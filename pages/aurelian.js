import { TitleComponent } from '../components/title.js'
import { Component } from 'react'
import Link from 'next/link'
import Layout from '../components/layout'

const withTitle = ({ component: Component, title, description}) => {
	return class Title extends Component {
		render() {
			return (
				<React.Fragment>
					<TitleComponent title={title} description={description} />
					<Component {...this.props} />
				</React.Fragment>
			);
		}
	};
};

class AurelianPage extends Component {
	componentDidMount() {
	var para = document.querySelectorAll('.lorem');
		para.forEach((p) => {
			const clone = p.cloneNode(true);
			clone.className= 'clone';
			p.parentNode.insertBefore(clone, p);
			p.style.height= p.offsetHeight - 14 + 'px';	
		})
	}
  render() {
    return (
      <main>
        <Layout>
            <section>
                <div className="content">
                    <div className="header">
                        <h1>
                        AURELIAN
                        </h1>
                    </div>
                    <div>
		<div className='summary'>
						<p className='lorem'>
							{`
								Aurelian is a 2018 photo collection, exploring the textures of butterfly wings. Prints are available upon request by contact through`} <i><b><a href="mailto:contact@syrkis.com?subject=Aurelian inquiry">email</a></b></i>{`.
								Proceeds go to the development of the
							`}<i><a href='https://virian.org'><b>Virian Project</b></a></i>.
						</p>
		</div>
		<br/><br/><br/>
                        <dev className='fuckoff2'>
						<img src="https://files-ll15vh3lu.vercel.app" alt="Aurelian 2"/>
                        <dev className='fuckoff'><p><i>{`Untitled`}</i>{`, Aurelian Series No. 1, 59 x 84 cm, Copenhagen 2018.`}</p></dev></dev>
                        <dev className='fuckoff2'>
						<img src="https://files-lg2h88aah.vercel.app" alt="Aurelian 3"/>
                        <dev className='fuckoff'><p><i>{`Untitled`}</i>{`, Aurelian Series No. 2, 59 x 84 cm, Copenhagen 2018.`}</p></dev></dev>
                        <dev className='fuckoff2'>
						<img src="https://files-iyvowzcfl.vercel.app" alt="Aurelain 1"/>
                        <dev className='fuckoff'><p><i>{`Untitled`}</i>{`, Aurelian Series No. 3, 59 x 84 cm, Copenhagen 2018.`}</p></dev></dev>
                        <dev className='fuckoff2'>
						<img src="https://files-d9fpcwewz.vercel.app" alt="Aurelian 3"/>
                        <dev className='fuckoff'><p><i>{`Untitled`}</i>{`, Aurelian Series No. 4, 59 x 84 cm, Copenhagen 2018.`}</p></dev></dev>
                        <dev className='fuckoff2'>
						<img src="https://files-np4lf6cc0.vercel.app" alt="Aurelian 3"/>
                        <dev className='fuckoff'><p><i>{`Untitled`}</i>{`, Aurelian series No. 5, 59 x 84 cm, Copenhagen 2018.`}</p></dev></dev>
						<br/><br/><br/><br/><br/><br/><br/><br/>
					
                    </div>
                </div>
            </section>
        </Layout>
        <style jsx>{`
			
             .header {
                padding: 42vh 0vh 22vh 0vh;
		letter-spacing: 0.4em;
            }
            
            img {
                width: 1400px;
                max-width: 80%;
                padding-top: 200px;
		z-index: -100;
                padding-bottom: 50px;
				
            }
			

            p {
                font-size: 1.3em;
            }

            section {
                text-align: center;
                width: 95%;
				margin:auto;
            }
			
			.summary {
				margin: auto;
				text-align: justify;
				width: 95%;
				max-width: 600px;
				text-align-last: center;
				position: relative;
			}
			
			a {
			color: black;}

        `}</style>
      </main>
    )
  }
}

export default withTitle({component: AurelianPage, title: 'The Aurelian Series | Noah Syrkis', description: 'Aurelian is a 2018 photo series, exploring the texture of butterfly wings.'});
