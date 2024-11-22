.data
pointerin: .space 4
pointerout: .space 4
ind: .space 4
a: .space 1600
nou: .space 1600
aux: .space 1600
m: .space 4
n: .space 4
n1: .space 4         #pt afisare
p: .space 4
i: .space 4
j: .space 4
nw: .space 4
north: .space 4
ne: .space 4
w: .space 4
e: .space 4
sw: .space 4
s: .space 4
se: .space 4
left: .space 4
right: .space 4
k: .space 4
x: .long 0          #generatia curenta
columnIndex: .space 4
lineIndex: .space 4
sp: .space 4
maxed: .long 20
c: .long 0    #citirea curenta
formatprintf: .asciz "%ld "
formatscanf: .asciz "%ld"
newline: .asciz "\n"
read: .asciz "r"
write: .asciz "w"
input: .asciz "in.txt"
output: .asciz "out.txt"
.text

.global main
main:

push $read
push $input
call fopen
add $8, %esp
mov %eax, pointerin
movl $0, ind
pushl $m
pushl $formatscanf
push pointerin
call fscanf
pop %ebx
pop %ebx
pop %ebx
pushl $n
pushl $formatscanf
push pointerin
call fscanf
pop %ebx
pop %ebx
pop %ebx
pushl $p
pushl $formatscanf
push pointerin
call fscanf
pop %ebx
pop %ebx
pop %ebx
incl m
incl m
incl n
incl n
xor %ebx, %ebx
movl %ebx, ind
movl m, %eax
mull n  
movl %eax, %ecx     
citire:
	cmp ind, %ecx
	je readk
	incl c
	movl c, %eax
	cmp %eax, p
	jl readk       #daca am terminat citirile, trec mai departe
	pusha
	pushl $i
	pushl $formatscanf   #citire i
	push pointerin
	call fscanf
	pop %ebx
	pop %ebx
	pop %ebx
	popa
	pusha
	pushl $j
	pushl $formatscanf
	push pointerin
	call fscanf             #citire j
	pop %ebx
	pop %ebx
	pop %ebx
	popa
	movl n, %eax
	incl i
	mull i
	add j, %eax
	add $1, %eax
	lea a, %esi            #dupa citire, pozitia pe care vreau sa pun e (i+1)m+j+1
	movl $1, (%esi, %eax, 4)
	lea nou, %edi
	movl $1, (%edi, %eax, 4)
	jmp go_next
go_next:
	incl ind
	jmp citire
readk:
	pushl $k
	pushl $formatscanf
	push pointerin
	call fscanf
	pop %ebx
	pop %ebx
	pop %ebx
	movl $0, x
	movl $0, i
	movl $0, j
setmax:
movl $0, ind
movl ind, %ebx
xor %edx, %edx
movl m, %eax
mull n  
movl %eax, %ecx     #pozitia maxima va fi in ecx
prelucrare:
	incl x
	movl $0, ind
	movl k, %ebx
	cmp x, %ebx
	jl afis
