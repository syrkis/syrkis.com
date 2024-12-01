// netlify/functions/webhook.js
const mollie = require("@mollie/api-client")({ apiKey: process.env.MOLLIE_API_KEY });

exports.handler = async (event, context) => {
  try {
    const { id } = JSON.parse(event.body);

    const payment = await mollie.payments.get(id);

    // Handle the payment status update
    if (payment.isPaid()) {
      // Payment is paid
      // Update your database or perform other actions
    } else if (payment.isOpen()) {
      // Payment is open
    } else if (payment.isCanceled()) {
      // Payment is canceled
    } else if (payment.isExpired()) {
      // Payment is expired
    } else if (payment.isFailed()) {
      // Payment has failed
    }

    return {
      statusCode: 200,
      body: JSON.stringify({ status: "success" }),
    };
  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: error.message }),
    };
  }
};
