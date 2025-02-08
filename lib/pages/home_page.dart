import 'package:flutter/cupertino.dart';
import 'package:shop_app/pages/cart_page.dart';
import 'package:shop_app/widgets/product_list.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart' as bsh;
import '../colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;

  // Lista de páginas
  final List<Widget> pages = const [
    ProductList(), 
    CartPage(),
  ];

  // Função de navegação entre as páginas
  void onBottomNavTapped(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CoHida.neuwhite,
      child: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: currentPage,
              children: pages,
            ),
          ),
          // Show selected page
          // Bottom Navigation Bar
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: CoHida.neuwhite,
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [
                bsh.BoxShadow(
                  blurRadius: 10.0,
                  offset: Offset(0, -5),
                  color: CoHida.wshadow,
                  inset: true,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => onBottomNavTapped(0),
                  child: Icon(
                    CupertinoIcons.home,
                    size: 30,
                    color: currentPage == 0 ? CoHida.green : CoHida.black,
                  ),
                ),
                GestureDetector(
                  onTap: () => onBottomNavTapped(1),
                  child: Icon(
                    CupertinoIcons.shopping_cart,
                    size: 30,
                    color: currentPage == 1 ? CoHida.green : CoHida.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
