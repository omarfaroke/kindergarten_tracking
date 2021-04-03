import 'package:flutter/material.dart';
import 'package:food_preservation/constants/constants.dart';
import 'package:food_preservation/models/table.dart';
import '../../../../util/extensions.dart';

class CardTableInfo extends StatelessWidget {
  const CardTableInfo({
    Key key,
    this.table,
    this.onPressDownload,
    this.isExists = false,
    this.onPressOpen,
  }) : super(key: key);

  final TableModel table;
  final Function(TableModel) onPressDownload;
  final Function(TableModel) onPressOpen;
  final bool isExists;

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
                    'جدول  : ${levels[table.level]}',
                    style: TextStyle(
                      fontFamily: "DinNextLtW23",
                    ),
                  ),
                  subtitle: Text(
                    'تاريخ الإضافة : ${table.createDate.formatDate()}',
                    style: TextStyle(
                      fontFamily: "DinNextLtW23",
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isExists
                      ? TextButton.icon(
                          onPressed: () => onPressOpen(table),
                          icon: Icon(Icons.open_in_new),
                          label: Text('فتح'),
                        )
                      : TextButton.icon(
                          onPressed: () => onPressDownload(table),
                          icon: Icon(Icons.file_download),
                          label: Text('تحميل'),
                        ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
