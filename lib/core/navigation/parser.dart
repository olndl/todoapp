import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:todoapp/core/navigation/paths.dart';
import '../../domain/model/todo.dart';
import '../../main.dart';
import 'model.dart';
//
// class BooksShelfRouteInformationParser
//     extends RouteInformationParser<NavigationStateDTO> {
//   @override
//   Future<NavigationStateDTO> parseRouteInformation(
//       RouteInformation routeInformation) {
//     final uri = Uri.parse(routeInformation.location ?? '');
//     if (uri.pathSegments.isEmpty) {
//       return Future.value(NavigationStateDTO.todos());
//     }
//     switch (uri.pathSegments[0]) {
//       case Paths.todoCreate:
//         return Future.value(NavigationStateDTO.todoIdCreate());
//       case Paths.todoEdit:
//         return Future.value(
//           NavigationStateDTO.todoIdEdit(uri.pathSegments[1] as Todo),
//         );
//       default:
//         return Future.value(NavigationStateDTO.todos());
//     }
//   }
//
//   @override
//   RouteInformation? restoreRouteInformation(NavigationStateDTO configuration) {
//     if (configuration.todos) {
//       return const RouteInformation(location: Paths.todos);
//     }
//     if (configuration.todoIdCreate == null) {
//       return const RouteInformation(location: '/${Paths.todos}');
//     }
//     return RouteInformation(
//         location: '/${Paths.todoEdit}/${configuration.todoIdEdit}');
//   }
// }


class RouteInformationParserImpl implements RouteInformationParser<TypedPath> {
  @override
  Future<TypedPath> parseRouteInformation(RouteInformation routeInformation) =>
      Future.value(path2TypedPath(routeInformation.location));

  @override
  RouteInformation restoreRouteInformation(TypedPath configuration) =>
      RouteInformation(location: typedPath2Path(configuration));

  static String typedPath2Path(TypedPath typedPath) => typedPath
      .map((s) => Uri.encodeComponent(jsonEncode(s.toJson())))
      .join('/');

  static TypedPath path2TypedPath(String? path) {
    if (path == null || path.isEmpty) return [];
    return [
      for (final s in path.split('/'))
        if (s.isNotEmpty) TypedSegment.fromJson(jsonDecode(Uri.decodeFull(s)))
    ];
  }
}
