
<?php

error_reporting(0); // for reporting all errors set E_ALL
ini_set('display_errors', 0); // for reporting all errors set 1
ini_set("allow_url_fopen", 1);

// Kickstart the framework
$f3=require('lib/base.php');

if ((float)PCRE_VERSION<7.9)
	trigger_error('PCRE version is out of date');

// Load configuration - Global Variables
$f3->config('config.ini');

/*
$f3->set('ONERROR',function($f3){
	echo \Template::instance()->render('header.tpl');
	echo \Template::instance()->render('topbar.tpl');
	echo \Template::instance()->render('404.tpl');
	echo \Template::instance()->render('footer.tpl');
});
*/

$f3->config('routes.ini');

$f3->run();
