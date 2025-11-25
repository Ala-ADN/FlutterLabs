import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bottom_nav_bar.dart';
import 'my_tab_bar.dart';
import 'custom_drawer.dart';
import '../../providers/theme_provider.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  bool useBottomNavigation = true; // true for BottomNav, false for TabBar

  void _toggleNavigationType() {
    setState(() {
      useBottomNavigation = !useBottomNavigation;
    });
    Navigator.pop(context); // Close drawer
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          "Store INSAT",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(
                fontWeight: FontWeight.bold, 
                color: Theme.of(context).colorScheme.onPrimary
              ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: themeProvider.isDarkMode
                ? 'Switch to Light Mode'
                : 'Switch to Dark Mode',
          ),
        ],
      ),
      drawer: CustomDrawer(
        useBottomNavigation ? "Tabs Navigation" : "Use bottom Navigation",
        Icon(useBottomNavigation ? Icons.tab : Icons.navigation),
        _toggleNavigationType,
      ),
      body: useBottomNavigation ? const BottomNavBar() : const MyTabBar(),
    );
  }
}
