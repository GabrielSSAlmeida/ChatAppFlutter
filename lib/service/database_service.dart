import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //CollectionReference = usado para add documentos, get documentos e buscar documentos do firestore
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  //Vai criar uma coleção users

  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");
  //Vai criar uma coleção group

  //save o userdata
  Future savingUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "groups": [],
      "profilePic": "",
      "uid": uid,
    });
  }

  //get o userdata
  Future gettingUserdata(String email) async {
    //faz uma busca no firestore
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
}
