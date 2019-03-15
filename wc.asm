
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
  12:	7e 6a                	jle    7e <main+0x7e>
  14:	8b 45 0c             	mov    0xc(%ebp),%eax
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
  17:	be 01 00 00 00       	mov    $0x1,%esi
  1c:	8d 58 04             	lea    0x4(%eax),%ebx
  1f:	90                   	nop
    if((fd = open(argv[i], 0)) < 0){
  20:	31 c0                	xor    %eax,%eax
  22:	89 44 24 04          	mov    %eax,0x4(%esp)
  26:	8b 03                	mov    (%ebx),%eax
  28:	89 04 24             	mov    %eax,(%esp)
  2b:	e8 e8 03 00 00       	call   418 <open>
  30:	85 c0                	test   %eax,%eax
  32:	78 2b                	js     5f <main+0x5f>
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
  34:	8b 13                	mov    (%ebx),%edx
  for(i = 1; i < argc; i++){
  36:	46                   	inc    %esi
  37:	83 c3 04             	add    $0x4,%ebx
    wc(fd, argv[i]);
  3a:	89 04 24             	mov    %eax,(%esp)
  3d:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  41:	89 54 24 04          	mov    %edx,0x4(%esp)
  45:	e8 56 00 00 00       	call   a0 <wc>
    close(fd);
  4a:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  4e:	89 04 24             	mov    %eax,(%esp)
  51:	e8 aa 03 00 00       	call   400 <close>
  for(i = 1; i < argc; i++){
  56:	39 f7                	cmp    %esi,%edi
  58:	75 c6                	jne    20 <main+0x20>
  }
  exit();
  5a:	e8 79 03 00 00       	call   3d8 <exit>
      printf(1, "wc: cannot open %s\n", argv[i]);
  5f:	8b 03                	mov    (%ebx),%eax
  61:	c7 44 24 04 bb 08 00 	movl   $0x8bb,0x4(%esp)
  68:	00 
  69:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  70:	89 44 24 08          	mov    %eax,0x8(%esp)
  74:	e8 a7 04 00 00       	call   520 <printf>
      exit();
  79:	e8 5a 03 00 00       	call   3d8 <exit>
    wc(0, "");
  7e:	c7 44 24 04 ad 08 00 	movl   $0x8ad,0x4(%esp)
  85:	00 
  86:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  8d:	e8 0e 00 00 00       	call   a0 <wc>
    exit();
  92:	e8 41 03 00 00       	call   3d8 <exit>
  97:	66 90                	xchg   %ax,%ax
  99:	66 90                	xchg   %ax,%ax
  9b:	66 90                	xchg   %ax,%ax
  9d:	66 90                	xchg   %ax,%ax
  9f:	90                   	nop

000000a0 <wc>:
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	57                   	push   %edi
  a4:	56                   	push   %esi
  a5:	53                   	push   %ebx
  l = w = c = 0;
  a6:	31 db                	xor    %ebx,%ebx
{
  a8:	83 ec 3c             	sub    $0x3c,%esp
  inword = 0;
  ab:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  l = w = c = 0;
  b2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  b9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
  c0:	8b 45 08             	mov    0x8(%ebp),%eax
  c3:	ba 00 02 00 00       	mov    $0x200,%edx
  c8:	b9 c0 0b 00 00       	mov    $0xbc0,%ecx
  cd:	89 54 24 08          	mov    %edx,0x8(%esp)
  d1:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  d5:	89 04 24             	mov    %eax,(%esp)
  d8:	e8 13 03 00 00       	call   3f0 <read>
  dd:	83 f8 00             	cmp    $0x0,%eax
  e0:	89 c6                	mov    %eax,%esi
  e2:	7e 6c                	jle    150 <wc+0xb0>
    for(i=0; i<n; i++){
  e4:	31 ff                	xor    %edi,%edi
  e6:	eb 14                	jmp    fc <wc+0x5c>
  e8:	90                   	nop
  e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        inword = 0;
  f0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    for(i=0; i<n; i++){
  f7:	47                   	inc    %edi
  f8:	39 fe                	cmp    %edi,%esi
  fa:	74 44                	je     140 <wc+0xa0>
      if(buf[i] == '\n')
  fc:	0f be 87 c0 0b 00 00 	movsbl 0xbc0(%edi),%eax
        l++;
 103:	31 c9                	xor    %ecx,%ecx
      if(strchr(" \r\t\n\v", buf[i]))
 105:	c7 04 24 98 08 00 00 	movl   $0x898,(%esp)
        l++;
 10c:	3c 0a                	cmp    $0xa,%al
 10e:	0f 94 c1             	sete   %cl
      if(strchr(" \r\t\n\v", buf[i]))
 111:	89 44 24 04          	mov    %eax,0x4(%esp)
        l++;
 115:	01 cb                	add    %ecx,%ebx
      if(strchr(" \r\t\n\v", buf[i]))
 117:	e8 44 01 00 00       	call   260 <strchr>
 11c:	85 c0                	test   %eax,%eax
 11e:	75 d0                	jne    f0 <wc+0x50>
      else if(!inword){
 120:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 123:	85 c0                	test   %eax,%eax
 125:	75 d0                	jne    f7 <wc+0x57>
    for(i=0; i<n; i++){
 127:	47                   	inc    %edi
        w++;
 128:	ff 45 dc             	incl   -0x24(%ebp)
    for(i=0; i<n; i++){
 12b:	39 fe                	cmp    %edi,%esi
        inword = 1;
 12d:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
    for(i=0; i<n; i++){
 134:	75 c6                	jne    fc <wc+0x5c>
 136:	8d 76 00             	lea    0x0(%esi),%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 140:	01 75 e0             	add    %esi,-0x20(%ebp)
 143:	e9 78 ff ff ff       	jmp    c0 <wc+0x20>
 148:	90                   	nop
 149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(n < 0){
 150:	75 36                	jne    188 <wc+0xe8>
  printf(1, "%d %d %d %s\n", l, w, c, name);
 152:	8b 45 0c             	mov    0xc(%ebp),%eax
 155:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 159:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 160:	89 44 24 14          	mov    %eax,0x14(%esp)
 164:	8b 45 e0             	mov    -0x20(%ebp),%eax
 167:	89 44 24 10          	mov    %eax,0x10(%esp)
 16b:	8b 45 dc             	mov    -0x24(%ebp),%eax
 16e:	89 44 24 0c          	mov    %eax,0xc(%esp)
 172:	b8 ae 08 00 00       	mov    $0x8ae,%eax
 177:	89 44 24 04          	mov    %eax,0x4(%esp)
 17b:	e8 a0 03 00 00       	call   520 <printf>
}
 180:	83 c4 3c             	add    $0x3c,%esp
 183:	5b                   	pop    %ebx
 184:	5e                   	pop    %esi
 185:	5f                   	pop    %edi
 186:	5d                   	pop    %ebp
 187:	c3                   	ret    
    printf(1, "wc: read error\n");
 188:	c7 44 24 04 9e 08 00 	movl   $0x89e,0x4(%esp)
 18f:	00 
 190:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 197:	e8 84 03 00 00       	call   520 <printf>
    exit();
 19c:	e8 37 02 00 00       	call   3d8 <exit>
 1a1:	66 90                	xchg   %ax,%ax
 1a3:	66 90                	xchg   %ax,%ax
 1a5:	66 90                	xchg   %ax,%ax
 1a7:	66 90                	xchg   %ax,%ax
 1a9:	66 90                	xchg   %ax,%ax
 1ab:	66 90                	xchg   %ax,%ax
 1ad:	66 90                	xchg   %ax,%ax
 1af:	90                   	nop

000001b0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 45 08             	mov    0x8(%ebp),%eax
 1b6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1b9:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1ba:	89 c2                	mov    %eax,%edx
 1bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1c0:	41                   	inc    %ecx
 1c1:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 1c5:	42                   	inc    %edx
 1c6:	84 db                	test   %bl,%bl
 1c8:	88 5a ff             	mov    %bl,-0x1(%edx)
 1cb:	75 f3                	jne    1c0 <strcpy+0x10>
    ;
  return os;
}
 1cd:	5b                   	pop    %ebx
 1ce:	5d                   	pop    %ebp
 1cf:	c3                   	ret    

000001d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1d6:	53                   	push   %ebx
 1d7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 1da:	0f b6 01             	movzbl (%ecx),%eax
 1dd:	0f b6 13             	movzbl (%ebx),%edx
 1e0:	84 c0                	test   %al,%al
 1e2:	75 18                	jne    1fc <strcmp+0x2c>
 1e4:	eb 22                	jmp    208 <strcmp+0x38>
 1e6:	8d 76 00             	lea    0x0(%esi),%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 1f0:	41                   	inc    %ecx
  while(*p && *p == *q)
 1f1:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 1f4:	43                   	inc    %ebx
 1f5:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
 1f8:	84 c0                	test   %al,%al
 1fa:	74 0c                	je     208 <strcmp+0x38>
 1fc:	38 d0                	cmp    %dl,%al
 1fe:	74 f0                	je     1f0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
 200:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 201:	29 d0                	sub    %edx,%eax
}
 203:	5d                   	pop    %ebp
 204:	c3                   	ret    
 205:	8d 76 00             	lea    0x0(%esi),%esi
 208:	5b                   	pop    %ebx
 209:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 20b:	29 d0                	sub    %edx,%eax
}
 20d:	5d                   	pop    %ebp
 20e:	c3                   	ret    
 20f:	90                   	nop

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
 219:	74 15                	je     230 <strlen+0x20>
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
 22b:	90                   	nop
 22c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
 230:	31 c0                	xor    %eax,%eax
}
 232:	5d                   	pop    %ebp
 233:	c3                   	ret    
 234:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 23a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000240 <memset>:

void*
memset(void *dst, int c, uint n)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	8b 55 08             	mov    0x8(%ebp),%edx
 246:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 247:	8b 4d 10             	mov    0x10(%ebp),%ecx
 24a:	8b 45 0c             	mov    0xc(%ebp),%eax
 24d:	89 d7                	mov    %edx,%edi
 24f:	fc                   	cld    
 250:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 252:	5f                   	pop    %edi
 253:	89 d0                	mov    %edx,%eax
 255:	5d                   	pop    %ebp
 256:	c3                   	ret    
 257:	89 f6                	mov    %esi,%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000260 <strchr>:

char*
strchr(const char *s, char c)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	8b 45 08             	mov    0x8(%ebp),%eax
 266:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 26a:	0f b6 10             	movzbl (%eax),%edx
 26d:	84 d2                	test   %dl,%dl
 26f:	74 1b                	je     28c <strchr+0x2c>
    if(*s == c)
 271:	38 d1                	cmp    %dl,%cl
 273:	75 0f                	jne    284 <strchr+0x24>
 275:	eb 17                	jmp    28e <strchr+0x2e>
 277:	89 f6                	mov    %esi,%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 280:	38 ca                	cmp    %cl,%dl
 282:	74 0a                	je     28e <strchr+0x2e>
  for(; *s; s++)
 284:	40                   	inc    %eax
 285:	0f b6 10             	movzbl (%eax),%edx
 288:	84 d2                	test   %dl,%dl
 28a:	75 f4                	jne    280 <strchr+0x20>
      return (char*)s;
  return 0;
 28c:	31 c0                	xor    %eax,%eax
}
 28e:	5d                   	pop    %ebp
 28f:	c3                   	ret    

00000290 <gets>:

char*
gets(char *buf, int max)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	57                   	push   %edi
 294:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 295:	31 f6                	xor    %esi,%esi
{
 297:	53                   	push   %ebx
 298:	83 ec 3c             	sub    $0x3c,%esp
 29b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
 29e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 2a1:	eb 32                	jmp    2d5 <gets+0x45>
 2a3:	90                   	nop
 2a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 2a8:	ba 01 00 00 00       	mov    $0x1,%edx
 2ad:	89 54 24 08          	mov    %edx,0x8(%esp)
 2b1:	89 7c 24 04          	mov    %edi,0x4(%esp)
 2b5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2bc:	e8 2f 01 00 00       	call   3f0 <read>
    if(cc < 1)
 2c1:	85 c0                	test   %eax,%eax
 2c3:	7e 19                	jle    2de <gets+0x4e>
      break;
    buf[i++] = c;
 2c5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2c9:	43                   	inc    %ebx
 2ca:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
 2cd:	3c 0a                	cmp    $0xa,%al
 2cf:	74 1f                	je     2f0 <gets+0x60>
 2d1:	3c 0d                	cmp    $0xd,%al
 2d3:	74 1b                	je     2f0 <gets+0x60>
  for(i=0; i+1 < max; ){
 2d5:	46                   	inc    %esi
 2d6:	3b 75 0c             	cmp    0xc(%ebp),%esi
 2d9:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 2dc:	7c ca                	jl     2a8 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 2de:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 2e1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 2e4:	8b 45 08             	mov    0x8(%ebp),%eax
 2e7:	83 c4 3c             	add    $0x3c,%esp
 2ea:	5b                   	pop    %ebx
 2eb:	5e                   	pop    %esi
 2ec:	5f                   	pop    %edi
 2ed:	5d                   	pop    %ebp
 2ee:	c3                   	ret    
 2ef:	90                   	nop
 2f0:	8b 45 08             	mov    0x8(%ebp),%eax
 2f3:	01 c6                	add    %eax,%esi
 2f5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 2f8:	eb e4                	jmp    2de <gets+0x4e>
 2fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000300 <stat>:

int
stat(const char *n, struct stat *st)
{
 300:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 301:	31 c0                	xor    %eax,%eax
{
 303:	89 e5                	mov    %esp,%ebp
 305:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 308:	89 44 24 04          	mov    %eax,0x4(%esp)
 30c:	8b 45 08             	mov    0x8(%ebp),%eax
{
 30f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 312:	89 75 fc             	mov    %esi,-0x4(%ebp)
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
  r = fstat(fd, st);
 335:	89 c6                	mov    %eax,%esi
  close(fd);
 337:	e8 c4 00 00 00       	call   400 <close>
  return r;
}
 33c:	89 f0                	mov    %esi,%eax
 33e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 341:	8b 75 fc             	mov    -0x4(%ebp),%esi
 344:	89 ec                	mov    %ebp,%esp
 346:	5d                   	pop    %ebp
 347:	c3                   	ret    
 348:	90                   	nop
 349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 350:	be ff ff ff ff       	mov    $0xffffffff,%esi
 355:	eb e5                	jmp    33c <stat+0x3c>
 357:	89 f6                	mov    %esi,%esi
 359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000360 <atoi>:

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
  n = 0;
 370:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 375:	77 1e                	ja     395 <atoi+0x35>
 377:	89 f6                	mov    %esi,%esi
 379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 380:	41                   	inc    %ecx
 381:	8d 04 80             	lea    (%eax,%eax,4),%eax
 384:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 388:	0f be 11             	movsbl (%ecx),%edx
 38b:	88 d3                	mov    %dl,%bl
 38d:	80 eb 30             	sub    $0x30,%bl
 390:	80 fb 09             	cmp    $0x9,%bl
 393:	76 eb                	jbe    380 <atoi+0x20>
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
  while(n-- > 0)
 3c8:	39 d3                	cmp    %edx,%ebx
 3ca:	75 f4                	jne    3c0 <memmove+0x20>
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
 478:	66 90                	xchg   %ax,%ax
 47a:	66 90                	xchg   %ax,%ax
 47c:	66 90                	xchg   %ax,%ax
 47e:	66 90                	xchg   %ax,%ax

00000480 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
 485:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 486:	89 d3                	mov    %edx,%ebx
 488:	c1 eb 1f             	shr    $0x1f,%ebx
{
 48b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 48e:	84 db                	test   %bl,%bl
{
 490:	89 45 c0             	mov    %eax,-0x40(%ebp)
 493:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 495:	74 79                	je     510 <printint+0x90>
 497:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 49b:	74 73                	je     510 <printint+0x90>
    neg = 1;
    x = -xx;
 49d:	f7 d8                	neg    %eax
    neg = 1;
 49f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 4a6:	31 f6                	xor    %esi,%esi
 4a8:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 4ab:	eb 05                	jmp    4b2 <printint+0x32>
 4ad:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4b0:	89 fe                	mov    %edi,%esi
 4b2:	31 d2                	xor    %edx,%edx
 4b4:	f7 f1                	div    %ecx
 4b6:	8d 7e 01             	lea    0x1(%esi),%edi
 4b9:	0f b6 92 d8 08 00 00 	movzbl 0x8d8(%edx),%edx
  }while((x /= base) != 0);
 4c0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 4c2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 4c5:	75 e9                	jne    4b0 <printint+0x30>
  if(neg)
 4c7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 4ca:	85 d2                	test   %edx,%edx
 4cc:	74 08                	je     4d6 <printint+0x56>
    buf[i++] = '-';
 4ce:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 4d3:	8d 7e 02             	lea    0x2(%esi),%edi
 4d6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 4da:	8b 7d c0             	mov    -0x40(%ebp),%edi
 4dd:	8d 76 00             	lea    0x0(%esi),%esi
 4e0:	0f b6 06             	movzbl (%esi),%eax
 4e3:	4e                   	dec    %esi
  write(fd, &c, 1);
 4e4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 4e8:	89 3c 24             	mov    %edi,(%esp)
 4eb:	88 45 d7             	mov    %al,-0x29(%ebp)
 4ee:	b8 01 00 00 00       	mov    $0x1,%eax
 4f3:	89 44 24 08          	mov    %eax,0x8(%esp)
 4f7:	e8 fc fe ff ff       	call   3f8 <write>

  while(--i >= 0)
 4fc:	39 de                	cmp    %ebx,%esi
 4fe:	75 e0                	jne    4e0 <printint+0x60>
    putc(fd, buf[i]);
}
 500:	83 c4 4c             	add    $0x4c,%esp
 503:	5b                   	pop    %ebx
 504:	5e                   	pop    %esi
 505:	5f                   	pop    %edi
 506:	5d                   	pop    %ebp
 507:	c3                   	ret    
 508:	90                   	nop
 509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 510:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 517:	eb 8d                	jmp    4a6 <printint+0x26>
 519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000520 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	57                   	push   %edi
 524:	56                   	push   %esi
 525:	53                   	push   %ebx
 526:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 529:	8b 75 0c             	mov    0xc(%ebp),%esi
 52c:	0f b6 1e             	movzbl (%esi),%ebx
 52f:	84 db                	test   %bl,%bl
 531:	0f 84 d1 00 00 00    	je     608 <printf+0xe8>
  state = 0;
 537:	31 ff                	xor    %edi,%edi
 539:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 53a:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 53d:	89 fa                	mov    %edi,%edx
 53f:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 542:	89 45 d0             	mov    %eax,-0x30(%ebp)
 545:	eb 41                	jmp    588 <printf+0x68>
 547:	89 f6                	mov    %esi,%esi
 549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 550:	83 f8 25             	cmp    $0x25,%eax
 553:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 556:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 55b:	74 1e                	je     57b <printf+0x5b>
  write(fd, &c, 1);
 55d:	b8 01 00 00 00       	mov    $0x1,%eax
 562:	89 44 24 08          	mov    %eax,0x8(%esp)
 566:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 569:	89 44 24 04          	mov    %eax,0x4(%esp)
 56d:	89 3c 24             	mov    %edi,(%esp)
 570:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 573:	e8 80 fe ff ff       	call   3f8 <write>
 578:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 57b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 57c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 580:	84 db                	test   %bl,%bl
 582:	0f 84 80 00 00 00    	je     608 <printf+0xe8>
    if(state == 0){
 588:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 58a:	0f be cb             	movsbl %bl,%ecx
 58d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 590:	74 be                	je     550 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 592:	83 fa 25             	cmp    $0x25,%edx
 595:	75 e4                	jne    57b <printf+0x5b>
      if(c == 'd'){
 597:	83 f8 64             	cmp    $0x64,%eax
 59a:	0f 84 f0 00 00 00    	je     690 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5a0:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 5a6:	83 f9 70             	cmp    $0x70,%ecx
 5a9:	74 65                	je     610 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5ab:	83 f8 73             	cmp    $0x73,%eax
 5ae:	0f 84 8c 00 00 00    	je     640 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5b4:	83 f8 63             	cmp    $0x63,%eax
 5b7:	0f 84 13 01 00 00    	je     6d0 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5bd:	83 f8 25             	cmp    $0x25,%eax
 5c0:	0f 84 e2 00 00 00    	je     6a8 <printf+0x188>
  write(fd, &c, 1);
 5c6:	b8 01 00 00 00       	mov    $0x1,%eax
 5cb:	46                   	inc    %esi
 5cc:	89 44 24 08          	mov    %eax,0x8(%esp)
 5d0:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5d3:	89 44 24 04          	mov    %eax,0x4(%esp)
 5d7:	89 3c 24             	mov    %edi,(%esp)
 5da:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5de:	e8 15 fe ff ff       	call   3f8 <write>
 5e3:	ba 01 00 00 00       	mov    $0x1,%edx
 5e8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5eb:	89 54 24 08          	mov    %edx,0x8(%esp)
 5ef:	89 44 24 04          	mov    %eax,0x4(%esp)
 5f3:	89 3c 24             	mov    %edi,(%esp)
 5f6:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 5f9:	e8 fa fd ff ff       	call   3f8 <write>
  for(i = 0; fmt[i]; i++){
 5fe:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 602:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 604:	84 db                	test   %bl,%bl
 606:	75 80                	jne    588 <printf+0x68>
    }
  }
}
 608:	83 c4 3c             	add    $0x3c,%esp
 60b:	5b                   	pop    %ebx
 60c:	5e                   	pop    %esi
 60d:	5f                   	pop    %edi
 60e:	5d                   	pop    %ebp
 60f:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 610:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 617:	b9 10 00 00 00       	mov    $0x10,%ecx
 61c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 61f:	89 f8                	mov    %edi,%eax
 621:	8b 13                	mov    (%ebx),%edx
 623:	e8 58 fe ff ff       	call   480 <printint>
        ap++;
 628:	89 d8                	mov    %ebx,%eax
      state = 0;
 62a:	31 d2                	xor    %edx,%edx
        ap++;
 62c:	83 c0 04             	add    $0x4,%eax
 62f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 632:	e9 44 ff ff ff       	jmp    57b <printf+0x5b>
 637:	89 f6                	mov    %esi,%esi
 639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 640:	8b 45 d0             	mov    -0x30(%ebp),%eax
 643:	8b 10                	mov    (%eax),%edx
        ap++;
 645:	83 c0 04             	add    $0x4,%eax
 648:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 64b:	85 d2                	test   %edx,%edx
 64d:	0f 84 aa 00 00 00    	je     6fd <printf+0x1dd>
        while(*s != 0){
 653:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 656:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 658:	84 c0                	test   %al,%al
 65a:	74 27                	je     683 <printf+0x163>
 65c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 660:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 663:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 668:	43                   	inc    %ebx
  write(fd, &c, 1);
 669:	89 44 24 08          	mov    %eax,0x8(%esp)
 66d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 670:	89 44 24 04          	mov    %eax,0x4(%esp)
 674:	89 3c 24             	mov    %edi,(%esp)
 677:	e8 7c fd ff ff       	call   3f8 <write>
        while(*s != 0){
 67c:	0f b6 03             	movzbl (%ebx),%eax
 67f:	84 c0                	test   %al,%al
 681:	75 dd                	jne    660 <printf+0x140>
      state = 0;
 683:	31 d2                	xor    %edx,%edx
 685:	e9 f1 fe ff ff       	jmp    57b <printf+0x5b>
 68a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 690:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 697:	b9 0a 00 00 00       	mov    $0xa,%ecx
 69c:	e9 7b ff ff ff       	jmp    61c <printf+0xfc>
 6a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 6a8:	b9 01 00 00 00       	mov    $0x1,%ecx
 6ad:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 6b0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 6b4:	89 44 24 04          	mov    %eax,0x4(%esp)
 6b8:	89 3c 24             	mov    %edi,(%esp)
 6bb:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 6be:	e8 35 fd ff ff       	call   3f8 <write>
      state = 0;
 6c3:	31 d2                	xor    %edx,%edx
 6c5:	e9 b1 fe ff ff       	jmp    57b <printf+0x5b>
 6ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 6d0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 6d3:	8b 03                	mov    (%ebx),%eax
        ap++;
 6d5:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 6d8:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 6db:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 6de:	b8 01 00 00 00       	mov    $0x1,%eax
 6e3:	89 44 24 08          	mov    %eax,0x8(%esp)
 6e7:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6ea:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ee:	e8 05 fd ff ff       	call   3f8 <write>
      state = 0;
 6f3:	31 d2                	xor    %edx,%edx
        ap++;
 6f5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 6f8:	e9 7e fe ff ff       	jmp    57b <printf+0x5b>
          s = "(null)";
 6fd:	bb cf 08 00 00       	mov    $0x8cf,%ebx
        while(*s != 0){
 702:	b0 28                	mov    $0x28,%al
 704:	e9 57 ff ff ff       	jmp    660 <printf+0x140>
 709:	66 90                	xchg   %ax,%ax
 70b:	66 90                	xchg   %ax,%ax
 70d:	66 90                	xchg   %ax,%ax
 70f:	90                   	nop

00000710 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 710:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 711:	a1 a0 0b 00 00       	mov    0xba0,%eax
{
 716:	89 e5                	mov    %esp,%ebp
 718:	57                   	push   %edi
 719:	56                   	push   %esi
 71a:	53                   	push   %ebx
 71b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 71e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 721:	eb 0d                	jmp    730 <free+0x20>
 723:	90                   	nop
 724:	90                   	nop
 725:	90                   	nop
 726:	90                   	nop
 727:	90                   	nop
 728:	90                   	nop
 729:	90                   	nop
 72a:	90                   	nop
 72b:	90                   	nop
 72c:	90                   	nop
 72d:	90                   	nop
 72e:	90                   	nop
 72f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 730:	39 c8                	cmp    %ecx,%eax
 732:	8b 10                	mov    (%eax),%edx
 734:	73 32                	jae    768 <free+0x58>
 736:	39 d1                	cmp    %edx,%ecx
 738:	72 04                	jb     73e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 73a:	39 d0                	cmp    %edx,%eax
 73c:	72 32                	jb     770 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 73e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 741:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 744:	39 fa                	cmp    %edi,%edx
 746:	74 30                	je     778 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 748:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 74b:	8b 50 04             	mov    0x4(%eax),%edx
 74e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 751:	39 f1                	cmp    %esi,%ecx
 753:	74 3c                	je     791 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 755:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 757:	5b                   	pop    %ebx
  freep = p;
 758:	a3 a0 0b 00 00       	mov    %eax,0xba0
}
 75d:	5e                   	pop    %esi
 75e:	5f                   	pop    %edi
 75f:	5d                   	pop    %ebp
 760:	c3                   	ret    
 761:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 768:	39 d0                	cmp    %edx,%eax
 76a:	72 04                	jb     770 <free+0x60>
 76c:	39 d1                	cmp    %edx,%ecx
 76e:	72 ce                	jb     73e <free+0x2e>
{
 770:	89 d0                	mov    %edx,%eax
 772:	eb bc                	jmp    730 <free+0x20>
 774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 778:	8b 7a 04             	mov    0x4(%edx),%edi
 77b:	01 fe                	add    %edi,%esi
 77d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 780:	8b 10                	mov    (%eax),%edx
 782:	8b 12                	mov    (%edx),%edx
 784:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 787:	8b 50 04             	mov    0x4(%eax),%edx
 78a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 78d:	39 f1                	cmp    %esi,%ecx
 78f:	75 c4                	jne    755 <free+0x45>
    p->s.size += bp->s.size;
 791:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 794:	a3 a0 0b 00 00       	mov    %eax,0xba0
    p->s.size += bp->s.size;
 799:	01 ca                	add    %ecx,%edx
 79b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 79e:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7a1:	89 10                	mov    %edx,(%eax)
}
 7a3:	5b                   	pop    %ebx
 7a4:	5e                   	pop    %esi
 7a5:	5f                   	pop    %edi
 7a6:	5d                   	pop    %ebp
 7a7:	c3                   	ret    
 7a8:	90                   	nop
 7a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000007b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7b0:	55                   	push   %ebp
 7b1:	89 e5                	mov    %esp,%ebp
 7b3:	57                   	push   %edi
 7b4:	56                   	push   %esi
 7b5:	53                   	push   %ebx
 7b6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7bc:	8b 15 a0 0b 00 00    	mov    0xba0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7c2:	8d 78 07             	lea    0x7(%eax),%edi
 7c5:	c1 ef 03             	shr    $0x3,%edi
 7c8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 7c9:	85 d2                	test   %edx,%edx
 7cb:	0f 84 8f 00 00 00    	je     860 <malloc+0xb0>
 7d1:	8b 02                	mov    (%edx),%eax
 7d3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7d6:	39 cf                	cmp    %ecx,%edi
 7d8:	76 66                	jbe    840 <malloc+0x90>
 7da:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 7e0:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7e5:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 7e8:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7ef:	eb 10                	jmp    801 <malloc+0x51>
 7f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7f8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7fa:	8b 48 04             	mov    0x4(%eax),%ecx
 7fd:	39 f9                	cmp    %edi,%ecx
 7ff:	73 3f                	jae    840 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 801:	39 05 a0 0b 00 00    	cmp    %eax,0xba0
 807:	89 c2                	mov    %eax,%edx
 809:	75 ed                	jne    7f8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 80b:	89 34 24             	mov    %esi,(%esp)
 80e:	e8 4d fc ff ff       	call   460 <sbrk>
  if(p == (char*)-1)
 813:	83 f8 ff             	cmp    $0xffffffff,%eax
 816:	74 18                	je     830 <malloc+0x80>
  hp->s.size = nu;
 818:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 81b:	83 c0 08             	add    $0x8,%eax
 81e:	89 04 24             	mov    %eax,(%esp)
 821:	e8 ea fe ff ff       	call   710 <free>
  return freep;
 826:	8b 15 a0 0b 00 00    	mov    0xba0,%edx
      if((p = morecore(nunits)) == 0)
 82c:	85 d2                	test   %edx,%edx
 82e:	75 c8                	jne    7f8 <malloc+0x48>
        return 0;
  }
}
 830:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 833:	31 c0                	xor    %eax,%eax
}
 835:	5b                   	pop    %ebx
 836:	5e                   	pop    %esi
 837:	5f                   	pop    %edi
 838:	5d                   	pop    %ebp
 839:	c3                   	ret    
 83a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 840:	39 cf                	cmp    %ecx,%edi
 842:	74 4c                	je     890 <malloc+0xe0>
        p->s.size -= nunits;
 844:	29 f9                	sub    %edi,%ecx
 846:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 849:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 84c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 84f:	89 15 a0 0b 00 00    	mov    %edx,0xba0
}
 855:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 858:	83 c0 08             	add    $0x8,%eax
}
 85b:	5b                   	pop    %ebx
 85c:	5e                   	pop    %esi
 85d:	5f                   	pop    %edi
 85e:	5d                   	pop    %ebp
 85f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 860:	b8 a4 0b 00 00       	mov    $0xba4,%eax
 865:	ba a4 0b 00 00       	mov    $0xba4,%edx
    base.s.size = 0;
 86a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 86c:	a3 a0 0b 00 00       	mov    %eax,0xba0
    base.s.size = 0;
 871:	b8 a4 0b 00 00       	mov    $0xba4,%eax
    base.s.ptr = freep = prevp = &base;
 876:	89 15 a4 0b 00 00    	mov    %edx,0xba4
    base.s.size = 0;
 87c:	89 0d a8 0b 00 00    	mov    %ecx,0xba8
 882:	e9 53 ff ff ff       	jmp    7da <malloc+0x2a>
 887:	89 f6                	mov    %esi,%esi
 889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 890:	8b 08                	mov    (%eax),%ecx
 892:	89 0a                	mov    %ecx,(%edx)
 894:	eb b9                	jmp    84f <malloc+0x9f>
