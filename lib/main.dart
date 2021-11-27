import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:socio_survey/components/connectivity_provider.dart';
import 'package:socio_survey/pages/cultural%20and%20heritage%20page/cultural_and_heritage.dart';
import 'package:socio_survey/pages/final%20page/final_page.dart';
import 'package:socio_survey/pages/user%20details%20page/user_details_page.dart';
import 'components/cities_page.dart';
import 'pages/Coastal Page/coastal_page.dart';
import 'pages/Economy and Industries page/economy_and_indu_page.dart';
import 'pages/Landing page/landing_page.dart';
import 'pages/Landing page/starting_screen.dart';
import 'pages/Tourism Page/tourism_page.dart';
import 'pages/Transportation page/transportation_page.dart';
import 'pages/environmental related page/environmental_related_page.dart';
import 'pages/householdprofilepage/household_profile_page.dart';
import 'pages/housing page/housing_page.dart';
import 'pages/physical infrastructure page/physical_infrastructure_page.dart';
import 'components/skip_page.dart';
import 'pages/slums page/slums_page.dart';
import 'pages/social infrastructure page/social_infrastructure_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
          child: StartingScreen(),
        )
      ],
      child: MaterialApp(
          builder: EasyLoading.init(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: Colors.blueAccent),
          routes: {
            '/cities_page': (context) => Cities(),
            '/skip_page': (context) => SkipPage(),
            '/starting_screen': (context) => StartingScreen(),
            '/landing_page': (context) => LandingPage(),
            '/user_details': (context) => UserDetails(),
            '/household_profile': (context) => HouseHoldPofilePage(),
            '/transportation_page': (context) => TransportationPage(),
            '/tourism_page': (context) => TourismPage(),
            '/socialInfrastructure_page': (context) =>
                SocialInfrastructurePage(),
            '/slums_page': (context) => SlumsPage(),
            '/physicalInfrastructure_page': (context) =>
                PhysicalInfrastructurePage(),
            '/housing_page': (context) => HousingPage(),
            '/final_page': (context) => FinalPage(),
            '/environmentalRelated_page': (context) =>
                EnvironmentalRelatedPage(),
            '/economyAndIndustries_page': (context) =>
                EconomyAndIndustriesPage(),
            '/culturalAndHeritage': (context) => CulturalAndHeritage(),
            '/coastal_page': (context) => CoastalPage(),
          },
          initialRoute: '/housing_page'),
    );
  }
}
