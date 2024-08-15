// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intro_page_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$IntroPageController on IntroPageControllerBase, Store {
  late final _$userDataMissingAtom =
      Atom(name: 'IntroPageControllerBase.userDataMissing', context: context);

  @override
  bool get userDataMissing {
    _$userDataMissingAtom.reportRead();
    return super.userDataMissing;
  }

  @override
  set userDataMissing(bool value) {
    _$userDataMissingAtom.reportWrite(value, super.userDataMissing, () {
      super.userDataMissing = value;
    });
  }

  late final _$checkUserDataAsyncAction =
      AsyncAction('IntroPageControllerBase.checkUserData', context: context);

  @override
  Future<bool> checkUserData() {
    return _$checkUserDataAsyncAction.run(() => super.checkUserData());
  }

  @override
  String toString() {
    return '''
userDataMissing: ${userDataMissing}
    ''';
  }
}
