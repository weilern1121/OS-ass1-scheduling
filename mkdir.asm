
_mkdir:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 e4 f0             	and    $0xfffffff0,%esp
   9:	83 ec 10             	sub    $0x10,%esp
   c:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i;

  if(argc < 2){
   f:	83 ff 01             	cmp    $0x1,%edi
  12:	7e 4a                	jle    5e <main+0x5e>
  14:	8b 45 0c             	mov    0xc(%ebp),%eax
  17:	be 01 00 00 00       	mov    $0x1,%esi
  1c:	8d 58 04             	lea    0x4(%eax),%ebx
  1f:	90                   	nop
    printf(2, "Usage: mkdir files...\n");
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if(mkdir(argv[i]) < 0){
  20:	8b 03                	mov    (%ebx),%eax
  22:	89 04 24             	mov    %eax,(%esp)
  25:	e8 f6 02 00 00       	call   320 <mkdir>
  2a:	85 c0                	test   %eax,%eax
  2c:	78 14                	js     42 <main+0x42>
  if(argc < 2){
    printf(2, "Usage: mkdir files...\n");
    exit(0);
  }

  for(i = 1; i < argc; i++){
  2e:	46                   	inc    %esi
  2f:	83 c3 04             	add    $0x4,%ebx
  32:	39 f7                	cmp    %esi,%edi
  34:	75 ea                	jne    20 <main+0x20>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit(0);
  36:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3d:	e8 76 02 00 00       	call   2b8 <exit>
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if(mkdir(argv[i]) < 0){
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  42:	8b 03                	mov    (%ebx),%eax
  44:	c7 44 24 04 97 07 00 	movl   $0x797,0x4(%esp)
  4b:	00 
  4c:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  53:	89 44 24 08          	mov    %eax,0x8(%esp)
  57:	e8 c4 03 00 00       	call   420 <printf>
      break;
  5c:	eb d8                	jmp    36 <main+0x36>
main(int argc, char *argv[])
{
  int i;

  if(argc < 2){
    printf(2, "Usage: mkdir files...\n");
  5e:	c7 44 24 04 80 07 00 	movl   $0x780,0x4(%esp)
  65:	00 
  66:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  6d:	e8 ae 03 00 00       	call   420 <printf>
    exit(0);
  72:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  79:	e8 3a 02 00 00       	call   2b8 <exit>
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
 3b9:	0f b6 92 bc 07 00 00 	movzbl 0x7bc(%edx),%edx
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
 3f7:	e8 dc fe ff ff       	call   2d8 <write>
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
 46b:	e8 68 fe ff ff       	call   2d8 <write>
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
 4d6:	e8 fd fd ff ff       	call   2d8 <write>
 4db:	ba 01 00 00 00       	mov    $0x1,%edx
 4e0:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4e3:	89 54 24 08          	mov    %edx,0x8(%esp)
 4e7:	89 44 24 04          	mov    %eax,0x4(%esp)
 4eb:	89 3c 24             	mov    %edi,(%esp)
 4ee:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 4f1:	e8 e2 fd ff ff       	call   2d8 <write>
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
 54b:	b8 b3 07 00 00       	mov    $0x7b3,%eax
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
 577:	e8 5c fd ff ff       	call   2d8 <write>
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
 5a6:	e8 2d fd ff ff       	call   2d8 <write>
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
 5e4:	e8 ef fc ff ff       	call   2d8 <write>
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
 601:	a1 4c 0a 00 00       	mov    0xa4c,%eax
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
 65a:	a3 4c 0a 00 00       	mov    %eax,0xa4c
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
 67f:	a3 4c 0a 00 00       	mov    %eax,0xa4c
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
 6ac:	8b 15 4c 0a 00 00    	mov    0xa4c,%edx
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
 6f9:	39 05 4c 0a 00 00    	cmp    %eax,0xa4c
 6ff:	89 c2                	mov    %eax,%edx
 701:	75 ed                	jne    6f0 <malloc+0x50>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 703:	89 1c 24             	mov    %ebx,(%esp)
 706:	e8 35 fc ff ff       	call   340 <sbrk>
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
 71e:	8b 15 4c 0a 00 00    	mov    0xa4c,%edx
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
 73f:	89 15 4c 0a 00 00    	mov    %edx,0xa4c
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
 756:	b8 50 0a 00 00       	mov    $0xa50,%eax
 75b:	ba 50 0a 00 00       	mov    $0xa50,%edx
    base.s.size = 0;
 760:	31 c9                	xor    %ecx,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 762:	a3 4c 0a 00 00       	mov    %eax,0xa4c
    base.s.size = 0;
 767:	b8 50 0a 00 00       	mov    $0xa50,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 76c:	89 15 50 0a 00 00    	mov    %edx,0xa50
    base.s.size = 0;
 772:	89 0d 54 0a 00 00    	mov    %ecx,0xa54
 778:	e9 4d ff ff ff       	jmp    6ca <malloc+0x2a>
