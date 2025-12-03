import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/book.dart';
import '../../data/book_service.dart';
import '../../data/user_service.dart';
import '../../data/firestore_basket_service.dart';
import '../../providers/storage_mode_provider.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final storageMode = Provider.of<StorageModeProvider>(context).mode;
    return Scaffold(
      appBar: AppBar(title: const Text('Basket')),
      body: FutureBuilder(
        future: UserService().getCurrentUser(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final user = snapshot.data;
          if (user == null || user.email == null) {
            return const Center(child: Text('No user found'));
          }
          // Use StatefulBuilder to allow setState for delete refresh
          return StatefulBuilder(
            builder: (context, setState) {
              if (storageMode == StorageMode.cloud) {
                return StreamBuilder<List<Map<String, dynamic>>>(
                  stream: FirestoreBasketService().getBasketStream(user.email!),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                    final books = snapshot.data!;
                    if (books.isEmpty) return const Center(child: Text('Basket is empty'));
                    return ListView.builder(
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        final b = books[index];
                        return Card(
                          child: ListTile(
                            leading: (b['image'] as String).isNotEmpty
                                ? Image.asset(b['image'], width: 48, height: 48, fit: BoxFit.cover)
                                : const Icon(Icons.book),
                            title: Text(b['name']),
                            subtitle: Text('Price: ${b['price']}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                await FirestoreBasketService().removeBookFromBasket(b['id']);
                                setState(() {}); // Refresh UI
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              } else {
                return FutureBuilder<List<Book>>(
                  future: BookService().fetchBasketBooksForUser(user.email!),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                    final books = snapshot.data!;
                    if (books.isEmpty) return const Center(child: Text('Basket is empty'));
                    return ListView.builder(
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        final book = books[index];
                        return Card(
                          child: ListTile(
                            leading: Image.asset(
                              book.image,
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                            ),
                            title: Text(book.name),
                            subtitle: Text('Price: ${book.price}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                await BookService().deleteBookByName(book.name);
                                setState(() {}); // Refresh UI
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
