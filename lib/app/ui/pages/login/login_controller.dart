import 'dart:async';
// import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:registro_pagos/app/helpers/extentions.dart';
// import 'package:google_maps_dm/generated/locale_keys.g.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/providers/login_api.dart';
import '../../../helpers/validators.dart';
import 'login_model.dart';

class LoginController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  final LoginApi _loginApi;
  late StreamSubscription _subscription;

  final String _query = '';
  String get query => _query;
  // final List<LoginModel>? _login = [];
  // List<LoginModel>? get login => _login;

  bool passwordVisible = true;
  IconData iconPassword = Icons.visibility_off_rounded;
  // IconData iconUser = Icons.clear_rounded;

  ValidationItem? usernameTextV = ValidationItem(null, null);
  ValidationItem? passwordTextV = ValidationItem(null, null);

  LoginController(
    this._loginApi, {
    required String username,
    required String password,
  }) {
    username = usernameController.text;
    password = passwordController.text;

    _subscription = _loginApi.onResults.listen(
      (results) {
        print("🌎 🚩 results $results, $query");
        notifyListeners();
      },
    );
  }

  //Getters
  ValidationItem get username => usernameTextV!;
  ValidationItem get password => passwordTextV!;
  bool get validate {
    if (passwordTextV!.value != null &&
        usernameTextV!.value != null &&
        passwordTextV!.value!.isNotEmpty &&
        usernameTextV!.value!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  // get passwordVisibleChange => passwordVisibleToggle;

  String? usernameChanged(String text) {
    if (text.isEmpty) {
      usernameTextV = ValidationItem(null, 'Campo requerido.');
    } else if (text.length < 6) {
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

/*
  void clearQuery() {
    if (usernameTextV!.value == null) {
      usernameController.text = '';
      usernameController.clear();
      usernameTextV = ValidationItem(null, null);
    }
    iconUser = Icons.close_rounded;
    validate;
    notifyListeners();
  }
  */

  void passwordVisibleToggle() {
    if (passwordVisible == true) {
      iconPassword = Icons.visibility_rounded;
    } else {
      iconPassword = Icons.visibility_off_rounded;
    }
    passwordVisible = !passwordVisible;

    notifyListeners();
  }

  Future<LoginModel?> submitData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final pastName = prefs.getString('username');
    if (pastName != usernameController.text) {
      await prefs.remove('token');
    }
    await prefs.setString('username', usernameController.text);

    final LoginModel result = await _loginApi.post(
      email: usernameController.text,
      password: passwordController.text,
    );

    return result;
  }
}
