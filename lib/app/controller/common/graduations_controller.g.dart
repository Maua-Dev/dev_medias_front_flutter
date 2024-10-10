// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graduations_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GraduationsController on GraduationsControllerBase, Store {
  Computed<Map<String, dynamic>>? _$getAllGradsComputed;

  @override
  Map<String, dynamic> get getAllGrads => (_$getAllGradsComputed ??=
          Computed<Map<String, dynamic>>(() => super.getAllGrads,
              name: 'GraduationsControllerBase.getAllGrads'))
      .value;

  late final _$allGradsAtom =
      Atom(name: 'GraduationsControllerBase.allGrads', context: context);

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

  late final _$fetchGradsAsyncAction =
      AsyncAction('GraduationsControllerBase.fetchGrads', context: context);

  @override
  Future<Map<String, dynamic>> fetchGrads() {
    return _$fetchGradsAsyncAction.run(() => super.fetchGrads());
  }

  late final _$GraduationsControllerBaseActionController =
      ActionController(name: 'GraduationsControllerBase', context: context);

  @override
  void setAllGrads(Map<String, dynamic> grads) {
    final _$actionInfo = _$GraduationsControllerBaseActionController
        .startAction(name: 'GraduationsControllerBase.setAllGrads');
    try {
      return super.setAllGrads(grads);
    } finally {
      _$GraduationsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<String> getDropdownInputStrings() {
    final _$actionInfo = _$GraduationsControllerBaseActionController
        .startAction(name: 'GraduationsControllerBase.getDropdownInputStrings');
    try {
      return super.getDropdownInputStrings();
    } finally {
      _$GraduationsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
allGrads: ${allGrads},
getAllGrads: ${getAllGrads}
    ''';
  }
}
