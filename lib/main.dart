import 'package:flutter/material.dart';
import 'configs/routes/routes.dart';
import 'configs/routes/routes_name.dart';
import 'dependency_injection/locator.dart';

ServiceLocator dependencyInjector = ServiceLocator();

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensuring that Flutter bindings are initialized
  dependencyInjector
      .servicesLocator(); // Initializing service locator for dependency injection
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.splash, // Initial route
      onGenerateRoute: Routes.generateRoute, // Generating routes
    ),
  );
 }
