import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HelplinePage extends StatefulWidget {
  @override
  _DeliveryPageState createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<HelplinePage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.red600,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: VStack([
          VxBox().size(20, 2).white.make(),
          5.heightBox,
          VxBox().size(28, 2).white.make(),
          5.heightBox,
          VxBox().size(15, 2).white.make(),
        ]).pOnly(left: 16, top: 15),
      ),
      body: VStack([
        VxBox(
                child: [
          Row(
            children: [
              Text(
                'Need Help ??',
                style: TextStyle(
                    fontFamily: GoogleFonts.comfortaa().fontFamily,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Vx.white),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ].column())
            .alignTopCenter
            .makeCentered()
            .h(40),
        VxBox(
                child: [
          Row(
            children: [
              VxBox()
                  .size(280, 130)
                  // .neumorphic(
                  //     color: Vx.gray100, elevation: 0) // Comment this line.
                  .bgImage(DecorationImage(
                    image: AssetImage('assets/help.png'),
                  ))
                  .alignCenterRight
                  .make(),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ].column())
            .padding(Vx.mV0)
            .alignTopCenter
            .makeCentered()
            .h(145),
        VxBox(
                child: [
          Row(
            children: [
              Text(
                'Don\'t Worry, We are here to Help !!',
                style: TextStyle(
                    fontFamily: GoogleFonts.comfortaa().fontFamily,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Vx.white),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ].column())
            .alignTopCenter
            .makeCentered()
            .h(35),
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: VxBox(
            child: VStack([
              "Try Using these Helpline Numbers -"
                  .richText
                  .red400
                  .bold
                  .size(18)
                  .make()
                  .h(28)
                  .centered(),
              Productcard(
                title: "Kisan Call Centre",
                subtitle: "1800-180-1551",
              ),
              Productcard(
                title: "Agriculture Department Helplines",
                subtitle: "+91-802-221-1764",
              ),
              Productcard(
                title: "Ministry of Textiles, Govt. of India",
                subtitle: "+91-11-26177002",
              ),
              Productcard(
                title: "National Helpline for Farmers - 1",
                subtitle: "1800-120-4049",
              ),
              Productcard(
                title: "National Helpline for Farmers - 2",
                subtitle: "1800-200-6321",
              ),
              Productcard(
                title: "Bharat Vyapaar Customer Care",
                subtitle: "+91-480-312-XXXX",
              ),
            ]).scrollVertical().p12(),
          ).gray100.make(),
        ).expand()
      ]),
    );
  }
}

// Product Cards.
class Productcard extends StatelessWidget {
  final String title, subtitle;

  Productcard({Key key, this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HStack([
      VStack(
        [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
            child: Column(
              children: [
                title.text.bold.red600.size(18).make(),
                3.heightBox,
                subtitle.text.red400.size(16).make(),
                5.heightBox,
                [
                  Icon(
                    Icons.call_outlined,
                    color: Vx.red500,
                    size: 25,
                  ),
                  WidthBox(25),
                  Icon(
                    Icons.message_outlined,
                    color: Vx.red500,
                    size: 25,
                  ),
                  WidthBox(25),
                  Icon(
                    Icons.video_call_outlined,
                    color: Vx.red500,
                    size: 27,
                  ),
                  WidthBox(25),
                  Icon(
                    Icons.email_outlined,
                    color: Vx.red500,
                    size: 25,
                  ),
                  WidthBox(25),
                  Icon(
                    Icons.report_outlined,
                    color: Vx.red500,
                    size: 25,
                  ),
                ].row().centered(),
              ],
            ),
          )
        ],
        crossAlignment: CrossAxisAlignment.start,
      ).expand()
    ]).backgroundColor(Vx.gray200).cornerRadius(15).py(10);
  }
}
