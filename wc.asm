
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
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
   9:	83 ec 20             	sub    $0x20,%esp
   c:	8b 7d 08             	mov    0x8(%ebp),%edi
  int fd, i;

  if(argc <= 1){
   f:	83 ff 01             	cmp    $0x1,%edi
  12:	7e 78                	jle    8c <main+0x8c>
  14:	8b 45 0c             	mov    0xc(%ebp),%eax
  17:	be 01 00 00 00       	mov    $0x1,%esi
  1c:	8d 58 04             	lea    0x4(%eax),%ebx
  1f:	90                   	nop
    wc(0, "");
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  20:	31 c0                	xor    %eax,%eax
  22:	89 44 24 04          	mov    %eax,0x4(%esp)
  26:	8b 03                	mov    (%ebx),%eax
  28:	89 04 24             	mov    %eax,(%esp)
  2b:	e8 08 04 00 00       	call   438 <open>
  30:	85 c0                	test   %eax,%eax
  32:	78 32                	js     66 <main+0x66>
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit(0);
    }
    wc(fd, argv[i]);
  34:	8b 13                	mov    (%ebx),%edx
  if(argc <= 1){
    wc(0, "");
    exit(0);
  }

  for(i = 1; i < argc; i++){
  36:	46                   	inc    %esi
  37:	83 c3 04             	add    $0x4,%ebx
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit(0);
    }
    wc(fd, argv[i]);
  3a:	89 04 24             	mov    %eax,(%esp)
  3d:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  41:	89 54 24 04          	mov    %edx,0x4(%esp)
  45:	e8 66 00 00 00       	call   b0 <wc>
    close(fd);
  4a:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  4e:	89 04 24             	mov    %eax,(%esp)
  51:	e8 ca 03 00 00       	call   420 <close>
  if(argc <= 1){
    wc(0, "");
    exit(0);
  }

  for(i = 1; i < argc; i++){
  56:	39 f7                	cmp    %esi,%edi
  58:	75 c6                	jne    20 <main+0x20>
      exit(0);
    }
    wc(fd, argv[i]);
    close(fd);
  }
  exit(0);
  5a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  61:	e8 92 03 00 00       	call   3f8 <exit>
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "wc: cannot open %s\n", argv[i]);
  66:	8b 03                	mov    (%ebx),%eax
  68:	c7 44 24 04 e3 08 00 	movl   $0x8e3,0x4(%esp)
  6f:	00 
  70:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  77:	89 44 24 08          	mov    %eax,0x8(%esp)
  7b:	e8 e0 04 00 00       	call   560 <printf>
      exit(0);
  80:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  87:	e8 6c 03 00 00       	call   3f8 <exit>
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
    wc(0, "");
  8c:	c7 44 24 04 d5 08 00 	movl   $0x8d5,0x4(%esp)
  93:	00 
  94:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  9b:	e8 10 00 00 00       	call   b0 <wc>
    exit(0);
  a0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  a7:	e8 4c 03 00 00       	call   3f8 <exit>
  ac:	66 90                	xchg   %ax,%ax
  ae:	66 90                	xchg   %ax,%ax

000000b0 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	57                   	push   %edi
  b4:	56                   	push   %esi
  b5:	53                   	push   %ebx
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  b6:	31 db                	xor    %ebx,%ebx

char buf[512];

