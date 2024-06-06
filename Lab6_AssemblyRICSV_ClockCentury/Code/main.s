# Century Clock using RISC-V processor

.globl _start

# #######################################
# ########      ENTRY POINT     #########
# #######################################
.text

# Start of code (entry point). Must be put in the beginning
_start:
infinity_loop:
    call MAIN_Init
    call MAIN_Loop
    # Update clock element here
    # Remove the example code and write your code... 
    # ### example code begin
    # call MAIN_Init
    # call MAIN_Init
#     lb a0, g_clock_second
#     addi a0, a0, 1
#     li a1, 15
#     blt a0, a1, 1f
#     mv a0, zero
# 1:
#     la a1, g_clock_second
#     sb a0, 0(a1)
    # ### example code end


    # Display clock to terminal
    li a0, 38
    call TERMINAL_ClearLine
    call TERMINAL_DisplayDateTime
    li a0, 6
    call TERMINAL_FillBlank
    j infinity_loop


    # Exit program
    li a0, EXIT
    ecall

    la a0, STR_DATE
    call TERMINAL_PrintString

    li a0, -1234567
    call TERMINAL_PrintNumber

    li a0, '\n'
    call TERMINAL_PrintChar

    call TERMINAL_DisplayTime
    call TERMINAL_DisplayDate
    call TERMINAL_DisplayDateTime

    # Exit program
    li a0, EXIT
    ecall

    # Set pixel at (2, 4) with default color
    # li a0, 2
    # li a1, 4
    # lw a2, COLOR_DEFAULT
    # call LEDMATRIX_DisplayPixel

    # li a0, 0b11101011
    # li a1, 8
    # li a2, 1
    # li a3, 9
    # lw a4, COLOR_DEFAULT
    # call LEDMATRIX_DisplayRow

    # li a0, 5
    # li a1, 13
    # li a2, 1
    # lw a3, COLOR_DEFAULT
    # call LEDMATRIX_DisplayDigit

    # li a0, 7
    # li a1, 13
    # li a2, 12
    # lw a3, COLOR_DEFAULT
    # call LEDMATRIX_DisplayDigit

    # li a0, 123456789
    # li a1, 1
    # li a2, 1
    # li a3, 1
    # lw a4, COLOR_DEFAULT
    # call DISPLAY_DisplayNumber

    # lw a0, COLOR_SCREEN
    # call LEDMATRIX_SetScreen

    # call DISPLAY_DisplaySecond
    # call DISPLAY_DisplayMinute
    # call DISPLAY_DisplayHour
    # call DISPLAY_DisplayDay
    # call DISPLAY_DisplayMonth
    # call DISPLAY_DisplayYear

    # Exit program
    # li a0, EXIT
    # ecall



# #######################################
# ######        MAIN MODULE        ######
# #######################################
.text
# void MAIN_Init(void)
MAIN_Init:
    addi sp, sp, -4
    # Store callee-save registers on stack
    sw ra, 0(sp)

    # Initial global variables 
    lw t0, DEFAULT_SECOND      # load value into t0
    la t1, g_clock_second      # load address into t1
    sw t0, 0(t1)               # store t0 into t1

    lw t0, DEFAULT_MINUTE
    la t1, g_clock_minute
    sw t0, 0(t1)

    lw t0, DEFAULT_HOUR
    la t1, g_clock_hour
    sw t0, 0(t1)

    lw t0, DEFAULT_DAY
    la t1, g_clock_day
    sw t0, 0(t1)

    lw t0, DEFAULT_MONTH
    la t1, g_clock_month
    sw t0, 0(t1)

    lw t0, DEFAULT_YEAR
    la t1, g_clock_year
    sw t0, 0(t1)

    # Khởi tạo g_cycle_1s_count thành 0
    li t1, 0
    la t2, g_cycle_1s_count
    sw t1, 0(t2)

    # Khởi tạo g_1s_signal thành false (0)
    li t1, 0
    la t2, g_1s_signal
    sw t1, 0(t2)

    # call CCLOCK_DisplayClock

    # Retore callee-save registers from stack
    lw ra, 0(sp)
    # Restore (callee-save) stack pointer before returning 
    addi sp, sp, 4
    ret

# void MAIN_Loop(void)
.globl MAIN_Loop
MAIN_Loop:
loop:
    call CCLOCK_Wait1sSignal
    beqz a0, loop

    call CCLOCK_UpdateTime
    # call CCLOCK_DisplayClock
    # Display clock to terminal
    li a0, 38
    call TERMINAL_ClearLine
    call TERMINAL_DisplayDateTime
    li a0, 6
    call TERMINAL_FillBlank
    j loop

# #######################################
# ######       CCLOCK MODULE       ######
# #######################################
.text

# bool CCLOCK_Wait1sSignal(void)
.globl CCLOCK_Wait1sSignal
CCLOCK_Wait1sSignal:
    # Reserve 2 words on the stack
    addi sp, sp, -8
    # Store callee-save registers on stack
    sw s0, 0(sp)            # ra
    sw s1, 4(sp)            # ra

    # Check g_cycle_1s_count true/false ?
    lb s0, g_cycle_1s_count
    lb s1, CYCLE_1S_WAIT
    beq s0, s1, 1f          # if (g_cycle_1s_count == CYCLE_1S_WAIT) 
    lb s0, g_cycle_1s_count 
    addi s0, s0, 1          # g_cycle_1s_count + 1
    la s1, g_cycle_1s_count
    sb s0, 0(s1)            # g_cycle_1s_count = g_cycle_1s_count + 1    
    li a0, 0                # return funcitons is false 
    j 2f

