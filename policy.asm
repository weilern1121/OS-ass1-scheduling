
_policy:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"
//#include "proc.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp

    int poli=atoi(argv[1]);
   9:	8b 45 0c             	mov    0xc(%ebp),%eax
   c:	8b 40 04             	mov    0x4(%eax),%eax
   f:	89 04 24             	mov    %eax,(%esp)
  12:	e8 d9 01 00 00       	call   1f0 <atoi>
    policy(poli);
  17:	89 04 24             	mov    %eax,(%esp)
  1a:	e8 e9 02 00 00       	call   308 <policy>
    exit(0);
  1f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  26:	e8 3d 02 00 00       	call   268 <exit>
  2b:	66 90                	xchg   %ax,%ax
  2d:	66 90                	xchg   %ax,%ax
  2f:	90                   	nop

00000030 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	8b 45 08             	mov    0x8(%ebp),%eax
  36:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  39:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  3a:	89 c2                	mov    %eax,%edx
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  40:	41                   	inc    %ecx
  41:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  45:	42                   	inc    %edx
  46:	84 db                	test   %bl,%bl
  48:	88 5a ff             	mov    %bl,-0x1(%edx)
  4b:	75 f3                	jne    40 <strcpy+0x10>
    ;
  return os;
}
  4d:	5b                   	pop    %ebx
  4e:	5d                   	pop    %ebp
  4f:	c3                   	ret    

00000050 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  50:	55                   	push   %ebp
  51:	89 e5                	mov    %esp,%ebp
  53:	8b 4d 08             	mov    0x8(%ebp),%ecx
  56:	56                   	push   %esi
  57:	53                   	push   %ebx
  58:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  5b:	0f b6 01             	movzbl (%ecx),%eax
  5e:	0f b6 13             	movzbl (%ebx),%edx
  61:	84 c0                	test   %al,%al
  63:	75 1c                	jne    81 <strcmp+0x31>
  65:	eb 29                	jmp    90 <strcmp+0x40>
  67:	89 f6                	mov    %esi,%esi
  69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  70:	41                   	inc    %ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  71:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
  74:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  77:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
  7b:	84 c0                	test   %al,%al
  7d:	74 11                	je     90 <strcmp+0x40>
  7f:	89 f3                	mov    %esi,%ebx
  81:	38 d0                	cmp    %dl,%al
  83:	74 eb                	je     70 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  85:	5b                   	pop    %ebx
int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    p++, q++;
  return (uchar)*p - (uchar)*q;
  86:	29 d0                	sub    %edx,%eax
}
  88:	5e                   	pop    %esi
  89:	5d                   	pop    %ebp
  8a:	c3                   	ret    
  8b:	90                   	nop
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  90:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  91:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  93:	29 d0                	sub    %edx,%eax
}
  95:	5e                   	pop    %esi
  96:	5d                   	pop    %ebp
  97:	c3                   	ret    
  98:	90                   	nop
  99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000a0 <strlen>:

uint
strlen(const char *s)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  a6:	80 39 00             	cmpb   $0x0,(%ecx)
  a9:	74 10                	je     bb <strlen+0x1b>
  ab:	31 d2                	xor    %edx,%edx
  ad:	8d 76 00             	lea    0x0(%esi),%esi
  b0:	42                   	inc    %edx
  b1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  b5:	89 d0                	mov    %edx,%eax
  b7:	75 f7                	jne    b0 <strlen+0x10>
    ;
  return n;
}
  b9:	5d                   	pop    %ebp
  ba:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
  bb:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
  bd:	5d                   	pop    %ebp
  be:	c3                   	ret    
  bf:	90                   	nop

000000c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	8b 55 08             	mov    0x8(%ebp),%edx
  c6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  cd:	89 d7                	mov    %edx,%edi
  cf:	fc                   	cld    
  d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  d2:	5f                   	pop    %edi
  d3:	89 d0                	mov    %edx,%eax
  d5:	5d                   	pop    %ebp
  d6:	c3                   	ret    
  d7:	89 f6                	mov    %esi,%esi
  d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000e0 <strchr>:

