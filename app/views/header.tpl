<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="{{ @ENCODING }}" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="Burstcoin block explorer">
		<meta name="author" content="Vassilis">
		<title>{{ @title }}</title>
		<base href="{{ @SCHEME . '://' . @HOST . ':' . @PORT . @BASE . '/'}}" />
		<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900" rel="stylesheet">
		<link rel="stylesheet" href="{{ @BASE }}/lib/code.css" type="text/css" />
		<link rel="stylesheet" href="{{ @BASE }}/ui/css/style.css" type="text/css" />
		<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
		<link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
		<link rel="stylesheet" href="{{ @BASE }}/ui/css/jquery.simplecolorpicker.css" type="text/css" />
		<link rel="stylesheet" href="{{ @BASE }}/ui/css/jquery.simplecolorpicker-regularfont.css" type="text/css" />
		<script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>
		<script src="{{ @BASE }}/ui/js/jquery-3.2.1.min.js"></script>
		<script src="{{ @BASE }}/ui/js/jquery-simplecolorpicker/jquery.simplecolorpicker.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.min.js"></script>
	</head>
	<body>
