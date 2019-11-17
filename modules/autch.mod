<?php

function login($s_login, $s_pass)
{
  if($s_pass != ''):
      $s  = sql("SELECT id FROM client WHERE email='$s_login' AND psw='$s_pass'");
      if (mysql_num_rows($s) > 0):
          $r = mysql_fetch_array($s);
          //session_register('user_id');
          $_SESSION['user_id'] = $r['id'];
          $_SESSION['user_log'] = $s_login;
          $result = true;
      else:
          $result = false;
      endif;
  else:
     $result = false;
  endif;
  return $result;
}

function auth_Check($s_login, $s_pass)
{
  $result = false;
  if (isset($s_login) and $s_login != ""):
       if (login($s_login, $s_pass)):
          $result = true;
       endif;
  endif;
  return $result;
}


?>
