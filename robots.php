<?php

header('Content-type: text/plain');

$host = $_SERVER['HTTP_HOST'];

$host = "http://".$host."/sitemap.xml"; 

print_r("User-agent: Yandex"); print_r("\n");

print_r("User-agent: *"); print_r("\n");


print_r("Host: ".$_SERVER['HTTP_HOST']); print_r("\n");

print_r("Sitemap: ".$host); print_r("\n");

?>
