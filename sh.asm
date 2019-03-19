
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
      22:	c7 04 24 ff 16 00 00 	movl   $0x16ff,(%esp)
      29:	e8 9a 11 00 00       	call   11c8 <open>
      2e:	85 c0                	test   %eax,%eax
      30:	79 de                	jns    10 <main+0x10>


    // from here
    int fd2;

    if((fd2 = open("path", O_RDWR)) >= 0){
      32:	ba 02 00 00 00       	mov    $0x2,%edx
      37:	89 54 24 04          	mov    %edx,0x4(%esp)
      3b:	c7 04 24 07 17 00 00 	movl   $0x1707,(%esp)
      42:	e8 81 11 00 00       	call   11c8 <open>
      47:	85 c0                	test   %eax,%eax
      49:	78 27                	js     72 <main+0x72>
      4b:	e9 a8 00 00 00       	jmp    f8 <main+0xf8>
int
fork1(void)
{
    int pid;

    pid = fork();
      50:	e8 2b 11 00 00       	call   1180 <fork>
    if(pid == -1)
      55:	83 f8 ff             	cmp    $0xffffffff,%eax
      58:	0f 84 e6 00 00 00    	je     144 <main+0x144>
        if(fork1() == 0)
      5e:	85 c0                	test   %eax,%eax
      60:	0f 84 ea 00 00 00    	je     150 <main+0x150>
        wait(0);
      66:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      6d:	e8 1e 11 00 00       	call   1190 <wait>
    while(getcmd(buf, sizeof(buf)) >= 0){
      72:	b8 64 00 00 00       	mov    $0x64,%eax
      77:	89 44 24 04          	mov    %eax,0x4(%esp)
      7b:	c7 04 24 20 1e 00 00 	movl   $0x1e20,(%esp)
      82:	e8 99 03 00 00       	call   420 <getcmd>
      87:	85 c0                	test   %eax,%eax
      89:	0f 88 a9 00 00 00    	js     138 <main+0x138>
        if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      8f:	80 3d 20 1e 00 00 63 	cmpb   $0x63,0x1e20
      96:	75 b8                	jne    50 <main+0x50>
      98:	80 3d 21 1e 00 00 64 	cmpb   $0x64,0x1e21
      9f:	75 af                	jne    50 <main+0x50>
      a1:	80 3d 22 1e 00 00 20 	cmpb   $0x20,0x1e22
      a8:	75 a6                	jne    50 <main+0x50>
            buf[strlen(buf)-1] = 0;  // chop \n
      aa:	c7 04 24 20 1e 00 00 	movl   $0x1e20,(%esp)
      b1:	e8 0a 0f 00 00       	call   fc0 <strlen>
            if(chdir(buf+3) < 0)
      b6:	c7 04 24 23 1e 00 00 	movl   $0x1e23,(%esp)
            buf[strlen(buf)-1] = 0;  // chop \n
      bd:	c6 80 1f 1e 00 00 00 	movb   $0x0,0x1e1f(%eax)
            if(chdir(buf+3) < 0)
      c4:	e8 2f 11 00 00       	call   11f8 <chdir>
      c9:	85 c0                	test   %eax,%eax
      cb:	79 a5                	jns    72 <main+0x72>
                printf(2, "cannot cd %s\n", buf+3);
      cd:	c7 44 24 08 23 1e 00 	movl   $0x1e23,0x8(%esp)
      d4:	00 
      d5:	c7 44 24 04 0c 17 00 	movl   $0x170c,0x4(%esp)
      dc:	00 
      dd:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      e4:	e8 e7 11 00 00       	call   12d0 <printf>
      e9:	eb 87                	jmp    72 <main+0x72>
            close(fd);
      eb:	89 04 24             	mov    %eax,(%esp)
      ee:	e8 bd 10 00 00       	call   11b0 <close>
            break;
      f3:	e9 3a ff ff ff       	jmp    32 <main+0x32>
        if( read(fd2, PATH, sizeof(PATH)) < 0 ){
      f8:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
      ff:	00 
     100:	c7 44 24 04 a0 1e 00 	movl   $0x1ea0,0x4(%esp)
     107:	00 
     108:	89 04 24             	mov    %eax,(%esp)
     10b:	e8 90 10 00 00       	call   11a0 <read>
     110:	85 c0                	test   %eax,%eax
     112:	0f 89 5a ff ff ff    	jns    72 <main+0x72>
            printf(1, "error: read from path file failed\n");
     118:	c7 44 24 04 4c 17 00 	movl   $0x174c,0x4(%esp)
     11f:	00 
     120:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     127:	e8 a4 11 00 00       	call   12d0 <printf>
            exit(0);
     12c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     133:	e8 50 10 00 00       	call   1188 <exit>
    exit(0);
     138:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     13f:	e8 44 10 00 00       	call   1188 <exit>
        panic("fork");
     144:	c7 04 24 88 16 00 00 	movl   $0x1688,(%esp)
     14b:	e8 30 03 00 00       	call   480 <panic>
            runcmd(parsecmd(buf));
     150:	c7 04 24 20 1e 00 00 	movl   $0x1e20,(%esp)
     157:	e8 84 0d 00 00       	call   ee0 <parsecmd>
     15c:	89 04 24             	mov    %eax,(%esp)
     15f:	e8 4c 03 00 00       	call   4b0 <runcmd>
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
     19f:	e8 1c 0e 00 00       	call   fc0 <strlen>
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

00000250 <strcpyuntildots>:
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
     266:	74 30                	je     298 <strcpyuntildots+0x48>
     268:	0f b6 0a             	movzbl (%edx),%ecx
     26b:	84 c9                	test   %cl,%cl
     26d:	88 0e                	mov    %cl,(%esi)
     26f:	74 27                	je     298 <strcpyuntildots+0x48>
     271:	89 f1                	mov    %esi,%ecx
     273:	eb 0c                	jmp    281 <strcpyuntildots+0x31>
     275:	8d 76 00             	lea    0x0(%esi),%esi
     278:	0f b6 1a             	movzbl (%edx),%ebx
     27b:	84 db                	test   %bl,%bl
     27d:	88 19                	mov    %bl,(%ecx)
     27f:	74 0b                	je     28c <strcpyuntildots+0x3c>
        s++,t++;
     281:	42                   	inc    %edx
    while((*s = *t) != delim && (*s = *t) !=0)
     282:	0f b6 1a             	movzbl (%edx),%ebx
        s++,t++;
     285:	41                   	inc    %ecx
    while((*s = *t) != delim && (*s = *t) !=0)
     286:	38 c3                	cmp    %al,%bl
     288:	88 19                	mov    %bl,(%ecx)
     28a:	75 ec                	jne    278 <strcpyuntildots+0x28>
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
    strcpy( curr_path , PATH );
     2b5:	be a0 1e 00 00       	mov    $0x1ea0,%esi
{
     2ba:	53                   	push   %ebx
     2bb:	83 ec 1c             	sub    $0x1c,%esp
    char *curr_path = malloc(strlen(PATH));
     2be:	c7 04 24 a0 1e 00 00 	movl   $0x1ea0,(%esp)
     2c5:	e8 f6 0c 00 00       	call   fc0 <strlen>
     2ca:	89 04 24             	mov    %eax,(%esp)
     2cd:	e8 8e 12 00 00       	call   1560 <malloc>
    strcpy( curr_path , PATH );
     2d2:	89 74 24 04          	mov    %esi,0x4(%esp)
    char *curr_path = malloc(strlen(PATH));
     2d6:	89 c3                	mov    %eax,%ebx
    strcpy( curr_path , PATH );
     2d8:	89 04 24             	mov    %eax,(%esp)
     2db:	e8 80 0c 00 00       	call   f60 <strcpy>
    while( curr_path != NULL )
     2e0:	85 db                	test   %ebx,%ebx
     2e2:	0f 84 1d 01 00 00    	je     405 <execWithPath+0x155>
     2e8:	90                   	nop
     2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        char* str2= malloc(100);
     2f0:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
     2f7:	e8 64 12 00 00       	call   1560 <malloc>
     2fc:	89 c6                	mov    %eax,%esi
    while((*s = *t) != delim && (*s = *t) !=0)
     2fe:	0f b6 03             	movzbl (%ebx),%eax
     301:	3c 3a                	cmp    $0x3a,%al
     303:	88 06                	mov    %al,(%esi)
     305:	0f 84 0d 01 00 00    	je     418 <execWithPath+0x168>
     30b:	0f b6 03             	movzbl (%ebx),%eax
     30e:	84 c0                	test   %al,%al
     310:	88 06                	mov    %al,(%esi)
     312:	0f 84 00 01 00 00    	je     418 <execWithPath+0x168>
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
        printf(2,"str2= %s \n",str2);
     335:	ba 48 16 00 00       	mov    $0x1648,%edx
    *s='\0';
     33a:	c6 00 00             	movb   $0x0,(%eax)
        printf(2,"str2= %s \n",str2);
     33d:	89 54 24 04          	mov    %edx,0x4(%esp)
     341:	89 74 24 08          	mov    %esi,0x8(%esp)
     345:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     34c:	e8 7f 0f 00 00       	call   12d0 <printf>
        curr_path=strchr(curr_path,':');
     351:	b9 3a 00 00 00       	mov    $0x3a,%ecx
     356:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     35a:	89 1c 24             	mov    %ebx,(%esp)
     35d:	e8 ae 0c 00 00       	call   1010 <strchr>
        char* str3=malloc ((strlen(str2) + strlen(path) - 1));
     362:	89 34 24             	mov    %esi,(%esp)
            curr_path++;
     365:	83 f8 01             	cmp    $0x1,%eax
        curr_path=strchr(curr_path,':');
     368:	89 c3                	mov    %eax,%ebx
            curr_path++;
     36a:	83 db ff             	sbb    $0xffffffff,%ebx
        char* str3=malloc ((strlen(str2) + strlen(path) - 1));
     36d:	e8 4e 0c 00 00       	call   fc0 <strlen>
     372:	89 c7                	mov    %eax,%edi
     374:	8b 45 08             	mov    0x8(%ebp),%eax
     377:	89 04 24             	mov    %eax,(%esp)
     37a:	e8 41 0c 00 00       	call   fc0 <strlen>
     37f:	8d 44 07 ff          	lea    -0x1(%edi,%eax,1),%eax
     383:	89 04 24             	mov    %eax,(%esp)
     386:	e8 d5 11 00 00       	call   1560 <malloc>
     38b:	89 f1                	mov    %esi,%ecx
     38d:	89 c7                	mov    %eax,%edi
     38f:	89 c2                	mov    %eax,%edx
     391:	eb 0d                	jmp    3a0 <execWithPath+0xf0>
     393:	90                   	nop
     394:	90                   	nop
     395:	90                   	nop
     396:	90                   	nop
     397:	90                   	nop
     398:	90                   	nop
     399:	90                   	nop
     39a:	90                   	nop
     39b:	90                   	nop
     39c:	90                   	nop
     39d:	90                   	nop
     39e:	90                   	nop
     39f:	90                   	nop
    while((*dest++ = *first++) != 0)
     3a0:	41                   	inc    %ecx
     3a1:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
     3a5:	42                   	inc    %edx
     3a6:	84 c0                	test   %al,%al
     3a8:	88 42 ff             	mov    %al,-0x1(%edx)
     3ab:	75 f3                	jne    3a0 <execWithPath+0xf0>
     3ad:	8b 4d 08             	mov    0x8(%ebp),%ecx
     3b0:	eb 07                	jmp    3b9 <execWithPath+0x109>
     3b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     3b8:	42                   	inc    %edx
    while((*dest++ = *second++) != 0)
     3b9:	41                   	inc    %ecx
     3ba:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
     3be:	84 c0                	test   %al,%al
     3c0:	88 42 ff             	mov    %al,-0x1(%edx)
     3c3:	75 f3                	jne    3b8 <execWithPath+0x108>
        printf(2,"str3= %s \n",str3);
     3c5:	b8 53 16 00 00       	mov    $0x1653,%eax
     3ca:	89 44 24 04          	mov    %eax,0x4(%esp)
     3ce:	89 7c 24 08          	mov    %edi,0x8(%esp)
     3d2:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     3d9:	e8 f2 0e 00 00       	call   12d0 <printf>
        exec( str3 , argv );
     3de:	8b 45 0c             	mov    0xc(%ebp),%eax
     3e1:	89 3c 24             	mov    %edi,(%esp)
     3e4:	89 44 24 04          	mov    %eax,0x4(%esp)
     3e8:	e8 d3 0d 00 00       	call   11c0 <exec>
        free(str2);
     3ed:	89 34 24             	mov    %esi,(%esp)
     3f0:	e8 cb 10 00 00       	call   14c0 <free>
        free(str3);
     3f5:	89 3c 24             	mov    %edi,(%esp)
     3f8:	e8 c3 10 00 00       	call   14c0 <free>
    while( curr_path != NULL )
     3fd:	85 db                	test   %ebx,%ebx
     3ff:	0f 85 eb fe ff ff    	jne    2f0 <execWithPath+0x40>
}
     405:	83 c4 1c             	add    $0x1c,%esp
     408:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     40d:	5b                   	pop    %ebx
     40e:	5e                   	pop    %esi
     40f:	5f                   	pop    %edi
     410:	5d                   	pop    %ebp
     411:	c3                   	ret    
     412:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while((*s = *t) != delim && (*s = *t) !=0)
     418:	89 f0                	mov    %esi,%eax
     41a:	e9 16 ff ff ff       	jmp    335 <execWithPath+0x85>
     41f:	90                   	nop

00000420 <getcmd>:
{
     420:	55                   	push   %ebp
    printf(2, "$ ");
     421:	b8 5e 16 00 00       	mov    $0x165e,%eax
{
     426:	89 e5                	mov    %esp,%ebp
     428:	83 ec 18             	sub    $0x18,%esp
     42b:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     42e:	8b 5d 08             	mov    0x8(%ebp),%ebx
     431:	89 75 fc             	mov    %esi,-0x4(%ebp)
     434:	8b 75 0c             	mov    0xc(%ebp),%esi
    printf(2, "$ ");
     437:	89 44 24 04          	mov    %eax,0x4(%esp)
     43b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     442:	e8 89 0e 00 00       	call   12d0 <printf>
    memset(buf, 0, nbuf);
     447:	31 d2                	xor    %edx,%edx
     449:	89 74 24 08          	mov    %esi,0x8(%esp)
     44d:	89 54 24 04          	mov    %edx,0x4(%esp)
     451:	89 1c 24             	mov    %ebx,(%esp)
     454:	e8 97 0b 00 00       	call   ff0 <memset>
    gets(buf, nbuf);
     459:	89 74 24 04          	mov    %esi,0x4(%esp)
     45d:	89 1c 24             	mov    %ebx,(%esp)
     460:	e8 db 0b 00 00       	call   1040 <gets>
    if(buf[0] == 0) // EOF
     465:	31 c0                	xor    %eax,%eax
}
     467:	8b 75 fc             	mov    -0x4(%ebp),%esi
    if(buf[0] == 0) // EOF
     46a:	80 3b 00             	cmpb   $0x0,(%ebx)
}
     46d:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    if(buf[0] == 0) // EOF
     470:	0f 94 c0             	sete   %al
}
     473:	89 ec                	mov    %ebp,%esp
    if(buf[0] == 0) // EOF
     475:	f7 d8                	neg    %eax
}
     477:	5d                   	pop    %ebp
     478:	c3                   	ret    
     479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000480 <panic>:
{
     480:	55                   	push   %ebp
     481:	89 e5                	mov    %esp,%ebp
     483:	83 ec 18             	sub    $0x18,%esp
    printf(2, "%s\n", s);
     486:	8b 45 08             	mov    0x8(%ebp),%eax
     489:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     490:	89 44 24 08          	mov    %eax,0x8(%esp)
     494:	b8 fb 16 00 00       	mov    $0x16fb,%eax
     499:	89 44 24 04          	mov    %eax,0x4(%esp)
     49d:	e8 2e 0e 00 00       	call   12d0 <printf>
    exit(0);
     4a2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     4a9:	e8 da 0c 00 00       	call   1188 <exit>
     4ae:	66 90                	xchg   %ax,%ax

000004b0 <runcmd>:
{
     4b0:	55                   	push   %ebp
     4b1:	89 e5                	mov    %esp,%ebp
     4b3:	56                   	push   %esi
     4b4:	53                   	push   %ebx
     4b5:	83 ec 20             	sub    $0x20,%esp
     4b8:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(cmd == 0)
     4bb:	85 db                	test   %ebx,%ebx
     4bd:	74 51                	je     510 <runcmd+0x60>
    switch(cmd->type){
     4bf:	83 3b 05             	cmpl   $0x5,(%ebx)
     4c2:	0f 87 4a 01 00 00    	ja     612 <runcmd+0x162>
     4c8:	8b 03                	mov    (%ebx),%eax
     4ca:	ff 24 85 1c 17 00 00 	jmp    *0x171c(,%eax,4)
            close(rcmd->fd);
     4d1:	8b 43 14             	mov    0x14(%ebx),%eax
     4d4:	89 04 24             	mov    %eax,(%esp)
     4d7:	e8 d4 0c 00 00       	call   11b0 <close>
            if(open(rcmd->file, rcmd->mode) < 0){
     4dc:	8b 43 10             	mov    0x10(%ebx),%eax
     4df:	89 44 24 04          	mov    %eax,0x4(%esp)
     4e3:	8b 43 08             	mov    0x8(%ebx),%eax
     4e6:	89 04 24             	mov    %eax,(%esp)
     4e9:	e8 da 0c 00 00       	call   11c8 <open>
     4ee:	85 c0                	test   %eax,%eax
     4f0:	79 3c                	jns    52e <runcmd+0x7e>
                printf(2, "open %s failed\n", rcmd->file);
     4f2:	8b 43 08             	mov    0x8(%ebx),%eax
     4f5:	c7 44 24 04 78 16 00 	movl   $0x1678,0x4(%esp)
     4fc:	00 
     4fd:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     504:	89 44 24 08          	mov    %eax,0x8(%esp)
     508:	e8 c3 0d 00 00       	call   12d0 <printf>
     50d:	8d 76 00             	lea    0x0(%esi),%esi
                exit(0);
     510:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     517:	e8 6c 0c 00 00       	call   1188 <exit>
    pid = fork();
     51c:	e8 5f 0c 00 00       	call   1180 <fork>
    if(pid == -1)
     521:	83 f8 ff             	cmp    $0xffffffff,%eax
     524:	0f 84 f4 00 00 00    	je     61e <runcmd+0x16e>
            if(fork1() == 0)
     52a:	85 c0                	test   %eax,%eax
     52c:	75 e2                	jne    510 <runcmd+0x60>
                runcmd(bcmd->cmd);
     52e:	8b 43 04             	mov    0x4(%ebx),%eax
     531:	89 04 24             	mov    %eax,(%esp)
     534:	e8 77 ff ff ff       	call   4b0 <runcmd>
            if(ecmd->argv[0] == 0)
     539:	8b 43 04             	mov    0x4(%ebx),%eax
     53c:	85 c0                	test   %eax,%eax
     53e:	74 d0                	je     510 <runcmd+0x60>
            exec(ecmd->argv[0], ecmd->argv);
     540:	8d 73 04             	lea    0x4(%ebx),%esi
     543:	89 74 24 04          	mov    %esi,0x4(%esp)
     547:	89 04 24             	mov    %eax,(%esp)
     54a:	e8 71 0c 00 00       	call   11c0 <exec>
            execWithPath(ecmd->argv[0], ecmd->argv);
     54f:	89 74 24 04          	mov    %esi,0x4(%esp)
     553:	8b 43 04             	mov    0x4(%ebx),%eax
     556:	89 04 24             	mov    %eax,(%esp)
     559:	e8 52 fd ff ff       	call   2b0 <execWithPath>
            printf(2, "exec %s failed\n", ecmd->argv[0]);
     55e:	8b 43 04             	mov    0x4(%ebx),%eax
     561:	c7 44 24 04 68 16 00 	movl   $0x1668,0x4(%esp)
     568:	00 
     569:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     570:	89 44 24 08          	mov    %eax,0x8(%esp)
     574:	e8 57 0d 00 00       	call   12d0 <printf>
            break;
     579:	eb 95                	jmp    510 <runcmd+0x60>
            if(pipe(p) < 0)
     57b:	8d 45 f0             	lea    -0x10(%ebp),%eax
     57e:	89 04 24             	mov    %eax,(%esp)
     581:	e8 12 0c 00 00       	call   1198 <pipe>
     586:	85 c0                	test   %eax,%eax
     588:	0f 88 d4 00 00 00    	js     662 <runcmd+0x1b2>
    pid = fork();
     58e:	e8 ed 0b 00 00       	call   1180 <fork>
    if(pid == -1)
     593:	83 f8 ff             	cmp    $0xffffffff,%eax
     596:	0f 84 82 00 00 00    	je     61e <runcmd+0x16e>
            if(fork1() == 0){
     59c:	85 c0                	test   %eax,%eax
     59e:	66 90                	xchg   %ax,%ax
     5a0:	0f 84 c8 00 00 00    	je     66e <runcmd+0x1be>
    pid = fork();
     5a6:	e8 d5 0b 00 00       	call   1180 <fork>
    if(pid == -1)
     5ab:	83 f8 ff             	cmp    $0xffffffff,%eax
     5ae:	66 90                	xchg   %ax,%ax
     5b0:	74 6c                	je     61e <runcmd+0x16e>
            if(fork1() == 0){
     5b2:	85 c0                	test   %eax,%eax
     5b4:	74 74                	je     62a <runcmd+0x17a>
            close(p[0]);
     5b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5b9:	89 04 24             	mov    %eax,(%esp)
     5bc:	e8 ef 0b 00 00       	call   11b0 <close>
            close(p[1]);
     5c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5c4:	89 04 24             	mov    %eax,(%esp)
     5c7:	e8 e4 0b 00 00       	call   11b0 <close>
            wait(0);
     5cc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     5d3:	e8 b8 0b 00 00       	call   1190 <wait>
            wait(0);
     5d8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     5df:	e8 ac 0b 00 00       	call   1190 <wait>
            break;
     5e4:	e9 27 ff ff ff       	jmp    510 <runcmd+0x60>
    pid = fork();
     5e9:	e8 92 0b 00 00       	call   1180 <fork>
    if(pid == -1)
     5ee:	83 f8 ff             	cmp    $0xffffffff,%eax
     5f1:	74 2b                	je     61e <runcmd+0x16e>
            if(fork1() == 0)
     5f3:	85 c0                	test   %eax,%eax
     5f5:	0f 84 33 ff ff ff    	je     52e <runcmd+0x7e>
            wait(0);
     5fb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     602:	e8 89 0b 00 00       	call   1190 <wait>
            runcmd(lcmd->right);
     607:	8b 43 08             	mov    0x8(%ebx),%eax
     60a:	89 04 24             	mov    %eax,(%esp)
     60d:	e8 9e fe ff ff       	call   4b0 <runcmd>
            panic("runcmd");
     612:	c7 04 24 61 16 00 00 	movl   $0x1661,(%esp)
     619:	e8 62 fe ff ff       	call   480 <panic>
        panic("fork");
     61e:	c7 04 24 88 16 00 00 	movl   $0x1688,(%esp)
     625:	e8 56 fe ff ff       	call   480 <panic>
                close(0);
     62a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     631:	e8 7a 0b 00 00       	call   11b0 <close>
                dup(p[0]);
     636:	8b 45 f0             	mov    -0x10(%ebp),%eax
     639:	89 04 24             	mov    %eax,(%esp)
     63c:	e8 bf 0b 00 00       	call   1200 <dup>
                close(p[0]);
     641:	8b 45 f0             	mov    -0x10(%ebp),%eax
     644:	89 04 24             	mov    %eax,(%esp)
     647:	e8 64 0b 00 00       	call   11b0 <close>
                close(p[1]);
     64c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     64f:	89 04 24             	mov    %eax,(%esp)
     652:	e8 59 0b 00 00       	call   11b0 <close>
                runcmd(pcmd->right);
     657:	8b 43 08             	mov    0x8(%ebx),%eax
     65a:	89 04 24             	mov    %eax,(%esp)
     65d:	e8 4e fe ff ff       	call   4b0 <runcmd>
                panic("pipe");
     662:	c7 04 24 8d 16 00 00 	movl   $0x168d,(%esp)
     669:	e8 12 fe ff ff       	call   480 <panic>
                close(1);
     66e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     675:	e8 36 0b 00 00       	call   11b0 <close>
                dup(p[1]);
     67a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     67d:	89 04 24             	mov    %eax,(%esp)
     680:	e8 7b 0b 00 00       	call   1200 <dup>
                close(p[0]);
     685:	8b 45 f0             	mov    -0x10(%ebp),%eax
     688:	89 04 24             	mov    %eax,(%esp)
     68b:	e8 20 0b 00 00       	call   11b0 <close>
                close(p[1]);
     690:	8b 45 f4             	mov    -0xc(%ebp),%eax
     693:	89 04 24             	mov    %eax,(%esp)
     696:	e8 15 0b 00 00       	call   11b0 <close>
                runcmd(pcmd->left);
     69b:	8b 43 04             	mov    0x4(%ebx),%eax
     69e:	89 04 24             	mov    %eax,(%esp)
     6a1:	e8 0a fe ff ff       	call   4b0 <runcmd>
     6a6:	8d 76 00             	lea    0x0(%esi),%esi
     6a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006b0 <fork1>:
{
     6b0:	55                   	push   %ebp
     6b1:	89 e5                	mov    %esp,%ebp
     6b3:	83 ec 18             	sub    $0x18,%esp
    pid = fork();
     6b6:	e8 c5 0a 00 00       	call   1180 <fork>
    if(pid == -1)
     6bb:	83 f8 ff             	cmp    $0xffffffff,%eax
     6be:	74 02                	je     6c2 <fork1+0x12>
    return pid;
}
     6c0:	c9                   	leave  
     6c1:	c3                   	ret    
        panic("fork");
     6c2:	c7 04 24 88 16 00 00 	movl   $0x1688,(%esp)
     6c9:	e8 b2 fd ff ff       	call   480 <panic>
     6ce:	66 90                	xchg   %ax,%ax

000006d0 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     6d0:	55                   	push   %ebp
     6d1:	89 e5                	mov    %esp,%ebp
     6d3:	53                   	push   %ebx
     6d4:	83 ec 14             	sub    $0x14,%esp
    struct execcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     6d7:	c7 04 24 54 00 00 00 	movl   $0x54,(%esp)
     6de:	e8 7d 0e 00 00       	call   1560 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     6e3:	31 d2                	xor    %edx,%edx
     6e5:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     6e9:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     6eb:	b8 54 00 00 00       	mov    $0x54,%eax
     6f0:	89 1c 24             	mov    %ebx,(%esp)
     6f3:	89 44 24 08          	mov    %eax,0x8(%esp)
     6f7:	e8 f4 08 00 00       	call   ff0 <memset>
    cmd->type = EXEC;
    return (struct cmd*)cmd;
}
     6fc:	89 d8                	mov    %ebx,%eax
    cmd->type = EXEC;
     6fe:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
}
     704:	83 c4 14             	add    $0x14,%esp
     707:	5b                   	pop    %ebx
     708:	5d                   	pop    %ebp
     709:	c3                   	ret    
     70a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000710 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     710:	55                   	push   %ebp
     711:	89 e5                	mov    %esp,%ebp
     713:	53                   	push   %ebx
     714:	83 ec 14             	sub    $0x14,%esp
    struct redircmd *cmd;

    cmd = malloc(sizeof(*cmd));
     717:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
     71e:	e8 3d 0e 00 00       	call   1560 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     723:	31 d2                	xor    %edx,%edx
     725:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     729:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     72b:	b8 18 00 00 00       	mov    $0x18,%eax
     730:	89 1c 24             	mov    %ebx,(%esp)
     733:	89 44 24 08          	mov    %eax,0x8(%esp)
     737:	e8 b4 08 00 00       	call   ff0 <memset>
    cmd->type = REDIR;
    cmd->cmd = subcmd;
     73c:	8b 45 08             	mov    0x8(%ebp),%eax
    cmd->type = REDIR;
     73f:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
    cmd->cmd = subcmd;
     745:	89 43 04             	mov    %eax,0x4(%ebx)
    cmd->file = file;
     748:	8b 45 0c             	mov    0xc(%ebp),%eax
     74b:	89 43 08             	mov    %eax,0x8(%ebx)
    cmd->efile = efile;
     74e:	8b 45 10             	mov    0x10(%ebp),%eax
     751:	89 43 0c             	mov    %eax,0xc(%ebx)
    cmd->mode = mode;
     754:	8b 45 14             	mov    0x14(%ebp),%eax
     757:	89 43 10             	mov    %eax,0x10(%ebx)
    cmd->fd = fd;
     75a:	8b 45 18             	mov    0x18(%ebp),%eax
     75d:	89 43 14             	mov    %eax,0x14(%ebx)
    return (struct cmd*)cmd;
}
     760:	83 c4 14             	add    $0x14,%esp
     763:	89 d8                	mov    %ebx,%eax
     765:	5b                   	pop    %ebx
     766:	5d                   	pop    %ebp
     767:	c3                   	ret    
     768:	90                   	nop
     769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000770 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     770:	55                   	push   %ebp
     771:	89 e5                	mov    %esp,%ebp
     773:	53                   	push   %ebx
     774:	83 ec 14             	sub    $0x14,%esp
    struct pipecmd *cmd;

    cmd = malloc(sizeof(*cmd));
     777:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     77e:	e8 dd 0d 00 00       	call   1560 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     783:	31 d2                	xor    %edx,%edx
     785:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     789:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     78b:	b8 0c 00 00 00       	mov    $0xc,%eax
     790:	89 1c 24             	mov    %ebx,(%esp)
     793:	89 44 24 08          	mov    %eax,0x8(%esp)
     797:	e8 54 08 00 00       	call   ff0 <memset>
    cmd->type = PIPE;
    cmd->left = left;
     79c:	8b 45 08             	mov    0x8(%ebp),%eax
    cmd->type = PIPE;
     79f:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
    cmd->left = left;
     7a5:	89 43 04             	mov    %eax,0x4(%ebx)
    cmd->right = right;
     7a8:	8b 45 0c             	mov    0xc(%ebp),%eax
     7ab:	89 43 08             	mov    %eax,0x8(%ebx)
    return (struct cmd*)cmd;
}
     7ae:	83 c4 14             	add    $0x14,%esp
     7b1:	89 d8                	mov    %ebx,%eax
     7b3:	5b                   	pop    %ebx
     7b4:	5d                   	pop    %ebp
     7b5:	c3                   	ret    
     7b6:	8d 76 00             	lea    0x0(%esi),%esi
     7b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000007c0 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     7c0:	55                   	push   %ebp
     7c1:	89 e5                	mov    %esp,%ebp
     7c3:	53                   	push   %ebx
     7c4:	83 ec 14             	sub    $0x14,%esp
    struct listcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     7c7:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     7ce:	e8 8d 0d 00 00       	call   1560 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     7d3:	31 d2                	xor    %edx,%edx
     7d5:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     7d9:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     7db:	b8 0c 00 00 00       	mov    $0xc,%eax
     7e0:	89 1c 24             	mov    %ebx,(%esp)
     7e3:	89 44 24 08          	mov    %eax,0x8(%esp)
     7e7:	e8 04 08 00 00       	call   ff0 <memset>
    cmd->type = LIST;
    cmd->left = left;
     7ec:	8b 45 08             	mov    0x8(%ebp),%eax
    cmd->type = LIST;
     7ef:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
    cmd->left = left;
     7f5:	89 43 04             	mov    %eax,0x4(%ebx)
    cmd->right = right;
     7f8:	8b 45 0c             	mov    0xc(%ebp),%eax
     7fb:	89 43 08             	mov    %eax,0x8(%ebx)
    return (struct cmd*)cmd;
}
     7fe:	83 c4 14             	add    $0x14,%esp
     801:	89 d8                	mov    %ebx,%eax
     803:	5b                   	pop    %ebx
     804:	5d                   	pop    %ebp
     805:	c3                   	ret    
     806:	8d 76 00             	lea    0x0(%esi),%esi
     809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000810 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     810:	55                   	push   %ebp
     811:	89 e5                	mov    %esp,%ebp
     813:	53                   	push   %ebx
     814:	83 ec 14             	sub    $0x14,%esp
    struct backcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     817:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     81e:	e8 3d 0d 00 00       	call   1560 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     823:	31 d2                	xor    %edx,%edx
     825:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     829:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     82b:	b8 08 00 00 00       	mov    $0x8,%eax
     830:	89 1c 24             	mov    %ebx,(%esp)
     833:	89 44 24 08          	mov    %eax,0x8(%esp)
     837:	e8 b4 07 00 00       	call   ff0 <memset>
    cmd->type = BACK;
    cmd->cmd = subcmd;
     83c:	8b 45 08             	mov    0x8(%ebp),%eax
    cmd->type = BACK;
     83f:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
    cmd->cmd = subcmd;
     845:	89 43 04             	mov    %eax,0x4(%ebx)
    return (struct cmd*)cmd;
}
     848:	83 c4 14             	add    $0x14,%esp
     84b:	89 d8                	mov    %ebx,%eax
     84d:	5b                   	pop    %ebx
     84e:	5d                   	pop    %ebp
     84f:	c3                   	ret    

00000850 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     850:	55                   	push   %ebp
     851:	89 e5                	mov    %esp,%ebp
     853:	57                   	push   %edi
     854:	56                   	push   %esi
     855:	53                   	push   %ebx
     856:	83 ec 1c             	sub    $0x1c,%esp
    char *s;
    int ret;

    s = *ps;
     859:	8b 45 08             	mov    0x8(%ebp),%eax
{
     85c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     85f:	8b 7d 10             	mov    0x10(%ebp),%edi
    s = *ps;
     862:	8b 30                	mov    (%eax),%esi
    while(s < es && strchr(whitespace, *s))
     864:	39 de                	cmp    %ebx,%esi
     866:	72 0d                	jb     875 <gettoken+0x25>
     868:	eb 22                	jmp    88c <gettoken+0x3c>
     86a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s++;
     870:	46                   	inc    %esi
    while(s < es && strchr(whitespace, *s))
     871:	39 f3                	cmp    %esi,%ebx
     873:	74 17                	je     88c <gettoken+0x3c>
     875:	0f be 06             	movsbl (%esi),%eax
     878:	c7 04 24 10 1e 00 00 	movl   $0x1e10,(%esp)
     87f:	89 44 24 04          	mov    %eax,0x4(%esp)
     883:	e8 88 07 00 00       	call   1010 <strchr>
     888:	85 c0                	test   %eax,%eax
     88a:	75 e4                	jne    870 <gettoken+0x20>
    if(q)
     88c:	85 ff                	test   %edi,%edi
     88e:	74 02                	je     892 <gettoken+0x42>
        *q = s;
     890:	89 37                	mov    %esi,(%edi)
    ret = *s;
     892:	0f be 06             	movsbl (%esi),%eax
    switch(*s){
     895:	3c 29                	cmp    $0x29,%al
     897:	7f 57                	jg     8f0 <gettoken+0xa0>
     899:	3c 28                	cmp    $0x28,%al
     89b:	0f 8d cb 00 00 00    	jge    96c <gettoken+0x11c>
     8a1:	31 ff                	xor    %edi,%edi
     8a3:	84 c0                	test   %al,%al
     8a5:	0f 85 cd 00 00 00    	jne    978 <gettoken+0x128>
            ret = 'a';
            while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
                s++;
            break;
    }
    if(eq)
     8ab:	8b 55 14             	mov    0x14(%ebp),%edx
     8ae:	85 d2                	test   %edx,%edx
     8b0:	74 05                	je     8b7 <gettoken+0x67>
        *eq = s;
     8b2:	8b 45 14             	mov    0x14(%ebp),%eax
     8b5:	89 30                	mov    %esi,(%eax)

    while(s < es && strchr(whitespace, *s))
     8b7:	39 de                	cmp    %ebx,%esi
     8b9:	72 0a                	jb     8c5 <gettoken+0x75>
     8bb:	eb 1f                	jmp    8dc <gettoken+0x8c>
     8bd:	8d 76 00             	lea    0x0(%esi),%esi
        s++;
     8c0:	46                   	inc    %esi
    while(s < es && strchr(whitespace, *s))
     8c1:	39 f3                	cmp    %esi,%ebx
     8c3:	74 17                	je     8dc <gettoken+0x8c>
     8c5:	0f be 06             	movsbl (%esi),%eax
     8c8:	c7 04 24 10 1e 00 00 	movl   $0x1e10,(%esp)
     8cf:	89 44 24 04          	mov    %eax,0x4(%esp)
     8d3:	e8 38 07 00 00       	call   1010 <strchr>
     8d8:	85 c0                	test   %eax,%eax
     8da:	75 e4                	jne    8c0 <gettoken+0x70>
    *ps = s;
     8dc:	8b 45 08             	mov    0x8(%ebp),%eax
     8df:	89 30                	mov    %esi,(%eax)
    return ret;
}
     8e1:	83 c4 1c             	add    $0x1c,%esp
     8e4:	89 f8                	mov    %edi,%eax
     8e6:	5b                   	pop    %ebx
     8e7:	5e                   	pop    %esi
     8e8:	5f                   	pop    %edi
     8e9:	5d                   	pop    %ebp
     8ea:	c3                   	ret    
     8eb:	90                   	nop
     8ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(*s){
     8f0:	3c 3e                	cmp    $0x3e,%al
     8f2:	75 1c                	jne    910 <gettoken+0xc0>
            if(*s == '>'){
     8f4:	80 7e 01 3e          	cmpb   $0x3e,0x1(%esi)
            s++;
     8f8:	8d 46 01             	lea    0x1(%esi),%eax
            if(*s == '>'){
     8fb:	0f 84 94 00 00 00    	je     995 <gettoken+0x145>
            s++;
     901:	89 c6                	mov    %eax,%esi
     903:	bf 3e 00 00 00       	mov    $0x3e,%edi
     908:	eb a1                	jmp    8ab <gettoken+0x5b>
     90a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(*s){
     910:	7f 56                	jg     968 <gettoken+0x118>
     912:	88 c1                	mov    %al,%cl
     914:	80 e9 3b             	sub    $0x3b,%cl
     917:	80 f9 01             	cmp    $0x1,%cl
     91a:	76 50                	jbe    96c <gettoken+0x11c>
            while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     91c:	39 f3                	cmp    %esi,%ebx
     91e:	77 27                	ja     947 <gettoken+0xf7>
     920:	eb 5e                	jmp    980 <gettoken+0x130>
     922:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     928:	0f be 06             	movsbl (%esi),%eax
     92b:	c7 04 24 08 1e 00 00 	movl   $0x1e08,(%esp)
     932:	89 44 24 04          	mov    %eax,0x4(%esp)
     936:	e8 d5 06 00 00       	call   1010 <strchr>
     93b:	85 c0                	test   %eax,%eax
     93d:	75 1c                	jne    95b <gettoken+0x10b>
                s++;
     93f:	46                   	inc    %esi
            while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     940:	39 f3                	cmp    %esi,%ebx
     942:	74 3c                	je     980 <gettoken+0x130>
     944:	0f be 06             	movsbl (%esi),%eax
     947:	89 44 24 04          	mov    %eax,0x4(%esp)
     94b:	c7 04 24 10 1e 00 00 	movl   $0x1e10,(%esp)
     952:	e8 b9 06 00 00       	call   1010 <strchr>
     957:	85 c0                	test   %eax,%eax
     959:	74 cd                	je     928 <gettoken+0xd8>
            ret = 'a';
     95b:	bf 61 00 00 00       	mov    $0x61,%edi
     960:	e9 46 ff ff ff       	jmp    8ab <gettoken+0x5b>
     965:	8d 76 00             	lea    0x0(%esi),%esi
    switch(*s){
     968:	3c 7c                	cmp    $0x7c,%al
     96a:	75 b0                	jne    91c <gettoken+0xcc>
    ret = *s;
     96c:	0f be f8             	movsbl %al,%edi
            s++;
     96f:	46                   	inc    %esi
            break;
     970:	e9 36 ff ff ff       	jmp    8ab <gettoken+0x5b>
     975:	8d 76 00             	lea    0x0(%esi),%esi
    switch(*s){
     978:	3c 26                	cmp    $0x26,%al
     97a:	75 a0                	jne    91c <gettoken+0xcc>
     97c:	eb ee                	jmp    96c <gettoken+0x11c>
     97e:	66 90                	xchg   %ax,%ax
    if(eq)
     980:	8b 45 14             	mov    0x14(%ebp),%eax
     983:	bf 61 00 00 00       	mov    $0x61,%edi
     988:	85 c0                	test   %eax,%eax
     98a:	0f 85 22 ff ff ff    	jne    8b2 <gettoken+0x62>
     990:	e9 47 ff ff ff       	jmp    8dc <gettoken+0x8c>
                s++;
     995:	83 c6 02             	add    $0x2,%esi
                ret = '+';
     998:	bf 2b 00 00 00       	mov    $0x2b,%edi
     99d:	e9 09 ff ff ff       	jmp    8ab <gettoken+0x5b>
     9a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     9a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009b0 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     9b0:	55                   	push   %ebp
     9b1:	89 e5                	mov    %esp,%ebp
     9b3:	57                   	push   %edi
     9b4:	56                   	push   %esi
     9b5:	53                   	push   %ebx
     9b6:	83 ec 1c             	sub    $0x1c,%esp
     9b9:	8b 7d 08             	mov    0x8(%ebp),%edi
     9bc:	8b 75 0c             	mov    0xc(%ebp),%esi
    char *s;

    s = *ps;
     9bf:	8b 1f                	mov    (%edi),%ebx
    while(s < es && strchr(whitespace, *s))
     9c1:	39 f3                	cmp    %esi,%ebx
     9c3:	72 10                	jb     9d5 <peek+0x25>
     9c5:	eb 25                	jmp    9ec <peek+0x3c>
     9c7:	89 f6                	mov    %esi,%esi
     9c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s++;
     9d0:	43                   	inc    %ebx
    while(s < es && strchr(whitespace, *s))
     9d1:	39 de                	cmp    %ebx,%esi
     9d3:	74 17                	je     9ec <peek+0x3c>
     9d5:	0f be 03             	movsbl (%ebx),%eax
     9d8:	c7 04 24 10 1e 00 00 	movl   $0x1e10,(%esp)
     9df:	89 44 24 04          	mov    %eax,0x4(%esp)
     9e3:	e8 28 06 00 00       	call   1010 <strchr>
     9e8:	85 c0                	test   %eax,%eax
     9ea:	75 e4                	jne    9d0 <peek+0x20>
    *ps = s;
     9ec:	89 1f                	mov    %ebx,(%edi)
    return *s && strchr(toks, *s);
     9ee:	31 c0                	xor    %eax,%eax
     9f0:	0f be 13             	movsbl (%ebx),%edx
     9f3:	84 d2                	test   %dl,%dl
     9f5:	74 17                	je     a0e <peek+0x5e>
     9f7:	8b 45 10             	mov    0x10(%ebp),%eax
     9fa:	89 54 24 04          	mov    %edx,0x4(%esp)
     9fe:	89 04 24             	mov    %eax,(%esp)
     a01:	e8 0a 06 00 00       	call   1010 <strchr>
     a06:	85 c0                	test   %eax,%eax
     a08:	0f 95 c0             	setne  %al
     a0b:	0f b6 c0             	movzbl %al,%eax
}
     a0e:	83 c4 1c             	add    $0x1c,%esp
     a11:	5b                   	pop    %ebx
     a12:	5e                   	pop    %esi
     a13:	5f                   	pop    %edi
     a14:	5d                   	pop    %ebp
     a15:	c3                   	ret    
     a16:	8d 76 00             	lea    0x0(%esi),%esi
     a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a20 <parseredirs>:
    return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     a20:	55                   	push   %ebp
     a21:	89 e5                	mov    %esp,%ebp
     a23:	57                   	push   %edi
     a24:	56                   	push   %esi
     a25:	53                   	push   %ebx
     a26:	83 ec 3c             	sub    $0x3c,%esp
     a29:	8b 75 0c             	mov    0xc(%ebp),%esi
     a2c:	8b 5d 10             	mov    0x10(%ebp),%ebx
     a2f:	90                   	nop
    int tok;
    char *q, *eq;

    while(peek(ps, es, "<>")){
     a30:	b8 af 16 00 00       	mov    $0x16af,%eax
     a35:	89 44 24 08          	mov    %eax,0x8(%esp)
     a39:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     a3d:	89 34 24             	mov    %esi,(%esp)
     a40:	e8 6b ff ff ff       	call   9b0 <peek>
     a45:	85 c0                	test   %eax,%eax
     a47:	0f 84 93 00 00 00    	je     ae0 <parseredirs+0xc0>
        tok = gettoken(ps, es, 0, 0);
     a4d:	31 c0                	xor    %eax,%eax
     a4f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     a53:	31 c0                	xor    %eax,%eax
     a55:	89 44 24 08          	mov    %eax,0x8(%esp)
     a59:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     a5d:	89 34 24             	mov    %esi,(%esp)
     a60:	e8 eb fd ff ff       	call   850 <gettoken>
        if(gettoken(ps, es, &q, &eq) != 'a')
     a65:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     a69:	89 34 24             	mov    %esi,(%esp)
        tok = gettoken(ps, es, 0, 0);
     a6c:	89 c7                	mov    %eax,%edi
        if(gettoken(ps, es, &q, &eq) != 'a')
     a6e:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     a71:	89 44 24 0c          	mov    %eax,0xc(%esp)
     a75:	8d 45 e0             	lea    -0x20(%ebp),%eax
     a78:	89 44 24 08          	mov    %eax,0x8(%esp)
     a7c:	e8 cf fd ff ff       	call   850 <gettoken>
     a81:	83 f8 61             	cmp    $0x61,%eax
     a84:	75 65                	jne    aeb <parseredirs+0xcb>
            panic("missing file for redirection");
        switch(tok){
     a86:	83 ff 3c             	cmp    $0x3c,%edi
     a89:	74 45                	je     ad0 <parseredirs+0xb0>
     a8b:	83 ff 3e             	cmp    $0x3e,%edi
     a8e:	66 90                	xchg   %ax,%ax
     a90:	74 05                	je     a97 <parseredirs+0x77>
     a92:	83 ff 2b             	cmp    $0x2b,%edi
     a95:	75 99                	jne    a30 <parseredirs+0x10>
                break;
            case '>':
                cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
                break;
            case '+':  // >>
                cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     a97:	ba 01 00 00 00       	mov    $0x1,%edx
     a9c:	b9 01 02 00 00       	mov    $0x201,%ecx
     aa1:	89 54 24 10          	mov    %edx,0x10(%esp)
     aa5:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
     aa9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     aac:	89 44 24 08          	mov    %eax,0x8(%esp)
     ab0:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ab3:	89 44 24 04          	mov    %eax,0x4(%esp)
     ab7:	8b 45 08             	mov    0x8(%ebp),%eax
     aba:	89 04 24             	mov    %eax,(%esp)
     abd:	e8 4e fc ff ff       	call   710 <redircmd>
     ac2:	89 45 08             	mov    %eax,0x8(%ebp)
                break;
     ac5:	e9 66 ff ff ff       	jmp    a30 <parseredirs+0x10>
     aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     ad0:	31 ff                	xor    %edi,%edi
     ad2:	31 c0                	xor    %eax,%eax
     ad4:	89 7c 24 10          	mov    %edi,0x10(%esp)
     ad8:	89 44 24 0c          	mov    %eax,0xc(%esp)
     adc:	eb cb                	jmp    aa9 <parseredirs+0x89>
     ade:	66 90                	xchg   %ax,%ax
        }
    }
    return cmd;
}
     ae0:	8b 45 08             	mov    0x8(%ebp),%eax
     ae3:	83 c4 3c             	add    $0x3c,%esp
     ae6:	5b                   	pop    %ebx
     ae7:	5e                   	pop    %esi
     ae8:	5f                   	pop    %edi
     ae9:	5d                   	pop    %ebp
     aea:	c3                   	ret    
            panic("missing file for redirection");
     aeb:	c7 04 24 92 16 00 00 	movl   $0x1692,(%esp)
     af2:	e8 89 f9 ff ff       	call   480 <panic>
     af7:	89 f6                	mov    %esi,%esi
     af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b00 <parseexec>:
    return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     b00:	55                   	push   %ebp
    char *q, *eq;
    int tok, argc;
    struct execcmd *cmd;
    struct cmd *ret;

    if(peek(ps, es, "("))
     b01:	ba b2 16 00 00       	mov    $0x16b2,%edx
{
     b06:	89 e5                	mov    %esp,%ebp
     b08:	57                   	push   %edi
     b09:	56                   	push   %esi
     b0a:	53                   	push   %ebx
     b0b:	83 ec 3c             	sub    $0x3c,%esp
     b0e:	8b 75 08             	mov    0x8(%ebp),%esi
     b11:	8b 7d 0c             	mov    0xc(%ebp),%edi
    if(peek(ps, es, "("))
     b14:	89 54 24 08          	mov    %edx,0x8(%esp)
     b18:	89 34 24             	mov    %esi,(%esp)
     b1b:	89 7c 24 04          	mov    %edi,0x4(%esp)
     b1f:	e8 8c fe ff ff       	call   9b0 <peek>
     b24:	85 c0                	test   %eax,%eax
     b26:	0f 85 9c 00 00 00    	jne    bc8 <parseexec+0xc8>
     b2c:	89 c3                	mov    %eax,%ebx
        return parseblock(ps, es);

    ret = execcmd();
     b2e:	e8 9d fb ff ff       	call   6d0 <execcmd>
    cmd = (struct execcmd*)ret;

    argc = 0;
    ret = parseredirs(ret, ps, es);
     b33:	89 7c 24 08          	mov    %edi,0x8(%esp)
     b37:	89 74 24 04          	mov    %esi,0x4(%esp)
     b3b:	89 04 24             	mov    %eax,(%esp)
    ret = execcmd();
     b3e:	89 45 d0             	mov    %eax,-0x30(%ebp)
    ret = parseredirs(ret, ps, es);
     b41:	e8 da fe ff ff       	call   a20 <parseredirs>
     b46:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     b49:	eb 1b                	jmp    b66 <parseexec+0x66>
     b4b:	90                   	nop
     b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cmd->argv[argc] = q;
        cmd->eargv[argc] = eq;
        argc++;
        if(argc >= MAXARGS)
            panic("too many args");
        ret = parseredirs(ret, ps, es);
     b50:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     b53:	89 7c 24 08          	mov    %edi,0x8(%esp)
     b57:	89 74 24 04          	mov    %esi,0x4(%esp)
     b5b:	89 04 24             	mov    %eax,(%esp)
     b5e:	e8 bd fe ff ff       	call   a20 <parseredirs>
     b63:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while(!peek(ps, es, "|)&;")){
     b66:	b8 c9 16 00 00       	mov    $0x16c9,%eax
     b6b:	89 44 24 08          	mov    %eax,0x8(%esp)
     b6f:	89 7c 24 04          	mov    %edi,0x4(%esp)
     b73:	89 34 24             	mov    %esi,(%esp)
     b76:	e8 35 fe ff ff       	call   9b0 <peek>
     b7b:	85 c0                	test   %eax,%eax
     b7d:	75 69                	jne    be8 <parseexec+0xe8>
        if((tok=gettoken(ps, es, &q, &eq)) == 0)
     b7f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     b82:	89 44 24 0c          	mov    %eax,0xc(%esp)
     b86:	8d 45 e0             	lea    -0x20(%ebp),%eax
     b89:	89 44 24 08          	mov    %eax,0x8(%esp)
     b8d:	89 7c 24 04          	mov    %edi,0x4(%esp)
     b91:	89 34 24             	mov    %esi,(%esp)
     b94:	e8 b7 fc ff ff       	call   850 <gettoken>
     b99:	85 c0                	test   %eax,%eax
     b9b:	74 4b                	je     be8 <parseexec+0xe8>
        if(tok != 'a')
     b9d:	83 f8 61             	cmp    $0x61,%eax
     ba0:	75 65                	jne    c07 <parseexec+0x107>
        cmd->argv[argc] = q;
     ba2:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ba5:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ba8:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
        cmd->eargv[argc] = eq;
     bac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     baf:	89 44 9a 2c          	mov    %eax,0x2c(%edx,%ebx,4)
        argc++;
     bb3:	43                   	inc    %ebx
        if(argc >= MAXARGS)
     bb4:	83 fb 0a             	cmp    $0xa,%ebx
     bb7:	75 97                	jne    b50 <parseexec+0x50>
            panic("too many args");
     bb9:	c7 04 24 bb 16 00 00 	movl   $0x16bb,(%esp)
     bc0:	e8 bb f8 ff ff       	call   480 <panic>
     bc5:	8d 76 00             	lea    0x0(%esi),%esi
        return parseblock(ps, es);
     bc8:	89 7c 24 04          	mov    %edi,0x4(%esp)
     bcc:	89 34 24             	mov    %esi,(%esp)
     bcf:	e8 9c 01 00 00       	call   d70 <parseblock>
     bd4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    }
    cmd->argv[argc] = 0;
    cmd->eargv[argc] = 0;
    return ret;
}
     bd7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     bda:	83 c4 3c             	add    $0x3c,%esp
     bdd:	5b                   	pop    %ebx
     bde:	5e                   	pop    %esi
     bdf:	5f                   	pop    %edi
     be0:	5d                   	pop    %ebp
     be1:	c3                   	ret    
     be2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     be8:	8b 45 d0             	mov    -0x30(%ebp),%eax
     beb:	8d 04 98             	lea    (%eax,%ebx,4),%eax
    cmd->argv[argc] = 0;
     bee:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    cmd->eargv[argc] = 0;
     bf5:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
}
     bfc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     bff:	83 c4 3c             	add    $0x3c,%esp
     c02:	5b                   	pop    %ebx
     c03:	5e                   	pop    %esi
     c04:	5f                   	pop    %edi
     c05:	5d                   	pop    %ebp
     c06:	c3                   	ret    
            panic("syntax");
     c07:	c7 04 24 b4 16 00 00 	movl   $0x16b4,(%esp)
     c0e:	e8 6d f8 ff ff       	call   480 <panic>
     c13:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c20 <parsepipe>:
{
     c20:	55                   	push   %ebp
     c21:	89 e5                	mov    %esp,%ebp
     c23:	83 ec 28             	sub    $0x28,%esp
     c26:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     c29:	8b 5d 08             	mov    0x8(%ebp),%ebx
     c2c:	89 75 f8             	mov    %esi,-0x8(%ebp)
     c2f:	8b 75 0c             	mov    0xc(%ebp),%esi
     c32:	89 7d fc             	mov    %edi,-0x4(%ebp)
    cmd = parseexec(ps, es);
     c35:	89 1c 24             	mov    %ebx,(%esp)
     c38:	89 74 24 04          	mov    %esi,0x4(%esp)
     c3c:	e8 bf fe ff ff       	call   b00 <parseexec>
    if(peek(ps, es, "|")){
     c41:	b9 ce 16 00 00       	mov    $0x16ce,%ecx
     c46:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     c4a:	89 74 24 04          	mov    %esi,0x4(%esp)
     c4e:	89 1c 24             	mov    %ebx,(%esp)
    cmd = parseexec(ps, es);
     c51:	89 c7                	mov    %eax,%edi
    if(peek(ps, es, "|")){
     c53:	e8 58 fd ff ff       	call   9b0 <peek>
     c58:	85 c0                	test   %eax,%eax
     c5a:	75 14                	jne    c70 <parsepipe+0x50>
}
     c5c:	89 f8                	mov    %edi,%eax
     c5e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     c61:	8b 75 f8             	mov    -0x8(%ebp),%esi
     c64:	8b 7d fc             	mov    -0x4(%ebp),%edi
     c67:	89 ec                	mov    %ebp,%esp
     c69:	5d                   	pop    %ebp
     c6a:	c3                   	ret    
     c6b:	90                   	nop
     c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        gettoken(ps, es, 0, 0);
     c70:	31 d2                	xor    %edx,%edx
     c72:	31 c0                	xor    %eax,%eax
     c74:	89 54 24 08          	mov    %edx,0x8(%esp)
     c78:	89 74 24 04          	mov    %esi,0x4(%esp)
     c7c:	89 1c 24             	mov    %ebx,(%esp)
     c7f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     c83:	e8 c8 fb ff ff       	call   850 <gettoken>
        cmd = pipecmd(cmd, parsepipe(ps, es));
     c88:	89 74 24 04          	mov    %esi,0x4(%esp)
     c8c:	89 1c 24             	mov    %ebx,(%esp)
     c8f:	e8 8c ff ff ff       	call   c20 <parsepipe>
}
     c94:	8b 5d f4             	mov    -0xc(%ebp),%ebx
        cmd = pipecmd(cmd, parsepipe(ps, es));
     c97:	89 7d 08             	mov    %edi,0x8(%ebp)
}
     c9a:	8b 75 f8             	mov    -0x8(%ebp),%esi
     c9d:	8b 7d fc             	mov    -0x4(%ebp),%edi
        cmd = pipecmd(cmd, parsepipe(ps, es));
     ca0:	89 45 0c             	mov    %eax,0xc(%ebp)
}
     ca3:	89 ec                	mov    %ebp,%esp
     ca5:	5d                   	pop    %ebp
        cmd = pipecmd(cmd, parsepipe(ps, es));
     ca6:	e9 c5 fa ff ff       	jmp    770 <pipecmd>
     cab:	90                   	nop
     cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000cb0 <parseline>:
{
     cb0:	55                   	push   %ebp
     cb1:	89 e5                	mov    %esp,%ebp
     cb3:	57                   	push   %edi
     cb4:	56                   	push   %esi
     cb5:	53                   	push   %ebx
     cb6:	83 ec 1c             	sub    $0x1c,%esp
     cb9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     cbc:	8b 75 0c             	mov    0xc(%ebp),%esi
    cmd = parsepipe(ps, es);
     cbf:	89 1c 24             	mov    %ebx,(%esp)
     cc2:	89 74 24 04          	mov    %esi,0x4(%esp)
     cc6:	e8 55 ff ff ff       	call   c20 <parsepipe>
     ccb:	89 c7                	mov    %eax,%edi
    while(peek(ps, es, "&")){
     ccd:	eb 23                	jmp    cf2 <parseline+0x42>
     ccf:	90                   	nop
        gettoken(ps, es, 0, 0);
     cd0:	31 c0                	xor    %eax,%eax
     cd2:	89 44 24 0c          	mov    %eax,0xc(%esp)
     cd6:	31 c0                	xor    %eax,%eax
     cd8:	89 44 24 08          	mov    %eax,0x8(%esp)
     cdc:	89 74 24 04          	mov    %esi,0x4(%esp)
     ce0:	89 1c 24             	mov    %ebx,(%esp)
     ce3:	e8 68 fb ff ff       	call   850 <gettoken>
        cmd = backcmd(cmd);
     ce8:	89 3c 24             	mov    %edi,(%esp)
     ceb:	e8 20 fb ff ff       	call   810 <backcmd>
     cf0:	89 c7                	mov    %eax,%edi
    while(peek(ps, es, "&")){
     cf2:	b8 d0 16 00 00       	mov    $0x16d0,%eax
     cf7:	89 44 24 08          	mov    %eax,0x8(%esp)
     cfb:	89 74 24 04          	mov    %esi,0x4(%esp)
     cff:	89 1c 24             	mov    %ebx,(%esp)
     d02:	e8 a9 fc ff ff       	call   9b0 <peek>
     d07:	85 c0                	test   %eax,%eax
     d09:	75 c5                	jne    cd0 <parseline+0x20>
    if(peek(ps, es, ";")){
     d0b:	b9 cc 16 00 00       	mov    $0x16cc,%ecx
     d10:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     d14:	89 74 24 04          	mov    %esi,0x4(%esp)
     d18:	89 1c 24             	mov    %ebx,(%esp)
     d1b:	e8 90 fc ff ff       	call   9b0 <peek>
     d20:	85 c0                	test   %eax,%eax
     d22:	75 0c                	jne    d30 <parseline+0x80>
}
     d24:	83 c4 1c             	add    $0x1c,%esp
     d27:	89 f8                	mov    %edi,%eax
     d29:	5b                   	pop    %ebx
     d2a:	5e                   	pop    %esi
     d2b:	5f                   	pop    %edi
     d2c:	5d                   	pop    %ebp
     d2d:	c3                   	ret    
     d2e:	66 90                	xchg   %ax,%ax
        gettoken(ps, es, 0, 0);
     d30:	31 d2                	xor    %edx,%edx
     d32:	31 c0                	xor    %eax,%eax
     d34:	89 54 24 08          	mov    %edx,0x8(%esp)
     d38:	89 74 24 04          	mov    %esi,0x4(%esp)
     d3c:	89 1c 24             	mov    %ebx,(%esp)
     d3f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     d43:	e8 08 fb ff ff       	call   850 <gettoken>
        cmd = listcmd(cmd, parseline(ps, es));
     d48:	89 74 24 04          	mov    %esi,0x4(%esp)
     d4c:	89 1c 24             	mov    %ebx,(%esp)
     d4f:	e8 5c ff ff ff       	call   cb0 <parseline>
     d54:	89 7d 08             	mov    %edi,0x8(%ebp)
     d57:	89 45 0c             	mov    %eax,0xc(%ebp)
}
     d5a:	83 c4 1c             	add    $0x1c,%esp
     d5d:	5b                   	pop    %ebx
     d5e:	5e                   	pop    %esi
     d5f:	5f                   	pop    %edi
     d60:	5d                   	pop    %ebp
        cmd = listcmd(cmd, parseline(ps, es));
     d61:	e9 5a fa ff ff       	jmp    7c0 <listcmd>
     d66:	8d 76 00             	lea    0x0(%esi),%esi
     d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d70 <parseblock>:
{
     d70:	55                   	push   %ebp
    if(!peek(ps, es, "("))
     d71:	b8 b2 16 00 00       	mov    $0x16b2,%eax
{
     d76:	89 e5                	mov    %esp,%ebp
     d78:	83 ec 28             	sub    $0x28,%esp
     d7b:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     d7e:	8b 5d 08             	mov    0x8(%ebp),%ebx
     d81:	89 75 f8             	mov    %esi,-0x8(%ebp)
     d84:	8b 75 0c             	mov    0xc(%ebp),%esi
    if(!peek(ps, es, "("))
     d87:	89 44 24 08          	mov    %eax,0x8(%esp)
{
     d8b:	89 7d fc             	mov    %edi,-0x4(%ebp)
    if(!peek(ps, es, "("))
     d8e:	89 1c 24             	mov    %ebx,(%esp)
     d91:	89 74 24 04          	mov    %esi,0x4(%esp)
     d95:	e8 16 fc ff ff       	call   9b0 <peek>
     d9a:	85 c0                	test   %eax,%eax
     d9c:	74 74                	je     e12 <parseblock+0xa2>
    gettoken(ps, es, 0, 0);
     d9e:	31 c9                	xor    %ecx,%ecx
     da0:	31 ff                	xor    %edi,%edi
     da2:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
     da6:	89 7c 24 08          	mov    %edi,0x8(%esp)
     daa:	89 74 24 04          	mov    %esi,0x4(%esp)
     dae:	89 1c 24             	mov    %ebx,(%esp)
     db1:	e8 9a fa ff ff       	call   850 <gettoken>
    cmd = parseline(ps, es);
     db6:	89 74 24 04          	mov    %esi,0x4(%esp)
     dba:	89 1c 24             	mov    %ebx,(%esp)
     dbd:	e8 ee fe ff ff       	call   cb0 <parseline>
    if(!peek(ps, es, ")"))
     dc2:	89 74 24 04          	mov    %esi,0x4(%esp)
     dc6:	89 1c 24             	mov    %ebx,(%esp)
    cmd = parseline(ps, es);
     dc9:	89 c7                	mov    %eax,%edi
    if(!peek(ps, es, ")"))
     dcb:	b8 ee 16 00 00       	mov    $0x16ee,%eax
     dd0:	89 44 24 08          	mov    %eax,0x8(%esp)
     dd4:	e8 d7 fb ff ff       	call   9b0 <peek>
     dd9:	85 c0                	test   %eax,%eax
     ddb:	74 41                	je     e1e <parseblock+0xae>
    gettoken(ps, es, 0, 0);
     ddd:	31 d2                	xor    %edx,%edx
     ddf:	31 c0                	xor    %eax,%eax
     de1:	89 54 24 08          	mov    %edx,0x8(%esp)
     de5:	89 74 24 04          	mov    %esi,0x4(%esp)
     de9:	89 1c 24             	mov    %ebx,(%esp)
     dec:	89 44 24 0c          	mov    %eax,0xc(%esp)
     df0:	e8 5b fa ff ff       	call   850 <gettoken>
    cmd = parseredirs(cmd, ps, es);
     df5:	89 74 24 08          	mov    %esi,0x8(%esp)
     df9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     dfd:	89 3c 24             	mov    %edi,(%esp)
     e00:	e8 1b fc ff ff       	call   a20 <parseredirs>
}
     e05:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     e08:	8b 75 f8             	mov    -0x8(%ebp),%esi
     e0b:	8b 7d fc             	mov    -0x4(%ebp),%edi
     e0e:	89 ec                	mov    %ebp,%esp
     e10:	5d                   	pop    %ebp
     e11:	c3                   	ret    
        panic("parseblock");
     e12:	c7 04 24 d2 16 00 00 	movl   $0x16d2,(%esp)
     e19:	e8 62 f6 ff ff       	call   480 <panic>
        panic("syntax - missing )");
     e1e:	c7 04 24 dd 16 00 00 	movl   $0x16dd,(%esp)
     e25:	e8 56 f6 ff ff       	call   480 <panic>
     e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000e30 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     e30:	55                   	push   %ebp
     e31:	89 e5                	mov    %esp,%ebp
     e33:	53                   	push   %ebx
     e34:	83 ec 14             	sub    $0x14,%esp
     e37:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct execcmd *ecmd;
    struct listcmd *lcmd;
    struct pipecmd *pcmd;
    struct redircmd *rcmd;

    if(cmd == 0)
     e3a:	85 db                	test   %ebx,%ebx
     e3c:	74 1d                	je     e5b <nulterminate+0x2b>
        return 0;

    switch(cmd->type){
     e3e:	83 3b 05             	cmpl   $0x5,(%ebx)
     e41:	77 18                	ja     e5b <nulterminate+0x2b>
     e43:	8b 03                	mov    (%ebx),%eax
     e45:	ff 24 85 34 17 00 00 	jmp    *0x1734(,%eax,4)
     e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            nulterminate(lcmd->right);
            break;

        case BACK:
            bcmd = (struct backcmd*)cmd;
            nulterminate(bcmd->cmd);
     e50:	8b 43 04             	mov    0x4(%ebx),%eax
     e53:	89 04 24             	mov    %eax,(%esp)
     e56:	e8 d5 ff ff ff       	call   e30 <nulterminate>
            break;
    }
    return cmd;
}
     e5b:	83 c4 14             	add    $0x14,%esp
     e5e:	89 d8                	mov    %ebx,%eax
     e60:	5b                   	pop    %ebx
     e61:	5d                   	pop    %ebp
     e62:	c3                   	ret    
     e63:	90                   	nop
     e64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            nulterminate(lcmd->left);
     e68:	8b 43 04             	mov    0x4(%ebx),%eax
     e6b:	89 04 24             	mov    %eax,(%esp)
     e6e:	e8 bd ff ff ff       	call   e30 <nulterminate>
            nulterminate(lcmd->right);
     e73:	8b 43 08             	mov    0x8(%ebx),%eax
     e76:	89 04 24             	mov    %eax,(%esp)
     e79:	e8 b2 ff ff ff       	call   e30 <nulterminate>
}
     e7e:	83 c4 14             	add    $0x14,%esp
     e81:	89 d8                	mov    %ebx,%eax
     e83:	5b                   	pop    %ebx
     e84:	5d                   	pop    %ebp
     e85:	c3                   	ret    
     e86:	8d 76 00             	lea    0x0(%esi),%esi
     e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            for(i=0; ecmd->argv[i]; i++)
     e90:	8b 4b 04             	mov    0x4(%ebx),%ecx
     e93:	8d 43 08             	lea    0x8(%ebx),%eax
     e96:	85 c9                	test   %ecx,%ecx
     e98:	74 c1                	je     e5b <nulterminate+0x2b>
     e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                *ecmd->eargv[i] = 0;
     ea0:	8b 50 24             	mov    0x24(%eax),%edx
     ea3:	83 c0 04             	add    $0x4,%eax
     ea6:	c6 02 00             	movb   $0x0,(%edx)
            for(i=0; ecmd->argv[i]; i++)
     ea9:	8b 50 fc             	mov    -0x4(%eax),%edx
     eac:	85 d2                	test   %edx,%edx
     eae:	75 f0                	jne    ea0 <nulterminate+0x70>
}
     eb0:	83 c4 14             	add    $0x14,%esp
     eb3:	89 d8                	mov    %ebx,%eax
     eb5:	5b                   	pop    %ebx
     eb6:	5d                   	pop    %ebp
     eb7:	c3                   	ret    
     eb8:	90                   	nop
     eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            nulterminate(rcmd->cmd);
     ec0:	8b 43 04             	mov    0x4(%ebx),%eax
     ec3:	89 04 24             	mov    %eax,(%esp)
     ec6:	e8 65 ff ff ff       	call   e30 <nulterminate>
            *rcmd->efile = 0;
     ecb:	8b 43 0c             	mov    0xc(%ebx),%eax
     ece:	c6 00 00             	movb   $0x0,(%eax)
}
     ed1:	83 c4 14             	add    $0x14,%esp
     ed4:	89 d8                	mov    %ebx,%eax
     ed6:	5b                   	pop    %ebx
     ed7:	5d                   	pop    %ebp
     ed8:	c3                   	ret    
     ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000ee0 <parsecmd>:
{
     ee0:	55                   	push   %ebp
     ee1:	89 e5                	mov    %esp,%ebp
     ee3:	56                   	push   %esi
     ee4:	53                   	push   %ebx
     ee5:	83 ec 10             	sub    $0x10,%esp
    es = s + strlen(s);
     ee8:	8b 5d 08             	mov    0x8(%ebp),%ebx
     eeb:	89 1c 24             	mov    %ebx,(%esp)
     eee:	e8 cd 00 00 00       	call   fc0 <strlen>
     ef3:	01 c3                	add    %eax,%ebx
    cmd = parseline(&s, es);
     ef5:	8d 45 08             	lea    0x8(%ebp),%eax
     ef8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     efc:	89 04 24             	mov    %eax,(%esp)
     eff:	e8 ac fd ff ff       	call   cb0 <parseline>
    peek(&s, es, "");
     f04:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    cmd = parseline(&s, es);
     f08:	89 c6                	mov    %eax,%esi
    peek(&s, es, "");
     f0a:	b8 52 16 00 00       	mov    $0x1652,%eax
     f0f:	89 44 24 08          	mov    %eax,0x8(%esp)
     f13:	8d 45 08             	lea    0x8(%ebp),%eax
     f16:	89 04 24             	mov    %eax,(%esp)
     f19:	e8 92 fa ff ff       	call   9b0 <peek>
    if(s != es){
     f1e:	8b 45 08             	mov    0x8(%ebp),%eax
     f21:	39 d8                	cmp    %ebx,%eax
     f23:	75 11                	jne    f36 <parsecmd+0x56>
    nulterminate(cmd);
     f25:	89 34 24             	mov    %esi,(%esp)
     f28:	e8 03 ff ff ff       	call   e30 <nulterminate>
}
     f2d:	83 c4 10             	add    $0x10,%esp
     f30:	89 f0                	mov    %esi,%eax
     f32:	5b                   	pop    %ebx
     f33:	5e                   	pop    %esi
     f34:	5d                   	pop    %ebp
     f35:	c3                   	ret    
        printf(2, "leftovers: %s\n", s);
     f36:	89 44 24 08          	mov    %eax,0x8(%esp)
     f3a:	c7 44 24 04 f0 16 00 	movl   $0x16f0,0x4(%esp)
     f41:	00 
     f42:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     f49:	e8 82 03 00 00       	call   12d0 <printf>
        panic("syntax");
     f4e:	c7 04 24 b4 16 00 00 	movl   $0x16b4,(%esp)
     f55:	e8 26 f5 ff ff       	call   480 <panic>
     f5a:	66 90                	xchg   %ax,%ax
     f5c:	66 90                	xchg   %ax,%ax
     f5e:	66 90                	xchg   %ax,%ax

00000f60 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     f60:	55                   	push   %ebp
     f61:	89 e5                	mov    %esp,%ebp
     f63:	8b 45 08             	mov    0x8(%ebp),%eax
     f66:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     f69:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     f6a:	89 c2                	mov    %eax,%edx
     f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     f70:	41                   	inc    %ecx
     f71:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     f75:	42                   	inc    %edx
     f76:	84 db                	test   %bl,%bl
     f78:	88 5a ff             	mov    %bl,-0x1(%edx)
     f7b:	75 f3                	jne    f70 <strcpy+0x10>
    ;
  return os;
}
     f7d:	5b                   	pop    %ebx
     f7e:	5d                   	pop    %ebp
     f7f:	c3                   	ret    

00000f80 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     f80:	55                   	push   %ebp
     f81:	89 e5                	mov    %esp,%ebp
     f83:	8b 4d 08             	mov    0x8(%ebp),%ecx
     f86:	53                   	push   %ebx
     f87:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
     f8a:	0f b6 01             	movzbl (%ecx),%eax
     f8d:	0f b6 13             	movzbl (%ebx),%edx
     f90:	84 c0                	test   %al,%al
     f92:	75 18                	jne    fac <strcmp+0x2c>
     f94:	eb 22                	jmp    fb8 <strcmp+0x38>
     f96:	8d 76 00             	lea    0x0(%esi),%esi
     f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     fa0:	41                   	inc    %ecx
  while(*p && *p == *q)
     fa1:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
     fa4:	43                   	inc    %ebx
     fa5:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
     fa8:	84 c0                	test   %al,%al
     faa:	74 0c                	je     fb8 <strcmp+0x38>
     fac:	38 d0                	cmp    %dl,%al
     fae:	74 f0                	je     fa0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
     fb0:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
     fb1:	29 d0                	sub    %edx,%eax
}
     fb3:	5d                   	pop    %ebp
     fb4:	c3                   	ret    
     fb5:	8d 76 00             	lea    0x0(%esi),%esi
     fb8:	5b                   	pop    %ebx
     fb9:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     fbb:	29 d0                	sub    %edx,%eax
}
     fbd:	5d                   	pop    %ebp
     fbe:	c3                   	ret    
     fbf:	90                   	nop

00000fc0 <strlen>:

uint
strlen(const char *s)
{
     fc0:	55                   	push   %ebp
     fc1:	89 e5                	mov    %esp,%ebp
     fc3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     fc6:	80 39 00             	cmpb   $0x0,(%ecx)
     fc9:	74 15                	je     fe0 <strlen+0x20>
     fcb:	31 d2                	xor    %edx,%edx
     fcd:	8d 76 00             	lea    0x0(%esi),%esi
     fd0:	42                   	inc    %edx
     fd1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     fd5:	89 d0                	mov    %edx,%eax
     fd7:	75 f7                	jne    fd0 <strlen+0x10>
    ;
  return n;
}
     fd9:	5d                   	pop    %ebp
     fda:	c3                   	ret    
     fdb:	90                   	nop
     fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
     fe0:	31 c0                	xor    %eax,%eax
}
     fe2:	5d                   	pop    %ebp
     fe3:	c3                   	ret    
     fe4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     fea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000ff0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     ff0:	55                   	push   %ebp
     ff1:	89 e5                	mov    %esp,%ebp
     ff3:	8b 55 08             	mov    0x8(%ebp),%edx
     ff6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     ff7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     ffa:	8b 45 0c             	mov    0xc(%ebp),%eax
     ffd:	89 d7                	mov    %edx,%edi
     fff:	fc                   	cld    
    1000:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1002:	5f                   	pop    %edi
    1003:	89 d0                	mov    %edx,%eax
    1005:	5d                   	pop    %ebp
    1006:	c3                   	ret    
    1007:	89 f6                	mov    %esi,%esi
    1009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001010 <strchr>:

char*
strchr(const char *s, char c)
{
    1010:	55                   	push   %ebp
    1011:	89 e5                	mov    %esp,%ebp
    1013:	8b 45 08             	mov    0x8(%ebp),%eax
    1016:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    101a:	0f b6 10             	movzbl (%eax),%edx
    101d:	84 d2                	test   %dl,%dl
    101f:	74 1b                	je     103c <strchr+0x2c>
    if(*s == c)
    1021:	38 d1                	cmp    %dl,%cl
    1023:	75 0f                	jne    1034 <strchr+0x24>
    1025:	eb 17                	jmp    103e <strchr+0x2e>
    1027:	89 f6                	mov    %esi,%esi
    1029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    1030:	38 ca                	cmp    %cl,%dl
    1032:	74 0a                	je     103e <strchr+0x2e>
  for(; *s; s++)
    1034:	40                   	inc    %eax
    1035:	0f b6 10             	movzbl (%eax),%edx
    1038:	84 d2                	test   %dl,%dl
    103a:	75 f4                	jne    1030 <strchr+0x20>
      return (char*)s;
  return 0;
    103c:	31 c0                	xor    %eax,%eax
}
    103e:	5d                   	pop    %ebp
    103f:	c3                   	ret    

00001040 <gets>:

char*
gets(char *buf, int max)
{
    1040:	55                   	push   %ebp
    1041:	89 e5                	mov    %esp,%ebp
    1043:	57                   	push   %edi
    1044:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1045:	31 f6                	xor    %esi,%esi
{
    1047:	53                   	push   %ebx
    1048:	83 ec 3c             	sub    $0x3c,%esp
    104b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
    104e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
    1051:	eb 32                	jmp    1085 <gets+0x45>
    1053:	90                   	nop
    1054:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
    1058:	ba 01 00 00 00       	mov    $0x1,%edx
    105d:	89 54 24 08          	mov    %edx,0x8(%esp)
    1061:	89 7c 24 04          	mov    %edi,0x4(%esp)
    1065:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    106c:	e8 2f 01 00 00       	call   11a0 <read>
    if(cc < 1)
    1071:	85 c0                	test   %eax,%eax
    1073:	7e 19                	jle    108e <gets+0x4e>
      break;
    buf[i++] = c;
    1075:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1079:	43                   	inc    %ebx
    107a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
    107d:	3c 0a                	cmp    $0xa,%al
    107f:	74 1f                	je     10a0 <gets+0x60>
    1081:	3c 0d                	cmp    $0xd,%al
    1083:	74 1b                	je     10a0 <gets+0x60>
  for(i=0; i+1 < max; ){
    1085:	46                   	inc    %esi
    1086:	3b 75 0c             	cmp    0xc(%ebp),%esi
    1089:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    108c:	7c ca                	jl     1058 <gets+0x18>
      break;
  }
  buf[i] = '\0';
    108e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1091:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
    1094:	8b 45 08             	mov    0x8(%ebp),%eax
    1097:	83 c4 3c             	add    $0x3c,%esp
    109a:	5b                   	pop    %ebx
    109b:	5e                   	pop    %esi
    109c:	5f                   	pop    %edi
    109d:	5d                   	pop    %ebp
    109e:	c3                   	ret    
    109f:	90                   	nop
    10a0:	8b 45 08             	mov    0x8(%ebp),%eax
    10a3:	01 c6                	add    %eax,%esi
    10a5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    10a8:	eb e4                	jmp    108e <gets+0x4e>
    10aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000010b0 <stat>:

int
stat(const char *n, struct stat *st)
{
    10b0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    10b1:	31 c0                	xor    %eax,%eax
{
    10b3:	89 e5                	mov    %esp,%ebp
    10b5:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
    10b8:	89 44 24 04          	mov    %eax,0x4(%esp)
    10bc:	8b 45 08             	mov    0x8(%ebp),%eax
{
    10bf:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    10c2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
    10c5:	89 04 24             	mov    %eax,(%esp)
    10c8:	e8 fb 00 00 00       	call   11c8 <open>
  if(fd < 0)
    10cd:	85 c0                	test   %eax,%eax
    10cf:	78 2f                	js     1100 <stat+0x50>
    10d1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    10d3:	8b 45 0c             	mov    0xc(%ebp),%eax
    10d6:	89 1c 24             	mov    %ebx,(%esp)
    10d9:	89 44 24 04          	mov    %eax,0x4(%esp)
    10dd:	e8 fe 00 00 00       	call   11e0 <fstat>
  close(fd);
    10e2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    10e5:	89 c6                	mov    %eax,%esi
  close(fd);
    10e7:	e8 c4 00 00 00       	call   11b0 <close>
  return r;
}
    10ec:	89 f0                	mov    %esi,%eax
    10ee:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    10f1:	8b 75 fc             	mov    -0x4(%ebp),%esi
    10f4:	89 ec                	mov    %ebp,%esp
    10f6:	5d                   	pop    %ebp
    10f7:	c3                   	ret    
    10f8:	90                   	nop
    10f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
    1100:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1105:	eb e5                	jmp    10ec <stat+0x3c>
    1107:	89 f6                	mov    %esi,%esi
    1109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001110 <atoi>:

int
atoi(const char *s)
{
    1110:	55                   	push   %ebp
    1111:	89 e5                	mov    %esp,%ebp
    1113:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1116:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1117:	0f be 11             	movsbl (%ecx),%edx
    111a:	88 d0                	mov    %dl,%al
    111c:	2c 30                	sub    $0x30,%al
    111e:	3c 09                	cmp    $0x9,%al
  n = 0;
    1120:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    1125:	77 1e                	ja     1145 <atoi+0x35>
    1127:	89 f6                	mov    %esi,%esi
    1129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    1130:	41                   	inc    %ecx
    1131:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1134:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    1138:	0f be 11             	movsbl (%ecx),%edx
    113b:	88 d3                	mov    %dl,%bl
    113d:	80 eb 30             	sub    $0x30,%bl
    1140:	80 fb 09             	cmp    $0x9,%bl
    1143:	76 eb                	jbe    1130 <atoi+0x20>
  return n;
}
    1145:	5b                   	pop    %ebx
    1146:	5d                   	pop    %ebp
    1147:	c3                   	ret    
    1148:	90                   	nop
    1149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001150 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	56                   	push   %esi
    1154:	8b 45 08             	mov    0x8(%ebp),%eax
    1157:	53                   	push   %ebx
    1158:	8b 5d 10             	mov    0x10(%ebp),%ebx
    115b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    115e:	85 db                	test   %ebx,%ebx
    1160:	7e 1a                	jle    117c <memmove+0x2c>
    1162:	31 d2                	xor    %edx,%edx
    1164:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    116a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
    1170:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    1174:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    1177:	42                   	inc    %edx
  while(n-- > 0)
    1178:	39 d3                	cmp    %edx,%ebx
    117a:	75 f4                	jne    1170 <memmove+0x20>
  return vdst;
}
    117c:	5b                   	pop    %ebx
    117d:	5e                   	pop    %esi
    117e:	5d                   	pop    %ebp
    117f:	c3                   	ret    

00001180 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1180:	b8 01 00 00 00       	mov    $0x1,%eax
    1185:	cd 40                	int    $0x40
    1187:	c3                   	ret    

00001188 <exit>:
SYSCALL(exit)
    1188:	b8 02 00 00 00       	mov    $0x2,%eax
    118d:	cd 40                	int    $0x40
    118f:	c3                   	ret    

00001190 <wait>:
SYSCALL(wait)
    1190:	b8 03 00 00 00       	mov    $0x3,%eax
    1195:	cd 40                	int    $0x40
    1197:	c3                   	ret    

00001198 <pipe>:
SYSCALL(pipe)
    1198:	b8 04 00 00 00       	mov    $0x4,%eax
    119d:	cd 40                	int    $0x40
    119f:	c3                   	ret    

000011a0 <read>:
SYSCALL(read)
    11a0:	b8 05 00 00 00       	mov    $0x5,%eax
    11a5:	cd 40                	int    $0x40
    11a7:	c3                   	ret    

000011a8 <write>:
SYSCALL(write)
    11a8:	b8 10 00 00 00       	mov    $0x10,%eax
    11ad:	cd 40                	int    $0x40
    11af:	c3                   	ret    

000011b0 <close>:
SYSCALL(close)
    11b0:	b8 15 00 00 00       	mov    $0x15,%eax
    11b5:	cd 40                	int    $0x40
    11b7:	c3                   	ret    

000011b8 <kill>:
SYSCALL(kill)
    11b8:	b8 06 00 00 00       	mov    $0x6,%eax
    11bd:	cd 40                	int    $0x40
    11bf:	c3                   	ret    

000011c0 <exec>:
SYSCALL(exec)
    11c0:	b8 07 00 00 00       	mov    $0x7,%eax
    11c5:	cd 40                	int    $0x40
    11c7:	c3                   	ret    

000011c8 <open>:
SYSCALL(open)
    11c8:	b8 0f 00 00 00       	mov    $0xf,%eax
    11cd:	cd 40                	int    $0x40
    11cf:	c3                   	ret    

000011d0 <mknod>:
SYSCALL(mknod)
    11d0:	b8 11 00 00 00       	mov    $0x11,%eax
    11d5:	cd 40                	int    $0x40
    11d7:	c3                   	ret    

000011d8 <unlink>:
SYSCALL(unlink)
    11d8:	b8 12 00 00 00       	mov    $0x12,%eax
    11dd:	cd 40                	int    $0x40
    11df:	c3                   	ret    

000011e0 <fstat>:
SYSCALL(fstat)
    11e0:	b8 08 00 00 00       	mov    $0x8,%eax
    11e5:	cd 40                	int    $0x40
    11e7:	c3                   	ret    

000011e8 <link>:
SYSCALL(link)
    11e8:	b8 13 00 00 00       	mov    $0x13,%eax
    11ed:	cd 40                	int    $0x40
    11ef:	c3                   	ret    

000011f0 <mkdir>:
SYSCALL(mkdir)
    11f0:	b8 14 00 00 00       	mov    $0x14,%eax
    11f5:	cd 40                	int    $0x40
    11f7:	c3                   	ret    

000011f8 <chdir>:
SYSCALL(chdir)
    11f8:	b8 09 00 00 00       	mov    $0x9,%eax
    11fd:	cd 40                	int    $0x40
    11ff:	c3                   	ret    

00001200 <dup>:
SYSCALL(dup)
    1200:	b8 0a 00 00 00       	mov    $0xa,%eax
    1205:	cd 40                	int    $0x40
    1207:	c3                   	ret    

00001208 <getpid>:
SYSCALL(getpid)
    1208:	b8 0b 00 00 00       	mov    $0xb,%eax
    120d:	cd 40                	int    $0x40
    120f:	c3                   	ret    

00001210 <sbrk>:
SYSCALL(sbrk)
    1210:	b8 0c 00 00 00       	mov    $0xc,%eax
    1215:	cd 40                	int    $0x40
    1217:	c3                   	ret    

00001218 <sleep>:
SYSCALL(sleep)
    1218:	b8 0d 00 00 00       	mov    $0xd,%eax
    121d:	cd 40                	int    $0x40
    121f:	c3                   	ret    

00001220 <uptime>:
SYSCALL(uptime)
    1220:	b8 0e 00 00 00       	mov    $0xe,%eax
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
    1269:	0f b6 92 78 17 00 00 	movzbl 0x1778(%edx),%edx
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
    12a7:	e8 fc fe ff ff       	call   11a8 <write>

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
    1323:	e8 80 fe ff ff       	call   11a8 <write>
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
    138e:	e8 15 fe ff ff       	call   11a8 <write>
    1393:	ba 01 00 00 00       	mov    $0x1,%edx
    1398:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    139b:	89 54 24 08          	mov    %edx,0x8(%esp)
    139f:	89 44 24 04          	mov    %eax,0x4(%esp)
    13a3:	89 3c 24             	mov    %edi,(%esp)
    13a6:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    13a9:	e8 fa fd ff ff       	call   11a8 <write>
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
    1427:	e8 7c fd ff ff       	call   11a8 <write>
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
    146e:	e8 35 fd ff ff       	call   11a8 <write>
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
    149e:	e8 05 fd ff ff       	call   11a8 <write>
      state = 0;
    14a3:	31 d2                	xor    %edx,%edx
        ap++;
    14a5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    14a8:	e9 7e fe ff ff       	jmp    132b <printf+0x5b>
          s = "(null)";
    14ad:	bb 70 17 00 00       	mov    $0x1770,%ebx
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
    14c1:	a1 84 1e 00 00       	mov    0x1e84,%eax
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
    1508:	a3 84 1e 00 00       	mov    %eax,0x1e84
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
    1544:	a3 84 1e 00 00       	mov    %eax,0x1e84
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
    156c:	8b 15 84 1e 00 00    	mov    0x1e84,%edx
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
    15b1:	39 05 84 1e 00 00    	cmp    %eax,0x1e84
    15b7:	89 c2                	mov    %eax,%edx
    15b9:	75 ed                	jne    15a8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    15bb:	89 34 24             	mov    %esi,(%esp)
    15be:	e8 4d fc ff ff       	call   1210 <sbrk>
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
    15d6:	8b 15 84 1e 00 00    	mov    0x1e84,%edx
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
    15ff:	89 15 84 1e 00 00    	mov    %edx,0x1e84
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
    1610:	b8 88 1e 00 00       	mov    $0x1e88,%eax
    1615:	ba 88 1e 00 00       	mov    $0x1e88,%edx
    base.s.size = 0;
    161a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
    161c:	a3 84 1e 00 00       	mov    %eax,0x1e84
    base.s.size = 0;
    1621:	b8 88 1e 00 00       	mov    $0x1e88,%eax
    base.s.ptr = freep = prevp = &base;
    1626:	89 15 88 1e 00 00    	mov    %edx,0x1e88
    base.s.size = 0;
    162c:	89 0d 8c 1e 00 00    	mov    %ecx,0x1e8c
    1632:	e9 53 ff ff ff       	jmp    158a <malloc+0x2a>
    1637:	89 f6                	mov    %esi,%esi
    1639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
    1640:	8b 08                	mov    (%eax),%ecx
    1642:	89 0a                	mov    %ecx,(%edx)
    1644:	eb b9                	jmp    15ff <malloc+0x9f>
