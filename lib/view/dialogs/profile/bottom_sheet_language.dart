import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogProfile {
  Future showBottomSheetLanguage(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Select Language',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ListTile(
                leading: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKokEnkW3y-qnUOOiWbGjRcPgaWwUIvYzqAQ&s',
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                ),
                title: const Text('English'),
                iconColor: Colors.black,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Image.network(
                  'https://t4.ftcdn.net/jpg/09/91/20/95/360_F_991209514_JVIeNCFe0YUMmcB3SJZstkk48e8EWryo.jpg',
                  width: 30,
                  height: 30,
                  fit: BoxFit.fill,
                ),
                title: const Text('Vietnamese'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Image.network(
                  'https://static.vecteezy.com/system/resources/previews/011/571/356/non_2x/circle-flag-of-japan-free-png.png',
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                ),
                title: const Text('Japanese'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Flag_of_South_Korea.svg/640px-Flag_of_South_Korea.svg.png',
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                ),
                title: const Text('Korean'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
  Future showBottomSheetContact(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Contact Us',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: const Text('Email: revme.contact@gmail.com'),

                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: const Text('Phone : 043 123 456'),

                onTap: () {
                  Navigator.pop(context);
                },
              ),

            ],
          ),
        );
      },
    );

  }


}
