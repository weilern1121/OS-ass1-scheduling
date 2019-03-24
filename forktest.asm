
_forktest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "fork test OK\n");
}

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  forktest();
   9:	e8 42 00 00 00       	call   50 <forktest>
  exit(0);
   e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  15:	e8 be 03 00 00       	call   3d8 <exit>
  1a:	66 90                	xchg   %ax,%ax
  1c:	66 90                	xchg   %ax,%ax
  1e:	66 90                	xchg   %ax,%ax

00000020 <printf>:

#define N  1000

void
printf(int fd, const char *s, ...)
{
  20:	55                   	push   %ebp
  21:	89 e5                	mov    %esp,%ebp
  23:	53                   	push   %ebx
  24:	83 ec 14             	sub    $0x14,%esp
  27:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  write(fd, s, strlen(s));
  2a:	89 1c 24             	mov    %ebx,(%esp)
  2d:	e8 de 01 00 00       	call   210 <strlen>
  32:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  36:	89 44 24 08          	mov    %eax,0x8(%esp)
  3a:	8b 45 08             	mov    0x8(%ebp),%eax
  3d:	89 04 24             	mov    %eax,(%esp)
  40:	e8 b3 03 00 00       	call   3f8 <write>
}
  45:	83 c4 14             	add    $0x14,%esp
  48:	5b                   	pop    %ebx
  49:	5d                   	pop    %ebp
  4a:	c3                   	ret    
  4b:	90                   	nop
  4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000050 <forktest>:

void
forktest(void)
{
  50:	55                   	push   %ebp
  51:	89 e5                	mov    %esp,%ebp
  53:	53                   	push   %ebx
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<N; n++){
  54:	31 db                	xor    %ebx,%ebx
  write(fd, s, strlen(s));
}

