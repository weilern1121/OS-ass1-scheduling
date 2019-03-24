
_sanity:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    return result;

}


int main(void) {
   0:	55                   	push   %ebp
    run_test(&test_exit_wait, "exit&wait");
   1:	b8 90 0f 00 00       	mov    $0xf90,%eax
    return result;

}


int main(void) {
   6:	89 e5                	mov    %esp,%ebp
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	83 ec 10             	sub    $0x10,%esp
    run_test(&test_exit_wait, "exit&wait");
   e:	89 44 24 04          	mov    %eax,0x4(%esp)
  12:	c7 04 24 80 00 00 00 	movl   $0x80,(%esp)
  19:	e8 22 02 00 00       	call   240 <run_test>
    run_test(&test_detach, "detach");
  1e:	ba 35 10 00 00       	mov    $0x1035,%edx
  23:	89 54 24 04          	mov    %edx,0x4(%esp)
  27:	c7 04 24 20 01 00 00 	movl   $0x120,(%esp)
  2e:	e8 0d 02 00 00       	call   240 <run_test>
    run_test(&test_round_robin_policy, "round robin policy");
  33:	b9 3c 10 00 00       	mov    $0x103c,%ecx
  38:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  3c:	c7 04 24 50 05 00 00 	movl   $0x550,(%esp)
  43:	e8 f8 01 00 00       	call   240 <run_test>
    run_test(&test_priority_policy, "priority policy");
  48:	b8 58 10 00 00       	mov    $0x1058,%eax
  4d:	89 44 24 04          	mov    %eax,0x4(%esp)
  51:	c7 04 24 70 05 00 00 	movl   $0x570,(%esp)
  58:	e8 e3 01 00 00       	call   240 <run_test>
    run_test(&test_extended_priority_policy, "extended priority policy");
  5d:	b8 4f 10 00 00       	mov    $0x104f,%eax
  62:	89 44 24 04          	mov    %eax,0x4(%esp)
  66:	c7 04 24 c0 05 00 00 	movl   $0x5c0,(%esp)
  6d:	e8 ce 01 00 00       	call   240 <run_test>
    //run_test(&test_accumulator, "accumulator");
    //run_test(&test_starvation, "starvation");
    //run_test(&test_performance_round_robin, "performance round robin");
    //run_test(&test_performance_priority, "performance priority");
    //run_test(&test_performance_extended_priority, "performance extended priority");
    exit(0);
  72:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  79:	e8 4a 0a 00 00       	call   ac8 <exit>
  7e:	66 90                	xchg   %ax,%ax

00000080 <test_exit_wait>:
        return 1;
    return fib(n - 1) + fib(n - 2);
}


boolean test_exit_wait() {
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	57                   	push   %edi
  84:	56                   	push   %esi
    int status;
    boolean result = true;
  85:	be 01 00 00 00       	mov    $0x1,%esi
        return 1;
    return fib(n - 1) + fib(n - 2);
}


