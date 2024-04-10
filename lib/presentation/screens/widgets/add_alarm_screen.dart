import 'dart:math';
import 'package:alarm_applications/application/home_notifier.dart';
import 'package:alarm_applications/core/constant/sizes.dart';
import 'package:alarm_applications/models/models.dart';
import 'package:alarm_applications/presentation/widgets/appbar/appbar.dart';
import 'package:alarm_applications/presentation/widgets/padding/main_padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAlarm extends StatefulWidget {
  final bool isEditing;
  final AlarmResponse? alarmToEdit;
  const AddAlarm({super.key, this.isEditing = false, this.alarmToEdit});
  @override
  State<AddAlarm> createState() => _AddAlaramState();
}

class _AddAlaramState extends State<AddAlarm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        title: widget.isEditing ? 'Edit Alarm' : 'Add Alarm',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Column(
              children: [
                Text(
                  context.read<HomeNotifier>().weatherData?.name ?? '',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: context
                          .read<HomeNotifier>()
                          .weatherData
                          ?.weather
                          ?.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Text(context
                                    .read<HomeNotifier>()
                                    .weatherData
                                    ?.weather?[index]
                                    .main ??
                                ''),
                            kWidth10,
                            Text(context
                                    .read<HomeNotifier>()
                                    .weatherData
                                    ?.weather?[index]
                                    .description ??
                                ''),
                          ],
                        );
                      }),
                )
              ],
            ),
          ),
        ],
      ),
      body: MainPadding(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<HomeNotifier>(
              builder: (context, value, child) => SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: CupertinoDatePicker(
                    showDayOfWeek: true,
                    minimumDate: DateTime.now(),
                    dateOrder: DatePickerDateOrder.dmy,
                    onDateTimeChanged: (va) {
                      context.read<HomeNotifier>().updateSelectedDate(va);
                      value.milliseconds = va.microsecondsSinceEpoch;
                      value.notificationtime = va;
                    },
                  ),
                ),
              ),
            ),
            const Text('Title'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CupertinoTextField(
                  placeholder: "Add Label",
                  controller: context.read<HomeNotifier>().controller,
                ),
              ),
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(" Repeat daily"),
                ),
                CupertinoSwitch(
                  value: context.watch<HomeNotifier>().repeat,
                  onChanged: (bool value) {
                    context.read<HomeNotifier>().changeSelected(value);
                  },
                ),
              ],
            ),
            kHeight20,
            Center(
              child: ElevatedButton(
                onPressed: _editAlarm,
                child: const Text("Set Alarm"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editAlarm() {
    //==-=-=-=-=-=-= If creating a edit alarm =-=-=-=
    if (widget.alarmToEdit != null) {
      final alarmToEdit = widget.alarmToEdit!;
      alarmToEdit.label = context.read<HomeNotifier>().controller.text;
      alarmToEdit.dateTime = context.read<HomeNotifier>().selectedDate;
      alarmToEdit.check = context.read<HomeNotifier>().repeat;
      alarmToEdit.when = context.read<HomeNotifier>().name!;
      alarmToEdit.milliseconds = context.read<HomeNotifier>().milliseconds ?? 0;
      context.read<HomeNotifier>().setData();
    } else {
      //==-=-=-=-=-=-= If creating a new alarm =-=-=-=-=
      final randomNumber = Random().nextInt(100);
      context.read<HomeNotifier>().setAlaram(
            context.read<HomeNotifier>().controller.text,
            context.read<HomeNotifier>().selectedDate ?? DateTime.now(),
            context.read<HomeNotifier>().repeat,
            context.read<HomeNotifier>().name!,
            randomNumber,
            context.read<HomeNotifier>().milliseconds ?? 0,
          );
      context.read<HomeNotifier>().setData();
      context.read<HomeNotifier>().secduleNotification(
            context.read<HomeNotifier>().notificationtime,
            randomNumber,
            context.read<HomeNotifier>().controller.text,
          );
    }
    Navigator.pop(context);
  }
}
