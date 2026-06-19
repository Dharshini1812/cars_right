import 'dart:developer';

import 'package:cars_right/core/utils/urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ApiService {
  Future get(String url);
  Future post(String url, Map map);
}

class ApiServiceImpl extends ApiService {
  Ref ref;
  ApiServiceImpl(this.ref);
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: Url.baseUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
  @override
  Future get(String url) async {
    try {
      log("GET Request to: $url");
      final response = await dio.get(url);
      log("Response from $url: ${response.statusCode} - ${response.data}");
      return response;
    } catch (e) {
      log("Error during GET request to $url: $e");
      rethrow;
    }
  }

  @override
  Future post(String url, Map map) async {
    try {
      log('POST => $url');
      log('DATA => $map');
      final response = await dio.post(url, data: map);
      log('Response from $url: ${response.statusCode} - ${response.data}');
      return response;
    } catch (e) {
      log("Error during POST request to $url: $e");
      rethrow;
    }
  }
}
