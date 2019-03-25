
_ln:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	83 ec 10             	sub    $0x10,%esp
  if(argc != 3){
   a:	83 7d 08 03          	cmpl   $0x3,0x8(%ebp)
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(argc != 3){
  11:	74 21                	je     34 <main+0x34>
    printf(2, "Usage: ln old new\n");
  13:	b8 90 07 00 00       	mov    $0x790,%eax
  18:	89 44 24 04          	mov    %eax,0x4(%esp)
  1c:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  23:	e8 08 04 00 00       	call   430 <printf>
    exit(0);
  28:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  2f:	e8 84 02 00 00       	call   2b8 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  34:	8b 43 08             	mov    0x8(%ebx),%eax
  37:	89 44 24 04          	mov    %eax,0x4(%esp)
  3b:	8b 43 04             	mov    0x4(%ebx),%eax
  3e:	89 04 24             	mov    %eax,(%esp)
  41:	e8 d2 02 00 00       	call   318 <link>
  46:	85 c0                	test   %eax,%eax
  48:	78 0c                	js     56 <main+0x56>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  4a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  51:	e8 62 02 00 00       	call   2b8 <exit>
  if(argc != 3){
    printf(2, "Usage: ln old new\n");
    exit(0);
  }
  if(link(argv[1], argv[2]) < 0)
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  56:	8b 43 08             	mov    0x8(%ebx),%eax
  59:	89 44 24 0c          	mov    %eax,0xc(%esp)
  5d:	8b 43 04             	mov    0x4(%ebx),%eax
  60:	c7 44 24 04 a3 07 00 	movl   $0x7a3,0x4(%esp)
  67:	00 
  68:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  6f:	89 44 24 08          	mov    %eax,0x8(%esp)
  73:	e8 b8 03 00 00       	call   430 <printf>
  78:	eb d0                	jmp    4a <main+0x4a>
  7a:	66 90                	xchg   %ax,%ax
  7c:	66 90                	xchg   %ax,%ax
  7e:	66 90                	xchg   %ax,%ax

00000080 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	8b 45 08             	mov    0x8(%ebp),%eax
  86:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  89:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  8a:	89 c2                	mov    %eax,%edx
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  90:	41                   	inc    %ecx
  91:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  95:	42                   	inc    %edx
  96:	84 db                	test   %bl,%bl
  98:	88 5a ff             	mov    %bl,-0x1(%edx)
  9b:	75 f3                	jne    90 <strcpy+0x10>
    ;
  return os;
}
  9d:	5b                   	pop    %ebx
  9e:	5d                   	pop    %ebp
  9f:	c3                   	ret    

000000a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  a6:	56                   	push   %esi
  a7:	53                   	push   %ebx
  a8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  ab:	0f b6 01             	movzbl (%ecx),%eax
  ae:	0f b6 13             	movzbl (%ebx),%edx
  b1:	84 c0                	test   %al,%al
  b3:	75 1c                	jne    d1 <strcmp+0x31>
  b5:	eb 29                	jmp    e0 <strcmp+0x40>
  b7:	89 f6                	mov    %esi,%esi
  b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  c0:	41                   	inc    %ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  c1:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
  c4:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  c7:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
  cb:	84 c0                	test   %al,%al
  cd:	74 11                	je     e0 <strcmp+0x40>
  cf:	89 f3                	mov    %esi,%ebx
  d1:	38 d0                	cmp    %dl,%al
  d3:	74 eb                	je     c0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  d5:	5b                   	pop    %ebx
int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    p++, q++;
  return (uchar)*p - (uchar)*q;
  d6:	29 d0                	sub    %edx,%eax
}
  d8:	5e                   	pop    %esi
  d9:	5d                   	pop    %ebp
  da:	c3                   	ret    
  db:	90                   	nop
  dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  e0:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  e1:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  e3:	29 d0                	sub    %edx,%eax
}
  e5:	5e                   	pop    %esi
  e6:	5d                   	pop    %ebp
  e7:	c3                   	ret    
  e8:	90                   	nop
  e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000f0 <strlen>:

