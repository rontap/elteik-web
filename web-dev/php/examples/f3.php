<?php
    $a = "";
    $b = "";
    if (isset($_GET["a"]) && isset($_GET["b"])){
        $a = floatval($_GET["a"]);
        $b = floatval($_GET["b"]);
        $epsilon = 0.000001;
        $x = abs($a) > $epsilon ? -$b/$a : "Nem szám.";
    }
?>

<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Egyenletmegoldó</title>
</head>
<body>
    <h1>Elsőfokú egyenlet: ax + b = 0</h1>
    <form action="f3.php" method="get">
        a = <input type="text" name="a" value="<?= $a ?>"> <br>
        b = <input type="text" name="b" value="<?= $b ?>"> <br>
        <button type="submit">Oldd meg!</button>
    </form>
    <?php if (isset($x)): ?>
        x = <?= $x ?>
    <?php endif; ?>
</body>
</html>