import "package:flutter/material.dart";
import "package:upang_eat/Widgets/StallsStallCard.dart";

class Stalls extends StatefulWidget {
  const Stalls({super.key});

  @override
  State<Stalls> createState() => _StallsState();
}

class _StallsState extends State<Stalls> {
  final List<Map<String, String>> stallData = [
    {
      'stallName': "Boss Sisig!",
      'imageProfile': "../assets/BossSisigProfile.jpg",
      'imageBanner': "../assets/BossSisigBanner.jpg"
    },
    {
      'stallName': "Ninong Ry's Exotic Delicacy",
      'imageProfile': "../assets/NinongRySpecialDelicacy.jpg",
      'imageBanner': "../assets/NinongRySpecialDelicacyBanner.jpg"
    },
    {
      'stallName': "Mekus Mekus Tayo Insan!",
      'imageProfile': "../assets/MekusMekusTayoInsan.jpg",
      'imageBanner': "../assets/MekusMekusTayoInsanBanner.jpeg"
    },
    {
      'stallName': "Masamsamit So Adele",
      'imageProfile': "../assets/MasamsamitSoAdele.jpg",
      'imageBanner': "../assets/MasamsamitSoAdeleBanner.jpg"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 320,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: ListView.builder(
            itemBuilder: (context, index){
              final stall = stallData[index];
              return StallsStallCard(imageBanner: stall['imageBanner'], imageProfile: stall['imageProfile'], stallName: stall['stallName'],);
            },
            itemCount: stallData.length,
          ),
        ),
      ),
    );
  }
}
