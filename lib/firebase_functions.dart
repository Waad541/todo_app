import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/taskmodel.dart';

class FirebaseFunction {
  static CollectionReference<TaskModel> getTaskCollection() {
    return FirebaseFirestore.instance.collection('Tasks').withConverter(
        fromFirestore: (snapshot, _) {
      return TaskModel.fromJson(snapshot.data()!);
    }, toFirestore: (task, _) {
      return task.toJson();
    });
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
}
