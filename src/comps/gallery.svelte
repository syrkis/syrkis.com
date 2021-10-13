<script>
    export let project;
    export let text;
    import { onMount } from 'svelte';


    let baseurl = "https://syrkis.ams3.cdn.digitaloceanspaces.com"
    let data = "";
    let works = "";

    onMount(async () => {
        data = await fetch(`/${project.toLowerCase()}.json`).then(x => x.json());
        works = data.works;
    });

    text = `${text} Limited edition prints can be bought through <a href='mailto:contact@syrkis.com'>email</a>. Proceeds go to the development of the <a href="https://virian.org" target=_blank>Virian Project</a>.`

</script>

<div class='wrapper'>
    <div class='description'><p>{@html text}</p></div>
    <div>
        {#await works then works}
            {#each works as work, i}
                <div>
                    <img src="{baseurl}/{project.toLowerCase()}/{work.file}.jpg" />
                </div>
                <div class="tagline">
                    <i>{work.title}</i>, {data.project} {i + 1}, {data.year}, {data.dims}
                </div>
            {/each}
        {/await}
    </div>
</div>

<svelte:head>
    <title>{project} | Noah Syrkis</title>
</svelte:head>

<style>

    .description {
        text-align: justify;
        text-align-last: center;
        max-width: 600px;
        margin:auto;
    }

    .tagline {
        text-align: center; 
        padding-top: 5vh;
    }

    img {
        width: 100%;
        height: 100%;
        max-width: 90vw;
        padding-top: 20vh;
        margin: auto;
        display: block;
    }

    .wrapper {
        padding-bottom: 10vh;
    }

</style>
