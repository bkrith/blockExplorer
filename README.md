# Block Explorer

Block explorer for burstcoin network based on wallet api

## Getting Started

Clone the github repository and use for apache server the htaccess.default settings and for nginx server the nginx.default settings.

### Prerequisites

Must have access to a local or online burst wallet and a server(apache, nginx, etc) with php support and mySQL database server.

### Installing

Clone the github repository.

Set the tmp folder to full privilage(and a suitable user with server privilage maybe) to allow temporary storage and caching of app.

In config.ini file you can set your global variables.

If you want to use the winners app you must create a database and a user for this. For example:

```
echo "CREATE DATABASE winners; CREATE USER 'winners'@'localhost' IDENTIFIED BY 'yourpassword'; GRANT ALL PRIVILEGES ON winners.* TO 'winners'@'localhost';" | mysql -uroot
mysql -uroot winners < winners.sql
```

For database use set true the mySqlEnabled variable in config.ini.

Also you must uncomment and set your database name, user and password in index.php.

```
$f3->set('db', new DB\SQL(
    'mysql:host=localhost;port=3306;dbname=winners', <- database name
    'winners', <- username
	'12345678', <- password
	array( 
		\PDO::ATTR_ERRMODE => \PDO::ERRMODE_EXCEPTION 
	)
));
```

At first time will be need some minutes to initialize the database table.

## Built With

* [Fat-Free Framework](https://fatfreeframework.com/) - The web framework 
* [Material Design Lite](https://getmdl.io/) - Material design for interface
* [jQuery](https://jquery.com/) - JQuery
* [jQuery.simplecolorpicker](https://github.com/tkrotoff/jquery-simplecolorpicker) - JQuery Color Picker

## Authors

* **Vassilis** - If you like it make a donation BURST-YY7Z-K8KK-E2B9-AKQCQ

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

