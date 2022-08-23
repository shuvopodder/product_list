import 'package:flutter/material.dart';
import 'package:product_list/singeproduct.dart';
import 'package:provider/provider.dart';

import 'DetailScreen.dart';
import 'getData.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  @override
  void initState() {
    // TODO: implement initState
    var fetchData = Provider.of<getData>(context, listen: false);
    fetchData.getListData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
//    context.read<getData>().getListData();

    return Scaffold(
      appBar:AppBar(
        title: Text("List View Page"),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Center(
          child: Consumer<getData>(
            builder: (context, value, child) => value.data.isEmpty
                ? const CircularProgressIndicator()
                : ListView.builder(

              itemCount: value.data.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => DetailScreen(
                          image: value.data[index].image,
                          price: value.data[index].price,
                          name: value.data[index].title,
                          category:value.data[index].category,
                          description: value.data[index].description,

                        rating: value.data[index].rate,
                        count : value.data[index].count,
                      ),
                    ),
                  );
                },
                 child: SingleProduct(
                   image:value.data[index].image,
                   title:value.data[index].title,
                   price:value.data[index].price,
                 )
                );
              },
            ),
          ),
          ),
        ),
    );
  }
  Future<void> _onRefresh() async{
    await Future.delayed(const Duration(seconds: 2));
    await context.read<getData>().getListData();

    setState(() {

    });
  }
}
