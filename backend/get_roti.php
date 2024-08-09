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

// Mengambil data dari tabel roti
$result = $connect->query("SELECT * FROM roti");
$roti = array();

while ($row = $result->fetch_assoc()) {
    $roti[] = $row;
}

// Mengembalikan data dalam format JSON
header('Content-Type: application/json');
echo json_encode($roti);

// Menutup koneksi
$connect->close();
?>
