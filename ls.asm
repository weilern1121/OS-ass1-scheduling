
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
  3c:	c7 04 24 d8 0a 00 00 	movl   $0xad8,(%esp)
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
  a6:	c7 04 24 dc 0d 00 00 	movl   $0xddc,(%esp)
  ad:	89 44 24 08          	mov    %eax,0x8(%esp)
  b1:	e8 da 04 00 00       	call   590 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  b6:	89 1c 24             	mov    %ebx,(%esp)
  b9:	e8 42 03 00 00       	call   400 <strlen>
  be:	89 1c 24             	mov    %ebx,(%esp)
  return buf;
  c1:	bb dc 0d 00 00       	mov    $0xddc,%ebx

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
  e1:	05 dc 0d 00 00       	add    $0xddc,%eax
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
 172:	b9 b8 0a 00 00       	mov    $0xab8,%ecx
 177:	89 74 24 10          	mov    %esi,0x10(%esp)
 17b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 17f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 186:	89 54 24 14          	mov    %edx,0x14(%esp)
 18a:	ba 02 00 00 00       	mov    $0x2,%edx
 18f:	89 54 24 0c          	mov    %edx,0xc(%esp)
 193:	89 44 24 08          	mov    %eax,0x8(%esp)
 197:	e8 94 05 00 00       	call   730 <printf>
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
 2d1:	ba b8 0a 00 00       	mov    $0xab8,%edx
 2d6:	89 44 24 08          	mov    %eax,0x8(%esp)
 2da:	89 54 24 04          	mov    %edx,0x4(%esp)
 2de:	89 4c 24 10          	mov    %ecx,0x10(%esp)
 2e2:	e8 49 04 00 00       	call   730 <printf>
 2e7:	e9 24 ff ff ff       	jmp    210 <ls+0x110>
 2ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
    printf(2, "ls: cannot open %s\n", path);
 2f0:	89 7c 24 08          	mov    %edi,0x8(%esp)
 2f4:	bf 90 0a 00 00       	mov    $0xa90,%edi
 2f9:	89 7c 24 04          	mov    %edi,0x4(%esp)
 2fd:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 304:	e8 27 04 00 00       	call   730 <printf>
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
 318:	b8 c5 0a 00 00       	mov    $0xac5,%eax
 31d:	89 44 24 04          	mov    %eax,0x4(%esp)
 321:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 328:	e8 03 04 00 00       	call   730 <printf>
      break;
 32d:	e9 6a fe ff ff       	jmp    19c <ls+0x9c>
 332:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
    printf(2, "ls: cannot stat %s\n", path);
 338:	be a4 0a 00 00       	mov    $0xaa4,%esi
 33d:	89 7c 24 08          	mov    %edi,0x8(%esp)
 341:	89 74 24 04          	mov    %esi,0x4(%esp)
 345:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 34c:	e8 df 03 00 00       	call   730 <printf>
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
 366:	b9 a4 0a 00 00       	mov    $0xaa4,%ecx
 36b:	89 44 24 08          	mov    %eax,0x8(%esp)
 36f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 373:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 37a:	e8 b1 03 00 00       	call   730 <printf>
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

