import 'package:flutter/cupertino.dart';
import '../colors.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String image;

  const ProductCard({ Key? key,
    required this.title, 
    required this.price,
    required this.image,
  
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: CoHida.neuwhite,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
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
          Text(title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            price,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            ),
          const SizedBox(height: 5),
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