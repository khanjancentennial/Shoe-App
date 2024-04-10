import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group1_mapd726_shoe_app/AdminHome/Provider/top_values_provider.dart';
import 'package:group1_mapd726_shoe_app/Widgets/button_with_text.dart';
import 'package:group1_mapd726_shoe_app/utils/app_color.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


import '../Login/LoginScreen.dart';
import '../utils/app_images.dart';
import '../utils/app_utils.dart';
import '../utils/preference_key.dart';
import 'Provider/all_numbers_provider.dart';
import 'Provider/top_five_products_provider.dart';

class AdminHomeScreen extends StatefulWidget {
  String? firstName;
  String? lastName;
  AdminHomeScreen({super.key, this.firstName,this.lastName});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {


  String firstDate = '';
  String lastDate = '';
  int touchedIndex = -1;
  double total = 0.0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => getDetails());
  }

  Future<void>? getDetails() async {
    if (this.mounted) {
      setState(() {});
      Provider.of<AllNumbersProvider>(context, listen: false)
          .getAllNumbersDetails();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text("Hello, ",
                      style: AppUtils.instance.textStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text("${widget.lastName}",
                      style: AppUtils.instance.textStyle(
                          fontSize: 25,
                          color: AppColors.buttonColor,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                        onTap: () {
                          AppUtils.instance.addPref(
                              PreferenceKey.boolKey, PreferenceKey.prefLogin,
                              false);
                          AppUtils.instance.addPref(PreferenceKey.stringKey,
                              PreferenceKey.prefFirstName, "");
                          AppUtils.instance.addPref(PreferenceKey.stringKey,
                              PreferenceKey.prefLastName, "");
                          AppUtils.instance.addPref(PreferenceKey.stringKey,
                              PreferenceKey.prefUserType, "");
                          AppUtils.instance.addPref(
                              PreferenceKey.stringKey, PreferenceKey.prefUserId,
                              "");
                          setState(() {});

                          // Navigator.pop(context);

                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: LoginScreen(),
                            withNavBar: false,
                            // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation: PageTransitionAnimation
                                .cupertino,
                          );
                        },
                        child: const Icon(
                          Icons.logout,
                          size: 35,
                        )
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                Consumer<AllNumbersProvider>(
                    builder: (_, getAllNumberProvider, child) =>

                    getAllNumberProvider.isLoading ?

                    const Center(
                      child: CircularProgressIndicator(),
                    )
                        :

                    Column(
                      children: [
                        Consumer<AllNumbersProvider>(
                          builder: (_, getAllNumberProvider, child) =>
                              Stack(
                                children: [
                                  Container(
                                      height: 80,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),

                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        child: Image.asset(AppImage.purpleImage,
                                          fit: BoxFit.fill,
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                        ),
                                      )
                                  ),
                                  Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 40),
                                            // Consumer<DashboardApiProvider>(
                                            //     builder: (_,getDashboardData,child) {
                                            //       return
                                            Container(
                                              width: 100,
                                              child: Text(
                                                  "${getAllNumberProvider
                                                      .allNumbersReport
                                                      .orders}",
                                                  style: AppUtils.instance
                                                      .textStyle(
                                                      fontSize: 22,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: AppColors.white
                                                  )
                                              ),
                                            ),
                                            // }
                                            // ),
                                            const SizedBox(width: 10),
                                            Flexible(
                                              child: Text("Total Orders",
                                                  style: AppUtils.instance
                                                      .textStyle(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: AppColors.white
                                                  )
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                        ),

                        Consumer<AllNumbersProvider>(
                          builder: (_, getAllNumberProvider, child) =>
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Stack(
                                  children: [
                                    Container(
                                        height: 80,
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              15),

                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          child: Image.asset(
                                            AppImage.greenImage,
                                            fit: BoxFit.fill,
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height,
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                          ),
                                        )
                                    ),
                                    Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 40),
                                              // Consumer<DashboardApiProvider>(
                                              //     builder: (_,getDashboardData,child)  {
                                              //       return
                                              Container(
                                                width: 100,
                                                child: Text(
                                                    "${getAllNumberProvider
                                                        .allNumbersReport
                                                        .products}",
                                                    style: AppUtils.instance
                                                        .textStyle(
                                                        fontSize: 22,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: AppColors.white
                                                    )
                                                ),
                                                //   );
                                                // }
                                              ),
                                              const SizedBox(width: 10),
                                              Flexible(
                                                child: Text("Total Products",
                                                    style: AppUtils.instance
                                                        .textStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: AppColors.white
                                                    )
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              ),
                        ),

                        Consumer<AllNumbersProvider>(
                          builder: (_, getAllNumberProvider, child) =>
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Stack(
                                  children: [
                                    Container(
                                        height: 80,
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              15),

                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          child: Image.asset(
                                            AppImage.orangeImage,
                                            fit: BoxFit.fill,
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height,
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                          ),
                                        )
                                    ),
                                    Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 40),
                                              // Consumer<DashboardApiProvider>(
                                              //     builder: (_,getDashboardData,child)  {
                                              //       return
                                              Container(
                                                width: 100,
                                                child: Text(
                                                    "${getAllNumberProvider
                                                        .allNumbersReport
                                                        .users}",
                                                    style: AppUtils.instance
                                                        .textStyle(
                                                        fontSize: 22,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: AppColors.white
                                                    )
                                                ),
                                                //   );
                                                // }
                                              ),
                                              const SizedBox(width: 10),
                                              Flexible(
                                                child: Text("Total Users",
                                                    style: AppUtils.instance
                                                        .textStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: AppColors.white
                                                    )
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    )

                                  ],
                                ),
                              ),
                        ),
                      ],
                    )
                ),


                const Padding(padding: EdgeInsets.only(top: 50)
                ),
                Text("Reports ",
                  style: AppUtils.instance.textStyle(
                      fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),

                Row(
                  children: [
                     Text("Select Date:- ",
                      style: AppUtils.instance.textStyle(
                        fontSize: 14
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () async {
                        selectDateRange(context);
                      },
                      icon: Icon(
                        Icons.calendar_today,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),

                  ],
                ),

                firstDate.toString().isEmpty || lastDate.toString().isEmpty ?

                const SizedBox()
                    :
                Row(
                  children: [
                    Column(
                      children: [
                        Text("Start Date:- $firstDate "),
                        Text("End Date:- $lastDate "),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    buttonWithText(
                        onPress: () {
                          Provider.of<TopFiveProductsProvider>(context,listen: false).reportData(context, firstDate, lastDate)
                              .then((value) {
                            Provider.of<TopValuesProvider>(context,listen: false).reportData(context, firstDate, lastDate);
                            total = Provider.of<TopValuesProvider>(context,listen: false).topValuesModel!.mondayRevenue!.toDouble() +
                                Provider.of<TopValuesProvider>(context,listen: false).topValuesModel!.tuesdayRevenue!.toDouble() +
                                Provider.of<TopValuesProvider>(context,listen: false).topValuesModel!.wednesdayRevenue!.toDouble() +
                                Provider.of<TopValuesProvider>(context,listen: false).topValuesModel!.thursdayRevenue!.toDouble() +
                                Provider.of<TopValuesProvider>(context,listen: false).topValuesModel!.fridayRevenue!.toDouble() +
                                Provider.of<TopValuesProvider>(context,listen: false).topValuesModel!.saturdayRevenue!.toDouble() +
                                Provider.of<TopValuesProvider>(context,listen: false).topValuesModel!.sundayRevenue!.toDouble();
                            setState(() {});
                          });
                        },
                        bgColor: AppColors.buttonColor,
                        height: 40,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 3,
                        text: "Submit",
                        textColor: AppColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)
                  ],
                ),


                const Padding(padding: EdgeInsets.only(top: 50)),

               Consumer2<TopFiveProductsProvider,TopValuesProvider>(
                   builder: (_, topFiveProducts,topValues, child) =>
                   topFiveProducts.isLoading || topValues.isLoading ?

                       Center(
                         child: CircularProgressIndicator(),
                       )
                       :
                   topFiveProducts.topFiveProductsModel != null && topValues.topValuesModel != null ?
                       Column(
                         children: [
                           Text("Top Five Selling Products",
                            style: AppUtils.instance.textStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                           ),
                           const Padding(padding: EdgeInsets.only(top: 30)),

                           Row(
                             children:[
                               Container(
                                 height: 15,width: 15,
                                 color: AppColors.darkRed,
                               ),
                               const SizedBox(width: 10),
                               Text("${topFiveProducts.topFiveProductsModel!.product1Name}")
                             ]

                           ),
                           Row(
                               children:[
                                 Container(
                                   height: 15,width: 15,
                                   color: AppColors.green,
                                 ),
                                 const SizedBox(width: 10),
                                 Text("${topFiveProducts.topFiveProductsModel!.product2Name}")
                               ]

                           ),
                           Row(
                               children:[
                                 Container(
                                   height: 15,width: 15,
                                   color: AppColors.black,
                                 ),
                                 const SizedBox(width: 10),
                                 Text("${topFiveProducts.topFiveProductsModel!.product3Name}")
                               ]

                           ),
                           Row(
                               children:[
                                 Container(
                                   height: 15,width: 15,
                                   color: AppColors.red,
                                 ),
                                 const SizedBox(width: 10),
                                 Text("${topFiveProducts.topFiveProductsModel!.product4Name}")
                               ]

                           ),
                           Row(
                               children:[
                                 Container(
                                   height: 15,width: 15,
                                   color: Colors.blueAccent,
                                 ),
                                 const SizedBox(width: 10),
                                 Text("${topFiveProducts.topFiveProductsModel!.product5Name}")
                               ]

                           ),


                           const Padding(padding: EdgeInsets.only(top: 30)),
                           Container(
                             height: 150,
                             child: PieChart(
                               PieChartData(
                                 pieTouchData: PieTouchData(
                                   touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                     setState(() {
                                       if (!event.isInterestedForInteractions ||
                                           pieTouchResponse == null ||
                                           pieTouchResponse.touchedSection == null) {
                                         touchedIndex = -1;
                                         return;
                                       }
                                       touchedIndex = pieTouchResponse
                                           .touchedSection!.touchedSectionIndex;
                                     });
                                   },
                                 ),
                                 borderData: FlBorderData(
                                   show: false,
                                 ),
                                 sectionsSpace: 0,
                                 centerSpaceRadius: 40,
                                 sections:
                                 Provider.of<TopFiveProductsProvider>(context,listen: false).topFiveProductsModel != null ?
                                 showingSections() : null,
                               ),
                             ),
                           ),
                           const Padding(padding: EdgeInsets.only(top: 100)),
                           Text("Total Revenue in \$",
                             style: AppUtils.instance.textStyle(
                                 fontWeight: FontWeight.bold,
                                 fontSize: 20
                             ),),
                           const Padding(padding: EdgeInsets.only(top: 30)),
                           Container(
                             height: 150,
                             child: BarChart(
                               BarChartData(
                                 barTouchData: barTouchData,
                                 titlesData: titlesData,
                                 borderData: borderData,
                                 barGroups:
                                 Provider.of<TopValuesProvider>(context,listen: false).topValuesModel != null ?
                                 barGroups : null,
                                 gridData: const FlGridData(show: false),
                                 alignment: BarChartAlignment.spaceAround,
                                 maxY: 5000,
                               ),
                             ),
                           ),
                         ],
                       )

                 :
                       const SizedBox(),

               ),

                const Padding(padding: EdgeInsets.only(bottom: 50)
                )


              ],
            ),
          ),
        ),
      ),

    );
  }


  BarTouchData get barTouchData =>
      BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (BarChartGroupData group,
              int groupIndex,
              BarChartRodData rod,
              int rodIndex,) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: AppColors.darkRed,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: AppColors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mn';
        break;
      case 1:
        text = 'Te';
        break;
      case 2:
        text = 'Wd';
        break;
      case 3:
        text = 'Tu';
        break;
      case 4:
        text = 'Fr';
        break;
      case 5:
        text = 'St';
        break;
      case 6:
        text = 'Sn';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData =>
      FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData =>
      FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient =>
      LinearGradient(
        colors: [
          AppColors.buttonColor,
          AppColors.darkRed,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );


  List<BarChartGroupData> get barGroups =>
      [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: Provider.of<TopValuesProvider>(context,listen: false).topValuesModel!.mondayRevenue!.toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: Provider.of<TopValuesProvider>(context,listen: false).topValuesModel!.tuesdayRevenue!.toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: Provider.of<TopValuesProvider>(context,listen: false).topValuesModel!.wednesdayRevenue!.toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: Provider.of<TopValuesProvider>(context,listen: false).topValuesModel!.thursdayRevenue!.toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: Provider.of<TopValuesProvider>(context,listen: false).topValuesModel!.fridayRevenue!.toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: Provider.of<TopValuesProvider>(context,listen: false).topValuesModel!.saturdayRevenue!.toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: Provider.of<TopValuesProvider>(context,listen: false).topValuesModel!.sundayRevenue!.toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];

  Future selectDateRange(BuildContext context) async {
    DateTimeRange? pickedRange = await showDateRangePicker(
        context: context,
        initialDateRange: DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now(),
        ),
        firstDate: DateTime(DateTime.now().year -10),
        lastDate: DateTime(DateTime.now().year +1),
        helpText: 'Select Date Range',
        cancelText: 'CANCEL',
        confirmText: 'OK',
        saveText: 'SAVE',
        errorFormatText: 'Invalid format.',
        errorInvalidText: 'Out of range.',
        errorInvalidRangeText: 'Invalid range.',
        fieldStartHintText: 'Start Date',
        fieldEndLabelText: 'End Date');
    if (pickedRange != null) {
      print('picked range ${pickedRange.start} ${pickedRange.end} ${pickedRange.duration.inDays}');
      DateTime originalFirstDate = DateTime.parse(pickedRange.start.toString());
      DateTime originalLastDate = DateTime.parse(pickedRange.end.toString());
      DateFormat formatter = DateFormat("E MMM d yyyy");
      firstDate = formatter.format(originalFirstDate);
      lastDate = formatter.format(originalLastDate);
      setState(() {});
    }
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(5, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.darkRed,
            value: Provider.of<TopFiveProductsProvider>(context,listen: false).topFiveProductsModel!.product1Totalquantity?.toDouble(),
            title: Provider.of<TopFiveProductsProvider>(context,listen: false).topFiveProductsModel!.product1Totalquantity.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.green,
            value: Provider.of<TopFiveProductsProvider>(context,listen: false).topFiveProductsModel!.product2Totalquantity!.toDouble(),
            title: Provider.of<TopFiveProductsProvider>(context,listen: false).topFiveProductsModel!.product2Totalquantity.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.black,
            value: Provider.of<TopFiveProductsProvider>(context,listen: false).topFiveProductsModel!.product3Totalquantity!.toDouble(),
            title: Provider.of<TopFiveProductsProvider>(context,listen: false).topFiveProductsModel!.product3Totalquantity.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: AppColors.red,
            value: Provider.of<TopFiveProductsProvider>(context,listen: false).topFiveProductsModel!.product4Totalquantity!.toDouble(),
            title: Provider.of<TopFiveProductsProvider>(context,listen: false).topFiveProductsModel!.product4Totalquantity.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              shadows: shadows,
            ),
          );
        case 4:
          return PieChartSectionData(
            color: Colors.blueAccent,
            value: Provider.of<TopFiveProductsProvider>(context,listen: false).topFiveProductsModel!.product5Totalquantity!.toDouble(),
            title: Provider.of<TopFiveProductsProvider>(context,listen: false).topFiveProductsModel!.product5Totalquantity.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }

}
