<html>
<?php
session_start();
$un = json_decode(file_get_contents('users.json'), true);
$teams = json_decode(file_get_contents('teams.json'), true);

$games = json_decode(file_get_contents('games.json'), true);
$comments = json_decode(file_get_contents('comments.json'), true);
?>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<link rel="stylesheet" href="main.css"/>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.php">ELTE Stadion</a>

        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
            <li class="nav-item ">
                <a class="nav-link">user <?= $_SESSION["un"] ??  'not logged in.' ?> // </a>
            </li>
            <li class="nav-item ">
                <a href="login.php" class="nav-link">Login </a>
            </li>
            <li class="nav-item">
                <a href="reg.php" class="nav-link">Register</a>
            </li>

            <?php if ($_SESSION['un']): ?>
            <li class="nav-item">
                <a href="logout.php" class="nav-link">Logout</a>
            </li>
            <?php endif; ?>
        </ul>
    </div>
</nav>