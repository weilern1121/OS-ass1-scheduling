
_schedulingTest9:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#define DEBUG 0
char* j;

int executePriority(int thePriority,long long times,char* debugString);

int main(int argc, char *argv[]){  
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
    int numberOfEexecutes = 10;

    policy(3);
   4:	bb 0a 00 00 00       	mov    $0xa,%ebx
int main(int argc, char *argv[]){  
   9:	83 e4 f0             	and    $0xfffffff0,%esp
   c:	83 ec 10             	sub    $0x10,%esp
    policy(3);
   f:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
  16:	e8 1d 04 00 00       	call   438 <policy>
  1b:	90                   	nop
  1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

    for(int i = 0;i < numberOfEexecutes;i++){
        executePriority(0,999999,"Priority One\n");
  20:	b8 88 08 00 00       	mov    $0x888,%eax
  25:	89 44 24 0c          	mov    %eax,0xc(%esp)
  29:	b8 3f 42 0f 00       	mov    $0xf423f,%eax
  2e:	89 44 24 04          	mov    %eax,0x4(%esp)
  32:	31 c0                	xor    %eax,%eax
  34:	89 44 24 08          	mov    %eax,0x8(%esp)
  38:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3f:	e8 6c 00 00 00       	call   b0 <executePriority>
    for(int i = 0;i < numberOfEexecutes;i++){
  44:	4b                   	dec    %ebx
  45:	75 d9                	jne    20 <main+0x20>
  47:	bb 0a 00 00 00       	mov    $0xa,%ebx
  4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }

    for(int i = 0;i < numberOfEexecutes;i++){
        executePriority(9,999999,"Priority Two\n");
  50:	31 c0                	xor    %eax,%eax
  52:	ba 96 08 00 00       	mov    $0x896,%edx
  57:	b9 3f 42 0f 00       	mov    $0xf423f,%ecx
  5c:	89 54 24 0c          	mov    %edx,0xc(%esp)
  60:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  64:	89 44 24 08          	mov    %eax,0x8(%esp)
  68:	c7 04 24 09 00 00 00 	movl   $0x9,(%esp)
  6f:	e8 3c 00 00 00       	call   b0 <executePriority>
    for(int i = 0;i < numberOfEexecutes;i++){
  74:	4b                   	dec    %ebx
  75:	75 d9                	jne    50 <main+0x50>
  77:	bb 14 00 00 00       	mov    $0x14,%ebx
  7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }

    for(int i = 0;i < numberOfEexecutes * 2;i++){
        wait(null);
  80:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  87:	e8 14 03 00 00       	call   3a0 <wait>
    for(int i = 0;i < numberOfEexecutes * 2;i++){
  8c:	4b                   	dec    %ebx
  8d:	75 f1                	jne    80 <main+0x80>
    }

    printf(1,"\n");
  8f:	b8 86 08 00 00       	mov    $0x886,%eax
  94:	89 44 24 04          	mov    %eax,0x4(%esp)
  98:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  9f:	e8 5c 04 00 00       	call   500 <printf>

    exit(0);
  a4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  ab:	e8 e8 02 00 00       	call   398 <exit>

000000b0 <executePriority>:
}

int executePriority(int thePriority,long long times,char* debugString){
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	83 ec 28             	sub    $0x28,%esp
  b6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  b9:	89 75 f8             	mov    %esi,-0x8(%ebp)
  bc:	8b 75 0c             	mov    0xc(%ebp),%esi
  bf:	89 7d fc             	mov    %edi,-0x4(%ebp)
  c2:	8b 7d 10             	mov    0x10(%ebp),%edi
    int pid;

    if((pid = fork()) == 0){
  c5:	e8 c6 02 00 00       	call   390 <fork>
  ca:	83 f8 00             	cmp    $0x0,%eax
  cd:	89 c3                	mov    %eax,%ebx
  cf:	74 3d                	je     10e <executePriority+0x5e>

        printf(1,"%d",thePriority);

        exit(0);
    }
    else if(pid > 0){
  d1:	7e 15                	jle    e8 <executePriority+0x38>
    }
    else{
        printf(1,"fork failed\n");
        return 0;
    }
}
  d3:	89 d8                	mov    %ebx,%eax
  d5:	8b 75 f8             	mov    -0x8(%ebp),%esi
  d8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  db:	8b 7d fc             	mov    -0x4(%ebp),%edi
  de:	89 ec                	mov    %ebp,%esp
  e0:	5d                   	pop    %ebp
  e1:	c3                   	ret    
  e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(1,"fork failed\n");
  e8:	b8 7b 08 00 00       	mov    $0x87b,%eax
        return 0;
  ed:	31 db                	xor    %ebx,%ebx
        printf(1,"fork failed\n");
  ef:	89 44 24 04          	mov    %eax,0x4(%esp)
  f3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  fa:	e8 01 04 00 00       	call   500 <printf>
}
  ff:	89 d8                	mov    %ebx,%eax
 101:	8b 75 f8             	mov    -0x8(%ebp),%esi
 104:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 107:	8b 7d fc             	mov    -0x4(%ebp),%edi
 10a:	89 ec                	mov    %ebp,%esp
 10c:	5d                   	pop    %ebp
 10d:	c3                   	ret    
        priority(thePriority);
 10e:	8b 45 08             	mov    0x8(%ebp),%eax
 111:	89 04 24             	mov    %eax,(%esp)
 114:	e8 2f 03 00 00       	call   448 <priority>
        for(int i = 0;i < times;i++){
 119:	83 ff 00             	cmp    $0x0,%edi
 11c:	7c 20                	jl     13e <executePriority+0x8e>
 11e:	7e 45                	jle    165 <executePriority+0xb5>
            j = malloc(sizeof(char) * 100);
 120:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
        for(int i = 0;i < times;i++){
 127:	43                   	inc    %ebx
            j = malloc(sizeof(char) * 100);
 128:	e8 63 06 00 00       	call   790 <malloc>
            free(j);
 12d:	89 04 24             	mov    %eax,(%esp)
            j = malloc(sizeof(char) * 100);
 130:	a3 80 0b 00 00       	mov    %eax,0xb80
            free(j);
 135:	e8 b6 05 00 00       	call   6f0 <free>
        for(int i = 0;i < times;i++){
 13a:	39 f3                	cmp    %esi,%ebx
 13c:	75 e2                	jne    120 <executePriority+0x70>
        printf(1,"%d",thePriority);
 13e:	8b 45 08             	mov    0x8(%ebp),%eax
 141:	c7 44 24 04 78 08 00 	movl   $0x878,0x4(%esp)
 148:	00 
 149:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 150:	89 44 24 08          	mov    %eax,0x8(%esp)
 154:	e8 a7 03 00 00       	call   500 <printf>
        exit(0);
 159:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 160:	e8 33 02 00 00       	call   398 <exit>
        for(int i = 0;i < times;i++){
 165:	83 fe 00             	cmp    $0x0,%esi
 168:	76 d4                	jbe    13e <executePriority+0x8e>
 16a:	eb b4                	jmp    120 <executePriority+0x70>
 16c:	66 90                	xchg   %ax,%ax
 16e:	66 90                	xchg   %ax,%ax

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

00000438 <policy>:
SYSCALL(policy)
 438:	b8 17 00 00 00       	mov    $0x17,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <detach>:
SYSCALL(detach)
 440:	b8 16 00 00 00       	mov    $0x16,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <priority>:
SYSCALL(priority)
 448:	b8 18 00 00 00       	mov    $0x18,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <wait_stat>:
SYSCALL(wait_stat)
 450:	b8 19 00 00 00       	mov    $0x19,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    
 458:	66 90                	xchg   %ax,%ax
 45a:	66 90                	xchg   %ax,%ax
 45c:	66 90                	xchg   %ax,%ax
 45e:	66 90                	xchg   %ax,%ax

00000460 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	56                   	push   %esi
 465:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 466:	89 d3                	mov    %edx,%ebx
 468:	c1 eb 1f             	shr    $0x1f,%ebx
{
 46b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 46e:	84 db                	test   %bl,%bl
{
 470:	89 45 c0             	mov    %eax,-0x40(%ebp)
 473:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 475:	74 79                	je     4f0 <printint+0x90>
 477:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 47b:	74 73                	je     4f0 <printint+0x90>
    neg = 1;
    x = -xx;
 47d:	f7 d8                	neg    %eax
    neg = 1;
 47f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 486:	31 f6                	xor    %esi,%esi
 488:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 48b:	eb 05                	jmp    492 <printint+0x32>
 48d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 490:	89 fe                	mov    %edi,%esi
 492:	31 d2                	xor    %edx,%edx
 494:	f7 f1                	div    %ecx
 496:	8d 7e 01             	lea    0x1(%esi),%edi
 499:	0f b6 92 ac 08 00 00 	movzbl 0x8ac(%edx),%edx
  }while((x /= base) != 0);
 4a0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 4a2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 4a5:	75 e9                	jne    490 <printint+0x30>
  if(neg)
 4a7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 4aa:	85 d2                	test   %edx,%edx
 4ac:	74 08                	je     4b6 <printint+0x56>
    buf[i++] = '-';
 4ae:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 4b3:	8d 7e 02             	lea    0x2(%esi),%edi
 4b6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 4ba:	8b 7d c0             	mov    -0x40(%ebp),%edi
 4bd:	8d 76 00             	lea    0x0(%esi),%esi
 4c0:	0f b6 06             	movzbl (%esi),%eax
 4c3:	4e                   	dec    %esi
  write(fd, &c, 1);
 4c4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 4c8:	89 3c 24             	mov    %edi,(%esp)
 4cb:	88 45 d7             	mov    %al,-0x29(%ebp)
 4ce:	b8 01 00 00 00       	mov    $0x1,%eax
 4d3:	89 44 24 08          	mov    %eax,0x8(%esp)
 4d7:	e8 dc fe ff ff       	call   3b8 <write>

  while(--i >= 0)
 4dc:	39 de                	cmp    %ebx,%esi
 4de:	75 e0                	jne    4c0 <printint+0x60>
    putc(fd, buf[i]);
}
 4e0:	83 c4 4c             	add    $0x4c,%esp
 4e3:	5b                   	pop    %ebx
 4e4:	5e                   	pop    %esi
 4e5:	5f                   	pop    %edi
 4e6:	5d                   	pop    %ebp
 4e7:	c3                   	ret    
 4e8:	90                   	nop
 4e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 4f0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 4f7:	eb 8d                	jmp    486 <printint+0x26>
 4f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000500 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	57                   	push   %edi
 504:	56                   	push   %esi
 505:	53                   	push   %ebx
 506:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 509:	8b 75 0c             	mov    0xc(%ebp),%esi
 50c:	0f b6 1e             	movzbl (%esi),%ebx
 50f:	84 db                	test   %bl,%bl
 511:	0f 84 d1 00 00 00    	je     5e8 <printf+0xe8>
  state = 0;
 517:	31 ff                	xor    %edi,%edi
 519:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 51a:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 51d:	89 fa                	mov    %edi,%edx
 51f:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 522:	89 45 d0             	mov    %eax,-0x30(%ebp)
 525:	eb 41                	jmp    568 <printf+0x68>
 527:	89 f6                	mov    %esi,%esi
 529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 530:	83 f8 25             	cmp    $0x25,%eax
 533:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 536:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 53b:	74 1e                	je     55b <printf+0x5b>
  write(fd, &c, 1);
 53d:	b8 01 00 00 00       	mov    $0x1,%eax
 542:	89 44 24 08          	mov    %eax,0x8(%esp)
 546:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 549:	89 44 24 04          	mov    %eax,0x4(%esp)
 54d:	89 3c 24             	mov    %edi,(%esp)
 550:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 553:	e8 60 fe ff ff       	call   3b8 <write>
 558:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 55b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 55c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 560:	84 db                	test   %bl,%bl
 562:	0f 84 80 00 00 00    	je     5e8 <printf+0xe8>
    if(state == 0){
 568:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 56a:	0f be cb             	movsbl %bl,%ecx
 56d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 570:	74 be                	je     530 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 572:	83 fa 25             	cmp    $0x25,%edx
 575:	75 e4                	jne    55b <printf+0x5b>
      if(c == 'd'){
 577:	83 f8 64             	cmp    $0x64,%eax
 57a:	0f 84 f0 00 00 00    	je     670 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 580:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 586:	83 f9 70             	cmp    $0x70,%ecx
 589:	74 65                	je     5f0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 58b:	83 f8 73             	cmp    $0x73,%eax
 58e:	0f 84 8c 00 00 00    	je     620 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 594:	83 f8 63             	cmp    $0x63,%eax
 597:	0f 84 13 01 00 00    	je     6b0 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 59d:	83 f8 25             	cmp    $0x25,%eax
 5a0:	0f 84 e2 00 00 00    	je     688 <printf+0x188>
  write(fd, &c, 1);
 5a6:	b8 01 00 00 00       	mov    $0x1,%eax
 5ab:	46                   	inc    %esi
 5ac:	89 44 24 08          	mov    %eax,0x8(%esp)
 5b0:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5b3:	89 44 24 04          	mov    %eax,0x4(%esp)
 5b7:	89 3c 24             	mov    %edi,(%esp)
 5ba:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5be:	e8 f5 fd ff ff       	call   3b8 <write>
 5c3:	ba 01 00 00 00       	mov    $0x1,%edx
 5c8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5cb:	89 54 24 08          	mov    %edx,0x8(%esp)
 5cf:	89 44 24 04          	mov    %eax,0x4(%esp)
 5d3:	89 3c 24             	mov    %edi,(%esp)
 5d6:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 5d9:	e8 da fd ff ff       	call   3b8 <write>
  for(i = 0; fmt[i]; i++){
 5de:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5e2:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 5e4:	84 db                	test   %bl,%bl
 5e6:	75 80                	jne    568 <printf+0x68>
    }
  }
}
 5e8:	83 c4 3c             	add    $0x3c,%esp
 5eb:	5b                   	pop    %ebx
 5ec:	5e                   	pop    %esi
 5ed:	5f                   	pop    %edi
 5ee:	5d                   	pop    %ebp
 5ef:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 5f0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 5f7:	b9 10 00 00 00       	mov    $0x10,%ecx
 5fc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5ff:	89 f8                	mov    %edi,%eax
 601:	8b 13                	mov    (%ebx),%edx
 603:	e8 58 fe ff ff       	call   460 <printint>
        ap++;
 608:	89 d8                	mov    %ebx,%eax
      state = 0;
 60a:	31 d2                	xor    %edx,%edx
        ap++;
 60c:	83 c0 04             	add    $0x4,%eax
 60f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 612:	e9 44 ff ff ff       	jmp    55b <printf+0x5b>
 617:	89 f6                	mov    %esi,%esi
 619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 620:	8b 45 d0             	mov    -0x30(%ebp),%eax
 623:	8b 10                	mov    (%eax),%edx
        ap++;
 625:	83 c0 04             	add    $0x4,%eax
 628:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 62b:	85 d2                	test   %edx,%edx
 62d:	0f 84 aa 00 00 00    	je     6dd <printf+0x1dd>
        while(*s != 0){
 633:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 636:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 638:	84 c0                	test   %al,%al
 63a:	74 27                	je     663 <printf+0x163>
 63c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 640:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 643:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 648:	43                   	inc    %ebx
  write(fd, &c, 1);
 649:	89 44 24 08          	mov    %eax,0x8(%esp)
 64d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 650:	89 44 24 04          	mov    %eax,0x4(%esp)
 654:	89 3c 24             	mov    %edi,(%esp)
 657:	e8 5c fd ff ff       	call   3b8 <write>
        while(*s != 0){
 65c:	0f b6 03             	movzbl (%ebx),%eax
 65f:	84 c0                	test   %al,%al
 661:	75 dd                	jne    640 <printf+0x140>
      state = 0;
 663:	31 d2                	xor    %edx,%edx
 665:	e9 f1 fe ff ff       	jmp    55b <printf+0x5b>
 66a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 670:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 677:	b9 0a 00 00 00       	mov    $0xa,%ecx
 67c:	e9 7b ff ff ff       	jmp    5fc <printf+0xfc>
 681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 688:	b9 01 00 00 00       	mov    $0x1,%ecx
 68d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 690:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 694:	89 44 24 04          	mov    %eax,0x4(%esp)
 698:	89 3c 24             	mov    %edi,(%esp)
 69b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 69e:	e8 15 fd ff ff       	call   3b8 <write>
      state = 0;
 6a3:	31 d2                	xor    %edx,%edx
 6a5:	e9 b1 fe ff ff       	jmp    55b <printf+0x5b>
 6aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 6b0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 6b3:	8b 03                	mov    (%ebx),%eax
        ap++;
 6b5:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 6b8:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 6bb:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 6be:	b8 01 00 00 00       	mov    $0x1,%eax
 6c3:	89 44 24 08          	mov    %eax,0x8(%esp)
 6c7:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6ca:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ce:	e8 e5 fc ff ff       	call   3b8 <write>
      state = 0;
 6d3:	31 d2                	xor    %edx,%edx
        ap++;
 6d5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 6d8:	e9 7e fe ff ff       	jmp    55b <printf+0x5b>
          s = "(null)";
 6dd:	bb a4 08 00 00       	mov    $0x8a4,%ebx
        while(*s != 0){
 6e2:	b0 28                	mov    $0x28,%al
 6e4:	e9 57 ff ff ff       	jmp    640 <printf+0x140>
 6e9:	66 90                	xchg   %ax,%ax
 6eb:	66 90                	xchg   %ax,%ax
 6ed:	66 90                	xchg   %ax,%ax
 6ef:	90                   	nop

000006f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f1:	a1 74 0b 00 00       	mov    0xb74,%eax
{
 6f6:	89 e5                	mov    %esp,%ebp
 6f8:	57                   	push   %edi
 6f9:	56                   	push   %esi
 6fa:	53                   	push   %ebx
 6fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 6fe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 701:	eb 0d                	jmp    710 <free+0x20>
 703:	90                   	nop
 704:	90                   	nop
 705:	90                   	nop
 706:	90                   	nop
 707:	90                   	nop
 708:	90                   	nop
 709:	90                   	nop
 70a:	90                   	nop
 70b:	90                   	nop
 70c:	90                   	nop
 70d:	90                   	nop
 70e:	90                   	nop
 70f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 710:	39 c8                	cmp    %ecx,%eax
 712:	8b 10                	mov    (%eax),%edx
 714:	73 32                	jae    748 <free+0x58>
 716:	39 d1                	cmp    %edx,%ecx
 718:	72 04                	jb     71e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 71a:	39 d0                	cmp    %edx,%eax
 71c:	72 32                	jb     750 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 71e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 721:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 724:	39 fa                	cmp    %edi,%edx
 726:	74 30                	je     758 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 728:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 72b:	8b 50 04             	mov    0x4(%eax),%edx
 72e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 731:	39 f1                	cmp    %esi,%ecx
 733:	74 3c                	je     771 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 735:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 737:	5b                   	pop    %ebx
  freep = p;
 738:	a3 74 0b 00 00       	mov    %eax,0xb74
}
 73d:	5e                   	pop    %esi
 73e:	5f                   	pop    %edi
 73f:	5d                   	pop    %ebp
 740:	c3                   	ret    
 741:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 748:	39 d0                	cmp    %edx,%eax
 74a:	72 04                	jb     750 <free+0x60>
 74c:	39 d1                	cmp    %edx,%ecx
 74e:	72 ce                	jb     71e <free+0x2e>
{
 750:	89 d0                	mov    %edx,%eax
 752:	eb bc                	jmp    710 <free+0x20>
 754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 758:	8b 7a 04             	mov    0x4(%edx),%edi
 75b:	01 fe                	add    %edi,%esi
 75d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 760:	8b 10                	mov    (%eax),%edx
 762:	8b 12                	mov    (%edx),%edx
 764:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 767:	8b 50 04             	mov    0x4(%eax),%edx
 76a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 76d:	39 f1                	cmp    %esi,%ecx
 76f:	75 c4                	jne    735 <free+0x45>
    p->s.size += bp->s.size;
 771:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 774:	a3 74 0b 00 00       	mov    %eax,0xb74
    p->s.size += bp->s.size;
 779:	01 ca                	add    %ecx,%edx
 77b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 77e:	8b 53 f8             	mov    -0x8(%ebx),%edx
 781:	89 10                	mov    %edx,(%eax)
}
 783:	5b                   	pop    %ebx
 784:	5e                   	pop    %esi
 785:	5f                   	pop    %edi
 786:	5d                   	pop    %ebp
 787:	c3                   	ret    
 788:	90                   	nop
 789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000790 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	57                   	push   %edi
 794:	56                   	push   %esi
 795:	53                   	push   %ebx
 796:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 799:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 79c:	8b 15 74 0b 00 00    	mov    0xb74,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a2:	8d 78 07             	lea    0x7(%eax),%edi
 7a5:	c1 ef 03             	shr    $0x3,%edi
 7a8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 7a9:	85 d2                	test   %edx,%edx
 7ab:	0f 84 8f 00 00 00    	je     840 <malloc+0xb0>
 7b1:	8b 02                	mov    (%edx),%eax
 7b3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7b6:	39 cf                	cmp    %ecx,%edi
 7b8:	76 66                	jbe    820 <malloc+0x90>
 7ba:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 7c0:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7c5:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 7c8:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7cf:	eb 10                	jmp    7e1 <malloc+0x51>
 7d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7da:	8b 48 04             	mov    0x4(%eax),%ecx
 7dd:	39 f9                	cmp    %edi,%ecx
 7df:	73 3f                	jae    820 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7e1:	39 05 74 0b 00 00    	cmp    %eax,0xb74
 7e7:	89 c2                	mov    %eax,%edx
 7e9:	75 ed                	jne    7d8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 7eb:	89 34 24             	mov    %esi,(%esp)
 7ee:	e8 2d fc ff ff       	call   420 <sbrk>
  if(p == (char*)-1)
 7f3:	83 f8 ff             	cmp    $0xffffffff,%eax
 7f6:	74 18                	je     810 <malloc+0x80>
  hp->s.size = nu;
 7f8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7fb:	83 c0 08             	add    $0x8,%eax
 7fe:	89 04 24             	mov    %eax,(%esp)
 801:	e8 ea fe ff ff       	call   6f0 <free>
  return freep;
 806:	8b 15 74 0b 00 00    	mov    0xb74,%edx
      if((p = morecore(nunits)) == 0)
 80c:	85 d2                	test   %edx,%edx
 80e:	75 c8                	jne    7d8 <malloc+0x48>
        return 0;
  }
}
 810:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 813:	31 c0                	xor    %eax,%eax
}
 815:	5b                   	pop    %ebx
 816:	5e                   	pop    %esi
 817:	5f                   	pop    %edi
 818:	5d                   	pop    %ebp
 819:	c3                   	ret    
 81a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 820:	39 cf                	cmp    %ecx,%edi
 822:	74 4c                	je     870 <malloc+0xe0>
        p->s.size -= nunits;
 824:	29 f9                	sub    %edi,%ecx
 826:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 829:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 82c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 82f:	89 15 74 0b 00 00    	mov    %edx,0xb74
}
 835:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 838:	83 c0 08             	add    $0x8,%eax
}
 83b:	5b                   	pop    %ebx
 83c:	5e                   	pop    %esi
 83d:	5f                   	pop    %edi
 83e:	5d                   	pop    %ebp
 83f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 840:	b8 78 0b 00 00       	mov    $0xb78,%eax
 845:	ba 78 0b 00 00       	mov    $0xb78,%edx
    base.s.size = 0;
 84a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 84c:	a3 74 0b 00 00       	mov    %eax,0xb74
    base.s.size = 0;
 851:	b8 78 0b 00 00       	mov    $0xb78,%eax
    base.s.ptr = freep = prevp = &base;
 856:	89 15 78 0b 00 00    	mov    %edx,0xb78
    base.s.size = 0;
 85c:	89 0d 7c 0b 00 00    	mov    %ecx,0xb7c
 862:	e9 53 ff ff ff       	jmp    7ba <malloc+0x2a>
 867:	89 f6                	mov    %esi,%esi
 869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 870:	8b 08                	mov    (%eax),%ecx
 872:	89 0a                	mov    %ecx,(%edx)
 874:	eb b9                	jmp    82f <malloc+0x9f>
