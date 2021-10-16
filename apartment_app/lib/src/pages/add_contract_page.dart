import 'package:apartment_app/src/fire_base/fb_contract.dart';
import 'package:apartment_app/src/widgets/buttons/main_button.dart';
import 'package:flutter/material.dart';

class AddContractPage extends StatefulWidget {
  const AddContractPage({ Key? key }) : super(key: key);

  @override
  _AddContractPageState createState() => _AddContractPageState();
}

class _AddContractPageState extends State<AddContractPage> {

  ContractFB contractFB = new ContractFB();
  
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _hostController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _startDayController = TextEditingController();
  final TextEditingController _expirationDateController = TextEditingController();
  final TextEditingController _billingStartDateController = TextEditingController();
  final TextEditingController _roomPaymentPeriodController = TextEditingController();
  final TextEditingController _roomChargeController = TextEditingController();
  final TextEditingController _depositController = TextEditingController();
  final TextEditingController _renterController = TextEditingController();
  final TextEditingController _rulesController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    final double height= MediaQuery.of(context).size.height;
    final double width= MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text("Tạo hợp đồng"),
        ),
      body: SingleChildScrollView(
        child:Column(
          children: [
            SizedBox(height: height*0.01,),
            Container(
               decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0)),
                    color: Colors.grey
              ),
              padding: EdgeInsets.only(left: 15),
              alignment: Alignment.centerLeft,
              width: width,
              height: height*0.05,
              child: Text(
                "Thông tin",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                ),
            
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                   Container(
              child:  TextFormField(
                controller: _hostController,
                decoration: InputDecoration(
                labelText: "Đại diện cho thuê", ),                        
                keyboardType: TextInputType.name,
                validator: (value){
                  if(value!.isEmpty ){
                    return "Vui lòng nhập đại diện cho thuê";;
                  }
                  else{
                    return null;
                  }
                },
              ),            
            ),
            SizedBox(height:height *0.03,), 
            TextFormField(
              controller: _roomController,
            decoration: InputDecoration(
                labelText: "Chọn phòng", ),                        
                keyboardType: TextInputType.name,
                validator: (value){
                  if(value!.isEmpty ){
                    return "Vui lòng chọn phòng";;
                  }
                  else{
                    return null;
                  }
                },
              ),
              SizedBox(height:height *0.03,),  
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
              width: width*0.4,
              child:  TextFormField(
                 controller: _startDayController,
                decoration: InputDecoration(
                labelText: "Ngày bắt đầu", ),                        
                keyboardType: TextInputType.datetime,
                validator: (value){
                  if(value!.isEmpty ){
                    return "Vui lòng nhập ngày bắt đầu thuê";;
                  }
                  else{
                    return null;
                  }
                },
              ),            
            ),
            Container(
              width: width*0.4,
              child:  TextFormField(
                 controller: _expirationDateController,
                decoration: InputDecoration(
                labelText: "Ngày kết thúc", ),                        
                keyboardType: TextInputType.datetime,
                validator: (value){
                  if(value!.isEmpty ){
                    return "Vui lòng nhập ngày kết thúc thuê";;
                  }
                  else{
                    return null;
                  }
                },
              ),            
            ),
              ],
            ),
            SizedBox(height:height *0.03,),  
            Container(
              child:  TextFormField(
                 controller: _billingStartDateController,
                decoration: InputDecoration(
                labelText: "Ngày bắt đầu tính tiền", ),                        
                keyboardType: TextInputType.datetime,
                validator: (value){
                  if(value!.isEmpty ){
                    return "Vui lòng nhập ngày bắt đầu tính tiền";;
                  }
                  else{
                    return null;
                  }
                },
              ),            
            ),
            SizedBox(height:height *0.03,), 
             Container(
              child:  TextFormField(
                 controller: _roomPaymentPeriodController,
                decoration: InputDecoration(
                labelText: "Kỳ thanh toán tiền phòng", ),                        
                keyboardType: TextInputType.name,
                validator: (value){
                  if(value!.isEmpty ){
                    return "Vui lòng nhập kỳ thanh toán tiền phòng";;
                  }
                  else{
                    return null;
                  }
                },
              ),            
            ),
           
                ],
              )
            ),
          
          Container(
               decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0)),
                    color: Colors.grey
              ),
              padding: EdgeInsets.only(left: 15),
              alignment: Alignment.centerLeft,
              width: width,
              height: height*0.05,
              child: Text(
                "Tiền thuê nhà",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                ),
            
            ),
             Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                   Container(
              child:  TextFormField(
                 controller: _roomChargeController,
                decoration: InputDecoration(
                labelText: "Tiền nhà", ),                        
                keyboardType: TextInputType.number,
                validator: (value){
                  if(value!.isEmpty ){
                    return "Vui lòng nhập tiền thuê nhà";;
                  }
                  else{
                    return null;
                  }
                },
              ),            
            ),
            SizedBox(height:height *0.03,), 
            TextFormField(
            controller: _depositController,
            decoration: InputDecoration(
                labelText: "Tiền cọc", ),                        
                keyboardType: TextInputType.number,
                validator: (value){
                  if(value!.isEmpty ){
                    return "Vui lòng nhập tiền cọc";;
                  }
                  else{
                    return null;
                  }
                },
              ),
             
                ],
              )
            ),
           Container(
               decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0)),
                    color: Colors.grey
              ),
              padding: EdgeInsets.only(left: 15),
              alignment: Alignment.centerLeft,
              width: width,
              height: height*0.05,
              child: Text(
                "Người thuê",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                ),
              
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: 
                TextFormField(
                controller: _renterController,
                decoration: InputDecoration(
                    labelText: "Người thuê", ),                        
                    keyboardType: TextInputType.name,
                    validator: (value){
                      if(value!.isEmpty ){
                        return "Vui lòng nhập người thuê nhà";;
                      }
                      else{
                        return null;
                      }
                    },
                  ),
              
            ),
            Container(
               decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0)),
                    color: Colors.grey
              ),
              padding: EdgeInsets.only(left: 15),
              alignment: Alignment.centerLeft,
              width: width,
              height: height*0.05,
              child: Text(
                "Dịch vụ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                ),
              
            ),
            SizedBox(height: height*0.01,),
            Container(
               decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0)),
                    color: Colors.grey
              ),
              padding: EdgeInsets.only(left: 15),
              alignment: Alignment.centerLeft,
              width: width,
              height: height*0.05,
              child: Text(
                "Điều khoản",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                ),
              
            ),
             Padding(
              padding: EdgeInsets.all(15),
              child: 
                TextFormField(
                controller: _rulesController,
                decoration: InputDecoration(
                    labelText: "Điều khoản", ),                        
                    keyboardType: TextInputType.name,
                    validator: (value){
                      if(value!.isEmpty ){
                        return "Vui lòng nhập điều khoản thuê nhà thuê nhà";;
                      }
                      else{
                        return null;
                      }
                    },
                  ),
            ),
           SizedBox(height: height*0.05,),
           Container(
             padding: EdgeInsets.only(right:20,left: 20),
             child:
               MainButton(name: "Tạo hợp đồng", onpressed: _onClick),
            
           ),
           SizedBox(height: height*0.05,),
          ],) ,
          
        ),
    );
  }
  void _onClick()
  {
      _addContract();
  }
  void _addContract() {
    contractFB.add(
      _hostController.text,
      _roomController.text,
      _startDayController.text, 
      _expirationDateController.text,
      _billingStartDateController.text,
      _roomPaymentPeriodController.text,
      _roomChargeController.text,
      _depositController.text,
      _renterController.text,
      _rulesController.text
    ).then((value) => {
      _hostController.clear(),
      _roomController.clear(),
      _startDayController.clear(), 
      _expirationDateController.clear(),
      _billingStartDateController.clear(),
      _roomPaymentPeriodController.clear(),
      _roomChargeController.clear(),
      _depositController.clear(),
      _renterController.clear(),
      _rulesController.clear(),
      Navigator.pop(context),
    });
  }

}