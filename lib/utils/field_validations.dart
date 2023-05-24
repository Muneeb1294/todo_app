
import '../resources/app_localization.dart';

class FieldValidator {

  static String? validateEmptyField(String? value) {
    if (value!.isEmpty) {
      return LocalizationMap.getValue("field_required");
    }
    return null;
  }
}
