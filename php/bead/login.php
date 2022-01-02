<title>ElteStadion::Login</title>
<?php
 include('core.php');
  $errors = [];

  if ($_GET["act"] == 1) {

      $myun = $_GET["un"];
      $mypw = $_GET["pw"];


      if ( trim($myun) === '' ) {
        $errors["un_empty"] = 'Must fill in Username<br/>';
      }
      if ( trim($mypw) === '' ) {
          $errors["pw_empty"] = 'Must fill in Password<br/>';
      }

      if ($un[$myun] && $un[$myun]["pw"] == $mypw ) {

          $_SESSION["un"] = $myun;
          $_SESSION["is_admin"] =  $myun === "admin" && $mypw === "admin";

      } else if (count($errors) == 0 ){
         $errors['invalid'] = 'Invalid Username or Password!<br/>';
      }

  }
?>

<?php if ($_GET['fromreg']): ?>
    <div class="c info">
        Successful registration. You may now log in.
    </div>
    <br/>
<?php endif; ?>
<?php if (count($_GET) > 0 && count($errors) > 0): ?>
    <div class="c error">
        Cannot log in. Reason: <br/>
        <?php echo $errors['invalid'] ?? '' ?>
        <?php echo $errors['un_empty'] ?? '' ?>
        <?php echo $errors['pw_empty'] ?? '' ?>
    </div>
    <br/>
<?php endif; ?>

<form class="c"  action="login.php" method="get" novalidate>
    <h2>Login</h2>
    <label>
        Username <br/>
        <input type="text" name="un" />
    </label>
    <br/>
    <label>
        Password <br/>
        <input type="password" name="pw"/>
    </label>
    <br/><br/>
    <input type="hidden" value="1" name="act"/>
    <input type="submit" value="Login" name="sm"/>
</form>


