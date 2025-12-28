/**
 * Utility helper functions
 * Common reusable utilities across the application
 */

import { TERMINOLOGY } from './constants';

/**
 * Creates a timeout promise that rejects after specified milliseconds
 * @param ms - Milliseconds to wait before timing out
 * @returns Promise that rejects after timeout
 */
export function createTimeout(ms: number): Promise<never> {
  return new Promise((_, reject) => {
    setTimeout(() => reject(new Error(`Request timeout after ${ms}ms`)), ms);
  });
}

/**
 * Wraps a promise with a timeout
 * @param promise - The promise to wrap
 * @param timeoutMs - Timeout in milliseconds
 * @returns The promise with timeout applied
 */
export async function withTimeout<T>(
  promise: Promise<T>,
  timeoutMs: number
): Promise<T> {
  return Promise.race([
    promise,
    createTimeout(timeoutMs),
  ]);
}

/**
 * Formats a date to a localized time string
 * @param dateString - ISO date string
 * @returns Formatted time string
 */
export function formatTime(dateString: string): string {
  return new Date(dateString).toLocaleTimeString();
}

/**
 * Formats a date to a localized date and time string
 * @param dateString - ISO date string
 * @returns Formatted date and time string
 */
export function formatDateTime(dateString: string): string {
  return new Date(dateString).toLocaleString();
}

/**
 * Safely accesses nested object properties
 * @param obj - The object to access
 * @param path - Dot-separated path to the property
 * @param defaultValue - Default value if property doesn't exist
 * @returns The property value or default
 */
export function safeGet<T>(
  obj: unknown,
  path: string,
  defaultValue: T
): T {
  const keys = path.split('.');
  let result: unknown = obj;

  for (const key of keys) {
    if (result && typeof result === 'object' && key in result) {
      result = (result as Record<string, unknown>)[key];
    } else {
      return defaultValue;
    }
  }

  return result as T ?? defaultValue;
}

/**
 * Checks if a value is defined (not null or undefined)
 * @param value - Value to check
 * @returns True if value is defined
 */
export function isDefined<T>(value: T | null | undefined): value is T {
  return value !== null && value !== undefined;
}

/**
 * Type guard to check if value has a specific property
 * @param obj - Object to check
 * @param prop - Property name to check for
 * @returns True if object has property
 */
export function hasProperty<T extends keyof never>(
  obj: unknown,
  prop: string
): obj is { [K in T]: unknown } {
  return typeof obj === 'object' && obj !== null && prop in obj;
}

/**
 * Standardized XP label for consistency
 */
export const XP_LABEL = TERMINOLOGY.XP;

/**
 * Standardized credits label for consistency
 */
export const CREDITS_LABEL = TERMINOLOGY.CREDITS;
