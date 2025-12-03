import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/book.dart';

class FirestoreBasketService {
  final CollectionReference basketCollection =
      FirebaseFirestore.instance.collection('basket');

  Future<void> addBookToBasket(Book book, String userEmail) async {
    await basketCollection.add({
      'name': book.name,
      'price': book.price,
      'image': book.image,
      'userEmail': userEmail,
    });
  }

  Future<void> removeBookFromBasket(String docId) async {
    await basketCollection.doc(docId).delete();
  }

  Stream<List<Map<String, dynamic>>> getBasketStream(String userEmail) {
    return basketCollection
        .where('userEmail', isEqualTo: userEmail)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>}).toList());
  }
}
