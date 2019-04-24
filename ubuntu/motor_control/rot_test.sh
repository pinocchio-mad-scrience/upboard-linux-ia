#! /bin/bash -x

cd

echo # newline
echo "28BYJ-48 Servo test"

in1=27 # GPIO_4 (PIN 13)
in2=22 # GPIO_5 (PIN 15)
in3=5 # GPIO_10 (PIN 29)
in4=6 # GPIO_11 (PIN 31)

# set up SOC GPIO 4, 5, 10, 11 to output
echo "$in1" > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio$in1/direction
echo "$in2" > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio$in2/direction
echo "$in3" > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio$in3/direction
echo "$in4" > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio$in4/direction

# set timing and no. cycles
delay=1
cycles=512

# ripple across pins in 3s
for (( i=1; i<=$cycles; i++ ))
do
echo "0" > /sys/class/gpio/gpio$in1/value
echo "1" > /sys/class/gpio/gpio$in2/value
sleep $delay
echo "0" > /sys/class/gpio/gpio$in3/value
echo "1" > /sys/class/gpio/gpio$in2/value
sleep $delay
echo "0" > /sys/class/gpio/gpio$in4/value
echo "1" > /sys/class/gpio/gpio$in3/value
sleep $delay
echo "0" > /sys/class/gpio/gpio$in3/value
echo "1" > /sys/class/gpio/gpio$in4/value
sleep $delay
done

# clean up
echo "0" > /sys/class/gpio/gpio$in1/value
echo "0" > /sys/class/gpio/gpio$in2/value
echo "0" > /sys/class/gpio/gpio$in3/value
echo "0" > /sys/class/gpio/gpio$in4/value
echo "$in1" > /sys/class/gpio/unexport
echo "$in2" > /sys/class/gpio/unexport
echo "$in3" > /sys/class/gpio/unexport
echo "$in4" > /sys/class/gpio/unexport
