import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'providers/app_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

<<<<<<< HEAD
=======
  // --- SUPABASE INITIALIZATION ---
  await Supabase.initialize(
    url: 'https://ctwwtumgqdxwgjfmuieg.supabase.co',
    anonKey: '',
  );

>>>>>>> 9a7e88c (Realtime DB and Accounting screen added with better darkmode)
  // Create and initialize the app provider
  final appProvider = AppProvider();
  await appProvider.loadState();

  runApp(ChangeNotifierProvider.value(value: appProvider, child: const App()));
}
