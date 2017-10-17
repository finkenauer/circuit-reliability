* Transient Simulation for Nand2

* ------------------------------ *
* Transistor model and import the file with the subckts
.options compat=PSPICE
.include ams35ps.lib
.include logicGates.sp

* ------------------------------ *
.param supply=3.3 	* supply == vcc
.param NandWp=60u
.param NandWn=50u

* ------------------------------ *
* source input
* Vname n+ n- pulse(v1 v2 td trise tfall pw per)
vin1 a  0  pulse (0 3.3 0 0.1n 0.1n 1.1n 2.2n)
vin2 b  0  pulse (0 3.3 0 0.1n 0.1n 2.2n 4.4n)

* ------------------------------ *
* Circuit Description
X1 a b out GND_ vcc nand

* ------------------------------ *
* capacitor
* Cname  n+ n- value
C1 out 0 17fF

* ------------------------------ *
* transient analysis
* .tran step total
.tran 0.001n 20n

* ------------------------------ *
* measures:
* measure propagation delay
.measure tran pLHa
+ trig v(a)   val='supply/2' fall=1
+ targ v(out) val='supply/2' rise=1

.measure tran pHLa
+ trig v(a)   val='supply/2' rise=1
+ targ v(out) val='supply/2' fall=1

.measure tran pLHb
+ trig v(b)   val='supply/2' fall=1
+ targ v(out) val='supply/2' rise=2

.measure tran pHLb
+ trig v(b)   val='supply/2' rise=1
+ targ v(out) val='supply/2' fall=2


* measure rise/fall time
.measure tran trise		* rise time
+ trig v(out) val='0.2*supply' rise=1
+ targ v(out) val='0.8*supply' rise=1

.measure tran tfall		* fall time
+ trig v(out) val='0.8*supply' fall=1
+ targ v(out) val='0.2*supply' fall=1

* ------------------------------ *
* power
*.print power(vcc)
.measure tran avg_power avg power from=0 to=20n 	* average power

* ------------------------------ *
* plot outputs
.print tran a b out
.print v(a) v(b) v(out)

.end