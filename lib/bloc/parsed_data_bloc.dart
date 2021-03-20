import 'package:olx_parser/model/parsed_data.dart';

abstract class ParseState {}

class ParsingProgress extends ParseState {}

class Parsed extends ParsedData {}
