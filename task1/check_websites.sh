#!/bin/bash

websites=("https://google.com" "https://facebook.com" "https://twitter.com")

log_file="website_status.log"

# Очистити файл логів перед новим записом
> "$log_file"

for website in "${websites[@]}"; do
    # отримати лише HTTP-код відповіді (-o /dev/null -s -w "%{http_code}")
    http_code=$(curl -L -o /dev/null -s -w "%{http_code}" "$website")

    if [ "$http_code" -eq 200 ]; then
        echo "<$website> is UP" | tee -a "$log_file"
    else
        echo "<$website> is DOWN" | tee -a "$log_file"
    fi
done

echo "Результати записано у файл $log_file"
