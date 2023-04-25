import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:registro_pagos/app/data/providers/add_payment_api.dart';
import 'package:registro_pagos/app/helpers/extentions.dart';
import 'package:registro_pagos/app/ui/pages/add_payment/add_payment_model.dart';
import 'package:registro_pagos/app/ui/pages/register/register_model.dart';
import '../../../helpers/validators.dart';

class AddPaymentController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final apartmentController = TextEditingController();
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final aparmentFocusNode = FocusNode();
  final nameFocusNode = FocusNode();
  final amountFocusNode = FocusNode();
  // final passwordFocusNode = FocusNode();

  final AddPaymentApi _addPaymentApi;
  late StreamSubscription _subscription;

  final String _query = '';
  String get query => _query;

  bool passwordVisible = true;
  IconData iconPassword = Icons.visibility_off_rounded;

  ValidationItem? apartmentTextV = ValidationItem(null, null);
  ValidationItem? nameTextV = ValidationItem(null, null);
  ValidationItem? amountTextV = ValidationItem(null, null);
  // ValidationItem? passwordTextV = ValidationItem(null, null);

  AddPaymentController(
    this._addPaymentApi, {
    required dynamic apartment,
    required String name,
    required dynamic amount,
    // required String password,
  }) {
    apartment = apartmentController.text;
    name = nameController.text;
    amount = amountController.text;
    // password = passwordController.text;

    _subscription = _addPaymentApi.onResults.listen(
      (results) {
        debugPrint("🌎 🚩 results $results, $query");
        notifyListeners();
      },
    );
  }

  //Getters
  ValidationItem get apartment => apartmentTextV!;
  ValidationItem get name => nameTextV!;
  ValidationItem get amount => amountTextV!;
  // ValidationItem get password => passwordTextV!;

  bool get validate {
    if (apartmentTextV!.value != null &&
        nameTextV!.value != null &&
        amountTextV!.value != null &&
        apartmentTextV!.value!.isNotEmpty &&
        nameTextV!.value!.isNotEmpty &&
        amountTextV!.value!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  String? aparmentChanged(String text) {
    if (text.isEmpty) {
      apartmentTextV = ValidationItem(null, 'Campo requerido.');
    } else if (text.length < 2) {
      apartmentTextV = ValidationItem(
          null, 'Longitud del dato menor a la mínima requerida.');
    } else if (text.length > 20) {
      apartmentTextV =
          ValidationItem(null, 'La longitud del dato es mayor a la requerida.');
    } else if (!text.isValidName) {
      apartmentTextV = ValidationItem(null, 'Dato Inválido');
    } else {
      apartmentTextV = ValidationItem(text, null);
    }
    notifyListeners();
    return null;
  }

  String? nameChanged(String text) {
    if (text.isEmpty) {
      nameTextV = ValidationItem(null, 'Campo requerido.');
    } else if (text.length < 2) {
      nameTextV = ValidationItem(
          null, 'Longitud del dato menor a la mínima requerida.');
    } else if (text.length > 20) {
      nameTextV =
          ValidationItem(null, 'La longitud del dato es mayor a la requerida.');
    } else if (!text.isValidName) {
      nameTextV = ValidationItem(null, 'Dato Inválido');
    } else {
      nameTextV = ValidationItem(text, null);
    }
    notifyListeners();
    return null;
  }

  String? amountChanged(String text) {
    if (text.isEmpty) {
      amountTextV = ValidationItem(null, 'Campo requerido.');
    } else if (text.length < 6) {
      amountTextV = ValidationItem(
          null, 'Longitud del dato menor a la mínima requerida.');
    } else if (text.length > 20) {
      amountTextV =
          ValidationItem(null, 'La longitud del dato es mayor a la requerida.');
    } else if (!text.isValidUsername) {
      amountTextV = ValidationItem(null, 'Dato Inválido');
    } else {
      amountTextV = ValidationItem(text, null);
    }
    notifyListeners();
    return null;
  }

  // String? passwordChanged(String text) {
  //   if (text.isEmpty) {
  //     passwordTextV = ValidationItem(null, 'Campo requerido.');
  //   } else if (text.length < 6) {
  //     passwordTextV = ValidationItem(
  //         null, 'Longitud del dato menor a la mínima requerida.');
  //   } else if (text.length > 12) {
  //     passwordTextV =
  //         ValidationItem(null, 'La longitud del dato es mayor a la requerida.');
  //   }
  //   // else if (!text.isValidPassword) {
  //   //   passwordTextV = ValidationItem(null, LocaleKeys.invalidData.tr());
  //   // }
  //   else {
  //     passwordTextV = ValidationItem(text, null);
  //   }
  //   notifyListeners();
  //   return null;
  // }

  void passwordVisibleToggle() {
    if (passwordVisible == true) {
      iconPassword = Icons.visibility_rounded;
    } else {
      iconPassword = Icons.visibility_off_rounded;
    }
    passwordVisible = !passwordVisible;

    notifyListeners();
  }

  Future<AddPaymentModel?> addPayment() async {
    final AddPaymentModel result = (await _addPaymentApi.post(
      apartment: apartmentController.text as int,
      name: nameController.text,
      amount: amountController.text,
    )) as AddPaymentModel;

    return result;
  }
}
