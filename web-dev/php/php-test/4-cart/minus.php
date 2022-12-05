<?php
session_start();
$cart = $_SESSION['cart'];
$id = $_GET['id'];

$cart[$id]--;

if ($cart[$id] == 0) {
    unset($cart[$id]);
}

$_SESSION['cart'] = $cart;

header('Location: index.php');