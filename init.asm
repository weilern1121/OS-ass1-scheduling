
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	55                   	push   %ebp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   1:	b9 02 00 00 00       	mov    $0x2,%ecx
{
   6:	89 e5                	mov    %esp,%ebp
   8:	53                   	push   %ebx
   9:	83 e4 f0             	and    $0xfffffff0,%esp
   c:	83 ec 10             	sub    $0x10,%esp
  if(open("console", O_RDWR) < 0){
   f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  13:	c7 04 24 08 08 00 00 	movl   $0x808,(%esp)
  1a:	e8 69 03 00 00       	call   388 <open>
  1f:	85 c0                	test   %eax,%eax
  21:	0f 88 ba 00 00 00    	js     e1 <main+0xe1>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  27:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  2e:	e8 8d 03 00 00       	call   3c0 <dup>
  dup(0);  // stderr
  33:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3a:	e8 81 03 00 00       	call   3c0 <dup>
  3f:	90                   	nop

  for(;;){
    printf(1, "init: starting sh\n");
  40:	ba 10 08 00 00       	mov    $0x810,%edx
  45:	89 54 24 04          	mov    %edx,0x4(%esp)
  49:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  50:	e8 3b 04 00 00       	call   490 <printf>
    pid = fork();
  55:	e8 e6 02 00 00       	call   340 <fork>
    if(pid < 0){
  5a:	85 c0                	test   %eax,%eax
    pid = fork();
  5c:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  5e:	78 3b                	js     9b <main+0x9b>
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
  60:	74 52                	je     b4 <main+0xb4>
  62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  70:	e8 db 02 00 00       	call   350 <wait>
  75:	89 c2                	mov    %eax,%edx
  77:	f7 d2                	not    %edx
  79:	c1 ea 1f             	shr    $0x1f,%edx
  7c:	84 d2                	test   %dl,%dl
  7e:	74 c0                	je     40 <main+0x40>
  80:	39 c3                	cmp    %eax,%ebx
  82:	74 bc                	je     40 <main+0x40>
      printf(1, "zombie!\n");
  84:	b8 4f 08 00 00       	mov    $0x84f,%eax
  89:	89 44 24 04          	mov    %eax,0x4(%esp)
  8d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  94:	e8 f7 03 00 00       	call   490 <printf>
  99:	eb d5                	jmp    70 <main+0x70>
      printf(1, "init: fork failed\n");
  9b:	c7 44 24 04 23 08 00 	movl   $0x823,0x4(%esp)
  a2:	00 
  a3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  aa:	e8 e1 03 00 00       	call   490 <printf>
      exit();
  af:	e8 94 02 00 00       	call   348 <exit>
      exec("sh", argv);
  b4:	c7 44 24 04 ec 0a 00 	movl   $0xaec,0x4(%esp)
  bb:	00 
  bc:	c7 04 24 36 08 00 00 	movl   $0x836,(%esp)
  c3:	e8 b8 02 00 00       	call   380 <exec>
      printf(1, "init: exec sh failed\n");
  c8:	c7 44 24 04 39 08 00 	movl   $0x839,0x4(%esp)
  cf:	00 
  d0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  d7:	e8 b4 03 00 00       	call   490 <printf>
      exit();
  dc:	e8 67 02 00 00       	call   348 <exit>
    mknod("console", 1, 1);
  e1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  e8:	00 
  e9:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  f0:	00 
  f1:	c7 04 24 08 08 00 00 	movl   $0x808,(%esp)
  f8:	e8 93 02 00 00       	call   390 <mknod>
    open("console", O_RDWR);
  fd:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
 104:	00 
 105:	c7 04 24 08 08 00 00 	movl   $0x808,(%esp)
 10c:	e8 77 02 00 00       	call   388 <open>
 111:	e9 11 ff ff ff       	jmp    27 <main+0x27>
 116:	66 90                	xchg   %ax,%ax
 118:	66 90                	xchg   %ax,%ax
 11a:	66 90                	xchg   %ax,%ax
 11c:	66 90                	xchg   %ax,%ax
 11e:	66 90                	xchg   %ax,%ax

00000120 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	8b 45 08             	mov    0x8(%ebp),%eax
 126:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 129:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 12a:	89 c2                	mov    %eax,%edx
 12c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 130:	41                   	inc    %ecx
 131:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 135:	42                   	inc    %edx
 136:	84 db                	test   %bl,%bl
 138:	88 5a ff             	mov    %bl,-0x1(%edx)
 13b:	75 f3                	jne    130 <strcpy+0x10>
    ;
  return os;
}
 13d:	5b                   	pop    %ebx
 13e:	5d                   	pop    %ebp
 13f:	c3                   	ret    

00000140 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	8b 4d 08             	mov    0x8(%ebp),%ecx
 146:	53                   	push   %ebx
 147:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 14a:	0f b6 01             	movzbl (%ecx),%eax
 14d:	0f b6 13             	movzbl (%ebx),%edx
 150:	84 c0                	test   %al,%al
 152:	75 18                	jne    16c <strcmp+0x2c>
 154:	eb 22                	jmp    178 <strcmp+0x38>
 156:	8d 76 00             	lea    0x0(%esi),%esi
 159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 160:	41                   	inc    %ecx
  while(*p && *p == *q)
 161:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 164:	43                   	inc    %ebx
 165:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
 168:	84 c0                	test   %al,%al
 16a:	74 0c                	je     178 <strcmp+0x38>
 16c:	38 d0                	cmp    %dl,%al
 16e:	74 f0                	je     160 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
 170:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 171:	29 d0                	sub    %edx,%eax
}
 173:	5d                   	pop    %ebp
 174:	c3                   	ret    
 175:	8d 76 00             	lea    0x0(%esi),%esi
 178:	5b                   	pop    %ebx
 179:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 17b:	29 d0                	sub    %edx,%eax
}
 17d:	5d                   	pop    %ebp
 17e:	c3                   	ret    
 17f:	90                   	nop

00000180 <strlen>:

uint
strlen(const char *s)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 186:	80 39 00             	cmpb   $0x0,(%ecx)
 189:	74 15                	je     1a0 <strlen+0x20>
 18b:	31 d2                	xor    %edx,%edx
 18d:	8d 76 00             	lea    0x0(%esi),%esi
 190:	42                   	inc    %edx
 191:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 195:	89 d0                	mov    %edx,%eax
 197:	75 f7                	jne    190 <strlen+0x10>
    ;
  return n;
}
 199:	5d                   	pop    %ebp
 19a:	c3                   	ret    
 19b:	90                   	nop
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
 1a0:	31 c0                	xor    %eax,%eax
}
 1a2:	5d                   	pop    %ebp
 1a3:	c3                   	ret    
 1a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 55 08             	mov    0x8(%ebp),%edx
 1b6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 1bd:	89 d7                	mov    %edx,%edi
 1bf:	fc                   	cld    
 1c0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1c2:	5f                   	pop    %edi
 1c3:	89 d0                	mov    %edx,%eax
 1c5:	5d                   	pop    %ebp
 1c6:	c3                   	ret    
 1c7:	89 f6                	mov    %esi,%esi
 1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001d0 <strchr>:

