
<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);
ini_set("allow_url_fopen", 1);

// Kickstart the framework
$f3=require('lib/base.php');

if ((float)PCRE_VERSION<7.9)
	trigger_error('PCRE version is out of date');

// Load configuration
$f3->config('config.ini');


$f3->config('routes.ini');

$f3->set('wallet', 'https://wallet.burst.cryptoguru.org:8125');
$f3->set('timeSeed', 1407729600); // GMT: Monday, August 11, 2014 4:00:00 AM

$f3->run();
