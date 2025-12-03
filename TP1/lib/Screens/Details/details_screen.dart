import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Models/book.dart';
import '../../data/book_service.dart';
import '../BasketScreen/basket_screen.dart';
import '../../data/firestore_basket_service.dart';
import '../../data/user_service.dart';
import '../../providers/storage_mode_provider.dart';

class DetailsScreen extends StatefulWidget {
  static const String routeName = "/Details";
  final Book? book;
  const DetailsScreen({super.key, this.book});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int quantity = 10;

  void _purchase() {
    if (quantity > 0) {
      setState(() => quantity--);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Purchased 1 — remaining: $quantity'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Out of stock'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  Future<void> _addToCart(Book book) async {
    final user = await UserService().getCurrentUser();
    if (user?.email == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No user found')),
      );
      return;
    }
    final storageMode = Provider.of<StorageModeProvider>(context, listen: false).mode;
    try {
      if (storageMode == StorageMode.cloud) {
        await FirestoreBasketService().addBookToBasket(book, user!.email!);
      } else {
        await BookService().insertBookForUser(book, user!.email!);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${book.name} added to cart'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          action: SnackBarAction(
            label: 'VIEW CART',
            textColor: Theme.of(context).colorScheme.onPrimary,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const BasketScreen()),
              );
            },
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add: $e'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Book book = widget.book ?? ModalRoute.of(context)!.settings.arguments as Book;
    return Scaffold(
      appBar: AppBar(title: Text(book.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Hero(
            tag: 'book-${book.name}',
            child: Center(
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    book.image,
                    height: 350,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          Text(
            book.name,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 24),

          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.attach_money,
                      size: 32,
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                  Text(
                    "${book.price} TND",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          Text(
            'About this book',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            "Lorem ipsum dolor sit amet consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor. Cras elementum ultrices diam. Maecenas ligula massa, varius a, semper congue.",
            textAlign: TextAlign.justify,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(height: 1.5),
          ),

          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _addToCart(book),
                  icon: Icon(Icons.add_shopping_cart,
                      color: Theme.of(context).colorScheme.primary),
                  label: const Text("Add to Cart"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _purchase,
                  icon: const Icon(Icons.shopping_bag),
                  label: const Text("Buy Now"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: quantity > 5
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.10)
                    : Theme.of(context).colorScheme.secondary.withOpacity(0.10),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    quantity > 5 ? Icons.check_circle : Icons.warning,
                    color: quantity > 5
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Stock: $quantity units',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: quantity > 5
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
