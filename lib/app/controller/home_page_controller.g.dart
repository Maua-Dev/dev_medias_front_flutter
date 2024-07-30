// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomePageController on HomePageControllerBase, Store {
  late final _$current_coursesAtom =
      Atom(name: 'HomePageControllerBase.current_courses', context: context);

  @override
  CurrentCourses get current_courses {
    _$current_coursesAtom.reportRead();
    return super.current_courses;
  }

  @override
  set current_courses(CurrentCourses value) {
    _$current_coursesAtom.reportWrite(value, super.current_courses, () {
      super.current_courses = value;
    });
  }

  late final _$HomePageControllerBaseActionController =
      ActionController(name: 'HomePageControllerBase', context: context);

  @override
  void removeCourse(dynamic index) {
    final _$actionInfo = _$HomePageControllerBaseActionController.startAction(
        name: 'HomePageControllerBase.removeCourse');
    try {
      return super.removeCourse(index);
    } finally {
      _$HomePageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
current_courses: ${current_courses}
    ''';
  }
}
