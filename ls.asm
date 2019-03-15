
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  close(fd);
}

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	56                   	push   %esi
   4:	53                   	push   %ebx
   5:	83 e4 f0             	and    $0xfffffff0,%esp
   8:	83 ec 10             	sub    $0x10,%esp
   b:	8b 45 08             	mov    0x8(%ebp),%eax
   e:	8b 55 0c             	mov    0xc(%ebp),%edx
  int i;

  if(argc < 2){
  11:	83 f8 01             	cmp    $0x1,%eax
  14:	7e 20                	jle    36 <main+0x36>
  16:	8d 5a 04             	lea    0x4(%edx),%ebx
  19:	8d 34 82             	lea    (%edx,%eax,4),%esi
  1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
  20:	8b 03                	mov    (%ebx),%eax
  22:	83 c3 04             	add    $0x4,%ebx
  25:	89 04 24             	mov    %eax,(%esp)
  28:	e8 c3 00 00 00       	call   f0 <ls>
  for(i=1; i<argc; i++)
  2d:	39 f3                	cmp    %esi,%ebx
  2f:	75 ef                	jne    20 <main+0x20>
  exit();
  31:	e8 62 05 00 00       	call   598 <exit>
    ls(".");
  36:	c7 04 24 a0 0a 00 00 	movl   $0xaa0,(%esp)
  3d:	e8 ae 00 00 00       	call   f0 <ls>
    exit();
  42:	e8 51 05 00 00       	call   598 <exit>
  47:	66 90                	xchg   %ax,%ax
  49:	66 90                	xchg   %ax,%ax
  4b:	66 90                	xchg   %ax,%ax
  4d:	66 90                	xchg   %ax,%ax
  4f:	90                   	nop

00000050 <fmtname>:
{
  50:	55                   	push   %ebp
  51:	89 e5                	mov    %esp,%ebp
  53:	56                   	push   %esi
  54:	53                   	push   %ebx
  55:	83 ec 10             	sub    $0x10,%esp
  58:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  5b:	89 1c 24             	mov    %ebx,(%esp)
  5e:	e8 6d 03 00 00       	call   3d0 <strlen>
  63:	01 d8                	add    %ebx,%eax
  65:	73 0e                	jae    75 <fmtname+0x25>
  67:	eb 11                	jmp    7a <fmtname+0x2a>
  69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  70:	48                   	dec    %eax
  71:	39 c3                	cmp    %eax,%ebx
  73:	77 05                	ja     7a <fmtname+0x2a>
  75:	80 38 2f             	cmpb   $0x2f,(%eax)
  78:	75 f6                	jne    70 <fmtname+0x20>
  p++;
  7a:	8d 58 01             	lea    0x1(%eax),%ebx
  if(strlen(p) >= DIRSIZ)
  7d:	89 1c 24             	mov    %ebx,(%esp)
  80:	e8 4b 03 00 00       	call   3d0 <strlen>
  85:	83 f8 0d             	cmp    $0xd,%eax
  88:	77 54                	ja     de <fmtname+0x8e>
  memmove(buf, p, strlen(p));
  8a:	89 1c 24             	mov    %ebx,(%esp)
  8d:	e8 3e 03 00 00       	call   3d0 <strlen>
  92:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  96:	c7 04 24 b0 0d 00 00 	movl   $0xdb0,(%esp)
  9d:	89 44 24 08          	mov    %eax,0x8(%esp)
  a1:	e8 ba 04 00 00       	call   560 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  a6:	89 1c 24             	mov    %ebx,(%esp)
  a9:	e8 22 03 00 00       	call   3d0 <strlen>
  ae:	89 1c 24             	mov    %ebx,(%esp)
  return buf;
  b1:	bb b0 0d 00 00       	mov    $0xdb0,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  b6:	89 c6                	mov    %eax,%esi
  b8:	e8 13 03 00 00       	call   3d0 <strlen>
  bd:	ba 0e 00 00 00       	mov    $0xe,%edx
  c2:	29 f2                	sub    %esi,%edx
  c4:	89 54 24 08          	mov    %edx,0x8(%esp)
  c8:	ba 20 00 00 00       	mov    $0x20,%edx
  cd:	89 54 24 04          	mov    %edx,0x4(%esp)
  d1:	05 b0 0d 00 00       	add    $0xdb0,%eax
  d6:	89 04 24             	mov    %eax,(%esp)
  d9:	e8 22 03 00 00       	call   400 <memset>
}
  de:	83 c4 10             	add    $0x10,%esp
  e1:	89 d8                	mov    %ebx,%eax
  e3:	5b                   	pop    %ebx
  e4:	5e                   	pop    %esi
  e5:	5d                   	pop    %ebp
  e6:	c3                   	ret    
  e7:	89 f6                	mov    %esi,%esi
  e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000f0 <ls>:
{
  f0:	55                   	push   %ebp
  if((fd = open(path, 0)) < 0){
  f1:	31 c0                	xor    %eax,%eax
{
  f3:	89 e5                	mov    %esp,%ebp
  f5:	81 ec 88 02 00 00    	sub    $0x288,%esp
  fb:	89 7d fc             	mov    %edi,-0x4(%ebp)
  fe:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((fd = open(path, 0)) < 0){
 101:	89 44 24 04          	mov    %eax,0x4(%esp)
{
 105:	89 5d f4             	mov    %ebx,-0xc(%ebp)
 108:	89 75 f8             	mov    %esi,-0x8(%ebp)
  if((fd = open(path, 0)) < 0){
 10b:	89 3c 24             	mov    %edi,(%esp)
 10e:	e8 c5 04 00 00       	call   5d8 <open>
 113:	85 c0                	test   %eax,%eax
 115:	78 49                	js     160 <ls+0x70>
  if(fstat(fd, &st) < 0){
 117:	8d b5 d4 fd ff ff    	lea    -0x22c(%ebp),%esi
 11d:	89 c3                	mov    %eax,%ebx
 11f:	89 74 24 04          	mov    %esi,0x4(%esp)
 123:	89 04 24             	mov    %eax,(%esp)
 126:	e8 c5 04 00 00       	call   5f0 <fstat>
 12b:	85 c0                	test   %eax,%eax
 12d:	0f 88 dd 00 00 00    	js     210 <ls+0x120>
  switch(st.type){
 133:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
 13a:	83 f8 01             	cmp    $0x1,%eax
 13d:	0f 84 9d 00 00 00    	je     1e0 <ls+0xf0>
 143:	83 f8 02             	cmp    $0x2,%eax
 146:	74 48                	je     190 <ls+0xa0>
  close(fd);
 148:	89 1c 24             	mov    %ebx,(%esp)
 14b:	e8 70 04 00 00       	call   5c0 <close>
}
 150:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 153:	8b 75 f8             	mov    -0x8(%ebp),%esi
 156:	8b 7d fc             	mov    -0x4(%ebp),%edi
 159:	89 ec                	mov    %ebp,%esp
 15b:	5d                   	pop    %ebp
 15c:	c3                   	ret    
 15d:	8d 76 00             	lea    0x0(%esi),%esi
    printf(2, "ls: cannot open %s\n", path);
 160:	89 7c 24 08          	mov    %edi,0x8(%esp)
 164:	bf 58 0a 00 00       	mov    $0xa58,%edi
 169:	89 7c 24 04          	mov    %edi,0x4(%esp)
 16d:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 174:	e8 67 05 00 00       	call   6e0 <printf>
}
 179:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 17c:	8b 75 f8             	mov    -0x8(%ebp),%esi
 17f:	8b 7d fc             	mov    -0x4(%ebp),%edi
 182:	89 ec                	mov    %ebp,%esp
 184:	5d                   	pop    %ebp
 185:	c3                   	ret    
 186:	8d 76 00             	lea    0x0(%esi),%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 190:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 196:	89 3c 24             	mov    %edi,(%esp)
 199:	8b b5 dc fd ff ff    	mov    -0x224(%ebp),%esi
 19f:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 1a5:	e8 a6 fe ff ff       	call   50 <fmtname>
 1aa:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 1b0:	b9 80 0a 00 00       	mov    $0xa80,%ecx
 1b5:	89 74 24 10          	mov    %esi,0x10(%esp)
 1b9:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 1bd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1c4:	89 54 24 14          	mov    %edx,0x14(%esp)
 1c8:	ba 02 00 00 00       	mov    $0x2,%edx
 1cd:	89 54 24 0c          	mov    %edx,0xc(%esp)
 1d1:	89 44 24 08          	mov    %eax,0x8(%esp)
 1d5:	e8 06 05 00 00       	call   6e0 <printf>
    break;
 1da:	e9 69 ff ff ff       	jmp    148 <ls+0x58>
 1df:	90                   	nop
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1e0:	89 3c 24             	mov    %edi,(%esp)
 1e3:	e8 e8 01 00 00       	call   3d0 <strlen>
 1e8:	83 c0 10             	add    $0x10,%eax
 1eb:	3d 00 02 00 00       	cmp    $0x200,%eax
 1f0:	76 4e                	jbe    240 <ls+0x150>
      printf(1, "ls: path too long\n");
 1f2:	b8 8d 0a 00 00       	mov    $0xa8d,%eax
 1f7:	89 44 24 04          	mov    %eax,0x4(%esp)
 1fb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 202:	e8 d9 04 00 00       	call   6e0 <printf>
      break;
 207:	e9 3c ff ff ff       	jmp    148 <ls+0x58>
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "ls: cannot stat %s\n", path);
 210:	be 6c 0a 00 00       	mov    $0xa6c,%esi
 215:	89 7c 24 08          	mov    %edi,0x8(%esp)
 219:	89 74 24 04          	mov    %esi,0x4(%esp)
 21d:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 224:	e8 b7 04 00 00       	call   6e0 <printf>
    close(fd);
 229:	89 1c 24             	mov    %ebx,(%esp)
 22c:	e8 8f 03 00 00       	call   5c0 <close>
}
 231:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 234:	8b 75 f8             	mov    -0x8(%ebp),%esi
 237:	8b 7d fc             	mov    -0x4(%ebp),%edi
 23a:	89 ec                	mov    %ebp,%esp
 23c:	5d                   	pop    %ebp
 23d:	c3                   	ret    
 23e:	66 90                	xchg   %ax,%ax
    strcpy(buf, path);
 240:	89 7c 24 04          	mov    %edi,0x4(%esp)
 244:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
 24a:	89 3c 24             	mov    %edi,(%esp)
 24d:	e8 1e 01 00 00       	call   370 <strcpy>
    p = buf+strlen(buf);
 252:	89 3c 24             	mov    %edi,(%esp)
 255:	e8 76 01 00 00       	call   3d0 <strlen>
 25a:	01 f8                	add    %edi,%eax
    *p++ = '/';
 25c:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 25f:	89 85 a8 fd ff ff    	mov    %eax,-0x258(%ebp)
    *p++ = '/';
 265:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
 26b:	c6 00 2f             	movb   $0x2f,(%eax)
 26e:	66 90                	xchg   %ax,%ax
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 270:	b8 10 00 00 00       	mov    $0x10,%eax
 275:	89 44 24 08          	mov    %eax,0x8(%esp)
 279:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 27f:	89 44 24 04          	mov    %eax,0x4(%esp)
 283:	89 1c 24             	mov    %ebx,(%esp)
 286:	e8 25 03 00 00       	call   5b0 <read>
 28b:	83 f8 10             	cmp    $0x10,%eax
 28e:	0f 85 b4 fe ff ff    	jne    148 <ls+0x58>
      if(de.inum == 0)
 294:	66 83 bd c4 fd ff ff 	cmpw   $0x0,-0x23c(%ebp)
 29b:	00 
 29c:	74 d2                	je     270 <ls+0x180>
      memmove(p, de.name, DIRSIZ);
 29e:	b8 0e 00 00 00       	mov    $0xe,%eax
 2a3:	89 44 24 08          	mov    %eax,0x8(%esp)
 2a7:	8d 85 c6 fd ff ff    	lea    -0x23a(%ebp),%eax
 2ad:	89 44 24 04          	mov    %eax,0x4(%esp)
 2b1:	8b 85 a4 fd ff ff    	mov    -0x25c(%ebp),%eax
 2b7:	89 04 24             	mov    %eax,(%esp)
 2ba:	e8 a1 02 00 00       	call   560 <memmove>
      p[DIRSIZ] = 0;
 2bf:	8b 85 a8 fd ff ff    	mov    -0x258(%ebp),%eax
 2c5:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 2c9:	89 74 24 04          	mov    %esi,0x4(%esp)
 2cd:	89 3c 24             	mov    %edi,(%esp)
 2d0:	e8 eb 01 00 00       	call   4c0 <stat>
 2d5:	85 c0                	test   %eax,%eax
 2d7:	78 6f                	js     348 <ls+0x258>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 2d9:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
 2df:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
 2e5:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
 2ec:	89 3c 24             	mov    %edi,(%esp)
 2ef:	89 8d ac fd ff ff    	mov    %ecx,-0x254(%ebp)
 2f5:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
 2fb:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 301:	e8 4a fd ff ff       	call   50 <fmtname>
 306:	8b 8d ac fd ff ff    	mov    -0x254(%ebp),%ecx
 30c:	8b 95 b0 fd ff ff    	mov    -0x250(%ebp),%edx
 312:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 319:	89 4c 24 14          	mov    %ecx,0x14(%esp)
 31d:	8b 8d b4 fd ff ff    	mov    -0x24c(%ebp),%ecx
 323:	89 54 24 10          	mov    %edx,0x10(%esp)
 327:	ba 80 0a 00 00       	mov    $0xa80,%edx
 32c:	89 44 24 08          	mov    %eax,0x8(%esp)
 330:	89 54 24 04          	mov    %edx,0x4(%esp)
 334:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
 338:	e8 a3 03 00 00       	call   6e0 <printf>
 33d:	e9 2e ff ff ff       	jmp    270 <ls+0x180>
 342:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 348:	b9 6c 0a 00 00       	mov    $0xa6c,%ecx
 34d:	89 7c 24 08          	mov    %edi,0x8(%esp)
 351:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 355:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 35c:	e8 7f 03 00 00       	call   6e0 <printf>
        continue;
 361:	e9 0a ff ff ff       	jmp    270 <ls+0x180>
 366:	66 90                	xchg   %ax,%ax
 368:	66 90                	xchg   %ax,%ax
 36a:	66 90                	xchg   %ax,%ax
 36c:	66 90                	xchg   %ax,%ax
 36e:	66 90                	xchg   %ax,%ax

00000370 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	8b 45 08             	mov    0x8(%ebp),%eax
 376:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 379:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 37a:	89 c2                	mov    %eax,%edx
 37c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 380:	41                   	inc    %ecx
 381:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 385:	42                   	inc    %edx
 386:	84 db                	test   %bl,%bl
 388:	88 5a ff             	mov    %bl,-0x1(%edx)
 38b:	75 f3                	jne    380 <strcpy+0x10>
    ;
  return os;
}
 38d:	5b                   	pop    %ebx
 38e:	5d                   	pop    %ebp
 38f:	c3                   	ret    

00000390 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	8b 4d 08             	mov    0x8(%ebp),%ecx
 396:	53                   	push   %ebx
 397:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 39a:	0f b6 01             	movzbl (%ecx),%eax
 39d:	0f b6 13             	movzbl (%ebx),%edx
 3a0:	84 c0                	test   %al,%al
 3a2:	75 18                	jne    3bc <strcmp+0x2c>
 3a4:	eb 22                	jmp    3c8 <strcmp+0x38>
 3a6:	8d 76 00             	lea    0x0(%esi),%esi
 3a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 3b0:	41                   	inc    %ecx
  while(*p && *p == *q)
 3b1:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 3b4:	43                   	inc    %ebx
 3b5:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
 3b8:	84 c0                	test   %al,%al
 3ba:	74 0c                	je     3c8 <strcmp+0x38>
 3bc:	38 d0                	cmp    %dl,%al
 3be:	74 f0                	je     3b0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
 3c0:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 3c1:	29 d0                	sub    %edx,%eax
}
 3c3:	5d                   	pop    %ebp
 3c4:	c3                   	ret    
 3c5:	8d 76 00             	lea    0x0(%esi),%esi
 3c8:	5b                   	pop    %ebx
 3c9:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 3cb:	29 d0                	sub    %edx,%eax
}
 3cd:	5d                   	pop    %ebp
 3ce:	c3                   	ret    
 3cf:	90                   	nop

000003d0 <strlen>:

uint
strlen(const char *s)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 3d6:	80 39 00             	cmpb   $0x0,(%ecx)
 3d9:	74 15                	je     3f0 <strlen+0x20>
 3db:	31 d2                	xor    %edx,%edx
 3dd:	8d 76 00             	lea    0x0(%esi),%esi
 3e0:	42                   	inc    %edx
 3e1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 3e5:	89 d0                	mov    %edx,%eax
 3e7:	75 f7                	jne    3e0 <strlen+0x10>
    ;
  return n;
}
 3e9:	5d                   	pop    %ebp
 3ea:	c3                   	ret    
 3eb:	90                   	nop
 3ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
 3f0:	31 c0                	xor    %eax,%eax
}
 3f2:	5d                   	pop    %ebp
 3f3:	c3                   	ret    
 3f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000400 <memset>:

