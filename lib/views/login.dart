import 'package:app_login/services/authentication_service.dart';
import 'package:app_login/views/registration.dart';
import 'package:app_login/widgets/snack_bar_widget.dart';
import 'package:app_login/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    _passwordController.text = 'minhasenha';
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
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
                      keyboardType: TextInputType.multiline,
                      maxLines: 1,
                      decoration: decoration("email"),
                      controller: _emailController,
                      validator: (value) =>
                          requiredValidator(value, "o usuário")),
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
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String email = _emailController.text;
                      String password = _passwordController.text;
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
