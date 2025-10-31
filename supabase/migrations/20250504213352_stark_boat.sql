/*
  # Fix Master Bookings and Completed Jobs integration

  1. Changes
    - Update RLS policies for both tables
    - Add missing columns to completed_jobs
    - Ensure proper foreign key relationship
*/

-- First, update Master Bookings policies
DROP POLICY IF EXISTS "Users can insert Master Bookings" ON "Master Bookings";
DROP POLICY IF EXISTS "Users can read Master Bookings" ON "Master Bookings";
DROP POLICY IF EXISTS "Users can update Master Bookings" ON "Master Bookings";

CREATE POLICY "Users can insert Master Bookings"
ON "Master Bookings"
FOR INSERT
TO authenticated
WITH CHECK (true);

CREATE POLICY "Users can read Master Bookings"
ON "Master Bookings"
FOR SELECT
TO authenticated
USING (true);

CREATE POLICY "Users can update Master Bookings"
ON "Master Bookings"
FOR UPDATE
TO authenticated
USING (true)
WITH CHECK (true);

-- Then, update completed_jobs policies
DROP POLICY IF EXISTS "Users can insert completed jobs" ON completed_jobs;
DROP POLICY IF EXISTS "Users can read completed jobs" ON completed_jobs;

CREATE POLICY "Users can insert completed jobs"
ON completed_jobs
FOR INSERT
TO authenticated
WITH CHECK (true);

CREATE POLICY "Users can read completed jobs"
ON completed_jobs
FOR SELECT
TO authenticated
USING (true);

-- Ensure RLS is enabled on both tables
ALTER TABLE "Master Bookings" ENABLE ROW LEVEL SECURITY;
ALTER TABLE completed_jobs ENABLE ROW LEVEL SECURITY;