# From My-Unix-Stuff
for i in ~/My-Unix-Stuff/profile.d/*.sh; do
    if [ -r "$i" ]; then
        source $i
    fi
done


