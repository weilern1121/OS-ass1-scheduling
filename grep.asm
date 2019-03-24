
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
  }
}

int
main(int argc, char *argv[])
{
  10:	8b 55 0c             	mov    0xc(%ebp),%edx
  int fd, i;
  char *pattern;

  if(argc <= 1){
  13:	0f 8e 9e 00 00 00    	jle    b7 <main+0xb7>
    printf(2, "usage: grep pattern [file ...]\n");
    exit(0);
  }
  pattern = argv[1];

  if(argc <= 2){
  19:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)

  if(argc <= 1){
    printf(2, "usage: grep pattern [file ...]\n");
    exit(0);
  }
  pattern = argv[1];
  1d:	8b 7a 04             	mov    0x4(%edx),%edi

  if(argc <= 2){
  20:	74 79                	je     9b <main+0x9b>
  22:	8d 72 08             	lea    0x8(%edx),%esi
  25:	bb 02 00 00 00       	mov    $0x2,%ebx
  2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    grep(pattern, 0);
    exit(0);
  }

  for(i = 2; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  30:	31 c0                	xor    %eax,%eax
  32:	89 44 24 04          	mov    %eax,0x4(%esp)
  36:	8b 06                	mov    (%esi),%eax
  38:	89 04 24             	mov    %eax,(%esp)
  3b:	e8 88 05 00 00       	call   5c8 <open>
  40:	85 c0                	test   %eax,%eax
  42:	78 31                	js     75 <main+0x75>
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit(0);
    }
    grep(pattern, fd);
  44:	89 44 24 04          	mov    %eax,0x4(%esp)
  if(argc <= 2){
    grep(pattern, 0);
    exit(0);
  }

  for(i = 2; i < argc; i++){
  48:	43                   	inc    %ebx
  49:	83 c6 04             	add    $0x4,%esi
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit(0);
    }
    grep(pattern, fd);
  4c:	89 3c 24             	mov    %edi,(%esp)
  4f:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  53:	e8 e8 01 00 00       	call   240 <grep>
    close(fd);
  58:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  5c:	89 04 24             	mov    %eax,(%esp)
  5f:	e8 4c 05 00 00       	call   5b0 <close>
  if(argc <= 2){
    grep(pattern, 0);
    exit(0);
  }

  for(i = 2; i < argc; i++){
  64:	39 5d 08             	cmp    %ebx,0x8(%ebp)
  67:	7f c7                	jg     30 <main+0x30>
      exit(0);
    }
    grep(pattern, fd);
    close(fd);
  }
  exit(0);
  69:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  70:	e8 13 05 00 00       	call   588 <exit>
    exit(0);
  }

  for(i = 2; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "grep: cannot open %s\n", argv[i]);
  75:	8b 06                	mov    (%esi),%eax
  77:	c7 44 24 04 70 0a 00 	movl   $0xa70,0x4(%esp)
  7e:	00 
  7f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  86:	89 44 24 08          	mov    %eax,0x8(%esp)
  8a:	e8 61 06 00 00       	call   6f0 <printf>
      exit(0);
  8f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  96:	e8 ed 04 00 00       	call   588 <exit>
    exit(0);
  }
  pattern = argv[1];

  if(argc <= 2){
    grep(pattern, 0);
  9b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  a2:	00 
  a3:	89 3c 24             	mov    %edi,(%esp)
  a6:	e8 95 01 00 00       	call   240 <grep>
    exit(0);
  ab:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  b2:	e8 d1 04 00 00       	call   588 <exit>
{
  int fd, i;
  char *pattern;

  if(argc <= 1){
    printf(2, "usage: grep pattern [file ...]\n");
  b7:	c7 44 24 04 50 0a 00 	movl   $0xa50,0x4(%esp)
  be:	00 
  bf:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  c6:	e8 25 06 00 00       	call   6f0 <printf>
    exit(0);
  cb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  d2:	e8 b1 04 00 00       	call   588 <exit>
  d7:	66 90                	xchg   %ax,%ax
  d9:	66 90                	xchg   %ax,%ax
  db:	66 90                	xchg   %ax,%ax
  dd:	66 90                	xchg   %ax,%ax
  df:	90                   	nop

000000e0 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	57                   	push   %edi
  e4:	56                   	push   %esi
  e5:	53                   	push   %ebx
  e6:	83 ec 1c             	sub    $0x1c,%esp
  e9:	8b 75 08             	mov    0x8(%ebp),%esi
  ec:	8b 7d 0c             	mov    0xc(%ebp),%edi
  ef:	8b 5d 10             	mov    0x10(%ebp),%ebx
  f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
 100:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 104:	89 3c 24             	mov    %edi,(%esp)
 107:	e8 34 00 00 00       	call   140 <matchhere>
 10c:	85 c0                	test   %eax,%eax
 10e:	75 20                	jne    130 <matchstar+0x50>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
 110:	0f be 13             	movsbl (%ebx),%edx
 113:	84 d2                	test   %dl,%dl
 115:	74 0a                	je     121 <matchstar+0x41>
 117:	43                   	inc    %ebx
 118:	83 fe 2e             	cmp    $0x2e,%esi
 11b:	74 e3                	je     100 <matchstar+0x20>
 11d:	39 f2                	cmp    %esi,%edx
 11f:	74 df                	je     100 <matchstar+0x20>
  return 0;
}
 121:	83 c4 1c             	add    $0x1c,%esp
 124:	5b                   	pop    %ebx
 125:	5e                   	pop    %esi
 126:	5f                   	pop    %edi
 127:	5d                   	pop    %ebp
 128:	c3                   	ret    
 129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 130:	83 c4 1c             	add    $0x1c,%esp
// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
 133:	b8 01 00 00 00       	mov    $0x1,%eax
  }while(*text!='\0' && (*text++==c || c=='.'));
  return 0;
}
 138:	5b                   	pop    %ebx
 139:	5e                   	pop    %esi
 13a:	5f                   	pop    %edi
 13b:	5d                   	pop    %ebp
 13c:	c3                   	ret    
 13d:	8d 76 00             	lea    0x0(%esi),%esi

