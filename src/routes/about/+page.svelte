<script lang="ts">
    const content = $state(`
      Noah Syrkis's work explores the aesthetics of archives and mathematics, as well as variations on geospatial and organic themes.

      Working between Copenhagen, Rio de Janeiro, and New York, Noah develops systems that map from complex data to typographics and aesthetics.

      Through pattern and form, his work examines the relationship between entropy and experience.
    `);
</script>

<div class="about text">
    {#each content.split("\n\n") as paragraph}
        <p>{paragraph}</p>
    {/each}
</div>

<style>
    .about {
        text-align: justify;
        text-align-last: center;
        padding: 10vh 0 10vh 0;
    }
</style>
