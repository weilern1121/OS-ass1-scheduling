
_pathTest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "../../traps.h"
#include "../../memlayout.h"

void execute(char * command, char** args);

int main(int argc, char *argv[]){
   0:	55                   	push   %ebp
    int fd;
    int writed;

    printf(1,"opening path\n");
   1:	b8 e5 0a 00 00       	mov    $0xae5,%eax
int main(int argc, char *argv[]){
   6:	89 e5                	mov    %esp,%ebp
   8:	56                   	push   %esi
   9:	53                   	push   %ebx
   a:	83 e4 f0             	and    $0xfffffff0,%esp
   d:	83 ec 20             	sub    $0x20,%esp
    printf(1,"opening path\n");
  10:	89 44 24 04          	mov    %eax,0x4(%esp)
  14:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1b:	e8 30 07 00 00       	call   750 <printf>
    fd = open("/path",O_WRONLY);
  20:	ba 01 00 00 00       	mov    $0x1,%edx
  25:	89 54 24 04          	mov    %edx,0x4(%esp)
  29:	c7 04 24 a7 0b 00 00 	movl   $0xba7,(%esp)
  30:	e8 f3 05 00 00       	call   628 <open>

    if(fd < 0){
  35:	85 c0                	test   %eax,%eax
  37:	0f 88 c5 02 00 00    	js     302 <main+0x302>
        exit(0);
    }

    const char * path = "/:/bin/:/hello/world/path/:/under/world/path";
    
    printf(1,"writing to path\n");
  3d:	c7 44 24 04 0f 0b 00 	movl   $0xb0f,0x4(%esp)
  44:	00 
  45:	89 c3                	mov    %eax,%ebx
  47:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  4e:	e8 fd 06 00 00       	call   750 <printf>
    writed = write(fd,path,strlen(path));
  53:	c7 04 24 54 0c 00 00 	movl   $0xc54,(%esp)
  5a:	e8 c1 03 00 00       	call   420 <strlen>
  5f:	c7 44 24 04 54 0c 00 	movl   $0xc54,0x4(%esp)
  66:	00 
  67:	89 1c 24             	mov    %ebx,(%esp)
  6a:	89 44 24 08          	mov    %eax,0x8(%esp)
  6e:	e8 95 05 00 00       	call   608 <write>
    
    if(writed != strlen(path)){
  73:	c7 04 24 54 0c 00 00 	movl   $0xc54,(%esp)
    writed = write(fd,path,strlen(path));
  7a:	89 c6                	mov    %eax,%esi
    if(writed != strlen(path)){
  7c:	e8 9f 03 00 00       	call   420 <strlen>
  81:	39 f0                	cmp    %esi,%eax
  83:	0f 85 5c 02 00 00    	jne    2e5 <main+0x2e5>
        printf(1,"error in writing to path, %d were written\n",writed);
    }

    printf(1,"closing path file\n");
  89:	c7 44 24 04 20 0b 00 	movl   $0xb20,0x4(%esp)
  90:	00 
  91:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  98:	e8 b3 06 00 00       	call   750 <printf>
    close(fd);
  9d:	89 1c 24             	mov    %ebx,(%esp)
    printf(1,"creating /bin/ path\n");
    args[0] = "/mkdir";
    args[1] = "/bin/";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);
  a0:	8d 5c 24 10          	lea    0x10(%esp),%ebx
    close(fd);
  a4:	e8 67 05 00 00       	call   610 <close>
    printf(1,"creating /bin/ path\n");
  a9:	c7 44 24 04 33 0b 00 	movl   $0xb33,0x4(%esp)
  b0:	00 
  b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  b8:	e8 93 06 00 00       	call   750 <printf>
    execute(command,args);
  bd:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  c1:	c7 04 24 48 0b 00 00 	movl   $0xb48,(%esp)
    args[0] = "/mkdir";
  c8:	c7 44 24 10 48 0b 00 	movl   $0xb48,0x10(%esp)
  cf:	00 
    args[1] = "/bin/";
  d0:	c7 44 24 14 4f 0b 00 	movl   $0xb4f,0x14(%esp)
  d7:	00 
    args[2] = 0;
  d8:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  df:	00 
    execute(command,args);
  e0:	e8 4b 02 00 00       	call   330 <execute>
    
    printf(1,"creating /hello path\n");
  e5:	c7 44 24 04 55 0b 00 	movl   $0xb55,0x4(%esp)
  ec:	00 
  ed:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  f4:	e8 57 06 00 00       	call   750 <printf>
    args[0] = "/mkdir";
    args[1] = "/hello";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);
  f9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  fd:	c7 04 24 48 0b 00 00 	movl   $0xb48,(%esp)
    args[0] = "/mkdir";
 104:	c7 44 24 10 48 0b 00 	movl   $0xb48,0x10(%esp)
 10b:	00 
    args[1] = "/hello";
 10c:	c7 44 24 14 6b 0b 00 	movl   $0xb6b,0x14(%esp)
 113:	00 
    args[2] = 0;
 114:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
 11b:	00 
    execute(command,args);
 11c:	e8 0f 02 00 00       	call   330 <execute>

    printf(1,"creating /hello/world path\n");
 121:	c7 44 24 04 72 0b 00 	movl   $0xb72,0x4(%esp)
 128:	00 
 129:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 130:	e8 1b 06 00 00       	call   750 <printf>
    args[0] = "/mkdir";
    args[1] = "/hello/world";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);
 135:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 139:	c7 04 24 48 0b 00 00 	movl   $0xb48,(%esp)
    args[0] = "/mkdir";
 140:	c7 44 24 10 48 0b 00 	movl   $0xb48,0x10(%esp)
 147:	00 
    args[1] = "/hello/world";
 148:	c7 44 24 14 8e 0b 00 	movl   $0xb8e,0x14(%esp)
 14f:	00 
    args[2] = 0;
 150:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
 157:	00 
    execute(command,args);
 158:	e8 d3 01 00 00       	call   330 <execute>

    printf(1,"creating /hello/world/path path\n");
 15d:	c7 44 24 04 b0 0c 00 	movl   $0xcb0,0x4(%esp)
 164:	00 
 165:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 16c:	e8 df 05 00 00       	call   750 <printf>
    args[0] = "/mkdir";
    args[1] = "/hello/world/path";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);
 171:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 175:	c7 04 24 48 0b 00 00 	movl   $0xb48,(%esp)
    args[0] = "/mkdir";
 17c:	c7 44 24 10 48 0b 00 	movl   $0xb48,0x10(%esp)
 183:	00 
    args[1] = "/hello/world/path";
 184:	c7 44 24 14 9b 0b 00 	movl   $0xb9b,0x14(%esp)
 18b:	00 
    args[2] = 0;
 18c:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
 193:	00 
    execute(command,args);
 194:	e8 97 01 00 00       	call   330 <execute>

    printf(1,"creating /under path\n");
 199:	c7 44 24 04 ad 0b 00 	movl   $0xbad,0x4(%esp)
 1a0:	00 
 1a1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1a8:	e8 a3 05 00 00       	call   750 <printf>
    args[0] = "/mkdir";
    args[1] = "/under";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);
 1ad:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 1b1:	c7 04 24 48 0b 00 00 	movl   $0xb48,(%esp)
    args[0] = "/mkdir";
 1b8:	c7 44 24 10 48 0b 00 	movl   $0xb48,0x10(%esp)
 1bf:	00 
    args[1] = "/under";
 1c0:	c7 44 24 14 c3 0b 00 	movl   $0xbc3,0x14(%esp)
 1c7:	00 
    args[2] = 0;
 1c8:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
 1cf:	00 
    execute(command,args);
 1d0:	e8 5b 01 00 00       	call   330 <execute>

    printf(1,"creating /under/world path\n");
 1d5:	c7 44 24 04 ca 0b 00 	movl   $0xbca,0x4(%esp)
 1dc:	00 
 1dd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1e4:	e8 67 05 00 00       	call   750 <printf>
    args[0] = "/mkdir";
    args[1] = "/under/world";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);
 1e9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 1ed:	c7 04 24 48 0b 00 00 	movl   $0xb48,(%esp)
    args[0] = "/mkdir";
 1f4:	c7 44 24 10 48 0b 00 	movl   $0xb48,0x10(%esp)
 1fb:	00 
    args[1] = "/under/world";
 1fc:	c7 44 24 14 e6 0b 00 	movl   $0xbe6,0x14(%esp)
 203:	00 
    args[2] = 0;
 204:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
 20b:	00 
    execute(command,args);
 20c:	e8 1f 01 00 00       	call   330 <execute>

    printf(1,"creating /under/world/path path\n");
 211:	c7 44 24 04 d4 0c 00 	movl   $0xcd4,0x4(%esp)
 218:	00 
 219:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 220:	e8 2b 05 00 00       	call   750 <printf>
    args[0] = "/mkdir";
    args[1] = "/under/world/path";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);
 225:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 229:	c7 04 24 48 0b 00 00 	movl   $0xb48,(%esp)
    args[0] = "/mkdir";
 230:	c7 44 24 10 48 0b 00 	movl   $0xb48,0x10(%esp)
 237:	00 
    args[1] = "/under/world/path";
 238:	c7 44 24 14 f3 0b 00 	movl   $0xbf3,0x14(%esp)
 23f:	00 
    args[2] = 0;
 240:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
 247:	00 
    execute(command,args);
 248:	e8 e3 00 00 00       	call   330 <execute>

    printf(1,"creating /notIn path\n");
 24d:	c7 44 24 04 05 0c 00 	movl   $0xc05,0x4(%esp)
 254:	00 
 255:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 25c:	e8 ef 04 00 00       	call   750 <printf>
    args[0] = "/mkdir";
    args[1] = "/notIn";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);
 261:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 265:	c7 04 24 48 0b 00 00 	movl   $0xb48,(%esp)
    args[0] = "/mkdir";
 26c:	c7 44 24 10 48 0b 00 	movl   $0xb48,0x10(%esp)
 273:	00 
    args[1] = "/notIn";
 274:	c7 44 24 14 1b 0c 00 	movl   $0xc1b,0x14(%esp)
 27b:	00 
    args[2] = 0;
 27c:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
 283:	00 
    execute(command,args);
 284:	e8 a7 00 00 00       	call   330 <execute>

    printf(1,"creating /notIn/path path\n");
 289:	c7 44 24 04 22 0c 00 	movl   $0xc22,0x4(%esp)
 290:	00 
 291:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 298:	e8 b3 04 00 00       	call   750 <printf>
    args[0] = "/mkdir";
    args[1] = "/notIn/path";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);
 29d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 2a1:	c7 04 24 48 0b 00 00 	movl   $0xb48,(%esp)
    args[0] = "/mkdir";
 2a8:	c7 44 24 10 48 0b 00 	movl   $0xb48,0x10(%esp)
 2af:	00 
    args[1] = "/notIn/path";
 2b0:	c7 44 24 14 3d 0c 00 	movl   $0xc3d,0x14(%esp)
 2b7:	00 
    args[2] = 0;
 2b8:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
 2bf:	00 
    execute(command,args);
 2c0:	e8 6b 00 00 00       	call   330 <execute>

    printf(1,"exiting\n");
 2c5:	c7 44 24 04 49 0c 00 	movl   $0xc49,0x4(%esp)
 2cc:	00 
 2cd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2d4:	e8 77 04 00 00       	call   750 <printf>

    exit(0);
 2d9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2e0:	e8 03 03 00 00       	call   5e8 <exit>
        printf(1,"error in writing to path, %d were written\n",writed);
 2e5:	89 74 24 08          	mov    %esi,0x8(%esp)
 2e9:	c7 44 24 04 84 0c 00 	movl   $0xc84,0x4(%esp)
 2f0:	00 
 2f1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2f8:	e8 53 04 00 00       	call   750 <printf>
 2fd:	e9 87 fd ff ff       	jmp    89 <main+0x89>
        printf(1,"Error in opening path file\n");
 302:	c7 44 24 04 f3 0a 00 	movl   $0xaf3,0x4(%esp)
 309:	00 
 30a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 311:	e8 3a 04 00 00       	call   750 <printf>
        exit(0);
 316:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 31d:	e8 c6 02 00 00       	call   5e8 <exit>
 322:	66 90                	xchg   %ax,%ax
 324:	66 90                	xchg   %ax,%ax
 326:	66 90                	xchg   %ax,%ax
 328:	66 90                	xchg   %ax,%ax
 32a:	66 90                	xchg   %ax,%ax
 32c:	66 90                	xchg   %ax,%ax
 32e:	66 90                	xchg   %ax,%ax

