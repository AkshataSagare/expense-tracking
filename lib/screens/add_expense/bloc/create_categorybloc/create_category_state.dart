part of 'create_category_bloc.dart';

sealed class CreateCategoryState extends Equatable {
  const CreateCategoryState();
  
  @override
  List<Object> get props => [];
}

final class CreateCategoryInitial extends CreateCategoryState {}

final class CreateCategoryInitialFailure extends CreateCategoryState {}
final class CreateCategoryInitialLoading extends CreateCategoryState {}
final class CreateCategoryInitialSuccess extends CreateCategoryState {}