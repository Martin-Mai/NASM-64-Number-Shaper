%include "simple_io.inc"
global asm_main
extern rperm

;;Some of codes are referenced from the example that professor showed in the lecture

SECTION .data
	array: dq 1,2,3,4,5,6,7,8
	prompt1: db "enter a,b to swap",10,0
	prompt2: db "0 to terminate: ",0
	a1: db "first coordinate not 1..8",10,0
	a2: db "no comma found",10,0
	a3: db "second coordinate not 1..8",10,0
	fi: dq 0		;;first index
	ni: dq 0		;;next index

	;;The first lines representation
	f8:db "  +------+",0
	f7:db "  +-----+ ",0
	f6:db "   +----+ ",0
	f5:db "   +---+  ",0
	f4:db "    +--+  ",0
	f3:db "    +-+   ",0
	f2:db "     ++   ",0
        firarr: dq f8,f7,f6,f5,f4,f3,f2
	;;There is no f1 because f1 is shown as the last line

	

	;;The lines between them representation
	b8: db "  +      +",0
	b7: db "  +     + ",0
        b6: db "   +    + ",0
	b5: db "   +   +  ",0
	b4: db "    +  +  ",0
	b3: db "    + +   ",0
	b2: db "     ++   ",0
	betarr: dq b8, b7, b6, b5, b4, b3, b2



	;;The last lines representation
	l8: db "..+------+",0
	l7: db "..+-----+.",0
	l6: db "...+----+.",0
	l5: db "...+---+..",0
	l4: db "....+--+..",0
	l3: db "....+-+...",0
	l2: db ".....++...",0
	l1: db ".....+....",0
	lasarr: dq l8,l7,l6,l5,l4,l3,l2,l1

	
	;;The spacing constant
	sp1: db "     ",0
 	sp2: db "         ",0
	sp3: db "          ",0

SECTION .text
;;Display theorem is based on the idea of python code example

display:
	enter 0,0
	saveregs
	mov qword [fi], 0
;loop for the position of the row
	;first index must be mov outside of the loop otherwise it would be run a infinite loop
LR:
	call print_nl
	cmp qword [fi], 8
	je display_Franek

	mov qword [ni], 0
	inc qword [fi]
	jmp LA

;;loop for the num of the array
LA:
	cmp qword [ni], 8
	je LR
	inc qword [ni]
	jmp Mom
;;Mom located the position of the index


Mom:	
	;;Mom is like a parent loop
	mov r15,[ni]
	dec r15
	mov rbx, 0
	imul rbx,r15,8
	mov rcx, 8
	sub rcx,[fi]
	inc rcx
	mov rdx, [array+rbx]
	mov r15,8
	sub r15, rdx
	imul r15,r15,8

;;Professor said we need to have four loops
;;one is the the uppest line
;;second is the line between the uppest and the lowest
;;third is the lowest line
;;empty space between each others 
	cmp rdx,rcx
	jb Empty
	cmp rcx, 1
	je Last
	cmp rdx,rcx
	je First

	jmp Between
Empty:
	mov rax,sp3
	call print_string
	jmp LA

First:
	mov r9, [firarr+r15]
	mov rax, r9
	call print_string
	jmp LA		

Between:
	mov r9, [betarr+r15]
	mov rax, r9
	call print_string
	jmp LA

Last:
	mov r11, [lasarr+r15]
	mov rax, r11
	call print_string
	jmp LA



;;the display_Franek part is the displaying frame shown by the professor

;;As what we mention the sp1, sp2 is 
;;the bottom numbers, the first one is a single char after 5 spaces
;;so thats why
;;after 5spaces characters, there will be like 9 spaces between 2character
;;the comma is not necessary to be added
;;I left it as a position reminder
display_Franek:
	;;space from the begin to the first number
	mov rax, sp1
    	call print_string
   	mov rax,[array]
	call print_int
	;;mov     al, ','
    	;;call    print_char
	
	;;space from the begin to the second number
    	mov rax, sp2
    	call print_string
    	mov rax, [array+8] 
    	call print_int
	;;mov     al, ','
    	;;call    print_char

	;;space from the begin to the third number
    	mov rax, sp2
    	call print_string
    	mov rax, [array+16]
    	call print_int
	;;mov     al, ','
    	;;call    print_char
 
	;;space from the begin to the fourth number
    	mov rax, sp2
    	call print_string
    	mov rax, [array+24]
    	call print_int
	;;mov     al, ','
    	;;call    print_char

	;;space from the begin to the fifth number
    	mov rax, sp2
    	call print_string
    	mov rax, [array+32]
    	call print_int
	;;mov     al, ','
    	;;call    print_char

	;;space from the begin to the sixth number
    	mov rax, sp2
    	call print_string
    	mov rax, [array+40]
    	call print_int
	;;mov     al, ','
    	;;call    print_char

	;;space from the begin to the seventh number
    	mov rax, sp2
    	call print_string
    	mov rax, [array+48]
    	call print_int
	;;mov     al, ','
    	;;call    print_char

	;;space from the begin to the eighth number
    	mov rax, sp2
    	call print_string
    	mov rax, [array+56]
    	call print_int
	call print_nl
	;;mov     al, ','
    	;;call    print_char
    	

restoregs
leave
ret		


;The asm_main has been shown on the lecture

asm_main:
	enter 0,0
	saveregs
	call display
	
	mov rdi, array	;;Array location
	mov rsi, 8	;;Array length

	call rperm
	call display

prompt:
		mov     rax, prompt1
		call    print_string
		mov     rax, prompt2
		call    print_string


read:
		call    read_char
		cmp     al, '0'
		je      asm_main_end
		cmp     al, '1'
		jb      error1
		cmp     al, '8'
		ja      error1

		mov     r12, 0
		mov     r12b, al
		sub     r12b, '0'

		call    read_char
		cmp     al, ','
		jne     error2

		call    read_char
		;;
		cmp     al, '0'
    		je      asm_main_end
		cmp     al, '1'
		jb      error3
		cmp     al, '8'
		ja      error3

		mov     r13, 0
		mov     r13b, al
		sub     r13b, '0'

		mov     r14, array
LOOP1:
      		cmp     [r14], r12
      		je      LOOP2
      		add     r14, 8
      		jmp     LOOP1

LOOP2:
      		mov     r15, array

LOOP3:
      		cmp     [r15], r13
      		je      LOOP4
      		add     r15, 8
      		jmp     LOOP3

LOOP4:
      		mov     [r14], r13
      		mov     [r15], r12
      		call    display
      		jmp     L1
error1:
		call    print_nl
		mov     rax, a1
		call    print_string
		;;empty input buffer
    		jmp L1
error2:
		call    print_nl
		mov     rax, a2
		call    print_string
		;;empty input buffer
		jmp     L1

error3:
		call    print_nl
		mov     rax, a3
		call    print_string
		;;empty input buffer
		jmp     L1
	
L1:
		cmp     al, 10
      		je      L2
      		call    read_char
      		jmp     L1
L2:
      		jmp     prompt

asm_main_end:
restoregs
leave
ret







