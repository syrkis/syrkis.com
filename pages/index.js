import Link from "next/link";
import Layout from "../components/layout";
import Header from "../components/header";
import Tile from "../components/tile";

export default () => (
  <main>
    <Layout>
      <Header />
      <section>
        <div className="content">
             <a href='https://virian.org' target='_blank'>
              <Tile particles={true} titleLine0="the" titleLine1="VIRIAN" titleLine4="project" tileTextColor="white" />
            </a>
	<br/> 
            <a href='https://methylorange.com' target='_blank'>
            <Tile image={`url('https://files-iyvowzcfl.vercel.app')`}  titleHuge0="METHYL ORANGE" titleLine0="or" titleLine1="MY LOVE IN" titleLine3="SUPERPOSIT1ON" tileTextColor="white"/>
            </a>
          <br/>
          <Link href="/bciioi">
            <a>
              <Tile image={`url('https://images.syrkis.com/bciioi/untitled_5.jpg')`} titleLine0="the" titleLine1="BCIIOI" titleLine4="series" tileTextColor="white" />
            </a>
          </Link>
	<br/>
          <Link href="/aurelian">
            <a>
              <Tile image={`url('https://images.syrkis.com/static/bright.jpg')`} titleLine0="the" titleLine1="AURELIAN" titleLine4="collection" tileTextColor="black" />
            </a>
          </Link>
	<br/>
          <Link href="/harmattan">
            <a>
            <Tile image={`url('https://images.syrkis.com/harmattan/girl.jpg')`}  titleLine0="the" titleLine1="HARMATTAN" titleLine4="series" tileTextColor="white"/>
            </a>
          </Link>
            <br/>
    <Link href='untitled'>
            <a>
            <Tile image={`url('https://files-htkutq83v-syrkis1.vercel.app')`} titleLine0='an' titleLine1="UNTITLED" titleLine4="IMAGE" tileTextColor="white"/>
            </a>
    </Link>
          <br/>
        </div>
      </section>
    </Layout>
    <style jsx>{`


      h1 {
        font-size: 2em;
        text-align: center;
        text-transform: uppercase;
        letter-spacing: 0.2em;
      }
      a, a:visited, a:focus, a:active, a:link, a:hover {
        color: inherit;
        text-decoration: none;
      }
      
      .content {
        padding-top: 90vh;
        width: 100%;
        margin: auto;
        text-align: center;
        position: relative;
      }  
      
    `}</style>
  </main>
);
