<script lang="ts">
    import type { Series, Print } from "$lib/types";
    export let print: Print;
    export let series: Series;

    const basePrice = 1000;
    const framingPrice = 500;

    let stochasticPrice = 0;

    function formatPrice(price: number): string {
        return price.toLocaleString("en-US", {
            minimumFractionDigits: 2,
            maximumFractionDigits: 2,
        });
    }
    function generateBillNumber(seriesSlug: string, printSlug: string): number {
        const combined = `${seriesSlug}-${printSlug}`;
        let hash = 0;
        for (let i = 0; i < combined.length; i++) {
            const char = combined.charCodeAt(i);
            hash = (hash << 5) - hash + char;
            hash = hash & hash;
        }
        return Math.abs(hash % 10000) + 1;
    }

    const billNumber = generateBillNumber(series.slug, print.slug);

    const currentDate = new Date().toLocaleDateString("en-GB", {
        day: "numeric",
        month: "long",
        year: "numeric",
    });
</script>

<div class="purchase-container">
    <div class="header-row">
        <span>Art Transfer Document</span>
        <span> № {billNumber} | {currentDate}</span>
    </div>

    <div class="content">
        <div class="seller">Noah Syrkis · Virian ApS · CVR 42950457 · København</div>

        <!-- <div class="artwork-details"> -->
        <!-- {print.title} · {series.material} -->
        <!-- </div> -->

        <div class="pricing">
            <div class="price-row">
                <span>Stochastic Price Increase</span>
                <span class="input-container">
                    € <input type="number" bind:value={stochasticPrice} min="0" step="100" class="price-input" />
                </span>
            </div>
            <div class="price-row">
                <span>Edition 4 out of {series.editions} of {print.title}</span>
                <span>€ {formatPrice(basePrice)}</span>
            </div>
            <div class="price-row">
                <span>Hand Crafted Float Framing in Hazelnut</span>
                <span>€ {formatPrice(framingPrice)}</span>
            </div>
            <div class="price-row total">
                <span>Total</span>
                <span>€ {formatPrice(basePrice + framingPrice + stochasticPrice)}</span>
            </div>
        </div>

        <div class="terms">
            Includes certificate of authenticity, worldwide shipping and insurance. Signed and numbered by the artist.
        </div>
        <!--
        <button class="apple-pay-button">
            <span>Buy with</span>
            <span class="apple-pay-text">Apple Pay</span>
        </button> -->
    </div>
</div>

<style>
    .purchase-container {
        max-width: 95%;
        width: 666px;
        margin: auto;
        /* padding: 1.5rem; */
        /* border: 1px solid #000; */
        border-radius: 2px;
        background-color: #fff;
        letter-spacing: 0.02em;
    }

    .header-row {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 1.5rem;
    }

    .content {
        display: flex;
        flex-direction: column;
        gap: 1.5rem;
    }

    .seller,
    .artwork-details {
        font-size: 1rem;
        color: #000;
    }

    .pricing {
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
        text-align: justify;
    }

    .price-row {
        display: flex;
        justify-content: space-between;
        /* font-size: 1rem; */
        line-height: 1.5;
    }

    .total {
        border-top: 1px solid #000;
        padding-top: 0.5rem;
    }

    .terms {
        font-size: 1rem;
        color: #333;
    }

    .apple-pay-button {
        -webkit-appearance: -apple-pay-button;
        -apple-pay-button-type: buy;
        -apple-pay-button-style: black;
        height: 45px;
        width: 100%;
        border: none;
        margin-top: 0.5rem;
    }

    @supports not (-webkit-appearance: -apple-pay-button) {
        .apple-pay-button {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 0.5rem;
            background: #000;
            color: #fff;
            border-radius: 4px;
            cursor: pointer;
        }

        .apple-pay-text {
            font-family: -apple-system, BlinkMacSystemFont, sans-serif;
        }
    }
    @media (max-width: 768px) {
        .purchase-container {
            font-size: 0.9em;
        }
        .header-row {
            font-size: 0.9em;
        }
        .content {
            font-size: 0.9em;
        }
    }

    .price-input {
        width: 80px;
        margin-left: 4px;
        border: none;
        border-bottom: 1px solid #000;
        padding: 2px 4px;
        text-align: right;
        font-family: inherit;
        font-size: inherit;
        -moz-appearance: textfield; /* Firefox */
    }

    .price-input::-webkit-outer-spin-button,
    .price-input::-webkit-inner-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }

    .price-input:focus {
        outline: none;
        border-bottom: 2px solid #000;
    }
</style>
