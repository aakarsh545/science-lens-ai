/**
 * Level calculation utilities for gamification
 * Formula: level n threshold = n * 100 XP
 */

export const calculateLevel = (xp: number): number => {
  return Math.floor(xp / 100) + 1;
};

export const getXpForLevel = (level: number): number => {
  return level * 100;
};

export const getXpForNextLevel = (currentXp: number): number => {
  const currentLevel = calculateLevel(currentXp);
  return getXpForLevel(currentLevel);
};

export const getProgressToNextLevel = (currentXp: number): number => {
  const currentLevel = calculateLevel(currentXp);
  const xpForCurrentLevel = getXpForLevel(currentLevel - 1);
  const xpForNextLevel = getXpForLevel(currentLevel);
  const xpInCurrentLevel = currentXp - xpForCurrentLevel;
  const xpNeededForLevel = xpForNextLevel - xpForCurrentLevel;
  return (xpInCurrentLevel / xpNeededForLevel) * 100;
};

export const didLevelUp = (oldXp: number, newXp: number): boolean => {
  return calculateLevel(oldXp) < calculateLevel(newXp);
};
