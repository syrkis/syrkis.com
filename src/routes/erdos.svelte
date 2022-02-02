<script>
    import Gallery from '../comps/gallery.svelte'; 

    let text = `The Erdős-Rényi illustrations explore the emergence of a largest component in <a href="https://en.wikipedia.org/wiki/Erd%C5%91s%E2%80%93R%C3%A9nyi_model" target="_blank">Erdős-Rényi networks</a> as seen in this <a href='https://youtu.be/YcgdItYO8kM' target=_blank>video</a>.`

</script>

<div>
    <Gallery project='Erdos' {text} />
</div>
