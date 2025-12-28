/**
 * Application-wide constants
 * Centralizes magic numbers and configuration values
 */

// Timeout values (in milliseconds)
export const TIMEOUT_VALUES = {
  INITIAL_REQUEST: 30000,      // 30 seconds for initial request
  NO_DATA_RECEIVED: 20000,     // 20 seconds without any data
  DEFAULT_TIMEOUT: 10000,      // 10 seconds default
} as const;

// Limit constants
export const LIMITS = {
  MAX_MESSAGE_LENGTH: 2000,    // Maximum characters for chat messages
  MIN_QUIZ_QUESTIONS: 2,       // Minimum quiz questions to complete
  DEFAULT_QUIZ_COUNT: 2,       // Default number of quizzes required
} as const;

// Terminology constants for consistency
export const TERMINOLOGY = {
  XP: 'XP',                    // Experience points - always use "XP"
  CREDITS: 'credits',          // Credits - always use "credits"
} as const;

// API endpoints
export const API_ENDPOINTS = {
  CHAT: '/functions/v1/ask',
  AI_HINT: '/functions/v1/ai-hint',
  LESSONS: '/functions/v1/lessons',
  COURSES: '/functions/v1/courses',
  CHALLENGES: '/functions/v1/challenges',
} as const;

// Achievement thresholds
export const ACHIEVEMENT_THRESHOLDS = {
  FIRST_QUESTION: 1,
  CURIOUS_MIND: 10,
  KNOWLEDGE_SEEKER: 50,
} as const;
