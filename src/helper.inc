ROUTINE helper [Type=INC]
#define openFile set fs=##class(%Stream.FileCharacter).%New() ##continue
  set year="20"_$p($p($zname,"Advent",2),"."),day=$zcvt($p($zname,".",2),"l") ##continue
  set sc=fs.LinkToFile("/opt/advent/input/"_year_"/"_day_".txt")

#define inputAll(%input) $$$openFile ##continue
  set %input = fs.Read(fs.Size) ##continue
  set %input = $lfs($tr(%input,$c(13)),$c(10))

#define input(%lines) $$$openFile ##continue
  while 'fs.AtEnd { set %lines($i(%lines)) = fs.ReadLine() }

#define nextLine(%lines, %line) $d(%lines($i(index)), %line)

#def1arg max(%args) $$max^helper(%args)
#def1arg min(%args) $$min^helper(%args)
#def1arg sum(%args) $$sum^helper(%args)
#def1arg sort(%args) $$sort^helper(%args)
#def1arg toHex(%args) $$toHex^helper(%args)

