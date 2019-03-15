
_grep:     file format elf32-i386


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
   9:	83 ec 20             	sub    $0x20,%esp
  int fd, i;
  char *pattern;

  if(argc <= 1){
   c:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
{
  10:	8b 55 0c             	mov    0xc(%ebp),%edx
  if(argc <= 1){
  13:	0f 8e 89 00 00 00    	jle    a2 <main+0xa2>
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];

  if(argc <= 2){
  19:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
  pattern = argv[1];
  1d:	8b 7a 04             	mov    0x4(%edx),%edi
  if(argc <= 2){
  20:	74 4c                	je     6e <main+0x6e>
  22:	8d 72 08             	lea    0x8(%edx),%esi
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
  25:	bb 02 00 00 00       	mov    $0x2,%ebx
  2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if((fd = open(argv[i], 0)) < 0){
  30:	31 c0                	xor    %eax,%eax
  32:	89 44 24 04          	mov    %eax,0x4(%esp)
  36:	8b 06                	mov    (%esi),%eax
  38:	89 04 24             	mov    %eax,(%esp)
  3b:	e8 58 05 00 00       	call   598 <open>
  40:	85 c0                	test   %eax,%eax
  42:	78 3f                	js     83 <main+0x83>
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
  44:	89 44 24 04          	mov    %eax,0x4(%esp)
  for(i = 2; i < argc; i++){
  48:	43                   	inc    %ebx
  49:	83 c6 04             	add    $0x4,%esi
    grep(pattern, fd);
  4c:	89 3c 24             	mov    %edi,(%esp)
  4f:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  53:	e8 d8 01 00 00       	call   230 <grep>
    close(fd);
  58:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  5c:	89 04 24             	mov    %eax,(%esp)
  5f:	e8 1c 05 00 00       	call   580 <close>
  for(i = 2; i < argc; i++){
  64:	39 5d 08             	cmp    %ebx,0x8(%ebp)
  67:	7f c7                	jg     30 <main+0x30>
  }
  exit();
  69:	e8 ea 04 00 00       	call   558 <exit>
    grep(pattern, 0);
  6e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  75:	00 
  76:	89 3c 24             	mov    %edi,(%esp)
  79:	e8 b2 01 00 00       	call   230 <grep>
    exit();
  7e:	e8 d5 04 00 00       	call   558 <exit>
      printf(1, "grep: cannot open %s\n", argv[i]);
  83:	8b 06                	mov    (%esi),%eax
  85:	c7 44 24 04 38 0a 00 	movl   $0xa38,0x4(%esp)
  8c:	00 
  8d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  94:	89 44 24 08          	mov    %eax,0x8(%esp)
  98:	e8 03 06 00 00       	call   6a0 <printf>
      exit();
  9d:	e8 b6 04 00 00       	call   558 <exit>
    printf(2, "usage: grep pattern [file ...]\n");
  a2:	c7 44 24 04 18 0a 00 	movl   $0xa18,0x4(%esp)
  a9:	00 
  aa:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  b1:	e8 ea 05 00 00       	call   6a0 <printf>
    exit();
  b6:	e8 9d 04 00 00       	call   558 <exit>
  bb:	66 90                	xchg   %ax,%ax
  bd:	66 90                	xchg   %ax,%ax
  bf:	90                   	nop

000000c0 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	57                   	push   %edi
  c4:	56                   	push   %esi
  c5:	53                   	push   %ebx
  c6:	83 ec 1c             	sub    $0x1c,%esp
  c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  cc:	8b 75 0c             	mov    0xc(%ebp),%esi
  cf:	8b 7d 10             	mov    0x10(%ebp),%edi
  d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
  e0:	89 7c 24 04          	mov    %edi,0x4(%esp)
  e4:	89 34 24             	mov    %esi,(%esp)
  e7:	e8 34 00 00 00       	call   120 <matchhere>
  ec:	85 c0                	test   %eax,%eax
  ee:	75 20                	jne    110 <matchstar+0x50>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  f0:	0f be 17             	movsbl (%edi),%edx
  f3:	84 d2                	test   %dl,%dl
  f5:	74 0a                	je     101 <matchstar+0x41>
  f7:	47                   	inc    %edi
  f8:	39 da                	cmp    %ebx,%edx
  fa:	74 e4                	je     e0 <matchstar+0x20>
  fc:	83 fb 2e             	cmp    $0x2e,%ebx
  ff:	74 df                	je     e0 <matchstar+0x20>
  return 0;
}
 101:	83 c4 1c             	add    $0x1c,%esp
 104:	5b                   	pop    %ebx
 105:	5e                   	pop    %esi
 106:	5f                   	pop    %edi
 107:	5d                   	pop    %ebp
 108:	c3                   	ret    
 109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 110:	83 c4 1c             	add    $0x1c,%esp
      return 1;
 113:	b8 01 00 00 00       	mov    $0x1,%eax
}
 118:	5b                   	pop    %ebx
 119:	5e                   	pop    %esi
 11a:	5f                   	pop    %edi
 11b:	5d                   	pop    %ebp
 11c:	c3                   	ret    
 11d:	8d 76 00             	lea    0x0(%esi),%esi

00000120 <matchhere>:
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	57                   	push   %edi
 124:	56                   	push   %esi
 125:	53                   	push   %ebx
 126:	83 ec 1c             	sub    $0x1c,%esp
 129:	8b 55 08             	mov    0x8(%ebp),%edx
 12c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(re[0] == '\0')
 12f:	0f b6 0a             	movzbl (%edx),%ecx
 132:	84 c9                	test   %cl,%cl
 134:	74 61                	je     197 <matchhere+0x77>
  if(re[1] == '*')
 136:	0f be 42 01          	movsbl 0x1(%edx),%eax
 13a:	3c 2a                	cmp    $0x2a,%al
 13c:	74 66                	je     1a4 <matchhere+0x84>
  if(re[0] == '$' && re[1] == '\0')
 13e:	80 f9 24             	cmp    $0x24,%cl
 141:	0f b6 1f             	movzbl (%edi),%ebx
 144:	75 04                	jne    14a <matchhere+0x2a>
 146:	84 c0                	test   %al,%al
 148:	74 7e                	je     1c8 <matchhere+0xa8>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 14a:	84 db                	test   %bl,%bl
 14c:	74 09                	je     157 <matchhere+0x37>
 14e:	38 d9                	cmp    %bl,%cl
 150:	74 3d                	je     18f <matchhere+0x6f>
 152:	80 f9 2e             	cmp    $0x2e,%cl
 155:	74 38                	je     18f <matchhere+0x6f>
}
 157:	83 c4 1c             	add    $0x1c,%esp
  return 0;
 15a:	31 c0                	xor    %eax,%eax
}
 15c:	5b                   	pop    %ebx
 15d:	5e                   	pop    %esi
 15e:	5f                   	pop    %edi
 15f:	5d                   	pop    %ebp
 160:	c3                   	ret    
 161:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(re[1] == '*')
 168:	0f b6 4a 01          	movzbl 0x1(%edx),%ecx
 16c:	80 f9 2a             	cmp    $0x2a,%cl
 16f:	74 38                	je     1a9 <matchhere+0x89>
  if(re[0] == '$' && re[1] == '\0')
 171:	3c 24                	cmp    $0x24,%al
 173:	75 04                	jne    179 <matchhere+0x59>
 175:	84 c9                	test   %cl,%cl
 177:	74 4b                	je     1c4 <matchhere+0xa4>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 179:	0f b6 1e             	movzbl (%esi),%ebx
 17c:	84 db                	test   %bl,%bl
 17e:	66 90                	xchg   %ax,%ax
 180:	74 d5                	je     157 <matchhere+0x37>
 182:	3c 2e                	cmp    $0x2e,%al
 184:	89 f7                	mov    %esi,%edi
 186:	74 04                	je     18c <matchhere+0x6c>
 188:	38 c3                	cmp    %al,%bl
 18a:	75 cb                	jne    157 <matchhere+0x37>
 18c:	0f be c1             	movsbl %cl,%eax
    return matchhere(re+1, text+1);
 18f:	42                   	inc    %edx
  if(re[0] == '\0')
 190:	84 c0                	test   %al,%al
    return matchhere(re+1, text+1);
 192:	8d 77 01             	lea    0x1(%edi),%esi
  if(re[0] == '\0')
 195:	75 d1                	jne    168 <matchhere+0x48>
    return 1;
 197:	b8 01 00 00 00       	mov    $0x1,%eax
}
 19c:	83 c4 1c             	add    $0x1c,%esp
 19f:	5b                   	pop    %ebx
 1a0:	5e                   	pop    %esi
 1a1:	5f                   	pop    %edi
 1a2:	5d                   	pop    %ebp
 1a3:	c3                   	ret    
  if(re[1] == '*')
 1a4:	89 fe                	mov    %edi,%esi
 1a6:	0f be c1             	movsbl %cl,%eax
    return matchstar(re[0], re+2, text);
 1a9:	83 c2 02             	add    $0x2,%edx
 1ac:	89 74 24 08          	mov    %esi,0x8(%esp)
 1b0:	89 54 24 04          	mov    %edx,0x4(%esp)
 1b4:	89 04 24             	mov    %eax,(%esp)
 1b7:	e8 04 ff ff ff       	call   c0 <matchstar>
}
 1bc:	83 c4 1c             	add    $0x1c,%esp
 1bf:	5b                   	pop    %ebx
 1c0:	5e                   	pop    %esi
 1c1:	5f                   	pop    %edi
 1c2:	5d                   	pop    %ebp
 1c3:	c3                   	ret    
 1c4:	0f b6 5f 01          	movzbl 0x1(%edi),%ebx
    return *text == '\0';
 1c8:	31 c0                	xor    %eax,%eax
 1ca:	84 db                	test   %bl,%bl
 1cc:	0f 94 c0             	sete   %al
 1cf:	eb cb                	jmp    19c <matchhere+0x7c>
 1d1:	eb 0d                	jmp    1e0 <match>
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

