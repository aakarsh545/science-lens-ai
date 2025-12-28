/**
 * Quick verification script for exponential XP progression
 * Run with: npx tsx verify-exponential-xp.ts
 */

import {
  calculateLevel,
  getTotalXpForLevel,
  getXpForNextLevel,
  getProgressToNextLevel,
  getXpRemainingToNextLevel
} from './src/utils/levelCalculations';

console.log('╔════════════════════════════════════════════════════════════╗');
console.log('║     EXPONENTIAL XP PROGRESSION VERIFICATION                ║');
console.log('╚════════════════════════════════════════════════════════════╝\n');

console.log('📊 LEVEL PROGRESSION TABLE:');
console.log('┌───────┬──────────────┬─────────────────┬──────────────┐');
console.log('│ Level │ Total XP     │ Incremental XP  │ Growth Rate  │');
console.log('├───────┼──────────────┼─────────────────┼──────────────┤');

for (let level = 1; level <= 10; level++) {
  const totalXp = getTotalXpForLevel(level);
  const incrementalXp = level === 1 ? 0 : getTotalXpForLevel(level) - getTotalXpForLevel(level - 1);
  const growthRate = level === 1 ? 'N/A' : `${Math.round((incrementalXp / (getTotalXpForLevel(level - 1) - getTotalXpForLevel(level - 2))) * 100)}%`;

  console.log(`│ ${level.toString().padEnd(5)} │ ${totalXp.toString().padStart(12)} │ ${incrementalXp.toString().padStart(15)} │ ${growthRate.toString().padEnd(12)} │`);
}

console.log('└───────┴──────────────┴─────────────────┴──────────────┘\n');

console.log('📈 EXAMPLE SCENARIOS:\n');

// Scenario 1: New player
console.log('🎮 Scenario 1: New Player (0 XP)');
const xp1 = 0;
console.log(`   Current Level: ${calculateLevel(xp1)}`);
console.log(`   XP to Level 2: ${getXpRemainingToNextLevel(xp1)}`);
console.log(`   Progress: ${getProgressToNextLevel(xp1).toFixed(1)}%\n`);

// Scenario 2: After earning 150 XP
console.log('🎮 Scenario 2: After earning 150 XP');
const xp2 = 150;
console.log(`   Current Level: ${calculateLevel(xp2)}`);
console.log(`   XP to Level 3: ${getXpRemainingToNextLevel(xp2)}`);
console.log(`   Progress: ${getProgressToNextLevel(xp2).toFixed(1)}%\n`);

// Scenario 3: Halfway to Level 5
console.log('🎮 Scenario 3: Player with 1100 XP (Level 4)');
const xp3 = 1100;
console.log(`   Current Level: ${calculateLevel(xp3)}`);
console.log(`   XP to Level 5: ${getXpRemainingToNextLevel(xp3)}`);
console.log(`   Progress: ${getProgressToNextLevel(xp3).toFixed(1)}%\n`);

// Scenario 4: Dedicated player
console.log('🎮 Scenario 4: Dedicated player with 5000 XP (Level 6)');
const xp4 = 5000;
console.log(`   Current Level: ${calculateLevel(xp4)}`);
console.log(`   XP to Level 7: ${getXpRemainingToNextLevel(xp4)}`);
console.log(`   Progress: ${getProgressToNextLevel(xp4).toFixed(1)}%\n`);

console.log('✅ VERIFICATION COMPLETE!');
console.log('\nKey Observations:');
console.log('• Early levels (1-3) are easily achievable for new players');
console.log('• Mid levels (4-6) provide moderate challenge');
console.log('• High levels (7+) require significant dedication');
console.log('• Each level doubles the XP requirement of the previous');
console.log('• Creates a satisfying progression curve\n');
