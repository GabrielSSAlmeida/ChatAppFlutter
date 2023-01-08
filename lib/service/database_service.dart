import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //CollectionReference = usado para add documentos, get documentos e buscar documentos do firestore
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  //Vai criar ou dar get em uma coleção users

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

  //get user groups
  getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  //criar os grupos no database
  Future createGroup(String userName, String id, String groupName) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${id}_$userName",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMEssageSender": "",
    });
    //documentReference.id é criado depois que completa o metodo, por isso não é possivel utilizar no add

    //update os membros
    await groupDocumentReference.update({
      //Adiciona um elemento no array members
      "members": FieldValue.arrayUnion(["${uid}_$userName"]),
      "groupId": groupDocumentReference.id,
    });

    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      "groups":
          FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
    });
  }
}
