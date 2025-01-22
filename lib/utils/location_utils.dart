import 'package:geolocator/geolocator.dart';

class LocationUtils {
  static final LocationUtils _instance = LocationUtils._internal();

  factory LocationUtils() {
    return _instance;
  }

  LocationUtils._internal();

  Future<Position?> getCurrentLocation() async {
    try {
      // 使用 Geolocator 获取当前位置
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return position;
    } catch (e) {
      print("Error getting location: $e");
      return null;
    }
  }
}
