import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_preservation/models/message.dart';
import 'package:food_preservation/models/user_model.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';
import '../../../../util/extensions.dart';

class CardInfoConversation extends StatelessWidget {
  const CardInfoConversation(
      {Key key, this.conversation, this.forParent = true, this.onSelected})
      : super(key: key);

  final Conversation conversation;
  final bool forParent;
  final Function(Conversation conversation) onSelected;
  @override
  Widget build(BuildContext context) {
    UserModel user =
        forParent ? conversation.userModel2 : conversation.userModel1;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        elevation: 7,
        margin: EdgeInsets.all(10),
        child: ListTile(
          onTap: () => onSelected(conversation),
          leading: user == null ? SizedBox() : imageUser(user),
          title: Text(user?.name ?? ''),
          subtitle: Text(conversation.updatedAt.formatDate(withTime: true)),
        ),
      ),
    );
  }

  Widget imageUser(parent) {
    List<String> shorCutName = parent.name.trim().split(" ");

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

    if (parent.photo == null) {
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
          image: CachedNetworkImageProvider(parent.photo),
        ),
      ),
    );
  }
}
