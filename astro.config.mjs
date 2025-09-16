// @ts-check
import { defineConfig } from "astro/config";
import { typst } from "astro-typst";

import netlify from "@astrojs/netlify";
import sitemap from "@astrojs/sitemap";

export default defineConfig({
  site: "https://syrkis.com",
  integrations: [
    typst({
      target: () => "svg",
      fontArgs: [{ fontPaths: ["src/assets/fonts"] }],
    }),
    sitemap(),
  ],
  adapter: netlify(),
});
