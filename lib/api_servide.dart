import 'dart:convert';
import 'dart:developer';

import 'package:advice_generator/advice.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Service {
  //KHởi tạo singleton
  static final _service = Service._internal();
  factory Service() => _service;
  Service._internal();

//Hàm fetch Data từ api
  Future fetchAdvice() async {
    const endPoint = 'https://api.adviceslip.com/advice';
    final uri = Uri.parse(endPoint);
    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['slip'];
        final advice = Advice.fromJson(data);
        return advice;
      }
    } catch (e) {
      log(e.toString());
    }
  }

//Hàm lưu dữ liệu xuống local

  Future saveToLocal(Advice advice) async {
    log('saved');
    final pref = await SharedPreferences.getInstance();
    final adviceJson = jsonEncode(advice.toJson());
    await pref.setString('advice', adviceJson);
  }
}

//Khởi tạo biến apiService
final service = Service();
