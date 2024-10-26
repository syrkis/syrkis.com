<script lang="ts">
    import { page } from "$app/stores";
    import Footer from "$lib/comps/Footer.svelte";
    import Header from "$lib/comps/Header.svelte";

    import "../global.css";

    // Determine if the current route is the root route
    $: isRootRoute = $page.url.pathname === "/";
    $: showFooter = !isRootRoute;
</script>

<div class="app">
    <Header />
    <main>
        <slot />
    </main>
    {#if showFooter}
        <Footer />
    {/if}
</div>

<style>
    .app {
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    main {
        flex: 1;
    }
</style>
