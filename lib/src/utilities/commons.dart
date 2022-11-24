//commons adalah function yang umum yang sering di pakai berkali kali
part of 'utilities.dart';

class Commons {
  final prefs = SharedPreferences.getInstance();
  final picker = ImagePicker();

  void setUid(String uid) async {
    final storage = await prefs;
    await storage.setString(myUid, uid);
  }

  Future<String> getUid() async {
    final storage = await prefs;
    return storage.getString(myUid)!;
  }

  void showSnackbar(BuildContext context, String msg) {
    showTopSnackBar(context, CustomSnackBar.error(message: msg));
  }

  void showSnackbarInfo(BuildContext context, String msg) {
    showTopSnackBar(context, CustomSnackBar.info(message: msg));
  }

  Future<bool> removeUid() async {
    final storage = await prefs;
    return storage.remove(myUid);
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  //Fungsi Upload Image From Galery
  Future<File> getImage() async {
    //tampung file yang di ambil
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 10,
    );
    return File(pickedFile!.path);
  }
}
