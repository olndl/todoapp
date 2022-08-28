import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:todoapp/core/errors/logger.dart';

import 'model.dart';

class RouteInformationParserImpl implements RouteInformationParser<TypedPath> {
  @override
  Future<TypedPath> parseRouteInformation(RouteInformation routeInformation) =>
      Future.value(path2TypedPath(routeInformation.location));

  @override
  RouteInformation restoreRouteInformation(TypedPath configuration) =>
      RouteInformation(location: typedPath2Path(configuration));

  static String typedPath2Path(TypedPath typedPath) {
    FirebaseAnalytics.instance.logEvent(
      name: 'route_${typedPath.map((s) => s.toJson()['path']).join('_')}',
    );
    logger.info(
      typedPath
          .map((s) => Uri.encodeComponent(jsonEncode(s.toJson())))
          .join('/'),
    );
    return typedPath
        .map((s) => Uri.encodeComponent(jsonEncode(s.toJson())))
        .join('/');
  }

  static TypedPath path2TypedPath(String? path) {
    logger.info(path);
    if (path == null || path.isEmpty) return [];
    logger.info([
      for (final s in path.split('/'))
        if (s.isNotEmpty) TypedSegment.fromJson(jsonDecode(Uri.decodeFull(s)))
    ]);
    return [
      for (final s in path.split('/'))
        if (s.isNotEmpty) TypedSegment.fromJson(jsonDecode(Uri.decodeFull(s)))
    ];
  }
}
