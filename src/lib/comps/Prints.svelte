<script lang="ts">
    import Mollie from "$lib/comps/Mollie.svelte";
    import type { Print, Series } from "$lib/types";

    const { slug } = $props<{ slug: string }>();

    let seriesData = $state<{ series: Series; prints: Print[] } | null>(null);
    let selectedPrint: Print | null = $state(null);

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

    function handlePrintClick(print: Print) {
        selectedPrint = selectedPrint === print ? null : print;
    }
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
                        <!-- Click handler on the content div -->
                        <div class="print-content" on:click={() => handlePrintClick(print)}>
                            {#if print.image}
                                <img src={print.image} alt={print.title} class="print-image" />
                            {/if}
                            <div class="print-info">
                                <p>
                                    {print.title}, {seriesData.series.material}
                                </p>
                            </div>
                        </div>

                        <!-- Mollie component shows only when this print is selected -->
                        {#if selectedPrint === print}
                            <div class="purchase-section">
                                <Mollie {print} series={seriesData.series} />
                            </div>
                        {/if}
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
        padding: 15vh 0;
    }

    .print-item {
        text-align: center;
        width: 80%;
        padding: 10vh 0;
    }

    .print-content {
        cursor: pointer;
    }

    .print-image {
        width: 100%;
        height: auto;
        max-width: 80vw;
        max-height: 90vh;
        object-fit: contain;
    }

    .print-info {
        padding: 20px 0;
        margin: 0;
        font-size: 1em;
    }

    .purchase-section {
        margin-top: 2rem;
    }
</style>
