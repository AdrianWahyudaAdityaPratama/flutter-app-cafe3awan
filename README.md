# 🏪 3awan Cafe Resto

A modern Flutter app for cafe & restaurant ordering — simple, elegant, and responsive.  
Dibuat dengan tampilan minimalis khas kafe yang bersih dan nyaman dipandang ☕

---

## ✨ Features

### 🧾 Home Page

- Menampilkan daftar menu (Foods & Drinks)
- Filter kategori: **All**, **Foods**, dan **Drinks**
- Pencarian menu real-time
- Tombol **Add / Remove** dengan animasi halus saat menambah item
- Badge keranjang (cart) di pojok kanan atas dengan tampilan rounded & presisi

### 🛒 Cart Page

- Menampilkan daftar item yang ditambahkan ke keranjang
- Tombol `+` dan `-` untuk menambah/mengurangi jumlah
- Total harga otomatis dihitung
- Input “Uang Dibayar” dan pilihan metode pembayaran (`Cash`, `Card`, `E-Wallet`)
- Tombol **Buat Pesanan** dengan desain modern & responsif

### ⚙️ MVVM Architecture

- Menggunakan **Provider** sebagai state management
- Pemisahan file berdasarkan fungsi (`models`, `viewmodels`, `views`, `widgets`)
- Clean, maintainable, dan scalable

---

## 📂 Folder Structure

```bash
lib/
│
├── models/
│   └── menu.dart
│
├── viewmodels/
│   ├── menu_viewmodel.dart
│   └── cart_viewmodel.dart
│
├── views/
│   ├── home_view.dart
│   ├── cart_view.dart
│   └── menu_cart.dart
│
└── widgets/
    └── menu_card.dart

```

## 🧠 Tech Stack

- Flutter (v3+)
- Provider (state management)
- Dart
- Material 3 Design
- MVVM Architecture

### 🚀 Getting Started

1️⃣ Clone the repo

```bash
git clone https://github.com/yourusername/3awan_cafe_resto.git
cd 3awan_cafe_resto
```

2️⃣ Install dependencies

```bash
flutter pub get
```

3️⃣ Run the app

```bash
flutter run
```

### 🎨 Design Style Guide

- Element Style
- Primary Color #1976D2
- Background #E3F2FD
- Font Clean, rounded sans-serif
- Corner Radius 12–20
- Shadow Soft and minimal
- Theme Pastel blue modern cafe vibes ☕

### ❤️ Credits

Developed with ☕ and Flutter by Adriyan Riyan

### 📄 License

This project is licensed under the MIT License — feel free to modify and use it for your own cafe or resto app.
