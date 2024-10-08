import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/widgets/favorite_button.dart';
import 'package:restaurant_app/widgets/menu_card.dart';

class RestaurantDetailScreen extends StatelessWidget {
  static const routeName = '/restaurant_detail_screen';

  final Restaurant restaurant;

  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: restaurant.id,
                  child: Image.network(
                    restaurant.pictureId,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 78, 78, 78),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const FavoriteButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        '📍 ${restaurant.city}',
                        style: const TextStyle(
                            fontFamily: 'Poppins', fontSize: 18.0),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        '⭐ ${restaurant.rating}',
                        style: const TextStyle(
                            fontFamily: 'Poppins', fontSize: 18.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 13),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 25.0,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textAlign: TextAlign.justify,
                        restaurant.description,
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Foods',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 25.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurant.menus.foods.length,
                      itemBuilder: (context, index) {
                        var food = restaurant.menus.foods[index];
                        return MenuCard(
                          imageUrl:
                              'https://i.pinimg.com/474x/ce/d2/72/ced27295631ad112c8592cf95242aa4c.jpg',
                          name: food.name,
                          price: 'IDR 15.000',
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Beverage',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurant.menus.drinks.length,
                      itemBuilder: (context, index) {
                        var drink = restaurant.menus.drinks[index];
                        return MenuCard(
                          imageUrl:
                              'https://i.pinimg.com/474x/71/70/2e/71702ed54c019af8de8feccbb0c60e35.jpg',
                          name: drink.name,
                          price: 'IDR 15.000',
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
