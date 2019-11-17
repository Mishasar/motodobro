<?

header( "Content-Type: text/xml; charset=utf-8" );



if (file_exists('insite3.xml')) {

$xml_root = simplexml_load_file('insite3.xml');



$host = $_SERVER['HTTP_HOST'];

$host = str_replace("motodobro.ru", "", $host);



echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?><urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">";



foreach ($xml_root->sitemap as $sitemap) {

$filename = str_replace("http://motodobro.ru/", "", $sitemap->loc);



if (file_exists($filename)) {

$xml = simplexml_load_file($filename);

foreach ($xml->url as $url){
$ii = $url->lastmod;

	if (!$ii==0){
		echo "<url><loc>".str_replace("motodobro.ru", $host."motodobro.ru", $url->loc)."</loc><lastmod>".$url->lastmod."</lastmod></url>" ;
	}elseif($ii==0) {
		echo "<url><loc>".str_replace("motodobro.ru", $host."motodobro.ru", $url->loc)."</loc></url>" ;
	}
}
}

}

echo "</urlset>";

}

?>
