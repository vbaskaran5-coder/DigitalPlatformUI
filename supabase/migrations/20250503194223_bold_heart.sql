/*
  # Initial schema setup for jobs management

  1. New Tables
    - `jobs`
      - `id` (uuid, primary key)
      - `customer_name` (text)
      - `address` (text)
      - `phone` (text)
      - `email` (text)
      - `service` (text)
      - `price` (numeric)
      - `status` (text)
      - `notes` (text)
      - `payment_method` (text)
      - `is_paid` (boolean)
      - `completed_at` (timestamptz)
      - `created_at` (timestamptz)
      - `updated_at` (timestamptz)
      - `contractor_id` (text)
      - `commission` (numeric)
      - `prepaid` (boolean)
      - `front_only` (boolean)
      - `back_only` (boolean)
      - `payout_processed` (boolean)
      - `payout_date` (timestamptz)
      - `invoice_number` (text)
      - `route_code` (text)

  2. Security
    - Enable RLS on `jobs` table
    - Add policies for authenticated users to manage their own jobs
*/

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
  route_code text
);

ALTER TABLE jobs ENABLE ROW LEVEL SECURITY;

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