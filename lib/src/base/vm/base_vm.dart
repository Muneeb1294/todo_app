import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:note_app/constants/fb_collections.dart';
import 'package:note_app/src/base/model/todo_data.dart';
import 'package:note_app/utils/bot_toast/zbot_toast.dart';

class BaseVM extends ChangeNotifier {
  List<TodoData> todoItems = [];

  Future<bool> createTodos(TodoData model) async {
    bool check = false;
    try {
      await FBCollections.todos.doc(model.id).set(model.toJson(),SetOptions(merge: true));
      check = true;
      notifyListeners();
    } on Exception catch (e) {
      ZBotToast.showToastError(message: e.toString());
      debugPrintStack();
    }
    return check;
  }

  Future<bool> readTodos() async {
    bool check = false;
    try {
      QuerySnapshot q = await FBCollections.todos.get();
      todoItems =
          q.docs.map<TodoData>((e) => TodoData.fromJson(e.data())).toList();
      check = true;
      notifyListeners();
    } on Exception catch (e) {
      ZBotToast.showToastError(message: e.toString());
      debugPrintStack();
    }
    return check;
  }

  Future<bool> updateTodo(TodoData model) async {
    bool check = false;
    try {
      await FBCollections.todos.doc(model.id).update(model.toJson());
      notifyListeners();
      check = true;
    } on Exception catch (e) {
      ZBotToast.showToastError(message: e.toString());
      debugPrintStack();
    }
    return check;
  }

  Future<bool> deleteTodo(String id) async {
    bool check = false;
    try {
      await FBCollections.todos.doc(id).delete();
      notifyListeners();
      check = true;
    } on Exception catch (e) {
      ZBotToast.showToastError(message: e.toString());
      debugPrintStack();
    }
    return check;
  }

  void update() {
    notifyListeners();
  }
}