000001e0 <match>:
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	56                   	push   %esi
 1e4:	53                   	push   %ebx
 1e5:	83 ec 10             	sub    $0x10,%esp
 1e8:	8b 75 08             	mov    0x8(%ebp),%esi
 1eb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '^')
 1ee:	80 3e 5e             	cmpb   $0x5e,(%esi)
 1f1:	75 0c                	jne    1ff <match+0x1f>
 1f3:	eb 2b                	jmp    220 <match+0x40>
 1f5:	8d 76 00             	lea    0x0(%esi),%esi
  }while(*text++ != '\0');
 1f8:	43                   	inc    %ebx
 1f9:	80 7b ff 00          	cmpb   $0x0,-0x1(%ebx)
 1fd:	74 15                	je     214 <match+0x34>
    if(matchhere(re, text))
 1ff:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 203:	89 34 24             	mov    %esi,(%esp)
 206:	e8 15 ff ff ff       	call   120 <matchhere>
 20b:	85 c0                	test   %eax,%eax
 20d:	74 e9                	je     1f8 <match+0x18>
      return 1;
 20f:	b8 01 00 00 00       	mov    $0x1,%eax
}
 214:	83 c4 10             	add    $0x10,%esp
 217:	5b                   	pop    %ebx
 218:	5e                   	pop    %esi
 219:	5d                   	pop    %ebp
 21a:	c3                   	ret    
 21b:	90                   	nop
 21c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return matchhere(re+1, text);
 220:	46                   	inc    %esi
 221:	89 75 08             	mov    %esi,0x8(%ebp)
}
 224:	83 c4 10             	add    $0x10,%esp
 227:	5b                   	pop    %ebx
 228:	5e                   	pop    %esi
 229:	5d                   	pop    %ebp
    return matchhere(re+1, text);
 22a:	e9 f1 fe ff ff       	jmp    120 <matchhere>
 22f:	90                   	nop

