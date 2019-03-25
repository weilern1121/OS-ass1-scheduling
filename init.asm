
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	55                   	push   %ebp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   1:	b9 02 00 00 00       	mov    $0x2,%ecx

char *argv[] = { "sh", 0 };

int
main(void)
{
   6:	89 e5                	mov    %esp,%ebp
   8:	53                   	push   %ebx
   9:	83 e4 f0             	and    $0xfffffff0,%esp
   c:	83 ec 10             	sub    $0x10,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  13:	c7 04 24 40 08 00 00 	movl   $0x840,(%esp)
  1a:	e8 89 03 00 00       	call   3a8 <open>
  1f:	85 c0                	test   %eax,%eax
  21:	0f 88 cf 00 00 00    	js     f6 <main+0xf6>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  27:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  2e:	e8 ad 03 00 00       	call   3e0 <dup>
  dup(0);  // stderr
  33:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3a:	e8 a1 03 00 00       	call   3e0 <dup>
  3f:	90                   	nop

  for(;;){
    printf(1, "init: starting sh\n");
  40:	ba 48 08 00 00       	mov    $0x848,%edx
  45:	89 54 24 04          	mov    %edx,0x4(%esp)
  49:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  50:	e8 8b 04 00 00       	call   4e0 <printf>
    pid = fork();
  55:	e8 06 03 00 00       	call   360 <fork>
    if(pid < 0){
  5a:	85 c0                	test   %eax,%eax
  dup(0);  // stdout
  dup(0);  // stderr

  for(;;){
    printf(1, "init: starting sh\n");
    pid = fork();
  5c:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  5e:	78 42                	js     a2 <main+0xa2>
      printf(1, "init: fork failed\n");
      exit(0);
    }
    if(pid == 0){
  60:	74 60                	je     c2 <main+0xc2>
  62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit(0);
    }
    while((wpid=wait(0)) >= 0 && wpid != pid)
  70:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  77:	e8 f4 02 00 00       	call   370 <wait>
  7c:	89 c2                	mov    %eax,%edx
  7e:	f7 d2                	not    %edx
  80:	c1 ea 1f             	shr    $0x1f,%edx
  83:	84 d2                	test   %dl,%dl
  85:	74 b9                	je     40 <main+0x40>
  87:	39 c3                	cmp    %eax,%ebx
  89:	74 b5                	je     40 <main+0x40>
      printf(1, "zombie!\n");
  8b:	b8 87 08 00 00       	mov    $0x887,%eax
  90:	89 44 24 04          	mov    %eax,0x4(%esp)
  94:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  9b:	e8 40 04 00 00       	call   4e0 <printf>
  a0:	eb ce                	jmp    70 <main+0x70>

  for(;;){
    printf(1, "init: starting sh\n");
    pid = fork();
    if(pid < 0){
      printf(1, "init: fork failed\n");
  a2:	c7 44 24 04 5b 08 00 	movl   $0x85b,0x4(%esp)
  a9:	00 
  aa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  b1:	e8 2a 04 00 00       	call   4e0 <printf>
      exit(0);
  b6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  bd:	e8 a6 02 00 00       	call   368 <exit>
    }
    if(pid == 0){
      exec("sh", argv);
  c2:	c7 44 24 04 24 0b 00 	movl   $0xb24,0x4(%esp)
  c9:	00 
  ca:	c7 04 24 6e 08 00 00 	movl   $0x86e,(%esp)
  d1:	e8 ca 02 00 00       	call   3a0 <exec>
      printf(1, "init: exec sh failed\n");
  d6:	c7 44 24 04 71 08 00 	movl   $0x871,0x4(%esp)
  dd:	00 
  de:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  e5:	e8 f6 03 00 00       	call   4e0 <printf>
      exit(0);
  ea:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  f1:	e8 72 02 00 00       	call   368 <exit>
main(void)
{
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
    mknod("console", 1, 1);
  f6:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  fd:	00 
  fe:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
 105:	00 
 106:	c7 04 24 40 08 00 00 	movl   $0x840,(%esp)
 10d:	e8 9e 02 00 00       	call   3b0 <mknod>
    open("console", O_RDWR);
 112:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
 119:	00 
 11a:	c7 04 24 40 08 00 00 	movl   $0x840,(%esp)
 121:	e8 82 02 00 00       	call   3a8 <open>
 126:	e9 fc fe ff ff       	jmp    27 <main+0x27>
 12b:	66 90                	xchg   %ax,%ax
 12d:	66 90                	xchg   %ax,%ax
 12f:	90                   	nop

00000130 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	8b 45 08             	mov    0x8(%ebp),%eax
 136:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 139:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 13a:	89 c2                	mov    %eax,%edx
 13c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 140:	41                   	inc    %ecx
 141:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 145:	42                   	inc    %edx
 146:	84 db                	test   %bl,%bl
 148:	88 5a ff             	mov    %bl,-0x1(%edx)
 14b:	75 f3                	jne    140 <strcpy+0x10>
    ;
  return os;
}
 14d:	5b                   	pop    %ebx
 14e:	5d                   	pop    %ebp
 14f:	c3                   	ret    

00000150 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	8b 4d 08             	mov    0x8(%ebp),%ecx
 156:	56                   	push   %esi
 157:	53                   	push   %ebx
 158:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 15b:	0f b6 01             	movzbl (%ecx),%eax
 15e:	0f b6 13             	movzbl (%ebx),%edx
 161:	84 c0                	test   %al,%al
 163:	75 1c                	jne    181 <strcmp+0x31>
 165:	eb 29                	jmp    190 <strcmp+0x40>
 167:	89 f6                	mov    %esi,%esi
 169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 170:	41                   	inc    %ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 171:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 174:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 177:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 17b:	84 c0                	test   %al,%al
 17d:	74 11                	je     190 <strcmp+0x40>
 17f:	89 f3                	mov    %esi,%ebx
 181:	38 d0                	cmp    %dl,%al
 183:	74 eb                	je     170 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 185:	5b                   	pop    %ebx
int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    p++, q++;
  return (uchar)*p - (uchar)*q;
 186:	29 d0                	sub    %edx,%eax
}
 188:	5e                   	pop    %esi
 189:	5d                   	pop    %ebp
 18a:	c3                   	ret    
 18b:	90                   	nop
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 190:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 191:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 193:	29 d0                	sub    %edx,%eax
}
 195:	5e                   	pop    %esi
 196:	5d                   	pop    %ebp
 197:	c3                   	ret    
 198:	90                   	nop
 199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001a0 <strlen>:

uint
strlen(const char *s)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1a6:	80 39 00             	cmpb   $0x0,(%ecx)
 1a9:	74 10                	je     1bb <strlen+0x1b>
 1ab:	31 d2                	xor    %edx,%edx
 1ad:	8d 76 00             	lea    0x0(%esi),%esi
 1b0:	42                   	inc    %edx
 1b1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1b5:	89 d0                	mov    %edx,%eax
 1b7:	75 f7                	jne    1b0 <strlen+0x10>
    ;
  return n;
}
 1b9:	5d                   	pop    %ebp
 1ba:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 1bb:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 1bd:	5d                   	pop    %ebp
 1be:	c3                   	ret    
 1bf:	90                   	nop

000001c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 55 08             	mov    0x8(%ebp),%edx
 1c6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 1cd:	89 d7                	mov    %edx,%edi
 1cf:	fc                   	cld    
 1d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1d2:	5f                   	pop    %edi
 1d3:	89 d0                	mov    %edx,%eax
 1d5:	5d                   	pop    %ebp
 1d6:	c3                   	ret    
 1d7:	89 f6                	mov    %esi,%esi
 1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001e0 <strchr>:

char*
strchr(const char *s, char c)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1ea:	0f b6 10             	movzbl (%eax),%edx
 1ed:	84 d2                	test   %dl,%dl
 1ef:	74 1b                	je     20c <strchr+0x2c>
    if(*s == c)
 1f1:	38 d1                	cmp    %dl,%cl
 1f3:	75 0f                	jne    204 <strchr+0x24>
 1f5:	eb 17                	jmp    20e <strchr+0x2e>
 1f7:	89 f6                	mov    %esi,%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 200:	38 ca                	cmp    %cl,%dl
 202:	74 0a                	je     20e <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 204:	40                   	inc    %eax
 205:	0f b6 10             	movzbl (%eax),%edx
 208:	84 d2                	test   %dl,%dl
 20a:	75 f4                	jne    200 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 20c:	31 c0                	xor    %eax,%eax
}
 20e:	5d                   	pop    %ebp
 20f:	c3                   	ret    

00000210 <gets>:

char*
gets(char *buf, int max)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	57                   	push   %edi
 214:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 215:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
 217:	53                   	push   %ebx
 218:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 21b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 21e:	eb 32                	jmp    252 <gets+0x42>
    cc = read(0, &c, 1);
 220:	b8 01 00 00 00       	mov    $0x1,%eax
 225:	89 44 24 08          	mov    %eax,0x8(%esp)
 229:	89 7c 24 04          	mov    %edi,0x4(%esp)
 22d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 234:	e8 47 01 00 00       	call   380 <read>
    if(cc < 1)
 239:	85 c0                	test   %eax,%eax
 23b:	7e 1d                	jle    25a <gets+0x4a>
      break;
    buf[i++] = c;
 23d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 241:	89 de                	mov    %ebx,%esi
 243:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 246:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 248:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 24c:	74 22                	je     270 <gets+0x60>
 24e:	3c 0d                	cmp    $0xd,%al
 250:	74 1e                	je     270 <gets+0x60>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 252:	8d 5e 01             	lea    0x1(%esi),%ebx
 255:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 258:	7c c6                	jl     220 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 25a:	8b 45 08             	mov    0x8(%ebp),%eax
 25d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 261:	83 c4 2c             	add    $0x2c,%esp
 264:	5b                   	pop    %ebx
 265:	5e                   	pop    %esi
 266:	5f                   	pop    %edi
 267:	5d                   	pop    %ebp
 268:	c3                   	ret    
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 270:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 273:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 275:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 279:	83 c4 2c             	add    $0x2c,%esp
 27c:	5b                   	pop    %ebx
 27d:	5e                   	pop    %esi
 27e:	5f                   	pop    %edi
 27f:	5d                   	pop    %ebp
 280:	c3                   	ret    
 281:	eb 0d                	jmp    290 <stat>
 283:	90                   	nop
 284:	90                   	nop
 285:	90                   	nop
 286:	90                   	nop
 287:	90                   	nop
 288:	90                   	nop
 289:	90                   	nop
 28a:	90                   	nop
 28b:	90                   	nop
 28c:	90                   	nop
 28d:	90                   	nop
 28e:	90                   	nop
 28f:	90                   	nop

00000290 <stat>:

int
stat(const char *n, struct stat *st)
{
 290:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 291:	31 c0                	xor    %eax,%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 293:	89 e5                	mov    %esp,%ebp
 295:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 298:	89 44 24 04          	mov    %eax,0x4(%esp)
 29c:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 29f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 2a2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a5:	89 04 24             	mov    %eax,(%esp)
 2a8:	e8 fb 00 00 00       	call   3a8 <open>
  if(fd < 0)
 2ad:	85 c0                	test   %eax,%eax
 2af:	78 2f                	js     2e0 <stat+0x50>
 2b1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 2b3:	8b 45 0c             	mov    0xc(%ebp),%eax
 2b6:	89 1c 24             	mov    %ebx,(%esp)
 2b9:	89 44 24 04          	mov    %eax,0x4(%esp)
 2bd:	e8 fe 00 00 00       	call   3c0 <fstat>
  close(fd);
 2c2:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 2c5:	89 c6                	mov    %eax,%esi
  close(fd);
 2c7:	e8 c4 00 00 00       	call   390 <close>
  return r;
 2cc:	89 f0                	mov    %esi,%eax
}
 2ce:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 2d1:	8b 75 fc             	mov    -0x4(%ebp),%esi
 2d4:	89 ec                	mov    %ebp,%esp
 2d6:	5d                   	pop    %ebp
 2d7:	c3                   	ret    
 2d8:	90                   	nop
 2d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 2e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2e5:	eb e7                	jmp    2ce <stat+0x3e>
 2e7:	89 f6                	mov    %esi,%esi
 2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002f0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2f6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2f7:	0f be 11             	movsbl (%ecx),%edx
 2fa:	88 d0                	mov    %dl,%al
 2fc:	2c 30                	sub    $0x30,%al
 2fe:	3c 09                	cmp    $0x9,%al
 300:	b8 00 00 00 00       	mov    $0x0,%eax
 305:	77 1e                	ja     325 <atoi+0x35>
 307:	89 f6                	mov    %esi,%esi
 309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 310:	41                   	inc    %ecx
 311:	8d 04 80             	lea    (%eax,%eax,4),%eax
 314:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 318:	0f be 11             	movsbl (%ecx),%edx
 31b:	88 d3                	mov    %dl,%bl
 31d:	80 eb 30             	sub    $0x30,%bl
 320:	80 fb 09             	cmp    $0x9,%bl
 323:	76 eb                	jbe    310 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 325:	5b                   	pop    %ebx
 326:	5d                   	pop    %ebp
 327:	c3                   	ret    
 328:	90                   	nop
 329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000330 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	56                   	push   %esi
 334:	8b 45 08             	mov    0x8(%ebp),%eax
 337:	53                   	push   %ebx
 338:	8b 5d 10             	mov    0x10(%ebp),%ebx
 33b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 33e:	85 db                	test   %ebx,%ebx
 340:	7e 1a                	jle    35c <memmove+0x2c>
 342:	31 d2                	xor    %edx,%edx
 344:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 34a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 350:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 354:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 357:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 358:	39 da                	cmp    %ebx,%edx
 35a:	75 f4                	jne    350 <memmove+0x20>
    *dst++ = *src++;
  return vdst;
}
 35c:	5b                   	pop    %ebx
 35d:	5e                   	pop    %esi
 35e:	5d                   	pop    %ebp
 35f:	c3                   	ret    

