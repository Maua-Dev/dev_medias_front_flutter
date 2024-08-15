import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GradeInput extends StatelessWidget {
  final String name;
  final bool labelled;

  const GradeInput({super.key, this.name = "Sem Nome", this.labelled = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        labelled ?
        Text(
          name,
          style: TextStyle(fontSize: 12),
        ) : Container(),
        SizedBox(
          height: 35,
          width: 60,
          child: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(4),
              FilteringTextInputFormatter.allow(RegExp(r'^[0-9,.]*$')),
              ],
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
                fillColor: AppColors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: Round.secondary,
                  borderSide:
                      BorderSide(color: AppColors.purpleButton, width: 4),
                )),
          ),
        )
      ],
    );
  }
}