1:
    la s0, g_cycle_1s_count
    sb zero, 0(s0)              # g_cycle_1s_count = 0
    la s0, g_1s_signal
    li s1, 1
    sb s1, 0(s0)                # g_1s_signal = 0
    li a0, 1                    # return 1 (true) have signal 1s
2:
    # Retore callee-save registers from stack
    lw s0, 0(sp)            # ra
    lw s1, 4(sp)            # ra
    # Restore (callee-save) stack pointer before returning
    addi sp, sp, 8
    # Return from function
    ret

# void CCLOCK_UpdateTime(void)
.globl CCLOCK_UpdateTime
CCLOCK_UpdateTime:
    # Reserve 1 words on the stack
    addi sp, sp, -4
    # Store callee-save registers on stack
    sw ra, 0(sp)
    # Check g_1s_signal
    la t0, g_1s_signal
    lb t1, 0(t0)
    beqz t1, end_CCLOCK_UpdateTime # if(g_1s_signal == 0) {end}

    # Set g_1s_signal = false
    li t1, 0
    sb t1, 0(t0)    # g_1s_signal = false

    # Call CLOCK_IncreaseOneSecond
    call CLOCK_IncreaseOneSecond
    beqz a0, end_CCLOCK_UpdateTime

    # Call CLOCK_IncreaseOneMinute
    call CLOCK_IncreaseOneMinute
    beqz a0, end_CCLOCK_UpdateTime

    # Call CLOCK_IncreaseOneHour
    call CLOCK_IncreaseOneHour
    beqz a0, end_CCLOCK_UpdateTime

    # Call CLOCK_IncreaseOneDay
    lw a0, g_clock_month
    lw a1, g_clock_year
    call CLOCK_IncreaseOneDay
    beqz a0, end_CCLOCK_UpdateTime

    # Call CLOCK_IncreaseOneMonth
    call CLOCK_IncreaseOneMonth
    beqz a0, end_CCLOCK_UpdateTime

    # Call CLOCK_IncreaseOneMonth
    call CLOCK_IncreaseOneYear

end_CCLOCK_UpdateTime:
    # Retore callee-save registers from stack
    lw ra, 0(sp)
    # Restore (callee-save) stack pointer before returning 
    addi sp, sp, 4
    ret

# void CCLOCK_DisplayClock(void)
.globl CCLOCK_DisplayClock
CCLOCK_DisplayClock: 
    # Reserve 1 words on the stack
    addi sp, sp, -4
    # Store callee-save registers on stack
    sw ra, 0(sp)
    call DISPLAY_DisplayHour
    call DISPLAY_DisplayMinute
    call DISPLAY_DisplaySecond
    call DISPLAY_DisplayDay
    call DISPLAY_DisplayMonth
    call DISPLAY_DisplayYear
    # Retore callee-save registers from stack
    lw ra, 0(sp)
    # Restore (callee-save) stack pointer before returning 
    addi sp, sp, 4
    ret


# #######################################
# ######       CLOCK MODULE        ######
# #######################################
.text
# Định nghĩa hàm CLOCK_IncreaseOneSecond
.globl CLOCK_IncreaseOneSecond
CLOCK_IncreaseOneSecond:
    # Lưu giá trị của các thanh ghi cần dùng vào stack
    addi sp, sp, -20
    sw ra, 16(sp)
    sw t0, 12(sp)
    sw t1, 8(sp)
    sw t2, 4(sp)
    sw t3, 0(sp)             # Lưu giá trị thanh ghi t3

    # Load các tham số vào thanh ghi
    la t0, g_clock_second      # t0 = &g_clock_second
    la t1, MAX_VALUE_SECOND    # t1 = MAX_VALUE_SECOND
    lw t1, 0(t1)               # Đọc giá trị của MAX_VALUE_SECOND
    la t2, DIRECTION_INCREASE  # t2 = DIRECTION_INCREASE
    lw t2, 0(t2)               # Đọc giá trị của DIRECTION_INCREASE
    la t3, INITIAL_SECOND
    lw t3, 0(t3)

    # Gọi hàm CLOCK_IncreaseByOne với các tham số
    mv a0, t0                  # Tham số 1: &g_clock_second
    mv a1, t1                  # Tham số 2: MAX_VALUE_SECOND
    mv a2, t2                  # Tham số 3: DIRECTION_INCREASE
    mv a3, t3
    jal ra, CLOCK_IncreaseByOne

    # Lưu kết quả b_clock_overflow vào bộ nhớ
    la t0, b_clock_overflow
    sw a0, 0(t0)

    # Khôi phục giá trị của các thanh ghi từ stack
    lw t3, 0(sp)
    lw t2, 4(sp)
    lw t1, 8(sp)
    lw t0, 12(sp)
    lw ra, 16(sp)
    addi sp, sp, 20

    # Trả về kết quả
    jr ra                      # Quay lại điểm gọi

