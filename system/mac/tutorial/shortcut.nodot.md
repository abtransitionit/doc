
```applescript
on run {input, parameters}
	
	-- ============================================================
	-- Purpose:
	--   1. Scan the "Junk" mailbox in Apple Mail
	--   2. Identify messages whose sender email address ends with several suffix
	--   3. Display the count in the list of matching sender addresses
	--   4. Display the list of matching sender addresses
	--
	-- Important:
	--   This script DOES delete matching messages automatically
	--   after you click Continue.
	-- ============================================================
	
	tell application "Mail"
		-- ============================================================
		-- STEP 1: Ask user which suffix to use
		-- ============================================================
		set dialogChoice to ""		
		set senderAdrCriteria to "."
		
		
		-- define var: Junk mailbox
		set junkMailbox to junk mailbox
		-- define var: Junk mailbox
		set allMessages to messages of junkMailbox
		-- define var: List of mail to delete (stores REFERENCES to messages)
		set ListMailToDelete to {}
		-- define var: List of addresses of mail to delete
		set AddrOfListMailToDelete to {}
		
		-- Get total count of all messages in Junk mailbox
		set totalMessagesInJunk to count of messages of junkMailbox
		
		-- Initialize counter for progress display
		set currentIndex to 0
		
		-- loop through all messages in the Junk mailbox to build the list of mail to delete
		repeat with theMessage in allMessages
			-- Increment counter
			set currentIndex to currentIndex + 1
			
			-- Get the email address
			set theAddress to extract address from (sender of theMessage)
			-- Store the MESSAGE REFERENCE itself (not the contents)
			set theMail to theMessage
			-- check the sender's email match the criteria
			if theAddress does not contain senderAdrCriteria then
				-- add the MESSAGE REFERENCE to the list
				set end of ListMailToDelete to theMail
				-- add the sender's email address to the list of matching messages
				set end of AddrOfListMailToDelete to theAddress
			end if
		end repeat
		
		-- define var: count the number of mail to delete
		set NbListMailToDelete to count of ListMailToDelete
		
		-- If no messages found, inform and exit
		if NbListMailToDelete is 0 then
			display dialog "No messages found with sender adress criteria " & senderAdrCriteria buttons {"OK"} default button "OK" with title "No messages found"
			return input
		end if
		
		-- Display the list of sender addresses (not the messages themselves)
		-- Convert the list of matching senders to a single string with line breaks
		set AppleScript's text item delimiters to return
		set AddrListFormated to AddrOfListMailToDelete as text
		set AppleScript's text item delimiters to ""
		
		-- Display the list of sender addresses that will be deleted
		-- Show: "38/124 messages found" where 38 = matches, 124 = total in Junk
		set dialogChoice to display dialog ¬
			"Found " & NbListMailToDelete & "/" & totalMessagesInJunk & " messages from:" & return & return & AddrListFormated ¬
			buttons {"Cancel", "Continue"} ¬
			cancel button "Cancel" ¬
			default button "Cancel" ¬
			with title "Messages matching the criteria " & senderAdrCriteria

		-- Stop the script if Cancel is clicked
		if button returned of dialogChoice is "Cancel" then
			return input
		end if

		-- If Continue is clicked, continue the script and ask for deletion confirmation

		-- -- Confirm deletion
		-- set dialogChoice to display dialog ¬
		-- 	"Delete " & NbListMailToDelete & "/" & totalMessagesInJunk & " message(s)?" ¬
		-- 	buttons {"Cancel", "Delete"} ¬
		-- 	default button "Cancel" ¬
		-- 	with title "Confirm deletion"

		-- force Deletion - no confirmation
		set dialogChoice to {button returned:"Delete"}


		-- Delete only if "Delete" is clicked
		if button returned of dialogChoice is "Delete" then
			-- delete (now references the actual messages)
			repeat with theMessage in ListMailToDelete
				delete theMessage
			end repeat
			
			-- Get the NEW count of messages left in Junk after deletion
			set NbMailLeft to count of messages of junkMailbox
			
			-- display info with remaining count
			display dialog ¬
				(NbListMailToDelete as rich text) & " message(s) deleted" & return & return & ¬
				(NbMailLeft as rich text) & ¬
				" message(s) left in Junk" buttons {"Ok"} default button ¬
				"Ok" with title "Deletion done"
		else if button returned of dialogChoice is "Cancel" then
			-- Get current count (unchanged since no deletion)
			set NbMailLeft to count of messages of junkMailbox
			
			display dialog ¬
				"Nothing was deleted" & return & return & ¬
				NbMailLeft & ¬
				" message(s) still in Junk" buttons {"Ok"} default button ¬
				"Ok" with title "Cancelled"
		end if
		
	end tell
	return input
end run

```  
