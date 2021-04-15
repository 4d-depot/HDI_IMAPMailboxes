//%attributes = {}
// Start receiving of the mail list according to the number of mail defined by Form.numberMails
var $itemID; ListRef : Integer
ARRAY LONGINT:C221($arr; 0)
If (Is a list:C621(ListRef))
	$itemID:=Selected list items:C379(ListRef; $arr; *)
	If ($itemID>-1)
		// search the box information of the selected box
		Form:C1466.currentMailbox:=Form:C1466.mailboxes.search($itemID)
		
		If (Form:C1466.currentMailbox#Null:C1517)
			// select the box as current box on the IMAP server
			Form:C1466.transporter.selectBox(Form:C1466.currentMailbox.name)
			
		Else 
			// select the inbox as current box on the IMAP server by default
			Form:C1466.transporter.selectBox("inbox")
			
		End if 
		
		// start the download of the emails
		Form:C1466.receiveMails:=cs:C1710.EmailDownloading.new(Form:C1466.transporter; Form:C1466.numberMails)
		Form:C1466.receiveMails.startTimer()
	Else 
		Form:C1466.receiveMails:=cs:C1710.EmailDownloading.new(Form:C1466.transporter; Form:C1466.numberMails)
	End if 
End if 
