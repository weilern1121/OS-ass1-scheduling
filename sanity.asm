
_sanity:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    return result;

}


int main(void) {
   0:	55                   	push   %ebp
    //run_test(&test_round_robin_policy, "round robin policy");
    //run_test(&test_priority_policy, "priority policy");
    //run_test(&test_extended_priority_policy, "extended priority policy");
    //run_test(&test_accumulator, "accumulator");
    //run_test(&test_starvation, "starvation");
    run_test(&test_performance_round_robin, "performance round robin");
   1:	b8 09 11 00 00       	mov    $0x1109,%eax
    return result;

}


int main(void) {
   6:	89 e5                	mov    %esp,%ebp
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	83 ec 10             	sub    $0x10,%esp
    //run_test(&test_round_robin_policy, "round robin policy");
    //run_test(&test_priority_policy, "priority policy");
    //run_test(&test_extended_priority_policy, "extended priority policy");
    //run_test(&test_accumulator, "accumulator");
    //run_test(&test_starvation, "starvation");
    run_test(&test_performance_round_robin, "performance round robin");
   e:	89 44 24 04          	mov    %eax,0x4(%esp)
  12:	c7 04 24 a0 06 00 00 	movl   $0x6a0,(%esp)
  19:	e8 42 00 00 00       	call   60 <run_test>
    run_test(&test_performance_priority, "performance priority");
  1e:	ba 21 11 00 00       	mov    $0x1121,%edx
  23:	89 54 24 04          	mov    %edx,0x4(%esp)
  27:	c7 04 24 c0 06 00 00 	movl   $0x6c0,(%esp)
  2e:	e8 2d 00 00 00       	call   60 <run_test>
    run_test(&test_performance_extended_priority, "performance extended priority");
  33:	b9 36 11 00 00       	mov    $0x1136,%ecx
  38:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  3c:	c7 04 24 00 07 00 00 	movl   $0x700,(%esp)
  43:	e8 18 00 00 00       	call   60 <run_test>
    exit(0);
  48:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  4f:	e8 64 0a 00 00       	call   ab8 <exit>
  54:	66 90                	xchg   %ax,%ax
  56:	66 90                	xchg   %ax,%ax
  58:	66 90                	xchg   %ax,%ax
  5a:	66 90                	xchg   %ax,%ax
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <run_test>:
};


typedef boolean (test_runner)();

void run_test(test_runner *test, char *name) {
  60:	55                   	push   %ebp
    printf(1, "========== Test - %s: Begin ==========\n", name);
  61:	b9 90 0f 00 00       	mov    $0xf90,%ecx
};


typedef boolean (test_runner)();

void run_test(test_runner *test, char *name) {
  66:	89 e5                	mov    %esp,%ebp
  68:	53                   	push   %ebx
  69:	83 ec 14             	sub    $0x14,%esp
  6c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    printf(1, "========== Test - %s: Begin ==========\n", name);
  6f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  73:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  7a:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  7e:	e8 ad 0b 00 00       	call   c30 <printf>
    boolean result = (*test)();
  83:	ff 55 08             	call   *0x8(%ebp)
    if (result) {
        printf(1, "========== Test - %s: Passed ==========\n", name);
  86:	89 5c 24 08          	mov    %ebx,0x8(%esp)
typedef boolean (test_runner)();

void run_test(test_runner *test, char *name) {
    printf(1, "========== Test - %s: Begin ==========\n", name);
    boolean result = (*test)();
    if (result) {
  8a:	85 c0                	test   %eax,%eax
  8c:	75 22                	jne    b0 <run_test+0x50>
        printf(1, "========== Test - %s: Passed ==========\n", name);
    } else {
        printf(1, "========== Test - %s: Failed ==========\n", name);
  8e:	b8 e4 0f 00 00       	mov    $0xfe4,%eax
  93:	89 44 24 04          	mov    %eax,0x4(%esp)
  97:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  9e:	e8 8d 0b 00 00       	call   c30 <printf>
    }
}
  a3:	83 c4 14             	add    $0x14,%esp
  a6:	5b                   	pop    %ebx
  a7:	5d                   	pop    %ebp
  a8:	c3                   	ret    
  a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

void run_test(test_runner *test, char *name) {
    printf(1, "========== Test - %s: Begin ==========\n", name);
    boolean result = (*test)();
    if (result) {
        printf(1, "========== Test - %s: Passed ==========\n", name);
  b0:	ba b8 0f 00 00       	mov    $0xfb8,%edx
  b5:	89 54 24 04          	mov    %edx,0x4(%esp)
  b9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c0:	e8 6b 0b 00 00       	call   c30 <printf>
    } else {
        printf(1, "========== Test - %s: Failed ==========\n", name);
    }
}
  c5:	83 c4 14             	add    $0x14,%esp
  c8:	5b                   	pop    %ebx
  c9:	5d                   	pop    %ebp
  ca:	c3                   	ret    
  cb:	90                   	nop
  cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000000d0 <assert_equals>:

boolean assert_equals(int expected, int actual, char *msg) {
  d0:	55                   	push   %ebp
  d1:	b8 01 00 00 00       	mov    $0x1,%eax
  d6:	89 e5                	mov    %esp,%ebp
  d8:	83 ec 28             	sub    $0x28,%esp
  db:	8b 55 08             	mov    0x8(%ebp),%edx
  de:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    if (expected != actual) {
  e1:	39 ca                	cmp    %ecx,%edx
  e3:	74 26                	je     10b <assert_equals+0x3b>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
  e5:	8b 45 10             	mov    0x10(%ebp),%eax
  e8:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  ec:	89 54 24 0c          	mov    %edx,0xc(%esp)
  f0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  f7:	89 44 24 08          	mov    %eax,0x8(%esp)
  fb:	b8 10 10 00 00       	mov    $0x1010,%eax
 100:	89 44 24 04          	mov    %eax,0x4(%esp)
 104:	e8 27 0b 00 00       	call   c30 <printf>
 109:	31 c0                	xor    %eax,%eax
        return false;
    } else return true;
}
 10b:	c9                   	leave  
 10c:	c3                   	ret    
 10d:	8d 76 00             	lea    0x0(%esi),%esi

00000110 <print_perf>:


void print_perf(struct perf *performance) {
 110:	55                   	push   %ebp
    printf(1, "pref:\n");
 111:	b8 70 10 00 00       	mov    $0x1070,%eax
        return false;
    } else return true;
}


void print_perf(struct perf *performance) {
 116:	89 e5                	mov    %esp,%ebp
 118:	53                   	push   %ebx
 119:	83 ec 14             	sub    $0x14,%esp
 11c:	8b 5d 08             	mov    0x8(%ebp),%ebx
    printf(1, "pref:\n");
 11f:	89 44 24 04          	mov    %eax,0x4(%esp)
 123:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 12a:	e8 01 0b 00 00       	call   c30 <printf>
    printf(1, "\tctime: %d\n", performance->ctime);
 12f:	ba 77 10 00 00       	mov    $0x1077,%edx
 134:	8b 03                	mov    (%ebx),%eax
 136:	89 54 24 04          	mov    %edx,0x4(%esp)
 13a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 141:	89 44 24 08          	mov    %eax,0x8(%esp)
 145:	e8 e6 0a 00 00       	call   c30 <printf>
    printf(1, "\tttime: %d\n", performance->ttime);
 14a:	8b 43 04             	mov    0x4(%ebx),%eax
 14d:	b9 83 10 00 00       	mov    $0x1083,%ecx
 152:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 156:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 15d:	89 44 24 08          	mov    %eax,0x8(%esp)
 161:	e8 ca 0a 00 00       	call   c30 <printf>
    printf(1, "\tstime: %d\n", performance->stime);
 166:	8b 43 08             	mov    0x8(%ebx),%eax
 169:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 170:	89 44 24 08          	mov    %eax,0x8(%esp)
 174:	b8 8f 10 00 00       	mov    $0x108f,%eax
 179:	89 44 24 04          	mov    %eax,0x4(%esp)
 17d:	e8 ae 0a 00 00       	call   c30 <printf>
    printf(1, "\tretime: %d\n", performance->retime);
 182:	8b 43 0c             	mov    0xc(%ebx),%eax
 185:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 18c:	89 44 24 08          	mov    %eax,0x8(%esp)
 190:	b8 9b 10 00 00       	mov    $0x109b,%eax
 195:	89 44 24 04          	mov    %eax,0x4(%esp)
 199:	e8 92 0a 00 00       	call   c30 <printf>
    printf(1, "\trutime: %d\n", performance->rutime);
 19e:	8b 43 10             	mov    0x10(%ebx),%eax
 1a1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1a8:	89 44 24 08          	mov    %eax,0x8(%esp)
 1ac:	b8 a8 10 00 00       	mov    $0x10a8,%eax
 1b1:	89 44 24 04          	mov    %eax,0x4(%esp)
 1b5:	e8 76 0a 00 00       	call   c30 <printf>
    printf(1, "\n\tTurnaround time: %d\n", (performance->ttime - performance->ctime));
 1ba:	8b 43 04             	mov    0x4(%ebx),%eax
 1bd:	b9 b5 10 00 00       	mov    $0x10b5,%ecx
 1c2:	8b 13                	mov    (%ebx),%edx
 1c4:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 1c8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1cf:	29 d0                	sub    %edx,%eax
 1d1:	89 44 24 08          	mov    %eax,0x8(%esp)
 1d5:	e8 56 0a 00 00       	call   c30 <printf>
}
 1da:	83 c4 14             	add    $0x14,%esp
 1dd:	5b                   	pop    %ebx
 1de:	5d                   	pop    %ebp
 1df:	c3                   	ret    

000001e0 <fact>:

int fact(int n) {
 1e0:	55                   	push   %ebp
    if (!n)
        return 0;
    return n * fact(n - 1);
}
 1e1:	31 c0                	xor    %eax,%eax
    printf(1, "\tretime: %d\n", performance->retime);
    printf(1, "\trutime: %d\n", performance->rutime);
    printf(1, "\n\tTurnaround time: %d\n", (performance->ttime - performance->ctime));
}

int fact(int n) {
 1e3:	89 e5                	mov    %esp,%ebp
    if (!n)
        return 0;
    return n * fact(n - 1);
}
 1e5:	5d                   	pop    %ebp
 1e6:	c3                   	ret    
 1e7:	89 f6                	mov    %esi,%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001f0 <fact2>:

