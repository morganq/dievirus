echo "building"
date -u
python3 ./shrinko8/shrinko8.py bn2.p8 bn2-min.p8 --minify --no-minify-lines --rename-safe-only --rename-map rename_map.txt --count
echo "-done-"