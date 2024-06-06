// File: cclock.c
#include "cclock.h"
#include "clock.h"
#include "display.h"

// Global variables definition
unsigned int g_cycle_1s_count = 0;
bool g_1s_signal = false;
unsigned int g_clock_second = DEFAULT_SECOND;
unsigned int g_clock_minute = DEFAULT_MINUTE;
unsigned int g_clock_hour = DEFAULT_HOUR;
unsigned int g_clock_day = DEFAULT_DAY;
unsigned int g_clock_month = DEFAULT_MONTH;
unsigned int g_clock_year = DEFAULT_YEAR;

bool CCLOCK_Wait1sSignal(void) {
    if (g_cycle_1s_count == CYCLE_1S_WAIT) {
        g_cycle_1s_count = 0;
        g_1s_signal = true;
        return true;
    }
    g_cycle_1s_count++;
    return false;
}

void CCLOCK_UpdateTime(void) {
    if (g_1s_signal) {
        g_1s_signal = false;

     // Gọi hàm CLOCK_IncreaseOneSecond và kiểm tra kết quả
        if (CLOCK_IncreaseOneSecond()) return;

        // Gọi hàm CLOCK_IncreaseOneMinute và kiểm tra kết quả
        if (CLOCK_IncreaseOneMinute()) return;

        // Gọi hàm CLOCK_IncreaseOneHour và kiểm tra kết quả
        if (CLOCK_IncreaseOneHour()) return;

        // Gọi hàm CLOCK_IncreaseOneDay và kiểm tra kết quả
        if (CLOCK_IncreaseOneDay(g_clock_month, g_clock_year)) return;

        // Gọi hàm CLOCK_IncreaseOneMonth và kiểm tra kết quả
        if (CLOCK_IncreaseOneMonth()) return;

        // Gọi hàm CLOCK_IncreaseOneYear
        CLOCK_IncreaseOneYear();
    }
}


void CCLOCK_DisplayClock(void) {
    DISPLAY_DisplayHour();
    DISPLAY_DisplayMinute();
    DISPLAY_DisplaySecond();
    DISPLAY_DisplayDay();
    DISPLAY_DisplayMonth();
    DISPLAY_DisplayYear();
}
