
#include "types.h"
#include "stat.h"
#include "user.h"

int
main(void)
{
    int pid=fork();
    if(pid==0){
        sleep(300);
        exit(5);
    }
    else{
        int status;
        wait(&status);
        printf(1,"########      exit status after is: %d\n", status);
        //free(status);
    }
    exit(0);


//    int pid;
//    int first_status=-2;
//    int second_status=-2;
//    int third_status=-2;
//    pid = fork(); // the child pid is 99
//    if(pid > 0) {
//        first_status = detach(99); // status = 0
//        second_status = detach(99); // status = -1, because this process has already
//                                    // detached this child, and it doesn’t have
//                                    // this child anymore.
//        third_status = detach(77); // status = -1, because this process doesn’t
//                                    // have a child with this pid.
//    }
//    printf(2,"first_status= %s, should be 0.\n",first_status);
//    printf(2,"second_status= %s, should be -1.\n"
//             "(because this process has already\n"
//             "detached this child, and it doesn’t have\n"
//             "this child anymore).\n",second_status);
//    printf(2,"third_status= %s, should be -1 \n  (because this process doesn’t"
//             " have a child with this pid.)  .\n",third_status);
//    exit(0);
}