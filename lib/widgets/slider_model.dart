import 'package:flutter/material.dart';


class SliderModel{

  String? imageAssetPath;
  String? title;
  String? desc;

  SliderModel({this.imageAssetPath,this.title,this.desc});

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getImageAssetPath(){
    return imageAssetPath!;
  }

  String getTitle(){
    return title!;
  }

  String getDesc(){
    return desc!;
  }

}

class SlideTile extends StatelessWidget {
  String? imagePath, title, desc;

  SlideTile({this.imagePath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imagePath!),
          SizedBox(
            height: 40,
          ),
          Text(title.toString(), textAlign: TextAlign.center,style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20
          ),),
          SizedBox(
            height: 20,
          ),
          Text(desc!, textAlign: TextAlign.center,style: TextStyle(
          fontWeight: FontWeight.w500,
              fontSize: 14))
        ],
      ),
    );
  }
}

List<SliderModel> getSlides(){

  List<SliderModel> slides = <SliderModel>[];
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc("Lớp vỏ bằng nhựa PVC chắc chắn, chống nước, dễ dàng tháo lắp thay thế");
  sliderModel.setTitle("Đơn giản");
  sliderModel.setImageAssetPath("assets/module_pas.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc("Thiết kế nhỏ gọn nhưng vẫn đầy đủ các chức năng : Camera, cảm biến, thời gian thực ,...");
  sliderModel.setTitle("Nhỏ gọn");
  sliderModel.setImageAssetPath("assets/board_pas.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc("Sử dụng ngay tài khoản google trên diện thoại để đăng nhập mà không cần nhiều bước");
  sliderModel.setTitle("Đăng nhập với tài khoản Google");
  sliderModel.setImageAssetPath("assets/google.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}