// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CommonController on _CommonControllerBase, Store {
  Computed<String?>? _$getPreviousPageComputed;

  @override
  String? get getPreviousPage => (_$getPreviousPageComputed ??=
          Computed<String?>(() => super.getPreviousPage,
              name: '_CommonControllerBase.getPreviousPage'))
      .value;

  late final _$previousPageAtom =
      Atom(name: '_CommonControllerBase.previousPage', context: context);

  @override
  String? get previousPage {
    _$previousPageAtom.reportRead();
    return super.previousPage;
  }

  @override
  set previousPage(String? value) {
    _$previousPageAtom.reportWrite(value, super.previousPage, () {
      super.previousPage = value;
    });
  }

  late final _$_CommonControllerBaseActionController =
      ActionController(name: '_CommonControllerBase', context: context);

  @override
  void setPreviousPage(String? page) {
    final _$actionInfo = _$_CommonControllerBaseActionController.startAction(
        name: '_CommonControllerBase.setPreviousPage');
    try {
      return super.setPreviousPage(page);
    } finally {
      _$_CommonControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
previousPage: ${previousPage},
getPreviousPage: ${getPreviousPage}
    ''';
  }
}
