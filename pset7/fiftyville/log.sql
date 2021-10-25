-- Keep a log of any SQL queries you execute as you solve the mystery.

-- Review crime reports at crime scene on day of robbery
SELECT * FROM crime_scene_reports 
WHERE street = "Chamberlin Street" 
AND day = 28 AND month = 7 AND year = 2020;

-- Find interviews conducted with 3 witnesses (should mention the courthouse)
SELECT * FROM interviews 
WHERE day = 28 AND month = 7 AND year = 2020 
AND transcript LIKE '%courthouse%';

-- Look for cars leaving through security footage within 10 minutes of theft (10:15),
SELECT * FROM courthouse_security_logs 
WHERE day = 28 AND month = 7 AND year = 2020 
AND hour = 10 AND minute < 25 AND minute >= 15;

-- Eugene recognized them by ATM on fifer street withdrawing money, 
SELECT * FROM atm_transactions 
WHERE day = 28 AND month = 7 AND year = 2020 
AND atm_location = "Fifer Street" AND transaction_type = "withdraw";

-- Raymond saw him call friend within a minute to buy plane ticket for tom
SELECT * FROM flights 
WHERE origin_airport_id IN (SELECT id FROM airports) 
AND day = 29 AND month = 7 AND year = 2020;

-- Find passengers from earliest out of Fiftyville
SELECT * FROM passengers 
WHERE flight_id = 36;

-- Find matches for thief
SELECT * FROM people 
WHERE phone_number IN 
    (SELECT caller FROM phone_calls 
        WHERE day = 28 AND month = 7 AND year = 2020) 
AND passport_number IN
    (SELECT passport_number FROM passengers 
        WHERE flight_id = 36)
AND license_plate IN 
    (SELECT license_plate FROM courthouse_security_logs)
AND id IN 
    (SELECT person_id FROM bank_accounts
        WHERE account_number IN 
        (SELECT account_number FROM atm_transactions
            WHERE day = 28 AND month = 7 AND year = 2020));

-- Find matches for accomplice
SELECT * FROM people 
WHERE phone_number IN 
    (SELECT receiver FROM phone_calls 
        WHERE day = 28 AND month = 7 AND year = 2020) 
AND passport_number IN
    (SELECT passport_number FROM passengers 
        WHERE flight_id = 36)
AND license_plate IN 
    (SELECT license_plate FROM courthouse_security_logs)
AND id IN 
    (SELECT person_id FROM bank_accounts
        WHERE account_number IN 
        (SELECT account_number FROM atm_transactions
            WHERE day = 28 AND month = 7 AND year = 2020));
            
-- Check Bank Accounts
SELECT * FROM bank_accounts WHERE account_number IN
    (SELECT account_number FROM atm_transactions
        WHERE day = 28 AND month = 7 AND year = 2020
        AND atm_location = "Fifer Street" 
        AND transaction_type = "withdraw");
        
-- Determine destination
SELECT * FROM flights
    JOIN airports ON destination_airport_id = airports.id
    WHERE destination_airport_id = 4;

-- Check phone calls        
SELECT * FROM phone_calls WHERE day = 28 AND month = 7 AND year = 2020 AND duration <= 60;

-- Check Ernest's call
SELECT * FROM people WHERE phone_number = "(375) 555-8161";

-- Check Madison's call
SELECT * FROM people WHERE phone_number = "(676) 555-6554";