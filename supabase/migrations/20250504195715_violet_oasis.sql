/*
  # Create jobs table and setup security policies

  1. New Tables
    - `jobs` table with the following columns:
      - `id` (uuid, primary key)
      - `customer_name` (text, not null)
      - `address` (text, not null)
      - `phone` (text)
      - `email` (text)
      - `service` (text, not null)
      - `price` (numeric, default 59.99)
      - `status` (text, default 'pending')
      - `notes` (text)
      - `payment_method` (text)
      - `is_paid` (boolean, default false)
      - `completed_at` (timestamptz)
      - `created_at` (timestamptz, default now())
      - `updated_at` (timestamptz, default now())
      - `contractor_id` (text)
      - `commission` (numeric)
      - `prepaid` (boolean, default false)
      - `front_only` (boolean, default false)
      - `back_only` (boolean, default false)
      - `payout_processed` (boolean, default false)
      - `payout_date` (timestamptz)
      - `invoice_number` (text)
      - `route_code` (text)
      - `booked_by` (text)
      - `date_booked` (timestamptz)
      - `time` (text)
      - `first_name` (text)
      - `last_name` (text)
      - `house_number` (text)
      - `street_name` (text)
      - `call_first` (text)
      - `home_phone` (text)
      - `cellphone` (text)
      - `city` (text)
      - `fo` (text)
      - `pp` (text)
      - `aer_amt` (numeric)
      - `billed_invoice_number` (text)
      - `date_completed` (timestamptz)

  2. Indexes
    - Primary key on id
    - Index on address
    - Index on contractor_id
    - Index on date_booked
    - Index on route_code
    - Index on status

  3. Security
    - Enable RLS
    - Add policies for authenticated users to:
      - Insert their own jobs
      - Read their own jobs
      - Update their own jobs

  4. Triggers
    - Add trigger to update updated_at column
*/

-- Create the jobs table
CREATE TABLE IF NOT EXISTS public.jobs (
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

-- Create indexes
CREATE INDEX IF NOT EXISTS jobs_address_idx ON public.jobs USING btree (address);
CREATE INDEX IF NOT EXISTS jobs_contractor_id_idx ON public.jobs USING btree (contractor_id);
CREATE INDEX IF NOT EXISTS jobs_date_booked_idx ON public.jobs USING btree (date_booked);
CREATE INDEX IF NOT EXISTS jobs_route_code_idx ON public.jobs USING btree (route_code);
CREATE INDEX IF NOT EXISTS jobs_status_idx ON public.jobs USING btree (status);

-- Enable Row Level Security
ALTER TABLE public.jobs ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Users can insert their own jobs"
    ON public.jobs
    FOR INSERT
    TO authenticated
    WITH CHECK ((auth.uid())::text = contractor_id);

CREATE POLICY "Users can read their own jobs"
    ON public.jobs
    FOR SELECT
    TO authenticated
    USING ((auth.uid())::text = contractor_id);

CREATE POLICY "Users can update their own jobs"
    ON public.jobs
    FOR UPDATE
    TO authenticated
    USING ((auth.uid())::text = contractor_id)
    WITH CHECK ((auth.uid())::text = contractor_id);

-- Create updated_at trigger function if it doesn't exist
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger
CREATE TRIGGER update_jobs_updated_at
    BEFORE UPDATE ON public.jobs
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();