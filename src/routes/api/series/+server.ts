import { json } from "@sveltejs/kit";
import type { RequestHandler } from "./$types";
import { readSeries } from "$lib/utils";

export const GET: RequestHandler = async () => {
  try {
    const series = await readSeries();
    return json(series);
  } catch (error) {
    console.error("Error reading series:", error);
    return json({ error: "Internal server error" }, { status: 500 });
  }
};
