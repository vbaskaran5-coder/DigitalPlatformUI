/*
  # Create Master Bookings table
  
  1. New Tables
    - `Master Bookings` table with all required columns
    
  2. Security
    - Enable RLS
    - Add policies for authenticated users
*/

CREATE TABLE IF NOT EXISTS "Master Bookings" (
  "Booking ID" text PRIMARY KEY,
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