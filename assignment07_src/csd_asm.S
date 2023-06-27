// 2nd level page table

.global main
main:
    // ���� �ּ� 0x20_0000�� �������Ϳ� �ε�
    ldr r0, =csd_MMUTable1
    // �������� r0�� �ִ� ���� �ּҸ� ���� �ּҷ� ��ȯ
    ldr r0, [r0]
    // ���� �ּҸ� �������� r1�� ����
    mov r1, r0

    // ���� ����� ������ ���� �ʱ�ȭ
    mov r2, #0

    // 0x20_0000 ~ 0x20_2FFF�� �������� ���ϴ� ����
    ldr r3, =0x202FFF
insert_loop:
	mov r5, #0x1
	str r5, [r1]
	add r1, r1, #4
	cmp r1, r3
	ble insert_loop

	mov r1, r0
sum_loop:
    // �������� r0�� �ִ� ���� �ּҿ� �ش��ϴ� �������� ����
    ldr r4, [r1]
    add r2, r2, r4

    // ���� �ּҷ� �̵�
    add r1, r1, #4
    cmp r1, r3
    ble sum_loop

    // ��� ���
    mov r6, r2
forever:
	b forever