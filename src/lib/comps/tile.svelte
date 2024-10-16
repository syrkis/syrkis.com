<script lang="ts">
    import { onMount, afterUpdate } from "svelte";
    import VanillaTilt from "vanilla-tilt";
    import ColorThief from "colorthief";
    import type { Group } from "$lib/types";

    type TiltElement = HTMLElement & {
        vanillaTilt?: {
            destroy: () => void;
        };
    };

    export let group: Group;

    let textColor = "white"; // Default color
    let tiltElement: TiltElement;

    function initTilt() {
        if (tiltElement) {
            VanillaTilt.init(tiltElement, {
                max: 2,
                scale: 1.03,
                speed: 1000,
                reverse: true,
            });
        }
    }

    onMount(() => {
        // Color extraction
        const img = new Image();
        img.crossOrigin = "Anonymous";
        img.src = group.image;

        img.onload = () => {
            const colorThief = new ColorThief();
            const getColorResult = colorThief.getColor(img);

            const processColor = (color: [number, number, number]) => {
                textColor = getContrastColor(color);
            };

            if (getColorResult instanceof Promise) {
                getColorResult.then(processColor).catch((err) => {
                    console.error("Error getting color:", err);
                });
            } else {
                processColor(getColorResult);
            }
        };

        return () => {
            tiltElement?.vanillaTilt?.destroy();
        };
    });

    afterUpdate(() => {
        initTilt();
    });

    function getContrastColor(rgb: [number, number, number]): string {
        const [r, g, b] = rgb;
        const brightness = Math.round((r * 299 + g * 587 + b * 114) / 1000);
        return brightness > 200 ? "black" : "white";
    }
</script>

<div
    bind:this={tiltElement}
    class="js-tilt bg"
    style="
        transform-style: preserve-3d;
        transform: perspective(1000px);
        background: black;
        background-image: url({group.image});
        background-size: cover;
        background-position: center;
        "
>
    <div class="inner">
        <div class="text" style="color: {textColor};">
            {#if group.prefix}
                <p class="meta">{group.prefix}</p>
            {/if}
            <h2>{group.title}</h2>
            {#if group.suffix}
                <p class="meta">{group.suffix}</p>
            {/if}
        </div>
    </div>
</div>

<style>
    .text {
        position: relative;
        z-index: 1;
    }
    .js-tilt {
        text-align: center;
        margin: 15vh 0;
        transform-style: preserve-3d;
    }

    .meta {
        font-weight: 100;
    }

    .inner {
        transform: translateZ(100px);
        margin: 0;
        letter-spacing: 0.15em;
        text-transform: uppercase;
        /* font-style: none; */
        font-weight: regular;
        font-size: 1.2em;
        line-height: 2.5em;
    }

    .bg {
        width: 90vw;
        margin: auto;
        height: 80vh;
        border-radius: 25px;
        display: flex;
        align-items: center;
        box-shadow:
            0 -4px 30px 2px rgba(0, 0, 0, 0.2),
            0 -8px 40px 2px rgba(0, 0, 0, 0.19);
        justify-content: center;
    }
</style>
