<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="index.css">
    <title>Performance</title>
</head>
<body>
<?php

$post = $_GET['post'];
$nc = $_GET['num_children'];
$cn = $_GET['children_names'];
$url = $_GET['music_url'];
$pt = $_GET['performance_type'];
$r = $_GET['ready'];
$errors = [];

if (count($_GET) > 0) {

    if (trim($nc) === '') {
        $errors['num_children'] = 'paraméter kitöltése kötelező';
    } else if (filter_var($nc, FILTER_VALIDATE_INT) === false) {
        $errors['num_children'] = 'egész számnak kell lennie.';
    } else if ($nc == 0) {
        $errors['num_children'] = 'gyerekek száma nem lehet nulla.';
    }

    if (trim($cn) === '') {
        $errors['children_names'] = 'paraméter kitöltése kötelező';
    } else if (
        !isset($errors['num_children']) &&
        count(explode(",",$cn)) != intval($nc)
    ) {
        $errors['children_names'] = '"Number of Children" számú nevet kell tartalmaznia vesszővel elválasztva';
    }

    if (trim($url) === '') {
        $errors['music_url'] = 'paraméter kitöltése kötelező';
    } else if ( filter_var($url, FILTER_VALIDATE_URL) === false) {
        $errors['music_url'] = 'nem helyes URL formátum!';
    }

    if (trim($url) === '') {
        $errors['performance_type'] = 'paraméter kitöltése kötelező';
    } else if ( $pt !== "poem" && $pt !== "song") {
        // milyen barbár felület az, ahol text input van, de csak két lehetséges beírható szöveg van? :)
        // neptun-level UX, de mindent a megrendelőért
        $errors['performance_type'] = 'Érték csak poem vagy song lehet!';
    }

    if ($r !== 'on') {
        $errors['ready'] = 'Someone is not ready yet!';
    }
 }

?>

<h1>Performance</h1>
<form action="index.php" method="get" novalidate>
    <label for="i1">Number of children:</label>
    <input type="text" name="num_children" id="i1" value="<?= $nc ?>">
    <span class="danger"><?= $errors['num_children'] ?? '' ?></span><br>

    <label for="i2">Children's names:</label>
    <input type="text" name="children_names" id="i2" value="<?= $cn ?>">
    <span class="danger"><?= $errors['children_names'] ?? '' ?></span><br>

    <label for="i3">URL of music to be played:</label>
    <input type="text" name="music_url" id="i3" value="<?= $url ?>">
    <span class="danger"><?= $errors['music_url'] ?? '' ?></span><br>

    <label for="i4">Performance type:</label>
    <input type="text" name="performance_type" id="i4" value="<?= $pt ?>">
    <span class="danger"><?= $errors['performance_type'] ?? '' ?></span><br>

    <input type="checkbox" name="ready" id="i5" <?= $r === 'on' ? 'checked' : '' ?>>
    <label for="i5">Everyone is ready</label>
    <span class="danger"><?= $errors['ready'] ?? '' ?></span>
   <br>

    <button type="submit">Submit</button>
</form>

<?php if (count($errors) == 0): ?>
    <div class="merry">🎄 MERRY CHRISTMAS AND HAPPY NEW YEAR! 🎄</div>
<?php endif; ?>

<h2>Test cases</h2>
( kihagyott rickroll lehetőség )<br/>
<a href="index.php?num_children=&children_names=&music_url=&performance_type=">num_children=&children_names=&music_url=&performance_type=</a><br>
<a href="index.php?num_children=n&children_names=&music_url=&performance_type=">num_children=n&children_names=&music_url=&performance_type=</a><br>
<a href="index.php?num_children=6.7&children_names=&music_url=&performance_type=">num_children=6.7&children_names=&music_url=&performance_type=</a><br>
<a href="index.php?num_children=0&children_names=&music_url=&performance_type=">num_children=0&children_names=&music_url=&performance_type=</a><br>
<a href="index.php?num_children=3&children_names=Adam%2CBarbara&music_url=&performance_type=">num_children=3&children_names=Adam%2CBarbara&music_url=&performance_type=</a><br>
<a href="index.php?num_children=3&children_names=Adam%2CBarbara%2CChloe&music_url=&performance_type=">num_children=3&children_names=Adam%2CBarbara%2CChloe&music_url=&performance_type=</a><br>
<a href="index.php?num_children=3&children_names=Adam%2CBarbara%2CChloe&music_url=5c3ezwen&performance_type=">num_children=3&children_names=Adam%2CBarbara%2CChloe&music_url=5c3ezwen&performance_type=</a><br>
<a href="index.php?num_children=3&children_names=Adam%2CBarbara%2CChloe&music_url=http%3A%2F%2Ftinyurl.com%2F5c3ezwen&performance_type=">num_children=3&children_names=Adam%2CBarbara%2CChloe&music_url=http%3A%2F%2Ftinyurl.com%2F5c3ezwen&performance_type=</a><br>
<a href="index.php?num_children=3&children_names=Adam%2CBarbara%2CChloe&music_url=http%3A%2F%2Ftinyurl.com%2F5c3ezwen&performance_type=good">num_children=3&children_names=Adam%2CBarbara%2CChloe&music_url=http%3A%2F%2Ftinyurl.com%2F5c3ezwen&performance_type=good</a><br>
<a href="index.php?num_children=3&children_names=Adam%2CBarbara%2CChloe&music_url=http%3A%2F%2Ftinyurl.com%2F5c3ezwen&performance_type=song">num_children=3&children_names=Adam%2CBarbara%2CChloe&music_url=http%3A%2F%2Ftinyurl.com%2F5c3ezwen&performance_type=song</a><br>
<a href="index.php?num_children=3&children_names=Adam%2CBarbara%2CChloe&music_url=http%3A%2F%2Ftinyurl.com%2F5c3ezwen&performance_type=song&ready=on">num_children=3&children_names=Adam%2CBarbara%2CChloe&music_url=http%3A%2F%2Ftinyurl.com%2F5c3ezwen&performance_type=song&ready=on</a><br>
</body>
</html>
