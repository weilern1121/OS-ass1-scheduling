
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	bb 01 00 00 00       	mov    $0x1,%ebx
   b:	83 e4 f0             	and    $0xfffffff0,%esp
   e:	83 ec 10             	sub    $0x10,%esp
  11:	8b 75 08             	mov    0x8(%ebp),%esi
  14:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  if(argc < 2){
  17:	83 fe 01             	cmp    $0x1,%esi
  1a:	7e 28                	jle    44 <main+0x44>
  1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "usage: kill pid...\n");
    exit(0);
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  20:	8b 04 9f             	mov    (%edi,%ebx,4),%eax

  if(argc < 2){
    printf(2, "usage: kill pid...\n");
    exit(0);
  }
  for(i=1; i<argc; i++)
  23:	43                   	inc    %ebx
    kill(atoi(argv[i]));
  24:	89 04 24             	mov    %eax,(%esp)
  27:	e8 04 02 00 00       	call   230 <atoi>
  2c:	89 04 24             	mov    %eax,(%esp)
  2f:	e8 a4 02 00 00       	call   2d8 <kill>

  if(argc < 2){
    printf(2, "usage: kill pid...\n");
    exit(0);
  }
  for(i=1; i<argc; i++)
  34:	39 de                	cmp    %ebx,%esi
  36:	75 e8                	jne    20 <main+0x20>
    kill(atoi(argv[i]));
  exit(0);
  38:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3f:	e8 64 02 00 00       	call   2a8 <exit>
main(int argc, char **argv)
{
  int i;

  if(argc < 2){
    printf(2, "usage: kill pid...\n");
  44:	c7 44 24 04 80 07 00 	movl   $0x780,0x4(%esp)
  4b:	00 
  4c:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  53:	e8 c8 03 00 00       	call   420 <printf>
    exit(0);
  58:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  5f:	e8 44 02 00 00       	call   2a8 <exit>
  64:	66 90                	xchg   %ax,%ax
  66:	66 90                	xchg   %ax,%ax
  68:	66 90                	xchg   %ax,%ax
  6a:	66 90                	xchg   %ax,%ax
  6c:	66 90                	xchg   %ax,%ax
  6e:	66 90                	xchg   %ax,%ax

00000070 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	8b 45 08             	mov    0x8(%ebp),%eax
  76:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  79:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  7a:	89 c2                	mov    %eax,%edx
  7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  80:	41                   	inc    %ecx
  81:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  85:	42                   	inc    %edx
  86:	84 db                	test   %bl,%bl
  88:	88 5a ff             	mov    %bl,-0x1(%edx)
  8b:	75 f3                	jne    80 <strcpy+0x10>
    ;
  return os;
}
  8d:	5b                   	pop    %ebx
  8e:	5d                   	pop    %ebp
  8f:	c3                   	ret    

00000090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	8b 4d 08             	mov    0x8(%ebp),%ecx
  96:	56                   	push   %esi
  97:	53                   	push   %ebx
  98:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  9b:	0f b6 01             	movzbl (%ecx),%eax
  9e:	0f b6 13             	movzbl (%ebx),%edx
  a1:	84 c0                	test   %al,%al
  a3:	75 1c                	jne    c1 <strcmp+0x31>
  a5:	eb 29                	jmp    d0 <strcmp+0x40>
  a7:	89 f6                	mov    %esi,%esi
  a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  b0:	41                   	inc    %ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  b1:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
  b4:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  b7:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
  bb:	84 c0                	test   %al,%al
  bd:	74 11                	je     d0 <strcmp+0x40>
  bf:	89 f3                	mov    %esi,%ebx
  c1:	38 d0                	cmp    %dl,%al
  c3:	74 eb                	je     b0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  c5:	5b                   	pop    %ebx
int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    p++, q++;
  return (uchar)*p - (uchar)*q;
  c6:	29 d0                	sub    %edx,%eax
}
  c8:	5e                   	pop    %esi
  c9:	5d                   	pop    %ebp
  ca:	c3                   	ret    
  cb:	90                   	nop
  cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  d0:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  d1:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  d3:	29 d0                	sub    %edx,%eax
}
  d5:	5e                   	pop    %esi
  d6:	5d                   	pop    %ebp
  d7:	c3                   	ret    
  d8:	90                   	nop
  d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000e0 <strlen>:

