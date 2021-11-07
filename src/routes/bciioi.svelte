<script>
    import Gallery from '../comps/gallery.svelte'; 

    let text = `BCIIOI is a series of images of etched nano wires (potential uses include single neuron interfacing) captured through a microscope lens.`

</script>

<div>
    <div>
        <h1>
            BCIIOI
        </h1>
    </div>
    <Gallery project='BCIIOI' {text} />
</div>
