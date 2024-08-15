import 'package:dev_medias_front_flutter/app/controller/home_page_controller.dart';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'edit_page_controller.g.dart';

class EditPageController = EditPageControllerBase with _$EditPageController;

abstract class EditPageControllerBase with Store {
  EditPageControllerBase();

  final List<TextEditingController> _textEditingControllers = [
    TextEditingController()
  ];
}

EditPageController editController = EditPageController();
