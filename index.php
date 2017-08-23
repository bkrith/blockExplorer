
<?php

error_reporting(0);
ini_set('display_errors', 0);
ini_set("allow_url_fopen", 1);

// Kickstart the framework
$f3=require('lib/base.php');

if ((float)PCRE_VERSION<7.9)
	trigger_error('PCRE version is out of date');

// Load configuration
$f3->config('config.ini');

$f3->set('ONERROR',function($f3){
	echo \Template::instance()->render('header.tpl');
	echo \Template::instance()->render('topbar.tpl');
	echo \Template::instance()->render('404.tpl');
	echo \Template::instance()->render('footer.tpl');
});

$f3->config('routes.ini');

$f3->set('wallet', 'https://wallet.burst.cryptoguru.org:8125');
$f3->set('timeSeed', 1407729600); // GMT: Monday, August 11, 2014 4:00:00 AM

$f3->run();