# Định nghĩa các hàm khác tương tự
.globl CLOCK_IncreaseOneMinute
CLOCK_IncreaseOneMinute:
    addi sp, sp, -20
    sw ra, 16(sp)
    sw t0, 12(sp)
    sw t1, 8(sp)
    sw t2, 4(sp)
    sw t3, 0(sp)

    la t0, g_clock_minute
    la t1, MAX_VALUE_MINUTE
    lw t1, 0(t1)
    la t2, DIRECTION_INCREASE
    lw t2, 0(t2)
    la t3, INITIAL_MINUTE
    lw t3, 0(t3)

    mv a0, t0
    mv a1, t1
    mv a2, t2
    mv a3, t3
    jal ra, CLOCK_IncreaseByOne

    la t0, b_clock_overflow
    sw a0, 0(t0)

    lw t3, 0(sp)
    lw t2, 4(sp)
    lw t1, 8(sp)
    lw t0, 12(sp)
    lw ra, 16(sp)
    addi sp, sp, 20

    jr ra

CLOCK_IncreaseOneHour:
    addi sp, sp, -20
    sw ra, 16(sp)
    sw t0, 12(sp)
    sw t1, 8(sp)
    sw t2, 4(sp)
    sw t3, 0(sp)

    la t0, g_clock_hour
    la t1, MAX_VALUE_HOUR
    lw t1, 0(t1)
    la t2, DIRECTION_INCREASE
    lw t2, 0(t2)
    la t3, INITIAL_HOUR
    lw t3, 0(t3)

    mv a0, t0
    mv a1, t1
    mv a2, t2
    mv a3, t3
    jal ra, CLOCK_IncreaseByOne

    la t0, b_clock_overflow
    sw a0, 0(t0)

    lw t3, 0(sp)
    lw t2, 4(sp)
    lw t1, 8(sp)
    lw t0, 12(sp)
    lw ra, 16(sp)
    addi sp, sp, 20

    jr ra

CLOCK_IncreaseOneMonth:
    addi sp, sp, -20
    sw ra, 16(sp)
    sw t0, 12(sp)
    sw t1, 8(sp)
    sw t2, 4(sp)
    sw t3, 0(sp)

    la t0, g_clock_month
    la t1, MAX_VALUE_MONTH
    lw t1, 0(t1)
    la t2, DIRECTION_INCREASE
    lw t2, 0(t2)
    la t3, INITIAL_MONTH
    lw t3, 0(t3)

    mv a0, t0
    mv a1, t1
    mv a2, t2
    mv a3, t3
    jal ra, CLOCK_IncreaseByOne

    la t0, b_clock_overflow
    sw a0, 0(t0)

    lw t3, 0(sp)
    lw t2, 4(sp)
    lw t1, 8(sp)
    lw t0, 12(sp)
    lw ra, 16(sp)
    addi sp, sp, 20

    jr ra

CLOCK_IncreaseOneYear:
    addi sp, sp, -20
    sw ra, 16(sp)
    sw t0, 12(sp)
    sw t1, 8(sp)
    sw t2, 4(sp)
    sw t3, 0(sp)

    la t0, g_clock_year
    la t1, MAX_VALUE_YEAR
    lw t1, 0(t1)
    la t2, DIRECTION_INCREASE
    lw t2, 0(t2)
    la t3, INITIAL_YEAR
    lw t3, 0(t3)

    mv a0, t0
    mv a1, t1
    mv a2, t2
    mv a3, t3
    jal ra, CLOCK_IncreaseByOne

    la t0, b_clock_overflow
    sw a0, 0(t0)

    lw t3, 0(sp)
    lw t2, 4(sp)
    lw t1, 8(sp)
    lw t0, 12(sp)
    lw ra, 16(sp)
    addi sp, sp, 20

    jr ra

.globl CLOCK_IncreaseOneDay
CLOCK_IncreaseOneDay:
    # Save registers
    addi sp, sp, -24
    sw ra, 20(sp)
    sw t0, 16(sp)
    sw t1, 12(sp)
    sw t2, 8(sp)
    sw t3, 4(sp)
    sw t4, 0(sp)

    # Load arguments
    lw t0, 0(a0)    # t0 = current_month
    lw t1, 4(a0)    # t1 = current_year
    la t4, INITIAL_DAY
    lw t4, 0(t4)

    mv a3, t4

    # Initialize max_value_day
    li t2, MAX_VALUE_DAY_28

    # Check if the current month is February
    li t3, 2
    beq t0, t3, check_leap_year

    # Check if the current month is in the list {1, 3, 5, 7, 8, 10, 12}
    li t3, 1
    beq t0, t3, set_max_31
    li t3, 3
    beq t0, t3, set_max_31
    li t3, 5
    beq t0, t3, set_max_31
    li t3, 7
    beq t0, t3, set_max_31
    li t3, 8
    beq t0, t3, set_max_31
    li t3, 10
    beq t0, t3, set_max_31
    li t3, 12
    beq t0, t3, set_max_31

    # Set max_value_day to 30 for other months
    li t2, MAX_VALUE_DAY_30
    j increase_day

set_max_31:
    li t2, MAX_VALUE_DAY_31
    j increase_day

check_leap_year:
    # Call CLOCK_IsLeapYear
    mv a0, t1
    jal ra, CLOCK_IsLeapYear

    # Check if it's a leap year
    beq a0, x0, feb_not_leap

    # Set max_value_day to 29 for leap year
    li t2, MAX_VALUE_DAY_29
    j increase_day

feb_not_leap:
    li t2, MAX_VALUE_DAY_28

