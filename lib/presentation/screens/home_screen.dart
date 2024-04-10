import 'dart:async';
import 'package:alarm_applications/application/home_notifier.dart';
import 'package:alarm_applications/core/constant/sizes.dart';
import 'package:alarm_applications/presentation/screens/settings_screen.dart';
import 'package:alarm_applications/presentation/screens/widgets/add_alarm_screen.dart';
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
    context.read<HomeNotifier>().fetchWeatherData();
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddAlarm()));
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
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const SettingsScreen();
                  }));
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

                        return Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xfffefeff),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 0,
                                    child: Text(
                                      '${alaram.label}',
                                      style: const TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 23),
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        context
                                            .read<HomeNotifier>()
                                            .editAlaram(alaram);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AddAlarm(
                                              isEditing: true,
                                              alarmToEdit: alaram,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                          FluentIcons.note_edit_24_filled)),
                                  IconButton(
                                      onPressed: () {
                                        context
                                            .read<HomeNotifier>()
                                            .deleteAlarm(alaram.id ?? 0);
                                      },
                                      icon: const Icon(
                                        FluentIcons.delete_24_filled,
                                        color: Colors.red,
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat.jm().format(
                                        alaram.dateTime ?? DateTime.now()),
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Consumer<HomeNotifier>(
                                    builder: (context, value, child) {
                                      return Transform.scale(
                                        scale: 0.8,
                                        child: Switch(
                                          activeColor: Colors.deepPurpleAccent,
                                          value: true,
                                          onChanged: (v) {
                                            value.editSwitch(index, v);

                                            value.cancelNotification(
                                                alarm.modelist[index].id!);
                                          },
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                              Text(
                                alarm.modelist[index].when!,
                                style: const TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                );
              }),
            ],
          ),
        ));
  }
}
