import 'package:flutter/services.dart';

final GradeInputFormatter gradeFormat = GradeInputFormatter();

class GradeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = '';
    final int newTextLength = newValue.text.length;
    if (newTextLength == 2) {
      if (newValue.text[1] == "." || newValue.text[1] == ",") {
        newText = newValue.text[0];
        return TextEditingValue(text: newText);
      } else {
        newText = "${newValue.text[0]}.${newValue.text[1]}";
        return TextEditingValue(text: newText);
      }
    } else if (newTextLength == 3) {
        newText =
            "${newValue.text[0]}.${newValue.text[1]}";
        return TextEditingValue(text: newText);
    } else if (newTextLength == 4 && newValue.text != "10.0") {
        if (newValue.text == "1.00") {
          newText =
              "10.0";
        } else if (newValue.text != "10.0") {
          newText = newValue.text.substring(0, 3);
        }
        return TextEditingValue(text: newText);
    } else {
          return TextEditingValue(text: newValue.text);
    }

  }
}
