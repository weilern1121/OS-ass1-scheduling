
_schedulingTest10:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
int executeForever(int timeToSleep,char* debugString);
int executeTimes(int timeToSleep,int numberOfLoops,int isDetach,char* debugString);

int executePriority(int thePriority,long long times,char* debugString);

int main(int argc, char *argv[]){  
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
    
    childPid1 = executeForever(0,"childPid1");
    childPid2 = executeForever(0,"childPid2");
    childPid3 = executeForever(0,"childPid3");
    childPid4 = executeForever(0,"childPid4");
    childPid5 = executeForever(1000,"childPid5");
   4:	bf ad 0b 00 00       	mov    $0xbad,%edi
int main(int argc, char *argv[]){  
   9:	56                   	push   %esi
    childPid4 = executeForever(0,"childPid4");
   a:	be a3 0b 00 00       	mov    $0xba3,%esi
int main(int argc, char *argv[]){  
   f:	53                   	push   %ebx
    childPid3 = executeForever(0,"childPid3");
  10:	bb 99 0b 00 00       	mov    $0xb99,%ebx
int main(int argc, char *argv[]){  
  15:	83 e4 f0             	and    $0xfffffff0,%esp
  18:	83 ec 40             	sub    $0x40,%esp
    policy(3);
  1b:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
  22:	e8 11 07 00 00       	call   738 <policy>
    printf(1,"Initiating scheduling test, test should take approximately 15000 time quantums !!!\n");
  27:	b8 58 0c 00 00       	mov    $0xc58,%eax
  2c:	89 44 24 04          	mov    %eax,0x4(%esp)
  30:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  37:	e8 c4 07 00 00       	call   800 <printf>
    childPid1 = executeForever(0,"childPid1");
  3c:	ba 85 0b 00 00       	mov    $0xb85,%edx
  41:	89 54 24 04          	mov    %edx,0x4(%esp)
  45:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  4c:	e8 ff 02 00 00       	call   350 <executeForever>
    childPid2 = executeForever(0,"childPid2");
  51:	b9 8f 0b 00 00       	mov    $0xb8f,%ecx
  56:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  5a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    childPid1 = executeForever(0,"childPid1");
  61:	89 44 24 10          	mov    %eax,0x10(%esp)
    childPid2 = executeForever(0,"childPid2");
  65:	e8 e6 02 00 00       	call   350 <executeForever>
    childPid3 = executeForever(0,"childPid3");
  6a:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    childPid9 = executeForever(0,"childPid9");
    childPid10 = executeForever(0,"childPid10");
    childPid11 = executeForever(0,"childPid11");
    childPid12 = executeForever(20000,"childPid12");
    childPid13 = executeForever(4567,"childPid13");
    childPid14 = executeForever(0,"childPid14");
  6e:	bb 0b 0c 00 00       	mov    $0xc0b,%ebx
    childPid3 = executeForever(0,"childPid3");
  73:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    childPid2 = executeForever(0,"childPid2");
  7a:	89 44 24 3c          	mov    %eax,0x3c(%esp)
    childPid3 = executeForever(0,"childPid3");
  7e:	e8 cd 02 00 00       	call   350 <executeForever>
    childPid4 = executeForever(0,"childPid4");
  83:	89 74 24 04          	mov    %esi,0x4(%esp)
  87:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    childPid3 = executeForever(0,"childPid3");
  8e:	89 44 24 38          	mov    %eax,0x38(%esp)
    childPid4 = executeForever(0,"childPid4");
  92:	e8 b9 02 00 00       	call   350 <executeForever>
    childPid5 = executeForever(1000,"childPid5");
  97:	89 7c 24 04          	mov    %edi,0x4(%esp)
  9b:	c7 04 24 e8 03 00 00 	movl   $0x3e8,(%esp)
    childPid4 = executeForever(0,"childPid4");
  a2:	89 44 24 34          	mov    %eax,0x34(%esp)
    childPid5 = executeForever(1000,"childPid5");
  a6:	e8 a5 02 00 00       	call   350 <executeForever>
    childPid6 = executeForever(10000,"childPid6");
  ab:	c7 04 24 10 27 00 00 	movl   $0x2710,(%esp)
    childPid5 = executeForever(1000,"childPid5");
  b2:	89 44 24 30          	mov    %eax,0x30(%esp)
    childPid6 = executeForever(10000,"childPid6");
  b6:	b8 b7 0b 00 00       	mov    $0xbb7,%eax
  bb:	89 44 24 04          	mov    %eax,0x4(%esp)
  bf:	e8 8c 02 00 00       	call   350 <executeForever>
    childPid7 = executeForever(0,"childPid7");
  c4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    childPid6 = executeForever(10000,"childPid6");
  cb:	89 44 24 2c          	mov    %eax,0x2c(%esp)
    childPid7 = executeForever(0,"childPid7");
  cf:	b8 c1 0b 00 00       	mov    $0xbc1,%eax
  d4:	89 44 24 04          	mov    %eax,0x4(%esp)
  d8:	e8 73 02 00 00       	call   350 <executeForever>
    childPid8 = executeForever(0,"childPid8");
  dd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    childPid7 = executeForever(0,"childPid7");
  e4:	89 44 24 28          	mov    %eax,0x28(%esp)
    childPid8 = executeForever(0,"childPid8");
  e8:	b8 cb 0b 00 00       	mov    $0xbcb,%eax
  ed:	89 44 24 04          	mov    %eax,0x4(%esp)
  f1:	e8 5a 02 00 00       	call   350 <executeForever>
    childPid9 = executeForever(0,"childPid9");
  f6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    childPid8 = executeForever(0,"childPid8");
  fd:	89 44 24 24          	mov    %eax,0x24(%esp)
    childPid9 = executeForever(0,"childPid9");
 101:	b8 d5 0b 00 00       	mov    $0xbd5,%eax
 106:	89 44 24 04          	mov    %eax,0x4(%esp)
 10a:	e8 41 02 00 00       	call   350 <executeForever>
    childPid10 = executeForever(0,"childPid10");
 10f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    childPid9 = executeForever(0,"childPid9");
 116:	89 44 24 20          	mov    %eax,0x20(%esp)
    childPid10 = executeForever(0,"childPid10");
 11a:	b8 df 0b 00 00       	mov    $0xbdf,%eax
 11f:	89 44 24 04          	mov    %eax,0x4(%esp)
 123:	e8 28 02 00 00       	call   350 <executeForever>
    childPid11 = executeForever(0,"childPid11");
 128:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    childPid10 = executeForever(0,"childPid10");
 12f:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    childPid11 = executeForever(0,"childPid11");
 133:	b8 ea 0b 00 00       	mov    $0xbea,%eax
 138:	89 44 24 04          	mov    %eax,0x4(%esp)
 13c:	e8 0f 02 00 00       	call   350 <executeForever>
    childPid12 = executeForever(20000,"childPid12");
 141:	ba f5 0b 00 00       	mov    $0xbf5,%edx
 146:	89 54 24 04          	mov    %edx,0x4(%esp)
 14a:	c7 04 24 20 4e 00 00 	movl   $0x4e20,(%esp)
    childPid11 = executeForever(0,"childPid11");
 151:	89 44 24 18          	mov    %eax,0x18(%esp)
    childPid12 = executeForever(20000,"childPid12");
 155:	e8 f6 01 00 00       	call   350 <executeForever>
    childPid13 = executeForever(4567,"childPid13");
 15a:	b9 00 0c 00 00       	mov    $0xc00,%ecx
 15f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 163:	c7 04 24 d7 11 00 00 	movl   $0x11d7,(%esp)
    childPid12 = executeForever(20000,"childPid12");
 16a:	89 44 24 14          	mov    %eax,0x14(%esp)
    childPid13 = executeForever(4567,"childPid13");
 16e:	e8 dd 01 00 00       	call   350 <executeForever>
    childPid14 = executeForever(0,"childPid14");
 173:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 177:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    childPid13 = executeForever(4567,"childPid13");
 17e:	89 c7                	mov    %eax,%edi
    childPid14 = executeForever(0,"childPid14");
 180:	e8 cb 01 00 00       	call   350 <executeForever>
    childPid15 = executeForever(0,"childPid15");
 185:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    childPid14 = executeForever(0,"childPid14");
 18c:	89 c6                	mov    %eax,%esi
    childPid15 = executeForever(0,"childPid15");
 18e:	b8 16 0c 00 00       	mov    $0xc16,%eax
 193:	89 44 24 04          	mov    %eax,0x4(%esp)
 197:	e8 b4 01 00 00       	call   350 <executeForever>


    executeTimes(20,400,0,"childPid16");
 19c:	c7 04 24 14 00 00 00 	movl   $0x14,(%esp)
    childPid15 = executeForever(0,"childPid15");
 1a3:	89 c3                	mov    %eax,%ebx
    executeTimes(20,400,0,"childPid16");
 1a5:	b8 21 0c 00 00       	mov    $0xc21,%eax
 1aa:	89 44 24 0c          	mov    %eax,0xc(%esp)
 1ae:	31 c0                	xor    %eax,%eax
 1b0:	89 44 24 08          	mov    %eax,0x8(%esp)
 1b4:	b8 90 01 00 00       	mov    $0x190,%eax
 1b9:	89 44 24 04          	mov    %eax,0x4(%esp)
 1bd:	e8 0e 02 00 00       	call   3d0 <executeTimes>
    executeTimes(10,600,0,"childPid17");
 1c2:	b8 2c 0c 00 00       	mov    $0xc2c,%eax
 1c7:	ba 58 02 00 00       	mov    $0x258,%edx
 1cc:	89 44 24 0c          	mov    %eax,0xc(%esp)
 1d0:	31 c0                	xor    %eax,%eax
 1d2:	89 54 24 04          	mov    %edx,0x4(%esp)
 1d6:	89 44 24 08          	mov    %eax,0x8(%esp)
 1da:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
 1e1:	e8 ea 01 00 00       	call   3d0 <executeTimes>
    executeTimes(60,100,0,"childPid18");
 1e6:	31 c0                	xor    %eax,%eax
 1e8:	b9 37 0c 00 00       	mov    $0xc37,%ecx
 1ed:	89 44 24 08          	mov    %eax,0x8(%esp)
 1f1:	b8 64 00 00 00       	mov    $0x64,%eax
 1f6:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
 1fa:	89 44 24 04          	mov    %eax,0x4(%esp)
 1fe:	c7 04 24 3c 00 00 00 	movl   $0x3c,(%esp)
 205:	e8 c6 01 00 00       	call   3d0 <executeTimes>
    executeTimes(1000,12,0,"childPid19");
 20a:	b8 42 0c 00 00       	mov    $0xc42,%eax
 20f:	89 44 24 0c          	mov    %eax,0xc(%esp)
 213:	31 c0                	xor    %eax,%eax
 215:	89 44 24 08          	mov    %eax,0x8(%esp)
 219:	b8 0c 00 00 00       	mov    $0xc,%eax
 21e:	89 44 24 04          	mov    %eax,0x4(%esp)
 222:	c7 04 24 e8 03 00 00 	movl   $0x3e8,(%esp)
 229:	e8 a2 01 00 00       	call   3d0 <executeTimes>
    executeTimes(200,10,0,"childPid20");
 22e:	31 d2                	xor    %edx,%edx
 230:	b9 0a 00 00 00       	mov    $0xa,%ecx
 235:	b8 4d 0c 00 00       	mov    $0xc4d,%eax
 23a:	89 54 24 08          	mov    %edx,0x8(%esp)
 23e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 242:	89 44 24 0c          	mov    %eax,0xc(%esp)
 246:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
 24d:	e8 7e 01 00 00       	call   3d0 <executeTimes>
    
    wait(null);
 252:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 259:	e8 42 04 00 00       	call   6a0 <wait>
    wait(null);
 25e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 265:	e8 36 04 00 00       	call   6a0 <wait>
    wait(null);
 26a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 271:	e8 2a 04 00 00       	call   6a0 <wait>
    wait(null);
 276:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 27d:	e8 1e 04 00 00       	call   6a0 <wait>
    wait(null);
 282:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 289:	e8 12 04 00 00       	call   6a0 <wait>

    kill(childPid1);
 28e:	8b 4c 24 10          	mov    0x10(%esp),%ecx
 292:	89 0c 24             	mov    %ecx,(%esp)
 295:	e8 2e 04 00 00       	call   6c8 <kill>
    kill(childPid2);
 29a:	8b 54 24 3c          	mov    0x3c(%esp),%edx
 29e:	89 14 24             	mov    %edx,(%esp)
 2a1:	e8 22 04 00 00       	call   6c8 <kill>
    kill(childPid3);
 2a6:	8b 4c 24 38          	mov    0x38(%esp),%ecx
 2aa:	89 0c 24             	mov    %ecx,(%esp)
 2ad:	e8 16 04 00 00       	call   6c8 <kill>
    kill(childPid4);
 2b2:	8b 54 24 34          	mov    0x34(%esp),%edx
 2b6:	89 14 24             	mov    %edx,(%esp)
 2b9:	e8 0a 04 00 00       	call   6c8 <kill>
    kill(childPid5);
 2be:	8b 4c 24 30          	mov    0x30(%esp),%ecx
 2c2:	89 0c 24             	mov    %ecx,(%esp)
 2c5:	e8 fe 03 00 00       	call   6c8 <kill>
    kill(childPid6);
 2ca:	8b 54 24 2c          	mov    0x2c(%esp),%edx
 2ce:	89 14 24             	mov    %edx,(%esp)
 2d1:	e8 f2 03 00 00       	call   6c8 <kill>
    kill(childPid7);
 2d6:	8b 4c 24 28          	mov    0x28(%esp),%ecx
 2da:	89 0c 24             	mov    %ecx,(%esp)
 2dd:	e8 e6 03 00 00       	call   6c8 <kill>
    kill(childPid8);
 2e2:	8b 54 24 24          	mov    0x24(%esp),%edx
 2e6:	89 14 24             	mov    %edx,(%esp)
 2e9:	e8 da 03 00 00       	call   6c8 <kill>
    kill(childPid9);
 2ee:	8b 4c 24 20          	mov    0x20(%esp),%ecx
 2f2:	89 0c 24             	mov    %ecx,(%esp)
 2f5:	e8 ce 03 00 00       	call   6c8 <kill>
    kill(childPid10);
 2fa:	8b 54 24 1c          	mov    0x1c(%esp),%edx
 2fe:	89 14 24             	mov    %edx,(%esp)
 301:	e8 c2 03 00 00       	call   6c8 <kill>
    kill(childPid11);
 306:	8b 44 24 18          	mov    0x18(%esp),%eax
 30a:	89 04 24             	mov    %eax,(%esp)
 30d:	e8 b6 03 00 00       	call   6c8 <kill>
    kill(childPid12);
 312:	8b 54 24 14          	mov    0x14(%esp),%edx
 316:	89 14 24             	mov    %edx,(%esp)
 319:	e8 aa 03 00 00       	call   6c8 <kill>
    kill(childPid13);
 31e:	89 3c 24             	mov    %edi,(%esp)
 321:	e8 a2 03 00 00       	call   6c8 <kill>
    kill(childPid14);
 326:	89 34 24             	mov    %esi,(%esp)
 329:	e8 9a 03 00 00       	call   6c8 <kill>
    kill(childPid15);
 32e:	89 1c 24             	mov    %ebx,(%esp)
 331:	e8 92 03 00 00       	call   6c8 <kill>

    sleep(2000);
 336:	c7 04 24 d0 07 00 00 	movl   $0x7d0,(%esp)
 33d:	e8 e6 03 00 00       	call   728 <sleep>

    exit(0);
 342:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 349:	e8 4a 03 00 00       	call   698 <exit>
 34e:	66 90                	xchg   %ax,%ax

00000350 <executeForever>:
}

int executeForever(int timeToSleep,char* debugString){
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	56                   	push   %esi
 354:	53                   	push   %ebx
 355:	83 ec 10             	sub    $0x10,%esp
 358:	8b 5d 08             	mov    0x8(%ebp),%ebx
    int pid;

    if((pid = fork()) == 0){
 35b:	e8 30 03 00 00       	call   690 <fork>
 360:	83 f8 00             	cmp    $0x0,%eax
 363:	74 15                	je     37a <executeForever+0x2a>
            printf(1," ending...\n");
        }

        exit(0);
    }
    else if(pid > 0){
 365:	7e 43                	jle    3aa <executeForever+0x5a>
        detach(pid);
 367:	89 04 24             	mov    %eax,(%esp)
 36a:	89 c6                	mov    %eax,%esi
 36c:	e8 cf 03 00 00       	call   740 <detach>
    }
    else{
        printf(1,"fork failed\n");
        return 0;
    }
}
 371:	83 c4 10             	add    $0x10,%esp
 374:	89 f0                	mov    %esi,%eax
 376:	5b                   	pop    %ebx
 377:	5e                   	pop    %esi
 378:	5d                   	pop    %ebp
 379:	c3                   	ret    
        priority(0);
 37a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 381:	e8 c2 03 00 00       	call   748 <priority>
 386:	8d 76 00             	lea    0x0(%esi),%esi
 389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            if(timeToSleep){   
 390:	85 db                	test   %ebx,%ebx
 392:	75 0c                	jne    3a0 <executeForever+0x50>
 394:	eb fe                	jmp    394 <executeForever+0x44>
 396:	8d 76 00             	lea    0x0(%esi),%esi
 399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
                sleep(timeToSleep);   
 3a0:	89 1c 24             	mov    %ebx,(%esp)
 3a3:	e8 80 03 00 00       	call   728 <sleep>
 3a8:	eb e6                	jmp    390 <executeForever+0x40>
        printf(1,"fork failed\n");
 3aa:	b8 78 0b 00 00       	mov    $0xb78,%eax
        return 0;
 3af:	31 f6                	xor    %esi,%esi
        printf(1,"fork failed\n");
 3b1:	89 44 24 04          	mov    %eax,0x4(%esp)
 3b5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 3bc:	e8 3f 04 00 00       	call   800 <printf>
        return 0;
 3c1:	eb ae                	jmp    371 <executeForever+0x21>
 3c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003d0 <executeTimes>:

int executeTimes(int timeToSleep,int numberOfLoops,int isDetach,char* debugString){
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	53                   	push   %ebx
 3d4:	83 ec 14             	sub    $0x14,%esp
    int pid;

    if((pid = fork()) == 0){
 3d7:	e8 b4 02 00 00       	call   690 <fork>
 3dc:	83 f8 00             	cmp    $0x0,%eax
 3df:	89 c3                	mov    %eax,%ebx
 3e1:	74 4c                	je     42f <executeTimes+0x5f>
            printf(1," ending...\n");
        }

        exit(0);
    }
    else if(pid > 0){
 3e3:	7e 2b                	jle    410 <executeTimes+0x40>
        if(isDetach){
 3e5:	8b 55 10             	mov    0x10(%ebp),%edx
 3e8:	85 d2                	test   %edx,%edx
 3ea:	75 0c                	jne    3f8 <executeTimes+0x28>
    }
    else{
        printf(1,"fork failed\n");
        return 0;
    }
 3ec:	83 c4 14             	add    $0x14,%esp
 3ef:	89 d8                	mov    %ebx,%eax
 3f1:	5b                   	pop    %ebx
 3f2:	5d                   	pop    %ebp
 3f3:	c3                   	ret    
 3f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            detach(pid);        
 3f8:	89 04 24             	mov    %eax,(%esp)
 3fb:	e8 40 03 00 00       	call   740 <detach>
 400:	83 c4 14             	add    $0x14,%esp
 403:	89 d8                	mov    %ebx,%eax
 405:	5b                   	pop    %ebx
 406:	5d                   	pop    %ebp
 407:	c3                   	ret    
 408:	90                   	nop
 409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1,"fork failed\n");
 410:	b8 78 0b 00 00       	mov    $0xb78,%eax
        return 0;
 415:	31 db                	xor    %ebx,%ebx
        printf(1,"fork failed\n");
 417:	89 44 24 04          	mov    %eax,0x4(%esp)
 41b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 422:	e8 d9 03 00 00       	call   800 <printf>
 427:	83 c4 14             	add    $0x14,%esp
 42a:	89 d8                	mov    %ebx,%eax
 42c:	5b                   	pop    %ebx
 42d:	5d                   	pop    %ebp
 42e:	c3                   	ret    
        priority(4);
 42f:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 436:	e8 0d 03 00 00       	call   748 <priority>
        sleep(1000);
 43b:	c7 04 24 e8 03 00 00 	movl   $0x3e8,(%esp)
 442:	e8 e1 02 00 00       	call   728 <sleep>
        for(int i = 0;i < numberOfLoops;i++){
 447:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 44b:	7e 11                	jle    45e <executeTimes+0x8e>
            sleep(timeToSleep);
 44d:	8b 45 08             	mov    0x8(%ebp),%eax
        for(int i = 0;i < numberOfLoops;i++){
 450:	43                   	inc    %ebx
            sleep(timeToSleep);
 451:	89 04 24             	mov    %eax,(%esp)
 454:	e8 cf 02 00 00       	call   728 <sleep>
        for(int i = 0;i < numberOfLoops;i++){
 459:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
 45c:	75 ef                	jne    44d <executeTimes+0x7d>
        exit(0);
 45e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 465:	e8 2e 02 00 00       	call   698 <exit>
 46a:	66 90                	xchg   %ax,%ax
 46c:	66 90                	xchg   %ax,%ax
 46e:	66 90                	xchg   %ax,%ax

00000470 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	8b 45 08             	mov    0x8(%ebp),%eax
 476:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 479:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 47a:	89 c2                	mov    %eax,%edx
 47c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 480:	41                   	inc    %ecx
 481:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 485:	42                   	inc    %edx
 486:	84 db                	test   %bl,%bl
 488:	88 5a ff             	mov    %bl,-0x1(%edx)
 48b:	75 f3                	jne    480 <strcpy+0x10>
    ;
  return os;
}
 48d:	5b                   	pop    %ebx
 48e:	5d                   	pop    %ebp
 48f:	c3                   	ret    

00000490 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	8b 4d 08             	mov    0x8(%ebp),%ecx
 496:	53                   	push   %ebx
 497:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 49a:	0f b6 01             	movzbl (%ecx),%eax
 49d:	0f b6 13             	movzbl (%ebx),%edx
 4a0:	84 c0                	test   %al,%al
 4a2:	75 18                	jne    4bc <strcmp+0x2c>
 4a4:	eb 22                	jmp    4c8 <strcmp+0x38>
 4a6:	8d 76 00             	lea    0x0(%esi),%esi
 4a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 4b0:	41                   	inc    %ecx
  while(*p && *p == *q)
 4b1:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 4b4:	43                   	inc    %ebx
 4b5:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
 4b8:	84 c0                	test   %al,%al
 4ba:	74 0c                	je     4c8 <strcmp+0x38>
 4bc:	38 d0                	cmp    %dl,%al
 4be:	74 f0                	je     4b0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
 4c0:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 4c1:	29 d0                	sub    %edx,%eax
}
 4c3:	5d                   	pop    %ebp
 4c4:	c3                   	ret    
 4c5:	8d 76 00             	lea    0x0(%esi),%esi
 4c8:	5b                   	pop    %ebx
 4c9:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 4cb:	29 d0                	sub    %edx,%eax
}
 4cd:	5d                   	pop    %ebp
 4ce:	c3                   	ret    
 4cf:	90                   	nop

000004d0 <strlen>:

uint
strlen(const char *s)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 4d6:	80 39 00             	cmpb   $0x0,(%ecx)
 4d9:	74 15                	je     4f0 <strlen+0x20>
 4db:	31 d2                	xor    %edx,%edx
 4dd:	8d 76 00             	lea    0x0(%esi),%esi
 4e0:	42                   	inc    %edx
 4e1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 4e5:	89 d0                	mov    %edx,%eax
 4e7:	75 f7                	jne    4e0 <strlen+0x10>
    ;
  return n;
}
 4e9:	5d                   	pop    %ebp
 4ea:	c3                   	ret    
 4eb:	90                   	nop
 4ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
 4f0:	31 c0                	xor    %eax,%eax
}
 4f2:	5d                   	pop    %ebp
 4f3:	c3                   	ret    
 4f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000500 <memset>:

void*
memset(void *dst, int c, uint n)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	8b 55 08             	mov    0x8(%ebp),%edx
 506:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 507:	8b 4d 10             	mov    0x10(%ebp),%ecx
 50a:	8b 45 0c             	mov    0xc(%ebp),%eax
 50d:	89 d7                	mov    %edx,%edi
 50f:	fc                   	cld    
 510:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 512:	5f                   	pop    %edi
 513:	89 d0                	mov    %edx,%eax
 515:	5d                   	pop    %ebp
 516:	c3                   	ret    
 517:	89 f6                	mov    %esi,%esi
 519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000520 <strchr>:

char*
strchr(const char *s, char c)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	8b 45 08             	mov    0x8(%ebp),%eax
 526:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 52a:	0f b6 10             	movzbl (%eax),%edx
 52d:	84 d2                	test   %dl,%dl
 52f:	74 1b                	je     54c <strchr+0x2c>
    if(*s == c)
 531:	38 d1                	cmp    %dl,%cl
 533:	75 0f                	jne    544 <strchr+0x24>
 535:	eb 17                	jmp    54e <strchr+0x2e>
 537:	89 f6                	mov    %esi,%esi
 539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 540:	38 ca                	cmp    %cl,%dl
 542:	74 0a                	je     54e <strchr+0x2e>
  for(; *s; s++)
 544:	40                   	inc    %eax
 545:	0f b6 10             	movzbl (%eax),%edx
 548:	84 d2                	test   %dl,%dl
 54a:	75 f4                	jne    540 <strchr+0x20>
      return (char*)s;
  return 0;
 54c:	31 c0                	xor    %eax,%eax
}
 54e:	5d                   	pop    %ebp
 54f:	c3                   	ret    

