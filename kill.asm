
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
  44:	c7 44 24 04 70 07 00 	movl   $0x770,0x4(%esp)
  4b:	00 
  4c:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  53:	e8 b8 03 00 00       	call   410 <printf>
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
 358:	66 90                	xchg   %ax,%ax
 35a:	66 90                	xchg   %ax,%ax
 35c:	66 90                	xchg   %ax,%ax
 35e:	66 90                	xchg   %ax,%ax

00000360 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	56                   	push   %esi
 365:	89 c6                	mov    %eax,%esi
 367:	53                   	push   %ebx
 368:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 36b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 36e:	85 db                	test   %ebx,%ebx
 370:	0f 84 8a 00 00 00    	je     400 <printint+0xa0>
 376:	89 d0                	mov    %edx,%eax
 378:	c1 e8 1f             	shr    $0x1f,%eax
 37b:	84 c0                	test   %al,%al
 37d:	0f 84 7d 00 00 00    	je     400 <printint+0xa0>
    neg = 1;
    x = -xx;
 383:	89 d0                	mov    %edx,%eax
 385:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 387:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 38e:	89 75 c0             	mov    %esi,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 391:	31 ff                	xor    %edi,%edi
 393:	89 ce                	mov    %ecx,%esi
 395:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 398:	eb 08                	jmp    3a2 <printint+0x42>
 39a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 3a0:	89 cf                	mov    %ecx,%edi
 3a2:	31 d2                	xor    %edx,%edx
 3a4:	f7 f6                	div    %esi
 3a6:	8d 4f 01             	lea    0x1(%edi),%ecx
 3a9:	0f b6 92 8c 07 00 00 	movzbl 0x78c(%edx),%edx
  }while((x /= base) != 0);
 3b0:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 3b2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 3b5:	75 e9                	jne    3a0 <printint+0x40>
  if(neg)
 3b7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 3ba:	8b 75 c0             	mov    -0x40(%ebp),%esi
 3bd:	85 d2                	test   %edx,%edx
 3bf:	74 08                	je     3c9 <printint+0x69>
    buf[i++] = '-';
 3c1:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 3c6:	8d 4f 02             	lea    0x2(%edi),%ecx
 3c9:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 3cd:	8d 76 00             	lea    0x0(%esi),%esi
 3d0:	0f b6 07             	movzbl (%edi),%eax
 3d3:	4f                   	dec    %edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3d4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 3d8:	89 34 24             	mov    %esi,(%esp)
 3db:	88 45 d7             	mov    %al,-0x29(%ebp)
 3de:	b8 01 00 00 00       	mov    $0x1,%eax
 3e3:	89 44 24 08          	mov    %eax,0x8(%esp)
 3e7:	e8 dc fe ff ff       	call   2c8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3ec:	39 df                	cmp    %ebx,%edi
 3ee:	75 e0                	jne    3d0 <printint+0x70>
    putc(fd, buf[i]);
}
 3f0:	83 c4 4c             	add    $0x4c,%esp
 3f3:	5b                   	pop    %ebx
 3f4:	5e                   	pop    %esi
 3f5:	5f                   	pop    %edi
 3f6:	5d                   	pop    %ebp
 3f7:	c3                   	ret    
 3f8:	90                   	nop
 3f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 400:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 402:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 409:	eb 83                	jmp    38e <printint+0x2e>
 40b:	90                   	nop
 40c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000410 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	53                   	push   %ebx
 416:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 419:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 41c:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 41f:	0f b6 1e             	movzbl (%esi),%ebx
 422:	84 db                	test   %bl,%bl
 424:	0f 84 c6 00 00 00    	je     4f0 <printf+0xe0>
 42a:	8d 45 10             	lea    0x10(%ebp),%eax
 42d:	46                   	inc    %esi
 42e:	89 45 d0             	mov    %eax,-0x30(%ebp)
 431:	31 d2                	xor    %edx,%edx
 433:	eb 3b                	jmp    470 <printf+0x60>
 435:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 438:	83 f8 25             	cmp    $0x25,%eax
 43b:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 43e:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 443:	74 1e                	je     463 <printf+0x53>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 445:	b8 01 00 00 00       	mov    $0x1,%eax
 44a:	89 44 24 08          	mov    %eax,0x8(%esp)
 44e:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 451:	89 44 24 04          	mov    %eax,0x4(%esp)
 455:	89 3c 24             	mov    %edi,(%esp)
 458:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 45b:	e8 68 fe ff ff       	call   2c8 <write>
 460:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 463:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 464:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 468:	84 db                	test   %bl,%bl
 46a:	0f 84 80 00 00 00    	je     4f0 <printf+0xe0>
    c = fmt[i] & 0xff;
    if(state == 0){
 470:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 472:	0f be cb             	movsbl %bl,%ecx
 475:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 478:	74 be                	je     438 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 47a:	83 fa 25             	cmp    $0x25,%edx
 47d:	75 e4                	jne    463 <printf+0x53>
      if(c == 'd'){
 47f:	83 f8 64             	cmp    $0x64,%eax
 482:	0f 84 20 01 00 00    	je     5a8 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 488:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 48e:	83 f9 70             	cmp    $0x70,%ecx
 491:	74 6d                	je     500 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 493:	83 f8 73             	cmp    $0x73,%eax
 496:	0f 84 94 00 00 00    	je     530 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 49c:	83 f8 63             	cmp    $0x63,%eax
 49f:	0f 84 14 01 00 00    	je     5b9 <printf+0x1a9>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4a5:	83 f8 25             	cmp    $0x25,%eax
 4a8:	0f 84 d2 00 00 00    	je     580 <printf+0x170>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4ae:	b8 01 00 00 00       	mov    $0x1,%eax
 4b3:	46                   	inc    %esi
 4b4:	89 44 24 08          	mov    %eax,0x8(%esp)
 4b8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4bb:	89 44 24 04          	mov    %eax,0x4(%esp)
 4bf:	89 3c 24             	mov    %edi,(%esp)
 4c2:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4c6:	e8 fd fd ff ff       	call   2c8 <write>
 4cb:	ba 01 00 00 00       	mov    $0x1,%edx
 4d0:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4d3:	89 54 24 08          	mov    %edx,0x8(%esp)
 4d7:	89 44 24 04          	mov    %eax,0x4(%esp)
 4db:	89 3c 24             	mov    %edi,(%esp)
 4de:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 4e1:	e8 e2 fd ff ff       	call   2c8 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4e6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4ea:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4ec:	84 db                	test   %bl,%bl
 4ee:	75 80                	jne    470 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4f0:	83 c4 3c             	add    $0x3c,%esp
 4f3:	5b                   	pop    %ebx
 4f4:	5e                   	pop    %esi
 4f5:	5f                   	pop    %edi
 4f6:	5d                   	pop    %ebp
 4f7:	c3                   	ret    
 4f8:	90                   	nop
 4f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 500:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 507:	b9 10 00 00 00       	mov    $0x10,%ecx
 50c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 50f:	89 f8                	mov    %edi,%eax
 511:	8b 13                	mov    (%ebx),%edx
 513:	e8 48 fe ff ff       	call   360 <printint>
        ap++;
 518:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 51a:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 51c:	83 c0 04             	add    $0x4,%eax
 51f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 522:	e9 3c ff ff ff       	jmp    463 <printf+0x53>
 527:	89 f6                	mov    %esi,%esi
 529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      } else if(c == 's'){
        s = (char*)*ap;
 530:	8b 45 d0             	mov    -0x30(%ebp),%eax
 533:	8b 18                	mov    (%eax),%ebx
        ap++;
 535:	83 c0 04             	add    $0x4,%eax
 538:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 53b:	b8 84 07 00 00       	mov    $0x784,%eax
 540:	85 db                	test   %ebx,%ebx
 542:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 545:	0f b6 03             	movzbl (%ebx),%eax
 548:	84 c0                	test   %al,%al
 54a:	74 27                	je     573 <printf+0x163>
 54c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 550:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 553:	b8 01 00 00 00       	mov    $0x1,%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 558:	43                   	inc    %ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 559:	89 44 24 08          	mov    %eax,0x8(%esp)
 55d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 560:	89 44 24 04          	mov    %eax,0x4(%esp)
 564:	89 3c 24             	mov    %edi,(%esp)
 567:	e8 5c fd ff ff       	call   2c8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 56c:	0f b6 03             	movzbl (%ebx),%eax
 56f:	84 c0                	test   %al,%al
 571:	75 dd                	jne    550 <printf+0x140>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 573:	31 d2                	xor    %edx,%edx
 575:	e9 e9 fe ff ff       	jmp    463 <printf+0x53>
 57a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 580:	b9 01 00 00 00       	mov    $0x1,%ecx
 585:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 588:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 58c:	89 44 24 04          	mov    %eax,0x4(%esp)
 590:	89 3c 24             	mov    %edi,(%esp)
 593:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 596:	e8 2d fd ff ff       	call   2c8 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 59b:	31 d2                	xor    %edx,%edx
 59d:	e9 c1 fe ff ff       	jmp    463 <printf+0x53>
 5a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 5a8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5af:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5b4:	e9 53 ff ff ff       	jmp    50c <printf+0xfc>
 5b9:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5bc:	8b 03                	mov    (%ebx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5be:	89 3c 24             	mov    %edi,(%esp)
 5c1:	88 45 e4             	mov    %al,-0x1c(%ebp)
 5c4:	b8 01 00 00 00       	mov    $0x1,%eax
 5c9:	89 44 24 08          	mov    %eax,0x8(%esp)
 5cd:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5d0:	89 44 24 04          	mov    %eax,0x4(%esp)
 5d4:	e8 ef fc ff ff       	call   2c8 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 5d9:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5db:	31 d2                	xor    %edx,%edx
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 5dd:	83 c0 04             	add    $0x4,%eax
 5e0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5e3:	e9 7b fe ff ff       	jmp    463 <printf+0x53>
 5e8:	66 90                	xchg   %ax,%ax
 5ea:	66 90                	xchg   %ax,%ax
 5ec:	66 90                	xchg   %ax,%ax
 5ee:	66 90                	xchg   %ax,%ax

000005f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f1:	a1 1c 0a 00 00       	mov    0xa1c,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 5f6:	89 e5                	mov    %esp,%ebp
 5f8:	57                   	push   %edi
 5f9:	56                   	push   %esi
 5fa:	53                   	push   %ebx
 5fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5fe:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 600:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 603:	39 c8                	cmp    %ecx,%eax
 605:	73 19                	jae    620 <free+0x30>
 607:	89 f6                	mov    %esi,%esi
 609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 610:	39 d1                	cmp    %edx,%ecx
 612:	72 1c                	jb     630 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 614:	39 d0                	cmp    %edx,%eax
 616:	73 18                	jae    630 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 618:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 61a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 61c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 61e:	72 f0                	jb     610 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 620:	39 d0                	cmp    %edx,%eax
 622:	72 f4                	jb     618 <free+0x28>
 624:	39 d1                	cmp    %edx,%ecx
 626:	73 f0                	jae    618 <free+0x28>
 628:	90                   	nop
 629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 630:	8b 73 fc             	mov    -0x4(%ebx),%esi
 633:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 636:	39 d7                	cmp    %edx,%edi
 638:	74 19                	je     653 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 63a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 63d:	8b 50 04             	mov    0x4(%eax),%edx
 640:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 643:	39 f1                	cmp    %esi,%ecx
 645:	74 25                	je     66c <free+0x7c>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 647:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 649:	5b                   	pop    %ebx
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 64a:	a3 1c 0a 00 00       	mov    %eax,0xa1c
}
 64f:	5e                   	pop    %esi
 650:	5f                   	pop    %edi
 651:	5d                   	pop    %ebp
 652:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 653:	8b 7a 04             	mov    0x4(%edx),%edi
 656:	01 fe                	add    %edi,%esi
 658:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 65b:	8b 10                	mov    (%eax),%edx
 65d:	8b 12                	mov    (%edx),%edx
 65f:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 662:	8b 50 04             	mov    0x4(%eax),%edx
 665:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 668:	39 f1                	cmp    %esi,%ecx
 66a:	75 db                	jne    647 <free+0x57>
    p->s.size += bp->s.size;
 66c:	8b 4b fc             	mov    -0x4(%ebx),%ecx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 66f:	a3 1c 0a 00 00       	mov    %eax,0xa1c
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 674:	01 ca                	add    %ecx,%edx
 676:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 679:	8b 53 f8             	mov    -0x8(%ebx),%edx
 67c:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 67e:	5b                   	pop    %ebx
 67f:	5e                   	pop    %esi
 680:	5f                   	pop    %edi
 681:	5d                   	pop    %ebp
 682:	c3                   	ret    
 683:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000690 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	57                   	push   %edi
 694:	56                   	push   %esi
 695:	53                   	push   %ebx
 696:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 699:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 69c:	8b 15 1c 0a 00 00    	mov    0xa1c,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6a2:	8d 78 07             	lea    0x7(%eax),%edi
 6a5:	c1 ef 03             	shr    $0x3,%edi
 6a8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 6a9:	85 d2                	test   %edx,%edx
 6ab:	0f 84 95 00 00 00    	je     746 <malloc+0xb6>
 6b1:	8b 02                	mov    (%edx),%eax
 6b3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6b6:	39 cf                	cmp    %ecx,%edi
 6b8:	76 66                	jbe    720 <malloc+0x90>
 6ba:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 6c0:	be 00 10 00 00       	mov    $0x1000,%esi
 6c5:	0f 43 f7             	cmovae %edi,%esi
 6c8:	ba 00 80 00 00       	mov    $0x8000,%edx
 6cd:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 6d4:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 6da:	0f 46 da             	cmovbe %edx,%ebx
 6dd:	eb 0a                	jmp    6e9 <malloc+0x59>
 6df:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6e0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6e2:	8b 48 04             	mov    0x4(%eax),%ecx
 6e5:	39 cf                	cmp    %ecx,%edi
 6e7:	76 37                	jbe    720 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6e9:	39 05 1c 0a 00 00    	cmp    %eax,0xa1c
 6ef:	89 c2                	mov    %eax,%edx
 6f1:	75 ed                	jne    6e0 <malloc+0x50>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 6f3:	89 1c 24             	mov    %ebx,(%esp)
 6f6:	e8 35 fc ff ff       	call   330 <sbrk>
  if(p == (char*)-1)
 6fb:	83 f8 ff             	cmp    $0xffffffff,%eax
 6fe:	74 18                	je     718 <malloc+0x88>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 700:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 703:	83 c0 08             	add    $0x8,%eax
 706:	89 04 24             	mov    %eax,(%esp)
 709:	e8 e2 fe ff ff       	call   5f0 <free>
  return freep;
 70e:	8b 15 1c 0a 00 00    	mov    0xa1c,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 714:	85 d2                	test   %edx,%edx
 716:	75 c8                	jne    6e0 <malloc+0x50>
        return 0;
 718:	31 c0                	xor    %eax,%eax
 71a:	eb 1c                	jmp    738 <malloc+0xa8>
 71c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 720:	39 cf                	cmp    %ecx,%edi
 722:	74 1c                	je     740 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 724:	29 f9                	sub    %edi,%ecx
 726:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 729:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 72c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 72f:	89 15 1c 0a 00 00    	mov    %edx,0xa1c
      return (void*)(p + 1);
 735:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 738:	83 c4 1c             	add    $0x1c,%esp
 73b:	5b                   	pop    %ebx
 73c:	5e                   	pop    %esi
 73d:	5f                   	pop    %edi
 73e:	5d                   	pop    %ebp
 73f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 740:	8b 08                	mov    (%eax),%ecx
 742:	89 0a                	mov    %ecx,(%edx)
 744:	eb e9                	jmp    72f <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 746:	b8 20 0a 00 00       	mov    $0xa20,%eax
 74b:	ba 20 0a 00 00       	mov    $0xa20,%edx
    base.s.size = 0;
 750:	31 c9                	xor    %ecx,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 752:	a3 1c 0a 00 00       	mov    %eax,0xa1c
    base.s.size = 0;
 757:	b8 20 0a 00 00       	mov    $0xa20,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 75c:	89 15 20 0a 00 00    	mov    %edx,0xa20
    base.s.size = 0;
 762:	89 0d 24 0a 00 00    	mov    %ecx,0xa24
 768:	e9 4d ff ff ff       	jmp    6ba <malloc+0x2a>
