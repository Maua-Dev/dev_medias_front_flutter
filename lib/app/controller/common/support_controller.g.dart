// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SupportController on _SupportControllerBase, Store {
  Computed<TextEditingController>? _$getEmailControllerComputed;

  @override
  TextEditingController get getEmailController =>
      (_$getEmailControllerComputed ??= Computed<TextEditingController>(
              () => super.getEmailController,
              name: '_SupportControllerBase.getEmailController'))
          .value;
  Computed<TextEditingController>? _$getMessageControllerComputed;

  @override
  TextEditingController get getMessageController =>
      (_$getMessageControllerComputed ??= Computed<TextEditingController>(
              () => super.getMessageController,
              name: '_SupportControllerBase.getMessageController'))
          .value;

  late final _$emailControllerAtom =
      Atom(name: '_SupportControllerBase.emailController', context: context);

  @override
  TextEditingController get emailController {
    _$emailControllerAtom.reportRead();
    return super.emailController;
  }

  @override
  set emailController(TextEditingController value) {
    _$emailControllerAtom.reportWrite(value, super.emailController, () {
      super.emailController = value;
    });
  }

  late final _$messageControllerAtom =
      Atom(name: '_SupportControllerBase.messageController', context: context);

  @override
  TextEditingController get messageController {
    _$messageControllerAtom.reportRead();
    return super.messageController;
  }

  @override
  set messageController(TextEditingController value) {
    _$messageControllerAtom.reportWrite(value, super.messageController, () {
      super.messageController = value;
    });
  }

  late final _$sendSupportAsyncAction =
      AsyncAction('_SupportControllerBase.sendSupport', context: context);

  @override
  Future<Map<dynamic, dynamic>> sendSupport() {
    return _$sendSupportAsyncAction.run(() => super.sendSupport());
  }

  @override
  String toString() {
    return '''
emailController: ${emailController},
messageController: ${messageController},
getEmailController: ${getEmailController},
getMessageController: ${getMessageController}
    ''';
  }
}
