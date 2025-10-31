/*
  # Create Master Bookings table with complete dataset
  
  1. Changes
    - Create Master Bookings table with all required columns
    - Add indexes for commonly queried columns
    - Enable RLS with appropriate policies
    - Import all data from the CSV file
    
  2. Notes
    - Uses text type for all columns to match CSV format
    - Includes automatic UUID generation for Booking ID
    - Adds created_at and updated_at timestamps
*/

-- Drop existing table if it exists
DROP TABLE IF EXISTS "Master Bookings";

-- Create the Master Bookings table
CREATE TABLE "Master Bookings" (
  "Booking ID" text PRIMARY KEY DEFAULT gen_random_uuid()::text,
  "Booked By" text,
  "Date/Time Booked" text,
  "Master Map" text,
  "Route Number" text,
  "First Name" text,
  "Last Name" text,
  "Full Address" text,
  "Home Phone" text,
  "Cell Phone" text,
  "Email Address" text,
  "Price" text,
  "Prepaid" text,
  "FO/BO/FP" text,
  "Log Sheet Notes" text,
  "Completed" text,
  "Cancelled" text,
  "Date Completed" text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create indexes for commonly queried columns
CREATE INDEX IF NOT EXISTS master_bookings_route_number_idx ON "Master Bookings" ("Route Number");
CREATE INDEX IF NOT EXISTS master_bookings_date_time_booked_idx ON "Master Bookings" ("Date/Time Booked");
CREATE INDEX IF NOT EXISTS master_bookings_completed_idx ON "Master Bookings" ("Completed");
CREATE INDEX IF NOT EXISTS master_bookings_cancelled_idx ON "Master Bookings" ("Cancelled");

-- Enable Row Level Security
ALTER TABLE "Master Bookings" ENABLE ROW LEVEL SECURITY;

-- Create RLS policies
CREATE POLICY "Users can read Master Bookings"
  ON "Master Bookings"
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Users can insert Master Bookings"
  ON "Master Bookings"
  FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Users can update Master Bookings"
  ON "Master Bookings"
  FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Create updated_at trigger
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_master_bookings_updated_at
    BEFORE UPDATE ON "Master Bookings"
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Insert all data from CSV
INSERT INTO "Master Bookings" (
  "Master Map",
  "Route Number",
  "First Name",
  "Last Name",
  "Full Address",
  "Home Phone",
  "Email Address",
  "FO/BO/FP",
  "Log Sheet Notes",
  "Prepaid"
) VALUES
  ('Aldershot #1', 'ALD01', 'Lorraine', 'Favalano', '597 Sandcherry Dr', '289 337-2803', 'lorrainecan1942@gmail.com', 'FP', 'SS', NULL),
  ('Aldershot #1', 'ALD01', 'George', 'Rortalato', '615 Sandcherry Dr', '416 729-0806', 'gborto@yahoo.com', 'FP', 'SS - MBH', NULL),
  ('Aldershot #1', 'ALD01', 'Pat', 'Mater', '601 Sandcherry Dr.', '905 630-9994', 'pat.mager032@sympatico.ca', 'FP', 'SS', NULL),
  ('Aldershot #1', 'ALD02', 'Kevin', 'Huschilt', '1019 Unsworth Ave', '905 484-3439', 'kevin.huschilt@outlook.com', 'FP', NULL, NULL),
  ('Aldershot #1', 'ALD03', 'Calvin', 'Birhan', '809 Danforth Pl', '905 730-1284', 'calvin@archmill.ca', 'FP', 'SS', 'x'),
  ('Aldershot #1', 'ALD03', 'Siegfried', 'Hoffman', '853 Danforth Pl', '905 921-5140', 'sieg.hoffmann1@gmail.com', 'FO', NULL, NULL),
  ('Aldershot #1', 'ALD03', 'Bruce', 'Law', '857 Danforth Pl', '905 317-0195', 'blaw2@ymail.com', 'FO', 'SS', NULL),
  ('Aldershot #1', 'ALD03', 'Jim', 'Mcdowell', '913 Danforth Pl', '289 337-9136', NULL, 'FP', 'gate', NULL),
  ('Aldershot #1', 'ALD03', 'Jim', 'Wilson', '970 Danforth Pl', '905 525-2231', 'jwilson002@sympatico.ca', 'FO', NULL, NULL),
  ('Aldershot #1', 'ALD03', 'Brian', 'Kingdon', '929 Gorton Ave', '905 528-8767', 'bekingdon@bell.net', 'FO', NULL, 'x'),
  ('Aldershot #1', 'ALD03', 'Greg', 'Madden', '907 North Shore Blvd W', '905 689-9538', 'maddengreg10@gmail.com', 'BO', NULL, NULL),
  ('Aldershot #1', 'ALD03', 'Josh', 'Smith', '911 North Shore Blvd W', '416 436-7655', 'jxsmith18@gmail.com', 'FO', 'SS', NULL),
  ('Aldershot #1', 'ALD04', 'Chris', 'Cafley', '985 Boothman Ave', '416 566-1652', 'ccafley@gmail.com', 'BO', NULL, NULL),
  ('Aldershot #1', 'ALD05', 'Andrew', 'Bennamon', '207 Callum Ct', '289 339-9314', 'andrewbannerman99@gmail.com', 'FP', NULL, NULL),
  ('Aldershot #1', 'ALD05', 'Dave', 'Lain', '935 Coleman Ct', '905 330-2523', 'klain2015@gmail.com', 'FP', NULL, NULL),
  ('Aldershot #1', 'ALD05', 'Alice', 'Guy', '892 Daryl Dr', '905 632-9258', NULL, 'FP', NULL, NULL),
  ('Aldershot #1', 'ALD06', 'Bert', 'Posedowski', '320 North Shore Blvd W', '905 525-0966', 'bert.posedowski@bell.net', 'FP', NULL, NULL),
  ('Aldershot #1', 'ALD07', 'Claudia', 'Steffer', '933 Glen Wood Ave', '905 518-4280', 'steffle@mcmaster.ca', 'FP', NULL, NULL),
  ('Aldershot #1', 'ALD08', 'Howard', 'MCCramara', '1030 Gallagher Rd', '905 637-3798', 'hrmcnamara@symapatico.ca', 'FO', NULL, NULL),
  ('Aldershot #2', 'ALD09', 'Denis', 'Sourcaudot', '228 Ascot Pl', '905 407-8450', 'dfourcaubot@gmail.com', 'FO', NULL, 'x'),
  ('Aldershot #2', 'ALD09', 'Ann', 'Petz', '819 Forest Glen Ave', '905 632-6674', 'acpburl@yahoo.ca', 'FP', 'CF', NULL),
  ('Aldershot #2', 'ALD09', 'Patrice', 'Collins', '205 North Shore Blvd W', '416 554-1991', 'patriccollins1028@gmail.com', 'FO', 'SS', 'x'),
  ('Aldershot #2', 'ALD09', 'Eric', 'Phillips', '78 Overdale', '905 296-3380', NULL, 'FO', 'CF', NULL),
  ('Aldershot #2', 'ALD09', 'Tony', 'Wuyzkowski', '881 Shaddhand Ave', '905 599-4669', 'tonywysz@gmail.com', 'BO', NULL, 'x'),
  ('Aldershot #2', 'ALD09', 'Louha', 'Magella', '889 Shaddhand Ave', '289 400-9621', 'prynetine@gmail.com', 'FO', NULL, 'x'),
  ('Aldershot #2', 'ALD09', 'louha', 'magella', '903 Shaddhand Ave', '289 400-9621', 'prynetine@gmail.com', 'BO', NULL, 'x'),
  ('Aldershot #2', 'ALD09', 'Chela', 'Eskicioglo', '895 unsworth ave', '416 829-6802', 'cagla.eskicioglu@gmail.com', 'FP', NULL, NULL),
  ('Aldershot #2', 'ALD10', 'Ian', 'Hughes', '809 Tanager Ave', '905 637-5662', 'mckennahughes25@gmail.com', 'FP', NULL, NULL),
  ('Aldershot #2', 'ALD10', 'Mark', 'Torrance', '861 Tanager Ave', '905 327-2275', 'acstorrance@me.com', 'FP', NULL, NULL),
  ('Aldershot #2', 'ALD10', 'Jim', 'Oglen', '834 Teal Dr', '905 220-1443', 'jimmycogden@gmail.com', 'FP', NULL, 'x'),
  ('Aldershot #2', 'ALD10', 'John', 'Corrigan', '915 Teal Dr', '289 962-1510', 'jcorrigan007@gmail.com', 'FP', 'SS', 'x'),
  ('Aldershot #2', 'ALD11', 'Janet', 'McNally', '905 Eagle Dr', '905 317-7763', 'jhmcnally1@gmail.com', 'FO', 'SS', NULL),
  ('Aldershot #2', 'ALD11', 'Jerry', 'Rusin', '774 Partridge Dr', '416 819-6026', 'rusinjerry@gamil.com', 'FO', NULL, NULL),
  ('Aldershot #2', 'ALD12', 'Anthony', 'Groleau', '833 Teal Dr', '905 719-8961', 'agroleau89@gmail.com', 'FP', NULL, NULL),
  ('Aldershot #2', 'ALD14', 'Mrs', 'Reed', '1039 Cedarwood Pl', '905 637-2090', 'reedbarbnoel@msn.com', 'FO', NULL, NULL),
  ('Aldershot #2', 'ALD14', 'mehmood', 'Ismail', '595 Kingswood Pl', '905 616-3727', 'ismile123@hotmail.com', 'FO', NULL, NULL),
  ('Aldershot #2', 'ALD15', 'Alex', 'Dodrowolski', '943 Nora Dr', '416 677-3241', NULL, 'BO', NULL, NULL),
  ('Aldershot #2', 'ALD15', 'Susan', 'Rogers', '865', '905 320-6356', 'sboychak@cogeco.ca', 'FO', '2nd RUN', NULL),
  ('Aldershot #2', 'ALD16', 'Mark', 'Benny', '657 Inverness Ave', '905 634-0710', 'mbenny10@cogeco.ca', 'BO', 'watch stones in BY', NULL),
  ('Aldershot #2', 'ALD16', 'Justin', 'Warren', '599 Kingswood Pl', '416 994-7735', 'dmdenver@hotmail.com', 'FP', NULL, NULL),
  ('Aldershot #2', 'ALD16', 'Ena', 'Rough', '943 Long Dr', '905 681-1093', NULL, 'FP', NULL, NULL),
  ('Aldershot #2', 'ALD16', 'Pat', 'Mcleod', '954 Long Dr', '905 639-6977', 'patricia.mcleod54@gmail.com', 'FP', NULL, NULL),
  ('Aldershot #2', 'ALD17', 'Gaston', 'Lapointe', '900 Cloverleaf Dr', '905 320-1721', 'gaston.lapoint8@gmail.com', 'FP', NULL, NULL),
  ('Aldershot #2', 'ALD17', 'Helen', 'Broderick', '976 Cloverleaf Dr', '905 639-1839', 'hbroderick@cogeco.ca', 'FP', NULL, NULL),
  ('Aldershot #2', 'ALD17', 'Mark', 'Sherk', '969 Glen View Ave', '289 442-3761', 'mjones13@cogeco.ca', 'FO', 'gate/SS', NULL),
  ('Aldershot #2', 'ALD17', 'John', 'Maheu', '1099 Marley Cr', '905 220-1146', 'jmm.mapm@gmail.com', 'FO', NULL, NULL),
  ('Aldershot #2', 'ALD20', 'Brian', 'Pedherney', '653 Gayne Blvd', '905 631-6979', 'bpedherney@gmail.com', 'FP', NULL, NULL),
  ('Aldershot #2', 'ALD20', 'Jane', 'Bagley', '693 Holt Dr', '905 634-3334', 'janebagley03@gmail.com', 'FO', 'gate', NULL),
  ('Aldershot #2', 'ALD20', 'Clint', 'Ellicott', '652 Vanderburgh Dr', '905 333-6263', 'clintellicott@gmail.com', 'FO', 'SS', 'x'),
  ('Aldershot #2', 'ALD21', 'Greg', 'Placidi', '554 Huron Dr', '905 319-8886', 'placidig@hotmail.com', 'BO', 'SS', NULL),
  ('Brant Hills', 'BH02', 'Teresa', 'Joubert', '2386 Arnold Cr', '905 320-2578', 'benoitrjoubert@yahoo.ca', 'FO', NULL, NULL),
  ('Brant Hills', 'BH02', 'Teresa', 'Burnham', '2418 Coventry Way', '905 580-0946', 'burnhamt7@gmail.com', 'BO', NULL, 'x'),
  ('Brant Hills', 'BH02', 'Mr', 'Cyr', '2324 Gillingham Dr', '416 558-3022', 'idan.cyr@gmail.com', 'FP', NULL, 'x'),
  ('Brant Hills', 'BH02', 'David', 'Lynn', '2327 Gillingham Dr', '905 335-7984', 'dlynn49@cogeco.ca', 'FP', NULL, 'x'),
  ('Brant Hills', 'BH02', 'Jose', 'Sales', '2390 Malcolm Cr', '905 336-3931', 'Jrs@hotmail.com', 'FP', NULL, NULL),
  ('Brant Hills', 'BH02', 'Mark', 'Gardner', '2433 Whittaker Dr', '226 402-0554', 'marla834@gmail.com', 'FP', NULL, NULL),
  ('Brant Hills', 'BH03', 'Larry', 'Code', '2471 Cavendish Dr', '289 208-4811', 'larry.code@circlek.com', 'FP', 'SS - MBH', NULL),
  ('Brant Hills', 'BH03', 'Ian', 'Clarke', '2308 Glastonbury Rd', '905 335-2588', 'iclarke57@icloud.com', 'FO', NULL, NULL),
  ('Brant Hills', 'BH04', 'Jim', 'Swierzewster', '2256 Ingersoll Dr', '905 335-0878', 'jimsacraftycarter@gmail.com', 'FO', NULL, NULL),
  ('Brant Hills', 'BH05', 'Mel', 'Borton', '2203 Previn Cr', '905 335-1506', 'melburtonaf@hotmail.com', 'FP', NULL, NULL),
  ('Brant Hills', 'BH05', 'Mark', 'Kerr', '2400 Sinclair Cir', '289 332-8606', 'msdmkerr@hotmail.com', 'FO', NULL, NULL),
  ('Brant Hills', 'BH05', 'Mr', 'Knight', '2402 Sinclair Cir', '905 336-1577', 'aknight1@cogeco.ca', 'FO', NULL, NULL),
  ('Brant Hills', 'BH05', 'Angela', 'Davidson', '2406 Sinclair Cr', '647 282-8449', NULL, 'BO', NULL, NULL),
  ('Brant Hills', 'BH05', 'Dan', 'Steele', '2457 Sinclair Cr', '905 336-9497', NULL, 'FO', 'CF', NULL),
  ('Brant Hills', 'BH06', 'Mike', 'Micheletti', '2142 Cartier Cr', '905 331-0157', 'mmicheletti@cogeco.ca', 'BO', 'CIF / NO TAX', 'x'),
  ('Brant Hills', 'BH06', 'Denis', 'Therria', '2185 Cartier Cr', '905 356-3747', 'knuckled62@gmail.com', 'FP', NULL, NULL),
  ('Brant Hills', 'BH06', 'Dennis', 'Molyneaux', '2198 Cartier Cr', '905 335-7157', 'dmolyneaux@cogeco.ca', 'FP', NULL, NULL),
  ('Brant Hills', 'BH06', 'Jane', 'Waller', '2237 melanie crt', '905 335-2173', 'coachdoug99@gmail.com', 'FP', NULL, NULL),
  ('Brant Hills', 'BH06', 'Doug', 'Waller', '2237 Melanie Ct', '905 335-2173', 'coachdoug99@gmail.com', 'FP', NULL, NULL),
  ('Brant Hills', 'BH06', 'Bruce', 'Wintebottom', '2217 Melissa Cr', '905 332-3341', 'winterbottom@sympatico.ca', 'FP', NULL, NULL),
  ('Brant Hills', 'BH06', 'Ron', 'Hammond', '2243 Sheffield Dr', '905 332-4884', 'ron@corrugated-sheets.com', 'FO', NULL, 'x'),
  ('Brant Hills', 'BH06', 'Grace', 'Hunter', '2247 Sheffield Dr', '905 319-0228', 'hunterg2222@yahoo.com', 'FO', NULL, 'x'),
  ('Brant Hills', 'BH07', 'Brent', 'Stack', '2020 Cavendish Dr', '647 262-7502', 'brentxstack@yahoo.com', 'FP', NULL, 'x'),
  ('Brant Hills', 'BH08', 'Lyman', 'Nelson', '1281 Abbey Crt', '519 323-7356', 'lymannelson2017@gmail.com', 'FO', NULL, NULL),
  ('Brant Hills', 'BH08', 'Paul', 'Leonard', '2211 Bellgrave Ct', '905 335-2127', 'pleonard373@bell.net', 'FO', NULL, NULL),
  ('Brant Hills', 'BH08', 'Richard', 'Brown', '1085 Havendale Blvd', '905 331-6720', 'brownkin@mac.com', 'BO', NULL, NULL),
  ('Brant Hills', 'BH08', 'Brent', 'Haugen', '2174 Havendale Blvd', '905 317-9410', NULL, 'FO', 'CF', NULL),
  ('Brant Hills', 'BH08', 'Marcia', 'Tessler', '1311 Knights Bridge', '905 483-0510', 'marmeltes@gmail.com', 'BO', NULL, 'x'),
  ('Brant Hills', 'BH08', 'Kirby', 'Williams', '1320 Knights Bridge', '905 220-7868', 'kirby.williams@bell.net', 'FP', NULL, 'x'),
  ('Brant Hills', 'BH09', 'Merie', 'Goxcraft', '1206 Apple Ford', '905 512 7007', 'mfoxcroft@fluke.ca', 'FP', 'SS', 'x'),
  ('Brant Hills', 'BH09', 'Eimira', 'Sabouneui', '1212 Apple Ford', '905 631 3232', 'elmira@cogeco.com', 'FP', NULL, 'x'),
  ('Brant Hills', 'BH09', 'Dave', 'Campbell', '1223 Appleford Ln', '905 691-6702', 'drcampbell.campbell@gmail.com', 'FP', NULL, NULL),
  ('Brant Hills', 'BH09', 'Garry', 'Huibers', '1292 Monmouth Dr', '905 467-4011', 'garryhuibers@gmail.com', 'FP', NULL, NULL),
  ('Brant Hills', 'BH12', 'Danielle', 'Alderman', '2180 Blackburn Ct', '905 315-9783', 'danielle@daniellealderman.com', 'FP', 'gate (dog)', NULL),
  ('Brant Hills', 'BH12', 'Steve', 'Bourassa', '2182 Blackburn Ct', '289 242-3150', 'bourasa.steve@gmail.com', 'FP', NULL, NULL),
  ('Brant Hills', 'BH12', 'Turner', 'Turner', '2639 Cavendish Dr', '905 520-7707', 'jim@jvturner.com', 'FP', NULL, NULL),
  ('Brant Hills', 'BH12', 'Christine', 'Moore', '2455 Overton Dr', '905 336-5277', 'cmoore242@cogeco.ca', 'FP', NULL, NULL),
  ('Brant Hills', 'BH14', 'Gord', 'Slack', '2393 Coldstream Dr', '905 336-7609', 'slack9770@gmail.com', 'FO', NULL, NULL),
  ('Brant Hills', 'BH14', 'Robert', 'Collum', '2322 Fleet Path', '905 332-4654', 'recollum4@gmail.com', 'FO', NULL, NULL),
  ('Brant Hills', 'BH14', 'Ian', 'Freeman', '2343 Middlesmoor Cr', '289 208-4505', 'freeman.ian.p@gmail.com', 'FP', NULL, 'x'),
  ('Brant Hills', 'BH14', 'Larry', 'Milne', '2399 Sherburne Dr', '905 336-1851', 'larrymilne@cogeco.ca', 'FO', 'SS - MBH', NULL),
  ('Brant Hills', 'BH15', 'Vince', 'Taylor', '2555 Cavendish Dr', '905 331-0898', 'vnjtaylor@sympatico.ca', 'FO', NULL, NULL),
  ('Brant Hills', 'BH15', 'Jeff', 'McArthur', '2414 Eaglesfield Dr', '905 335-0669', 'thenines@hotmail.com', 'BO', NULL, NULL),
  ('Brant Hills', 'BH15', 'Tim', 'Keeler', '2314 Malcolm Cr', '905 331-4414', 'tkeeler@sympatico.ca', 'FO', NULL, NULL);