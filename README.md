# Conway's Game of Life x86 AT&T

Acest repository implementează Jocul Vieții al lui Conway și un sistem de criptare simetrică bazat pe evoluția acestuia, scris în Assembly x86, folosind sintaxa AT&T.

## Descriere

Jocul Vieții al lui Conway este un joc zero-player inventat de matematicianul John Horton Conway în 1970. Simulează evoluția unei grile bidimensionale de celule pe baza unor reguli simple:

-    Subpopulare: O celulă vie cu mai puțin de 2 vecini vii moare.
-    Supraviețuire: O celulă vie cu 2 sau 3 vecini vii supraviețuiește.
-    Suprapopulare: O celulă vie cu mai mult de 3 vecini vii moare.
-    Reproducere: O celulă moartă cu exact 3 vecini vii devine vie.
-    Continuitatea celulelor moarte: Orice altă celulă moartă rămâne moartă.

Acest proiect implementează și un sistem de criptare simetrică, utilizând evoluția jocului ca și cheie.

## Funcționalități

### 1. Simularea Jocului 

Citirea stării inițiale a matricei (m x n) și numărul de evoluții k.
Aplicarea regulilor de evoluție pentru a calcula matricea finală Sk.
Outputul constă în matricea rezultată după k evoluții.

### 2. Criptare și Decriptare

 #### Criptare:
Creează o cheie de criptare pe baza unei configurări inițiale și a unui număr k de evoluții.
XOR între cheia generată și un mesaj pentru a produce textul criptat.
#### Decriptare:
 Utilizează cheia generată pentru a recupera mesajul original prin XOR.

### 3. Input și Output prin Fisiere

Citirea configurației inițiale dintr-un fișier in.txt.
Scrierea rezultatului evoluției într-un fișier out.txt.
