<?php
include('core.php');
$t = $teams[$_GET["id"]];
$id = $_GET["id"];
?>
<title>ElteStadion::Team</title>

<section>
    <h1>Team <?= $t["name"] ?> </h1>

    Home City: <?= $t["city"] ?>

    <br/><br/>
    <h2>Games</h2>


    <?php
    $myteam = array_filter($games, fn($el) => $el["home_team"] == $id || $el["away_team"] == $id);

    ?>

    <table>
        <tr>
            <th>Date</th>
            <th>Home</th>
            <th>Away</th>
            <th>Score</th>
            <?php if ($_SESSION['is_admin']): ?>
                <th>Edit Game</th>
            <?php endif; ?>
        </tr>
        <?php foreach ($myteam as $i=>$game): ?>
            <tr class="<?php
            if ($game["home_score"] == -1) echo '';
            else if ($game["home_score"] == $game["away_score"]) echo 'd';
            else if ($game["home_score"] > $game["away_score"]) echo $id == $game["home_team"] ? 'w' : 'l';
            else echo $id != $game["home_team"] ? 'w' : 'l'
            ?>">
                <td> <?= $game["date"] ?> </td>
                <td> <?= $teams[$game["home_team"]]["name"] ?></td>
                <td> <?= $teams[$game["away_team"]]["name"] ?></td>
                <td>
                    <?php if ($game["home_score"] > -1): ?>
                        (
                        <?= $game["home_score"] ?> :
                        <?= $game["away_score"] ?>
                        )
                    <?php else: ?>
                        TBD
                    <?php endif; ?>
                </td>
                <?php if ($_SESSION['is_admin']): ?>
                <td>
                    <a href="edit.php?id=<?=$i?>&edit=<?=$id?>">
                        <button class="btn btn-info">Edit</button>
                    </a>
                </td>
                <?php endif; ?>
            </tr>
        <?php endforeach; ?>
    </table>


</section>
<br/><br/>
<section id="comments">

    <h2>Comments</h2>

    <?php if ($_GET["comment"] == "ok"): ?>
        <div class="c info c-nomargin">
            Comment added!
        </div>
    <?php endif;?>

    <?php if ($_GET["comment"] == "empty"): ?>
        <div class="c error c-nomargin">
            Your comment cannot be empty!
        </div>
    <?php endif;?>

    <?php if ($_GET["comment"] == "deleted"): ?>
        <div class="c info c-nomargin">
            Comment removed.
        </div>
    <?php endif;?>
    <br/>

    <?php if ($_SESSION["un"]): ?>
        <form class="c-nomargin" action="comment.php">
            <label id="comment">
                Add your own comment
                <br/><br/>
                <textarea name="comment" ></textarea>
            </label><br/>
            <input type="hidden" value="<?=$id?>" name="team"/>
            <input class="btn btn-primary" type="submit" value="Send Comment"/>
        </form>
    <?php else: ?>
        <div class="c info c-nomargin">
            To add your comment you must first <a href="login.php">log in</a>.
        </div>
    <?php endif; ?>


    <hr/>

    <?php
    $comments = array_filter($comments, fn($el) => $el["team"] == $id);
    ?>

    <?php foreach ($comments as $i=>$comment): ?>

        <div class="comment">
            <b> <?= $comment["un"] ?></b> at <?= $comment["ts"] ?> said: <br/><br/>
            <span><?= $comment["text"] ?></span>

            <?php if ($_SESSION['is_admin']): ?>
                <br/><br/>
                <a href="comment.php?team=<?=$id?>&delete=<?=$i?>">
                    <button class="btn btn-danger">Delete Comment</button>
                </a>
            <?php endif; ?>
        </div>

    <?php endforeach; ?>

</section>
<br/><br/>