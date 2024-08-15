import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'edit_page_controller.g.dart';

class EditPageController = EditPageControllerBase with _$EditPageController;

abstract class EditPageControllerBase with Store {
  EditPageControllerBase();

  final List<TextEditingController> textEditingControllers = [
    TextEditingController()
  ];
}

EditPageController editController = EditPageController();
