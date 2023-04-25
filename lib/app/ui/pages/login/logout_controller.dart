import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/providers/login_api.dart';

class LogoutController extends ChangeNotifier {
  final LoginApi loginApi;

  LogoutController(this.loginApi);

  Future logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final idUser = prefs.getInt('idUser');
    final token = prefs.getString('token');
    try {
      final result = await loginApi.logout(idUser: idUser!, token: token!);
      // await prefs.remove('username');
      await prefs.remove('token');
      await prefs.remove('profile');

      debugPrint('😭 Logout Username: $idUser');
      debugPrint('😭 Logout Password: $token');
      return result;
    } catch (e) {
      debugPrint('Logout: $e');
      return e;
    }
  }
}