void
forktest(void)
{
  56:	83 ec 14             	sub    $0x14,%esp
#define N  1000

void
printf(int fd, const char *s, ...)
{
  write(fd, s, strlen(s));
  59:	c7 04 24 90 04 00 00 	movl   $0x490,(%esp)
  60:	e8 ab 01 00 00       	call   210 <strlen>
  65:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  6c:	89 44 24 08          	mov    %eax,0x8(%esp)
  70:	b8 90 04 00 00       	mov    $0x490,%eax
  75:	89 44 24 04          	mov    %eax,0x4(%esp)
  79:	e8 7a 03 00 00       	call   3f8 <write>
  7e:	eb 12                	jmp    92 <forktest+0x42>

  for(n=0; n<N; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
  80:	0f 84 d8 00 00 00    	je     15e <forktest+0x10e>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<N; n++){
  86:	43                   	inc    %ebx
  87:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
  8d:	8d 76 00             	lea    0x0(%esi),%esi
  90:	74 76                	je     108 <forktest+0xb8>
    pid = fork();
  92:	e8 39 03 00 00       	call   3d0 <fork>
    if(pid < 0)
  97:	85 c0                	test   %eax,%eax
  99:	79 e5                	jns    80 <forktest+0x30>
  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit(0);
  }

  for(; n > 0; n--){
  9b:	85 db                	test   %ebx,%ebx
  9d:	8d 76 00             	lea    0x0(%esi),%esi
  a0:	74 21                	je     c3 <forktest+0x73>
  a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(wait(0) < 0){
  b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  b7:	e8 24 03 00 00       	call   3e0 <wait>
  bc:	85 c0                	test   %eax,%eax
  be:	78 79                	js     139 <forktest+0xe9>
  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit(0);
  }

  for(; n > 0; n--){
  c0:	4b                   	dec    %ebx
  c1:	75 ed                	jne    b0 <forktest+0x60>
      printf(1, "wait stopped early\n");
      exit(0);
    }
  }

  if(wait(0) != -1){
  c3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  ca:	e8 11 03 00 00       	call   3e0 <wait>
  cf:	40                   	inc    %eax
  d0:	0f 85 94 00 00 00    	jne    16a <forktest+0x11a>
#define N  1000

void
printf(int fd, const char *s, ...)
{
  write(fd, s, strlen(s));
  d6:	c7 04 24 c2 04 00 00 	movl   $0x4c2,(%esp)
  dd:	e8 2e 01 00 00       	call   210 <strlen>
  e2:	ba c2 04 00 00       	mov    $0x4c2,%edx
  e7:	89 54 24 04          	mov    %edx,0x4(%esp)
  eb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  f2:	89 44 24 08          	mov    %eax,0x8(%esp)
  f6:	e8 fd 02 00 00       	call   3f8 <write>
    printf(1, "wait got too many\n");
    exit(0);
  }

  printf(1, "fork test OK\n");
}
  fb:	83 c4 14             	add    $0x14,%esp
  fe:	5b                   	pop    %ebx
  ff:	5d                   	pop    %ebp
 100:	c3                   	ret    
 101:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
#define N  1000

void
printf(int fd, const char *s, ...)
{
  write(fd, s, strlen(s));
 108:	c7 04 24 d0 04 00 00 	movl   $0x4d0,(%esp)
 10f:	e8 fc 00 00 00       	call   210 <strlen>
 114:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 11b:	89 44 24 08          	mov    %eax,0x8(%esp)
 11f:	b8 d0 04 00 00       	mov    $0x4d0,%eax
 124:	89 44 24 04          	mov    %eax,0x4(%esp)
 128:	e8 cb 02 00 00       	call   3f8 <write>
      exit(0);
  }

  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit(0);
 12d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 134:	e8 9f 02 00 00       	call   3d8 <exit>
#define N  1000

void
printf(int fd, const char *s, ...)
{
  write(fd, s, strlen(s));
 139:	c7 04 24 9b 04 00 00 	movl   $0x49b,(%esp)
 140:	bb 9b 04 00 00       	mov    $0x49b,%ebx
 145:	e8 c6 00 00 00       	call   210 <strlen>
 14a:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 14e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 155:	89 44 24 08          	mov    %eax,0x8(%esp)
 159:	e8 9a 02 00 00       	call   3f8 <write>
  }

  for(; n > 0; n--){
    if(wait(0) < 0){
      printf(1, "wait stopped early\n");
      exit(0);
 15e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 165:	e8 6e 02 00 00       	call   3d8 <exit>
#define N  1000

void
printf(int fd, const char *s, ...)
{
  write(fd, s, strlen(s));
 16a:	c7 04 24 af 04 00 00 	movl   $0x4af,(%esp)
 171:	e8 9a 00 00 00       	call   210 <strlen>
 176:	b9 af 04 00 00       	mov    $0x4af,%ecx
 17b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 17f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 186:	89 44 24 08          	mov    %eax,0x8(%esp)
 18a:	e8 69 02 00 00       	call   3f8 <write>
    }
  }

  if(wait(0) != -1){
    printf(1, "wait got too many\n");
    exit(0);
 18f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 196:	e8 3d 02 00 00       	call   3d8 <exit>
 19b:	66 90                	xchg   %ax,%ax
 19d:	66 90                	xchg   %ax,%ax
 19f:	90                   	nop

000001a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	8b 45 08             	mov    0x8(%ebp),%eax
 1a6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1a9:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1aa:	89 c2                	mov    %eax,%edx
 1ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1b0:	41                   	inc    %ecx
 1b1:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 1b5:	42                   	inc    %edx
 1b6:	84 db                	test   %bl,%bl
 1b8:	88 5a ff             	mov    %bl,-0x1(%edx)
 1bb:	75 f3                	jne    1b0 <strcpy+0x10>
    ;
  return os;
}
 1bd:	5b                   	pop    %ebx
 1be:	5d                   	pop    %ebp
 1bf:	c3                   	ret    

000001c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1c6:	56                   	push   %esi
 1c7:	53                   	push   %ebx
 1c8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 1cb:	0f b6 01             	movzbl (%ecx),%eax
 1ce:	0f b6 13             	movzbl (%ebx),%edx
 1d1:	84 c0                	test   %al,%al
 1d3:	75 1c                	jne    1f1 <strcmp+0x31>
 1d5:	eb 29                	jmp    200 <strcmp+0x40>
 1d7:	89 f6                	mov    %esi,%esi
 1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 1e0:	41                   	inc    %ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1e1:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 1e4:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1e7:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 1eb:	84 c0                	test   %al,%al
 1ed:	74 11                	je     200 <strcmp+0x40>
 1ef:	89 f3                	mov    %esi,%ebx
 1f1:	38 d0                	cmp    %dl,%al
 1f3:	74 eb                	je     1e0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 1f5:	5b                   	pop    %ebx
int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1f6:	29 d0                	sub    %edx,%eax
}
 1f8:	5e                   	pop    %esi
 1f9:	5d                   	pop    %ebp
 1fa:	c3                   	ret    
 1fb:	90                   	nop
 1fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 200:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 201:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 203:	29 d0                	sub    %edx,%eax
}
 205:	5e                   	pop    %esi
 206:	5d                   	pop    %ebp
 207:	c3                   	ret    
 208:	90                   	nop
 209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000210 <strlen>:

uint
strlen(const char *s)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 216:	80 39 00             	cmpb   $0x0,(%ecx)
 219:	74 10                	je     22b <strlen+0x1b>
 21b:	31 d2                	xor    %edx,%edx
 21d:	8d 76 00             	lea    0x0(%esi),%esi
 220:	42                   	inc    %edx
 221:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 225:	89 d0                	mov    %edx,%eax
 227:	75 f7                	jne    220 <strlen+0x10>
    ;
  return n;
}
 229:	5d                   	pop    %ebp
 22a:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 22b:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 22d:	5d                   	pop    %ebp
 22e:	c3                   	ret    
 22f:	90                   	nop

