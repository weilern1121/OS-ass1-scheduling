
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
      13:	0f 8f e2 00 00 00    	jg     fb <main+0xfb>
{
    static char buf[100];
    int fd;

    // Ensure that three file descriptors are open.
    while((fd = open("console", O_RDWR)) >= 0){
      19:	b9 02 00 00 00       	mov    $0x2,%ecx
      1e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
      22:	c7 04 24 e1 16 00 00 	movl   $0x16e1,(%esp)
      29:	e8 8a 11 00 00       	call   11b8 <open>
      2e:	85 c0                	test   %eax,%eax
      30:	79 de                	jns    10 <main+0x10>


    // from here
    int fd2;

    if((fd2 = open("path", O_RDWR)) >= 0){
      32:	ba 02 00 00 00       	mov    $0x2,%edx
      37:	89 54 24 04          	mov    %edx,0x4(%esp)
      3b:	c7 04 24 e9 16 00 00 	movl   $0x16e9,(%esp)
      42:	e8 71 11 00 00       	call   11b8 <open>
      47:	85 c0                	test   %eax,%eax
      49:	78 6f                	js     ba <main+0xba>
        if( read(fd2, PATH, sizeof(PATH)) < 0 ){
      4b:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
      52:	00 
      53:	c7 44 24 04 80 1e 00 	movl   $0x1e80,0x4(%esp)
      5a:	00 
      5b:	89 04 24             	mov    %eax,(%esp)
      5e:	e8 2d 11 00 00       	call   1190 <read>
      63:	85 c0                	test   %eax,%eax
      65:	79 53                	jns    ba <main+0xba>
            printf(1, "error: read from path file failed\n");
      67:	c7 44 24 04 2c 17 00 	movl   $0x172c,0x4(%esp)
      6e:	00 
      6f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      76:	e8 65 12 00 00       	call   12e0 <printf>
            exit(0);
      7b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      82:	e8 f1 10 00 00       	call   1178 <exit>
      87:	89 f6                	mov    %esi,%esi
      89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    // till here


    // Read and run input commands.
    while(getcmd(buf, sizeof(buf)) >= 0){
        if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      90:	80 3d 02 1e 00 00 20 	cmpb   $0x20,0x1e02
      97:	0f 84 8b 00 00 00    	je     128 <main+0x128>
      9d:	8d 76 00             	lea    0x0(%esi),%esi
int
fork1(void)
{
    int pid;

    pid = fork();
      a0:	e8 cb 10 00 00       	call   1170 <fork>
    if(pid == -1)
      a5:	83 f8 ff             	cmp    $0xffffffff,%eax
      a8:	74 45                	je     ef <main+0xef>
            buf[strlen(buf)-1] = 0;  // chop \n
            if(chdir(buf+3) < 0)
                printf(2, "cannot cd %s\n", buf+3);
            continue;
        }
        if(fork1() == 0)
      aa:	85 c0                	test   %eax,%eax
      ac:	74 66                	je     114 <main+0x114>
            runcmd(parsecmd(buf));
        wait(0);
      ae:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      b5:	e8 c6 10 00 00       	call   1180 <wait>
    }
    // till here


    // Read and run input commands.
    while(getcmd(buf, sizeof(buf)) >= 0){
      ba:	b8 64 00 00 00       	mov    $0x64,%eax
      bf:	89 44 24 04          	mov    %eax,0x4(%esp)
      c3:	c7 04 24 00 1e 00 00 	movl   $0x1e00,(%esp)
      ca:	e8 11 03 00 00       	call   3e0 <getcmd>
      cf:	85 c0                	test   %eax,%eax
      d1:	78 35                	js     108 <main+0x108>
        if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      d3:	80 3d 00 1e 00 00 63 	cmpb   $0x63,0x1e00
      da:	75 c4                	jne    a0 <main+0xa0>
      dc:	80 3d 01 1e 00 00 64 	cmpb   $0x64,0x1e01
      e3:	74 ab                	je     90 <main+0x90>
int
fork1(void)
{
    int pid;

    pid = fork();
      e5:	e8 86 10 00 00       	call   1170 <fork>
    if(pid == -1)
      ea:	83 f8 ff             	cmp    $0xffffffff,%eax
      ed:	75 bb                	jne    aa <main+0xaa>
        panic("fork");
      ef:	c7 04 24 6a 16 00 00 	movl   $0x166a,(%esp)
      f6:	e8 45 03 00 00       	call   440 <panic>
    int fd;

    // Ensure that three file descriptors are open.
    while((fd = open("console", O_RDWR)) >= 0){
        if(fd >= 3){
            close(fd);
      fb:	89 04 24             	mov    %eax,(%esp)
      fe:	e8 9d 10 00 00       	call   11a0 <close>
            break;
     103:	e9 2a ff ff ff       	jmp    32 <main+0x32>
        }
        if(fork1() == 0)
            runcmd(parsecmd(buf));
        wait(0);
    }
    exit(0);
     108:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     10f:	e8 64 10 00 00       	call   1178 <exit>
            if(chdir(buf+3) < 0)
                printf(2, "cannot cd %s\n", buf+3);
            continue;
        }
        if(fork1() == 0)
            runcmd(parsecmd(buf));
     114:	c7 04 24 00 1e 00 00 	movl   $0x1e00,(%esp)
     11b:	e8 a0 0d 00 00       	call   ec0 <parsecmd>
     120:	89 04 24             	mov    %eax,(%esp)
     123:	e8 48 03 00 00       	call   470 <runcmd>

    // Read and run input commands.
    while(getcmd(buf, sizeof(buf)) >= 0){
        if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
            // Chdir must be called by the parent, not the child.
            buf[strlen(buf)-1] = 0;  // chop \n
     128:	c7 04 24 00 1e 00 00 	movl   $0x1e00,(%esp)
     12f:	e8 7c 0e 00 00       	call   fb0 <strlen>
            if(chdir(buf+3) < 0)
     134:	c7 04 24 03 1e 00 00 	movl   $0x1e03,(%esp)

    // Read and run input commands.
    while(getcmd(buf, sizeof(buf)) >= 0){
        if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
            // Chdir must be called by the parent, not the child.
            buf[strlen(buf)-1] = 0;  // chop \n
     13b:	c6 80 ff 1d 00 00 00 	movb   $0x0,0x1dff(%eax)
            if(chdir(buf+3) < 0)
     142:	e8 a1 10 00 00       	call   11e8 <chdir>
     147:	85 c0                	test   %eax,%eax
     149:	0f 89 6b ff ff ff    	jns    ba <main+0xba>
                printf(2, "cannot cd %s\n", buf+3);
     14f:	c7 44 24 08 03 1e 00 	movl   $0x1e03,0x8(%esp)
     156:	00 
     157:	c7 44 24 04 ee 16 00 	movl   $0x16ee,0x4(%esp)
     15e:	00 
     15f:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     166:	e8 75 11 00 00       	call   12e0 <printf>
     16b:	e9 4a ff ff ff       	jmp    ba <main+0xba>

00000170 <swap>:
struct cmd *parsecmd(char*);
char PATH[512]; // YOAV ADD PATH ENV VAR

void
swap( int a , int b , char *str)
{
     170:	55                   	push   %ebp
     171:	89 e5                	mov    %esp,%ebp
     173:	8b 45 10             	mov    0x10(%ebp),%eax
     176:	53                   	push   %ebx
    char temp = str[a];
     177:	8b 55 08             	mov    0x8(%ebp),%edx
    str[a] = str[b];
     17a:	8b 5d 0c             	mov    0xc(%ebp),%ebx
char PATH[512]; // YOAV ADD PATH ENV VAR

void
swap( int a , int b , char *str)
{
    char temp = str[a];
     17d:	01 c2                	add    %eax,%edx
    str[a] = str[b];
     17f:	01 d8                	add    %ebx,%eax
char PATH[512]; // YOAV ADD PATH ENV VAR

void
swap( int a , int b , char *str)
{
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

void
reverse_string( char *str )
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
     19f:	e8 0c 0e 00 00       	call   fb0 <strlen>
     1a4:	8d 70 ff             	lea    -0x1(%eax),%esi
    int i , k = len;
    for( i = 0 ; i < len ; i++ )
     1a7:	85 f6                	test   %esi,%esi
     1a9:	7e 43                	jle    1ee <reverse_string+0x5e>

void
swap( int a , int b , char *str)
{
    char temp = str[a];
    str[a] = str[b];
     1ab:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
char PATH[512]; // YOAV ADD PATH ENV VAR

void
swap( int a , int b , char *str)
{
    char temp = str[a];
     1ae:	0f b6 13             	movzbl (%ebx),%edx
    int len = strlen( str ) - 1;
    int i , k = len;
    for( i = 0 ; i < len ; i++ )
    {
        swap( i , k , str );
        k--;
     1b1:	83 e8 02             	sub    $0x2,%eax

void
swap( int a , int b , char *str)
{
    char temp = str[a];
    str[a] = str[b];
     1b4:	0f b6 0f             	movzbl (%edi),%ecx
    int i , k = len;
    for( i = 0 ; i < len ; i++ )
    {
        swap( i , k , str );
        k--;
        if( k == len/2 )
     1b7:	d1 fe                	sar    %esi
     1b9:	39 f0                	cmp    %esi,%eax

void
swap( int a , int b , char *str)
{
    char temp = str[a];
    str[a] = str[b];
     1bb:	88 0b                	mov    %cl,(%ebx)
    str[b] = temp;
     1bd:	88 17                	mov    %dl,(%edi)
    int i , k = len;
    for( i = 0 ; i < len ; i++ )
    {
        swap( i , k , str );
        k--;
        if( k == len/2 )
     1bf:	74 2d                	je     1ee <reverse_string+0x5e>
     1c1:	8d 53 01             	lea    0x1(%ebx),%edx
     1c4:	eb 24                	jmp    1ea <reverse_string+0x5a>
     1c6:	8d 76 00             	lea    0x0(%esi),%esi
     1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
char PATH[512]; // YOAV ADD PATH ENV VAR

void
swap( int a , int b , char *str)
{
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
    int len = strlen( str ) - 1;
    int i , k = len;
    for( i = 0 ; i < len ; i++ )
    {
        swap( i , k , str );
        k--;
     1e5:	48                   	dec    %eax
        if( k == len/2 )
     1e6:	39 f0                	cmp    %esi,%eax
     1e8:	74 04                	je     1ee <reverse_string+0x5e>
void
reverse_string( char *str )
{
    int len = strlen( str ) - 1;
    int i , k = len;
    for( i = 0 ; i < len ; i++ )
     1ea:	85 c0                	test   %eax,%eax
     1ec:	75 e2                	jne    1d0 <reverse_string+0x40>
        swap( i , k , str );
        k--;
        if( k == len/2 )
            break;
    }
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

char*
strconcat (const char *first, const char *second, char* dest){
     200:	55                   	push   %ebp
     201:	89 e5                	mov    %esp,%ebp
     203:	56                   	push   %esi
     204:	8b 75 10             	mov    0x10(%ebp),%esi
     207:	53                   	push   %ebx
     208:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     20b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    //This func gets two strings and concatted them into dest.
    //NOTE - dest is already MALLOCed before this function call.
    char* output=dest;
    while((*dest++ = *first++) != 0)
     20e:	89 f2                	mov    %esi,%edx
     210:	43                   	inc    %ebx
     211:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
     215:	42                   	inc    %edx
     216:	84 c0                	test   %al,%al
     218:	88 42 ff             	mov    %al,-0x1(%edx)
     21b:	75 f3                	jne    210 <strconcat+0x10>
        ;
    dest--;
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
        ;
    return output;
}
     23d:	5b                   	pop    %ebx
     23e:	89 f0                	mov    %esi,%eax
     240:	5e                   	pop    %esi
     241:	5d                   	pop    %ebp
     242:	c3                   	ret    
     243:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <strcpyuntildelimiter>:


char*
strcpyuntildelimiter(char *s, const char *t, char delim)
{
     250:	55                   	push   %ebp
     251:	89 e5                	mov    %esp,%ebp
     253:	8b 55 0c             	mov    0xc(%ebp),%edx
     256:	56                   	push   %esi
     257:	0f b6 45 10          	movzbl 0x10(%ebp),%eax
     25b:	53                   	push   %ebx
     25c:	8b 75 08             	mov    0x8(%ebp),%esi
    //of him into s until the end of t or delimiter.
    //NOTE- the target string (s) is already MALLOCed before the function call
    char *os;

    os = s;
    while((*s = *t) != delim && (*s = *t) !=0)
     25f:	0f b6 0a             	movzbl (%edx),%ecx
     262:	38 c8                	cmp    %cl,%al
     264:	88 0e                	mov    %cl,(%esi)
     266:	74 2d                	je     295 <strcpyuntildelimiter+0x45>
     268:	0f b6 0a             	movzbl (%edx),%ecx
     26b:	84 c9                	test   %cl,%cl
     26d:	88 0e                	mov    %cl,(%esi)
     26f:	74 24                	je     295 <strcpyuntildelimiter+0x45>
     271:	89 f1                	mov    %esi,%ecx
     273:	eb 0c                	jmp    281 <strcpyuntildelimiter+0x31>
     275:	8d 76 00             	lea    0x0(%esi),%esi
     278:	0f b6 1a             	movzbl (%edx),%ebx
     27b:	84 db                	test   %bl,%bl
     27d:	88 19                	mov    %bl,(%ecx)
     27f:	74 0b                	je     28c <strcpyuntildelimiter+0x3c>
        s++,t++;
     281:	42                   	inc    %edx
    //of him into s until the end of t or delimiter.
    //NOTE- the target string (s) is already MALLOCed before the function call
    char *os;

    os = s;
    while((*s = *t) != delim && (*s = *t) !=0)
     282:	0f b6 1a             	movzbl (%edx),%ebx
        s++,t++;
     285:	41                   	inc    %ecx
    //of him into s until the end of t or delimiter.
    //NOTE- the target string (s) is already MALLOCed before the function call
    char *os;

    os = s;
    while((*s = *t) != delim && (*s = *t) !=0)
     286:	38 c3                	cmp    %al,%bl
     288:	88 19                	mov    %bl,(%ecx)
     28a:	75 ec                	jne    278 <strcpyuntildelimiter+0x28>
        s++,t++;
    //s--;
    *s='\0';
     28c:	c6 01 00             	movb   $0x0,(%ecx)
    return os;
}
     28f:	89 f0                	mov    %esi,%eax
     291:	5b                   	pop    %ebx
     292:	5e                   	pop    %esi
     293:	5d                   	pop    %ebp
     294:	c3                   	ret    
    //of him into s until the end of t or delimiter.
    //NOTE- the target string (s) is already MALLOCed before the function call
    char *os;

    os = s;
    while((*s = *t) != delim && (*s = *t) !=0)
     295:	89 f1                	mov    %esi,%ecx
     297:	eb f3                	jmp    28c <strcpyuntildelimiter+0x3c>
     299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002a0 <execWithPath>:
    return os;
}

int
execWithPath(char *path, char **argv)
{
     2a0:	55                   	push   %ebp
     2a1:	89 e5                	mov    %esp,%ebp
     2a3:	57                   	push   %edi
     2a4:	56                   	push   %esi
     2a5:	53                   	push   %ebx
     2a6:	83 ec 1c             	sub    $0x1c,%esp
    char *curr_path = malloc(strlen(PATH));
     2a9:	c7 04 24 80 1e 00 00 	movl   $0x1e80,(%esp)
     2b0:	e8 fb 0c 00 00       	call   fb0 <strlen>
     2b5:	89 04 24             	mov    %eax,(%esp)
     2b8:	e8 a3 12 00 00       	call   1560 <malloc>
    strcpy( curr_path , PATH );
     2bd:	ba 80 1e 00 00       	mov    $0x1e80,%edx
     2c2:	89 54 24 04          	mov    %edx,0x4(%esp)
}

int
execWithPath(char *path, char **argv)
{
    char *curr_path = malloc(strlen(PATH));
     2c6:	89 c3                	mov    %eax,%ebx
    strcpy( curr_path , PATH );
     2c8:	89 04 24             	mov    %eax,(%esp)
     2cb:	e8 70 0c 00 00       	call   f40 <strcpy>
    while( curr_path != NULL )
     2d0:	85 db                	test   %ebx,%ebx
     2d2:	0f 84 e4 00 00 00    	je     3bc <execWithPath+0x11c>
     2d8:	90                   	nop
     2d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    {
        //get the string until the delimiter
        char* str2= malloc(100);
     2e0:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
     2e7:	e8 74 12 00 00       	call   1560 <malloc>
     2ec:	89 c6                	mov    %eax,%esi
    //of him into s until the end of t or delimiter.
    //NOTE- the target string (s) is already MALLOCed before the function call
    char *os;

    os = s;
    while((*s = *t) != delim && (*s = *t) !=0)
     2ee:	0f b6 03             	movzbl (%ebx),%eax
     2f1:	3c 3a                	cmp    $0x3a,%al
     2f3:	88 06                	mov    %al,(%esi)
     2f5:	0f 84 da 00 00 00    	je     3d5 <execWithPath+0x135>
     2fb:	0f b6 03             	movzbl (%ebx),%eax
     2fe:	84 c0                	test   %al,%al
     300:	88 06                	mov    %al,(%esi)
     302:	0f 84 cd 00 00 00    	je     3d5 <execWithPath+0x135>
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
    //of him into s until the end of t or delimiter.
    //NOTE- the target string (s) is already MALLOCed before the function call
    char *os;

    os = s;
    while((*s = *t) != delim && (*s = *t) !=0)
     31a:	0f b6 11             	movzbl (%ecx),%edx
        s++,t++;
     31d:	40                   	inc    %eax
    //of him into s until the end of t or delimiter.
    //NOTE- the target string (s) is already MALLOCed before the function call
    char *os;

    os = s;
    while((*s = *t) != delim && (*s = *t) !=0)
     31e:	80 fa 3a             	cmp    $0x3a,%dl
     321:	88 10                	mov    %dl,(%eax)
     323:	75 eb                	jne    310 <execWithPath+0x70>
        s++,t++;
    //s--;
    *s='\0';
     325:	c6 00 00             	movb   $0x0,(%eax)
        char* str2= malloc(100);
        str2=strcpyuntildelimiter(str2,curr_path,':');
        //printf(2,"str2= %s \n",str2);

        //delete the first part until delimiter from th e path
        curr_path=strchr(curr_path,':');
     328:	b8 3a 00 00 00       	mov    $0x3a,%eax
     32d:	89 1c 24             	mov    %ebx,(%esp)
     330:	89 44 24 04          	mov    %eax,0x4(%esp)
     334:	e8 b7 0c 00 00       	call   ff0 <strchr>
        if(curr_path!=NULL)
            curr_path++;
        //get the concated string of the curr_path @ path (i.e the order)
        char* str3=malloc ((strlen(str2) + strlen(path) - 1));
     339:	89 34 24             	mov    %esi,(%esp)
        //printf(2,"str2= %s \n",str2);

        //delete the first part until delimiter from th e path
        curr_path=strchr(curr_path,':');
        if(curr_path!=NULL)
            curr_path++;
     33c:	83 f8 01             	cmp    $0x1,%eax
        char* str2= malloc(100);
        str2=strcpyuntildelimiter(str2,curr_path,':');
        //printf(2,"str2= %s \n",str2);

        //delete the first part until delimiter from th e path
        curr_path=strchr(curr_path,':');
     33f:	89 c3                	mov    %eax,%ebx
        if(curr_path!=NULL)
            curr_path++;
     341:	83 db ff             	sbb    $0xffffffff,%ebx
        //get the concated string of the curr_path @ path (i.e the order)
        char* str3=malloc ((strlen(str2) + strlen(path) - 1));
     344:	e8 67 0c 00 00       	call   fb0 <strlen>
     349:	89 c7                	mov    %eax,%edi
     34b:	8b 45 08             	mov    0x8(%ebp),%eax
     34e:	89 04 24             	mov    %eax,(%esp)
     351:	e8 5a 0c 00 00       	call   fb0 <strlen>
     356:	8d 44 07 ff          	lea    -0x1(%edi,%eax,1),%eax
     35a:	89 04 24             	mov    %eax,(%esp)
     35d:	e8 fe 11 00 00       	call   1560 <malloc>
     362:	89 f1                	mov    %esi,%ecx
     364:	89 c7                	mov    %eax,%edi
     366:	89 c2                	mov    %eax,%edx
     368:	90                   	nop
     369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
char*
strconcat (const char *first, const char *second, char* dest){
    //This func gets two strings and concatted them into dest.
    //NOTE - dest is already MALLOCed before this function call.
    char* output=dest;
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
        ;
    dest--;
    while((*dest++ = *second++) != 0)
     389:	41                   	inc    %ecx
     38a:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
     38e:	84 c0                	test   %al,%al
     390:	88 42 ff             	mov    %al,-0x1(%edx)
     393:	75 f3                	jne    388 <execWithPath+0xe8>
        //get the concated string of the curr_path @ path (i.e the order)
        char* str3=malloc ((strlen(str2) + strlen(path) - 1));
        str3=strconcat(str2,path,str3);
        //printf(2,"str3= %s \n",str3);

        exec( str3 , argv );
     395:	8b 45 0c             	mov    0xc(%ebp),%eax
     398:	89 3c 24             	mov    %edi,(%esp)
     39b:	89 44 24 04          	mov    %eax,0x4(%esp)
     39f:	e8 0c 0e 00 00       	call   11b0 <exec>
        // if got here- exec failed
        // than, we keep iterate on path and free concated path
        free(str2);
     3a4:	89 34 24             	mov    %esi,(%esp)
     3a7:	e8 14 11 00 00       	call   14c0 <free>
        free(str3);
     3ac:	89 3c 24             	mov    %edi,(%esp)
     3af:	e8 0c 11 00 00       	call   14c0 <free>
int
execWithPath(char *path, char **argv)
{
    char *curr_path = malloc(strlen(PATH));
    strcpy( curr_path , PATH );
    while( curr_path != NULL )
     3b4:	85 db                	test   %ebx,%ebx
     3b6:	0f 85 24 ff ff ff    	jne    2e0 <execWithPath+0x40>
        // if got here- exec failed
        // than, we keep iterate on path and free concated path
        free(str2);
        free(str3);
    }
    free(curr_path);
     3bc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     3c3:	e8 f8 10 00 00       	call   14c0 <free>
    return -1;
}
     3c8:	83 c4 1c             	add    $0x1c,%esp
     3cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     3d0:	5b                   	pop    %ebx
     3d1:	5e                   	pop    %esi
     3d2:	5f                   	pop    %edi
     3d3:	5d                   	pop    %ebp
     3d4:	c3                   	ret    
    //of him into s until the end of t or delimiter.
    //NOTE- the target string (s) is already MALLOCed before the function call
    char *os;

    os = s;
    while((*s = *t) != delim && (*s = *t) !=0)
     3d5:	89 f0                	mov    %esi,%eax
     3d7:	e9 49 ff ff ff       	jmp    325 <execWithPath+0x85>
     3dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003e0 <getcmd>:
    exit(0);
}

int
getcmd(char *buf, int nbuf)
{
     3e0:	55                   	push   %ebp
    printf(2, "$ ");
     3e1:	b8 40 16 00 00       	mov    $0x1640,%eax
    exit(0);
}

int
getcmd(char *buf, int nbuf)
{
     3e6:	89 e5                	mov    %esp,%ebp
     3e8:	83 ec 18             	sub    $0x18,%esp
     3eb:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     3ee:	8b 5d 08             	mov    0x8(%ebp),%ebx
     3f1:	89 75 fc             	mov    %esi,-0x4(%ebp)
     3f4:	8b 75 0c             	mov    0xc(%ebp),%esi
    printf(2, "$ ");
     3f7:	89 44 24 04          	mov    %eax,0x4(%esp)
     3fb:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     402:	e8 d9 0e 00 00       	call   12e0 <printf>
    memset(buf, 0, nbuf);
     407:	31 d2                	xor    %edx,%edx
     409:	89 74 24 08          	mov    %esi,0x8(%esp)
     40d:	89 54 24 04          	mov    %edx,0x4(%esp)
     411:	89 1c 24             	mov    %ebx,(%esp)
     414:	e8 b7 0b 00 00       	call   fd0 <memset>
    gets(buf, nbuf);
     419:	89 74 24 04          	mov    %esi,0x4(%esp)
     41d:	89 1c 24             	mov    %ebx,(%esp)
     420:	e8 fb 0b 00 00       	call   1020 <gets>
     425:	31 c0                	xor    %eax,%eax
    if(buf[0] == 0) // EOF
        return -1;
    return 0;
}
     427:	8b 75 fc             	mov    -0x4(%ebp),%esi
     42a:	80 3b 00             	cmpb   $0x0,(%ebx)
     42d:	8b 5d f8             	mov    -0x8(%ebp),%ebx
     430:	0f 94 c0             	sete   %al
     433:	89 ec                	mov    %ebp,%esp
     435:	f7 d8                	neg    %eax
     437:	5d                   	pop    %ebp
     438:	c3                   	ret    
     439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000440 <panic>:
    exit(0);
}

void
panic(char *s)
{
     440:	55                   	push   %ebp
     441:	89 e5                	mov    %esp,%ebp
     443:	83 ec 18             	sub    $0x18,%esp
    printf(2, "%s\n", s);
     446:	8b 45 08             	mov    0x8(%ebp),%eax
     449:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     450:	89 44 24 08          	mov    %eax,0x8(%esp)
     454:	b8 dd 16 00 00       	mov    $0x16dd,%eax
     459:	89 44 24 04          	mov    %eax,0x4(%esp)
     45d:	e8 7e 0e 00 00       	call   12e0 <printf>
    exit(0);
     462:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     469:	e8 0a 0d 00 00       	call   1178 <exit>
     46e:	66 90                	xchg   %ax,%ax

00000470 <runcmd>:
}

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
     470:	55                   	push   %ebp
     471:	89 e5                	mov    %esp,%ebp
     473:	56                   	push   %esi
     474:	53                   	push   %ebx
     475:	83 ec 20             	sub    $0x20,%esp
     478:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct execcmd *ecmd;
    struct listcmd *lcmd;
    struct pipecmd *pcmd;
    struct redircmd *rcmd;

    if(cmd == 0)
     47b:	85 db                	test   %ebx,%ebx
     47d:	0f 84 8d 00 00 00    	je     510 <runcmd+0xa0>
        exit(0);

    switch(cmd->type){
     483:	83 3b 05             	cmpl   $0x5,(%ebx)
     486:	0f 87 39 01 00 00    	ja     5c5 <runcmd+0x155>
     48c:	8b 03                	mov    (%ebx),%eax
     48e:	ff 24 85 fc 16 00 00 	jmp    *0x16fc(,%eax,4)
            runcmd(lcmd->right);
            break;

        case PIPE:
            pcmd = (struct pipecmd*)cmd;
            if(pipe(p) < 0)
     495:	8d 45 f0             	lea    -0x10(%ebp),%eax
     498:	89 04 24             	mov    %eax,(%esp)
     49b:	e8 e8 0c 00 00       	call   1188 <pipe>
     4a0:	85 c0                	test   %eax,%eax
     4a2:	0f 88 55 01 00 00    	js     5fd <runcmd+0x18d>
int
fork1(void)
{
    int pid;

    pid = fork();
     4a8:	e8 c3 0c 00 00       	call   1170 <fork>
    if(pid == -1)
     4ad:	83 f8 ff             	cmp    $0xffffffff,%eax
     4b0:	0f 84 1b 01 00 00    	je     5d1 <runcmd+0x161>

        case PIPE:
            pcmd = (struct pipecmd*)cmd;
            if(pipe(p) < 0)
                panic("pipe");
            if(fork1() == 0){
     4b6:	85 c0                	test   %eax,%eax
     4b8:	0f 84 4b 01 00 00    	je     609 <runcmd+0x199>
     4be:	66 90                	xchg   %ax,%ax
int
fork1(void)
{
    int pid;

    pid = fork();
     4c0:	e8 ab 0c 00 00       	call   1170 <fork>
    if(pid == -1)
     4c5:	83 f8 ff             	cmp    $0xffffffff,%eax
     4c8:	0f 84 03 01 00 00    	je     5d1 <runcmd+0x161>
                dup(p[1]);
                close(p[0]);
                close(p[1]);
                runcmd(pcmd->left);
            }
            if(fork1() == 0){
     4ce:	85 c0                	test   %eax,%eax
     4d0:	0f 84 6b 01 00 00    	je     641 <runcmd+0x1d1>
                dup(p[0]);
                close(p[0]);
                close(p[1]);
                runcmd(pcmd->right);
            }
            close(p[0]);
     4d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4d9:	89 04 24             	mov    %eax,(%esp)
     4dc:	e8 bf 0c 00 00       	call   11a0 <close>
            close(p[1]);
     4e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4e4:	89 04 24             	mov    %eax,(%esp)
     4e7:	e8 b4 0c 00 00       	call   11a0 <close>
            wait(0);
     4ec:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     4f3:	e8 88 0c 00 00       	call   1180 <wait>
            wait(0);
     4f8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     4ff:	e8 7c 0c 00 00       	call   1180 <wait>
     504:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     50a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
        case REDIR:
            rcmd = (struct redircmd*)cmd;
            close(rcmd->fd);
            if(open(rcmd->file, rcmd->mode) < 0){
                printf(2, "open %s failed\n", rcmd->file);
                exit(0);
     510:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     517:	e8 5c 0c 00 00       	call   1178 <exit>
int
fork1(void)
{
    int pid;

    pid = fork();
     51c:	e8 4f 0c 00 00       	call   1170 <fork>
    if(pid == -1)
     521:	83 f8 ff             	cmp    $0xffffffff,%eax
     524:	0f 84 a7 00 00 00    	je     5d1 <runcmd+0x161>
            wait(0);
            break;

        case BACK:
            bcmd = (struct backcmd*)cmd;
            if(fork1() == 0)
     52a:	85 c0                	test   %eax,%eax
     52c:	75 e2                	jne    510 <runcmd+0xa0>
     52e:	66 90                	xchg   %ax,%ax
     530:	eb 63                	jmp    595 <runcmd+0x125>
        default:
            panic("runcmd");

        case EXEC:
            ecmd = (struct execcmd*)cmd;
            if(ecmd->argv[0] == 0)
     532:	8b 43 04             	mov    0x4(%ebx),%eax
     535:	85 c0                	test   %eax,%eax
     537:	74 d7                	je     510 <runcmd+0xa0>
                exit(0);
            exec(ecmd->argv[0], ecmd->argv);
     539:	8d 73 04             	lea    0x4(%ebx),%esi
     53c:	89 74 24 04          	mov    %esi,0x4(%esp)
     540:	89 04 24             	mov    %eax,(%esp)
     543:	e8 68 0c 00 00       	call   11b0 <exec>
            // from here
            execWithPath(ecmd->argv[0], ecmd->argv);
     548:	89 74 24 04          	mov    %esi,0x4(%esp)
     54c:	8b 43 04             	mov    0x4(%ebx),%eax
     54f:	89 04 24             	mov    %eax,(%esp)
     552:	e8 49 fd ff ff       	call   2a0 <execWithPath>
            // till here
            printf(2, "exec %s failed\n", ecmd->argv[0]);
     557:	8b 43 04             	mov    0x4(%ebx),%eax
     55a:	c7 44 24 04 4a 16 00 	movl   $0x164a,0x4(%esp)
     561:	00 
     562:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     569:	89 44 24 08          	mov    %eax,0x8(%esp)
     56d:	e8 6e 0d 00 00       	call   12e0 <printf>
            break;
     572:	eb 9c                	jmp    510 <runcmd+0xa0>

        case REDIR:
            rcmd = (struct redircmd*)cmd;
            close(rcmd->fd);
     574:	8b 43 14             	mov    0x14(%ebx),%eax
     577:	89 04 24             	mov    %eax,(%esp)
     57a:	e8 21 0c 00 00       	call   11a0 <close>
            if(open(rcmd->file, rcmd->mode) < 0){
     57f:	8b 43 10             	mov    0x10(%ebx),%eax
     582:	89 44 24 04          	mov    %eax,0x4(%esp)
     586:	8b 43 08             	mov    0x8(%ebx),%eax
     589:	89 04 24             	mov    %eax,(%esp)
     58c:	e8 27 0c 00 00       	call   11b8 <open>
     591:	85 c0                	test   %eax,%eax
     593:	78 48                	js     5dd <runcmd+0x16d>
            break;

        case BACK:
            bcmd = (struct backcmd*)cmd;
            if(fork1() == 0)
                runcmd(bcmd->cmd);
     595:	8b 43 04             	mov    0x4(%ebx),%eax
     598:	89 04 24             	mov    %eax,(%esp)
     59b:	e8 d0 fe ff ff       	call   470 <runcmd>
int
fork1(void)
{
    int pid;

    pid = fork();
     5a0:	e8 cb 0b 00 00       	call   1170 <fork>
    if(pid == -1)
     5a5:	83 f8 ff             	cmp    $0xffffffff,%eax
     5a8:	74 27                	je     5d1 <runcmd+0x161>
            runcmd(rcmd->cmd);
            break;

        case LIST:
            lcmd = (struct listcmd*)cmd;
            if(fork1() == 0)
     5aa:	85 c0                	test   %eax,%eax
     5ac:	74 e7                	je     595 <runcmd+0x125>
                runcmd(lcmd->left);
            wait(0);
     5ae:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     5b5:	e8 c6 0b 00 00       	call   1180 <wait>
            runcmd(lcmd->right);
     5ba:	8b 43 08             	mov    0x8(%ebx),%eax
     5bd:	89 04 24             	mov    %eax,(%esp)
     5c0:	e8 ab fe ff ff       	call   470 <runcmd>
    if(cmd == 0)
        exit(0);

    switch(cmd->type){
        default:
            panic("runcmd");
     5c5:	c7 04 24 43 16 00 00 	movl   $0x1643,(%esp)
     5cc:	e8 6f fe ff ff       	call   440 <panic>
{
    int pid;

    pid = fork();
    if(pid == -1)
        panic("fork");
     5d1:	c7 04 24 6a 16 00 00 	movl   $0x166a,(%esp)
     5d8:	e8 63 fe ff ff       	call   440 <panic>

        case REDIR:
            rcmd = (struct redircmd*)cmd;
            close(rcmd->fd);
            if(open(rcmd->file, rcmd->mode) < 0){
                printf(2, "open %s failed\n", rcmd->file);
     5dd:	8b 43 08             	mov    0x8(%ebx),%eax
     5e0:	c7 44 24 04 5a 16 00 	movl   $0x165a,0x4(%esp)
     5e7:	00 
     5e8:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     5ef:	89 44 24 08          	mov    %eax,0x8(%esp)
     5f3:	e8 e8 0c 00 00       	call   12e0 <printf>
     5f8:	e9 13 ff ff ff       	jmp    510 <runcmd+0xa0>
            break;

        case PIPE:
            pcmd = (struct pipecmd*)cmd;
            if(pipe(p) < 0)
                panic("pipe");
     5fd:	c7 04 24 6f 16 00 00 	movl   $0x166f,(%esp)
     604:	e8 37 fe ff ff       	call   440 <panic>
            if(fork1() == 0){
                close(1);
     609:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     610:	e8 8b 0b 00 00       	call   11a0 <close>
                dup(p[1]);
     615:	8b 45 f4             	mov    -0xc(%ebp),%eax
     618:	89 04 24             	mov    %eax,(%esp)
     61b:	e8 d0 0b 00 00       	call   11f0 <dup>
                close(p[0]);
     620:	8b 45 f0             	mov    -0x10(%ebp),%eax
     623:	89 04 24             	mov    %eax,(%esp)
     626:	e8 75 0b 00 00       	call   11a0 <close>
                close(p[1]);
     62b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     62e:	89 04 24             	mov    %eax,(%esp)
     631:	e8 6a 0b 00 00       	call   11a0 <close>
                runcmd(pcmd->left);
     636:	8b 43 04             	mov    0x4(%ebx),%eax
     639:	89 04 24             	mov    %eax,(%esp)
     63c:	e8 2f fe ff ff       	call   470 <runcmd>
            }
            if(fork1() == 0){
                close(0);
     641:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     648:	e8 53 0b 00 00       	call   11a0 <close>
                dup(p[0]);
     64d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     650:	89 04 24             	mov    %eax,(%esp)
     653:	e8 98 0b 00 00       	call   11f0 <dup>
                close(p[0]);
     658:	8b 45 f0             	mov    -0x10(%ebp),%eax
     65b:	89 04 24             	mov    %eax,(%esp)
     65e:	e8 3d 0b 00 00       	call   11a0 <close>
                close(p[1]);
     663:	8b 45 f4             	mov    -0xc(%ebp),%eax
     666:	89 04 24             	mov    %eax,(%esp)
     669:	e8 32 0b 00 00       	call   11a0 <close>
                runcmd(pcmd->right);
     66e:	8b 43 08             	mov    0x8(%ebx),%eax
     671:	89 04 24             	mov    %eax,(%esp)
     674:	e8 f7 fd ff ff       	call   470 <runcmd>
     679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000680 <fork1>:
    exit(0);
}

int
fork1(void)
{
     680:	55                   	push   %ebp
     681:	89 e5                	mov    %esp,%ebp
     683:	83 ec 18             	sub    $0x18,%esp
    int pid;

    pid = fork();
     686:	e8 e5 0a 00 00       	call   1170 <fork>
    if(pid == -1)
     68b:	83 f8 ff             	cmp    $0xffffffff,%eax
     68e:	74 02                	je     692 <fork1+0x12>
        panic("fork");
    return pid;
}
     690:	c9                   	leave  
     691:	c3                   	ret    
{
    int pid;

    pid = fork();
    if(pid == -1)
        panic("fork");
     692:	c7 04 24 6a 16 00 00 	movl   $0x166a,(%esp)
     699:	e8 a2 fd ff ff       	call   440 <panic>
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
     6ae:	e8 ad 0e 00 00       	call   1560 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     6b3:	31 d2                	xor    %edx,%edx
     6b5:	89 54 24 04          	mov    %edx,0x4(%esp)
struct cmd*
execcmd(void)
{
    struct execcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     6b9:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     6bb:	b8 54 00 00 00       	mov    $0x54,%eax
     6c0:	89 1c 24             	mov    %ebx,(%esp)
     6c3:	89 44 24 08          	mov    %eax,0x8(%esp)
     6c7:	e8 04 09 00 00       	call   fd0 <memset>
    cmd->type = EXEC;
    return (struct cmd*)cmd;
}
     6cc:	89 d8                	mov    %ebx,%eax
{
    struct execcmd *cmd;

    cmd = malloc(sizeof(*cmd));
    memset(cmd, 0, sizeof(*cmd));
    cmd->type = EXEC;
     6ce:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
    return (struct cmd*)cmd;
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
     6ee:	e8 6d 0e 00 00       	call   1560 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     6f3:	31 d2                	xor    %edx,%edx
     6f5:	89 54 24 04          	mov    %edx,0x4(%esp)
struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
    struct redircmd *cmd;

    cmd = malloc(sizeof(*cmd));
     6f9:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     6fb:	b8 18 00 00 00       	mov    $0x18,%eax
     700:	89 1c 24             	mov    %ebx,(%esp)
     703:	89 44 24 08          	mov    %eax,0x8(%esp)
     707:	e8 c4 08 00 00       	call   fd0 <memset>
    cmd->type = REDIR;
    cmd->cmd = subcmd;
     70c:	8b 45 08             	mov    0x8(%ebp),%eax
{
    struct redircmd *cmd;

    cmd = malloc(sizeof(*cmd));
    memset(cmd, 0, sizeof(*cmd));
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
     74e:	e8 0d 0e 00 00       	call   1560 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     753:	31 d2                	xor    %edx,%edx
     755:	89 54 24 04          	mov    %edx,0x4(%esp)
struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
    struct pipecmd *cmd;

    cmd = malloc(sizeof(*cmd));
     759:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     75b:	b8 0c 00 00 00       	mov    $0xc,%eax
     760:	89 1c 24             	mov    %ebx,(%esp)
     763:	89 44 24 08          	mov    %eax,0x8(%esp)
     767:	e8 64 08 00 00       	call   fd0 <memset>
    cmd->type = PIPE;
    cmd->left = left;
     76c:	8b 45 08             	mov    0x8(%ebp),%eax
{
    struct pipecmd *cmd;

    cmd = malloc(sizeof(*cmd));
    memset(cmd, 0, sizeof(*cmd));
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
     79e:	e8 bd 0d 00 00       	call   1560 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     7a3:	31 d2                	xor    %edx,%edx
     7a5:	89 54 24 04          	mov    %edx,0x4(%esp)
struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
    struct listcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     7a9:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     7ab:	b8 0c 00 00 00       	mov    $0xc,%eax
     7b0:	89 1c 24             	mov    %ebx,(%esp)
     7b3:	89 44 24 08          	mov    %eax,0x8(%esp)
     7b7:	e8 14 08 00 00       	call   fd0 <memset>
    cmd->type = LIST;
    cmd->left = left;
     7bc:	8b 45 08             	mov    0x8(%ebp),%eax
{
    struct listcmd *cmd;

    cmd = malloc(sizeof(*cmd));
    memset(cmd, 0, sizeof(*cmd));
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
     7ee:	e8 6d 0d 00 00       	call   1560 <malloc>
    memset(cmd, 0, sizeof(*cmd));
     7f3:	31 d2                	xor    %edx,%edx
     7f5:	89 54 24 04          	mov    %edx,0x4(%esp)
struct cmd*
backcmd(struct cmd *subcmd)
{
    struct backcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     7f9:	89 c3                	mov    %eax,%ebx
    memset(cmd, 0, sizeof(*cmd));
     7fb:	b8 08 00 00 00       	mov    $0x8,%eax
     800:	89 1c 24             	mov    %ebx,(%esp)
     803:	89 44 24 08          	mov    %eax,0x8(%esp)
     807:	e8 c4 07 00 00       	call   fd0 <memset>
    cmd->type = BACK;
    cmd->cmd = subcmd;
     80c:	8b 45 08             	mov    0x8(%ebp),%eax
{
    struct backcmd *cmd;

    cmd = malloc(sizeof(*cmd));
    memset(cmd, 0, sizeof(*cmd));
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
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     82c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     82f:	8b 75 10             	mov    0x10(%ebp),%esi
    char *s;
    int ret;

    s = *ps;
     832:	8b 38                	mov    (%eax),%edi
    while(s < es && strchr(whitespace, *s))
     834:	39 df                	cmp    %ebx,%edi
     836:	72 11                	jb     849 <gettoken+0x29>
     838:	eb 26                	jmp    860 <gettoken+0x40>
     83a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s++;
     840:	47                   	inc    %edi
{
    char *s;
    int ret;

    s = *ps;
    while(s < es && strchr(whitespace, *s))
     841:	39 fb                	cmp    %edi,%ebx
     843:	0f 84 ef 00 00 00    	je     938 <gettoken+0x118>
     849:	0f be 07             	movsbl (%edi),%eax
     84c:	c7 04 24 e4 1d 00 00 	movl   $0x1de4,(%esp)
     853:	89 44 24 04          	mov    %eax,0x4(%esp)
     857:	e8 94 07 00 00       	call   ff0 <strchr>
     85c:	85 c0                	test   %eax,%eax
     85e:	75 e0                	jne    840 <gettoken+0x20>
        s++;
    if(q)
     860:	85 f6                	test   %esi,%esi
     862:	74 02                	je     866 <gettoken+0x46>
        *q = s;
     864:	89 3e                	mov    %edi,(%esi)
    ret = *s;
     866:	0f be 37             	movsbl (%edi),%esi
     869:	89 f1                	mov    %esi,%ecx
     86b:	89 f0                	mov    %esi,%eax
    switch(*s){
     86d:	80 f9 29             	cmp    $0x29,%cl
     870:	7f 56                	jg     8c8 <gettoken+0xa8>
     872:	80 f9 28             	cmp    $0x28,%cl
     875:	7d 5c                	jge    8d3 <gettoken+0xb3>
     877:	84 c9                	test   %cl,%cl
     879:	0f 85 e1 00 00 00    	jne    960 <gettoken+0x140>
            ret = 'a';
            while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
                s++;
            break;
    }
    if(eq)
     87f:	8b 55 14             	mov    0x14(%ebp),%edx
     882:	85 d2                	test   %edx,%edx
     884:	74 05                	je     88b <gettoken+0x6b>
        *eq = s;
     886:	8b 45 14             	mov    0x14(%ebp),%eax
     889:	89 38                	mov    %edi,(%eax)

    while(s < es && strchr(whitespace, *s))
     88b:	39 fb                	cmp    %edi,%ebx
     88d:	77 0e                	ja     89d <gettoken+0x7d>
     88f:	eb 23                	jmp    8b4 <gettoken+0x94>
     891:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s++;
     898:	47                   	inc    %edi
            break;
    }
    if(eq)
        *eq = s;

    while(s < es && strchr(whitespace, *s))
     899:	39 fb                	cmp    %edi,%ebx
     89b:	74 17                	je     8b4 <gettoken+0x94>
     89d:	0f be 07             	movsbl (%edi),%eax
     8a0:	c7 04 24 e4 1d 00 00 	movl   $0x1de4,(%esp)
     8a7:	89 44 24 04          	mov    %eax,0x4(%esp)
     8ab:	e8 40 07 00 00       	call   ff0 <strchr>
     8b0:	85 c0                	test   %eax,%eax
     8b2:	75 e4                	jne    898 <gettoken+0x78>
        s++;
    *ps = s;
     8b4:	8b 45 08             	mov    0x8(%ebp),%eax
     8b7:	89 38                	mov    %edi,(%eax)
    return ret;
}
     8b9:	83 c4 1c             	add    $0x1c,%esp
     8bc:	89 f0                	mov    %esi,%eax
     8be:	5b                   	pop    %ebx
     8bf:	5e                   	pop    %esi
     8c0:	5f                   	pop    %edi
     8c1:	5d                   	pop    %ebp
     8c2:	c3                   	ret    
     8c3:	90                   	nop
     8c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(s < es && strchr(whitespace, *s))
        s++;
    if(q)
        *q = s;
    ret = *s;
    switch(*s){
     8c8:	80 f9 3e             	cmp    $0x3e,%cl
     8cb:	75 13                	jne    8e0 <gettoken+0xc0>
        case '<':
            s++;
            break;
        case '>':
            s++;
            if(*s == '>'){
     8cd:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
     8d1:	74 7d                	je     950 <gettoken+0x130>
        case '&':
        case '<':
            s++;
            break;
        case '>':
            s++;
     8d3:	47                   	inc    %edi
     8d4:	eb a9                	jmp    87f <gettoken+0x5f>
     8d6:	8d 76 00             	lea    0x0(%esi),%esi
     8d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    while(s < es && strchr(whitespace, *s))
        s++;
    if(q)
        *q = s;
    ret = *s;
    switch(*s){
     8e0:	7f 5e                	jg     940 <gettoken+0x120>
     8e2:	80 e9 3b             	sub    $0x3b,%cl
     8e5:	80 f9 01             	cmp    $0x1,%cl
     8e8:	76 e9                	jbe    8d3 <gettoken+0xb3>
                s++;
            }
            break;
        default:
            ret = 'a';
            while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     8ea:	39 fb                	cmp    %edi,%ebx
     8ec:	77 29                	ja     917 <gettoken+0xf7>
     8ee:	66 90                	xchg   %ax,%ax
     8f0:	eb 7b                	jmp    96d <gettoken+0x14d>
     8f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     8f8:	0f be 07             	movsbl (%edi),%eax
     8fb:	c7 04 24 dc 1d 00 00 	movl   $0x1ddc,(%esp)
     902:	89 44 24 04          	mov    %eax,0x4(%esp)
     906:	e8 e5 06 00 00       	call   ff0 <strchr>
     90b:	85 c0                	test   %eax,%eax
     90d:	75 1c                	jne    92b <gettoken+0x10b>
                s++;
     90f:	47                   	inc    %edi
                s++;
            }
            break;
        default:
            ret = 'a';
            while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     910:	39 fb                	cmp    %edi,%ebx
     912:	74 57                	je     96b <gettoken+0x14b>
     914:	0f be 07             	movsbl (%edi),%eax
     917:	89 44 24 04          	mov    %eax,0x4(%esp)
     91b:	c7 04 24 e4 1d 00 00 	movl   $0x1de4,(%esp)
     922:	e8 c9 06 00 00       	call   ff0 <strchr>
     927:	85 c0                	test   %eax,%eax
     929:	74 cd                	je     8f8 <gettoken+0xd8>
                ret = '+';
                s++;
            }
            break;
        default:
            ret = 'a';
     92b:	be 61 00 00 00       	mov    $0x61,%esi
     930:	e9 4a ff ff ff       	jmp    87f <gettoken+0x5f>
     935:	8d 76 00             	lea    0x0(%esi),%esi
     938:	89 df                	mov    %ebx,%edi
     93a:	e9 21 ff ff ff       	jmp    860 <gettoken+0x40>
     93f:	90                   	nop
    while(s < es && strchr(whitespace, *s))
        s++;
    if(q)
        *q = s;
    ret = *s;
    switch(*s){
     940:	80 f9 7c             	cmp    $0x7c,%cl
     943:	75 a5                	jne    8ea <gettoken+0xca>
        case '&':
        case '<':
            s++;
            break;
        case '>':
            s++;
     945:	47                   	inc    %edi
     946:	e9 34 ff ff ff       	jmp    87f <gettoken+0x5f>
     94b:	90                   	nop
     94c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            if(*s == '>'){
                ret = '+';
                s++;
     950:	83 c7 02             	add    $0x2,%edi
            s++;
            break;
        case '>':
            s++;
            if(*s == '>'){
                ret = '+';
     953:	be 2b 00 00 00       	mov    $0x2b,%esi
     958:	e9 22 ff ff ff       	jmp    87f <gettoken+0x5f>
     95d:	8d 76 00             	lea    0x0(%esi),%esi
    while(s < es && strchr(whitespace, *s))
        s++;
    if(q)
        *q = s;
    ret = *s;
    switch(*s){
     960:	80 f9 26             	cmp    $0x26,%cl
     963:	75 85                	jne    8ea <gettoken+0xca>
        case '&':
        case '<':
            s++;
            break;
        case '>':
            s++;
     965:	47                   	inc    %edi
     966:	e9 14 ff ff ff       	jmp    87f <gettoken+0x5f>
     96b:	89 df                	mov    %ebx,%edi
            ret = 'a';
            while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
                s++;
            break;
    }
    if(eq)
     96d:	8b 45 14             	mov    0x14(%ebp),%eax
     970:	be 61 00 00 00       	mov    $0x61,%esi
     975:	85 c0                	test   %eax,%eax
     977:	0f 85 09 ff ff ff    	jne    886 <gettoken+0x66>
     97d:	e9 32 ff ff ff       	jmp    8b4 <gettoken+0x94>
     982:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000990 <peek>:
    return ret;
}

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
peek(char **ps, char *es, char *toks)
{
    char *s;

    s = *ps;
    while(s < es && strchr(whitespace, *s))
     9b1:	39 de                	cmp    %ebx,%esi
     9b3:	74 17                	je     9cc <peek+0x3c>
     9b5:	0f be 03             	movsbl (%ebx),%eax
     9b8:	c7 04 24 e4 1d 00 00 	movl   $0x1de4,(%esp)
     9bf:	89 44 24 04          	mov    %eax,0x4(%esp)
     9c3:	e8 28 06 00 00       	call   ff0 <strchr>
     9c8:	85 c0                	test   %eax,%eax
     9ca:	75 e4                	jne    9b0 <peek+0x20>
        s++;
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
     a10:	b8 91 16 00 00       	mov    $0x1691,%eax
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
     a40:	e8 db fd ff ff       	call   820 <gettoken>
        if(gettoken(ps, es, &q, &eq) != 'a')
     a45:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     a49:	89 34 24             	mov    %esi,(%esp)
{
    int tok;
    char *q, *eq;

    while(peek(ps, es, "<>")){
        tok = gettoken(ps, es, 0, 0);
     a4c:	89 c7                	mov    %eax,%edi
        if(gettoken(ps, es, &q, &eq) != 'a')
     a4e:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     a51:	89 44 24 0c          	mov    %eax,0xc(%esp)
     a55:	8d 45 e0             	lea    -0x20(%ebp),%eax
     a58:	89 44 24 08          	mov    %eax,0x8(%esp)
     a5c:	e8 bf fd ff ff       	call   820 <gettoken>
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
     a9d:	e8 3e fc ff ff       	call   6e0 <redircmd>
     aa2:	89 45 08             	mov    %eax,0x8(%ebp)
                break;
     aa5:	e9 66 ff ff ff       	jmp    a10 <parseredirs+0x10>
     aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        tok = gettoken(ps, es, 0, 0);
        if(gettoken(ps, es, &q, &eq) != 'a')
            panic("missing file for redirection");
        switch(tok){
            case '<':
                cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     ab0:	31 ff                	xor    %edi,%edi
     ab2:	31 c0                	xor    %eax,%eax
     ab4:	89 7c 24 10          	mov    %edi,0x10(%esp)
     ab8:	89 44 24 0c          	mov    %eax,0xc(%esp)
     abc:	eb cb                	jmp    a89 <parseredirs+0x89>
     abe:	66 90                	xchg   %ax,%ax
                cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
                break;
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
    char *q, *eq;

    while(peek(ps, es, "<>")){
        tok = gettoken(ps, es, 0, 0);
        if(gettoken(ps, es, &q, &eq) != 'a')
            panic("missing file for redirection");
     acb:	c7 04 24 74 16 00 00 	movl   $0x1674,(%esp)
     ad2:	e8 69 f9 ff ff       	call   440 <panic>
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
     ae1:	ba 94 16 00 00       	mov    $0x1694,%edx
    return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     ae6:	89 e5                	mov    %esp,%ebp
     ae8:	57                   	push   %edi
     ae9:	56                   	push   %esi
     aea:	53                   	push   %ebx
     aeb:	83 ec 3c             	sub    $0x3c,%esp
     aee:	8b 75 08             	mov    0x8(%ebp),%esi
     af1:	8b 7d 0c             	mov    0xc(%ebp),%edi
    char *q, *eq;
    int tok, argc;
    struct execcmd *cmd;
    struct cmd *ret;

    if(peek(ps, es, "("))
     af4:	89 54 24 08          	mov    %edx,0x8(%esp)
     af8:	89 34 24             	mov    %esi,(%esp)
     afb:	89 7c 24 04          	mov    %edi,0x4(%esp)
     aff:	e8 8c fe ff ff       	call   990 <peek>
     b04:	85 c0                	test   %eax,%eax
     b06:	0f 85 a4 00 00 00    	jne    bb0 <parseexec+0xd0>
        return parseblock(ps, es);

    ret = execcmd();
     b0c:	e8 8f fb ff ff       	call   6a0 <execcmd>
    cmd = (struct execcmd*)ret;

    argc = 0;
    ret = parseredirs(ret, ps, es);
     b11:	89 7c 24 08          	mov    %edi,0x8(%esp)
     b15:	89 74 24 04          	mov    %esi,0x4(%esp)
     b19:	89 04 24             	mov    %eax,(%esp)
    struct cmd *ret;

    if(peek(ps, es, "("))
        return parseblock(ps, es);

    ret = execcmd();
     b1c:	89 c3                	mov    %eax,%ebx
     b1e:	89 45 cc             	mov    %eax,-0x34(%ebp)
     b21:	8d 5b 04             	lea    0x4(%ebx),%ebx
    cmd = (struct execcmd*)ret;

    argc = 0;
    ret = parseredirs(ret, ps, es);
     b24:	e8 d7 fe ff ff       	call   a00 <parseredirs>
        return parseblock(ps, es);

    ret = execcmd();
    cmd = (struct execcmd*)ret;

    argc = 0;
     b29:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    ret = parseredirs(ret, ps, es);
     b30:	89 45 d0             	mov    %eax,-0x30(%ebp)
     b33:	eb 19                	jmp    b4e <parseexec+0x6e>
     b35:	8d 76 00             	lea    0x0(%esi),%esi
        cmd->argv[argc] = q;
        cmd->eargv[argc] = eq;
        argc++;
        if(argc >= MAXARGS)
            panic("too many args");
        ret = parseredirs(ret, ps, es);
     b38:	8b 45 d0             	mov    -0x30(%ebp),%eax
     b3b:	89 7c 24 08          	mov    %edi,0x8(%esp)
     b3f:	89 74 24 04          	mov    %esi,0x4(%esp)
     b43:	89 04 24             	mov    %eax,(%esp)
     b46:	e8 b5 fe ff ff       	call   a00 <parseredirs>
     b4b:	89 45 d0             	mov    %eax,-0x30(%ebp)
    ret = execcmd();
    cmd = (struct execcmd*)ret;

    argc = 0;
    ret = parseredirs(ret, ps, es);
    while(!peek(ps, es, "|)&;")){
     b4e:	b8 ab 16 00 00       	mov    $0x16ab,%eax
     b53:	89 44 24 08          	mov    %eax,0x8(%esp)
     b57:	89 7c 24 04          	mov    %edi,0x4(%esp)
     b5b:	89 34 24             	mov    %esi,(%esp)
     b5e:	e8 2d fe ff ff       	call   990 <peek>
     b63:	85 c0                	test   %eax,%eax
     b65:	75 61                	jne    bc8 <parseexec+0xe8>
        if((tok=gettoken(ps, es, &q, &eq)) == 0)
     b67:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     b6a:	89 44 24 0c          	mov    %eax,0xc(%esp)
     b6e:	8d 45 e0             	lea    -0x20(%ebp),%eax
     b71:	89 44 24 08          	mov    %eax,0x8(%esp)
     b75:	89 7c 24 04          	mov    %edi,0x4(%esp)
     b79:	89 34 24             	mov    %esi,(%esp)
     b7c:	e8 9f fc ff ff       	call   820 <gettoken>
     b81:	85 c0                	test   %eax,%eax
     b83:	74 43                	je     bc8 <parseexec+0xe8>
            break;
        if(tok != 'a')
     b85:	83 f8 61             	cmp    $0x61,%eax
     b88:	75 60                	jne    bea <parseexec+0x10a>
            panic("syntax");
        cmd->argv[argc] = q;
     b8a:	8b 45 e0             	mov    -0x20(%ebp),%eax
     b8d:	83 c3 04             	add    $0x4,%ebx
        cmd->eargv[argc] = eq;
        argc++;
     b90:	ff 45 d4             	incl   -0x2c(%ebp)
    while(!peek(ps, es, "|)&;")){
        if((tok=gettoken(ps, es, &q, &eq)) == 0)
            break;
        if(tok != 'a')
            panic("syntax");
        cmd->argv[argc] = q;
     b93:	89 43 fc             	mov    %eax,-0x4(%ebx)
        cmd->eargv[argc] = eq;
     b96:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     b99:	89 43 24             	mov    %eax,0x24(%ebx)
        argc++;
     b9c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        if(argc >= MAXARGS)
     b9f:	83 f8 0a             	cmp    $0xa,%eax
     ba2:	75 94                	jne    b38 <parseexec+0x58>
            panic("too many args");
     ba4:	c7 04 24 9d 16 00 00 	movl   $0x169d,(%esp)
     bab:	e8 90 f8 ff ff       	call   440 <panic>
    int tok, argc;
    struct execcmd *cmd;
    struct cmd *ret;

    if(peek(ps, es, "("))
        return parseblock(ps, es);
     bb0:	89 7c 24 04          	mov    %edi,0x4(%esp)
     bb4:	89 34 24             	mov    %esi,(%esp)
     bb7:	e8 94 01 00 00       	call   d50 <parseblock>
        ret = parseredirs(ret, ps, es);
    }
    cmd->argv[argc] = 0;
    cmd->eargv[argc] = 0;
    return ret;
}
     bbc:	83 c4 3c             	add    $0x3c,%esp
     bbf:	5b                   	pop    %ebx
     bc0:	5e                   	pop    %esi
     bc1:	5f                   	pop    %edi
     bc2:	5d                   	pop    %ebp
     bc3:	c3                   	ret    
     bc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     bc8:	8b 45 cc             	mov    -0x34(%ebp),%eax
     bcb:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     bce:	8d 04 90             	lea    (%eax,%edx,4),%eax
        argc++;
        if(argc >= MAXARGS)
            panic("too many args");
        ret = parseredirs(ret, ps, es);
    }
    cmd->argv[argc] = 0;
     bd1:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    cmd->eargv[argc] = 0;
     bd8:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
     bdf:	8b 45 d0             	mov    -0x30(%ebp),%eax
    return ret;
}
     be2:	83 c4 3c             	add    $0x3c,%esp
     be5:	5b                   	pop    %ebx
     be6:	5e                   	pop    %esi
     be7:	5f                   	pop    %edi
     be8:	5d                   	pop    %ebp
     be9:	c3                   	ret    
    ret = parseredirs(ret, ps, es);
    while(!peek(ps, es, "|)&;")){
        if((tok=gettoken(ps, es, &q, &eq)) == 0)
            break;
        if(tok != 'a')
            panic("syntax");
     bea:	c7 04 24 96 16 00 00 	movl   $0x1696,(%esp)
     bf1:	e8 4a f8 ff ff       	call   440 <panic>
     bf6:	8d 76 00             	lea    0x0(%esi),%esi
     bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c00 <parsepipe>:
    return cmd;
}

struct cmd*
parsepipe(char **ps, char *es)
{
     c00:	55                   	push   %ebp
     c01:	89 e5                	mov    %esp,%ebp
     c03:	83 ec 28             	sub    $0x28,%esp
     c06:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     c09:	8b 5d 08             	mov    0x8(%ebp),%ebx
     c0c:	89 75 f8             	mov    %esi,-0x8(%ebp)
     c0f:	8b 75 0c             	mov    0xc(%ebp),%esi
     c12:	89 7d fc             	mov    %edi,-0x4(%ebp)
    struct cmd *cmd;

    cmd = parseexec(ps, es);
     c15:	89 1c 24             	mov    %ebx,(%esp)
     c18:	89 74 24 04          	mov    %esi,0x4(%esp)
     c1c:	e8 bf fe ff ff       	call   ae0 <parseexec>
    if(peek(ps, es, "|")){
     c21:	b9 b0 16 00 00       	mov    $0x16b0,%ecx
     c26:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     c2a:	89 74 24 04          	mov    %esi,0x4(%esp)
     c2e:	89 1c 24             	mov    %ebx,(%esp)
struct cmd*
parsepipe(char **ps, char *es)
{
    struct cmd *cmd;

    cmd = parseexec(ps, es);
     c31:	89 c7                	mov    %eax,%edi
    if(peek(ps, es, "|")){
     c33:	e8 58 fd ff ff       	call   990 <peek>
     c38:	85 c0                	test   %eax,%eax
     c3a:	75 14                	jne    c50 <parsepipe+0x50>
        gettoken(ps, es, 0, 0);
        cmd = pipecmd(cmd, parsepipe(ps, es));
    }
    return cmd;
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
{
    struct cmd *cmd;

    cmd = parseexec(ps, es);
    if(peek(ps, es, "|")){
        gettoken(ps, es, 0, 0);
     c50:	31 d2                	xor    %edx,%edx
     c52:	31 c0                	xor    %eax,%eax
     c54:	89 54 24 08          	mov    %edx,0x8(%esp)
     c58:	89 74 24 04          	mov    %esi,0x4(%esp)
     c5c:	89 1c 24             	mov    %ebx,(%esp)
     c5f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     c63:	e8 b8 fb ff ff       	call   820 <gettoken>
        cmd = pipecmd(cmd, parsepipe(ps, es));
     c68:	89 74 24 04          	mov    %esi,0x4(%esp)
     c6c:	89 1c 24             	mov    %ebx,(%esp)
     c6f:	e8 8c ff ff ff       	call   c00 <parsepipe>
    }
    return cmd;
}
     c74:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    struct cmd *cmd;

    cmd = parseexec(ps, es);
    if(peek(ps, es, "|")){
        gettoken(ps, es, 0, 0);
        cmd = pipecmd(cmd, parsepipe(ps, es));
     c77:	89 7d 08             	mov    %edi,0x8(%ebp)
    }
    return cmd;
}
     c7a:	8b 75 f8             	mov    -0x8(%ebp),%esi
     c7d:	8b 7d fc             	mov    -0x4(%ebp),%edi
    struct cmd *cmd;

    cmd = parseexec(ps, es);
    if(peek(ps, es, "|")){
        gettoken(ps, es, 0, 0);
        cmd = pipecmd(cmd, parsepipe(ps, es));
     c80:	89 45 0c             	mov    %eax,0xc(%ebp)
    }
    return cmd;
}
     c83:	89 ec                	mov    %ebp,%esp
     c85:	5d                   	pop    %ebp
    struct cmd *cmd;

    cmd = parseexec(ps, es);
    if(peek(ps, es, "|")){
        gettoken(ps, es, 0, 0);
        cmd = pipecmd(cmd, parsepipe(ps, es));
     c86:	e9 b5 fa ff ff       	jmp    740 <pipecmd>
     c8b:	90                   	nop
     c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000c90 <parseline>:
    return cmd;
}

struct cmd*
parseline(char **ps, char *es)
{
     c90:	55                   	push   %ebp
     c91:	89 e5                	mov    %esp,%ebp
     c93:	57                   	push   %edi
     c94:	56                   	push   %esi
     c95:	53                   	push   %ebx
     c96:	83 ec 1c             	sub    $0x1c,%esp
     c99:	8b 5d 08             	mov    0x8(%ebp),%ebx
     c9c:	8b 75 0c             	mov    0xc(%ebp),%esi
    struct cmd *cmd;

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
     cc3:	e8 58 fb ff ff       	call   820 <gettoken>
        cmd = backcmd(cmd);
     cc8:	89 3c 24             	mov    %edi,(%esp)
     ccb:	e8 10 fb ff ff       	call   7e0 <backcmd>
     cd0:	89 c7                	mov    %eax,%edi
parseline(char **ps, char *es)
{
    struct cmd *cmd;

    cmd = parsepipe(ps, es);
    while(peek(ps, es, "&")){
     cd2:	b8 b2 16 00 00       	mov    $0x16b2,%eax
     cd7:	89 44 24 08          	mov    %eax,0x8(%esp)
     cdb:	89 74 24 04          	mov    %esi,0x4(%esp)
     cdf:	89 1c 24             	mov    %ebx,(%esp)
     ce2:	e8 a9 fc ff ff       	call   990 <peek>
     ce7:	85 c0                	test   %eax,%eax
     ce9:	75 c5                	jne    cb0 <parseline+0x20>
        gettoken(ps, es, 0, 0);
        cmd = backcmd(cmd);
    }
    if(peek(ps, es, ";")){
     ceb:	b9 ae 16 00 00       	mov    $0x16ae,%ecx
     cf0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     cf4:	89 74 24 04          	mov    %esi,0x4(%esp)
     cf8:	89 1c 24             	mov    %ebx,(%esp)
     cfb:	e8 90 fc ff ff       	call   990 <peek>
     d00:	85 c0                	test   %eax,%eax
     d02:	75 0c                	jne    d10 <parseline+0x80>
        gettoken(ps, es, 0, 0);
        cmd = listcmd(cmd, parseline(ps, es));
    }
    return cmd;
}
     d04:	83 c4 1c             	add    $0x1c,%esp
     d07:	89 f8                	mov    %edi,%eax
     d09:	5b                   	pop    %ebx
     d0a:	5e                   	pop    %esi
     d0b:	5f                   	pop    %edi
     d0c:	5d                   	pop    %ebp
     d0d:	c3                   	ret    
     d0e:	66 90                	xchg   %ax,%ax
    while(peek(ps, es, "&")){
        gettoken(ps, es, 0, 0);
        cmd = backcmd(cmd);
    }
    if(peek(ps, es, ";")){
        gettoken(ps, es, 0, 0);
     d10:	31 d2                	xor    %edx,%edx
     d12:	31 c0                	xor    %eax,%eax
     d14:	89 54 24 08          	mov    %edx,0x8(%esp)
     d18:	89 74 24 04          	mov    %esi,0x4(%esp)
     d1c:	89 1c 24             	mov    %ebx,(%esp)
     d1f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     d23:	e8 f8 fa ff ff       	call   820 <gettoken>
        cmd = listcmd(cmd, parseline(ps, es));
     d28:	89 74 24 04          	mov    %esi,0x4(%esp)
     d2c:	89 1c 24             	mov    %ebx,(%esp)
     d2f:	e8 5c ff ff ff       	call   c90 <parseline>
     d34:	89 7d 08             	mov    %edi,0x8(%ebp)
     d37:	89 45 0c             	mov    %eax,0xc(%ebp)
    }
    return cmd;
}
     d3a:	83 c4 1c             	add    $0x1c,%esp
     d3d:	5b                   	pop    %ebx
     d3e:	5e                   	pop    %esi
     d3f:	5f                   	pop    %edi
     d40:	5d                   	pop    %ebp
        gettoken(ps, es, 0, 0);
        cmd = backcmd(cmd);
    }
    if(peek(ps, es, ";")){
        gettoken(ps, es, 0, 0);
        cmd = listcmd(cmd, parseline(ps, es));
     d41:	e9 4a fa ff ff       	jmp    790 <listcmd>
     d46:	8d 76 00             	lea    0x0(%esi),%esi
     d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d50 <parseblock>:
    return cmd;
}

struct cmd*
parseblock(char **ps, char *es)
{
     d50:	55                   	push   %ebp
    struct cmd *cmd;

    if(!peek(ps, es, "("))
     d51:	b8 94 16 00 00       	mov    $0x1694,%eax
    return cmd;
}

struct cmd*
parseblock(char **ps, char *es)
{
     d56:	89 e5                	mov    %esp,%ebp
     d58:	83 ec 28             	sub    $0x28,%esp
     d5b:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     d5e:	8b 5d 08             	mov    0x8(%ebp),%ebx
     d61:	89 75 f8             	mov    %esi,-0x8(%ebp)
     d64:	8b 75 0c             	mov    0xc(%ebp),%esi
    struct cmd *cmd;

    if(!peek(ps, es, "("))
     d67:	89 44 24 08          	mov    %eax,0x8(%esp)
    return cmd;
}

struct cmd*
parseblock(char **ps, char *es)
{
     d6b:	89 7d fc             	mov    %edi,-0x4(%ebp)
    struct cmd *cmd;

    if(!peek(ps, es, "("))
     d6e:	89 1c 24             	mov    %ebx,(%esp)
     d71:	89 74 24 04          	mov    %esi,0x4(%esp)
     d75:	e8 16 fc ff ff       	call   990 <peek>
     d7a:	85 c0                	test   %eax,%eax
     d7c:	74 74                	je     df2 <parseblock+0xa2>
        panic("parseblock");
    gettoken(ps, es, 0, 0);
     d7e:	31 c9                	xor    %ecx,%ecx
     d80:	31 ff                	xor    %edi,%edi
     d82:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
     d86:	89 7c 24 08          	mov    %edi,0x8(%esp)
     d8a:	89 74 24 04          	mov    %esi,0x4(%esp)
     d8e:	89 1c 24             	mov    %ebx,(%esp)
     d91:	e8 8a fa ff ff       	call   820 <gettoken>
    cmd = parseline(ps, es);
     d96:	89 74 24 04          	mov    %esi,0x4(%esp)
     d9a:	89 1c 24             	mov    %ebx,(%esp)
     d9d:	e8 ee fe ff ff       	call   c90 <parseline>
    if(!peek(ps, es, ")"))
     da2:	89 74 24 04          	mov    %esi,0x4(%esp)
     da6:	89 1c 24             	mov    %ebx,(%esp)
    struct cmd *cmd;

    if(!peek(ps, es, "("))
        panic("parseblock");
    gettoken(ps, es, 0, 0);
    cmd = parseline(ps, es);
     da9:	89 c7                	mov    %eax,%edi
    if(!peek(ps, es, ")"))
     dab:	b8 d0 16 00 00       	mov    $0x16d0,%eax
     db0:	89 44 24 08          	mov    %eax,0x8(%esp)
     db4:	e8 d7 fb ff ff       	call   990 <peek>
     db9:	85 c0                	test   %eax,%eax
     dbb:	74 41                	je     dfe <parseblock+0xae>
        panic("syntax - missing )");
    gettoken(ps, es, 0, 0);
     dbd:	31 d2                	xor    %edx,%edx
     dbf:	31 c0                	xor    %eax,%eax
     dc1:	89 54 24 08          	mov    %edx,0x8(%esp)
     dc5:	89 74 24 04          	mov    %esi,0x4(%esp)
     dc9:	89 1c 24             	mov    %ebx,(%esp)
     dcc:	89 44 24 0c          	mov    %eax,0xc(%esp)
     dd0:	e8 4b fa ff ff       	call   820 <gettoken>
    cmd = parseredirs(cmd, ps, es);
     dd5:	89 74 24 08          	mov    %esi,0x8(%esp)
     dd9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     ddd:	89 3c 24             	mov    %edi,(%esp)
     de0:	e8 1b fc ff ff       	call   a00 <parseredirs>
    return cmd;
}
     de5:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     de8:	8b 75 f8             	mov    -0x8(%ebp),%esi
     deb:	8b 7d fc             	mov    -0x4(%ebp),%edi
     dee:	89 ec                	mov    %ebp,%esp
     df0:	5d                   	pop    %ebp
     df1:	c3                   	ret    
parseblock(char **ps, char *es)
{
    struct cmd *cmd;

    if(!peek(ps, es, "("))
        panic("parseblock");
     df2:	c7 04 24 b4 16 00 00 	movl   $0x16b4,(%esp)
     df9:	e8 42 f6 ff ff       	call   440 <panic>
    gettoken(ps, es, 0, 0);
    cmd = parseline(ps, es);
    if(!peek(ps, es, ")"))
        panic("syntax - missing )");
     dfe:	c7 04 24 bf 16 00 00 	movl   $0x16bf,(%esp)
     e05:	e8 36 f6 ff ff       	call   440 <panic>
     e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000e10 <nulterminate>:
}

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
     e1c:	0f 84 96 00 00 00    	je     eb8 <nulterminate+0xa8>
        return 0;

    switch(cmd->type){
     e22:	83 3b 05             	cmpl   $0x5,(%ebx)
     e25:	77 48                	ja     e6f <nulterminate+0x5f>
     e27:	8b 03                	mov    (%ebx),%eax
     e29:	ff 24 85 14 17 00 00 	jmp    *0x1714(,%eax,4)
            nulterminate(pcmd->right);
            break;

        case LIST:
            lcmd = (struct listcmd*)cmd;
            nulterminate(lcmd->left);
     e30:	8b 43 04             	mov    0x4(%ebx),%eax
     e33:	89 04 24             	mov    %eax,(%esp)
     e36:	e8 d5 ff ff ff       	call   e10 <nulterminate>
            nulterminate(lcmd->right);
     e3b:	8b 43 08             	mov    0x8(%ebx),%eax
     e3e:	89 04 24             	mov    %eax,(%esp)
     e41:	e8 ca ff ff ff       	call   e10 <nulterminate>
            break;
     e46:	89 d8                	mov    %ebx,%eax
            bcmd = (struct backcmd*)cmd;
            nulterminate(bcmd->cmd);
            break;
    }
    return cmd;
}
     e48:	83 c4 14             	add    $0x14,%esp
     e4b:	5b                   	pop    %ebx
     e4c:	5d                   	pop    %ebp
     e4d:	c3                   	ret    
     e4e:	66 90                	xchg   %ax,%ax
        return 0;

    switch(cmd->type){
        case EXEC:
            ecmd = (struct execcmd*)cmd;
            for(i=0; ecmd->argv[i]; i++)
     e50:	8b 4b 04             	mov    0x4(%ebx),%ecx
     e53:	8d 43 2c             	lea    0x2c(%ebx),%eax
     e56:	85 c9                	test   %ecx,%ecx
     e58:	74 15                	je     e6f <nulterminate+0x5f>
     e5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                *ecmd->eargv[i] = 0;
     e60:	8b 10                	mov    (%eax),%edx
     e62:	83 c0 04             	add    $0x4,%eax
     e65:	c6 02 00             	movb   $0x0,(%edx)
        return 0;

    switch(cmd->type){
        case EXEC:
            ecmd = (struct execcmd*)cmd;
            for(i=0; ecmd->argv[i]; i++)
     e68:	8b 50 d8             	mov    -0x28(%eax),%edx
     e6b:	85 d2                	test   %edx,%edx
     e6d:	75 f1                	jne    e60 <nulterminate+0x50>
            bcmd = (struct backcmd*)cmd;
            nulterminate(bcmd->cmd);
            break;
    }
    return cmd;
}
     e6f:	83 c4 14             	add    $0x14,%esp
    struct redircmd *rcmd;

    if(cmd == 0)
        return 0;

    switch(cmd->type){
     e72:	89 d8                	mov    %ebx,%eax
            bcmd = (struct backcmd*)cmd;
            nulterminate(bcmd->cmd);
            break;
    }
    return cmd;
}
     e74:	5b                   	pop    %ebx
     e75:	5d                   	pop    %ebp
     e76:	c3                   	ret    
     e77:	89 f6                	mov    %esi,%esi
     e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            nulterminate(lcmd->right);
            break;

        case BACK:
            bcmd = (struct backcmd*)cmd;
            nulterminate(bcmd->cmd);
     e80:	8b 43 04             	mov    0x4(%ebx),%eax
     e83:	89 04 24             	mov    %eax,(%esp)
     e86:	e8 85 ff ff ff       	call   e10 <nulterminate>
            break;
    }
    return cmd;
}
     e8b:	83 c4 14             	add    $0x14,%esp
            break;

        case BACK:
            bcmd = (struct backcmd*)cmd;
            nulterminate(bcmd->cmd);
            break;
     e8e:	89 d8                	mov    %ebx,%eax
    }
    return cmd;
}
     e90:	5b                   	pop    %ebx
     e91:	5d                   	pop    %ebp
     e92:	c3                   	ret    
     e93:	90                   	nop
     e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                *ecmd->eargv[i] = 0;
            break;

        case REDIR:
            rcmd = (struct redircmd*)cmd;
            nulterminate(rcmd->cmd);
     e98:	8b 43 04             	mov    0x4(%ebx),%eax
     e9b:	89 04 24             	mov    %eax,(%esp)
     e9e:	e8 6d ff ff ff       	call   e10 <nulterminate>
            *rcmd->efile = 0;
     ea3:	8b 43 0c             	mov    0xc(%ebx),%eax
     ea6:	c6 00 00             	movb   $0x0,(%eax)
            bcmd = (struct backcmd*)cmd;
            nulterminate(bcmd->cmd);
            break;
    }
    return cmd;
}
     ea9:	83 c4 14             	add    $0x14,%esp

        case REDIR:
            rcmd = (struct redircmd*)cmd;
            nulterminate(rcmd->cmd);
            *rcmd->efile = 0;
            break;
     eac:	89 d8                	mov    %ebx,%eax
            bcmd = (struct backcmd*)cmd;
            nulterminate(bcmd->cmd);
            break;
    }
    return cmd;
}
     eae:	5b                   	pop    %ebx
     eaf:	5d                   	pop    %ebp
     eb0:	c3                   	ret    
     eb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct listcmd *lcmd;
    struct pipecmd *pcmd;
    struct redircmd *rcmd;

    if(cmd == 0)
        return 0;
     eb8:	31 c0                	xor    %eax,%eax
     eba:	eb 8c                	jmp    e48 <nulterminate+0x38>
     ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ec0 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     ec0:	55                   	push   %ebp
     ec1:	89 e5                	mov    %esp,%ebp
     ec3:	56                   	push   %esi
     ec4:	53                   	push   %ebx
     ec5:	83 ec 10             	sub    $0x10,%esp
    char *es;
    struct cmd *cmd;

    es = s + strlen(s);
     ec8:	8b 5d 08             	mov    0x8(%ebp),%ebx
     ecb:	89 1c 24             	mov    %ebx,(%esp)
     ece:	e8 dd 00 00 00       	call   fb0 <strlen>
     ed3:	01 c3                	add    %eax,%ebx
    cmd = parseline(&s, es);
     ed5:	8d 45 08             	lea    0x8(%ebp),%eax
     ed8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     edc:	89 04 24             	mov    %eax,(%esp)
     edf:	e8 ac fd ff ff       	call   c90 <parseline>
    peek(&s, es, "");
     ee4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
{
    char *es;
    struct cmd *cmd;

    es = s + strlen(s);
    cmd = parseline(&s, es);
     ee8:	89 c6                	mov    %eax,%esi
    peek(&s, es, "");
     eea:	b8 59 16 00 00       	mov    $0x1659,%eax
     eef:	89 44 24 08          	mov    %eax,0x8(%esp)
     ef3:	8d 45 08             	lea    0x8(%ebp),%eax
     ef6:	89 04 24             	mov    %eax,(%esp)
     ef9:	e8 92 fa ff ff       	call   990 <peek>
    if(s != es){
     efe:	8b 45 08             	mov    0x8(%ebp),%eax
     f01:	39 c3                	cmp    %eax,%ebx
     f03:	75 11                	jne    f16 <parsecmd+0x56>
        printf(2, "leftovers: %s\n", s);
        panic("syntax");
    }
    nulterminate(cmd);
     f05:	89 34 24             	mov    %esi,(%esp)
     f08:	e8 03 ff ff ff       	call   e10 <nulterminate>
    return cmd;
}
     f0d:	83 c4 10             	add    $0x10,%esp
     f10:	89 f0                	mov    %esi,%eax
     f12:	5b                   	pop    %ebx
     f13:	5e                   	pop    %esi
     f14:	5d                   	pop    %ebp
     f15:	c3                   	ret    

    es = s + strlen(s);
    cmd = parseline(&s, es);
    peek(&s, es, "");
    if(s != es){
        printf(2, "leftovers: %s\n", s);
     f16:	89 44 24 08          	mov    %eax,0x8(%esp)
     f1a:	c7 44 24 04 d2 16 00 	movl   $0x16d2,0x4(%esp)
     f21:	00 
     f22:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     f29:	e8 b2 03 00 00       	call   12e0 <printf>
        panic("syntax");
     f2e:	c7 04 24 96 16 00 00 	movl   $0x1696,(%esp)
     f35:	e8 06 f5 ff ff       	call   440 <panic>
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
     f66:	56                   	push   %esi
     f67:	53                   	push   %ebx
     f68:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
     f6b:	0f b6 01             	movzbl (%ecx),%eax
     f6e:	0f b6 13             	movzbl (%ebx),%edx
     f71:	84 c0                	test   %al,%al
     f73:	75 1c                	jne    f91 <strcmp+0x31>
     f75:	eb 29                	jmp    fa0 <strcmp+0x40>
     f77:	89 f6                	mov    %esi,%esi
     f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     f80:	41                   	inc    %ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     f81:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
     f84:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     f87:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
     f8b:	84 c0                	test   %al,%al
     f8d:	74 11                	je     fa0 <strcmp+0x40>
     f8f:	89 f3                	mov    %esi,%ebx
     f91:	38 d0                	cmp    %dl,%al
     f93:	74 eb                	je     f80 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
     f95:	5b                   	pop    %ebx
int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    p++, q++;
  return (uchar)*p - (uchar)*q;
     f96:	29 d0                	sub    %edx,%eax
}
     f98:	5e                   	pop    %esi
     f99:	5d                   	pop    %ebp
     f9a:	c3                   	ret    
     f9b:	90                   	nop
     f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     fa0:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     fa1:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
     fa3:	29 d0                	sub    %edx,%eax
}
     fa5:	5e                   	pop    %esi
     fa6:	5d                   	pop    %ebp
     fa7:	c3                   	ret    
     fa8:	90                   	nop
     fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000fb0 <strlen>:

uint
strlen(const char *s)
{
     fb0:	55                   	push   %ebp
     fb1:	89 e5                	mov    %esp,%ebp
     fb3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     fb6:	80 39 00             	cmpb   $0x0,(%ecx)
     fb9:	74 10                	je     fcb <strlen+0x1b>
     fbb:	31 d2                	xor    %edx,%edx
     fbd:	8d 76 00             	lea    0x0(%esi),%esi
     fc0:	42                   	inc    %edx
     fc1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     fc5:	89 d0                	mov    %edx,%eax
     fc7:	75 f7                	jne    fc0 <strlen+0x10>
    ;
  return n;
}
     fc9:	5d                   	pop    %ebp
     fca:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
     fcb:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
     fcd:	5d                   	pop    %ebp
     fce:	c3                   	ret    
     fcf:	90                   	nop

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
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1014:	40                   	inc    %eax
    1015:	0f b6 10             	movzbl (%eax),%edx
    1018:	84 d2                	test   %dl,%dl
    101a:	75 f4                	jne    1010 <strchr+0x20>
    if(*s == c)
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
  return 0;
}

char*
gets(char *buf, int max)
{
    1027:	53                   	push   %ebx
    1028:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    102b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    102e:	eb 32                	jmp    1062 <gets+0x42>
    cc = read(0, &c, 1);
    1030:	b8 01 00 00 00       	mov    $0x1,%eax
    1035:	89 44 24 08          	mov    %eax,0x8(%esp)
    1039:	89 7c 24 04          	mov    %edi,0x4(%esp)
    103d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1044:	e8 47 01 00 00       	call   1190 <read>
    if(cc < 1)
    1049:	85 c0                	test   %eax,%eax
    104b:	7e 1d                	jle    106a <gets+0x4a>
      break;
    buf[i++] = c;
    104d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1051:	89 de                	mov    %ebx,%esi
    1053:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
    1056:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    1058:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    105c:	74 22                	je     1080 <gets+0x60>
    105e:	3c 0d                	cmp    $0xd,%al
    1060:	74 1e                	je     1080 <gets+0x60>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1062:	8d 5e 01             	lea    0x1(%esi),%ebx
    1065:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1068:	7c c6                	jl     1030 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    106a:	8b 45 08             	mov    0x8(%ebp),%eax
    106d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    1071:	83 c4 2c             	add    $0x2c,%esp
    1074:	5b                   	pop    %ebx
    1075:	5e                   	pop    %esi
    1076:	5f                   	pop    %edi
    1077:	5d                   	pop    %ebp
    1078:	c3                   	ret    
    1079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1080:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1083:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1085:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    1089:	83 c4 2c             	add    $0x2c,%esp
    108c:	5b                   	pop    %ebx
    108d:	5e                   	pop    %esi
    108e:	5f                   	pop    %edi
    108f:	5d                   	pop    %ebp
    1090:	c3                   	ret    
    1091:	eb 0d                	jmp    10a0 <stat>
    1093:	90                   	nop
    1094:	90                   	nop
    1095:	90                   	nop
    1096:	90                   	nop
    1097:	90                   	nop
    1098:	90                   	nop
    1099:	90                   	nop
    109a:	90                   	nop
    109b:	90                   	nop
    109c:	90                   	nop
    109d:	90                   	nop
    109e:	90                   	nop
    109f:	90                   	nop

000010a0 <stat>:

int
stat(const char *n, struct stat *st)
{
    10a0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    10a1:	31 c0                	xor    %eax,%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
    10a3:	89 e5                	mov    %esp,%ebp
    10a5:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    10a8:	89 44 24 04          	mov    %eax,0x4(%esp)
    10ac:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
    10af:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    10b2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    10b5:	89 04 24             	mov    %eax,(%esp)
    10b8:	e8 fb 00 00 00       	call   11b8 <open>
  if(fd < 0)
    10bd:	85 c0                	test   %eax,%eax
    10bf:	78 2f                	js     10f0 <stat+0x50>
    10c1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    10c3:	8b 45 0c             	mov    0xc(%ebp),%eax
    10c6:	89 1c 24             	mov    %ebx,(%esp)
    10c9:	89 44 24 04          	mov    %eax,0x4(%esp)
    10cd:	e8 fe 00 00 00       	call   11d0 <fstat>
  close(fd);
    10d2:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    10d5:	89 c6                	mov    %eax,%esi
  close(fd);
    10d7:	e8 c4 00 00 00       	call   11a0 <close>
  return r;
    10dc:	89 f0                	mov    %esi,%eax
}
    10de:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    10e1:	8b 75 fc             	mov    -0x4(%ebp),%esi
    10e4:	89 ec                	mov    %ebp,%esp
    10e6:	5d                   	pop    %ebp
    10e7:	c3                   	ret    
    10e8:	90                   	nop
    10e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
    10f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    10f5:	eb e7                	jmp    10de <stat+0x3e>
    10f7:	89 f6                	mov    %esi,%esi
    10f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001100 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    1100:	55                   	push   %ebp
    1101:	89 e5                	mov    %esp,%ebp
    1103:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1106:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1107:	0f be 11             	movsbl (%ecx),%edx
    110a:	88 d0                	mov    %dl,%al
    110c:	2c 30                	sub    $0x30,%al
    110e:	3c 09                	cmp    $0x9,%al
    1110:	b8 00 00 00 00       	mov    $0x0,%eax
    1115:	77 1e                	ja     1135 <atoi+0x35>
    1117:	89 f6                	mov    %esi,%esi
    1119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    1120:	41                   	inc    %ecx
    1121:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1124:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1128:	0f be 11             	movsbl (%ecx),%edx
    112b:	88 d3                	mov    %dl,%bl
    112d:	80 eb 30             	sub    $0x30,%bl
    1130:	80 fb 09             	cmp    $0x9,%bl
    1133:	76 eb                	jbe    1120 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
    1135:	5b                   	pop    %ebx
    1136:	5d                   	pop    %ebp
    1137:	c3                   	ret    
    1138:	90                   	nop
    1139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001140 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1140:	55                   	push   %ebp
    1141:	89 e5                	mov    %esp,%ebp
    1143:	56                   	push   %esi
    1144:	8b 45 08             	mov    0x8(%ebp),%eax
    1147:	53                   	push   %ebx
    1148:	8b 5d 10             	mov    0x10(%ebp),%ebx
    114b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    114e:	85 db                	test   %ebx,%ebx
    1150:	7e 1a                	jle    116c <memmove+0x2c>
    1152:	31 d2                	xor    %edx,%edx
    1154:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    115a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
    1160:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    1164:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    1167:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1168:	39 da                	cmp    %ebx,%edx
    116a:	75 f4                	jne    1160 <memmove+0x20>
    *dst++ = *src++;
  return vdst;
}
    116c:	5b                   	pop    %ebx
    116d:	5e                   	pop    %esi
    116e:	5d                   	pop    %ebp
    116f:	c3                   	ret    

00001170 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1170:	b8 01 00 00 00       	mov    $0x1,%eax
    1175:	cd 40                	int    $0x40
    1177:	c3                   	ret    

00001178 <exit>:
SYSCALL(exit)
    1178:	b8 02 00 00 00       	mov    $0x2,%eax
    117d:	cd 40                	int    $0x40
    117f:	c3                   	ret    

00001180 <wait>:
SYSCALL(wait)
    1180:	b8 03 00 00 00       	mov    $0x3,%eax
    1185:	cd 40                	int    $0x40
    1187:	c3                   	ret    

00001188 <pipe>:
SYSCALL(pipe)
    1188:	b8 04 00 00 00       	mov    $0x4,%eax
    118d:	cd 40                	int    $0x40
    118f:	c3                   	ret    

00001190 <read>:
SYSCALL(read)
    1190:	b8 05 00 00 00       	mov    $0x5,%eax
    1195:	cd 40                	int    $0x40
    1197:	c3                   	ret    

00001198 <write>:
SYSCALL(write)
    1198:	b8 10 00 00 00       	mov    $0x10,%eax
    119d:	cd 40                	int    $0x40
    119f:	c3                   	ret    

000011a0 <close>:
SYSCALL(close)
    11a0:	b8 15 00 00 00       	mov    $0x15,%eax
    11a5:	cd 40                	int    $0x40
    11a7:	c3                   	ret    

000011a8 <kill>:
SYSCALL(kill)
    11a8:	b8 06 00 00 00       	mov    $0x6,%eax
    11ad:	cd 40                	int    $0x40
    11af:	c3                   	ret    

000011b0 <exec>:
SYSCALL(exec)
    11b0:	b8 07 00 00 00       	mov    $0x7,%eax
    11b5:	cd 40                	int    $0x40
    11b7:	c3                   	ret    

000011b8 <open>:
SYSCALL(open)
    11b8:	b8 0f 00 00 00       	mov    $0xf,%eax
    11bd:	cd 40                	int    $0x40
    11bf:	c3                   	ret    

000011c0 <mknod>:
SYSCALL(mknod)
    11c0:	b8 11 00 00 00       	mov    $0x11,%eax
    11c5:	cd 40                	int    $0x40
    11c7:	c3                   	ret    

000011c8 <unlink>:
SYSCALL(unlink)
    11c8:	b8 12 00 00 00       	mov    $0x12,%eax
    11cd:	cd 40                	int    $0x40
    11cf:	c3                   	ret    

000011d0 <fstat>:
SYSCALL(fstat)
    11d0:	b8 08 00 00 00       	mov    $0x8,%eax
    11d5:	cd 40                	int    $0x40
    11d7:	c3                   	ret    

000011d8 <link>:
SYSCALL(link)
    11d8:	b8 13 00 00 00       	mov    $0x13,%eax
    11dd:	cd 40                	int    $0x40
    11df:	c3                   	ret    

000011e0 <mkdir>:
SYSCALL(mkdir)
    11e0:	b8 14 00 00 00       	mov    $0x14,%eax
    11e5:	cd 40                	int    $0x40
    11e7:	c3                   	ret    

000011e8 <chdir>:
SYSCALL(chdir)
    11e8:	b8 09 00 00 00       	mov    $0x9,%eax
    11ed:	cd 40                	int    $0x40
    11ef:	c3                   	ret    

000011f0 <dup>:
SYSCALL(dup)
    11f0:	b8 0a 00 00 00       	mov    $0xa,%eax
    11f5:	cd 40                	int    $0x40
    11f7:	c3                   	ret    

000011f8 <getpid>:
SYSCALL(getpid)
    11f8:	b8 0b 00 00 00       	mov    $0xb,%eax
    11fd:	cd 40                	int    $0x40
    11ff:	c3                   	ret    

00001200 <sbrk>:
SYSCALL(sbrk)
    1200:	b8 0c 00 00 00       	mov    $0xc,%eax
    1205:	cd 40                	int    $0x40
    1207:	c3                   	ret    

00001208 <sleep>:
SYSCALL(sleep)
    1208:	b8 0d 00 00 00       	mov    $0xd,%eax
    120d:	cd 40                	int    $0x40
    120f:	c3                   	ret    

00001210 <uptime>:
SYSCALL(uptime)
    1210:	b8 0e 00 00 00       	mov    $0xe,%eax
    1215:	cd 40                	int    $0x40
    1217:	c3                   	ret    

00001218 <policy>:
SYSCALL(policy)
    1218:	b8 17 00 00 00       	mov    $0x17,%eax
    121d:	cd 40                	int    $0x40
    121f:	c3                   	ret    

00001220 <detach>:
SYSCALL(detach)
    1220:	b8 16 00 00 00       	mov    $0x16,%eax
    1225:	cd 40                	int    $0x40
    1227:	c3                   	ret    

00001228 <priority>:
SYSCALL(priority)
    1228:	b8 18 00 00 00       	mov    $0x18,%eax
    122d:	cd 40                	int    $0x40
    122f:	c3                   	ret    

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
    1235:	89 c6                	mov    %eax,%esi
    1237:	53                   	push   %ebx
    1238:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    123b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    123e:	85 db                	test   %ebx,%ebx
    1240:	0f 84 8a 00 00 00    	je     12d0 <printint+0xa0>
    1246:	89 d0                	mov    %edx,%eax
    1248:	c1 e8 1f             	shr    $0x1f,%eax
    124b:	84 c0                	test   %al,%al
    124d:	0f 84 7d 00 00 00    	je     12d0 <printint+0xa0>
    neg = 1;
    x = -xx;
    1253:	89 d0                	mov    %edx,%eax
    1255:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    1257:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    125e:	89 75 c0             	mov    %esi,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
    1261:	31 ff                	xor    %edi,%edi
    1263:	89 ce                	mov    %ecx,%esi
    1265:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    1268:	eb 08                	jmp    1272 <printint+0x42>
    126a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1270:	89 cf                	mov    %ecx,%edi
    1272:	31 d2                	xor    %edx,%edx
    1274:	f7 f6                	div    %esi
    1276:	8d 4f 01             	lea    0x1(%edi),%ecx
    1279:	0f b6 92 58 17 00 00 	movzbl 0x1758(%edx),%edx
  }while((x /= base) != 0);
    1280:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    1282:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
    1285:	75 e9                	jne    1270 <printint+0x40>
  if(neg)
    1287:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    128a:	8b 75 c0             	mov    -0x40(%ebp),%esi
    128d:	85 d2                	test   %edx,%edx
    128f:	74 08                	je     1299 <printint+0x69>
    buf[i++] = '-';
    1291:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
    1296:	8d 4f 02             	lea    0x2(%edi),%ecx
    1299:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
    129d:	8d 76 00             	lea    0x0(%esi),%esi
    12a0:	0f b6 07             	movzbl (%edi),%eax
    12a3:	4f                   	dec    %edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    12a4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    12a8:	89 34 24             	mov    %esi,(%esp)
    12ab:	88 45 d7             	mov    %al,-0x29(%ebp)
    12ae:	b8 01 00 00 00       	mov    $0x1,%eax
    12b3:	89 44 24 08          	mov    %eax,0x8(%esp)
    12b7:	e8 dc fe ff ff       	call   1198 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    12bc:	39 df                	cmp    %ebx,%edi
    12be:	75 e0                	jne    12a0 <printint+0x70>
    putc(fd, buf[i]);
}
    12c0:	83 c4 4c             	add    $0x4c,%esp
    12c3:	5b                   	pop    %ebx
    12c4:	5e                   	pop    %esi
    12c5:	5f                   	pop    %edi
    12c6:	5d                   	pop    %ebp
    12c7:	c3                   	ret    
    12c8:	90                   	nop
    12c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    12d0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    12d2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    12d9:	eb 83                	jmp    125e <printint+0x2e>
    12db:	90                   	nop
    12dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000012e0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    12e0:	55                   	push   %ebp
    12e1:	89 e5                	mov    %esp,%ebp
    12e3:	57                   	push   %edi
    12e4:	56                   	push   %esi
    12e5:	53                   	push   %ebx
    12e6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    12e9:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    12ec:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    12ef:	0f b6 1e             	movzbl (%esi),%ebx
    12f2:	84 db                	test   %bl,%bl
    12f4:	0f 84 c6 00 00 00    	je     13c0 <printf+0xe0>
    12fa:	8d 45 10             	lea    0x10(%ebp),%eax
    12fd:	46                   	inc    %esi
    12fe:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1301:	31 d2                	xor    %edx,%edx
    1303:	eb 3b                	jmp    1340 <printf+0x60>
    1305:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1308:	83 f8 25             	cmp    $0x25,%eax
    130b:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
    130e:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1313:	74 1e                	je     1333 <printf+0x53>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1315:	b8 01 00 00 00       	mov    $0x1,%eax
    131a:	89 44 24 08          	mov    %eax,0x8(%esp)
    131e:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1321:	89 44 24 04          	mov    %eax,0x4(%esp)
    1325:	89 3c 24             	mov    %edi,(%esp)
    1328:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    132b:	e8 68 fe ff ff       	call   1198 <write>
    1330:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    1333:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1334:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    1338:	84 db                	test   %bl,%bl
    133a:	0f 84 80 00 00 00    	je     13c0 <printf+0xe0>
    c = fmt[i] & 0xff;
    if(state == 0){
    1340:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    1342:	0f be cb             	movsbl %bl,%ecx
    1345:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1348:	74 be                	je     1308 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    134a:	83 fa 25             	cmp    $0x25,%edx
    134d:	75 e4                	jne    1333 <printf+0x53>
      if(c == 'd'){
    134f:	83 f8 64             	cmp    $0x64,%eax
    1352:	0f 84 20 01 00 00    	je     1478 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1358:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    135e:	83 f9 70             	cmp    $0x70,%ecx
    1361:	74 6d                	je     13d0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1363:	83 f8 73             	cmp    $0x73,%eax
    1366:	0f 84 94 00 00 00    	je     1400 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    136c:	83 f8 63             	cmp    $0x63,%eax
    136f:	0f 84 14 01 00 00    	je     1489 <printf+0x1a9>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1375:	83 f8 25             	cmp    $0x25,%eax
    1378:	0f 84 d2 00 00 00    	je     1450 <printf+0x170>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    137e:	b8 01 00 00 00       	mov    $0x1,%eax
    1383:	46                   	inc    %esi
    1384:	89 44 24 08          	mov    %eax,0x8(%esp)
    1388:	8d 45 e7             	lea    -0x19(%ebp),%eax
    138b:	89 44 24 04          	mov    %eax,0x4(%esp)
    138f:	89 3c 24             	mov    %edi,(%esp)
    1392:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1396:	e8 fd fd ff ff       	call   1198 <write>
    139b:	ba 01 00 00 00       	mov    $0x1,%edx
    13a0:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    13a3:	89 54 24 08          	mov    %edx,0x8(%esp)
    13a7:	89 44 24 04          	mov    %eax,0x4(%esp)
    13ab:	89 3c 24             	mov    %edi,(%esp)
    13ae:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    13b1:	e8 e2 fd ff ff       	call   1198 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    13b6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    13ba:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    13bc:	84 db                	test   %bl,%bl
    13be:	75 80                	jne    1340 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    13c0:	83 c4 3c             	add    $0x3c,%esp
    13c3:	5b                   	pop    %ebx
    13c4:	5e                   	pop    %esi
    13c5:	5f                   	pop    %edi
    13c6:	5d                   	pop    %ebp
    13c7:	c3                   	ret    
    13c8:	90                   	nop
    13c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    13d0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    13d7:	b9 10 00 00 00       	mov    $0x10,%ecx
    13dc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    13df:	89 f8                	mov    %edi,%eax
    13e1:	8b 13                	mov    (%ebx),%edx
    13e3:	e8 48 fe ff ff       	call   1230 <printint>
        ap++;
    13e8:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    13ea:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
    13ec:	83 c0 04             	add    $0x4,%eax
    13ef:	89 45 d0             	mov    %eax,-0x30(%ebp)
    13f2:	e9 3c ff ff ff       	jmp    1333 <printf+0x53>
    13f7:	89 f6                	mov    %esi,%esi
    13f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      } else if(c == 's'){
        s = (char*)*ap;
    1400:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1403:	8b 18                	mov    (%eax),%ebx
        ap++;
    1405:	83 c0 04             	add    $0x4,%eax
    1408:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
    140b:	b8 50 17 00 00       	mov    $0x1750,%eax
    1410:	85 db                	test   %ebx,%ebx
    1412:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
    1415:	0f b6 03             	movzbl (%ebx),%eax
    1418:	84 c0                	test   %al,%al
    141a:	74 27                	je     1443 <printf+0x163>
    141c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1420:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1423:	b8 01 00 00 00       	mov    $0x1,%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
    1428:	43                   	inc    %ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1429:	89 44 24 08          	mov    %eax,0x8(%esp)
    142d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    1430:	89 44 24 04          	mov    %eax,0x4(%esp)
    1434:	89 3c 24             	mov    %edi,(%esp)
    1437:	e8 5c fd ff ff       	call   1198 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    143c:	0f b6 03             	movzbl (%ebx),%eax
    143f:	84 c0                	test   %al,%al
    1441:	75 dd                	jne    1420 <printf+0x140>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1443:	31 d2                	xor    %edx,%edx
    1445:	e9 e9 fe ff ff       	jmp    1333 <printf+0x53>
    144a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1450:	b9 01 00 00 00       	mov    $0x1,%ecx
    1455:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1458:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    145c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1460:	89 3c 24             	mov    %edi,(%esp)
    1463:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    1466:	e8 2d fd ff ff       	call   1198 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    146b:	31 d2                	xor    %edx,%edx
    146d:	e9 c1 fe ff ff       	jmp    1333 <printf+0x53>
    1472:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1478:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    147f:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1484:	e9 53 ff ff ff       	jmp    13dc <printf+0xfc>
    1489:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    148c:	8b 03                	mov    (%ebx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    148e:	89 3c 24             	mov    %edi,(%esp)
    1491:	88 45 e4             	mov    %al,-0x1c(%ebp)
    1494:	b8 01 00 00 00       	mov    $0x1,%eax
    1499:	89 44 24 08          	mov    %eax,0x8(%esp)
    149d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    14a0:	89 44 24 04          	mov    %eax,0x4(%esp)
    14a4:	e8 ef fc ff ff       	call   1198 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    14a9:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    14ab:	31 d2                	xor    %edx,%edx
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    14ad:	83 c0 04             	add    $0x4,%eax
    14b0:	89 45 d0             	mov    %eax,-0x30(%ebp)
    14b3:	e9 7b fe ff ff       	jmp    1333 <printf+0x53>
    14b8:	66 90                	xchg   %ax,%ax
    14ba:	66 90                	xchg   %ax,%ax
    14bc:	66 90                	xchg   %ax,%ax
    14be:	66 90                	xchg   %ax,%ax

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
    14c1:	a1 64 1e 00 00       	mov    0x1e64,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    14c6:	89 e5                	mov    %esp,%ebp
    14c8:	57                   	push   %edi
    14c9:	56                   	push   %esi
    14ca:	53                   	push   %ebx
    14cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14ce:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
    14d0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14d3:	39 c8                	cmp    %ecx,%eax
    14d5:	73 19                	jae    14f0 <free+0x30>
    14d7:	89 f6                	mov    %esi,%esi
    14d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    14e0:	39 d1                	cmp    %edx,%ecx
    14e2:	72 1c                	jb     1500 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14e4:	39 d0                	cmp    %edx,%eax
    14e6:	73 18                	jae    1500 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
    14e8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14ea:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14ec:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14ee:	72 f0                	jb     14e0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14f0:	39 d0                	cmp    %edx,%eax
    14f2:	72 f4                	jb     14e8 <free+0x28>
    14f4:	39 d1                	cmp    %edx,%ecx
    14f6:	73 f0                	jae    14e8 <free+0x28>
    14f8:	90                   	nop
    14f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
    1500:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1503:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1506:	39 d7                	cmp    %edx,%edi
    1508:	74 19                	je     1523 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    150a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    150d:	8b 50 04             	mov    0x4(%eax),%edx
    1510:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1513:	39 f1                	cmp    %esi,%ecx
    1515:	74 25                	je     153c <free+0x7c>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1517:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
    1519:	5b                   	pop    %ebx
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    151a:	a3 64 1e 00 00       	mov    %eax,0x1e64
}
    151f:	5e                   	pop    %esi
    1520:	5f                   	pop    %edi
    1521:	5d                   	pop    %ebp
    1522:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1523:	8b 7a 04             	mov    0x4(%edx),%edi
    1526:	01 fe                	add    %edi,%esi
    1528:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    152b:	8b 10                	mov    (%eax),%edx
    152d:	8b 12                	mov    (%edx),%edx
    152f:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1532:	8b 50 04             	mov    0x4(%eax),%edx
    1535:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1538:	39 f1                	cmp    %esi,%ecx
    153a:	75 db                	jne    1517 <free+0x57>
    p->s.size += bp->s.size;
    153c:	8b 4b fc             	mov    -0x4(%ebx),%ecx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    153f:	a3 64 1e 00 00       	mov    %eax,0x1e64
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1544:	01 ca                	add    %ecx,%edx
    1546:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1549:	8b 53 f8             	mov    -0x8(%ebx),%edx
    154c:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    154e:	5b                   	pop    %ebx
    154f:	5e                   	pop    %esi
    1550:	5f                   	pop    %edi
    1551:	5d                   	pop    %ebp
    1552:	c3                   	ret    
    1553:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

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
    156c:	8b 15 64 1e 00 00    	mov    0x1e64,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1572:	8d 78 07             	lea    0x7(%eax),%edi
    1575:	c1 ef 03             	shr    $0x3,%edi
    1578:	47                   	inc    %edi
  if((prevp = freep) == 0){
    1579:	85 d2                	test   %edx,%edx
    157b:	0f 84 95 00 00 00    	je     1616 <malloc+0xb6>
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
    1590:	be 00 10 00 00       	mov    $0x1000,%esi
    1595:	0f 43 f7             	cmovae %edi,%esi
    1598:	ba 00 80 00 00       	mov    $0x8000,%edx
    159d:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
    15a4:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
    15aa:	0f 46 da             	cmovbe %edx,%ebx
    15ad:	eb 0a                	jmp    15b9 <malloc+0x59>
    15af:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15b0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    15b2:	8b 48 04             	mov    0x4(%eax),%ecx
    15b5:	39 cf                	cmp    %ecx,%edi
    15b7:	76 37                	jbe    15f0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    15b9:	39 05 64 1e 00 00    	cmp    %eax,0x1e64
    15bf:	89 c2                	mov    %eax,%edx
    15c1:	75 ed                	jne    15b0 <malloc+0x50>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    15c3:	89 1c 24             	mov    %ebx,(%esp)
    15c6:	e8 35 fc ff ff       	call   1200 <sbrk>
  if(p == (char*)-1)
    15cb:	83 f8 ff             	cmp    $0xffffffff,%eax
    15ce:	74 18                	je     15e8 <malloc+0x88>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    15d0:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
    15d3:	83 c0 08             	add    $0x8,%eax
    15d6:	89 04 24             	mov    %eax,(%esp)
    15d9:	e8 e2 fe ff ff       	call   14c0 <free>
  return freep;
    15de:	8b 15 64 1e 00 00    	mov    0x1e64,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    15e4:	85 d2                	test   %edx,%edx
    15e6:	75 c8                	jne    15b0 <malloc+0x50>
        return 0;
    15e8:	31 c0                	xor    %eax,%eax
    15ea:	eb 1c                	jmp    1608 <malloc+0xa8>
    15ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    15f0:	39 cf                	cmp    %ecx,%edi
    15f2:	74 1c                	je     1610 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    15f4:	29 f9                	sub    %edi,%ecx
    15f6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    15f9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    15fc:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
    15ff:	89 15 64 1e 00 00    	mov    %edx,0x1e64
      return (void*)(p + 1);
    1605:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1608:	83 c4 1c             	add    $0x1c,%esp
    160b:	5b                   	pop    %ebx
    160c:	5e                   	pop    %esi
    160d:	5f                   	pop    %edi
    160e:	5d                   	pop    %ebp
    160f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    1610:	8b 08                	mov    (%eax),%ecx
    1612:	89 0a                	mov    %ecx,(%edx)
    1614:	eb e9                	jmp    15ff <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    1616:	b8 68 1e 00 00       	mov    $0x1e68,%eax
    161b:	ba 68 1e 00 00       	mov    $0x1e68,%edx
    base.s.size = 0;
    1620:	31 c9                	xor    %ecx,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    1622:	a3 64 1e 00 00       	mov    %eax,0x1e64
    base.s.size = 0;
    1627:	b8 68 1e 00 00       	mov    $0x1e68,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    162c:	89 15 68 1e 00 00    	mov    %edx,0x1e68
    base.s.size = 0;
    1632:	89 0d 6c 1e 00 00    	mov    %ecx,0x1e6c
    1638:	e9 4d ff ff ff       	jmp    158a <malloc+0x2a>
