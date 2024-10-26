// src/lib/stores.ts
import { writable } from "svelte/store";
import type { Series } from "$lib/types";

// Create a writable store for the series data
export const seriesStore = writable<Series[]>([]);
