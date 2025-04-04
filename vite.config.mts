import { defineConfig } from "vite"
import RubyPlugin from "vite-plugin-ruby"
import FullReload from "vite-plugin-full-reload"
import StimulusHRM from "vite-plugin-stimulus-hmr"
import autoprefixer from 'autoprefixer'

export default defineConfig({
  plugins: [
    RubyPlugin(),
    FullReload(["config/routes.rb", "app/views/**/*"], { delay: 200 }),
    StimulusHRM()
  ],
  css: {
    postcss: {
      plugins: [
        autoprefixer({}) 
      ],
    }
  }
})
