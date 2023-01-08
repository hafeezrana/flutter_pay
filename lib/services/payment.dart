import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_pay/env/env.dart';

class StripeRequestResponse {
  bool success;
  final String message;
  StripeRequestResponse({
    required this.success,
    required this.message,
  });
}

class StripeService {
  static String baseUrl = 'https://api.stripe.com/v1';
  static String paymementApiUrl = '$baseUrl/payment_intents';
  static Uri paymentUri = Uri.parse(paymementApiUrl);
  static String secretKey = Env.secretkey;

  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secretKey}',
    'Content-Type': 'application/x-www-form-urlencoded',
  };

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency
      };

      final response =
          await http.post(paymentUri, headers: headers, body: body);

      // if (response.statusCode == 'success') {
      //   return StripeRequestResponse(
      //       success: true, message: 'Transaction done successfully');
      // } else {
      //   return StripeRequestResponse(
      //       success: false, message: 'Transaction failed');
      // }
      return jsonDecode(response.body);
    } catch (error) {
      throw Exception('Error happened');
    }
  }

  Future<void> makePayment() async {
    try {
      final makePaymentIntent = await createPaymentIntent('125', 'pkr');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: makePaymentIntent['client-secret'],
            merchantDisplayName: 'Hafeez Rana',
            style: ThemeMode.dark,
          ))
          .then((value) {});
      await displayPaymentSheet();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        return const Text('Payment Successful!');
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException {
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (error) {
      throw Error();
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }
}
