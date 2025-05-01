import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../configs/routes/routes_name.dart';
import '../services/splash/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashServices splashServices = SplashServices(); // Instance of SplashServices for handling splash screen logic

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
    Future.delayed(Duration(seconds: 2), () {
      // Restore status bar before navigating if needed
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
      Navigator.pushReplacementNamed(context, RoutesName.login);
    });
    splashServices.checkAuthentication(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('images/splesh_bg.png', fit: BoxFit.cover),
          ),
          Center(
            child: Image.asset('images/logo_clip.png', width: 164, height: 197),
          ),
        ],
      ),
    );
  }
}
