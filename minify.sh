echo "building"
date -u
python3 ~/Downloads/shrinko8-main\ 2/shrinko8.py bn2.p8 bn2-min.p8 --minify --no-minify-lines --rename-safe-only --rename-map rename_map.txt --count
#python3 ~/Downloads/shrinko8-main\ 2/shrinko8.py bn2.p8 bn2-min.p8 --minify --rename-safe-only --rename-map rename_map.txt
#/Applications/PICO-8.app/Contents/MacOS/pico8 -x tinyhawk-min.p8 -export "build/tinyhawk.html -f -p ../plates/better_splash"
#/Applications/PICO-8.app/Contents/MacOS/pico8 -x tinyhawk-min.p8 -export "build/tinyhawk.bin -i 231 -s 2 -c 0"
#/Applications/PICO-8.app/Contents/MacOS/pico8 -x tinyhawk-min.p8 -export "build/tinyhawk.p8.png"
#ditto -c -k --sequesterRsrc --keepParent build/tinyhawk_html build/tinyhawk_html.zip
echo "-done-"