import 'package:flutter/material.dart';
import 'package:sowlabapp/onboarding_segment/onboarding_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return; // important safety check

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => OnboardingPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "FarmerEats",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: "Be Vietnam",
          ),
        ),
      ),
    );
  }
}
