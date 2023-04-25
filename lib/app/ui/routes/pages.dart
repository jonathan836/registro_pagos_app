import 'package:flutter/widgets.dart';
import 'package:registro_pagos/app/ui/pages/add_payment/add_payment_page.dart';
import 'package:registro_pagos/app/ui/pages/payment_record/payment_record_page.dart';
import 'package:registro_pagos/app/ui/routes/routes.dart';

import '../pages/home/home_page.dart';
import '../pages/login/login_page.dart';
import '../pages/register/register_page.dart';

Map<String, Widget Function(BuildContext context)> appRoutes() {
  return {
    Routes.HOME: (_) => const HomePage(),
    Routes.LOGIN: (_) => LoginPage(
          username: '',
          password: '',
        ),
    Routes.REGISTER: (_) =>
        RegisterPage(firstName: '', lastName: '', username: '', password: ''),
    Routes.PAYMENT_RECORD: (_) => const PaymentRecordPage(),
    Routes.ADD_PAYMENT: (_) =>
        AddPaymentPage(apartment: '', name: '', amount: '')
  };
}
