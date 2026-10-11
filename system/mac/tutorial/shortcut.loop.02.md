
```applescript
on run {input, parameters}
	
	-- ============================================================
	-- Purpose:
	--   1. Scan the "Junk" mailbox in Apple Mail
	--   2. Identify messages whose sender email address ends with several suffix
	--   3. Display the count and list of matching sender addresses
	--   3. Do the job in loop
	--
	-- Important:
	--   This script DOES delete matching messages automatically
	--   after you click Continue.
	-- ============================================================
	
	tell application "Mail"
		
		-- ============================================================
		-- STEP 1: Define the suffixes to check
		-- ============================================================
		set dialogChoice to ""
		set SenderAdrCriteriaList to {"76.4949881", "no-reply"}
		
		-- Loop through each criteria
		repeat with senderAdrCriteriaItem in SenderAdrCriteriaList
			
			set senderAdrCriteria to contents of senderAdrCriteriaItem
			
			-- Define variable: Junk mailbox
			set junkMailbox to junk mailbox
			
			-- Get all messages in the Junk mailbox
			set allMessages to messages of junkMailbox
			
			-- Initialize list of matching message references
			set ListMailToDelete to {}
			
			-- Initialize list of matching sender addresses
			set AddrOfListMailToDelete to {}
			
			-- Get total count of messages in Junk
			set totalMessagesInJunk to count of messages of junkMailbox
			
			-- Initialize counter
			set currentIndex to 0
			
			-- Loop through all messages in Junk
			repeat with theMessage in allMessages
				
				-- Increment counter
				set currentIndex to currentIndex + 1
				
				-- Get the sender's email address
				set theAddress to extract address from (sender of theMessage)
				
				-- Store the message reference
				set theMail to theMessage
				
				-- Check the criteria ---> sender address contains criteriaString
				if theAddress contains senderAdrCriteria then
					
					-- Add the message reference to the list
					set end of ListMailToDelete to theMail
					
					-- Add the sender address to the list
					set end of AddrOfListMailToDelete to theAddress
					
				end if
				
			end repeat
			
			-- Count matching messages
			set NbListMailToDelete to count of ListMailToDelete
			
			-- If no messages match, display a message and continue
			-- with the next suffix
			if NbListMailToDelete is 0 then
				
				display dialog ¬
					"No messages found with sender address criteria " & senderAdrCriteria ¬
					buttons {"OK"} default button "OK" ¬
					with title "No messages found"
				
			else
				
				-- ============================================================
				-- STEP 2: Format and display matching sender addresses
				-- ============================================================
				
				-- Convert the list of addresses into a single text string
				set AppleScript's text item delimiters to return
				set AddrListFormated to AddrOfListMailToDelete as text
				set AppleScript's text item delimiters to ""
				
				-- Display matching sender addresses
				set dialogChoice to display dialog ¬
					"Found " & NbListMailToDelete & "/" & totalMessagesInJunk & " messages from:" & return & return & AddrListFormated ¬
					buttons {"Cancel", "Continue"} ¬
					cancel button "Cancel" ¬
					default button "Cancel" ¬
					with title "Messages matching the suffix " & senderAdrCriteria
				
				-- Stop the entire script if Cancel is clicked
				if button returned of dialogChoice is "Cancel" then
					return input
				end if
				
				-- ============================================================
				-- STEP 3: Handle deletion
				-- ============================================================
				
				-- Force deletion without a confirmation dialog
				set dialogChoice to {button returned:"Delete"}
				
				-- Delete matching messages
				if button returned of dialogChoice is "Delete" then
					
					repeat with theMessage in ListMailToDelete
						delete theMessage
					end repeat
					
					-- Get the new count of messages remaining in Junk
					set NbMailLeft to count of messages of junkMailbox
					
					-- Display deletion results
					display dialog ¬
						(NbListMailToDelete as rich text) & " message(s) deleted" & return & return & ¬
						(NbMailLeft as rich text) & ¬
						" message(s) left in Junk" ¬
						buttons {"OK"} default button "OK" ¬
						with title "Deletion done"
					
				else if button returned of dialogChoice is "Cancel" then
					
					-- Get current count (unchanged if nothing was deleted)
					set NbMailLeft to count of messages of junkMailbox
					
					display dialog ¬
						"Nothing was deleted" & return & return & ¬
						NbMailLeft & ¬
						" message(s) still in Junk" ¬
						buttons {"OK"} default button "OK" ¬
						with title "Cancelled"
					
				end if
				
			end if
			
		end repeat
		
	end tell
	
	return input
	
end run```  