increase_day:
    # Call CLOCK_IncreaseByOne
    la a0, g_clock_day
    mv a1, t2
    li a2, 1       # DIRECTION_INCREASE
    jal ra, CLOCK_IncreaseByOne

    # Store result in b_clock_overflow
    mv a0, a0

    # Restore registers
    lw t4, 0(sp)
    lw t3, 4(sp)
    lw t2, 8(sp)
    lw t1, 12(sp)
    lw t0, 16(sp)
    lw ra, 20(sp)
    addi sp, sp, 24

    # Return
    jr ra

#Hàm check năm nhuận
.globl CLOCK_IsLeapYear
CLOCK_IsLeapYear:
    # Save registers
    addi sp, sp, -12
    sw ra, 8(sp)
    sw t0, 4(sp)
    sw t1, 0(sp)

    # Load argument
    mv t0, a0    # t0 = year

    # Check if year % 100 == 0
    li t1, 100
    rem t1, t0, t1
    bnez t1, not_century
    j not_leap

not_century:
    # Check if year % 4 == 0
    li t1, 4
    rem t1, t0, t1
    bnez t1, not_leap
    j is_leap

is_leap:
    li a0, 1    # Return true
    j leap_done

not_leap:
    li a0, 0    # Return false
    j leap_done
leap_done:
    # Restore registers
    lw t1, 0(sp)
    lw t0, 4(sp)
    lw ra, 8(sp)
    addi sp, sp, 12

    # Return
    jr ra


# Định nghĩa hàm CLOCK_IncreaseByOne
.globl CLOCK_IncreaseByOne
CLOCK_IncreaseByOne:
    # Lưu giá trị của các thanh ghi cần dùng vào stack
    addi sp, sp, -12           # Tạo không gian trên stack
    sw ra, 8(sp)               # Lưu giá trị thanh ghi return address
    sw t6, 4(sp)
    sw t1, 0(sp)               # Lưu giá trị thanh ghi t1

    # Load the values from memory
    lw t1, 0(a0)               # t1 = *p_clock_counter
    mv t3, a1                  # t3 = max_value
    mv t4, a2                  # t4 = b_direction
    mv t2, a3                  # t2 = initial_value

    # Initialize b_clock_overflow to false
    li t5, 0                   # t5 = 0

    # Check the direction and perform the appropriate operation
    li t6, 1                   # t6 = DIRECTION_INCREASE
    beq t4, t6, increase       # Nếu b_direction == DIRECTION_INCREASE, nhảy tới increase

    # Direction is decrease
    li t6, 0                   # t6 = 0
    beq t1, t6, underflow      # nếu clock_counter == 0, nhảy tới underflow

    # Decrement the clock_counter
    addi t1, t1, -1            # clock_counter -= 1
    j store_and_exit           # Nhảy tới store_and_exit

underflow:
    li t5, 1                   # b_clock_overflow = true
    mv t1, t3                  # clock_counter = max_value
    j store_and_exit           # Nhảy tới store_and_exit

increase:
    beq t1, t3, overflow       # nếu clock_counter == max_value, nhảy tới overflow

    # Increment the clock_counter
    addi t1, t1, 1             # clock_counter += 1
    j store_and_exit           # Nhảy tới store_and_exit

overflow:
    li t5, 1                   # b_clock_overflow = true
    beqz t2, overflow_0
    j overflow_1                   # clock_counter = 0

overflow_0:
    li t1, 0
    j store_and_exit 

overflow_1:
    li t1, 1

store_and_exit:
    # Store the clock_counter back to memory
    sw t1, 0(a0)

    # Trả về b_clock_overflow qua a0
    mv a0, t5

    # Khôi phục giá trị của các thanh ghi từ stack
    lw t1, 0(sp)               # Phục hồi giá trị thanh ghi t1
    lw ra, 8(sp)               # Phục hồi giá trị thanh ghi ra
    addi sp, sp, 12            # Giải phóng stack

    # Quay lại điểm gọi
    jr ra

# #######################################
# ######      DISPLAY MODULE       ######
# #######################################
.text

# void DISPLAY_DisplayNumber(uint32_t number, uint16_t position_x, uint16_t position_y, uint16_t display_width, uint32_t color)
.globl DISPLAY_DisplayNumber
DISPLAY_DisplayNumber:
    # Reserve 7 words on the stack
    addi sp, sp, -28
    # Store caller-save registers on stack
    sw ra, 0(sp)            # ra

    lb s0, FONT_WIDTH
    addi s0, s0, 1          # s0 = FONT_WIDTH + 1
    mv t0, a3
    addi t0, t0, -1         # t0 = display_width - 1
    mul t0, s0, t0
    add a1, a1, t0          # x = position_x + (FONT_WIDTH + 1) * (display_width - 1)

0:
    beqz a3, 1f
    li t0, 10
    div t1, a0, t0
    mul t0, t1, t0
    sub t0, a0, t0          # t0 = digit = number % 10
    mv a0, t1               # a0 = number = number / 10

    # Store caller-save registers on stack
    sw a0, 4(sp)   
    sw a1, 8(sp)     
    sw a2, 12(sp)
    sw a3, 16(sp)
    sw a4, 20(sp)
    sw s0, 24(sp)

    mv a0, t0
    mv a3, a4
    call LEDMATRIX_DisplayDigit

    # Restore caller-save registers from stack
    lw a0, 4(sp)   
    lw a1, 8(sp)     
    lw a2, 12(sp)
    lw a3, 16(sp)
    lw a4, 20(sp)    
    lw s0, 24(sp)

    sub a1, a1, s0
    addi a3, a3, -1
    j 0b

