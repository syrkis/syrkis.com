import Tilt from 'react-tilt';
import Link from 'next/link';


export default (props) => (
  <div style={{paddingBottom: '15vh'}}>
    <Tilt className="Tilt" options={{ max : 3, scale: 1.05, speed: 3000 }} style={{
        transformStyle: 'preserve-3d',
        height: '750px',
        maxHeight: '80vh',
        width: '1400px',
        maxWidth: '90%',
        background: props.image,
        backgroundSize: 'cover',
        backgroundPosition: 'center',
        borderRadius: '20px',
        boxShadow: ' 0 -4px 30px 2px rgba(0, 0, 0, 0.2),  0 -8px 40px 2px rgba(0, 0, 0, 0.19)',
        margin: '0 auto',
        display: 'flex',
        flexDirection: 'column',
        justifyContent: 'center'

      }} >


        <div className="Tilt-inner" style={{
          textAlign: 'center',
          width: '100%',
          color: props.tileTextColor,
          alignContent: 'center',
          lineHeight: '4em',
          }}>
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
    </Tilt>
    <style jsx>{`


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