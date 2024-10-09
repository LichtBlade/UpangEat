// TODO: Fix all input fields, fix radio button, implement image input
import 'package:flutter/material.dart';
import 'package:upang_eat/widgets/seller_center_widgets/seller_center_appbar.dart';

class SellerCenterProductForm extends StatefulWidget {
  const SellerCenterProductForm({super.key});

  @override
  State<SellerCenterProductForm> createState() =>
      _SellerCenterProductFormState();
}

class _SellerCenterProductFormState extends State<SellerCenterProductForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const SellerCenterAppbar(stallName: 'BossSisig'),
        body: SingleChildScrollView(
          child: Form(
            child: Card(
              margin: const EdgeInsets.all(16),
              color: const Color.fromARGB(255, 237, 237, 237),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create Product',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    // Product Name
                    _titleText('Name'),
                    SizedBox(
                      height: 34,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    // Price
                    _titleText('Price'),
                    SizedBox(
                      height: 34,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    // Radio Button
                    _titleText('Type'),
                    Row(
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: null,
                              onChanged: (index) {},
                            ),
                            Text('Breakfast')
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: null,
                              onChanged: (index) {},
                            ),
                            Text('Lunch')
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: null,
                              onChanged: (index) {},
                            ),
                            Text('Merienda')
                          ],
                        ),
                      ],
                    ),

                    // Category
                    _titleText('Category:'),
                    SizedBox(
                      height: 34,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    //Description
                    _titleText('Description'),
                    const SizedBox(
                      height: 200, //     <-- TextField expands to this height.
                      child: TextField(
                        maxLines: null, // Set this
                        expands: true, // and this
                        keyboardType: TextInputType.multiline,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),

                    //Image
                    _titleText('Image'),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          color: Colors.white,
                          height: 200,
                          width: 500,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image,
                                color: Colors.grey,
                              ),
                            ],
                          )),
                    ),

                    //Footer Buttons
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(),
                            onPressed: () {},
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              elevation: 2.0,
                              backgroundColor:
                                  const Color.fromARGB(255, 222, 15, 57),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Submit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

Widget _titleText(String title) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Text(
      title,
      style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
    ),
  );
}
