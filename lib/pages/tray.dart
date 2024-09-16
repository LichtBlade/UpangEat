import "package:flutter/material.dart";
import "package:upang_eat/Widgets/stalls_stall_card.dart";

class Tray extends StatefulWidget {
  const Tray({super.key});

  @override
  State<Tray> createState() => _TrayState();
}

class _TrayState extends State<Tray> {
  final List<String> foods = [
    "assets/drink.png",
    "assets/drink.png",
    "assets/drink.png",
    "assets/drink.png",
    "assets/drink.png",
    "assets/drink.png",
    "assets/drink.png",
    "assets/drink.png",
    "assets/drink.png",
    "assets/drink.png",
  ];
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
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 350,
        child: ListView.builder(
          itemBuilder: (context, index) {
            final food = foods[index];
            bool isChecked = false;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        }),
                    const SizedBox(width: 16),
                    Image.asset(food, width: 80, height: 80, fit: BoxFit.cover,),
                    const SizedBox(width: 16),
                    const Column(
                      children: [
                        Text("data"),
                        Text("data"),
                        Text("data"),
                        Text("data"),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: foods.length,
        ),
      ),
    );
  }
}
