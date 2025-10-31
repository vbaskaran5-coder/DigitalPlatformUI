/*
  # Fix completed jobs policies and constraints

  1. Changes
    - Add UPDATE policy for completed_jobs
    - Make booking_id nullable to avoid foreign key issues
    - Add missing indexes
*/

-- Make booking_id nullable and drop the foreign key constraint
ALTER TABLE completed_jobs 
  ALTER COLUMN booking_id DROP NOT NULL,
  DROP CONSTRAINT IF EXISTS completed_jobs_booking_id_fkey;

-- Add UPDATE policy for completed_jobs
CREATE POLICY "Users can update completed jobs"
  ON completed_jobs
  FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Ensure indexes exist
CREATE INDEX IF NOT EXISTS completed_jobs_customer_name_idx ON completed_jobs (customer_name);
CREATE INDEX IF NOT EXISTS completed_jobs_address_idx ON completed_jobs (address);
CREATE INDEX IF NOT EXISTS completed_jobs_payment_method_idx ON completed_jobs (payment_method);