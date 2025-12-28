#!/usr/bin/env node

const supabaseUrl = 'https://kljndbehjwfdyewgxgaw.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtsam5kYmVoandmZHlld2d4Z2F3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjY1NTk1MTksImV4cCI6MjA4MjEzNTUxOX0.3R0SkWwe-uExB1SCOwyb1T3DThBWUYW-1MyAPkhJb8o';

async function countLessons() {
  try {
    // Get all lessons
    const response = await fetch(`${supabaseUrl}/rest/v1/lessons?select=*`, {
      headers: {
        'apikey': supabaseKey,
        'Authorization': `Bearer ${supabaseKey}`
      }
    });

    const data = await response.json();
    console.log(`Total lessons in database: ${data.length}`);

    // Get courses with lesson counts
    const coursesResponse = await fetch(`${supabaseUrl}/rest/v1/courses?select=id,title,slug,lessons(id)`, {
      headers: {
        'apikey': supabaseKey,
        'Authorization': `Bearer ${supabaseKey}`
      }
    });

    const courses = await coursesResponse.json();

    // Count lessons per course
    const lessonCounts = {};
    data.forEach(lesson => {
      if (!lessonCounts[lesson.course_id]) {
        lessonCounts[lesson.course_id] = 0;
      }
      lessonCounts[lesson.course_id]++;
    });

    console.log('\nLessons per course:');
    courses.forEach(course => {
      const count = lessonCounts[course.id] || 0;
      console.log(`  - ${course.title}: ${count} lessons`);
    });

  } catch (error) {
    console.error('Error:', error);
  }
}

countLessons();
