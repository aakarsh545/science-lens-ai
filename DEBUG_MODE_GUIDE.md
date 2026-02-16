# Debug Mode Guide

## Overview

The debug mode is a powerful testing tool that helps discover broken buttons, console errors, and UX issues throughout the Science Lens AI application. It provides real-time logging of all button clicks, errors, and navigation issues.

## How to Enable Debug Mode

### Method 1: URL Parameter (Recommended)
Add `?debug=true` to any URL in the app:
```
https://science-lens-ai.vercel.app/dashboard?debug=true
https://science-lens-ai.vercel.app/learning?debug=true
https://science-lens-ai.vercel.app/shop?debug=true
```

### Method 2: Browser Console
Open the browser console (F12) and run:
```javascript
localStorage.setItem('debug', 'true');
location.reload();
```

### Method 3: Direct URL Access
Navigate to any page with `?debug=true` in the URL. Debug mode will persist across page navigations.

## Debug Panel Features

When debug mode is enabled, you'll see a **purple bug icon** in the bottom-right corner of the screen.

### Panel Features:
- **Live Click Log**: Every button click is logged in real-time
- **Error Detection**: Automatically catches and displays JavaScript errors
- **Button Identification**: Shows what each button is supposed to do (UX description)
- **Location Tracking**: Shows where each button is located in the app
- **Visual Feedback**: Clicked buttons are highlighted with a red border for 2 seconds
- **Error Counter**: Badge shows the number of errors detected
- **Click Counter**: Shows total number of buttons clicked

## Understanding the Logs

Each log entry shows:
- **Button Name**: The text/label of the button
- **Description**: What the button should do in plain English
- **Location**: Where the button is located in the app
- **Result**: ✅ Success (blue) or ❌ Error (red)
- **Timestamp**: When the click occurred
- **Details**: Full error stack trace (click "Show details")

## Systematic Testing Checklist

Use the built-in checklist in the debug panel to track your testing progress:

### 1. Dashboard Buttons
- [ ] **Continue Learning** → Should navigate to the last lesson the user was working on
- [ ] **Ask Questions** → Should navigate to the AI Q&A page
- [ ] **Start Challenge** → Should begin a new timed daily challenge
- [ ] **Daily Goal** → Should show XP progress and completion status

### 2. Learning Page
- [ ] **Start Course** → Navigate to first lesson of a new course
- [ ] **Continue Learning** → Navigate to next incomplete lesson
- [ ] **Category Filters** → Filter courses by category (Physics, Chemistry, etc.)
- [ ] **Difficulty Tabs** → Filter by difficulty (Beginner, Intermediate, Advanced)
- [ ] **Search Bar** → Search for courses by name/description

### 3. Lesson Navigation
- [ ] **Next Lesson** (floating button) → Go to next lesson in chapter
- [ ] **Back to Course** → Return to course page with all lessons
- [ ] **Read Aloud** → Use text-to-speech to read lesson content
- [ ] **Get AI Hint** → Show AI-generated hint for current topic
- [ ] **Mark as Complete** → Save progress, award XP, unlock next lesson

### 4. Chapter Quizzes
- [ ] **Start Chapter Quiz** → Open multi-step quiz at chapter end
- [ ] **Next Question** → Move to next quiz question
- [ ] **Previous Question** → Go back to previous question
- [ ] **Submit Chapter Quiz** → Submit answers and check score (70% to pass)

### 5. Shop
- [ ] **Equip Theme** → Apply selected theme to entire website
- [ ] **Select Theme** → Preview theme before equipping
- [ ] **Buy Premium Theme** → Deduct credits and unlock theme
- [ ] **Credit Balance** → Display available credits

### 6. Challenges Page
- [ ] **Start Daily Challenge** → Begin today's unique challenge (once per day)
- [ ] **Start Regular Challenge** → Begin practice challenge
- [ ] **Difficulty Selection** → Choose easy, medium, or hard
- [ ] **Timer** → Countdown timer should work correctly
- [ ] **Submit Answers** → Submit challenge and see results

### 7. Profile & Settings
- [ ] **Edit Profile** → Open profile editing form
- [ ] **Save Profile** → Save changes to database
- [ ] **Change Password** → Update account password
- [ ] **Toggle Notifications** → Enable/disable email notifications
- [ ] **Sign Out** → Sign out and redirect to landing page

