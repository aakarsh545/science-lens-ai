import React, { useEffect, useRef } from 'react';
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  BarElement,
  ArcElement,
  Title,
  Tooltip,
  Legend,
  Filler,
} from 'chart.js';
import { Line, Bar, Doughnut } from 'react-chartjs-2';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from './ui/card';

// Register Chart.js components
ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  BarElement,
  ArcElement,
  Title,
  Tooltip,
  Legend,
  Filler
);

/**
 * ChartExample Component
 *
 * Demonstrates data visualization using Chart.js
 * Useful for displaying learning progress, quiz results, and scientific data
 */

// Example data
const lineChartData = {
  labels: ['Week 1', 'Week 2', 'Week 3', 'Week 4', 'Week 5', 'Week 6'],
  datasets: [
    {
      label: 'Learning Progress',
      data: [20, 35, 45, 60, 75, 85],
      borderColor: 'rgb(139, 92, 246)',
      backgroundColor: 'rgba(139, 92, 246, 0.1)',
      tension: 0.4,
      fill: true,
    },
    {
      label: 'Quiz Scores',
      data: [65, 72, 68, 80, 85, 92],
      borderColor: 'rgb(59, 130, 246)',
      backgroundColor: 'rgba(59, 130, 246, 0.1)',
      tension: 0.4,
      fill: true,
    },
  ],
};

const barChartData = {
  labels: ['Physics', 'Chemistry', 'Biology', 'Math', 'Earth Science'],
  datasets: [
    {
      label: 'Topics Completed',
      data: [12, 8, 15, 10, 6],
      backgroundColor: [
        'rgba(139, 92, 246, 0.8)',
        'rgba(59, 130, 246, 0.8)',
        'rgba(16, 185, 129, 0.8)',
        'rgba(251, 146, 60, 0.8)',
        'rgba(239, 68, 68, 0.8)',
      ],
      borderColor: [
        'rgb(139, 92, 246)',
        'rgb(59, 130, 246)',
        'rgb(16, 185, 129)',
        'rgb(251, 146, 60)',
        'rgb(239, 68, 68)',
      ],
      borderWidth: 2,
    },
  ],
};

const doughnutChartData = {
  labels: ['Completed', 'In Progress', 'Not Started'],
  datasets: [
    {
      data: [45, 30, 25],
      backgroundColor: [
        'rgba(16, 185, 129, 0.8)',
        'rgba(251, 146, 60, 0.8)',
        'rgba(209, 213, 219, 0.8)',
      ],
      borderColor: [
        'rgb(16, 185, 129)',
        'rgb(251, 146, 60)',
        'rgb(209, 213, 219)',
      ],
      borderWidth: 2,
    },
  ],
};

const chartOptions = {
  responsive: true,
  maintainAspectRatio: true,
  plugins: {
    legend: {
      position: 'top' as const,
    },
    title: {
      display: true,
      text: 'Learning Analytics Dashboard',
    },
  },
  scales: {
    y: {
      beginAtZero: true,
      max: 100,
    },
  },
};

const barOptions = {
  responsive: true,
  maintainAspectRatio: true,
  plugins: {
    legend: {
      display: false,
    },
    title: {
      display: true,
      text: 'Topics Completed by Subject',
    },
  },
  scales: {
    y: {
      beginAtZero: true,
    },
  },
};

const doughnutOptions = {
  responsive: true,
  maintainAspectRatio: true,
  plugins: {
    legend: {
      position: 'right' as const,
    },
    title: {
      display: true,
      text: 'Course Completion Status',
    },
  },
};

export const ChartExample: React.FC = () => {
  return (
    <div className="space-y-6">
      <Card>
        <CardHeader>
          <CardTitle>Chart.js Integration Examples</CardTitle>
          <CardDescription>
            Data visualization for learning analytics and scientific data
          </CardDescription>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <div className="p-4 border rounded-lg">
              <h3 className="text-lg font-semibold mb-4">Line Chart - Progress Over Time</h3>
              <Line data={lineChartData} options={chartOptions} />
            </div>

            <div className="p-4 border rounded-lg">
              <h3 className="text-lg font-semibold mb-4">Bar Chart - Topics by Subject</h3>
              <Bar data={barChartData} options={barOptions} />
            </div>

            <div className="p-4 border rounded-lg lg:col-span-2">
              <h3 className="text-lg font-semibold mb-4">Doughnut Chart - Completion Status</h3>
              <div className="flex justify-center">
                <div style={{ maxWidth: '400px', width: '100%' }}>
                  <Doughnut data={doughnutChartData} options={doughnutOptions} />
                </div>
              </div>
            </div>
          </div>

          <div className="mt-6 p-4 bg-purple-50 rounded-lg border border-purple-200">
            <h4 className="font-semibold mb-2">Usage Example:</h4>
            <pre className="text-xs bg-white p-3 rounded border overflow-x-auto">
{`import { Line, Bar, Doughnut } from 'react-chartjs-2';
import { Chart as ChartJS, registerables } from 'chart.js';

ChartJS.register(...ChartJS.registerables);

<Line data={chartData} options={chartOptions} />`}
            </pre>
          </div>
        </CardContent>
      </Card>
    </div>
  );
};

export default ChartExample;
