# killmatch localhost:24800
ssh -f -N -L localhost:24800:10.12.64.11:24800 10.12.64.11
synergyc -f localhost
