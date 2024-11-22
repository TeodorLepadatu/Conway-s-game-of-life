.data
ind: .space 4
a: .space 3200
nou: .space 3200
cript: .space 3200
decript: .space 3200
mesaj: .space 3200
msj: .space 3200      #in binar
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
formatprintf: .asciz "%ld"
formatscanf: .asciz "%ld"
newline: .asciz "\n"
sir: .space 80
bin: .long 2
count: .long 0
textscanf: .asciz "%s"
textprintf: .asciz "%s"
crypt: .space 4
lmax: .space 4
aux: .space 4
hexprint: .asciz "0x"
hexA: .asciz "A"
hexB: .asciz "B"
hexC: .asciz "C"
hexD: .asciz "D"
hexE: .asciz "E"
hexF: .asciz "F"
litera: .space 4
.text

.global main
main:
movl $0, ind
pushl $m
pushl $formatscanf
call scanf
stop1:
pop %ebx
pop %ebx
pushl $n
pushl $formatscanf
call scanf
stop2:
pop %ebx
pop %ebx
pushl $p
pushl $formatscanf
call scanf
stop3:
pop %ebx
pop %ebx
incl m
incl m
incl n
incl n
what:
xor %ebx, %ebx
movl %ebx, ind
movl m, %eax
mull n  
movl %eax, %ecx     #pozitia maxima va fi in ecx
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
	call scanf
	pop %ebx
	pop %ebx
	popa
	pusha
	pushl $j
	pushl $formatscanf
	call scanf             #citire j
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
	#pusha
	#pushl %eax
	#pushl $formatprintf
	#call printf
	#pop %ebx
	#pop %ebx
	#popa
	jmp go_next
go_next:
	incl ind
	jmp citire
readk:
	pushl $k
	pushl $formatscanf
	call scanf
	stop6:
	pop %ebx
	pop %ebx
	movl $0, x
	movl $0, i
	movl $0, j
#movl $4, %eax
#movl $1, %ebx
#movl $newline, %ecx
#movl $2, %edx
#int $0x80
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
	jl et_0x01
nextgen:                                                     
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

et_0x01:

movl %ecx, lmax         #lungimea maxima curenta a cheii (aka matricea)

pusha
push $crypt
push $formatscanf
call scanf
pop %ebx
pop %ebx
popa

