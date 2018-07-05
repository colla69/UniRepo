
let r1 = eintragPunkte "Martin" 8 (eintragPunkte "Steffen" 4 leer) 
let r2 = eintragAbschreiber "Martin" (eintragPunkte "Steffen" 6 r1)
let r3 = eintragPunkte "Martin" 12 (eintragPunkte "Steffen" 2 r2)
