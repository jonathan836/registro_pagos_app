import 'dart:async';
import 'package:flutter/material.dart';
import 'package:registro_pagos/app/helpers/extentions.dart';
import 'package:registro_pagos/app/ui/pages/register/register_model.dart';
import '../../../data/providers/register_api.dart';
import '../../../helpers/validators.dart';

class RegisterController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameFocusNode = FocusNode();
  final lastNameFocusNode = FocusNode();
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  final RegisterApi _registerApi;
  late StreamSubscription _subscription;

  final String _query = '';
  String get query => _query;

  bool passwordVisible = true;
  IconData iconPassword = Icons.visibility_off_rounded;

  ValidationItem? firstNameTextV = ValidationItem(null, null);
  ValidationItem? lastNameTextV = ValidationItem(null, null);
  ValidationItem? usernameTextV = ValidationItem(null, null);
  ValidationItem? passwordTextV = ValidationItem(null, null);

  RegisterController(
    this._registerApi, {
    required String firstName,
    required String lastName,
    required String username,
    required String password,
  }) {
    firstName = firstNameController.text;
    lastName = lastNameController.text;
    username = usernameController.text;
    password = passwordController.text;

    _subscription = _registerApi.onResults.listen(
      (results) {
        debugPrint("🌎 🚩 results $results, $query");
        notifyListeners();
      },
    );
  }

  //Getters
  ValidationItem get firstName => firstNameTextV!;
  ValidationItem get lastName => lastNameTextV!;
  ValidationItem get username => usernameTextV!;
  ValidationItem get password => passwordTextV!;

  bool get validate {
    if (passwordTextV!.value != null &&
        usernameTextV!.value != null &&
        firstNameTextV!.value != null &&
        lastNameTextV!.value != null &&
        passwordTextV!.value!.isNotEmpty &&
        usernameTextV!.value!.isNotEmpty &&
        firstNameTextV!.value!.isNotEmpty &&
        lastNameTextV!.value!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  String? firstNameChanged(String text) {
    if (text.isEmpty) {
      firstNameTextV = ValidationItem(null, 'Campo requerido.');
    } else if (text.length < 2) {
      firstNameTextV = ValidationItem(
          null, 'Longitud del dato menor a la mínima requerida.');
    } else if (text.length > 20) {
      firstNameTextV =
          ValidationItem(null, 'La longitud del dato es mayor a la requerida.');
    } else if (!text.isValidName) {
      firstNameTextV = ValidationItem(null, 'Dato Inválido');
    } else {
      firstNameTextV = ValidationItem(text, null);
    }
    notifyListeners();
    return null;
  }

  String? lastNameChanged(String text) {
    if (text.isEmpty) {
      lastNameTextV = ValidationItem(null, 'Campo requerido.');
    } else if (text.length < 2) {
      lastNameTextV = ValidationItem(
          null, 'Longitud del dato menor a la mínima requerida.');
    } else if (text.length > 20) {
      lastNameTextV =
          ValidationItem(null, 'La longitud del dato es mayor a la requerida.');
    } else if (!text.isValidName) {
      lastNameTextV = ValidationItem(null, 'Dato Inválido');
    } else {
      lastNameTextV = ValidationItem(text, null);
    }
    notifyListeners();
    return null;
  }

  String? usernameChanged(String text) {
    if (text.isEmpty) {
      usernameTextV = ValidationItem(null, 'Campo requerido.');
    } else if (text.length < 5) {
      usernameTextV = ValidationItem(
          null, 'Longitud del dato menor a la mínima requerida.');
    } else if (text.length > 20) {
      usernameTextV =
          ValidationItem(null, 'La longitud del dato es mayor a la requerida.');
    } else if (!text.isValidUsername) {
      usernameTextV = ValidationItem(null, 'Dato Inválido');
    } else {
      usernameTextV = ValidationItem(text, null);
    }
    notifyListeners();
    return null;
  }

  String? passwordChanged(String text) {
    if (text.isEmpty) {
      passwordTextV = ValidationItem(null, 'Campo requerido.');
    } else if (text.length < 6) {
      passwordTextV = ValidationItem(
          null, 'Longitud del dato menor a la mínima requerida.');
    } else if (text.length > 12) {
      passwordTextV =
          ValidationItem(null, 'La longitud del dato es mayor a la requerida.');
    }
    // else if (!text.isValidPassword) {
    //   passwordTextV = ValidationItem(null, LocaleKeys.invalidData.tr());
    // }
    else {
      passwordTextV = ValidationItem(text, null);
    }
    notifyListeners();
    return null;
  }

  void passwordVisibleToggle() {
    if (passwordVisible == true) {
      iconPassword = Icons.visibility_rounded;
    } else {
      iconPassword = Icons.visibility_off_rounded;
    }
    passwordVisible = !passwordVisible;

    notifyListeners();
  }

  Future<RegisterModel?> submitRegisterData() async {
    final RegisterModel result = await _registerApi.post(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: usernameController.text,
      password: passwordController.text,
    );

    return result;
  }
}