void
wc(int fd, char *name)
{
  b8:	83 ec 3c             	sub    $0x3c,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  bb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
wc(int fd, char *name)
{
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  c2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  c9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
  d0:	8b 45 08             	mov    0x8(%ebp),%eax
  d3:	b9 00 02 00 00       	mov    $0x200,%ecx
  d8:	be e0 0b 00 00       	mov    $0xbe0,%esi
  dd:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  e1:	89 74 24 04          	mov    %esi,0x4(%esp)
  e5:	89 04 24             	mov    %eax,(%esp)
  e8:	e8 23 03 00 00       	call   410 <read>
  ed:	83 f8 00             	cmp    $0x0,%eax
  f0:	89 c7                	mov    %eax,%edi
  f2:	7e 65                	jle    159 <wc+0xa9>
  f4:	31 f6                	xor    %esi,%esi
  f6:	eb 14                	jmp    10c <wc+0x5c>
  f8:	90                   	nop
  f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
        inword = 0;
 100:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
 107:	46                   	inc    %esi
 108:	39 f7                	cmp    %esi,%edi
 10a:	74 3a                	je     146 <wc+0x96>
      c++;
      if(buf[i] == '\n')
 10c:	0f be 86 e0 0b 00 00 	movsbl 0xbe0(%esi),%eax
        l++;
 113:	31 c9                	xor    %ecx,%ecx
      if(strchr(" \r\t\n\v", buf[i]))
 115:	c7 04 24 c0 08 00 00 	movl   $0x8c0,(%esp)
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
        l++;
 11c:	3c 0a                	cmp    $0xa,%al
 11e:	0f 94 c1             	sete   %cl
      if(strchr(" \r\t\n\v", buf[i]))
 121:	89 44 24 04          	mov    %eax,0x4(%esp)
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
        l++;
 125:	01 cb                	add    %ecx,%ebx
      if(strchr(" \r\t\n\v", buf[i]))
 127:	e8 44 01 00 00       	call   270 <strchr>
 12c:	85 c0                	test   %eax,%eax
 12e:	75 d0                	jne    100 <wc+0x50>
        inword = 0;
      else if(!inword){
 130:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 133:	85 c0                	test   %eax,%eax
 135:	75 19                	jne    150 <wc+0xa0>
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
 137:	46                   	inc    %esi
      if(buf[i] == '\n')
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
        inword = 0;
      else if(!inword){
        w++;
 138:	ff 45 e0             	incl   -0x20(%ebp)
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
 13b:	39 f7                	cmp    %esi,%edi
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
        inword = 0;
      else if(!inword){
        w++;
        inword = 1;
 13d:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
 144:	75 c6                	jne    10c <wc+0x5c>
 146:	01 7d dc             	add    %edi,-0x24(%ebp)
 149:	eb 85                	jmp    d0 <wc+0x20>
 14b:	90                   	nop
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 150:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
 157:	eb ae                	jmp    107 <wc+0x57>
        w++;
        inword = 1;
      }
    }
  }
  if(n < 0){
 159:	75 36                	jne    191 <wc+0xe1>
    printf(1, "wc: read error\n");
    exit(0);
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
 15b:	8b 45 0c             	mov    0xc(%ebp),%eax
 15e:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 162:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 169:	89 44 24 14          	mov    %eax,0x14(%esp)
 16d:	8b 45 dc             	mov    -0x24(%ebp),%eax
 170:	89 44 24 10          	mov    %eax,0x10(%esp)
 174:	8b 45 e0             	mov    -0x20(%ebp),%eax
 177:	89 44 24 0c          	mov    %eax,0xc(%esp)
 17b:	b8 d6 08 00 00       	mov    $0x8d6,%eax
 180:	89 44 24 04          	mov    %eax,0x4(%esp)
 184:	e8 d7 03 00 00       	call   560 <printf>
}
 189:	83 c4 3c             	add    $0x3c,%esp
 18c:	5b                   	pop    %ebx
 18d:	5e                   	pop    %esi
 18e:	5f                   	pop    %edi
 18f:	5d                   	pop    %ebp
 190:	c3                   	ret    
        inword = 1;
      }
    }
  }
  if(n < 0){
    printf(1, "wc: read error\n");
 191:	ba c6 08 00 00       	mov    $0x8c6,%edx
 196:	89 54 24 04          	mov    %edx,0x4(%esp)
 19a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1a1:	e8 ba 03 00 00       	call   560 <printf>
    exit(0);
 1a6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1ad:	e8 46 02 00 00       	call   3f8 <exit>
 1b2:	66 90                	xchg   %ax,%ax
 1b4:	66 90                	xchg   %ax,%ax
 1b6:	66 90                	xchg   %ax,%ax
 1b8:	66 90                	xchg   %ax,%ax
 1ba:	66 90                	xchg   %ax,%ax
 1bc:	66 90                	xchg   %ax,%ax
 1be:	66 90                	xchg   %ax,%ax

000001c0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 45 08             	mov    0x8(%ebp),%eax
 1c6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1c9:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1ca:	89 c2                	mov    %eax,%edx
 1cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1d0:	41                   	inc    %ecx
 1d1:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 1d5:	42                   	inc    %edx
 1d6:	84 db                	test   %bl,%bl
 1d8:	88 5a ff             	mov    %bl,-0x1(%edx)
 1db:	75 f3                	jne    1d0 <strcpy+0x10>
    ;
  return os;
}
 1dd:	5b                   	pop    %ebx
 1de:	5d                   	pop    %ebp
 1df:	c3                   	ret    

