CREATE TABLE IF NOT EXISTS Person (
	person_id INTEGER PRIMARY KEY,
	full_name TEXT,
	pub_key TEXT,
	email TEXT,
	UNIQUE(pub_key),
	UNIQUE(email));

CREATE TABLE IF NOT EXISTS Wallet (
	wallet_id INTEGER,
	person_id INTEGER REFERENCES Person(person_id),
	currency TEXT,
	receiving_address TEXT,
	sending_address TEXT,
	descr TEXT,
	UNIQUE(person_id, currency, descr));

CREATE TABLE IF NOT EXISTS SC_Status (
	sc_status TEXT,
	UNIQUE(sc_status));

CREATE TABLE IF NOT EXISTS SC (
	sc_id INTEGER PRIMARY KEY,
	pub_key TEXT,
	priv_key TEXT,
	status TEXT);

CREATE TABLE IF NOT EXISTS SC_Party (
	sc_id INTEGER REFERENCES SC(sc_id),
	person_id INTEGER REFERENCES Person(person_id),
	role TEXT,
	UNIQUE(person_id, role));

CREATE TABLE IF NOT EXISTS SC_Value (
	sc_id INTEGER REFERENCES SC(sc_id),
	key TEXT,
	value TEXT,
	UNIQUE(sc_id, key));

CREATE TABLE IF NOT EXISTS SC_Code (
	sc_id INTEGER REFERENCES SC(sc_id),
	code TEXT);
--TODO: Make events separate; into packages/statutes???

CREATE TABLE IF NOT EXISTS SC_Event (
	sc_event_id INTEGER PRIMARY KEY,
	sc_id INTEGER REFERENCES SC(sc_id),
	event_time INTEGER,
	callback TEXT,
	descr TEXT);
