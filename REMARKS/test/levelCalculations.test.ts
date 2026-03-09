/**
 * Test file for exponential XP progression calculations
 * Formula: XP for level N = 100 × 2^(N-1)
 */

import {
  calculateLevel,
  getTotalXpForLevel,
  getXpForNextLevel,
  getProgressToNextLevel,
  getXpRemainingToNextLevel,
  didLevelUp
} from './levelCalculations';

console.log('=== Testing Exponential XP Progression ===\n');

// Test cases for calculateLevel
const levelTests = [
  { xp: 0, expectedLevel: 1, description: '0 XP should be Level 1' },
  { xp: 50, expectedLevel: 1, description: '50 XP should be Level 1' },
  { xp: 99, expectedLevel: 1, description: '99 XP should be Level 1' },
  { xp: 100, expectedLevel: 2, description: '100 XP should be Level 2' },
  { xp: 200, expectedLevel: 2, description: '200 XP should be Level 2' },
  { xp: 299, expectedLevel: 2, description: '299 XP should be Level 2' },
  { xp: 300, expectedLevel: 3, description: '300 XP should be Level 3 (100+200)' },
  { xp: 500, expectedLevel: 3, description: '500 XP should be Level 3' },
  { xp: 699, expectedLevel: 3, description: '699 XP should be Level 3' },
  { xp: 700, expectedLevel: 4, description: '700 XP should be Level 4 (100+200+400)' },
  { xp: 1000, expectedLevel: 4, description: '1000 XP should be Level 4' },
  { xp: 1499, expectedLevel: 4, description: '1499 XP should be Level 4' },
  { xp: 1500, expectedLevel: 5, description: '1500 XP should be Level 5 (100+200+400+800)' },
  { xp: 2000, expectedLevel: 5, description: '2000 XP should be Level 5' },
  { xp: 3100, expectedLevel: 6, description: '3100 XP should be Level 6 (1500+1600)' },
];

console.log('Testing calculateLevel():');
let passedTests = 0;
levelTests.forEach(({ xp, expectedLevel, description }) => {
  const actualLevel = calculateLevel(xp);
  const passed = actualLevel === expectedLevel;
  if (passed) passedTests++;
  console.log(`${passed ? '✓' : '✗'} ${description}`);
  if (!passed) {
    console.log(`  Expected: ${expectedLevel}, Got: ${actualLevel}`);
  }
});
console.log(`Passed: ${passedTests}/${levelTests.length}\n`);

// Test cases for getTotalXpForLevel
const totalXpTests = [
  { level: 1, expectedXp: 0, description: 'Level 1 should require 0 total XP' },
  { level: 2, expectedXp: 100, description: 'Level 2 should require 100 total XP' },
  { level: 3, expectedXp: 300, description: 'Level 3 should require 300 total XP (100+200)' },
  { level: 4, expectedXp: 700, description: 'Level 4 should require 700 total XP (100+200+400)' },
  { level: 5, expectedXp: 1500, description: 'Level 5 should require 1500 total XP (100+200+400+800)' },
  { level: 6, expectedXp: 3100, description: 'Level 6 should require 3100 total XP (1500+1600)' },
];

console.log('Testing getTotalXpForLevel():');
passedTests = 0;
totalXpTests.forEach(({ level, expectedXp, description }) => {
  const actualXp = getTotalXpForLevel(level);
  const passed = actualXp === expectedXp;
  if (passed) passedTests++;
  console.log(`${passed ? '✓' : '✗'} ${description}`);
  if (!passed) {
    console.log(`  Expected: ${expectedXp}, Got: ${actualXp}`);
  }
});
console.log(`Passed: ${passedTests}/${totalXpTests.length}\n`);

// Test cases for getXpForNextLevel (incremental XP needed)
const xpForNextTests = [
  { xp: 0, expectedXp: 100, description: '0 XP: need 100 XP for Level 2' },
  { xp: 50, expectedXp: 100, description: '50 XP: need 100 XP for Level 2' },
  { xp: 100, expectedXp: 200, description: '100 XP (Level 2): need 200 XP for Level 3' },
  { xp: 250, expectedXp: 200, description: '250 XP (Level 2): need 200 XP for Level 3' },
  { xp: 300, expectedXp: 400, description: '300 XP (Level 3): need 400 XP for Level 4' },
  { xp: 700, expectedXp: 800, description: '700 XP (Level 4): need 800 XP for Level 5' },
  { xp: 1500, expectedXp: 1600, description: '1500 XP (Level 5): need 1600 XP for Level 6' },
];

