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
  // Definindo os filtros
  final List<String> filters = ['All', 'Judogi', 'Obi', 'Rasguard', 'Accesories'];
  String selectedFilter = 'All'; 

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Título
            const Text(
              'Judo Collection',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            // Campo de pesquisa
            const SizedBox(height: 15),
            const SizedBox(
              height: 50,
              child: CupertinoTextField(
                prefix: Padding(
                  padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
                  child: Icon(
                    CupertinoIcons.search,
                    size: 20,
                    color: CoHida.wshadow,
                  ),
                ),
                placeholder: 'Search',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                decoration: bsh.BoxDecoration(
                  color: CoHida.neuwhite,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  boxShadow: [
                    bsh.BoxShadow(
                      blurRadius: 10.0,
                      offset: Offset(0, -5),
                      color: CoHida.wglow,
                      inset: true,
                    ),
                    bsh.BoxShadow(
                      blurRadius: 10.0,
                      offset: Offset(0, 5),
                      color: CoHida.wshadow,
                      inset: true,
                    ),
                  ],
                ),
              ),
            ),
            // Filtros
            const SizedBox(height: 15),
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
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = filter; // Atualizando o filtro selecionado
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: selectedFilter == filter
                              ? CoHida.green
                              : CoHida.neuwhite,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 10.0,
                              offset: Offset(-5, -5),
                              color: CoHida.wglow,
                            ),
                            BoxShadow(
                              blurRadius: 10.0,
                              offset: Offset(5, 5),
                              color: CoHida.wshadow,
                            ),
                          ],
                        ),
                        child: Text(
                          filter,
                          style: TextStyle(
                            fontSize: 16,
                            color: selectedFilter == filter
                                ? CoHida.dgreen
                                : CoHida.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Lista de produtos
            const SizedBox(height: 15),
            Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeBottom: true, // Remove padding extra na parte inferior
                child: ListView.builder(
                  padding: EdgeInsets.zero, // Remove qualquer padding extra
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    if (selectedFilter == 'All' || product['company'] == selectedFilter) {
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
                    }
                    return Container();
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
