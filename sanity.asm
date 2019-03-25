
_sanity:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    return result;

}


int main(void) {
   0:	55                   	push   %ebp
    //run_test(&test_exit_wait, "exit&wait");
    //run_test(&test_detach, "detach");
    run_test(&test_round_robin_policy, "round robin policy");
   1:	b8 f5 10 00 00       	mov    $0x10f5,%eax
    return result;

}


int main(void) {
   6:	89 e5                	mov    %esp,%ebp
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	83 ec 10             	sub    $0x10,%esp
    //run_test(&test_exit_wait, "exit&wait");
    //run_test(&test_detach, "detach");
    run_test(&test_round_robin_policy, "round robin policy");
   e:	89 44 24 04          	mov    %eax,0x4(%esp)
  12:	c7 04 24 30 05 00 00 	movl   $0x530,(%esp)
  19:	e8 42 00 00 00       	call   60 <run_test>
    run_test(&test_priority_policy, "priority policy");
  1e:	ba 11 11 00 00       	mov    $0x1111,%edx
  23:	89 54 24 04          	mov    %edx,0x4(%esp)
  27:	c7 04 24 50 05 00 00 	movl   $0x550,(%esp)
  2e:	e8 2d 00 00 00       	call   60 <run_test>
    run_test(&test_extended_priority_policy, "extended priority policy");
  33:	b9 08 11 00 00       	mov    $0x1108,%ecx
  38:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  3c:	c7 04 24 a0 05 00 00 	movl   $0x5a0,(%esp)
  43:	e8 18 00 00 00       	call   60 <run_test>
    //run_test(&test_accumulator, "accumulator");
    //run_test(&test_starvation, "starvation");
    //run_test(&test_performance_round_robin, "performance round robin");
    //run_test(&test_performance_priority, "performance priority");
    //run_test(&test_performance_extended_priority, "performance extended priority");
    exit(0);
  48:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  4f:	e8 54 0a 00 00       	call   aa8 <exit>
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
  61:	b9 70 0f 00 00       	mov    $0xf70,%ecx
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
  7e:	e8 8d 0b 00 00       	call   c10 <printf>
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
  8e:	b8 c4 0f 00 00       	mov    $0xfc4,%eax
  93:	89 44 24 04          	mov    %eax,0x4(%esp)
  97:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  9e:	e8 6d 0b 00 00       	call   c10 <printf>
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
  b0:	ba 98 0f 00 00       	mov    $0xf98,%edx
  b5:	89 54 24 04          	mov    %edx,0x4(%esp)
  b9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c0:	e8 4b 0b 00 00       	call   c10 <printf>
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
  fb:	b8 f0 0f 00 00       	mov    $0xff0,%eax
 100:	89 44 24 04          	mov    %eax,0x4(%esp)
 104:	e8 07 0b 00 00       	call   c10 <printf>
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
 111:	b8 50 10 00 00       	mov    $0x1050,%eax
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
 12a:	e8 e1 0a 00 00       	call   c10 <printf>
    printf(1, "\tctime: %d\n", performance->ctime);
 12f:	ba 57 10 00 00       	mov    $0x1057,%edx
 134:	8b 03                	mov    (%ebx),%eax
 136:	89 54 24 04          	mov    %edx,0x4(%esp)
 13a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 141:	89 44 24 08          	mov    %eax,0x8(%esp)
 145:	e8 c6 0a 00 00       	call   c10 <printf>
    printf(1, "\tttime: %d\n", performance->ttime);
 14a:	8b 43 04             	mov    0x4(%ebx),%eax
 14d:	b9 63 10 00 00       	mov    $0x1063,%ecx
 152:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 156:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 15d:	89 44 24 08          	mov    %eax,0x8(%esp)
 161:	e8 aa 0a 00 00       	call   c10 <printf>
    printf(1, "\tstime: %d\n", performance->stime);
 166:	8b 43 08             	mov    0x8(%ebx),%eax
 169:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 170:	89 44 24 08          	mov    %eax,0x8(%esp)
 174:	b8 6f 10 00 00       	mov    $0x106f,%eax
 179:	89 44 24 04          	mov    %eax,0x4(%esp)
 17d:	e8 8e 0a 00 00       	call   c10 <printf>
    printf(1, "\tretime: %d\n", performance->retime);
 182:	8b 43 0c             	mov    0xc(%ebx),%eax
 185:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 18c:	89 44 24 08          	mov    %eax,0x8(%esp)
 190:	b8 7b 10 00 00       	mov    $0x107b,%eax
 195:	89 44 24 04          	mov    %eax,0x4(%esp)
 199:	e8 72 0a 00 00       	call   c10 <printf>
    printf(1, "\trutime: %d\n", performance->rutime);
 19e:	8b 43 10             	mov    0x10(%ebx),%eax
 1a1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1a8:	89 44 24 08          	mov    %eax,0x8(%esp)
 1ac:	b8 88 10 00 00       	mov    $0x1088,%eax
 1b1:	89 44 24 04          	mov    %eax,0x4(%esp)
 1b5:	e8 56 0a 00 00       	call   c10 <printf>
    printf(1, "\n\tTurnaround time: %d\n", (performance->ttime - performance->ctime));
 1ba:	8b 43 04             	mov    0x4(%ebx),%eax
 1bd:	b9 95 10 00 00       	mov    $0x1095,%ecx
 1c2:	8b 13                	mov    (%ebx),%edx
 1c4:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 1c8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1cf:	29 d0                	sub    %edx,%eax
 1d1:	89 44 24 08          	mov    %eax,0x8(%esp)
 1d5:	e8 36 0a 00 00       	call   c10 <printf>
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
 2b0:	e8 eb 07 00 00       	call   aa0 <fork>
        if (pid > 0) {
 2b5:	85 c0                	test   %eax,%eax
 2b7:	7e 57                	jle    310 <test_exit_wait+0x80>
            wait(&status);
 2b9:	89 3c 24             	mov    %edi,(%esp)
 2bc:	e8 ef 07 00 00       	call   ab0 <wait>
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
 2d5:	ba f0 0f 00 00       	mov    $0xff0,%edx
 2da:	b8 ac 10 00 00       	mov    $0x10ac,%eax
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
 2f4:	e8 17 09 00 00       	call   c10 <printf>

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
 317:	e8 1c 08 00 00       	call   b38 <sleep>
            exit(i);
 31c:	89 1c 24             	mov    %ebx,(%esp)
 31f:	e8 84 07 00 00       	call   aa8 <exit>
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
 338:	e8 63 07 00 00       	call   aa0 <fork>
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
 34f:	e8 fc 07 00 00       	call   b50 <detach>
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
 35f:	e8 ec 07 00 00       	call   b50 <detach>
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
 372:	b8 f0 0f 00 00       	mov    $0xff0,%eax
 377:	be c7 10 00 00       	mov    $0x10c7,%esi
 37c:	89 44 24 04          	mov    %eax,0x4(%esp)
 380:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
 384:	89 74 24 08          	mov    %esi,0x8(%esp)
 388:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 38f:	e8 7c 08 00 00       	call   c10 <printf>
        result1 = assert_equals(0, status1, "detach - status1");

        status2 = detach(pid);
        result2 = assert_equals(-1, status2, "detach - status2");

        status3 = detach(-10);
 394:	c7 04 24 f6 ff ff ff 	movl   $0xfffffff6,(%esp)
 39b:	e8 b0 07 00 00       	call   b50 <detach>
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
 3b7:	e8 94 07 00 00       	call   b50 <detach>
        printf(1, "========== Test - %s: Failed ==========\n", name);
    }
}

