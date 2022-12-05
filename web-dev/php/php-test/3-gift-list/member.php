<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gift list</title>
    <link rel="stylesheet" href="index.css">
</head>
<?php
$fam = json_decode(file_get_contents('members.json'), true);
$member = $fam[$_GET['id']];
?>
<body>
<h1>Ideas for <?= $member['name'] ?></h1>
<a href="index.php">Back to main page</a>
<form action="new.php" method="post">
    <fieldset>
        <legend>New idea</legend>
        <input type="hidden" name="id" value="<?= $_GET['id'] ?>"/>
        Idea: <input type="text" name="idea" required> <br>
        <button name="function-add" type="submit">Add new idea</button>
    </fieldset>
</form>
<ul>
    <?php foreach ($member["ideas"] as $i => $ids): ?>

        <?php if ($ids["status"] === "ok"): ?>
            <li class="ok">
                <?= $ids["text"] ?>
            </li>
        <?php endif; ?>

    <?php endforeach; ?>

    <?php foreach ($member["ideas"] as $i => $ids): ?>

        <?php if ($ids["status"] === "new"): ?>
            <li class="new">
                <?= $ids["text"] ?>
                <form action="edit.php" method="post">
                    <input type="hidden" name="idea-id" value="<?= $i ?>">
                    <input type="hidden" name="id" value="<?= $_GET['id'] ?>"/>
                    <button type="submit" name="function-ok">Got it!</button>
                    <button type="submit" name="function-discard">Discard it!</button>
                </form>
            </li>
        <?php endif; ?>
    <?php endforeach; ?>

    <?php foreach ($member["ideas"] as $i => $ids): ?>
        <?php if ($ids["status"] === "discarded"): ?>
            <li class="discarded">
                <?= $ids["text"] ?>
            </li>
        <?php endif; ?>
    <?php endforeach; ?>
</ul>
</body>
</html>