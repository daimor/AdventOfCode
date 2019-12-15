ROUTINE helper [Type=INC]
#define openFile set fs=##class(%Stream.FileCharacter).%New() ##continue
  set year="20"_$p($p($zname,"Advent",2),"."),day=$zcvt($p($zname,".",2),"l") ##continue
  set sc=fs.LinkToFile("/opt/advent/input/"_year_"/"_day_".txt")

#define inputFull(%input) $$$openFile ##continue
  set %input = $zstrip(fs.Read(fs.Size), "<>WC") ##continue

#define inputAll(%input) $$$openFile ##continue
  set %input = fs.Read(fs.Size) ##continue
  set %input = $lfs($tr(%input,$c(13)),$c(10)),ptr=0

#define input(%lines) $$$openFile ##continue
  while 'fs.AtEnd { set %lines($i(%lines)) = fs.ReadLine() }

#define nextLine(%lines, %line) $d(%lines)&&(($lv(%lines)&&$listnext(%lines,ptr,%line))||($d(%lines($i(index)), %line)))

#def1arg max(%args) $$max^helper(%args)
#def1arg min(%args) $$min^helper(%args)
#def1arg sum(%args) $$sum^helper(%args)
#def1arg sort(%args) $$sort^helper(%args)
#def1arg toHex(%args) $$toHex^helper(%args)
#def1arg toBits(%args) $$toBits^helper(%args)
#def1arg knot(%args) $$knot^helper(%args)
#def1arg insert(%args) $$insert^helper(%args)

#def1arg and(%args) $$and^helper(%args)
#def1arg or(%args) $$or^helper(%args)
#def1arg xor(%args) $$xor^helper(%args)

#define lcm(%list) $$lcm^helper(%list)
#define ceil(%v) $$ceil^helper(%v)