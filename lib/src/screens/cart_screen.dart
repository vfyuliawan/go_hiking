// ignore_for_file: prefer_const_constructors

part of 'screens.dart';

class CartProductScreen extends StatelessWidget {
  const CartProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: BlocConsumer<GetCartCountCubit, GetCartCountState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is GetCartCountIsFailed) {
              return Commons().showSnackbar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is GetCartCountIsLoading) {
              return CircularProgressIndicator().centered();
            } else if (state is GetCartCountIsSuccess) {
              return VStack(
                crossAlignment: CrossAxisAlignment.center,
                [
                  "Your Cart".text.size(18).make(),
                  "${state.cartCount} Item".text.size(14).make(),
                ],
              );
            }
            return 0.heightBox;
          },
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        child: BlocConsumer<CartProductBloc, CartProductState>(
          listener: (context, state) {
            if (state is CartProductIsFailed) {
              Commons().showSnackbar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is CartProductIsLoading) {
              return const CircularProgressIndicator().centered();
            } else if (state is CartProductIsSuccess) {
              final data = state.model;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: "Langit Sore Store"
                        .text
                        .color(Colors.black)
                        .bold
                        .size(20)
                        .make()
                        .p(10),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final product = data[index];
                      return Slidable(
                          endActionPane: ActionPane(
                            motion: StretchMotion(),
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              SlidableAction(
                                onPressed: null,
                                icon: Icons.share,
                                backgroundColor: Colors.blue.shade400,
                                label: "Share",
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  Commons().showSnackbarInfo(
                                    context,
                                    "berhasil dihapus",
                                  );
                                  BlocProvider.of<RemoveCartCubit>(context)
                                      .removeCart(product.id!);
                                  BlocProvider.of<CartProductBloc>(context)
                                      .add(FetchListCart());
                                },
                                icon: Icons.delete,
                                backgroundColor: Colors.red.shade400,
                                label: "Delete",
                              )
                            ],
                          ),
                          child: Card(
                            margin: EdgeInsets.only(right: 3, top: 5),
                            child: Container(
                              padding: EdgeInsets.all(15),
                              child: _buidProductListTile(product),
                            ),
                          ));
                    },
                  ),
                ],
              );
            }
            return Container(
              child: "test".text.makeCentered(),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, -15), blurRadius: 20, color: Colors.black26),
          ],
        ),
      ),
    );
  }

  Widget _buidProductListTile(ProductModel product) {
    return ListTile(
        trailing: Icon(Icons.arrow_back_ios_new_outlined,
            color: kPrimaryColor, size: 12),
        title: "${product.name}".text.make(),
        subtitle: "RP. ${product.price}".text.color(kPrimaryColor).make(),
        leading: Container(
          child: Image(image: NetworkImage("${product.picture}")),
        ));
  }
}
