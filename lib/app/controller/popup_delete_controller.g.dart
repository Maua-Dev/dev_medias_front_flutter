// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popup_delete_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PopupDeleteController on _PopupDeleteController, Store {
  late final _$isVisibleAtom =
      Atom(name: '_PopupDeleteController.isVisible', context: context);

  @override
  bool get isVisible {
    _$isVisibleAtom.reportRead();
    return super.isVisible;
  }

  @override
  set isVisible(bool value) {
    _$isVisibleAtom.reportWrite(value, super.isVisible, () {
      super.isVisible = value;
    });
  }

  late final _$_PopupDeleteControllerActionController =
      ActionController(name: '_PopupDeleteController', context: context);

  @override
  void showPopup() {
    final _$actionInfo = _$_PopupDeleteControllerActionController.startAction(
        name: '_PopupDeleteController.showPopup');
    try {
      return super.showPopup();
    } finally {
      _$_PopupDeleteControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void hidePopup() {
    final _$actionInfo = _$_PopupDeleteControllerActionController.startAction(
        name: '_PopupDeleteController.hidePopup');
    try {
      return super.hidePopup();
    } finally {
      _$_PopupDeleteControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteCourse() {
    final _$actionInfo = _$_PopupDeleteControllerActionController.startAction(
        name: '_PopupDeleteController.deleteCourse');
    try {
      return super.deleteCourse();
    } finally {
      _$_PopupDeleteControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isVisible: ${isVisible}
    ''';
  }
}
