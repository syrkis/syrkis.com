import {Helmet} from "react-helmet";
import { TitleComponent } from '../components/title.js'
import { Component } from 'react'
import Link from 'next/link'
import Layout from '../components/layout'

const withTitle = ({ component: Component, title, description}) => {
	return class Title extends Component {
		render() {
			return (
				<React.Fragment>
					<TitleComponent title={title} description={description}/>
					<Component {...this.props} />
				</React.Fragment>
			);
		}
	};
};

class HarmattanPage extends Component {
  render() {
    return (
      <main>
        <Layout>
		            <Helmet>
	                  <script src="/static/text_align_last.js" type="text/javascript" />

	              </Helmet>
            <section>
                <div className="content">
                    <div className="header">
                        <h1>
                        HARMATTAN
                        </h1>
                    </div>
<div className='summary'>
				<p id='lorem'>
					
						Harmattan is a 2015 photos series shot and edited from the perspective of the main charcater of <a href='/methyl'><i><b>Methyl Orange</b></i></a>.
						Presented over the course of nine limited edition prints, the series is available for purchase by contact through <i><b><a href="mailto:contact@syrkis.com?subject=Harmattan inquiry">email</a></b></i>.
						Proceeds are donated to the <i><a href="https://schistosomiasiscontrolinitiative.org/"><b>SCI Foundation</b></a></i>.
				</p>
</div>
                    <div>
                        <img src="https://images.syrkis.com/harmattan/girl.jpg" alt="The Girl"/>
						<p><i>{`The Girl`}</i>, {`2015, 59 x 84 cm, 300 €, 6 of 9 prints remain available.`}</p>
                        <img src="https://images.syrkis.com/harmattan/family.jpg" alt="The Day"/>
						<p><i>{`The Family`}</i>, {`2015, 59 x 84 cm, 300 €, 7 of 9 prints remain available.`}</p>
                        <img src="https://images.syrkis.com/harmattan/boy.jpg" alt="The Boy"/>
						<p><i>{`The Boy`}</i>, {`2015, 59 x 84 cm, 300 €, 6 of 9 prints remain available.`}</p>
                        <img src="https://images.syrkis.com/harmattan/girls.jpg" alt="The Girls"/>
						<p><i>{`The Girls`}</i>, {`2015, 59 x 84 cm, 300 €, 5 of 9 prints remain available.`}</p>
                        <img src="https://images.syrkis.com/harmattan/model.jpg" alt="The Model"/>
						<p><i>{`The Model`}</i>, {`2015, 59 x 84 cm, 300 €, 7 of 9 prints remain available.`}</p>
                        <img src="https://images.syrkis.com/harmattan/night.jpg" alt="The Night"/>
						<p><i>{`The Night`}</i>, {`2015, 59 x 84 cm, 300 €, 5 of 9 prints remain available.`}</p>
                        <img src="https://images.syrkis.com/harmattan/man.jpg" alt="The Man"/>
						<p><i>{`The Man`}</i>, {`2015, 59 x 84 cm, 300 €, 4 of 9 prints remain available.`}</p>
                        <img src="https://images.syrkis.com/harmattan/day.jpg" alt="The Girl"/>
						<p><i>{`The Day`}</i>, {`2015, 59 x 84 cm, 300 €, 7 of 9 prints remain available.`}</p>
                        <img src="https://images.syrkis.com/harmattan/scout.jpg" alt="The Scout"/>
						<p><i>{`The Scout`}</i>, {`2015, 59 x 84 cm, 300 €, 6 of 9 prints remain available.`}</p>
						<br/><br/><br/><br/><br/><br/><br/><br/>
						
                    </div>
                </div>
            </section>
        </Layout>
        <style jsx>{`
		#lorem, .clone {
		    line-height: 1.95em;
		      font: 1.3em;
			max-width: 95%;
			}

			#lorem {
			  text-align: justify;
			    overflow: hidden;
			      background: white;
			      }

			      .clone {
			        text-align: center;
				}


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

            p {
                font-size: 1.3em;
            }

            section {
                text-align: center;
                width: 95%;
				margin: auto;
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

export default withTitle({component: HarmattanPage, title: 'The Harmattan Series | Noah Syrkis', description: 'Harmattan is a 2015 photos series shot and edited from the perspective of the main charcater of Methyl Orange.' });
