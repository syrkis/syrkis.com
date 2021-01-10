import Link from 'next/link';

export default () => (
  <div>
    <div className="footer">
      <p>
        {'for any inquiries write'}
        <br />
	<a href="mailto:contact@syrkis.com">
		contact@syrkis.com
	</a>
        <br />
        <div>
        	<a href='https://github.com/syrkis' target='_blank' className='fab fa-github'></a>
            <a href='https://twitter.com/noahsyrkis' target='_blank' className='fab fa-twitter'></a>
            <a href="https://www.linkedin.com/in/syrkis/" target="_blank" className="fab fa-linkedin social"></a>
            <a href='https://instagram.com/noahsyrkis' target='_blank' className='fab fa-instagram'></a>
	    	<a href="https://twitch.tv/noahsyrkis" target="_blank" className="fab fa-twitch"></a>
	<br />
        </div>
      </p>
    </div>
    <style jsx>
      {`
        .fab, .fas {
          text-decoration: none !important;
          padding: 0 12px 0 12px;
          line-height: 2.5em;
        }

        .footer {
          position: relative;
          z-index: 1;
          text-align: center;
          letter-spacing: 0.1em;
          padding: 0 0 1em 0;
          font-size: 1.15em;

        }

        a, a:visited, a:focus, a:active, a:link{
          color: inherit;
          transition: opacity 0.5s ease;
        }

        a:hover {
          text-decoration: none;
          opacity: 0.6;
          transition: opacity 0.5s ease;
        }
        hr {
          color: black;
          border: 0.5px solid black;
          width: 150px;
          margin: 0.8em auto 0.8em auto;
        }
      `}
    </style>
  </div>
)
