<script lang="ts">
    import { page } from "$app/stores";
    import { fade, fly } from "svelte/transition";

    $: currentRoute = $page.url.pathname;
</script>

<div class="container {currentRoute !== '/' ? 'about' : ''}">
    <div class="bg {currentRoute !== '/' ? 'about' : ''}" transition:fade={{ duration: 500 }} />
    <div class="content">
        <div class="header" class:about={currentRoute !== "/"} transition:fly={{ y: -50, duration: 500 }}>
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

<style>
    .container {
        position: relative;
        height: 80vh; /* Reduced from 100vh to 80vh */
        transition: all 500ms ease-out;
    }
    .container.about {
        height: 25vh;
    }
    .content {
        position: relative;
        z-index: 1;
    }
    .header {
        text-align: center;
        padding: 44vh 0 20px 0; /* Adjusted from 44vh to 24vh */
        letter-spacing: 0.15em;
        margin: 0;
        transition: all 500ms ease-out;
    }
    .header.about {
        padding: 0vh;
        opacity: 0;
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
        padding-bottom: 5vh; /* Reduced from 15vh to 5vh */
    }
    .bg {
        position: absolute;
        top: 0;
        transition: all 500ms ease-out;
        left: 0;
        width: 100%;
        height: 110vh;
        z-index: 0;
        background:
            linear-gradient(to top, rgba(255, 255, 255, 1) 0%, rgba(255, 255, 255, 0) 70%, rgba(0, 0, 0, 0) 100%),
            url("https://syrkis.ams3.cdn.digitaloceanspaces.com/noah/aurelian/bright.jpg") center/cover no-repeat;
    }
    .bg.about {
        height: 35vh;
        opacity: 0;
    }
</style>
