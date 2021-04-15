Class constructor
	
Function from($mail : Object)->$from : Text
	If ($mail#Null:C1517)
		$from:=This:C1470._emailAddresses($mail.from)
	Else 
		$from:=""
	End if 
	
Function to($mail : Object)->$to : Text
	If ($mail#Null:C1517)
		$to:=This:C1470._emailAddresses($mail.to)
	Else 
		$to:=""
	End if 
	
Function cc($mail : Object)->$cc : Text
	If ($mail#Null:C1517)
		$cc:=This:C1470._emailAddresses($mail.cc)
	Else 
		$cc:=""
	End if 
	
Function _emailAddresses($addresses : Collection)->$result : Text
	// Transform a collection of email address to a string to display it in the UI
	// all the emails are converted as "name <emailAddress>" separated by ","
	// $addresses -> collection of email address object
	// result -> string containing all the addresses as string
	
	var $address : Object
	
	If ($addresses=Null:C1517)
		$result:=""
	Else 
		
		// string construction
		For each ($address; $addresses)
			
			If ($result#"")
				$result:=$result+", "
			End if 
			
			$result:=$result+String:C10($address.name)+" <"+String:C10($address.email)+">"
			
		End for each 
		
	End if 
	
Function subject($mail : Object)->$subject : Text
	If ($mail#Null:C1517)
		$subject:=String:C10(Form:C1466.mail.subject)
	Else 
		$subject:=""
	End if 
	
Function sentDate($mail : Object)->$sentDate : Text
	If ($mail#Null:C1517)
		$sentDate:=String:C10(Date:C102(Form:C1466.mail.sendAt); Date RFC 1123:K1:11; Time:C179(Form:C1466.mail.sendAt))
	Else 
		$sentDate:=""
	End if 
	
Function attachments($mail : Object)->$attachments : Collection
	If ($mail#Null:C1517)
		$attachments:=$mail.attachments
	Else 
		$attachments:=New collection:C1472
	End if 
	