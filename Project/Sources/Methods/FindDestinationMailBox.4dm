//%attributes = {}
// Determines the destination mailbox where the email must be copy / move
var $itemID; $itemPos : Integer
var $0 : Object
var $itemName : Text

// Position of the mailbox in the list box
$itemPos:=Drop position:C608

GET LIST ITEM:C378(ListRef; $itemPos; $itemID; $itemName)

// search the box information of the destination box
$0:=Form:C1466.mailboxes.search($itemID)