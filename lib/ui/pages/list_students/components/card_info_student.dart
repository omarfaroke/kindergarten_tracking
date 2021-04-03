import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_preservation/models/student.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';

class CardInfoStudent extends StatelessWidget {
  const CardInfoStudent({
    Key key,
    @required this.student,
    this.onSelected,
  }) : super(key: key);

  final Student student;
  final Function(Student student) onSelected;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: InkWell(
          onTap: () => onSelected(student),
          child: Card(
            elevation: 7,
            margin: EdgeInsets.all(8),
            child: ListTile(
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