boolean assert_equals(int expected, int actual, char *msg) {
    if (expected != actual) {
 3bc:	83 f8 ff             	cmp    $0xffffffff,%eax
 3bf:	74 5f                	je     420 <test_detach+0xf0>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
 3c1:	89 44 24 10          	mov    %eax,0x10(%esp)
 3c5:	ba d8 10 00 00       	mov    $0x10d8,%edx
 3ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 3cf:	b9 f0 0f 00 00       	mov    $0xff0,%ecx
 3d4:	89 44 24 0c          	mov    %eax,0xc(%esp)
 3d8:	89 54 24 08          	mov    %edx,0x8(%esp)
 3dc:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 3e0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 3e7:	e8 24 08 00 00       	call   c10 <printf>
 3ec:	eb b7                	jmp    3a5 <test_detach+0x75>
 3ee:	66 90                	xchg   %ax,%ax
 3f0:	89 44 24 10          	mov    %eax,0x10(%esp)
 3f4:	31 c0                	xor    %eax,%eax
 3f6:	31 db                	xor    %ebx,%ebx
 3f8:	89 44 24 0c          	mov    %eax,0xc(%esp)
 3fc:	b8 b6 10 00 00       	mov    $0x10b6,%eax
 401:	89 44 24 08          	mov    %eax,0x8(%esp)
 405:	b8 f0 0f 00 00       	mov    $0xff0,%eax
 40a:	89 44 24 04          	mov    %eax,0x4(%esp)
 40e:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 415:	e8 f6 07 00 00       	call   c10 <printf>
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
 43e:	e8 f5 06 00 00       	call   b38 <sleep>
        exit(0);
 443:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 44a:	e8 59 06 00 00       	call   aa8 <exit>
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
 460:	e8 3b 06 00 00       	call   aa0 <fork>
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
 486:	e8 25 06 00 00       	call   ab0 <wait>
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
 49f:	ba e9 10 00 00       	mov    $0x10e9,%edx
 4a4:	31 c0                	xor    %eax,%eax
 4a6:	b9 f0 0f 00 00       	mov    $0xff0,%ecx
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
 4c0:	e8 4b 07 00 00       	call   c10 <printf>
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
 4fb:	e8 58 06 00 00       	call   b58 <priority>
                }
            }
            sleep(10);
 500:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
 507:	e8 2c 06 00 00       	call   b38 <sleep>
            exit(0);
 50c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 513:	e8 90 05 00 00       	call   aa8 <exit>
        if (pid < 0) {
            break;
        } else if (pid == 0) {
            if (priority_mod) {
                if ((i % *(priority_mod)) == 0 && policy == PRIORITY) {
                    priority(1);
 518:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 51f:	e8 34 06 00 00       	call   b58 <priority>
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
 565:	e8 de 05 00 00       	call   b48 <policy>
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
 587:	e8 bc 05 00 00       	call   b48 <policy>
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
 5b5:	e8 8e 05 00 00       	call   b48 <policy>
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
 5d7:	e8 6c 05 00 00       	call   b48 <policy>
    return result;
}
 5dc:	83 c4 24             	add    $0x24,%esp
 5df:	89 d8                	mov    %ebx,%eax
 5e1:	5b                   	pop    %ebx
 5e2:	5d                   	pop    %ebp
 5e3:	c3                   	ret    
 5e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000005f0 <wait_stat>:
boolean  wait_stat( int * stat , struct perf *p)
{
 5f0:	55                   	push   %ebp
    return true;
}
 5f1:	b8 01 00 00 00       	mov    $0x1,%eax

    policy(ROUND_ROBIN);
    return result;
}
boolean  wait_stat( int * stat , struct perf *p)
{
 5f6:	89 e5                	mov    %esp,%ebp
    return true;
}
 5f8:	5d                   	pop    %ebp
 5f9:	c3                   	ret    
 5fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000600 <test_performance_helper>:
boolean test_performance_helper(int *npriority) {
 600:	55                   	push   %ebp
 601:	89 e5                	mov    %esp,%ebp
 603:	53                   	push   %ebx
 604:	83 ec 34             	sub    $0x34,%esp
    int pid1;
    struct perf perf2;
    pid1 = fork();
 607:	e8 94 04 00 00       	call   aa0 <fork>
    if (pid1 > 0) {
 60c:	85 c0                	test   %eax,%eax
 60e:	7f 34                	jg     644 <test_performance_helper+0x44>
 610:	bb 64 00 00 00       	mov    $0x64,%ebx
 615:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    } else {
        for (int a = 0; a < 100; ++a) {
            int pid;
            struct perf perf1;

            pid = fork();
 620:	e8 7b 04 00 00       	call   aa0 <fork>
            // the child pid is pid
            if (pid > 0) {
 625:	85 c0                	test   %eax,%eax
 627:	7e 31                	jle    65a <test_performance_helper+0x5a>
                int status;
                sleep(5);
 629:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 630:	e8 03 05 00 00       	call   b38 <sleep>
    if (pid1 > 0) {
        int status1;
        wait_stat(&status1, &perf2);
        print_perf(&perf2);
    } else {
        for (int a = 0; a < 100; ++a) {
 635:	4b                   	dec    %ebx
 636:	75 e8                	jne    620 <test_performance_helper+0x20>
                }
                sleep(5);
                exit(0);
            }
        }
        exit(0);
 638:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 63f:	e8 64 04 00 00       	call   aa8 <exit>
    struct perf perf2;
    pid1 = fork();
    if (pid1 > 0) {
        int status1;
        wait_stat(&status1, &perf2);
        print_perf(&perf2);
 644:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 647:	89 04 24             	mov    %eax,(%esp)
 64a:	e8 c1 fa ff ff       	call   110 <print_perf>
            }
        }
        exit(0);
    }
    return true;
}
 64f:	83 c4 34             	add    $0x34,%esp
 652:	b8 01 00 00 00       	mov    $0x1,%eax
 657:	5b                   	pop    %ebx
 658:	5d                   	pop    %ebp
 659:	c3                   	ret    
            if (pid > 0) {
                int status;
                sleep(5);
                wait_stat(&status, &perf1);
            } else {
                if (npriority)
 65a:	8b 45 08             	mov    0x8(%ebp),%eax
 65d:	85 c0                	test   %eax,%eax
 65f:	74 0d                	je     66e <test_performance_helper+0x6e>
                    priority(*npriority);
 661:	8b 45 08             	mov    0x8(%ebp),%eax
 664:	8b 00                	mov    (%eax),%eax
 666:	89 04 24             	mov    %eax,(%esp)
 669:	e8 ea 04 00 00       	call   b58 <priority>
                for (int i = 0; i < 100000000; ++i) {
                    for (int j = 0; j < 100000000; ++j) {
                        ++sum;
                    }
                }
                sleep(5);
 66e:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 675:	e8 be 04 00 00       	call   b38 <sleep>
                exit(0);
 67a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 681:	e8 22 04 00 00       	call   aa8 <exit>
 686:	8d 76 00             	lea    0x0(%esi),%esi
 689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000690 <test_starvation_helper>:
    }
    return true;
}


boolean test_starvation_helper(int npolicy, int npriority) {
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	57                   	push   %edi
 694:	56                   	push   %esi
    boolean result = true;
    policy(npolicy);
    int nProcs = 10;
    int pid_arr[nProcs];
    int pid;
    memset(&pid_arr, 0, nProcs * sizeof(int));
 695:	31 f6                	xor    %esi,%esi
    }
    return true;
}


boolean test_starvation_helper(int npolicy, int npriority) {
 697:	53                   	push   %ebx
    boolean result = true;
    policy(npolicy);
    int nProcs = 10;
    int pid_arr[nProcs];
    int pid;
    memset(&pid_arr, 0, nProcs * sizeof(int));
 698:	bb 28 00 00 00       	mov    $0x28,%ebx
    }
    return true;
}


