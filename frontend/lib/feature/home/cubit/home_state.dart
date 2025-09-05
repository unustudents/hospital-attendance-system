part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = HomeInitial;
  const factory HomeState.loading() = HomeLoading;
  const factory HomeState.loaded(PegawaiData pegawaiData) = HomeLoaded;
  const factory HomeState.error(String message) = HomeError;
}
