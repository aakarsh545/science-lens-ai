import * as React from "react";

import { cn } from "@/lib/utils";

export interface HelixLoaderProps extends React.HTMLAttributes<HTMLDivElement> {}

const HelixLoader = React.forwardRef<HTMLDivElement, HelixLoaderProps>(
  ({ className, ...props }, ref) => {
    return (
      <div
        ref={ref}
        className={cn("inline-flex items-center justify-center h-8 w-8", className)}
        {...props}
      >
        <svg
          className="animate-helix-spin"
          viewBox="0 0 100 100"
          xmlns="http://www.w3.org/2000/svg"
        >
          {/* Background circle - dark navy */}
          <circle cx="50" cy="50" r="48" fill="hsl(var(--background))" opacity="0.1" />

          {/* Helix spiral arms - pink/magenta curved lines */}
          {/* Arm 1 */}
          <path
            d="M 50 50 Q 70 50 75 30"
            stroke="hsl(var(--primary))"
            strokeWidth="3"
            fill="none"
            strokeLinecap="round"
            opacity="0.9"
          />
          <path
            d="M 50 50 Q 80 50 85 25"
            stroke="hsl(var(--primary))"
            strokeWidth="2.5"
            fill="none"
            strokeLinecap="round"
            opacity="0.7"
          />

          {/* Arm 2 - rotated 120 degrees */}
          <path
            d="M 50 50 Q 70 50 75 30"
            stroke="hsl(var(--primary))"
            strokeWidth="3"
            fill="none"
            strokeLinecap="round"
            opacity="0.9"
            transform="rotate(120, 50, 50)"
          />
          <path
            d="M 50 50 Q 80 50 85 25"
            stroke="hsl(var(--primary))"
            strokeWidth="2.5"
            fill="none"
            strokeLinecap="round"
            opacity="0.7"
            transform="rotate(120, 50, 50)"
          />

          {/* Arm 3 - rotated 240 degrees */}
          <path
            d="M 50 50 Q 70 50 75 30"
            stroke="hsl(var(--primary))"
            strokeWidth="3"
            fill="none"
            strokeLinecap="round"
            opacity="0.9"
            transform="rotate(240, 50, 50)"
          />
          <path
            d="M 50 50 Q 80 50 85 25"
            stroke="hsl(var(--primary))"
            strokeWidth="2.5"
            fill="none"
            strokeLinecap="round"
            opacity="0.7"
            transform="rotate(240, 50, 50)"
          />

          {/* Center white dots */}
          <circle cx="50" cy="50" r="3" fill="white" opacity="1" />
          <circle cx="50" cy="50" r="2" fill="white" opacity="0.8" />
        </svg>
      </div>
    );
  }
);

HelixLoader.displayName = "HelixLoader";

export { HelixLoader };
