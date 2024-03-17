import 'package:flutter/material.dart';
import '../../component/card_swiper_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSearching = false;
  final List<String> imageUrls = [
    'https://i0.hdslb.com/bfs/archive/cb0c06e794bcc2bc203aae7c3c3db6042620f181.jpg',
    'https://i0.hdslb.com/bfs/archive/3a1feb2169c236c67b86f8b231a2471780703c4b.jpg',
    'https://i0.hdslb.com/bfs/archive/f148be797fee7936cd18304a53fafe99860fc5d1.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchBox(
              isSearching: _isSearching,
              onChanged: (value) {
                setState(() {
                  _isSearching = value.isNotEmpty;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: CardSwiperWidget(imageUrls: imageUrls),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(6, (index) {
                  return Center(
                    child: GridItem(index + 1),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final int index;

  GridItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        border: Border.all(color: Colors.white, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          'Item $index',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  final bool isSearching;
  final ValueChanged<String>? onChanged;

  const SearchBox({
    Key? key,
    required this.isSearching,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[200],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: '搜索...',
              border: InputBorder.none,
              icon: isSearching ? null : Icon(Icons.search),
              suffixIcon: isSearching
                  ? IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {},
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
