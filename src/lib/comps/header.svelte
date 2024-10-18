<script lang="ts">
    import { page } from "$app/stores";
    import { fade, fly } from "svelte/transition";
    import { onMount } from "svelte";
    import { browser } from "$app/environment";

    let previousRoute = "/";
    let currentRoute = "/";
    let transitioning = false;
    let mounted = false;

    onMount(() => {
        mounted = true;
        currentRoute = $page.url.pathname;
    });

    $: if (mounted && $page.url.pathname !== currentRoute) {
        previousRoute = currentRoute;
        currentRoute = $page.url.pathname;
        transitioning =
            (currentRoute === "/" && previousRoute === "/about") ||
            (currentRoute === "/about" && previousRoute === "/");
        if (transitioning && browser) {
            window.scrollTo({ top: 0, behavior: "smooth" });
        }
    }

    const shouldTransition = () => mounted && transitioning;
</script>

{#if mounted}
    <div class="container" class:about={currentRoute !== "/"}>
        <div
            class="bg"
            class:about={currentRoute !== "/"}
            class:instant={!shouldTransition()}
            transition:fade={{ duration: shouldTransition() ? 500 : 0 }}
        />

        <div
            class="content"
            class:about={currentRoute !== "/"}
            class:instant={!shouldTransition()}
            transition:fly={{ y: -50, duration: shouldTransition() ? 500 : 0 }}
        >
            <div class="header">
                <h1>Noah Syrkis</h1>
            </div>
            <div class="navigation">
                <nav>
                    <a href="/about" class:active={currentRoute === "/about"}>about</a>
                    <a href="/">|</a>
                    <a href="/" class:active={currentRoute === "/"}>works</a>
                </nav>
            </div>
        </div>
    </div>
{/if}

<style>
    .container {
        position: relative;
        height: 85vh;
        transition: all 1000ms ease-in-out;
    }
    .container.about {
        height: 25vh;
    }
    .content {
        position: relative;
        z-index: 1;
        transition: transform 1000ms ease-in-out;
    }
    .content.about {
        transition: transform 1000ms ease-in-out;
        transform: translateY(calc(-100% + 100px)); /* Move up, leaving 50px visible */
    }
    .header {
        text-align: center;
        padding: 44vh 0 20px 0;
        letter-spacing: 0.15em;
        margin: 0;
    }
    h1 {
        font-size: 1.9em;
        font-weight: normal;
        text-transform: uppercase;
    }
    a {
        color: black;
        text-decoration: none;
        font-style: normal;
        padding: 0 1em;
        font-weight: normal;
    }
    .navigation {
        font-size: 1.2em;
        margin: 0 0 2em 0;
        text-align: center;
        padding-bottom: 5vh;
    }
    .bg {
        position: absolute;
        top: 0;
        transition: all 1000ms ease-in-out;
        left: 0;
        width: 100%;
        height: 110vh;
        z-index: 0;
        background:
            linear-gradient(to top, rgba(255, 255, 255, 1) 0%, rgba(255, 255, 255, 0) 70%, rgba(0, 0, 0, 0) 100%),
            url("https://syrkis.ams3.cdn.digitaloceanspaces.com/noah/aurelian/bright.jpg") center/cover no-repeat;
    }
    .bg.about {
        /* // off set 100vh to move up completely */
        transform: translateY(-50vh);
        opacity: 0;
    }
</style>
