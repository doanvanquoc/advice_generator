import 'dart:convert';
import 'dart:developer';

import 'package:advice_generator/advice.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class APIService {
  //KHởi tạo singleton
  static final _service = APIService._internal();
  factory APIService() => _service;
  APIService._internal();

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
}

//Khởi tạo biến apiService
final apiService = APIService();
