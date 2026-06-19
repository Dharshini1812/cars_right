import 'dart:developer';

import 'package:cars_right/core/utils/urls.dart';
import 'package:cars_right/features/login/data/model/send_otp_model.dart';
import 'package:cars_right/features/login/data/model/verify_otp_model.dart';
import 'package:cars_right/features/login/presentation/logic/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class LoginRemoteDataSource {
  Future<SendOtpModel> sendOtp(SendOtpModel model);
  Future<VerifyOtpModel> verifyOtp(VerifyOtpModel model);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final Ref ref;
  LoginRemoteDataSourceImpl(this.ref);
  @override
  @override
  Future<SendOtpModel> sendOtp(SendOtpModel params) async {
    try {
      String url = Url.sendOtp;

      Map map = SendOtpModel(
        phone: params.phone,
        isRegistered: true,
        role: 'VALUATOR',
        source: 2,
      ).toJson();

      var body = await ref.read(apiService).post(url, map);
      log('Response from API: $body');

      if (body == null) {
        throw 'API request failed';
      }

      if (body['success'] != true) {
        throw body['message'] ?? 'OTP sending failed';
      }

      final model = SendOtpModel.fromJson(body);
      return model;
    } catch (e) {
      log('Error occurred while sending OTP: $e');
      rethrow;
    }
  }

  @override
  Future<VerifyOtpModel> verifyOtp(VerifyOtpModel params) async {
    try {
      String url = Url.verifyOtp;
      Map map = VerifyOtpModel(
        phone: params.phone,
        otp: params.otp,
        isRegistered: true, // Simulated response
        role: 'VALUATOR', // Simulated response
        source: 2,
      ).toJson();

      var body = await ref.read(apiService).post(url, map);
      log('Response from API: $body');

      if (body == null) {
        throw 'API request failed or returned a null response';
      }
      if (body.isEmpty) {
        throw 'Invalid Credentials';
      }
      var model = VerifyOtpModel.fromJson(body['data']);
      return model;
    } catch (e) {
      log('Error occurred while verifying OTP: $e');
      rethrow;
    }
  }
}
