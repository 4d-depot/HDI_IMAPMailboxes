Case of 
	: (FORM Event:C1606.code=On Selection Change:K2:29)
		// start emails receptions according to the new mailbox selected
		StartReceiving
		
	: (FORM Event:C1606.code=On Drop:K2:12)
		// Copy an email in the the destination mailbox
		OnDropAction
		
	: (FORM Event:C1606.code=On Clicked:K2:4)
		If (Right click:C712)
			var $status : Object
			var $name : Text
			var $vlUserChoice : Integer
			var $split : Collection
			
			// Menu displaying
			$vlUserChoice:=MenuManagement
			
			If (($vlUserChoice>0) & (Form:C1466.trace))
				TRACE:C157
			End if 
			
			Case of 
					// Create a new mail box as child of the selected mailbox
				: ($vlUserChoice=1)
					
					$name:=Request:C163("New mailbox name :"; ""; "Add"; "Cancel")
					
					If ((Bool:C1537(OK)) & ($name#""))
						// Creation of the path with the name enter by the user
						If (Form:C1466.currentMailbox#Null:C1517)
							$name:=Form:C1466.currentMailbox.name+Form:C1466.mailboxes.delimiter+$name
						End if 
						// Add a new mailbox 
						$status:=Form:C1466.transporter.createBox($name)
					End if 
					
					// ******************** Remove a mailbox *******************
				: ($vlUserChoice=2)
					CONFIRM:C162("Would you delete the mailbox : "+Form:C1466.currentMailbox.name)
					If (Bool:C1537(OK))
						// Subscribtion is not deleted automaticaly by the IMAP server when the mailbox is deleted.
						// Unsubscribe before deleting the box if necessary
						If (Form:C1466.mailboxes.subscribed.countValues(Form:C1466.currentMailbox.name; "name")=1)
							$status:=Form:C1466.transporter.unsubscribe(Form:C1466.currentMailbox.name)
						End if 
						// Deletion of the selected mailbox
						$status:=Form:C1466.transporter.deleteBox(Form:C1466.currentMailbox.name)
					End if 
					
					// ******************* Rename a mailbox *******************
				: ($vlUserChoice=3)
					$split:=Split string:C1554(Form:C1466.currentMailbox.name; Form:C1466.mailboxes.delimiter)
					$name:=Request:C163("Rename the '"+$split[$split.length-1]+"' by :"; ""; "Rename"; "Cancel")
					If ((Bool:C1537(OK)) & ($name#""))
						$split[$split.length-1]:=$name
						$name:=$split.join(Form:C1466.mailboxes.delimiter)
						// Subscribtion is not renamed automaticaly by the IMAP server when the mailbox is renamed.
						// Unsubscribe before renaming the box if necessary
						If (Form:C1466.mailboxes.subscribed.countValues(Form:C1466.currentMailbox.name; "name")=1)
							$status:=Form:C1466.transporter.unsubscribe(Form:C1466.currentMailbox.name)
						End if 
						// Rename the mailbox at the same level than the current mailbox
						$status:=Form:C1466.transporter.renameBox(Form:C1466.currentMailbox.name; $name)
					End if 
					
					// ******************* Subscribe / Unsubscribe *******************
				: ($vlUserChoice=4)
					// If the box is unsubscribed, subscribed it
					If (Form:C1466.mailboxes.subscribed.countValues(Form:C1466.currentMailbox.name; "name")=0)
						$status:=Form:C1466.transporter.subscribe(Form:C1466.currentMailbox.name)
					Else   // If the box is subscribed, unsubscribed it
						$status:=Form:C1466.transporter.unsubscribe(Form:C1466.currentMailbox.name)
					End if 
			End case 
			
			If ($status#Null:C1517)
				// If no error, reloads the email list
				If (Bool:C1537($status.success))
					ListRef:=Form:C1466.mailboxes.initList()
					StartReceiving
				Else 
					ALERT:C41("Error : "+$status.statusText)
				End if 
			End if 
			
		End if 
End case 