
_sanity:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 e4 f0             	and    $0xfffffff0,%esp
   9:	83 ec 10             	sub    $0x10,%esp

    int pid;
    int first_status=-2;
    int second_status=-2;
    int third_status=-2;
    pid = fork(); // the child pid is 99
   c:	e8 cf 02 00 00       	call   2e0 <fork>
    if(pid > 0) {
  11:	85 c0                	test   %eax,%eax
  13:	7e 7b                	jle    90 <main+0x90>
        first_status = detach(pid); // status = 0
  15:	89 04 24             	mov    %eax,(%esp)
  18:	89 c3                	mov    %eax,%ebx
  1a:	e8 71 03 00 00       	call   390 <detach>
        second_status = detach(pid); // status = -1, because this process has already
  1f:	89 1c 24             	mov    %ebx,(%esp)
    int first_status=-2;
    int second_status=-2;
    int third_status=-2;
    pid = fork(); // the child pid is 99
    if(pid > 0) {
        first_status = detach(pid); // status = 0
  22:	89 c7                	mov    %eax,%edi
        second_status = detach(pid); // status = -1, because this process has already
  24:	e8 67 03 00 00       	call   390 <detach>
                                    // detached this child, and it doesn’t have
                                    // this child anymore.
        third_status = detach(77); // status = -1, because this process doesn’t
  29:	c7 04 24 4d 00 00 00 	movl   $0x4d,(%esp)
    int second_status=-2;
    int third_status=-2;
    pid = fork(); // the child pid is 99
    if(pid > 0) {
        first_status = detach(pid); // status = 0
        second_status = detach(pid); // status = -1, because this process has already
  30:	89 c6                	mov    %eax,%esi
                                    // detached this child, and it doesn’t have
                                    // this child anymore.
        third_status = detach(77); // status = -1, because this process doesn’t
  32:	e8 59 03 00 00       	call   390 <detach>
  37:	89 c3                	mov    %eax,%ebx
                                    // have a child with this pid.
        //sleep(100);
    }
    printf(2,"first_status= %d, should be 0.\n",first_status);
  39:	b8 b0 07 00 00       	mov    $0x7b0,%eax
  3e:	89 44 24 04          	mov    %eax,0x4(%esp)
  42:	89 7c 24 08          	mov    %edi,0x8(%esp)
  46:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  4d:	e8 fe 03 00 00       	call   450 <printf>
    printf(2,"second_status= %d, should be -1.\n"
  52:	ba d0 07 00 00       	mov    $0x7d0,%edx
  57:	89 54 24 04          	mov    %edx,0x4(%esp)
  5b:	89 74 24 08          	mov    %esi,0x8(%esp)
  5f:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  66:	e8 e5 03 00 00       	call   450 <printf>
             "(because this process has already\n"
             "detached this child, and it doesn’t have\n"
             "this child anymore).\n",second_status);
    printf(2,"third_status= %d, should be -1 \n  (because this process doesn’t"
  6b:	b9 54 08 00 00       	mov    $0x854,%ecx
  70:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  74:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  78:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  7f:	e8 cc 03 00 00       	call   450 <printf>
             " have a child with this pid.)  .\n",third_status);
    exit(0);
  84:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  8b:	e8 58 02 00 00       	call   2e8 <exit>


    int pid;
    int first_status=-2;
    int second_status=-2;
    int third_status=-2;
  90:	bb fe ff ff ff       	mov    $0xfffffffe,%ebx
//    exit(0);


    int pid;
    int first_status=-2;
    int second_status=-2;
  95:	be fe ff ff ff       	mov    $0xfffffffe,%esi
//    }
//    exit(0);


    int pid;
    int first_status=-2;
  9a:	bf fe ff ff ff       	mov    $0xfffffffe,%edi
  9f:	eb 98                	jmp    39 <main+0x39>
  a1:	66 90                	xchg   %ax,%ax
  a3:	66 90                	xchg   %ax,%ax
  a5:	66 90                	xchg   %ax,%ax
  a7:	66 90                	xchg   %ax,%ax
  a9:	66 90                	xchg   %ax,%ax
  ab:	66 90                	xchg   %ax,%ax
  ad:	66 90                	xchg   %ax,%ax
  af:	90                   	nop

000000b0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	8b 45 08             	mov    0x8(%ebp),%eax
  b6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  b9:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  ba:	89 c2                	mov    %eax,%edx
  bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  c0:	41                   	inc    %ecx
  c1:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  c5:	42                   	inc    %edx
  c6:	84 db                	test   %bl,%bl
  c8:	88 5a ff             	mov    %bl,-0x1(%edx)
  cb:	75 f3                	jne    c0 <strcpy+0x10>
    ;
  return os;
}
  cd:	5b                   	pop    %ebx
  ce:	5d                   	pop    %ebp
  cf:	c3                   	ret    

000000d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  d6:	56                   	push   %esi
  d7:	53                   	push   %ebx
  d8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  db:	0f b6 01             	movzbl (%ecx),%eax
  de:	0f b6 13             	movzbl (%ebx),%edx
  e1:	84 c0                	test   %al,%al
  e3:	75 1c                	jne    101 <strcmp+0x31>
  e5:	eb 29                	jmp    110 <strcmp+0x40>
  e7:	89 f6                	mov    %esi,%esi
  e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  f0:	41                   	inc    %ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  f1:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
  f4:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  f7:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
  fb:	84 c0                	test   %al,%al
  fd:	74 11                	je     110 <strcmp+0x40>
  ff:	89 f3                	mov    %esi,%ebx
 101:	38 d0                	cmp    %dl,%al
 103:	74 eb                	je     f0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 105:	5b                   	pop    %ebx
int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    p++, q++;
  return (uchar)*p - (uchar)*q;
 106:	29 d0                	sub    %edx,%eax
}
 108:	5e                   	pop    %esi
 109:	5d                   	pop    %ebp
 10a:	c3                   	ret    
 10b:	90                   	nop
 10c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 110:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 111:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 113:	29 d0                	sub    %edx,%eax
}
 115:	5e                   	pop    %esi
 116:	5d                   	pop    %ebp
 117:	c3                   	ret    
 118:	90                   	nop
 119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000120 <strlen>:

