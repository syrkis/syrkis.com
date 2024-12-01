// netlify/functions/validate-merchant.js
const mollie = require("@mollie/api-client")({ apiKey: process.env.MOLLIE_API_KEY });

exports.handler = async (event, context) => {
  try {
    const { validationURL } = JSON.parse(event.body);

    const validationData = await mollie.methods.applePay.validate({
      validationUrl: validationURL,
      domain: "syrkis.com",
    });

    return {
      statusCode: 200,
      body: JSON.stringify(validationData),
    };
  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: error.message }),
    };
  }
};
