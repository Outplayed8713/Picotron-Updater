# Automatic Picotron Updates for Linux
This repository includes scripts for updating [Picotron](https://www.lexaloffle.com/picotron.php) for Linux.

## Included Scripts:
1. **picotron_update.sh:** Downloads and extracts latest version of Picotron if there are new updates.
2. **picotron.sh:** Runs the updater then starts Picotron. This script can be used instead of the Picotron executable so Picotron is always up to date.
3. **generate_desktop_entry**: Creates a Picotron desktop entry so Picotron appears in the applications list. The desktop entry executes the Picotron.sh script.

## Usage:
```bash
➜  picotron_updates git:(main) ./picotron_update.sh 
This script needs your login credentials to https://www.lexaloffle.com/ to install updates.
Enter username: your_username
Enter password: your_password 

Latest Picotron Version: x.x.x
Updating Picotron.
```

``` bash
➜  picotron_updates git:(main) ./picotron.sh 
Latest Picotron Version: x.x.x
No Picotron updates are available.
Starting Picotron!
```

``` bash
➜  picotron_updates git:(main) ./generate_desktop_entry.sh 
Created Picotron.desktop.
Added Picotron.desktop entry to applications list.
```
Create symbolic link to picotron.sh. Preferably done in a directory that is part of your $PATH so you can execute it from anywhere.
```bash
ln -s Picotron-Updater/picotron.sh ~/.local/bin/
```

## Warning:
These scripts require your lexaloffle account credentials to download the latest version of Picotron. The script will prompt for your credentials and will store them in a plaintext file on your computer. The script sets the file permission to 600, so only your user can read and write to this file, but be aware that your account password could be easily exposed in the event your system is compromised.
