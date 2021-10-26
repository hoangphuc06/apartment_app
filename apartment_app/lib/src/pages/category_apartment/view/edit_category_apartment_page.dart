import 'package:apartment_app/src/pages/category_apartment/firebase/fb_category_apartment.dart';
import 'package:apartment_app/src/style/my_style.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_app/src/widgets/title/title_info_not_null.dart';
import 'package:flutter/material.dart';

class EditCategoryApartmentPage extends StatefulWidget {
  //const EditCategoryApartmentPage({Key? key}) : super(key: key);
  final String id;
  EditCategoryApartmentPage(this.id);

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
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  final TextEditingController _minRentalPriceController = TextEditingController();
  final TextEditingController _maxRentalPriceController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initInfo();
  }

  void initInfo() {
    categoryApartmentFB.collectionReference.doc(widget.id).get().then((value) => {
      _nameController.text = value['name'],
      _areaController.text = value['area'],
      _amountBedroomController.text = value['amountBedroom'],
      _amountWcController.text = value['amountWc'],
      _amountDwellerController.text = value['amountDweller'],
      _minPriceController.text = value['minPrice'],
      _maxPriceController.text = value['maxPrice'],
      _minRentalPriceController.text = value['minRentalPrice'],
      _maxRentalPriceController.text = value['maxRentalPrice'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Sửa loại căn hộ", ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              // Tên loại căn hộ
              TitleInfoNotNull(text: "Tên loại căn hộ"),
              _nameTextField(),

              // Diện tích căn hộ
              SizedBox(height: 30,),
              TitleInfoNotNull(text: "Diện tích (m2)"),
              _areaTextField(),

              //Số lượng phòng ngủ
              SizedBox(height: 30,),
              TitleInfoNotNull(text: "Số phòng ngủ"),
              _amountBedroomTextField(),

              //Số lượng phòng vệ sinh
              SizedBox(height: 30,),
              TitleInfoNotNull(text: "Số phòng vệ sinh"),
              _amountWcTextField(),

              //Số lượng người ở
              SizedBox(height: 30,),
              TitleInfoNotNull(text: "Số lượng người ở"),
              _amountDwellerTextField(),

              //Giá bán
              SizedBox(height: 30,),
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
              SizedBox(height: 30,),
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

              // Nút bấm
              SizedBox(height: 30,),
              MainButton(
                name: "Sửa",
                onpressed: _editCategoty,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _editCategoty() {
    if (_formkey.currentState!.validate()) {
      categoryApartmentFB.update(
          widget.id,
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
