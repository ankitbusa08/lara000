import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import react from '@vitejs/plugin-react';

export default defineConfig({
    plugins: [
        laravel({
            input: 'resources/js/app.jsx',
            refresh: true,
        }),
        react(),
    ],
    server: {
        host: '0.0.0.0', // Ensure the server uses an IPv4 address
        port: 5173,
        strictPort: true, // Fail if the port is already in use
        hmr: {
            host: 'localhost',
            port: 5173,
        },
    },
});
