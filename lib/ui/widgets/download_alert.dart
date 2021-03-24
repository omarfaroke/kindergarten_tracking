import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';
import 'package:food_preservation/util/function_helpers.dart';
import 'custom_alert.dart';

class StateDownload {
  bool successDownload;
  int sizeFile;
  String errorMsg;
}

class DownloadAlert extends StatefulWidget {
  final String url;
  final String path;

  DownloadAlert({Key key, @required this.url, @required this.path})
      : super(key: key);

  @override
  _DownloadAlertState createState() => _DownloadAlertState();
}

class _DownloadAlertState extends State<DownloadAlert> {
  Dio dio = new Dio();
  int received = 0;
  String progress = "0";
  int total = 0;
  CancelToken cancelToken = CancelToken();
  StateDownload stateDownload = StateDownload();

  download() async {
    await dio.download(
      widget.url,
      widget.path,
      deleteOnError: true,
      // options: Options(method: "POST"),
      onReceiveProgress: (receivedBytes, totalBytes) {
        setState(() {
          received = receivedBytes;
          total = totalBytes;
          progress = (received / total * 100).toStringAsFixed(0);
        });
        //Check if download is complete and close the alert dialog
        if (receivedBytes == totalBytes) {
          stateDownload.successDownload = true;
          stateDownload.sizeFile = total;

          Navigator.pop(context, stateDownload);
        }
      },
      cancelToken: cancelToken,
    ).catchError((err) {
      print('error dio download ..');
      print(err);
    });
  }

  @override
  void initState() {
    super.initState();
    download();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: CustomAlert(
          child: Stack(
            textDirection: TextDirection.ltr,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "تحميل ...",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: LinearProgressIndicator(
                        value: double.parse(progress) / 100,
                        valueColor:
                            AlwaysStoppedAnimation(AppColors.lightPrimary),
                        backgroundColor: AppColors.lightAccent,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "$progress %",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${formatBytes(received, 1)} "
                          "of ${formatBytes(total, 1)}",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    stateDownload.successDownload = false;
                    stateDownload.errorMsg = 'cancel download';
                    stateDownload.sizeFile = 0;

                    cancelToken.cancel();
                    Navigator.pop(context, stateDownload);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
