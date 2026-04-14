import 'package:dev_medias_front_flutter/app/model/notice.dart';
import 'package:dev_medias_front_flutter/app/service/notification_service.dart';
import 'package:mobx/mobx.dart';

part 'notifications_controller.g.dart';

class NotificationsController = NotificationsControllerBase
    with _$NotificationsController;

abstract class NotificationsControllerBase with Store {
  NotificationsControllerBase();

  final NotificationService _service = NotificationService();

  @observable
  ObservableList<NoticeModel> notices = ObservableList<NoticeModel>();

  @action
  Future<void> fetchNotifications() async {
    final list = await _service.getNotifications();
    notices = ObservableList<NoticeModel>.of(list);
  }
}

final NotificationsController notificationsController =
    NotificationsController();
