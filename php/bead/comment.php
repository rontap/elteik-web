<?php

include('core.php');

if ($_SESSION["is_admin"] && $_GET["delete"]) {
    unset($comments[$_GET["delete"]]);
    var_dump($comments);
    file_put_contents('comments.json', json_encode($comments, JSON_PRETTY_PRINT));
    header('Location: team.php?comment=deleted&id=' . $_GET["team"] . '#comments');
} else if (trim($_GET["comment"]) === "") {
    header('Location: team.php?comment=empty&id=' . $_GET["team"] . '#comments');
} else {

    $comments[] = [
        'un' => $_SESSION["un"],
        'text' => $_GET["comment"],
        'ts' => date('Y-m-d h:i'),
        'team' => $_GET["team"]
    ];

    file_put_contents('comments.json', json_encode($comments, JSON_PRETTY_PRINT));

    header('Location: team.php?comment=ok&id=' . $_GET["team"] . '#comments');

    var_dump($comments);
}

?>