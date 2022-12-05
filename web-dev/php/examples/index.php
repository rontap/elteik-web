<?php
    $reg = json_decode(file_get_contents('data.json'), true);
    uasort($reg, function($a, $b){
        return strcmp($a['fullname'], $b['fullname']);
    });
?>

<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista</title>
</head>
<body>
    <a href="reg.php">Új regisztráció</a>
    <h1>Regisztráltak listája</h1>
    <ul>
        <?php foreach($reg as $r): ?>
            <li><a href="show.php?taj=<?= $r['taj'] ?>"> <?= $r['fullname'] ?> </a></li>
        <?php endforeach; ?>
    </ul>
</body>
</html>