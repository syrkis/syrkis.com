<!-- routes/[slug]/+page.svelte -->

<script lang="ts">
    import type { PageData } from "./$types";

    export let data: PageData;
</script>

<div class="header">
    <!-- <h1>{data.group.title}</h1> -->
    <div class="description">
        <span>{data.group.description}</span>
    </div>
</div>

{#each data.works as work}
    <div>
        <img src={work.image} alt={work.title} />
        <div class="tagline">
            <h3>{work.title}</h3>
        </div>
    </div>
{/each}

<style>
    .description {
        text-align: center;
        padding-top: 10vh;
        width: 600px;
        max-width: 90vw;
        margin: auto;
    }
    .tagline {
        text-align: center;
    }
    h3 {
        font-weight: 100;
    }
    .header {
        padding: 28vh 0 16vh 0;
        text-align: center;
    }
    img {
        width: 100%;
        height: 100%;
        max-width: 90vw;
        padding-top: 20vh;
        margin: auto;
        display: block;
    }
</style>
