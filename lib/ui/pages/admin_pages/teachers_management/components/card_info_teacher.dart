import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_preservation/models/teacher.dart';
import 'package:food_preservation/models/user_model.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';
import 'package:food_preservation/util/enums.dart';
import 'package:get/get.dart';

class CardInfoTeacher extends StatelessWidget {
  const CardInfoTeacher({
    Key key,
    @required this.teacher,
    this.onStatusChanged,
    this.onPressDelete,
    this.onPressEdit,
  }) : super(key: key);

  final Teacher teacher;
  final Function(Teacher teatcher, bool value) onStatusChanged;
  final Function(Teacher teatcher) onPressDelete;
  final Function(Teacher teatcher) onPressEdit;

  @override
  Widget build(BuildContext context) {
    UserModel infoTeacher = this.teacher.info;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Card(
          elevation: 7,
          margin: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ExpansionTile(
                    initiallyExpanded: false,
                    leading: imageUser(infoTeacher),
                    title: Text(
                      infoTeacher.name,
                      style: TextStyle(
                        color: AppColors.lightPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      'يدرس مستوى ${teacher.level}',
                      style: TextStyle(
                        color: AppColors.lightPrimary,
                      ),
                      maxLines: 1,
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(
                        top: 35,
                      ),
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.red,
                      ),
                    ),
                    children: <Widget>[
                      Card(
                        elevation: 30,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  child: Column(
                                children: <Widget>[
                                  ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    leading: Icon(Icons.location_on),
                                    title: Text("العنوان"),
                                    subtitle: Text(infoTeacher.address),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.email),
                                    title: Text("البريد الالكتروني"),
                                    subtitle: Text(infoTeacher.email),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.phone_android),
                                    title: Text("جوال"),
                                    subtitle: Text(infoTeacher.phone),
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => onPressEdit(teacher)),
                            IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => onPressDelete(teacher)),
                            // Text("حالة المعلم"),
                            Switch(
                              // checkColor: AppColors.lightPrimary,
                              activeColor: AppColors.lightPrimary,
                              value: infoTeacher.status == Status.approve,
                              onChanged: (bool value) =>
                                  onStatusChanged(teacher, value),
                            ),
                          ])),
                ],
              ),
            ],
          ),
        ));
  }

  Widget imageUser(infoTeacher) {
    List<String> shorCutName = infoTeacher.name.trim().split(" ");

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

    if (infoTeacher.photo == null) {
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
          image: CachedNetworkImageProvider(infoTeacher.photo),
        ),
      ),
    );
  }
}
