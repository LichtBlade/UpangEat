import "package:flutter/material.dart";

class Stalls extends StatefulWidget {
  const Stalls({super.key});

  @override
  State<Stalls> createState() => _StallsState();
}

class _StallsState extends State<Stalls> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Card.outlined(
            elevation: 12,
            color: const Color(0xFFFEF7FF),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "../assets/BossSisigProfile.jpg",
                          height: 100,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(child: Image.asset("../assets/BossSisigBanner.jpg", fit: BoxFit.cover))
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.black26,
                  thickness: 0.3,
                  height: 12,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text("data"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
