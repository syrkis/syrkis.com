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
                            ERDŐS-RÉNYI
                        </h1>
                    </div>
                    <div>
		<div className='summary'>
						<p className='lorem'>
							{`
								The Erdős-Rényi illustrations explore the emergence of a largest component in `}<a href="http://networksciencebook.com/chapter/3" target="_blank"><b><i>{`Erdős-Rényi networks`}</i></b></a>{`. The illustrations are available upon request by contact through`} <i><b><a href="mailto:contact@syrkis.com?subject=Phase Trans Illustrations inquiry">email</a></b></i>{`.
								Proceeds go to the development of the
							`}<i><a href='https://virian.org' target='_blank'><b>Virian Project</b></a></i>.
						</p>
		</div>
		<br/><br/><br/>
                        <dev className='fuckoff2'>
						<img src="https://files-638x7sj2q-syrkis1.vercel.app" alt="Phase One"/>
                        </dev>
                        <dev className='fuckoff2'>
						<img src="https://files-lpphy36ds-syrkis1.vercel.app" alt="Phase Two"/>
                        </dev>
                        <dev className='fuckoff2'>
						<img src="https://files-dumt8x3xd-syrkis1.vercel.app" alt="Phase Three"/>
                        </dev>
                        <dev className='fuckoff2'>
						<img src="https://files-6onc9mafc-syrkis1.vercel.app" alt="Aurelian 3"/>
                        </dev>
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
                width: 80%;
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