00000140 <matchhere>:
  return 0;
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	56                   	push   %esi
 144:	53                   	push   %ebx
 145:	83 ec 10             	sub    $0x10,%esp
 148:	8b 45 08             	mov    0x8(%ebp),%eax
 14b:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(re[0] == '\0')
 14e:	0f b6 08             	movzbl (%eax),%ecx
 151:	84 c9                	test   %cl,%cl
 153:	74 53                	je     1a8 <matchhere+0x68>
    return 1;
  if(re[1] == '*')
 155:	0f be 50 01          	movsbl 0x1(%eax),%edx
 159:	80 fa 2a             	cmp    $0x2a,%dl
 15c:	74 63                	je     1c1 <matchhere+0x81>
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
 15e:	80 f9 24             	cmp    $0x24,%cl
 161:	75 04                	jne    167 <matchhere+0x27>
 163:	84 d2                	test   %dl,%dl
 165:	74 77                	je     1de <matchhere+0x9e>
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 167:	0f b6 1e             	movzbl (%esi),%ebx
 16a:	84 db                	test   %bl,%bl
 16c:	74 4a                	je     1b8 <matchhere+0x78>
 16e:	38 d9                	cmp    %bl,%cl
 170:	74 05                	je     177 <matchhere+0x37>
 172:	80 f9 2e             	cmp    $0x2e,%cl
 175:	75 41                	jne    1b8 <matchhere+0x78>
    return matchhere(re+1, text+1);
 177:	46                   	inc    %esi
 178:	40                   	inc    %eax
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
 179:	84 d2                	test   %dl,%dl
 17b:	74 2b                	je     1a8 <matchhere+0x68>
    return 1;
  if(re[1] == '*')
 17d:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
 181:	80 f9 2a             	cmp    $0x2a,%cl
 184:	74 3e                	je     1c4 <matchhere+0x84>
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
 186:	80 fa 24             	cmp    $0x24,%dl
 189:	75 04                	jne    18f <matchhere+0x4f>
 18b:	84 c9                	test   %cl,%cl
 18d:	74 4f                	je     1de <matchhere+0x9e>
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 18f:	0f b6 1e             	movzbl (%esi),%ebx
 192:	84 db                	test   %bl,%bl
 194:	74 22                	je     1b8 <matchhere+0x78>
 196:	80 fa 2e             	cmp    $0x2e,%dl
 199:	74 04                	je     19f <matchhere+0x5f>
 19b:	38 d3                	cmp    %dl,%bl
 19d:	75 19                	jne    1b8 <matchhere+0x78>
 19f:	0f be d1             	movsbl %cl,%edx
    return matchhere(re+1, text+1);
 1a2:	46                   	inc    %esi
 1a3:	40                   	inc    %eax
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
 1a4:	84 d2                	test   %dl,%dl
 1a6:	75 d5                	jne    17d <matchhere+0x3d>
    return 1;
 1a8:	b8 01 00 00 00       	mov    $0x1,%eax
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
}
 1ad:	83 c4 10             	add    $0x10,%esp
 1b0:	5b                   	pop    %ebx
 1b1:	5e                   	pop    %esi
 1b2:	5d                   	pop    %ebp
 1b3:	c3                   	ret    
 1b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1b8:	83 c4 10             	add    $0x10,%esp
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
 1bb:	31 c0                	xor    %eax,%eax
}
 1bd:	5b                   	pop    %ebx
 1be:	5e                   	pop    %esi
 1bf:	5d                   	pop    %ebp
 1c0:	c3                   	ret    
// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
    return 1;
  if(re[1] == '*')
 1c1:	0f be d1             	movsbl %cl,%edx
    return matchstar(re[0], re+2, text);
 1c4:	83 c0 02             	add    $0x2,%eax
 1c7:	89 74 24 08          	mov    %esi,0x8(%esp)
 1cb:	89 44 24 04          	mov    %eax,0x4(%esp)
 1cf:	89 14 24             	mov    %edx,(%esp)
 1d2:	e8 09 ff ff ff       	call   e0 <matchstar>
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
}
 1d7:	83 c4 10             	add    $0x10,%esp
 1da:	5b                   	pop    %ebx
 1db:	5e                   	pop    %esi
 1dc:	5d                   	pop    %ebp
 1dd:	c3                   	ret    
  if(re[0] == '\0')
    return 1;
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
 1de:	31 c0                	xor    %eax,%eax
 1e0:	80 3e 00             	cmpb   $0x0,(%esi)
 1e3:	0f 94 c0             	sete   %al
 1e6:	eb c5                	jmp    1ad <matchhere+0x6d>
 1e8:	90                   	nop
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001f0 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	56                   	push   %esi
 1f4:	53                   	push   %ebx
 1f5:	83 ec 10             	sub    $0x10,%esp
 1f8:	8b 75 08             	mov    0x8(%ebp),%esi
 1fb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '^')
 1fe:	80 3e 5e             	cmpb   $0x5e,(%esi)
 201:	75 0c                	jne    20f <match+0x1f>
 203:	eb 26                	jmp    22b <match+0x3b>
 205:	8d 76 00             	lea    0x0(%esi),%esi
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
  }while(*text++ != '\0');
 208:	43                   	inc    %ebx
 209:	80 7b ff 00          	cmpb   $0x0,-0x1(%ebx)
 20d:	74 15                	je     224 <match+0x34>
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
 20f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 213:	89 34 24             	mov    %esi,(%esp)
 216:	e8 25 ff ff ff       	call   140 <matchhere>
 21b:	85 c0                	test   %eax,%eax
 21d:	74 e9                	je     208 <match+0x18>
      return 1;
 21f:	b8 01 00 00 00       	mov    $0x1,%eax
  }while(*text++ != '\0');
  return 0;
}
 224:	83 c4 10             	add    $0x10,%esp
 227:	5b                   	pop    %ebx
 228:	5e                   	pop    %esi
 229:	5d                   	pop    %ebp
 22a:	c3                   	ret    

int
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
 22b:	46                   	inc    %esi
 22c:	89 75 08             	mov    %esi,0x8(%ebp)
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
  }while(*text++ != '\0');
  return 0;
}
 22f:	83 c4 10             	add    $0x10,%esp
 232:	5b                   	pop    %ebx
 233:	5e                   	pop    %esi
 234:	5d                   	pop    %ebp

