import 'package:buzzer_app/core/widgets/stack_background.dart';
import 'package:buzzer_app/features/notifications/presentation/widgets/cart_section.dart';
import 'package:buzzer_app/features/notifications/presentation/widgets/order_section.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StackBackground(
      height: MediaQuery.of(context).size.height * .4,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'Notifications',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
        body: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          color: Colors.grey.shade200,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListView(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cart',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(
                        color: Colors.black26,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * .3,
                        child: CartSection(),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Orders',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(
                      color: Colors.black26,
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * .3,
                        child: OrderSection()),
                  ],
                )),

                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}
