import { createContext, useContext, useState, useEffect, ReactNode } from 'react';

interface DebugContextType {
  debugMode: boolean;
  setDebugMode: (enabled: boolean) => void;
  toggleDebugMode: () => void;
}

const DebugContext = createContext<DebugContextType | undefined>(undefined);

export function DebugProvider({ children }: { children: ReactNode }) {
  const [debugMode, setDebugModeState] = useState(false);

  useEffect(() => {
    // Check URL params
    const urlParams = new URLSearchParams(window.location.search);
    const urlDebug = urlParams.get('debug') === 'true';

    // Check localStorage
    const localDebug = localStorage.getItem('debug') === 'true';

    if (urlDebug || localDebug) {
      setDebugModeState(true);
      localStorage.setItem('debug', 'true');
    }
  }, []);

  const setDebugMode = (enabled: boolean) => {
    setDebugModeState(enabled);
    localStorage.setItem('debug', enabled ? 'true' : 'false');

    // Update URL without reloading
    const url = new URL(window.location.href);
    if (enabled) {
      url.searchParams.set('debug', 'true');
    } else {
      url.searchParams.delete('debug');
    }
    window.history.replaceState({}, '', url.toString());
  };

  const toggleDebugMode = () => {
    setDebugMode(!debugMode);
  };

  return (
    <DebugContext.Provider value={{ debugMode, setDebugMode, toggleDebugMode }}>
      {children}
    </DebugContext.Provider>
  );
}

export function useDebug() {
  const context = useContext(DebugContext);
  if (context === undefined) {
    throw new Error('useDebug must be used within a DebugProvider');
  }
  return context;
}
