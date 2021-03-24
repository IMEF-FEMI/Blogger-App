import 'package:blogger_app/core/enums/auth_state.dart';
import 'package:blogger_app/core/viewmodels/authentication_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blog_list_view.dart';
import 'login_View.dart';

class InitAppView extends StatefulWidget {
  @override
  _InitAppViewState createState() => _InitAppViewState();
}

class _InitAppViewState extends State<InitAppView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationViewModel>(builder: (context, model, child) {
      if (model.authState == AuthState.Authenticated) {
        return BlogListView();
      }

      if (model.authState == AuthState.Unauthenticated) {
        return LoginView();
      }
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
        ),
      );
    });
  }
}
