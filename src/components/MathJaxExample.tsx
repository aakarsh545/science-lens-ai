import React from 'react';
import { MathJax, MathJaxContext } from 'better-react-mathjax';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from './ui/card';

/**
 * MathJaxExample Component
 *
 * Demonstrates mathematical formula rendering using MathJax
 * Useful for displaying complex mathematical expressions in lessons
 */

const mathJaxConfig = {
  tex: {
    inlineMath: [['$', '$'], ['\\(', '\\)']],
    displayMath: [['$$', '$$'], ['\\[', '\\]']],
    processEscapes: true,
    processEnvironments: true,
  },
  options: {
    skipHtmlTags: ['script', 'noscript', 'style', 'textarea', 'pre'],
    enableMenu: true,
  },
};

// Example mathematical formulas
const mathExamples = {
  quadratic: {
    title: 'Quadratic Formula',
    inline: 'The quadratic formula is $x = \\frac{-b \\pm \\sqrt{b^2 - 4ac}}{2a}$',
    display: '$$x = \\frac{-b \\pm \\sqrt{b^2 - 4ac}}{2a}$$',
    description: 'Used to solve quadratic equations of the form ax² + bx + c = 0',
  },
  pythagorean: {
    title: 'Pythagorean Theorem',
    inline: 'The Pythagorean theorem states $a^2 + b^2 = c^2$',
    display: '$$a^2 + b^2 = c^2$$',
    description: 'In a right-angled triangle, the square of the hypotenuse equals the sum of squares of the other two sides',
  },
  euler: {
    title: 'Euler\'s Identity',
    inline: 'Euler\'s identity is $e^{i\\pi} + 1 = 0$',
    display: '$$e^{i\\pi} + 1 = 0$$',
    description: 'Often cited as the most beautiful equation in mathematics',
  },
  integral: {
    title: 'Definite Integral',
    inline: 'The area under the curve is $\\int_{a}^{b} f(x) dx$',
    display: '$$\\int_{a}^{b} f(x) dx = F(b) - F(a)$$',
    description: 'Fundamental theorem of calculus',
  },
  derivative: {
    title: 'Chain Rule',
    inline: 'The chain rule: $\\frac{dy}{dx} = \\frac{dy}{du} \\cdot \\frac{du}{dx}$',
    display: '$$\\frac{d}{dx}[f(g(x))] = f\'(g(x)) \\cdot g\'(x)$$',
    description: 'Differentiation of composite functions',
  },
  matrix: {
    title: 'Matrix Multiplication',
    inline: 'Matrix product: $C = AB$',
    display: '$$C_{ij} = \\sum_{k=1}^{n} A_{ik}B_{kj}$$',
    description: 'Element-wise formula for matrix multiplication',
  },
};

export const MathJaxExample: React.FC = () => {
  return (
    <MathJaxContext config={mathJaxConfig}>
      <Card className="w-full">
        <CardHeader>
          <CardTitle>Mathematical Formula Examples</CardTitle>
          <CardDescription>
            Rendered using MathJax - perfect for science and math lessons
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-6">
          {(Object.entries(mathExamples) as [keyof typeof mathExamples, string][]).map(([key, example]) => (
            <div key={key} className="border-l-4 border-purple-500 pl-4 py-2">
              <h3 className="text-lg font-semibold mb-2">{example.title}</h3>
              <p className="text-sm text-gray-600 mb-2">{example.description}</p>
              <div className="space-y-2">
                <div className="text-sm">
                  <span className="font-medium">Inline: </span>
                  <MathJax inline>{example.inline}</MathJax>
                </div>
                <div>
                  <span className="font-medium text-sm">Display:</span>
                  <div className="my-2 p-3 bg-gray-50 rounded-lg">
                    <MathJax>{example.display}</MathJax>
                  </div>
                </div>
              </div>
            </div>
          ))}

          <div className="mt-6 p-4 bg-purple-50 rounded-lg border border-purple-200">
            <h4 className="font-semibold mb-2">Usage in Lessons:</h4>
            <pre className="text-xs bg-white p-3 rounded border overflow-x-auto">
{`import { MathJax, MathJaxContext } from 'better-react-mathjax';

<MathJaxContext config={mathJaxConfig}>
  <MathJax>
    Your formula here: $E = mc^2$
  </MathJax>
</MathJaxContext>`}
            </pre>
          </div>

          <div className="mt-4 p-4 bg-blue-50 rounded-lg border border-blue-200">
            <h4 className="font-semibold mb-2">LaTeX Quick Reference:</h4>
            <ul className="text-sm space-y-1">
              <li><code className="bg-blue-100 px-1 rounded">x^2</code> → superscript (x²)</li>
              <li><code className="bg-blue-100 px-1 rounded">x_2</code> → subscript (x₂)</li>
              <li><code className="bg-blue-100 px-1 rounded">\\frac{a}{b}</code> → fraction (a/b)</li>
              <li><code className="bg-blue-100 px-1 rounded">\\sqrt{x}</code> → square root (√x)</li>
              <li><code className="bg-blue-100 px-1 rounded">\\int</code> → integral (∫)</li>
              <li><code className="bg-blue-100 px-1 rounded">\\sum</code> → summation (Σ)</li>
            </ul>
          </div>
        </CardContent>
      </Card>
    </MathJaxContext>
  );
};

export default MathJaxExample;
