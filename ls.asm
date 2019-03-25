
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
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	bb 01 00 00 00       	mov    $0x1,%ebx
   b:	83 e4 f0             	and    $0xfffffff0,%esp
   e:	83 ec 10             	sub    $0x10,%esp
  11:	8b 75 08             	mov    0x8(%ebp),%esi
  14:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  if(argc < 2){
  17:	83 fe 01             	cmp    $0x1,%esi
  1a:	7e 20                	jle    3c <main+0x3c>
  1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
  20:	8b 04 9f             	mov    (%edi,%ebx,4),%eax

  if(argc < 2){
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
  23:	43                   	inc    %ebx
    ls(argv[i]);
  24:	89 04 24             	mov    %eax,(%esp)
  27:	e8 d4 00 00 00       	call   100 <ls>

  if(argc < 2){
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
  2c:	39 de                	cmp    %ebx,%esi
  2e:	75 f0                	jne    20 <main+0x20>
    ls(argv[i]);
  exit(0);
  30:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  37:	e8 8c 05 00 00       	call   5c8 <exit>
main(int argc, char *argv[])
{
  int i;

  if(argc < 2){
    ls(".");
  3c:	c7 04 24 e8 0a 00 00 	movl   $0xae8,(%esp)
  43:	e8 b8 00 00 00       	call   100 <ls>
    exit(0);
  48:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  4f:	e8 74 05 00 00       	call   5c8 <exit>
  54:	66 90                	xchg   %ax,%ax
  56:	66 90                	xchg   %ax,%ax
  58:	66 90                	xchg   %ax,%ax
  5a:	66 90                	xchg   %ax,%ax
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	56                   	push   %esi
  64:	53                   	push   %ebx
  65:	83 ec 10             	sub    $0x10,%esp
  68:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  6b:	89 1c 24             	mov    %ebx,(%esp)
  6e:	e8 8d 03 00 00       	call   400 <strlen>
  73:	01 d8                	add    %ebx,%eax
  75:	73 0e                	jae    85 <fmtname+0x25>
  77:	eb 11                	jmp    8a <fmtname+0x2a>
  79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  80:	48                   	dec    %eax
  81:	39 c3                	cmp    %eax,%ebx
  83:	77 05                	ja     8a <fmtname+0x2a>
  85:	80 38 2f             	cmpb   $0x2f,(%eax)
  88:	75 f6                	jne    80 <fmtname+0x20>
    ;
  p++;
  8a:	8d 58 01             	lea    0x1(%eax),%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  8d:	89 1c 24             	mov    %ebx,(%esp)
  90:	e8 6b 03 00 00       	call   400 <strlen>
  95:	83 f8 0d             	cmp    $0xd,%eax
  98:	77 54                	ja     ee <fmtname+0x8e>
    return p;
  memmove(buf, p, strlen(p));
  9a:	89 1c 24             	mov    %ebx,(%esp)
  9d:	e8 5e 03 00 00       	call   400 <strlen>
  a2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  a6:	c7 04 24 ec 0d 00 00 	movl   $0xdec,(%esp)
  ad:	89 44 24 08          	mov    %eax,0x8(%esp)
  b1:	e8 da 04 00 00       	call   590 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  b6:	89 1c 24             	mov    %ebx,(%esp)
  b9:	e8 42 03 00 00       	call   400 <strlen>
  be:	89 1c 24             	mov    %ebx,(%esp)
  return buf;
  c1:	bb ec 0d 00 00       	mov    $0xdec,%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  c6:	89 c6                	mov    %eax,%esi
  c8:	e8 33 03 00 00       	call   400 <strlen>
  cd:	ba 0e 00 00 00       	mov    $0xe,%edx
  d2:	29 f2                	sub    %esi,%edx
  d4:	89 54 24 08          	mov    %edx,0x8(%esp)
  d8:	ba 20 00 00 00       	mov    $0x20,%edx
  dd:	89 54 24 04          	mov    %edx,0x4(%esp)
  e1:	05 ec 0d 00 00       	add    $0xdec,%eax
  e6:	89 04 24             	mov    %eax,(%esp)
  e9:	e8 32 03 00 00       	call   420 <memset>
  return buf;
}
  ee:	83 c4 10             	add    $0x10,%esp
  f1:	89 d8                	mov    %ebx,%eax
  f3:	5b                   	pop    %ebx
  f4:	5e                   	pop    %esi
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret    
  f7:	89 f6                	mov    %esi,%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <ls>:

void
ls(char *path)
{
 100:	55                   	push   %ebp
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
 101:	31 c0                	xor    %eax,%eax
  return buf;
}

void
ls(char *path)
{
 103:	89 e5                	mov    %esp,%ebp
 105:	57                   	push   %edi
 106:	56                   	push   %esi
 107:	53                   	push   %ebx
 108:	81 ec 7c 02 00 00    	sub    $0x27c,%esp
 10e:	8b 7d 08             	mov    0x8(%ebp),%edi
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
 111:	89 44 24 04          	mov    %eax,0x4(%esp)
 115:	89 3c 24             	mov    %edi,(%esp)
 118:	e8 eb 04 00 00       	call   608 <open>
 11d:	85 c0                	test   %eax,%eax
 11f:	0f 88 cb 01 00 00    	js     2f0 <ls+0x1f0>
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
 125:	8d b5 d4 fd ff ff    	lea    -0x22c(%ebp),%esi
 12b:	89 c3                	mov    %eax,%ebx
 12d:	89 74 24 04          	mov    %esi,0x4(%esp)
 131:	89 04 24             	mov    %eax,(%esp)
 134:	e8 e7 04 00 00       	call   620 <fstat>
 139:	85 c0                	test   %eax,%eax
 13b:	0f 88 f7 01 00 00    	js     338 <ls+0x238>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
 141:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
 148:	83 f8 01             	cmp    $0x1,%eax
 14b:	74 63                	je     1b0 <ls+0xb0>
 14d:	83 f8 02             	cmp    $0x2,%eax
 150:	75 4a                	jne    19c <ls+0x9c>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 152:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 158:	89 3c 24             	mov    %edi,(%esp)
 15b:	8b b5 dc fd ff ff    	mov    -0x224(%ebp),%esi
 161:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 167:	e8 f4 fe ff ff       	call   60 <fmtname>
 16c:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 172:	b9 c8 0a 00 00       	mov    $0xac8,%ecx
 177:	89 74 24 10          	mov    %esi,0x10(%esp)
 17b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 17f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 186:	89 54 24 14          	mov    %edx,0x14(%esp)
 18a:	ba 02 00 00 00       	mov    $0x2,%edx
 18f:	89 54 24 0c          	mov    %edx,0xc(%esp)
 193:	89 44 24 08          	mov    %eax,0x8(%esp)
 197:	e8 a4 05 00 00       	call   740 <printf>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 19c:	89 1c 24             	mov    %ebx,(%esp)
 19f:	e8 4c 04 00 00       	call   5f0 <close>
}
 1a4:	81 c4 7c 02 00 00    	add    $0x27c,%esp
 1aa:	5b                   	pop    %ebx
 1ab:	5e                   	pop    %esi
 1ac:	5f                   	pop    %edi
 1ad:	5d                   	pop    %ebp
 1ae:	c3                   	ret    
 1af:	90                   	nop
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    break;

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1b0:	89 3c 24             	mov    %edi,(%esp)
 1b3:	e8 48 02 00 00       	call   400 <strlen>
 1b8:	83 c0 10             	add    $0x10,%eax
 1bb:	3d 00 02 00 00       	cmp    $0x200,%eax
 1c0:	0f 87 52 01 00 00    	ja     318 <ls+0x218>
      printf(1, "ls: path too long\n");
      break;
    }
    strcpy(buf, path);
 1c6:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 1cc:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1d0:	8d bd c4 fd ff ff    	lea    -0x23c(%ebp),%edi
 1d6:	89 04 24             	mov    %eax,(%esp)
 1d9:	e8 b2 01 00 00       	call   390 <strcpy>
    p = buf+strlen(buf);
 1de:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 1e4:	89 04 24             	mov    %eax,(%esp)
 1e7:	e8 14 02 00 00       	call   400 <strlen>
 1ec:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
 1f2:	01 c1                	add    %eax,%ecx
    *p++ = '/';
 1f4:	8d 84 05 e9 fd ff ff 	lea    -0x217(%ebp,%eax,1),%eax
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf(1, "ls: path too long\n");
      break;
    }
    strcpy(buf, path);
    p = buf+strlen(buf);
 1fb:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
    *p++ = '/';
 201:	89 85 a4 fd ff ff    	mov    %eax,-0x25c(%ebp)
 207:	c6 01 2f             	movb   $0x2f,(%ecx)
 20a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 210:	b8 10 00 00 00       	mov    $0x10,%eax
 215:	89 44 24 08          	mov    %eax,0x8(%esp)
 219:	89 7c 24 04          	mov    %edi,0x4(%esp)
 21d:	89 1c 24             	mov    %ebx,(%esp)
 220:	e8 bb 03 00 00       	call   5e0 <read>
 225:	83 f8 10             	cmp    $0x10,%eax
 228:	0f 85 6e ff ff ff    	jne    19c <ls+0x9c>
      if(de.inum == 0)
 22e:	66 83 bd c4 fd ff ff 	cmpw   $0x0,-0x23c(%ebp)
 235:	00 
 236:	74 d8                	je     210 <ls+0x110>
        continue;
      memmove(p, de.name, DIRSIZ);
 238:	b8 0e 00 00 00       	mov    $0xe,%eax
 23d:	89 44 24 08          	mov    %eax,0x8(%esp)
 241:	8d 85 c6 fd ff ff    	lea    -0x23a(%ebp),%eax
 247:	89 44 24 04          	mov    %eax,0x4(%esp)
 24b:	8b 85 a4 fd ff ff    	mov    -0x25c(%ebp),%eax
 251:	89 04 24             	mov    %eax,(%esp)
 254:	e8 37 03 00 00       	call   590 <memmove>
      p[DIRSIZ] = 0;
 259:	8b 85 a8 fd ff ff    	mov    -0x258(%ebp),%eax
 25f:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 263:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 269:	89 74 24 04          	mov    %esi,0x4(%esp)
 26d:	89 04 24             	mov    %eax,(%esp)
 270:	e8 7b 02 00 00       	call   4f0 <stat>
 275:	85 c0                	test   %eax,%eax
 277:	0f 88 e3 00 00 00    	js     360 <ls+0x260>
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 27d:	0f bf 95 d4 fd ff ff 	movswl -0x22c(%ebp),%edx
 284:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
 28a:	8b 85 dc fd ff ff    	mov    -0x224(%ebp),%eax
 290:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
 296:	8d 95 e8 fd ff ff    	lea    -0x218(%ebp),%edx
 29c:	89 14 24             	mov    %edx,(%esp)
 29f:	89 8d ac fd ff ff    	mov    %ecx,-0x254(%ebp)
 2a5:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 2ab:	e8 b0 fd ff ff       	call   60 <fmtname>
 2b0:	8b 8d ac fd ff ff    	mov    -0x254(%ebp),%ecx
 2b6:	8b 95 b0 fd ff ff    	mov    -0x250(%ebp),%edx
 2bc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2c3:	89 4c 24 14          	mov    %ecx,0x14(%esp)
 2c7:	8b 8d b4 fd ff ff    	mov    -0x24c(%ebp),%ecx
 2cd:	89 54 24 0c          	mov    %edx,0xc(%esp)
 2d1:	ba c8 0a 00 00       	mov    $0xac8,%edx
 2d6:	89 44 24 08          	mov    %eax,0x8(%esp)
 2da:	89 54 24 04          	mov    %edx,0x4(%esp)
 2de:	89 4c 24 10          	mov    %ecx,0x10(%esp)
 2e2:	e8 59 04 00 00       	call   740 <printf>
 2e7:	e9 24 ff ff ff       	jmp    210 <ls+0x110>
 2ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
    printf(2, "ls: cannot open %s\n", path);
 2f0:	89 7c 24 08          	mov    %edi,0x8(%esp)
 2f4:	bf a0 0a 00 00       	mov    $0xaa0,%edi
 2f9:	89 7c 24 04          	mov    %edi,0x4(%esp)
 2fd:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 304:	e8 37 04 00 00       	call   740 <printf>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
}
 309:	81 c4 7c 02 00 00    	add    $0x27c,%esp
 30f:	5b                   	pop    %ebx
 310:	5e                   	pop    %esi
 311:	5f                   	pop    %edi
 312:	5d                   	pop    %ebp
 313:	c3                   	ret    
 314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    break;

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf(1, "ls: path too long\n");
 318:	b8 d5 0a 00 00       	mov    $0xad5,%eax
 31d:	89 44 24 04          	mov    %eax,0x4(%esp)
 321:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 328:	e8 13 04 00 00       	call   740 <printf>
      break;
 32d:	e9 6a fe ff ff       	jmp    19c <ls+0x9c>
 332:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
    printf(2, "ls: cannot stat %s\n", path);
 338:	be b4 0a 00 00       	mov    $0xab4,%esi
 33d:	89 7c 24 08          	mov    %edi,0x8(%esp)
 341:	89 74 24 04          	mov    %esi,0x4(%esp)
 345:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 34c:	e8 ef 03 00 00       	call   740 <printf>
    close(fd);
 351:	89 1c 24             	mov    %ebx,(%esp)
 354:	e8 97 02 00 00       	call   5f0 <close>
    return;
 359:	e9 46 fe ff ff       	jmp    1a4 <ls+0xa4>
 35e:	66 90                	xchg   %ax,%ax
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
      if(stat(buf, &st) < 0){
        printf(1, "ls: cannot stat %s\n", buf);
 360:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 366:	b9 b4 0a 00 00       	mov    $0xab4,%ecx
 36b:	89 44 24 08          	mov    %eax,0x8(%esp)
 36f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 373:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 37a:	e8 c1 03 00 00       	call   740 <printf>
        continue;
 37f:	e9 8c fe ff ff       	jmp    210 <ls+0x110>
 384:	66 90                	xchg   %ax,%ax
 386:	66 90                	xchg   %ax,%ax
 388:	66 90                	xchg   %ax,%ax
 38a:	66 90                	xchg   %ax,%ax
 38c:	66 90                	xchg   %ax,%ax
 38e:	66 90                	xchg   %ax,%ax

00000390 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	8b 45 08             	mov    0x8(%ebp),%eax
 396:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 399:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 39a:	89 c2                	mov    %eax,%edx
 39c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3a0:	41                   	inc    %ecx
 3a1:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 3a5:	42                   	inc    %edx
 3a6:	84 db                	test   %bl,%bl
 3a8:	88 5a ff             	mov    %bl,-0x1(%edx)
 3ab:	75 f3                	jne    3a0 <strcpy+0x10>
    ;
  return os;
}
 3ad:	5b                   	pop    %ebx
 3ae:	5d                   	pop    %ebp
 3af:	c3                   	ret    

000003b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3b6:	56                   	push   %esi
 3b7:	53                   	push   %ebx
 3b8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 3bb:	0f b6 01             	movzbl (%ecx),%eax
 3be:	0f b6 13             	movzbl (%ebx),%edx
 3c1:	84 c0                	test   %al,%al
 3c3:	75 1c                	jne    3e1 <strcmp+0x31>
 3c5:	eb 29                	jmp    3f0 <strcmp+0x40>
 3c7:	89 f6                	mov    %esi,%esi
 3c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 3d0:	41                   	inc    %ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3d1:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 3d4:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3d7:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 3db:	84 c0                	test   %al,%al
 3dd:	74 11                	je     3f0 <strcmp+0x40>
 3df:	89 f3                	mov    %esi,%ebx
 3e1:	38 d0                	cmp    %dl,%al
 3e3:	74 eb                	je     3d0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 3e5:	5b                   	pop    %ebx
int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3e6:	29 d0                	sub    %edx,%eax
}
 3e8:	5e                   	pop    %esi
 3e9:	5d                   	pop    %ebp
 3ea:	c3                   	ret    
 3eb:	90                   	nop
 3ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3f0:	5b                   	pop    %ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3f1:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3f3:	29 d0                	sub    %edx,%eax
}
 3f5:	5e                   	pop    %esi
 3f6:	5d                   	pop    %ebp
 3f7:	c3                   	ret    
 3f8:	90                   	nop
 3f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000400 <strlen>:

