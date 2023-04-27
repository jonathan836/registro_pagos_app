import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:registro_pagos/app/ui/pages/add_payment/add_payment_model.dart';

import '../../../app_config.dart';
import '../../ui/pages/register/register_model.dart';

class AddPaymentApi {
  final Dio _dio;
  CancelToken? _cancelToken;

  AddPaymentApi(this._dio);

  final _controller = StreamController<List<AddPaymentModel>?>.broadcast();

  Stream<List<AddPaymentModel>?> get onResults => _controller.stream;

  Future<AddPaymentModel> post({
    required String apartment,
    required String name,
    required String amount,
  }) async {
    _cancelToken = CancelToken();
    final response = await _dio.post(
      '${AppConfig.instance.apiHost}addPayment',
      data: {
        'apartment': apartment,
        'name': name,
        'amount': amount,
      },
      cancelToken: _cancelToken,
    );

    final data = AddPaymentModel.fromJson(response.data);

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
