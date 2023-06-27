#include "uart_regs.h"
#include "uart_init.s"
#include "print_macro.s"
#include "print_init.s"


.align 8



.global main
main: //Instructions are described with 'C language'

	UART_init
	PRINT_init

	PRINT_macro				//PRINT_macro #1
	ldr r1, =Input_data @r1�� Input_data�� ù word�� �ּҸ� ����
	ldr r2, =Output_data @r2�� Output_data�� ù word�� �ּҸ� ����
	PRINT_macro				//PRINT_macro #2
	mov r3, #0 @r3�� outer_counter-> 0���� �ʱ�ȭ
	outerLoop:
		mov r4, #0 @r4�� ��Ƚ�� inner_counter -> 0���� �ʱ�ȭ
		mov r0, r1 @r0�� Input_data�� ù word�� �ּ� ����
		add r5, r0, #4 @r5�� ù word�� ���� word �ּ� ���� (�ϳ��� word�� 4byte�̹Ƿ� +4�� �Ѵ�)
		PRINT_macro				//PRINT_macro #3
	innerLoop: @�ϳ��� path������ �� �ݺ���
		ldr r8, [r0] @r8�� r0�� ����� �ּ��� �� ����
		ldr r7, [r5] @r7�� r5�� ����� �ּ��� �� ����
		cmp r8, r7 @r8�� ���� r7�� ���� ��
		PRINT_macro				//PRINT_macro #4
		strge r8, [r5] @r8�� ���� �� ũ�ٸ�, r8�� ���� r5�� ����� �ּҷ� ����
		strge r7, [r0] @r8�� ���� �� ũ�ٸ�, r7�� ���� r0�� ����� �ּҷ� ����
						@�ᱹ r8�� r7�� ���� �ٲ� -> swap
		PRINT_macro				//PRINT_macro #10
		add r0, #4 @r0�� ���� word�� �ּ� ����
		add r5, #4 @r5�� ���� word�� �ּ� ����
		add r4, #1 @inner_count++
		cmp r4, #31 @r4(�� ī����)�� 31���� Ȯ��
		blne innerLoop @r4(�� ī����)�� 31�� �ƴ϶�� �ٽ� innerLoop����
		PRINT_macro				//PRINT_macro #5
	add r3, #1 @r4(�� ī����)�� 31�̶��, outer_count++
	cmp r3, #32 @r3(ī����)�� 32���� Ȯ��
	blne outerLoop @r3(ī����)�� 32�� �ƴ϶��, �ٽ� outerLoop ����

mov r4, #0 @r3(ī����)�� 32��� r4(inner_count)�� 0���� �ʱ�ȭ-> �Ʒ� copyLoop���� ����ϴ� counter
PRINT_macro				//PRINT_macro #6
copyLoop:
	mov r0, r1 @r0��  Input_data�� ù word�� �ּҸ� ����
	mov r5, r2 @r5�� Output_data�� ù word�� �ּҸ� ����
	PRINT_macro				//PRINT_macro #7
	ldr r8, [r1], #4 @r8�� r1�� ����Ű�� �ּ��� ���� �����ϰ� r1�� ����� �ּҿ� +4
	str r8, [r2], #4 @r2�� r8�� ����� ���� �����ϰ� r2�� ����� �ּҿ� +4
	PRINT_macro				//PRINT_macro #8
	add r4, #1 @counter++
	cmp r4, #32 @counter�� 32���� Ȯ��
	blne copyLoop @�ƴ϶�� �ٽ� copyLoop����
	PRINT_macro				//PRINT_macro #9

bl csd_main @32��� csd_main���� �̵�


.data
.align 4 @4byte������ ����
Input_data:
	.word 2, 0, -7, -1, 3, 8, -4, 10
	.word -9, -16, 15, 13, 1, 4, -3, 14
	.word -8, -10, -15, 6, -13, -5, 9, 12
	.word -11, -14, -6, 11, 5, 7, -2, -12
Output_data:
	.word 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0



//Normal Interrupt Service Routine