00000330 <execute>:
}

void execute(char * command, char** args){
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	83 ec 18             	sub    $0x18,%esp
 336:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 339:	8b 5d 08             	mov    0x8(%ebp),%ebx
 33c:	89 75 fc             	mov    %esi,-0x4(%ebp)
 33f:	8b 75 0c             	mov    0xc(%ebp),%esi
    int pid;

    if((pid = fork()) == 0){
 342:	e8 99 02 00 00       	call   5e0 <fork>
 347:	83 f8 00             	cmp    $0x0,%eax
 34a:	74 3c                	je     388 <execute+0x58>
        exec(command, args);
        printf(1, "exec %s failed\n", command);
    }
    else if(pid > 0){
 34c:	7e 1a                	jle    368 <execute+0x38>
        //printf(1,"waiting for exec of %s to finish\n",command);
        wait(null);
 34e:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
    }
    else{
        printf(1,"fork failed\n");
    }

}
 355:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 358:	8b 75 fc             	mov    -0x4(%ebp),%esi
 35b:	89 ec                	mov    %ebp,%esp
 35d:	5d                   	pop    %ebp
        wait(null);
 35e:	e9 8d 02 00 00       	jmp    5f0 <wait>
 363:	90                   	nop
 364:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1,"fork failed\n");
 368:	c7 45 0c d8 0a 00 00 	movl   $0xad8,0xc(%ebp)
}
 36f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
        printf(1,"fork failed\n");
 372:	c7 45 08 01 00 00 00 	movl   $0x1,0x8(%ebp)
}
 379:	8b 75 fc             	mov    -0x4(%ebp),%esi
 37c:	89 ec                	mov    %ebp,%esp
 37e:	5d                   	pop    %ebp
        printf(1,"fork failed\n");
 37f:	e9 cc 03 00 00       	jmp    750 <printf>
 384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        exec(command, args);
 388:	89 74 24 04          	mov    %esi,0x4(%esp)
 38c:	89 1c 24             	mov    %ebx,(%esp)
 38f:	e8 8c 02 00 00       	call   620 <exec>
        printf(1, "exec %s failed\n", command);
 394:	b8 c8 0a 00 00       	mov    $0xac8,%eax
 399:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 39d:	89 44 24 04          	mov    %eax,0x4(%esp)
 3a1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 3a8:	e8 a3 03 00 00       	call   750 <printf>
}
 3ad:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 3b0:	8b 75 fc             	mov    -0x4(%ebp),%esi
 3b3:	89 ec                	mov    %ebp,%esp
 3b5:	5d                   	pop    %ebp
 3b6:	c3                   	ret    
 3b7:	66 90                	xchg   %ax,%ax
 3b9:	66 90                	xchg   %ax,%ax
 3bb:	66 90                	xchg   %ax,%ax
 3bd:	66 90                	xchg   %ax,%ax
 3bf:	90                   	nop

