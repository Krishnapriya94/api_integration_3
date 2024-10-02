import 'package:api_integration_3/controller/news_detail_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaveNewsScreen extends StatefulWidget {
  const SaveNewsScreen({super.key});

  @override
  State<SaveNewsScreen> createState() => _SaveNewsScreenState();
}

class _SaveNewsScreenState extends State<SaveNewsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<NewsDetailScreenController>().getSavedNews();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<NewsDetailScreenController>(
          builder: (context, saveProvider, child) {
        return ListView.separated(
            itemBuilder: (context, index) {
              final currentSaved =
                  saveProvider.getCurrentSaved(saveProvider.keys[index]);
              return Container(
                child: Text(currentSaved?.title ?? ""),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
            itemCount: saveProvider.keys.length);
      }),
    );
  }
}