uint
strlen(const char *s)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 406:	80 39 00             	cmpb   $0x0,(%ecx)
 409:	74 10                	je     41b <strlen+0x1b>
 40b:	31 d2                	xor    %edx,%edx
 40d:	8d 76 00             	lea    0x0(%esi),%esi
 410:	42                   	inc    %edx
 411:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 415:	89 d0                	mov    %edx,%eax
 417:	75 f7                	jne    410 <strlen+0x10>
    ;
  return n;
}
 419:	5d                   	pop    %ebp
 41a:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 41b:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 41d:	5d                   	pop    %ebp
 41e:	c3                   	ret    
 41f:	90                   	nop

00000420 <memset>:

void*
memset(void *dst, int c, uint n)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	8b 55 08             	mov    0x8(%ebp),%edx
 426:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 427:	8b 4d 10             	mov    0x10(%ebp),%ecx
 42a:	8b 45 0c             	mov    0xc(%ebp),%eax
 42d:	89 d7                	mov    %edx,%edi
 42f:	fc                   	cld    
 430:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 432:	5f                   	pop    %edi
 433:	89 d0                	mov    %edx,%eax
 435:	5d                   	pop    %ebp
 436:	c3                   	ret    
 437:	89 f6                	mov    %esi,%esi
 439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000440 <strchr>:

