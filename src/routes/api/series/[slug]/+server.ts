import { json } from "@sveltejs/kit";
import type { RequestHandler } from "./$types";
import { readSeries } from "$lib/utils";

export const GET: RequestHandler = async ({ params }) => {
  const { slug } = params;

  try {
    const allSeries = await readSeries();
    const series = allSeries.find((s) => s.slug === slug);

    if (!series) {
      return json({ error: "Series not found" }, { status: 404 });
    }

    return json(series);
  } catch (error) {
    console.error(`Error reading series ${slug}:`, error);
    return json({ error: "Internal server error" }, { status: 500 });
  }
};
