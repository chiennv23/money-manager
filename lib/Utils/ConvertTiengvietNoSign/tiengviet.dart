library tiengviet;

import 'package:coresystem/Utils/ConvertTiengvietNoSign/parser_engine/parser_engine.dart';

abstract class TiengViet {
  /// Parser engine for parse text to unsigned
  ///
  /// [default] parser engine user [VietnameseParserEngine])
  static ParserEngine _parserEngine = VietnameseParserEngine();

  /// Method set engine for parser
  ///
  static void setParseEngine(ParserEngine parserEngine) {
    _parserEngine = parserEngine;
  }

  ///[text] vietnamese language
  ///
  ///[return] vietnamese language unsigned
  static String parse(String text) {
    return _parserEngine.unsigned(text);
  }
}
