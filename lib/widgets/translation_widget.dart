import 'package:flutter/material.dart';
import 'package:hello/api/translate_api.dart';
import 'package:hello/views/translations.dart';

import 'package:http/http.dart' as http;

class TranslationWidget extends StatefulWidget {
  final String message;
  final String fromLanguage;
  final String toLanguage;
  final Widget Function(String translation ) builder;

  const TranslationWidget({Key key, this.message,
    this.fromLanguage,
    this.toLanguage,
    this.builder}) : super(key: key);



  @override
  _TranslationWidgetState createState() => _TranslationWidgetState();
}

class _TranslationWidgetState extends State<TranslationWidget> {
  String translation ;
  @override
  Widget build(BuildContext context) {
    final toLanguageCode = Translations.getLanguageCode(widget.toLanguage);
    return FutureBuilder(
      future: TranslationApi.translate(widget.message, toLanguageCode),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        switch (snapshot.connectionState){
          case ConnectionState.waiting :
            return buildWaiting();
          default:
            if(snapshot.hasError){
              translation= "Couldn't translate, network problems";
            }
            else{
             translation= snapshot.data;
            }
            return widget.builder(translation);
        }
      }

    );
  }
  Widget buildWaiting() =>
      translation == null ? Container(): widget.builder(translation);
}

