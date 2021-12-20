<script>
    let links = [
        ["syrkis.substack.com", " far fa-envelope-open"],
        ["github.com/syrkis", "github"],
        ["twitter.com/noahsyrkis", "twitter"],
        ["youtube.com/channel/UCjhko_G0E9BT7-ustIvsEoA", "youtube"],
        ["twitch.com/syrkis", "twitch"]
    ];
</script>

<div>
    <slot />
    <div class='footer'>
        <div>for any inquiries, write</div>
        <div><a href="mailto:contact@syrkis.com">contact@syrkis.com</a></div> 
        <div class='social'>
            {#each links as link}
                <a href="https://{link[0]}" target="_blank" class="fab fa-{link[1]}" />
            {/each}
        </div>
    </div>
</div>

<style>
    .footer { text-align: center; line-height: 2em; padding-bottom: 10px; }
    .fab { padding: 0 8px 0 8px; font-size: 0.8em; }
    a { font-style: normal; font-weight: 100; }
</style>
