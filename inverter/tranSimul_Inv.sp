* Transient Simulation for Inverter

* ------------------------------ *
* Transistor model and import the file with the subckts
.options compat=PSPICE
.include ams35ps.lib
.include logicGates.sp
*.include measure.sp

* ------------------------------ *
.param supply=3.3 	* supply == vcc
.param InvWp=60u
.param InvWn=30u

* ------------------------------ *
* source input
* Vname n+ n- pulse(v1 v2 td trise tfall pw per)
vin1 a  0  pulse (0 3.3 0 0.1n 0.1n 1.n 2.2n)

* ------------------------------ *
* Circuit Description
X1 a out vcc inv

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
.measure tran pLH
+ trig v(a)   val='supply/2' fall=1
+ targ v(out) val='supply/2' rise=1

.measure tran pHL
+ trig v(a)   val='supply/2' rise=1
+ targ v(out) val='supply/2' fall=1
*
.measure tran tpdr param = 'pLH * 1e12'	* rising drop delay (ps)
.measure tran tpdf param = 'pHL * 1e12'	* falling drop delay (ps)
.measure tran tpd param='(tpdr+tpdf)/2'	* average prop delay (ps)

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
.print tran a out
.print v(a) v(out)

.end