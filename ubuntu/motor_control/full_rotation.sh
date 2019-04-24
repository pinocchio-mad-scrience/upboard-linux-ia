#!/bin/sh -x
 
timeout=0.025
 
in1=27 # GPIO_4 (PIN 13)
in2=22 # GPIO_5 (PIN 15)
in3=5 # GPIO_10 (PIN 29)
in4=6 # GPIO_11 (PIN 31)

AB() {
        echo high > /sys/class/gpio/gpio$in1/direction
        echo high > /sys/class/gpio/gpio$in2/direction
        echo low > /sys/class/gpio/gpio$in3/direction
        echo low > /sys/class/gpio/gpio$in4/direction
}
BC() {
        echo low > /sys/class/gpio/gpio$in1/direction
        echo high > /sys/class/gpio/gpio$in2/direction
        echo high > /sys/class/gpio/gpio$in3/direction
        echo low > /sys/class/gpio/gpio$in4/direction
}
 
CD() {
        echo low > /sys/class/gpio/gpio$in1/direction
        echo low > /sys/class/gpio/gpio$in2/direction
        echo high > /sys/class/gpio/gpio$in3/direction
        echo high > /sys/class/gpio/gpio$in4/direction
}
 
DA() {
        echo high > /sys/class/gpio/gpio$in1/direction
        echo low > /sys/class/gpio/gpio$in2/direction
        echo low > /sys/class/gpio/gpio$in3/direction
        echo high > /sys/class/gpio/gpio$in4/direction
}
 
off() {
        echo low > /sys/class/gpio/gpio$in1/direction
        echo low > /sys/class/gpio/gpio$in2/direction
        echo low > /sys/class/gpio/gpio$in3/direction
        echo low > /sys/class/gpio/gpio$in4/direction
}
 
test() {
        for input in $in1 $in2 $in3 $in4
        do
                echo high > /sys/class/gpio/gpio$input/direction
                sleep 1
                echo low > /sys/class/gpio/gpio$input/direction
        done
}
 
step=0
 
while [ $step -lt 4096 ]
do
        echo "step: $step"
 
        AB
        sleep $timeout
 
        BC
        sleep $timeout
 
        CD
        sleep $timeout
 
        DA
        sleep $timeout
 
        step=`expr $step + 4`
done
 
off

