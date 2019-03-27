
_sanity:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    exit(0);

}*/


int main(int argc, char *argv[]){
       0:	55                   	push   %ebp
    int fd;
    int writed;

    printf(1,"opening path\n");
       1:	b8 1a 15 00 00       	mov    $0x151a,%eax
int main(int argc, char *argv[]){
       6:	89 e5                	mov    %esp,%ebp
       8:	56                   	push   %esi
       9:	53                   	push   %ebx
       a:	83 e4 f0             	and    $0xfffffff0,%esp
       d:	83 ec 20             	sub    $0x20,%esp
    printf(1,"opening path\n");
      10:	89 44 24 04          	mov    %eax,0x4(%esp)
      14:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      1b:	e8 c0 10 00 00       	call   10e0 <printf>
    fd = open("/path",O_WRONLY);
      20:	ba 01 00 00 00       	mov    $0x1,%edx
      25:	89 54 24 04          	mov    %edx,0x4(%esp)
      29:	c7 04 24 dc 15 00 00 	movl   $0x15dc,(%esp)
      30:	e8 83 0f 00 00       	call   fb8 <open>

    if(fd < 0){
      35:	85 c0                	test   %eax,%eax
      37:	0f 88 d9 03 00 00    	js     416 <main+0x416>
        exit(0);
    }

    const char * path = "/:/bin/:/hello/world/path/:/under/world/path";

    printf(1,"writing to path\n");
      3d:	c7 44 24 04 44 15 00 	movl   $0x1544,0x4(%esp)
      44:	00 
      45:	89 c3                	mov    %eax,%ebx
      47:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      4e:	e8 8d 10 00 00       	call   10e0 <printf>
    writed = write(fd,path,strlen(path));
      53:	c7 04 24 c4 17 00 00 	movl   $0x17c4,(%esp)
      5a:	e8 51 0d 00 00       	call   db0 <strlen>
      5f:	c7 44 24 04 c4 17 00 	movl   $0x17c4,0x4(%esp)
      66:	00 
      67:	89 1c 24             	mov    %ebx,(%esp)
      6a:	89 44 24 08          	mov    %eax,0x8(%esp)
      6e:	e8 25 0f 00 00       	call   f98 <write>

    if(writed != strlen(path)){
      73:	c7 04 24 c4 17 00 00 	movl   $0x17c4,(%esp)
    writed = write(fd,path,strlen(path));
      7a:	89 c6                	mov    %eax,%esi
    if(writed != strlen(path)){
      7c:	e8 2f 0d 00 00       	call   db0 <strlen>
      81:	39 f0                	cmp    %esi,%eax
      83:	0f 85 70 03 00 00    	jne    3f9 <main+0x3f9>
        printf(1,"error in writing to path, %d were written\n",writed);
    }

    printf(1,"closing path file\n");
      89:	c7 44 24 04 55 15 00 	movl   $0x1555,0x4(%esp)
      90:	00 
      91:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      98:	e8 43 10 00 00       	call   10e0 <printf>
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
      a4:	e8 f7 0e 00 00       	call   fa0 <close>
    printf(1,"creating /bin/ path\n");
      a9:	c7 44 24 04 68 15 00 	movl   $0x1568,0x4(%esp)
      b0:	00 
      b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      b8:	e8 23 10 00 00       	call   10e0 <printf>
    execute(command,args);
      bd:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      c1:	c7 04 24 7d 15 00 00 	movl   $0x157d,(%esp)
    args[0] = "/mkdir";
      c8:	c7 44 24 10 7d 15 00 	movl   $0x157d,0x10(%esp)
      cf:	00 
    args[1] = "/bin/";
      d0:	c7 44 24 14 84 15 00 	movl   $0x1584,0x14(%esp)
      d7:	00 
    args[2] = 0;
      d8:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
      df:	00 
    execute(command,args);
      e0:	e8 5b 03 00 00       	call   440 <execute>

    printf(1,"creating /hello path\n");
      e5:	c7 44 24 04 8a 15 00 	movl   $0x158a,0x4(%esp)
      ec:	00 
      ed:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      f4:	e8 e7 0f 00 00       	call   10e0 <printf>
    args[0] = "/mkdir";
    args[1] = "/hello";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);
      f9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      fd:	c7 04 24 7d 15 00 00 	movl   $0x157d,(%esp)
    args[0] = "/mkdir";
     104:	c7 44 24 10 7d 15 00 	movl   $0x157d,0x10(%esp)
     10b:	00 
    args[1] = "/hello";
     10c:	c7 44 24 14 a0 15 00 	movl   $0x15a0,0x14(%esp)
     113:	00 
    args[2] = 0;
     114:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
     11b:	00 
    execute(command,args);
     11c:	e8 1f 03 00 00       	call   440 <execute>

    printf(1,"creating /hello/world path\n");
     121:	c7 44 24 04 a7 15 00 	movl   $0x15a7,0x4(%esp)
     128:	00 
     129:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     130:	e8 ab 0f 00 00       	call   10e0 <printf>
    args[0] = "/mkdir";
    args[1] = "/hello/world";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);
     135:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     139:	c7 04 24 7d 15 00 00 	movl   $0x157d,(%esp)
    args[0] = "/mkdir";
     140:	c7 44 24 10 7d 15 00 	movl   $0x157d,0x10(%esp)
     147:	00 
    args[1] = "/hello/world";
     148:	c7 44 24 14 c3 15 00 	movl   $0x15c3,0x14(%esp)
     14f:	00 
    args[2] = 0;
     150:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
     157:	00 
    execute(command,args);
     158:	e8 e3 02 00 00       	call   440 <execute>

    printf(1,"creating /hello/world/path path\n");
     15d:	c7 44 24 04 20 18 00 	movl   $0x1820,0x4(%esp)
     164:	00 
     165:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     16c:	e8 6f 0f 00 00       	call   10e0 <printf>
    args[0] = "/mkdir";
    args[1] = "/hello/world/path";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);
     171:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     175:	c7 04 24 7d 15 00 00 	movl   $0x157d,(%esp)
    args[0] = "/mkdir";
     17c:	c7 44 24 10 7d 15 00 	movl   $0x157d,0x10(%esp)
     183:	00 
    args[1] = "/hello/world/path";
     184:	c7 44 24 14 d0 15 00 	movl   $0x15d0,0x14(%esp)
     18b:	00 
    args[2] = 0;
     18c:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
     193:	00 
    execute(command,args);
     194:	e8 a7 02 00 00       	call   440 <execute>

    printf(1,"creating /under path\n");
     199:	c7 44 24 04 e2 15 00 	movl   $0x15e2,0x4(%esp)
     1a0:	00 
     1a1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     1a8:	e8 33 0f 00 00       	call   10e0 <printf>
    args[0] = "/mkdir";
    args[1] = "/under";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);
     1ad:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     1b1:	c7 04 24 7d 15 00 00 	movl   $0x157d,(%esp)
    args[0] = "/mkdir";
     1b8:	c7 44 24 10 7d 15 00 	movl   $0x157d,0x10(%esp)
     1bf:	00 
    args[1] = "/under";
     1c0:	c7 44 24 14 f8 15 00 	movl   $0x15f8,0x14(%esp)
     1c7:	00 
    args[2] = 0;
     1c8:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
     1cf:	00 
    execute(command,args);
     1d0:	e8 6b 02 00 00       	call   440 <execute>

    printf(1,"creating /under/world path\n");
     1d5:	c7 44 24 04 ff 15 00 	movl   $0x15ff,0x4(%esp)
     1dc:	00 
     1dd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     1e4:	e8 f7 0e 00 00       	call   10e0 <printf>
    args[0] = "/mkdir";
    args[1] = "/under/world";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);
     1e9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     1ed:	c7 04 24 7d 15 00 00 	movl   $0x157d,(%esp)
    args[0] = "/mkdir";
     1f4:	c7 44 24 10 7d 15 00 	movl   $0x157d,0x10(%esp)
     1fb:	00 
    args[1] = "/under/world";
     1fc:	c7 44 24 14 1b 16 00 	movl   $0x161b,0x14(%esp)
     203:	00 
    args[2] = 0;
     204:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
     20b:	00 
    execute(command,args);
     20c:	e8 2f 02 00 00       	call   440 <execute>

    printf(1,"creating /under/world/path path\n");
     211:	c7 44 24 04 44 18 00 	movl   $0x1844,0x4(%esp)
     218:	00 
     219:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     220:	e8 bb 0e 00 00       	call   10e0 <printf>
    args[0] = "/mkdir";
    args[1] = "/under/world/path";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);
     225:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     229:	c7 04 24 7d 15 00 00 	movl   $0x157d,(%esp)
    args[0] = "/mkdir";
     230:	c7 44 24 10 7d 15 00 	movl   $0x157d,0x10(%esp)
     237:	00 
    args[1] = "/under/world/path";
     238:	c7 44 24 14 28 16 00 	movl   $0x1628,0x14(%esp)
     23f:	00 
    args[2] = 0;
     240:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
     247:	00 
    execute(command,args);
     248:	e8 f3 01 00 00       	call   440 <execute>

    printf(1,"creating /notIn path\n");
     24d:	c7 44 24 04 3a 16 00 	movl   $0x163a,0x4(%esp)
     254:	00 
     255:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     25c:	e8 7f 0e 00 00       	call   10e0 <printf>
    args[0] = "/mkdir";
    args[1] = "/notIn";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);
     261:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     265:	c7 04 24 7d 15 00 00 	movl   $0x157d,(%esp)
    args[0] = "/mkdir";
     26c:	c7 44 24 10 7d 15 00 	movl   $0x157d,0x10(%esp)
     273:	00 
    args[1] = "/notIn";
     274:	c7 44 24 14 50 16 00 	movl   $0x1650,0x14(%esp)
     27b:	00 
    args[2] = 0;
     27c:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
     283:	00 
    execute(command,args);
     284:	e8 b7 01 00 00       	call   440 <execute>

    printf(1,"creating /notIn/path path\n");
     289:	c7 44 24 04 57 16 00 	movl   $0x1657,0x4(%esp)
     290:	00 
     291:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     298:	e8 43 0e 00 00       	call   10e0 <printf>
    args[0] = "/mkdir";
    args[1] = "/notIn/path";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);
     29d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     2a1:	c7 04 24 7d 15 00 00 	movl   $0x157d,(%esp)
    args[0] = "/mkdir";
     2a8:	c7 44 24 10 7d 15 00 	movl   $0x157d,0x10(%esp)
     2af:	00 
    args[1] = "/notIn/path";
     2b0:	c7 44 24 14 72 16 00 	movl   $0x1672,0x14(%esp)
     2b7:	00 
    args[2] = 0;
     2b8:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
     2bf:	00 
    execute(command,args);
     2c0:	e8 7b 01 00 00       	call   440 <execute>

    printf(1,"##################exiting\n");
     2c5:	c7 44 24 04 7e 16 00 	movl   $0x167e,0x4(%esp)
     2cc:	00 
     2cd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     2d4:	e8 07 0e 00 00       	call   10e0 <printf>


    printf(1,"copying cat to /notIn/path/cat\n");
     2d9:	c7 44 24 04 68 18 00 	movl   $0x1868,0x4(%esp)
     2e0:	00 
     2e1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     2e8:	e8 f3 0d 00 00       	call   10e0 <printf>
    args[0] = "/ln";
    args[1] = "/cat";
    args[2] = "/notIn/path/cat";
    args[3] = 0;
    command = "/ln";
    execute(command,args);
     2ed:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     2f1:	c7 04 24 99 16 00 00 	movl   $0x1699,(%esp)
    args[0] = "/ln";
     2f8:	c7 44 24 10 99 16 00 	movl   $0x1699,0x10(%esp)
     2ff:	00 
    args[1] = "/cat";
     300:	c7 44 24 14 a8 16 00 	movl   $0x16a8,0x14(%esp)
     307:	00 
    args[2] = "/notIn/path/cat";
     308:	c7 44 24 18 9d 16 00 	movl   $0x169d,0x18(%esp)
     30f:	00 
    args[3] = 0;
     310:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
     317:	00 
    execute(command,args);
     318:	e8 23 01 00 00       	call   440 <execute>

    printf(1,"copying echo to /notIn/path/echo\n");
     31d:	c7 44 24 04 88 18 00 	movl   $0x1888,0x4(%esp)
     324:	00 
     325:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     32c:	e8 af 0d 00 00       	call   10e0 <printf>
    args[0] = "/ln";
    args[1] = "/echo";
    args[2] = "/notIn/path/echo";
    args[3] = 0;
    command = "/ln";
    execute(command,args);
     331:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     335:	c7 04 24 99 16 00 00 	movl   $0x1699,(%esp)
    args[0] = "/ln";
     33c:	c7 44 24 10 99 16 00 	movl   $0x1699,0x10(%esp)
     343:	00 
    args[1] = "/echo";
     344:	c7 44 24 14 b8 16 00 	movl   $0x16b8,0x14(%esp)
     34b:	00 
    args[2] = "/notIn/path/echo";
     34c:	c7 44 24 18 ad 16 00 	movl   $0x16ad,0x18(%esp)
     353:	00 
    args[3] = 0;
     354:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
     35b:	00 
    execute(command,args);
     35c:	e8 df 00 00 00       	call   440 <execute>

    printf(1,"removing /cat\n");
     361:	c7 44 24 04 be 16 00 	movl   $0x16be,0x4(%esp)
     368:	00 
     369:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     370:	e8 6b 0d 00 00       	call   10e0 <printf>
    args[0] = "/rm";
    args[1] = "/cat";
    args[2] = 0;
    command = "/rm";
    execute(command,args);
     375:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     379:	c7 04 24 cd 16 00 00 	movl   $0x16cd,(%esp)
    args[0] = "/rm";
     380:	c7 44 24 10 cd 16 00 	movl   $0x16cd,0x10(%esp)
     387:	00 
    args[1] = "/cat";
     388:	c7 44 24 14 a8 16 00 	movl   $0x16a8,0x14(%esp)
     38f:	00 
    args[2] = 0;
     390:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
     397:	00 
    execute(command,args);
     398:	e8 a3 00 00 00       	call   440 <execute>

    printf(1,"removing /echo\n");
     39d:	c7 44 24 04 d1 16 00 	movl   $0x16d1,0x4(%esp)
     3a4:	00 
     3a5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     3ac:	e8 2f 0d 00 00       	call   10e0 <printf>
    args[0] = "/rm";
    args[1] = "/echo";
    args[2] = 0;
    command = "/rm";
    execute(command,args);
     3b1:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     3b5:	c7 04 24 cd 16 00 00 	movl   $0x16cd,(%esp)
    args[0] = "/rm";
     3bc:	c7 44 24 10 cd 16 00 	movl   $0x16cd,0x10(%esp)
     3c3:	00 
    args[1] = "/echo";
     3c4:	c7 44 24 14 b8 16 00 	movl   $0x16b8,0x14(%esp)
     3cb:	00 
    args[2] = 0;
     3cc:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
     3d3:	00 
    execute(command,args);
     3d4:	e8 67 00 00 00       	call   440 <execute>

    printf(1,"###########################3exiting\n");
     3d9:	c7 44 24 04 ac 18 00 	movl   $0x18ac,0x4(%esp)
     3e0:	00 
     3e1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     3e8:	e8 f3 0c 00 00       	call   10e0 <printf>



    exit(0);
     3ed:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     3f4:	e8 7f 0b 00 00       	call   f78 <exit>
        printf(1,"error in writing to path, %d were written\n",writed);
     3f9:	89 74 24 08          	mov    %esi,0x8(%esp)
     3fd:	c7 44 24 04 f4 17 00 	movl   $0x17f4,0x4(%esp)
     404:	00 
     405:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     40c:	e8 cf 0c 00 00       	call   10e0 <printf>
     411:	e9 73 fc ff ff       	jmp    89 <main+0x89>
        printf(1,"Error in opening path file\n");
     416:	c7 44 24 04 28 15 00 	movl   $0x1528,0x4(%esp)
     41d:	00 
     41e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     425:	e8 b6 0c 00 00       	call   10e0 <printf>
        exit(0);
     42a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     431:	e8 42 0b 00 00       	call   f78 <exit>
     436:	66 90                	xchg   %ax,%ax
     438:	66 90                	xchg   %ax,%ax
     43a:	66 90                	xchg   %ax,%ax
     43c:	66 90                	xchg   %ax,%ax
     43e:	66 90                	xchg   %ax,%ax

