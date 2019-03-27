
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
       1:	b8 10 16 00 00       	mov    $0x1610,%eax
int main(int argc, char *argv[]){
       6:	89 e5                	mov    %esp,%ebp
       8:	56                   	push   %esi
       9:	53                   	push   %ebx
       a:	83 e4 f0             	and    $0xfffffff0,%esp
       d:	83 ec 20             	sub    $0x20,%esp
    printf(1,"opening path\n");
      10:	89 44 24 04          	mov    %eax,0x4(%esp)
      14:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      1b:	e8 a0 11 00 00       	call   11c0 <printf>
    fd = open("/path",O_WRONLY);
      20:	ba 01 00 00 00       	mov    $0x1,%edx
      25:	89 54 24 04          	mov    %edx,0x4(%esp)
      29:	c7 04 24 d2 16 00 00 	movl   $0x16d2,(%esp)
      30:	e8 63 10 00 00       	call   1098 <open>

    if(fd < 0){
      35:	85 c0                	test   %eax,%eax
      37:	0f 88 91 04 00 00    	js     4ce <main+0x4ce>
        exit(0);
    }

    const char * path = "/:/bin/:/hello/world/path/:/under/world/path";

    printf(1,"writing to path\n");
      3d:	c7 44 24 04 3a 16 00 	movl   $0x163a,0x4(%esp)
      44:	00 
      45:	89 c3                	mov    %eax,%ebx
      47:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      4e:	e8 6d 11 00 00       	call   11c0 <printf>
    writed = write(fd,path,strlen(path));
      53:	c7 04 24 e4 18 00 00 	movl   $0x18e4,(%esp)
      5a:	e8 31 0e 00 00       	call   e90 <strlen>
      5f:	c7 44 24 04 e4 18 00 	movl   $0x18e4,0x4(%esp)
      66:	00 
      67:	89 1c 24             	mov    %ebx,(%esp)
      6a:	89 44 24 08          	mov    %eax,0x8(%esp)
      6e:	e8 05 10 00 00       	call   1078 <write>

    if(writed != strlen(path)){
      73:	c7 04 24 e4 18 00 00 	movl   $0x18e4,(%esp)
    writed = write(fd,path,strlen(path));
      7a:	89 c6                	mov    %eax,%esi
    if(writed != strlen(path)){
      7c:	e8 0f 0e 00 00       	call   e90 <strlen>
      81:	39 f0                	cmp    %esi,%eax
      83:	0f 85 28 04 00 00    	jne    4b1 <main+0x4b1>
        printf(1,"error in writing to path, %d were written\n",writed);
    }

    printf(1,"closing path file\n");
      89:	c7 44 24 04 4b 16 00 	movl   $0x164b,0x4(%esp)
      90:	00 
      91:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      98:	e8 23 11 00 00       	call   11c0 <printf>
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
      a4:	e8 d7 0f 00 00       	call   1080 <close>
    printf(1,"creating /bin/ path\n");
      a9:	c7 44 24 04 5e 16 00 	movl   $0x165e,0x4(%esp)
      b0:	00 
      b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      b8:	e8 03 11 00 00       	call   11c0 <printf>
    execute(command,args);
      bd:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      c1:	c7 04 24 73 16 00 00 	movl   $0x1673,(%esp)
    args[0] = "/mkdir";
      c8:	c7 44 24 10 73 16 00 	movl   $0x1673,0x10(%esp)
      cf:	00 
    args[1] = "/bin/";
      d0:	c7 44 24 14 7a 16 00 	movl   $0x167a,0x14(%esp)
      d7:	00 
    args[2] = 0;
      d8:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
      df:	00 
    execute(command,args);
      e0:	e8 0b 04 00 00       	call   4f0 <execute>

    printf(1,"creating /hello path\n");
      e5:	c7 44 24 04 80 16 00 	movl   $0x1680,0x4(%esp)
      ec:	00 
      ed:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      f4:	e8 c7 10 00 00       	call   11c0 <printf>
    args[0] = "/mkdir";
    args[1] = "/hello";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);
      f9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      fd:	c7 04 24 73 16 00 00 	movl   $0x1673,(%esp)
    args[0] = "/mkdir";
     104:	c7 44 24 10 73 16 00 	movl   $0x1673,0x10(%esp)
     10b:	00 
    args[1] = "/hello";
     10c:	c7 44 24 14 96 16 00 	movl   $0x1696,0x14(%esp)
     113:	00 
    args[2] = 0;
     114:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
     11b:	00 
    execute(command,args);
     11c:	e8 cf 03 00 00       	call   4f0 <execute>

    printf(1,"creating /hello/world path\n");
     121:	c7 44 24 04 9d 16 00 	movl   $0x169d,0x4(%esp)
     128:	00 
     129:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     130:	e8 8b 10 00 00       	call   11c0 <printf>
    args[0] = "/mkdir";
    args[1] = "/hello/world";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);
     135:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     139:	c7 04 24 73 16 00 00 	movl   $0x1673,(%esp)
    args[0] = "/mkdir";
     140:	c7 44 24 10 73 16 00 	movl   $0x1673,0x10(%esp)
     147:	00 
    args[1] = "/hello/world";
     148:	c7 44 24 14 b9 16 00 	movl   $0x16b9,0x14(%esp)
     14f:	00 
    args[2] = 0;
     150:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
     157:	00 
    execute(command,args);
     158:	e8 93 03 00 00       	call   4f0 <execute>

    printf(1,"creating /hello/world/path path\n");
     15d:	c7 44 24 04 40 19 00 	movl   $0x1940,0x4(%esp)
     164:	00 
     165:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     16c:	e8 4f 10 00 00       	call   11c0 <printf>
    args[0] = "/mkdir";
    args[1] = "/hello/world/path";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);
     171:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     175:	c7 04 24 73 16 00 00 	movl   $0x1673,(%esp)
    args[0] = "/mkdir";
     17c:	c7 44 24 10 73 16 00 	movl   $0x1673,0x10(%esp)
     183:	00 
    args[1] = "/hello/world/path";
     184:	c7 44 24 14 c6 16 00 	movl   $0x16c6,0x14(%esp)
     18b:	00 
    args[2] = 0;
     18c:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
     193:	00 
    execute(command,args);
     194:	e8 57 03 00 00       	call   4f0 <execute>

    printf(1,"creating /under path\n");
     199:	c7 44 24 04 d8 16 00 	movl   $0x16d8,0x4(%esp)
     1a0:	00 
     1a1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     1a8:	e8 13 10 00 00       	call   11c0 <printf>
    args[0] = "/mkdir";
    args[1] = "/under";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);
     1ad:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     1b1:	c7 04 24 73 16 00 00 	movl   $0x1673,(%esp)
    args[0] = "/mkdir";
     1b8:	c7 44 24 10 73 16 00 	movl   $0x1673,0x10(%esp)
     1bf:	00 
    args[1] = "/under";
     1c0:	c7 44 24 14 ee 16 00 	movl   $0x16ee,0x14(%esp)
     1c7:	00 
    args[2] = 0;
     1c8:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
     1cf:	00 
    execute(command,args);
     1d0:	e8 1b 03 00 00       	call   4f0 <execute>

    printf(1,"creating /under/world path\n");
     1d5:	c7 44 24 04 f5 16 00 	movl   $0x16f5,0x4(%esp)
     1dc:	00 
     1dd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     1e4:	e8 d7 0f 00 00       	call   11c0 <printf>
    args[0] = "/mkdir";
    args[1] = "/under/world";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);
     1e9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     1ed:	c7 04 24 73 16 00 00 	movl   $0x1673,(%esp)
    args[0] = "/mkdir";
     1f4:	c7 44 24 10 73 16 00 	movl   $0x1673,0x10(%esp)
     1fb:	00 
    args[1] = "/under/world";
     1fc:	c7 44 24 14 11 17 00 	movl   $0x1711,0x14(%esp)
     203:	00 
    args[2] = 0;
     204:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
     20b:	00 
    execute(command,args);
     20c:	e8 df 02 00 00       	call   4f0 <execute>

    printf(1,"creating /under/world/path path\n");
     211:	c7 44 24 04 64 19 00 	movl   $0x1964,0x4(%esp)
     218:	00 
     219:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     220:	e8 9b 0f 00 00       	call   11c0 <printf>
    args[0] = "/mkdir";
    args[1] = "/under/world/path";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);
     225:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     229:	c7 04 24 73 16 00 00 	movl   $0x1673,(%esp)
    args[0] = "/mkdir";
     230:	c7 44 24 10 73 16 00 	movl   $0x1673,0x10(%esp)
     237:	00 
    args[1] = "/under/world/path";
     238:	c7 44 24 14 1e 17 00 	movl   $0x171e,0x14(%esp)
     23f:	00 
    args[2] = 0;
     240:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
     247:	00 
    execute(command,args);
     248:	e8 a3 02 00 00       	call   4f0 <execute>

    printf(1,"creating /notIn path\n");
     24d:	c7 44 24 04 30 17 00 	movl   $0x1730,0x4(%esp)
     254:	00 
     255:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     25c:	e8 5f 0f 00 00       	call   11c0 <printf>
    args[0] = "/mkdir";
    args[1] = "/notIn";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);
     261:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     265:	c7 04 24 73 16 00 00 	movl   $0x1673,(%esp)
    args[0] = "/mkdir";
     26c:	c7 44 24 10 73 16 00 	movl   $0x1673,0x10(%esp)
     273:	00 
    args[1] = "/notIn";
     274:	c7 44 24 14 46 17 00 	movl   $0x1746,0x14(%esp)
     27b:	00 
    args[2] = 0;
     27c:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
     283:	00 
    execute(command,args);
     284:	e8 67 02 00 00       	call   4f0 <execute>

    printf(1,"creating /notIn/path path\n");
     289:	c7 44 24 04 4d 17 00 	movl   $0x174d,0x4(%esp)
     290:	00 
     291:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     298:	e8 23 0f 00 00       	call   11c0 <printf>
    args[0] = "/mkdir";
    args[1] = "/notIn/path";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);
     29d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     2a1:	c7 04 24 73 16 00 00 	movl   $0x1673,(%esp)
    args[0] = "/mkdir";
     2a8:	c7 44 24 10 73 16 00 	movl   $0x1673,0x10(%esp)
     2af:	00 
    args[1] = "/notIn/path";
     2b0:	c7 44 24 14 68 17 00 	movl   $0x1768,0x14(%esp)
     2b7:	00 
    args[2] = 0;
     2b8:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
     2bf:	00 
    execute(command,args);
     2c0:	e8 2b 02 00 00       	call   4f0 <execute>

    printf(1,"##################exiting\n");
     2c5:	c7 44 24 04 74 17 00 	movl   $0x1774,0x4(%esp)
     2cc:	00 
     2cd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     2d4:	e8 e7 0e 00 00       	call   11c0 <printf>


    printf(1,"copying cat to /notIn/path/cat\n");
     2d9:	c7 44 24 04 88 19 00 	movl   $0x1988,0x4(%esp)
     2e0:	00 
     2e1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     2e8:	e8 d3 0e 00 00       	call   11c0 <printf>
    args[0] = "/ln";
    args[1] = "/cat";
    args[2] = "/notIn/path/cat";
    args[3] = 0;
    command = "/ln";
    execute(command,args);
     2ed:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     2f1:	c7 04 24 8f 17 00 00 	movl   $0x178f,(%esp)
    args[0] = "/ln";
     2f8:	c7 44 24 10 8f 17 00 	movl   $0x178f,0x10(%esp)
     2ff:	00 
    args[1] = "/cat";
     300:	c7 44 24 14 9e 17 00 	movl   $0x179e,0x14(%esp)
     307:	00 
    args[2] = "/notIn/path/cat";
     308:	c7 44 24 18 93 17 00 	movl   $0x1793,0x18(%esp)
     30f:	00 
    args[3] = 0;
     310:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
     317:	00 
    execute(command,args);
     318:	e8 d3 01 00 00       	call   4f0 <execute>

    printf(1,"copying echo to /notIn/path/echo\n");
     31d:	c7 44 24 04 a8 19 00 	movl   $0x19a8,0x4(%esp)
     324:	00 
     325:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     32c:	e8 8f 0e 00 00       	call   11c0 <printf>
    args[0] = "/ln";
    args[1] = "/echo";
    args[2] = "/notIn/path/echo";
    args[3] = 0;
    command = "/ln";
    execute(command,args);
     331:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     335:	c7 04 24 8f 17 00 00 	movl   $0x178f,(%esp)
    args[0] = "/ln";
     33c:	c7 44 24 10 8f 17 00 	movl   $0x178f,0x10(%esp)
     343:	00 
    args[1] = "/echo";
     344:	c7 44 24 14 f1 17 00 	movl   $0x17f1,0x14(%esp)
     34b:	00 
    args[2] = "/notIn/path/echo";
     34c:	c7 44 24 18 a3 17 00 	movl   $0x17a3,0x18(%esp)
     353:	00 
    args[3] = 0;
     354:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
     35b:	00 
    execute(command,args);
     35c:	e8 8f 01 00 00       	call   4f0 <execute>

    printf(1,"removing /cat\n");
     361:	c7 44 24 04 b4 17 00 	movl   $0x17b4,0x4(%esp)
     368:	00 
     369:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     370:	e8 4b 0e 00 00       	call   11c0 <printf>
    args[0] = "/rm";
    args[1] = "/cat";
    args[2] = 0;
    command = "/rm";
    execute(command,args);
     375:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     379:	c7 04 24 c3 17 00 00 	movl   $0x17c3,(%esp)
    args[0] = "/rm";
     380:	c7 44 24 10 c3 17 00 	movl   $0x17c3,0x10(%esp)
     387:	00 
    args[1] = "/cat";
     388:	c7 44 24 14 9e 17 00 	movl   $0x179e,0x14(%esp)
     38f:	00 
    args[2] = 0;
     390:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
     397:	00 
    execute(command,args);
     398:	e8 53 01 00 00       	call   4f0 <execute>

    printf(1,"removing /echo\n");
     39d:	c7 44 24 04 c7 17 00 	movl   $0x17c7,0x4(%esp)
     3a4:	00 
     3a5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     3ac:	e8 0f 0e 00 00       	call   11c0 <printf>
    args[0] = "/rm";
    args[1] = "/echo";
    args[2] = 0;
    command = "/rm";
    execute(command,args);
     3b1:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     3b5:	c7 04 24 c3 17 00 00 	movl   $0x17c3,(%esp)
    args[0] = "/rm";
     3bc:	c7 44 24 10 c3 17 00 	movl   $0x17c3,0x10(%esp)
     3c3:	00 
    args[1] = "/echo";
     3c4:	c7 44 24 14 f1 17 00 	movl   $0x17f1,0x14(%esp)
     3cb:	00 
    args[2] = 0;
     3cc:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
     3d3:	00 
    execute(command,args);
     3d4:	e8 17 01 00 00       	call   4f0 <execute>

    printf(1,"########\tremoved cat+echo from root\t###################\n");
     3d9:	c7 44 24 04 cc 19 00 	movl   $0x19cc,0x4(%esp)
     3e0:	00 
     3e1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     3e8:	e8 d3 0d 00 00       	call   11c0 <printf>

    printf(1,"copying /notIn/path/cat to /bin/cat\n");
     3ed:	c7 44 24 04 08 1a 00 	movl   $0x1a08,0x4(%esp)
     3f4:	00 
     3f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     3fc:	e8 bf 0d 00 00       	call   11c0 <printf>
    args[0] = "/ln";
    args[1] = "/notIn/path/cat";
    args[2] = "/bin/cat";
    args[3] = 0;
    command = "/ln";
    execute(command,args);
     401:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     405:	c7 04 24 8f 17 00 00 	movl   $0x178f,(%esp)
    args[0] = "/ln";
     40c:	c7 44 24 10 8f 17 00 	movl   $0x178f,0x10(%esp)
     413:	00 
    args[1] = "/notIn/path/cat";
     414:	c7 44 24 14 93 17 00 	movl   $0x1793,0x14(%esp)
     41b:	00 
    args[2] = "/bin/cat";
     41c:	c7 44 24 18 d7 17 00 	movl   $0x17d7,0x18(%esp)
     423:	00 
    args[3] = 0;
     424:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
     42b:	00 
    execute(command,args);
     42c:	e8 bf 00 00 00       	call   4f0 <execute>

    printf(1,"copying /notIn/path/echo to /hello/world/path/echo\n");
     431:	c7 44 24 04 30 1a 00 	movl   $0x1a30,0x4(%esp)
     438:	00 
     439:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     440:	e8 7b 0d 00 00       	call   11c0 <printf>
    args[0] = "/ln";
    args[1] = "notIn/path/echo";
    args[2] = "/hello/world/path/echo";
    args[3] = 0;
    command = "/ln";
    execute(command,args);
     445:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     449:	c7 04 24 8f 17 00 00 	movl   $0x178f,(%esp)
    args[0] = "/ln";
     450:	c7 44 24 10 8f 17 00 	movl   $0x178f,0x10(%esp)
     457:	00 
    args[1] = "notIn/path/echo";
     458:	c7 44 24 14 a4 17 00 	movl   $0x17a4,0x14(%esp)
     45f:	00 
    args[2] = "/hello/world/path/echo";
     460:	c7 44 24 18 e0 17 00 	movl   $0x17e0,0x18(%esp)
     467:	00 
    args[3] = 0;
     468:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
     46f:	00 
    execute(command,args);
     470:	e8 7b 00 00 00       	call   4f0 <execute>

    printf(1,"exiting\n");
     475:	c7 44 24 04 86 17 00 	movl   $0x1786,0x4(%esp)
     47c:	00 
     47d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     484:	e8 37 0d 00 00       	call   11c0 <printf>
    printf(2,"path= %s\n",path);
     489:	c7 44 24 08 e4 18 00 	movl   $0x18e4,0x8(%esp)
     490:	00 
     491:	c7 44 24 04 f7 17 00 	movl   $0x17f7,0x4(%esp)
     498:	00 
     499:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     4a0:	e8 1b 0d 00 00       	call   11c0 <printf>





    exit(0);
     4a5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     4ac:	e8 a7 0b 00 00       	call   1058 <exit>
        printf(1,"error in writing to path, %d were written\n",writed);
     4b1:	89 74 24 08          	mov    %esi,0x8(%esp)
     4b5:	c7 44 24 04 14 19 00 	movl   $0x1914,0x4(%esp)
     4bc:	00 
     4bd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     4c4:	e8 f7 0c 00 00       	call   11c0 <printf>
     4c9:	e9 bb fb ff ff       	jmp    89 <main+0x89>
        printf(1,"Error in opening path file\n");
     4ce:	c7 44 24 04 1e 16 00 	movl   $0x161e,0x4(%esp)
     4d5:	00 
     4d6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     4dd:	e8 de 0c 00 00       	call   11c0 <printf>
        exit(0);
     4e2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     4e9:	e8 6a 0b 00 00       	call   1058 <exit>
     4ee:	66 90                	xchg   %ax,%ax

