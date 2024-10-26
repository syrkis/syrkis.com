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

<!-- <div class="background-wrapper" class:subpage={$isSubPage}> -->
<!-- <div class="background" class:subpage={$isSubPage}></div> -->
<!-- </div> -->
<header class:subpage={$isSubPage}>
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
        display: flex;
        overflow: hidden;
        align-items: center;
        justify-content: center; /* Center children horizontally */
        font-size: 1.1em;
        margin: 0 auto;
        width: 100vw; /* Ensure full width */
        height: 100vh; /* Default height for the homepage */
        overflow: hidden;
        transition:
            transform 1s ease-in-out,
            height 1s ease-in-out;
    }

    header.subpage {
        transform: translateY(-2em);
        height: 120px; /* Reduced height for other pages */
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
</style>
