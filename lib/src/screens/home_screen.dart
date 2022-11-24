// ignore_for_file: prefer_const_constructors

//Register -> Home -> Logout -> Login -> Home -> Admin

part of 'screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // leading: Icon(Icons.menu),
        actions: [
          BlocConsumer<GetCartCountCubit, GetCartCountState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is GetCartCountIsLoading) {
                return CircularProgressIndicator().centered();
              } else if (state is GetCartCountIsSuccess) {
                return Container(
                  alignment: Alignment.center,
                  width: 50,
                  child: Stack(
                    children: [
                      Positioned(
                        child: Container(
                          child: Icon(Icons.shopping_cart),
                        ).onTap(() {
                          context.go(routeName.cartPath);
                        }),
                      ),
                      Positioned(
                        bottom: 12,
                        child: Container(
                          width: 15,
                          decoration: BoxDecoration(
                            color: Colors.red.shade400,
                          ),
                          child: "${state.cartCount}".text.white.size(5).make(),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return 0.heightBox;
            },
          )
        ],
        backgroundColor: kPrimaryColor,
      ),
      drawer: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserIsSuccess) {
            return NavigationDrawer(data: state.data);
          }
          return Container();
        },
      ),
      // backgroundColor: kSecondaryColor,
      body: SafeArea(
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserIsFailed) {
              Commons().showSnackbar(context, state.message);
            } else if (state is UserIsLogOut) {
              context.go(routeName.login);
            }
          },
          builder: (context, state) {
            if (state is UserIsLoading) {
              return const CircularProgressIndicator().centered();
            } else if (state is UserIsSuccess) {
              return VStack(
                [
                  // 16.heightBox,
                  // CustomAppbar(
                  //     Icons.arrow_back_ios_outlined, Icons.search_outlined),
                  // _buildDisplayPhoto(),
                  // _buildUserDetail(context, state.data.usernama),
                  // 'Welcome ${state.data.usernama}'.text.make(),
                  // ButtonWidget(
                  //   text: "Logout",
                  //   onPressed: () {
                  //     BlocProvider.of<UserBloc>(context).add(LogOutUser());
                  //     Commons().showSnackbarInfo(context, "You Have Been Logout");
                  //   },
                  // )
                  HeaderWithSearchBox(
                    size: size,
                    data: state.data,
                  ),
                  // _buildAppBar(context, state.data),
                  // _buildNavigationCustom(context, state.data),
                  // 24.heightBox,
                  SelectBarWidget(),
                  Container(
                    width: 600,
                    height: 300,
                    child: _buildListProductCard(),
                  ),
                ],
                alignment: MainAxisAlignment.start,
                axisSize: MainAxisSize.max,
              );
              // .scrollVertical(physics: ScrollPhysics());
            }
            return 0.heightBox;
          },
        ),
      ),
    );
  }

  Widget _buildListProductCard() {
    return BlocConsumer<ListProductsBloc, ListProductsState>(
      listener: (context, state) {
        if (state is ListProductsIsFailed) {
          Commons().showSnackbarInfo(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is ListProductsIsLoading) {
          //Loading Widget
          return CircularProgressIndicator();
        }
        if (state is ListProductsIsSuccess) {
          //List Product Widget
          final data = state.products;

          return GridView.builder(
            // shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            // padding: EdgeInsets.only(right: 20, left: 20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 10 / 7,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: VStack([
                    GestureDetector(
                      onTap: () {
                        context.go(routeName.detailPath, extra: data[index].id);
                      },
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: CardCustomWidget(
                          image: data[index].picture,
                          price: data[index].price!,
                          title: data[index].name,
                        ),
                      ),
                    ),
                  ]));
            },
          );
        }
        return Container();
      },
    );
  }

  Widget _buildListProduct() {
    return BlocConsumer<ListProductsBloc, ListProductsState>(
      listener: (context, state) {
        if (state is ListProductsIsFailed) {
          Commons().showSnackbarInfo(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is ListProductsIsLoading) {
          //Loading Widget
          return CircularProgressIndicator();
        }
        if (state is ListProductsIsSuccess) {
          //List Product Widget
          final data = state.products;

          return GridView.builder(
            // shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(right: 20, left: 20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: VStack([
                    GestureDetector(
                      onTap: () {
                        context.go(routeName.detailPath, extra: data[index].id);
                      },
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(
                          (data[index].picture!.isEmpty
                              ? "https://thumbs.dreamstime.com/b/no-image-available-icon-photo-camera-flat-vector-illustration-132483141.jpg"
                              : data[index].picture!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    data[index].name!.text.bodyText1(context).make(),
                    data[index].price!.text.bodyText1(context).make(),
                  ]));
            },
          );
        }
        return Container();
      },
    );
  }

  Widget _buildDisplayPhoto() {
    return Container(
      height: 250,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(flex: 1, child: Container()),
              Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        color: Colors.white),
                  ))
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.all(15),
              width: 200,
              height: 200,
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    offset: Offset(-1, 10),
                    blurRadius: 10),
              ]),
              child: Image.asset(
                "images/photo.png",
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildUserDetail(BuildContext context, state) {
    return Container(
        padding: EdgeInsets.all(10),
        height: 350,
        color: Colors.white,
        child: Column(
          children: [
            "Welcome $state".text.make().centered(),
            ButtonWidget(
              text: "Logout",
              onPressed: () {
                BlocProvider.of<UserBloc>(context).add(LogOutUser());
                Commons().showSnackbarInfo(context, "You Have Been Logout");
              },
            )
          ],
        ));
  }

  //TODO : INNER WIDGET APPBAR
  Widget _buildAppBar(BuildContext context, UserModel data) {
    return VxBox(
      child: HStack([
        HStack(
          [
            //TODO: Circular Photo
            VxCircle(
              radius: 80,
              backgroundImage: DecorationImage(
                  image: NetworkImage(data.photoProfile!), fit: BoxFit.cover),
            ),
            16.widthBox,
            //TODO : WELCOME NAME
            "Good ${Commons().greeting()}, \n"
                .richText
                .size(11)
                .withTextSpanChildren([
                  data.usernama!.textSpan
                      .size(16)
                      .bold
                      .color(Colors.black)
                      .make()
                ])
                .make()
                .onTap(() {
                  context.go(routeName.adminPath);
                })
          ],
        ).expand(),
        IconButton(
            onPressed: () {
              BlocProvider.of<UserBloc>(context).add(LogOutUser());
            },
            icon: Icon(Icons.logout_rounded))
      ], crossAlignment: CrossAxisAlignment.start),
    ).white.height(90).p12.bottomRounded(value: 30).shadow.make();
  }

  //TODO: NAVIGATION
  Widget _buildNavigationCustom(BuildContext context, UserModel data) {
    return VxBox(
      child: Column(
        children: [
          8.heightBox,
          "Favorite".text.bold.size(16).make(),
          VxBox(
              child: ListView(
            children: [
              ListTile(
                title: Text("Madhicine Pack"),
                contentPadding: EdgeInsets.all(20),
                subtitle: Text("140.000"),
                leading: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Image(
                      image: NetworkImage(
                          "https://m.media-amazon.com/images/I/71ZAlWNZ1yL._AC_UY1000_.jpg")),
                ),
                trailing:
                    Icon(Icons.thumb_up, color: Colors.greenAccent.shade700),
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                title: Text("Daypack Lafuma"),
                contentPadding: EdgeInsets.all(20),
                subtitle: Text("200.000"),
                leading: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Image(
                      image: NetworkImage(
                          "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//103/MTA-48649260/oem_10l-cycling-backpack-hiking-daypack-rucksack-riding-daypack-for-running-black-orange_full01.jpg")),
                ),
                trailing:
                    Icon(Icons.thumb_up, color: Colors.greenAccent.shade700),
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                title: Text("Body Bag Eiger"),
                contentPadding: EdgeInsets.all(20),
                subtitle: Text("100.000"),
                leading: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Image(
                      image: NetworkImage(
                          "https://images.tokopedia.net/img/cache/500-square/VqbcmM/2022/6/25/85c615a2-da28-4deb-8976-19a12ada10d3.png")),
                ),
                trailing:
                    Icon(Icons.thumb_up, color: Colors.greenAccent.shade700),
              )
            ],
          )).height(400).make(),
        ],
      ),
    )
        .white
        .customRounded(
          BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)),
        )
        .margin(EdgeInsets.only(right: 15, left: 15))
        .make();

    // VxBox(
    //   child: HStack([
    //     HStack(
    //       [
    //         VxBox(
    //           child:
    //         ).height(100).width(100).red100.make()
    //       ],
    //     ).expand(),
    //   ], crossAlignment: CrossAxisAlignment.start),
    // )
    //     .white
    //     .height(100)
    //     .p12
    //     .margin(EdgeInsets.only(left: 12, right: 12))
    //     .customRounded(BorderRadius.circular(14))
    //     .shadow
    //     .make();
  }

  //TODO : PRODUCT GIRD

}
