<!-- routes/+page.svelte -->
<script lang="ts">
    import type { PageData } from "./$types";
    import Tile from "$lib/comps/Tile.svelte";
    import { fly } from "svelte/transition";

    export let data: PageData;

    function formatDate(date: Date | string) {
        const d = date instanceof Date ? date : new Date(date);
        return d.toLocaleDateString("en-US", {
            year: "numeric",
            month: "long",
            day: "numeric",
        });
    }
</script>

<div class="tiles">
    {#if data.groups && data.groups.length > 0}
        {#each data.groups as group, index}
            <div class="tile" style="--delay: {index * 0.1}s">
                <a href={`/${group.slug}`}>
                    <Tile {group} />
                </a>
            </div>
        {/each}
    {:else}
        <p>No groups found.</p>
    {/if}
</div>

<style>
    .tile {
        padding: 10vh 0;
        /* opacity: 0; */
        transform: translateY(80vh);
        animation: slideIn 1s ease-in-out forwards;
        animation-delay: var(--delay);
    }
    .tiles {
        padding: 10vh 0;
    }

    @keyframes slideIn {
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
</style>
