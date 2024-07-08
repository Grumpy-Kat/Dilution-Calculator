import 'package:flutter/cupertino.dart';
import 'routes.dart' as routes;

List<routes.ScreenRoutes> _history = [];

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void init(routes.ScreenRoutes nextScreenEnum) {
  _history.clear();
  _history.add(nextScreenEnum);
}

void pushReplacement(BuildContext context, Offset offset, routes.ScreenRoutes nextScreenEnum, Widget nextScreen) {
  if(_history.isNotEmpty) {
    _history[_history.length - 1] = nextScreenEnum;
  } else {
    _history.add(nextScreenEnum);
  }

  Navigator.of(context).pushReplacement(
    _createRouteTransition(nextScreen),
  );
}

void push(BuildContext context, Offset offset, routes.ScreenRoutes nextScreenEnum, Widget nextScreen) {
  _history.add(nextScreenEnum);

  Navigator.of(context).push(
    _createRouteTransition(nextScreen),
  );
}

void pop(BuildContext context, bool reloadPrev) {
  if(_history.length <= 1) {
    push(context, const Offset(-1, 0), routes.defaultEnumRoute, routes.routes[routes.defaultRoute]!(context));
    return;
  }

  _history.removeLast();
  if(_history.length > 1 && _history[_history.length - 1] == _history[_history.length - 2]) {
    _history.removeLast();
  }

  routes.ScreenRoutes prevScreen = _history[_history.length - 1];
  Navigator.of(context).pushReplacement(
    _createRouteTransition(routes.enumRoutes[prevScreen]!(context)),
  );
}

Route _createRouteTransition(Widget nextScreen) {
  return CupertinoPageRoute(
    builder: (context) => nextScreen,
  );
}