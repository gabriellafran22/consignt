import 'package:consignt/screen/store/provider/create_store_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FormContact extends StatelessWidget {
  const FormContact({
    Key? key,
    required this.provider,
  }) : super(key: key);

  final CreateStoreProvider provider;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        TextFormField(
          controller: provider.whatsappController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            label: Text('Whatsapp'),
            prefix: Text('+62'),
            prefixIcon: Padding(
              padding: EdgeInsets.all(10.0),
              child: FaIcon(
                FontAwesomeIcons.whatsapp,
                color: Colors.green,
              ),
            ),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          style: const TextStyle(fontSize: 14),
        ),
        Container(height: 10),
        TextFormField(
          controller: provider.telegramController,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            label: Text('Telegram'),
            hintText: 'username',
            prefixIcon: Padding(
              padding: EdgeInsets.all(10.0),
              child: FaIcon(
                FontAwesomeIcons.telegram,
                color: Colors.lightBlueAccent,
              ),
            ),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
