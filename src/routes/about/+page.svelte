<script lang="ts">
    const content = $state(`
        Noah Syrkis creates at the intersection of technology and art. His work transforms complex ideas into visual experiences, from microscopic nanowires to abstract mathematical concepts.

        Through photography and digital art, Noah explores themes of emergence, cultural dynamics, and the nature of intelligence. His projects, including the Virian Project, blend data science with artistic expression.

        Noah's background in artificial intelligence informs his unique perspective on creativity and systems thinking. He teaches, researches, and continually seeks new ways to visualize our interconnected world.
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
        padding: 5vh 0 15vh 0;
    }
</style>
