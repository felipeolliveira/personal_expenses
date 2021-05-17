import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double value;
  final double percent;

  ChartBar({this.day, this.value, this.percent});

  @override
  Widget build(BuildContext context) {
    print(percent);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(
        builder: (ctx, contraints) {
          return Column(
            children: [
              Container(
                height: contraints.maxHeight * 0.15,
                child: FittedBox(
                  child: Text('${value.toStringAsFixed(2)}'),
                ),
              ),
              SizedBox(height: contraints.maxHeight * 0.05),
              Container(
                width: 10.0,
                height: contraints.maxHeight * 0.6,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    FractionallySizedBox(
                      heightFactor: percent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: contraints.maxHeight * 0.05),
              Container(
                height: contraints.maxHeight * 0.15,
                child: Text(day),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Expanded(
//                     flex: 100 - percent,
//                     child: Container(
//                       color: Colors.grey[300],
//                     )),
//                 Expanded(
//                     flex: percent,
//                     child: Container(
//                       color: Theme.of(context).accentColor,
//                     )),
