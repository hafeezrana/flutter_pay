import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey =
      'pk_test_51MMDFnLBNTAOGzaWPRYb3t9FLnFuuXTculv5kVKN2sxwkQlKndgdcbvVo7i0LmQ4wmhlECVwEjOWl7NbGsHU62M600rpLiuktF';

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Payment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(),
    );
  }
}
