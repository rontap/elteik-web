<?php
include('core.php');

$errors = [];
$mygame = $games[$_GET["id"]];
$id = $_GET["id"];
$edit = $_GET["edit"];
if ($_GET["delete"]) {
    //DELETE THIS STUFFFF
    unset($games[$id]);
    file_put_contents('games.json', json_encode($games, JSON_PRETTY_PRINT));
    header("Location: team.php?id=".$_GET["edit"]);
}
if (count($_POST) > 0) {
    $mygame["home_score"] = $_POST["home_score"] ?? '';
    $mygame["away_score"] = $_POST["away_score"] ?? '';
    $mygame["date"] = $_POST["date"] ?? '';

    if ( trim($_POST["home_score"]) === '' ) {
        $errors["home_score"] = 'Must fill in Home Score';
    }
    if ( trim($_POST["away_score"]) === '' ) {
        $errors["away_score"] = 'Must fill in Away Score';
    }
    if ( trim($_POST["date"]) === '' ) {
        $errors["date"] = 'Must fill in Date in format YYYY-MM-DD';
    }

    if ( trim($_POST["home_score"]) !== '0' && ! filter_var(trim($_POST["home_score"]), FILTER_VALIDATE_INT) ) {
        $errors["home_score"] = 'Home score must be number';
    }
    if ( trim($_POST["away_score"]) !== '0' && ! filter_var(trim($_POST["away_score"]), FILTER_VALIDATE_INT) ) {
        $errors["away_score"] = 'away score must be number';
    }
    if ( count(date_parse_from_format('Y-m-d', $_POST["date"])["errors"]) >0 ) {
        $errors["date"] = 'Invalid date format. Must be in YYYY-MM-DD';
    }

    if  (count($errors) == 0) {
        $games[$id] = $mygame;
        file_put_contents('games.json', json_encode($games, JSON_PRETTY_PRINT));
        header("Location: team.php?id=".$_GET["edit"]);
    }
} else {

}

?>
<title>ElteStadion::Edit</title>

<h1>Game between  <?= $teams[$mygame["home_team"]]["name"] ?>  and  <?= $teams[$mygame["away_team"]]["name"] ?></h1>
<br/>
<div  class="c" >
<form action="edit.php?id=<?=$id?>&edit=<?=$edit?>" method="post" novalidate>
    <h2>Edit</h2>
    <label>
        Home Team Score (  <?= $teams[$mygame["home_team"]]["name"] ?> )<br/>
        <input type="number" name="home_score" value="<?= $mygame["home_score"] ?>"/>
        <span class="e"><?= $errors['home_score'] ?? '' ?></span>
    </label>
    <br/>
    <label>
        Away Team Score (  <?= $teams[$mygame["away_team"]]["name"] ?> )<br/>
        <input type="number" name="away_score" value="<?= $mygame["away_score"] ?>"/>
        <span class="e"><?= $errors['away_score'] ?? '' ?></span>
    </label>
    <br/>
    <label>
        Date <br/>
        <input type="text" name="date" value="<?= $mygame["date"] ?>"/>
        <span class="e"><?= $errors['date'] ?? '' ?></span>
    </label>
    <br/>
    <br/>
    If the game is not played yet, or was cancelled on the date, put -1 to both scores.

    <br/><br/>
    <input type="hidden" value="1" name="act"/>
    <input type="submit" value="Submit Edit" name="sm" class="btn btn-primary"/>
</form>

<hr/>
<a href="edit.php?id=<?=$id?>&edit=<?=$edit?>&delete=1">
    <button class="btn btn-danger">Delete Game</button>
</a>
</div>