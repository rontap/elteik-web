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


?>
<body>
  <h1>Gift list</h1>
  <h2>My family members</h2>
  <ul>

        <?php foreach ($fam as $mem): ?>
      <li>
          <a href="member.php?id=<?= $mem["id"]?>">
              <?= $mem["name"] ?>
          </a>
          (
          <?= count(array_filter( $mem['ideas'] , fn($n) => $n["status"] === "ok")) ?>
          /
          <?= count(array_filter( $mem['ideas'] , fn($n) => $n["status"] !== "discarded")) ?>
          )
      </li>
      <?php endforeach; ?>



  </ul>
</body>
</html>