char*
strchr(const char *s, char c)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 45 08             	mov    0x8(%ebp),%eax
  e6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
  ea:	0f b6 10             	movzbl (%eax),%edx
  ed:	84 d2                	test   %dl,%dl
  ef:	74 1b                	je     10c <strchr+0x2c>
    if(*s == c)
  f1:	38 d1                	cmp    %dl,%cl
  f3:	75 0f                	jne    104 <strchr+0x24>
  f5:	eb 17                	jmp    10e <strchr+0x2e>
  f7:	89 f6                	mov    %esi,%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 100:	38 ca                	cmp    %cl,%dl
 102:	74 0a                	je     10e <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 104:	40                   	inc    %eax
 105:	0f b6 10             	movzbl (%eax),%edx
 108:	84 d2                	test   %dl,%dl
 10a:	75 f4                	jne    100 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 10c:	31 c0                	xor    %eax,%eax
}
 10e:	5d                   	pop    %ebp
 10f:	c3                   	ret    

00000110 <gets>:

char*
gets(char *buf, int max)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 115:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
 117:	53                   	push   %ebx
 118:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 11b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 11e:	eb 32                	jmp    152 <gets+0x42>
    cc = read(0, &c, 1);
 120:	b8 01 00 00 00       	mov    $0x1,%eax
 125:	89 44 24 08          	mov    %eax,0x8(%esp)
 129:	89 7c 24 04          	mov    %edi,0x4(%esp)
 12d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 134:	e8 47 01 00 00       	call   280 <read>
    if(cc < 1)
 139:	85 c0                	test   %eax,%eax
 13b:	7e 1d                	jle    15a <gets+0x4a>
      break;
    buf[i++] = c;
 13d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 141:	89 de                	mov    %ebx,%esi
 143:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 146:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 148:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 14c:	74 22                	je     170 <gets+0x60>
 14e:	3c 0d                	cmp    $0xd,%al
 150:	74 1e                	je     170 <gets+0x60>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 152:	8d 5e 01             	lea    0x1(%esi),%ebx
 155:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 158:	7c c6                	jl     120 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 15a:	8b 45 08             	mov    0x8(%ebp),%eax
 15d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 161:	83 c4 2c             	add    $0x2c,%esp
 164:	5b                   	pop    %ebx
 165:	5e                   	pop    %esi
 166:	5f                   	pop    %edi
 167:	5d                   	pop    %ebp
 168:	c3                   	ret    
 169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 170:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 173:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 175:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 179:	83 c4 2c             	add    $0x2c,%esp
 17c:	5b                   	pop    %ebx
 17d:	5e                   	pop    %esi
 17e:	5f                   	pop    %edi
 17f:	5d                   	pop    %ebp
 180:	c3                   	ret    
 181:	eb 0d                	jmp    190 <stat>
 183:	90                   	nop
 184:	90                   	nop
 185:	90                   	nop
 186:	90                   	nop
 187:	90                   	nop
 188:	90                   	nop
 189:	90                   	nop
 18a:	90                   	nop
 18b:	90                   	nop
 18c:	90                   	nop
 18d:	90                   	nop
 18e:	90                   	nop
 18f:	90                   	nop

00000190 <stat>:

