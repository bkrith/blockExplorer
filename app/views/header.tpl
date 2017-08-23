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

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="{{ @ENCODING }}" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="Burstcoin block explorer">
		<meta name="author" content="Vassilis">
		<title>Burst explorer by Vassilis</title>
		<base href="{{ @SCHEME . '://' . @HOST . ':' . @PORT . @BASE . '/'}}" />
		<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900" rel="stylesheet">
		<link rel="stylesheet" href="{{ @BASE }}/lib/code.css" type="text/css" />
		<link rel="stylesheet" href="{{ @BASE }}/ui/css/style.css" type="text/css" />
		<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
		<link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
		<script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>
	</head>
	<body>
