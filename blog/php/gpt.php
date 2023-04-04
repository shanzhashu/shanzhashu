<?php
header('Content-type:text/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET,POST,OPTIONS');
header('Access-Control-Allow-Headers: *');

function http_post_json($url, $jsonStr)
{
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $jsonStr);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            'Content-Type: application/json; charset=utf-8',
            'Authorization: Bearer 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',
            'Content-Length: ' . strlen($jsonStr)
        )
    );
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);
 
    return array($httpCode, $response);
}

$in_json = file_get_contents('PHP://input');
$in_obj = json_decode($in_json, true);
#echo $in_obj['prompt'];

$url = "https://api.openai.com/v1/chat/completions";

$query_array = array();
$query_array['model'] = 'gpt-3.5-turbo';
$query_array['max_tokens'] = 3000;
$query_array['temperature'] = 0.5;
$query_array['top_p'] = 1;
$query_array['frequency_penalty'] = 0;
$query_array['presence_penalty'] = 0;

$msg_array = array();
$msg_array['role'] = 'user';
$msg_array['content'] = $in_obj['prompt'];
$msg_array2 = array($msg_array);

$query_array['messages'] = $msg_array2;
$jsonStr = json_encode($query_array);

#echo $jsonStr;

list($retCode, $retContent) = http_post_json($url, $jsonStr);

echo $retContent;
?>