00000440 <execute>:
void execute(char * command, char** args){
     440:	55                   	push   %ebp
     441:	89 e5                	mov    %esp,%ebp
     443:	83 ec 18             	sub    $0x18,%esp
     446:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     449:	8b 5d 08             	mov    0x8(%ebp),%ebx
     44c:	89 75 fc             	mov    %esi,-0x4(%ebp)
     44f:	8b 75 0c             	mov    0xc(%ebp),%esi
    if((pid = fork()) == 0){
     452:	e8 19 0b 00 00       	call   f70 <fork>
     457:	83 f8 00             	cmp    $0x0,%eax
     45a:	74 3c                	je     498 <execute+0x58>
    else if(pid > 0){
     45c:	7e 1a                	jle    478 <execute+0x38>
        wait(null);
     45e:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
}
     465:	8b 5d f8             	mov    -0x8(%ebp),%ebx
     468:	8b 75 fc             	mov    -0x4(%ebp),%esi
     46b:	89 ec                	mov    %ebp,%esp
     46d:	5d                   	pop    %ebp
        wait(null);
     46e:	e9 0d 0b 00 00       	jmp    f80 <wait>
     473:	90                   	nop
     474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1,"fork failed\n");
     478:	c7 45 0c 68 14 00 00 	movl   $0x1468,0xc(%ebp)
}
     47f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
        printf(1,"fork failed\n");
     482:	c7 45 08 01 00 00 00 	movl   $0x1,0x8(%ebp)
}
     489:	8b 75 fc             	mov    -0x4(%ebp),%esi
     48c:	89 ec                	mov    %ebp,%esp
     48e:	5d                   	pop    %ebp
        printf(1,"fork failed\n");
     48f:	e9 4c 0c 00 00       	jmp    10e0 <printf>
     494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        exec(command, args);
     498:	89 74 24 04          	mov    %esi,0x4(%esp)
     49c:	89 1c 24             	mov    %ebx,(%esp)
     49f:	e8 0c 0b 00 00       	call   fb0 <exec>
        printf(1, "exec %s failed\n", command);
     4a4:	b8 58 14 00 00       	mov    $0x1458,%eax
     4a9:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     4ad:	89 44 24 04          	mov    %eax,0x4(%esp)
     4b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     4b8:	e8 23 0c 00 00       	call   10e0 <printf>
}
     4bd:	8b 5d f8             	mov    -0x8(%ebp),%ebx
     4c0:	8b 75 fc             	mov    -0x4(%ebp),%esi
     4c3:	89 ec                	mov    %ebp,%esp
     4c5:	5d                   	pop    %ebp
     4c6:	c3                   	ret    
     4c7:	89 f6                	mov    %esi,%esi
     4c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004d0 <run_test>:
void run_test(test_runner *test, char *name) {
     4d0:	55                   	push   %ebp
    printf(1, "========== Test - %s: Begin ==========\n", name);
     4d1:	b9 e4 16 00 00       	mov    $0x16e4,%ecx
void run_test(test_runner *test, char *name) {
     4d6:	89 e5                	mov    %esp,%ebp
     4d8:	53                   	push   %ebx
     4d9:	83 ec 14             	sub    $0x14,%esp
     4dc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    printf(1, "========== Test - %s: Begin ==========\n", name);
     4df:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     4e3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     4ea:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     4ee:	e8 ed 0b 00 00       	call   10e0 <printf>
    boolean result = (*test)();
     4f3:	ff 55 08             	call   *0x8(%ebp)
        printf(1, "========== Test - %s: Passed ==========\n", name);
     4f6:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    if (result) {
     4fa:	85 c0                	test   %eax,%eax
     4fc:	75 22                	jne    520 <run_test+0x50>
        printf(1, "========== Test - %s: Failed ==========\n", name);
     4fe:	b8 38 17 00 00       	mov    $0x1738,%eax
     503:	89 44 24 04          	mov    %eax,0x4(%esp)
     507:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     50e:	e8 cd 0b 00 00       	call   10e0 <printf>
}
     513:	83 c4 14             	add    $0x14,%esp
     516:	5b                   	pop    %ebx
     517:	5d                   	pop    %ebp
     518:	c3                   	ret    
     519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "========== Test - %s: Passed ==========\n", name);
     520:	ba 0c 17 00 00       	mov    $0x170c,%edx
     525:	89 54 24 04          	mov    %edx,0x4(%esp)
     529:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     530:	e8 ab 0b 00 00       	call   10e0 <printf>
}
     535:	83 c4 14             	add    $0x14,%esp
     538:	5b                   	pop    %ebx
     539:	5d                   	pop    %ebp
     53a:	c3                   	ret    
     53b:	90                   	nop
     53c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000540 <assert_equals>:
