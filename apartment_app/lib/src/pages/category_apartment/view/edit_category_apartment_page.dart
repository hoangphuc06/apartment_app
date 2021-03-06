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
      appBar: myAppBar("S???a lo???i c??n h???"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title("Th??ng tin chi ti???t"),

              // T??n lo???i c??n h???
              SizedBox(height: 10,),
              TitleInfoNotNull(text: "T??n lo???i c??n h???"),
              SizedBox(height: 10,),
              _nameTextField(),

              // Di???n t??ch c??n h???
              SizedBox(height: 10,),
              TitleInfoNotNull(text: "Di???n t??ch (m2)"),
              SizedBox(height: 10,),
              _areaTextField(),

              //S??? l?????ng ph??ng ng???
              SizedBox(height: 10,),
              TitleInfoNotNull(text: "S??? ph??ng ng???"),
              SizedBox(height: 10,),
              _amountBedroomTextField(),

              //S??? l?????ng ph??ng v??? sinh
              SizedBox(height: 10,),
              TitleInfoNotNull(text: "S??? ph??ng v??? sinh"),
              SizedBox(height: 10,),
              _amountWcTextField(),

              //S??? l?????ng ng?????i ???
              SizedBox(height: 10,),
              TitleInfoNotNull(text: "S??? l?????ng ng?????i ???"),
              SizedBox(height: 10,),
              _amountDwellerTextField(),
              SizedBox(height: 30,),

              _title("Gi?? c??? giao ?????ng"),

              //Gi?? b??n
              SizedBox(height: 10,),
              TitleInfoNotNull(text: "Gi?? b??n (VN??)"),
              SizedBox(height: 10,),
              _priceTextField(),

              //Gi?? thu??
              SizedBox(height: 10,),
              TitleInfoNotNull(text: "Gi?? thu?? (VN??)"),
              SizedBox(height: 10,),
              _rentalPriceTextField(),
              SizedBox(height: 30,),

              MainButton(
                name: "S???a",
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
      decoration: MyStyle().style_decoration_tff("C??n h??? lo???i A"),
      keyboardType: TextInputType.name,
      validator: (val) {
        if (val!.isEmpty) {
          return "Vui l??ng nh???p t??n";
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
          return "Vui l??ng nh???p di???n t??ch";
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
          return "Vui l??ng nh???p s??? ph??ng ng???";
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
          return "Vui l??ng nh???p s??? ph??ng v??? sinh";
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
          return "Vui l??ng nh???p s??? l?????ng ng?????i ???";
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
      decoration: MyStyle().style_decoration_tff("Nh???p gi?? b??n"),
      keyboardType: TextInputType.number,
      validator: (val) {
        if (val!.isEmpty) {
          return "Vui l??ng nh???p gi??";
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
      decoration: MyStyle().style_decoration_tff("Nh???p gi?? thu??"),
      keyboardType: TextInputType.number,
      validator: (val) {
        if (val!.isEmpty) {
          return "Vui l??ng nh???p gi??";
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