char*
strchr(const char *s, char c)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	8b 45 08             	mov    0x8(%ebp),%eax
 446:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 44a:	0f b6 10             	movzbl (%eax),%edx
 44d:	84 d2                	test   %dl,%dl
 44f:	74 1b                	je     46c <strchr+0x2c>
    if(*s == c)
 451:	38 d1                	cmp    %dl,%cl
 453:	75 0f                	jne    464 <strchr+0x24>
 455:	eb 17                	jmp    46e <strchr+0x2e>
 457:	89 f6                	mov    %esi,%esi
 459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 460:	38 ca                	cmp    %cl,%dl
 462:	74 0a                	je     46e <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 464:	40                   	inc    %eax
 465:	0f b6 10             	movzbl (%eax),%edx
 468:	84 d2                	test   %dl,%dl
 46a:	75 f4                	jne    460 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 46c:	31 c0                	xor    %eax,%eax
}
 46e:	5d                   	pop    %ebp
 46f:	c3                   	ret    

00000470 <gets>:

char*
gets(char *buf, int max)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	57                   	push   %edi
 474:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 475:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
 477:	53                   	push   %ebx
 478:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 47b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 47e:	eb 32                	jmp    4b2 <gets+0x42>
    cc = read(0, &c, 1);
 480:	b8 01 00 00 00       	mov    $0x1,%eax
 485:	89 44 24 08          	mov    %eax,0x8(%esp)
 489:	89 7c 24 04          	mov    %edi,0x4(%esp)
 48d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 494:	e8 47 01 00 00       	call   5e0 <read>
    if(cc < 1)
 499:	85 c0                	test   %eax,%eax
 49b:	7e 1d                	jle    4ba <gets+0x4a>
      break;
    buf[i++] = c;
 49d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 4a1:	89 de                	mov    %ebx,%esi
 4a3:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 4a6:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 4a8:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 4ac:	74 22                	je     4d0 <gets+0x60>
 4ae:	3c 0d                	cmp    $0xd,%al
 4b0:	74 1e                	je     4d0 <gets+0x60>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4b2:	8d 5e 01             	lea    0x1(%esi),%ebx
 4b5:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 4b8:	7c c6                	jl     480 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 4ba:	8b 45 08             	mov    0x8(%ebp),%eax
 4bd:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 4c1:	83 c4 2c             	add    $0x2c,%esp
 4c4:	5b                   	pop    %ebx
 4c5:	5e                   	pop    %esi
 4c6:	5f                   	pop    %edi
 4c7:	5d                   	pop    %ebp
 4c8:	c3                   	ret    
 4c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 4d0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4d3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 4d5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 4d9:	83 c4 2c             	add    $0x2c,%esp
 4dc:	5b                   	pop    %ebx
 4dd:	5e                   	pop    %esi
 4de:	5f                   	pop    %edi
 4df:	5d                   	pop    %ebp
 4e0:	c3                   	ret    
 4e1:	eb 0d                	jmp    4f0 <stat>
 4e3:	90                   	nop
 4e4:	90                   	nop
 4e5:	90                   	nop
 4e6:	90                   	nop
 4e7:	90                   	nop
 4e8:	90                   	nop
 4e9:	90                   	nop
 4ea:	90                   	nop
 4eb:	90                   	nop
 4ec:	90                   	nop
 4ed:	90                   	nop
 4ee:	90                   	nop
 4ef:	90                   	nop

