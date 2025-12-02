import 'package:flutter/material.dart';
import '../../Models/book.dart';
import 'library_cell.dart';
import '../Details/details_screen.dart';

class LibraryScreen extends StatelessWidget {
  final List<Book> books;
  const LibraryScreen({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text('Library'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.58,
        ),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DetailsScreen(book: book)),
            ),
            child: LibraryCell(book: book),
          );
        },
      ),
    );
  }
}
