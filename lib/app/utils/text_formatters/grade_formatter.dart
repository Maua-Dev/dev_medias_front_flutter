import 'package:flutter/services.dart';

final GradeInputFormatter gradeFormat = GradeInputFormatter();

class GradeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = '';
    final int newTextLength = newValue.text.length;
    if (newTextLength < 2) {
      newText = newValue.text;
      return TextEditingValue(text: newText);
    } else if (newTextLength < 3 && newTextLength > 1 && newValue.text[1] != ".") {
        newText =
            "${newValue.text.substring(0, newValue.text.length - 1)}.${newValue.text[newValue.text.length - 1]}";
        return TextEditingValue(text: newText);
    } else if (newValue.text == "1.00") {
        newText =
            "10.0";
        return TextEditingValue(text: newText);
    } else {
          return TextEditingValue(text: newValue.text);
    }

  }
}
