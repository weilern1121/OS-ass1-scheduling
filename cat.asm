
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

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
  int fd, i;

  if(argc <= 1){
   c:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  10:	7e 6f                	jle    81 <main+0x81>
  12:	8b 45 0c             	mov    0xc(%ebp),%eax
  15:	be 01 00 00 00       	mov    $0x1,%esi
  1a:	8d 78 04             	lea    0x4(%eax),%edi
  1d:	8d 76 00             	lea    0x0(%esi),%esi
    cat(0);
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  20:	31 c0                	xor    %eax,%eax
  22:	89 44 24 04          	mov    %eax,0x4(%esp)
  26:	8b 07                	mov    (%edi),%eax
  28:	89 04 24             	mov    %eax,(%esp)
  2b:	e8 88 03 00 00       	call   3b8 <open>
  30:	85 c0                	test   %eax,%eax
  32:	89 c3                	mov    %eax,%ebx
  34:	78 25                	js     5b <main+0x5b>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit(0);
    }
    cat(fd);
  36:	89 04 24             	mov    %eax,(%esp)
  if(argc <= 1){
    cat(0);
    exit(0);
  }

  for(i = 1; i < argc; i++){
  39:	46                   	inc    %esi
  3a:	83 c7 04             	add    $0x4,%edi
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit(0);
    }
    cat(fd);
  3d:	e8 5e 00 00 00       	call   a0 <cat>
    close(fd);
  42:	89 1c 24             	mov    %ebx,(%esp)
  45:	e8 56 03 00 00       	call   3a0 <close>
  if(argc <= 1){
    cat(0);
    exit(0);
  }

  for(i = 1; i < argc; i++){
  4a:	39 75 08             	cmp    %esi,0x8(%ebp)
  4d:	75 d1                	jne    20 <main+0x20>
      exit(0);
    }
    cat(fd);
    close(fd);
  }
  exit(0);
  4f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  56:	e8 1d 03 00 00       	call   378 <exit>
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
  5b:	8b 07                	mov    (%edi),%eax
  5d:	c7 44 24 04 63 08 00 	movl   $0x863,0x4(%esp)
  64:	00 
  65:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  6c:	89 44 24 08          	mov    %eax,0x8(%esp)
  70:	e8 6b 04 00 00       	call   4e0 <printf>
      exit(0);
  75:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  7c:	e8 f7 02 00 00       	call   378 <exit>
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
    cat(0);
  81:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  88:	e8 13 00 00 00       	call   a0 <cat>
    exit(0);
  8d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  94:	e8 df 02 00 00       	call   378 <exit>
  99:	66 90                	xchg   %ax,%ax
  9b:	66 90                	xchg   %ax,%ax
  9d:	66 90                	xchg   %ax,%ax
  9f:	90                   	nop

000000a0 <cat>:

char buf[512];

