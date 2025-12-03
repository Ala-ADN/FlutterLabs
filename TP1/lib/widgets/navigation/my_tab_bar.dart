import 'package:flutter/material.dart';
import '../../Screens/HomeScreen/home_screen.dart';
import '../../Screens/LibraryScreen/library_screen.dart';
import '../../Screens/BasketScreen/basket_screen.dart';
import '../../data/book_data.dart';

class MyTabBar extends StatefulWidget {
  const MyTabBar({super.key});

  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> with TickerProviderStateMixin {
  late List<Widget> pages;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    pages = [
      const HomeScreen(),
      LibraryScreen(books: BookData.books),
      const BasketScreen(),
    ];
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).colorScheme.surface,
          child: TabBar(
            controller: tabController,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            indicatorColor: Theme.of(context).colorScheme.primary,
            indicatorWeight: 3,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
            ),
            tabs: const [
              Tab(icon: Icon(Icons.home_outlined), text: "Home"),
              Tab(icon: Icon(Icons.bookmark_outline), text: "Library"),
              Tab(icon: Icon(Icons.shopping_bag), text: "Basket"),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: pages,
          ),
        ),
      ],
    );
  }
}