00000230 <grep>:
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	57                   	push   %edi
 234:	56                   	push   %esi
  m = 0;
 235:	31 f6                	xor    %esi,%esi
{
 237:	53                   	push   %ebx
 238:	83 ec 2c             	sub    $0x2c,%esp
 23b:	90                   	nop
 23c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 240:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 245:	29 f0                	sub    %esi,%eax
 247:	89 44 24 08          	mov    %eax,0x8(%esp)
 24b:	8d 86 00 0e 00 00    	lea    0xe00(%esi),%eax
 251:	89 44 24 04          	mov    %eax,0x4(%esp)
 255:	8b 45 0c             	mov    0xc(%ebp),%eax
 258:	89 04 24             	mov    %eax,(%esp)
 25b:	e8 10 03 00 00       	call   570 <read>
 260:	85 c0                	test   %eax,%eax
 262:	0f 8e b8 00 00 00    	jle    320 <grep+0xf0>
    m += n;
 268:	01 c6                	add    %eax,%esi
    p = buf;
 26a:	bf 00 0e 00 00       	mov    $0xe00,%edi
    buf[m] = '\0';
 26f:	c6 86 00 0e 00 00 00 	movb   $0x0,0xe00(%esi)
 276:	89 75 e0             	mov    %esi,-0x20(%ebp)
 279:	8b 75 08             	mov    0x8(%ebp),%esi
 27c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while((q = strchr(p, '\n')) != 0){
 280:	b8 0a 00 00 00       	mov    $0xa,%eax
 285:	89 44 24 04          	mov    %eax,0x4(%esp)
 289:	89 3c 24             	mov    %edi,(%esp)
 28c:	e8 4f 01 00 00       	call   3e0 <strchr>
 291:	85 c0                	test   %eax,%eax
 293:	89 c3                	mov    %eax,%ebx
 295:	74 49                	je     2e0 <grep+0xb0>
      *q = 0;
 297:	c6 03 00             	movb   $0x0,(%ebx)
      if(match(pattern, p)){
 29a:	89 7c 24 04          	mov    %edi,0x4(%esp)
 29e:	89 34 24             	mov    %esi,(%esp)
 2a1:	e8 3a ff ff ff       	call   1e0 <match>
 2a6:	8d 4b 01             	lea    0x1(%ebx),%ecx
 2a9:	85 c0                	test   %eax,%eax
 2ab:	75 0b                	jne    2b8 <grep+0x88>
      p = q+1;
 2ad:	89 cf                	mov    %ecx,%edi
 2af:	eb cf                	jmp    280 <grep+0x50>
 2b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        write(1, p, q+1 - p);
 2b8:	89 c8                	mov    %ecx,%eax
 2ba:	29 f8                	sub    %edi,%eax
        *q = '\n';
 2bc:	c6 03 0a             	movb   $0xa,(%ebx)
        write(1, p, q+1 - p);
 2bf:	89 7c 24 04          	mov    %edi,0x4(%esp)
 2c3:	89 44 24 08          	mov    %eax,0x8(%esp)
 2c7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2ce:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 2d1:	e8 a2 02 00 00       	call   578 <write>
 2d6:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
      p = q+1;
 2d9:	89 cf                	mov    %ecx,%edi
 2db:	eb a3                	jmp    280 <grep+0x50>
 2dd:	8d 76 00             	lea    0x0(%esi),%esi
    if(p == buf)
 2e0:	81 ff 00 0e 00 00    	cmp    $0xe00,%edi
 2e6:	8b 75 e0             	mov    -0x20(%ebp),%esi
 2e9:	74 2d                	je     318 <grep+0xe8>
    if(m > 0){
 2eb:	85 f6                	test   %esi,%esi
 2ed:	0f 8e 4d ff ff ff    	jle    240 <grep+0x10>
      m -= p - buf;
 2f3:	89 f8                	mov    %edi,%eax
 2f5:	2d 00 0e 00 00       	sub    $0xe00,%eax
 2fa:	29 c6                	sub    %eax,%esi
      memmove(buf, p, m);
 2fc:	89 74 24 08          	mov    %esi,0x8(%esp)
 300:	89 7c 24 04          	mov    %edi,0x4(%esp)
 304:	c7 04 24 00 0e 00 00 	movl   $0xe00,(%esp)
 30b:	e8 10 02 00 00       	call   520 <memmove>
 310:	e9 2b ff ff ff       	jmp    240 <grep+0x10>
 315:	8d 76 00             	lea    0x0(%esi),%esi
      m = 0;
 318:	31 f6                	xor    %esi,%esi
 31a:	e9 21 ff ff ff       	jmp    240 <grep+0x10>
 31f:	90                   	nop
}
 320:	83 c4 2c             	add    $0x2c,%esp
 323:	5b                   	pop    %ebx
 324:	5e                   	pop    %esi
 325:	5f                   	pop    %edi
 326:	5d                   	pop    %ebp
 327:	c3                   	ret    
 328:	66 90                	xchg   %ax,%ax
 32a:	66 90                	xchg   %ax,%ax
 32c:	66 90                	xchg   %ax,%ax
 32e:	66 90                	xchg   %ax,%ax

00000330 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	8b 45 08             	mov    0x8(%ebp),%eax
 336:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 339:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 33a:	89 c2                	mov    %eax,%edx
 33c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 340:	41                   	inc    %ecx
 341:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 345:	42                   	inc    %edx
 346:	84 db                	test   %bl,%bl
 348:	88 5a ff             	mov    %bl,-0x1(%edx)
 34b:	75 f3                	jne    340 <strcpy+0x10>
    ;
  return os;
}
 34d:	5b                   	pop    %ebx
 34e:	5d                   	pop    %ebp
 34f:	c3                   	ret    

00000350 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	8b 4d 08             	mov    0x8(%ebp),%ecx
 356:	53                   	push   %ebx
 357:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 35a:	0f b6 01             	movzbl (%ecx),%eax
 35d:	0f b6 13             	movzbl (%ebx),%edx
 360:	84 c0                	test   %al,%al
 362:	75 18                	jne    37c <strcmp+0x2c>
 364:	eb 22                	jmp    388 <strcmp+0x38>
 366:	8d 76 00             	lea    0x0(%esi),%esi
 369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 370:	41                   	inc    %ecx
  while(*p && *p == *q)
 371:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 374:	43                   	inc    %ebx
 375:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
 378:	84 c0                	test   %al,%al
 37a:	74 0c                	je     388 <strcmp+0x38>
 37c:	38 d0                	cmp    %dl,%al
 37e:	74 f0                	je     370 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
 380:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 381:	29 d0                	sub    %edx,%eax
}
 383:	5d                   	pop    %ebp
 384:	c3                   	ret    
 385:	8d 76 00             	lea    0x0(%esi),%esi
 388:	5b                   	pop    %ebx
 389:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 38b:	29 d0                	sub    %edx,%eax
}
 38d:	5d                   	pop    %ebp
 38e:	c3                   	ret    
 38f:	90                   	nop

