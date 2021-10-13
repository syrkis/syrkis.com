<script>

    export let project;
    import Particles from "svelte-particles";
    import VanillaTilt from 'vanilla-tilt';
    import { onMount } from 'svelte';
    
    onMount(async () => {
        const element = document.querySelectorAll(".js-tilt");
        VanillaTilt.init(element, { max: 3, scale: 1.03, speed: 2000 });
    });

    let baseurl = "https://syrkis.ams3.cdn.digitaloceanspaces.com";
    let bg = `${baseurl}/${project.id}/${project.bg}.jpg`;

    let particlesConfig = { particles: {
            color: { value: "#ddd", },
            size: { value: 1 },
            links: { enable: true,color: "#ddd",distance: 30,width: 2 },
            move: { enable: true, speed: 0.3 },
            number: { density: { area: 300, enable: true, factor: 1000 } },
        } };

</script>

<a href={project.url}>
    <div class='js-tilt bg' style="
        transform-style: preserve-3d;
        transform: perspective(1000px);
        background: black;
        background-image: url({bg});
        background-size: cover;
        background-position: center;
        " data-tilt>
            <div class='inner'>
                    <div class='text' style="color:{project.color};">
                        <p>{project.pre}</p>
                        <h2>{project.title}</h2>
                        <p>{project.suf}</p>
                    </div>
            </div>
            {#if project.particles}
                <div id="tsparticles">
                    <Particles options="{particlesConfig}" />
                </div>
            {/if}
    </div>
</a>

<style>
    .text { position: relative; z-index: 1; }
    .js-tilt { text-align: center; margin: 15vh 0; transform-style: preserve-3d; }
    a { font-style: normal; }

    .inner {
        transform: translateZ(100px);
        margin: 0;
        letter-spacing: 0.15em;
        text-transform: uppercase;
        font-style: none;
        line-height: 2.5em;
    }

    #tsparticles { height: 80vh;  width: 90vw; bottom:0; position: absolute; display: block; z-index: -1; }

    .bg {
        width: 90vw;
        margin: auto;
        height: 80vh;
        border-radius: 25px;
        display: flex;
        align-items: center;
        box-shadow: 0 -4px 30px 2px rgba(0, 0, 0, 0.2),
                    0 -8px 40px 2px rgba(0, 0, 0, 0.19);
        justify-content: center;
    }    

</style>

