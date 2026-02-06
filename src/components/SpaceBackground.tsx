import React from 'react';

export default function SpaceBackground() {
  return (
    <div className="fixed inset-0 -z-10 bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900">
      {/* Simple CSS-based stars */}
      <div className="absolute inset-0 starfield opacity-30" />
      {/* Gradient overlay for depth */}
      <div className="absolute inset-0 bg-gradient-to-t from-slate-900/50 via-transparent to-slate-900/50" />
    </div>
  );
}
