// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intro_page_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$IntroPageController on IntroPageControllerBase, Store {
  late final _$loggedInAtom =
      Atom(name: 'IntroPageControllerBase.loggedIn', context: context);

  @override
  bool get loggedIn {
    _$loggedInAtom.reportRead();
    return super.loggedIn;
  }

  @override
  set loggedIn(bool value) {
    _$loggedInAtom.reportWrite(value, super.loggedIn, () {
      super.loggedIn = value;
    });
  }

  late final _$checkUserDataExistsAsyncAction = AsyncAction(
      'IntroPageControllerBase.checkUserDataExists',
      context: context);

  @override
  Future<bool> checkUserDataExists() {
    return _$checkUserDataExistsAsyncAction
        .run(() => super.checkUserDataExists());
  }

  late final _$insertUserDataAsyncAction =
      AsyncAction('IntroPageControllerBase.insertUserData', context: context);

  @override
  Future<void> insertUserData(UserModel user) {
    return _$insertUserDataAsyncAction.run(() => super.insertUserData(user));
  }

  late final _$IntroPageControllerBaseActionController =
      ActionController(name: 'IntroPageControllerBase', context: context);

  @override
  void setLoginSuccesful(bool status) {
    final _$actionInfo = _$IntroPageControllerBaseActionController.startAction(
        name: 'IntroPageControllerBase.setLoginSuccesful');
    try {
      return super.setLoginSuccesful(status);
    } finally {
      _$IntroPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loggedIn: ${loggedIn}
    ''';
  }
}
