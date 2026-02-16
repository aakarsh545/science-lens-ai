import React, { Component, ErrorInfo, ReactNode } from 'react';
import { AlertCircle, RefreshCw } from 'lucide-react';

interface Props {
  children: ReactNode;
  fallback?: ReactNode;
}

interface State {
  hasError: boolean;
  error: Error | null;
  errorInfo: ErrorInfo | null;
}

export class DebugErrorBoundary extends Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = {
      hasError: false,
      error: null,
      errorInfo: null
    };
  }

  static getDerivedStateFromError(error: Error): State {
    return {
      hasError: true,
      error,
      errorInfo: null
    };
  }

  componentDidCatch(error: Error, errorInfo: ErrorInfo) {
    this.setState({
      error,
      errorInfo
    });

    // Log to debug panel
    document.dispatchEvent(
      new CustomEvent('debug-log', {
        detail: {
          type: 'error',
          buttonName: 'React Error Boundary',
          description: error.message,
          location: window.location.href,
          details: `Component Stack:\n${errorInfo.componentStack}\n\nStack:\n${error.stack}`
        }
      })
    );

    // Also log to console
    console.error('Error caught by ErrorBoundary:', error, errorInfo);
  }

  handleReset = () => {
    this.setState({
      hasError: false,
      error: null,
      errorInfo: null
    });
  };

  render() {
    if (this.state.hasError) {
      if (this.props.fallback) {
        return this.props.fallback;
      }

      return (
        <div className="min-h-screen flex items-center justify-center bg-gray-50 dark:bg-gray-900 p-4">
          <div className="max-w-2xl w-full bg-white dark:bg-gray-800 rounded-lg shadow-xl p-8">
            <div className="flex items-center gap-3 mb-6">
              <AlertCircle className="w-12 h-12 text-red-500 flex-shrink-0" />
              <div>
                <h1 className="text-2xl font-bold text-gray-900 dark:text-white">
                  Something went wrong
                </h1>
                <p className="text-gray-600 dark:text-gray-400 mt-1">
                  An error occurred while rendering this page
                </p>
              </div>
            </div>

            {this.state.error && (
              <div className="bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 rounded-lg p-4 mb-6">
                <h3 className="font-semibold text-red-900 dark:text-red-300 mb-2">
                  Error Message:
                </h3>
                <p className="text-red-800 dark:text-red-200 font-mono text-sm">
                  {this.state.error.message}
                </p>

                {this.state.error.stack && (
                  <details className="mt-4">
                    <summary className="cursor-pointer text-sm text-red-700 dark:text-red-300 hover:text-red-900 dark:hover:text-red-100">
                      View Stack Trace
                    </summary>
                    <pre className="mt-3 text-xs bg-red-100 dark:bg-red-900/40 p-3 rounded overflow-x-auto">
                      {this.state.error.stack}
                    </pre>
                  </details>
                )}
              </div>
            )}

            {this.state.errorInfo && (
              <details className="mb-6">
                <summary className="cursor-pointer text-sm text-gray-700 dark:text-gray-300 hover:text-gray-900 dark:hover:text-gray-100">
                  View Component Stack
                </summary>
                <pre className="mt-3 text-xs bg-gray-100 dark:bg-gray-700 p-3 rounded overflow-x-auto">
                  {this.state.errorInfo.componentStack}
                </pre>
              </details>
            )}

            <div className="flex gap-3">
              <button
                onClick={this.handleReset}
                className="flex items-center gap-2 bg-purple-600 hover:bg-purple-700 text-white px-4 py-2 rounded-lg font-medium"
              >
                <RefreshCw className="w-4 h-4" />
                Try Again
              </button>
              <button
                onClick={() => window.location.href = '/'}
                className="bg-gray-200 dark:bg-gray-700 hover:bg-gray-300 dark:hover:bg-gray-600 px-4 py-2 rounded-lg font-medium"
              >
                Go to Home
              </button>
            </div>

            <div className="mt-6 p-4 bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 rounded-lg">
              <p className="text-sm text-blue-900 dark:text-blue-200">
                <strong>Debug Mode Active:</strong> This error has been logged to the debug panel.
                Check the panel in the bottom-right corner for more details.
              </p>
            </div>
          </div>
        </div>
      );
    }

    return this.props.children;
  }
}