int
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
 235:	e9 06 ff ff ff       	jmp    140 <matchhere>
 23a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000240 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	56                   	push   %esi
 245:	53                   	push   %ebx
 246:	83 ec 2c             	sub    $0x2c,%esp
 249:	8b 75 08             	mov    0x8(%ebp),%esi
  int n, m;
  char *p, *q;

  m = 0;
 24c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 253:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 260:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 263:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 268:	29 c8                	sub    %ecx,%eax
 26a:	89 44 24 08          	mov    %eax,0x8(%esp)
 26e:	8d 81 20 0e 00 00    	lea    0xe20(%ecx),%eax
 274:	89 44 24 04          	mov    %eax,0x4(%esp)
 278:	8b 45 0c             	mov    0xc(%ebp),%eax
 27b:	89 04 24             	mov    %eax,(%esp)
 27e:	e8 1d 03 00 00       	call   5a0 <read>
 283:	85 c0                	test   %eax,%eax
 285:	0f 8e b1 00 00 00    	jle    33c <grep+0xfc>
    m += n;
 28b:	01 45 e4             	add    %eax,-0x1c(%ebp)
    buf[m] = '\0';
    p = buf;
 28e:	bb 20 0e 00 00       	mov    $0xe20,%ebx
  int n, m;
  char *p, *q;

  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    m += n;
 293:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    buf[m] = '\0';
 296:	c6 82 20 0e 00 00 00 	movb   $0x0,0xe20(%edx)
 29d:	8d 76 00             	lea    0x0(%esi),%esi
    p = buf;
    while((q = strchr(p, '\n')) != 0){
 2a0:	ba 0a 00 00 00       	mov    $0xa,%edx
 2a5:	89 54 24 04          	mov    %edx,0x4(%esp)
 2a9:	89 1c 24             	mov    %ebx,(%esp)
 2ac:	e8 4f 01 00 00       	call   400 <strchr>
 2b1:	85 c0                	test   %eax,%eax
 2b3:	89 c7                	mov    %eax,%edi
 2b5:	74 39                	je     2f0 <grep+0xb0>
      *q = 0;
 2b7:	c6 07 00             	movb   $0x0,(%edi)
      if(match(pattern, p)){
 2ba:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 2be:	89 34 24             	mov    %esi,(%esp)
 2c1:	e8 2a ff ff ff       	call   1f0 <match>
 2c6:	85 c0                	test   %eax,%eax
 2c8:	75 06                	jne    2d0 <grep+0x90>
 2ca:	8d 5f 01             	lea    0x1(%edi),%ebx
 2cd:	eb d1                	jmp    2a0 <grep+0x60>
 2cf:	90                   	nop
        *q = '\n';
 2d0:	c6 07 0a             	movb   $0xa,(%edi)
        write(1, p, q+1 - p);
 2d3:	47                   	inc    %edi
 2d4:	89 f8                	mov    %edi,%eax
 2d6:	29 d8                	sub    %ebx,%eax
 2d8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 2dc:	89 fb                	mov    %edi,%ebx
 2de:	89 44 24 08          	mov    %eax,0x8(%esp)
 2e2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2e9:	e8 ba 02 00 00       	call   5a8 <write>
 2ee:	eb b0                	jmp    2a0 <grep+0x60>
      }
      p = q+1;
    }
    if(p == buf)
 2f0:	81 fb 20 0e 00 00    	cmp    $0xe20,%ebx
 2f6:	74 38                	je     330 <grep+0xf0>
      m = 0;
    if(m > 0){
 2f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 2fb:	85 c0                	test   %eax,%eax
 2fd:	0f 8e 5d ff ff ff    	jle    260 <grep+0x20>
      m -= p - buf;
 303:	89 d8                	mov    %ebx,%eax
 305:	2d 20 0e 00 00       	sub    $0xe20,%eax
 30a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
      memmove(buf, p, m);
 30d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      p = q+1;
    }
    if(p == buf)
      m = 0;
    if(m > 0){
      m -= p - buf;
 311:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
      memmove(buf, p, m);
 314:	c7 04 24 20 0e 00 00 	movl   $0xe20,(%esp)
 31b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 31f:	e8 2c 02 00 00       	call   550 <memmove>
 324:	e9 37 ff ff ff       	jmp    260 <grep+0x20>
 329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        write(1, p, q+1 - p);
      }
      p = q+1;
    }
    if(p == buf)
      m = 0;
 330:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 337:	e9 24 ff ff ff       	jmp    260 <grep+0x20>
    if(m > 0){
      m -= p - buf;
      memmove(buf, p, m);
    }
  }
}
 33c:	83 c4 2c             	add    $0x2c,%esp
 33f:	5b                   	pop    %ebx
 340:	5e                   	pop    %esi
 341:	5f                   	pop    %edi
 342:	5d                   	pop    %ebp
 343:	c3                   	ret    
 344:	66 90                	xchg   %ax,%ax
 346:	66 90                	xchg   %ax,%ax
 348:	66 90                	xchg   %ax,%ax
 34a:	66 90                	xchg   %ax,%ax
 34c:	66 90                	xchg   %ax,%ax
 34e:	66 90                	xchg   %ax,%ax

00000350 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	8b 45 08             	mov    0x8(%ebp),%eax
 356:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 359:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 35a:	89 c2                	mov    %eax,%edx
 35c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 360:	41                   	inc    %ecx
 361:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 365:	42                   	inc    %edx
 366:	84 db                	test   %bl,%bl
 368:	88 5a ff             	mov    %bl,-0x1(%edx)
 36b:	75 f3                	jne    360 <strcpy+0x10>
    ;
  return os;
}
 36d:	5b                   	pop    %ebx
 36e:	5d                   	pop    %ebp
 36f:	c3                   	ret    