1:
    # Retore caller-save registers from stack
    lw ra, 0(sp)            # ra
    # Restore (callee-save) stack pointer before returning
    addi sp, sp, 28
    # Return from function
    ret


# void DISPLAY_DisplaySecond(void)
.globl DISPLAY_DisplaySecond
DISPLAY_DisplaySecond:
    # Reserve 1 words on the stack
    addi sp, sp, -4
    # Store caller-save registers on stack
    sw ra, 0(sp)            # ra

    lb a0, g_clock_second
    lh a1, POS_SS_X
    lh a2, POS_SS_Y
    lb a3, NUMBER_WIDTH_2
    lw a4, COLOR_DEFAULT
    call DISPLAY_DisplayNumber

    # Retore caller-save registers from stack
    lw ra, 0(sp)            # ra
    # Restore (callee-save) stack pointer before returning
    addi sp, sp, 4
    # Return from function
    ret


# void DISPLAY_DisplayMinute(void)
.globl DISPLAY_DisplayMinute
DISPLAY_DisplayMinute:
    # Reserve 1 words on the stack
    addi sp, sp, -4
    # Store caller-save registers on stack
    sw ra, 0(sp)            # ra

    lb a0, g_clock_minute
    lh a1, POS_MI_X
    lh a2, POS_MI_Y
    lb a3, NUMBER_WIDTH_2
    lw a4, COLOR_DEFAULT
    call DISPLAY_DisplayNumber

    # Retore caller-save registers from stack
    lw ra, 0(sp)            # ra
    # Restore (callee-save) stack pointer before returning
    addi sp, sp, 4
    # Return from function
    ret


# void DISPLAY_DisplayHour(void)
.globl DISPLAY_DisplayHour
DISPLAY_DisplayHour:
    # Reserve 1 words on the stack
    addi sp, sp, -4
    # Store caller-save registers on stack
    sw ra, 0(sp)            # ra

    lb a0, g_clock_hour
    lh a1, POS_HH_X
    lh a2, POS_HH_Y
    lb a3, NUMBER_WIDTH_2
    lw a4, COLOR_DEFAULT
    call DISPLAY_DisplayNumber

    # Retore caller-save registers from stack
    lw ra, 0(sp)            # ra
    # Restore (callee-save) stack pointer before returning
    addi sp, sp, 4
    # Return from function
    ret


# void DISPLAY_DisplayDay(void)
.globl DISPLAY_DisplayDay
DISPLAY_DisplayDay:
    # Reserve 1 words on the stack
    addi sp, sp, -4
    # Store caller-save registers on stack
    sw ra, 0(sp)            # ra

    lb a0, g_clock_day
    lh a1, POS_DD_X
    lh a2, POS_DD_Y
    lb a3, NUMBER_WIDTH_2
    lw a4, COLOR_DEFAULT
    call DISPLAY_DisplayNumber

    # Retore caller-save registers from stack
    lw ra, 0(sp)            # ra
    # Restore (callee-save) stack pointer before returning
    addi sp, sp, 4
    # Return from function
    ret


# void DISPLAY_DisplayMonth(void)
.globl DISPLAY_DisplayMonth
DISPLAY_DisplayMonth:
    # Reserve 1 words on the stack
    addi sp, sp, -4
    # Store caller-save registers on stack
    sw ra, 0(sp)            # ra

    lb a0, g_clock_month
    lh a1, POS_MO_X
    lh a2, POS_MO_Y
    lb a3, NUMBER_WIDTH_2
    lw a4, COLOR_DEFAULT
    call DISPLAY_DisplayNumber

    # Retore caller-save registers from stack
    lw ra, 0(sp)            # ra
    # Restore (callee-save) stack pointer before returning
    addi sp, sp, 4
    # Return from function
    ret


# void DISPLAY_DisplayYear(void)
.globl DISPLAY_DisplayYear
DISPLAY_DisplayYear:
    # Reserve 1 words on the stack
    addi sp, sp, -4
    # Store caller-save registers on stack
    sw ra, 0(sp)            # ra

    lh a0, g_clock_year
    lh a1, POS_YY_X
    lh a2, POS_YY_Y
    lb a3, NUMBER_WIDTH_4
    lw a4, COLOR_DEFAULT
    call DISPLAY_DisplayNumber

    # Retore caller-save registers from stack
    lw ra, 0(sp)            # ra
    # Restore (callee-save) stack pointer before returning
    addi sp, sp, 4
    # Return from function
    ret


# #######################################
# #####      LED MATRIX MODULE     ######
# #######################################
.text

# void LEDMATRIX_SetScreen(uint32_t color)
.globl LEDMATRIX_SetScreen
LEDMATRIX_SetScreen:
    mv a1, a0
    li a0, LEDMATRIX_SET_SCREEN
    ecall

    # Return from function
    ret

# void LEDMATRIX_DisplayPixel(uint16_t x, uint16_t y, uint32_t color)
.globl LEDMATRIX_DisplayPixel
LEDMATRIX_DisplayPixel:
    # Prepare data
    slli a0, a0, 16         # x = x << 16
    or   a1, a0, a1         # y = x | y

    # Display pixel to Led Matrix
    li a0, LEDMATRIX_SET_PIXEL
    ecall

    # Return from function
    ret


