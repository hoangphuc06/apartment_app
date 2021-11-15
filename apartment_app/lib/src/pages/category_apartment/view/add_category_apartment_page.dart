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
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _rentalPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: myGreen,
        elevation: 0,
        centerTitle: true,
        title:  Text(
          "Thêm loại căn hộ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title("Thông tin chi tiết"),

              // Tên loại căn hộ
              SizedBox(height: 10,),
              TitleInfoNotNull(text: "Tên loại căn hộ"),
              SizedBox(height: 10,),
              _nameTextField(),

              // Diện tích căn hộ
              SizedBox(height: 20,),
              TitleInfoNotNull(text: "Diện tích (m2)"),
              SizedBox(height: 10,),
              _areaTextField(),

              //Số lượng phòng ngủ
              SizedBox(height: 10,),
              TitleInfoNotNull(text: "Số phòng ngủ"),
              SizedBox(height: 10,),
              _amountBedroomTextField(),

              //Số lượng phòng vệ sinh
              SizedBox(height: 10,),
              TitleInfoNotNull(text: "Số phòng vệ sinh"),
              SizedBox(height: 10,),
              _amountWcTextField(),

              //Số lượng người ở
              SizedBox(height: 10,),
              TitleInfoNotNull(text: "Số lượng người ở"),
              SizedBox(height: 10,),
              _amountDwellerTextField(),
              SizedBox(height: 30,),

              _title("Giá cả giao động"),

              //Giá bán
              SizedBox(height: 10,),
              TitleInfoNotNull(text: "Giá bán (VNĐ)"),
              _priceTextField(),

              //Giá thuê
              SizedBox(height: 10,),
              TitleInfoNotNull(text: "Giá thuê (VNĐ)"),
              _rentalPriceTextField(),

              // Nút bấm
              SizedBox(height: 30,),
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
          _priceController.text,
          _rentalPriceController.text
      )
          .then((value) => {
         Navigator.pop(context),
      });
    }
  }

  _nameTextField() => Container(
    padding: MyStyle().padding_container_tff(),
    decoration: MyStyle().style_decoration_container(),
    child: TextFormField(
      style: MyStyle().style_text_tff(),
      controller: _nameController,
      decoration: MyStyle().style_decoration_tff("Căn hộ loại A"),
      keyboardType: TextInputType.name,
      validator: (val) {
        if (val!.isEmpty) {
          return "Vui lòng nhập tên";
        }
        return null;
      },
    ),
  );

  _areaTextField() => Container(
    padding: MyStyle().padding_container_tff(),
    decoration: MyStyle().style_decoration_container(),
    child: TextFormField(
      style: MyStyle().style_text_tff(),
      controller: _areaController,
      decoration: MyStyle().style_decoration_tff("50, 60,..."),
      keyboardType: TextInputType.number,
      validator: (val) {
        if (val!.isEmpty) {
          return "Vui lòng nhập diện tích";
        }
        return null;
      },
    ),
  );

  _amountBedroomTextField() => Container(
    padding: MyStyle().padding_container_tff(),
    decoration: MyStyle().style_decoration_container(),
    child: TextFormField(
      style: MyStyle().style_text_tff(),
      controller: _amountBedroomController,
      decoration: MyStyle().style_decoration_tff("1, 2,..."),
      keyboardType: TextInputType.number,
      validator: (val) {
        if (val!.isEmpty) {
          return "Vui lòng nhập số phòng ngủ";
        }
        return null;
      },
    ),
  );

  _amountWcTextField() => Container(
    padding: MyStyle().padding_container_tff(),
    decoration: MyStyle().style_decoration_container(),
    child: TextFormField(
      style: MyStyle().style_text_tff(),
      controller: _amountWcController,
      decoration: MyStyle().style_decoration_tff("1, 2,..."),
      keyboardType: TextInputType.number,
      validator: (val) {
        if (val!.isEmpty) {
          return "Vui lòng nhập số phòng vệ sinh";
        }
        return null;
      },
    ),
  );

  _amountDwellerTextField() => Container(
    padding: MyStyle().padding_container_tff(),
    decoration: MyStyle().style_decoration_container(),
    child: TextFormField(
      style: MyStyle().style_text_tff(),
      controller: _amountDwellerController,
      decoration: MyStyle().style_decoration_tff("1, 2,..."),
      keyboardType: TextInputType.number,
      validator: (val) {
        if (val!.isEmpty) {
          return "Vui lòng nhập số lượng người ở";
        }
        return null;
      },
    ),
  );

  _priceTextField() => Container(
    padding: MyStyle().padding_container_tff(),
    decoration: MyStyle().style_decoration_container(),
    child: TextFormField(
      style: MyStyle().style_text_tff(),
      controller: _priceController,
      decoration: MyStyle().style_decoration_tff("Nhập giá bán"),
      keyboardType: TextInputType.number,
      validator: (val) {
        if (val!.isEmpty) {
          return "Vui lòng nhập giá";
        }
        return null;
      },
    ),
  );

  _rentalPriceTextField() => Container(
    padding: MyStyle().padding_container_tff(),
    decoration: MyStyle().style_decoration_container(),
    child: TextFormField(
      style: MyStyle().style_text_tff(),
      controller: _rentalPriceController,
      decoration: MyStyle().style_decoration_tff("Nhập giá thuê"),
      keyboardType: TextInputType.number,
      validator: (val) {
        if (val!.isEmpty) {
          return "Vui lòng nhập giá";
        }

        return null;
      },
    ),
  );
  _title(String text) => Text(
    text,
    style: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontWeight: FontWeight.bold
    ),
  );
}