00000370 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	8b 4d 08             	mov    0x8(%ebp),%ecx
 376:	56                   	push   %esi
 377:	53                   	push   %ebx
 378:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 37b:	0f b6 01             	movzbl (%ecx),%eax
 37e:	0f b6 13             	movzbl (%ebx),%edx
 381:	84 c0                	test   %al,%al
 383:	75 1c                	jne    3a1 <strcmp+0x31>
 385:	eb 29                	jmp    3b0 <strcmp+0x40>
 387:	89 f6                	mov    %esi,%esi
 389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 390:	41                   	inc    %ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 391:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 394:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 397:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 39b:	84 c0                	test   %al,%al
 39d:	74 11                	je     3b0 <strcmp+0x40>
 39f:	89 f3                	mov    %esi,%ebx
 3a1:	38 d0                	cmp    %dl,%al
 3a3:	74 eb                	je     390 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 3a5:	5b                   	pop    %ebx
int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3a6:	29 d0                	sub    %edx,%eax
}
 3a8:	5e                   	pop    %esi
 3a9:	5d                   	pop    %ebp
 3aa:	c3                   	ret    
 3ab:	90                   	nop
 3ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3b0:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3b1:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3b3:	29 d0                	sub    %edx,%eax
}
 3b5:	5e                   	pop    %esi
 3b6:	5d                   	pop    %ebp
 3b7:	c3                   	ret    
 3b8:	90                   	nop
 3b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003c0 <strlen>:

uint
strlen(const char *s)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 3c6:	80 39 00             	cmpb   $0x0,(%ecx)
 3c9:	74 10                	je     3db <strlen+0x1b>
 3cb:	31 d2                	xor    %edx,%edx
 3cd:	8d 76 00             	lea    0x0(%esi),%esi
 3d0:	42                   	inc    %edx
 3d1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 3d5:	89 d0                	mov    %edx,%eax
 3d7:	75 f7                	jne    3d0 <strlen+0x10>
    ;
  return n;
}
 3d9:	5d                   	pop    %ebp
 3da:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 3db:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 3dd:	5d                   	pop    %ebp
 3de:	c3                   	ret    
 3df:	90                   	nop

000003e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	8b 55 08             	mov    0x8(%ebp),%edx
 3e6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ed:	89 d7                	mov    %edx,%edi
 3ef:	fc                   	cld    
 3f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3f2:	5f                   	pop    %edi
 3f3:	89 d0                	mov    %edx,%eax
 3f5:	5d                   	pop    %ebp
 3f6:	c3                   	ret    
 3f7:	89 f6                	mov    %esi,%esi
 3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000400 <strchr>:

char*
strchr(const char *s, char c)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	8b 45 08             	mov    0x8(%ebp),%eax
 406:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 40a:	0f b6 10             	movzbl (%eax),%edx
 40d:	84 d2                	test   %dl,%dl
 40f:	74 1b                	je     42c <strchr+0x2c>
    if(*s == c)
 411:	38 d1                	cmp    %dl,%cl
 413:	75 0f                	jne    424 <strchr+0x24>
 415:	eb 17                	jmp    42e <strchr+0x2e>
 417:	89 f6                	mov    %esi,%esi
 419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 420:	38 ca                	cmp    %cl,%dl
 422:	74 0a                	je     42e <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 424:	40                   	inc    %eax
 425:	0f b6 10             	movzbl (%eax),%edx
 428:	84 d2                	test   %dl,%dl
 42a:	75 f4                	jne    420 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 42c:	31 c0                	xor    %eax,%eax
}
 42e:	5d                   	pop    %ebp
 42f:	c3                   	ret    

00000430 <gets>:

char*
gets(char *buf, int max)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	57                   	push   %edi
 434:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 435:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
 437:	53                   	push   %ebx
 438:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 43b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 43e:	eb 32                	jmp    472 <gets+0x42>
    cc = read(0, &c, 1);
 440:	b8 01 00 00 00       	mov    $0x1,%eax
 445:	89 44 24 08          	mov    %eax,0x8(%esp)
 449:	89 7c 24 04          	mov    %edi,0x4(%esp)
 44d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 454:	e8 47 01 00 00       	call   5a0 <read>
    if(cc < 1)
 459:	85 c0                	test   %eax,%eax
 45b:	7e 1d                	jle    47a <gets+0x4a>
      break;
    buf[i++] = c;
 45d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 461:	89 de                	mov    %ebx,%esi
 463:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 466:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 468:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 46c:	74 22                	je     490 <gets+0x60>
 46e:	3c 0d                	cmp    $0xd,%al
 470:	74 1e                	je     490 <gets+0x60>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 472:	8d 5e 01             	lea    0x1(%esi),%ebx
 475:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 478:	7c c6                	jl     440 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 47a:	8b 45 08             	mov    0x8(%ebp),%eax
 47d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 481:	83 c4 2c             	add    $0x2c,%esp
 484:	5b                   	pop    %ebx
 485:	5e                   	pop    %esi
 486:	5f                   	pop    %edi
 487:	5d                   	pop    %ebp
 488:	c3                   	ret    
 489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 490:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 493:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 495:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 499:	83 c4 2c             	add    $0x2c,%esp
 49c:	5b                   	pop    %ebx
 49d:	5e                   	pop    %esi
 49e:	5f                   	pop    %edi
 49f:	5d                   	pop    %ebp
 4a0:	c3                   	ret    
 4a1:	eb 0d                	jmp    4b0 <stat>
 4a3:	90                   	nop
 4a4:	90                   	nop
 4a5:	90                   	nop
 4a6:	90                   	nop
 4a7:	90                   	nop
 4a8:	90                   	nop
 4a9:	90                   	nop
 4aa:	90                   	nop
 4ab:	90                   	nop
 4ac:	90                   	nop
 4ad:	90                   	nop
 4ae:	90                   	nop
 4af:	90                   	nop

000004b0 <stat>:

int
stat(const char *n, struct stat *st)
{
 4b0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4b1:	31 c0                	xor    %eax,%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 4b3:	89 e5                	mov    %esp,%ebp
 4b5:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4b8:	89 44 24 04          	mov    %eax,0x4(%esp)
 4bc:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 4bf:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 4c2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4c5:	89 04 24             	mov    %eax,(%esp)
 4c8:	e8 fb 00 00 00       	call   5c8 <open>
  if(fd < 0)
 4cd:	85 c0                	test   %eax,%eax
 4cf:	78 2f                	js     500 <stat+0x50>
 4d1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 4d3:	8b 45 0c             	mov    0xc(%ebp),%eax
 4d6:	89 1c 24             	mov    %ebx,(%esp)
 4d9:	89 44 24 04          	mov    %eax,0x4(%esp)
 4dd:	e8 fe 00 00 00       	call   5e0 <fstat>
  close(fd);
 4e2:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 4e5:	89 c6                	mov    %eax,%esi
  close(fd);
 4e7:	e8 c4 00 00 00       	call   5b0 <close>
  return r;
 4ec:	89 f0                	mov    %esi,%eax
}
 4ee:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 4f1:	8b 75 fc             	mov    -0x4(%ebp),%esi
 4f4:	89 ec                	mov    %ebp,%esp
 4f6:	5d                   	pop    %ebp
 4f7:	c3                   	ret    
 4f8:	90                   	nop
 4f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 500:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 505:	eb e7                	jmp    4ee <stat+0x3e>
 507:	89 f6                	mov    %esi,%esi
 509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000510 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	8b 4d 08             	mov    0x8(%ebp),%ecx
 516:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 517:	0f be 11             	movsbl (%ecx),%edx
 51a:	88 d0                	mov    %dl,%al
 51c:	2c 30                	sub    $0x30,%al
 51e:	3c 09                	cmp    $0x9,%al
 520:	b8 00 00 00 00       	mov    $0x0,%eax
 525:	77 1e                	ja     545 <atoi+0x35>
 527:	89 f6                	mov    %esi,%esi
 529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 530:	41                   	inc    %ecx
 531:	8d 04 80             	lea    (%eax,%eax,4),%eax
 534:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 538:	0f be 11             	movsbl (%ecx),%edx
 53b:	88 d3                	mov    %dl,%bl
 53d:	80 eb 30             	sub    $0x30,%bl
 540:	80 fb 09             	cmp    $0x9,%bl
 543:	76 eb                	jbe    530 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 545:	5b                   	pop    %ebx
 546:	5d                   	pop    %ebp
 547:	c3                   	ret    
 548:	90                   	nop
 549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000550 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	56                   	push   %esi
 554:	8b 45 08             	mov    0x8(%ebp),%eax
 557:	53                   	push   %ebx
 558:	8b 5d 10             	mov    0x10(%ebp),%ebx
 55b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 55e:	85 db                	test   %ebx,%ebx
 560:	7e 1a                	jle    57c <memmove+0x2c>
 562:	31 d2                	xor    %edx,%edx
 564:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 56a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 570:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 574:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 577:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 578:	39 da                	cmp    %ebx,%edx
 57a:	75 f4                	jne    570 <memmove+0x20>
    *dst++ = *src++;
  return vdst;
}
 57c:	5b                   	pop    %ebx
 57d:	5e                   	pop    %esi
 57e:	5d                   	pop    %ebp
 57f:	c3                   	ret    

00000580 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 580:	b8 01 00 00 00       	mov    $0x1,%eax
 585:	cd 40                	int    $0x40
 587:	c3                   	ret    

00000588 <exit>:
SYSCALL(exit)
 588:	b8 02 00 00 00       	mov    $0x2,%eax
 58d:	cd 40                	int    $0x40
 58f:	c3                   	ret    

00000590 <wait>:
SYSCALL(wait)
 590:	b8 03 00 00 00       	mov    $0x3,%eax
 595:	cd 40                	int    $0x40
 597:	c3                   	ret    

00000598 <pipe>:
SYSCALL(pipe)
 598:	b8 04 00 00 00       	mov    $0x4,%eax
 59d:	cd 40                	int    $0x40
 59f:	c3                   	ret    

000005a0 <read>:
SYSCALL(read)
 5a0:	b8 05 00 00 00       	mov    $0x5,%eax
 5a5:	cd 40                	int    $0x40
 5a7:	c3                   	ret    

000005a8 <write>:
SYSCALL(write)
 5a8:	b8 10 00 00 00       	mov    $0x10,%eax
 5ad:	cd 40                	int    $0x40
 5af:	c3                   	ret    

000005b0 <close>:
SYSCALL(close)
 5b0:	b8 15 00 00 00       	mov    $0x15,%eax
 5b5:	cd 40                	int    $0x40
 5b7:	c3                   	ret    

000005b8 <kill>:
SYSCALL(kill)
 5b8:	b8 06 00 00 00       	mov    $0x6,%eax
 5bd:	cd 40                	int    $0x40
 5bf:	c3                   	ret    

000005c0 <exec>:
SYSCALL(exec)
 5c0:	b8 07 00 00 00       	mov    $0x7,%eax
 5c5:	cd 40                	int    $0x40
 5c7:	c3                   	ret    

000005c8 <open>:
SYSCALL(open)
 5c8:	b8 0f 00 00 00       	mov    $0xf,%eax
 5cd:	cd 40                	int    $0x40
 5cf:	c3                   	ret    

000005d0 <mknod>:
SYSCALL(mknod)
 5d0:	b8 11 00 00 00       	mov    $0x11,%eax
 5d5:	cd 40                	int    $0x40
 5d7:	c3                   	ret    

000005d8 <unlink>:
SYSCALL(unlink)
 5d8:	b8 12 00 00 00       	mov    $0x12,%eax
 5dd:	cd 40                	int    $0x40
 5df:	c3                   	ret    

000005e0 <fstat>:
SYSCALL(fstat)
 5e0:	b8 08 00 00 00       	mov    $0x8,%eax
 5e5:	cd 40                	int    $0x40
 5e7:	c3                   	ret    

000005e8 <link>:
SYSCALL(link)
 5e8:	b8 13 00 00 00       	mov    $0x13,%eax
 5ed:	cd 40                	int    $0x40
 5ef:	c3                   	ret    

000005f0 <mkdir>:
SYSCALL(mkdir)
 5f0:	b8 14 00 00 00       	mov    $0x14,%eax
 5f5:	cd 40                	int    $0x40
 5f7:	c3                   	ret    

000005f8 <chdir>:
SYSCALL(chdir)
 5f8:	b8 09 00 00 00       	mov    $0x9,%eax
 5fd:	cd 40                	int    $0x40
 5ff:	c3                   	ret    

