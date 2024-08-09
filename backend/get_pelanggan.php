<?php
$server = "localhost";
$user = "root";
$password = "";
$db = "roti_perusahaan";

$connect = new mysqli($server, $user, $password, $db);

if ($connect->connect_error) {
    die("Koneksi gagal: " . $connect->connect_error);
}

$result = $connect->query("SELECT * FROM pelanggan");
if ($result === false) {
    die("Query gagal: " . $connect->error);
}

$pelanggan = array();
while($row = $result->fetch_assoc()) {
    $pelanggan[] = $row;
}

header('Content-Type: application/json');
echo json_encode($pelanggan);
$connect->close();
?>
