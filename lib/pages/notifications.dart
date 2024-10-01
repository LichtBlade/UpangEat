import "package:flutter/material.dart";
import "package:upang_eat/Widgets/stalls_stall_card.dart";

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final List<Map<String, String>> stallData = [
    {
      'stallName': "Boss Sisig!",
      'imageProfile': "assets/1.jpg",
      'imageBanner': "assets/BossSisigBanner.jpg"
    },
    {
      'stallName': "Ninong Ry's Exotic Delicacy",
      'imageProfile': "assets/2.jpg",
      'imageBanner': "assets/NinongRySpecialDelicacyBanner.jpg"
    },
    {
      'stallName': "Mekus Mekus Tayo Insan!",
      'imageProfile': "assets/3.jpg",
      'imageBanner': "assets/MekusMekusTayoInsanBanner.jpeg"
    },
    {
      'stallName': "Masamsamit So Adele",
      'imageProfile': "assets/4.jpg",
      'imageBanner': "assets/MasamsamitSoAdeleBanner.jpg"
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
            return const Center(child:Text("WOW"));
          },
          itemCount: stallData.length,
        ),
      ),
    );
  }
}
