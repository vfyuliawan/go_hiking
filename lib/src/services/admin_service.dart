part of 'services.dart';

class AdminService {
  //initial nama koleksi
  final productCollection =
      FirebaseFirestore.instance.collection(productCollectionName);

  //add new product
  Future<Either<String, String>> addNewProduct(ProductModel data,
      {File? file}) async {
    try {
      //doc adalah membuat dokumen
      //id dibuat menggunakan tanggal dan detik
      productCollection.doc(data.id).set(data.toMap());
      //mengecek jika terdapat file
      if (file != null) {
        //untuk upload file pada firebase Storage memerlukan dua function (refereence dan storage snapshot untuk mengambil linknya )
        //set reference
        Reference ref = FirebaseStorage.instance.ref().child(data.id!);
        //untuk mengambil file
        TaskSnapshot snapshot = await ref.putFile(file);
        //ambil Url path
        String downloadUrl = await snapshot.ref.getDownloadURL();
        if (downloadUrl.isNotEmpty) {
          updateProduct(
            data.id!,
            data.copyWith(
              picture: downloadUrl,
            ),
          );
        }
      }
      return right("Berhasil Ditambahkan");
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, String>> updateProduct(
      String id, ProductModel data) async {
    try {
      productCollection.doc(data.id).update(data.toMap());
      return right("Berhasil Ditambahkan");
    } catch (e) {
      return left(e.toString());
    }
  }
}