int
stat(const char *n, struct stat *st)
{
 190:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 191:	31 c0                	xor    %eax,%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 193:	89 e5                	mov    %esp,%ebp
 195:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 198:	89 44 24 04          	mov    %eax,0x4(%esp)
 19c:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 19f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1a2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1a5:	89 04 24             	mov    %eax,(%esp)
 1a8:	e8 fb 00 00 00       	call   2a8 <open>
  if(fd < 0)
 1ad:	85 c0                	test   %eax,%eax
 1af:	78 2f                	js     1e0 <stat+0x50>
 1b1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1b3:	8b 45 0c             	mov    0xc(%ebp),%eax
 1b6:	89 1c 24             	mov    %ebx,(%esp)
 1b9:	89 44 24 04          	mov    %eax,0x4(%esp)
 1bd:	e8 fe 00 00 00       	call   2c0 <fstat>
  close(fd);
 1c2:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 1c5:	89 c6                	mov    %eax,%esi
  close(fd);
 1c7:	e8 c4 00 00 00       	call   290 <close>
  return r;
 1cc:	89 f0                	mov    %esi,%eax
}
 1ce:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 1d1:	8b 75 fc             	mov    -0x4(%ebp),%esi
 1d4:	89 ec                	mov    %ebp,%esp
 1d6:	5d                   	pop    %ebp
 1d7:	c3                   	ret    
 1d8:	90                   	nop
 1d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 1e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1e5:	eb e7                	jmp    1ce <stat+0x3e>
 1e7:	89 f6                	mov    %esi,%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001f0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1f6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1f7:	0f be 11             	movsbl (%ecx),%edx
 1fa:	88 d0                	mov    %dl,%al
 1fc:	2c 30                	sub    $0x30,%al
 1fe:	3c 09                	cmp    $0x9,%al
 200:	b8 00 00 00 00       	mov    $0x0,%eax
 205:	77 1e                	ja     225 <atoi+0x35>
 207:	89 f6                	mov    %esi,%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 210:	41                   	inc    %ecx
 211:	8d 04 80             	lea    (%eax,%eax,4),%eax
 214:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 218:	0f be 11             	movsbl (%ecx),%edx
 21b:	88 d3                	mov    %dl,%bl
 21d:	80 eb 30             	sub    $0x30,%bl
 220:	80 fb 09             	cmp    $0x9,%bl
 223:	76 eb                	jbe    210 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 225:	5b                   	pop    %ebx
 226:	5d                   	pop    %ebp
 227:	c3                   	ret    
 228:	90                   	nop
 229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000230 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	56                   	push   %esi
 234:	8b 45 08             	mov    0x8(%ebp),%eax
 237:	53                   	push   %ebx
 238:	8b 5d 10             	mov    0x10(%ebp),%ebx
 23b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 23e:	85 db                	test   %ebx,%ebx
 240:	7e 1a                	jle    25c <memmove+0x2c>
 242:	31 d2                	xor    %edx,%edx
 244:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 24a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 250:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 254:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 257:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 258:	39 da                	cmp    %ebx,%edx
 25a:	75 f4                	jne    250 <memmove+0x20>
    *dst++ = *src++;
  return vdst;
}
 25c:	5b                   	pop    %ebx
 25d:	5e                   	pop    %esi
 25e:	5d                   	pop    %ebp
 25f:	c3                   	ret    

00000260 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 260:	b8 01 00 00 00       	mov    $0x1,%eax
 265:	cd 40                	int    $0x40
 267:	c3                   	ret    

00000268 <exit>:
SYSCALL(exit)
 268:	b8 02 00 00 00       	mov    $0x2,%eax
 26d:	cd 40                	int    $0x40
 26f:	c3                   	ret    

00000270 <wait>:
SYSCALL(wait)
 270:	b8 03 00 00 00       	mov    $0x3,%eax
 275:	cd 40                	int    $0x40
 277:	c3                   	ret    

00000278 <pipe>:
SYSCALL(pipe)
 278:	b8 04 00 00 00       	mov    $0x4,%eax
 27d:	cd 40                	int    $0x40
 27f:	c3                   	ret    

00000280 <read>:
SYSCALL(read)
 280:	b8 05 00 00 00       	mov    $0x5,%eax
 285:	cd 40                	int    $0x40
 287:	c3                   	ret    

00000288 <write>:
SYSCALL(write)
 288:	b8 10 00 00 00       	mov    $0x10,%eax
 28d:	cd 40                	int    $0x40
 28f:	c3                   	ret    

