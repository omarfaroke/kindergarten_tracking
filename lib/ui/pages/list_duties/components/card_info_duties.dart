import 'package:flutter/material.dart';
import 'package:food_preservation/constants/constants.dart';
import 'package:food_preservation/models/duties.dart';
import 'package:food_preservation/models/table.dart';
import '../../../../util/extensions.dart';

class CardDutiesInfo extends StatelessWidget {
  const CardDutiesInfo({
    Key key,
    this.duties,
  }) : super(key: key);

  final Duties duties;

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
                    '${duties.text}',
                    style: TextStyle(
                      fontFamily: "DinNextLtW23",
                    ),
                  ),
                  subtitle: Text(
                    'تاريخ الإضافة : ${duties.date.formatDate()}',
                    style: TextStyle(
                      fontFamily: "DinNextLtW23",
                    ),
                  ),
                  
                  trailing: Text(
                    ' ${levels[duties.level]}',
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
  }
}
