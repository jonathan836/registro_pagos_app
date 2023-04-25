import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/global_input.dart';
import '../login_controller.dart';

class LoginInputs extends StatelessWidget {
  const LoginInputs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LoginController>(context);
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          GlobalInput(
            controller: controller.usernameController,
            validatorErrorText: controller.usernameTextV!.error,
            focusNode: controller.usernameFocusNode,
            placeholder: 'Usuario',
            validator: controller.validate,
            changed: controller.usernameChanged,
            // showPasswordOrClear: controller.clearQuery,
            isPassword: false,
            // icon: controller.iconUser,
            passwordVisible: false,
            maxLength: 20,
            labelStyle: Colors.black,
            colorStyle: Colors.black,
            borderSide: Colors.black,
          ),
          const SizedBox(height: 10),
          GlobalInput(
            controller: controller.passwordController,
            validatorErrorText: controller.passwordTextV!.error,
            focusNode: controller.passwordFocusNode,
            placeholder: 'Contraseña',
            changed: controller.passwordChanged,
            showPasswordOrClear: controller.passwordVisibleToggle,
            isPassword: true,
            icon: controller.iconPassword,
            passwordVisible: controller.passwordVisible,
            maxLength: 12,
            labelStyle: Colors.black,
            colorStyle: Colors.black,
            borderSide: Colors.black,
            colorIcon: Colors.black,
          ),
        ],
      ),
    );
  }
}
