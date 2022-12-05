<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>2. feladat</title>
</head>
<body>
<?php
$post = $_POST['post'];
$id = $_POST['product_id'] ?? '';
$old = $_POST['old_price'] ?? '';
$new = $_POST['new_price'] ?? '';
$errors = [];
if (count($_POST) > 0) {


    if (strlen($id) != 6) { // nem tudjuk kizárni, hogy space is van termékazonosítóban.
        $errors['product_id'] = 'Termékazonosító kötelező, és kötelezően 6 karakter kell!';
    }

    if (trim($old) === '') {
        $errors['old_price'] = 'Régi ár kitöltése kötelező';
    } else if (filter_var($old, FILTER_VALIDATE_INT) === false) {
        $errors['old_price'] = 'Régi ár kitöltése egész számnak kell lennie.';
    }

    if (trim($new) === '') {
        $errors['new_price'] = 'Új ár kitöltése kötelező';
    } else if (filter_var($new, FILTER_VALIDATE_INT) === false) {
        $errors['new_price'] = 'Új ár kitöltése egész számnak kell lennie.';
    } else if ($old-1 < $new) {
        $errors['new_price'] = 'Leárazásnál az új árnak csökkennie kell.';
    } else if($old == 0) {
        $errors['new_price'] = 'Új árnak pozitívnak kell lennie.';
    }
}
?>
<h1>Leárazáskalkulátor</h1>
<form action="2.php" method="post" novalidate>
    <input type="hidden" value="1" name="post" ;

    <label for="product_id">Termékazonosító:</label>
    <input type="text" name="product_id" value="<?= $id ?>">
    <span class="danger"> <?= $errors['product_id'] ?? '' ?></span>
    <br>
    <label for="old_price">Régi ár:</label><input type="text" name="old_price" value="<?= $old ?>">
    <span class="danger"><?= $errors['old_price'] ?? '' ?></span>
    <br>
    <label for="new_price">Új ár:</label><input type="text" name="new_price" value="<?= $new ?>">
    <span class="danger"><?= $errors['new_price'] ?? '' ?></span>
    <br>
    <button type="submit">OK</button>
    <br/>

</form>
<?php if (count($errors) == 0): ?>
    <br/><span>Leárazás: <?= 100 * ($old - $new) / $old ?>%</span>
<?php endif; ?>

</body>
</html>