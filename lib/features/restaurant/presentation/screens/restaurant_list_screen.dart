import 'dart:developer';

import 'package:buzzer_app/core/widgets/stack_background.dart';
import 'package:buzzer_app/features/restaurant/presentation/blocs/restaurant_bloc.dart';
import 'package:buzzer_app/features/restaurant/presentation/blocs/restaurant_event.dart';
import 'package:buzzer_app/features/restaurant/presentation/blocs/restaurant_state.dart';
import 'package:buzzer_app/features/restaurant/presentation/screens/widgets/customSearchBar.dart';
import 'package:buzzer_app/features/restaurant/presentation/screens/widgets/restaurant_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StackBackground(
      height: MediaQuery.of(context).size.height * .5,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          title: const Text('Restaurants',
              style: TextStyle(fontWeight: FontWeight.bold)),
          bottom: const PreferredSize(
              preferredSize: Size(50, 100),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CustomSearchBar(),
              )),
        ),
        body: Container(
          color: Colors.grey.shade200,
          child: Column(
            children: [
              Expanded(
                child: BlocConsumer<RestaurantBloc, RestaurantState>(
                  builder: (context, state) {
                    if (state is RestaurantLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is RestaurantsLoaded) {
                      return ListView.builder(
                        itemCount: state.restaurants.length,
                        itemBuilder: (context, index) {
                          return RestaurantCard(
                            restaurant: state.restaurants[index],
                          );
                        },
                      );
                    } else if (state is RestaurantError) {
                      log(state.message, stackTrace: state.stackTrace);
                      return const Center(
                        child: Text('there is Error here'),
                      );
                    } else {
                      if(state is RestaurantInitial){
                        context
                            .read<RestaurantBloc>()
                            .add(GetAllRestaurantsEvent());
                      }
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  },
                  listener: (context, state) {
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
