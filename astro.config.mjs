// @ts-check
import { defineConfig } from "astro/config";
import { typst } from "astro-typst";
import path from "node:path";

import sitemap from "@astrojs/sitemap";

import node from "@astrojs/node";

import netlify from "@astrojs/netlify";

export default defineConfig({
  site: "https://syrkis.com",

  integrations: [
    typst({
      target: () => "svg",
      fontArgs: [{ fontPaths: [path.resolve("public/fonts")] }],
    }),
    sitemap(),
  ],

  adapter: netlify(),
});
