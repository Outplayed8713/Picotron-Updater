#!/bin/bash
dir="$(dirname -- "$(readlink -f -- "$0")")"
local_version="$(grep "Picotron v" "$dir/picotron/picotron_manual.txt" 2>/dev/null | cut -d v -f2 | tr -d $'\r')"
cookie_expiration="$(grep "s_pass" "$dir/cookies.txt" 2>/dev/null | cut -f5)"

GetNewCookie() {
  if [[ -e "$dir/config" ]]; then
    source "$dir/config"
    curl --cookie-jar "$dir/cookies.txt" --form pass=$pass --form user=$user 'https://www.lexaloffle.com/account.php?page=login'
    chmod 600 "$dir/cookies.txt"
  else
    echo "This script needs your login credentials to https://www.lexaloffle.com/ to install updates."
    read -p "Enter username: " user
    read -s -p "Enter password: " pass
    echo
    echo
    echo "user='$user'" >config
    echo "pass='$pass'" >>config
    chmod 600 "$dir/config"
    curl --cookie-jar "$dir/cookies.txt" --form pass=$pass --form user=$user 'https://www.lexaloffle.com/account.php?page=login'
    chmod 600 "$dir/cookies.txt"
    cookie_expiration="$(grep "s_pass" "$dir/cookies.txt" 2>/dev/null | cut -f5)"
    if [[ -z $cookie_expiration ]]; then
      echo "Invalid credentials provided."
      echo "Cannot Install latest version of Picotron."
      rm "$dir/config" "$dir/cookies.txt"
      exit
    fi
  fi
}

Update() {
  curl -s -b "$dir/cookies.txt" -O --output-dir "$dir" "$zip_url"
  unzip -o "$dir/*.zip" -d "$dir"
  rm $dir/*.zip
}

CheckForUpdates() {
  if [[ "$(date +%s)" > $cookie_expiration ]]; then
    GetNewCookie
  fi
  zip_url="https://www.lexaloffle.com$(curl -s -b "$dir/cookies.txt" "https://www.lexaloffle.com/games.php?page=updates" | grep "picotron.*amd64" | cut -d = -f 2 | cut -d ">" -f 1)"
  latest_version="$(echo $zip_url | cut -d _ -f2 | tr -d ' ')"
  echo "Latest Picotron Version: $latest_version"
  if [[ "$latest_version" != "$local_version" ]]; then
    echo "Updating Picotron."
    Update
  else
    echo "No Picotron updates are available."
  fi
}

CheckForUpdates
