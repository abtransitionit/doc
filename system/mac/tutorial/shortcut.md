[//]: #(Reference)
[README]:  ./README.md

# [←][README]Linux

# Definition
- there is one app name raccourci
  1. ⌘ + Espace pour ouvrir Spotlight.
  1. Tape Raccourcis.

The code

```applescript
on run {input, parameters}

  -- ============================================================
  -- Purpose:
  --   1. Scan the "Junk" mailbox in Apple Mail and identify
  --   2. identify messages whose sender email address ends with ".id"
  --   3. Display the count in the list of matching sender addresses
  --   4. Display the list of matching sender addresses
  --
  -- Important:
  --   This script DOES NOT delete anything.
  --   It only displays the matching sender addresses.
  -- ============================================================

  tell application "Mail"
	-- ============================================================
	-- STEP 1: Ask user which suffix to use
	-- ============================================================
	set suffixList to {".id", ".us", ".biz", ".me", ".uk.com", ".com"}

	set suffixChoice to choose from list suffixList ¬
		with prompt "Choose the email suffix to filter and delete:" ¬
		default items {".us"} ¬
		OK button name "Continue" cancel button name "Cancel"

	if suffixChoice is false then
		return input
	end if

	set mailSuffixDialog to item 1 of suffixChoice

	display dialog ¬
		"You Choose :" & mailSuffixDialog ¬
		buttons {"Continue"} default button "Continue" ¬
		with title "Select Suffix"  

	-- define var: Junk mailbox
	set junkMailbox to junk mailbox
	-- define var: Junk mailbox
	set allMessages to messages of junkMailbox
	-- Get the button that was clicked (the chosen suffix that defines the mail to delmete)
	-- set mailSuffix to button returned of suffixChoice	
	-- set mailSuffix to ".id"
	set mailSuffix to mailSuffixDialog
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
		-- check if the sender's email address ends with the mail suffix
		if theAddress ends with mailSuffix then
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
		display dialog "No messages found with sender ending in " & mailSuffix buttons {"OK"} default button "OK" with title "No messages found"
		return input
	end if
	
	-- Display the list of sender addresses (not the messages themselves)
	-- Convert the list of matching senders to a single string with line breaks
	set AppleScript's text item delimiters to return
	set AddrListFormated to AddrOfListMailToDelete as text
	set AppleScript's text item delimiters to ""
	
	-- Display the list of sender addresses that will be deleted
	-- Show: "38/124 messages found" where 38 = matches, 124 = total in Junk
	display dialog ¬
		"Found " & NbListMailToDelete & "/" & totalMessagesInJunk & " messages from:" & return & return & AddrListFormated ¬
		buttons {"Continue"} default button "Continue" ¬
		with title "Messages matching the suffix " & mailSuffix

	-- Confirm deletion
	set dialogChoice to display dialog ¬
		"Delete " & NbListMailToDelete & "/" & totalMessagesInJunk & " message(s)?" ¬
		buttons {"Cancel", "Delete"} default button "Cancel" ¬
		with title "Confirm deletion"				

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
			(NbListMailToDelete as text) & " message(s) deleted" & return & return & ¬
			(NbMailLeft as text) & " message(s) left in Junk" ¬
			buttons {"Ok"} default button "Ok" ¬
			with title "Deletion done"				
	else if button returned of dialogChoice is "Cancel" then
		-- Get current count (unchanged since no deletion)
		set NbMailLeft to count of messages of junkMailbox
		
		display dialog ¬
			"Nothing was deleted" & return & return & ¬
			NbMailLeft & " message(s) still in Junk" ¬
			buttons {"Ok"} default button "Ok" ¬
			with title "Cancelled"
	end if

  end tell
  return input
end run
```  