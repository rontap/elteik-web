<?php

$fam = json_decode(file_get_contents('members.json'), true);

var_dump($_POST);

$str = '';
if (isset($_POST['function-ok'])) {
    $str = 'ok';
} else if (isset($_POST['function-discard'])) {
    $str = 'discarded';
}

// :'( visszasírom az SQLt
$ideas = $fam[$_POST['id']]["ideas"][$_POST['idea-id']]['status'] = $str;

echo "<br/><br/>";
file_put_contents('members.json', json_encode($fam, JSON_PRETTY_PRINT));

header("Location: member.php?id=" . $_POST['id']);
?>