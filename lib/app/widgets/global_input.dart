import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalInput extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String placeholder;
  final String? validatorErrorText;
  final dynamic? validator;
  final String? Function(String val)? changed;
  final VoidCallback? showPasswordOrClear;
  final IconData? icon;
  final bool? isPassword;
  final int? maxLength;
  final Color labelStyle;
  final Color colorStyle;
  final Color borderSide;
  final Color? colorIcon;

  final bool? passwordVisible;

  const GlobalInput({
    Key? key,
    required this.placeholder,
    this.validator,
    this.validatorErrorText,
    this.changed,
    required this.focusNode,
    required this.controller,
    this.showPasswordOrClear,
    this.icon,
    this.isPassword,
    this.passwordVisible,
    this.maxLength,
    required this.labelStyle,
    required this.colorStyle,
    required this.borderSide,
    this.colorIcon,
  }) : super(key: key);

  @override
  State<GlobalInput> createState() => _GlobalInputState();
}

class _GlobalInputState extends State<GlobalInput> {
  late ValueNotifier<String> _text;

  @override
  void initState() {
    super.initState();
    _text = ValueNotifier(widget.controller.text);
    widget.controller.addListener(
      () {
        final String textFromController = widget.controller.text;
        if (textFromController.isEmpty && _text.value.isNotEmpty) {
          _text.value = '';
        } else if (textFromController.isNotEmpty) {
          _text.value = textFromController;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
        maxLength: widget.maxLength,
        onTap: () {
          if (!widget.focusNode.hasFocus) {
            widget.changed?.call(_text.value.isEmpty ? '' : _text.value);
          }
        },
        obscureText: widget.isPassword == false
            ? widget.passwordVisible ?? true
            : widget.passwordVisible ?? false
                ? widget.isPassword ?? true
                : false,
        validator: (v) {
          if (widget.validator != null) {
            final String? error = widget.validator(v);
            if (error != null) {
              return widget.validatorErrorText ?? error;
            }
          }
          return null;
        },
        style: TextStyle(
          color: widget.colorStyle,
        ),
        focusNode: widget.focusNode,
        onChanged: widget.changed,
        decoration: InputDecoration(
          labelText: widget.placeholder,
          counterStyle: const TextStyle(
            color: Colors.black,
          ),
          errorText: widget.validatorErrorText,
          labelStyle: TextStyle(
            color: widget.labelStyle,
            decorationColor: Colors.white,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: widget.borderSide),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderSide,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          suffixIcon: ValueListenableBuilder<String>(
            valueListenable: _text,
            builder: (_, text, child) {
              if (text.isNotEmpty) {
                return child!;
              } else {
                return const SizedBox();
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: CupertinoButton(
                padding: const EdgeInsets.all(10),
                color: widget.colorIcon,
                onPressed: widget.showPasswordOrClear,
                child: Icon(widget.icon),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