boolean test_starvation_helper(int npolicy, int npriority) {
 69d:	83 ec 5c             	sub    $0x5c,%esp
    boolean result = true;
    policy(npolicy);
 6a0:	8b 45 08             	mov    0x8(%ebp),%eax
 6a3:	89 04 24             	mov    %eax,(%esp)
 6a6:	e8 9d 04 00 00       	call   b48 <policy>
    int nProcs = 10;
    int pid_arr[nProcs];
    int pid;
    memset(&pid_arr, 0, nProcs * sizeof(int));
 6ab:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 6af:	8d 5d c0             	lea    -0x40(%ebp),%ebx
 6b2:	89 74 24 04          	mov    %esi,0x4(%esp)
    for (int i = 0; i < nProcs; ++i) {
 6b6:	31 f6                	xor    %esi,%esi
    boolean result = true;
    policy(npolicy);
    int nProcs = 10;
    int pid_arr[nProcs];
    int pid;
    memset(&pid_arr, 0, nProcs * sizeof(int));
 6b8:	89 1c 24             	mov    %ebx,(%esp)
 6bb:	e8 40 02 00 00       	call   900 <memset>
    for (int i = 0; i < nProcs; ++i) {
        pid = fork();
 6c0:	e8 db 03 00 00       	call   aa0 <fork>
        if (pid < 0) {
 6c5:	85 c0                	test   %eax,%eax
 6c7:	78 0f                	js     6d8 <test_starvation_helper+0x48>
            break;
        } else if (pid == 0) {
 6c9:	0f 84 a1 00 00 00    	je     770 <test_starvation_helper+0xe0>
            sleep(5);
            priority(npriority);
            for (;;) {};
        } else {
            pid_arr[i] = pid;
 6cf:	89 04 b3             	mov    %eax,(%ebx,%esi,4)
    policy(npolicy);
    int nProcs = 10;
    int pid_arr[nProcs];
    int pid;
    memset(&pid_arr, 0, nProcs * sizeof(int));
    for (int i = 0; i < nProcs; ++i) {
 6d2:	46                   	inc    %esi
 6d3:	83 fe 0a             	cmp    $0xa,%esi
 6d6:	75 e8                	jne    6c0 <test_starvation_helper+0x30>
            for (;;) {};
        } else {
            pid_arr[i] = pid;
        }
    }
    sleep(100);
 6d8:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 6df:	8d 7d e8             	lea    -0x18(%ebp),%edi
    return true;
}


boolean test_starvation_helper(int npolicy, int npriority) {
    boolean result = true;
 6e2:	be 01 00 00 00       	mov    $0x1,%esi
            for (;;) {};
        } else {
            pid_arr[i] = pid;
        }
    }
    sleep(100);
 6e7:	e8 4c 04 00 00       	call   b38 <sleep>
 6ec:	eb 15                	jmp    703 <test_starvation_helper+0x73>
 6ee:	66 90                	xchg   %ax,%ax
    for (int j = 0; j < nProcs; ++j) {
        if (pid_arr[j] != 0) {
            result = result && assert_equals(0, kill(pid_arr[j]), "failed to kill child (yes it does sound horrible)");
            wait(null);
 6f0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 6f7:	e8 b4 03 00 00       	call   ab0 <wait>
 6fc:	83 c3 04             	add    $0x4,%ebx
        } else {
            pid_arr[i] = pid;
        }
    }
    sleep(100);
    for (int j = 0; j < nProcs; ++j) {
 6ff:	39 df                	cmp    %ebx,%edi
 701:	74 4d                	je     750 <test_starvation_helper+0xc0>
        if (pid_arr[j] != 0) {
 703:	8b 03                	mov    (%ebx),%eax
 705:	85 c0                	test   %eax,%eax
 707:	74 f3                	je     6fc <test_starvation_helper+0x6c>
            result = result && assert_equals(0, kill(pid_arr[j]), "failed to kill child (yes it does sound horrible)");
 709:	85 f6                	test   %esi,%esi
 70b:	74 e3                	je     6f0 <test_starvation_helper+0x60>
 70d:	89 04 24             	mov    %eax,(%esp)
 710:	be 01 00 00 00       	mov    $0x1,%esi
 715:	e8 be 03 00 00       	call   ad8 <kill>
        printf(1, "========== Test - %s: Failed ==========\n", name);
    }
}

boolean assert_equals(int expected, int actual, char *msg) {
    if (expected != actual) {
 71a:	85 c0                	test   %eax,%eax
 71c:	74 d2                	je     6f0 <test_starvation_helper+0x60>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
 71e:	89 44 24 10          	mov    %eax,0x10(%esp)
 722:	ba 1c 10 00 00       	mov    $0x101c,%edx
 727:	31 c0                	xor    %eax,%eax
 729:	b9 f0 0f 00 00       	mov    $0xff0,%ecx
        }
    }
    sleep(100);
    for (int j = 0; j < nProcs; ++j) {
        if (pid_arr[j] != 0) {
            result = result && assert_equals(0, kill(pid_arr[j]), "failed to kill child (yes it does sound horrible)");
 72e:	31 f6                	xor    %esi,%esi
    }
}

boolean assert_equals(int expected, int actual, char *msg) {
    if (expected != actual) {
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
 730:	89 44 24 0c          	mov    %eax,0xc(%esp)
 734:	89 54 24 08          	mov    %edx,0x8(%esp)
 738:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 73c:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 743:	e8 c8 04 00 00       	call   c10 <printf>
 748:	eb a6                	jmp    6f0 <test_starvation_helper+0x60>
 74a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        if (pid_arr[j] != 0) {
            result = result && assert_equals(0, kill(pid_arr[j]), "failed to kill child (yes it does sound horrible)");
            wait(null);
        }
    }
    policy(ROUND_ROBIN);
 750:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 757:	e8 ec 03 00 00       	call   b48 <policy>
    return result;
}
 75c:	83 c4 5c             	add    $0x5c,%esp
 75f:	89 f0                	mov    %esi,%eax
 761:	5b                   	pop    %ebx
 762:	5e                   	pop    %esi
 763:	5f                   	pop    %edi
 764:	5d                   	pop    %ebp
 765:	c3                   	ret    
 766:	8d 76 00             	lea    0x0(%esi),%esi
 769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    for (int i = 0; i < nProcs; ++i) {
        pid = fork();
        if (pid < 0) {
            break;
        } else if (pid == 0) {
            sleep(5);
 770:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 777:	e8 bc 03 00 00       	call   b38 <sleep>
            priority(npriority);
 77c:	8b 45 0c             	mov    0xc(%ebp),%eax
 77f:	89 04 24             	mov    %eax,(%esp)
 782:	e8 d1 03 00 00       	call   b58 <priority>
 787:	eb fe                	jmp    787 <test_starvation_helper+0xf7>
 789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000790 <test_accumulator>:
}

/**
 * test the growth of accumulator
 */
boolean test_accumulator() {
 790:	55                   	push   %ebp
    return test_starvation_helper(PRIORITY, 2);
 791:	b8 02 00 00 00       	mov    $0x2,%eax
}

/**
 * test the growth of accumulator
 */
boolean test_accumulator() {
 796:	89 e5                	mov    %esp,%ebp
 798:	83 ec 18             	sub    $0x18,%esp
    return test_starvation_helper(PRIORITY, 2);
 79b:	89 44 24 04          	mov    %eax,0x4(%esp)
 79f:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 7a6:	e8 e5 fe ff ff       	call   690 <test_starvation_helper>
}
 7ab:	c9                   	leave  
 7ac:	c3                   	ret    
 7ad:	8d 76 00             	lea    0x0(%esi),%esi

000007b0 <test_starvation>:

/** I hope this does test the case of
   starvation in extended priority
   (where the priority is 0)
*/
boolean test_starvation() {
 7b0:	55                   	push   %ebp
    return test_starvation_helper(EXTENED_PRIORITY, 0);
 7b1:	31 c0                	xor    %eax,%eax

/** I hope this does test the case of
   starvation in extended priority
   (where the priority is 0)
*/
boolean test_starvation() {
 7b3:	89 e5                	mov    %esp,%ebp
 7b5:	83 ec 18             	sub    $0x18,%esp
    return test_starvation_helper(EXTENED_PRIORITY, 0);
 7b8:	89 44 24 04          	mov    %eax,0x4(%esp)
 7bc:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
 7c3:	e8 c8 fe ff ff       	call   690 <test_starvation_helper>
}
 7c8:	c9                   	leave  
 7c9:	c3                   	ret    
 7ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000007d0 <test_performance_round_robin>:


boolean test_performance_round_robin() {
 7d0:	55                   	push   %ebp
 7d1:	89 e5                	mov    %esp,%ebp
 7d3:	83 ec 18             	sub    $0x18,%esp
    return test_performance_helper(null);
 7d6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 7dd:	e8 1e fe ff ff       	call   600 <test_performance_helper>
}
 7e2:	c9                   	leave  
 7e3:	c3                   	ret    
 7e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 7ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000007f0 <test_performance_priority>:

boolean test_performance_priority() {
 7f0:	55                   	push   %ebp
 7f1:	89 e5                	mov    %esp,%ebp
 7f3:	53                   	push   %ebx
 7f4:	83 ec 24             	sub    $0x24,%esp
    policy(PRIORITY);
 7f7:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 7fe:	e8 45 03 00 00       	call   b48 <policy>
    int npriority = 2;
    boolean result = test_performance_helper(&npriority);
 803:	8d 45 f4             	lea    -0xc(%ebp),%eax
 806:	89 04 24             	mov    %eax,(%esp)
    return test_performance_helper(null);
}

boolean test_performance_priority() {
    policy(PRIORITY);
    int npriority = 2;
 809:	c7 45 f4 02 00 00 00 	movl   $0x2,-0xc(%ebp)
    boolean result = test_performance_helper(&npriority);
 810:	e8 eb fd ff ff       	call   600 <test_performance_helper>
    policy(ROUND_ROBIN);
 815:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
}

boolean test_performance_priority() {
    policy(PRIORITY);
    int npriority = 2;
    boolean result = test_performance_helper(&npriority);
 81c:	89 c3                	mov    %eax,%ebx
    policy(ROUND_ROBIN);
 81e:	e8 25 03 00 00       	call   b48 <policy>
    return result;

}
 823:	83 c4 24             	add    $0x24,%esp
 826:	89 d8                	mov    %ebx,%eax
 828:	5b                   	pop    %ebx
 829:	5d                   	pop    %ebp
 82a:	c3                   	ret    
 82b:	90                   	nop
 82c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000830 <test_performance_extended_priority>:

boolean test_performance_extended_priority() {
 830:	55                   	push   %ebp
 831:	89 e5                	mov    %esp,%ebp
 833:	53                   	push   %ebx
 834:	83 ec 24             	sub    $0x24,%esp
    policy(EXTENED_PRIORITY);
 837:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
 83e:	e8 05 03 00 00       	call   b48 <policy>
    int npriority = 0;
    boolean result = test_performance_helper(&npriority);
 843:	8d 45 f4             	lea    -0xc(%ebp),%eax
 846:	89 04 24             	mov    %eax,(%esp)

}

boolean test_performance_extended_priority() {
    policy(EXTENED_PRIORITY);
    int npriority = 0;
 849:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    boolean result = test_performance_helper(&npriority);
 850:	e8 ab fd ff ff       	call   600 <test_performance_helper>
    policy(ROUND_ROBIN);
 855:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
}

boolean test_performance_extended_priority() {
    policy(EXTENED_PRIORITY);
    int npriority = 0;
    boolean result = test_performance_helper(&npriority);
 85c:	89 c3                	mov    %eax,%ebx
    policy(ROUND_ROBIN);
 85e:	e8 e5 02 00 00       	call   b48 <policy>
    return result;

}
 863:	83 c4 24             	add    $0x24,%esp
 866:	89 d8                	mov    %ebx,%eax
 868:	5b                   	pop    %ebx
 869:	5d                   	pop    %ebp
 86a:	c3                   	ret    
 86b:	66 90                	xchg   %ax,%ax
 86d:	66 90                	xchg   %ax,%ax
 86f:	90                   	nop

00000870 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 870:	55                   	push   %ebp
 871:	89 e5                	mov    %esp,%ebp
 873:	8b 45 08             	mov    0x8(%ebp),%eax
 876:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 879:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 87a:	89 c2                	mov    %eax,%edx
 87c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 880:	41                   	inc    %ecx
 881:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 885:	42                   	inc    %edx
 886:	84 db                	test   %bl,%bl
 888:	88 5a ff             	mov    %bl,-0x1(%edx)
 88b:	75 f3                	jne    880 <strcpy+0x10>
    ;
  return os;
}
 88d:	5b                   	pop    %ebx
 88e:	5d                   	pop    %ebp
 88f:	c3                   	ret    

00000890 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 890:	55                   	push   %ebp
 891:	89 e5                	mov    %esp,%ebp
 893:	8b 4d 08             	mov    0x8(%ebp),%ecx
 896:	56                   	push   %esi
 897:	53                   	push   %ebx
 898:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 89b:	0f b6 01             	movzbl (%ecx),%eax
 89e:	0f b6 13             	movzbl (%ebx),%edx
 8a1:	84 c0                	test   %al,%al
 8a3:	75 1c                	jne    8c1 <strcmp+0x31>
 8a5:	eb 29                	jmp    8d0 <strcmp+0x40>
 8a7:	89 f6                	mov    %esi,%esi
 8a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 8b0:	41                   	inc    %ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 8b1:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 8b4:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 8b7:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 8bb:	84 c0                	test   %al,%al
 8bd:	74 11                	je     8d0 <strcmp+0x40>
 8bf:	89 f3                	mov    %esi,%ebx
 8c1:	38 d0                	cmp    %dl,%al
 8c3:	74 eb                	je     8b0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 8c5:	5b                   	pop    %ebx
int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    p++, q++;
  return (uchar)*p - (uchar)*q;
 8c6:	29 d0                	sub    %edx,%eax
}
 8c8:	5e                   	pop    %esi
 8c9:	5d                   	pop    %ebp
 8ca:	c3                   	ret    
 8cb:	90                   	nop
 8cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 8d0:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 8d1:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 8d3:	29 d0                	sub    %edx,%eax
}
 8d5:	5e                   	pop    %esi
 8d6:	5d                   	pop    %ebp
 8d7:	c3                   	ret    
 8d8:	90                   	nop
 8d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008e0 <strlen>:

