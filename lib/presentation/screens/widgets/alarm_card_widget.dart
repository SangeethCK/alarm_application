import 'package:alarm_applications/application/home_notifier.dart';
import 'package:alarm_applications/core/constant/assets.dart';
import 'package:alarm_applications/core/constant/sizes.dart';
import 'package:alarm_applications/core/constant/style.dart';
import 'package:alarm_applications/core/constant/validations.dart';
import 'package:alarm_applications/models/alaram_response.dart';
import 'package:alarm_applications/presentation/screens/widgets/add_alarm_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlarmCardWidget extends StatelessWidget {
  const AlarmCardWidget(
      {super.key, required this.alaram, required this.onChanged});

  final AlarmResponse alaram;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    String result = regex.stringMatch(alaram.dateTime ?? '') ?? '';
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xfffefeff),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 0,
                child: Text(
                  '${alaram.label}',
                  style: labelStyle,
                ),
              ),
              kWidth18,
              result == 'AM'
                  ? Image.asset(
                      am,
                      height: 50,
                    )
                  : Image.asset(
                      pm,
                      height: 50,
                    ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    context.read<HomeNotifier>().editAlaram(alaram);
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
                  icon: Image.asset(
                    'assets/icons/edit (1).png',
                    height: 20,
                    color: Colors.deepPurpleAccent,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${alaram.dateTime}',
                style: dateStyle,
              ),
              Consumer<HomeNotifier>(
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      activeColor: Colors.deepPurpleAccent,
                      value: (alaram.milliseconds! <
                              DateTime.now().microsecondsSinceEpoch)
                          ? false
                          : alaram.check ?? false,
                      onChanged: (v) {
                        onChanged(v);
                      },
                    ),
                  );
                },
              )
            ],
          ),
          Text(
            alaram.when ?? '',
            style: subHead,
          ),
        ],
      ),
    );
  }
}
