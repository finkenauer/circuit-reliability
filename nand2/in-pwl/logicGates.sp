* Description of basic logic gates as subckts

* ------------------------------ *
* Voltage
* Vname n+ n- value
vgnd 	GND_ 0 
vcc 	vcc 0 dc 3.3


* subckt definition
* Mname d g s b tipo w l vtho

* ------------------------------ *
* inverter
.subckt inv in out vcc
M1 out in vcc  vcc   MODPM width=InvWp length='0.35u' 
M2 out in 0    0     MODNM width=InvWn length='0.35u' 
.ends inv

* ------------------------------ *
* nand2
.subckt nand a b out GND_ vcc
M1 out a vcc  	vcc   MODPM width=NandWp length='0.35u' delvto=vtoP
M2 out b vcc  	vcc   MODPM width=NandWp length='0.35u' delvto=vtoP

M3 out a n1 	GND_  MODNM width=NandWn length='0.35u' delvto=vtoN
M4 n1  b GND_ 	GND_  MODNM width=NandWn length='0.35u' delvto=vtoN
.ends nand

* ------------------------------ *
* nor2
.subckt nor a b out GND_ vcc
M1 out a n1  	vcc   MODPM width=NorWp length='0.35u'
M2 n1  b vcc  	vcc   MODPM width=NorWp length='0.35u'

M3 out a GND_ 	GND_  MODNM width=NorWn length='0.35u'
M4 out b GND_ 	GND_  MODNM width=NorWn length='0.35u'
.ends nor