import 'package:alarm_applications/application/home_notifier.dart';
import 'package:alarm_applications/models/models.dart';
import 'package:alarm_applications/presentation/screens/widgets/add_alarm_screen.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AlarmCardWidget extends StatelessWidget {
  const AlarmCardWidget(
      {super.key, required this.alaram, required this.onChanged});

  final AlarmResponse alaram;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  icon: const Icon(FluentIcons.note_edit_24_filled)),
              IconButton(
                  onPressed: () {
                    context.read<HomeNotifier>().deleteAlarm(alaram.id ?? 0);
                  },
                  icon: const Icon(
                    FluentIcons.delete_24_filled,
                    color: Colors.red,
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat.jm().format(alaram.dateTime ?? DateTime.now()),
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
                        onChanged(v);
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  );
                },
              )
            ],
          ),
          Text(
            alaram.when ?? '',
            style: const TextStyle(
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}