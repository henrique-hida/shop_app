import 'package:flutter/cupertino.dart';
import 'package:shop_app/widgets/product_card.dart';
import 'package:shop_app/pages/product_page.dart';
import '../colors.dart';
import '../global_vars.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart' as bsh;

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  // List of category filters
  final List<String> filters = ['All', 'Judogi', 'Obi', 'Rashguard', 'Accessories'];
  String selectedFilter = 'All'; 
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = List.from(products);
    searchController.addListener(filterProducts);
  }

  @override
  void dispose() {
    searchController.removeListener(filterProducts);
    searchController.dispose();
    super.dispose();
  }

  // Filter search function
  void filterProducts() {
    String query = searchController.text.toLowerCase();

    final updatedList = products.where((product) {
      final productTitle = (product['title'] as String).toLowerCase();
      final productCategory = (product['category'] as String).toLowerCase();

      final matchesQuery = productTitle.contains(query);
      final matchesFilter = selectedFilter == 'All' || productCategory == selectedFilter.toLowerCase();

      return matchesQuery && matchesFilter;
    }).toList();

    setState(() {
      filteredProducts = updatedList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Title
            const Text(
              'Judo Collection',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 15),

            // Search Field
            SizedBox(
              height: 50,
              child: CupertinoTextField(
                controller: searchController,
                autocorrect: true,
                placeholder: 'Search',
                style: const TextStyle(fontWeight: FontWeight.w400),
                decoration: const bsh.BoxDecoration(
                  color: CoHida.neuwhite,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  boxShadow: [
                    bsh.BoxShadow(blurRadius: 10.0, offset: Offset(0, -5), color: CoHida.wglow, inset: true),
                    bsh.BoxShadow(blurRadius: 10.0, offset: Offset(0, 5), color: CoHida.wshadow, inset: true),
                  ],
                ),
                prefix: const Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0,0),
                  child: Icon(CupertinoIcons.search,
                    color: CoHida.wshadow,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Filters
            SizedBox(
              height: 40,
              child: ListView.builder(
                clipBehavior: Clip.none,
                itemCount: filters.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        if (selectedFilter != filter) {
                          setState(() {
                            selectedFilter = filter;
                          });
                          filterProducts();
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: selectedFilter == filter ? CoHida.green : CoHida.neuwhite,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          boxShadow: const [
                            BoxShadow(blurRadius: 10.0, offset: Offset(-5, -5), color: CoHida.wglow),
                            BoxShadow(blurRadius: 10.0, offset: Offset(5, 5), color: CoHida.wshadow),
                          ],
                        ),
                        child: Text(
                          filter,
                          style: TextStyle(
                            fontSize: 16,
                            color: selectedFilter == filter ? CoHida.dgreen : CoHida.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 15),

            // Product List
            Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeBottom: true,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) {
                              return ProductPage(product: product);
                            },
                          ),
                        );
                      },
                      child: ProductCard(
                        title: product['title'] as String,
                        price: product['price'] as String,
                        image: product['imageUrl'] as String,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
