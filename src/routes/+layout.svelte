<script>
    let links = [
        ["fab fa-github", "https://github.com/syrkis"],
        ["fab fa-brands fa-x-twitter ", "https://x.com/noahsyrkis"],
        ["fab fa-brands fa-rss", "https://virian.org/text"],
        ["fab fa-youtube", "https://youtube.com/@syrkis"],
        ["fab fa-brands fa-orcid", "https://orcid.org/0000-0002-6553-1115"],
    ];
</script>

<div>
    <slot />
    <div class='footer'>
        <div>for all enquiries, write</div>
        <div><a href="mailto:desk@syrkis.com">desk@syrkis.com</a></div>
        <div class='social'>
            {#each links as link}
                <a href="{link[1]}" target='_blank'  rel='noreferrer' class="{link[0]}"> </a>
            {/each}
        </div>
    </div>
</div>

<style>

    .footer { text-align: center; line-height: 2em; padding-bottom: 3rem; letter-spacing: 0.02em; }
    .fab, .far, .fas { padding: 0 10px; font-size: 0.8 em; }
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
