<?php
include('core.php');
?>
<title>ElteStadion::Main</title>

<h2>Teams</h2>
<?php foreach ($teams as $team): ?>

    <li>
        <a href="team.php?id=<?= $team["id"] ?>">
            <?= $team["name"] ?>
        </a>
    </li>

<?php endforeach; ?>


<h2>Last 5 Games</h2>