uint
strlen(const char *s)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  e6:	80 39 00             	cmpb   $0x0,(%ecx)
  e9:	74 10                	je     fb <strlen+0x1b>
  eb:	31 d2                	xor    %edx,%edx
  ed:	8d 76 00             	lea    0x0(%esi),%esi
  f0:	42                   	inc    %edx
  f1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  f5:	89 d0                	mov    %edx,%eax
  f7:	75 f7                	jne    f0 <strlen+0x10>
    ;
  return n;
}
  f9:	5d                   	pop    %ebp
  fa:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
  fb:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
  fd:	5d                   	pop    %ebp
  fe:	c3                   	ret    
  ff:	90                   	nop

00000100 <memset>:

void*
memset(void *dst, int c, uint n)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 55 08             	mov    0x8(%ebp),%edx
 106:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 107:	8b 4d 10             	mov    0x10(%ebp),%ecx
 10a:	8b 45 0c             	mov    0xc(%ebp),%eax
 10d:	89 d7                	mov    %edx,%edi
 10f:	fc                   	cld    
 110:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 112:	5f                   	pop    %edi
 113:	89 d0                	mov    %edx,%eax
 115:	5d                   	pop    %ebp
 116:	c3                   	ret    
 117:	89 f6                	mov    %esi,%esi
 119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000120 <strchr>:

char*
strchr(const char *s, char c)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	8b 45 08             	mov    0x8(%ebp),%eax
 126:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 12a:	0f b6 10             	movzbl (%eax),%edx
 12d:	84 d2                	test   %dl,%dl
 12f:	74 1b                	je     14c <strchr+0x2c>
    if(*s == c)
 131:	38 d1                	cmp    %dl,%cl
 133:	75 0f                	jne    144 <strchr+0x24>
 135:	eb 17                	jmp    14e <strchr+0x2e>
 137:	89 f6                	mov    %esi,%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 140:	38 ca                	cmp    %cl,%dl
 142:	74 0a                	je     14e <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 144:	40                   	inc    %eax
 145:	0f b6 10             	movzbl (%eax),%edx
 148:	84 d2                	test   %dl,%dl
 14a:	75 f4                	jne    140 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 14c:	31 c0                	xor    %eax,%eax
}
 14e:	5d                   	pop    %ebp
 14f:	c3                   	ret    

00000150 <gets>:

char*
gets(char *buf, int max)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	57                   	push   %edi
 154:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 155:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
 157:	53                   	push   %ebx
 158:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 15b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 15e:	eb 32                	jmp    192 <gets+0x42>
    cc = read(0, &c, 1);
 160:	b8 01 00 00 00       	mov    $0x1,%eax
 165:	89 44 24 08          	mov    %eax,0x8(%esp)
 169:	89 7c 24 04          	mov    %edi,0x4(%esp)
 16d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 174:	e8 47 01 00 00       	call   2c0 <read>
    if(cc < 1)
 179:	85 c0                	test   %eax,%eax
 17b:	7e 1d                	jle    19a <gets+0x4a>
      break;
    buf[i++] = c;
 17d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 181:	89 de                	mov    %ebx,%esi
 183:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 186:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 188:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 18c:	74 22                	je     1b0 <gets+0x60>
 18e:	3c 0d                	cmp    $0xd,%al
 190:	74 1e                	je     1b0 <gets+0x60>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 192:	8d 5e 01             	lea    0x1(%esi),%ebx
 195:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 198:	7c c6                	jl     160 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 19a:	8b 45 08             	mov    0x8(%ebp),%eax
 19d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1a1:	83 c4 2c             	add    $0x2c,%esp
 1a4:	5b                   	pop    %ebx
 1a5:	5e                   	pop    %esi
 1a6:	5f                   	pop    %edi
 1a7:	5d                   	pop    %ebp
 1a8:	c3                   	ret    
 1a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1b0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1b3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1b5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1b9:	83 c4 2c             	add    $0x2c,%esp
 1bc:	5b                   	pop    %ebx
 1bd:	5e                   	pop    %esi
 1be:	5f                   	pop    %edi
 1bf:	5d                   	pop    %ebp
 1c0:	c3                   	ret    
 1c1:	eb 0d                	jmp    1d0 <stat>
 1c3:	90                   	nop
 1c4:	90                   	nop
 1c5:	90                   	nop
 1c6:	90                   	nop
 1c7:	90                   	nop
 1c8:	90                   	nop
 1c9:	90                   	nop
 1ca:	90                   	nop
 1cb:	90                   	nop
 1cc:	90                   	nop
 1cd:	90                   	nop
 1ce:	90                   	nop
 1cf:	90                   	nop

