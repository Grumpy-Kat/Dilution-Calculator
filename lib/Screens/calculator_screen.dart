import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme.dart' as theme;

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({ super.key });

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  late TextEditingController _materialDilutionController;
  late TextEditingController _materialMassController;

  late TextEditingController _targetDilutionController;

  late TextEditingController _targetSolventMassController;
  late TextEditingController _actualSolventMassController;

  bool _hasAddedExtraMaterial = false;
  late TextEditingController _targetAddedMaterialMassController;
  late TextEditingController _actualAddedMaterialMassController;
  late TextEditingController _totalMaterialMassController;

  late TextEditingController _totalMassController;
  late TextEditingController _actualDilutionController;

  final String _initialMass = '0.000';
  final String _initialMaterialDilution = '100';
  final String _initialTargetDilution = '10';

  final MainAxisAlignment alignment = MainAxisAlignment.center;

  @override
  void initState() {
    super.initState();

    _materialDilutionController = TextEditingController(text: _initialMaterialDilution);
    _materialMassController = TextEditingController(text: _initialMass);
    _targetDilutionController = TextEditingController(text: _initialTargetDilution);
    _targetSolventMassController = TextEditingController(text: _initialMass);
    _actualSolventMassController = TextEditingController(text: _initialMass);
    _targetAddedMaterialMassController = TextEditingController(text: _initialMass);
    _actualAddedMaterialMassController = TextEditingController(text: _initialMass);
    _totalMaterialMassController = TextEditingController(text: _initialMass);
    _totalMassController = TextEditingController(text: _initialMass);
    _actualDilutionController = TextEditingController(text: _initialTargetDilution);
  }

  @override
  void dispose() {
    _materialDilutionController.dispose();
    _materialMassController.dispose();
    _targetDilutionController.dispose();
    _targetSolventMassController.dispose();
    _actualSolventMassController.dispose();
    _targetAddedMaterialMassController.dispose();
    _actualAddedMaterialMassController.dispose();
    _totalMaterialMassController.dispose();
    _totalMassController.dispose();
    _actualDilutionController.dispose();

    super.dispose();
  }

  void reset() {
    _hasAddedExtraMaterial = false;
    _materialDilutionController.text = _initialMaterialDilution;
    _materialMassController.text = _initialMass;
    _targetDilutionController.text = _initialTargetDilution;
    _targetSolventMassController.text = _initialMass;
    _actualSolventMassController.text = _initialMass;
    _targetAddedMaterialMassController.text = _initialMass;
    _actualAddedMaterialMassController.text = _initialMass;
    _totalMaterialMassController.text = _initialMass;
    _totalMassController.text = _initialMass;
    _actualDilutionController.text = _initialTargetDilution;

    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    const double spacingHeight = 18;

    const EdgeInsetsDirectional navigationBarPadding = EdgeInsetsDirectional.symmetric(horizontal: 15.0, vertical: 10.0);
    const Widget navigationBarHeader = Text('Dilution Calculator', style: TextStyle(fontSize: 17));
    CupertinoNavigationBar navigationBar;
    switch(alignment) {
      case MainAxisAlignment.start:
        navigationBar = const CupertinoNavigationBar(leading: navigationBarHeader, padding: navigationBarPadding);
      case MainAxisAlignment.center:
      case MainAxisAlignment.spaceBetween:
      case MainAxisAlignment.spaceAround:
      case MainAxisAlignment.spaceEvenly:
        navigationBar = const CupertinoNavigationBar(middle: navigationBarHeader, padding: navigationBarPadding);
      case MainAxisAlignment.end:
        navigationBar = const CupertinoNavigationBar(trailing: navigationBarHeader, padding: navigationBarPadding);
    }

    return CupertinoPageScaffold(
      navigationBar: navigationBar,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _getTextFieldRow('Material Dilution', _materialDilutionController, '%', _updateTargetSolventMass, false, true),
              _getTextFieldRow('Material Mass', _materialMassController, 'g', _updateTargetSolventMass),
              const SizedBox(height: spacingHeight),

              _getTextFieldRow('Target Dilution', _targetDilutionController, '%', _updateTargetSolventMass, false),
              const SizedBox(height: spacingHeight),

              _getTextFieldRow('Target Solvent Mass', _targetSolventMassController, 'g'),
              _getTextFieldRow('Actual Solvent Mass', _actualSolventMassController, 'g', _updateTargetMaterialMass),
              _getTextFieldRow('Target Added Material Mass', _targetAddedMaterialMassController, 'g'),
              _getTextFieldRow('Actual Added Material Mass', _actualAddedMaterialMassController, 'g', _onActualAddedMaterialMassChanged),
              _getTextFieldRow('Total Material Mass', _totalMaterialMassController, 'g'),
              const SizedBox(height: spacingHeight),

              _getTextFieldRow('Total Mass', _totalMassController, 'g'),
              _getTextFieldRow('Actual Dilution', _actualDilutionController, '%', null, false),
              const SizedBox(height: spacingHeight),

              Container(
                alignment: Alignment.center,
                height: 40,
                child: Row(
                  mainAxisAlignment: alignment,
                  children: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: theme.primaryColor.resolveFrom(context),
                        foregroundColor: theme.primaryContrastingColor.resolveFrom(context),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        ),
                        side: BorderSide(
                          color: theme.primaryColor.resolveFrom(context),
                          width: 1.5,
                        ),
                      ),
                      onPressed: () { _updateTargetSolventMass(''); },
                      child: const Text('Calculate'),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: theme.primaryColor.resolveFrom(context),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        ),
                        side: BorderSide(
                          color: theme.primaryColor.resolveFrom(context),
                          width: 1.5,
                        ),
                      ),
                      onPressed: reset,
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTextFieldRow(String label, TextEditingController controller, String unit, [ValueChanged<String>? onChanged, bool limitToThreeDigits = true, bool autofocus = false]) {
    return Container(
      alignment: Alignment.center,
      height: 35,
      child: Row(
        mainAxisAlignment: alignment,
        children: <Widget>[
          Text('$label: ', style: const TextStyle(fontSize: 15)),
          Container(
            width: 100,
            padding: const EdgeInsets.only(left: 20),
            child: CupertinoTextField(
              textAlign: TextAlign.end,
              controller: controller,
              onChanged: onChanged,
              readOnly: onChanged == null ? true : false,
              autofocus: autofocus,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(limitToThreeDigits ? r'^\d+(\.\d{0,3})?' : r'^\d+(\.\d*)?')),
              ],
            ),
          ),
          Text(' $unit'),
        ],
      ),
    );
  }

  void _updateTargetSolventMass(String _) {
    // The method is passed on of the three values below, but its harder to figure out
    // what value is being passed and get the other two than just getting all three
    // This just makes the function easier to reuse for all three onChange callbacks
    double materialDilution = _toDouble(_materialDilutionController.text);
    double materialMass = _toDouble(_materialMassController.text);
    double targetDilution = _toDouble(_targetDilutionController.text);

    double targetSolventMass = (materialDilution / targetDilution * materialMass) - materialMass;
    _targetSolventMassController.text = targetSolventMass.toStringAsFixed(3);

    _updateTargetMaterialMass(_);
  }

  void _updateTargetMaterialMass(String _) {
    double solventMass = _toDouble(_actualSolventMassController.text);
    double materialDilution = _toDouble(_materialDilutionController.text);
    double materialMass = _toDouble(_materialMassController.text);
    double targetDilution = _toDouble(_targetDilutionController.text);

    double targetTotalMaterialMass = solventMass * targetDilution / (materialDilution - targetDilution);
    double targetAddedMaterialMass = targetTotalMaterialMass - materialMass;
    // Clamp added material mass to 0
    if(targetAddedMaterialMass < 0) {
      targetAddedMaterialMass = 0;
      targetTotalMaterialMass = materialMass;
    }
    _targetAddedMaterialMassController.text = targetAddedMaterialMass.toStringAsFixed(3);
    if(!_hasAddedExtraMaterial) {
      _totalMaterialMassController.text = targetTotalMaterialMass.toStringAsFixed(3);
    }

    _updateTotalMass();
  }

  void _onActualAddedMaterialMassChanged(String val) {
    _hasAddedExtraMaterial = true;

    double addedMaterialMass = _toDouble(val);
    double originalMaterialMass = _toDouble(_materialMassController.text);

    double totalMaterialMass = addedMaterialMass + originalMaterialMass;
    _totalMaterialMassController.text = totalMaterialMass.toStringAsFixed(3);

    _updateTotalMass();
  }

  void _updateTotalMass() {
    double solventMass = _toDouble(_actualSolventMassController.text);
    double materialMass = _getMaterialMass();

    double totalMass = solventMass + materialMass;
    _totalMassController.text = totalMass.toStringAsFixed(3);

    _updateActualDilution();
  }

  void _updateActualDilution() {
    double materialMass = _getMaterialMass();
    double materialDilution = _toDouble(_materialDilutionController.text);
    double totalMass = _toDouble(_totalMassController.text);

    double actualDilution = materialMass * materialDilution / totalMass;
    _actualDilutionController.text = actualDilution.toString();
  }

  double _getMaterialMass() {
    if(_hasAddedExtraMaterial) {
      return _toDouble(_totalMaterialMassController.text);
    }
    return _toDouble(_materialMassController.text);
  }

  double _toDouble(String val) {
    return double.tryParse(val) ?? 0;
  }
}
