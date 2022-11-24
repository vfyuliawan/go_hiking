part of 'services.dart';

class DetailProductService {
  final productCollection =
      FirebaseFirestore.instance.collection(productCollectionName);

  Future<Either<String, ProductModel>> fethDetailProduct(String docId) async {
    try {
      final documentSnapshot = await productCollection.doc(docId).get();
      final data = ProductModel.fromMap(documentSnapshot.data()!);
      return right(data);
    } catch (e) {
      return left(e.toString());
    }
  }
}
