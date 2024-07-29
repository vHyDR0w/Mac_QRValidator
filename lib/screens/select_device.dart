import 'package:flutter/material.dart';
import 'package:scan_device_qr_code/screens/scanner_page.dart';

class SelectDevice extends StatelessWidget {
  const SelectDevice({super.key});

  @override
  Widget build(BuildContext context) {
    bool starrDevice = false;
    return Scaffold(
      appBar: AppBar(
        title: Text("Select device"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 250, 10, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0x33536765),
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
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: 160,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ScannerPage(
                                starrDevice: false,
                              ),
                            ),
                          );
                        },
                        style: devButtonStyle,
                        child: Text(
                          'Pravah',
                          style: devTextStyle,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 160,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ScannerPage(starrDevice: true),
                            ),
                          );
                        },
                        style: devButtonStyle,
                        child: Text(
                          'Starr',
                          style: devTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

var devButtonStyle = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(7.0),
  ),
  backgroundColor: Colors.white,
  padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
);

var devTextStyle = const TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