void*
memset(void *dst, int c, uint n)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	8b 55 08             	mov    0x8(%ebp),%edx
 406:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 407:	8b 4d 10             	mov    0x10(%ebp),%ecx
 40a:	8b 45 0c             	mov    0xc(%ebp),%eax
 40d:	89 d7                	mov    %edx,%edi
 40f:	fc                   	cld    
 410:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 412:	5f                   	pop    %edi
 413:	89 d0                	mov    %edx,%eax
 415:	5d                   	pop    %ebp
 416:	c3                   	ret    
 417:	89 f6                	mov    %esi,%esi
 419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000420 <strchr>:

char*
strchr(const char *s, char c)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	8b 45 08             	mov    0x8(%ebp),%eax
 426:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 42a:	0f b6 10             	movzbl (%eax),%edx
 42d:	84 d2                	test   %dl,%dl
 42f:	74 1b                	je     44c <strchr+0x2c>
    if(*s == c)
 431:	38 d1                	cmp    %dl,%cl
 433:	75 0f                	jne    444 <strchr+0x24>
 435:	eb 17                	jmp    44e <strchr+0x2e>
 437:	89 f6                	mov    %esi,%esi
 439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 440:	38 ca                	cmp    %cl,%dl
 442:	74 0a                	je     44e <strchr+0x2e>
  for(; *s; s++)
 444:	40                   	inc    %eax
 445:	0f b6 10             	movzbl (%eax),%edx
 448:	84 d2                	test   %dl,%dl
 44a:	75 f4                	jne    440 <strchr+0x20>
      return (char*)s;
  return 0;
 44c:	31 c0                	xor    %eax,%eax
}
 44e:	5d                   	pop    %ebp
 44f:	c3                   	ret    