000001d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1d0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d1:	31 c0                	xor    %eax,%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 1d3:	89 e5                	mov    %esp,%ebp
 1d5:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d8:	89 44 24 04          	mov    %eax,0x4(%esp)
 1dc:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 1df:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1e2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e5:	89 04 24             	mov    %eax,(%esp)
 1e8:	e8 fb 00 00 00       	call   2e8 <open>
  if(fd < 0)
 1ed:	85 c0                	test   %eax,%eax
 1ef:	78 2f                	js     220 <stat+0x50>
 1f1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1f3:	8b 45 0c             	mov    0xc(%ebp),%eax
 1f6:	89 1c 24             	mov    %ebx,(%esp)
 1f9:	89 44 24 04          	mov    %eax,0x4(%esp)
 1fd:	e8 fe 00 00 00       	call   300 <fstat>
  close(fd);
 202:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 205:	89 c6                	mov    %eax,%esi
  close(fd);
 207:	e8 c4 00 00 00       	call   2d0 <close>
  return r;
 20c:	89 f0                	mov    %esi,%eax
}
 20e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 211:	8b 75 fc             	mov    -0x4(%ebp),%esi
 214:	89 ec                	mov    %ebp,%esp
 216:	5d                   	pop    %ebp
 217:	c3                   	ret    
 218:	90                   	nop
 219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 220:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 225:	eb e7                	jmp    20e <stat+0x3e>
 227:	89 f6                	mov    %esi,%esi
 229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000230 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	8b 4d 08             	mov    0x8(%ebp),%ecx
 236:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 237:	0f be 11             	movsbl (%ecx),%edx
 23a:	88 d0                	mov    %dl,%al
 23c:	2c 30                	sub    $0x30,%al
 23e:	3c 09                	cmp    $0x9,%al
 240:	b8 00 00 00 00       	mov    $0x0,%eax
 245:	77 1e                	ja     265 <atoi+0x35>
 247:	89 f6                	mov    %esi,%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 250:	41                   	inc    %ecx
 251:	8d 04 80             	lea    (%eax,%eax,4),%eax
 254:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 258:	0f be 11             	movsbl (%ecx),%edx
 25b:	88 d3                	mov    %dl,%bl
 25d:	80 eb 30             	sub    $0x30,%bl
 260:	80 fb 09             	cmp    $0x9,%bl
 263:	76 eb                	jbe    250 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 265:	5b                   	pop    %ebx
 266:	5d                   	pop    %ebp
 267:	c3                   	ret    
 268:	90                   	nop
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000270 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	56                   	push   %esi
 274:	8b 45 08             	mov    0x8(%ebp),%eax
 277:	53                   	push   %ebx
 278:	8b 5d 10             	mov    0x10(%ebp),%ebx
 27b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 27e:	85 db                	test   %ebx,%ebx
 280:	7e 1a                	jle    29c <memmove+0x2c>
 282:	31 d2                	xor    %edx,%edx
 284:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 28a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 290:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 294:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 297:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 298:	39 da                	cmp    %ebx,%edx
 29a:	75 f4                	jne    290 <memmove+0x20>
    *dst++ = *src++;
  return vdst;
}
 29c:	5b                   	pop    %ebx
 29d:	5e                   	pop    %esi
 29e:	5d                   	pop    %ebp
 29f:	c3                   	ret    

