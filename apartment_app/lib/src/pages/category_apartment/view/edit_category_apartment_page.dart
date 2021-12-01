import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/category_apartment/firebase/fb_category_apartment.dart';
import 'package:apartment_app/src/pages/category_apartment/model/category_apartment_model.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/appbars/my_app_bar.dart';
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
    _amountDwellerController.text = widget.categoryApartment.amountDweller.toString();
    _priceController.text = widget.categoryApartment.price.toString();
    _rentalPriceController.text = widget.categoryApartment.rentalPrice.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar("Sửa loại căn hộ"),
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
              SizedBox(height: 10,),
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
              SizedBox(height: 10,),
              _priceTextField(),

              //Giá thuê
              SizedBox(height: 10,),
              TitleInfoNotNull(text: "Giá thuê (VNĐ)"),
              SizedBox(height: 10,),
              _rentalPriceTextField(),
              SizedBox(height: 30,),

              MainButton(
                name: "Sửa",
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
