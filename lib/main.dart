import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'theme.dart' as theme;
import 'navigation.dart' as navigation;
import 'routes.dart' as routes;

void main() {
  runApp(const DilutionCalculator());
}

class DilutionCalculator extends StatelessWidget {
  const DilutionCalculator({ super.key });

  @override
  Widget build(BuildContext context) {
    // Sets orientation of app
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    // Sets up routes for navigation of pages
    routes.setRoutes();

    if(kDebugMode) print('Starting!');
    return CupertinoApp(
      title: 'Dilution Calculator',
      theme: theme.themeData,
      navigatorKey: navigation.navigatorKey,
      routes: routes.routes,
      debugShowCheckedModeBanner: false,
      home: _getHome(),
    );
  }

  Widget _getHome() {
    navigation.init(routes.defaultEnumRoute);
    return routes.routes[routes.defaultRoute]!(null);
  }
}