### 8. Sidebar Navigation
- [ ] **Dashboard** → Navigate to main dashboard
- [ ] **Learning** → Navigate to learning page
- [ ] **Challenges** → Navigate to challenges page
- [ ] **Shop** → Navigate to theme shop
- [ ] **Profile** → Navigate to user profile
- [ ] **Settings** → Navigate to account settings
- [ ] **Sign Out** → Sign out of account

## Common Issues Detected

### "Button does nothing"
This error appears when:
- Button has no click handler (`onClick`)
- Button has no href (for links)
- Button handler throws an error silently

**What to check:**
- Is the button connected to an event handler?
- Does the handler function exist?
- Are there any console errors when clicking?

### "Error: [message]"
JavaScript errors that occur during button clicks:
- Network request failures
- Missing data/variables
- Type errors
- Reference errors

**What to check:**
- Check the "Show details" section for full stack trace
- Look for missing imports or undefined variables
- Verify API endpoints are correct

### Navigation Issues
If navigation doesn't work:
- Check if route exists in `App.tsx`
- Verify URL parameters match the route pattern
- Check for authentication requirements

## Exporting Debug Logs

Click the **"Copy Log"** button in the debug panel to export all logs to your clipboard. The log includes:
- All button clicks
- All errors detected
- Timestamps
- Full details

Use this to share results with the development team.

## Disabling Debug Mode

### Method 1: Remove URL Parameter
Remove `?debug=true` from the URL and refresh.

### Method 2: Browser Console
```javascript
localStorage.removeItem('debug');
location.reload();
```

### Method 3: Clear Local Storage
Open browser DevTools → Application → Local Storage → Remove `debug` key → Refresh.

## Tips for Effective Testing

1. **Test in Order**: Follow the systematic checklist from top to bottom
2. **Check Visual Feedback**: Watch for the red border highlight on clicked buttons
3. **Read Descriptions**: Each log shows what the button SHOULD do - verify it actually does it
4. **Check Console**: The debug panel catches most errors, but also check the browser console
5. **Test on Mobile**: Try testing on different screen sizes
6. **Test Flows**: Don't just test individual buttons - test complete user flows:
   - Sign up → Browse courses → Start lesson → Complete lesson → Take chapter quiz → Next chapter
   - Dashboard → Start challenge → Submit → View results
   - Shop → Buy theme → Equip → Check applied theme

## Example Testing Session

1. Enable debug mode: Go to `https://science-lens-ai.vercel.app/dashboard?debug=true`
2. Open the debug panel (click purple bug icon)
3. Click "Continue Learning" on dashboard
   - ✅ Log shows: "Continue Learning - Should navigate to the last lesson..."
   - Check if navigation worked
4. In a lesson, click "Next Lesson"
   - ✅ Log shows expected behavior
   - Check if actually moved to next lesson
5. Try clicking a button that might be broken
   - ❌ Error appears in debug panel
   - "Button does nothing" or specific error message
6. After testing, click "Copy Log" and share results

## Button Identification System

The debug mode automatically identifies buttons by:
- Button ID (if set via `id` attribute)
- Button text content
- CSS classes
- Parent container location

Buttons are matched against a comprehensive database of known buttons with their UX descriptions. Unknown buttons are logged with their HTML structure for identification.

## Advanced Usage

### Adding Custom Button Descriptions

Edit `src/components/debug/DebugPanel.tsx` and add to `BUTTON_DESCRIPTIONS`:

```typescript
'your-button-id': {
  description: 'What this button should do in plain English',
  location: 'Where this button is located'
}
```

### Programmatic Debug Logging

In your components, you can log custom debug events:

```typescript
import { logDebugEvent } from '@/components/debug/DebugPanel';

// Log a click
logDebugEvent(
  'click',
  'My Button',
  'Should do something important',
  'Page: /dashboard',
  undefined,
  buttonElement
);

// Log an error
logDebugEvent(
  'error',
  'My Feature',
  'Something went wrong',
  'Component: MyComponent',
  error.stack
);
```

## Troubleshooting

### Debug panel not showing
- Verify `?debug=true` is in URL
- Check localStorage has `debug: "true"`
- Refresh the page
- Check browser console for errors

### Buttons not being logged
- Verify debug mode is enabled (purple icon visible)
- Check button is a `<button>`, `<a>`, or has `role="button"`
- Try clicking different buttons

### False positives
Some buttons might be flagged as "does nothing" when they actually:
- Toggle state (like checkboxes, toggles)
- Open modals (might have slight delay)
- Perform background actions

Use your judgment when reviewing logs.

## Support

If you find bugs or have suggestions for the debug mode:
1. Copy the debug log
2. Include steps to reproduce
3. Share with the development team

Happy testing! 🐛
