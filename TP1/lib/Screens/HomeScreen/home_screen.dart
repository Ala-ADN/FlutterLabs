import 'package:flutter/material.dart';

import '../../Models/book.dart';
import 'home_cell.dart';
import '../../Screens/Details/details_screen.dart';
import '../../Screens/SignUpScreen/signup_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SignUpScreen()),
          );
        },
        icon: const Icon(Icons.person_add),
        label: const Text('Sign Up'),
        tooltip: 'Go to Sign Up',
      ),
    );
  }
}
