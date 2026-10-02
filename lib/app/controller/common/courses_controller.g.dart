// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courses_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CoursesController on CoursesControllerBase, Store {
  Computed<Map<String, dynamic>>? _$getAllCoursesComputed;

  @override
  Map<String, dynamic> get getAllCourses => (_$getAllCoursesComputed ??=
          Computed<Map<String, dynamic>>(() => super.getAllCourses,
              name: 'CoursesControllerBase.getAllCourses'))
      .value;
  Computed<int>? _$customCoursesCountComputed;

  @override
  int get customCoursesCount => (_$customCoursesCountComputed ??= Computed<int>(
          () => super.customCoursesCount,
          name: 'CoursesControllerBase.customCoursesCount'))
      .value;
  Computed<bool>? _$atCustomLimitComputed;

  @override
  bool get atCustomLimit =>
      (_$atCustomLimitComputed ??= Computed<bool>(() => super.atCustomLimit,
              name: 'CoursesControllerBase.atCustomLimit'))
          .value;
  Computed<bool>? _$getLoadedCoursesComputed;

  @override
  bool get getLoadedCourses => (_$getLoadedCoursesComputed ??= Computed<bool>(
          () => super.getLoadedCourses,
          name: 'CoursesControllerBase.getLoadedCourses'))
      .value;

  late final _$allCoursesAtom =
      Atom(name: 'CoursesControllerBase.allCourses', context: context);

  @override
  ObservableMap<String, dynamic>? get allCourses {
    _$allCoursesAtom.reportRead();
    return super.allCourses;
  }

  @override
  set allCourses(ObservableMap<String, dynamic>? value) {
    _$allCoursesAtom.reportWrite(value, super.allCourses, () {
      super.allCourses = value;
    });
  }

  late final _$loadedCoursesAtom =
      Atom(name: 'CoursesControllerBase.loadedCourses', context: context);

  @override
  bool get loadedCourses {
    _$loadedCoursesAtom.reportRead();
    return super.loadedCourses;
  }

  @override
  set loadedCourses(bool value) {
    _$loadedCoursesAtom.reportWrite(value, super.loadedCourses, () {
      super.loadedCourses = value;
    });
  }

  late final _$fetchCoursesAsyncAction =
      AsyncAction('CoursesControllerBase.fetchCourses', context: context);

  @override
  Future<Map<String, dynamic>> fetchCourses() {
    return _$fetchCoursesAsyncAction.run(() => super.fetchCourses());
  }

  late final _$refreshAllSubjectsAsyncAction =
      AsyncAction('CoursesControllerBase.refreshAllSubjects', context: context);

  @override
  Future<bool> refreshAllSubjects() {
    return _$refreshAllSubjectsAsyncAction
        .run(() => super.refreshAllSubjects());
  }

  late final _$removeCourseFromHomeAsyncAction = AsyncAction(
      'CoursesControllerBase.removeCourseFromHome',
      context: context);

  @override
  Future<void> removeCourseFromHome(CourseModel course) {
    return _$removeCourseFromHomeAsyncAction
        .run(() => super.removeCourseFromHome(course));
  }

  late final _$CoursesControllerBaseActionController =
      ActionController(name: 'CoursesControllerBase', context: context);

  @override
  void setAllCourses(Map<String, dynamic> courses) {
    final _$actionInfo = _$CoursesControllerBaseActionController.startAction(
        name: 'CoursesControllerBase.setAllCourses');
    try {
      return super.setAllCourses(courses);
    } finally {
      _$CoursesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoadedCourses(bool status) {
    final _$actionInfo = _$CoursesControllerBaseActionController.startAction(
        name: 'CoursesControllerBase.setLoadedCourses');
    try {
      return super.setLoadedCourses(status);
    } finally {
      _$CoursesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  late final _$deleteAllCurrentCoursesAsyncAction = AsyncAction(
      'CoursesControllerBase.deleteAllCurrentCourses',
      context: context);

  @override
  Future<void> deleteAllCurrentCourses() {
    return _$deleteAllCurrentCoursesAsyncAction
        .run(() => super.deleteAllCurrentCourses());
  }

  @override
  String toString() {
    return '''
allCourses: ${allCourses},
loadedCourses: ${loadedCourses},
getAllCourses: ${getAllCourses},
customCoursesCount: ${customCoursesCount},
atCustomLimit: ${atCustomLimit},
getLoadedCourses: ${getLoadedCourses}
    ''';
  }
}
