* Monte Carlo Simulation for Nand2

* ------------------------------ *
* Transistor model and import the file with the subckts
.options compat=PSPICE
.include ams35ps.lib
.include logicGates.sp
*.include measure.sp

.options numdgt = 6

* ------------------------------ *
.param supply=3.3 	* supply == vcc
.param slopeTec=0.006n
.param NandWp=60u
.param NandWn=50u

* ------------------------------ *
* source input
* Vname n+ n- pulse(v1 v2 td trise tfall pw per)
*vin1 a  0  pulse (0 3.3 0 0.1n 0.1n 1.1n 2.2n)
*vin2 b  0  pulse (0 3.3 0 0.1n 0.1n 2.2n 4.4n)
vin3 b 0 pwl (0n 	0		0.2n 	0	'0.2n+slopeTec'	3.3	4.2n 	3.3	'4.2n+slopeTec'	0)
vin4 a 0 pwl (0n 	3.3	0.2n  3.3)
* ------------------------------ *
* Circuit Description
X1 a b out GND_ vcc nand

* ------------------------------ *
* capacitor
* Cname  n+ n- value
C1 out 0 17fF

* ------------------------------ *
* monte carlo simulation
* .param parameter=agauss(nominal_val, abs_variation, sigma [, multiplier])
.param vtoN=agauss(0, 0.1*6.593e-01, 1) 
.param vtoP=agauss(0, 0.1*-8.95e-01, 1)

* .tran step total SWEEP MONTE=n (n = n repeated simulations)
.tran 0.001n 20n sweep monte=1500

* ------------------------------ *
* measures:
* measure propagation delay
*.measure tran apLH
*+ trig v(a)   val='supply/2' fall=1
*+ targ v(out) val='supply/2' rise=1
*
*.measure tran apHL
*+ trig v(a)   val='supply/2' rise=1
*+ targ v(out) val='supply/2' fall=1

.measure tran bpLH
+ trig v(b)   val='supply/2' fall=1
+ targ v(out) val='supply/2' rise=1

.measure tran bpHL
+ trig v(b)   val='supply/2' rise=1
+ targ v(out) val='supply/2' fall=1


* measure rise/fall time
.measure tran trise		* rise time
+ trig v(out) val='0.2*supply' rise=1
+ targ v(out) val='0.8*supply' rise=1

.measure tran tfall		* fall time
+ trig v(out) val='0.8*supply' fall=1 * 60% é o que mede multiplca para ter os 100%
+ targ v(out) val='0.2*supply' fall=1

* ------------------------------ *
* power
*.print power(vcc)
*.measure tran ipower integral power from=0 to=20n 	* average power

.measure tran consumoCaso1_LH integ 'p(vcc)*(3.5)' from='3.5N' to='7N'
.measure tran consumoCaso1_HL integ 'p(vcc)*(3.5)' from='0' to='3.5N'

* ------------------------------ *
* plot outputs
.print tran a b out
.print v(a) v(b) v(out)

.end