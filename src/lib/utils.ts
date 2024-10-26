import { readFile, readdir } from "node:fs/promises";
import { join } from "node:path";
import matter from "gray-matter";
import type { Series, Print } from "$lib/types";

async function readData<T>(dir: string, sortFunction?: (a: T, b: T) => number): Promise<T[]> {
  const dataDir = join(process.cwd(), "data", dir);
  const files = await readdir(dataDir);
  const dataArray = await Promise.all(
    files
      .filter((file) => file.endsWith(".md"))
      .map(async (file) => {
        const content = await readFile(join(dataDir, file), "utf-8");
        const { data } = matter(content);
        return data as T;
      }),
  );

  if (sortFunction) {
    dataArray.sort(sortFunction);
  }

  return dataArray;
}

export const readPrints = () => readData<Print>("prints");

// Sort series by date property
export const readSeries = () =>
  readData<Series>("series", (a, b) => {
    const dateA = new Date(a.date);
    const dateB = new Date(b.date);
    return dateB.getTime() - dateA.getTime();
  });
