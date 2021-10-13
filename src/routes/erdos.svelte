<script>
    import Gallery from '../comps/gallery.svelte'; 

    let text = `The Erdős-Rényi illustrations explore the emergence of a largest component in Erdős-Rényi networks as seen in this <a href='https://youtu.be/YcgdItYO8kM' target=_blank>video</a>.`

</script>

<div>
    <div>
        <h1>
            ERDŐS-RÉNYI
        </h1>
    </div>
    <Gallery project='Erdos' {text} />
</div>
