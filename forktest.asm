
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
  forktest();
   6:	e8 35 00 00 00       	call   40 <forktest>
  exit();
   b:	e8 88 03 00 00       	call   398 <exit>

00000010 <printf>:
{
  10:	55                   	push   %ebp
  11:	89 e5                	mov    %esp,%ebp
  13:	53                   	push   %ebx
  14:	83 ec 14             	sub    $0x14,%esp
  17:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  write(fd, s, strlen(s));
  1a:	89 1c 24             	mov    %ebx,(%esp)
  1d:	e8 ae 01 00 00       	call   1d0 <strlen>
  22:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  26:	89 44 24 08          	mov    %eax,0x8(%esp)
  2a:	8b 45 08             	mov    0x8(%ebp),%eax
  2d:	89 04 24             	mov    %eax,(%esp)
  30:	e8 83 03 00 00       	call   3b8 <write>
}
  35:	83 c4 14             	add    $0x14,%esp
  38:	5b                   	pop    %ebx
  39:	5d                   	pop    %ebp
  3a:	c3                   	ret    
  3b:	90                   	nop
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000040 <forktest>:
{
  40:	55                   	push   %ebp
  41:	89 e5                	mov    %esp,%ebp
  43:	53                   	push   %ebx
  write(fd, s, strlen(s));
  44:	bb 38 04 00 00       	mov    $0x438,%ebx
{
  49:	83 ec 14             	sub    $0x14,%esp
  write(fd, s, strlen(s));
  4c:	c7 04 24 38 04 00 00 	movl   $0x438,(%esp)
  53:	e8 78 01 00 00       	call   1d0 <strlen>
  58:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  for(n=0; n<N; n++){
  5c:	31 db                	xor    %ebx,%ebx
  write(fd, s, strlen(s));
  5e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  65:	89 44 24 08          	mov    %eax,0x8(%esp)
  69:	e8 4a 03 00 00       	call   3b8 <write>
  6e:	eb 12                	jmp    82 <forktest+0x42>
    if(pid == 0)
  70:	0f 84 c9 00 00 00    	je     13f <forktest+0xff>
  for(n=0; n<N; n++){
  76:	43                   	inc    %ebx
  77:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
  7d:	8d 76 00             	lea    0x0(%esi),%esi
  80:	74 6e                	je     f0 <forktest+0xb0>
    pid = fork();
  82:	e8 09 03 00 00       	call   390 <fork>
    if(pid < 0)
  87:	85 c0                	test   %eax,%eax
  89:	79 e5                	jns    70 <forktest+0x30>
  for(; n > 0; n--){
  8b:	85 db                	test   %ebx,%ebx
  8d:	8d 76 00             	lea    0x0(%esi),%esi
  90:	74 1a                	je     ac <forktest+0x6c>
  92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(wait() < 0){
  a0:	e8 fb 02 00 00       	call   3a0 <wait>
  a5:	85 c0                	test   %eax,%eax
  a7:	78 71                	js     11a <forktest+0xda>
  for(; n > 0; n--){
  a9:	4b                   	dec    %ebx
  aa:	75 f4                	jne    a0 <forktest+0x60>
  ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(wait() != -1){
  b0:	e8 eb 02 00 00       	call   3a0 <wait>
  b5:	40                   	inc    %eax
  b6:	0f 85 88 00 00 00    	jne    144 <forktest+0x104>
  write(fd, s, strlen(s));
  bc:	c7 04 24 6a 04 00 00 	movl   $0x46a,(%esp)
  c3:	e8 08 01 00 00       	call   1d0 <strlen>
  c8:	ba 6a 04 00 00       	mov    $0x46a,%edx
  cd:	89 54 24 04          	mov    %edx,0x4(%esp)
  d1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  d8:	89 44 24 08          	mov    %eax,0x8(%esp)
  dc:	e8 d7 02 00 00       	call   3b8 <write>
}
  e1:	83 c4 14             	add    $0x14,%esp
  e4:	5b                   	pop    %ebx
  e5:	5d                   	pop    %ebp
  e6:	c3                   	ret    
  e7:	89 f6                	mov    %esi,%esi
  e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  write(fd, s, strlen(s));
  f0:	c7 04 24 78 04 00 00 	movl   $0x478,(%esp)
  f7:	e8 d4 00 00 00       	call   1d0 <strlen>
  fc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 103:	89 44 24 08          	mov    %eax,0x8(%esp)
 107:	b8 78 04 00 00       	mov    $0x478,%eax
 10c:	89 44 24 04          	mov    %eax,0x4(%esp)
 110:	e8 a3 02 00 00       	call   3b8 <write>
    exit();
 115:	e8 7e 02 00 00       	call   398 <exit>
  write(fd, s, strlen(s));
 11a:	c7 04 24 43 04 00 00 	movl   $0x443,(%esp)
 121:	e8 aa 00 00 00       	call   1d0 <strlen>
 126:	b9 43 04 00 00       	mov    $0x443,%ecx
 12b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 12f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 136:	89 44 24 08          	mov    %eax,0x8(%esp)
 13a:	e8 79 02 00 00       	call   3b8 <write>
      exit();
 13f:	e8 54 02 00 00       	call   398 <exit>
  write(fd, s, strlen(s));
 144:	c7 04 24 57 04 00 00 	movl   $0x457,(%esp)
 14b:	e8 80 00 00 00       	call   1d0 <strlen>
 150:	c7 44 24 04 57 04 00 	movl   $0x457,0x4(%esp)
 157:	00 
 158:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 15f:	89 44 24 08          	mov    %eax,0x8(%esp)
 163:	e8 50 02 00 00       	call   3b8 <write>
    exit();
 168:	e8 2b 02 00 00       	call   398 <exit>
 16d:	66 90                	xchg   %ax,%ax
 16f:	90                   	nop

00000170 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	8b 45 08             	mov    0x8(%ebp),%eax
 176:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 179:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 17a:	89 c2                	mov    %eax,%edx
 17c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 180:	41                   	inc    %ecx
 181:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 185:	42                   	inc    %edx
 186:	84 db                	test   %bl,%bl
 188:	88 5a ff             	mov    %bl,-0x1(%edx)
 18b:	75 f3                	jne    180 <strcpy+0x10>
    ;
  return os;
}
 18d:	5b                   	pop    %ebx
 18e:	5d                   	pop    %ebp
 18f:	c3                   	ret    

00000190 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	8b 4d 08             	mov    0x8(%ebp),%ecx
 196:	53                   	push   %ebx
 197:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 19a:	0f b6 01             	movzbl (%ecx),%eax
 19d:	0f b6 13             	movzbl (%ebx),%edx
 1a0:	84 c0                	test   %al,%al
 1a2:	75 18                	jne    1bc <strcmp+0x2c>
 1a4:	eb 22                	jmp    1c8 <strcmp+0x38>
 1a6:	8d 76 00             	lea    0x0(%esi),%esi
 1a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 1b0:	41                   	inc    %ecx
  while(*p && *p == *q)
 1b1:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 1b4:	43                   	inc    %ebx
 1b5:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
 1b8:	84 c0                	test   %al,%al
 1ba:	74 0c                	je     1c8 <strcmp+0x38>
 1bc:	38 d0                	cmp    %dl,%al
 1be:	74 f0                	je     1b0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
 1c0:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 1c1:	29 d0                	sub    %edx,%eax
}
 1c3:	5d                   	pop    %ebp
 1c4:	c3                   	ret    
 1c5:	8d 76 00             	lea    0x0(%esi),%esi
 1c8:	5b                   	pop    %ebx
 1c9:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 1cb:	29 d0                	sub    %edx,%eax
}
 1cd:	5d                   	pop    %ebp
 1ce:	c3                   	ret    
 1cf:	90                   	nop

000001d0 <strlen>:

uint
strlen(const char *s)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1d6:	80 39 00             	cmpb   $0x0,(%ecx)
 1d9:	74 15                	je     1f0 <strlen+0x20>
 1db:	31 d2                	xor    %edx,%edx
 1dd:	8d 76 00             	lea    0x0(%esi),%esi
 1e0:	42                   	inc    %edx
 1e1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1e5:	89 d0                	mov    %edx,%eax
 1e7:	75 f7                	jne    1e0 <strlen+0x10>
    ;
  return n;
}
 1e9:	5d                   	pop    %ebp
 1ea:	c3                   	ret    
 1eb:	90                   	nop
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
 1f0:	31 c0                	xor    %eax,%eax
}
 1f2:	5d                   	pop    %ebp
 1f3:	c3                   	ret    
 1f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000200 <memset>:

void*
memset(void *dst, int c, uint n)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 55 08             	mov    0x8(%ebp),%edx
 206:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 207:	8b 4d 10             	mov    0x10(%ebp),%ecx
 20a:	8b 45 0c             	mov    0xc(%ebp),%eax
 20d:	89 d7                	mov    %edx,%edi
 20f:	fc                   	cld    
 210:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 212:	5f                   	pop    %edi
 213:	89 d0                	mov    %edx,%eax
 215:	5d                   	pop    %ebp
 216:	c3                   	ret    
 217:	89 f6                	mov    %esi,%esi
 219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000220 <strchr>:

char*
strchr(const char *s, char c)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	8b 45 08             	mov    0x8(%ebp),%eax
 226:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 22a:	0f b6 10             	movzbl (%eax),%edx
 22d:	84 d2                	test   %dl,%dl
 22f:	74 1b                	je     24c <strchr+0x2c>
    if(*s == c)
 231:	38 d1                	cmp    %dl,%cl
 233:	75 0f                	jne    244 <strchr+0x24>
 235:	eb 17                	jmp    24e <strchr+0x2e>
 237:	89 f6                	mov    %esi,%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 240:	38 ca                	cmp    %cl,%dl
 242:	74 0a                	je     24e <strchr+0x2e>
  for(; *s; s++)
 244:	40                   	inc    %eax
 245:	0f b6 10             	movzbl (%eax),%edx
 248:	84 d2                	test   %dl,%dl
 24a:	75 f4                	jne    240 <strchr+0x20>
      return (char*)s;
  return 0;
 24c:	31 c0                	xor    %eax,%eax
}
 24e:	5d                   	pop    %ebp
 24f:	c3                   	ret    

00000250 <gets>:

char*
gets(char *buf, int max)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	57                   	push   %edi
 254:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 255:	31 f6                	xor    %esi,%esi
{
 257:	53                   	push   %ebx
 258:	83 ec 3c             	sub    $0x3c,%esp
 25b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
 25e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 261:	eb 32                	jmp    295 <gets+0x45>
 263:	90                   	nop
 264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 268:	ba 01 00 00 00       	mov    $0x1,%edx
 26d:	89 54 24 08          	mov    %edx,0x8(%esp)
 271:	89 7c 24 04          	mov    %edi,0x4(%esp)
 275:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 27c:	e8 2f 01 00 00       	call   3b0 <read>
    if(cc < 1)
 281:	85 c0                	test   %eax,%eax
 283:	7e 19                	jle    29e <gets+0x4e>
      break;
    buf[i++] = c;
 285:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 289:	43                   	inc    %ebx
 28a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
 28d:	3c 0a                	cmp    $0xa,%al
 28f:	74 1f                	je     2b0 <gets+0x60>
 291:	3c 0d                	cmp    $0xd,%al
 293:	74 1b                	je     2b0 <gets+0x60>
  for(i=0; i+1 < max; ){
 295:	46                   	inc    %esi
 296:	3b 75 0c             	cmp    0xc(%ebp),%esi
 299:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 29c:	7c ca                	jl     268 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 29e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 2a1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 2a4:	8b 45 08             	mov    0x8(%ebp),%eax
 2a7:	83 c4 3c             	add    $0x3c,%esp
 2aa:	5b                   	pop    %ebx
 2ab:	5e                   	pop    %esi
 2ac:	5f                   	pop    %edi
 2ad:	5d                   	pop    %ebp
 2ae:	c3                   	ret    
 2af:	90                   	nop
 2b0:	8b 45 08             	mov    0x8(%ebp),%eax
 2b3:	01 c6                	add    %eax,%esi
 2b5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 2b8:	eb e4                	jmp    29e <gets+0x4e>
 2ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002c0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2c0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2c1:	31 c0                	xor    %eax,%eax
{
 2c3:	89 e5                	mov    %esp,%ebp
 2c5:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 2c8:	89 44 24 04          	mov    %eax,0x4(%esp)
 2cc:	8b 45 08             	mov    0x8(%ebp),%eax
{
 2cf:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 2d2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 2d5:	89 04 24             	mov    %eax,(%esp)
 2d8:	e8 fb 00 00 00       	call   3d8 <open>
  if(fd < 0)
 2dd:	85 c0                	test   %eax,%eax
 2df:	78 2f                	js     310 <stat+0x50>
 2e1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 2e3:	8b 45 0c             	mov    0xc(%ebp),%eax
 2e6:	89 1c 24             	mov    %ebx,(%esp)
 2e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 2ed:	e8 fe 00 00 00       	call   3f0 <fstat>
  close(fd);
 2f2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2f5:	89 c6                	mov    %eax,%esi
  close(fd);
 2f7:	e8 c4 00 00 00       	call   3c0 <close>
  return r;
}
 2fc:	89 f0                	mov    %esi,%eax
 2fe:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 301:	8b 75 fc             	mov    -0x4(%ebp),%esi
 304:	89 ec                	mov    %ebp,%esp
 306:	5d                   	pop    %ebp
 307:	c3                   	ret    
 308:	90                   	nop
 309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 310:	be ff ff ff ff       	mov    $0xffffffff,%esi
 315:	eb e5                	jmp    2fc <stat+0x3c>
 317:	89 f6                	mov    %esi,%esi
 319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000320 <atoi>:

int
atoi(const char *s)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	8b 4d 08             	mov    0x8(%ebp),%ecx
 326:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 327:	0f be 11             	movsbl (%ecx),%edx
 32a:	88 d0                	mov    %dl,%al
 32c:	2c 30                	sub    $0x30,%al
 32e:	3c 09                	cmp    $0x9,%al
  n = 0;
 330:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 335:	77 1e                	ja     355 <atoi+0x35>
 337:	89 f6                	mov    %esi,%esi
 339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 340:	41                   	inc    %ecx
 341:	8d 04 80             	lea    (%eax,%eax,4),%eax
 344:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 348:	0f be 11             	movsbl (%ecx),%edx
 34b:	88 d3                	mov    %dl,%bl
 34d:	80 eb 30             	sub    $0x30,%bl
 350:	80 fb 09             	cmp    $0x9,%bl
 353:	76 eb                	jbe    340 <atoi+0x20>
  return n;
}
 355:	5b                   	pop    %ebx
 356:	5d                   	pop    %ebp
 357:	c3                   	ret    
 358:	90                   	nop
 359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000360 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	56                   	push   %esi
 364:	8b 45 08             	mov    0x8(%ebp),%eax
 367:	53                   	push   %ebx
 368:	8b 5d 10             	mov    0x10(%ebp),%ebx
 36b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 36e:	85 db                	test   %ebx,%ebx
 370:	7e 1a                	jle    38c <memmove+0x2c>
 372:	31 d2                	xor    %edx,%edx
 374:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 37a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 380:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 384:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 387:	42                   	inc    %edx
  while(n-- > 0)
 388:	39 d3                	cmp    %edx,%ebx
 38a:	75 f4                	jne    380 <memmove+0x20>
  return vdst;
}
 38c:	5b                   	pop    %ebx
 38d:	5e                   	pop    %esi
 38e:	5d                   	pop    %ebp
 38f:	c3                   	ret    

00000390 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 390:	b8 01 00 00 00       	mov    $0x1,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <exit>:
SYSCALL(exit)
 398:	b8 02 00 00 00       	mov    $0x2,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <wait>:
SYSCALL(wait)
 3a0:	b8 03 00 00 00       	mov    $0x3,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <pipe>:
SYSCALL(pipe)
 3a8:	b8 04 00 00 00       	mov    $0x4,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <read>:
SYSCALL(read)
 3b0:	b8 05 00 00 00       	mov    $0x5,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <write>:
SYSCALL(write)
 3b8:	b8 10 00 00 00       	mov    $0x10,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <close>:
SYSCALL(close)
 3c0:	b8 15 00 00 00       	mov    $0x15,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <kill>:
SYSCALL(kill)
 3c8:	b8 06 00 00 00       	mov    $0x6,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <exec>:
SYSCALL(exec)
 3d0:	b8 07 00 00 00       	mov    $0x7,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <open>:
SYSCALL(open)
 3d8:	b8 0f 00 00 00       	mov    $0xf,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <mknod>:
SYSCALL(mknod)
 3e0:	b8 11 00 00 00       	mov    $0x11,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <unlink>:
SYSCALL(unlink)
 3e8:	b8 12 00 00 00       	mov    $0x12,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <fstat>:
SYSCALL(fstat)
 3f0:	b8 08 00 00 00       	mov    $0x8,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <link>:
SYSCALL(link)
 3f8:	b8 13 00 00 00       	mov    $0x13,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <mkdir>:
SYSCALL(mkdir)
 400:	b8 14 00 00 00       	mov    $0x14,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <chdir>:
SYSCALL(chdir)
 408:	b8 09 00 00 00       	mov    $0x9,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <dup>:
SYSCALL(dup)
 410:	b8 0a 00 00 00       	mov    $0xa,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <getpid>:
SYSCALL(getpid)
 418:	b8 0b 00 00 00       	mov    $0xb,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <sbrk>:
SYSCALL(sbrk)
 420:	b8 0c 00 00 00       	mov    $0xc,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <sleep>:
SYSCALL(sleep)
 428:	b8 0d 00 00 00       	mov    $0xd,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <uptime>:
SYSCALL(uptime)
 430:	b8 0e 00 00 00       	mov    $0xe,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    