000003c0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	8b 45 08             	mov    0x8(%ebp),%eax
 3c6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 3c9:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 3ca:	89 c2                	mov    %eax,%edx
 3cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3d0:	41                   	inc    %ecx
 3d1:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 3d5:	42                   	inc    %edx
 3d6:	84 db                	test   %bl,%bl
 3d8:	88 5a ff             	mov    %bl,-0x1(%edx)
 3db:	75 f3                	jne    3d0 <strcpy+0x10>
    ;
  return os;
}
 3dd:	5b                   	pop    %ebx
 3de:	5d                   	pop    %ebp
 3df:	c3                   	ret    

000003e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3e6:	53                   	push   %ebx
 3e7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 3ea:	0f b6 01             	movzbl (%ecx),%eax
 3ed:	0f b6 13             	movzbl (%ebx),%edx
 3f0:	84 c0                	test   %al,%al
 3f2:	75 18                	jne    40c <strcmp+0x2c>
 3f4:	eb 22                	jmp    418 <strcmp+0x38>
 3f6:	8d 76 00             	lea    0x0(%esi),%esi
 3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 400:	41                   	inc    %ecx
  while(*p && *p == *q)
 401:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 404:	43                   	inc    %ebx
 405:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
 408:	84 c0                	test   %al,%al
 40a:	74 0c                	je     418 <strcmp+0x38>
 40c:	38 d0                	cmp    %dl,%al
 40e:	74 f0                	je     400 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
 410:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 411:	29 d0                	sub    %edx,%eax
}
 413:	5d                   	pop    %ebp
 414:	c3                   	ret    
 415:	8d 76 00             	lea    0x0(%esi),%esi
 418:	5b                   	pop    %ebx
 419:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 41b:	29 d0                	sub    %edx,%eax
}
 41d:	5d                   	pop    %ebp
 41e:	c3                   	ret    
 41f:	90                   	nop

00000420 <strlen>:

uint
strlen(const char *s)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 426:	80 39 00             	cmpb   $0x0,(%ecx)
 429:	74 15                	je     440 <strlen+0x20>
 42b:	31 d2                	xor    %edx,%edx
 42d:	8d 76 00             	lea    0x0(%esi),%esi
 430:	42                   	inc    %edx
 431:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 435:	89 d0                	mov    %edx,%eax
 437:	75 f7                	jne    430 <strlen+0x10>
    ;
  return n;
}
 439:	5d                   	pop    %ebp
 43a:	c3                   	ret    
 43b:	90                   	nop
 43c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
 440:	31 c0                	xor    %eax,%eax
}
 442:	5d                   	pop    %ebp
 443:	c3                   	ret    
 444:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 44a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000450 <memset>:

