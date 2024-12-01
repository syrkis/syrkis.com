<script lang="ts">
    import { page } from "$app/stores";
    import { derived } from "svelte/store";

    const links = [
        { href: "/works", text: "works" },
        { href: "/", text: "|" },
        { href: "/about", text: "about" },
    ];

    const isSubPage = derived(page, ($page) => $page.url.pathname !== "/");
</script>

<header class:subpage={$isSubPage}>
    <div class="background-wrapper">
        <div class="background" class:subpage={$isSubPage}></div>
    </div>
    <div class="content">
        <h1>
            <a href="/">NOAH SYRKIS</a>
        </h1>
        <nav>
            <ul>
                {#each links as link}
                    <li>
                        <a href={link.href}>
                            {link.text}
                        </a>
                    </li>
                {/each}
            </ul>
        </nav>
    </div>
</header>

<style>
    header {
        position: relative;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.1em;
        margin: 0 auto;
        width: 100vw;
        height: 100vh;
        overflow: hidden;
        transition:
            transform 1s ease-in-out,
            height 1s ease-in-out;
    }

    header.subpage {
        transform: translateY(-2em);
        height: 120px;
    }

    .background-wrapper {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
        z-index: -1;
        transition: transform 1s ease-in-out;
    }

    .background {
        width: 100%;
        height: 100%;
        background-image: linear-gradient(to bottom, rgba(255, 255, 255, 0) 50%, rgba(255, 255, 255, 1)),
            url("/images/aurelian-1.jpg");
        background-size: cover;
        background-position: center;
        transition: opacity 1s ease-in-out;
    }

    .background.subpage {
        opacity: 0;
    }

    .content {
        z-index: 1;
    }

    nav ul {
        list-style-type: none;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    nav li {
        display: inline;
        margin: 0 31px;
    }

    @keyframes slideUp {
        0% {
            transform: translateY(0);
        }
        100% {
            transform: translateY(-2em);
        }
    }

    header.subpage .background-wrapper {
        animation: slideUp 1s ease-in-out forwards;
    }
</style>
