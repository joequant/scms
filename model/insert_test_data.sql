INSERT INTO Person(full_name, pub_key) VALUES ('Sam Bourque', 'pub_key_sam');
INSERT INTO Wallet(person_id, currency, receiving_address, sending_address, descr) VALUES (1, 'XBT', 'rx_addy1', 'tx_addy1', 'Sam Bourque''s wallet');
INSERT INTO Wallet(person_id, currency, receiving_address, sending_address, descr) VALUES (1, 'XBT', 'rx_addy2', 'tx_addy2', 'Sam Bourque''s wallet also');
INSERT INTO Wallet(person_id, currency, receiving_address, sending_address, descr) VALUES (1, 'XLT', 'rx_addy4', 'tx_addy3', 'Sam Bourque''s wallet also');
INSERT INTO Person(full_name, pub_key) VALUES ('Hugo Hoho', 'pub_key_hugo');
INSERT INTO Wallet(person_id, currency, receiving_address, sending_address, descr) VALUES (2, 'XBT', 'rx_addy1', 'tx_addy1', 'Hugo Hoho''s wallet');

INSERT INTO SC(pub_key, priv_key, status) VALUES ('pub_key_sc', 'priv_key_sc', 'draft');

INSERT INTO SC(pub_key, priv_key, status) VALUES ('pub_key_sc', 'priv_key_sc', 'draft');
INSERT INTO SC_Party(sc_id, person_id, role) VALUES (2, 1, 'PlayerA');
INSERT INTO SC_Party(sc_id, person_id, role) VALUES (2, 2, 'PlayerB');

INSERT INTO SC(pub_key, priv_key, status) VALUES ('pub_key_sc', 'priv_key_sc', 'draft');
INSERT INTO SC_Party(sc_id, person_id, role) VALUES (3, 1, 'Creditor');
INSERT INTO SC_Party(sc_id, person_id, role) VALUES (3, 2, 'Debtor');

