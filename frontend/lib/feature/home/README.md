# Home Feature - Flutter Frontend

Frontend untuk mengambil data pegawai dari backend Dart Frog.

## 📁 Struktur File

```
lib/feature/home/
├── cubit/
│   ├── home_cubit.dart      # Main cubit untuk state management
│   └── home_state.dart      # States untuk home feature
├── models/
│   └── pegawai.dart         # Freezed models untuk response API
├── services/
│   └── home_service.dart    # HTTP service layer
└── pages/
    └── home_page.dart       # UI Widget untuk menampilkan data
```

## 🚀 Cara Menggunakan

### 1. Install Dependencies

```bash
cd frontend/
flutter pub get
```

### 2. Generate Freezed Files

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Pastikan Backend Running

Pastikan backend Dart Frog berjalan di `localhost:8080`:

```bash
cd backend/
dart pub global activate dart_frog_cli
dart_frog dev
```

### 4. Jalankan Testing App

```bash
flutter run lib/main_test.dart
```

## 📝 API Endpoint

**URL:** `http://localhost:8080/v1/home?user={userId}`

**Method:** GET

**Response:**
```json
{
  "success": true,
  "message": "Data pegawai berhasil diambil",
  "data": {
    "user_id": 1,
    "nama_pegawai": "John Doe",
    "departemen": "IT",
    "shifts": [
      {
        "shift": "Pagi",
        "jam_masuk": "08:00:00",
        "jam_pulang": "16:00:00"
      }
    ],
    "sudah_absensi": false,
    "presensi_aktif": null,
    "endpoint": "/v1/home",
    "timestamp": "2025-09-05T10:30:00.000Z"
  }
}
```

## 🎯 HomeCubit Usage

### Basic Usage

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature/home/cubit/home_cubit.dart';

// Dalam widget
BlocProvider(
  create: (context) => HomeCubit(),
  child: BlocBuilder<HomeCubit, HomeState>(
    builder: (context, state) {
      return switch (state) {
        HomeInitial() => Text('Initial state'),
        HomeLoading() => CircularProgressIndicator(),
        HomeLoaded(:final pegawaiData) => Text('Loaded: ${pegawaiData.namaPegawai}'),
        HomeError(:final message) => Text('Error: $message'),
      };
    },
  ),
)
```

### Methods Available

```dart
final cubit = context.read<HomeCubit>();

// Ambil data pegawai
await cubit.getPegawaiData(1);

// Refresh data yang sudah dimuat
await cubit.refreshData();

// Reset state ke initial
cubit.reset();

// Test koneksi backend
await cubit.testConnection();
```

## 🔧 HomeService Usage

Jika ingin menggunakan service langsung tanpa cubit:

```dart
import 'feature/home/services/home_service.dart';

// Ambil data pegawai
try {
  final response = await HomeService.getPegawaiData(1);
  if (response.success) {
    print('Nama: ${response.data.namaPegawai}');
  }
} catch (e) {
  print('Error: $e');
}

// Test koneksi
final isConnected = await HomeService.testConnection();
print('Backend accessible: $isConnected');
```

## 🎨 UI Components

`HomePage` widget menyediakan UI lengkap dengan:

- Loading indicator
- Error handling dengan retry button
- Informasi pegawai (nama, departemen, status absensi)
- Daftar shift kerja
- Presensi aktif (jika ada)
- Debug information
- Pull to refresh

## 🐛 Error Handling

Cubit menangani berbagai jenis error:

1. **Network Error**: Koneksi internet bermasalah
2. **Server Error**: Backend tidak accessible (status code != 200)
3. **API Error**: Backend response success = false
4. **Parse Error**: JSON parsing gagal

## 🔄 State Management

States yang tersedia:

- `HomeInitial`: State awal
- `HomeLoading`: Sedang loading data
- `HomeLoaded`: Data berhasil dimuat
- `HomeError`: Terjadi error

## 📱 Testing

Untuk testing, gunakan `main_test.dart` yang menyediakan:
- Input field untuk User ID
- Button untuk test API call
- Navigasi ke HomePage dengan data real

## 🔧 Configuration

Base URL backend dapat diubah di `HomeService`:

```dart
class HomeService {
  static const String baseUrl = 'http://localhost:8080'; // Ubah sesuai kebutuhan
}
```

## 📋 Dependencies

- `flutter_bloc`: State management
- `http`: HTTP client
- `freezed`: Immutable models
- `json_annotation`: JSON serialization
