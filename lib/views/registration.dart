import 'package:app_login/services/authentication_service.dart';
import 'package:app_login/widgets/snack_bar_widget.dart';
import 'package:app_login/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _AppLoginState();
}

class _AppLoginState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _userController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  AuthenticationService _authService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registro'),
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Registro",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 1,
                            decoration: decoration("usuário"),
                            controller: _userController,
                            validator: (value) =>
                                requiredValidator(value, "o usuário")),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 1,
                          decoration: decoration("email"),
                          controller: _emailController,
                          validator: (value) =>
                              requiredValidator(value, "o email"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: TextFormField(
                          validator: (value) =>
                              requiredValidator(value, "a senha"),
                          keyboardType: TextInputType.multiline,
                          maxLines: 1,
                          decoration: decoration("senha"),
                          controller: _passwordController,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            String user = _userController.text;
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            _authService
                                .registerUser(
                                    user: user,
                                    email: email,
                                    password: password)
                                .then((value) {
                              if (value != null) {
                                snackBarWidget(
                                    context: context,
                                    title: value,
                                    isError: true);
                              } else {
                                snackBarWidget(
                                    context: context,
                                    title: 'Cadastro Efetuado com Sucesso!',
                                    isError: false);
                                Navigator.pop(context);
                              }
                            });
                          }
                        },
                        child: Text(
                          "Registrar",
                        ),
                      ),
                    ])))));
  }
}
