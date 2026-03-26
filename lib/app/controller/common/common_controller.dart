import 'package:mobx/mobx.dart';

part 'common_controller.g.dart';

class CommonController = CommonControllerBase with _$CommonController;

abstract class CommonControllerBase with Store {

  @observable
  String? previousPage;

  @computed
  String? get getPreviousPage => previousPage;

  @action
  void setPreviousPage(String? page) {
    previousPage = page;
  }
}

final CommonController commonController = CommonController();
