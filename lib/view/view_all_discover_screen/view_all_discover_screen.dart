import 'package:api_integration_3/controller/home_screen_controller.dart';
import 'package:api_integration_3/controller/search_screen_controller.dart';
import 'package:api_integration_3/utils/color_constants/color_constants.dart';
import 'package:api_integration_3/view/news_detail_screen/news_detail_screen.dart';
import 'package:api_integration_3/view/search_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewAllDiscoverScreen extends StatefulWidget {
  const ViewAllDiscoverScreen({super.key});

  @override
  State<ViewAllDiscoverScreen> createState() => _ViewAllDiscoverScreenState();
}

class _ViewAllDiscoverScreenState extends State<ViewAllDiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<SearchScreenController>();

    @override
    void initState() {
      super.initState();
      //Provider.of<HomeScreenController>(context,listen: false).fetchData();
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) async {
          await context
              .read<SearchScreenController>()
              .getEverything("everything");
        },
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Discover",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Text("News from all around the world"),
            SizedBox(
              height: 20,
            ),
            SearchBar(
              leading: Icon(
                Icons.search,
                size: 30,
                color: ColorConstants.mainBlack.withOpacity(.5),
              ),
              hintText: "Search",
              onChanged: (value) async {
                await context
                    .read<SearchScreenController>()
                    .getEverything(value);
              },
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: context.watch<SearchScreenController>().isLoading
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
                                  description: searchProvider
                                          .allNewsResDataModel
                                          ?.articles?[index]
                                          .description ??
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
                                            searchProvider
                                                    .allNewsResDataModel
                                                    ?.articles?[index]
                                                    .publishedAt
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
                      itemCount: searchProvider
                              .allNewsResDataModel?.articles?.length ??
                          0,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
