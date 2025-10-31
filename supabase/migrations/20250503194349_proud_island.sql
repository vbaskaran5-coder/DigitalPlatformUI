/*
  # Import Master Bookings

  1. Changes
    - Add new columns to match Master-Bookings table structure
    - Add migration function to import data
*/

-- Add new columns to match Master-Bookings structure
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS booked_by text;
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS date_booked timestamptz;
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS time text;
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS first_name text;
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS last_name text;
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS house_number text;
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS street_name text;
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS call_first text;
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS home_phone text;
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS cellphone text;
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS city text;
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS fo text;
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS pp text;
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS aer_amt numeric;
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS billed_invoice_number text;
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS date_completed timestamptz;