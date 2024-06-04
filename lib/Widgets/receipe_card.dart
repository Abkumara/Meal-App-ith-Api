import 'package:flutter/material.dart';

class ReceipeCard extends StatelessWidget {
  const ReceipeCard(
      {super.key,
      required this.title,
      required this.cookTime,
      required this.backgroundImageUrl,
      required this.rate});
  final String title;
  final String cookTime;
  final String rate;
  final String backgroundImageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        padding: EdgeInsets.all(10),
        height: 330,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(18),
          image: DecorationImage(
            fit: BoxFit.cover,
            opacity: 0.5,
            image: NetworkImage(backgroundImageUrl),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    width: 70,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        Text(
                          rate,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    )),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.timer_sharp,
                          color: Colors.amber,
                        ),
                        Text(
                          cookTime,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    )),
              ],
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 21),
            ),
          ],
        ),
      ),
    );
  }
}
