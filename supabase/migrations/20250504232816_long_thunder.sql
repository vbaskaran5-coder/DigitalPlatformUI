/*
  # Fix RLS policies for completed jobs

  1. Changes
    - Drop existing INSERT policy
    - Create new INSERT policy with proper conditions
    - Update SELECT and UPDATE policies to match

  2. Security
    - Enable RLS (already enabled)
    - Add policies for authenticated users to manage their own jobs
    - Ensure contractor_id matches the authenticated user's ID
*/

-- Drop existing policies
DROP POLICY IF EXISTS "Users can insert completed jobs" ON completed_jobs;
DROP POLICY IF EXISTS "Users can read completed jobs" ON completed_jobs;
DROP POLICY IF EXISTS "Users can update completed jobs" ON completed_jobs;

-- Create new policies with proper conditions
CREATE POLICY "Users can insert completed jobs"
ON completed_jobs
FOR INSERT
TO authenticated
WITH CHECK (
  -- Allow insert if contractor_id matches the authenticated user's ID
  contractor_id = auth.uid()::text
);

CREATE POLICY "Users can read completed jobs"
ON completed_jobs
FOR SELECT
TO authenticated
USING (
  -- Allow read if contractor_id matches the authenticated user's ID
  contractor_id = auth.uid()::text
);

CREATE POLICY "Users can update completed jobs"
ON completed_jobs
FOR UPDATE
TO authenticated
USING (
  -- Allow update if contractor_id matches the authenticated user's ID
  contractor_id = auth.uid()::text
)
WITH CHECK (
  -- Ensure updates maintain the same contractor_id
  contractor_id = auth.uid()::text
);