import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardDetails extends StatelessWidget {
  CardDetails({Key? key, required this.imageAddress, required this.index, required this.placeDetails})
      : super(key: key);

  String imageAddress;
  int index;
  String placeDetails;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            const SizedBox(
              height: 800.0,
              width: double.infinity,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              height: 500.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(imageAddress),
                    fit: BoxFit.fill,
                  )),
            ),
            Positioned(
              top: 420.0,
              left: 10.0,
              right: 10.0,
              child: Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  height: 380.0,
                  decoration: const BoxDecoration(
                      //borderRadius: BorderRadius.circular(20.0)
                      ),
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 10.0,
                    top: 20.0,
                  ),
                  child: Text(
                    placeDetails,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ),
            Positioned(
                child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {},
            ))
          ],
        ),
      ],
    );
  }
}
