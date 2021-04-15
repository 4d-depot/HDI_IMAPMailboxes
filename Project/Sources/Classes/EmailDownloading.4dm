Class constructor($transporter : Object; $numberMails : Integer)
	
	This:C1470._transporter:=$transporter
	This:C1470._numberMails:=$numberMails
	This:C1470.mails:=Null:C1517
	
Function startTimer
	// Show the download message
	OBJECT SET VISIBLE:C603(*; "Download"; True:C214)
	
	// Set the timer to 1 to show the download message and start the receiving just after
	SET TIMER:C645(1)
	
	// Start receiving of the mail list according to the number of mail defined by Form.numberMails
Function startDownload()
	// Stop the timer
	SET TIMER:C645(0)
	
	// Fills the mails collection with the list of the last "numberMails" emails received
	// Fills the list of attachements and the body if necessary of the first email of the list
	// Creation of the mail lists. They contain just the mail headers
	This:C1470._receiveMails()
	
	
	// Receives the number of last mails asked by the user
Function _receiveMails()
	
	var $min : Integer
	var $mails : Collection
	
	// Search the list of emails and the information for each emails
	This:C1470.mails:=New collection:C1472
	If (Num:C11(This:C1470._transporter.getBoxInfo().mailCount)>0)
		
		// calculation of the position of the first email to download
		$min:=This:C1470._transporter.getBoxInfo().mailCount-This:C1470._numberMails
		
		
		// Download of the last emails
		$mails:=This:C1470._transporter.getMails($min; This:C1470._transporter.getBoxInfo().mailCount; New object:C1471("withBody"; False:C215; "updateSeen"; False:C215)).list
		
		This:C1470.mails:=$mails.reverse()
		
	End if 
	
	
	
	
	