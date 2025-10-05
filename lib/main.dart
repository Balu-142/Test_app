import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'chat_App/core/utils/network_info.dart';

import 'chat_App/data/datasources/auth_remote_data_source.dart';
import 'chat_App/data/datasources/chat_remote_data_source.dart';
import 'chat_App/data/datasources/message_remote_data_source.dart';

import 'chat_App/data/repositories/auth_repository_impl.dart';
import 'chat_App/data/repositories/chat_repository_impl.dart';
import 'chat_App/data/repositories/message_repository_impl.dart';

import 'chat_App/domain/repositories/auth_repository.dart';
import 'chat_App/domain/repositories/chat_repository.dart';
import 'chat_App/domain/repositories/message_repository.dart';

import 'chat_App/domain/usecases/login_usecase.dart';
import 'chat_App/domain/usecases/get_chats_usecase.dart';
import 'chat_App/domain/usecases/get_messages_usecase.dart';
import 'chat_App/domain/usecases/send_message_usecase.dart';

import 'chat_App/presentation/blocs/auth_bloc.dart';

import 'chat_App/presentation/pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final httpClient = http.Client();
  final networkInfo = NetworkInfo();

  @override
  Widget build(BuildContext context) {
    // Set up data sources
    final authRemoteDataSource = AuthRemoteDataSourceImpl(client: httpClient);
    final chatRemoteDataSource = ChatRemoteDataSourceImpl(client: httpClient);
    final messageRemoteDataSource =
    MessageRemoteDataSourceImpl(client: httpClient);

    // Set up repositories
    final AuthRepository authRepository = AuthRepositoryImpl(
      remoteDataSource: authRemoteDataSource,
      networkInfo: networkInfo,
    );

    final ChatRepository chatRepository = ChatRepositoryImpl(
      remote: chatRemoteDataSource,
      networkInfo: networkInfo,
    );

    final MessageRepository messageRepository = MessageRepositoryImpl(
      remote: messageRemoteDataSource,
      networkInfo: networkInfo,
    );

    // Set up use cases
    final loginUseCase = LoginUseCase(authRepository);
    final getChatsUseCase = GetChatsUseCase(chatRepository);
    final getMessagesUseCase = GetMessagesUseCase(messageRepository);
    final sendMessageUseCase = SendMessageUseCase(messageRepository);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LoginUseCase>.value(value: loginUseCase),
        RepositoryProvider<GetChatsUseCase>.value(value: getChatsUseCase),
        RepositoryProvider<GetMessagesUseCase>.value(
            value: getMessagesUseCase),
        RepositoryProvider<SendMessageUseCase>.value(
            value: sendMessageUseCase),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (_) => AuthBloc(loginUseCase: loginUseCase),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chat App with Clean Architecture',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const LoginPage(),
        ),
      ),
    );
  }
}
