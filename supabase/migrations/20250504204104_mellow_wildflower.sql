/*
  # Create Master Bookings table from CSV structure

  1. New Tables
    - `Master Bookings` table with all columns from the CSV file
    - All columns are text type to match CSV format
    - Added created_at and updated_at timestamps
    
  2. Security
    - Enable RLS
    - Add policies for authenticated users
    
  3. Indexes
    - Add indexes for commonly queried columns
*/

-- Drop existing table if it exists
DROP TABLE IF EXISTS "Master Bookings";

-- Create the Master Bookings table
CREATE TABLE "Master Bookings" (
  "Booking ID" text PRIMARY KEY DEFAULT gen_random_uuid()::text,
  "Booked By" text,
  "Date/Time Booked" text,
  "Master Map" text,
  "Route Number" text,
  "First Name" text,
  "Last Name" text,
  "Full Address" text,
  "Home Phone" text,
  "Cell Phone" text,
  "Email Address" text,
  "Price" text,
  "Prepaid" text,
  "FO/BO/FP" text,
  "Log Sheet Notes" text,
  "Completed" text,
  "Cancelled" text,
  "Date Completed" text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create indexes for commonly queried columns
CREATE INDEX IF NOT EXISTS master_bookings_route_number_idx ON "Master Bookings" ("Route Number");
CREATE INDEX IF NOT EXISTS master_bookings_date_time_booked_idx ON "Master Bookings" ("Date/Time Booked");
CREATE INDEX IF NOT EXISTS master_bookings_completed_idx ON "Master Bookings" ("Completed");
CREATE INDEX IF NOT EXISTS master_bookings_cancelled_idx ON "Master Bookings" ("Cancelled");

-- Enable Row Level Security
ALTER TABLE "Master Bookings" ENABLE ROW LEVEL SECURITY;

-- Create RLS policies
CREATE POLICY "Users can read Master Bookings"
  ON "Master Bookings"
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Users can insert Master Bookings"
  ON "Master Bookings"
  FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Users can update Master Bookings"
  ON "Master Bookings"
  FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Create updated_at trigger
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_master_bookings_updated_at
    BEFORE UPDATE ON "Master Bookings"
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Insert sample data
INSERT INTO "Master Bookings" (
  "Master Map",
  "Route Number",
  "First Name",
  "Last Name",
  "Full Address",
  "Home Phone",
  "Email Address",
  "FO/BO/FP",
  "Log Sheet Notes",
  "Prepaid"
) VALUES
  ('Aldershot #1', 'ALD01', 'Lorraine', 'Favalano', '597 Sandcherry Dr', '289 337-2803', 'lorrainecan1942@gmail.com', 'FP', 'SS', NULL),
  ('Aldershot #1', 'ALD01', 'George', 'Rortalato', '615 Sandcherry Dr', '416 729-0806', 'gborto@yahoo.com', 'FP', 'SS - MBH', NULL),
  ('Aldershot #1', 'ALD01', 'Pat', 'Mater', '601 Sandcherry Dr.', '905 630-9994', 'pat.mager032@sympatico.ca', 'FP', 'SS', NULL),
  ('Aldershot #1', 'ALD02', 'Kevin', 'Huschilt', '1019 Unsworth Ave', '905 484-3439', 'kevin.huschilt@outlook.com', 'FP', NULL, NULL),
  ('Aldershot #1', 'ALD03', 'Calvin', 'Birhan', '809 Danforth Pl', '905 730-1284', 'calvin@archmill.ca', 'FP', 'SS', 'x'),
  ('Aldershot #1', 'ALD03', 'Siegfried', 'Hoffman', '853 Danforth Pl', '905 921-5140', 'sieg.hoffmann1@gmail.com', 'FO', NULL, NULL),
  ('Aldershot #1', 'ALD03', 'Bruce', 'Law', '857 Danforth Pl', '905 317-0195', 'blaw2@ymail.com', 'FO', 'SS', NULL),
  ('Aldershot #1', 'ALD03', 'Jim', 'Mcdowell', '913 Danforth Pl', '289 337-9136', NULL, 'FP', 'gate', NULL),
  ('Aldershot #1', 'ALD03', 'Jim', 'Wilson', '970 Danforth Pl', '905 525-2231', 'jwilson002@sympatico.ca', 'FO', NULL, NULL),
  ('Aldershot #1', 'ALD03', 'Brian', 'Kingdon', '929 Gorton Ave', '905 528-8767', 'bekingdon@bell.net', 'FO', NULL, 'x');