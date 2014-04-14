<?php

session_name( 'cetinapp' );
if(session_id() == '') {
    session_start();
}

define( "ROOT", dirname(__FILE__) );

/*
define( "DB_NAME", "CetinApp" );
define( "DB_USER", "root" );
define( "DB_PASSWORD", "root" );
define( "DB_HOST", "localhost" );
*/

define( "DB_NAME", "turushan_cetinapp" );
define( "DB_USER", "turushan_ctnapp" );
define( "DB_PASSWORD", "cetinapp" );
define( "DB_HOST", "localhost" );


//define( "DOMAIN", "http://localhost:8888" );
define( "DOMAIN", "http://cevikogullari.com" );

define( "TABLE_CHATROOM", 'chatroom' );
define( "TABLE_USER", 'user' );
define( "TABLE_USER_CHATROOM", 'user_chatroom' );
define( "TABLE_USER_FRIEND", 'user_friend' );
define( "TABLE_USER_MESSAGE", 'user_message' );

// Load components
$classes = glob( ROOT . "/classes/*.php" );
if ( $classes && is_array( $classes ) ) {
	foreach ( $classes as $file ) {
		include_once $file;
	}
}
unset( $classes );

// Load required php functions
$functions = glob( ROOT . "/functions/*.php" );
if ( $functions && is_array( $functions ) ) {
	foreach ( $functions as $file ) {
		include_once $file;
	}
}
unset( $functions );