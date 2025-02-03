// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_page_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddPageController on AddPageControllerBase, Store {
  late final _$coursesLoadedAtom =
      Atom(name: 'AddPageControllerBase.coursesLoaded', context: context);

  @override
  bool get coursesLoaded {
    _$coursesLoadedAtom.reportRead();
    return super.coursesLoaded;
  }

  @override
  set coursesLoaded(bool value) {
    _$coursesLoadedAtom.reportWrite(value, super.coursesLoaded, () {
      super.coursesLoaded = value;
    });
  }

  late final _$availableCoursesAtom =
      Atom(name: 'AddPageControllerBase.availableCourses', context: context);

  @override
  ObservableMap<String, dynamic>? get availableCourses {
    _$availableCoursesAtom.reportRead();
    return super.availableCourses;
  }

  @override
  set availableCourses(ObservableMap<String, dynamic>? value) {
    _$availableCoursesAtom.reportWrite(value, super.availableCourses, () {
      super.availableCourses = value;
    });
  }

  late final _$userSearchAtom =
      Atom(name: 'AddPageControllerBase.userSearch', context: context);

  @override
  String get userSearch {
    _$userSearchAtom.reportRead();
    return super.userSearch;
  }

  @override
  set userSearch(String value) {
    _$userSearchAtom.reportWrite(value, super.userSearch, () {
      super.userSearch = value;
    });
  }

  late final _$loadCoursesAsyncAction =
      AsyncAction('AddPageControllerBase.loadCourses', context: context);

  @override
  Future<void> loadCourses() {
    return _$loadCoursesAsyncAction.run(() => super.loadCourses());
  }

  late final _$AddPageControllerBaseActionController =
      ActionController(name: 'AddPageControllerBase', context: context);

  @override
  void setCoursesLoaded(bool status) {
    final _$actionInfo = _$AddPageControllerBaseActionController.startAction(
        name: 'AddPageControllerBase.setCoursesLoaded');
    try {
      return super.setCoursesLoaded(status);
    } finally {
      _$AddPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void searchAvailableCourses() {
    final _$actionInfo = _$AddPageControllerBaseActionController.startAction(
        name: 'AddPageControllerBase.searchAvailableCourses');
    try {
      return super.searchAvailableCourses();
    } finally {
      _$AddPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSearchTerm(String value) {
    final _$actionInfo = _$AddPageControllerBaseActionController.startAction(
        name: 'AddPageControllerBase.setSearchTerm');
    try {
      return super.setSearchTerm(value);
    } finally {
      _$AddPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
coursesLoaded: ${coursesLoaded},
availableCourses: ${availableCourses},
userSearch: ${userSearch}
    ''';
  }
}
