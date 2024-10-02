import 'package:api_integration_3/controller/home_screen_controller.dart';
import 'package:api_integration_3/controller/search_screen_controller.dart';
import 'package:api_integration_3/utils/color_constants/color_constants.dart';
import 'package:api_integration_3/view/news_detail_screen/news_detail_screen.dart';
import 'package:api_integration_3/view/save_news_screen/save_news_screen.dart';
import 'package:api_integration_3/view/search_screen/search_screen.dart';
import 'package:api_integration_3/view/view_all_discover_screen/view_all_discover_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:provider/provider.dart';

//https://newsapi.org/v2/top-headlines?country=us&apiKey=c655201135cc4275b9b11dd0966b9a7c

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    //Provider.of<HomeScreenController>(context,listen: false).fetchData();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<HomeScreenController>().getTopHeadLines();
        await context
            .read<SearchScreenController>()
            .getEverything("everything");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeScreenController>();
    final searchProvider = context.watch<SearchScreenController>();

    return Scaffold(
      body: SliderDrawer(
        appBar: SliderAppBar(
            appBarColor: Colors.white,
            trailing: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(),
                    ));
              },
              child: Icon(
                Icons.search,
                size: 30,
              ),
            ),
            title: Text("Disha News",
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.w700))),
        slider: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SaveNewsScreen(),
                        ));
                  },
                  child: Text(
                    "Save News",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Breaking News",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => ViewAllDiscoverScreen(),
                      //     ));
                    },
                    child: Text(
                      "View all",
                      style: TextStyle(
                          fontSize: 20, color: ColorConstants.lightBlue),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: homeProvider.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: CarouselSlider(
                          items: List.generate(
                            homeProvider.newsResData?.articles?.length ?? 0,
                            (index) => InkWell(
                              onTap: () {
                                // homeProvider.selectedIndex = index;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewsDetailScreen(
                                        title: homeProvider.newsResData
                                                ?.articles?[index].title ??
                                            "",
                                        description: homeProvider
                                                .newsResData
                                                ?.articles?[index]
                                                .description ??
                                            "",
                                        date: homeProvider.newsResData
                                                ?.articles?[index].publishedAt
                                                .toString() ??
                                            "",
                                        image: homeProvider.newsResData
                                                ?.articles?[index].urlToImage ??
                                            "",
                                        author: homeProvider.newsResData
                                                ?.articles?[index].author ??
                                            "",
                                      ),
                                    ));
                              },
                              child: Column(
                                children: [
                                  Expanded(
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: homeProvider.newsResData
                                              ?.articles?[index].urlToImage ??
                                          "https://static.vecteezy.com/system/resources/previews/004/141/669/original/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg",
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      errorListener: (value) {
                                        print("image is not loaded");
                                        print(homeProvider);
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    color:
                                        ColorConstants.mainGrey.withOpacity(.2),
                                    child: Text(
                                      maxLines: 2,
                                      homeProvider.newsResData?.articles?[index]
                                              .title ??
                                          "",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          options: CarouselOptions(
                            height: 300,
                            aspectRatio: 16 / 9,
                            //viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ),
              ),
              //Divider(),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Recommendation",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewAllDiscoverScreen(),
                          ));
                    },
                    child: Text(
                      "View all",
                      style: TextStyle(
                          fontSize: 20, color: ColorConstants.lightBlue),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.separated(
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
                                    fontWeight: FontWeight.bold, fontSize: 18),
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
                      searchProvider.allNewsResDataModel?.articles?.length ?? 0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
