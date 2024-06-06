// File: cclock.h
#ifndef CCLOCK_H
#define CCLOCK_H

#include <stdbool.h>

// Constants
#define CYCLE_1S_WAIT 3
#define DEFAULT_SECOND 0
#define DEFAULT_MINUTE 30
#define DEFAULT_HOUR 7
#define DEFAULT_DAY 11
#define DEFAULT_MONTH 5
#define DEFAULT_YEAR 2024

// Global variables
extern unsigned int g_cycle_1s_count;
extern bool g_1s_signal;
extern unsigned int g_clock_second;
extern unsigned int g_clock_minute;
extern unsigned int g_clock_hour;
extern unsigned int g_clock_day;
extern unsigned int g_clock_month;
extern unsigned int g_clock_year;

// Function declarations
bool CCLOCK_Wait1sSignal(void);
void CCLOCK_UpdateTime(void);
void CCLOCK_DisplayClock(void);

#endif // CCLOCK_H
