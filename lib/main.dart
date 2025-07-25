import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'providers/app_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Create and initialize the app provider
  final appProvider = AppProvider();
  await appProvider.loadState();

  runApp(ChangeNotifierProvider.value(value: appProvider, child: const App()));
}
