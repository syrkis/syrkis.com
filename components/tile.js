import Tilt from 'react-tilt';
import Link from 'next/link';
import Particles from 'react-particles-js';

export default (props) => (
  <div style={{paddingBottom: '15vh'}}>
    <Tilt className="Tilt" options={{ max : 3, scale: 1.05, speed: 3000, glare : true, maxGlare: 1.0}} style={{
        transformStyle: 'preserve-3d',
        maxHeight: '750px',
        height: '80vh',
        maxWidth: '1400px',
        width: '90%',
        backgroundImage: props.image,
        backgroundColor: 'black',
        backgroundSize: 'cover',
        backgroundPosition: 'center',
        borderRadius: '20px',
        boxShadow: ' 0 -4px 30px 2px rgba(0, 0, 0, 0.2),  0 -8px 40px 2px rgba(0, 0, 0, 0.19)',
        margin: '0 auto',
        display: 'flex',
        flexDirection: 'column',
        justifyContent: 'center'
      }} >
                {
                        props.particles &&
                        <Particles className='background' style={{
                            width: '100%', height: '200px', position: 'absolute', top: 0, left: 0}} params={{
                            retinaDetect: true,
                            fpsLimit: 48,
                            particles: {
                                color: {
                                    value: '#fff'
                                },
                                links: {
                                    color: '#fff',
                                    distance: 50
                                },
                                move: {
                                    speed: 1
                                },
                                    number: {
                                        value: 150
                                    }
                        }}}/>
                }



        <div className="Tilt-inner" id='wrapper' style={{
          textAlign: 'center',
          width: '100%',
          color: props.tileTextColor,
          alignContent: 'center',
          lineHeight: '4em',
          }}>

    <div className='content'>
          <h1>{props.titleHuge0}</h1>
          <h1>{props.titleHuge1}</h1>
          <h4>{props.titleLine0}</h4>
          <h2>{props.titleLine1}</h2>
          <h4>{props.titleLine2}</h4>
          <h2>{props.titleLine3}</h2>
          <h4>{props.titleLine4}</h4>
          <h2>{props.titleLine5}</h2>
          <h4>{props.titleLine6}</h4>
        </div>
        </div>
    </Tilt>
    <style jsx>{`


        .background{
            position: absolute;
            top: 0;
            left: 0;
        }

        .Tilt-inner {
            transform: translateZ(150px);
            letter-spacing: 0.2em;
            text-transform: uppercase;
        }

    h2 {
      font-size: 1.7em;
      word-spacing: 0.2em;
    }

    h3 {
      font-size: 1.3em;
      letter-spacing: 0.1em;
    }

    h4 {
      font-size: 0.8em;
      letter-spacing: 0.1em;
    }

    a, a:visited, a:focus, a:active, a:link, a:hover {
      color: inherit; text-decoration: none; }



`}</style>
</div>
)
