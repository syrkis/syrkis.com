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

class BciioiPage extends Component {
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
                        BCIIOI
                        </h1>
                    </div>
                    <div>
		<div className='summary'>
						<p className='lorem'>
							{`
								The BCIIOI series is a 2016 exploration of the merger between the natural and the digital.
								It consists of five limited edition prints available for purchase through `} <i><b><a href="mailto:contact@syrkis.com?subject=BCIIOI inquiry">email</a></b></i>{`.
								Proceeds go to the development of the
							`}<i><a href='https://virian.org' target='_blank'><b>Virian Project</b></a></i>.
						</p>
		</div>
		<br/><br/><br/>
                        <dev className='fuckoff2'>
						<img src="https://images.syrkis.com/bciioi/untitled_1.jpg" alt="watch your head! she said"/>
                        <dev className='fuckoff'><p><i>{`Watch your head! she said`}</i>{`, BCIIOI 1, 59 x 84 cm, limited edition of 5.`}</p></dev></dev>
                        <dev className='fuckoff2'>
						<img src="https://images.syrkis.com/bciioi/untitled_2.jpg" alt="look at what's inside"/>
                        <dev className='fuckoff'><p><i>{`Look at what's inside`}</i>{`, BCIIOI 2, 59 x 84 cm, limited edition of 5.`}</p></dev></dev>
                        <dev className='fuckoff2'>
						<img src="https://images.syrkis.com/bciioi/untitled_3.jpg" alt="it's full of rods and wires"/>
                        <dev className='fuckoff'><p><i>{`It's full of rods and wires`}</i>{`, BCIIOI 3, 59 x 84 cm, limited edition of 5.`}</p></dev></dev>
                        <dev className='fuckoff2'>
						<img src="https://images.syrkis.com/bciioi/untitled_4.jpg" alt="they're coming out of your neck"/>
                        <dev className='fuckoff'><p><i>{`They're coming out of your neck`}</i>{`, BCIIOI 4, 59 x 84 cm, limited edition of 5.`}</p></dev></dev>
                        <dev className='fuckoff2'>
						<img src="https://images.syrkis.com/bciioi/untitled_5.jpg" alt="Untitled"/>
                        <dev className='fuckoff'><p><i>{`Untitled`}</i>{`, BCIIOI 5, 59 x 84 cm, limited edition of 5.`}</p></dev></dev>
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

export default withTitle({component: BciioiPage, title: 'The BCIIOI Series | Noah Syrkis', description: 'The photo series BCIIOI is a 2016 study of the relationship and the merger of the natural with the digital.'});