nextgen:                                                     #mereu suma partiala este 1, trebuie vazut de ce folosind gdb (mai ales a doua iteratie)
#indicele de la primul element de pe linie nu e bun
	xor %eax, %eax        #pentru copiere->indexul copierii
	cmp ind, %ecx
	je copy         #iese din prelucrare
	movl $0, sp    #reset la suma vecinilor
	#verificare border si copiere in matricea noua next up->
	movl m, %ebx
	cmp ind, %ebx
	jg zero          #pune 0 in matricea noua daca elementul e pe prima linie
	xor %edx, %edx
	movl ind, %eax
	div n
	xor %ebx, %ebx
	cmp %edx, %ebx
	je zero  	 #pune 0 daca elem e pe prima coloana
	movl n, %ebx
	decl %ebx
	cmp %edx, %ebx
	je zero          # pune 0 daca elem e pe ultima coloana
	movl %ecx, %edx
	sub n, %edx
	cmp ind, %edx
	jl zero		#pune 0 daca elem e pe ultima linie
	movl ind, %edx
	sub n, %edx
	sub $1, %edx
	movl %edx, nw   #NW
	movl nw, %ebx
	lea a, %esi
	movl (%esi, %ebx, 4), %eax
	add %eax, sp   #adaug NW la suma vecinilor
	movl ind, %edx
	sub n, %edx
	movl %edx, north   #N
	movl north, %ebx
	movl (%esi, %ebx, 4), %eax
	add %eax, sp  #adaug N la suma vecinilor
	movl ind, %edx
	add $1, %edx
	sub n, %edx
	movl %edx, ne   #NE
	movl ne, %ebx
	movl (%esi, %ebx, 4), %eax
	add %eax, sp  #adaug NE la suma vecinilor
	movl ind, %edx
	sub $1, %edx
	movl %edx, w   #W
	movl w, %ebx
	movl (%esi, %ebx, 4), %eax
	add %eax, sp   #adaug W la suma vecinilor
	movl ind, %edx
	add $1, %edx
	movl %edx, e   #E
	movl e, %ebx
	movl (%esi, %ebx, 4), %eax
	add %eax, sp   #adaug E la suma vecinilor
	movl ind, %edx
	sub $1, %edx
	add n, %edx
	movl %edx, sw  #SW
	movl sw, %ebx
	movl (%esi, %ebx, 4), %eax
	add %eax, sp   #adaug SW la suma vecinilor
	movl ind, %edx
	add n, %edx
	movl %edx, s    #S
	movl s, %ebx
	movl (%esi, %ebx, 4), %eax
	add %eax, sp    #adaug S la suma vecinilor
	movl ind, %edx
	add n, %edx
	add $1, %edx
	movl %edx, se    #SE
	movl se, %ebx
	movl (%esi, %ebx, 4), %eax
	add %eax, sp    #adaug SE la suma vecinilor
reguli:
	xor %ebx, %ebx
	movl ind, %eax     #eax va tine indexul curent
	movl (%esi, %eax, 4), %eax   #eax va tine valoarea de pe pozitia ind adica 0 sau 1
	cmp %ebx, %eax
	jg subpopulare     #verific daca celula e in viata sau nu
	creare:
		add $3, %ebx
		cmp sp, %ebx
		je unu
	continuitate_celule_moarte:
		jmp zero
	subpopulare:
		add $2, %ebx
		cmp sp, %ebx
		jg zero
	continuitate_celule_vii:
		cmp sp, %ebx
		je unu
		add $1, %ebx
		cmp sp, %ebx
		je unu
	ultrapopulare:
		cmp sp, %ebx
		jl zero
stop:
	incl ind
	jmp nextgen
zero:
	movl ind, %eax
	lea nou, %edi
	movl $0, (%edi, %eax, 4)
	incl ind
	jmp nextgen
unu:
	movl ind, %eax
	lea nou, %edi
	movl $1, (%edi, %eax, 4)
	incl ind
	jmp nextgen
copy:
	cmp %eax, %ecx
	je prelucrare
	lea nou, %edi
	movl (%edi, %eax, 4), %edx
	lea a, %esi
	movl %edx, (%esi, %eax, 4)
	incl %eax
	jmp copy
afis:
movl $1, lineIndex
decl m
movl n, %edx
movl %edx, n1
sub $1, n1      #pentru afisarea fara border
push $write
push $output
call fopen
add $8, %esp
mov %eax, pointerout
for_lines:
	movl lineIndex, %ecx
	cmp %ecx, m
	je et_exit
	movl $1, columnIndex
		for_columns:
			movl columnIndex, %ecx
			cmp %ecx, n1
			je cont
			movl lineIndex, %eax
			movl $0, %edx
			mull n
			addl columnIndex, %eax
			lea nou, %edi
			movl (%edi, %eax, 4), %ebx
			pushl %ebx
			pushl $formatprintf
			push pointerout
			call fprintf
			pop %ebx
			pop %ebx
			pop %ebx
			pushl $0
			call fflush
			popl %ebx
			incl columnIndex
			jmp for_columns
	cont:
		push $newline
		push pointerout
		call fprintf
		pop %ebx
		pop %ebx
		push $0
		call fflush
		pop %ebx
		incl lineIndex
		jmp for_lines

et_exit:
pushl $0
call fflush
pop %ebx
movl $1, %eax
xorl %ebx, %ebx
int $0x80
