#pragma once
#ifdef __CYGWIN__
//#include <sys/syscall.h>
#else
#include <sys/syscall.h>
#endif
#include <unistd.h>

#ifndef __CYGWIN__
static inline int sigtimedwait(const sigset_t* set, siginfo_t* info, const timespec* timeout) {
    union {
        sigset_t set;
        sigset_t set64;
    } s{};
    s.set = *set;
    return syscall(__NR_rt_sigtimedwait, &s.set64, info, timeout, sizeof(sigset_t));
}
#endif