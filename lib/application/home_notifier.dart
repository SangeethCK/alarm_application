import 'dart:convert';
import 'dart:developer';

import 'package:alarm_applications/infrastructure/home_repository.dart';
import 'package:alarm_applications/models/models.dart';
import 'package:alarm_applications/models/weather_response.dart';
import 'package:alarm_applications/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

class HomeNotifier extends ChangeNotifier {
  late SharedPreferences preferences;
  List<AlarmResponse> modelist = [];
  List<String> listofstring = [];
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  TextEditingController controller = TextEditingController();
  String? dateTime;
  late BuildContext context;
  bool repeat = false;
  DateTime notificationtime = DateTime.now();
  String? name = "none";
  int? milliseconds;

//=-=-=-=-=-= Set Alarams =-=-=-=-=-=-=
  setAlaram(String label, DateTime dateTime, bool check, String repeat, int id,
      int milliseconds) {
    modelist.add(AlarmResponse(
        label: label,
        dateTime: dateTime,
        check: check,
        when: repeat,
        id: id,
        milliseconds: milliseconds));
    notifyListeners();
  }

//=-=-=-=-=-= Edit Switch =-=-=-=-=-=-=
  editSwitch(int index, bool check) {
    modelist[index].check = check;
    notifyListeners();
  }
//=-=-=-= Selected Swicth =-=-=

  changeSelected(bool value) {
    repeat = value;
    name = repeat ? "Everyday" : "none";
    notifyListeners();
  }

  DateTime _selectedDate = DateTime.now();

  //=-=-=-=-= Getter for selected date =-=-=-=-=-=
  DateTime get selectedDate => _selectedDate;

  void updateSelectedDate(DateTime newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }

  //=-=-=-=-= Edit Alarams =-=-=-=-=-=
  editAlaram(AlarmResponse? alaram) {
    if (alaram != null) {
      controller.text = alaram.label ?? '';
      _selectedDate = alaram.dateTime != null
          ? alaram.dateTime ?? DateTime.now()
          : DateTime.now();
      repeat = alaram.check ?? false;
      milliseconds = alaram.milliseconds;
    } else {
      controller.clear();
      _selectedDate = DateTime.now();
      repeat = false;
    }
    notifyListeners();
  }

//=-=-=-=-=-= Load Data =-=-=-=-=
  getData() async {
    preferences = await SharedPreferences.getInstance();
    List<String>? cominglist = preferences.getStringList("data");
    if (cominglist == null) {
    } else {
      modelist = cominglist
          .map((e) => AlarmResponse.fromJson(json.decode(e)))
          .toList();

      notifyListeners();
    }
  }
//=-=-=-=-=-= Set Data =-=-=-=-=

  setData() {
    listofstring = modelist.map((e) => json.encode(e.toJson())).toList();
    preferences.setStringList("data", listofstring);

    notifyListeners();
  }

//=-=-=-= Delete Alarm =-=-=-=-=
  void deleteAlarm(int id) {
    modelist.removeWhere((alarm) => alarm.id == id);
    setData();
    notifyListeners();
  }

  inituilize(
    con,
  ) async {
    context = con;
    var androidInitilize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSinitilize = const DarwinInitializationSettings();
    var initilizationsSettings =
        InitializationSettings(android: androidInitilize, iOS: iOSinitilize);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin!.initialize(initilizationsSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse,
  ) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(context,
        MaterialPageRoute<void>(builder: (context) => const HomeScreen()));
  }

//=-=-=-= Show Notification =-=-=-=-=
  showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin!.show(
        0, 'plain title', 'plain body', notificationDetails,
        payload: 'item x');
  }

//=-=-=-= Schedule Notification =-=-=-=-=
  secduleNotification(DateTime datetim, int randomnumber, String label) async {
    int newtime =
        datetim.millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch;

    DateTime scheduledDate =
        DateTime.now().add(Duration(milliseconds: newtime));
    tz.TZDateTime scheduledDateLocal =
        tz.TZDateTime.from(scheduledDate, tz.local);

    log('Scheduled Date: $scheduledDate');

    await flutterLocalNotificationsPlugin?.zonedSchedule(
        randomnumber,
        label,
        DateFormat().format(DateTime.now()),
        scheduledDateLocal,
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description',
                sound: RawResourceAndroidNotificationSound("alarm"),
                autoCancel: false,
                playSound: true,
                priority: Priority.max)),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

//=-=-=-= Cancel Notification =-=-=-=-=
  cancelNotification(int notificationid) async {
    await flutterLocalNotificationsPlugin!.cancel(notificationid);
  }

  //=-=-=-=-= Fetch Weather =-=-=-=-=-=
  WeatherResponse? _weatherData;
  bool _isLoading = false;

  WeatherResponse? get weatherData => _weatherData;
  bool get isLoading => _isLoading;

  Future<void> fetchWeatherData() async {
    try {
      _isLoading = true;
      final res = await HomeRepository().fetchWeather();
      _weatherData = res.fold(
        (exception) {
          debugPrint('Error loading weather: $exception');
          return null;
        },
        (weatherResponse) => weatherResponse,
      );
      notifyListeners();
    } finally {
      _isLoading = false;
    }
  }

  

  //=-=-=-= Permission Handler =-=-=-=

  Future<void> permission() async {
    if (await Permission.location.request().isGranted) {
      fetchWeatherData();
    } else {
      log('Why');
    }
  }
}
