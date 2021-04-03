import 'package:flutter/material.dart';
import 'package:food_preservation/ui/widgets/validators.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ListDropdown extends StatelessWidget {
  const ListDropdown(
      {Key key, this.formControlName, this.hint, this.values, this.prefixIcon, this.lable, this.readOnly =false})
      : super(key: key);
  final String formControlName;
  final String lable;
  final String hint;
  final values;
  final IconData prefixIcon;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> listKeysValues;
    if (values is List) {
      listKeysValues = Map.fromIterables(values, values);
    } else {
      listKeysValues = values;
    }

    return ReactiveDropdownField(
      formControlName: this.formControlName,
      readOnly:readOnly ,
      decoration: InputDecoration(
        // labelText:this.labelText,
        // border: UnderlineInputBorder(),
        border: OutlineInputBorder(),
        prefixIcon: prefixIcon != null ? Icon(this.prefixIcon) : SizedBox(),
        // hintText: this.hintText,
        labelText: this.lable ,
        hintText:this.lable,
        labelStyle: TextStyle(
          fontFamily: 'DinNextLtW23',
        ),

        // helperText: this.hintText,
      ),
      items: listKeysValues.entries
          .map<DropdownMenuItem>((e) => DropdownMenuItem(
              value: e.key,
              child: Center(
                  child: Text(
                e.value.toString(),
                overflow: TextOverflow.ellipsis,
              ))))
          .toList(),
      isExpanded: true,
      validationMessages: (control) => {...validatorRequiredMs},
    );
  }
}