000004f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 4f0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4f1:	31 c0                	xor    %eax,%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 4f3:	89 e5                	mov    %esp,%ebp
 4f5:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4f8:	89 44 24 04          	mov    %eax,0x4(%esp)
 4fc:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 4ff:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 502:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 505:	89 04 24             	mov    %eax,(%esp)
 508:	e8 fb 00 00 00       	call   608 <open>
  if(fd < 0)
 50d:	85 c0                	test   %eax,%eax
 50f:	78 2f                	js     540 <stat+0x50>
 511:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 513:	8b 45 0c             	mov    0xc(%ebp),%eax
 516:	89 1c 24             	mov    %ebx,(%esp)
 519:	89 44 24 04          	mov    %eax,0x4(%esp)
 51d:	e8 fe 00 00 00       	call   620 <fstat>
  close(fd);
 522:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 525:	89 c6                	mov    %eax,%esi
  close(fd);
 527:	e8 c4 00 00 00       	call   5f0 <close>
  return r;
 52c:	89 f0                	mov    %esi,%eax
}
 52e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 531:	8b 75 fc             	mov    -0x4(%ebp),%esi
 534:	89 ec                	mov    %ebp,%esp
 536:	5d                   	pop    %ebp
 537:	c3                   	ret    
 538:	90                   	nop
 539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 540:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 545:	eb e7                	jmp    52e <stat+0x3e>
 547:	89 f6                	mov    %esi,%esi
 549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000550 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	8b 4d 08             	mov    0x8(%ebp),%ecx
 556:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 557:	0f be 11             	movsbl (%ecx),%edx
 55a:	88 d0                	mov    %dl,%al
 55c:	2c 30                	sub    $0x30,%al
 55e:	3c 09                	cmp    $0x9,%al
 560:	b8 00 00 00 00       	mov    $0x0,%eax
 565:	77 1e                	ja     585 <atoi+0x35>
 567:	89 f6                	mov    %esi,%esi
 569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 570:	41                   	inc    %ecx
 571:	8d 04 80             	lea    (%eax,%eax,4),%eax
 574:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 578:	0f be 11             	movsbl (%ecx),%edx
 57b:	88 d3                	mov    %dl,%bl
 57d:	80 eb 30             	sub    $0x30,%bl
 580:	80 fb 09             	cmp    $0x9,%bl
 583:	76 eb                	jbe    570 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 585:	5b                   	pop    %ebx
 586:	5d                   	pop    %ebp
 587:	c3                   	ret    
 588:	90                   	nop
 589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000590 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	56                   	push   %esi
 594:	8b 45 08             	mov    0x8(%ebp),%eax
 597:	53                   	push   %ebx
 598:	8b 5d 10             	mov    0x10(%ebp),%ebx
 59b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 59e:	85 db                	test   %ebx,%ebx
 5a0:	7e 1a                	jle    5bc <memmove+0x2c>
 5a2:	31 d2                	xor    %edx,%edx
 5a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 5b0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 5b4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 5b7:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5b8:	39 da                	cmp    %ebx,%edx
 5ba:	75 f4                	jne    5b0 <memmove+0x20>
    *dst++ = *src++;
  return vdst;
}
 5bc:	5b                   	pop    %ebx
 5bd:	5e                   	pop    %esi
 5be:	5d                   	pop    %ebp
 5bf:	c3                   	ret    

