
_pathTest4:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "../../traps.h"
#include "../../memlayout.h"

void execute(char * command, char** args);

int main(int argc, char *argv[]){
   0:	55                   	push   %ebp
    char * command;
    char *args[4];

    printf(1,"copying cat to /notIn/path/cat\n");
   1:	b8 48 09 00 00       	mov    $0x948,%eax
int main(int argc, char *argv[]){
   6:	89 e5                	mov    %esp,%ebp
   8:	53                   	push   %ebx
    args[0] = "/ln";
    args[1] = "/cat";
    args[2] = "/notIn/path/cat";
   9:	bb f9 08 00 00       	mov    $0x8f9,%ebx
int main(int argc, char *argv[]){
   e:	83 e4 f0             	and    $0xfffffff0,%esp
  11:	83 ec 20             	sub    $0x20,%esp
    printf(1,"copying cat to /notIn/path/cat\n");
  14:	89 44 24 04          	mov    %eax,0x4(%esp)
  18:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1f:	e8 3c 05 00 00       	call   560 <printf>
    args[1] = "/cat";
  24:	b9 04 09 00 00       	mov    $0x904,%ecx
    args[0] = "/ln";
  29:	ba f5 08 00 00       	mov    $0x8f5,%edx
    args[2] = "/notIn/path/cat";
  2e:	89 5c 24 18          	mov    %ebx,0x18(%esp)
    args[3] = 0;
    command = "/ln";
    execute(command,args);
  32:	8d 5c 24 10          	lea    0x10(%esp),%ebx
    args[3] = 0;
  36:	31 c0                	xor    %eax,%eax
    execute(command,args);
  38:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  3c:	c7 04 24 f5 08 00 00 	movl   $0x8f5,(%esp)
    args[1] = "/cat";
  43:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    args[0] = "/ln";
  47:	89 54 24 10          	mov    %edx,0x10(%esp)
    args[3] = 0;
  4b:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    execute(command,args);
  4f:	e8 ec 00 00 00       	call   140 <execute>
    
    printf(1,"copying echo to /notIn/path/echo\n");
  54:	b8 68 09 00 00       	mov    $0x968,%eax
  59:	89 44 24 04          	mov    %eax,0x4(%esp)
  5d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  64:	e8 f7 04 00 00       	call   560 <printf>
    args[0] = "/ln";
  69:	b8 f5 08 00 00       	mov    $0x8f5,%eax
  6e:	89 44 24 10          	mov    %eax,0x10(%esp)
    args[1] = "/echo";
  72:	b8 14 09 00 00       	mov    $0x914,%eax
  77:	89 44 24 14          	mov    %eax,0x14(%esp)
    args[2] = "/notIn/path/echo";
  7b:	b8 09 09 00 00       	mov    $0x909,%eax
  80:	89 44 24 18          	mov    %eax,0x18(%esp)
    args[3] = 0;
  84:	31 c0                	xor    %eax,%eax
    command = "/ln";
    execute(command,args);
  86:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  8a:	c7 04 24 f5 08 00 00 	movl   $0x8f5,(%esp)
    args[3] = 0;
  91:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    execute(command,args);
  95:	e8 a6 00 00 00       	call   140 <execute>

    printf(1,"removing /cat\n");
  9a:	ba 1a 09 00 00       	mov    $0x91a,%edx
  9f:	89 54 24 04          	mov    %edx,0x4(%esp)
  a3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  aa:	e8 b1 04 00 00       	call   560 <printf>
    args[0] = "/rm";
    args[1] = "/cat";
  af:	b8 04 09 00 00       	mov    $0x904,%eax
    args[0] = "/rm";
  b4:	b9 29 09 00 00       	mov    $0x929,%ecx
    args[1] = "/cat";
  b9:	89 44 24 14          	mov    %eax,0x14(%esp)
    args[2] = 0;
  bd:	31 c0                	xor    %eax,%eax
    command = "/rm";
    execute(command,args);
  bf:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  c3:	c7 04 24 29 09 00 00 	movl   $0x929,(%esp)
    args[0] = "/rm";
  ca:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    args[2] = 0;
  ce:	89 44 24 18          	mov    %eax,0x18(%esp)
    execute(command,args);
  d2:	e8 69 00 00 00       	call   140 <execute>

    printf(1,"removing /echo\n");
  d7:	b8 2d 09 00 00       	mov    $0x92d,%eax
  dc:	89 44 24 04          	mov    %eax,0x4(%esp)
  e0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  e7:	e8 74 04 00 00       	call   560 <printf>
    args[0] = "/rm";
  ec:	b8 29 09 00 00       	mov    $0x929,%eax
  f1:	89 44 24 10          	mov    %eax,0x10(%esp)
    args[1] = "/echo";
  f5:	b8 14 09 00 00       	mov    $0x914,%eax
  fa:	89 44 24 14          	mov    %eax,0x14(%esp)
    args[2] = 0;
  fe:	31 c0                	xor    %eax,%eax
    command = "/rm";
    execute(command,args);
 100:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 104:	c7 04 24 29 09 00 00 	movl   $0x929,(%esp)
    args[2] = 0;
 10b:	89 44 24 18          	mov    %eax,0x18(%esp)
    execute(command,args);
 10f:	e8 2c 00 00 00       	call   140 <execute>

    printf(1,"exiting\n");
 114:	ba 3d 09 00 00       	mov    $0x93d,%edx
 119:	89 54 24 04          	mov    %edx,0x4(%esp)
 11d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 124:	e8 37 04 00 00       	call   560 <printf>

    exit(0);
 129:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 130:	e8 c3 02 00 00       	call   3f8 <exit>
 135:	66 90                	xchg   %ax,%ax
 137:	66 90                	xchg   %ax,%ax
 139:	66 90                	xchg   %ax,%ax
 13b:	66 90                	xchg   %ax,%ax
 13d:	66 90                	xchg   %ax,%ax
 13f:	90                   	nop

00000140 <execute>:
}

void execute(char * command, char** args){
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	83 ec 18             	sub    $0x18,%esp
 146:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 149:	8b 5d 08             	mov    0x8(%ebp),%ebx
 14c:	89 75 fc             	mov    %esi,-0x4(%ebp)
 14f:	8b 75 0c             	mov    0xc(%ebp),%esi
    int pid;

    if((pid = fork()) == 0){
 152:	e8 99 02 00 00       	call   3f0 <fork>
 157:	83 f8 00             	cmp    $0x0,%eax
 15a:	74 3c                	je     198 <execute+0x58>
        exec(command, args);
        printf(1, "exec %s failed\n", command);
    }
    else if(pid > 0){
 15c:	7e 1a                	jle    178 <execute+0x38>
        //printf(1,"waiting for exec of %s to finish\n",command);
        wait(null);
 15e:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
    }
    else{
        printf(1,"fork failed\n");
    }

}
 165:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 168:	8b 75 fc             	mov    -0x4(%ebp),%esi
 16b:	89 ec                	mov    %ebp,%esp
 16d:	5d                   	pop    %ebp
        wait(null);
 16e:	e9 8d 02 00 00       	jmp    400 <wait>
 173:	90                   	nop
 174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1,"fork failed\n");
 178:	c7 45 0c e8 08 00 00 	movl   $0x8e8,0xc(%ebp)
}
 17f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
        printf(1,"fork failed\n");
 182:	c7 45 08 01 00 00 00 	movl   $0x1,0x8(%ebp)
}
 189:	8b 75 fc             	mov    -0x4(%ebp),%esi
 18c:	89 ec                	mov    %ebp,%esp
 18e:	5d                   	pop    %ebp
        printf(1,"fork failed\n");
 18f:	e9 cc 03 00 00       	jmp    560 <printf>
 194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        exec(command, args);
 198:	89 74 24 04          	mov    %esi,0x4(%esp)
 19c:	89 1c 24             	mov    %ebx,(%esp)
 19f:	e8 8c 02 00 00       	call   430 <exec>
        printf(1, "exec %s failed\n", command);
 1a4:	b8 d8 08 00 00       	mov    $0x8d8,%eax
 1a9:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 1ad:	89 44 24 04          	mov    %eax,0x4(%esp)
 1b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1b8:	e8 a3 03 00 00       	call   560 <printf>
}
 1bd:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 1c0:	8b 75 fc             	mov    -0x4(%ebp),%esi
 1c3:	89 ec                	mov    %ebp,%esp
 1c5:	5d                   	pop    %ebp
 1c6:	c3                   	ret    
 1c7:	66 90                	xchg   %ax,%ax
 1c9:	66 90                	xchg   %ax,%ax
 1cb:	66 90                	xchg   %ax,%ax
 1cd:	66 90                	xchg   %ax,%ax
 1cf:	90                   	nop

