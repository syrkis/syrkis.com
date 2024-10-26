<script lang="ts">
    const email = "desk@syrkis.com";
    const displayEmail = email.replace("@", "[at]");
</script>

<footer>
    <div class="dashes">—————</div>
    <p>for all enquiries, write</p>
    <p>
        <a href={`mailto:${email}`}>{displayEmail}</a>
    </p>
</footer>

<style>
    footer {
        margin-top: 2em;
    }

    .dashes {
        margin-bottom: 1em;
    }

    a {
        color: inherit;
        text-decoration: none;
        cursor: pointer;
    }

    a:hover {
        text-decoration: underline;
    }
</style>