000005c0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5c0:	b8 01 00 00 00       	mov    $0x1,%eax
 5c5:	cd 40                	int    $0x40
 5c7:	c3                   	ret    

000005c8 <exit>:
SYSCALL(exit)
 5c8:	b8 02 00 00 00       	mov    $0x2,%eax
 5cd:	cd 40                	int    $0x40
 5cf:	c3                   	ret    

000005d0 <wait>:
SYSCALL(wait)
 5d0:	b8 03 00 00 00       	mov    $0x3,%eax
 5d5:	cd 40                	int    $0x40
 5d7:	c3                   	ret    

000005d8 <pipe>:
SYSCALL(pipe)
 5d8:	b8 04 00 00 00       	mov    $0x4,%eax
 5dd:	cd 40                	int    $0x40
 5df:	c3                   	ret    

000005e0 <read>:
SYSCALL(read)
 5e0:	b8 05 00 00 00       	mov    $0x5,%eax
 5e5:	cd 40                	int    $0x40
 5e7:	c3                   	ret    

000005e8 <write>:
SYSCALL(write)
 5e8:	b8 10 00 00 00       	mov    $0x10,%eax
 5ed:	cd 40                	int    $0x40
 5ef:	c3                   	ret    

000005f0 <close>:
SYSCALL(close)
 5f0:	b8 15 00 00 00       	mov    $0x15,%eax
 5f5:	cd 40                	int    $0x40
 5f7:	c3                   	ret    

000005f8 <kill>:
SYSCALL(kill)
 5f8:	b8 06 00 00 00       	mov    $0x6,%eax
 5fd:	cd 40                	int    $0x40
 5ff:	c3                   	ret    

00000600 <exec>:
SYSCALL(exec)
 600:	b8 07 00 00 00       	mov    $0x7,%eax
 605:	cd 40                	int    $0x40
 607:	c3                   	ret    

00000608 <open>:
SYSCALL(open)
 608:	b8 0f 00 00 00       	mov    $0xf,%eax
 60d:	cd 40                	int    $0x40
 60f:	c3                   	ret    

00000610 <mknod>:
SYSCALL(mknod)
 610:	b8 11 00 00 00       	mov    $0x11,%eax
 615:	cd 40                	int    $0x40
 617:	c3                   	ret    

00000618 <unlink>:
SYSCALL(unlink)
 618:	b8 12 00 00 00       	mov    $0x12,%eax
 61d:	cd 40                	int    $0x40
 61f:	c3                   	ret    

00000620 <fstat>:
SYSCALL(fstat)
 620:	b8 08 00 00 00       	mov    $0x8,%eax
 625:	cd 40                	int    $0x40
 627:	c3                   	ret    

00000628 <link>:
SYSCALL(link)
 628:	b8 13 00 00 00       	mov    $0x13,%eax
 62d:	cd 40                	int    $0x40
 62f:	c3                   	ret    

00000630 <mkdir>:
SYSCALL(mkdir)
 630:	b8 14 00 00 00       	mov    $0x14,%eax
 635:	cd 40                	int    $0x40
 637:	c3                   	ret    

00000638 <chdir>:
SYSCALL(chdir)
 638:	b8 09 00 00 00       	mov    $0x9,%eax
 63d:	cd 40                	int    $0x40
 63f:	c3                   	ret    

00000640 <dup>:
SYSCALL(dup)
 640:	b8 0a 00 00 00       	mov    $0xa,%eax
 645:	cd 40                	int    $0x40
 647:	c3                   	ret    

00000648 <getpid>:
SYSCALL(getpid)
 648:	b8 0b 00 00 00       	mov    $0xb,%eax
 64d:	cd 40                	int    $0x40
 64f:	c3                   	ret    

00000650 <sbrk>:
SYSCALL(sbrk)
 650:	b8 0c 00 00 00       	mov    $0xc,%eax
 655:	cd 40                	int    $0x40
 657:	c3                   	ret    

00000658 <sleep>:
SYSCALL(sleep)
 658:	b8 0d 00 00 00       	mov    $0xd,%eax
 65d:	cd 40                	int    $0x40
 65f:	c3                   	ret    

00000660 <uptime>:
SYSCALL(uptime)
 660:	b8 0e 00 00 00       	mov    $0xe,%eax
 665:	cd 40                	int    $0x40
 667:	c3                   	ret    

00000668 <policy>:
SYSCALL(policy)
 668:	b8 17 00 00 00       	mov    $0x17,%eax
 66d:	cd 40                	int    $0x40
 66f:	c3                   	ret    