# void LEDMATRIX_DisplayRow(uint16_t row, uint16_t width, uint16_t x, uint16_t y, uint32_t color)
.globl LEDMATRIX_DisplayRow
LEDMATRIX_DisplayRow:
    # Reserve 6 words on the stack
    addi sp, sp, -24
    # Store caller-save registers on stack
    sw ra, 0(sp)            # ra

0:  
    addi a1, a1, -1
    blt a1, x0, LEDMATRIX_DisplayRow_end

    # Store caller-save registers on stack
    sw a0, 4(sp)            # row
    sw a1, 8(sp)            # width
    sw a2, 12(sp)           # x
    sw a3, 16(sp)           # y
    sw a4, 20(sp)           # color

    li t0, 0x1
    sll t0, t0, a1
    and t0, a0, t0

    mv a0, a2
    mv a1, a3
    bnez t0, LEDMATRIX_DisplayRow_else

LEDMATRIX_DisplayRow_if:
    la a2, COLOR_BACKGROUND
    lw a2, 0(a2)
    j LEDMATRIX_DisplayRow_endif
LEDMATRIX_DisplayRow_else:
    mv a2, a4
LEDMATRIX_DisplayRow_endif:
    call LEDMATRIX_DisplayPixel

    # Restore caller-save registers from stack
    lw a0, 4(sp)            # row
    lw a1, 8(sp)            # width
    lw a2, 12(sp)           # x
    lw a3, 16(sp)           # y
    lw a4, 20(sp)           # color

    addi a2, a2, 1
    j 0b

LEDMATRIX_DisplayRow_end:
    # Retore caller-save registers from stack
    lw ra, 0(sp)            # ra
    # Restore (callee-save) stack pointer before returning
    addi sp, sp, 24
    # Return from function
    ret


# void LEDMATRIX_DisplayDigit(uint8_t digit, uint16_t x, uint16_t y, uint32_t color)
.globl LEDMATRIX_DisplayDigit
LEDMATRIX_DisplayDigit:
    # Reserve 4 words on the stack
    addi sp, sp, -16
    # Store caller-save registers on stack
    sw ra, 0(sp)            # ra

    lb s0, FONT_HEIGHT      # s0 = height
    la s1, g_p_font_digit
    slli a0, a0, 2
    add s1, s1, a0          # s1 = g_p_font_digit + digit * 4
    lw s1, 0(s1)

0:
    ble s0, zero, LEDMATRIX_DisplayDigit_end # if s0 <= 0 then LEDMATRIX_DisplayDigit_end
    addi s0, s0, -1

    # Store caller-save registers on stack
    sw a1, 4(sp)
    sw a2, 8(sp)
    sw a3, 12(sp)

    mv a4, a3
    mv a3, a2
    mv a2, a1
    lb a1, FONT_WIDTH
    lb a0, 0(s1)

    call LEDMATRIX_DisplayRow

    # Restore caller-save registers from stack
    lw a1, 4(sp)
    lw a2, 8(sp)
    lw a3, 12(sp)

    addi s1, s1, 1
    addi a2, a2, 1
    j 0b

LEDMATRIX_DisplayDigit_end:
    # Retore caller-save registers from stack
    lw ra, 0(sp)            # ra
    # Restore (callee-save) stack pointer before returning
    addi sp, sp, 16
    # Return from function
    ret

# #######################################
# ######         TERMINAL          ######
# #######################################
.text

# void TERMINAL_PrintString(const char* str)
.globl TERMINAL_PrintString
TERMINAL_PrintString:
.data
    STR_TIME:       .string "Time: "
    STR_DATE:       .string "Date: "
    STR_DATETIME:   .string "Date+Time: "
    STR_NEWLINE:    .string "\n"
.text
    mv a1, a0
    li a0, TERMINAL_PRINT_STRING
    ecall
    # Return from function
    ret


# void TERMINAL_PrintNumber(int32_t number)
.globl TERMINAL_PrintNumber
TERMINAL_PrintNumber:
.text
    mv a1, a0
    li a0, TERMINAL_PRINT_INT
    ecall
    # Return from function
    ret


# void TERMINAL_PrintChar(char c)
.globl TERMINAL_PrintChar
TERMINAL_PrintChar:
.text
    mv a1, a0
    li a0, TERMINAL_PRINT_CHAR
    ecall
    # Return from function
    ret


# void TERMINAL_PrintTime(void)
.globl TERMINAL_PrintTime
TERMINAL_PrintTime:
    # Reserve 1 words on the stack
    addi sp, sp, -4
    # Store caller-save registers on stack
    sw ra, 0(sp)            # ra

    lb a0, g_clock_hour
    call TERMINAL_PrintNumber
    li a0, ':'
    call TERMINAL_PrintChar
    lb a0, g_clock_minute
    call TERMINAL_PrintNumber
    li a0, ':'
    call TERMINAL_PrintChar
    lb a0, g_clock_second
    call TERMINAL_PrintNumber

    # Retore caller-save registers from stack
    lw ra, 0(sp)            # ra
    # Restore (callee-save) stack pointer before returning
    addi sp, sp, 4
    # Return from function
    ret


# void TERMINAL_PrintDate(void)
.globl TERMINAL_PrintDate
TERMINAL_PrintDate:
    # Reserve 1 words on the stack
    addi sp, sp, -4
    # Store caller-save registers on stack
    sw ra, 0(sp)            # ra

    lb a0, g_clock_day
    call TERMINAL_PrintNumber
    li a0, '/'
    call TERMINAL_PrintChar
    lb a0, g_clock_month
    call TERMINAL_PrintNumber
    li a0, '/'
    call TERMINAL_PrintChar
    lh a0, g_clock_year
    call TERMINAL_PrintNumber

    # Retore caller-save registers from stack
    lw ra, 0(sp)            # ra
    # Restore (callee-save) stack pointer before returning
    addi sp, sp, 4
    # Return from function
    ret