00000360 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 360:	b8 01 00 00 00       	mov    $0x1,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <exit>:
SYSCALL(exit)
 368:	b8 02 00 00 00       	mov    $0x2,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <wait>:
SYSCALL(wait)
 370:	b8 03 00 00 00       	mov    $0x3,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <pipe>:
SYSCALL(pipe)
 378:	b8 04 00 00 00       	mov    $0x4,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <read>:
SYSCALL(read)
 380:	b8 05 00 00 00       	mov    $0x5,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <write>:
SYSCALL(write)
 388:	b8 10 00 00 00       	mov    $0x10,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <close>:
SYSCALL(close)
 390:	b8 15 00 00 00       	mov    $0x15,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <kill>:
SYSCALL(kill)
 398:	b8 06 00 00 00       	mov    $0x6,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <exec>:
SYSCALL(exec)
 3a0:	b8 07 00 00 00       	mov    $0x7,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <open>:
SYSCALL(open)
 3a8:	b8 0f 00 00 00       	mov    $0xf,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <mknod>:
SYSCALL(mknod)
 3b0:	b8 11 00 00 00       	mov    $0x11,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <unlink>:
SYSCALL(unlink)
 3b8:	b8 12 00 00 00       	mov    $0x12,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <fstat>:
SYSCALL(fstat)
 3c0:	b8 08 00 00 00       	mov    $0x8,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <link>:
