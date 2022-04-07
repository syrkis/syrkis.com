<script>
    import Tile from '../comps/tile.svelte';
    import { onMount } from 'svelte';

    let data = "";
    onMount(async () => {
        data = await fetch('/dirs/index.json').then(x => x.json());
    });

    let letters = "Noah Syrkis";/*.split("").sort(() => Math.random() - 0.5);*/

</script>

<div class='wrapper'>
    <div class='bg' />
        <h1>
            {#each letters as letter}
                {letter}
            {/each}
        </h1>
    <div class='tiles'>
        {#await data then projects}
            {#each projects as project}
                <div class='tile'>
                    <Tile bind:project={project} />
                </div>
            {/each}
        {/await}
    </div>
</div>

<svelte:head>
    <title>Noah Syrkis</title>
    <meta property="og:image" content="https://syrkis.ams3.cdn.digitaloceanspaces.com/noah/tiles/syrkis_com_thumb.png" />
    <meta property="og:title" content="Noah Syrkis" />
    <meta property="og:url" content="https://syrkis.com" />
</svelte:head>

<style>
    .tile {
        width: 90vw;
        margin:auto;
        padding: 10vh 0;
    }
    .bg {
        letter-spacing: 0.4em;
        height: 110vh;
        z-index: -1;
        position: absolute;
        background:linear-gradient(to top, rgba(255, 255, 255, 255) 0%, rgba(255, 255, 255, 0) 75%, rgba(0, 0, 0, 0) 100%), url('https://syrkis.ams3.cdn.digitaloceanspaces.com/noah/aurelian/bright.jpg');
        background-position: center;
        background-size: cover;
        width: 100%;
    }
    .wrapper {
        position: relative;
    }
</style>
