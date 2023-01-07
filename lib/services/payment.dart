import 'package:flutter_pay/env/env.dart';

class StripeRequestResponse {
  final String amount;
  final String currency;
  StripeRequestResponse({
    required this.amount,
    required this.currency,
  });
}

class StripeService {
  static String baseUrl = 'https://api.stripe.com/v1';
  static String paymementApiUrl = '$baseUrl/payment_intents';
  static Uri paymentUri = Uri.parse(paymementApiUrl);
  static String secretKey = Env.secretkey;
}