00000230 <memset>:

void*
memset(void *dst, int c, uint n)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	8b 55 08             	mov    0x8(%ebp),%edx
 236:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 237:	8b 4d 10             	mov    0x10(%ebp),%ecx
 23a:	8b 45 0c             	mov    0xc(%ebp),%eax
 23d:	89 d7                	mov    %edx,%edi
 23f:	fc                   	cld    
 240:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 242:	5f                   	pop    %edi
 243:	89 d0                	mov    %edx,%eax
 245:	5d                   	pop    %ebp
 246:	c3                   	ret    
 247:	89 f6                	mov    %esi,%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <strchr>:

char*
strchr(const char *s, char c)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	8b 45 08             	mov    0x8(%ebp),%eax
 256:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 25a:	0f b6 10             	movzbl (%eax),%edx
 25d:	84 d2                	test   %dl,%dl
 25f:	74 1b                	je     27c <strchr+0x2c>
    if(*s == c)
 261:	38 d1                	cmp    %dl,%cl
 263:	75 0f                	jne    274 <strchr+0x24>
 265:	eb 17                	jmp    27e <strchr+0x2e>
 267:	89 f6                	mov    %esi,%esi
 269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 270:	38 ca                	cmp    %cl,%dl
 272:	74 0a                	je     27e <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 274:	40                   	inc    %eax
 275:	0f b6 10             	movzbl (%eax),%edx
 278:	84 d2                	test   %dl,%dl
 27a:	75 f4                	jne    270 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 27c:	31 c0                	xor    %eax,%eax
}
 27e:	5d                   	pop    %ebp
 27f:	c3                   	ret    

00000280 <gets>:

