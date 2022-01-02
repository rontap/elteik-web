<?php
session_start();
$cart = $_SESSION['cart'];
$id = $_GET['id'];

if (!isset($cart[$id])) {
    $cart[$id] = 0;
}
$cart[$id]+=1;

$_SESSION['cart'] = $cart;

header('Location: index.php');