000001d0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	8b 45 08             	mov    0x8(%ebp),%eax
 1d6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1d9:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1da:	89 c2                	mov    %eax,%edx
 1dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1e0:	41                   	inc    %ecx
 1e1:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 1e5:	42                   	inc    %edx
 1e6:	84 db                	test   %bl,%bl
 1e8:	88 5a ff             	mov    %bl,-0x1(%edx)
 1eb:	75 f3                	jne    1e0 <strcpy+0x10>
    ;
  return os;
}
 1ed:	5b                   	pop    %ebx
 1ee:	5d                   	pop    %ebp
 1ef:	c3                   	ret    

000001f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1f6:	53                   	push   %ebx
 1f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 1fa:	0f b6 01             	movzbl (%ecx),%eax
 1fd:	0f b6 13             	movzbl (%ebx),%edx
 200:	84 c0                	test   %al,%al
 202:	75 18                	jne    21c <strcmp+0x2c>
 204:	eb 22                	jmp    228 <strcmp+0x38>
 206:	8d 76 00             	lea    0x0(%esi),%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 210:	41                   	inc    %ecx
  while(*p && *p == *q)
 211:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 214:	43                   	inc    %ebx
 215:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
 218:	84 c0                	test   %al,%al
 21a:	74 0c                	je     228 <strcmp+0x38>
 21c:	38 d0                	cmp    %dl,%al
 21e:	74 f0                	je     210 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
 220:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 221:	29 d0                	sub    %edx,%eax
}
 223:	5d                   	pop    %ebp
 224:	c3                   	ret    
 225:	8d 76 00             	lea    0x0(%esi),%esi
 228:	5b                   	pop    %ebx
 229:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 22b:	29 d0                	sub    %edx,%eax
}
 22d:	5d                   	pop    %ebp
 22e:	c3                   	ret    
 22f:	90                   	nop

