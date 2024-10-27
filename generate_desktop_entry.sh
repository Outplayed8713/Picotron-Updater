#!/bin/bash
dir="$(dirname -- "$(readlink -f -- "$0")")"
cat <<EOF >$dir/Picotron.desktop
[Desktop Entry]

# The type as listed above
Type=Application

# The version of the desktop entry specification to which this file complies
Version=1.0

# The name of the application
Name=Picotron

# A comment which can/will be used as a tooltip
Comment=Virtual Workstation OS

# The executable of the application, possibly with arguments.
Exec=$dir/picotron.sh

# The name of the icon that will be used to display this entry
Icon=lexaloffle-picotron

# Describes whether this application needs to be run in a terminal or not
Terminal=false

# Describes the categories in which this entry should be shown
Categories=Development;Game;
EOF
echo "Created Picotron.desktop."

mkdir -p ~/.local/share/applications
mkdir -p ~/.icons
cp $dir/Picotron.desktop ~/.local/share/applications
cp $dir/lexaloffle-picotron.png ~/.icons
echo "Added Picotron.desktop entry to applications list."
