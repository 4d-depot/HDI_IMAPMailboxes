//%attributes = {}
If (Form:C1466.mails.length>0)
	var $destinationMailbox; $status : Object
	var $ids : Collection
	
	// search the box information of the destination box
	$destinationMailbox:=FindDestinationMailBox
	
	// ids of the email to copy
	$ids:=Form:C1466.mails.extract("id")
	
	If ($destinationMailbox#Null:C1517)
		// copy emails from selected mailbox to destination mailbox
		$status:=Form:C1466.transporter.copy($ids; $destinationMailbox.name)
	End if 
	
	If (Not:C34($status.success))
		ALERT:C41($status.statusText)
	End if 
End if 
