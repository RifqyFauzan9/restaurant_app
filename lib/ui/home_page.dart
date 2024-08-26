import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/restaurant_detail_screen.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RestaurantDetailScreen.routeName,
              arguments: restaurant);
        },
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Hero(tag: restaurant.id, child: Image.network(
                  restaurant.pictureId,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error, size: 50); // Error icon
                  },
                ),),
              ),
            ),
            const SizedBox(
              width: 16.0,
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '📍 ${restaurant.city}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Roboto',
                      fontSize: 20.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    '⭐${restaurant.rating.toString()}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/json/local_restaurant.json'),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            // loading widget
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              final restaurantApp =
                  restaurantAppFromJson(snapshot.data as String);
              final List<Restaurant> restaurants = restaurantApp.restaurants;
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Restaurant',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Recommended restaurant for you.',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 145, 145, 145),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: restaurants.length,
                        itemBuilder: (context, index) {
                          return _buildRestaurantItem(
                              context, restaurants[index]);
                        },
                      ),
                    )
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              // error widget
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              // loading widget
              return const Center(child: CircularProgressIndicator());
            }
          }
        },
      ),
    );
  }
}
