import 'package:apartment_app/src/colors/colors.dart';
import 'package:apartment_app/src/pages/Bill/firebase/fb_billinfo.dart';
import 'package:apartment_app/src/pages/statistic/model/statistic_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart'as chart;
class  YearStatisticPage extends StatefulWidget {
  const YearStatisticPage({Key? key}) : super(key: key);

  @override
  _YearStatisticPageState createState() => _YearStatisticPageState();
}

class _YearStatisticPageState extends State<YearStatisticPage>{
  List<String>yearlist=[];
  List<StatisticModel> listStatistic=[];
  late final List<chart.Series<typeCharge,String>> seriesList;
  StatisticModel model=new StatisticModel(0,0,0,0,0);
  String selectYear=DateFormat('yyyy').format( DateTime.now());
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
  List<chart.Series<typeCharge, String>> createSampleData(List<StatisticModel> month) {
    List<typeCharge> chargeE = [];
    List<typeCharge> chargeW = [];
    List<typeCharge> fine = [];
    List<typeCharge> total = [];
    int index=0;
      month.forEach((element) {
        index ++;
        print(index);
        chargeE.add(new typeCharge(index.toString(), month[index-1].chargeE, myYellow));
        chargeW.add(new typeCharge(index.toString(), month[index-1].chargeW, myBlue));
        fine.add(new typeCharge(index.toString(), month[index-1].fine, myRed));
        total.add(new typeCharge(index.toString(), month[index-1].total, myGreen));
      });
    return [
      // Blue bars with a lighter center color.
      new chart.Series<typeCharge, String>(
        id: 'water charge',
        domainFn: (typeCharge charge, _) => charge.name,
        measureFn: (typeCharge charge, _) => charge.money,
        data: chargeW,
        colorFn: (typeCharge charge, _) => chart.ColorUtil.fromDartColor(charge.Color),
      ),
      // Solid red bars. Fill color will default to the series color if no
      // fillColorFn is configured.
      new chart.Series<typeCharge, String>(
        id: 'electric charge',
        measureFn: (typeCharge charge, _) => charge.money,
        data: chargeE,
        colorFn: (typeCharge charge, _) => chart.ColorUtil.fromDartColor(charge.Color),
        domainFn: (typeCharge charge, _) => charge.name,
      ),
      // Hollow green bars.
      new chart.Series<typeCharge, String>(
        id: 'fine',
        domainFn: (typeCharge charge, _) => charge.name,
        measureFn: (typeCharge charge, _) => charge.money,
        data: fine,
        colorFn: (typeCharge charge, _) => chart.ColorUtil.fromDartColor(charge.Color),
      ),
      new chart.Series<typeCharge, String>(
        id: 'total',
        domainFn: (typeCharge charge, _) => charge.name,
        measureFn: (typeCharge charge, _) => charge.money,
        data: total,
        colorFn: (typeCharge charge, _) => chart.ColorUtil.fromDartColor(charge.Color),
      ),
    ];
  }
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
                      this.listStatistic=[];
                      for(int i=0; i<12;i++){
                          this.listStatistic.add(new StatisticModel(0,0,0,0,0));
                      }
                      snapshot.data!.docs.forEach((element) {
                        if(element['yearBill']==this.selectYear)
                        {
                          this.model.total+=int.parse(element['total']);
                          this.model.fine+=int.parse(element['fine']);
                          this.model.chargeE+=int.parse(element['totalE']);
                          this.model.chargeW+=int.parse(element['totalW']);
                          this.model.service+=int.parse(element['serviceFee']);
                          int month=int.parse(element['monthBill']);
                          listStatistic[month-1].total+=int.parse(element['total']);
                          listStatistic[month-1].fine+=int.parse(element['fine']);
                          listStatistic[month-1].chargeE+=int.parse(element['totalE']);
                          listStatistic[month-1].chargeW+=int.parse(element['totalW']);
                          listStatistic[month-1].service+=int.parse(element['serviceFee']);
                        }
                      });

                      return ListView(
                        children: [
                          _detail('Tiền điện ', this.model.fine.toString(),myYellow),
                          SizedBox(height: 10,),
                          _detail('Tiền nước', this.model.chargeW.toString(),myBlue),
                          SizedBox(height: 10,),
                          _detail('Tiền phat', this.model.chargeE.toString(),myRed),
                          SizedBox(height: 10,),
                          _detail('Tổng cộng', this.model.total.toString(),myGreen),
                          SizedBox(height: 50,),
                         Container(
                           height: 450,
                           child: ListView(
                             scrollDirection: Axis.horizontal,
                             children: [
                               SizedBox(
                                 width: 1500,
                                 child: chart.BarChart(this.createSampleData(this.listStatistic),
                                   animate: true,
                                   defaultRenderer: new chart.BarRendererConfig(
                                       groupingType: chart.BarGroupingType.grouped, ),
                                 ),
                               )
                             ],
                           ),
                         ),
                         // Expanded(child: chart.BarChart(this._createSampleData( model.fine,model.chargeE,model.chargeW,model.total), animate: true,),),
                         //      SizedBox(
                         //      height:600,
                         //      child: chart.BarChart(this.createSampleData(),
                         //        animate: true,
                         //        defaultRenderer: new chart.BarRendererConfig(
                         //            groupingType: chart.BarGroupingType.grouped, strokeWidthPx: 2.0),
                         //        vertical: false,
                         //      ),
                         //    ),



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
