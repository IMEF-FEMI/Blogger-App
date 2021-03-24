import 'package:blogger_app/core/enums/auth_state.dart';
import 'package:blogger_app/core/enums/view_state.dart';
import 'package:blogger_app/core/services/auth_service.dart';
import 'package:flutter/foundation.dart';
import '../../locator.dart';
import 'base_model.dart';

class AuthenticationViewModel extends BaseModel {
  String errorMessage = "";

  AuthService _authService = locator<AuthService>();

  AuthState _authState = AuthState.Uninitialized;

  AuthState get authState => _authState;

  void setAuthState(AuthState authState) {
    _authState = authState;
    notifyListeners();
  }

  ///initialize App
  /// check if user is logged in or not
  AuthenticationViewModel.initialize() {
    initialize();
  }

  Future initialize() async {
    final bool isLoggedIn = await _authService.isUserLoggedIn();
    if (isLoggedIn) {
      setAuthState(AuthState.Authenticated);
    } else {
      setAuthState(AuthState.Unauthenticated);
    }
  }

  Future loginInWithUsernameAndPassword({
    @required String username,
    @required String password,
  }) async {
    setState(ViewState.Busy);
    try {
      final result = await _authService.loginInWithUsernameAndPassword({
        "username": username,
        "password": password,
      });
      // set setate as authenticated
      //if function call was successful
      setAuthState(AuthState.Authenticated);
      return result;
    } catch (e) {
      print(e);
      errorMessage = e.message;
      setState(ViewState.Error);
    }
  }

  Future logout() async {
    return await _authService.logout();
  }
}
