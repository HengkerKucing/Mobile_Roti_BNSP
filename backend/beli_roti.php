<?php
$server = "localhost";
$user = "root";
$password = "";
$db = "roti_perusahaan";

// Membuat koneksi ke database
$connect = new mysqli($server, $user, $password, $db);

// Memeriksa koneksi
if ($connect->connect_error) {
    die("Koneksi gagal: " . $connect->connect_error);
}

// Mendapatkan data dari request POST
$nama = $_POST['nama'];
$email = $_POST['email'];
$no_telepon = $_POST['no_telepon'];
$alamat = $_POST['alamat'];
$gps_lat = $_POST['gps_lat'];
$gps_lng = $_POST['gps_lng'];
$roti_id = (int)$_POST['roti_id']; // Konversi roti_id ke integer

// Debugging: Print data yang diterima
// echo "Data yang diterima: nama=$nama, email=$email, no_telepon=$no_telepon, alamat=$alamat, gps_lat=$gps_lat, gps_lng=$gps_lng, roti_id=$roti_id";

// Menyiapkan statement SQL
$stmt = $connect->prepare("INSERT INTO pelanggan (nama, email, no_telepon, alamat, gps_lat, gps_lng, roti_id) VALUES (?, ?, ?, ?, ?, ?, ?)");
if (!$stmt) {
    die("Kesalahan dalam persiapan statement: " . $connect->error);
}

$stmt->bind_param("ssssdii", $nama, $email, $no_telepon, $alamat, $gps_lat, $gps_lng, $roti_id); // Bind parameter dengan tipe data yang sesuai

// Menjalankan query
if ($stmt->execute()) {
    echo "Pembelian berhasil";
} else {
    echo "Gagal melakukan pembelian: " . $stmt->error; // Menampilkan pesan error dari statement
}

// Menutup statement dan koneksi
$stmt->close();
$connect->close();
?>
