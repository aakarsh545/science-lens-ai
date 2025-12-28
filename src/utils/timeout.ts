/**
 * Reusable timeout utility that wraps a Promise with a timeout
 * @param promise The promise to wrap
 * @param timeoutMs Timeout in milliseconds
 * @param errorMessage Optional error message
 * @returns A promise that rejects if timeout is reached
 */
export function withTimeout<T>(
  promise: Promise<T>,
  timeoutMs: number,
  errorMessage: string = "Operation timed out"
): Promise<T> {
  const timeoutPromise = new Promise<never>((_, reject) => {
    setTimeout(() => {
      reject(new Error(errorMessage));
    }, timeoutMs);
  });

  return Promise.race([promise, timeoutPromise]);
}

/**
 * Creates a timeout promise that rejects after specified milliseconds
 * @param timeoutMs Timeout in milliseconds
 * @param errorMessage Optional error message
 * @returns A promise that rejects after the timeout
 */
export function createTimeout(
  timeoutMs: number,
  errorMessage: string = "Operation timed out"
): Promise<never> {
  return new Promise((_, reject) => {
    setTimeout(() => {
      reject(new Error(errorMessage));
    }, timeoutMs);
  });
}

/**
 * Wraps an async function with a timeout
 * @param fn The async function to wrap
 * @param timeoutMs Timeout in milliseconds
 * @returns A wrapped function that will timeout if execution takes too long
 */
export function withTimeoutFn<T extends (...args: any[]) => Promise<any>>(
  fn: T,
  timeoutMs: number
): T {
  return (async (...args: Parameters<T>) => {
    return withTimeout(fn(...args), timeoutMs);
  }) as T;
}
