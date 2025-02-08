freduse CPIAUCSL, clear
gen year = year(daten)
gen month = month(daten)
keep if (year >= 2008 & year <= 2024)
drop daten year month
gen date_num = date(date, "YMD")
format date_num %td
gen date_month = mofd(date_num)
format date_month %tm
drop date date_num
rename date_month date
order date CPIAUCSL
tsset date
tsline CPIAUCSL
list date CPIAUCSL in 1/10

* Load the Consumer Price Index (CPIAUCSL) dataset directly from FRED
freduse CPIAUCSL, clear   // Fetch data from the Federal Reserve Economic Data (FRED) database

* Extract year and month components from the 'daten' variable (likely a date format)
gen year = year(daten)    // Create a new variable 'year' that extracts the year from 'daten'
gen month = month(daten)  // Create a new variable 'month' that extracts the month from 'daten'

* Keep only the data from the period 2008 to 2024
keep if (year >= 2008 & year <= 2024)  // Filters out all observations outside this range

* Save the cleaned dataset to a specified location on the computer
save "/Users/tylersotomayor/STAT/CPIAUCSL-2008-2024-new.dta", replace  // Save dataset with a new filename

* Remove unnecessary variables to clean up the dataset
drop daten year month  // 'daten' is no longer needed after extracting year & month

* Plot the time series for CPIAUCSL
tsline CPIAUCSL  // Creates a simple time series plot for the CPI data

* Properly define the date variable
gen date_num = date(daten, "YMD")  // Convert 'daten' into a Stata numeric date format (YYYY-MM-DD)
format date_num %td                 // Apply a date format to 'date_num' for readability

* Convert the date into a monthly format for time-series structure
gen date_month = mofd(date_num)  // Convert daily date into a monthly date format
format date_month %tm            // Apply a monthly date format to 'date_month'

* Remove redundant variables that were only used for transformation
drop daten date_num  // Remove 'daten' (original date) and 'date_num' (intermediate step)

* Rename the final cleaned date variable to 'date' for clarity
rename date_month date  // Use 'date' as the standard time-series identifier

* Ensure proper order of variables in the dataset for clarity
order date CPIAUCSL  // Moves 'date' to the first column

* Declare the dataset as a time-series dataset using the 'date' variable
tsset date  // Set 'date' as the time variable for time-series analysis

* Plot the time series again after proper date formatting
tsline CPIAUCSL  // Generate an updated time series plot

* Display the first 10 observations to check the final structure
list date CPIAUCSL in 1/10  // Lists the first 10 rows of 'date' and 'CPIAUCSL'
