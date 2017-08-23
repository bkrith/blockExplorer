<!--
Block Explorer - Burstcoin block explorer 
Copyright (C) 2017 Vassilis 

This program is free software: you can redistribute it and/or modify it under the terms of 
the GNU General Public License as published by the Free Software Foundation, either version 
3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. 
If not, see <http://www.gnu.org/licenses/>.

Make a donation to the author Vassilis ( BURST-YY7Z-K8KK-E2B9-AKQCQ )

-->

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

$f3->run();
