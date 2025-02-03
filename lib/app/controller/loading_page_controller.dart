import 'package:mobx/mobx.dart';
part 'loading_page_controller.g.dart';

class LoadingPageController = LoadingPageControllerBase
    with _$LoadingPageController;

abstract class LoadingPageControllerBase with Store {
  LoadingPageControllerBase();

  @observable
  bool _loading = false;

  @action
  bool getLoading() {
    return _loading;
  }

  @action
  void setLoading(bool status) {
    _loading = status;
  }
}

LoadingPageController loadingPageController = LoadingPageController();