000001e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1e6:	56                   	push   %esi
 1e7:	53                   	push   %ebx
 1e8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 1eb:	0f b6 01             	movzbl (%ecx),%eax
 1ee:	0f b6 13             	movzbl (%ebx),%edx
 1f1:	84 c0                	test   %al,%al
 1f3:	75 1c                	jne    211 <strcmp+0x31>
 1f5:	eb 29                	jmp    220 <strcmp+0x40>
 1f7:	89 f6                	mov    %esi,%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 200:	41                   	inc    %ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 201:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 204:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 207:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 20b:	84 c0                	test   %al,%al
 20d:	74 11                	je     220 <strcmp+0x40>
 20f:	89 f3                	mov    %esi,%ebx
 211:	38 d0                	cmp    %dl,%al
 213:	74 eb                	je     200 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 215:	5b                   	pop    %ebx
int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    p++, q++;
  return (uchar)*p - (uchar)*q;
 216:	29 d0                	sub    %edx,%eax
}
 218:	5e                   	pop    %esi
 219:	5d                   	pop    %ebp
 21a:	c3                   	ret    
 21b:	90                   	nop
 21c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 220:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 221:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 223:	29 d0                	sub    %edx,%eax
}
 225:	5e                   	pop    %esi
 226:	5d                   	pop    %ebp
 227:	c3                   	ret    
 228:	90                   	nop
 229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

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
 239:	74 10                	je     24b <strlen+0x1b>
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
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 24b:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 24d:	5d                   	pop    %ebp
 24e:	c3                   	ret    
 24f:	90                   	nop

00000250 <memset>:

void*
memset(void *dst, int c, uint n)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	8b 55 08             	mov    0x8(%ebp),%edx
 256:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 257:	8b 4d 10             	mov    0x10(%ebp),%ecx
 25a:	8b 45 0c             	mov    0xc(%ebp),%eax
 25d:	89 d7                	mov    %edx,%edi
 25f:	fc                   	cld    
 260:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 262:	5f                   	pop    %edi
 263:	89 d0                	mov    %edx,%eax
 265:	5d                   	pop    %ebp
 266:	c3                   	ret    
 267:	89 f6                	mov    %esi,%esi
 269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000270 <strchr>:

char*
strchr(const char *s, char c)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 27a:	0f b6 10             	movzbl (%eax),%edx
 27d:	84 d2                	test   %dl,%dl
 27f:	74 1b                	je     29c <strchr+0x2c>
    if(*s == c)
 281:	38 d1                	cmp    %dl,%cl
 283:	75 0f                	jne    294 <strchr+0x24>
 285:	eb 17                	jmp    29e <strchr+0x2e>
 287:	89 f6                	mov    %esi,%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 290:	38 ca                	cmp    %cl,%dl
 292:	74 0a                	je     29e <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 294:	40                   	inc    %eax
 295:	0f b6 10             	movzbl (%eax),%edx
 298:	84 d2                	test   %dl,%dl
 29a:	75 f4                	jne    290 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 29c:	31 c0                	xor    %eax,%eax
}
 29e:	5d                   	pop    %ebp
 29f:	c3                   	ret    

000002a0 <gets>:

