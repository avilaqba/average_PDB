for {set b 1} {$b <= 20} {incr b 5} {
set firstdcd $b
set lastdcd [expr $b+5]
set dcdincr 1
set firstframe 0
set lastframe -1 
set frameskip 25
set prefix production

mol load pdb step3_pbcsetup.pdb

set sel0 [atomselect top "protein and backbone "]
set sel1 [atomselect top "protein and backbone " ]
set sel1all [ atomselect top "all"]


for { set i $firstdcd } { $i <= $lastdcd } { incr i $dcdincr } {

mol addfile ${prefix}_${i}.dcd first $firstframe last $lastframe step $frameskip waitfor all

}
set n [molinfo top get numframes]

for {set f 0} {$f < $n} {incr f 1} {
	
	$sel1 frame $f
	$sel1all frame $f
	set M [measure fit $sel1 $sel0 ]
	$sel1all move $M
}
set pos [measure avpos $sel0]
$sel0 set {x y z} $pos 
$sel0 writepdb aavpos_${b}.pdb
animate delete all
}

