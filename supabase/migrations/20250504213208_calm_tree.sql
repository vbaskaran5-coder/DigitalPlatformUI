/*
  # Fix Master Bookings RLS policies

  1. Changes
    - Update RLS policies for Master Bookings table to properly handle INSERT operations
    - Ensure authenticated users can insert new records
    - Maintain existing SELECT and UPDATE policies

  2. Security
    - Maintain RLS enabled on Master Bookings table
    - Update INSERT policy to allow authenticated users to add new records
    - Keep existing policies for SELECT and UPDATE operations
*/

-- Drop the existing INSERT policy if it exists
DO $$ 
BEGIN
  IF EXISTS (
    SELECT 1 FROM pg_policies 
    WHERE schemaname = 'public' 
    AND tablename = 'Master Bookings' 
    AND cmd = 'INSERT'
  ) THEN
    DROP POLICY IF EXISTS "Users can insert Master Bookings" ON "Master Bookings";
  END IF;
END $$;

-- Create a new INSERT policy that properly handles authenticated users
CREATE POLICY "Users can insert Master Bookings"
ON "Master Bookings"
FOR INSERT
TO authenticated
WITH CHECK (true);

-- Verify RLS is still enabled
ALTER TABLE "Master Bookings" ENABLE ROW LEVEL SECURITY;