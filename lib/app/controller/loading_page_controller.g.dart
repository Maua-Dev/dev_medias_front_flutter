// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loading_page_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoadingPageController on LoadingPageControllerBase, Store {
  late final _$_loadingAtom =
      Atom(name: 'LoadingPageControllerBase._loading', context: context);

  @override
  bool get _loading {
    _$_loadingAtom.reportRead();
    return super._loading;
  }

  @override
  set _loading(bool value) {
    _$_loadingAtom.reportWrite(value, super._loading, () {
      super._loading = value;
    });
  }

  late final _$LoadingPageControllerBaseActionController =
      ActionController(name: 'LoadingPageControllerBase', context: context);

  @override
  bool getLoading() {
    final _$actionInfo = _$LoadingPageControllerBaseActionController
        .startAction(name: 'LoadingPageControllerBase.getLoading');
    try {
      return super.getLoading();
    } finally {
      _$LoadingPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool status) {
    final _$actionInfo = _$LoadingPageControllerBaseActionController
        .startAction(name: 'LoadingPageControllerBase.setLoading');
    try {
      return super.setLoading(status);
    } finally {
      _$LoadingPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
