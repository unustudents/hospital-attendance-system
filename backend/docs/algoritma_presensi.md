# Algoritma Presensi Pegawai

Dokumen ini menjelaskan alur logika sistem presensi pegawai.

## Ringkasan Tahapan
1. Mulai (user akses halaman input presensi)
2. Input user (pilih jam masuk & barcode, sistem ambil foto)
3. Validasi awal
4. Identifikasi pegawai (berdasarkan barcode)
5. Tentukan shift pegawai
6. Proses & simpan foto
7. Tentukan jenis presensi (Masuk / Pulang)
8. Proses detail (Masuk atau Pulang)
9. Selesai (tampilkan pesan & kembali ke form)

---
## 1. Mulai
Halaman `index.php?page=Input` memuat `inputdata.php` yang menampilkan form:
- Dropdown Jam Masuk (data dari tabel `jam_jaga` → `GROUP BY jam_masuk`)
- Input Barcode
- Kamera aktif (otomatis mengambil foto ketika shift dipilih)

## 2. Input User
- User memilih Jam Masuk → sistem trigger capture foto, disimpan sebagai Base64 di field hidden.
- User mengisi / scan Barcode pegawai.
- User menekan tombol Simpan.

## 3. Validasi Awal
Periksa:
- Barcode terisi?
- Jam Masuk (shift) dipilih?
- Foto berhasil diambil?
Jika ada yang kosong → tampilkan pesan error & kembali ke form.

## 4. Identifikasi Pegawai
Query:
```sql
SELECT id FROM barcode WHERE barcode = '$barcode';
```
Jika tidak ditemukan → error "Barcode tidak dikenal" → stop.

## 5. Tentukan Shift Pegawai
Query:
```sql
SELECT shift, jam_masuk, jam_pulang, dep_id
FROM jam_jaga
WHERE jam_masuk = '$jam_masuk'
  AND dep_id = (SELECT departemen FROM pegawai WHERE id = '$idpeg');
```
Jika tidak ada hasil → error "Shift tidak valid" → stop.

## 6. Proses Foto
- Decode Base64 → simpan file: `YYYY-MM-DD<Shift><ID>.jpeg`.
- Jika sudah ada file sebelumnya untuk kombinasi (tanggal+shift+id) → hapus & ganti baru.

## 7. Tentukan Jenis Presensi
Cek di `temporary_presensi` untuk `idpeg`:
- Jika BELUM ADA baris → ini Presensi Masuk.
- Jika SUDAH ADA → ini Presensi Pulang.

## 8A. Presensi Masuk
Hitung keterlambatan:
1. Ambil `jam_masuk` terjadwal.
2. Selisih = NOW() - jam_masuk.
3. Klasifikasi:
   - selisih <= toleransi → `Tepat Waktu`
   - toleransi < selisih <= terlambat1 → `Terlambat Toleransi`
   - terlambat1 < selisih <= terlambat2 → `Terlambat I`
   - selisih > terlambat2 → `Terlambat II`

Simpan ke `temporary_presensi`:
- `idpeg`
- `shift`
- `jam_datang = NOW()`
- `jam_pulang = NULL`
- `status`
- `keterlambatan` (dalam menit / detik sesuai kebutuhan)
- `foto`

## 8B. Presensi Pulang
Langkah:
1. Ambil baris existing dari `temporary_presensi`.
2. Ambil `jam_pulang` terjadwal.
3. Jika `jam_pulang < jam_masuk` → tambah 1 hari (shift malam).
4. Status tambahan:
   - Jika NOW() < jam_pulang → append label `PSW` (Pulang Sebelum Waktu).
5. Hitung durasi kerja: `durasi = NOW() - jam_datang`.
6. Update baris `temporary_presensi`:
   - `jam_pulang = NOW()`
   - `status = status (+PSW jika perlu)`
   - `durasi`
7. Pindahkan (insert) ke `rekap_presensi` sebagai histori permanen.
8. Hapus baris dari `temporary_presensi`.

## 9. Selesai
- Tampilkan pesan sukses.
- Refresh / redirect ke form input agar siap untuk pegawai berikutnya.

---
## Contoh Pseudocode Ringkas
```pseudo
IF not barcode OR not shift OR not foto THEN
  error("Data wajib belum lengkap")
  RETURN
END IF

idpeg = SELECT id FROM barcode WHERE barcode = :barcode
IF not idpeg THEN error("Barcode tidak dikenal"); RETURN

shiftRow = SELECT ... FROM jam_jaga WHERE jam_masuk=:jam_masuk AND dep_id=(SELECT departemen FROM pegawai WHERE id=:idpeg)
IF not shiftRow THEN error("Shift tidak valid"); RETURN

simpanFoto(base64, tanggalShiftId)

existing = SELECT * FROM temporary_presensi WHERE idpeg=:idpeg
IF not existing THEN
   selisih = now - shiftRow.jam_masuk
   status = klasifikasiKeterlambatan(selisih)
   INSERT temporary_presensi(...)
ELSE
   jadwalPulang = shiftRow.jam_pulang
   IF jadwalPulang < shiftRow.jam_masuk THEN jadwalPulang += 1 day
   status = existing.status
   IF now < jadwalPulang THEN status += "+PSW"
   durasi = now - existing.jam_datang
   UPDATE temporary_presensi SET ...
   INSERT rekap_presensi FROM temporary_presensi_row
   DELETE FROM temporary_presensi WHERE idpeg=:idpeg
END IF
success("Presensi tersimpan")
```

## Catatan Implementasi Tambahan
- Simpan times dalam UTC atau konsisten timezone.
- Gunakan transaksi ketika memindahkan data ke `rekap_presensi`.
- Index yang disarankan: `temporary_presensi(idpeg)`, `rekap_presensi(idpeg, jam_datang)`.
- Validasi double-scan cepat (rate limit per pegawai per X detik).
- Logging untuk audit (user-agent, ip, device).
- Pertimbangkan integrasi Face Recognition (opsional) sebelum final insert.

## Kemungkinan Ekstensi
- Penanganan cuti/sakit: bypass keterlambatan.
- Rekalkulasi durasi jika ada koreksi manual oleh admin.
- Notifikasi real-time (websocket) saat presensi masuk/pulang.

---
Dokumen ini dapat diperbarui seiring evolusi kebutuhan bisnis.
