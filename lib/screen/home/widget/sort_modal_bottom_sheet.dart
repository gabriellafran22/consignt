import 'package:consignt/common/navigate.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../di.dart';

class SortModalBottomSheet extends StatefulWidget {
  const SortModalBottomSheet({Key? key}) : super(key: key);

  @override
  _SortModalBottomSheetState createState() => _SortModalBottomSheetState();
}

class _SortModalBottomSheetState extends State<SortModalBottomSheet> {
  String sort = 'Newest';

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ActionChip(
        backgroundColor: Colors.white30,
        avatar: const CircleAvatar(
          child: FaIcon(
            FontAwesomeIcons.sort,
            size: 14,
          ),
        ),
        label: Text('Sort: ' + sort),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: ListView(
                  children: ListTile.divideTiles(
                    color: Colors.blueGrey,
                    context: context,
                    tiles: [
                      ListTile(
                        title: const Text('Newest'),
                        onTap: () {
                          setState(() {
                            sort = 'Newest';
                            inject<Navigate>().pop();
                          });
                        },
                      ),
                      ListTile(
                        title: const Text('Price: Low to High'),
                        onTap: () {
                          setState(() {
                            sort = 'Price: Low to High';
                            inject<Navigate>().pop();
                          });
                        },
                      ),
                      ListTile(
                        title: const Text('Price: High to Low'),
                        onTap: () {
                          setState(() {
                            sort = 'Price: High to Low';
                            inject<Navigate>().pop();
                          });
                        },
                      ),
                    ],
                  ).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