xorl %ebx, %ebx
add $1, %ebx
cmp crypt, %ebx     #crypt or decrypt
je decriptare
criptare:
	pusha
	push $sir
	push $textscanf
	call scanf
	pop %ebx
	pop %ebx
	popa
	
	movl $0, %edi
	xorl %ecx, %ecx     #pozitia maxima in mesaj

	char:
		movl $0, count
		movl $8, %ebx
		xorl %eax, %eax
		movb sir(%edi), %al    #in %eax am caracterul
		testb %al, %al       #test pt \0
		jz prep_key
		
		to_binary:
			cmp count, %ebx
			je nextchar
			xorl %edx, %edx
			movl $2, bin        
			div bin
			pushl %edx       #pune pe stiva bitii
			incl count
			jmp to_binary
			
		nextchar:
			incl %edi
			pop %ebx
			lea mesaj, %esi
			movl %ebx, (%esi, %ecx, 4)           #pune in mesaj bitii
			incl %ecx
			pop %ebx
			lea mesaj, %esi
			movl %ebx, (%esi, %ecx, 4)
			incl %ecx
			pop %ebx
			lea mesaj, %esi
			movl %ebx, (%esi, %ecx, 4)
			incl %ecx
			pop %ebx
			lea mesaj, %esi
			movl %ebx, (%esi, %ecx, 4)
			incl %ecx
			pop %ebx
			lea mesaj, %esi
			movl %ebx, (%esi, %ecx, 4)
			incl %ecx
			pop %ebx
			lea mesaj, %esi
			movl %ebx, (%esi, %ecx, 4)
			incl %ecx
			pop %ebx
			lea mesaj, %esi
			movl %ebx, (%esi, %ecx, 4)
			incl %ecx
			pop %ebx
			lea mesaj, %esi
			movl %ebx, (%esi, %ecx, 4) 
			incl %ecx
			jmp char
	prep_key:
		cmp lmax, %ecx          #30<48 
		jg double
		movl %ecx, lmax
		xorl %edx, %edx
		jmp xorare
		
		double:                    
			movl lmax, %eax
			xorl %edx, %edx
			#folosesc ambele matrice pt a construi 
			#pun cheia in nou
			#prin a parcurg cu un index si adaug la nou index+%ecx
		adaug:
			cmp lmax, %edx
			je reset       
			lea a, %esi
			lea nou, %edi
			movl (%esi, %edx, 4), %ebx
			movl %ebx, (%edi, %eax, 4)       
			incl %eax	#creste lungimea la nou
			incl %edx       #creste pozitia de pe care iau element din a
			jmp adaug
		reset:
			xorl %edx, %edx
			movl %eax, lmax
			jmp prep_key
	xorare:
		cmp lmax, %edx
		je hexa
		lea mesaj, %esi
		lea nou, %edi
		movl (%esi, %edx, 4), %eax
		movl (%edi, %edx, 4), %ebx
		xorl %eax, %ebx
		lea cript, %edi
		movl %ebx, (%edi, %edx, 4)
		incl %edx
		jmp xorare
	hexa:
		movl $4, %eax
		movl $1, %ebx
		movl $hexprint, %ecx
		movl $3, %edx
		int $0x80
		#de la coada la cap in cript
		#pun pe stiva numerele din hexa (care va fi in %ebx)
		#pt lungimea mesajului iau ceil(lmax/4)
		movl lmax, %ecx
		decl %ecx
		
		caract_pe_stiva:
			movl $4, %edx
			xorl %ebx, %ebx
			movl $1, aux
			cmp %ecx, %edx
			jg less_than_4
			lea cript, %edi
			movl (%edi, %ecx, 4), %eax
			movl %eax, %ebx
			decl %ecx
			lea cript, %edi
			movl (%edi, %ecx, 4), %eax
			movl $2, aux
			xorl %edx, %edx
			mull aux
			add %eax, %ebx
			decl %ecx
			lea cript, %edi
			movl (%edi, %ecx, 4), %eax
			movl $4, aux
			xorl %edx, %edx
			mull aux
			add %eax, %ebx
			decl %ecx
			lea cript, %edi
			movl (%edi, %ecx, 4), %eax
			movl $8, aux
			xorl %edx, %edx
			mull aux
			add %eax, %ebx
			decl %ecx
			pushl %ebx
			jmp caract_pe_stiva
			less_than_4:
				xorl %edx, %edx
				cmp %ecx, %edx
				je lastpush
				lea cript, %edi
				movl (%edi, %ecx, 4), %eax
				xorl %edx, %edx
				mull aux
				add %eax, %ebx
				decl %ecx
				movl aux, %eax
				add aux, %eax
				movl %eax, aux
				jmp less_than_4
			lastpush:
				pushl %ebx
		movl lmax, %eax
		movl $4, %ebx
		xorl %edx, %edx
		div %ebx
		xorl %ecx, %ecx
		cmp %ecx, %edx
		je print
		add $1, %eax
		
		print:
			cmp %ecx, %eax
			je exit
			pop %ebx
			movl $9, %edx
			cmp %edx, %ebx
			jg printchar
			printint:
				pusha
				push %ebx
				push $formatprintf
				call printf
				pop %ebx
				pop %ebx
				popa
				pusha
				push $0
				call fflush
				pop %ebx
				popa
				incl %ecx
				jmp print
			printchar:
				incl %edx
				cmp %edx, %ebx
				je printa
				incl %edx
				cmp %edx, %ebx
				je printb
				incl %edx
				cmp %edx, %ebx
				je printc
				incl %edx
				cmp %edx, %ebx
				je printd
				incl %edx
				cmp %edx, %ebx
				je printe
				incl %edx
				cmp %edx, %ebx
				je printF
				
				printa:
					pusha
					push $hexA
					push $textprintf
					call printf
					pop %ebx
					pop %ebx
					popa
					pusha
					push $0
					call fflush
					pop %ebx
					popa
					incl %ecx
					jmp print
				printb:
					pusha
					push $hexB
					push $textprintf
					call printf
					pop %ebx
					pop %ebx
					popa
					pusha
					push $0
					call fflush
					pop %ebx
					popa
					incl %ecx
					jmp print
				printc:
					pusha
					push $hexC
					push $textprintf
					call printf
					pop %ebx
					pop %ebx
					popa
					pusha
					push $0
					call fflush
					pop %ebx
					popa
					incl %ecx
					jmp print
				printd:
					pusha
					push $hexD
					push $textprintf
					call printf
					pop %ebx
					pop %ebx
					popa
					pusha
					push $0
					call fflush
					pop %ebx
					popa
					incl %ecx
					jmp print
				printe:
					pusha
					push $hexE
					push $textprintf
					call printf
					pop %ebx
					pop %ebx
					popa
					pusha
					push $0
					call fflush
					pop %ebx
					popa
					incl %ecx
					jmp print
				printF:
					pusha
					push $hexF
					push $textprintf
					call printf
					pop %ebx
					pop %ebx
					popa
					pusha
					push $0
					call fflush
					pop %ebx
					popa
					incl %ecx
					jmp print
