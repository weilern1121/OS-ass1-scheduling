
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
      22:	c7 04 24 12 18 00 00 	movl   $0x1812,(%esp)
      29:	e8 8a 12 00 00       	call   12b8 <open>
      2e:	85 c0                	test   %eax,%eax
      30:	79 de                	jns    10 <main+0x10>
      32:	eb 2b                	jmp    5f <main+0x5f>
      34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi



    // Read and run input commands.
    while(getcmd(buf, sizeof(buf)) >= 0){
        if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      38:	80 3d 22 1f 00 00 20 	cmpb   $0x20,0x1f22
      3f:	0f 84 85 00 00 00    	je     ca <main+0xca>
int
fork1(void)
{
    int pid;

    pid = fork();
      45:	e8 26 12 00 00       	call   1270 <fork>
    if(pid == -1)
      4a:	83 f8 ff             	cmp    $0xffffffff,%eax
      4d:	74 45                	je     94 <main+0x94>
        if(fork1() == 0)
      4f:	85 c0                	test   %eax,%eax
      51:	74 63                	je     b6 <main+0xb6>
        wait(0);
      53:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      5a:	e8 21 12 00 00       	call   1280 <wait>
    while(getcmd(buf, sizeof(buf)) >= 0){
      5f:	b8 f4 01 00 00       	mov    $0x1f4,%eax
      64:	89 44 24 04          	mov    %eax,0x4(%esp)
      68:	c7 04 24 20 1f 00 00 	movl   $0x1f20,(%esp)
      6f:	e8 3c 03 00 00       	call   3b0 <getcmd>
      74:	85 c0                	test   %eax,%eax
      76:	78 32                	js     aa <main+0xaa>
        if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      78:	80 3d 20 1f 00 00 63 	cmpb   $0x63,0x1f20
      7f:	75 c4                	jne    45 <main+0x45>
      81:	80 3d 21 1f 00 00 64 	cmpb   $0x64,0x1f21
      88:	74 ae                	je     38 <main+0x38>
    pid = fork();
      8a:	e8 e1 11 00 00       	call   1270 <fork>
    if(pid == -1)
      8f:	83 f8 ff             	cmp    $0xffffffff,%eax
      92:	75 bb                	jne    4f <main+0x4f>
        panic("fork");
      94:	c7 04 24 9b 17 00 00 	movl   $0x179b,(%esp)
      9b:	e8 70 03 00 00       	call   410 <panic>
            close(fd);
      a0:	89 04 24             	mov    %eax,(%esp)
      a3:	e8 f8 11 00 00       	call   12a0 <close>
            break;
      a8:	eb b5                	jmp    5f <main+0x5f>
    exit(0);
      aa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      b1:	e8 c2 11 00 00       	call   1278 <exit>
            runcmd(parsecmd(buf));
      b6:	c7 04 24 20 1f 00 00 	movl   $0x1f20,(%esp)
      bd:	e8 0e 0f 00 00       	call   fd0 <parsecmd>
      c2:	89 04 24             	mov    %eax,(%esp)
      c5:	e8 76 03 00 00       	call   440 <runcmd>
            buf[strlen(buf)-1] = 0;  // chop \n
      ca:	c7 04 24 20 1f 00 00 	movl   $0x1f20,(%esp)
      d1:	e8 da 0f 00 00       	call   10b0 <strlen>
            if(chdir(buf+3) < 0)
      d6:	c7 04 24 23 1f 00 00 	movl   $0x1f23,(%esp)
            buf[strlen(buf)-1] = 0;  // chop \n
      dd:	c6 80 1f 1f 00 00 00 	movb   $0x0,0x1f1f(%eax)
            if(chdir(buf+3) < 0)
      e4:	e8 ff 11 00 00       	call   12e8 <chdir>
      e9:	85 c0                	test   %eax,%eax
      eb:	0f 89 6e ff ff ff    	jns    5f <main+0x5f>
                printf(2, "cannot cd %s\n", buf+3);
      f1:	c7 44 24 08 23 1f 00 	movl   $0x1f23,0x8(%esp)
      f8:	00 
      f9:	c7 44 24 04 1a 18 00 	movl   $0x181a,0x4(%esp)
     100:	00 
     101:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     108:	e8 d3 12 00 00       	call   13e0 <printf>
     10d:	e9 4d ff ff ff       	jmp    5f <main+0x5f>
     112:	66 90                	xchg   %ax,%ax
     114:	66 90                	xchg   %ax,%ax
     116:	66 90                	xchg   %ax,%ax
     118:	66 90                	xchg   %ax,%ax
     11a:	66 90                	xchg   %ax,%ax
     11c:	66 90                	xchg   %ax,%ax
     11e:	66 90                	xchg   %ax,%ax

00000120 <swap>:
{
     120:	55                   	push   %ebp
     121:	89 e5                	mov    %esp,%ebp
     123:	8b 45 10             	mov    0x10(%ebp),%eax
     126:	53                   	push   %ebx
    char temp = str[a];
     127:	8b 55 08             	mov    0x8(%ebp),%edx
    str[a] = str[b];
     12a:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    char temp = str[a];
     12d:	01 c2                	add    %eax,%edx
    str[a] = str[b];
     12f:	01 d8                	add    %ebx,%eax
    char temp = str[a];
     131:	0f b6 0a             	movzbl (%edx),%ecx
    str[a] = str[b];
     134:	0f b6 18             	movzbl (%eax),%ebx
     137:	88 1a                	mov    %bl,(%edx)
    str[b] = temp;
     139:	88 08                	mov    %cl,(%eax)
}
     13b:	5b                   	pop    %ebx
     13c:	5d                   	pop    %ebp
     13d:	c3                   	ret    
     13e:	66 90                	xchg   %ax,%ax

00000140 <reverse_string>:
{
     140:	55                   	push   %ebp
     141:	89 e5                	mov    %esp,%ebp
     143:	57                   	push   %edi
     144:	56                   	push   %esi
     145:	53                   	push   %ebx
     146:	83 ec 2c             	sub    $0x2c,%esp
     149:	8b 5d 08             	mov    0x8(%ebp),%ebx
    int len = strlen( str ) - 1;
     14c:	89 1c 24             	mov    %ebx,(%esp)
     14f:	e8 5c 0f 00 00       	call   10b0 <strlen>
     154:	8d 70 ff             	lea    -0x1(%eax),%esi
    for( i = 0 ; i < len ; i++ )
     157:	85 f6                	test   %esi,%esi
     159:	7e 43                	jle    19e <reverse_string+0x5e>
    str[a] = str[b];
     15b:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
    char temp = str[a];
     15e:	0f b6 13             	movzbl (%ebx),%edx
        k--;
     161:	83 e8 02             	sub    $0x2,%eax
    str[a] = str[b];
     164:	0f b6 0f             	movzbl (%edi),%ecx
        if( k == len/2 )
     167:	d1 fe                	sar    %esi
     169:	39 f0                	cmp    %esi,%eax
    str[a] = str[b];
     16b:	88 0b                	mov    %cl,(%ebx)
    str[b] = temp;
     16d:	88 17                	mov    %dl,(%edi)
        if( k == len/2 )
     16f:	74 2d                	je     19e <reverse_string+0x5e>
     171:	8d 53 01             	lea    0x1(%ebx),%edx
     174:	eb 24                	jmp    19a <reverse_string+0x5a>
     176:	8d 76 00             	lea    0x0(%esi),%esi
     179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    char temp = str[a];
     180:	0f b6 0a             	movzbl (%edx),%ecx
     183:	42                   	inc    %edx
     184:	88 4d e7             	mov    %cl,-0x19(%ebp)
    str[a] = str[b];
     187:	0f b6 0c 03          	movzbl (%ebx,%eax,1),%ecx
     18b:	88 4a ff             	mov    %cl,-0x1(%edx)
    str[b] = temp;
     18e:	0f b6 4d e7          	movzbl -0x19(%ebp),%ecx
     192:	88 0c 03             	mov    %cl,(%ebx,%eax,1)
        k--;
     195:	48                   	dec    %eax
        if( k == len/2 )
     196:	39 f0                	cmp    %esi,%eax
     198:	74 04                	je     19e <reverse_string+0x5e>
    for( i = 0 ; i < len ; i++ )
     19a:	85 c0                	test   %eax,%eax
     19c:	75 e2                	jne    180 <reverse_string+0x40>
}
     19e:	83 c4 2c             	add    $0x2c,%esp
     1a1:	5b                   	pop    %ebx
     1a2:	5e                   	pop    %esi
     1a3:	5f                   	pop    %edi
     1a4:	5d                   	pop    %ebp
     1a5:	c3                   	ret    
     1a6:	8d 76 00             	lea    0x0(%esi),%esi
     1a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001b0 <strconcat>:
strconcat (const char *first, const char *second, char* dest){
     1b0:	55                   	push   %ebp
     1b1:	89 e5                	mov    %esp,%ebp
     1b3:	56                   	push   %esi
     1b4:	8b 75 10             	mov    0x10(%ebp),%esi
     1b7:	53                   	push   %ebx
     1b8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     1bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    while((*dest++ = *first++) != 0)
     1be:	89 f2                	mov    %esi,%edx
     1c0:	43                   	inc    %ebx
     1c1:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
     1c5:	42                   	inc    %edx
     1c6:	84 c0                	test   %al,%al
     1c8:	88 42 ff             	mov    %al,-0x1(%edx)
     1cb:	75 f3                	jne    1c0 <strconcat+0x10>
    while((*dest++ = *second++) != 0)
     1cd:	41                   	inc    %ecx
     1ce:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
     1d2:	84 c0                	test   %al,%al
     1d4:	88 42 ff             	mov    %al,-0x1(%edx)
     1d7:	74 14                	je     1ed <strconcat+0x3d>
     1d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     1e0:	41                   	inc    %ecx
     1e1:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
     1e5:	42                   	inc    %edx
     1e6:	84 c0                	test   %al,%al
     1e8:	88 42 ff             	mov    %al,-0x1(%edx)
     1eb:	75 f3                	jne    1e0 <strconcat+0x30>
}
     1ed:	5b                   	pop    %ebx
     1ee:	89 f0                	mov    %esi,%eax
     1f0:	5e                   	pop    %esi
     1f1:	5d                   	pop    %ebp
     1f2:	c3                   	ret    
     1f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000200 <strcpyuntildelimiter>:
{
     200:	55                   	push   %ebp
     201:	89 e5                	mov    %esp,%ebp
     203:	8b 55 0c             	mov    0xc(%ebp),%edx
     206:	56                   	push   %esi
     207:	0f b6 45 10          	movzbl 0x10(%ebp),%eax
     20b:	53                   	push   %ebx
     20c:	8b 75 08             	mov    0x8(%ebp),%esi
    while((*s = *t) != delim && (*s = *t) !=0)
     20f:	0f b6 0a             	movzbl (%edx),%ecx
     212:	38 c8                	cmp    %cl,%al
     214:	88 0e                	mov    %cl,(%esi)
     216:	74 30                	je     248 <strcpyuntildelimiter+0x48>
     218:	0f b6 0a             	movzbl (%edx),%ecx
     21b:	84 c9                	test   %cl,%cl
     21d:	88 0e                	mov    %cl,(%esi)
     21f:	74 27                	je     248 <strcpyuntildelimiter+0x48>
     221:	89 f1                	mov    %esi,%ecx
     223:	eb 0c                	jmp    231 <strcpyuntildelimiter+0x31>
     225:	8d 76 00             	lea    0x0(%esi),%esi
     228:	0f b6 1a             	movzbl (%edx),%ebx
     22b:	84 db                	test   %bl,%bl
     22d:	88 19                	mov    %bl,(%ecx)
     22f:	74 0b                	je     23c <strcpyuntildelimiter+0x3c>
        s++,t++;
     231:	42                   	inc    %edx
    while((*s = *t) != delim && (*s = *t) !=0)
     232:	0f b6 1a             	movzbl (%edx),%ebx
        s++,t++;
     235:	41                   	inc    %ecx
    while((*s = *t) != delim && (*s = *t) !=0)
     236:	38 c3                	cmp    %al,%bl
     238:	88 19                	mov    %bl,(%ecx)
     23a:	75 ec                	jne    228 <strcpyuntildelimiter+0x28>
    *s='\0';
     23c:	c6 01 00             	movb   $0x0,(%ecx)
}
     23f:	89 f0                	mov    %esi,%eax
     241:	5b                   	pop    %ebx
     242:	5e                   	pop    %esi
     243:	5d                   	pop    %ebp
     244:	c3                   	ret    
     245:	8d 76 00             	lea    0x0(%esi),%esi
    while((*s = *t) != delim && (*s = *t) !=0)
     248:	89 f1                	mov    %esi,%ecx
}
     24a:	89 f0                	mov    %esi,%eax
    *s='\0';
     24c:	c6 01 00             	movb   $0x0,(%ecx)
}
     24f:	5b                   	pop    %ebx
     250:	5e                   	pop    %esi
     251:	5d                   	pop    %ebp
     252:	c3                   	ret    
     253:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000260 <execWithPath>:
{
     260:	55                   	push   %ebp
     261:	89 e5                	mov    %esp,%ebp
     263:	57                   	push   %edi
     264:	56                   	push   %esi
     265:	53                   	push   %ebx
     266:	83 ec 1c             	sub    $0x1c,%esp
    char *curr_path = malloc(strlen(PATH));
     269:	c7 04 24 20 21 00 00 	movl   $0x2120,(%esp)
     270:	e8 3b 0e 00 00       	call   10b0 <strlen>
     275:	89 04 24             	mov    %eax,(%esp)
     278:	e8 f3 13 00 00       	call   1670 <malloc>
    strcpy( curr_path , PATH );
     27d:	b9 20 21 00 00       	mov    $0x2120,%ecx
     282:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    char *curr_path = malloc(strlen(PATH));
     286:	89 c3                	mov    %eax,%ebx
    strcpy( curr_path , PATH );
     288:	89 04 24             	mov    %eax,(%esp)
     28b:	e8 c0 0d 00 00       	call   1050 <strcpy>
    while( curr_path != NULL )
     290:	85 db                	test   %ebx,%ebx
     292:	0f 84 f1 00 00 00    	je     389 <execWithPath+0x129>
     298:	90                   	nop
     299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        char* str2= malloc(100);
     2a0:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
     2a7:	e8 c4 13 00 00       	call   1670 <malloc>
     2ac:	89 c6                	mov    %eax,%esi
    while((*s = *t) != delim && (*s = *t) !=0)
     2ae:	0f b6 03             	movzbl (%ebx),%eax
     2b1:	3c 3a                	cmp    $0x3a,%al
     2b3:	88 06                	mov    %al,(%esi)
     2b5:	0f 84 e5 00 00 00    	je     3a0 <execWithPath+0x140>
     2bb:	0f b6 03             	movzbl (%ebx),%eax
     2be:	84 c0                	test   %al,%al
     2c0:	88 06                	mov    %al,(%esi)
     2c2:	0f 84 d8 00 00 00    	je     3a0 <execWithPath+0x140>
     2c8:	89 d9                	mov    %ebx,%ecx
     2ca:	89 f0                	mov    %esi,%eax
     2cc:	eb 0b                	jmp    2d9 <execWithPath+0x79>
     2ce:	66 90                	xchg   %ax,%ax
     2d0:	0f b6 11             	movzbl (%ecx),%edx
     2d3:	84 d2                	test   %dl,%dl
     2d5:	88 10                	mov    %dl,(%eax)
     2d7:	74 0c                	je     2e5 <execWithPath+0x85>
        s++,t++;
     2d9:	41                   	inc    %ecx
    while((*s = *t) != delim && (*s = *t) !=0)
     2da:	0f b6 11             	movzbl (%ecx),%edx
        s++,t++;
     2dd:	40                   	inc    %eax
    while((*s = *t) != delim && (*s = *t) !=0)
     2de:	80 fa 3a             	cmp    $0x3a,%dl
     2e1:	88 10                	mov    %dl,(%eax)
     2e3:	75 eb                	jne    2d0 <execWithPath+0x70>
        curr_path=strchr(curr_path,':');
     2e5:	ba 3a 00 00 00       	mov    $0x3a,%edx
    *s='\0';
     2ea:	c6 00 00             	movb   $0x0,(%eax)
        curr_path=strchr(curr_path,':');
     2ed:	89 54 24 04          	mov    %edx,0x4(%esp)
     2f1:	89 1c 24             	mov    %ebx,(%esp)
     2f4:	e8 07 0e 00 00       	call   1100 <strchr>
        char* str3=malloc ((strlen(str2) + strlen(path) - 1));
     2f9:	89 34 24             	mov    %esi,(%esp)
            curr_path++;
     2fc:	83 f8 01             	cmp    $0x1,%eax
        curr_path=strchr(curr_path,':');
     2ff:	89 c3                	mov    %eax,%ebx
            curr_path++;
     301:	83 db ff             	sbb    $0xffffffff,%ebx
        char* str3=malloc ((strlen(str2) + strlen(path) - 1));
     304:	e8 a7 0d 00 00       	call   10b0 <strlen>
     309:	89 c7                	mov    %eax,%edi
     30b:	8b 45 08             	mov    0x8(%ebp),%eax
     30e:	89 04 24             	mov    %eax,(%esp)
     311:	e8 9a 0d 00 00       	call   10b0 <strlen>
     316:	8d 44 07 ff          	lea    -0x1(%edi,%eax,1),%eax
     31a:	89 04 24             	mov    %eax,(%esp)
     31d:	e8 4e 13 00 00       	call   1670 <malloc>
     322:	89 c7                	mov    %eax,%edi
     324:	89 c2                	mov    %eax,%edx
     326:	89 f0                	mov    %esi,%eax
     328:	90                   	nop
     329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while((*dest++ = *first++) != 0)
     330:	40                   	inc    %eax
     331:	0f b6 48 ff          	movzbl -0x1(%eax),%ecx
     335:	42                   	inc    %edx
     336:	84 c9                	test   %cl,%cl
     338:	88 4a ff             	mov    %cl,-0x1(%edx)
     33b:	75 f3                	jne    330 <execWithPath+0xd0>
     33d:	8b 45 08             	mov    0x8(%ebp),%eax
     340:	eb 07                	jmp    349 <execWithPath+0xe9>
     342:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     348:	42                   	inc    %edx
    while((*dest++ = *second++) != 0)
     349:	40                   	inc    %eax
     34a:	0f b6 48 ff          	movzbl -0x1(%eax),%ecx
     34e:	84 c9                	test   %cl,%cl
     350:	88 4a ff             	mov    %cl,-0x1(%edx)
     353:	75 f3                	jne    348 <execWithPath+0xe8>
        printf(3,"str3= %s \tstr2= %s\n",str3,str2);
     355:	b8 58 17 00 00       	mov    $0x1758,%eax
     35a:	89 44 24 04          	mov    %eax,0x4(%esp)
     35e:	89 74 24 0c          	mov    %esi,0xc(%esp)
     362:	89 7c 24 08          	mov    %edi,0x8(%esp)
     366:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
     36d:	e8 6e 10 00 00       	call   13e0 <printf>
        exec( str3 , argv );
     372:	8b 45 0c             	mov    0xc(%ebp),%eax
     375:	89 3c 24             	mov    %edi,(%esp)
     378:	89 44 24 04          	mov    %eax,0x4(%esp)
     37c:	e8 2f 0f 00 00       	call   12b0 <exec>
    while( curr_path != NULL )
     381:	85 db                	test   %ebx,%ebx
     383:	0f 85 17 ff ff ff    	jne    2a0 <execWithPath+0x40>
}
     389:	83 c4 1c             	add    $0x1c,%esp
     38c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     391:	5b                   	pop    %ebx
     392:	5e                   	pop    %esi
     393:	5f                   	pop    %edi
     394:	5d                   	pop    %ebp
     395:	c3                   	ret    
     396:	8d 76 00             	lea    0x0(%esi),%esi
     399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    while((*s = *t) != delim && (*s = *t) !=0)
     3a0:	89 f0                	mov    %esi,%eax
     3a2:	e9 3e ff ff ff       	jmp    2e5 <execWithPath+0x85>
     3a7:	89 f6                	mov    %esi,%esi
     3a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003b0 <getcmd>:
{
     3b0:	55                   	push   %ebp
    printf(2, "$ ");
     3b1:	b8 6c 17 00 00       	mov    $0x176c,%eax
{
     3b6:	89 e5                	mov    %esp,%ebp
     3b8:	83 ec 18             	sub    $0x18,%esp
     3bb:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     3be:	8b 5d 08             	mov    0x8(%ebp),%ebx
     3c1:	89 75 fc             	mov    %esi,-0x4(%ebp)
     3c4:	8b 75 0c             	mov    0xc(%ebp),%esi
    printf(2, "$ ");
     3c7:	89 44 24 04          	mov    %eax,0x4(%esp)
     3cb:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     3d2:	e8 09 10 00 00       	call   13e0 <printf>
    memset(buf, 0, nbuf);
     3d7:	31 d2                	xor    %edx,%edx
     3d9:	89 74 24 08          	mov    %esi,0x8(%esp)
     3dd:	89 54 24 04          	mov    %edx,0x4(%esp)
     3e1:	89 1c 24             	mov    %ebx,(%esp)
     3e4:	e8 f7 0c 00 00       	call   10e0 <memset>
    gets(buf, nbuf);
     3e9:	89 74 24 04          	mov    %esi,0x4(%esp)
     3ed:	89 1c 24             	mov    %ebx,(%esp)
     3f0:	e8 3b 0d 00 00       	call   1130 <gets>
    if(buf[0] == 0) // EOF
     3f5:	31 c0                	xor    %eax,%eax
}
     3f7:	8b 75 fc             	mov    -0x4(%ebp),%esi
    if(buf[0] == 0) // EOF
     3fa:	80 3b 00             	cmpb   $0x0,(%ebx)
}
     3fd:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    if(buf[0] == 0) // EOF
     400:	0f 94 c0             	sete   %al
}
     403:	89 ec                	mov    %ebp,%esp
    if(buf[0] == 0) // EOF
     405:	f7 d8                	neg    %eax
}
     407:	5d                   	pop    %ebp
     408:	c3                   	ret    
     409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000410 <panic>:
{
     410:	55                   	push   %ebp
     411:	89 e5                	mov    %esp,%ebp
     413:	83 ec 18             	sub    $0x18,%esp
    printf(2, "%s\n", s);
     416:	8b 45 08             	mov    0x8(%ebp),%eax
     419:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     420:	89 44 24 08          	mov    %eax,0x8(%esp)
     424:	b8 0e 18 00 00       	mov    $0x180e,%eax
     429:	89 44 24 04          	mov    %eax,0x4(%esp)
     42d:	e8 ae 0f 00 00       	call   13e0 <printf>
    exit(0);
     432:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     439:	e8 3a 0e 00 00       	call   1278 <exit>
     43e:	66 90                	xchg   %ax,%ax

00000440 <runcmd>:
{
     440:	55                   	push   %ebp
    if((fd2 = open("path", O_RDWR)) >= 0){
     441:	b8 02 00 00 00       	mov    $0x2,%eax
{
     446:	89 e5                	mov    %esp,%ebp
     448:	57                   	push   %edi
     449:	56                   	push   %esi
     44a:	53                   	push   %ebx
     44b:	83 ec 3c             	sub    $0x3c,%esp
    if((fd2 = open("path", O_RDWR)) >= 0){
     44e:	89 44 24 04          	mov    %eax,0x4(%esp)
{
     452:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if((fd2 = open("path", O_RDWR)) >= 0){
     455:	c7 04 24 6f 17 00 00 	movl   $0x176f,(%esp)
     45c:	e8 57 0e 00 00       	call   12b8 <open>
     461:	85 c0                	test   %eax,%eax
     463:	79 62                	jns    4c7 <runcmd+0x87>
    if(cmd == 0)
     465:	85 db                	test   %ebx,%ebx
     467:	74 52                	je     4bb <runcmd+0x7b>
    switch(cmd->type){
     469:	83 3b 05             	cmpl   $0x5,(%ebx)
     46c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     470:	0f 87 60 02 00 00    	ja     6d6 <runcmd+0x296>
     476:	8b 03                	mov    (%ebx),%eax
     478:	ff 24 85 4c 18 00 00 	jmp    *0x184c(,%eax,4)
            close(rcmd->fd);
     47f:	8b 43 14             	mov    0x14(%ebx),%eax
     482:	89 04 24             	mov    %eax,(%esp)
     485:	e8 16 0e 00 00       	call   12a0 <close>
            if(open(rcmd->file, rcmd->mode) < 0){
     48a:	8b 43 10             	mov    0x10(%ebx),%eax
     48d:	89 44 24 04          	mov    %eax,0x4(%esp)
     491:	8b 43 08             	mov    0x8(%ebx),%eax
     494:	89 04 24             	mov    %eax,(%esp)
     497:	e8 1c 0e 00 00       	call   12b8 <open>
     49c:	85 c0                	test   %eax,%eax
     49e:	79 75                	jns    515 <runcmd+0xd5>
                printf(2, "open %s failed\n", rcmd->file);
     4a0:	8b 43 08             	mov    0x8(%ebx),%eax
     4a3:	c7 44 24 04 8b 17 00 	movl   $0x178b,0x4(%esp)
     4aa:	00 
     4ab:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     4b2:	89 44 24 08          	mov    %eax,0x8(%esp)
     4b6:	e8 25 0f 00 00       	call   13e0 <printf>
                exit(0);
     4bb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     4c2:	e8 b1 0d 00 00       	call   1278 <exit>
        if( read(fd2, PATH, sizeof(PATH)) < 0 ){
     4c7:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
     4ce:	00 
     4cf:	c7 44 24 04 20 21 00 	movl   $0x2120,0x4(%esp)
     4d6:	00 
     4d7:	89 04 24             	mov    %eax,(%esp)
     4da:	e8 b1 0d 00 00       	call   1290 <read>
     4df:	85 c0                	test   %eax,%eax
     4e1:	79 82                	jns    465 <runcmd+0x25>
            printf(1, "error: read from path file failed\n");
     4e3:	c7 44 24 04 28 18 00 	movl   $0x1828,0x4(%esp)
     4ea:	00 
     4eb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     4f2:	e8 e9 0e 00 00       	call   13e0 <printf>
            exit(0);
     4f7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     4fe:	e8 75 0d 00 00       	call   1278 <exit>
    pid = fork();
     503:	e8 68 0d 00 00       	call   1270 <fork>
    if(pid == -1)
     508:	83 f8 ff             	cmp    $0xffffffff,%eax
     50b:	0f 84 d1 01 00 00    	je     6e2 <runcmd+0x2a2>
            if(fork1() == 0)
     511:	85 c0                	test   %eax,%eax
     513:	75 a6                	jne    4bb <runcmd+0x7b>
                runcmd(bcmd->cmd);
     515:	8b 43 04             	mov    0x4(%ebx),%eax
     518:	89 04 24             	mov    %eax,(%esp)
     51b:	e8 20 ff ff ff       	call   440 <runcmd>
            if(ecmd->argv[0] == 0)
     520:	8b 43 04             	mov    0x4(%ebx),%eax
     523:	85 c0                	test   %eax,%eax
     525:	74 94                	je     4bb <runcmd+0x7b>
            exec(ecmd->argv[0], ecmd->argv);
     527:	8d 73 04             	lea    0x4(%ebx),%esi
     52a:	89 74 24 04          	mov    %esi,0x4(%esp)
     52e:	89 04 24             	mov    %eax,(%esp)
     531:	89 75 d0             	mov    %esi,-0x30(%ebp)
     534:	e8 77 0d 00 00       	call   12b0 <exec>
            char *curr_path = malloc(strlen(PATH));
     539:	c7 04 24 20 21 00 00 	movl   $0x2120,(%esp)
     540:	e8 6b 0b 00 00       	call   10b0 <strlen>
     545:	89 04 24             	mov    %eax,(%esp)
     548:	e8 23 11 00 00       	call   1670 <malloc>
            char* path=ecmd->argv[0];
     54d:	8b 73 04             	mov    0x4(%ebx),%esi
            strcpy( curr_path , PATH );
     550:	c7 44 24 04 20 21 00 	movl   $0x2120,0x4(%esp)
     557:	00 
     558:	89 04 24             	mov    %eax,(%esp)
            char *curr_path = malloc(strlen(PATH));
     55b:	89 c7                	mov    %eax,%edi
            strcpy( curr_path , PATH );
     55d:	e8 ee 0a 00 00       	call   1050 <strcpy>
     562:	89 5d 08             	mov    %ebx,0x8(%ebp)
            while( curr_path != NULL )
     565:	85 ff                	test   %edi,%edi
     567:	0f 84 81 01 00 00    	je     6ee <runcmd+0x2ae>
                char* str2= malloc(100);
     56d:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
     574:	e8 f7 10 00 00       	call   1670 <malloc>
     579:	89 c3                	mov    %eax,%ebx
    while((*s = *t) != delim && (*s = *t) !=0)
     57b:	0f b6 07             	movzbl (%edi),%eax
     57e:	3c 3a                	cmp    $0x3a,%al
     580:	88 03                	mov    %al,(%ebx)
     582:	0f 84 89 01 00 00    	je     711 <runcmd+0x2d1>
     588:	0f b6 07             	movzbl (%edi),%eax
     58b:	84 c0                	test   %al,%al
     58d:	88 03                	mov    %al,(%ebx)
     58f:	0f 84 7c 01 00 00    	je     711 <runcmd+0x2d1>
     595:	89 f9                	mov    %edi,%ecx
     597:	89 d8                	mov    %ebx,%eax
     599:	eb 0e                	jmp    5a9 <runcmd+0x169>
     59b:	90                   	nop
     59c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     5a0:	0f b6 11             	movzbl (%ecx),%edx
     5a3:	84 d2                	test   %dl,%dl
     5a5:	88 10                	mov    %dl,(%eax)
     5a7:	74 0c                	je     5b5 <runcmd+0x175>
        s++,t++;
     5a9:	41                   	inc    %ecx
    while((*s = *t) != delim && (*s = *t) !=0)
     5aa:	0f b6 11             	movzbl (%ecx),%edx
        s++,t++;
     5ad:	40                   	inc    %eax
    while((*s = *t) != delim && (*s = *t) !=0)
     5ae:	80 fa 3a             	cmp    $0x3a,%dl
     5b1:	88 10                	mov    %dl,(%eax)
     5b3:	75 eb                	jne    5a0 <runcmd+0x160>
    *s='\0';
     5b5:	c6 00 00             	movb   $0x0,(%eax)
                curr_path=strchr(curr_path,':');
     5b8:	89 3c 24             	mov    %edi,(%esp)
     5bb:	c7 44 24 04 3a 00 00 	movl   $0x3a,0x4(%esp)
     5c2:	00 
     5c3:	e8 38 0b 00 00       	call   1100 <strchr>
                if(curr_path!=NULL)
     5c8:	85 c0                	test   %eax,%eax
                curr_path=strchr(curr_path,':');
     5ca:	89 c7                	mov    %eax,%edi
                if(curr_path!=NULL)
     5cc:	74 01                	je     5cf <runcmd+0x18f>
                    curr_path++;
     5ce:	47                   	inc    %edi
                char* str3=malloc ((strlen(str2) + strlen(path) - 1));
     5cf:	89 1c 24             	mov    %ebx,(%esp)
     5d2:	e8 d9 0a 00 00       	call   10b0 <strlen>
     5d7:	89 34 24             	mov    %esi,(%esp)
     5da:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     5dd:	e8 ce 0a 00 00       	call   10b0 <strlen>
     5e2:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     5e5:	8d 44 02 ff          	lea    -0x1(%edx,%eax,1),%eax
     5e9:	89 04 24             	mov    %eax,(%esp)
     5ec:	e8 7f 10 00 00       	call   1670 <malloc>
     5f1:	89 c2                	mov    %eax,%edx
     5f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     5f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    while((*dest++ = *first++) != 0)
     600:	43                   	inc    %ebx
     601:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
     605:	42                   	inc    %edx
     606:	84 c9                	test   %cl,%cl
     608:	88 4a ff             	mov    %cl,-0x1(%edx)
     60b:	75 f3                	jne    600 <runcmd+0x1c0>
     60d:	89 f3                	mov    %esi,%ebx
     60f:	eb 08                	jmp    619 <runcmd+0x1d9>
     611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     618:	42                   	inc    %edx
    while((*dest++ = *second++) != 0)
     619:	43                   	inc    %ebx
     61a:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
     61e:	84 c9                	test   %cl,%cl
     620:	88 4a ff             	mov    %cl,-0x1(%edx)
     623:	75 f3                	jne    618 <runcmd+0x1d8>
                ecmd->argv[0]=str3;
     625:	8b 5d 08             	mov    0x8(%ebp),%ebx
     628:	89 43 04             	mov    %eax,0x4(%ebx)
                exec( ecmd->argv[0] , ecmd->argv );
     62b:	8b 5d d0             	mov    -0x30(%ebp),%ebx
     62e:	89 04 24             	mov    %eax,(%esp)
     631:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     635:	e8 76 0c 00 00       	call   12b0 <exec>
     63a:	e9 26 ff ff ff       	jmp    565 <runcmd+0x125>
            if(pipe(p) < 0)
     63f:	8d 45 e0             	lea    -0x20(%ebp),%eax
     642:	89 04 24             	mov    %eax,(%esp)
     645:	e8 3e 0c 00 00       	call   1288 <pipe>
     64a:	85 c0                	test   %eax,%eax
     64c:	0f 88 fe 00 00 00    	js     750 <runcmd+0x310>
    pid = fork();
     652:	e8 19 0c 00 00       	call   1270 <fork>
    if(pid == -1)
     657:	83 f8 ff             	cmp    $0xffffffff,%eax
     65a:	0f 84 82 00 00 00    	je     6e2 <runcmd+0x2a2>
            if(fork1() == 0){
     660:	85 c0                	test   %eax,%eax
     662:	0f 84 f4 00 00 00    	je     75c <runcmd+0x31c>
    pid = fork();
     668:	e8 03 0c 00 00       	call   1270 <fork>
    if(pid == -1)
     66d:	83 f8 ff             	cmp    $0xffffffff,%eax
     670:	74 70                	je     6e2 <runcmd+0x2a2>
            if(fork1() == 0){
     672:	85 c0                	test   %eax,%eax
     674:	0f 84 9e 00 00 00    	je     718 <runcmd+0x2d8>
            close(p[0]);
     67a:	8b 45 e0             	mov    -0x20(%ebp),%eax
     67d:	89 04 24             	mov    %eax,(%esp)
     680:	e8 1b 0c 00 00       	call   12a0 <close>
            close(p[1]);
     685:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     688:	89 04 24             	mov    %eax,(%esp)
     68b:	e8 10 0c 00 00       	call   12a0 <close>
            wait(0);
     690:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     697:	e8 e4 0b 00 00       	call   1280 <wait>
            wait(0);
     69c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     6a3:	e8 d8 0b 00 00       	call   1280 <wait>
            break;
     6a8:	e9 0e fe ff ff       	jmp    4bb <runcmd+0x7b>
    pid = fork();
     6ad:	e8 be 0b 00 00       	call   1270 <fork>
    if(pid == -1)
     6b2:	83 f8 ff             	cmp    $0xffffffff,%eax
     6b5:	74 2b                	je     6e2 <runcmd+0x2a2>
            if(fork1() == 0)
     6b7:	85 c0                	test   %eax,%eax
     6b9:	0f 84 56 fe ff ff    	je     515 <runcmd+0xd5>
            wait(0);
     6bf:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     6c6:	e8 b5 0b 00 00       	call   1280 <wait>
            runcmd(lcmd->right);
     6cb:	8b 43 08             	mov    0x8(%ebx),%eax
     6ce:	89 04 24             	mov    %eax,(%esp)
     6d1:	e8 6a fd ff ff       	call   440 <runcmd>
            panic("runcmd");
     6d6:	c7 04 24 74 17 00 00 	movl   $0x1774,(%esp)
     6dd:	e8 2e fd ff ff       	call   410 <panic>
        panic("fork");
     6e2:	c7 04 24 9b 17 00 00 	movl   $0x179b,(%esp)
     6e9:	e8 22 fd ff ff       	call   410 <panic>
     6ee:	8b 5d 08             	mov    0x8(%ebp),%ebx
            printf(2, "exec %s failed\n", ecmd->argv[0]);
     6f1:	8b 43 04             	mov    0x4(%ebx),%eax
     6f4:	c7 44 24 04 7b 17 00 	movl   $0x177b,0x4(%esp)
     6fb:	00 
     6fc:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     703:	89 44 24 08          	mov    %eax,0x8(%esp)
     707:	e8 d4 0c 00 00       	call   13e0 <printf>
            break;
     70c:	e9 aa fd ff ff       	jmp    4bb <runcmd+0x7b>
    while((*s = *t) != delim && (*s = *t) !=0)
     711:	89 d8                	mov    %ebx,%eax
     713:	e9 9d fe ff ff       	jmp    5b5 <runcmd+0x175>
                close(0);
     718:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     71f:	e8 7c 0b 00 00       	call   12a0 <close>
                dup(p[0]);
     724:	8b 45 e0             	mov    -0x20(%ebp),%eax
     727:	89 04 24             	mov    %eax,(%esp)
     72a:	e8 c1 0b 00 00       	call   12f0 <dup>
                close(p[0]);
     72f:	8b 45 e0             	mov    -0x20(%ebp),%eax
     732:	89 04 24             	mov    %eax,(%esp)
     735:	e8 66 0b 00 00       	call   12a0 <close>
                close(p[1]);
     73a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     73d:	89 04 24             	mov    %eax,(%esp)
     740:	e8 5b 0b 00 00       	call   12a0 <close>
                runcmd(pcmd->right);
     745:	8b 43 08             	mov    0x8(%ebx),%eax
     748:	89 04 24             	mov    %eax,(%esp)
     74b:	e8 f0 fc ff ff       	call   440 <runcmd>
                panic("pipe");
     750:	c7 04 24 a0 17 00 00 	movl   $0x17a0,(%esp)
     757:	e8 b4 fc ff ff       	call   410 <panic>
                close(1);
     75c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     763:	e8 38 0b 00 00       	call   12a0 <close>
                dup(p[1]);
     768:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     76b:	89 04 24             	mov    %eax,(%esp)
     76e:	e8 7d 0b 00 00       	call   12f0 <dup>
                close(p[0]);
     773:	8b 45 e0             	mov    -0x20(%ebp),%eax
     776:	89 04 24             	mov    %eax,(%esp)
     779:	e8 22 0b 00 00       	call   12a0 <close>
                close(p[1]);
     77e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     781:	89 04 24             	mov    %eax,(%esp)
     784:	e8 17 0b 00 00       	call   12a0 <close>
                runcmd(pcmd->left);
     789:	8b 43 04             	mov    0x4(%ebx),%eax
     78c:	89 04 24             	mov    %eax,(%esp)
     78f:	e8 ac fc ff ff       	call   440 <runcmd>
     794:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     79a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000007a0 <fork1>:
{
     7a0:	55                   	push   %ebp
     7a1:	89 e5                	mov    %esp,%ebp
     7a3:	83 ec 18             	sub    $0x18,%esp
    pid = fork();
     7a6:	e8 c5 0a 00 00       	call   1270 <fork>
    if(pid == -1)
     7ab:	83 f8 ff             	cmp    $0xffffffff,%eax
     7ae:	74 02                	je     7b2 <fork1+0x12>
    return pid;
}
     7b0:	c9                   	leave  
     7b1:	c3                   	ret    
        panic("fork");
     7b2:	c7 04 24 9b 17 00 00 	movl   $0x179b,(%esp)
     7b9:	e8 52 fc ff ff       	call   410 <panic>
     7be:	66 90                	xchg   %ax,%ax

000007c0 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     7c0:	55                   	push   %ebp
     7c1:	89 e5                	mov    %esp,%ebp
     7c3:	53                   	push   %ebx
     7c4:	83 ec 14             	sub    $0x14,%esp
    struct execcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     7c7:	c7 04 24 54 00 00 00 	movl   $0x54,(%esp)
     7ce:	e8 9d 0e 00 00       	call   1670 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     7d3:	31 d2                	xor    %edx,%edx
     7d5:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     7d9:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     7db:	b8 54 00 00 00       	mov    $0x54,%eax
     7e0:	89 1c 24             	mov    %ebx,(%esp)
     7e3:	89 44 24 08          	mov    %eax,0x8(%esp)
     7e7:	e8 f4 08 00 00       	call   10e0 <memset>
    cmd->type = EXEC;
    return (struct cmd*)cmd;
}
     7ec:	89 d8                	mov    %ebx,%eax
    cmd->type = EXEC;
     7ee:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
}
     7f4:	83 c4 14             	add    $0x14,%esp
     7f7:	5b                   	pop    %ebx
     7f8:	5d                   	pop    %ebp
     7f9:	c3                   	ret    
     7fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000800 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     800:	55                   	push   %ebp
     801:	89 e5                	mov    %esp,%ebp
     803:	53                   	push   %ebx
     804:	83 ec 14             	sub    $0x14,%esp
    struct redircmd *cmd;

    cmd = malloc(sizeof(*cmd));
     807:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
     80e:	e8 5d 0e 00 00       	call   1670 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     813:	31 d2                	xor    %edx,%edx
     815:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     819:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     81b:	b8 18 00 00 00       	mov    $0x18,%eax
     820:	89 1c 24             	mov    %ebx,(%esp)
     823:	89 44 24 08          	mov    %eax,0x8(%esp)
     827:	e8 b4 08 00 00       	call   10e0 <memset>
    cmd->type = REDIR;
    cmd->cmd = subcmd;
     82c:	8b 45 08             	mov    0x8(%ebp),%eax
    cmd->type = REDIR;
     82f:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
    cmd->cmd = subcmd;
     835:	89 43 04             	mov    %eax,0x4(%ebx)
    cmd->file = file;
     838:	8b 45 0c             	mov    0xc(%ebp),%eax
     83b:	89 43 08             	mov    %eax,0x8(%ebx)
    cmd->efile = efile;
     83e:	8b 45 10             	mov    0x10(%ebp),%eax
     841:	89 43 0c             	mov    %eax,0xc(%ebx)
    cmd->mode = mode;
     844:	8b 45 14             	mov    0x14(%ebp),%eax
     847:	89 43 10             	mov    %eax,0x10(%ebx)
    cmd->fd = fd;
     84a:	8b 45 18             	mov    0x18(%ebp),%eax
     84d:	89 43 14             	mov    %eax,0x14(%ebx)
    return (struct cmd*)cmd;
}
     850:	83 c4 14             	add    $0x14,%esp
     853:	89 d8                	mov    %ebx,%eax
     855:	5b                   	pop    %ebx
     856:	5d                   	pop    %ebp
     857:	c3                   	ret    
     858:	90                   	nop
     859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000860 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     860:	55                   	push   %ebp
     861:	89 e5                	mov    %esp,%ebp
     863:	53                   	push   %ebx
     864:	83 ec 14             	sub    $0x14,%esp
    struct pipecmd *cmd;

    cmd = malloc(sizeof(*cmd));
     867:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     86e:	e8 fd 0d 00 00       	call   1670 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     873:	31 d2                	xor    %edx,%edx
     875:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     879:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     87b:	b8 0c 00 00 00       	mov    $0xc,%eax
     880:	89 1c 24             	mov    %ebx,(%esp)
     883:	89 44 24 08          	mov    %eax,0x8(%esp)
     887:	e8 54 08 00 00       	call   10e0 <memset>
    cmd->type = PIPE;
    cmd->left = left;
     88c:	8b 45 08             	mov    0x8(%ebp),%eax
    cmd->type = PIPE;
     88f:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
    cmd->left = left;
     895:	89 43 04             	mov    %eax,0x4(%ebx)
    cmd->right = right;
     898:	8b 45 0c             	mov    0xc(%ebp),%eax
     89b:	89 43 08             	mov    %eax,0x8(%ebx)
    return (struct cmd*)cmd;
}
     89e:	83 c4 14             	add    $0x14,%esp
     8a1:	89 d8                	mov    %ebx,%eax
     8a3:	5b                   	pop    %ebx
     8a4:	5d                   	pop    %ebp
     8a5:	c3                   	ret    
     8a6:	8d 76 00             	lea    0x0(%esi),%esi
     8a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008b0 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     8b0:	55                   	push   %ebp
     8b1:	89 e5                	mov    %esp,%ebp
     8b3:	53                   	push   %ebx
     8b4:	83 ec 14             	sub    $0x14,%esp
    struct listcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     8b7:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     8be:	e8 ad 0d 00 00       	call   1670 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     8c3:	31 d2                	xor    %edx,%edx
     8c5:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     8c9:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     8cb:	b8 0c 00 00 00       	mov    $0xc,%eax
     8d0:	89 1c 24             	mov    %ebx,(%esp)
     8d3:	89 44 24 08          	mov    %eax,0x8(%esp)
     8d7:	e8 04 08 00 00       	call   10e0 <memset>
    cmd->type = LIST;
    cmd->left = left;
     8dc:	8b 45 08             	mov    0x8(%ebp),%eax
    cmd->type = LIST;
     8df:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
    cmd->left = left;
     8e5:	89 43 04             	mov    %eax,0x4(%ebx)
    cmd->right = right;
     8e8:	8b 45 0c             	mov    0xc(%ebp),%eax
     8eb:	89 43 08             	mov    %eax,0x8(%ebx)
    return (struct cmd*)cmd;
}
     8ee:	83 c4 14             	add    $0x14,%esp
     8f1:	89 d8                	mov    %ebx,%eax
     8f3:	5b                   	pop    %ebx
     8f4:	5d                   	pop    %ebp
     8f5:	c3                   	ret    
     8f6:	8d 76 00             	lea    0x0(%esi),%esi
     8f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000900 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     900:	55                   	push   %ebp
     901:	89 e5                	mov    %esp,%ebp
     903:	53                   	push   %ebx
     904:	83 ec 14             	sub    $0x14,%esp
    struct backcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     907:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     90e:	e8 5d 0d 00 00       	call   1670 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     913:	31 d2                	xor    %edx,%edx
     915:	89 54 24 04          	mov    %edx,0x4(%esp)
    cmd = malloc(sizeof(*cmd));
     919:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     91b:	b8 08 00 00 00       	mov    $0x8,%eax
     920:	89 1c 24             	mov    %ebx,(%esp)
     923:	89 44 24 08          	mov    %eax,0x8(%esp)
     927:	e8 b4 07 00 00       	call   10e0 <memset>
    cmd->type = BACK;
    cmd->cmd = subcmd;
     92c:	8b 45 08             	mov    0x8(%ebp),%eax
    cmd->type = BACK;
     92f:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
    cmd->cmd = subcmd;
     935:	89 43 04             	mov    %eax,0x4(%ebx)
    return (struct cmd*)cmd;
}
     938:	83 c4 14             	add    $0x14,%esp
     93b:	89 d8                	mov    %ebx,%eax
     93d:	5b                   	pop    %ebx
     93e:	5d                   	pop    %ebp
     93f:	c3                   	ret    

00000940 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     940:	55                   	push   %ebp
     941:	89 e5                	mov    %esp,%ebp
     943:	57                   	push   %edi
     944:	56                   	push   %esi
     945:	53                   	push   %ebx
     946:	83 ec 1c             	sub    $0x1c,%esp
    char *s;
    int ret;

    s = *ps;
     949:	8b 45 08             	mov    0x8(%ebp),%eax
{
     94c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     94f:	8b 7d 10             	mov    0x10(%ebp),%edi
    s = *ps;
     952:	8b 30                	mov    (%eax),%esi
    while(s < es && strchr(whitespace, *s))
     954:	39 de                	cmp    %ebx,%esi
     956:	72 0d                	jb     965 <gettoken+0x25>
     958:	eb 22                	jmp    97c <gettoken+0x3c>
     95a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s++;
     960:	46                   	inc    %esi
    while(s < es && strchr(whitespace, *s))
     961:	39 f3                	cmp    %esi,%ebx
     963:	74 17                	je     97c <gettoken+0x3c>
     965:	0f be 06             	movsbl (%esi),%eax
     968:	c7 04 24 18 1f 00 00 	movl   $0x1f18,(%esp)
     96f:	89 44 24 04          	mov    %eax,0x4(%esp)
     973:	e8 88 07 00 00       	call   1100 <strchr>
     978:	85 c0                	test   %eax,%eax
     97a:	75 e4                	jne    960 <gettoken+0x20>
    if(q)
     97c:	85 ff                	test   %edi,%edi
     97e:	74 02                	je     982 <gettoken+0x42>
        *q = s;
     980:	89 37                	mov    %esi,(%edi)
    ret = *s;
     982:	0f be 06             	movsbl (%esi),%eax
    switch(*s){
     985:	3c 29                	cmp    $0x29,%al
     987:	7f 57                	jg     9e0 <gettoken+0xa0>
     989:	3c 28                	cmp    $0x28,%al
     98b:	0f 8d cb 00 00 00    	jge    a5c <gettoken+0x11c>
     991:	31 ff                	xor    %edi,%edi
     993:	84 c0                	test   %al,%al
     995:	0f 85 cd 00 00 00    	jne    a68 <gettoken+0x128>
            ret = 'a';
            while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
                s++;
            break;
    }
    if(eq)
     99b:	8b 55 14             	mov    0x14(%ebp),%edx
     99e:	85 d2                	test   %edx,%edx
     9a0:	74 05                	je     9a7 <gettoken+0x67>
        *eq = s;
     9a2:	8b 45 14             	mov    0x14(%ebp),%eax
     9a5:	89 30                	mov    %esi,(%eax)

    while(s < es && strchr(whitespace, *s))
     9a7:	39 de                	cmp    %ebx,%esi
     9a9:	72 0a                	jb     9b5 <gettoken+0x75>
     9ab:	eb 1f                	jmp    9cc <gettoken+0x8c>
     9ad:	8d 76 00             	lea    0x0(%esi),%esi
        s++;
     9b0:	46                   	inc    %esi
    while(s < es && strchr(whitespace, *s))
     9b1:	39 f3                	cmp    %esi,%ebx
     9b3:	74 17                	je     9cc <gettoken+0x8c>
     9b5:	0f be 06             	movsbl (%esi),%eax
     9b8:	c7 04 24 18 1f 00 00 	movl   $0x1f18,(%esp)
     9bf:	89 44 24 04          	mov    %eax,0x4(%esp)
     9c3:	e8 38 07 00 00       	call   1100 <strchr>
     9c8:	85 c0                	test   %eax,%eax
     9ca:	75 e4                	jne    9b0 <gettoken+0x70>
    *ps = s;
     9cc:	8b 45 08             	mov    0x8(%ebp),%eax
     9cf:	89 30                	mov    %esi,(%eax)
    return ret;
}
     9d1:	83 c4 1c             	add    $0x1c,%esp
     9d4:	89 f8                	mov    %edi,%eax
     9d6:	5b                   	pop    %ebx
     9d7:	5e                   	pop    %esi
     9d8:	5f                   	pop    %edi
     9d9:	5d                   	pop    %ebp
     9da:	c3                   	ret    
     9db:	90                   	nop
     9dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(*s){
     9e0:	3c 3e                	cmp    $0x3e,%al
     9e2:	75 1c                	jne    a00 <gettoken+0xc0>
            if(*s == '>'){
     9e4:	80 7e 01 3e          	cmpb   $0x3e,0x1(%esi)
            s++;
     9e8:	8d 46 01             	lea    0x1(%esi),%eax
            if(*s == '>'){
     9eb:	0f 84 94 00 00 00    	je     a85 <gettoken+0x145>
            s++;
     9f1:	89 c6                	mov    %eax,%esi
     9f3:	bf 3e 00 00 00       	mov    $0x3e,%edi
     9f8:	eb a1                	jmp    99b <gettoken+0x5b>
     9fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(*s){
     a00:	7f 56                	jg     a58 <gettoken+0x118>
     a02:	88 c1                	mov    %al,%cl
     a04:	80 e9 3b             	sub    $0x3b,%cl
     a07:	80 f9 01             	cmp    $0x1,%cl
     a0a:	76 50                	jbe    a5c <gettoken+0x11c>
            while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     a0c:	39 f3                	cmp    %esi,%ebx
     a0e:	77 27                	ja     a37 <gettoken+0xf7>
     a10:	eb 5e                	jmp    a70 <gettoken+0x130>
     a12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     a18:	0f be 06             	movsbl (%esi),%eax
     a1b:	c7 04 24 10 1f 00 00 	movl   $0x1f10,(%esp)
     a22:	89 44 24 04          	mov    %eax,0x4(%esp)
     a26:	e8 d5 06 00 00       	call   1100 <strchr>
     a2b:	85 c0                	test   %eax,%eax
     a2d:	75 1c                	jne    a4b <gettoken+0x10b>
                s++;
     a2f:	46                   	inc    %esi
            while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     a30:	39 f3                	cmp    %esi,%ebx
     a32:	74 3c                	je     a70 <gettoken+0x130>
     a34:	0f be 06             	movsbl (%esi),%eax
     a37:	89 44 24 04          	mov    %eax,0x4(%esp)
     a3b:	c7 04 24 18 1f 00 00 	movl   $0x1f18,(%esp)
     a42:	e8 b9 06 00 00       	call   1100 <strchr>
     a47:	85 c0                	test   %eax,%eax
     a49:	74 cd                	je     a18 <gettoken+0xd8>
            ret = 'a';
     a4b:	bf 61 00 00 00       	mov    $0x61,%edi
     a50:	e9 46 ff ff ff       	jmp    99b <gettoken+0x5b>
     a55:	8d 76 00             	lea    0x0(%esi),%esi
    switch(*s){
     a58:	3c 7c                	cmp    $0x7c,%al
     a5a:	75 b0                	jne    a0c <gettoken+0xcc>
    ret = *s;
     a5c:	0f be f8             	movsbl %al,%edi
            s++;
     a5f:	46                   	inc    %esi
            break;
     a60:	e9 36 ff ff ff       	jmp    99b <gettoken+0x5b>
     a65:	8d 76 00             	lea    0x0(%esi),%esi
    switch(*s){
     a68:	3c 26                	cmp    $0x26,%al
     a6a:	75 a0                	jne    a0c <gettoken+0xcc>
     a6c:	eb ee                	jmp    a5c <gettoken+0x11c>
     a6e:	66 90                	xchg   %ax,%ax
    if(eq)
     a70:	8b 45 14             	mov    0x14(%ebp),%eax
     a73:	bf 61 00 00 00       	mov    $0x61,%edi
     a78:	85 c0                	test   %eax,%eax
     a7a:	0f 85 22 ff ff ff    	jne    9a2 <gettoken+0x62>
     a80:	e9 47 ff ff ff       	jmp    9cc <gettoken+0x8c>
                s++;
     a85:	83 c6 02             	add    $0x2,%esi
                ret = '+';
     a88:	bf 2b 00 00 00       	mov    $0x2b,%edi
     a8d:	e9 09 ff ff ff       	jmp    99b <gettoken+0x5b>
     a92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000aa0 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     aa0:	55                   	push   %ebp
     aa1:	89 e5                	mov    %esp,%ebp
     aa3:	57                   	push   %edi
     aa4:	56                   	push   %esi
     aa5:	53                   	push   %ebx
     aa6:	83 ec 1c             	sub    $0x1c,%esp
     aa9:	8b 7d 08             	mov    0x8(%ebp),%edi
     aac:	8b 75 0c             	mov    0xc(%ebp),%esi
    char *s;

    s = *ps;
     aaf:	8b 1f                	mov    (%edi),%ebx
    while(s < es && strchr(whitespace, *s))
     ab1:	39 f3                	cmp    %esi,%ebx
     ab3:	72 10                	jb     ac5 <peek+0x25>
     ab5:	eb 25                	jmp    adc <peek+0x3c>
     ab7:	89 f6                	mov    %esi,%esi
     ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s++;
     ac0:	43                   	inc    %ebx
    while(s < es && strchr(whitespace, *s))
     ac1:	39 de                	cmp    %ebx,%esi
     ac3:	74 17                	je     adc <peek+0x3c>
     ac5:	0f be 03             	movsbl (%ebx),%eax
     ac8:	c7 04 24 18 1f 00 00 	movl   $0x1f18,(%esp)
     acf:	89 44 24 04          	mov    %eax,0x4(%esp)
     ad3:	e8 28 06 00 00       	call   1100 <strchr>
     ad8:	85 c0                	test   %eax,%eax
     ada:	75 e4                	jne    ac0 <peek+0x20>
    *ps = s;
     adc:	89 1f                	mov    %ebx,(%edi)
    return *s && strchr(toks, *s);
     ade:	31 c0                	xor    %eax,%eax
     ae0:	0f be 13             	movsbl (%ebx),%edx
     ae3:	84 d2                	test   %dl,%dl
     ae5:	74 17                	je     afe <peek+0x5e>
     ae7:	8b 45 10             	mov    0x10(%ebp),%eax
     aea:	89 54 24 04          	mov    %edx,0x4(%esp)
     aee:	89 04 24             	mov    %eax,(%esp)
     af1:	e8 0a 06 00 00       	call   1100 <strchr>
     af6:	85 c0                	test   %eax,%eax
     af8:	0f 95 c0             	setne  %al
     afb:	0f b6 c0             	movzbl %al,%eax
}
     afe:	83 c4 1c             	add    $0x1c,%esp
     b01:	5b                   	pop    %ebx
     b02:	5e                   	pop    %esi
     b03:	5f                   	pop    %edi
     b04:	5d                   	pop    %ebp
     b05:	c3                   	ret    
     b06:	8d 76 00             	lea    0x0(%esi),%esi
     b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b10 <parseredirs>:
    return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     b10:	55                   	push   %ebp
     b11:	89 e5                	mov    %esp,%ebp
     b13:	57                   	push   %edi
     b14:	56                   	push   %esi
     b15:	53                   	push   %ebx
     b16:	83 ec 3c             	sub    $0x3c,%esp
     b19:	8b 75 0c             	mov    0xc(%ebp),%esi
     b1c:	8b 5d 10             	mov    0x10(%ebp),%ebx
     b1f:	90                   	nop
    int tok;
    char *q, *eq;

    while(peek(ps, es, "<>")){
     b20:	b8 c2 17 00 00       	mov    $0x17c2,%eax
     b25:	89 44 24 08          	mov    %eax,0x8(%esp)
     b29:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     b2d:	89 34 24             	mov    %esi,(%esp)
     b30:	e8 6b ff ff ff       	call   aa0 <peek>
     b35:	85 c0                	test   %eax,%eax
     b37:	0f 84 93 00 00 00    	je     bd0 <parseredirs+0xc0>
        tok = gettoken(ps, es, 0, 0);
     b3d:	31 c0                	xor    %eax,%eax
     b3f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     b43:	31 c0                	xor    %eax,%eax
     b45:	89 44 24 08          	mov    %eax,0x8(%esp)
     b49:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     b4d:	89 34 24             	mov    %esi,(%esp)
     b50:	e8 eb fd ff ff       	call   940 <gettoken>
        if(gettoken(ps, es, &q, &eq) != 'a')
     b55:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     b59:	89 34 24             	mov    %esi,(%esp)
        tok = gettoken(ps, es, 0, 0);
     b5c:	89 c7                	mov    %eax,%edi
        if(gettoken(ps, es, &q, &eq) != 'a')
     b5e:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     b61:	89 44 24 0c          	mov    %eax,0xc(%esp)
     b65:	8d 45 e0             	lea    -0x20(%ebp),%eax
     b68:	89 44 24 08          	mov    %eax,0x8(%esp)
     b6c:	e8 cf fd ff ff       	call   940 <gettoken>
     b71:	83 f8 61             	cmp    $0x61,%eax
     b74:	75 65                	jne    bdb <parseredirs+0xcb>
            panic("missing file for redirection");
        switch(tok){
     b76:	83 ff 3c             	cmp    $0x3c,%edi
     b79:	74 45                	je     bc0 <parseredirs+0xb0>
     b7b:	83 ff 3e             	cmp    $0x3e,%edi
     b7e:	66 90                	xchg   %ax,%ax
     b80:	74 05                	je     b87 <parseredirs+0x77>
     b82:	83 ff 2b             	cmp    $0x2b,%edi
     b85:	75 99                	jne    b20 <parseredirs+0x10>
                break;
            case '>':
                cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
                break;
            case '+':  // >>
                cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     b87:	ba 01 00 00 00       	mov    $0x1,%edx
     b8c:	b9 01 02 00 00       	mov    $0x201,%ecx
     b91:	89 54 24 10          	mov    %edx,0x10(%esp)
     b95:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
     b99:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     b9c:	89 44 24 08          	mov    %eax,0x8(%esp)
     ba0:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ba3:	89 44 24 04          	mov    %eax,0x4(%esp)
     ba7:	8b 45 08             	mov    0x8(%ebp),%eax
     baa:	89 04 24             	mov    %eax,(%esp)
     bad:	e8 4e fc ff ff       	call   800 <redircmd>
     bb2:	89 45 08             	mov    %eax,0x8(%ebp)
                break;
     bb5:	e9 66 ff ff ff       	jmp    b20 <parseredirs+0x10>
     bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     bc0:	31 ff                	xor    %edi,%edi
     bc2:	31 c0                	xor    %eax,%eax
     bc4:	89 7c 24 10          	mov    %edi,0x10(%esp)
     bc8:	89 44 24 0c          	mov    %eax,0xc(%esp)
     bcc:	eb cb                	jmp    b99 <parseredirs+0x89>
     bce:	66 90                	xchg   %ax,%ax
        }
    }
    return cmd;
}
     bd0:	8b 45 08             	mov    0x8(%ebp),%eax
     bd3:	83 c4 3c             	add    $0x3c,%esp
     bd6:	5b                   	pop    %ebx
     bd7:	5e                   	pop    %esi
     bd8:	5f                   	pop    %edi
     bd9:	5d                   	pop    %ebp
     bda:	c3                   	ret    
            panic("missing file for redirection");
     bdb:	c7 04 24 a5 17 00 00 	movl   $0x17a5,(%esp)
     be2:	e8 29 f8 ff ff       	call   410 <panic>
     be7:	89 f6                	mov    %esi,%esi
     be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000bf0 <parseexec>:
    return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     bf0:	55                   	push   %ebp
    char *q, *eq;
    int tok, argc;
    struct execcmd *cmd;
    struct cmd *ret;

    if(peek(ps, es, "("))
     bf1:	ba c5 17 00 00       	mov    $0x17c5,%edx
{
     bf6:	89 e5                	mov    %esp,%ebp
     bf8:	57                   	push   %edi
     bf9:	56                   	push   %esi
     bfa:	53                   	push   %ebx
     bfb:	83 ec 3c             	sub    $0x3c,%esp
     bfe:	8b 75 08             	mov    0x8(%ebp),%esi
     c01:	8b 7d 0c             	mov    0xc(%ebp),%edi
    if(peek(ps, es, "("))
     c04:	89 54 24 08          	mov    %edx,0x8(%esp)
     c08:	89 34 24             	mov    %esi,(%esp)
     c0b:	89 7c 24 04          	mov    %edi,0x4(%esp)
     c0f:	e8 8c fe ff ff       	call   aa0 <peek>
     c14:	85 c0                	test   %eax,%eax
     c16:	0f 85 9c 00 00 00    	jne    cb8 <parseexec+0xc8>
     c1c:	89 c3                	mov    %eax,%ebx
        return parseblock(ps, es);

    ret = execcmd();
     c1e:	e8 9d fb ff ff       	call   7c0 <execcmd>
    cmd = (struct execcmd*)ret;

    argc = 0;
    ret = parseredirs(ret, ps, es);
     c23:	89 7c 24 08          	mov    %edi,0x8(%esp)
     c27:	89 74 24 04          	mov    %esi,0x4(%esp)
     c2b:	89 04 24             	mov    %eax,(%esp)
    ret = execcmd();
     c2e:	89 45 d0             	mov    %eax,-0x30(%ebp)
    ret = parseredirs(ret, ps, es);
     c31:	e8 da fe ff ff       	call   b10 <parseredirs>
     c36:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     c39:	eb 1b                	jmp    c56 <parseexec+0x66>
     c3b:	90                   	nop
     c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cmd->argv[argc] = q;
        cmd->eargv[argc] = eq;
        argc++;
        if(argc >= MAXARGS)
            panic("too many args");
        ret = parseredirs(ret, ps, es);
     c40:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     c43:	89 7c 24 08          	mov    %edi,0x8(%esp)
     c47:	89 74 24 04          	mov    %esi,0x4(%esp)
     c4b:	89 04 24             	mov    %eax,(%esp)
     c4e:	e8 bd fe ff ff       	call   b10 <parseredirs>
     c53:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while(!peek(ps, es, "|)&;")){
     c56:	b8 dc 17 00 00       	mov    $0x17dc,%eax
     c5b:	89 44 24 08          	mov    %eax,0x8(%esp)
     c5f:	89 7c 24 04          	mov    %edi,0x4(%esp)
     c63:	89 34 24             	mov    %esi,(%esp)
     c66:	e8 35 fe ff ff       	call   aa0 <peek>
     c6b:	85 c0                	test   %eax,%eax
     c6d:	75 69                	jne    cd8 <parseexec+0xe8>
        if((tok=gettoken(ps, es, &q, &eq)) == 0)
     c6f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     c72:	89 44 24 0c          	mov    %eax,0xc(%esp)
     c76:	8d 45 e0             	lea    -0x20(%ebp),%eax
     c79:	89 44 24 08          	mov    %eax,0x8(%esp)
     c7d:	89 7c 24 04          	mov    %edi,0x4(%esp)
     c81:	89 34 24             	mov    %esi,(%esp)
     c84:	e8 b7 fc ff ff       	call   940 <gettoken>
     c89:	85 c0                	test   %eax,%eax
     c8b:	74 4b                	je     cd8 <parseexec+0xe8>
        if(tok != 'a')
     c8d:	83 f8 61             	cmp    $0x61,%eax
     c90:	75 65                	jne    cf7 <parseexec+0x107>
        cmd->argv[argc] = q;
     c92:	8b 45 e0             	mov    -0x20(%ebp),%eax
     c95:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c98:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
        cmd->eargv[argc] = eq;
     c9c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c9f:	89 44 9a 2c          	mov    %eax,0x2c(%edx,%ebx,4)
        argc++;
     ca3:	43                   	inc    %ebx
        if(argc >= MAXARGS)
     ca4:	83 fb 0a             	cmp    $0xa,%ebx
     ca7:	75 97                	jne    c40 <parseexec+0x50>
            panic("too many args");
     ca9:	c7 04 24 ce 17 00 00 	movl   $0x17ce,(%esp)
     cb0:	e8 5b f7 ff ff       	call   410 <panic>
     cb5:	8d 76 00             	lea    0x0(%esi),%esi
        return parseblock(ps, es);
     cb8:	89 7c 24 04          	mov    %edi,0x4(%esp)
     cbc:	89 34 24             	mov    %esi,(%esp)
     cbf:	e8 9c 01 00 00       	call   e60 <parseblock>
     cc4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    }
    cmd->argv[argc] = 0;
    cmd->eargv[argc] = 0;
    return ret;
}
     cc7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     cca:	83 c4 3c             	add    $0x3c,%esp
     ccd:	5b                   	pop    %ebx
     cce:	5e                   	pop    %esi
     ccf:	5f                   	pop    %edi
     cd0:	5d                   	pop    %ebp
     cd1:	c3                   	ret    
     cd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     cd8:	8b 45 d0             	mov    -0x30(%ebp),%eax
     cdb:	8d 04 98             	lea    (%eax,%ebx,4),%eax
    cmd->argv[argc] = 0;
     cde:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    cmd->eargv[argc] = 0;
     ce5:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
}
     cec:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     cef:	83 c4 3c             	add    $0x3c,%esp
     cf2:	5b                   	pop    %ebx
     cf3:	5e                   	pop    %esi
     cf4:	5f                   	pop    %edi
     cf5:	5d                   	pop    %ebp
     cf6:	c3                   	ret    
            panic("syntax");
     cf7:	c7 04 24 c7 17 00 00 	movl   $0x17c7,(%esp)
     cfe:	e8 0d f7 ff ff       	call   410 <panic>
     d03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d10 <parsepipe>:
{
     d10:	55                   	push   %ebp
     d11:	89 e5                	mov    %esp,%ebp
     d13:	83 ec 28             	sub    $0x28,%esp
     d16:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     d19:	8b 5d 08             	mov    0x8(%ebp),%ebx
     d1c:	89 75 f8             	mov    %esi,-0x8(%ebp)
     d1f:	8b 75 0c             	mov    0xc(%ebp),%esi
     d22:	89 7d fc             	mov    %edi,-0x4(%ebp)
    cmd = parseexec(ps, es);
     d25:	89 1c 24             	mov    %ebx,(%esp)
     d28:	89 74 24 04          	mov    %esi,0x4(%esp)
     d2c:	e8 bf fe ff ff       	call   bf0 <parseexec>
    if(peek(ps, es, "|")){
     d31:	b9 e1 17 00 00       	mov    $0x17e1,%ecx
     d36:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     d3a:	89 74 24 04          	mov    %esi,0x4(%esp)
     d3e:	89 1c 24             	mov    %ebx,(%esp)
    cmd = parseexec(ps, es);
     d41:	89 c7                	mov    %eax,%edi
    if(peek(ps, es, "|")){
     d43:	e8 58 fd ff ff       	call   aa0 <peek>
     d48:	85 c0                	test   %eax,%eax
     d4a:	75 14                	jne    d60 <parsepipe+0x50>
}
     d4c:	89 f8                	mov    %edi,%eax
     d4e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     d51:	8b 75 f8             	mov    -0x8(%ebp),%esi
     d54:	8b 7d fc             	mov    -0x4(%ebp),%edi
     d57:	89 ec                	mov    %ebp,%esp
     d59:	5d                   	pop    %ebp
     d5a:	c3                   	ret    
     d5b:	90                   	nop
     d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        gettoken(ps, es, 0, 0);
     d60:	31 d2                	xor    %edx,%edx
     d62:	31 c0                	xor    %eax,%eax
     d64:	89 54 24 08          	mov    %edx,0x8(%esp)
     d68:	89 74 24 04          	mov    %esi,0x4(%esp)
     d6c:	89 1c 24             	mov    %ebx,(%esp)
     d6f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     d73:	e8 c8 fb ff ff       	call   940 <gettoken>
        cmd = pipecmd(cmd, parsepipe(ps, es));
     d78:	89 74 24 04          	mov    %esi,0x4(%esp)
     d7c:	89 1c 24             	mov    %ebx,(%esp)
     d7f:	e8 8c ff ff ff       	call   d10 <parsepipe>
}
     d84:	8b 5d f4             	mov    -0xc(%ebp),%ebx
        cmd = pipecmd(cmd, parsepipe(ps, es));
     d87:	89 7d 08             	mov    %edi,0x8(%ebp)
}
     d8a:	8b 75 f8             	mov    -0x8(%ebp),%esi
     d8d:	8b 7d fc             	mov    -0x4(%ebp),%edi
        cmd = pipecmd(cmd, parsepipe(ps, es));
     d90:	89 45 0c             	mov    %eax,0xc(%ebp)
}
     d93:	89 ec                	mov    %ebp,%esp
     d95:	5d                   	pop    %ebp
        cmd = pipecmd(cmd, parsepipe(ps, es));
     d96:	e9 c5 fa ff ff       	jmp    860 <pipecmd>
     d9b:	90                   	nop
     d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000da0 <parseline>:
{
     da0:	55                   	push   %ebp
     da1:	89 e5                	mov    %esp,%ebp
     da3:	57                   	push   %edi
     da4:	56                   	push   %esi
     da5:	53                   	push   %ebx
     da6:	83 ec 1c             	sub    $0x1c,%esp
     da9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     dac:	8b 75 0c             	mov    0xc(%ebp),%esi
    cmd = parsepipe(ps, es);
     daf:	89 1c 24             	mov    %ebx,(%esp)
     db2:	89 74 24 04          	mov    %esi,0x4(%esp)
     db6:	e8 55 ff ff ff       	call   d10 <parsepipe>
     dbb:	89 c7                	mov    %eax,%edi
    while(peek(ps, es, "&")){
     dbd:	eb 23                	jmp    de2 <parseline+0x42>
     dbf:	90                   	nop
        gettoken(ps, es, 0, 0);
     dc0:	31 c0                	xor    %eax,%eax
     dc2:	89 44 24 0c          	mov    %eax,0xc(%esp)
     dc6:	31 c0                	xor    %eax,%eax
     dc8:	89 44 24 08          	mov    %eax,0x8(%esp)
     dcc:	89 74 24 04          	mov    %esi,0x4(%esp)
     dd0:	89 1c 24             	mov    %ebx,(%esp)
     dd3:	e8 68 fb ff ff       	call   940 <gettoken>
        cmd = backcmd(cmd);
     dd8:	89 3c 24             	mov    %edi,(%esp)
     ddb:	e8 20 fb ff ff       	call   900 <backcmd>
     de0:	89 c7                	mov    %eax,%edi
    while(peek(ps, es, "&")){
     de2:	b8 e3 17 00 00       	mov    $0x17e3,%eax
     de7:	89 44 24 08          	mov    %eax,0x8(%esp)
     deb:	89 74 24 04          	mov    %esi,0x4(%esp)
     def:	89 1c 24             	mov    %ebx,(%esp)
     df2:	e8 a9 fc ff ff       	call   aa0 <peek>
     df7:	85 c0                	test   %eax,%eax
     df9:	75 c5                	jne    dc0 <parseline+0x20>
    if(peek(ps, es, ";")){
     dfb:	b9 df 17 00 00       	mov    $0x17df,%ecx
     e00:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     e04:	89 74 24 04          	mov    %esi,0x4(%esp)
     e08:	89 1c 24             	mov    %ebx,(%esp)
     e0b:	e8 90 fc ff ff       	call   aa0 <peek>
     e10:	85 c0                	test   %eax,%eax
     e12:	75 0c                	jne    e20 <parseline+0x80>
}
     e14:	83 c4 1c             	add    $0x1c,%esp
     e17:	89 f8                	mov    %edi,%eax
     e19:	5b                   	pop    %ebx
     e1a:	5e                   	pop    %esi
     e1b:	5f                   	pop    %edi
     e1c:	5d                   	pop    %ebp
     e1d:	c3                   	ret    
     e1e:	66 90                	xchg   %ax,%ax
        gettoken(ps, es, 0, 0);
     e20:	31 d2                	xor    %edx,%edx
     e22:	31 c0                	xor    %eax,%eax
     e24:	89 54 24 08          	mov    %edx,0x8(%esp)
     e28:	89 74 24 04          	mov    %esi,0x4(%esp)
     e2c:	89 1c 24             	mov    %ebx,(%esp)
     e2f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     e33:	e8 08 fb ff ff       	call   940 <gettoken>
        cmd = listcmd(cmd, parseline(ps, es));
     e38:	89 74 24 04          	mov    %esi,0x4(%esp)
     e3c:	89 1c 24             	mov    %ebx,(%esp)
     e3f:	e8 5c ff ff ff       	call   da0 <parseline>
     e44:	89 7d 08             	mov    %edi,0x8(%ebp)
     e47:	89 45 0c             	mov    %eax,0xc(%ebp)
}
     e4a:	83 c4 1c             	add    $0x1c,%esp
     e4d:	5b                   	pop    %ebx
     e4e:	5e                   	pop    %esi
     e4f:	5f                   	pop    %edi
     e50:	5d                   	pop    %ebp
        cmd = listcmd(cmd, parseline(ps, es));
     e51:	e9 5a fa ff ff       	jmp    8b0 <listcmd>
     e56:	8d 76 00             	lea    0x0(%esi),%esi
     e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000e60 <parseblock>:
{
     e60:	55                   	push   %ebp
    if(!peek(ps, es, "("))
     e61:	b8 c5 17 00 00       	mov    $0x17c5,%eax
{
     e66:	89 e5                	mov    %esp,%ebp
     e68:	83 ec 28             	sub    $0x28,%esp
     e6b:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     e6e:	8b 5d 08             	mov    0x8(%ebp),%ebx
     e71:	89 75 f8             	mov    %esi,-0x8(%ebp)
     e74:	8b 75 0c             	mov    0xc(%ebp),%esi
    if(!peek(ps, es, "("))
     e77:	89 44 24 08          	mov    %eax,0x8(%esp)
{
     e7b:	89 7d fc             	mov    %edi,-0x4(%ebp)
    if(!peek(ps, es, "("))
     e7e:	89 1c 24             	mov    %ebx,(%esp)
     e81:	89 74 24 04          	mov    %esi,0x4(%esp)
     e85:	e8 16 fc ff ff       	call   aa0 <peek>
     e8a:	85 c0                	test   %eax,%eax
     e8c:	74 74                	je     f02 <parseblock+0xa2>
    gettoken(ps, es, 0, 0);
     e8e:	31 c9                	xor    %ecx,%ecx
     e90:	31 ff                	xor    %edi,%edi
     e92:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
     e96:	89 7c 24 08          	mov    %edi,0x8(%esp)
     e9a:	89 74 24 04          	mov    %esi,0x4(%esp)
     e9e:	89 1c 24             	mov    %ebx,(%esp)
     ea1:	e8 9a fa ff ff       	call   940 <gettoken>
    cmd = parseline(ps, es);
     ea6:	89 74 24 04          	mov    %esi,0x4(%esp)
     eaa:	89 1c 24             	mov    %ebx,(%esp)
     ead:	e8 ee fe ff ff       	call   da0 <parseline>
    if(!peek(ps, es, ")"))
     eb2:	89 74 24 04          	mov    %esi,0x4(%esp)
     eb6:	89 1c 24             	mov    %ebx,(%esp)
    cmd = parseline(ps, es);
     eb9:	89 c7                	mov    %eax,%edi
    if(!peek(ps, es, ")"))
     ebb:	b8 01 18 00 00       	mov    $0x1801,%eax
     ec0:	89 44 24 08          	mov    %eax,0x8(%esp)
     ec4:	e8 d7 fb ff ff       	call   aa0 <peek>
     ec9:	85 c0                	test   %eax,%eax
     ecb:	74 41                	je     f0e <parseblock+0xae>
    gettoken(ps, es, 0, 0);
     ecd:	31 d2                	xor    %edx,%edx
     ecf:	31 c0                	xor    %eax,%eax
     ed1:	89 54 24 08          	mov    %edx,0x8(%esp)
     ed5:	89 74 24 04          	mov    %esi,0x4(%esp)
     ed9:	89 1c 24             	mov    %ebx,(%esp)
     edc:	89 44 24 0c          	mov    %eax,0xc(%esp)
     ee0:	e8 5b fa ff ff       	call   940 <gettoken>
    cmd = parseredirs(cmd, ps, es);
     ee5:	89 74 24 08          	mov    %esi,0x8(%esp)
     ee9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     eed:	89 3c 24             	mov    %edi,(%esp)
     ef0:	e8 1b fc ff ff       	call   b10 <parseredirs>
}
     ef5:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     ef8:	8b 75 f8             	mov    -0x8(%ebp),%esi
     efb:	8b 7d fc             	mov    -0x4(%ebp),%edi
     efe:	89 ec                	mov    %ebp,%esp
     f00:	5d                   	pop    %ebp
     f01:	c3                   	ret    
        panic("parseblock");
     f02:	c7 04 24 e5 17 00 00 	movl   $0x17e5,(%esp)
     f09:	e8 02 f5 ff ff       	call   410 <panic>
        panic("syntax - missing )");
     f0e:	c7 04 24 f0 17 00 00 	movl   $0x17f0,(%esp)
     f15:	e8 f6 f4 ff ff       	call   410 <panic>
     f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000f20 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     f20:	55                   	push   %ebp
     f21:	89 e5                	mov    %esp,%ebp
     f23:	53                   	push   %ebx
     f24:	83 ec 14             	sub    $0x14,%esp
     f27:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct execcmd *ecmd;
    struct listcmd *lcmd;
    struct pipecmd *pcmd;
    struct redircmd *rcmd;

    if(cmd == 0)
     f2a:	85 db                	test   %ebx,%ebx
     f2c:	74 1d                	je     f4b <nulterminate+0x2b>
        return 0;

    switch(cmd->type){
     f2e:	83 3b 05             	cmpl   $0x5,(%ebx)
     f31:	77 18                	ja     f4b <nulterminate+0x2b>
     f33:	8b 03                	mov    (%ebx),%eax
     f35:	ff 24 85 64 18 00 00 	jmp    *0x1864(,%eax,4)
     f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            nulterminate(lcmd->right);
            break;

        case BACK:
            bcmd = (struct backcmd*)cmd;
            nulterminate(bcmd->cmd);
     f40:	8b 43 04             	mov    0x4(%ebx),%eax
     f43:	89 04 24             	mov    %eax,(%esp)
     f46:	e8 d5 ff ff ff       	call   f20 <nulterminate>
            break;
    }
    return cmd;
}
     f4b:	83 c4 14             	add    $0x14,%esp
     f4e:	89 d8                	mov    %ebx,%eax
     f50:	5b                   	pop    %ebx
     f51:	5d                   	pop    %ebp
     f52:	c3                   	ret    
     f53:	90                   	nop
     f54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            nulterminate(lcmd->left);
     f58:	8b 43 04             	mov    0x4(%ebx),%eax
     f5b:	89 04 24             	mov    %eax,(%esp)
     f5e:	e8 bd ff ff ff       	call   f20 <nulterminate>
            nulterminate(lcmd->right);
     f63:	8b 43 08             	mov    0x8(%ebx),%eax
     f66:	89 04 24             	mov    %eax,(%esp)
     f69:	e8 b2 ff ff ff       	call   f20 <nulterminate>
}
     f6e:	83 c4 14             	add    $0x14,%esp
     f71:	89 d8                	mov    %ebx,%eax
     f73:	5b                   	pop    %ebx
     f74:	5d                   	pop    %ebp
     f75:	c3                   	ret    
     f76:	8d 76 00             	lea    0x0(%esi),%esi
     f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            for(i=0; ecmd->argv[i]; i++)
     f80:	8b 4b 04             	mov    0x4(%ebx),%ecx
     f83:	8d 43 08             	lea    0x8(%ebx),%eax
     f86:	85 c9                	test   %ecx,%ecx
     f88:	74 c1                	je     f4b <nulterminate+0x2b>
     f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                *ecmd->eargv[i] = 0;
     f90:	8b 50 24             	mov    0x24(%eax),%edx
     f93:	83 c0 04             	add    $0x4,%eax
     f96:	c6 02 00             	movb   $0x0,(%edx)
            for(i=0; ecmd->argv[i]; i++)
     f99:	8b 50 fc             	mov    -0x4(%eax),%edx
     f9c:	85 d2                	test   %edx,%edx
     f9e:	75 f0                	jne    f90 <nulterminate+0x70>
}
     fa0:	83 c4 14             	add    $0x14,%esp
     fa3:	89 d8                	mov    %ebx,%eax
     fa5:	5b                   	pop    %ebx
     fa6:	5d                   	pop    %ebp
     fa7:	c3                   	ret    
     fa8:	90                   	nop
     fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            nulterminate(rcmd->cmd);
     fb0:	8b 43 04             	mov    0x4(%ebx),%eax
     fb3:	89 04 24             	mov    %eax,(%esp)
     fb6:	e8 65 ff ff ff       	call   f20 <nulterminate>
            *rcmd->efile = 0;
     fbb:	8b 43 0c             	mov    0xc(%ebx),%eax
     fbe:	c6 00 00             	movb   $0x0,(%eax)
}
     fc1:	83 c4 14             	add    $0x14,%esp
     fc4:	89 d8                	mov    %ebx,%eax
     fc6:	5b                   	pop    %ebx
     fc7:	5d                   	pop    %ebp
     fc8:	c3                   	ret    
     fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000fd0 <parsecmd>:
{
     fd0:	55                   	push   %ebp
     fd1:	89 e5                	mov    %esp,%ebp
     fd3:	56                   	push   %esi
     fd4:	53                   	push   %ebx
     fd5:	83 ec 10             	sub    $0x10,%esp
    es = s + strlen(s);
     fd8:	8b 5d 08             	mov    0x8(%ebp),%ebx
     fdb:	89 1c 24             	mov    %ebx,(%esp)
     fde:	e8 cd 00 00 00       	call   10b0 <strlen>
     fe3:	01 c3                	add    %eax,%ebx
    cmd = parseline(&s, es);
     fe5:	8d 45 08             	lea    0x8(%ebp),%eax
     fe8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     fec:	89 04 24             	mov    %eax,(%esp)
     fef:	e8 ac fd ff ff       	call   da0 <parseline>
    peek(&s, es, "");
     ff4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    cmd = parseline(&s, es);
     ff8:	89 c6                	mov    %eax,%esi
    peek(&s, es, "");
     ffa:	b8 8a 17 00 00       	mov    $0x178a,%eax
     fff:	89 44 24 08          	mov    %eax,0x8(%esp)
    1003:	8d 45 08             	lea    0x8(%ebp),%eax
    1006:	89 04 24             	mov    %eax,(%esp)
    1009:	e8 92 fa ff ff       	call   aa0 <peek>
    if(s != es){
    100e:	8b 45 08             	mov    0x8(%ebp),%eax
    1011:	39 d8                	cmp    %ebx,%eax
    1013:	75 11                	jne    1026 <parsecmd+0x56>
    nulterminate(cmd);
    1015:	89 34 24             	mov    %esi,(%esp)
    1018:	e8 03 ff ff ff       	call   f20 <nulterminate>
}
    101d:	83 c4 10             	add    $0x10,%esp
    1020:	89 f0                	mov    %esi,%eax
    1022:	5b                   	pop    %ebx
    1023:	5e                   	pop    %esi
    1024:	5d                   	pop    %ebp
    1025:	c3                   	ret    
        printf(2, "leftovers: %s\n", s);
    1026:	89 44 24 08          	mov    %eax,0x8(%esp)
    102a:	c7 44 24 04 03 18 00 	movl   $0x1803,0x4(%esp)
    1031:	00 
    1032:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    1039:	e8 a2 03 00 00       	call   13e0 <printf>
        panic("syntax");
    103e:	c7 04 24 c7 17 00 00 	movl   $0x17c7,(%esp)
    1045:	e8 c6 f3 ff ff       	call   410 <panic>
    104a:	66 90                	xchg   %ax,%ax
    104c:	66 90                	xchg   %ax,%ax
    104e:	66 90                	xchg   %ax,%ax

00001050 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    1050:	55                   	push   %ebp
    1051:	89 e5                	mov    %esp,%ebp
    1053:	8b 45 08             	mov    0x8(%ebp),%eax
    1056:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1059:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    105a:	89 c2                	mov    %eax,%edx
    105c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1060:	41                   	inc    %ecx
    1061:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    1065:	42                   	inc    %edx
    1066:	84 db                	test   %bl,%bl
    1068:	88 5a ff             	mov    %bl,-0x1(%edx)
    106b:	75 f3                	jne    1060 <strcpy+0x10>
    ;
  return os;
}
    106d:	5b                   	pop    %ebx
    106e:	5d                   	pop    %ebp
    106f:	c3                   	ret    

00001070 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1070:	55                   	push   %ebp
    1071:	89 e5                	mov    %esp,%ebp
    1073:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1076:	53                   	push   %ebx
    1077:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
    107a:	0f b6 01             	movzbl (%ecx),%eax
    107d:	0f b6 13             	movzbl (%ebx),%edx
    1080:	84 c0                	test   %al,%al
    1082:	75 18                	jne    109c <strcmp+0x2c>
    1084:	eb 22                	jmp    10a8 <strcmp+0x38>
    1086:	8d 76 00             	lea    0x0(%esi),%esi
    1089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    1090:	41                   	inc    %ecx
  while(*p && *p == *q)
    1091:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
    1094:	43                   	inc    %ebx
    1095:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
    1098:	84 c0                	test   %al,%al
    109a:	74 0c                	je     10a8 <strcmp+0x38>
    109c:	38 d0                	cmp    %dl,%al
    109e:	74 f0                	je     1090 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
    10a0:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
    10a1:	29 d0                	sub    %edx,%eax
}
    10a3:	5d                   	pop    %ebp
    10a4:	c3                   	ret    
    10a5:	8d 76 00             	lea    0x0(%esi),%esi
    10a8:	5b                   	pop    %ebx
    10a9:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    10ab:	29 d0                	sub    %edx,%eax
}
    10ad:	5d                   	pop    %ebp
    10ae:	c3                   	ret    
    10af:	90                   	nop

000010b0 <strlen>:

uint
strlen(const char *s)
{
    10b0:	55                   	push   %ebp
    10b1:	89 e5                	mov    %esp,%ebp
    10b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    10b6:	80 39 00             	cmpb   $0x0,(%ecx)
    10b9:	74 15                	je     10d0 <strlen+0x20>
    10bb:	31 d2                	xor    %edx,%edx
    10bd:	8d 76 00             	lea    0x0(%esi),%esi
    10c0:	42                   	inc    %edx
    10c1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    10c5:	89 d0                	mov    %edx,%eax
    10c7:	75 f7                	jne    10c0 <strlen+0x10>
    ;
  return n;
}
    10c9:	5d                   	pop    %ebp
    10ca:	c3                   	ret    
    10cb:	90                   	nop
    10cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
    10d0:	31 c0                	xor    %eax,%eax
}
    10d2:	5d                   	pop    %ebp
    10d3:	c3                   	ret    
    10d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    10da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000010e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    10e0:	55                   	push   %ebp
    10e1:	89 e5                	mov    %esp,%ebp
    10e3:	8b 55 08             	mov    0x8(%ebp),%edx
    10e6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    10e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    10ea:	8b 45 0c             	mov    0xc(%ebp),%eax
    10ed:	89 d7                	mov    %edx,%edi
    10ef:	fc                   	cld    
    10f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    10f2:	5f                   	pop    %edi
    10f3:	89 d0                	mov    %edx,%eax
    10f5:	5d                   	pop    %ebp
    10f6:	c3                   	ret    
    10f7:	89 f6                	mov    %esi,%esi
    10f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001100 <strchr>:

char*
strchr(const char *s, char c)
{
    1100:	55                   	push   %ebp
    1101:	89 e5                	mov    %esp,%ebp
    1103:	8b 45 08             	mov    0x8(%ebp),%eax
    1106:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    110a:	0f b6 10             	movzbl (%eax),%edx
    110d:	84 d2                	test   %dl,%dl
    110f:	74 1b                	je     112c <strchr+0x2c>
    if(*s == c)
    1111:	38 d1                	cmp    %dl,%cl
    1113:	75 0f                	jne    1124 <strchr+0x24>
    1115:	eb 17                	jmp    112e <strchr+0x2e>
    1117:	89 f6                	mov    %esi,%esi
    1119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    1120:	38 ca                	cmp    %cl,%dl
    1122:	74 0a                	je     112e <strchr+0x2e>
  for(; *s; s++)
    1124:	40                   	inc    %eax
    1125:	0f b6 10             	movzbl (%eax),%edx
    1128:	84 d2                	test   %dl,%dl
    112a:	75 f4                	jne    1120 <strchr+0x20>
      return (char*)s;
  return 0;
    112c:	31 c0                	xor    %eax,%eax
}
    112e:	5d                   	pop    %ebp
    112f:	c3                   	ret    

00001130 <gets>:

char*
gets(char *buf, int max)
{
    1130:	55                   	push   %ebp
    1131:	89 e5                	mov    %esp,%ebp
    1133:	57                   	push   %edi
    1134:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1135:	31 f6                	xor    %esi,%esi
{
    1137:	53                   	push   %ebx
    1138:	83 ec 3c             	sub    $0x3c,%esp
    113b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
    113e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
    1141:	eb 32                	jmp    1175 <gets+0x45>
    1143:	90                   	nop
    1144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
    1148:	ba 01 00 00 00       	mov    $0x1,%edx
    114d:	89 54 24 08          	mov    %edx,0x8(%esp)
    1151:	89 7c 24 04          	mov    %edi,0x4(%esp)
    1155:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    115c:	e8 2f 01 00 00       	call   1290 <read>
    if(cc < 1)
    1161:	85 c0                	test   %eax,%eax
    1163:	7e 19                	jle    117e <gets+0x4e>
      break;
    buf[i++] = c;
    1165:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1169:	43                   	inc    %ebx
    116a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
    116d:	3c 0a                	cmp    $0xa,%al
    116f:	74 1f                	je     1190 <gets+0x60>
    1171:	3c 0d                	cmp    $0xd,%al
    1173:	74 1b                	je     1190 <gets+0x60>
  for(i=0; i+1 < max; ){
    1175:	46                   	inc    %esi
    1176:	3b 75 0c             	cmp    0xc(%ebp),%esi
    1179:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    117c:	7c ca                	jl     1148 <gets+0x18>
      break;
  }
  buf[i] = '\0';
    117e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1181:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
    1184:	8b 45 08             	mov    0x8(%ebp),%eax
    1187:	83 c4 3c             	add    $0x3c,%esp
    118a:	5b                   	pop    %ebx
    118b:	5e                   	pop    %esi
    118c:	5f                   	pop    %edi
    118d:	5d                   	pop    %ebp
    118e:	c3                   	ret    
    118f:	90                   	nop
    1190:	8b 45 08             	mov    0x8(%ebp),%eax
    1193:	01 c6                	add    %eax,%esi
    1195:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    1198:	eb e4                	jmp    117e <gets+0x4e>
    119a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000011a0 <stat>:

int
stat(const char *n, struct stat *st)
{
    11a0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11a1:	31 c0                	xor    %eax,%eax
{
    11a3:	89 e5                	mov    %esp,%ebp
    11a5:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
    11a8:	89 44 24 04          	mov    %eax,0x4(%esp)
    11ac:	8b 45 08             	mov    0x8(%ebp),%eax
{
    11af:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    11b2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
    11b5:	89 04 24             	mov    %eax,(%esp)
    11b8:	e8 fb 00 00 00       	call   12b8 <open>
  if(fd < 0)
    11bd:	85 c0                	test   %eax,%eax
    11bf:	78 2f                	js     11f0 <stat+0x50>
    11c1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    11c3:	8b 45 0c             	mov    0xc(%ebp),%eax
    11c6:	89 1c 24             	mov    %ebx,(%esp)
    11c9:	89 44 24 04          	mov    %eax,0x4(%esp)
    11cd:	e8 fe 00 00 00       	call   12d0 <fstat>
  close(fd);
    11d2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    11d5:	89 c6                	mov    %eax,%esi
  close(fd);
    11d7:	e8 c4 00 00 00       	call   12a0 <close>
  return r;
}
    11dc:	89 f0                	mov    %esi,%eax
    11de:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    11e1:	8b 75 fc             	mov    -0x4(%ebp),%esi
    11e4:	89 ec                	mov    %ebp,%esp
    11e6:	5d                   	pop    %ebp
    11e7:	c3                   	ret    
    11e8:	90                   	nop
    11e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
    11f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    11f5:	eb e5                	jmp    11dc <stat+0x3c>
    11f7:	89 f6                	mov    %esi,%esi
    11f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001200 <atoi>:

int
atoi(const char *s)
{
    1200:	55                   	push   %ebp
    1201:	89 e5                	mov    %esp,%ebp
    1203:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1206:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1207:	0f be 11             	movsbl (%ecx),%edx
    120a:	88 d0                	mov    %dl,%al
    120c:	2c 30                	sub    $0x30,%al
    120e:	3c 09                	cmp    $0x9,%al
  n = 0;
    1210:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    1215:	77 1e                	ja     1235 <atoi+0x35>
    1217:	89 f6                	mov    %esi,%esi
    1219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    1220:	41                   	inc    %ecx
    1221:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1224:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    1228:	0f be 11             	movsbl (%ecx),%edx
    122b:	88 d3                	mov    %dl,%bl
    122d:	80 eb 30             	sub    $0x30,%bl
    1230:	80 fb 09             	cmp    $0x9,%bl
    1233:	76 eb                	jbe    1220 <atoi+0x20>
  return n;
}
    1235:	5b                   	pop    %ebx
    1236:	5d                   	pop    %ebp
    1237:	c3                   	ret    
    1238:	90                   	nop
    1239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001240 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1240:	55                   	push   %ebp
    1241:	89 e5                	mov    %esp,%ebp
    1243:	56                   	push   %esi
    1244:	8b 45 08             	mov    0x8(%ebp),%eax
    1247:	53                   	push   %ebx
    1248:	8b 5d 10             	mov    0x10(%ebp),%ebx
    124b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    124e:	85 db                	test   %ebx,%ebx
    1250:	7e 1a                	jle    126c <memmove+0x2c>
    1252:	31 d2                	xor    %edx,%edx
    1254:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    125a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
    1260:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    1264:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    1267:	42                   	inc    %edx
  while(n-- > 0)
    1268:	39 d3                	cmp    %edx,%ebx
    126a:	75 f4                	jne    1260 <memmove+0x20>
  return vdst;
}
    126c:	5b                   	pop    %ebx
    126d:	5e                   	pop    %esi
    126e:	5d                   	pop    %ebp
    126f:	c3                   	ret    

00001270 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1270:	b8 01 00 00 00       	mov    $0x1,%eax
    1275:	cd 40                	int    $0x40
    1277:	c3                   	ret    

00001278 <exit>:
SYSCALL(exit)
    1278:	b8 02 00 00 00       	mov    $0x2,%eax
    127d:	cd 40                	int    $0x40
    127f:	c3                   	ret    

00001280 <wait>:
SYSCALL(wait)
    1280:	b8 03 00 00 00       	mov    $0x3,%eax
    1285:	cd 40                	int    $0x40
    1287:	c3                   	ret    

00001288 <pipe>:
SYSCALL(pipe)
    1288:	b8 04 00 00 00       	mov    $0x4,%eax
    128d:	cd 40                	int    $0x40
    128f:	c3                   	ret    

00001290 <read>:
SYSCALL(read)
    1290:	b8 05 00 00 00       	mov    $0x5,%eax
    1295:	cd 40                	int    $0x40
    1297:	c3                   	ret    

00001298 <write>:
SYSCALL(write)
    1298:	b8 10 00 00 00       	mov    $0x10,%eax
    129d:	cd 40                	int    $0x40
    129f:	c3                   	ret    

000012a0 <close>:
SYSCALL(close)
    12a0:	b8 15 00 00 00       	mov    $0x15,%eax
    12a5:	cd 40                	int    $0x40
    12a7:	c3                   	ret    

000012a8 <kill>:
SYSCALL(kill)
    12a8:	b8 06 00 00 00       	mov    $0x6,%eax
    12ad:	cd 40                	int    $0x40
    12af:	c3                   	ret    

000012b0 <exec>:
SYSCALL(exec)
    12b0:	b8 07 00 00 00       	mov    $0x7,%eax
    12b5:	cd 40                	int    $0x40
    12b7:	c3                   	ret    

000012b8 <open>:
SYSCALL(open)
    12b8:	b8 0f 00 00 00       	mov    $0xf,%eax
    12bd:	cd 40                	int    $0x40
    12bf:	c3                   	ret    

000012c0 <mknod>:
SYSCALL(mknod)
    12c0:	b8 11 00 00 00       	mov    $0x11,%eax
    12c5:	cd 40                	int    $0x40
    12c7:	c3                   	ret    

000012c8 <unlink>:
SYSCALL(unlink)
    12c8:	b8 12 00 00 00       	mov    $0x12,%eax
    12cd:	cd 40                	int    $0x40
    12cf:	c3                   	ret    

000012d0 <fstat>:
SYSCALL(fstat)
    12d0:	b8 08 00 00 00       	mov    $0x8,%eax
    12d5:	cd 40                	int    $0x40
    12d7:	c3                   	ret    

000012d8 <link>:
SYSCALL(link)
    12d8:	b8 13 00 00 00       	mov    $0x13,%eax
    12dd:	cd 40                	int    $0x40
    12df:	c3                   	ret    

000012e0 <mkdir>:
SYSCALL(mkdir)
    12e0:	b8 14 00 00 00       	mov    $0x14,%eax
    12e5:	cd 40                	int    $0x40
    12e7:	c3                   	ret    

000012e8 <chdir>:
SYSCALL(chdir)
    12e8:	b8 09 00 00 00       	mov    $0x9,%eax
    12ed:	cd 40                	int    $0x40
    12ef:	c3                   	ret    

000012f0 <dup>:
SYSCALL(dup)
    12f0:	b8 0a 00 00 00       	mov    $0xa,%eax
    12f5:	cd 40                	int    $0x40
    12f7:	c3                   	ret    

000012f8 <getpid>:
SYSCALL(getpid)
    12f8:	b8 0b 00 00 00       	mov    $0xb,%eax
    12fd:	cd 40                	int    $0x40
    12ff:	c3                   	ret    

00001300 <sbrk>:
SYSCALL(sbrk)
    1300:	b8 0c 00 00 00       	mov    $0xc,%eax
    1305:	cd 40                	int    $0x40
    1307:	c3                   	ret    

00001308 <sleep>:
SYSCALL(sleep)
    1308:	b8 0d 00 00 00       	mov    $0xd,%eax
    130d:	cd 40                	int    $0x40
    130f:	c3                   	ret    

00001310 <uptime>:
SYSCALL(uptime)
    1310:	b8 0e 00 00 00       	mov    $0xe,%eax
    1315:	cd 40                	int    $0x40
    1317:	c3                   	ret    

00001318 <policy>:
SYSCALL(policy)
    1318:	b8 17 00 00 00       	mov    $0x17,%eax
    131d:	cd 40                	int    $0x40
    131f:	c3                   	ret    

00001320 <detach>:
SYSCALL(detach)
    1320:	b8 16 00 00 00       	mov    $0x16,%eax
    1325:	cd 40                	int    $0x40
    1327:	c3                   	ret    

00001328 <priority>:
SYSCALL(priority)
    1328:	b8 18 00 00 00       	mov    $0x18,%eax
    132d:	cd 40                	int    $0x40
    132f:	c3                   	ret    

00001330 <wait_stat>:
SYSCALL(wait_stat)
    1330:	b8 19 00 00 00       	mov    $0x19,%eax
    1335:	cd 40                	int    $0x40
    1337:	c3                   	ret    
    1338:	66 90                	xchg   %ax,%ax
    133a:	66 90                	xchg   %ax,%ax
    133c:	66 90                	xchg   %ax,%ax
    133e:	66 90                	xchg   %ax,%ax

00001340 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1340:	55                   	push   %ebp
    1341:	89 e5                	mov    %esp,%ebp
    1343:	57                   	push   %edi
    1344:	56                   	push   %esi
    1345:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1346:	89 d3                	mov    %edx,%ebx
    1348:	c1 eb 1f             	shr    $0x1f,%ebx
{
    134b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
    134e:	84 db                	test   %bl,%bl
{
    1350:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1353:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    1355:	74 79                	je     13d0 <printint+0x90>
    1357:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    135b:	74 73                	je     13d0 <printint+0x90>
    neg = 1;
    x = -xx;
    135d:	f7 d8                	neg    %eax
    neg = 1;
    135f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1366:	31 f6                	xor    %esi,%esi
    1368:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    136b:	eb 05                	jmp    1372 <printint+0x32>
    136d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1370:	89 fe                	mov    %edi,%esi
    1372:	31 d2                	xor    %edx,%edx
    1374:	f7 f1                	div    %ecx
    1376:	8d 7e 01             	lea    0x1(%esi),%edi
    1379:	0f b6 92 84 18 00 00 	movzbl 0x1884(%edx),%edx
  }while((x /= base) != 0);
    1380:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    1382:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    1385:	75 e9                	jne    1370 <printint+0x30>
  if(neg)
    1387:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    138a:	85 d2                	test   %edx,%edx
    138c:	74 08                	je     1396 <printint+0x56>
    buf[i++] = '-';
    138e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    1393:	8d 7e 02             	lea    0x2(%esi),%edi
    1396:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    139a:	8b 7d c0             	mov    -0x40(%ebp),%edi
    139d:	8d 76 00             	lea    0x0(%esi),%esi
    13a0:	0f b6 06             	movzbl (%esi),%eax
    13a3:	4e                   	dec    %esi
  write(fd, &c, 1);
    13a4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    13a8:	89 3c 24             	mov    %edi,(%esp)
    13ab:	88 45 d7             	mov    %al,-0x29(%ebp)
    13ae:	b8 01 00 00 00       	mov    $0x1,%eax
    13b3:	89 44 24 08          	mov    %eax,0x8(%esp)
    13b7:	e8 dc fe ff ff       	call   1298 <write>

  while(--i >= 0)
    13bc:	39 de                	cmp    %ebx,%esi
    13be:	75 e0                	jne    13a0 <printint+0x60>
    putc(fd, buf[i]);
}
    13c0:	83 c4 4c             	add    $0x4c,%esp
    13c3:	5b                   	pop    %ebx
    13c4:	5e                   	pop    %esi
    13c5:	5f                   	pop    %edi
    13c6:	5d                   	pop    %ebp
    13c7:	c3                   	ret    
    13c8:	90                   	nop
    13c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    13d0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    13d7:	eb 8d                	jmp    1366 <printint+0x26>
    13d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000013e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    13e0:	55                   	push   %ebp
    13e1:	89 e5                	mov    %esp,%ebp
    13e3:	57                   	push   %edi
    13e4:	56                   	push   %esi
    13e5:	53                   	push   %ebx
    13e6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    13e9:	8b 75 0c             	mov    0xc(%ebp),%esi
    13ec:	0f b6 1e             	movzbl (%esi),%ebx
    13ef:	84 db                	test   %bl,%bl
    13f1:	0f 84 d1 00 00 00    	je     14c8 <printf+0xe8>
  state = 0;
    13f7:	31 ff                	xor    %edi,%edi
    13f9:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
    13fa:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
    13fd:	89 fa                	mov    %edi,%edx
    13ff:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
    1402:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1405:	eb 41                	jmp    1448 <printf+0x68>
    1407:	89 f6                	mov    %esi,%esi
    1409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1410:	83 f8 25             	cmp    $0x25,%eax
    1413:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
    1416:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    141b:	74 1e                	je     143b <printf+0x5b>
  write(fd, &c, 1);
    141d:	b8 01 00 00 00       	mov    $0x1,%eax
    1422:	89 44 24 08          	mov    %eax,0x8(%esp)
    1426:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1429:	89 44 24 04          	mov    %eax,0x4(%esp)
    142d:	89 3c 24             	mov    %edi,(%esp)
    1430:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    1433:	e8 60 fe ff ff       	call   1298 <write>
    1438:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    143b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
    143c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    1440:	84 db                	test   %bl,%bl
    1442:	0f 84 80 00 00 00    	je     14c8 <printf+0xe8>
    if(state == 0){
    1448:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
    144a:	0f be cb             	movsbl %bl,%ecx
    144d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1450:	74 be                	je     1410 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1452:	83 fa 25             	cmp    $0x25,%edx
    1455:	75 e4                	jne    143b <printf+0x5b>
      if(c == 'd'){
    1457:	83 f8 64             	cmp    $0x64,%eax
    145a:	0f 84 f0 00 00 00    	je     1550 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1460:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    1466:	83 f9 70             	cmp    $0x70,%ecx
    1469:	74 65                	je     14d0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    146b:	83 f8 73             	cmp    $0x73,%eax
    146e:	0f 84 8c 00 00 00    	je     1500 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1474:	83 f8 63             	cmp    $0x63,%eax
    1477:	0f 84 13 01 00 00    	je     1590 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    147d:	83 f8 25             	cmp    $0x25,%eax
    1480:	0f 84 e2 00 00 00    	je     1568 <printf+0x188>
  write(fd, &c, 1);
    1486:	b8 01 00 00 00       	mov    $0x1,%eax
    148b:	46                   	inc    %esi
    148c:	89 44 24 08          	mov    %eax,0x8(%esp)
    1490:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1493:	89 44 24 04          	mov    %eax,0x4(%esp)
    1497:	89 3c 24             	mov    %edi,(%esp)
    149a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    149e:	e8 f5 fd ff ff       	call   1298 <write>
    14a3:	ba 01 00 00 00       	mov    $0x1,%edx
    14a8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    14ab:	89 54 24 08          	mov    %edx,0x8(%esp)
    14af:	89 44 24 04          	mov    %eax,0x4(%esp)
    14b3:	89 3c 24             	mov    %edi,(%esp)
    14b6:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    14b9:	e8 da fd ff ff       	call   1298 <write>
  for(i = 0; fmt[i]; i++){
    14be:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    14c2:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    14c4:	84 db                	test   %bl,%bl
    14c6:	75 80                	jne    1448 <printf+0x68>
    }
  }
}
    14c8:	83 c4 3c             	add    $0x3c,%esp
    14cb:	5b                   	pop    %ebx
    14cc:	5e                   	pop    %esi
    14cd:	5f                   	pop    %edi
    14ce:	5d                   	pop    %ebp
    14cf:	c3                   	ret    
        printint(fd, *ap, 16, 0);
    14d0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    14d7:	b9 10 00 00 00       	mov    $0x10,%ecx
    14dc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    14df:	89 f8                	mov    %edi,%eax
    14e1:	8b 13                	mov    (%ebx),%edx
    14e3:	e8 58 fe ff ff       	call   1340 <printint>
        ap++;
    14e8:	89 d8                	mov    %ebx,%eax
      state = 0;
    14ea:	31 d2                	xor    %edx,%edx
        ap++;
    14ec:	83 c0 04             	add    $0x4,%eax
    14ef:	89 45 d0             	mov    %eax,-0x30(%ebp)
    14f2:	e9 44 ff ff ff       	jmp    143b <printf+0x5b>
    14f7:	89 f6                	mov    %esi,%esi
    14f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
    1500:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1503:	8b 10                	mov    (%eax),%edx
        ap++;
    1505:	83 c0 04             	add    $0x4,%eax
    1508:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    150b:	85 d2                	test   %edx,%edx
    150d:	0f 84 aa 00 00 00    	je     15bd <printf+0x1dd>
        while(*s != 0){
    1513:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
    1516:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
    1518:	84 c0                	test   %al,%al
    151a:	74 27                	je     1543 <printf+0x163>
    151c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1520:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    1523:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
    1528:	43                   	inc    %ebx
  write(fd, &c, 1);
    1529:	89 44 24 08          	mov    %eax,0x8(%esp)
    152d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    1530:	89 44 24 04          	mov    %eax,0x4(%esp)
    1534:	89 3c 24             	mov    %edi,(%esp)
    1537:	e8 5c fd ff ff       	call   1298 <write>
        while(*s != 0){
    153c:	0f b6 03             	movzbl (%ebx),%eax
    153f:	84 c0                	test   %al,%al
    1541:	75 dd                	jne    1520 <printf+0x140>
      state = 0;
    1543:	31 d2                	xor    %edx,%edx
    1545:	e9 f1 fe ff ff       	jmp    143b <printf+0x5b>
    154a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    1550:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1557:	b9 0a 00 00 00       	mov    $0xa,%ecx
    155c:	e9 7b ff ff ff       	jmp    14dc <printf+0xfc>
    1561:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
    1568:	b9 01 00 00 00       	mov    $0x1,%ecx
    156d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1570:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    1574:	89 44 24 04          	mov    %eax,0x4(%esp)
    1578:	89 3c 24             	mov    %edi,(%esp)
    157b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    157e:	e8 15 fd ff ff       	call   1298 <write>
      state = 0;
    1583:	31 d2                	xor    %edx,%edx
    1585:	e9 b1 fe ff ff       	jmp    143b <printf+0x5b>
    158a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
    1590:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    1593:	8b 03                	mov    (%ebx),%eax
        ap++;
    1595:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    1598:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
    159b:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    159e:	b8 01 00 00 00       	mov    $0x1,%eax
    15a3:	89 44 24 08          	mov    %eax,0x8(%esp)
    15a7:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    15aa:	89 44 24 04          	mov    %eax,0x4(%esp)
    15ae:	e8 e5 fc ff ff       	call   1298 <write>
      state = 0;
    15b3:	31 d2                	xor    %edx,%edx
        ap++;
    15b5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    15b8:	e9 7e fe ff ff       	jmp    143b <printf+0x5b>
          s = "(null)";
    15bd:	bb 7c 18 00 00       	mov    $0x187c,%ebx
        while(*s != 0){
    15c2:	b0 28                	mov    $0x28,%al
    15c4:	e9 57 ff ff ff       	jmp    1520 <printf+0x140>
    15c9:	66 90                	xchg   %ax,%ax
    15cb:	66 90                	xchg   %ax,%ax
    15cd:	66 90                	xchg   %ax,%ax
    15cf:	90                   	nop

000015d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    15d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15d1:	a1 14 21 00 00       	mov    0x2114,%eax
{
    15d6:	89 e5                	mov    %esp,%ebp
    15d8:	57                   	push   %edi
    15d9:	56                   	push   %esi
    15da:	53                   	push   %ebx
    15db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    15de:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    15e1:	eb 0d                	jmp    15f0 <free+0x20>
    15e3:	90                   	nop
    15e4:	90                   	nop
    15e5:	90                   	nop
    15e6:	90                   	nop
    15e7:	90                   	nop
    15e8:	90                   	nop
    15e9:	90                   	nop
    15ea:	90                   	nop
    15eb:	90                   	nop
    15ec:	90                   	nop
    15ed:	90                   	nop
    15ee:	90                   	nop
    15ef:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15f0:	39 c8                	cmp    %ecx,%eax
    15f2:	8b 10                	mov    (%eax),%edx
    15f4:	73 32                	jae    1628 <free+0x58>
    15f6:	39 d1                	cmp    %edx,%ecx
    15f8:	72 04                	jb     15fe <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    15fa:	39 d0                	cmp    %edx,%eax
    15fc:	72 32                	jb     1630 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
    15fe:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1601:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1604:	39 fa                	cmp    %edi,%edx
    1606:	74 30                	je     1638 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1608:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    160b:	8b 50 04             	mov    0x4(%eax),%edx
    160e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1611:	39 f1                	cmp    %esi,%ecx
    1613:	74 3c                	je     1651 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1615:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
    1617:	5b                   	pop    %ebx
  freep = p;
    1618:	a3 14 21 00 00       	mov    %eax,0x2114
}
    161d:	5e                   	pop    %esi
    161e:	5f                   	pop    %edi
    161f:	5d                   	pop    %ebp
    1620:	c3                   	ret    
    1621:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1628:	39 d0                	cmp    %edx,%eax
    162a:	72 04                	jb     1630 <free+0x60>
    162c:	39 d1                	cmp    %edx,%ecx
    162e:	72 ce                	jb     15fe <free+0x2e>
{
    1630:	89 d0                	mov    %edx,%eax
    1632:	eb bc                	jmp    15f0 <free+0x20>
    1634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1638:	8b 7a 04             	mov    0x4(%edx),%edi
    163b:	01 fe                	add    %edi,%esi
    163d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1640:	8b 10                	mov    (%eax),%edx
    1642:	8b 12                	mov    (%edx),%edx
    1644:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1647:	8b 50 04             	mov    0x4(%eax),%edx
    164a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    164d:	39 f1                	cmp    %esi,%ecx
    164f:	75 c4                	jne    1615 <free+0x45>
    p->s.size += bp->s.size;
    1651:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
    1654:	a3 14 21 00 00       	mov    %eax,0x2114
    p->s.size += bp->s.size;
    1659:	01 ca                	add    %ecx,%edx
    165b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    165e:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1661:	89 10                	mov    %edx,(%eax)
}
    1663:	5b                   	pop    %ebx
    1664:	5e                   	pop    %esi
    1665:	5f                   	pop    %edi
    1666:	5d                   	pop    %ebp
    1667:	c3                   	ret    
    1668:	90                   	nop
    1669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001670 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1670:	55                   	push   %ebp
    1671:	89 e5                	mov    %esp,%ebp
    1673:	57                   	push   %edi
    1674:	56                   	push   %esi
    1675:	53                   	push   %ebx
    1676:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1679:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    167c:	8b 15 14 21 00 00    	mov    0x2114,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1682:	8d 78 07             	lea    0x7(%eax),%edi
    1685:	c1 ef 03             	shr    $0x3,%edi
    1688:	47                   	inc    %edi
  if((prevp = freep) == 0){
    1689:	85 d2                	test   %edx,%edx
    168b:	0f 84 8f 00 00 00    	je     1720 <malloc+0xb0>
    1691:	8b 02                	mov    (%edx),%eax
    1693:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1696:	39 cf                	cmp    %ecx,%edi
    1698:	76 66                	jbe    1700 <malloc+0x90>
    169a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    16a0:	bb 00 10 00 00       	mov    $0x1000,%ebx
    16a5:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    16a8:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    16af:	eb 10                	jmp    16c1 <malloc+0x51>
    16b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    16b8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    16ba:	8b 48 04             	mov    0x4(%eax),%ecx
    16bd:	39 f9                	cmp    %edi,%ecx
    16bf:	73 3f                	jae    1700 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    16c1:	39 05 14 21 00 00    	cmp    %eax,0x2114
    16c7:	89 c2                	mov    %eax,%edx
    16c9:	75 ed                	jne    16b8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    16cb:	89 34 24             	mov    %esi,(%esp)
    16ce:	e8 2d fc ff ff       	call   1300 <sbrk>
  if(p == (char*)-1)
    16d3:	83 f8 ff             	cmp    $0xffffffff,%eax
    16d6:	74 18                	je     16f0 <malloc+0x80>
  hp->s.size = nu;
    16d8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    16db:	83 c0 08             	add    $0x8,%eax
    16de:	89 04 24             	mov    %eax,(%esp)
    16e1:	e8 ea fe ff ff       	call   15d0 <free>
  return freep;
    16e6:	8b 15 14 21 00 00    	mov    0x2114,%edx
      if((p = morecore(nunits)) == 0)
    16ec:	85 d2                	test   %edx,%edx
    16ee:	75 c8                	jne    16b8 <malloc+0x48>
        return 0;
  }
}
    16f0:	83 c4 1c             	add    $0x1c,%esp
        return 0;
    16f3:	31 c0                	xor    %eax,%eax
}
    16f5:	5b                   	pop    %ebx
    16f6:	5e                   	pop    %esi
    16f7:	5f                   	pop    %edi
    16f8:	5d                   	pop    %ebp
    16f9:	c3                   	ret    
    16fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1700:	39 cf                	cmp    %ecx,%edi
    1702:	74 4c                	je     1750 <malloc+0xe0>
        p->s.size -= nunits;
    1704:	29 f9                	sub    %edi,%ecx
    1706:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1709:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    170c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    170f:	89 15 14 21 00 00    	mov    %edx,0x2114
}
    1715:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
    1718:	83 c0 08             	add    $0x8,%eax
}
    171b:	5b                   	pop    %ebx
    171c:	5e                   	pop    %esi
    171d:	5f                   	pop    %edi
    171e:	5d                   	pop    %ebp
    171f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    1720:	b8 18 21 00 00       	mov    $0x2118,%eax
    1725:	ba 18 21 00 00       	mov    $0x2118,%edx
    base.s.size = 0;
    172a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
    172c:	a3 14 21 00 00       	mov    %eax,0x2114
    base.s.size = 0;
    1731:	b8 18 21 00 00       	mov    $0x2118,%eax
    base.s.ptr = freep = prevp = &base;
    1736:	89 15 18 21 00 00    	mov    %edx,0x2118
    base.s.size = 0;
    173c:	89 0d 1c 21 00 00    	mov    %ecx,0x211c
    1742:	e9 53 ff ff ff       	jmp    169a <malloc+0x2a>
    1747:	89 f6                	mov    %esi,%esi
    1749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
    1750:	8b 08                	mov    (%eax),%ecx
    1752:	89 0a                	mov    %ecx,(%edx)
    1754:	eb b9                	jmp    170f <malloc+0x9f>
