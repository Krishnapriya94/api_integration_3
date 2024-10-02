import 'package:api_integration_3/controller/news_detail_screen_controller.dart';
import 'package:api_integration_3/utils/color_constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.image,
    required this.author,
  });
  final String title;
  final String description;
  final String date;
  final String image;
  final String author;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          InkWell(
            onTap: () {
              context.read<NewsDetailScreenController>().onSave(
                  title: title,
                  description: description,
                  date: date,
                  author: author);

              print(title);
            },
            child: CircleAvatar(
                radius: 20,
                backgroundColor: ColorConstants.mainGrey.withOpacity(.5),
                child: Icon(Icons.bookmark_border_outlined)),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(image))),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: ColorConstants.mainWhite,
                //borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(textAlign: TextAlign.justify, date),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                      maxLines: 5,
                      style: TextStyle(
                          fontSize: 25,
                          color: ColorConstants.lightBlue,
                          fontWeight: FontWeight.bold),
                      title),
                  Text(
                    maxLines: 50,
                    textAlign: TextAlign.justify,
                    description,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