000002a0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2a0:	b8 01 00 00 00       	mov    $0x1,%eax
 2a5:	cd 40                	int    $0x40
 2a7:	c3                   	ret    

000002a8 <exit>:
SYSCALL(exit)
 2a8:	b8 02 00 00 00       	mov    $0x2,%eax
 2ad:	cd 40                	int    $0x40
 2af:	c3                   	ret    

000002b0 <wait>:
SYSCALL(wait)
 2b0:	b8 03 00 00 00       	mov    $0x3,%eax
 2b5:	cd 40                	int    $0x40
 2b7:	c3                   	ret    

000002b8 <pipe>:
SYSCALL(pipe)
 2b8:	b8 04 00 00 00       	mov    $0x4,%eax
 2bd:	cd 40                	int    $0x40
 2bf:	c3                   	ret    

000002c0 <read>:
SYSCALL(read)
 2c0:	b8 05 00 00 00       	mov    $0x5,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <write>:
SYSCALL(write)
 2c8:	b8 10 00 00 00       	mov    $0x10,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <close>:
SYSCALL(close)
 2d0:	b8 15 00 00 00       	mov    $0x15,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <kill>:
SYSCALL(kill)
 2d8:	b8 06 00 00 00       	mov    $0x6,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <exec>:
SYSCALL(exec)
 2e0:	b8 07 00 00 00       	mov    $0x7,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <open>:
SYSCALL(open)
 2e8:	b8 0f 00 00 00       	mov    $0xf,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <mknod>:
SYSCALL(mknod)
 2f0:	b8 11 00 00 00       	mov    $0x11,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <unlink>:
SYSCALL(unlink)
 2f8:	b8 12 00 00 00       	mov    $0x12,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <fstat>:
SYSCALL(fstat)
 300:	b8 08 00 00 00       	mov    $0x8,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <link>:
SYSCALL(link)
 308:	b8 13 00 00 00       	mov    $0x13,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <mkdir>:
SYSCALL(mkdir)
 310:	b8 14 00 00 00       	mov    $0x14,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <chdir>:
SYSCALL(chdir)
 318:	b8 09 00 00 00       	mov    $0x9,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <dup>:
SYSCALL(dup)
 320:	b8 0a 00 00 00       	mov    $0xa,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <getpid>:
SYSCALL(getpid)
 328:	b8 0b 00 00 00       	mov    $0xb,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <sbrk>:
SYSCALL(sbrk)
 330:	b8 0c 00 00 00       	mov    $0xc,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <sleep>:
SYSCALL(sleep)
 338:	b8 0d 00 00 00       	mov    $0xd,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <uptime>:
SYSCALL(uptime)
 340:	b8 0e 00 00 00       	mov    $0xe,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <policy>:
SYSCALL(policy)
 348:	b8 17 00 00 00       	mov    $0x17,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <detach>:
SYSCALL(detach)
 350:	b8 16 00 00 00       	mov    $0x16,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <priority>:
SYSCALL(priority)
 358:	b8 18 00 00 00       	mov    $0x18,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <wait_stat>:
SYSCALL(wait_stat)
 360:	b8 19 00 00 00       	mov    $0x19,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    
 368:	66 90                	xchg   %ax,%ax
 36a:	66 90                	xchg   %ax,%ax
 36c:	66 90                	xchg   %ax,%ax
 36e:	66 90                	xchg   %ax,%ax

