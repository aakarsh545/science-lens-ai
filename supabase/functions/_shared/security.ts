/**
 * Shared Security Utilities for Edge Functions
 *
 * Provides:
 * - CORS validation with origin allowlist
 * - Rate limiting checking
 * - Abuse logging
 * - Fail-closed error handling
 */

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

// ============================================================================
// CORS Configuration
// ============================================================================

const ALLOWED_ORIGINS = [
  // Production domains - UPDATE THESE WITH YOUR ACTUAL DOMAINS
  "https://yourdomain.com",
  "https://www.yourdomain.com",

  // Local development
  "http://localhost:5173",
  "http://localhost:3000",
  "http://localhost:8080",
  "http://localhost:8081",
  "http://127.0.0.1:5173",
  "http://127.0.0.1:3000",
  "http://127.0.0.1:8080",
  "http://127.0.0.1:8081",

  // Preview deployments - UPDATE WITH YOUR PREVIEW DOMAIN PATTERN
  // Example: "https://*.vercel.app",
  // Example: "https://*.netlify.app",
];

/**
 * Validates request origin against allowlist
 * @param origin - Origin header from request
 * @returns boolean indicating if origin is allowed
 */
export function isOriginAllowed(origin: string | null): boolean {
  if (!origin) return false;

  // Check exact matches
  if (ALLOWED_ORIGINS.includes(origin)) {
    return true;
  }

  // Check wildcard patterns (for preview deployments)
  for (const allowed of ALLOWED_ORIGINS) {
    if (allowed.includes("*")) {
      const pattern = allowed.replace(/\*/g, ".*");
      const regex = new RegExp(`^${pattern}$`);
      if (regex.test(origin)) {
        return true;
      }
    }
  }

  return false;
}

/**
 * Creates CORS headers with origin validation
 * @param origin - Origin header from request
 * @returns CORS headers object
 */
export function getCorsHeaders(origin: string | null): Record<string, string> {
  if (isOriginAllowed(origin)) {
    return {
      "Access-Control-Allow-Origin": origin!,
      "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
      "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE",
    };
  }

  // Return restrictive headers for unauthorized origins
  return {};
}

/**
 * Handles OPTIONS preflight requests with CORS validation
 * @param req - Request object
 * @returns Response for OPTIONS request
 */
export function handleOptions(req: Request): Response | null {
  if (req.method === "OPTIONS") {
    const origin = req.headers.get("Origin");
    const corsHeaders = getCorsHeaders(origin);

    if (Object.keys(corsHeaders).length === 0) {
      // Origin not allowed
      return new Response(null, { status: 403 });
    }

    return new Response(null, { headers: corsHeaders });
  }
  return null;
}

/**
 * Validates request origin and returns error response if unauthorized
 * @param req - Request object
 * @returns Response if origin invalid, null if valid
 */
export function validateOrigin(req: Request): Response | null {
  const origin = req.headers.get("Origin");

  // Allow requests without Origin header (non-browser requests)
  if (!origin) {
    return null;
  }

  if (!isOriginAllowed(origin)) {
    return new Response(
      JSON.stringify({ error: "Forbidden" }),
      {
        status: 403,
        headers: {
          "Content-Type": "application/json",
          ...getCorsHeaders(origin),
        },
      }
    );
  }

  return null;
}

// ============================================================================
// Rate Limiting
// ============================================================================

interface RateLimitResult {
  allowed: boolean;
  remaining: number;
  resetAt: Date;
  error?: string;
}

/**
 * Checks rate limit for a user/endpoint combination
 * @param supabase - Supabase client
 * @param userId - User ID
 * @param endpoint - Endpoint identifier
 * @param limit - Maximum requests allowed in window
 * @param windowSeconds - Time window in seconds
 * @returns RateLimitResult with allowed status
 */
