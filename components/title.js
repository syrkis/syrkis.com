import Helmet from 'react-helmet';

const TitleComponent = ({ title, description }) => {
	var defaultTitle = 'Noah Syrkis';
	var defaultDesc = 'Writer, photographer, data scientist and cross-class capitalist';
	return (
		<Helmet>
			<title>{title ? title : defaultTitle}</title>
			<meta name='description' content={description ? description : defaultDesc}/>
		</Helmet>
	);
};

export { TitleComponent };