00000290 <close>:
SYSCALL(close)
 290:	b8 15 00 00 00       	mov    $0x15,%eax
 295:	cd 40                	int    $0x40
 297:	c3                   	ret    

00000298 <kill>:
SYSCALL(kill)
 298:	b8 06 00 00 00       	mov    $0x6,%eax
 29d:	cd 40                	int    $0x40
 29f:	c3                   	ret    

000002a0 <exec>:
SYSCALL(exec)
 2a0:	b8 07 00 00 00       	mov    $0x7,%eax
 2a5:	cd 40                	int    $0x40
 2a7:	c3                   	ret    

000002a8 <open>:
SYSCALL(open)
 2a8:	b8 0f 00 00 00       	mov    $0xf,%eax
 2ad:	cd 40                	int    $0x40
 2af:	c3                   	ret    

000002b0 <mknod>:
SYSCALL(mknod)
 2b0:	b8 11 00 00 00       	mov    $0x11,%eax
 2b5:	cd 40                	int    $0x40
 2b7:	c3                   	ret    

000002b8 <unlink>:
SYSCALL(unlink)
 2b8:	b8 12 00 00 00       	mov    $0x12,%eax
 2bd:	cd 40                	int    $0x40
 2bf:	c3                   	ret    

000002c0 <fstat>:
SYSCALL(fstat)
 2c0:	b8 08 00 00 00       	mov    $0x8,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <link>:
SYSCALL(link)
 2c8:	b8 13 00 00 00       	mov    $0x13,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <mkdir>:
SYSCALL(mkdir)
 2d0:	b8 14 00 00 00       	mov    $0x14,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <chdir>:
SYSCALL(chdir)
 2d8:	b8 09 00 00 00       	mov    $0x9,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <dup>:
SYSCALL(dup)
 2e0:	b8 0a 00 00 00       	mov    $0xa,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <getpid>:
SYSCALL(getpid)
 2e8:	b8 0b 00 00 00       	mov    $0xb,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <sbrk>:
SYSCALL(sbrk)
 2f0:	b8 0c 00 00 00       	mov    $0xc,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <sleep>:
SYSCALL(sleep)
 2f8:	b8 0d 00 00 00       	mov    $0xd,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <uptime>:
SYSCALL(uptime)
 300:	b8 0e 00 00 00       	mov    $0xe,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <policy>:
SYSCALL(policy)
 308:	b8 17 00 00 00       	mov    $0x17,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <detach>:
SYSCALL(detach)
 310:	b8 16 00 00 00       	mov    $0x16,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <priority>:
SYSCALL(priority)
 318:	b8 18 00 00 00       	mov    $0x18,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <wait_stat>:
SYSCALL(wait_stat)
 320:	b8 19 00 00 00       	mov    $0x19,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    
 328:	66 90                	xchg   %ax,%ax
 32a:	66 90                	xchg   %ax,%ax
 32c:	66 90                	xchg   %ax,%ax
 32e:	66 90                	xchg   %ax,%ax