# void TERMINAL_DisplayTime(void)
.globl TERMINAL_DisplayTime
TERMINAL_DisplayTime:
    # Reserve 1 words on the stack
    addi sp, sp, -4
    # Store caller-save registers on stack
    sw ra, 0(sp)            # ra

    la a0, STR_TIME
    call TERMINAL_PrintString
    
    call TERMINAL_PrintTime

    li a0, '\n'
    call TERMINAL_PrintChar

    # Retore caller-save registers from stack
    lw ra, 0(sp)            # ra
    # Restore (callee-save) stack pointer before returning
    addi sp, sp, 4
    # Return from function
    ret


# void TERMINAL_DisplayDate(void)
.globl TERMINAL_DisplayDate
TERMINAL_DisplayDate:
    # Reserve 1 words on the stack
    addi sp, sp, -4
    # Store caller-save registers on stack
    sw ra, 0(sp)            # ra

    la a0, STR_DATE
    call TERMINAL_PrintString
    
    call TERMINAL_PrintDate

    li a0, '\n'
    call TERMINAL_PrintChar

    # Retore caller-save registers from stack
    lw ra, 0(sp)            # ra
    # Restore (callee-save) stack pointer before returning
    addi sp, sp, 4
    # Return from function
    ret


# void TERMINAL_DisplayDateTime(void)
.globl TERMINAL_DisplayDateTime
TERMINAL_DisplayDateTime:
    # Reserve 1 words on the stack
    addi sp, sp, -4
    # Store caller-save registers on stack
    sw ra, 0(sp)            # ra

    la a0, STR_DATETIME
    call TERMINAL_PrintString
    call TERMINAL_PrintDate
    li a0, ' '
    call TERMINAL_PrintChar
    call TERMINAL_PrintTime

    # Retore caller-save registers from stack
    lw ra, 0(sp)            # ra
    # Restore (callee-save) stack pointer before returning
    addi sp, sp, 4
    # Return from function
    ret


# void TERMINAL_FillChar(char c, uint32_t number_of_character)
.globl TERMINAL_FillChar
TERMINAL_FillChar:
    # Reserve 3 words on the stack
    addi sp, sp, -12
    # Store caller-save registers on stack
    sw ra, 0(sp)            # ra
    sw a0, 4(sp)            
    sw a1, 8(sp)            

0:

    beqz a1, 1f
    # Store caller-save registers on stack
    sw a1, 8(sp)  
    call TERMINAL_PrintChar
    # Retore caller-save registers from stack
    lw a0, 4(sp)            
    lw a1, 8(sp)

    addi a1, a1, -1
    j 0b
1:
    # Retore caller-save registers from stack
    lw ra, 0(sp)            # ra
    # Restore (callee-save) stack pointer before returning
    addi sp, sp, 12
    # Return from function
    ret


# void TERMINAL_ClearLine(uint32_t max_number_of_character)
.globl TERMINAL_ClearLine
TERMINAL_ClearLine:
    # Reserve 1 words on the stack
    addi sp, sp, -4
    # Store caller-save registers on stack
    sw ra, 0(sp)            # ra

    mv a1, a0
    li a0, '\b'
    call TERMINAL_FillChar

    # Retore caller-save registers from stack
    lw ra, 0(sp)            # ra
    # Restore (callee-save) stack pointer before returning
    addi sp, sp, 4
    # Return from function
    ret


# void TERMINAL_FillBlank(uint32_t max_number_of_character)
.globl TERMINAL_FillBlank
TERMINAL_FillBlank:
    # Reserve 1 words on the stack
    addi sp, sp, -4
    # Store caller-save registers on stack
    sw ra, 0(sp)            # ra

    mv a1, a0
    li a0, ' '
    call TERMINAL_FillChar

    # Retore caller-save registers from stack
    lw ra, 0(sp)            # ra
    # Restore (callee-save) stack pointer before returning
    addi sp, sp, 4
    # Return from function
    ret




# #######################################
# #########      CONSTANT      ##########
# #######################################

# Define ecall IDs
.equ    EXIT, 10
.equ    TERMINAL_PRINT_CHAR, 11
.equ    TERMINAL_PRINT_INT, 1
.equ    TERMINAL_PRINT_STRING, 4
.equ    LEDMATRIX_SET_PIXEL, 0x100
.equ    LEDMATRIX_SET_SCREEN, 0x101
.equ    MAX_VALUE_DAY_28, 28
.equ    MAX_VALUE_DAY_29, 29
.equ    MAX_VALUE_DAY_30, 30
.equ    MAX_VALUE_DAY_31, 31

# #######################################
# #####      CONSTANT VARIABLE     ######
# #######################################
.data

# Define color
COLOR_DEFAULT:      .word 0xFFFF00
COLOR_BACKGROUND:   .word 0x2F2F2F
COLOR_SCREEN:       .word 0x000000

# Define font size
FONT_WIDTH:         .byte 5
FONT_HEIGHT:        .byte 8

