import 'package:dev_medias_front_flutter/app/controller/common/courses_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/common/graduations_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/intro_page_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/common/user_controller.dart';
import 'package:dev_medias_front_flutter/app/model/user.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:dev_medias_front_flutter/app/widgets/logo.dart';
import 'package:flutter/material.dart';

class StartingDataForm extends StatefulWidget {
  const StartingDataForm({super.key});

  @override
  State<StartingDataForm> createState() => _StartingDataFormState();
}

class _StartingDataFormState extends State<StartingDataForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController graduationController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SizedBox(
        width: 400,
        child: Column(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 42),
                child: Logo(),
              ),
            ),
            Expanded(child: Container()),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Você é novo por aqui?",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "Fale um pouco de você para começarmos",
                  style: TextStyle(color: AppColors.white, fontSize: 16),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Seu nome",
                    style: labelStyle(),
                  ),
                  TextFormField(
                      controller: nameController,
                      style: const TextStyle(fontSize: 20),
                      decoration: customInputDecoration(hintText: ""),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Seu curso",
                    style: labelStyle(),
                  ),
                  DropdownMenu(
                      width: 380,
                      enableFilter: true,
                      controller: graduationController,
                      inputDecorationTheme: customInputDecorationTheme(),
                      textStyle:
                          const TextStyle(fontSize: 20, color: AppColors.black),
                      onSelected: (s) {
                        userController.setGraduation(s!);
                      },
                      menuHeight: 200,
                      menuStyle: const MenuStyle(
                        maximumSize:
                            WidgetStatePropertyAll(Size.fromWidth(120)),
                        backgroundColor:
                            WidgetStatePropertyAll(AppColors.white),
                      ),
                      dropdownMenuEntries:
                          graduationsController.getDropdownInputStrings().map((s) {
                        return DropdownMenuEntry<String>(
                          style: MenuItemButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20),
                              backgroundColor: AppColors.white),
                          value: s,
                          label: '$s - ${graduationsController.allGrads?[s]}',
                        );
                      }).toList()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Seu ano",
                    style: labelStyle(),
                  ),
                  DropdownMenu(
                      width: 380,
                      controller: yearController,
                      enableFilter: true,
                      inputDecorationTheme: customInputDecorationTheme(),
                      textStyle:
                          const TextStyle(fontSize: 20, color: AppColors.black),
                      onSelected: (s) {
                        userController.setYear(int.parse(s!));
                      },
                      dropdownMenuEntries: [1, 2, 3, 4, 5].map((s) {
                        return DropdownMenuEntry<String>(
                          style: MenuItemButton.styleFrom(
                              textStyle: const TextStyle(
                                  fontSize: 20,
                                  overflow: TextOverflow.ellipsis),
                              backgroundColor: AppColors.white),
                          value: "$s",
                          label: '$s',
                        );
                      }).toList()),
                ],
              ),
            ),
            Expanded(flex: 1, child: Container()),
            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await userController.insertUserData(UserModel(
                        name: nameController.text,
                        graduation: graduationController.text,
                        year: int.parse(yearController.text)));
                    await userController.loadInitialCourses(graduationController.text, int.parse(yearController.text));
                    introPageController.setLoginSuccesful(true);
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                },
                style: TextButton.styleFrom(
                    backgroundColor: AppColors.red,
                    shape: RoundedRectangleBorder(borderRadius: Round.primary),
                    minimumSize: const Size.fromHeight(50),
                    padding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 7)),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Confirmar",
                        style: TextStyle(color: AppColors.white, fontSize: 22),
                      ),
                    ],
                  ),
                )),
            Expanded(flex: 2, child: Container())
          ],
        ),
      ),
    );
  }

  TextStyle labelStyle() =>
      const TextStyle(color: AppColors.white, fontSize: 18.0);

  InputDecoration customInputDecoration({String hintText = ""}) {
    return InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 20, color: AppColors.textFaded),
        fillColor: AppColors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: Round.primary,
          borderSide: BorderSide.none,
        ));
  }

  InputDecorationTheme customInputDecorationTheme({String hintText = ""}) {
    return InputDecorationTheme(
        constraints: BoxConstraints.expand(),
        hintStyle: const TextStyle(fontSize: 20, color: AppColors.textFaded),
        fillColor: AppColors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: Round.primary,
          borderSide: BorderSide.none,
        ));
  }
}
