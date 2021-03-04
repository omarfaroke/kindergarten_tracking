import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key key,
    @required this.formControlName,
    @required this.hintText,
    this.labelText,
    this.validationMessages,
    @required this.prefixIcon,
    this.onSubmitted,
    this.textInputAction,
    this.suffix,
    this.minLines,
    this.maxLines,
    this.isNumber = false,
    this.readOnly = false,
    this.obscureText = false,
  }) : super(key: key);
  final String formControlName;
  final String hintText;
  final String labelText;
  final IconData prefixIcon;
  final Widget suffix;
  final bool isNumber;
  final bool readOnly;
  final bool obscureText;
  final int minLines;
  final int maxLines;
  final void Function() onSubmitted;
  final TextInputAction textInputAction;
  final Map<String, String> Function(AbstractControl<dynamic>)
      validationMessages;
  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: this.formControlName,
      onSubmitted: this.onSubmitted,
      minLines: minLines ?? 1,
      maxLines: maxLines ?? 1,
      obscureText: this.obscureText,
      readOnly: this.readOnly,
      keyboardType: this.isNumber ? TextInputType.number : null,
      inputFormatters: this.isNumber
          ? [FilteringTextInputFormatter.digitsOnly]
          : [],
      textInputAction: this.textInputAction ?? TextInputAction.next,
      validationMessages: this.validationMessages,
      decoration: InputDecoration(
        // labelText:this.labelText,
        // border: UnderlineInputBorder(),
        border: OutlineInputBorder(),
        prefixIcon: Icon(this.prefixIcon),
        // hintText: this.hintText,
        labelText: this.hintText,
        labelStyle: TextStyle(  fontFamily: 'DinNextLtW23',),
        
        // helperText: this.hintText,
        suffix: this.suffix,
      ),
    );
  }
}
