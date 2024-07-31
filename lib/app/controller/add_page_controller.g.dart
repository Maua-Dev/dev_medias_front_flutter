// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_page_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddPageController on AddPageControllerBase, Store {
  late final _$availableCoursesAtom =
      Atom(name: 'AddPageControllerBase.availableCourses', context: context);

  @override
  ObservableList<Course> get availableCourses {
    _$availableCoursesAtom.reportRead();
    return super.availableCourses;
  }

  @override
  set availableCourses(ObservableList<Course> value) {
    _$availableCoursesAtom.reportWrite(value, super.availableCourses, () {
      super.availableCourses = value;
    });
  }

  late final _$AddPageControllerBaseActionController =
      ActionController(name: 'AddPageControllerBase', context: context);

  @override
  void addCurrentCourse(Course course) {
    final _$actionInfo = _$AddPageControllerBaseActionController.startAction(
        name: 'AddPageControllerBase.addCurrentCourse');
    try {
      return super.addCurrentCourse(course);
    } finally {
      _$AddPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addAvailableCourse(Course course) {
    final _$actionInfo = _$AddPageControllerBaseActionController.startAction(
        name: 'AddPageControllerBase.addAvailableCourse');
    try {
      return super.addAvailableCourse(course);
    } finally {
      _$AddPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeAvailableCourse(Course course) {
    final _$actionInfo = _$AddPageControllerBaseActionController.startAction(
        name: 'AddPageControllerBase.removeAvailableCourse');
    try {
      return super.removeAvailableCourse(course);
    } finally {
      _$AddPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
availableCourses: ${availableCourses}
    ''';
  }
}