000004f0 <execute>:
void execute(char * command, char** args){
     4f0:	55                   	push   %ebp
     4f1:	89 e5                	mov    %esp,%ebp
     4f3:	83 ec 18             	sub    $0x18,%esp
     4f6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     4f9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     4fc:	89 75 fc             	mov    %esi,-0x4(%ebp)
     4ff:	8b 75 08             	mov    0x8(%ebp),%esi
    if((pid = fork()) == 0){
     502:	e8 49 0b 00 00       	call   1050 <fork>
     507:	83 f8 00             	cmp    $0x0,%eax
     50a:	74 3c                	je     548 <execute+0x58>
    else if(pid > 0){
     50c:	7e 1a                	jle    528 <execute+0x38>
        wait(null);
     50e:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
}
     515:	8b 5d f8             	mov    -0x8(%ebp),%ebx
     518:	8b 75 fc             	mov    -0x4(%ebp),%esi
     51b:	89 ec                	mov    %ebp,%esp
     51d:	5d                   	pop    %ebp
        wait(null);
     51e:	e9 3d 0b 00 00       	jmp    1060 <wait>
     523:	90                   	nop
     524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1,"fork failed\n");
     528:	c7 45 0c 5e 15 00 00 	movl   $0x155e,0xc(%ebp)
}
     52f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
        printf(1,"fork failed\n");
     532:	c7 45 08 01 00 00 00 	movl   $0x1,0x8(%ebp)
}
     539:	8b 75 fc             	mov    -0x4(%ebp),%esi
     53c:	89 ec                	mov    %ebp,%esp
     53e:	5d                   	pop    %ebp
        printf(1,"fork failed\n");
     53f:	e9 7c 0c 00 00       	jmp    11c0 <printf>
     544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        exec(command, args);
     548:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     54c:	89 34 24             	mov    %esi,(%esp)
     54f:	e8 3c 0b 00 00       	call   1090 <exec>
        printf(1, "args0= %s\n",args[0]);
     554:	8b 03                	mov    (%ebx),%eax
     556:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     55d:	89 44 24 08          	mov    %eax,0x8(%esp)
     561:	b8 38 15 00 00       	mov    $0x1538,%eax
     566:	89 44 24 04          	mov    %eax,0x4(%esp)
     56a:	e8 51 0c 00 00       	call   11c0 <printf>
        printf(1, "args1= %s\n",args[1]);
     56f:	8b 43 04             	mov    0x4(%ebx),%eax
     572:	ba 43 15 00 00       	mov    $0x1543,%edx
     577:	89 54 24 04          	mov    %edx,0x4(%esp)
     57b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     582:	89 44 24 08          	mov    %eax,0x8(%esp)
     586:	e8 35 0c 00 00       	call   11c0 <printf>
        printf(1, "exec %s failed\n", command);
     58b:	b9 4e 15 00 00       	mov    $0x154e,%ecx
     590:	89 74 24 08          	mov    %esi,0x8(%esp)
     594:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     598:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     59f:	e8 1c 0c 00 00       	call   11c0 <printf>
}
     5a4:	8b 5d f8             	mov    -0x8(%ebp),%ebx
     5a7:	8b 75 fc             	mov    -0x4(%ebp),%esi
     5aa:	89 ec                	mov    %ebp,%esp
     5ac:	5d                   	pop    %ebp
     5ad:	c3                   	ret    
     5ae:	66 90                	xchg   %ax,%ax

000005b0 <run_test>:
void run_test(test_runner *test, char *name) {
     5b0:	55                   	push   %ebp
    printf(1, "========== Test - %s: Begin ==========\n", name);
     5b1:	b9 04 18 00 00       	mov    $0x1804,%ecx
void run_test(test_runner *test, char *name) {
     5b6:	89 e5                	mov    %esp,%ebp
     5b8:	53                   	push   %ebx
     5b9:	83 ec 14             	sub    $0x14,%esp
     5bc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    printf(1, "========== Test - %s: Begin ==========\n", name);
     5bf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     5c3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     5ca:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     5ce:	e8 ed 0b 00 00       	call   11c0 <printf>
    boolean result = (*test)();
     5d3:	ff 55 08             	call   *0x8(%ebp)
        printf(1, "========== Test - %s: Passed ==========\n", name);
     5d6:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    if (result) {
     5da:	85 c0                	test   %eax,%eax
     5dc:	75 22                	jne    600 <run_test+0x50>
        printf(1, "========== Test - %s: Failed ==========\n", name);
     5de:	b8 58 18 00 00       	mov    $0x1858,%eax
     5e3:	89 44 24 04          	mov    %eax,0x4(%esp)
     5e7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     5ee:	e8 cd 0b 00 00       	call   11c0 <printf>
}
     5f3:	83 c4 14             	add    $0x14,%esp
     5f6:	5b                   	pop    %ebx
     5f7:	5d                   	pop    %ebp
     5f8:	c3                   	ret    
     5f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "========== Test - %s: Passed ==========\n", name);
     600:	ba 2c 18 00 00       	mov    $0x182c,%edx
     605:	89 54 24 04          	mov    %edx,0x4(%esp)
     609:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     610:	e8 ab 0b 00 00       	call   11c0 <printf>
}
     615:	83 c4 14             	add    $0x14,%esp
     618:	5b                   	pop    %ebx
     619:	5d                   	pop    %ebp
     61a:	c3                   	ret    
     61b:	90                   	nop
     61c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000620 <assert_equals>:
