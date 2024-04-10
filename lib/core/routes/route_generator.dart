// ignore_for_file: unused_local_variable

import 'package:alarm_applications/core/routes/routes.dart';
import 'package:alarm_applications/presentation/screens/home_screen.dart';
import 'package:alarm_applications/presentation/screens/settings_screen.dart';
import 'package:alarm_applications/presentation/screens/widgets/add_alarm_screen.dart';
import 'package:alarm_applications/presentation/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final Object? args = routeSettings.arguments;

    switch (routeSettings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case add:
        return MaterialPageRoute(builder: (_) => const AddAlarm());
      case settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute({String? error, bool argsError = false}) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: const AppbarWidget(
          title: 'Error',
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            error ?? '${argsError ? 'Arguments' : 'Navitation'} Error',
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