void
cat(int fd)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	56                   	push   %esi
  a4:	53                   	push   %ebx
  a5:	83 ec 10             	sub    $0x10,%esp
  a8:	8b 75 08             	mov    0x8(%ebp),%esi
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  ab:	eb 20                	jmp    cd <cat+0x2d>
  ad:	8d 76 00             	lea    0x0(%esi),%esi
    if (write(1, buf, n) != n) {
  b0:	b8 60 0b 00 00       	mov    $0xb60,%eax
  b5:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  b9:	89 44 24 04          	mov    %eax,0x4(%esp)
  bd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c4:	e8 cf 02 00 00       	call   398 <write>
  c9:	39 c3                	cmp    %eax,%ebx
  cb:	75 2a                	jne    f7 <cat+0x57>
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  cd:	ba 00 02 00 00       	mov    $0x200,%edx
  d2:	b9 60 0b 00 00       	mov    $0xb60,%ecx
  d7:	89 54 24 08          	mov    %edx,0x8(%esp)
  db:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  df:	89 34 24             	mov    %esi,(%esp)
  e2:	e8 a9 02 00 00       	call   390 <read>
  e7:	83 f8 00             	cmp    $0x0,%eax
  ea:	89 c3                	mov    %eax,%ebx
  ec:	7f c2                	jg     b0 <cat+0x10>
    if (write(1, buf, n) != n) {
      printf(1, "cat: write error\n");
      exit(0);
    }
  }
  if(n < 0){
  ee:	75 28                	jne    118 <cat+0x78>
    printf(1, "cat: read error\n");
    exit(0);
  }
}
  f0:	83 c4 10             	add    $0x10,%esp
  f3:	5b                   	pop    %ebx
  f4:	5e                   	pop    %esi
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret    
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
    if (write(1, buf, n) != n) {
      printf(1, "cat: write error\n");
  f7:	bb 40 08 00 00       	mov    $0x840,%ebx
  fc:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 100:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 107:	e8 d4 03 00 00       	call   4e0 <printf>
      exit(0);
 10c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 113:	e8 60 02 00 00       	call   378 <exit>
    }
  }
  if(n < 0){
    printf(1, "cat: read error\n");
 118:	b8 52 08 00 00       	mov    $0x852,%eax
 11d:	89 44 24 04          	mov    %eax,0x4(%esp)
 121:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 128:	e8 b3 03 00 00       	call   4e0 <printf>
    exit(0);
 12d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 134:	e8 3f 02 00 00       	call   378 <exit>
 139:	66 90                	xchg   %ax,%ax
 13b:	66 90                	xchg   %ax,%ax
 13d:	66 90                	xchg   %ax,%ax
 13f:	90                   	nop

00000140 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	8b 45 08             	mov    0x8(%ebp),%eax
 146:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 149:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 14a:	89 c2                	mov    %eax,%edx
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 150:	41                   	inc    %ecx
 151:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 155:	42                   	inc    %edx
 156:	84 db                	test   %bl,%bl
 158:	88 5a ff             	mov    %bl,-0x1(%edx)
 15b:	75 f3                	jne    150 <strcpy+0x10>
    ;
  return os;
}
 15d:	5b                   	pop    %ebx
 15e:	5d                   	pop    %ebp
 15f:	c3                   	ret    

00000160 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	8b 4d 08             	mov    0x8(%ebp),%ecx
 166:	56                   	push   %esi
 167:	53                   	push   %ebx
 168:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 16b:	0f b6 01             	movzbl (%ecx),%eax
 16e:	0f b6 13             	movzbl (%ebx),%edx
 171:	84 c0                	test   %al,%al
 173:	75 1c                	jne    191 <strcmp+0x31>
 175:	eb 29                	jmp    1a0 <strcmp+0x40>
 177:	89 f6                	mov    %esi,%esi
 179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 180:	41                   	inc    %ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 181:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 184:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 187:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 18b:	84 c0                	test   %al,%al
 18d:	74 11                	je     1a0 <strcmp+0x40>
 18f:	89 f3                	mov    %esi,%ebx
 191:	38 d0                	cmp    %dl,%al
 193:	74 eb                	je     180 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 195:	5b                   	pop    %ebx
int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    p++, q++;
  return (uchar)*p - (uchar)*q;
 196:	29 d0                	sub    %edx,%eax
}
 198:	5e                   	pop    %esi
 199:	5d                   	pop    %ebp
 19a:	c3                   	ret    
 19b:	90                   	nop
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1a0:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1a1:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1a3:	29 d0                	sub    %edx,%eax
}
 1a5:	5e                   	pop    %esi
 1a6:	5d                   	pop    %ebp
 1a7:	c3                   	ret    
 1a8:	90                   	nop
 1a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001b0 <strlen>:

uint
strlen(const char *s)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1b6:	80 39 00             	cmpb   $0x0,(%ecx)
 1b9:	74 10                	je     1cb <strlen+0x1b>
 1bb:	31 d2                	xor    %edx,%edx
 1bd:	8d 76 00             	lea    0x0(%esi),%esi
 1c0:	42                   	inc    %edx
 1c1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1c5:	89 d0                	mov    %edx,%eax
 1c7:	75 f7                	jne    1c0 <strlen+0x10>
    ;
  return n;
}
 1c9:	5d                   	pop    %ebp
 1ca:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 1cb:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 1cd:	5d                   	pop    %ebp
 1ce:	c3                   	ret    
 1cf:	90                   	nop

000001d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	8b 55 08             	mov    0x8(%ebp),%edx
 1d6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1da:	8b 45 0c             	mov    0xc(%ebp),%eax
 1dd:	89 d7                	mov    %edx,%edi
 1df:	fc                   	cld    
 1e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1e2:	5f                   	pop    %edi
 1e3:	89 d0                	mov    %edx,%eax
 1e5:	5d                   	pop    %ebp
 1e6:	c3                   	ret    
 1e7:	89 f6                	mov    %esi,%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001f0 <strchr>:

char*
strchr(const char *s, char c)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1fa:	0f b6 10             	movzbl (%eax),%edx
 1fd:	84 d2                	test   %dl,%dl
 1ff:	74 1b                	je     21c <strchr+0x2c>
    if(*s == c)
 201:	38 d1                	cmp    %dl,%cl
 203:	75 0f                	jne    214 <strchr+0x24>
 205:	eb 17                	jmp    21e <strchr+0x2e>
 207:	89 f6                	mov    %esi,%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 210:	38 ca                	cmp    %cl,%dl
 212:	74 0a                	je     21e <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 214:	40                   	inc    %eax
 215:	0f b6 10             	movzbl (%eax),%edx
 218:	84 d2                	test   %dl,%dl
 21a:	75 f4                	jne    210 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 21c:	31 c0                	xor    %eax,%eax
}
 21e:	5d                   	pop    %ebp
 21f:	c3                   	ret    

00000220 <gets>:

char*
gets(char *buf, int max)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 225:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
 227:	53                   	push   %ebx
 228:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 22b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 22e:	eb 32                	jmp    262 <gets+0x42>
    cc = read(0, &c, 1);
 230:	b8 01 00 00 00       	mov    $0x1,%eax
 235:	89 44 24 08          	mov    %eax,0x8(%esp)
 239:	89 7c 24 04          	mov    %edi,0x4(%esp)
 23d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 244:	e8 47 01 00 00       	call   390 <read>
    if(cc < 1)
 249:	85 c0                	test   %eax,%eax
 24b:	7e 1d                	jle    26a <gets+0x4a>
      break;
    buf[i++] = c;
 24d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 251:	89 de                	mov    %ebx,%esi
 253:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 256:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 258:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 25c:	74 22                	je     280 <gets+0x60>
 25e:	3c 0d                	cmp    $0xd,%al
 260:	74 1e                	je     280 <gets+0x60>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 262:	8d 5e 01             	lea    0x1(%esi),%ebx
 265:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 268:	7c c6                	jl     230 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 26a:	8b 45 08             	mov    0x8(%ebp),%eax
 26d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 271:	83 c4 2c             	add    $0x2c,%esp
 274:	5b                   	pop    %ebx
 275:	5e                   	pop    %esi
 276:	5f                   	pop    %edi
 277:	5d                   	pop    %ebp
 278:	c3                   	ret    
 279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 280:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 283:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 285:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 289:	83 c4 2c             	add    $0x2c,%esp
 28c:	5b                   	pop    %ebx
 28d:	5e                   	pop    %esi
 28e:	5f                   	pop    %edi
 28f:	5d                   	pop    %ebp
 290:	c3                   	ret    
 291:	eb 0d                	jmp    2a0 <stat>
 293:	90                   	nop
 294:	90                   	nop
 295:	90                   	nop
 296:	90                   	nop
 297:	90                   	nop
 298:	90                   	nop
 299:	90                   	nop
 29a:	90                   	nop
 29b:	90                   	nop
 29c:	90                   	nop
 29d:	90                   	nop
 29e:	90                   	nop
 29f:	90                   	nop

