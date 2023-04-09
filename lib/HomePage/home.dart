import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_project/Constant/color.dart';
import 'package:riverpod_project/Network/network.dart';
import 'package:riverpod_project/ProdutcDetailPage/detail.dart';
import 'package:riverpod_project/main.dart';
import 'package:riverpod_project/router.dart';

import 'package:shimmer/shimmer.dart';

import '../Constant/items.dart';
import '../Model/state.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

final providerSelectedPage = StateProvider((ref) => 0);

class _HomePageState extends ConsumerState<HomePage> {
  NetworkCreator networkCreator = NetworkCreator();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    List<String> pages = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "10",
      "11",
      "12",
      "13",
      "14",
      "15",
      "16",
      "17",
      "18",
      "19",
      "20"
    ];
    final selected = ref.watch(providerSelectedPage);
    final logging = ref.watch(islogin);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Coloring.primary,
          drawer: Item.GetDrawer(context, _scaffoldKey, logging, ref),
          appBar: Item.GetAppBar(
              "QIT Flutter", true, _scaffoldKey, logging, context),
          body: Body(selected, pages)),
    );
  }

  Widget Body(int selected, List<String> pages) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 70.sp,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 15.sp,
                ),
                InkWell(
                  onTap: () {
                    if (selected != 0) {
                      ref.read(providerSelectedPage.notifier).state--;
                    }
                  },
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(25),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        "\u21D0",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: pages.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            SizedBox(
                              width: 15.sp,
                            ),
                            InkWell(
                              onTap: () {
                                ref.read(providerSelectedPage.notifier).state =
                                    index;
                              },
                              child: Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(25),
                                child: CircleAvatar(
                                  backgroundColor: selected == index
                                      ? Colors.grey[800]
                                      : Colors.white,
                                  child: Text(
                                    "${pages[index]}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: selected == index
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
                InkWell(
                  onTap: () {
                    if (selected != 19) {
                      ref.read(providerSelectedPage.notifier).state++;
                    }
                  },
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(25),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        "\u21D2",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15.sp,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(25.sp),
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder(
                future: networkCreator.getAllProduct(selected),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Shimmer.fromColors(
                        period: Duration(milliseconds: 2000),
                        baseColor: Colors.white,
                        highlightColor: Coloring.third,
                        child: GridView.builder(
                            itemCount: 5,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2.5,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 20,
                                    mainAxisExtent: 350),
                            itemBuilder: (context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                              );
                            }));
                  } else if (snapshot.hasData) {
                    return GridView.builder(
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2.5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 20,
                          mainAxisExtent: 350),
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return Detail(
                                    id: snapshot.data!.data![index].id!);
                              },
                            ));
                          },
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Image.network(snapshot.data!
                                      .data![index].image!.conversions!.large!),
                                ),
                                Expanded(
                                  child: Text(
                                    snapshot.data!.data![index].title!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Divider(
                                  color: Colors.black,
                                  thickness: 3,
                                ),
                                Text(
                                  snapshot.data!.data![index].price!.value! +
                                      snapshot
                                          .data!.data![index].price!.currency!,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text("No Data...".tr()));
                  }
                }),
          )
        ],
      ),
    );
  }
}