char*
gets(char *buf, int max)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	57                   	push   %edi
 284:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 285:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
 287:	53                   	push   %ebx
 288:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 28b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 28e:	eb 32                	jmp    2c2 <gets+0x42>
    cc = read(0, &c, 1);
 290:	b8 01 00 00 00       	mov    $0x1,%eax
 295:	89 44 24 08          	mov    %eax,0x8(%esp)
 299:	89 7c 24 04          	mov    %edi,0x4(%esp)
 29d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2a4:	e8 47 01 00 00       	call   3f0 <read>
    if(cc < 1)
 2a9:	85 c0                	test   %eax,%eax
 2ab:	7e 1d                	jle    2ca <gets+0x4a>
      break;
    buf[i++] = c;
 2ad:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2b1:	89 de                	mov    %ebx,%esi
 2b3:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 2b6:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 2b8:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 2bc:	74 22                	je     2e0 <gets+0x60>
 2be:	3c 0d                	cmp    $0xd,%al
 2c0:	74 1e                	je     2e0 <gets+0x60>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2c2:	8d 5e 01             	lea    0x1(%esi),%ebx
 2c5:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2c8:	7c c6                	jl     290 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2ca:	8b 45 08             	mov    0x8(%ebp),%eax
 2cd:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2d1:	83 c4 2c             	add    $0x2c,%esp
 2d4:	5b                   	pop    %ebx
 2d5:	5e                   	pop    %esi
 2d6:	5f                   	pop    %edi
 2d7:	5d                   	pop    %ebp
 2d8:	c3                   	ret    
 2d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2e0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2e3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2e5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2e9:	83 c4 2c             	add    $0x2c,%esp
 2ec:	5b                   	pop    %ebx
 2ed:	5e                   	pop    %esi
 2ee:	5f                   	pop    %edi
 2ef:	5d                   	pop    %ebp
 2f0:	c3                   	ret    
 2f1:	eb 0d                	jmp    300 <stat>
 2f3:	90                   	nop
 2f4:	90                   	nop
 2f5:	90                   	nop
 2f6:	90                   	nop
 2f7:	90                   	nop
 2f8:	90                   	nop
 2f9:	90                   	nop
 2fa:	90                   	nop
 2fb:	90                   	nop
 2fc:	90                   	nop
 2fd:	90                   	nop
 2fe:	90                   	nop
 2ff:	90                   	nop

00000300 <stat>:

int
stat(const char *n, struct stat *st)
{
 300:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 301:	31 c0                	xor    %eax,%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 303:	89 e5                	mov    %esp,%ebp
 305:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 308:	89 44 24 04          	mov    %eax,0x4(%esp)
 30c:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 30f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 312:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 315:	89 04 24             	mov    %eax,(%esp)
 318:	e8 fb 00 00 00       	call   418 <open>
  if(fd < 0)
 31d:	85 c0                	test   %eax,%eax
 31f:	78 2f                	js     350 <stat+0x50>
 321:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 323:	8b 45 0c             	mov    0xc(%ebp),%eax
 326:	89 1c 24             	mov    %ebx,(%esp)
 329:	89 44 24 04          	mov    %eax,0x4(%esp)
 32d:	e8 fe 00 00 00       	call   430 <fstat>
  close(fd);
 332:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 335:	89 c6                	mov    %eax,%esi
  close(fd);
 337:	e8 c4 00 00 00       	call   400 <close>
  return r;
 33c:	89 f0                	mov    %esi,%eax
}
 33e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 341:	8b 75 fc             	mov    -0x4(%ebp),%esi
 344:	89 ec                	mov    %ebp,%esp
 346:	5d                   	pop    %ebp
 347:	c3                   	ret    
 348:	90                   	nop
 349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 350:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 355:	eb e7                	jmp    33e <stat+0x3e>
 357:	89 f6                	mov    %esi,%esi
 359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000360 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	8b 4d 08             	mov    0x8(%ebp),%ecx
 366:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 367:	0f be 11             	movsbl (%ecx),%edx
 36a:	88 d0                	mov    %dl,%al
 36c:	2c 30                	sub    $0x30,%al
 36e:	3c 09                	cmp    $0x9,%al
 370:	b8 00 00 00 00       	mov    $0x0,%eax
 375:	77 1e                	ja     395 <atoi+0x35>
 377:	89 f6                	mov    %esi,%esi
 379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 380:	41                   	inc    %ecx
 381:	8d 04 80             	lea    (%eax,%eax,4),%eax
 384:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 388:	0f be 11             	movsbl (%ecx),%edx
 38b:	88 d3                	mov    %dl,%bl
 38d:	80 eb 30             	sub    $0x30,%bl
 390:	80 fb 09             	cmp    $0x9,%bl
 393:	76 eb                	jbe    380 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 395:	5b                   	pop    %ebx
 396:	5d                   	pop    %ebp
 397:	c3                   	ret    
 398:	90                   	nop
 399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	56                   	push   %esi
 3a4:	8b 45 08             	mov    0x8(%ebp),%eax
 3a7:	53                   	push   %ebx
 3a8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3ae:	85 db                	test   %ebx,%ebx
 3b0:	7e 1a                	jle    3cc <memmove+0x2c>
 3b2:	31 d2                	xor    %edx,%edx
 3b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 3c0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 3c4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 3c7:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3c8:	39 da                	cmp    %ebx,%edx
 3ca:	75 f4                	jne    3c0 <memmove+0x20>
    *dst++ = *src++;
  return vdst;
}
 3cc:	5b                   	pop    %ebx
 3cd:	5e                   	pop    %esi
 3ce:	5d                   	pop    %ebp
 3cf:	c3                   	ret    

