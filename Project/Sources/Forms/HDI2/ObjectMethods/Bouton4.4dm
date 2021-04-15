C_OBJECT:C1216($status; $info)

If (String:C10(Form:C1466.IMAP.host)#"")
	// creation of the transporter IMAP object with the information entered in the form
	Form:C1466.transporter:=IMAP New transporter:C1723(Form:C1466.IMAP)
	
	// Connection check, to verify if  the information entered are OK
	$status:=Form:C1466.transporter.checkConnection()
	
	
	// Verification if connection check is success or not and display a message
	If ($status.success)
		ShowBoxInfo(True:C214)
		Form:C1466.connectResult:="IMAP information OK"
		Form:C1466.mailboxes:=cs:C1710.MailBoxes.new(Form:C1466.transporter)
		ListRef:=Form:C1466.mailboxes.initList()
		
	Else 
		ShowBoxInfo(False:C215)
		ALERT:C41("An error occurred: "+$status.statusText)
		Form:C1466.connectResult:=""
	End if 
End if 