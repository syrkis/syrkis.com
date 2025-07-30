// 1. Import utilities from `astro:content`
import { defineCollection, z } from "astro:content";
// 2. Import loader(s)
import { glob, file } from "astro/loaders";

// 3. Define your collection(s)
const works = defineCollection({
    loader: glob({ pattern: "*.yaml", base: "./works" }),
    schema: z.object({
        title: z.string(),
        year: z.string().min(4).max(4),
        desc: z.string().min(10).max(200),
        cover: z.string(), // .url()
        material: z.string(),
        hidden: z.boolean().default(false),
        works: z.array(
            z.object({
                name: z.string().min(1).max(100),
                file: z.string(), // .url()
            }),
        ),
    }),
});

const talks = defineCollection({
    loader: glob({ pattern: "*.typ", base: "./talks" }),
    schema: z.object({
        title: z.string(),
        date: z.string(),
        hidden: z.boolean().default(false),
    }),
});

// 4. Export a single `collections` object to register your collection(s)
export const collections = { works, talks };
