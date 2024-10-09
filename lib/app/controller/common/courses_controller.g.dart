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

  late final _$allGradsAtom =
      Atom(name: 'CoursesControllerBase.allGrads', context: context);

  @override
  ObservableMap<String, dynamic>? get allGrads {
    _$allGradsAtom.reportRead();
    return super.allGrads;
  }

  @override
  set allGrads(ObservableMap<String, dynamic>? value) {
    _$allGradsAtom.reportWrite(value, super.allGrads, () {
      super.allGrads = value;
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

  late final _$getCoursesAsyncAction =
      AsyncAction('CoursesControllerBase.getCourses', context: context);

  @override
  Future<Map<String, dynamic>> getCourses() {
    return _$getCoursesAsyncAction.run(() => super.getCourses());
  }

  late final _$getGradsAsyncAction =
      AsyncAction('CoursesControllerBase.getGrads', context: context);

  @override
  Future<Map<String, dynamic>> getGrads() {
    return _$getGradsAsyncAction.run(() => super.getGrads());
  }

  late final _$CoursesControllerBaseActionController =
      ActionController(name: 'CoursesControllerBase', context: context);

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

  @override
  dynamic getAllGrads() {
    final _$actionInfo = _$CoursesControllerBaseActionController.startAction(
        name: 'CoursesControllerBase.getAllGrads');
    try {
      return super.getAllGrads();
    } finally {
      _$CoursesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<String> getDropdownInputStrings() {
    final _$actionInfo = _$CoursesControllerBaseActionController.startAction(
        name: 'CoursesControllerBase.getDropdownInputStrings');
    try {
      return super.getDropdownInputStrings();
    } finally {
      _$CoursesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
allCourses: ${allCourses},
allGrads: ${allGrads},
loadedCourses: ${loadedCourses}
    ''';
  }
}
