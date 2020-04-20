import 'package:flutter/material.dart';

import 'package:talksindhi/my_appbar.dart';
import 'package:talksindhi/realtime_data.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Widget searchItem({BuildContext context, element}) {
    var category = element['category'];

    return InkWell(
      splashColor: Colors.orange,
      onTap: () => Navigator.pushReplacementNamed(
        context,
        '/learnContent',
        arguments: {
          'category': category,
          'subCategory': element['subCategory'],
          'subCategoryIndex': element['subCategoryIndex'],
          'rebuildScreen': element['rebuildScreen'],
          'initialIndex': element['initialIndex'],
        },
      ),
      child: Card(
        // color: Colors.blueGrey[200],
        elevation: 1.0,
        child: ListTile(
          leading: category == 'vocabulary'
              ? Icon(
                  Icons.font_download,
                  color: Colors.orange[200],
                )
              : Icon(
                  Icons.people,
                  color: Colors.blue[200],
                ),
          trailing: Icon(
            Icons.search,
            size: 30.0,
            color: Colors.orange[200],
          ),
          title: category == 'vocabulary'
              ? Text(
                  vocabulary[element['subCategoryIndex']]['data']
                      [element['initialIndex']]['english'],
                )
              : Text(
                  conversation[element['subCategoryIndex']]['data']
                      [element['initialIndex']]['english'],
                ),
          subtitle: category == 'vocabulary'
              ? Text(
                  vocabulary[element['subCategoryIndex']]['data']
                      [element['initialIndex']]['sindhi'],
                )
              : Text(
                  conversation[element['subCategoryIndex']]['data']
                      [element['initialIndex']]['sindhi'],
                ),
        ),
      ),
    );
  }

  var filteredWords;
  @override
  void initState() {
    filteredWords = searchItems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: myAppBar(
          context: context,
          elevation: 0.0,
          backgroundColor: Colors.orange[50],
          rebuildScreen: () {
            setState(() {
              print('rebuild screen');
            });
          },
          backButton: true,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
                child: Card(
                  margin: const EdgeInsets.only(
                    left: 0.0,
                    right: 0.0,
                    top: 0.0,
                    bottom: 2.0,
                  ),
                  color: Colors.orange[50],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 5.0,
                    ),
                    child: TextField(
                      autofocus: true,
                      style: const TextStyle(
                        fontSize: 18.0,
                        letterSpacing: 0.75,
                      ),
                      decoration: InputDecoration(
                        hintText: globalLanguage == 'english'
                            ? 'Search and learn'
                            : 'खोजो और सीखो',
                        hintStyle: const TextStyle(
                            fontSize: 18.0, color: Colors.blueGrey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                      ),
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        setState(
                          () {
                            filteredWords = searchItems.where((element) {
                              var category = element['category'];

                              if (category == 'vocabulary')
                                return vocabulary[element['subCategoryIndex']]
                                            ['data'][element['initialIndex']]
                                        ['english']
                                    .toLowerCase()
                                    .contains(value.toLowerCase());
                              else if (category == 'conversation')
                                return conversation[element['subCategoryIndex']]
                                            ['data'][element['initialIndex']]
                                        ['english']
                                    .toLowerCase()
                                    .contains(value.toLowerCase());
                              else
                                return false;
                            }).toList();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 15,
              child: filteredWords.length > 0
                  ? ListView.builder(
                      itemCount: filteredWords.length,
                      itemBuilder: (context, index) => searchItem(
                        context: context,
                        element: filteredWords[index],
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/unhappy-face.png',
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            globalLanguage == 'english'
                                ? 'Sorry, we could not find what you were looking for'
                                : 'क्षमा करें, हमें वह नहीं मिल रहा है जिसकी आपको तलाश है',
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20.0,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.blueGrey,
                            ),
                          ),
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
