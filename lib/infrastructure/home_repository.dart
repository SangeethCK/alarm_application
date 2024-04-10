
import 'package:alarm_applications/core/constant/base_url.dart';
import 'package:alarm_applications/core/intercepters/intercepters.dart';
import 'package:alarm_applications/models/weather_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

class HomeRepository {
//=-=-=-=-= Wether API =-=-=-=-=-=
  Future<Either<Exception, WeatherResponse>> fetchWeather() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    Response response = await NetworkProvider().get(
        '$baseUrl?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey');
    if (response.statusCode == 200) {
      return Right(WeatherResponse.fromJson(response.data));
    } else {
      return Left(
          Exception('Failed to fetch weather data: ${response.statusCode}'));
    }
  }
}
