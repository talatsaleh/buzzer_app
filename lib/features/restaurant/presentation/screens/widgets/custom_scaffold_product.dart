import 'package:buzzer_app/core/widgets/stack_background.dart';
import 'package:flutter/material.dart';

class CustomScaffoldProduct extends StatefulWidget {
  const CustomScaffoldProduct({
    super.key,
    required this.appBar,
    required this.child,
    required this.addToCart,
    required this.height,
  });

  final AppBar appBar;
  final Widget child;
  final double height;
  final Function(int quantity) addToCart;

  @override
  State<CustomScaffoldProduct> createState() => _CustomScaffoldProductState();
}

class _CustomScaffoldProductState extends State<CustomScaffoldProduct> {
  int quantity = 0;

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    setState(() {
      quantity--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StackBackground(
        height: widget.height,
        backgroundColor: Colors.grey.shade200,
        child: Scaffold(
          floatingActionButtonLocation: quantity == 0
              ? FloatingActionButtonLocation.miniStartFloat
              : FloatingActionButtonLocation.centerDocked,
          floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,
          floatingActionButton: quantity == 0
              ? FloatingActionButton(
                  onPressed: increaseQuantity,
                  backgroundColor: Colors.amber,
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 1)
                    ],
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, color: Colors.black),
                            onPressed: decreaseQuantity,
                          ),
                          Text(
                            quantity.toString().padLeft(2, '0'),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, color: Colors.black),
                            onPressed: increaseQuantity,
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          widget.addToCart(quantity);
                          setState(() {
                            quantity = 0;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'ADD TO BASKET',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          backgroundColor: Colors.transparent,
          appBar: widget.appBar,
          body: widget.child,
        ));
  }
}
