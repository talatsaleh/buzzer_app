import 'package:buzzer_app/core/widgets/stack_background.dart';
import 'package:buzzer_app/features/cart/domain/entities/cart_item.dart';
import 'package:buzzer_app/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:buzzer_app/features/cart/presentation/blocs/cart_events.dart';
import 'package:buzzer_app/features/cart/presentation/blocs/cart_state.dart';
import 'package:buzzer_app/features/restaurant/presentation/screens/widgets/star_rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StackBackground(
      height: MediaQuery.of(context).size.height * .5,
      backgroundColor: Colors.grey.shade200,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            title: Text('Cart'),
          ),
          body: BlocConsumer<CartBloc, CartState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is CartLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CartLoaded) {
                if (state.items.isEmpty) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: Center(
                      child: Text('There is no Items in Cart try add one'),
                    ),
                  );
                } else {
                  return Container(
                    color: Colors.grey.shade200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.items.first.restaurantName,
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
                        ),
                        ...List.generate(
                          state.items.length,
                          (index) {
                            return BasketItemWidget(
                                cartItem: state.items[index]);
                          },
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order Summary',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black26,
                                  ),
                                  SummaryRow(
                                      title: 'Subtotal:', value: 'SAR 300'),
                                  SummaryRow(title: 'VAT:', value: 'SAR 20'),
                                  SummaryRow(
                                      title: 'Total:',
                                      value: 'SAR 320',
                                      isTotal: true),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              } else {
                if (state is CartError) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: Center(
                      child: Text('error : ${state.message}'),
                    ),
                  );
                }
                return Center(
                  child: Text('data'),
                );
              }
            },
          )),
    );
  }
}

class BasketItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const BasketItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: .5,
              blurRadius: 10,
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(cartItem.imageUrl),
                  radius: 40,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          StarRating(rate: 4),
                          Text(
                            cartItem.rate.toString(),
                            style: TextStyle(
                                color: Colors.black26,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              context
                                  .read<CartBloc>()
                                  .add(RemoveCartItemEvent(cartItem.id));
                            },
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            cartItem.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'View Details',
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            SummaryRow(
              title: 'Price:',
              value: 'EGP ${cartItem.price}',
              padding: EdgeInsets.symmetric(vertical: 0),
            ),
            SummaryRow(
              title: 'Quantity:',
              value: 'x${cartItem.quantity}',
              padding: EdgeInsets.symmetric(vertical: 0),
            ),
            SummaryRow(
              title: 'Subtotal',
              value: 'SAR ${cartItem.total}',
              padding: EdgeInsets.symmetric(vertical: 0),
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isTotal;
  final EdgeInsets padding;

  const SummaryRow({
    super.key,
    required this.title,
    required this.value,
    this.isTotal = false,
    this.padding = const EdgeInsets.symmetric(vertical: 4),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black45,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal ? Colors.red : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