SYSCALL(link)
 3c8:	b8 13 00 00 00       	mov    $0x13,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <mkdir>:
SYSCALL(mkdir)
 3d0:	b8 14 00 00 00       	mov    $0x14,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <chdir>:
SYSCALL(chdir)
 3d8:	b8 09 00 00 00       	mov    $0x9,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <dup>:
SYSCALL(dup)
 3e0:	b8 0a 00 00 00       	mov    $0xa,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <getpid>:
SYSCALL(getpid)
 3e8:	b8 0b 00 00 00       	mov    $0xb,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <sbrk>:
SYSCALL(sbrk)
 3f0:	b8 0c 00 00 00       	mov    $0xc,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <sleep>:
SYSCALL(sleep)
 3f8:	b8 0d 00 00 00       	mov    $0xd,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <uptime>:
SYSCALL(uptime)
 400:	b8 0e 00 00 00       	mov    $0xe,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <policy>:
SYSCALL(policy)
 408:	b8 17 00 00 00       	mov    $0x17,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <detach>:
SYSCALL(detach)
 410:	b8 16 00 00 00       	mov    $0x16,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <priority>:
SYSCALL(priority)
 418:	b8 18 00 00 00       	mov    $0x18,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <wait_stat>:
SYSCALL(wait_stat)
 420:	b8 19 00 00 00       	mov    $0x19,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    
 428:	66 90                	xchg   %ax,%ax
 42a:	66 90                	xchg   %ax,%ax
 42c:	66 90                	xchg   %ax,%ax
 42e:	66 90                	xchg   %ax,%ax

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
 479:	0f b6 92 98 08 00 00 	movzbl 0x898(%edx),%edx
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
 4b7:	e8 cc fe ff ff       	call   388 <write>
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
 52b:	e8 58 fe ff ff       	call   388 <write>
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
 596:	e8 ed fd ff ff       	call   388 <write>
 59b:	ba 01 00 00 00       	mov    $0x1,%edx
 5a0:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5a3:	89 54 24 08          	mov    %edx,0x8(%esp)
 5a7:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ab:	89 3c 24             	mov    %edi,(%esp)
 5ae:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 5b1:	e8 d2 fd ff ff       	call   388 <write>
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
 60b:	b8 90 08 00 00       	mov    $0x890,%eax
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
 637:	e8 4c fd ff ff       	call   388 <write>
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
 666:	e8 1d fd ff ff       	call   388 <write>
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
 6a4:	e8 df fc ff ff       	call   388 <write>
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
 6c1:	a1 2c 0b 00 00       	mov    0xb2c,%eax
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
 71a:	a3 2c 0b 00 00       	mov    %eax,0xb2c
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
 73f:	a3 2c 0b 00 00       	mov    %eax,0xb2c
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
 76c:	8b 15 2c 0b 00 00    	mov    0xb2c,%edx
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
 7b9:	39 05 2c 0b 00 00    	cmp    %eax,0xb2c
 7bf:	89 c2                	mov    %eax,%edx
 7c1:	75 ed                	jne    7b0 <malloc+0x50>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 7c3:	89 1c 24             	mov    %ebx,(%esp)
 7c6:	e8 25 fc ff ff       	call   3f0 <sbrk>
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
 7de:	8b 15 2c 0b 00 00    	mov    0xb2c,%edx
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
 7ff:	89 15 2c 0b 00 00    	mov    %edx,0xb2c
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
 816:	b8 30 0b 00 00       	mov    $0xb30,%eax
 81b:	ba 30 0b 00 00       	mov    $0xb30,%edx
    base.s.size = 0;
 820:	31 c9                	xor    %ecx,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 822:	a3 2c 0b 00 00       	mov    %eax,0xb2c
    base.s.size = 0;
 827:	b8 30 0b 00 00       	mov    $0xb30,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 82c:	89 15 30 0b 00 00    	mov    %edx,0xb30
    base.s.size = 0;
 832:	89 0d 34 0b 00 00    	mov    %ecx,0xb34
 838:	e9 4d ff ff ff       	jmp    78a <malloc+0x2a>
