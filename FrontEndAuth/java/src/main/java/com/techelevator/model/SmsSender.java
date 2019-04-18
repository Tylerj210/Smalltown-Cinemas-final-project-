package com.techelevator.model;
import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;
public class SmsSender {

	    // Find your Account Sid and Token at twilio.com/console
	    // DANGER! This is insecure. See http://twil.io/secure
	    public static final String ACCOUNT_SID = "AC7ea97872e521af796502945e6299b3f3";
	    public static final String AUTH_TOKEN = "0dd822678e5f66c20c1ff0118a8c79bf";

	    
	    public static void message(String phoneNumber, String message) {
	    	Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
	        Message body = Message.creator(
	                new com.twilio.type.PhoneNumber(phoneNumber),
	                new com.twilio.type.PhoneNumber("+12162422287"),
	                message)
	            .create();
	    }
	}

