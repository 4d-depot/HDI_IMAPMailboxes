//%attributes = {}
#DECLARE->$vlUserChoice : Integer

var $vtItems : Text

$vlUserChoice:=0

// open pop up menu
If (Form:C1466.currentMailbox#Null:C1517)
	// if the selected mailbox is not selectable, no action allowed
	If (Bool:C1537(Form:C1466.currentMailbox.selectable))
		// Verification if the selected mailbox is already subscribed
		If (Form:C1466.mailboxes.subscribed.countValues(Form:C1466.currentMailbox.name; "name")=0)
			$vtItems:="New mailbox;Delete mailbox;Rename mailbox;Subscribe"
		Else 
			$vtItems:="New mailbox;Delete mailbox;Rename mailbox;Unsubscribe"
		End if 
		// open the menu
		$vlUserChoice:=Pop up menu:C542($vtItems)
	End if 
Else 
	// if no mailbox selected, you can just create a mailbox 
	$vtItems:="New mailbox"
	$vlUserChoice:=Pop up menu:C542($vtItems)
End if 