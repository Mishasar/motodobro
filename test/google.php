<?
echo 4;
require __DIR__ . '../pma/vendor/autoload.php';
echo 3;
var_dump(10);

echo 2;
// Путь к файлу ключа сервисного аккаунта
$googleAccountKeyFilePath = __DIR__ . '/assets/my-project-test1-fdd689d70f55.json';
putenv( 'GOOGLE_APPLICATION_CREDENTIALS=' . $googleAccountKeyFilePath );

// Документация https://developers.google.com/sheets/api/
$client = new Google_Client();
$client->useApplicationDefaultCredentials();

// Области, к которым будет доступ
// https://developers.google.com/identity/protocols/googlescopes
$client->addScope( 'https://www.googleapis.com/auth/spreadsheets' );

$service = new Google_Service_Sheets( $client );

// ID таблицы
$spreadsheetId = '1KdTaK81c3BURTW4D7QMGgkEexd_ATYx3pUiUNbsmNlY';