decriptare:
	pusha
	push $sir
	push $textscanf
	call scanf
	pop %ebx
	pop %ebx
	popa
	movl $2, %edi
	xorl %ecx, %ecx
	load:
		xorl %eax, %eax
		movb sir(%edi), %al
		testb %al, %al       #test pt \0
		jz prep_key_for_decrypt             
		
		movl $48, %ebx
		cmp %eax, %ebx
		je t0
		
		movl $49, %ebx
		cmp %eax, %ebx
		je t1
		
		movl $50, %ebx
		cmp %eax, %ebx
		je t2
		
		movl $51, %ebx
		cmp %eax, %ebx
		je t3
		
		movl $52, %ebx
		cmp %eax, %ebx
		je t4
		
		movl $53, %ebx
		cmp %eax, %ebx
		je t5
		
		movl $54, %ebx
		cmp %eax, %ebx
		je t6
		
		movl $55, %ebx
		cmp %eax, %ebx
		je t7
		
		movl $56, %ebx
		cmp %eax, %ebx
		je t8
		
		movl $57, %ebx
		cmp %eax, %ebx
		je t9
		
		movl $65, %ebx
		cmp %eax, %ebx
		je tA
		
		movl $66, %ebx
		cmp %eax, %ebx
		je tB
		
		movl $67, %ebx
		cmp %eax, %ebx
		je tC
		
		movl $68, %ebx
		cmp %eax, %ebx
		je tD
		
		movl $69, %ebx
		cmp %eax, %ebx
		je tE
		
		movl $70, %ebx
		cmp %eax, %ebx
		je tF
		
	t0:
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		incl %edi
		jmp load
	t1:
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		incl %edi
		jmp load
	t2:
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		incl %edi
		jmp load
	t3:
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		incl %edi
		jmp load
	t4:
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		incl %edi
		jmp load
	t5:
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		incl %edi
		jmp load
	t6:
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		incl %edi
		jmp load
	t7:
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		incl %edi
		jmp load
	t8:
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		incl %edi
		jmp load
	t9:
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		incl %edi
		jmp load
	tA:
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		incl %edi
		jmp load
	tB:
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		incl %edi
		jmp load
	tC:
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		incl %edi
		jmp load
	tD:
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		incl %edi
		jmp load
	tE:
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $0, (%esi, %ecx, 4)
		incl %ecx
		incl %edi
		jmp load
	tF:
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		lea decript, %esi
		movl $1, (%esi, %ecx, 4)
		incl %ecx
		incl %edi
		jmp load
	
	
	prep_key_for_decrypt:
		cmp lmax, %ecx          #30<48 
		jg doubled
		movl %ecx, lmax
		xorl %edx, %edx
		jmp xor_for_binary
		
		doubled:                    
			movl lmax, %eax
			xorl %edx, %edx
			#folosesc ambele matrice pt a construi 
			#pun cheia in nou
		adaugd:
			cmp lmax, %edx
			je resetd       
			lea a, %esi
			lea nou, %edi
			movl (%esi, %edx, 4), %ebx
			movl %ebx, (%edi, %eax, 4)       
			incl %eax	#creste lungimea la nou
			incl %edx       #creste pozitia de pe care iau element din a
			jmp adaugd
		resetd:
			xorl %edx, %edx
			movl %eax, lmax
			jmp prep_key_for_decrypt
			
			
	xor_for_binary:
		cmp lmax, %edx
		je create_mesaj
		lea decript, %esi
		lea nou, %edi
		movl (%esi, %edx, 4), %eax
		movl (%edi, %edx, 4), %ebx
		xorl %eax, %ebx
		lea msj, %edi
		movl %ebx, (%edi, %edx, 4)
		incl %edx
		jmp xor_for_binary
	
	create_mesaj:
		xorl %edx, %edx
		loop:                        #parcurge tot sirul de biti
			cmp %ecx, %edx
			je exit
			xorl %ebx, %ebx
			lea msj, %edi
			movl (%edi, %edx, 4), %eax
			shl $7, %eax
			add %eax, %ebx
			incl %edx
			lea msj, %edi
			movl (%edi, %edx, 4), %eax
			shl $6, %eax
			add %eax, %ebx
			incl %edx
			lea msj, %edi
			movl (%edi, %edx, 4), %eax
			shl $5, %eax
			add %eax, %ebx
			incl %edx
			lea msj, %edi
			movl (%edi, %edx, 4), %eax
			shl $4, %eax
			add %eax, %ebx
			incl %edx
			lea msj, %edi
			movl (%edi, %edx, 4), %eax
			shl $3, %eax
			add %eax, %ebx
			incl %edx
			lea msj, %edi
			movl (%edi, %edx, 4), %eax
			shl $2, %eax
			add %eax, %ebx
			incl %edx
			lea msj, %edi
			movl (%edi, %edx, 4), %eax
			shl $1, %eax
			add %eax, %ebx
			incl %edx
			lea msj, %edi
			movl (%edi, %edx, 4), %eax
			add %eax, %ebx
			incl %edx
			movl %ebx, litera
		afisare:
			pusha
			push $litera
			push $textprintf
			call printf
			pop %ebx
			pop %ebx
			popa
			pusha
			push $0
			call fflush
			pop %ebx
			popa
			jmp loop
exit:
movl $4, %eax
movl $1, %ebx
movl $newline, %ecx
movl $2, %edx
int $0x80
pushl $0
call fflush
pop %ebx
movl $1, %eax
xorl %ebx, %ebx
int $0x80
