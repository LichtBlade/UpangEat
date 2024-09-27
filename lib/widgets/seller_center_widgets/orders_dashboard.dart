import 'package:flutter/material.dart';

class OrdersDashboard extends StatefulWidget {
  final int numToProcess;
  final int numToClaim;
  final int numToReviwew;
  final Function()? forwardBtnFunc;

  const OrdersDashboard({
    super.key,
    required this.numToProcess,
    required this.numToClaim,
    required this.numToReviwew,
    this.forwardBtnFunc,
  });

  @override
  State<OrdersDashboard> createState() => _OrdersDashboardState();
}

class _OrdersDashboardState extends State<OrdersDashboard> {
  late int numClaim;
  late int numProcess;
  late int numReview;
  Function()? onPressed;

  @override
  void initState() {
    super.initState();

    numClaim = widget.numToClaim;
    numProcess = widget.numToProcess;
    numReview = widget.numToReviwew;
    onPressed = widget.forwardBtnFunc;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
        child: Column(
          children: [
            //Card header
            Row(
              children: [
                const Flexible(
                  flex: 5,
                  fit: FlexFit.tight,
                  child: Text(
                    'Orders',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: IconButton(
                        onPressed: onPressed,
                        icon: const Icon(Icons.arrow_forward_ios_outlined)))
              ],
            ),

            //Card data
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        children: [
                          Text(
                            numProcess.toString(),
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'To Process',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      )),
                  const VerticalDivider(
                    thickness: 2,
                    width: 1,
                    endIndent: 2,
                    color: Colors.black,
                  ),
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        children: [
                          Text(
                            numClaim.toString(),
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'To Claim',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      )),
                  const VerticalDivider(
                    color: Colors.black,
                    thickness: 2,
                    width: 1,
                    endIndent: 2,
                  ),
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        children: [
                          Text(
                            numReview.toString(),
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Review',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
