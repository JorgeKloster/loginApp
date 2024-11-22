import 'package:app_login/services/authentication_service.dart';
import 'package:app_login/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirestoreService firestoreService = FirestoreService();

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
                accountName: Text(
                  widget.user.displayName != null
                      ? widget.user.displayName!
                      : "Não Informado",
                ),
                accountEmail: Text(
                  widget.user.email != null
                      ? widget.user.email!
                      : "Não Informado",
                ),
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
                AuthenticationService().logoutUser();
              },
            ),
            Divider(
              thickness: 2,
            )
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getTrainingsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List trainingList = snapshot.data!.docs;

            return ListView.builder(
              itemCount: trainingList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = trainingList[index];
                String docID = document.id;

                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;

                String trainingDay = data["day"];
                String trainingTrain = data["training"];

                return ListTile(
                    title: Text(trainingDay),
                    subtitle: Text(trainingTrain),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              _openModalForm(docID: docID);
                            },
                            icon: Icon(
                              Icons.settings,
                            )),
                        IconButton(
                            onPressed: () {
                              firestoreService.deleteTraining(docID);
                            },
                            icon: Icon(
                              Icons.delete,
                            )),
                      ],
                    ));
              },
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openModalForm();
        },
        backgroundColor: const Color.fromARGB(255, 230, 193, 193),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _openModalForm({String? docID}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          String? _selectedDayOption;
          final List<String> _dayOptions = [
            'Segunda',
            'Terça',
            'Quarta',
            'Quinta',
            'Sexta',
            'Sábado',
            'Domingo'
          ];
          String? _selectedTrainingOption;
          final List<String> _trainingOptions = [
            'Peito',
            'Costas',
            'Pernas',
            'Braços'
          ];
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text("Criar treino"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: _selectedDayOption,
                    hint: Text('Selecione o dia'),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedDayOption = newValue;
                      });
                    },
                    items: _dayOptions
                        .map<DropdownMenuItem<String>>((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                  DropdownButton<String>(
                    value: _selectedTrainingOption,
                    hint: Text('Selecione o treino'),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedTrainingOption = newValue;
                      });
                    },
                    items: _trainingOptions
                        .map<DropdownMenuItem<String>>((String options) {
                      return DropdownMenuItem<String>(
                        value: options,
                        child: Text(options),
                      );
                    }).toList(),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Fechar")),
                TextButton(
                    onPressed: () {
                      if (docID == null) {
                        firestoreService.addTraining(
                            _selectedDayOption, _selectedTrainingOption);
                      } else {
                        firestoreService.updateTraining(
                            docID, _selectedDayOption, _selectedTrainingOption);
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text("Salvar"))
              ],
            );
          });
        });
  }
}
