import 'Screens/calculator_screen.dart';
import 'types.dart';

Map<String, OnScreenAction> routes = {};
Map<ScreenRoutes, OnScreenAction> enumRoutes = {};

String defaultRoute = '/calculatorScreen';
ScreenRoutes defaultEnumRoute = ScreenRoutes.calculatorScreen;

enum ScreenRoutes {
  calculatorScreen,
}

void setRoutes() {
  routes = {
    '/calculatorScreen': (context, [shouldReset = false]) => const CalculatorScreen(),
  };
  enumRoutes = {
    ScreenRoutes.calculatorScreen: routes['/calculatorScreen']!,
  };
}