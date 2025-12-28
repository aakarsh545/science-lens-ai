import { clsx, type ClassValue } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

/**
 * Get consistent difficulty colors for badges and UI elements
 * @param difficulty - The difficulty level (beginner, intermediate, advanced)
 * @returns Object containing className for styling
 */
export function getDifficultyColors(difficulty: string) {
  switch (difficulty.toLowerCase()) {
    case 'beginner':
      return 'bg-green-500/10 text-green-500 border-green-500/20 dark:text-green-400 dark:border-green-400/30';
    case 'intermediate':
      return 'bg-blue-500/10 text-blue-500 border-blue-500/20 dark:text-blue-400 dark:border-blue-400/30';
    case 'advanced':
      return 'bg-purple-500/10 text-purple-500 border-purple-500/20 dark:text-purple-400 dark:border-purple-400/30';
    default:
      return 'bg-gray-500/10 text-gray-500 border-gray-500/20 dark:text-gray-400 dark:border-gray-400/30';
  }
}

/**
 * Get difficulty icon/emoji
 * @param difficulty - The difficulty level
 * @returns Emoji for the difficulty level
 */
export function getDifficultyIcon(difficulty: string): string {
  switch (difficulty.toLowerCase()) {
    case 'beginner':
      return '🔰';
    case 'intermediate':
      return '🔷';
    case 'advanced':
      return '🔶';
    default:
      return '📚';
  }
}

/**
 * Get difficulty badge text
 * @param difficulty - The difficulty level
 * @returns Formatted text with icon
 */
export function getDifficultyLabel(difficulty: string): string {
  const icon = getDifficultyIcon(difficulty);
  const label = difficulty.charAt(0).toUpperCase() + difficulty.slice(1);
  return `${icon} ${label}`;
}
