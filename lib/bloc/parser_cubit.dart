import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olx_parser/repository/olx_repository.dart';

abstract class ParserState {}

class ParsingStarted extends ParserState {}

class ParsingFinished extends ParserState {}

class ParserView extends ParserState {}

class ParserCubit extends Cubit<ParserState> {
  final OlxRepository _olxRepository;

  ParserCubit(this._olxRepository) : super(ParserView());

  void start() async {
    emit(ParsingStarted());
  }

  void stop() async {
    emit(ParsingFinished());
  }

  void export() async {}
}
