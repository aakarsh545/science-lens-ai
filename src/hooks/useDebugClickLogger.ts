import { useEffect } from 'react';
import { useDebug } from '@/contexts/DebugContext';
import { identifyButton, logDebugEvent } from '@/components/debug/DebugPanel';

export function useDebugClickLogger() {
  const { debugMode } = useDebug();

  useEffect(() => {
    if (!debugMode) return;

    let lastClickTime = 0;
    let navigationOccurred = false;
    let stateChanged = false;

    // Track navigation
    const originalPushState = history.pushState;
    const originalReplaceState = history.replaceState;

    history.pushState = function (...args) {
      navigationOccurred = true;
      return originalPushState.apply(this, args);
    };

    history.replaceState = function (...args) {
      navigationOccurred = true;
      return originalReplaceState.apply(this, args);
    };

    // Track hash changes
    const handleHashChange = () => {
      navigationOccurred = true;
    };
    window.addEventListener('hashchange', handleHashChange);

    // Track popstate (back/forward buttons)
    const handlePopState = () => {
      navigationOccurred = true;
    };
    window.addEventListener('popstate', handlePopState);

    // Log all button clicks
    const handleClick = (event: MouseEvent) => {
      const target = event.target as HTMLElement;
      const button = target.closest('button, a, [role="button"]') as HTMLElement;

      if (!button) return;

      lastClickTime = Date.now();
      navigationOccurred = false;
      stateChanged = false;

      const { name, description, location } = identifyButton(button);

      // Log the click immediately
      logDebugEvent('click', name, description, location, undefined, button);

      // Check if button did nothing after 500ms
      setTimeout(() => {
        if (!navigationOccurred && !stateChanged) {
          // Check if button has onClick handler
          const hasClickHandler = button.onclick !== null ||
                                 button.getAttribute('onclick') !== null;

          if (!hasClickHandler && !(button as any).href) {
            // Button has no handler and no href - it's a dead button!
            logDebugEvent(
              'error',
              name,
              'Button does nothing - no click handler or navigation',
              location,
              `Button HTML:\n${button.outerHTML.slice(0, 200)}`
            );
          }
        }
      }, 500);
    };

    // Capture errors from button clicks
    const handleError = (event: ErrorEvent) => {
      const timeSinceClick = Date.now() - lastClickTime;

      if (timeSinceClick < 1000) {
        // This error likely came from a button click
        const button = document.activeElement as HTMLElement;
        if (button) {
          const { name, location } = identifyButton(button);

          logDebugEvent(
            'error',
            name,
            `Error: ${event.message}`,
            location,
            `Stack:\n${event.error?.stack || 'No stack available'}`
          );
        }
      }
    };

    // Use capture phase to catch all clicks
    document.addEventListener('click', handleClick, true);
    window.addEventListener('error', handleError);

    return () => {
      document.removeEventListener('click', handleClick, true);
      window.removeEventListener('error', handleError);
      window.removeEventListener('hashchange', handleHashChange);
      window.removeEventListener('popstate', handlePopState);

      // Restore original methods
      history.pushState = originalPushState;
      history.replaceState = originalReplaceState;
    };
  }, [debugMode]);
}
