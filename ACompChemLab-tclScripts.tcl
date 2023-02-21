###########################################################
## Copyright 2022 Atanu Acharya
## Thses scripts are developed by the ACompChemLab
## Research Lab of Dr. Atanu Acharya @ Syracuse University
## Contributor(s): Atanu Acharya
##  
##########################################################




##################################################
## Calculate number of atoms			##
## Usage: numatoms <molid> "<atom selection>"	##
## Default values:                      	##
## <molid> = top    <atom selection> = all	##
##################################################
proc numatoms {{mol top} {str "all"}} {
	set n_atoms [[atomselect $mol $str] num]
	return ${n_atoms}
} 
##################################################


##########################################################
## Create a dictionary of <atom name> <point charge>	##
## Usage: dictNameCharge <molid> "<atom selection>"	##
## Default values:                               	##
## <molid> = top    <atom selection> = all	        ##
## Dependancy: proc numatoms { }			##
##########################################################
proc dictNameCharge {{mol top} {str "all"}} {
	set n_atoms [numatoms $mol "$str"]
	set nameChdict [dict create]
	for {set i 0} {$i < $n_atoms} {incr i} {
        	set name [[atomselect $mol "index $i"] get name]
        	set charge [format "%.4f" [[atomselect $mol "index $i"] get charge]]
		dict append nameChdict $name $charge
	}
	unset charge
	unset name
	return ${nameChdict} 
} 
###########################################################


##########################################################
## Create a dictionary of <atom index> <point charge>	##
## Usage: dictIndexCharge <molid> "<atom selection>"	##
## Default values:                               	##
## <molid> = top    <atom selection> = all	        ##
## Dependancy: proc numatoms { }			##
##########################################################
proc dictIndexCharge {{mol top} {str "all"}} {
	set n_atoms [numatoms $mol "$str"]
	set indexChdict [dict create]
	for {set i 0} {$i < $n_atoms} {incr i} {
        	set charge [format "%.4f" [[atomselect $mol "index $i"] get charge]]
		dict append indexChdict $i $charge
	}
	unset charge 
	return ${indexChdict} 
} 
##########################################################

###################################################################
## Create a dictionary of <atom index> <Coordinate>              ##
## Usage: dictIndexCoor <molid> "<atom selection>"  <frame >     ##
## Default values:                                               ##
## <molid> = top    <atom selection> = all  <frame> = last       ##
## Dependancy: proc numatoms { }                                 ##
###################################################################
proc dictIndexCoor {{mol top} {str "all"} {frame last}} {
        set n_atoms [numatoms $mol "$str"]
        set indexCoordict [dict create]
        for {set i 0} {$i < $n_atoms} {incr i} {
                set coor [[atomselect $mol "index $i" frame $frame] get {x y z}]
                dict append indexCoordict $i $coor
        }
        unset coor
        return ${indexCoordict}
}
###################################################################

##########################################################################################
## Create a dictionary of all atom properties in the following format  			##
## <index> {name <name> charge <charge> xcoor <xcoor> ycoor <ycoor> zcoor <zcoor>}      ##
## Usage: parseAtoms <molid> "<atom selection>"  <frame >        			##
## Default values:                                               			##
## <molid> = top    <atom selection> = all  <frame> = last       			##
## Dependancy: proc numatoms { }                                 			##
##########################################################################################
proc parseAtoms {{mol top} {whichframe last} {str "all"}} {
        set n_atoms [numatoms $mol "$str"]
        set AllAtoms [dict create]
        for {set i 0} {$i < $n_atoms} {incr i} {
                dict set AllAtoms $i name [[atomselect $mol "index $i"] get name]
                dict set AllAtoms $i charge [format "%.4f" [[atomselect $mol "index $i"] get charge]]
                dict set AllAtoms $i xcoor [format "%.4f" [[atomselect $mol "index $i" frame $whichframe] get x ]]
                dict set AllAtoms $i ycoor [format "%.4f" [[atomselect $mol "index $i" frame $whichframe] get y ]]
                dict set AllAtoms $i zcoor [format "%.4f" [[atomselect $mol "index $i" frame $whichframe] get z ]]
        }
        return ${AllAtoms}
}
##########################################################################################