export async function checkRateLimit(
  supabase: any,
  userId: string,
  endpoint: string,
  limit: number,
  windowSeconds: number
): Promise<RateLimitResult> {
  try {
    // Call the rate_limit RPC function
    const { data, error } = await supabase.rpc("check_rate_limit", {
      p_user_id: userId,
      p_endpoint: endpoint,
      p_limit: limit,
      p_window_seconds: windowSeconds,
    });

    if (error) {
      console.error("Rate limit check error:", error);
      // Fail closed - deny on error
      return {
        allowed: false,
        remaining: 0,
        resetAt: new Date(Date.now() + windowSeconds * 1000),
        error: "Rate limit check failed",
      };
    }

    return {
      allowed: data.allowed,
      remaining: data.remaining,
      resetAt: new Date(data.reset_at),
    };
  } catch (error) {
    console.error("Rate limit exception:", error);
    // Fail closed - deny on error
    return {
      allowed: false,
      remaining: 0,
      resetAt: new Date(Date.now() + windowSeconds * 1000),
      error: "Rate limit check failed",
    };
  }
}

/**
 * Creates a 429 Too Many Requests response
 * @param resetAt - When the rate limit resets
 * @param corsHeaders - CORS headers
 * @returns Response with 429 status
 */
export function rateLimitResponse(resetAt: Date, corsHeaders: Record<string, string>): Response {
  const retryAfter = Math.ceil((resetAt.getTime() - Date.now()) / 1000);

  return new Response(
    JSON.stringify({
      error: "Too many requests",
      message: `Rate limit exceeded. Try again in ${retryAfter} seconds.`,
    }),
    {
      status: 429,
      headers: {
        ...corsHeaders,
        "Content-Type": "application/json",
        "Retry-After": retryAfter.toString(),
      },
    }
  );
}

// ============================================================================
// Abuse Logging
// ============================================================================

export type AbuseEventType =
  | "auth_failure"
  | "auth_success"
  | "rate_limit"
  | "suspicious_activity"
  | "admin_escalation"
  | "privilege_escalation_attempt"
  | "perfect_score"
  | "rapid_requests"
  | "unusual_user_agent";

interface AbuseLogEntry {
  user_id?: string;
  event_type: AbuseEventType;
  endpoint: string;
  details: Record<string, any>;
  severity?: "low" | "medium" | "high" | "critical";
}

/**
 * Logs an abuse/security event to the abuse_log table
 * @param supabase - Supabase client
 * @param entry - Abuse log entry
 */
export async function logAbuseEvent(
  supabase: any,
  entry: AbuseLogEntry
): Promise<void> {
  try {
    await supabase.from("abuse_log").insert({
      user_id: entry.user_id,
      event_type: entry.event_type,
      endpoint: entry.endpoint,
      details: entry.details,
      severity: entry.severity || "medium",
      created_at: new Date().toISOString(),
    });
  } catch (error) {
    // Don't throw - logging failures shouldn't break the request
    console.error("Failed to log abuse event:", error);
  }
}

/**
 * Logs authentication failure
 */
export async function logAuthFailure(
  supabase: any,
  userId: string | undefined,
  endpoint: string,
  reason: string
): Promise<void> {
  await logAbuseEvent(supabase, {
    user_id: userId,
    event_type: "auth_failure",
    endpoint,
    details: { reason },
    severity: "medium",
  });
}

/**
 * Logs rate limit violation
 */
export async function logRateLimitViolation(
  supabase: any,
  userId: string,
  endpoint: string,
  limit: number,
  windowSeconds: number
): Promise<void> {
  await logAbuseEvent(supabase, {
    user_id: userId,
    event_type: "rate_limit",
    endpoint,
    details: {
      limit,
      window_seconds: windowSeconds,
      message: `Exceeded ${limit} requests per ${windowSeconds} seconds`,
    },
    severity: "medium",
  });
}

/**
 * Logs suspicious activity
 */
export async function logSuspiciousActivity(
  supabase: any,
  userId: string,
  endpoint: string,
  activity: string,
  details: Record<string, any> = {}
): Promise<void> {
  await logAbuseEvent(supabase, {
    user_id: userId,
    event_type: "suspicious_activity",
    endpoint,
    details: { activity, ...details },
    severity: "high",
  });
}

