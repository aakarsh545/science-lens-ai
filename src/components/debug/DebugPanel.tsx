import { useState, useEffect, useRef } from 'react';
import { X, Bug, AlertCircle, CheckCircle, Clock, Play, SkipForward } from 'lucide-react';

interface DebugLog {
  id: string;
  timestamp: Date;
  type: 'click' | 'error' | 'success';
  buttonName: string;
  description: string;
  location: string;
  details?: string;
}

interface DebugPanelProps {
  enabled: boolean;
  onClose: () => void;
}

// UX descriptions for all major buttons in the app
const BUTTON_DESCRIPTIONS: Record<string, { description: string; location: string }> = {
  // Dashboard buttons
  'continue-learning': {
    description: 'Should navigate to the last lesson the user was working on',
    location: 'Dashboard - Continue Learning card'
  },
  'ask-questions': {
    description: 'Should navigate to the AI Q&A page where users can ask science questions',
    location: 'Dashboard - Ask Questions card'
  },
  'start-challenge': {
    description: 'Should navigate to the Challenges page and begin a new timed daily challenge',
    location: 'Dashboard - Daily Challenge card'
  },
  'daily-goal': {
    description: 'Should show the user\'s daily XP goal progress and completion status',
    location: 'Dashboard - Daily Goal section'
  },

  // Learning page buttons
  'start-course': {
    description: 'Should navigate to the first lesson of the selected course',
    location: 'Learning page - Course card'
  },
  'continue-course': {
    description: 'Should navigate to the next incomplete lesson in the course',
    location: 'Learning page - Course card'
  },
  'next-lesson': {
    description: 'Should take the user to the next lesson in the current chapter',
    location: 'LessonPlayer - floating button (bottom-right)'
  },
  'mark-complete': {
    description: 'Should save the lesson as completed, award XP, and unlock the next lesson',
    location: 'LessonPlayer - action buttons'
  },
  'read-aloud': {
    description: 'Should use text-to-speech to read the lesson content aloud',
    location: 'LessonPlayer - content toolbar'
  },
  'get-hint': {
    description: 'Should show an AI-generated hint to help understand the current topic',
    location: 'LessonPlayer - Get Hint button'
  },
  'back-to-course': {
    description: 'Should navigate back to the course page showing all lessons',
    location: 'LessonPlayer - Back to Course button'
  },
  'start-chapter-quiz': {
    description: 'Should open the multi-step chapter quiz to test knowledge of the chapter',
    location: 'LessonPlayer - Chapter Quiz card'
  },

  // Challenges page buttons
  'challenge-start': {
    description: 'Should begin a new challenge session with the selected difficulty',
    location: 'Challenges page - Challenge card'
  },
  'daily-challenge-start': {
    description: 'Should start today\'s unique daily challenge (can only be played once per day)',
    location: 'Challenges page - Daily Challenge section'
  },

  // Profile & Settings
  'edit-profile': {
    description: 'Should open profile editing form to update name, bio, avatar',
    location: 'Profile page - Edit button'
  },
  'save-profile': {
    description: 'Should save profile changes to the database',
    location: 'Profile page - Save button'
  },
  'change-password': {
    description: 'Should open password change form',
    location: 'Settings page - Security section'
  },
  'toggle-notifications': {
    description: 'Should enable/disable email notifications for the user',
    location: 'Settings page - Notifications section'
  },
  'delete-account': {
    description: 'Should permanently delete the user account and all data (with confirmation)',
    location: 'Settings page - Danger Zone'
  },

  // Navigation
  'sidebar-dashboard': {
    description: 'Should navigate to the main dashboard',
    location: 'Sidebar - Dashboard link'
  },
  'sidebar-learning': {
    description: 'Should navigate to the learning page with all courses',
    location: 'Sidebar - Learning link'
  },
  'sidebar-challenges': {
    description: 'Should navigate to the challenges page',
    location: 'Sidebar - Challenges link'
  },
  'sidebar-profile': {
    description: 'Should navigate to the user profile page',
    location: 'Sidebar - Profile link'
  },
  'sidebar-settings': {
    description: 'Should navigate to account settings',
    location: 'Sidebar - Settings link'
  },
  'sign-out': {
    description: 'Should sign the user out and redirect to landing page',
    location: 'Sidebar - Sign Out button'
  },

  // General
  'submit': {
    description: 'Should submit the form or complete the current action',
    location: 'Form - Submit button'
  },
  'cancel': {
    description: 'Should cancel the current action and return to previous state',
    location: 'Modal/Form - Cancel button'
  },
  'confirm': {
    description: 'Should confirm the action and proceed',
    location: 'Modal - Confirm button'
  },
  'close': {
    description: 'Should close the modal or dialog',
    location: 'Modal - Close button'
  }
};

