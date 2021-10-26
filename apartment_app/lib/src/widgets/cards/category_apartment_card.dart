import 'package:flutter/material.dart';

class CategoryApartmentCard extends StatelessWidget {
  const CategoryApartmentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped.');
        },
        child: const SizedBox(
          width: 300,
          height: 100,
          child: Text('A card that can be tapped'),
        ),
      ),
    );
  }
}
