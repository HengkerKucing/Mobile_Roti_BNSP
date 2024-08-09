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

// Mengambil data dari tabel pelanggan
$result = $connect->query("SELECT * FROM pelanggan");

// Memeriksa hasil query
if ($result === false) {
    die("Query gagal: " . $connect->error);
}

$pelanggan = array();

// Mengambil data dari hasil query
while($row = $result->fetch_assoc()) {
    $pelanggan[] = $row;
}

// Mengatur header untuk JSON
header('Content-Type: application/json');

// Mengembalikan data dalam format JSON
echo json_encode($pelanggan);

// Menutup koneksi
$connect->close();
?>
