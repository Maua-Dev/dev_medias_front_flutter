import 'package:mobx/mobx.dart';

part 'common_controller.g.dart';

class CommonController = _CommonControllerBase with _$CommonController;

abstract class _CommonControllerBase with Store {

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
