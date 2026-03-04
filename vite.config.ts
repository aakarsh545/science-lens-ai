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
      "lottie-web": "lottie-web/build/player/lottie_light",
    },
  },
  define: {
    'import.meta.env.VITE_SUPABASE_URL': JSON.stringify(process.env.VITE_SUPABASE_URL || "https://pfrmkmlstzjexccmdkoc.supabase.co"),
    'import.meta.env.VITE_SUPABASE_PUBLISHABLE_KEY': JSON.stringify(process.env.VITE_SUPABASE_PUBLISHABLE_KEY || "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBmcm1rbWxzdHpqZXhjY21ka29jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTkxNzE2MzksImV4cCI6MjA3NDc0NzYzOX0.b0mjj8CS604Y38Pf1iQefrBz59pV0yEl3sCewGe4DmA"),
  },
  build: {
    sourcemap: true,
    minify: 'esbuild',
    target: 'es2020',
    chunkSizeWarningLimit: 6000,
  },
  optimizeDeps: {
    include: ['better-react-mathjax'],
  },
}));
