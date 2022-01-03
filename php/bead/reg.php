<title>ElteStadion::Registration</title>
<?php
include('core.php');
$errors = [];
$myun = $_GET["un"] ?? '';
$mypw = $_GET["pw"] ?? '';
$mypw2 = $_GET["pw2"] ?? '';
$myemail = $_GET["email"] ?? '';


if ($_GET["act"] == 1) {

    // generic error handling
    if (trim($myun) === '')
        $errors['un'] = 'Must give Username!';

    if (trim($mypw) === '')
        $errors['pw'] = 'Must give Password!';
    if (trim($mypw2) === '')
        $errors['pw2'] = 'Must give Repeated Password!';
    else if ($mypw !== $mypw2)
        $errors['pw2'] = 'Two passwords do not match!';

    if (trim($myemail) === '')
        $errors['email'] = 'Must give E-mail Address!';
    else if (!filter_var(trim($myemail), FILTER_VALIDATE_EMAIL))
        $errors['email'] = 'Must give valid E-mail Address!';


    if ($un[$myun] !== null)
        $errors['un'] = 'User with this username already exists!';

    if (count($errors) == 0) {
        //register
        $un[$myun] = [
           "email" => $myemail,
           "un" => $myun,
           "pw" => $mypw
        ];

        file_put_contents('users.json', json_encode($un, JSON_PRETTY_PRINT));
        header('Location: login.php?fromreg=1');
    }
}
?>


<form class="c" action="reg.php" method="get" novalidate>
    <h2>Register</h2>
    <label>
        Username <br/>
        <input type="text" name="un" value="<?= $myun ?>"/>
        <span class="e"><?= $errors['un'] ?? '' ?></span>
    </label>
    <br/>
    <label>
        Email address <br/>
        <input type="email" name="email" value="<?= $myemail ?>"/>
        <span class="e"><?= $errors['email'] ?? '' ?></span>
    </label>
    <br/>
    <label>
        Password <br/>
        <input type="password" name="pw" value="<?= $mypw ?>"/>
        <span class="e"><?= $errors['pw'] ?? '' ?></span>
    </label>
    <br/>
    <label>
        Password (again) <br/>
        <input type="password" name="pw2" value="<?= $mypw2 ?>"/>
        <span class="e"><?= $errors['pw2'] ?? '' ?></span>
    </label>
    <br/><br/>
    <input type="hidden" value="1" name="act"/>
    <input type="submit" value="Register" name="sm" class="btn btn-primary"/>
</form>


