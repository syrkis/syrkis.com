<script lang="ts">
    import type { Series, Print } from "$lib/types";
    export let print: Print;
    export let series: Series;

    const basePrice = 1000;
    const framingPrice = 500;

    let stochasticPercentage = 0;

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

    function calculateTotalPrice(): number {
        const stochasticPrice = (1 + stochasticPercentage) * basePrice;
        return stochasticPrice + framingPrice;
    }

    async function handleApplePay() {
        const totalPrice = calculateTotalPrice();
        const paymentRequest = {
            countryCode: "US",
            currencyCode: "EUR",
            total: {
                label: "Total",
                amount: (totalPrice / 100).toFixed(2),
            },
            supportedNetworks: ["visa", "masterCard", "amex", "discover"],
            merchantCapabilities: ["supports3DS"],
        };

        const session = new ApplePaySession(3, paymentRequest);

        session.onvalidatemerchant = async (event) => {
            const validationData = await fetch("/.netlify/functions/validate-merchant", {
                method: "POST",
                body: JSON.stringify({ validationURL: event.validationURL }),
            }).then((res) => res.json());

            session.completeMerchantValidation(validationData);
        };

        session.onpaymentauthorized = async (event) => {
            const paymentData = event.payment;
            const response = await fetch("/.netlify/functions/create-payment", {
                method: "POST",
                body: JSON.stringify({
                    amount: totalPrice,
                    description: `Purchase of ${print.title}`,
                    email: paymentData.shippingContact.emailAddress,
                    name: paymentData.shippingContact.givenName + " " + paymentData.shippingContact.familyName,
                }),
            }).then((res) => res.json());

            if (response.success) {
                session.completePayment(ApplePaySession.STATUS_SUCCESS);
                window.location.href = "https://syrkis.com/success";
            } else {
                session.completePayment(ApplePaySession.STATUS_FAILURE);
            }
        };

        session.begin();
    }
</script>

<div class="purchase-container">
    <div class="header-row">
        <span>Art Transfer Document</span>
        <span> № {billNumber} | {currentDate}</span>
    </div>

    <div class="content">
        <div class="seller">Noah Syrkis · Virian ApS · CVR 38793993 · Copenhagen</div>

        <div class="pricing">
            <div class="price-row">
                <span>Stochastic Price Increase (%)</span>
                <span class="input-container">
                    <input
                        type="number"
                        bind:value={stochasticPercentage}
                        min="0"
                        max="100"
                        step="1"
                        class="price-input"
                    /> %
                </span>
            </div>
            <div class="price-row">
                <span>Edition 4 out of {series.editions} of {print.title}</span>
                <span>{formatPrice(basePrice)} €</span>
            </div>
            <div class="price-row">
                <span>Hand Crafted Float Framing in Hazelnut</span>
                <span>{formatPrice(framingPrice)} €</span>
            </div>
            <div class="price-row total">
                <span>Total</span>
                <span>{formatPrice(calculateTotalPrice())} €</span>
            </div>
        </div>

        <div class="terms">
            Includes certificate of authenticity, worldwide shipping and insurance. Signed and numbered by the artist.
        </div>

        <button on:click={handleApplePay} class="apple-pay-button">Buy with Apple Pay</button>
    </div>
</div>

<style>
    .purchase-container {
        max-width: 95%;
        width: 666px;
        margin: auto;
    }

    .header-row {
        display: flex;
        justify-content: space-between;
        margin-bottom: 3rem;
    }

    .content {
        display: flex;
        flex-direction: column;
        gap: 3rem;
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
    }

    .total {
        border-top: 1px solid #000;
        padding-top: 0.5rem;
    }

    .terms {
        font-size: 1rem;
        color: #333;
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

    .apple-pay-button {
        display: inline-block;
        background: black;
        color: white;
        padding: 10px 20px;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
    }
</style>
