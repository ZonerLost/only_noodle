import 'api_client.dart';
import 'auth_service.dart';
import 'cart_service.dart';
import 'category_service.dart';
import 'driver_service.dart';
import 'loyalty_service.dart';
import 'notification_service.dart';
import 'order_service.dart';
import 'payment_service.dart';
import 'product_service.dart';
import 'restaurant_service.dart';
import 'storage/auth_storage.dart';
import 'support_service.dart';
import 'user_service.dart';
import 'zone_service.dart';

class ServiceLocator {
  static late AuthStorage authStorage;
  static late ApiClient apiClient;
  static late AuthService authService;
  static late UserService userService;
  static late CategoryService categoryService;
  static late RestaurantService restaurantService;
  static late ProductService productService;
  static late CartService cartService;
  static late OrderService orderService;
  static late NotificationService notificationService;
  static late LoyaltyService loyaltyService;
  static late DriverService driverService;
  static late SupportService supportService;
  static late ZoneService zoneService;
  static late PaymentService paymentService;

  static Future<void> init() async {
    authStorage = await AuthStorage.init();
    apiClient = ApiClient(authStorage);
    authService = AuthService(apiClient, authStorage);
    userService = UserService(apiClient);
    categoryService = CategoryService(apiClient);
    restaurantService = RestaurantService(apiClient);
    productService = ProductService(apiClient);
    cartService = CartService(apiClient);
    orderService = OrderService(apiClient);
    notificationService = NotificationService(apiClient);
    loyaltyService = LoyaltyService(apiClient);
    driverService = DriverService(apiClient);
    supportService = SupportService(apiClient);
    zoneService = ZoneService(apiClient);
    paymentService = PaymentService(apiClient);
  }
}