00000230 <strlen>:

uint
strlen(const char *s)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 236:	80 39 00             	cmpb   $0x0,(%ecx)
 239:	74 15                	je     250 <strlen+0x20>
 23b:	31 d2                	xor    %edx,%edx
 23d:	8d 76 00             	lea    0x0(%esi),%esi
 240:	42                   	inc    %edx
 241:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 245:	89 d0                	mov    %edx,%eax
 247:	75 f7                	jne    240 <strlen+0x10>
    ;
  return n;
}
 249:	5d                   	pop    %ebp
 24a:	c3                   	ret    
 24b:	90                   	nop
 24c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
 250:	31 c0                	xor    %eax,%eax
}
 252:	5d                   	pop    %ebp
 253:	c3                   	ret    
 254:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 25a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000260 <memset>:

void*
memset(void *dst, int c, uint n)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	8b 55 08             	mov    0x8(%ebp),%edx
 266:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 267:	8b 4d 10             	mov    0x10(%ebp),%ecx
 26a:	8b 45 0c             	mov    0xc(%ebp),%eax
 26d:	89 d7                	mov    %edx,%edi
 26f:	fc                   	cld    
 270:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 272:	5f                   	pop    %edi
 273:	89 d0                	mov    %edx,%eax
 275:	5d                   	pop    %ebp
 276:	c3                   	ret    
 277:	89 f6                	mov    %esi,%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000280 <strchr>:

char*
strchr(const char *s, char c)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	8b 45 08             	mov    0x8(%ebp),%eax
 286:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 28a:	0f b6 10             	movzbl (%eax),%edx
 28d:	84 d2                	test   %dl,%dl
 28f:	74 1b                	je     2ac <strchr+0x2c>
    if(*s == c)
 291:	38 d1                	cmp    %dl,%cl
 293:	75 0f                	jne    2a4 <strchr+0x24>
 295:	eb 17                	jmp    2ae <strchr+0x2e>
 297:	89 f6                	mov    %esi,%esi
 299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 2a0:	38 ca                	cmp    %cl,%dl
 2a2:	74 0a                	je     2ae <strchr+0x2e>
  for(; *s; s++)
 2a4:	40                   	inc    %eax
 2a5:	0f b6 10             	movzbl (%eax),%edx
 2a8:	84 d2                	test   %dl,%dl
 2aa:	75 f4                	jne    2a0 <strchr+0x20>
      return (char*)s;
  return 0;
 2ac:	31 c0                	xor    %eax,%eax
}
 2ae:	5d                   	pop    %ebp
 2af:	c3                   	ret    

000002b0 <gets>:

char*
gets(char *buf, int max)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	57                   	push   %edi
 2b4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2b5:	31 f6                	xor    %esi,%esi
{
 2b7:	53                   	push   %ebx
 2b8:	83 ec 3c             	sub    $0x3c,%esp
 2bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
 2be:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 2c1:	eb 32                	jmp    2f5 <gets+0x45>
 2c3:	90                   	nop
 2c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 2c8:	ba 01 00 00 00       	mov    $0x1,%edx
 2cd:	89 54 24 08          	mov    %edx,0x8(%esp)
 2d1:	89 7c 24 04          	mov    %edi,0x4(%esp)
 2d5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2dc:	e8 2f 01 00 00       	call   410 <read>
    if(cc < 1)
 2e1:	85 c0                	test   %eax,%eax
 2e3:	7e 19                	jle    2fe <gets+0x4e>
      break;
    buf[i++] = c;
 2e5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2e9:	43                   	inc    %ebx
 2ea:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
 2ed:	3c 0a                	cmp    $0xa,%al
 2ef:	74 1f                	je     310 <gets+0x60>
 2f1:	3c 0d                	cmp    $0xd,%al
 2f3:	74 1b                	je     310 <gets+0x60>
  for(i=0; i+1 < max; ){
 2f5:	46                   	inc    %esi
 2f6:	3b 75 0c             	cmp    0xc(%ebp),%esi
 2f9:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 2fc:	7c ca                	jl     2c8 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 2fe:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 301:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 304:	8b 45 08             	mov    0x8(%ebp),%eax
 307:	83 c4 3c             	add    $0x3c,%esp
 30a:	5b                   	pop    %ebx
 30b:	5e                   	pop    %esi
 30c:	5f                   	pop    %edi
 30d:	5d                   	pop    %ebp
 30e:	c3                   	ret    
 30f:	90                   	nop
 310:	8b 45 08             	mov    0x8(%ebp),%eax
 313:	01 c6                	add    %eax,%esi
 315:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 318:	eb e4                	jmp    2fe <gets+0x4e>
 31a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000320 <stat>:

int
stat(const char *n, struct stat *st)
{
 320:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 321:	31 c0                	xor    %eax,%eax
{
 323:	89 e5                	mov    %esp,%ebp
 325:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 328:	89 44 24 04          	mov    %eax,0x4(%esp)
 32c:	8b 45 08             	mov    0x8(%ebp),%eax
{
 32f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 332:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 335:	89 04 24             	mov    %eax,(%esp)
 338:	e8 fb 00 00 00       	call   438 <open>
  if(fd < 0)
 33d:	85 c0                	test   %eax,%eax
 33f:	78 2f                	js     370 <stat+0x50>
 341:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 343:	8b 45 0c             	mov    0xc(%ebp),%eax
 346:	89 1c 24             	mov    %ebx,(%esp)
 349:	89 44 24 04          	mov    %eax,0x4(%esp)
 34d:	e8 fe 00 00 00       	call   450 <fstat>
  close(fd);
 352:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 355:	89 c6                	mov    %eax,%esi
  close(fd);
 357:	e8 c4 00 00 00       	call   420 <close>
  return r;
}
 35c:	89 f0                	mov    %esi,%eax
 35e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 361:	8b 75 fc             	mov    -0x4(%ebp),%esi
 364:	89 ec                	mov    %ebp,%esp
 366:	5d                   	pop    %ebp
 367:	c3                   	ret    
 368:	90                   	nop
 369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 370:	be ff ff ff ff       	mov    $0xffffffff,%esi
 375:	eb e5                	jmp    35c <stat+0x3c>
 377:	89 f6                	mov    %esi,%esi
 379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000380 <atoi>:

int
atoi(const char *s)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	8b 4d 08             	mov    0x8(%ebp),%ecx
 386:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 387:	0f be 11             	movsbl (%ecx),%edx
 38a:	88 d0                	mov    %dl,%al
 38c:	2c 30                	sub    $0x30,%al
 38e:	3c 09                	cmp    $0x9,%al
  n = 0;
 390:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 395:	77 1e                	ja     3b5 <atoi+0x35>
 397:	89 f6                	mov    %esi,%esi
 399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 3a0:	41                   	inc    %ecx
 3a1:	8d 04 80             	lea    (%eax,%eax,4),%eax
 3a4:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 3a8:	0f be 11             	movsbl (%ecx),%edx
 3ab:	88 d3                	mov    %dl,%bl
 3ad:	80 eb 30             	sub    $0x30,%bl
 3b0:	80 fb 09             	cmp    $0x9,%bl
 3b3:	76 eb                	jbe    3a0 <atoi+0x20>
  return n;
}
 3b5:	5b                   	pop    %ebx
 3b6:	5d                   	pop    %ebp
 3b7:	c3                   	ret    
 3b8:	90                   	nop
 3b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003c0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	56                   	push   %esi
 3c4:	8b 45 08             	mov    0x8(%ebp),%eax
 3c7:	53                   	push   %ebx
 3c8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3ce:	85 db                	test   %ebx,%ebx
 3d0:	7e 1a                	jle    3ec <memmove+0x2c>
 3d2:	31 d2                	xor    %edx,%edx
 3d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 3e0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 3e4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 3e7:	42                   	inc    %edx
  while(n-- > 0)
 3e8:	39 d3                	cmp    %edx,%ebx
 3ea:	75 f4                	jne    3e0 <memmove+0x20>
  return vdst;
}
 3ec:	5b                   	pop    %ebx
 3ed:	5e                   	pop    %esi
 3ee:	5d                   	pop    %ebp
 3ef:	c3                   	ret    

000003f0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3f0:	b8 01 00 00 00       	mov    $0x1,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <exit>:
SYSCALL(exit)
 3f8:	b8 02 00 00 00       	mov    $0x2,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <wait>:
SYSCALL(wait)
 400:	b8 03 00 00 00       	mov    $0x3,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <pipe>:
SYSCALL(pipe)
 408:	b8 04 00 00 00       	mov    $0x4,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <read>:
SYSCALL(read)
 410:	b8 05 00 00 00       	mov    $0x5,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <write>:
SYSCALL(write)
 418:	b8 10 00 00 00       	mov    $0x10,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <close>:
SYSCALL(close)
 420:	b8 15 00 00 00       	mov    $0x15,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <kill>:
SYSCALL(kill)
 428:	b8 06 00 00 00       	mov    $0x6,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <exec>:
SYSCALL(exec)
 430:	b8 07 00 00 00       	mov    $0x7,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <open>:
SYSCALL(open)
 438:	b8 0f 00 00 00       	mov    $0xf,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <mknod>:
SYSCALL(mknod)
 440:	b8 11 00 00 00       	mov    $0x11,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <unlink>:
SYSCALL(unlink)
 448:	b8 12 00 00 00       	mov    $0x12,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <fstat>:
SYSCALL(fstat)
 450:	b8 08 00 00 00       	mov    $0x8,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <link>:
SYSCALL(link)
 458:	b8 13 00 00 00       	mov    $0x13,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <mkdir>:
SYSCALL(mkdir)
 460:	b8 14 00 00 00       	mov    $0x14,%eax
 465:	cd 40                	int    $0x40
 467:	c3                   	ret    

00000468 <chdir>:
SYSCALL(chdir)
 468:	b8 09 00 00 00       	mov    $0x9,%eax
 46d:	cd 40                	int    $0x40
 46f:	c3                   	ret    

00000470 <dup>:
SYSCALL(dup)
 470:	b8 0a 00 00 00       	mov    $0xa,%eax
 475:	cd 40                	int    $0x40
 477:	c3                   	ret    

00000478 <getpid>:
SYSCALL(getpid)
 478:	b8 0b 00 00 00       	mov    $0xb,%eax
 47d:	cd 40                	int    $0x40
 47f:	c3                   	ret    

00000480 <sbrk>:
SYSCALL(sbrk)
 480:	b8 0c 00 00 00       	mov    $0xc,%eax
 485:	cd 40                	int    $0x40
 487:	c3                   	ret    

00000488 <sleep>:
SYSCALL(sleep)
 488:	b8 0d 00 00 00       	mov    $0xd,%eax
 48d:	cd 40                	int    $0x40
 48f:	c3                   	ret    

00000490 <uptime>:
SYSCALL(uptime)
 490:	b8 0e 00 00 00       	mov    $0xe,%eax
 495:	cd 40                	int    $0x40
 497:	c3                   	ret    

00000498 <policy>:
SYSCALL(policy)
 498:	b8 17 00 00 00       	mov    $0x17,%eax
 49d:	cd 40                	int    $0x40
 49f:	c3                   	ret    

000004a0 <detach>:
SYSCALL(detach)
 4a0:	b8 16 00 00 00       	mov    $0x16,%eax
 4a5:	cd 40                	int    $0x40
 4a7:	c3                   	ret    

000004a8 <priority>:
SYSCALL(priority)
 4a8:	b8 18 00 00 00       	mov    $0x18,%eax
 4ad:	cd 40                	int    $0x40
 4af:	c3                   	ret    

000004b0 <wait_stat>:
SYSCALL(wait_stat)
 4b0:	b8 19 00 00 00       	mov    $0x19,%eax
 4b5:	cd 40                	int    $0x40
 4b7:	c3                   	ret    
 4b8:	66 90                	xchg   %ax,%ax
 4ba:	66 90                	xchg   %ax,%ax
 4bc:	66 90                	xchg   %ax,%ax
 4be:	66 90                	xchg   %ax,%ax

000004c0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	56                   	push   %esi
 4c5:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4c6:	89 d3                	mov    %edx,%ebx
 4c8:	c1 eb 1f             	shr    $0x1f,%ebx
{
 4cb:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 4ce:	84 db                	test   %bl,%bl
{
 4d0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 4d3:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 4d5:	74 79                	je     550 <printint+0x90>
 4d7:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4db:	74 73                	je     550 <printint+0x90>
    neg = 1;
    x = -xx;
 4dd:	f7 d8                	neg    %eax
    neg = 1;
 4df:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 4e6:	31 f6                	xor    %esi,%esi
 4e8:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 4eb:	eb 05                	jmp    4f2 <printint+0x32>
 4ed:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4f0:	89 fe                	mov    %edi,%esi
 4f2:	31 d2                	xor    %edx,%edx
 4f4:	f7 f1                	div    %ecx
 4f6:	8d 7e 01             	lea    0x1(%esi),%edi
 4f9:	0f b6 92 94 09 00 00 	movzbl 0x994(%edx),%edx
  }while((x /= base) != 0);
 500:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 502:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 505:	75 e9                	jne    4f0 <printint+0x30>
  if(neg)
 507:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 50a:	85 d2                	test   %edx,%edx
 50c:	74 08                	je     516 <printint+0x56>
    buf[i++] = '-';
 50e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 513:	8d 7e 02             	lea    0x2(%esi),%edi
 516:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 51a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 51d:	8d 76 00             	lea    0x0(%esi),%esi
 520:	0f b6 06             	movzbl (%esi),%eax
 523:	4e                   	dec    %esi
  write(fd, &c, 1);
 524:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 528:	89 3c 24             	mov    %edi,(%esp)
 52b:	88 45 d7             	mov    %al,-0x29(%ebp)
 52e:	b8 01 00 00 00       	mov    $0x1,%eax
 533:	89 44 24 08          	mov    %eax,0x8(%esp)
 537:	e8 dc fe ff ff       	call   418 <write>

  while(--i >= 0)
 53c:	39 de                	cmp    %ebx,%esi
 53e:	75 e0                	jne    520 <printint+0x60>
    putc(fd, buf[i]);
}
 540:	83 c4 4c             	add    $0x4c,%esp
 543:	5b                   	pop    %ebx
 544:	5e                   	pop    %esi
 545:	5f                   	pop    %edi
 546:	5d                   	pop    %ebp
 547:	c3                   	ret    
 548:	90                   	nop
 549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 550:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 557:	eb 8d                	jmp    4e6 <printint+0x26>
 559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000560 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	57                   	push   %edi
 564:	56                   	push   %esi
 565:	53                   	push   %ebx
 566:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 569:	8b 75 0c             	mov    0xc(%ebp),%esi
 56c:	0f b6 1e             	movzbl (%esi),%ebx
 56f:	84 db                	test   %bl,%bl
 571:	0f 84 d1 00 00 00    	je     648 <printf+0xe8>
  state = 0;
 577:	31 ff                	xor    %edi,%edi
 579:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 57a:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 57d:	89 fa                	mov    %edi,%edx
 57f:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 582:	89 45 d0             	mov    %eax,-0x30(%ebp)
 585:	eb 41                	jmp    5c8 <printf+0x68>
 587:	89 f6                	mov    %esi,%esi
 589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 590:	83 f8 25             	cmp    $0x25,%eax
 593:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 596:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 59b:	74 1e                	je     5bb <printf+0x5b>
  write(fd, &c, 1);
 59d:	b8 01 00 00 00       	mov    $0x1,%eax
 5a2:	89 44 24 08          	mov    %eax,0x8(%esp)
 5a6:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 5a9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ad:	89 3c 24             	mov    %edi,(%esp)
 5b0:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 5b3:	e8 60 fe ff ff       	call   418 <write>
 5b8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 5bb:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 5bc:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 5c0:	84 db                	test   %bl,%bl
 5c2:	0f 84 80 00 00 00    	je     648 <printf+0xe8>
    if(state == 0){
 5c8:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 5ca:	0f be cb             	movsbl %bl,%ecx
 5cd:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 5d0:	74 be                	je     590 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5d2:	83 fa 25             	cmp    $0x25,%edx
 5d5:	75 e4                	jne    5bb <printf+0x5b>
      if(c == 'd'){
 5d7:	83 f8 64             	cmp    $0x64,%eax
 5da:	0f 84 f0 00 00 00    	je     6d0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5e0:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 5e6:	83 f9 70             	cmp    $0x70,%ecx
 5e9:	74 65                	je     650 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5eb:	83 f8 73             	cmp    $0x73,%eax
 5ee:	0f 84 8c 00 00 00    	je     680 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5f4:	83 f8 63             	cmp    $0x63,%eax
 5f7:	0f 84 13 01 00 00    	je     710 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5fd:	83 f8 25             	cmp    $0x25,%eax
 600:	0f 84 e2 00 00 00    	je     6e8 <printf+0x188>
  write(fd, &c, 1);
 606:	b8 01 00 00 00       	mov    $0x1,%eax
 60b:	46                   	inc    %esi
 60c:	89 44 24 08          	mov    %eax,0x8(%esp)
 610:	8d 45 e7             	lea    -0x19(%ebp),%eax
 613:	89 44 24 04          	mov    %eax,0x4(%esp)
 617:	89 3c 24             	mov    %edi,(%esp)
 61a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 61e:	e8 f5 fd ff ff       	call   418 <write>
 623:	ba 01 00 00 00       	mov    $0x1,%edx
 628:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 62b:	89 54 24 08          	mov    %edx,0x8(%esp)
 62f:	89 44 24 04          	mov    %eax,0x4(%esp)
 633:	89 3c 24             	mov    %edi,(%esp)
 636:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 639:	e8 da fd ff ff       	call   418 <write>
  for(i = 0; fmt[i]; i++){
 63e:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 642:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 644:	84 db                	test   %bl,%bl
 646:	75 80                	jne    5c8 <printf+0x68>
    }
  }
}
 648:	83 c4 3c             	add    $0x3c,%esp
 64b:	5b                   	pop    %ebx
 64c:	5e                   	pop    %esi
 64d:	5f                   	pop    %edi
 64e:	5d                   	pop    %ebp
 64f:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 650:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 657:	b9 10 00 00 00       	mov    $0x10,%ecx
 65c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 65f:	89 f8                	mov    %edi,%eax
 661:	8b 13                	mov    (%ebx),%edx
 663:	e8 58 fe ff ff       	call   4c0 <printint>
        ap++;
 668:	89 d8                	mov    %ebx,%eax
      state = 0;
 66a:	31 d2                	xor    %edx,%edx
        ap++;
 66c:	83 c0 04             	add    $0x4,%eax
 66f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 672:	e9 44 ff ff ff       	jmp    5bb <printf+0x5b>
 677:	89 f6                	mov    %esi,%esi
 679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 680:	8b 45 d0             	mov    -0x30(%ebp),%eax
 683:	8b 10                	mov    (%eax),%edx
        ap++;
 685:	83 c0 04             	add    $0x4,%eax
 688:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 68b:	85 d2                	test   %edx,%edx
 68d:	0f 84 aa 00 00 00    	je     73d <printf+0x1dd>
        while(*s != 0){
 693:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 696:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 698:	84 c0                	test   %al,%al
 69a:	74 27                	je     6c3 <printf+0x163>
 69c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6a0:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 6a3:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 6a8:	43                   	inc    %ebx
  write(fd, &c, 1);
 6a9:	89 44 24 08          	mov    %eax,0x8(%esp)
 6ad:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 6b0:	89 44 24 04          	mov    %eax,0x4(%esp)
 6b4:	89 3c 24             	mov    %edi,(%esp)
 6b7:	e8 5c fd ff ff       	call   418 <write>
        while(*s != 0){
 6bc:	0f b6 03             	movzbl (%ebx),%eax
 6bf:	84 c0                	test   %al,%al
 6c1:	75 dd                	jne    6a0 <printf+0x140>
      state = 0;
 6c3:	31 d2                	xor    %edx,%edx
 6c5:	e9 f1 fe ff ff       	jmp    5bb <printf+0x5b>
 6ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 6d0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 6d7:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6dc:	e9 7b ff ff ff       	jmp    65c <printf+0xfc>
 6e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 6e8:	b9 01 00 00 00       	mov    $0x1,%ecx
 6ed:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 6f0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 6f4:	89 44 24 04          	mov    %eax,0x4(%esp)
 6f8:	89 3c 24             	mov    %edi,(%esp)
 6fb:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 6fe:	e8 15 fd ff ff       	call   418 <write>
      state = 0;
 703:	31 d2                	xor    %edx,%edx
 705:	e9 b1 fe ff ff       	jmp    5bb <printf+0x5b>
 70a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 710:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 713:	8b 03                	mov    (%ebx),%eax
        ap++;
 715:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 718:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 71b:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 71e:	b8 01 00 00 00       	mov    $0x1,%eax
 723:	89 44 24 08          	mov    %eax,0x8(%esp)
 727:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 72a:	89 44 24 04          	mov    %eax,0x4(%esp)
 72e:	e8 e5 fc ff ff       	call   418 <write>
      state = 0;
 733:	31 d2                	xor    %edx,%edx
        ap++;
 735:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 738:	e9 7e fe ff ff       	jmp    5bb <printf+0x5b>
          s = "(null)";
 73d:	bb 8c 09 00 00       	mov    $0x98c,%ebx
        while(*s != 0){
 742:	b0 28                	mov    $0x28,%al
 744:	e9 57 ff ff ff       	jmp    6a0 <printf+0x140>
 749:	66 90                	xchg   %ax,%ax
 74b:	66 90                	xchg   %ax,%ax
 74d:	66 90                	xchg   %ax,%ax
 74f:	90                   	nop

00000750 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 750:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 751:	a1 60 0c 00 00       	mov    0xc60,%eax
{
 756:	89 e5                	mov    %esp,%ebp
 758:	57                   	push   %edi
 759:	56                   	push   %esi
 75a:	53                   	push   %ebx
 75b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 75e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 761:	eb 0d                	jmp    770 <free+0x20>
 763:	90                   	nop
 764:	90                   	nop
 765:	90                   	nop
 766:	90                   	nop
 767:	90                   	nop
 768:	90                   	nop
 769:	90                   	nop
 76a:	90                   	nop
 76b:	90                   	nop
 76c:	90                   	nop
 76d:	90                   	nop
 76e:	90                   	nop
 76f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 770:	39 c8                	cmp    %ecx,%eax
 772:	8b 10                	mov    (%eax),%edx
 774:	73 32                	jae    7a8 <free+0x58>
 776:	39 d1                	cmp    %edx,%ecx
 778:	72 04                	jb     77e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 77a:	39 d0                	cmp    %edx,%eax
 77c:	72 32                	jb     7b0 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 77e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 781:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 784:	39 fa                	cmp    %edi,%edx
 786:	74 30                	je     7b8 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 788:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 78b:	8b 50 04             	mov    0x4(%eax),%edx
 78e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 791:	39 f1                	cmp    %esi,%ecx
 793:	74 3c                	je     7d1 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 795:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 797:	5b                   	pop    %ebx
  freep = p;
 798:	a3 60 0c 00 00       	mov    %eax,0xc60
}
 79d:	5e                   	pop    %esi
 79e:	5f                   	pop    %edi
 79f:	5d                   	pop    %ebp
 7a0:	c3                   	ret    
 7a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a8:	39 d0                	cmp    %edx,%eax
 7aa:	72 04                	jb     7b0 <free+0x60>
 7ac:	39 d1                	cmp    %edx,%ecx
 7ae:	72 ce                	jb     77e <free+0x2e>
{
 7b0:	89 d0                	mov    %edx,%eax
 7b2:	eb bc                	jmp    770 <free+0x20>
 7b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 7b8:	8b 7a 04             	mov    0x4(%edx),%edi
 7bb:	01 fe                	add    %edi,%esi
 7bd:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7c0:	8b 10                	mov    (%eax),%edx
 7c2:	8b 12                	mov    (%edx),%edx
 7c4:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7c7:	8b 50 04             	mov    0x4(%eax),%edx
 7ca:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7cd:	39 f1                	cmp    %esi,%ecx
 7cf:	75 c4                	jne    795 <free+0x45>
    p->s.size += bp->s.size;
 7d1:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 7d4:	a3 60 0c 00 00       	mov    %eax,0xc60
    p->s.size += bp->s.size;
 7d9:	01 ca                	add    %ecx,%edx
 7db:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7de:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7e1:	89 10                	mov    %edx,(%eax)
}
 7e3:	5b                   	pop    %ebx
 7e4:	5e                   	pop    %esi
 7e5:	5f                   	pop    %edi
 7e6:	5d                   	pop    %ebp
 7e7:	c3                   	ret    
 7e8:	90                   	nop
 7e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000007f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7f0:	55                   	push   %ebp
 7f1:	89 e5                	mov    %esp,%ebp
 7f3:	57                   	push   %edi
 7f4:	56                   	push   %esi
 7f5:	53                   	push   %ebx
 7f6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7fc:	8b 15 60 0c 00 00    	mov    0xc60,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 802:	8d 78 07             	lea    0x7(%eax),%edi
 805:	c1 ef 03             	shr    $0x3,%edi
 808:	47                   	inc    %edi
  if((prevp = freep) == 0){
 809:	85 d2                	test   %edx,%edx
 80b:	0f 84 8f 00 00 00    	je     8a0 <malloc+0xb0>
 811:	8b 02                	mov    (%edx),%eax
 813:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 816:	39 cf                	cmp    %ecx,%edi
 818:	76 66                	jbe    880 <malloc+0x90>
 81a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 820:	bb 00 10 00 00       	mov    $0x1000,%ebx
 825:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 828:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 82f:	eb 10                	jmp    841 <malloc+0x51>
 831:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 838:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 83a:	8b 48 04             	mov    0x4(%eax),%ecx
 83d:	39 f9                	cmp    %edi,%ecx
 83f:	73 3f                	jae    880 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 841:	39 05 60 0c 00 00    	cmp    %eax,0xc60
 847:	89 c2                	mov    %eax,%edx
 849:	75 ed                	jne    838 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 84b:	89 34 24             	mov    %esi,(%esp)
 84e:	e8 2d fc ff ff       	call   480 <sbrk>
  if(p == (char*)-1)
 853:	83 f8 ff             	cmp    $0xffffffff,%eax
 856:	74 18                	je     870 <malloc+0x80>
  hp->s.size = nu;
 858:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 85b:	83 c0 08             	add    $0x8,%eax
 85e:	89 04 24             	mov    %eax,(%esp)
 861:	e8 ea fe ff ff       	call   750 <free>
  return freep;
 866:	8b 15 60 0c 00 00    	mov    0xc60,%edx
      if((p = morecore(nunits)) == 0)
 86c:	85 d2                	test   %edx,%edx
 86e:	75 c8                	jne    838 <malloc+0x48>
        return 0;
  }
}
 870:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 873:	31 c0                	xor    %eax,%eax
}
 875:	5b                   	pop    %ebx
 876:	5e                   	pop    %esi
 877:	5f                   	pop    %edi
 878:	5d                   	pop    %ebp
 879:	c3                   	ret    
 87a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 880:	39 cf                	cmp    %ecx,%edi
 882:	74 4c                	je     8d0 <malloc+0xe0>
        p->s.size -= nunits;
 884:	29 f9                	sub    %edi,%ecx
 886:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 889:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 88c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 88f:	89 15 60 0c 00 00    	mov    %edx,0xc60
}
 895:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 898:	83 c0 08             	add    $0x8,%eax
}
 89b:	5b                   	pop    %ebx
 89c:	5e                   	pop    %esi
 89d:	5f                   	pop    %edi
 89e:	5d                   	pop    %ebp
 89f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 8a0:	b8 64 0c 00 00       	mov    $0xc64,%eax
 8a5:	ba 64 0c 00 00       	mov    $0xc64,%edx
    base.s.size = 0;
 8aa:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 8ac:	a3 60 0c 00 00       	mov    %eax,0xc60
    base.s.size = 0;
 8b1:	b8 64 0c 00 00       	mov    $0xc64,%eax
    base.s.ptr = freep = prevp = &base;
 8b6:	89 15 64 0c 00 00    	mov    %edx,0xc64
    base.s.size = 0;
 8bc:	89 0d 68 0c 00 00    	mov    %ecx,0xc68
 8c2:	e9 53 ff ff ff       	jmp    81a <malloc+0x2a>
 8c7:	89 f6                	mov    %esi,%esi
 8c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 8d0:	8b 08                	mov    (%eax),%ecx
 8d2:	89 0a                	mov    %ecx,(%edx)
 8d4:	eb b9                	jmp    88f <malloc+0x9f>