uint
strlen(const char *s)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  f6:	80 39 00             	cmpb   $0x0,(%ecx)
  f9:	74 10                	je     10b <strlen+0x1b>
  fb:	31 d2                	xor    %edx,%edx
  fd:	8d 76 00             	lea    0x0(%esi),%esi
 100:	42                   	inc    %edx
 101:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 105:	89 d0                	mov    %edx,%eax
 107:	75 f7                	jne    100 <strlen+0x10>
    ;
  return n;
}
 109:	5d                   	pop    %ebp
 10a:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 10b:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 10d:	5d                   	pop    %ebp
 10e:	c3                   	ret    
 10f:	90                   	nop

00000110 <memset>:

void*
memset(void *dst, int c, uint n)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	8b 55 08             	mov    0x8(%ebp),%edx
 116:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 117:	8b 4d 10             	mov    0x10(%ebp),%ecx
 11a:	8b 45 0c             	mov    0xc(%ebp),%eax
 11d:	89 d7                	mov    %edx,%edi
 11f:	fc                   	cld    
 120:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 122:	5f                   	pop    %edi
 123:	89 d0                	mov    %edx,%eax
 125:	5d                   	pop    %ebp
 126:	c3                   	ret    
 127:	89 f6                	mov    %esi,%esi
 129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000130 <strchr>:

char*
strchr(const char *s, char c)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	8b 45 08             	mov    0x8(%ebp),%eax
 136:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 13a:	0f b6 10             	movzbl (%eax),%edx
 13d:	84 d2                	test   %dl,%dl
 13f:	74 1b                	je     15c <strchr+0x2c>
    if(*s == c)
 141:	38 d1                	cmp    %dl,%cl
 143:	75 0f                	jne    154 <strchr+0x24>
 145:	eb 17                	jmp    15e <strchr+0x2e>
 147:	89 f6                	mov    %esi,%esi
 149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 150:	38 ca                	cmp    %cl,%dl
 152:	74 0a                	je     15e <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 154:	40                   	inc    %eax
 155:	0f b6 10             	movzbl (%eax),%edx
 158:	84 d2                	test   %dl,%dl
 15a:	75 f4                	jne    150 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 15c:	31 c0                	xor    %eax,%eax
}
 15e:	5d                   	pop    %ebp
 15f:	c3                   	ret    

00000160 <gets>:

char*
gets(char *buf, int max)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	57                   	push   %edi
 164:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 165:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
 167:	53                   	push   %ebx
 168:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 16b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 16e:	eb 32                	jmp    1a2 <gets+0x42>
    cc = read(0, &c, 1);
 170:	b8 01 00 00 00       	mov    $0x1,%eax
 175:	89 44 24 08          	mov    %eax,0x8(%esp)
 179:	89 7c 24 04          	mov    %edi,0x4(%esp)
 17d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 184:	e8 47 01 00 00       	call   2d0 <read>
    if(cc < 1)
 189:	85 c0                	test   %eax,%eax
 18b:	7e 1d                	jle    1aa <gets+0x4a>
      break;
    buf[i++] = c;
 18d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 191:	89 de                	mov    %ebx,%esi
 193:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 196:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 198:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 19c:	74 22                	je     1c0 <gets+0x60>
 19e:	3c 0d                	cmp    $0xd,%al
 1a0:	74 1e                	je     1c0 <gets+0x60>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a2:	8d 5e 01             	lea    0x1(%esi),%ebx
 1a5:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1a8:	7c c6                	jl     170 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1aa:	8b 45 08             	mov    0x8(%ebp),%eax
 1ad:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1b1:	83 c4 2c             	add    $0x2c,%esp
 1b4:	5b                   	pop    %ebx
 1b5:	5e                   	pop    %esi
 1b6:	5f                   	pop    %edi
 1b7:	5d                   	pop    %ebp
 1b8:	c3                   	ret    
 1b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1c0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1c3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1c5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1c9:	83 c4 2c             	add    $0x2c,%esp
 1cc:	5b                   	pop    %ebx
 1cd:	5e                   	pop    %esi
 1ce:	5f                   	pop    %edi
 1cf:	5d                   	pop    %ebp
 1d0:	c3                   	ret    
 1d1:	eb 0d                	jmp    1e0 <stat>
 1d3:	90                   	nop
 1d4:	90                   	nop
 1d5:	90                   	nop
 1d6:	90                   	nop
 1d7:	90                   	nop
 1d8:	90                   	nop
 1d9:	90                   	nop
 1da:	90                   	nop
 1db:	90                   	nop
 1dc:	90                   	nop
 1dd:	90                   	nop
 1de:	90                   	nop
 1df:	90                   	nop

