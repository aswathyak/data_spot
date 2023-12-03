import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonInputTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool isPassword;
  final void Function()? onTap;
  final bool isDigitOnly;
  final bool readOnly;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final Widget? sufixIcon;

  const CommonInputTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.hintText,
    this.validator,
    this.onTap,
    this.readOnly = false,
    this.keyboardType = TextInputType.name,
    this.onChanged,
    this.sufixIcon,
  })  : isPassword = false,
        isDigitOnly = false;

  const CommonInputTextFormField.password({
    super.key,
    required this.labelText,
    required this.controller,
    required this.hintText,
    this.validator,
    this.onTap,
    this.readOnly = false,
    this.keyboardType = TextInputType.name,
    this.onChanged,
    this.sufixIcon,
  })  : isPassword = true,
        isDigitOnly = false;
  const CommonInputTextFormField.digitOnly({
    super.key,
    required this.labelText,
    required this.controller,
    required this.hintText,
    this.validator,
    this.onTap,
    this.readOnly = false,
    this.keyboardType = TextInputType.name,
    this.onChanged,
    this.sufixIcon,
  })  : isPassword = false,
        isDigitOnly = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            color: Colors.black
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          onChanged: onChanged,
          readOnly: readOnly,
          onTap: onTap,
          obscureText: isPassword,
          obscuringCharacter: '\u2B24',
          keyboardType:
              isPassword ? TextInputType.visiblePassword : keyboardType,
          textInputAction:
              isPassword ? TextInputAction.done : TextInputAction.next,
          
          controller: controller,
          inputFormatters: [
            isDigitOnly
                ? FilteringTextInputFormatter.digitsOnly
                : isPassword
                    ? LengthLimitingTextInputFormatter(16)
                    : LengthLimitingTextInputFormatter(50),
          ],
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8)
            ),
            suffixIcon: sufixIcon,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey.shade400
            )
          ),
          validator: validator,
        ),
      ],
    );
  }
}
