import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod_project/Constant/color.dart';
import 'package:riverpod_project/Constant/dialogs.dart';
import 'package:riverpod_project/Constant/items.dart';
import 'package:riverpod_project/Model/cart.dart';
import 'package:riverpod_project/Model/productmodel.dart';
import 'package:riverpod_project/Model/usermodel.dart';
import 'package:riverpod_project/Network/network.dart';
import 'package:riverpod_project/router.dart';

import '../main.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

final cartItem = StateProvider((ref) => CartItem());
final tokenstate = StateProvider((ref) => userIt<Users>().token);

class _CartPageState extends ConsumerState<CartPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  NetworkCreator networkCreator = NetworkCreator();
  @override
  Widget build(BuildContext context) {
    final logging = ref.watch(islogin);
    ref.watch(cartItem);
    final datatoken = ref.watch(tokenstate);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Coloring.primary,
      appBar: Item.GetAppBar(
          "قائمة المشتريات".tr(), false, _scaffoldKey, logging, context),
      drawer: Item.GetDrawer(context, _scaffoldKey, logging, ref),
      body: Body(datatoken),
    );
  }

  Body(String? datatoken) {
    return datatoken == null
        ? Center(
            child: Text("You're Not Login".tr(),
                style: TextStyle(
                    fontFamily: "Nabeel",
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold)))
        : SingleChildScrollView(
            child: FutureBuilder<List<Detail>>(
                future:
                    networkCreator.getDetailProductCart(userIt<Users>().token!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Coloring.secondary,
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: networkCreator.cartItem.cart!.items,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ListTile(
                                    visualDensity: const VisualDensity(
                                        vertical: 4, horizontal: 4),
                                    title: Text(
                                        "${networkCreator.cartItem.cart!.products![index].total!.value!} ${networkCreator.cartItem.cart!.products![index].total!.currency!}",
                                        style: const TextStyle(
                                            fontFamily: "Nabeel",
                                            fontWeight: FontWeight.bold)),
                                    leading: Image.network(snapshot.data![index]
                                        .data!.image!.conversions!.small!),
                                    trailing: Column(
                                      children: [
                                        Text(
                                          "الكميّة ".tr() +
                                              "${networkCreator.cartItem.cart!.products![index].totalQuantity}",
                                          style: const TextStyle(
                                              fontFamily: "Nabeel",
                                              fontWeight: FontWeight.bold),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Dialogs.ensuredelete(
                                                context,
                                                snapshot.data![index].data!.id!,
                                                ref);
                                          },
                                          child: Icon(Icons.delete),
                                        )
                                      ],
                                    ),
                                    subtitle: Text(
                                        "${networkCreator.cartItem.cart!.products![index].unitPrice!.value!} ${networkCreator.cartItem.cart!.products![index].unitPrice!.currency!}",
                                        style: const TextStyle(
                                            fontFamily: "Nabeel",
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  const Divider(
                                    thickness: 2,
                                  ),
                                ],
                              );
                            }),
                      ],
                    );
                  } else {
                    return const Center(
                        child: Text("No Data!!",
                            style: TextStyle(
                                fontFamily: "Nabeel",
                                fontWeight: FontWeight.bold)));
                  }
                }),
          );
  }
}
