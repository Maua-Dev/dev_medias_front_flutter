// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courses_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CoursesController on CoursesControllerBase, Store {
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

  late final _$getCoursesAsyncAction =
      AsyncAction('CoursesControllerBase.getCourses', context: context);

  @override
  Future<Map<String, dynamic>> getCourses() {
    return _$getCoursesAsyncAction.run(() => super.getCourses());
  }

  @override
  String toString() {
    return '''
allCourses: ${allCourses}
    ''';
  }
}
