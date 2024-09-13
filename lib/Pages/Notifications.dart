import "package:flutter/material.dart";
import "package:upang_eat/Widgets/StallsStallCard.dart";

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
        width: 350,
        child: ListView.builder(
          itemBuilder: (context, index){
            final stall = stallData[index];
            return StallsStallCard(imageBanner: stall['imageBanner'], imageProfile: stall['imageProfile'], stallName: stall['stallName'],);
          },
          itemCount: stallData.length,
        ),
      ),
    );
  }
}
