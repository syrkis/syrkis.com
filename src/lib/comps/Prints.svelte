<script lang="ts">
    import type { Print, Series } from "$lib/types";

    const { slug } = $props<{ slug: string }>();

    let seriesData = $state<{ series: Series; prints: Print[] } | null>(null);

    $effect(() => {
        Promise.all([
            fetch(`/api/series/${slug}`).then((r) => r.json() as Promise<Series>),
            fetch(`/api/prints/${slug}`).then((r) => r.json() as Promise<Print[]>),
        ])
            .then(([series, prints]) => {
                seriesData = { series, prints };
            })
            .catch((error) => {
                console.error("Error fetching data:", error);
                seriesData = null;
            });
    });
</script>

<div class="container">
    {#if seriesData}
        <div class="description text">
            <p>{seriesData.series.description}</p>
        </div>
        {#if seriesData.prints.length > 0}
            <div class="prints-container">
                {#each seriesData.prints as print}
                    <div class="print-item">
                        {#if print.image}
                            <img src={print.image} alt={print.title} class="print-image" />
                        {/if}
                        <div class="print-info">
                            <p>{print.title}, {seriesData.series.material}</p>
                        </div>
                    </div>
                {/each}
            </div>
        {:else}
            <p>No prints found in this series.</p>
        {/if}
    {:else}
        <p>Loading series information...</p>
    {/if}
</div>

<style>
    .prints-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 2rem;
        /* padding: 2rem 1rem; */
        padding: 15vh 0;
    }

    .print-item {
        text-align: center;
        width: 100%;
        width: 80%;
        padding: 10vh 0;
    }

    .print-image {
        width: 100%;
        height: auto;
    }

    .print-info p {
        padding: 20px 0;
        margin: 0;
        font-size: 1em;
    }
</style>
