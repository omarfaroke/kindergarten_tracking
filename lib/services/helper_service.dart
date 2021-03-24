
import 'package:food_preservation/ui/widgets/toast_msg.dart';
import 'package:permission_handler/permission_handler.dart';

class HelperService  {
  static Future<bool> get checkPermissionStorage async {
    PermissionStatus permission = await Permission.storage.status;

    if (permission != PermissionStatus.granted) {
      PermissionStatus permissionStatus = await Permission.storage.request();

      if (permissionStatus.isDenied) {
        showTextError('فشل الحصول على صلاحية التعامل مع الملفات !');
        return false;
      }
      return true;
    } else {
      return true;
    }
  }

}
