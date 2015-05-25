/**
* A runnable task that implmements runnable via dynamic proxy
*/
component accessors="true"{

	property name="channel";
	property name="id";
	property name="priceGenerator";

	function init( channel, messageProperties ){
		variables.id 				= left( createUUID(), 3 );
		variables.channel   		= arguments.channel;
        variables.messageProperties  		= arguments.messageProperties;
		variables.priceGenerator 	= new PriceGenerator();

		// application reference
		variables.app 		= application;
		return this;
	}

	function run(){

			var price = variables.priceGenerator.nextPrice();
			writeDump( var="Producing: #price#", output="console" );

            variables.channel.basicPublish( "", 
											"stock.prices", 
											variables.messageProperties.PERSISTENT_TEXT_PLAIN, /*javaCast( "null", ""),*/  //make messages permanent
											price.getBytes() );
                                            
                                            

		/*
        while( !variables.app.stopProducer ){
			var price = variables.priceGenerator.nextPrice();
			writeDump( var="Producing: #price#", output="console" );

			variables.channel.basicPublish( "", 
											"stock.prices", 
											javaCast( "null", ""),
											price.getBytes() );

			sleep( 500 );
		}*/

		writeDump( var="Stopping Producer : #variables.id#", output="console" );
	}

}