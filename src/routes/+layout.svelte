<script>
    import Footer from "../comps/footer.svelte";
</script>

<div>
    <slot />
    <Footer />
</div>

<style>
    :global(body, html) {
        font-size: 1.1em;
        margin: 0;
        line-height: 1.5em;
        color: #333;
        font-family: "Latin Modern Roman", serif;
        width: 100vw;
    }

    :global(h1) {
        text-align: center;
        padding: 50vh 0 5vh 0;
        letter-spacing: 0.15em;
        font-size: 1.9em;
        font-weight: normal;
        text-transform: uppercase;
        margin: 0;
    }

    :global(h2) {
        font-weight: normal;
    }

    :global(a, a.hover, a:visited) {
        text-decoration: none;
        font-style: italic;
        /* font-weight: bold; */
        color: #333;
    }
</style>
