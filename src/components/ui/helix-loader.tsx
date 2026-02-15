import * as React from "react";

import { cn } from "@/lib/utils";

export interface HelixLoaderProps extends React.HTMLAttributes<HTMLDivElement> {
  size?: number;
  color?: string;
}

const HelixLoader = React.forwardRef<HTMLDivElement, HelixLoaderProps>(
  ({ className, size = 45, color = "hsl(var(--primary))", ...props }, ref) => {
    const uibSpeed = "2.5s";
    const uibA = `calc(${uibSpeed} / -2)`;
    const uibB = `calc(${uibSpeed} / -6)`;

    return (
      <div
        ref={ref}
        className={cn("inline-flex items-center justify-center", className)}
        {...props}
      >
        <style>{`
          .helix-loader-container {
            --uib-size: ${size}px;
            --uib-color: ${color};
            --uib-speed: ${uibSpeed};
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: var(--uib-size);
            width: var(--uib-size);
          }

          .helix-slice {
            position: relative;
            height: calc(var(--uib-size) / 6);
            width: 100%;
          }

          .helix-slice::before,
          .helix-slice::after {
            --uib-a: ${uibA};
            --uib-b: ${uibB};
            content: '';
            position: absolute;
            top: 0;
            left: calc(50% - var(--uib-size) / 12);
            height: 100%;
            width: calc(100% / 6);
            border-radius: 50%;
            background-color: var(--uib-color);
            flex-shrink: 0;
            animation: orbit var(--uib-speed) linear infinite;
            transition: background-color 0.3s ease;
          }

          .helix-slice:nth-child(1)::after {
            animation-delay: var(--uib-a);
          }

          .helix-slice:nth-child(2)::before {
            animation-delay: var(--uib-b);
          }

          .helix-slice:nth-child(2)::after {
            animation-delay: calc(var(--uib-a) + var(--uib-b));
          }

          .helix-slice:nth-child(3)::before {
            animation-delay: calc(var(--uib-b) * 2);
          }
          .helix-slice:nth-child(3)::after {
            animation-delay: calc(var(--uib-a) + var(--uib-b) * 2);
          }

          .helix-slice:nth-child(4)::before {
            animation-delay: calc(var(--uib-b) * 3);
          }
          .helix-slice:nth-child(4)::after {
            animation-delay: calc(var(--uib-a) + var(--uib-b) * 3);
          }

          .helix-slice:nth-child(5)::before {
            animation-delay: calc(var(--uib-b) * 4);
          }
          .helix-slice:nth-child(5)::after {
            animation-delay: calc(var(--uib-a) + var(--uib-b) * 4);
          }

          .helix-slice:nth-child(6)::before {
            animation-delay: calc(var(--uib-b) * 5);
          }
          .helix-slice:nth-child(6)::after {
            animation-delay: calc(var(--uib-a) + var(--uib-b) * 5);
          }

          @keyframes orbit {
            0% {
              transform: translateX(calc(var(--uib-size) * 0.25)) scale(0.73684);
              opacity: 0.65;
            }
            5% {
              transform: translateX(calc(var(--uib-size) * 0.235)) scale(0.684208);
              opacity: 0.58;
            }
            10% {
              transform: translateX(calc(var(--uib-size) * 0.182)) scale(0.631576);
              opacity: 0.51;
            }
            15% {
              transform: translateX(calc(var(--uib-size) * 0.129)) scale(0.578944);
              opacity: 0.44;
            }
            20% {
              transform: translateX(calc(var(--uib-size) * 0.076)) scale(0.526312);
              opacity: 0.37;
            }
            25% {
              transform: translateX(0%) scale(0.47368);
              opacity: 0.3;
            }
            30% {
              transform: translateX(calc(var(--uib-size) * -0.076)) scale(0.526312);
              opacity: 0.37;
            }
            35% {
              transform: translateX(calc(var(--uib-size) * -0.129)) scale(0.578944);
              opacity: 0.44;
            }
            40% {
              transform: translateX(calc(var(--uib-size) * -0.182)) scale(0.631576);
              opacity: 0.51;
            }
            45% {
              transform: translateX(calc(var(--uib-size) * -0.235)) scale(0.684208);
              opacity: 0.58;
            }
            50% {
              transform: translateX(calc(var(--uib-size) * -0.25)) scale(0.73684);
              opacity: 0.65;
            }
            55% {
              transform: translateX(calc(var(--uib-size) * -0.235)) scale(0.789472);
              opacity: 0.72;
            }
            60% {
              transform: translateX(calc(var(--uib-size) * -0.182)) scale(0.842104);
              opacity: 0.79;
            }
            65% {
              transform: translateX(calc(var(--uib-size) * -0.129)) scale(0.894736);
              opacity: 0.86;
            }
            70% {
              transform: translateX(calc(var(--uib-size) * -0.076)) scale(0.947368);
              opacity: 0.93;
            }
            75% {
              transform: translateX(0%) scale(1);
              opacity: 1;
            }
            80% {
              transform: translateX(calc(var(--uib-size) * 0.076)) scale(0.947368);
              opacity: 0.93;
            }
            85% {
              transform: translateX(calc(var(--uib-size) * 0.129)) scale(0.894736);
              opacity: 0.86;
            }
            90% {
              transform: translateX(calc(var(--uib-size) * 0.182)) scale(0.842104);
              opacity: 0.79;
            }
            95% {
              transform: translateX(calc(var(--uib-size) * 0.235)) scale(0.789472);
              opacity: 0.72;
            }
            100% {
              transform: translateX(calc(var(--uib-size) * 0.25)) scale(0.73684);
              opacity: 0.65;
            }
          }
        `}</style>
        <div className="helix-loader-container">
          <div className="helix-slice"></div>
          <div className="helix-slice"></div>
          <div className="helix-slice"></div>
          <div className="helix-slice"></div>
          <div className="helix-slice"></div>
          <div className="helix-slice"></div>
        </div>
      </div>
    );
  }
);

HelixLoader.displayName = "HelixLoader";

export { HelixLoader };
