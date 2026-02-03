import 'package:get/get.dart';
import 'package:only_noodle/models/notification_model.dart';
import 'package:only_noodle/services/service_locator.dart';
import 'package:only_noodle/utils/error_handler.dart';

class NotificationsController extends GetxController {
  final notifications = <AppNotification>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final list = await ServiceLocator.notificationService.getNotifications();
      notifications.assignAll(list);
    } on ApiException catch (error) {
      errorMessage.value = error.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markRead(String id) async {
    await ServiceLocator.notificationService.markRead(id);
    await loadNotifications();
  }

  Future<void> delete(String id) async {
    await ServiceLocator.notificationService.deleteNotification(id);
    await loadNotifications();
  }
}