uint
strlen(const char *s)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 126:	80 39 00             	cmpb   $0x0,(%ecx)
 129:	74 10                	je     13b <strlen+0x1b>
 12b:	31 d2                	xor    %edx,%edx
 12d:	8d 76 00             	lea    0x0(%esi),%esi
 130:	42                   	inc    %edx
 131:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 135:	89 d0                	mov    %edx,%eax
 137:	75 f7                	jne    130 <strlen+0x10>
    ;
  return n;
}
 139:	5d                   	pop    %ebp
 13a:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 13b:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 13d:	5d                   	pop    %ebp
 13e:	c3                   	ret    
 13f:	90                   	nop

00000140 <memset>:

void*
memset(void *dst, int c, uint n)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	8b 55 08             	mov    0x8(%ebp),%edx
 146:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 147:	8b 4d 10             	mov    0x10(%ebp),%ecx
 14a:	8b 45 0c             	mov    0xc(%ebp),%eax
 14d:	89 d7                	mov    %edx,%edi
 14f:	fc                   	cld    
 150:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 152:	5f                   	pop    %edi
 153:	89 d0                	mov    %edx,%eax
 155:	5d                   	pop    %ebp
 156:	c3                   	ret    
 157:	89 f6                	mov    %esi,%esi
 159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000160 <strchr>:

char*
strchr(const char *s, char c)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	8b 45 08             	mov    0x8(%ebp),%eax
 166:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 16a:	0f b6 10             	movzbl (%eax),%edx
 16d:	84 d2                	test   %dl,%dl
 16f:	74 1b                	je     18c <strchr+0x2c>
    if(*s == c)
 171:	38 d1                	cmp    %dl,%cl
 173:	75 0f                	jne    184 <strchr+0x24>
 175:	eb 17                	jmp    18e <strchr+0x2e>
 177:	89 f6                	mov    %esi,%esi
 179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 180:	38 ca                	cmp    %cl,%dl
 182:	74 0a                	je     18e <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 184:	40                   	inc    %eax
 185:	0f b6 10             	movzbl (%eax),%edx
 188:	84 d2                	test   %dl,%dl
 18a:	75 f4                	jne    180 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 18c:	31 c0                	xor    %eax,%eax
}
 18e:	5d                   	pop    %ebp
 18f:	c3                   	ret    

