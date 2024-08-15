import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:dev_medias_front_flutter/app/widgets/logo.dart';
import 'package:flutter/material.dart';

class StartingDataForm extends StatelessWidget {
  const StartingDataForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 42),
            child: Logo(),
          ),
        ),
        Expanded(flex: 1, child: Container()),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Text("Você é novo por aqui?", style: TextStyle(color: AppColors.white, fontSize: 20,),),
          Text("Insira seus dados abaixo para começarmos", style: TextStyle(color: AppColors.white, fontSize: 16),),
        ],),
        const Padding(
          padding: EdgeInsets.only(top: 18),
          child: CustomTextField(label: "Seu Nome"),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 18),
          child: CustomTextField(label: "Curso", hint: "Código do Curso"),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 18),
          child: CustomTextField(label: "Ano"),
        ),
        Expanded(flex: 1, child: Container()),
        ElevatedButton(
          onPressed: () {}, 
          style: TextButton.styleFrom(
            backgroundColor: AppColors.red,
            shape: RoundedRectangleBorder(borderRadius: Round.primary),
            minimumSize: const Size.fromHeight(50),
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 7)),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Confirmar", style: TextStyle(color: AppColors.white, fontSize: 22),),
              ],
            ),
          )
        ),
        Expanded(flex: 3, child: Container())
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;

  const CustomTextField({
    this.label = "Sem Rótulo",
    this.hint = "",
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.white, fontSize: 18),
        ),
        TextField(
          style: const TextStyle(
            fontSize: 20,
          ),
          decoration: InputDecoration(
              hintText: hint,
              fillColor: AppColors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: Round.primary,
                borderSide: BorderSide.none,
              )),
        ),
      ],
    );
  }
}