# Define font for digit
FONT_DIGIT_0:
    .byte 0b01110
    .byte 0b10001
    .byte 0b10011
    .byte 0b10101
    .byte 0b11001
    .byte 0b10001
    .byte 0b10001
    .byte 0b01110
FONT_DIGIT_1:
    .byte 0b00100
    .byte 0b01100
    .byte 0b10100
    .byte 0b00100
    .byte 0b00100
    .byte 0b00100
    .byte 0b00100
    .byte 0b11111
FONT_DIGIT_2:
    .byte 0b01110
    .byte 0b10001
    .byte 0b00001
    .byte 0b00010
    .byte 0b00100
    .byte 0b01000
    .byte 0b10000
    .byte 0b11111
FONT_DIGIT_3:
    .byte 0b01110
    .byte 0b10001
    .byte 0b00001
    .byte 0b00110
    .byte 0b00001
    .byte 0b00001
    .byte 0b10001
    .byte 0b01110
FONT_DIGIT_4:
    .byte 0b10001
    .byte 0b10001
    .byte 0b10001
    .byte 0b11111
    .byte 0b00001
    .byte 0b00001
    .byte 0b00001
    .byte 0b00001
FONT_DIGIT_5:
    .byte 0b11111
    .byte 0b10000
    .byte 0b10000
    .byte 0b11110
    .byte 0b00001
    .byte 0b00001
    .byte 0b00001
    .byte 0b11110
FONT_DIGIT_6:
    .byte 0b01111
    .byte 0b10000
    .byte 0b10000
    .byte 0b11111
    .byte 0b10001
    .byte 0b10001
    .byte 0b10001
    .byte 0b01110
FONT_DIGIT_7:
    .byte 0b11111
    .byte 0b00001
    .byte 0b00001
    .byte 0b00010
    .byte 0b00100
    .byte 0b00100
    .byte 0b00100
    .byte 0b00100
FONT_DIGIT_8:
    .byte 0b01110
    .byte 0b10001
    .byte 0b10001
    .byte 0b01110
    .byte 0b10001
    .byte 0b10001
    .byte 0b10001
    .byte 0b01110
FONT_DIGIT_9:
    .byte 0b01110
    .byte 0b10001
    .byte 0b10001
    .byte 0b11111
    .byte 0b00001
    .byte 0b00001
    .byte 0b10001
    .byte 0b01110

# Define position for clock element
POS_SS_X:   .half 1
POS_SS_Y:   .half 1
POS_MI_X:   .half 16
POS_MI_Y:   .half 1
POS_HH_X:   .half 31
POS_HH_Y:   .half 1
POS_DD_X:   .half 1
POS_DD_Y:   .half 13
POS_MO_X:   .half 16
POS_MO_Y:   .half 13
POS_YY_X:   .half 31
POS_YY_Y:   .half 13

# Define number witdh
NUMBER_WIDTH_2: .byte 2
NUMBER_WIDTH_4: .byte 4

# Define 1s cycle
CYCLE_1S_WAIT:  .byte 3


# #######################################
# ######      GLOBAL VARIABLE     #######
# #######################################
.data

# Define font array
g_p_font_digit:
    .word FONT_DIGIT_0
    .word FONT_DIGIT_1
    .word FONT_DIGIT_2
    .word FONT_DIGIT_3
    .word FONT_DIGIT_4
    .word FONT_DIGIT_5
    .word FONT_DIGIT_6
    .word FONT_DIGIT_7
    .word FONT_DIGIT_8
    .word FONT_DIGIT_9

# Define clock element
# g_clock_second: .byte 0
# g_clock_minute: .byte 30
# g_clock_hour:   .byte 7
# g_clock_day:    .byte 11
# g_clock_month:  .byte 5
# g_clock_year:   .half 2024

g_clock_second: .word 0          # Biến toàn cục đại diện cho số giây
g_clock_minute: .word 0          # Biến toàn cục đại diện cho số phút
g_clock_hour: .word 0 
g_clock_day: .word 1          # Biến toàn cục đại diện cho số giờ
g_clock_month: .word 1           # Biến toàn cục đại diện cho số tháng
g_clock_year: .word 2000            # Biến toàn cục đại diện cho số năm

# Define signal
g_cycle_1s_count: .byte 0
g_1s_signal:    .byte 0

# Define clock default 
DEFAULT_SECOND: .word 0
DEFAULT_MINUTE: .word 30
DEFAULT_HOUR:   .word 7
DEFAULT_DAY:    .word 11
DEFAULT_MONTH:  .word 5
DEFAULT_YEAR:   .word 2024

# Define for clock module
MAX_VALUE_SECOND: .word 59       # Giá trị tối đa cho số giây
MAX_VALUE_MINUTE: .word 59       # Giá trị tối đa cho số phút
MAX_VALUE_HOUR: .word 23         # Giá trị tối đa cho số giờ
MAX_VALUE_MONTH: .word 11        # Giá trị tối đa cho số tháng (0-11)
MAX_VALUE_YEAR: .word 9999       # Giá trị tối đa cho số năm (ví dụ)

DIRECTION_INCREASE: .word 1      # Hướng tăng (1)
b_clock_overflow: .word 0        # Biến để lưu kết quả tràn

INITIAL_YEAR: .word 1
INITIAL_MONTH: .word 1
INITIAL_DAY: .word 1
INITIAL_HOUR: .word 0
INITIAL_MINUTE: .word 0
INITIAL_SECOND: .word 0


# End of program, leave a blank line afterwards is preferred
