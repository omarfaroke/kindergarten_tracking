import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_preservation/constants/constants.dart';
import 'package:food_preservation/models/behavior.dart';
import 'package:food_preservation/models/follow_exit.dart';
import 'package:food_preservation/models/student.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';
import 'package:food_preservation/ui/widgets/list_drop_down.dart';

class CardInfoStudent extends StatelessWidget {
  const CardInfoStudent({
    Key key,
    @required this.student,
    this.onEditFollowExit,
    this.onEditBehavior,
    this.behavior,
    this.followExit,
  }) : super(key: key);

  final Student student;
  final Behavior behavior;
  final FollowExit followExit;
  final Function(FollowExit obj, bool value) onEditFollowExit;
  final Function(Behavior behavior, String value) onEditBehavior;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Card(
          elevation: 7,
          margin: EdgeInsets.all(8),
          child: Column(
            children: [
              ListTile(
                leading: imageUser(student),
                title: Text(
                  student.name,
                  style: TextStyle(
                    color: AppColors.lightPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  ' مستوى ${student.level}',
                  style: TextStyle(
                    color: AppColors.lightPrimary,
                  ),
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'السلوك : ',
                          style: TextStyle(
                            color: AppColors.lightPrimary,
                            fontSize: 18,
                          ),
                          maxLines: 1,
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: behavior.behavior,
                            onChanged: (v) => onEditBehavior(behavior, v),
                            items: listBehaviorIcons.entries
                                .map<DropdownMenuItem<String>>(
                                  (e) => DropdownMenuItem<String>(
                                    value: e.key,
                                    child: Center(child: e.value),
                                  ),
                                )
                                .toList(),
                            // isExpanded: true,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'تأكيد خروج الطالب : ',
                          style: TextStyle(
                            color: AppColors.lightPrimary,
                            fontSize: 18,
                          ),
                          maxLines: 1,
                        ),
                        Checkbox(
                          // checkColor: Colors.amber,
                          activeColor: AppColors.lightPrimary,
                          value: !(followExit.timeExit != null && followExit.timeExit.isNotEmpty),
                          onChanged: (v) => onEditFollowExit(followExit, v),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget imageUser(student) {
    List<String> shorCutName = student.name.trim().split(" ");

    shorCutName.first = shorCutName.first.toUpperCase();

    Widget pictureName = Container(
      height: 90,
      width: 60,
      decoration: BoxDecoration(
//        border: Border.all(color: AppColors.textDarkColor, width: 2.0),
//        borderRadius: BorderRadius.circular(40.0),
        shape: BoxShape.circle,
      ),
      child: FittedBox(
        child: CircleAvatar(
          backgroundColor: AppColors.lightAccent,
          child: Text(
            shorCutName.first[0] + " " + shorCutName.last[0],
            style: TextStyle(color: AppColors.lightTextPrimary),
          ),
        ),
      ),
    );

    if (student.photo == null) {
      return pictureName;
    }
//  return pictureName;
    return Container(
      height: 80,
      width: 60,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightTextPrimary, width: 2.0),
        // borderRadius: BorderRadius.circular(2.0),
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: CachedNetworkImageProvider(student.photo),
        ),
      ),
    );
  }
}
