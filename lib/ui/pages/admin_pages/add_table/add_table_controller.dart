import 'package:file_picker/file_picker.dart';
import 'package:food_preservation/models/table.dart';
import 'package:food_preservation/services/db/table_firestore_service.dart';
import 'package:food_preservation/ui/widgets/toast_msg.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddTableController extends GetxController {
  final _form = fb.group({
    'createDate': FormControl<DateTime>(
      value: DateTime.now(),
      validators: [
        Validators.required,
      ],
    ),
    'pathFile': FormControl(
      validators: [
        Validators.required,
      ],
    ),
    'level': FormControl<String>(
      validators: [
        Validators.required,
        Validators.number,
      ],
    ),
  }, []);

  FormGroup get form => _form;

  bool _isBusy = false;

  bool get isBusy => _isBusy;

  set isBusy(bool value) {
    _isBusy = value;
    update();
  }

  Future add() async {
    print('add');
    if (_form.valid) {
      //
      try {
        isBusy = true;

        Map mapFrom = _form.value;
        mapFrom['createDate'] = mapFrom['createDate'].millisecondsSinceEpoch;

        TableModel table = TableModel.fromMap(mapFrom);

        await Get.find<TableFirestoreService>().createTable(table: table);
      } catch (e) {
        print(e);
        showSnackBar(
          title: "خطأ في إضافة البيانات",
          message: '',
        );
        isBusy = false;

        return;
      }

      showTextSuccess('تم إضافة البيانات بنجاح');

      isBusy = false;
      afterSuccessAdd;
    } else {
      _form.markAllAsTouched();

      return false;
    }

    return true;
  }

  get afterSuccessAdd {
    Get.back();
  }

  get pickPdfFile async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      form.control('pathFile').value = file.path;

      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);
    } else {
      // User canceled the picker
    }
  }
}
