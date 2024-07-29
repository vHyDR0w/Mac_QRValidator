import 'package:flutter/material.dart';
import 'package:scan_device_qr_code/constants/constants.dart';
import 'package:scan_device_qr_code/constants/empty_feed.dart';
import 'package:scan_device_qr_code/constants/qr_interchange.dart';
import 'epoch_computation.dart';

class ResultPagePravah extends StatelessWidget {
  const ResultPagePravah({super.key, required this.data});
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    FilterOut filterOut = FilterOut.fromJson(data);
    // var fof = filterOut.feeds;
    var chnl = filterOut.channel;

    // if (filterOut.feeds![0].field1 == null &&
    //     filterOut.feeds![0].field2 == null) {
    //   return Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Result'),
    //     ),
    //     body: qrInterchangePravah(),
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
            'Result Pravah',
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
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Channel Id: ${chnl.id}',
                            style: contentStyle,
                          ),
                          Text(
                            'Total flow: ${filterOut.feeds![index].field1} L',
                            style: contentStyle,
                          ),
                          Text(
                            'Flow rate: ${filterOut.feeds![index].field2} kL/hr',
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

class FilterOut {
  List<Feeds>? feeds;
  Channel? channel;
  FilterOut({this.feeds, this.channel});
  FilterOut.fromJson(Map<String, dynamic> json) {
    if (json['feeds'] != null) {
      feeds = <Feeds>[];
      json['feeds'].forEach((v) {
        feeds!.add(Feeds.fromJson(v));
      });
    }
    if (json['channel'] != null) {
      channel = Channel.fromJson(json['channel']);
    }
  }
}

class Feeds {
  String? createdAt;
  int? entryId;
  String? field1;
  String? field2;

  Feeds({this.createdAt, this.entryId, this.field1, this.field2});
  Feeds.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    entryId = json['entry_id'];
    field1 = json['field1'];
    field2 = json['field2'];
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
