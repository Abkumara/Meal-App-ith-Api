import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_recpie_with_api/Model/food_object.dart';
import 'package:food_recpie_with_api/Widgets/receipe_card.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<FoodObject>> getUsers() async {
    var url = Uri.parse('https://yummly2.p.rapidapi.com/feeds/list');
    late http.Response response;
    List<FoodObject> foodObjects = [];
    try {
      response = await http.get(url, headers: {
        'X-RapidAPI-Key': '64267e8130mshd0e5ba80b03325cp1a6dc3jsn228bd7565faa',
        'X-RapidAPI-Host': 'yummly2.p.rapidapi.com'
      });
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        List<dynamic> foods = data['feed'];
        for (var item in foods) {
          var foodname = item['content']['details']['displayName'];
          var cookTime = item['content']['details']['totalTime'];
          var rating = item['content']['details']['rating'];
          var imageUrl =
              item['content']['details']['images'][0]['resizableImageUrl'];
          FoodObject foodObject =
              FoodObject(cookTime, imageUrl, rating, foodname);
          foodObjects.add(foodObject);
        }
      } else {
        return Future.error('error ${response.statusCode}');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
    return foodObjects;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu_sharp),
              SizedBox(
                width: 10,
              ),
              Text('Food App'),
            ],
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return ReceipeCard(
                      backgroundImageUrl: snapshot.data[index].imageUrl,
                      cookTime: snapshot.data[index].cookTime,
                      rate: snapshot.data[index].rating.toString(),
                      title: snapshot.data[index].foodName,
                    );
                  },
                );
              }
            }
          },
        ));
  }
}
