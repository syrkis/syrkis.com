<script>
    let links = [
        ["instagram.com/noahsyrkis", "instagram"],
        ["github.com/syrkis", "github"],
        ["twitter.com/noahsyrkis", "twitter"],
        ["youtube.com/@syrkis", "youtube"],
        ["twitch.com/syrkis", "twitch"]
    ];
</script>

<div>
    <slot />
    <div class='footer'>
        <div>for all enquiries, write</div>
        <div><a href="mailto:desk@syrkis.com">desk@syrkis.com</a></div>
        <div class='social'>
            {#each links as link}
                <a href="https://{link[0]}" target="_blank" class="fab fa-{link[1]}"> </a>
            {/each}
        </div>
    </div>
</div>

<style>

    .footer { text-align: center; line-height: 2em; padding-bottom: 10px; }
    .fab { padding: 0 8px 0 8px; font-size: 0.8em; }
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