boolean assert_equals(int expected, int actual, char *msg) {
     540:	55                   	push   %ebp
     541:	b8 01 00 00 00       	mov    $0x1,%eax
     546:	89 e5                	mov    %esp,%ebp
     548:	83 ec 28             	sub    $0x28,%esp
     54b:	8b 55 08             	mov    0x8(%ebp),%edx
     54e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    if (expected != actual) {
     551:	39 ca                	cmp    %ecx,%edx
     553:	74 26                	je     57b <assert_equals+0x3b>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     555:	8b 45 10             	mov    0x10(%ebp),%eax
     558:	89 4c 24 10          	mov    %ecx,0x10(%esp)
     55c:	89 54 24 0c          	mov    %edx,0xc(%esp)
     560:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     567:	89 44 24 08          	mov    %eax,0x8(%esp)
     56b:	b8 64 17 00 00       	mov    $0x1764,%eax
     570:	89 44 24 04          	mov    %eax,0x4(%esp)
     574:	e8 67 0b 00 00       	call   10e0 <printf>
     579:	31 c0                	xor    %eax,%eax
}
     57b:	c9                   	leave  
     57c:	c3                   	ret    
     57d:	8d 76 00             	lea    0x0(%esi),%esi

00000580 <print_perf>:
void print_perf(struct perf *performance) {
     580:	55                   	push   %ebp
    printf(1, "pref:\n");
     581:	b8 75 14 00 00       	mov    $0x1475,%eax
void print_perf(struct perf *performance) {
     586:	89 e5                	mov    %esp,%ebp
     588:	53                   	push   %ebx
     589:	83 ec 14             	sub    $0x14,%esp
     58c:	8b 5d 08             	mov    0x8(%ebp),%ebx
    printf(1, "pref:\n");
     58f:	89 44 24 04          	mov    %eax,0x4(%esp)
     593:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     59a:	e8 41 0b 00 00       	call   10e0 <printf>
    printf(1, "\tctime: %d\n", performance->ctime);
     59f:	ba 7c 14 00 00       	mov    $0x147c,%edx
     5a4:	8b 03                	mov    (%ebx),%eax
     5a6:	89 54 24 04          	mov    %edx,0x4(%esp)
     5aa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     5b1:	89 44 24 08          	mov    %eax,0x8(%esp)
     5b5:	e8 26 0b 00 00       	call   10e0 <printf>
    printf(1, "\tttime: %d\n", performance->ttime);
     5ba:	8b 43 04             	mov    0x4(%ebx),%eax
     5bd:	b9 88 14 00 00       	mov    $0x1488,%ecx
     5c2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     5c6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     5cd:	89 44 24 08          	mov    %eax,0x8(%esp)
     5d1:	e8 0a 0b 00 00       	call   10e0 <printf>
    printf(1, "\tstime: %d\n", performance->stime);
     5d6:	8b 43 08             	mov    0x8(%ebx),%eax
     5d9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     5e0:	89 44 24 08          	mov    %eax,0x8(%esp)
     5e4:	b8 94 14 00 00       	mov    $0x1494,%eax
     5e9:	89 44 24 04          	mov    %eax,0x4(%esp)
     5ed:	e8 ee 0a 00 00       	call   10e0 <printf>
    printf(1, "\tretime: %d\n", performance->retime);
     5f2:	8b 43 0c             	mov    0xc(%ebx),%eax
     5f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     5fc:	89 44 24 08          	mov    %eax,0x8(%esp)
     600:	b8 a0 14 00 00       	mov    $0x14a0,%eax
     605:	89 44 24 04          	mov    %eax,0x4(%esp)
     609:	e8 d2 0a 00 00       	call   10e0 <printf>
    printf(1, "\trutime: %d\n", performance->rutime);
     60e:	8b 43 10             	mov    0x10(%ebx),%eax
     611:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     618:	89 44 24 08          	mov    %eax,0x8(%esp)
     61c:	b8 ad 14 00 00       	mov    $0x14ad,%eax
     621:	89 44 24 04          	mov    %eax,0x4(%esp)
     625:	e8 b6 0a 00 00       	call   10e0 <printf>
    printf(1, "\n\tTurnaround time: %d\n", (performance->ttime - performance->ctime));
     62a:	8b 43 04             	mov    0x4(%ebx),%eax
     62d:	b9 ba 14 00 00       	mov    $0x14ba,%ecx
     632:	8b 13                	mov    (%ebx),%edx
     634:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     638:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     63f:	29 d0                	sub    %edx,%eax
     641:	89 44 24 08          	mov    %eax,0x8(%esp)
     645:	e8 96 0a 00 00       	call   10e0 <printf>
}
     64a:	83 c4 14             	add    $0x14,%esp
     64d:	5b                   	pop    %ebx
     64e:	5d                   	pop    %ebp
     64f:	c3                   	ret    

00000650 <fact>:
int fact(int n) {
     650:	55                   	push   %ebp
}
     651:	31 c0                	xor    %eax,%eax
int fact(int n) {
     653:	89 e5                	mov    %esp,%ebp
}
     655:	5d                   	pop    %ebp
     656:	c3                   	ret    
     657:	89 f6                	mov    %esi,%esi
     659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000660 <fact2>:
unsigned long long fact2(unsigned long long n, unsigned long long k) {
     660:	55                   	push   %ebp
     661:	89 e5                	mov    %esp,%ebp
     663:	57                   	push   %edi
     664:	56                   	push   %esi
     665:	53                   	push   %ebx
     666:	83 ec 0c             	sub    $0xc,%esp
     669:	8b 45 10             	mov    0x10(%ebp),%eax
     66c:	8b 55 14             	mov    0x14(%ebp),%edx
     66f:	8b 4d 08             	mov    0x8(%ebp),%ecx
     672:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     675:	89 45 e8             	mov    %eax,-0x18(%ebp)
     678:	89 55 ec             	mov    %edx,-0x14(%ebp)
     67b:	eb 25                	jmp    6a2 <fact2+0x42>
     67d:	8d 76 00             	lea    0x0(%esi),%esi
        k = k * n;
     680:	8b 75 ec             	mov    -0x14(%ebp),%esi
        --n;
     683:	83 c1 ff             	add    $0xffffffff,%ecx
        k = k * n;
     686:	8b 55 e8             	mov    -0x18(%ebp),%edx
        --n;
     689:	83 d3 ff             	adc    $0xffffffff,%ebx
        k = k * n;
     68c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     68f:	0f af f1             	imul   %ecx,%esi
     692:	0f af d3             	imul   %ebx,%edx
     695:	01 d6                	add    %edx,%esi
     697:	f7 e1                	mul    %ecx
     699:	89 55 ec             	mov    %edx,-0x14(%ebp)
     69c:	01 75 ec             	add    %esi,-0x14(%ebp)
     69f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (n == 1) {
     6a2:	89 ce                	mov    %ecx,%esi
     6a4:	89 df                	mov    %ebx,%edi
     6a6:	83 f6 01             	xor    $0x1,%esi
     6a9:	09 f7                	or     %esi,%edi
     6ab:	75 d3                	jne    680 <fact2+0x20>
}
     6ad:	8b 45 e8             	mov    -0x18(%ebp),%eax
     6b0:	8b 55 ec             	mov    -0x14(%ebp),%edx
     6b3:	83 c4 0c             	add    $0xc,%esp
     6b6:	5b                   	pop    %ebx
     6b7:	5e                   	pop    %esi
     6b8:	5f                   	pop    %edi
     6b9:	5d                   	pop    %ebp
     6ba:	c3                   	ret    
     6bb:	90                   	nop
     6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006c0 <fib>:
int fib(int n) {
     6c0:	55                   	push   %ebp
     6c1:	89 e5                	mov    %esp,%ebp
     6c3:	83 ec 28             	sub    $0x28,%esp
     6c6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     6c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     6cc:	89 75 f8             	mov    %esi,-0x8(%ebp)
     6cf:	89 7d fc             	mov    %edi,-0x4(%ebp)
    if (!n)
     6d2:	85 db                	test   %ebx,%ebx
     6d4:	74 2a                	je     700 <fib+0x40>
     6d6:	4b                   	dec    %ebx
     6d7:	bf ff ff ff ff       	mov    $0xffffffff,%edi
     6dc:	31 f6                	xor    %esi,%esi
    return fib(n - 1) + fib(n - 2);
     6de:	89 1c 24             	mov    %ebx,(%esp)
     6e1:	83 eb 02             	sub    $0x2,%ebx
     6e4:	e8 d7 ff ff ff       	call   6c0 <fib>
     6e9:	01 c6                	add    %eax,%esi
    if (!n)
     6eb:	39 fb                	cmp    %edi,%ebx
     6ed:	75 ef                	jne    6de <fib+0x1e>
     6ef:	8d 46 01             	lea    0x1(%esi),%eax
}
     6f2:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     6f5:	8b 75 f8             	mov    -0x8(%ebp),%esi
     6f8:	8b 7d fc             	mov    -0x4(%ebp),%edi
     6fb:	89 ec                	mov    %ebp,%esp
     6fd:	5d                   	pop    %ebp
     6fe:	c3                   	ret    
     6ff:	90                   	nop
     700:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    if (!n)
     703:	b8 01 00 00 00       	mov    $0x1,%eax
}
     708:	8b 75 f8             	mov    -0x8(%ebp),%esi
     70b:	8b 7d fc             	mov    -0x4(%ebp),%edi
     70e:	89 ec                	mov    %ebp,%esp
     710:	5d                   	pop    %ebp
     711:	c3                   	ret    
     712:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000720 <test_exit_wait>:
boolean test_exit_wait() {
     720:	55                   	push   %ebp
     721:	89 e5                	mov    %esp,%ebp
     723:	57                   	push   %edi
     724:	56                   	push   %esi
    boolean result = true;
     725:	be 01 00 00 00       	mov    $0x1,%esi
boolean test_exit_wait() {
     72a:	53                   	push   %ebx
    for (int i = 0; i < 20; ++i) {
     72b:	31 db                	xor    %ebx,%ebx
boolean test_exit_wait() {
     72d:	83 ec 3c             	sub    $0x3c,%esp
            wait(&status);
     730:	8d 7d e4             	lea    -0x1c(%ebp),%edi
     733:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        pid = fork();
     740:	e8 2b 08 00 00       	call   f70 <fork>
        if (pid > 0) {
     745:	85 c0                	test   %eax,%eax
     747:	7e 57                	jle    7a0 <test_exit_wait+0x80>
            wait(&status);
     749:	89 3c 24             	mov    %edi,(%esp)
     74c:	e8 2f 08 00 00       	call   f80 <wait>
            result = result && assert_equals(i, status, "exit&wait");
     751:	85 f6                	test   %esi,%esi
     753:	74 34                	je     789 <test_exit_wait+0x69>
     755:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     758:	be 01 00 00 00       	mov    $0x1,%esi
    if (expected != actual) {
     75d:	39 d8                	cmp    %ebx,%eax
     75f:	74 28                	je     789 <test_exit_wait+0x69>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     761:	89 44 24 10          	mov    %eax,0x10(%esp)
     765:	ba 64 17 00 00       	mov    $0x1764,%edx
     76a:	b8 d1 14 00 00       	mov    $0x14d1,%eax
     76f:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
            result = result && assert_equals(i, status, "exit&wait");
     773:	31 f6                	xor    %esi,%esi
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     775:	89 44 24 08          	mov    %eax,0x8(%esp)
     779:	89 54 24 04          	mov    %edx,0x4(%esp)
     77d:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     784:	e8 57 09 00 00       	call   10e0 <printf>
    for (int i = 0; i < 20; ++i) {
     789:	43                   	inc    %ebx
     78a:	83 fb 14             	cmp    $0x14,%ebx
            status = -1;
     78d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
    for (int i = 0; i < 20; ++i) {
     794:	75 aa                	jne    740 <test_exit_wait+0x20>
}
     796:	83 c4 3c             	add    $0x3c,%esp
     799:	89 f0                	mov    %esi,%eax
     79b:	5b                   	pop    %ebx
     79c:	5e                   	pop    %esi
     79d:	5f                   	pop    %edi
     79e:	5d                   	pop    %ebp
     79f:	c3                   	ret    
            sleep(3);
     7a0:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
     7a7:	e8 5c 08 00 00       	call   1008 <sleep>
            exit(i);
     7ac:	89 1c 24             	mov    %ebx,(%esp)
     7af:	e8 c4 07 00 00       	call   f78 <exit>
     7b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     7ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000007c0 <test_detach>:
boolean test_detach() {
     7c0:	55                   	push   %ebp
     7c1:	89 e5                	mov    %esp,%ebp
     7c3:	56                   	push   %esi
     7c4:	53                   	push   %ebx
     7c5:	83 ec 20             	sub    $0x20,%esp
    pid = fork();
     7c8:	e8 a3 07 00 00       	call   f70 <fork>
    if (pid > 0) {
     7cd:	85 c0                	test   %eax,%eax
     7cf:	0f 8e ea 00 00 00    	jle    8bf <test_detach+0xff>
        status1 = detach(pid);
     7d5:	89 04 24             	mov    %eax,(%esp)
     7d8:	89 c3                	mov    %eax,%ebx
    } else return true;
     7da:	be 01 00 00 00       	mov    $0x1,%esi
        status1 = detach(pid);
     7df:	e8 3c 08 00 00       	call   1020 <detach>
    if (expected != actual) {
     7e4:	85 c0                	test   %eax,%eax
     7e6:	0f 85 a4 00 00 00    	jne    890 <test_detach+0xd0>
        status2 = detach(pid);
     7ec:	89 1c 24             	mov    %ebx,(%esp)
     7ef:	e8 2c 08 00 00       	call   1020 <detach>
    if (expected != actual) {
     7f4:	83 f8 ff             	cmp    $0xffffffff,%eax
     7f7:	75 1f                	jne    818 <test_detach+0x58>
        status3 = detach(-10);
     7f9:	c7 04 24 f6 ff ff ff 	movl   $0xfffffff6,(%esp)
     800:	e8 1b 08 00 00       	call   1020 <detach>
    if (expected != actual) {
     805:	83 f8 ff             	cmp    $0xffffffff,%eax
     808:	75 4a                	jne    854 <test_detach+0x94>
}
     80a:	83 c4 20             	add    $0x20,%esp
     80d:	89 f0                	mov    %esi,%eax
     80f:	5b                   	pop    %ebx
     810:	5e                   	pop    %esi
     811:	5d                   	pop    %ebp
     812:	c3                   	ret    
     813:	90                   	nop
     814:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     818:	89 44 24 10          	mov    %eax,0x10(%esp)
     81c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
     821:	b8 64 17 00 00       	mov    $0x1764,%eax
     826:	be ec 14 00 00       	mov    $0x14ec,%esi
     82b:	89 44 24 04          	mov    %eax,0x4(%esp)
     82f:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
     833:	89 74 24 08          	mov    %esi,0x8(%esp)
     837:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     83e:	e8 9d 08 00 00       	call   10e0 <printf>
        status3 = detach(-10);
     843:	c7 04 24 f6 ff ff ff 	movl   $0xfffffff6,(%esp)
     84a:	e8 d1 07 00 00       	call   1020 <detach>
    if (expected != actual) {
     84f:	83 f8 ff             	cmp    $0xffffffff,%eax
     852:	74 2b                	je     87f <test_detach+0xbf>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     854:	89 44 24 10          	mov    %eax,0x10(%esp)
     858:	ba fd 14 00 00       	mov    $0x14fd,%edx
     85d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     862:	b9 64 17 00 00       	mov    $0x1764,%ecx
     867:	89 44 24 0c          	mov    %eax,0xc(%esp)
     86b:	89 54 24 08          	mov    %edx,0x8(%esp)
     86f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     873:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     87a:	e8 61 08 00 00       	call   10e0 <printf>
}
     87f:	83 c4 20             	add    $0x20,%esp
        return result1 && result2 && result3;
     882:	31 f6                	xor    %esi,%esi
}
     884:	5b                   	pop    %ebx
     885:	89 f0                	mov    %esi,%eax
     887:	5e                   	pop    %esi
     888:	5d                   	pop    %ebp
     889:	c3                   	ret    
     88a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     890:	89 44 24 10          	mov    %eax,0x10(%esp)
     894:	31 c0                	xor    %eax,%eax
     896:	31 f6                	xor    %esi,%esi
     898:	89 44 24 0c          	mov    %eax,0xc(%esp)
     89c:	b8 db 14 00 00       	mov    $0x14db,%eax
     8a1:	89 44 24 08          	mov    %eax,0x8(%esp)
     8a5:	b8 64 17 00 00       	mov    $0x1764,%eax
     8aa:	89 44 24 04          	mov    %eax,0x4(%esp)
     8ae:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     8b5:	e8 26 08 00 00       	call   10e0 <printf>
     8ba:	e9 2d ff ff ff       	jmp    7ec <test_detach+0x2c>
        sleep(100);
     8bf:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
     8c6:	e8 3d 07 00 00       	call   1008 <sleep>
        exit(0);
     8cb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     8d2:	e8 a1 06 00 00       	call   f78 <exit>
     8d7:	89 f6                	mov    %esi,%esi
     8d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008e0 <test_policy_helper>:
boolean test_policy_helper(int *priority_mod, int policy) {
     8e0:	55                   	push   %ebp
     8e1:	89 e5                	mov    %esp,%ebp
     8e3:	57                   	push   %edi
     8e4:	56                   	push   %esi
     8e5:	53                   	push   %ebx
    for (int i = 0; i < nProcs; ++i) {
     8e6:	31 db                	xor    %ebx,%ebx
boolean test_policy_helper(int *priority_mod, int policy) {
     8e8:	83 ec 4c             	sub    $0x4c,%esp
     8eb:	90                   	nop
     8ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        pid = fork();
     8f0:	e8 7b 06 00 00       	call   f70 <fork>
        if (pid < 0) {
     8f5:	85 c0                	test   %eax,%eax
     8f7:	78 0c                	js     905 <test_policy_helper+0x25>
        } else if (pid == 0) {
     8f9:	0f 84 a5 00 00 00    	je     9a4 <test_policy_helper+0xc4>
    for (int i = 0; i < nProcs; ++i) {
     8ff:	43                   	inc    %ebx
     900:	83 fb 0a             	cmp    $0xa,%ebx
     903:	75 eb                	jne    8f0 <test_policy_helper+0x10>
     905:	31 f6                	xor    %esi,%esi
     907:	ba 01 00 00 00       	mov    $0x1,%edx
     90c:	8d 7d e4             	lea    -0x1c(%ebp),%edi
        wait(&status);
     90f:	89 3c 24             	mov    %edi,(%esp)
     912:	8d 5e 01             	lea    0x1(%esi),%ebx
     915:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     918:	e8 63 06 00 00       	call   f80 <wait>
        result = result && assert_equals(0, status, "round robin");
     91d:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     920:	85 d2                	test   %edx,%edx
     922:	74 5c                	je     980 <test_policy_helper+0xa0>
     924:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     927:	ba 01 00 00 00       	mov    $0x1,%edx
    if (expected != actual) {
     92c:	85 c0                	test   %eax,%eax
     92e:	75 18                	jne    948 <test_policy_helper+0x68>
    for (int j = 0; j < nProcs; ++j) {
     930:	83 fb 0a             	cmp    $0xa,%ebx
     933:	89 de                	mov    %ebx,%esi
     935:	75 d8                	jne    90f <test_policy_helper+0x2f>
}
     937:	83 c4 4c             	add    $0x4c,%esp
     93a:	89 d0                	mov    %edx,%eax
     93c:	5b                   	pop    %ebx
     93d:	5e                   	pop    %esi
     93e:	5f                   	pop    %edi
     93f:	5d                   	pop    %ebp
     940:	c3                   	ret    
     941:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     948:	89 44 24 10          	mov    %eax,0x10(%esp)
     94c:	ba 0e 15 00 00       	mov    $0x150e,%edx
     951:	31 c0                	xor    %eax,%eax
     953:	b9 64 17 00 00       	mov    $0x1764,%ecx
     958:	89 44 24 0c          	mov    %eax,0xc(%esp)
     95c:	89 54 24 08          	mov    %edx,0x8(%esp)
     960:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     964:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     96b:	e8 70 07 00 00       	call   10e0 <printf>
    for (int j = 0; j < nProcs; ++j) {
     970:	83 fb 0a             	cmp    $0xa,%ebx
     973:	74 23                	je     998 <test_policy_helper+0xb8>
        wait(&status);
     975:	89 3c 24             	mov    %edi,(%esp)
     978:	8d 5e 02             	lea    0x2(%esi),%ebx
     97b:	e8 00 06 00 00       	call   f80 <wait>
    for (int j = 0; j < nProcs; ++j) {
     980:	83 fb 0a             	cmp    $0xa,%ebx
     983:	74 13                	je     998 <test_policy_helper+0xb8>
        wait(&status);
     985:	89 3c 24             	mov    %edi,(%esp)
     988:	43                   	inc    %ebx
     989:	e8 f2 05 00 00       	call   f80 <wait>
        result = result && assert_equals(0, status, "round robin");
     98e:	31 d2                	xor    %edx,%edx
     990:	eb 9e                	jmp    930 <test_policy_helper+0x50>
     992:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
     998:	83 c4 4c             	add    $0x4c,%esp
        result = result && assert_equals(0, status, "round robin");
     99b:	31 d2                	xor    %edx,%edx
}
     99d:	5b                   	pop    %ebx
     99e:	89 d0                	mov    %edx,%eax
     9a0:	5e                   	pop    %esi
     9a1:	5f                   	pop    %edi
     9a2:	5d                   	pop    %ebp
     9a3:	c3                   	ret    
            if (priority_mod) {
     9a4:	8b 75 08             	mov    0x8(%ebp),%esi
     9a7:	85 f6                	test   %esi,%esi
     9a9:	74 1a                	je     9c5 <test_policy_helper+0xe5>
                if ((i % *(priority_mod)) == 0 && policy == PRIORITY) {
     9ab:	8b 4d 08             	mov    0x8(%ebp),%ecx
     9ae:	89 d8                	mov    %ebx,%eax
     9b0:	99                   	cltd   
     9b1:	f7 39                	idivl  (%ecx)
     9b3:	85 d2                	test   %edx,%edx
     9b5:	75 06                	jne    9bd <test_policy_helper+0xdd>
     9b7:	83 7d 0c 02          	cmpl   $0x2,0xc(%ebp)
     9bb:	74 20                	je     9dd <test_policy_helper+0xfd>
                    priority(i % (*priority_mod));
     9bd:	89 14 24             	mov    %edx,(%esp)
     9c0:	e8 63 06 00 00       	call   1028 <priority>
            sleep(10);
     9c5:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
     9cc:	e8 37 06 00 00       	call   1008 <sleep>
            exit(0);
     9d1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     9d8:	e8 9b 05 00 00       	call   f78 <exit>
                    priority(1);
     9dd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     9e4:	e8 3f 06 00 00       	call   1028 <priority>
     9e9:	eb da                	jmp    9c5 <test_policy_helper+0xe5>
     9eb:	90                   	nop
     9ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000009f0 <test_round_robin_policy>:
boolean test_round_robin_policy() {
     9f0:	55                   	push   %ebp
    return test_policy_helper(null, null);
     9f1:	31 c0                	xor    %eax,%eax
boolean test_round_robin_policy() {
     9f3:	89 e5                	mov    %esp,%ebp
     9f5:	83 ec 18             	sub    $0x18,%esp
    return test_policy_helper(null, null);
     9f8:	89 44 24 04          	mov    %eax,0x4(%esp)
     9fc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     a03:	e8 d8 fe ff ff       	call   8e0 <test_policy_helper>
}
     a08:	c9                   	leave  
     a09:	c3                   	ret    
     a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000a10 <test_priority_policy>:
boolean test_priority_policy() {
     a10:	55                   	push   %ebp
     a11:	89 e5                	mov    %esp,%ebp
     a13:	53                   	push   %ebx
     a14:	83 ec 24             	sub    $0x24,%esp
    policy(PRIORITY);
     a17:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    int priority_mod = 10;
     a1e:	c7 45 f4 0a 00 00 00 	movl   $0xa,-0xc(%ebp)
    policy(PRIORITY);
     a25:	e8 ee 05 00 00       	call   1018 <policy>
    boolean result = test_policy_helper(&priority_mod, PRIORITY);
     a2a:	b8 02 00 00 00       	mov    $0x2,%eax
     a2f:	89 44 24 04          	mov    %eax,0x4(%esp)
     a33:	8d 45 f4             	lea    -0xc(%ebp),%eax
     a36:	89 04 24             	mov    %eax,(%esp)
     a39:	e8 a2 fe ff ff       	call   8e0 <test_policy_helper>
    policy(ROUND_ROBIN);
     a3e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    boolean result = test_policy_helper(&priority_mod, PRIORITY);
     a45:	89 c3                	mov    %eax,%ebx
    policy(ROUND_ROBIN);
     a47:	e8 cc 05 00 00       	call   1018 <policy>
}
     a4c:	83 c4 24             	add    $0x24,%esp
     a4f:	89 d8                	mov    %ebx,%eax
     a51:	5b                   	pop    %ebx
     a52:	5d                   	pop    %ebp
     a53:	c3                   	ret    
     a54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     a5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000a60 <test_extended_priority_policy>:
boolean test_extended_priority_policy() {
     a60:	55                   	push   %ebp
     a61:	89 e5                	mov    %esp,%ebp
     a63:	53                   	push   %ebx
     a64:	83 ec 24             	sub    $0x24,%esp
    policy(EXTENED_PRIORITY);
     a67:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
    int priority_mod = 10;
     a6e:	c7 45 f4 0a 00 00 00 	movl   $0xa,-0xc(%ebp)
    policy(EXTENED_PRIORITY);
     a75:	e8 9e 05 00 00       	call   1018 <policy>
    boolean result = test_policy_helper(&priority_mod, EXTENED_PRIORITY);
     a7a:	b8 03 00 00 00       	mov    $0x3,%eax
     a7f:	89 44 24 04          	mov    %eax,0x4(%esp)
     a83:	8d 45 f4             	lea    -0xc(%ebp),%eax
     a86:	89 04 24             	mov    %eax,(%esp)
     a89:	e8 52 fe ff ff       	call   8e0 <test_policy_helper>
    policy(ROUND_ROBIN);
     a8e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    boolean result = test_policy_helper(&priority_mod, EXTENED_PRIORITY);
     a95:	89 c3                	mov    %eax,%ebx
    policy(ROUND_ROBIN);
     a97:	e8 7c 05 00 00       	call   1018 <policy>
}
     a9c:	83 c4 24             	add    $0x24,%esp
     a9f:	89 d8                	mov    %ebx,%eax
     aa1:	5b                   	pop    %ebx
     aa2:	5d                   	pop    %ebp
     aa3:	c3                   	ret    
     aa4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     aaa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000ab0 <test_performance_helper>:
boolean test_performance_helper(int *npriority) {
     ab0:	55                   	push   %ebp
     ab1:	89 e5                	mov    %esp,%ebp
     ab3:	57                   	push   %edi
     ab4:	56                   	push   %esi
     ab5:	53                   	push   %ebx
     ab6:	83 ec 3c             	sub    $0x3c,%esp
    pid1 = fork();
     ab9:	e8 b2 04 00 00       	call   f70 <fork>
    if (pid1 > 0) {
     abe:	85 c0                	test   %eax,%eax
     ac0:	7f 3e                	jg     b00 <test_performance_helper+0x50>
     ac2:	bb 0a 00 00 00       	mov    $0xa,%ebx
                wait_stat(&status, &perf1);
     ac7:	8d 7d d4             	lea    -0x2c(%ebp),%edi
     aca:	8d 75 d0             	lea    -0x30(%ebp),%esi
     acd:	8d 76 00             	lea    0x0(%esi),%esi
            pid = fork();
     ad0:	e8 9b 04 00 00       	call   f70 <fork>
            if (pid > 0) {
     ad5:	85 c0                	test   %eax,%eax
     ad7:	7e 4e                	jle    b27 <test_performance_helper+0x77>
                sleep(5);
     ad9:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     ae0:	e8 23 05 00 00       	call   1008 <sleep>
                wait_stat(&status, &perf1);
     ae5:	89 7c 24 04          	mov    %edi,0x4(%esp)
     ae9:	89 34 24             	mov    %esi,(%esp)
     aec:	e8 3f 05 00 00       	call   1030 <wait_stat>
        for (int a = 0; a < 10; ++a) {
     af1:	4b                   	dec    %ebx
     af2:	75 dc                	jne    ad0 <test_performance_helper+0x20>
        exit(0);
     af4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     afb:	e8 78 04 00 00       	call   f78 <exit>
        wait_stat(&status1, &perf2);
     b00:	8d 5d d4             	lea    -0x2c(%ebp),%ebx
     b03:	8d 45 d0             	lea    -0x30(%ebp),%eax
     b06:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     b0a:	89 04 24             	mov    %eax,(%esp)
     b0d:	e8 1e 05 00 00       	call   1030 <wait_stat>
        print_perf(&perf2);
     b12:	89 1c 24             	mov    %ebx,(%esp)
     b15:	e8 66 fa ff ff       	call   580 <print_perf>
}
     b1a:	83 c4 3c             	add    $0x3c,%esp
     b1d:	b8 01 00 00 00       	mov    $0x1,%eax
     b22:	5b                   	pop    %ebx
     b23:	5e                   	pop    %esi
     b24:	5f                   	pop    %edi
     b25:	5d                   	pop    %ebp
     b26:	c3                   	ret    
                if (npriority)
     b27:	8b 45 08             	mov    0x8(%ebp),%eax
     b2a:	85 c0                	test   %eax,%eax
     b2c:	74 0d                	je     b3b <test_performance_helper+0x8b>
                    priority(*npriority);
     b2e:	8b 45 08             	mov    0x8(%ebp),%eax
     b31:	8b 00                	mov    (%eax),%eax
     b33:	89 04 24             	mov    %eax,(%esp)
     b36:	e8 ed 04 00 00       	call   1028 <priority>
                sleep(5);
     b3b:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     b42:	e8 c1 04 00 00       	call   1008 <sleep>
                exit(0);
     b47:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     b4e:	e8 25 04 00 00       	call   f78 <exit>
     b53:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b60 <test_starvation_helper>:
boolean test_starvation_helper(int npolicy, int npriority) {
     b60:	55                   	push   %ebp
     b61:	89 e5                	mov    %esp,%ebp
     b63:	57                   	push   %edi
     b64:	56                   	push   %esi
    memset(&pid_arr, 0, nProcs * sizeof(int));
     b65:	31 f6                	xor    %esi,%esi
boolean test_starvation_helper(int npolicy, int npriority) {
     b67:	53                   	push   %ebx
    memset(&pid_arr, 0, nProcs * sizeof(int));
     b68:	bb 28 00 00 00       	mov    $0x28,%ebx
boolean test_starvation_helper(int npolicy, int npriority) {
     b6d:	83 ec 5c             	sub    $0x5c,%esp
    policy(npolicy);
     b70:	8b 45 08             	mov    0x8(%ebp),%eax
     b73:	89 04 24             	mov    %eax,(%esp)
     b76:	e8 9d 04 00 00       	call   1018 <policy>
    memset(&pid_arr, 0, nProcs * sizeof(int));
     b7b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     b7f:	8d 5d c0             	lea    -0x40(%ebp),%ebx
     b82:	89 74 24 04          	mov    %esi,0x4(%esp)
     b86:	89 df                	mov    %ebx,%edi
     b88:	89 1c 24             	mov    %ebx,(%esp)
     b8b:	8d 75 e8             	lea    -0x18(%ebp),%esi
     b8e:	e8 4d 02 00 00       	call   de0 <memset>
     b93:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        pid = fork();
     ba0:	e8 cb 03 00 00       	call   f70 <fork>
        if (pid < 0) {
     ba5:	85 c0                	test   %eax,%eax
     ba7:	78 0f                	js     bb8 <test_starvation_helper+0x58>
        } else if (pid == 0) {
     ba9:	0f 84 a1 00 00 00    	je     c50 <test_starvation_helper+0xf0>
            pid_arr[i] = pid;
     baf:	89 07                	mov    %eax,(%edi)
     bb1:	83 c7 04             	add    $0x4,%edi
    for (int i = 0; i < nProcs; ++i) {
     bb4:	39 f7                	cmp    %esi,%edi
     bb6:	75 e8                	jne    ba0 <test_starvation_helper+0x40>
    sleep(100);
     bb8:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
    boolean result = true;
     bbf:	bf 01 00 00 00       	mov    $0x1,%edi
    sleep(100);
     bc4:	e8 3f 04 00 00       	call   1008 <sleep>
     bc9:	eb 18                	jmp    be3 <test_starvation_helper+0x83>
     bcb:	90                   	nop
     bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            wait(null);
     bd0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     bd7:	e8 a4 03 00 00       	call   f80 <wait>
     bdc:	83 c3 04             	add    $0x4,%ebx
    for (int j = 0; j < nProcs; ++j) {
     bdf:	39 de                	cmp    %ebx,%esi
     be1:	74 4d                	je     c30 <test_starvation_helper+0xd0>
        if (pid_arr[j] != 0) {
     be3:	8b 03                	mov    (%ebx),%eax
     be5:	85 c0                	test   %eax,%eax
     be7:	74 f3                	je     bdc <test_starvation_helper+0x7c>
            result = result && assert_equals(0, kill(pid_arr[j]), "failed to kill child (yes it does sound horrible)");
     be9:	85 ff                	test   %edi,%edi
     beb:	74 e3                	je     bd0 <test_starvation_helper+0x70>
     bed:	89 04 24             	mov    %eax,(%esp)
     bf0:	bf 01 00 00 00       	mov    $0x1,%edi
     bf5:	e8 ae 03 00 00       	call   fa8 <kill>
    if (expected != actual) {
     bfa:	85 c0                	test   %eax,%eax
     bfc:	74 d2                	je     bd0 <test_starvation_helper+0x70>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     bfe:	89 44 24 10          	mov    %eax,0x10(%esp)
     c02:	ba 90 17 00 00       	mov    $0x1790,%edx
     c07:	31 c0                	xor    %eax,%eax
     c09:	b9 64 17 00 00       	mov    $0x1764,%ecx
            result = result && assert_equals(0, kill(pid_arr[j]), "failed to kill child (yes it does sound horrible)");
     c0e:	31 ff                	xor    %edi,%edi
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     c10:	89 44 24 0c          	mov    %eax,0xc(%esp)
     c14:	89 54 24 08          	mov    %edx,0x8(%esp)
     c18:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     c1c:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     c23:	e8 b8 04 00 00       	call   10e0 <printf>
     c28:	eb a6                	jmp    bd0 <test_starvation_helper+0x70>
     c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    policy(ROUND_ROBIN);
     c30:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c37:	e8 dc 03 00 00       	call   1018 <policy>
}
     c3c:	83 c4 5c             	add    $0x5c,%esp
     c3f:	89 f8                	mov    %edi,%eax
     c41:	5b                   	pop    %ebx
     c42:	5e                   	pop    %esi
     c43:	5f                   	pop    %edi
     c44:	5d                   	pop    %ebp
     c45:	c3                   	ret    
     c46:	8d 76 00             	lea    0x0(%esi),%esi
     c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            sleep(5);
     c50:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     c57:	e8 ac 03 00 00       	call   1008 <sleep>
            priority(npriority);
     c5c:	8b 45 0c             	mov    0xc(%ebp),%eax
     c5f:	89 04 24             	mov    %eax,(%esp)
     c62:	e8 c1 03 00 00       	call   1028 <priority>
     c67:	eb fe                	jmp    c67 <test_starvation_helper+0x107>
     c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000c70 <test_accumulator>:
boolean test_accumulator() {
     c70:	55                   	push   %ebp
    return test_starvation_helper(PRIORITY, 2);
     c71:	b8 02 00 00 00       	mov    $0x2,%eax
boolean test_accumulator() {
     c76:	89 e5                	mov    %esp,%ebp
     c78:	83 ec 18             	sub    $0x18,%esp
    return test_starvation_helper(PRIORITY, 2);
     c7b:	89 44 24 04          	mov    %eax,0x4(%esp)
     c7f:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     c86:	e8 d5 fe ff ff       	call   b60 <test_starvation_helper>
}
     c8b:	c9                   	leave  
     c8c:	c3                   	ret    
     c8d:	8d 76 00             	lea    0x0(%esi),%esi

00000c90 <test_starvation>:
boolean test_starvation() {
     c90:	55                   	push   %ebp
    return test_starvation_helper(EXTENED_PRIORITY, 0);
     c91:	31 c0                	xor    %eax,%eax
boolean test_starvation() {
     c93:	89 e5                	mov    %esp,%ebp
     c95:	83 ec 18             	sub    $0x18,%esp
    return test_starvation_helper(EXTENED_PRIORITY, 0);
     c98:	89 44 24 04          	mov    %eax,0x4(%esp)
     c9c:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
     ca3:	e8 b8 fe ff ff       	call   b60 <test_starvation_helper>
}
     ca8:	c9                   	leave  
     ca9:	c3                   	ret    
     caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000cb0 <test_performance_round_robin>:
boolean test_performance_round_robin() {
     cb0:	55                   	push   %ebp
     cb1:	89 e5                	mov    %esp,%ebp
     cb3:	83 ec 18             	sub    $0x18,%esp
    return test_performance_helper(null);
     cb6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     cbd:	e8 ee fd ff ff       	call   ab0 <test_performance_helper>
}
     cc2:	c9                   	leave  
     cc3:	c3                   	ret    
     cc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     cca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000cd0 <test_performance_priority>:
boolean test_performance_priority() {
     cd0:	55                   	push   %ebp
     cd1:	89 e5                	mov    %esp,%ebp
     cd3:	53                   	push   %ebx
     cd4:	83 ec 24             	sub    $0x24,%esp
    policy(PRIORITY);
     cd7:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     cde:	e8 35 03 00 00       	call   1018 <policy>
    boolean result = test_performance_helper(&npriority);
     ce3:	8d 45 f4             	lea    -0xc(%ebp),%eax
     ce6:	89 04 24             	mov    %eax,(%esp)
    int npriority = 2;
     ce9:	c7 45 f4 02 00 00 00 	movl   $0x2,-0xc(%ebp)
    boolean result = test_performance_helper(&npriority);
     cf0:	e8 bb fd ff ff       	call   ab0 <test_performance_helper>
    policy(ROUND_ROBIN);
     cf5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    boolean result = test_performance_helper(&npriority);
     cfc:	89 c3                	mov    %eax,%ebx
    policy(ROUND_ROBIN);
     cfe:	e8 15 03 00 00       	call   1018 <policy>
}
     d03:	83 c4 24             	add    $0x24,%esp
     d06:	89 d8                	mov    %ebx,%eax
     d08:	5b                   	pop    %ebx
     d09:	5d                   	pop    %ebp
     d0a:	c3                   	ret    
     d0b:	90                   	nop
     d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000d10 <test_performance_extended_priority>:
boolean test_performance_extended_priority() {
     d10:	55                   	push   %ebp
     d11:	89 e5                	mov    %esp,%ebp
     d13:	53                   	push   %ebx
     d14:	83 ec 24             	sub    $0x24,%esp
    policy(EXTENED_PRIORITY);
     d17:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
     d1e:	e8 f5 02 00 00       	call   1018 <policy>
    boolean result = test_performance_helper(&npriority);
     d23:	8d 45 f4             	lea    -0xc(%ebp),%eax
     d26:	89 04 24             	mov    %eax,(%esp)
    int npriority = 0;
     d29:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    boolean result = test_performance_helper(&npriority);
     d30:	e8 7b fd ff ff       	call   ab0 <test_performance_helper>
    policy(ROUND_ROBIN);
     d35:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    boolean result = test_performance_helper(&npriority);
     d3c:	89 c3                	mov    %eax,%ebx
    policy(ROUND_ROBIN);
     d3e:	e8 d5 02 00 00       	call   1018 <policy>
}
     d43:	83 c4 24             	add    $0x24,%esp
     d46:	89 d8                	mov    %ebx,%eax
     d48:	5b                   	pop    %ebx
     d49:	5d                   	pop    %ebp
     d4a:	c3                   	ret    
     d4b:	66 90                	xchg   %ax,%ax
     d4d:	66 90                	xchg   %ax,%ax
     d4f:	90                   	nop

00000d50 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     d50:	55                   	push   %ebp
     d51:	89 e5                	mov    %esp,%ebp
     d53:	8b 45 08             	mov    0x8(%ebp),%eax
     d56:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     d59:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     d5a:	89 c2                	mov    %eax,%edx
     d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d60:	41                   	inc    %ecx
     d61:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     d65:	42                   	inc    %edx
     d66:	84 db                	test   %bl,%bl
     d68:	88 5a ff             	mov    %bl,-0x1(%edx)
     d6b:	75 f3                	jne    d60 <strcpy+0x10>
    ;
  return os;
}
     d6d:	5b                   	pop    %ebx
     d6e:	5d                   	pop    %ebp
     d6f:	c3                   	ret    

00000d70 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     d70:	55                   	push   %ebp
     d71:	89 e5                	mov    %esp,%ebp
     d73:	8b 4d 08             	mov    0x8(%ebp),%ecx
     d76:	53                   	push   %ebx
     d77:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
     d7a:	0f b6 01             	movzbl (%ecx),%eax
     d7d:	0f b6 13             	movzbl (%ebx),%edx
     d80:	84 c0                	test   %al,%al
     d82:	75 18                	jne    d9c <strcmp+0x2c>
     d84:	eb 22                	jmp    da8 <strcmp+0x38>
     d86:	8d 76 00             	lea    0x0(%esi),%esi
     d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     d90:	41                   	inc    %ecx
  while(*p && *p == *q)
     d91:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
     d94:	43                   	inc    %ebx
     d95:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
     d98:	84 c0                	test   %al,%al
     d9a:	74 0c                	je     da8 <strcmp+0x38>
     d9c:	38 d0                	cmp    %dl,%al
     d9e:	74 f0                	je     d90 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
     da0:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
     da1:	29 d0                	sub    %edx,%eax
}
     da3:	5d                   	pop    %ebp
     da4:	c3                   	ret    
     da5:	8d 76 00             	lea    0x0(%esi),%esi
     da8:	5b                   	pop    %ebx
     da9:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     dab:	29 d0                	sub    %edx,%eax
}
     dad:	5d                   	pop    %ebp
     dae:	c3                   	ret    
     daf:	90                   	nop

00000db0 <strlen>:

uint
strlen(const char *s)
{
     db0:	55                   	push   %ebp
     db1:	89 e5                	mov    %esp,%ebp
     db3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     db6:	80 39 00             	cmpb   $0x0,(%ecx)
     db9:	74 15                	je     dd0 <strlen+0x20>
     dbb:	31 d2                	xor    %edx,%edx
     dbd:	8d 76 00             	lea    0x0(%esi),%esi
     dc0:	42                   	inc    %edx
     dc1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     dc5:	89 d0                	mov    %edx,%eax
     dc7:	75 f7                	jne    dc0 <strlen+0x10>
    ;
  return n;
}
     dc9:	5d                   	pop    %ebp
     dca:	c3                   	ret    
     dcb:	90                   	nop
     dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
     dd0:	31 c0                	xor    %eax,%eax
}
     dd2:	5d                   	pop    %ebp
     dd3:	c3                   	ret    
     dd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     dda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000de0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     de0:	55                   	push   %ebp
     de1:	89 e5                	mov    %esp,%ebp
     de3:	8b 55 08             	mov    0x8(%ebp),%edx
     de6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     de7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     dea:	8b 45 0c             	mov    0xc(%ebp),%eax
     ded:	89 d7                	mov    %edx,%edi
     def:	fc                   	cld    
     df0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     df2:	5f                   	pop    %edi
     df3:	89 d0                	mov    %edx,%eax
     df5:	5d                   	pop    %ebp
     df6:	c3                   	ret    
     df7:	89 f6                	mov    %esi,%esi
     df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000e00 <strchr>:

char*
strchr(const char *s, char c)
{
     e00:	55                   	push   %ebp
     e01:	89 e5                	mov    %esp,%ebp
     e03:	8b 45 08             	mov    0x8(%ebp),%eax
     e06:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     e0a:	0f b6 10             	movzbl (%eax),%edx
     e0d:	84 d2                	test   %dl,%dl
     e0f:	74 1b                	je     e2c <strchr+0x2c>
    if(*s == c)
     e11:	38 d1                	cmp    %dl,%cl
     e13:	75 0f                	jne    e24 <strchr+0x24>
     e15:	eb 17                	jmp    e2e <strchr+0x2e>
     e17:	89 f6                	mov    %esi,%esi
     e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     e20:	38 ca                	cmp    %cl,%dl
     e22:	74 0a                	je     e2e <strchr+0x2e>
  for(; *s; s++)
     e24:	40                   	inc    %eax
     e25:	0f b6 10             	movzbl (%eax),%edx
     e28:	84 d2                	test   %dl,%dl
     e2a:	75 f4                	jne    e20 <strchr+0x20>
      return (char*)s;
  return 0;
     e2c:	31 c0                	xor    %eax,%eax
}
     e2e:	5d                   	pop    %ebp
     e2f:	c3                   	ret    

00000e30 <gets>:

char*
gets(char *buf, int max)
{
     e30:	55                   	push   %ebp
     e31:	89 e5                	mov    %esp,%ebp
     e33:	57                   	push   %edi
     e34:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     e35:	31 f6                	xor    %esi,%esi
{
     e37:	53                   	push   %ebx
     e38:	83 ec 3c             	sub    $0x3c,%esp
     e3b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
     e3e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
     e41:	eb 32                	jmp    e75 <gets+0x45>
     e43:	90                   	nop
     e44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
     e48:	ba 01 00 00 00       	mov    $0x1,%edx
     e4d:	89 54 24 08          	mov    %edx,0x8(%esp)
     e51:	89 7c 24 04          	mov    %edi,0x4(%esp)
     e55:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     e5c:	e8 2f 01 00 00       	call   f90 <read>
    if(cc < 1)
     e61:	85 c0                	test   %eax,%eax
     e63:	7e 19                	jle    e7e <gets+0x4e>
      break;
    buf[i++] = c;
     e65:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     e69:	43                   	inc    %ebx
     e6a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
     e6d:	3c 0a                	cmp    $0xa,%al
     e6f:	74 1f                	je     e90 <gets+0x60>
     e71:	3c 0d                	cmp    $0xd,%al
     e73:	74 1b                	je     e90 <gets+0x60>
  for(i=0; i+1 < max; ){
     e75:	46                   	inc    %esi
     e76:	3b 75 0c             	cmp    0xc(%ebp),%esi
     e79:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
     e7c:	7c ca                	jl     e48 <gets+0x18>
      break;
  }
  buf[i] = '\0';
     e7e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     e81:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
     e84:	8b 45 08             	mov    0x8(%ebp),%eax
     e87:	83 c4 3c             	add    $0x3c,%esp
     e8a:	5b                   	pop    %ebx
     e8b:	5e                   	pop    %esi
     e8c:	5f                   	pop    %edi
     e8d:	5d                   	pop    %ebp
     e8e:	c3                   	ret    
     e8f:	90                   	nop
     e90:	8b 45 08             	mov    0x8(%ebp),%eax
     e93:	01 c6                	add    %eax,%esi
     e95:	89 75 d4             	mov    %esi,-0x2c(%ebp)
     e98:	eb e4                	jmp    e7e <gets+0x4e>
     e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000ea0 <stat>:

int
stat(const char *n, struct stat *st)
{
     ea0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     ea1:	31 c0                	xor    %eax,%eax
{
     ea3:	89 e5                	mov    %esp,%ebp
     ea5:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
     ea8:	89 44 24 04          	mov    %eax,0x4(%esp)
     eac:	8b 45 08             	mov    0x8(%ebp),%eax
{
     eaf:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     eb2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
     eb5:	89 04 24             	mov    %eax,(%esp)
     eb8:	e8 fb 00 00 00       	call   fb8 <open>
  if(fd < 0)
     ebd:	85 c0                	test   %eax,%eax
     ebf:	78 2f                	js     ef0 <stat+0x50>
     ec1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
     ec3:	8b 45 0c             	mov    0xc(%ebp),%eax
     ec6:	89 1c 24             	mov    %ebx,(%esp)
     ec9:	89 44 24 04          	mov    %eax,0x4(%esp)
     ecd:	e8 fe 00 00 00       	call   fd0 <fstat>
  close(fd);
     ed2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     ed5:	89 c6                	mov    %eax,%esi
  close(fd);
     ed7:	e8 c4 00 00 00       	call   fa0 <close>
  return r;
}
     edc:	89 f0                	mov    %esi,%eax
     ede:	8b 5d f8             	mov    -0x8(%ebp),%ebx
     ee1:	8b 75 fc             	mov    -0x4(%ebp),%esi
     ee4:	89 ec                	mov    %ebp,%esp
     ee6:	5d                   	pop    %ebp
     ee7:	c3                   	ret    
     ee8:	90                   	nop
     ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
     ef0:	be ff ff ff ff       	mov    $0xffffffff,%esi
     ef5:	eb e5                	jmp    edc <stat+0x3c>
     ef7:	89 f6                	mov    %esi,%esi
     ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000f00 <atoi>:

int
atoi(const char *s)
{
     f00:	55                   	push   %ebp
     f01:	89 e5                	mov    %esp,%ebp
     f03:	8b 4d 08             	mov    0x8(%ebp),%ecx
     f06:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     f07:	0f be 11             	movsbl (%ecx),%edx
     f0a:	88 d0                	mov    %dl,%al
     f0c:	2c 30                	sub    $0x30,%al
     f0e:	3c 09                	cmp    $0x9,%al
  n = 0;
     f10:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
     f15:	77 1e                	ja     f35 <atoi+0x35>
     f17:	89 f6                	mov    %esi,%esi
     f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
     f20:	41                   	inc    %ecx
     f21:	8d 04 80             	lea    (%eax,%eax,4),%eax
     f24:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
     f28:	0f be 11             	movsbl (%ecx),%edx
     f2b:	88 d3                	mov    %dl,%bl
     f2d:	80 eb 30             	sub    $0x30,%bl
     f30:	80 fb 09             	cmp    $0x9,%bl
     f33:	76 eb                	jbe    f20 <atoi+0x20>
  return n;
}
     f35:	5b                   	pop    %ebx
     f36:	5d                   	pop    %ebp
     f37:	c3                   	ret    
     f38:	90                   	nop
     f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000f40 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     f40:	55                   	push   %ebp
     f41:	89 e5                	mov    %esp,%ebp
     f43:	56                   	push   %esi
     f44:	8b 45 08             	mov    0x8(%ebp),%eax
     f47:	53                   	push   %ebx
     f48:	8b 5d 10             	mov    0x10(%ebp),%ebx
     f4b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     f4e:	85 db                	test   %ebx,%ebx
     f50:	7e 1a                	jle    f6c <memmove+0x2c>
     f52:	31 d2                	xor    %edx,%edx
     f54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     f5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
     f60:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     f64:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     f67:	42                   	inc    %edx
  while(n-- > 0)
     f68:	39 d3                	cmp    %edx,%ebx
     f6a:	75 f4                	jne    f60 <memmove+0x20>
  return vdst;
}
     f6c:	5b                   	pop    %ebx
     f6d:	5e                   	pop    %esi
     f6e:	5d                   	pop    %ebp
     f6f:	c3                   	ret    

00000f70 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     f70:	b8 01 00 00 00       	mov    $0x1,%eax
     f75:	cd 40                	int    $0x40
     f77:	c3                   	ret    

00000f78 <exit>:
SYSCALL(exit)
     f78:	b8 02 00 00 00       	mov    $0x2,%eax
     f7d:	cd 40                	int    $0x40
     f7f:	c3                   	ret    

00000f80 <wait>:
SYSCALL(wait)
     f80:	b8 03 00 00 00       	mov    $0x3,%eax
     f85:	cd 40                	int    $0x40
     f87:	c3                   	ret    

00000f88 <pipe>:
SYSCALL(pipe)
     f88:	b8 04 00 00 00       	mov    $0x4,%eax
     f8d:	cd 40                	int    $0x40
     f8f:	c3                   	ret    

00000f90 <read>:
SYSCALL(read)
     f90:	b8 05 00 00 00       	mov    $0x5,%eax
     f95:	cd 40                	int    $0x40
     f97:	c3                   	ret    

00000f98 <write>:
SYSCALL(write)
     f98:	b8 10 00 00 00       	mov    $0x10,%eax
     f9d:	cd 40                	int    $0x40
     f9f:	c3                   	ret    

00000fa0 <close>:
SYSCALL(close)
     fa0:	b8 15 00 00 00       	mov    $0x15,%eax
     fa5:	cd 40                	int    $0x40
     fa7:	c3                   	ret    

00000fa8 <kill>:
SYSCALL(kill)
     fa8:	b8 06 00 00 00       	mov    $0x6,%eax
     fad:	cd 40                	int    $0x40
     faf:	c3                   	ret    

00000fb0 <exec>:
SYSCALL(exec)
     fb0:	b8 07 00 00 00       	mov    $0x7,%eax
     fb5:	cd 40                	int    $0x40
     fb7:	c3                   	ret    

00000fb8 <open>:
SYSCALL(open)
     fb8:	b8 0f 00 00 00       	mov    $0xf,%eax
     fbd:	cd 40                	int    $0x40
     fbf:	c3                   	ret    

00000fc0 <mknod>:
SYSCALL(mknod)
     fc0:	b8 11 00 00 00       	mov    $0x11,%eax
     fc5:	cd 40                	int    $0x40
     fc7:	c3                   	ret    

00000fc8 <unlink>:
SYSCALL(unlink)
     fc8:	b8 12 00 00 00       	mov    $0x12,%eax
     fcd:	cd 40                	int    $0x40
     fcf:	c3                   	ret    

00000fd0 <fstat>:
SYSCALL(fstat)
     fd0:	b8 08 00 00 00       	mov    $0x8,%eax
     fd5:	cd 40                	int    $0x40
     fd7:	c3                   	ret    

00000fd8 <link>:
SYSCALL(link)
     fd8:	b8 13 00 00 00       	mov    $0x13,%eax
     fdd:	cd 40                	int    $0x40
     fdf:	c3                   	ret    

00000fe0 <mkdir>:
SYSCALL(mkdir)
     fe0:	b8 14 00 00 00       	mov    $0x14,%eax
     fe5:	cd 40                	int    $0x40
     fe7:	c3                   	ret    

00000fe8 <chdir>:
SYSCALL(chdir)
     fe8:	b8 09 00 00 00       	mov    $0x9,%eax
     fed:	cd 40                	int    $0x40
     fef:	c3                   	ret    

00000ff0 <dup>:
SYSCALL(dup)
     ff0:	b8 0a 00 00 00       	mov    $0xa,%eax
     ff5:	cd 40                	int    $0x40
     ff7:	c3                   	ret    

00000ff8 <getpid>:
SYSCALL(getpid)
     ff8:	b8 0b 00 00 00       	mov    $0xb,%eax
     ffd:	cd 40                	int    $0x40
     fff:	c3                   	ret    

00001000 <sbrk>:
SYSCALL(sbrk)
    1000:	b8 0c 00 00 00       	mov    $0xc,%eax
    1005:	cd 40                	int    $0x40
    1007:	c3                   	ret    

00001008 <sleep>:
SYSCALL(sleep)
    1008:	b8 0d 00 00 00       	mov    $0xd,%eax
    100d:	cd 40                	int    $0x40
    100f:	c3                   	ret    

00001010 <uptime>:
SYSCALL(uptime)
    1010:	b8 0e 00 00 00       	mov    $0xe,%eax
    1015:	cd 40                	int    $0x40
    1017:	c3                   	ret    

00001018 <policy>:
SYSCALL(policy)
    1018:	b8 17 00 00 00       	mov    $0x17,%eax
    101d:	cd 40                	int    $0x40
    101f:	c3                   	ret    

00001020 <detach>:
SYSCALL(detach)
    1020:	b8 16 00 00 00       	mov    $0x16,%eax
    1025:	cd 40                	int    $0x40
    1027:	c3                   	ret    

00001028 <priority>:
SYSCALL(priority)
    1028:	b8 18 00 00 00       	mov    $0x18,%eax
    102d:	cd 40                	int    $0x40
    102f:	c3                   	ret    

00001030 <wait_stat>:
SYSCALL(wait_stat)
    1030:	b8 19 00 00 00       	mov    $0x19,%eax
    1035:	cd 40                	int    $0x40
    1037:	c3                   	ret    
    1038:	66 90                	xchg   %ax,%ax
    103a:	66 90                	xchg   %ax,%ax
    103c:	66 90                	xchg   %ax,%ax
    103e:	66 90                	xchg   %ax,%ax

00001040 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1040:	55                   	push   %ebp
    1041:	89 e5                	mov    %esp,%ebp
    1043:	57                   	push   %edi
    1044:	56                   	push   %esi
    1045:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1046:	89 d3                	mov    %edx,%ebx
    1048:	c1 eb 1f             	shr    $0x1f,%ebx
{
    104b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
    104e:	84 db                	test   %bl,%bl
{
    1050:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1053:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    1055:	74 79                	je     10d0 <printint+0x90>
    1057:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    105b:	74 73                	je     10d0 <printint+0x90>
    neg = 1;
    x = -xx;
    105d:	f7 d8                	neg    %eax
    neg = 1;
    105f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1066:	31 f6                	xor    %esi,%esi
    1068:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    106b:	eb 05                	jmp    1072 <printint+0x32>
    106d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1070:	89 fe                	mov    %edi,%esi
    1072:	31 d2                	xor    %edx,%edx
    1074:	f7 f1                	div    %ecx
    1076:	8d 7e 01             	lea    0x1(%esi),%edi
    1079:	0f b6 92 dc 18 00 00 	movzbl 0x18dc(%edx),%edx
  }while((x /= base) != 0);
    1080:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    1082:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    1085:	75 e9                	jne    1070 <printint+0x30>
  if(neg)
    1087:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    108a:	85 d2                	test   %edx,%edx
    108c:	74 08                	je     1096 <printint+0x56>
    buf[i++] = '-';
    108e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    1093:	8d 7e 02             	lea    0x2(%esi),%edi
    1096:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    109a:	8b 7d c0             	mov    -0x40(%ebp),%edi
    109d:	8d 76 00             	lea    0x0(%esi),%esi
    10a0:	0f b6 06             	movzbl (%esi),%eax
    10a3:	4e                   	dec    %esi
  write(fd, &c, 1);
    10a4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    10a8:	89 3c 24             	mov    %edi,(%esp)
    10ab:	88 45 d7             	mov    %al,-0x29(%ebp)
    10ae:	b8 01 00 00 00       	mov    $0x1,%eax
    10b3:	89 44 24 08          	mov    %eax,0x8(%esp)
    10b7:	e8 dc fe ff ff       	call   f98 <write>

  while(--i >= 0)
    10bc:	39 de                	cmp    %ebx,%esi
    10be:	75 e0                	jne    10a0 <printint+0x60>
    putc(fd, buf[i]);
}
    10c0:	83 c4 4c             	add    $0x4c,%esp
    10c3:	5b                   	pop    %ebx
    10c4:	5e                   	pop    %esi
    10c5:	5f                   	pop    %edi
    10c6:	5d                   	pop    %ebp
    10c7:	c3                   	ret    
    10c8:	90                   	nop
    10c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    10d0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    10d7:	eb 8d                	jmp    1066 <printint+0x26>
    10d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000010e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    10e0:	55                   	push   %ebp
    10e1:	89 e5                	mov    %esp,%ebp
    10e3:	57                   	push   %edi
    10e4:	56                   	push   %esi
    10e5:	53                   	push   %ebx
    10e6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    10e9:	8b 75 0c             	mov    0xc(%ebp),%esi
    10ec:	0f b6 1e             	movzbl (%esi),%ebx
    10ef:	84 db                	test   %bl,%bl
    10f1:	0f 84 d1 00 00 00    	je     11c8 <printf+0xe8>
  state = 0;
    10f7:	31 ff                	xor    %edi,%edi
    10f9:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
    10fa:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
    10fd:	89 fa                	mov    %edi,%edx
    10ff:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
    1102:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1105:	eb 41                	jmp    1148 <printf+0x68>
    1107:	89 f6                	mov    %esi,%esi
    1109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1110:	83 f8 25             	cmp    $0x25,%eax
    1113:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
    1116:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    111b:	74 1e                	je     113b <printf+0x5b>
  write(fd, &c, 1);
    111d:	b8 01 00 00 00       	mov    $0x1,%eax
    1122:	89 44 24 08          	mov    %eax,0x8(%esp)
    1126:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1129:	89 44 24 04          	mov    %eax,0x4(%esp)
    112d:	89 3c 24             	mov    %edi,(%esp)
    1130:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    1133:	e8 60 fe ff ff       	call   f98 <write>
    1138:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    113b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
    113c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    1140:	84 db                	test   %bl,%bl
    1142:	0f 84 80 00 00 00    	je     11c8 <printf+0xe8>
    if(state == 0){
    1148:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
    114a:	0f be cb             	movsbl %bl,%ecx
    114d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1150:	74 be                	je     1110 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1152:	83 fa 25             	cmp    $0x25,%edx
    1155:	75 e4                	jne    113b <printf+0x5b>
      if(c == 'd'){
    1157:	83 f8 64             	cmp    $0x64,%eax
    115a:	0f 84 f0 00 00 00    	je     1250 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1160:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    1166:	83 f9 70             	cmp    $0x70,%ecx
    1169:	74 65                	je     11d0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    116b:	83 f8 73             	cmp    $0x73,%eax
    116e:	0f 84 8c 00 00 00    	je     1200 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1174:	83 f8 63             	cmp    $0x63,%eax
    1177:	0f 84 13 01 00 00    	je     1290 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    117d:	83 f8 25             	cmp    $0x25,%eax
    1180:	0f 84 e2 00 00 00    	je     1268 <printf+0x188>
  write(fd, &c, 1);
    1186:	b8 01 00 00 00       	mov    $0x1,%eax
    118b:	46                   	inc    %esi
    118c:	89 44 24 08          	mov    %eax,0x8(%esp)
    1190:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1193:	89 44 24 04          	mov    %eax,0x4(%esp)
    1197:	89 3c 24             	mov    %edi,(%esp)
    119a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    119e:	e8 f5 fd ff ff       	call   f98 <write>
    11a3:	ba 01 00 00 00       	mov    $0x1,%edx
    11a8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    11ab:	89 54 24 08          	mov    %edx,0x8(%esp)
    11af:	89 44 24 04          	mov    %eax,0x4(%esp)
    11b3:	89 3c 24             	mov    %edi,(%esp)
    11b6:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    11b9:	e8 da fd ff ff       	call   f98 <write>
  for(i = 0; fmt[i]; i++){
    11be:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    11c2:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    11c4:	84 db                	test   %bl,%bl
    11c6:	75 80                	jne    1148 <printf+0x68>
    }
  }
}
    11c8:	83 c4 3c             	add    $0x3c,%esp
    11cb:	5b                   	pop    %ebx
    11cc:	5e                   	pop    %esi
    11cd:	5f                   	pop    %edi
    11ce:	5d                   	pop    %ebp
    11cf:	c3                   	ret    
        printint(fd, *ap, 16, 0);
    11d0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    11d7:	b9 10 00 00 00       	mov    $0x10,%ecx
    11dc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    11df:	89 f8                	mov    %edi,%eax
    11e1:	8b 13                	mov    (%ebx),%edx
    11e3:	e8 58 fe ff ff       	call   1040 <printint>
        ap++;
    11e8:	89 d8                	mov    %ebx,%eax
      state = 0;
    11ea:	31 d2                	xor    %edx,%edx
        ap++;
    11ec:	83 c0 04             	add    $0x4,%eax
    11ef:	89 45 d0             	mov    %eax,-0x30(%ebp)
    11f2:	e9 44 ff ff ff       	jmp    113b <printf+0x5b>
    11f7:	89 f6                	mov    %esi,%esi
    11f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
    1200:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1203:	8b 10                	mov    (%eax),%edx
        ap++;
    1205:	83 c0 04             	add    $0x4,%eax
    1208:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    120b:	85 d2                	test   %edx,%edx
    120d:	0f 84 aa 00 00 00    	je     12bd <printf+0x1dd>
        while(*s != 0){
    1213:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
    1216:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
    1218:	84 c0                	test   %al,%al
    121a:	74 27                	je     1243 <printf+0x163>
    121c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1220:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    1223:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
    1228:	43                   	inc    %ebx
  write(fd, &c, 1);
    1229:	89 44 24 08          	mov    %eax,0x8(%esp)
    122d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    1230:	89 44 24 04          	mov    %eax,0x4(%esp)
    1234:	89 3c 24             	mov    %edi,(%esp)
    1237:	e8 5c fd ff ff       	call   f98 <write>
        while(*s != 0){
    123c:	0f b6 03             	movzbl (%ebx),%eax
    123f:	84 c0                	test   %al,%al
    1241:	75 dd                	jne    1220 <printf+0x140>
      state = 0;
    1243:	31 d2                	xor    %edx,%edx
    1245:	e9 f1 fe ff ff       	jmp    113b <printf+0x5b>
    124a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    1250:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1257:	b9 0a 00 00 00       	mov    $0xa,%ecx
    125c:	e9 7b ff ff ff       	jmp    11dc <printf+0xfc>
    1261:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
    1268:	b9 01 00 00 00       	mov    $0x1,%ecx
    126d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1270:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    1274:	89 44 24 04          	mov    %eax,0x4(%esp)
    1278:	89 3c 24             	mov    %edi,(%esp)
    127b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    127e:	e8 15 fd ff ff       	call   f98 <write>
      state = 0;
    1283:	31 d2                	xor    %edx,%edx
    1285:	e9 b1 fe ff ff       	jmp    113b <printf+0x5b>
    128a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
    1290:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    1293:	8b 03                	mov    (%ebx),%eax
        ap++;
    1295:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    1298:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
    129b:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    129e:	b8 01 00 00 00       	mov    $0x1,%eax
    12a3:	89 44 24 08          	mov    %eax,0x8(%esp)
    12a7:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    12aa:	89 44 24 04          	mov    %eax,0x4(%esp)
    12ae:	e8 e5 fc ff ff       	call   f98 <write>
      state = 0;
    12b3:	31 d2                	xor    %edx,%edx
        ap++;
    12b5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    12b8:	e9 7e fe ff ff       	jmp    113b <printf+0x5b>
          s = "(null)";
    12bd:	bb d4 18 00 00       	mov    $0x18d4,%ebx
        while(*s != 0){
    12c2:	b0 28                	mov    $0x28,%al
    12c4:	e9 57 ff ff ff       	jmp    1220 <printf+0x140>
    12c9:	66 90                	xchg   %ax,%ax
    12cb:	66 90                	xchg   %ax,%ax
    12cd:	66 90                	xchg   %ax,%ax
    12cf:	90                   	nop

000012d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    12d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    12d1:	a1 bc 1e 00 00       	mov    0x1ebc,%eax
{
    12d6:	89 e5                	mov    %esp,%ebp
    12d8:	57                   	push   %edi
    12d9:	56                   	push   %esi
    12da:	53                   	push   %ebx
    12db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    12de:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    12e1:	eb 0d                	jmp    12f0 <free+0x20>
    12e3:	90                   	nop
    12e4:	90                   	nop
    12e5:	90                   	nop
    12e6:	90                   	nop
    12e7:	90                   	nop
    12e8:	90                   	nop
    12e9:	90                   	nop
    12ea:	90                   	nop
    12eb:	90                   	nop
    12ec:	90                   	nop
    12ed:	90                   	nop
    12ee:	90                   	nop
    12ef:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    12f0:	39 c8                	cmp    %ecx,%eax
    12f2:	8b 10                	mov    (%eax),%edx
    12f4:	73 32                	jae    1328 <free+0x58>
    12f6:	39 d1                	cmp    %edx,%ecx
    12f8:	72 04                	jb     12fe <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    12fa:	39 d0                	cmp    %edx,%eax
    12fc:	72 32                	jb     1330 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
    12fe:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1301:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1304:	39 fa                	cmp    %edi,%edx
    1306:	74 30                	je     1338 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1308:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    130b:	8b 50 04             	mov    0x4(%eax),%edx
    130e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1311:	39 f1                	cmp    %esi,%ecx
    1313:	74 3c                	je     1351 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1315:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
    1317:	5b                   	pop    %ebx
  freep = p;
    1318:	a3 bc 1e 00 00       	mov    %eax,0x1ebc
}
    131d:	5e                   	pop    %esi
    131e:	5f                   	pop    %edi
    131f:	5d                   	pop    %ebp
    1320:	c3                   	ret    
    1321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1328:	39 d0                	cmp    %edx,%eax
    132a:	72 04                	jb     1330 <free+0x60>
    132c:	39 d1                	cmp    %edx,%ecx
    132e:	72 ce                	jb     12fe <free+0x2e>
{
    1330:	89 d0                	mov    %edx,%eax
    1332:	eb bc                	jmp    12f0 <free+0x20>
    1334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1338:	8b 7a 04             	mov    0x4(%edx),%edi
    133b:	01 fe                	add    %edi,%esi
    133d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1340:	8b 10                	mov    (%eax),%edx
    1342:	8b 12                	mov    (%edx),%edx
    1344:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1347:	8b 50 04             	mov    0x4(%eax),%edx
    134a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    134d:	39 f1                	cmp    %esi,%ecx
    134f:	75 c4                	jne    1315 <free+0x45>
    p->s.size += bp->s.size;
    1351:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
    1354:	a3 bc 1e 00 00       	mov    %eax,0x1ebc
    p->s.size += bp->s.size;
    1359:	01 ca                	add    %ecx,%edx
    135b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    135e:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1361:	89 10                	mov    %edx,(%eax)
}
    1363:	5b                   	pop    %ebx
    1364:	5e                   	pop    %esi
    1365:	5f                   	pop    %edi
    1366:	5d                   	pop    %ebp
    1367:	c3                   	ret    
    1368:	90                   	nop
    1369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001370 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1370:	55                   	push   %ebp
    1371:	89 e5                	mov    %esp,%ebp
    1373:	57                   	push   %edi
    1374:	56                   	push   %esi
    1375:	53                   	push   %ebx
    1376:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1379:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    137c:	8b 15 bc 1e 00 00    	mov    0x1ebc,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1382:	8d 78 07             	lea    0x7(%eax),%edi
    1385:	c1 ef 03             	shr    $0x3,%edi
    1388:	47                   	inc    %edi
  if((prevp = freep) == 0){
    1389:	85 d2                	test   %edx,%edx
    138b:	0f 84 8f 00 00 00    	je     1420 <malloc+0xb0>
    1391:	8b 02                	mov    (%edx),%eax
    1393:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1396:	39 cf                	cmp    %ecx,%edi
    1398:	76 66                	jbe    1400 <malloc+0x90>
    139a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    13a0:	bb 00 10 00 00       	mov    $0x1000,%ebx
    13a5:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    13a8:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    13af:	eb 10                	jmp    13c1 <malloc+0x51>
    13b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    13b8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    13ba:	8b 48 04             	mov    0x4(%eax),%ecx
    13bd:	39 f9                	cmp    %edi,%ecx
    13bf:	73 3f                	jae    1400 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    13c1:	39 05 bc 1e 00 00    	cmp    %eax,0x1ebc
    13c7:	89 c2                	mov    %eax,%edx
    13c9:	75 ed                	jne    13b8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    13cb:	89 34 24             	mov    %esi,(%esp)
    13ce:	e8 2d fc ff ff       	call   1000 <sbrk>
  if(p == (char*)-1)
    13d3:	83 f8 ff             	cmp    $0xffffffff,%eax
    13d6:	74 18                	je     13f0 <malloc+0x80>
  hp->s.size = nu;
    13d8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    13db:	83 c0 08             	add    $0x8,%eax
    13de:	89 04 24             	mov    %eax,(%esp)
    13e1:	e8 ea fe ff ff       	call   12d0 <free>
  return freep;
    13e6:	8b 15 bc 1e 00 00    	mov    0x1ebc,%edx
      if((p = morecore(nunits)) == 0)
    13ec:	85 d2                	test   %edx,%edx
    13ee:	75 c8                	jne    13b8 <malloc+0x48>
        return 0;
  }
}
    13f0:	83 c4 1c             	add    $0x1c,%esp
        return 0;
    13f3:	31 c0                	xor    %eax,%eax
}
    13f5:	5b                   	pop    %ebx
    13f6:	5e                   	pop    %esi
    13f7:	5f                   	pop    %edi
    13f8:	5d                   	pop    %ebp
    13f9:	c3                   	ret    
    13fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1400:	39 cf                	cmp    %ecx,%edi
    1402:	74 4c                	je     1450 <malloc+0xe0>
        p->s.size -= nunits;
    1404:	29 f9                	sub    %edi,%ecx
    1406:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1409:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    140c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    140f:	89 15 bc 1e 00 00    	mov    %edx,0x1ebc
}
    1415:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
    1418:	83 c0 08             	add    $0x8,%eax
}
    141b:	5b                   	pop    %ebx
    141c:	5e                   	pop    %esi
    141d:	5f                   	pop    %edi
    141e:	5d                   	pop    %ebp
    141f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    1420:	b8 c0 1e 00 00       	mov    $0x1ec0,%eax
    1425:	ba c0 1e 00 00       	mov    $0x1ec0,%edx
    base.s.size = 0;
    142a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
    142c:	a3 bc 1e 00 00       	mov    %eax,0x1ebc
    base.s.size = 0;
    1431:	b8 c0 1e 00 00       	mov    $0x1ec0,%eax
    base.s.ptr = freep = prevp = &base;
    1436:	89 15 c0 1e 00 00    	mov    %edx,0x1ec0
    base.s.size = 0;
    143c:	89 0d c4 1e 00 00    	mov    %ecx,0x1ec4
    1442:	e9 53 ff ff ff       	jmp    139a <malloc+0x2a>
    1447:	89 f6                	mov    %esi,%esi
    1449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
    1450:	8b 08                	mov    (%eax),%ecx
    1452:	89 0a                	mov    %ecx,(%edx)
    1454:	eb b9                	jmp    140f <malloc+0x9f>
