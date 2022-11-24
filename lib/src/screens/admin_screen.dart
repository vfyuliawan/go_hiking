part of 'screens.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productDescController = TextEditingController();
  void reset() {
    //hapus name controller
    productNameController.clear();
    //hapus price controller
    productPriceController.clear();
    //hapus state image
    BlocProvider.of<ProductPictureCubit>(context).resetImage();
  }

  @override
  Widget build(BuildContext context) {
    //WILL POPSCOPE ADALAH UNUTUK BACK EVENT
    return WillPopScope(
      onWillPop: () {
        reset();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          // leading: Icon(Icons.menu),

          backgroundColor: kPrimaryColor,
        ),
        body: BlocConsumer<AdminBloc, AdminState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is AdminIsSuccess) {
              reset();
              Commons().showSnackbarInfo(context, state.message);
            } else if (state is AdminIsFailed) {
              Commons().showSnackbar(context, state.message);
            }
          },
          builder: (context, state) {
            return VStack([
              // CustomAppbar(Icons.arrow_back_ios, Icons.search),
              _buildProductForm(),
              16.heightBox,
              ButtonWidget(
                onPressed: () {
                  BlocProvider.of<AdminBloc>(context).add(
                    AddProduct(
                      name: productNameController.text,
                      price: double.parse(productPriceController.text),
                      desc: productDescController.text,
                    ),
                  );
                },
                isLoading: (state is AdminIsLoading) ? true : false,
                text: "Unggah Produk",
              )
            ]);
          },
        ).p16(),
      ),
    );
  }

  Widget _buildProductForm() {
    return VStack([
      TextFieldWidget(
        controller: productNameController,
        title: 'Name Produk',
      ),
      8.heightBox,
      TextFieldWidget(
        controller: productPriceController,
        title: 'Harga Produk',
      ),
      8.heightBox,
      TextFieldWidget(
        controller: productDescController,
        title: 'Description',
      ),
      16.heightBox,
      BlocBuilder<ProductPictureCubit, ProductPictureState>(
        builder: (context, state) {
          if (state is ProductPictureIsLoaded) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ZStack(
                [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.file(
                      state.file,
                      fit: BoxFit.contain,
                    ),
                  ),
                  IconButton(
                          onPressed: () {
                            BlocProvider.of<ProductPictureCubit>(context)
                                .resetImage();
                          },
                          icon: Icon(Icons.delete))
                      .box
                      .color(Colors.greenAccent.withOpacity(0.8))
                      .roundedFull
                      .make()
                ],
                alignment: Alignment.center,
              ),
            );
          } else {}
          return IconButton(
              onPressed: () {
                BlocProvider.of<ProductPictureCubit>(context).getImage();
              },
              icon: const Icon(Icons.image));
        },
      ),
    ]);
  }
}