console.log('Testing getXpForNextLevel():');
passedTests = 0;
xpForNextTests.forEach(({ xp, expectedXp, description }) => {
  const actualXp = getXpForNextLevel(xp);
  const passed = actualXp === expectedXp;
  if (passed) passedTests++;
  console.log(`${passed ? '✓' : '✗'} ${description}`);
  if (!passed) {
    console.log(`  Expected: ${expectedXp}, Got: ${actualXp}`);
  }
});
console.log(`Passed: ${passedTests}/${xpForNextTests.length}\n`);

// Test cases for getProgressToNextLevel
const progressTests = [
  { xp: 0, expectedProgress: 0, description: '0 XP: 0% progress to Level 2' },
  { xp: 50, expectedProgress: 50, description: '50 XP: 50% progress to Level 2' },
  { xp: 100, expectedProgress: 0, description: '100 XP (Level 2): 0% progress to Level 3' },
  { xp: 200, expectedProgress: 50, description: '200 XP (Level 2): 50% progress to Level 3' },
  { xp: 250, expectedProgress: 75, description: '250 XP (Level 2): 75% progress to Level 3' },
  { xp: 700, expectedProgress: 0, description: '700 XP (Level 4): 0% progress to Level 5' },
];

console.log('Testing getProgressToNextLevel():');
passedTests = 0;
progressTests.forEach(({ xp, expectedProgress, description }) => {
  const actualProgress = Math.round(getProgressToNextLevel(xp));
  const passed = actualProgress === expectedProgress;
  if (passed) passedTests++;
  console.log(`${passed ? '✓' : '✗'} ${description}`);
  if (!passed) {
    console.log(`  Expected: ${expectedProgress}%, Got: ${actualProgress}%`);
  }
});
console.log(`Passed: ${passedTests}/${progressTests.length}\n`);

// Test cases for getXpRemainingToNextLevel
const remainingTests = [
  { xp: 0, expectedRemaining: 100, description: '0 XP: 100 XP remaining to Level 2' },
  { xp: 50, expectedRemaining: 50, description: '50 XP: 50 XP remaining to Level 2' },
  { xp: 100, expectedRemaining: 200, description: '100 XP: 200 XP remaining to Level 3' },
  { xp: 250, expectedRemaining: 50, description: '250 XP: 50 XP remaining to Level 3' },
  { xp: 700, expectedRemaining: 800, description: '700 XP: 800 XP remaining to Level 5' },
];

console.log('Testing getXpRemainingToNextLevel():');
passedTests = 0;
remainingTests.forEach(({ xp, expectedRemaining, description }) => {
  const actualRemaining = getXpRemainingToNextLevel(xp);
  const passed = actualRemaining === expectedRemaining;
  if (passed) passedTests++;
  console.log(`${passed ? '✓' : '✗'} ${description}`);
  if (!passed) {
    console.log(`  Expected: ${expectedRemaining}, Got: ${actualRemaining}`);
  }
});
console.log(`Passed: ${passedTests}/${remainingTests.length}\n`);

// Test cases for didLevelUp
const levelUpTests = [
  { oldXp: 0, newXp: 50, expected: false, description: '0→50 XP: No level up' },
  { oldXp: 50, newXp: 100, expected: true, description: '50→100 XP: Level up to 2' },
  { oldXp: 250, newXp: 300, expected: true, description: '250→300 XP: Level up to 3' },
  { oldXp: 100, newXp: 200, expected: false, description: '100→200 XP: No level up (both Level 2)' },
  { oldXp: 699, newXp: 700, expected: true, description: '699→700 XP: Level up to 4' },
];

console.log('Testing didLevelUp():');
passedTests = 0;
levelUpTests.forEach(({ oldXp, newXp, expected, description }) => {
  const actual = didLevelUp(oldXp, newXp);
  const passed = actual === expected;
  if (passed) passedTests++;
  console.log(`${passed ? '✓' : '✗'} ${description}`);
  if (!passed) {
    console.log(`  Expected: ${expected}, Got: ${actual}`);
  }
});
console.log(`Passed: ${passedTests}/${levelUpTests.length}\n`);

console.log('=== All Tests Complete ===');
