/**
 * Error Handling Utility
 *
 * Provides centralized error handling that:
 * - Logs detailed errors to console/server for debugging
 * - Returns user-friendly generic messages to clients
 * - Hides sensitive internal details (stack traces, DB errors, etc.)
 */

/**
 * User-friendly error messages mapping
 * Internal errors are mapped to generic, safe messages for users
 */
const USER_FRIENDLY_MESSAGES: Record<string, string> = {
  // Authentication errors
  'Invalid login credentials': 'Invalid email or password. Please try again.',
  'Email not confirmed': 'Please verify your email address before signing in.',
  'User not found': 'Account not found. Please sign up.',
  'Invalid token': 'Your session has expired. Please sign in again.',
  'No authorization header': 'Authentication required. Please sign in.',
  'Unauthorized': 'You need to sign in to access this feature.',

  // Database errors (generic messages)
  'duplicate': 'This record already exists.',
  'unique': 'This value is already taken.',
  'foreign key': 'Related record not found.',
  'constraint': 'Unable to complete this operation. Please try again.',

  // Network/API errors
  'Failed to fetch': 'Network error. Please check your connection.',
  'Network request failed': 'Network error. Please check your connection.',
  'timeout': 'Request timed out. Please try again.',
  'rate limit': 'Too many requests. Please wait a moment.',
  '429': 'Too many requests. Please wait a moment.',

  // Credit errors
  'Insufficient credits': 'You do not have enough credits for this action.',
  'credits_exhausted': 'No credits remaining. Credits refresh daily.',

  // Validation errors
  'Validation error': 'Please check your input and try again.',
  'Invalid input': 'Please check your input and try again.',
  'Required': 'This field is required.',

  // AI errors
  'AI provider error': 'Unable to get AI response. Please try again.',
  'OpenAI API key not configured': 'Service temporarily unavailable.',
  'AI fallback failed': 'Service temporarily unavailable. Please try again later.',

  // Generic fallback
  'default': 'An error occurred. Please try again.',
};

/**
 * Error types for classification
 */
export type ErrorType =
  | 'auth'
  | 'database'
  | 'network'
  | 'validation'
  | 'credits'
  | 'ai'
  | 'unknown';

/**
 * Gets a user-friendly error message based on the error
 * Logs detailed error to console for debugging
 *
 * @param error - The error object or message
 * @param context - Additional context about where the error occurred
 * @returns User-friendly error message (never exposes internals)
 */
export function getUserFriendlyMessage(
  error: Error | string | unknown,
  context?: string
): string {
  // Extract error message
  let errorMessage: string;
  let errorDetails: unknown = error;

  if (error instanceof Error) {
    errorMessage = error.message;
    errorDetails = {
      message: error.message,
      stack: error.stack,
      name: error.name,
    };
  } else if (typeof error === 'string') {
    errorMessage = error;
  } else {
    errorMessage = 'Unknown error';
  }

  // Log detailed error to console (server-side only, not exposed to client)
  console.error(`[Error${context ? ` - ${context}` : ''}]`, {
    message: errorMessage,
    details: errorDetails,
    timestamp: new Date().toISOString(),
  });

  // Check for specific error patterns and return user-friendly message
  const lowerError = errorMessage.toLowerCase();

  // Authentication errors
  if (
    lowerError.includes('invalid login') ||
    lowerError.includes('invalid credentials') ||
    lowerError.includes('auth')
  ) {
    return USER_FRIENDLY_MESSAGES['Invalid login credentials'];
  }

  if (lowerError.includes('email not confirmed') || lowerError.includes('verify email')) {
    return USER_FRIENDLY_MESSAGES['Email not confirmed'];
  }

  if (lowerError.includes('user not found')) {
    return USER_FRIENDLY_MESSAGES['User not found'];
  }

  if (lowerError.includes('token') || lowerError.includes('unauthorized') || lowerError.includes('authorization')) {
    return USER_FRIENDLY_MESSAGES['Unauthorized'];
  }

  // Database errors
  if (lowerError.includes('duplicate') || lowerError.includes('already exists')) {
    return USER_FRIENDLY_MESSAGES['duplicate'];
  }

  if (lowerError.includes('unique') || lowerError.includes('constraint')) {
    return USER_FRIENDLY_MESSAGES['unique'];
  }

  if (lowerError.includes('foreign key') || lowerError.includes('relation')) {
    return USER_FRIENDLY_MESSAGES['foreign key'];
  }

  // Network errors
  if (
    lowerError.includes('network') ||
    lowerError.includes('fetch') ||
    lowerError.includes('connection')
  ) {
    return USER_FRIENDLY_MESSAGES['Failed to fetch'];
  }

  if (lowerError.includes('timeout') || lowerError.includes('timed out')) {
    return USER_FRIENDLY_MESSAGES['timeout'];
  }

  if (lowerError.includes('rate limit') || lowerError.includes('429') || lowerError.includes('too many requests')) {
    return USER_FRIENDLY_MESSAGES['rate limit'];
  }

  // Credit errors
  if (
    lowerError.includes('credit') ||
    lowerError.includes('insufficient')
  ) {
    return USER_FRIENDLY_MESSAGES['Insufficient credits'];
  }

  // AI errors
  if (
    lowerError.includes('ai') ||
    lowerError.includes('openai') ||
    lowerError.includes('llm')
  ) {
    return USER_FRIENDLY_MESSAGES['AI provider error'];
  }

  // Validation errors
  if (
    lowerError.includes('validation') ||
    lowerError.includes('invalid') ||
    lowerError.includes('required')
  ) {
    return USER_FRIENDLY_MESSAGES['Validation error'];
  }

  // Default fallback (generic message, no details exposed)
  return USER_FRIENDLY_MESSAGES['default'];
}

