import 'package:alarm_applications/application/home_notifier.dart';
import 'package:alarm_applications/core/constant/assets.dart';
import 'package:alarm_applications/core/constant/sizes.dart';
import 'package:alarm_applications/core/constant/style.dart';
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
                      weather,
                      height: 105,
                    ),
                    kHeight10,
                    Text(
                      value.weatherData?.name ?? '',
                      style: textStyleFont24,
                    ),
                    kHeight10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Status :  ',
                          style: textStyleFont24,
                        ),
                        kHeight15,
                        Text(
                          value.weatherData?.weather?[index].main ?? '',
                          style: textStyleFont24,
                        ),
                      ],
                    ),
                    kHeight10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        kHeight10,
                        Text('Description : ', style: textStyleFont24),
                        kHeight10,
                        Text(
                          value.weatherData?.weather?[index].description ?? '',
                          style: textStyleFont24,
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