boolean test_exit_wait() {
  8a:	53                   	push   %ebx
    int status;
    boolean result = true;
    int pid;
    for (int i = 0; i < 20; ++i) {
  8b:	31 db                	xor    %ebx,%ebx
        return 1;
    return fib(n - 1) + fib(n - 2);
}


boolean test_exit_wait() {
  8d:	83 ec 3c             	sub    $0x3c,%esp
    boolean result = true;
    int pid;
    for (int i = 0; i < 20; ++i) {
        pid = fork();
        if (pid > 0) {
            wait(&status);
  90:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  93:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
boolean test_exit_wait() {
    int status;
    boolean result = true;
    int pid;
    for (int i = 0; i < 20; ++i) {
        pid = fork();
  a0:	e8 1b 0a 00 00       	call   ac0 <fork>
        if (pid > 0) {
  a5:	85 c0                	test   %eax,%eax
  a7:	7e 57                	jle    100 <test_exit_wait+0x80>
            wait(&status);
  a9:	89 3c 24             	mov    %edi,(%esp)
  ac:	e8 1f 0a 00 00       	call   ad0 <wait>
            result = result && assert_equals(i, status, "exit&wait");
  b1:	85 f6                	test   %esi,%esi
  b3:	74 34                	je     e9 <test_exit_wait+0x69>
  b5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  b8:	be 01 00 00 00       	mov    $0x1,%esi
        printf(1, "========== Test - %s: Failed ==========\n", name);
    }
}

boolean assert_equals(int expected, int actual, char *msg) {
    if (expected != actual) {
  bd:	39 d8                	cmp    %ebx,%eax
  bf:	74 28                	je     e9 <test_exit_wait+0x69>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
  c1:	89 44 24 10          	mov    %eax,0x10(%esp)
  c5:	ba 68 10 00 00       	mov    $0x1068,%edx
  ca:	b8 90 0f 00 00       	mov    $0xf90,%eax
  cf:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    int pid;
    for (int i = 0; i < 20; ++i) {
        pid = fork();
        if (pid > 0) {
            wait(&status);
            result = result && assert_equals(i, status, "exit&wait");
  d3:	31 f6                	xor    %esi,%esi
    }
}

boolean assert_equals(int expected, int actual, char *msg) {
    if (expected != actual) {
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
  d5:	89 44 24 08          	mov    %eax,0x8(%esp)
  d9:	89 54 24 04          	mov    %edx,0x4(%esp)
  dd:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  e4:	e8 47 0b 00 00       	call   c30 <printf>

boolean test_exit_wait() {
    int status;
    boolean result = true;
    int pid;
    for (int i = 0; i < 20; ++i) {
  e9:	43                   	inc    %ebx
  ea:	83 fb 14             	cmp    $0x14,%ebx
        pid = fork();
        if (pid > 0) {
            wait(&status);
            result = result && assert_equals(i, status, "exit&wait");
            status = -1;
  ed:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)

boolean test_exit_wait() {
    int status;
    boolean result = true;
    int pid;
    for (int i = 0; i < 20; ++i) {
  f4:	75 aa                	jne    a0 <test_exit_wait+0x20>
            sleep(3);
            exit(i);
        }
    }
    return result;
}
  f6:	83 c4 3c             	add    $0x3c,%esp
  f9:	89 f0                	mov    %esi,%eax
  fb:	5b                   	pop    %ebx
  fc:	5e                   	pop    %esi
  fd:	5f                   	pop    %edi
  fe:	5d                   	pop    %ebp
  ff:	c3                   	ret    
        if (pid > 0) {
            wait(&status);
            result = result && assert_equals(i, status, "exit&wait");
            status = -1;
        } else {
            sleep(3);
 100:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
 107:	e8 4c 0a 00 00       	call   b58 <sleep>
            exit(i);
 10c:	89 1c 24             	mov    %ebx,(%esp)
 10f:	e8 b4 09 00 00       	call   ac8 <exit>
 114:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 11a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000120 <test_detach>:
        }
    }
    return result;
}

boolean test_detach() {
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	56                   	push   %esi
 124:	53                   	push   %ebx
 125:	83 ec 20             	sub    $0x20,%esp
    int pid;
    boolean result1;
    boolean result2;
    boolean result3;

    pid = fork();
 128:	e8 93 09 00 00       	call   ac0 <fork>
    if (pid > 0) {
 12d:	85 c0                	test   %eax,%eax
 12f:	0f 8e f2 00 00 00    	jle    227 <test_detach+0x107>
        status1 = detach(pid);
 135:	89 04 24             	mov    %eax,(%esp)
 138:	89 c6                	mov    %eax,%esi

boolean assert_equals(int expected, int actual, char *msg) {
    if (expected != actual) {
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
        return false;
    } else return true;
 13a:	bb 01 00 00 00       	mov    $0x1,%ebx
    boolean result2;
    boolean result3;

    pid = fork();
    if (pid > 0) {
        status1 = detach(pid);
 13f:	e8 2c 0a 00 00       	call   b70 <detach>
        printf(1, "========== Test - %s: Failed ==========\n", name);
    }
}

boolean assert_equals(int expected, int actual, char *msg) {
    if (expected != actual) {
 144:	85 c0                	test   %eax,%eax
 146:	0f 85 94 00 00 00    	jne    1e0 <test_detach+0xc0>
    pid = fork();
    if (pid > 0) {
        status1 = detach(pid);
        result1 = assert_equals(0, status1, "detach - status1");

        status2 = detach(pid);
 14c:	89 34 24             	mov    %esi,(%esp)
 14f:	e8 1c 0a 00 00       	call   b70 <detach>
        printf(1, "========== Test - %s: Failed ==========\n", name);
    }
}

boolean assert_equals(int expected, int actual, char *msg) {
    if (expected != actual) {
 154:	83 f8 ff             	cmp    $0xffffffff,%eax
 157:	74 47                	je     1a0 <test_detach+0x80>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
 159:	89 44 24 10          	mov    %eax,0x10(%esp)
 15d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
 162:	b8 68 10 00 00       	mov    $0x1068,%eax
 167:	be ab 0f 00 00       	mov    $0xfab,%esi
 16c:	89 44 24 04          	mov    %eax,0x4(%esp)
 170:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
 174:	89 74 24 08          	mov    %esi,0x8(%esp)
 178:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 17f:	e8 ac 0a 00 00       	call   c30 <printf>
        result1 = assert_equals(0, status1, "detach - status1");

        status2 = detach(pid);
        result2 = assert_equals(-1, status2, "detach - status2");

        status3 = detach(-10);
 184:	c7 04 24 f6 ff ff ff 	movl   $0xfffffff6,(%esp)
 18b:	e8 e0 09 00 00       	call   b70 <detach>
        printf(1, "========== Test - %s: Failed ==========\n", name);
    }
}

boolean assert_equals(int expected, int actual, char *msg) {
    if (expected != actual) {
 190:	83 f8 ff             	cmp    $0xffffffff,%eax
 193:	75 1c                	jne    1b1 <test_detach+0x91>
        return result1 && result2 && result3;
    } else {
        sleep(100);
        exit(0);
    }
}
 195:	83 c4 20             	add    $0x20,%esp
        result2 = assert_equals(-1, status2, "detach - status2");

        status3 = detach(-10);
        result3 = assert_equals(-1, status3, "detach - status3");

        return result1 && result2 && result3;
 198:	31 c0                	xor    %eax,%eax
    } else {
        sleep(100);
        exit(0);
    }
}
 19a:	5b                   	pop    %ebx
 19b:	5e                   	pop    %esi
 19c:	5d                   	pop    %ebp
 19d:	c3                   	ret    
 19e:	66 90                	xchg   %ax,%ax
        result1 = assert_equals(0, status1, "detach - status1");

        status2 = detach(pid);
        result2 = assert_equals(-1, status2, "detach - status2");

        status3 = detach(-10);
 1a0:	c7 04 24 f6 ff ff ff 	movl   $0xfffffff6,(%esp)
 1a7:	e8 c4 09 00 00       	call   b70 <detach>
        printf(1, "========== Test - %s: Failed ==========\n", name);
    }
}

boolean assert_equals(int expected, int actual, char *msg) {
    if (expected != actual) {
 1ac:	83 f8 ff             	cmp    $0xffffffff,%eax
 1af:	74 5f                	je     210 <test_detach+0xf0>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
 1b1:	89 44 24 10          	mov    %eax,0x10(%esp)
 1b5:	ba bc 0f 00 00       	mov    $0xfbc,%edx
 1ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1bf:	b9 68 10 00 00       	mov    $0x1068,%ecx
 1c4:	89 44 24 0c          	mov    %eax,0xc(%esp)
 1c8:	89 54 24 08          	mov    %edx,0x8(%esp)
 1cc:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 1d0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 1d7:	e8 54 0a 00 00       	call   c30 <printf>
 1dc:	eb b7                	jmp    195 <test_detach+0x75>
 1de:	66 90                	xchg   %ax,%ax
 1e0:	89 44 24 10          	mov    %eax,0x10(%esp)
 1e4:	31 c0                	xor    %eax,%eax
 1e6:	31 db                	xor    %ebx,%ebx
 1e8:	89 44 24 0c          	mov    %eax,0xc(%esp)
 1ec:	b8 9a 0f 00 00       	mov    $0xf9a,%eax
 1f1:	89 44 24 08          	mov    %eax,0x8(%esp)
 1f5:	b8 68 10 00 00       	mov    $0x1068,%eax
 1fa:	89 44 24 04          	mov    %eax,0x4(%esp)
 1fe:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 205:	e8 26 0a 00 00       	call   c30 <printf>
 20a:	e9 3d ff ff ff       	jmp    14c <test_detach+0x2c>
 20f:	90                   	nop
        result2 = assert_equals(-1, status2, "detach - status2");

        status3 = detach(-10);
        result3 = assert_equals(-1, status3, "detach - status3");

        return result1 && result2 && result3;
 210:	80 e3 01             	and    $0x1,%bl
 213:	84 db                	test   %bl,%bl
 215:	0f 84 7a ff ff ff    	je     195 <test_detach+0x75>
    } else {
        sleep(100);
        exit(0);
    }
}
 21b:	83 c4 20             	add    $0x20,%esp
        result2 = assert_equals(-1, status2, "detach - status2");

        status3 = detach(-10);
        result3 = assert_equals(-1, status3, "detach - status3");

        return result1 && result2 && result3;
 21e:	b8 01 00 00 00       	mov    $0x1,%eax
    } else {
        sleep(100);
        exit(0);
    }
}
 223:	5b                   	pop    %ebx
 224:	5e                   	pop    %esi
 225:	5d                   	pop    %ebp
 226:	c3                   	ret    
        status3 = detach(-10);
        result3 = assert_equals(-1, status3, "detach - status3");

        return result1 && result2 && result3;
    } else {
        sleep(100);
 227:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 22e:	e8 25 09 00 00       	call   b58 <sleep>
        exit(0);
 233:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 23a:	e8 89 08 00 00       	call   ac8 <exit>
 23f:	90                   	nop

00000240 <run_test>:
};


typedef boolean (test_runner)();

void run_test(test_runner *test, char *name) {
 240:	55                   	push   %ebp
    printf(1, "========== Test - %s: Begin ==========\n", name);
 241:	b9 94 10 00 00       	mov    $0x1094,%ecx
};


typedef boolean (test_runner)();

void run_test(test_runner *test, char *name) {
 246:	89 e5                	mov    %esp,%ebp
 248:	53                   	push   %ebx
 249:	83 ec 14             	sub    $0x14,%esp
 24c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    printf(1, "========== Test - %s: Begin ==========\n", name);
 24f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 253:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 25a:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 25e:	e8 cd 09 00 00       	call   c30 <printf>
    boolean result = (*test)();
 263:	ff 55 08             	call   *0x8(%ebp)
    if (result) {
        printf(1, "========== Test - %s: Passed ==========\n", name);
 266:	89 5c 24 08          	mov    %ebx,0x8(%esp)
typedef boolean (test_runner)();

void run_test(test_runner *test, char *name) {
    printf(1, "========== Test - %s: Begin ==========\n", name);
    boolean result = (*test)();
    if (result) {
 26a:	85 c0                	test   %eax,%eax
 26c:	75 22                	jne    290 <run_test+0x50>
        printf(1, "========== Test - %s: Passed ==========\n", name);
    } else {
        printf(1, "========== Test - %s: Failed ==========\n", name);
 26e:	b8 e8 10 00 00       	mov    $0x10e8,%eax
 273:	89 44 24 04          	mov    %eax,0x4(%esp)
 277:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 27e:	e8 ad 09 00 00       	call   c30 <printf>
    }
}
 283:	83 c4 14             	add    $0x14,%esp
 286:	5b                   	pop    %ebx
 287:	5d                   	pop    %ebp
 288:	c3                   	ret    
 289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

void run_test(test_runner *test, char *name) {
    printf(1, "========== Test - %s: Begin ==========\n", name);
    boolean result = (*test)();
    if (result) {
        printf(1, "========== Test - %s: Passed ==========\n", name);
 290:	ba bc 10 00 00       	mov    $0x10bc,%edx
 295:	89 54 24 04          	mov    %edx,0x4(%esp)
 299:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2a0:	e8 8b 09 00 00       	call   c30 <printf>
    } else {
        printf(1, "========== Test - %s: Failed ==========\n", name);
    }
}
 2a5:	83 c4 14             	add    $0x14,%esp
 2a8:	5b                   	pop    %ebx
 2a9:	5d                   	pop    %ebp
 2aa:	c3                   	ret    
 2ab:	90                   	nop
 2ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002b0 <assert_equals>:

boolean assert_equals(int expected, int actual, char *msg) {
 2b0:	55                   	push   %ebp
 2b1:	b8 01 00 00 00       	mov    $0x1,%eax
 2b6:	89 e5                	mov    %esp,%ebp
 2b8:	83 ec 28             	sub    $0x28,%esp
 2bb:	8b 55 08             	mov    0x8(%ebp),%edx
 2be:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    if (expected != actual) {
 2c1:	39 ca                	cmp    %ecx,%edx
 2c3:	74 26                	je     2eb <assert_equals+0x3b>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
 2c5:	8b 45 10             	mov    0x10(%ebp),%eax
 2c8:	89 4c 24 10          	mov    %ecx,0x10(%esp)
 2cc:	89 54 24 0c          	mov    %edx,0xc(%esp)
 2d0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 2d7:	89 44 24 08          	mov    %eax,0x8(%esp)
 2db:	b8 68 10 00 00       	mov    $0x1068,%eax
 2e0:	89 44 24 04          	mov    %eax,0x4(%esp)
 2e4:	e8 47 09 00 00       	call   c30 <printf>
 2e9:	31 c0                	xor    %eax,%eax
        return false;
    } else return true;
}
 2eb:	c9                   	leave  
 2ec:	c3                   	ret    
 2ed:	8d 76 00             	lea    0x0(%esi),%esi

000002f0 <print_perf>:


void print_perf(struct perf *performance) {
 2f0:	55                   	push   %ebp
    printf(1, "pref:\n");
 2f1:	b8 cd 0f 00 00       	mov    $0xfcd,%eax
        return false;
    } else return true;
}


void print_perf(struct perf *performance) {
 2f6:	89 e5                	mov    %esp,%ebp
 2f8:	53                   	push   %ebx
 2f9:	83 ec 14             	sub    $0x14,%esp
 2fc:	8b 5d 08             	mov    0x8(%ebp),%ebx
    printf(1, "pref:\n");
 2ff:	89 44 24 04          	mov    %eax,0x4(%esp)
 303:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 30a:	e8 21 09 00 00       	call   c30 <printf>
    printf(1, "\tctime: %d\n", performance->ctime);
 30f:	ba d4 0f 00 00       	mov    $0xfd4,%edx
 314:	8b 03                	mov    (%ebx),%eax
 316:	89 54 24 04          	mov    %edx,0x4(%esp)
 31a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 321:	89 44 24 08          	mov    %eax,0x8(%esp)
 325:	e8 06 09 00 00       	call   c30 <printf>
    printf(1, "\tttime: %d\n", performance->ttime);
 32a:	8b 43 04             	mov    0x4(%ebx),%eax
 32d:	b9 e0 0f 00 00       	mov    $0xfe0,%ecx
 332:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 336:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 33d:	89 44 24 08          	mov    %eax,0x8(%esp)
 341:	e8 ea 08 00 00       	call   c30 <printf>
    printf(1, "\tstime: %d\n", performance->stime);
 346:	8b 43 08             	mov    0x8(%ebx),%eax
 349:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 350:	89 44 24 08          	mov    %eax,0x8(%esp)
 354:	b8 ec 0f 00 00       	mov    $0xfec,%eax
 359:	89 44 24 04          	mov    %eax,0x4(%esp)
 35d:	e8 ce 08 00 00       	call   c30 <printf>
    printf(1, "\tretime: %d\n", performance->retime);
 362:	8b 43 0c             	mov    0xc(%ebx),%eax
 365:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 36c:	89 44 24 08          	mov    %eax,0x8(%esp)
 370:	b8 f8 0f 00 00       	mov    $0xff8,%eax
 375:	89 44 24 04          	mov    %eax,0x4(%esp)
 379:	e8 b2 08 00 00       	call   c30 <printf>
    printf(1, "\trutime: %d\n", performance->rutime);
 37e:	8b 43 10             	mov    0x10(%ebx),%eax
 381:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 388:	89 44 24 08          	mov    %eax,0x8(%esp)
 38c:	b8 05 10 00 00       	mov    $0x1005,%eax
 391:	89 44 24 04          	mov    %eax,0x4(%esp)
 395:	e8 96 08 00 00       	call   c30 <printf>
    printf(1, "\n\tTurnaround time: %d\n", (performance->ttime - performance->ctime));
 39a:	8b 43 04             	mov    0x4(%ebx),%eax
 39d:	b9 12 10 00 00       	mov    $0x1012,%ecx
 3a2:	8b 13                	mov    (%ebx),%edx
 3a4:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 3a8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 3af:	29 d0                	sub    %edx,%eax
 3b1:	89 44 24 08          	mov    %eax,0x8(%esp)
 3b5:	e8 76 08 00 00       	call   c30 <printf>
}
 3ba:	83 c4 14             	add    $0x14,%esp
 3bd:	5b                   	pop    %ebx
 3be:	5d                   	pop    %ebp
 3bf:	c3                   	ret    

000003c0 <fact>:

int fact(int n) {
 3c0:	55                   	push   %ebp
    if (!n)
        return 0;
    return n * fact(n - 1);
}
 3c1:	31 c0                	xor    %eax,%eax
    printf(1, "\tretime: %d\n", performance->retime);
    printf(1, "\trutime: %d\n", performance->rutime);
    printf(1, "\n\tTurnaround time: %d\n", (performance->ttime - performance->ctime));
}

int fact(int n) {
 3c3:	89 e5                	mov    %esp,%ebp
    if (!n)
        return 0;
    return n * fact(n - 1);
}
 3c5:	5d                   	pop    %ebp
 3c6:	c3                   	ret    
 3c7:	89 f6                	mov    %esi,%esi
 3c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003d0 <fact2>:

unsigned long long fact2(unsigned long long n, unsigned long long k) {
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3d6:	57                   	push   %edi
 3d7:	8b 45 10             	mov    0x10(%ebp),%eax
 3da:	56                   	push   %esi
 3db:	8b 55 14             	mov    0x14(%ebp),%edx
 3de:	53                   	push   %ebx
 3df:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    start:
    if (n == 1) {
 3e2:	89 ce                	mov    %ecx,%esi
 3e4:	83 f6 01             	xor    $0x1,%esi
 3e7:	09 de                	or     %ebx,%esi
 3e9:	74 24                	je     40f <fact2+0x3f>
 3eb:	90                   	nop
 3ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return k;
    } else {
        --n;
 3f0:	83 c1 ff             	add    $0xffffffff,%ecx
        k = k * n;
 3f3:	89 d6                	mov    %edx,%esi
unsigned long long fact2(unsigned long long n, unsigned long long k) {
    start:
    if (n == 1) {
        return k;
    } else {
        --n;
 3f5:	83 d3 ff             	adc    $0xffffffff,%ebx
        k = k * n;
 3f8:	89 df                	mov    %ebx,%edi
 3fa:	0f af f8             	imul   %eax,%edi
 3fd:	0f af f1             	imul   %ecx,%esi
 400:	f7 e1                	mul    %ecx
 402:	01 fe                	add    %edi,%esi
 404:	01 f2                	add    %esi,%edx
    return n * fact(n - 1);
}

unsigned long long fact2(unsigned long long n, unsigned long long k) {
    start:
    if (n == 1) {
 406:	89 ce                	mov    %ecx,%esi
 408:	83 f6 01             	xor    $0x1,%esi
 40b:	09 de                	or     %ebx,%esi
 40d:	75 e1                	jne    3f0 <fact2+0x20>
        k = k * n;
        goto start;
    }


}
 40f:	5b                   	pop    %ebx
 410:	5e                   	pop    %esi
 411:	5f                   	pop    %edi
 412:	5d                   	pop    %ebp
 413:	c3                   	ret    
 414:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 41a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000420 <fib>:

int fib(int n) {
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	56                   	push   %esi
 424:	53                   	push   %ebx
 425:	83 ec 10             	sub    $0x10,%esp
 428:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if (!n)
 42b:	85 db                	test   %ebx,%ebx
 42d:	74 2d                	je     45c <fib+0x3c>
 42f:	31 f6                	xor    %esi,%esi
 431:	eb 0d                	jmp    440 <fib+0x20>
 433:	90                   	nop
 434:	90                   	nop
 435:	90                   	nop
 436:	90                   	nop
 437:	90                   	nop
 438:	90                   	nop
 439:	90                   	nop
 43a:	90                   	nop
 43b:	90                   	nop
 43c:	90                   	nop
 43d:	90                   	nop
 43e:	90                   	nop
 43f:	90                   	nop
        return 1;
    return fib(n - 1) + fib(n - 2);
 440:	8d 43 ff             	lea    -0x1(%ebx),%eax
 443:	89 04 24             	mov    %eax,(%esp)
 446:	e8 d5 ff ff ff       	call   420 <fib>
 44b:	01 c6                	add    %eax,%esi


}

int fib(int n) {
    if (!n)
 44d:	83 eb 02             	sub    $0x2,%ebx
 450:	75 ee                	jne    440 <fib+0x20>
 452:	8d 46 01             	lea    0x1(%esi),%eax
        return 1;
    return fib(n - 1) + fib(n - 2);
}
 455:	83 c4 10             	add    $0x10,%esp
 458:	5b                   	pop    %ebx
 459:	5e                   	pop    %esi
 45a:	5d                   	pop    %ebp
 45b:	c3                   	ret    


}

int fib(int n) {
    if (!n)
 45c:	b8 01 00 00 00       	mov    $0x1,%eax
 461:	eb f2                	jmp    455 <fib+0x35>
 463:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000470 <test_policy_helper>:
        sleep(100);
        exit(0);
    }
}

boolean test_policy_helper(int *priority_mod, int policy) {
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	57                   	push   %edi
 474:	56                   	push   %esi
 475:	53                   	push   %ebx
    int nProcs = 15;
    int pid, status;
    boolean result = true;
    for (int i = 0; i < nProcs; ++i) {
 476:	31 db                	xor    %ebx,%ebx
        sleep(100);
        exit(0);
    }
}

boolean test_policy_helper(int *priority_mod, int policy) {
 478:	83 ec 3c             	sub    $0x3c,%esp
 47b:	90                   	nop
 47c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    int nProcs = 15;
    int pid, status;
    boolean result = true;
    for (int i = 0; i < nProcs; ++i) {
        pid = fork();
 480:	e8 3b 06 00 00       	call   ac0 <fork>
        if (pid < 0) {
 485:	85 c0                	test   %eax,%eax
 487:	78 6f                	js     4f8 <test_policy_helper+0x88>
            break;
        } else if (pid == 0) {
 489:	74 74                	je     4ff <test_policy_helper+0x8f>

boolean test_policy_helper(int *priority_mod, int policy) {
    int nProcs = 15;
    int pid, status;
    boolean result = true;
    for (int i = 0; i < nProcs; ++i) {
 48b:	43                   	inc    %ebx
 48c:	83 fb 0f             	cmp    $0xf,%ebx
 48f:	90                   	nop
 490:	75 ee                	jne    480 <test_policy_helper+0x10>
 492:	be 01 00 00 00       	mov    $0x1,%esi
 497:	8d 7d e4             	lea    -0x1c(%ebp),%edi
 49a:	eb 07                	jmp    4a3 <test_policy_helper+0x33>
 49c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            }
            sleep(10);
            exit(0);
        }
    }
    for (int j = 0; j < nProcs; ++j) {
 4a0:	4b                   	dec    %ebx
 4a1:	74 45                	je     4e8 <test_policy_helper+0x78>
        wait(&status);
 4a3:	89 3c 24             	mov    %edi,(%esp)
 4a6:	e8 25 06 00 00       	call   ad0 <wait>
        result = result && assert_equals(0, status, "round robin");
 4ab:	85 f6                	test   %esi,%esi
 4ad:	74 f1                	je     4a0 <test_policy_helper+0x30>
 4af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4b2:	be 01 00 00 00       	mov    $0x1,%esi
        printf(1, "========== Test - %s: Failed ==========\n", name);
    }
}

boolean assert_equals(int expected, int actual, char *msg) {
    if (expected != actual) {
 4b7:	85 c0                	test   %eax,%eax
 4b9:	74 e5                	je     4a0 <test_policy_helper+0x30>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
 4bb:	89 44 24 10          	mov    %eax,0x10(%esp)
 4bf:	ba 29 10 00 00       	mov    $0x1029,%edx
 4c4:	31 c0                	xor    %eax,%eax
 4c6:	b9 68 10 00 00       	mov    $0x1068,%ecx
            exit(0);
        }
    }
    for (int j = 0; j < nProcs; ++j) {
        wait(&status);
        result = result && assert_equals(0, status, "round robin");
 4cb:	31 f6                	xor    %esi,%esi
    }
}

boolean assert_equals(int expected, int actual, char *msg) {
    if (expected != actual) {
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
 4cd:	89 44 24 0c          	mov    %eax,0xc(%esp)
 4d1:	89 54 24 08          	mov    %edx,0x8(%esp)
 4d5:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 4d9:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 4e0:	e8 4b 07 00 00       	call   c30 <printf>
            }
            sleep(10);
            exit(0);
        }
    }
    for (int j = 0; j < nProcs; ++j) {
 4e5:	4b                   	dec    %ebx
 4e6:	75 bb                	jne    4a3 <test_policy_helper+0x33>
        wait(&status);
        result = result && assert_equals(0, status, "round robin");
    }
    return result;

}
 4e8:	83 c4 3c             	add    $0x3c,%esp
 4eb:	89 f0                	mov    %esi,%eax
 4ed:	5b                   	pop    %ebx
 4ee:	5e                   	pop    %esi
 4ef:	5f                   	pop    %edi
 4f0:	5d                   	pop    %ebp
 4f1:	c3                   	ret    
 4f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4f8:	bb 0f 00 00 00       	mov    $0xf,%ebx
 4fd:	eb 93                	jmp    492 <test_policy_helper+0x22>
    for (int i = 0; i < nProcs; ++i) {
        pid = fork();
        if (pid < 0) {
            break;
        } else if (pid == 0) {
            if (priority_mod) {
 4ff:	8b 75 08             	mov    0x8(%ebp),%esi
 502:	85 f6                	test   %esi,%esi
 504:	74 1a                	je     520 <test_policy_helper+0xb0>
                if ((i % *(priority_mod)) == 0 && policy == PRIORITY) {
 506:	8b 4d 08             	mov    0x8(%ebp),%ecx
 509:	89 d8                	mov    %ebx,%eax
 50b:	99                   	cltd   
 50c:	f7 39                	idivl  (%ecx)
 50e:	83 7d 0c 02          	cmpl   $0x2,0xc(%ebp)
 512:	75 04                	jne    518 <test_policy_helper+0xa8>
 514:	85 d2                	test   %edx,%edx
 516:	74 20                	je     538 <test_policy_helper+0xc8>
                    priority(1);
                } else {
                    priority(i % (*priority_mod));
 518:	89 14 24             	mov    %edx,(%esp)
 51b:	e8 58 06 00 00       	call   b78 <priority>
                }
            }
            sleep(10);
 520:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
 527:	e8 2c 06 00 00       	call   b58 <sleep>
            exit(0);
 52c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 533:	e8 90 05 00 00       	call   ac8 <exit>
        if (pid < 0) {
            break;
        } else if (pid == 0) {
            if (priority_mod) {
                if ((i % *(priority_mod)) == 0 && policy == PRIORITY) {
                    priority(1);
 538:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 53f:	e8 34 06 00 00       	call   b78 <priority>
 544:	eb da                	jmp    520 <test_policy_helper+0xb0>
 546:	8d 76 00             	lea    0x0(%esi),%esi
 549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000550 <test_round_robin_policy>:
    }
    return result;

}

boolean test_round_robin_policy() {
 550:	55                   	push   %ebp
    return test_policy_helper(null, null);
 551:	31 c0                	xor    %eax,%eax
    }
    return result;

}

boolean test_round_robin_policy() {
 553:	89 e5                	mov    %esp,%ebp
 555:	83 ec 18             	sub    $0x18,%esp
    return test_policy_helper(null, null);
 558:	89 44 24 04          	mov    %eax,0x4(%esp)
 55c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 563:	e8 08 ff ff ff       	call   470 <test_policy_helper>

}
 568:	c9                   	leave  
 569:	c3                   	ret    
 56a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000570 <test_priority_policy>:

boolean test_priority_policy() {
 570:	55                   	push   %ebp
 571:	89 e5                	mov    %esp,%ebp
 573:	53                   	push   %ebx
 574:	83 ec 24             	sub    $0x24,%esp
    int priority_mod = 10;
    policy(PRIORITY);
 577:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    return test_policy_helper(null, null);

}

boolean test_priority_policy() {
    int priority_mod = 10;
 57e:	c7 45 f4 0a 00 00 00 	movl   $0xa,-0xc(%ebp)
    policy(PRIORITY);
 585:	e8 de 05 00 00       	call   b68 <policy>
    boolean result = test_policy_helper(&priority_mod, PRIORITY);
 58a:	b8 02 00 00 00       	mov    $0x2,%eax
 58f:	89 44 24 04          	mov    %eax,0x4(%esp)
 593:	8d 45 f4             	lea    -0xc(%ebp),%eax
 596:	89 04 24             	mov    %eax,(%esp)
 599:	e8 d2 fe ff ff       	call   470 <test_policy_helper>
    policy(ROUND_ROBIN);
 59e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
}

boolean test_priority_policy() {
    int priority_mod = 10;
    policy(PRIORITY);
    boolean result = test_policy_helper(&priority_mod, PRIORITY);
 5a5:	89 c3                	mov    %eax,%ebx
    policy(ROUND_ROBIN);
 5a7:	e8 bc 05 00 00       	call   b68 <policy>
    return result;
}
 5ac:	83 c4 24             	add    $0x24,%esp
 5af:	89 d8                	mov    %ebx,%eax
 5b1:	5b                   	pop    %ebx
 5b2:	5d                   	pop    %ebp
 5b3:	c3                   	ret    
 5b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000005c0 <test_extended_priority_policy>:

boolean test_extended_priority_policy() {
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	53                   	push   %ebx
 5c4:	83 ec 24             	sub    $0x24,%esp
    int priority_mod = 10;
    policy(EXTENED_PRIORITY);
 5c7:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
    policy(ROUND_ROBIN);
    return result;
}

boolean test_extended_priority_policy() {
    int priority_mod = 10;
 5ce:	c7 45 f4 0a 00 00 00 	movl   $0xa,-0xc(%ebp)
    policy(EXTENED_PRIORITY);
 5d5:	e8 8e 05 00 00       	call   b68 <policy>
    boolean result = test_policy_helper(&priority_mod, EXTENED_PRIORITY);
 5da:	b8 03 00 00 00       	mov    $0x3,%eax
 5df:	89 44 24 04          	mov    %eax,0x4(%esp)
 5e3:	8d 45 f4             	lea    -0xc(%ebp),%eax
 5e6:	89 04 24             	mov    %eax,(%esp)
 5e9:	e8 82 fe ff ff       	call   470 <test_policy_helper>
    policy(ROUND_ROBIN);
 5ee:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
}

boolean test_extended_priority_policy() {
    int priority_mod = 10;
    policy(EXTENED_PRIORITY);
    boolean result = test_policy_helper(&priority_mod, EXTENED_PRIORITY);
 5f5:	89 c3                	mov    %eax,%ebx
    policy(ROUND_ROBIN);
 5f7:	e8 6c 05 00 00       	call   b68 <policy>
    return result;
}
 5fc:	83 c4 24             	add    $0x24,%esp
 5ff:	89 d8                	mov    %ebx,%eax
 601:	5b                   	pop    %ebx
 602:	5d                   	pop    %ebp
 603:	c3                   	ret    
 604:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 60a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000610 <wait_stat>:
boolean  wait_stat( int * stat , struct perf *p)
{
 610:	55                   	push   %ebp
    return true;
}
 611:	b8 01 00 00 00       	mov    $0x1,%eax
    boolean result = test_policy_helper(&priority_mod, EXTENED_PRIORITY);
    policy(ROUND_ROBIN);
    return result;
}
boolean  wait_stat( int * stat , struct perf *p)
{
 616:	89 e5                	mov    %esp,%ebp
    return true;
}
 618:	5d                   	pop    %ebp
 619:	c3                   	ret    
 61a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000620 <test_performance_helper>:
boolean test_performance_helper(int *npriority) {
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	53                   	push   %ebx
 624:	83 ec 34             	sub    $0x34,%esp
    int pid1;
    struct perf perf2;
    pid1 = fork();
 627:	e8 94 04 00 00       	call   ac0 <fork>
    if (pid1 > 0) {
 62c:	85 c0                	test   %eax,%eax
 62e:	7f 34                	jg     664 <test_performance_helper+0x44>
 630:	bb 64 00 00 00       	mov    $0x64,%ebx
 635:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    } else {
        for (int a = 0; a < 100; ++a) {
            int pid;
            struct perf perf1;

            pid = fork();
 640:	e8 7b 04 00 00       	call   ac0 <fork>
            // the child pid is pid
            if (pid > 0) {
 645:	85 c0                	test   %eax,%eax
 647:	7e 31                	jle    67a <test_performance_helper+0x5a>
                int status;
                sleep(5);
 649:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 650:	e8 03 05 00 00       	call   b58 <sleep>
    if (pid1 > 0) {
        int status1;
        wait_stat(&status1, &perf2);
        print_perf(&perf2);
    } else {
        for (int a = 0; a < 100; ++a) {
 655:	4b                   	dec    %ebx
 656:	75 e8                	jne    640 <test_performance_helper+0x20>
                }
                sleep(5);
                exit(0);
            }
        }
        exit(0);
 658:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 65f:	e8 64 04 00 00       	call   ac8 <exit>
    struct perf perf2;
    pid1 = fork();
    if (pid1 > 0) {
        int status1;
        wait_stat(&status1, &perf2);
        print_perf(&perf2);
 664:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 667:	89 04 24             	mov    %eax,(%esp)
 66a:	e8 81 fc ff ff       	call   2f0 <print_perf>
            }
        }
        exit(0);
    }
    return true;
}
 66f:	83 c4 34             	add    $0x34,%esp
 672:	b8 01 00 00 00       	mov    $0x1,%eax
 677:	5b                   	pop    %ebx
 678:	5d                   	pop    %ebp
 679:	c3                   	ret    
            if (pid > 0) {
                int status;
                sleep(5);
                wait_stat(&status, &perf1);
            } else {
                if (npriority)
 67a:	8b 45 08             	mov    0x8(%ebp),%eax
 67d:	85 c0                	test   %eax,%eax
 67f:	74 0d                	je     68e <test_performance_helper+0x6e>
                    priority(*npriority);
 681:	8b 45 08             	mov    0x8(%ebp),%eax
 684:	8b 00                	mov    (%eax),%eax
 686:	89 04 24             	mov    %eax,(%esp)
 689:	e8 ea 04 00 00       	call   b78 <priority>
                for (int i = 0; i < 100000000; ++i) {
                    for (int j = 0; j < 100000000; ++j) {
                        ++sum;
                    }
                }
                sleep(5);
 68e:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 695:	e8 be 04 00 00       	call   b58 <sleep>
                exit(0);
 69a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 6a1:	e8 22 04 00 00       	call   ac8 <exit>
 6a6:	8d 76 00             	lea    0x0(%esi),%esi
 6a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006b0 <test_starvation_helper>:
    }
    return true;
}


boolean test_starvation_helper(int npolicy, int npriority) {
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	57                   	push   %edi
 6b4:	56                   	push   %esi
    boolean result = true;
    policy(npolicy);
    int nProcs = 10;
    int pid_arr[nProcs];
    int pid;
    memset(&pid_arr, 0, nProcs * sizeof(int));
 6b5:	31 f6                	xor    %esi,%esi
    }
    return true;
}


boolean test_starvation_helper(int npolicy, int npriority) {
 6b7:	53                   	push   %ebx
    boolean result = true;
    policy(npolicy);
    int nProcs = 10;
    int pid_arr[nProcs];
    int pid;
    memset(&pid_arr, 0, nProcs * sizeof(int));
 6b8:	bb 28 00 00 00       	mov    $0x28,%ebx
    }
    return true;
}


boolean test_starvation_helper(int npolicy, int npriority) {
 6bd:	83 ec 5c             	sub    $0x5c,%esp
    boolean result = true;
    policy(npolicy);
 6c0:	8b 45 08             	mov    0x8(%ebp),%eax
 6c3:	89 04 24             	mov    %eax,(%esp)
 6c6:	e8 9d 04 00 00       	call   b68 <policy>
    int nProcs = 10;
    int pid_arr[nProcs];
    int pid;
    memset(&pid_arr, 0, nProcs * sizeof(int));
 6cb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 6cf:	8d 5d c0             	lea    -0x40(%ebp),%ebx
 6d2:	89 74 24 04          	mov    %esi,0x4(%esp)
    for (int i = 0; i < nProcs; ++i) {
 6d6:	31 f6                	xor    %esi,%esi
    boolean result = true;
    policy(npolicy);
    int nProcs = 10;
    int pid_arr[nProcs];
    int pid;
    memset(&pid_arr, 0, nProcs * sizeof(int));
 6d8:	89 1c 24             	mov    %ebx,(%esp)
 6db:	e8 40 02 00 00       	call   920 <memset>
    for (int i = 0; i < nProcs; ++i) {
        pid = fork();
 6e0:	e8 db 03 00 00       	call   ac0 <fork>
        if (pid < 0) {
 6e5:	85 c0                	test   %eax,%eax
 6e7:	78 0f                	js     6f8 <test_starvation_helper+0x48>
            break;
        } else if (pid == 0) {
 6e9:	0f 84 a1 00 00 00    	je     790 <test_starvation_helper+0xe0>
            sleep(5);
            priority(npriority);
            for (;;) {};
        } else {
            pid_arr[i] = pid;
 6ef:	89 04 b3             	mov    %eax,(%ebx,%esi,4)
    policy(npolicy);
    int nProcs = 10;
    int pid_arr[nProcs];
    int pid;
    memset(&pid_arr, 0, nProcs * sizeof(int));
    for (int i = 0; i < nProcs; ++i) {
 6f2:	46                   	inc    %esi
 6f3:	83 fe 0a             	cmp    $0xa,%esi
 6f6:	75 e8                	jne    6e0 <test_starvation_helper+0x30>
            for (;;) {};
        } else {
            pid_arr[i] = pid;
        }
    }
    sleep(100);
 6f8:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 6ff:	8d 7d e8             	lea    -0x18(%ebp),%edi
    return true;
}


boolean test_starvation_helper(int npolicy, int npriority) {
    boolean result = true;
 702:	be 01 00 00 00       	mov    $0x1,%esi
            for (;;) {};
        } else {
            pid_arr[i] = pid;
        }
    }
    sleep(100);
 707:	e8 4c 04 00 00       	call   b58 <sleep>
 70c:	eb 15                	jmp    723 <test_starvation_helper+0x73>
 70e:	66 90                	xchg   %ax,%ax
    for (int j = 0; j < nProcs; ++j) {
        if (pid_arr[j] != 0) {
            result = result && assert_equals(0, kill(pid_arr[j]), "failed to kill child (yes it does sound horrible)");
            wait(null);
 710:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 717:	e8 b4 03 00 00       	call   ad0 <wait>
 71c:	83 c3 04             	add    $0x4,%ebx
        } else {
            pid_arr[i] = pid;
        }
    }
    sleep(100);
    for (int j = 0; j < nProcs; ++j) {
 71f:	39 df                	cmp    %ebx,%edi
 721:	74 4d                	je     770 <test_starvation_helper+0xc0>
        if (pid_arr[j] != 0) {
 723:	8b 03                	mov    (%ebx),%eax
 725:	85 c0                	test   %eax,%eax
 727:	74 f3                	je     71c <test_starvation_helper+0x6c>
            result = result && assert_equals(0, kill(pid_arr[j]), "failed to kill child (yes it does sound horrible)");
 729:	85 f6                	test   %esi,%esi
 72b:	74 e3                	je     710 <test_starvation_helper+0x60>
 72d:	89 04 24             	mov    %eax,(%esp)
 730:	be 01 00 00 00       	mov    $0x1,%esi
 735:	e8 be 03 00 00       	call   af8 <kill>
        printf(1, "========== Test - %s: Failed ==========\n", name);
    }
}

boolean assert_equals(int expected, int actual, char *msg) {
    if (expected != actual) {
 73a:	85 c0                	test   %eax,%eax
 73c:	74 d2                	je     710 <test_starvation_helper+0x60>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
 73e:	89 44 24 10          	mov    %eax,0x10(%esp)
 742:	ba 14 11 00 00       	mov    $0x1114,%edx
 747:	31 c0                	xor    %eax,%eax
 749:	b9 68 10 00 00       	mov    $0x1068,%ecx
        }
    }
    sleep(100);
    for (int j = 0; j < nProcs; ++j) {
        if (pid_arr[j] != 0) {
            result = result && assert_equals(0, kill(pid_arr[j]), "failed to kill child (yes it does sound horrible)");
 74e:	31 f6                	xor    %esi,%esi
    }
}

boolean assert_equals(int expected, int actual, char *msg) {
    if (expected != actual) {
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
 750:	89 44 24 0c          	mov    %eax,0xc(%esp)
 754:	89 54 24 08          	mov    %edx,0x8(%esp)
 758:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 75c:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 763:	e8 c8 04 00 00       	call   c30 <printf>
 768:	eb a6                	jmp    710 <test_starvation_helper+0x60>
 76a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        if (pid_arr[j] != 0) {
            result = result && assert_equals(0, kill(pid_arr[j]), "failed to kill child (yes it does sound horrible)");
            wait(null);
        }
    }
    policy(ROUND_ROBIN);
 770:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 777:	e8 ec 03 00 00       	call   b68 <policy>
    return result;
}
 77c:	83 c4 5c             	add    $0x5c,%esp
 77f:	89 f0                	mov    %esi,%eax
 781:	5b                   	pop    %ebx
 782:	5e                   	pop    %esi
 783:	5f                   	pop    %edi
 784:	5d                   	pop    %ebp
 785:	c3                   	ret    
 786:	8d 76 00             	lea    0x0(%esi),%esi
 789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    for (int i = 0; i < nProcs; ++i) {
        pid = fork();
        if (pid < 0) {
            break;
        } else if (pid == 0) {
            sleep(5);
 790:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 797:	e8 bc 03 00 00       	call   b58 <sleep>
            priority(npriority);
 79c:	8b 45 0c             	mov    0xc(%ebp),%eax
 79f:	89 04 24             	mov    %eax,(%esp)
 7a2:	e8 d1 03 00 00       	call   b78 <priority>
 7a7:	eb fe                	jmp    7a7 <test_starvation_helper+0xf7>
 7a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000007b0 <test_accumulator>:
}

/**
 * test the growth of accumulator
 */
boolean test_accumulator() {
 7b0:	55                   	push   %ebp
    return test_starvation_helper(PRIORITY, 2);
 7b1:	b8 02 00 00 00       	mov    $0x2,%eax
}

/**
 * test the growth of accumulator
 */
boolean test_accumulator() {
 7b6:	89 e5                	mov    %esp,%ebp
 7b8:	83 ec 18             	sub    $0x18,%esp
    return test_starvation_helper(PRIORITY, 2);
 7bb:	89 44 24 04          	mov    %eax,0x4(%esp)
 7bf:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 7c6:	e8 e5 fe ff ff       	call   6b0 <test_starvation_helper>
}
 7cb:	c9                   	leave  
 7cc:	c3                   	ret    
 7cd:	8d 76 00             	lea    0x0(%esi),%esi

000007d0 <test_starvation>:

/** I hope this does test the case of
   starvation in extended priority
   (where the priority is 0)
*/
boolean test_starvation() {
 7d0:	55                   	push   %ebp
    return test_starvation_helper(EXTENED_PRIORITY, 0);
 7d1:	31 c0                	xor    %eax,%eax

/** I hope this does test the case of
   starvation in extended priority
   (where the priority is 0)
*/
boolean test_starvation() {
 7d3:	89 e5                	mov    %esp,%ebp
 7d5:	83 ec 18             	sub    $0x18,%esp
    return test_starvation_helper(EXTENED_PRIORITY, 0);
 7d8:	89 44 24 04          	mov    %eax,0x4(%esp)
 7dc:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
 7e3:	e8 c8 fe ff ff       	call   6b0 <test_starvation_helper>
}
 7e8:	c9                   	leave  
 7e9:	c3                   	ret    
 7ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000007f0 <test_performance_round_robin>:


boolean test_performance_round_robin() {
 7f0:	55                   	push   %ebp
 7f1:	89 e5                	mov    %esp,%ebp
 7f3:	83 ec 18             	sub    $0x18,%esp
    return test_performance_helper(null);
 7f6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 7fd:	e8 1e fe ff ff       	call   620 <test_performance_helper>
}
 802:	c9                   	leave  
 803:	c3                   	ret    
 804:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 80a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000810 <test_performance_priority>:

boolean test_performance_priority() {
 810:	55                   	push   %ebp
 811:	89 e5                	mov    %esp,%ebp
 813:	53                   	push   %ebx
 814:	83 ec 24             	sub    $0x24,%esp
    policy(PRIORITY);
 817:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 81e:	e8 45 03 00 00       	call   b68 <policy>
    int npriority = 2;
    boolean result = test_performance_helper(&npriority);
 823:	8d 45 f4             	lea    -0xc(%ebp),%eax
 826:	89 04 24             	mov    %eax,(%esp)
    return test_performance_helper(null);
}

boolean test_performance_priority() {
    policy(PRIORITY);
    int npriority = 2;
 829:	c7 45 f4 02 00 00 00 	movl   $0x2,-0xc(%ebp)
    boolean result = test_performance_helper(&npriority);
 830:	e8 eb fd ff ff       	call   620 <test_performance_helper>
    policy(ROUND_ROBIN);
 835:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
}

boolean test_performance_priority() {
    policy(PRIORITY);
    int npriority = 2;
    boolean result = test_performance_helper(&npriority);
 83c:	89 c3                	mov    %eax,%ebx
    policy(ROUND_ROBIN);
 83e:	e8 25 03 00 00       	call   b68 <policy>
    return result;

}
 843:	83 c4 24             	add    $0x24,%esp
 846:	89 d8                	mov    %ebx,%eax
 848:	5b                   	pop    %ebx
 849:	5d                   	pop    %ebp
 84a:	c3                   	ret    
 84b:	90                   	nop
 84c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000850 <test_performance_extended_priority>:

boolean test_performance_extended_priority() {
 850:	55                   	push   %ebp
 851:	89 e5                	mov    %esp,%ebp
 853:	53                   	push   %ebx
 854:	83 ec 24             	sub    $0x24,%esp
    policy(EXTENED_PRIORITY);
 857:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
 85e:	e8 05 03 00 00       	call   b68 <policy>
    int npriority = 0;
    boolean result = test_performance_helper(&npriority);
 863:	8d 45 f4             	lea    -0xc(%ebp),%eax
 866:	89 04 24             	mov    %eax,(%esp)

}

boolean test_performance_extended_priority() {
    policy(EXTENED_PRIORITY);
    int npriority = 0;
 869:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    boolean result = test_performance_helper(&npriority);
 870:	e8 ab fd ff ff       	call   620 <test_performance_helper>
    policy(ROUND_ROBIN);
 875:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
}

boolean test_performance_extended_priority() {
    policy(EXTENED_PRIORITY);
    int npriority = 0;
    boolean result = test_performance_helper(&npriority);
 87c:	89 c3                	mov    %eax,%ebx
    policy(ROUND_ROBIN);
 87e:	e8 e5 02 00 00       	call   b68 <policy>
    return result;

}
 883:	83 c4 24             	add    $0x24,%esp
 886:	89 d8                	mov    %ebx,%eax
 888:	5b                   	pop    %ebx
 889:	5d                   	pop    %ebp
 88a:	c3                   	ret    
 88b:	66 90                	xchg   %ax,%ax
 88d:	66 90                	xchg   %ax,%ax
 88f:	90                   	nop

00000890 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 890:	55                   	push   %ebp
 891:	89 e5                	mov    %esp,%ebp
 893:	8b 45 08             	mov    0x8(%ebp),%eax
 896:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 899:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 89a:	89 c2                	mov    %eax,%edx
 89c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 8a0:	41                   	inc    %ecx
 8a1:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 8a5:	42                   	inc    %edx
 8a6:	84 db                	test   %bl,%bl
 8a8:	88 5a ff             	mov    %bl,-0x1(%edx)
 8ab:	75 f3                	jne    8a0 <strcpy+0x10>
    ;
  return os;
}
 8ad:	5b                   	pop    %ebx
 8ae:	5d                   	pop    %ebp
 8af:	c3                   	ret    

000008b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 8b0:	55                   	push   %ebp
 8b1:	89 e5                	mov    %esp,%ebp
 8b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 8b6:	56                   	push   %esi
 8b7:	53                   	push   %ebx
 8b8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 8bb:	0f b6 01             	movzbl (%ecx),%eax
 8be:	0f b6 13             	movzbl (%ebx),%edx
 8c1:	84 c0                	test   %al,%al
 8c3:	75 1c                	jne    8e1 <strcmp+0x31>
 8c5:	eb 29                	jmp    8f0 <strcmp+0x40>
 8c7:	89 f6                	mov    %esi,%esi
 8c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 8d0:	41                   	inc    %ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 8d1:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 8d4:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 8d7:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 8db:	84 c0                	test   %al,%al
 8dd:	74 11                	je     8f0 <strcmp+0x40>
 8df:	89 f3                	mov    %esi,%ebx
 8e1:	38 d0                	cmp    %dl,%al
 8e3:	74 eb                	je     8d0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 8e5:	5b                   	pop    %ebx
int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    p++, q++;
  return (uchar)*p - (uchar)*q;
 8e6:	29 d0                	sub    %edx,%eax
}
 8e8:	5e                   	pop    %esi
 8e9:	5d                   	pop    %ebp
 8ea:	c3                   	ret    
 8eb:	90                   	nop
 8ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 8f0:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 8f1:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 8f3:	29 d0                	sub    %edx,%eax
}
 8f5:	5e                   	pop    %esi
 8f6:	5d                   	pop    %ebp
 8f7:	c3                   	ret    
 8f8:	90                   	nop
 8f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000900 <strlen>:

uint
strlen(const char *s)
{
 900:	55                   	push   %ebp
 901:	89 e5                	mov    %esp,%ebp
 903:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 906:	80 39 00             	cmpb   $0x0,(%ecx)
 909:	74 10                	je     91b <strlen+0x1b>
 90b:	31 d2                	xor    %edx,%edx
 90d:	8d 76 00             	lea    0x0(%esi),%esi
 910:	42                   	inc    %edx
 911:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 915:	89 d0                	mov    %edx,%eax
 917:	75 f7                	jne    910 <strlen+0x10>
    ;
  return n;
}
 919:	5d                   	pop    %ebp
 91a:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 91b:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 91d:	5d                   	pop    %ebp
 91e:	c3                   	ret    
 91f:	90                   	nop

00000920 <memset>:

void*
memset(void *dst, int c, uint n)
{
 920:	55                   	push   %ebp
 921:	89 e5                	mov    %esp,%ebp
 923:	8b 55 08             	mov    0x8(%ebp),%edx
 926:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 927:	8b 4d 10             	mov    0x10(%ebp),%ecx
 92a:	8b 45 0c             	mov    0xc(%ebp),%eax
 92d:	89 d7                	mov    %edx,%edi
 92f:	fc                   	cld    
 930:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 932:	5f                   	pop    %edi
 933:	89 d0                	mov    %edx,%eax
 935:	5d                   	pop    %ebp
 936:	c3                   	ret    
 937:	89 f6                	mov    %esi,%esi
 939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000940 <strchr>:

char*
strchr(const char *s, char c)
{
 940:	55                   	push   %ebp
 941:	89 e5                	mov    %esp,%ebp
 943:	8b 45 08             	mov    0x8(%ebp),%eax
 946:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 94a:	0f b6 10             	movzbl (%eax),%edx
 94d:	84 d2                	test   %dl,%dl
 94f:	74 1b                	je     96c <strchr+0x2c>
    if(*s == c)
 951:	38 d1                	cmp    %dl,%cl
 953:	75 0f                	jne    964 <strchr+0x24>
 955:	eb 17                	jmp    96e <strchr+0x2e>
 957:	89 f6                	mov    %esi,%esi
 959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 960:	38 ca                	cmp    %cl,%dl
 962:	74 0a                	je     96e <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 964:	40                   	inc    %eax
 965:	0f b6 10             	movzbl (%eax),%edx
 968:	84 d2                	test   %dl,%dl
 96a:	75 f4                	jne    960 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 96c:	31 c0                	xor    %eax,%eax
}
 96e:	5d                   	pop    %ebp
 96f:	c3                   	ret    

00000970 <gets>:

char*
gets(char *buf, int max)
{
 970:	55                   	push   %ebp
 971:	89 e5                	mov    %esp,%ebp
 973:	57                   	push   %edi
 974:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 975:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
 977:	53                   	push   %ebx
 978:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 97b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 97e:	eb 32                	jmp    9b2 <gets+0x42>
    cc = read(0, &c, 1);
 980:	b8 01 00 00 00       	mov    $0x1,%eax
 985:	89 44 24 08          	mov    %eax,0x8(%esp)
 989:	89 7c 24 04          	mov    %edi,0x4(%esp)
 98d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 994:	e8 47 01 00 00       	call   ae0 <read>
    if(cc < 1)
 999:	85 c0                	test   %eax,%eax
 99b:	7e 1d                	jle    9ba <gets+0x4a>
      break;
    buf[i++] = c;
 99d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 9a1:	89 de                	mov    %ebx,%esi
 9a3:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 9a6:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 9a8:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 9ac:	74 22                	je     9d0 <gets+0x60>
 9ae:	3c 0d                	cmp    $0xd,%al
 9b0:	74 1e                	je     9d0 <gets+0x60>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 9b2:	8d 5e 01             	lea    0x1(%esi),%ebx
 9b5:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 9b8:	7c c6                	jl     980 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 9ba:	8b 45 08             	mov    0x8(%ebp),%eax
 9bd:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 9c1:	83 c4 2c             	add    $0x2c,%esp
 9c4:	5b                   	pop    %ebx
 9c5:	5e                   	pop    %esi
 9c6:	5f                   	pop    %edi
 9c7:	5d                   	pop    %ebp
 9c8:	c3                   	ret    
 9c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 9d0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 9d3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 9d5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 9d9:	83 c4 2c             	add    $0x2c,%esp
 9dc:	5b                   	pop    %ebx
 9dd:	5e                   	pop    %esi
 9de:	5f                   	pop    %edi
 9df:	5d                   	pop    %ebp
 9e0:	c3                   	ret    
 9e1:	eb 0d                	jmp    9f0 <stat>
 9e3:	90                   	nop
 9e4:	90                   	nop
 9e5:	90                   	nop
 9e6:	90                   	nop
 9e7:	90                   	nop
 9e8:	90                   	nop
 9e9:	90                   	nop
 9ea:	90                   	nop
 9eb:	90                   	nop
 9ec:	90                   	nop
 9ed:	90                   	nop
 9ee:	90                   	nop
 9ef:	90                   	nop

000009f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 9f0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 9f1:	31 c0                	xor    %eax,%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 9f3:	89 e5                	mov    %esp,%ebp
 9f5:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 9f8:	89 44 24 04          	mov    %eax,0x4(%esp)
 9fc:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 9ff:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 a02:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 a05:	89 04 24             	mov    %eax,(%esp)
 a08:	e8 fb 00 00 00       	call   b08 <open>
  if(fd < 0)
 a0d:	85 c0                	test   %eax,%eax
 a0f:	78 2f                	js     a40 <stat+0x50>
 a11:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 a13:	8b 45 0c             	mov    0xc(%ebp),%eax
 a16:	89 1c 24             	mov    %ebx,(%esp)
 a19:	89 44 24 04          	mov    %eax,0x4(%esp)
 a1d:	e8 fe 00 00 00       	call   b20 <fstat>
  close(fd);
 a22:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 a25:	89 c6                	mov    %eax,%esi
  close(fd);
 a27:	e8 c4 00 00 00       	call   af0 <close>
  return r;
 a2c:	89 f0                	mov    %esi,%eax
}
 a2e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 a31:	8b 75 fc             	mov    -0x4(%ebp),%esi
 a34:	89 ec                	mov    %ebp,%esp
 a36:	5d                   	pop    %ebp
 a37:	c3                   	ret    
 a38:	90                   	nop
 a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 a40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a45:	eb e7                	jmp    a2e <stat+0x3e>
 a47:	89 f6                	mov    %esi,%esi
 a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a50 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 a50:	55                   	push   %ebp
 a51:	89 e5                	mov    %esp,%ebp
 a53:	8b 4d 08             	mov    0x8(%ebp),%ecx
 a56:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 a57:	0f be 11             	movsbl (%ecx),%edx
 a5a:	88 d0                	mov    %dl,%al
 a5c:	2c 30                	sub    $0x30,%al
 a5e:	3c 09                	cmp    $0x9,%al
 a60:	b8 00 00 00 00       	mov    $0x0,%eax
 a65:	77 1e                	ja     a85 <atoi+0x35>
 a67:	89 f6                	mov    %esi,%esi
 a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 a70:	41                   	inc    %ecx
 a71:	8d 04 80             	lea    (%eax,%eax,4),%eax
 a74:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 a78:	0f be 11             	movsbl (%ecx),%edx
 a7b:	88 d3                	mov    %dl,%bl
 a7d:	80 eb 30             	sub    $0x30,%bl
 a80:	80 fb 09             	cmp    $0x9,%bl
 a83:	76 eb                	jbe    a70 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 a85:	5b                   	pop    %ebx
 a86:	5d                   	pop    %ebp
 a87:	c3                   	ret    
 a88:	90                   	nop
 a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000a90 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 a90:	55                   	push   %ebp
 a91:	89 e5                	mov    %esp,%ebp
 a93:	56                   	push   %esi
 a94:	8b 45 08             	mov    0x8(%ebp),%eax
 a97:	53                   	push   %ebx
 a98:	8b 5d 10             	mov    0x10(%ebp),%ebx
 a9b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 a9e:	85 db                	test   %ebx,%ebx
 aa0:	7e 1a                	jle    abc <memmove+0x2c>
 aa2:	31 d2                	xor    %edx,%edx
 aa4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 aaa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 ab0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 ab4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 ab7:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 ab8:	39 da                	cmp    %ebx,%edx
 aba:	75 f4                	jne    ab0 <memmove+0x20>
    *dst++ = *src++;
  return vdst;
}
 abc:	5b                   	pop    %ebx
 abd:	5e                   	pop    %esi
 abe:	5d                   	pop    %ebp
 abf:	c3                   	ret    

00000ac0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 ac0:	b8 01 00 00 00       	mov    $0x1,%eax
 ac5:	cd 40                	int    $0x40
 ac7:	c3                   	ret    

00000ac8 <exit>:
SYSCALL(exit)
 ac8:	b8 02 00 00 00       	mov    $0x2,%eax
 acd:	cd 40                	int    $0x40
 acf:	c3                   	ret    

00000ad0 <wait>:
SYSCALL(wait)
 ad0:	b8 03 00 00 00       	mov    $0x3,%eax
 ad5:	cd 40                	int    $0x40
 ad7:	c3                   	ret    

00000ad8 <pipe>:
SYSCALL(pipe)
 ad8:	b8 04 00 00 00       	mov    $0x4,%eax
 add:	cd 40                	int    $0x40
 adf:	c3                   	ret    

00000ae0 <read>:
SYSCALL(read)
 ae0:	b8 05 00 00 00       	mov    $0x5,%eax
 ae5:	cd 40                	int    $0x40
 ae7:	c3                   	ret    

00000ae8 <write>:
SYSCALL(write)
 ae8:	b8 10 00 00 00       	mov    $0x10,%eax
 aed:	cd 40                	int    $0x40
 aef:	c3                   	ret    

00000af0 <close>:
SYSCALL(close)
 af0:	b8 15 00 00 00       	mov    $0x15,%eax
 af5:	cd 40                	int    $0x40
 af7:	c3                   	ret    

00000af8 <kill>:
SYSCALL(kill)
 af8:	b8 06 00 00 00       	mov    $0x6,%eax
 afd:	cd 40                	int    $0x40
 aff:	c3                   	ret    

00000b00 <exec>:
SYSCALL(exec)
 b00:	b8 07 00 00 00       	mov    $0x7,%eax
 b05:	cd 40                	int    $0x40
 b07:	c3                   	ret    

00000b08 <open>:
SYSCALL(open)
 b08:	b8 0f 00 00 00       	mov    $0xf,%eax
 b0d:	cd 40                	int    $0x40
 b0f:	c3                   	ret    

00000b10 <mknod>:
SYSCALL(mknod)
 b10:	b8 11 00 00 00       	mov    $0x11,%eax
 b15:	cd 40                	int    $0x40
 b17:	c3                   	ret    

00000b18 <unlink>:
SYSCALL(unlink)
 b18:	b8 12 00 00 00       	mov    $0x12,%eax
 b1d:	cd 40                	int    $0x40
 b1f:	c3                   	ret    

00000b20 <fstat>:
SYSCALL(fstat)
 b20:	b8 08 00 00 00       	mov    $0x8,%eax
 b25:	cd 40                	int    $0x40
 b27:	c3                   	ret    

00000b28 <link>:
SYSCALL(link)
 b28:	b8 13 00 00 00       	mov    $0x13,%eax
 b2d:	cd 40                	int    $0x40
 b2f:	c3                   	ret    

00000b30 <mkdir>:
SYSCALL(mkdir)
 b30:	b8 14 00 00 00       	mov    $0x14,%eax
 b35:	cd 40                	int    $0x40
 b37:	c3                   	ret    

00000b38 <chdir>:
SYSCALL(chdir)
 b38:	b8 09 00 00 00       	mov    $0x9,%eax
 b3d:	cd 40                	int    $0x40
 b3f:	c3                   	ret    

00000b40 <dup>:
SYSCALL(dup)
 b40:	b8 0a 00 00 00       	mov    $0xa,%eax
 b45:	cd 40                	int    $0x40
 b47:	c3                   	ret    

00000b48 <getpid>:
SYSCALL(getpid)
 b48:	b8 0b 00 00 00       	mov    $0xb,%eax
 b4d:	cd 40                	int    $0x40
 b4f:	c3                   	ret    

00000b50 <sbrk>:
SYSCALL(sbrk)
 b50:	b8 0c 00 00 00       	mov    $0xc,%eax
 b55:	cd 40                	int    $0x40
 b57:	c3                   	ret    

00000b58 <sleep>:
SYSCALL(sleep)
 b58:	b8 0d 00 00 00       	mov    $0xd,%eax
 b5d:	cd 40                	int    $0x40
 b5f:	c3                   	ret    

00000b60 <uptime>:
SYSCALL(uptime)
 b60:	b8 0e 00 00 00       	mov    $0xe,%eax
 b65:	cd 40                	int    $0x40
 b67:	c3                   	ret    

00000b68 <policy>:
SYSCALL(policy)
 b68:	b8 17 00 00 00       	mov    $0x17,%eax
 b6d:	cd 40                	int    $0x40
 b6f:	c3                   	ret    

00000b70 <detach>:
SYSCALL(detach)
 b70:	b8 16 00 00 00       	mov    $0x16,%eax
 b75:	cd 40                	int    $0x40
 b77:	c3                   	ret    

00000b78 <priority>:
SYSCALL(priority)
 b78:	b8 18 00 00 00       	mov    $0x18,%eax
 b7d:	cd 40                	int    $0x40
 b7f:	c3                   	ret    

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
 bc9:	0f b6 92 50 11 00 00 	movzbl 0x1150(%edx),%edx
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
 c07:	e8 dc fe ff ff       	call   ae8 <write>
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
 c7b:	e8 68 fe ff ff       	call   ae8 <write>
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
 ce6:	e8 fd fd ff ff       	call   ae8 <write>
 ceb:	ba 01 00 00 00       	mov    $0x1,%edx
 cf0:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 cf3:	89 54 24 08          	mov    %edx,0x8(%esp)
 cf7:	89 44 24 04          	mov    %eax,0x4(%esp)
 cfb:	89 3c 24             	mov    %edi,(%esp)
 cfe:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 d01:	e8 e2 fd ff ff       	call   ae8 <write>
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
 d5b:	b8 48 11 00 00       	mov    $0x1148,%eax
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
 d87:	e8 5c fd ff ff       	call   ae8 <write>
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
 db6:	e8 2d fd ff ff       	call   ae8 <write>
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
 df4:	e8 ef fc ff ff       	call   ae8 <write>
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
 e11:	a1 e8 16 00 00       	mov    0x16e8,%eax
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
 e6a:	a3 e8 16 00 00       	mov    %eax,0x16e8
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
 e8f:	a3 e8 16 00 00       	mov    %eax,0x16e8
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
 ebc:	8b 15 e8 16 00 00    	mov    0x16e8,%edx
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
 f09:	39 05 e8 16 00 00    	cmp    %eax,0x16e8
 f0f:	89 c2                	mov    %eax,%edx
 f11:	75 ed                	jne    f00 <malloc+0x50>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 f13:	89 1c 24             	mov    %ebx,(%esp)
 f16:	e8 35 fc ff ff       	call   b50 <sbrk>
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
 f2e:	8b 15 e8 16 00 00    	mov    0x16e8,%edx
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
 f4f:	89 15 e8 16 00 00    	mov    %edx,0x16e8
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
 f66:	b8 ec 16 00 00       	mov    $0x16ec,%eax
 f6b:	ba ec 16 00 00       	mov    $0x16ec,%edx
    base.s.size = 0;
 f70:	31 c9                	xor    %ecx,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 f72:	a3 e8 16 00 00       	mov    %eax,0x16e8
    base.s.size = 0;
 f77:	b8 ec 16 00 00       	mov    $0x16ec,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 f7c:	89 15 ec 16 00 00    	mov    %edx,0x16ec
    base.s.size = 0;
 f82:	89 0d f0 16 00 00    	mov    %ecx,0x16f0
 f88:	e9 4d ff ff ff       	jmp    eda <malloc+0x2a>
