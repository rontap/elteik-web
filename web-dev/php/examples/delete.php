<?php
    if (isset($_GET['taj'])){
        $taj = $_GET['taj'];
        $reg = json_decode(file_get_contents('data.json'), true);
        if (isset($reg[$taj])){
            unset($reg[$taj]);
            file_put_contents('data.json', json_encode($reg, JSON_PRETTY_PRINT));
        }
    }
    header('location: index.php');
?>