export function DebugPanel({ enabled, onClose }: DebugPanelProps) {
  const [logs, setLogs] = useState<DebugLog[]>([]);
  const [isExpanded, setIsExpanded] = useState(false);
  const logsEndRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (!enabled) return;

    // Listen for debug events from other components
    const handleDebugEvent = (event: CustomEvent) => {
      const { type, buttonName, description, location, details } = event.detail;

      const newLog: DebugLog = {
        id: `${Date.now()}-${Math.random()}`,
        timestamp: new Date(),
        type,
        buttonName,
        description,
        location,
        details
      };

      setLogs(prev => [...prev, newLog].slice(-100)); // Keep last 100 logs

      // Highlight the clicked button
      if (type === 'click' && event.detail.element) {
        const element = event.detail.element as HTMLElement;
        element.style.outline = '3px solid red';
        element.style.outlineOffset = '2px';
        setTimeout(() => {
          element.style.outline = '';
          element.style.outlineOffset = '';
        }, 2000);
      }
    };

    document.addEventListener('debug-log', handleDebugEvent as EventListener);

    // Listen for global errors
    const handleError = (event: ErrorEvent) => {
      const newLog: DebugLog = {
        id: `error-${Date.now()}`,
        timestamp: new Date(),
        type: 'error',
        buttonName: 'Global Error',
        description: event.message,
        location: window.location.href,
        details: event.error?.stack || 'No stack trace available'
      };
      setLogs(prev => [...prev, newLog].slice(-100));
    };

    window.addEventListener('error', handleError);

    return () => {
      document.removeEventListener('debug-log', handleDebugEvent as EventListener);
      window.removeEventListener('error', handleError);
    };
  }, [enabled]);

  useEffect(() => {
    // Auto-scroll to bottom when new logs arrive
    if (logsEndRef.current) {
      logsEndRef.current.scrollIntoView({ behavior: 'smooth' });
    }
  }, [logs]);

  // Automated testing functionality
  const [isTesting, setIsTesting] = useState(false);
  const [testProgress, setTestProgress] = useState({ current: 0, total: 0 });
  const [testStatus, setTestStatus] = useState('');
  const testingRef = useRef(false);
  const abortControllerRef = useRef<AbortController | null>(null);

  const findTestableButtons = (): HTMLElement[] => {
    // Find all buttons, links, and clickable elements
    const buttons = Array.from(document.querySelectorAll(
      'button:not([disabled]), a[href], [role="button"]:not([disabled])'
    )) as HTMLElement[];

    // Filter out debug panel buttons and hidden elements
    return buttons.filter(btn => {
      // Skip debug panel buttons
      if (btn.closest('.debug-panel')) return false;

      // Skip hidden elements
      const rect = btn.getBoundingClientRect();
      if (rect.width === 0 || rect.height === 0) return false;

      // Skip elements with display: none or visibility: hidden
      const style = window.getComputedStyle(btn);
      if (style.display === 'none' || style.visibility === 'hidden') return false;

      return true;
    });
  };

  const testAllButtons = async () => {
    if (isTesting) {
      // Stop testing
      abortControllerRef.current?.abort();
      testingRef.current = false;
      setIsTesting(false);
      setTestStatus('');
      return;
    }

    const buttons = findTestableButtons();
    if (buttons.length === 0) {
      logDebugEvent(
        'error',
        'Test All Buttons',
        'No clickable buttons found on current page',
        window.location.href
      );
      return;
    }

    testingRef.current = true;
    setIsTesting(true);
    abortControllerRef.current = new AbortController();

    setTestProgress({ current: 0, total: buttons.length });
    setTestStatus('Starting automated button testing...');

    logDebugEvent(
      'click',
      'Test All Buttons',
      `Starting automated test of ${buttons.length} buttons`,
      window.location.href
    );

    // Test buttons one by one
    for (let i = 0; i < buttons.length; i++) {
      if (!testingRef.current) break;

      const button = buttons[i];
      setTestProgress({ current: i + 1, total: buttons.length });
      setTestStatus(`Testing button ${i + 1}/${buttons.length}...`);

      const { name, description, location } = identifyButton(button);

      // Scroll button into view
      button.scrollIntoView({ behavior: 'smooth', block: 'center' });

      // Wait a bit for scroll
      await new Promise(resolve => setTimeout(resolve, 500));

      // Highlight the button
      button.style.outline = '3px solid orange';
      button.style.outlineOffset = '2px';

      try {
        // Click the button
        const clickEvent = new MouseEvent('click', {
          bubbles: true,
          cancelable: true,
          view: window
        });
        button.dispatchEvent(clickEvent);

        logDebugEvent('click', name, description, location, undefined, button);

        // Wait to observe effects
        await new Promise(resolve => setTimeout(resolve, 1000));
      } catch (error) {
        logDebugEvent(
          'error',
          name,
          `Error clicking button: ${error}`,
          location,
          error instanceof Error ? error.stack : String(error)
        );
      } finally {
        // Remove highlight
        button.style.outline = '';
        button.style.outlineOffset = '';
      }
    }

    testingRef.current = false;
    setIsTesting(false);
    setTestStatus(`Completed testing ${buttons.length} buttons!`);

    logDebugEvent(
      'success',
      'Test All Buttons',
      `Successfully completed automated test of ${buttons.length} buttons`,
      window.location.href
    );

    // Clear status after 3 seconds
    setTimeout(() => setTestStatus(''), 3000);
  };

  if (!enabled) return null;

  const getLogIcon = (type: DebugLog['type']) => {
    switch (type) {
      case 'error':
        return <AlertCircle className="w-4 h-4 text-red-500" />;
      case 'success':
        return <CheckCircle className="w-4 h-4 text-green-500" />;
      case 'click':
        return <Clock className="w-4 h-4 text-blue-500" />;
    }
  };

  const getLogBgColor = (type: DebugLog['type']) => {
    switch (type) {
      case 'error':
        return 'bg-red-50 dark:bg-red-950/20 border-red-200 dark:border-red-800';
      case 'success':
        return 'bg-green-50 dark:bg-green-950/20 border-green-200 dark:border-green-800';
      case 'click':
        return 'bg-blue-50 dark:bg-blue-950/20 border-blue-200 dark:border-blue-800';
    }
  };

  const errorCount = logs.filter(l => l.type === 'error').length;
  const clickCount = logs.filter(l => l.type === 'click').length;

  return (
    <div className="fixed bottom-4 right-4 z-[9999] font-sans">
      {!isExpanded ? (
        <button
          onClick={() => setIsExpanded(true)}
          className="bg-purple-600 hover:bg-purple-700 text-white rounded-full p-3 shadow-lg"
          title="Open Debug Panel"
        >
          <Bug className="w-6 h-6" />
          {errorCount > 0 && (
            <span className="absolute -top-1 -right-1 bg-red-500 text-white text-xs rounded-full w-5 h-5 flex items-center justify-center">
              {errorCount}
            </span>
          )}
        </button>
      ) : (
        <div className="bg-white dark:bg-gray-900 rounded-lg shadow-2xl border-2 border-purple-500 w-[500px] max-h-[600px] flex flex-col">
          {/* Header */}
          <div className="bg-purple-600 text-white p-4 rounded-t-lg flex items-center justify-between">
            <div className="flex items-center gap-2">
              <Bug className="w-5 h-5" />
              <h3 className="font-bold">Debug Panel</h3>
            </div>
            <div className="flex items-center gap-2">
              <span className="text-sm bg-purple-700 px-2 py-1 rounded">
                {clickCount} clicks
              </span>
              <span className="text-sm bg-red-700 px-2 py-1 rounded">
                {errorCount} errors
              </span>
              <button
                onClick={() => {
                  setLogs([]);
                  setIsExpanded(false);
                }}
                className="hover:bg-purple-700 p-1 rounded"
              >
                <X className="w-5 h-5" />
              </button>
            </div>
          </div>

          {/* Testing Controls */}
          <div className="p-4 border-b border-gray-200 dark:border-gray-700 debug-panel">
            <h4 className="font-semibold mb-2 text-sm">Automated Testing</h4>

            <button
              onClick={testAllButtons}
              disabled={isTesting}
              className={`w-full flex items-center justify-center gap-2 px-4 py-3 rounded-lg font-medium text-sm transition-colors ${
                isTesting
                  ? 'bg-orange-600 hover:bg-orange-700 text-white'
                  : 'bg-purple-600 hover:bg-purple-700 text-white'
              }`}
            >
              {isTesting ? (
                <>
                  <SkipForward className="w-4 h-4" />
                  Stop Testing
                </>
              ) : (
                <>
                  <Play className="w-4 h-4" />
                  Test All Buttons
                </>
              )}
            </button>

            {isTesting && (
              <div className="mt-3 space-y-2">
                <div className="flex items-center justify-between text-xs">
                  <span className="text-gray-600 dark:text-gray-400">
                    Progress: {testProgress.current} / {testProgress.total}
                  </span>
                  <span className="font-medium">
                    {Math.round((testProgress.current / testProgress.total) * 100)}%
                  </span>
                </div>
                <div className="w-full h-2 bg-gray-200 dark:bg-gray-700 rounded-full overflow-hidden">
                  <div
                    className="h-full bg-gradient-to-r from-purple-600 to-pink-600 transition-all duration-300"
                    style={{ width: `${(testProgress.current / testProgress.total) * 100}%` }}
                  />
                </div>
                {testStatus && (
                  <p className="text-xs text-gray-600 dark:text-gray-400 text-center">
                    {testStatus}
                  </p>
                )}
              </div>
            )}

            {!isTesting && testStatus && (
              <div className="mt-2 p-2 bg-green-50 dark:bg-green-950/20 border border-green-200 dark:border-green-800 rounded">
                <p className="text-xs text-green-800 dark:text-green-200 text-center">
                  ✓ {testStatus}
                </p>
              </div>
            )}
          </div>

          {/* Logs */}
          <div className="flex-1 overflow-y-auto p-4 space-y-2">
            {logs.length === 0 ? (
              <p className="text-gray-500 text-sm text-center py-8">
                No logs yet. Click buttons to start testing.
              </p>
            ) : (
              logs.map(log => (
                <div
                  key={log.id}
                  className={`p-3 rounded-lg border ${getLogBgColor(log.type)}`}
                >
                  <div className="flex items-start gap-2">
                    {getLogIcon(log.type)}
                    <div className="flex-1 min-w-0">
                      <div className="font-semibold text-sm">{log.buttonName}</div>
                      <div className="text-xs text-gray-600 dark:text-gray-400 mt-1">
                        {log.description}
                      </div>
                      <div className="text-xs text-gray-500 dark:text-gray-500 mt-1">
                        📍 {log.location}
                      </div>
                      {log.details && (
                        <details className="mt-2">
                          <summary className="text-xs cursor-pointer text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-200">
                            Show details
                          </summary>
                          <pre className="text-xs mt-2 p-2 bg-gray-100 dark:bg-gray-800 rounded overflow-x-auto">
                            {log.details}
                          </pre>
                        </details>
                      )}
                      <div className="text-xs text-gray-400 mt-1">
                        {log.timestamp.toLocaleTimeString()}
                      </div>
                    </div>
                  </div>
                </div>
              ))
            )}
            <div ref={logsEndRef} />
          </div>

          {/* Footer */}
          <div className="p-3 border-t border-gray-200 dark:border-gray-700 flex gap-2">
            <button
              onClick={() => setLogs([])}
              className="flex-1 bg-gray-200 dark:bg-gray-700 hover:bg-gray-300 dark:hover:bg-gray-600 px-3 py-2 rounded text-sm font-medium"
            >
              Clear Logs
            </button>
            <button
              onClick={() => {
                const testResults = logs.map(l => `${l.type.toUpperCase()}: ${l.buttonName} - ${l.description}`).join('\n');
                navigator.clipboard.writeText(testResults);
                alert('Debug log copied to clipboard!');
              }}
              className="flex-1 bg-purple-600 hover:bg-purple-700 text-white px-3 py-2 rounded text-sm font-medium"
            >
              Copy Log
            </button>
          </div>
        </div>
      )}
    </div>
  );
}