/**
 * Classifies an error into a type for structured handling
 *
 * @param error - The error object or message
 * @returns Error type classification
 */
export function classifyError(error: Error | string | unknown): ErrorType {
  let errorMessage: string;

  if (error instanceof Error) {
    errorMessage = error.message;
  } else if (typeof error === 'string') {
    errorMessage = error;
  } else {
    return 'unknown';
  }

  const lowerError = errorMessage.toLowerCase();

  // Classification logic
  if (
    lowerError.includes('auth') ||
    lowerError.includes('login') ||
    lowerError.includes('token') ||
    lowerError.includes('unauthorized') ||
    lowerError.includes('credentials')
  ) {
    return 'auth';
  }

  if (
    lowerError.includes('duplicate') ||
    lowerError.includes('constraint') ||
    lowerError.includes('database') ||
    lowerError.includes('relation') ||
    lowerError.includes('foreign key')
  ) {
    return 'database';
  }

  if (
    lowerError.includes('network') ||
    lowerError.includes('fetch') ||
    lowerError.includes('timeout') ||
    lowerError.includes('connection')
  ) {
    return 'network';
  }

  if (
    lowerError.includes('validation') ||
    lowerError.includes('invalid') ||
    lowerError.includes('required')
  ) {
    return 'validation';
  }

  if (lowerError.includes('credit')) {
    return 'credits';
  }

  if (
    lowerError.includes('ai') ||
    lowerError.includes('openai') ||
    lowerError.includes('llm')
  ) {
    return 'ai';
  }

  return 'unknown';
}

/**
 * Handles errors in a consistent way across the app
 * Use this in try-catch blocks to ensure proper error handling
 *
 * @param error - The error that occurred
 * @param context - Where the error occurred (for logging)
 * @param onError - Optional callback for custom error handling
 * @returns User-friendly error message
 */
export function handleError(
  error: Error | string | unknown,
  context?: string,
  onError?: (message: string, errorType: ErrorType) => void
): string {
  const userMessage = getUserFriendlyMessage(error, context);
  const errorType = classifyError(error);

  // Call custom error handler if provided
  if (onError) {
    onError(userMessage, errorType);
  }

  return userMessage;
}

/**
 * Creates a standardized error response for Edge Functions
 * Maps internal errors to generic client messages
 *
 * @param error - The error that occurred
 * @param corsHeaders - CORS headers for the response
 * @param context - Optional context for logging
 * @returns Response object with generic error message
 */
export function createErrorResponse(
  error: Error | string | unknown,
  corsHeaders: Record<string, string>,
  context?: string
): Response {
  const userMessage = getUserFriendlyMessage(error, context);

  console.error(`[Edge Function Error${context ? ` - ${context}` : ''}]`, {
    userMessage,
    originalError: error instanceof Error ? error.message : error,
    timestamp: new Date().toISOString(),
  });

  return new Response(
    JSON.stringify({
      error: userMessage,
    }),
    {
      status: 500,
      headers: {
        ...corsHeaders,
        'Content-Type': 'application/json',
      },
    }
  );
}

/**
 * Wraps an async function with error handling
 * Returns generic errors to clients while logging details server-side
 *
 * @param fn - The async function to wrap
 * @param context - Context for error logging
 * @returns Wrapped function with error handling
 */
export function withErrorHandling<T extends (...args: any[]) => Promise<any>>(
  fn: T,
  context?: string
): T {
  return (async (...args: Parameters<T>) => {
    try {
      return await fn(...args);
    } catch (error) {
      const userMessage = getUserFriendlyMessage(error, context);
      const errorType = classifyError(error);

      // Log detailed error
      console.error(`[Error in ${context || fn.name}]`, {
        userMessage,
        errorType,
        details: error,
        timestamp: new Date().toISOString(),
      });

      // Throw user-friendly error
      throw new Error(userMessage);
    }
  }) as T;
}
