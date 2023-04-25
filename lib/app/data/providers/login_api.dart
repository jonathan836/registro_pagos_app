import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:registro_pagos/app/ui/pages/login/logout_model.dart';

import '../../../app_config.dart';
import '../../ui/pages/login/login_model.dart';

class LoginApi {
  final Dio _dio;
  CancelToken? _cancelToken;

  LoginApi(this._dio);

  final _controller = StreamController<List<LoginModel>?>.broadcast();

  Stream<List<LoginModel>?> get onResults => _controller.stream;

  Future<LoginModel> post({
    required String email,
    required String password,
  }) async {
    _cancelToken = CancelToken();
    final response = await _dio.post(
      '${AppConfig.instance.apiHost}login',
      // 'http://172.16.90.115:8091/api/login',
      data: {
        'username': email,
        'password': password,
      },
      cancelToken: _cancelToken,
    );

    final data = LoginModel.fromJson(response.data);

    return data;
  }

  Future<LogoutModel?>? logout({
    required int idUser,
    required String token,
  }) async {
    try {
      _cancelToken = CancelToken();
      final response = await _dio.post(
        '${AppConfig.instance.apiHost}logout',
        data: {
          'idUser': idUser,
        },
        options: Options(headers: {
          'auth-token': token,
        }),
        cancelToken: _cancelToken,
      );

      final data = LogoutModel.fromJson(response.data);

      print(data);
      return data;
    } catch (e) {
      log("💀Error $e");
      return null;
    }
  }

  void cancel() {
    if (_cancelToken != null) {
      _cancelToken!.cancel();
      _cancelToken = null;
    }
  }

  void dispose() {
    cancel();
    _controller.close();
  }
}
