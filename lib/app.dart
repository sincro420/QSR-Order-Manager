import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/app_provider.dart';
import 'screens/home_screen.dart';
import 'screens/settlement_screen.dart';
import 'screens/history_screen.dart';
import 'screens/settings_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, _) {
        return MaterialApp(
          title: 'T&B Food Ordering',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: Brightness.dark,
          ),
          themeMode:
              appProvider.state.darkMode ? ThemeMode.dark : ThemeMode.light,
          home: const MainScreen(),
        );
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SettlementScreen(),
    const HistoryScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Add this line
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Settlement',
=======
      body: IndexedStack(index: _selectedIndex, children: _screens),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToHome,
        backgroundColor:
            _selectedIndex == 0
                ? Colors.purple
                : Colors.purple.withOpacity(0.8),
        elevation: 2.0,
        child: Icon(
          Icons.memory_sharp,
          color: _selectedIndex == 0 ? Colors.white : Colors.white70,
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.history,
                  color: _selectedIndex == 1 ? Colors.purple : Colors.grey,
                ),
                onPressed: () => _onItemTapped(1),
                tooltip: 'History',
              ),
              IconButton(
                icon: Icon(
                  Icons.calculate_rounded,
                  color: _selectedIndex == 2 ? Colors.purple : Colors.grey,
                ),
                onPressed: () => _onItemTapped(2),
                tooltip: 'Settlement',
              ),
              const SizedBox(width: 48), // Space for the notch/FAB
              IconButton(
                icon: Icon(
                  Icons.receipt_long,
                  color: _selectedIndex == 3 ? Colors.purple : Colors.grey,
                ),
                onPressed: () => _onItemTapped(3),
                tooltip: 'Accounting',
              ),
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: _selectedIndex == 4 ? Colors.purple : Colors.grey,
                ),
                onPressed: () => _onItemTapped(4),
                tooltip: 'Settings',
              ),
            ],
>>>>>>> 9a7e88c (Realtime DB and Accounting screen added with better darkmode)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
