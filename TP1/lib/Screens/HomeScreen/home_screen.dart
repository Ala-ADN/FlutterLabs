import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/book.dart';
import 'home_cell.dart';
import '../../Screens/Details/details_screen.dart';
import '../../Screens/LibraryScreen/library_screen.dart';
import '../../providers/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final books = <Book>[
      Book("Madame Bovary", 35, 'assets/madame_bovary.jpg'),
      Book("L'Étranger", 28, 'assets/letranger.jpg'),
      Book("Le Petit Prince", 25, 'assets/petit_prince.jpg'),
      Book("Madame Bovary", 35, 'assets/madame_bovary.jpg'),
      Book("L'Étranger", 28, 'assets/letranger.jpg'),
      Book("Le Petit Prince", 25, 'assets/petit_prince.jpg'),
      Book("Madame Bovary", 35, 'assets/madame_bovary.jpg'),
      Book("L'Étranger", 28, 'assets/letranger.jpg'),
      Book("Le Petit Prince", 25, 'assets/petit_prince.jpg'),
      Book("Madame Bovary", 35, 'assets/madame_bovary.jpg'),
      Book("L'Étranger", 28, 'assets/letranger.jpg'),
      Book("Le Petit Prince", 25, 'assets/petit_prince.jpg'),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          "Store INSAT",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary),
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
          IconButton(
            icon: const Icon(Icons.grid_view),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LibraryScreen(books: books)),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final b = books[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DetailsScreen(book: b)),
              );
            },
            child: HomeCell(b),
          );
        },
      ),
    );
  }
}