00000600 <dup>:
SYSCALL(dup)
 600:	b8 0a 00 00 00       	mov    $0xa,%eax
 605:	cd 40                	int    $0x40
 607:	c3                   	ret    

00000608 <getpid>:
SYSCALL(getpid)
 608:	b8 0b 00 00 00       	mov    $0xb,%eax
 60d:	cd 40                	int    $0x40
 60f:	c3                   	ret    

00000610 <sbrk>:
SYSCALL(sbrk)
 610:	b8 0c 00 00 00       	mov    $0xc,%eax
 615:	cd 40                	int    $0x40
 617:	c3                   	ret    

00000618 <sleep>:
SYSCALL(sleep)
 618:	b8 0d 00 00 00       	mov    $0xd,%eax
 61d:	cd 40                	int    $0x40
 61f:	c3                   	ret    

00000620 <uptime>:
SYSCALL(uptime)
 620:	b8 0e 00 00 00       	mov    $0xe,%eax
 625:	cd 40                	int    $0x40
 627:	c3                   	ret    

00000628 <policy>:
SYSCALL(policy)
 628:	b8 17 00 00 00       	mov    $0x17,%eax
 62d:	cd 40                	int    $0x40
 62f:	c3                   	ret    

00000630 <detach>:
SYSCALL(detach)
 630:	b8 16 00 00 00       	mov    $0x16,%eax
 635:	cd 40                	int    $0x40
 637:	c3                   	ret    

00000638 <priority>:
SYSCALL(priority)
 638:	b8 18 00 00 00       	mov    $0x18,%eax
 63d:	cd 40                	int    $0x40
 63f:	c3                   	ret    

