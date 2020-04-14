import 'package:flutter/material.dart';

class VocabularyTab extends StatelessWidget {
  Container cards(
    String imageUrl,
    String title,
    String subtitle,
  ) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Card(
        child: Column(
          children: <Widget>[
            // Image.asset(imageUrl, fit: BoxFit.cover, width: )
            Container(
              child: ListTile(
                title: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
              child: LinearProgressIndicator(
                value: 10 / 20,
                backgroundColor: Colors.grey[100],
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).backgroundColor,
      child: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150.0,
          childAspectRatio: 0.68,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemBuilder: (context, index) => Container(
          color: Colors.red,
        ),
      ),
    );
  }
}

// padding: EdgeInsets.only(bottom: 5),
// scrollDirection: Axis.vertical,
// children: <Widget>[
//   Row(
//     children: <Widget>[
//       Container(
//         child: cards('assets/tiger.png', 'Animals', '10/20'),
//       ),
//       Container(
//         child: cards('assets/birds.png', 'Birds', '10/20'),
//       ),
//       Container(
//         child: cards('assets/colors.png', 'Color', '10/20'),
//       ),
//     ],
//   ),
//   Row(
//     children: <Widget>[
//       Container(
//         child: cards('assets/creature.png', 'Creature', '10/20'),
//       ),
//       Container(
//         child: cards('assets/dress.png', 'Dress', '10/20'),
//       ),
//       Container(
//         child: cards('assets/education.png', 'Education', '10/20'),
//       ),
//     ],
//   ),
//   Row(
//     children: <Widget>[
//       Container(
//         child: cards('assets/fruits.png', 'Fruits', '10/20'),
//       ),
//       Container(
//         child: cards('assets/health.png', 'Health', '10/20'),
//       ),
//       Container(
//         child: cards('assets/nature.png', 'Nature', '10/20'),
//       ),
//     ],
//   ),
// ],