00000330 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	56                   	push   %esi
 335:	89 c6                	mov    %eax,%esi
 337:	53                   	push   %ebx
 338:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 33b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 33e:	85 db                	test   %ebx,%ebx
 340:	0f 84 8a 00 00 00    	je     3d0 <printint+0xa0>
 346:	89 d0                	mov    %edx,%eax
 348:	c1 e8 1f             	shr    $0x1f,%eax
 34b:	84 c0                	test   %al,%al
 34d:	0f 84 7d 00 00 00    	je     3d0 <printint+0xa0>
    neg = 1;
    x = -xx;
 353:	89 d0                	mov    %edx,%eax
 355:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 357:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 35e:	89 75 c0             	mov    %esi,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 361:	31 ff                	xor    %edi,%edi
 363:	89 ce                	mov    %ecx,%esi
 365:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 368:	eb 08                	jmp    372 <printint+0x42>
 36a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 370:	89 cf                	mov    %ecx,%edi
 372:	31 d2                	xor    %edx,%edx
 374:	f7 f6                	div    %esi
 376:	8d 4f 01             	lea    0x1(%edi),%ecx
 379:	0f b6 92 48 07 00 00 	movzbl 0x748(%edx),%edx
  }while((x /= base) != 0);
 380:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 382:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 385:	75 e9                	jne    370 <printint+0x40>
  if(neg)
 387:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 38a:	8b 75 c0             	mov    -0x40(%ebp),%esi
 38d:	85 d2                	test   %edx,%edx
 38f:	74 08                	je     399 <printint+0x69>
    buf[i++] = '-';
 391:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 396:	8d 4f 02             	lea    0x2(%edi),%ecx
 399:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 39d:	8d 76 00             	lea    0x0(%esi),%esi
 3a0:	0f b6 07             	movzbl (%edi),%eax
 3a3:	4f                   	dec    %edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3a4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 3a8:	89 34 24             	mov    %esi,(%esp)
 3ab:	88 45 d7             	mov    %al,-0x29(%ebp)
 3ae:	b8 01 00 00 00       	mov    $0x1,%eax
 3b3:	89 44 24 08          	mov    %eax,0x8(%esp)
 3b7:	e8 cc fe ff ff       	call   288 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3bc:	39 df                	cmp    %ebx,%edi
 3be:	75 e0                	jne    3a0 <printint+0x70>
    putc(fd, buf[i]);
}
 3c0:	83 c4 4c             	add    $0x4c,%esp
 3c3:	5b                   	pop    %ebx
 3c4:	5e                   	pop    %esi
 3c5:	5f                   	pop    %edi
 3c6:	5d                   	pop    %ebp
 3c7:	c3                   	ret    
 3c8:	90                   	nop
 3c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3d0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3d2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3d9:	eb 83                	jmp    35e <printint+0x2e>
 3db:	90                   	nop
 3dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003e0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	56                   	push   %esi
 3e5:	53                   	push   %ebx
 3e6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3e9:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 3ec:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3ef:	0f b6 1e             	movzbl (%esi),%ebx
 3f2:	84 db                	test   %bl,%bl
 3f4:	0f 84 c6 00 00 00    	je     4c0 <printf+0xe0>
 3fa:	8d 45 10             	lea    0x10(%ebp),%eax
 3fd:	46                   	inc    %esi
 3fe:	89 45 d0             	mov    %eax,-0x30(%ebp)
 401:	31 d2                	xor    %edx,%edx
 403:	eb 3b                	jmp    440 <printf+0x60>
 405:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 408:	83 f8 25             	cmp    $0x25,%eax
 40b:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 40e:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 413:	74 1e                	je     433 <printf+0x53>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 415:	b8 01 00 00 00       	mov    $0x1,%eax
 41a:	89 44 24 08          	mov    %eax,0x8(%esp)
 41e:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 421:	89 44 24 04          	mov    %eax,0x4(%esp)
 425:	89 3c 24             	mov    %edi,(%esp)
 428:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 42b:	e8 58 fe ff ff       	call   288 <write>
 430:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 433:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 434:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 438:	84 db                	test   %bl,%bl
 43a:	0f 84 80 00 00 00    	je     4c0 <printf+0xe0>
    c = fmt[i] & 0xff;
    if(state == 0){
 440:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 442:	0f be cb             	movsbl %bl,%ecx
 445:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 448:	74 be                	je     408 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 44a:	83 fa 25             	cmp    $0x25,%edx
 44d:	75 e4                	jne    433 <printf+0x53>
      if(c == 'd'){
 44f:	83 f8 64             	cmp    $0x64,%eax
 452:	0f 84 20 01 00 00    	je     578 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 458:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 45e:	83 f9 70             	cmp    $0x70,%ecx
 461:	74 6d                	je     4d0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 463:	83 f8 73             	cmp    $0x73,%eax
 466:	0f 84 94 00 00 00    	je     500 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 46c:	83 f8 63             	cmp    $0x63,%eax
 46f:	0f 84 14 01 00 00    	je     589 <printf+0x1a9>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 475:	83 f8 25             	cmp    $0x25,%eax
 478:	0f 84 d2 00 00 00    	je     550 <printf+0x170>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 47e:	b8 01 00 00 00       	mov    $0x1,%eax
 483:	46                   	inc    %esi
 484:	89 44 24 08          	mov    %eax,0x8(%esp)
 488:	8d 45 e7             	lea    -0x19(%ebp),%eax
 48b:	89 44 24 04          	mov    %eax,0x4(%esp)
 48f:	89 3c 24             	mov    %edi,(%esp)
 492:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 496:	e8 ed fd ff ff       	call   288 <write>
 49b:	ba 01 00 00 00       	mov    $0x1,%edx
 4a0:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4a3:	89 54 24 08          	mov    %edx,0x8(%esp)
 4a7:	89 44 24 04          	mov    %eax,0x4(%esp)
 4ab:	89 3c 24             	mov    %edi,(%esp)
 4ae:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 4b1:	e8 d2 fd ff ff       	call   288 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4b6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4ba:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4bc:	84 db                	test   %bl,%bl
 4be:	75 80                	jne    440 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4c0:	83 c4 3c             	add    $0x3c,%esp
 4c3:	5b                   	pop    %ebx
 4c4:	5e                   	pop    %esi
 4c5:	5f                   	pop    %edi
 4c6:	5d                   	pop    %ebp
 4c7:	c3                   	ret    
 4c8:	90                   	nop
 4c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4d0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4d7:	b9 10 00 00 00       	mov    $0x10,%ecx
 4dc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 4df:	89 f8                	mov    %edi,%eax
 4e1:	8b 13                	mov    (%ebx),%edx
 4e3:	e8 48 fe ff ff       	call   330 <printint>
        ap++;
 4e8:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4ea:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 4ec:	83 c0 04             	add    $0x4,%eax
 4ef:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4f2:	e9 3c ff ff ff       	jmp    433 <printf+0x53>
 4f7:	89 f6                	mov    %esi,%esi
 4f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      } else if(c == 's'){
        s = (char*)*ap;
 500:	8b 45 d0             	mov    -0x30(%ebp),%eax
 503:	8b 18                	mov    (%eax),%ebx
        ap++;
 505:	83 c0 04             	add    $0x4,%eax
 508:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 50b:	b8 40 07 00 00       	mov    $0x740,%eax
 510:	85 db                	test   %ebx,%ebx
 512:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 515:	0f b6 03             	movzbl (%ebx),%eax
 518:	84 c0                	test   %al,%al
 51a:	74 27                	je     543 <printf+0x163>
 51c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 520:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 523:	b8 01 00 00 00       	mov    $0x1,%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 528:	43                   	inc    %ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 529:	89 44 24 08          	mov    %eax,0x8(%esp)
 52d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 530:	89 44 24 04          	mov    %eax,0x4(%esp)
 534:	89 3c 24             	mov    %edi,(%esp)
 537:	e8 4c fd ff ff       	call   288 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 53c:	0f b6 03             	movzbl (%ebx),%eax
 53f:	84 c0                	test   %al,%al
 541:	75 dd                	jne    520 <printf+0x140>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 543:	31 d2                	xor    %edx,%edx
 545:	e9 e9 fe ff ff       	jmp    433 <printf+0x53>
 54a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 550:	b9 01 00 00 00       	mov    $0x1,%ecx
 555:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 558:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 55c:	89 44 24 04          	mov    %eax,0x4(%esp)
 560:	89 3c 24             	mov    %edi,(%esp)
 563:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 566:	e8 1d fd ff ff       	call   288 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 56b:	31 d2                	xor    %edx,%edx
 56d:	e9 c1 fe ff ff       	jmp    433 <printf+0x53>
 572:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 578:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 57f:	b9 0a 00 00 00       	mov    $0xa,%ecx
 584:	e9 53 ff ff ff       	jmp    4dc <printf+0xfc>
 589:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 58c:	8b 03                	mov    (%ebx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 58e:	89 3c 24             	mov    %edi,(%esp)
 591:	88 45 e4             	mov    %al,-0x1c(%ebp)
 594:	b8 01 00 00 00       	mov    $0x1,%eax
 599:	89 44 24 08          	mov    %eax,0x8(%esp)
 59d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5a0:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a4:	e8 df fc ff ff       	call   288 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 5a9:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5ab:	31 d2                	xor    %edx,%edx
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 5ad:	83 c0 04             	add    $0x4,%eax
 5b0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5b3:	e9 7b fe ff ff       	jmp    433 <printf+0x53>
 5b8:	66 90                	xchg   %ax,%ax
 5ba:	66 90                	xchg   %ax,%ax
 5bc:	66 90                	xchg   %ax,%ax
 5be:	66 90                	xchg   %ax,%ax

000005c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5c1:	a1 d4 09 00 00       	mov    0x9d4,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 5c6:	89 e5                	mov    %esp,%ebp
 5c8:	57                   	push   %edi
 5c9:	56                   	push   %esi
 5ca:	53                   	push   %ebx
 5cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5ce:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5d0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d3:	39 c8                	cmp    %ecx,%eax
 5d5:	73 19                	jae    5f0 <free+0x30>
 5d7:	89 f6                	mov    %esi,%esi
 5d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 5e0:	39 d1                	cmp    %edx,%ecx
 5e2:	72 1c                	jb     600 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5e4:	39 d0                	cmp    %edx,%eax
 5e6:	73 18                	jae    600 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 5e8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5ea:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5ec:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5ee:	72 f0                	jb     5e0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5f0:	39 d0                	cmp    %edx,%eax
 5f2:	72 f4                	jb     5e8 <free+0x28>
 5f4:	39 d1                	cmp    %edx,%ecx
 5f6:	73 f0                	jae    5e8 <free+0x28>
 5f8:	90                   	nop
 5f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 600:	8b 73 fc             	mov    -0x4(%ebx),%esi
 603:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 606:	39 d7                	cmp    %edx,%edi
 608:	74 19                	je     623 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 60a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 60d:	8b 50 04             	mov    0x4(%eax),%edx
 610:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 613:	39 f1                	cmp    %esi,%ecx
 615:	74 25                	je     63c <free+0x7c>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 617:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 619:	5b                   	pop    %ebx
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 61a:	a3 d4 09 00 00       	mov    %eax,0x9d4
}
 61f:	5e                   	pop    %esi
 620:	5f                   	pop    %edi
 621:	5d                   	pop    %ebp
 622:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 623:	8b 7a 04             	mov    0x4(%edx),%edi
 626:	01 fe                	add    %edi,%esi
 628:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 62b:	8b 10                	mov    (%eax),%edx
 62d:	8b 12                	mov    (%edx),%edx
 62f:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 632:	8b 50 04             	mov    0x4(%eax),%edx
 635:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 638:	39 f1                	cmp    %esi,%ecx
 63a:	75 db                	jne    617 <free+0x57>
    p->s.size += bp->s.size;
 63c:	8b 4b fc             	mov    -0x4(%ebx),%ecx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 63f:	a3 d4 09 00 00       	mov    %eax,0x9d4
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 644:	01 ca                	add    %ecx,%edx
 646:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 649:	8b 53 f8             	mov    -0x8(%ebx),%edx
 64c:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 64e:	5b                   	pop    %ebx
 64f:	5e                   	pop    %esi
 650:	5f                   	pop    %edi
 651:	5d                   	pop    %ebp
 652:	c3                   	ret    
 653:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000660 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 660:	55                   	push   %ebp
 661:	89 e5                	mov    %esp,%ebp
 663:	57                   	push   %edi
 664:	56                   	push   %esi
 665:	53                   	push   %ebx
 666:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 669:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 66c:	8b 15 d4 09 00 00    	mov    0x9d4,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 672:	8d 78 07             	lea    0x7(%eax),%edi
 675:	c1 ef 03             	shr    $0x3,%edi
 678:	47                   	inc    %edi
  if((prevp = freep) == 0){
 679:	85 d2                	test   %edx,%edx
 67b:	0f 84 95 00 00 00    	je     716 <malloc+0xb6>
 681:	8b 02                	mov    (%edx),%eax
 683:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 686:	39 cf                	cmp    %ecx,%edi
 688:	76 66                	jbe    6f0 <malloc+0x90>
 68a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 690:	be 00 10 00 00       	mov    $0x1000,%esi
 695:	0f 43 f7             	cmovae %edi,%esi
 698:	ba 00 80 00 00       	mov    $0x8000,%edx
 69d:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 6a4:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 6aa:	0f 46 da             	cmovbe %edx,%ebx
 6ad:	eb 0a                	jmp    6b9 <malloc+0x59>
 6af:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6b0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6b2:	8b 48 04             	mov    0x4(%eax),%ecx
 6b5:	39 cf                	cmp    %ecx,%edi
 6b7:	76 37                	jbe    6f0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6b9:	39 05 d4 09 00 00    	cmp    %eax,0x9d4
 6bf:	89 c2                	mov    %eax,%edx
 6c1:	75 ed                	jne    6b0 <malloc+0x50>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 6c3:	89 1c 24             	mov    %ebx,(%esp)
 6c6:	e8 25 fc ff ff       	call   2f0 <sbrk>
  if(p == (char*)-1)
 6cb:	83 f8 ff             	cmp    $0xffffffff,%eax
 6ce:	74 18                	je     6e8 <malloc+0x88>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 6d0:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 6d3:	83 c0 08             	add    $0x8,%eax
 6d6:	89 04 24             	mov    %eax,(%esp)
 6d9:	e8 e2 fe ff ff       	call   5c0 <free>
  return freep;
 6de:	8b 15 d4 09 00 00    	mov    0x9d4,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 6e4:	85 d2                	test   %edx,%edx
 6e6:	75 c8                	jne    6b0 <malloc+0x50>
        return 0;
 6e8:	31 c0                	xor    %eax,%eax
 6ea:	eb 1c                	jmp    708 <malloc+0xa8>
 6ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 6f0:	39 cf                	cmp    %ecx,%edi
 6f2:	74 1c                	je     710 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 6f4:	29 f9                	sub    %edi,%ecx
 6f6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 6f9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 6fc:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 6ff:	89 15 d4 09 00 00    	mov    %edx,0x9d4
      return (void*)(p + 1);
 705:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 708:	83 c4 1c             	add    $0x1c,%esp
 70b:	5b                   	pop    %ebx
 70c:	5e                   	pop    %esi
 70d:	5f                   	pop    %edi
 70e:	5d                   	pop    %ebp
 70f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 710:	8b 08                	mov    (%eax),%ecx
 712:	89 0a                	mov    %ecx,(%edx)
 714:	eb e9                	jmp    6ff <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 716:	b8 d8 09 00 00       	mov    $0x9d8,%eax
 71b:	ba d8 09 00 00       	mov    $0x9d8,%edx
    base.s.size = 0;
 720:	31 c9                	xor    %ecx,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 722:	a3 d4 09 00 00       	mov    %eax,0x9d4
    base.s.size = 0;
 727:	b8 d8 09 00 00       	mov    $0x9d8,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 72c:	89 15 d8 09 00 00    	mov    %edx,0x9d8
    base.s.size = 0;
 732:	89 0d dc 09 00 00    	mov    %ecx,0x9dc
 738:	e9 4d ff ff ff       	jmp    68a <malloc+0x2a>
