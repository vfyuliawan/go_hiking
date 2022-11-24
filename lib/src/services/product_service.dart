part of 'services.dart';

class ProductService {
  final productCollection =
      FirebaseFirestore.instance.collection(productCollectionName);
  final usersCollection =
      FirebaseFirestore.instance.collection(userCollectionName);

  Future<Either<String, List<ProductModel>>> fetchListProducts() async {
    try {
      final querySnapshot = await productCollection.get();
      //ambil data
      final data = querySnapshot.docs
          .map((e) => ProductModel.fromMap(e.data()))
          .toList();
      return right(data);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, ProductModel>> fetchDetailProduct(String docId) async {
    try {
      final documentSnapshot = await productCollection.doc(docId).get();

      final data = ProductModel.fromMap(documentSnapshot.data()!);
      return right(data);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, String>> addToCart(ProductModel model) async {
    try {
      String uid = await Commons().getUid();
      usersCollection
          .doc(uid)
          .collection(cartCollectionName)
          .doc(model.id)
          .set(model.toMap());

      return right('Berhasil Memasukkan Ke Keranjang');
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, List<ProductModel>>> fetchListCart() async {
    try {
      String userId = await Commons().getUid();
      final querySnapshot = await usersCollection
          .doc(userId)
          .collection(cartCollectionName)
          .get();
      final data = querySnapshot.docs
          .map((e) => ProductModel.fromMap(e.data()))
          .toList();
      return right(data);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, int>> getCartCount() async {
    try {
      String userId = await Commons().getUid();
      final querySnapshot = await usersCollection
          .doc(userId)
          .collection(cartCollectionName)
          .get();
      return right(querySnapshot.docs.length);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, String>> removeCartCount(String productId) async {
    try {
      String userId = await Commons().getUid();
      await usersCollection
          .doc(userId)
          .collection(cartCollectionName)
          .doc(productId)
          .delete();
      return right("Berhasil Dihapus");
    } catch (e) {
      return left(
        e.toString(),
      );
    }
  }
}


//pada firebase terdapat dua
//Query Snapshot => banyak data
//Document Snapshot => satu data

