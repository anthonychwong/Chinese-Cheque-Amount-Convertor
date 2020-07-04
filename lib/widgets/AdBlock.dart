import 'package:flutter/widgets.dart';

class AdBlock extends StatelessWidget {
  final String imageURL;
  final String description;

  AdBlock({this.imageURL, this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(imageURL),
        SizedBox(
          height: 5,
        ),
        Text(description)
      ],
    );
  }
}
