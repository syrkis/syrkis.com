<script lang="ts">
    import { page } from "$app/stores";
    import Prints from "$lib/comps/Prints.svelte";
</script>

<Prints slug={$page.params.slug} />
