// routes/+page.server.ts

import type { PageServerLoad } from "./$types";
import { getAllGroups } from "$lib/data";

export const load: PageServerLoad = async () => {
  const groups = await getAllGroups();

  // Sort groups by date, newest first
  groups.sort((a, b) => {
    // Ensure we're dealing with valid Date objects
    const dateA = a.date instanceof Date ? a.date : new Date(a.date);
    const dateB = b.date instanceof Date ? b.date : new Date(b.date);

    return dateB.getTime() - dateA.getTime();
  });

  return {
    groups,
  };
};
