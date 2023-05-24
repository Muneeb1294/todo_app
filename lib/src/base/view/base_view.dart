import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:note_app/constants/fb_collections.dart';
import 'package:note_app/src/base/model/todo_data.dart';
import 'package:note_app/src/base/vm/base_vm.dart';
import 'package:note_app/utils/bot_toast/zbot_toast.dart';
import 'package:note_app/utils/global_functions.dart';
import 'package:note_app/utils/global_widgets.dart';
import 'package:note_app/utils/heights_widths.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';
import '../../../utils/app_bar.dart';
import 'create_todo.dart';

class BaseView extends StatefulWidget {
  static String route = "/base_view";
  const BaseView({Key? key}) : super(key: key);

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      BaseVM vm = Provider.of<BaseVM>(context, listen: false);
      ZBotToast.loadingShow();
      bool check = await vm.readTodos();
      if (check) {
        ZBotToast.loadingClose();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BaseVM>(builder: (context, vm, _) {
      return WillPopScope(
        onWillPop: GlobalFunctions.onWillPop,
        child: Scaffold(
          appBar: appBar("todos"),
          floatingActionButton: FloatingActionButton(
            mini: true,
            onPressed: () {
              Get.toNamed(CreateTodo.route);
            },
            backgroundColor: R.colors.themeYellow,
            child: const Icon(Icons.add),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlobalWidgets.fieldTitle("your_todos"),
              h2,
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: List.generate(vm.todoItems.length,
                      (index) => todoCard(vm: vm, model: vm.todoItems[index])),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget todoCard({required BaseVM vm, required TodoData model}) => Slidable(
        key: ValueKey(model.id),
        endActionPane: ActionPane(
          extentRatio: .35,
          motion: const ScrollMotion(),
          children: [
            CustomSlidableAction(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              onPressed: (context) async {
                vm.todoItems.remove(model);
                vm.update();
                await vm.deleteTodo(model.id ?? "");
              },
              backgroundColor: Colors.transparent,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 1.5.w),
                decoration: BoxDecoration(
                  color: R.colors.red.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                  border: Border.all(
                    color: R.colors.red.withOpacity(0.2),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.delete,
                    color: R.colors.red,
                    size: 25,
                  ),
                ),
              ),
            ),
            CustomSlidableAction(
              padding: const EdgeInsets.only(right: 10),
              onPressed: (context) async {
                Get.toNamed(CreateTodo.route,
                    arguments: {"isEdit": true, "model": model});
              },
              backgroundColor: Colors.transparent,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 1.5.w),
                decoration: BoxDecoration(
                  color: R.colors.green.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                  border: Border.all(
                    color: R.colors.green.withOpacity(0.2),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.edit,
                    color: R.colors.green,
                    size: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: R.decoration.cardBoxDecoration(),
          child: Row(
            children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.title ?? "",
                        style: R.textStyles.poppins(),
                      ),
                      h2,
                      Text(
                        model.description ?? "",
                        style: R.textStyles.poppins(),
                      ),
                    ]),
              ),
              Checkbox(
                  value: model.isDone,
                  onChanged: (v) async {
                    model.isDone = v;
                    vm.update();
                    await FBCollections.todos
                        .doc(model.id)
                        .update({"isDone": v});
                  })
            ],
          ),
        ),
      );
}
