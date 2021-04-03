import 'package:food_preservation/models/duties.dart';
import 'package:food_preservation/services/db/students_firestore_service.dart';
import 'package:food_preservation/ui/widgets/toast_msg.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../util/extensions.dart';

class AddDutiesController extends GetxController {
  String _level;

  AddDutiesController(String level) {
    _level = level;
    setUpDefualtValue;
  }

  final _form = fb.group({
    'text': FormControl(
      validators: [
        Validators.required,
      ],
    ),
    'level': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
  }, []);

  FormGroup get form => _form;

  get setUpDefualtValue {
    form.updateValue({'level': _level});
  }

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

        Duties duties = Duties.fromMap(mapFrom);

        duties.date = DateTime.now().justDate.millisecondsSinceEpoch;

        bool ok =
            await Get.find<StudentsFirestoreService>().createDuties(duties);

        if (!ok) {
          throw new Exception();
        }
      } catch (e) {
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
}
