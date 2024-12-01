// netlify/functions/create-payment.js
const mollie = require("@mollie/api-client")({ apiKey: process.env.MOLLIE_API_KEY });

exports.handler = async (event, context) => {
  try {
    const { amount, description, email, name } = JSON.parse(event.body);

    const payment = await mollie.payments.create({
      amount: {
        currency: "EUR",
        value: (amount / 100).toFixed(2), // e.g. '10.00'
      },
      description: description,
      redirectUrl: "https://syrkis.com/success",
      webhookUrl: "https://syrkis.com/.netlify/functions/webhook",
      metadata: {
        email: email,
        name: name,
      },
      method: "applepay",
    });

    return {
      statusCode: 200,
      body: JSON.stringify({ success: true, paymentUrl: payment.getPaymentUrl() }),
    };
  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify({ success: false, error: error.message }),
    };
  }
};
