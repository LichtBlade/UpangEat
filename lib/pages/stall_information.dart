import 'package:flutter/material.dart';

class StallInformation extends StatefulWidget {
  const StallInformation({super.key});

  @override
  State<StallInformation> createState() => _StallInformationState();
}

class _StallInformationState extends State<StallInformation> {
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
      appBar: AppBar(
        title: const Text("Stall Information"),

      ),

      body: SizedBox(
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 220,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage(
                            "assets/NinongRySpecialDelicacy.jpg"),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 0,
                    right: 0,
                    top: 90,
                    child: Center(
                      child: Text(
                        "Title",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  color: Colors.brown,
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView.builder(
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
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
