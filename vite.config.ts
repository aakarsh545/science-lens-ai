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
          // Simplified chunking to avoid circular dependencies
          if (id.includes('node_modules')) {
            // Put all React-related in one chunk
            if (id.includes('react') || id.includes('react-dom') || id.includes('react-router')) {
              return 'react-vendor';
            }
            // Put everything else in vendor
            return 'vendor';
          }
        },
      },
    },
    chunkSizeWarningLimit: 1000,
    minify: 'esbuild',
    target: 'es2020',
  },
}));
