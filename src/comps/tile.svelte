<script>

    export let project;
    import Particles from "svelte-particles";
    import { loadFull } from "tsparticles";
    import VanillaTilt from 'vanilla-tilt';
    import { onMount } from 'svelte';
    
    onMount(async () => {
        const element = document.querySelectorAll(".js-tilt");
        VanillaTilt.init(element, { max: 3, scale: 1.03, speed: 2000,
        reverse: true });
    });

    let baseurl = "https://syrkis.ams3.cdn.digitaloceanspaces.com/noah/tiles";
    let bg = `${baseurl}/${project.bg}.jpg`;


    let onParticlesLoaded = (event) => {
        const particlesContainer = event.detail.particles;

        // you can use particlesContainer to call all the Container class
        // (from the core library) methods like play, pause, refresh, start, stop
    };

    let particlesInit = async (engine) => {
        // you can use main to customize the tsParticles instance adding presets or custom shapes
        // this loads the tsparticles package bundle, it's the easiest method for getting everything ready
        // starting from v2 you can add only the features you need reducing the bundle size
        await loadFull(engine);
    };

let particlesConfig = {
        fullScreen: { enable: false, zIndex: 0 },
        detectRetina: true,
        particles: {
            color: {
                value: "#ddd",
            },
            size: {
                value: 1,
            },
            links: {
                enable: true,
                color: "#ddd",
                distance: 40,
                width: 2,
            },
            move: {
                enable: true,
                speed: 0.1,
            },
            number: {
                value: 42,
                density : {
                    enable: true,
                    value_area: 150
                }
            },
        },
    };

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
                    <Particles
                            options="{particlesConfig}"
                            on:particlesLoaded="{onParticlesLoaded}"
                            particlesInit="{particlesInit}"
                    />
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