00000680 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 680:	55                   	push   %ebp
 681:	89 e5                	mov    %esp,%ebp
 683:	57                   	push   %edi
 684:	56                   	push   %esi
 685:	89 c6                	mov    %eax,%esi
 687:	53                   	push   %ebx
 688:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 68b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 68e:	85 db                	test   %ebx,%ebx
 690:	0f 84 8a 00 00 00    	je     720 <printint+0xa0>
 696:	89 d0                	mov    %edx,%eax
 698:	c1 e8 1f             	shr    $0x1f,%eax
 69b:	84 c0                	test   %al,%al
 69d:	0f 84 7d 00 00 00    	je     720 <printint+0xa0>
    neg = 1;
    x = -xx;
 6a3:	89 d0                	mov    %edx,%eax
 6a5:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 6a7:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 6ae:	89 75 c0             	mov    %esi,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 6b1:	31 ff                	xor    %edi,%edi
 6b3:	89 ce                	mov    %ecx,%esi
 6b5:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 6b8:	eb 08                	jmp    6c2 <printint+0x42>
 6ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 6c0:	89 cf                	mov    %ecx,%edi
 6c2:	31 d2                	xor    %edx,%edx
 6c4:	f7 f6                	div    %esi
 6c6:	8d 4f 01             	lea    0x1(%edi),%ecx
 6c9:	0f b6 92 e4 0a 00 00 	movzbl 0xae4(%edx),%edx
  }while((x /= base) != 0);
 6d0:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 6d2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 6d5:	75 e9                	jne    6c0 <printint+0x40>
  if(neg)
 6d7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 6da:	8b 75 c0             	mov    -0x40(%ebp),%esi
 6dd:	85 d2                	test   %edx,%edx
 6df:	74 08                	je     6e9 <printint+0x69>
    buf[i++] = '-';
 6e1:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 6e6:	8d 4f 02             	lea    0x2(%edi),%ecx
 6e9:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 6ed:	8d 76 00             	lea    0x0(%esi),%esi
 6f0:	0f b6 07             	movzbl (%edi),%eax
 6f3:	4f                   	dec    %edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6f4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 6f8:	89 34 24             	mov    %esi,(%esp)
 6fb:	88 45 d7             	mov    %al,-0x29(%ebp)
 6fe:	b8 01 00 00 00       	mov    $0x1,%eax
 703:	89 44 24 08          	mov    %eax,0x8(%esp)
 707:	e8 dc fe ff ff       	call   5e8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 70c:	39 df                	cmp    %ebx,%edi
 70e:	75 e0                	jne    6f0 <printint+0x70>
    putc(fd, buf[i]);
}
 710:	83 c4 4c             	add    $0x4c,%esp
 713:	5b                   	pop    %ebx
 714:	5e                   	pop    %esi
 715:	5f                   	pop    %edi
 716:	5d                   	pop    %ebp
 717:	c3                   	ret    
 718:	90                   	nop
 719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 720:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 722:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 729:	eb 83                	jmp    6ae <printint+0x2e>
 72b:	90                   	nop
 72c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000730 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 730:	55                   	push   %ebp
 731:	89 e5                	mov    %esp,%ebp
 733:	57                   	push   %edi
 734:	56                   	push   %esi
 735:	53                   	push   %ebx
 736:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 739:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 73c:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 73f:	0f b6 1e             	movzbl (%esi),%ebx
 742:	84 db                	test   %bl,%bl
 744:	0f 84 c6 00 00 00    	je     810 <printf+0xe0>
 74a:	8d 45 10             	lea    0x10(%ebp),%eax
 74d:	46                   	inc    %esi
 74e:	89 45 d0             	mov    %eax,-0x30(%ebp)
 751:	31 d2                	xor    %edx,%edx
 753:	eb 3b                	jmp    790 <printf+0x60>
 755:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 758:	83 f8 25             	cmp    $0x25,%eax
 75b:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 75e:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 763:	74 1e                	je     783 <printf+0x53>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 765:	b8 01 00 00 00       	mov    $0x1,%eax
 76a:	89 44 24 08          	mov    %eax,0x8(%esp)
 76e:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 771:	89 44 24 04          	mov    %eax,0x4(%esp)
 775:	89 3c 24             	mov    %edi,(%esp)
 778:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 77b:	e8 68 fe ff ff       	call   5e8 <write>
 780:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 783:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 784:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 788:	84 db                	test   %bl,%bl
 78a:	0f 84 80 00 00 00    	je     810 <printf+0xe0>
    c = fmt[i] & 0xff;
    if(state == 0){
 790:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 792:	0f be cb             	movsbl %bl,%ecx
 795:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 798:	74 be                	je     758 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 79a:	83 fa 25             	cmp    $0x25,%edx
 79d:	75 e4                	jne    783 <printf+0x53>
      if(c == 'd'){
 79f:	83 f8 64             	cmp    $0x64,%eax
 7a2:	0f 84 20 01 00 00    	je     8c8 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 7a8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 7ae:	83 f9 70             	cmp    $0x70,%ecx
 7b1:	74 6d                	je     820 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 7b3:	83 f8 73             	cmp    $0x73,%eax
 7b6:	0f 84 94 00 00 00    	je     850 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7bc:	83 f8 63             	cmp    $0x63,%eax
 7bf:	0f 84 14 01 00 00    	je     8d9 <printf+0x1a9>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 7c5:	83 f8 25             	cmp    $0x25,%eax
 7c8:	0f 84 d2 00 00 00    	je     8a0 <printf+0x170>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7ce:	b8 01 00 00 00       	mov    $0x1,%eax
 7d3:	46                   	inc    %esi
 7d4:	89 44 24 08          	mov    %eax,0x8(%esp)
 7d8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 7db:	89 44 24 04          	mov    %eax,0x4(%esp)
 7df:	89 3c 24             	mov    %edi,(%esp)
 7e2:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 7e6:	e8 fd fd ff ff       	call   5e8 <write>
 7eb:	ba 01 00 00 00       	mov    $0x1,%edx
 7f0:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 7f3:	89 54 24 08          	mov    %edx,0x8(%esp)
 7f7:	89 44 24 04          	mov    %eax,0x4(%esp)
 7fb:	89 3c 24             	mov    %edi,(%esp)
 7fe:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 801:	e8 e2 fd ff ff       	call   5e8 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 806:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 80a:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 80c:	84 db                	test   %bl,%bl
 80e:	75 80                	jne    790 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 810:	83 c4 3c             	add    $0x3c,%esp
 813:	5b                   	pop    %ebx
 814:	5e                   	pop    %esi
 815:	5f                   	pop    %edi
 816:	5d                   	pop    %ebp
 817:	c3                   	ret    
 818:	90                   	nop
 819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 820:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 827:	b9 10 00 00 00       	mov    $0x10,%ecx
 82c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 82f:	89 f8                	mov    %edi,%eax
 831:	8b 13                	mov    (%ebx),%edx
 833:	e8 48 fe ff ff       	call   680 <printint>
        ap++;
 838:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 83a:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 83c:	83 c0 04             	add    $0x4,%eax
 83f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 842:	e9 3c ff ff ff       	jmp    783 <printf+0x53>
 847:	89 f6                	mov    %esi,%esi
 849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      } else if(c == 's'){
        s = (char*)*ap;
 850:	8b 45 d0             	mov    -0x30(%ebp),%eax
 853:	8b 18                	mov    (%eax),%ebx
        ap++;
 855:	83 c0 04             	add    $0x4,%eax
 858:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 85b:	b8 da 0a 00 00       	mov    $0xada,%eax
 860:	85 db                	test   %ebx,%ebx
 862:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 865:	0f b6 03             	movzbl (%ebx),%eax
 868:	84 c0                	test   %al,%al
 86a:	74 27                	je     893 <printf+0x163>
 86c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 870:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 873:	b8 01 00 00 00       	mov    $0x1,%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 878:	43                   	inc    %ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 879:	89 44 24 08          	mov    %eax,0x8(%esp)
 87d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 880:	89 44 24 04          	mov    %eax,0x4(%esp)
 884:	89 3c 24             	mov    %edi,(%esp)
 887:	e8 5c fd ff ff       	call   5e8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 88c:	0f b6 03             	movzbl (%ebx),%eax
 88f:	84 c0                	test   %al,%al
 891:	75 dd                	jne    870 <printf+0x140>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 893:	31 d2                	xor    %edx,%edx
 895:	e9 e9 fe ff ff       	jmp    783 <printf+0x53>
 89a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8a0:	b9 01 00 00 00       	mov    $0x1,%ecx
 8a5:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 8a8:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 8ac:	89 44 24 04          	mov    %eax,0x4(%esp)
 8b0:	89 3c 24             	mov    %edi,(%esp)
 8b3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 8b6:	e8 2d fd ff ff       	call   5e8 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8bb:	31 d2                	xor    %edx,%edx
 8bd:	e9 c1 fe ff ff       	jmp    783 <printf+0x53>
 8c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 8c8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 8cf:	b9 0a 00 00 00       	mov    $0xa,%ecx
 8d4:	e9 53 ff ff ff       	jmp    82c <printf+0xfc>
 8d9:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 8dc:	8b 03                	mov    (%ebx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8de:	89 3c 24             	mov    %edi,(%esp)
 8e1:	88 45 e4             	mov    %al,-0x1c(%ebp)
 8e4:	b8 01 00 00 00       	mov    $0x1,%eax
 8e9:	89 44 24 08          	mov    %eax,0x8(%esp)
 8ed:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 8f0:	89 44 24 04          	mov    %eax,0x4(%esp)
 8f4:	e8 ef fc ff ff       	call   5e8 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 8f9:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8fb:	31 d2                	xor    %edx,%edx
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 8fd:	83 c0 04             	add    $0x4,%eax
 900:	89 45 d0             	mov    %eax,-0x30(%ebp)
 903:	e9 7b fe ff ff       	jmp    783 <printf+0x53>
 908:	66 90                	xchg   %ax,%ax
 90a:	66 90                	xchg   %ax,%ax
 90c:	66 90                	xchg   %ax,%ax
 90e:	66 90                	xchg   %ax,%ax

00000910 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 910:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 911:	a1 ec 0d 00 00       	mov    0xdec,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 916:	89 e5                	mov    %esp,%ebp
 918:	57                   	push   %edi
 919:	56                   	push   %esi
 91a:	53                   	push   %ebx
 91b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 91e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 920:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 923:	39 c8                	cmp    %ecx,%eax
 925:	73 19                	jae    940 <free+0x30>
 927:	89 f6                	mov    %esi,%esi
 929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 930:	39 d1                	cmp    %edx,%ecx
 932:	72 1c                	jb     950 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 934:	39 d0                	cmp    %edx,%eax
 936:	73 18                	jae    950 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 938:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 93a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 93c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 93e:	72 f0                	jb     930 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 940:	39 d0                	cmp    %edx,%eax
 942:	72 f4                	jb     938 <free+0x28>
 944:	39 d1                	cmp    %edx,%ecx
 946:	73 f0                	jae    938 <free+0x28>
 948:	90                   	nop
 949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 950:	8b 73 fc             	mov    -0x4(%ebx),%esi
 953:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 956:	39 d7                	cmp    %edx,%edi
 958:	74 19                	je     973 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 95a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 95d:	8b 50 04             	mov    0x4(%eax),%edx
 960:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 963:	39 f1                	cmp    %esi,%ecx
 965:	74 25                	je     98c <free+0x7c>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 967:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 969:	5b                   	pop    %ebx
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 96a:	a3 ec 0d 00 00       	mov    %eax,0xdec
}
 96f:	5e                   	pop    %esi
 970:	5f                   	pop    %edi
 971:	5d                   	pop    %ebp
 972:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 973:	8b 7a 04             	mov    0x4(%edx),%edi
 976:	01 fe                	add    %edi,%esi
 978:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 97b:	8b 10                	mov    (%eax),%edx
 97d:	8b 12                	mov    (%edx),%edx
 97f:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 982:	8b 50 04             	mov    0x4(%eax),%edx
 985:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 988:	39 f1                	cmp    %esi,%ecx
 98a:	75 db                	jne    967 <free+0x57>
    p->s.size += bp->s.size;
 98c:	8b 4b fc             	mov    -0x4(%ebx),%ecx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 98f:	a3 ec 0d 00 00       	mov    %eax,0xdec
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 994:	01 ca                	add    %ecx,%edx
 996:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 999:	8b 53 f8             	mov    -0x8(%ebx),%edx
 99c:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 99e:	5b                   	pop    %ebx
 99f:	5e                   	pop    %esi
 9a0:	5f                   	pop    %edi
 9a1:	5d                   	pop    %ebp
 9a2:	c3                   	ret    
 9a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 9a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9b0:	55                   	push   %ebp
 9b1:	89 e5                	mov    %esp,%ebp
 9b3:	57                   	push   %edi
 9b4:	56                   	push   %esi
 9b5:	53                   	push   %ebx
 9b6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 9bc:	8b 15 ec 0d 00 00    	mov    0xdec,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9c2:	8d 78 07             	lea    0x7(%eax),%edi
 9c5:	c1 ef 03             	shr    $0x3,%edi
 9c8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 9c9:	85 d2                	test   %edx,%edx
 9cb:	0f 84 95 00 00 00    	je     a66 <malloc+0xb6>
 9d1:	8b 02                	mov    (%edx),%eax
 9d3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 9d6:	39 cf                	cmp    %ecx,%edi
 9d8:	76 66                	jbe    a40 <malloc+0x90>
 9da:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 9e0:	be 00 10 00 00       	mov    $0x1000,%esi
 9e5:	0f 43 f7             	cmovae %edi,%esi
 9e8:	ba 00 80 00 00       	mov    $0x8000,%edx
 9ed:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 9f4:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 9fa:	0f 46 da             	cmovbe %edx,%ebx
 9fd:	eb 0a                	jmp    a09 <malloc+0x59>
 9ff:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a00:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a02:	8b 48 04             	mov    0x4(%eax),%ecx
 a05:	39 cf                	cmp    %ecx,%edi
 a07:	76 37                	jbe    a40 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a09:	39 05 ec 0d 00 00    	cmp    %eax,0xdec
 a0f:	89 c2                	mov    %eax,%edx
 a11:	75 ed                	jne    a00 <malloc+0x50>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 a13:	89 1c 24             	mov    %ebx,(%esp)
 a16:	e8 35 fc ff ff       	call   650 <sbrk>
  if(p == (char*)-1)
 a1b:	83 f8 ff             	cmp    $0xffffffff,%eax
 a1e:	74 18                	je     a38 <malloc+0x88>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 a20:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 a23:	83 c0 08             	add    $0x8,%eax
 a26:	89 04 24             	mov    %eax,(%esp)
 a29:	e8 e2 fe ff ff       	call   910 <free>
  return freep;
 a2e:	8b 15 ec 0d 00 00    	mov    0xdec,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 a34:	85 d2                	test   %edx,%edx
 a36:	75 c8                	jne    a00 <malloc+0x50>
        return 0;
 a38:	31 c0                	xor    %eax,%eax
 a3a:	eb 1c                	jmp    a58 <malloc+0xa8>
 a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 a40:	39 cf                	cmp    %ecx,%edi
 a42:	74 1c                	je     a60 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 a44:	29 f9                	sub    %edi,%ecx
 a46:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 a49:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 a4c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 a4f:	89 15 ec 0d 00 00    	mov    %edx,0xdec
      return (void*)(p + 1);
 a55:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a58:	83 c4 1c             	add    $0x1c,%esp
 a5b:	5b                   	pop    %ebx
 a5c:	5e                   	pop    %esi
 a5d:	5f                   	pop    %edi
 a5e:	5d                   	pop    %ebp
 a5f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 a60:	8b 08                	mov    (%eax),%ecx
 a62:	89 0a                	mov    %ecx,(%edx)
 a64:	eb e9                	jmp    a4f <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 a66:	b8 f0 0d 00 00       	mov    $0xdf0,%eax
 a6b:	ba f0 0d 00 00       	mov    $0xdf0,%edx
    base.s.size = 0;
 a70:	31 c9                	xor    %ecx,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 a72:	a3 ec 0d 00 00       	mov    %eax,0xdec
    base.s.size = 0;
 a77:	b8 f0 0d 00 00       	mov    $0xdf0,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 a7c:	89 15 f0 0d 00 00    	mov    %edx,0xdf0
    base.s.size = 0;
 a82:	89 0d f4 0d 00 00    	mov    %ecx,0xdf4
 a88:	e9 4d ff ff ff       	jmp    9da <malloc+0x2a>
