# Weather_data
Weather data collection and storage
The objective of this project is to collect weather data by using a public api and then store it into a mysql database by using XAMPP
The table structure for the database is as follows:
CREATE TABLE weather (
  id INT AUTO_INCREMENT PRIMARY KEY,
  city VARCHAR(50),
  temperature DECIMAL(5,2),
  humidity INT,
  weather_description VARCHAR(100),
  timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
);
 ( the script is explained in the executable )

command for connecting to the server - mysql -u username -p -h hostname -P portnumber
