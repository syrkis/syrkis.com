<!-- Works.svelte -->
<script lang="ts">
    import type { PageData } from "./types";
    import Tile from "$lib/comps/tile.svelte";

    export let data: PageData;
</script>

<section id="works">
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
</section>