000001e0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1e0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e1:	31 c0                	xor    %eax,%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 1e3:	89 e5                	mov    %esp,%ebp
 1e5:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e8:	89 44 24 04          	mov    %eax,0x4(%esp)
 1ec:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 1ef:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1f2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f5:	89 04 24             	mov    %eax,(%esp)
 1f8:	e8 fb 00 00 00       	call   2f8 <open>
  if(fd < 0)
 1fd:	85 c0                	test   %eax,%eax
 1ff:	78 2f                	js     230 <stat+0x50>
 201:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 203:	8b 45 0c             	mov    0xc(%ebp),%eax
 206:	89 1c 24             	mov    %ebx,(%esp)
 209:	89 44 24 04          	mov    %eax,0x4(%esp)
 20d:	e8 fe 00 00 00       	call   310 <fstat>
  close(fd);
 212:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 215:	89 c6                	mov    %eax,%esi
  close(fd);
 217:	e8 c4 00 00 00       	call   2e0 <close>
  return r;
 21c:	89 f0                	mov    %esi,%eax
}
 21e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 221:	8b 75 fc             	mov    -0x4(%ebp),%esi
 224:	89 ec                	mov    %ebp,%esp
 226:	5d                   	pop    %ebp
 227:	c3                   	ret    
 228:	90                   	nop
 229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 230:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 235:	eb e7                	jmp    21e <stat+0x3e>
 237:	89 f6                	mov    %esi,%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000240 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	8b 4d 08             	mov    0x8(%ebp),%ecx
 246:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 247:	0f be 11             	movsbl (%ecx),%edx
 24a:	88 d0                	mov    %dl,%al
 24c:	2c 30                	sub    $0x30,%al
 24e:	3c 09                	cmp    $0x9,%al
 250:	b8 00 00 00 00       	mov    $0x0,%eax
 255:	77 1e                	ja     275 <atoi+0x35>
 257:	89 f6                	mov    %esi,%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 260:	41                   	inc    %ecx
 261:	8d 04 80             	lea    (%eax,%eax,4),%eax
 264:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 268:	0f be 11             	movsbl (%ecx),%edx
 26b:	88 d3                	mov    %dl,%bl
 26d:	80 eb 30             	sub    $0x30,%bl
 270:	80 fb 09             	cmp    $0x9,%bl
 273:	76 eb                	jbe    260 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 275:	5b                   	pop    %ebx
 276:	5d                   	pop    %ebp
 277:	c3                   	ret    
 278:	90                   	nop
 279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000280 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	56                   	push   %esi
 284:	8b 45 08             	mov    0x8(%ebp),%eax
 287:	53                   	push   %ebx
 288:	8b 5d 10             	mov    0x10(%ebp),%ebx
 28b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 28e:	85 db                	test   %ebx,%ebx
 290:	7e 1a                	jle    2ac <memmove+0x2c>
 292:	31 d2                	xor    %edx,%edx
 294:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 29a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 2a0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2a4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2a7:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2a8:	39 da                	cmp    %ebx,%edx
 2aa:	75 f4                	jne    2a0 <memmove+0x20>
    *dst++ = *src++;
  return vdst;
}
 2ac:	5b                   	pop    %ebx
 2ad:	5e                   	pop    %esi
 2ae:	5d                   	pop    %ebp
 2af:	c3                   	ret    

