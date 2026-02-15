import React, { useCallback, useState } from 'react';
import ReactFlow, {
  MiniMap,
  Controls,
  Background,
  useNodesState,
  useEdgesState,
  addEdge,
  Connection,
  Edge,
  Node,
  BackgroundVariant,
} from 'reactflow';
import 'reactflow/dist/style.css';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from './ui/card';

/**
 * ReactFlowExample Component
 *
 * Demonstrates interactive node-based diagrams using React Flow
 * Useful for creating concept maps, flow charts, and learning pathways
 */

// Initial nodes for a sample learning pathway
const initialNodes: Node[] = [
  {
    id: '1',
    type: 'input',
    data: { label: 'Start: Physics Basics' },
    position: { x: 250, y: 0 },
    style: { background: '#8b5cf6', color: 'white', border: '2px solid #7c3aed' },
  },
  {
    id: '2',
    data: { label: 'Newton\'s Laws' },
    position: { x: 100, y: 100 },
    style: { background: '#3b82f6', color: 'white', border: '2px solid #2563eb' },
  },
  {
    id: '3',
    data: { label: 'Energy & Work' },
    position: { x: 400, y: 100 },
    style: { background: '#3b82f6', color: 'white', border: '2px solid #2563eb' },
  },
  {
    id: '4',
    data: { label: 'Momentum' },
    position: { x: 100, y: 200 },
    style: { background: '#10b981', color: 'white', border: '2px solid #059669' },
  },
  {
    id: '5',
    data: { label: 'Power' },
    position: { x: 400, y: 200 },
    style: { background: '#10b981', color: 'white', border: '2px solid #059669' },
  },
  {
    id: '6',
    type: 'output',
    data: { label: 'Master: Mechanics' },
    position: { x: 250, y: 300 },
    style: { background: '#f59e0b', color: 'white', border: '2px solid #d97706' },
  },
];

// Initial edges connecting the nodes
const initialEdges: Edge[] = [
  { id: 'e1-2', source: '1', target: '2', label: 'Choose', animated: true },
  { id: 'e1-3', source: '1', target: '3', label: 'Choose', animated: true },
  { id: 'e2-4', source: '2', target: '4', label: 'Learn' },
  { id: 'e3-5', source: '3', target: '5', label: 'Learn' },
  { id: 'e4-6', source: '4', target: '6', label: 'Complete' },
  { id: 'e5-6', source: '5', target: '6', label: 'Complete' },
];

const ReactFlowExample: React.FC = () => {
  const [nodes, setNodes, onNodesChange] = useNodesState(initialNodes);
  const [edges, setEdges, onEdgesChange] = useEdgesState(initialEdges);

  const onConnect = useCallback(
    (params: Connection) => setEdges((eds) => addEdge(params, eds)),
    [setEdges]
  );

  return (
    <Card className="w-full">
      <CardHeader>
        <CardTitle>React Flow Integration</CardTitle>
        <CardDescription>
          Interactive node diagrams for learning pathways and concept maps
        </CardDescription>
      </CardHeader>
      <CardContent>
        <div className="w-full h-[500px] border rounded-lg bg-gray-50">
          <ReactFlow
            nodes={nodes}
            edges={edges}
            onNodesChange={onNodesChange}
            onEdgesChange={onEdgesChange}
            onConnect={onConnect}
            fitView
            className="bg-white"
          >
            <Controls />
            <MiniMap
              nodeColor={(node) => {
                switch (node.type) {
                  case 'input':
                    return '#8b5cf6';
                  case 'output':
                    return '#f59e0b';
                  default:
                    return '#3b82f6';
                }
              }}
            />
            <Background variant={BackgroundVariant.Dots} gap={12} size={1} />
          </ReactFlow>
        </div>

        <div className="mt-6 grid grid-cols-1 md:grid-cols-2 gap-4">
          <div className="p-4 bg-blue-50 rounded-lg border border-blue-200">
            <h4 className="font-semibold mb-2">Features:</h4>
            <ul className="text-sm space-y-1">
              <li>✅ Drag and drop nodes</li>
              <li>✅ Create connections between nodes</li>
              <li>✅ Zoom and pan the canvas</li>
              <li>✅ Mini map for navigation</li>
              <li>✅ Custom node styling</li>
              <li>✅ Animated edges</li>
            </ul>
          </div>

          <div className="p-4 bg-purple-50 rounded-lg border border-purple-200">
            <h4 className="font-semibold mb-2">Use Cases:</h4>
            <ul className="text-sm space-y-1">
              <li>📚 Learning pathway visualization</li>
              <li>🔗 Concept maps</li>
              <li>🎯 Prerequisite tracking</li>
              <li>📊 Flow charts</li>
              <li>🧠 Knowledge graphs</li>
              <li>⚡ Decision trees</li>
            </ul>
          </div>
        </div>

        <div className="mt-4 p-4 bg-gray-50 rounded-lg border">
          <h4 className="font-semibold mb-2">Usage Example:</h4>
          <pre className="text-xs bg-white p-3 rounded border overflow-x-auto">
{`import ReactFlow, { useNodesState, useEdgesState } from 'reactflow';
import 'reactflow/dist/style.css';

const [nodes, setNodes, onNodesChange] = useNodesState(initialNodes);
const [edges, setEdges, onEdgesChange] = useEdgesState(initialEdges);

<ReactFlow
  nodes={nodes}
  edges={edges}
  onNodesChange={onNodesChange}
  onEdgesChange={onEdgesChange}
  fitView
/>`}
          </pre>
        </div>
      </CardContent>
    </Card>
  );
};

export default ReactFlowExample;
