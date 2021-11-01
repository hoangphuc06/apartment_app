import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/category_apartment/firebase/fb_category_apartment.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:flutter/material.dart';

class AddCategoryApartmentPage extends StatefulWidget {
  const AddCategoryApartmentPage({Key? key}) : super(key: key);

  @override
  _AddCategoryApartmentPageState createState() => _AddCategoryApartmentPageState();
}

class _AddCategoryApartmentPageState extends State<AddCategoryApartmentPage> {

  final _formkey = GlobalKey<FormState>();

  CategoryApartmentFB categoryApartmentFB = new CategoryApartmentFB();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _amountBedroomController = TextEditingController();
  final TextEditingController _amountWcController = TextEditingController();
  final TextEditingController _amountDwellerController = TextEditingController();
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  final TextEditingController _minRentalPriceController = TextEditingController();
  final TextEditingController _maxRentalPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: myGreen,
        elevation: 0,
        centerTitle: true,
        title:  Text(
          "Thêm loại căn hộ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Card(
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),

                      Text("THÔNG TIN CHI TIẾT", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),

                      // Tên loại căn hộ
                      SizedBox(height: 20,),
                      TitleInfoNotNull(text: "Tên loại căn hộ"),
                      _nameTextField(),

                      // Diện tích căn hộ
                      SizedBox(height: 20,),
                      TitleInfoNotNull(text: "Diện tích (m2)"),
                      _areaTextField(),

                      //Số lượng phòng ngủ
                      SizedBox(height: 20,),
                      TitleInfoNotNull(text: "Số phòng ngủ"),
                      _amountBedroomTextField(),

                      //Số lượng phòng vệ sinh
                      SizedBox(height: 20,),
                      TitleInfoNotNull(text: "Số phòng vệ sinh"),
                      _amountWcTextField(),

                      //Số lượng người ở
                      SizedBox(height: 20,),
                      TitleInfoNotNull(text: "Số lượng người ở"),
                      _amountDwellerTextField(),

                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),

                      Text("GIÁ CẢ GIAO ĐỘNG", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),

                      //Giá bán
                      SizedBox(height: 20,),
                      TitleInfoNotNull(text: "Giá bán (VNĐ)"),
                      Row(children: [
                        Container(
                            width: 130,
                            child: _minPriceTextField()
                        ),
                        Spacer(),
                        Text("-", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),),
                        Spacer(),
                        Container(
                            width: 130,
                            child: _maxPriceTextField()
                        ),
                      ],),

                      //Giá thuê
                      SizedBox(height: 20,),
                      TitleInfoNotNull(text: "Giá thuê (VNĐ)"),
                      Row(children: [
                        Container(
                            width: 130,
                            child: _minRentalPriceTextField()
                        ),
                        Spacer(),
                        Text("-", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),),
                        Spacer(),
                        Container(
                            width: 130,
                            child: _maxRentalPriceTextField()
                        ),
                      ],),

                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
              // Nút bấm
              SizedBox(height: 10,),
              MainButton(
                name: "Thêm",
                onpressed: _addCategoty,
              ),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }

  void _addCategoty() {
    if (_formkey.currentState!.validate()) {
      categoryApartmentFB.add(
          _nameController.text,
          _areaController.text,
          _amountBedroomController.text,
          _amountWcController.text,
          _amountDwellerController.text,
          _minPriceController.text,
          _maxPriceController.text,
          _minRentalPriceController.text,
          _maxRentalPriceController.text)
          .then((value) => {
         Navigator.pop(context),
      });
    }
  }

  _nameTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: _nameController,
    decoration: InputDecoration(
      hintText: "Căn hộ loại A...",
    ),
    keyboardType: TextInputType.name,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập tên";
      }
      return null;
    },
  );

  _areaTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: _areaController,
    decoration: InputDecoration(
      hintText: "50, 60...",
    ),
    keyboardType: TextInputType.number,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập diện tích";
      }
      return null;
    },
  );

  _amountBedroomTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: _amountBedroomController,
    decoration: InputDecoration(
      hintText: "1, 2...",
    ),
    keyboardType: TextInputType.number,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập số phòng ngủ";
      }
      return null;
    },
  );

  _amountWcTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: _amountWcController,
    decoration: InputDecoration(
      hintText: "1, 2...",
    ),
    keyboardType: TextInputType.number,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập số phòng vệ sinh";
      }
      return null;
    },
  );

  _amountDwellerTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: _amountDwellerController,
    decoration: InputDecoration(
      hintText: "1, 2...",
    ),
    keyboardType: TextInputType.number,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập số lượng người ở";
      }
      return null;
    },
  );

  _minPriceTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: _minPriceController,
    decoration: InputDecoration(
      hintText: "Từ",
    ),
    keyboardType: TextInputType.number,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập giá";
      }
      return null;
    },
  );

  _maxPriceTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: _maxPriceController,
    decoration: InputDecoration(
      hintText: "Đến",
    ),
    keyboardType: TextInputType.number,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập giá";
      }

      if (_minPriceController.text.isEmpty) {
        return null;
      }

      double min = double.parse(_minPriceController.text);
      double max = double.parse(val.toString());

      if (min >= max) {
        return "Giá không phù hợp";
      }

      return null;
    },
  );

  _minRentalPriceTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: _minRentalPriceController,
    decoration: InputDecoration(
      hintText: "Từ",
    ),
    keyboardType: TextInputType.number,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập giá";
      }
      return null;
    },
  );

  _maxRentalPriceTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: _maxRentalPriceController,
    decoration: InputDecoration(
      hintText: "Đến",
    ),
    keyboardType: TextInputType.number,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập giá";
      }

      if (_minRentalPriceController.text.isEmpty) {
        return null;
      }

      double min = double.parse(_minRentalPriceController.text);
      double max = double.parse(val.toString());

      if (min >= max) {
        return "Giá không phù hợp";
      }

      return null;
    },
  );
}