00000390 <strlen>:

uint
strlen(const char *s)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 396:	80 39 00             	cmpb   $0x0,(%ecx)
 399:	74 15                	je     3b0 <strlen+0x20>
 39b:	31 d2                	xor    %edx,%edx
 39d:	8d 76 00             	lea    0x0(%esi),%esi
 3a0:	42                   	inc    %edx
 3a1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 3a5:	89 d0                	mov    %edx,%eax
 3a7:	75 f7                	jne    3a0 <strlen+0x10>
    ;
  return n;
}
 3a9:	5d                   	pop    %ebp
 3aa:	c3                   	ret    
 3ab:	90                   	nop
 3ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
 3b0:	31 c0                	xor    %eax,%eax
}
 3b2:	5d                   	pop    %ebp
 3b3:	c3                   	ret    
 3b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000003c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	8b 55 08             	mov    0x8(%ebp),%edx
 3c6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 3cd:	89 d7                	mov    %edx,%edi
 3cf:	fc                   	cld    
 3d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3d2:	5f                   	pop    %edi
 3d3:	89 d0                	mov    %edx,%eax
 3d5:	5d                   	pop    %ebp
 3d6:	c3                   	ret    
 3d7:	89 f6                	mov    %esi,%esi
 3d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003e0 <strchr>:

char*
strchr(const char *s, char c)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	8b 45 08             	mov    0x8(%ebp),%eax
 3e6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 3ea:	0f b6 10             	movzbl (%eax),%edx
 3ed:	84 d2                	test   %dl,%dl
 3ef:	74 1b                	je     40c <strchr+0x2c>
    if(*s == c)
 3f1:	38 d1                	cmp    %dl,%cl
 3f3:	75 0f                	jne    404 <strchr+0x24>
 3f5:	eb 17                	jmp    40e <strchr+0x2e>
 3f7:	89 f6                	mov    %esi,%esi
 3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 400:	38 ca                	cmp    %cl,%dl
 402:	74 0a                	je     40e <strchr+0x2e>
  for(; *s; s++)
 404:	40                   	inc    %eax
 405:	0f b6 10             	movzbl (%eax),%edx
 408:	84 d2                	test   %dl,%dl
 40a:	75 f4                	jne    400 <strchr+0x20>
      return (char*)s;
  return 0;
 40c:	31 c0                	xor    %eax,%eax
}
 40e:	5d                   	pop    %ebp
 40f:	c3                   	ret    

00000410 <gets>:

