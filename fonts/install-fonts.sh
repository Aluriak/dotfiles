wget https://use.fontawesome.com/releases/v6.4.0/fontawesome-free-6.4.0-desktop.zip -O fa.zip
unzip fa.zip
mkdir -p ~/.fonts
cp fontawesome*desktop/otfs/*.otf ~/.fonts
fc-cache -f -v
