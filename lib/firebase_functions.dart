import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/taskmodel.dart';

import 'models/usermodel.dart';

class FirebaseFunction {
  static CollectionReference<TaskModel> getTaskCollection() {
    return FirebaseFirestore.instance.collection('Tasks').withConverter(
        fromFirestore: (snapshot, _) {
      return TaskModel.fromJson(snapshot.data()!);
    }, toFirestore: (task, _) {
      return task.toJson();
    });
  }

  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (user, _) {
        return user.toJson();
      },
    );
  }

  static addUser(UserModel userModel) {
    var collection = getUsersCollection();
    var docRef = collection.doc(userModel.id);
    docRef.set(userModel);
  }

  static Future<void> addTask(TaskModel task) {
    var collection = getTaskCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getTask(DateTime date) {
    var collection = getTaskCollection();
    return collection
        .where('date',
            isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String id) {
    var collection = getTaskCollection();
    return collection.doc(id).delete();
  }

  static Future<void> updateTask(TaskModel task) {
    var collection = getTaskCollection();
    return collection.doc(task.id).update(task.toJson());
  }

  static Future<UserModel?> readUserData() async {
    var collection = getUsersCollection();

    DocumentSnapshot<UserModel> docUser =
        await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    return docUser.data();
  }

  static login(String emailAddress, String password, Function onSuccess,
      Function onError) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message);
    }
  }

  static createAccount(String email, String password,
      {required Function onSuccess,
      required Function onError,
      required String username,
      required String phone,
      required int age}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      credential.user?.sendEmailVerification();
      UserModel userModel = UserModel(
        id: credential.user!.uid,
        username: username,
        phone: phone,
        age: age,
        email: email,
      );
      addUser(userModel);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message);
    } catch (e) {
      onError(e.toString());
    }
  }
}
