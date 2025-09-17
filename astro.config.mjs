// @ts-check
import { defineConfig } from "astro/config";
import { typst } from "astro-typst";

import sitemap from "@astrojs/sitemap";

import node from "@astrojs/node";

export default defineConfig({
  site: "https://syrkis.com",

  integrations: [
    typst({
      target: () => "svg",
      fontArgs: [{ fontPaths: ["src/assets/fonts"] }],
    }),
    sitemap(),
  ],

  adapter: node({
    mode: "standalone",
  }),
});