char*
gets(char *buf, int max)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	57                   	push   %edi
 2a4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2a5:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
 2a7:	53                   	push   %ebx
 2a8:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 2ab:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2ae:	eb 32                	jmp    2e2 <gets+0x42>
    cc = read(0, &c, 1);
 2b0:	b8 01 00 00 00       	mov    $0x1,%eax
 2b5:	89 44 24 08          	mov    %eax,0x8(%esp)
 2b9:	89 7c 24 04          	mov    %edi,0x4(%esp)
 2bd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2c4:	e8 47 01 00 00       	call   410 <read>
    if(cc < 1)
 2c9:	85 c0                	test   %eax,%eax
 2cb:	7e 1d                	jle    2ea <gets+0x4a>
      break;
    buf[i++] = c;
 2cd:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2d1:	89 de                	mov    %ebx,%esi
 2d3:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 2d6:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 2d8:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 2dc:	74 22                	je     300 <gets+0x60>
 2de:	3c 0d                	cmp    $0xd,%al
 2e0:	74 1e                	je     300 <gets+0x60>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2e2:	8d 5e 01             	lea    0x1(%esi),%ebx
 2e5:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2e8:	7c c6                	jl     2b0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2ea:	8b 45 08             	mov    0x8(%ebp),%eax
 2ed:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2f1:	83 c4 2c             	add    $0x2c,%esp
 2f4:	5b                   	pop    %ebx
 2f5:	5e                   	pop    %esi
 2f6:	5f                   	pop    %edi
 2f7:	5d                   	pop    %ebp
 2f8:	c3                   	ret    
 2f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 300:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 303:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 305:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 309:	83 c4 2c             	add    $0x2c,%esp
 30c:	5b                   	pop    %ebx
 30d:	5e                   	pop    %esi
 30e:	5f                   	pop    %edi
 30f:	5d                   	pop    %ebp
 310:	c3                   	ret    
 311:	eb 0d                	jmp    320 <stat>
 313:	90                   	nop
 314:	90                   	nop
 315:	90                   	nop
 316:	90                   	nop
 317:	90                   	nop
 318:	90                   	nop
 319:	90                   	nop
 31a:	90                   	nop
 31b:	90                   	nop
 31c:	90                   	nop
 31d:	90                   	nop
 31e:	90                   	nop
 31f:	90                   	nop

00000320 <stat>:

int
stat(const char *n, struct stat *st)
{
 320:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 321:	31 c0                	xor    %eax,%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 323:	89 e5                	mov    %esp,%ebp
 325:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 328:	89 44 24 04          	mov    %eax,0x4(%esp)
 32c:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 32f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 332:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

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
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 355:	89 c6                	mov    %eax,%esi
  close(fd);
 357:	e8 c4 00 00 00       	call   420 <close>
  return r;
 35c:	89 f0                	mov    %esi,%eax
}
 35e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 361:	8b 75 fc             	mov    -0x4(%ebp),%esi
 364:	89 ec                	mov    %ebp,%esp
 366:	5d                   	pop    %ebp
 367:	c3                   	ret    
 368:	90                   	nop
 369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 370:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 375:	eb e7                	jmp    35e <stat+0x3e>
 377:	89 f6                	mov    %esi,%esi
 379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000380 <atoi>:
  return r;
}

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
 390:	b8 00 00 00 00       	mov    $0x0,%eax
 395:	77 1e                	ja     3b5 <atoi+0x35>
 397:	89 f6                	mov    %esi,%esi
 399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 3a0:	41                   	inc    %ecx
 3a1:	8d 04 80             	lea    (%eax,%eax,4),%eax
 3a4:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3a8:	0f be 11             	movsbl (%ecx),%edx
 3ab:	88 d3                	mov    %dl,%bl
 3ad:	80 eb 30             	sub    $0x30,%bl
 3b0:	80 fb 09             	cmp    $0x9,%bl
 3b3:	76 eb                	jbe    3a0 <atoi+0x20>
    n = n*10 + *s++ - '0';
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
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3e8:	39 da                	cmp    %ebx,%edx
 3ea:	75 f4                	jne    3e0 <memmove+0x20>
    *dst++ = *src++;
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

