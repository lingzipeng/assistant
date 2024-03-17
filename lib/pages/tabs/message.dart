import 'package:flutter/material.dart';
import '../../component/card_swiper_widget.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final List<String> imageUrls = [
    'https://i0.hdslb.com/bfs/archive/1db01c0402fcb4f55ae96017b0f9986ebee219f0.jpg',
    'https://i0.hdslb.com/bfs/archive/3a1feb2169c236c67b86f8b231a2471780703c4b.jpg@672w_378h_1c_!web-home-common-cover',
    'https://i0.hdslb.com/bfs/archive/f148be797fee7936cd18304a53fafe99860fc5d1.jpg@672w_378h_1c_!web-home-common-cover',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Swiper Example'),
      ),
      body: CardSwiperWidget(imageUrls: imageUrls),
    );
  }
}
