import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_preservation/constants/constants.dart';
import 'package:food_preservation/models/behavior.dart';
import 'package:food_preservation/models/follow_exit.dart';
import 'package:food_preservation/models/student.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';
import '../../../../util/extensions.dart';

class CardInfoFollowExit extends StatelessWidget {
  const CardInfoFollowExit({
    Key key,
    @required this.followExit,
  }) : super(key: key);

  final FollowExit followExit;

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
                  child: FittedBox(
                    child: (followExit.timeExit != null &&
                            followExit.timeExit.isNotEmpty)
                        ? Icon(Icons.check_circle_outline , color: Colors.green,)
                        : Icon(Icons.remove_circle),
                  )),
              title: Text(
                'وقت الخروج : ${followExit.timeExit}',
                style: TextStyle(
                  color: AppColors.lightPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                ' حصة يوم : ${followExit.date.formatDate()}',
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