char*
strchr(const char *s, char c)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	8b 45 08             	mov    0x8(%ebp),%eax
 1d6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1da:	0f b6 10             	movzbl (%eax),%edx
 1dd:	84 d2                	test   %dl,%dl
 1df:	74 1b                	je     1fc <strchr+0x2c>
    if(*s == c)
 1e1:	38 d1                	cmp    %dl,%cl
 1e3:	75 0f                	jne    1f4 <strchr+0x24>
 1e5:	eb 17                	jmp    1fe <strchr+0x2e>
 1e7:	89 f6                	mov    %esi,%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 1f0:	38 ca                	cmp    %cl,%dl
 1f2:	74 0a                	je     1fe <strchr+0x2e>
  for(; *s; s++)
 1f4:	40                   	inc    %eax
 1f5:	0f b6 10             	movzbl (%eax),%edx
 1f8:	84 d2                	test   %dl,%dl
 1fa:	75 f4                	jne    1f0 <strchr+0x20>
      return (char*)s;
  return 0;
 1fc:	31 c0                	xor    %eax,%eax
}
 1fe:	5d                   	pop    %ebp
 1ff:	c3                   	ret    

00000200 <gets>:

char*
gets(char *buf, int max)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	57                   	push   %edi
 204:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 205:	31 f6                	xor    %esi,%esi
{
 207:	53                   	push   %ebx
 208:	83 ec 3c             	sub    $0x3c,%esp
 20b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
 20e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 211:	eb 32                	jmp    245 <gets+0x45>
 213:	90                   	nop
 214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 218:	ba 01 00 00 00       	mov    $0x1,%edx
 21d:	89 54 24 08          	mov    %edx,0x8(%esp)
 221:	89 7c 24 04          	mov    %edi,0x4(%esp)
 225:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 22c:	e8 2f 01 00 00       	call   360 <read>
    if(cc < 1)
 231:	85 c0                	test   %eax,%eax
 233:	7e 19                	jle    24e <gets+0x4e>
      break;
    buf[i++] = c;
 235:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 239:	43                   	inc    %ebx
 23a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
 23d:	3c 0a                	cmp    $0xa,%al
 23f:	74 1f                	je     260 <gets+0x60>
 241:	3c 0d                	cmp    $0xd,%al
 243:	74 1b                	je     260 <gets+0x60>
  for(i=0; i+1 < max; ){
 245:	46                   	inc    %esi
 246:	3b 75 0c             	cmp    0xc(%ebp),%esi
 249:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 24c:	7c ca                	jl     218 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 24e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 251:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 254:	8b 45 08             	mov    0x8(%ebp),%eax
 257:	83 c4 3c             	add    $0x3c,%esp
 25a:	5b                   	pop    %ebx
 25b:	5e                   	pop    %esi
 25c:	5f                   	pop    %edi
 25d:	5d                   	pop    %ebp
 25e:	c3                   	ret    
 25f:	90                   	nop
 260:	8b 45 08             	mov    0x8(%ebp),%eax
 263:	01 c6                	add    %eax,%esi
 265:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 268:	eb e4                	jmp    24e <gets+0x4e>
 26a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000270 <stat>:

int
stat(const char *n, struct stat *st)
{
 270:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 271:	31 c0                	xor    %eax,%eax
{
 273:	89 e5                	mov    %esp,%ebp
 275:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 278:	89 44 24 04          	mov    %eax,0x4(%esp)
 27c:	8b 45 08             	mov    0x8(%ebp),%eax
{
 27f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 282:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 285:	89 04 24             	mov    %eax,(%esp)
 288:	e8 fb 00 00 00       	call   388 <open>
  if(fd < 0)
 28d:	85 c0                	test   %eax,%eax
 28f:	78 2f                	js     2c0 <stat+0x50>
 291:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 293:	8b 45 0c             	mov    0xc(%ebp),%eax
 296:	89 1c 24             	mov    %ebx,(%esp)
 299:	89 44 24 04          	mov    %eax,0x4(%esp)
 29d:	e8 fe 00 00 00       	call   3a0 <fstat>
  close(fd);
 2a2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2a5:	89 c6                	mov    %eax,%esi
  close(fd);
 2a7:	e8 c4 00 00 00       	call   370 <close>
  return r;
}
 2ac:	89 f0                	mov    %esi,%eax
 2ae:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 2b1:	8b 75 fc             	mov    -0x4(%ebp),%esi
 2b4:	89 ec                	mov    %ebp,%esp
 2b6:	5d                   	pop    %ebp
 2b7:	c3                   	ret    
 2b8:	90                   	nop
 2b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 2c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2c5:	eb e5                	jmp    2ac <stat+0x3c>
 2c7:	89 f6                	mov    %esi,%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002d0 <atoi>:

int
atoi(const char *s)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2d6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2d7:	0f be 11             	movsbl (%ecx),%edx
 2da:	88 d0                	mov    %dl,%al
 2dc:	2c 30                	sub    $0x30,%al
 2de:	3c 09                	cmp    $0x9,%al
  n = 0;
 2e0:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 2e5:	77 1e                	ja     305 <atoi+0x35>
 2e7:	89 f6                	mov    %esi,%esi
 2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 2f0:	41                   	inc    %ecx
 2f1:	8d 04 80             	lea    (%eax,%eax,4),%eax
 2f4:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 2f8:	0f be 11             	movsbl (%ecx),%edx
 2fb:	88 d3                	mov    %dl,%bl
 2fd:	80 eb 30             	sub    $0x30,%bl
 300:	80 fb 09             	cmp    $0x9,%bl
 303:	76 eb                	jbe    2f0 <atoi+0x20>
  return n;
}
 305:	5b                   	pop    %ebx
 306:	5d                   	pop    %ebp
 307:	c3                   	ret    
 308:	90                   	nop
 309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000310 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	56                   	push   %esi
 314:	8b 45 08             	mov    0x8(%ebp),%eax
 317:	53                   	push   %ebx
 318:	8b 5d 10             	mov    0x10(%ebp),%ebx
 31b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 31e:	85 db                	test   %ebx,%ebx
 320:	7e 1a                	jle    33c <memmove+0x2c>
 322:	31 d2                	xor    %edx,%edx
 324:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 32a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 330:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 334:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 337:	42                   	inc    %edx
  while(n-- > 0)
 338:	39 d3                	cmp    %edx,%ebx
 33a:	75 f4                	jne    330 <memmove+0x20>
  return vdst;
}
 33c:	5b                   	pop    %ebx
 33d:	5e                   	pop    %esi
 33e:	5d                   	pop    %ebp
 33f:	c3                   	ret    

00000340 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 340:	b8 01 00 00 00       	mov    $0x1,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <exit>:
SYSCALL(exit)
 348:	b8 02 00 00 00       	mov    $0x2,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <wait>:
SYSCALL(wait)
 350:	b8 03 00 00 00       	mov    $0x3,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <pipe>:
SYSCALL(pipe)
 358:	b8 04 00 00 00       	mov    $0x4,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <read>:
SYSCALL(read)
 360:	b8 05 00 00 00       	mov    $0x5,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <write>:
SYSCALL(write)
 368:	b8 10 00 00 00       	mov    $0x10,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <close>:
SYSCALL(close)
 370:	b8 15 00 00 00       	mov    $0x15,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <kill>:
SYSCALL(kill)
 378:	b8 06 00 00 00       	mov    $0x6,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <exec>:
SYSCALL(exec)
 380:	b8 07 00 00 00       	mov    $0x7,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <open>:
SYSCALL(open)
 388:	b8 0f 00 00 00       	mov    $0xf,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <mknod>:
SYSCALL(mknod)
 390:	b8 11 00 00 00       	mov    $0x11,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <unlink>:
SYSCALL(unlink)
 398:	b8 12 00 00 00       	mov    $0x12,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <fstat>:
SYSCALL(fstat)
 3a0:	b8 08 00 00 00       	mov    $0x8,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <link>:
SYSCALL(link)
 3a8:	b8 13 00 00 00       	mov    $0x13,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <mkdir>:
SYSCALL(mkdir)
 3b0:	b8 14 00 00 00       	mov    $0x14,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <chdir>:
SYSCALL(chdir)
 3b8:	b8 09 00 00 00       	mov    $0x9,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <dup>:
SYSCALL(dup)
 3c0:	b8 0a 00 00 00       	mov    $0xa,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <getpid>:
SYSCALL(getpid)
 3c8:	b8 0b 00 00 00       	mov    $0xb,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <sbrk>:
SYSCALL(sbrk)
 3d0:	b8 0c 00 00 00       	mov    $0xc,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <sleep>:
SYSCALL(sleep)
 3d8:	b8 0d 00 00 00       	mov    $0xd,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <uptime>:
SYSCALL(uptime)
 3e0:	b8 0e 00 00 00       	mov    $0xe,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    
 3e8:	66 90                	xchg   %ax,%ax
 3ea:	66 90                	xchg   %ax,%ax
 3ec:	66 90                	xchg   %ax,%ax
 3ee:	66 90                	xchg   %ax,%ax

000003f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	56                   	push   %esi
 3f5:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3f6:	89 d3                	mov    %edx,%ebx
 3f8:	c1 eb 1f             	shr    $0x1f,%ebx
{
 3fb:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 3fe:	84 db                	test   %bl,%bl
{
 400:	89 45 c0             	mov    %eax,-0x40(%ebp)
 403:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 405:	74 79                	je     480 <printint+0x90>
 407:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 40b:	74 73                	je     480 <printint+0x90>
    neg = 1;
    x = -xx;
 40d:	f7 d8                	neg    %eax
    neg = 1;
 40f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 416:	31 f6                	xor    %esi,%esi
 418:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 41b:	eb 05                	jmp    422 <printint+0x32>
 41d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 420:	89 fe                	mov    %edi,%esi
 422:	31 d2                	xor    %edx,%edx
 424:	f7 f1                	div    %ecx
 426:	8d 7e 01             	lea    0x1(%esi),%edi
 429:	0f b6 92 60 08 00 00 	movzbl 0x860(%edx),%edx
  }while((x /= base) != 0);
 430:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 432:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 435:	75 e9                	jne    420 <printint+0x30>
  if(neg)
 437:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 43a:	85 d2                	test   %edx,%edx
 43c:	74 08                	je     446 <printint+0x56>
    buf[i++] = '-';
 43e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 443:	8d 7e 02             	lea    0x2(%esi),%edi
 446:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 44a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 44d:	8d 76 00             	lea    0x0(%esi),%esi
 450:	0f b6 06             	movzbl (%esi),%eax
 453:	4e                   	dec    %esi
  write(fd, &c, 1);
 454:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 458:	89 3c 24             	mov    %edi,(%esp)
 45b:	88 45 d7             	mov    %al,-0x29(%ebp)
 45e:	b8 01 00 00 00       	mov    $0x1,%eax
 463:	89 44 24 08          	mov    %eax,0x8(%esp)
 467:	e8 fc fe ff ff       	call   368 <write>

  while(--i >= 0)
 46c:	39 de                	cmp    %ebx,%esi
 46e:	75 e0                	jne    450 <printint+0x60>
    putc(fd, buf[i]);
}
 470:	83 c4 4c             	add    $0x4c,%esp
 473:	5b                   	pop    %ebx
 474:	5e                   	pop    %esi
 475:	5f                   	pop    %edi
 476:	5d                   	pop    %ebp
 477:	c3                   	ret    
 478:	90                   	nop
 479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 480:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 487:	eb 8d                	jmp    416 <printint+0x26>
 489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000490 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	56                   	push   %esi
 495:	53                   	push   %ebx
 496:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 499:	8b 75 0c             	mov    0xc(%ebp),%esi
 49c:	0f b6 1e             	movzbl (%esi),%ebx
 49f:	84 db                	test   %bl,%bl
 4a1:	0f 84 d1 00 00 00    	je     578 <printf+0xe8>
  state = 0;
 4a7:	31 ff                	xor    %edi,%edi
 4a9:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 4aa:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 4ad:	89 fa                	mov    %edi,%edx
 4af:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 4b2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4b5:	eb 41                	jmp    4f8 <printf+0x68>
 4b7:	89 f6                	mov    %esi,%esi
 4b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 4c0:	83 f8 25             	cmp    $0x25,%eax
 4c3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 4c6:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 4cb:	74 1e                	je     4eb <printf+0x5b>
  write(fd, &c, 1);
 4cd:	b8 01 00 00 00       	mov    $0x1,%eax
 4d2:	89 44 24 08          	mov    %eax,0x8(%esp)
 4d6:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 4d9:	89 44 24 04          	mov    %eax,0x4(%esp)
 4dd:	89 3c 24             	mov    %edi,(%esp)
 4e0:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 4e3:	e8 80 fe ff ff       	call   368 <write>
 4e8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 4eb:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 4ec:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 4f0:	84 db                	test   %bl,%bl
 4f2:	0f 84 80 00 00 00    	je     578 <printf+0xe8>
    if(state == 0){
 4f8:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 4fa:	0f be cb             	movsbl %bl,%ecx
 4fd:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 500:	74 be                	je     4c0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 502:	83 fa 25             	cmp    $0x25,%edx
 505:	75 e4                	jne    4eb <printf+0x5b>
      if(c == 'd'){
 507:	83 f8 64             	cmp    $0x64,%eax
 50a:	0f 84 f0 00 00 00    	je     600 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 510:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 516:	83 f9 70             	cmp    $0x70,%ecx
 519:	74 65                	je     580 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 51b:	83 f8 73             	cmp    $0x73,%eax
 51e:	0f 84 8c 00 00 00    	je     5b0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 524:	83 f8 63             	cmp    $0x63,%eax
 527:	0f 84 13 01 00 00    	je     640 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 52d:	83 f8 25             	cmp    $0x25,%eax
 530:	0f 84 e2 00 00 00    	je     618 <printf+0x188>
  write(fd, &c, 1);
 536:	b8 01 00 00 00       	mov    $0x1,%eax
 53b:	46                   	inc    %esi
 53c:	89 44 24 08          	mov    %eax,0x8(%esp)
 540:	8d 45 e7             	lea    -0x19(%ebp),%eax
 543:	89 44 24 04          	mov    %eax,0x4(%esp)
 547:	89 3c 24             	mov    %edi,(%esp)
 54a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 54e:	e8 15 fe ff ff       	call   368 <write>
 553:	ba 01 00 00 00       	mov    $0x1,%edx
 558:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 55b:	89 54 24 08          	mov    %edx,0x8(%esp)
 55f:	89 44 24 04          	mov    %eax,0x4(%esp)
 563:	89 3c 24             	mov    %edi,(%esp)
 566:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 569:	e8 fa fd ff ff       	call   368 <write>
  for(i = 0; fmt[i]; i++){
 56e:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 572:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 574:	84 db                	test   %bl,%bl
 576:	75 80                	jne    4f8 <printf+0x68>
    }
  }
}
 578:	83 c4 3c             	add    $0x3c,%esp
 57b:	5b                   	pop    %ebx
 57c:	5e                   	pop    %esi
 57d:	5f                   	pop    %edi
 57e:	5d                   	pop    %ebp
 57f:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 580:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 587:	b9 10 00 00 00       	mov    $0x10,%ecx
 58c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 58f:	89 f8                	mov    %edi,%eax
 591:	8b 13                	mov    (%ebx),%edx
 593:	e8 58 fe ff ff       	call   3f0 <printint>
        ap++;
 598:	89 d8                	mov    %ebx,%eax
      state = 0;
 59a:	31 d2                	xor    %edx,%edx
        ap++;
 59c:	83 c0 04             	add    $0x4,%eax
 59f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5a2:	e9 44 ff ff ff       	jmp    4eb <printf+0x5b>
 5a7:	89 f6                	mov    %esi,%esi
 5a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 5b0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5b3:	8b 10                	mov    (%eax),%edx
        ap++;
 5b5:	83 c0 04             	add    $0x4,%eax
 5b8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 5bb:	85 d2                	test   %edx,%edx
 5bd:	0f 84 aa 00 00 00    	je     66d <printf+0x1dd>
        while(*s != 0){
 5c3:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 5c6:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 5c8:	84 c0                	test   %al,%al
 5ca:	74 27                	je     5f3 <printf+0x163>
 5cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5d0:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 5d3:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 5d8:	43                   	inc    %ebx
  write(fd, &c, 1);
 5d9:	89 44 24 08          	mov    %eax,0x8(%esp)
 5dd:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 5e0:	89 44 24 04          	mov    %eax,0x4(%esp)
 5e4:	89 3c 24             	mov    %edi,(%esp)
 5e7:	e8 7c fd ff ff       	call   368 <write>
        while(*s != 0){
 5ec:	0f b6 03             	movzbl (%ebx),%eax
 5ef:	84 c0                	test   %al,%al
 5f1:	75 dd                	jne    5d0 <printf+0x140>
      state = 0;
 5f3:	31 d2                	xor    %edx,%edx
 5f5:	e9 f1 fe ff ff       	jmp    4eb <printf+0x5b>
 5fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 600:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 607:	b9 0a 00 00 00       	mov    $0xa,%ecx
 60c:	e9 7b ff ff ff       	jmp    58c <printf+0xfc>
 611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 618:	b9 01 00 00 00       	mov    $0x1,%ecx
 61d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 620:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 624:	89 44 24 04          	mov    %eax,0x4(%esp)
 628:	89 3c 24             	mov    %edi,(%esp)
 62b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 62e:	e8 35 fd ff ff       	call   368 <write>
      state = 0;
 633:	31 d2                	xor    %edx,%edx
 635:	e9 b1 fe ff ff       	jmp    4eb <printf+0x5b>
 63a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 640:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 643:	8b 03                	mov    (%ebx),%eax
        ap++;
 645:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 648:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 64b:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 64e:	b8 01 00 00 00       	mov    $0x1,%eax
 653:	89 44 24 08          	mov    %eax,0x8(%esp)
 657:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 65a:	89 44 24 04          	mov    %eax,0x4(%esp)
 65e:	e8 05 fd ff ff       	call   368 <write>
      state = 0;
 663:	31 d2                	xor    %edx,%edx
        ap++;
 665:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 668:	e9 7e fe ff ff       	jmp    4eb <printf+0x5b>
          s = "(null)";
 66d:	bb 58 08 00 00       	mov    $0x858,%ebx
        while(*s != 0){
 672:	b0 28                	mov    $0x28,%al
 674:	e9 57 ff ff ff       	jmp    5d0 <printf+0x140>
 679:	66 90                	xchg   %ax,%ax
 67b:	66 90                	xchg   %ax,%ax
 67d:	66 90                	xchg   %ax,%ax
 67f:	90                   	nop

00000680 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 680:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 681:	a1 f4 0a 00 00       	mov    0xaf4,%eax
{
 686:	89 e5                	mov    %esp,%ebp
 688:	57                   	push   %edi
 689:	56                   	push   %esi
 68a:	53                   	push   %ebx
 68b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 68e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 691:	eb 0d                	jmp    6a0 <free+0x20>
 693:	90                   	nop
 694:	90                   	nop
 695:	90                   	nop
 696:	90                   	nop
 697:	90                   	nop
 698:	90                   	nop
 699:	90                   	nop
 69a:	90                   	nop
 69b:	90                   	nop
 69c:	90                   	nop
 69d:	90                   	nop
 69e:	90                   	nop
 69f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a0:	39 c8                	cmp    %ecx,%eax
 6a2:	8b 10                	mov    (%eax),%edx
 6a4:	73 32                	jae    6d8 <free+0x58>
 6a6:	39 d1                	cmp    %edx,%ecx
 6a8:	72 04                	jb     6ae <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6aa:	39 d0                	cmp    %edx,%eax
 6ac:	72 32                	jb     6e0 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6ae:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6b1:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6b4:	39 fa                	cmp    %edi,%edx
 6b6:	74 30                	je     6e8 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6b8:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6bb:	8b 50 04             	mov    0x4(%eax),%edx
 6be:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6c1:	39 f1                	cmp    %esi,%ecx
 6c3:	74 3c                	je     701 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6c5:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 6c7:	5b                   	pop    %ebx
  freep = p;
 6c8:	a3 f4 0a 00 00       	mov    %eax,0xaf4
}
 6cd:	5e                   	pop    %esi
 6ce:	5f                   	pop    %edi
 6cf:	5d                   	pop    %ebp
 6d0:	c3                   	ret    
 6d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6d8:	39 d0                	cmp    %edx,%eax
 6da:	72 04                	jb     6e0 <free+0x60>
 6dc:	39 d1                	cmp    %edx,%ecx
 6de:	72 ce                	jb     6ae <free+0x2e>
{
 6e0:	89 d0                	mov    %edx,%eax
 6e2:	eb bc                	jmp    6a0 <free+0x20>
 6e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 6e8:	8b 7a 04             	mov    0x4(%edx),%edi
 6eb:	01 fe                	add    %edi,%esi
 6ed:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6f0:	8b 10                	mov    (%eax),%edx
 6f2:	8b 12                	mov    (%edx),%edx
 6f4:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6f7:	8b 50 04             	mov    0x4(%eax),%edx
 6fa:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6fd:	39 f1                	cmp    %esi,%ecx
 6ff:	75 c4                	jne    6c5 <free+0x45>
    p->s.size += bp->s.size;
 701:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 704:	a3 f4 0a 00 00       	mov    %eax,0xaf4
    p->s.size += bp->s.size;
 709:	01 ca                	add    %ecx,%edx
 70b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 70e:	8b 53 f8             	mov    -0x8(%ebx),%edx
 711:	89 10                	mov    %edx,(%eax)
}
 713:	5b                   	pop    %ebx
 714:	5e                   	pop    %esi
 715:	5f                   	pop    %edi
 716:	5d                   	pop    %ebp
 717:	c3                   	ret    
 718:	90                   	nop
 719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000720 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	57                   	push   %edi
 724:	56                   	push   %esi
 725:	53                   	push   %ebx
 726:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 729:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 72c:	8b 15 f4 0a 00 00    	mov    0xaf4,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 732:	8d 78 07             	lea    0x7(%eax),%edi
 735:	c1 ef 03             	shr    $0x3,%edi
 738:	47                   	inc    %edi
  if((prevp = freep) == 0){
 739:	85 d2                	test   %edx,%edx
 73b:	0f 84 8f 00 00 00    	je     7d0 <malloc+0xb0>
 741:	8b 02                	mov    (%edx),%eax
 743:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 746:	39 cf                	cmp    %ecx,%edi
 748:	76 66                	jbe    7b0 <malloc+0x90>
 74a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 750:	bb 00 10 00 00       	mov    $0x1000,%ebx
 755:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 758:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 75f:	eb 10                	jmp    771 <malloc+0x51>
 761:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 768:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 76a:	8b 48 04             	mov    0x4(%eax),%ecx
 76d:	39 f9                	cmp    %edi,%ecx
 76f:	73 3f                	jae    7b0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 771:	39 05 f4 0a 00 00    	cmp    %eax,0xaf4
 777:	89 c2                	mov    %eax,%edx
 779:	75 ed                	jne    768 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 77b:	89 34 24             	mov    %esi,(%esp)
 77e:	e8 4d fc ff ff       	call   3d0 <sbrk>
  if(p == (char*)-1)
 783:	83 f8 ff             	cmp    $0xffffffff,%eax
 786:	74 18                	je     7a0 <malloc+0x80>
  hp->s.size = nu;
 788:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 78b:	83 c0 08             	add    $0x8,%eax
 78e:	89 04 24             	mov    %eax,(%esp)
 791:	e8 ea fe ff ff       	call   680 <free>
  return freep;
 796:	8b 15 f4 0a 00 00    	mov    0xaf4,%edx
      if((p = morecore(nunits)) == 0)
 79c:	85 d2                	test   %edx,%edx
 79e:	75 c8                	jne    768 <malloc+0x48>
        return 0;
  }
}
 7a0:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 7a3:	31 c0                	xor    %eax,%eax
}
 7a5:	5b                   	pop    %ebx
 7a6:	5e                   	pop    %esi
 7a7:	5f                   	pop    %edi
 7a8:	5d                   	pop    %ebp
 7a9:	c3                   	ret    
 7aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7b0:	39 cf                	cmp    %ecx,%edi
 7b2:	74 4c                	je     800 <malloc+0xe0>
        p->s.size -= nunits;
 7b4:	29 f9                	sub    %edi,%ecx
 7b6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7b9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7bc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7bf:	89 15 f4 0a 00 00    	mov    %edx,0xaf4
}
 7c5:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 7c8:	83 c0 08             	add    $0x8,%eax
}
 7cb:	5b                   	pop    %ebx
 7cc:	5e                   	pop    %esi
 7cd:	5f                   	pop    %edi
 7ce:	5d                   	pop    %ebp
 7cf:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 7d0:	b8 f8 0a 00 00       	mov    $0xaf8,%eax
 7d5:	ba f8 0a 00 00       	mov    $0xaf8,%edx
    base.s.size = 0;
 7da:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 7dc:	a3 f4 0a 00 00       	mov    %eax,0xaf4
    base.s.size = 0;
 7e1:	b8 f8 0a 00 00       	mov    $0xaf8,%eax
    base.s.ptr = freep = prevp = &base;
 7e6:	89 15 f8 0a 00 00    	mov    %edx,0xaf8
    base.s.size = 0;
 7ec:	89 0d fc 0a 00 00    	mov    %ecx,0xafc
 7f2:	e9 53 ff ff ff       	jmp    74a <malloc+0x2a>
 7f7:	89 f6                	mov    %esi,%esi
 7f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 800:	8b 08                	mov    (%eax),%ecx
 802:	89 0a                	mov    %ecx,(%edx)
 804:	eb b9                	jmp    7bf <malloc+0x9f>
