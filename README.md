# RestaurantApp
🍽️ RestaurantApp  RestaurantApp adalah aplikasi Flutter yang menampilkan daftar restoran, detail restoran, pencarian, serta fitur review menggunakan Dicoding Restaurant API. Aplikasi ini dibuat untuk memenuhi seluruh kriteria wajib submission pada kelas Flutter.
Berikut adalah **README.md** yang lengkap dan rapi untuk aplikasi **RestaurantApp** menggunakan **Flutter** dan **Dicoding Restaurant API**, disesuaikan dengan seluruh kriteria submission yang Anda sebutkan.

---


## 📱 Fitur Aplikasi

### 1. Halaman Daftar Restoran

* Menampilkan daftar restoran dari API Dicoding
* Informasi yang ditampilkan:

  * Gambar restoran
  * Nama restoran
  * Kota
  * Rating
* Data diambil dari endpoint:

  ```
  https://restaurant-api.dicoding.dev/list
  ```

---

### 2. Halaman Detail Restoran

* Menampilkan detail lengkap restoran
* Informasi yang ditampilkan:

  * Nama restoran
  * Gambar restoran
  * Deskripsi
  * Kota & alamat
  * Rating
  * Daftar menu makanan
  * Daftar menu minuman
  * Review pelanggan
* Data diambil dari endpoint:

  ```
  https://restaurant-api.dicoding.dev/detail/{id}
  ```

---

### 3. Tema Terang & Gelap

* Mendukung **Light Theme** dan **Dark Theme**
* Perubahan tema meliputi:

  * Warna utama aplikasi (bukan warna default Flutter)
  * Font family kustom
* Tema dikelola menggunakan **Provider**

---

### 4. Indikator Loading

* Menampilkan indikator loading saat:

  * Memuat daftar restoran
  * Memuat detail restoran
  * Melakukan pencarian
* Menggunakan widget:

  * `CircularProgressIndicator`

---

### 5. State Management

* Menggunakan **Provider** sebagai state management
* Hanya menggunakan **satu jenis state management**
* Mengimplementasikan **sealed class** untuk:

  * Loading state
  * Success state
  * Error state
* Digunakan khusus saat pemanggilan Web API

---

### 6. Penanganan Error

* Menampilkan pesan error saat:

  * Gagal memuat data dari internet
  * Terjadi kesalahan respons API
* Pesan error:

  * Mudah dipahami oleh pengguna
  * Ditampilkan dalam bentuk teks / widget khusus

---

### 7. Animasi Hero

* Menggunakan **Hero Animation**:

  * Dari halaman daftar restoran ke halaman detail
* Hero diterapkan pada:

  * Gambar restoran
* Animasi berjalan dua arah (forward & back)

---

### 8. Fitur Pencarian Restoran

* Halaman khusus pencarian restoran
* Terdiri dari:

  * `TextField` untuk input kata kunci
  * Daftar hasil pencarian
* Menggunakan endpoint pencarian:

  ```
  https://restaurant-api.dicoding.dev/search?q={keyword}
  ```
* Contoh:

  ```
  https://restaurant-api.dicoding.dev/search?q=cafe
  ```

---

### 9. Fitur Review Restoran

* Menampilkan daftar review restoran di halaman detail
* Menambahkan review baru dengan:

  * Field nama
  * Field ulasan
* Review dikirim ke API menggunakan endpoint:

  ```
  https://restaurant-api.dicoding.dev/review
  ```
* Data yang dikirim:

  * `id` restoran
  * `name`
  * `review`

---

## 🧹 Kualitas Kode

* Tidak ada kode atau komentar yang tidak digunakan
* Indentasi rapi dan konsisten
* Import yang tidak terpakai telah dihapus
* Struktur folder terorganisir dengan baik

---

## 🛠️ Teknologi yang Digunakan

* **Flutter**
* **Dart**
* **Provider** (State Management)
* **HTTP Package**
* **Dicoding Restaurant API**

---

## 🚀 Cara Menjalankan Aplikasi

1. Clone repository ini

   ```bash
   git clone https://github.com/hanissiddiq/RestaurantApp.git
   ```

2. Masuk ke folder project

   ```bash
   cd RestaurantApp
   ```

3. Install dependency

   ```bash
   flutter pub get
   ```

4. Jalankan aplikasi

   ```bash
   flutter run
   ```

---

---
## Preview Apps
<img width="498" height="1013" alt="image" src="https://github.com/user-attachments/assets/a451b0bc-260b-4989-92e0-d1a912e2a526" />
<img width="487" height="1019" alt="image" src="https://github.com/user-attachments/assets/a7feb6db-b64f-48c7-b0d7-4723bf19dc6c" />


---

## 📌 Catatan

* Aplikasi membutuhkan koneksi internet untuk mengakses API
* Pastikan emulator atau perangkat sudah terhubung ke internet

---

## 👨‍💻 Pengembang

**Nama:** Hanis Siddiq
**Project:** RestaurantApp (Submission Flutter)

---