uint
strlen(const char *s)
{
 8e0:	55                   	push   %ebp
 8e1:	89 e5                	mov    %esp,%ebp
 8e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 8e6:	80 39 00             	cmpb   $0x0,(%ecx)
 8e9:	74 10                	je     8fb <strlen+0x1b>
 8eb:	31 d2                	xor    %edx,%edx
 8ed:	8d 76 00             	lea    0x0(%esi),%esi
 8f0:	42                   	inc    %edx
 8f1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 8f5:	89 d0                	mov    %edx,%eax
 8f7:	75 f7                	jne    8f0 <strlen+0x10>
    ;
  return n;
}
 8f9:	5d                   	pop    %ebp
 8fa:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 8fb:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 8fd:	5d                   	pop    %ebp
 8fe:	c3                   	ret    
 8ff:	90                   	nop

00000900 <memset>:

void*
memset(void *dst, int c, uint n)
{
 900:	55                   	push   %ebp
 901:	89 e5                	mov    %esp,%ebp
 903:	8b 55 08             	mov    0x8(%ebp),%edx
 906:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 907:	8b 4d 10             	mov    0x10(%ebp),%ecx
 90a:	8b 45 0c             	mov    0xc(%ebp),%eax
 90d:	89 d7                	mov    %edx,%edi
 90f:	fc                   	cld    
 910:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 912:	5f                   	pop    %edi
 913:	89 d0                	mov    %edx,%eax
 915:	5d                   	pop    %ebp
 916:	c3                   	ret    
 917:	89 f6                	mov    %esi,%esi
 919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000920 <strchr>:

char*
strchr(const char *s, char c)
{
 920:	55                   	push   %ebp
 921:	89 e5                	mov    %esp,%ebp
 923:	8b 45 08             	mov    0x8(%ebp),%eax
 926:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 92a:	0f b6 10             	movzbl (%eax),%edx
 92d:	84 d2                	test   %dl,%dl
 92f:	74 1b                	je     94c <strchr+0x2c>
    if(*s == c)
 931:	38 d1                	cmp    %dl,%cl
 933:	75 0f                	jne    944 <strchr+0x24>
 935:	eb 17                	jmp    94e <strchr+0x2e>
 937:	89 f6                	mov    %esi,%esi
 939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 940:	38 ca                	cmp    %cl,%dl
 942:	74 0a                	je     94e <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 944:	40                   	inc    %eax
 945:	0f b6 10             	movzbl (%eax),%edx
 948:	84 d2                	test   %dl,%dl
 94a:	75 f4                	jne    940 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 94c:	31 c0                	xor    %eax,%eax
}
 94e:	5d                   	pop    %ebp
 94f:	c3                   	ret    

00000950 <gets>:

char*
gets(char *buf, int max)
{
 950:	55                   	push   %ebp
 951:	89 e5                	mov    %esp,%ebp
 953:	57                   	push   %edi
 954:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 955:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
 957:	53                   	push   %ebx
 958:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 95b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 95e:	eb 32                	jmp    992 <gets+0x42>
    cc = read(0, &c, 1);
 960:	b8 01 00 00 00       	mov    $0x1,%eax
 965:	89 44 24 08          	mov    %eax,0x8(%esp)
 969:	89 7c 24 04          	mov    %edi,0x4(%esp)
 96d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 974:	e8 47 01 00 00       	call   ac0 <read>
    if(cc < 1)
 979:	85 c0                	test   %eax,%eax
 97b:	7e 1d                	jle    99a <gets+0x4a>
      break;
    buf[i++] = c;
 97d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 981:	89 de                	mov    %ebx,%esi
 983:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 986:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 988:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 98c:	74 22                	je     9b0 <gets+0x60>
 98e:	3c 0d                	cmp    $0xd,%al
 990:	74 1e                	je     9b0 <gets+0x60>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 992:	8d 5e 01             	lea    0x1(%esi),%ebx
 995:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 998:	7c c6                	jl     960 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 99a:	8b 45 08             	mov    0x8(%ebp),%eax
 99d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 9a1:	83 c4 2c             	add    $0x2c,%esp
 9a4:	5b                   	pop    %ebx
 9a5:	5e                   	pop    %esi
 9a6:	5f                   	pop    %edi
 9a7:	5d                   	pop    %ebp
 9a8:	c3                   	ret    
 9a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 9b0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 9b3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 9b5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 9b9:	83 c4 2c             	add    $0x2c,%esp
 9bc:	5b                   	pop    %ebx
 9bd:	5e                   	pop    %esi
 9be:	5f                   	pop    %edi
 9bf:	5d                   	pop    %ebp
 9c0:	c3                   	ret    
 9c1:	eb 0d                	jmp    9d0 <stat>
 9c3:	90                   	nop
 9c4:	90                   	nop
 9c5:	90                   	nop
 9c6:	90                   	nop
 9c7:	90                   	nop
 9c8:	90                   	nop
 9c9:	90                   	nop
 9ca:	90                   	nop
 9cb:	90                   	nop
 9cc:	90                   	nop
 9cd:	90                   	nop
 9ce:	90                   	nop
 9cf:	90                   	nop

000009d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 9d0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 9d1:	31 c0                	xor    %eax,%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 9d3:	89 e5                	mov    %esp,%ebp
 9d5:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 9d8:	89 44 24 04          	mov    %eax,0x4(%esp)
 9dc:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 9df:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 9e2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 9e5:	89 04 24             	mov    %eax,(%esp)
 9e8:	e8 fb 00 00 00       	call   ae8 <open>
  if(fd < 0)
 9ed:	85 c0                	test   %eax,%eax
 9ef:	78 2f                	js     a20 <stat+0x50>
 9f1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 9f3:	8b 45 0c             	mov    0xc(%ebp),%eax
 9f6:	89 1c 24             	mov    %ebx,(%esp)
 9f9:	89 44 24 04          	mov    %eax,0x4(%esp)
 9fd:	e8 fe 00 00 00       	call   b00 <fstat>
  close(fd);
 a02:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 a05:	89 c6                	mov    %eax,%esi
  close(fd);
 a07:	e8 c4 00 00 00       	call   ad0 <close>
  return r;
 a0c:	89 f0                	mov    %esi,%eax
}
 a0e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 a11:	8b 75 fc             	mov    -0x4(%ebp),%esi
 a14:	89 ec                	mov    %ebp,%esp
 a16:	5d                   	pop    %ebp
 a17:	c3                   	ret    
 a18:	90                   	nop
 a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 a20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a25:	eb e7                	jmp    a0e <stat+0x3e>
 a27:	89 f6                	mov    %esi,%esi
 a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a30 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 a30:	55                   	push   %ebp
 a31:	89 e5                	mov    %esp,%ebp
 a33:	8b 4d 08             	mov    0x8(%ebp),%ecx
 a36:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 a37:	0f be 11             	movsbl (%ecx),%edx
 a3a:	88 d0                	mov    %dl,%al
 a3c:	2c 30                	sub    $0x30,%al
 a3e:	3c 09                	cmp    $0x9,%al
 a40:	b8 00 00 00 00       	mov    $0x0,%eax
 a45:	77 1e                	ja     a65 <atoi+0x35>
 a47:	89 f6                	mov    %esi,%esi
 a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 a50:	41                   	inc    %ecx
 a51:	8d 04 80             	lea    (%eax,%eax,4),%eax
 a54:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 a58:	0f be 11             	movsbl (%ecx),%edx
 a5b:	88 d3                	mov    %dl,%bl
 a5d:	80 eb 30             	sub    $0x30,%bl
 a60:	80 fb 09             	cmp    $0x9,%bl
 a63:	76 eb                	jbe    a50 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 a65:	5b                   	pop    %ebx
 a66:	5d                   	pop    %ebp
 a67:	c3                   	ret    
 a68:	90                   	nop
 a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000a70 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 a70:	55                   	push   %ebp
 a71:	89 e5                	mov    %esp,%ebp
 a73:	56                   	push   %esi
 a74:	8b 45 08             	mov    0x8(%ebp),%eax
 a77:	53                   	push   %ebx
 a78:	8b 5d 10             	mov    0x10(%ebp),%ebx
 a7b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 a7e:	85 db                	test   %ebx,%ebx
 a80:	7e 1a                	jle    a9c <memmove+0x2c>
 a82:	31 d2                	xor    %edx,%edx
 a84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 a8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 a90:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 a94:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 a97:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 a98:	39 da                	cmp    %ebx,%edx
 a9a:	75 f4                	jne    a90 <memmove+0x20>
    *dst++ = *src++;
  return vdst;
}
 a9c:	5b                   	pop    %ebx
 a9d:	5e                   	pop    %esi
 a9e:	5d                   	pop    %ebp
 a9f:	c3                   	ret    

