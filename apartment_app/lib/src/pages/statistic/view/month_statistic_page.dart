import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/Bill/firebase/fb_billinfo.dart';
import 'package:apartment_app/src/pages/statistic/model/statistic_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart'as chart;
class  MonthStatisticPage extends StatefulWidget {
  const MonthStatisticPage({Key? key}) : super(key: key);

  @override
  _MonthStatisticPageState createState() => _MonthStatisticPageState();
}

class _MonthStatisticPageState extends State<MonthStatisticPage>{
  List<String>monthlist=['1','2','3','4','5','6','7','8','9','10','11','12'];
  List<String>yearlist=[];
  late final List<chart.Series<typeCharge,String>> seriesList;
   StatisticModel model=new StatisticModel(0,0,0,0,0);
  String selectYear=DateFormat('yyyy').format( DateTime.now());
  String selectMonth=DateFormat('MM').format( DateTime.now());
  BillInfoFB fb= new BillInfoFB();
  List<chart.Series<typeCharge, String>> _createSampleData( int fine, int chargeE , int chargeW, int total) {
    final data = [
      new typeCharge('Tiền phạt', fine,myRed),
      new typeCharge('Tiền điện', chargeE,myYellow),
      new typeCharge('Tiền nước', chargeW,myBlue),
      new typeCharge('Tổng cộng', total,myGreen),
    ];

    return [
      new chart.Series<typeCharge, String>(
        id: 'charge',
        colorFn: (typeCharge charge, _) => chart.ColorUtil.fromDartColor(charge.Color),
        domainFn: (typeCharge charge, _) => charge.name,
        measureFn: (typeCharge charge, _) => charge.money,
        data: data,

      )
    ];
  }
  _monthDownList() => DropdownButton(
    hint: Text(this.selectMonth),
    iconSize: 36,
    onChanged: (temp) {
      setState(() {
        this.selectMonth = temp.toString();
      });
    },
    items: this.monthlist.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
  _yearDownList() => DropdownButton(
    hint: Text(this.selectYear),
    iconSize: 36,
    onChanged: (temp) {
      setState(() {
        this.selectYear = temp.toString();
      });
    },
    items: this.yearlist.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
  _detail(String name, String detail, Color color ) => Container(
    padding: EdgeInsets.all(8),
    height: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Colors.blueGrey.withOpacity(0.1)
    ),
    child: Row(
      children: [
        Text(
          name,
          style: TextStyle(
              color:color ,
              fontWeight: FontWeight.bold
          ),
        ),
        Spacer(),
        Text(
          detail,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500
          ),
        ),
      ],
    ),
  );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor:  Colors.white,
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Text('Tháng',style: TextStyle(  color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 17)),
                Spacer(),
                this._monthDownList()
              ],
            ),
            Row(
              children: [
                Text('Năm',style: TextStyle( color: Colors.black87, fontWeight: FontWeight.bold,fontSize: 17),),
                Spacer(),
                StreamBuilder(
                    stream: this.fb.collectionReference.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: Text("No Data"),);
                      }
                      this.yearlist.clear();
                      snapshot.data!.docs.forEach((element) {
                        if(!this.yearlist.contains(element['yearBill']))  this.yearlist.add(element['yearBill']);
                      }
                      );
                      if(!this.yearlist.contains(this.selectYear)) this.yearlist.add(this.selectYear);
                      return this._yearDownList();
                    }),
              ],
            ),
            SizedBox(height: 10,),
            Expanded(
              child: StreamBuilder(
                  stream: this.fb.collectionReference.snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

                    if (!snapshot.hasData) {
                      return Center(child: Text("No Data"),);
                    }
                    this.model= new StatisticModel(0,0,0,0,0);

                    snapshot.data!.docs.forEach((element) {
                        if(element['yearBill']==this.selectYear&&element['monthBill']==this.selectMonth
                        &&element['status']!='Chưa thanh toán'
                        )
                          {
                            this.model.total+=int.parse(element['total']);
                            this.model.fine+=int.parse(element['fine']);
                            this.model.chargeE+=int.parse(element['totalE']);
                            this.model.chargeW+=int.parse(element['totalW']);
                            this.model.service+=int.parse(element['serviceFee']);

                          }
                    });

                    return Column(
                      children: [

                        _detail('Tiền điện ', this.model.fine.toString(),myYellow),
                        SizedBox(height: 10,),
                        _detail('Tiền nước', this.model.chargeW.toString(),myBlue),
                        SizedBox(height: 10,),
                        _detail('Tiền phat', this.model.chargeE.toString(),myRed),
                        SizedBox(height: 10,),
                        _detail('Tổng cộng', this.model.total.toString(),myGreen),

                     SizedBox(height: 25,),
                     Expanded(child: chart.BarChart(this._createSampleData( model.fine,model.chargeE,model.chargeW,model.total), animate: true,),),
                        SizedBox(height: 25,),
                      ],


                    );
                  }),
            ),
          ],
        )
      ),
    );
    throw UnimplementedError();
  }

}
class typeCharge {
  final String name;
  final int money;
  final Color;
  typeCharge(this.name, this.money,this.Color);
}
