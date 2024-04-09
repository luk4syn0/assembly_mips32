.data

podaj_ilosc:	.asciiz "\nWitaj, podaj dlugosc ciagu Fibonacciego (int): "
wynik:		.asciiz "\nCiag prezentuje sie nastepujaco:\n"
przecinek:	.asciiz ", "
.align 2
array:	.space 2048 #(512 liczb - 2048 bajtow)

.text

li $v0, 4
la $a0, podaj_ilosc
syscall
li $v0, 5
syscall
la $t1, ($v0) #t1 dlugosc ciagu

#Podstawowe wyrazy ciagu
li $t2, 0
li $t3, 0
sw $t2, array($t3)

li $t2, 1
li $t3, 4
sw $t2, array($t3)

#Algorytm ciagu

li $t3, 0 #pierwszy indeks ciagu
li $t4, 3 #licznik petli 
li $t5, 4 #drugi indeks ciagu
fibonacci:
	lw $t6, array($t3)
	lw $t7, array($t5)
	addu $t8, $t6, $t7
	
	addu $t5, $t5, 4
	
	sw $t8, array($t5)
	
	addi $t3, $t3, 4
	addi $t5, $t3, 4
	addi $t4, $t4, 1
	ble $t4, $t1, fibonacci

li $t2, 0
li $t3, 1
addi $t5, $t1, -1

la $a0, wynik
li $v0, 4
syscall

wypisz_fib:
	lw $t4, array($t2)
	la $a0, ($t4)
	li $v0, 1
	syscall
	
	la $a0, przecinek
	li $v0, 4
	syscall

	addi $t2, ,$t2, 4
	addi $t3, $t3, 1
	addi $t5, $t5, 1
	ble $t3, $t1, wypisz_fib



li $v0, 10
syscall