void*
memset(void *dst, int c, uint n)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	8b 55 08             	mov    0x8(%ebp),%edx
 456:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 457:	8b 4d 10             	mov    0x10(%ebp),%ecx
 45a:	8b 45 0c             	mov    0xc(%ebp),%eax
 45d:	89 d7                	mov    %edx,%edi
 45f:	fc                   	cld    
 460:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 462:	5f                   	pop    %edi
 463:	89 d0                	mov    %edx,%eax
 465:	5d                   	pop    %ebp
 466:	c3                   	ret    
 467:	89 f6                	mov    %esi,%esi
 469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000470 <strchr>:

char*
strchr(const char *s, char c)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	8b 45 08             	mov    0x8(%ebp),%eax
 476:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 47a:	0f b6 10             	movzbl (%eax),%edx
 47d:	84 d2                	test   %dl,%dl
 47f:	74 1b                	je     49c <strchr+0x2c>
    if(*s == c)
 481:	38 d1                	cmp    %dl,%cl
 483:	75 0f                	jne    494 <strchr+0x24>
 485:	eb 17                	jmp    49e <strchr+0x2e>
 487:	89 f6                	mov    %esi,%esi
 489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 490:	38 ca                	cmp    %cl,%dl
 492:	74 0a                	je     49e <strchr+0x2e>
  for(; *s; s++)
 494:	40                   	inc    %eax
 495:	0f b6 10             	movzbl (%eax),%edx
 498:	84 d2                	test   %dl,%dl
 49a:	75 f4                	jne    490 <strchr+0x20>
      return (char*)s;
  return 0;
 49c:	31 c0                	xor    %eax,%eax
}
 49e:	5d                   	pop    %ebp
 49f:	c3                   	ret    

000004a0 <gets>:

