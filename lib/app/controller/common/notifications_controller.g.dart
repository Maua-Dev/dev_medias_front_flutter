// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NotificationsController on NotificationsControllerBase, Store {
  late final _$noticesAtom =
      Atom(name: 'NotificationsControllerBase.notices', context: context);

  @override
  ObservableList<NoticeModel> get notices {
    _$noticesAtom.reportRead();
    return super.notices;
  }

  @override
  set notices(ObservableList<NoticeModel> value) {
    _$noticesAtom.reportWrite(value, super.notices, () {
      super.notices = value;
    });
  }

  late final _$fetchNotificationsAsyncAction = AsyncAction(
      'NotificationsControllerBase.fetchNotifications',
      context: context);

  @override
  Future<void> fetchNotifications() {
    return _$fetchNotificationsAsyncAction
        .run(() => super.fetchNotifications());
  }

  @override
  String toString() {
    return '''
notices: ${notices}
    ''';
  }
}
