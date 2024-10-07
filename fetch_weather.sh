#!/bin/bash

#Script for fetching data from OpenWeatherMap

#Configuration

API_KEY="some key"
CITY="${1:-New York}"
UNITS="metric"
BASE_URL="https://api.openweathermap.org/data/2.5/weather"

#Databse cedentials
DB_USER="root"
DB_PASSWORD="some password"
DB_NAME="Weather_data"


#Fetch weather data using curl - the response variable is used to campture the output

response=$(curl -s -G "$BASE_URL" --data-urlencode "q=$CITY" --data-urlencode "appid=$API_KEY" --data-urlencode "units=$UNITS")

# Check if the response constains an error
 

cod=$(echo "$response" | jq '.cod')
if [ "$cod" -ne 200 ]; then
   message=$(echo "$response" | jq -r '.message')
    echo "Error fetching weather data: $message"
    break
fi


#Exctract desired fields using jq which is used for processing json data 

temperature=$(echo "$response" | jq '.main.temp')
humidity=$(echo "$response" | jq '.main.humidity')
description=$(echo "$response" | jq -r '.weather[0].description')
city_name=$(echo "$response" | jq -r '.name')
timestamp=$(date +"%Y-%m-%d %H:%M:%S")

#Display the fetched data

echo "City: $city_name"
echo "Temperature: $temperature°C"
echo "Humidity: $humidity%"
echo "Weather Description: $description"
echo "Timestamp: $timestamp"

#Inserting the data into the mysql database - EOF is used to send out as input into the mysql command

mysql -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" <<EOF
    INSERT INTO weather (city, temperature, humidity, weather_description, timestamp)
    VALUES ('$city_name', $temperature, $humidity, '$description', '$timestamp');
EOF

echo "Running script"