00000450 <gets>:

char*
gets(char *buf, int max)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 455:	31 f6                	xor    %esi,%esi
{
 457:	53                   	push   %ebx
 458:	83 ec 3c             	sub    $0x3c,%esp
 45b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
 45e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 461:	eb 32                	jmp    495 <gets+0x45>
 463:	90                   	nop
 464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 468:	ba 01 00 00 00       	mov    $0x1,%edx
 46d:	89 54 24 08          	mov    %edx,0x8(%esp)
 471:	89 7c 24 04          	mov    %edi,0x4(%esp)
 475:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 47c:	e8 2f 01 00 00       	call   5b0 <read>
    if(cc < 1)
 481:	85 c0                	test   %eax,%eax
 483:	7e 19                	jle    49e <gets+0x4e>
      break;
    buf[i++] = c;
 485:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 489:	43                   	inc    %ebx
 48a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
 48d:	3c 0a                	cmp    $0xa,%al
 48f:	74 1f                	je     4b0 <gets+0x60>
 491:	3c 0d                	cmp    $0xd,%al
 493:	74 1b                	je     4b0 <gets+0x60>
  for(i=0; i+1 < max; ){
 495:	46                   	inc    %esi
 496:	3b 75 0c             	cmp    0xc(%ebp),%esi
 499:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 49c:	7c ca                	jl     468 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 49e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4a1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 4a4:	8b 45 08             	mov    0x8(%ebp),%eax
 4a7:	83 c4 3c             	add    $0x3c,%esp
 4aa:	5b                   	pop    %ebx
 4ab:	5e                   	pop    %esi
 4ac:	5f                   	pop    %edi
 4ad:	5d                   	pop    %ebp
 4ae:	c3                   	ret    
 4af:	90                   	nop
 4b0:	8b 45 08             	mov    0x8(%ebp),%eax
 4b3:	01 c6                	add    %eax,%esi
 4b5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 4b8:	eb e4                	jmp    49e <gets+0x4e>
 4ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000004c0 <stat>:

int
stat(const char *n, struct stat *st)
{
 4c0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4c1:	31 c0                	xor    %eax,%eax
{
 4c3:	89 e5                	mov    %esp,%ebp
 4c5:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 4c8:	89 44 24 04          	mov    %eax,0x4(%esp)
 4cc:	8b 45 08             	mov    0x8(%ebp),%eax
{
 4cf:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 4d2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 4d5:	89 04 24             	mov    %eax,(%esp)
 4d8:	e8 fb 00 00 00       	call   5d8 <open>
  if(fd < 0)
 4dd:	85 c0                	test   %eax,%eax
 4df:	78 2f                	js     510 <stat+0x50>
 4e1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 4e3:	8b 45 0c             	mov    0xc(%ebp),%eax
 4e6:	89 1c 24             	mov    %ebx,(%esp)
 4e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 4ed:	e8 fe 00 00 00       	call   5f0 <fstat>
  close(fd);
 4f2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 4f5:	89 c6                	mov    %eax,%esi
  close(fd);
 4f7:	e8 c4 00 00 00       	call   5c0 <close>
  return r;
}
 4fc:	89 f0                	mov    %esi,%eax
 4fe:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 501:	8b 75 fc             	mov    -0x4(%ebp),%esi
 504:	89 ec                	mov    %ebp,%esp
 506:	5d                   	pop    %ebp
 507:	c3                   	ret    
 508:	90                   	nop
 509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 510:	be ff ff ff ff       	mov    $0xffffffff,%esi
 515:	eb e5                	jmp    4fc <stat+0x3c>
 517:	89 f6                	mov    %esi,%esi
 519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000520 <atoi>:

int
atoi(const char *s)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	8b 4d 08             	mov    0x8(%ebp),%ecx
 526:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 527:	0f be 11             	movsbl (%ecx),%edx
 52a:	88 d0                	mov    %dl,%al
 52c:	2c 30                	sub    $0x30,%al
 52e:	3c 09                	cmp    $0x9,%al
  n = 0;
 530:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 535:	77 1e                	ja     555 <atoi+0x35>
 537:	89 f6                	mov    %esi,%esi
 539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 540:	41                   	inc    %ecx
 541:	8d 04 80             	lea    (%eax,%eax,4),%eax
 544:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 548:	0f be 11             	movsbl (%ecx),%edx
 54b:	88 d3                	mov    %dl,%bl
 54d:	80 eb 30             	sub    $0x30,%bl
 550:	80 fb 09             	cmp    $0x9,%bl
 553:	76 eb                	jbe    540 <atoi+0x20>
  return n;
}
 555:	5b                   	pop    %ebx
 556:	5d                   	pop    %ebp
 557:	c3                   	ret    
 558:	90                   	nop
 559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000560 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	56                   	push   %esi
 564:	8b 45 08             	mov    0x8(%ebp),%eax
 567:	53                   	push   %ebx
 568:	8b 5d 10             	mov    0x10(%ebp),%ebx
 56b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 56e:	85 db                	test   %ebx,%ebx
 570:	7e 1a                	jle    58c <memmove+0x2c>
 572:	31 d2                	xor    %edx,%edx
 574:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 57a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 580:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 584:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 587:	42                   	inc    %edx
  while(n-- > 0)
 588:	39 d3                	cmp    %edx,%ebx
 58a:	75 f4                	jne    580 <memmove+0x20>
  return vdst;
}
 58c:	5b                   	pop    %ebx
 58d:	5e                   	pop    %esi
 58e:	5d                   	pop    %ebp
 58f:	c3                   	ret    

00000590 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 590:	b8 01 00 00 00       	mov    $0x1,%eax
 595:	cd 40                	int    $0x40
 597:	c3                   	ret    

00000598 <exit>:
SYSCALL(exit)
 598:	b8 02 00 00 00       	mov    $0x2,%eax
 59d:	cd 40                	int    $0x40
 59f:	c3                   	ret    

000005a0 <wait>:
SYSCALL(wait)
 5a0:	b8 03 00 00 00       	mov    $0x3,%eax
 5a5:	cd 40                	int    $0x40
 5a7:	c3                   	ret    

000005a8 <pipe>:
SYSCALL(pipe)
 5a8:	b8 04 00 00 00       	mov    $0x4,%eax
 5ad:	cd 40                	int    $0x40
 5af:	c3                   	ret    

000005b0 <read>:
SYSCALL(read)
 5b0:	b8 05 00 00 00       	mov    $0x5,%eax
 5b5:	cd 40                	int    $0x40
 5b7:	c3                   	ret    

000005b8 <write>:
SYSCALL(write)
 5b8:	b8 10 00 00 00       	mov    $0x10,%eax
 5bd:	cd 40                	int    $0x40
 5bf:	c3                   	ret    

000005c0 <close>:
SYSCALL(close)
 5c0:	b8 15 00 00 00       	mov    $0x15,%eax
 5c5:	cd 40                	int    $0x40
 5c7:	c3                   	ret    

000005c8 <kill>:
SYSCALL(kill)
 5c8:	b8 06 00 00 00       	mov    $0x6,%eax
 5cd:	cd 40                	int    $0x40
 5cf:	c3                   	ret    

000005d0 <exec>:
SYSCALL(exec)
 5d0:	b8 07 00 00 00       	mov    $0x7,%eax
 5d5:	cd 40                	int    $0x40
 5d7:	c3                   	ret    

000005d8 <open>:
SYSCALL(open)
 5d8:	b8 0f 00 00 00       	mov    $0xf,%eax
 5dd:	cd 40                	int    $0x40
 5df:	c3                   	ret    

000005e0 <mknod>:
SYSCALL(mknod)
 5e0:	b8 11 00 00 00       	mov    $0x11,%eax
 5e5:	cd 40                	int    $0x40
 5e7:	c3                   	ret    

000005e8 <unlink>:
SYSCALL(unlink)
 5e8:	b8 12 00 00 00       	mov    $0x12,%eax
 5ed:	cd 40                	int    $0x40
 5ef:	c3                   	ret    

000005f0 <fstat>:
SYSCALL(fstat)
 5f0:	b8 08 00 00 00       	mov    $0x8,%eax
 5f5:	cd 40                	int    $0x40
 5f7:	c3                   	ret    

000005f8 <link>:
SYSCALL(link)
 5f8:	b8 13 00 00 00       	mov    $0x13,%eax
 5fd:	cd 40                	int    $0x40
 5ff:	c3                   	ret    

00000600 <mkdir>:
SYSCALL(mkdir)
 600:	b8 14 00 00 00       	mov    $0x14,%eax
 605:	cd 40                	int    $0x40
 607:	c3                   	ret    

00000608 <chdir>:
SYSCALL(chdir)
 608:	b8 09 00 00 00       	mov    $0x9,%eax
 60d:	cd 40                	int    $0x40
 60f:	c3                   	ret    

00000610 <dup>:
SYSCALL(dup)
 610:	b8 0a 00 00 00       	mov    $0xa,%eax
 615:	cd 40                	int    $0x40
 617:	c3                   	ret    

00000618 <getpid>:
SYSCALL(getpid)
 618:	b8 0b 00 00 00       	mov    $0xb,%eax
 61d:	cd 40                	int    $0x40
 61f:	c3                   	ret    

00000620 <sbrk>:
SYSCALL(sbrk)
 620:	b8 0c 00 00 00       	mov    $0xc,%eax
 625:	cd 40                	int    $0x40
 627:	c3                   	ret    

00000628 <sleep>:
SYSCALL(sleep)
 628:	b8 0d 00 00 00       	mov    $0xd,%eax
 62d:	cd 40                	int    $0x40
 62f:	c3                   	ret    

00000630 <uptime>:
SYSCALL(uptime)
 630:	b8 0e 00 00 00       	mov    $0xe,%eax
 635:	cd 40                	int    $0x40
 637:	c3                   	ret    
 638:	66 90                	xchg   %ax,%ax
 63a:	66 90                	xchg   %ax,%ax
 63c:	66 90                	xchg   %ax,%ax
 63e:	66 90                	xchg   %ax,%ax

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
 645:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 646:	89 d3                	mov    %edx,%ebx
 648:	c1 eb 1f             	shr    $0x1f,%ebx
{
 64b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 64e:	84 db                	test   %bl,%bl
{
 650:	89 45 c0             	mov    %eax,-0x40(%ebp)
 653:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 655:	74 79                	je     6d0 <printint+0x90>
 657:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 65b:	74 73                	je     6d0 <printint+0x90>
    neg = 1;
    x = -xx;
 65d:	f7 d8                	neg    %eax
    neg = 1;
 65f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 666:	31 f6                	xor    %esi,%esi
 668:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 66b:	eb 05                	jmp    672 <printint+0x32>
 66d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 670:	89 fe                	mov    %edi,%esi
 672:	31 d2                	xor    %edx,%edx
 674:	f7 f1                	div    %ecx
 676:	8d 7e 01             	lea    0x1(%esi),%edi
 679:	0f b6 92 ac 0a 00 00 	movzbl 0xaac(%edx),%edx
  }while((x /= base) != 0);
 680:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 682:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 685:	75 e9                	jne    670 <printint+0x30>
  if(neg)
 687:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 68a:	85 d2                	test   %edx,%edx
 68c:	74 08                	je     696 <printint+0x56>
    buf[i++] = '-';
 68e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 693:	8d 7e 02             	lea    0x2(%esi),%edi
 696:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 69a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 69d:	8d 76 00             	lea    0x0(%esi),%esi
 6a0:	0f b6 06             	movzbl (%esi),%eax
 6a3:	4e                   	dec    %esi
  write(fd, &c, 1);
 6a4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 6a8:	89 3c 24             	mov    %edi,(%esp)
 6ab:	88 45 d7             	mov    %al,-0x29(%ebp)
 6ae:	b8 01 00 00 00       	mov    $0x1,%eax
 6b3:	89 44 24 08          	mov    %eax,0x8(%esp)
 6b7:	e8 fc fe ff ff       	call   5b8 <write>

  while(--i >= 0)
 6bc:	39 de                	cmp    %ebx,%esi
 6be:	75 e0                	jne    6a0 <printint+0x60>
    putc(fd, buf[i]);
}
 6c0:	83 c4 4c             	add    $0x4c,%esp
 6c3:	5b                   	pop    %ebx
 6c4:	5e                   	pop    %esi
 6c5:	5f                   	pop    %edi
 6c6:	5d                   	pop    %ebp
 6c7:	c3                   	ret    
 6c8:	90                   	nop
 6c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 6d0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 6d7:	eb 8d                	jmp    666 <printint+0x26>
 6d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	57                   	push   %edi
 6e4:	56                   	push   %esi
 6e5:	53                   	push   %ebx
 6e6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6e9:	8b 75 0c             	mov    0xc(%ebp),%esi
 6ec:	0f b6 1e             	movzbl (%esi),%ebx
 6ef:	84 db                	test   %bl,%bl
 6f1:	0f 84 d1 00 00 00    	je     7c8 <printf+0xe8>
  state = 0;
 6f7:	31 ff                	xor    %edi,%edi
 6f9:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 6fa:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 6fd:	89 fa                	mov    %edi,%edx
 6ff:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 702:	89 45 d0             	mov    %eax,-0x30(%ebp)
 705:	eb 41                	jmp    748 <printf+0x68>
 707:	89 f6                	mov    %esi,%esi
 709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 710:	83 f8 25             	cmp    $0x25,%eax
 713:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 716:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 71b:	74 1e                	je     73b <printf+0x5b>
  write(fd, &c, 1);
 71d:	b8 01 00 00 00       	mov    $0x1,%eax
 722:	89 44 24 08          	mov    %eax,0x8(%esp)
 726:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 729:	89 44 24 04          	mov    %eax,0x4(%esp)
 72d:	89 3c 24             	mov    %edi,(%esp)
 730:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 733:	e8 80 fe ff ff       	call   5b8 <write>
 738:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 73b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 73c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 740:	84 db                	test   %bl,%bl
 742:	0f 84 80 00 00 00    	je     7c8 <printf+0xe8>
    if(state == 0){
 748:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 74a:	0f be cb             	movsbl %bl,%ecx
 74d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 750:	74 be                	je     710 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 752:	83 fa 25             	cmp    $0x25,%edx
 755:	75 e4                	jne    73b <printf+0x5b>
      if(c == 'd'){
 757:	83 f8 64             	cmp    $0x64,%eax
 75a:	0f 84 f0 00 00 00    	je     850 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 760:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 766:	83 f9 70             	cmp    $0x70,%ecx
 769:	74 65                	je     7d0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 76b:	83 f8 73             	cmp    $0x73,%eax
 76e:	0f 84 8c 00 00 00    	je     800 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 774:	83 f8 63             	cmp    $0x63,%eax
 777:	0f 84 13 01 00 00    	je     890 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 77d:	83 f8 25             	cmp    $0x25,%eax
 780:	0f 84 e2 00 00 00    	je     868 <printf+0x188>
  write(fd, &c, 1);
 786:	b8 01 00 00 00       	mov    $0x1,%eax
 78b:	46                   	inc    %esi
 78c:	89 44 24 08          	mov    %eax,0x8(%esp)
 790:	8d 45 e7             	lea    -0x19(%ebp),%eax
 793:	89 44 24 04          	mov    %eax,0x4(%esp)
 797:	89 3c 24             	mov    %edi,(%esp)
 79a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 79e:	e8 15 fe ff ff       	call   5b8 <write>
 7a3:	ba 01 00 00 00       	mov    $0x1,%edx
 7a8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 7ab:	89 54 24 08          	mov    %edx,0x8(%esp)
 7af:	89 44 24 04          	mov    %eax,0x4(%esp)
 7b3:	89 3c 24             	mov    %edi,(%esp)
 7b6:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 7b9:	e8 fa fd ff ff       	call   5b8 <write>
  for(i = 0; fmt[i]; i++){
 7be:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7c2:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 7c4:	84 db                	test   %bl,%bl
 7c6:	75 80                	jne    748 <printf+0x68>
    }
  }
}
 7c8:	83 c4 3c             	add    $0x3c,%esp
 7cb:	5b                   	pop    %ebx
 7cc:	5e                   	pop    %esi
 7cd:	5f                   	pop    %edi
 7ce:	5d                   	pop    %ebp
 7cf:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 7d0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 7d7:	b9 10 00 00 00       	mov    $0x10,%ecx
 7dc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 7df:	89 f8                	mov    %edi,%eax
 7e1:	8b 13                	mov    (%ebx),%edx
 7e3:	e8 58 fe ff ff       	call   640 <printint>
        ap++;
 7e8:	89 d8                	mov    %ebx,%eax
      state = 0;
 7ea:	31 d2                	xor    %edx,%edx
        ap++;
 7ec:	83 c0 04             	add    $0x4,%eax
 7ef:	89 45 d0             	mov    %eax,-0x30(%ebp)
 7f2:	e9 44 ff ff ff       	jmp    73b <printf+0x5b>
 7f7:	89 f6                	mov    %esi,%esi
 7f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 800:	8b 45 d0             	mov    -0x30(%ebp),%eax
 803:	8b 10                	mov    (%eax),%edx
        ap++;
 805:	83 c0 04             	add    $0x4,%eax
 808:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 80b:	85 d2                	test   %edx,%edx
 80d:	0f 84 aa 00 00 00    	je     8bd <printf+0x1dd>
        while(*s != 0){
 813:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 816:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 818:	84 c0                	test   %al,%al
 81a:	74 27                	je     843 <printf+0x163>
 81c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 820:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 823:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 828:	43                   	inc    %ebx
  write(fd, &c, 1);
 829:	89 44 24 08          	mov    %eax,0x8(%esp)
 82d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 830:	89 44 24 04          	mov    %eax,0x4(%esp)
 834:	89 3c 24             	mov    %edi,(%esp)
 837:	e8 7c fd ff ff       	call   5b8 <write>
        while(*s != 0){
 83c:	0f b6 03             	movzbl (%ebx),%eax
 83f:	84 c0                	test   %al,%al
 841:	75 dd                	jne    820 <printf+0x140>
      state = 0;
 843:	31 d2                	xor    %edx,%edx
 845:	e9 f1 fe ff ff       	jmp    73b <printf+0x5b>
 84a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 850:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 857:	b9 0a 00 00 00       	mov    $0xa,%ecx
 85c:	e9 7b ff ff ff       	jmp    7dc <printf+0xfc>
 861:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 868:	b9 01 00 00 00       	mov    $0x1,%ecx
 86d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 870:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 874:	89 44 24 04          	mov    %eax,0x4(%esp)
 878:	89 3c 24             	mov    %edi,(%esp)
 87b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 87e:	e8 35 fd ff ff       	call   5b8 <write>
      state = 0;
 883:	31 d2                	xor    %edx,%edx
 885:	e9 b1 fe ff ff       	jmp    73b <printf+0x5b>
 88a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 890:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 893:	8b 03                	mov    (%ebx),%eax
        ap++;
 895:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 898:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 89b:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 89e:	b8 01 00 00 00       	mov    $0x1,%eax
 8a3:	89 44 24 08          	mov    %eax,0x8(%esp)
 8a7:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 8aa:	89 44 24 04          	mov    %eax,0x4(%esp)
 8ae:	e8 05 fd ff ff       	call   5b8 <write>
      state = 0;
 8b3:	31 d2                	xor    %edx,%edx
        ap++;
 8b5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 8b8:	e9 7e fe ff ff       	jmp    73b <printf+0x5b>
          s = "(null)";
 8bd:	bb a2 0a 00 00       	mov    $0xaa2,%ebx
        while(*s != 0){
 8c2:	b0 28                	mov    $0x28,%al
 8c4:	e9 57 ff ff ff       	jmp    820 <printf+0x140>
 8c9:	66 90                	xchg   %ax,%ax
 8cb:	66 90                	xchg   %ax,%ax
 8cd:	66 90                	xchg   %ax,%ax
 8cf:	90                   	nop

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
 8d1:	a1 c0 0d 00 00       	mov    0xdc0,%eax
{
 8d6:	89 e5                	mov    %esp,%ebp
 8d8:	57                   	push   %edi
 8d9:	56                   	push   %esi
 8da:	53                   	push   %ebx
 8db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 8de:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 8e1:	eb 0d                	jmp    8f0 <free+0x20>
 8e3:	90                   	nop
 8e4:	90                   	nop
 8e5:	90                   	nop
 8e6:	90                   	nop
 8e7:	90                   	nop
 8e8:	90                   	nop
 8e9:	90                   	nop
 8ea:	90                   	nop
 8eb:	90                   	nop
 8ec:	90                   	nop
 8ed:	90                   	nop
 8ee:	90                   	nop
 8ef:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8f0:	39 c8                	cmp    %ecx,%eax
 8f2:	8b 10                	mov    (%eax),%edx
 8f4:	73 32                	jae    928 <free+0x58>
 8f6:	39 d1                	cmp    %edx,%ecx
 8f8:	72 04                	jb     8fe <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8fa:	39 d0                	cmp    %edx,%eax
 8fc:	72 32                	jb     930 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8fe:	8b 73 fc             	mov    -0x4(%ebx),%esi
 901:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 904:	39 fa                	cmp    %edi,%edx
 906:	74 30                	je     938 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 908:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 90b:	8b 50 04             	mov    0x4(%eax),%edx
 90e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 911:	39 f1                	cmp    %esi,%ecx
 913:	74 3c                	je     951 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 915:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 917:	5b                   	pop    %ebx
  freep = p;
 918:	a3 c0 0d 00 00       	mov    %eax,0xdc0
}
 91d:	5e                   	pop    %esi
 91e:	5f                   	pop    %edi
 91f:	5d                   	pop    %ebp
 920:	c3                   	ret    
 921:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 928:	39 d0                	cmp    %edx,%eax
 92a:	72 04                	jb     930 <free+0x60>
 92c:	39 d1                	cmp    %edx,%ecx
 92e:	72 ce                	jb     8fe <free+0x2e>
{
 930:	89 d0                	mov    %edx,%eax
 932:	eb bc                	jmp    8f0 <free+0x20>
 934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 938:	8b 7a 04             	mov    0x4(%edx),%edi
 93b:	01 fe                	add    %edi,%esi
 93d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 940:	8b 10                	mov    (%eax),%edx
 942:	8b 12                	mov    (%edx),%edx
 944:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 947:	8b 50 04             	mov    0x4(%eax),%edx
 94a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 94d:	39 f1                	cmp    %esi,%ecx
 94f:	75 c4                	jne    915 <free+0x45>
    p->s.size += bp->s.size;
 951:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 954:	a3 c0 0d 00 00       	mov    %eax,0xdc0
    p->s.size += bp->s.size;
 959:	01 ca                	add    %ecx,%edx
 95b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 95e:	8b 53 f8             	mov    -0x8(%ebx),%edx
 961:	89 10                	mov    %edx,(%eax)
}
 963:	5b                   	pop    %ebx
 964:	5e                   	pop    %esi
 965:	5f                   	pop    %edi
 966:	5d                   	pop    %ebp
 967:	c3                   	ret    
 968:	90                   	nop
 969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

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
 97c:	8b 15 c0 0d 00 00    	mov    0xdc0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 982:	8d 78 07             	lea    0x7(%eax),%edi
 985:	c1 ef 03             	shr    $0x3,%edi
 988:	47                   	inc    %edi
  if((prevp = freep) == 0){
 989:	85 d2                	test   %edx,%edx
 98b:	0f 84 8f 00 00 00    	je     a20 <malloc+0xb0>
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
 9a0:	bb 00 10 00 00       	mov    $0x1000,%ebx
 9a5:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 9a8:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 9af:	eb 10                	jmp    9c1 <malloc+0x51>
 9b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9b8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 9ba:	8b 48 04             	mov    0x4(%eax),%ecx
 9bd:	39 f9                	cmp    %edi,%ecx
 9bf:	73 3f                	jae    a00 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9c1:	39 05 c0 0d 00 00    	cmp    %eax,0xdc0
 9c7:	89 c2                	mov    %eax,%edx
 9c9:	75 ed                	jne    9b8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 9cb:	89 34 24             	mov    %esi,(%esp)
 9ce:	e8 4d fc ff ff       	call   620 <sbrk>
  if(p == (char*)-1)
 9d3:	83 f8 ff             	cmp    $0xffffffff,%eax
 9d6:	74 18                	je     9f0 <malloc+0x80>
  hp->s.size = nu;
 9d8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 9db:	83 c0 08             	add    $0x8,%eax
 9de:	89 04 24             	mov    %eax,(%esp)
 9e1:	e8 ea fe ff ff       	call   8d0 <free>
  return freep;
 9e6:	8b 15 c0 0d 00 00    	mov    0xdc0,%edx
      if((p = morecore(nunits)) == 0)
 9ec:	85 d2                	test   %edx,%edx
 9ee:	75 c8                	jne    9b8 <malloc+0x48>
        return 0;
  }
}
 9f0:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 9f3:	31 c0                	xor    %eax,%eax
}
 9f5:	5b                   	pop    %ebx
 9f6:	5e                   	pop    %esi
 9f7:	5f                   	pop    %edi
 9f8:	5d                   	pop    %ebp
 9f9:	c3                   	ret    
 9fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 a00:	39 cf                	cmp    %ecx,%edi
 a02:	74 4c                	je     a50 <malloc+0xe0>
        p->s.size -= nunits;
 a04:	29 f9                	sub    %edi,%ecx
 a06:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 a09:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 a0c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 a0f:	89 15 c0 0d 00 00    	mov    %edx,0xdc0
}
 a15:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 a18:	83 c0 08             	add    $0x8,%eax
}
 a1b:	5b                   	pop    %ebx
 a1c:	5e                   	pop    %esi
 a1d:	5f                   	pop    %edi
 a1e:	5d                   	pop    %ebp
 a1f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 a20:	b8 c4 0d 00 00       	mov    $0xdc4,%eax
 a25:	ba c4 0d 00 00       	mov    $0xdc4,%edx
    base.s.size = 0;
 a2a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 a2c:	a3 c0 0d 00 00       	mov    %eax,0xdc0
    base.s.size = 0;
 a31:	b8 c4 0d 00 00       	mov    $0xdc4,%eax
    base.s.ptr = freep = prevp = &base;
 a36:	89 15 c4 0d 00 00    	mov    %edx,0xdc4
    base.s.size = 0;
 a3c:	89 0d c8 0d 00 00    	mov    %ecx,0xdc8
 a42:	e9 53 ff ff ff       	jmp    99a <malloc+0x2a>
 a47:	89 f6                	mov    %esi,%esi
 a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 a50:	8b 08                	mov    (%eax),%ecx
 a52:	89 0a                	mov    %ecx,(%edx)
 a54:	eb b9                	jmp    a0f <malloc+0x9f>