INSERT INTO SC_Code(sc_id, code) VALUES (1, '
$fct.print "Hello Smart Contract World!"
def sc_event_hello_world
	$fct.print "Hello Smart Contract Event World!"
end
def sc_event_hello_email_world
	$fct.send_email("sam.bourque@gmail.com", "Hello Smart Contract World!", "This is a test email")
end
def sc_event_hello_args_world(arg1, arg2)
	$fct.print "#{arg1}--#{arg2}"
end
');

INSERT INTO SC_Code(sc_id, code) VALUES (2, '
$bet_amount = 1 #XBT
$bet = {"PlayerA" => "Chelsea", "PlayerB" => "Arsenal"}

def sc_event_check_balance
	if $sc_fct.key_exists("PAID")
		$fct.print "Warning: already paid--no need to check again"
	end
	balance = $fct.get_wallet_balance(nil)
	$fct.print balance
	if balance >= $bet_amount * 2
		$sc_fct.set_value("PAID") if ! $sc_fct.key_exists("PAID")
		$fct.print "Bet is now paid--contract is in effect"
		$sc_fct.set_status("active")
		if balance > $bet_amount * 2
			$fct.print "Warning: someone overpaid"
		end
		$fct.print "#{$bet}"
	else
		$fct.print "Bet is not paid yet"
	end
	balance
end

def sc_event_resolve_bet
	if $sc_fct.key_exists("PAID")
		scores = $fct.web_get("www.sportsscores.com/scores/dump_example")
		$fct.print scores
		winner = nil
		is_tied = nil
		if scores[$bet["PlayerA"]] == scores[$bet["PlayerB"]]
			$fct.print "Tied--nobody wins the bet"
			$fct.print "Reimbursing both players"
			a_wallet = $sc_fct.sc.parties["PlayerA"].wallets["XBT"][0]
			$fct.automate_payment($bet_amount, "XBT", nil, a_wallet)
			b_wallet = $sc_fct.sc.parties["PlayerB"].wallets["XBT"][0]
			$fct.automate_payment($bet_amount, "XBT", nil, b_wallet)
			is_tied = true
		else
			if scores[$bet["PlayerA"]] > scores[$bet["PlayerB"]]
				winner = "PlayerA"
			end
			if scores[$bet["PlayerA"]] < scores[$bet["PlayerB"]]
				winner = "PlayerB"
			end
			if ! winner.nil?
				$fct.print "#{winner} wins the bet"
				$fct.print "Paying out #{winner}"
				#p $sc_fct.sc.parties
				winning_wallet = $sc_fct.sc.parties[winner].wallets["XBT"][0]
				$fct.automate_payment($bet_amount * 2, "XBT", nil, winning_wallet)
			end
		end
		if ! winner.nil? || is_tied
			$fct.print "Bet is done--contract is terminated"
			$sc_fct.set_status("terminated")
		else
			$fct.print "No final scores listed yet"
		end
	else
		$fct.print "Contract is not in effect as payments have not yet been verified"
	end
end
');

INSERT INTO SC_Code(sc_id, code) VALUES (3, '
$initial_principal_HKD = 80000
$number_of_expected_principal_payments = 12
$interest_rate = 0.10
$interest_only_period_month = 5 # May
$interest_only_period_year = 2015
$interest_only_period_date = Date.new(interest_only_period_year, interest_only_period_month)

### This contract is governed by the Laws of Hong Kong Special Administrative Region.
### Payments due at midnight on Hong Kong timezone on the last calendar day of every month.
### Interest payments only until INTEREST_ONLY_PERIOD, inclusive.
### Principal payments plus interest to be paid off in one calendar year from INTEREST_ONLY_PERIOD.
### Interest rate is defined on a per annum basis, calculated daily.
### Public holidays and weekends are disregarded.
### All payments are to be settled in Bitcoin ("XBT").
### All HKD amounts are rounded to the nearest 10 cents increment.
### All XBT amounts are rounded up to the nearest Satoshi (i.e. the eighth decimal place of a XBT).

def initialize_contract
	if $sc_fct.key_exists("INITIALIZED")
		$fct.print "Warning: contract is already initialized--no need to do it again"
	else
		$sc_fct.set_value("PRINCIPAL_AMOUNT", $initial_principal_HKD)
		$sc_fct.set_value("INITIALIZED")
	end
end

def notify_loan_deposit(signature, plain_text)
	if $sc_fct.confirm_signature(signature, plain_text, $sc_fct.sc.parties["Creditor"])
		if $sc_fct.key_exists("LOAN_DEPOSITED_DATE")
			$fct.print "Warning: loan deposit is already noted--no need to do it again"
		else
			now = DateTime.now
			$sc_fct.set_value("LOAN_DEPOSITED_DATE", now)
			$fct.print("Loan deposit is noted at: #{now}")
			$fct.print("Pending confirmation from debtor")
			notify_next_payment(get_days_until_month_end(today))
		end
	else
		$fct.print "Invalid signature or unauthorized function call"
	end
end

def confirm_loan_deposit(signature, plain_text)
	if $sc_fct.confirm_signature(signature, plain_text, $sc_fct.sc.parties["Debtor"])
		if $sc_fct.key_exists("LOAN_DEPOSITED_DATE")
			today = DateTime.today
			$sc_fct.set_value("LOAN_CONFIRMED_DATE", today)
			$sc_fct.set_value("INTEREST_ACCRUAL_START_DATE", today)
			$fct.print("Loan deposit is confirmed at: #{today}")
			$sc_fct.set_status("active")
			notify_next_payment
		else
			$fct.print "Warning: loan deposit is already noted--no need to do it again"
		end
	else
		$fct.print "Invalid signature or unauthorized function call"
	end
end

def get_days_until_month_end(date_object = DateTime.today)
	next_month = get_next_payment_date(date_object)
	(next_month - date_object).to_i
end

def get_next_payment_date(date_object = DateTime.today)
	Date.new(date_object.year, date_object.month, 1) >> 1
end

def notify_next_payment(days = DateTime.today)
	days = get_days_until_month_end()
	days = 30 if days > 30 #Cap at 30... in case it would happen to be 31
	accrued = get_accrued_interest_in_month(days)
	next_payment_date = get_next_payment_date(date_object)
	$fct.print "The next payment is due at: #{next_payment_date}"
	next_payment_amount = get_accrued_interest_in_month(days)
	if next_payment_date >= $interest_only_period_date
		$fct.print "The interest portion of the payment is: #{next_payment_amount}"
		principal_portion = ($initial_principal_HKD / $number_of_expected_principal_payments).round(1)
		next_payment_amount = (next_payment_amount + principal_portion).round(1)
		$fct.print "The principal portion of the payment is: #{principal_portion}"
	end
	$fct.print "The next payment amount is: #{next_payment_amount} HKD"
	next_payment_amount
end

def get_accrued_interest_in_month(days = 30)
	days = 30 if days > 30 #Cap at 30... in case it would happen to be 31
	principal = $sc_fct.get_value("PRINCIPAL_AMOUNT")
	interest_accrued_daily = principal * $interest_rate / 365
	interest_payment = interest_accrued_daily * days
	interest_payment.round(1)
end

def get_payment_record

end

def record_payment
end
');

--INSERT INTO SC_Value(sc_id, sc_key, sc_value) VALUES (1, '', '');
