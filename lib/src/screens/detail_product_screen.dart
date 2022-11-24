// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

part of 'screens.dart';

class DetailProductScreen extends StatelessWidget {
  const DetailProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // leading: Icon(Icons.menu),
        actions: [
          Container(
            width: 50,
            child: Icon(Icons.logout_outlined),
          ),
        ],
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
        child: BlocConsumer<DetailProductBloc, DetailProductState>(
          listener: (context, state) {
            if (state is DetailProductIsFailed) {
              Commons().showSnackbar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is DetailProductIsLoading) {
              return CircularProgressIndicator();
            } else {
              if (state is DetailProductIsSuccess) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    width: double.maxFinite,
                    height: 800,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          child: Container(
                            width: double.maxFinite,
                            height: 300,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        NetworkImage("${state.data.picture}"),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        Positioned(
                            left: 20,
                            top: 30,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.menu,
                                      color: Colors.white,
                                    ))
                              ],
                            )),
                        Positioned(
                          top: 275,
                          child: Container(
                            padding:
                                EdgeInsets.only(right: 20, left: 20, top: 30),
                            width: MediaQuery.of(context).size.width,
                            height: 600,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //TODO : TITLE AND PRICEE
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    "${state.data.name}"
                                        .text
                                        .bold
                                        .size(18)
                                        .make(),
                                    8.heightBox,
                                    "RP. ${state.data.price}".text.make(),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: AppColors.mainColor,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    //TODO: LOCATION
                                    AppText(text: "Malang, Jawa Tengah")
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Wrap(
                                      children: List.generate(5, (index) {
                                        return Icon(
                                          Icons.star,
                                          color: index < 4
                                              ? AppColors.starColor
                                              : AppColors.textColor2,
                                        );
                                      }),
                                    ),
                                    SizedBox(width: 3),
                                    AppText(
                                      text: "(4.0)",
                                      color: AppColors.textColor2,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                AppLargeText(
                                  text: "People",
                                  color: Colors.black45,
                                  size: 20,
                                ),
                                AppText(
                                  text: "Number of people in your group",
                                  color: AppColors.mainColor,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Wrap(
                                  children: List.generate(5, (index) {
                                    return InkWell(
                                      onTap: () {},
                                      child: Container(
                                        margin: EdgeInsets.only(right: 5),
                                        child: AppButton(
                                          color: -1 == index
                                              ? Colors.white
                                              : Colors.black,
                                          bgcolor: -1 == index
                                              ? Colors.black87
                                              : AppColors.buttonBackground,
                                          borderColor:
                                              AppColors.buttonBackground,
                                          size: 50,
                                          text: (index + 1).toString(),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                AppLargeText(
                                  text: "Description",
                                  size: 25,
                                  color: Colors.black.withOpacity(0.8),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                AppText(
                                    color: Colors.black.withOpacity(0.5),
                                    text: "${state.data.desc}")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
            return 0.heightBox;
          },
        ),
      ),
      bottomNavigationBar: BlocConsumer<DetailProductBloc, DetailProductState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is DetailProductIsFailed) {
            Commons().showSnackbar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is DetailProductIsSuccess) {
            return Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  AppButton(
                          icon: Icons.shopping_cart,
                          isIcon: true,
                          color: kPrimaryColor,
                          bgcolor: Colors.white,
                          borderColor: kPrimaryColor,
                          size: 60)
                      .onTap(() {
                    Commons().showSnackbarInfo(
                        context, "Berhasil Ditambah ke keranjang");
                    BlocProvider.of<AddToChartCubit>(context)
                        .addToChart(state.data);
                  }),
                  SizedBox(
                    width: 20,
                  ),
                  ResponsiveButton(
                    width: 250,
                    isResponsive: true,
                  ),
                  // ButtonWidget(
                  //   color: Colors.green,
                  //   text: "Add To Chart",
                  //   onPressed: () {
                  //     BlocProvider.of<AddToChartCubit>(context)
                  //         .addToChart(state.data);
                  //   },
                  // ),
                ],
              ),
            );
          }
          return 0.heightBox;
        },
      ),
    );
  }
}
