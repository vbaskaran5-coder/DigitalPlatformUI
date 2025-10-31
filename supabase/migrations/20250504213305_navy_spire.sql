/*
  # Fix Master Bookings RLS policies

  1. Changes
    - Add INSERT policy for Master Bookings table to allow authenticated users to insert new rows
    - Keep existing policies intact
    - Ensure policy matches the completed_jobs table policy structure

  2. Security
    - Maintains RLS enabled
    - Adds explicit INSERT policy for authenticated users
    - Preserves existing SELECT and UPDATE policies
*/

-- Drop the existing INSERT policy if it exists
DROP POLICY IF EXISTS "Users can insert Master Bookings" ON "Master Bookings";

-- Create new INSERT policy with proper permissions
CREATE POLICY "Users can insert Master Bookings"
ON "Master Bookings"
FOR INSERT
TO authenticated
WITH CHECK (true);

-- Verify RLS is still enabled
ALTER TABLE "Master Bookings" ENABLE ROW LEVEL SECURITY;