00000aa0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 aa0:	b8 01 00 00 00       	mov    $0x1,%eax
 aa5:	cd 40                	int    $0x40
 aa7:	c3                   	ret    

00000aa8 <exit>:
SYSCALL(exit)
 aa8:	b8 02 00 00 00       	mov    $0x2,%eax
 aad:	cd 40                	int    $0x40
 aaf:	c3                   	ret    

00000ab0 <wait>:
SYSCALL(wait)
 ab0:	b8 03 00 00 00       	mov    $0x3,%eax
 ab5:	cd 40                	int    $0x40
 ab7:	c3                   	ret    

00000ab8 <pipe>:
SYSCALL(pipe)
 ab8:	b8 04 00 00 00       	mov    $0x4,%eax
 abd:	cd 40                	int    $0x40
 abf:	c3                   	ret    

00000ac0 <read>:
SYSCALL(read)
 ac0:	b8 05 00 00 00       	mov    $0x5,%eax
 ac5:	cd 40                	int    $0x40
 ac7:	c3                   	ret    

00000ac8 <write>:
SYSCALL(write)
 ac8:	b8 10 00 00 00       	mov    $0x10,%eax
 acd:	cd 40                	int    $0x40
 acf:	c3                   	ret    

00000ad0 <close>:
SYSCALL(close)
 ad0:	b8 15 00 00 00       	mov    $0x15,%eax
 ad5:	cd 40                	int    $0x40
 ad7:	c3                   	ret    

