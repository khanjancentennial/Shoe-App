import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group1_mapd726_shoe_app/Widgets/button_with_text.dart';
import 'package:group1_mapd726_shoe_app/utils/app_color.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../Login/LoginScreen.dart';
import '../utils/app_images.dart';
import '../utils/app_utils.dart';
import '../utils/preference_key.dart';

class AdminHomeScreen extends StatefulWidget {
  String? firstName;
  String? lastName;
  AdminHomeScreen({super.key, this.firstName,this.lastName});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 50
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
                        onTap:(){
                          AppUtils.instance.addPref(PreferenceKey.boolKey, PreferenceKey.prefLogin,false);
                          AppUtils.instance.addPref(PreferenceKey.stringKey, PreferenceKey.prefFirstName,"");
                          AppUtils.instance.addPref(PreferenceKey.stringKey, PreferenceKey.prefLastName,"");
                          AppUtils.instance.addPref(PreferenceKey.stringKey, PreferenceKey.prefUserType,"");

                          // Navigator.pop(context);

                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: LoginScreen(),
                            withNavBar: false, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation: PageTransitionAnimation.cupertino,
                          );

                        } ,
                        child: const Icon(
                          Icons.logout,
                          size: 35,
                        )
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                Stack(
                  children: [
                    Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),

                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: Image.asset(AppImage.purpleImage,
                            fit: BoxFit.fill,
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
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
                                      child: Text("120",
                                          style: AppUtils.instance.textStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.white
                                          )
                                      ),
                                    ),
                                  // }
                              // ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Text("Total Orders",
                                    style:AppUtils.instance.textStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white
                                    )
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),

                Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Stack(
                        children: [
                          Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),

                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                child: Image.asset(AppImage.greenImage,
                                  fit: BoxFit.fill,
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
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
                                            child: Text("80",
                                                style: AppUtils.instance.textStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.white
                                                )
                                            ),
                                        //   );
                                        // }
                                    ),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: Text("Total Products",
                                          style: AppUtils.instance.textStyle(
                                              fontWeight: FontWeight.bold,
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
                Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Stack(
                        children: [
                          Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),

                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                child: Image.asset(AppImage.orangeImage,
                                  fit: BoxFit.fill,
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
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
                                      child: Text("80",
                                          style: AppUtils.instance.textStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.white
                                          )
                                      ),
                                      //   );
                                      // }
                                    ),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: Text("Total Users",
                                          style: AppUtils.instance.textStyle(
                                              fontWeight: FontWeight.bold,
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

                const Padding(padding: EdgeInsets.only(top: 50)
                ),
                const Text("Report Category Wise"),
                const Padding(padding: EdgeInsets.only(top: 50)
                ),
            Container(
              height: 150,
              child: BarChart(
                BarChartData(
                  barTouchData: barTouchData,
                  titlesData: titlesData,
                  borderData: borderData,
                  barGroups: barGroups,
                  gridData: const FlGridData(show: false),
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 20,
                ),
              ),
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


  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      tooltipBgColor: Colors.transparent,
      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: 8,
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {
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

  FlTitlesData get titlesData => FlTitlesData(
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

  FlBorderData get borderData => FlBorderData(
    show: false,
  );

  LinearGradient get _barsGradient => LinearGradient(
    colors: [
      AppColors.buttonColor,
      AppColors.darkRed,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  List<BarChartGroupData> get barGroups => [
    BarChartGroupData(
      x: 0,
      barRods: [
        BarChartRodData(
          toY: 8,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 1,
      barRods: [
        BarChartRodData(
          toY: 10,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 2,
      barRods: [
        BarChartRodData(
          toY: 14,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 3,
      barRods: [
        BarChartRodData(
          toY: 15,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 4,
      barRods: [
        BarChartRodData(
          toY: 13,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 5,
      barRods: [
        BarChartRodData(
          toY: 10,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 6,
      barRods: [
        BarChartRodData(
          toY: 16,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
  ];

}
