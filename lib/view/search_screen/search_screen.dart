import 'package:api_integration_3/controller/search_screen_controller.dart';
import 'package:api_integration_3/utils/color_constants/color_constants.dart';
import 'package:api_integration_3/view/news_detail_screen/news_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<SearchScreenController>();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          SearchBar(
            leading: Icon(
              Icons.search,
              size: 30,
              color: ColorConstants.mainBlack.withOpacity(.5),
            ),
            onChanged: (value) async {
              await searchProvider.getEverything(value);
            },
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: Consumer<SearchScreenController>(
            builder: (context, value, child) => value.isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsDetailScreen(
                                title: searchProvider.allNewsResDataModel
                                        ?.articles?[index].title ??
                                    "",
                                description: searchProvider.allNewsResDataModel
                                        ?.articles?[index].description ??
                                    "",
                                date: searchProvider.allNewsResDataModel
                                        ?.articles?[index].publishedAt
                                        .toString() ??
                                    "",
                                image: searchProvider.allNewsResDataModel
                                        ?.articles?[index].urlToImage ??
                                    "",
                                author: searchProvider.allNewsResDataModel
                                        ?.articles?[index].author ??
                                    "",
                              ),
                            ));
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(searchProvider
                                            .allNewsResDataModel
                                            ?.articles?[index]
                                            .urlToImage ??
                                        ""))),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  maxLines: 2,
                                  searchProvider.allNewsResDataModel
                                          ?.articles?[index].title ??
                                      "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          maxLines: 1,
                                          searchProvider.allNewsResDataModel
                                                  ?.articles?[index].author ??
                                              ""),
                                    ),
                                    Expanded(
                                      child: Text(
                                          maxLines: 1,
                                          searchProvider.allNewsResDataModel
                                                  ?.articles?[index].publishedAt
                                                  .toString() ??
                                              ""),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                    itemCount:
                        searchProvider.allNewsResDataModel?.articles?.length ??
                            0,
                  ),
          ))
        ]),
      ),
    );
  }
}
