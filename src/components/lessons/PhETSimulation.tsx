import React from 'react';
import Spline from '@splinetool/react-spline';
import { useRive } from '@rive-app/react-canvas';
import Lottie from 'lottie-react';

interface PhETSimulationProps {
  type: 'phet' | 'spline' | 'rive' | 'lottie';
  url?: string;
  title?: string;
  config?: any;
}

const RiveWrapper: React.FC<{ url: string; stateMachine?: string }> = ({ url, stateMachine }) => {
  const { RiveComponent } = useRive({
    src: url,
    stateMachines: stateMachine || 'bouncing-drive',
    autoplay: true,
  });
  return <RiveComponent style={{ width: '100%', height: '100%' }} />;
};

export const PhETSimulation: React.FC<PhETSimulationProps> = ({ type, url, title, config }) => {
  const renderSimulation = () => {
    switch (type) {
      case 'phet':
        return (
          <div className="w-full h-[600px] rounded-lg border-2 border-purple-200 bg-white">
            <iframe
              src={url}
              title={title || 'PHET Simulation'}
              className="w-full h-full border-0"
              allowFullScreen
              loading="lazy"
            />
          </div>
        );

      case 'spline':
        return (
          <div className="w-full h-[600px] rounded-lg border-2 border-blue-200 bg-gradient-to-br from-blue-50 to-purple-50">
            <Spline
              scene={url || ''}
              style={{ width: '100%', height: '100%' }}
            />
          </div>
        );

      case 'rive':
        return (
          <div className="w-full h-[600px] rounded-lg border-2 border-orange-200 bg-orange-50">
            <RiveWrapper url={url || ''} stateMachine={config?.stateMachine} />
          </div>
        );

      case 'lottie':
        return (
          <div className="w-full h-[600px] rounded-lg border-2 border-green-200 bg-green-50">
            <Lottie
              animationData={config?.animationData || url}
              loop={true}
              className="w-full h-full"
            />
          </div>
        );

      default:
        return null;
    }
  };

  return (
    <div className="my-6">
      {title && (
        <h3 className="text-lg font-semibold mb-3 text-[var(--text-primary)]">
          {title}
        </h3>
      )}
      {renderSimulation()}
    </div>
  );
};

export default PhETSimulation;