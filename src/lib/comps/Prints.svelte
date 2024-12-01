<script lang="ts">
    import Mollie from "$lib/comps/Mollie.svelte";
    import type { Print, Series } from "$lib/types";
    import { fade, slide } from "svelte/transition";

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
                        <button class="print-content" onclick={() => handlePrintClick(print)}>
                            {#if print.image}
                                <img src={print.image} alt={print.title} class="print-image" />
                            {/if}
                            <div class="print-info">
                                <p>
                                    {print.title}, {seriesData.series.material}
                                </p>
                            </div>
                        </button>

                        <!-- Mollie component shows only when this print is selected -->
                        {#if selectedPrint === print}
                            <div class="purchase-section" transition:slide>
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
    .print-content {
        all: unset;
        width: 100%;
        display: block;
    }

    .prints-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 2rem;
        padding: 15vh 0;
    }

    .print-item {
        text-align: center;
        /* width: 80%; */
        width: 100%;
        padding: 10vh 0;
    }

    .print-content {
        cursor: pointer;
    }

    .print-image {
        width: 100%;
        max-width: 80vw;
        max-height: 90vh;
        overflow: hidden;
        /* transtion on border and transform*/
        /* transition: all 1s ease-in-out; */
    }

    .print-image {
        width: 100%;
        height: 100%;
        object-fit: contain;
    }

    img {
        border-radius: 10px;
        transition: all 1s ease-in-out;
    }

    .print-image:hover {
        transform: scale(1.05);
    }

    .print-info {
        padding-top: 20px;
        margin: auto;
        font-size: 1em;
        max-width: 90%;
    }

    .purchase-section {
        margin-top: 2rem;
    }
    @media (max-width: 768px) {
        .print-info {
            font-size: 0.8em;
        }
    }
</style>
