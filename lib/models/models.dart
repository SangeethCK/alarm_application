import 'dart:developer';

import 'package:intl/intl.dart';

class AlarmResponse {
  String? label;
  DateTime? dateTime;
  bool? check;
  String? when;
  int? id;
  int? milliseconds;

  AlarmResponse(
      {this.label,
      this.dateTime,
      this.check,
      this.when,
      this.id,
      this.milliseconds});

  factory AlarmResponse.fromJson(Map<String, dynamic> json) => AlarmResponse(
        label: json["label"],
        dateTime:
            json["dateTime"] != null ? _parseDateTime(json["dateTime"]) : null,
        check: json["check"],
        when: json["when"],
        id: json["id"],
        milliseconds: json["milliseconds"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "dateTime": dateTime?.toIso8601String(),
        "check": check,
        "when": when,
        "id": id,
        "milliseconds": milliseconds,
      };
}

DateTime? _parseDateTime(String? dateTimeString) {
  if (dateTimeString == null) return null;

  // Parse date-time string in custom format
  try {
    // Modify the format string according to your date-time format
    return DateFormat("dd/MM/yyyy HH:mm:ss").parse(dateTimeString);
  } catch (e) {
    log("Error parsing date-time: $e");
    return null;
  }
}
