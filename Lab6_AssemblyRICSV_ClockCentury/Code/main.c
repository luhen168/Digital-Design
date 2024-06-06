// File: main.c
#include "cclock.h"
#include "stdio.h"

void MAIN_Init(void) {
    g_clock_second = DEFAULT_SECOND;
    g_clock_minute = DEFAULT_MINUTE;
    g_clock_hour = DEFAULT_HOUR;
    g_clock_day = DEFAULT_DAY;
    g_clock_month = DEFAULT_MONTH;
    g_clock_year = DEFAULT_YEAR;
    g_cycle_1s_count = 0;
    g_1s_signal = false;
}

void MAIN_Loop(void) {
    while (1) {
        if (CCLOCK_Wait1sSignal()) {
            CCLOCK_DisplayClock();
            CCLOCK_UpdateTime();
        }
    }
}

int main(void) {
    MAIN_Init();
    MAIN_Loop();
    return 0;
}