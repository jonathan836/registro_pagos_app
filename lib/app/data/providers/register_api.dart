import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../app_config.dart';
import '../../ui/pages/register/register_model.dart';

class RegisterApi {
  final Dio _dio;
  CancelToken? _cancelToken;

  RegisterApi(this._dio);

  final _controller = StreamController<List<RegisterModel>?>.broadcast();

  Stream<List<RegisterModel>?> get onResults => _controller.stream;

  Future<RegisterModel> post({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    _cancelToken = CancelToken();
    final response = await _dio.post(
      '${AppConfig.instance.apiHost}register',
      // 'http://172.16.90.115:8091/api/login',
      data: {
        'firstName': firstName,
        'lastName': lastName,
        'username': email,
        'password': password,
      },
      cancelToken: _cancelToken,
    );

    final data = RegisterModel.fromJson(response.data);

    return data;
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
