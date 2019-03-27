
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
       3:	56                   	push   %esi
       4:	53                   	push   %ebx
       5:	83 e4 f0             	and    $0xfffffff0,%esp
       8:	83 ec 10             	sub    $0x10,%esp
    //static char buf[100];
    char* buf = (char*)malloc(8000);
       b:	c7 04 24 40 1f 00 00 	movl   $0x1f40,(%esp)
      12:	e8 49 15 00 00       	call   1560 <malloc>
      17:	89 c3                	mov    %eax,%ebx
    int fd;

    // Ensure that three file descriptors are open.
    while((fd = open("console", O_RDWR)) >= 0){
      19:	eb 0e                	jmp    29 <main+0x29>
      1b:	90                   	nop
      1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(fd >= 3){
      20:	83 f8 02             	cmp    $0x2,%eax
      23:	0f 8f be 00 00 00    	jg     e7 <main+0xe7>
    while((fd = open("console", O_RDWR)) >= 0){
      29:	b9 02 00 00 00       	mov    $0x2,%ecx
      2e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
      32:	c7 04 24 fd 16 00 00 	movl   $0x16fd,(%esp)
      39:	e8 6a 11 00 00       	call   11a8 <open>
      3e:	85 c0                	test   %eax,%eax
      40:	79 de                	jns    20 <main+0x20>


    // from here
    int fd2;

    if((fd2 = open("path", O_RDWR)) >= 0){
      42:	ba 02 00 00 00       	mov    $0x2,%edx
      47:	89 54 24 04          	mov    %edx,0x4(%esp)
      4b:	c7 04 24 05 17 00 00 	movl   $0x1705,(%esp)
      52:	e8 51 11 00 00       	call   11a8 <open>
      57:	85 c0                	test   %eax,%eax
      59:	0f 89 96 00 00 00    	jns    f5 <main+0xf5>
    // Read and run input commands.
    while(getcmd(buf, sizeof(buf)) >= 0){
        if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
            // Chdir must be called by the parent, not the child.
            buf[strlen(buf)-1] = 0;  // chop \n
            if(chdir(buf+3) < 0)
      5f:	8d 73 03             	lea    0x3(%ebx),%esi
      62:	eb 26                	jmp    8a <main+0x8a>
      64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
fork1(void)
{
    int pid;

    pid = fork();
      68:	e8 f3 10 00 00       	call   1160 <fork>
    if(pid == -1)
      6d:	83 f8 ff             	cmp    $0xffffffff,%eax
      70:	0f 84 cb 00 00 00    	je     141 <main+0x141>
        if(fork1() == 0)
      76:	85 c0                	test   %eax,%eax
      78:	0f 84 cf 00 00 00    	je     14d <main+0x14d>
        wait(0);
      7e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      85:	e8 e6 10 00 00       	call   1170 <wait>
    while(getcmd(buf, sizeof(buf)) >= 0){
      8a:	b8 04 00 00 00       	mov    $0x4,%eax
      8f:	89 44 24 04          	mov    %eax,0x4(%esp)
      93:	89 1c 24             	mov    %ebx,(%esp)
      96:	e8 65 03 00 00       	call   400 <getcmd>
      9b:	85 c0                	test   %eax,%eax
      9d:	0f 88 92 00 00 00    	js     135 <main+0x135>
        if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      a3:	80 3b 63             	cmpb   $0x63,(%ebx)
      a6:	75 c0                	jne    68 <main+0x68>
      a8:	80 7b 01 64          	cmpb   $0x64,0x1(%ebx)
      ac:	75 ba                	jne    68 <main+0x68>
      ae:	80 7b 02 20          	cmpb   $0x20,0x2(%ebx)
      b2:	75 b4                	jne    68 <main+0x68>
            buf[strlen(buf)-1] = 0;  // chop \n
      b4:	89 1c 24             	mov    %ebx,(%esp)
      b7:	e8 e4 0e 00 00       	call   fa0 <strlen>
      bc:	c6 44 03 ff 00       	movb   $0x0,-0x1(%ebx,%eax,1)
            if(chdir(buf+3) < 0)
      c1:	89 34 24             	mov    %esi,(%esp)
      c4:	e8 0f 11 00 00       	call   11d8 <chdir>
      c9:	85 c0                	test   %eax,%eax
      cb:	79 bd                	jns    8a <main+0x8a>
                printf(2, "cannot cd %s\n", buf+3);
      cd:	89 74 24 08          	mov    %esi,0x8(%esp)
      d1:	c7 44 24 04 0a 17 00 	movl   $0x170a,0x4(%esp)
      d8:	00 
      d9:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      e0:	e8 eb 11 00 00       	call   12d0 <printf>
      e5:	eb a3                	jmp    8a <main+0x8a>
            close(fd);
      e7:	89 04 24             	mov    %eax,(%esp)
      ea:	e8 a1 10 00 00       	call   1190 <close>
      ef:	90                   	nop
            break;
      f0:	e9 4d ff ff ff       	jmp    42 <main+0x42>
        if( read(fd2, PATH, sizeof(PATH)) < 0 ){
      f5:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
      fc:	00 
      fd:	c7 44 24 04 40 1e 00 	movl   $0x1e40,0x4(%esp)
     104:	00 
     105:	89 04 24             	mov    %eax,(%esp)
     108:	e8 73 10 00 00       	call   1180 <read>
     10d:	85 c0                	test   %eax,%eax
     10f:	0f 89 4a ff ff ff    	jns    5f <main+0x5f>
            printf(1, "error: read from path file failed\n");
     115:	c7 44 24 04 48 17 00 	movl   $0x1748,0x4(%esp)
     11c:	00 
     11d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     124:	e8 a7 11 00 00       	call   12d0 <printf>
            exit(0);
     129:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     130:	e8 33 10 00 00       	call   1168 <exit>
    exit(0);
     135:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     13c:	e8 27 10 00 00       	call   1168 <exit>
        panic("fork");
     141:	c7 04 24 86 16 00 00 	movl   $0x1686,(%esp)
     148:	e8 13 03 00 00       	call   460 <panic>
            runcmd(parsecmd(buf));
     14d:	89 1c 24             	mov    %ebx,(%esp)
     150:	e8 6b 0d 00 00       	call   ec0 <parsecmd>
     155:	89 04 24             	mov    %eax,(%esp)
     158:	e8 33 03 00 00       	call   490 <runcmd>
     15d:	66 90                	xchg   %ax,%ax
     15f:	90                   	nop

00000160 <swap>:
{
     160:	55                   	push   %ebp
     161:	89 e5                	mov    %esp,%ebp
     163:	8b 45 10             	mov    0x10(%ebp),%eax
     166:	53                   	push   %ebx
    char temp = str[a];
     167:	8b 55 08             	mov    0x8(%ebp),%edx
    str[a] = str[b];
     16a:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    char temp = str[a];
     16d:	01 c2                	add    %eax,%edx
    str[a] = str[b];
     16f:	01 d8                	add    %ebx,%eax
    char temp = str[a];
     171:	0f b6 0a             	movzbl (%edx),%ecx
    str[a] = str[b];
     174:	0f b6 18             	movzbl (%eax),%ebx
     177:	88 1a                	mov    %bl,(%edx)
    str[b] = temp;
     179:	88 08                	mov    %cl,(%eax)
}
     17b:	5b                   	pop    %ebx
     17c:	5d                   	pop    %ebp
     17d:	c3                   	ret    
     17e:	66 90                	xchg   %ax,%ax

00000180 <reverse_string>:
{
     180:	55                   	push   %ebp
     181:	89 e5                	mov    %esp,%ebp
     183:	57                   	push   %edi
     184:	56                   	push   %esi
     185:	53                   	push   %ebx
     186:	83 ec 2c             	sub    $0x2c,%esp
     189:	8b 5d 08             	mov    0x8(%ebp),%ebx
    int len = strlen( str ) - 1;
     18c:	89 1c 24             	mov    %ebx,(%esp)
     18f:	e8 0c 0e 00 00       	call   fa0 <strlen>
     194:	8d 70 ff             	lea    -0x1(%eax),%esi
    for( i = 0 ; i < len ; i++ )
     197:	85 f6                	test   %esi,%esi
     199:	7e 43                	jle    1de <reverse_string+0x5e>
    str[a] = str[b];
     19b:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
    char temp = str[a];
     19e:	0f b6 13             	movzbl (%ebx),%edx
        k--;
     1a1:	83 e8 02             	sub    $0x2,%eax
    str[a] = str[b];
     1a4:	0f b6 0f             	movzbl (%edi),%ecx
        if( k == len/2 )
     1a7:	d1 fe                	sar    %esi
     1a9:	39 f0                	cmp    %esi,%eax
    str[a] = str[b];
     1ab:	88 0b                	mov    %cl,(%ebx)
    str[b] = temp;
     1ad:	88 17                	mov    %dl,(%edi)
        if( k == len/2 )
     1af:	74 2d                	je     1de <reverse_string+0x5e>
     1b1:	8d 53 01             	lea    0x1(%ebx),%edx
     1b4:	eb 24                	jmp    1da <reverse_string+0x5a>
     1b6:	8d 76 00             	lea    0x0(%esi),%esi
     1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    char temp = str[a];
     1c0:	0f b6 0a             	movzbl (%edx),%ecx
     1c3:	42                   	inc    %edx
     1c4:	88 4d e7             	mov    %cl,-0x19(%ebp)
    str[a] = str[b];
     1c7:	0f b6 0c 03          	movzbl (%ebx,%eax,1),%ecx
     1cb:	88 4a ff             	mov    %cl,-0x1(%edx)
    str[b] = temp;
     1ce:	0f b6 4d e7          	movzbl -0x19(%ebp),%ecx
     1d2:	88 0c 03             	mov    %cl,(%ebx,%eax,1)
        k--;
     1d5:	48                   	dec    %eax
        if( k == len/2 )
     1d6:	39 f0                	cmp    %esi,%eax
     1d8:	74 04                	je     1de <reverse_string+0x5e>
    for( i = 0 ; i < len ; i++ )
     1da:	85 c0                	test   %eax,%eax
     1dc:	75 e2                	jne    1c0 <reverse_string+0x40>
}
     1de:	83 c4 2c             	add    $0x2c,%esp
     1e1:	5b                   	pop    %ebx
     1e2:	5e                   	pop    %esi
     1e3:	5f                   	pop    %edi
     1e4:	5d                   	pop    %ebp
     1e5:	c3                   	ret    
     1e6:	8d 76 00             	lea    0x0(%esi),%esi
     1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001f0 <strconcat>:
strconcat (const char *first, const char *second, char* dest){
     1f0:	55                   	push   %ebp
     1f1:	89 e5                	mov    %esp,%ebp
     1f3:	56                   	push   %esi
     1f4:	8b 75 10             	mov    0x10(%ebp),%esi
     1f7:	53                   	push   %ebx
     1f8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     1fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    while((*dest++ = *first++) != 0)
     1fe:	89 f2                	mov    %esi,%edx
     200:	43                   	inc    %ebx
     201:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
     205:	42                   	inc    %edx
     206:	84 c0                	test   %al,%al
     208:	88 42 ff             	mov    %al,-0x1(%edx)
     20b:	75 f3                	jne    200 <strconcat+0x10>
    while((*dest++ = *second++) != 0)
     20d:	41                   	inc    %ecx
     20e:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
     212:	84 c0                	test   %al,%al
     214:	88 42 ff             	mov    %al,-0x1(%edx)
     217:	74 14                	je     22d <strconcat+0x3d>
     219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     220:	41                   	inc    %ecx
     221:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
     225:	42                   	inc    %edx
     226:	84 c0                	test   %al,%al
     228:	88 42 ff             	mov    %al,-0x1(%edx)
     22b:	75 f3                	jne    220 <strconcat+0x30>
}
     22d:	5b                   	pop    %ebx
     22e:	89 f0                	mov    %esi,%eax
     230:	5e                   	pop    %esi
     231:	5d                   	pop    %ebp
     232:	c3                   	ret    
     233:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000240 <strcpyuntildelimiter>:
{
     240:	55                   	push   %ebp
     241:	89 e5                	mov    %esp,%ebp
     243:	8b 55 0c             	mov    0xc(%ebp),%edx
     246:	56                   	push   %esi
     247:	0f b6 45 10          	movzbl 0x10(%ebp),%eax
     24b:	53                   	push   %ebx
     24c:	8b 75 08             	mov    0x8(%ebp),%esi
    while((*s = *t) != delim && (*s = *t) !=0)
     24f:	0f b6 0a             	movzbl (%edx),%ecx
     252:	38 c8                	cmp    %cl,%al
     254:	88 0e                	mov    %cl,(%esi)
     256:	74 30                	je     288 <strcpyuntildelimiter+0x48>
     258:	0f b6 0a             	movzbl (%edx),%ecx
     25b:	84 c9                	test   %cl,%cl
     25d:	88 0e                	mov    %cl,(%esi)
     25f:	74 27                	je     288 <strcpyuntildelimiter+0x48>
     261:	89 f1                	mov    %esi,%ecx
     263:	eb 0c                	jmp    271 <strcpyuntildelimiter+0x31>
     265:	8d 76 00             	lea    0x0(%esi),%esi
     268:	0f b6 1a             	movzbl (%edx),%ebx
     26b:	84 db                	test   %bl,%bl
     26d:	88 19                	mov    %bl,(%ecx)
     26f:	74 0b                	je     27c <strcpyuntildelimiter+0x3c>
        s++,t++;
     271:	42                   	inc    %edx
    while((*s = *t) != delim && (*s = *t) !=0)
     272:	0f b6 1a             	movzbl (%edx),%ebx
        s++,t++;
     275:	41                   	inc    %ecx
    while((*s = *t) != delim && (*s = *t) !=0)
     276:	38 c3                	cmp    %al,%bl
     278:	88 19                	mov    %bl,(%ecx)
     27a:	75 ec                	jne    268 <strcpyuntildelimiter+0x28>
    *s='\0';
     27c:	c6 01 00             	movb   $0x0,(%ecx)
}
     27f:	89 f0                	mov    %esi,%eax
     281:	5b                   	pop    %ebx
     282:	5e                   	pop    %esi
     283:	5d                   	pop    %ebp
     284:	c3                   	ret    
     285:	8d 76 00             	lea    0x0(%esi),%esi
    while((*s = *t) != delim && (*s = *t) !=0)
     288:	89 f1                	mov    %esi,%ecx
}
     28a:	89 f0                	mov    %esi,%eax
    *s='\0';
     28c:	c6 01 00             	movb   $0x0,(%ecx)
}
     28f:	5b                   	pop    %ebx
     290:	5e                   	pop    %esi
     291:	5d                   	pop    %ebp
     292:	c3                   	ret    
     293:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002a0 <execWithPath>:
{
     2a0:	55                   	push   %ebp
     2a1:	89 e5                	mov    %esp,%ebp
     2a3:	57                   	push   %edi
     2a4:	56                   	push   %esi
     2a5:	53                   	push   %ebx
     2a6:	83 ec 1c             	sub    $0x1c,%esp
    char *curr_path = malloc(strlen(PATH));
     2a9:	c7 04 24 40 1e 00 00 	movl   $0x1e40,(%esp)
     2b0:	e8 eb 0c 00 00       	call   fa0 <strlen>
     2b5:	89 04 24             	mov    %eax,(%esp)
     2b8:	e8 a3 12 00 00       	call   1560 <malloc>
    strcpy( curr_path , PATH );
     2bd:	b9 40 1e 00 00       	mov    $0x1e40,%ecx
     2c2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    char *curr_path = malloc(strlen(PATH));
     2c6:	89 c3                	mov    %eax,%ebx
    strcpy( curr_path , PATH );
     2c8:	89 04 24             	mov    %eax,(%esp)
     2cb:	e8 70 0c 00 00       	call   f40 <strcpy>
    while( curr_path != NULL )
     2d0:	85 db                	test   %ebx,%ebx
     2d2:	0f 84 01 01 00 00    	je     3d9 <execWithPath+0x139>
     2d8:	90                   	nop
     2d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        char* str2= malloc(100);
     2e0:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
     2e7:	e8 74 12 00 00       	call   1560 <malloc>
     2ec:	89 c6                	mov    %eax,%esi
    while((*s = *t) != delim && (*s = *t) !=0)
     2ee:	0f b6 03             	movzbl (%ebx),%eax
     2f1:	3c 3a                	cmp    $0x3a,%al
     2f3:	88 06                	mov    %al,(%esi)
     2f5:	0f 84 fd 00 00 00    	je     3f8 <execWithPath+0x158>
     2fb:	0f b6 03             	movzbl (%ebx),%eax
     2fe:	84 c0                	test   %al,%al
     300:	88 06                	mov    %al,(%esi)
     302:	0f 84 f0 00 00 00    	je     3f8 <execWithPath+0x158>
     308:	89 d9                	mov    %ebx,%ecx
     30a:	89 f0                	mov    %esi,%eax
     30c:	eb 0b                	jmp    319 <execWithPath+0x79>
     30e:	66 90                	xchg   %ax,%ax
     310:	0f b6 11             	movzbl (%ecx),%edx
     313:	84 d2                	test   %dl,%dl
     315:	88 10                	mov    %dl,(%eax)
     317:	74 0c                	je     325 <execWithPath+0x85>
        s++,t++;
     319:	41                   	inc    %ecx
    while((*s = *t) != delim && (*s = *t) !=0)
     31a:	0f b6 11             	movzbl (%ecx),%edx
        s++,t++;
     31d:	40                   	inc    %eax
    while((*s = *t) != delim && (*s = *t) !=0)
     31e:	80 fa 3a             	cmp    $0x3a,%dl
     321:	88 10                	mov    %dl,(%eax)
     323:	75 eb                	jne    310 <execWithPath+0x70>
        curr_path=strchr(curr_path,':');
     325:	ba 3a 00 00 00       	mov    $0x3a,%edx
    *s='\0';
     32a:	c6 00 00             	movb   $0x0,(%eax)
        curr_path=strchr(curr_path,':');
     32d:	89 54 24 04          	mov    %edx,0x4(%esp)
     331:	89 1c 24             	mov    %ebx,(%esp)
     334:	e8 b7 0c 00 00       	call   ff0 <strchr>
        char* str3=malloc ((strlen(str2) + strlen(path) - 1));
     339:	89 34 24             	mov    %esi,(%esp)
            curr_path++;
     33c:	83 f8 01             	cmp    $0x1,%eax
        curr_path=strchr(curr_path,':');
     33f:	89 c3                	mov    %eax,%ebx
            curr_path++;
     341:	83 db ff             	sbb    $0xffffffff,%ebx
        char* str3=malloc ((strlen(str2) + strlen(path) - 1));
     344:	e8 57 0c 00 00       	call   fa0 <strlen>
     349:	89 c7                	mov    %eax,%edi
     34b:	8b 45 08             	mov    0x8(%ebp),%eax
     34e:	89 04 24             	mov    %eax,(%esp)
     351:	e8 4a 0c 00 00       	call   fa0 <strlen>
     356:	8d 44 07 ff          	lea    -0x1(%edi,%eax,1),%eax
     35a:	89 04 24             	mov    %eax,(%esp)
     35d:	e8 fe 11 00 00       	call   1560 <malloc>
     362:	89 f1                	mov    %esi,%ecx
     364:	89 c7                	mov    %eax,%edi
     366:	89 c2                	mov    %eax,%edx
     368:	90                   	nop
     369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while((*dest++ = *first++) != 0)
     370:	41                   	inc    %ecx
     371:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
     375:	42                   	inc    %edx
     376:	84 c0                	test   %al,%al
     378:	88 42 ff             	mov    %al,-0x1(%edx)
     37b:	75 f3                	jne    370 <execWithPath+0xd0>
     37d:	8b 4d 08             	mov    0x8(%ebp),%ecx
     380:	eb 07                	jmp    389 <execWithPath+0xe9>
     382:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     388:	42                   	inc    %edx
    while((*dest++ = *second++) != 0)
     389:	41                   	inc    %ecx
     38a:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
     38e:	84 c0                	test   %al,%al
     390:	88 42 ff             	mov    %al,-0x1(%edx)
     393:	75 f3                	jne    388 <execWithPath+0xe8>
        printf(3,"str3= %s \tstr2= %s\n",str3,str2);
     395:	b8 48 16 00 00       	mov    $0x1648,%eax
     39a:	89 44 24 04          	mov    %eax,0x4(%esp)
     39e:	89 74 24 0c          	mov    %esi,0xc(%esp)
     3a2:	89 7c 24 08          	mov    %edi,0x8(%esp)
     3a6:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
     3ad:	e8 1e 0f 00 00       	call   12d0 <printf>
        exec( str3 , argv );
     3b2:	8b 45 0c             	mov    0xc(%ebp),%eax
     3b5:	89 3c 24             	mov    %edi,(%esp)
     3b8:	89 44 24 04          	mov    %eax,0x4(%esp)
     3bc:	e8 df 0d 00 00       	call   11a0 <exec>
        free(str2);
     3c1:	89 34 24             	mov    %esi,(%esp)
     3c4:	e8 f7 10 00 00       	call   14c0 <free>
        free(str3);
     3c9:	89 3c 24             	mov    %edi,(%esp)
     3cc:	e8 ef 10 00 00       	call   14c0 <free>
    while( curr_path != NULL )
     3d1:	85 db                	test   %ebx,%ebx
     3d3:	0f 85 07 ff ff ff    	jne    2e0 <execWithPath+0x40>
    free(curr_path);
     3d9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     3e0:	e8 db 10 00 00       	call   14c0 <free>
}
     3e5:	83 c4 1c             	add    $0x1c,%esp
     3e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     3ed:	5b                   	pop    %ebx
     3ee:	5e                   	pop    %esi
     3ef:	5f                   	pop    %edi
     3f0:	5d                   	pop    %ebp
     3f1:	c3                   	ret    
     3f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while((*s = *t) != delim && (*s = *t) !=0)
     3f8:	89 f0                	mov    %esi,%eax
     3fa:	e9 26 ff ff ff       	jmp    325 <execWithPath+0x85>
     3ff:	90                   	nop

00000400 <getcmd>:
{
     400:	55                   	push   %ebp
    printf(2, "$ ");
     401:	b8 5c 16 00 00       	mov    $0x165c,%eax
{
     406:	89 e5                	mov    %esp,%ebp
     408:	83 ec 18             	sub    $0x18,%esp
     40b:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     40e:	8b 5d 08             	mov    0x8(%ebp),%ebx
     411:	89 75 fc             	mov    %esi,-0x4(%ebp)
     414:	8b 75 0c             	mov    0xc(%ebp),%esi
    printf(2, "$ ");
     417:	89 44 24 04          	mov    %eax,0x4(%esp)
     41b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     422:	e8 a9 0e 00 00       	call   12d0 <printf>
    memset(buf, 0, nbuf);
     427:	31 d2                	xor    %edx,%edx
     429:	89 74 24 08          	mov    %esi,0x8(%esp)
     42d:	89 54 24 04          	mov    %edx,0x4(%esp)
     431:	89 1c 24             	mov    %ebx,(%esp)
     434:	e8 97 0b 00 00       	call   fd0 <memset>
    gets(buf, nbuf);
     439:	89 74 24 04          	mov    %esi,0x4(%esp)
     43d:	89 1c 24             	mov    %ebx,(%esp)
     440:	e8 db 0b 00 00       	call   1020 <gets>
    if(buf[0] == 0) // EOF
     445:	31 c0                	xor    %eax,%eax
}
     447:	8b 75 fc             	mov    -0x4(%ebp),%esi
    if(buf[0] == 0) // EOF
     44a:	80 3b 00             	cmpb   $0x0,(%ebx)
}
     44d:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    if(buf[0] == 0) // EOF
     450:	0f 94 c0             	sete   %al
}
     453:	89 ec                	mov    %ebp,%esp
    if(buf[0] == 0) // EOF
     455:	f7 d8                	neg    %eax
}
     457:	5d                   	pop    %ebp
     458:	c3                   	ret    
     459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000460 <panic>:
{
     460:	55                   	push   %ebp
     461:	89 e5                	mov    %esp,%ebp
     463:	83 ec 18             	sub    $0x18,%esp
    printf(2, "%s\n", s);
     466:	8b 45 08             	mov    0x8(%ebp),%eax
     469:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     470:	89 44 24 08          	mov    %eax,0x8(%esp)
     474:	b8 f9 16 00 00       	mov    $0x16f9,%eax
     479:	89 44 24 04          	mov    %eax,0x4(%esp)
     47d:	e8 4e 0e 00 00       	call   12d0 <printf>
    exit(0);
     482:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     489:	e8 da 0c 00 00       	call   1168 <exit>
     48e:	66 90                	xchg   %ax,%ax

00000490 <runcmd>:
{
     490:	55                   	push   %ebp
     491:	89 e5                	mov    %esp,%ebp
     493:	56                   	push   %esi
     494:	53                   	push   %ebx
     495:	83 ec 20             	sub    $0x20,%esp
     498:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(cmd == 0)
     49b:	85 db                	test   %ebx,%ebx
     49d:	74 51                	je     4f0 <runcmd+0x60>
    switch(cmd->type){
     49f:	83 3b 05             	cmpl   $0x5,(%ebx)
     4a2:	0f 87 4a 01 00 00    	ja     5f2 <runcmd+0x162>
     4a8:	8b 03                	mov    (%ebx),%eax
     4aa:	ff 24 85 18 17 00 00 	jmp    *0x1718(,%eax,4)
            close(rcmd->fd);
     4b1:	8b 43 14             	mov    0x14(%ebx),%eax
     4b4:	89 04 24             	mov    %eax,(%esp)
     4b7:	e8 d4 0c 00 00       	call   1190 <close>
            if(open(rcmd->file, rcmd->mode) < 0){
     4bc:	8b 43 10             	mov    0x10(%ebx),%eax
     4bf:	89 44 24 04          	mov    %eax,0x4(%esp)
     4c3:	8b 43 08             	mov    0x8(%ebx),%eax
     4c6:	89 04 24             	mov    %eax,(%esp)
     4c9:	e8 da 0c 00 00       	call   11a8 <open>
     4ce:	85 c0                	test   %eax,%eax
     4d0:	79 3c                	jns    50e <runcmd+0x7e>
                printf(2, "open %s failed\n", rcmd->file);
     4d2:	8b 43 08             	mov    0x8(%ebx),%eax
     4d5:	c7 44 24 04 76 16 00 	movl   $0x1676,0x4(%esp)
     4dc:	00 
     4dd:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     4e4:	89 44 24 08          	mov    %eax,0x8(%esp)
     4e8:	e8 e3 0d 00 00       	call   12d0 <printf>
     4ed:	8d 76 00             	lea    0x0(%esi),%esi
                exit(0);
     4f0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     4f7:	e8 6c 0c 00 00       	call   1168 <exit>
    pid = fork();
     4fc:	e8 5f 0c 00 00       	call   1160 <fork>
    if(pid == -1)
     501:	83 f8 ff             	cmp    $0xffffffff,%eax
     504:	0f 84 f4 00 00 00    	je     5fe <runcmd+0x16e>
            if(fork1() == 0)
     50a:	85 c0                	test   %eax,%eax
     50c:	75 e2                	jne    4f0 <runcmd+0x60>
                runcmd(bcmd->cmd);
     50e:	8b 43 04             	mov    0x4(%ebx),%eax
     511:	89 04 24             	mov    %eax,(%esp)
     514:	e8 77 ff ff ff       	call   490 <runcmd>
            if(ecmd->argv[0] == 0)
     519:	8b 43 04             	mov    0x4(%ebx),%eax
     51c:	85 c0                	test   %eax,%eax
     51e:	74 d0                	je     4f0 <runcmd+0x60>
            exec(ecmd->argv[0], ecmd->argv);
     520:	8d 73 04             	lea    0x4(%ebx),%esi
     523:	89 74 24 04          	mov    %esi,0x4(%esp)
     527:	89 04 24             	mov    %eax,(%esp)
     52a:	e8 71 0c 00 00       	call   11a0 <exec>
            execWithPath(ecmd->argv[0], ecmd->argv);
     52f:	89 74 24 04          	mov    %esi,0x4(%esp)
     533:	8b 43 04             	mov    0x4(%ebx),%eax
     536:	89 04 24             	mov    %eax,(%esp)
     539:	e8 62 fd ff ff       	call   2a0 <execWithPath>
            printf(2, "exec %s failed\n", ecmd->argv[0]);
     53e:	8b 43 04             	mov    0x4(%ebx),%eax
     541:	c7 44 24 04 66 16 00 	movl   $0x1666,0x4(%esp)
     548:	00 
     549:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     550:	89 44 24 08          	mov    %eax,0x8(%esp)
     554:	e8 77 0d 00 00       	call   12d0 <printf>
            break;
     559:	eb 95                	jmp    4f0 <runcmd+0x60>
            if(pipe(p) < 0)
     55b:	8d 45 f0             	lea    -0x10(%ebp),%eax
     55e:	89 04 24             	mov    %eax,(%esp)
     561:	e8 12 0c 00 00       	call   1178 <pipe>
     566:	85 c0                	test   %eax,%eax
     568:	0f 88 d4 00 00 00    	js     642 <runcmd+0x1b2>
    pid = fork();
     56e:	e8 ed 0b 00 00       	call   1160 <fork>
    if(pid == -1)
     573:	83 f8 ff             	cmp    $0xffffffff,%eax
     576:	0f 84 82 00 00 00    	je     5fe <runcmd+0x16e>
            if(fork1() == 0){
     57c:	85 c0                	test   %eax,%eax
     57e:	66 90                	xchg   %ax,%ax
     580:	0f 84 c8 00 00 00    	je     64e <runcmd+0x1be>
    pid = fork();
     586:	e8 d5 0b 00 00       	call   1160 <fork>
    if(pid == -1)
     58b:	83 f8 ff             	cmp    $0xffffffff,%eax
     58e:	66 90                	xchg   %ax,%ax
     590:	74 6c                	je     5fe <runcmd+0x16e>
            if(fork1() == 0){
     592:	85 c0                	test   %eax,%eax
     594:	74 74                	je     60a <runcmd+0x17a>
            close(p[0]);
     596:	8b 45 f0             	mov    -0x10(%ebp),%eax
     599:	89 04 24             	mov    %eax,(%esp)
     59c:	e8 ef 0b 00 00       	call   1190 <close>
            close(p[1]);
     5a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5a4:	89 04 24             	mov    %eax,(%esp)
     5a7:	e8 e4 0b 00 00       	call   1190 <close>
            wait(0);
     5ac:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     5b3:	e8 b8 0b 00 00       	call   1170 <wait>
            wait(0);
     5b8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     5bf:	e8 ac 0b 00 00       	call   1170 <wait>
            break;
     5c4:	e9 27 ff ff ff       	jmp    4f0 <runcmd+0x60>
    pid = fork();
     5c9:	e8 92 0b 00 00       	call   1160 <fork>
    if(pid == -1)
     5ce:	83 f8 ff             	cmp    $0xffffffff,%eax
     5d1:	74 2b                	je     5fe <runcmd+0x16e>
            if(fork1() == 0)
     5d3:	85 c0                	test   %eax,%eax
     5d5:	0f 84 33 ff ff ff    	je     50e <runcmd+0x7e>
            wait(0);
     5db:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     5e2:	e8 89 0b 00 00       	call   1170 <wait>
            runcmd(lcmd->right);
     5e7:	8b 43 08             	mov    0x8(%ebx),%eax
     5ea:	89 04 24             	mov    %eax,(%esp)
     5ed:	e8 9e fe ff ff       	call   490 <runcmd>
            panic("runcmd");
     5f2:	c7 04 24 5f 16 00 00 	movl   $0x165f,(%esp)
     5f9:	e8 62 fe ff ff       	call   460 <panic>
        panic("fork");
     5fe:	c7 04 24 86 16 00 00 	movl   $0x1686,(%esp)
     605:	e8 56 fe ff ff       	call   460 <panic>
                close(0);
     60a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     611:	e8 7a 0b 00 00       	call   1190 <close>
                dup(p[0]);
     616:	8b 45 f0             	mov    -0x10(%ebp),%eax
     619:	89 04 24             	mov    %eax,(%esp)
     61c:	e8 bf 0b 00 00       	call   11e0 <dup>
                close(p[0]);
     621:	8b 45 f0             	mov    -0x10(%ebp),%eax
     624:	89 04 24             	mov    %eax,(%esp)
     627:	e8 64 0b 00 00       	call   1190 <close>
                close(p[1]);
     62c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     62f:	89 04 24             	mov    %eax,(%esp)
     632:	e8 59 0b 00 00       	call   1190 <close>
                runcmd(pcmd->right);
     637:	8b 43 08             	mov    0x8(%ebx),%eax
     63a:	89 04 24             	mov    %eax,(%esp)
     63d:	e8 4e fe ff ff       	call   490 <runcmd>
                panic("pipe");
     642:	c7 04 24 8b 16 00 00 	movl   $0x168b,(%esp)
     649:	e8 12 fe ff ff       	call   460 <panic>
                close(1);
     64e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     655:	e8 36 0b 00 00       	call   1190 <close>
                dup(p[1]);
     65a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     65d:	89 04 24             	mov    %eax,(%esp)
     660:	e8 7b 0b 00 00       	call   11e0 <dup>
                close(p[0]);
     665:	8b 45 f0             	mov    -0x10(%ebp),%eax
     668:	89 04 24             	mov    %eax,(%esp)
     66b:	e8 20 0b 00 00       	call   1190 <close>
                close(p[1]);
     670:	8b 45 f4             	mov    -0xc(%ebp),%eax
     673:	89 04 24             	mov    %eax,(%esp)
     676:	e8 15 0b 00 00       	call   1190 <close>
                runcmd(pcmd->left);
     67b:	8b 43 04             	mov    0x4(%ebx),%eax
     67e:	89 04 24             	mov    %eax,(%esp)
     681:	e8 0a fe ff ff       	call   490 <runcmd>
     686:	8d 76 00             	lea    0x0(%esi),%esi
     689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000690 <fork1>:
{
     690:	55                   	push   %ebp
     691:	89 e5                	mov    %esp,%ebp
     693:	83 ec 18             	sub    $0x18,%esp
    pid = fork();
     696:	e8 c5 0a 00 00       	call   1160 <fork>
    if(pid == -1)
     69b:	83 f8 ff             	cmp    $0xffffffff,%eax
     69e:	74 02                	je     6a2 <fork1+0x12>
    return pid;
}
     6a0:	c9                   	leave  
     6a1:	c3                   	ret    
        panic("fork");
     6a2:	c7 04 24 86 16 00 00 	movl   $0x1686,(%esp)
     6a9:	e8 b2 fd ff ff       	call   460 <panic>
     6ae:	66 90                	xchg   %ax,%ax

000006b0 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     6b0:	55                   	push   %ebp
     6b1:	89 e5                	mov    %esp,%ebp
     6b3:	53                   	push   %ebx
     6b4:	83 ec 14             	sub    $0x14,%esp
    struct execcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     6b7:	c7 04 24 54 00 00 00 	movl   $0x54,(%esp)
     6be:	e8 9d 0e 00 00       	call   1560 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     6c3:	31 d2                	xor    %edx,%edx
     6c5:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     6c9:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     6cb:	b8 54 00 00 00       	mov    $0x54,%eax
     6d0:	89 1c 24             	mov    %ebx,(%esp)
     6d3:	89 44 24 08          	mov    %eax,0x8(%esp)
     6d7:	e8 f4 08 00 00       	call   fd0 <memset>
    cmd->type = EXEC;
    return (struct cmd*)cmd;
}
     6dc:	89 d8                	mov    %ebx,%eax
    cmd->type = EXEC;
     6de:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
}
     6e4:	83 c4 14             	add    $0x14,%esp
     6e7:	5b                   	pop    %ebx
     6e8:	5d                   	pop    %ebp
     6e9:	c3                   	ret    
     6ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000006f0 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     6f0:	55                   	push   %ebp
     6f1:	89 e5                	mov    %esp,%ebp
     6f3:	53                   	push   %ebx
     6f4:	83 ec 14             	sub    $0x14,%esp
    struct redircmd *cmd;

    cmd = malloc(sizeof(*cmd));
     6f7:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
     6fe:	e8 5d 0e 00 00       	call   1560 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     703:	31 d2                	xor    %edx,%edx
     705:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     709:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     70b:	b8 18 00 00 00       	mov    $0x18,%eax
     710:	89 1c 24             	mov    %ebx,(%esp)
     713:	89 44 24 08          	mov    %eax,0x8(%esp)
     717:	e8 b4 08 00 00       	call   fd0 <memset>
    cmd->type = REDIR;
    cmd->cmd = subcmd;
     71c:	8b 45 08             	mov    0x8(%ebp),%eax
    cmd->type = REDIR;
     71f:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
    cmd->cmd = subcmd;
     725:	89 43 04             	mov    %eax,0x4(%ebx)
    cmd->file = file;
     728:	8b 45 0c             	mov    0xc(%ebp),%eax
     72b:	89 43 08             	mov    %eax,0x8(%ebx)
    cmd->efile = efile;
     72e:	8b 45 10             	mov    0x10(%ebp),%eax
     731:	89 43 0c             	mov    %eax,0xc(%ebx)
    cmd->mode = mode;
     734:	8b 45 14             	mov    0x14(%ebp),%eax
     737:	89 43 10             	mov    %eax,0x10(%ebx)
    cmd->fd = fd;
     73a:	8b 45 18             	mov    0x18(%ebp),%eax
     73d:	89 43 14             	mov    %eax,0x14(%ebx)
    return (struct cmd*)cmd;
}
     740:	83 c4 14             	add    $0x14,%esp
     743:	89 d8                	mov    %ebx,%eax
     745:	5b                   	pop    %ebx
     746:	5d                   	pop    %ebp
     747:	c3                   	ret    
     748:	90                   	nop
     749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000750 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     750:	55                   	push   %ebp
     751:	89 e5                	mov    %esp,%ebp
     753:	53                   	push   %ebx
     754:	83 ec 14             	sub    $0x14,%esp
    struct pipecmd *cmd;

    cmd = malloc(sizeof(*cmd));
     757:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     75e:	e8 fd 0d 00 00       	call   1560 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     763:	31 d2                	xor    %edx,%edx
     765:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     769:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     76b:	b8 0c 00 00 00       	mov    $0xc,%eax
     770:	89 1c 24             	mov    %ebx,(%esp)
     773:	89 44 24 08          	mov    %eax,0x8(%esp)
     777:	e8 54 08 00 00       	call   fd0 <memset>
    cmd->type = PIPE;
    cmd->left = left;
     77c:	8b 45 08             	mov    0x8(%ebp),%eax
    cmd->type = PIPE;
     77f:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
    cmd->left = left;
     785:	89 43 04             	mov    %eax,0x4(%ebx)
    cmd->right = right;
     788:	8b 45 0c             	mov    0xc(%ebp),%eax
     78b:	89 43 08             	mov    %eax,0x8(%ebx)
    return (struct cmd*)cmd;
}
     78e:	83 c4 14             	add    $0x14,%esp
     791:	89 d8                	mov    %ebx,%eax
     793:	5b                   	pop    %ebx
     794:	5d                   	pop    %ebp
     795:	c3                   	ret    
     796:	8d 76 00             	lea    0x0(%esi),%esi
     799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000007a0 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     7a0:	55                   	push   %ebp
     7a1:	89 e5                	mov    %esp,%ebp
     7a3:	53                   	push   %ebx
     7a4:	83 ec 14             	sub    $0x14,%esp
    struct listcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     7a7:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     7ae:	e8 ad 0d 00 00       	call   1560 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     7b3:	31 d2                	xor    %edx,%edx
     7b5:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     7b9:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     7bb:	b8 0c 00 00 00       	mov    $0xc,%eax
     7c0:	89 1c 24             	mov    %ebx,(%esp)
     7c3:	89 44 24 08          	mov    %eax,0x8(%esp)
     7c7:	e8 04 08 00 00       	call   fd0 <memset>
    cmd->type = LIST;
    cmd->left = left;
     7cc:	8b 45 08             	mov    0x8(%ebp),%eax
    cmd->type = LIST;
     7cf:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
    cmd->left = left;
     7d5:	89 43 04             	mov    %eax,0x4(%ebx)
    cmd->right = right;
     7d8:	8b 45 0c             	mov    0xc(%ebp),%eax
     7db:	89 43 08             	mov    %eax,0x8(%ebx)
    return (struct cmd*)cmd;
}
     7de:	83 c4 14             	add    $0x14,%esp
     7e1:	89 d8                	mov    %ebx,%eax
     7e3:	5b                   	pop    %ebx
     7e4:	5d                   	pop    %ebp
     7e5:	c3                   	ret    
     7e6:	8d 76 00             	lea    0x0(%esi),%esi
     7e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000007f0 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     7f0:	55                   	push   %ebp
     7f1:	89 e5                	mov    %esp,%ebp
     7f3:	53                   	push   %ebx
     7f4:	83 ec 14             	sub    $0x14,%esp
    struct backcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     7f7:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     7fe:	e8 5d 0d 00 00       	call   1560 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     803:	31 d2                	xor    %edx,%edx
     805:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     809:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     80b:	b8 08 00 00 00       	mov    $0x8,%eax
     810:	89 1c 24             	mov    %ebx,(%esp)
     813:	89 44 24 08          	mov    %eax,0x8(%esp)
     817:	e8 b4 07 00 00       	call   fd0 <memset>
    cmd->type = BACK;
    cmd->cmd = subcmd;
     81c:	8b 45 08             	mov    0x8(%ebp),%eax
    cmd->type = BACK;
     81f:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
    cmd->cmd = subcmd;
     825:	89 43 04             	mov    %eax,0x4(%ebx)
    return (struct cmd*)cmd;
}
     828:	83 c4 14             	add    $0x14,%esp
     82b:	89 d8                	mov    %ebx,%eax
     82d:	5b                   	pop    %ebx
     82e:	5d                   	pop    %ebp
     82f:	c3                   	ret    

00000830 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     830:	55                   	push   %ebp
     831:	89 e5                	mov    %esp,%ebp
     833:	57                   	push   %edi
     834:	56                   	push   %esi
     835:	53                   	push   %ebx
     836:	83 ec 1c             	sub    $0x1c,%esp
    char *s;
    int ret;

    s = *ps;
     839:	8b 45 08             	mov    0x8(%ebp),%eax
{
     83c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     83f:	8b 7d 10             	mov    0x10(%ebp),%edi
    s = *ps;
     842:	8b 30                	mov    (%eax),%esi
    while(s < es && strchr(whitespace, *s))
     844:	39 de                	cmp    %ebx,%esi
     846:	72 0d                	jb     855 <gettoken+0x25>
     848:	eb 22                	jmp    86c <gettoken+0x3c>
     84a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s++;
     850:	46                   	inc    %esi
    while(s < es && strchr(whitespace, *s))
     851:	39 f3                	cmp    %esi,%ebx
     853:	74 17                	je     86c <gettoken+0x3c>
     855:	0f be 06             	movsbl (%esi),%eax
     858:	c7 04 24 0c 1e 00 00 	movl   $0x1e0c,(%esp)
     85f:	89 44 24 04          	mov    %eax,0x4(%esp)
     863:	e8 88 07 00 00       	call   ff0 <strchr>
     868:	85 c0                	test   %eax,%eax
     86a:	75 e4                	jne    850 <gettoken+0x20>
    if(q)
     86c:	85 ff                	test   %edi,%edi
     86e:	74 02                	je     872 <gettoken+0x42>
        *q = s;
     870:	89 37                	mov    %esi,(%edi)
    ret = *s;
     872:	0f be 06             	movsbl (%esi),%eax
    switch(*s){
     875:	3c 29                	cmp    $0x29,%al
     877:	7f 57                	jg     8d0 <gettoken+0xa0>
     879:	3c 28                	cmp    $0x28,%al
     87b:	0f 8d cb 00 00 00    	jge    94c <gettoken+0x11c>
     881:	31 ff                	xor    %edi,%edi
     883:	84 c0                	test   %al,%al
     885:	0f 85 cd 00 00 00    	jne    958 <gettoken+0x128>
            ret = 'a';
            while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
                s++;
            break;
    }
    if(eq)
     88b:	8b 55 14             	mov    0x14(%ebp),%edx
     88e:	85 d2                	test   %edx,%edx
     890:	74 05                	je     897 <gettoken+0x67>
        *eq = s;
     892:	8b 45 14             	mov    0x14(%ebp),%eax
     895:	89 30                	mov    %esi,(%eax)

    while(s < es && strchr(whitespace, *s))
     897:	39 de                	cmp    %ebx,%esi
     899:	72 0a                	jb     8a5 <gettoken+0x75>
     89b:	eb 1f                	jmp    8bc <gettoken+0x8c>
     89d:	8d 76 00             	lea    0x0(%esi),%esi
        s++;
     8a0:	46                   	inc    %esi
    while(s < es && strchr(whitespace, *s))
     8a1:	39 f3                	cmp    %esi,%ebx
     8a3:	74 17                	je     8bc <gettoken+0x8c>
     8a5:	0f be 06             	movsbl (%esi),%eax
     8a8:	c7 04 24 0c 1e 00 00 	movl   $0x1e0c,(%esp)
     8af:	89 44 24 04          	mov    %eax,0x4(%esp)
     8b3:	e8 38 07 00 00       	call   ff0 <strchr>
     8b8:	85 c0                	test   %eax,%eax
     8ba:	75 e4                	jne    8a0 <gettoken+0x70>
    *ps = s;
     8bc:	8b 45 08             	mov    0x8(%ebp),%eax
     8bf:	89 30                	mov    %esi,(%eax)
    return ret;
}
     8c1:	83 c4 1c             	add    $0x1c,%esp
     8c4:	89 f8                	mov    %edi,%eax
     8c6:	5b                   	pop    %ebx
     8c7:	5e                   	pop    %esi
     8c8:	5f                   	pop    %edi
     8c9:	5d                   	pop    %ebp
     8ca:	c3                   	ret    
     8cb:	90                   	nop
     8cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(*s){
     8d0:	3c 3e                	cmp    $0x3e,%al
     8d2:	75 1c                	jne    8f0 <gettoken+0xc0>
            if(*s == '>'){
     8d4:	80 7e 01 3e          	cmpb   $0x3e,0x1(%esi)
            s++;
     8d8:	8d 46 01             	lea    0x1(%esi),%eax
            if(*s == '>'){
     8db:	0f 84 94 00 00 00    	je     975 <gettoken+0x145>
            s++;
     8e1:	89 c6                	mov    %eax,%esi
     8e3:	bf 3e 00 00 00       	mov    $0x3e,%edi
     8e8:	eb a1                	jmp    88b <gettoken+0x5b>
     8ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(*s){
     8f0:	7f 56                	jg     948 <gettoken+0x118>
     8f2:	88 c1                	mov    %al,%cl
     8f4:	80 e9 3b             	sub    $0x3b,%cl
     8f7:	80 f9 01             	cmp    $0x1,%cl
     8fa:	76 50                	jbe    94c <gettoken+0x11c>
            while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     8fc:	39 f3                	cmp    %esi,%ebx
     8fe:	77 27                	ja     927 <gettoken+0xf7>
     900:	eb 5e                	jmp    960 <gettoken+0x130>
     902:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     908:	0f be 06             	movsbl (%esi),%eax
     90b:	c7 04 24 04 1e 00 00 	movl   $0x1e04,(%esp)
     912:	89 44 24 04          	mov    %eax,0x4(%esp)
     916:	e8 d5 06 00 00       	call   ff0 <strchr>
     91b:	85 c0                	test   %eax,%eax
     91d:	75 1c                	jne    93b <gettoken+0x10b>
                s++;
     91f:	46                   	inc    %esi
            while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     920:	39 f3                	cmp    %esi,%ebx
     922:	74 3c                	je     960 <gettoken+0x130>
     924:	0f be 06             	movsbl (%esi),%eax
     927:	89 44 24 04          	mov    %eax,0x4(%esp)
     92b:	c7 04 24 0c 1e 00 00 	movl   $0x1e0c,(%esp)
     932:	e8 b9 06 00 00       	call   ff0 <strchr>
     937:	85 c0                	test   %eax,%eax
     939:	74 cd                	je     908 <gettoken+0xd8>
            ret = 'a';
     93b:	bf 61 00 00 00       	mov    $0x61,%edi
     940:	e9 46 ff ff ff       	jmp    88b <gettoken+0x5b>
     945:	8d 76 00             	lea    0x0(%esi),%esi
    switch(*s){
     948:	3c 7c                	cmp    $0x7c,%al
     94a:	75 b0                	jne    8fc <gettoken+0xcc>
    ret = *s;
     94c:	0f be f8             	movsbl %al,%edi
            s++;
     94f:	46                   	inc    %esi
            break;
     950:	e9 36 ff ff ff       	jmp    88b <gettoken+0x5b>
     955:	8d 76 00             	lea    0x0(%esi),%esi
    switch(*s){
     958:	3c 26                	cmp    $0x26,%al
     95a:	75 a0                	jne    8fc <gettoken+0xcc>
     95c:	eb ee                	jmp    94c <gettoken+0x11c>
     95e:	66 90                	xchg   %ax,%ax
    if(eq)
     960:	8b 45 14             	mov    0x14(%ebp),%eax
     963:	bf 61 00 00 00       	mov    $0x61,%edi
     968:	85 c0                	test   %eax,%eax
     96a:	0f 85 22 ff ff ff    	jne    892 <gettoken+0x62>
     970:	e9 47 ff ff ff       	jmp    8bc <gettoken+0x8c>
                s++;
     975:	83 c6 02             	add    $0x2,%esi
                ret = '+';
     978:	bf 2b 00 00 00       	mov    $0x2b,%edi
     97d:	e9 09 ff ff ff       	jmp    88b <gettoken+0x5b>
     982:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000990 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     990:	55                   	push   %ebp
     991:	89 e5                	mov    %esp,%ebp
     993:	57                   	push   %edi
     994:	56                   	push   %esi
     995:	53                   	push   %ebx
     996:	83 ec 1c             	sub    $0x1c,%esp
     999:	8b 7d 08             	mov    0x8(%ebp),%edi
     99c:	8b 75 0c             	mov    0xc(%ebp),%esi
    char *s;

    s = *ps;
     99f:	8b 1f                	mov    (%edi),%ebx
    while(s < es && strchr(whitespace, *s))
     9a1:	39 f3                	cmp    %esi,%ebx
     9a3:	72 10                	jb     9b5 <peek+0x25>
     9a5:	eb 25                	jmp    9cc <peek+0x3c>
     9a7:	89 f6                	mov    %esi,%esi
     9a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s++;
     9b0:	43                   	inc    %ebx
    while(s < es && strchr(whitespace, *s))
     9b1:	39 de                	cmp    %ebx,%esi
     9b3:	74 17                	je     9cc <peek+0x3c>
     9b5:	0f be 03             	movsbl (%ebx),%eax
     9b8:	c7 04 24 0c 1e 00 00 	movl   $0x1e0c,(%esp)
     9bf:	89 44 24 04          	mov    %eax,0x4(%esp)
     9c3:	e8 28 06 00 00       	call   ff0 <strchr>
     9c8:	85 c0                	test   %eax,%eax
     9ca:	75 e4                	jne    9b0 <peek+0x20>
    *ps = s;
     9cc:	89 1f                	mov    %ebx,(%edi)
    return *s && strchr(toks, *s);
     9ce:	31 c0                	xor    %eax,%eax
     9d0:	0f be 13             	movsbl (%ebx),%edx
     9d3:	84 d2                	test   %dl,%dl
     9d5:	74 17                	je     9ee <peek+0x5e>
     9d7:	8b 45 10             	mov    0x10(%ebp),%eax
     9da:	89 54 24 04          	mov    %edx,0x4(%esp)
     9de:	89 04 24             	mov    %eax,(%esp)
     9e1:	e8 0a 06 00 00       	call   ff0 <strchr>
     9e6:	85 c0                	test   %eax,%eax
     9e8:	0f 95 c0             	setne  %al
     9eb:	0f b6 c0             	movzbl %al,%eax
}
     9ee:	83 c4 1c             	add    $0x1c,%esp
     9f1:	5b                   	pop    %ebx
     9f2:	5e                   	pop    %esi
     9f3:	5f                   	pop    %edi
     9f4:	5d                   	pop    %ebp
     9f5:	c3                   	ret    
     9f6:	8d 76 00             	lea    0x0(%esi),%esi
     9f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a00 <parseredirs>:
    return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     a00:	55                   	push   %ebp
     a01:	89 e5                	mov    %esp,%ebp
     a03:	57                   	push   %edi
     a04:	56                   	push   %esi
     a05:	53                   	push   %ebx
     a06:	83 ec 3c             	sub    $0x3c,%esp
     a09:	8b 75 0c             	mov    0xc(%ebp),%esi
     a0c:	8b 5d 10             	mov    0x10(%ebp),%ebx
     a0f:	90                   	nop
    int tok;
    char *q, *eq;

    while(peek(ps, es, "<>")){
     a10:	b8 ad 16 00 00       	mov    $0x16ad,%eax
     a15:	89 44 24 08          	mov    %eax,0x8(%esp)
     a19:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     a1d:	89 34 24             	mov    %esi,(%esp)
     a20:	e8 6b ff ff ff       	call   990 <peek>
     a25:	85 c0                	test   %eax,%eax
     a27:	0f 84 93 00 00 00    	je     ac0 <parseredirs+0xc0>
        tok = gettoken(ps, es, 0, 0);
     a2d:	31 c0                	xor    %eax,%eax
     a2f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     a33:	31 c0                	xor    %eax,%eax
     a35:	89 44 24 08          	mov    %eax,0x8(%esp)
     a39:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     a3d:	89 34 24             	mov    %esi,(%esp)
     a40:	e8 eb fd ff ff       	call   830 <gettoken>
        if(gettoken(ps, es, &q, &eq) != 'a')
     a45:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     a49:	89 34 24             	mov    %esi,(%esp)
        tok = gettoken(ps, es, 0, 0);
     a4c:	89 c7                	mov    %eax,%edi
        if(gettoken(ps, es, &q, &eq) != 'a')
     a4e:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     a51:	89 44 24 0c          	mov    %eax,0xc(%esp)
     a55:	8d 45 e0             	lea    -0x20(%ebp),%eax
     a58:	89 44 24 08          	mov    %eax,0x8(%esp)
     a5c:	e8 cf fd ff ff       	call   830 <gettoken>
     a61:	83 f8 61             	cmp    $0x61,%eax
     a64:	75 65                	jne    acb <parseredirs+0xcb>
            panic("missing file for redirection");
        switch(tok){
     a66:	83 ff 3c             	cmp    $0x3c,%edi
     a69:	74 45                	je     ab0 <parseredirs+0xb0>
     a6b:	83 ff 3e             	cmp    $0x3e,%edi
     a6e:	66 90                	xchg   %ax,%ax
     a70:	74 05                	je     a77 <parseredirs+0x77>
     a72:	83 ff 2b             	cmp    $0x2b,%edi
     a75:	75 99                	jne    a10 <parseredirs+0x10>
                break;
            case '>':
                cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
                break;
            case '+':  // >>
                cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     a77:	ba 01 00 00 00       	mov    $0x1,%edx
     a7c:	b9 01 02 00 00       	mov    $0x201,%ecx
     a81:	89 54 24 10          	mov    %edx,0x10(%esp)
     a85:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
     a89:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a8c:	89 44 24 08          	mov    %eax,0x8(%esp)
     a90:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a93:	89 44 24 04          	mov    %eax,0x4(%esp)
     a97:	8b 45 08             	mov    0x8(%ebp),%eax
     a9a:	89 04 24             	mov    %eax,(%esp)
     a9d:	e8 4e fc ff ff       	call   6f0 <redircmd>
     aa2:	89 45 08             	mov    %eax,0x8(%ebp)
                break;
     aa5:	e9 66 ff ff ff       	jmp    a10 <parseredirs+0x10>
     aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     ab0:	31 ff                	xor    %edi,%edi
     ab2:	31 c0                	xor    %eax,%eax
     ab4:	89 7c 24 10          	mov    %edi,0x10(%esp)
     ab8:	89 44 24 0c          	mov    %eax,0xc(%esp)
     abc:	eb cb                	jmp    a89 <parseredirs+0x89>
     abe:	66 90                	xchg   %ax,%ax
        }
    }
    return cmd;
}
     ac0:	8b 45 08             	mov    0x8(%ebp),%eax
     ac3:	83 c4 3c             	add    $0x3c,%esp
     ac6:	5b                   	pop    %ebx
     ac7:	5e                   	pop    %esi
     ac8:	5f                   	pop    %edi
     ac9:	5d                   	pop    %ebp
     aca:	c3                   	ret    
            panic("missing file for redirection");
     acb:	c7 04 24 90 16 00 00 	movl   $0x1690,(%esp)
     ad2:	e8 89 f9 ff ff       	call   460 <panic>
     ad7:	89 f6                	mov    %esi,%esi
     ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ae0 <parseexec>:
    return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     ae0:	55                   	push   %ebp
    char *q, *eq;
    int tok, argc;
    struct execcmd *cmd;
    struct cmd *ret;

    if(peek(ps, es, "("))
     ae1:	ba b0 16 00 00       	mov    $0x16b0,%edx
{
     ae6:	89 e5                	mov    %esp,%ebp
     ae8:	57                   	push   %edi
     ae9:	56                   	push   %esi
     aea:	53                   	push   %ebx
     aeb:	83 ec 3c             	sub    $0x3c,%esp
     aee:	8b 75 08             	mov    0x8(%ebp),%esi
     af1:	8b 7d 0c             	mov    0xc(%ebp),%edi
    if(peek(ps, es, "("))
     af4:	89 54 24 08          	mov    %edx,0x8(%esp)
     af8:	89 34 24             	mov    %esi,(%esp)
     afb:	89 7c 24 04          	mov    %edi,0x4(%esp)
     aff:	e8 8c fe ff ff       	call   990 <peek>
     b04:	85 c0                	test   %eax,%eax
     b06:	0f 85 9c 00 00 00    	jne    ba8 <parseexec+0xc8>
     b0c:	89 c3                	mov    %eax,%ebx
        return parseblock(ps, es);

    ret = execcmd();
     b0e:	e8 9d fb ff ff       	call   6b0 <execcmd>
    cmd = (struct execcmd*)ret;

    argc = 0;
    ret = parseredirs(ret, ps, es);
     b13:	89 7c 24 08          	mov    %edi,0x8(%esp)
     b17:	89 74 24 04          	mov    %esi,0x4(%esp)
     b1b:	89 04 24             	mov    %eax,(%esp)
    ret = execcmd();
     b1e:	89 45 d0             	mov    %eax,-0x30(%ebp)
    ret = parseredirs(ret, ps, es);
     b21:	e8 da fe ff ff       	call   a00 <parseredirs>
     b26:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     b29:	eb 1b                	jmp    b46 <parseexec+0x66>
     b2b:	90                   	nop
     b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cmd->argv[argc] = q;
        cmd->eargv[argc] = eq;
        argc++;
        if(argc >= MAXARGS)
            panic("too many args");
        ret = parseredirs(ret, ps, es);
     b30:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     b33:	89 7c 24 08          	mov    %edi,0x8(%esp)
     b37:	89 74 24 04          	mov    %esi,0x4(%esp)
     b3b:	89 04 24             	mov    %eax,(%esp)
     b3e:	e8 bd fe ff ff       	call   a00 <parseredirs>
     b43:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while(!peek(ps, es, "|)&;")){
     b46:	b8 c7 16 00 00       	mov    $0x16c7,%eax
     b4b:	89 44 24 08          	mov    %eax,0x8(%esp)
     b4f:	89 7c 24 04          	mov    %edi,0x4(%esp)
     b53:	89 34 24             	mov    %esi,(%esp)
     b56:	e8 35 fe ff ff       	call   990 <peek>
     b5b:	85 c0                	test   %eax,%eax
     b5d:	75 69                	jne    bc8 <parseexec+0xe8>
        if((tok=gettoken(ps, es, &q, &eq)) == 0)
     b5f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     b62:	89 44 24 0c          	mov    %eax,0xc(%esp)
     b66:	8d 45 e0             	lea    -0x20(%ebp),%eax
     b69:	89 44 24 08          	mov    %eax,0x8(%esp)
     b6d:	89 7c 24 04          	mov    %edi,0x4(%esp)
     b71:	89 34 24             	mov    %esi,(%esp)
     b74:	e8 b7 fc ff ff       	call   830 <gettoken>
     b79:	85 c0                	test   %eax,%eax
     b7b:	74 4b                	je     bc8 <parseexec+0xe8>
        if(tok != 'a')
     b7d:	83 f8 61             	cmp    $0x61,%eax
     b80:	75 65                	jne    be7 <parseexec+0x107>
        cmd->argv[argc] = q;
     b82:	8b 45 e0             	mov    -0x20(%ebp),%eax
     b85:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b88:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
        cmd->eargv[argc] = eq;
     b8c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     b8f:	89 44 9a 2c          	mov    %eax,0x2c(%edx,%ebx,4)
        argc++;
     b93:	43                   	inc    %ebx
        if(argc >= MAXARGS)
     b94:	83 fb 0a             	cmp    $0xa,%ebx
     b97:	75 97                	jne    b30 <parseexec+0x50>
            panic("too many args");
     b99:	c7 04 24 b9 16 00 00 	movl   $0x16b9,(%esp)
     ba0:	e8 bb f8 ff ff       	call   460 <panic>
     ba5:	8d 76 00             	lea    0x0(%esi),%esi
        return parseblock(ps, es);
     ba8:	89 7c 24 04          	mov    %edi,0x4(%esp)
     bac:	89 34 24             	mov    %esi,(%esp)
     baf:	e8 9c 01 00 00       	call   d50 <parseblock>
     bb4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    }
    cmd->argv[argc] = 0;
    cmd->eargv[argc] = 0;
    return ret;
}
     bb7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     bba:	83 c4 3c             	add    $0x3c,%esp
     bbd:	5b                   	pop    %ebx
     bbe:	5e                   	pop    %esi
     bbf:	5f                   	pop    %edi
     bc0:	5d                   	pop    %ebp
     bc1:	c3                   	ret    
     bc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     bc8:	8b 45 d0             	mov    -0x30(%ebp),%eax
     bcb:	8d 04 98             	lea    (%eax,%ebx,4),%eax
    cmd->argv[argc] = 0;
     bce:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    cmd->eargv[argc] = 0;
     bd5:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
}
     bdc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     bdf:	83 c4 3c             	add    $0x3c,%esp
     be2:	5b                   	pop    %ebx
     be3:	5e                   	pop    %esi
     be4:	5f                   	pop    %edi
     be5:	5d                   	pop    %ebp
     be6:	c3                   	ret    
            panic("syntax");
     be7:	c7 04 24 b2 16 00 00 	movl   $0x16b2,(%esp)
     bee:	e8 6d f8 ff ff       	call   460 <panic>
     bf3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c00 <parsepipe>:
{
     c00:	55                   	push   %ebp
     c01:	89 e5                	mov    %esp,%ebp
     c03:	83 ec 28             	sub    $0x28,%esp
     c06:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     c09:	8b 5d 08             	mov    0x8(%ebp),%ebx
     c0c:	89 75 f8             	mov    %esi,-0x8(%ebp)
     c0f:	8b 75 0c             	mov    0xc(%ebp),%esi
     c12:	89 7d fc             	mov    %edi,-0x4(%ebp)
    cmd = parseexec(ps, es);
     c15:	89 1c 24             	mov    %ebx,(%esp)
     c18:	89 74 24 04          	mov    %esi,0x4(%esp)
     c1c:	e8 bf fe ff ff       	call   ae0 <parseexec>
    if(peek(ps, es, "|")){
     c21:	b9 cc 16 00 00       	mov    $0x16cc,%ecx
     c26:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     c2a:	89 74 24 04          	mov    %esi,0x4(%esp)
     c2e:	89 1c 24             	mov    %ebx,(%esp)
    cmd = parseexec(ps, es);
     c31:	89 c7                	mov    %eax,%edi
    if(peek(ps, es, "|")){
     c33:	e8 58 fd ff ff       	call   990 <peek>
     c38:	85 c0                	test   %eax,%eax
     c3a:	75 14                	jne    c50 <parsepipe+0x50>
}
     c3c:	89 f8                	mov    %edi,%eax
     c3e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     c41:	8b 75 f8             	mov    -0x8(%ebp),%esi
     c44:	8b 7d fc             	mov    -0x4(%ebp),%edi
     c47:	89 ec                	mov    %ebp,%esp
     c49:	5d                   	pop    %ebp
     c4a:	c3                   	ret    
     c4b:	90                   	nop
     c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        gettoken(ps, es, 0, 0);
     c50:	31 d2                	xor    %edx,%edx
     c52:	31 c0                	xor    %eax,%eax
     c54:	89 54 24 08          	mov    %edx,0x8(%esp)
     c58:	89 74 24 04          	mov    %esi,0x4(%esp)
     c5c:	89 1c 24             	mov    %ebx,(%esp)
     c5f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     c63:	e8 c8 fb ff ff       	call   830 <gettoken>
        cmd = pipecmd(cmd, parsepipe(ps, es));
     c68:	89 74 24 04          	mov    %esi,0x4(%esp)
     c6c:	89 1c 24             	mov    %ebx,(%esp)
     c6f:	e8 8c ff ff ff       	call   c00 <parsepipe>
}
     c74:	8b 5d f4             	mov    -0xc(%ebp),%ebx
        cmd = pipecmd(cmd, parsepipe(ps, es));
     c77:	89 7d 08             	mov    %edi,0x8(%ebp)
}
     c7a:	8b 75 f8             	mov    -0x8(%ebp),%esi
     c7d:	8b 7d fc             	mov    -0x4(%ebp),%edi
        cmd = pipecmd(cmd, parsepipe(ps, es));
     c80:	89 45 0c             	mov    %eax,0xc(%ebp)
}
     c83:	89 ec                	mov    %ebp,%esp
     c85:	5d                   	pop    %ebp
        cmd = pipecmd(cmd, parsepipe(ps, es));
     c86:	e9 c5 fa ff ff       	jmp    750 <pipecmd>
     c8b:	90                   	nop
     c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000c90 <parseline>:
{
     c90:	55                   	push   %ebp
     c91:	89 e5                	mov    %esp,%ebp
     c93:	57                   	push   %edi
     c94:	56                   	push   %esi
     c95:	53                   	push   %ebx
     c96:	83 ec 1c             	sub    $0x1c,%esp
     c99:	8b 5d 08             	mov    0x8(%ebp),%ebx
     c9c:	8b 75 0c             	mov    0xc(%ebp),%esi
    cmd = parsepipe(ps, es);
     c9f:	89 1c 24             	mov    %ebx,(%esp)
     ca2:	89 74 24 04          	mov    %esi,0x4(%esp)
     ca6:	e8 55 ff ff ff       	call   c00 <parsepipe>
     cab:	89 c7                	mov    %eax,%edi
    while(peek(ps, es, "&")){
     cad:	eb 23                	jmp    cd2 <parseline+0x42>
     caf:	90                   	nop
        gettoken(ps, es, 0, 0);
     cb0:	31 c0                	xor    %eax,%eax
     cb2:	89 44 24 0c          	mov    %eax,0xc(%esp)
     cb6:	31 c0                	xor    %eax,%eax
     cb8:	89 44 24 08          	mov    %eax,0x8(%esp)
     cbc:	89 74 24 04          	mov    %esi,0x4(%esp)
     cc0:	89 1c 24             	mov    %ebx,(%esp)
     cc3:	e8 68 fb ff ff       	call   830 <gettoken>
        cmd = backcmd(cmd);
     cc8:	89 3c 24             	mov    %edi,(%esp)
     ccb:	e8 20 fb ff ff       	call   7f0 <backcmd>
     cd0:	89 c7                	mov    %eax,%edi
    while(peek(ps, es, "&")){
     cd2:	b8 ce 16 00 00       	mov    $0x16ce,%eax
     cd7:	89 44 24 08          	mov    %eax,0x8(%esp)
     cdb:	89 74 24 04          	mov    %esi,0x4(%esp)
     cdf:	89 1c 24             	mov    %ebx,(%esp)
     ce2:	e8 a9 fc ff ff       	call   990 <peek>
     ce7:	85 c0                	test   %eax,%eax
     ce9:	75 c5                	jne    cb0 <parseline+0x20>
    if(peek(ps, es, ";")){
     ceb:	b9 ca 16 00 00       	mov    $0x16ca,%ecx
     cf0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     cf4:	89 74 24 04          	mov    %esi,0x4(%esp)
     cf8:	89 1c 24             	mov    %ebx,(%esp)
     cfb:	e8 90 fc ff ff       	call   990 <peek>
     d00:	85 c0                	test   %eax,%eax
     d02:	75 0c                	jne    d10 <parseline+0x80>
}
     d04:	83 c4 1c             	add    $0x1c,%esp
     d07:	89 f8                	mov    %edi,%eax
     d09:	5b                   	pop    %ebx
     d0a:	5e                   	pop    %esi
     d0b:	5f                   	pop    %edi
     d0c:	5d                   	pop    %ebp
     d0d:	c3                   	ret    
     d0e:	66 90                	xchg   %ax,%ax
        gettoken(ps, es, 0, 0);
     d10:	31 d2                	xor    %edx,%edx
     d12:	31 c0                	xor    %eax,%eax
     d14:	89 54 24 08          	mov    %edx,0x8(%esp)
     d18:	89 74 24 04          	mov    %esi,0x4(%esp)
     d1c:	89 1c 24             	mov    %ebx,(%esp)
     d1f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     d23:	e8 08 fb ff ff       	call   830 <gettoken>
        cmd = listcmd(cmd, parseline(ps, es));
     d28:	89 74 24 04          	mov    %esi,0x4(%esp)
     d2c:	89 1c 24             	mov    %ebx,(%esp)
     d2f:	e8 5c ff ff ff       	call   c90 <parseline>
     d34:	89 7d 08             	mov    %edi,0x8(%ebp)
     d37:	89 45 0c             	mov    %eax,0xc(%ebp)
}
     d3a:	83 c4 1c             	add    $0x1c,%esp
     d3d:	5b                   	pop    %ebx
     d3e:	5e                   	pop    %esi
     d3f:	5f                   	pop    %edi
     d40:	5d                   	pop    %ebp
        cmd = listcmd(cmd, parseline(ps, es));
     d41:	e9 5a fa ff ff       	jmp    7a0 <listcmd>
     d46:	8d 76 00             	lea    0x0(%esi),%esi
     d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d50 <parseblock>:
{
     d50:	55                   	push   %ebp
    if(!peek(ps, es, "("))
     d51:	b8 b0 16 00 00       	mov    $0x16b0,%eax
{
     d56:	89 e5                	mov    %esp,%ebp
     d58:	83 ec 28             	sub    $0x28,%esp
     d5b:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     d5e:	8b 5d 08             	mov    0x8(%ebp),%ebx
     d61:	89 75 f8             	mov    %esi,-0x8(%ebp)
     d64:	8b 75 0c             	mov    0xc(%ebp),%esi
    if(!peek(ps, es, "("))
     d67:	89 44 24 08          	mov    %eax,0x8(%esp)
{
     d6b:	89 7d fc             	mov    %edi,-0x4(%ebp)
    if(!peek(ps, es, "("))
     d6e:	89 1c 24             	mov    %ebx,(%esp)
     d71:	89 74 24 04          	mov    %esi,0x4(%esp)
     d75:	e8 16 fc ff ff       	call   990 <peek>
     d7a:	85 c0                	test   %eax,%eax
     d7c:	74 74                	je     df2 <parseblock+0xa2>
    gettoken(ps, es, 0, 0);
     d7e:	31 c9                	xor    %ecx,%ecx
     d80:	31 ff                	xor    %edi,%edi
     d82:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
     d86:	89 7c 24 08          	mov    %edi,0x8(%esp)
     d8a:	89 74 24 04          	mov    %esi,0x4(%esp)
     d8e:	89 1c 24             	mov    %ebx,(%esp)
     d91:	e8 9a fa ff ff       	call   830 <gettoken>
    cmd = parseline(ps, es);
     d96:	89 74 24 04          	mov    %esi,0x4(%esp)
     d9a:	89 1c 24             	mov    %ebx,(%esp)
     d9d:	e8 ee fe ff ff       	call   c90 <parseline>
    if(!peek(ps, es, ")"))
     da2:	89 74 24 04          	mov    %esi,0x4(%esp)
     da6:	89 1c 24             	mov    %ebx,(%esp)
    cmd = parseline(ps, es);
     da9:	89 c7                	mov    %eax,%edi
    if(!peek(ps, es, ")"))
     dab:	b8 ec 16 00 00       	mov    $0x16ec,%eax
     db0:	89 44 24 08          	mov    %eax,0x8(%esp)
     db4:	e8 d7 fb ff ff       	call   990 <peek>
     db9:	85 c0                	test   %eax,%eax
     dbb:	74 41                	je     dfe <parseblock+0xae>
    gettoken(ps, es, 0, 0);
     dbd:	31 d2                	xor    %edx,%edx
     dbf:	31 c0                	xor    %eax,%eax
     dc1:	89 54 24 08          	mov    %edx,0x8(%esp)
     dc5:	89 74 24 04          	mov    %esi,0x4(%esp)
     dc9:	89 1c 24             	mov    %ebx,(%esp)
     dcc:	89 44 24 0c          	mov    %eax,0xc(%esp)
     dd0:	e8 5b fa ff ff       	call   830 <gettoken>
    cmd = parseredirs(cmd, ps, es);
     dd5:	89 74 24 08          	mov    %esi,0x8(%esp)
     dd9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     ddd:	89 3c 24             	mov    %edi,(%esp)
     de0:	e8 1b fc ff ff       	call   a00 <parseredirs>
}
     de5:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     de8:	8b 75 f8             	mov    -0x8(%ebp),%esi
     deb:	8b 7d fc             	mov    -0x4(%ebp),%edi
     dee:	89 ec                	mov    %ebp,%esp
     df0:	5d                   	pop    %ebp
     df1:	c3                   	ret    
        panic("parseblock");
     df2:	c7 04 24 d0 16 00 00 	movl   $0x16d0,(%esp)
     df9:	e8 62 f6 ff ff       	call   460 <panic>
        panic("syntax - missing )");
     dfe:	c7 04 24 db 16 00 00 	movl   $0x16db,(%esp)
     e05:	e8 56 f6 ff ff       	call   460 <panic>
     e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000e10 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     e10:	55                   	push   %ebp
     e11:	89 e5                	mov    %esp,%ebp
     e13:	53                   	push   %ebx
     e14:	83 ec 14             	sub    $0x14,%esp
     e17:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct execcmd *ecmd;
    struct listcmd *lcmd;
    struct pipecmd *pcmd;
    struct redircmd *rcmd;

    if(cmd == 0)
     e1a:	85 db                	test   %ebx,%ebx
     e1c:	74 1d                	je     e3b <nulterminate+0x2b>
        return 0;

    switch(cmd->type){
     e1e:	83 3b 05             	cmpl   $0x5,(%ebx)
     e21:	77 18                	ja     e3b <nulterminate+0x2b>
     e23:	8b 03                	mov    (%ebx),%eax
     e25:	ff 24 85 30 17 00 00 	jmp    *0x1730(,%eax,4)
     e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            nulterminate(lcmd->right);
            break;

        case BACK:
            bcmd = (struct backcmd*)cmd;
            nulterminate(bcmd->cmd);
     e30:	8b 43 04             	mov    0x4(%ebx),%eax
     e33:	89 04 24             	mov    %eax,(%esp)
     e36:	e8 d5 ff ff ff       	call   e10 <nulterminate>
            break;
    }
    return cmd;
}
     e3b:	83 c4 14             	add    $0x14,%esp
     e3e:	89 d8                	mov    %ebx,%eax
     e40:	5b                   	pop    %ebx
     e41:	5d                   	pop    %ebp
     e42:	c3                   	ret    
     e43:	90                   	nop
     e44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            nulterminate(lcmd->left);
     e48:	8b 43 04             	mov    0x4(%ebx),%eax
     e4b:	89 04 24             	mov    %eax,(%esp)
     e4e:	e8 bd ff ff ff       	call   e10 <nulterminate>
            nulterminate(lcmd->right);
     e53:	8b 43 08             	mov    0x8(%ebx),%eax
     e56:	89 04 24             	mov    %eax,(%esp)
     e59:	e8 b2 ff ff ff       	call   e10 <nulterminate>
}
     e5e:	83 c4 14             	add    $0x14,%esp
     e61:	89 d8                	mov    %ebx,%eax
     e63:	5b                   	pop    %ebx
     e64:	5d                   	pop    %ebp
     e65:	c3                   	ret    
     e66:	8d 76 00             	lea    0x0(%esi),%esi
     e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            for(i=0; ecmd->argv[i]; i++)
     e70:	8b 4b 04             	mov    0x4(%ebx),%ecx
     e73:	8d 43 08             	lea    0x8(%ebx),%eax
     e76:	85 c9                	test   %ecx,%ecx
     e78:	74 c1                	je     e3b <nulterminate+0x2b>
     e7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                *ecmd->eargv[i] = 0;
     e80:	8b 50 24             	mov    0x24(%eax),%edx
     e83:	83 c0 04             	add    $0x4,%eax
     e86:	c6 02 00             	movb   $0x0,(%edx)
            for(i=0; ecmd->argv[i]; i++)
     e89:	8b 50 fc             	mov    -0x4(%eax),%edx
     e8c:	85 d2                	test   %edx,%edx
     e8e:	75 f0                	jne    e80 <nulterminate+0x70>
}
     e90:	83 c4 14             	add    $0x14,%esp
     e93:	89 d8                	mov    %ebx,%eax
     e95:	5b                   	pop    %ebx
     e96:	5d                   	pop    %ebp
     e97:	c3                   	ret    
     e98:	90                   	nop
     e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            nulterminate(rcmd->cmd);
     ea0:	8b 43 04             	mov    0x4(%ebx),%eax
     ea3:	89 04 24             	mov    %eax,(%esp)
     ea6:	e8 65 ff ff ff       	call   e10 <nulterminate>
            *rcmd->efile = 0;
     eab:	8b 43 0c             	mov    0xc(%ebx),%eax
     eae:	c6 00 00             	movb   $0x0,(%eax)
}
     eb1:	83 c4 14             	add    $0x14,%esp
     eb4:	89 d8                	mov    %ebx,%eax
     eb6:	5b                   	pop    %ebx
     eb7:	5d                   	pop    %ebp
     eb8:	c3                   	ret    
     eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000ec0 <parsecmd>:
{
     ec0:	55                   	push   %ebp
     ec1:	89 e5                	mov    %esp,%ebp
     ec3:	56                   	push   %esi
     ec4:	53                   	push   %ebx
     ec5:	83 ec 10             	sub    $0x10,%esp
    es = s + strlen(s);
     ec8:	8b 5d 08             	mov    0x8(%ebp),%ebx
     ecb:	89 1c 24             	mov    %ebx,(%esp)
     ece:	e8 cd 00 00 00       	call   fa0 <strlen>
     ed3:	01 c3                	add    %eax,%ebx
    cmd = parseline(&s, es);
     ed5:	8d 45 08             	lea    0x8(%ebp),%eax
     ed8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     edc:	89 04 24             	mov    %eax,(%esp)
     edf:	e8 ac fd ff ff       	call   c90 <parseline>
    peek(&s, es, "");
     ee4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    cmd = parseline(&s, es);
     ee8:	89 c6                	mov    %eax,%esi
    peek(&s, es, "");
     eea:	b8 75 16 00 00       	mov    $0x1675,%eax
     eef:	89 44 24 08          	mov    %eax,0x8(%esp)
     ef3:	8d 45 08             	lea    0x8(%ebp),%eax
     ef6:	89 04 24             	mov    %eax,(%esp)
     ef9:	e8 92 fa ff ff       	call   990 <peek>
    if(s != es){
     efe:	8b 45 08             	mov    0x8(%ebp),%eax
     f01:	39 d8                	cmp    %ebx,%eax
     f03:	75 11                	jne    f16 <parsecmd+0x56>
    nulterminate(cmd);
     f05:	89 34 24             	mov    %esi,(%esp)
     f08:	e8 03 ff ff ff       	call   e10 <nulterminate>
}
     f0d:	83 c4 10             	add    $0x10,%esp
     f10:	89 f0                	mov    %esi,%eax
     f12:	5b                   	pop    %ebx
     f13:	5e                   	pop    %esi
     f14:	5d                   	pop    %ebp
     f15:	c3                   	ret    
        printf(2, "leftovers: %s\n", s);
     f16:	89 44 24 08          	mov    %eax,0x8(%esp)
     f1a:	c7 44 24 04 ee 16 00 	movl   $0x16ee,0x4(%esp)
     f21:	00 
     f22:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     f29:	e8 a2 03 00 00       	call   12d0 <printf>
        panic("syntax");
     f2e:	c7 04 24 b2 16 00 00 	movl   $0x16b2,(%esp)
     f35:	e8 26 f5 ff ff       	call   460 <panic>
     f3a:	66 90                	xchg   %ax,%ax
     f3c:	66 90                	xchg   %ax,%ax
     f3e:	66 90                	xchg   %ax,%ax

00000f40 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     f40:	55                   	push   %ebp
     f41:	89 e5                	mov    %esp,%ebp
     f43:	8b 45 08             	mov    0x8(%ebp),%eax
     f46:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     f49:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     f4a:	89 c2                	mov    %eax,%edx
     f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     f50:	41                   	inc    %ecx
     f51:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     f55:	42                   	inc    %edx
     f56:	84 db                	test   %bl,%bl
     f58:	88 5a ff             	mov    %bl,-0x1(%edx)
     f5b:	75 f3                	jne    f50 <strcpy+0x10>
    ;
  return os;
}
     f5d:	5b                   	pop    %ebx
     f5e:	5d                   	pop    %ebp
     f5f:	c3                   	ret    

00000f60 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     f60:	55                   	push   %ebp
     f61:	89 e5                	mov    %esp,%ebp
     f63:	8b 4d 08             	mov    0x8(%ebp),%ecx
     f66:	53                   	push   %ebx
     f67:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
     f6a:	0f b6 01             	movzbl (%ecx),%eax
     f6d:	0f b6 13             	movzbl (%ebx),%edx
     f70:	84 c0                	test   %al,%al
     f72:	75 18                	jne    f8c <strcmp+0x2c>
     f74:	eb 22                	jmp    f98 <strcmp+0x38>
     f76:	8d 76 00             	lea    0x0(%esi),%esi
     f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     f80:	41                   	inc    %ecx
  while(*p && *p == *q)
     f81:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
     f84:	43                   	inc    %ebx
     f85:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
     f88:	84 c0                	test   %al,%al
     f8a:	74 0c                	je     f98 <strcmp+0x38>
     f8c:	38 d0                	cmp    %dl,%al
     f8e:	74 f0                	je     f80 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
     f90:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
     f91:	29 d0                	sub    %edx,%eax
}
     f93:	5d                   	pop    %ebp
     f94:	c3                   	ret    
     f95:	8d 76 00             	lea    0x0(%esi),%esi
     f98:	5b                   	pop    %ebx
     f99:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     f9b:	29 d0                	sub    %edx,%eax
}
     f9d:	5d                   	pop    %ebp
     f9e:	c3                   	ret    
     f9f:	90                   	nop

00000fa0 <strlen>:

uint
strlen(const char *s)
{
     fa0:	55                   	push   %ebp
     fa1:	89 e5                	mov    %esp,%ebp
     fa3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     fa6:	80 39 00             	cmpb   $0x0,(%ecx)
     fa9:	74 15                	je     fc0 <strlen+0x20>
     fab:	31 d2                	xor    %edx,%edx
     fad:	8d 76 00             	lea    0x0(%esi),%esi
     fb0:	42                   	inc    %edx
     fb1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     fb5:	89 d0                	mov    %edx,%eax
     fb7:	75 f7                	jne    fb0 <strlen+0x10>
    ;
  return n;
}
     fb9:	5d                   	pop    %ebp
     fba:	c3                   	ret    
     fbb:	90                   	nop
     fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
     fc0:	31 c0                	xor    %eax,%eax
}
     fc2:	5d                   	pop    %ebp
     fc3:	c3                   	ret    
     fc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     fca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000fd0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     fd0:	55                   	push   %ebp
     fd1:	89 e5                	mov    %esp,%ebp
     fd3:	8b 55 08             	mov    0x8(%ebp),%edx
     fd6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     fd7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     fda:	8b 45 0c             	mov    0xc(%ebp),%eax
     fdd:	89 d7                	mov    %edx,%edi
     fdf:	fc                   	cld    
     fe0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     fe2:	5f                   	pop    %edi
     fe3:	89 d0                	mov    %edx,%eax
     fe5:	5d                   	pop    %ebp
     fe6:	c3                   	ret    
     fe7:	89 f6                	mov    %esi,%esi
     fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ff0 <strchr>:

char*
strchr(const char *s, char c)
{
     ff0:	55                   	push   %ebp
     ff1:	89 e5                	mov    %esp,%ebp
     ff3:	8b 45 08             	mov    0x8(%ebp),%eax
     ff6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     ffa:	0f b6 10             	movzbl (%eax),%edx
     ffd:	84 d2                	test   %dl,%dl
     fff:	74 1b                	je     101c <strchr+0x2c>
    if(*s == c)
    1001:	38 d1                	cmp    %dl,%cl
    1003:	75 0f                	jne    1014 <strchr+0x24>
    1005:	eb 17                	jmp    101e <strchr+0x2e>
    1007:	89 f6                	mov    %esi,%esi
    1009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    1010:	38 ca                	cmp    %cl,%dl
    1012:	74 0a                	je     101e <strchr+0x2e>
  for(; *s; s++)
    1014:	40                   	inc    %eax
    1015:	0f b6 10             	movzbl (%eax),%edx
    1018:	84 d2                	test   %dl,%dl
    101a:	75 f4                	jne    1010 <strchr+0x20>
      return (char*)s;
  return 0;
    101c:	31 c0                	xor    %eax,%eax
}
    101e:	5d                   	pop    %ebp
    101f:	c3                   	ret    

00001020 <gets>:

char*
gets(char *buf, int max)
{
    1020:	55                   	push   %ebp
    1021:	89 e5                	mov    %esp,%ebp
    1023:	57                   	push   %edi
    1024:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1025:	31 f6                	xor    %esi,%esi
{
    1027:	53                   	push   %ebx
    1028:	83 ec 3c             	sub    $0x3c,%esp
    102b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
    102e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
    1031:	eb 32                	jmp    1065 <gets+0x45>
    1033:	90                   	nop
    1034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
    1038:	ba 01 00 00 00       	mov    $0x1,%edx
    103d:	89 54 24 08          	mov    %edx,0x8(%esp)
    1041:	89 7c 24 04          	mov    %edi,0x4(%esp)
    1045:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    104c:	e8 2f 01 00 00       	call   1180 <read>
    if(cc < 1)
    1051:	85 c0                	test   %eax,%eax
    1053:	7e 19                	jle    106e <gets+0x4e>
      break;
    buf[i++] = c;
    1055:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1059:	43                   	inc    %ebx
    105a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
    105d:	3c 0a                	cmp    $0xa,%al
    105f:	74 1f                	je     1080 <gets+0x60>
    1061:	3c 0d                	cmp    $0xd,%al
    1063:	74 1b                	je     1080 <gets+0x60>
  for(i=0; i+1 < max; ){
    1065:	46                   	inc    %esi
    1066:	3b 75 0c             	cmp    0xc(%ebp),%esi
    1069:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    106c:	7c ca                	jl     1038 <gets+0x18>
      break;
  }
  buf[i] = '\0';
    106e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1071:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
    1074:	8b 45 08             	mov    0x8(%ebp),%eax
    1077:	83 c4 3c             	add    $0x3c,%esp
    107a:	5b                   	pop    %ebx
    107b:	5e                   	pop    %esi
    107c:	5f                   	pop    %edi
    107d:	5d                   	pop    %ebp
    107e:	c3                   	ret    
    107f:	90                   	nop
    1080:	8b 45 08             	mov    0x8(%ebp),%eax
    1083:	01 c6                	add    %eax,%esi
    1085:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    1088:	eb e4                	jmp    106e <gets+0x4e>
    108a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001090 <stat>:

int
stat(const char *n, struct stat *st)
{
    1090:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1091:	31 c0                	xor    %eax,%eax
{
    1093:	89 e5                	mov    %esp,%ebp
    1095:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
    1098:	89 44 24 04          	mov    %eax,0x4(%esp)
    109c:	8b 45 08             	mov    0x8(%ebp),%eax
{
    109f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    10a2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
    10a5:	89 04 24             	mov    %eax,(%esp)
    10a8:	e8 fb 00 00 00       	call   11a8 <open>
  if(fd < 0)
    10ad:	85 c0                	test   %eax,%eax
    10af:	78 2f                	js     10e0 <stat+0x50>
    10b1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    10b3:	8b 45 0c             	mov    0xc(%ebp),%eax
    10b6:	89 1c 24             	mov    %ebx,(%esp)
    10b9:	89 44 24 04          	mov    %eax,0x4(%esp)
    10bd:	e8 fe 00 00 00       	call   11c0 <fstat>
  close(fd);
    10c2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    10c5:	89 c6                	mov    %eax,%esi
  close(fd);
    10c7:	e8 c4 00 00 00       	call   1190 <close>
  return r;
}
    10cc:	89 f0                	mov    %esi,%eax
    10ce:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    10d1:	8b 75 fc             	mov    -0x4(%ebp),%esi
    10d4:	89 ec                	mov    %ebp,%esp
    10d6:	5d                   	pop    %ebp
    10d7:	c3                   	ret    
    10d8:	90                   	nop
    10d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
    10e0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    10e5:	eb e5                	jmp    10cc <stat+0x3c>
    10e7:	89 f6                	mov    %esi,%esi
    10e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000010f0 <atoi>:

int
atoi(const char *s)
{
    10f0:	55                   	push   %ebp
    10f1:	89 e5                	mov    %esp,%ebp
    10f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
    10f6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    10f7:	0f be 11             	movsbl (%ecx),%edx
    10fa:	88 d0                	mov    %dl,%al
    10fc:	2c 30                	sub    $0x30,%al
    10fe:	3c 09                	cmp    $0x9,%al
  n = 0;
    1100:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    1105:	77 1e                	ja     1125 <atoi+0x35>
    1107:	89 f6                	mov    %esi,%esi
    1109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    1110:	41                   	inc    %ecx
    1111:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1114:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    1118:	0f be 11             	movsbl (%ecx),%edx
    111b:	88 d3                	mov    %dl,%bl
    111d:	80 eb 30             	sub    $0x30,%bl
    1120:	80 fb 09             	cmp    $0x9,%bl
    1123:	76 eb                	jbe    1110 <atoi+0x20>
  return n;
}
    1125:	5b                   	pop    %ebx
    1126:	5d                   	pop    %ebp
    1127:	c3                   	ret    
    1128:	90                   	nop
    1129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001130 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1130:	55                   	push   %ebp
    1131:	89 e5                	mov    %esp,%ebp
    1133:	56                   	push   %esi
    1134:	8b 45 08             	mov    0x8(%ebp),%eax
    1137:	53                   	push   %ebx
    1138:	8b 5d 10             	mov    0x10(%ebp),%ebx
    113b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    113e:	85 db                	test   %ebx,%ebx
    1140:	7e 1a                	jle    115c <memmove+0x2c>
    1142:	31 d2                	xor    %edx,%edx
    1144:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    114a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
    1150:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    1154:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    1157:	42                   	inc    %edx
  while(n-- > 0)
    1158:	39 d3                	cmp    %edx,%ebx
    115a:	75 f4                	jne    1150 <memmove+0x20>
  return vdst;
}
    115c:	5b                   	pop    %ebx
    115d:	5e                   	pop    %esi
    115e:	5d                   	pop    %ebp
    115f:	c3                   	ret    

00001160 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1160:	b8 01 00 00 00       	mov    $0x1,%eax
    1165:	cd 40                	int    $0x40
    1167:	c3                   	ret    

00001168 <exit>:
SYSCALL(exit)
    1168:	b8 02 00 00 00       	mov    $0x2,%eax
    116d:	cd 40                	int    $0x40
    116f:	c3                   	ret    

00001170 <wait>:
SYSCALL(wait)
    1170:	b8 03 00 00 00       	mov    $0x3,%eax
    1175:	cd 40                	int    $0x40
    1177:	c3                   	ret    

00001178 <pipe>:
SYSCALL(pipe)
    1178:	b8 04 00 00 00       	mov    $0x4,%eax
    117d:	cd 40                	int    $0x40
    117f:	c3                   	ret    

00001180 <read>:
SYSCALL(read)
    1180:	b8 05 00 00 00       	mov    $0x5,%eax
    1185:	cd 40                	int    $0x40
    1187:	c3                   	ret    

00001188 <write>:
SYSCALL(write)
    1188:	b8 10 00 00 00       	mov    $0x10,%eax
    118d:	cd 40                	int    $0x40
    118f:	c3                   	ret    

00001190 <close>:
SYSCALL(close)
    1190:	b8 15 00 00 00       	mov    $0x15,%eax
    1195:	cd 40                	int    $0x40
    1197:	c3                   	ret    

00001198 <kill>:
SYSCALL(kill)
    1198:	b8 06 00 00 00       	mov    $0x6,%eax
    119d:	cd 40                	int    $0x40
    119f:	c3                   	ret    

000011a0 <exec>:
SYSCALL(exec)
    11a0:	b8 07 00 00 00       	mov    $0x7,%eax
    11a5:	cd 40                	int    $0x40
    11a7:	c3                   	ret    

000011a8 <open>:
SYSCALL(open)
    11a8:	b8 0f 00 00 00       	mov    $0xf,%eax
    11ad:	cd 40                	int    $0x40
    11af:	c3                   	ret    

000011b0 <mknod>:
SYSCALL(mknod)
    11b0:	b8 11 00 00 00       	mov    $0x11,%eax
    11b5:	cd 40                	int    $0x40
    11b7:	c3                   	ret    

000011b8 <unlink>:
SYSCALL(unlink)
    11b8:	b8 12 00 00 00       	mov    $0x12,%eax
    11bd:	cd 40                	int    $0x40
    11bf:	c3                   	ret    

000011c0 <fstat>:
SYSCALL(fstat)
    11c0:	b8 08 00 00 00       	mov    $0x8,%eax
    11c5:	cd 40                	int    $0x40
    11c7:	c3                   	ret    

000011c8 <link>:
SYSCALL(link)
    11c8:	b8 13 00 00 00       	mov    $0x13,%eax
    11cd:	cd 40                	int    $0x40
    11cf:	c3                   	ret    

000011d0 <mkdir>:
SYSCALL(mkdir)
    11d0:	b8 14 00 00 00       	mov    $0x14,%eax
    11d5:	cd 40                	int    $0x40
    11d7:	c3                   	ret    

000011d8 <chdir>:
SYSCALL(chdir)
    11d8:	b8 09 00 00 00       	mov    $0x9,%eax
    11dd:	cd 40                	int    $0x40
    11df:	c3                   	ret    

000011e0 <dup>:
SYSCALL(dup)
    11e0:	b8 0a 00 00 00       	mov    $0xa,%eax
    11e5:	cd 40                	int    $0x40
    11e7:	c3                   	ret    

000011e8 <getpid>:
SYSCALL(getpid)
    11e8:	b8 0b 00 00 00       	mov    $0xb,%eax
    11ed:	cd 40                	int    $0x40
    11ef:	c3                   	ret    

000011f0 <sbrk>:
SYSCALL(sbrk)
    11f0:	b8 0c 00 00 00       	mov    $0xc,%eax
    11f5:	cd 40                	int    $0x40
    11f7:	c3                   	ret    

000011f8 <sleep>:
SYSCALL(sleep)
    11f8:	b8 0d 00 00 00       	mov    $0xd,%eax
    11fd:	cd 40                	int    $0x40
    11ff:	c3                   	ret    

00001200 <uptime>:
SYSCALL(uptime)
    1200:	b8 0e 00 00 00       	mov    $0xe,%eax
    1205:	cd 40                	int    $0x40
    1207:	c3                   	ret    

00001208 <policy>:
SYSCALL(policy)
    1208:	b8 17 00 00 00       	mov    $0x17,%eax
    120d:	cd 40                	int    $0x40
    120f:	c3                   	ret    

00001210 <detach>:
SYSCALL(detach)
    1210:	b8 16 00 00 00       	mov    $0x16,%eax
    1215:	cd 40                	int    $0x40
    1217:	c3                   	ret    

00001218 <priority>:
SYSCALL(priority)
    1218:	b8 18 00 00 00       	mov    $0x18,%eax
    121d:	cd 40                	int    $0x40
    121f:	c3                   	ret    

00001220 <wait_stat>:
SYSCALL(wait_stat)
    1220:	b8 19 00 00 00       	mov    $0x19,%eax
    1225:	cd 40                	int    $0x40
    1227:	c3                   	ret    
    1228:	66 90                	xchg   %ax,%ax
    122a:	66 90                	xchg   %ax,%ax
    122c:	66 90                	xchg   %ax,%ax
    122e:	66 90                	xchg   %ax,%ax

00001230 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1230:	55                   	push   %ebp
    1231:	89 e5                	mov    %esp,%ebp
    1233:	57                   	push   %edi
    1234:	56                   	push   %esi
    1235:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1236:	89 d3                	mov    %edx,%ebx
    1238:	c1 eb 1f             	shr    $0x1f,%ebx
{
    123b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
    123e:	84 db                	test   %bl,%bl
{
    1240:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1243:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    1245:	74 79                	je     12c0 <printint+0x90>
    1247:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    124b:	74 73                	je     12c0 <printint+0x90>
    neg = 1;
    x = -xx;
    124d:	f7 d8                	neg    %eax
    neg = 1;
    124f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1256:	31 f6                	xor    %esi,%esi
    1258:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    125b:	eb 05                	jmp    1262 <printint+0x32>
    125d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1260:	89 fe                	mov    %edi,%esi
    1262:	31 d2                	xor    %edx,%edx
    1264:	f7 f1                	div    %ecx
    1266:	8d 7e 01             	lea    0x1(%esi),%edi
    1269:	0f b6 92 74 17 00 00 	movzbl 0x1774(%edx),%edx
  }while((x /= base) != 0);
    1270:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    1272:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    1275:	75 e9                	jne    1260 <printint+0x30>
  if(neg)
    1277:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    127a:	85 d2                	test   %edx,%edx
    127c:	74 08                	je     1286 <printint+0x56>
    buf[i++] = '-';
    127e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    1283:	8d 7e 02             	lea    0x2(%esi),%edi
    1286:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    128a:	8b 7d c0             	mov    -0x40(%ebp),%edi
    128d:	8d 76 00             	lea    0x0(%esi),%esi
    1290:	0f b6 06             	movzbl (%esi),%eax
    1293:	4e                   	dec    %esi
  write(fd, &c, 1);
    1294:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    1298:	89 3c 24             	mov    %edi,(%esp)
    129b:	88 45 d7             	mov    %al,-0x29(%ebp)
    129e:	b8 01 00 00 00       	mov    $0x1,%eax
    12a3:	89 44 24 08          	mov    %eax,0x8(%esp)
    12a7:	e8 dc fe ff ff       	call   1188 <write>

  while(--i >= 0)
    12ac:	39 de                	cmp    %ebx,%esi
    12ae:	75 e0                	jne    1290 <printint+0x60>
    putc(fd, buf[i]);
}
    12b0:	83 c4 4c             	add    $0x4c,%esp
    12b3:	5b                   	pop    %ebx
    12b4:	5e                   	pop    %esi
    12b5:	5f                   	pop    %edi
    12b6:	5d                   	pop    %ebp
    12b7:	c3                   	ret    
    12b8:	90                   	nop
    12b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    12c0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    12c7:	eb 8d                	jmp    1256 <printint+0x26>
    12c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000012d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    12d0:	55                   	push   %ebp
    12d1:	89 e5                	mov    %esp,%ebp
    12d3:	57                   	push   %edi
    12d4:	56                   	push   %esi
    12d5:	53                   	push   %ebx
    12d6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    12d9:	8b 75 0c             	mov    0xc(%ebp),%esi
    12dc:	0f b6 1e             	movzbl (%esi),%ebx
    12df:	84 db                	test   %bl,%bl
    12e1:	0f 84 d1 00 00 00    	je     13b8 <printf+0xe8>
  state = 0;
    12e7:	31 ff                	xor    %edi,%edi
    12e9:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
    12ea:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
    12ed:	89 fa                	mov    %edi,%edx
    12ef:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
    12f2:	89 45 d0             	mov    %eax,-0x30(%ebp)
    12f5:	eb 41                	jmp    1338 <printf+0x68>
    12f7:	89 f6                	mov    %esi,%esi
    12f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1300:	83 f8 25             	cmp    $0x25,%eax
    1303:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
    1306:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    130b:	74 1e                	je     132b <printf+0x5b>
  write(fd, &c, 1);
    130d:	b8 01 00 00 00       	mov    $0x1,%eax
    1312:	89 44 24 08          	mov    %eax,0x8(%esp)
    1316:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1319:	89 44 24 04          	mov    %eax,0x4(%esp)
    131d:	89 3c 24             	mov    %edi,(%esp)
    1320:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    1323:	e8 60 fe ff ff       	call   1188 <write>
    1328:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    132b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
    132c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    1330:	84 db                	test   %bl,%bl
    1332:	0f 84 80 00 00 00    	je     13b8 <printf+0xe8>
    if(state == 0){
    1338:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
    133a:	0f be cb             	movsbl %bl,%ecx
    133d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1340:	74 be                	je     1300 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1342:	83 fa 25             	cmp    $0x25,%edx
    1345:	75 e4                	jne    132b <printf+0x5b>
      if(c == 'd'){
    1347:	83 f8 64             	cmp    $0x64,%eax
    134a:	0f 84 f0 00 00 00    	je     1440 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1350:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    1356:	83 f9 70             	cmp    $0x70,%ecx
    1359:	74 65                	je     13c0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    135b:	83 f8 73             	cmp    $0x73,%eax
    135e:	0f 84 8c 00 00 00    	je     13f0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1364:	83 f8 63             	cmp    $0x63,%eax
    1367:	0f 84 13 01 00 00    	je     1480 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    136d:	83 f8 25             	cmp    $0x25,%eax
    1370:	0f 84 e2 00 00 00    	je     1458 <printf+0x188>
  write(fd, &c, 1);
    1376:	b8 01 00 00 00       	mov    $0x1,%eax
    137b:	46                   	inc    %esi
    137c:	89 44 24 08          	mov    %eax,0x8(%esp)
    1380:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1383:	89 44 24 04          	mov    %eax,0x4(%esp)
    1387:	89 3c 24             	mov    %edi,(%esp)
    138a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    138e:	e8 f5 fd ff ff       	call   1188 <write>
    1393:	ba 01 00 00 00       	mov    $0x1,%edx
    1398:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    139b:	89 54 24 08          	mov    %edx,0x8(%esp)
    139f:	89 44 24 04          	mov    %eax,0x4(%esp)
    13a3:	89 3c 24             	mov    %edi,(%esp)
    13a6:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    13a9:	e8 da fd ff ff       	call   1188 <write>
  for(i = 0; fmt[i]; i++){
    13ae:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    13b2:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    13b4:	84 db                	test   %bl,%bl
    13b6:	75 80                	jne    1338 <printf+0x68>
    }
  }
}
    13b8:	83 c4 3c             	add    $0x3c,%esp
    13bb:	5b                   	pop    %ebx
    13bc:	5e                   	pop    %esi
    13bd:	5f                   	pop    %edi
    13be:	5d                   	pop    %ebp
    13bf:	c3                   	ret    
        printint(fd, *ap, 16, 0);
    13c0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    13c7:	b9 10 00 00 00       	mov    $0x10,%ecx
    13cc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    13cf:	89 f8                	mov    %edi,%eax
    13d1:	8b 13                	mov    (%ebx),%edx
    13d3:	e8 58 fe ff ff       	call   1230 <printint>
        ap++;
    13d8:	89 d8                	mov    %ebx,%eax
      state = 0;
    13da:	31 d2                	xor    %edx,%edx
        ap++;
    13dc:	83 c0 04             	add    $0x4,%eax
    13df:	89 45 d0             	mov    %eax,-0x30(%ebp)
    13e2:	e9 44 ff ff ff       	jmp    132b <printf+0x5b>
    13e7:	89 f6                	mov    %esi,%esi
    13e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
    13f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
    13f3:	8b 10                	mov    (%eax),%edx
        ap++;
    13f5:	83 c0 04             	add    $0x4,%eax
    13f8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    13fb:	85 d2                	test   %edx,%edx
    13fd:	0f 84 aa 00 00 00    	je     14ad <printf+0x1dd>
        while(*s != 0){
    1403:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
    1406:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
    1408:	84 c0                	test   %al,%al
    140a:	74 27                	je     1433 <printf+0x163>
    140c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1410:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    1413:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
    1418:	43                   	inc    %ebx
  write(fd, &c, 1);
    1419:	89 44 24 08          	mov    %eax,0x8(%esp)
    141d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    1420:	89 44 24 04          	mov    %eax,0x4(%esp)
    1424:	89 3c 24             	mov    %edi,(%esp)
    1427:	e8 5c fd ff ff       	call   1188 <write>
        while(*s != 0){
    142c:	0f b6 03             	movzbl (%ebx),%eax
    142f:	84 c0                	test   %al,%al
    1431:	75 dd                	jne    1410 <printf+0x140>
      state = 0;
    1433:	31 d2                	xor    %edx,%edx
    1435:	e9 f1 fe ff ff       	jmp    132b <printf+0x5b>
    143a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    1440:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1447:	b9 0a 00 00 00       	mov    $0xa,%ecx
    144c:	e9 7b ff ff ff       	jmp    13cc <printf+0xfc>
    1451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
    1458:	b9 01 00 00 00       	mov    $0x1,%ecx
    145d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1460:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    1464:	89 44 24 04          	mov    %eax,0x4(%esp)
    1468:	89 3c 24             	mov    %edi,(%esp)
    146b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    146e:	e8 15 fd ff ff       	call   1188 <write>
      state = 0;
    1473:	31 d2                	xor    %edx,%edx
    1475:	e9 b1 fe ff ff       	jmp    132b <printf+0x5b>
    147a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
    1480:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    1483:	8b 03                	mov    (%ebx),%eax
        ap++;
    1485:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    1488:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
    148b:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    148e:	b8 01 00 00 00       	mov    $0x1,%eax
    1493:	89 44 24 08          	mov    %eax,0x8(%esp)
    1497:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    149a:	89 44 24 04          	mov    %eax,0x4(%esp)
    149e:	e8 e5 fc ff ff       	call   1188 <write>
      state = 0;
    14a3:	31 d2                	xor    %edx,%edx
        ap++;
    14a5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    14a8:	e9 7e fe ff ff       	jmp    132b <printf+0x5b>
          s = "(null)";
    14ad:	bb 6c 17 00 00       	mov    $0x176c,%ebx
        while(*s != 0){
    14b2:	b0 28                	mov    $0x28,%al
    14b4:	e9 57 ff ff ff       	jmp    1410 <printf+0x140>
    14b9:	66 90                	xchg   %ax,%ax
    14bb:	66 90                	xchg   %ax,%ax
    14bd:	66 90                	xchg   %ax,%ax
    14bf:	90                   	nop

000014c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    14c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14c1:	a1 20 1e 00 00       	mov    0x1e20,%eax
{
    14c6:	89 e5                	mov    %esp,%ebp
    14c8:	57                   	push   %edi
    14c9:	56                   	push   %esi
    14ca:	53                   	push   %ebx
    14cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    14ce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    14d1:	eb 0d                	jmp    14e0 <free+0x20>
    14d3:	90                   	nop
    14d4:	90                   	nop
    14d5:	90                   	nop
    14d6:	90                   	nop
    14d7:	90                   	nop
    14d8:	90                   	nop
    14d9:	90                   	nop
    14da:	90                   	nop
    14db:	90                   	nop
    14dc:	90                   	nop
    14dd:	90                   	nop
    14de:	90                   	nop
    14df:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14e0:	39 c8                	cmp    %ecx,%eax
    14e2:	8b 10                	mov    (%eax),%edx
    14e4:	73 32                	jae    1518 <free+0x58>
    14e6:	39 d1                	cmp    %edx,%ecx
    14e8:	72 04                	jb     14ee <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14ea:	39 d0                	cmp    %edx,%eax
    14ec:	72 32                	jb     1520 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
    14ee:	8b 73 fc             	mov    -0x4(%ebx),%esi
    14f1:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    14f4:	39 fa                	cmp    %edi,%edx
    14f6:	74 30                	je     1528 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    14f8:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    14fb:	8b 50 04             	mov    0x4(%eax),%edx
    14fe:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1501:	39 f1                	cmp    %esi,%ecx
    1503:	74 3c                	je     1541 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1505:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
    1507:	5b                   	pop    %ebx
  freep = p;
    1508:	a3 20 1e 00 00       	mov    %eax,0x1e20
}
    150d:	5e                   	pop    %esi
    150e:	5f                   	pop    %edi
    150f:	5d                   	pop    %ebp
    1510:	c3                   	ret    
    1511:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1518:	39 d0                	cmp    %edx,%eax
    151a:	72 04                	jb     1520 <free+0x60>
    151c:	39 d1                	cmp    %edx,%ecx
    151e:	72 ce                	jb     14ee <free+0x2e>
{
    1520:	89 d0                	mov    %edx,%eax
    1522:	eb bc                	jmp    14e0 <free+0x20>
    1524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1528:	8b 7a 04             	mov    0x4(%edx),%edi
    152b:	01 fe                	add    %edi,%esi
    152d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1530:	8b 10                	mov    (%eax),%edx
    1532:	8b 12                	mov    (%edx),%edx
    1534:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1537:	8b 50 04             	mov    0x4(%eax),%edx
    153a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    153d:	39 f1                	cmp    %esi,%ecx
    153f:	75 c4                	jne    1505 <free+0x45>
    p->s.size += bp->s.size;
    1541:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
    1544:	a3 20 1e 00 00       	mov    %eax,0x1e20
    p->s.size += bp->s.size;
    1549:	01 ca                	add    %ecx,%edx
    154b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    154e:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1551:	89 10                	mov    %edx,(%eax)
}
    1553:	5b                   	pop    %ebx
    1554:	5e                   	pop    %esi
    1555:	5f                   	pop    %edi
    1556:	5d                   	pop    %ebp
    1557:	c3                   	ret    
    1558:	90                   	nop
    1559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001560 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1560:	55                   	push   %ebp
    1561:	89 e5                	mov    %esp,%ebp
    1563:	57                   	push   %edi
    1564:	56                   	push   %esi
    1565:	53                   	push   %ebx
    1566:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1569:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    156c:	8b 15 20 1e 00 00    	mov    0x1e20,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1572:	8d 78 07             	lea    0x7(%eax),%edi
    1575:	c1 ef 03             	shr    $0x3,%edi
    1578:	47                   	inc    %edi
  if((prevp = freep) == 0){
    1579:	85 d2                	test   %edx,%edx
    157b:	0f 84 8f 00 00 00    	je     1610 <malloc+0xb0>
    1581:	8b 02                	mov    (%edx),%eax
    1583:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1586:	39 cf                	cmp    %ecx,%edi
    1588:	76 66                	jbe    15f0 <malloc+0x90>
    158a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1590:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1595:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    1598:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    159f:	eb 10                	jmp    15b1 <malloc+0x51>
    15a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15a8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    15aa:	8b 48 04             	mov    0x4(%eax),%ecx
    15ad:	39 f9                	cmp    %edi,%ecx
    15af:	73 3f                	jae    15f0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    15b1:	39 05 20 1e 00 00    	cmp    %eax,0x1e20
    15b7:	89 c2                	mov    %eax,%edx
    15b9:	75 ed                	jne    15a8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    15bb:	89 34 24             	mov    %esi,(%esp)
    15be:	e8 2d fc ff ff       	call   11f0 <sbrk>
  if(p == (char*)-1)
    15c3:	83 f8 ff             	cmp    $0xffffffff,%eax
    15c6:	74 18                	je     15e0 <malloc+0x80>
  hp->s.size = nu;
    15c8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    15cb:	83 c0 08             	add    $0x8,%eax
    15ce:	89 04 24             	mov    %eax,(%esp)
    15d1:	e8 ea fe ff ff       	call   14c0 <free>
  return freep;
    15d6:	8b 15 20 1e 00 00    	mov    0x1e20,%edx
      if((p = morecore(nunits)) == 0)
    15dc:	85 d2                	test   %edx,%edx
    15de:	75 c8                	jne    15a8 <malloc+0x48>
        return 0;
  }
}
    15e0:	83 c4 1c             	add    $0x1c,%esp
        return 0;
    15e3:	31 c0                	xor    %eax,%eax
}
    15e5:	5b                   	pop    %ebx
    15e6:	5e                   	pop    %esi
    15e7:	5f                   	pop    %edi
    15e8:	5d                   	pop    %ebp
    15e9:	c3                   	ret    
    15ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    15f0:	39 cf                	cmp    %ecx,%edi
    15f2:	74 4c                	je     1640 <malloc+0xe0>
        p->s.size -= nunits;
    15f4:	29 f9                	sub    %edi,%ecx
    15f6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    15f9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    15fc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    15ff:	89 15 20 1e 00 00    	mov    %edx,0x1e20
}
    1605:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
    1608:	83 c0 08             	add    $0x8,%eax
}
    160b:	5b                   	pop    %ebx
    160c:	5e                   	pop    %esi
    160d:	5f                   	pop    %edi
    160e:	5d                   	pop    %ebp
    160f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    1610:	b8 24 1e 00 00       	mov    $0x1e24,%eax
    1615:	ba 24 1e 00 00       	mov    $0x1e24,%edx
    base.s.size = 0;
    161a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
    161c:	a3 20 1e 00 00       	mov    %eax,0x1e20
    base.s.size = 0;
    1621:	b8 24 1e 00 00       	mov    $0x1e24,%eax
    base.s.ptr = freep = prevp = &base;
    1626:	89 15 24 1e 00 00    	mov    %edx,0x1e24
    base.s.size = 0;
    162c:	89 0d 28 1e 00 00    	mov    %ecx,0x1e28
    1632:	e9 53 ff ff ff       	jmp    158a <malloc+0x2a>
    1637:	89 f6                	mov    %esi,%esi
    1639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
    1640:	8b 08                	mov    (%eax),%ecx
    1642:	89 0a                	mov    %ecx,(%edx)
    1644:	eb b9                	jmp    15ff <malloc+0x9f>
