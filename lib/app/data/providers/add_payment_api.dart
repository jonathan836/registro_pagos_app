import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:dio/dio.dart';

import '../../../app_config.dart';
import '../../ui/pages/register/register_model.dart';

class AddPaymentApi {
  final Dio _dio;
  CancelToken? _cancelToken;

  AddPaymentApi(this._dio);

  final _controller = StreamController<List<RegisterModel>?>.broadcast();

  Stream<List<RegisterModel>?> get onResults => _controller.stream;

  Future<RegisterModel> post({
    required dynamic apartment,
    required String name,
    required dynamic amount,
  }) async {
    _cancelToken = CancelToken();
    final response = await _dio.post(
      '${AppConfig.instance.apiHost}addPayment',
      // 'http://172.16.90.115:8091/api/login',
      data: {
        'aparment': apartment,
        'name': name,
        'amount': amount,
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
