// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomePageController on HomePageControllerBase, Store {
  late final _$currentCoursesAtom =
      Atom(name: 'HomePageControllerBase.currentCourses', context: context);

  @override
  ObservableList<Course> get currentCourses {
    _$currentCoursesAtom.reportRead();
    return super.currentCourses;
  }

  @override
  set currentCourses(ObservableList<Course> value) {
    _$currentCoursesAtom.reportWrite(value, super.currentCourses, () {
      super.currentCourses = value;
    });
  }

  late final _$HomePageControllerBaseActionController =
      ActionController(name: 'HomePageControllerBase', context: context);

  @override
  void removeCurrentCourse(Course course) {
    final _$actionInfo = _$HomePageControllerBaseActionController.startAction(
        name: 'HomePageControllerBase.removeCurrentCourse');
    try {
      return super.removeCurrentCourse(course);
    } finally {
      _$HomePageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadUserCourses() {
    final _$actionInfo = _$HomePageControllerBaseActionController.startAction(
        name: 'HomePageControllerBase.loadUserCourses');
    try {
      return super.loadUserCourses();
    } finally {
      _$HomePageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentCourses: ${currentCourses}
    ''';
  }
}
