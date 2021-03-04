import 'package:flutter/material.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      backgroundColor: AppColors.lightPrimary,
    ));
  }
}
