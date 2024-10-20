import 'package:dev_medias_front_flutter/app/service/support_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'support_controller.g.dart';

class SupportController = _SupportControllerBase with _$SupportController;

abstract class _SupportControllerBase with Store {

  SupportService supportService = SupportService();

  @observable
  TextEditingController emailController = TextEditingController();

  @observable
  TextEditingController messageController = TextEditingController();

  @computed
  TextEditingController get getEmailController => emailController;

  @computed
  TextEditingController get getMessageController => messageController;

  @action
  Future<Map> sendSupport() async {
    final message = {
      "email": emailController.text,
      "message": messageController.text,
    };
    try {
      final response = await supportService.postMessage(message);
      return response;
    } catch (e) {
      throw Exception('Erro de rede: $e');
    }
  }
}

final SupportController supportController = SupportController();
