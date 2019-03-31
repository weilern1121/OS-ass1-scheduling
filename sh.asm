
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    return 0;
}

int
main(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 e4 f0             	and    $0xfffffff0,%esp
       6:	83 ec 10             	sub    $0x10,%esp
    static char buf[500];
    //char* buf = (char*)malloc(8000);
    int fd;

    // Ensure that three file descriptors are open.
    while((fd = open("console", O_RDWR)) >= 0){
       9:	eb 0e                	jmp    19 <main+0x19>
       b:	90                   	nop
       c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(fd >= 3){
      10:	83 f8 02             	cmp    $0x2,%eax
      13:	0f 8f 87 00 00 00    	jg     a0 <main+0xa0>
    while((fd = open("console", O_RDWR)) >= 0){
      19:	ba 02 00 00 00       	mov    $0x2,%edx
      1e:	89 54 24 04          	mov    %edx,0x4(%esp)
      22:	c7 04 24 3e 16 00 00 	movl   $0x163e,(%esp)
      29:	e8 ca 10 00 00       	call   10f8 <open>
      2e:	85 c0                	test   %eax,%eax
      30:	79 de                	jns    10 <main+0x10>
      32:	eb 2b                	jmp    5f <main+0x5f>
      34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi



    // Read and run input commands.
    while(getcmd(buf, sizeof(buf)) >= 0){
        if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      38:	80 3d e2 1c 00 00 20 	cmpb   $0x20,0x1ce2
      3f:	0f 84 85 00 00 00    	je     ca <main+0xca>
int
fork1(void)
{
    int pid;

    pid = fork();
      45:	e8 66 10 00 00       	call   10b0 <fork>
    if(pid == -1)
      4a:	83 f8 ff             	cmp    $0xffffffff,%eax
      4d:	74 45                	je     94 <main+0x94>
        if(fork1() == 0)
      4f:	85 c0                	test   %eax,%eax
      51:	74 63                	je     b6 <main+0xb6>
        wait(0);
      53:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      5a:	e8 61 10 00 00       	call   10c0 <wait>
    while(getcmd(buf, sizeof(buf)) >= 0){
      5f:	b8 f4 01 00 00       	mov    $0x1f4,%eax
      64:	89 44 24 04          	mov    %eax,0x4(%esp)
      68:	c7 04 24 e0 1c 00 00 	movl   $0x1ce0,(%esp)
      6f:	e8 5c 01 00 00       	call   1d0 <getcmd>
      74:	85 c0                	test   %eax,%eax
      76:	78 32                	js     aa <main+0xaa>
        if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      78:	80 3d e0 1c 00 00 63 	cmpb   $0x63,0x1ce0
      7f:	75 c4                	jne    45 <main+0x45>
      81:	80 3d e1 1c 00 00 64 	cmpb   $0x64,0x1ce1
      88:	74 ae                	je     38 <main+0x38>
    pid = fork();
      8a:	e8 21 10 00 00       	call   10b0 <fork>
    if(pid == -1)
      8f:	83 f8 ff             	cmp    $0xffffffff,%eax
      92:	75 bb                	jne    4f <main+0x4f>
        panic("fork");
      94:	c7 04 24 c7 15 00 00 	movl   $0x15c7,(%esp)
      9b:	e8 90 01 00 00       	call   230 <panic>
            close(fd);
      a0:	89 04 24             	mov    %eax,(%esp)
      a3:	e8 38 10 00 00       	call   10e0 <close>
            break;
      a8:	eb b5                	jmp    5f <main+0x5f>
    exit(0);
      aa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      b1:	e8 02 10 00 00       	call   10b8 <exit>
            runcmd(parsecmd(buf));
      b6:	c7 04 24 e0 1c 00 00 	movl   $0x1ce0,(%esp)
      bd:	e8 4e 0d 00 00       	call   e10 <parsecmd>
      c2:	89 04 24             	mov    %eax,(%esp)
      c5:	e8 96 01 00 00       	call   260 <runcmd>
            buf[strlen(buf)-1] = 0;  // chop \n
      ca:	c7 04 24 e0 1c 00 00 	movl   $0x1ce0,(%esp)
      d1:	e8 1a 0e 00 00       	call   ef0 <strlen>
            if(chdir(buf+3) < 0)
      d6:	c7 04 24 e3 1c 00 00 	movl   $0x1ce3,(%esp)
            buf[strlen(buf)-1] = 0;  // chop \n
      dd:	c6 80 df 1c 00 00 00 	movb   $0x0,0x1cdf(%eax)
            if(chdir(buf+3) < 0)
      e4:	e8 3f 10 00 00       	call   1128 <chdir>
      e9:	85 c0                	test   %eax,%eax
      eb:	0f 89 6e ff ff ff    	jns    5f <main+0x5f>
                printf(2, "cannot cd %s\n", buf+3);
      f1:	c7 44 24 08 e3 1c 00 	movl   $0x1ce3,0x8(%esp)
      f8:	00 
      f9:	c7 44 24 04 46 16 00 	movl   $0x1646,0x4(%esp)
     100:	00 
     101:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     108:	e8 13 11 00 00       	call   1220 <printf>
     10d:	e9 4d ff ff ff       	jmp    5f <main+0x5f>
     112:	66 90                	xchg   %ax,%ax
     114:	66 90                	xchg   %ax,%ax
     116:	66 90                	xchg   %ax,%ax
     118:	66 90                	xchg   %ax,%ax
     11a:	66 90                	xchg   %ax,%ax
     11c:	66 90                	xchg   %ax,%ax
     11e:	66 90                	xchg   %ax,%ax

00000120 <strconcat>:
strconcat (const char *first, const char *second, char* dest){
     120:	55                   	push   %ebp
     121:	89 e5                	mov    %esp,%ebp
     123:	56                   	push   %esi
     124:	8b 75 10             	mov    0x10(%ebp),%esi
     127:	53                   	push   %ebx
     128:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     12b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    while((*dest++ = *first++) != 0)
     12e:	89 f2                	mov    %esi,%edx
     130:	43                   	inc    %ebx
     131:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
     135:	42                   	inc    %edx
     136:	84 c0                	test   %al,%al
     138:	88 42 ff             	mov    %al,-0x1(%edx)
     13b:	75 f3                	jne    130 <strconcat+0x10>
    while((*dest++ = *second++) != 0)
     13d:	41                   	inc    %ecx
     13e:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
     142:	84 c0                	test   %al,%al
     144:	88 42 ff             	mov    %al,-0x1(%edx)
     147:	74 14                	je     15d <strconcat+0x3d>
     149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     150:	41                   	inc    %ecx
     151:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
     155:	42                   	inc    %edx
     156:	84 c0                	test   %al,%al
     158:	88 42 ff             	mov    %al,-0x1(%edx)
     15b:	75 f3                	jne    150 <strconcat+0x30>
}
     15d:	5b                   	pop    %ebx
     15e:	89 f0                	mov    %esi,%eax
     160:	5e                   	pop    %esi
     161:	5d                   	pop    %ebp
     162:	c3                   	ret    
     163:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000170 <strcpyuntildelimiter>:
{
     170:	55                   	push   %ebp
     171:	89 e5                	mov    %esp,%ebp
     173:	8b 55 0c             	mov    0xc(%ebp),%edx
     176:	56                   	push   %esi
     177:	0f b6 45 10          	movzbl 0x10(%ebp),%eax
     17b:	53                   	push   %ebx
     17c:	8b 75 08             	mov    0x8(%ebp),%esi
    while((*s = *t) != delim && (*s = *t) !=0)
     17f:	0f b6 0a             	movzbl (%edx),%ecx
     182:	38 c8                	cmp    %cl,%al
     184:	88 0e                	mov    %cl,(%esi)
     186:	74 30                	je     1b8 <strcpyuntildelimiter+0x48>
     188:	0f b6 0a             	movzbl (%edx),%ecx
     18b:	84 c9                	test   %cl,%cl
     18d:	88 0e                	mov    %cl,(%esi)
     18f:	74 27                	je     1b8 <strcpyuntildelimiter+0x48>
     191:	89 f1                	mov    %esi,%ecx
     193:	eb 0c                	jmp    1a1 <strcpyuntildelimiter+0x31>
     195:	8d 76 00             	lea    0x0(%esi),%esi
     198:	0f b6 1a             	movzbl (%edx),%ebx
     19b:	84 db                	test   %bl,%bl
     19d:	88 19                	mov    %bl,(%ecx)
     19f:	74 0b                	je     1ac <strcpyuntildelimiter+0x3c>
        s++,t++;
     1a1:	42                   	inc    %edx
    while((*s = *t) != delim && (*s = *t) !=0)
     1a2:	0f b6 1a             	movzbl (%edx),%ebx
        s++,t++;
     1a5:	41                   	inc    %ecx
    while((*s = *t) != delim && (*s = *t) !=0)
     1a6:	38 c3                	cmp    %al,%bl
     1a8:	88 19                	mov    %bl,(%ecx)
     1aa:	75 ec                	jne    198 <strcpyuntildelimiter+0x28>
    *s='\0';
     1ac:	c6 01 00             	movb   $0x0,(%ecx)
}
     1af:	89 f0                	mov    %esi,%eax
     1b1:	5b                   	pop    %ebx
     1b2:	5e                   	pop    %esi
     1b3:	5d                   	pop    %ebp
     1b4:	c3                   	ret    
     1b5:	8d 76 00             	lea    0x0(%esi),%esi
    while((*s = *t) != delim && (*s = *t) !=0)
     1b8:	89 f1                	mov    %esi,%ecx
}
     1ba:	89 f0                	mov    %esi,%eax
    *s='\0';
     1bc:	c6 01 00             	movb   $0x0,(%ecx)
}
     1bf:	5b                   	pop    %ebx
     1c0:	5e                   	pop    %esi
     1c1:	5d                   	pop    %ebp
     1c2:	c3                   	ret    
     1c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001d0 <getcmd>:
{
     1d0:	55                   	push   %ebp
    printf(2, "$ ");
     1d1:	b8 98 15 00 00       	mov    $0x1598,%eax
{
     1d6:	89 e5                	mov    %esp,%ebp
     1d8:	83 ec 18             	sub    $0x18,%esp
     1db:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     1de:	8b 5d 08             	mov    0x8(%ebp),%ebx
     1e1:	89 75 fc             	mov    %esi,-0x4(%ebp)
     1e4:	8b 75 0c             	mov    0xc(%ebp),%esi
    printf(2, "$ ");
     1e7:	89 44 24 04          	mov    %eax,0x4(%esp)
     1eb:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     1f2:	e8 29 10 00 00       	call   1220 <printf>
    memset(buf, 0, nbuf);
     1f7:	31 d2                	xor    %edx,%edx
     1f9:	89 74 24 08          	mov    %esi,0x8(%esp)
     1fd:	89 54 24 04          	mov    %edx,0x4(%esp)
     201:	89 1c 24             	mov    %ebx,(%esp)
     204:	e8 17 0d 00 00       	call   f20 <memset>
    gets(buf, nbuf);
     209:	89 74 24 04          	mov    %esi,0x4(%esp)
     20d:	89 1c 24             	mov    %ebx,(%esp)
     210:	e8 5b 0d 00 00       	call   f70 <gets>
    if(buf[0] == 0) // EOF
     215:	31 c0                	xor    %eax,%eax
}
     217:	8b 75 fc             	mov    -0x4(%ebp),%esi
    if(buf[0] == 0) // EOF
     21a:	80 3b 00             	cmpb   $0x0,(%ebx)
}
     21d:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    if(buf[0] == 0) // EOF
     220:	0f 94 c0             	sete   %al
}
     223:	89 ec                	mov    %ebp,%esp
    if(buf[0] == 0) // EOF
     225:	f7 d8                	neg    %eax
}
     227:	5d                   	pop    %ebp
     228:	c3                   	ret    
     229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000230 <panic>:
{
     230:	55                   	push   %ebp
     231:	89 e5                	mov    %esp,%ebp
     233:	83 ec 18             	sub    $0x18,%esp
    printf(2, "%s\n", s);
     236:	8b 45 08             	mov    0x8(%ebp),%eax
     239:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     240:	89 44 24 08          	mov    %eax,0x8(%esp)
     244:	b8 3a 16 00 00       	mov    $0x163a,%eax
     249:	89 44 24 04          	mov    %eax,0x4(%esp)
     24d:	e8 ce 0f 00 00       	call   1220 <printf>
    exit(0);
     252:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     259:	e8 5a 0e 00 00       	call   10b8 <exit>
     25e:	66 90                	xchg   %ax,%ax

00000260 <runcmd>:
{
     260:	55                   	push   %ebp
    if((fd2 = open("path", O_RDWR)) >= 0){
     261:	b8 02 00 00 00       	mov    $0x2,%eax
{
     266:	89 e5                	mov    %esp,%ebp
     268:	57                   	push   %edi
     269:	56                   	push   %esi
     26a:	53                   	push   %ebx
     26b:	83 ec 3c             	sub    $0x3c,%esp
    if((fd2 = open("path", O_RDWR)) >= 0){
     26e:	89 44 24 04          	mov    %eax,0x4(%esp)
{
     272:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if((fd2 = open("path", O_RDWR)) >= 0){
     275:	c7 04 24 9b 15 00 00 	movl   $0x159b,(%esp)
     27c:	e8 77 0e 00 00       	call   10f8 <open>
     281:	85 c0                	test   %eax,%eax
     283:	79 62                	jns    2e7 <runcmd+0x87>
    if(cmd == 0)
     285:	85 db                	test   %ebx,%ebx
     287:	74 52                	je     2db <runcmd+0x7b>
    switch(cmd->type){
     289:	83 3b 05             	cmpl   $0x5,(%ebx)
     28c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     290:	0f 87 80 02 00 00    	ja     516 <runcmd+0x2b6>
     296:	8b 03                	mov    (%ebx),%eax
     298:	ff 24 85 78 16 00 00 	jmp    *0x1678(,%eax,4)
            close(rcmd->fd);
     29f:	8b 43 14             	mov    0x14(%ebx),%eax
     2a2:	89 04 24             	mov    %eax,(%esp)
     2a5:	e8 36 0e 00 00       	call   10e0 <close>
            if(open(rcmd->file, rcmd->mode) < 0){
     2aa:	8b 43 10             	mov    0x10(%ebx),%eax
     2ad:	89 44 24 04          	mov    %eax,0x4(%esp)
     2b1:	8b 43 08             	mov    0x8(%ebx),%eax
     2b4:	89 04 24             	mov    %eax,(%esp)
     2b7:	e8 3c 0e 00 00       	call   10f8 <open>
     2bc:	85 c0                	test   %eax,%eax
     2be:	79 75                	jns    335 <runcmd+0xd5>
                printf(2, "open %s failed\n", rcmd->file);
     2c0:	8b 43 08             	mov    0x8(%ebx),%eax
     2c3:	c7 44 24 04 b7 15 00 	movl   $0x15b7,0x4(%esp)
     2ca:	00 
     2cb:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     2d2:	89 44 24 08          	mov    %eax,0x8(%esp)
     2d6:	e8 45 0f 00 00       	call   1220 <printf>
                exit(0);
     2db:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     2e2:	e8 d1 0d 00 00       	call   10b8 <exit>
        if( read(fd2, PATH, sizeof(PATH)) < 0 ){
     2e7:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
     2ee:	00 
     2ef:	c7 44 24 04 e0 1e 00 	movl   $0x1ee0,0x4(%esp)
     2f6:	00 
     2f7:	89 04 24             	mov    %eax,(%esp)
     2fa:	e8 d1 0d 00 00       	call   10d0 <read>
     2ff:	85 c0                	test   %eax,%eax
     301:	79 82                	jns    285 <runcmd+0x25>
            printf(1, "error: read from path file failed\n");
     303:	c7 44 24 04 54 16 00 	movl   $0x1654,0x4(%esp)
     30a:	00 
     30b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     312:	e8 09 0f 00 00       	call   1220 <printf>
            exit(0);
     317:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     31e:	e8 95 0d 00 00       	call   10b8 <exit>
    pid = fork();
     323:	e8 88 0d 00 00       	call   10b0 <fork>
    if(pid == -1)
     328:	83 f8 ff             	cmp    $0xffffffff,%eax
     32b:	0f 84 f1 01 00 00    	je     522 <runcmd+0x2c2>
            if(fork1() == 0)
     331:	85 c0                	test   %eax,%eax
     333:	75 a6                	jne    2db <runcmd+0x7b>
                runcmd(bcmd->cmd);
     335:	8b 43 04             	mov    0x4(%ebx),%eax
     338:	89 04 24             	mov    %eax,(%esp)
     33b:	e8 20 ff ff ff       	call   260 <runcmd>
            if(ecmd->argv[0] == 0)
     340:	8b 43 04             	mov    0x4(%ebx),%eax
     343:	85 c0                	test   %eax,%eax
     345:	74 94                	je     2db <runcmd+0x7b>
            exec(ecmd->argv[0], ecmd->argv);
     347:	8d 73 04             	lea    0x4(%ebx),%esi
     34a:	89 74 24 04          	mov    %esi,0x4(%esp)
     34e:	89 04 24             	mov    %eax,(%esp)
     351:	89 75 d0             	mov    %esi,-0x30(%ebp)
     354:	e8 97 0d 00 00       	call   10f0 <exec>
            char *curr_path = malloc(strlen(PATH));
     359:	c7 04 24 e0 1e 00 00 	movl   $0x1ee0,(%esp)
     360:	e8 8b 0b 00 00       	call   ef0 <strlen>
     365:	89 04 24             	mov    %eax,(%esp)
     368:	e8 43 11 00 00       	call   14b0 <malloc>
     36d:	89 c7                	mov    %eax,%edi
            char* path=ecmd->argv[0];
     36f:	8b 43 04             	mov    0x4(%ebx),%eax
            strcpy( curr_path , PATH );
     372:	c7 44 24 04 e0 1e 00 	movl   $0x1ee0,0x4(%esp)
     379:	00 
     37a:	89 3c 24             	mov    %edi,(%esp)
            char* path=ecmd->argv[0];
     37d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
            strcpy( curr_path , PATH );
     380:	e8 0b 0b 00 00       	call   e90 <strcpy>
     385:	89 5d 08             	mov    %ebx,0x8(%ebp)
            while( curr_path != NULL )
     388:	85 ff                	test   %edi,%edi
     38a:	0f 84 9e 01 00 00    	je     52e <runcmd+0x2ce>
                char* str2= malloc(strlen(PATH));
     390:	c7 04 24 e0 1e 00 00 	movl   $0x1ee0,(%esp)
     397:	e8 54 0b 00 00       	call   ef0 <strlen>
     39c:	89 04 24             	mov    %eax,(%esp)
     39f:	e8 0c 11 00 00       	call   14b0 <malloc>
     3a4:	89 c3                	mov    %eax,%ebx
    while((*s = *t) != delim && (*s = *t) !=0)
     3a6:	0f b6 07             	movzbl (%edi),%eax
     3a9:	3c 3a                	cmp    $0x3a,%al
     3ab:	88 03                	mov    %al,(%ebx)
     3ad:	0f 84 aa 01 00 00    	je     55d <runcmd+0x2fd>
     3b3:	0f b6 07             	movzbl (%edi),%eax
     3b6:	84 c0                	test   %al,%al
     3b8:	88 03                	mov    %al,(%ebx)
     3ba:	0f 84 9d 01 00 00    	je     55d <runcmd+0x2fd>
     3c0:	89 f9                	mov    %edi,%ecx
     3c2:	89 d8                	mov    %ebx,%eax
     3c4:	eb 13                	jmp    3d9 <runcmd+0x179>
     3c6:	8d 76 00             	lea    0x0(%esi),%esi
     3c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     3d0:	0f b6 11             	movzbl (%ecx),%edx
     3d3:	84 d2                	test   %dl,%dl
     3d5:	88 10                	mov    %dl,(%eax)
     3d7:	74 0c                	je     3e5 <runcmd+0x185>
        s++,t++;
     3d9:	41                   	inc    %ecx
    while((*s = *t) != delim && (*s = *t) !=0)
     3da:	0f b6 11             	movzbl (%ecx),%edx
        s++,t++;
     3dd:	40                   	inc    %eax
    while((*s = *t) != delim && (*s = *t) !=0)
     3de:	80 fa 3a             	cmp    $0x3a,%dl
     3e1:	88 10                	mov    %dl,(%eax)
     3e3:	75 eb                	jne    3d0 <runcmd+0x170>
    *s='\0';
     3e5:	c6 00 00             	movb   $0x0,(%eax)
                curr_path=strchr(curr_path,':');
     3e8:	89 3c 24             	mov    %edi,(%esp)
     3eb:	c7 44 24 04 3a 00 00 	movl   $0x3a,0x4(%esp)
     3f2:	00 
     3f3:	e8 48 0b 00 00       	call   f40 <strchr>
                if(curr_path!=NULL)
     3f8:	85 c0                	test   %eax,%eax
                curr_path=strchr(curr_path,':');
     3fa:	89 c7                	mov    %eax,%edi
                if(curr_path!=NULL)
     3fc:	74 01                	je     3ff <runcmd+0x19f>
                    curr_path++;
     3fe:	47                   	inc    %edi
                char* str3=malloc ((strlen(str2) + strlen(path) + 1));
     3ff:	89 1c 24             	mov    %ebx,(%esp)
     402:	e8 e9 0a 00 00       	call   ef0 <strlen>
     407:	89 c6                	mov    %eax,%esi
     409:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     40c:	89 04 24             	mov    %eax,(%esp)
     40f:	e8 dc 0a 00 00       	call   ef0 <strlen>
     414:	8d 44 06 01          	lea    0x1(%esi,%eax,1),%eax
     418:	89 04 24             	mov    %eax,(%esp)
     41b:	e8 90 10 00 00       	call   14b0 <malloc>
     420:	89 d9                	mov    %ebx,%ecx
     422:	89 c6                	mov    %eax,%esi
     424:	89 c2                	mov    %eax,%edx
     426:	8d 76 00             	lea    0x0(%esi),%esi
     429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    while((*dest++ = *first++) != 0)
     430:	41                   	inc    %ecx
     431:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
     435:	42                   	inc    %edx
     436:	84 c0                	test   %al,%al
     438:	88 42 ff             	mov    %al,-0x1(%edx)
     43b:	75 f3                	jne    430 <runcmd+0x1d0>
     43d:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     440:	eb 07                	jmp    449 <runcmd+0x1e9>
     442:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     448:	42                   	inc    %edx
    while((*dest++ = *second++) != 0)
     449:	41                   	inc    %ecx
     44a:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
     44e:	84 c0                	test   %al,%al
     450:	88 42 ff             	mov    %al,-0x1(%edx)
     453:	75 f3                	jne    448 <runcmd+0x1e8>
                ecmd->argv[0]=str3;
     455:	8b 45 08             	mov    0x8(%ebp),%eax
     458:	89 70 04             	mov    %esi,0x4(%eax)
                exec( ecmd->argv[0] , ecmd->argv );
     45b:	8b 45 d0             	mov    -0x30(%ebp),%eax
     45e:	89 34 24             	mov    %esi,(%esp)
     461:	89 44 24 04          	mov    %eax,0x4(%esp)
     465:	e8 86 0c 00 00       	call   10f0 <exec>
                free(str2);
     46a:	89 1c 24             	mov    %ebx,(%esp)
     46d:	e8 9e 0f 00 00       	call   1410 <free>
                free(str3);
     472:	89 34 24             	mov    %esi,(%esp)
     475:	e8 96 0f 00 00       	call   1410 <free>
     47a:	e9 09 ff ff ff       	jmp    388 <runcmd+0x128>
            if(pipe(p) < 0)
     47f:	8d 45 e0             	lea    -0x20(%ebp),%eax
     482:	89 04 24             	mov    %eax,(%esp)
     485:	e8 3e 0c 00 00       	call   10c8 <pipe>
     48a:	85 c0                	test   %eax,%eax
     48c:	0f 88 0a 01 00 00    	js     59c <runcmd+0x33c>
    pid = fork();
     492:	e8 19 0c 00 00       	call   10b0 <fork>
    if(pid == -1)
     497:	83 f8 ff             	cmp    $0xffffffff,%eax
     49a:	0f 84 82 00 00 00    	je     522 <runcmd+0x2c2>
            if(fork1() == 0){
     4a0:	85 c0                	test   %eax,%eax
     4a2:	0f 84 00 01 00 00    	je     5a8 <runcmd+0x348>
    pid = fork();
     4a8:	e8 03 0c 00 00       	call   10b0 <fork>
    if(pid == -1)
     4ad:	83 f8 ff             	cmp    $0xffffffff,%eax
     4b0:	74 70                	je     522 <runcmd+0x2c2>
            if(fork1() == 0){
     4b2:	85 c0                	test   %eax,%eax
     4b4:	0f 84 aa 00 00 00    	je     564 <runcmd+0x304>
            close(p[0]);
     4ba:	8b 45 e0             	mov    -0x20(%ebp),%eax
     4bd:	89 04 24             	mov    %eax,(%esp)
     4c0:	e8 1b 0c 00 00       	call   10e0 <close>
            close(p[1]);
     4c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4c8:	89 04 24             	mov    %eax,(%esp)
     4cb:	e8 10 0c 00 00       	call   10e0 <close>
            wait(0);
     4d0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     4d7:	e8 e4 0b 00 00       	call   10c0 <wait>
            wait(0);
     4dc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     4e3:	e8 d8 0b 00 00       	call   10c0 <wait>
            break;
     4e8:	e9 ee fd ff ff       	jmp    2db <runcmd+0x7b>
    pid = fork();
     4ed:	e8 be 0b 00 00       	call   10b0 <fork>
    if(pid == -1)
     4f2:	83 f8 ff             	cmp    $0xffffffff,%eax
     4f5:	74 2b                	je     522 <runcmd+0x2c2>
            if(fork1() == 0)
     4f7:	85 c0                	test   %eax,%eax
     4f9:	0f 84 36 fe ff ff    	je     335 <runcmd+0xd5>
            wait(0);
     4ff:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     506:	e8 b5 0b 00 00       	call   10c0 <wait>
            runcmd(lcmd->right);
     50b:	8b 43 08             	mov    0x8(%ebx),%eax
     50e:	89 04 24             	mov    %eax,(%esp)
     511:	e8 4a fd ff ff       	call   260 <runcmd>
            panic("runcmd");
     516:	c7 04 24 a0 15 00 00 	movl   $0x15a0,(%esp)
     51d:	e8 0e fd ff ff       	call   230 <panic>
        panic("fork");
     522:	c7 04 24 c7 15 00 00 	movl   $0x15c7,(%esp)
     529:	e8 02 fd ff ff       	call   230 <panic>
     52e:	8b 5d 08             	mov    0x8(%ebp),%ebx
            free(curr_path);
     531:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     538:	e8 d3 0e 00 00       	call   1410 <free>
            printf(2, "exec %s failed\n", ecmd->argv[0]);
     53d:	8b 43 04             	mov    0x4(%ebx),%eax
     540:	c7 44 24 04 a7 15 00 	movl   $0x15a7,0x4(%esp)
     547:	00 
     548:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     54f:	89 44 24 08          	mov    %eax,0x8(%esp)
     553:	e8 c8 0c 00 00       	call   1220 <printf>
            break;
     558:	e9 7e fd ff ff       	jmp    2db <runcmd+0x7b>
    while((*s = *t) != delim && (*s = *t) !=0)
     55d:	89 d8                	mov    %ebx,%eax
     55f:	e9 81 fe ff ff       	jmp    3e5 <runcmd+0x185>
                close(0);
     564:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     56b:	e8 70 0b 00 00       	call   10e0 <close>
                dup(p[0]);
     570:	8b 45 e0             	mov    -0x20(%ebp),%eax
     573:	89 04 24             	mov    %eax,(%esp)
     576:	e8 b5 0b 00 00       	call   1130 <dup>
                close(p[0]);
     57b:	8b 45 e0             	mov    -0x20(%ebp),%eax
     57e:	89 04 24             	mov    %eax,(%esp)
     581:	e8 5a 0b 00 00       	call   10e0 <close>
                close(p[1]);
     586:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     589:	89 04 24             	mov    %eax,(%esp)
     58c:	e8 4f 0b 00 00       	call   10e0 <close>
                runcmd(pcmd->right);
     591:	8b 43 08             	mov    0x8(%ebx),%eax
     594:	89 04 24             	mov    %eax,(%esp)
     597:	e8 c4 fc ff ff       	call   260 <runcmd>
                panic("pipe");
     59c:	c7 04 24 cc 15 00 00 	movl   $0x15cc,(%esp)
     5a3:	e8 88 fc ff ff       	call   230 <panic>
                close(1);
     5a8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     5af:	e8 2c 0b 00 00       	call   10e0 <close>
                dup(p[1]);
     5b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5b7:	89 04 24             	mov    %eax,(%esp)
     5ba:	e8 71 0b 00 00       	call   1130 <dup>
                close(p[0]);
     5bf:	8b 45 e0             	mov    -0x20(%ebp),%eax
     5c2:	89 04 24             	mov    %eax,(%esp)
     5c5:	e8 16 0b 00 00       	call   10e0 <close>
                close(p[1]);
     5ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5cd:	89 04 24             	mov    %eax,(%esp)
     5d0:	e8 0b 0b 00 00       	call   10e0 <close>
                runcmd(pcmd->left);
     5d5:	8b 43 04             	mov    0x4(%ebx),%eax
     5d8:	89 04 24             	mov    %eax,(%esp)
     5db:	e8 80 fc ff ff       	call   260 <runcmd>

000005e0 <fork1>:
{
     5e0:	55                   	push   %ebp
     5e1:	89 e5                	mov    %esp,%ebp
     5e3:	83 ec 18             	sub    $0x18,%esp
    pid = fork();
     5e6:	e8 c5 0a 00 00       	call   10b0 <fork>
    if(pid == -1)
     5eb:	83 f8 ff             	cmp    $0xffffffff,%eax
     5ee:	74 02                	je     5f2 <fork1+0x12>
    return pid;
}
     5f0:	c9                   	leave  
     5f1:	c3                   	ret    
        panic("fork");
     5f2:	c7 04 24 c7 15 00 00 	movl   $0x15c7,(%esp)
     5f9:	e8 32 fc ff ff       	call   230 <panic>
     5fe:	66 90                	xchg   %ax,%ax

00000600 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     600:	55                   	push   %ebp
     601:	89 e5                	mov    %esp,%ebp
     603:	53                   	push   %ebx
     604:	83 ec 14             	sub    $0x14,%esp
    struct execcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     607:	c7 04 24 54 00 00 00 	movl   $0x54,(%esp)
     60e:	e8 9d 0e 00 00       	call   14b0 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     613:	31 d2                	xor    %edx,%edx
     615:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     619:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     61b:	b8 54 00 00 00       	mov    $0x54,%eax
     620:	89 1c 24             	mov    %ebx,(%esp)
     623:	89 44 24 08          	mov    %eax,0x8(%esp)
     627:	e8 f4 08 00 00       	call   f20 <memset>
    cmd->type = EXEC;
    return (struct cmd*)cmd;
}
     62c:	89 d8                	mov    %ebx,%eax
    cmd->type = EXEC;
     62e:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
}
     634:	83 c4 14             	add    $0x14,%esp
     637:	5b                   	pop    %ebx
     638:	5d                   	pop    %ebp
     639:	c3                   	ret    
     63a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000640 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     640:	55                   	push   %ebp
     641:	89 e5                	mov    %esp,%ebp
     643:	53                   	push   %ebx
     644:	83 ec 14             	sub    $0x14,%esp
    struct redircmd *cmd;

    cmd = malloc(sizeof(*cmd));
     647:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
     64e:	e8 5d 0e 00 00       	call   14b0 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     653:	31 d2                	xor    %edx,%edx
     655:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     659:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     65b:	b8 18 00 00 00       	mov    $0x18,%eax
     660:	89 1c 24             	mov    %ebx,(%esp)
     663:	89 44 24 08          	mov    %eax,0x8(%esp)
     667:	e8 b4 08 00 00       	call   f20 <memset>
    cmd->type = REDIR;
    cmd->cmd = subcmd;
     66c:	8b 45 08             	mov    0x8(%ebp),%eax
    cmd->type = REDIR;
     66f:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
    cmd->cmd = subcmd;
     675:	89 43 04             	mov    %eax,0x4(%ebx)
    cmd->file = file;
     678:	8b 45 0c             	mov    0xc(%ebp),%eax
     67b:	89 43 08             	mov    %eax,0x8(%ebx)
    cmd->efile = efile;
     67e:	8b 45 10             	mov    0x10(%ebp),%eax
     681:	89 43 0c             	mov    %eax,0xc(%ebx)
    cmd->mode = mode;
     684:	8b 45 14             	mov    0x14(%ebp),%eax
     687:	89 43 10             	mov    %eax,0x10(%ebx)
    cmd->fd = fd;
     68a:	8b 45 18             	mov    0x18(%ebp),%eax
     68d:	89 43 14             	mov    %eax,0x14(%ebx)
    return (struct cmd*)cmd;
}
     690:	83 c4 14             	add    $0x14,%esp
     693:	89 d8                	mov    %ebx,%eax
     695:	5b                   	pop    %ebx
     696:	5d                   	pop    %ebp
     697:	c3                   	ret    
     698:	90                   	nop
     699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006a0 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     6a0:	55                   	push   %ebp
     6a1:	89 e5                	mov    %esp,%ebp
     6a3:	53                   	push   %ebx
     6a4:	83 ec 14             	sub    $0x14,%esp
    struct pipecmd *cmd;

    cmd = malloc(sizeof(*cmd));
     6a7:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     6ae:	e8 fd 0d 00 00       	call   14b0 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     6b3:	31 d2                	xor    %edx,%edx
     6b5:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     6b9:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     6bb:	b8 0c 00 00 00       	mov    $0xc,%eax
     6c0:	89 1c 24             	mov    %ebx,(%esp)
     6c3:	89 44 24 08          	mov    %eax,0x8(%esp)
     6c7:	e8 54 08 00 00       	call   f20 <memset>
    cmd->type = PIPE;
    cmd->left = left;
     6cc:	8b 45 08             	mov    0x8(%ebp),%eax
    cmd->type = PIPE;
     6cf:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
    cmd->left = left;
     6d5:	89 43 04             	mov    %eax,0x4(%ebx)
    cmd->right = right;
     6d8:	8b 45 0c             	mov    0xc(%ebp),%eax
     6db:	89 43 08             	mov    %eax,0x8(%ebx)
    return (struct cmd*)cmd;
}
     6de:	83 c4 14             	add    $0x14,%esp
     6e1:	89 d8                	mov    %ebx,%eax
     6e3:	5b                   	pop    %ebx
     6e4:	5d                   	pop    %ebp
     6e5:	c3                   	ret    
     6e6:	8d 76 00             	lea    0x0(%esi),%esi
     6e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006f0 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     6f0:	55                   	push   %ebp
     6f1:	89 e5                	mov    %esp,%ebp
     6f3:	53                   	push   %ebx
     6f4:	83 ec 14             	sub    $0x14,%esp
    struct listcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     6f7:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     6fe:	e8 ad 0d 00 00       	call   14b0 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     703:	31 d2                	xor    %edx,%edx
     705:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     709:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     70b:	b8 0c 00 00 00       	mov    $0xc,%eax
     710:	89 1c 24             	mov    %ebx,(%esp)
     713:	89 44 24 08          	mov    %eax,0x8(%esp)
     717:	e8 04 08 00 00       	call   f20 <memset>
    cmd->type = LIST;
    cmd->left = left;
     71c:	8b 45 08             	mov    0x8(%ebp),%eax
    cmd->type = LIST;
     71f:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
    cmd->left = left;
     725:	89 43 04             	mov    %eax,0x4(%ebx)
    cmd->right = right;
     728:	8b 45 0c             	mov    0xc(%ebp),%eax
     72b:	89 43 08             	mov    %eax,0x8(%ebx)
    return (struct cmd*)cmd;
}
     72e:	83 c4 14             	add    $0x14,%esp
     731:	89 d8                	mov    %ebx,%eax
     733:	5b                   	pop    %ebx
     734:	5d                   	pop    %ebp
     735:	c3                   	ret    
     736:	8d 76 00             	lea    0x0(%esi),%esi
     739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000740 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     740:	55                   	push   %ebp
     741:	89 e5                	mov    %esp,%ebp
     743:	53                   	push   %ebx
     744:	83 ec 14             	sub    $0x14,%esp
    struct backcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     747:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     74e:	e8 5d 0d 00 00       	call   14b0 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     753:	31 d2                	xor    %edx,%edx
     755:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     759:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     75b:	b8 08 00 00 00       	mov    $0x8,%eax
     760:	89 1c 24             	mov    %ebx,(%esp)
     763:	89 44 24 08          	mov    %eax,0x8(%esp)
     767:	e8 b4 07 00 00       	call   f20 <memset>
    cmd->type = BACK;
    cmd->cmd = subcmd;
     76c:	8b 45 08             	mov    0x8(%ebp),%eax
    cmd->type = BACK;
     76f:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
    cmd->cmd = subcmd;
     775:	89 43 04             	mov    %eax,0x4(%ebx)
    return (struct cmd*)cmd;
}
     778:	83 c4 14             	add    $0x14,%esp
     77b:	89 d8                	mov    %ebx,%eax
     77d:	5b                   	pop    %ebx
     77e:	5d                   	pop    %ebp
     77f:	c3                   	ret    

00000780 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     780:	55                   	push   %ebp
     781:	89 e5                	mov    %esp,%ebp
     783:	57                   	push   %edi
     784:	56                   	push   %esi
     785:	53                   	push   %ebx
     786:	83 ec 1c             	sub    $0x1c,%esp
    char *s;
    int ret;

    s = *ps;
     789:	8b 45 08             	mov    0x8(%ebp),%eax
{
     78c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     78f:	8b 7d 10             	mov    0x10(%ebp),%edi
    s = *ps;
     792:	8b 30                	mov    (%eax),%esi
    while(s < es && strchr(whitespace, *s))
     794:	39 de                	cmp    %ebx,%esi
     796:	72 0d                	jb     7a5 <gettoken+0x25>
     798:	eb 22                	jmp    7bc <gettoken+0x3c>
     79a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s++;
     7a0:	46                   	inc    %esi
    while(s < es && strchr(whitespace, *s))
     7a1:	39 f3                	cmp    %esi,%ebx
     7a3:	74 17                	je     7bc <gettoken+0x3c>
     7a5:	0f be 06             	movsbl (%esi),%eax
     7a8:	c7 04 24 c4 1c 00 00 	movl   $0x1cc4,(%esp)
     7af:	89 44 24 04          	mov    %eax,0x4(%esp)
     7b3:	e8 88 07 00 00       	call   f40 <strchr>
     7b8:	85 c0                	test   %eax,%eax
     7ba:	75 e4                	jne    7a0 <gettoken+0x20>
    if(q)
     7bc:	85 ff                	test   %edi,%edi
     7be:	74 02                	je     7c2 <gettoken+0x42>
        *q = s;
     7c0:	89 37                	mov    %esi,(%edi)
    ret = *s;
     7c2:	0f be 06             	movsbl (%esi),%eax
    switch(*s){
     7c5:	3c 29                	cmp    $0x29,%al
     7c7:	7f 57                	jg     820 <gettoken+0xa0>
     7c9:	3c 28                	cmp    $0x28,%al
     7cb:	0f 8d cb 00 00 00    	jge    89c <gettoken+0x11c>
     7d1:	31 ff                	xor    %edi,%edi
     7d3:	84 c0                	test   %al,%al
     7d5:	0f 85 cd 00 00 00    	jne    8a8 <gettoken+0x128>
            ret = 'a';
            while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
                s++;
            break;
    }
    if(eq)
     7db:	8b 55 14             	mov    0x14(%ebp),%edx
     7de:	85 d2                	test   %edx,%edx
     7e0:	74 05                	je     7e7 <gettoken+0x67>
        *eq = s;
     7e2:	8b 45 14             	mov    0x14(%ebp),%eax
     7e5:	89 30                	mov    %esi,(%eax)

    while(s < es && strchr(whitespace, *s))
     7e7:	39 de                	cmp    %ebx,%esi
     7e9:	72 0a                	jb     7f5 <gettoken+0x75>
     7eb:	eb 1f                	jmp    80c <gettoken+0x8c>
     7ed:	8d 76 00             	lea    0x0(%esi),%esi
        s++;
     7f0:	46                   	inc    %esi
    while(s < es && strchr(whitespace, *s))
     7f1:	39 f3                	cmp    %esi,%ebx
     7f3:	74 17                	je     80c <gettoken+0x8c>
     7f5:	0f be 06             	movsbl (%esi),%eax
     7f8:	c7 04 24 c4 1c 00 00 	movl   $0x1cc4,(%esp)
     7ff:	89 44 24 04          	mov    %eax,0x4(%esp)
     803:	e8 38 07 00 00       	call   f40 <strchr>
     808:	85 c0                	test   %eax,%eax
     80a:	75 e4                	jne    7f0 <gettoken+0x70>
    *ps = s;
     80c:	8b 45 08             	mov    0x8(%ebp),%eax
     80f:	89 30                	mov    %esi,(%eax)
    return ret;
}
     811:	83 c4 1c             	add    $0x1c,%esp
     814:	89 f8                	mov    %edi,%eax
     816:	5b                   	pop    %ebx
     817:	5e                   	pop    %esi
     818:	5f                   	pop    %edi
     819:	5d                   	pop    %ebp
     81a:	c3                   	ret    
     81b:	90                   	nop
     81c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(*s){
     820:	3c 3e                	cmp    $0x3e,%al
     822:	75 1c                	jne    840 <gettoken+0xc0>
            if(*s == '>'){
     824:	80 7e 01 3e          	cmpb   $0x3e,0x1(%esi)
            s++;
     828:	8d 46 01             	lea    0x1(%esi),%eax
            if(*s == '>'){
     82b:	0f 84 94 00 00 00    	je     8c5 <gettoken+0x145>
            s++;
     831:	89 c6                	mov    %eax,%esi
     833:	bf 3e 00 00 00       	mov    $0x3e,%edi
     838:	eb a1                	jmp    7db <gettoken+0x5b>
     83a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(*s){
     840:	7f 56                	jg     898 <gettoken+0x118>
     842:	88 c1                	mov    %al,%cl
     844:	80 e9 3b             	sub    $0x3b,%cl
     847:	80 f9 01             	cmp    $0x1,%cl
     84a:	76 50                	jbe    89c <gettoken+0x11c>
            while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     84c:	39 f3                	cmp    %esi,%ebx
     84e:	77 27                	ja     877 <gettoken+0xf7>
     850:	eb 5e                	jmp    8b0 <gettoken+0x130>
     852:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     858:	0f be 06             	movsbl (%esi),%eax
     85b:	c7 04 24 bc 1c 00 00 	movl   $0x1cbc,(%esp)
     862:	89 44 24 04          	mov    %eax,0x4(%esp)
     866:	e8 d5 06 00 00       	call   f40 <strchr>
     86b:	85 c0                	test   %eax,%eax
     86d:	75 1c                	jne    88b <gettoken+0x10b>
                s++;
     86f:	46                   	inc    %esi
            while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     870:	39 f3                	cmp    %esi,%ebx
     872:	74 3c                	je     8b0 <gettoken+0x130>
     874:	0f be 06             	movsbl (%esi),%eax
     877:	89 44 24 04          	mov    %eax,0x4(%esp)
     87b:	c7 04 24 c4 1c 00 00 	movl   $0x1cc4,(%esp)
     882:	e8 b9 06 00 00       	call   f40 <strchr>
     887:	85 c0                	test   %eax,%eax
     889:	74 cd                	je     858 <gettoken+0xd8>
            ret = 'a';
     88b:	bf 61 00 00 00       	mov    $0x61,%edi
     890:	e9 46 ff ff ff       	jmp    7db <gettoken+0x5b>
     895:	8d 76 00             	lea    0x0(%esi),%esi
    switch(*s){
     898:	3c 7c                	cmp    $0x7c,%al
     89a:	75 b0                	jne    84c <gettoken+0xcc>
    ret = *s;
     89c:	0f be f8             	movsbl %al,%edi
            s++;
     89f:	46                   	inc    %esi
            break;
     8a0:	e9 36 ff ff ff       	jmp    7db <gettoken+0x5b>
     8a5:	8d 76 00             	lea    0x0(%esi),%esi
    switch(*s){
     8a8:	3c 26                	cmp    $0x26,%al
     8aa:	75 a0                	jne    84c <gettoken+0xcc>
     8ac:	eb ee                	jmp    89c <gettoken+0x11c>
     8ae:	66 90                	xchg   %ax,%ax
    if(eq)
     8b0:	8b 45 14             	mov    0x14(%ebp),%eax
     8b3:	bf 61 00 00 00       	mov    $0x61,%edi
     8b8:	85 c0                	test   %eax,%eax
     8ba:	0f 85 22 ff ff ff    	jne    7e2 <gettoken+0x62>
     8c0:	e9 47 ff ff ff       	jmp    80c <gettoken+0x8c>
                s++;
     8c5:	83 c6 02             	add    $0x2,%esi
                ret = '+';
     8c8:	bf 2b 00 00 00       	mov    $0x2b,%edi
     8cd:	e9 09 ff ff ff       	jmp    7db <gettoken+0x5b>
     8d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     8d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008e0 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     8e0:	55                   	push   %ebp
     8e1:	89 e5                	mov    %esp,%ebp
     8e3:	57                   	push   %edi
     8e4:	56                   	push   %esi
     8e5:	53                   	push   %ebx
     8e6:	83 ec 1c             	sub    $0x1c,%esp
     8e9:	8b 7d 08             	mov    0x8(%ebp),%edi
     8ec:	8b 75 0c             	mov    0xc(%ebp),%esi
    char *s;

    s = *ps;
     8ef:	8b 1f                	mov    (%edi),%ebx
    while(s < es && strchr(whitespace, *s))
     8f1:	39 f3                	cmp    %esi,%ebx
     8f3:	72 10                	jb     905 <peek+0x25>
     8f5:	eb 25                	jmp    91c <peek+0x3c>
     8f7:	89 f6                	mov    %esi,%esi
     8f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s++;
     900:	43                   	inc    %ebx
    while(s < es && strchr(whitespace, *s))
     901:	39 de                	cmp    %ebx,%esi
     903:	74 17                	je     91c <peek+0x3c>
     905:	0f be 03             	movsbl (%ebx),%eax
     908:	c7 04 24 c4 1c 00 00 	movl   $0x1cc4,(%esp)
     90f:	89 44 24 04          	mov    %eax,0x4(%esp)
     913:	e8 28 06 00 00       	call   f40 <strchr>
     918:	85 c0                	test   %eax,%eax
     91a:	75 e4                	jne    900 <peek+0x20>
    *ps = s;
     91c:	89 1f                	mov    %ebx,(%edi)
    return *s && strchr(toks, *s);
     91e:	31 c0                	xor    %eax,%eax
     920:	0f be 13             	movsbl (%ebx),%edx
     923:	84 d2                	test   %dl,%dl
     925:	74 17                	je     93e <peek+0x5e>
     927:	8b 45 10             	mov    0x10(%ebp),%eax
     92a:	89 54 24 04          	mov    %edx,0x4(%esp)
     92e:	89 04 24             	mov    %eax,(%esp)
     931:	e8 0a 06 00 00       	call   f40 <strchr>
     936:	85 c0                	test   %eax,%eax
     938:	0f 95 c0             	setne  %al
     93b:	0f b6 c0             	movzbl %al,%eax
}
     93e:	83 c4 1c             	add    $0x1c,%esp
     941:	5b                   	pop    %ebx
     942:	5e                   	pop    %esi
     943:	5f                   	pop    %edi
     944:	5d                   	pop    %ebp
     945:	c3                   	ret    
     946:	8d 76 00             	lea    0x0(%esi),%esi
     949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000950 <parseredirs>:
    return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     950:	55                   	push   %ebp
     951:	89 e5                	mov    %esp,%ebp
     953:	57                   	push   %edi
     954:	56                   	push   %esi
     955:	53                   	push   %ebx
     956:	83 ec 3c             	sub    $0x3c,%esp
     959:	8b 75 0c             	mov    0xc(%ebp),%esi
     95c:	8b 5d 10             	mov    0x10(%ebp),%ebx
     95f:	90                   	nop
    int tok;
    char *q, *eq;

    while(peek(ps, es, "<>")){
     960:	b8 ee 15 00 00       	mov    $0x15ee,%eax
     965:	89 44 24 08          	mov    %eax,0x8(%esp)
     969:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     96d:	89 34 24             	mov    %esi,(%esp)
     970:	e8 6b ff ff ff       	call   8e0 <peek>
     975:	85 c0                	test   %eax,%eax
     977:	0f 84 93 00 00 00    	je     a10 <parseredirs+0xc0>
        tok = gettoken(ps, es, 0, 0);
     97d:	31 c0                	xor    %eax,%eax
     97f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     983:	31 c0                	xor    %eax,%eax
     985:	89 44 24 08          	mov    %eax,0x8(%esp)
     989:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     98d:	89 34 24             	mov    %esi,(%esp)
     990:	e8 eb fd ff ff       	call   780 <gettoken>
        if(gettoken(ps, es, &q, &eq) != 'a')
     995:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     999:	89 34 24             	mov    %esi,(%esp)
        tok = gettoken(ps, es, 0, 0);
     99c:	89 c7                	mov    %eax,%edi
        if(gettoken(ps, es, &q, &eq) != 'a')
     99e:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     9a1:	89 44 24 0c          	mov    %eax,0xc(%esp)
     9a5:	8d 45 e0             	lea    -0x20(%ebp),%eax
     9a8:	89 44 24 08          	mov    %eax,0x8(%esp)
     9ac:	e8 cf fd ff ff       	call   780 <gettoken>
     9b1:	83 f8 61             	cmp    $0x61,%eax
     9b4:	75 65                	jne    a1b <parseredirs+0xcb>
            panic("missing file for redirection");
        switch(tok){
     9b6:	83 ff 3c             	cmp    $0x3c,%edi
     9b9:	74 45                	je     a00 <parseredirs+0xb0>
     9bb:	83 ff 3e             	cmp    $0x3e,%edi
     9be:	66 90                	xchg   %ax,%ax
     9c0:	74 05                	je     9c7 <parseredirs+0x77>
     9c2:	83 ff 2b             	cmp    $0x2b,%edi
     9c5:	75 99                	jne    960 <parseredirs+0x10>
                break;
            case '>':
                cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
                break;
            case '+':  // >>
                cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     9c7:	ba 01 00 00 00       	mov    $0x1,%edx
     9cc:	b9 01 02 00 00       	mov    $0x201,%ecx
     9d1:	89 54 24 10          	mov    %edx,0x10(%esp)
     9d5:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
     9d9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     9dc:	89 44 24 08          	mov    %eax,0x8(%esp)
     9e0:	8b 45 e0             	mov    -0x20(%ebp),%eax
     9e3:	89 44 24 04          	mov    %eax,0x4(%esp)
     9e7:	8b 45 08             	mov    0x8(%ebp),%eax
     9ea:	89 04 24             	mov    %eax,(%esp)
     9ed:	e8 4e fc ff ff       	call   640 <redircmd>
     9f2:	89 45 08             	mov    %eax,0x8(%ebp)
                break;
     9f5:	e9 66 ff ff ff       	jmp    960 <parseredirs+0x10>
     9fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     a00:	31 ff                	xor    %edi,%edi
     a02:	31 c0                	xor    %eax,%eax
     a04:	89 7c 24 10          	mov    %edi,0x10(%esp)
     a08:	89 44 24 0c          	mov    %eax,0xc(%esp)
     a0c:	eb cb                	jmp    9d9 <parseredirs+0x89>
     a0e:	66 90                	xchg   %ax,%ax
        }
    }
    return cmd;
}
     a10:	8b 45 08             	mov    0x8(%ebp),%eax
     a13:	83 c4 3c             	add    $0x3c,%esp
     a16:	5b                   	pop    %ebx
     a17:	5e                   	pop    %esi
     a18:	5f                   	pop    %edi
     a19:	5d                   	pop    %ebp
     a1a:	c3                   	ret    
            panic("missing file for redirection");
     a1b:	c7 04 24 d1 15 00 00 	movl   $0x15d1,(%esp)
     a22:	e8 09 f8 ff ff       	call   230 <panic>
     a27:	89 f6                	mov    %esi,%esi
     a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a30 <parseexec>:
    return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     a30:	55                   	push   %ebp
    char *q, *eq;
    int tok, argc;
    struct execcmd *cmd;
    struct cmd *ret;

    if(peek(ps, es, "("))
     a31:	ba f1 15 00 00       	mov    $0x15f1,%edx
{
     a36:	89 e5                	mov    %esp,%ebp
     a38:	57                   	push   %edi
     a39:	56                   	push   %esi
     a3a:	53                   	push   %ebx
     a3b:	83 ec 3c             	sub    $0x3c,%esp
     a3e:	8b 75 08             	mov    0x8(%ebp),%esi
     a41:	8b 7d 0c             	mov    0xc(%ebp),%edi
    if(peek(ps, es, "("))
     a44:	89 54 24 08          	mov    %edx,0x8(%esp)
     a48:	89 34 24             	mov    %esi,(%esp)
     a4b:	89 7c 24 04          	mov    %edi,0x4(%esp)
     a4f:	e8 8c fe ff ff       	call   8e0 <peek>
     a54:	85 c0                	test   %eax,%eax
     a56:	0f 85 9c 00 00 00    	jne    af8 <parseexec+0xc8>
     a5c:	89 c3                	mov    %eax,%ebx
        return parseblock(ps, es);

    ret = execcmd();
     a5e:	e8 9d fb ff ff       	call   600 <execcmd>
    cmd = (struct execcmd*)ret;

    argc = 0;
    ret = parseredirs(ret, ps, es);
     a63:	89 7c 24 08          	mov    %edi,0x8(%esp)
     a67:	89 74 24 04          	mov    %esi,0x4(%esp)
     a6b:	89 04 24             	mov    %eax,(%esp)
    ret = execcmd();
     a6e:	89 45 d0             	mov    %eax,-0x30(%ebp)
    ret = parseredirs(ret, ps, es);
     a71:	e8 da fe ff ff       	call   950 <parseredirs>
     a76:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     a79:	eb 1b                	jmp    a96 <parseexec+0x66>
     a7b:	90                   	nop
     a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cmd->argv[argc] = q;
        cmd->eargv[argc] = eq;
        argc++;
        if(argc >= MAXARGS)
            panic("too many args");
        ret = parseredirs(ret, ps, es);
     a80:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     a83:	89 7c 24 08          	mov    %edi,0x8(%esp)
     a87:	89 74 24 04          	mov    %esi,0x4(%esp)
     a8b:	89 04 24             	mov    %eax,(%esp)
     a8e:	e8 bd fe ff ff       	call   950 <parseredirs>
     a93:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while(!peek(ps, es, "|)&;")){
     a96:	b8 08 16 00 00       	mov    $0x1608,%eax
     a9b:	89 44 24 08          	mov    %eax,0x8(%esp)
     a9f:	89 7c 24 04          	mov    %edi,0x4(%esp)
     aa3:	89 34 24             	mov    %esi,(%esp)
     aa6:	e8 35 fe ff ff       	call   8e0 <peek>
     aab:	85 c0                	test   %eax,%eax
     aad:	75 69                	jne    b18 <parseexec+0xe8>
        if((tok=gettoken(ps, es, &q, &eq)) == 0)
     aaf:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     ab2:	89 44 24 0c          	mov    %eax,0xc(%esp)
     ab6:	8d 45 e0             	lea    -0x20(%ebp),%eax
     ab9:	89 44 24 08          	mov    %eax,0x8(%esp)
     abd:	89 7c 24 04          	mov    %edi,0x4(%esp)
     ac1:	89 34 24             	mov    %esi,(%esp)
     ac4:	e8 b7 fc ff ff       	call   780 <gettoken>
     ac9:	85 c0                	test   %eax,%eax
     acb:	74 4b                	je     b18 <parseexec+0xe8>
        if(tok != 'a')
     acd:	83 f8 61             	cmp    $0x61,%eax
     ad0:	75 65                	jne    b37 <parseexec+0x107>
        cmd->argv[argc] = q;
     ad2:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ad5:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ad8:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
        cmd->eargv[argc] = eq;
     adc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     adf:	89 44 9a 2c          	mov    %eax,0x2c(%edx,%ebx,4)
        argc++;
     ae3:	43                   	inc    %ebx
        if(argc >= MAXARGS)
     ae4:	83 fb 0a             	cmp    $0xa,%ebx
     ae7:	75 97                	jne    a80 <parseexec+0x50>
            panic("too many args");
     ae9:	c7 04 24 fa 15 00 00 	movl   $0x15fa,(%esp)
     af0:	e8 3b f7 ff ff       	call   230 <panic>
     af5:	8d 76 00             	lea    0x0(%esi),%esi
        return parseblock(ps, es);
     af8:	89 7c 24 04          	mov    %edi,0x4(%esp)
     afc:	89 34 24             	mov    %esi,(%esp)
     aff:	e8 9c 01 00 00       	call   ca0 <parseblock>
     b04:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    }
    cmd->argv[argc] = 0;
    cmd->eargv[argc] = 0;
    return ret;
}
     b07:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     b0a:	83 c4 3c             	add    $0x3c,%esp
     b0d:	5b                   	pop    %ebx
     b0e:	5e                   	pop    %esi
     b0f:	5f                   	pop    %edi
     b10:	5d                   	pop    %ebp
     b11:	c3                   	ret    
     b12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b18:	8b 45 d0             	mov    -0x30(%ebp),%eax
     b1b:	8d 04 98             	lea    (%eax,%ebx,4),%eax
    cmd->argv[argc] = 0;
     b1e:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    cmd->eargv[argc] = 0;
     b25:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
}
     b2c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     b2f:	83 c4 3c             	add    $0x3c,%esp
     b32:	5b                   	pop    %ebx
     b33:	5e                   	pop    %esi
     b34:	5f                   	pop    %edi
     b35:	5d                   	pop    %ebp
     b36:	c3                   	ret    
            panic("syntax");
     b37:	c7 04 24 f3 15 00 00 	movl   $0x15f3,(%esp)
     b3e:	e8 ed f6 ff ff       	call   230 <panic>
     b43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b50 <parsepipe>:
{
     b50:	55                   	push   %ebp
     b51:	89 e5                	mov    %esp,%ebp
     b53:	83 ec 28             	sub    $0x28,%esp
     b56:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     b59:	8b 5d 08             	mov    0x8(%ebp),%ebx
     b5c:	89 75 f8             	mov    %esi,-0x8(%ebp)
     b5f:	8b 75 0c             	mov    0xc(%ebp),%esi
     b62:	89 7d fc             	mov    %edi,-0x4(%ebp)
    cmd = parseexec(ps, es);
     b65:	89 1c 24             	mov    %ebx,(%esp)
     b68:	89 74 24 04          	mov    %esi,0x4(%esp)
     b6c:	e8 bf fe ff ff       	call   a30 <parseexec>
    if(peek(ps, es, "|")){
     b71:	b9 0d 16 00 00       	mov    $0x160d,%ecx
     b76:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     b7a:	89 74 24 04          	mov    %esi,0x4(%esp)
     b7e:	89 1c 24             	mov    %ebx,(%esp)
    cmd = parseexec(ps, es);
     b81:	89 c7                	mov    %eax,%edi
    if(peek(ps, es, "|")){
     b83:	e8 58 fd ff ff       	call   8e0 <peek>
     b88:	85 c0                	test   %eax,%eax
     b8a:	75 14                	jne    ba0 <parsepipe+0x50>
}
     b8c:	89 f8                	mov    %edi,%eax
     b8e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     b91:	8b 75 f8             	mov    -0x8(%ebp),%esi
     b94:	8b 7d fc             	mov    -0x4(%ebp),%edi
     b97:	89 ec                	mov    %ebp,%esp
     b99:	5d                   	pop    %ebp
     b9a:	c3                   	ret    
     b9b:	90                   	nop
     b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        gettoken(ps, es, 0, 0);
     ba0:	31 d2                	xor    %edx,%edx
     ba2:	31 c0                	xor    %eax,%eax
     ba4:	89 54 24 08          	mov    %edx,0x8(%esp)
     ba8:	89 74 24 04          	mov    %esi,0x4(%esp)
     bac:	89 1c 24             	mov    %ebx,(%esp)
     baf:	89 44 24 0c          	mov    %eax,0xc(%esp)
     bb3:	e8 c8 fb ff ff       	call   780 <gettoken>
        cmd = pipecmd(cmd, parsepipe(ps, es));
     bb8:	89 74 24 04          	mov    %esi,0x4(%esp)
     bbc:	89 1c 24             	mov    %ebx,(%esp)
     bbf:	e8 8c ff ff ff       	call   b50 <parsepipe>
}
     bc4:	8b 5d f4             	mov    -0xc(%ebp),%ebx
        cmd = pipecmd(cmd, parsepipe(ps, es));
     bc7:	89 7d 08             	mov    %edi,0x8(%ebp)
}
     bca:	8b 75 f8             	mov    -0x8(%ebp),%esi
     bcd:	8b 7d fc             	mov    -0x4(%ebp),%edi
        cmd = pipecmd(cmd, parsepipe(ps, es));
     bd0:	89 45 0c             	mov    %eax,0xc(%ebp)
}
     bd3:	89 ec                	mov    %ebp,%esp
     bd5:	5d                   	pop    %ebp
        cmd = pipecmd(cmd, parsepipe(ps, es));
     bd6:	e9 c5 fa ff ff       	jmp    6a0 <pipecmd>
     bdb:	90                   	nop
     bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000be0 <parseline>:
{
     be0:	55                   	push   %ebp
     be1:	89 e5                	mov    %esp,%ebp
     be3:	57                   	push   %edi
     be4:	56                   	push   %esi
     be5:	53                   	push   %ebx
     be6:	83 ec 1c             	sub    $0x1c,%esp
     be9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     bec:	8b 75 0c             	mov    0xc(%ebp),%esi
    cmd = parsepipe(ps, es);
     bef:	89 1c 24             	mov    %ebx,(%esp)
     bf2:	89 74 24 04          	mov    %esi,0x4(%esp)
     bf6:	e8 55 ff ff ff       	call   b50 <parsepipe>
     bfb:	89 c7                	mov    %eax,%edi
    while(peek(ps, es, "&")){
     bfd:	eb 23                	jmp    c22 <parseline+0x42>
     bff:	90                   	nop
        gettoken(ps, es, 0, 0);
     c00:	31 c0                	xor    %eax,%eax
     c02:	89 44 24 0c          	mov    %eax,0xc(%esp)
     c06:	31 c0                	xor    %eax,%eax
     c08:	89 44 24 08          	mov    %eax,0x8(%esp)
     c0c:	89 74 24 04          	mov    %esi,0x4(%esp)
     c10:	89 1c 24             	mov    %ebx,(%esp)
     c13:	e8 68 fb ff ff       	call   780 <gettoken>
        cmd = backcmd(cmd);
     c18:	89 3c 24             	mov    %edi,(%esp)
     c1b:	e8 20 fb ff ff       	call   740 <backcmd>
     c20:	89 c7                	mov    %eax,%edi
    while(peek(ps, es, "&")){
     c22:	b8 0f 16 00 00       	mov    $0x160f,%eax
     c27:	89 44 24 08          	mov    %eax,0x8(%esp)
     c2b:	89 74 24 04          	mov    %esi,0x4(%esp)
     c2f:	89 1c 24             	mov    %ebx,(%esp)
     c32:	e8 a9 fc ff ff       	call   8e0 <peek>
     c37:	85 c0                	test   %eax,%eax
     c39:	75 c5                	jne    c00 <parseline+0x20>
    if(peek(ps, es, ";")){
     c3b:	b9 0b 16 00 00       	mov    $0x160b,%ecx
     c40:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     c44:	89 74 24 04          	mov    %esi,0x4(%esp)
     c48:	89 1c 24             	mov    %ebx,(%esp)
     c4b:	e8 90 fc ff ff       	call   8e0 <peek>
     c50:	85 c0                	test   %eax,%eax
     c52:	75 0c                	jne    c60 <parseline+0x80>
}
     c54:	83 c4 1c             	add    $0x1c,%esp
     c57:	89 f8                	mov    %edi,%eax
     c59:	5b                   	pop    %ebx
     c5a:	5e                   	pop    %esi
     c5b:	5f                   	pop    %edi
     c5c:	5d                   	pop    %ebp
     c5d:	c3                   	ret    
     c5e:	66 90                	xchg   %ax,%ax
        gettoken(ps, es, 0, 0);
     c60:	31 d2                	xor    %edx,%edx
     c62:	31 c0                	xor    %eax,%eax
     c64:	89 54 24 08          	mov    %edx,0x8(%esp)
     c68:	89 74 24 04          	mov    %esi,0x4(%esp)
     c6c:	89 1c 24             	mov    %ebx,(%esp)
     c6f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     c73:	e8 08 fb ff ff       	call   780 <gettoken>
        cmd = listcmd(cmd, parseline(ps, es));
     c78:	89 74 24 04          	mov    %esi,0x4(%esp)
     c7c:	89 1c 24             	mov    %ebx,(%esp)
     c7f:	e8 5c ff ff ff       	call   be0 <parseline>
     c84:	89 7d 08             	mov    %edi,0x8(%ebp)
     c87:	89 45 0c             	mov    %eax,0xc(%ebp)
}
     c8a:	83 c4 1c             	add    $0x1c,%esp
     c8d:	5b                   	pop    %ebx
     c8e:	5e                   	pop    %esi
     c8f:	5f                   	pop    %edi
     c90:	5d                   	pop    %ebp
        cmd = listcmd(cmd, parseline(ps, es));
     c91:	e9 5a fa ff ff       	jmp    6f0 <listcmd>
     c96:	8d 76 00             	lea    0x0(%esi),%esi
     c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ca0 <parseblock>:
{
     ca0:	55                   	push   %ebp
    if(!peek(ps, es, "("))
     ca1:	b8 f1 15 00 00       	mov    $0x15f1,%eax
{
     ca6:	89 e5                	mov    %esp,%ebp
     ca8:	83 ec 28             	sub    $0x28,%esp
     cab:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     cae:	8b 5d 08             	mov    0x8(%ebp),%ebx
     cb1:	89 75 f8             	mov    %esi,-0x8(%ebp)
     cb4:	8b 75 0c             	mov    0xc(%ebp),%esi
    if(!peek(ps, es, "("))
     cb7:	89 44 24 08          	mov    %eax,0x8(%esp)
{
     cbb:	89 7d fc             	mov    %edi,-0x4(%ebp)
    if(!peek(ps, es, "("))
     cbe:	89 1c 24             	mov    %ebx,(%esp)
     cc1:	89 74 24 04          	mov    %esi,0x4(%esp)
     cc5:	e8 16 fc ff ff       	call   8e0 <peek>
     cca:	85 c0                	test   %eax,%eax
     ccc:	74 74                	je     d42 <parseblock+0xa2>
    gettoken(ps, es, 0, 0);
     cce:	31 c9                	xor    %ecx,%ecx
     cd0:	31 ff                	xor    %edi,%edi
     cd2:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
     cd6:	89 7c 24 08          	mov    %edi,0x8(%esp)
     cda:	89 74 24 04          	mov    %esi,0x4(%esp)
     cde:	89 1c 24             	mov    %ebx,(%esp)
     ce1:	e8 9a fa ff ff       	call   780 <gettoken>
    cmd = parseline(ps, es);
     ce6:	89 74 24 04          	mov    %esi,0x4(%esp)
     cea:	89 1c 24             	mov    %ebx,(%esp)
     ced:	e8 ee fe ff ff       	call   be0 <parseline>
    if(!peek(ps, es, ")"))
     cf2:	89 74 24 04          	mov    %esi,0x4(%esp)
     cf6:	89 1c 24             	mov    %ebx,(%esp)
    cmd = parseline(ps, es);
     cf9:	89 c7                	mov    %eax,%edi
    if(!peek(ps, es, ")"))
     cfb:	b8 2d 16 00 00       	mov    $0x162d,%eax
     d00:	89 44 24 08          	mov    %eax,0x8(%esp)
     d04:	e8 d7 fb ff ff       	call   8e0 <peek>
     d09:	85 c0                	test   %eax,%eax
     d0b:	74 41                	je     d4e <parseblock+0xae>
    gettoken(ps, es, 0, 0);
     d0d:	31 d2                	xor    %edx,%edx
     d0f:	31 c0                	xor    %eax,%eax
     d11:	89 54 24 08          	mov    %edx,0x8(%esp)
     d15:	89 74 24 04          	mov    %esi,0x4(%esp)
     d19:	89 1c 24             	mov    %ebx,(%esp)
     d1c:	89 44 24 0c          	mov    %eax,0xc(%esp)
     d20:	e8 5b fa ff ff       	call   780 <gettoken>
    cmd = parseredirs(cmd, ps, es);
     d25:	89 74 24 08          	mov    %esi,0x8(%esp)
     d29:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     d2d:	89 3c 24             	mov    %edi,(%esp)
     d30:	e8 1b fc ff ff       	call   950 <parseredirs>
}
     d35:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     d38:	8b 75 f8             	mov    -0x8(%ebp),%esi
     d3b:	8b 7d fc             	mov    -0x4(%ebp),%edi
     d3e:	89 ec                	mov    %ebp,%esp
     d40:	5d                   	pop    %ebp
     d41:	c3                   	ret    
        panic("parseblock");
     d42:	c7 04 24 11 16 00 00 	movl   $0x1611,(%esp)
     d49:	e8 e2 f4 ff ff       	call   230 <panic>
        panic("syntax - missing )");
     d4e:	c7 04 24 1c 16 00 00 	movl   $0x161c,(%esp)
     d55:	e8 d6 f4 ff ff       	call   230 <panic>
     d5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000d60 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     d60:	55                   	push   %ebp
     d61:	89 e5                	mov    %esp,%ebp
     d63:	53                   	push   %ebx
     d64:	83 ec 14             	sub    $0x14,%esp
     d67:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct execcmd *ecmd;
    struct listcmd *lcmd;
    struct pipecmd *pcmd;
    struct redircmd *rcmd;

    if(cmd == 0)
     d6a:	85 db                	test   %ebx,%ebx
     d6c:	74 1d                	je     d8b <nulterminate+0x2b>
        return 0;

    switch(cmd->type){
     d6e:	83 3b 05             	cmpl   $0x5,(%ebx)
     d71:	77 18                	ja     d8b <nulterminate+0x2b>
     d73:	8b 03                	mov    (%ebx),%eax
     d75:	ff 24 85 90 16 00 00 	jmp    *0x1690(,%eax,4)
     d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            nulterminate(lcmd->right);
            break;

        case BACK:
            bcmd = (struct backcmd*)cmd;
            nulterminate(bcmd->cmd);
     d80:	8b 43 04             	mov    0x4(%ebx),%eax
     d83:	89 04 24             	mov    %eax,(%esp)
     d86:	e8 d5 ff ff ff       	call   d60 <nulterminate>
            break;
    }
    return cmd;
}
     d8b:	83 c4 14             	add    $0x14,%esp
     d8e:	89 d8                	mov    %ebx,%eax
     d90:	5b                   	pop    %ebx
     d91:	5d                   	pop    %ebp
     d92:	c3                   	ret    
     d93:	90                   	nop
     d94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            nulterminate(lcmd->left);
     d98:	8b 43 04             	mov    0x4(%ebx),%eax
     d9b:	89 04 24             	mov    %eax,(%esp)
     d9e:	e8 bd ff ff ff       	call   d60 <nulterminate>
            nulterminate(lcmd->right);
     da3:	8b 43 08             	mov    0x8(%ebx),%eax
     da6:	89 04 24             	mov    %eax,(%esp)
     da9:	e8 b2 ff ff ff       	call   d60 <nulterminate>
}
     dae:	83 c4 14             	add    $0x14,%esp
     db1:	89 d8                	mov    %ebx,%eax
     db3:	5b                   	pop    %ebx
     db4:	5d                   	pop    %ebp
     db5:	c3                   	ret    
     db6:	8d 76 00             	lea    0x0(%esi),%esi
     db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            for(i=0; ecmd->argv[i]; i++)
     dc0:	8b 4b 04             	mov    0x4(%ebx),%ecx
     dc3:	8d 43 08             	lea    0x8(%ebx),%eax
     dc6:	85 c9                	test   %ecx,%ecx
     dc8:	74 c1                	je     d8b <nulterminate+0x2b>
     dca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                *ecmd->eargv[i] = 0;
     dd0:	8b 50 24             	mov    0x24(%eax),%edx
     dd3:	83 c0 04             	add    $0x4,%eax
     dd6:	c6 02 00             	movb   $0x0,(%edx)
            for(i=0; ecmd->argv[i]; i++)
     dd9:	8b 50 fc             	mov    -0x4(%eax),%edx
     ddc:	85 d2                	test   %edx,%edx
     dde:	75 f0                	jne    dd0 <nulterminate+0x70>
}
     de0:	83 c4 14             	add    $0x14,%esp
     de3:	89 d8                	mov    %ebx,%eax
     de5:	5b                   	pop    %ebx
     de6:	5d                   	pop    %ebp
     de7:	c3                   	ret    
     de8:	90                   	nop
     de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            nulterminate(rcmd->cmd);
     df0:	8b 43 04             	mov    0x4(%ebx),%eax
     df3:	89 04 24             	mov    %eax,(%esp)
     df6:	e8 65 ff ff ff       	call   d60 <nulterminate>
            *rcmd->efile = 0;
     dfb:	8b 43 0c             	mov    0xc(%ebx),%eax
     dfe:	c6 00 00             	movb   $0x0,(%eax)
}
     e01:	83 c4 14             	add    $0x14,%esp
     e04:	89 d8                	mov    %ebx,%eax
     e06:	5b                   	pop    %ebx
     e07:	5d                   	pop    %ebp
     e08:	c3                   	ret    
     e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000e10 <parsecmd>:
{
     e10:	55                   	push   %ebp
     e11:	89 e5                	mov    %esp,%ebp
     e13:	56                   	push   %esi
     e14:	53                   	push   %ebx
     e15:	83 ec 10             	sub    $0x10,%esp
    es = s + strlen(s);
     e18:	8b 5d 08             	mov    0x8(%ebp),%ebx
     e1b:	89 1c 24             	mov    %ebx,(%esp)
     e1e:	e8 cd 00 00 00       	call   ef0 <strlen>
     e23:	01 c3                	add    %eax,%ebx
    cmd = parseline(&s, es);
     e25:	8d 45 08             	lea    0x8(%ebp),%eax
     e28:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     e2c:	89 04 24             	mov    %eax,(%esp)
     e2f:	e8 ac fd ff ff       	call   be0 <parseline>
    peek(&s, es, "");
     e34:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    cmd = parseline(&s, es);
     e38:	89 c6                	mov    %eax,%esi
    peek(&s, es, "");
     e3a:	b8 b6 15 00 00       	mov    $0x15b6,%eax
     e3f:	89 44 24 08          	mov    %eax,0x8(%esp)
     e43:	8d 45 08             	lea    0x8(%ebp),%eax
     e46:	89 04 24             	mov    %eax,(%esp)
     e49:	e8 92 fa ff ff       	call   8e0 <peek>
    if(s != es){
     e4e:	8b 45 08             	mov    0x8(%ebp),%eax
     e51:	39 d8                	cmp    %ebx,%eax
     e53:	75 11                	jne    e66 <parsecmd+0x56>
    nulterminate(cmd);
     e55:	89 34 24             	mov    %esi,(%esp)
     e58:	e8 03 ff ff ff       	call   d60 <nulterminate>
}
     e5d:	83 c4 10             	add    $0x10,%esp
     e60:	89 f0                	mov    %esi,%eax
     e62:	5b                   	pop    %ebx
     e63:	5e                   	pop    %esi
     e64:	5d                   	pop    %ebp
     e65:	c3                   	ret    
        printf(2, "leftovers: %s\n", s);
     e66:	89 44 24 08          	mov    %eax,0x8(%esp)
     e6a:	c7 44 24 04 2f 16 00 	movl   $0x162f,0x4(%esp)
     e71:	00 
     e72:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     e79:	e8 a2 03 00 00       	call   1220 <printf>
        panic("syntax");
     e7e:	c7 04 24 f3 15 00 00 	movl   $0x15f3,(%esp)
     e85:	e8 a6 f3 ff ff       	call   230 <panic>
     e8a:	66 90                	xchg   %ax,%ax
     e8c:	66 90                	xchg   %ax,%ax
     e8e:	66 90                	xchg   %ax,%ax

00000e90 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     e90:	55                   	push   %ebp
     e91:	89 e5                	mov    %esp,%ebp
     e93:	8b 45 08             	mov    0x8(%ebp),%eax
     e96:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     e99:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     e9a:	89 c2                	mov    %eax,%edx
     e9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ea0:	41                   	inc    %ecx
     ea1:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     ea5:	42                   	inc    %edx
     ea6:	84 db                	test   %bl,%bl
     ea8:	88 5a ff             	mov    %bl,-0x1(%edx)
     eab:	75 f3                	jne    ea0 <strcpy+0x10>
    ;
  return os;
}
     ead:	5b                   	pop    %ebx
     eae:	5d                   	pop    %ebp
     eaf:	c3                   	ret    

00000eb0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     eb0:	55                   	push   %ebp
     eb1:	89 e5                	mov    %esp,%ebp
     eb3:	8b 4d 08             	mov    0x8(%ebp),%ecx
     eb6:	53                   	push   %ebx
     eb7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
     eba:	0f b6 01             	movzbl (%ecx),%eax
     ebd:	0f b6 13             	movzbl (%ebx),%edx
     ec0:	84 c0                	test   %al,%al
     ec2:	75 18                	jne    edc <strcmp+0x2c>
     ec4:	eb 22                	jmp    ee8 <strcmp+0x38>
     ec6:	8d 76 00             	lea    0x0(%esi),%esi
     ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     ed0:	41                   	inc    %ecx
  while(*p && *p == *q)
     ed1:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
     ed4:	43                   	inc    %ebx
     ed5:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
     ed8:	84 c0                	test   %al,%al
     eda:	74 0c                	je     ee8 <strcmp+0x38>
     edc:	38 d0                	cmp    %dl,%al
     ede:	74 f0                	je     ed0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
     ee0:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
     ee1:	29 d0                	sub    %edx,%eax
}
     ee3:	5d                   	pop    %ebp
     ee4:	c3                   	ret    
     ee5:	8d 76 00             	lea    0x0(%esi),%esi
     ee8:	5b                   	pop    %ebx
     ee9:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     eeb:	29 d0                	sub    %edx,%eax
}
     eed:	5d                   	pop    %ebp
     eee:	c3                   	ret    
     eef:	90                   	nop

00000ef0 <strlen>:

uint
strlen(const char *s)
{
     ef0:	55                   	push   %ebp
     ef1:	89 e5                	mov    %esp,%ebp
     ef3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     ef6:	80 39 00             	cmpb   $0x0,(%ecx)
     ef9:	74 15                	je     f10 <strlen+0x20>
     efb:	31 d2                	xor    %edx,%edx
     efd:	8d 76 00             	lea    0x0(%esi),%esi
     f00:	42                   	inc    %edx
     f01:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     f05:	89 d0                	mov    %edx,%eax
     f07:	75 f7                	jne    f00 <strlen+0x10>
    ;
  return n;
}
     f09:	5d                   	pop    %ebp
     f0a:	c3                   	ret    
     f0b:	90                   	nop
     f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
     f10:	31 c0                	xor    %eax,%eax
}
     f12:	5d                   	pop    %ebp
     f13:	c3                   	ret    
     f14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     f1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000f20 <memset>:

void*
memset(void *dst, int c, uint n)
{
     f20:	55                   	push   %ebp
     f21:	89 e5                	mov    %esp,%ebp
     f23:	8b 55 08             	mov    0x8(%ebp),%edx
     f26:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     f27:	8b 4d 10             	mov    0x10(%ebp),%ecx
     f2a:	8b 45 0c             	mov    0xc(%ebp),%eax
     f2d:	89 d7                	mov    %edx,%edi
     f2f:	fc                   	cld    
     f30:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     f32:	5f                   	pop    %edi
     f33:	89 d0                	mov    %edx,%eax
     f35:	5d                   	pop    %ebp
     f36:	c3                   	ret    
     f37:	89 f6                	mov    %esi,%esi
     f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000f40 <strchr>:

char*
strchr(const char *s, char c)
{
     f40:	55                   	push   %ebp
     f41:	89 e5                	mov    %esp,%ebp
     f43:	8b 45 08             	mov    0x8(%ebp),%eax
     f46:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     f4a:	0f b6 10             	movzbl (%eax),%edx
     f4d:	84 d2                	test   %dl,%dl
     f4f:	74 1b                	je     f6c <strchr+0x2c>
    if(*s == c)
     f51:	38 d1                	cmp    %dl,%cl
     f53:	75 0f                	jne    f64 <strchr+0x24>
     f55:	eb 17                	jmp    f6e <strchr+0x2e>
     f57:	89 f6                	mov    %esi,%esi
     f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     f60:	38 ca                	cmp    %cl,%dl
     f62:	74 0a                	je     f6e <strchr+0x2e>
  for(; *s; s++)
     f64:	40                   	inc    %eax
     f65:	0f b6 10             	movzbl (%eax),%edx
     f68:	84 d2                	test   %dl,%dl
     f6a:	75 f4                	jne    f60 <strchr+0x20>
      return (char*)s;
  return 0;
     f6c:	31 c0                	xor    %eax,%eax
}
     f6e:	5d                   	pop    %ebp
     f6f:	c3                   	ret    

00000f70 <gets>:

char*
gets(char *buf, int max)
{
     f70:	55                   	push   %ebp
     f71:	89 e5                	mov    %esp,%ebp
     f73:	57                   	push   %edi
     f74:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     f75:	31 f6                	xor    %esi,%esi
{
     f77:	53                   	push   %ebx
     f78:	83 ec 3c             	sub    $0x3c,%esp
     f7b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
     f7e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
     f81:	eb 32                	jmp    fb5 <gets+0x45>
     f83:	90                   	nop
     f84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
     f88:	ba 01 00 00 00       	mov    $0x1,%edx
     f8d:	89 54 24 08          	mov    %edx,0x8(%esp)
     f91:	89 7c 24 04          	mov    %edi,0x4(%esp)
     f95:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     f9c:	e8 2f 01 00 00       	call   10d0 <read>
    if(cc < 1)
     fa1:	85 c0                	test   %eax,%eax
     fa3:	7e 19                	jle    fbe <gets+0x4e>
      break;
    buf[i++] = c;
     fa5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     fa9:	43                   	inc    %ebx
     faa:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
     fad:	3c 0a                	cmp    $0xa,%al
     faf:	74 1f                	je     fd0 <gets+0x60>
     fb1:	3c 0d                	cmp    $0xd,%al
     fb3:	74 1b                	je     fd0 <gets+0x60>
  for(i=0; i+1 < max; ){
     fb5:	46                   	inc    %esi
     fb6:	3b 75 0c             	cmp    0xc(%ebp),%esi
     fb9:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
     fbc:	7c ca                	jl     f88 <gets+0x18>
      break;
  }
  buf[i] = '\0';
     fbe:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     fc1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
     fc4:	8b 45 08             	mov    0x8(%ebp),%eax
     fc7:	83 c4 3c             	add    $0x3c,%esp
     fca:	5b                   	pop    %ebx
     fcb:	5e                   	pop    %esi
     fcc:	5f                   	pop    %edi
     fcd:	5d                   	pop    %ebp
     fce:	c3                   	ret    
     fcf:	90                   	nop
     fd0:	8b 45 08             	mov    0x8(%ebp),%eax
     fd3:	01 c6                	add    %eax,%esi
     fd5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
     fd8:	eb e4                	jmp    fbe <gets+0x4e>
     fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000fe0 <stat>:

int
stat(const char *n, struct stat *st)
{
     fe0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     fe1:	31 c0                	xor    %eax,%eax
{
     fe3:	89 e5                	mov    %esp,%ebp
     fe5:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
     fe8:	89 44 24 04          	mov    %eax,0x4(%esp)
     fec:	8b 45 08             	mov    0x8(%ebp),%eax
{
     fef:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     ff2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
     ff5:	89 04 24             	mov    %eax,(%esp)
     ff8:	e8 fb 00 00 00       	call   10f8 <open>
  if(fd < 0)
     ffd:	85 c0                	test   %eax,%eax
     fff:	78 2f                	js     1030 <stat+0x50>
    1001:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    1003:	8b 45 0c             	mov    0xc(%ebp),%eax
    1006:	89 1c 24             	mov    %ebx,(%esp)
    1009:	89 44 24 04          	mov    %eax,0x4(%esp)
    100d:	e8 fe 00 00 00       	call   1110 <fstat>
  close(fd);
    1012:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    1015:	89 c6                	mov    %eax,%esi
  close(fd);
    1017:	e8 c4 00 00 00       	call   10e0 <close>
  return r;
}
    101c:	89 f0                	mov    %esi,%eax
    101e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    1021:	8b 75 fc             	mov    -0x4(%ebp),%esi
    1024:	89 ec                	mov    %ebp,%esp
    1026:	5d                   	pop    %ebp
    1027:	c3                   	ret    
    1028:	90                   	nop
    1029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
    1030:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1035:	eb e5                	jmp    101c <stat+0x3c>
    1037:	89 f6                	mov    %esi,%esi
    1039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001040 <atoi>:

int
atoi(const char *s)
{
    1040:	55                   	push   %ebp
    1041:	89 e5                	mov    %esp,%ebp
    1043:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1046:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1047:	0f be 11             	movsbl (%ecx),%edx
    104a:	88 d0                	mov    %dl,%al
    104c:	2c 30                	sub    $0x30,%al
    104e:	3c 09                	cmp    $0x9,%al
  n = 0;
    1050:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    1055:	77 1e                	ja     1075 <atoi+0x35>
    1057:	89 f6                	mov    %esi,%esi
    1059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    1060:	41                   	inc    %ecx
    1061:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1064:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    1068:	0f be 11             	movsbl (%ecx),%edx
    106b:	88 d3                	mov    %dl,%bl
    106d:	80 eb 30             	sub    $0x30,%bl
    1070:	80 fb 09             	cmp    $0x9,%bl
    1073:	76 eb                	jbe    1060 <atoi+0x20>
  return n;
}
    1075:	5b                   	pop    %ebx
    1076:	5d                   	pop    %ebp
    1077:	c3                   	ret    
    1078:	90                   	nop
    1079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001080 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1080:	55                   	push   %ebp
    1081:	89 e5                	mov    %esp,%ebp
    1083:	56                   	push   %esi
    1084:	8b 45 08             	mov    0x8(%ebp),%eax
    1087:	53                   	push   %ebx
    1088:	8b 5d 10             	mov    0x10(%ebp),%ebx
    108b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    108e:	85 db                	test   %ebx,%ebx
    1090:	7e 1a                	jle    10ac <memmove+0x2c>
    1092:	31 d2                	xor    %edx,%edx
    1094:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    109a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
    10a0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    10a4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    10a7:	42                   	inc    %edx
  while(n-- > 0)
    10a8:	39 d3                	cmp    %edx,%ebx
    10aa:	75 f4                	jne    10a0 <memmove+0x20>
  return vdst;
}
    10ac:	5b                   	pop    %ebx
    10ad:	5e                   	pop    %esi
    10ae:	5d                   	pop    %ebp
    10af:	c3                   	ret    

000010b0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    10b0:	b8 01 00 00 00       	mov    $0x1,%eax
    10b5:	cd 40                	int    $0x40
    10b7:	c3                   	ret    

000010b8 <exit>:
SYSCALL(exit)
    10b8:	b8 02 00 00 00       	mov    $0x2,%eax
    10bd:	cd 40                	int    $0x40
    10bf:	c3                   	ret    

000010c0 <wait>:
SYSCALL(wait)
    10c0:	b8 03 00 00 00       	mov    $0x3,%eax
    10c5:	cd 40                	int    $0x40
    10c7:	c3                   	ret    

000010c8 <pipe>:
SYSCALL(pipe)
    10c8:	b8 04 00 00 00       	mov    $0x4,%eax
    10cd:	cd 40                	int    $0x40
    10cf:	c3                   	ret    

000010d0 <read>:
SYSCALL(read)
    10d0:	b8 05 00 00 00       	mov    $0x5,%eax
    10d5:	cd 40                	int    $0x40
    10d7:	c3                   	ret    

000010d8 <write>:
SYSCALL(write)
    10d8:	b8 10 00 00 00       	mov    $0x10,%eax
    10dd:	cd 40                	int    $0x40
    10df:	c3                   	ret    

000010e0 <close>:
SYSCALL(close)
    10e0:	b8 15 00 00 00       	mov    $0x15,%eax
    10e5:	cd 40                	int    $0x40
    10e7:	c3                   	ret    

000010e8 <kill>:
SYSCALL(kill)
    10e8:	b8 06 00 00 00       	mov    $0x6,%eax
    10ed:	cd 40                	int    $0x40
    10ef:	c3                   	ret    

000010f0 <exec>:
SYSCALL(exec)
    10f0:	b8 07 00 00 00       	mov    $0x7,%eax
    10f5:	cd 40                	int    $0x40
    10f7:	c3                   	ret    

000010f8 <open>:
SYSCALL(open)
    10f8:	b8 0f 00 00 00       	mov    $0xf,%eax
    10fd:	cd 40                	int    $0x40
    10ff:	c3                   	ret    

00001100 <mknod>:
SYSCALL(mknod)
    1100:	b8 11 00 00 00       	mov    $0x11,%eax
    1105:	cd 40                	int    $0x40
    1107:	c3                   	ret    

00001108 <unlink>:
SYSCALL(unlink)
    1108:	b8 12 00 00 00       	mov    $0x12,%eax
    110d:	cd 40                	int    $0x40
    110f:	c3                   	ret    

00001110 <fstat>:
SYSCALL(fstat)
    1110:	b8 08 00 00 00       	mov    $0x8,%eax
    1115:	cd 40                	int    $0x40
    1117:	c3                   	ret    

00001118 <link>:
SYSCALL(link)
    1118:	b8 13 00 00 00       	mov    $0x13,%eax
    111d:	cd 40                	int    $0x40
    111f:	c3                   	ret    

00001120 <mkdir>:
SYSCALL(mkdir)
    1120:	b8 14 00 00 00       	mov    $0x14,%eax
    1125:	cd 40                	int    $0x40
    1127:	c3                   	ret    

00001128 <chdir>:
SYSCALL(chdir)
    1128:	b8 09 00 00 00       	mov    $0x9,%eax
    112d:	cd 40                	int    $0x40
    112f:	c3                   	ret    

00001130 <dup>:
SYSCALL(dup)
    1130:	b8 0a 00 00 00       	mov    $0xa,%eax
    1135:	cd 40                	int    $0x40
    1137:	c3                   	ret    

00001138 <getpid>:
SYSCALL(getpid)
    1138:	b8 0b 00 00 00       	mov    $0xb,%eax
    113d:	cd 40                	int    $0x40
    113f:	c3                   	ret    

00001140 <sbrk>:
SYSCALL(sbrk)
    1140:	b8 0c 00 00 00       	mov    $0xc,%eax
    1145:	cd 40                	int    $0x40
    1147:	c3                   	ret    

00001148 <sleep>:
SYSCALL(sleep)
    1148:	b8 0d 00 00 00       	mov    $0xd,%eax
    114d:	cd 40                	int    $0x40
    114f:	c3                   	ret    

00001150 <uptime>:
SYSCALL(uptime)
    1150:	b8 0e 00 00 00       	mov    $0xe,%eax
    1155:	cd 40                	int    $0x40
    1157:	c3                   	ret    

00001158 <policy>:
SYSCALL(policy)
    1158:	b8 17 00 00 00       	mov    $0x17,%eax
    115d:	cd 40                	int    $0x40
    115f:	c3                   	ret    

00001160 <detach>:
SYSCALL(detach)
    1160:	b8 16 00 00 00       	mov    $0x16,%eax
    1165:	cd 40                	int    $0x40
    1167:	c3                   	ret    

00001168 <priority>:
SYSCALL(priority)
    1168:	b8 18 00 00 00       	mov    $0x18,%eax
    116d:	cd 40                	int    $0x40
    116f:	c3                   	ret    

00001170 <wait_stat>:
SYSCALL(wait_stat)
    1170:	b8 19 00 00 00       	mov    $0x19,%eax
    1175:	cd 40                	int    $0x40
    1177:	c3                   	ret    
    1178:	66 90                	xchg   %ax,%ax
    117a:	66 90                	xchg   %ax,%ax
    117c:	66 90                	xchg   %ax,%ax
    117e:	66 90                	xchg   %ax,%ax

00001180 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1180:	55                   	push   %ebp
    1181:	89 e5                	mov    %esp,%ebp
    1183:	57                   	push   %edi
    1184:	56                   	push   %esi
    1185:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1186:	89 d3                	mov    %edx,%ebx
    1188:	c1 eb 1f             	shr    $0x1f,%ebx
{
    118b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
    118e:	84 db                	test   %bl,%bl
{
    1190:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1193:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    1195:	74 79                	je     1210 <printint+0x90>
    1197:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    119b:	74 73                	je     1210 <printint+0x90>
    neg = 1;
    x = -xx;
    119d:	f7 d8                	neg    %eax
    neg = 1;
    119f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    11a6:	31 f6                	xor    %esi,%esi
    11a8:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    11ab:	eb 05                	jmp    11b2 <printint+0x32>
    11ad:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    11b0:	89 fe                	mov    %edi,%esi
    11b2:	31 d2                	xor    %edx,%edx
    11b4:	f7 f1                	div    %ecx
    11b6:	8d 7e 01             	lea    0x1(%esi),%edi
    11b9:	0f b6 92 b0 16 00 00 	movzbl 0x16b0(%edx),%edx
  }while((x /= base) != 0);
    11c0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    11c2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    11c5:	75 e9                	jne    11b0 <printint+0x30>
  if(neg)
    11c7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    11ca:	85 d2                	test   %edx,%edx
    11cc:	74 08                	je     11d6 <printint+0x56>
    buf[i++] = '-';
    11ce:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    11d3:	8d 7e 02             	lea    0x2(%esi),%edi
    11d6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    11da:	8b 7d c0             	mov    -0x40(%ebp),%edi
    11dd:	8d 76 00             	lea    0x0(%esi),%esi
    11e0:	0f b6 06             	movzbl (%esi),%eax
    11e3:	4e                   	dec    %esi
  write(fd, &c, 1);
    11e4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    11e8:	89 3c 24             	mov    %edi,(%esp)
    11eb:	88 45 d7             	mov    %al,-0x29(%ebp)
    11ee:	b8 01 00 00 00       	mov    $0x1,%eax
    11f3:	89 44 24 08          	mov    %eax,0x8(%esp)
    11f7:	e8 dc fe ff ff       	call   10d8 <write>

  while(--i >= 0)
    11fc:	39 de                	cmp    %ebx,%esi
    11fe:	75 e0                	jne    11e0 <printint+0x60>
    putc(fd, buf[i]);
}
    1200:	83 c4 4c             	add    $0x4c,%esp
    1203:	5b                   	pop    %ebx
    1204:	5e                   	pop    %esi
    1205:	5f                   	pop    %edi
    1206:	5d                   	pop    %ebp
    1207:	c3                   	ret    
    1208:	90                   	nop
    1209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1210:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1217:	eb 8d                	jmp    11a6 <printint+0x26>
    1219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001220 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1220:	55                   	push   %ebp
    1221:	89 e5                	mov    %esp,%ebp
    1223:	57                   	push   %edi
    1224:	56                   	push   %esi
    1225:	53                   	push   %ebx
    1226:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1229:	8b 75 0c             	mov    0xc(%ebp),%esi
    122c:	0f b6 1e             	movzbl (%esi),%ebx
    122f:	84 db                	test   %bl,%bl
    1231:	0f 84 d1 00 00 00    	je     1308 <printf+0xe8>
  state = 0;
    1237:	31 ff                	xor    %edi,%edi
    1239:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
    123a:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
    123d:	89 fa                	mov    %edi,%edx
    123f:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
    1242:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1245:	eb 41                	jmp    1288 <printf+0x68>
    1247:	89 f6                	mov    %esi,%esi
    1249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1250:	83 f8 25             	cmp    $0x25,%eax
    1253:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
    1256:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    125b:	74 1e                	je     127b <printf+0x5b>
  write(fd, &c, 1);
    125d:	b8 01 00 00 00       	mov    $0x1,%eax
    1262:	89 44 24 08          	mov    %eax,0x8(%esp)
    1266:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1269:	89 44 24 04          	mov    %eax,0x4(%esp)
    126d:	89 3c 24             	mov    %edi,(%esp)
    1270:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    1273:	e8 60 fe ff ff       	call   10d8 <write>
    1278:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    127b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
    127c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    1280:	84 db                	test   %bl,%bl
    1282:	0f 84 80 00 00 00    	je     1308 <printf+0xe8>
    if(state == 0){
    1288:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
    128a:	0f be cb             	movsbl %bl,%ecx
    128d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1290:	74 be                	je     1250 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1292:	83 fa 25             	cmp    $0x25,%edx
    1295:	75 e4                	jne    127b <printf+0x5b>
      if(c == 'd'){
    1297:	83 f8 64             	cmp    $0x64,%eax
    129a:	0f 84 f0 00 00 00    	je     1390 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    12a0:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    12a6:	83 f9 70             	cmp    $0x70,%ecx
    12a9:	74 65                	je     1310 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    12ab:	83 f8 73             	cmp    $0x73,%eax
    12ae:	0f 84 8c 00 00 00    	je     1340 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    12b4:	83 f8 63             	cmp    $0x63,%eax
    12b7:	0f 84 13 01 00 00    	je     13d0 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    12bd:	83 f8 25             	cmp    $0x25,%eax
    12c0:	0f 84 e2 00 00 00    	je     13a8 <printf+0x188>
  write(fd, &c, 1);
    12c6:	b8 01 00 00 00       	mov    $0x1,%eax
    12cb:	46                   	inc    %esi
    12cc:	89 44 24 08          	mov    %eax,0x8(%esp)
    12d0:	8d 45 e7             	lea    -0x19(%ebp),%eax
    12d3:	89 44 24 04          	mov    %eax,0x4(%esp)
    12d7:	89 3c 24             	mov    %edi,(%esp)
    12da:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    12de:	e8 f5 fd ff ff       	call   10d8 <write>
    12e3:	ba 01 00 00 00       	mov    $0x1,%edx
    12e8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    12eb:	89 54 24 08          	mov    %edx,0x8(%esp)
    12ef:	89 44 24 04          	mov    %eax,0x4(%esp)
    12f3:	89 3c 24             	mov    %edi,(%esp)
    12f6:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    12f9:	e8 da fd ff ff       	call   10d8 <write>
  for(i = 0; fmt[i]; i++){
    12fe:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1302:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    1304:	84 db                	test   %bl,%bl
    1306:	75 80                	jne    1288 <printf+0x68>
    }
  }
}
    1308:	83 c4 3c             	add    $0x3c,%esp
    130b:	5b                   	pop    %ebx
    130c:	5e                   	pop    %esi
    130d:	5f                   	pop    %edi
    130e:	5d                   	pop    %ebp
    130f:	c3                   	ret    
        printint(fd, *ap, 16, 0);
    1310:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1317:	b9 10 00 00 00       	mov    $0x10,%ecx
    131c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    131f:	89 f8                	mov    %edi,%eax
    1321:	8b 13                	mov    (%ebx),%edx
    1323:	e8 58 fe ff ff       	call   1180 <printint>
        ap++;
    1328:	89 d8                	mov    %ebx,%eax
      state = 0;
    132a:	31 d2                	xor    %edx,%edx
        ap++;
    132c:	83 c0 04             	add    $0x4,%eax
    132f:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1332:	e9 44 ff ff ff       	jmp    127b <printf+0x5b>
    1337:	89 f6                	mov    %esi,%esi
    1339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
    1340:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1343:	8b 10                	mov    (%eax),%edx
        ap++;
    1345:	83 c0 04             	add    $0x4,%eax
    1348:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    134b:	85 d2                	test   %edx,%edx
    134d:	0f 84 aa 00 00 00    	je     13fd <printf+0x1dd>
        while(*s != 0){
    1353:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
    1356:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
    1358:	84 c0                	test   %al,%al
    135a:	74 27                	je     1383 <printf+0x163>
    135c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1360:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    1363:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
    1368:	43                   	inc    %ebx
  write(fd, &c, 1);
    1369:	89 44 24 08          	mov    %eax,0x8(%esp)
    136d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    1370:	89 44 24 04          	mov    %eax,0x4(%esp)
    1374:	89 3c 24             	mov    %edi,(%esp)
    1377:	e8 5c fd ff ff       	call   10d8 <write>
        while(*s != 0){
    137c:	0f b6 03             	movzbl (%ebx),%eax
    137f:	84 c0                	test   %al,%al
    1381:	75 dd                	jne    1360 <printf+0x140>
      state = 0;
    1383:	31 d2                	xor    %edx,%edx
    1385:	e9 f1 fe ff ff       	jmp    127b <printf+0x5b>
    138a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    1390:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1397:	b9 0a 00 00 00       	mov    $0xa,%ecx
    139c:	e9 7b ff ff ff       	jmp    131c <printf+0xfc>
    13a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
    13a8:	b9 01 00 00 00       	mov    $0x1,%ecx
    13ad:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    13b0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    13b4:	89 44 24 04          	mov    %eax,0x4(%esp)
    13b8:	89 3c 24             	mov    %edi,(%esp)
    13bb:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    13be:	e8 15 fd ff ff       	call   10d8 <write>
      state = 0;
    13c3:	31 d2                	xor    %edx,%edx
    13c5:	e9 b1 fe ff ff       	jmp    127b <printf+0x5b>
    13ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
    13d0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    13d3:	8b 03                	mov    (%ebx),%eax
        ap++;
    13d5:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    13d8:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
    13db:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    13de:	b8 01 00 00 00       	mov    $0x1,%eax
    13e3:	89 44 24 08          	mov    %eax,0x8(%esp)
    13e7:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    13ea:	89 44 24 04          	mov    %eax,0x4(%esp)
    13ee:	e8 e5 fc ff ff       	call   10d8 <write>
      state = 0;
    13f3:	31 d2                	xor    %edx,%edx
        ap++;
    13f5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    13f8:	e9 7e fe ff ff       	jmp    127b <printf+0x5b>
          s = "(null)";
    13fd:	bb a8 16 00 00       	mov    $0x16a8,%ebx
        while(*s != 0){
    1402:	b0 28                	mov    $0x28,%al
    1404:	e9 57 ff ff ff       	jmp    1360 <printf+0x140>
    1409:	66 90                	xchg   %ax,%ax
    140b:	66 90                	xchg   %ax,%ax
    140d:	66 90                	xchg   %ax,%ax
    140f:	90                   	nop

00001410 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1410:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1411:	a1 d4 1e 00 00       	mov    0x1ed4,%eax
{
    1416:	89 e5                	mov    %esp,%ebp
    1418:	57                   	push   %edi
    1419:	56                   	push   %esi
    141a:	53                   	push   %ebx
    141b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    141e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1421:	eb 0d                	jmp    1430 <free+0x20>
    1423:	90                   	nop
    1424:	90                   	nop
    1425:	90                   	nop
    1426:	90                   	nop
    1427:	90                   	nop
    1428:	90                   	nop
    1429:	90                   	nop
    142a:	90                   	nop
    142b:	90                   	nop
    142c:	90                   	nop
    142d:	90                   	nop
    142e:	90                   	nop
    142f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1430:	39 c8                	cmp    %ecx,%eax
    1432:	8b 10                	mov    (%eax),%edx
    1434:	73 32                	jae    1468 <free+0x58>
    1436:	39 d1                	cmp    %edx,%ecx
    1438:	72 04                	jb     143e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    143a:	39 d0                	cmp    %edx,%eax
    143c:	72 32                	jb     1470 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
    143e:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1441:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1444:	39 fa                	cmp    %edi,%edx
    1446:	74 30                	je     1478 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1448:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    144b:	8b 50 04             	mov    0x4(%eax),%edx
    144e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1451:	39 f1                	cmp    %esi,%ecx
    1453:	74 3c                	je     1491 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1455:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
    1457:	5b                   	pop    %ebx
  freep = p;
    1458:	a3 d4 1e 00 00       	mov    %eax,0x1ed4
}
    145d:	5e                   	pop    %esi
    145e:	5f                   	pop    %edi
    145f:	5d                   	pop    %ebp
    1460:	c3                   	ret    
    1461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1468:	39 d0                	cmp    %edx,%eax
    146a:	72 04                	jb     1470 <free+0x60>
    146c:	39 d1                	cmp    %edx,%ecx
    146e:	72 ce                	jb     143e <free+0x2e>
{
    1470:	89 d0                	mov    %edx,%eax
    1472:	eb bc                	jmp    1430 <free+0x20>
    1474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1478:	8b 7a 04             	mov    0x4(%edx),%edi
    147b:	01 fe                	add    %edi,%esi
    147d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1480:	8b 10                	mov    (%eax),%edx
    1482:	8b 12                	mov    (%edx),%edx
    1484:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1487:	8b 50 04             	mov    0x4(%eax),%edx
    148a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    148d:	39 f1                	cmp    %esi,%ecx
    148f:	75 c4                	jne    1455 <free+0x45>
    p->s.size += bp->s.size;
    1491:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
    1494:	a3 d4 1e 00 00       	mov    %eax,0x1ed4
    p->s.size += bp->s.size;
    1499:	01 ca                	add    %ecx,%edx
    149b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    149e:	8b 53 f8             	mov    -0x8(%ebx),%edx
    14a1:	89 10                	mov    %edx,(%eax)
}
    14a3:	5b                   	pop    %ebx
    14a4:	5e                   	pop    %esi
    14a5:	5f                   	pop    %edi
    14a6:	5d                   	pop    %ebp
    14a7:	c3                   	ret    
    14a8:	90                   	nop
    14a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000014b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    14b0:	55                   	push   %ebp
    14b1:	89 e5                	mov    %esp,%ebp
    14b3:	57                   	push   %edi
    14b4:	56                   	push   %esi
    14b5:	53                   	push   %ebx
    14b6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    14b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    14bc:	8b 15 d4 1e 00 00    	mov    0x1ed4,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    14c2:	8d 78 07             	lea    0x7(%eax),%edi
    14c5:	c1 ef 03             	shr    $0x3,%edi
    14c8:	47                   	inc    %edi
  if((prevp = freep) == 0){
    14c9:	85 d2                	test   %edx,%edx
    14cb:	0f 84 8f 00 00 00    	je     1560 <malloc+0xb0>
    14d1:	8b 02                	mov    (%edx),%eax
    14d3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    14d6:	39 cf                	cmp    %ecx,%edi
    14d8:	76 66                	jbe    1540 <malloc+0x90>
    14da:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    14e0:	bb 00 10 00 00       	mov    $0x1000,%ebx
    14e5:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    14e8:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    14ef:	eb 10                	jmp    1501 <malloc+0x51>
    14f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    14f8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    14fa:	8b 48 04             	mov    0x4(%eax),%ecx
    14fd:	39 f9                	cmp    %edi,%ecx
    14ff:	73 3f                	jae    1540 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1501:	39 05 d4 1e 00 00    	cmp    %eax,0x1ed4
    1507:	89 c2                	mov    %eax,%edx
    1509:	75 ed                	jne    14f8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    150b:	89 34 24             	mov    %esi,(%esp)
    150e:	e8 2d fc ff ff       	call   1140 <sbrk>
  if(p == (char*)-1)
    1513:	83 f8 ff             	cmp    $0xffffffff,%eax
    1516:	74 18                	je     1530 <malloc+0x80>
  hp->s.size = nu;
    1518:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    151b:	83 c0 08             	add    $0x8,%eax
    151e:	89 04 24             	mov    %eax,(%esp)
    1521:	e8 ea fe ff ff       	call   1410 <free>
  return freep;
    1526:	8b 15 d4 1e 00 00    	mov    0x1ed4,%edx
      if((p = morecore(nunits)) == 0)
    152c:	85 d2                	test   %edx,%edx
    152e:	75 c8                	jne    14f8 <malloc+0x48>
        return 0;
  }
}
    1530:	83 c4 1c             	add    $0x1c,%esp
        return 0;
    1533:	31 c0                	xor    %eax,%eax
}
    1535:	5b                   	pop    %ebx
    1536:	5e                   	pop    %esi
    1537:	5f                   	pop    %edi
    1538:	5d                   	pop    %ebp
    1539:	c3                   	ret    
    153a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1540:	39 cf                	cmp    %ecx,%edi
    1542:	74 4c                	je     1590 <malloc+0xe0>
        p->s.size -= nunits;
    1544:	29 f9                	sub    %edi,%ecx
    1546:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1549:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    154c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    154f:	89 15 d4 1e 00 00    	mov    %edx,0x1ed4
}
    1555:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
    1558:	83 c0 08             	add    $0x8,%eax
}
    155b:	5b                   	pop    %ebx
    155c:	5e                   	pop    %esi
    155d:	5f                   	pop    %edi
    155e:	5d                   	pop    %ebp
    155f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    1560:	b8 d8 1e 00 00       	mov    $0x1ed8,%eax
    1565:	ba d8 1e 00 00       	mov    $0x1ed8,%edx
    base.s.size = 0;
    156a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
    156c:	a3 d4 1e 00 00       	mov    %eax,0x1ed4
    base.s.size = 0;
    1571:	b8 d8 1e 00 00       	mov    $0x1ed8,%eax
    base.s.ptr = freep = prevp = &base;
    1576:	89 15 d8 1e 00 00    	mov    %edx,0x1ed8
    base.s.size = 0;
    157c:	89 0d dc 1e 00 00    	mov    %ecx,0x1edc
    1582:	e9 53 ff ff ff       	jmp    14da <malloc+0x2a>
    1587:	89 f6                	mov    %esi,%esi
    1589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
    1590:	8b 08                	mov    (%eax),%ecx
    1592:	89 0a                	mov    %ecx,(%edx)
    1594:	eb b9                	jmp    154f <malloc+0x9f>
