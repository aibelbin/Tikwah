import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';

const usePolling =
	process.env.VITE_USE_POLLING === 'true' ||
	process.env.CHOKIDAR_USEPOLLING === 'true' ||
	process.env.CI === 'true';

export default defineConfig({
	plugins: [sveltekit()],
	server: {
		watch: {
			usePolling,
			interval: 200
		}
	}
});
