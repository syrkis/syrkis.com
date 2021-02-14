import Head from 'next/head'
import Footer from './footer'

const layoutStyle = {
  margin: 0,
  padding: 0,
  fontFamily: 'Crimson Text, serif',
  position: 'relative',
  lineHeight: '2em'
}

export default (props) => (
  <div style={layoutStyle}>
    <div>
      <Head>
	<title>Noah Syrkis | Aurelian, BCIIOI, Virian</title>
	<meta name='description' content='Portfolio site of writer, photographer, data scientist, and cross-class capitalist Noah Syrkis.' />


       <meta charSet="UTF-8" />
       <meta name="revisit-after" content="30 days" />
       <meta name="author" content="Noah Syrkis" />
       <meta name="viewport" content="initial-scale=1.0, width=device-width" key="viewport" />
       <link rel="shortcut icon" type="image/png" href="https://files-pdrfbjewg.vercel.app" />
	<link rel="preconnect" href="https://fonts.gstatic.com" />
	<link href="https://fonts.googleapis.com/css2?family=Crimson+Text&display=swap" rel="stylesheet" / >
       <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"  />
       <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/all.css" integrity="sha384-3AB7yXWz4OeoZcPbieVW64vVXEwADiYyAEhwilzWsLw+9FgqpyjjStpPnpBO8o8S" crossOrigin="anonymous" key="fontawesome" />
      </Head>
      {props.children}
    </div>
    <Footer />
	<style jsx global>{`
	.lorem, .clone {
		margin:auto;
	  	position: absolute;
%;
		}

		.lorem {
		  text-align: justify;
		    overflow: hidden;
		      background: white;
		      }

		      .clone {
		        text-align: center;
			font-size: 1.3em;
			}
		p {
			font-size: 1.3em;
			letter-spacing: 0.01em;
			margin: auto;
			}

		img {
		z-index:-100;}

			`}</style>
  </div>
)