00000ad8 <kill>:
SYSCALL(kill)
 ad8:	b8 06 00 00 00       	mov    $0x6,%eax
 add:	cd 40                	int    $0x40
 adf:	c3                   	ret    

00000ae0 <exec>:
SYSCALL(exec)
 ae0:	b8 07 00 00 00       	mov    $0x7,%eax
 ae5:	cd 40                	int    $0x40
 ae7:	c3                   	ret    

00000ae8 <open>:
SYSCALL(open)
 ae8:	b8 0f 00 00 00       	mov    $0xf,%eax
 aed:	cd 40                	int    $0x40
 aef:	c3                   	ret    

00000af0 <mknod>:
SYSCALL(mknod)
 af0:	b8 11 00 00 00       	mov    $0x11,%eax
 af5:	cd 40                	int    $0x40
 af7:	c3                   	ret    

00000af8 <unlink>:
SYSCALL(unlink)
 af8:	b8 12 00 00 00       	mov    $0x12,%eax
 afd:	cd 40                	int    $0x40
 aff:	c3                   	ret    

00000b00 <fstat>:
SYSCALL(fstat)
 b00:	b8 08 00 00 00       	mov    $0x8,%eax
 b05:	cd 40                	int    $0x40
 b07:	c3                   	ret    

00000b08 <link>:
SYSCALL(link)
 b08:	b8 13 00 00 00       	mov    $0x13,%eax
 b0d:	cd 40                	int    $0x40
 b0f:	c3                   	ret    

00000b10 <mkdir>:
SYSCALL(mkdir)
 b10:	b8 14 00 00 00       	mov    $0x14,%eax
 b15:	cd 40                	int    $0x40
 b17:	c3                   	ret    

00000b18 <chdir>:
SYSCALL(chdir)
 b18:	b8 09 00 00 00       	mov    $0x9,%eax
 b1d:	cd 40                	int    $0x40
 b1f:	c3                   	ret    

00000b20 <dup>:
SYSCALL(dup)
 b20:	b8 0a 00 00 00       	mov    $0xa,%eax
 b25:	cd 40                	int    $0x40
 b27:	c3                   	ret    

00000b28 <getpid>:
SYSCALL(getpid)
 b28:	b8 0b 00 00 00       	mov    $0xb,%eax
 b2d:	cd 40                	int    $0x40
 b2f:	c3                   	ret    

00000b30 <sbrk>:
SYSCALL(sbrk)
 b30:	b8 0c 00 00 00       	mov    $0xc,%eax
 b35:	cd 40                	int    $0x40
 b37:	c3                   	ret    

00000b38 <sleep>:
SYSCALL(sleep)
 b38:	b8 0d 00 00 00       	mov    $0xd,%eax
 b3d:	cd 40                	int    $0x40
 b3f:	c3                   	ret    

00000b40 <uptime>:
SYSCALL(uptime)
 b40:	b8 0e 00 00 00       	mov    $0xe,%eax
 b45:	cd 40                	int    $0x40
 b47:	c3                   	ret    

00000b48 <policy>:
SYSCALL(policy)
 b48:	b8 17 00 00 00       	mov    $0x17,%eax
 b4d:	cd 40                	int    $0x40
 b4f:	c3                   	ret    

00000b50 <detach>:
SYSCALL(detach)
 b50:	b8 16 00 00 00       	mov    $0x16,%eax
 b55:	cd 40                	int    $0x40
 b57:	c3                   	ret    

00000b58 <priority>:
SYSCALL(priority)
 b58:	b8 18 00 00 00       	mov    $0x18,%eax
 b5d:	cd 40                	int    $0x40
 b5f:	c3                   	ret    

