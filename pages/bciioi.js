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
						<p>
							{`
								The photo series BCIIOI is a 2016 study of the relationship and the merger of the natural with the digital.
								Presented over the course of five limited edition prints, the series is available for purchase by contact through email.
								Proceeds go to the development of the
							`}<i><a href='https://virian.org'>Virian Project</a></i>
						</p>
		</div>
		<br/>
                        <dev className='fuckoff2'>
						<img src="https://images.syrkis.com/bciioi/untitled_1.jpg" alt="watch your head! she said"/>
                        <dev className='fuckoff'><p><i>{`"watch your head! she said"`}</i>{`, BCIIOI 1, 59 x 84 cm, 300 €, 2 of 5 prints remain available.`}</p></dev></dev>
                        <dev className='fuckoff2'>
						<img src="https://images.syrkis.com/bciioi/untitled_2.jpg" alt="look at what's inside"/>
                        <dev className='fuckoff'><p><i>{`"look at what's inside"`}</i>{`, BCIIOI 2, 59 x 84 cm, 300 €, 2 of 5 prints remain available.`}</p></dev></dev>
                        <dev className='fuckoff2'>
						<img src="https://images.syrkis.com/bciioi/untitled_3.jpg" alt="it's full of rods and wires"/>
                        <dev className='fuckoff'><p><i>{`"it's full of rods and wires"`}</i>{`, BCIIOI 3, 59 x 84 cm, 300 €, 3 of 5 prints remain available.`}</p></dev></dev>
                        <dev className='fuckoff2'>
						<img src="https://images.syrkis.com/bciioi/untitled_4.jpg" alt="they're coming out of your neck"/>
                        <dev className='fuckoff'><p><i>{`"they're coming out of your neck"`}</i>{`, BCIIOI 4, 59 x 84 cm, 300 €, 3 of 5 prints remain available.`}</p></dev></dev>
                        <dev className='fuckoff2'>
						<img src="https://images.syrkis.com/bciioi/untitled_5.jpg" alt="Untitled"/>
                        <dev className='fuckoff'><p><i>{`"untitled"`}</i>{`, BCIIOI 5, 59 x 84 cm, 300 €, 2 of 5 prints remain available.`}</p></dev></dev>
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
                padding-bottom: 50px;
				
            }
			
			.fuckoff {
				text-align: center;
			}
			
			.fuckoff2 {
				pos
                width: 1400px;
                max-width: 75%;
				margin: auto;
				position: relative;
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
				width: 600px;
				max-width: 90%;
				text-align-last: center;
			
			}
			
			a {
			color: black;}

        `}</style>
      </main>
    )
  }
}

export default withTitle({component: BciioiPage, title: 'The BCIIOI Series', description: 'The photo series BCIIOI is a 2016 study of the relationship and the merger of the natural with the digital.'});
