import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:registro_pagos/app/ui/pages/add_payment/add_payment_controller.dart';

import '../../../../widgets/global_input.dart';

class AddPaymentInput extends StatelessWidget {
  const AddPaymentInput({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AddPaymentController>(context);
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          GlobalInput(
            controller: controller.apartmentController,
            keyboardType: TextInputType.number,
            validatorErrorText: controller.apartmentTextV!.error,
            focusNode: controller.aparmentFocusNode,
            placeholder: 'Nº de Apartamento',
            validator: controller.validate,
            changed: controller.aparmentChanged,
            // showPasswordOrClear: controller.clearQuery,
            isPassword: false,
            // icon: controller.iconUser,
            passwordVisible: false,
            maxLength: 5,
            labelStyle: Colors.black,
            colorStyle: Colors.black,
            borderSide: Colors.black,
          ),
          const SizedBox(height: 10),
          GlobalInput(
            controller: controller.nameController,
            keyboardType: TextInputType.text,
            validatorErrorText: controller.nameTextV!.error,
            focusNode: controller.nameFocusNode,
            placeholder: 'Nombre',
            validator: controller.validate,
            changed: controller.nameChanged,
            isPassword: false,
            passwordVisible: false,
            maxLength: 20,
            labelStyle: Colors.black,
            colorStyle: Colors.black,
            borderSide: Colors.black,
          ),
          GlobalInput(
            controller: controller.amountController,
            keyboardType: TextInputType.number,
            validatorErrorText: controller.amountTextV!.error,
            focusNode: controller.amountFocusNode,
            placeholder: 'Monto',
            validator: controller.validate,
            changed: controller.amountChanged,
            isPassword: false,
            passwordVisible: false,
            maxLength: 12,
            labelStyle: Colors.black,
            colorStyle: Colors.black,
            borderSide: Colors.black,
          ),
        ],
      ),
    );
  }
}
