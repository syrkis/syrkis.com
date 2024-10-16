<!-- routes/+page.svelte -->

<script lang="ts">
    import type { PageData } from "./$types";
    import Tile from "$lib/comps/tile.svelte";

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

<h1>All Groups</h1>

<div class="tiles">
    {#if data.groups && data.groups.length > 0}
        {#each data.groups as group}
            <div class="tile">
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
    }
    .tiles {
        padding-top: 10vh;
    }
</style>
