//%attributes = {}
Form:C1466.mailDisplay:=cs:C1710.MailDisplay.new()
Form:C1466.mail:=Null:C1517

Form:C1466.trace:=False:C215

Form:C1466.IMAP:=cs:C1710.IMAPServerInfo.new()
Form:C1466.transporter:=Null:C1517

OBJECT SET FONT:C164(*; "Password"; "%password")

Form:C1466.numberMails:=10

Form:C1466.copy:=True:C214

Form:C1466.displaySubscribed:=False:C215

ShowBoxInfo(False:C215)
