import 'package:flutter/material.dart';
import '../../Models/book.dart';
import '../../data/book_service.dart';
import '../../data/user_service.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  Future<List<Book>> _basketFuture() async {
    final user = await UserService().getCurrentUser();
    final email = user?.email;
    if (email != null && email.isNotEmpty) {
      return BookService().fetchBasketBooksForUser(email);
    }
    return BookService().fetchBasketBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Basket')),
      body: FutureBuilder<List<Book>>(
        future: _basketFuture(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erreur : ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          final books = snapshot.data ?? const <Book>[];
          if (books.isEmpty) {
            return const Center(child: Text('Basket is empty'));
          }
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final b = books[index];
              return ListTile(
                leading: (b.image.isNotEmpty)
                    ? Image.asset(b.image, width: 48, height: 48, fit: BoxFit.cover)
                    : const Icon(Icons.book),
                title: Text(b.name),
                subtitle: Text('Price: ${b.price}'),
              );
            },
          );
        },
      ),
    );
  }
}
