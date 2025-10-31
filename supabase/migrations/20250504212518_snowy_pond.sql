/*
  # Create completed jobs table

  1. New Tables
    - `completed_jobs` table to track all completed jobs
    
  2. Security
    - Enable RLS
    - Add policies for authenticated users
*/

CREATE TABLE completed_jobs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  booking_id text REFERENCES "Master Bookings"("Booking ID"),
  customer_name text NOT NULL,
  address text NOT NULL,
  payment_method text NOT NULL,
  price numeric NOT NULL,
  completed_at timestamptz NOT NULL DEFAULT now(),
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  contractor_id text,
  is_paid boolean DEFAULT false,
  prepaid boolean DEFAULT false,
  front_only boolean DEFAULT false,
  back_only boolean DEFAULT false,
  notes text
);

-- Enable Row Level Security
ALTER TABLE completed_jobs ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Users can read completed jobs"
  ON completed_jobs
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Users can insert completed jobs"
  ON completed_jobs
  FOR INSERT
  TO authenticated
  WITH CHECK (true);

-- Create indexes
CREATE INDEX completed_jobs_booking_id_idx ON completed_jobs (booking_id);
CREATE INDEX completed_jobs_completed_at_idx ON completed_jobs (completed_at);
CREATE INDEX completed_jobs_contractor_id_idx ON completed_jobs (contractor_id);

-- Create updated_at trigger
CREATE TRIGGER update_completed_jobs_updated_at
    BEFORE UPDATE ON completed_jobs
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();