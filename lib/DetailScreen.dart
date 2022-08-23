
import 'package:flutter/material.dart';
import 'package:product_list/ProductListPage.dart';
import 'package:provider/provider.dart';


class DetailScreen extends StatefulWidget {
  final String image;
  final String title;
  final num price, rating;
  final int count;
  final String description;
  final String category;
  const DetailScreen({required this.image, required this.title, required this.price, required this.category,  required this.description, required this.rating, required this.count});
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {


  final TextStyle myStyle = const TextStyle(
    fontSize: 18,
  );
  final now = DateTime.now();


  Widget _buildImage() {
    return Center(
      child: Container(
        width: 380,
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(13),
            child: Container(
              height: 260,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(widget.image),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameToDescriptionPart() {
    return Container(
      height: 100,
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //title

              Text(widget.title,style: const TextStyle(fontWeight: FontWeight.bold),),

              //handle independent day's discount
              now.month==DateTime.march
                  ? Text("\$ ${widget.price.toString()}", style: const TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.lineThrough,),)
                  : Text("\$ ${widget.price.toString()}", style: const TextStyle(
                    color: Color(0xff9b96d6),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),),
              now.month==DateTime.march
                  ? Text("\$ ${widget.price-widget.price*(26/100)}", style: const TextStyle(
                    color: Color(0xff9b96d6),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),)
                  : Container() ,

              //category
              Text(widget.category, style: myStyle),

            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDiscription() {
    return Container(
      height: 170,
      child: Wrap(
        children:  <Widget>[
          Text(widget.description,
            style: const TextStyle(fontSize: 16),
          ),
          Text("\nrating: "+widget.rating.toString(),
            style: const TextStyle(fontSize: 18,
                fontWeight: FontWeight.bold)
          ),
          Text("\ncount: "+widget.count.toString(),
              style:  const TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Detail Page", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => const ProductListPage(),
              ),
            );
          },
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            _buildImage(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildNameToDescriptionPart(),
                  _buildDiscription(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}