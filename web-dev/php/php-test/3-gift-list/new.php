<?php

$fam = json_decode(file_get_contents('members.json'), true);

var_dump($_POST);

$ideas = $fam[ $_POST['id'] ]["ideas"];
$vars = [
    'status' => 'new',
    'text' => $_POST['idea']
];
array_push( $ideas, $vars );
echo "<br/><br/>";
var_dump($vars);
var_dump($ideas);
$fam[ $_POST['id'] ]["ideas"] = $ideas ;

echo "<br/><br/>";
file_put_contents('members.json', json_encode($fam, JSON_PRETTY_PRINT));

header("Location: member.php?id=".$_POST['id']);
?>