import 'package:flutter/material.dart';
import '../../Screens/HomeScreen/home_screen.dart';
import '../../Screens/LibraryScreen/library_screen.dart';
import '../../Screens/BasketScreen/basket_screen.dart';
import '../../data/book_data.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late List<Widget> pages;
  var mCurrentIndex = 0;

  @override
  void initState() {
    super.initState();
    pages = [
      const HomeScreen(),
      LibraryScreen(books: BookData.books),
      const BasketScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[mCurrentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: mCurrentIndex,
        onTap: (value) {
          setState(() {
            mCurrentIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.primary,
        ),
        unselectedLabelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            label: "Library",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: "Basket",
          ),
        ],
      ),
    );
  }
}