00000640 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	57                   	push   %edi
 644:	56                   	push   %esi
 645:	89 c6                	mov    %eax,%esi
 647:	53                   	push   %ebx
 648:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 64b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 64e:	85 db                	test   %ebx,%ebx
 650:	0f 84 8a 00 00 00    	je     6e0 <printint+0xa0>
 656:	89 d0                	mov    %edx,%eax
 658:	c1 e8 1f             	shr    $0x1f,%eax
 65b:	84 c0                	test   %al,%al
 65d:	0f 84 7d 00 00 00    	je     6e0 <printint+0xa0>
    neg = 1;
    x = -xx;
 663:	89 d0                	mov    %edx,%eax
 665:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 667:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 66e:	89 75 c0             	mov    %esi,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 671:	31 ff                	xor    %edi,%edi
 673:	89 ce                	mov    %ecx,%esi
 675:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 678:	eb 08                	jmp    682 <printint+0x42>
 67a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 680:	89 cf                	mov    %ecx,%edi
 682:	31 d2                	xor    %edx,%edx
 684:	f7 f6                	div    %esi
 686:	8d 4f 01             	lea    0x1(%edi),%ecx
 689:	0f b6 92 90 0a 00 00 	movzbl 0xa90(%edx),%edx
  }while((x /= base) != 0);
 690:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 692:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 695:	75 e9                	jne    680 <printint+0x40>
  if(neg)
 697:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 69a:	8b 75 c0             	mov    -0x40(%ebp),%esi
 69d:	85 d2                	test   %edx,%edx
 69f:	74 08                	je     6a9 <printint+0x69>
    buf[i++] = '-';
 6a1:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 6a6:	8d 4f 02             	lea    0x2(%edi),%ecx
 6a9:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 6ad:	8d 76 00             	lea    0x0(%esi),%esi
 6b0:	0f b6 07             	movzbl (%edi),%eax
 6b3:	4f                   	dec    %edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6b4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 6b8:	89 34 24             	mov    %esi,(%esp)
 6bb:	88 45 d7             	mov    %al,-0x29(%ebp)
 6be:	b8 01 00 00 00       	mov    $0x1,%eax
 6c3:	89 44 24 08          	mov    %eax,0x8(%esp)
 6c7:	e8 dc fe ff ff       	call   5a8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 6cc:	39 df                	cmp    %ebx,%edi
 6ce:	75 e0                	jne    6b0 <printint+0x70>
    putc(fd, buf[i]);
}
 6d0:	83 c4 4c             	add    $0x4c,%esp
 6d3:	5b                   	pop    %ebx
 6d4:	5e                   	pop    %esi
 6d5:	5f                   	pop    %edi
 6d6:	5d                   	pop    %ebp
 6d7:	c3                   	ret    
 6d8:	90                   	nop
 6d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6e0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 6e2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 6e9:	eb 83                	jmp    66e <printint+0x2e>
 6eb:	90                   	nop
 6ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006f0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	57                   	push   %edi
 6f4:	56                   	push   %esi
 6f5:	53                   	push   %ebx
 6f6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6f9:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 6fc:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6ff:	0f b6 1e             	movzbl (%esi),%ebx
 702:	84 db                	test   %bl,%bl
 704:	0f 84 c6 00 00 00    	je     7d0 <printf+0xe0>
 70a:	8d 45 10             	lea    0x10(%ebp),%eax
 70d:	46                   	inc    %esi
 70e:	89 45 d0             	mov    %eax,-0x30(%ebp)
 711:	31 d2                	xor    %edx,%edx
 713:	eb 3b                	jmp    750 <printf+0x60>
 715:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 718:	83 f8 25             	cmp    $0x25,%eax
 71b:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 71e:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 723:	74 1e                	je     743 <printf+0x53>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 725:	b8 01 00 00 00       	mov    $0x1,%eax
 72a:	89 44 24 08          	mov    %eax,0x8(%esp)
 72e:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 731:	89 44 24 04          	mov    %eax,0x4(%esp)
 735:	89 3c 24             	mov    %edi,(%esp)
 738:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 73b:	e8 68 fe ff ff       	call   5a8 <write>
 740:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 743:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 744:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 748:	84 db                	test   %bl,%bl
 74a:	0f 84 80 00 00 00    	je     7d0 <printf+0xe0>
    c = fmt[i] & 0xff;
    if(state == 0){
 750:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 752:	0f be cb             	movsbl %bl,%ecx
 755:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 758:	74 be                	je     718 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 75a:	83 fa 25             	cmp    $0x25,%edx
 75d:	75 e4                	jne    743 <printf+0x53>
      if(c == 'd'){
 75f:	83 f8 64             	cmp    $0x64,%eax
 762:	0f 84 20 01 00 00    	je     888 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 768:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 76e:	83 f9 70             	cmp    $0x70,%ecx
 771:	74 6d                	je     7e0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 773:	83 f8 73             	cmp    $0x73,%eax
 776:	0f 84 94 00 00 00    	je     810 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 77c:	83 f8 63             	cmp    $0x63,%eax
 77f:	0f 84 14 01 00 00    	je     899 <printf+0x1a9>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 785:	83 f8 25             	cmp    $0x25,%eax
 788:	0f 84 d2 00 00 00    	je     860 <printf+0x170>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 78e:	b8 01 00 00 00       	mov    $0x1,%eax
 793:	46                   	inc    %esi
 794:	89 44 24 08          	mov    %eax,0x8(%esp)
 798:	8d 45 e7             	lea    -0x19(%ebp),%eax
 79b:	89 44 24 04          	mov    %eax,0x4(%esp)
 79f:	89 3c 24             	mov    %edi,(%esp)
 7a2:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 7a6:	e8 fd fd ff ff       	call   5a8 <write>
 7ab:	ba 01 00 00 00       	mov    $0x1,%edx
 7b0:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 7b3:	89 54 24 08          	mov    %edx,0x8(%esp)
 7b7:	89 44 24 04          	mov    %eax,0x4(%esp)
 7bb:	89 3c 24             	mov    %edi,(%esp)
 7be:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 7c1:	e8 e2 fd ff ff       	call   5a8 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7c6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7ca:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7cc:	84 db                	test   %bl,%bl
 7ce:	75 80                	jne    750 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 7d0:	83 c4 3c             	add    $0x3c,%esp
 7d3:	5b                   	pop    %ebx
 7d4:	5e                   	pop    %esi
 7d5:	5f                   	pop    %edi
 7d6:	5d                   	pop    %ebp
 7d7:	c3                   	ret    
 7d8:	90                   	nop
 7d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 7e0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 7e7:	b9 10 00 00 00       	mov    $0x10,%ecx
 7ec:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 7ef:	89 f8                	mov    %edi,%eax
 7f1:	8b 13                	mov    (%ebx),%edx
 7f3:	e8 48 fe ff ff       	call   640 <printint>
        ap++;
 7f8:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7fa:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 7fc:	83 c0 04             	add    $0x4,%eax
 7ff:	89 45 d0             	mov    %eax,-0x30(%ebp)
 802:	e9 3c ff ff ff       	jmp    743 <printf+0x53>
 807:	89 f6                	mov    %esi,%esi
 809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      } else if(c == 's'){
        s = (char*)*ap;
 810:	8b 45 d0             	mov    -0x30(%ebp),%eax
 813:	8b 18                	mov    (%eax),%ebx
        ap++;
 815:	83 c0 04             	add    $0x4,%eax
 818:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 81b:	b8 86 0a 00 00       	mov    $0xa86,%eax
 820:	85 db                	test   %ebx,%ebx
 822:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 825:	0f b6 03             	movzbl (%ebx),%eax
 828:	84 c0                	test   %al,%al
 82a:	74 27                	je     853 <printf+0x163>
 82c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 830:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 833:	b8 01 00 00 00       	mov    $0x1,%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 838:	43                   	inc    %ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 839:	89 44 24 08          	mov    %eax,0x8(%esp)
 83d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 840:	89 44 24 04          	mov    %eax,0x4(%esp)
 844:	89 3c 24             	mov    %edi,(%esp)
 847:	e8 5c fd ff ff       	call   5a8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 84c:	0f b6 03             	movzbl (%ebx),%eax
 84f:	84 c0                	test   %al,%al
 851:	75 dd                	jne    830 <printf+0x140>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 853:	31 d2                	xor    %edx,%edx
 855:	e9 e9 fe ff ff       	jmp    743 <printf+0x53>
 85a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 860:	b9 01 00 00 00       	mov    $0x1,%ecx
 865:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 868:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 86c:	89 44 24 04          	mov    %eax,0x4(%esp)
 870:	89 3c 24             	mov    %edi,(%esp)
 873:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 876:	e8 2d fd ff ff       	call   5a8 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 87b:	31 d2                	xor    %edx,%edx
 87d:	e9 c1 fe ff ff       	jmp    743 <printf+0x53>
 882:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 888:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 88f:	b9 0a 00 00 00       	mov    $0xa,%ecx
 894:	e9 53 ff ff ff       	jmp    7ec <printf+0xfc>
 899:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 89c:	8b 03                	mov    (%ebx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 89e:	89 3c 24             	mov    %edi,(%esp)
 8a1:	88 45 e4             	mov    %al,-0x1c(%ebp)
 8a4:	b8 01 00 00 00       	mov    $0x1,%eax
 8a9:	89 44 24 08          	mov    %eax,0x8(%esp)
 8ad:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 8b0:	89 44 24 04          	mov    %eax,0x4(%esp)
 8b4:	e8 ef fc ff ff       	call   5a8 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 8b9:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8bb:	31 d2                	xor    %edx,%edx
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 8bd:	83 c0 04             	add    $0x4,%eax
 8c0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 8c3:	e9 7b fe ff ff       	jmp    743 <printf+0x53>
 8c8:	66 90                	xchg   %ax,%ax
 8ca:	66 90                	xchg   %ax,%ax
 8cc:	66 90                	xchg   %ax,%ax
 8ce:	66 90                	xchg   %ax,%ax

000008d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d1:	a1 00 0e 00 00       	mov    0xe00,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 8d6:	89 e5                	mov    %esp,%ebp
 8d8:	57                   	push   %edi
 8d9:	56                   	push   %esi
 8da:	53                   	push   %ebx
 8db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8de:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8e0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8e3:	39 c8                	cmp    %ecx,%eax
 8e5:	73 19                	jae    900 <free+0x30>
 8e7:	89 f6                	mov    %esi,%esi
 8e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 8f0:	39 d1                	cmp    %edx,%ecx
 8f2:	72 1c                	jb     910 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8f4:	39 d0                	cmp    %edx,%eax
 8f6:	73 18                	jae    910 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 8f8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8fa:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8fc:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8fe:	72 f0                	jb     8f0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 900:	39 d0                	cmp    %edx,%eax
 902:	72 f4                	jb     8f8 <free+0x28>
 904:	39 d1                	cmp    %edx,%ecx
 906:	73 f0                	jae    8f8 <free+0x28>
 908:	90                   	nop
 909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 910:	8b 73 fc             	mov    -0x4(%ebx),%esi
 913:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 916:	39 d7                	cmp    %edx,%edi
 918:	74 19                	je     933 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 91a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 91d:	8b 50 04             	mov    0x4(%eax),%edx
 920:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 923:	39 f1                	cmp    %esi,%ecx
 925:	74 25                	je     94c <free+0x7c>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 927:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 929:	5b                   	pop    %ebx
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 92a:	a3 00 0e 00 00       	mov    %eax,0xe00
}
 92f:	5e                   	pop    %esi
 930:	5f                   	pop    %edi
 931:	5d                   	pop    %ebp
 932:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 933:	8b 7a 04             	mov    0x4(%edx),%edi
 936:	01 fe                	add    %edi,%esi
 938:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 93b:	8b 10                	mov    (%eax),%edx
 93d:	8b 12                	mov    (%edx),%edx
 93f:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 942:	8b 50 04             	mov    0x4(%eax),%edx
 945:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 948:	39 f1                	cmp    %esi,%ecx
 94a:	75 db                	jne    927 <free+0x57>
    p->s.size += bp->s.size;
 94c:	8b 4b fc             	mov    -0x4(%ebx),%ecx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 94f:	a3 00 0e 00 00       	mov    %eax,0xe00
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 954:	01 ca                	add    %ecx,%edx
 956:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 959:	8b 53 f8             	mov    -0x8(%ebx),%edx
 95c:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 95e:	5b                   	pop    %ebx
 95f:	5e                   	pop    %esi
 960:	5f                   	pop    %edi
 961:	5d                   	pop    %ebp
 962:	c3                   	ret    
 963:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000970 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 970:	55                   	push   %ebp
 971:	89 e5                	mov    %esp,%ebp
 973:	57                   	push   %edi
 974:	56                   	push   %esi
 975:	53                   	push   %ebx
 976:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 979:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 97c:	8b 15 00 0e 00 00    	mov    0xe00,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 982:	8d 78 07             	lea    0x7(%eax),%edi
 985:	c1 ef 03             	shr    $0x3,%edi
 988:	47                   	inc    %edi
  if((prevp = freep) == 0){
 989:	85 d2                	test   %edx,%edx
 98b:	0f 84 95 00 00 00    	je     a26 <malloc+0xb6>
 991:	8b 02                	mov    (%edx),%eax
 993:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 996:	39 cf                	cmp    %ecx,%edi
 998:	76 66                	jbe    a00 <malloc+0x90>
 99a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 9a0:	be 00 10 00 00       	mov    $0x1000,%esi
 9a5:	0f 43 f7             	cmovae %edi,%esi
 9a8:	ba 00 80 00 00       	mov    $0x8000,%edx
 9ad:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 9b4:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 9ba:	0f 46 da             	cmovbe %edx,%ebx
 9bd:	eb 0a                	jmp    9c9 <malloc+0x59>
 9bf:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9c0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 9c2:	8b 48 04             	mov    0x4(%eax),%ecx
 9c5:	39 cf                	cmp    %ecx,%edi
 9c7:	76 37                	jbe    a00 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9c9:	39 05 00 0e 00 00    	cmp    %eax,0xe00
 9cf:	89 c2                	mov    %eax,%edx
 9d1:	75 ed                	jne    9c0 <malloc+0x50>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 9d3:	89 1c 24             	mov    %ebx,(%esp)
 9d6:	e8 35 fc ff ff       	call   610 <sbrk>
  if(p == (char*)-1)
 9db:	83 f8 ff             	cmp    $0xffffffff,%eax
 9de:	74 18                	je     9f8 <malloc+0x88>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 9e0:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 9e3:	83 c0 08             	add    $0x8,%eax
 9e6:	89 04 24             	mov    %eax,(%esp)
 9e9:	e8 e2 fe ff ff       	call   8d0 <free>
  return freep;
 9ee:	8b 15 00 0e 00 00    	mov    0xe00,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 9f4:	85 d2                	test   %edx,%edx
 9f6:	75 c8                	jne    9c0 <malloc+0x50>
        return 0;
 9f8:	31 c0                	xor    %eax,%eax
 9fa:	eb 1c                	jmp    a18 <malloc+0xa8>
 9fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 a00:	39 cf                	cmp    %ecx,%edi
 a02:	74 1c                	je     a20 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 a04:	29 f9                	sub    %edi,%ecx
 a06:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 a09:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 a0c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 a0f:	89 15 00 0e 00 00    	mov    %edx,0xe00
      return (void*)(p + 1);
 a15:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a18:	83 c4 1c             	add    $0x1c,%esp
 a1b:	5b                   	pop    %ebx
 a1c:	5e                   	pop    %esi
 a1d:	5f                   	pop    %edi
 a1e:	5d                   	pop    %ebp
 a1f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 a20:	8b 08                	mov    (%eax),%ecx
 a22:	89 0a                	mov    %ecx,(%edx)
 a24:	eb e9                	jmp    a0f <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 a26:	b8 04 0e 00 00       	mov    $0xe04,%eax
 a2b:	ba 04 0e 00 00       	mov    $0xe04,%edx
    base.s.size = 0;
 a30:	31 c9                	xor    %ecx,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 a32:	a3 00 0e 00 00       	mov    %eax,0xe00
    base.s.size = 0;
 a37:	b8 04 0e 00 00       	mov    $0xe04,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 a3c:	89 15 04 0e 00 00    	mov    %edx,0xe04
    base.s.size = 0;
 a42:	89 0d 08 0e 00 00    	mov    %ecx,0xe08
 a48:	e9 4d ff ff ff       	jmp    99a <malloc+0x2a>
