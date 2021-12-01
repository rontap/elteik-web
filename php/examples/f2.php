<?php
    $nev = "Ismeretlen";
    // SZUPERGLOBÁLIS VÁLTOZÓK: $_GET
    if (isset($_GET["felh"]) && trim($_GET["felh"]) !== ""){
        $nev = $_GET["felh"];
    }
?>
<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hello</title>
</head>
<body>
    <h1>Helló, <?= $nev ?>!</h1>
    <form action="f2.php" method="get">
        Név: <input type="text" name="felh" value="<?= $nev ?>"> <br>
        <button type="submit">Köszönj nekem!</button>
    </form>
</body>
</html>