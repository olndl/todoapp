import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'delegate.dart';
import 'model.dart';

final routerDelegateProvider = Provider<TodoRouterDelegate>(
  (ref) => TodoRouterDelegate(ref, [HomeSegment()]),
);

final navigationStackProvider =
    StateProvider<TypedPath>((_) => [HomeSegment()]);
