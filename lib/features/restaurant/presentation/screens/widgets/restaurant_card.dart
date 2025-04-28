import 'package:buzzer_app/features/restaurant/domain/entities/restaurant.dart';
import 'package:buzzer_app/features/restaurant/presentation/blocs/restaurant_event.dart';
import 'package:buzzer_app/features/restaurant/presentation/screens/restaurant_detail_screen.dart';
import 'package:buzzer_app/features/restaurant/presentation/screens/widgets/star_rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/restaurant_bloc.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context
            .read<RestaurantBloc>()
            .add(GetRestaurantDetailEvent(restaurant.id));
        Navigator.of(context)
            .push(MaterialPageRoute(
          builder: (context) => RestaurantDetailScreen(restaurant: restaurant),
        ))
            .then(
          (value) {
          },
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
        shadowColor: Colors.black26,
        elevation: 0.5,
        child: Padding(
          padding: const EdgeInsets.only(
            right: 8.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(8.0),
                  right: Radius.circular(100),
                ),
                child: Image.network(
                  restaurant.imageUrl,
                  width: 150.0,
                  height: 150.0,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          StarRating(rate: restaurant.rating),
                          const SizedBox(width: 4.0),
                          Text('${restaurant.rating}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black26)),
                        ],
                      ),
                      Text(
                        restaurant.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        'Restaurant',
                        style: TextStyle(color: Colors.red.shade900),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on,
                              size: 16.0, color: Colors.grey),
                          const SizedBox(width: 4.0),
                          Text(restaurant.address,
                              style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
