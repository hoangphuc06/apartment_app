import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/category_apartment/firebase/fb_category_apartment.dart';
import 'package:apartment_app/src/pages/category_apartment/model/category_apartment_model.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:flutter/material.dart';

class EditCategoryApartmentPage extends StatefulWidget {
  //const EditCategoryApartmentPage({Key? key}) : super(key: key);
  final CategoryApartment categoryApartment;
  EditCategoryApartmentPage(this.categoryApartment);

  @override
  _EditCategoryApartmentPageState createState() => _EditCategoryApartmentPageState();
}

class _EditCategoryApartmentPageState extends State<EditCategoryApartmentPage> {

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
  void initState() {
    // TODO: implement initState
    super.initState();
    initInfo();
  }

  void initInfo() {
    _nameController.text = widget.categoryApartment.name.toString();
    _areaController.text = widget.categoryApartment.area.toString();
    _amountBedroomController.text = widget.categoryApartment.amountBedroom.toString();
    _amountWcController.text = widget.categoryApartment.amountWc.toString();
    _amountDwellerController.text = widget.categoryApartment.amountWc.toString();
    _priceController.text = widget.categoryApartment.price.toString();
    _rentalPriceController.text = widget.categoryApartment.rentalPrice.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: myGreen,
        elevation: 0,
        centerTitle: true,
        title:  Text(
          "Sửa loại căn hộ",
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
                      _priceTextField(),

                      //Giá thuê
                      SizedBox(height: 20,),
                      TitleInfoNotNull(text: "Giá thuê (VNĐ)"),
                      _rentalPriceTextField(),

                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
              // Nút bấm
              SizedBox(height: 10,),
              MainButton(
                name: "Thêm",
                onpressed: _editCategoty,
              ),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }

  void _editCategoty() {
    if (_formkey.currentState!.validate()) {
      categoryApartmentFB.update(
          widget.categoryApartment.id.toString(),
          _nameController.text,
          _areaController.text,
          _amountBedroomController.text,
          _amountWcController.text,
          _amountDwellerController.text,
          _priceController.text,
          _rentalPriceController.text
      )
          .then((value) => {
            Navigator.pop(
                context,
                CategoryApartment(
                  id: widget.categoryApartment.id.toString(),
                  name: _nameController.text,
                  area: _areaController.text,
                  amountBedroom: _amountBedroomController.text,
                  amountWc: _amountWcController.text,
                  amountDweller: _amountDwellerController.text,
                  price: _priceController.text,
                  rentalPrice: _rentalPriceController.text
                )),
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

  _priceTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: _priceController,
    decoration: InputDecoration(
      hintText: "Nhập giá bán",
    ),
    keyboardType: TextInputType.number,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập giá";
      }
      return null;
    },
  );

  _rentalPriceTextField() => TextFormField(
    style: MyStyle().style_text_tff(),
    controller: _rentalPriceController,
    decoration: InputDecoration(
      hintText: "Nhập giá thuê",
    ),
    keyboardType: TextInputType.number,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập giá";
      }

      return null;
    },
  );
}