00000670 <detach>:
SYSCALL(detach)
 670:	b8 16 00 00 00       	mov    $0x16,%eax
 675:	cd 40                	int    $0x40
 677:	c3                   	ret    

00000678 <priority>:
SYSCALL(priority)
 678:	b8 18 00 00 00       	mov    $0x18,%eax
 67d:	cd 40                	int    $0x40
 67f:	c3                   	ret    

00000680 <wait_stat>:
SYSCALL(wait_stat)
 680:	b8 19 00 00 00       	mov    $0x19,%eax
 685:	cd 40                	int    $0x40
 687:	c3                   	ret    
 688:	66 90                	xchg   %ax,%ax
 68a:	66 90                	xchg   %ax,%ax
 68c:	66 90                	xchg   %ax,%ax
 68e:	66 90                	xchg   %ax,%ax

00000690 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	57                   	push   %edi
 694:	56                   	push   %esi
 695:	89 c6                	mov    %eax,%esi
 697:	53                   	push   %ebx
 698:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 69b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 69e:	85 db                	test   %ebx,%ebx
 6a0:	0f 84 8a 00 00 00    	je     730 <printint+0xa0>
 6a6:	89 d0                	mov    %edx,%eax
 6a8:	c1 e8 1f             	shr    $0x1f,%eax
 6ab:	84 c0                	test   %al,%al
 6ad:	0f 84 7d 00 00 00    	je     730 <printint+0xa0>
    neg = 1;
    x = -xx;
 6b3:	89 d0                	mov    %edx,%eax
 6b5:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 6b7:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 6be:	89 75 c0             	mov    %esi,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 6c1:	31 ff                	xor    %edi,%edi
 6c3:	89 ce                	mov    %ecx,%esi
 6c5:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 6c8:	eb 08                	jmp    6d2 <printint+0x42>
 6ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 6d0:	89 cf                	mov    %ecx,%edi
 6d2:	31 d2                	xor    %edx,%edx
 6d4:	f7 f6                	div    %esi
 6d6:	8d 4f 01             	lea    0x1(%edi),%ecx
 6d9:	0f b6 92 f4 0a 00 00 	movzbl 0xaf4(%edx),%edx
  }while((x /= base) != 0);
 6e0:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 6e2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 6e5:	75 e9                	jne    6d0 <printint+0x40>
  if(neg)
 6e7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 6ea:	8b 75 c0             	mov    -0x40(%ebp),%esi
 6ed:	85 d2                	test   %edx,%edx
 6ef:	74 08                	je     6f9 <printint+0x69>
    buf[i++] = '-';
 6f1:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 6f6:	8d 4f 02             	lea    0x2(%edi),%ecx
 6f9:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 6fd:	8d 76 00             	lea    0x0(%esi),%esi
 700:	0f b6 07             	movzbl (%edi),%eax
 703:	4f                   	dec    %edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 704:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 708:	89 34 24             	mov    %esi,(%esp)
 70b:	88 45 d7             	mov    %al,-0x29(%ebp)
 70e:	b8 01 00 00 00       	mov    $0x1,%eax
 713:	89 44 24 08          	mov    %eax,0x8(%esp)
 717:	e8 cc fe ff ff       	call   5e8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 71c:	39 df                	cmp    %ebx,%edi
 71e:	75 e0                	jne    700 <printint+0x70>
    putc(fd, buf[i]);
}
 720:	83 c4 4c             	add    $0x4c,%esp
 723:	5b                   	pop    %ebx
 724:	5e                   	pop    %esi
 725:	5f                   	pop    %edi
 726:	5d                   	pop    %ebp
 727:	c3                   	ret    
 728:	90                   	nop
 729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 730:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 732:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 739:	eb 83                	jmp    6be <printint+0x2e>
 73b:	90                   	nop
 73c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000740 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	57                   	push   %edi
 744:	56                   	push   %esi
 745:	53                   	push   %ebx
 746:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 749:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 74c:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 74f:	0f b6 1e             	movzbl (%esi),%ebx
 752:	84 db                	test   %bl,%bl
 754:	0f 84 c6 00 00 00    	je     820 <printf+0xe0>
 75a:	8d 45 10             	lea    0x10(%ebp),%eax
 75d:	46                   	inc    %esi
 75e:	89 45 d0             	mov    %eax,-0x30(%ebp)
 761:	31 d2                	xor    %edx,%edx
 763:	eb 3b                	jmp    7a0 <printf+0x60>
 765:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 768:	83 f8 25             	cmp    $0x25,%eax
 76b:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 76e:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 773:	74 1e                	je     793 <printf+0x53>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 775:	b8 01 00 00 00       	mov    $0x1,%eax
 77a:	89 44 24 08          	mov    %eax,0x8(%esp)
 77e:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 781:	89 44 24 04          	mov    %eax,0x4(%esp)
 785:	89 3c 24             	mov    %edi,(%esp)
 788:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 78b:	e8 58 fe ff ff       	call   5e8 <write>
 790:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 793:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 794:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 798:	84 db                	test   %bl,%bl
 79a:	0f 84 80 00 00 00    	je     820 <printf+0xe0>
    c = fmt[i] & 0xff;
    if(state == 0){
 7a0:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 7a2:	0f be cb             	movsbl %bl,%ecx
 7a5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 7a8:	74 be                	je     768 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 7aa:	83 fa 25             	cmp    $0x25,%edx
 7ad:	75 e4                	jne    793 <printf+0x53>
      if(c == 'd'){
 7af:	83 f8 64             	cmp    $0x64,%eax
 7b2:	0f 84 20 01 00 00    	je     8d8 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 7b8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 7be:	83 f9 70             	cmp    $0x70,%ecx
 7c1:	74 6d                	je     830 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 7c3:	83 f8 73             	cmp    $0x73,%eax
 7c6:	0f 84 94 00 00 00    	je     860 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7cc:	83 f8 63             	cmp    $0x63,%eax
 7cf:	0f 84 14 01 00 00    	je     8e9 <printf+0x1a9>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 7d5:	83 f8 25             	cmp    $0x25,%eax
 7d8:	0f 84 d2 00 00 00    	je     8b0 <printf+0x170>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7de:	b8 01 00 00 00       	mov    $0x1,%eax
 7e3:	46                   	inc    %esi
 7e4:	89 44 24 08          	mov    %eax,0x8(%esp)
 7e8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 7eb:	89 44 24 04          	mov    %eax,0x4(%esp)
 7ef:	89 3c 24             	mov    %edi,(%esp)
 7f2:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 7f6:	e8 ed fd ff ff       	call   5e8 <write>
 7fb:	ba 01 00 00 00       	mov    $0x1,%edx
 800:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 803:	89 54 24 08          	mov    %edx,0x8(%esp)
 807:	89 44 24 04          	mov    %eax,0x4(%esp)
 80b:	89 3c 24             	mov    %edi,(%esp)
 80e:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 811:	e8 d2 fd ff ff       	call   5e8 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 816:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 81a:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 81c:	84 db                	test   %bl,%bl
 81e:	75 80                	jne    7a0 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 820:	83 c4 3c             	add    $0x3c,%esp
 823:	5b                   	pop    %ebx
 824:	5e                   	pop    %esi
 825:	5f                   	pop    %edi
 826:	5d                   	pop    %ebp
 827:	c3                   	ret    
 828:	90                   	nop
 829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 830:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 837:	b9 10 00 00 00       	mov    $0x10,%ecx
 83c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 83f:	89 f8                	mov    %edi,%eax
 841:	8b 13                	mov    (%ebx),%edx
 843:	e8 48 fe ff ff       	call   690 <printint>
        ap++;
 848:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 84a:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 84c:	83 c0 04             	add    $0x4,%eax
 84f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 852:	e9 3c ff ff ff       	jmp    793 <printf+0x53>
 857:	89 f6                	mov    %esi,%esi
 859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      } else if(c == 's'){
        s = (char*)*ap;
 860:	8b 45 d0             	mov    -0x30(%ebp),%eax
 863:	8b 18                	mov    (%eax),%ebx
        ap++;
 865:	83 c0 04             	add    $0x4,%eax
 868:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 86b:	b8 ea 0a 00 00       	mov    $0xaea,%eax
 870:	85 db                	test   %ebx,%ebx
 872:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 875:	0f b6 03             	movzbl (%ebx),%eax
 878:	84 c0                	test   %al,%al
 87a:	74 27                	je     8a3 <printf+0x163>
 87c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 880:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 883:	b8 01 00 00 00       	mov    $0x1,%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 888:	43                   	inc    %ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 889:	89 44 24 08          	mov    %eax,0x8(%esp)
 88d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 890:	89 44 24 04          	mov    %eax,0x4(%esp)
 894:	89 3c 24             	mov    %edi,(%esp)
 897:	e8 4c fd ff ff       	call   5e8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 89c:	0f b6 03             	movzbl (%ebx),%eax
 89f:	84 c0                	test   %al,%al
 8a1:	75 dd                	jne    880 <printf+0x140>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8a3:	31 d2                	xor    %edx,%edx
 8a5:	e9 e9 fe ff ff       	jmp    793 <printf+0x53>
 8aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8b0:	b9 01 00 00 00       	mov    $0x1,%ecx
 8b5:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 8b8:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 8bc:	89 44 24 04          	mov    %eax,0x4(%esp)
 8c0:	89 3c 24             	mov    %edi,(%esp)
 8c3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 8c6:	e8 1d fd ff ff       	call   5e8 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8cb:	31 d2                	xor    %edx,%edx
 8cd:	e9 c1 fe ff ff       	jmp    793 <printf+0x53>
 8d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 8d8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 8df:	b9 0a 00 00 00       	mov    $0xa,%ecx
 8e4:	e9 53 ff ff ff       	jmp    83c <printf+0xfc>
 8e9:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 8ec:	8b 03                	mov    (%ebx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8ee:	89 3c 24             	mov    %edi,(%esp)
 8f1:	88 45 e4             	mov    %al,-0x1c(%ebp)
 8f4:	b8 01 00 00 00       	mov    $0x1,%eax
 8f9:	89 44 24 08          	mov    %eax,0x8(%esp)
 8fd:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 900:	89 44 24 04          	mov    %eax,0x4(%esp)
 904:	e8 df fc ff ff       	call   5e8 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 909:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 90b:	31 d2                	xor    %edx,%edx
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 90d:	83 c0 04             	add    $0x4,%eax
 910:	89 45 d0             	mov    %eax,-0x30(%ebp)
 913:	e9 7b fe ff ff       	jmp    793 <printf+0x53>
 918:	66 90                	xchg   %ax,%ax
 91a:	66 90                	xchg   %ax,%ax
 91c:	66 90                	xchg   %ax,%ax
 91e:	66 90                	xchg   %ax,%ax

00000920 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 920:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 921:	a1 fc 0d 00 00       	mov    0xdfc,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 926:	89 e5                	mov    %esp,%ebp
 928:	57                   	push   %edi
 929:	56                   	push   %esi
 92a:	53                   	push   %ebx
 92b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 92e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 930:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 933:	39 c8                	cmp    %ecx,%eax
 935:	73 19                	jae    950 <free+0x30>
 937:	89 f6                	mov    %esi,%esi
 939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 940:	39 d1                	cmp    %edx,%ecx
 942:	72 1c                	jb     960 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 944:	39 d0                	cmp    %edx,%eax
 946:	73 18                	jae    960 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 948:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 94a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 94c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 94e:	72 f0                	jb     940 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 950:	39 d0                	cmp    %edx,%eax
 952:	72 f4                	jb     948 <free+0x28>
 954:	39 d1                	cmp    %edx,%ecx
 956:	73 f0                	jae    948 <free+0x28>
 958:	90                   	nop
 959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 960:	8b 73 fc             	mov    -0x4(%ebx),%esi
 963:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 966:	39 d7                	cmp    %edx,%edi
 968:	74 19                	je     983 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 96a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 96d:	8b 50 04             	mov    0x4(%eax),%edx
 970:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 973:	39 f1                	cmp    %esi,%ecx
 975:	74 25                	je     99c <free+0x7c>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 977:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 979:	5b                   	pop    %ebx
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 97a:	a3 fc 0d 00 00       	mov    %eax,0xdfc
}
 97f:	5e                   	pop    %esi
 980:	5f                   	pop    %edi
 981:	5d                   	pop    %ebp
 982:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 983:	8b 7a 04             	mov    0x4(%edx),%edi
 986:	01 fe                	add    %edi,%esi
 988:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 98b:	8b 10                	mov    (%eax),%edx
 98d:	8b 12                	mov    (%edx),%edx
 98f:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 992:	8b 50 04             	mov    0x4(%eax),%edx
 995:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 998:	39 f1                	cmp    %esi,%ecx
 99a:	75 db                	jne    977 <free+0x57>
    p->s.size += bp->s.size;
 99c:	8b 4b fc             	mov    -0x4(%ebx),%ecx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 99f:	a3 fc 0d 00 00       	mov    %eax,0xdfc
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9a4:	01 ca                	add    %ecx,%edx
 9a6:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 9a9:	8b 53 f8             	mov    -0x8(%ebx),%edx
 9ac:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 9ae:	5b                   	pop    %ebx
 9af:	5e                   	pop    %esi
 9b0:	5f                   	pop    %edi
 9b1:	5d                   	pop    %ebp
 9b2:	c3                   	ret    
 9b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 9b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9c0:	55                   	push   %ebp
 9c1:	89 e5                	mov    %esp,%ebp
 9c3:	57                   	push   %edi
 9c4:	56                   	push   %esi
 9c5:	53                   	push   %ebx
 9c6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 9cc:	8b 15 fc 0d 00 00    	mov    0xdfc,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9d2:	8d 78 07             	lea    0x7(%eax),%edi
 9d5:	c1 ef 03             	shr    $0x3,%edi
 9d8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 9d9:	85 d2                	test   %edx,%edx
 9db:	0f 84 95 00 00 00    	je     a76 <malloc+0xb6>
 9e1:	8b 02                	mov    (%edx),%eax
 9e3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 9e6:	39 cf                	cmp    %ecx,%edi
 9e8:	76 66                	jbe    a50 <malloc+0x90>
 9ea:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 9f0:	be 00 10 00 00       	mov    $0x1000,%esi
 9f5:	0f 43 f7             	cmovae %edi,%esi
 9f8:	ba 00 80 00 00       	mov    $0x8000,%edx
 9fd:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 a04:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 a0a:	0f 46 da             	cmovbe %edx,%ebx
 a0d:	eb 0a                	jmp    a19 <malloc+0x59>
 a0f:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a10:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a12:	8b 48 04             	mov    0x4(%eax),%ecx
 a15:	39 cf                	cmp    %ecx,%edi
 a17:	76 37                	jbe    a50 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a19:	39 05 fc 0d 00 00    	cmp    %eax,0xdfc
 a1f:	89 c2                	mov    %eax,%edx
 a21:	75 ed                	jne    a10 <malloc+0x50>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 a23:	89 1c 24             	mov    %ebx,(%esp)
 a26:	e8 25 fc ff ff       	call   650 <sbrk>
  if(p == (char*)-1)
 a2b:	83 f8 ff             	cmp    $0xffffffff,%eax
 a2e:	74 18                	je     a48 <malloc+0x88>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 a30:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 a33:	83 c0 08             	add    $0x8,%eax
 a36:	89 04 24             	mov    %eax,(%esp)
 a39:	e8 e2 fe ff ff       	call   920 <free>
  return freep;
 a3e:	8b 15 fc 0d 00 00    	mov    0xdfc,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 a44:	85 d2                	test   %edx,%edx
 a46:	75 c8                	jne    a10 <malloc+0x50>
        return 0;
 a48:	31 c0                	xor    %eax,%eax
 a4a:	eb 1c                	jmp    a68 <malloc+0xa8>
 a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 a50:	39 cf                	cmp    %ecx,%edi
 a52:	74 1c                	je     a70 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 a54:	29 f9                	sub    %edi,%ecx
 a56:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 a59:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 a5c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 a5f:	89 15 fc 0d 00 00    	mov    %edx,0xdfc
      return (void*)(p + 1);
 a65:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a68:	83 c4 1c             	add    $0x1c,%esp
 a6b:	5b                   	pop    %ebx
 a6c:	5e                   	pop    %esi
 a6d:	5f                   	pop    %edi
 a6e:	5d                   	pop    %ebp
 a6f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 a70:	8b 08                	mov    (%eax),%ecx
 a72:	89 0a                	mov    %ecx,(%edx)
 a74:	eb e9                	jmp    a5f <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 a76:	b8 00 0e 00 00       	mov    $0xe00,%eax
 a7b:	ba 00 0e 00 00       	mov    $0xe00,%edx
    base.s.size = 0;
 a80:	31 c9                	xor    %ecx,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 a82:	a3 fc 0d 00 00       	mov    %eax,0xdfc
    base.s.size = 0;
 a87:	b8 00 0e 00 00       	mov    $0xe00,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 a8c:	89 15 00 0e 00 00    	mov    %edx,0xe00
    base.s.size = 0;
 a92:	89 0d 04 0e 00 00    	mov    %ecx,0xe04
 a98:	e9 4d ff ff ff       	jmp    9ea <malloc+0x2a>
