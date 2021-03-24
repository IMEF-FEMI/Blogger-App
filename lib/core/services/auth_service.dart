import 'package:flutter/foundation.dart';

import 'api/api.dart';
import 'api/endpoints.dart';
import 'sharedpreferences/shared_prefs.dart';

class AuthService {
  final SharedPrefs sharedPrefs;
  final Api api;

  AuthService({
    @required this.sharedPrefs,
    @required this.api,
  });

  ///check if user token exists
  Future<bool> isUserLoggedIn() async {
    return await sharedPrefs.getToken() != null;
  }

  Future loginInWithUsernameAndPassword(Map<String, dynamic> params) async {
    final result = await api.httpPostCall(Endpoints.login, params);

    // save token and user details
    await sharedPrefs.setToken(result['token']);
    return result;
  }

  Future logout() async {
    return await sharedPrefs.clearSharedPrefs();
  }
}