00000550 <gets>:

char*
gets(char *buf, int max)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	57                   	push   %edi
 554:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 555:	31 f6                	xor    %esi,%esi
{
 557:	53                   	push   %ebx
 558:	83 ec 3c             	sub    $0x3c,%esp
 55b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
 55e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 561:	eb 32                	jmp    595 <gets+0x45>
 563:	90                   	nop
 564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 568:	ba 01 00 00 00       	mov    $0x1,%edx
 56d:	89 54 24 08          	mov    %edx,0x8(%esp)
 571:	89 7c 24 04          	mov    %edi,0x4(%esp)
 575:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 57c:	e8 2f 01 00 00       	call   6b0 <read>
    if(cc < 1)
 581:	85 c0                	test   %eax,%eax
 583:	7e 19                	jle    59e <gets+0x4e>
      break;
    buf[i++] = c;
 585:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 589:	43                   	inc    %ebx
 58a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
 58d:	3c 0a                	cmp    $0xa,%al
 58f:	74 1f                	je     5b0 <gets+0x60>
 591:	3c 0d                	cmp    $0xd,%al
 593:	74 1b                	je     5b0 <gets+0x60>
  for(i=0; i+1 < max; ){
 595:	46                   	inc    %esi
 596:	3b 75 0c             	cmp    0xc(%ebp),%esi
 599:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 59c:	7c ca                	jl     568 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 59e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 5a1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 5a4:	8b 45 08             	mov    0x8(%ebp),%eax
 5a7:	83 c4 3c             	add    $0x3c,%esp
 5aa:	5b                   	pop    %ebx
 5ab:	5e                   	pop    %esi
 5ac:	5f                   	pop    %edi
 5ad:	5d                   	pop    %ebp
 5ae:	c3                   	ret    
 5af:	90                   	nop
 5b0:	8b 45 08             	mov    0x8(%ebp),%eax
 5b3:	01 c6                	add    %eax,%esi
 5b5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 5b8:	eb e4                	jmp    59e <gets+0x4e>
 5ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000005c0 <stat>:

int
stat(const char *n, struct stat *st)
{
 5c0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 5c1:	31 c0                	xor    %eax,%eax
{
 5c3:	89 e5                	mov    %esp,%ebp
 5c5:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 5c8:	89 44 24 04          	mov    %eax,0x4(%esp)
 5cc:	8b 45 08             	mov    0x8(%ebp),%eax
{
 5cf:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 5d2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 5d5:	89 04 24             	mov    %eax,(%esp)
 5d8:	e8 fb 00 00 00       	call   6d8 <open>
  if(fd < 0)
 5dd:	85 c0                	test   %eax,%eax
 5df:	78 2f                	js     610 <stat+0x50>
 5e1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 5e3:	8b 45 0c             	mov    0xc(%ebp),%eax
 5e6:	89 1c 24             	mov    %ebx,(%esp)
 5e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ed:	e8 fe 00 00 00       	call   6f0 <fstat>
  close(fd);
 5f2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 5f5:	89 c6                	mov    %eax,%esi
  close(fd);
 5f7:	e8 c4 00 00 00       	call   6c0 <close>
  return r;
}
 5fc:	89 f0                	mov    %esi,%eax
 5fe:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 601:	8b 75 fc             	mov    -0x4(%ebp),%esi
 604:	89 ec                	mov    %ebp,%esp
 606:	5d                   	pop    %ebp
 607:	c3                   	ret    
 608:	90                   	nop
 609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 610:	be ff ff ff ff       	mov    $0xffffffff,%esi
 615:	eb e5                	jmp    5fc <stat+0x3c>
 617:	89 f6                	mov    %esi,%esi
 619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000620 <atoi>:

int
atoi(const char *s)
{
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	8b 4d 08             	mov    0x8(%ebp),%ecx
 626:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 627:	0f be 11             	movsbl (%ecx),%edx
 62a:	88 d0                	mov    %dl,%al
 62c:	2c 30                	sub    $0x30,%al
 62e:	3c 09                	cmp    $0x9,%al
  n = 0;
 630:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 635:	77 1e                	ja     655 <atoi+0x35>
 637:	89 f6                	mov    %esi,%esi
 639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 640:	41                   	inc    %ecx
 641:	8d 04 80             	lea    (%eax,%eax,4),%eax
 644:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 648:	0f be 11             	movsbl (%ecx),%edx
 64b:	88 d3                	mov    %dl,%bl
 64d:	80 eb 30             	sub    $0x30,%bl
 650:	80 fb 09             	cmp    $0x9,%bl
 653:	76 eb                	jbe    640 <atoi+0x20>
  return n;
}
 655:	5b                   	pop    %ebx
 656:	5d                   	pop    %ebp
 657:	c3                   	ret    
 658:	90                   	nop
 659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000660 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 660:	55                   	push   %ebp
 661:	89 e5                	mov    %esp,%ebp
 663:	56                   	push   %esi
 664:	8b 45 08             	mov    0x8(%ebp),%eax
 667:	53                   	push   %ebx
 668:	8b 5d 10             	mov    0x10(%ebp),%ebx
 66b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 66e:	85 db                	test   %ebx,%ebx
 670:	7e 1a                	jle    68c <memmove+0x2c>
 672:	31 d2                	xor    %edx,%edx
 674:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 67a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 680:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 684:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 687:	42                   	inc    %edx
  while(n-- > 0)
 688:	39 d3                	cmp    %edx,%ebx
 68a:	75 f4                	jne    680 <memmove+0x20>
  return vdst;
}
 68c:	5b                   	pop    %ebx
 68d:	5e                   	pop    %esi
 68e:	5d                   	pop    %ebp
 68f:	c3                   	ret    

00000690 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 690:	b8 01 00 00 00       	mov    $0x1,%eax
 695:	cd 40                	int    $0x40
 697:	c3                   	ret    

00000698 <exit>:
SYSCALL(exit)
 698:	b8 02 00 00 00       	mov    $0x2,%eax
 69d:	cd 40                	int    $0x40
 69f:	c3                   	ret    

000006a0 <wait>:
SYSCALL(wait)
 6a0:	b8 03 00 00 00       	mov    $0x3,%eax
 6a5:	cd 40                	int    $0x40
 6a7:	c3                   	ret    

000006a8 <pipe>:
SYSCALL(pipe)
 6a8:	b8 04 00 00 00       	mov    $0x4,%eax
 6ad:	cd 40                	int    $0x40
 6af:	c3                   	ret    

000006b0 <read>:
SYSCALL(read)
 6b0:	b8 05 00 00 00       	mov    $0x5,%eax
 6b5:	cd 40                	int    $0x40
 6b7:	c3                   	ret    

000006b8 <write>:
SYSCALL(write)
 6b8:	b8 10 00 00 00       	mov    $0x10,%eax
 6bd:	cd 40                	int    $0x40
 6bf:	c3                   	ret    

000006c0 <close>:
SYSCALL(close)
 6c0:	b8 15 00 00 00       	mov    $0x15,%eax
 6c5:	cd 40                	int    $0x40
 6c7:	c3                   	ret    

000006c8 <kill>:
SYSCALL(kill)
 6c8:	b8 06 00 00 00       	mov    $0x6,%eax
 6cd:	cd 40                	int    $0x40
 6cf:	c3                   	ret    

000006d0 <exec>:
SYSCALL(exec)
 6d0:	b8 07 00 00 00       	mov    $0x7,%eax
 6d5:	cd 40                	int    $0x40
 6d7:	c3                   	ret    

000006d8 <open>:
SYSCALL(open)
 6d8:	b8 0f 00 00 00       	mov    $0xf,%eax
 6dd:	cd 40                	int    $0x40
 6df:	c3                   	ret    

000006e0 <mknod>:
SYSCALL(mknod)
 6e0:	b8 11 00 00 00       	mov    $0x11,%eax
 6e5:	cd 40                	int    $0x40
 6e7:	c3                   	ret    

000006e8 <unlink>:
SYSCALL(unlink)
 6e8:	b8 12 00 00 00       	mov    $0x12,%eax
 6ed:	cd 40                	int    $0x40
 6ef:	c3                   	ret    

000006f0 <fstat>:
SYSCALL(fstat)
 6f0:	b8 08 00 00 00       	mov    $0x8,%eax
 6f5:	cd 40                	int    $0x40
 6f7:	c3                   	ret    

000006f8 <link>:
SYSCALL(link)
 6f8:	b8 13 00 00 00       	mov    $0x13,%eax
 6fd:	cd 40                	int    $0x40
 6ff:	c3                   	ret    

00000700 <mkdir>:
SYSCALL(mkdir)
 700:	b8 14 00 00 00       	mov    $0x14,%eax
 705:	cd 40                	int    $0x40
 707:	c3                   	ret    

00000708 <chdir>:
SYSCALL(chdir)
 708:	b8 09 00 00 00       	mov    $0x9,%eax
 70d:	cd 40                	int    $0x40
 70f:	c3                   	ret    

00000710 <dup>:
SYSCALL(dup)
 710:	b8 0a 00 00 00       	mov    $0xa,%eax
 715:	cd 40                	int    $0x40
 717:	c3                   	ret    

00000718 <getpid>:
SYSCALL(getpid)
 718:	b8 0b 00 00 00       	mov    $0xb,%eax
 71d:	cd 40                	int    $0x40
 71f:	c3                   	ret    

00000720 <sbrk>:
SYSCALL(sbrk)
 720:	b8 0c 00 00 00       	mov    $0xc,%eax
 725:	cd 40                	int    $0x40
 727:	c3                   	ret    

00000728 <sleep>:
SYSCALL(sleep)
 728:	b8 0d 00 00 00       	mov    $0xd,%eax
 72d:	cd 40                	int    $0x40
 72f:	c3                   	ret    

00000730 <uptime>:
SYSCALL(uptime)
 730:	b8 0e 00 00 00       	mov    $0xe,%eax
 735:	cd 40                	int    $0x40
 737:	c3                   	ret    

00000738 <policy>:
SYSCALL(policy)
 738:	b8 17 00 00 00       	mov    $0x17,%eax
 73d:	cd 40                	int    $0x40
 73f:	c3                   	ret    

00000740 <detach>:
SYSCALL(detach)
 740:	b8 16 00 00 00       	mov    $0x16,%eax
 745:	cd 40                	int    $0x40
 747:	c3                   	ret    

00000748 <priority>:
SYSCALL(priority)
 748:	b8 18 00 00 00       	mov    $0x18,%eax
 74d:	cd 40                	int    $0x40
 74f:	c3                   	ret    

00000750 <wait_stat>:
SYSCALL(wait_stat)
 750:	b8 19 00 00 00       	mov    $0x19,%eax
 755:	cd 40                	int    $0x40
 757:	c3                   	ret    
 758:	66 90                	xchg   %ax,%ax
 75a:	66 90                	xchg   %ax,%ax
 75c:	66 90                	xchg   %ax,%ax
 75e:	66 90                	xchg   %ax,%ax

00000760 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	57                   	push   %edi
 764:	56                   	push   %esi
 765:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 766:	89 d3                	mov    %edx,%ebx
 768:	c1 eb 1f             	shr    $0x1f,%ebx
{
 76b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 76e:	84 db                	test   %bl,%bl
{
 770:	89 45 c0             	mov    %eax,-0x40(%ebp)
 773:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 775:	74 79                	je     7f0 <printint+0x90>
 777:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 77b:	74 73                	je     7f0 <printint+0x90>
    neg = 1;
    x = -xx;
 77d:	f7 d8                	neg    %eax
    neg = 1;
 77f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 786:	31 f6                	xor    %esi,%esi
 788:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 78b:	eb 05                	jmp    792 <printint+0x32>
 78d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 790:	89 fe                	mov    %edi,%esi
 792:	31 d2                	xor    %edx,%edx
 794:	f7 f1                	div    %ecx
 796:	8d 7e 01             	lea    0x1(%esi),%edi
 799:	0f b6 92 b4 0c 00 00 	movzbl 0xcb4(%edx),%edx
  }while((x /= base) != 0);
 7a0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 7a2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 7a5:	75 e9                	jne    790 <printint+0x30>
  if(neg)
 7a7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 7aa:	85 d2                	test   %edx,%edx
 7ac:	74 08                	je     7b6 <printint+0x56>
    buf[i++] = '-';
 7ae:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 7b3:	8d 7e 02             	lea    0x2(%esi),%edi
 7b6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 7ba:	8b 7d c0             	mov    -0x40(%ebp),%edi
 7bd:	8d 76 00             	lea    0x0(%esi),%esi
 7c0:	0f b6 06             	movzbl (%esi),%eax
 7c3:	4e                   	dec    %esi
  write(fd, &c, 1);
 7c4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 7c8:	89 3c 24             	mov    %edi,(%esp)
 7cb:	88 45 d7             	mov    %al,-0x29(%ebp)
 7ce:	b8 01 00 00 00       	mov    $0x1,%eax
 7d3:	89 44 24 08          	mov    %eax,0x8(%esp)
 7d7:	e8 dc fe ff ff       	call   6b8 <write>

  while(--i >= 0)
 7dc:	39 de                	cmp    %ebx,%esi
 7de:	75 e0                	jne    7c0 <printint+0x60>
    putc(fd, buf[i]);
}
 7e0:	83 c4 4c             	add    $0x4c,%esp
 7e3:	5b                   	pop    %ebx
 7e4:	5e                   	pop    %esi
 7e5:	5f                   	pop    %edi
 7e6:	5d                   	pop    %ebp
 7e7:	c3                   	ret    
 7e8:	90                   	nop
 7e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 7f0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 7f7:	eb 8d                	jmp    786 <printint+0x26>
 7f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000800 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 800:	55                   	push   %ebp
 801:	89 e5                	mov    %esp,%ebp
 803:	57                   	push   %edi
 804:	56                   	push   %esi
 805:	53                   	push   %ebx
 806:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 809:	8b 75 0c             	mov    0xc(%ebp),%esi
 80c:	0f b6 1e             	movzbl (%esi),%ebx
 80f:	84 db                	test   %bl,%bl
 811:	0f 84 d1 00 00 00    	je     8e8 <printf+0xe8>
  state = 0;
 817:	31 ff                	xor    %edi,%edi
 819:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 81a:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 81d:	89 fa                	mov    %edi,%edx
 81f:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 822:	89 45 d0             	mov    %eax,-0x30(%ebp)
 825:	eb 41                	jmp    868 <printf+0x68>
 827:	89 f6                	mov    %esi,%esi
 829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 830:	83 f8 25             	cmp    $0x25,%eax
 833:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 836:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 83b:	74 1e                	je     85b <printf+0x5b>
  write(fd, &c, 1);
 83d:	b8 01 00 00 00       	mov    $0x1,%eax
 842:	89 44 24 08          	mov    %eax,0x8(%esp)
 846:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 849:	89 44 24 04          	mov    %eax,0x4(%esp)
 84d:	89 3c 24             	mov    %edi,(%esp)
 850:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 853:	e8 60 fe ff ff       	call   6b8 <write>
 858:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 85b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 85c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 860:	84 db                	test   %bl,%bl
 862:	0f 84 80 00 00 00    	je     8e8 <printf+0xe8>
    if(state == 0){
 868:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 86a:	0f be cb             	movsbl %bl,%ecx
 86d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 870:	74 be                	je     830 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 872:	83 fa 25             	cmp    $0x25,%edx
 875:	75 e4                	jne    85b <printf+0x5b>
      if(c == 'd'){
 877:	83 f8 64             	cmp    $0x64,%eax
 87a:	0f 84 f0 00 00 00    	je     970 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 880:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 886:	83 f9 70             	cmp    $0x70,%ecx
 889:	74 65                	je     8f0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 88b:	83 f8 73             	cmp    $0x73,%eax
 88e:	0f 84 8c 00 00 00    	je     920 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 894:	83 f8 63             	cmp    $0x63,%eax
 897:	0f 84 13 01 00 00    	je     9b0 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 89d:	83 f8 25             	cmp    $0x25,%eax
 8a0:	0f 84 e2 00 00 00    	je     988 <printf+0x188>
  write(fd, &c, 1);
 8a6:	b8 01 00 00 00       	mov    $0x1,%eax
 8ab:	46                   	inc    %esi
 8ac:	89 44 24 08          	mov    %eax,0x8(%esp)
 8b0:	8d 45 e7             	lea    -0x19(%ebp),%eax
 8b3:	89 44 24 04          	mov    %eax,0x4(%esp)
 8b7:	89 3c 24             	mov    %edi,(%esp)
 8ba:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 8be:	e8 f5 fd ff ff       	call   6b8 <write>
 8c3:	ba 01 00 00 00       	mov    $0x1,%edx
 8c8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 8cb:	89 54 24 08          	mov    %edx,0x8(%esp)
 8cf:	89 44 24 04          	mov    %eax,0x4(%esp)
 8d3:	89 3c 24             	mov    %edi,(%esp)
 8d6:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 8d9:	e8 da fd ff ff       	call   6b8 <write>
  for(i = 0; fmt[i]; i++){
 8de:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8e2:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 8e4:	84 db                	test   %bl,%bl
 8e6:	75 80                	jne    868 <printf+0x68>
    }
  }
}
 8e8:	83 c4 3c             	add    $0x3c,%esp
 8eb:	5b                   	pop    %ebx
 8ec:	5e                   	pop    %esi
 8ed:	5f                   	pop    %edi
 8ee:	5d                   	pop    %ebp
 8ef:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 8f0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 8f7:	b9 10 00 00 00       	mov    $0x10,%ecx
 8fc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 8ff:	89 f8                	mov    %edi,%eax
 901:	8b 13                	mov    (%ebx),%edx
 903:	e8 58 fe ff ff       	call   760 <printint>
        ap++;
 908:	89 d8                	mov    %ebx,%eax
      state = 0;
 90a:	31 d2                	xor    %edx,%edx
        ap++;
 90c:	83 c0 04             	add    $0x4,%eax
 90f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 912:	e9 44 ff ff ff       	jmp    85b <printf+0x5b>
 917:	89 f6                	mov    %esi,%esi
 919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 920:	8b 45 d0             	mov    -0x30(%ebp),%eax
 923:	8b 10                	mov    (%eax),%edx
        ap++;
 925:	83 c0 04             	add    $0x4,%eax
 928:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 92b:	85 d2                	test   %edx,%edx
 92d:	0f 84 aa 00 00 00    	je     9dd <printf+0x1dd>
        while(*s != 0){
 933:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 936:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 938:	84 c0                	test   %al,%al
 93a:	74 27                	je     963 <printf+0x163>
 93c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 940:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 943:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 948:	43                   	inc    %ebx
  write(fd, &c, 1);
 949:	89 44 24 08          	mov    %eax,0x8(%esp)
 94d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 950:	89 44 24 04          	mov    %eax,0x4(%esp)
 954:	89 3c 24             	mov    %edi,(%esp)
 957:	e8 5c fd ff ff       	call   6b8 <write>
        while(*s != 0){
 95c:	0f b6 03             	movzbl (%ebx),%eax
 95f:	84 c0                	test   %al,%al
 961:	75 dd                	jne    940 <printf+0x140>
      state = 0;
 963:	31 d2                	xor    %edx,%edx
 965:	e9 f1 fe ff ff       	jmp    85b <printf+0x5b>
 96a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 970:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 977:	b9 0a 00 00 00       	mov    $0xa,%ecx
 97c:	e9 7b ff ff ff       	jmp    8fc <printf+0xfc>
 981:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 988:	b9 01 00 00 00       	mov    $0x1,%ecx
 98d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 990:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 994:	89 44 24 04          	mov    %eax,0x4(%esp)
 998:	89 3c 24             	mov    %edi,(%esp)
 99b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 99e:	e8 15 fd ff ff       	call   6b8 <write>
      state = 0;
 9a3:	31 d2                	xor    %edx,%edx
 9a5:	e9 b1 fe ff ff       	jmp    85b <printf+0x5b>
 9aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 9b0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 9b3:	8b 03                	mov    (%ebx),%eax
        ap++;
 9b5:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 9b8:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 9bb:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 9be:	b8 01 00 00 00       	mov    $0x1,%eax
 9c3:	89 44 24 08          	mov    %eax,0x8(%esp)
 9c7:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 9ca:	89 44 24 04          	mov    %eax,0x4(%esp)
 9ce:	e8 e5 fc ff ff       	call   6b8 <write>
      state = 0;
 9d3:	31 d2                	xor    %edx,%edx
        ap++;
 9d5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 9d8:	e9 7e fe ff ff       	jmp    85b <printf+0x5b>
          s = "(null)";
 9dd:	bb ac 0c 00 00       	mov    $0xcac,%ebx
        while(*s != 0){
 9e2:	b0 28                	mov    $0x28,%al
 9e4:	e9 57 ff ff ff       	jmp    940 <printf+0x140>
 9e9:	66 90                	xchg   %ax,%ax
 9eb:	66 90                	xchg   %ax,%ax
 9ed:	66 90                	xchg   %ax,%ax
 9ef:	90                   	nop

000009f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9f1:	a1 b0 0f 00 00       	mov    0xfb0,%eax
{
 9f6:	89 e5                	mov    %esp,%ebp
 9f8:	57                   	push   %edi
 9f9:	56                   	push   %esi
 9fa:	53                   	push   %ebx
 9fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 9fe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 a01:	eb 0d                	jmp    a10 <free+0x20>
 a03:	90                   	nop
 a04:	90                   	nop
 a05:	90                   	nop
 a06:	90                   	nop
 a07:	90                   	nop
 a08:	90                   	nop
 a09:	90                   	nop
 a0a:	90                   	nop
 a0b:	90                   	nop
 a0c:	90                   	nop
 a0d:	90                   	nop
 a0e:	90                   	nop
 a0f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a10:	39 c8                	cmp    %ecx,%eax
 a12:	8b 10                	mov    (%eax),%edx
 a14:	73 32                	jae    a48 <free+0x58>
 a16:	39 d1                	cmp    %edx,%ecx
 a18:	72 04                	jb     a1e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a1a:	39 d0                	cmp    %edx,%eax
 a1c:	72 32                	jb     a50 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a1e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a21:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a24:	39 fa                	cmp    %edi,%edx
 a26:	74 30                	je     a58 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 a28:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 a2b:	8b 50 04             	mov    0x4(%eax),%edx
 a2e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a31:	39 f1                	cmp    %esi,%ecx
 a33:	74 3c                	je     a71 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 a35:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 a37:	5b                   	pop    %ebx
  freep = p;
 a38:	a3 b0 0f 00 00       	mov    %eax,0xfb0
}
 a3d:	5e                   	pop    %esi
 a3e:	5f                   	pop    %edi
 a3f:	5d                   	pop    %ebp
 a40:	c3                   	ret    
 a41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a48:	39 d0                	cmp    %edx,%eax
 a4a:	72 04                	jb     a50 <free+0x60>
 a4c:	39 d1                	cmp    %edx,%ecx
 a4e:	72 ce                	jb     a1e <free+0x2e>
{
 a50:	89 d0                	mov    %edx,%eax
 a52:	eb bc                	jmp    a10 <free+0x20>
 a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 a58:	8b 7a 04             	mov    0x4(%edx),%edi
 a5b:	01 fe                	add    %edi,%esi
 a5d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 a60:	8b 10                	mov    (%eax),%edx
 a62:	8b 12                	mov    (%edx),%edx
 a64:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 a67:	8b 50 04             	mov    0x4(%eax),%edx
 a6a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a6d:	39 f1                	cmp    %esi,%ecx
 a6f:	75 c4                	jne    a35 <free+0x45>
    p->s.size += bp->s.size;
 a71:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 a74:	a3 b0 0f 00 00       	mov    %eax,0xfb0
    p->s.size += bp->s.size;
 a79:	01 ca                	add    %ecx,%edx
 a7b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 a7e:	8b 53 f8             	mov    -0x8(%ebx),%edx
 a81:	89 10                	mov    %edx,(%eax)
}
 a83:	5b                   	pop    %ebx
 a84:	5e                   	pop    %esi
 a85:	5f                   	pop    %edi
 a86:	5d                   	pop    %ebp
 a87:	c3                   	ret    
 a88:	90                   	nop
 a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000a90 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a90:	55                   	push   %ebp
 a91:	89 e5                	mov    %esp,%ebp
 a93:	57                   	push   %edi
 a94:	56                   	push   %esi
 a95:	53                   	push   %ebx
 a96:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a99:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 a9c:	8b 15 b0 0f 00 00    	mov    0xfb0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 aa2:	8d 78 07             	lea    0x7(%eax),%edi
 aa5:	c1 ef 03             	shr    $0x3,%edi
 aa8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 aa9:	85 d2                	test   %edx,%edx
 aab:	0f 84 8f 00 00 00    	je     b40 <malloc+0xb0>
 ab1:	8b 02                	mov    (%edx),%eax
 ab3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 ab6:	39 cf                	cmp    %ecx,%edi
 ab8:	76 66                	jbe    b20 <malloc+0x90>
 aba:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 ac0:	bb 00 10 00 00       	mov    $0x1000,%ebx
 ac5:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 ac8:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 acf:	eb 10                	jmp    ae1 <malloc+0x51>
 ad1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ad8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 ada:	8b 48 04             	mov    0x4(%eax),%ecx
 add:	39 f9                	cmp    %edi,%ecx
 adf:	73 3f                	jae    b20 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ae1:	39 05 b0 0f 00 00    	cmp    %eax,0xfb0
 ae7:	89 c2                	mov    %eax,%edx
 ae9:	75 ed                	jne    ad8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 aeb:	89 34 24             	mov    %esi,(%esp)
 aee:	e8 2d fc ff ff       	call   720 <sbrk>
  if(p == (char*)-1)
 af3:	83 f8 ff             	cmp    $0xffffffff,%eax
 af6:	74 18                	je     b10 <malloc+0x80>
  hp->s.size = nu;
 af8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 afb:	83 c0 08             	add    $0x8,%eax
 afe:	89 04 24             	mov    %eax,(%esp)
 b01:	e8 ea fe ff ff       	call   9f0 <free>
  return freep;
 b06:	8b 15 b0 0f 00 00    	mov    0xfb0,%edx
      if((p = morecore(nunits)) == 0)
 b0c:	85 d2                	test   %edx,%edx
 b0e:	75 c8                	jne    ad8 <malloc+0x48>
        return 0;
  }
}
 b10:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 b13:	31 c0                	xor    %eax,%eax
}
 b15:	5b                   	pop    %ebx
 b16:	5e                   	pop    %esi
 b17:	5f                   	pop    %edi
 b18:	5d                   	pop    %ebp
 b19:	c3                   	ret    
 b1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 b20:	39 cf                	cmp    %ecx,%edi
 b22:	74 4c                	je     b70 <malloc+0xe0>
        p->s.size -= nunits;
 b24:	29 f9                	sub    %edi,%ecx
 b26:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 b29:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 b2c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 b2f:	89 15 b0 0f 00 00    	mov    %edx,0xfb0
}
 b35:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 b38:	83 c0 08             	add    $0x8,%eax
}
 b3b:	5b                   	pop    %ebx
 b3c:	5e                   	pop    %esi
 b3d:	5f                   	pop    %edi
 b3e:	5d                   	pop    %ebp
 b3f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 b40:	b8 b4 0f 00 00       	mov    $0xfb4,%eax
 b45:	ba b4 0f 00 00       	mov    $0xfb4,%edx
    base.s.size = 0;
 b4a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 b4c:	a3 b0 0f 00 00       	mov    %eax,0xfb0
    base.s.size = 0;
 b51:	b8 b4 0f 00 00       	mov    $0xfb4,%eax
    base.s.ptr = freep = prevp = &base;
 b56:	89 15 b4 0f 00 00    	mov    %edx,0xfb4
    base.s.size = 0;
 b5c:	89 0d b8 0f 00 00    	mov    %ecx,0xfb8
 b62:	e9 53 ff ff ff       	jmp    aba <malloc+0x2a>
 b67:	89 f6                	mov    %esi,%esi
 b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 b70:	8b 08                	mov    (%eax),%ecx
 b72:	89 0a                	mov    %ecx,(%edx)
 b74:	eb b9                	jmp    b2f <malloc+0x9f>
