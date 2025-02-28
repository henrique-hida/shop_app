import 'package:flutter/cupertino.dart';
import '../colors.dart';
import '../providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context).cart;
    
    return CupertinoPageScaffold(
      // Top Navigation Bar
      navigationBar: CupertinoNavigationBar(
        border: Border.all(color: CoHida.transparent),
        backgroundColor: CoHida.neuwhite,
        middle: const Text(
          'Cart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      backgroundColor: CoHida.neuwhite,
      // List of cart items
      child: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final cartItem = cart[index];
          
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                ClipOval(
                  child: Image.asset(
                    cartItem['imageUrl'] as String,
                    width: 50.0, 
                    height: 50.0, 
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                // Product details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItem['title'].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Size: ${cartItem['size']}',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Delete product button
                GestureDetector(
                  onTap: () {
                    showCupertinoDialog(
                      context: context, 
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: const Text('Are you sure?'),
                          actions: [
                            // Cancel button
                            CupertinoButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            // Confirm deletion button
                            CupertinoButton(
                              child: const Text('Yes'),
                              onPressed: () {
                                Provider.of<CartProvider>(context, listen: false)
                                    .removeProduct(cartItem);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Icon(
                    CupertinoIcons.trash_fill,
                    size: 25,
                    color: CoHida.wshadow,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
