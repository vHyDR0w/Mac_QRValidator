import 'package:flutter/material.dart';
import 'package:scan_device_qr_code/constants/constants.dart';
import 'package:scan_device_qr_code/constants/empty_feed.dart';
import 'package:scan_device_qr_code/constants/qr_interchange.dart';
import 'epoch_computation.dart';

class ResultPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const ResultPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    FilterOut filterOut = FilterOut.fromJson(data);
    var fof = filterOut.feeds;
    var chnl = filterOut.channel;

    // if (filterOut.feeds![0].field1 != null &&
    //     filterOut.feeds![0].field2 != null) {
    //   return Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Result'),
    //     ),
    //     body: qrInterchangeStarr(),
    //   );
    // } else
    if (filterOut.feeds == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Result'),
        ),
        body: emptyFeed(),
      );
    } else {
      //filtered fetched datetime
      String? createddateString = filterOut.feeds?[0].createdAt
          ?.substring(0, filterOut.feeds![0].createdAt!.length - 1);

      EpochComputation timeData = computefunction(createddateString!);

      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Result Starr',
          ),
        ),
        body: ListView.builder(
          itemCount: filterOut.feeds!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 230.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0x33536765),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4.0,
                      color: Color(0x33000000),
                      offset: Offset(0.0, 0.2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20.0),
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name: ${chnl!.name}',
                            style: deviceNameStyle,
                          ),
                          Text(
                            'Channel Id : ${chnl.id}',
                            style: contentStyle,
                          ),
                          Text(
                            'Added on ${timeData.year}-${timeData.month}-${timeData.day}',
                            style: contentStyle,
                          ),
                          Text(
                            'Temperature: ${fof![fof.length - index - 1].field7}°C',
                            style: contentStyle,
                          ),
                          Text(
                            'Water level: ${fof[fof.length - index - 1].field6} cm',
                            style: contentStyle,
                          ),
                          Text(
                            'Updated ${timeData.epochTimeMin} mins ago',
                            // 'Updated ${(timeData.epochTimeMin) / 60} hours & ${(timeData.epochTimeMin) % 60} ago',
                            style: contentStyle,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      icon: const Icon(
                        Icons.home,
                        size: 50,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}

//purpose of FilterOut & Feeds is to handle json object and convert it into dart object
class FilterOut {
  Channel? channel;
  List<Feeds>? feeds;

  FilterOut({this.channel, this.feeds});

  FilterOut.fromJson(Map<String, dynamic> json) {
    if (json['channel'] != null) {
      // print("Entered channel block");
      try {
        Channel.fromJson(json['channel']);
      } catch (e) {
        // print("Error is $e");
      }
      channel = Channel.fromJson(json['channel']);
    }
    // if feeds property is found in json then it creates a new list of Feeds objects from the JSON data
    if (json['feeds'] != null) {
      feeds = <Feeds>[];
      json['feeds'].forEach((v) {
        feeds!.add(Feeds.fromJson(v));
      });
    }
  }
}

//a Feeds class is created and feed value is stored to deal with conversion of json into dart object
class Feeds {
  String? createdAt;
  int? entryId;
  String? field6;
  String? field7;
  // String? field1;
  // String? field2;

  Feeds({
    this.createdAt,
    this.entryId,
    this.field6,
    this.field7,
    // this.field1,
    // this.field2,
  });

  Feeds.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    entryId = json['entry_id'];
    field6 = json['field6'];
    field7 = json['field7'];
    // field1 = json['field1'];
    // field2 = json['field2'];
  }
}

class Channel {
  int? id;
  String? name;

  Channel({this.id, this.name});

  Channel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
