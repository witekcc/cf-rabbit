<cfscript>
	application.stopProducer = false;
	
	// Create new channel for this interaction
	application.channel = application.connection.createChannel();

	// Crete Queue just in case
	application.channel.queueDeclare( "stock.prices", 
						  javaCast( "boolean", true ), //make messages permanent
						  javaCast( "boolean", false ), 
						  javaCast( "boolean", true ), 
						  javaCast( "null", "" ) );

	// create task
	producerTask = createDynamicProxy( new ProducerTask( application.channel, application.messageProperties), [ "java.lang.Runnable" ] );
	
	// start the producer thread
    thread = createObject( "java", "java.lang.Thread" )
    	.init( producerTask )
    	.start();

</cfscript>
<h1>Publisher started!</h1>
<a href="stop.cfm">Stop Publisher</a>