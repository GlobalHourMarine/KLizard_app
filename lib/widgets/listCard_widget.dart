// ignore_for_file: file_names

import 'package:flutter/material.dart';

Widget getDesignForListWithData(
    List<Map<String, String>> dataList, bool isArrowShow) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (Map item in dataList)
              Row(
                children: [
                  Text(
                    item['title'].toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    item['value'].toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: item['title'].toString() == ""
                          ? FontWeight.w500
                          : FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
          ],
        ),
        if (isArrowShow == true) const Spacer(),
        if (isArrowShow == true)
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
          )
      ],
    ),
  );
}

Widget commonCardDesignForListWithData(
    List<Map<String, String>> dataList, bool isArrowShow) {
  return Card(
    elevation: 5,
    margin: const EdgeInsets.all(15.0),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (Map item in dataList)
                Row(
                  children: [
                    Text(
                      item['title'].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      item['value'].toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: item['title'].toString() == ""
                            ? FontWeight.w500
                            : FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
            ],
          ),
          if (isArrowShow == true) const Spacer(),
          if (isArrowShow == true)
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            )
        ],
      ),
    ),
  );
}
