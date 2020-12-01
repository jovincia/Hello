import 'dart:convert';
import 'dart:core';
import'package:http/http.dart' as http ;
import 'package:translator/translator.dart';
import 'package:html_unescape/html_unescape.dart';

class TranslationApi{
  static final _apiKey='AIzaSyCZgVUJ12lNGd9YnJNwduCBPKJ6AkdC9GI';
  static Future<String> translate(String message, String toLangage)async{
      final response = await http.post(
        'https:\\translation.googleapis.com/langage/translate/v2  ? target= $toLangage & key=$_apiKey & q=$message '
      );
      if (response.statusCode ==200){
        final body=json.decode(response.body);
        final translations = body ['data'] ['translations'] as List;
        final translation = translations.first;

        return  HtmlUnescape().convert(translation['translatedText']);
      }
      else
        {
            throw Exception ();
        }
       }
       static Future <String> (
           String message,String fromLanguageCode,String toLanguageCode) async{
            final translation = await GoogleTranslator.translate(
           message,
              from: fromLanguageCode,
              to: toLanguageCode,
            );
            return translation.text;
       }
      }



