/**
 * User-scoped localStorage utility
 * Prevents data leakage between different user accounts on the same browser
 */

import { User } from "@supabase/supabase-js";

/**
 * Get user-scoped localStorage key
 */
export function getUserKey(key: string, user: User | null): string {
  return user ? `${key}_${user.id}` : key;
}

/**
 * Get user-scoped localStorage key by userId (without User object)
 */
export function getUserKeyById(key: string, userId: string): string {
  return `${key}_${userId}`;
}

/**
 * Get item from user-scoped localStorage
 */
export function getUserItem(key: string, user: User | null): string | null {
  const userKey = getUserKey(key, user);
  return localStorage.getItem(userKey);
}

/**
 * Set item in user-scoped localStorage
 */
export function setUserItem(key: string, value: string, user: User | null): void {
  const userKey = getUserKey(key, user);
  localStorage.setItem(userKey, value);
}

/**
 * Remove item from user-scoped localStorage
 */
export function removeUserItem(key: string, user: User | null): void {
  const userKey = getUserKey(key, user);
  localStorage.removeItem(userKey);
}

/**
 * Clear ALL user-specific data from localStorage
 * Call this on signOut to prevent data leakage between accounts
 */
export function clearUserData(user: User | null): void {
  if (!user) return;

  // List of user-scoped localStorage keys to clear
  const userKeys = [
    'theme',           // Light/dark mode preference
    // Add more keys here as needed
  ];

  userKeys.forEach(key => {
    removeUserItem(key, user);
  });

  // Also clear any old-format generic keys (migration)
  localStorage.removeItem('theme');

  console.log(`[userStorage] Cleared data for user ${user.id}`);
}

/**
 * Clear ALL user-specific data from localStorage by userId
 * Alternative to clearUserData when you only have userId
 */
export function clearUserDataById(userId: string): void {
  if (!userId) return;

  // List of user-scoped localStorage keys to clear
  const userKeys = [
    'theme',           // Light/dark mode preference
    // Add more keys here as needed
  ];

  userKeys.forEach(key => {
    const userKey = getUserKeyById(key, userId);
    localStorage.removeItem(userKey);
  });

  // Also clear any old-format generic keys (migration)
  localStorage.removeItem('theme');

  console.log(`[userStorage] Cleared data for user ${userId}`);
}

/**
 * Migrate generic localStorage keys to user-scoped keys
 * Call this on signIn if user has old data
 */
export function migrateUserData(user: User | null): void {
  if (!user) return;

  const keysToMigrate = ['theme'];

  keysToMigrate.forEach(key => {
    const genericValue = localStorage.getItem(key);
    if (genericValue) {
      // Migrate to user-scoped key
      setUserItem(key, genericValue, user);
      // Remove generic key
      localStorage.removeItem(key);
      console.log(`[userStorage] Migrated ${key} to user-scoped for user ${user.id}`);
    }
  });
}
