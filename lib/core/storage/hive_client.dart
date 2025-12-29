import 'package:hive_flutter/hive_flutter.dart';

class HiveClient {
  static Future<void> init() async {
    await Hive.initFlutter();
  }
}
