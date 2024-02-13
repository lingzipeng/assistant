import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchBox(
            isSearching: _isSearching,
            onChanged: (value) {
              setState(() {
                _isSearching = value.isNotEmpty;
              });
            },
          ),
          const Expanded(
            child: Center(
              child: Text(
                '这里是首页内容',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
        ],
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
              suffixIcon: isSearching ? IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                },
              ) : null,
            ),
          ),
        ),
      ),
    );
  }
}
