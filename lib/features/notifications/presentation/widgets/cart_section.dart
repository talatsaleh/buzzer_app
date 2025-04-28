import 'package:buzzer_app/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:buzzer_app/features/cart/presentation/blocs/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartSection extends StatelessWidget {
  const CartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 1,
                blurStyle: BlurStyle.outer),
          ],
        ),
        child: BlocConsumer<CartBloc, CartState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is CartLoaded) {
              return Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Park Lee Hone',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Restaurant',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Text('8'),
                          foregroundColor: Colors.white,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Align(
                        alignment: Alignment.topCenter,
                        heightFactor: 0,
                        child: Column(
                          children: [
                            Expanded(
                              child: ShaderMask(
                                shaderCallback: (bounds) {
                                  return LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black,
                                      Colors.transparent,
                                    ],
                                    stops: [.4, .6],
                                  ).createShader(bounds);
                                },
                                blendMode: BlendMode.dstIn,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ItemListTile(),
                                    ItemListTile(),
                                    ItemListTile(),
                                    ItemListTile(),
                                    ItemListTile(),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(child: Text('addmore'))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center();
            }
          },
        ),
      ),
    );
  }
}

class ItemListTile extends StatelessWidget {
  const ItemListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assetName'),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(left: 12, right: 12),
                child: Text(
                  'data',
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text('data'),
            )),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text('data'),
            )),
          ],
        ),
        Divider()
      ],
    );
  }
}
