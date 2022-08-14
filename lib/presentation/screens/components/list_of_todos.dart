import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/dimension.dart';

class ListOfTodos extends StatelessWidget {
  final ScrollController scrollController;
  const ListOfTodos({Key? key, required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(
          top: Dim.height(context) / 100,
          bottom: Dim.height(context) / 100),
      controller: scrollController,
      shrinkWrap: true,
      itemCount:
      flag ? todos.length : uncompletedTodoList.length,
      itemBuilder: (BuildContext context, int index) {
        final item = flag
            ? todos[index]
            : uncompletedTodoList[index];
        bool isChanged = item.done;
        return ClipRRect(
          clipBehavior: Clip.hardEdge,
          child: Dismissible(
            key: Key(item.id),
            background: Container(
              color: ColorApp.lightTheme.colorGreen,
              alignment: Alignment.lerp(
                  Alignment.centerLeft,
                  Alignment.centerRight,
                  .05),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: SvgPicture.asset(
                  S.iconCheck,
                  color: ColorApp.lightTheme.colorWhite,
                ),
              ),
            ),
            secondaryBackground: Container(
              color: ColorApp.lightTheme.colorRed,
              alignment: Alignment.lerp(
                  Alignment.centerRight,
                  Alignment.centerLeft,
                  .05),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: SvgPicture.asset(
                  S.iconDelete,
                  color: ColorApp.lightTheme.colorWhite,
                ),
              ),
            ),
            confirmDismiss: (direction) =>
                _confirmDismissal(
                    direction, context, item, revision),
            onDismissed: (direction) => _toDismissed(
                direction, context, item, revision),
            child: ListTile(
                onTap: () => Navigator.pushNamed(
                    context, Routes.EDIT_TODO_ROUTE,
                    arguments: {
                      "todo": item,
                      "revision": revision
                    }),
                leading: Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: item
                        .importance ==
                        S.important
                        ? (_availableImportanceColors[
                    _remoteConfig
                        .getString(
                        'importanceColor')
                        .isNotEmpty
                        ? _remoteConfig.getString(
                        'importanceColor')
                        : _defaultImportanceColor])
                        : ColorApp.lightTheme.colorGrey,
                  ),
                  child: Checkbox(
                    checkColor:
                    ColorApp.lightTheme.colorWhite,
                    activeColor:
                    ColorApp.lightTheme.colorGreen,
                    value: isChanged,
                    onChanged: (_) async {
                      BlocProvider.of<TodosCubit>(context)
                          .changeCompletion(item, revision);
                      //return false;
                    },
                  ),
                ),
                horizontalTitleGap: 8,
                trailing: IconButton(
                  onPressed: () {
                    _simpleDialogithTodoDetails(
                        context, item);
                  },
                  icon: SvgPicture.asset(
                    S.iconInfoOutline,
                  ),
                ),
                title: item.done == true
                    ? Text(
                  item.text,
                  style: Theme.of(context)
                      .textTheme
                      .headline1,
                )
                    : Row(
                  children: [
                    _priority(item.importance),
                    Text(
                      item.text,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1,
                    ),
                  ],
                ),
                subtitle: item.deadline != null
                    ? Text(
                    _fromTsoFormatDate(item.deadline!),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1)
                    : null),
          ),
        );
      },
    );
  }
}
