import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../errors/logger.dart';
import 'delegate.dart';
import 'model.dart';
//
// class DebugRouteInformationProvider extends PlatformRouteInformationProvider {
//   DebugRouteInformationProvider()
//       : super(
//       initialRouteInformation: RouteInformation(
//           location: PlatformDispatcher.instance.defaultRouteName));
//
//   @override
//   Future<bool> didPushRoute(String route) {
//     logger.info('Platform reports $route');
//     return super.didPushRoute(route);
//   }
//
//   @override
//   Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
//     logger.info('Platform reports routeinformation: $routeInformation');
//     return super.didPushRouteInformation(routeInformation);
//   }
// }

final routerDelegateProvider =
Provider<TodoRouterDelegate>((ref) => TodoRouterDelegate(ref, [HomeSegment()]));

final navigationStackProvider =
StateProvider<TypedPath>((_) => [HomeSegment()]);