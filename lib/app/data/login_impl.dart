import 'package:registro_pagos/app/data/providers/login_api.dart';
import 'package:registro_pagos/app/ui/pages/login/logout_model.dart';

import '../ui/pages/login/login_model.dart';

class LoginImpl implements LoginApi {
  // Implementar LOGIN Y LOGOUT en la API
  final LoginApi _loginApi;

  LoginImpl(this._loginApi);

  @override
  Future<LoginModel> post({
    required String email,
    required String password,
  }) {
    // Recibe los datos(username y password) y retorna un metodo de la API
    return _loginApi.post(email: email, password: password);
  }

  @override
  Future<LogoutModel?>? logout({
    required int idUser,
    required String token,
  }) {
    // Recibe el nombre de usuario y retorna un metodo de la API
    return _loginApi.logout(idUser: idUser, token: token);
  }

  @override
  void cancel() {
    _loginApi.cancel(); // Destruye la pagina actual(Login API)
  }

  @override
  void dispose() {
    _loginApi.dispose();
  }

  @override
  Stream<List<LoginModel>?> get onResults => _loginApi.onResults;
}
