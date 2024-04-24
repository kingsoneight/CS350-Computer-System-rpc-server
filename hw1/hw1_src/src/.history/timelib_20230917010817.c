/*******************************************************************************
 * Time Functions Library (implementation)
 *
 * Description:
 *     A library to handle various time-related functions and operations.
 *
 * Author:
 *     Renato Mancuso <rmancuso@bu.edu>
 *
 * Affiliation:
 *     Boston University
 *
 * Creation Date:
 *     September 10, 2023
 *
 * Notes:
 *     Ensure to link against the necessary dependencies when compiling and
 *     using this library. Modifications or improvements are welcome. Please
 *     refer to the accompanying documentation for detailed usage instructions.
 *
 *******************************************************************************/

#include "timelib.h"

/* Return the number of clock cycles elapsed when waiting for
 * wait_time seconds using sleeping functions */
uint64_t get_elapsed_sleep(long sec, long nsec)
{

	/* initialize variable clock and timespec structs for nanosleep*/
	uint64_t clock1 = 0;
	uint64_t clock2 = 0;
	struct timespec req = {sec, nsec};
	struct timespec rem;

	get_clocks(clock1);
	nanosleep(&req, &rem);
	get_clocks(clock2);

	return clock2 - clock1;
}
/* Return the number of clock cycles elapsed when waiting for
 * wait_time seconds using busy-waiting functions */
uint64_t get_elapsed_busywait(long sec, long nsec)
{
	struct timespec tp, begin_timestamp;
	uint64_t clock1, clock2;

	if (clock_gettime(CLOCK_MONOTONIC, &tp) == 0)
	{
		begin_timestamp = tp;
		get_clocks(clock1);
		do
		{
			clock_gettime(CLOCK_MONOTONIC, &tp);
			get_clocks(clock2);
		} while (tp.tv_sec * 1e9 + tp.tv_nsec <= begin_timestamp.tv_sec * 1e9 + begin_timestamp.tv_nsec + sec * 1e9 + nsec);
	}
	return clock2 - clock1;
}

/* Utility function to add two timespec structures together. The input
 * parameter a is updated with the result of the sum. */
void timespec_add(struct timespec *a, struct timespec *b)
{
	/* Try to add up the nsec and see if we spill over into the
	 * seconds */
	time_t addl_seconds = b->tv_sec;
	a->tv_nsec += b->tv_nsec;
	if (a->tv_nsec > NANO_IN_SEC)
	{
		addl_seconds += a->tv_nsec / NANO_IN_SEC;
		a->tv_nsec = a->tv_nsec % NANO_IN_SEC;
	}
	a->tv_sec += addl_seconds;
}

/* Utility function to compare two timespec structures. It returns 1
 * if a is in the future compared to b; -1 if b is in the future
 * compared to a; 0 if they are identical. */
int timespec_cmp(struct timespec *a, struct timespec *b)
{
	if (a->tv_sec == b->tv_sec && a->tv_nsec == b->tv_nsec)
	{
		return 0;
	}
	else if ((a->tv_sec > b->tv_sec) ||
					 (a->tv_sec == b->tv_sec && a->tv_nsec > b->tv_nsec))
	{
		return 1;
	}
	else
	{
		return -1;
	}
}

/* Busywait for the amount of time described via the delay
 * parameter */
uint64_t busywait_timespec(struct timespec delay)
{
	/* IMPLEMENT ME! (Optional but useful) */
}
