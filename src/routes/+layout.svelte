<!-- syrkis.com/src/routes/+layout.svelte -->
<script>
    import Footer from "../comps/footer.svelte";
    import Header from "../comps/header.svelte";
</script>

<div class="layout">
    <Header />
    <main>
        <slot />
    </main>
    <Footer />
</div>

<style>
    :global(body, html) {
        font-size: 1.1em;
        margin: 0;
        padding: 0;
        line-height: 1.5em;
        color: #333;
        font-family: "Latin Modern Roman", serif;
    }

    .layout {
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    main {
        flex: 1;
        margin-top: -20vh; /* Add this line to pull the content up */
    }

    :global(h2) {
        font-weight: normal;
    }

    :global(a) {
        text-decoration: none;
        color: #333;
    }
</style>