000002a0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2a0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a1:	31 c0                	xor    %eax,%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 2a3:	89 e5                	mov    %esp,%ebp
 2a5:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a8:	89 44 24 04          	mov    %eax,0x4(%esp)
 2ac:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 2af:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 2b2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b5:	89 04 24             	mov    %eax,(%esp)
 2b8:	e8 fb 00 00 00       	call   3b8 <open>
  if(fd < 0)
 2bd:	85 c0                	test   %eax,%eax
 2bf:	78 2f                	js     2f0 <stat+0x50>
 2c1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 2c3:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c6:	89 1c 24             	mov    %ebx,(%esp)
 2c9:	89 44 24 04          	mov    %eax,0x4(%esp)
 2cd:	e8 fe 00 00 00       	call   3d0 <fstat>
  close(fd);
 2d2:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 2d5:	89 c6                	mov    %eax,%esi
  close(fd);
 2d7:	e8 c4 00 00 00       	call   3a0 <close>
  return r;
 2dc:	89 f0                	mov    %esi,%eax
}
 2de:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 2e1:	8b 75 fc             	mov    -0x4(%ebp),%esi
 2e4:	89 ec                	mov    %ebp,%esp
 2e6:	5d                   	pop    %ebp
 2e7:	c3                   	ret    
 2e8:	90                   	nop
 2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 2f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2f5:	eb e7                	jmp    2de <stat+0x3e>
 2f7:	89 f6                	mov    %esi,%esi
 2f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000300 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	8b 4d 08             	mov    0x8(%ebp),%ecx
 306:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 307:	0f be 11             	movsbl (%ecx),%edx
 30a:	88 d0                	mov    %dl,%al
 30c:	2c 30                	sub    $0x30,%al
 30e:	3c 09                	cmp    $0x9,%al
 310:	b8 00 00 00 00       	mov    $0x0,%eax
 315:	77 1e                	ja     335 <atoi+0x35>
 317:	89 f6                	mov    %esi,%esi
 319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 320:	41                   	inc    %ecx
 321:	8d 04 80             	lea    (%eax,%eax,4),%eax
 324:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 328:	0f be 11             	movsbl (%ecx),%edx
 32b:	88 d3                	mov    %dl,%bl
 32d:	80 eb 30             	sub    $0x30,%bl
 330:	80 fb 09             	cmp    $0x9,%bl
 333:	76 eb                	jbe    320 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 335:	5b                   	pop    %ebx
 336:	5d                   	pop    %ebp
 337:	c3                   	ret    
 338:	90                   	nop
 339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000340 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	56                   	push   %esi
 344:	8b 45 08             	mov    0x8(%ebp),%eax
 347:	53                   	push   %ebx
 348:	8b 5d 10             	mov    0x10(%ebp),%ebx
 34b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 34e:	85 db                	test   %ebx,%ebx
 350:	7e 1a                	jle    36c <memmove+0x2c>
 352:	31 d2                	xor    %edx,%edx
 354:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 35a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 360:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 364:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 367:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 368:	39 da                	cmp    %ebx,%edx
 36a:	75 f4                	jne    360 <memmove+0x20>
    *dst++ = *src++;
  return vdst;
}
 36c:	5b                   	pop    %ebx
 36d:	5e                   	pop    %esi
 36e:	5d                   	pop    %ebp
 36f:	c3                   	ret    

00000370 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 370:	b8 01 00 00 00       	mov    $0x1,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <exit>:
SYSCALL(exit)
 378:	b8 02 00 00 00       	mov    $0x2,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <wait>:
SYSCALL(wait)
 380:	b8 03 00 00 00       	mov    $0x3,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <pipe>:
SYSCALL(pipe)
 388:	b8 04 00 00 00       	mov    $0x4,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <read>:
SYSCALL(read)
 390:	b8 05 00 00 00       	mov    $0x5,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <write>:
SYSCALL(write)
 398:	b8 10 00 00 00       	mov    $0x10,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <close>:
SYSCALL(close)
 3a0:	b8 15 00 00 00       	mov    $0x15,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <kill>:
SYSCALL(kill)
 3a8:	b8 06 00 00 00       	mov    $0x6,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <exec>:
SYSCALL(exec)
 3b0:	b8 07 00 00 00       	mov    $0x7,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <open>:
SYSCALL(open)
 3b8:	b8 0f 00 00 00       	mov    $0xf,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <mknod>:
SYSCALL(mknod)
 3c0:	b8 11 00 00 00       	mov    $0x11,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <unlink>:
SYSCALL(unlink)
 3c8:	b8 12 00 00 00       	mov    $0x12,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <fstat>:
SYSCALL(fstat)
 3d0:	b8 08 00 00 00       	mov    $0x8,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <link>:
SYSCALL(link)
 3d8:	b8 13 00 00 00       	mov    $0x13,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <mkdir>:
SYSCALL(mkdir)
 3e0:	b8 14 00 00 00       	mov    $0x14,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <chdir>:
SYSCALL(chdir)
 3e8:	b8 09 00 00 00       	mov    $0x9,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <dup>:
SYSCALL(dup)
 3f0:	b8 0a 00 00 00       	mov    $0xa,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <getpid>:
SYSCALL(getpid)
 3f8:	b8 0b 00 00 00       	mov    $0xb,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <sbrk>:
SYSCALL(sbrk)
 400:	b8 0c 00 00 00       	mov    $0xc,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <sleep>:
SYSCALL(sleep)
 408:	b8 0d 00 00 00       	mov    $0xd,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <uptime>:
SYSCALL(uptime)
 410:	b8 0e 00 00 00       	mov    $0xe,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <policy>:
SYSCALL(policy)
 418:	b8 17 00 00 00       	mov    $0x17,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <detach>:
SYSCALL(detach)
 420:	b8 16 00 00 00       	mov    $0x16,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <priority>:
SYSCALL(priority)
 428:	b8 18 00 00 00       	mov    $0x18,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	57                   	push   %edi
 434:	56                   	push   %esi
 435:	89 c6                	mov    %eax,%esi
 437:	53                   	push   %ebx
 438:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 43b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 43e:	85 db                	test   %ebx,%ebx
 440:	0f 84 8a 00 00 00    	je     4d0 <printint+0xa0>
 446:	89 d0                	mov    %edx,%eax
 448:	c1 e8 1f             	shr    $0x1f,%eax
 44b:	84 c0                	test   %al,%al
 44d:	0f 84 7d 00 00 00    	je     4d0 <printint+0xa0>
    neg = 1;
    x = -xx;
 453:	89 d0                	mov    %edx,%eax
 455:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 457:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 45e:	89 75 c0             	mov    %esi,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 461:	31 ff                	xor    %edi,%edi
 463:	89 ce                	mov    %ecx,%esi
 465:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 468:	eb 08                	jmp    472 <printint+0x42>
 46a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 470:	89 cf                	mov    %ecx,%edi
 472:	31 d2                	xor    %edx,%edx
 474:	f7 f6                	div    %esi
 476:	8d 4f 01             	lea    0x1(%edi),%ecx
 479:	0f b6 92 80 08 00 00 	movzbl 0x880(%edx),%edx
  }while((x /= base) != 0);
 480:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 482:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 485:	75 e9                	jne    470 <printint+0x40>
  if(neg)
 487:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 48a:	8b 75 c0             	mov    -0x40(%ebp),%esi
 48d:	85 d2                	test   %edx,%edx
 48f:	74 08                	je     499 <printint+0x69>
    buf[i++] = '-';
 491:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 496:	8d 4f 02             	lea    0x2(%edi),%ecx
 499:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 49d:	8d 76 00             	lea    0x0(%esi),%esi
 4a0:	0f b6 07             	movzbl (%edi),%eax
 4a3:	4f                   	dec    %edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4a4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 4a8:	89 34 24             	mov    %esi,(%esp)
 4ab:	88 45 d7             	mov    %al,-0x29(%ebp)
 4ae:	b8 01 00 00 00       	mov    $0x1,%eax
 4b3:	89 44 24 08          	mov    %eax,0x8(%esp)
 4b7:	e8 dc fe ff ff       	call   398 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4bc:	39 df                	cmp    %ebx,%edi
 4be:	75 e0                	jne    4a0 <printint+0x70>
    putc(fd, buf[i]);
}
 4c0:	83 c4 4c             	add    $0x4c,%esp
 4c3:	5b                   	pop    %ebx
 4c4:	5e                   	pop    %esi
 4c5:	5f                   	pop    %edi
 4c6:	5d                   	pop    %ebp
 4c7:	c3                   	ret    
 4c8:	90                   	nop
 4c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4d0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4d2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 4d9:	eb 83                	jmp    45e <printint+0x2e>
 4db:	90                   	nop
 4dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004e0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	56                   	push   %esi
 4e5:	53                   	push   %ebx
 4e6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4e9:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4ec:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4ef:	0f b6 1e             	movzbl (%esi),%ebx
 4f2:	84 db                	test   %bl,%bl
 4f4:	0f 84 c6 00 00 00    	je     5c0 <printf+0xe0>
 4fa:	8d 45 10             	lea    0x10(%ebp),%eax
 4fd:	46                   	inc    %esi
 4fe:	89 45 d0             	mov    %eax,-0x30(%ebp)
 501:	31 d2                	xor    %edx,%edx
 503:	eb 3b                	jmp    540 <printf+0x60>
 505:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 508:	83 f8 25             	cmp    $0x25,%eax
 50b:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 50e:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 513:	74 1e                	je     533 <printf+0x53>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 515:	b8 01 00 00 00       	mov    $0x1,%eax
 51a:	89 44 24 08          	mov    %eax,0x8(%esp)
 51e:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 521:	89 44 24 04          	mov    %eax,0x4(%esp)
 525:	89 3c 24             	mov    %edi,(%esp)
 528:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 52b:	e8 68 fe ff ff       	call   398 <write>
 530:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 533:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 534:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 538:	84 db                	test   %bl,%bl
 53a:	0f 84 80 00 00 00    	je     5c0 <printf+0xe0>
    c = fmt[i] & 0xff;
    if(state == 0){
 540:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 542:	0f be cb             	movsbl %bl,%ecx
 545:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 548:	74 be                	je     508 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 54a:	83 fa 25             	cmp    $0x25,%edx
 54d:	75 e4                	jne    533 <printf+0x53>
      if(c == 'd'){
 54f:	83 f8 64             	cmp    $0x64,%eax
 552:	0f 84 20 01 00 00    	je     678 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 558:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 55e:	83 f9 70             	cmp    $0x70,%ecx
 561:	74 6d                	je     5d0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 563:	83 f8 73             	cmp    $0x73,%eax
 566:	0f 84 94 00 00 00    	je     600 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 56c:	83 f8 63             	cmp    $0x63,%eax
 56f:	0f 84 14 01 00 00    	je     689 <printf+0x1a9>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 575:	83 f8 25             	cmp    $0x25,%eax
 578:	0f 84 d2 00 00 00    	je     650 <printf+0x170>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 57e:	b8 01 00 00 00       	mov    $0x1,%eax
 583:	46                   	inc    %esi
 584:	89 44 24 08          	mov    %eax,0x8(%esp)
 588:	8d 45 e7             	lea    -0x19(%ebp),%eax
 58b:	89 44 24 04          	mov    %eax,0x4(%esp)
 58f:	89 3c 24             	mov    %edi,(%esp)
 592:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 596:	e8 fd fd ff ff       	call   398 <write>
 59b:	ba 01 00 00 00       	mov    $0x1,%edx
 5a0:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5a3:	89 54 24 08          	mov    %edx,0x8(%esp)
 5a7:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ab:	89 3c 24             	mov    %edi,(%esp)
 5ae:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 5b1:	e8 e2 fd ff ff       	call   398 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5b6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5ba:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5bc:	84 db                	test   %bl,%bl
 5be:	75 80                	jne    540 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5c0:	83 c4 3c             	add    $0x3c,%esp
 5c3:	5b                   	pop    %ebx
 5c4:	5e                   	pop    %esi
 5c5:	5f                   	pop    %edi
 5c6:	5d                   	pop    %ebp
 5c7:	c3                   	ret    
 5c8:	90                   	nop
 5c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5d0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 5d7:	b9 10 00 00 00       	mov    $0x10,%ecx
 5dc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5df:	89 f8                	mov    %edi,%eax
 5e1:	8b 13                	mov    (%ebx),%edx
 5e3:	e8 48 fe ff ff       	call   430 <printint>
        ap++;
 5e8:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5ea:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 5ec:	83 c0 04             	add    $0x4,%eax
 5ef:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5f2:	e9 3c ff ff ff       	jmp    533 <printf+0x53>
 5f7:	89 f6                	mov    %esi,%esi
 5f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      } else if(c == 's'){
        s = (char*)*ap;
 600:	8b 45 d0             	mov    -0x30(%ebp),%eax
 603:	8b 18                	mov    (%eax),%ebx
        ap++;
 605:	83 c0 04             	add    $0x4,%eax
 608:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 60b:	b8 78 08 00 00       	mov    $0x878,%eax
 610:	85 db                	test   %ebx,%ebx
 612:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 615:	0f b6 03             	movzbl (%ebx),%eax
 618:	84 c0                	test   %al,%al
 61a:	74 27                	je     643 <printf+0x163>
 61c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 620:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 623:	b8 01 00 00 00       	mov    $0x1,%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 628:	43                   	inc    %ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 629:	89 44 24 08          	mov    %eax,0x8(%esp)
 62d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 630:	89 44 24 04          	mov    %eax,0x4(%esp)
 634:	89 3c 24             	mov    %edi,(%esp)
 637:	e8 5c fd ff ff       	call   398 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 63c:	0f b6 03             	movzbl (%ebx),%eax
 63f:	84 c0                	test   %al,%al
 641:	75 dd                	jne    620 <printf+0x140>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 643:	31 d2                	xor    %edx,%edx
 645:	e9 e9 fe ff ff       	jmp    533 <printf+0x53>
 64a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 650:	b9 01 00 00 00       	mov    $0x1,%ecx
 655:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 658:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 65c:	89 44 24 04          	mov    %eax,0x4(%esp)
 660:	89 3c 24             	mov    %edi,(%esp)
 663:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 666:	e8 2d fd ff ff       	call   398 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 66b:	31 d2                	xor    %edx,%edx
 66d:	e9 c1 fe ff ff       	jmp    533 <printf+0x53>
 672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 678:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 67f:	b9 0a 00 00 00       	mov    $0xa,%ecx
 684:	e9 53 ff ff ff       	jmp    5dc <printf+0xfc>
 689:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 68c:	8b 03                	mov    (%ebx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 68e:	89 3c 24             	mov    %edi,(%esp)
 691:	88 45 e4             	mov    %al,-0x1c(%ebp)
 694:	b8 01 00 00 00       	mov    $0x1,%eax
 699:	89 44 24 08          	mov    %eax,0x8(%esp)
 69d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6a0:	89 44 24 04          	mov    %eax,0x4(%esp)
 6a4:	e8 ef fc ff ff       	call   398 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 6a9:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6ab:	31 d2                	xor    %edx,%edx
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 6ad:	83 c0 04             	add    $0x4,%eax
 6b0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 6b3:	e9 7b fe ff ff       	jmp    533 <printf+0x53>
 6b8:	66 90                	xchg   %ax,%ax
 6ba:	66 90                	xchg   %ax,%ax
 6bc:	66 90                	xchg   %ax,%ax
 6be:	66 90                	xchg   %ax,%ax

000006c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c1:	a1 40 0b 00 00       	mov    0xb40,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c6:	89 e5                	mov    %esp,%ebp
 6c8:	57                   	push   %edi
 6c9:	56                   	push   %esi
 6ca:	53                   	push   %ebx
 6cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ce:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6d0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d3:	39 c8                	cmp    %ecx,%eax
 6d5:	73 19                	jae    6f0 <free+0x30>
 6d7:	89 f6                	mov    %esi,%esi
 6d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 6e0:	39 d1                	cmp    %edx,%ecx
 6e2:	72 1c                	jb     700 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e4:	39 d0                	cmp    %edx,%eax
 6e6:	73 18                	jae    700 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 6e8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ea:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ec:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ee:	72 f0                	jb     6e0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f0:	39 d0                	cmp    %edx,%eax
 6f2:	72 f4                	jb     6e8 <free+0x28>
 6f4:	39 d1                	cmp    %edx,%ecx
 6f6:	73 f0                	jae    6e8 <free+0x28>
 6f8:	90                   	nop
 6f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 700:	8b 73 fc             	mov    -0x4(%ebx),%esi
 703:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 706:	39 d7                	cmp    %edx,%edi
 708:	74 19                	je     723 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 70a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 70d:	8b 50 04             	mov    0x4(%eax),%edx
 710:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 713:	39 f1                	cmp    %esi,%ecx
 715:	74 25                	je     73c <free+0x7c>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 717:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 719:	5b                   	pop    %ebx
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 71a:	a3 40 0b 00 00       	mov    %eax,0xb40
}
 71f:	5e                   	pop    %esi
 720:	5f                   	pop    %edi
 721:	5d                   	pop    %ebp
 722:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 723:	8b 7a 04             	mov    0x4(%edx),%edi
 726:	01 fe                	add    %edi,%esi
 728:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 72b:	8b 10                	mov    (%eax),%edx
 72d:	8b 12                	mov    (%edx),%edx
 72f:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 732:	8b 50 04             	mov    0x4(%eax),%edx
 735:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 738:	39 f1                	cmp    %esi,%ecx
 73a:	75 db                	jne    717 <free+0x57>
    p->s.size += bp->s.size;
 73c:	8b 4b fc             	mov    -0x4(%ebx),%ecx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 73f:	a3 40 0b 00 00       	mov    %eax,0xb40
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 744:	01 ca                	add    %ecx,%edx
 746:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 749:	8b 53 f8             	mov    -0x8(%ebx),%edx
 74c:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 74e:	5b                   	pop    %ebx
 74f:	5e                   	pop    %esi
 750:	5f                   	pop    %edi
 751:	5d                   	pop    %ebp
 752:	c3                   	ret    
 753:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000760 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	57                   	push   %edi
 764:	56                   	push   %esi
 765:	53                   	push   %ebx
 766:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 769:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 76c:	8b 15 40 0b 00 00    	mov    0xb40,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 772:	8d 78 07             	lea    0x7(%eax),%edi
 775:	c1 ef 03             	shr    $0x3,%edi
 778:	47                   	inc    %edi
  if((prevp = freep) == 0){
 779:	85 d2                	test   %edx,%edx
 77b:	0f 84 95 00 00 00    	je     816 <malloc+0xb6>
 781:	8b 02                	mov    (%edx),%eax
 783:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 786:	39 cf                	cmp    %ecx,%edi
 788:	76 66                	jbe    7f0 <malloc+0x90>
 78a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 790:	be 00 10 00 00       	mov    $0x1000,%esi
 795:	0f 43 f7             	cmovae %edi,%esi
 798:	ba 00 80 00 00       	mov    $0x8000,%edx
 79d:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 7a4:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 7aa:	0f 46 da             	cmovbe %edx,%ebx
 7ad:	eb 0a                	jmp    7b9 <malloc+0x59>
 7af:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7b0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7b2:	8b 48 04             	mov    0x4(%eax),%ecx
 7b5:	39 cf                	cmp    %ecx,%edi
 7b7:	76 37                	jbe    7f0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7b9:	39 05 40 0b 00 00    	cmp    %eax,0xb40
 7bf:	89 c2                	mov    %eax,%edx
 7c1:	75 ed                	jne    7b0 <malloc+0x50>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 7c3:	89 1c 24             	mov    %ebx,(%esp)
 7c6:	e8 35 fc ff ff       	call   400 <sbrk>
  if(p == (char*)-1)
 7cb:	83 f8 ff             	cmp    $0xffffffff,%eax
 7ce:	74 18                	je     7e8 <malloc+0x88>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 7d0:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 7d3:	83 c0 08             	add    $0x8,%eax
 7d6:	89 04 24             	mov    %eax,(%esp)
 7d9:	e8 e2 fe ff ff       	call   6c0 <free>
  return freep;
 7de:	8b 15 40 0b 00 00    	mov    0xb40,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 7e4:	85 d2                	test   %edx,%edx
 7e6:	75 c8                	jne    7b0 <malloc+0x50>
        return 0;
 7e8:	31 c0                	xor    %eax,%eax
 7ea:	eb 1c                	jmp    808 <malloc+0xa8>
 7ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 7f0:	39 cf                	cmp    %ecx,%edi
 7f2:	74 1c                	je     810 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 7f4:	29 f9                	sub    %edi,%ecx
 7f6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7f9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7fc:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 7ff:	89 15 40 0b 00 00    	mov    %edx,0xb40
      return (void*)(p + 1);
 805:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 808:	83 c4 1c             	add    $0x1c,%esp
 80b:	5b                   	pop    %ebx
 80c:	5e                   	pop    %esi
 80d:	5f                   	pop    %edi
 80e:	5d                   	pop    %ebp
 80f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 810:	8b 08                	mov    (%eax),%ecx
 812:	89 0a                	mov    %ecx,(%edx)
 814:	eb e9                	jmp    7ff <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 816:	b8 44 0b 00 00       	mov    $0xb44,%eax
 81b:	ba 44 0b 00 00       	mov    $0xb44,%edx
    base.s.size = 0;
 820:	31 c9                	xor    %ecx,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 822:	a3 40 0b 00 00       	mov    %eax,0xb40
    base.s.size = 0;
 827:	b8 44 0b 00 00       	mov    $0xb44,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 82c:	89 15 44 0b 00 00    	mov    %edx,0xb44
    base.s.size = 0;
 832:	89 0d 48 0b 00 00    	mov    %ecx,0xb48
 838:	e9 4d ff ff ff       	jmp    78a <malloc+0x2a>
