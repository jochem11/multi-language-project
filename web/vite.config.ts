import { defineConfig } from "vite";
import { nitroV2Plugin as nitro } from "@solidjs/vite-plugin-nitro-2";
import { solidStart } from "@solidjs/start/config";

export default defineConfig({
  plugins: [
    solidStart(),
    nitro({
      baseURL: "/",
    }),
  ],
  server: {
    host: "0.0.0.0",
    port: 3000,
    strictPort: true, // Prevents Vite from "jumping" to 5173 if 3000 is busy
    hmr: {
      clientPort: 3000,
    },
  },
});
