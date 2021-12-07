<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>3. feladat</title>
</head>
<body>
<!-- Ez két oldal egyben, ezek közül egyszerre csak az egyiket kell
megjeleníteni, vagy akár ki is lehet szervezni külön fájlokba! -->
<?php
$reg = json_decode(file_get_contents('3.json'), true);

if (isset($_POST["notes"])) {

    if (isset($_POST['edit'])) {

        $notes = $_POST['notes'];
        if (isset($reg[$_POST['edit']])) {
            $reg[$_POST['edit']]["notes"] = $notes;
            file_put_contents('3.json', json_encode($reg, JSON_PRETTY_PRINT));
        }
    }
    //header("location 3.php");
}
?>
<h1>Szállítási címek</h1>
<?php foreach ($reg as $r): ?>
    <li><a href="3.php?edit=<?= $r['id'] ?>"> <?= $r['address'] ?> </a></li>
<?php endforeach; ?>


<?php if (isset($_GET['edit']) && $_GET["edit"] != ""): ?>

    <?php
    $e = $_GET['edit'];
    ?>

    <h1>Cím részletei</h1>
    <form action="3.php" method="post">
        <b>Azonosító:</b> <?= $reg[$e]['id'] ?> <br>
        <b>Cím:</b> <?= $reg[$e]['address'] ?><br>
        <b>Megjegyzés:</b> <br>
        <input type="hidden" value="<?= $reg[$e]['id'] ?>" name="edit"/>
        <textarea name="notes" cols="60" rows="4"><?= $reg[$e]['notes'] ?></textarea> <br>
        <button type="submit">Mentés</button>
    </form>

<?php endif; ?>
</body>
</html>