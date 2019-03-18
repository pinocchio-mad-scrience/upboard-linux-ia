#!/bin/bash

while(true) do

free -tm
sudo sync ; sudo sh -c 'echo 1 > /proc/sys/vm/drop_caches'
sudo sync ; sudo sh -c 'echo 2 > /proc/sys/vm/drop_caches'
sudo sync ; sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'
free -h
done

