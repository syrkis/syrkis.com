<script>
    import Tile from "../comps/tile.svelte";
    import { onMount } from "svelte";
    import { goto } from "$app/navigation";

    let data = "";
    onMount(async () => {
        data = await fetch("/dirs/index.json").then((x) => x.json());
    });

    export function scrollToFirstTile() {
        const firstTile = document.getElementById("first-tile");
        if (firstTile) {
            firstTile.scrollIntoView({ behavior: "smooth" });
        }
    }
</script>

<div class="wrapper">
    <div class="tiles">
        {#each data as project, index}
            <div class="tile" id={index === 0 ? "works" : ""}>
                <Tile bind:project />
            </div>
        {/each}
    </div>
</div>

<svelte:head>
    <title>Noah Syrkis</title>
    <meta
        property="og:image"
        content="https://syrkis.ams3.cdn.digitaloceanspaces.com/noah/tiles/syrkis_com_thumb.png"
    />
    <meta property="og:title" content="Noah Syrkis" />
    <meta property="og:url" content="https://syrkis.com" />
</svelte:head>

<style>
    .tile {
        width: 90vw;
        margin: auto;
        padding: 10vh 0;
    }
    .wrapper {
        position: relative;
        padding-top: 20vh; /* Add this line to push the content down */
    }
</style>
