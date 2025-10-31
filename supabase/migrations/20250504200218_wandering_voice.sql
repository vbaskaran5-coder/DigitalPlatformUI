/*
  # Import Master Bookings data
  
  1. Changes
    - Import initial set of bookings from Master Bookings spreadsheet
    - Map fields to appropriate columns
    - Set default service type as 'Core Aeration'
    - Set default price as 59.99
*/

INSERT INTO public.jobs (
  master_map,
  route_code,
  first_name,
  last_name,
  house_number,
  street_name,
  home_phone,
  email,
  pp,
  fo,
  log_sheet_notes,
  address,
  customer_name,
  service,
  price,
  status,
  created_at,
  updated_at,
  prepaid,
  front_only
) VALUES
  ('Aldershot #1', 'ALD01', 'Lorraine', 'Favalano', '597', 'Sandcherry Dr', '289 337-2803', 'lorrainecan1942@gmail.com', NULL, NULL, 'SS', '597 Sandcherry Dr', 'Lorraine Favalano', 'Core Aeration', 59.99, 'pending', NOW(), NOW(), false, false),
  ('Aldershot #1', 'ALD01', 'George', 'Rortalato', '615', 'Sandcherry Dr', '416 729-0806', 'gborto@yahoo.com', NULL, NULL, 'SS - MBH', '615 Sandcherry Dr', 'George Rortalato', 'Core Aeration', 59.99, 'pending', NOW(), NOW(), false, false),
  ('Aldershot #1', 'ALD01', 'Pat', 'Mater', '601', 'Sandcherry Dr.', '905 630-9994', 'pat.mager032@sympatico.ca', NULL, NULL, 'SS', '601 Sandcherry Dr.', 'Pat Mater', 'Core Aeration', 59.99, 'pending', NOW(), NOW(), false, false),
  ('Aldershot #1', 'ALD02', 'Kevin', 'Huschilt', '1019', 'Unsworth Ave', '905 484-3439', 'kevin.huschilt@outlook.com', NULL, NULL, NULL, '1019 Unsworth Ave', 'Kevin Huschilt', 'Core Aeration', 59.99, 'pending', NOW(), NOW(), false, false),
  ('Aldershot #1', 'ALD03', 'Calvin', 'Birhan', '809', 'Danforth Pl', '905 730-1284', 'calvin@archmill.ca', 'x', NULL, 'SS', '809 Danforth Pl', 'Calvin Birhan', 'Core Aeration', 59.99, 'pending', NOW(), NOW(), true, false),
  ('Aldershot #1', 'ALD03', 'Siegfried', 'Hoffman', '853', 'Danforth Pl', '905 921-5140', 'sieg.hoffmann1@gmail.com', NULL, 'x', NULL, '853 Danforth Pl', 'Siegfried Hoffman', 'Core Aeration', 59.99, 'pending', NOW(), NOW(), false, true),
  ('Aldershot #1', 'ALD03', 'Bruce', 'Law', '857', 'Danforth Pl', '905 317-0195', 'blaw2@ymail.com', NULL, 'x', 'SS', '857 Danforth Pl', 'Bruce Law', 'Core Aeration', 59.99, 'pending', NOW(), NOW(), false, true),
  ('Aldershot #1', 'ALD03', 'Jim', 'Mcdowell', '913', 'Danforth Pl', '289 337-9136', NULL, NULL, NULL, 'gate', '913 Danforth Pl', 'Jim Mcdowell', 'Core Aeration', 59.99, 'pending', NOW(), NOW(), false, false),
  ('Aldershot #1', 'ALD03', 'Jim', 'Wilson', '970', 'Danforth Pl', '905 525-2231', 'jwilson002@sympatico.ca', NULL, 'x', NULL, '970 Danforth Pl', 'Jim Wilson', 'Core Aeration', 59.99, 'pending', NOW(), NOW(), false, true),
  ('Aldershot #1', 'ALD03', 'Brian', 'Kingdon', '929', 'Gorton Ave', '905 528-8767', 'bekingdon@bell.net', 'x', 'x', NULL, '929 Gorton Ave', 'Brian Kingdon', 'Core Aeration', 59.99, 'pending', NOW(), NOW(), true, true);