/**
 * Logs privilege escalation attempt
 */
export async function logPrivilegeEscalationAttempt(
  supabase: any,
  userId: string,
  endpoint: string,
  targetUserId: string,
  success: boolean
): Promise<void> {
  await logAbuseEvent(supabase, {
    user_id: userId,
    event_type: success ? "admin_escalation" : "privilege_escalation_attempt",
    endpoint,
    details: {
      target_user_id: targetUserId,
      success,
    },
    severity: success ? "medium" : "high",
  });
}

/**
 * Checks for suspicious patterns and logs them
 */
export async function checkSuspiciousPatterns(
  supabase: any,
  userId: string,
  endpoint: string,
  userAgent: string | null
): Promise<void> {
  // Check for unusual user agents
  if (userAgent) {
    const suspiciousPatterns = [
      /bot/i,
      /crawler/i,
      /spider/i,
      /scraper/i,
      /curl/i,
      /wget/i,
    ];

    for (const pattern of suspiciousPatterns) {
      if (pattern.test(userAgent)) {
        await logSuspiciousActivity(
          supabase,
          userId,
          endpoint,
          "Unusual user agent detected",
          { user_agent: userAgent }
        );
        break;
      }
    }
  }
}

// ============================================================================
// Error Handling (Fail-Closed)
// ============================================================================

/**
 * Creates a standardized error response (fail-closed)
 * @param message - Generic error message (don't expose internals)
 * @param status - HTTP status code
 * @param corsHeaders - CORS headers
 * @returns Response object
 */
export function createErrorResponse(
  message: string,
  status: number,
  corsHeaders: Record<string, string>
): Response {
  // Log error server-side
  console.error(`[${status}] ${message}`, { timestamp: new Date().toISOString() });

  // Return generic error to client (don't expose internals)
  return new Response(
    JSON.stringify({
      error: message,
    }),
    {
      status,
      headers: {
        ...corsHeaders,
        "Content-Type": "application/json",
      },
    }
  );
}

/**
 * Handles database errors (fail-closed)
 */
export function handleDatabaseError(error: any, corsHeaders: Record<string, string>): Response {
  console.error("Database error:", {
    message: error.message,
    code: error.code,
    details: error.details,
    timestamp: new Date().toISOString(),
  });

  // Return generic error to client
  return createErrorResponse(
    "An error occurred while processing your request",
    500,
    corsHeaders
  );
}

/**
 * Handles authentication errors (fail-closed)
 */
export function handleAuthError(
  corsHeaders: Record<string, string>,
  reason: string = "Authentication required"
): Response {
  return createErrorResponse(reason, 401, corsHeaders);
}

/**
 * Handles authorization errors (fail-closed)
 */
export function handleAuthzError(
  corsHeaders: Record<string, string>,
  reason: string = "Insufficient permissions"
): Response {
  return createErrorResponse(reason, 403, corsHeaders);
}

// ============================================================================
// Utility Functions
// ============================================================================

/**
 * Extracts user ID from JWT token
 * @param authHeader - Authorization header value
 * @returns User ID or null
 */
export function extractUserId(authHeader: string | null): string | null {
  if (!authHeader) return null;

  const token = authHeader.replace("Bearer ", "");
  const jwtParts = token.split(".");

  if (jwtParts.length !== 3) return null;

  try {
    const jwtPayload = JSON.parse(atob(jwtParts[1]));
    return jwtPayload.sub || null;
  } catch {
    return null;
  }
}

/**
 * Gets client IP address from request
 * @param req - Request object
 * @returns IP address or null
 */
export function getClientIp(req: Request): string | null {
  // Check various headers for IP
  const headers = [
    "CF-Connecting-IP", // Cloudflare
    "X-Forwarded-For",
    "X-Real-IP",
    "X-Client-IP",
  ];

  for (const header of headers) {
    const ip = req.headers.get(header);
    if (ip) {
      // X-Forwarded-For may contain multiple IPs
      return ip.split(",")[0].trim();
    }
  }

  return null;
}