char*
gets(char *buf, int max)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 415:	31 f6                	xor    %esi,%esi
{
 417:	53                   	push   %ebx
 418:	83 ec 3c             	sub    $0x3c,%esp
 41b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
 41e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 421:	eb 32                	jmp    455 <gets+0x45>
 423:	90                   	nop
 424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 428:	ba 01 00 00 00       	mov    $0x1,%edx
 42d:	89 54 24 08          	mov    %edx,0x8(%esp)
 431:	89 7c 24 04          	mov    %edi,0x4(%esp)
 435:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 43c:	e8 2f 01 00 00       	call   570 <read>
    if(cc < 1)
 441:	85 c0                	test   %eax,%eax
 443:	7e 19                	jle    45e <gets+0x4e>
      break;
    buf[i++] = c;
 445:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 449:	43                   	inc    %ebx
 44a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
 44d:	3c 0a                	cmp    $0xa,%al
 44f:	74 1f                	je     470 <gets+0x60>
 451:	3c 0d                	cmp    $0xd,%al
 453:	74 1b                	je     470 <gets+0x60>
  for(i=0; i+1 < max; ){
 455:	46                   	inc    %esi
 456:	3b 75 0c             	cmp    0xc(%ebp),%esi
 459:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 45c:	7c ca                	jl     428 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 45e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 461:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 464:	8b 45 08             	mov    0x8(%ebp),%eax
 467:	83 c4 3c             	add    $0x3c,%esp
 46a:	5b                   	pop    %ebx
 46b:	5e                   	pop    %esi
 46c:	5f                   	pop    %edi
 46d:	5d                   	pop    %ebp
 46e:	c3                   	ret    
 46f:	90                   	nop
 470:	8b 45 08             	mov    0x8(%ebp),%eax
 473:	01 c6                	add    %eax,%esi
 475:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 478:	eb e4                	jmp    45e <gets+0x4e>
 47a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000480 <stat>:

int
stat(const char *n, struct stat *st)
{
 480:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 481:	31 c0                	xor    %eax,%eax
{
 483:	89 e5                	mov    %esp,%ebp
 485:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 488:	89 44 24 04          	mov    %eax,0x4(%esp)
 48c:	8b 45 08             	mov    0x8(%ebp),%eax
{
 48f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 492:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 495:	89 04 24             	mov    %eax,(%esp)
 498:	e8 fb 00 00 00       	call   598 <open>
  if(fd < 0)
 49d:	85 c0                	test   %eax,%eax
 49f:	78 2f                	js     4d0 <stat+0x50>
 4a1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 4a3:	8b 45 0c             	mov    0xc(%ebp),%eax
 4a6:	89 1c 24             	mov    %ebx,(%esp)
 4a9:	89 44 24 04          	mov    %eax,0x4(%esp)
 4ad:	e8 fe 00 00 00       	call   5b0 <fstat>
  close(fd);
 4b2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 4b5:	89 c6                	mov    %eax,%esi
  close(fd);
 4b7:	e8 c4 00 00 00       	call   580 <close>
  return r;
}
 4bc:	89 f0                	mov    %esi,%eax
 4be:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 4c1:	8b 75 fc             	mov    -0x4(%ebp),%esi
 4c4:	89 ec                	mov    %ebp,%esp
 4c6:	5d                   	pop    %ebp
 4c7:	c3                   	ret    
 4c8:	90                   	nop
 4c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 4d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 4d5:	eb e5                	jmp    4bc <stat+0x3c>
 4d7:	89 f6                	mov    %esi,%esi
 4d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004e0 <atoi>:

int
atoi(const char *s)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 4e6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4e7:	0f be 11             	movsbl (%ecx),%edx
 4ea:	88 d0                	mov    %dl,%al
 4ec:	2c 30                	sub    $0x30,%al
 4ee:	3c 09                	cmp    $0x9,%al
  n = 0;
 4f0:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 4f5:	77 1e                	ja     515 <atoi+0x35>
 4f7:	89 f6                	mov    %esi,%esi
 4f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 500:	41                   	inc    %ecx
 501:	8d 04 80             	lea    (%eax,%eax,4),%eax
 504:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 508:	0f be 11             	movsbl (%ecx),%edx
 50b:	88 d3                	mov    %dl,%bl
 50d:	80 eb 30             	sub    $0x30,%bl
 510:	80 fb 09             	cmp    $0x9,%bl
 513:	76 eb                	jbe    500 <atoi+0x20>
  return n;
}
 515:	5b                   	pop    %ebx
 516:	5d                   	pop    %ebp
 517:	c3                   	ret    
 518:	90                   	nop
 519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000520 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	56                   	push   %esi
 524:	8b 45 08             	mov    0x8(%ebp),%eax
 527:	53                   	push   %ebx
 528:	8b 5d 10             	mov    0x10(%ebp),%ebx
 52b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 52e:	85 db                	test   %ebx,%ebx
 530:	7e 1a                	jle    54c <memmove+0x2c>
 532:	31 d2                	xor    %edx,%edx
 534:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 53a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 540:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 544:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 547:	42                   	inc    %edx
  while(n-- > 0)
 548:	39 d3                	cmp    %edx,%ebx
 54a:	75 f4                	jne    540 <memmove+0x20>
  return vdst;
}
 54c:	5b                   	pop    %ebx
 54d:	5e                   	pop    %esi
 54e:	5d                   	pop    %ebp
 54f:	c3                   	ret    

00000550 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 550:	b8 01 00 00 00       	mov    $0x1,%eax
 555:	cd 40                	int    $0x40
 557:	c3                   	ret    

00000558 <exit>:
SYSCALL(exit)
 558:	b8 02 00 00 00       	mov    $0x2,%eax
 55d:	cd 40                	int    $0x40
 55f:	c3                   	ret    

00000560 <wait>:
SYSCALL(wait)
 560:	b8 03 00 00 00       	mov    $0x3,%eax
 565:	cd 40                	int    $0x40
 567:	c3                   	ret    

00000568 <pipe>:
SYSCALL(pipe)
 568:	b8 04 00 00 00       	mov    $0x4,%eax
 56d:	cd 40                	int    $0x40
 56f:	c3                   	ret    

00000570 <read>:
SYSCALL(read)
 570:	b8 05 00 00 00       	mov    $0x5,%eax
 575:	cd 40                	int    $0x40
 577:	c3                   	ret    

00000578 <write>:
SYSCALL(write)
 578:	b8 10 00 00 00       	mov    $0x10,%eax
 57d:	cd 40                	int    $0x40
 57f:	c3                   	ret    

00000580 <close>:
SYSCALL(close)
 580:	b8 15 00 00 00       	mov    $0x15,%eax
 585:	cd 40                	int    $0x40
 587:	c3                   	ret    

00000588 <kill>:
SYSCALL(kill)
 588:	b8 06 00 00 00       	mov    $0x6,%eax
 58d:	cd 40                	int    $0x40
 58f:	c3                   	ret    

00000590 <exec>:
SYSCALL(exec)
 590:	b8 07 00 00 00       	mov    $0x7,%eax
 595:	cd 40                	int    $0x40
 597:	c3                   	ret    

00000598 <open>:
SYSCALL(open)
 598:	b8 0f 00 00 00       	mov    $0xf,%eax
 59d:	cd 40                	int    $0x40
 59f:	c3                   	ret    

000005a0 <mknod>:
SYSCALL(mknod)
 5a0:	b8 11 00 00 00       	mov    $0x11,%eax
 5a5:	cd 40                	int    $0x40
 5a7:	c3                   	ret    

000005a8 <unlink>:
SYSCALL(unlink)
 5a8:	b8 12 00 00 00       	mov    $0x12,%eax
 5ad:	cd 40                	int    $0x40
 5af:	c3                   	ret    

000005b0 <fstat>:
SYSCALL(fstat)
 5b0:	b8 08 00 00 00       	mov    $0x8,%eax
 5b5:	cd 40                	int    $0x40
 5b7:	c3                   	ret    

000005b8 <link>:
SYSCALL(link)
 5b8:	b8 13 00 00 00       	mov    $0x13,%eax
 5bd:	cd 40                	int    $0x40
 5bf:	c3                   	ret    

000005c0 <mkdir>:
SYSCALL(mkdir)
 5c0:	b8 14 00 00 00       	mov    $0x14,%eax
 5c5:	cd 40                	int    $0x40
 5c7:	c3                   	ret    

000005c8 <chdir>:
SYSCALL(chdir)
 5c8:	b8 09 00 00 00       	mov    $0x9,%eax
 5cd:	cd 40                	int    $0x40
 5cf:	c3                   	ret    

000005d0 <dup>:
SYSCALL(dup)
 5d0:	b8 0a 00 00 00       	mov    $0xa,%eax
 5d5:	cd 40                	int    $0x40
 5d7:	c3                   	ret    

000005d8 <getpid>:
SYSCALL(getpid)
 5d8:	b8 0b 00 00 00       	mov    $0xb,%eax
 5dd:	cd 40                	int    $0x40
 5df:	c3                   	ret    

000005e0 <sbrk>:
SYSCALL(sbrk)
 5e0:	b8 0c 00 00 00       	mov    $0xc,%eax
 5e5:	cd 40                	int    $0x40
 5e7:	c3                   	ret    

000005e8 <sleep>:
SYSCALL(sleep)
 5e8:	b8 0d 00 00 00       	mov    $0xd,%eax
 5ed:	cd 40                	int    $0x40
 5ef:	c3                   	ret    

000005f0 <uptime>:
SYSCALL(uptime)
 5f0:	b8 0e 00 00 00       	mov    $0xe,%eax
 5f5:	cd 40                	int    $0x40
 5f7:	c3                   	ret    
 5f8:	66 90                	xchg   %ax,%ax
 5fa:	66 90                	xchg   %ax,%ax
 5fc:	66 90                	xchg   %ax,%ax
 5fe:	66 90                	xchg   %ax,%ax

00000600 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 600:	55                   	push   %ebp
 601:	89 e5                	mov    %esp,%ebp
 603:	57                   	push   %edi
 604:	56                   	push   %esi
 605:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 606:	89 d3                	mov    %edx,%ebx
 608:	c1 eb 1f             	shr    $0x1f,%ebx
{
 60b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 60e:	84 db                	test   %bl,%bl
{
 610:	89 45 c0             	mov    %eax,-0x40(%ebp)
 613:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 615:	74 79                	je     690 <printint+0x90>
 617:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 61b:	74 73                	je     690 <printint+0x90>
    neg = 1;
    x = -xx;
 61d:	f7 d8                	neg    %eax
    neg = 1;
 61f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 626:	31 f6                	xor    %esi,%esi
 628:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 62b:	eb 05                	jmp    632 <printint+0x32>
 62d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 630:	89 fe                	mov    %edi,%esi
 632:	31 d2                	xor    %edx,%edx
 634:	f7 f1                	div    %ecx
 636:	8d 7e 01             	lea    0x1(%esi),%edi
 639:	0f b6 92 58 0a 00 00 	movzbl 0xa58(%edx),%edx
  }while((x /= base) != 0);
 640:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 642:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 645:	75 e9                	jne    630 <printint+0x30>
  if(neg)
 647:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 64a:	85 d2                	test   %edx,%edx
 64c:	74 08                	je     656 <printint+0x56>
    buf[i++] = '-';
 64e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 653:	8d 7e 02             	lea    0x2(%esi),%edi
 656:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 65a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 65d:	8d 76 00             	lea    0x0(%esi),%esi
 660:	0f b6 06             	movzbl (%esi),%eax
 663:	4e                   	dec    %esi
  write(fd, &c, 1);
 664:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 668:	89 3c 24             	mov    %edi,(%esp)
 66b:	88 45 d7             	mov    %al,-0x29(%ebp)
 66e:	b8 01 00 00 00       	mov    $0x1,%eax
 673:	89 44 24 08          	mov    %eax,0x8(%esp)
 677:	e8 fc fe ff ff       	call   578 <write>

  while(--i >= 0)
 67c:	39 de                	cmp    %ebx,%esi
 67e:	75 e0                	jne    660 <printint+0x60>
    putc(fd, buf[i]);
}
 680:	83 c4 4c             	add    $0x4c,%esp
 683:	5b                   	pop    %ebx
 684:	5e                   	pop    %esi
 685:	5f                   	pop    %edi
 686:	5d                   	pop    %ebp
 687:	c3                   	ret    
 688:	90                   	nop
 689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 690:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 697:	eb 8d                	jmp    626 <printint+0x26>
 699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	57                   	push   %edi
 6a4:	56                   	push   %esi
 6a5:	53                   	push   %ebx
 6a6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6a9:	8b 75 0c             	mov    0xc(%ebp),%esi
 6ac:	0f b6 1e             	movzbl (%esi),%ebx
 6af:	84 db                	test   %bl,%bl
 6b1:	0f 84 d1 00 00 00    	je     788 <printf+0xe8>
  state = 0;
 6b7:	31 ff                	xor    %edi,%edi
 6b9:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 6ba:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 6bd:	89 fa                	mov    %edi,%edx
 6bf:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 6c2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 6c5:	eb 41                	jmp    708 <printf+0x68>
 6c7:	89 f6                	mov    %esi,%esi
 6c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6d0:	83 f8 25             	cmp    $0x25,%eax
 6d3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 6d6:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 6db:	74 1e                	je     6fb <printf+0x5b>
  write(fd, &c, 1);
 6dd:	b8 01 00 00 00       	mov    $0x1,%eax
 6e2:	89 44 24 08          	mov    %eax,0x8(%esp)
 6e6:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 6e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ed:	89 3c 24             	mov    %edi,(%esp)
 6f0:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 6f3:	e8 80 fe ff ff       	call   578 <write>
 6f8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 6fb:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 6fc:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 700:	84 db                	test   %bl,%bl
 702:	0f 84 80 00 00 00    	je     788 <printf+0xe8>
    if(state == 0){
 708:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 70a:	0f be cb             	movsbl %bl,%ecx
 70d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 710:	74 be                	je     6d0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 712:	83 fa 25             	cmp    $0x25,%edx
 715:	75 e4                	jne    6fb <printf+0x5b>
      if(c == 'd'){
 717:	83 f8 64             	cmp    $0x64,%eax
 71a:	0f 84 f0 00 00 00    	je     810 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 720:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 726:	83 f9 70             	cmp    $0x70,%ecx
 729:	74 65                	je     790 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 72b:	83 f8 73             	cmp    $0x73,%eax
 72e:	0f 84 8c 00 00 00    	je     7c0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 734:	83 f8 63             	cmp    $0x63,%eax
 737:	0f 84 13 01 00 00    	je     850 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 73d:	83 f8 25             	cmp    $0x25,%eax
 740:	0f 84 e2 00 00 00    	je     828 <printf+0x188>
  write(fd, &c, 1);
 746:	b8 01 00 00 00       	mov    $0x1,%eax
 74b:	46                   	inc    %esi
 74c:	89 44 24 08          	mov    %eax,0x8(%esp)
 750:	8d 45 e7             	lea    -0x19(%ebp),%eax
 753:	89 44 24 04          	mov    %eax,0x4(%esp)
 757:	89 3c 24             	mov    %edi,(%esp)
 75a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 75e:	e8 15 fe ff ff       	call   578 <write>
 763:	ba 01 00 00 00       	mov    $0x1,%edx
 768:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 76b:	89 54 24 08          	mov    %edx,0x8(%esp)
 76f:	89 44 24 04          	mov    %eax,0x4(%esp)
 773:	89 3c 24             	mov    %edi,(%esp)
 776:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 779:	e8 fa fd ff ff       	call   578 <write>
  for(i = 0; fmt[i]; i++){
 77e:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 782:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 784:	84 db                	test   %bl,%bl
 786:	75 80                	jne    708 <printf+0x68>
    }
  }
}
 788:	83 c4 3c             	add    $0x3c,%esp
 78b:	5b                   	pop    %ebx
 78c:	5e                   	pop    %esi
 78d:	5f                   	pop    %edi
 78e:	5d                   	pop    %ebp
 78f:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 790:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 797:	b9 10 00 00 00       	mov    $0x10,%ecx
 79c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 79f:	89 f8                	mov    %edi,%eax
 7a1:	8b 13                	mov    (%ebx),%edx
 7a3:	e8 58 fe ff ff       	call   600 <printint>
        ap++;
 7a8:	89 d8                	mov    %ebx,%eax
      state = 0;
 7aa:	31 d2                	xor    %edx,%edx
        ap++;
 7ac:	83 c0 04             	add    $0x4,%eax
 7af:	89 45 d0             	mov    %eax,-0x30(%ebp)
 7b2:	e9 44 ff ff ff       	jmp    6fb <printf+0x5b>
 7b7:	89 f6                	mov    %esi,%esi
 7b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 7c0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 7c3:	8b 10                	mov    (%eax),%edx
        ap++;
 7c5:	83 c0 04             	add    $0x4,%eax
 7c8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 7cb:	85 d2                	test   %edx,%edx
 7cd:	0f 84 aa 00 00 00    	je     87d <printf+0x1dd>
        while(*s != 0){
 7d3:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 7d6:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 7d8:	84 c0                	test   %al,%al
 7da:	74 27                	je     803 <printf+0x163>
 7dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7e0:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 7e3:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 7e8:	43                   	inc    %ebx
  write(fd, &c, 1);
 7e9:	89 44 24 08          	mov    %eax,0x8(%esp)
 7ed:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 7f0:	89 44 24 04          	mov    %eax,0x4(%esp)
 7f4:	89 3c 24             	mov    %edi,(%esp)
 7f7:	e8 7c fd ff ff       	call   578 <write>
        while(*s != 0){
 7fc:	0f b6 03             	movzbl (%ebx),%eax
 7ff:	84 c0                	test   %al,%al
 801:	75 dd                	jne    7e0 <printf+0x140>
      state = 0;
 803:	31 d2                	xor    %edx,%edx
 805:	e9 f1 fe ff ff       	jmp    6fb <printf+0x5b>
 80a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 810:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 817:	b9 0a 00 00 00       	mov    $0xa,%ecx
 81c:	e9 7b ff ff ff       	jmp    79c <printf+0xfc>
 821:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 828:	b9 01 00 00 00       	mov    $0x1,%ecx
 82d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 830:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 834:	89 44 24 04          	mov    %eax,0x4(%esp)
 838:	89 3c 24             	mov    %edi,(%esp)
 83b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 83e:	e8 35 fd ff ff       	call   578 <write>
      state = 0;
 843:	31 d2                	xor    %edx,%edx
 845:	e9 b1 fe ff ff       	jmp    6fb <printf+0x5b>
 84a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 850:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 853:	8b 03                	mov    (%ebx),%eax
        ap++;
 855:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 858:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 85b:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 85e:	b8 01 00 00 00       	mov    $0x1,%eax
 863:	89 44 24 08          	mov    %eax,0x8(%esp)
 867:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 86a:	89 44 24 04          	mov    %eax,0x4(%esp)
 86e:	e8 05 fd ff ff       	call   578 <write>
      state = 0;
 873:	31 d2                	xor    %edx,%edx
        ap++;
 875:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 878:	e9 7e fe ff ff       	jmp    6fb <printf+0x5b>
          s = "(null)";
 87d:	bb 4e 0a 00 00       	mov    $0xa4e,%ebx
        while(*s != 0){
 882:	b0 28                	mov    $0x28,%al
 884:	e9 57 ff ff ff       	jmp    7e0 <printf+0x140>
 889:	66 90                	xchg   %ax,%ax
 88b:	66 90                	xchg   %ax,%ax
 88d:	66 90                	xchg   %ax,%ax
 88f:	90                   	nop

00000890 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 890:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 891:	a1 e0 0d 00 00       	mov    0xde0,%eax
{
 896:	89 e5                	mov    %esp,%ebp
 898:	57                   	push   %edi
 899:	56                   	push   %esi
 89a:	53                   	push   %ebx
 89b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 89e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 8a1:	eb 0d                	jmp    8b0 <free+0x20>
 8a3:	90                   	nop
 8a4:	90                   	nop
 8a5:	90                   	nop
 8a6:	90                   	nop
 8a7:	90                   	nop
 8a8:	90                   	nop
 8a9:	90                   	nop
 8aa:	90                   	nop
 8ab:	90                   	nop
 8ac:	90                   	nop
 8ad:	90                   	nop
 8ae:	90                   	nop
 8af:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8b0:	39 c8                	cmp    %ecx,%eax
 8b2:	8b 10                	mov    (%eax),%edx
 8b4:	73 32                	jae    8e8 <free+0x58>
 8b6:	39 d1                	cmp    %edx,%ecx
 8b8:	72 04                	jb     8be <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ba:	39 d0                	cmp    %edx,%eax
 8bc:	72 32                	jb     8f0 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8be:	8b 73 fc             	mov    -0x4(%ebx),%esi
 8c1:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 8c4:	39 fa                	cmp    %edi,%edx
 8c6:	74 30                	je     8f8 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 8c8:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 8cb:	8b 50 04             	mov    0x4(%eax),%edx
 8ce:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8d1:	39 f1                	cmp    %esi,%ecx
 8d3:	74 3c                	je     911 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 8d5:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 8d7:	5b                   	pop    %ebx
  freep = p;
 8d8:	a3 e0 0d 00 00       	mov    %eax,0xde0
}
 8dd:	5e                   	pop    %esi
 8de:	5f                   	pop    %edi
 8df:	5d                   	pop    %ebp
 8e0:	c3                   	ret    
 8e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8e8:	39 d0                	cmp    %edx,%eax
 8ea:	72 04                	jb     8f0 <free+0x60>
 8ec:	39 d1                	cmp    %edx,%ecx
 8ee:	72 ce                	jb     8be <free+0x2e>
{
 8f0:	89 d0                	mov    %edx,%eax
 8f2:	eb bc                	jmp    8b0 <free+0x20>
 8f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 8f8:	8b 7a 04             	mov    0x4(%edx),%edi
 8fb:	01 fe                	add    %edi,%esi
 8fd:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 900:	8b 10                	mov    (%eax),%edx
 902:	8b 12                	mov    (%edx),%edx
 904:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 907:	8b 50 04             	mov    0x4(%eax),%edx
 90a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 90d:	39 f1                	cmp    %esi,%ecx
 90f:	75 c4                	jne    8d5 <free+0x45>
    p->s.size += bp->s.size;
 911:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 914:	a3 e0 0d 00 00       	mov    %eax,0xde0
    p->s.size += bp->s.size;
 919:	01 ca                	add    %ecx,%edx
 91b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 91e:	8b 53 f8             	mov    -0x8(%ebx),%edx
 921:	89 10                	mov    %edx,(%eax)
}
 923:	5b                   	pop    %ebx
 924:	5e                   	pop    %esi
 925:	5f                   	pop    %edi
 926:	5d                   	pop    %ebp
 927:	c3                   	ret    
 928:	90                   	nop
 929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000930 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 930:	55                   	push   %ebp
 931:	89 e5                	mov    %esp,%ebp
 933:	57                   	push   %edi
 934:	56                   	push   %esi
 935:	53                   	push   %ebx
 936:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 939:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 93c:	8b 15 e0 0d 00 00    	mov    0xde0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 942:	8d 78 07             	lea    0x7(%eax),%edi
 945:	c1 ef 03             	shr    $0x3,%edi
 948:	47                   	inc    %edi
  if((prevp = freep) == 0){
 949:	85 d2                	test   %edx,%edx
 94b:	0f 84 8f 00 00 00    	je     9e0 <malloc+0xb0>
 951:	8b 02                	mov    (%edx),%eax
 953:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 956:	39 cf                	cmp    %ecx,%edi
 958:	76 66                	jbe    9c0 <malloc+0x90>
 95a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 960:	bb 00 10 00 00       	mov    $0x1000,%ebx
 965:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 968:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 96f:	eb 10                	jmp    981 <malloc+0x51>
 971:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 978:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 97a:	8b 48 04             	mov    0x4(%eax),%ecx
 97d:	39 f9                	cmp    %edi,%ecx
 97f:	73 3f                	jae    9c0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 981:	39 05 e0 0d 00 00    	cmp    %eax,0xde0
 987:	89 c2                	mov    %eax,%edx
 989:	75 ed                	jne    978 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 98b:	89 34 24             	mov    %esi,(%esp)
 98e:	e8 4d fc ff ff       	call   5e0 <sbrk>
  if(p == (char*)-1)
 993:	83 f8 ff             	cmp    $0xffffffff,%eax
 996:	74 18                	je     9b0 <malloc+0x80>
  hp->s.size = nu;
 998:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 99b:	83 c0 08             	add    $0x8,%eax
 99e:	89 04 24             	mov    %eax,(%esp)
 9a1:	e8 ea fe ff ff       	call   890 <free>
  return freep;
 9a6:	8b 15 e0 0d 00 00    	mov    0xde0,%edx
      if((p = morecore(nunits)) == 0)
 9ac:	85 d2                	test   %edx,%edx
 9ae:	75 c8                	jne    978 <malloc+0x48>
        return 0;
  }
}
 9b0:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 9b3:	31 c0                	xor    %eax,%eax
}
 9b5:	5b                   	pop    %ebx
 9b6:	5e                   	pop    %esi
 9b7:	5f                   	pop    %edi
 9b8:	5d                   	pop    %ebp
 9b9:	c3                   	ret    
 9ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 9c0:	39 cf                	cmp    %ecx,%edi
 9c2:	74 4c                	je     a10 <malloc+0xe0>
        p->s.size -= nunits;
 9c4:	29 f9                	sub    %edi,%ecx
 9c6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 9c9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 9cc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 9cf:	89 15 e0 0d 00 00    	mov    %edx,0xde0
}
 9d5:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 9d8:	83 c0 08             	add    $0x8,%eax
}
 9db:	5b                   	pop    %ebx
 9dc:	5e                   	pop    %esi
 9dd:	5f                   	pop    %edi
 9de:	5d                   	pop    %ebp
 9df:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 9e0:	b8 e4 0d 00 00       	mov    $0xde4,%eax
 9e5:	ba e4 0d 00 00       	mov    $0xde4,%edx
    base.s.size = 0;
 9ea:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 9ec:	a3 e0 0d 00 00       	mov    %eax,0xde0
    base.s.size = 0;
 9f1:	b8 e4 0d 00 00       	mov    $0xde4,%eax
    base.s.ptr = freep = prevp = &base;
 9f6:	89 15 e4 0d 00 00    	mov    %edx,0xde4
    base.s.size = 0;
 9fc:	89 0d e8 0d 00 00    	mov    %ecx,0xde8
 a02:	e9 53 ff ff ff       	jmp    95a <malloc+0x2a>
 a07:	89 f6                	mov    %esi,%esi
 a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 a10:	8b 08                	mov    (%eax),%ecx
 a12:	89 0a                	mov    %ecx,(%edx)
 a14:	eb b9                	jmp    9cf <malloc+0x9f>
