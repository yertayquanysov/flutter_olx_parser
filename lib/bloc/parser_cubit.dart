import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olx_parser/repository/excel_repository.dart';
import 'package:olx_parser/repository/olx_repository.dart';

abstract class ParserState {}

class ParsingStarted extends ParserState {
  final int parsedAdsCount;

  ParsingStarted({this.parsedAdsCount = 0});
}

class ParsingFinished extends ParserState {}

class ParserView extends ParserState {}

class ParserCubit extends Cubit<ParserState> {
  final OlxRepository _olxRepository;
  final ExcelRepository _excelRepository;

  ParserCubit(
    this._olxRepository,
    this._excelRepository,
  ) : super(ParserView());

  void start() async {
    emit(ParsingStarted());

    _olxRepository.getAdsList(onFinish: () {
      emit(ParsingFinished());
    });
  }

  void stop() async {
    emit(ParsingFinished());
  }

  void export() async {
    final parsedData = _olxRepository.parsedAdsList;
    await _excelRepository.exportData(parsedData);

    emit(ParserView());
  }
}
