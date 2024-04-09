.data

powitanie:	.asciiz "\nDzien dobry, witam w programie sortujacym tablice liczb podawanych z klawiatury oraz zwracajacym roznice ich skrajnych elementow."
ilosc_liczb:	.asciiz "\nPodaj ilosc liczb, ktore chcesz posortowac i otrzymac roznice ich skrajnych elementow (maksymalnie 256 elementow): "
out_str:	.asciiz "\nPodaj elementy tablicy (oddzielone znakiem Enter):"
roznica1:	.asciiz "\nRoznica liczb "
roznica2:	.asciiz " oraz "
roznica3:	.asciiz " wynosi: "
tob_str:	.asciiz	"T["
tcb_str:	.asciiz	"] = "
nwl_str:	.asciiz	"\n"
res_str:	.asciiz	"Posortowana rosnaco tablica:\n"
tablica1:	.asciiz "T = ("
przecinek:	.asciiz ", "
tablica2:	.asciiz ")" 
najw_liczba:	.word 0
najm_liczba:	.word 0

.align 2
tablica:	.space 1024	# 256 int - 1024 bajtow

.text

main:

li $v0, 4
la $a0, powitanie
syscall		

li $v0, 4
la $a0, ilosc_liczb
syscall
li $v0, 5
syscall

la $t9, ($v0)
mulo $t9, $t9, 4

li $v0, 4
la $a0, out_str
syscall
li $v0, 4
la $a0, nwl_str
syscall


li $t0, 0		# $t0 = 0
li $t1, 0		# $t1 = 0
la $t2, ($t9)		# $t2 = ilosc liczb * 4

petla_input:
	li $v0, 4		# $v0 = 4
	la $a0, tob_str		# $a0 = tob_str address
	syscall			# syscall $v0 = 4 - print string $a0
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 4		# $v0 = 4
	la $a0, tcb_str		# $a0 = tcb_str address
	syscall			# syscall $v0 = 4 - print string $a0

	li $v0, 5		# $v0 = 5
	syscall			# syscall $v0 = 5 - read int
	
	move $t3, $v0
	sw $t3, tablica($t0)	#array t3 = v0
	
	addi $t0, $t0, 4  #przeniesienie do nastepnego adresu -> t0 + 4
	addi $t1, $t1, 1
	
	blt $t0, $t2, petla_input
	
	
	
li $t0, 0	#indeks pierwsza liczba
li $t1, 4	#indeks druga liczba
la $t2, ($t9)	#licznik
li $t3, 0	#pierwsza liczba w kolejnosci
li $t4, 0	#druga liczba w kolejnosci
li $t5, 0	#przechowuje wartosc najmniejszej liczby z listy
li $t6, 0	#indeks (bajt) najmniejszej liczby w tablicy
li $t7, 0	#znacznik glownej petli
li $t8, 0	#przechowuje wartoœæ z tablica[$t0]

#Sortowanie

sortowanie_main:
lw $t5, tablica($t0)
lw $t8, tablica($t0)
la $t6, ($t7)	#glowilem sie 2 godziny nad tym jednym elementem który zabezpiecza przed wczeœniejszym posortowaniem, a przez to nie wejsciem do funkcji "wpisz:". Na dzisiaj koniec myœlenia...
najmniejsza:
	lw $t3, tablica($t0)	#wpisujemy pierwsza liczbê do rejestru
	lw $t4, tablica($t1)	#wpisujemy drug¹ liczbê do rejestru
	blt $t4, $t3, wpisz	#porownujemy wartosci w rejestrach odpowiadajacych liczbom w tablicy odwolujac sie do funkcji "wpisz"
powrot:
	addi $t0, $t0, 4
	addi $t1, $t0, 4
	blt $t1, $t2, najmniejsza
	beq $t0, $t2, pomin_podmiana	# program dla ilosci liczb roznej od 10 (a bardziej ilosci bajtow im odpowiadajacej), przenosi ostatnia liczbe na adres ktory znajduje sie za nia, co powoduje wypisanie 0 na ostatnim miejscu tablicy
podmiana:
	sw $t5, tablica($t7)
	sw $t8, tablica($t6)
pomin_podmiana:


addi $t0, $t7, 4
addi $t1, $t0, 4		
addi $t7, $t7, 4
blt $t7, $t2, sortowanie_main

#wynik
li $t0, 0
la $t1, ($t9)
li $v0, 4
la $a0, res_str
syscall

lw $t8, tablica($t0)
sw $t8, najm_liczba

poczatek:
	li $v0, 4
	la $a0, tablica1 
	syscall
petla_wypisz_array:
	
	li $v0, 1
	lw $a0, tablica($t0)
	syscall
	
	addi $t0, $t0, 4
	beq $t0, $t1, koniec
	
	li $v0, 4
	la $a0, przecinek
	syscall
	
	
	blt $t0, $t1, petla_wypisz_array

koniec:
	li $v0, 4
	la $a0, tablica2
	syscall

addi $t0, $t0, -4
lw $t9, tablica($t0)
sw $t9, najm_liczba

subu $t1, $t8, $t9 #wynik odejmowania

li $v0, 4
la $a0, roznica1
syscall
li $v0, 1
la $a0, ($t8)
syscall
li $v0, 4
la $a0, roznica2
syscall
li $v0, 1
la $a0, ($t9)
syscall
li $v0, 4
la $a0, roznica3
syscall
li $v0, 1
la $a0, ($t1)
syscall

li $v0, 10
syscall	

#funkcje	
wpisz:
	blt $t5, $t4, powrot	#porownanie czy nowa znaleziona liczba jest mniejsza niz aktualna najmniejsza
	la $t5, ($t4)		#zapisanie najmniejszej liczby
	la $t6, ($t1)		#wpisanie indeksu (bajtu na którym siê znajduje w tablicy) liczby najmniejszej do rejsetru
	j powrot
	

	
