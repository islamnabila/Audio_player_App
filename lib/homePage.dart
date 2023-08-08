import 'dart:convert';

import 'package:audio_player/my_tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audio_player/app_color.dart' as AppColors;

class MyHomePage extends StatefulWidget{
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>with SingleTickerProviderStateMixin {
    late List <dynamic>populrBooks ;
    late List <dynamic> books;
    late ScrollController _scrollController;
    late TabController _tabController;

  get key => null;
  ReadData()async{
    await DefaultAssetBundle.of(context).loadString("json/populrBooks.json").then((s){
      setState(() {
      populrBooks=  json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context).loadString("json/books.json").then((s){
      setState(() {
        books=  json.decode(s);
      });
    });
  }
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, right: 20,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageIcon(AssetImage('assets/images/menu.png'), size: 18, color: Colors.black,),
                    Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(width: 10,),
                        Icon(Icons.notifications_active)
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text("Popular Books", style: TextStyle(fontSize: 30),),
                  )
                ],
              ),
              SizedBox(height: 11,),
              Container(
                height: 180,
                child: Stack(
                  children: [
                     Positioned(
                       top : 0,
                      left: -20,
                      right: 0,
                      child: Container(
                        height: 180,
                        child: PageView.builder(
                            controller: PageController(viewportFraction: 0.8),
                            // ignore: unnecessary_null_comparison
                            itemCount: populrBooks==null?0:populrBooks.length,
                            itemBuilder: (_, i){
                              return Container(
                                height: 180,
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(21),
                                    image: DecorationImage(
                                        image: AssetImage(populrBooks[i]["img"]),
                                      fit: BoxFit.fill,
                                    )
                                ),
                              );
                            }),
                      ),
                    ),
                  ],

                ),
              ),
              Expanded(child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder:(BuildContext context, bool isScroll){ 
                  return [
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: AppColors.silverBackground,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(50),

                        child: Container(
                          margin: EdgeInsets.only(bottom: 20,left: 25),
                          child: TabBar(
                            indicatorPadding: EdgeInsets.all(0),
                            indicatorSize: TabBarIndicatorSize.label,
                            labelPadding: EdgeInsets.only(right: 10),
                            controller: _tabController,
                            isScrollable: true,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 7,
                                  offset: Offset(0 ,0),
                                )
                              ]
                            ),
                            tabs: [
                            Container(
                            height :50,
                            width: 120,
                            child: Text( "New", style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.menu1Color,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 7,
                                    offset: Offset(0 ,0),
                                  )
                                ]
                            ),

                          ),
                              Container(
                                height :50,
                                width: 120,
                                child: Text( "Popular", style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.menu2color,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 7,
                                        offset: Offset(0 ,0),
                                      )
                                    ]
                                ),

                              ),
                              Container(
                                height :50,
                                width: 120,
                                child: Text( "Trending", style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.menu3color,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 7,
                                        offset: Offset(0 ,0),
                                      )
                                    ]
                                ),

                              ),

                            ],
                          ),
                        ),
                      ),
                    )
                  ];

                }, body: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                    itemCount: books ==null?0: books.length,
                      itemBuilder: (_, i){
                    return Container(
                      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.tabVarViewColor,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2,
                              offset: Offset(0, 0)
                            )
                          ]
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Container(
                                width: 90,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: AssetImage(books[i]["img"]),
                                  )

                                ),
                              ),
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.star, size: 20, color: AppColors.startColor,),
                                      SizedBox(width: 5,),
                                      Text(books[i]["rating"], style: TextStyle(color: AppColors.menu2color )),
                                    ],
                                  ),
                                  Text(books[i]["title"], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                  Text(books[i]["text"], style: TextStyle(fontSize: 16, color: AppColors.subTitleText),),
                                  SizedBox(height: 5,),
                                  Container(
                                    width: 50,
                                    height: 18,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: AppColors.loveColor,
                                    ),
                                    child: Text("Love", style: TextStyle(fontSize: 14, color: Colors.white),),
                                    alignment: Alignment.center,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  ListView.builder(
                    itemCount: books==null?0 : books.length,
                      itemBuilder: (_, i){
                    return Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.tabVarViewColor,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2,
                              offset: Offset(0,0),
                            )
                          ],
                          
                        ),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Container(
                                height: 150,
                                width: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: AssetImage(books[i]["img"])
                                  )

                                ),
                              ),
                              SizedBox(width: 5,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: AppColors.startColor,),
                                      SizedBox(width: 3,),
                                      Text(books[i]["rating"], style: TextStyle(color: AppColors.menu2color),)
                                      
                                    ],
                                  ),
                                  Text(books[i]["title"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                  Text(books[i]["text"], style: TextStyle(fontSize: 16, color: AppColors.subTitleText),),
                                  Container(
                                    width: 50,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: AppColors.loveColor
                                    ),
                                    child: Text("Love", style: TextStyle(color: Colors.white, fontSize: 16),),
                                    alignment: Alignment.center,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                    
                  }),
                  ListView.builder(
                      itemCount: books==null?0 : books.length,
                      itemBuilder: (_, i){
                        return Container(
                          margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.tabVarViewColor,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2,
                                  offset: Offset(0,0),
                                )
                              ],

                            ),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Container(
                                    height: 150,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: AssetImage(books[i]["img"])
                                        )

                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.star, color: AppColors.startColor,),
                                          SizedBox(width: 3,),
                                          Text(books[i]["rating"], style: TextStyle(color: AppColors.menu2color),)

                                        ],
                                      ),
                                      Text(books[i]["title"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                      Text(books[i]["text"], style: TextStyle(fontSize: 16, color: AppColors.subTitleText),),
                                      Container(
                                        width: 50,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(3),
                                            color: AppColors.loveColor
                                        ),
                                        child: Text("Love", style: TextStyle(color: Colors.white, fontSize: 16),),
                                        alignment: Alignment.center,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
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

}