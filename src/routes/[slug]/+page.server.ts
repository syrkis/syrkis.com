// routes/[slug]/+page.server.ts

import { error } from "@sveltejs/kit";
import type { PageServerLoad } from "./$types";
import { getGroup, getWorksByGroup } from "$lib/data";

export const load: PageServerLoad = async ({ params }) => {
  const { slug } = params;

  const group = await getGroup(slug);
  if (!group) {
    throw error(404, "Group not found");
  }

  const works = await getWorksByGroup(slug);

  return {
    group,
    works,
  };
};
