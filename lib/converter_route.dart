import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:udacity1/unit.dart';

class ConverterRoute extends StatefulWidget {
  final Color color;
  final List<Unit> units;

  const ConverterRoute({
    @required this.color,
    @required this.units,
  })  : assert(color != null),
        assert(units != null);

  @override
  State<StatefulWidget> createState() {
    return _ConverterRouteState();
  }
}

class _ConverterRouteState extends State<ConverterRoute> {
  // TODO: Set some variables, such as for keeping track of the user's input
  // value and units
  String _input;

  Unit _inputUnit;
  Unit _outputUnit;

  // TODO: Determine whether you need to override anything, such as initState()

  // TODO: Add other helper functions. We've given you one, _format()

  /// Clean up conversion; trim trailing zeros, e.g. 5.500 -> 5.5, 10.0 -> 10
  String _format(double conversion) {
    var outputNum = conversion.toStringAsPrecision(7);
    if (outputNum.contains('.') && outputNum.endsWith('0')) {
      var i = outputNum.length - 1;
      while (outputNum[i] == '0') {
        i -= 1;
      }
      outputNum = outputNum.substring(0, i + 1);
    }
    if (outputNum.endsWith('.')) {
      return outputNum.substring(0, outputNum.length - 1);
    }
    return outputNum;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Create the 'input' group of widgets. This is a Column that
    // includes the input value, and 'from' unit [Dropdown].
    final _inputUnitDropdown = DropdownButton<Unit>(
      isExpanded: true,
      underline: Container(),
      value: (_inputUnit == null && widget.units != null)
          ? widget.units[0]
          : _inputUnit,
      onChanged: (Unit newValue) {
        setState(() {
          _inputUnit = newValue;
        });
      },
      items: (widget.units == null || widget.units.length == 0)
          ? <Unit>[]
          : widget.units.map((Unit unit) {
              return DropdownMenuItem<Unit>(
                value: unit,
                child: Text(unit.name),
              );
            }).toList(),
    );

    var _inputTextField = TextFormField(
      keyboardType: TextInputType.number,
      decoration:
          InputDecoration(border: OutlineInputBorder(), labelText: "Input"),
      onChanged: (String value) {
        setState(() {
          _input = value;
        });
      },
      validator: (String value) {
        RegExp exp = new RegExp(r"[0-9\.\,]");
        return exp.hasMatch(value) ? null : 'Just use numbers';
      },
    );

    final Widget inputGroupBox = Container(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: EdgeInsets.all(0),
      child: Column(
        children: [
          Text(
              'Input: ${_format(double.parse(_input == null || _input == "" ? "0" : _input))}',
              style: Theme.of(context).textTheme.subhead),
          _inputTextField,
          FormattedBox(child: _inputUnitDropdown),
        ],
      ),
    );

    // TODO: Create a compare arrows icon.
    final compareArrowsIcon = RotatedBox(
      quarterTurns: 1,
      child: Icon(Icons.compare_arrows, size: 30),
    );

    // TODO: Create the 'output' group of widgets. This is a Column that
    // includes the output value, and 'to' unit [Dropdown].
    var _outputTextField = TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Output",
      ),
      readOnly: true,
      controller: TextEditingController(text: _input),
    );

    var _outputUnitDropdown = FormattedBox(
      child: DropdownButton<Unit>(
        isExpanded: true,
        underline: Container(),
        value: _outputUnit,
        onChanged: (Unit newValue) {
          setState(() {
            _outputUnit = newValue;
          });
        },
        items: (widget.units == null || widget.units.length == 0)
            ? <Unit>[]
            : widget.units.map((Unit unit) {
                return DropdownMenuItem<Unit>(
                  value: unit,
                  child: Text(unit.name),
                );
              }).toList(),
      ),
    );

    final Widget outputGroupBox = Container(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: EdgeInsets.all(0),
      child: Column(
        children: <Widget>[
          _outputTextField,
          _outputUnitDropdown,
        ],
      ),
    );

    // TODO: Return the input, arrows, and output widgets, wrapped in a Column.
    return Column(
      children: <Widget>[
        inputGroupBox,
        compareArrowsIcon,
        outputGroupBox,
      ],
    );
  }
}

class FormattedBox extends StatelessWidget {
  final Widget child;

  const FormattedBox({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
      padding: EdgeInsets.fromLTRB(12, 8, 10, 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(4.0),
        ),
      ),
      child: child,
    );
  }
}
