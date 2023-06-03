import 'dart:convert';
import 'package:ebook/mytabs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List popularBooks = [];
  List books = [];
  List tbooks = [];
  List pbooks = [];
  late ScrollController _scrollController;
  late TabController _tabController;
  String button_text = "love";
  Color color = Colors.blue;

  readData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/images.json")
        .then((s) async {
      setState(() {
        popularBooks = json.decode(s);
        _tabController = TabController(length: 3, vsync: this);
        _scrollController = ScrollController();
      });
      await DefaultAssetBundle.of(context)
          .loadString("json/books.json")
          .then((w) {
        setState(() {
          books = json.decode(w);
        });
      });
      await DefaultAssetBundle.of(context)
          .loadString("json/pbooks.json")
          .then((w) {
        setState(() {
          pbooks = json.decode(w);
        });
      });
      await DefaultAssetBundle.of(context)
          .loadString("json/tbooks.json")
          .then((n) {
        setState(() {
          tbooks = json.decode(n);
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ImageIcon(
                      AssetImage("assets/images/menu.png"),
                      size: 24,
                      color: Colors.black,
                    ),
                    Row(
                      children: const [
                        Icon(Icons.search),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(Icons.notifications),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: const Text(
                      "Popular Books",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  Positioned(
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 200,
                          child: PageView.builder(
                              controller: PageController(viewportFraction: 0.8),
                              itemCount: popularBooks.length,
                              itemBuilder: (_, i) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                            popularBooks[i]["image"],
                                          ))),
                                );
                              })))
                ],
              ),
              Expanded(
                  child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (BuildContext context, bool isScroll) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: Colors.white,
                      bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(50),
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: TabBar(
                              indicatorSize: TabBarIndicatorSize.label,
                              labelPadding: const EdgeInsets.only(left: 10),
                              controller: _tabController,
                              isScrollable: true,
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 7,
                                    )
                                  ]),
                              tabs: const [
                                MyTabs(color: Colors.amber, text: "New"),
                                MyTabs(color: Colors.blue, text: "Popular"),
                                MyTabs(color: Colors.red, text: "Trending"),
                              ],
                            ),
                          )),
                    )
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView.builder(
                        itemCount: books == null ? 0 : books.length,
                        itemBuilder: (_, i) {
                          return Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(5),
                            width: 600,
                            height: 160,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    offset: const Offset(0, 0),
                                    blurRadius: 3),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(books[i]["image"]),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(0, 0),
                                        )
                                      ]),
                                  width: 100,
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.white,
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              size: 24,
                                              color: Colors.yellow,
                                            ),
                                            Text(
                                              books[i]["ratings"],
                                              style: const TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          books[i]["name"],
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          books[i]["Author"],
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              button_text = "Loved";
                                            });
                                          },
                                          style: const ButtonStyle(),
                                          child: Text(button_text),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                    ListView.builder(
                        itemCount: pbooks == null ? 0 : pbooks.length,
                        itemBuilder: (_, i) {
                          return Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(5),
                            width: 600,
                            height: 160,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    offset: const Offset(0, 0),
                                    blurRadius: 3),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(pbooks[i]["image"]),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(0, 0),
                                        )
                                      ]),
                                  width: 100,
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.white,
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              size: 24,
                                              color: Colors.yellow,
                                            ),
                                            Text(
                                              pbooks[i]["ratings"],
                                              style: const TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          pbooks[i]["name"],
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          pbooks[i]["Author"],
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              button_text = "Loved";
                                            });
                                          },
                                          style: const ButtonStyle(),
                                          child: Text(button_text),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                    ListView.builder(
                        itemCount: tbooks == null ? 0 : tbooks.length,
                        itemBuilder: (_, i) {
                          return Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(5),
                            width: 600,
                            height: 160,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    offset: const Offset(0, 0),
                                    blurRadius: 3),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(tbooks[i]["image"]),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: const [
                                         BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(0, 0),
                                        )
                                      ]),
                                  width: 100,
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.white,
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              size: 24,
                                              color: Colors.yellow,
                                            ),
                                            Text(
                                              tbooks[i]["ratings"],
                                              style: const TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          tbooks[i]["name"],
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          tbooks[i]["Author"],
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              button_text = "Loved";
                                            });
                                          },
                                          style: const ButtonStyle(
                                          ),
                                          child: Text(button_text),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<TabController>('_tabController', _tabController));
  }
}
