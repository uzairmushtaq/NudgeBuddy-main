import 'package:NudgeBuddy/models/diet_advice.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// DIET DETAIL PAGE CLASS - RENDERS DETAILS FOR THE POSTS FOUND IN THE NUTRITION ADVICE SECTION
class DietDetailPage extends StatelessWidget {
  const DietDetailPage({super.key, required this.data});
  final DietModel data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(data.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //IMAGE
            Hero(
              tag: data.title,
              child: SizedBox(
                height: SizeConfig.heightMultiplier * 40,
                width: SizeConfig.widthMultiplier * 100,
                child: Image.asset(
                  data.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //DESCRIPTION
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.heightMultiplier * 2,
                  horizontal: SizeConfig.widthMultiplier * 4),
              child: Text(
                data.desciption,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: SizeConfig.textMultiplier * 1.8),
              ),
            ),
            //ARTICLE
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 4),
              child: Text(
                'Related Article: ',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 2,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.heightMultiplier * 1,
                  horizontal: SizeConfig.widthMultiplier * 4),
              child: Text(
                data.articleText,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: SizeConfig.textMultiplier * 1.8),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 4),
              child: InkWell(
                onTap: ()=>_launchUrl(data.articleURL),
                child: Text(
                  data.articleURL,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 1.8,
                      color: Colors.blue,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.heightMultiplier * 6)
          ],
        ),
      ),
    );
  }

  _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