boolean assert_equals(int expected, int actual, char *msg) {
     620:	55                   	push   %ebp
     621:	b8 01 00 00 00       	mov    $0x1,%eax
     626:	89 e5                	mov    %esp,%ebp
     628:	83 ec 28             	sub    $0x28,%esp
     62b:	8b 55 08             	mov    0x8(%ebp),%edx
     62e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    if (expected != actual) {
     631:	39 ca                	cmp    %ecx,%edx
     633:	74 26                	je     65b <assert_equals+0x3b>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     635:	8b 45 10             	mov    0x10(%ebp),%eax
     638:	89 4c 24 10          	mov    %ecx,0x10(%esp)
     63c:	89 54 24 0c          	mov    %edx,0xc(%esp)
     640:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     647:	89 44 24 08          	mov    %eax,0x8(%esp)
     64b:	b8 84 18 00 00       	mov    $0x1884,%eax
     650:	89 44 24 04          	mov    %eax,0x4(%esp)
     654:	e8 67 0b 00 00       	call   11c0 <printf>
     659:	31 c0                	xor    %eax,%eax
}
     65b:	c9                   	leave  
     65c:	c3                   	ret    
     65d:	8d 76 00             	lea    0x0(%esi),%esi

00000660 <print_perf>:
void print_perf(struct perf *performance) {
     660:	55                   	push   %ebp
    printf(1, "pref:\n");
     661:	b8 6b 15 00 00       	mov    $0x156b,%eax
void print_perf(struct perf *performance) {
     666:	89 e5                	mov    %esp,%ebp
     668:	53                   	push   %ebx
     669:	83 ec 14             	sub    $0x14,%esp
     66c:	8b 5d 08             	mov    0x8(%ebp),%ebx
    printf(1, "pref:\n");
     66f:	89 44 24 04          	mov    %eax,0x4(%esp)
     673:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     67a:	e8 41 0b 00 00       	call   11c0 <printf>
    printf(1, "\tctime: %d\n", performance->ctime);
     67f:	ba 72 15 00 00       	mov    $0x1572,%edx
     684:	8b 03                	mov    (%ebx),%eax
     686:	89 54 24 04          	mov    %edx,0x4(%esp)
     68a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     691:	89 44 24 08          	mov    %eax,0x8(%esp)
     695:	e8 26 0b 00 00       	call   11c0 <printf>
    printf(1, "\tttime: %d\n", performance->ttime);
     69a:	8b 43 04             	mov    0x4(%ebx),%eax
     69d:	b9 7e 15 00 00       	mov    $0x157e,%ecx
     6a2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     6a6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     6ad:	89 44 24 08          	mov    %eax,0x8(%esp)
     6b1:	e8 0a 0b 00 00       	call   11c0 <printf>
    printf(1, "\tstime: %d\n", performance->stime);
     6b6:	8b 43 08             	mov    0x8(%ebx),%eax
     6b9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     6c0:	89 44 24 08          	mov    %eax,0x8(%esp)
     6c4:	b8 8a 15 00 00       	mov    $0x158a,%eax
     6c9:	89 44 24 04          	mov    %eax,0x4(%esp)
     6cd:	e8 ee 0a 00 00       	call   11c0 <printf>
    printf(1, "\tretime: %d\n", performance->retime);
     6d2:	8b 43 0c             	mov    0xc(%ebx),%eax
     6d5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     6dc:	89 44 24 08          	mov    %eax,0x8(%esp)
     6e0:	b8 96 15 00 00       	mov    $0x1596,%eax
     6e5:	89 44 24 04          	mov    %eax,0x4(%esp)
     6e9:	e8 d2 0a 00 00       	call   11c0 <printf>
    printf(1, "\trutime: %d\n", performance->rutime);
     6ee:	8b 43 10             	mov    0x10(%ebx),%eax
     6f1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     6f8:	89 44 24 08          	mov    %eax,0x8(%esp)
     6fc:	b8 a3 15 00 00       	mov    $0x15a3,%eax
     701:	89 44 24 04          	mov    %eax,0x4(%esp)
     705:	e8 b6 0a 00 00       	call   11c0 <printf>
    printf(1, "\n\tTurnaround time: %d\n", (performance->ttime - performance->ctime));
     70a:	8b 43 04             	mov    0x4(%ebx),%eax
     70d:	b9 b0 15 00 00       	mov    $0x15b0,%ecx
     712:	8b 13                	mov    (%ebx),%edx
     714:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     718:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     71f:	29 d0                	sub    %edx,%eax
     721:	89 44 24 08          	mov    %eax,0x8(%esp)
     725:	e8 96 0a 00 00       	call   11c0 <printf>
}
     72a:	83 c4 14             	add    $0x14,%esp
     72d:	5b                   	pop    %ebx
     72e:	5d                   	pop    %ebp
     72f:	c3                   	ret    

00000730 <fact>:
int fact(int n) {
     730:	55                   	push   %ebp
}
     731:	31 c0                	xor    %eax,%eax
int fact(int n) {
     733:	89 e5                	mov    %esp,%ebp
}
     735:	5d                   	pop    %ebp
     736:	c3                   	ret    
     737:	89 f6                	mov    %esi,%esi
     739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000740 <fact2>:
unsigned long long fact2(unsigned long long n, unsigned long long k) {
     740:	55                   	push   %ebp
     741:	89 e5                	mov    %esp,%ebp
     743:	57                   	push   %edi
     744:	56                   	push   %esi
     745:	53                   	push   %ebx
     746:	83 ec 0c             	sub    $0xc,%esp
     749:	8b 45 10             	mov    0x10(%ebp),%eax
     74c:	8b 55 14             	mov    0x14(%ebp),%edx
     74f:	8b 4d 08             	mov    0x8(%ebp),%ecx
     752:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     755:	89 45 e8             	mov    %eax,-0x18(%ebp)
     758:	89 55 ec             	mov    %edx,-0x14(%ebp)
     75b:	eb 25                	jmp    782 <fact2+0x42>
     75d:	8d 76 00             	lea    0x0(%esi),%esi
        k = k * n;
     760:	8b 75 ec             	mov    -0x14(%ebp),%esi
        --n;
     763:	83 c1 ff             	add    $0xffffffff,%ecx
        k = k * n;
     766:	8b 55 e8             	mov    -0x18(%ebp),%edx
        --n;
     769:	83 d3 ff             	adc    $0xffffffff,%ebx
        k = k * n;
     76c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     76f:	0f af f1             	imul   %ecx,%esi
     772:	0f af d3             	imul   %ebx,%edx
     775:	01 d6                	add    %edx,%esi
     777:	f7 e1                	mul    %ecx
     779:	89 55 ec             	mov    %edx,-0x14(%ebp)
     77c:	01 75 ec             	add    %esi,-0x14(%ebp)
     77f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (n == 1) {
     782:	89 ce                	mov    %ecx,%esi
     784:	89 df                	mov    %ebx,%edi
     786:	83 f6 01             	xor    $0x1,%esi
     789:	09 f7                	or     %esi,%edi
     78b:	75 d3                	jne    760 <fact2+0x20>
}
     78d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     790:	8b 55 ec             	mov    -0x14(%ebp),%edx
     793:	83 c4 0c             	add    $0xc,%esp
     796:	5b                   	pop    %ebx
     797:	5e                   	pop    %esi
     798:	5f                   	pop    %edi
     799:	5d                   	pop    %ebp
     79a:	c3                   	ret    
     79b:	90                   	nop
     79c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000007a0 <fib>:
int fib(int n) {
     7a0:	55                   	push   %ebp
     7a1:	89 e5                	mov    %esp,%ebp
     7a3:	83 ec 28             	sub    $0x28,%esp
     7a6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     7a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     7ac:	89 75 f8             	mov    %esi,-0x8(%ebp)
     7af:	89 7d fc             	mov    %edi,-0x4(%ebp)
    if (!n)
     7b2:	85 db                	test   %ebx,%ebx
     7b4:	74 2a                	je     7e0 <fib+0x40>
     7b6:	4b                   	dec    %ebx
     7b7:	bf ff ff ff ff       	mov    $0xffffffff,%edi
     7bc:	31 f6                	xor    %esi,%esi
    return fib(n - 1) + fib(n - 2);
     7be:	89 1c 24             	mov    %ebx,(%esp)
     7c1:	83 eb 02             	sub    $0x2,%ebx
     7c4:	e8 d7 ff ff ff       	call   7a0 <fib>
     7c9:	01 c6                	add    %eax,%esi
    if (!n)
     7cb:	39 fb                	cmp    %edi,%ebx
     7cd:	75 ef                	jne    7be <fib+0x1e>
     7cf:	8d 46 01             	lea    0x1(%esi),%eax
}
     7d2:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     7d5:	8b 75 f8             	mov    -0x8(%ebp),%esi
     7d8:	8b 7d fc             	mov    -0x4(%ebp),%edi
     7db:	89 ec                	mov    %ebp,%esp
     7dd:	5d                   	pop    %ebp
     7de:	c3                   	ret    
     7df:	90                   	nop
     7e0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    if (!n)
     7e3:	b8 01 00 00 00       	mov    $0x1,%eax
}
     7e8:	8b 75 f8             	mov    -0x8(%ebp),%esi
     7eb:	8b 7d fc             	mov    -0x4(%ebp),%edi
     7ee:	89 ec                	mov    %ebp,%esp
     7f0:	5d                   	pop    %ebp
     7f1:	c3                   	ret    
     7f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     7f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000800 <test_exit_wait>:
boolean test_exit_wait() {
     800:	55                   	push   %ebp
     801:	89 e5                	mov    %esp,%ebp
     803:	57                   	push   %edi
     804:	56                   	push   %esi
    boolean result = true;
     805:	be 01 00 00 00       	mov    $0x1,%esi
boolean test_exit_wait() {
     80a:	53                   	push   %ebx
    for (int i = 0; i < 20; ++i) {
     80b:	31 db                	xor    %ebx,%ebx
boolean test_exit_wait() {
     80d:	83 ec 3c             	sub    $0x3c,%esp
            wait(&status);
     810:	8d 7d e4             	lea    -0x1c(%ebp),%edi
     813:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        pid = fork();
     820:	e8 2b 08 00 00       	call   1050 <fork>
        if (pid > 0) {
     825:	85 c0                	test   %eax,%eax
     827:	7e 57                	jle    880 <test_exit_wait+0x80>
            wait(&status);
     829:	89 3c 24             	mov    %edi,(%esp)
     82c:	e8 2f 08 00 00       	call   1060 <wait>
            result = result && assert_equals(i, status, "exit&wait");
     831:	85 f6                	test   %esi,%esi
     833:	74 34                	je     869 <test_exit_wait+0x69>
     835:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     838:	be 01 00 00 00       	mov    $0x1,%esi
    if (expected != actual) {
     83d:	39 d8                	cmp    %ebx,%eax
     83f:	74 28                	je     869 <test_exit_wait+0x69>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     841:	89 44 24 10          	mov    %eax,0x10(%esp)
     845:	ba 84 18 00 00       	mov    $0x1884,%edx
     84a:	b8 c7 15 00 00       	mov    $0x15c7,%eax
     84f:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
            result = result && assert_equals(i, status, "exit&wait");
     853:	31 f6                	xor    %esi,%esi
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     855:	89 44 24 08          	mov    %eax,0x8(%esp)
     859:	89 54 24 04          	mov    %edx,0x4(%esp)
     85d:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     864:	e8 57 09 00 00       	call   11c0 <printf>
    for (int i = 0; i < 20; ++i) {
     869:	43                   	inc    %ebx
     86a:	83 fb 14             	cmp    $0x14,%ebx
            status = -1;
     86d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
    for (int i = 0; i < 20; ++i) {
     874:	75 aa                	jne    820 <test_exit_wait+0x20>
}
     876:	83 c4 3c             	add    $0x3c,%esp
     879:	89 f0                	mov    %esi,%eax
     87b:	5b                   	pop    %ebx
     87c:	5e                   	pop    %esi
     87d:	5f                   	pop    %edi
     87e:	5d                   	pop    %ebp
     87f:	c3                   	ret    
            sleep(3);
     880:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
     887:	e8 5c 08 00 00       	call   10e8 <sleep>
            exit(i);
     88c:	89 1c 24             	mov    %ebx,(%esp)
     88f:	e8 c4 07 00 00       	call   1058 <exit>
     894:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     89a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000008a0 <test_detach>:
boolean test_detach() {
     8a0:	55                   	push   %ebp
     8a1:	89 e5                	mov    %esp,%ebp
     8a3:	56                   	push   %esi
     8a4:	53                   	push   %ebx
     8a5:	83 ec 20             	sub    $0x20,%esp
    pid = fork();
     8a8:	e8 a3 07 00 00       	call   1050 <fork>
    if (pid > 0) {
     8ad:	85 c0                	test   %eax,%eax
     8af:	0f 8e ea 00 00 00    	jle    99f <test_detach+0xff>
        status1 = detach(pid);
     8b5:	89 04 24             	mov    %eax,(%esp)
     8b8:	89 c3                	mov    %eax,%ebx
    } else return true;
     8ba:	be 01 00 00 00       	mov    $0x1,%esi
        status1 = detach(pid);
     8bf:	e8 3c 08 00 00       	call   1100 <detach>
    if (expected != actual) {
     8c4:	85 c0                	test   %eax,%eax
     8c6:	0f 85 a4 00 00 00    	jne    970 <test_detach+0xd0>
        status2 = detach(pid);
     8cc:	89 1c 24             	mov    %ebx,(%esp)
     8cf:	e8 2c 08 00 00       	call   1100 <detach>
    if (expected != actual) {
     8d4:	83 f8 ff             	cmp    $0xffffffff,%eax
     8d7:	75 1f                	jne    8f8 <test_detach+0x58>
        status3 = detach(-10);
     8d9:	c7 04 24 f6 ff ff ff 	movl   $0xfffffff6,(%esp)
     8e0:	e8 1b 08 00 00       	call   1100 <detach>
    if (expected != actual) {
     8e5:	83 f8 ff             	cmp    $0xffffffff,%eax
     8e8:	75 4a                	jne    934 <test_detach+0x94>
}
     8ea:	83 c4 20             	add    $0x20,%esp
     8ed:	89 f0                	mov    %esi,%eax
     8ef:	5b                   	pop    %ebx
     8f0:	5e                   	pop    %esi
     8f1:	5d                   	pop    %ebp
     8f2:	c3                   	ret    
     8f3:	90                   	nop
     8f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     8f8:	89 44 24 10          	mov    %eax,0x10(%esp)
     8fc:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
     901:	b8 84 18 00 00       	mov    $0x1884,%eax
     906:	be e2 15 00 00       	mov    $0x15e2,%esi
     90b:	89 44 24 04          	mov    %eax,0x4(%esp)
     90f:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
     913:	89 74 24 08          	mov    %esi,0x8(%esp)
     917:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     91e:	e8 9d 08 00 00       	call   11c0 <printf>
        status3 = detach(-10);
     923:	c7 04 24 f6 ff ff ff 	movl   $0xfffffff6,(%esp)
     92a:	e8 d1 07 00 00       	call   1100 <detach>
    if (expected != actual) {
     92f:	83 f8 ff             	cmp    $0xffffffff,%eax
     932:	74 2b                	je     95f <test_detach+0xbf>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     934:	89 44 24 10          	mov    %eax,0x10(%esp)
     938:	ba f3 15 00 00       	mov    $0x15f3,%edx
     93d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     942:	b9 84 18 00 00       	mov    $0x1884,%ecx
     947:	89 44 24 0c          	mov    %eax,0xc(%esp)
     94b:	89 54 24 08          	mov    %edx,0x8(%esp)
     94f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     953:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     95a:	e8 61 08 00 00       	call   11c0 <printf>
}
     95f:	83 c4 20             	add    $0x20,%esp
        return result1 && result2 && result3;
     962:	31 f6                	xor    %esi,%esi
}
     964:	5b                   	pop    %ebx
     965:	89 f0                	mov    %esi,%eax
     967:	5e                   	pop    %esi
     968:	5d                   	pop    %ebp
     969:	c3                   	ret    
     96a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     970:	89 44 24 10          	mov    %eax,0x10(%esp)
     974:	31 c0                	xor    %eax,%eax
     976:	31 f6                	xor    %esi,%esi
     978:	89 44 24 0c          	mov    %eax,0xc(%esp)
     97c:	b8 d1 15 00 00       	mov    $0x15d1,%eax
     981:	89 44 24 08          	mov    %eax,0x8(%esp)
     985:	b8 84 18 00 00       	mov    $0x1884,%eax
     98a:	89 44 24 04          	mov    %eax,0x4(%esp)
     98e:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     995:	e8 26 08 00 00       	call   11c0 <printf>
     99a:	e9 2d ff ff ff       	jmp    8cc <test_detach+0x2c>
        sleep(100);
     99f:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
     9a6:	e8 3d 07 00 00       	call   10e8 <sleep>
        exit(0);
     9ab:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     9b2:	e8 a1 06 00 00       	call   1058 <exit>
     9b7:	89 f6                	mov    %esi,%esi
     9b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009c0 <test_policy_helper>:
boolean test_policy_helper(int *priority_mod, int policy) {
     9c0:	55                   	push   %ebp
     9c1:	89 e5                	mov    %esp,%ebp
     9c3:	57                   	push   %edi
     9c4:	56                   	push   %esi
     9c5:	53                   	push   %ebx
    for (int i = 0; i < nProcs; ++i) {
     9c6:	31 db                	xor    %ebx,%ebx
boolean test_policy_helper(int *priority_mod, int policy) {
     9c8:	83 ec 4c             	sub    $0x4c,%esp
     9cb:	90                   	nop
     9cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        pid = fork();
     9d0:	e8 7b 06 00 00       	call   1050 <fork>
        if (pid < 0) {
     9d5:	85 c0                	test   %eax,%eax
     9d7:	78 0c                	js     9e5 <test_policy_helper+0x25>
        } else if (pid == 0) {
     9d9:	0f 84 a5 00 00 00    	je     a84 <test_policy_helper+0xc4>
    for (int i = 0; i < nProcs; ++i) {
     9df:	43                   	inc    %ebx
     9e0:	83 fb 0a             	cmp    $0xa,%ebx
     9e3:	75 eb                	jne    9d0 <test_policy_helper+0x10>
     9e5:	31 f6                	xor    %esi,%esi
     9e7:	ba 01 00 00 00       	mov    $0x1,%edx
     9ec:	8d 7d e4             	lea    -0x1c(%ebp),%edi
        wait(&status);
     9ef:	89 3c 24             	mov    %edi,(%esp)
     9f2:	8d 5e 01             	lea    0x1(%esi),%ebx
     9f5:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     9f8:	e8 63 06 00 00       	call   1060 <wait>
        result = result && assert_equals(0, status, "round robin");
     9fd:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     a00:	85 d2                	test   %edx,%edx
     a02:	74 5c                	je     a60 <test_policy_helper+0xa0>
     a04:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a07:	ba 01 00 00 00       	mov    $0x1,%edx
    if (expected != actual) {
     a0c:	85 c0                	test   %eax,%eax
     a0e:	75 18                	jne    a28 <test_policy_helper+0x68>
    for (int j = 0; j < nProcs; ++j) {
     a10:	83 fb 0a             	cmp    $0xa,%ebx
     a13:	89 de                	mov    %ebx,%esi
     a15:	75 d8                	jne    9ef <test_policy_helper+0x2f>
}
     a17:	83 c4 4c             	add    $0x4c,%esp
     a1a:	89 d0                	mov    %edx,%eax
     a1c:	5b                   	pop    %ebx
     a1d:	5e                   	pop    %esi
     a1e:	5f                   	pop    %edi
     a1f:	5d                   	pop    %ebp
     a20:	c3                   	ret    
     a21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     a28:	89 44 24 10          	mov    %eax,0x10(%esp)
     a2c:	ba 04 16 00 00       	mov    $0x1604,%edx
     a31:	31 c0                	xor    %eax,%eax
     a33:	b9 84 18 00 00       	mov    $0x1884,%ecx
     a38:	89 44 24 0c          	mov    %eax,0xc(%esp)
     a3c:	89 54 24 08          	mov    %edx,0x8(%esp)
     a40:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     a44:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     a4b:	e8 70 07 00 00       	call   11c0 <printf>
    for (int j = 0; j < nProcs; ++j) {
     a50:	83 fb 0a             	cmp    $0xa,%ebx
     a53:	74 23                	je     a78 <test_policy_helper+0xb8>
        wait(&status);
     a55:	89 3c 24             	mov    %edi,(%esp)
     a58:	8d 5e 02             	lea    0x2(%esi),%ebx
     a5b:	e8 00 06 00 00       	call   1060 <wait>
    for (int j = 0; j < nProcs; ++j) {
     a60:	83 fb 0a             	cmp    $0xa,%ebx
     a63:	74 13                	je     a78 <test_policy_helper+0xb8>
        wait(&status);
     a65:	89 3c 24             	mov    %edi,(%esp)
     a68:	43                   	inc    %ebx
     a69:	e8 f2 05 00 00       	call   1060 <wait>
        result = result && assert_equals(0, status, "round robin");
     a6e:	31 d2                	xor    %edx,%edx
     a70:	eb 9e                	jmp    a10 <test_policy_helper+0x50>
     a72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
     a78:	83 c4 4c             	add    $0x4c,%esp
        result = result && assert_equals(0, status, "round robin");
     a7b:	31 d2                	xor    %edx,%edx
}
     a7d:	5b                   	pop    %ebx
     a7e:	89 d0                	mov    %edx,%eax
     a80:	5e                   	pop    %esi
     a81:	5f                   	pop    %edi
     a82:	5d                   	pop    %ebp
     a83:	c3                   	ret    
            if (priority_mod) {
     a84:	8b 75 08             	mov    0x8(%ebp),%esi
     a87:	85 f6                	test   %esi,%esi
     a89:	74 1a                	je     aa5 <test_policy_helper+0xe5>
                if ((i % *(priority_mod)) == 0 && policy == PRIORITY) {
     a8b:	8b 4d 08             	mov    0x8(%ebp),%ecx
     a8e:	89 d8                	mov    %ebx,%eax
     a90:	99                   	cltd   
     a91:	f7 39                	idivl  (%ecx)
     a93:	85 d2                	test   %edx,%edx
     a95:	75 06                	jne    a9d <test_policy_helper+0xdd>
     a97:	83 7d 0c 02          	cmpl   $0x2,0xc(%ebp)
     a9b:	74 20                	je     abd <test_policy_helper+0xfd>
                    priority(i % (*priority_mod));
     a9d:	89 14 24             	mov    %edx,(%esp)
     aa0:	e8 63 06 00 00       	call   1108 <priority>
            sleep(10);
     aa5:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
     aac:	e8 37 06 00 00       	call   10e8 <sleep>
            exit(0);
     ab1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     ab8:	e8 9b 05 00 00       	call   1058 <exit>
                    priority(1);
     abd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ac4:	e8 3f 06 00 00       	call   1108 <priority>
     ac9:	eb da                	jmp    aa5 <test_policy_helper+0xe5>
     acb:	90                   	nop
     acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ad0 <test_round_robin_policy>:
boolean test_round_robin_policy() {
     ad0:	55                   	push   %ebp
    return test_policy_helper(null, null);
     ad1:	31 c0                	xor    %eax,%eax
boolean test_round_robin_policy() {
     ad3:	89 e5                	mov    %esp,%ebp
     ad5:	83 ec 18             	sub    $0x18,%esp
    return test_policy_helper(null, null);
     ad8:	89 44 24 04          	mov    %eax,0x4(%esp)
     adc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     ae3:	e8 d8 fe ff ff       	call   9c0 <test_policy_helper>
}
     ae8:	c9                   	leave  
     ae9:	c3                   	ret    
     aea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000af0 <test_priority_policy>:
boolean test_priority_policy() {
     af0:	55                   	push   %ebp
     af1:	89 e5                	mov    %esp,%ebp
     af3:	53                   	push   %ebx
     af4:	83 ec 24             	sub    $0x24,%esp
    policy(PRIORITY);
     af7:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    int priority_mod = 10;
     afe:	c7 45 f4 0a 00 00 00 	movl   $0xa,-0xc(%ebp)
    policy(PRIORITY);
     b05:	e8 ee 05 00 00       	call   10f8 <policy>
    boolean result = test_policy_helper(&priority_mod, PRIORITY);
     b0a:	b8 02 00 00 00       	mov    $0x2,%eax
     b0f:	89 44 24 04          	mov    %eax,0x4(%esp)
     b13:	8d 45 f4             	lea    -0xc(%ebp),%eax
     b16:	89 04 24             	mov    %eax,(%esp)
     b19:	e8 a2 fe ff ff       	call   9c0 <test_policy_helper>
    policy(ROUND_ROBIN);
     b1e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    boolean result = test_policy_helper(&priority_mod, PRIORITY);
     b25:	89 c3                	mov    %eax,%ebx
    policy(ROUND_ROBIN);
     b27:	e8 cc 05 00 00       	call   10f8 <policy>
}
     b2c:	83 c4 24             	add    $0x24,%esp
     b2f:	89 d8                	mov    %ebx,%eax
     b31:	5b                   	pop    %ebx
     b32:	5d                   	pop    %ebp
     b33:	c3                   	ret    
     b34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000b40 <test_extended_priority_policy>:
boolean test_extended_priority_policy() {
     b40:	55                   	push   %ebp
     b41:	89 e5                	mov    %esp,%ebp
     b43:	53                   	push   %ebx
     b44:	83 ec 24             	sub    $0x24,%esp
    policy(EXTENED_PRIORITY);
     b47:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
    int priority_mod = 10;
     b4e:	c7 45 f4 0a 00 00 00 	movl   $0xa,-0xc(%ebp)
    policy(EXTENED_PRIORITY);
     b55:	e8 9e 05 00 00       	call   10f8 <policy>
    boolean result = test_policy_helper(&priority_mod, EXTENED_PRIORITY);
     b5a:	b8 03 00 00 00       	mov    $0x3,%eax
     b5f:	89 44 24 04          	mov    %eax,0x4(%esp)
     b63:	8d 45 f4             	lea    -0xc(%ebp),%eax
     b66:	89 04 24             	mov    %eax,(%esp)
     b69:	e8 52 fe ff ff       	call   9c0 <test_policy_helper>
    policy(ROUND_ROBIN);
     b6e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    boolean result = test_policy_helper(&priority_mod, EXTENED_PRIORITY);
     b75:	89 c3                	mov    %eax,%ebx
    policy(ROUND_ROBIN);
     b77:	e8 7c 05 00 00       	call   10f8 <policy>
}
     b7c:	83 c4 24             	add    $0x24,%esp
     b7f:	89 d8                	mov    %ebx,%eax
     b81:	5b                   	pop    %ebx
     b82:	5d                   	pop    %ebp
     b83:	c3                   	ret    
     b84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000b90 <test_performance_helper>:
boolean test_performance_helper(int *npriority) {
     b90:	55                   	push   %ebp
     b91:	89 e5                	mov    %esp,%ebp
     b93:	57                   	push   %edi
     b94:	56                   	push   %esi
     b95:	53                   	push   %ebx
     b96:	83 ec 3c             	sub    $0x3c,%esp
    pid1 = fork();
     b99:	e8 b2 04 00 00       	call   1050 <fork>
    if (pid1 > 0) {
     b9e:	85 c0                	test   %eax,%eax
     ba0:	7f 3e                	jg     be0 <test_performance_helper+0x50>
     ba2:	bb 0a 00 00 00       	mov    $0xa,%ebx
                wait_stat(&status, &perf1);
     ba7:	8d 7d d4             	lea    -0x2c(%ebp),%edi
     baa:	8d 75 d0             	lea    -0x30(%ebp),%esi
     bad:	8d 76 00             	lea    0x0(%esi),%esi
            pid = fork();
     bb0:	e8 9b 04 00 00       	call   1050 <fork>
            if (pid > 0) {
     bb5:	85 c0                	test   %eax,%eax
     bb7:	7e 4e                	jle    c07 <test_performance_helper+0x77>
                sleep(5);
     bb9:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     bc0:	e8 23 05 00 00       	call   10e8 <sleep>
                wait_stat(&status, &perf1);
     bc5:	89 7c 24 04          	mov    %edi,0x4(%esp)
     bc9:	89 34 24             	mov    %esi,(%esp)
     bcc:	e8 3f 05 00 00       	call   1110 <wait_stat>
        for (int a = 0; a < 10; ++a) {
     bd1:	4b                   	dec    %ebx
     bd2:	75 dc                	jne    bb0 <test_performance_helper+0x20>
        exit(0);
     bd4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     bdb:	e8 78 04 00 00       	call   1058 <exit>
        wait_stat(&status1, &perf2);
     be0:	8d 5d d4             	lea    -0x2c(%ebp),%ebx
     be3:	8d 45 d0             	lea    -0x30(%ebp),%eax
     be6:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     bea:	89 04 24             	mov    %eax,(%esp)
     bed:	e8 1e 05 00 00       	call   1110 <wait_stat>
        print_perf(&perf2);
     bf2:	89 1c 24             	mov    %ebx,(%esp)
     bf5:	e8 66 fa ff ff       	call   660 <print_perf>
}
     bfa:	83 c4 3c             	add    $0x3c,%esp
     bfd:	b8 01 00 00 00       	mov    $0x1,%eax
     c02:	5b                   	pop    %ebx
     c03:	5e                   	pop    %esi
     c04:	5f                   	pop    %edi
     c05:	5d                   	pop    %ebp
     c06:	c3                   	ret    
                if (npriority)
     c07:	8b 45 08             	mov    0x8(%ebp),%eax
     c0a:	85 c0                	test   %eax,%eax
     c0c:	74 0d                	je     c1b <test_performance_helper+0x8b>
                    priority(*npriority);
     c0e:	8b 45 08             	mov    0x8(%ebp),%eax
     c11:	8b 00                	mov    (%eax),%eax
     c13:	89 04 24             	mov    %eax,(%esp)
     c16:	e8 ed 04 00 00       	call   1108 <priority>
                sleep(5);
     c1b:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     c22:	e8 c1 04 00 00       	call   10e8 <sleep>
                exit(0);
     c27:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     c2e:	e8 25 04 00 00       	call   1058 <exit>
     c33:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c40 <test_starvation_helper>:
boolean test_starvation_helper(int npolicy, int npriority) {
     c40:	55                   	push   %ebp
     c41:	89 e5                	mov    %esp,%ebp
     c43:	57                   	push   %edi
     c44:	56                   	push   %esi
    memset(&pid_arr, 0, nProcs * sizeof(int));
     c45:	31 f6                	xor    %esi,%esi
boolean test_starvation_helper(int npolicy, int npriority) {
     c47:	53                   	push   %ebx
    memset(&pid_arr, 0, nProcs * sizeof(int));
     c48:	bb 28 00 00 00       	mov    $0x28,%ebx
boolean test_starvation_helper(int npolicy, int npriority) {
     c4d:	83 ec 5c             	sub    $0x5c,%esp
    policy(npolicy);
     c50:	8b 45 08             	mov    0x8(%ebp),%eax
     c53:	89 04 24             	mov    %eax,(%esp)
     c56:	e8 9d 04 00 00       	call   10f8 <policy>
    memset(&pid_arr, 0, nProcs * sizeof(int));
     c5b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     c5f:	8d 5d c0             	lea    -0x40(%ebp),%ebx
     c62:	89 74 24 04          	mov    %esi,0x4(%esp)
     c66:	89 df                	mov    %ebx,%edi
     c68:	89 1c 24             	mov    %ebx,(%esp)
     c6b:	8d 75 e8             	lea    -0x18(%ebp),%esi
     c6e:	e8 4d 02 00 00       	call   ec0 <memset>
     c73:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        pid = fork();
     c80:	e8 cb 03 00 00       	call   1050 <fork>
        if (pid < 0) {
     c85:	85 c0                	test   %eax,%eax
     c87:	78 0f                	js     c98 <test_starvation_helper+0x58>
        } else if (pid == 0) {
     c89:	0f 84 a1 00 00 00    	je     d30 <test_starvation_helper+0xf0>
            pid_arr[i] = pid;
     c8f:	89 07                	mov    %eax,(%edi)
     c91:	83 c7 04             	add    $0x4,%edi
    for (int i = 0; i < nProcs; ++i) {
     c94:	39 f7                	cmp    %esi,%edi
     c96:	75 e8                	jne    c80 <test_starvation_helper+0x40>
    sleep(100);
     c98:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
    boolean result = true;
     c9f:	bf 01 00 00 00       	mov    $0x1,%edi
    sleep(100);
     ca4:	e8 3f 04 00 00       	call   10e8 <sleep>
     ca9:	eb 18                	jmp    cc3 <test_starvation_helper+0x83>
     cab:	90                   	nop
     cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            wait(null);
     cb0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     cb7:	e8 a4 03 00 00       	call   1060 <wait>
     cbc:	83 c3 04             	add    $0x4,%ebx
    for (int j = 0; j < nProcs; ++j) {
     cbf:	39 de                	cmp    %ebx,%esi
     cc1:	74 4d                	je     d10 <test_starvation_helper+0xd0>
        if (pid_arr[j] != 0) {
     cc3:	8b 03                	mov    (%ebx),%eax
     cc5:	85 c0                	test   %eax,%eax
     cc7:	74 f3                	je     cbc <test_starvation_helper+0x7c>
            result = result && assert_equals(0, kill(pid_arr[j]), "failed to kill child (yes it does sound horrible)");
     cc9:	85 ff                	test   %edi,%edi
     ccb:	74 e3                	je     cb0 <test_starvation_helper+0x70>
     ccd:	89 04 24             	mov    %eax,(%esp)
     cd0:	bf 01 00 00 00       	mov    $0x1,%edi
     cd5:	e8 ae 03 00 00       	call   1088 <kill>
    if (expected != actual) {
     cda:	85 c0                	test   %eax,%eax
     cdc:	74 d2                	je     cb0 <test_starvation_helper+0x70>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     cde:	89 44 24 10          	mov    %eax,0x10(%esp)
     ce2:	ba b0 18 00 00       	mov    $0x18b0,%edx
     ce7:	31 c0                	xor    %eax,%eax
     ce9:	b9 84 18 00 00       	mov    $0x1884,%ecx
            result = result && assert_equals(0, kill(pid_arr[j]), "failed to kill child (yes it does sound horrible)");
     cee:	31 ff                	xor    %edi,%edi
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     cf0:	89 44 24 0c          	mov    %eax,0xc(%esp)
     cf4:	89 54 24 08          	mov    %edx,0x8(%esp)
     cf8:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     cfc:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     d03:	e8 b8 04 00 00       	call   11c0 <printf>
     d08:	eb a6                	jmp    cb0 <test_starvation_helper+0x70>
     d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    policy(ROUND_ROBIN);
     d10:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d17:	e8 dc 03 00 00       	call   10f8 <policy>
}
     d1c:	83 c4 5c             	add    $0x5c,%esp
     d1f:	89 f8                	mov    %edi,%eax
     d21:	5b                   	pop    %ebx
     d22:	5e                   	pop    %esi
     d23:	5f                   	pop    %edi
     d24:	5d                   	pop    %ebp
     d25:	c3                   	ret    
     d26:	8d 76 00             	lea    0x0(%esi),%esi
     d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            sleep(5);
     d30:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     d37:	e8 ac 03 00 00       	call   10e8 <sleep>
            priority(npriority);
     d3c:	8b 45 0c             	mov    0xc(%ebp),%eax
     d3f:	89 04 24             	mov    %eax,(%esp)
     d42:	e8 c1 03 00 00       	call   1108 <priority>
     d47:	eb fe                	jmp    d47 <test_starvation_helper+0x107>
     d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d50 <test_accumulator>:
boolean test_accumulator() {
     d50:	55                   	push   %ebp
    return test_starvation_helper(PRIORITY, 2);
     d51:	b8 02 00 00 00       	mov    $0x2,%eax
boolean test_accumulator() {
     d56:	89 e5                	mov    %esp,%ebp
     d58:	83 ec 18             	sub    $0x18,%esp
    return test_starvation_helper(PRIORITY, 2);
     d5b:	89 44 24 04          	mov    %eax,0x4(%esp)
     d5f:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     d66:	e8 d5 fe ff ff       	call   c40 <test_starvation_helper>
}
     d6b:	c9                   	leave  
     d6c:	c3                   	ret    
     d6d:	8d 76 00             	lea    0x0(%esi),%esi

00000d70 <test_starvation>:
boolean test_starvation() {
     d70:	55                   	push   %ebp
    return test_starvation_helper(EXTENED_PRIORITY, 0);
     d71:	31 c0                	xor    %eax,%eax
boolean test_starvation() {
     d73:	89 e5                	mov    %esp,%ebp
     d75:	83 ec 18             	sub    $0x18,%esp
    return test_starvation_helper(EXTENED_PRIORITY, 0);
     d78:	89 44 24 04          	mov    %eax,0x4(%esp)
     d7c:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
     d83:	e8 b8 fe ff ff       	call   c40 <test_starvation_helper>
}
     d88:	c9                   	leave  
     d89:	c3                   	ret    
     d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000d90 <test_performance_round_robin>:
boolean test_performance_round_robin() {
     d90:	55                   	push   %ebp
     d91:	89 e5                	mov    %esp,%ebp
     d93:	83 ec 18             	sub    $0x18,%esp
    return test_performance_helper(null);
     d96:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     d9d:	e8 ee fd ff ff       	call   b90 <test_performance_helper>
}
     da2:	c9                   	leave  
     da3:	c3                   	ret    
     da4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     daa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000db0 <test_performance_priority>:
boolean test_performance_priority() {
     db0:	55                   	push   %ebp
     db1:	89 e5                	mov    %esp,%ebp
     db3:	53                   	push   %ebx
     db4:	83 ec 24             	sub    $0x24,%esp
    policy(PRIORITY);
     db7:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     dbe:	e8 35 03 00 00       	call   10f8 <policy>
    boolean result = test_performance_helper(&npriority);
     dc3:	8d 45 f4             	lea    -0xc(%ebp),%eax
     dc6:	89 04 24             	mov    %eax,(%esp)
    int npriority = 2;
     dc9:	c7 45 f4 02 00 00 00 	movl   $0x2,-0xc(%ebp)
    boolean result = test_performance_helper(&npriority);
     dd0:	e8 bb fd ff ff       	call   b90 <test_performance_helper>
    policy(ROUND_ROBIN);
     dd5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    boolean result = test_performance_helper(&npriority);
     ddc:	89 c3                	mov    %eax,%ebx
    policy(ROUND_ROBIN);
     dde:	e8 15 03 00 00       	call   10f8 <policy>
}
     de3:	83 c4 24             	add    $0x24,%esp
     de6:	89 d8                	mov    %ebx,%eax
     de8:	5b                   	pop    %ebx
     de9:	5d                   	pop    %ebp
     dea:	c3                   	ret    
     deb:	90                   	nop
     dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000df0 <test_performance_extended_priority>:
boolean test_performance_extended_priority() {
     df0:	55                   	push   %ebp
     df1:	89 e5                	mov    %esp,%ebp
     df3:	53                   	push   %ebx
     df4:	83 ec 24             	sub    $0x24,%esp
    policy(EXTENED_PRIORITY);
     df7:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
     dfe:	e8 f5 02 00 00       	call   10f8 <policy>
    boolean result = test_performance_helper(&npriority);
     e03:	8d 45 f4             	lea    -0xc(%ebp),%eax
     e06:	89 04 24             	mov    %eax,(%esp)
    int npriority = 0;
     e09:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    boolean result = test_performance_helper(&npriority);
     e10:	e8 7b fd ff ff       	call   b90 <test_performance_helper>
    policy(ROUND_ROBIN);
     e15:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    boolean result = test_performance_helper(&npriority);
     e1c:	89 c3                	mov    %eax,%ebx
    policy(ROUND_ROBIN);
     e1e:	e8 d5 02 00 00       	call   10f8 <policy>
}
     e23:	83 c4 24             	add    $0x24,%esp
     e26:	89 d8                	mov    %ebx,%eax
     e28:	5b                   	pop    %ebx
     e29:	5d                   	pop    %ebp
     e2a:	c3                   	ret    
     e2b:	66 90                	xchg   %ax,%ax
     e2d:	66 90                	xchg   %ax,%ax
     e2f:	90                   	nop

00000e30 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     e30:	55                   	push   %ebp
     e31:	89 e5                	mov    %esp,%ebp
     e33:	8b 45 08             	mov    0x8(%ebp),%eax
     e36:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     e39:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     e3a:	89 c2                	mov    %eax,%edx
     e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e40:	41                   	inc    %ecx
     e41:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     e45:	42                   	inc    %edx
     e46:	84 db                	test   %bl,%bl
     e48:	88 5a ff             	mov    %bl,-0x1(%edx)
     e4b:	75 f3                	jne    e40 <strcpy+0x10>
    ;
  return os;
}
     e4d:	5b                   	pop    %ebx
     e4e:	5d                   	pop    %ebp
     e4f:	c3                   	ret    

00000e50 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     e50:	55                   	push   %ebp
     e51:	89 e5                	mov    %esp,%ebp
     e53:	8b 4d 08             	mov    0x8(%ebp),%ecx
     e56:	53                   	push   %ebx
     e57:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
     e5a:	0f b6 01             	movzbl (%ecx),%eax
     e5d:	0f b6 13             	movzbl (%ebx),%edx
     e60:	84 c0                	test   %al,%al
     e62:	75 18                	jne    e7c <strcmp+0x2c>
     e64:	eb 22                	jmp    e88 <strcmp+0x38>
     e66:	8d 76 00             	lea    0x0(%esi),%esi
     e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     e70:	41                   	inc    %ecx
  while(*p && *p == *q)
     e71:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
     e74:	43                   	inc    %ebx
     e75:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
     e78:	84 c0                	test   %al,%al
     e7a:	74 0c                	je     e88 <strcmp+0x38>
     e7c:	38 d0                	cmp    %dl,%al
     e7e:	74 f0                	je     e70 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
     e80:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
     e81:	29 d0                	sub    %edx,%eax
}
     e83:	5d                   	pop    %ebp
     e84:	c3                   	ret    
     e85:	8d 76 00             	lea    0x0(%esi),%esi
     e88:	5b                   	pop    %ebx
     e89:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     e8b:	29 d0                	sub    %edx,%eax
}
     e8d:	5d                   	pop    %ebp
     e8e:	c3                   	ret    
     e8f:	90                   	nop

00000e90 <strlen>:

uint
strlen(const char *s)
{
     e90:	55                   	push   %ebp
     e91:	89 e5                	mov    %esp,%ebp
     e93:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     e96:	80 39 00             	cmpb   $0x0,(%ecx)
     e99:	74 15                	je     eb0 <strlen+0x20>
     e9b:	31 d2                	xor    %edx,%edx
     e9d:	8d 76 00             	lea    0x0(%esi),%esi
     ea0:	42                   	inc    %edx
     ea1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     ea5:	89 d0                	mov    %edx,%eax
     ea7:	75 f7                	jne    ea0 <strlen+0x10>
    ;
  return n;
}
     ea9:	5d                   	pop    %ebp
     eaa:	c3                   	ret    
     eab:	90                   	nop
     eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
     eb0:	31 c0                	xor    %eax,%eax
}
     eb2:	5d                   	pop    %ebp
     eb3:	c3                   	ret    
     eb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     eba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000ec0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     ec0:	55                   	push   %ebp
     ec1:	89 e5                	mov    %esp,%ebp
     ec3:	8b 55 08             	mov    0x8(%ebp),%edx
     ec6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     ec7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     eca:	8b 45 0c             	mov    0xc(%ebp),%eax
     ecd:	89 d7                	mov    %edx,%edi
     ecf:	fc                   	cld    
     ed0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     ed2:	5f                   	pop    %edi
     ed3:	89 d0                	mov    %edx,%eax
     ed5:	5d                   	pop    %ebp
     ed6:	c3                   	ret    
     ed7:	89 f6                	mov    %esi,%esi
     ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ee0 <strchr>:

char*
strchr(const char *s, char c)
{
     ee0:	55                   	push   %ebp
     ee1:	89 e5                	mov    %esp,%ebp
     ee3:	8b 45 08             	mov    0x8(%ebp),%eax
     ee6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     eea:	0f b6 10             	movzbl (%eax),%edx
     eed:	84 d2                	test   %dl,%dl
     eef:	74 1b                	je     f0c <strchr+0x2c>
    if(*s == c)
     ef1:	38 d1                	cmp    %dl,%cl
     ef3:	75 0f                	jne    f04 <strchr+0x24>
     ef5:	eb 17                	jmp    f0e <strchr+0x2e>
     ef7:	89 f6                	mov    %esi,%esi
     ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     f00:	38 ca                	cmp    %cl,%dl
     f02:	74 0a                	je     f0e <strchr+0x2e>
  for(; *s; s++)
     f04:	40                   	inc    %eax
     f05:	0f b6 10             	movzbl (%eax),%edx
     f08:	84 d2                	test   %dl,%dl
     f0a:	75 f4                	jne    f00 <strchr+0x20>
      return (char*)s;
  return 0;
     f0c:	31 c0                	xor    %eax,%eax
}
     f0e:	5d                   	pop    %ebp
     f0f:	c3                   	ret    

00000f10 <gets>:

char*
gets(char *buf, int max)
{
     f10:	55                   	push   %ebp
     f11:	89 e5                	mov    %esp,%ebp
     f13:	57                   	push   %edi
     f14:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     f15:	31 f6                	xor    %esi,%esi
{
     f17:	53                   	push   %ebx
     f18:	83 ec 3c             	sub    $0x3c,%esp
     f1b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
     f1e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
     f21:	eb 32                	jmp    f55 <gets+0x45>
     f23:	90                   	nop
     f24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
     f28:	ba 01 00 00 00       	mov    $0x1,%edx
     f2d:	89 54 24 08          	mov    %edx,0x8(%esp)
     f31:	89 7c 24 04          	mov    %edi,0x4(%esp)
     f35:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     f3c:	e8 2f 01 00 00       	call   1070 <read>
    if(cc < 1)
     f41:	85 c0                	test   %eax,%eax
     f43:	7e 19                	jle    f5e <gets+0x4e>
      break;
    buf[i++] = c;
     f45:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     f49:	43                   	inc    %ebx
     f4a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
     f4d:	3c 0a                	cmp    $0xa,%al
     f4f:	74 1f                	je     f70 <gets+0x60>
     f51:	3c 0d                	cmp    $0xd,%al
     f53:	74 1b                	je     f70 <gets+0x60>
  for(i=0; i+1 < max; ){
     f55:	46                   	inc    %esi
     f56:	3b 75 0c             	cmp    0xc(%ebp),%esi
     f59:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
     f5c:	7c ca                	jl     f28 <gets+0x18>
      break;
  }
  buf[i] = '\0';
     f5e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     f61:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
     f64:	8b 45 08             	mov    0x8(%ebp),%eax
     f67:	83 c4 3c             	add    $0x3c,%esp
     f6a:	5b                   	pop    %ebx
     f6b:	5e                   	pop    %esi
     f6c:	5f                   	pop    %edi
     f6d:	5d                   	pop    %ebp
     f6e:	c3                   	ret    
     f6f:	90                   	nop
     f70:	8b 45 08             	mov    0x8(%ebp),%eax
     f73:	01 c6                	add    %eax,%esi
     f75:	89 75 d4             	mov    %esi,-0x2c(%ebp)
     f78:	eb e4                	jmp    f5e <gets+0x4e>
     f7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000f80 <stat>:

int
stat(const char *n, struct stat *st)
{
     f80:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     f81:	31 c0                	xor    %eax,%eax
{
     f83:	89 e5                	mov    %esp,%ebp
     f85:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
     f88:	89 44 24 04          	mov    %eax,0x4(%esp)
     f8c:	8b 45 08             	mov    0x8(%ebp),%eax
{
     f8f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     f92:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
     f95:	89 04 24             	mov    %eax,(%esp)
     f98:	e8 fb 00 00 00       	call   1098 <open>
  if(fd < 0)
     f9d:	85 c0                	test   %eax,%eax
     f9f:	78 2f                	js     fd0 <stat+0x50>
     fa1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
     fa3:	8b 45 0c             	mov    0xc(%ebp),%eax
     fa6:	89 1c 24             	mov    %ebx,(%esp)
     fa9:	89 44 24 04          	mov    %eax,0x4(%esp)
     fad:	e8 fe 00 00 00       	call   10b0 <fstat>
  close(fd);
     fb2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     fb5:	89 c6                	mov    %eax,%esi
  close(fd);
     fb7:	e8 c4 00 00 00       	call   1080 <close>
  return r;
}
     fbc:	89 f0                	mov    %esi,%eax
     fbe:	8b 5d f8             	mov    -0x8(%ebp),%ebx
     fc1:	8b 75 fc             	mov    -0x4(%ebp),%esi
     fc4:	89 ec                	mov    %ebp,%esp
     fc6:	5d                   	pop    %ebp
     fc7:	c3                   	ret    
     fc8:	90                   	nop
     fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
     fd0:	be ff ff ff ff       	mov    $0xffffffff,%esi
     fd5:	eb e5                	jmp    fbc <stat+0x3c>
     fd7:	89 f6                	mov    %esi,%esi
     fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000fe0 <atoi>:

int
atoi(const char *s)
{
     fe0:	55                   	push   %ebp
     fe1:	89 e5                	mov    %esp,%ebp
     fe3:	8b 4d 08             	mov    0x8(%ebp),%ecx
     fe6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     fe7:	0f be 11             	movsbl (%ecx),%edx
     fea:	88 d0                	mov    %dl,%al
     fec:	2c 30                	sub    $0x30,%al
     fee:	3c 09                	cmp    $0x9,%al
  n = 0;
     ff0:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
     ff5:	77 1e                	ja     1015 <atoi+0x35>
     ff7:	89 f6                	mov    %esi,%esi
     ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    1000:	41                   	inc    %ecx
    1001:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1004:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    1008:	0f be 11             	movsbl (%ecx),%edx
    100b:	88 d3                	mov    %dl,%bl
    100d:	80 eb 30             	sub    $0x30,%bl
    1010:	80 fb 09             	cmp    $0x9,%bl
    1013:	76 eb                	jbe    1000 <atoi+0x20>
  return n;
}
    1015:	5b                   	pop    %ebx
    1016:	5d                   	pop    %ebp
    1017:	c3                   	ret    
    1018:	90                   	nop
    1019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001020 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1020:	55                   	push   %ebp
    1021:	89 e5                	mov    %esp,%ebp
    1023:	56                   	push   %esi
    1024:	8b 45 08             	mov    0x8(%ebp),%eax
    1027:	53                   	push   %ebx
    1028:	8b 5d 10             	mov    0x10(%ebp),%ebx
    102b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    102e:	85 db                	test   %ebx,%ebx
    1030:	7e 1a                	jle    104c <memmove+0x2c>
    1032:	31 d2                	xor    %edx,%edx
    1034:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    103a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
    1040:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    1044:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    1047:	42                   	inc    %edx
  while(n-- > 0)
    1048:	39 d3                	cmp    %edx,%ebx
    104a:	75 f4                	jne    1040 <memmove+0x20>
  return vdst;
}
    104c:	5b                   	pop    %ebx
    104d:	5e                   	pop    %esi
    104e:	5d                   	pop    %ebp
    104f:	c3                   	ret    

00001050 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1050:	b8 01 00 00 00       	mov    $0x1,%eax
    1055:	cd 40                	int    $0x40
    1057:	c3                   	ret    

00001058 <exit>:
SYSCALL(exit)
    1058:	b8 02 00 00 00       	mov    $0x2,%eax
    105d:	cd 40                	int    $0x40
    105f:	c3                   	ret    

00001060 <wait>:
SYSCALL(wait)
    1060:	b8 03 00 00 00       	mov    $0x3,%eax
    1065:	cd 40                	int    $0x40
    1067:	c3                   	ret    

00001068 <pipe>:
SYSCALL(pipe)
    1068:	b8 04 00 00 00       	mov    $0x4,%eax
    106d:	cd 40                	int    $0x40
    106f:	c3                   	ret    

00001070 <read>:
SYSCALL(read)
    1070:	b8 05 00 00 00       	mov    $0x5,%eax
    1075:	cd 40                	int    $0x40
    1077:	c3                   	ret    

00001078 <write>:
SYSCALL(write)
    1078:	b8 10 00 00 00       	mov    $0x10,%eax
    107d:	cd 40                	int    $0x40
    107f:	c3                   	ret    

00001080 <close>:
SYSCALL(close)
    1080:	b8 15 00 00 00       	mov    $0x15,%eax
    1085:	cd 40                	int    $0x40
    1087:	c3                   	ret    

00001088 <kill>:
SYSCALL(kill)
    1088:	b8 06 00 00 00       	mov    $0x6,%eax
    108d:	cd 40                	int    $0x40
    108f:	c3                   	ret    

00001090 <exec>:
SYSCALL(exec)
    1090:	b8 07 00 00 00       	mov    $0x7,%eax
    1095:	cd 40                	int    $0x40
    1097:	c3                   	ret    

00001098 <open>:
SYSCALL(open)
    1098:	b8 0f 00 00 00       	mov    $0xf,%eax
    109d:	cd 40                	int    $0x40
    109f:	c3                   	ret    

000010a0 <mknod>:
SYSCALL(mknod)
    10a0:	b8 11 00 00 00       	mov    $0x11,%eax
    10a5:	cd 40                	int    $0x40
    10a7:	c3                   	ret    

000010a8 <unlink>:
SYSCALL(unlink)
    10a8:	b8 12 00 00 00       	mov    $0x12,%eax
    10ad:	cd 40                	int    $0x40
    10af:	c3                   	ret    

000010b0 <fstat>:
SYSCALL(fstat)
    10b0:	b8 08 00 00 00       	mov    $0x8,%eax
    10b5:	cd 40                	int    $0x40
    10b7:	c3                   	ret    

000010b8 <link>:
SYSCALL(link)
    10b8:	b8 13 00 00 00       	mov    $0x13,%eax
    10bd:	cd 40                	int    $0x40
    10bf:	c3                   	ret    

000010c0 <mkdir>:
SYSCALL(mkdir)
    10c0:	b8 14 00 00 00       	mov    $0x14,%eax
    10c5:	cd 40                	int    $0x40
    10c7:	c3                   	ret    

000010c8 <chdir>:
SYSCALL(chdir)
    10c8:	b8 09 00 00 00       	mov    $0x9,%eax
    10cd:	cd 40                	int    $0x40
    10cf:	c3                   	ret    

000010d0 <dup>:
SYSCALL(dup)
    10d0:	b8 0a 00 00 00       	mov    $0xa,%eax
    10d5:	cd 40                	int    $0x40
    10d7:	c3                   	ret    

000010d8 <getpid>:
SYSCALL(getpid)
    10d8:	b8 0b 00 00 00       	mov    $0xb,%eax
    10dd:	cd 40                	int    $0x40
    10df:	c3                   	ret    

000010e0 <sbrk>:
SYSCALL(sbrk)
    10e0:	b8 0c 00 00 00       	mov    $0xc,%eax
    10e5:	cd 40                	int    $0x40
    10e7:	c3                   	ret    

000010e8 <sleep>:
SYSCALL(sleep)
    10e8:	b8 0d 00 00 00       	mov    $0xd,%eax
    10ed:	cd 40                	int    $0x40
    10ef:	c3                   	ret    

000010f0 <uptime>:
SYSCALL(uptime)
    10f0:	b8 0e 00 00 00       	mov    $0xe,%eax
    10f5:	cd 40                	int    $0x40
    10f7:	c3                   	ret    

000010f8 <policy>:
SYSCALL(policy)
    10f8:	b8 17 00 00 00       	mov    $0x17,%eax
    10fd:	cd 40                	int    $0x40
    10ff:	c3                   	ret    

00001100 <detach>:
SYSCALL(detach)
    1100:	b8 16 00 00 00       	mov    $0x16,%eax
    1105:	cd 40                	int    $0x40
    1107:	c3                   	ret    

00001108 <priority>:
SYSCALL(priority)
    1108:	b8 18 00 00 00       	mov    $0x18,%eax
    110d:	cd 40                	int    $0x40
    110f:	c3                   	ret    

00001110 <wait_stat>:
SYSCALL(wait_stat)
    1110:	b8 19 00 00 00       	mov    $0x19,%eax
    1115:	cd 40                	int    $0x40
    1117:	c3                   	ret    
    1118:	66 90                	xchg   %ax,%ax
    111a:	66 90                	xchg   %ax,%ax
    111c:	66 90                	xchg   %ax,%ax
    111e:	66 90                	xchg   %ax,%ax

00001120 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1120:	55                   	push   %ebp
    1121:	89 e5                	mov    %esp,%ebp
    1123:	57                   	push   %edi
    1124:	56                   	push   %esi
    1125:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1126:	89 d3                	mov    %edx,%ebx
    1128:	c1 eb 1f             	shr    $0x1f,%ebx
{
    112b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
    112e:	84 db                	test   %bl,%bl
{
    1130:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1133:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    1135:	74 79                	je     11b0 <printint+0x90>
    1137:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    113b:	74 73                	je     11b0 <printint+0x90>
    neg = 1;
    x = -xx;
    113d:	f7 d8                	neg    %eax
    neg = 1;
    113f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1146:	31 f6                	xor    %esi,%esi
    1148:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    114b:	eb 05                	jmp    1152 <printint+0x32>
    114d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1150:	89 fe                	mov    %edi,%esi
    1152:	31 d2                	xor    %edx,%edx
    1154:	f7 f1                	div    %ecx
    1156:	8d 7e 01             	lea    0x1(%esi),%edi
    1159:	0f b6 92 6c 1a 00 00 	movzbl 0x1a6c(%edx),%edx
  }while((x /= base) != 0);
    1160:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    1162:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    1165:	75 e9                	jne    1150 <printint+0x30>
  if(neg)
    1167:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    116a:	85 d2                	test   %edx,%edx
    116c:	74 08                	je     1176 <printint+0x56>
    buf[i++] = '-';
    116e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    1173:	8d 7e 02             	lea    0x2(%esi),%edi
    1176:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    117a:	8b 7d c0             	mov    -0x40(%ebp),%edi
    117d:	8d 76 00             	lea    0x0(%esi),%esi
    1180:	0f b6 06             	movzbl (%esi),%eax
    1183:	4e                   	dec    %esi
  write(fd, &c, 1);
    1184:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    1188:	89 3c 24             	mov    %edi,(%esp)
    118b:	88 45 d7             	mov    %al,-0x29(%ebp)
    118e:	b8 01 00 00 00       	mov    $0x1,%eax
    1193:	89 44 24 08          	mov    %eax,0x8(%esp)
    1197:	e8 dc fe ff ff       	call   1078 <write>

  while(--i >= 0)
    119c:	39 de                	cmp    %ebx,%esi
    119e:	75 e0                	jne    1180 <printint+0x60>
    putc(fd, buf[i]);
}
    11a0:	83 c4 4c             	add    $0x4c,%esp
    11a3:	5b                   	pop    %ebx
    11a4:	5e                   	pop    %esi
    11a5:	5f                   	pop    %edi
    11a6:	5d                   	pop    %ebp
    11a7:	c3                   	ret    
    11a8:	90                   	nop
    11a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    11b0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    11b7:	eb 8d                	jmp    1146 <printint+0x26>
    11b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000011c0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    11c0:	55                   	push   %ebp
    11c1:	89 e5                	mov    %esp,%ebp
    11c3:	57                   	push   %edi
    11c4:	56                   	push   %esi
    11c5:	53                   	push   %ebx
    11c6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    11c9:	8b 75 0c             	mov    0xc(%ebp),%esi
    11cc:	0f b6 1e             	movzbl (%esi),%ebx
    11cf:	84 db                	test   %bl,%bl
    11d1:	0f 84 d1 00 00 00    	je     12a8 <printf+0xe8>
  state = 0;
    11d7:	31 ff                	xor    %edi,%edi
    11d9:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
    11da:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
    11dd:	89 fa                	mov    %edi,%edx
    11df:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
    11e2:	89 45 d0             	mov    %eax,-0x30(%ebp)
    11e5:	eb 41                	jmp    1228 <printf+0x68>
    11e7:	89 f6                	mov    %esi,%esi
    11e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    11f0:	83 f8 25             	cmp    $0x25,%eax
    11f3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
    11f6:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    11fb:	74 1e                	je     121b <printf+0x5b>
  write(fd, &c, 1);
    11fd:	b8 01 00 00 00       	mov    $0x1,%eax
    1202:	89 44 24 08          	mov    %eax,0x8(%esp)
    1206:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1209:	89 44 24 04          	mov    %eax,0x4(%esp)
    120d:	89 3c 24             	mov    %edi,(%esp)
    1210:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    1213:	e8 60 fe ff ff       	call   1078 <write>
    1218:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    121b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
    121c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    1220:	84 db                	test   %bl,%bl
    1222:	0f 84 80 00 00 00    	je     12a8 <printf+0xe8>
    if(state == 0){
    1228:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
    122a:	0f be cb             	movsbl %bl,%ecx
    122d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1230:	74 be                	je     11f0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1232:	83 fa 25             	cmp    $0x25,%edx
    1235:	75 e4                	jne    121b <printf+0x5b>
      if(c == 'd'){
    1237:	83 f8 64             	cmp    $0x64,%eax
    123a:	0f 84 f0 00 00 00    	je     1330 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1240:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    1246:	83 f9 70             	cmp    $0x70,%ecx
    1249:	74 65                	je     12b0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    124b:	83 f8 73             	cmp    $0x73,%eax
    124e:	0f 84 8c 00 00 00    	je     12e0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1254:	83 f8 63             	cmp    $0x63,%eax
    1257:	0f 84 13 01 00 00    	je     1370 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    125d:	83 f8 25             	cmp    $0x25,%eax
    1260:	0f 84 e2 00 00 00    	je     1348 <printf+0x188>
  write(fd, &c, 1);
    1266:	b8 01 00 00 00       	mov    $0x1,%eax
    126b:	46                   	inc    %esi
    126c:	89 44 24 08          	mov    %eax,0x8(%esp)
    1270:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1273:	89 44 24 04          	mov    %eax,0x4(%esp)
    1277:	89 3c 24             	mov    %edi,(%esp)
    127a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    127e:	e8 f5 fd ff ff       	call   1078 <write>
    1283:	ba 01 00 00 00       	mov    $0x1,%edx
    1288:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    128b:	89 54 24 08          	mov    %edx,0x8(%esp)
    128f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1293:	89 3c 24             	mov    %edi,(%esp)
    1296:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    1299:	e8 da fd ff ff       	call   1078 <write>
  for(i = 0; fmt[i]; i++){
    129e:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    12a2:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    12a4:	84 db                	test   %bl,%bl
    12a6:	75 80                	jne    1228 <printf+0x68>
    }
  }
}
    12a8:	83 c4 3c             	add    $0x3c,%esp
    12ab:	5b                   	pop    %ebx
    12ac:	5e                   	pop    %esi
    12ad:	5f                   	pop    %edi
    12ae:	5d                   	pop    %ebp
    12af:	c3                   	ret    
        printint(fd, *ap, 16, 0);
    12b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    12b7:	b9 10 00 00 00       	mov    $0x10,%ecx
    12bc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    12bf:	89 f8                	mov    %edi,%eax
    12c1:	8b 13                	mov    (%ebx),%edx
    12c3:	e8 58 fe ff ff       	call   1120 <printint>
        ap++;
    12c8:	89 d8                	mov    %ebx,%eax
      state = 0;
    12ca:	31 d2                	xor    %edx,%edx
        ap++;
    12cc:	83 c0 04             	add    $0x4,%eax
    12cf:	89 45 d0             	mov    %eax,-0x30(%ebp)
    12d2:	e9 44 ff ff ff       	jmp    121b <printf+0x5b>
    12d7:	89 f6                	mov    %esi,%esi
    12d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
    12e0:	8b 45 d0             	mov    -0x30(%ebp),%eax
    12e3:	8b 10                	mov    (%eax),%edx
        ap++;
    12e5:	83 c0 04             	add    $0x4,%eax
    12e8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    12eb:	85 d2                	test   %edx,%edx
    12ed:	0f 84 aa 00 00 00    	je     139d <printf+0x1dd>
        while(*s != 0){
    12f3:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
    12f6:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
    12f8:	84 c0                	test   %al,%al
    12fa:	74 27                	je     1323 <printf+0x163>
    12fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1300:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    1303:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
    1308:	43                   	inc    %ebx
  write(fd, &c, 1);
    1309:	89 44 24 08          	mov    %eax,0x8(%esp)
    130d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    1310:	89 44 24 04          	mov    %eax,0x4(%esp)
    1314:	89 3c 24             	mov    %edi,(%esp)
    1317:	e8 5c fd ff ff       	call   1078 <write>
        while(*s != 0){
    131c:	0f b6 03             	movzbl (%ebx),%eax
    131f:	84 c0                	test   %al,%al
    1321:	75 dd                	jne    1300 <printf+0x140>
      state = 0;
    1323:	31 d2                	xor    %edx,%edx
    1325:	e9 f1 fe ff ff       	jmp    121b <printf+0x5b>
    132a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    1330:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1337:	b9 0a 00 00 00       	mov    $0xa,%ecx
    133c:	e9 7b ff ff ff       	jmp    12bc <printf+0xfc>
    1341:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
    1348:	b9 01 00 00 00       	mov    $0x1,%ecx
    134d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1350:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    1354:	89 44 24 04          	mov    %eax,0x4(%esp)
    1358:	89 3c 24             	mov    %edi,(%esp)
    135b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    135e:	e8 15 fd ff ff       	call   1078 <write>
      state = 0;
    1363:	31 d2                	xor    %edx,%edx
    1365:	e9 b1 fe ff ff       	jmp    121b <printf+0x5b>
    136a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
    1370:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    1373:	8b 03                	mov    (%ebx),%eax
        ap++;
    1375:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    1378:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
    137b:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    137e:	b8 01 00 00 00       	mov    $0x1,%eax
    1383:	89 44 24 08          	mov    %eax,0x8(%esp)
    1387:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    138a:	89 44 24 04          	mov    %eax,0x4(%esp)
    138e:	e8 e5 fc ff ff       	call   1078 <write>
      state = 0;
    1393:	31 d2                	xor    %edx,%edx
        ap++;
    1395:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    1398:	e9 7e fe ff ff       	jmp    121b <printf+0x5b>
          s = "(null)";
    139d:	bb 64 1a 00 00       	mov    $0x1a64,%ebx
        while(*s != 0){
    13a2:	b0 28                	mov    $0x28,%al
    13a4:	e9 57 ff ff ff       	jmp    1300 <printf+0x140>
    13a9:	66 90                	xchg   %ax,%ax
    13ab:	66 90                	xchg   %ax,%ax
    13ad:	66 90                	xchg   %ax,%ax
    13af:	90                   	nop

000013b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    13b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    13b1:	a1 50 20 00 00       	mov    0x2050,%eax
{
    13b6:	89 e5                	mov    %esp,%ebp
    13b8:	57                   	push   %edi
    13b9:	56                   	push   %esi
    13ba:	53                   	push   %ebx
    13bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    13be:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    13c1:	eb 0d                	jmp    13d0 <free+0x20>
    13c3:	90                   	nop
    13c4:	90                   	nop
    13c5:	90                   	nop
    13c6:	90                   	nop
    13c7:	90                   	nop
    13c8:	90                   	nop
    13c9:	90                   	nop
    13ca:	90                   	nop
    13cb:	90                   	nop
    13cc:	90                   	nop
    13cd:	90                   	nop
    13ce:	90                   	nop
    13cf:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    13d0:	39 c8                	cmp    %ecx,%eax
    13d2:	8b 10                	mov    (%eax),%edx
    13d4:	73 32                	jae    1408 <free+0x58>
    13d6:	39 d1                	cmp    %edx,%ecx
    13d8:	72 04                	jb     13de <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    13da:	39 d0                	cmp    %edx,%eax
    13dc:	72 32                	jb     1410 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
    13de:	8b 73 fc             	mov    -0x4(%ebx),%esi
    13e1:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    13e4:	39 fa                	cmp    %edi,%edx
    13e6:	74 30                	je     1418 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    13e8:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    13eb:	8b 50 04             	mov    0x4(%eax),%edx
    13ee:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    13f1:	39 f1                	cmp    %esi,%ecx
    13f3:	74 3c                	je     1431 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    13f5:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
    13f7:	5b                   	pop    %ebx
  freep = p;
    13f8:	a3 50 20 00 00       	mov    %eax,0x2050
}
    13fd:	5e                   	pop    %esi
    13fe:	5f                   	pop    %edi
    13ff:	5d                   	pop    %ebp
    1400:	c3                   	ret    
    1401:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1408:	39 d0                	cmp    %edx,%eax
    140a:	72 04                	jb     1410 <free+0x60>
    140c:	39 d1                	cmp    %edx,%ecx
    140e:	72 ce                	jb     13de <free+0x2e>
{
    1410:	89 d0                	mov    %edx,%eax
    1412:	eb bc                	jmp    13d0 <free+0x20>
    1414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1418:	8b 7a 04             	mov    0x4(%edx),%edi
    141b:	01 fe                	add    %edi,%esi
    141d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1420:	8b 10                	mov    (%eax),%edx
    1422:	8b 12                	mov    (%edx),%edx
    1424:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1427:	8b 50 04             	mov    0x4(%eax),%edx
    142a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    142d:	39 f1                	cmp    %esi,%ecx
    142f:	75 c4                	jne    13f5 <free+0x45>
    p->s.size += bp->s.size;
    1431:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
    1434:	a3 50 20 00 00       	mov    %eax,0x2050
    p->s.size += bp->s.size;
    1439:	01 ca                	add    %ecx,%edx
    143b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    143e:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1441:	89 10                	mov    %edx,(%eax)
}
    1443:	5b                   	pop    %ebx
    1444:	5e                   	pop    %esi
    1445:	5f                   	pop    %edi
    1446:	5d                   	pop    %ebp
    1447:	c3                   	ret    
    1448:	90                   	nop
    1449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001450 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1450:	55                   	push   %ebp
    1451:	89 e5                	mov    %esp,%ebp
    1453:	57                   	push   %edi
    1454:	56                   	push   %esi
    1455:	53                   	push   %ebx
    1456:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1459:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    145c:	8b 15 50 20 00 00    	mov    0x2050,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1462:	8d 78 07             	lea    0x7(%eax),%edi
    1465:	c1 ef 03             	shr    $0x3,%edi
    1468:	47                   	inc    %edi
  if((prevp = freep) == 0){
    1469:	85 d2                	test   %edx,%edx
    146b:	0f 84 8f 00 00 00    	je     1500 <malloc+0xb0>
    1471:	8b 02                	mov    (%edx),%eax
    1473:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1476:	39 cf                	cmp    %ecx,%edi
    1478:	76 66                	jbe    14e0 <malloc+0x90>
    147a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1480:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1485:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    1488:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    148f:	eb 10                	jmp    14a1 <malloc+0x51>
    1491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1498:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    149a:	8b 48 04             	mov    0x4(%eax),%ecx
    149d:	39 f9                	cmp    %edi,%ecx
    149f:	73 3f                	jae    14e0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    14a1:	39 05 50 20 00 00    	cmp    %eax,0x2050
    14a7:	89 c2                	mov    %eax,%edx
    14a9:	75 ed                	jne    1498 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    14ab:	89 34 24             	mov    %esi,(%esp)
    14ae:	e8 2d fc ff ff       	call   10e0 <sbrk>
  if(p == (char*)-1)
    14b3:	83 f8 ff             	cmp    $0xffffffff,%eax
    14b6:	74 18                	je     14d0 <malloc+0x80>
  hp->s.size = nu;
    14b8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    14bb:	83 c0 08             	add    $0x8,%eax
    14be:	89 04 24             	mov    %eax,(%esp)
    14c1:	e8 ea fe ff ff       	call   13b0 <free>
  return freep;
    14c6:	8b 15 50 20 00 00    	mov    0x2050,%edx
      if((p = morecore(nunits)) == 0)
    14cc:	85 d2                	test   %edx,%edx
    14ce:	75 c8                	jne    1498 <malloc+0x48>
        return 0;
  }
}
    14d0:	83 c4 1c             	add    $0x1c,%esp
        return 0;
    14d3:	31 c0                	xor    %eax,%eax
}
    14d5:	5b                   	pop    %ebx
    14d6:	5e                   	pop    %esi
    14d7:	5f                   	pop    %edi
    14d8:	5d                   	pop    %ebp
    14d9:	c3                   	ret    
    14da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    14e0:	39 cf                	cmp    %ecx,%edi
    14e2:	74 4c                	je     1530 <malloc+0xe0>
        p->s.size -= nunits;
    14e4:	29 f9                	sub    %edi,%ecx
    14e6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    14e9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    14ec:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    14ef:	89 15 50 20 00 00    	mov    %edx,0x2050
}
    14f5:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
    14f8:	83 c0 08             	add    $0x8,%eax
}
    14fb:	5b                   	pop    %ebx
    14fc:	5e                   	pop    %esi
    14fd:	5f                   	pop    %edi
    14fe:	5d                   	pop    %ebp
    14ff:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    1500:	b8 54 20 00 00       	mov    $0x2054,%eax
    1505:	ba 54 20 00 00       	mov    $0x2054,%edx
    base.s.size = 0;
    150a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
    150c:	a3 50 20 00 00       	mov    %eax,0x2050
    base.s.size = 0;
    1511:	b8 54 20 00 00       	mov    $0x2054,%eax
    base.s.ptr = freep = prevp = &base;
    1516:	89 15 54 20 00 00    	mov    %edx,0x2054
    base.s.size = 0;
    151c:	89 0d 58 20 00 00    	mov    %ecx,0x2058
    1522:	e9 53 ff ff ff       	jmp    147a <malloc+0x2a>
    1527:	89 f6                	mov    %esi,%esi
    1529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
    1530:	8b 08                	mov    (%eax),%ecx
    1532:	89 0a                	mov    %ecx,(%edx)
    1534:	eb b9                	jmp    14ef <malloc+0x9f>
