import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference trainings =
      FirebaseFirestore.instance.collection("trainings");

  Future addTraining(String? day, String? train) {
    return trainings.add({"day": day, "training": train});
  }

  Stream<QuerySnapshot> getTrainingsStream() {
    final trainingStream = trainings.snapshots();
    return trainingStream;
  }

  Future<void> updateTraining(String docID, String? newDay, String? newTrain) {
    return trainings.doc(docID).update({"day": newDay, "training": newTrain});
  }

  Future<void> deleteTraining(String docID) {
    return trainings.doc(docID).delete();
  }

  Future<DocumentSnapshot> getTraining(String docID) {
    return trainings.doc(docID).get();
  }
}
