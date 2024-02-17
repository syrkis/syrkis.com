<script>
    export let project;
    export let text;
    import { onMount } from 'svelte';


    let baseurl = "https://syrkis.ams3.digitaloceanspaces.com/noah"
    let data = "";
    let works = "";

    onMount(async () => {
        data = await fetch(`dirs/${project.toLowerCase()}.json`).then(x => x.json());
        works = data.works;
    });

    let salesText = `Limited edition prints of five can be bought for $3,000 (click image to buy). All proceeds go to <a href="https://virian.org" target=_blank>Virian</a>.`
</script>

<div>
<div class='wrapper'>
    <div class='description'>
        {#if data.for_sale}
            <p>{@html text}</p>
            <!--{@html salesText}</p>-->
        {:else}
            <p>{@html text}</p>
        {/if}
    </div>
    <div>
        {#await works then works}
            {#each works as work, i}
                <div>
                        {#if data.for_sale}
                            <!--<a href={work['payment_url']} target="_blank" rel="noreferrer">-->
                                <img src="{baseurl}/{project.toLowerCase()}/{work.file}.jpg" alt="{work.title}, {data.project} {i + 1}" />
                            <!--</a>-->
                        {:else}
                            <img src="{baseurl}/{project.toLowerCase()}/{work.file}.jpg" alt="{work.title}, {data.project} {i + 1}" />
                        {/if}
                </div>
                <div class="tagline">
                    <i>{work.title}</i>, {data.project} {i + 1}, {data.year}, {data.dims}
                </div>
            {/each}
        {/await}
    </div>
    </div>
</div>

<svelte:head>
    <title>{project} | Noah Syrkis</title>
    <meta name="description" content="{text}" />
    <meta property="og:image" content="https://syrkis.ams3.cdn.digitaloceanspaces.com/noah/tiles/{project.toLowerCase()}.jpg" />
    <meta property="og:title" content="{project} | Noah Syrkis" />
    <meta property="og:url" content="https://syrkis.com/{project}" />
</svelte:head>

<style>
    #home {
        font-weight: bold;
        font-style: italic ;
        padding: 3rem;
        text-align: center;
    }

    .description {
        text-align: center;
        text-align-last: center;
        max-width: 600px;
        width: 90%;
        margin:auto;
        padding: 35vh 0 15vh 0;
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
