/*
  # Create jobs table and configure security

  1. New Tables
    - `jobs` table with all required columns for the aeration booking system
  
  2. Security
    - Enable RLS
    - Add policies for authenticated users
    
  3. Performance
    - Add indexes for commonly queried columns
    - Add trigger for updated_at timestamp
*/

-- Create the jobs table
CREATE TABLE IF NOT EXISTS jobs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  customer_name text NOT NULL,
  address text NOT NULL,
  phone text,
  email text,
  service text NOT NULL,
  price numeric NOT NULL DEFAULT 59.99,
  status text NOT NULL DEFAULT 'pending',
  notes text,
  payment_method text,
  is_paid boolean DEFAULT false,
  completed_at timestamptz,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  contractor_id text,
  commission numeric,
  prepaid boolean DEFAULT false,
  front_only boolean DEFAULT false,
  back_only boolean DEFAULT false,
  payout_processed boolean DEFAULT false,
  payout_date timestamptz,
  invoice_number text,
  route_code text,
  booked_by text,
  date_booked timestamptz,
  time text,
  first_name text,
  last_name text,
  house_number text,
  street_name text,
  call_first text,
  home_phone text,
  cellphone text,
  city text,
  fo text,
  pp text,
  aer_amt numeric,
  billed_invoice_number text,
  date_completed timestamptz
);

-- Enable Row Level Security
ALTER TABLE jobs ENABLE ROW LEVEL SECURITY;

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS jobs_route_code_idx ON jobs (route_code);
CREATE INDEX IF NOT EXISTS jobs_address_idx ON jobs (address);
CREATE INDEX IF NOT EXISTS jobs_date_booked_idx ON jobs (date_booked);
CREATE INDEX IF NOT EXISTS jobs_contractor_id_idx ON jobs (contractor_id);
CREATE INDEX IF NOT EXISTS jobs_status_idx ON jobs (status);

-- Create RLS policies
CREATE POLICY "Users can read their own jobs"
  ON jobs
  FOR SELECT
  TO authenticated
  USING (auth.uid()::text = contractor_id);

CREATE POLICY "Users can insert their own jobs"
  ON jobs
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid()::text = contractor_id);

CREATE POLICY "Users can update their own jobs"
  ON jobs
  FOR UPDATE
  TO authenticated
  USING (auth.uid()::text = contractor_id)
  WITH CHECK (auth.uid()::text = contractor_id);

-- Create updated_at trigger
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_jobs_updated_at
    BEFORE UPDATE ON jobs
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();