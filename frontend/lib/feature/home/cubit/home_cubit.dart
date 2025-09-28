import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/pegawai.dart';
import '../data/home_online_data_source.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState.initial()) {
    getPegawaiData(1263);
  }

  /// Mengambil data pegawai dari backend
  /// [userId] - ID user yang akan diambil datanya
  Future<void> getPegawaiData(int userId) async {
    try {
      emit(const HomeState.loading());

      final pegawaiResponse = await HomeDataOnline.getAttendanceData(userId);

      if (pegawaiResponse.success) {
        emit(HomeState.loaded(pegawaiResponse.data));
      } else {
        emit(
          HomeState.error('Gagal mengambil data: ${pegawaiResponse.message}'),
        );
      }
    } catch (e) {
      emit(HomeState.error(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  /// Reset state ke initial
  void reset() {
    emit(const HomeState.initial());
  }

  /// Reload data dengan user ID yang sama (jika ada)
  Future<void> refreshData() async {
    state.whenOrNull(
      loaded: (pegawaiData) async {
        await getPegawaiData(pegawaiData.userId);
      },
    );
  }

  /// Test koneksi ke backend
  Future<void> testConnection() async {
    try {
      emit(const HomeState.loading());
      final isConnected = await HomeDataOnline.testConnection();

      if (isConnected) {
        emit(const HomeState.initial()); // Back to initial if connection OK
      } else {
        emit(const HomeState.error('Tidak dapat terhubung ke server'));
      }
    } catch (e) {
      emit(HomeState.error('Connection test failed: ${e.toString()}'));
    }
  }
}