00000190 <gets>:

char*
gets(char *buf, int max)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	57                   	push   %edi
 194:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 195:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
 197:	53                   	push   %ebx
 198:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 19b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 19e:	eb 32                	jmp    1d2 <gets+0x42>
    cc = read(0, &c, 1);
 1a0:	b8 01 00 00 00       	mov    $0x1,%eax
 1a5:	89 44 24 08          	mov    %eax,0x8(%esp)
 1a9:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1b4:	e8 47 01 00 00       	call   300 <read>
    if(cc < 1)
 1b9:	85 c0                	test   %eax,%eax
 1bb:	7e 1d                	jle    1da <gets+0x4a>
      break;
    buf[i++] = c;
 1bd:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1c1:	89 de                	mov    %ebx,%esi
 1c3:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 1c6:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 1c8:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 1cc:	74 22                	je     1f0 <gets+0x60>
 1ce:	3c 0d                	cmp    $0xd,%al
 1d0:	74 1e                	je     1f0 <gets+0x60>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d2:	8d 5e 01             	lea    0x1(%esi),%ebx
 1d5:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1d8:	7c c6                	jl     1a0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1da:	8b 45 08             	mov    0x8(%ebp),%eax
 1dd:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1e1:	83 c4 2c             	add    $0x2c,%esp
 1e4:	5b                   	pop    %ebx
 1e5:	5e                   	pop    %esi
 1e6:	5f                   	pop    %edi
 1e7:	5d                   	pop    %ebp
 1e8:	c3                   	ret    
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1f0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1f5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1f9:	83 c4 2c             	add    $0x2c,%esp
 1fc:	5b                   	pop    %ebx
 1fd:	5e                   	pop    %esi
 1fe:	5f                   	pop    %edi
 1ff:	5d                   	pop    %ebp
 200:	c3                   	ret    
 201:	eb 0d                	jmp    210 <stat>
 203:	90                   	nop
 204:	90                   	nop
 205:	90                   	nop
 206:	90                   	nop
 207:	90                   	nop
 208:	90                   	nop
 209:	90                   	nop
 20a:	90                   	nop
 20b:	90                   	nop
 20c:	90                   	nop
 20d:	90                   	nop
 20e:	90                   	nop
 20f:	90                   	nop

00000210 <stat>:

int
stat(const char *n, struct stat *st)
{
 210:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 211:	31 c0                	xor    %eax,%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 213:	89 e5                	mov    %esp,%ebp
 215:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 218:	89 44 24 04          	mov    %eax,0x4(%esp)
 21c:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 21f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 222:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 225:	89 04 24             	mov    %eax,(%esp)
 228:	e8 fb 00 00 00       	call   328 <open>
  if(fd < 0)
 22d:	85 c0                	test   %eax,%eax
 22f:	78 2f                	js     260 <stat+0x50>
 231:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 233:	8b 45 0c             	mov    0xc(%ebp),%eax
 236:	89 1c 24             	mov    %ebx,(%esp)
 239:	89 44 24 04          	mov    %eax,0x4(%esp)
 23d:	e8 fe 00 00 00       	call   340 <fstat>
  close(fd);
 242:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 245:	89 c6                	mov    %eax,%esi
  close(fd);
 247:	e8 c4 00 00 00       	call   310 <close>
  return r;
 24c:	89 f0                	mov    %esi,%eax
}
 24e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 251:	8b 75 fc             	mov    -0x4(%ebp),%esi
 254:	89 ec                	mov    %ebp,%esp
 256:	5d                   	pop    %ebp
 257:	c3                   	ret    
 258:	90                   	nop
 259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 260:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 265:	eb e7                	jmp    24e <stat+0x3e>
 267:	89 f6                	mov    %esi,%esi
 269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000270 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	8b 4d 08             	mov    0x8(%ebp),%ecx
 276:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 277:	0f be 11             	movsbl (%ecx),%edx
 27a:	88 d0                	mov    %dl,%al
 27c:	2c 30                	sub    $0x30,%al
 27e:	3c 09                	cmp    $0x9,%al
 280:	b8 00 00 00 00       	mov    $0x0,%eax
 285:	77 1e                	ja     2a5 <atoi+0x35>
 287:	89 f6                	mov    %esi,%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 290:	41                   	inc    %ecx
 291:	8d 04 80             	lea    (%eax,%eax,4),%eax
 294:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 298:	0f be 11             	movsbl (%ecx),%edx
 29b:	88 d3                	mov    %dl,%bl
 29d:	80 eb 30             	sub    $0x30,%bl
 2a0:	80 fb 09             	cmp    $0x9,%bl
 2a3:	76 eb                	jbe    290 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 2a5:	5b                   	pop    %ebx
 2a6:	5d                   	pop    %ebp
 2a7:	c3                   	ret    
 2a8:	90                   	nop
 2a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	56                   	push   %esi
 2b4:	8b 45 08             	mov    0x8(%ebp),%eax
 2b7:	53                   	push   %ebx
 2b8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 2bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2be:	85 db                	test   %ebx,%ebx
 2c0:	7e 1a                	jle    2dc <memmove+0x2c>
 2c2:	31 d2                	xor    %edx,%edx
 2c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 2d0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2d4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2d7:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2d8:	39 da                	cmp    %ebx,%edx
 2da:	75 f4                	jne    2d0 <memmove+0x20>
    *dst++ = *src++;
  return vdst;
}
 2dc:	5b                   	pop    %ebx
 2dd:	5e                   	pop    %esi
 2de:	5d                   	pop    %ebp
 2df:	c3                   	ret    

000002e0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2e0:	b8 01 00 00 00       	mov    $0x1,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <exit>:
SYSCALL(exit)
 2e8:	b8 02 00 00 00       	mov    $0x2,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <wait>:
SYSCALL(wait)
 2f0:	b8 03 00 00 00       	mov    $0x3,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <pipe>:
SYSCALL(pipe)
 2f8:	b8 04 00 00 00       	mov    $0x4,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <read>:
SYSCALL(read)
 300:	b8 05 00 00 00       	mov    $0x5,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <write>:
SYSCALL(write)
 308:	b8 10 00 00 00       	mov    $0x10,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <close>:
SYSCALL(close)
 310:	b8 15 00 00 00       	mov    $0x15,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <kill>:
SYSCALL(kill)
 318:	b8 06 00 00 00       	mov    $0x6,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <exec>:
SYSCALL(exec)
 320:	b8 07 00 00 00       	mov    $0x7,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <open>:
SYSCALL(open)
 328:	b8 0f 00 00 00       	mov    $0xf,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <mknod>:
SYSCALL(mknod)
 330:	b8 11 00 00 00       	mov    $0x11,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <unlink>:
SYSCALL(unlink)
 338:	b8 12 00 00 00       	mov    $0x12,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <fstat>:
SYSCALL(fstat)
 340:	b8 08 00 00 00       	mov    $0x8,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <link>:
SYSCALL(link)
 348:	b8 13 00 00 00       	mov    $0x13,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <mkdir>:
SYSCALL(mkdir)
 350:	b8 14 00 00 00       	mov    $0x14,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <chdir>:
SYSCALL(chdir)
 358:	b8 09 00 00 00       	mov    $0x9,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <dup>:
SYSCALL(dup)
 360:	b8 0a 00 00 00       	mov    $0xa,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <getpid>:
SYSCALL(getpid)
 368:	b8 0b 00 00 00       	mov    $0xb,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <sbrk>:
SYSCALL(sbrk)
 370:	b8 0c 00 00 00       	mov    $0xc,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <sleep>:
SYSCALL(sleep)
 378:	b8 0d 00 00 00       	mov    $0xd,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <uptime>:
SYSCALL(uptime)
 380:	b8 0e 00 00 00       	mov    $0xe,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <policy>:
SYSCALL(policy)
 388:	b8 17 00 00 00       	mov    $0x17,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <detach>:
SYSCALL(detach)
 390:	b8 16 00 00 00       	mov    $0x16,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    
 398:	66 90                	xchg   %ax,%ax
 39a:	66 90                	xchg   %ax,%ax
 39c:	66 90                	xchg   %ax,%ax
 39e:	66 90                	xchg   %ax,%ax

000003a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	56                   	push   %esi
 3a5:	89 c6                	mov    %eax,%esi
 3a7:	53                   	push   %ebx
 3a8:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
 3ae:	85 db                	test   %ebx,%ebx
 3b0:	0f 84 8a 00 00 00    	je     440 <printint+0xa0>
 3b6:	89 d0                	mov    %edx,%eax
 3b8:	c1 e8 1f             	shr    $0x1f,%eax
 3bb:	84 c0                	test   %al,%al
 3bd:	0f 84 7d 00 00 00    	je     440 <printint+0xa0>
    neg = 1;
    x = -xx;
 3c3:	89 d0                	mov    %edx,%eax
 3c5:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 3c7:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 3ce:	89 75 c0             	mov    %esi,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 3d1:	31 ff                	xor    %edi,%edi
 3d3:	89 ce                	mov    %ecx,%esi
 3d5:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 3d8:	eb 08                	jmp    3e2 <printint+0x42>
 3da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 3e0:	89 cf                	mov    %ecx,%edi
 3e2:	31 d2                	xor    %edx,%edx
 3e4:	f7 f6                	div    %esi
 3e6:	8d 4f 01             	lea    0x1(%edi),%ecx
 3e9:	0f b6 92 c0 08 00 00 	movzbl 0x8c0(%edx),%edx
  }while((x /= base) != 0);
 3f0:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 3f2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 3f5:	75 e9                	jne    3e0 <printint+0x40>
  if(neg)
 3f7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 3fa:	8b 75 c0             	mov    -0x40(%ebp),%esi
 3fd:	85 d2                	test   %edx,%edx
 3ff:	74 08                	je     409 <printint+0x69>
    buf[i++] = '-';
 401:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 406:	8d 4f 02             	lea    0x2(%edi),%ecx
 409:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 40d:	8d 76 00             	lea    0x0(%esi),%esi
 410:	0f b6 07             	movzbl (%edi),%eax
 413:	4f                   	dec    %edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 414:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 418:	89 34 24             	mov    %esi,(%esp)
 41b:	88 45 d7             	mov    %al,-0x29(%ebp)
 41e:	b8 01 00 00 00       	mov    $0x1,%eax
 423:	89 44 24 08          	mov    %eax,0x8(%esp)
 427:	e8 dc fe ff ff       	call   308 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 42c:	39 df                	cmp    %ebx,%edi
 42e:	75 e0                	jne    410 <printint+0x70>
    putc(fd, buf[i]);
}
 430:	83 c4 4c             	add    $0x4c,%esp
 433:	5b                   	pop    %ebx
 434:	5e                   	pop    %esi
 435:	5f                   	pop    %edi
 436:	5d                   	pop    %ebp
 437:	c3                   	ret    
 438:	90                   	nop
 439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 440:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 442:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 449:	eb 83                	jmp    3ce <printint+0x2e>
 44b:	90                   	nop
 44c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000450 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	56                   	push   %esi
 455:	53                   	push   %ebx
 456:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 459:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 45c:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 45f:	0f b6 1e             	movzbl (%esi),%ebx
 462:	84 db                	test   %bl,%bl
 464:	0f 84 c6 00 00 00    	je     530 <printf+0xe0>
 46a:	8d 45 10             	lea    0x10(%ebp),%eax
 46d:	46                   	inc    %esi
 46e:	89 45 d0             	mov    %eax,-0x30(%ebp)
 471:	31 d2                	xor    %edx,%edx
 473:	eb 3b                	jmp    4b0 <printf+0x60>
 475:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 478:	83 f8 25             	cmp    $0x25,%eax
 47b:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 47e:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 483:	74 1e                	je     4a3 <printf+0x53>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 485:	b8 01 00 00 00       	mov    $0x1,%eax
 48a:	89 44 24 08          	mov    %eax,0x8(%esp)
 48e:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 491:	89 44 24 04          	mov    %eax,0x4(%esp)
 495:	89 3c 24             	mov    %edi,(%esp)
 498:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 49b:	e8 68 fe ff ff       	call   308 <write>
 4a0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 4a3:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4a4:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 4a8:	84 db                	test   %bl,%bl
 4aa:	0f 84 80 00 00 00    	je     530 <printf+0xe0>
    c = fmt[i] & 0xff;
    if(state == 0){
 4b0:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 4b2:	0f be cb             	movsbl %bl,%ecx
 4b5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 4b8:	74 be                	je     478 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4ba:	83 fa 25             	cmp    $0x25,%edx
 4bd:	75 e4                	jne    4a3 <printf+0x53>
      if(c == 'd'){
 4bf:	83 f8 64             	cmp    $0x64,%eax
 4c2:	0f 84 20 01 00 00    	je     5e8 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4c8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 4ce:	83 f9 70             	cmp    $0x70,%ecx
 4d1:	74 6d                	je     540 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4d3:	83 f8 73             	cmp    $0x73,%eax
 4d6:	0f 84 94 00 00 00    	je     570 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4dc:	83 f8 63             	cmp    $0x63,%eax
 4df:	0f 84 14 01 00 00    	je     5f9 <printf+0x1a9>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4e5:	83 f8 25             	cmp    $0x25,%eax
 4e8:	0f 84 d2 00 00 00    	je     5c0 <printf+0x170>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4ee:	b8 01 00 00 00       	mov    $0x1,%eax
 4f3:	46                   	inc    %esi
 4f4:	89 44 24 08          	mov    %eax,0x8(%esp)
 4f8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4fb:	89 44 24 04          	mov    %eax,0x4(%esp)
 4ff:	89 3c 24             	mov    %edi,(%esp)
 502:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 506:	e8 fd fd ff ff       	call   308 <write>
 50b:	ba 01 00 00 00       	mov    $0x1,%edx
 510:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 513:	89 54 24 08          	mov    %edx,0x8(%esp)
 517:	89 44 24 04          	mov    %eax,0x4(%esp)
 51b:	89 3c 24             	mov    %edi,(%esp)
 51e:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 521:	e8 e2 fd ff ff       	call   308 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 526:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 52a:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 52c:	84 db                	test   %bl,%bl
 52e:	75 80                	jne    4b0 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 530:	83 c4 3c             	add    $0x3c,%esp
 533:	5b                   	pop    %ebx
 534:	5e                   	pop    %esi
 535:	5f                   	pop    %edi
 536:	5d                   	pop    %ebp
 537:	c3                   	ret    
 538:	90                   	nop
 539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 540:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 547:	b9 10 00 00 00       	mov    $0x10,%ecx
 54c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 54f:	89 f8                	mov    %edi,%eax
 551:	8b 13                	mov    (%ebx),%edx
 553:	e8 48 fe ff ff       	call   3a0 <printint>
        ap++;
 558:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 55a:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 55c:	83 c0 04             	add    $0x4,%eax
 55f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 562:	e9 3c ff ff ff       	jmp    4a3 <printf+0x53>
 567:	89 f6                	mov    %esi,%esi
 569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      } else if(c == 's'){
        s = (char*)*ap;
 570:	8b 45 d0             	mov    -0x30(%ebp),%eax
 573:	8b 18                	mov    (%eax),%ebx
        ap++;
 575:	83 c0 04             	add    $0x4,%eax
 578:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 57b:	b8 b8 08 00 00       	mov    $0x8b8,%eax
 580:	85 db                	test   %ebx,%ebx
 582:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 585:	0f b6 03             	movzbl (%ebx),%eax
 588:	84 c0                	test   %al,%al
 58a:	74 27                	je     5b3 <printf+0x163>
 58c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 590:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 593:	b8 01 00 00 00       	mov    $0x1,%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 598:	43                   	inc    %ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 599:	89 44 24 08          	mov    %eax,0x8(%esp)
 59d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 5a0:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a4:	89 3c 24             	mov    %edi,(%esp)
 5a7:	e8 5c fd ff ff       	call   308 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5ac:	0f b6 03             	movzbl (%ebx),%eax
 5af:	84 c0                	test   %al,%al
 5b1:	75 dd                	jne    590 <printf+0x140>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5b3:	31 d2                	xor    %edx,%edx
 5b5:	e9 e9 fe ff ff       	jmp    4a3 <printf+0x53>
 5ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5c0:	b9 01 00 00 00       	mov    $0x1,%ecx
 5c5:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 5c8:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 5cc:	89 44 24 04          	mov    %eax,0x4(%esp)
 5d0:	89 3c 24             	mov    %edi,(%esp)
 5d3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 5d6:	e8 2d fd ff ff       	call   308 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5db:	31 d2                	xor    %edx,%edx
 5dd:	e9 c1 fe ff ff       	jmp    4a3 <printf+0x53>
 5e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 5e8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5ef:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5f4:	e9 53 ff ff ff       	jmp    54c <printf+0xfc>
 5f9:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5fc:	8b 03                	mov    (%ebx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5fe:	89 3c 24             	mov    %edi,(%esp)
 601:	88 45 e4             	mov    %al,-0x1c(%ebp)
 604:	b8 01 00 00 00       	mov    $0x1,%eax
 609:	89 44 24 08          	mov    %eax,0x8(%esp)
 60d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 610:	89 44 24 04          	mov    %eax,0x4(%esp)
 614:	e8 ef fc ff ff       	call   308 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 619:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 61b:	31 d2                	xor    %edx,%edx
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 61d:	83 c0 04             	add    $0x4,%eax
 620:	89 45 d0             	mov    %eax,-0x30(%ebp)
 623:	e9 7b fe ff ff       	jmp    4a3 <printf+0x53>
 628:	66 90                	xchg   %ax,%ax
 62a:	66 90                	xchg   %ax,%ax
 62c:	66 90                	xchg   %ax,%ax
 62e:	66 90                	xchg   %ax,%ax

00000630 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 630:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 631:	a1 50 0b 00 00       	mov    0xb50,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 636:	89 e5                	mov    %esp,%ebp
 638:	57                   	push   %edi
 639:	56                   	push   %esi
 63a:	53                   	push   %ebx
 63b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 63e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 640:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 643:	39 c8                	cmp    %ecx,%eax
 645:	73 19                	jae    660 <free+0x30>
 647:	89 f6                	mov    %esi,%esi
 649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 650:	39 d1                	cmp    %edx,%ecx
 652:	72 1c                	jb     670 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 654:	39 d0                	cmp    %edx,%eax
 656:	73 18                	jae    670 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 658:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 65a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 65c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 65e:	72 f0                	jb     650 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 660:	39 d0                	cmp    %edx,%eax
 662:	72 f4                	jb     658 <free+0x28>
 664:	39 d1                	cmp    %edx,%ecx
 666:	73 f0                	jae    658 <free+0x28>
 668:	90                   	nop
 669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 670:	8b 73 fc             	mov    -0x4(%ebx),%esi
 673:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 676:	39 d7                	cmp    %edx,%edi
 678:	74 19                	je     693 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 67a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 67d:	8b 50 04             	mov    0x4(%eax),%edx
 680:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 683:	39 f1                	cmp    %esi,%ecx
 685:	74 25                	je     6ac <free+0x7c>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 687:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 689:	5b                   	pop    %ebx
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 68a:	a3 50 0b 00 00       	mov    %eax,0xb50
}
 68f:	5e                   	pop    %esi
 690:	5f                   	pop    %edi
 691:	5d                   	pop    %ebp
 692:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 693:	8b 7a 04             	mov    0x4(%edx),%edi
 696:	01 fe                	add    %edi,%esi
 698:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 69b:	8b 10                	mov    (%eax),%edx
 69d:	8b 12                	mov    (%edx),%edx
 69f:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6a2:	8b 50 04             	mov    0x4(%eax),%edx
 6a5:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6a8:	39 f1                	cmp    %esi,%ecx
 6aa:	75 db                	jne    687 <free+0x57>
    p->s.size += bp->s.size;
 6ac:	8b 4b fc             	mov    -0x4(%ebx),%ecx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 6af:	a3 50 0b 00 00       	mov    %eax,0xb50
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6b4:	01 ca                	add    %ecx,%edx
 6b6:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6b9:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6bc:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 6be:	5b                   	pop    %ebx
 6bf:	5e                   	pop    %esi
 6c0:	5f                   	pop    %edi
 6c1:	5d                   	pop    %ebp
 6c2:	c3                   	ret    
 6c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6d0:	55                   	push   %ebp
 6d1:	89 e5                	mov    %esp,%ebp
 6d3:	57                   	push   %edi
 6d4:	56                   	push   %esi
 6d5:	53                   	push   %ebx
 6d6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6dc:	8b 15 50 0b 00 00    	mov    0xb50,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6e2:	8d 78 07             	lea    0x7(%eax),%edi
 6e5:	c1 ef 03             	shr    $0x3,%edi
 6e8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 6e9:	85 d2                	test   %edx,%edx
 6eb:	0f 84 95 00 00 00    	je     786 <malloc+0xb6>
 6f1:	8b 02                	mov    (%edx),%eax
 6f3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6f6:	39 cf                	cmp    %ecx,%edi
 6f8:	76 66                	jbe    760 <malloc+0x90>
 6fa:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 700:	be 00 10 00 00       	mov    $0x1000,%esi
 705:	0f 43 f7             	cmovae %edi,%esi
 708:	ba 00 80 00 00       	mov    $0x8000,%edx
 70d:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 714:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 71a:	0f 46 da             	cmovbe %edx,%ebx
 71d:	eb 0a                	jmp    729 <malloc+0x59>
 71f:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 720:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 722:	8b 48 04             	mov    0x4(%eax),%ecx
 725:	39 cf                	cmp    %ecx,%edi
 727:	76 37                	jbe    760 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 729:	39 05 50 0b 00 00    	cmp    %eax,0xb50
 72f:	89 c2                	mov    %eax,%edx
 731:	75 ed                	jne    720 <malloc+0x50>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 733:	89 1c 24             	mov    %ebx,(%esp)
 736:	e8 35 fc ff ff       	call   370 <sbrk>
  if(p == (char*)-1)
 73b:	83 f8 ff             	cmp    $0xffffffff,%eax
 73e:	74 18                	je     758 <malloc+0x88>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 740:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 743:	83 c0 08             	add    $0x8,%eax
 746:	89 04 24             	mov    %eax,(%esp)
 749:	e8 e2 fe ff ff       	call   630 <free>
  return freep;
 74e:	8b 15 50 0b 00 00    	mov    0xb50,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 754:	85 d2                	test   %edx,%edx
 756:	75 c8                	jne    720 <malloc+0x50>
        return 0;
 758:	31 c0                	xor    %eax,%eax
 75a:	eb 1c                	jmp    778 <malloc+0xa8>
 75c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 760:	39 cf                	cmp    %ecx,%edi
 762:	74 1c                	je     780 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 764:	29 f9                	sub    %edi,%ecx
 766:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 769:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 76c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 76f:	89 15 50 0b 00 00    	mov    %edx,0xb50
      return (void*)(p + 1);
 775:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 778:	83 c4 1c             	add    $0x1c,%esp
 77b:	5b                   	pop    %ebx
 77c:	5e                   	pop    %esi
 77d:	5f                   	pop    %edi
 77e:	5d                   	pop    %ebp
 77f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 780:	8b 08                	mov    (%eax),%ecx
 782:	89 0a                	mov    %ecx,(%edx)
 784:	eb e9                	jmp    76f <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 786:	b8 54 0b 00 00       	mov    $0xb54,%eax
 78b:	ba 54 0b 00 00       	mov    $0xb54,%edx
    base.s.size = 0;
 790:	31 c9                	xor    %ecx,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 792:	a3 50 0b 00 00       	mov    %eax,0xb50
    base.s.size = 0;
 797:	b8 54 0b 00 00       	mov    $0xb54,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 79c:	89 15 54 0b 00 00    	mov    %edx,0xb54
    base.s.size = 0;
 7a2:	89 0d 58 0b 00 00    	mov    %ecx,0xb58
 7a8:	e9 4d ff ff ff       	jmp    6fa <malloc+0x2a>
