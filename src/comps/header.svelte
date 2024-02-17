<div class="header">
    <nav>
        <ul>
            <li><a href="/about">about</a></li>
            <li><a href="/">home</a></li>
            <li><a href="/press">press</a></li>
        </ul>
    </nav>
</div>

<style>
    .header {
        text-align: center;
        position: absolute;
        width: 100%;
        z-index: 1000;
    }

    nav ul {
        list-style: none;
        padding: 40px 10%;
        margin: auto;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    nav li {
        display: flex;
    }

    nav li:not(:last-child)::after {
        content: "|";
        margin: 0 30px;
    }

    nav a {
        text-decoration: none;
    }
</style>
