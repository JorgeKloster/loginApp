import 'package:app_login/views/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      initialRoute: "login",
      routes: {
        "/": (context) => AppLogin(),
        "login": (content) => Login(),
        //"formDeTarefas": (content) => FormViewTasks(),
      },
    );
  }
}

class AppLogin extends StatefulWidget {
  const AppLogin({super.key});

  @override
  State<AppLogin> createState() => _AppLoginState();
}

class _AppLoginState extends State<AppLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela Inicial"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text("Jorge"),
                accountEmail: Text("jfkloster@gmail.com"),
                currentAccountPicture: ClipOval(
                  child: Container(
                    height: 100,
                    width: 100,
                    child: FittedBox(
                      fit: BoxFit.fill,
                    ),
                  ),
                )),
            ListTile(
              title: Text(
                "Sair",
              ),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.pushNamed(context, "login");
              },
            ),
            Divider(
              thickness: 2,
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(30, 300, 30, 5.0),
              child: Text(
                "Bem vindo a tela inicial!",
                style: TextStyle(
                  fontSize: 30,
                ),
              ))
        ],
      ),
    );
  }
}
