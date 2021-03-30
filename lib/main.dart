import 'package:blogger_app/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/viewmodels/authentication_viewmodel.dart';
import 'page_router.dart';
import 'ui/shared/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationViewModel>.value(
          // add AuthenticationViewModel here so it can be accessed globally
          value: AuthenticationViewModel.initialize(),
        ),
      ],
      child: MaterialApp(
        title: 'blogger App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: AppColors.primarySwatch,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            elevation: 0.0,
          ),
          brightness: Brightness.dark,
        ),
        initialRoute: '/',
        onGenerateRoute: PageRouter.generateRoute,
      ),
    );
  }
}
