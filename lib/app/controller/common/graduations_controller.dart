import 'dart:async';
import 'package:dev_medias_front_flutter/app/service/graduation_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobx/mobx.dart';
part 'graduations_controller.g.dart';

class GraduationsController = GraduationsControllerBase with _$GraduationsController;

abstract class GraduationsControllerBase with Store {
  GraduationsControllerBase();

  final dio = Dio();

  final service = GraduationService();

  @observable
  ObservableMap<String, dynamic>? allGrads;

  @computed
  Map<String, dynamic> get getAllGrads {
    final result = <String, dynamic>{};
    allGrads!.forEach((key, value) {
      result[key] = value;
    });
    return result;
  }

  @action
  void setAllGrads(Map<String, dynamic> grads) {
    allGrads = ObservableMap<String, dynamic>.of(grads);
  }

  @action
  Future<Map<String, dynamic>> fetchGrads() async {
    final data = await service.getGraduations();
    setAllGrads(data);
    return data;
  }

  @action
  List<String> getDropdownInputStrings() {
    List<String> aux = [];
    allGrads!.forEach((key, value) {
      aux.add(key);
    });
    return aux;
  }
}

GraduationsController graduationsController = GraduationsController();
