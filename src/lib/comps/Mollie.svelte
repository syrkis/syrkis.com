<script lang="ts">
    import type { Series, Print } from "$lib/types";
    export let print: Print;
    export let series: Series;
    const basePrice = 1000;
    const framingPrice = 500;

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

    function getOrdinalSuffix(day: number): string {
        if (day > 3 && day < 21) return "th";
        switch (day % 10) {
            case 1:
                return "st";
            case 2:
                return "nd";
            case 3:
                return "rd";
            default:
                return "th";
        }
    }

    function formatDate(date: Date): string {
        const day = date.getDate();
        const month = date.toLocaleString("en-GB", { month: "long" });
        const year = date.getFullYear();
        const suffix = getOrdinalSuffix(day);
        return `${day}${suffix} of ${month} ${year}`;
    }

    const currentDate = formatDate(new Date());
</script>

<div class="purchase-container">
    <div class="header-row">
        <span>BILL OF SALE | № {billNumber}</span>
        <span>{currentDate}</span>
    </div>

    <div class="content">
        <div class="seller">Noah Syrkis · Virian ApS · CVR 42950457 · København</div>

        <div class="artwork-details">
            {print.title} · {series.material}
        </div>

        <div class="pricing">
            <div class="price-row">
                <span>Edition 4 out of {series.editions} of {print.title} (signed and numbered by the artist)</span>
                <span>€{basePrice}</span>
            </div>
            <div class="price-row">
                <span>Museum Grade Hand Crafted Float Framing in Hazelnut</span>
                <span>€{framingPrice}</span>
            </div>
            <div class="price-row total">
                <span>Total</span>
                <span>€{basePrice + framingPrice}</span>
            </div>
        </div>

        <div class="terms">Includes certificate of authenticity, worldwide shipping and insurance.</div>

        <button class="apple-pay-button">
            <span>Buy with</span>
            <span class="apple-pay-text">Apple Pay</span>
        </button>
    </div>
</div>

<style>
    .purchase-container {
        width: 100%;
        max-width: 600px;
        margin: auto;
        padding: 1.5rem;
        border: 1px solid #000;
        border-radius: 2px;
        background-color: #fff;
        letter-spacing: 0.02em;
    }

    .header-row {
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-size: 0.8rem;
        margin-bottom: 1.5rem;
    }

    .content {
        display: flex;
        flex-direction: column;
        gap: 1.5rem;
    }

    .seller,
    .artwork-details {
        font-size: 0.9rem;
        color: #000;
    }

    .pricing {
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
    }

    .price-row {
        display: flex;
        justify-content: space-between;
        font-size: 0.9rem;
        line-height: 1.5;
    }

    .total {
        border-top: 1px solid #000;
        padding-top: 0.5rem;
    }

    .terms {
        font-size: 0.8rem;
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
</style>