00000370 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	57                   	push   %edi
 374:	56                   	push   %esi
 375:	89 c6                	mov    %eax,%esi
 377:	53                   	push   %ebx
 378:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 37b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 37e:	85 db                	test   %ebx,%ebx
 380:	0f 84 8a 00 00 00    	je     410 <printint+0xa0>
 386:	89 d0                	mov    %edx,%eax
 388:	c1 e8 1f             	shr    $0x1f,%eax
 38b:	84 c0                	test   %al,%al
 38d:	0f 84 7d 00 00 00    	je     410 <printint+0xa0>
    neg = 1;
    x = -xx;
 393:	89 d0                	mov    %edx,%eax
 395:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 397:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 39e:	89 75 c0             	mov    %esi,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 3a1:	31 ff                	xor    %edi,%edi
 3a3:	89 ce                	mov    %ecx,%esi
 3a5:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 3a8:	eb 08                	jmp    3b2 <printint+0x42>
 3aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 3b0:	89 cf                	mov    %ecx,%edi
 3b2:	31 d2                	xor    %edx,%edx
 3b4:	f7 f6                	div    %esi
 3b6:	8d 4f 01             	lea    0x1(%edi),%ecx
 3b9:	0f b6 92 9c 07 00 00 	movzbl 0x79c(%edx),%edx
  }while((x /= base) != 0);
 3c0:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 3c2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 3c5:	75 e9                	jne    3b0 <printint+0x40>
  if(neg)
 3c7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 3ca:	8b 75 c0             	mov    -0x40(%ebp),%esi
 3cd:	85 d2                	test   %edx,%edx
 3cf:	74 08                	je     3d9 <printint+0x69>
    buf[i++] = '-';
 3d1:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 3d6:	8d 4f 02             	lea    0x2(%edi),%ecx
 3d9:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 3dd:	8d 76 00             	lea    0x0(%esi),%esi
 3e0:	0f b6 07             	movzbl (%edi),%eax
 3e3:	4f                   	dec    %edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3e4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 3e8:	89 34 24             	mov    %esi,(%esp)
 3eb:	88 45 d7             	mov    %al,-0x29(%ebp)
 3ee:	b8 01 00 00 00       	mov    $0x1,%eax
 3f3:	89 44 24 08          	mov    %eax,0x8(%esp)
 3f7:	e8 cc fe ff ff       	call   2c8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3fc:	39 df                	cmp    %ebx,%edi
 3fe:	75 e0                	jne    3e0 <printint+0x70>
    putc(fd, buf[i]);
}
 400:	83 c4 4c             	add    $0x4c,%esp
 403:	5b                   	pop    %ebx
 404:	5e                   	pop    %esi
 405:	5f                   	pop    %edi
 406:	5d                   	pop    %ebp
 407:	c3                   	ret    
 408:	90                   	nop
 409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 410:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 412:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 419:	eb 83                	jmp    39e <printint+0x2e>
 41b:	90                   	nop
 41c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000420 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	56                   	push   %esi
 425:	53                   	push   %ebx
 426:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 429:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 42c:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 42f:	0f b6 1e             	movzbl (%esi),%ebx
 432:	84 db                	test   %bl,%bl
 434:	0f 84 c6 00 00 00    	je     500 <printf+0xe0>
 43a:	8d 45 10             	lea    0x10(%ebp),%eax
 43d:	46                   	inc    %esi
 43e:	89 45 d0             	mov    %eax,-0x30(%ebp)
 441:	31 d2                	xor    %edx,%edx
 443:	eb 3b                	jmp    480 <printf+0x60>
 445:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 448:	83 f8 25             	cmp    $0x25,%eax
 44b:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 44e:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 453:	74 1e                	je     473 <printf+0x53>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 455:	b8 01 00 00 00       	mov    $0x1,%eax
 45a:	89 44 24 08          	mov    %eax,0x8(%esp)
 45e:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 461:	89 44 24 04          	mov    %eax,0x4(%esp)
 465:	89 3c 24             	mov    %edi,(%esp)
 468:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 46b:	e8 58 fe ff ff       	call   2c8 <write>
 470:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 473:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 474:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 478:	84 db                	test   %bl,%bl
 47a:	0f 84 80 00 00 00    	je     500 <printf+0xe0>
    c = fmt[i] & 0xff;
    if(state == 0){
 480:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 482:	0f be cb             	movsbl %bl,%ecx
 485:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 488:	74 be                	je     448 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 48a:	83 fa 25             	cmp    $0x25,%edx
 48d:	75 e4                	jne    473 <printf+0x53>
      if(c == 'd'){
 48f:	83 f8 64             	cmp    $0x64,%eax
 492:	0f 84 20 01 00 00    	je     5b8 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 498:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 49e:	83 f9 70             	cmp    $0x70,%ecx
 4a1:	74 6d                	je     510 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4a3:	83 f8 73             	cmp    $0x73,%eax
 4a6:	0f 84 94 00 00 00    	je     540 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4ac:	83 f8 63             	cmp    $0x63,%eax
 4af:	0f 84 14 01 00 00    	je     5c9 <printf+0x1a9>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4b5:	83 f8 25             	cmp    $0x25,%eax
 4b8:	0f 84 d2 00 00 00    	je     590 <printf+0x170>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4be:	b8 01 00 00 00       	mov    $0x1,%eax
 4c3:	46                   	inc    %esi
 4c4:	89 44 24 08          	mov    %eax,0x8(%esp)
 4c8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4cb:	89 44 24 04          	mov    %eax,0x4(%esp)
 4cf:	89 3c 24             	mov    %edi,(%esp)
 4d2:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4d6:	e8 ed fd ff ff       	call   2c8 <write>
 4db:	ba 01 00 00 00       	mov    $0x1,%edx
 4e0:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4e3:	89 54 24 08          	mov    %edx,0x8(%esp)
 4e7:	89 44 24 04          	mov    %eax,0x4(%esp)
 4eb:	89 3c 24             	mov    %edi,(%esp)
 4ee:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 4f1:	e8 d2 fd ff ff       	call   2c8 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4f6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4fa:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4fc:	84 db                	test   %bl,%bl
 4fe:	75 80                	jne    480 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 500:	83 c4 3c             	add    $0x3c,%esp
 503:	5b                   	pop    %ebx
 504:	5e                   	pop    %esi
 505:	5f                   	pop    %edi
 506:	5d                   	pop    %ebp
 507:	c3                   	ret    
 508:	90                   	nop
 509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 510:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 517:	b9 10 00 00 00       	mov    $0x10,%ecx
 51c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 51f:	89 f8                	mov    %edi,%eax
 521:	8b 13                	mov    (%ebx),%edx
 523:	e8 48 fe ff ff       	call   370 <printint>
        ap++;
 528:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 52a:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 52c:	83 c0 04             	add    $0x4,%eax
 52f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 532:	e9 3c ff ff ff       	jmp    473 <printf+0x53>
 537:	89 f6                	mov    %esi,%esi
 539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      } else if(c == 's'){
        s = (char*)*ap;
 540:	8b 45 d0             	mov    -0x30(%ebp),%eax
 543:	8b 18                	mov    (%eax),%ebx
        ap++;
 545:	83 c0 04             	add    $0x4,%eax
 548:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 54b:	b8 94 07 00 00       	mov    $0x794,%eax
 550:	85 db                	test   %ebx,%ebx
 552:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 555:	0f b6 03             	movzbl (%ebx),%eax
 558:	84 c0                	test   %al,%al
 55a:	74 27                	je     583 <printf+0x163>
 55c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 560:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 563:	b8 01 00 00 00       	mov    $0x1,%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 568:	43                   	inc    %ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 569:	89 44 24 08          	mov    %eax,0x8(%esp)
 56d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 570:	89 44 24 04          	mov    %eax,0x4(%esp)
 574:	89 3c 24             	mov    %edi,(%esp)
 577:	e8 4c fd ff ff       	call   2c8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 57c:	0f b6 03             	movzbl (%ebx),%eax
 57f:	84 c0                	test   %al,%al
 581:	75 dd                	jne    560 <printf+0x140>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 583:	31 d2                	xor    %edx,%edx
 585:	e9 e9 fe ff ff       	jmp    473 <printf+0x53>
 58a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 590:	b9 01 00 00 00       	mov    $0x1,%ecx
 595:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 598:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 59c:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a0:	89 3c 24             	mov    %edi,(%esp)
 5a3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 5a6:	e8 1d fd ff ff       	call   2c8 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5ab:	31 d2                	xor    %edx,%edx
 5ad:	e9 c1 fe ff ff       	jmp    473 <printf+0x53>
 5b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 5b8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5bf:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5c4:	e9 53 ff ff ff       	jmp    51c <printf+0xfc>
 5c9:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5cc:	8b 03                	mov    (%ebx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5ce:	89 3c 24             	mov    %edi,(%esp)
 5d1:	88 45 e4             	mov    %al,-0x1c(%ebp)
 5d4:	b8 01 00 00 00       	mov    $0x1,%eax
 5d9:	89 44 24 08          	mov    %eax,0x8(%esp)
 5dd:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5e0:	89 44 24 04          	mov    %eax,0x4(%esp)
 5e4:	e8 df fc ff ff       	call   2c8 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 5e9:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5eb:	31 d2                	xor    %edx,%edx
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 5ed:	83 c0 04             	add    $0x4,%eax
 5f0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5f3:	e9 7b fe ff ff       	jmp    473 <printf+0x53>
 5f8:	66 90                	xchg   %ax,%ax
 5fa:	66 90                	xchg   %ax,%ax
 5fc:	66 90                	xchg   %ax,%ax
 5fe:	66 90                	xchg   %ax,%ax

00000600 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 600:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 601:	a1 2c 0a 00 00       	mov    0xa2c,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 606:	89 e5                	mov    %esp,%ebp
 608:	57                   	push   %edi
 609:	56                   	push   %esi
 60a:	53                   	push   %ebx
 60b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 60e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 610:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 613:	39 c8                	cmp    %ecx,%eax
 615:	73 19                	jae    630 <free+0x30>
 617:	89 f6                	mov    %esi,%esi
 619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 620:	39 d1                	cmp    %edx,%ecx
 622:	72 1c                	jb     640 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 624:	39 d0                	cmp    %edx,%eax
 626:	73 18                	jae    640 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 628:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 62a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 62c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 62e:	72 f0                	jb     620 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 630:	39 d0                	cmp    %edx,%eax
 632:	72 f4                	jb     628 <free+0x28>
 634:	39 d1                	cmp    %edx,%ecx
 636:	73 f0                	jae    628 <free+0x28>
 638:	90                   	nop
 639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 640:	8b 73 fc             	mov    -0x4(%ebx),%esi
 643:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 646:	39 d7                	cmp    %edx,%edi
 648:	74 19                	je     663 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 64a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 64d:	8b 50 04             	mov    0x4(%eax),%edx
 650:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 653:	39 f1                	cmp    %esi,%ecx
 655:	74 25                	je     67c <free+0x7c>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 657:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 659:	5b                   	pop    %ebx
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 65a:	a3 2c 0a 00 00       	mov    %eax,0xa2c
}
 65f:	5e                   	pop    %esi
 660:	5f                   	pop    %edi
 661:	5d                   	pop    %ebp
 662:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 663:	8b 7a 04             	mov    0x4(%edx),%edi
 666:	01 fe                	add    %edi,%esi
 668:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 66b:	8b 10                	mov    (%eax),%edx
 66d:	8b 12                	mov    (%edx),%edx
 66f:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 672:	8b 50 04             	mov    0x4(%eax),%edx
 675:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 678:	39 f1                	cmp    %esi,%ecx
 67a:	75 db                	jne    657 <free+0x57>
    p->s.size += bp->s.size;
 67c:	8b 4b fc             	mov    -0x4(%ebx),%ecx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 67f:	a3 2c 0a 00 00       	mov    %eax,0xa2c
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 684:	01 ca                	add    %ecx,%edx
 686:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 689:	8b 53 f8             	mov    -0x8(%ebx),%edx
 68c:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 68e:	5b                   	pop    %ebx
 68f:	5e                   	pop    %esi
 690:	5f                   	pop    %edi
 691:	5d                   	pop    %ebp
 692:	c3                   	ret    
 693:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	57                   	push   %edi
 6a4:	56                   	push   %esi
 6a5:	53                   	push   %ebx
 6a6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6ac:	8b 15 2c 0a 00 00    	mov    0xa2c,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6b2:	8d 78 07             	lea    0x7(%eax),%edi
 6b5:	c1 ef 03             	shr    $0x3,%edi
 6b8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 6b9:	85 d2                	test   %edx,%edx
 6bb:	0f 84 95 00 00 00    	je     756 <malloc+0xb6>
 6c1:	8b 02                	mov    (%edx),%eax
 6c3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6c6:	39 cf                	cmp    %ecx,%edi
 6c8:	76 66                	jbe    730 <malloc+0x90>
 6ca:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 6d0:	be 00 10 00 00       	mov    $0x1000,%esi
 6d5:	0f 43 f7             	cmovae %edi,%esi
 6d8:	ba 00 80 00 00       	mov    $0x8000,%edx
 6dd:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 6e4:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 6ea:	0f 46 da             	cmovbe %edx,%ebx
 6ed:	eb 0a                	jmp    6f9 <malloc+0x59>
 6ef:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6f0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6f2:	8b 48 04             	mov    0x4(%eax),%ecx
 6f5:	39 cf                	cmp    %ecx,%edi
 6f7:	76 37                	jbe    730 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6f9:	39 05 2c 0a 00 00    	cmp    %eax,0xa2c
 6ff:	89 c2                	mov    %eax,%edx
 701:	75 ed                	jne    6f0 <malloc+0x50>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 703:	89 1c 24             	mov    %ebx,(%esp)
 706:	e8 25 fc ff ff       	call   330 <sbrk>
  if(p == (char*)-1)
 70b:	83 f8 ff             	cmp    $0xffffffff,%eax
 70e:	74 18                	je     728 <malloc+0x88>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 710:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 713:	83 c0 08             	add    $0x8,%eax
 716:	89 04 24             	mov    %eax,(%esp)
 719:	e8 e2 fe ff ff       	call   600 <free>
  return freep;
 71e:	8b 15 2c 0a 00 00    	mov    0xa2c,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 724:	85 d2                	test   %edx,%edx
 726:	75 c8                	jne    6f0 <malloc+0x50>
        return 0;
 728:	31 c0                	xor    %eax,%eax
 72a:	eb 1c                	jmp    748 <malloc+0xa8>
 72c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 730:	39 cf                	cmp    %ecx,%edi
 732:	74 1c                	je     750 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 734:	29 f9                	sub    %edi,%ecx
 736:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 739:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 73c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 73f:	89 15 2c 0a 00 00    	mov    %edx,0xa2c
      return (void*)(p + 1);
 745:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 748:	83 c4 1c             	add    $0x1c,%esp
 74b:	5b                   	pop    %ebx
 74c:	5e                   	pop    %esi
 74d:	5f                   	pop    %edi
 74e:	5d                   	pop    %ebp
 74f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 750:	8b 08                	mov    (%eax),%ecx
 752:	89 0a                	mov    %ecx,(%edx)
 754:	eb e9                	jmp    73f <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 756:	b8 30 0a 00 00       	mov    $0xa30,%eax
 75b:	ba 30 0a 00 00       	mov    $0xa30,%edx
    base.s.size = 0;
 760:	31 c9                	xor    %ecx,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 762:	a3 2c 0a 00 00       	mov    %eax,0xa2c
    base.s.size = 0;
 767:	b8 30 0a 00 00       	mov    $0xa30,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 76c:	89 15 30 0a 00 00    	mov    %edx,0xa30
    base.s.size = 0;
 772:	89 0d 34 0a 00 00    	mov    %ecx,0xa34
 778:	e9 4d ff ff ff       	jmp    6ca <malloc+0x2a>
