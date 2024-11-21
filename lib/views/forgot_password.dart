import 'package:app_login/services/authentication_service.dart';
import 'package:app_login/widgets/snack_bar_widget.dart';
import 'package:app_login/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  AuthenticationService _authenticationService = AuthenticationService();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Recuperação de Senha'),
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Digite seu email e enviaremos um link para você resetar sua senha",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            maxLines: 1,
                            decoration: decoration("email"),
                            controller: _emailController,
                            validator: (value) =>
                                requiredValidator(value, "o email")),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            String email = _emailController.text;
                            _authenticationService
                                .passwordReset(email)
                                .then((erro) {
                              if (erro != null) {
                                snackBarWidget(
                                    context: context,
                                    title: erro,
                                    isError: true);
                              } else {
                                snackBarWidget(
                                    context: context,
                                    title: "Link enviado com sucesso!",
                                    isError: false);
                              }
                            });
                          }
                        },
                        child: Text(
                          "Resetar Senha",
                        ),
                      )
                    ])))));
  }
}