char*
gets(char *buf, int max)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	57                   	push   %edi
 4a4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4a5:	31 f6                	xor    %esi,%esi
{
 4a7:	53                   	push   %ebx
 4a8:	83 ec 3c             	sub    $0x3c,%esp
 4ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
 4ae:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 4b1:	eb 32                	jmp    4e5 <gets+0x45>
 4b3:	90                   	nop
 4b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 4b8:	ba 01 00 00 00       	mov    $0x1,%edx
 4bd:	89 54 24 08          	mov    %edx,0x8(%esp)
 4c1:	89 7c 24 04          	mov    %edi,0x4(%esp)
 4c5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4cc:	e8 2f 01 00 00       	call   600 <read>
    if(cc < 1)
 4d1:	85 c0                	test   %eax,%eax
 4d3:	7e 19                	jle    4ee <gets+0x4e>
      break;
    buf[i++] = c;
 4d5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 4d9:	43                   	inc    %ebx
 4da:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
 4dd:	3c 0a                	cmp    $0xa,%al
 4df:	74 1f                	je     500 <gets+0x60>
 4e1:	3c 0d                	cmp    $0xd,%al
 4e3:	74 1b                	je     500 <gets+0x60>
  for(i=0; i+1 < max; ){
 4e5:	46                   	inc    %esi
 4e6:	3b 75 0c             	cmp    0xc(%ebp),%esi
 4e9:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 4ec:	7c ca                	jl     4b8 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 4ee:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4f1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 4f4:	8b 45 08             	mov    0x8(%ebp),%eax
 4f7:	83 c4 3c             	add    $0x3c,%esp
 4fa:	5b                   	pop    %ebx
 4fb:	5e                   	pop    %esi
 4fc:	5f                   	pop    %edi
 4fd:	5d                   	pop    %ebp
 4fe:	c3                   	ret    
 4ff:	90                   	nop
 500:	8b 45 08             	mov    0x8(%ebp),%eax
 503:	01 c6                	add    %eax,%esi
 505:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 508:	eb e4                	jmp    4ee <gets+0x4e>
 50a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000510 <stat>:

int
stat(const char *n, struct stat *st)
{
 510:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 511:	31 c0                	xor    %eax,%eax
{
 513:	89 e5                	mov    %esp,%ebp
 515:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 518:	89 44 24 04          	mov    %eax,0x4(%esp)
 51c:	8b 45 08             	mov    0x8(%ebp),%eax
{
 51f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 522:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 525:	89 04 24             	mov    %eax,(%esp)
 528:	e8 fb 00 00 00       	call   628 <open>
  if(fd < 0)
 52d:	85 c0                	test   %eax,%eax
 52f:	78 2f                	js     560 <stat+0x50>
 531:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 533:	8b 45 0c             	mov    0xc(%ebp),%eax
 536:	89 1c 24             	mov    %ebx,(%esp)
 539:	89 44 24 04          	mov    %eax,0x4(%esp)
 53d:	e8 fe 00 00 00       	call   640 <fstat>
  close(fd);
 542:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 545:	89 c6                	mov    %eax,%esi
  close(fd);
 547:	e8 c4 00 00 00       	call   610 <close>
  return r;
}
 54c:	89 f0                	mov    %esi,%eax
 54e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 551:	8b 75 fc             	mov    -0x4(%ebp),%esi
 554:	89 ec                	mov    %ebp,%esp
 556:	5d                   	pop    %ebp
 557:	c3                   	ret    
 558:	90                   	nop
 559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 560:	be ff ff ff ff       	mov    $0xffffffff,%esi
 565:	eb e5                	jmp    54c <stat+0x3c>
 567:	89 f6                	mov    %esi,%esi
 569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000570 <atoi>:

int
atoi(const char *s)
{
 570:	55                   	push   %ebp
 571:	89 e5                	mov    %esp,%ebp
 573:	8b 4d 08             	mov    0x8(%ebp),%ecx
 576:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 577:	0f be 11             	movsbl (%ecx),%edx
 57a:	88 d0                	mov    %dl,%al
 57c:	2c 30                	sub    $0x30,%al
 57e:	3c 09                	cmp    $0x9,%al
  n = 0;
 580:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 585:	77 1e                	ja     5a5 <atoi+0x35>
 587:	89 f6                	mov    %esi,%esi
 589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 590:	41                   	inc    %ecx
 591:	8d 04 80             	lea    (%eax,%eax,4),%eax
 594:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 598:	0f be 11             	movsbl (%ecx),%edx
 59b:	88 d3                	mov    %dl,%bl
 59d:	80 eb 30             	sub    $0x30,%bl
 5a0:	80 fb 09             	cmp    $0x9,%bl
 5a3:	76 eb                	jbe    590 <atoi+0x20>
  return n;
}
 5a5:	5b                   	pop    %ebx
 5a6:	5d                   	pop    %ebp
 5a7:	c3                   	ret    
 5a8:	90                   	nop
 5a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000005b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	56                   	push   %esi
 5b4:	8b 45 08             	mov    0x8(%ebp),%eax
 5b7:	53                   	push   %ebx
 5b8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 5bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5be:	85 db                	test   %ebx,%ebx
 5c0:	7e 1a                	jle    5dc <memmove+0x2c>
 5c2:	31 d2                	xor    %edx,%edx
 5c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 5d0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 5d4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 5d7:	42                   	inc    %edx
  while(n-- > 0)
 5d8:	39 d3                	cmp    %edx,%ebx
 5da:	75 f4                	jne    5d0 <memmove+0x20>
  return vdst;
}
 5dc:	5b                   	pop    %ebx
 5dd:	5e                   	pop    %esi
 5de:	5d                   	pop    %ebp
 5df:	c3                   	ret    

000005e0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5e0:	b8 01 00 00 00       	mov    $0x1,%eax
 5e5:	cd 40                	int    $0x40
 5e7:	c3                   	ret    

000005e8 <exit>:
SYSCALL(exit)
 5e8:	b8 02 00 00 00       	mov    $0x2,%eax
 5ed:	cd 40                	int    $0x40
 5ef:	c3                   	ret    

000005f0 <wait>:
SYSCALL(wait)
 5f0:	b8 03 00 00 00       	mov    $0x3,%eax
 5f5:	cd 40                	int    $0x40
 5f7:	c3                   	ret    

000005f8 <pipe>:
SYSCALL(pipe)
 5f8:	b8 04 00 00 00       	mov    $0x4,%eax
 5fd:	cd 40                	int    $0x40
 5ff:	c3                   	ret    

00000600 <read>:
SYSCALL(read)
 600:	b8 05 00 00 00       	mov    $0x5,%eax
 605:	cd 40                	int    $0x40
 607:	c3                   	ret    

00000608 <write>:
SYSCALL(write)
 608:	b8 10 00 00 00       	mov    $0x10,%eax
 60d:	cd 40                	int    $0x40
 60f:	c3                   	ret    

00000610 <close>:
SYSCALL(close)
 610:	b8 15 00 00 00       	mov    $0x15,%eax
 615:	cd 40                	int    $0x40
 617:	c3                   	ret    

00000618 <kill>:
SYSCALL(kill)
 618:	b8 06 00 00 00       	mov    $0x6,%eax
 61d:	cd 40                	int    $0x40
 61f:	c3                   	ret    

00000620 <exec>:
SYSCALL(exec)
 620:	b8 07 00 00 00       	mov    $0x7,%eax
 625:	cd 40                	int    $0x40
 627:	c3                   	ret    

00000628 <open>:
SYSCALL(open)
 628:	b8 0f 00 00 00       	mov    $0xf,%eax
 62d:	cd 40                	int    $0x40
 62f:	c3                   	ret    

00000630 <mknod>:
SYSCALL(mknod)
 630:	b8 11 00 00 00       	mov    $0x11,%eax
 635:	cd 40                	int    $0x40
 637:	c3                   	ret    

00000638 <unlink>:
SYSCALL(unlink)
 638:	b8 12 00 00 00       	mov    $0x12,%eax
 63d:	cd 40                	int    $0x40
 63f:	c3                   	ret    

00000640 <fstat>:
SYSCALL(fstat)
 640:	b8 08 00 00 00       	mov    $0x8,%eax
 645:	cd 40                	int    $0x40
 647:	c3                   	ret    

00000648 <link>:
SYSCALL(link)
 648:	b8 13 00 00 00       	mov    $0x13,%eax
 64d:	cd 40                	int    $0x40
 64f:	c3                   	ret    

00000650 <mkdir>:
SYSCALL(mkdir)
 650:	b8 14 00 00 00       	mov    $0x14,%eax
 655:	cd 40                	int    $0x40
 657:	c3                   	ret    

00000658 <chdir>:
SYSCALL(chdir)
 658:	b8 09 00 00 00       	mov    $0x9,%eax
 65d:	cd 40                	int    $0x40
 65f:	c3                   	ret    

00000660 <dup>:
SYSCALL(dup)
 660:	b8 0a 00 00 00       	mov    $0xa,%eax
 665:	cd 40                	int    $0x40
 667:	c3                   	ret    

00000668 <getpid>:
SYSCALL(getpid)
 668:	b8 0b 00 00 00       	mov    $0xb,%eax
 66d:	cd 40                	int    $0x40
 66f:	c3                   	ret    

00000670 <sbrk>:
SYSCALL(sbrk)
 670:	b8 0c 00 00 00       	mov    $0xc,%eax
 675:	cd 40                	int    $0x40
 677:	c3                   	ret    

00000678 <sleep>:
SYSCALL(sleep)
 678:	b8 0d 00 00 00       	mov    $0xd,%eax
 67d:	cd 40                	int    $0x40
 67f:	c3                   	ret    

00000680 <uptime>:
SYSCALL(uptime)
 680:	b8 0e 00 00 00       	mov    $0xe,%eax
 685:	cd 40                	int    $0x40
 687:	c3                   	ret    

00000688 <policy>:
SYSCALL(policy)
 688:	b8 17 00 00 00       	mov    $0x17,%eax
 68d:	cd 40                	int    $0x40
 68f:	c3                   	ret    

00000690 <detach>:
SYSCALL(detach)
 690:	b8 16 00 00 00       	mov    $0x16,%eax
 695:	cd 40                	int    $0x40
 697:	c3                   	ret    

00000698 <priority>:
SYSCALL(priority)
 698:	b8 18 00 00 00       	mov    $0x18,%eax
 69d:	cd 40                	int    $0x40
 69f:	c3                   	ret    

000006a0 <wait_stat>:
SYSCALL(wait_stat)
 6a0:	b8 19 00 00 00       	mov    $0x19,%eax
 6a5:	cd 40                	int    $0x40
 6a7:	c3                   	ret    
 6a8:	66 90                	xchg   %ax,%ax
 6aa:	66 90                	xchg   %ax,%ax
 6ac:	66 90                	xchg   %ax,%ax
 6ae:	66 90                	xchg   %ax,%ax

000006b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	57                   	push   %edi
 6b4:	56                   	push   %esi
 6b5:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6b6:	89 d3                	mov    %edx,%ebx
 6b8:	c1 eb 1f             	shr    $0x1f,%ebx
{
 6bb:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 6be:	84 db                	test   %bl,%bl
{
 6c0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 6c3:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 6c5:	74 79                	je     740 <printint+0x90>
 6c7:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 6cb:	74 73                	je     740 <printint+0x90>
    neg = 1;
    x = -xx;
 6cd:	f7 d8                	neg    %eax
    neg = 1;
 6cf:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 6d6:	31 f6                	xor    %esi,%esi
 6d8:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 6db:	eb 05                	jmp    6e2 <printint+0x32>
 6dd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 6e0:	89 fe                	mov    %edi,%esi
 6e2:	31 d2                	xor    %edx,%edx
 6e4:	f7 f1                	div    %ecx
 6e6:	8d 7e 01             	lea    0x1(%esi),%edi
 6e9:	0f b6 92 00 0d 00 00 	movzbl 0xd00(%edx),%edx
  }while((x /= base) != 0);
 6f0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 6f2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 6f5:	75 e9                	jne    6e0 <printint+0x30>
  if(neg)
 6f7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 6fa:	85 d2                	test   %edx,%edx
 6fc:	74 08                	je     706 <printint+0x56>
    buf[i++] = '-';
 6fe:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 703:	8d 7e 02             	lea    0x2(%esi),%edi
 706:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 70a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 70d:	8d 76 00             	lea    0x0(%esi),%esi
 710:	0f b6 06             	movzbl (%esi),%eax
 713:	4e                   	dec    %esi
  write(fd, &c, 1);
 714:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 718:	89 3c 24             	mov    %edi,(%esp)
 71b:	88 45 d7             	mov    %al,-0x29(%ebp)
 71e:	b8 01 00 00 00       	mov    $0x1,%eax
 723:	89 44 24 08          	mov    %eax,0x8(%esp)
 727:	e8 dc fe ff ff       	call   608 <write>

  while(--i >= 0)
 72c:	39 de                	cmp    %ebx,%esi
 72e:	75 e0                	jne    710 <printint+0x60>
    putc(fd, buf[i]);
}
 730:	83 c4 4c             	add    $0x4c,%esp
 733:	5b                   	pop    %ebx
 734:	5e                   	pop    %esi
 735:	5f                   	pop    %edi
 736:	5d                   	pop    %ebp
 737:	c3                   	ret    
 738:	90                   	nop
 739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 740:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 747:	eb 8d                	jmp    6d6 <printint+0x26>
 749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000750 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	57                   	push   %edi
 754:	56                   	push   %esi
 755:	53                   	push   %ebx
 756:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 759:	8b 75 0c             	mov    0xc(%ebp),%esi
 75c:	0f b6 1e             	movzbl (%esi),%ebx
 75f:	84 db                	test   %bl,%bl
 761:	0f 84 d1 00 00 00    	je     838 <printf+0xe8>
  state = 0;
 767:	31 ff                	xor    %edi,%edi
 769:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 76a:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 76d:	89 fa                	mov    %edi,%edx
 76f:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 772:	89 45 d0             	mov    %eax,-0x30(%ebp)
 775:	eb 41                	jmp    7b8 <printf+0x68>
 777:	89 f6                	mov    %esi,%esi
 779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 780:	83 f8 25             	cmp    $0x25,%eax
 783:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 786:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 78b:	74 1e                	je     7ab <printf+0x5b>
  write(fd, &c, 1);
 78d:	b8 01 00 00 00       	mov    $0x1,%eax
 792:	89 44 24 08          	mov    %eax,0x8(%esp)
 796:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 799:	89 44 24 04          	mov    %eax,0x4(%esp)
 79d:	89 3c 24             	mov    %edi,(%esp)
 7a0:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 7a3:	e8 60 fe ff ff       	call   608 <write>
 7a8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 7ab:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 7ac:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 7b0:	84 db                	test   %bl,%bl
 7b2:	0f 84 80 00 00 00    	je     838 <printf+0xe8>
    if(state == 0){
 7b8:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 7ba:	0f be cb             	movsbl %bl,%ecx
 7bd:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 7c0:	74 be                	je     780 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 7c2:	83 fa 25             	cmp    $0x25,%edx
 7c5:	75 e4                	jne    7ab <printf+0x5b>
      if(c == 'd'){
 7c7:	83 f8 64             	cmp    $0x64,%eax
 7ca:	0f 84 f0 00 00 00    	je     8c0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 7d0:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 7d6:	83 f9 70             	cmp    $0x70,%ecx
 7d9:	74 65                	je     840 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 7db:	83 f8 73             	cmp    $0x73,%eax
 7de:	0f 84 8c 00 00 00    	je     870 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7e4:	83 f8 63             	cmp    $0x63,%eax
 7e7:	0f 84 13 01 00 00    	je     900 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 7ed:	83 f8 25             	cmp    $0x25,%eax
 7f0:	0f 84 e2 00 00 00    	je     8d8 <printf+0x188>
  write(fd, &c, 1);
 7f6:	b8 01 00 00 00       	mov    $0x1,%eax
 7fb:	46                   	inc    %esi
 7fc:	89 44 24 08          	mov    %eax,0x8(%esp)
 800:	8d 45 e7             	lea    -0x19(%ebp),%eax
 803:	89 44 24 04          	mov    %eax,0x4(%esp)
 807:	89 3c 24             	mov    %edi,(%esp)
 80a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 80e:	e8 f5 fd ff ff       	call   608 <write>
 813:	ba 01 00 00 00       	mov    $0x1,%edx
 818:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 81b:	89 54 24 08          	mov    %edx,0x8(%esp)
 81f:	89 44 24 04          	mov    %eax,0x4(%esp)
 823:	89 3c 24             	mov    %edi,(%esp)
 826:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 829:	e8 da fd ff ff       	call   608 <write>
  for(i = 0; fmt[i]; i++){
 82e:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 832:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 834:	84 db                	test   %bl,%bl
 836:	75 80                	jne    7b8 <printf+0x68>
    }
  }
}
 838:	83 c4 3c             	add    $0x3c,%esp
 83b:	5b                   	pop    %ebx
 83c:	5e                   	pop    %esi
 83d:	5f                   	pop    %edi
 83e:	5d                   	pop    %ebp
 83f:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 840:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 847:	b9 10 00 00 00       	mov    $0x10,%ecx
 84c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 84f:	89 f8                	mov    %edi,%eax
 851:	8b 13                	mov    (%ebx),%edx
 853:	e8 58 fe ff ff       	call   6b0 <printint>
        ap++;
 858:	89 d8                	mov    %ebx,%eax
      state = 0;
 85a:	31 d2                	xor    %edx,%edx
        ap++;
 85c:	83 c0 04             	add    $0x4,%eax
 85f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 862:	e9 44 ff ff ff       	jmp    7ab <printf+0x5b>
 867:	89 f6                	mov    %esi,%esi
 869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 870:	8b 45 d0             	mov    -0x30(%ebp),%eax
 873:	8b 10                	mov    (%eax),%edx
        ap++;
 875:	83 c0 04             	add    $0x4,%eax
 878:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 87b:	85 d2                	test   %edx,%edx
 87d:	0f 84 aa 00 00 00    	je     92d <printf+0x1dd>
        while(*s != 0){
 883:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 886:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 888:	84 c0                	test   %al,%al
 88a:	74 27                	je     8b3 <printf+0x163>
 88c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 890:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 893:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 898:	43                   	inc    %ebx
  write(fd, &c, 1);
 899:	89 44 24 08          	mov    %eax,0x8(%esp)
 89d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 8a0:	89 44 24 04          	mov    %eax,0x4(%esp)
 8a4:	89 3c 24             	mov    %edi,(%esp)
 8a7:	e8 5c fd ff ff       	call   608 <write>
        while(*s != 0){
 8ac:	0f b6 03             	movzbl (%ebx),%eax
 8af:	84 c0                	test   %al,%al
 8b1:	75 dd                	jne    890 <printf+0x140>
      state = 0;
 8b3:	31 d2                	xor    %edx,%edx
 8b5:	e9 f1 fe ff ff       	jmp    7ab <printf+0x5b>
 8ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 8c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 8c7:	b9 0a 00 00 00       	mov    $0xa,%ecx
 8cc:	e9 7b ff ff ff       	jmp    84c <printf+0xfc>
 8d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 8d8:	b9 01 00 00 00       	mov    $0x1,%ecx
 8dd:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 8e0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 8e4:	89 44 24 04          	mov    %eax,0x4(%esp)
 8e8:	89 3c 24             	mov    %edi,(%esp)
 8eb:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 8ee:	e8 15 fd ff ff       	call   608 <write>
      state = 0;
 8f3:	31 d2                	xor    %edx,%edx
 8f5:	e9 b1 fe ff ff       	jmp    7ab <printf+0x5b>
 8fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 900:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 903:	8b 03                	mov    (%ebx),%eax
        ap++;
 905:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 908:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 90b:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 90e:	b8 01 00 00 00       	mov    $0x1,%eax
 913:	89 44 24 08          	mov    %eax,0x8(%esp)
 917:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 91a:	89 44 24 04          	mov    %eax,0x4(%esp)
 91e:	e8 e5 fc ff ff       	call   608 <write>
      state = 0;
 923:	31 d2                	xor    %edx,%edx
        ap++;
 925:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 928:	e9 7e fe ff ff       	jmp    7ab <printf+0x5b>
          s = "(null)";
 92d:	bb f8 0c 00 00       	mov    $0xcf8,%ebx
        while(*s != 0){
 932:	b0 28                	mov    $0x28,%al
 934:	e9 57 ff ff ff       	jmp    890 <printf+0x140>
 939:	66 90                	xchg   %ax,%ax
 93b:	66 90                	xchg   %ax,%ax
 93d:	66 90                	xchg   %ax,%ax
 93f:	90                   	nop

00000940 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 940:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 941:	a1 d0 0f 00 00       	mov    0xfd0,%eax
{
 946:	89 e5                	mov    %esp,%ebp
 948:	57                   	push   %edi
 949:	56                   	push   %esi
 94a:	53                   	push   %ebx
 94b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 94e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 951:	eb 0d                	jmp    960 <free+0x20>
 953:	90                   	nop
 954:	90                   	nop
 955:	90                   	nop
 956:	90                   	nop
 957:	90                   	nop
 958:	90                   	nop
 959:	90                   	nop
 95a:	90                   	nop
 95b:	90                   	nop
 95c:	90                   	nop
 95d:	90                   	nop
 95e:	90                   	nop
 95f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 960:	39 c8                	cmp    %ecx,%eax
 962:	8b 10                	mov    (%eax),%edx
 964:	73 32                	jae    998 <free+0x58>
 966:	39 d1                	cmp    %edx,%ecx
 968:	72 04                	jb     96e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 96a:	39 d0                	cmp    %edx,%eax
 96c:	72 32                	jb     9a0 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 96e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 971:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 974:	39 fa                	cmp    %edi,%edx
 976:	74 30                	je     9a8 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 978:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 97b:	8b 50 04             	mov    0x4(%eax),%edx
 97e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 981:	39 f1                	cmp    %esi,%ecx
 983:	74 3c                	je     9c1 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 985:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 987:	5b                   	pop    %ebx
  freep = p;
 988:	a3 d0 0f 00 00       	mov    %eax,0xfd0
}
 98d:	5e                   	pop    %esi
 98e:	5f                   	pop    %edi
 98f:	5d                   	pop    %ebp
 990:	c3                   	ret    
 991:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 998:	39 d0                	cmp    %edx,%eax
 99a:	72 04                	jb     9a0 <free+0x60>
 99c:	39 d1                	cmp    %edx,%ecx
 99e:	72 ce                	jb     96e <free+0x2e>
{
 9a0:	89 d0                	mov    %edx,%eax
 9a2:	eb bc                	jmp    960 <free+0x20>
 9a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 9a8:	8b 7a 04             	mov    0x4(%edx),%edi
 9ab:	01 fe                	add    %edi,%esi
 9ad:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 9b0:	8b 10                	mov    (%eax),%edx
 9b2:	8b 12                	mov    (%edx),%edx
 9b4:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 9b7:	8b 50 04             	mov    0x4(%eax),%edx
 9ba:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 9bd:	39 f1                	cmp    %esi,%ecx
 9bf:	75 c4                	jne    985 <free+0x45>
    p->s.size += bp->s.size;
 9c1:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 9c4:	a3 d0 0f 00 00       	mov    %eax,0xfd0
    p->s.size += bp->s.size;
 9c9:	01 ca                	add    %ecx,%edx
 9cb:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 9ce:	8b 53 f8             	mov    -0x8(%ebx),%edx
 9d1:	89 10                	mov    %edx,(%eax)
}
 9d3:	5b                   	pop    %ebx
 9d4:	5e                   	pop    %esi
 9d5:	5f                   	pop    %edi
 9d6:	5d                   	pop    %ebp
 9d7:	c3                   	ret    
 9d8:	90                   	nop
 9d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000009e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9e0:	55                   	push   %ebp
 9e1:	89 e5                	mov    %esp,%ebp
 9e3:	57                   	push   %edi
 9e4:	56                   	push   %esi
 9e5:	53                   	push   %ebx
 9e6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 9ec:	8b 15 d0 0f 00 00    	mov    0xfd0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9f2:	8d 78 07             	lea    0x7(%eax),%edi
 9f5:	c1 ef 03             	shr    $0x3,%edi
 9f8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 9f9:	85 d2                	test   %edx,%edx
 9fb:	0f 84 8f 00 00 00    	je     a90 <malloc+0xb0>
 a01:	8b 02                	mov    (%edx),%eax
 a03:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 a06:	39 cf                	cmp    %ecx,%edi
 a08:	76 66                	jbe    a70 <malloc+0x90>
 a0a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 a10:	bb 00 10 00 00       	mov    $0x1000,%ebx
 a15:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 a18:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 a1f:	eb 10                	jmp    a31 <malloc+0x51>
 a21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a28:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a2a:	8b 48 04             	mov    0x4(%eax),%ecx
 a2d:	39 f9                	cmp    %edi,%ecx
 a2f:	73 3f                	jae    a70 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a31:	39 05 d0 0f 00 00    	cmp    %eax,0xfd0
 a37:	89 c2                	mov    %eax,%edx
 a39:	75 ed                	jne    a28 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 a3b:	89 34 24             	mov    %esi,(%esp)
 a3e:	e8 2d fc ff ff       	call   670 <sbrk>
  if(p == (char*)-1)
 a43:	83 f8 ff             	cmp    $0xffffffff,%eax
 a46:	74 18                	je     a60 <malloc+0x80>
  hp->s.size = nu;
 a48:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 a4b:	83 c0 08             	add    $0x8,%eax
 a4e:	89 04 24             	mov    %eax,(%esp)
 a51:	e8 ea fe ff ff       	call   940 <free>
  return freep;
 a56:	8b 15 d0 0f 00 00    	mov    0xfd0,%edx
      if((p = morecore(nunits)) == 0)
 a5c:	85 d2                	test   %edx,%edx
 a5e:	75 c8                	jne    a28 <malloc+0x48>
        return 0;
  }
}
 a60:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 a63:	31 c0                	xor    %eax,%eax
}
 a65:	5b                   	pop    %ebx
 a66:	5e                   	pop    %esi
 a67:	5f                   	pop    %edi
 a68:	5d                   	pop    %ebp
 a69:	c3                   	ret    
 a6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 a70:	39 cf                	cmp    %ecx,%edi
 a72:	74 4c                	je     ac0 <malloc+0xe0>
        p->s.size -= nunits;
 a74:	29 f9                	sub    %edi,%ecx
 a76:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 a79:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 a7c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 a7f:	89 15 d0 0f 00 00    	mov    %edx,0xfd0
}
 a85:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 a88:	83 c0 08             	add    $0x8,%eax
}
 a8b:	5b                   	pop    %ebx
 a8c:	5e                   	pop    %esi
 a8d:	5f                   	pop    %edi
 a8e:	5d                   	pop    %ebp
 a8f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 a90:	b8 d4 0f 00 00       	mov    $0xfd4,%eax
 a95:	ba d4 0f 00 00       	mov    $0xfd4,%edx
    base.s.size = 0;
 a9a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 a9c:	a3 d0 0f 00 00       	mov    %eax,0xfd0
    base.s.size = 0;
 aa1:	b8 d4 0f 00 00       	mov    $0xfd4,%eax
    base.s.ptr = freep = prevp = &base;
 aa6:	89 15 d4 0f 00 00    	mov    %edx,0xfd4
    base.s.size = 0;
 aac:	89 0d d8 0f 00 00    	mov    %ecx,0xfd8
 ab2:	e9 53 ff ff ff       	jmp    a0a <malloc+0x2a>
 ab7:	89 f6                	mov    %esi,%esi
 ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 ac0:	8b 08                	mov    (%eax),%ecx
 ac2:	89 0a                	mov    %ecx,(%edx)
 ac4:	eb b9                	jmp    a7f <malloc+0x9f>