000002b0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2b0:	b8 01 00 00 00       	mov    $0x1,%eax
 2b5:	cd 40                	int    $0x40
 2b7:	c3                   	ret    

000002b8 <exit>:
SYSCALL(exit)
 2b8:	b8 02 00 00 00       	mov    $0x2,%eax
 2bd:	cd 40                	int    $0x40
 2bf:	c3                   	ret    

000002c0 <wait>:
SYSCALL(wait)
 2c0:	b8 03 00 00 00       	mov    $0x3,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <pipe>:
SYSCALL(pipe)
 2c8:	b8 04 00 00 00       	mov    $0x4,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <read>:
SYSCALL(read)
 2d0:	b8 05 00 00 00       	mov    $0x5,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <write>:
SYSCALL(write)
 2d8:	b8 10 00 00 00       	mov    $0x10,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <close>:
SYSCALL(close)
 2e0:	b8 15 00 00 00       	mov    $0x15,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <kill>:
SYSCALL(kill)
 2e8:	b8 06 00 00 00       	mov    $0x6,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <exec>:
SYSCALL(exec)
 2f0:	b8 07 00 00 00       	mov    $0x7,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <open>:
SYSCALL(open)
 2f8:	b8 0f 00 00 00       	mov    $0xf,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <mknod>:
SYSCALL(mknod)
 300:	b8 11 00 00 00       	mov    $0x11,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <unlink>:
SYSCALL(unlink)
 308:	b8 12 00 00 00       	mov    $0x12,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <fstat>:
SYSCALL(fstat)
 310:	b8 08 00 00 00       	mov    $0x8,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <link>:
SYSCALL(link)
 318:	b8 13 00 00 00       	mov    $0x13,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <mkdir>:
SYSCALL(mkdir)
 320:	b8 14 00 00 00       	mov    $0x14,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <chdir>:
SYSCALL(chdir)
 328:	b8 09 00 00 00       	mov    $0x9,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <dup>:
SYSCALL(dup)
 330:	b8 0a 00 00 00       	mov    $0xa,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <getpid>:
SYSCALL(getpid)
 338:	b8 0b 00 00 00       	mov    $0xb,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <sbrk>:
SYSCALL(sbrk)
 340:	b8 0c 00 00 00       	mov    $0xc,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <sleep>:
SYSCALL(sleep)
 348:	b8 0d 00 00 00       	mov    $0xd,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <uptime>:
SYSCALL(uptime)
 350:	b8 0e 00 00 00       	mov    $0xe,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <policy>:
SYSCALL(policy)
 358:	b8 17 00 00 00       	mov    $0x17,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <detach>:
SYSCALL(detach)
 360:	b8 16 00 00 00       	mov    $0x16,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <priority>:
SYSCALL(priority)
 368:	b8 18 00 00 00       	mov    $0x18,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <wait_stat>:
SYSCALL(wait_stat)
 370:	b8 19 00 00 00       	mov    $0x19,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    
 378:	66 90                	xchg   %ax,%ax
 37a:	66 90                	xchg   %ax,%ax
 37c:	66 90                	xchg   %ax,%ax
 37e:	66 90                	xchg   %ax,%ax

