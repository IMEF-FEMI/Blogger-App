import 'package:blogger_app/core/enums/view_state.dart';
import 'package:blogger_app/core/viewmodels/authentication_viewmodel.dart';
import 'package:blogger_app/ui/widgets/shared_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _authModel = Provider.of<AuthenticationViewModel>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Text(
                    "Let's sign you in.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Welcome back.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SharedTextField(
                    controller: _usernameController,
                    icon: Icon(
                      Icons.person,
                      color: Color(0xff62626c),
                    ),
                    label: "Username",
                    validator: (value) {
                      if (value.isEmpty) {
                        return "required!";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  SharedTextField(
                    controller: _passwordController,
                    icon: Icon(
                      Icons.lock,
                      color: Color(0xff62626c),
                    ),
                    label: "Password",
                    validator: (value) {
                      if (value.isEmpty) {
                        return "required!";
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  if (_authModel.state == ViewState.Error)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        _authModel.errorMessage,
                        style: TextStyle(fontSize: 17, color: Colors.red),
                      ),
                    )
                ],
              ),
              if (_authModel.state != ViewState.Busy)
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await _authModel.loginInWithUsernameAndPassword(
                          username: _usernameController.text,
                          password: _passwordController.text,
                        );
                        // Navigator.pushNamed(context, "/blog_list");
                      }
                    },
                    child: Text("Sign In"),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                        ),
                        primary: Color(0xff62626c)))
              else
                Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