000004b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	57                   	push   %edi
 4b4:	56                   	push   %esi
 4b5:	89 c6                	mov    %eax,%esi
 4b7:	53                   	push   %ebx
 4b8:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 4be:	85 db                	test   %ebx,%ebx
 4c0:	0f 84 8a 00 00 00    	je     550 <printint+0xa0>
 4c6:	89 d0                	mov    %edx,%eax
 4c8:	c1 e8 1f             	shr    $0x1f,%eax
 4cb:	84 c0                	test   %al,%al
 4cd:	0f 84 7d 00 00 00    	je     550 <printint+0xa0>
    neg = 1;
    x = -xx;
 4d3:	89 d0                	mov    %edx,%eax
 4d5:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 4d7:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 4de:	89 75 c0             	mov    %esi,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 4e1:	31 ff                	xor    %edi,%edi
 4e3:	89 ce                	mov    %ecx,%esi
 4e5:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 4e8:	eb 08                	jmp    4f2 <printint+0x42>
 4ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4f0:	89 cf                	mov    %ecx,%edi
 4f2:	31 d2                	xor    %edx,%edx
 4f4:	f7 f6                	div    %esi
 4f6:	8d 4f 01             	lea    0x1(%edi),%ecx
 4f9:	0f b6 92 00 09 00 00 	movzbl 0x900(%edx),%edx
  }while((x /= base) != 0);
 500:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 502:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 505:	75 e9                	jne    4f0 <printint+0x40>
  if(neg)
 507:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 50a:	8b 75 c0             	mov    -0x40(%ebp),%esi
 50d:	85 d2                	test   %edx,%edx
 50f:	74 08                	je     519 <printint+0x69>
    buf[i++] = '-';
 511:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 516:	8d 4f 02             	lea    0x2(%edi),%ecx
 519:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 51d:	8d 76 00             	lea    0x0(%esi),%esi
 520:	0f b6 07             	movzbl (%edi),%eax
 523:	4f                   	dec    %edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 524:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 528:	89 34 24             	mov    %esi,(%esp)
 52b:	88 45 d7             	mov    %al,-0x29(%ebp)
 52e:	b8 01 00 00 00       	mov    $0x1,%eax
 533:	89 44 24 08          	mov    %eax,0x8(%esp)
 537:	e8 dc fe ff ff       	call   418 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 53c:	39 df                	cmp    %ebx,%edi
 53e:	75 e0                	jne    520 <printint+0x70>
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
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 550:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 552:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 559:	eb 83                	jmp    4de <printint+0x2e>
 55b:	90                   	nop
 55c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000560 <printf>:
}

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
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 56c:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 56f:	0f b6 1e             	movzbl (%esi),%ebx
 572:	84 db                	test   %bl,%bl
 574:	0f 84 c6 00 00 00    	je     640 <printf+0xe0>
 57a:	8d 45 10             	lea    0x10(%ebp),%eax
 57d:	46                   	inc    %esi
 57e:	89 45 d0             	mov    %eax,-0x30(%ebp)
 581:	31 d2                	xor    %edx,%edx
 583:	eb 3b                	jmp    5c0 <printf+0x60>
 585:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 588:	83 f8 25             	cmp    $0x25,%eax
 58b:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 58e:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 593:	74 1e                	je     5b3 <printf+0x53>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 595:	b8 01 00 00 00       	mov    $0x1,%eax
 59a:	89 44 24 08          	mov    %eax,0x8(%esp)
 59e:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 5a1:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a5:	89 3c 24             	mov    %edi,(%esp)
 5a8:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 5ab:	e8 68 fe ff ff       	call   418 <write>
 5b0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 5b3:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5b4:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 5b8:	84 db                	test   %bl,%bl
 5ba:	0f 84 80 00 00 00    	je     640 <printf+0xe0>
    c = fmt[i] & 0xff;
    if(state == 0){
 5c0:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 5c2:	0f be cb             	movsbl %bl,%ecx
 5c5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 5c8:	74 be                	je     588 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5ca:	83 fa 25             	cmp    $0x25,%edx
 5cd:	75 e4                	jne    5b3 <printf+0x53>
      if(c == 'd'){
 5cf:	83 f8 64             	cmp    $0x64,%eax
 5d2:	0f 84 20 01 00 00    	je     6f8 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5d8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 5de:	83 f9 70             	cmp    $0x70,%ecx
 5e1:	74 6d                	je     650 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5e3:	83 f8 73             	cmp    $0x73,%eax
 5e6:	0f 84 94 00 00 00    	je     680 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5ec:	83 f8 63             	cmp    $0x63,%eax
 5ef:	0f 84 14 01 00 00    	je     709 <printf+0x1a9>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5f5:	83 f8 25             	cmp    $0x25,%eax
 5f8:	0f 84 d2 00 00 00    	je     6d0 <printf+0x170>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5fe:	b8 01 00 00 00       	mov    $0x1,%eax
 603:	46                   	inc    %esi
 604:	89 44 24 08          	mov    %eax,0x8(%esp)
 608:	8d 45 e7             	lea    -0x19(%ebp),%eax
 60b:	89 44 24 04          	mov    %eax,0x4(%esp)
 60f:	89 3c 24             	mov    %edi,(%esp)
 612:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 616:	e8 fd fd ff ff       	call   418 <write>
 61b:	ba 01 00 00 00       	mov    $0x1,%edx
 620:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 623:	89 54 24 08          	mov    %edx,0x8(%esp)
 627:	89 44 24 04          	mov    %eax,0x4(%esp)
 62b:	89 3c 24             	mov    %edi,(%esp)
 62e:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 631:	e8 e2 fd ff ff       	call   418 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 636:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 63a:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 63c:	84 db                	test   %bl,%bl
 63e:	75 80                	jne    5c0 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 640:	83 c4 3c             	add    $0x3c,%esp
 643:	5b                   	pop    %ebx
 644:	5e                   	pop    %esi
 645:	5f                   	pop    %edi
 646:	5d                   	pop    %ebp
 647:	c3                   	ret    
 648:	90                   	nop
 649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 650:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 657:	b9 10 00 00 00       	mov    $0x10,%ecx
 65c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 65f:	89 f8                	mov    %edi,%eax
 661:	8b 13                	mov    (%ebx),%edx
 663:	e8 48 fe ff ff       	call   4b0 <printint>
        ap++;
 668:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 66a:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 66c:	83 c0 04             	add    $0x4,%eax
 66f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 672:	e9 3c ff ff ff       	jmp    5b3 <printf+0x53>
 677:	89 f6                	mov    %esi,%esi
 679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      } else if(c == 's'){
        s = (char*)*ap;
 680:	8b 45 d0             	mov    -0x30(%ebp),%eax
 683:	8b 18                	mov    (%eax),%ebx
        ap++;
 685:	83 c0 04             	add    $0x4,%eax
 688:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 68b:	b8 f7 08 00 00       	mov    $0x8f7,%eax
 690:	85 db                	test   %ebx,%ebx
 692:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 695:	0f b6 03             	movzbl (%ebx),%eax
 698:	84 c0                	test   %al,%al
 69a:	74 27                	je     6c3 <printf+0x163>
 69c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6a0:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6a3:	b8 01 00 00 00       	mov    $0x1,%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 6a8:	43                   	inc    %ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6a9:	89 44 24 08          	mov    %eax,0x8(%esp)
 6ad:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 6b0:	89 44 24 04          	mov    %eax,0x4(%esp)
 6b4:	89 3c 24             	mov    %edi,(%esp)
 6b7:	e8 5c fd ff ff       	call   418 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6bc:	0f b6 03             	movzbl (%ebx),%eax
 6bf:	84 c0                	test   %al,%al
 6c1:	75 dd                	jne    6a0 <printf+0x140>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6c3:	31 d2                	xor    %edx,%edx
 6c5:	e9 e9 fe ff ff       	jmp    5b3 <printf+0x53>
 6ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6d0:	b9 01 00 00 00       	mov    $0x1,%ecx
 6d5:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 6d8:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 6dc:	89 44 24 04          	mov    %eax,0x4(%esp)
 6e0:	89 3c 24             	mov    %edi,(%esp)
 6e3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 6e6:	e8 2d fd ff ff       	call   418 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6eb:	31 d2                	xor    %edx,%edx
 6ed:	e9 c1 fe ff ff       	jmp    5b3 <printf+0x53>
 6f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 6f8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 6ff:	b9 0a 00 00 00       	mov    $0xa,%ecx
 704:	e9 53 ff ff ff       	jmp    65c <printf+0xfc>
 709:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 70c:	8b 03                	mov    (%ebx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 70e:	89 3c 24             	mov    %edi,(%esp)
 711:	88 45 e4             	mov    %al,-0x1c(%ebp)
 714:	b8 01 00 00 00       	mov    $0x1,%eax
 719:	89 44 24 08          	mov    %eax,0x8(%esp)
 71d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 720:	89 44 24 04          	mov    %eax,0x4(%esp)
 724:	e8 ef fc ff ff       	call   418 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 729:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 72b:	31 d2                	xor    %edx,%edx
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 72d:	83 c0 04             	add    $0x4,%eax
 730:	89 45 d0             	mov    %eax,-0x30(%ebp)
 733:	e9 7b fe ff ff       	jmp    5b3 <printf+0x53>
 738:	66 90                	xchg   %ax,%ax
 73a:	66 90                	xchg   %ax,%ax
 73c:	66 90                	xchg   %ax,%ax
 73e:	66 90                	xchg   %ax,%ax

00000740 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 740:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 741:	a1 c0 0b 00 00       	mov    0xbc0,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 746:	89 e5                	mov    %esp,%ebp
 748:	57                   	push   %edi
 749:	56                   	push   %esi
 74a:	53                   	push   %ebx
 74b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 74e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 750:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 753:	39 c8                	cmp    %ecx,%eax
 755:	73 19                	jae    770 <free+0x30>
 757:	89 f6                	mov    %esi,%esi
 759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 760:	39 d1                	cmp    %edx,%ecx
 762:	72 1c                	jb     780 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 764:	39 d0                	cmp    %edx,%eax
 766:	73 18                	jae    780 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 768:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 76a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 76c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 76e:	72 f0                	jb     760 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 770:	39 d0                	cmp    %edx,%eax
 772:	72 f4                	jb     768 <free+0x28>
 774:	39 d1                	cmp    %edx,%ecx
 776:	73 f0                	jae    768 <free+0x28>
 778:	90                   	nop
 779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 780:	8b 73 fc             	mov    -0x4(%ebx),%esi
 783:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 786:	39 d7                	cmp    %edx,%edi
 788:	74 19                	je     7a3 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 78a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 78d:	8b 50 04             	mov    0x4(%eax),%edx
 790:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 793:	39 f1                	cmp    %esi,%ecx
 795:	74 25                	je     7bc <free+0x7c>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 797:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 799:	5b                   	pop    %ebx
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 79a:	a3 c0 0b 00 00       	mov    %eax,0xbc0
}
 79f:	5e                   	pop    %esi
 7a0:	5f                   	pop    %edi
 7a1:	5d                   	pop    %ebp
 7a2:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7a3:	8b 7a 04             	mov    0x4(%edx),%edi
 7a6:	01 fe                	add    %edi,%esi
 7a8:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7ab:	8b 10                	mov    (%eax),%edx
 7ad:	8b 12                	mov    (%edx),%edx
 7af:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7b2:	8b 50 04             	mov    0x4(%eax),%edx
 7b5:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7b8:	39 f1                	cmp    %esi,%ecx
 7ba:	75 db                	jne    797 <free+0x57>
    p->s.size += bp->s.size;
 7bc:	8b 4b fc             	mov    -0x4(%ebx),%ecx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 7bf:	a3 c0 0b 00 00       	mov    %eax,0xbc0
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7c4:	01 ca                	add    %ecx,%edx
 7c6:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7c9:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7cc:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 7ce:	5b                   	pop    %ebx
 7cf:	5e                   	pop    %esi
 7d0:	5f                   	pop    %edi
 7d1:	5d                   	pop    %ebp
 7d2:	c3                   	ret    
 7d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 7d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000007e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7e0:	55                   	push   %ebp
 7e1:	89 e5                	mov    %esp,%ebp
 7e3:	57                   	push   %edi
 7e4:	56                   	push   %esi
 7e5:	53                   	push   %ebx
 7e6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7ec:	8b 15 c0 0b 00 00    	mov    0xbc0,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7f2:	8d 78 07             	lea    0x7(%eax),%edi
 7f5:	c1 ef 03             	shr    $0x3,%edi
 7f8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 7f9:	85 d2                	test   %edx,%edx
 7fb:	0f 84 95 00 00 00    	je     896 <malloc+0xb6>
 801:	8b 02                	mov    (%edx),%eax
 803:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 806:	39 cf                	cmp    %ecx,%edi
 808:	76 66                	jbe    870 <malloc+0x90>
 80a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 810:	be 00 10 00 00       	mov    $0x1000,%esi
 815:	0f 43 f7             	cmovae %edi,%esi
 818:	ba 00 80 00 00       	mov    $0x8000,%edx
 81d:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 824:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 82a:	0f 46 da             	cmovbe %edx,%ebx
 82d:	eb 0a                	jmp    839 <malloc+0x59>
 82f:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 830:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 832:	8b 48 04             	mov    0x4(%eax),%ecx
 835:	39 cf                	cmp    %ecx,%edi
 837:	76 37                	jbe    870 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 839:	39 05 c0 0b 00 00    	cmp    %eax,0xbc0
 83f:	89 c2                	mov    %eax,%edx
 841:	75 ed                	jne    830 <malloc+0x50>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 843:	89 1c 24             	mov    %ebx,(%esp)
 846:	e8 35 fc ff ff       	call   480 <sbrk>
  if(p == (char*)-1)
 84b:	83 f8 ff             	cmp    $0xffffffff,%eax
 84e:	74 18                	je     868 <malloc+0x88>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 850:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 853:	83 c0 08             	add    $0x8,%eax
 856:	89 04 24             	mov    %eax,(%esp)
 859:	e8 e2 fe ff ff       	call   740 <free>
  return freep;
 85e:	8b 15 c0 0b 00 00    	mov    0xbc0,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 864:	85 d2                	test   %edx,%edx
 866:	75 c8                	jne    830 <malloc+0x50>
        return 0;
 868:	31 c0                	xor    %eax,%eax
 86a:	eb 1c                	jmp    888 <malloc+0xa8>
 86c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 870:	39 cf                	cmp    %ecx,%edi
 872:	74 1c                	je     890 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 874:	29 f9                	sub    %edi,%ecx
 876:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 879:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 87c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 87f:	89 15 c0 0b 00 00    	mov    %edx,0xbc0
      return (void*)(p + 1);
 885:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 888:	83 c4 1c             	add    $0x1c,%esp
 88b:	5b                   	pop    %ebx
 88c:	5e                   	pop    %esi
 88d:	5f                   	pop    %edi
 88e:	5d                   	pop    %ebp
 88f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 890:	8b 08                	mov    (%eax),%ecx
 892:	89 0a                	mov    %ecx,(%edx)
 894:	eb e9                	jmp    87f <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 896:	b8 c4 0b 00 00       	mov    $0xbc4,%eax
 89b:	ba c4 0b 00 00       	mov    $0xbc4,%edx
    base.s.size = 0;
 8a0:	31 c9                	xor    %ecx,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 8a2:	a3 c0 0b 00 00       	mov    %eax,0xbc0
    base.s.size = 0;
 8a7:	b8 c4 0b 00 00       	mov    $0xbc4,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 8ac:	89 15 c4 0b 00 00    	mov    %edx,0xbc4
    base.s.size = 0;
 8b2:	89 0d c8 0b 00 00    	mov    %ecx,0xbc8
 8b8:	e9 4d ff ff ff       	jmp    80a <malloc+0x2a>
