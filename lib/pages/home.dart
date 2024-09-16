
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:upang_eat/Widgets/app_bar_widget.dart';
import "package:upang_eat/Widgets/categories_widget.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, String>> stallData = [
    {
      'stallName': "Boss Sisig!",
      'imageProfile': "assets/BossSisigProfile.jpg",
      'imageBanner': "assets/BossSisigBanner.jpg"
    },
    {
      'stallName': "Ninong Ry's Exotic Delicacy",
      'imageProfile': "assets/NinongRySpecialDelicacy.jpg",
      'imageBanner': "assets/NinongRySpecialDelicacyBanner.jpg"
    },
    {
      'stallName': "Mekus Mekus Tayo Insan!",
      'imageProfile': "assets/MekusMekusTayoInsan.jpg",
      'imageBanner': "assets/MekusMekusTayoInsanBanner.jpeg"
    },
    {
      'stallName': "Masamsamit So Adele",
      'imageProfile': "assets/MasamsamitSoAdele.jpg",
      'imageBanner': "assets/MasamsamitSoAdeleBanner.jpg"
    }
  ];
  final List<String> foods = [
    "assets/drink.png",
    "assets/drink.png",
    "assets/drink.png",
    "assets/drink.png",
    "assets/drink.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(top: 8.0),
        children: [
          // Appbarwidget(),   Deleted No Need
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: Container(
              width: 320,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    )
                  ]),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(CupertinoIcons.search),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                      hintText: "What would you like to have?",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16, left: 16),
            child: Text(
              "Categories",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          // Categories !!!!!!
          Categorieswidget(),
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              "Stalls",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 160,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: stallData.length,
                itemBuilder: (context, index) {
                  final stall = stallData[index];
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Card(
                          elevation: 8,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14.0),
                            child: Column(children: [
                              Image.asset(
                                stall['imageProfile']!,
                                height: 100,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                width: 120,
                                child: Center(child: Text(stall['stallName']!)),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 8),
            child: Text(
              "Meals",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: foods.length,
                itemBuilder: (context, index) {
                  final food = foods[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card.outlined(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(14.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    food,
                                    height: 95,
                                    width: 95,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: SizedBox(
                                width: 210,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Sting", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.start,),
                                    Text("Masasampal ka sa gising. Its liver lover boy")
                                  ],
                                ),
                              ),
                            )

                          ],
                        ),
                      ),

                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
