import 'package:courier_app/api/model/user/user.dart';
import 'package:courier_app/helpers/cache_helper.dart';
import 'package:courier_app/res/keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cache_manager.dart';

class UserManager {
  static final UserManager _instance = UserManager._internal();
  static final Rx<UserManager> _rx = Rx(_instance);

  static UserManager get instance => _instance;

  static Rx<UserManager> get rx => _rx;

  UserManager._internal();

  User? _user;

  User? get user => _user;

  init() async {
    try {
      _user = User.fromJson(await CacheManager.instance.getEncrypt(Keys.user));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  save({User? user, bool needNotify = true}) async {
    if (user != null) {
      await CacheManager.instance.putEncrypt(Keys.user, user.toJson());
    } else {
      await CacheManager.instance.deleteEncrypt(Keys.user);
    }

    if (needNotify) {
      _rx.update((manager) {
        manager!._user = user;
      });
    } else {
      _user = user;
    }
  }

  void silentRefreshUserInfo() async {
    final user = this.user;
    if (user != null) {
      User? newUser;

      try {
        await save(user: newUser);
      } catch (e) {}
    }
  }

  clear() async {
    await CacheManager.instance.deleteEncrypts([Keys.user]);

    _user = null;
    _rx.update((manager) {
      manager!._user = null;
    });
  }

  bool get isLogin => CacheHelper.ticket?.isNotEmpty == true;
}
