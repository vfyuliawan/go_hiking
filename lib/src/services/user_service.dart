part of 'services.dart';

class UserService {
  //Inisialisasi Collection
  final userCollection =
      FirebaseFirestore.instance.collection(userCollectionName);

  //TODO : Regisger with email
  //Either untuk mendefinisikan kiri dan kanan (kiri sebagai String dan Kanan Sebagai UserModel)
  Future<Either<String, UserModel>> registerWithEmail(
      {String? email, String? password, String? name}) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      //Kumpulkan Data
      final userData = UserModel(
          admin: false,
          email: email,
          photoProfile: '',
          uid: userCredential.user!.uid,
          usernama: name);

      //Upload Data Ke Firebase
      //doc untuk menulis pada firebase
      //set untuk set data
      userCollection.doc(userCredential.user!.uid).set(userData.toMap());
      return right(userData);
    } on FirebaseAuthException catch (e) {
      return left(e.toString().split("]").last);
    }
  }

  //TODO : Login with email
  Future<Either<String, UserModel>> loginWithEmail(
      {String? email, String? password}) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);

      return loadUserData(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      return left(e.toString().split("]").last);
    }
  }

  //TODO : Get User Data
  Future<Either<String, UserModel>> loadUserData(String? uid) async {
    try {
      final userData = await userCollection.doc(uid).get();
      if (userData.data()!.isNotEmpty) {
        return right(UserModel.fromMap(userData.data()!));
      } else {
        return left("Cannot Find User");
      }
    } on FirebaseAuthException catch (e) {
      return left(e.toString().split("]").last);
    }
  }

  Future<void> logOutUser() async {
    await FirebaseAuth.instance.signOut();
  }
}
