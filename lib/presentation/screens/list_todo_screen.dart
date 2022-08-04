import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/dimension.dart';
import '../../core/localization/l10n/all_locales.dart';
import '../../core/navigation/routes.dart';
import '../../data/models/todo/todo.dart';
import '../bloc/list_todo/todos_cubit.dart';
import '../widgets/app_header.dart';

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  const MyHeaderDelegate();

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    final progress = shrinkOffset / maxExtent;

    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: 1,
            child: ColoredBox(
              color: ColorApp.lightTheme.backPrimary,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            padding: EdgeInsets.lerp(
              EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              EdgeInsets.only(bottom: 16),
              progress,
            ),
            alignment: Alignment.lerp(
              Alignment.bottomLeft,
              Alignment.bottomCenter,
              progress,
            ),
            child: Text(
              'Mountains',
              style: TextStyle.lerp(
                Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: Colors.black),
                Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: Colors.black),
                progress,
              ),
            ),
          ),
          AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              padding: EdgeInsets.lerp(
                EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                EdgeInsets.only(bottom: 16),
                progress,
              ),
              alignment: Alignment.lerp(
                Alignment(.8, 2.35),
                Alignment(.67, 2.2),
                progress,
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 392 / 1.6),
                child:
                IconButton(onPressed: () {}, icon: Icon(Icons.visibility)),
              )),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 264;

  @override
  double get minExtent => 84;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class TodosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodosCubit>(context).fetchTodos();

    return BlocBuilder<TodosCubit, TodosState>(
        builder: (context, state) {
          if (!(state is TodosLoaded))
            return Center(child: CircularProgressIndicator());
          final todos = state.todos;
          final revision = state.revision;
          final scrollController = ScrollController();
          return Scaffold(
            backgroundColor: Color(0xfffcfaf1),
            body: CustomScrollView(
              slivers: [
                _head(),
                _subhead(context),
                _body(scrollController, context, todos, revision)
              //   Column(
              //   children: [
              //     InkWell(
              //       onTap: () => Navigator.pushNamed(context, Routes.ADD_TODO_ROUTE,
              //           arguments: revision),
              //       child: Padding(
              //         padding: const EdgeInsets.all(10.0),
              //         child: Icon(Icons.add),
              //       ),
              //     ),
              //     Column(
              //       children:
              //       todos.map((e) => _todo(e, revision, context)).toList(),
              //     ),
              //   ],
              // ),
          ]
            ),
            floatingActionButton: _btnAdd(revision, context),
          );

          //   CustomScrollView(
          //   slivers: [
          //     _head(),
          //     _subhead(context),
          //     _body(scrollController, context, todos, revision),
          //   ],
          // );
        },
      );
  }

  Widget _head() {
    return const SliverPersistentHeader(
      pinned: true,
      delegate: AppHeader(),
    );
  }

  Widget _subhead(context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: Dim.width(context) / 4.95),
        child: Text(
          AllLocale
              .of(context)
              .subtitle,
        ),
      ),
    );
  }

  Widget _body(ScrollController scrollController, context, List<Todo> todos,
      int revision) {
    return SliverToBoxAdapter(
        child: _card(scrollController, context, todos, revision)
    );
  }

  Widget _card(ScrollController scrollController, context, List<Todo> todos,
      int revision) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(
        top: Dim.height(context) / 40,
        left: Dim.width(context) / 56,
        right: Dim.width(context) / 56,
        bottom: Dim.height(context) / 40,
      ),
      child:
      _bodyCard(scrollController, context, todos, revision),);
  }


  Widget _bodyCard(controller, context, List<Todo> todos, int revision) {
    return ListView.builder(
      reverse: true,
      padding: EdgeInsets.only(
          top: Dim.height(context) / 100, bottom: Dim.height(context) / 100),
      controller: controller,
      shrinkWrap: true,
      itemCount: todos.length,
      itemBuilder: (BuildContext context, int index) {
        final item = todos[index];
        return ClipRRect(
            clipBehavior: Clip.hardEdge,
            child: _todoBody(index, item, context, revision));
      },
    );
  }

  Widget _todoBody(int index, Todo item, context, int revision) {
    return Dismissible(
      key: Key(item.id),
      background: _fromLeftToRight(),
      secondaryBackground: _fromRightToLeft(),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          BlocProvider.of<TodosCubit>(context).changeCompletion(item, revision);
          return false;
        }
        if (direction == DismissDirection.endToStart) {
          BlocProvider.of<TodosCubit>(context).deleteTodo(item, revision);
        }
      },
      onDismissed: (direction) =>
          _toDismissed(direction, context, item, revision),
      child: _todoTile(item, context, revision),
    );
  }

  Widget _fromLeftToRight() {
    return Container(
      color: Colors.green,
      alignment: Alignment.centerLeft,
      child: const Padding(
        padding: EdgeInsets.all(15),
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }


  Widget _fromRightToLeft() {
    return Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      child: const Padding(
        padding: EdgeInsets.all(15),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<bool> _confirmDismissal(DismissDirection direction, context,
      Todo item) async {
    if (direction == DismissDirection.startToEnd) {
      return false;
    } else {
      bool delete = true;
      final snackbarController = ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
          Text('${AllLocale
              .of(context)
              .deletedTask} ${item.text}'),
          action: SnackBarAction(
              label: AllLocale
                  .of(context)
                  .undo,
              onPressed: () => delete = false),
        ),
      );
      await snackbarController.closed;
      return delete;
    }
  }

  Future<bool?> _toDismissed(DismissDirection direction, context, Todo item,
      int revision) async
  {
    if (direction == DismissDirection.startToEnd) {
      BlocProvider.of<TodosCubit>(context).changeCompletion(item, revision);
      return false;
    }
    if (direction == DismissDirection.endToStart) {
      BlocProvider.of<TodosCubit>(context).deleteTodo(item, revision);
    }
  }


  Widget _todoTile(Todo todo, context, int revision) {
    bool isChanged = todo.done;
    return ListTile(
        onTap:() =>
            Navigator.pushNamed(context, Routes.EDIT_TODO_ROUTE,
                arguments: {"todo": todo, "revision": revision}),
        leading: Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor:
            todo.importance == "important" ? Colors.red : Colors.grey,
          ),
          child: Checkbox(
            checkColor: Colors.white,
            activeColor: Colors.green,
            value: isChanged,
            onChanged: (_) async {
              BlocProvider.of<TodosCubit>(context).changeCompletion(
                  todo, revision);
              //return false;
            },
          ),
        ),
        horizontalTitleGap: 3,
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.info_outline),
        ),
        title: todo.done == true
            ? Text(
          todo.text,
          style: const TextStyle(
              decoration: TextDecoration.lineThrough, color: Colors.grey),
        )
            : Row(
          children: [
            _priority(todo.importance),
            Text(
              todo.text,
            ),
          ],
        ),
        subtitle: todo.deadline != null
            ? Text(
            DateFormat('dd MMMM yyy', 'ru').format(
                DateTime.fromMillisecondsSinceEpoch(todo.deadline! * 1000)),
            style: const TextStyle(color: Colors.grey))
            : null);
  }


  Widget _priority(String? importance) {
    return importance == "basic"
        ? const Icon(Icons.arrow_downward)
        : (importance == "important"
        ? const Icon(
      Icons.priority_high_sharp,
      color: Colors.red,
    )
        : const Text(""));
  }


  Widget _btnAdd(int revision, context) {
    return FloatingActionButton(
      onPressed: () =>
          Navigator.pushNamed(context, Routes.ADD_TODO_ROUTE,
              arguments: revision),

      //     () {
      //   context
      //       .read<NavigationController>()
      //       .navigateTo(Routes.ADD_TODO_ROUTE, arguments: revision);
      // },
      child: const Icon(Icons.add),
    );
  }
}



  Widget _todo(Todo todo, int revision, context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routes.EDIT_TODO_ROUTE,
          arguments: {"todo": todo, "revision": revision}),
      child: Dismissible(
        key: Key("${todo.id}"),
        child: _todoTile(todo, context),
        confirmDismiss: (_) async {
          BlocProvider.of<TodosCubit>(context).changeCompletion(todo, revision);
          return false;
        },
        background: Container(
          color: Colors.indigo,
        ),
      ),
    );
  }

  Widget _todoTile(Todo todo, context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(todo.text),
          _completionIndicator(todo),
        ],
      ),
    );
  }

  Widget _completionIndicator(Todo todo) {
    return Container(
      width: 20.0,
      height: 20.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(
          width: 4.0,
          color: todo.done ? Colors.green : Colors.red,
        ),
      ),
    );
  }




// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:todoapp/core/constants/dimension.dart';
// import 'package:todoapp/core/localization/l10n/all_locales.dart';
// import '../../core/navigation/controller.dart';
// import '../../core/navigation/routes.dart';
// import '../../data/models/todo/todo.dart';
// import '../bloc/list_todo/todos_cubit.dart';
// import '../widgets/app_header.dart';
//
// class TodoListScreen extends StatefulWidget {
//   const TodoListScreen({Key? key}) : super(key: key);
//
//   @override
//   State<TodoListScreen> createState() => _TodoListScreenState();
// }
//
// class _TodoListScreenState extends State<TodoListScreen> {
//   @override
//   Widget build(BuildContext context) {
//     BlocProvider.of<TodosCubit>(context).fetchTodos();
//
//     final scrollController = ScrollController();
//     return BlocBuilder<TodosCubit, TodosState>(
//       builder: (context, state) {
//         if (state is! TodosLoaded) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         final todos = state.todos;
//         final revision = state.revision;
//         return Scaffold(
//           backgroundColor: Color(0xfffcfaf1),
//           body: CustomScrollView(slivers: [
//             _head(),
//             _subhead(),
//             _body(scrollController, todos, revision),
//           ]),
//           floatingActionButton: _btnAdd(revision)
//         );
//       },
//     );
//   }
//
//   Widget _head() {
//     return const SliverPersistentHeader(
//       pinned: true,
//       delegate: AppHeader(),
//     );
//   }
//
//   Widget _subhead() {
//     return SliverToBoxAdapter(
//       child: Padding(
//         padding: EdgeInsets.only(left: Dim.width(context) / 4.95),
//         child: Text(
//           AllLocale.of(context).subtitle,
//         ),
//       ),
//     );
//   }
//
//   Widget _body(ScrollController scrollController, List<Todo> todos, int revision) {
//     return SliverToBoxAdapter(
//       child: _card(scrollController, todos, revision)
//     );
//   }
//
//   Widget _card(ScrollController scrollController, List<Todo> todos, int revision) {
//     return Card(
//       color: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       margin: EdgeInsets.only(
//         top: Dim.height(context) / 40,
//         left: Dim.width(context) / 56,
//         right: Dim.width(context) / 56,
//         bottom: Dim.height(context) / 40,
//       ),
//       child:
//       _bodyCard(scrollController, todos, revision),);
//   }
//
//
//
//   Widget _bodyCard(controller, List<Todo> todos, int revision) {
//     return ListView.builder(
//       reverse: true,
//       padding: EdgeInsets.only(
//           top: Dim.height(context) / 100, bottom: Dim.height(context) / 100),
//       controller: controller,
//       shrinkWrap: true,
//       itemCount: todos.length,
//       itemBuilder: (BuildContext context, int index) {
//         final item = todos[index];
//         return ClipRRect(
//             clipBehavior: Clip.hardEdge,
//             child: _todoBody(index, item, revision));
//       },
//     );
//   }
//
//   Widget _todoBody(int index, Todo item, int revision) {
//     return Dismissible(
//       key: Key(item.id),
//       background: _fromLeftToRight(),
//       secondaryBackground: _fromRightToLeft(),
//       confirmDismiss: (_) async {
//       BlocProvider.of<TodosCubit>(context).changeCompletion(item, revision);
//       return false;
//     },
//       onDismissed: (direction) => _toDismissed(direction, item, revision),
//       child: _todoTile(item, revision),
//     );
//   }
//
//   Widget _fromLeftToRight() {
//     return Container(
//       color: Colors.green,
//       alignment: Alignment.centerLeft,
//       child: const Padding(
//         padding: EdgeInsets.all(15),
//         child: Icon(
//           Icons.check,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
//
//
//   Widget _fromRightToLeft() {
//     return Container(
//       color: Colors.green,
//       alignment: Alignment.centerLeft,
//       child: const Padding(
//         padding: EdgeInsets.all(15),
//         child: Icon(
//           Icons.check,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
//
//    Future<bool> _confirmDismissal(DismissDirection direction, Todo item) async {
//      if (direction == DismissDirection.startToEnd) {
//        return false;
//      } else {
//        bool delete = true;
//        final snackbarController = ScaffoldMessenger.of(context).showSnackBar(
//          SnackBar(
//            content:
//            Text('${AllLocale.of(context).deletedTask} ${item.text}'),
//            action: SnackBarAction(
//                label: AllLocale.of(context).undo,
//                onPressed: () => delete = false),
//          ),
//        );
//        await snackbarController.closed;
//        return delete;
//      }
//    }
//
//   Future<bool?> _toDismissed(DismissDirection direction, Todo item, int revision) async
//      {
//        if (direction == DismissDirection.startToEnd) {
//          BlocProvider.of<TodosCubit>(context).changeCompletion(item, revision);
//        return false;
//        }
//        if (direction == DismissDirection.endToStart) {
//          BlocProvider.of<TodosCubit>(context).deleteTodo(item, revision);
//        }
//      }
//
//
//   Widget _todoTile(Todo todo, int revision) {
//     bool isChanged = todo.done;
//     return ListTile(
//         onTap: () {
//           // context
//           //     .read<NavigationController>()
//           //     .navigateTo(Routes.view, arguments: todo);
//         },
//         leading: Theme(
//           data: Theme.of(context).copyWith(
//             unselectedWidgetColor:
//                 todo.importance == "important" ? Colors.red : Colors.grey,
//           ),
//           child: Checkbox(
//             checkColor: Colors.white,
//             activeColor: Colors.green,
//             value: isChanged,
//             onChanged: (isChanged) async {
//               BlocProvider.of<TodosCubit>(context)
//                   .changeCompletion(todo, revision);
//               setState((){isChanged = todo.done;});
//             },
//           ),
//         ),
//         horizontalTitleGap: 3,
//         trailing: IconButton(
//           onPressed: () {
//             context.read<NavigationController>().navigateTo(
//                 Routes.EDIT_TODO_ROUTE,
//                 arguments: {"todo": todo, "revision": revision});
//           },
//           icon: const Icon(Icons.info_outline),
//         ),
//         title: todo.done == true
//             ? Text(
//                 todo.text,
//                 style: const TextStyle(
//                     decoration: TextDecoration.lineThrough, color: Colors.grey),
//               )
//             : Row(
//                 children: [
//                   _priority(todo.importance),
//                   Text(
//                     todo.text,
//                   ),
//                 ],
//               ),
//         subtitle: todo.deadline != null
//             ? Text(
//                 DateFormat('dd MMMM yyy', 'ru').format(
//                     DateTime.fromMillisecondsSinceEpoch(todo.deadline! * 1000)),
//                 style: const TextStyle(color: Colors.grey))
//             : null);
//   }
//
//
//   Widget _priority(String? importance) {
//     return importance == "basic"
//         ? const Icon(Icons.arrow_downward)
//         : (importance == "important"
//             ? const Icon(
//                 Icons.priority_high_sharp,
//                 color: Colors.red,
//               )
//             : const Text(""));
//   }
//
//
//
//   Widget _btnAdd(int revision) {
//     return FloatingActionButton(
//       onPressed: () {
//         context
//             .read<NavigationController>()
//             .navigateTo(Routes.ADD_TODO_ROUTE, arguments: revision);
//       },
//       child: const Icon(Icons.add),
//     );
//   }
// }

