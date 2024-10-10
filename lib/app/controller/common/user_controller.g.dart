// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserController on UserControllerBase, Store {
  Computed<bool>? _$getUserDataMissingComputed;

  @override
  bool get getUserDataMissing => (_$getUserDataMissingComputed ??=
          Computed<bool>(() => super.getUserDataMissing,
              name: 'UserControllerBase.getUserDataMissing'))
      .value;
  Computed<bool>? _$getFirstLoginComputed;

  @override
  bool get getFirstLogin =>
      (_$getFirstLoginComputed ??= Computed<bool>(() => super.getFirstLogin,
              name: 'UserControllerBase.getFirstLogin'))
          .value;
  Computed<String?>? _$getNameComputed;

  @override
  String? get getName =>
      (_$getNameComputed ??= Computed<String?>(() => super.getName,
              name: 'UserControllerBase.getName'))
          .value;
  Computed<String?>? _$getGraduationComputed;

  @override
  String? get getGraduation =>
      (_$getGraduationComputed ??= Computed<String?>(() => super.getGraduation,
              name: 'UserControllerBase.getGraduation'))
          .value;
  Computed<int?>? _$getYearComputed;

  @override
  int? get getYear => (_$getYearComputed ??= Computed<int?>(() => super.getYear,
          name: 'UserControllerBase.getYear'))
      .value;
  Computed<List<String>>? _$getCurrentCoursesComputed;

  @override
  List<String> get getCurrentCourses => (_$getCurrentCoursesComputed ??=
          Computed<List<String>>(() => super.getCurrentCourses,
              name: 'UserControllerBase.getCurrentCourses'))
      .value;

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

  late final _$firstLoginAtom =
      Atom(name: 'UserControllerBase.firstLogin', context: context);

  @override
  bool get firstLogin {
    _$firstLoginAtom.reportRead();
    return super.firstLogin;
  }

  @override
  set firstLogin(bool value) {
    _$firstLoginAtom.reportWrite(value, super.firstLogin, () {
      super.firstLogin = value;
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

  late final _$currentCoursesAtom =
      Atom(name: 'UserControllerBase.currentCourses', context: context);

  @override
  ObservableList<String> get currentCourses {
    _$currentCoursesAtom.reportRead();
    return super.currentCourses;
  }

  @override
  set currentCourses(ObservableList<String> value) {
    _$currentCoursesAtom.reportWrite(value, super.currentCourses, () {
      super.currentCourses = value;
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
  Future<Map<dynamic, dynamic>> getUserData() {
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

  late final _$fetchCurrentCoursesAsyncAction =
      AsyncAction('UserControllerBase.fetchCurrentCourses', context: context);

  @override
  Future<void> fetchCurrentCourses() {
    return _$fetchCurrentCoursesAsyncAction
        .run(() => super.fetchCurrentCourses());
  }

  late final _$insertCurrentCoursesAsyncAction =
      AsyncAction('UserControllerBase.insertCurrentCourses', context: context);

  @override
  Future<void> insertCurrentCourses(String code) {
    return _$insertCurrentCoursesAsyncAction
        .run(() => super.insertCurrentCourses(code));
  }

  late final _$removeCurrentCourseAsyncAction =
      AsyncAction('UserControllerBase.removeCurrentCourse', context: context);

  @override
  Future<void> removeCurrentCourse(String code) {
    return _$removeCurrentCourseAsyncAction
        .run(() => super.removeCurrentCourse(code));
  }

  late final _$loadInitialCoursesAsyncAction =
      AsyncAction('UserControllerBase.loadInitialCourses', context: context);

  @override
  Future<void> loadInitialCourses(String code, int year) {
    return _$loadInitialCoursesAsyncAction
        .run(() => super.loadInitialCourses(code, year));
  }

  late final _$UserControllerBaseActionController =
      ActionController(name: 'UserControllerBase', context: context);

  @override
  void setUserDataMissing(bool status) {
    final _$actionInfo = _$UserControllerBaseActionController.startAction(
        name: 'UserControllerBase.setUserDataMissing');
    try {
      return super.setUserDataMissing(status);
    } finally {
      _$UserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFirstLogin(bool status) {
    final _$actionInfo = _$UserControllerBaseActionController.startAction(
        name: 'UserControllerBase.setFirstLogin');
    try {
      return super.setFirstLogin(status);
    } finally {
      _$UserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(String name) {
    final _$actionInfo = _$UserControllerBaseActionController.startAction(
        name: 'UserControllerBase.setName');
    try {
      return super.setName(name);
    } finally {
      _$UserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGraduation(String graduation) {
    final _$actionInfo = _$UserControllerBaseActionController.startAction(
        name: 'UserControllerBase.setGraduation');
    try {
      return super.setGraduation(graduation);
    } finally {
      _$UserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setYear(int year) {
    final _$actionInfo = _$UserControllerBaseActionController.startAction(
        name: 'UserControllerBase.setYear');
    try {
      return super.setYear(year);
    } finally {
      _$UserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentCourses(List<String> courses) {
    final _$actionInfo = _$UserControllerBaseActionController.startAction(
        name: 'UserControllerBase.setCurrentCourses');
    try {
      return super.setCurrentCourses(courses);
    } finally {
      _$UserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userDataMissing: ${userDataMissing},
firstLogin: ${firstLogin},
name: ${name},
graduation: ${graduation},
year: ${year},
currentCourses: ${currentCourses},
getUserDataMissing: ${getUserDataMissing},
getFirstLogin: ${getFirstLogin},
getName: ${getName},
getGraduation: ${getGraduation},
getYear: ${getYear},
getCurrentCourses: ${getCurrentCourses}
    ''';
  }
}
