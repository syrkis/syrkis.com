import fs from "node:fs/promises";
import path from "node:path";
import matter from "gray-matter";

export async function getGroup(slug: string) {
  try {
    const filePath = path.join(process.cwd(), "data", "group", `${slug}.md`);
    const fileContents = await fs.readFile(filePath, "utf-8");
    const { data } = matter(fileContents);
    return data;
  } catch (error) {
    console.error(`Error reading group file: ${error}`);
    return null;
  }
}

export async function getWorksByGroup(groupSlug: string) {
  try {
    const dirPath = path.join(process.cwd(), "data", "works", groupSlug);
    const files = await fs.readdir(dirPath);
    const works = await Promise.all(
      files
        .filter((file) => file.endsWith(".md"))
        .map(async (file) => {
          const filePath = path.join(dirPath, file);
          const fileContents = await fs.readFile(filePath, "utf-8");
          const { data } = matter(fileContents);
          return data;
        }),
    );
    return works;
  } catch (error) {
    console.error(`Error reading works: ${error}`);
    return [];
  }
}
// $lib/data.ts

export async function getAllGroups() {
  try {
    const dirPath = path.join(process.cwd(), "data", "group");
    const files = await fs.readdir(dirPath);
    const groups = await Promise.all(
      files
        .filter((file) => file.endsWith(".md"))
        .map(async (file) => {
          const filePath = path.join(dirPath, file);
          const fileContents = await fs.readFile(filePath, "utf-8");
          const { data } = matter(fileContents);
          return {
            ...data,
            date: new Date(data.date),
            slug: path.parse(file).name, // Add this line to include the slug
          };
        }),
    );
    return groups;
  } catch (error) {
    console.error(`Error reading groups: ${error}`);
    return [];
  }
}