unsigned long long fact2(unsigned long long n, unsigned long long k) {
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1f6:	57                   	push   %edi
 1f7:	8b 45 10             	mov    0x10(%ebp),%eax
 1fa:	56                   	push   %esi
 1fb:	8b 55 14             	mov    0x14(%ebp),%edx
 1fe:	53                   	push   %ebx
 1ff:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    start:
    if (n == 1) {
 202:	89 ce                	mov    %ecx,%esi
 204:	83 f6 01             	xor    $0x1,%esi
 207:	09 de                	or     %ebx,%esi
 209:	74 24                	je     22f <fact2+0x3f>
 20b:	90                   	nop
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return k;
    } else {
        --n;
 210:	83 c1 ff             	add    $0xffffffff,%ecx
        k = k * n;
 213:	89 d6                	mov    %edx,%esi
unsigned long long fact2(unsigned long long n, unsigned long long k) {
    start:
    if (n == 1) {
        return k;
    } else {
        --n;
 215:	83 d3 ff             	adc    $0xffffffff,%ebx
        k = k * n;
 218:	89 df                	mov    %ebx,%edi
 21a:	0f af f8             	imul   %eax,%edi
 21d:	0f af f1             	imul   %ecx,%esi
 220:	f7 e1                	mul    %ecx
 222:	01 fe                	add    %edi,%esi
 224:	01 f2                	add    %esi,%edx
    return n * fact(n - 1);
}

unsigned long long fact2(unsigned long long n, unsigned long long k) {
    start:
    if (n == 1) {
 226:	89 ce                	mov    %ecx,%esi
 228:	83 f6 01             	xor    $0x1,%esi
 22b:	09 de                	or     %ebx,%esi
 22d:	75 e1                	jne    210 <fact2+0x20>
        k = k * n;
        goto start;
    }


}
 22f:	5b                   	pop    %ebx
 230:	5e                   	pop    %esi
 231:	5f                   	pop    %edi
 232:	5d                   	pop    %ebp
 233:	c3                   	ret    
 234:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 23a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000240 <fib>:

int fib(int n) {
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	56                   	push   %esi
 244:	53                   	push   %ebx
 245:	83 ec 10             	sub    $0x10,%esp
 248:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if (!n)
 24b:	85 db                	test   %ebx,%ebx
 24d:	74 2d                	je     27c <fib+0x3c>
 24f:	31 f6                	xor    %esi,%esi
 251:	eb 0d                	jmp    260 <fib+0x20>
 253:	90                   	nop
 254:	90                   	nop
 255:	90                   	nop
 256:	90                   	nop
 257:	90                   	nop
 258:	90                   	nop
 259:	90                   	nop
 25a:	90                   	nop
 25b:	90                   	nop
 25c:	90                   	nop
 25d:	90                   	nop
 25e:	90                   	nop
 25f:	90                   	nop
        return 1;
    return fib(n - 1) + fib(n - 2);
 260:	8d 43 ff             	lea    -0x1(%ebx),%eax
 263:	89 04 24             	mov    %eax,(%esp)
 266:	e8 d5 ff ff ff       	call   240 <fib>
 26b:	01 c6                	add    %eax,%esi


}

int fib(int n) {
    if (!n)
 26d:	83 eb 02             	sub    $0x2,%ebx
 270:	75 ee                	jne    260 <fib+0x20>
 272:	8d 46 01             	lea    0x1(%esi),%eax
        return 1;
    return fib(n - 1) + fib(n - 2);
}
 275:	83 c4 10             	add    $0x10,%esp
 278:	5b                   	pop    %ebx
 279:	5e                   	pop    %esi
 27a:	5d                   	pop    %ebp
 27b:	c3                   	ret    


}

int fib(int n) {
    if (!n)
 27c:	b8 01 00 00 00       	mov    $0x1,%eax
 281:	eb f2                	jmp    275 <fib+0x35>
 283:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000290 <test_exit_wait>:
        return 1;
    return fib(n - 1) + fib(n - 2);
}


boolean test_exit_wait() {
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	57                   	push   %edi
 294:	56                   	push   %esi
    int status;
    boolean result = true;
 295:	be 01 00 00 00       	mov    $0x1,%esi
        return 1;
    return fib(n - 1) + fib(n - 2);
}


boolean test_exit_wait() {
 29a:	53                   	push   %ebx
    int status;
    boolean result = true;
    int pid;
    for (int i = 0; i < 20; ++i) {
 29b:	31 db                	xor    %ebx,%ebx
        return 1;
    return fib(n - 1) + fib(n - 2);
}


boolean test_exit_wait() {
 29d:	83 ec 3c             	sub    $0x3c,%esp
    boolean result = true;
    int pid;
    for (int i = 0; i < 20; ++i) {
        pid = fork();
        if (pid > 0) {
            wait(&status);
 2a0:	8d 7d e4             	lea    -0x1c(%ebp),%edi
 2a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
boolean test_exit_wait() {
    int status;
    boolean result = true;
    int pid;
    for (int i = 0; i < 20; ++i) {
        pid = fork();
 2b0:	e8 fb 07 00 00       	call   ab0 <fork>
        if (pid > 0) {
 2b5:	85 c0                	test   %eax,%eax
 2b7:	7e 57                	jle    310 <test_exit_wait+0x80>
            wait(&status);
 2b9:	89 3c 24             	mov    %edi,(%esp)
 2bc:	e8 ff 07 00 00       	call   ac0 <wait>
            result = result && assert_equals(i, status, "exit&wait");
 2c1:	85 f6                	test   %esi,%esi
 2c3:	74 34                	je     2f9 <test_exit_wait+0x69>
 2c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 2c8:	be 01 00 00 00       	mov    $0x1,%esi
        printf(1, "========== Test - %s: Failed ==========\n", name);
    }
}

boolean assert_equals(int expected, int actual, char *msg) {
    if (expected != actual) {
 2cd:	39 d8                	cmp    %ebx,%eax
 2cf:	74 28                	je     2f9 <test_exit_wait+0x69>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
 2d1:	89 44 24 10          	mov    %eax,0x10(%esp)
 2d5:	ba 10 10 00 00       	mov    $0x1010,%edx
 2da:	b8 cc 10 00 00       	mov    $0x10cc,%eax
 2df:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    int pid;
    for (int i = 0; i < 20; ++i) {
        pid = fork();
        if (pid > 0) {
            wait(&status);
            result = result && assert_equals(i, status, "exit&wait");
 2e3:	31 f6                	xor    %esi,%esi
    }
}

boolean assert_equals(int expected, int actual, char *msg) {
    if (expected != actual) {
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
 2e5:	89 44 24 08          	mov    %eax,0x8(%esp)
 2e9:	89 54 24 04          	mov    %edx,0x4(%esp)
 2ed:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 2f4:	e8 37 09 00 00       	call   c30 <printf>

boolean test_exit_wait() {
    int status;
    boolean result = true;
    int pid;
    for (int i = 0; i < 20; ++i) {
 2f9:	43                   	inc    %ebx
 2fa:	83 fb 14             	cmp    $0x14,%ebx
        pid = fork();
        if (pid > 0) {
            wait(&status);
            result = result && assert_equals(i, status, "exit&wait");
            status = -1;
 2fd:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)

boolean test_exit_wait() {
    int status;
    boolean result = true;
    int pid;
    for (int i = 0; i < 20; ++i) {
 304:	75 aa                	jne    2b0 <test_exit_wait+0x20>
            sleep(3);
            exit(i);
        }
    }
    return result;
}
 306:	83 c4 3c             	add    $0x3c,%esp
 309:	89 f0                	mov    %esi,%eax
 30b:	5b                   	pop    %ebx
 30c:	5e                   	pop    %esi
 30d:	5f                   	pop    %edi
 30e:	5d                   	pop    %ebp
 30f:	c3                   	ret    
        if (pid > 0) {
            wait(&status);
            result = result && assert_equals(i, status, "exit&wait");
            status = -1;
        } else {
            sleep(3);
 310:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
 317:	e8 2c 08 00 00       	call   b48 <sleep>
            exit(i);
 31c:	89 1c 24             	mov    %ebx,(%esp)
 31f:	e8 94 07 00 00       	call   ab8 <exit>
 324:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 32a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000330 <test_detach>:
        }
    }
    return result;
}

boolean test_detach() {
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	56                   	push   %esi
 334:	53                   	push   %ebx
 335:	83 ec 20             	sub    $0x20,%esp
    int pid;
    boolean result1;
    boolean result2;
    boolean result3;

    pid = fork();
 338:	e8 73 07 00 00       	call   ab0 <fork>
    if (pid > 0) {
 33d:	85 c0                	test   %eax,%eax
 33f:	0f 8e f2 00 00 00    	jle    437 <test_detach+0x107>
        status1 = detach(pid);
 345:	89 04 24             	mov    %eax,(%esp)
 348:	89 c6                	mov    %eax,%esi

boolean assert_equals(int expected, int actual, char *msg) {
    if (expected != actual) {
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
        return false;
    } else return true;
 34a:	bb 01 00 00 00       	mov    $0x1,%ebx
    boolean result2;
    boolean result3;

    pid = fork();
    if (pid > 0) {
        status1 = detach(pid);
 34f:	e8 0c 08 00 00       	call   b60 <detach>
        printf(1, "========== Test - %s: Failed ==========\n", name);
    }
}

boolean assert_equals(int expected, int actual, char *msg) {
    if (expected != actual) {
 354:	85 c0                	test   %eax,%eax
 356:	0f 85 94 00 00 00    	jne    3f0 <test_detach+0xc0>
    pid = fork();
    if (pid > 0) {
        status1 = detach(pid);
        result1 = assert_equals(0, status1, "detach - status1");

        status2 = detach(pid);
 35c:	89 34 24             	mov    %esi,(%esp)
 35f:	e8 fc 07 00 00       	call   b60 <detach>
        printf(1, "========== Test - %s: Failed ==========\n", name);
    }
}

boolean assert_equals(int expected, int actual, char *msg) {
    if (expected != actual) {
 364:	83 f8 ff             	cmp    $0xffffffff,%eax
 367:	74 47                	je     3b0 <test_detach+0x80>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
 369:	89 44 24 10          	mov    %eax,0x10(%esp)
 36d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
 372:	b8 10 10 00 00       	mov    $0x1010,%eax
 377:	be e7 10 00 00       	mov    $0x10e7,%esi
 37c:	89 44 24 04          	mov    %eax,0x4(%esp)
 380:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
 384:	89 74 24 08          	mov    %esi,0x8(%esp)
 388:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 38f:	e8 9c 08 00 00       	call   c30 <printf>
        result1 = assert_equals(0, status1, "detach - status1");

        status2 = detach(pid);
        result2 = assert_equals(-1, status2, "detach - status2");

        status3 = detach(-10);
 394:	c7 04 24 f6 ff ff ff 	movl   $0xfffffff6,(%esp)
 39b:	e8 c0 07 00 00       	call   b60 <detach>
        printf(1, "========== Test - %s: Failed ==========\n", name);
    }
}

boolean assert_equals(int expected, int actual, char *msg) {
    if (expected != actual) {
 3a0:	83 f8 ff             	cmp    $0xffffffff,%eax
 3a3:	75 1c                	jne    3c1 <test_detach+0x91>
        return result1 && result2 && result3;
    } else {
        sleep(100);
        exit(0);
    }
}
 3a5:	83 c4 20             	add    $0x20,%esp
        result2 = assert_equals(-1, status2, "detach - status2");

        status3 = detach(-10);
        result3 = assert_equals(-1, status3, "detach - status3");

        return result1 && result2 && result3;
 3a8:	31 c0                	xor    %eax,%eax
    } else {
        sleep(100);
        exit(0);
    }
}
 3aa:	5b                   	pop    %ebx
 3ab:	5e                   	pop    %esi
 3ac:	5d                   	pop    %ebp
 3ad:	c3                   	ret    
 3ae:	66 90                	xchg   %ax,%ax
        result1 = assert_equals(0, status1, "detach - status1");

        status2 = detach(pid);
        result2 = assert_equals(-1, status2, "detach - status2");

        status3 = detach(-10);
 3b0:	c7 04 24 f6 ff ff ff 	movl   $0xfffffff6,(%esp)
 3b7:	e8 a4 07 00 00       	call   b60 <detach>
        printf(1, "========== Test - %s: Failed ==========\n", name);
    }
}

boolean assert_equals(int expected, int actual, char *msg) {
    if (expected != actual) {
 3bc:	83 f8 ff             	cmp    $0xffffffff,%eax
 3bf:	74 5f                	je     420 <test_detach+0xf0>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
 3c1:	89 44 24 10          	mov    %eax,0x10(%esp)
 3c5:	ba f8 10 00 00       	mov    $0x10f8,%edx
 3ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 3cf:	b9 10 10 00 00       	mov    $0x1010,%ecx
 3d4:	89 44 24 0c          	mov    %eax,0xc(%esp)
 3d8:	89 54 24 08          	mov    %edx,0x8(%esp)
 3dc:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 3e0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 3e7:	e8 44 08 00 00       	call   c30 <printf>
 3ec:	eb b7                	jmp    3a5 <test_detach+0x75>
 3ee:	66 90                	xchg   %ax,%ax
 3f0:	89 44 24 10          	mov    %eax,0x10(%esp)
 3f4:	31 c0                	xor    %eax,%eax
 3f6:	31 db                	xor    %ebx,%ebx
 3f8:	89 44 24 0c          	mov    %eax,0xc(%esp)
 3fc:	b8 d6 10 00 00       	mov    $0x10d6,%eax
 401:	89 44 24 08          	mov    %eax,0x8(%esp)
 405:	b8 10 10 00 00       	mov    $0x1010,%eax
 40a:	89 44 24 04          	mov    %eax,0x4(%esp)
 40e:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 415:	e8 16 08 00 00       	call   c30 <printf>
 41a:	e9 3d ff ff ff       	jmp    35c <test_detach+0x2c>
 41f:	90                   	nop
        result2 = assert_equals(-1, status2, "detach - status2");

        status3 = detach(-10);
        result3 = assert_equals(-1, status3, "detach - status3");

        return result1 && result2 && result3;
 420:	80 e3 01             	and    $0x1,%bl
 423:	84 db                	test   %bl,%bl
 425:	0f 84 7a ff ff ff    	je     3a5 <test_detach+0x75>
    } else {
        sleep(100);
        exit(0);
    }
}
 42b:	83 c4 20             	add    $0x20,%esp
        result2 = assert_equals(-1, status2, "detach - status2");

        status3 = detach(-10);
        result3 = assert_equals(-1, status3, "detach - status3");

        return result1 && result2 && result3;
 42e:	b8 01 00 00 00       	mov    $0x1,%eax
    } else {
        sleep(100);
        exit(0);
    }
}
 433:	5b                   	pop    %ebx
 434:	5e                   	pop    %esi
 435:	5d                   	pop    %ebp
 436:	c3                   	ret    
        status3 = detach(-10);
        result3 = assert_equals(-1, status3, "detach - status3");

        return result1 && result2 && result3;
    } else {
        sleep(100);
 437:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 43e:	e8 05 07 00 00       	call   b48 <sleep>
        exit(0);
 443:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 44a:	e8 69 06 00 00       	call   ab8 <exit>
 44f:	90                   	nop

00000450 <test_policy_helper>:
    }
}

boolean test_policy_helper(int *priority_mod, int policy) {
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	56                   	push   %esi
 455:	53                   	push   %ebx
    int nProcs = 10;
    int pid, status;
    boolean result = true;
    for (int i = 0; i < nProcs; ++i) {
 456:	31 db                	xor    %ebx,%ebx
        sleep(100);
        exit(0);
    }
}

boolean test_policy_helper(int *priority_mod, int policy) {
 458:	83 ec 3c             	sub    $0x3c,%esp
 45b:	90                   	nop
 45c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    int nProcs = 10;
    int pid, status;
    boolean result = true;
    for (int i = 0; i < nProcs; ++i) {
        pid = fork();
 460:	e8 4b 06 00 00       	call   ab0 <fork>
        if (pid < 0) {
 465:	85 c0                	test   %eax,%eax
 467:	78 6f                	js     4d8 <test_policy_helper+0x88>
            break;
        } else if (pid == 0) {
 469:	74 74                	je     4df <test_policy_helper+0x8f>

boolean test_policy_helper(int *priority_mod, int policy) {
    int nProcs = 10;
    int pid, status;
    boolean result = true;
    for (int i = 0; i < nProcs; ++i) {
 46b:	43                   	inc    %ebx
 46c:	83 fb 0a             	cmp    $0xa,%ebx
 46f:	90                   	nop
 470:	75 ee                	jne    460 <test_policy_helper+0x10>
 472:	be 01 00 00 00       	mov    $0x1,%esi
 477:	8d 7d e4             	lea    -0x1c(%ebp),%edi
 47a:	eb 07                	jmp    483 <test_policy_helper+0x33>
 47c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            }
            sleep(10);
            exit(0);
        }
    }
    for (int j = 0; j < nProcs; ++j) {
 480:	4b                   	dec    %ebx
 481:	74 45                	je     4c8 <test_policy_helper+0x78>
        wait(&status);
 483:	89 3c 24             	mov    %edi,(%esp)
 486:	e8 35 06 00 00       	call   ac0 <wait>
        result = result && assert_equals(0, status, "round robin");
 48b:	85 f6                	test   %esi,%esi
 48d:	74 f1                	je     480 <test_policy_helper+0x30>
 48f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 492:	be 01 00 00 00       	mov    $0x1,%esi
        printf(1, "========== Test - %s: Failed ==========\n", name);
    }
}

boolean assert_equals(int expected, int actual, char *msg) {
    if (expected != actual) {
 497:	85 c0                	test   %eax,%eax
 499:	74 e5                	je     480 <test_policy_helper+0x30>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
 49b:	89 44 24 10          	mov    %eax,0x10(%esp)
 49f:	ba 15 11 00 00       	mov    $0x1115,%edx
 4a4:	31 c0                	xor    %eax,%eax
 4a6:	b9 10 10 00 00       	mov    $0x1010,%ecx
            exit(0);
        }
    }
    for (int j = 0; j < nProcs; ++j) {
        wait(&status);
        result = result && assert_equals(0, status, "round robin");
 4ab:	31 f6                	xor    %esi,%esi
    }
}

boolean assert_equals(int expected, int actual, char *msg) {
    if (expected != actual) {
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
 4ad:	89 44 24 0c          	mov    %eax,0xc(%esp)
 4b1:	89 54 24 08          	mov    %edx,0x8(%esp)
 4b5:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 4b9:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 4c0:	e8 6b 07 00 00       	call   c30 <printf>
            }
            sleep(10);
            exit(0);
        }
    }
    for (int j = 0; j < nProcs; ++j) {
 4c5:	4b                   	dec    %ebx
 4c6:	75 bb                	jne    483 <test_policy_helper+0x33>
        wait(&status);
        result = result && assert_equals(0, status, "round robin");
    }
    return result;

}
 4c8:	83 c4 3c             	add    $0x3c,%esp
 4cb:	89 f0                	mov    %esi,%eax
 4cd:	5b                   	pop    %ebx
 4ce:	5e                   	pop    %esi
 4cf:	5f                   	pop    %edi
 4d0:	5d                   	pop    %ebp
 4d1:	c3                   	ret    
 4d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4d8:	bb 0a 00 00 00       	mov    $0xa,%ebx
 4dd:	eb 93                	jmp    472 <test_policy_helper+0x22>
    for (int i = 0; i < nProcs; ++i) {
        pid = fork();
        if (pid < 0) {
            break;
        } else if (pid == 0) {
            if (priority_mod) {
 4df:	8b 75 08             	mov    0x8(%ebp),%esi
 4e2:	85 f6                	test   %esi,%esi
 4e4:	74 1a                	je     500 <test_policy_helper+0xb0>
                if ((i % *(priority_mod)) == 0 && policy == PRIORITY) {
 4e6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 4e9:	89 d8                	mov    %ebx,%eax
 4eb:	99                   	cltd   
 4ec:	f7 39                	idivl  (%ecx)
 4ee:	83 7d 0c 02          	cmpl   $0x2,0xc(%ebp)
 4f2:	75 04                	jne    4f8 <test_policy_helper+0xa8>
 4f4:	85 d2                	test   %edx,%edx
 4f6:	74 20                	je     518 <test_policy_helper+0xc8>
                    priority(1);
                } else {
                    priority(i % (*priority_mod));
 4f8:	89 14 24             	mov    %edx,(%esp)
 4fb:	e8 68 06 00 00       	call   b68 <priority>
                }
            }
            sleep(10);
 500:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
 507:	e8 3c 06 00 00       	call   b48 <sleep>
            exit(0);
 50c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 513:	e8 a0 05 00 00       	call   ab8 <exit>
        if (pid < 0) {
            break;
        } else if (pid == 0) {
            if (priority_mod) {
                if ((i % *(priority_mod)) == 0 && policy == PRIORITY) {
                    priority(1);
 518:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 51f:	e8 44 06 00 00       	call   b68 <priority>
 524:	eb da                	jmp    500 <test_policy_helper+0xb0>
 526:	8d 76 00             	lea    0x0(%esi),%esi
 529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000530 <test_round_robin_policy>:
    }
    return result;

}

boolean test_round_robin_policy() {
 530:	55                   	push   %ebp
    return test_policy_helper(null, null);
 531:	31 c0                	xor    %eax,%eax
    }
    return result;

}

boolean test_round_robin_policy() {
 533:	89 e5                	mov    %esp,%ebp
 535:	83 ec 18             	sub    $0x18,%esp
    return test_policy_helper(null, null);
 538:	89 44 24 04          	mov    %eax,0x4(%esp)
 53c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 543:	e8 08 ff ff ff       	call   450 <test_policy_helper>

}
 548:	c9                   	leave  
 549:	c3                   	ret    
 54a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000550 <test_priority_policy>:

boolean test_priority_policy() {
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	53                   	push   %ebx
 554:	83 ec 24             	sub    $0x24,%esp
    int priority_mod = 10;
    policy(PRIORITY);
 557:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    return test_policy_helper(null, null);

}

boolean test_priority_policy() {
    int priority_mod = 10;
 55e:	c7 45 f4 0a 00 00 00 	movl   $0xa,-0xc(%ebp)
    policy(PRIORITY);
 565:	e8 ee 05 00 00       	call   b58 <policy>
    boolean result = test_policy_helper(&priority_mod, PRIORITY);
 56a:	b8 02 00 00 00       	mov    $0x2,%eax
 56f:	89 44 24 04          	mov    %eax,0x4(%esp)
 573:	8d 45 f4             	lea    -0xc(%ebp),%eax
 576:	89 04 24             	mov    %eax,(%esp)
 579:	e8 d2 fe ff ff       	call   450 <test_policy_helper>
    policy(ROUND_ROBIN);
 57e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
}

boolean test_priority_policy() {
    int priority_mod = 10;
    policy(PRIORITY);
    boolean result = test_policy_helper(&priority_mod, PRIORITY);
 585:	89 c3                	mov    %eax,%ebx
    policy(ROUND_ROBIN);
 587:	e8 cc 05 00 00       	call   b58 <policy>
    return result;
}
 58c:	83 c4 24             	add    $0x24,%esp
 58f:	89 d8                	mov    %ebx,%eax
 591:	5b                   	pop    %ebx
 592:	5d                   	pop    %ebp
 593:	c3                   	ret    
 594:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 59a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000005a0 <test_extended_priority_policy>:

boolean test_extended_priority_policy() {
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	53                   	push   %ebx
 5a4:	83 ec 24             	sub    $0x24,%esp
    int priority_mod = 10;
    policy(EXTENED_PRIORITY);
 5a7:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
    policy(ROUND_ROBIN);
    return result;
}

boolean test_extended_priority_policy() {
    int priority_mod = 10;
 5ae:	c7 45 f4 0a 00 00 00 	movl   $0xa,-0xc(%ebp)
    policy(EXTENED_PRIORITY);
 5b5:	e8 9e 05 00 00       	call   b58 <policy>
    boolean result = test_policy_helper(&priority_mod, EXTENED_PRIORITY);
 5ba:	b8 03 00 00 00       	mov    $0x3,%eax
 5bf:	89 44 24 04          	mov    %eax,0x4(%esp)
 5c3:	8d 45 f4             	lea    -0xc(%ebp),%eax
 5c6:	89 04 24             	mov    %eax,(%esp)
 5c9:	e8 82 fe ff ff       	call   450 <test_policy_helper>

    policy(ROUND_ROBIN);
 5ce:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
}

boolean test_extended_priority_policy() {
    int priority_mod = 10;
    policy(EXTENED_PRIORITY);
    boolean result = test_policy_helper(&priority_mod, EXTENED_PRIORITY);
 5d5:	89 c3                	mov    %eax,%ebx

    policy(ROUND_ROBIN);
 5d7:	e8 7c 05 00 00       	call   b58 <policy>
    return result;
}
 5dc:	83 c4 24             	add    $0x24,%esp
 5df:	89 d8                	mov    %ebx,%eax
 5e1:	5b                   	pop    %ebx
 5e2:	5d                   	pop    %ebp
 5e3:	c3                   	ret    
 5e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000005f0 <test_performance_helper>:

boolean test_performance_helper(int *npriority) {
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	57                   	push   %edi
 5f4:	56                   	push   %esi
 5f5:	53                   	push   %ebx
 5f6:	83 ec 3c             	sub    $0x3c,%esp
    int pid1;
    struct perf perf2;
    pid1 = fork();
 5f9:	e8 b2 04 00 00       	call   ab0 <fork>
    if (pid1 > 0) {
 5fe:	85 c0                	test   %eax,%eax
 600:	7f 3e                	jg     640 <test_performance_helper+0x50>
 602:	bb 64 00 00 00       	mov    $0x64,%ebx
            pid = fork();
            // the child pid is pid
            if (pid > 0) {
                int status;
                sleep(5);
                wait_stat(&status, &perf1);
 607:	8d 7d d4             	lea    -0x2c(%ebp),%edi
 60a:	8d 75 d0             	lea    -0x30(%ebp),%esi
 60d:	8d 76 00             	lea    0x0(%esi),%esi
    } else {
        for (int a = 0; a < 100; ++a) {
            int pid;
            struct perf perf1;

            pid = fork();
 610:	e8 9b 04 00 00       	call   ab0 <fork>
            // the child pid is pid
            if (pid > 0) {
 615:	85 c0                	test   %eax,%eax
 617:	7e 4e                	jle    667 <test_performance_helper+0x77>
                int status;
                sleep(5);
 619:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 620:	e8 23 05 00 00       	call   b48 <sleep>
                wait_stat(&status, &perf1);
 625:	89 7c 24 04          	mov    %edi,0x4(%esp)
 629:	89 34 24             	mov    %esi,(%esp)
 62c:	e8 3f 05 00 00       	call   b70 <wait_stat>
    if (pid1 > 0) {
        int status1;
        wait_stat(&status1, &perf2);
        print_perf(&perf2);
    } else {
        for (int a = 0; a < 100; ++a) {
 631:	4b                   	dec    %ebx
 632:	75 dc                	jne    610 <test_performance_helper+0x20>
                }
                sleep(5);
                exit(0);
            }
        }
        exit(0);
 634:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 63b:	e8 78 04 00 00       	call   ab8 <exit>
    int pid1;
    struct perf perf2;
    pid1 = fork();
    if (pid1 > 0) {
        int status1;
        wait_stat(&status1, &perf2);
 640:	8d 5d d4             	lea    -0x2c(%ebp),%ebx
 643:	8d 45 d0             	lea    -0x30(%ebp),%eax
 646:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 64a:	89 04 24             	mov    %eax,(%esp)
 64d:	e8 1e 05 00 00       	call   b70 <wait_stat>
        print_perf(&perf2);
 652:	89 1c 24             	mov    %ebx,(%esp)
 655:	e8 b6 fa ff ff       	call   110 <print_perf>
            }
        }
        exit(0);
    }
    return true;
}
 65a:	83 c4 3c             	add    $0x3c,%esp
 65d:	b8 01 00 00 00       	mov    $0x1,%eax
 662:	5b                   	pop    %ebx
 663:	5e                   	pop    %esi
 664:	5f                   	pop    %edi
 665:	5d                   	pop    %ebp
 666:	c3                   	ret    
            if (pid > 0) {
                int status;
                sleep(5);
                wait_stat(&status, &perf1);
            } else {
                if (npriority)
 667:	8b 45 08             	mov    0x8(%ebp),%eax
 66a:	85 c0                	test   %eax,%eax
 66c:	74 0d                	je     67b <test_performance_helper+0x8b>
                    priority(*npriority);
 66e:	8b 45 08             	mov    0x8(%ebp),%eax
 671:	8b 00                	mov    (%eax),%eax
 673:	89 04 24             	mov    %eax,(%esp)
 676:	e8 ed 04 00 00       	call   b68 <priority>
                for (int i = 0; i < 100000000; ++i) {
                    for (int j = 0; j < 100000000; ++j) {
                        ++sum;
                    }
                }
                sleep(5);
 67b:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 682:	e8 c1 04 00 00       	call   b48 <sleep>
                exit(0);
 687:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 68e:	e8 25 04 00 00       	call   ab8 <exit>
 693:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006a0 <test_performance_round_robin>:
boolean test_starvation() {
    return test_starvation_helper(EXTENED_PRIORITY, 0);
}


boolean test_performance_round_robin() {
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	83 ec 18             	sub    $0x18,%esp
    return test_performance_helper(null);
 6a6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 6ad:	e8 3e ff ff ff       	call   5f0 <test_performance_helper>
}
 6b2:	c9                   	leave  
 6b3:	c3                   	ret    
 6b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000006c0 <test_performance_priority>:

boolean test_performance_priority() {
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	53                   	push   %ebx
 6c4:	83 ec 24             	sub    $0x24,%esp
    policy(PRIORITY);
 6c7:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 6ce:	e8 85 04 00 00       	call   b58 <policy>
    int npriority = 2;
    boolean result = test_performance_helper(&npriority);
 6d3:	8d 45 f4             	lea    -0xc(%ebp),%eax
 6d6:	89 04 24             	mov    %eax,(%esp)
    return test_performance_helper(null);
}

boolean test_performance_priority() {
    policy(PRIORITY);
    int npriority = 2;
 6d9:	c7 45 f4 02 00 00 00 	movl   $0x2,-0xc(%ebp)
    boolean result = test_performance_helper(&npriority);
 6e0:	e8 0b ff ff ff       	call   5f0 <test_performance_helper>
    policy(ROUND_ROBIN);
 6e5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
}

boolean test_performance_priority() {
    policy(PRIORITY);
    int npriority = 2;
    boolean result = test_performance_helper(&npriority);
 6ec:	89 c3                	mov    %eax,%ebx
    policy(ROUND_ROBIN);
 6ee:	e8 65 04 00 00       	call   b58 <policy>
    return result;

}
 6f3:	83 c4 24             	add    $0x24,%esp
 6f6:	89 d8                	mov    %ebx,%eax
 6f8:	5b                   	pop    %ebx
 6f9:	5d                   	pop    %ebp
 6fa:	c3                   	ret    
 6fb:	90                   	nop
 6fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000700 <test_performance_extended_priority>:

boolean test_performance_extended_priority() {
 700:	55                   	push   %ebp
 701:	89 e5                	mov    %esp,%ebp
 703:	53                   	push   %ebx
 704:	83 ec 24             	sub    $0x24,%esp
    policy(EXTENED_PRIORITY);
 707:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
 70e:	e8 45 04 00 00       	call   b58 <policy>
    int npriority = 0;
    boolean result = test_performance_helper(&npriority);
 713:	8d 45 f4             	lea    -0xc(%ebp),%eax
 716:	89 04 24             	mov    %eax,(%esp)

}

boolean test_performance_extended_priority() {
    policy(EXTENED_PRIORITY);
    int npriority = 0;
 719:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    boolean result = test_performance_helper(&npriority);
 720:	e8 cb fe ff ff       	call   5f0 <test_performance_helper>
    policy(ROUND_ROBIN);
 725:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
}

boolean test_performance_extended_priority() {
    policy(EXTENED_PRIORITY);
    int npriority = 0;
    boolean result = test_performance_helper(&npriority);
 72c:	89 c3                	mov    %eax,%ebx
    policy(ROUND_ROBIN);
 72e:	e8 25 04 00 00       	call   b58 <policy>
    return result;

}
 733:	83 c4 24             	add    $0x24,%esp
 736:	89 d8                	mov    %ebx,%eax
 738:	5b                   	pop    %ebx
 739:	5d                   	pop    %ebp
 73a:	c3                   	ret    
 73b:	90                   	nop
 73c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000740 <test_starvation_helper>:
    }
    return true;
}


boolean test_starvation_helper(int npolicy, int npriority) {
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	57                   	push   %edi
 744:	56                   	push   %esi
    boolean result = true;
    policy(npolicy);
    int nProcs = 10;
    int pid_arr[nProcs];
    int pid;
    memset(&pid_arr, 0, nProcs * sizeof(int));
 745:	31 f6                	xor    %esi,%esi
    }
    return true;
}


boolean test_starvation_helper(int npolicy, int npriority) {
 747:	53                   	push   %ebx
    boolean result = true;
    policy(npolicy);
    int nProcs = 10;
    int pid_arr[nProcs];
    int pid;
    memset(&pid_arr, 0, nProcs * sizeof(int));
 748:	bb 28 00 00 00       	mov    $0x28,%ebx
    }
    return true;
}


boolean test_starvation_helper(int npolicy, int npriority) {
 74d:	83 ec 5c             	sub    $0x5c,%esp
    boolean result = true;
    policy(npolicy);
 750:	8b 45 08             	mov    0x8(%ebp),%eax
 753:	89 04 24             	mov    %eax,(%esp)
 756:	e8 fd 03 00 00       	call   b58 <policy>
    int nProcs = 10;
    int pid_arr[nProcs];
    int pid;
    memset(&pid_arr, 0, nProcs * sizeof(int));
 75b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 75f:	8d 5d c0             	lea    -0x40(%ebp),%ebx
 762:	89 74 24 04          	mov    %esi,0x4(%esp)
    for (int i = 0; i < nProcs; ++i) {
 766:	31 f6                	xor    %esi,%esi
    boolean result = true;
    policy(npolicy);
    int nProcs = 10;
    int pid_arr[nProcs];
    int pid;
    memset(&pid_arr, 0, nProcs * sizeof(int));
 768:	89 1c 24             	mov    %ebx,(%esp)
 76b:	e8 a0 01 00 00       	call   910 <memset>
    for (int i = 0; i < nProcs; ++i) {
        pid = fork();
 770:	e8 3b 03 00 00       	call   ab0 <fork>
        if (pid < 0) {
 775:	85 c0                	test   %eax,%eax
 777:	78 0f                	js     788 <test_starvation_helper+0x48>
            break;
        } else if (pid == 0) {
 779:	0f 84 a1 00 00 00    	je     820 <test_starvation_helper+0xe0>
            sleep(5);
            priority(npriority);
            for (;;) {};
        } else {
            pid_arr[i] = pid;
 77f:	89 04 b3             	mov    %eax,(%ebx,%esi,4)
    policy(npolicy);
    int nProcs = 10;
    int pid_arr[nProcs];
    int pid;
    memset(&pid_arr, 0, nProcs * sizeof(int));
    for (int i = 0; i < nProcs; ++i) {
 782:	46                   	inc    %esi
 783:	83 fe 0a             	cmp    $0xa,%esi
 786:	75 e8                	jne    770 <test_starvation_helper+0x30>
            for (;;) {};
        } else {
            pid_arr[i] = pid;
        }
    }
    sleep(100);
 788:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 78f:	8d 7d e8             	lea    -0x18(%ebp),%edi
    return true;
}


boolean test_starvation_helper(int npolicy, int npriority) {
    boolean result = true;
 792:	be 01 00 00 00       	mov    $0x1,%esi
            for (;;) {};
        } else {
            pid_arr[i] = pid;
        }
    }
    sleep(100);
 797:	e8 ac 03 00 00       	call   b48 <sleep>
 79c:	eb 15                	jmp    7b3 <test_starvation_helper+0x73>
 79e:	66 90                	xchg   %ax,%ax
    for (int j = 0; j < nProcs; ++j) {
        if (pid_arr[j] != 0) {
            result = result && assert_equals(0, kill(pid_arr[j]), "failed to kill child (yes it does sound horrible)");
            wait(null);
 7a0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 7a7:	e8 14 03 00 00       	call   ac0 <wait>
 7ac:	83 c3 04             	add    $0x4,%ebx
        } else {
            pid_arr[i] = pid;
        }
    }
    sleep(100);
    for (int j = 0; j < nProcs; ++j) {
 7af:	39 df                	cmp    %ebx,%edi
 7b1:	74 4d                	je     800 <test_starvation_helper+0xc0>
        if (pid_arr[j] != 0) {
 7b3:	8b 03                	mov    (%ebx),%eax
 7b5:	85 c0                	test   %eax,%eax
 7b7:	74 f3                	je     7ac <test_starvation_helper+0x6c>
            result = result && assert_equals(0, kill(pid_arr[j]), "failed to kill child (yes it does sound horrible)");
 7b9:	85 f6                	test   %esi,%esi
 7bb:	74 e3                	je     7a0 <test_starvation_helper+0x60>
 7bd:	89 04 24             	mov    %eax,(%esp)
 7c0:	be 01 00 00 00       	mov    $0x1,%esi
 7c5:	e8 1e 03 00 00       	call   ae8 <kill>
        printf(1, "========== Test - %s: Failed ==========\n", name);
    }
}

boolean assert_equals(int expected, int actual, char *msg) {
    if (expected != actual) {
 7ca:	85 c0                	test   %eax,%eax
 7cc:	74 d2                	je     7a0 <test_starvation_helper+0x60>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
 7ce:	89 44 24 10          	mov    %eax,0x10(%esp)
 7d2:	ba 3c 10 00 00       	mov    $0x103c,%edx
 7d7:	31 c0                	xor    %eax,%eax
 7d9:	b9 10 10 00 00       	mov    $0x1010,%ecx
        }
    }
    sleep(100);
    for (int j = 0; j < nProcs; ++j) {
        if (pid_arr[j] != 0) {
            result = result && assert_equals(0, kill(pid_arr[j]), "failed to kill child (yes it does sound horrible)");
 7de:	31 f6                	xor    %esi,%esi
    }
}

boolean assert_equals(int expected, int actual, char *msg) {
    if (expected != actual) {
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
 7e0:	89 44 24 0c          	mov    %eax,0xc(%esp)
 7e4:	89 54 24 08          	mov    %edx,0x8(%esp)
 7e8:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 7ec:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 7f3:	e8 38 04 00 00       	call   c30 <printf>
 7f8:	eb a6                	jmp    7a0 <test_starvation_helper+0x60>
 7fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        if (pid_arr[j] != 0) {
            result = result && assert_equals(0, kill(pid_arr[j]), "failed to kill child (yes it does sound horrible)");
            wait(null);
        }
    }
    policy(ROUND_ROBIN);
 800:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 807:	e8 4c 03 00 00       	call   b58 <policy>
    return result;
}
 80c:	83 c4 5c             	add    $0x5c,%esp
 80f:	89 f0                	mov    %esi,%eax
 811:	5b                   	pop    %ebx
 812:	5e                   	pop    %esi
 813:	5f                   	pop    %edi
 814:	5d                   	pop    %ebp
 815:	c3                   	ret    
 816:	8d 76 00             	lea    0x0(%esi),%esi
 819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    for (int i = 0; i < nProcs; ++i) {
        pid = fork();
        if (pid < 0) {
            break;
        } else if (pid == 0) {
            sleep(5);
 820:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 827:	e8 1c 03 00 00       	call   b48 <sleep>
            priority(npriority);
 82c:	8b 45 0c             	mov    0xc(%ebp),%eax
 82f:	89 04 24             	mov    %eax,(%esp)
 832:	e8 31 03 00 00       	call   b68 <priority>
 837:	eb fe                	jmp    837 <test_starvation_helper+0xf7>
 839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000840 <test_accumulator>:
}

/**
 * test the growth of accumulator
 */
boolean test_accumulator() {
 840:	55                   	push   %ebp
    return test_starvation_helper(PRIORITY, 2);
 841:	b8 02 00 00 00       	mov    $0x2,%eax
}

/**
 * test the growth of accumulator
 */
boolean test_accumulator() {
 846:	89 e5                	mov    %esp,%ebp
 848:	83 ec 18             	sub    $0x18,%esp
    return test_starvation_helper(PRIORITY, 2);
 84b:	89 44 24 04          	mov    %eax,0x4(%esp)
 84f:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 856:	e8 e5 fe ff ff       	call   740 <test_starvation_helper>
}
 85b:	c9                   	leave  
 85c:	c3                   	ret    
 85d:	8d 76 00             	lea    0x0(%esi),%esi

00000860 <test_starvation>:

/** I hope this does test the case of
   starvation in extended priority
   (where the priority is 0)
*/
boolean test_starvation() {
 860:	55                   	push   %ebp
    return test_starvation_helper(EXTENED_PRIORITY, 0);
 861:	31 c0                	xor    %eax,%eax

/** I hope this does test the case of
   starvation in extended priority
   (where the priority is 0)
*/
boolean test_starvation() {
 863:	89 e5                	mov    %esp,%ebp
 865:	83 ec 18             	sub    $0x18,%esp
    return test_starvation_helper(EXTENED_PRIORITY, 0);
 868:	89 44 24 04          	mov    %eax,0x4(%esp)
 86c:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
 873:	e8 c8 fe ff ff       	call   740 <test_starvation_helper>
}
 878:	c9                   	leave  
 879:	c3                   	ret    
 87a:	66 90                	xchg   %ax,%ax
 87c:	66 90                	xchg   %ax,%ax
 87e:	66 90                	xchg   %ax,%ax

00000880 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 880:	55                   	push   %ebp
 881:	89 e5                	mov    %esp,%ebp
 883:	8b 45 08             	mov    0x8(%ebp),%eax
 886:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 889:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 88a:	89 c2                	mov    %eax,%edx
 88c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 890:	41                   	inc    %ecx
 891:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 895:	42                   	inc    %edx
 896:	84 db                	test   %bl,%bl
 898:	88 5a ff             	mov    %bl,-0x1(%edx)
 89b:	75 f3                	jne    890 <strcpy+0x10>
    ;
  return os;
}
 89d:	5b                   	pop    %ebx
 89e:	5d                   	pop    %ebp
 89f:	c3                   	ret    

000008a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 8a0:	55                   	push   %ebp
 8a1:	89 e5                	mov    %esp,%ebp
 8a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 8a6:	56                   	push   %esi
 8a7:	53                   	push   %ebx
 8a8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 8ab:	0f b6 01             	movzbl (%ecx),%eax
 8ae:	0f b6 13             	movzbl (%ebx),%edx
 8b1:	84 c0                	test   %al,%al
 8b3:	75 1c                	jne    8d1 <strcmp+0x31>
 8b5:	eb 29                	jmp    8e0 <strcmp+0x40>
 8b7:	89 f6                	mov    %esi,%esi
 8b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 8c0:	41                   	inc    %ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 8c1:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 8c4:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 8c7:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 8cb:	84 c0                	test   %al,%al
 8cd:	74 11                	je     8e0 <strcmp+0x40>
 8cf:	89 f3                	mov    %esi,%ebx
 8d1:	38 d0                	cmp    %dl,%al
 8d3:	74 eb                	je     8c0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 8d5:	5b                   	pop    %ebx
int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    p++, q++;
  return (uchar)*p - (uchar)*q;
 8d6:	29 d0                	sub    %edx,%eax
}
 8d8:	5e                   	pop    %esi
 8d9:	5d                   	pop    %ebp
 8da:	c3                   	ret    
 8db:	90                   	nop
 8dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 8e0:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 8e1:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 8e3:	29 d0                	sub    %edx,%eax
}
 8e5:	5e                   	pop    %esi
 8e6:	5d                   	pop    %ebp
 8e7:	c3                   	ret    
 8e8:	90                   	nop
 8e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008f0 <strlen>:

uint
strlen(const char *s)
{
 8f0:	55                   	push   %ebp
 8f1:	89 e5                	mov    %esp,%ebp
 8f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 8f6:	80 39 00             	cmpb   $0x0,(%ecx)
 8f9:	74 10                	je     90b <strlen+0x1b>
 8fb:	31 d2                	xor    %edx,%edx
 8fd:	8d 76 00             	lea    0x0(%esi),%esi
 900:	42                   	inc    %edx
 901:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 905:	89 d0                	mov    %edx,%eax
 907:	75 f7                	jne    900 <strlen+0x10>
    ;
  return n;
}
 909:	5d                   	pop    %ebp
 90a:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 90b:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 90d:	5d                   	pop    %ebp
 90e:	c3                   	ret    
 90f:	90                   	nop

00000910 <memset>:

void*
memset(void *dst, int c, uint n)
{
 910:	55                   	push   %ebp
 911:	89 e5                	mov    %esp,%ebp
 913:	8b 55 08             	mov    0x8(%ebp),%edx
 916:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 917:	8b 4d 10             	mov    0x10(%ebp),%ecx
 91a:	8b 45 0c             	mov    0xc(%ebp),%eax
 91d:	89 d7                	mov    %edx,%edi
 91f:	fc                   	cld    
 920:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 922:	5f                   	pop    %edi
 923:	89 d0                	mov    %edx,%eax
 925:	5d                   	pop    %ebp
 926:	c3                   	ret    
 927:	89 f6                	mov    %esi,%esi
 929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000930 <strchr>:

char*
strchr(const char *s, char c)
{
 930:	55                   	push   %ebp
 931:	89 e5                	mov    %esp,%ebp
 933:	8b 45 08             	mov    0x8(%ebp),%eax
 936:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 93a:	0f b6 10             	movzbl (%eax),%edx
 93d:	84 d2                	test   %dl,%dl
 93f:	74 1b                	je     95c <strchr+0x2c>
    if(*s == c)
 941:	38 d1                	cmp    %dl,%cl
 943:	75 0f                	jne    954 <strchr+0x24>
 945:	eb 17                	jmp    95e <strchr+0x2e>
 947:	89 f6                	mov    %esi,%esi
 949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 950:	38 ca                	cmp    %cl,%dl
 952:	74 0a                	je     95e <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 954:	40                   	inc    %eax
 955:	0f b6 10             	movzbl (%eax),%edx
 958:	84 d2                	test   %dl,%dl
 95a:	75 f4                	jne    950 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 95c:	31 c0                	xor    %eax,%eax
}
 95e:	5d                   	pop    %ebp
 95f:	c3                   	ret    

00000960 <gets>:

char*
gets(char *buf, int max)
{
 960:	55                   	push   %ebp
 961:	89 e5                	mov    %esp,%ebp
 963:	57                   	push   %edi
 964:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 965:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
 967:	53                   	push   %ebx
 968:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 96b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 96e:	eb 32                	jmp    9a2 <gets+0x42>
    cc = read(0, &c, 1);
 970:	b8 01 00 00 00       	mov    $0x1,%eax
 975:	89 44 24 08          	mov    %eax,0x8(%esp)
 979:	89 7c 24 04          	mov    %edi,0x4(%esp)
 97d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 984:	e8 47 01 00 00       	call   ad0 <read>
    if(cc < 1)
 989:	85 c0                	test   %eax,%eax
 98b:	7e 1d                	jle    9aa <gets+0x4a>
      break;
    buf[i++] = c;
 98d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 991:	89 de                	mov    %ebx,%esi
 993:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 996:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 998:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 99c:	74 22                	je     9c0 <gets+0x60>
 99e:	3c 0d                	cmp    $0xd,%al
 9a0:	74 1e                	je     9c0 <gets+0x60>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 9a2:	8d 5e 01             	lea    0x1(%esi),%ebx
 9a5:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 9a8:	7c c6                	jl     970 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 9aa:	8b 45 08             	mov    0x8(%ebp),%eax
 9ad:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 9b1:	83 c4 2c             	add    $0x2c,%esp
 9b4:	5b                   	pop    %ebx
 9b5:	5e                   	pop    %esi
 9b6:	5f                   	pop    %edi
 9b7:	5d                   	pop    %ebp
 9b8:	c3                   	ret    
 9b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 9c0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 9c3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 9c5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 9c9:	83 c4 2c             	add    $0x2c,%esp
 9cc:	5b                   	pop    %ebx
 9cd:	5e                   	pop    %esi
 9ce:	5f                   	pop    %edi
 9cf:	5d                   	pop    %ebp
 9d0:	c3                   	ret    
 9d1:	eb 0d                	jmp    9e0 <stat>
 9d3:	90                   	nop
 9d4:	90                   	nop
 9d5:	90                   	nop
 9d6:	90                   	nop
 9d7:	90                   	nop
 9d8:	90                   	nop
 9d9:	90                   	nop
 9da:	90                   	nop
 9db:	90                   	nop
 9dc:	90                   	nop
 9dd:	90                   	nop
 9de:	90                   	nop
 9df:	90                   	nop

000009e0 <stat>:

int
stat(const char *n, struct stat *st)
{
 9e0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 9e1:	31 c0                	xor    %eax,%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 9e3:	89 e5                	mov    %esp,%ebp
 9e5:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 9e8:	89 44 24 04          	mov    %eax,0x4(%esp)
 9ec:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 9ef:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 9f2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 9f5:	89 04 24             	mov    %eax,(%esp)
 9f8:	e8 fb 00 00 00       	call   af8 <open>
  if(fd < 0)
 9fd:	85 c0                	test   %eax,%eax
 9ff:	78 2f                	js     a30 <stat+0x50>
 a01:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 a03:	8b 45 0c             	mov    0xc(%ebp),%eax
 a06:	89 1c 24             	mov    %ebx,(%esp)
 a09:	89 44 24 04          	mov    %eax,0x4(%esp)
 a0d:	e8 fe 00 00 00       	call   b10 <fstat>
  close(fd);
 a12:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 a15:	89 c6                	mov    %eax,%esi
  close(fd);
 a17:	e8 c4 00 00 00       	call   ae0 <close>
  return r;
 a1c:	89 f0                	mov    %esi,%eax
}
 a1e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 a21:	8b 75 fc             	mov    -0x4(%ebp),%esi
 a24:	89 ec                	mov    %ebp,%esp
 a26:	5d                   	pop    %ebp
 a27:	c3                   	ret    
 a28:	90                   	nop
 a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 a30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a35:	eb e7                	jmp    a1e <stat+0x3e>
 a37:	89 f6                	mov    %esi,%esi
 a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a40 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 a40:	55                   	push   %ebp
 a41:	89 e5                	mov    %esp,%ebp
 a43:	8b 4d 08             	mov    0x8(%ebp),%ecx
 a46:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 a47:	0f be 11             	movsbl (%ecx),%edx
 a4a:	88 d0                	mov    %dl,%al
 a4c:	2c 30                	sub    $0x30,%al
 a4e:	3c 09                	cmp    $0x9,%al
 a50:	b8 00 00 00 00       	mov    $0x0,%eax
 a55:	77 1e                	ja     a75 <atoi+0x35>
 a57:	89 f6                	mov    %esi,%esi
 a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 a60:	41                   	inc    %ecx
 a61:	8d 04 80             	lea    (%eax,%eax,4),%eax
 a64:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 a68:	0f be 11             	movsbl (%ecx),%edx
 a6b:	88 d3                	mov    %dl,%bl
 a6d:	80 eb 30             	sub    $0x30,%bl
 a70:	80 fb 09             	cmp    $0x9,%bl
 a73:	76 eb                	jbe    a60 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 a75:	5b                   	pop    %ebx
 a76:	5d                   	pop    %ebp
 a77:	c3                   	ret    
 a78:	90                   	nop
 a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000a80 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 a80:	55                   	push   %ebp
 a81:	89 e5                	mov    %esp,%ebp
 a83:	56                   	push   %esi
 a84:	8b 45 08             	mov    0x8(%ebp),%eax
 a87:	53                   	push   %ebx
 a88:	8b 5d 10             	mov    0x10(%ebp),%ebx
 a8b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 a8e:	85 db                	test   %ebx,%ebx
 a90:	7e 1a                	jle    aac <memmove+0x2c>
 a92:	31 d2                	xor    %edx,%edx
 a94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 a9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 aa0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 aa4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 aa7:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 aa8:	39 da                	cmp    %ebx,%edx
 aaa:	75 f4                	jne    aa0 <memmove+0x20>
    *dst++ = *src++;
  return vdst;
}
 aac:	5b                   	pop    %ebx
 aad:	5e                   	pop    %esi
 aae:	5d                   	pop    %ebp
 aaf:	c3                   	ret    

00000ab0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 ab0:	b8 01 00 00 00       	mov    $0x1,%eax
 ab5:	cd 40                	int    $0x40
 ab7:	c3                   	ret    

00000ab8 <exit>:
SYSCALL(exit)
 ab8:	b8 02 00 00 00       	mov    $0x2,%eax
 abd:	cd 40                	int    $0x40
 abf:	c3                   	ret    

00000ac0 <wait>:
SYSCALL(wait)
 ac0:	b8 03 00 00 00       	mov    $0x3,%eax
 ac5:	cd 40                	int    $0x40
 ac7:	c3                   	ret    

00000ac8 <pipe>:
SYSCALL(pipe)
 ac8:	b8 04 00 00 00       	mov    $0x4,%eax
 acd:	cd 40                	int    $0x40
 acf:	c3                   	ret    

00000ad0 <read>:
SYSCALL(read)
 ad0:	b8 05 00 00 00       	mov    $0x5,%eax
 ad5:	cd 40                	int    $0x40
 ad7:	c3                   	ret    

00000ad8 <write>:
SYSCALL(write)
 ad8:	b8 10 00 00 00       	mov    $0x10,%eax
 add:	cd 40                	int    $0x40
 adf:	c3                   	ret    

00000ae0 <close>:
SYSCALL(close)
 ae0:	b8 15 00 00 00       	mov    $0x15,%eax
 ae5:	cd 40                	int    $0x40
 ae7:	c3                   	ret    

00000ae8 <kill>:
SYSCALL(kill)
 ae8:	b8 06 00 00 00       	mov    $0x6,%eax
 aed:	cd 40                	int    $0x40
 aef:	c3                   	ret    

00000af0 <exec>:
SYSCALL(exec)
 af0:	b8 07 00 00 00       	mov    $0x7,%eax
 af5:	cd 40                	int    $0x40
 af7:	c3                   	ret    

00000af8 <open>:
SYSCALL(open)
 af8:	b8 0f 00 00 00       	mov    $0xf,%eax
 afd:	cd 40                	int    $0x40
 aff:	c3                   	ret    

00000b00 <mknod>:
SYSCALL(mknod)
 b00:	b8 11 00 00 00       	mov    $0x11,%eax
 b05:	cd 40                	int    $0x40
 b07:	c3                   	ret    

00000b08 <unlink>:
SYSCALL(unlink)
 b08:	b8 12 00 00 00       	mov    $0x12,%eax
 b0d:	cd 40                	int    $0x40
 b0f:	c3                   	ret    

00000b10 <fstat>:
SYSCALL(fstat)
 b10:	b8 08 00 00 00       	mov    $0x8,%eax
 b15:	cd 40                	int    $0x40
 b17:	c3                   	ret    

00000b18 <link>:
SYSCALL(link)
 b18:	b8 13 00 00 00       	mov    $0x13,%eax
 b1d:	cd 40                	int    $0x40
 b1f:	c3                   	ret    

00000b20 <mkdir>:
SYSCALL(mkdir)
 b20:	b8 14 00 00 00       	mov    $0x14,%eax
 b25:	cd 40                	int    $0x40
 b27:	c3                   	ret    

00000b28 <chdir>:
SYSCALL(chdir)
 b28:	b8 09 00 00 00       	mov    $0x9,%eax
 b2d:	cd 40                	int    $0x40
 b2f:	c3                   	ret    

00000b30 <dup>:
SYSCALL(dup)
 b30:	b8 0a 00 00 00       	mov    $0xa,%eax
 b35:	cd 40                	int    $0x40
 b37:	c3                   	ret    

00000b38 <getpid>:
SYSCALL(getpid)
 b38:	b8 0b 00 00 00       	mov    $0xb,%eax
 b3d:	cd 40                	int    $0x40
 b3f:	c3                   	ret    

00000b40 <sbrk>:
SYSCALL(sbrk)
 b40:	b8 0c 00 00 00       	mov    $0xc,%eax
 b45:	cd 40                	int    $0x40
 b47:	c3                   	ret    

00000b48 <sleep>:
SYSCALL(sleep)
 b48:	b8 0d 00 00 00       	mov    $0xd,%eax
 b4d:	cd 40                	int    $0x40
 b4f:	c3                   	ret    

00000b50 <uptime>:
SYSCALL(uptime)
 b50:	b8 0e 00 00 00       	mov    $0xe,%eax
 b55:	cd 40                	int    $0x40
 b57:	c3                   	ret    

00000b58 <policy>:
SYSCALL(policy)
 b58:	b8 17 00 00 00       	mov    $0x17,%eax
 b5d:	cd 40                	int    $0x40
 b5f:	c3                   	ret    

00000b60 <detach>:
SYSCALL(detach)
 b60:	b8 16 00 00 00       	mov    $0x16,%eax
 b65:	cd 40                	int    $0x40
 b67:	c3                   	ret    

00000b68 <priority>:
SYSCALL(priority)
 b68:	b8 18 00 00 00       	mov    $0x18,%eax
 b6d:	cd 40                	int    $0x40
 b6f:	c3                   	ret    

00000b70 <wait_stat>:
SYSCALL(wait_stat)
 b70:	b8 19 00 00 00       	mov    $0x19,%eax
 b75:	cd 40                	int    $0x40
 b77:	c3                   	ret    
 b78:	66 90                	xchg   %ax,%ax
 b7a:	66 90                	xchg   %ax,%ax
 b7c:	66 90                	xchg   %ax,%ax
 b7e:	66 90                	xchg   %ax,%ax

00000b80 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 b80:	55                   	push   %ebp
 b81:	89 e5                	mov    %esp,%ebp
 b83:	57                   	push   %edi
 b84:	56                   	push   %esi
 b85:	89 c6                	mov    %eax,%esi
 b87:	53                   	push   %ebx
 b88:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 b8b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 b8e:	85 db                	test   %ebx,%ebx
 b90:	0f 84 8a 00 00 00    	je     c20 <printint+0xa0>
 b96:	89 d0                	mov    %edx,%eax
 b98:	c1 e8 1f             	shr    $0x1f,%eax
 b9b:	84 c0                	test   %al,%al
 b9d:	0f 84 7d 00 00 00    	je     c20 <printint+0xa0>
    neg = 1;
    x = -xx;
 ba3:	89 d0                	mov    %edx,%eax
 ba5:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 ba7:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 bae:	89 75 c0             	mov    %esi,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 bb1:	31 ff                	xor    %edi,%edi
 bb3:	89 ce                	mov    %ecx,%esi
 bb5:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 bb8:	eb 08                	jmp    bc2 <printint+0x42>
 bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 bc0:	89 cf                	mov    %ecx,%edi
 bc2:	31 d2                	xor    %edx,%edx
 bc4:	f7 f6                	div    %esi
 bc6:	8d 4f 01             	lea    0x1(%edi),%ecx
 bc9:	0f b6 92 5c 11 00 00 	movzbl 0x115c(%edx),%edx
  }while((x /= base) != 0);
 bd0:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 bd2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 bd5:	75 e9                	jne    bc0 <printint+0x40>
  if(neg)
 bd7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 bda:	8b 75 c0             	mov    -0x40(%ebp),%esi
 bdd:	85 d2                	test   %edx,%edx
 bdf:	74 08                	je     be9 <printint+0x69>
    buf[i++] = '-';
 be1:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 be6:	8d 4f 02             	lea    0x2(%edi),%ecx
 be9:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 bed:	8d 76 00             	lea    0x0(%esi),%esi
 bf0:	0f b6 07             	movzbl (%edi),%eax
 bf3:	4f                   	dec    %edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 bf4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 bf8:	89 34 24             	mov    %esi,(%esp)
 bfb:	88 45 d7             	mov    %al,-0x29(%ebp)
 bfe:	b8 01 00 00 00       	mov    $0x1,%eax
 c03:	89 44 24 08          	mov    %eax,0x8(%esp)
 c07:	e8 cc fe ff ff       	call   ad8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 c0c:	39 df                	cmp    %ebx,%edi
 c0e:	75 e0                	jne    bf0 <printint+0x70>
    putc(fd, buf[i]);
}
 c10:	83 c4 4c             	add    $0x4c,%esp
 c13:	5b                   	pop    %ebx
 c14:	5e                   	pop    %esi
 c15:	5f                   	pop    %edi
 c16:	5d                   	pop    %ebp
 c17:	c3                   	ret    
 c18:	90                   	nop
 c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 c20:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 c22:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 c29:	eb 83                	jmp    bae <printint+0x2e>
 c2b:	90                   	nop
 c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000c30 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 c30:	55                   	push   %ebp
 c31:	89 e5                	mov    %esp,%ebp
 c33:	57                   	push   %edi
 c34:	56                   	push   %esi
 c35:	53                   	push   %ebx
 c36:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 c39:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 c3c:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 c3f:	0f b6 1e             	movzbl (%esi),%ebx
 c42:	84 db                	test   %bl,%bl
 c44:	0f 84 c6 00 00 00    	je     d10 <printf+0xe0>
 c4a:	8d 45 10             	lea    0x10(%ebp),%eax
 c4d:	46                   	inc    %esi
 c4e:	89 45 d0             	mov    %eax,-0x30(%ebp)
 c51:	31 d2                	xor    %edx,%edx
 c53:	eb 3b                	jmp    c90 <printf+0x60>
 c55:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 c58:	83 f8 25             	cmp    $0x25,%eax
 c5b:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 c5e:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 c63:	74 1e                	je     c83 <printf+0x53>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 c65:	b8 01 00 00 00       	mov    $0x1,%eax
 c6a:	89 44 24 08          	mov    %eax,0x8(%esp)
 c6e:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 c71:	89 44 24 04          	mov    %eax,0x4(%esp)
 c75:	89 3c 24             	mov    %edi,(%esp)
 c78:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 c7b:	e8 58 fe ff ff       	call   ad8 <write>
 c80:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 c83:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 c84:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 c88:	84 db                	test   %bl,%bl
 c8a:	0f 84 80 00 00 00    	je     d10 <printf+0xe0>
    c = fmt[i] & 0xff;
    if(state == 0){
 c90:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 c92:	0f be cb             	movsbl %bl,%ecx
 c95:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 c98:	74 be                	je     c58 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 c9a:	83 fa 25             	cmp    $0x25,%edx
 c9d:	75 e4                	jne    c83 <printf+0x53>
      if(c == 'd'){
 c9f:	83 f8 64             	cmp    $0x64,%eax
 ca2:	0f 84 20 01 00 00    	je     dc8 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 ca8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 cae:	83 f9 70             	cmp    $0x70,%ecx
 cb1:	74 6d                	je     d20 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 cb3:	83 f8 73             	cmp    $0x73,%eax
 cb6:	0f 84 94 00 00 00    	je     d50 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 cbc:	83 f8 63             	cmp    $0x63,%eax
 cbf:	0f 84 14 01 00 00    	je     dd9 <printf+0x1a9>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 cc5:	83 f8 25             	cmp    $0x25,%eax
 cc8:	0f 84 d2 00 00 00    	je     da0 <printf+0x170>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 cce:	b8 01 00 00 00       	mov    $0x1,%eax
 cd3:	46                   	inc    %esi
 cd4:	89 44 24 08          	mov    %eax,0x8(%esp)
 cd8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 cdb:	89 44 24 04          	mov    %eax,0x4(%esp)
 cdf:	89 3c 24             	mov    %edi,(%esp)
 ce2:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 ce6:	e8 ed fd ff ff       	call   ad8 <write>
 ceb:	ba 01 00 00 00       	mov    $0x1,%edx
 cf0:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 cf3:	89 54 24 08          	mov    %edx,0x8(%esp)
 cf7:	89 44 24 04          	mov    %eax,0x4(%esp)
 cfb:	89 3c 24             	mov    %edi,(%esp)
 cfe:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 d01:	e8 d2 fd ff ff       	call   ad8 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 d06:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 d0a:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 d0c:	84 db                	test   %bl,%bl
 d0e:	75 80                	jne    c90 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 d10:	83 c4 3c             	add    $0x3c,%esp
 d13:	5b                   	pop    %ebx
 d14:	5e                   	pop    %esi
 d15:	5f                   	pop    %edi
 d16:	5d                   	pop    %ebp
 d17:	c3                   	ret    
 d18:	90                   	nop
 d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 d20:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 d27:	b9 10 00 00 00       	mov    $0x10,%ecx
 d2c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 d2f:	89 f8                	mov    %edi,%eax
 d31:	8b 13                	mov    (%ebx),%edx
 d33:	e8 48 fe ff ff       	call   b80 <printint>
        ap++;
 d38:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 d3a:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 d3c:	83 c0 04             	add    $0x4,%eax
 d3f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 d42:	e9 3c ff ff ff       	jmp    c83 <printf+0x53>
 d47:	89 f6                	mov    %esi,%esi
 d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      } else if(c == 's'){
        s = (char*)*ap;
 d50:	8b 45 d0             	mov    -0x30(%ebp),%eax
 d53:	8b 18                	mov    (%eax),%ebx
        ap++;
 d55:	83 c0 04             	add    $0x4,%eax
 d58:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 d5b:	b8 54 11 00 00       	mov    $0x1154,%eax
 d60:	85 db                	test   %ebx,%ebx
 d62:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 d65:	0f b6 03             	movzbl (%ebx),%eax
 d68:	84 c0                	test   %al,%al
 d6a:	74 27                	je     d93 <printf+0x163>
 d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 d70:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 d73:	b8 01 00 00 00       	mov    $0x1,%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 d78:	43                   	inc    %ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 d79:	89 44 24 08          	mov    %eax,0x8(%esp)
 d7d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 d80:	89 44 24 04          	mov    %eax,0x4(%esp)
 d84:	89 3c 24             	mov    %edi,(%esp)
 d87:	e8 4c fd ff ff       	call   ad8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 d8c:	0f b6 03             	movzbl (%ebx),%eax
 d8f:	84 c0                	test   %al,%al
 d91:	75 dd                	jne    d70 <printf+0x140>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 d93:	31 d2                	xor    %edx,%edx
 d95:	e9 e9 fe ff ff       	jmp    c83 <printf+0x53>
 d9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 da0:	b9 01 00 00 00       	mov    $0x1,%ecx
 da5:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 da8:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 dac:	89 44 24 04          	mov    %eax,0x4(%esp)
 db0:	89 3c 24             	mov    %edi,(%esp)
 db3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 db6:	e8 1d fd ff ff       	call   ad8 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 dbb:	31 d2                	xor    %edx,%edx
 dbd:	e9 c1 fe ff ff       	jmp    c83 <printf+0x53>
 dc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 dc8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 dcf:	b9 0a 00 00 00       	mov    $0xa,%ecx
 dd4:	e9 53 ff ff ff       	jmp    d2c <printf+0xfc>
 dd9:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 ddc:	8b 03                	mov    (%ebx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 dde:	89 3c 24             	mov    %edi,(%esp)
 de1:	88 45 e4             	mov    %al,-0x1c(%ebp)
 de4:	b8 01 00 00 00       	mov    $0x1,%eax
 de9:	89 44 24 08          	mov    %eax,0x8(%esp)
 ded:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 df0:	89 44 24 04          	mov    %eax,0x4(%esp)
 df4:	e8 df fc ff ff       	call   ad8 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 df9:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 dfb:	31 d2                	xor    %edx,%edx
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 dfd:	83 c0 04             	add    $0x4,%eax
 e00:	89 45 d0             	mov    %eax,-0x30(%ebp)
 e03:	e9 7b fe ff ff       	jmp    c83 <printf+0x53>
 e08:	66 90                	xchg   %ax,%ax
 e0a:	66 90                	xchg   %ax,%ax
 e0c:	66 90                	xchg   %ax,%ax
 e0e:	66 90                	xchg   %ax,%ax

00000e10 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 e10:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e11:	a1 dc 16 00 00       	mov    0x16dc,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 e16:	89 e5                	mov    %esp,%ebp
 e18:	57                   	push   %edi
 e19:	56                   	push   %esi
 e1a:	53                   	push   %ebx
 e1b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e1e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 e20:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e23:	39 c8                	cmp    %ecx,%eax
 e25:	73 19                	jae    e40 <free+0x30>
 e27:	89 f6                	mov    %esi,%esi
 e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 e30:	39 d1                	cmp    %edx,%ecx
 e32:	72 1c                	jb     e50 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e34:	39 d0                	cmp    %edx,%eax
 e36:	73 18                	jae    e50 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 e38:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e3a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e3c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e3e:	72 f0                	jb     e30 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e40:	39 d0                	cmp    %edx,%eax
 e42:	72 f4                	jb     e38 <free+0x28>
 e44:	39 d1                	cmp    %edx,%ecx
 e46:	73 f0                	jae    e38 <free+0x28>
 e48:	90                   	nop
 e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 e50:	8b 73 fc             	mov    -0x4(%ebx),%esi
 e53:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 e56:	39 d7                	cmp    %edx,%edi
 e58:	74 19                	je     e73 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 e5a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 e5d:	8b 50 04             	mov    0x4(%eax),%edx
 e60:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 e63:	39 f1                	cmp    %esi,%ecx
 e65:	74 25                	je     e8c <free+0x7c>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 e67:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 e69:	5b                   	pop    %ebx
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 e6a:	a3 dc 16 00 00       	mov    %eax,0x16dc
}
 e6f:	5e                   	pop    %esi
 e70:	5f                   	pop    %edi
 e71:	5d                   	pop    %ebp
 e72:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 e73:	8b 7a 04             	mov    0x4(%edx),%edi
 e76:	01 fe                	add    %edi,%esi
 e78:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 e7b:	8b 10                	mov    (%eax),%edx
 e7d:	8b 12                	mov    (%edx),%edx
 e7f:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 e82:	8b 50 04             	mov    0x4(%eax),%edx
 e85:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 e88:	39 f1                	cmp    %esi,%ecx
 e8a:	75 db                	jne    e67 <free+0x57>
    p->s.size += bp->s.size;
 e8c:	8b 4b fc             	mov    -0x4(%ebx),%ecx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 e8f:	a3 dc 16 00 00       	mov    %eax,0x16dc
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 e94:	01 ca                	add    %ecx,%edx
 e96:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 e99:	8b 53 f8             	mov    -0x8(%ebx),%edx
 e9c:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 e9e:	5b                   	pop    %ebx
 e9f:	5e                   	pop    %esi
 ea0:	5f                   	pop    %edi
 ea1:	5d                   	pop    %ebp
 ea2:	c3                   	ret    
 ea3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000eb0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 eb0:	55                   	push   %ebp
 eb1:	89 e5                	mov    %esp,%ebp
 eb3:	57                   	push   %edi
 eb4:	56                   	push   %esi
 eb5:	53                   	push   %ebx
 eb6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 eb9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 ebc:	8b 15 dc 16 00 00    	mov    0x16dc,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ec2:	8d 78 07             	lea    0x7(%eax),%edi
 ec5:	c1 ef 03             	shr    $0x3,%edi
 ec8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 ec9:	85 d2                	test   %edx,%edx
 ecb:	0f 84 95 00 00 00    	je     f66 <malloc+0xb6>
 ed1:	8b 02                	mov    (%edx),%eax
 ed3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 ed6:	39 cf                	cmp    %ecx,%edi
 ed8:	76 66                	jbe    f40 <malloc+0x90>
 eda:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 ee0:	be 00 10 00 00       	mov    $0x1000,%esi
 ee5:	0f 43 f7             	cmovae %edi,%esi
 ee8:	ba 00 80 00 00       	mov    $0x8000,%edx
 eed:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 ef4:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 efa:	0f 46 da             	cmovbe %edx,%ebx
 efd:	eb 0a                	jmp    f09 <malloc+0x59>
 eff:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 f00:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 f02:	8b 48 04             	mov    0x4(%eax),%ecx
 f05:	39 cf                	cmp    %ecx,%edi
 f07:	76 37                	jbe    f40 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 f09:	39 05 dc 16 00 00    	cmp    %eax,0x16dc
 f0f:	89 c2                	mov    %eax,%edx
 f11:	75 ed                	jne    f00 <malloc+0x50>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 f13:	89 1c 24             	mov    %ebx,(%esp)
 f16:	e8 25 fc ff ff       	call   b40 <sbrk>
  if(p == (char*)-1)
 f1b:	83 f8 ff             	cmp    $0xffffffff,%eax
 f1e:	74 18                	je     f38 <malloc+0x88>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 f20:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 f23:	83 c0 08             	add    $0x8,%eax
 f26:	89 04 24             	mov    %eax,(%esp)
 f29:	e8 e2 fe ff ff       	call   e10 <free>
  return freep;
 f2e:	8b 15 dc 16 00 00    	mov    0x16dc,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 f34:	85 d2                	test   %edx,%edx
 f36:	75 c8                	jne    f00 <malloc+0x50>
        return 0;
 f38:	31 c0                	xor    %eax,%eax
 f3a:	eb 1c                	jmp    f58 <malloc+0xa8>
 f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 f40:	39 cf                	cmp    %ecx,%edi
 f42:	74 1c                	je     f60 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 f44:	29 f9                	sub    %edi,%ecx
 f46:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 f49:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 f4c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 f4f:	89 15 dc 16 00 00    	mov    %edx,0x16dc
      return (void*)(p + 1);
 f55:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 f58:	83 c4 1c             	add    $0x1c,%esp
 f5b:	5b                   	pop    %ebx
 f5c:	5e                   	pop    %esi
 f5d:	5f                   	pop    %edi
 f5e:	5d                   	pop    %ebp
 f5f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 f60:	8b 08                	mov    (%eax),%ecx
 f62:	89 0a                	mov    %ecx,(%edx)
 f64:	eb e9                	jmp    f4f <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 f66:	b8 e0 16 00 00       	mov    $0x16e0,%eax
 f6b:	ba e0 16 00 00       	mov    $0x16e0,%edx
    base.s.size = 0;
 f70:	31 c9                	xor    %ecx,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 f72:	a3 dc 16 00 00       	mov    %eax,0x16dc
    base.s.size = 0;
 f77:	b8 e0 16 00 00       	mov    $0x16e0,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 f7c:	89 15 e0 16 00 00    	mov    %edx,0x16e0
    base.s.size = 0;
 f82:	89 0d e4 16 00 00    	mov    %ecx,0x16e4
 f88:	e9 4d ff ff ff       	jmp    eda <malloc+0x2a>
