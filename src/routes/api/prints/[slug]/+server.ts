import { json } from "@sveltejs/kit";
import type { RequestHandler } from "./$types";
import { readPrints } from "$lib/utils";

export const GET: RequestHandler = async ({ params, url }) => {
  const { slug } = params;
  const printSlug = url.searchParams.get("print");

  try {
    const prints = await readPrints();

    if (printSlug) {
      // Looking for a specific print
      const print = prints.find((p) => p.series === slug && p.slug === printSlug);
      if (!print) {
        return json({ error: "Print not found" }, { status: 404 });
      }
      return json(print);
    }

    // Looking for all prints in a series
    const seriesPrints = prints.filter((p) => p.series === slug);
    if (seriesPrints.length === 0) {
      return json({ error: "Series not found" }, { status: 404 });
    }
    return json(seriesPrints);
  } catch (error) {
    console.error("Error reading prints:", error);
    return json({ error: "Internal server error" }, { status: 500 });
  }
};
