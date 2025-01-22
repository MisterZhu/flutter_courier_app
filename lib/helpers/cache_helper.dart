import 'package:courier_app/api/model/user/user.dart';
import 'package:courier_app/managers/cache_manager.dart';
import 'package:courier_app/managers/user_manager.dart';
import 'package:courier_app/res/keys.dart';

abstract class CacheHelper {
  /// Ticket
  static String? get ticket => CacheManager.instance.getGlobal(Keys.ticket);
  static void saveTicket(String ticket) =>
      CacheManager.instance.putGlobal(key: Keys.ticket, value: ticket);
  static void clearTicket() => CacheManager.instance.deleteGlobal(Keys.ticket);
  static bool containsTicket() =>
      CacheManager.instance.containsGlobal(Keys.ticket);

  /// User
  static User? get user => UserManager.instance.user;
  static void saveUser({User? user, bool needNotify = false}) =>
      UserManager.instance.save(
        user: user,
        needNotify: needNotify,
      );
  static void clearUser() => UserManager.instance.clear();

  /// Remove all
  static void clearAll() {
    clearTicket();
    clearUser();
  }
}
