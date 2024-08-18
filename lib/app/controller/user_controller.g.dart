// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserController on UserControllerBase, Store {
  late final _$userDataMissingAtom =
      Atom(name: 'UserControllerBase.userDataMissing', context: context);

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

  late final _$nameAtom =
      Atom(name: 'UserControllerBase.name', context: context);

  @override
  String? get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String? value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$graduationAtom =
      Atom(name: 'UserControllerBase.graduation', context: context);

  @override
  String? get graduation {
    _$graduationAtom.reportRead();
    return super.graduation;
  }

  @override
  set graduation(String? value) {
    _$graduationAtom.reportWrite(value, super.graduation, () {
      super.graduation = value;
    });
  }

  late final _$yearAtom =
      Atom(name: 'UserControllerBase.year', context: context);

  @override
  int? get year {
    _$yearAtom.reportRead();
    return super.year;
  }

  @override
  set year(int? value) {
    _$yearAtom.reportWrite(value, super.year, () {
      super.year = value;
    });
  }

  late final _$checkUserDataExistsAsyncAction =
      AsyncAction('UserControllerBase.checkUserDataExists', context: context);

  @override
  Future<bool> checkUserDataExists() {
    return _$checkUserDataExistsAsyncAction
        .run(() => super.checkUserDataExists());
  }

  late final _$getUserDataAsyncAction =
      AsyncAction('UserControllerBase.getUserData', context: context);

  @override
  Future<UserModel?> getUserData() {
    return _$getUserDataAsyncAction.run(() => super.getUserData());
  }

  late final _$insertUserDataAsyncAction =
      AsyncAction('UserControllerBase.insertUserData', context: context);

  @override
  Future<void> insertUserData(UserModel user) {
    return _$insertUserDataAsyncAction.run(() => super.insertUserData(user));
  }

  late final _$resetUserDataAsyncAction =
      AsyncAction('UserControllerBase.resetUserData', context: context);

  @override
  Future<void> resetUserData() {
    return _$resetUserDataAsyncAction.run(() => super.resetUserData());
  }

  @override
  String toString() {
    return '''
userDataMissing: ${userDataMissing},
name: ${name},
graduation: ${graduation},
year: ${year}
    ''';
  }
}
