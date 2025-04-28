import 'package:buzzer_app/core/widgets/stack_background.dart';
import 'package:buzzer_app/features/restaurant/domain/entities/menuItem.dart';
import 'package:buzzer_app/features/restaurant/domain/entities/restaurant.dart';
import 'package:buzzer_app/features/restaurant/presentation/blocs/restaurant_bloc.dart';
import 'package:buzzer_app/features/restaurant/presentation/blocs/restaurant_event.dart';
import 'package:buzzer_app/features/restaurant/presentation/blocs/restaurant_state.dart';
import 'package:buzzer_app/features/restaurant/presentation/screens/restaurants_detail_product_detail_screen.dart';
import 'package:buzzer_app/features/restaurant/presentation/screens/widgets/star_rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        context.read<RestaurantBloc>().add(GetAllRestaurantsEvent());
      },
      child: StackBackground(
        height: MediaQuery.of(context).size.height * .5,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.transparent,
            title: Text(restaurant.name),
          ),
          body: Container(
            color: Colors.grey.shade200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocConsumer<RestaurantBloc, RestaurantState>(
                builder: (context, state) {
                  print(state.runtimeType);

                  if (state is RestaurantLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is RestaurantError) {
                    return Center(
                      child: Text('There is proplem,'),
                    );
                  } else if (state is RestaurantItemLoaded) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 items per row
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.75, // Adjust aspect ratio
                      ),
                      itemCount: state.menuItem.length, // Number of items
                      itemBuilder: (context, index) {
                        return ProductCard(
                          menuItem: state.menuItem[index],
                          restaurant: restaurant,
                        );
                      },
                    );
                  } else {
                    return const Center();
                  }
                },
                listener: (BuildContext context, RestaurantState state) {},
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final MenuItem menuItem;
  final Restaurant restaurant;

  const ProductCard(
      {super.key, required this.menuItem, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetailScreen(
            menuItem: menuItem,
            restaurant: restaurant,
          ),
        ));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                menuItem.imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          StarRating(rate: menuItem.rate),
                          const SizedBox(width: 4),
                          Text("${menuItem.rate}",
                              style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                      Text(
                        "Featured",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    menuItem.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        "EGP ${menuItem.price + 10}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        "EGP ${menuItem.price}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
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
