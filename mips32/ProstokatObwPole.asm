.data

start_txt:	.asciiz "\nWitaj, podaj dlugosc bokow prostokata (w cm, dozwolona wartosc float)."
bok1_txt:	.asciiz "\nPodaj bok a: "
bok2_txt:	.asciiz "\nPodaj bok b: "
pole_txt:	.asciiz "\nPole prostok¹ta wynosi: "
obwod_txt:	.asciiz "\nObwod prostokata wynosi: "
obraz_txt:	.asciiz "\nProstokat wyglada nastepujaco (* oznacza 1 cm):\n"
bok:		.asciiz "*"
puste:		.asciiz " "

.text

li $v0, 4
la $a0, start_txt
syscall
la $a0, bok1_txt
syscall
li $v0, 7 #zapis do $f0
syscall
mov.d $f2, $f0 #f2 bok a
li $v0, 4
la $a0, bok2_txt
syscall
li $v0, 7 #zapis do $f0
syscall
mov.d $f4,$f0 #f4 bok b

mul.d $f6, $f2, $f4 #pole
add.d $f8, $f2, $f2 
add.d $f10, $f4, $f4
add.d $f14, $f8, $f10 #obwod

li $v0, 4
la $a0, pole_txt
syscall
li $v0, 3
mov.d $f12,$f6
syscall

li $v0, 4
la $a0, obwod_txt
syscall
li $v0, 3
mov.d $f12,$f14
syscall



# Obraz (trzeba przekonwertowac dlugosc zmiennoprzecinkow¹ na calkowita, wiec obraz bedzie jedynie przyblizona wielkoscia, zaokraglona do wartosci calkowitej)

#li $t8, 0 #licznik boku x(a)
#li $t9, 0 #licznik boku y(b)


#for:
#	la $a0, bok
#	li $v0, 4
#	syscall
#	addi $t8, $t8, 1
#	ble $t8, $

li $v0, 10
syscall