00000b60 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 b60:	55                   	push   %ebp
 b61:	89 e5                	mov    %esp,%ebp
 b63:	57                   	push   %edi
 b64:	56                   	push   %esi
 b65:	89 c6                	mov    %eax,%esi
 b67:	53                   	push   %ebx
 b68:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 b6b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 b6e:	85 db                	test   %ebx,%ebx
 b70:	0f 84 8a 00 00 00    	je     c00 <printint+0xa0>
 b76:	89 d0                	mov    %edx,%eax
 b78:	c1 e8 1f             	shr    $0x1f,%eax
 b7b:	84 c0                	test   %al,%al
 b7d:	0f 84 7d 00 00 00    	je     c00 <printint+0xa0>
    neg = 1;
    x = -xx;
 b83:	89 d0                	mov    %edx,%eax
 b85:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 b87:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 b8e:	89 75 c0             	mov    %esi,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 b91:	31 ff                	xor    %edi,%edi
 b93:	89 ce                	mov    %ecx,%esi
 b95:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 b98:	eb 08                	jmp    ba2 <printint+0x42>
 b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 ba0:	89 cf                	mov    %ecx,%edi
 ba2:	31 d2                	xor    %edx,%edx
 ba4:	f7 f6                	div    %esi
 ba6:	8d 4f 01             	lea    0x1(%edi),%ecx
 ba9:	0f b6 92 28 11 00 00 	movzbl 0x1128(%edx),%edx
  }while((x /= base) != 0);
 bb0:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 bb2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 bb5:	75 e9                	jne    ba0 <printint+0x40>
  if(neg)
 bb7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 bba:	8b 75 c0             	mov    -0x40(%ebp),%esi
 bbd:	85 d2                	test   %edx,%edx
 bbf:	74 08                	je     bc9 <printint+0x69>
    buf[i++] = '-';
 bc1:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 bc6:	8d 4f 02             	lea    0x2(%edi),%ecx
 bc9:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 bcd:	8d 76 00             	lea    0x0(%esi),%esi
 bd0:	0f b6 07             	movzbl (%edi),%eax
 bd3:	4f                   	dec    %edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 bd4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 bd8:	89 34 24             	mov    %esi,(%esp)
 bdb:	88 45 d7             	mov    %al,-0x29(%ebp)
 bde:	b8 01 00 00 00       	mov    $0x1,%eax
 be3:	89 44 24 08          	mov    %eax,0x8(%esp)
 be7:	e8 dc fe ff ff       	call   ac8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 bec:	39 df                	cmp    %ebx,%edi
 bee:	75 e0                	jne    bd0 <printint+0x70>
    putc(fd, buf[i]);
}
 bf0:	83 c4 4c             	add    $0x4c,%esp
 bf3:	5b                   	pop    %ebx
 bf4:	5e                   	pop    %esi
 bf5:	5f                   	pop    %edi
 bf6:	5d                   	pop    %ebp
 bf7:	c3                   	ret    
 bf8:	90                   	nop
 bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 c00:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 c02:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 c09:	eb 83                	jmp    b8e <printint+0x2e>
 c0b:	90                   	nop
 c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000c10 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 c10:	55                   	push   %ebp
 c11:	89 e5                	mov    %esp,%ebp
 c13:	57                   	push   %edi
 c14:	56                   	push   %esi
 c15:	53                   	push   %ebx
 c16:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 c19:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 c1c:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 c1f:	0f b6 1e             	movzbl (%esi),%ebx
 c22:	84 db                	test   %bl,%bl
 c24:	0f 84 c6 00 00 00    	je     cf0 <printf+0xe0>
 c2a:	8d 45 10             	lea    0x10(%ebp),%eax
 c2d:	46                   	inc    %esi
 c2e:	89 45 d0             	mov    %eax,-0x30(%ebp)
 c31:	31 d2                	xor    %edx,%edx
 c33:	eb 3b                	jmp    c70 <printf+0x60>
 c35:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 c38:	83 f8 25             	cmp    $0x25,%eax
 c3b:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 c3e:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 c43:	74 1e                	je     c63 <printf+0x53>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 c45:	b8 01 00 00 00       	mov    $0x1,%eax
 c4a:	89 44 24 08          	mov    %eax,0x8(%esp)
 c4e:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 c51:	89 44 24 04          	mov    %eax,0x4(%esp)
 c55:	89 3c 24             	mov    %edi,(%esp)
 c58:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 c5b:	e8 68 fe ff ff       	call   ac8 <write>
 c60:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 c63:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 c64:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 c68:	84 db                	test   %bl,%bl
 c6a:	0f 84 80 00 00 00    	je     cf0 <printf+0xe0>
    c = fmt[i] & 0xff;
    if(state == 0){
 c70:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 c72:	0f be cb             	movsbl %bl,%ecx
 c75:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 c78:	74 be                	je     c38 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 c7a:	83 fa 25             	cmp    $0x25,%edx
 c7d:	75 e4                	jne    c63 <printf+0x53>
      if(c == 'd'){
 c7f:	83 f8 64             	cmp    $0x64,%eax
 c82:	0f 84 20 01 00 00    	je     da8 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 c88:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 c8e:	83 f9 70             	cmp    $0x70,%ecx
 c91:	74 6d                	je     d00 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 c93:	83 f8 73             	cmp    $0x73,%eax
 c96:	0f 84 94 00 00 00    	je     d30 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 c9c:	83 f8 63             	cmp    $0x63,%eax
 c9f:	0f 84 14 01 00 00    	je     db9 <printf+0x1a9>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 ca5:	83 f8 25             	cmp    $0x25,%eax
 ca8:	0f 84 d2 00 00 00    	je     d80 <printf+0x170>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 cae:	b8 01 00 00 00       	mov    $0x1,%eax
 cb3:	46                   	inc    %esi
 cb4:	89 44 24 08          	mov    %eax,0x8(%esp)
 cb8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 cbb:	89 44 24 04          	mov    %eax,0x4(%esp)
 cbf:	89 3c 24             	mov    %edi,(%esp)
 cc2:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 cc6:	e8 fd fd ff ff       	call   ac8 <write>
 ccb:	ba 01 00 00 00       	mov    $0x1,%edx
 cd0:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 cd3:	89 54 24 08          	mov    %edx,0x8(%esp)
 cd7:	89 44 24 04          	mov    %eax,0x4(%esp)
 cdb:	89 3c 24             	mov    %edi,(%esp)
 cde:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 ce1:	e8 e2 fd ff ff       	call   ac8 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 ce6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 cea:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 cec:	84 db                	test   %bl,%bl
 cee:	75 80                	jne    c70 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 cf0:	83 c4 3c             	add    $0x3c,%esp
 cf3:	5b                   	pop    %ebx
 cf4:	5e                   	pop    %esi
 cf5:	5f                   	pop    %edi
 cf6:	5d                   	pop    %ebp
 cf7:	c3                   	ret    
 cf8:	90                   	nop
 cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 d00:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 d07:	b9 10 00 00 00       	mov    $0x10,%ecx
 d0c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 d0f:	89 f8                	mov    %edi,%eax
 d11:	8b 13                	mov    (%ebx),%edx
 d13:	e8 48 fe ff ff       	call   b60 <printint>
        ap++;
 d18:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 d1a:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 d1c:	83 c0 04             	add    $0x4,%eax
 d1f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 d22:	e9 3c ff ff ff       	jmp    c63 <printf+0x53>
 d27:	89 f6                	mov    %esi,%esi
 d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      } else if(c == 's'){
        s = (char*)*ap;
 d30:	8b 45 d0             	mov    -0x30(%ebp),%eax
 d33:	8b 18                	mov    (%eax),%ebx
        ap++;
 d35:	83 c0 04             	add    $0x4,%eax
 d38:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 d3b:	b8 21 11 00 00       	mov    $0x1121,%eax
 d40:	85 db                	test   %ebx,%ebx
 d42:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 d45:	0f b6 03             	movzbl (%ebx),%eax
 d48:	84 c0                	test   %al,%al
 d4a:	74 27                	je     d73 <printf+0x163>
 d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 d50:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 d53:	b8 01 00 00 00       	mov    $0x1,%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 d58:	43                   	inc    %ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 d59:	89 44 24 08          	mov    %eax,0x8(%esp)
 d5d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 d60:	89 44 24 04          	mov    %eax,0x4(%esp)
 d64:	89 3c 24             	mov    %edi,(%esp)
 d67:	e8 5c fd ff ff       	call   ac8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 d6c:	0f b6 03             	movzbl (%ebx),%eax
 d6f:	84 c0                	test   %al,%al
 d71:	75 dd                	jne    d50 <printf+0x140>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 d73:	31 d2                	xor    %edx,%edx
 d75:	e9 e9 fe ff ff       	jmp    c63 <printf+0x53>
 d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 d80:	b9 01 00 00 00       	mov    $0x1,%ecx
 d85:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 d88:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 d8c:	89 44 24 04          	mov    %eax,0x4(%esp)
 d90:	89 3c 24             	mov    %edi,(%esp)
 d93:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 d96:	e8 2d fd ff ff       	call   ac8 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 d9b:	31 d2                	xor    %edx,%edx
 d9d:	e9 c1 fe ff ff       	jmp    c63 <printf+0x53>
 da2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 da8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 daf:	b9 0a 00 00 00       	mov    $0xa,%ecx
 db4:	e9 53 ff ff ff       	jmp    d0c <printf+0xfc>
 db9:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 dbc:	8b 03                	mov    (%ebx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 dbe:	89 3c 24             	mov    %edi,(%esp)
 dc1:	88 45 e4             	mov    %al,-0x1c(%ebp)
 dc4:	b8 01 00 00 00       	mov    $0x1,%eax
 dc9:	89 44 24 08          	mov    %eax,0x8(%esp)
 dcd:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 dd0:	89 44 24 04          	mov    %eax,0x4(%esp)
 dd4:	e8 ef fc ff ff       	call   ac8 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 dd9:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 ddb:	31 d2                	xor    %edx,%edx
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 ddd:	83 c0 04             	add    $0x4,%eax
 de0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 de3:	e9 7b fe ff ff       	jmp    c63 <printf+0x53>
 de8:	66 90                	xchg   %ax,%ax
 dea:	66 90                	xchg   %ax,%ax
 dec:	66 90                	xchg   %ax,%ax
 dee:	66 90                	xchg   %ax,%ax

00000df0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 df0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 df1:	a1 c0 16 00 00       	mov    0x16c0,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 df6:	89 e5                	mov    %esp,%ebp
 df8:	57                   	push   %edi
 df9:	56                   	push   %esi
 dfa:	53                   	push   %ebx
 dfb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 dfe:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 e00:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e03:	39 c8                	cmp    %ecx,%eax
 e05:	73 19                	jae    e20 <free+0x30>
 e07:	89 f6                	mov    %esi,%esi
 e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 e10:	39 d1                	cmp    %edx,%ecx
 e12:	72 1c                	jb     e30 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e14:	39 d0                	cmp    %edx,%eax
 e16:	73 18                	jae    e30 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 e18:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e1a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e1c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e1e:	72 f0                	jb     e10 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e20:	39 d0                	cmp    %edx,%eax
 e22:	72 f4                	jb     e18 <free+0x28>
 e24:	39 d1                	cmp    %edx,%ecx
 e26:	73 f0                	jae    e18 <free+0x28>
 e28:	90                   	nop
 e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 e30:	8b 73 fc             	mov    -0x4(%ebx),%esi
 e33:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 e36:	39 d7                	cmp    %edx,%edi
 e38:	74 19                	je     e53 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 e3a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 e3d:	8b 50 04             	mov    0x4(%eax),%edx
 e40:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 e43:	39 f1                	cmp    %esi,%ecx
 e45:	74 25                	je     e6c <free+0x7c>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 e47:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 e49:	5b                   	pop    %ebx
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 e4a:	a3 c0 16 00 00       	mov    %eax,0x16c0
}
 e4f:	5e                   	pop    %esi
 e50:	5f                   	pop    %edi
 e51:	5d                   	pop    %ebp
 e52:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 e53:	8b 7a 04             	mov    0x4(%edx),%edi
 e56:	01 fe                	add    %edi,%esi
 e58:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 e5b:	8b 10                	mov    (%eax),%edx
 e5d:	8b 12                	mov    (%edx),%edx
 e5f:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 e62:	8b 50 04             	mov    0x4(%eax),%edx
 e65:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 e68:	39 f1                	cmp    %esi,%ecx
 e6a:	75 db                	jne    e47 <free+0x57>
    p->s.size += bp->s.size;
 e6c:	8b 4b fc             	mov    -0x4(%ebx),%ecx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 e6f:	a3 c0 16 00 00       	mov    %eax,0x16c0
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 e74:	01 ca                	add    %ecx,%edx
 e76:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 e79:	8b 53 f8             	mov    -0x8(%ebx),%edx
 e7c:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 e7e:	5b                   	pop    %ebx
 e7f:	5e                   	pop    %esi
 e80:	5f                   	pop    %edi
 e81:	5d                   	pop    %ebp
 e82:	c3                   	ret    
 e83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000e90 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 e90:	55                   	push   %ebp
 e91:	89 e5                	mov    %esp,%ebp
 e93:	57                   	push   %edi
 e94:	56                   	push   %esi
 e95:	53                   	push   %ebx
 e96:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 e99:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 e9c:	8b 15 c0 16 00 00    	mov    0x16c0,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ea2:	8d 78 07             	lea    0x7(%eax),%edi
 ea5:	c1 ef 03             	shr    $0x3,%edi
 ea8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 ea9:	85 d2                	test   %edx,%edx
 eab:	0f 84 95 00 00 00    	je     f46 <malloc+0xb6>
 eb1:	8b 02                	mov    (%edx),%eax
 eb3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 eb6:	39 cf                	cmp    %ecx,%edi
 eb8:	76 66                	jbe    f20 <malloc+0x90>
 eba:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 ec0:	be 00 10 00 00       	mov    $0x1000,%esi
 ec5:	0f 43 f7             	cmovae %edi,%esi
 ec8:	ba 00 80 00 00       	mov    $0x8000,%edx
 ecd:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 ed4:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 eda:	0f 46 da             	cmovbe %edx,%ebx
 edd:	eb 0a                	jmp    ee9 <malloc+0x59>
 edf:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ee0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 ee2:	8b 48 04             	mov    0x4(%eax),%ecx
 ee5:	39 cf                	cmp    %ecx,%edi
 ee7:	76 37                	jbe    f20 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ee9:	39 05 c0 16 00 00    	cmp    %eax,0x16c0
 eef:	89 c2                	mov    %eax,%edx
 ef1:	75 ed                	jne    ee0 <malloc+0x50>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 ef3:	89 1c 24             	mov    %ebx,(%esp)
 ef6:	e8 35 fc ff ff       	call   b30 <sbrk>
  if(p == (char*)-1)
 efb:	83 f8 ff             	cmp    $0xffffffff,%eax
 efe:	74 18                	je     f18 <malloc+0x88>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 f00:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 f03:	83 c0 08             	add    $0x8,%eax
 f06:	89 04 24             	mov    %eax,(%esp)
 f09:	e8 e2 fe ff ff       	call   df0 <free>
  return freep;
 f0e:	8b 15 c0 16 00 00    	mov    0x16c0,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 f14:	85 d2                	test   %edx,%edx
 f16:	75 c8                	jne    ee0 <malloc+0x50>
        return 0;
 f18:	31 c0                	xor    %eax,%eax
 f1a:	eb 1c                	jmp    f38 <malloc+0xa8>
 f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 f20:	39 cf                	cmp    %ecx,%edi
 f22:	74 1c                	je     f40 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 f24:	29 f9                	sub    %edi,%ecx
 f26:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 f29:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 f2c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 f2f:	89 15 c0 16 00 00    	mov    %edx,0x16c0
      return (void*)(p + 1);
 f35:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 f38:	83 c4 1c             	add    $0x1c,%esp
 f3b:	5b                   	pop    %ebx
 f3c:	5e                   	pop    %esi
 f3d:	5f                   	pop    %edi
 f3e:	5d                   	pop    %ebp
 f3f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 f40:	8b 08                	mov    (%eax),%ecx
 f42:	89 0a                	mov    %ecx,(%edx)
 f44:	eb e9                	jmp    f2f <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 f46:	b8 c4 16 00 00       	mov    $0x16c4,%eax
 f4b:	ba c4 16 00 00       	mov    $0x16c4,%edx
    base.s.size = 0;
 f50:	31 c9                	xor    %ecx,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 f52:	a3 c0 16 00 00       	mov    %eax,0x16c0
    base.s.size = 0;
 f57:	b8 c4 16 00 00       	mov    $0x16c4,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 f5c:	89 15 c4 16 00 00    	mov    %edx,0x16c4
    base.s.size = 0;
 f62:	89 0d c8 16 00 00    	mov    %ecx,0x16c8
 f68:	e9 4d ff ff ff       	jmp    eba <malloc+0x2a>
