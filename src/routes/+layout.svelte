<script>
    let links = [
        ["fab fa-github", "https://github.com/syrkis"],
        ["fab fa-instagram", "https://instagram.com/noahsyrkis"],
        ["fab fa-youtube", "https://youtube.com/@syrkis"],
        ["fab fa-linkedin", "https://linkedin.com/in/syrkis"],
        ["far fa-circle", "/"],
    ];
</script>

<div>
    <slot />
    <div class='footer'>
        <div>for all enquiries, write</div>
        <div><a href="mailto:desk@syrkis.com">desk@syrkis.com</a></div>
        <div class='social'>
            {#each links as link}
                {#if link[0] === "far fa-circle"}
                    <a href="{link[1]}" class="{link[0]}"> </a>
                {:else}
                    <a href="{link[1]}" target='_blank'  rel='noreferrer' class="{link[0]}"> </a>
                {/if}
            {/each}
        </div>
    </div>
</div>

<style>

    .footer { text-align: center; line-height: 2em; padding-bottom: 3rem; }
    .fab, .far, .fas { padding: 0 8px 0 8px; font-size: 0.8em; }
    a { font-style: normal; font-weight: 100; }

    :global(body, html) {
        font-size: 1.1em;
        margin: 0;
        line-height: 1.5em;
        color: #333;
        font-family: 'Crimson Text', 'serif';
        width: 100vw;
    }

    :global(h1) {
        text-align: center;
        padding: 50vh 0 25vh 0;
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
        font-weight: bold;
        color: #333;
    }

</style>
