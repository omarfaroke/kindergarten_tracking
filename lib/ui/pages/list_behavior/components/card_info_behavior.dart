import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_preservation/constants/constants.dart';
import 'package:food_preservation/models/behavior.dart';
import 'package:food_preservation/models/student.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';
import '../../../../util/extensions.dart';

class CardInfoBehavior extends StatelessWidget {
  const CardInfoBehavior({
    Key key,
    @required this.behavior,
  }) : super(key: key);

  final Behavior behavior;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: InkWell(
          child: Card(
            elevation: 7,
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: Container(
                  height: 50,
                  child:
                      FittedBox(child: listBehaviorIcons[behavior.behavior])),
              title: Text(
                'السلوك : ${behavior.behavior}',
                style: TextStyle(
                  color: AppColors.lightPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                ' حصة يوم : ${behavior.date.formatDate()}',
                style: TextStyle(
                  color: AppColors.lightPrimary,
                ),
                maxLines: 1,
              ),
            ),
          ),
        ));
  }
}
