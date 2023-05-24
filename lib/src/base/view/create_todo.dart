import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:note_app/constants/fb_collections.dart';
import 'package:note_app/src/base/vm/base_vm.dart';
import 'package:note_app/utils/app_bar.dart';
import 'package:note_app/utils/app_button.dart';
import 'package:note_app/utils/bot_toast/zbot_toast.dart';
import 'package:note_app/utils/field_validations.dart';
import 'package:provider/provider.dart';

import '../../../resources/resources.dart';
import '../../../utils/global_widgets.dart';
import '../../../utils/heights_widths.dart';
import '../model/todo_data.dart';

class CreateTodo extends StatefulWidget {
  static String route = "/create_todo";
  const CreateTodo({super.key});

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  TodoData? model;
  bool isEdit = false;
  dynamic args;

  final titleC = TextEditingController();
  final descriptionC = TextEditingController();
  final titleF = FocusNode();
  final descriptionF = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      args = ModalRoute.of(context)?.settings.arguments;
      if (args != null) {
        if (args["isEdit"] != null) {
          isEdit = args["isEdit"];
          if (args["model"] != null) {
            model = args["model"];
            titleC.text = model?.title ?? "";
            descriptionC.text = model?.description ?? "";
          }
        }
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BaseVM>(builder: (context, vm, _) {
      return Scaffold(
        appBar: appBar("add_todo", isBackButton: true),
        body: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalWidgets.fieldTitle("title"),
                titleField(),
                h2,
                GlobalWidgets.fieldTitle("description"),
                descriptionField(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20),
          child: AppButton(
              buttonTitle: "save",
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  ZBotToast.loadingShow();
                  TodoData todo = createTodo();
                  bool check = await vm.createTodos(todo);
                  if (check) {
                    if (isEdit) {
                      int index = vm.todoItems
                          .indexWhere((element) => element.id == model?.id);
                      if (index != -1) {
                        vm.todoItems[index] = todo;
                      }
                    } else {
                      vm.todoItems.add(todo);
                    }
                    vm.update();
                    Get.back();
                    ZBotToast.loadingClose();
                  }
                }
              }),
        ),
      );
    });
  }

  TextFormField titleField() {
    return TextFormField(
      controller: titleC,
      focusNode: titleF,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      decoration: R.decoration.fieldDecoration(hintText: "enter_title"),
      inputFormatters: [LengthLimitingTextInputFormatter(60)],
      validator: FieldValidator.validateEmptyField,
    );
  }

  TextFormField descriptionField() {
    return TextFormField(
      controller: descriptionC,
      focusNode: descriptionF,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.name,
      maxLines: 6,
      decoration: R.decoration.fieldDecoration(hintText: "enter_description"),
      inputFormatters: [LengthLimitingTextInputFormatter(200)],
      validator: FieldValidator.validateEmptyField,
    );
  }

  TodoData createTodo() {
    DocumentReference ref = FBCollections.todos.doc();
    TodoData todo = TodoData(
      createdAt: isEdit ? model?.createdAt : Timestamp.now(),
      description: descriptionC.text.trim(),
      id: isEdit ? model?.id : ref.id,
      isDone: false,
      title: titleC.text.trim(),
    );
    return todo;
  }
}
