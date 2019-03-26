
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
    static char buf[100];
    int fd;

    // Ensure that three file descriptors are open.
    while((fd = open("console", O_RDWR)) >= 0){
       9:	eb 0e                	jmp    19 <main+0x19>
       b:	90                   	nop
       c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(fd >= 3){
      10:	83 f8 02             	cmp    $0x2,%eax
      13:	0f 8f d2 00 00 00    	jg     eb <main+0xeb>
    while((fd = open("console", O_RDWR)) >= 0){
      19:	b9 02 00 00 00       	mov    $0x2,%ecx
      1e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
      22:	c7 04 24 d9 16 00 00 	movl   $0x16d9,(%esp)
      29:	e8 6a 11 00 00       	call   1198 <open>
      2e:	85 c0                	test   %eax,%eax
      30:	79 de                	jns    10 <main+0x10>


    // from here
    int fd2;

    if((fd2 = open("path", O_RDWR)) >= 0){
      32:	ba 02 00 00 00       	mov    $0x2,%edx
      37:	89 54 24 04          	mov    %edx,0x4(%esp)
      3b:	c7 04 24 e1 16 00 00 	movl   $0x16e1,(%esp)
      42:	e8 51 11 00 00       	call   1198 <open>
      47:	85 c0                	test   %eax,%eax
      49:	78 27                	js     72 <main+0x72>
      4b:	e9 a8 00 00 00       	jmp    f8 <main+0xf8>
int
fork1(void)
{
    int pid;

    pid = fork();
      50:	e8 fb 10 00 00       	call   1150 <fork>
    if(pid == -1)
      55:	83 f8 ff             	cmp    $0xffffffff,%eax
      58:	0f 84 e6 00 00 00    	je     144 <main+0x144>
        if(fork1() == 0)
      5e:	85 c0                	test   %eax,%eax
      60:	0f 84 ea 00 00 00    	je     150 <main+0x150>
        wait(0);
      66:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      6d:	e8 ee 10 00 00       	call   1160 <wait>
    while(getcmd(buf, sizeof(buf)) >= 0){
      72:	b8 64 00 00 00       	mov    $0x64,%eax
      77:	89 44 24 04          	mov    %eax,0x4(%esp)
      7b:	c7 04 24 00 1e 00 00 	movl   $0x1e00,(%esp)
      82:	e8 69 03 00 00       	call   3f0 <getcmd>
      87:	85 c0                	test   %eax,%eax
      89:	0f 88 a9 00 00 00    	js     138 <main+0x138>
        if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      8f:	80 3d 00 1e 00 00 63 	cmpb   $0x63,0x1e00
      96:	75 b8                	jne    50 <main+0x50>
      98:	80 3d 01 1e 00 00 64 	cmpb   $0x64,0x1e01
      9f:	75 af                	jne    50 <main+0x50>
      a1:	80 3d 02 1e 00 00 20 	cmpb   $0x20,0x1e02
      a8:	75 a6                	jne    50 <main+0x50>
            buf[strlen(buf)-1] = 0;  // chop \n
      aa:	c7 04 24 00 1e 00 00 	movl   $0x1e00,(%esp)
      b1:	e8 da 0e 00 00       	call   f90 <strlen>
            if(chdir(buf+3) < 0)
      b6:	c7 04 24 03 1e 00 00 	movl   $0x1e03,(%esp)
            buf[strlen(buf)-1] = 0;  // chop \n
      bd:	c6 80 ff 1d 00 00 00 	movb   $0x0,0x1dff(%eax)
            if(chdir(buf+3) < 0)
      c4:	e8 ff 10 00 00       	call   11c8 <chdir>
      c9:	85 c0                	test   %eax,%eax
      cb:	79 a5                	jns    72 <main+0x72>
                printf(2, "cannot cd %s\n", buf+3);
      cd:	c7 44 24 08 03 1e 00 	movl   $0x1e03,0x8(%esp)
      d4:	00 
      d5:	c7 44 24 04 e6 16 00 	movl   $0x16e6,0x4(%esp)
      dc:	00 
      dd:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      e4:	e8 d7 11 00 00       	call   12c0 <printf>
      e9:	eb 87                	jmp    72 <main+0x72>
            close(fd);
      eb:	89 04 24             	mov    %eax,(%esp)
      ee:	e8 8d 10 00 00       	call   1180 <close>
            break;
      f3:	e9 3a ff ff ff       	jmp    32 <main+0x32>
        if( read(fd2, PATH, sizeof(PATH)) < 0 ){
      f8:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
      ff:	00 
     100:	c7 44 24 04 80 1e 00 	movl   $0x1e80,0x4(%esp)
     107:	00 
     108:	89 04 24             	mov    %eax,(%esp)
     10b:	e8 60 10 00 00       	call   1170 <read>
     110:	85 c0                	test   %eax,%eax
     112:	0f 89 5a ff ff ff    	jns    72 <main+0x72>
            printf(1, "error: read from path file failed\n");
     118:	c7 44 24 04 24 17 00 	movl   $0x1724,0x4(%esp)
     11f:	00 
     120:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     127:	e8 94 11 00 00       	call   12c0 <printf>
            exit(0);
     12c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     133:	e8 20 10 00 00       	call   1158 <exit>
    exit(0);
     138:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     13f:	e8 14 10 00 00       	call   1158 <exit>
        panic("fork");
     144:	c7 04 24 62 16 00 00 	movl   $0x1662,(%esp)
     14b:	e8 00 03 00 00       	call   450 <panic>
            runcmd(parsecmd(buf));
     150:	c7 04 24 00 1e 00 00 	movl   $0x1e00,(%esp)
     157:	e8 54 0d 00 00       	call   eb0 <parsecmd>
     15c:	89 04 24             	mov    %eax,(%esp)
     15f:	e8 1c 03 00 00       	call   480 <runcmd>
     164:	66 90                	xchg   %ax,%ax
     166:	66 90                	xchg   %ax,%ax
     168:	66 90                	xchg   %ax,%ax
     16a:	66 90                	xchg   %ax,%ax
     16c:	66 90                	xchg   %ax,%ax
     16e:	66 90                	xchg   %ax,%ax

00000170 <swap>:
{
     170:	55                   	push   %ebp
     171:	89 e5                	mov    %esp,%ebp
     173:	8b 45 10             	mov    0x10(%ebp),%eax
     176:	53                   	push   %ebx
    char temp = str[a];
     177:	8b 55 08             	mov    0x8(%ebp),%edx
    str[a] = str[b];
     17a:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    char temp = str[a];
     17d:	01 c2                	add    %eax,%edx
    str[a] = str[b];
     17f:	01 d8                	add    %ebx,%eax
    char temp = str[a];
     181:	0f b6 0a             	movzbl (%edx),%ecx
    str[a] = str[b];
     184:	0f b6 18             	movzbl (%eax),%ebx
     187:	88 1a                	mov    %bl,(%edx)
    str[b] = temp;
     189:	88 08                	mov    %cl,(%eax)
}
     18b:	5b                   	pop    %ebx
     18c:	5d                   	pop    %ebp
     18d:	c3                   	ret    
     18e:	66 90                	xchg   %ax,%ax

00000190 <reverse_string>:
{
     190:	55                   	push   %ebp
     191:	89 e5                	mov    %esp,%ebp
     193:	57                   	push   %edi
     194:	56                   	push   %esi
     195:	53                   	push   %ebx
     196:	83 ec 2c             	sub    $0x2c,%esp
     199:	8b 5d 08             	mov    0x8(%ebp),%ebx
    int len = strlen( str ) - 1;
     19c:	89 1c 24             	mov    %ebx,(%esp)
     19f:	e8 ec 0d 00 00       	call   f90 <strlen>
     1a4:	8d 70 ff             	lea    -0x1(%eax),%esi
    for( i = 0 ; i < len ; i++ )
     1a7:	85 f6                	test   %esi,%esi
     1a9:	7e 43                	jle    1ee <reverse_string+0x5e>
    str[a] = str[b];
     1ab:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
    char temp = str[a];
     1ae:	0f b6 13             	movzbl (%ebx),%edx
        k--;
     1b1:	83 e8 02             	sub    $0x2,%eax
    str[a] = str[b];
     1b4:	0f b6 0f             	movzbl (%edi),%ecx
        if( k == len/2 )
     1b7:	d1 fe                	sar    %esi
     1b9:	39 f0                	cmp    %esi,%eax
    str[a] = str[b];
     1bb:	88 0b                	mov    %cl,(%ebx)
    str[b] = temp;
     1bd:	88 17                	mov    %dl,(%edi)
        if( k == len/2 )
     1bf:	74 2d                	je     1ee <reverse_string+0x5e>
     1c1:	8d 53 01             	lea    0x1(%ebx),%edx
     1c4:	eb 24                	jmp    1ea <reverse_string+0x5a>
     1c6:	8d 76 00             	lea    0x0(%esi),%esi
     1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    char temp = str[a];
     1d0:	0f b6 0a             	movzbl (%edx),%ecx
     1d3:	42                   	inc    %edx
     1d4:	88 4d e7             	mov    %cl,-0x19(%ebp)
    str[a] = str[b];
     1d7:	0f b6 0c 03          	movzbl (%ebx,%eax,1),%ecx
     1db:	88 4a ff             	mov    %cl,-0x1(%edx)
    str[b] = temp;
     1de:	0f b6 4d e7          	movzbl -0x19(%ebp),%ecx
     1e2:	88 0c 03             	mov    %cl,(%ebx,%eax,1)
        k--;
     1e5:	48                   	dec    %eax
        if( k == len/2 )
     1e6:	39 f0                	cmp    %esi,%eax
     1e8:	74 04                	je     1ee <reverse_string+0x5e>
    for( i = 0 ; i < len ; i++ )
     1ea:	85 c0                	test   %eax,%eax
     1ec:	75 e2                	jne    1d0 <reverse_string+0x40>
}
     1ee:	83 c4 2c             	add    $0x2c,%esp
     1f1:	5b                   	pop    %ebx
     1f2:	5e                   	pop    %esi
     1f3:	5f                   	pop    %edi
     1f4:	5d                   	pop    %ebp
     1f5:	c3                   	ret    
     1f6:	8d 76 00             	lea    0x0(%esi),%esi
     1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000200 <strconcat>:
strconcat (const char *first, const char *second, char* dest){
     200:	55                   	push   %ebp
     201:	89 e5                	mov    %esp,%ebp
     203:	56                   	push   %esi
     204:	8b 75 10             	mov    0x10(%ebp),%esi
     207:	53                   	push   %ebx
     208:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     20b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    while((*dest++ = *first++) != 0)
     20e:	89 f2                	mov    %esi,%edx
     210:	43                   	inc    %ebx
     211:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
     215:	42                   	inc    %edx
     216:	84 c0                	test   %al,%al
     218:	88 42 ff             	mov    %al,-0x1(%edx)
     21b:	75 f3                	jne    210 <strconcat+0x10>
    while((*dest++ = *second++) != 0)
     21d:	41                   	inc    %ecx
     21e:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
     222:	84 c0                	test   %al,%al
     224:	88 42 ff             	mov    %al,-0x1(%edx)
     227:	74 14                	je     23d <strconcat+0x3d>
     229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     230:	41                   	inc    %ecx
     231:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
     235:	42                   	inc    %edx
     236:	84 c0                	test   %al,%al
     238:	88 42 ff             	mov    %al,-0x1(%edx)
     23b:	75 f3                	jne    230 <strconcat+0x30>
}
     23d:	5b                   	pop    %ebx
     23e:	89 f0                	mov    %esi,%eax
     240:	5e                   	pop    %esi
     241:	5d                   	pop    %ebp
     242:	c3                   	ret    
     243:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <strcpyuntildelimiter>:
{
     250:	55                   	push   %ebp
     251:	89 e5                	mov    %esp,%ebp
     253:	8b 55 0c             	mov    0xc(%ebp),%edx
     256:	56                   	push   %esi
     257:	0f b6 45 10          	movzbl 0x10(%ebp),%eax
     25b:	53                   	push   %ebx
     25c:	8b 75 08             	mov    0x8(%ebp),%esi
    while((*s = *t) != delim && (*s = *t) !=0)
     25f:	0f b6 0a             	movzbl (%edx),%ecx
     262:	38 c8                	cmp    %cl,%al
     264:	88 0e                	mov    %cl,(%esi)
     266:	74 30                	je     298 <strcpyuntildelimiter+0x48>
     268:	0f b6 0a             	movzbl (%edx),%ecx
     26b:	84 c9                	test   %cl,%cl
     26d:	88 0e                	mov    %cl,(%esi)
     26f:	74 27                	je     298 <strcpyuntildelimiter+0x48>
     271:	89 f1                	mov    %esi,%ecx
     273:	eb 0c                	jmp    281 <strcpyuntildelimiter+0x31>
     275:	8d 76 00             	lea    0x0(%esi),%esi
     278:	0f b6 1a             	movzbl (%edx),%ebx
     27b:	84 db                	test   %bl,%bl
     27d:	88 19                	mov    %bl,(%ecx)
     27f:	74 0b                	je     28c <strcpyuntildelimiter+0x3c>
        s++,t++;
     281:	42                   	inc    %edx
    while((*s = *t) != delim && (*s = *t) !=0)
     282:	0f b6 1a             	movzbl (%edx),%ebx
        s++,t++;
     285:	41                   	inc    %ecx
    while((*s = *t) != delim && (*s = *t) !=0)
     286:	38 c3                	cmp    %al,%bl
     288:	88 19                	mov    %bl,(%ecx)
     28a:	75 ec                	jne    278 <strcpyuntildelimiter+0x28>
    *s='\0';
     28c:	c6 01 00             	movb   $0x0,(%ecx)
}
     28f:	89 f0                	mov    %esi,%eax
     291:	5b                   	pop    %ebx
     292:	5e                   	pop    %esi
     293:	5d                   	pop    %ebp
     294:	c3                   	ret    
     295:	8d 76 00             	lea    0x0(%esi),%esi
    while((*s = *t) != delim && (*s = *t) !=0)
     298:	89 f1                	mov    %esi,%ecx
}
     29a:	89 f0                	mov    %esi,%eax
    *s='\0';
     29c:	c6 01 00             	movb   $0x0,(%ecx)
}
     29f:	5b                   	pop    %ebx
     2a0:	5e                   	pop    %esi
     2a1:	5d                   	pop    %ebp
     2a2:	c3                   	ret    
     2a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     2a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002b0 <execWithPath>:
{
     2b0:	55                   	push   %ebp
     2b1:	89 e5                	mov    %esp,%ebp
     2b3:	57                   	push   %edi
     2b4:	56                   	push   %esi
     2b5:	53                   	push   %ebx
     2b6:	83 ec 1c             	sub    $0x1c,%esp
    char *curr_path = malloc(strlen(PATH));
     2b9:	c7 04 24 80 1e 00 00 	movl   $0x1e80,(%esp)
     2c0:	e8 cb 0c 00 00       	call   f90 <strlen>
     2c5:	89 04 24             	mov    %eax,(%esp)
     2c8:	e8 83 12 00 00       	call   1550 <malloc>
    strcpy( curr_path , PATH );
     2cd:	ba 80 1e 00 00       	mov    $0x1e80,%edx
     2d2:	89 54 24 04          	mov    %edx,0x4(%esp)
    char *curr_path = malloc(strlen(PATH));
     2d6:	89 c3                	mov    %eax,%ebx
    strcpy( curr_path , PATH );
     2d8:	89 04 24             	mov    %eax,(%esp)
     2db:	e8 50 0c 00 00       	call   f30 <strcpy>
    while( curr_path != NULL )
     2e0:	85 db                	test   %ebx,%ebx
     2e2:	0f 84 e4 00 00 00    	je     3cc <execWithPath+0x11c>
     2e8:	90                   	nop
     2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        char* str2= malloc(100);
     2f0:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
     2f7:	e8 54 12 00 00       	call   1550 <malloc>
     2fc:	89 c6                	mov    %eax,%esi
    while((*s = *t) != delim && (*s = *t) !=0)
     2fe:	0f b6 03             	movzbl (%ebx),%eax
     301:	3c 3a                	cmp    $0x3a,%al
     303:	88 06                	mov    %al,(%esi)
     305:	0f 84 dd 00 00 00    	je     3e8 <execWithPath+0x138>
     30b:	0f b6 03             	movzbl (%ebx),%eax
     30e:	84 c0                	test   %al,%al
     310:	88 06                	mov    %al,(%esi)
     312:	0f 84 d0 00 00 00    	je     3e8 <execWithPath+0x138>
     318:	89 d9                	mov    %ebx,%ecx
     31a:	89 f0                	mov    %esi,%eax
     31c:	eb 0b                	jmp    329 <execWithPath+0x79>
     31e:	66 90                	xchg   %ax,%ax
     320:	0f b6 11             	movzbl (%ecx),%edx
     323:	84 d2                	test   %dl,%dl
     325:	88 10                	mov    %dl,(%eax)
     327:	74 0c                	je     335 <execWithPath+0x85>
        s++,t++;
     329:	41                   	inc    %ecx
    while((*s = *t) != delim && (*s = *t) !=0)
     32a:	0f b6 11             	movzbl (%ecx),%edx
        s++,t++;
     32d:	40                   	inc    %eax
    while((*s = *t) != delim && (*s = *t) !=0)
     32e:	80 fa 3a             	cmp    $0x3a,%dl
     331:	88 10                	mov    %dl,(%eax)
     333:	75 eb                	jne    320 <execWithPath+0x70>
    *s='\0';
     335:	c6 00 00             	movb   $0x0,(%eax)
        curr_path=strchr(curr_path,':');
     338:	b8 3a 00 00 00       	mov    $0x3a,%eax
     33d:	89 1c 24             	mov    %ebx,(%esp)
     340:	89 44 24 04          	mov    %eax,0x4(%esp)
     344:	e8 97 0c 00 00       	call   fe0 <strchr>
        char* str3=malloc ((strlen(str2) + strlen(path) - 1));
     349:	89 34 24             	mov    %esi,(%esp)
            curr_path++;
     34c:	83 f8 01             	cmp    $0x1,%eax
        curr_path=strchr(curr_path,':');
     34f:	89 c3                	mov    %eax,%ebx
            curr_path++;
     351:	83 db ff             	sbb    $0xffffffff,%ebx
        char* str3=malloc ((strlen(str2) + strlen(path) - 1));
     354:	e8 37 0c 00 00       	call   f90 <strlen>
     359:	89 c7                	mov    %eax,%edi
     35b:	8b 45 08             	mov    0x8(%ebp),%eax
     35e:	89 04 24             	mov    %eax,(%esp)
     361:	e8 2a 0c 00 00       	call   f90 <strlen>
     366:	8d 44 07 ff          	lea    -0x1(%edi,%eax,1),%eax
     36a:	89 04 24             	mov    %eax,(%esp)
     36d:	e8 de 11 00 00       	call   1550 <malloc>
     372:	89 f1                	mov    %esi,%ecx
     374:	89 c7                	mov    %eax,%edi
     376:	89 c2                	mov    %eax,%edx
     378:	90                   	nop
     379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while((*dest++ = *first++) != 0)
     380:	41                   	inc    %ecx
     381:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
     385:	42                   	inc    %edx
     386:	84 c0                	test   %al,%al
     388:	88 42 ff             	mov    %al,-0x1(%edx)
     38b:	75 f3                	jne    380 <execWithPath+0xd0>
     38d:	8b 4d 08             	mov    0x8(%ebp),%ecx
     390:	eb 07                	jmp    399 <execWithPath+0xe9>
     392:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     398:	42                   	inc    %edx
    while((*dest++ = *second++) != 0)
     399:	41                   	inc    %ecx
     39a:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
     39e:	84 c0                	test   %al,%al
     3a0:	88 42 ff             	mov    %al,-0x1(%edx)
     3a3:	75 f3                	jne    398 <execWithPath+0xe8>
        exec( str3 , argv );
     3a5:	8b 45 0c             	mov    0xc(%ebp),%eax
     3a8:	89 3c 24             	mov    %edi,(%esp)
     3ab:	89 44 24 04          	mov    %eax,0x4(%esp)
     3af:	e8 dc 0d 00 00       	call   1190 <exec>
        free(str2);
     3b4:	89 34 24             	mov    %esi,(%esp)
     3b7:	e8 f4 10 00 00       	call   14b0 <free>
        free(str3);
     3bc:	89 3c 24             	mov    %edi,(%esp)
     3bf:	e8 ec 10 00 00       	call   14b0 <free>
    while( curr_path != NULL )
     3c4:	85 db                	test   %ebx,%ebx
     3c6:	0f 85 24 ff ff ff    	jne    2f0 <execWithPath+0x40>
    free(curr_path);
     3cc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     3d3:	e8 d8 10 00 00       	call   14b0 <free>
}
     3d8:	83 c4 1c             	add    $0x1c,%esp
     3db:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     3e0:	5b                   	pop    %ebx
     3e1:	5e                   	pop    %esi
     3e2:	5f                   	pop    %edi
     3e3:	5d                   	pop    %ebp
     3e4:	c3                   	ret    
     3e5:	8d 76 00             	lea    0x0(%esi),%esi
    while((*s = *t) != delim && (*s = *t) !=0)
     3e8:	89 f0                	mov    %esi,%eax
     3ea:	e9 46 ff ff ff       	jmp    335 <execWithPath+0x85>
     3ef:	90                   	nop

000003f0 <getcmd>:
{
     3f0:	55                   	push   %ebp
    printf(2, "$ ");
     3f1:	b8 38 16 00 00       	mov    $0x1638,%eax
{
     3f6:	89 e5                	mov    %esp,%ebp
     3f8:	83 ec 18             	sub    $0x18,%esp
     3fb:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     3fe:	8b 5d 08             	mov    0x8(%ebp),%ebx
     401:	89 75 fc             	mov    %esi,-0x4(%ebp)
     404:	8b 75 0c             	mov    0xc(%ebp),%esi
    printf(2, "$ ");
     407:	89 44 24 04          	mov    %eax,0x4(%esp)
     40b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     412:	e8 a9 0e 00 00       	call   12c0 <printf>
    memset(buf, 0, nbuf);
     417:	31 d2                	xor    %edx,%edx
     419:	89 74 24 08          	mov    %esi,0x8(%esp)
     41d:	89 54 24 04          	mov    %edx,0x4(%esp)
     421:	89 1c 24             	mov    %ebx,(%esp)
     424:	e8 97 0b 00 00       	call   fc0 <memset>
    gets(buf, nbuf);
     429:	89 74 24 04          	mov    %esi,0x4(%esp)
     42d:	89 1c 24             	mov    %ebx,(%esp)
     430:	e8 db 0b 00 00       	call   1010 <gets>
    if(buf[0] == 0) // EOF
     435:	31 c0                	xor    %eax,%eax
}
     437:	8b 75 fc             	mov    -0x4(%ebp),%esi
    if(buf[0] == 0) // EOF
     43a:	80 3b 00             	cmpb   $0x0,(%ebx)
}
     43d:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    if(buf[0] == 0) // EOF
     440:	0f 94 c0             	sete   %al
}
     443:	89 ec                	mov    %ebp,%esp
    if(buf[0] == 0) // EOF
     445:	f7 d8                	neg    %eax
}
     447:	5d                   	pop    %ebp
     448:	c3                   	ret    
     449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000450 <panic>:
{
     450:	55                   	push   %ebp
     451:	89 e5                	mov    %esp,%ebp
     453:	83 ec 18             	sub    $0x18,%esp
    printf(2, "%s\n", s);
     456:	8b 45 08             	mov    0x8(%ebp),%eax
     459:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     460:	89 44 24 08          	mov    %eax,0x8(%esp)
     464:	b8 d5 16 00 00       	mov    $0x16d5,%eax
     469:	89 44 24 04          	mov    %eax,0x4(%esp)
     46d:	e8 4e 0e 00 00       	call   12c0 <printf>
    exit(0);
     472:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     479:	e8 da 0c 00 00       	call   1158 <exit>
     47e:	66 90                	xchg   %ax,%ax

00000480 <runcmd>:
{
     480:	55                   	push   %ebp
     481:	89 e5                	mov    %esp,%ebp
     483:	56                   	push   %esi
     484:	53                   	push   %ebx
     485:	83 ec 20             	sub    $0x20,%esp
     488:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(cmd == 0)
     48b:	85 db                	test   %ebx,%ebx
     48d:	74 51                	je     4e0 <runcmd+0x60>
    switch(cmd->type){
     48f:	83 3b 05             	cmpl   $0x5,(%ebx)
     492:	0f 87 4a 01 00 00    	ja     5e2 <runcmd+0x162>
     498:	8b 03                	mov    (%ebx),%eax
     49a:	ff 24 85 f4 16 00 00 	jmp    *0x16f4(,%eax,4)
            close(rcmd->fd);
     4a1:	8b 43 14             	mov    0x14(%ebx),%eax
     4a4:	89 04 24             	mov    %eax,(%esp)
     4a7:	e8 d4 0c 00 00       	call   1180 <close>
            if(open(rcmd->file, rcmd->mode) < 0){
     4ac:	8b 43 10             	mov    0x10(%ebx),%eax
     4af:	89 44 24 04          	mov    %eax,0x4(%esp)
     4b3:	8b 43 08             	mov    0x8(%ebx),%eax
     4b6:	89 04 24             	mov    %eax,(%esp)
     4b9:	e8 da 0c 00 00       	call   1198 <open>
     4be:	85 c0                	test   %eax,%eax
     4c0:	79 3c                	jns    4fe <runcmd+0x7e>
                printf(2, "open %s failed\n", rcmd->file);
     4c2:	8b 43 08             	mov    0x8(%ebx),%eax
     4c5:	c7 44 24 04 52 16 00 	movl   $0x1652,0x4(%esp)
     4cc:	00 
     4cd:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     4d4:	89 44 24 08          	mov    %eax,0x8(%esp)
     4d8:	e8 e3 0d 00 00       	call   12c0 <printf>
     4dd:	8d 76 00             	lea    0x0(%esi),%esi
                exit(0);
     4e0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     4e7:	e8 6c 0c 00 00       	call   1158 <exit>
    pid = fork();
     4ec:	e8 5f 0c 00 00       	call   1150 <fork>
    if(pid == -1)
     4f1:	83 f8 ff             	cmp    $0xffffffff,%eax
     4f4:	0f 84 f4 00 00 00    	je     5ee <runcmd+0x16e>
            if(fork1() == 0)
     4fa:	85 c0                	test   %eax,%eax
     4fc:	75 e2                	jne    4e0 <runcmd+0x60>
                runcmd(bcmd->cmd);
     4fe:	8b 43 04             	mov    0x4(%ebx),%eax
     501:	89 04 24             	mov    %eax,(%esp)
     504:	e8 77 ff ff ff       	call   480 <runcmd>
            if(ecmd->argv[0] == 0)
     509:	8b 43 04             	mov    0x4(%ebx),%eax
     50c:	85 c0                	test   %eax,%eax
     50e:	74 d0                	je     4e0 <runcmd+0x60>
            exec(ecmd->argv[0], ecmd->argv);
     510:	8d 73 04             	lea    0x4(%ebx),%esi
     513:	89 74 24 04          	mov    %esi,0x4(%esp)
     517:	89 04 24             	mov    %eax,(%esp)
     51a:	e8 71 0c 00 00       	call   1190 <exec>
            execWithPath(ecmd->argv[0], ecmd->argv);
     51f:	89 74 24 04          	mov    %esi,0x4(%esp)
     523:	8b 43 04             	mov    0x4(%ebx),%eax
     526:	89 04 24             	mov    %eax,(%esp)
     529:	e8 82 fd ff ff       	call   2b0 <execWithPath>
            printf(2, "exec %s failed\n", ecmd->argv[0]);
     52e:	8b 43 04             	mov    0x4(%ebx),%eax
     531:	c7 44 24 04 42 16 00 	movl   $0x1642,0x4(%esp)
     538:	00 
     539:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     540:	89 44 24 08          	mov    %eax,0x8(%esp)
     544:	e8 77 0d 00 00       	call   12c0 <printf>
            break;
     549:	eb 95                	jmp    4e0 <runcmd+0x60>
            if(pipe(p) < 0)
     54b:	8d 45 f0             	lea    -0x10(%ebp),%eax
     54e:	89 04 24             	mov    %eax,(%esp)
     551:	e8 12 0c 00 00       	call   1168 <pipe>
     556:	85 c0                	test   %eax,%eax
     558:	0f 88 d4 00 00 00    	js     632 <runcmd+0x1b2>
    pid = fork();
     55e:	e8 ed 0b 00 00       	call   1150 <fork>
    if(pid == -1)
     563:	83 f8 ff             	cmp    $0xffffffff,%eax
     566:	0f 84 82 00 00 00    	je     5ee <runcmd+0x16e>
            if(fork1() == 0){
     56c:	85 c0                	test   %eax,%eax
     56e:	66 90                	xchg   %ax,%ax
     570:	0f 84 c8 00 00 00    	je     63e <runcmd+0x1be>
    pid = fork();
     576:	e8 d5 0b 00 00       	call   1150 <fork>
    if(pid == -1)
     57b:	83 f8 ff             	cmp    $0xffffffff,%eax
     57e:	66 90                	xchg   %ax,%ax
     580:	74 6c                	je     5ee <runcmd+0x16e>
            if(fork1() == 0){
     582:	85 c0                	test   %eax,%eax
     584:	74 74                	je     5fa <runcmd+0x17a>
            close(p[0]);
     586:	8b 45 f0             	mov    -0x10(%ebp),%eax
     589:	89 04 24             	mov    %eax,(%esp)
     58c:	e8 ef 0b 00 00       	call   1180 <close>
            close(p[1]);
     591:	8b 45 f4             	mov    -0xc(%ebp),%eax
     594:	89 04 24             	mov    %eax,(%esp)
     597:	e8 e4 0b 00 00       	call   1180 <close>
            wait(0);
     59c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     5a3:	e8 b8 0b 00 00       	call   1160 <wait>
            wait(0);
     5a8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     5af:	e8 ac 0b 00 00       	call   1160 <wait>
            break;
     5b4:	e9 27 ff ff ff       	jmp    4e0 <runcmd+0x60>
    pid = fork();
     5b9:	e8 92 0b 00 00       	call   1150 <fork>
    if(pid == -1)
     5be:	83 f8 ff             	cmp    $0xffffffff,%eax
     5c1:	74 2b                	je     5ee <runcmd+0x16e>
            if(fork1() == 0)
     5c3:	85 c0                	test   %eax,%eax
     5c5:	0f 84 33 ff ff ff    	je     4fe <runcmd+0x7e>
            wait(0);
     5cb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     5d2:	e8 89 0b 00 00       	call   1160 <wait>
            runcmd(lcmd->right);
     5d7:	8b 43 08             	mov    0x8(%ebx),%eax
     5da:	89 04 24             	mov    %eax,(%esp)
     5dd:	e8 9e fe ff ff       	call   480 <runcmd>
            panic("runcmd");
     5e2:	c7 04 24 3b 16 00 00 	movl   $0x163b,(%esp)
     5e9:	e8 62 fe ff ff       	call   450 <panic>
        panic("fork");
     5ee:	c7 04 24 62 16 00 00 	movl   $0x1662,(%esp)
     5f5:	e8 56 fe ff ff       	call   450 <panic>
                close(0);
     5fa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     601:	e8 7a 0b 00 00       	call   1180 <close>
                dup(p[0]);
     606:	8b 45 f0             	mov    -0x10(%ebp),%eax
     609:	89 04 24             	mov    %eax,(%esp)
     60c:	e8 bf 0b 00 00       	call   11d0 <dup>
                close(p[0]);
     611:	8b 45 f0             	mov    -0x10(%ebp),%eax
     614:	89 04 24             	mov    %eax,(%esp)
     617:	e8 64 0b 00 00       	call   1180 <close>
                close(p[1]);
     61c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     61f:	89 04 24             	mov    %eax,(%esp)
     622:	e8 59 0b 00 00       	call   1180 <close>
                runcmd(pcmd->right);
     627:	8b 43 08             	mov    0x8(%ebx),%eax
     62a:	89 04 24             	mov    %eax,(%esp)
     62d:	e8 4e fe ff ff       	call   480 <runcmd>
                panic("pipe");
     632:	c7 04 24 67 16 00 00 	movl   $0x1667,(%esp)
     639:	e8 12 fe ff ff       	call   450 <panic>
                close(1);
     63e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     645:	e8 36 0b 00 00       	call   1180 <close>
                dup(p[1]);
     64a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     64d:	89 04 24             	mov    %eax,(%esp)
     650:	e8 7b 0b 00 00       	call   11d0 <dup>
                close(p[0]);
     655:	8b 45 f0             	mov    -0x10(%ebp),%eax
     658:	89 04 24             	mov    %eax,(%esp)
     65b:	e8 20 0b 00 00       	call   1180 <close>
                close(p[1]);
     660:	8b 45 f4             	mov    -0xc(%ebp),%eax
     663:	89 04 24             	mov    %eax,(%esp)
     666:	e8 15 0b 00 00       	call   1180 <close>
                runcmd(pcmd->left);
     66b:	8b 43 04             	mov    0x4(%ebx),%eax
     66e:	89 04 24             	mov    %eax,(%esp)
     671:	e8 0a fe ff ff       	call   480 <runcmd>
     676:	8d 76 00             	lea    0x0(%esi),%esi
     679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000680 <fork1>:
{
     680:	55                   	push   %ebp
     681:	89 e5                	mov    %esp,%ebp
     683:	83 ec 18             	sub    $0x18,%esp
    pid = fork();
     686:	e8 c5 0a 00 00       	call   1150 <fork>
    if(pid == -1)
     68b:	83 f8 ff             	cmp    $0xffffffff,%eax
     68e:	74 02                	je     692 <fork1+0x12>
    return pid;
}
     690:	c9                   	leave  
     691:	c3                   	ret    
        panic("fork");
     692:	c7 04 24 62 16 00 00 	movl   $0x1662,(%esp)
     699:	e8 b2 fd ff ff       	call   450 <panic>
     69e:	66 90                	xchg   %ax,%ax

000006a0 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     6a0:	55                   	push   %ebp
     6a1:	89 e5                	mov    %esp,%ebp
     6a3:	53                   	push   %ebx
     6a4:	83 ec 14             	sub    $0x14,%esp
    struct execcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     6a7:	c7 04 24 54 00 00 00 	movl   $0x54,(%esp)
     6ae:	e8 9d 0e 00 00       	call   1550 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     6b3:	31 d2                	xor    %edx,%edx
     6b5:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     6b9:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     6bb:	b8 54 00 00 00       	mov    $0x54,%eax
     6c0:	89 1c 24             	mov    %ebx,(%esp)
     6c3:	89 44 24 08          	mov    %eax,0x8(%esp)
     6c7:	e8 f4 08 00 00       	call   fc0 <memset>
    cmd->type = EXEC;
    return (struct cmd*)cmd;
}
     6cc:	89 d8                	mov    %ebx,%eax
    cmd->type = EXEC;
     6ce:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
}
     6d4:	83 c4 14             	add    $0x14,%esp
     6d7:	5b                   	pop    %ebx
     6d8:	5d                   	pop    %ebp
     6d9:	c3                   	ret    
     6da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000006e0 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     6e0:	55                   	push   %ebp
     6e1:	89 e5                	mov    %esp,%ebp
     6e3:	53                   	push   %ebx
     6e4:	83 ec 14             	sub    $0x14,%esp
    struct redircmd *cmd;

    cmd = malloc(sizeof(*cmd));
     6e7:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
     6ee:	e8 5d 0e 00 00       	call   1550 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     6f3:	31 d2                	xor    %edx,%edx
     6f5:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     6f9:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     6fb:	b8 18 00 00 00       	mov    $0x18,%eax
     700:	89 1c 24             	mov    %ebx,(%esp)
     703:	89 44 24 08          	mov    %eax,0x8(%esp)
     707:	e8 b4 08 00 00       	call   fc0 <memset>
    cmd->type = REDIR;
    cmd->cmd = subcmd;
     70c:	8b 45 08             	mov    0x8(%ebp),%eax
    cmd->type = REDIR;
     70f:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
    cmd->cmd = subcmd;
     715:	89 43 04             	mov    %eax,0x4(%ebx)
    cmd->file = file;
     718:	8b 45 0c             	mov    0xc(%ebp),%eax
     71b:	89 43 08             	mov    %eax,0x8(%ebx)
    cmd->efile = efile;
     71e:	8b 45 10             	mov    0x10(%ebp),%eax
     721:	89 43 0c             	mov    %eax,0xc(%ebx)
    cmd->mode = mode;
     724:	8b 45 14             	mov    0x14(%ebp),%eax
     727:	89 43 10             	mov    %eax,0x10(%ebx)
    cmd->fd = fd;
     72a:	8b 45 18             	mov    0x18(%ebp),%eax
     72d:	89 43 14             	mov    %eax,0x14(%ebx)
    return (struct cmd*)cmd;
}
     730:	83 c4 14             	add    $0x14,%esp
     733:	89 d8                	mov    %ebx,%eax
     735:	5b                   	pop    %ebx
     736:	5d                   	pop    %ebp
     737:	c3                   	ret    
     738:	90                   	nop
     739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000740 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     740:	55                   	push   %ebp
     741:	89 e5                	mov    %esp,%ebp
     743:	53                   	push   %ebx
     744:	83 ec 14             	sub    $0x14,%esp
    struct pipecmd *cmd;

    cmd = malloc(sizeof(*cmd));
     747:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     74e:	e8 fd 0d 00 00       	call   1550 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     753:	31 d2                	xor    %edx,%edx
     755:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     759:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     75b:	b8 0c 00 00 00       	mov    $0xc,%eax
     760:	89 1c 24             	mov    %ebx,(%esp)
     763:	89 44 24 08          	mov    %eax,0x8(%esp)
     767:	e8 54 08 00 00       	call   fc0 <memset>
    cmd->type = PIPE;
    cmd->left = left;
     76c:	8b 45 08             	mov    0x8(%ebp),%eax
    cmd->type = PIPE;
     76f:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
    cmd->left = left;
     775:	89 43 04             	mov    %eax,0x4(%ebx)
    cmd->right = right;
     778:	8b 45 0c             	mov    0xc(%ebp),%eax
     77b:	89 43 08             	mov    %eax,0x8(%ebx)
    return (struct cmd*)cmd;
}
     77e:	83 c4 14             	add    $0x14,%esp
     781:	89 d8                	mov    %ebx,%eax
     783:	5b                   	pop    %ebx
     784:	5d                   	pop    %ebp
     785:	c3                   	ret    
     786:	8d 76 00             	lea    0x0(%esi),%esi
     789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000790 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     790:	55                   	push   %ebp
     791:	89 e5                	mov    %esp,%ebp
     793:	53                   	push   %ebx
     794:	83 ec 14             	sub    $0x14,%esp
    struct listcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     797:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     79e:	e8 ad 0d 00 00       	call   1550 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     7a3:	31 d2                	xor    %edx,%edx
     7a5:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     7a9:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     7ab:	b8 0c 00 00 00       	mov    $0xc,%eax
     7b0:	89 1c 24             	mov    %ebx,(%esp)
     7b3:	89 44 24 08          	mov    %eax,0x8(%esp)
     7b7:	e8 04 08 00 00       	call   fc0 <memset>
    cmd->type = LIST;
    cmd->left = left;
     7bc:	8b 45 08             	mov    0x8(%ebp),%eax
    cmd->type = LIST;
     7bf:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
    cmd->left = left;
     7c5:	89 43 04             	mov    %eax,0x4(%ebx)
    cmd->right = right;
     7c8:	8b 45 0c             	mov    0xc(%ebp),%eax
     7cb:	89 43 08             	mov    %eax,0x8(%ebx)
    return (struct cmd*)cmd;
}
     7ce:	83 c4 14             	add    $0x14,%esp
     7d1:	89 d8                	mov    %ebx,%eax
     7d3:	5b                   	pop    %ebx
     7d4:	5d                   	pop    %ebp
     7d5:	c3                   	ret    
     7d6:	8d 76 00             	lea    0x0(%esi),%esi
     7d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000007e0 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     7e0:	55                   	push   %ebp
     7e1:	89 e5                	mov    %esp,%ebp
     7e3:	53                   	push   %ebx
     7e4:	83 ec 14             	sub    $0x14,%esp
    struct backcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     7e7:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     7ee:	e8 5d 0d 00 00       	call   1550 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     7f3:	31 d2                	xor    %edx,%edx
     7f5:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     7f9:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     7fb:	b8 08 00 00 00       	mov    $0x8,%eax
     800:	89 1c 24             	mov    %ebx,(%esp)
     803:	89 44 24 08          	mov    %eax,0x8(%esp)
     807:	e8 b4 07 00 00       	call   fc0 <memset>
    cmd->type = BACK;
    cmd->cmd = subcmd;
     80c:	8b 45 08             	mov    0x8(%ebp),%eax
    cmd->type = BACK;
     80f:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
    cmd->cmd = subcmd;
     815:	89 43 04             	mov    %eax,0x4(%ebx)
    return (struct cmd*)cmd;
}
     818:	83 c4 14             	add    $0x14,%esp
     81b:	89 d8                	mov    %ebx,%eax
     81d:	5b                   	pop    %ebx
     81e:	5d                   	pop    %ebp
     81f:	c3                   	ret    

00000820 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     820:	55                   	push   %ebp
     821:	89 e5                	mov    %esp,%ebp
     823:	57                   	push   %edi
     824:	56                   	push   %esi
     825:	53                   	push   %ebx
     826:	83 ec 1c             	sub    $0x1c,%esp
    char *s;
    int ret;

    s = *ps;
     829:	8b 45 08             	mov    0x8(%ebp),%eax
{
     82c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     82f:	8b 7d 10             	mov    0x10(%ebp),%edi
    s = *ps;
     832:	8b 30                	mov    (%eax),%esi
    while(s < es && strchr(whitespace, *s))
     834:	39 de                	cmp    %ebx,%esi
     836:	72 0d                	jb     845 <gettoken+0x25>
     838:	eb 22                	jmp    85c <gettoken+0x3c>
     83a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s++;
     840:	46                   	inc    %esi
    while(s < es && strchr(whitespace, *s))
     841:	39 f3                	cmp    %esi,%ebx
     843:	74 17                	je     85c <gettoken+0x3c>
     845:	0f be 06             	movsbl (%esi),%eax
     848:	c7 04 24 e4 1d 00 00 	movl   $0x1de4,(%esp)
     84f:	89 44 24 04          	mov    %eax,0x4(%esp)
     853:	e8 88 07 00 00       	call   fe0 <strchr>
     858:	85 c0                	test   %eax,%eax
     85a:	75 e4                	jne    840 <gettoken+0x20>
    if(q)
     85c:	85 ff                	test   %edi,%edi
     85e:	74 02                	je     862 <gettoken+0x42>
        *q = s;
     860:	89 37                	mov    %esi,(%edi)
    ret = *s;
     862:	0f be 06             	movsbl (%esi),%eax
    switch(*s){
     865:	3c 29                	cmp    $0x29,%al
     867:	7f 57                	jg     8c0 <gettoken+0xa0>
     869:	3c 28                	cmp    $0x28,%al
     86b:	0f 8d cb 00 00 00    	jge    93c <gettoken+0x11c>
     871:	31 ff                	xor    %edi,%edi
     873:	84 c0                	test   %al,%al
     875:	0f 85 cd 00 00 00    	jne    948 <gettoken+0x128>
            ret = 'a';
            while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
                s++;
            break;
    }
    if(eq)
     87b:	8b 55 14             	mov    0x14(%ebp),%edx
     87e:	85 d2                	test   %edx,%edx
     880:	74 05                	je     887 <gettoken+0x67>
        *eq = s;
     882:	8b 45 14             	mov    0x14(%ebp),%eax
     885:	89 30                	mov    %esi,(%eax)

    while(s < es && strchr(whitespace, *s))
     887:	39 de                	cmp    %ebx,%esi
     889:	72 0a                	jb     895 <gettoken+0x75>
     88b:	eb 1f                	jmp    8ac <gettoken+0x8c>
     88d:	8d 76 00             	lea    0x0(%esi),%esi
        s++;
     890:	46                   	inc    %esi
    while(s < es && strchr(whitespace, *s))
     891:	39 f3                	cmp    %esi,%ebx
     893:	74 17                	je     8ac <gettoken+0x8c>
     895:	0f be 06             	movsbl (%esi),%eax
     898:	c7 04 24 e4 1d 00 00 	movl   $0x1de4,(%esp)
     89f:	89 44 24 04          	mov    %eax,0x4(%esp)
     8a3:	e8 38 07 00 00       	call   fe0 <strchr>
     8a8:	85 c0                	test   %eax,%eax
     8aa:	75 e4                	jne    890 <gettoken+0x70>
    *ps = s;
     8ac:	8b 45 08             	mov    0x8(%ebp),%eax
     8af:	89 30                	mov    %esi,(%eax)
    return ret;
}
     8b1:	83 c4 1c             	add    $0x1c,%esp
     8b4:	89 f8                	mov    %edi,%eax
     8b6:	5b                   	pop    %ebx
     8b7:	5e                   	pop    %esi
     8b8:	5f                   	pop    %edi
     8b9:	5d                   	pop    %ebp
     8ba:	c3                   	ret    
     8bb:	90                   	nop
     8bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(*s){
     8c0:	3c 3e                	cmp    $0x3e,%al
     8c2:	75 1c                	jne    8e0 <gettoken+0xc0>
            if(*s == '>'){
     8c4:	80 7e 01 3e          	cmpb   $0x3e,0x1(%esi)
            s++;
     8c8:	8d 46 01             	lea    0x1(%esi),%eax
            if(*s == '>'){
     8cb:	0f 84 94 00 00 00    	je     965 <gettoken+0x145>
            s++;
     8d1:	89 c6                	mov    %eax,%esi
     8d3:	bf 3e 00 00 00       	mov    $0x3e,%edi
     8d8:	eb a1                	jmp    87b <gettoken+0x5b>
     8da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(*s){
     8e0:	7f 56                	jg     938 <gettoken+0x118>
     8e2:	88 c1                	mov    %al,%cl
     8e4:	80 e9 3b             	sub    $0x3b,%cl
     8e7:	80 f9 01             	cmp    $0x1,%cl
     8ea:	76 50                	jbe    93c <gettoken+0x11c>
            while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     8ec:	39 f3                	cmp    %esi,%ebx
     8ee:	77 27                	ja     917 <gettoken+0xf7>
     8f0:	eb 5e                	jmp    950 <gettoken+0x130>
     8f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     8f8:	0f be 06             	movsbl (%esi),%eax
     8fb:	c7 04 24 dc 1d 00 00 	movl   $0x1ddc,(%esp)
     902:	89 44 24 04          	mov    %eax,0x4(%esp)
     906:	e8 d5 06 00 00       	call   fe0 <strchr>
     90b:	85 c0                	test   %eax,%eax
     90d:	75 1c                	jne    92b <gettoken+0x10b>
                s++;
     90f:	46                   	inc    %esi
            while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     910:	39 f3                	cmp    %esi,%ebx
     912:	74 3c                	je     950 <gettoken+0x130>
     914:	0f be 06             	movsbl (%esi),%eax
     917:	89 44 24 04          	mov    %eax,0x4(%esp)
     91b:	c7 04 24 e4 1d 00 00 	movl   $0x1de4,(%esp)
     922:	e8 b9 06 00 00       	call   fe0 <strchr>
     927:	85 c0                	test   %eax,%eax
     929:	74 cd                	je     8f8 <gettoken+0xd8>
            ret = 'a';
     92b:	bf 61 00 00 00       	mov    $0x61,%edi
     930:	e9 46 ff ff ff       	jmp    87b <gettoken+0x5b>
     935:	8d 76 00             	lea    0x0(%esi),%esi
    switch(*s){
     938:	3c 7c                	cmp    $0x7c,%al
     93a:	75 b0                	jne    8ec <gettoken+0xcc>
    ret = *s;
     93c:	0f be f8             	movsbl %al,%edi
            s++;
     93f:	46                   	inc    %esi
            break;
     940:	e9 36 ff ff ff       	jmp    87b <gettoken+0x5b>
     945:	8d 76 00             	lea    0x0(%esi),%esi
    switch(*s){
     948:	3c 26                	cmp    $0x26,%al
     94a:	75 a0                	jne    8ec <gettoken+0xcc>
     94c:	eb ee                	jmp    93c <gettoken+0x11c>
     94e:	66 90                	xchg   %ax,%ax
    if(eq)
     950:	8b 45 14             	mov    0x14(%ebp),%eax
     953:	bf 61 00 00 00       	mov    $0x61,%edi
     958:	85 c0                	test   %eax,%eax
     95a:	0f 85 22 ff ff ff    	jne    882 <gettoken+0x62>
     960:	e9 47 ff ff ff       	jmp    8ac <gettoken+0x8c>
                s++;
     965:	83 c6 02             	add    $0x2,%esi
                ret = '+';
     968:	bf 2b 00 00 00       	mov    $0x2b,%edi
     96d:	e9 09 ff ff ff       	jmp    87b <gettoken+0x5b>
     972:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000980 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     980:	55                   	push   %ebp
     981:	89 e5                	mov    %esp,%ebp
     983:	57                   	push   %edi
     984:	56                   	push   %esi
     985:	53                   	push   %ebx
     986:	83 ec 1c             	sub    $0x1c,%esp
     989:	8b 7d 08             	mov    0x8(%ebp),%edi
     98c:	8b 75 0c             	mov    0xc(%ebp),%esi
    char *s;

    s = *ps;
     98f:	8b 1f                	mov    (%edi),%ebx
    while(s < es && strchr(whitespace, *s))
     991:	39 f3                	cmp    %esi,%ebx
     993:	72 10                	jb     9a5 <peek+0x25>
     995:	eb 25                	jmp    9bc <peek+0x3c>
     997:	89 f6                	mov    %esi,%esi
     999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s++;
     9a0:	43                   	inc    %ebx
    while(s < es && strchr(whitespace, *s))
     9a1:	39 de                	cmp    %ebx,%esi
     9a3:	74 17                	je     9bc <peek+0x3c>
     9a5:	0f be 03             	movsbl (%ebx),%eax
     9a8:	c7 04 24 e4 1d 00 00 	movl   $0x1de4,(%esp)
     9af:	89 44 24 04          	mov    %eax,0x4(%esp)
     9b3:	e8 28 06 00 00       	call   fe0 <strchr>
     9b8:	85 c0                	test   %eax,%eax
     9ba:	75 e4                	jne    9a0 <peek+0x20>
    *ps = s;
     9bc:	89 1f                	mov    %ebx,(%edi)
    return *s && strchr(toks, *s);
     9be:	31 c0                	xor    %eax,%eax
     9c0:	0f be 13             	movsbl (%ebx),%edx
     9c3:	84 d2                	test   %dl,%dl
     9c5:	74 17                	je     9de <peek+0x5e>
     9c7:	8b 45 10             	mov    0x10(%ebp),%eax
     9ca:	89 54 24 04          	mov    %edx,0x4(%esp)
     9ce:	89 04 24             	mov    %eax,(%esp)
     9d1:	e8 0a 06 00 00       	call   fe0 <strchr>
     9d6:	85 c0                	test   %eax,%eax
     9d8:	0f 95 c0             	setne  %al
     9db:	0f b6 c0             	movzbl %al,%eax
}
     9de:	83 c4 1c             	add    $0x1c,%esp
     9e1:	5b                   	pop    %ebx
     9e2:	5e                   	pop    %esi
     9e3:	5f                   	pop    %edi
     9e4:	5d                   	pop    %ebp
     9e5:	c3                   	ret    
     9e6:	8d 76 00             	lea    0x0(%esi),%esi
     9e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009f0 <parseredirs>:
    return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     9f0:	55                   	push   %ebp
     9f1:	89 e5                	mov    %esp,%ebp
     9f3:	57                   	push   %edi
     9f4:	56                   	push   %esi
     9f5:	53                   	push   %ebx
     9f6:	83 ec 3c             	sub    $0x3c,%esp
     9f9:	8b 75 0c             	mov    0xc(%ebp),%esi
     9fc:	8b 5d 10             	mov    0x10(%ebp),%ebx
     9ff:	90                   	nop
    int tok;
    char *q, *eq;

    while(peek(ps, es, "<>")){
     a00:	b8 89 16 00 00       	mov    $0x1689,%eax
     a05:	89 44 24 08          	mov    %eax,0x8(%esp)
     a09:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     a0d:	89 34 24             	mov    %esi,(%esp)
     a10:	e8 6b ff ff ff       	call   980 <peek>
     a15:	85 c0                	test   %eax,%eax
     a17:	0f 84 93 00 00 00    	je     ab0 <parseredirs+0xc0>
        tok = gettoken(ps, es, 0, 0);
     a1d:	31 c0                	xor    %eax,%eax
     a1f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     a23:	31 c0                	xor    %eax,%eax
     a25:	89 44 24 08          	mov    %eax,0x8(%esp)
     a29:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     a2d:	89 34 24             	mov    %esi,(%esp)
     a30:	e8 eb fd ff ff       	call   820 <gettoken>
        if(gettoken(ps, es, &q, &eq) != 'a')
     a35:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     a39:	89 34 24             	mov    %esi,(%esp)
        tok = gettoken(ps, es, 0, 0);
     a3c:	89 c7                	mov    %eax,%edi
        if(gettoken(ps, es, &q, &eq) != 'a')
     a3e:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     a41:	89 44 24 0c          	mov    %eax,0xc(%esp)
     a45:	8d 45 e0             	lea    -0x20(%ebp),%eax
     a48:	89 44 24 08          	mov    %eax,0x8(%esp)
     a4c:	e8 cf fd ff ff       	call   820 <gettoken>
     a51:	83 f8 61             	cmp    $0x61,%eax
     a54:	75 65                	jne    abb <parseredirs+0xcb>
            panic("missing file for redirection");
        switch(tok){
     a56:	83 ff 3c             	cmp    $0x3c,%edi
     a59:	74 45                	je     aa0 <parseredirs+0xb0>
     a5b:	83 ff 3e             	cmp    $0x3e,%edi
     a5e:	66 90                	xchg   %ax,%ax
     a60:	74 05                	je     a67 <parseredirs+0x77>
     a62:	83 ff 2b             	cmp    $0x2b,%edi
     a65:	75 99                	jne    a00 <parseredirs+0x10>
                break;
            case '>':
                cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
                break;
            case '+':  // >>
                cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     a67:	ba 01 00 00 00       	mov    $0x1,%edx
     a6c:	b9 01 02 00 00       	mov    $0x201,%ecx
     a71:	89 54 24 10          	mov    %edx,0x10(%esp)
     a75:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
     a79:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a7c:	89 44 24 08          	mov    %eax,0x8(%esp)
     a80:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a83:	89 44 24 04          	mov    %eax,0x4(%esp)
     a87:	8b 45 08             	mov    0x8(%ebp),%eax
     a8a:	89 04 24             	mov    %eax,(%esp)
     a8d:	e8 4e fc ff ff       	call   6e0 <redircmd>
     a92:	89 45 08             	mov    %eax,0x8(%ebp)
                break;
     a95:	e9 66 ff ff ff       	jmp    a00 <parseredirs+0x10>
     a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     aa0:	31 ff                	xor    %edi,%edi
     aa2:	31 c0                	xor    %eax,%eax
     aa4:	89 7c 24 10          	mov    %edi,0x10(%esp)
     aa8:	89 44 24 0c          	mov    %eax,0xc(%esp)
     aac:	eb cb                	jmp    a79 <parseredirs+0x89>
     aae:	66 90                	xchg   %ax,%ax
        }
    }
    return cmd;
}
     ab0:	8b 45 08             	mov    0x8(%ebp),%eax
     ab3:	83 c4 3c             	add    $0x3c,%esp
     ab6:	5b                   	pop    %ebx
     ab7:	5e                   	pop    %esi
     ab8:	5f                   	pop    %edi
     ab9:	5d                   	pop    %ebp
     aba:	c3                   	ret    
            panic("missing file for redirection");
     abb:	c7 04 24 6c 16 00 00 	movl   $0x166c,(%esp)
     ac2:	e8 89 f9 ff ff       	call   450 <panic>
     ac7:	89 f6                	mov    %esi,%esi
     ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ad0 <parseexec>:
    return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     ad0:	55                   	push   %ebp
    char *q, *eq;
    int tok, argc;
    struct execcmd *cmd;
    struct cmd *ret;

    if(peek(ps, es, "("))
     ad1:	ba 8c 16 00 00       	mov    $0x168c,%edx
{
     ad6:	89 e5                	mov    %esp,%ebp
     ad8:	57                   	push   %edi
     ad9:	56                   	push   %esi
     ada:	53                   	push   %ebx
     adb:	83 ec 3c             	sub    $0x3c,%esp
     ade:	8b 75 08             	mov    0x8(%ebp),%esi
     ae1:	8b 7d 0c             	mov    0xc(%ebp),%edi
    if(peek(ps, es, "("))
     ae4:	89 54 24 08          	mov    %edx,0x8(%esp)
     ae8:	89 34 24             	mov    %esi,(%esp)
     aeb:	89 7c 24 04          	mov    %edi,0x4(%esp)
     aef:	e8 8c fe ff ff       	call   980 <peek>
     af4:	85 c0                	test   %eax,%eax
     af6:	0f 85 9c 00 00 00    	jne    b98 <parseexec+0xc8>
     afc:	89 c3                	mov    %eax,%ebx
        return parseblock(ps, es);

    ret = execcmd();
     afe:	e8 9d fb ff ff       	call   6a0 <execcmd>
    cmd = (struct execcmd*)ret;

    argc = 0;
    ret = parseredirs(ret, ps, es);
     b03:	89 7c 24 08          	mov    %edi,0x8(%esp)
     b07:	89 74 24 04          	mov    %esi,0x4(%esp)
     b0b:	89 04 24             	mov    %eax,(%esp)
    ret = execcmd();
     b0e:	89 45 d0             	mov    %eax,-0x30(%ebp)
    ret = parseredirs(ret, ps, es);
     b11:	e8 da fe ff ff       	call   9f0 <parseredirs>
     b16:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     b19:	eb 1b                	jmp    b36 <parseexec+0x66>
     b1b:	90                   	nop
     b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cmd->argv[argc] = q;
        cmd->eargv[argc] = eq;
        argc++;
        if(argc >= MAXARGS)
            panic("too many args");
        ret = parseredirs(ret, ps, es);
     b20:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     b23:	89 7c 24 08          	mov    %edi,0x8(%esp)
     b27:	89 74 24 04          	mov    %esi,0x4(%esp)
     b2b:	89 04 24             	mov    %eax,(%esp)
     b2e:	e8 bd fe ff ff       	call   9f0 <parseredirs>
     b33:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while(!peek(ps, es, "|)&;")){
     b36:	b8 a3 16 00 00       	mov    $0x16a3,%eax
     b3b:	89 44 24 08          	mov    %eax,0x8(%esp)
     b3f:	89 7c 24 04          	mov    %edi,0x4(%esp)
     b43:	89 34 24             	mov    %esi,(%esp)
     b46:	e8 35 fe ff ff       	call   980 <peek>
     b4b:	85 c0                	test   %eax,%eax
     b4d:	75 69                	jne    bb8 <parseexec+0xe8>
        if((tok=gettoken(ps, es, &q, &eq)) == 0)
     b4f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     b52:	89 44 24 0c          	mov    %eax,0xc(%esp)
     b56:	8d 45 e0             	lea    -0x20(%ebp),%eax
     b59:	89 44 24 08          	mov    %eax,0x8(%esp)
     b5d:	89 7c 24 04          	mov    %edi,0x4(%esp)
     b61:	89 34 24             	mov    %esi,(%esp)
     b64:	e8 b7 fc ff ff       	call   820 <gettoken>
     b69:	85 c0                	test   %eax,%eax
     b6b:	74 4b                	je     bb8 <parseexec+0xe8>
        if(tok != 'a')
     b6d:	83 f8 61             	cmp    $0x61,%eax
     b70:	75 65                	jne    bd7 <parseexec+0x107>
        cmd->argv[argc] = q;
     b72:	8b 45 e0             	mov    -0x20(%ebp),%eax
     b75:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b78:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
        cmd->eargv[argc] = eq;
     b7c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     b7f:	89 44 9a 2c          	mov    %eax,0x2c(%edx,%ebx,4)
        argc++;
     b83:	43                   	inc    %ebx
        if(argc >= MAXARGS)
     b84:	83 fb 0a             	cmp    $0xa,%ebx
     b87:	75 97                	jne    b20 <parseexec+0x50>
            panic("too many args");
     b89:	c7 04 24 95 16 00 00 	movl   $0x1695,(%esp)
     b90:	e8 bb f8 ff ff       	call   450 <panic>
     b95:	8d 76 00             	lea    0x0(%esi),%esi
        return parseblock(ps, es);
     b98:	89 7c 24 04          	mov    %edi,0x4(%esp)
     b9c:	89 34 24             	mov    %esi,(%esp)
     b9f:	e8 9c 01 00 00       	call   d40 <parseblock>
     ba4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    }
    cmd->argv[argc] = 0;
    cmd->eargv[argc] = 0;
    return ret;
}
     ba7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     baa:	83 c4 3c             	add    $0x3c,%esp
     bad:	5b                   	pop    %ebx
     bae:	5e                   	pop    %esi
     baf:	5f                   	pop    %edi
     bb0:	5d                   	pop    %ebp
     bb1:	c3                   	ret    
     bb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     bb8:	8b 45 d0             	mov    -0x30(%ebp),%eax
     bbb:	8d 04 98             	lea    (%eax,%ebx,4),%eax
    cmd->argv[argc] = 0;
     bbe:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    cmd->eargv[argc] = 0;
     bc5:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
}
     bcc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     bcf:	83 c4 3c             	add    $0x3c,%esp
     bd2:	5b                   	pop    %ebx
     bd3:	5e                   	pop    %esi
     bd4:	5f                   	pop    %edi
     bd5:	5d                   	pop    %ebp
     bd6:	c3                   	ret    
            panic("syntax");
     bd7:	c7 04 24 8e 16 00 00 	movl   $0x168e,(%esp)
     bde:	e8 6d f8 ff ff       	call   450 <panic>
     be3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000bf0 <parsepipe>:
{
     bf0:	55                   	push   %ebp
     bf1:	89 e5                	mov    %esp,%ebp
     bf3:	83 ec 28             	sub    $0x28,%esp
     bf6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     bf9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     bfc:	89 75 f8             	mov    %esi,-0x8(%ebp)
     bff:	8b 75 0c             	mov    0xc(%ebp),%esi
     c02:	89 7d fc             	mov    %edi,-0x4(%ebp)
    cmd = parseexec(ps, es);
     c05:	89 1c 24             	mov    %ebx,(%esp)
     c08:	89 74 24 04          	mov    %esi,0x4(%esp)
     c0c:	e8 bf fe ff ff       	call   ad0 <parseexec>
    if(peek(ps, es, "|")){
     c11:	b9 a8 16 00 00       	mov    $0x16a8,%ecx
     c16:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     c1a:	89 74 24 04          	mov    %esi,0x4(%esp)
     c1e:	89 1c 24             	mov    %ebx,(%esp)
    cmd = parseexec(ps, es);
     c21:	89 c7                	mov    %eax,%edi
    if(peek(ps, es, "|")){
     c23:	e8 58 fd ff ff       	call   980 <peek>
     c28:	85 c0                	test   %eax,%eax
     c2a:	75 14                	jne    c40 <parsepipe+0x50>
}
     c2c:	89 f8                	mov    %edi,%eax
     c2e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     c31:	8b 75 f8             	mov    -0x8(%ebp),%esi
     c34:	8b 7d fc             	mov    -0x4(%ebp),%edi
     c37:	89 ec                	mov    %ebp,%esp
     c39:	5d                   	pop    %ebp
     c3a:	c3                   	ret    
     c3b:	90                   	nop
     c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        gettoken(ps, es, 0, 0);
     c40:	31 d2                	xor    %edx,%edx
     c42:	31 c0                	xor    %eax,%eax
     c44:	89 54 24 08          	mov    %edx,0x8(%esp)
     c48:	89 74 24 04          	mov    %esi,0x4(%esp)
     c4c:	89 1c 24             	mov    %ebx,(%esp)
     c4f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     c53:	e8 c8 fb ff ff       	call   820 <gettoken>
        cmd = pipecmd(cmd, parsepipe(ps, es));
     c58:	89 74 24 04          	mov    %esi,0x4(%esp)
     c5c:	89 1c 24             	mov    %ebx,(%esp)
     c5f:	e8 8c ff ff ff       	call   bf0 <parsepipe>
}
     c64:	8b 5d f4             	mov    -0xc(%ebp),%ebx
        cmd = pipecmd(cmd, parsepipe(ps, es));
     c67:	89 7d 08             	mov    %edi,0x8(%ebp)
}
     c6a:	8b 75 f8             	mov    -0x8(%ebp),%esi
     c6d:	8b 7d fc             	mov    -0x4(%ebp),%edi
        cmd = pipecmd(cmd, parsepipe(ps, es));
     c70:	89 45 0c             	mov    %eax,0xc(%ebp)
}
     c73:	89 ec                	mov    %ebp,%esp
     c75:	5d                   	pop    %ebp
        cmd = pipecmd(cmd, parsepipe(ps, es));
     c76:	e9 c5 fa ff ff       	jmp    740 <pipecmd>
     c7b:	90                   	nop
     c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000c80 <parseline>:
{
     c80:	55                   	push   %ebp
     c81:	89 e5                	mov    %esp,%ebp
     c83:	57                   	push   %edi
     c84:	56                   	push   %esi
     c85:	53                   	push   %ebx
     c86:	83 ec 1c             	sub    $0x1c,%esp
     c89:	8b 5d 08             	mov    0x8(%ebp),%ebx
     c8c:	8b 75 0c             	mov    0xc(%ebp),%esi
    cmd = parsepipe(ps, es);
     c8f:	89 1c 24             	mov    %ebx,(%esp)
     c92:	89 74 24 04          	mov    %esi,0x4(%esp)
     c96:	e8 55 ff ff ff       	call   bf0 <parsepipe>
     c9b:	89 c7                	mov    %eax,%edi
    while(peek(ps, es, "&")){
     c9d:	eb 23                	jmp    cc2 <parseline+0x42>
     c9f:	90                   	nop
        gettoken(ps, es, 0, 0);
     ca0:	31 c0                	xor    %eax,%eax
     ca2:	89 44 24 0c          	mov    %eax,0xc(%esp)
     ca6:	31 c0                	xor    %eax,%eax
     ca8:	89 44 24 08          	mov    %eax,0x8(%esp)
     cac:	89 74 24 04          	mov    %esi,0x4(%esp)
     cb0:	89 1c 24             	mov    %ebx,(%esp)
     cb3:	e8 68 fb ff ff       	call   820 <gettoken>
        cmd = backcmd(cmd);
     cb8:	89 3c 24             	mov    %edi,(%esp)
     cbb:	e8 20 fb ff ff       	call   7e0 <backcmd>
     cc0:	89 c7                	mov    %eax,%edi
    while(peek(ps, es, "&")){
     cc2:	b8 aa 16 00 00       	mov    $0x16aa,%eax
     cc7:	89 44 24 08          	mov    %eax,0x8(%esp)
     ccb:	89 74 24 04          	mov    %esi,0x4(%esp)
     ccf:	89 1c 24             	mov    %ebx,(%esp)
     cd2:	e8 a9 fc ff ff       	call   980 <peek>
     cd7:	85 c0                	test   %eax,%eax
     cd9:	75 c5                	jne    ca0 <parseline+0x20>
    if(peek(ps, es, ";")){
     cdb:	b9 a6 16 00 00       	mov    $0x16a6,%ecx
     ce0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     ce4:	89 74 24 04          	mov    %esi,0x4(%esp)
     ce8:	89 1c 24             	mov    %ebx,(%esp)
     ceb:	e8 90 fc ff ff       	call   980 <peek>
     cf0:	85 c0                	test   %eax,%eax
     cf2:	75 0c                	jne    d00 <parseline+0x80>
}
     cf4:	83 c4 1c             	add    $0x1c,%esp
     cf7:	89 f8                	mov    %edi,%eax
     cf9:	5b                   	pop    %ebx
     cfa:	5e                   	pop    %esi
     cfb:	5f                   	pop    %edi
     cfc:	5d                   	pop    %ebp
     cfd:	c3                   	ret    
     cfe:	66 90                	xchg   %ax,%ax
        gettoken(ps, es, 0, 0);
     d00:	31 d2                	xor    %edx,%edx
     d02:	31 c0                	xor    %eax,%eax
     d04:	89 54 24 08          	mov    %edx,0x8(%esp)
     d08:	89 74 24 04          	mov    %esi,0x4(%esp)
     d0c:	89 1c 24             	mov    %ebx,(%esp)
     d0f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     d13:	e8 08 fb ff ff       	call   820 <gettoken>
        cmd = listcmd(cmd, parseline(ps, es));
     d18:	89 74 24 04          	mov    %esi,0x4(%esp)
     d1c:	89 1c 24             	mov    %ebx,(%esp)
     d1f:	e8 5c ff ff ff       	call   c80 <parseline>
     d24:	89 7d 08             	mov    %edi,0x8(%ebp)
     d27:	89 45 0c             	mov    %eax,0xc(%ebp)
}
     d2a:	83 c4 1c             	add    $0x1c,%esp
     d2d:	5b                   	pop    %ebx
     d2e:	5e                   	pop    %esi
     d2f:	5f                   	pop    %edi
     d30:	5d                   	pop    %ebp
        cmd = listcmd(cmd, parseline(ps, es));
     d31:	e9 5a fa ff ff       	jmp    790 <listcmd>
     d36:	8d 76 00             	lea    0x0(%esi),%esi
     d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d40 <parseblock>:
{
     d40:	55                   	push   %ebp
    if(!peek(ps, es, "("))
     d41:	b8 8c 16 00 00       	mov    $0x168c,%eax
{
     d46:	89 e5                	mov    %esp,%ebp
     d48:	83 ec 28             	sub    $0x28,%esp
     d4b:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     d4e:	8b 5d 08             	mov    0x8(%ebp),%ebx
     d51:	89 75 f8             	mov    %esi,-0x8(%ebp)
     d54:	8b 75 0c             	mov    0xc(%ebp),%esi
    if(!peek(ps, es, "("))
     d57:	89 44 24 08          	mov    %eax,0x8(%esp)
{
     d5b:	89 7d fc             	mov    %edi,-0x4(%ebp)
    if(!peek(ps, es, "("))
     d5e:	89 1c 24             	mov    %ebx,(%esp)
     d61:	89 74 24 04          	mov    %esi,0x4(%esp)
     d65:	e8 16 fc ff ff       	call   980 <peek>
     d6a:	85 c0                	test   %eax,%eax
     d6c:	74 74                	je     de2 <parseblock+0xa2>
    gettoken(ps, es, 0, 0);
     d6e:	31 c9                	xor    %ecx,%ecx
     d70:	31 ff                	xor    %edi,%edi
     d72:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
     d76:	89 7c 24 08          	mov    %edi,0x8(%esp)
     d7a:	89 74 24 04          	mov    %esi,0x4(%esp)
     d7e:	89 1c 24             	mov    %ebx,(%esp)
     d81:	e8 9a fa ff ff       	call   820 <gettoken>
    cmd = parseline(ps, es);
     d86:	89 74 24 04          	mov    %esi,0x4(%esp)
     d8a:	89 1c 24             	mov    %ebx,(%esp)
     d8d:	e8 ee fe ff ff       	call   c80 <parseline>
    if(!peek(ps, es, ")"))
     d92:	89 74 24 04          	mov    %esi,0x4(%esp)
     d96:	89 1c 24             	mov    %ebx,(%esp)
    cmd = parseline(ps, es);
     d99:	89 c7                	mov    %eax,%edi
    if(!peek(ps, es, ")"))
     d9b:	b8 c8 16 00 00       	mov    $0x16c8,%eax
     da0:	89 44 24 08          	mov    %eax,0x8(%esp)
     da4:	e8 d7 fb ff ff       	call   980 <peek>
     da9:	85 c0                	test   %eax,%eax
     dab:	74 41                	je     dee <parseblock+0xae>
    gettoken(ps, es, 0, 0);
     dad:	31 d2                	xor    %edx,%edx
     daf:	31 c0                	xor    %eax,%eax
     db1:	89 54 24 08          	mov    %edx,0x8(%esp)
     db5:	89 74 24 04          	mov    %esi,0x4(%esp)
     db9:	89 1c 24             	mov    %ebx,(%esp)
     dbc:	89 44 24 0c          	mov    %eax,0xc(%esp)
     dc0:	e8 5b fa ff ff       	call   820 <gettoken>
    cmd = parseredirs(cmd, ps, es);
     dc5:	89 74 24 08          	mov    %esi,0x8(%esp)
     dc9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     dcd:	89 3c 24             	mov    %edi,(%esp)
     dd0:	e8 1b fc ff ff       	call   9f0 <parseredirs>
}
     dd5:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     dd8:	8b 75 f8             	mov    -0x8(%ebp),%esi
     ddb:	8b 7d fc             	mov    -0x4(%ebp),%edi
     dde:	89 ec                	mov    %ebp,%esp
     de0:	5d                   	pop    %ebp
     de1:	c3                   	ret    
        panic("parseblock");
     de2:	c7 04 24 ac 16 00 00 	movl   $0x16ac,(%esp)
     de9:	e8 62 f6 ff ff       	call   450 <panic>
        panic("syntax - missing )");
     dee:	c7 04 24 b7 16 00 00 	movl   $0x16b7,(%esp)
     df5:	e8 56 f6 ff ff       	call   450 <panic>
     dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000e00 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     e00:	55                   	push   %ebp
     e01:	89 e5                	mov    %esp,%ebp
     e03:	53                   	push   %ebx
     e04:	83 ec 14             	sub    $0x14,%esp
     e07:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct execcmd *ecmd;
    struct listcmd *lcmd;
    struct pipecmd *pcmd;
    struct redircmd *rcmd;

    if(cmd == 0)
     e0a:	85 db                	test   %ebx,%ebx
     e0c:	74 1d                	je     e2b <nulterminate+0x2b>
        return 0;

    switch(cmd->type){
     e0e:	83 3b 05             	cmpl   $0x5,(%ebx)
     e11:	77 18                	ja     e2b <nulterminate+0x2b>
     e13:	8b 03                	mov    (%ebx),%eax
     e15:	ff 24 85 0c 17 00 00 	jmp    *0x170c(,%eax,4)
     e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            nulterminate(lcmd->right);
            break;

        case BACK:
            bcmd = (struct backcmd*)cmd;
            nulterminate(bcmd->cmd);
     e20:	8b 43 04             	mov    0x4(%ebx),%eax
     e23:	89 04 24             	mov    %eax,(%esp)
     e26:	e8 d5 ff ff ff       	call   e00 <nulterminate>
            break;
    }
    return cmd;
}
     e2b:	83 c4 14             	add    $0x14,%esp
     e2e:	89 d8                	mov    %ebx,%eax
     e30:	5b                   	pop    %ebx
     e31:	5d                   	pop    %ebp
     e32:	c3                   	ret    
     e33:	90                   	nop
     e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            nulterminate(lcmd->left);
     e38:	8b 43 04             	mov    0x4(%ebx),%eax
     e3b:	89 04 24             	mov    %eax,(%esp)
     e3e:	e8 bd ff ff ff       	call   e00 <nulterminate>
            nulterminate(lcmd->right);
     e43:	8b 43 08             	mov    0x8(%ebx),%eax
     e46:	89 04 24             	mov    %eax,(%esp)
     e49:	e8 b2 ff ff ff       	call   e00 <nulterminate>
}
     e4e:	83 c4 14             	add    $0x14,%esp
     e51:	89 d8                	mov    %ebx,%eax
     e53:	5b                   	pop    %ebx
     e54:	5d                   	pop    %ebp
     e55:	c3                   	ret    
     e56:	8d 76 00             	lea    0x0(%esi),%esi
     e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            for(i=0; ecmd->argv[i]; i++)
     e60:	8b 4b 04             	mov    0x4(%ebx),%ecx
     e63:	8d 43 08             	lea    0x8(%ebx),%eax
     e66:	85 c9                	test   %ecx,%ecx
     e68:	74 c1                	je     e2b <nulterminate+0x2b>
     e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                *ecmd->eargv[i] = 0;
     e70:	8b 50 24             	mov    0x24(%eax),%edx
     e73:	83 c0 04             	add    $0x4,%eax
     e76:	c6 02 00             	movb   $0x0,(%edx)
            for(i=0; ecmd->argv[i]; i++)
     e79:	8b 50 fc             	mov    -0x4(%eax),%edx
     e7c:	85 d2                	test   %edx,%edx
     e7e:	75 f0                	jne    e70 <nulterminate+0x70>
}
     e80:	83 c4 14             	add    $0x14,%esp
     e83:	89 d8                	mov    %ebx,%eax
     e85:	5b                   	pop    %ebx
     e86:	5d                   	pop    %ebp
     e87:	c3                   	ret    
     e88:	90                   	nop
     e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            nulterminate(rcmd->cmd);
     e90:	8b 43 04             	mov    0x4(%ebx),%eax
     e93:	89 04 24             	mov    %eax,(%esp)
     e96:	e8 65 ff ff ff       	call   e00 <nulterminate>
            *rcmd->efile = 0;
     e9b:	8b 43 0c             	mov    0xc(%ebx),%eax
     e9e:	c6 00 00             	movb   $0x0,(%eax)
}
     ea1:	83 c4 14             	add    $0x14,%esp
     ea4:	89 d8                	mov    %ebx,%eax
     ea6:	5b                   	pop    %ebx
     ea7:	5d                   	pop    %ebp
     ea8:	c3                   	ret    
     ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000eb0 <parsecmd>:
{
     eb0:	55                   	push   %ebp
     eb1:	89 e5                	mov    %esp,%ebp
     eb3:	56                   	push   %esi
     eb4:	53                   	push   %ebx
     eb5:	83 ec 10             	sub    $0x10,%esp
    es = s + strlen(s);
     eb8:	8b 5d 08             	mov    0x8(%ebp),%ebx
     ebb:	89 1c 24             	mov    %ebx,(%esp)
     ebe:	e8 cd 00 00 00       	call   f90 <strlen>
     ec3:	01 c3                	add    %eax,%ebx
    cmd = parseline(&s, es);
     ec5:	8d 45 08             	lea    0x8(%ebp),%eax
     ec8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     ecc:	89 04 24             	mov    %eax,(%esp)
     ecf:	e8 ac fd ff ff       	call   c80 <parseline>
    peek(&s, es, "");
     ed4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    cmd = parseline(&s, es);
     ed8:	89 c6                	mov    %eax,%esi
    peek(&s, es, "");
     eda:	b8 51 16 00 00       	mov    $0x1651,%eax
     edf:	89 44 24 08          	mov    %eax,0x8(%esp)
     ee3:	8d 45 08             	lea    0x8(%ebp),%eax
     ee6:	89 04 24             	mov    %eax,(%esp)
     ee9:	e8 92 fa ff ff       	call   980 <peek>
    if(s != es){
     eee:	8b 45 08             	mov    0x8(%ebp),%eax
     ef1:	39 d8                	cmp    %ebx,%eax
     ef3:	75 11                	jne    f06 <parsecmd+0x56>
    nulterminate(cmd);
     ef5:	89 34 24             	mov    %esi,(%esp)
     ef8:	e8 03 ff ff ff       	call   e00 <nulterminate>
}
     efd:	83 c4 10             	add    $0x10,%esp
     f00:	89 f0                	mov    %esi,%eax
     f02:	5b                   	pop    %ebx
     f03:	5e                   	pop    %esi
     f04:	5d                   	pop    %ebp
     f05:	c3                   	ret    
        printf(2, "leftovers: %s\n", s);
     f06:	89 44 24 08          	mov    %eax,0x8(%esp)
     f0a:	c7 44 24 04 ca 16 00 	movl   $0x16ca,0x4(%esp)
     f11:	00 
     f12:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     f19:	e8 a2 03 00 00       	call   12c0 <printf>
        panic("syntax");
     f1e:	c7 04 24 8e 16 00 00 	movl   $0x168e,(%esp)
     f25:	e8 26 f5 ff ff       	call   450 <panic>
     f2a:	66 90                	xchg   %ax,%ax
     f2c:	66 90                	xchg   %ax,%ax
     f2e:	66 90                	xchg   %ax,%ax

00000f30 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     f30:	55                   	push   %ebp
     f31:	89 e5                	mov    %esp,%ebp
     f33:	8b 45 08             	mov    0x8(%ebp),%eax
     f36:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     f39:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     f3a:	89 c2                	mov    %eax,%edx
     f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     f40:	41                   	inc    %ecx
     f41:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     f45:	42                   	inc    %edx
     f46:	84 db                	test   %bl,%bl
     f48:	88 5a ff             	mov    %bl,-0x1(%edx)
     f4b:	75 f3                	jne    f40 <strcpy+0x10>
    ;
  return os;
}
     f4d:	5b                   	pop    %ebx
     f4e:	5d                   	pop    %ebp
     f4f:	c3                   	ret    

00000f50 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     f50:	55                   	push   %ebp
     f51:	89 e5                	mov    %esp,%ebp
     f53:	8b 4d 08             	mov    0x8(%ebp),%ecx
     f56:	53                   	push   %ebx
     f57:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
     f5a:	0f b6 01             	movzbl (%ecx),%eax
     f5d:	0f b6 13             	movzbl (%ebx),%edx
     f60:	84 c0                	test   %al,%al
     f62:	75 18                	jne    f7c <strcmp+0x2c>
     f64:	eb 22                	jmp    f88 <strcmp+0x38>
     f66:	8d 76 00             	lea    0x0(%esi),%esi
     f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     f70:	41                   	inc    %ecx
  while(*p && *p == *q)
     f71:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
     f74:	43                   	inc    %ebx
     f75:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
     f78:	84 c0                	test   %al,%al
     f7a:	74 0c                	je     f88 <strcmp+0x38>
     f7c:	38 d0                	cmp    %dl,%al
     f7e:	74 f0                	je     f70 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
     f80:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
     f81:	29 d0                	sub    %edx,%eax
}
     f83:	5d                   	pop    %ebp
     f84:	c3                   	ret    
     f85:	8d 76 00             	lea    0x0(%esi),%esi
     f88:	5b                   	pop    %ebx
     f89:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     f8b:	29 d0                	sub    %edx,%eax
}
     f8d:	5d                   	pop    %ebp
     f8e:	c3                   	ret    
     f8f:	90                   	nop

00000f90 <strlen>:

uint
strlen(const char *s)
{
     f90:	55                   	push   %ebp
     f91:	89 e5                	mov    %esp,%ebp
     f93:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     f96:	80 39 00             	cmpb   $0x0,(%ecx)
     f99:	74 15                	je     fb0 <strlen+0x20>
     f9b:	31 d2                	xor    %edx,%edx
     f9d:	8d 76 00             	lea    0x0(%esi),%esi
     fa0:	42                   	inc    %edx
     fa1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     fa5:	89 d0                	mov    %edx,%eax
     fa7:	75 f7                	jne    fa0 <strlen+0x10>
    ;
  return n;
}
     fa9:	5d                   	pop    %ebp
     faa:	c3                   	ret    
     fab:	90                   	nop
     fac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
     fb0:	31 c0                	xor    %eax,%eax
}
     fb2:	5d                   	pop    %ebp
     fb3:	c3                   	ret    
     fb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     fba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000fc0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     fc0:	55                   	push   %ebp
     fc1:	89 e5                	mov    %esp,%ebp
     fc3:	8b 55 08             	mov    0x8(%ebp),%edx
     fc6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     fc7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     fca:	8b 45 0c             	mov    0xc(%ebp),%eax
     fcd:	89 d7                	mov    %edx,%edi
     fcf:	fc                   	cld    
     fd0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     fd2:	5f                   	pop    %edi
     fd3:	89 d0                	mov    %edx,%eax
     fd5:	5d                   	pop    %ebp
     fd6:	c3                   	ret    
     fd7:	89 f6                	mov    %esi,%esi
     fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000fe0 <strchr>:

char*
strchr(const char *s, char c)
{
     fe0:	55                   	push   %ebp
     fe1:	89 e5                	mov    %esp,%ebp
     fe3:	8b 45 08             	mov    0x8(%ebp),%eax
     fe6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     fea:	0f b6 10             	movzbl (%eax),%edx
     fed:	84 d2                	test   %dl,%dl
     fef:	74 1b                	je     100c <strchr+0x2c>
    if(*s == c)
     ff1:	38 d1                	cmp    %dl,%cl
     ff3:	75 0f                	jne    1004 <strchr+0x24>
     ff5:	eb 17                	jmp    100e <strchr+0x2e>
     ff7:	89 f6                	mov    %esi,%esi
     ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    1000:	38 ca                	cmp    %cl,%dl
    1002:	74 0a                	je     100e <strchr+0x2e>
  for(; *s; s++)
    1004:	40                   	inc    %eax
    1005:	0f b6 10             	movzbl (%eax),%edx
    1008:	84 d2                	test   %dl,%dl
    100a:	75 f4                	jne    1000 <strchr+0x20>
      return (char*)s;
  return 0;
    100c:	31 c0                	xor    %eax,%eax
}
    100e:	5d                   	pop    %ebp
    100f:	c3                   	ret    

00001010 <gets>:

char*
gets(char *buf, int max)
{
    1010:	55                   	push   %ebp
    1011:	89 e5                	mov    %esp,%ebp
    1013:	57                   	push   %edi
    1014:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1015:	31 f6                	xor    %esi,%esi
{
    1017:	53                   	push   %ebx
    1018:	83 ec 3c             	sub    $0x3c,%esp
    101b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
    101e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
    1021:	eb 32                	jmp    1055 <gets+0x45>
    1023:	90                   	nop
    1024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
    1028:	ba 01 00 00 00       	mov    $0x1,%edx
    102d:	89 54 24 08          	mov    %edx,0x8(%esp)
    1031:	89 7c 24 04          	mov    %edi,0x4(%esp)
    1035:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    103c:	e8 2f 01 00 00       	call   1170 <read>
    if(cc < 1)
    1041:	85 c0                	test   %eax,%eax
    1043:	7e 19                	jle    105e <gets+0x4e>
      break;
    buf[i++] = c;
    1045:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1049:	43                   	inc    %ebx
    104a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
    104d:	3c 0a                	cmp    $0xa,%al
    104f:	74 1f                	je     1070 <gets+0x60>
    1051:	3c 0d                	cmp    $0xd,%al
    1053:	74 1b                	je     1070 <gets+0x60>
  for(i=0; i+1 < max; ){
    1055:	46                   	inc    %esi
    1056:	3b 75 0c             	cmp    0xc(%ebp),%esi
    1059:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    105c:	7c ca                	jl     1028 <gets+0x18>
      break;
  }
  buf[i] = '\0';
    105e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1061:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
    1064:	8b 45 08             	mov    0x8(%ebp),%eax
    1067:	83 c4 3c             	add    $0x3c,%esp
    106a:	5b                   	pop    %ebx
    106b:	5e                   	pop    %esi
    106c:	5f                   	pop    %edi
    106d:	5d                   	pop    %ebp
    106e:	c3                   	ret    
    106f:	90                   	nop
    1070:	8b 45 08             	mov    0x8(%ebp),%eax
    1073:	01 c6                	add    %eax,%esi
    1075:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    1078:	eb e4                	jmp    105e <gets+0x4e>
    107a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001080 <stat>:

int
stat(const char *n, struct stat *st)
{
    1080:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1081:	31 c0                	xor    %eax,%eax
{
    1083:	89 e5                	mov    %esp,%ebp
    1085:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
    1088:	89 44 24 04          	mov    %eax,0x4(%esp)
    108c:	8b 45 08             	mov    0x8(%ebp),%eax
{
    108f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    1092:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
    1095:	89 04 24             	mov    %eax,(%esp)
    1098:	e8 fb 00 00 00       	call   1198 <open>
  if(fd < 0)
    109d:	85 c0                	test   %eax,%eax
    109f:	78 2f                	js     10d0 <stat+0x50>
    10a1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    10a3:	8b 45 0c             	mov    0xc(%ebp),%eax
    10a6:	89 1c 24             	mov    %ebx,(%esp)
    10a9:	89 44 24 04          	mov    %eax,0x4(%esp)
    10ad:	e8 fe 00 00 00       	call   11b0 <fstat>
  close(fd);
    10b2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    10b5:	89 c6                	mov    %eax,%esi
  close(fd);
    10b7:	e8 c4 00 00 00       	call   1180 <close>
  return r;
}
    10bc:	89 f0                	mov    %esi,%eax
    10be:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    10c1:	8b 75 fc             	mov    -0x4(%ebp),%esi
    10c4:	89 ec                	mov    %ebp,%esp
    10c6:	5d                   	pop    %ebp
    10c7:	c3                   	ret    
    10c8:	90                   	nop
    10c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
    10d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    10d5:	eb e5                	jmp    10bc <stat+0x3c>
    10d7:	89 f6                	mov    %esi,%esi
    10d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000010e0 <atoi>:

int
atoi(const char *s)
{
    10e0:	55                   	push   %ebp
    10e1:	89 e5                	mov    %esp,%ebp
    10e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
    10e6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    10e7:	0f be 11             	movsbl (%ecx),%edx
    10ea:	88 d0                	mov    %dl,%al
    10ec:	2c 30                	sub    $0x30,%al
    10ee:	3c 09                	cmp    $0x9,%al
  n = 0;
    10f0:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    10f5:	77 1e                	ja     1115 <atoi+0x35>
    10f7:	89 f6                	mov    %esi,%esi
    10f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    1100:	41                   	inc    %ecx
    1101:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1104:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    1108:	0f be 11             	movsbl (%ecx),%edx
    110b:	88 d3                	mov    %dl,%bl
    110d:	80 eb 30             	sub    $0x30,%bl
    1110:	80 fb 09             	cmp    $0x9,%bl
    1113:	76 eb                	jbe    1100 <atoi+0x20>
  return n;
}
    1115:	5b                   	pop    %ebx
    1116:	5d                   	pop    %ebp
    1117:	c3                   	ret    
    1118:	90                   	nop
    1119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001120 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1120:	55                   	push   %ebp
    1121:	89 e5                	mov    %esp,%ebp
    1123:	56                   	push   %esi
    1124:	8b 45 08             	mov    0x8(%ebp),%eax
    1127:	53                   	push   %ebx
    1128:	8b 5d 10             	mov    0x10(%ebp),%ebx
    112b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    112e:	85 db                	test   %ebx,%ebx
    1130:	7e 1a                	jle    114c <memmove+0x2c>
    1132:	31 d2                	xor    %edx,%edx
    1134:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    113a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
    1140:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    1144:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    1147:	42                   	inc    %edx
  while(n-- > 0)
    1148:	39 d3                	cmp    %edx,%ebx
    114a:	75 f4                	jne    1140 <memmove+0x20>
  return vdst;
}
    114c:	5b                   	pop    %ebx
    114d:	5e                   	pop    %esi
    114e:	5d                   	pop    %ebp
    114f:	c3                   	ret    

00001150 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1150:	b8 01 00 00 00       	mov    $0x1,%eax
    1155:	cd 40                	int    $0x40
    1157:	c3                   	ret    

00001158 <exit>:
SYSCALL(exit)
    1158:	b8 02 00 00 00       	mov    $0x2,%eax
    115d:	cd 40                	int    $0x40
    115f:	c3                   	ret    

00001160 <wait>:
SYSCALL(wait)
    1160:	b8 03 00 00 00       	mov    $0x3,%eax
    1165:	cd 40                	int    $0x40
    1167:	c3                   	ret    

00001168 <pipe>:
SYSCALL(pipe)
    1168:	b8 04 00 00 00       	mov    $0x4,%eax
    116d:	cd 40                	int    $0x40
    116f:	c3                   	ret    

00001170 <read>:
SYSCALL(read)
    1170:	b8 05 00 00 00       	mov    $0x5,%eax
    1175:	cd 40                	int    $0x40
    1177:	c3                   	ret    

00001178 <write>:
SYSCALL(write)
    1178:	b8 10 00 00 00       	mov    $0x10,%eax
    117d:	cd 40                	int    $0x40
    117f:	c3                   	ret    

00001180 <close>:
SYSCALL(close)
    1180:	b8 15 00 00 00       	mov    $0x15,%eax
    1185:	cd 40                	int    $0x40
    1187:	c3                   	ret    

00001188 <kill>:
SYSCALL(kill)
    1188:	b8 06 00 00 00       	mov    $0x6,%eax
    118d:	cd 40                	int    $0x40
    118f:	c3                   	ret    

00001190 <exec>:
SYSCALL(exec)
    1190:	b8 07 00 00 00       	mov    $0x7,%eax
    1195:	cd 40                	int    $0x40
    1197:	c3                   	ret    

00001198 <open>:
SYSCALL(open)
    1198:	b8 0f 00 00 00       	mov    $0xf,%eax
    119d:	cd 40                	int    $0x40
    119f:	c3                   	ret    

000011a0 <mknod>:
SYSCALL(mknod)
    11a0:	b8 11 00 00 00       	mov    $0x11,%eax
    11a5:	cd 40                	int    $0x40
    11a7:	c3                   	ret    

000011a8 <unlink>:
SYSCALL(unlink)
    11a8:	b8 12 00 00 00       	mov    $0x12,%eax
    11ad:	cd 40                	int    $0x40
    11af:	c3                   	ret    

000011b0 <fstat>:
SYSCALL(fstat)
    11b0:	b8 08 00 00 00       	mov    $0x8,%eax
    11b5:	cd 40                	int    $0x40
    11b7:	c3                   	ret    

000011b8 <link>:
SYSCALL(link)
    11b8:	b8 13 00 00 00       	mov    $0x13,%eax
    11bd:	cd 40                	int    $0x40
    11bf:	c3                   	ret    

000011c0 <mkdir>:
SYSCALL(mkdir)
    11c0:	b8 14 00 00 00       	mov    $0x14,%eax
    11c5:	cd 40                	int    $0x40
    11c7:	c3                   	ret    

000011c8 <chdir>:
SYSCALL(chdir)
    11c8:	b8 09 00 00 00       	mov    $0x9,%eax
    11cd:	cd 40                	int    $0x40
    11cf:	c3                   	ret    

000011d0 <dup>:
SYSCALL(dup)
    11d0:	b8 0a 00 00 00       	mov    $0xa,%eax
    11d5:	cd 40                	int    $0x40
    11d7:	c3                   	ret    

000011d8 <getpid>:
SYSCALL(getpid)
    11d8:	b8 0b 00 00 00       	mov    $0xb,%eax
    11dd:	cd 40                	int    $0x40
    11df:	c3                   	ret    

000011e0 <sbrk>:
SYSCALL(sbrk)
    11e0:	b8 0c 00 00 00       	mov    $0xc,%eax
    11e5:	cd 40                	int    $0x40
    11e7:	c3                   	ret    

000011e8 <sleep>:
SYSCALL(sleep)
    11e8:	b8 0d 00 00 00       	mov    $0xd,%eax
    11ed:	cd 40                	int    $0x40
    11ef:	c3                   	ret    

000011f0 <uptime>:
SYSCALL(uptime)
    11f0:	b8 0e 00 00 00       	mov    $0xe,%eax
    11f5:	cd 40                	int    $0x40
    11f7:	c3                   	ret    

000011f8 <policy>:
SYSCALL(policy)
    11f8:	b8 17 00 00 00       	mov    $0x17,%eax
    11fd:	cd 40                	int    $0x40
    11ff:	c3                   	ret    

00001200 <detach>:
SYSCALL(detach)
    1200:	b8 16 00 00 00       	mov    $0x16,%eax
    1205:	cd 40                	int    $0x40
    1207:	c3                   	ret    

00001208 <priority>:
SYSCALL(priority)
    1208:	b8 18 00 00 00       	mov    $0x18,%eax
    120d:	cd 40                	int    $0x40
    120f:	c3                   	ret    

00001210 <wait_stat>:
SYSCALL(wait_stat)
    1210:	b8 19 00 00 00       	mov    $0x19,%eax
    1215:	cd 40                	int    $0x40
    1217:	c3                   	ret    
    1218:	66 90                	xchg   %ax,%ax
    121a:	66 90                	xchg   %ax,%ax
    121c:	66 90                	xchg   %ax,%ax
    121e:	66 90                	xchg   %ax,%ax

00001220 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1220:	55                   	push   %ebp
    1221:	89 e5                	mov    %esp,%ebp
    1223:	57                   	push   %edi
    1224:	56                   	push   %esi
    1225:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1226:	89 d3                	mov    %edx,%ebx
    1228:	c1 eb 1f             	shr    $0x1f,%ebx
{
    122b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
    122e:	84 db                	test   %bl,%bl
{
    1230:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1233:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    1235:	74 79                	je     12b0 <printint+0x90>
    1237:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    123b:	74 73                	je     12b0 <printint+0x90>
    neg = 1;
    x = -xx;
    123d:	f7 d8                	neg    %eax
    neg = 1;
    123f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1246:	31 f6                	xor    %esi,%esi
    1248:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    124b:	eb 05                	jmp    1252 <printint+0x32>
    124d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1250:	89 fe                	mov    %edi,%esi
    1252:	31 d2                	xor    %edx,%edx
    1254:	f7 f1                	div    %ecx
    1256:	8d 7e 01             	lea    0x1(%esi),%edi
    1259:	0f b6 92 50 17 00 00 	movzbl 0x1750(%edx),%edx
  }while((x /= base) != 0);
    1260:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    1262:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    1265:	75 e9                	jne    1250 <printint+0x30>
  if(neg)
    1267:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    126a:	85 d2                	test   %edx,%edx
    126c:	74 08                	je     1276 <printint+0x56>
    buf[i++] = '-';
    126e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    1273:	8d 7e 02             	lea    0x2(%esi),%edi
    1276:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    127a:	8b 7d c0             	mov    -0x40(%ebp),%edi
    127d:	8d 76 00             	lea    0x0(%esi),%esi
    1280:	0f b6 06             	movzbl (%esi),%eax
    1283:	4e                   	dec    %esi
  write(fd, &c, 1);
    1284:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    1288:	89 3c 24             	mov    %edi,(%esp)
    128b:	88 45 d7             	mov    %al,-0x29(%ebp)
    128e:	b8 01 00 00 00       	mov    $0x1,%eax
    1293:	89 44 24 08          	mov    %eax,0x8(%esp)
    1297:	e8 dc fe ff ff       	call   1178 <write>

  while(--i >= 0)
    129c:	39 de                	cmp    %ebx,%esi
    129e:	75 e0                	jne    1280 <printint+0x60>
    putc(fd, buf[i]);
}
    12a0:	83 c4 4c             	add    $0x4c,%esp
    12a3:	5b                   	pop    %ebx
    12a4:	5e                   	pop    %esi
    12a5:	5f                   	pop    %edi
    12a6:	5d                   	pop    %ebp
    12a7:	c3                   	ret    
    12a8:	90                   	nop
    12a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    12b0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    12b7:	eb 8d                	jmp    1246 <printint+0x26>
    12b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000012c0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    12c0:	55                   	push   %ebp
    12c1:	89 e5                	mov    %esp,%ebp
    12c3:	57                   	push   %edi
    12c4:	56                   	push   %esi
    12c5:	53                   	push   %ebx
    12c6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    12c9:	8b 75 0c             	mov    0xc(%ebp),%esi
    12cc:	0f b6 1e             	movzbl (%esi),%ebx
    12cf:	84 db                	test   %bl,%bl
    12d1:	0f 84 d1 00 00 00    	je     13a8 <printf+0xe8>
  state = 0;
    12d7:	31 ff                	xor    %edi,%edi
    12d9:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
    12da:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
    12dd:	89 fa                	mov    %edi,%edx
    12df:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
    12e2:	89 45 d0             	mov    %eax,-0x30(%ebp)
    12e5:	eb 41                	jmp    1328 <printf+0x68>
    12e7:	89 f6                	mov    %esi,%esi
    12e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    12f0:	83 f8 25             	cmp    $0x25,%eax
    12f3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
    12f6:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    12fb:	74 1e                	je     131b <printf+0x5b>
  write(fd, &c, 1);
    12fd:	b8 01 00 00 00       	mov    $0x1,%eax
    1302:	89 44 24 08          	mov    %eax,0x8(%esp)
    1306:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1309:	89 44 24 04          	mov    %eax,0x4(%esp)
    130d:	89 3c 24             	mov    %edi,(%esp)
    1310:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    1313:	e8 60 fe ff ff       	call   1178 <write>
    1318:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    131b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
    131c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    1320:	84 db                	test   %bl,%bl
    1322:	0f 84 80 00 00 00    	je     13a8 <printf+0xe8>
    if(state == 0){
    1328:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
    132a:	0f be cb             	movsbl %bl,%ecx
    132d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1330:	74 be                	je     12f0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1332:	83 fa 25             	cmp    $0x25,%edx
    1335:	75 e4                	jne    131b <printf+0x5b>
      if(c == 'd'){
    1337:	83 f8 64             	cmp    $0x64,%eax
    133a:	0f 84 f0 00 00 00    	je     1430 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1340:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    1346:	83 f9 70             	cmp    $0x70,%ecx
    1349:	74 65                	je     13b0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    134b:	83 f8 73             	cmp    $0x73,%eax
    134e:	0f 84 8c 00 00 00    	je     13e0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1354:	83 f8 63             	cmp    $0x63,%eax
    1357:	0f 84 13 01 00 00    	je     1470 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    135d:	83 f8 25             	cmp    $0x25,%eax
    1360:	0f 84 e2 00 00 00    	je     1448 <printf+0x188>
  write(fd, &c, 1);
    1366:	b8 01 00 00 00       	mov    $0x1,%eax
    136b:	46                   	inc    %esi
    136c:	89 44 24 08          	mov    %eax,0x8(%esp)
    1370:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1373:	89 44 24 04          	mov    %eax,0x4(%esp)
    1377:	89 3c 24             	mov    %edi,(%esp)
    137a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    137e:	e8 f5 fd ff ff       	call   1178 <write>
    1383:	ba 01 00 00 00       	mov    $0x1,%edx
    1388:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    138b:	89 54 24 08          	mov    %edx,0x8(%esp)
    138f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1393:	89 3c 24             	mov    %edi,(%esp)
    1396:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    1399:	e8 da fd ff ff       	call   1178 <write>
  for(i = 0; fmt[i]; i++){
    139e:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    13a2:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    13a4:	84 db                	test   %bl,%bl
    13a6:	75 80                	jne    1328 <printf+0x68>
    }
  }
}
    13a8:	83 c4 3c             	add    $0x3c,%esp
    13ab:	5b                   	pop    %ebx
    13ac:	5e                   	pop    %esi
    13ad:	5f                   	pop    %edi
    13ae:	5d                   	pop    %ebp
    13af:	c3                   	ret    
        printint(fd, *ap, 16, 0);
    13b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    13b7:	b9 10 00 00 00       	mov    $0x10,%ecx
    13bc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    13bf:	89 f8                	mov    %edi,%eax
    13c1:	8b 13                	mov    (%ebx),%edx
    13c3:	e8 58 fe ff ff       	call   1220 <printint>
        ap++;
    13c8:	89 d8                	mov    %ebx,%eax
      state = 0;
    13ca:	31 d2                	xor    %edx,%edx
        ap++;
    13cc:	83 c0 04             	add    $0x4,%eax
    13cf:	89 45 d0             	mov    %eax,-0x30(%ebp)
    13d2:	e9 44 ff ff ff       	jmp    131b <printf+0x5b>
    13d7:	89 f6                	mov    %esi,%esi
    13d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
    13e0:	8b 45 d0             	mov    -0x30(%ebp),%eax
    13e3:	8b 10                	mov    (%eax),%edx
        ap++;
    13e5:	83 c0 04             	add    $0x4,%eax
    13e8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    13eb:	85 d2                	test   %edx,%edx
    13ed:	0f 84 aa 00 00 00    	je     149d <printf+0x1dd>
        while(*s != 0){
    13f3:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
    13f6:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
    13f8:	84 c0                	test   %al,%al
    13fa:	74 27                	je     1423 <printf+0x163>
    13fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1400:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    1403:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
    1408:	43                   	inc    %ebx
  write(fd, &c, 1);
    1409:	89 44 24 08          	mov    %eax,0x8(%esp)
    140d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    1410:	89 44 24 04          	mov    %eax,0x4(%esp)
    1414:	89 3c 24             	mov    %edi,(%esp)
    1417:	e8 5c fd ff ff       	call   1178 <write>
        while(*s != 0){
    141c:	0f b6 03             	movzbl (%ebx),%eax
    141f:	84 c0                	test   %al,%al
    1421:	75 dd                	jne    1400 <printf+0x140>
      state = 0;
    1423:	31 d2                	xor    %edx,%edx
    1425:	e9 f1 fe ff ff       	jmp    131b <printf+0x5b>
    142a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    1430:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1437:	b9 0a 00 00 00       	mov    $0xa,%ecx
    143c:	e9 7b ff ff ff       	jmp    13bc <printf+0xfc>
    1441:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
    1448:	b9 01 00 00 00       	mov    $0x1,%ecx
    144d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1450:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    1454:	89 44 24 04          	mov    %eax,0x4(%esp)
    1458:	89 3c 24             	mov    %edi,(%esp)
    145b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    145e:	e8 15 fd ff ff       	call   1178 <write>
      state = 0;
    1463:	31 d2                	xor    %edx,%edx
    1465:	e9 b1 fe ff ff       	jmp    131b <printf+0x5b>
    146a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
    1470:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    1473:	8b 03                	mov    (%ebx),%eax
        ap++;
    1475:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    1478:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
    147b:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    147e:	b8 01 00 00 00       	mov    $0x1,%eax
    1483:	89 44 24 08          	mov    %eax,0x8(%esp)
    1487:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    148a:	89 44 24 04          	mov    %eax,0x4(%esp)
    148e:	e8 e5 fc ff ff       	call   1178 <write>
      state = 0;
    1493:	31 d2                	xor    %edx,%edx
        ap++;
    1495:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    1498:	e9 7e fe ff ff       	jmp    131b <printf+0x5b>
          s = "(null)";
    149d:	bb 48 17 00 00       	mov    $0x1748,%ebx
        while(*s != 0){
    14a2:	b0 28                	mov    $0x28,%al
    14a4:	e9 57 ff ff ff       	jmp    1400 <printf+0x140>
    14a9:	66 90                	xchg   %ax,%ax
    14ab:	66 90                	xchg   %ax,%ax
    14ad:	66 90                	xchg   %ax,%ax
    14af:	90                   	nop

000014b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    14b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14b1:	a1 64 1e 00 00       	mov    0x1e64,%eax
{
    14b6:	89 e5                	mov    %esp,%ebp
    14b8:	57                   	push   %edi
    14b9:	56                   	push   %esi
    14ba:	53                   	push   %ebx
    14bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    14be:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    14c1:	eb 0d                	jmp    14d0 <free+0x20>
    14c3:	90                   	nop
    14c4:	90                   	nop
    14c5:	90                   	nop
    14c6:	90                   	nop
    14c7:	90                   	nop
    14c8:	90                   	nop
    14c9:	90                   	nop
    14ca:	90                   	nop
    14cb:	90                   	nop
    14cc:	90                   	nop
    14cd:	90                   	nop
    14ce:	90                   	nop
    14cf:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14d0:	39 c8                	cmp    %ecx,%eax
    14d2:	8b 10                	mov    (%eax),%edx
    14d4:	73 32                	jae    1508 <free+0x58>
    14d6:	39 d1                	cmp    %edx,%ecx
    14d8:	72 04                	jb     14de <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14da:	39 d0                	cmp    %edx,%eax
    14dc:	72 32                	jb     1510 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
    14de:	8b 73 fc             	mov    -0x4(%ebx),%esi
    14e1:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    14e4:	39 fa                	cmp    %edi,%edx
    14e6:	74 30                	je     1518 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    14e8:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    14eb:	8b 50 04             	mov    0x4(%eax),%edx
    14ee:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    14f1:	39 f1                	cmp    %esi,%ecx
    14f3:	74 3c                	je     1531 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    14f5:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
    14f7:	5b                   	pop    %ebx
  freep = p;
    14f8:	a3 64 1e 00 00       	mov    %eax,0x1e64
}
    14fd:	5e                   	pop    %esi
    14fe:	5f                   	pop    %edi
    14ff:	5d                   	pop    %ebp
    1500:	c3                   	ret    
    1501:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1508:	39 d0                	cmp    %edx,%eax
    150a:	72 04                	jb     1510 <free+0x60>
    150c:	39 d1                	cmp    %edx,%ecx
    150e:	72 ce                	jb     14de <free+0x2e>
{
    1510:	89 d0                	mov    %edx,%eax
    1512:	eb bc                	jmp    14d0 <free+0x20>
    1514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1518:	8b 7a 04             	mov    0x4(%edx),%edi
    151b:	01 fe                	add    %edi,%esi
    151d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1520:	8b 10                	mov    (%eax),%edx
    1522:	8b 12                	mov    (%edx),%edx
    1524:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1527:	8b 50 04             	mov    0x4(%eax),%edx
    152a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    152d:	39 f1                	cmp    %esi,%ecx
    152f:	75 c4                	jne    14f5 <free+0x45>
    p->s.size += bp->s.size;
    1531:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
    1534:	a3 64 1e 00 00       	mov    %eax,0x1e64
    p->s.size += bp->s.size;
    1539:	01 ca                	add    %ecx,%edx
    153b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    153e:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1541:	89 10                	mov    %edx,(%eax)
}
    1543:	5b                   	pop    %ebx
    1544:	5e                   	pop    %esi
    1545:	5f                   	pop    %edi
    1546:	5d                   	pop    %ebp
    1547:	c3                   	ret    
    1548:	90                   	nop
    1549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001550 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1550:	55                   	push   %ebp
    1551:	89 e5                	mov    %esp,%ebp
    1553:	57                   	push   %edi
    1554:	56                   	push   %esi
    1555:	53                   	push   %ebx
    1556:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1559:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    155c:	8b 15 64 1e 00 00    	mov    0x1e64,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1562:	8d 78 07             	lea    0x7(%eax),%edi
    1565:	c1 ef 03             	shr    $0x3,%edi
    1568:	47                   	inc    %edi
  if((prevp = freep) == 0){
    1569:	85 d2                	test   %edx,%edx
    156b:	0f 84 8f 00 00 00    	je     1600 <malloc+0xb0>
    1571:	8b 02                	mov    (%edx),%eax
    1573:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1576:	39 cf                	cmp    %ecx,%edi
    1578:	76 66                	jbe    15e0 <malloc+0x90>
    157a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1580:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1585:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    1588:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    158f:	eb 10                	jmp    15a1 <malloc+0x51>
    1591:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1598:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    159a:	8b 48 04             	mov    0x4(%eax),%ecx
    159d:	39 f9                	cmp    %edi,%ecx
    159f:	73 3f                	jae    15e0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    15a1:	39 05 64 1e 00 00    	cmp    %eax,0x1e64
    15a7:	89 c2                	mov    %eax,%edx
    15a9:	75 ed                	jne    1598 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    15ab:	89 34 24             	mov    %esi,(%esp)
    15ae:	e8 2d fc ff ff       	call   11e0 <sbrk>
  if(p == (char*)-1)
    15b3:	83 f8 ff             	cmp    $0xffffffff,%eax
    15b6:	74 18                	je     15d0 <malloc+0x80>
  hp->s.size = nu;
    15b8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    15bb:	83 c0 08             	add    $0x8,%eax
    15be:	89 04 24             	mov    %eax,(%esp)
    15c1:	e8 ea fe ff ff       	call   14b0 <free>
  return freep;
    15c6:	8b 15 64 1e 00 00    	mov    0x1e64,%edx
      if((p = morecore(nunits)) == 0)
    15cc:	85 d2                	test   %edx,%edx
    15ce:	75 c8                	jne    1598 <malloc+0x48>
        return 0;
  }
}
    15d0:	83 c4 1c             	add    $0x1c,%esp
        return 0;
    15d3:	31 c0                	xor    %eax,%eax
}
    15d5:	5b                   	pop    %ebx
    15d6:	5e                   	pop    %esi
    15d7:	5f                   	pop    %edi
    15d8:	5d                   	pop    %ebp
    15d9:	c3                   	ret    
    15da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    15e0:	39 cf                	cmp    %ecx,%edi
    15e2:	74 4c                	je     1630 <malloc+0xe0>
        p->s.size -= nunits;
    15e4:	29 f9                	sub    %edi,%ecx
    15e6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    15e9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    15ec:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    15ef:	89 15 64 1e 00 00    	mov    %edx,0x1e64
}
    15f5:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
    15f8:	83 c0 08             	add    $0x8,%eax
}
    15fb:	5b                   	pop    %ebx
    15fc:	5e                   	pop    %esi
    15fd:	5f                   	pop    %edi
    15fe:	5d                   	pop    %ebp
    15ff:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    1600:	b8 68 1e 00 00       	mov    $0x1e68,%eax
    1605:	ba 68 1e 00 00       	mov    $0x1e68,%edx
    base.s.size = 0;
    160a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
    160c:	a3 64 1e 00 00       	mov    %eax,0x1e64
    base.s.size = 0;
    1611:	b8 68 1e 00 00       	mov    $0x1e68,%eax
    base.s.ptr = freep = prevp = &base;
    1616:	89 15 68 1e 00 00    	mov    %edx,0x1e68
    base.s.size = 0;
    161c:	89 0d 6c 1e 00 00    	mov    %ecx,0x1e6c
    1622:	e9 53 ff ff ff       	jmp    157a <malloc+0x2a>
    1627:	89 f6                	mov    %esi,%esi
    1629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
    1630:	8b 08                	mov    (%eax),%ecx
    1632:	89 0a                	mov    %ecx,(%edx)
    1634:	eb b9                	jmp    15ef <malloc+0x9f>
