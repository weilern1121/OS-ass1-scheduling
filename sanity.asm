
_sanity:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    return result;

}


int main(void) {
   0:	55                   	push   %ebp
    run_test(&test_round_robin_policy, "round robin policy");
    run_test(&test_priority_policy, "priority policy");
    run_test(&test_extended_priority_policy, "extended priority policy");
    run_test(&test_accumulator, "accumulator");
    run_test(&test_starvation, "starvation");*/
    run_test(&test_performance_round_robin, "performance round robin");
   1:	b8 61 11 00 00       	mov    $0x1161,%eax
int main(void) {
   6:	89 e5                	mov    %esp,%ebp
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	83 ec 10             	sub    $0x10,%esp
    run_test(&test_performance_round_robin, "performance round robin");
   e:	89 44 24 04          	mov    %eax,0x4(%esp)
  12:	c7 04 24 f0 06 00 00 	movl   $0x6f0,(%esp)
  19:	e8 42 00 00 00       	call   60 <run_test>
    run_test(&test_performance_priority, "performance priority");
  1e:	ba 79 11 00 00       	mov    $0x1179,%edx
  23:	89 54 24 04          	mov    %edx,0x4(%esp)
  27:	c7 04 24 10 07 00 00 	movl   $0x710,(%esp)
  2e:	e8 2d 00 00 00       	call   60 <run_test>
    run_test(&test_performance_extended_priority, "performance extended priority");
  33:	b9 8e 11 00 00       	mov    $0x118e,%ecx
  38:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  3c:	c7 04 24 50 07 00 00 	movl   $0x750,(%esp)
  43:	e8 18 00 00 00       	call   60 <run_test>
    exit(0);
  48:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  4f:	e8 b4 0a 00 00       	call   b08 <exit>
  54:	66 90                	xchg   %ax,%ax
  56:	66 90                	xchg   %ax,%ax
  58:	66 90                	xchg   %ax,%ax
  5a:	66 90                	xchg   %ax,%ax
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <run_test>:
void run_test(test_runner *test, char *name) {
  60:	55                   	push   %ebp
    printf(1, "========== Test - %s: Begin ==========\n", name);
  61:	b9 e8 0f 00 00       	mov    $0xfe8,%ecx
void run_test(test_runner *test, char *name) {
  66:	89 e5                	mov    %esp,%ebp
  68:	53                   	push   %ebx
  69:	83 ec 14             	sub    $0x14,%esp
  6c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    printf(1, "========== Test - %s: Begin ==========\n", name);
  6f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  73:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  7a:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  7e:	e8 ed 0b 00 00       	call   c70 <printf>
    boolean result = (*test)();
  83:	ff 55 08             	call   *0x8(%ebp)
        printf(1, "========== Test - %s: Passed ==========\n", name);
  86:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    if (result) {
  8a:	85 c0                	test   %eax,%eax
  8c:	75 22                	jne    b0 <run_test+0x50>
        printf(1, "========== Test - %s: Failed ==========\n", name);
  8e:	b8 3c 10 00 00       	mov    $0x103c,%eax
  93:	89 44 24 04          	mov    %eax,0x4(%esp)
  97:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  9e:	e8 cd 0b 00 00       	call   c70 <printf>
}
  a3:	83 c4 14             	add    $0x14,%esp
  a6:	5b                   	pop    %ebx
  a7:	5d                   	pop    %ebp
  a8:	c3                   	ret    
  a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "========== Test - %s: Passed ==========\n", name);
  b0:	ba 10 10 00 00       	mov    $0x1010,%edx
  b5:	89 54 24 04          	mov    %edx,0x4(%esp)
  b9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c0:	e8 ab 0b 00 00       	call   c70 <printf>
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
  fb:	b8 68 10 00 00       	mov    $0x1068,%eax
 100:	89 44 24 04          	mov    %eax,0x4(%esp)
 104:	e8 67 0b 00 00       	call   c70 <printf>
 109:	31 c0                	xor    %eax,%eax
}
 10b:	c9                   	leave  
 10c:	c3                   	ret    
 10d:	8d 76 00             	lea    0x0(%esi),%esi

00000110 <print_perf>:
void print_perf(struct perf *performance) {
 110:	55                   	push   %ebp
    printf(1, "pref:\n");
 111:	b8 c8 10 00 00       	mov    $0x10c8,%eax
void print_perf(struct perf *performance) {
 116:	89 e5                	mov    %esp,%ebp
 118:	53                   	push   %ebx
 119:	83 ec 14             	sub    $0x14,%esp
 11c:	8b 5d 08             	mov    0x8(%ebp),%ebx
    printf(1, "pref:\n");
 11f:	89 44 24 04          	mov    %eax,0x4(%esp)
 123:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 12a:	e8 41 0b 00 00       	call   c70 <printf>
    printf(1, "\tctime: %d\n", performance->ctime);
 12f:	ba cf 10 00 00       	mov    $0x10cf,%edx
 134:	8b 03                	mov    (%ebx),%eax
 136:	89 54 24 04          	mov    %edx,0x4(%esp)
 13a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 141:	89 44 24 08          	mov    %eax,0x8(%esp)
 145:	e8 26 0b 00 00       	call   c70 <printf>
    printf(1, "\tttime: %d\n", performance->ttime);
 14a:	8b 43 04             	mov    0x4(%ebx),%eax
 14d:	b9 db 10 00 00       	mov    $0x10db,%ecx
 152:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 156:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 15d:	89 44 24 08          	mov    %eax,0x8(%esp)
 161:	e8 0a 0b 00 00       	call   c70 <printf>
    printf(1, "\tstime: %d\n", performance->stime);
 166:	8b 43 08             	mov    0x8(%ebx),%eax
 169:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 170:	89 44 24 08          	mov    %eax,0x8(%esp)
 174:	b8 e7 10 00 00       	mov    $0x10e7,%eax
 179:	89 44 24 04          	mov    %eax,0x4(%esp)
 17d:	e8 ee 0a 00 00       	call   c70 <printf>
    printf(1, "\tretime: %d\n", performance->retime);
 182:	8b 43 0c             	mov    0xc(%ebx),%eax
 185:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 18c:	89 44 24 08          	mov    %eax,0x8(%esp)
 190:	b8 f3 10 00 00       	mov    $0x10f3,%eax
 195:	89 44 24 04          	mov    %eax,0x4(%esp)
 199:	e8 d2 0a 00 00       	call   c70 <printf>
    printf(1, "\trutime: %d\n", performance->rutime);
 19e:	8b 43 10             	mov    0x10(%ebx),%eax
 1a1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1a8:	89 44 24 08          	mov    %eax,0x8(%esp)
 1ac:	b8 00 11 00 00       	mov    $0x1100,%eax
 1b1:	89 44 24 04          	mov    %eax,0x4(%esp)
 1b5:	e8 b6 0a 00 00       	call   c70 <printf>
    printf(1, "\n\tTurnaround time: %d\n", (performance->ttime - performance->ctime));
 1ba:	8b 43 04             	mov    0x4(%ebx),%eax
 1bd:	b9 0d 11 00 00       	mov    $0x110d,%ecx
 1c2:	8b 13                	mov    (%ebx),%edx
 1c4:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 1c8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1cf:	29 d0                	sub    %edx,%eax
 1d1:	89 44 24 08          	mov    %eax,0x8(%esp)
 1d5:	e8 96 0a 00 00       	call   c70 <printf>
}
 1da:	83 c4 14             	add    $0x14,%esp
 1dd:	5b                   	pop    %ebx
 1de:	5d                   	pop    %ebp
 1df:	c3                   	ret    

000001e0 <fact>:
int fact(int n) {
 1e0:	55                   	push   %ebp
}
 1e1:	31 c0                	xor    %eax,%eax
int fact(int n) {
 1e3:	89 e5                	mov    %esp,%ebp
}
 1e5:	5d                   	pop    %ebp
 1e6:	c3                   	ret    
 1e7:	89 f6                	mov    %esi,%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001f0 <fact2>:
unsigned long long fact2(unsigned long long n, unsigned long long k) {
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	57                   	push   %edi
 1f4:	56                   	push   %esi
 1f5:	53                   	push   %ebx
 1f6:	83 ec 0c             	sub    $0xc,%esp
 1f9:	8b 45 10             	mov    0x10(%ebp),%eax
 1fc:	8b 55 14             	mov    0x14(%ebp),%edx
 1ff:	8b 4d 08             	mov    0x8(%ebp),%ecx
 202:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 205:	89 45 e8             	mov    %eax,-0x18(%ebp)
 208:	89 55 ec             	mov    %edx,-0x14(%ebp)
 20b:	eb 25                	jmp    232 <fact2+0x42>
 20d:	8d 76 00             	lea    0x0(%esi),%esi
        k = k * n;
 210:	8b 75 ec             	mov    -0x14(%ebp),%esi
        --n;
 213:	83 c1 ff             	add    $0xffffffff,%ecx
        k = k * n;
 216:	8b 55 e8             	mov    -0x18(%ebp),%edx
        --n;
 219:	83 d3 ff             	adc    $0xffffffff,%ebx
        k = k * n;
 21c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 21f:	0f af f1             	imul   %ecx,%esi
 222:	0f af d3             	imul   %ebx,%edx
 225:	01 d6                	add    %edx,%esi
 227:	f7 e1                	mul    %ecx
 229:	89 55 ec             	mov    %edx,-0x14(%ebp)
 22c:	01 75 ec             	add    %esi,-0x14(%ebp)
 22f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (n == 1) {
 232:	89 ce                	mov    %ecx,%esi
 234:	89 df                	mov    %ebx,%edi
 236:	83 f6 01             	xor    $0x1,%esi
 239:	09 f7                	or     %esi,%edi
 23b:	75 d3                	jne    210 <fact2+0x20>
}
 23d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 240:	8b 55 ec             	mov    -0x14(%ebp),%edx
 243:	83 c4 0c             	add    $0xc,%esp
 246:	5b                   	pop    %ebx
 247:	5e                   	pop    %esi
 248:	5f                   	pop    %edi
 249:	5d                   	pop    %ebp
 24a:	c3                   	ret    
 24b:	90                   	nop
 24c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000250 <fib>:
int fib(int n) {
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	83 ec 28             	sub    $0x28,%esp
 256:	89 5d f4             	mov    %ebx,-0xc(%ebp)
 259:	8b 5d 08             	mov    0x8(%ebp),%ebx
 25c:	89 75 f8             	mov    %esi,-0x8(%ebp)
 25f:	89 7d fc             	mov    %edi,-0x4(%ebp)
    if (!n)
 262:	85 db                	test   %ebx,%ebx
 264:	74 2a                	je     290 <fib+0x40>
 266:	4b                   	dec    %ebx
 267:	bf ff ff ff ff       	mov    $0xffffffff,%edi
 26c:	31 f6                	xor    %esi,%esi
    return fib(n - 1) + fib(n - 2);
 26e:	89 1c 24             	mov    %ebx,(%esp)
 271:	83 eb 02             	sub    $0x2,%ebx
 274:	e8 d7 ff ff ff       	call   250 <fib>
 279:	01 c6                	add    %eax,%esi
    if (!n)
 27b:	39 fb                	cmp    %edi,%ebx
 27d:	75 ef                	jne    26e <fib+0x1e>
 27f:	8d 46 01             	lea    0x1(%esi),%eax
}
 282:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 285:	8b 75 f8             	mov    -0x8(%ebp),%esi
 288:	8b 7d fc             	mov    -0x4(%ebp),%edi
 28b:	89 ec                	mov    %ebp,%esp
 28d:	5d                   	pop    %ebp
 28e:	c3                   	ret    
 28f:	90                   	nop
 290:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    if (!n)
 293:	b8 01 00 00 00       	mov    $0x1,%eax
}
 298:	8b 75 f8             	mov    -0x8(%ebp),%esi
 29b:	8b 7d fc             	mov    -0x4(%ebp),%edi
 29e:	89 ec                	mov    %ebp,%esp
 2a0:	5d                   	pop    %ebp
 2a1:	c3                   	ret    
 2a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002b0 <test_exit_wait>:
boolean test_exit_wait() {
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	57                   	push   %edi
 2b4:	56                   	push   %esi
    boolean result = true;
 2b5:	be 01 00 00 00       	mov    $0x1,%esi
boolean test_exit_wait() {
 2ba:	53                   	push   %ebx
    for (int i = 0; i < 20; ++i) {
 2bb:	31 db                	xor    %ebx,%ebx
boolean test_exit_wait() {
 2bd:	83 ec 3c             	sub    $0x3c,%esp
            wait(&status);
 2c0:	8d 7d e4             	lea    -0x1c(%ebp),%edi
 2c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        pid = fork();
 2d0:	e8 2b 08 00 00       	call   b00 <fork>
        if (pid > 0) {
 2d5:	85 c0                	test   %eax,%eax
 2d7:	7e 57                	jle    330 <test_exit_wait+0x80>
            wait(&status);
 2d9:	89 3c 24             	mov    %edi,(%esp)
 2dc:	e8 2f 08 00 00       	call   b10 <wait>
            result = result && assert_equals(i, status, "exit&wait");
 2e1:	85 f6                	test   %esi,%esi
 2e3:	74 34                	je     319 <test_exit_wait+0x69>
 2e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 2e8:	be 01 00 00 00       	mov    $0x1,%esi
    if (expected != actual) {
 2ed:	39 d8                	cmp    %ebx,%eax
 2ef:	74 28                	je     319 <test_exit_wait+0x69>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
 2f1:	89 44 24 10          	mov    %eax,0x10(%esp)
 2f5:	ba 68 10 00 00       	mov    $0x1068,%edx
 2fa:	b8 24 11 00 00       	mov    $0x1124,%eax
 2ff:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
            result = result && assert_equals(i, status, "exit&wait");
 303:	31 f6                	xor    %esi,%esi
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
 305:	89 44 24 08          	mov    %eax,0x8(%esp)
 309:	89 54 24 04          	mov    %edx,0x4(%esp)
 30d:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 314:	e8 57 09 00 00       	call   c70 <printf>
    for (int i = 0; i < 20; ++i) {
 319:	43                   	inc    %ebx
 31a:	83 fb 14             	cmp    $0x14,%ebx
            status = -1;
 31d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
    for (int i = 0; i < 20; ++i) {
 324:	75 aa                	jne    2d0 <test_exit_wait+0x20>
}
 326:	83 c4 3c             	add    $0x3c,%esp
 329:	89 f0                	mov    %esi,%eax
 32b:	5b                   	pop    %ebx
 32c:	5e                   	pop    %esi
 32d:	5f                   	pop    %edi
 32e:	5d                   	pop    %ebp
 32f:	c3                   	ret    
            sleep(3);
 330:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
 337:	e8 5c 08 00 00       	call   b98 <sleep>
            exit(i);
 33c:	89 1c 24             	mov    %ebx,(%esp)
 33f:	e8 c4 07 00 00       	call   b08 <exit>
 344:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 34a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000350 <test_detach>:
boolean test_detach() {
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	56                   	push   %esi
 354:	53                   	push   %ebx
 355:	83 ec 20             	sub    $0x20,%esp
    pid = fork();
 358:	e8 a3 07 00 00       	call   b00 <fork>
    if (pid > 0) {
 35d:	85 c0                	test   %eax,%eax
 35f:	0f 8e ea 00 00 00    	jle    44f <test_detach+0xff>
        status1 = detach(pid);
 365:	89 04 24             	mov    %eax,(%esp)
 368:	89 c3                	mov    %eax,%ebx
    } else return true;
 36a:	be 01 00 00 00       	mov    $0x1,%esi
        status1 = detach(pid);
 36f:	e8 3c 08 00 00       	call   bb0 <detach>
    if (expected != actual) {
 374:	85 c0                	test   %eax,%eax
 376:	0f 85 a4 00 00 00    	jne    420 <test_detach+0xd0>
        status2 = detach(pid);
 37c:	89 1c 24             	mov    %ebx,(%esp)
 37f:	e8 2c 08 00 00       	call   bb0 <detach>
    if (expected != actual) {
 384:	83 f8 ff             	cmp    $0xffffffff,%eax
 387:	75 1f                	jne    3a8 <test_detach+0x58>
        status3 = detach(-10);
 389:	c7 04 24 f6 ff ff ff 	movl   $0xfffffff6,(%esp)
 390:	e8 1b 08 00 00       	call   bb0 <detach>
    if (expected != actual) {
 395:	83 f8 ff             	cmp    $0xffffffff,%eax
 398:	75 4a                	jne    3e4 <test_detach+0x94>
}
 39a:	83 c4 20             	add    $0x20,%esp
 39d:	89 f0                	mov    %esi,%eax
 39f:	5b                   	pop    %ebx
 3a0:	5e                   	pop    %esi
 3a1:	5d                   	pop    %ebp
 3a2:	c3                   	ret    
 3a3:	90                   	nop
 3a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
 3a8:	89 44 24 10          	mov    %eax,0x10(%esp)
 3ac:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
 3b1:	b8 68 10 00 00       	mov    $0x1068,%eax
 3b6:	be 3f 11 00 00       	mov    $0x113f,%esi
 3bb:	89 44 24 04          	mov    %eax,0x4(%esp)
 3bf:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
 3c3:	89 74 24 08          	mov    %esi,0x8(%esp)
 3c7:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 3ce:	e8 9d 08 00 00       	call   c70 <printf>
        status3 = detach(-10);
 3d3:	c7 04 24 f6 ff ff ff 	movl   $0xfffffff6,(%esp)
 3da:	e8 d1 07 00 00       	call   bb0 <detach>
    if (expected != actual) {
 3df:	83 f8 ff             	cmp    $0xffffffff,%eax
 3e2:	74 2b                	je     40f <test_detach+0xbf>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
 3e4:	89 44 24 10          	mov    %eax,0x10(%esp)
 3e8:	ba 50 11 00 00       	mov    $0x1150,%edx
 3ed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 3f2:	b9 68 10 00 00       	mov    $0x1068,%ecx
 3f7:	89 44 24 0c          	mov    %eax,0xc(%esp)
 3fb:	89 54 24 08          	mov    %edx,0x8(%esp)
 3ff:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 403:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 40a:	e8 61 08 00 00       	call   c70 <printf>
}
 40f:	83 c4 20             	add    $0x20,%esp
        return result1 && result2 && result3;
 412:	31 f6                	xor    %esi,%esi
}
 414:	5b                   	pop    %ebx
 415:	89 f0                	mov    %esi,%eax
 417:	5e                   	pop    %esi
 418:	5d                   	pop    %ebp
 419:	c3                   	ret    
 41a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
 420:	89 44 24 10          	mov    %eax,0x10(%esp)
 424:	31 c0                	xor    %eax,%eax
 426:	31 f6                	xor    %esi,%esi
 428:	89 44 24 0c          	mov    %eax,0xc(%esp)
 42c:	b8 2e 11 00 00       	mov    $0x112e,%eax
 431:	89 44 24 08          	mov    %eax,0x8(%esp)
 435:	b8 68 10 00 00       	mov    $0x1068,%eax
 43a:	89 44 24 04          	mov    %eax,0x4(%esp)
 43e:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 445:	e8 26 08 00 00       	call   c70 <printf>
 44a:	e9 2d ff ff ff       	jmp    37c <test_detach+0x2c>
        sleep(100);
 44f:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 456:	e8 3d 07 00 00       	call   b98 <sleep>
        exit(0);
 45b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 462:	e8 a1 06 00 00       	call   b08 <exit>
 467:	89 f6                	mov    %esi,%esi
 469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000470 <test_policy_helper>:
boolean test_policy_helper(int *priority_mod, int policy) {
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	57                   	push   %edi
 474:	56                   	push   %esi
 475:	53                   	push   %ebx
    for (int i = 0; i < nProcs; ++i) {
 476:	31 db                	xor    %ebx,%ebx
boolean test_policy_helper(int *priority_mod, int policy) {
 478:	83 ec 4c             	sub    $0x4c,%esp
 47b:	90                   	nop
 47c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        pid = fork();
 480:	e8 7b 06 00 00       	call   b00 <fork>
        if (pid < 0) {
 485:	85 c0                	test   %eax,%eax
 487:	78 0c                	js     495 <test_policy_helper+0x25>
        } else if (pid == 0) {
 489:	0f 84 a5 00 00 00    	je     534 <test_policy_helper+0xc4>
    for (int i = 0; i < nProcs; ++i) {
 48f:	43                   	inc    %ebx
 490:	83 fb 0a             	cmp    $0xa,%ebx
 493:	75 eb                	jne    480 <test_policy_helper+0x10>
 495:	31 f6                	xor    %esi,%esi
 497:	ba 01 00 00 00       	mov    $0x1,%edx
 49c:	8d 7d e4             	lea    -0x1c(%ebp),%edi
        wait(&status);
 49f:	89 3c 24             	mov    %edi,(%esp)
 4a2:	8d 5e 01             	lea    0x1(%esi),%ebx
 4a5:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 4a8:	e8 63 06 00 00       	call   b10 <wait>
        result = result && assert_equals(0, status, "round robin");
 4ad:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 4b0:	85 d2                	test   %edx,%edx
 4b2:	74 5c                	je     510 <test_policy_helper+0xa0>
 4b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4b7:	ba 01 00 00 00       	mov    $0x1,%edx
    if (expected != actual) {
 4bc:	85 c0                	test   %eax,%eax
 4be:	75 18                	jne    4d8 <test_policy_helper+0x68>
    for (int j = 0; j < nProcs; ++j) {
 4c0:	83 fb 0a             	cmp    $0xa,%ebx
 4c3:	89 de                	mov    %ebx,%esi
 4c5:	75 d8                	jne    49f <test_policy_helper+0x2f>
}
 4c7:	83 c4 4c             	add    $0x4c,%esp
 4ca:	89 d0                	mov    %edx,%eax
 4cc:	5b                   	pop    %ebx
 4cd:	5e                   	pop    %esi
 4ce:	5f                   	pop    %edi
 4cf:	5d                   	pop    %ebp
 4d0:	c3                   	ret    
 4d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
 4d8:	89 44 24 10          	mov    %eax,0x10(%esp)
 4dc:	ba 6d 11 00 00       	mov    $0x116d,%edx
 4e1:	31 c0                	xor    %eax,%eax
 4e3:	b9 68 10 00 00       	mov    $0x1068,%ecx
 4e8:	89 44 24 0c          	mov    %eax,0xc(%esp)
 4ec:	89 54 24 08          	mov    %edx,0x8(%esp)
 4f0:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 4f4:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 4fb:	e8 70 07 00 00       	call   c70 <printf>
    for (int j = 0; j < nProcs; ++j) {
 500:	83 fb 0a             	cmp    $0xa,%ebx
 503:	74 23                	je     528 <test_policy_helper+0xb8>
        wait(&status);
 505:	89 3c 24             	mov    %edi,(%esp)
 508:	8d 5e 02             	lea    0x2(%esi),%ebx
 50b:	e8 00 06 00 00       	call   b10 <wait>
    for (int j = 0; j < nProcs; ++j) {
 510:	83 fb 0a             	cmp    $0xa,%ebx
 513:	74 13                	je     528 <test_policy_helper+0xb8>
        wait(&status);
 515:	89 3c 24             	mov    %edi,(%esp)
 518:	43                   	inc    %ebx
 519:	e8 f2 05 00 00       	call   b10 <wait>
        result = result && assert_equals(0, status, "round robin");
 51e:	31 d2                	xor    %edx,%edx
 520:	eb 9e                	jmp    4c0 <test_policy_helper+0x50>
 522:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
 528:	83 c4 4c             	add    $0x4c,%esp
        result = result && assert_equals(0, status, "round robin");
 52b:	31 d2                	xor    %edx,%edx
}
 52d:	5b                   	pop    %ebx
 52e:	89 d0                	mov    %edx,%eax
 530:	5e                   	pop    %esi
 531:	5f                   	pop    %edi
 532:	5d                   	pop    %ebp
 533:	c3                   	ret    
            if (priority_mod) {
 534:	8b 75 08             	mov    0x8(%ebp),%esi
 537:	85 f6                	test   %esi,%esi
 539:	74 1a                	je     555 <test_policy_helper+0xe5>
                if ((i % *(priority_mod)) == 0 && policy == PRIORITY) {
 53b:	8b 4d 08             	mov    0x8(%ebp),%ecx
 53e:	89 d8                	mov    %ebx,%eax
 540:	99                   	cltd   
 541:	f7 39                	idivl  (%ecx)
 543:	85 d2                	test   %edx,%edx
 545:	75 06                	jne    54d <test_policy_helper+0xdd>
 547:	83 7d 0c 02          	cmpl   $0x2,0xc(%ebp)
 54b:	74 20                	je     56d <test_policy_helper+0xfd>
                    priority(i % (*priority_mod));
 54d:	89 14 24             	mov    %edx,(%esp)
 550:	e8 63 06 00 00       	call   bb8 <priority>
            sleep(10);
 555:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
 55c:	e8 37 06 00 00       	call   b98 <sleep>
            exit(0);
 561:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 568:	e8 9b 05 00 00       	call   b08 <exit>
                    priority(1);
 56d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 574:	e8 3f 06 00 00       	call   bb8 <priority>
 579:	eb da                	jmp    555 <test_policy_helper+0xe5>
 57b:	90                   	nop
 57c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000580 <test_round_robin_policy>:
boolean test_round_robin_policy() {
 580:	55                   	push   %ebp
    return test_policy_helper(null, null);
 581:	31 c0                	xor    %eax,%eax
boolean test_round_robin_policy() {
 583:	89 e5                	mov    %esp,%ebp
 585:	83 ec 18             	sub    $0x18,%esp
    return test_policy_helper(null, null);
 588:	89 44 24 04          	mov    %eax,0x4(%esp)
 58c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 593:	e8 d8 fe ff ff       	call   470 <test_policy_helper>
}
 598:	c9                   	leave  
 599:	c3                   	ret    
 59a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000005a0 <test_priority_policy>:
boolean test_priority_policy() {
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	53                   	push   %ebx
 5a4:	83 ec 24             	sub    $0x24,%esp
    policy(PRIORITY);
 5a7:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    int priority_mod = 10;
 5ae:	c7 45 f4 0a 00 00 00 	movl   $0xa,-0xc(%ebp)
    policy(PRIORITY);
 5b5:	e8 ee 05 00 00       	call   ba8 <policy>
    boolean result = test_policy_helper(&priority_mod, PRIORITY);
 5ba:	b8 02 00 00 00       	mov    $0x2,%eax
 5bf:	89 44 24 04          	mov    %eax,0x4(%esp)
 5c3:	8d 45 f4             	lea    -0xc(%ebp),%eax
 5c6:	89 04 24             	mov    %eax,(%esp)
 5c9:	e8 a2 fe ff ff       	call   470 <test_policy_helper>
    policy(ROUND_ROBIN);
 5ce:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    boolean result = test_policy_helper(&priority_mod, PRIORITY);
 5d5:	89 c3                	mov    %eax,%ebx
    policy(ROUND_ROBIN);
 5d7:	e8 cc 05 00 00       	call   ba8 <policy>
}
 5dc:	83 c4 24             	add    $0x24,%esp
 5df:	89 d8                	mov    %ebx,%eax
 5e1:	5b                   	pop    %ebx
 5e2:	5d                   	pop    %ebp
 5e3:	c3                   	ret    
 5e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000005f0 <test_extended_priority_policy>:
boolean test_extended_priority_policy() {
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	53                   	push   %ebx
 5f4:	83 ec 24             	sub    $0x24,%esp
    policy(EXTENED_PRIORITY);
 5f7:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
    int priority_mod = 10;
 5fe:	c7 45 f4 0a 00 00 00 	movl   $0xa,-0xc(%ebp)
    policy(EXTENED_PRIORITY);
 605:	e8 9e 05 00 00       	call   ba8 <policy>
    boolean result = test_policy_helper(&priority_mod, EXTENED_PRIORITY);
 60a:	b8 03 00 00 00       	mov    $0x3,%eax
 60f:	89 44 24 04          	mov    %eax,0x4(%esp)
 613:	8d 45 f4             	lea    -0xc(%ebp),%eax
 616:	89 04 24             	mov    %eax,(%esp)
 619:	e8 52 fe ff ff       	call   470 <test_policy_helper>
    policy(ROUND_ROBIN);
 61e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    boolean result = test_policy_helper(&priority_mod, EXTENED_PRIORITY);
 625:	89 c3                	mov    %eax,%ebx
    policy(ROUND_ROBIN);
 627:	e8 7c 05 00 00       	call   ba8 <policy>
}
 62c:	83 c4 24             	add    $0x24,%esp
 62f:	89 d8                	mov    %ebx,%eax
 631:	5b                   	pop    %ebx
 632:	5d                   	pop    %ebp
 633:	c3                   	ret    
 634:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 63a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000640 <test_performance_helper>:
boolean test_performance_helper(int *npriority) {
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	57                   	push   %edi
 644:	56                   	push   %esi
 645:	53                   	push   %ebx
 646:	83 ec 3c             	sub    $0x3c,%esp
    pid1 = fork();
 649:	e8 b2 04 00 00       	call   b00 <fork>
    if (pid1 > 0) {
 64e:	85 c0                	test   %eax,%eax
 650:	7f 3e                	jg     690 <test_performance_helper+0x50>
 652:	bb 0a 00 00 00       	mov    $0xa,%ebx
                wait_stat(&status, &perf1);
 657:	8d 7d d4             	lea    -0x2c(%ebp),%edi
 65a:	8d 75 d0             	lea    -0x30(%ebp),%esi
 65d:	8d 76 00             	lea    0x0(%esi),%esi
            pid = fork();
 660:	e8 9b 04 00 00       	call   b00 <fork>
            if (pid > 0) {
 665:	85 c0                	test   %eax,%eax
 667:	7e 4e                	jle    6b7 <test_performance_helper+0x77>
                sleep(5);
 669:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 670:	e8 23 05 00 00       	call   b98 <sleep>
                wait_stat(&status, &perf1);
 675:	89 7c 24 04          	mov    %edi,0x4(%esp)
 679:	89 34 24             	mov    %esi,(%esp)
 67c:	e8 3f 05 00 00       	call   bc0 <wait_stat>
        for (int a = 0; a < 10; ++a) {
 681:	4b                   	dec    %ebx
 682:	75 dc                	jne    660 <test_performance_helper+0x20>
        exit(0);
 684:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 68b:	e8 78 04 00 00       	call   b08 <exit>
        wait_stat(&status1, &perf2);
 690:	8d 5d d4             	lea    -0x2c(%ebp),%ebx
 693:	8d 45 d0             	lea    -0x30(%ebp),%eax
 696:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 69a:	89 04 24             	mov    %eax,(%esp)
 69d:	e8 1e 05 00 00       	call   bc0 <wait_stat>
        print_perf(&perf2);
 6a2:	89 1c 24             	mov    %ebx,(%esp)
 6a5:	e8 66 fa ff ff       	call   110 <print_perf>
}
 6aa:	83 c4 3c             	add    $0x3c,%esp
 6ad:	b8 01 00 00 00       	mov    $0x1,%eax
 6b2:	5b                   	pop    %ebx
 6b3:	5e                   	pop    %esi
 6b4:	5f                   	pop    %edi
 6b5:	5d                   	pop    %ebp
 6b6:	c3                   	ret    
                if (npriority)
 6b7:	8b 45 08             	mov    0x8(%ebp),%eax
 6ba:	85 c0                	test   %eax,%eax
 6bc:	74 0d                	je     6cb <test_performance_helper+0x8b>
                    priority(*npriority);
 6be:	8b 45 08             	mov    0x8(%ebp),%eax
 6c1:	8b 00                	mov    (%eax),%eax
 6c3:	89 04 24             	mov    %eax,(%esp)
 6c6:	e8 ed 04 00 00       	call   bb8 <priority>
                sleep(5);
 6cb:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 6d2:	e8 c1 04 00 00       	call   b98 <sleep>
                exit(0);
 6d7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 6de:	e8 25 04 00 00       	call   b08 <exit>
 6e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006f0 <test_performance_round_robin>:
boolean test_performance_round_robin() {
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	83 ec 18             	sub    $0x18,%esp
    return test_performance_helper(null);
 6f6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 6fd:	e8 3e ff ff ff       	call   640 <test_performance_helper>
}
 702:	c9                   	leave  
 703:	c3                   	ret    
 704:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 70a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000710 <test_performance_priority>:
boolean test_performance_priority() {
 710:	55                   	push   %ebp
 711:	89 e5                	mov    %esp,%ebp
 713:	53                   	push   %ebx
 714:	83 ec 24             	sub    $0x24,%esp
    policy(PRIORITY);
 717:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 71e:	e8 85 04 00 00       	call   ba8 <policy>
    boolean result = test_performance_helper(&npriority);
 723:	8d 45 f4             	lea    -0xc(%ebp),%eax
 726:	89 04 24             	mov    %eax,(%esp)
    int npriority = 2;
 729:	c7 45 f4 02 00 00 00 	movl   $0x2,-0xc(%ebp)
    boolean result = test_performance_helper(&npriority);
 730:	e8 0b ff ff ff       	call   640 <test_performance_helper>
    policy(ROUND_ROBIN);
 735:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    boolean result = test_performance_helper(&npriority);
 73c:	89 c3                	mov    %eax,%ebx
    policy(ROUND_ROBIN);
 73e:	e8 65 04 00 00       	call   ba8 <policy>
}
 743:	83 c4 24             	add    $0x24,%esp
 746:	89 d8                	mov    %ebx,%eax
 748:	5b                   	pop    %ebx
 749:	5d                   	pop    %ebp
 74a:	c3                   	ret    
 74b:	90                   	nop
 74c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000750 <test_performance_extended_priority>:
boolean test_performance_extended_priority() {
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	53                   	push   %ebx
 754:	83 ec 24             	sub    $0x24,%esp
    policy(EXTENED_PRIORITY);
 757:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
 75e:	e8 45 04 00 00       	call   ba8 <policy>
    boolean result = test_performance_helper(&npriority);
 763:	8d 45 f4             	lea    -0xc(%ebp),%eax
 766:	89 04 24             	mov    %eax,(%esp)
    int npriority = 0;
 769:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    boolean result = test_performance_helper(&npriority);
 770:	e8 cb fe ff ff       	call   640 <test_performance_helper>
    policy(ROUND_ROBIN);
 775:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    boolean result = test_performance_helper(&npriority);
 77c:	89 c3                	mov    %eax,%ebx
    policy(ROUND_ROBIN);
 77e:	e8 25 04 00 00       	call   ba8 <policy>
}
 783:	83 c4 24             	add    $0x24,%esp
 786:	89 d8                	mov    %ebx,%eax
 788:	5b                   	pop    %ebx
 789:	5d                   	pop    %ebp
 78a:	c3                   	ret    
 78b:	90                   	nop
 78c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000790 <test_starvation_helper>:
boolean test_starvation_helper(int npolicy, int npriority) {
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	57                   	push   %edi
 794:	56                   	push   %esi
    memset(&pid_arr, 0, nProcs * sizeof(int));
 795:	31 f6                	xor    %esi,%esi
boolean test_starvation_helper(int npolicy, int npriority) {
 797:	53                   	push   %ebx
    memset(&pid_arr, 0, nProcs * sizeof(int));
 798:	bb 28 00 00 00       	mov    $0x28,%ebx
boolean test_starvation_helper(int npolicy, int npriority) {
 79d:	83 ec 5c             	sub    $0x5c,%esp
    policy(npolicy);
 7a0:	8b 45 08             	mov    0x8(%ebp),%eax
 7a3:	89 04 24             	mov    %eax,(%esp)
 7a6:	e8 fd 03 00 00       	call   ba8 <policy>
    memset(&pid_arr, 0, nProcs * sizeof(int));
 7ab:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 7af:	8d 5d c0             	lea    -0x40(%ebp),%ebx
 7b2:	89 74 24 04          	mov    %esi,0x4(%esp)
 7b6:	89 df                	mov    %ebx,%edi
 7b8:	89 1c 24             	mov    %ebx,(%esp)
 7bb:	8d 75 e8             	lea    -0x18(%ebp),%esi
 7be:	e8 ad 01 00 00       	call   970 <memset>
 7c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 7c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        pid = fork();
 7d0:	e8 2b 03 00 00       	call   b00 <fork>
        if (pid < 0) {
 7d5:	85 c0                	test   %eax,%eax
 7d7:	78 0f                	js     7e8 <test_starvation_helper+0x58>
        } else if (pid == 0) {
 7d9:	0f 84 a1 00 00 00    	je     880 <test_starvation_helper+0xf0>
            pid_arr[i] = pid;
 7df:	89 07                	mov    %eax,(%edi)
 7e1:	83 c7 04             	add    $0x4,%edi
    for (int i = 0; i < nProcs; ++i) {
 7e4:	39 f7                	cmp    %esi,%edi
 7e6:	75 e8                	jne    7d0 <test_starvation_helper+0x40>
    sleep(100);
 7e8:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
    boolean result = true;
 7ef:	bf 01 00 00 00       	mov    $0x1,%edi
    sleep(100);
 7f4:	e8 9f 03 00 00       	call   b98 <sleep>
 7f9:	eb 18                	jmp    813 <test_starvation_helper+0x83>
 7fb:	90                   	nop
 7fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            wait(null);
 800:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 807:	e8 04 03 00 00       	call   b10 <wait>
 80c:	83 c3 04             	add    $0x4,%ebx
    for (int j = 0; j < nProcs; ++j) {
 80f:	39 de                	cmp    %ebx,%esi
 811:	74 4d                	je     860 <test_starvation_helper+0xd0>
        if (pid_arr[j] != 0) {
 813:	8b 03                	mov    (%ebx),%eax
 815:	85 c0                	test   %eax,%eax
 817:	74 f3                	je     80c <test_starvation_helper+0x7c>
            result = result && assert_equals(0, kill(pid_arr[j]), "failed to kill child (yes it does sound horrible)");
 819:	85 ff                	test   %edi,%edi
 81b:	74 e3                	je     800 <test_starvation_helper+0x70>
 81d:	89 04 24             	mov    %eax,(%esp)
 820:	bf 01 00 00 00       	mov    $0x1,%edi
 825:	e8 0e 03 00 00       	call   b38 <kill>
    if (expected != actual) {
 82a:	85 c0                	test   %eax,%eax
 82c:	74 d2                	je     800 <test_starvation_helper+0x70>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
 82e:	89 44 24 10          	mov    %eax,0x10(%esp)
 832:	ba 94 10 00 00       	mov    $0x1094,%edx
 837:	31 c0                	xor    %eax,%eax
 839:	b9 68 10 00 00       	mov    $0x1068,%ecx
            result = result && assert_equals(0, kill(pid_arr[j]), "failed to kill child (yes it does sound horrible)");
 83e:	31 ff                	xor    %edi,%edi
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
 840:	89 44 24 0c          	mov    %eax,0xc(%esp)
 844:	89 54 24 08          	mov    %edx,0x8(%esp)
 848:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 84c:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 853:	e8 18 04 00 00       	call   c70 <printf>
 858:	eb a6                	jmp    800 <test_starvation_helper+0x70>
 85a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    policy(ROUND_ROBIN);
 860:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 867:	e8 3c 03 00 00       	call   ba8 <policy>
}
 86c:	83 c4 5c             	add    $0x5c,%esp
 86f:	89 f8                	mov    %edi,%eax
 871:	5b                   	pop    %ebx
 872:	5e                   	pop    %esi
 873:	5f                   	pop    %edi
 874:	5d                   	pop    %ebp
 875:	c3                   	ret    
 876:	8d 76 00             	lea    0x0(%esi),%esi
 879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            sleep(5);
 880:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 887:	e8 0c 03 00 00       	call   b98 <sleep>
            priority(npriority);
 88c:	8b 45 0c             	mov    0xc(%ebp),%eax
 88f:	89 04 24             	mov    %eax,(%esp)
 892:	e8 21 03 00 00       	call   bb8 <priority>
 897:	eb fe                	jmp    897 <test_starvation_helper+0x107>
 899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008a0 <test_accumulator>:
boolean test_accumulator() {
 8a0:	55                   	push   %ebp
    return test_starvation_helper(PRIORITY, 2);
 8a1:	b8 02 00 00 00       	mov    $0x2,%eax
boolean test_accumulator() {
 8a6:	89 e5                	mov    %esp,%ebp
 8a8:	83 ec 18             	sub    $0x18,%esp
    return test_starvation_helper(PRIORITY, 2);
 8ab:	89 44 24 04          	mov    %eax,0x4(%esp)
 8af:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 8b6:	e8 d5 fe ff ff       	call   790 <test_starvation_helper>
}
 8bb:	c9                   	leave  
 8bc:	c3                   	ret    
 8bd:	8d 76 00             	lea    0x0(%esi),%esi

000008c0 <test_starvation>:
boolean test_starvation() {
 8c0:	55                   	push   %ebp
    return test_starvation_helper(EXTENED_PRIORITY, 0);
 8c1:	31 c0                	xor    %eax,%eax
boolean test_starvation() {
 8c3:	89 e5                	mov    %esp,%ebp
 8c5:	83 ec 18             	sub    $0x18,%esp
    return test_starvation_helper(EXTENED_PRIORITY, 0);
 8c8:	89 44 24 04          	mov    %eax,0x4(%esp)
 8cc:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
 8d3:	e8 b8 fe ff ff       	call   790 <test_starvation_helper>
}
 8d8:	c9                   	leave  
 8d9:	c3                   	ret    
 8da:	66 90                	xchg   %ax,%ax
 8dc:	66 90                	xchg   %ax,%ax
 8de:	66 90                	xchg   %ax,%ax

000008e0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 8e0:	55                   	push   %ebp
 8e1:	89 e5                	mov    %esp,%ebp
 8e3:	8b 45 08             	mov    0x8(%ebp),%eax
 8e6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 8e9:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 8ea:	89 c2                	mov    %eax,%edx
 8ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 8f0:	41                   	inc    %ecx
 8f1:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 8f5:	42                   	inc    %edx
 8f6:	84 db                	test   %bl,%bl
 8f8:	88 5a ff             	mov    %bl,-0x1(%edx)
 8fb:	75 f3                	jne    8f0 <strcpy+0x10>
    ;
  return os;
}
 8fd:	5b                   	pop    %ebx
 8fe:	5d                   	pop    %ebp
 8ff:	c3                   	ret    

00000900 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 900:	55                   	push   %ebp
 901:	89 e5                	mov    %esp,%ebp
 903:	8b 4d 08             	mov    0x8(%ebp),%ecx
 906:	53                   	push   %ebx
 907:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 90a:	0f b6 01             	movzbl (%ecx),%eax
 90d:	0f b6 13             	movzbl (%ebx),%edx
 910:	84 c0                	test   %al,%al
 912:	75 18                	jne    92c <strcmp+0x2c>
 914:	eb 22                	jmp    938 <strcmp+0x38>
 916:	8d 76 00             	lea    0x0(%esi),%esi
 919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 920:	41                   	inc    %ecx
  while(*p && *p == *q)
 921:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 924:	43                   	inc    %ebx
 925:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
 928:	84 c0                	test   %al,%al
 92a:	74 0c                	je     938 <strcmp+0x38>
 92c:	38 d0                	cmp    %dl,%al
 92e:	74 f0                	je     920 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
 930:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 931:	29 d0                	sub    %edx,%eax
}
 933:	5d                   	pop    %ebp
 934:	c3                   	ret    
 935:	8d 76 00             	lea    0x0(%esi),%esi
 938:	5b                   	pop    %ebx
 939:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 93b:	29 d0                	sub    %edx,%eax
}
 93d:	5d                   	pop    %ebp
 93e:	c3                   	ret    
 93f:	90                   	nop

00000940 <strlen>:

uint
strlen(const char *s)
{
 940:	55                   	push   %ebp
 941:	89 e5                	mov    %esp,%ebp
 943:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 946:	80 39 00             	cmpb   $0x0,(%ecx)
 949:	74 15                	je     960 <strlen+0x20>
 94b:	31 d2                	xor    %edx,%edx
 94d:	8d 76 00             	lea    0x0(%esi),%esi
 950:	42                   	inc    %edx
 951:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 955:	89 d0                	mov    %edx,%eax
 957:	75 f7                	jne    950 <strlen+0x10>
    ;
  return n;
}
 959:	5d                   	pop    %ebp
 95a:	c3                   	ret    
 95b:	90                   	nop
 95c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
 960:	31 c0                	xor    %eax,%eax
}
 962:	5d                   	pop    %ebp
 963:	c3                   	ret    
 964:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 96a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000970 <memset>:

void*
memset(void *dst, int c, uint n)
{
 970:	55                   	push   %ebp
 971:	89 e5                	mov    %esp,%ebp
 973:	8b 55 08             	mov    0x8(%ebp),%edx
 976:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 977:	8b 4d 10             	mov    0x10(%ebp),%ecx
 97a:	8b 45 0c             	mov    0xc(%ebp),%eax
 97d:	89 d7                	mov    %edx,%edi
 97f:	fc                   	cld    
 980:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 982:	5f                   	pop    %edi
 983:	89 d0                	mov    %edx,%eax
 985:	5d                   	pop    %ebp
 986:	c3                   	ret    
 987:	89 f6                	mov    %esi,%esi
 989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000990 <strchr>:

char*
strchr(const char *s, char c)
{
 990:	55                   	push   %ebp
 991:	89 e5                	mov    %esp,%ebp
 993:	8b 45 08             	mov    0x8(%ebp),%eax
 996:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 99a:	0f b6 10             	movzbl (%eax),%edx
 99d:	84 d2                	test   %dl,%dl
 99f:	74 1b                	je     9bc <strchr+0x2c>
    if(*s == c)
 9a1:	38 d1                	cmp    %dl,%cl
 9a3:	75 0f                	jne    9b4 <strchr+0x24>
 9a5:	eb 17                	jmp    9be <strchr+0x2e>
 9a7:	89 f6                	mov    %esi,%esi
 9a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 9b0:	38 ca                	cmp    %cl,%dl
 9b2:	74 0a                	je     9be <strchr+0x2e>
  for(; *s; s++)
 9b4:	40                   	inc    %eax
 9b5:	0f b6 10             	movzbl (%eax),%edx
 9b8:	84 d2                	test   %dl,%dl
 9ba:	75 f4                	jne    9b0 <strchr+0x20>
      return (char*)s;
  return 0;
 9bc:	31 c0                	xor    %eax,%eax
}
 9be:	5d                   	pop    %ebp
 9bf:	c3                   	ret    

000009c0 <gets>:

char*
gets(char *buf, int max)
{
 9c0:	55                   	push   %ebp
 9c1:	89 e5                	mov    %esp,%ebp
 9c3:	57                   	push   %edi
 9c4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 9c5:	31 f6                	xor    %esi,%esi
{
 9c7:	53                   	push   %ebx
 9c8:	83 ec 3c             	sub    $0x3c,%esp
 9cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
 9ce:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 9d1:	eb 32                	jmp    a05 <gets+0x45>
 9d3:	90                   	nop
 9d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 9d8:	ba 01 00 00 00       	mov    $0x1,%edx
 9dd:	89 54 24 08          	mov    %edx,0x8(%esp)
 9e1:	89 7c 24 04          	mov    %edi,0x4(%esp)
 9e5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 9ec:	e8 2f 01 00 00       	call   b20 <read>
    if(cc < 1)
 9f1:	85 c0                	test   %eax,%eax
 9f3:	7e 19                	jle    a0e <gets+0x4e>
      break;
    buf[i++] = c;
 9f5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 9f9:	43                   	inc    %ebx
 9fa:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
 9fd:	3c 0a                	cmp    $0xa,%al
 9ff:	74 1f                	je     a20 <gets+0x60>
 a01:	3c 0d                	cmp    $0xd,%al
 a03:	74 1b                	je     a20 <gets+0x60>
  for(i=0; i+1 < max; ){
 a05:	46                   	inc    %esi
 a06:	3b 75 0c             	cmp    0xc(%ebp),%esi
 a09:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 a0c:	7c ca                	jl     9d8 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 a0e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 a11:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 a14:	8b 45 08             	mov    0x8(%ebp),%eax
 a17:	83 c4 3c             	add    $0x3c,%esp
 a1a:	5b                   	pop    %ebx
 a1b:	5e                   	pop    %esi
 a1c:	5f                   	pop    %edi
 a1d:	5d                   	pop    %ebp
 a1e:	c3                   	ret    
 a1f:	90                   	nop
 a20:	8b 45 08             	mov    0x8(%ebp),%eax
 a23:	01 c6                	add    %eax,%esi
 a25:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 a28:	eb e4                	jmp    a0e <gets+0x4e>
 a2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000a30 <stat>:

int
stat(const char *n, struct stat *st)
{
 a30:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 a31:	31 c0                	xor    %eax,%eax
{
 a33:	89 e5                	mov    %esp,%ebp
 a35:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 a38:	89 44 24 04          	mov    %eax,0x4(%esp)
 a3c:	8b 45 08             	mov    0x8(%ebp),%eax
{
 a3f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 a42:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 a45:	89 04 24             	mov    %eax,(%esp)
 a48:	e8 fb 00 00 00       	call   b48 <open>
  if(fd < 0)
 a4d:	85 c0                	test   %eax,%eax
 a4f:	78 2f                	js     a80 <stat+0x50>
 a51:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 a53:	8b 45 0c             	mov    0xc(%ebp),%eax
 a56:	89 1c 24             	mov    %ebx,(%esp)
 a59:	89 44 24 04          	mov    %eax,0x4(%esp)
 a5d:	e8 fe 00 00 00       	call   b60 <fstat>
  close(fd);
 a62:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 a65:	89 c6                	mov    %eax,%esi
  close(fd);
 a67:	e8 c4 00 00 00       	call   b30 <close>
  return r;
}
 a6c:	89 f0                	mov    %esi,%eax
 a6e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 a71:	8b 75 fc             	mov    -0x4(%ebp),%esi
 a74:	89 ec                	mov    %ebp,%esp
 a76:	5d                   	pop    %ebp
 a77:	c3                   	ret    
 a78:	90                   	nop
 a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 a80:	be ff ff ff ff       	mov    $0xffffffff,%esi
 a85:	eb e5                	jmp    a6c <stat+0x3c>
 a87:	89 f6                	mov    %esi,%esi
 a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a90 <atoi>:

int
atoi(const char *s)
{
 a90:	55                   	push   %ebp
 a91:	89 e5                	mov    %esp,%ebp
 a93:	8b 4d 08             	mov    0x8(%ebp),%ecx
 a96:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 a97:	0f be 11             	movsbl (%ecx),%edx
 a9a:	88 d0                	mov    %dl,%al
 a9c:	2c 30                	sub    $0x30,%al
 a9e:	3c 09                	cmp    $0x9,%al
  n = 0;
 aa0:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 aa5:	77 1e                	ja     ac5 <atoi+0x35>
 aa7:	89 f6                	mov    %esi,%esi
 aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 ab0:	41                   	inc    %ecx
 ab1:	8d 04 80             	lea    (%eax,%eax,4),%eax
 ab4:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 ab8:	0f be 11             	movsbl (%ecx),%edx
 abb:	88 d3                	mov    %dl,%bl
 abd:	80 eb 30             	sub    $0x30,%bl
 ac0:	80 fb 09             	cmp    $0x9,%bl
 ac3:	76 eb                	jbe    ab0 <atoi+0x20>
  return n;
}
 ac5:	5b                   	pop    %ebx
 ac6:	5d                   	pop    %ebp
 ac7:	c3                   	ret    
 ac8:	90                   	nop
 ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000ad0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 ad0:	55                   	push   %ebp
 ad1:	89 e5                	mov    %esp,%ebp
 ad3:	56                   	push   %esi
 ad4:	8b 45 08             	mov    0x8(%ebp),%eax
 ad7:	53                   	push   %ebx
 ad8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 adb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 ade:	85 db                	test   %ebx,%ebx
 ae0:	7e 1a                	jle    afc <memmove+0x2c>
 ae2:	31 d2                	xor    %edx,%edx
 ae4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 aea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 af0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 af4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 af7:	42                   	inc    %edx
  while(n-- > 0)
 af8:	39 d3                	cmp    %edx,%ebx
 afa:	75 f4                	jne    af0 <memmove+0x20>
  return vdst;
}
 afc:	5b                   	pop    %ebx
 afd:	5e                   	pop    %esi
 afe:	5d                   	pop    %ebp
 aff:	c3                   	ret    

00000b00 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 b00:	b8 01 00 00 00       	mov    $0x1,%eax
 b05:	cd 40                	int    $0x40
 b07:	c3                   	ret    

00000b08 <exit>:
SYSCALL(exit)
 b08:	b8 02 00 00 00       	mov    $0x2,%eax
 b0d:	cd 40                	int    $0x40
 b0f:	c3                   	ret    

00000b10 <wait>:
SYSCALL(wait)
 b10:	b8 03 00 00 00       	mov    $0x3,%eax
 b15:	cd 40                	int    $0x40
 b17:	c3                   	ret    

00000b18 <pipe>:
SYSCALL(pipe)
 b18:	b8 04 00 00 00       	mov    $0x4,%eax
 b1d:	cd 40                	int    $0x40
 b1f:	c3                   	ret    

00000b20 <read>:
SYSCALL(read)
 b20:	b8 05 00 00 00       	mov    $0x5,%eax
 b25:	cd 40                	int    $0x40
 b27:	c3                   	ret    

00000b28 <write>:
SYSCALL(write)
 b28:	b8 10 00 00 00       	mov    $0x10,%eax
 b2d:	cd 40                	int    $0x40
 b2f:	c3                   	ret    

00000b30 <close>:
SYSCALL(close)
 b30:	b8 15 00 00 00       	mov    $0x15,%eax
 b35:	cd 40                	int    $0x40
 b37:	c3                   	ret    

00000b38 <kill>:
SYSCALL(kill)
 b38:	b8 06 00 00 00       	mov    $0x6,%eax
 b3d:	cd 40                	int    $0x40
 b3f:	c3                   	ret    

00000b40 <exec>:
SYSCALL(exec)
 b40:	b8 07 00 00 00       	mov    $0x7,%eax
 b45:	cd 40                	int    $0x40
 b47:	c3                   	ret    

00000b48 <open>:
SYSCALL(open)
 b48:	b8 0f 00 00 00       	mov    $0xf,%eax
 b4d:	cd 40                	int    $0x40
 b4f:	c3                   	ret    

00000b50 <mknod>:
SYSCALL(mknod)
 b50:	b8 11 00 00 00       	mov    $0x11,%eax
 b55:	cd 40                	int    $0x40
 b57:	c3                   	ret    

00000b58 <unlink>:
SYSCALL(unlink)
 b58:	b8 12 00 00 00       	mov    $0x12,%eax
 b5d:	cd 40                	int    $0x40
 b5f:	c3                   	ret    

00000b60 <fstat>:
SYSCALL(fstat)
 b60:	b8 08 00 00 00       	mov    $0x8,%eax
 b65:	cd 40                	int    $0x40
 b67:	c3                   	ret    

00000b68 <link>:
SYSCALL(link)
 b68:	b8 13 00 00 00       	mov    $0x13,%eax
 b6d:	cd 40                	int    $0x40
 b6f:	c3                   	ret    

00000b70 <mkdir>:
SYSCALL(mkdir)
 b70:	b8 14 00 00 00       	mov    $0x14,%eax
 b75:	cd 40                	int    $0x40
 b77:	c3                   	ret    

00000b78 <chdir>:
SYSCALL(chdir)
 b78:	b8 09 00 00 00       	mov    $0x9,%eax
 b7d:	cd 40                	int    $0x40
 b7f:	c3                   	ret    

00000b80 <dup>:
SYSCALL(dup)
 b80:	b8 0a 00 00 00       	mov    $0xa,%eax
 b85:	cd 40                	int    $0x40
 b87:	c3                   	ret    

00000b88 <getpid>:
SYSCALL(getpid)
 b88:	b8 0b 00 00 00       	mov    $0xb,%eax
 b8d:	cd 40                	int    $0x40
 b8f:	c3                   	ret    

00000b90 <sbrk>:
SYSCALL(sbrk)
 b90:	b8 0c 00 00 00       	mov    $0xc,%eax
 b95:	cd 40                	int    $0x40
 b97:	c3                   	ret    

00000b98 <sleep>:
SYSCALL(sleep)
 b98:	b8 0d 00 00 00       	mov    $0xd,%eax
 b9d:	cd 40                	int    $0x40
 b9f:	c3                   	ret    

00000ba0 <uptime>:
SYSCALL(uptime)
 ba0:	b8 0e 00 00 00       	mov    $0xe,%eax
 ba5:	cd 40                	int    $0x40
 ba7:	c3                   	ret    

00000ba8 <policy>:
SYSCALL(policy)
 ba8:	b8 17 00 00 00       	mov    $0x17,%eax
 bad:	cd 40                	int    $0x40
 baf:	c3                   	ret    

00000bb0 <detach>:
SYSCALL(detach)
 bb0:	b8 16 00 00 00       	mov    $0x16,%eax
 bb5:	cd 40                	int    $0x40
 bb7:	c3                   	ret    

00000bb8 <priority>:
SYSCALL(priority)
 bb8:	b8 18 00 00 00       	mov    $0x18,%eax
 bbd:	cd 40                	int    $0x40
 bbf:	c3                   	ret    

00000bc0 <wait_stat>:
SYSCALL(wait_stat)
 bc0:	b8 19 00 00 00       	mov    $0x19,%eax
 bc5:	cd 40                	int    $0x40
 bc7:	c3                   	ret    
 bc8:	66 90                	xchg   %ax,%ax
 bca:	66 90                	xchg   %ax,%ax
 bcc:	66 90                	xchg   %ax,%ax
 bce:	66 90                	xchg   %ax,%ax

00000bd0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 bd0:	55                   	push   %ebp
 bd1:	89 e5                	mov    %esp,%ebp
 bd3:	57                   	push   %edi
 bd4:	56                   	push   %esi
 bd5:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 bd6:	89 d3                	mov    %edx,%ebx
 bd8:	c1 eb 1f             	shr    $0x1f,%ebx
{
 bdb:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 bde:	84 db                	test   %bl,%bl
{
 be0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 be3:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 be5:	74 79                	je     c60 <printint+0x90>
 be7:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 beb:	74 73                	je     c60 <printint+0x90>
    neg = 1;
    x = -xx;
 bed:	f7 d8                	neg    %eax
    neg = 1;
 bef:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 bf6:	31 f6                	xor    %esi,%esi
 bf8:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 bfb:	eb 05                	jmp    c02 <printint+0x32>
 bfd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 c00:	89 fe                	mov    %edi,%esi
 c02:	31 d2                	xor    %edx,%edx
 c04:	f7 f1                	div    %ecx
 c06:	8d 7e 01             	lea    0x1(%esi),%edi
 c09:	0f b6 92 b4 11 00 00 	movzbl 0x11b4(%edx),%edx
  }while((x /= base) != 0);
 c10:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 c12:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 c15:	75 e9                	jne    c00 <printint+0x30>
  if(neg)
 c17:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 c1a:	85 d2                	test   %edx,%edx
 c1c:	74 08                	je     c26 <printint+0x56>
    buf[i++] = '-';
 c1e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 c23:	8d 7e 02             	lea    0x2(%esi),%edi
 c26:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 c2a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 c2d:	8d 76 00             	lea    0x0(%esi),%esi
 c30:	0f b6 06             	movzbl (%esi),%eax
 c33:	4e                   	dec    %esi
  write(fd, &c, 1);
 c34:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 c38:	89 3c 24             	mov    %edi,(%esp)
 c3b:	88 45 d7             	mov    %al,-0x29(%ebp)
 c3e:	b8 01 00 00 00       	mov    $0x1,%eax
 c43:	89 44 24 08          	mov    %eax,0x8(%esp)
 c47:	e8 dc fe ff ff       	call   b28 <write>

  while(--i >= 0)
 c4c:	39 de                	cmp    %ebx,%esi
 c4e:	75 e0                	jne    c30 <printint+0x60>
    putc(fd, buf[i]);
}
 c50:	83 c4 4c             	add    $0x4c,%esp
 c53:	5b                   	pop    %ebx
 c54:	5e                   	pop    %esi
 c55:	5f                   	pop    %edi
 c56:	5d                   	pop    %ebp
 c57:	c3                   	ret    
 c58:	90                   	nop
 c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 c60:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 c67:	eb 8d                	jmp    bf6 <printint+0x26>
 c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000c70 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 c70:	55                   	push   %ebp
 c71:	89 e5                	mov    %esp,%ebp
 c73:	57                   	push   %edi
 c74:	56                   	push   %esi
 c75:	53                   	push   %ebx
 c76:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 c79:	8b 75 0c             	mov    0xc(%ebp),%esi
 c7c:	0f b6 1e             	movzbl (%esi),%ebx
 c7f:	84 db                	test   %bl,%bl
 c81:	0f 84 d1 00 00 00    	je     d58 <printf+0xe8>
  state = 0;
 c87:	31 ff                	xor    %edi,%edi
 c89:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 c8a:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 c8d:	89 fa                	mov    %edi,%edx
 c8f:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 c92:	89 45 d0             	mov    %eax,-0x30(%ebp)
 c95:	eb 41                	jmp    cd8 <printf+0x68>
 c97:	89 f6                	mov    %esi,%esi
 c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 ca0:	83 f8 25             	cmp    $0x25,%eax
 ca3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 ca6:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 cab:	74 1e                	je     ccb <printf+0x5b>
  write(fd, &c, 1);
 cad:	b8 01 00 00 00       	mov    $0x1,%eax
 cb2:	89 44 24 08          	mov    %eax,0x8(%esp)
 cb6:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 cb9:	89 44 24 04          	mov    %eax,0x4(%esp)
 cbd:	89 3c 24             	mov    %edi,(%esp)
 cc0:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 cc3:	e8 60 fe ff ff       	call   b28 <write>
 cc8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 ccb:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 ccc:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 cd0:	84 db                	test   %bl,%bl
 cd2:	0f 84 80 00 00 00    	je     d58 <printf+0xe8>
    if(state == 0){
 cd8:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 cda:	0f be cb             	movsbl %bl,%ecx
 cdd:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 ce0:	74 be                	je     ca0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 ce2:	83 fa 25             	cmp    $0x25,%edx
 ce5:	75 e4                	jne    ccb <printf+0x5b>
      if(c == 'd'){
 ce7:	83 f8 64             	cmp    $0x64,%eax
 cea:	0f 84 f0 00 00 00    	je     de0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 cf0:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 cf6:	83 f9 70             	cmp    $0x70,%ecx
 cf9:	74 65                	je     d60 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 cfb:	83 f8 73             	cmp    $0x73,%eax
 cfe:	0f 84 8c 00 00 00    	je     d90 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 d04:	83 f8 63             	cmp    $0x63,%eax
 d07:	0f 84 13 01 00 00    	je     e20 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 d0d:	83 f8 25             	cmp    $0x25,%eax
 d10:	0f 84 e2 00 00 00    	je     df8 <printf+0x188>
  write(fd, &c, 1);
 d16:	b8 01 00 00 00       	mov    $0x1,%eax
 d1b:	46                   	inc    %esi
 d1c:	89 44 24 08          	mov    %eax,0x8(%esp)
 d20:	8d 45 e7             	lea    -0x19(%ebp),%eax
 d23:	89 44 24 04          	mov    %eax,0x4(%esp)
 d27:	89 3c 24             	mov    %edi,(%esp)
 d2a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 d2e:	e8 f5 fd ff ff       	call   b28 <write>
 d33:	ba 01 00 00 00       	mov    $0x1,%edx
 d38:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 d3b:	89 54 24 08          	mov    %edx,0x8(%esp)
 d3f:	89 44 24 04          	mov    %eax,0x4(%esp)
 d43:	89 3c 24             	mov    %edi,(%esp)
 d46:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 d49:	e8 da fd ff ff       	call   b28 <write>
  for(i = 0; fmt[i]; i++){
 d4e:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 d52:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 d54:	84 db                	test   %bl,%bl
 d56:	75 80                	jne    cd8 <printf+0x68>
    }
  }
}
 d58:	83 c4 3c             	add    $0x3c,%esp
 d5b:	5b                   	pop    %ebx
 d5c:	5e                   	pop    %esi
 d5d:	5f                   	pop    %edi
 d5e:	5d                   	pop    %ebp
 d5f:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 d60:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 d67:	b9 10 00 00 00       	mov    $0x10,%ecx
 d6c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 d6f:	89 f8                	mov    %edi,%eax
 d71:	8b 13                	mov    (%ebx),%edx
 d73:	e8 58 fe ff ff       	call   bd0 <printint>
        ap++;
 d78:	89 d8                	mov    %ebx,%eax
      state = 0;
 d7a:	31 d2                	xor    %edx,%edx
        ap++;
 d7c:	83 c0 04             	add    $0x4,%eax
 d7f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 d82:	e9 44 ff ff ff       	jmp    ccb <printf+0x5b>
 d87:	89 f6                	mov    %esi,%esi
 d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 d90:	8b 45 d0             	mov    -0x30(%ebp),%eax
 d93:	8b 10                	mov    (%eax),%edx
        ap++;
 d95:	83 c0 04             	add    $0x4,%eax
 d98:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 d9b:	85 d2                	test   %edx,%edx
 d9d:	0f 84 aa 00 00 00    	je     e4d <printf+0x1dd>
        while(*s != 0){
 da3:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 da6:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 da8:	84 c0                	test   %al,%al
 daa:	74 27                	je     dd3 <printf+0x163>
 dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 db0:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 db3:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 db8:	43                   	inc    %ebx
  write(fd, &c, 1);
 db9:	89 44 24 08          	mov    %eax,0x8(%esp)
 dbd:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 dc0:	89 44 24 04          	mov    %eax,0x4(%esp)
 dc4:	89 3c 24             	mov    %edi,(%esp)
 dc7:	e8 5c fd ff ff       	call   b28 <write>
        while(*s != 0){
 dcc:	0f b6 03             	movzbl (%ebx),%eax
 dcf:	84 c0                	test   %al,%al
 dd1:	75 dd                	jne    db0 <printf+0x140>
      state = 0;
 dd3:	31 d2                	xor    %edx,%edx
 dd5:	e9 f1 fe ff ff       	jmp    ccb <printf+0x5b>
 dda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 de0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 de7:	b9 0a 00 00 00       	mov    $0xa,%ecx
 dec:	e9 7b ff ff ff       	jmp    d6c <printf+0xfc>
 df1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 df8:	b9 01 00 00 00       	mov    $0x1,%ecx
 dfd:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 e00:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 e04:	89 44 24 04          	mov    %eax,0x4(%esp)
 e08:	89 3c 24             	mov    %edi,(%esp)
 e0b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 e0e:	e8 15 fd ff ff       	call   b28 <write>
      state = 0;
 e13:	31 d2                	xor    %edx,%edx
 e15:	e9 b1 fe ff ff       	jmp    ccb <printf+0x5b>
 e1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 e20:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 e23:	8b 03                	mov    (%ebx),%eax
        ap++;
 e25:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 e28:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 e2b:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 e2e:	b8 01 00 00 00       	mov    $0x1,%eax
 e33:	89 44 24 08          	mov    %eax,0x8(%esp)
 e37:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 e3a:	89 44 24 04          	mov    %eax,0x4(%esp)
 e3e:	e8 e5 fc ff ff       	call   b28 <write>
      state = 0;
 e43:	31 d2                	xor    %edx,%edx
        ap++;
 e45:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 e48:	e9 7e fe ff ff       	jmp    ccb <printf+0x5b>
          s = "(null)";
 e4d:	bb ac 11 00 00       	mov    $0x11ac,%ebx
        while(*s != 0){
 e52:	b0 28                	mov    $0x28,%al
 e54:	e9 57 ff ff ff       	jmp    db0 <printf+0x140>
 e59:	66 90                	xchg   %ax,%ax
 e5b:	66 90                	xchg   %ax,%ax
 e5d:	66 90                	xchg   %ax,%ax
 e5f:	90                   	nop

00000e60 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 e60:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e61:	a1 50 17 00 00       	mov    0x1750,%eax
{
 e66:	89 e5                	mov    %esp,%ebp
 e68:	57                   	push   %edi
 e69:	56                   	push   %esi
 e6a:	53                   	push   %ebx
 e6b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 e6e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 e71:	eb 0d                	jmp    e80 <free+0x20>
 e73:	90                   	nop
 e74:	90                   	nop
 e75:	90                   	nop
 e76:	90                   	nop
 e77:	90                   	nop
 e78:	90                   	nop
 e79:	90                   	nop
 e7a:	90                   	nop
 e7b:	90                   	nop
 e7c:	90                   	nop
 e7d:	90                   	nop
 e7e:	90                   	nop
 e7f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e80:	39 c8                	cmp    %ecx,%eax
 e82:	8b 10                	mov    (%eax),%edx
 e84:	73 32                	jae    eb8 <free+0x58>
 e86:	39 d1                	cmp    %edx,%ecx
 e88:	72 04                	jb     e8e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e8a:	39 d0                	cmp    %edx,%eax
 e8c:	72 32                	jb     ec0 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 e8e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 e91:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 e94:	39 fa                	cmp    %edi,%edx
 e96:	74 30                	je     ec8 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 e98:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 e9b:	8b 50 04             	mov    0x4(%eax),%edx
 e9e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 ea1:	39 f1                	cmp    %esi,%ecx
 ea3:	74 3c                	je     ee1 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 ea5:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 ea7:	5b                   	pop    %ebx
  freep = p;
 ea8:	a3 50 17 00 00       	mov    %eax,0x1750
}
 ead:	5e                   	pop    %esi
 eae:	5f                   	pop    %edi
 eaf:	5d                   	pop    %ebp
 eb0:	c3                   	ret    
 eb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 eb8:	39 d0                	cmp    %edx,%eax
 eba:	72 04                	jb     ec0 <free+0x60>
 ebc:	39 d1                	cmp    %edx,%ecx
 ebe:	72 ce                	jb     e8e <free+0x2e>
{
 ec0:	89 d0                	mov    %edx,%eax
 ec2:	eb bc                	jmp    e80 <free+0x20>
 ec4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 ec8:	8b 7a 04             	mov    0x4(%edx),%edi
 ecb:	01 fe                	add    %edi,%esi
 ecd:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 ed0:	8b 10                	mov    (%eax),%edx
 ed2:	8b 12                	mov    (%edx),%edx
 ed4:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 ed7:	8b 50 04             	mov    0x4(%eax),%edx
 eda:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 edd:	39 f1                	cmp    %esi,%ecx
 edf:	75 c4                	jne    ea5 <free+0x45>
    p->s.size += bp->s.size;
 ee1:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 ee4:	a3 50 17 00 00       	mov    %eax,0x1750
    p->s.size += bp->s.size;
 ee9:	01 ca                	add    %ecx,%edx
 eeb:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 eee:	8b 53 f8             	mov    -0x8(%ebx),%edx
 ef1:	89 10                	mov    %edx,(%eax)
}
 ef3:	5b                   	pop    %ebx
 ef4:	5e                   	pop    %esi
 ef5:	5f                   	pop    %edi
 ef6:	5d                   	pop    %ebp
 ef7:	c3                   	ret    
 ef8:	90                   	nop
 ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000f00 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 f00:	55                   	push   %ebp
 f01:	89 e5                	mov    %esp,%ebp
 f03:	57                   	push   %edi
 f04:	56                   	push   %esi
 f05:	53                   	push   %ebx
 f06:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 f09:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 f0c:	8b 15 50 17 00 00    	mov    0x1750,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 f12:	8d 78 07             	lea    0x7(%eax),%edi
 f15:	c1 ef 03             	shr    $0x3,%edi
 f18:	47                   	inc    %edi
  if((prevp = freep) == 0){
 f19:	85 d2                	test   %edx,%edx
 f1b:	0f 84 8f 00 00 00    	je     fb0 <malloc+0xb0>
 f21:	8b 02                	mov    (%edx),%eax
 f23:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 f26:	39 cf                	cmp    %ecx,%edi
 f28:	76 66                	jbe    f90 <malloc+0x90>
 f2a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 f30:	bb 00 10 00 00       	mov    $0x1000,%ebx
 f35:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 f38:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 f3f:	eb 10                	jmp    f51 <malloc+0x51>
 f41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 f48:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 f4a:	8b 48 04             	mov    0x4(%eax),%ecx
 f4d:	39 f9                	cmp    %edi,%ecx
 f4f:	73 3f                	jae    f90 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 f51:	39 05 50 17 00 00    	cmp    %eax,0x1750
 f57:	89 c2                	mov    %eax,%edx
 f59:	75 ed                	jne    f48 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 f5b:	89 34 24             	mov    %esi,(%esp)
 f5e:	e8 2d fc ff ff       	call   b90 <sbrk>
  if(p == (char*)-1)
 f63:	83 f8 ff             	cmp    $0xffffffff,%eax
 f66:	74 18                	je     f80 <malloc+0x80>
  hp->s.size = nu;
 f68:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 f6b:	83 c0 08             	add    $0x8,%eax
 f6e:	89 04 24             	mov    %eax,(%esp)
 f71:	e8 ea fe ff ff       	call   e60 <free>
  return freep;
 f76:	8b 15 50 17 00 00    	mov    0x1750,%edx
      if((p = morecore(nunits)) == 0)
 f7c:	85 d2                	test   %edx,%edx
 f7e:	75 c8                	jne    f48 <malloc+0x48>
        return 0;
  }
}
 f80:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 f83:	31 c0                	xor    %eax,%eax
}
 f85:	5b                   	pop    %ebx
 f86:	5e                   	pop    %esi
 f87:	5f                   	pop    %edi
 f88:	5d                   	pop    %ebp
 f89:	c3                   	ret    
 f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 f90:	39 cf                	cmp    %ecx,%edi
 f92:	74 4c                	je     fe0 <malloc+0xe0>
        p->s.size -= nunits;
 f94:	29 f9                	sub    %edi,%ecx
 f96:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 f99:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 f9c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 f9f:	89 15 50 17 00 00    	mov    %edx,0x1750
}
 fa5:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 fa8:	83 c0 08             	add    $0x8,%eax
}
 fab:	5b                   	pop    %ebx
 fac:	5e                   	pop    %esi
 fad:	5f                   	pop    %edi
 fae:	5d                   	pop    %ebp
 faf:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 fb0:	b8 54 17 00 00       	mov    $0x1754,%eax
 fb5:	ba 54 17 00 00       	mov    $0x1754,%edx
    base.s.size = 0;
 fba:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 fbc:	a3 50 17 00 00       	mov    %eax,0x1750
    base.s.size = 0;
 fc1:	b8 54 17 00 00       	mov    $0x1754,%eax
    base.s.ptr = freep = prevp = &base;
 fc6:	89 15 54 17 00 00    	mov    %edx,0x1754
    base.s.size = 0;
 fcc:	89 0d 58 17 00 00    	mov    %ecx,0x1758
 fd2:	e9 53 ff ff ff       	jmp    f2a <malloc+0x2a>
 fd7:	89 f6                	mov    %esi,%esi
 fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 fe0:	8b 08                	mov    (%eax),%ecx
 fe2:	89 0a                	mov    %ecx,(%edx)
 fe4:	eb b9                	jmp    f9f <malloc+0x9f>
