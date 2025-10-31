/*
  # Add backOnly column to jobs table

  1. Changes
    - Add `back_only` boolean column to `jobs` table with default value of false
    
  2. Notes
    - Uses IF NOT EXISTS to prevent errors if column already exists
    - Sets default value to false to match existing behavior
*/

DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 
    FROM information_schema.columns 
    WHERE table_name = 'jobs' 
    AND column_name = 'back_only'
  ) THEN
    ALTER TABLE jobs ADD COLUMN back_only boolean DEFAULT false;
  END IF;
END $$;