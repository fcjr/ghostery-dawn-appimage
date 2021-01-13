#!/bin/bash

# download lastest
#wget --content-disposition https://get.ghosterybrowser.com/download/linux

# extract version number
VERSION=$(ls Ghostery-*.tar.bz2 | cut -d "-" -f 2 | sed -e 's|.tar.bz2||g')

# extract package
mkdir -p build/usr/bin
tar -xf Ghostery*.tar.bz2 --strip-components=1 -C build/usr/bin

#copy image
cp ghostery.png build

# create desktop & apprun files
cat > build/ghostery.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Ghostery
Icon=ghostery
Exec=Ghostery %u
Categories=GNOME;GTK;Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;x-scheme-handler/chrome;video/webm;application/x-xpinstall;
StartupNotify=true
EOF

cat > build/AppRun <<\EOF
#!/bin/bash
HERE="$(dirname "$(readlink -f "${0}")")"
"$HERE/usr/bin/Ghostery" "$@"
EOF
chmod a+x build/AppRun

# create app image
mkdir -p dist
appimagetool build "dist/Ghostery$VERSION.AppImage"
