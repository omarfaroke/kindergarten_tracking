import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_preservation/models/ads.dart';
import '../../util/extensions.dart';

class CardInfoAds extends StatelessWidget {
  const CardInfoAds({
    Key key,
    @required this.ads,
    this.onPressDelete,
  }) : super(key: key);

  final Ads ads;
  final Function(Ads ads) onPressDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text(
                    '${ads.text}',
                    style: TextStyle(
                      fontFamily: "DinNextLtW23",
                    ),
                  ),
                  subtitle: Text(
                    'تاريخ الإضافة : ${ads.date.formatDate()}',
                    style: TextStyle(
                      fontFamily: "DinNextLtW23",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    // return Directionality(
    //     textDirection: TextDirection.rtl,
    //     child: Card(
    //       elevation: 7,
    //       margin: EdgeInsets.all(8),
    //       child: Column(
    //         children: <Widget>[
    //           Stack(
    //             children: <Widget>[

    //               Card(
    //                 child: Column(
    //                   children: [
    //                     imageUser(),
    //                     Text(
    //                       ads.title,
    //                       style: TextStyle(
    //                         fontSize: 18,
    //                         // color: AppColors.lightTextButton,
    //                         fontFamily: "DinNextLtW23",
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                     Text(
    //                       ads.text,
    //                       style: TextStyle(
    //                         fontSize: 14,
    //                         // color: AppColors.lightTextButton,
    //                         fontFamily: "DinNextLtW23",
    //                       ),
    //                     ),
    //                     Text(
    //                       ads.date.formatDate(),
    //                       style: TextStyle(
    //                         fontSize: 12,
    //                         // color: AppColors.lightTextButton,
    //                         fontFamily: "DinNextLtW23",
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               Align(
    //                   alignment: Alignment.topLeft,
    //                   child: Visibility(
    //                     visible: onPressDelete != null,
    //                     child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.end,
    //                         children: <Widget>[
    //                           IconButton(
    //                               icon: Icon(Icons.delete),
    //                               onPressed: () => onPressDelete(ads)),
    //                         ]),
    //                   )),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ));
  }

  Widget imageUser() {
    if (ads.photo != null) {
      return Container(
        height: 200,
        child: CachedNetworkImage(
          imageUrl: ads.photo,
          placeholder: (context, url) => CircularProgressIndicator(),
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
