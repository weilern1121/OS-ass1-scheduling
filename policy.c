#include "types.h"
#include "stat.h"
#include "user.h"
//#include "proc.h"

int
main(int argc, char *argv[])
{
    int poli=atoi(argv[0]);
    policy(poli);
    exit(0);
}