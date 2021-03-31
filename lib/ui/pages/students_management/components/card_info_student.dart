import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_preservation/models/student.dart';
import 'package:food_preservation/models/teacher.dart';
import 'package:food_preservation/models/user_model.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';
import 'package:food_preservation/util/enums.dart';
import 'package:get/get.dart';

class CardInfoStudent extends StatelessWidget {
  const CardInfoStudent({
    Key key,
    @required this.student,
    this.onStatusChanged,
    this.onPressDelete,
    this.onPressEdit,
    this.onPressAddParent,
    this.onPressShowParent,
    this.onPressShowBrothers,
    this.justShowBrothers = false,
  }) : super(key: key);

  final Student student;
  final Function(Student student, bool value) onStatusChanged;
  final Function(Student student) onPressDelete;
  final Function(Student student) onPressEdit;
  final Function(Student student) onPressAddParent;
  final Function(Student student) onPressShowParent;
  final Function(Student student) onPressShowBrothers;
  final bool justShowBrothers;

  @override
  Widget build(BuildContext context) {
    bool hasParent = student.parentId == null ? false : true;

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
                                    subtitle: Text(student.address),
                                  ),
                                  Visibility(
                                    visible: !justShowBrothers,
                                    child: hasParent
                                        ? Column(
                                            children: [
                                              ListTile(
                                                leading: Icon(Icons.person),
                                                title: Text("بيانات ولي الامر"),
                                                subtitle: FlatButton(
                                                  child: Text(
                                                    'استعراض بيانات ولي الامر',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  color: AppColors.lightPrimary,
                                                  onPressed: () =>
                                                      onPressShowParent(
                                                          student),
                                                ),
                                              ),
                                              FlatButton(
                                                child: Text(
                                                  '  جميع الطلاب لنفس ولي الامر',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                color: AppColors.lightPrimary,
                                                onPressed: () =>
                                                    onPressShowBrothers(
                                                        student),
                                              ),
                                            ],
                                          )
                                        : ListTile(
                                            leading: Icon(Icons.person),
                                            title: Text("بيانات ولي الامر"),
                                            subtitle: FlatButton(
                                              child: Text(
                                                'ربط الطالب مع ولي امر',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              color: AppColors.lightPrimary,
                                              onPressed: () =>
                                                  onPressAddParent(student),
                                            ),
                                          ),
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
                                onPressed: () => onPressEdit(student)),
                            IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => onPressDelete(student)),
                            // Text("حالة المعلم"),
                            Switch(
                              // checkColor: AppColors.lightPrimary,
                              activeColor: AppColors.lightPrimary,
                              value: student.status == Status.approve,
                              onChanged: (bool value) =>
                                  onStatusChanged(student, value),
                            ),
                          ])),
                ],
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
