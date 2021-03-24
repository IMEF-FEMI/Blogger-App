import 'package:blogger_app/ui/views/blog_list_view.dart';
import 'package:blogger_app/ui/views/init_app.dart';
import 'package:flutter/material.dart';

import 'ui/views/login_View.dart';

class PageRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => InitAppView());
      case '/blog_list':
        return MaterialPageRoute(builder: (_) => BlogListView());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginView());
      // case '/signup':
      //   return MaterialPageRoute(builder: (_) => SignUpView());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                "No Route Defined",
              ),
            ),
          ),
        );
    }
  }
}