// Helper function to identify buttons
export function identifyButton(element: HTMLElement): { name: string; description: string; location: string } {
  const buttonText = element.textContent?.trim().slice(0, 50) || 'Unnamed Button';
  const buttonId = element.id || element.getAttribute('data-testid') || '';
  const buttonClass = element.className;

  // Check if button matches known patterns
  if (buttonId && BUTTON_DESCRIPTIONS[buttonId]) {
    return {
      name: buttonText,
      ...BUTTON_DESCRIPTIONS[buttonId]
    };
  }

  // Try to identify by text content
  const lowerText = buttonText.toLowerCase();

  if (lowerText.includes('continue learning') || lowerText.includes('continue')) {
    return { name: buttonText, ...BUTTON_DESCRIPTIONS['continue-learning'] };
  }
  if (lowerText.includes('ask question') || lowerText.includes('ask ai')) {
    return { name: buttonText, ...BUTTON_DESCRIPTIONS['ask-questions'] };
  }
  if (lowerText.includes('start challenge') || lowerText.includes('begin')) {
    return { name: buttonText, ...BUTTON_DESCRIPTIONS['start-challenge'] };
  }
  if (lowerText.includes('next lesson') || lowerText.includes('next →')) {
    return { name: buttonText, ...BUTTON_DESCRIPTIONS['next-lesson'] };
  }
  if (lowerText.includes('mark complete') || lowerText.includes('complete')) {
    return { name: buttonText, ...BUTTON_DESCRIPTIONS['mark-complete'] };
  }
  if (lowerText.includes('read aloud') || lowerText.includes('speak')) {
    return { name: buttonText, ...BUTTON_DESCRIPTIONS['read-aloud'] };
  }
  if (lowerText.includes('get hint') || lowerText.includes('hint')) {
    return { name: buttonText, ...BUTTON_DESCRIPTIONS['get-hint'] };
  }
  if (lowerText.includes('back to course') || lowerText.includes('back')) {
    return { name: buttonText, ...BUTTON_DESCRIPTIONS['back-to-course'] };
  }
  if (lowerText.includes('start chapter quiz') || lowerText.includes('chapter quiz')) {
    return { name: buttonText, ...BUTTON_DESCRIPTIONS['start-chapter-quiz'] };
  }
  if (lowerText.includes('sign out') || lowerText.includes('logout')) {
    return { name: buttonText, ...BUTTON_DESCRIPTIONS['sign-out'] };
  }
  if (lowerText.includes('submit')) {
    return { name: buttonText, ...BUTTON_DESCRIPTIONS['submit'] };
  }
  if (lowerText.includes('cancel')) {
    return { name: buttonText, ...BUTTON_DESCRIPTIONS['cancel'] };
  }
  if (lowerText.includes('confirm')) {
    return { name: buttonText, ...BUTTON_DESCRIPTIONS['confirm'] };
  }
  if (lowerText.includes('close')) {
    return { name: buttonText, ...BUTTON_DESCRIPTIONS['close'] };
  }

  // Default identification
  return {
    name: buttonText,
    description: 'Button action not yet documented',
    location: `Page: ${window.location.pathname} | Class: ${buttonClass}`
  };
}

// Helper to emit debug events
export function logDebugEvent(
  type: 'click' | 'error' | 'success',
  buttonName: string,
  description: string,
  location: string,
  details?: string,
  element?: HTMLElement
) {
  document.dispatchEvent(
    new CustomEvent('debug-log', {
      detail: { type, buttonName, description, location, details, element }
    })
  );
}
