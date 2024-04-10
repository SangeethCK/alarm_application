import 'package:alarm_applications/application/home_notifier.dart';
import 'package:alarm_applications/presentation/widgets/appbar/appbar.dart';
import 'package:alarm_applications/presentation/widgets/padding/main_padding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(
        title: 'Settings',
      ),
      body: MainPadding(
        child: Consumer<HomeNotifier>(
          builder: (context, value, child) => ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: value.weatherData?.weather?.length,
            itemBuilder: (context, index) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/weather-app.png',
                      height: 105,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Status : ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          value.weatherData?.weather?[index].main ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Desc : ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          value.weatherData?.weather?[index].description ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