000003d0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3d0:	b8 01 00 00 00       	mov    $0x1,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <exit>:
SYSCALL(exit)
 3d8:	b8 02 00 00 00       	mov    $0x2,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <wait>:
SYSCALL(wait)
 3e0:	b8 03 00 00 00       	mov    $0x3,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <pipe>:
SYSCALL(pipe)
 3e8:	b8 04 00 00 00       	mov    $0x4,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <read>:
SYSCALL(read)
 3f0:	b8 05 00 00 00       	mov    $0x5,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <write>:
SYSCALL(write)
 3f8:	b8 10 00 00 00       	mov    $0x10,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <close>:
SYSCALL(close)
 400:	b8 15 00 00 00       	mov    $0x15,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <kill>:
SYSCALL(kill)
 408:	b8 06 00 00 00       	mov    $0x6,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <exec>:
SYSCALL(exec)
 410:	b8 07 00 00 00       	mov    $0x7,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <open>:
SYSCALL(open)
 418:	b8 0f 00 00 00       	mov    $0xf,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <mknod>:
SYSCALL(mknod)
 420:	b8 11 00 00 00       	mov    $0x11,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <unlink>:
SYSCALL(unlink)
 428:	b8 12 00 00 00       	mov    $0x12,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <fstat>:
SYSCALL(fstat)
 430:	b8 08 00 00 00       	mov    $0x8,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <link>:
SYSCALL(link)
 438:	b8 13 00 00 00       	mov    $0x13,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <mkdir>:
SYSCALL(mkdir)
 440:	b8 14 00 00 00       	mov    $0x14,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <chdir>:
SYSCALL(chdir)
 448:	b8 09 00 00 00       	mov    $0x9,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <dup>:
SYSCALL(dup)
 450:	b8 0a 00 00 00       	mov    $0xa,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <getpid>:
SYSCALL(getpid)
 458:	b8 0b 00 00 00       	mov    $0xb,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <sbrk>:
SYSCALL(sbrk)
 460:	b8 0c 00 00 00       	mov    $0xc,%eax
 465:	cd 40                	int    $0x40
 467:	c3                   	ret    

00000468 <sleep>:
SYSCALL(sleep)
 468:	b8 0d 00 00 00       	mov    $0xd,%eax
 46d:	cd 40                	int    $0x40
 46f:	c3                   	ret    

00000470 <uptime>:
SYSCALL(uptime)
 470:	b8 0e 00 00 00       	mov    $0xe,%eax
 475:	cd 40                	int    $0x40
 477:	c3                   	ret    

00000478 <policy>:
SYSCALL(policy)
 478:	b8 17 00 00 00       	mov    $0x17,%eax
 47d:	cd 40                	int    $0x40
 47f:	c3                   	ret    

00000480 <detach>:
SYSCALL(detach)
 480:	b8 16 00 00 00       	mov    $0x16,%eax
 485:	cd 40                	int    $0x40
 487:	c3                   	ret    

00000488 <priority>:
SYSCALL(priority)
 488:	b8 18 00 00 00       	mov    $0x18,%eax
 48d:	cd 40                	int    $0x40
 48f:	c3                   	ret    
