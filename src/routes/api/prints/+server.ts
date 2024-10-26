import { json } from "@sveltejs/kit";
import type { RequestHandler } from "./$types";
import { readPrints } from "$lib/utils";

export const GET: RequestHandler = async () => {
  try {
    const prints = await readPrints();
    return json(prints);
  } catch (error) {
    console.error("Error reading prints:", error);
    return json({ error: "Internal server error" }, { status: 500 });
  }
};
