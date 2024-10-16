<!-- routes/[slug]/+page.svelte -->

<script lang="ts">
    import type { PageData } from "./$types";

    export let data: PageData;
</script>

<h1>Group: {data.group.title}</h1>

<h2>Group Details:</h2>
<pre>{JSON.stringify(data.group, null, 2)}</pre>

<h2>Works in this group:</h2>
{#if data.works && data.works.length > 0}
    {#each data.works as work}
        <div>
            <h3>{work.title}</h3>
            <pre>{JSON.stringify(work, null, 2)}</pre>
        </div>
    {/each}
{:else}
    <p>No works found in this group.</p>
{/if}

<style>
    pre {
        background-color: #f4f4f4;
        padding: 10px;
        border-radius: 5px;
        white-space: pre-wrap;
        word-wrap: break-word;
    }
</style>
