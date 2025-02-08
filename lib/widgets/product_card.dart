import 'package:flutter/cupertino.dart';
import '../colors.dart';

class ProductCard extends StatelessWidget {
  // Product attributes
  final String title;
  final String price;
  final String image;

  const ProductCard({
    Key? key,
    required this.title,
    required this.price,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20), 
      decoration: BoxDecoration(
        color: CoHida.neuwhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10.0,
            offset: Offset(-10, -10),
            color: CoHida.wglow, 
          ),
          BoxShadow(
            blurRadius: 10.0,
            offset: Offset(10, 10),
            color: CoHida.wshadow,
          ),
        ],
      ),
      padding: const EdgeInsets.all(18.0), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Title
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 5), 
          // Product Price
          Text(
            price,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 5),
          // Product Image
          Center(
            child: Image.asset(
              image,
              height: 175,
            ),
          ),
        ],
      ),
    );
  }
}
