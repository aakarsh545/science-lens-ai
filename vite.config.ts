import { defineConfig } from "vite";
import react from "@vitejs/plugin-react-swc";
import path from "path";
import { componentTagger } from "lovable-tagger";

// https://vitejs.dev/config/
export default defineConfig(({ mode }) => ({
  base: '/',
  server: {
    host: "::",
    port: 8080,
  },
  plugins: [react(), mode === "development" && componentTagger()].filter(Boolean),
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
    dedupe: ['react', 'react-dom'],
  },
  build: {
    rollupOptions: {
      output: {
        manualChunks(id) {
          // Split vendor chunks more granularly to avoid circular dependencies
          if (id.includes('node_modules')) {
            if (id.includes('react') || id.includes('react-dom') || id.includes('react-router')) {
              return 'react-vendor';
            }
            // Supabase
            if (id.includes('@supabase')) {
              return 'supabase-vendor';
            }
            // UI libraries
            if (id.includes('framer-motion')) {
              return 'framer-motion-vendor';
            }
            if (id.includes('lucide-react')) {
              return 'lucide-vendor';
            }
            // Radix UI components
            if (id.includes('@radix-ui')) {
              return 'radix-vendor';
            }
            if (id.includes('jspdf')) {
              return 'pdf-export';
            }
            // Class variance authority
            if (id.includes('class-variance-authority') || id.includes('clsx') || id.includes('tailwind-merge')) {
              return 'cva-vendor';
            }
            // Other node_modules - split by package to avoid circular deps
            const match = id.match(/node_modules\/([^/]+)/);
            if (match) {
              return `vendor-${match[1].replace('@', '')}`;
            }
            return 'vendor';
          }
        },
        // Improve module format to avoid circular dependencies
        interop: 'auto',
      },
      // Experimental features to help with circular dependencies
      onwarn(warning, warn) {
        // Ignore circular dependency warnings for node_modules
        if (warning.code === 'CIRCULAR_DEPENDENCY' && warning.message.includes('node_modules')) {
          return;
        }
        warn(warning);
      },
    },
    chunkSizeWarningLimit: 1000,
    minify: 'esbuild',
    target: 'es2020',
  },
}));
