import 'dart:ffi';

import 'package:app_login/services/authentication_service.dart';
import 'package:app_login/views/registration.dart';
import 'package:app_login/widgets/snack_bar_widget.dart';
import 'package:app_login/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _AppLoginState();
}

class _AppLoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  AuthenticationService _authenticationService = AuthenticationService();
  bool _obscureText = true;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _passwordController.text = 'minhasenha';
    _loadLoginState();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _saveLoginState(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      await prefs.setString('email', email);
      await prefs.setString('password', password);
      await prefs.setBool('remember', _rememberMe);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.setBool('remember', false);
    }
  }

  void _loadLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = prefs.getBool('remember') ?? false;
      if (_rememberMe) {
        _emailController.text = prefs.getString('email') ?? '';
        _passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    decoration: decoration("email"),
                    controller: _emailController,
                    validator: (value) => requiredEmailValidator(value),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) =>
                              requiredValidator(value, "a senha"),
                          keyboardType: TextInputType.multiline,
                          maxLines: 1,
                          decoration: decoration("senha"),
                          controller: _passwordController,
                          obscureText: _obscureText,
                        ),
                        IconButton(
                            onPressed: _togglePasswordVisibility,
                            icon: Icon(
                              Icons.remove_red_eye,
                            ))
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                      ),
                      Text('Lembrar-me'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      _saveLoginState(email, password);
                      _authenticationService
                          .loginUser(email: email, password: password)
                          .then((erro) {
                        if (erro != null) {
                          snackBarWidget(
                              context: context, title: erro, isError: true);
                        }
                      });
                    }
                  },
                  child: Text(
                    "Entrar",
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(15),
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Registration()));
                        },
                        child: Text("Registre-se"))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/esqueceuSenha");
                        },
                        child: Text(
                          "Esqueceu a senha?",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ])),
        ),
      ),
    );
  }
}
