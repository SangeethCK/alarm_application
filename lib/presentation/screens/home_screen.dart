import 'dart:async';

import 'package:alarm_applications/application/home_notifier.dart';
import 'package:alarm_applications/core/constant/sizes.dart';
import 'package:alarm_applications/core/routes/routes.dart';
import 'package:alarm_applications/presentation/screens/widgets/alarm_card_widget.dart';
import 'package:alarm_applications/presentation/widgets/appbar/appbar.dart';
import 'package:alarm_applications/presentation/widgets/padding/main_padding.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool value = false;

  @override
  void initState() {
    context.read<HomeNotifier>().inituilize(context);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
    context.read<HomeNotifier>().getData();
    context.read<HomeNotifier>().permission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: FloatingActionButton.extended(
              backgroundColor: Colors.deepPurpleAccent,
              shape: const CircleBorder(),
              onPressed: () {
                context.read<HomeNotifier>().editAlaram(null);
                Navigator.pushNamed(context, add);
              },
              label: const Icon(
                Icons.add,
                color: Colors.white,
              )),
        ),
        backgroundColor: const Color(0xfff6f7f7),
        appBar: AppbarWidget(
          centerTitle: true,
          title: 'Smart Alarm',
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, settings);
                },
                icon: const Icon(FluentIcons.settings_24_filled))
          ],
        ),
        body: MainPadding(
          child: ListView(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat.yMEd().add_jms().format(
                            DateTime.now(),
                          ),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                    kWidth20,
                    Text(
                      context.read<HomeNotifier>().weatherData?.name ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
              kHeight10,
              const Text(
                'Your Alarm',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Consumer<HomeNotifier>(builder: (context, alarm, child) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.builder(
                      itemCount: alarm.modelist.length,
                      itemBuilder: (context, index) {
                        final alaram = alarm.modelist[index];

                        return AlarmCardWidget(
                          alaram: alaram,
                          onChanged: (v) {
                            alarm.editSwitch(index, v);

                            alarm.cancelNotification(alarm.modelist[index].id!);
                          },
                        );
                      }),
                );
              }),
            ],
          ),
        ));
  }
}
