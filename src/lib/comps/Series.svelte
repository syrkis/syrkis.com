<script lang="ts">
    import type { Series } from "$lib/types";
    import ColorThief from "colorthief";
    import { page } from "$app/stores";

    // Declare reactive state for series and translation
    let series = $state<Series[]>([]);

    // Fetch series data and update translateY on successful fetch
    $effect(() => {
        fetch("/api/series")
            .then((response) => response.json())
            .then((data: unknown) => {
                if (Array.isArray(data)) {
                    series = data as Series[];

                } else {
                    throw new Error("Received data is not an array");
                }
            })
            .catch((error) => {
                console.error("Error fetching series data:", error);
            });
    });

    $inspect(series); // For debugging during development

    const isRootRoute = $page.url.pathname === "/";

    // export let series: Series[];
    function getContrastColor(rgb: [number, number, number]): string {
        const [r, g, b] = rgb;
        const brightness = Math.round((r * 299 + g * 587 + b * 114) / 1000);
        return brightness > 200 ? "black" : "white";
    }
</script>

<div class="container" >
    <div class="series-container">
        {#each series as group (group.slug)}
            <div class="slider">
                <a href="/{isRootRoute  ? 'works' : group.slug}" class="series-tile">
                    <img
                        src={group.image}
                        alt={group.title}
                        class="series-image"
                        onload={async (event) => {
                            const img = event.target as HTMLImageElement;
                            const colorThief = new ColorThief();
                            const color = await colorThief.getColor(img);
                            const textColor = getContrastColor(color);
                            (img.parentElement as HTMLElement).style.setProperty('--text-color', textColor);
                        }}
                        crossorigin="anonymous"
                    />
                    <div class="series-title" style="color: var(--text-color);">
                        {#if group.prefix}
                            {group.prefix}
                        {/if}
                        <h2>{group.title}</h2>
                        {#if group.suffix}
                            {group.suffix}
                        {/if}
                    </div>
                </a>
            </div>
        {/each}
    </div>
</div>

<style>
    .slider {
        padding: 10vh 0;
        font-size: 1.5rem;
    }
    .series-container {
        display: flex;
        flex-direction: column;
        gap: 1rem;
        padding: 1rem;
        width: 85vw;
        margin: 0 auto;
    }

    .series-tile {
        text-transform: uppercase;
        width: 100%;
        height: 80vh;
        /* aspect-ratio: 16 / 9; */
        border-radius: 20px;
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        overflow: hidden;
        position: relative;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        text-decoration: none;
        transition: transform 1s ease-out, color 0.5s ease-in-out;
        /* Add a transition for the transform property */
    }

    /* Add a hover effect for the series-tile */
    .series-tile:hover {
        transform: scale(1.02); /* Scales the tile to 105% of its original size */
    }

    .series-image {
        width: 100%;
        height: 100%;
        object-fit: cover;
        position: absolute;
        top: 0;
        left: 0;
    }

    .series-title {
        position: relative;
        z-index: 1;
        color: inherit;
    }
</style>
