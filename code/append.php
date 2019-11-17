<?

require_once __DIR__ . '/vendor/autoload.php';

function addRowToSpreadsheet($ary_values = array()) {
    // Set up the API
    $client = new Google_Client();
    $googleAccountKeyFilePath = __DIR__ . '/assets/motodobro-5cf315f48325.json';
    $client->setAuthConfigFile($googleAccountKeyFilePath); // Use your own client_secret JSON file
    $client->addScope(Google_Service_Sheets::SPREADSHEETS);
    $accessToken = 'ACCESS_TOKEN'; // Use your generated access token
    $client->setAccessToken($accessToken);
    $sheet_service = new Google_Service_Sheets($client);
    // Set the sheet ID
    $fileId = '1m0RQD4Xl24eu_mHfX0yJy8qR7bSNFwujHBFNtbl3X7o'; // Copy & paste from a spreadsheet URL
    // Build the CellData array
    $values = array();
    foreach( $ary_values AS $d ) {
        $cellData = new Google_Service_Sheets_CellData();
        $value = new Google_Service_Sheets_ExtendedValue();
        $value->setStringValue($d);
        $cellData->setUserEnteredValue($value);
        $values[] = $cellData;
    }
    // Build the RowData
    $rowData = new Google_Service_Sheets_RowData();
    $rowData->setValues($values);
    // Prepare the request
    $append_request = new Google_Service_Sheets_AppendCellsRequest();
    $append_request->setSheetId(144339035);
    $append_request->setRows($rowData);
    $append_request->setFields('userEnteredValue');
    // Set the request
    $request = new Google_Service_Sheets_Request();
    $request->setAppendCells($append_request);
    // Add the request to the requests array
    $requests = array();
    $requests[] = $request;
    // Prepare the update
    $batchUpdateRequest = new Google_Service_Sheets_BatchUpdateSpreadsheetRequest(array(
        'requests' => $requests
    ));

    try {
        // Execute the request
        $response = $sheet_service->spreadsheets->batchUpdate($fileId, $batchUpdateRequest);
        if( $response->valid() ) {
            // Success, the row has been added
            return true;
        }
    } catch (Exception $e) {
//        // Something went wrong
        error_log($e->getMessage());
    }

    return false;
}