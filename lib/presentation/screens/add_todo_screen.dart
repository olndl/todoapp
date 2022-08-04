import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/dimension.dart';
import '../../core/localization/l10n/all_locales.dart';
import '../../data/models/todo/todo.dart';
import '../bloc/add_todo/add_todo_cubit.dart';

class AddTodoScreen extends StatefulWidget {
  final int revision;

  const AddTodoScreen({Key? key, required this.revision}) : super(key: key);

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  Random _random = Random();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
      ),
      body: BlocListener<AddTodoCubit, AddTodoState>(
        listener: (context, state) {
          if (state is TodoAdded) {
            Navigator.pop(context);
          } else if (state is AddTodoError) {
            debugPrint(state.error);
          }
        },
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(context) {
    return Column(
      children: [
        Card(
          color: Colors.white,
          margin: EdgeInsets.all(Dim.width(context) / 25),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: TextField(
            minLines: 4,
            maxLines: 100,
            autofocus: true,
            controller: _controller,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(Dim.width(context) / 20),
                border: InputBorder.none,
                hintText: AllLocale.of(context).hintMessage),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 10.0),
        InkWell(
          onTap: () {
            final message = _controller.text;
            Todo newTask = Todo(
                id: _random.nextInt(10000).toString(),
                createdAt: DateTime.now().millisecondsSinceEpoch,
                text: message,
                lastUpdatedBy: "123",
                changedAt: DateTime.now().millisecondsSinceEpoch,
                deadline: DateTime.now().millisecondsSinceEpoch,
                done: true,
                importance: 'low');
            BlocProvider.of<AddTodoCubit>(context)
                .addTodo(newTask, widget.revision);
          },
          child: _addBtn(context),
        )
      ],
    );
  }

  Widget _addBtn(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: BlocBuilder<AddTodoCubit, AddTodoState>(
          builder: (context, state) {
            if (state is AddingTodo) return CircularProgressIndicator();
            return Text(
              "Add Todo",
              style: TextStyle(color: Colors.white),
            );
          },
        ),
      ),
    );
  }
}
