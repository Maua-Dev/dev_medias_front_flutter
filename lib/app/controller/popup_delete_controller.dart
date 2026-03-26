import 'package:mobx/mobx.dart';

part 'popup_delete_controller.g.dart';

class PopupDeleteController = PopupDeleteControllerBase with _$PopupDeleteController;

abstract class PopupDeleteControllerBase with Store {
  @observable
  bool isVisible = false;

  @action
  void showPopup() {
    isVisible = true;
  }

  @action
  void hidePopup() {
    isVisible = false;
  }

  @action
  void deleteCourse() {
    hidePopup();
  }
}
