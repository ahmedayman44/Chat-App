part of 'chat_cubit_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatSucess extends ChatState{
  List<Message> messagees ; 

  ChatSucess({required this.messagees});
}
