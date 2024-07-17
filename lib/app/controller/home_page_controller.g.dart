// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomePageController on HomePageControllerBase, Store {
  late final _$counterAtom =
      Atom(name: 'HomePageControllerBase.counter', context: context);

  @override
  Counter get counter {
    _$counterAtom.reportRead();
    return super.counter;
  }

  @override
  set counter(Counter value) {
    _$counterAtom.reportWrite(value, super.counter, () {
      super.counter = value;
    });
  }

  late final _$HomePageControllerBaseActionController =
      ActionController(name: 'HomePageControllerBase', context: context);

  @override
  void incrementCounter() {
    final _$actionInfo = _$HomePageControllerBaseActionController.startAction(
        name: 'HomePageControllerBase.incrementCounter');
    try {
      return super.incrementCounter();
    } finally {
      _$HomePageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
counter: ${counter}
    ''';
  }
}
