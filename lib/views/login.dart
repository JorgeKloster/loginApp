import 'package:app_login/main.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _AppLoginState();
}

class _AppLoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _userController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Form(
            key: _formKey,
            child: Column(children: [
              Padding(
                padding: EdgeInsets.fromLTRB(85.0, 200, 85.0, 5.0),
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(85.0, 30, 85.0, 5.0),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 1,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "Usuário",
                      hintText: "Digite o usuário",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  controller: _userController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Usuário Obrigatório";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(85.0, 10, 85.0, 5.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Senha Obrigatória";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: 1,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      labelText: "Senha",
                      hintText: "Digite a senha",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  controller: _passwordController,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AppLogin()));
                  }
                },
                child: Text(
                  "Entrar",
                ),
              )
            ])));
  }
}
