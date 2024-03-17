import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class CardSwiperWidget extends StatelessWidget {
  final List<String> imageUrls;

  const CardSwiperWidget({Key? key, required this.imageUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // 设置轮播图高度
      child: Swiper(
        itemCount: imageUrls.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.network(
              imageUrls[index],
              fit: BoxFit.cover,
            ),
          );
        },
        pagination: SwiperPagination(), // 添加默认的分页指示器
      ),
    );
  }
}