00000380 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	56                   	push   %esi
 385:	89 c6                	mov    %eax,%esi
 387:	53                   	push   %ebx
 388:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 38b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 38e:	85 db                	test   %ebx,%ebx
 390:	0f 84 8a 00 00 00    	je     420 <printint+0xa0>
 396:	89 d0                	mov    %edx,%eax
 398:	c1 e8 1f             	shr    $0x1f,%eax
 39b:	84 c0                	test   %al,%al
 39d:	0f 84 7d 00 00 00    	je     420 <printint+0xa0>
    neg = 1;
    x = -xx;
 3a3:	89 d0                	mov    %edx,%eax
 3a5:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 3a7:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 3ae:	89 75 c0             	mov    %esi,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 3b1:	31 ff                	xor    %edi,%edi
 3b3:	89 ce                	mov    %ecx,%esi
 3b5:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 3b8:	eb 08                	jmp    3c2 <printint+0x42>
 3ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 3c0:	89 cf                	mov    %ecx,%edi
 3c2:	31 d2                	xor    %edx,%edx
 3c4:	f7 f6                	div    %esi
 3c6:	8d 4f 01             	lea    0x1(%edi),%ecx
 3c9:	0f b6 92 c0 07 00 00 	movzbl 0x7c0(%edx),%edx
  }while((x /= base) != 0);
 3d0:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 3d2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 3d5:	75 e9                	jne    3c0 <printint+0x40>
  if(neg)
 3d7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 3da:	8b 75 c0             	mov    -0x40(%ebp),%esi
 3dd:	85 d2                	test   %edx,%edx
 3df:	74 08                	je     3e9 <printint+0x69>
    buf[i++] = '-';
 3e1:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 3e6:	8d 4f 02             	lea    0x2(%edi),%ecx
 3e9:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 3ed:	8d 76 00             	lea    0x0(%esi),%esi
 3f0:	0f b6 07             	movzbl (%edi),%eax
 3f3:	4f                   	dec    %edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3f4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 3f8:	89 34 24             	mov    %esi,(%esp)
 3fb:	88 45 d7             	mov    %al,-0x29(%ebp)
 3fe:	b8 01 00 00 00       	mov    $0x1,%eax
 403:	89 44 24 08          	mov    %eax,0x8(%esp)
 407:	e8 cc fe ff ff       	call   2d8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 40c:	39 df                	cmp    %ebx,%edi
 40e:	75 e0                	jne    3f0 <printint+0x70>
    putc(fd, buf[i]);
}
 410:	83 c4 4c             	add    $0x4c,%esp
 413:	5b                   	pop    %ebx
 414:	5e                   	pop    %esi
 415:	5f                   	pop    %edi
 416:	5d                   	pop    %ebp
 417:	c3                   	ret    
 418:	90                   	nop
 419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 420:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 422:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 429:	eb 83                	jmp    3ae <printint+0x2e>
 42b:	90                   	nop
 42c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000430 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	57                   	push   %edi
 434:	56                   	push   %esi
 435:	53                   	push   %ebx
 436:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 439:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 43c:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 43f:	0f b6 1e             	movzbl (%esi),%ebx
 442:	84 db                	test   %bl,%bl
 444:	0f 84 c6 00 00 00    	je     510 <printf+0xe0>
 44a:	8d 45 10             	lea    0x10(%ebp),%eax
 44d:	46                   	inc    %esi
 44e:	89 45 d0             	mov    %eax,-0x30(%ebp)
 451:	31 d2                	xor    %edx,%edx
 453:	eb 3b                	jmp    490 <printf+0x60>
 455:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 458:	83 f8 25             	cmp    $0x25,%eax
 45b:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 45e:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 463:	74 1e                	je     483 <printf+0x53>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 465:	b8 01 00 00 00       	mov    $0x1,%eax
 46a:	89 44 24 08          	mov    %eax,0x8(%esp)
 46e:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 471:	89 44 24 04          	mov    %eax,0x4(%esp)
 475:	89 3c 24             	mov    %edi,(%esp)
 478:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 47b:	e8 58 fe ff ff       	call   2d8 <write>
 480:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 483:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 484:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 488:	84 db                	test   %bl,%bl
 48a:	0f 84 80 00 00 00    	je     510 <printf+0xe0>
    c = fmt[i] & 0xff;
    if(state == 0){
 490:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 492:	0f be cb             	movsbl %bl,%ecx
 495:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 498:	74 be                	je     458 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 49a:	83 fa 25             	cmp    $0x25,%edx
 49d:	75 e4                	jne    483 <printf+0x53>
      if(c == 'd'){
 49f:	83 f8 64             	cmp    $0x64,%eax
 4a2:	0f 84 20 01 00 00    	je     5c8 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4a8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 4ae:	83 f9 70             	cmp    $0x70,%ecx
 4b1:	74 6d                	je     520 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4b3:	83 f8 73             	cmp    $0x73,%eax
 4b6:	0f 84 94 00 00 00    	je     550 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4bc:	83 f8 63             	cmp    $0x63,%eax
 4bf:	0f 84 14 01 00 00    	je     5d9 <printf+0x1a9>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4c5:	83 f8 25             	cmp    $0x25,%eax
 4c8:	0f 84 d2 00 00 00    	je     5a0 <printf+0x170>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4ce:	b8 01 00 00 00       	mov    $0x1,%eax
 4d3:	46                   	inc    %esi
 4d4:	89 44 24 08          	mov    %eax,0x8(%esp)
 4d8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4db:	89 44 24 04          	mov    %eax,0x4(%esp)
 4df:	89 3c 24             	mov    %edi,(%esp)
 4e2:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4e6:	e8 ed fd ff ff       	call   2d8 <write>
 4eb:	ba 01 00 00 00       	mov    $0x1,%edx
 4f0:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4f3:	89 54 24 08          	mov    %edx,0x8(%esp)
 4f7:	89 44 24 04          	mov    %eax,0x4(%esp)
 4fb:	89 3c 24             	mov    %edi,(%esp)
 4fe:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 501:	e8 d2 fd ff ff       	call   2d8 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 506:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 50a:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 50c:	84 db                	test   %bl,%bl
 50e:	75 80                	jne    490 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 510:	83 c4 3c             	add    $0x3c,%esp
 513:	5b                   	pop    %ebx
 514:	5e                   	pop    %esi
 515:	5f                   	pop    %edi
 516:	5d                   	pop    %ebp
 517:	c3                   	ret    
 518:	90                   	nop
 519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 520:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 527:	b9 10 00 00 00       	mov    $0x10,%ecx
 52c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 52f:	89 f8                	mov    %edi,%eax
 531:	8b 13                	mov    (%ebx),%edx
 533:	e8 48 fe ff ff       	call   380 <printint>
        ap++;
 538:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 53a:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 53c:	83 c0 04             	add    $0x4,%eax
 53f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 542:	e9 3c ff ff ff       	jmp    483 <printf+0x53>
 547:	89 f6                	mov    %esi,%esi
 549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      } else if(c == 's'){
        s = (char*)*ap;
 550:	8b 45 d0             	mov    -0x30(%ebp),%eax
 553:	8b 18                	mov    (%eax),%ebx
        ap++;
 555:	83 c0 04             	add    $0x4,%eax
 558:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 55b:	b8 b7 07 00 00       	mov    $0x7b7,%eax
 560:	85 db                	test   %ebx,%ebx
 562:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 565:	0f b6 03             	movzbl (%ebx),%eax
 568:	84 c0                	test   %al,%al
 56a:	74 27                	je     593 <printf+0x163>
 56c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 570:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 573:	b8 01 00 00 00       	mov    $0x1,%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 578:	43                   	inc    %ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 579:	89 44 24 08          	mov    %eax,0x8(%esp)
 57d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 580:	89 44 24 04          	mov    %eax,0x4(%esp)
 584:	89 3c 24             	mov    %edi,(%esp)
 587:	e8 4c fd ff ff       	call   2d8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 58c:	0f b6 03             	movzbl (%ebx),%eax
 58f:	84 c0                	test   %al,%al
 591:	75 dd                	jne    570 <printf+0x140>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 593:	31 d2                	xor    %edx,%edx
 595:	e9 e9 fe ff ff       	jmp    483 <printf+0x53>
 59a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5a0:	b9 01 00 00 00       	mov    $0x1,%ecx
 5a5:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 5a8:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 5ac:	89 44 24 04          	mov    %eax,0x4(%esp)
 5b0:	89 3c 24             	mov    %edi,(%esp)
 5b3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 5b6:	e8 1d fd ff ff       	call   2d8 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5bb:	31 d2                	xor    %edx,%edx
 5bd:	e9 c1 fe ff ff       	jmp    483 <printf+0x53>
 5c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 5c8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5cf:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5d4:	e9 53 ff ff ff       	jmp    52c <printf+0xfc>
 5d9:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5dc:	8b 03                	mov    (%ebx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5de:	89 3c 24             	mov    %edi,(%esp)
 5e1:	88 45 e4             	mov    %al,-0x1c(%ebp)
 5e4:	b8 01 00 00 00       	mov    $0x1,%eax
 5e9:	89 44 24 08          	mov    %eax,0x8(%esp)
 5ed:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5f0:	89 44 24 04          	mov    %eax,0x4(%esp)
 5f4:	e8 df fc ff ff       	call   2d8 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 5f9:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5fb:	31 d2                	xor    %edx,%edx
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 5fd:	83 c0 04             	add    $0x4,%eax
 600:	89 45 d0             	mov    %eax,-0x30(%ebp)
 603:	e9 7b fe ff ff       	jmp    483 <printf+0x53>
 608:	66 90                	xchg   %ax,%ax
 60a:	66 90                	xchg   %ax,%ax
 60c:	66 90                	xchg   %ax,%ax
 60e:	66 90                	xchg   %ax,%ax

00000610 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 610:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 611:	a1 4c 0a 00 00       	mov    0xa4c,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 616:	89 e5                	mov    %esp,%ebp
 618:	57                   	push   %edi
 619:	56                   	push   %esi
 61a:	53                   	push   %ebx
 61b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 61e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 620:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 623:	39 c8                	cmp    %ecx,%eax
 625:	73 19                	jae    640 <free+0x30>
 627:	89 f6                	mov    %esi,%esi
 629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 630:	39 d1                	cmp    %edx,%ecx
 632:	72 1c                	jb     650 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 634:	39 d0                	cmp    %edx,%eax
 636:	73 18                	jae    650 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 638:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 63a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 63c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 63e:	72 f0                	jb     630 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 640:	39 d0                	cmp    %edx,%eax
 642:	72 f4                	jb     638 <free+0x28>
 644:	39 d1                	cmp    %edx,%ecx
 646:	73 f0                	jae    638 <free+0x28>
 648:	90                   	nop
 649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 650:	8b 73 fc             	mov    -0x4(%ebx),%esi
 653:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 656:	39 d7                	cmp    %edx,%edi
 658:	74 19                	je     673 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 65a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 65d:	8b 50 04             	mov    0x4(%eax),%edx
 660:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 663:	39 f1                	cmp    %esi,%ecx
 665:	74 25                	je     68c <free+0x7c>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 667:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 669:	5b                   	pop    %ebx
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 66a:	a3 4c 0a 00 00       	mov    %eax,0xa4c
}
 66f:	5e                   	pop    %esi
 670:	5f                   	pop    %edi
 671:	5d                   	pop    %ebp
 672:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 673:	8b 7a 04             	mov    0x4(%edx),%edi
 676:	01 fe                	add    %edi,%esi
 678:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 67b:	8b 10                	mov    (%eax),%edx
 67d:	8b 12                	mov    (%edx),%edx
 67f:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 682:	8b 50 04             	mov    0x4(%eax),%edx
 685:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 688:	39 f1                	cmp    %esi,%ecx
 68a:	75 db                	jne    667 <free+0x57>
    p->s.size += bp->s.size;
 68c:	8b 4b fc             	mov    -0x4(%ebx),%ecx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 68f:	a3 4c 0a 00 00       	mov    %eax,0xa4c
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 694:	01 ca                	add    %ecx,%edx
 696:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 699:	8b 53 f8             	mov    -0x8(%ebx),%edx
 69c:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 69e:	5b                   	pop    %ebx
 69f:	5e                   	pop    %esi
 6a0:	5f                   	pop    %edi
 6a1:	5d                   	pop    %ebp
 6a2:	c3                   	ret    
 6a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	57                   	push   %edi
 6b4:	56                   	push   %esi
 6b5:	53                   	push   %ebx
 6b6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6bc:	8b 15 4c 0a 00 00    	mov    0xa4c,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6c2:	8d 78 07             	lea    0x7(%eax),%edi
 6c5:	c1 ef 03             	shr    $0x3,%edi
 6c8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 6c9:	85 d2                	test   %edx,%edx
 6cb:	0f 84 95 00 00 00    	je     766 <malloc+0xb6>
 6d1:	8b 02                	mov    (%edx),%eax
 6d3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6d6:	39 cf                	cmp    %ecx,%edi
 6d8:	76 66                	jbe    740 <malloc+0x90>
 6da:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 6e0:	be 00 10 00 00       	mov    $0x1000,%esi
 6e5:	0f 43 f7             	cmovae %edi,%esi
 6e8:	ba 00 80 00 00       	mov    $0x8000,%edx
 6ed:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 6f4:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 6fa:	0f 46 da             	cmovbe %edx,%ebx
 6fd:	eb 0a                	jmp    709 <malloc+0x59>
 6ff:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 700:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 702:	8b 48 04             	mov    0x4(%eax),%ecx
 705:	39 cf                	cmp    %ecx,%edi
 707:	76 37                	jbe    740 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 709:	39 05 4c 0a 00 00    	cmp    %eax,0xa4c
 70f:	89 c2                	mov    %eax,%edx
 711:	75 ed                	jne    700 <malloc+0x50>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 713:	89 1c 24             	mov    %ebx,(%esp)
 716:	e8 25 fc ff ff       	call   340 <sbrk>
  if(p == (char*)-1)
 71b:	83 f8 ff             	cmp    $0xffffffff,%eax
 71e:	74 18                	je     738 <malloc+0x88>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 720:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 723:	83 c0 08             	add    $0x8,%eax
 726:	89 04 24             	mov    %eax,(%esp)
 729:	e8 e2 fe ff ff       	call   610 <free>
  return freep;
 72e:	8b 15 4c 0a 00 00    	mov    0xa4c,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 734:	85 d2                	test   %edx,%edx
 736:	75 c8                	jne    700 <malloc+0x50>
        return 0;
 738:	31 c0                	xor    %eax,%eax
 73a:	eb 1c                	jmp    758 <malloc+0xa8>
 73c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 740:	39 cf                	cmp    %ecx,%edi
 742:	74 1c                	je     760 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 744:	29 f9                	sub    %edi,%ecx
 746:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 749:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 74c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 74f:	89 15 4c 0a 00 00    	mov    %edx,0xa4c
      return (void*)(p + 1);
 755:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 758:	83 c4 1c             	add    $0x1c,%esp
 75b:	5b                   	pop    %ebx
 75c:	5e                   	pop    %esi
 75d:	5f                   	pop    %edi
 75e:	5d                   	pop    %ebp
 75f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 760:	8b 08                	mov    (%eax),%ecx
 762:	89 0a                	mov    %ecx,(%edx)
 764:	eb e9                	jmp    74f <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 766:	b8 50 0a 00 00       	mov    $0xa50,%eax
 76b:	ba 50 0a 00 00       	mov    $0xa50,%edx
    base.s.size = 0;
 770:	31 c9                	xor    %ecx,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 772:	a3 4c 0a 00 00       	mov    %eax,0xa4c
    base.s.size = 0;
 777:	b8 50 0a 00 00       	mov    $0xa50,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 77c:	89 15 50 0a 00 00    	mov    %edx,0xa50
    base.s.size = 0;
 782:	89 0d 54 0a 00 00    	mov    %ecx,0xa54
 788:	e9 4d ff ff ff       	jmp    6da <malloc+0x2a>
