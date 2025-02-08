import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../colors.dart';
import '../providers/cart_provider.dart';

class ProductPage extends StatefulWidget {
  // Product details passed as a map
  final Map<String, dynamic> product;

  const ProductPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  dynamic selectedSize;

  // Handles adding a product to the cart
  void onTap() {
    if (selectedSize == null) {
      showCupertinoSnackBar(context, 'Please select a size');
    } else {
      final cartItem = {
        'id': widget.product['id'],
        'title': widget.product['title'],
        'price': widget.product['price'],
        'imageUrl': widget.product['imageUrl'],
        'size': selectedSize,
      };

      Provider.of<CartProvider>(context, listen: false).addProduct(cartItem);

      showCupertinoSnackBar(context, 'Product added successfully');
    }
  }

  // Notification function
  void showCupertinoSnackBar(BuildContext context, String message) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
        return CupertinoAlertDialog(
          title: Text(message),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CoHida.neuwhite,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Product Details Header
              const Center(
                child: Text(
                  'Details',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Product Title
              Text(
                widget.product['title'] as String,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Spacer(),
              // Product Image
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  widget.product['imageUrl'] as String,
                  height: 250,
                ),
              ),
              const Spacer(flex: 2),
              // Bottom Product Information and Actions
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: CoHida.neublack,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Product Price
                    Text(
                      '${widget.product['price']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: CoHida.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Size Selection
                    SizedBox(
                      height: 50,
                      child: Center(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: constraints.maxWidth,
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                clipBehavior: Clip.none,
                                scrollDirection: Axis.horizontal,
                                itemCount: (widget.product['sizes'] as List<String>).length,
                                itemBuilder: (context, index) {
                                  final size = (widget.product['sizes'] as List<String>)[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedSize = size;
                                        });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                                        decoration: BoxDecoration(
                                          color: selectedSize == size ? CoHida.green : CoHida.neublack,
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 10.0,
                                              offset: Offset(-5, -5),
                                              color: CoHida.bglow,
                                            ),
                                            BoxShadow(
                                              blurRadius: 10.0,
                                              offset: Offset(5, 5),
                                              color: CoHida.bshadow,
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          size.toString(),
                                          style: TextStyle(
                                            color: selectedSize == size ? CoHida.dgreen : CoHida.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Add to Cart Button
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CupertinoButton(
                        child: const Text(
                          'Add to cart',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CoHida.dgreen,
                          ),
                        ),
                        onPressed: onTap,
                        color: CoHida.green,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
