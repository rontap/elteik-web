<?php
include('core.php');
?>
<title>ElteStadion::Main</title>

<section>
    <h1>ELTE Stadion Games</h1>
    <p>
        This website is aimed at tracking all games played in the new
        ELTE University's Own football stadium!<br/>
        You can click on any team to see all their scores, and see their games.<br/>
        You can create an account, and then comment for your favourite team!!<br/>

    </p>
</section>
<section>
    <h2>Teams</h2>
    <?php foreach ($teams as $game): ?>

        <li>
            <a href="team.php?id=<?= $game["id"] ?>">
                <?= $game["name"] ?>
            </a>
        </li>

    <?php endforeach; ?>
</section>

<section>
    <h2>Last 5 Games</h2>

    <?php
    // games.json az IDŐ szerint rendezve van; le nem játszott meccseknél -1 az eredmény.
    $team_fil = array_filter($games, fn($el) => $el["home_score"] > -1 && $el["away_score"] > -1);

    function cpts($a, $b ) {
        return strtotime($b["date"]) - strtotime($a["date"]);
    }
    usort($team_fil, "cpts");
    $games_5 = array_reverse(array_slice(($team_fil), 0, 5));
    ?>

    <?php foreach ($games_5 as $game): ?>

        <li>
            <code> <?= $game["date"] ?></code> :
            <?= $teams[$game["home_team"]]["name"] ?> vs
            <?= $teams[$game["away_team"]]["name"] ?>
            (
            <?= $game["home_score"] ?> :
            <?= $game["away_score"] ?>
            )
            </a>
        </li>

    <?php endforeach; ?>

</section>