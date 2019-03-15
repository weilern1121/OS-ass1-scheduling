
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

int
main(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 e4 f0             	and    $0xfffffff0,%esp
       6:	83 ec 10             	sub    $0x10,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
       9:	eb 0a                	jmp    15 <main+0x15>
       b:	90                   	nop
       c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(fd >= 3){
      10:	83 f8 02             	cmp    $0x2,%eax
      13:	7f 78                	jg     8d <main+0x8d>
  while((fd = open("console", O_RDWR)) >= 0){
      15:	ba 02 00 00 00       	mov    $0x2,%edx
      1a:	89 54 24 04          	mov    %edx,0x4(%esp)
      1e:	c7 04 24 a9 13 00 00 	movl   $0x13a9,(%esp)
      25:	e8 5e 0e 00 00       	call   e88 <open>
      2a:	85 c0                	test   %eax,%eax
      2c:	79 e2                	jns    10 <main+0x10>
      2e:	eb 1c                	jmp    4c <main+0x4c>
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      30:	80 3d c2 19 00 00 20 	cmpb   $0x20,0x19c2
      37:	74 77                	je     b0 <main+0xb0>
int
fork1(void)
{
  int pid;

  pid = fork();
      39:	e8 02 0e 00 00       	call   e40 <fork>
  if(pid == -1)
      3e:	83 f8 ff             	cmp    $0xffffffff,%eax
      41:	74 3e                	je     81 <main+0x81>
    if(fork1() == 0)
      43:	85 c0                	test   %eax,%eax
      45:	74 55                	je     9c <main+0x9c>
    wait();
      47:	e8 04 0e 00 00       	call   e50 <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
      4c:	b8 64 00 00 00       	mov    $0x64,%eax
      51:	89 44 24 04          	mov    %eax,0x4(%esp)
      55:	c7 04 24 c0 19 00 00 	movl   $0x19c0,(%esp)
      5c:	e8 9f 00 00 00       	call   100 <getcmd>
      61:	85 c0                	test   %eax,%eax
      63:	78 32                	js     97 <main+0x97>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      65:	80 3d c0 19 00 00 63 	cmpb   $0x63,0x19c0
      6c:	75 cb                	jne    39 <main+0x39>
      6e:	80 3d c1 19 00 00 64 	cmpb   $0x64,0x19c1
      75:	74 b9                	je     30 <main+0x30>
  pid = fork();
      77:	e8 c4 0d 00 00       	call   e40 <fork>
  if(pid == -1)
      7c:	83 f8 ff             	cmp    $0xffffffff,%eax
      7f:	75 c2                	jne    43 <main+0x43>
    panic("fork");
      81:	c7 04 24 32 13 00 00 	movl   $0x1332,(%esp)
      88:	e8 d3 00 00 00       	call   160 <panic>
      close(fd);
      8d:	89 04 24             	mov    %eax,(%esp)
      90:	e8 db 0d 00 00       	call   e70 <close>
      break;
      95:	eb b5                	jmp    4c <main+0x4c>
  exit();
      97:	e8 ac 0d 00 00       	call   e48 <exit>
      runcmd(parsecmd(buf));
      9c:	c7 04 24 c0 19 00 00 	movl   $0x19c0,(%esp)
      a3:	e8 f8 0a 00 00       	call   ba0 <parsecmd>
      a8:	89 04 24             	mov    %eax,(%esp)
      ab:	e8 e0 00 00 00       	call   190 <runcmd>
      buf[strlen(buf)-1] = 0;  // chop \n
      b0:	c7 04 24 c0 19 00 00 	movl   $0x19c0,(%esp)
      b7:	e8 c4 0b 00 00       	call   c80 <strlen>
      if(chdir(buf+3) < 0)
      bc:	c7 04 24 c3 19 00 00 	movl   $0x19c3,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
      c3:	c6 80 bf 19 00 00 00 	movb   $0x0,0x19bf(%eax)
      if(chdir(buf+3) < 0)
      ca:	e8 e9 0d 00 00       	call   eb8 <chdir>
      cf:	85 c0                	test   %eax,%eax
      d1:	0f 89 75 ff ff ff    	jns    4c <main+0x4c>
        printf(2, "cannot cd %s\n", buf+3);
      d7:	c7 44 24 08 c3 19 00 	movl   $0x19c3,0x8(%esp)
      de:	00 
      df:	c7 44 24 04 b1 13 00 	movl   $0x13b1,0x4(%esp)
      e6:	00 
      e7:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      ee:	e8 9d 0e 00 00       	call   f90 <printf>
      f3:	e9 54 ff ff ff       	jmp    4c <main+0x4c>
      f8:	66 90                	xchg   %ax,%ax
      fa:	66 90                	xchg   %ax,%ax
      fc:	66 90                	xchg   %ax,%ax
      fe:	66 90                	xchg   %ax,%ax

00000100 <getcmd>:
{
     100:	55                   	push   %ebp
  printf(2, "$ ");
     101:	b8 08 13 00 00       	mov    $0x1308,%eax
{
     106:	89 e5                	mov    %esp,%ebp
     108:	83 ec 18             	sub    $0x18,%esp
     10b:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     10e:	8b 5d 08             	mov    0x8(%ebp),%ebx
     111:	89 75 fc             	mov    %esi,-0x4(%ebp)
     114:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf(2, "$ ");
     117:	89 44 24 04          	mov    %eax,0x4(%esp)
     11b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     122:	e8 69 0e 00 00       	call   f90 <printf>
  memset(buf, 0, nbuf);
     127:	31 d2                	xor    %edx,%edx
     129:	89 74 24 08          	mov    %esi,0x8(%esp)
     12d:	89 54 24 04          	mov    %edx,0x4(%esp)
     131:	89 1c 24             	mov    %ebx,(%esp)
     134:	e8 77 0b 00 00       	call   cb0 <memset>
  gets(buf, nbuf);
     139:	89 74 24 04          	mov    %esi,0x4(%esp)
     13d:	89 1c 24             	mov    %ebx,(%esp)
     140:	e8 bb 0b 00 00       	call   d00 <gets>
  if(buf[0] == 0) // EOF
     145:	31 c0                	xor    %eax,%eax
}
     147:	8b 75 fc             	mov    -0x4(%ebp),%esi
  if(buf[0] == 0) // EOF
     14a:	80 3b 00             	cmpb   $0x0,(%ebx)
}
     14d:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  if(buf[0] == 0) // EOF
     150:	0f 94 c0             	sete   %al
}
     153:	89 ec                	mov    %ebp,%esp
  if(buf[0] == 0) // EOF
     155:	f7 d8                	neg    %eax
}
     157:	5d                   	pop    %ebp
     158:	c3                   	ret    
     159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000160 <panic>:
{
     160:	55                   	push   %ebp
     161:	89 e5                	mov    %esp,%ebp
     163:	83 ec 18             	sub    $0x18,%esp
  printf(2, "%s\n", s);
     166:	8b 45 08             	mov    0x8(%ebp),%eax
     169:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     170:	89 44 24 08          	mov    %eax,0x8(%esp)
     174:	b8 a5 13 00 00       	mov    $0x13a5,%eax
     179:	89 44 24 04          	mov    %eax,0x4(%esp)
     17d:	e8 0e 0e 00 00       	call   f90 <printf>
  exit();
     182:	e8 c1 0c 00 00       	call   e48 <exit>
     187:	89 f6                	mov    %esi,%esi
     189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000190 <runcmd>:
{
     190:	55                   	push   %ebp
     191:	89 e5                	mov    %esp,%ebp
     193:	53                   	push   %ebx
     194:	83 ec 24             	sub    $0x24,%esp
     197:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     19a:	85 db                	test   %ebx,%ebx
     19c:	74 52                	je     1f0 <runcmd+0x60>
  switch(cmd->type){
     19e:	83 3b 05             	cmpl   $0x5,(%ebx)
     1a1:	0f 87 29 01 00 00    	ja     2d0 <runcmd+0x140>
     1a7:	8b 03                	mov    (%ebx),%eax
     1a9:	ff 24 85 c0 13 00 00 	jmp    *0x13c0(,%eax,4)
    close(rcmd->fd);
     1b0:	8b 43 14             	mov    0x14(%ebx),%eax
     1b3:	89 04 24             	mov    %eax,(%esp)
     1b6:	e8 b5 0c 00 00       	call   e70 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     1bb:	8b 43 10             	mov    0x10(%ebx),%eax
     1be:	89 44 24 04          	mov    %eax,0x4(%esp)
     1c2:	8b 43 08             	mov    0x8(%ebx),%eax
     1c5:	89 04 24             	mov    %eax,(%esp)
     1c8:	e8 bb 0c 00 00       	call   e88 <open>
     1cd:	85 c0                	test   %eax,%eax
     1cf:	79 36                	jns    207 <runcmd+0x77>
      printf(2, "open %s failed\n", rcmd->file);
     1d1:	8b 43 08             	mov    0x8(%ebx),%eax
     1d4:	c7 44 24 04 22 13 00 	movl   $0x1322,0x4(%esp)
     1db:	00 
     1dc:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     1e3:	89 44 24 08          	mov    %eax,0x8(%esp)
     1e7:	e8 a4 0d 00 00       	call   f90 <printf>
     1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      exit();
     1f0:	e8 53 0c 00 00       	call   e48 <exit>
  pid = fork();
     1f5:	e8 46 0c 00 00       	call   e40 <fork>
  if(pid == -1)
     1fa:	83 f8 ff             	cmp    $0xffffffff,%eax
     1fd:	0f 84 d9 00 00 00    	je     2dc <runcmd+0x14c>
    if(fork1() == 0)
     203:	85 c0                	test   %eax,%eax
     205:	75 e9                	jne    1f0 <runcmd+0x60>
      runcmd(bcmd->cmd);
     207:	8b 43 04             	mov    0x4(%ebx),%eax
     20a:	89 04 24             	mov    %eax,(%esp)
     20d:	e8 7e ff ff ff       	call   190 <runcmd>
    if(ecmd->argv[0] == 0)
     212:	8b 43 04             	mov    0x4(%ebx),%eax
     215:	85 c0                	test   %eax,%eax
     217:	74 d7                	je     1f0 <runcmd+0x60>
    exec(ecmd->argv[0], ecmd->argv);
     219:	8d 53 04             	lea    0x4(%ebx),%edx
     21c:	89 54 24 04          	mov    %edx,0x4(%esp)
     220:	89 04 24             	mov    %eax,(%esp)
     223:	e8 58 0c 00 00       	call   e80 <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     228:	8b 43 04             	mov    0x4(%ebx),%eax
     22b:	c7 44 24 04 12 13 00 	movl   $0x1312,0x4(%esp)
     232:	00 
     233:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     23a:	89 44 24 08          	mov    %eax,0x8(%esp)
     23e:	e8 4d 0d 00 00       	call   f90 <printf>
    break;
     243:	eb ab                	jmp    1f0 <runcmd+0x60>
    if(pipe(p) < 0)
     245:	8d 45 f0             	lea    -0x10(%ebp),%eax
     248:	89 04 24             	mov    %eax,(%esp)
     24b:	e8 08 0c 00 00       	call   e58 <pipe>
     250:	85 c0                	test   %eax,%eax
     252:	0f 88 c8 00 00 00    	js     320 <runcmd+0x190>
  pid = fork();
     258:	e8 e3 0b 00 00       	call   e40 <fork>
  if(pid == -1)
     25d:	83 f8 ff             	cmp    $0xffffffff,%eax
     260:	74 7a                	je     2dc <runcmd+0x14c>
    if(fork1() == 0){
     262:	85 c0                	test   %eax,%eax
     264:	0f 84 c2 00 00 00    	je     32c <runcmd+0x19c>
     26a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  pid = fork();
     270:	e8 cb 0b 00 00       	call   e40 <fork>
  if(pid == -1)
     275:	83 f8 ff             	cmp    $0xffffffff,%eax
     278:	74 62                	je     2dc <runcmd+0x14c>
    if(fork1() == 0){
     27a:	85 c0                	test   %eax,%eax
     27c:	74 6a                	je     2e8 <runcmd+0x158>
    close(p[0]);
     27e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     281:	89 04 24             	mov    %eax,(%esp)
     284:	e8 e7 0b 00 00       	call   e70 <close>
    close(p[1]);
     289:	8b 45 f4             	mov    -0xc(%ebp),%eax
     28c:	89 04 24             	mov    %eax,(%esp)
     28f:	e8 dc 0b 00 00       	call   e70 <close>
    wait();
     294:	e8 b7 0b 00 00       	call   e50 <wait>
    wait();
     299:	e8 b2 0b 00 00       	call   e50 <wait>
     29e:	66 90                	xchg   %ax,%ax
    break;
     2a0:	e9 4b ff ff ff       	jmp    1f0 <runcmd+0x60>
  pid = fork();
     2a5:	e8 96 0b 00 00       	call   e40 <fork>
  if(pid == -1)
     2aa:	83 f8 ff             	cmp    $0xffffffff,%eax
     2ad:	8d 76 00             	lea    0x0(%esi),%esi
     2b0:	74 2a                	je     2dc <runcmd+0x14c>
    if(fork1() == 0)
     2b2:	85 c0                	test   %eax,%eax
     2b4:	0f 84 4d ff ff ff    	je     207 <runcmd+0x77>
     2ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wait();
     2c0:	e8 8b 0b 00 00       	call   e50 <wait>
    runcmd(lcmd->right);
     2c5:	8b 43 08             	mov    0x8(%ebx),%eax
     2c8:	89 04 24             	mov    %eax,(%esp)
     2cb:	e8 c0 fe ff ff       	call   190 <runcmd>
    panic("runcmd");
     2d0:	c7 04 24 0b 13 00 00 	movl   $0x130b,(%esp)
     2d7:	e8 84 fe ff ff       	call   160 <panic>
    panic("fork");
     2dc:	c7 04 24 32 13 00 00 	movl   $0x1332,(%esp)
     2e3:	e8 78 fe ff ff       	call   160 <panic>
      close(0);
     2e8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     2ef:	e8 7c 0b 00 00       	call   e70 <close>
      dup(p[0]);
     2f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     2f7:	89 04 24             	mov    %eax,(%esp)
     2fa:	e8 c1 0b 00 00       	call   ec0 <dup>
      close(p[0]);
     2ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
     302:	89 04 24             	mov    %eax,(%esp)
     305:	e8 66 0b 00 00       	call   e70 <close>
      close(p[1]);
     30a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     30d:	89 04 24             	mov    %eax,(%esp)
     310:	e8 5b 0b 00 00       	call   e70 <close>
      runcmd(pcmd->right);
     315:	8b 43 08             	mov    0x8(%ebx),%eax
     318:	89 04 24             	mov    %eax,(%esp)
     31b:	e8 70 fe ff ff       	call   190 <runcmd>
      panic("pipe");
     320:	c7 04 24 37 13 00 00 	movl   $0x1337,(%esp)
     327:	e8 34 fe ff ff       	call   160 <panic>
      close(1);
     32c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     333:	e8 38 0b 00 00       	call   e70 <close>
      dup(p[1]);
     338:	8b 45 f4             	mov    -0xc(%ebp),%eax
     33b:	89 04 24             	mov    %eax,(%esp)
     33e:	e8 7d 0b 00 00       	call   ec0 <dup>
      close(p[0]);
     343:	8b 45 f0             	mov    -0x10(%ebp),%eax
     346:	89 04 24             	mov    %eax,(%esp)
     349:	e8 22 0b 00 00       	call   e70 <close>
      close(p[1]);
     34e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     351:	89 04 24             	mov    %eax,(%esp)
     354:	e8 17 0b 00 00       	call   e70 <close>
      runcmd(pcmd->left);
     359:	8b 43 04             	mov    0x4(%ebx),%eax
     35c:	89 04 24             	mov    %eax,(%esp)
     35f:	e8 2c fe ff ff       	call   190 <runcmd>
     364:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     36a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000370 <fork1>:
{
     370:	55                   	push   %ebp
     371:	89 e5                	mov    %esp,%ebp
     373:	83 ec 18             	sub    $0x18,%esp
  pid = fork();
     376:	e8 c5 0a 00 00       	call   e40 <fork>
  if(pid == -1)
     37b:	83 f8 ff             	cmp    $0xffffffff,%eax
     37e:	74 02                	je     382 <fork1+0x12>
  return pid;
}
     380:	c9                   	leave  
     381:	c3                   	ret    
    panic("fork");
     382:	c7 04 24 32 13 00 00 	movl   $0x1332,(%esp)
     389:	e8 d2 fd ff ff       	call   160 <panic>
     38e:	66 90                	xchg   %ax,%ax

00000390 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     390:	55                   	push   %ebp
     391:	89 e5                	mov    %esp,%ebp
     393:	53                   	push   %ebx
     394:	83 ec 14             	sub    $0x14,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     397:	c7 04 24 54 00 00 00 	movl   $0x54,(%esp)
     39e:	e8 7d 0e 00 00       	call   1220 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3a3:	31 d2                	xor    %edx,%edx
     3a5:	89 54 24 04          	mov    %edx,0x4(%esp)
  cmd = malloc(sizeof(*cmd));
     3a9:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3ab:	b8 54 00 00 00       	mov    $0x54,%eax
     3b0:	89 1c 24             	mov    %ebx,(%esp)
     3b3:	89 44 24 08          	mov    %eax,0x8(%esp)
     3b7:	e8 f4 08 00 00       	call   cb0 <memset>
  cmd->type = EXEC;
  return (struct cmd*)cmd;
}
     3bc:	89 d8                	mov    %ebx,%eax
  cmd->type = EXEC;
     3be:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
}
     3c4:	83 c4 14             	add    $0x14,%esp
     3c7:	5b                   	pop    %ebx
     3c8:	5d                   	pop    %ebp
     3c9:	c3                   	ret    
     3ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003d0 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     3d0:	55                   	push   %ebp
     3d1:	89 e5                	mov    %esp,%ebp
     3d3:	53                   	push   %ebx
     3d4:	83 ec 14             	sub    $0x14,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3d7:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
     3de:	e8 3d 0e 00 00       	call   1220 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3e3:	31 d2                	xor    %edx,%edx
     3e5:	89 54 24 04          	mov    %edx,0x4(%esp)
  cmd = malloc(sizeof(*cmd));
     3e9:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3eb:	b8 18 00 00 00       	mov    $0x18,%eax
     3f0:	89 1c 24             	mov    %ebx,(%esp)
     3f3:	89 44 24 08          	mov    %eax,0x8(%esp)
     3f7:	e8 b4 08 00 00       	call   cb0 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     3fc:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     3ff:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     405:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     408:	8b 45 0c             	mov    0xc(%ebp),%eax
     40b:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     40e:	8b 45 10             	mov    0x10(%ebp),%eax
     411:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     414:	8b 45 14             	mov    0x14(%ebp),%eax
     417:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     41a:	8b 45 18             	mov    0x18(%ebp),%eax
     41d:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     420:	83 c4 14             	add    $0x14,%esp
     423:	89 d8                	mov    %ebx,%eax
     425:	5b                   	pop    %ebx
     426:	5d                   	pop    %ebp
     427:	c3                   	ret    
     428:	90                   	nop
     429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000430 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     430:	55                   	push   %ebp
     431:	89 e5                	mov    %esp,%ebp
     433:	53                   	push   %ebx
     434:	83 ec 14             	sub    $0x14,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     437:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     43e:	e8 dd 0d 00 00       	call   1220 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     443:	31 d2                	xor    %edx,%edx
     445:	89 54 24 04          	mov    %edx,0x4(%esp)
  cmd = malloc(sizeof(*cmd));
     449:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     44b:	b8 0c 00 00 00       	mov    $0xc,%eax
     450:	89 1c 24             	mov    %ebx,(%esp)
     453:	89 44 24 08          	mov    %eax,0x8(%esp)
     457:	e8 54 08 00 00       	call   cb0 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     45c:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     45f:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     465:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     468:	8b 45 0c             	mov    0xc(%ebp),%eax
     46b:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     46e:	83 c4 14             	add    $0x14,%esp
     471:	89 d8                	mov    %ebx,%eax
     473:	5b                   	pop    %ebx
     474:	5d                   	pop    %ebp
     475:	c3                   	ret    
     476:	8d 76 00             	lea    0x0(%esi),%esi
     479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000480 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     480:	55                   	push   %ebp
     481:	89 e5                	mov    %esp,%ebp
     483:	53                   	push   %ebx
     484:	83 ec 14             	sub    $0x14,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     487:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     48e:	e8 8d 0d 00 00       	call   1220 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     493:	31 d2                	xor    %edx,%edx
     495:	89 54 24 04          	mov    %edx,0x4(%esp)
  cmd = malloc(sizeof(*cmd));
     499:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     49b:	b8 0c 00 00 00       	mov    $0xc,%eax
     4a0:	89 1c 24             	mov    %ebx,(%esp)
     4a3:	89 44 24 08          	mov    %eax,0x8(%esp)
     4a7:	e8 04 08 00 00       	call   cb0 <memset>
  cmd->type = LIST;
  cmd->left = left;
     4ac:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     4af:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     4b5:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     4b8:	8b 45 0c             	mov    0xc(%ebp),%eax
     4bb:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     4be:	83 c4 14             	add    $0x14,%esp
     4c1:	89 d8                	mov    %ebx,%eax
     4c3:	5b                   	pop    %ebx
     4c4:	5d                   	pop    %ebp
     4c5:	c3                   	ret    
     4c6:	8d 76 00             	lea    0x0(%esi),%esi
     4c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004d0 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     4d0:	55                   	push   %ebp
     4d1:	89 e5                	mov    %esp,%ebp
     4d3:	53                   	push   %ebx
     4d4:	83 ec 14             	sub    $0x14,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4d7:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     4de:	e8 3d 0d 00 00       	call   1220 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     4e3:	31 d2                	xor    %edx,%edx
     4e5:	89 54 24 04          	mov    %edx,0x4(%esp)
  cmd = malloc(sizeof(*cmd));
     4e9:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     4eb:	b8 08 00 00 00       	mov    $0x8,%eax
     4f0:	89 1c 24             	mov    %ebx,(%esp)
     4f3:	89 44 24 08          	mov    %eax,0x8(%esp)
     4f7:	e8 b4 07 00 00       	call   cb0 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     4fc:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     4ff:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     505:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     508:	83 c4 14             	add    $0x14,%esp
     50b:	89 d8                	mov    %ebx,%eax
     50d:	5b                   	pop    %ebx
     50e:	5d                   	pop    %ebp
     50f:	c3                   	ret    

00000510 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     510:	55                   	push   %ebp
     511:	89 e5                	mov    %esp,%ebp
     513:	57                   	push   %edi
     514:	56                   	push   %esi
     515:	53                   	push   %ebx
     516:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int ret;

  s = *ps;
     519:	8b 45 08             	mov    0x8(%ebp),%eax
{
     51c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     51f:	8b 7d 10             	mov    0x10(%ebp),%edi
  s = *ps;
     522:	8b 30                	mov    (%eax),%esi
  while(s < es && strchr(whitespace, *s))
     524:	39 de                	cmp    %ebx,%esi
     526:	72 0d                	jb     535 <gettoken+0x25>
     528:	eb 22                	jmp    54c <gettoken+0x3c>
     52a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     530:	46                   	inc    %esi
  while(s < es && strchr(whitespace, *s))
     531:	39 f3                	cmp    %esi,%ebx
     533:	74 17                	je     54c <gettoken+0x3c>
     535:	0f be 06             	movsbl (%esi),%eax
     538:	c7 04 24 ac 19 00 00 	movl   $0x19ac,(%esp)
     53f:	89 44 24 04          	mov    %eax,0x4(%esp)
     543:	e8 88 07 00 00       	call   cd0 <strchr>
     548:	85 c0                	test   %eax,%eax
     54a:	75 e4                	jne    530 <gettoken+0x20>
  if(q)
     54c:	85 ff                	test   %edi,%edi
     54e:	74 02                	je     552 <gettoken+0x42>
    *q = s;
     550:	89 37                	mov    %esi,(%edi)
  ret = *s;
     552:	0f be 06             	movsbl (%esi),%eax
  switch(*s){
     555:	3c 29                	cmp    $0x29,%al
     557:	7f 57                	jg     5b0 <gettoken+0xa0>
     559:	3c 28                	cmp    $0x28,%al
     55b:	0f 8d cb 00 00 00    	jge    62c <gettoken+0x11c>
     561:	31 ff                	xor    %edi,%edi
     563:	84 c0                	test   %al,%al
     565:	0f 85 cd 00 00 00    	jne    638 <gettoken+0x128>
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     56b:	8b 55 14             	mov    0x14(%ebp),%edx
     56e:	85 d2                	test   %edx,%edx
     570:	74 05                	je     577 <gettoken+0x67>
    *eq = s;
     572:	8b 45 14             	mov    0x14(%ebp),%eax
     575:	89 30                	mov    %esi,(%eax)

  while(s < es && strchr(whitespace, *s))
     577:	39 de                	cmp    %ebx,%esi
     579:	72 0a                	jb     585 <gettoken+0x75>
     57b:	eb 1f                	jmp    59c <gettoken+0x8c>
     57d:	8d 76 00             	lea    0x0(%esi),%esi
    s++;
     580:	46                   	inc    %esi
  while(s < es && strchr(whitespace, *s))
     581:	39 f3                	cmp    %esi,%ebx
     583:	74 17                	je     59c <gettoken+0x8c>
     585:	0f be 06             	movsbl (%esi),%eax
     588:	c7 04 24 ac 19 00 00 	movl   $0x19ac,(%esp)
     58f:	89 44 24 04          	mov    %eax,0x4(%esp)
     593:	e8 38 07 00 00       	call   cd0 <strchr>
     598:	85 c0                	test   %eax,%eax
     59a:	75 e4                	jne    580 <gettoken+0x70>
  *ps = s;
     59c:	8b 45 08             	mov    0x8(%ebp),%eax
     59f:	89 30                	mov    %esi,(%eax)
  return ret;
}
     5a1:	83 c4 1c             	add    $0x1c,%esp
     5a4:	89 f8                	mov    %edi,%eax
     5a6:	5b                   	pop    %ebx
     5a7:	5e                   	pop    %esi
     5a8:	5f                   	pop    %edi
     5a9:	5d                   	pop    %ebp
     5aa:	c3                   	ret    
     5ab:	90                   	nop
     5ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     5b0:	3c 3e                	cmp    $0x3e,%al
     5b2:	75 1c                	jne    5d0 <gettoken+0xc0>
    if(*s == '>'){
     5b4:	80 7e 01 3e          	cmpb   $0x3e,0x1(%esi)
    s++;
     5b8:	8d 46 01             	lea    0x1(%esi),%eax
    if(*s == '>'){
     5bb:	0f 84 94 00 00 00    	je     655 <gettoken+0x145>
    s++;
     5c1:	89 c6                	mov    %eax,%esi
     5c3:	bf 3e 00 00 00       	mov    $0x3e,%edi
     5c8:	eb a1                	jmp    56b <gettoken+0x5b>
     5ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  switch(*s){
     5d0:	7f 56                	jg     628 <gettoken+0x118>
     5d2:	88 c1                	mov    %al,%cl
     5d4:	80 e9 3b             	sub    $0x3b,%cl
     5d7:	80 f9 01             	cmp    $0x1,%cl
     5da:	76 50                	jbe    62c <gettoken+0x11c>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5dc:	39 f3                	cmp    %esi,%ebx
     5de:	77 27                	ja     607 <gettoken+0xf7>
     5e0:	eb 5e                	jmp    640 <gettoken+0x130>
     5e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     5e8:	0f be 06             	movsbl (%esi),%eax
     5eb:	c7 04 24 a4 19 00 00 	movl   $0x19a4,(%esp)
     5f2:	89 44 24 04          	mov    %eax,0x4(%esp)
     5f6:	e8 d5 06 00 00       	call   cd0 <strchr>
     5fb:	85 c0                	test   %eax,%eax
     5fd:	75 1c                	jne    61b <gettoken+0x10b>
      s++;
     5ff:	46                   	inc    %esi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     600:	39 f3                	cmp    %esi,%ebx
     602:	74 3c                	je     640 <gettoken+0x130>
     604:	0f be 06             	movsbl (%esi),%eax
     607:	89 44 24 04          	mov    %eax,0x4(%esp)
     60b:	c7 04 24 ac 19 00 00 	movl   $0x19ac,(%esp)
     612:	e8 b9 06 00 00       	call   cd0 <strchr>
     617:	85 c0                	test   %eax,%eax
     619:	74 cd                	je     5e8 <gettoken+0xd8>
    ret = 'a';
     61b:	bf 61 00 00 00       	mov    $0x61,%edi
     620:	e9 46 ff ff ff       	jmp    56b <gettoken+0x5b>
     625:	8d 76 00             	lea    0x0(%esi),%esi
  switch(*s){
     628:	3c 7c                	cmp    $0x7c,%al
     62a:	75 b0                	jne    5dc <gettoken+0xcc>
  ret = *s;
     62c:	0f be f8             	movsbl %al,%edi
    s++;
     62f:	46                   	inc    %esi
    break;
     630:	e9 36 ff ff ff       	jmp    56b <gettoken+0x5b>
     635:	8d 76 00             	lea    0x0(%esi),%esi
  switch(*s){
     638:	3c 26                	cmp    $0x26,%al
     63a:	75 a0                	jne    5dc <gettoken+0xcc>
     63c:	eb ee                	jmp    62c <gettoken+0x11c>
     63e:	66 90                	xchg   %ax,%ax
  if(eq)
     640:	8b 45 14             	mov    0x14(%ebp),%eax
     643:	bf 61 00 00 00       	mov    $0x61,%edi
     648:	85 c0                	test   %eax,%eax
     64a:	0f 85 22 ff ff ff    	jne    572 <gettoken+0x62>
     650:	e9 47 ff ff ff       	jmp    59c <gettoken+0x8c>
      s++;
     655:	83 c6 02             	add    $0x2,%esi
      ret = '+';
     658:	bf 2b 00 00 00       	mov    $0x2b,%edi
     65d:	e9 09 ff ff ff       	jmp    56b <gettoken+0x5b>
     662:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000670 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     670:	55                   	push   %ebp
     671:	89 e5                	mov    %esp,%ebp
     673:	57                   	push   %edi
     674:	56                   	push   %esi
     675:	53                   	push   %ebx
     676:	83 ec 1c             	sub    $0x1c,%esp
     679:	8b 7d 08             	mov    0x8(%ebp),%edi
     67c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     67f:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     681:	39 f3                	cmp    %esi,%ebx
     683:	72 10                	jb     695 <peek+0x25>
     685:	eb 25                	jmp    6ac <peek+0x3c>
     687:	89 f6                	mov    %esi,%esi
     689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    s++;
     690:	43                   	inc    %ebx
  while(s < es && strchr(whitespace, *s))
     691:	39 de                	cmp    %ebx,%esi
     693:	74 17                	je     6ac <peek+0x3c>
     695:	0f be 03             	movsbl (%ebx),%eax
     698:	c7 04 24 ac 19 00 00 	movl   $0x19ac,(%esp)
     69f:	89 44 24 04          	mov    %eax,0x4(%esp)
     6a3:	e8 28 06 00 00       	call   cd0 <strchr>
     6a8:	85 c0                	test   %eax,%eax
     6aa:	75 e4                	jne    690 <peek+0x20>
  *ps = s;
     6ac:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     6ae:	31 c0                	xor    %eax,%eax
     6b0:	0f be 13             	movsbl (%ebx),%edx
     6b3:	84 d2                	test   %dl,%dl
     6b5:	74 17                	je     6ce <peek+0x5e>
     6b7:	8b 45 10             	mov    0x10(%ebp),%eax
     6ba:	89 54 24 04          	mov    %edx,0x4(%esp)
     6be:	89 04 24             	mov    %eax,(%esp)
     6c1:	e8 0a 06 00 00       	call   cd0 <strchr>
     6c6:	85 c0                	test   %eax,%eax
     6c8:	0f 95 c0             	setne  %al
     6cb:	0f b6 c0             	movzbl %al,%eax
}
     6ce:	83 c4 1c             	add    $0x1c,%esp
     6d1:	5b                   	pop    %ebx
     6d2:	5e                   	pop    %esi
     6d3:	5f                   	pop    %edi
     6d4:	5d                   	pop    %ebp
     6d5:	c3                   	ret    
     6d6:	8d 76 00             	lea    0x0(%esi),%esi
     6d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006e0 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     6e0:	55                   	push   %ebp
     6e1:	89 e5                	mov    %esp,%ebp
     6e3:	57                   	push   %edi
     6e4:	56                   	push   %esi
     6e5:	53                   	push   %ebx
     6e6:	83 ec 3c             	sub    $0x3c,%esp
     6e9:	8b 75 0c             	mov    0xc(%ebp),%esi
     6ec:	8b 5d 10             	mov    0x10(%ebp),%ebx
     6ef:	90                   	nop
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     6f0:	b8 59 13 00 00       	mov    $0x1359,%eax
     6f5:	89 44 24 08          	mov    %eax,0x8(%esp)
     6f9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     6fd:	89 34 24             	mov    %esi,(%esp)
     700:	e8 6b ff ff ff       	call   670 <peek>
     705:	85 c0                	test   %eax,%eax
     707:	0f 84 93 00 00 00    	je     7a0 <parseredirs+0xc0>
    tok = gettoken(ps, es, 0, 0);
     70d:	31 c0                	xor    %eax,%eax
     70f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     713:	31 c0                	xor    %eax,%eax
     715:	89 44 24 08          	mov    %eax,0x8(%esp)
     719:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     71d:	89 34 24             	mov    %esi,(%esp)
     720:	e8 eb fd ff ff       	call   510 <gettoken>
    if(gettoken(ps, es, &q, &eq) != 'a')
     725:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     729:	89 34 24             	mov    %esi,(%esp)
    tok = gettoken(ps, es, 0, 0);
     72c:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     72e:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     731:	89 44 24 0c          	mov    %eax,0xc(%esp)
     735:	8d 45 e0             	lea    -0x20(%ebp),%eax
     738:	89 44 24 08          	mov    %eax,0x8(%esp)
     73c:	e8 cf fd ff ff       	call   510 <gettoken>
     741:	83 f8 61             	cmp    $0x61,%eax
     744:	75 65                	jne    7ab <parseredirs+0xcb>
      panic("missing file for redirection");
    switch(tok){
     746:	83 ff 3c             	cmp    $0x3c,%edi
     749:	74 45                	je     790 <parseredirs+0xb0>
     74b:	83 ff 3e             	cmp    $0x3e,%edi
     74e:	66 90                	xchg   %ax,%ax
     750:	74 05                	je     757 <parseredirs+0x77>
     752:	83 ff 2b             	cmp    $0x2b,%edi
     755:	75 99                	jne    6f0 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     757:	ba 01 00 00 00       	mov    $0x1,%edx
     75c:	b9 01 02 00 00       	mov    $0x201,%ecx
     761:	89 54 24 10          	mov    %edx,0x10(%esp)
     765:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
     769:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     76c:	89 44 24 08          	mov    %eax,0x8(%esp)
     770:	8b 45 e0             	mov    -0x20(%ebp),%eax
     773:	89 44 24 04          	mov    %eax,0x4(%esp)
     777:	8b 45 08             	mov    0x8(%ebp),%eax
     77a:	89 04 24             	mov    %eax,(%esp)
     77d:	e8 4e fc ff ff       	call   3d0 <redircmd>
     782:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     785:	e9 66 ff ff ff       	jmp    6f0 <parseredirs+0x10>
     78a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     790:	31 ff                	xor    %edi,%edi
     792:	31 c0                	xor    %eax,%eax
     794:	89 7c 24 10          	mov    %edi,0x10(%esp)
     798:	89 44 24 0c          	mov    %eax,0xc(%esp)
     79c:	eb cb                	jmp    769 <parseredirs+0x89>
     79e:	66 90                	xchg   %ax,%ax
    }
  }
  return cmd;
}
     7a0:	8b 45 08             	mov    0x8(%ebp),%eax
     7a3:	83 c4 3c             	add    $0x3c,%esp
     7a6:	5b                   	pop    %ebx
     7a7:	5e                   	pop    %esi
     7a8:	5f                   	pop    %edi
     7a9:	5d                   	pop    %ebp
     7aa:	c3                   	ret    
      panic("missing file for redirection");
     7ab:	c7 04 24 3c 13 00 00 	movl   $0x133c,(%esp)
     7b2:	e8 a9 f9 ff ff       	call   160 <panic>
     7b7:	89 f6                	mov    %esi,%esi
     7b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000007c0 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     7c0:	55                   	push   %ebp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     7c1:	ba 5c 13 00 00       	mov    $0x135c,%edx
{
     7c6:	89 e5                	mov    %esp,%ebp
     7c8:	57                   	push   %edi
     7c9:	56                   	push   %esi
     7ca:	53                   	push   %ebx
     7cb:	83 ec 3c             	sub    $0x3c,%esp
     7ce:	8b 75 08             	mov    0x8(%ebp),%esi
     7d1:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(peek(ps, es, "("))
     7d4:	89 54 24 08          	mov    %edx,0x8(%esp)
     7d8:	89 34 24             	mov    %esi,(%esp)
     7db:	89 7c 24 04          	mov    %edi,0x4(%esp)
     7df:	e8 8c fe ff ff       	call   670 <peek>
     7e4:	85 c0                	test   %eax,%eax
     7e6:	0f 85 9c 00 00 00    	jne    888 <parseexec+0xc8>
     7ec:	89 c3                	mov    %eax,%ebx
    return parseblock(ps, es);

  ret = execcmd();
     7ee:	e8 9d fb ff ff       	call   390 <execcmd>
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     7f3:	89 7c 24 08          	mov    %edi,0x8(%esp)
     7f7:	89 74 24 04          	mov    %esi,0x4(%esp)
     7fb:	89 04 24             	mov    %eax,(%esp)
  ret = execcmd();
     7fe:	89 45 d0             	mov    %eax,-0x30(%ebp)
  ret = parseredirs(ret, ps, es);
     801:	e8 da fe ff ff       	call   6e0 <parseredirs>
     806:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     809:	eb 1b                	jmp    826 <parseexec+0x66>
     80b:	90                   	nop
     80c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     810:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     813:	89 7c 24 08          	mov    %edi,0x8(%esp)
     817:	89 74 24 04          	mov    %esi,0x4(%esp)
     81b:	89 04 24             	mov    %eax,(%esp)
     81e:	e8 bd fe ff ff       	call   6e0 <parseredirs>
     823:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     826:	b8 73 13 00 00       	mov    $0x1373,%eax
     82b:	89 44 24 08          	mov    %eax,0x8(%esp)
     82f:	89 7c 24 04          	mov    %edi,0x4(%esp)
     833:	89 34 24             	mov    %esi,(%esp)
     836:	e8 35 fe ff ff       	call   670 <peek>
     83b:	85 c0                	test   %eax,%eax
     83d:	75 69                	jne    8a8 <parseexec+0xe8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     83f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     842:	89 44 24 0c          	mov    %eax,0xc(%esp)
     846:	8d 45 e0             	lea    -0x20(%ebp),%eax
     849:	89 44 24 08          	mov    %eax,0x8(%esp)
     84d:	89 7c 24 04          	mov    %edi,0x4(%esp)
     851:	89 34 24             	mov    %esi,(%esp)
     854:	e8 b7 fc ff ff       	call   510 <gettoken>
     859:	85 c0                	test   %eax,%eax
     85b:	74 4b                	je     8a8 <parseexec+0xe8>
    if(tok != 'a')
     85d:	83 f8 61             	cmp    $0x61,%eax
     860:	75 65                	jne    8c7 <parseexec+0x107>
    cmd->argv[argc] = q;
     862:	8b 45 e0             	mov    -0x20(%ebp),%eax
     865:	8b 55 d0             	mov    -0x30(%ebp),%edx
     868:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
    cmd->eargv[argc] = eq;
     86c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     86f:	89 44 9a 2c          	mov    %eax,0x2c(%edx,%ebx,4)
    argc++;
     873:	43                   	inc    %ebx
    if(argc >= MAXARGS)
     874:	83 fb 0a             	cmp    $0xa,%ebx
     877:	75 97                	jne    810 <parseexec+0x50>
      panic("too many args");
     879:	c7 04 24 65 13 00 00 	movl   $0x1365,(%esp)
     880:	e8 db f8 ff ff       	call   160 <panic>
     885:	8d 76 00             	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     888:	89 7c 24 04          	mov    %edi,0x4(%esp)
     88c:	89 34 24             	mov    %esi,(%esp)
     88f:	e8 9c 01 00 00       	call   a30 <parseblock>
     894:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     897:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     89a:	83 c4 3c             	add    $0x3c,%esp
     89d:	5b                   	pop    %ebx
     89e:	5e                   	pop    %esi
     89f:	5f                   	pop    %edi
     8a0:	5d                   	pop    %ebp
     8a1:	c3                   	ret    
     8a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     8a8:	8b 45 d0             	mov    -0x30(%ebp),%eax
     8ab:	8d 04 98             	lea    (%eax,%ebx,4),%eax
  cmd->argv[argc] = 0;
     8ae:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  cmd->eargv[argc] = 0;
     8b5:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
}
     8bc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     8bf:	83 c4 3c             	add    $0x3c,%esp
     8c2:	5b                   	pop    %ebx
     8c3:	5e                   	pop    %esi
     8c4:	5f                   	pop    %edi
     8c5:	5d                   	pop    %ebp
     8c6:	c3                   	ret    
      panic("syntax");
     8c7:	c7 04 24 5e 13 00 00 	movl   $0x135e,(%esp)
     8ce:	e8 8d f8 ff ff       	call   160 <panic>
     8d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     8d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008e0 <parsepipe>:
{
     8e0:	55                   	push   %ebp
     8e1:	89 e5                	mov    %esp,%ebp
     8e3:	83 ec 28             	sub    $0x28,%esp
     8e6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     8e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     8ec:	89 75 f8             	mov    %esi,-0x8(%ebp)
     8ef:	8b 75 0c             	mov    0xc(%ebp),%esi
     8f2:	89 7d fc             	mov    %edi,-0x4(%ebp)
  cmd = parseexec(ps, es);
     8f5:	89 1c 24             	mov    %ebx,(%esp)
     8f8:	89 74 24 04          	mov    %esi,0x4(%esp)
     8fc:	e8 bf fe ff ff       	call   7c0 <parseexec>
  if(peek(ps, es, "|")){
     901:	b9 78 13 00 00       	mov    $0x1378,%ecx
     906:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     90a:	89 74 24 04          	mov    %esi,0x4(%esp)
     90e:	89 1c 24             	mov    %ebx,(%esp)
  cmd = parseexec(ps, es);
     911:	89 c7                	mov    %eax,%edi
  if(peek(ps, es, "|")){
     913:	e8 58 fd ff ff       	call   670 <peek>
     918:	85 c0                	test   %eax,%eax
     91a:	75 14                	jne    930 <parsepipe+0x50>
}
     91c:	89 f8                	mov    %edi,%eax
     91e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     921:	8b 75 f8             	mov    -0x8(%ebp),%esi
     924:	8b 7d fc             	mov    -0x4(%ebp),%edi
     927:	89 ec                	mov    %ebp,%esp
     929:	5d                   	pop    %ebp
     92a:	c3                   	ret    
     92b:	90                   	nop
     92c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    gettoken(ps, es, 0, 0);
     930:	31 d2                	xor    %edx,%edx
     932:	31 c0                	xor    %eax,%eax
     934:	89 54 24 08          	mov    %edx,0x8(%esp)
     938:	89 74 24 04          	mov    %esi,0x4(%esp)
     93c:	89 1c 24             	mov    %ebx,(%esp)
     93f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     943:	e8 c8 fb ff ff       	call   510 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     948:	89 74 24 04          	mov    %esi,0x4(%esp)
     94c:	89 1c 24             	mov    %ebx,(%esp)
     94f:	e8 8c ff ff ff       	call   8e0 <parsepipe>
}
     954:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    cmd = pipecmd(cmd, parsepipe(ps, es));
     957:	89 7d 08             	mov    %edi,0x8(%ebp)
}
     95a:	8b 75 f8             	mov    -0x8(%ebp),%esi
     95d:	8b 7d fc             	mov    -0x4(%ebp),%edi
    cmd = pipecmd(cmd, parsepipe(ps, es));
     960:	89 45 0c             	mov    %eax,0xc(%ebp)
}
     963:	89 ec                	mov    %ebp,%esp
     965:	5d                   	pop    %ebp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     966:	e9 c5 fa ff ff       	jmp    430 <pipecmd>
     96b:	90                   	nop
     96c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000970 <parseline>:
{
     970:	55                   	push   %ebp
     971:	89 e5                	mov    %esp,%ebp
     973:	57                   	push   %edi
     974:	56                   	push   %esi
     975:	53                   	push   %ebx
     976:	83 ec 1c             	sub    $0x1c,%esp
     979:	8b 5d 08             	mov    0x8(%ebp),%ebx
     97c:	8b 75 0c             	mov    0xc(%ebp),%esi
  cmd = parsepipe(ps, es);
     97f:	89 1c 24             	mov    %ebx,(%esp)
     982:	89 74 24 04          	mov    %esi,0x4(%esp)
     986:	e8 55 ff ff ff       	call   8e0 <parsepipe>
     98b:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     98d:	eb 23                	jmp    9b2 <parseline+0x42>
     98f:	90                   	nop
    gettoken(ps, es, 0, 0);
     990:	31 c0                	xor    %eax,%eax
     992:	89 44 24 0c          	mov    %eax,0xc(%esp)
     996:	31 c0                	xor    %eax,%eax
     998:	89 44 24 08          	mov    %eax,0x8(%esp)
     99c:	89 74 24 04          	mov    %esi,0x4(%esp)
     9a0:	89 1c 24             	mov    %ebx,(%esp)
     9a3:	e8 68 fb ff ff       	call   510 <gettoken>
    cmd = backcmd(cmd);
     9a8:	89 3c 24             	mov    %edi,(%esp)
     9ab:	e8 20 fb ff ff       	call   4d0 <backcmd>
     9b0:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     9b2:	b8 7a 13 00 00       	mov    $0x137a,%eax
     9b7:	89 44 24 08          	mov    %eax,0x8(%esp)
     9bb:	89 74 24 04          	mov    %esi,0x4(%esp)
     9bf:	89 1c 24             	mov    %ebx,(%esp)
     9c2:	e8 a9 fc ff ff       	call   670 <peek>
     9c7:	85 c0                	test   %eax,%eax
     9c9:	75 c5                	jne    990 <parseline+0x20>
  if(peek(ps, es, ";")){
     9cb:	b9 76 13 00 00       	mov    $0x1376,%ecx
     9d0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     9d4:	89 74 24 04          	mov    %esi,0x4(%esp)
     9d8:	89 1c 24             	mov    %ebx,(%esp)
     9db:	e8 90 fc ff ff       	call   670 <peek>
     9e0:	85 c0                	test   %eax,%eax
     9e2:	75 0c                	jne    9f0 <parseline+0x80>
}
     9e4:	83 c4 1c             	add    $0x1c,%esp
     9e7:	89 f8                	mov    %edi,%eax
     9e9:	5b                   	pop    %ebx
     9ea:	5e                   	pop    %esi
     9eb:	5f                   	pop    %edi
     9ec:	5d                   	pop    %ebp
     9ed:	c3                   	ret    
     9ee:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
     9f0:	31 d2                	xor    %edx,%edx
     9f2:	31 c0                	xor    %eax,%eax
     9f4:	89 54 24 08          	mov    %edx,0x8(%esp)
     9f8:	89 74 24 04          	mov    %esi,0x4(%esp)
     9fc:	89 1c 24             	mov    %ebx,(%esp)
     9ff:	89 44 24 0c          	mov    %eax,0xc(%esp)
     a03:	e8 08 fb ff ff       	call   510 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     a08:	89 74 24 04          	mov    %esi,0x4(%esp)
     a0c:	89 1c 24             	mov    %ebx,(%esp)
     a0f:	e8 5c ff ff ff       	call   970 <parseline>
     a14:	89 7d 08             	mov    %edi,0x8(%ebp)
     a17:	89 45 0c             	mov    %eax,0xc(%ebp)
}
     a1a:	83 c4 1c             	add    $0x1c,%esp
     a1d:	5b                   	pop    %ebx
     a1e:	5e                   	pop    %esi
     a1f:	5f                   	pop    %edi
     a20:	5d                   	pop    %ebp
    cmd = listcmd(cmd, parseline(ps, es));
     a21:	e9 5a fa ff ff       	jmp    480 <listcmd>
     a26:	8d 76 00             	lea    0x0(%esi),%esi
     a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a30 <parseblock>:
{
     a30:	55                   	push   %ebp
  if(!peek(ps, es, "("))
     a31:	b8 5c 13 00 00       	mov    $0x135c,%eax
{
     a36:	89 e5                	mov    %esp,%ebp
     a38:	83 ec 28             	sub    $0x28,%esp
     a3b:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     a3e:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a41:	89 75 f8             	mov    %esi,-0x8(%ebp)
     a44:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     a47:	89 44 24 08          	mov    %eax,0x8(%esp)
{
     a4b:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(!peek(ps, es, "("))
     a4e:	89 1c 24             	mov    %ebx,(%esp)
     a51:	89 74 24 04          	mov    %esi,0x4(%esp)
     a55:	e8 16 fc ff ff       	call   670 <peek>
     a5a:	85 c0                	test   %eax,%eax
     a5c:	74 74                	je     ad2 <parseblock+0xa2>
  gettoken(ps, es, 0, 0);
     a5e:	31 c9                	xor    %ecx,%ecx
     a60:	31 ff                	xor    %edi,%edi
     a62:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
     a66:	89 7c 24 08          	mov    %edi,0x8(%esp)
     a6a:	89 74 24 04          	mov    %esi,0x4(%esp)
     a6e:	89 1c 24             	mov    %ebx,(%esp)
     a71:	e8 9a fa ff ff       	call   510 <gettoken>
  cmd = parseline(ps, es);
     a76:	89 74 24 04          	mov    %esi,0x4(%esp)
     a7a:	89 1c 24             	mov    %ebx,(%esp)
     a7d:	e8 ee fe ff ff       	call   970 <parseline>
  if(!peek(ps, es, ")"))
     a82:	89 74 24 04          	mov    %esi,0x4(%esp)
     a86:	89 1c 24             	mov    %ebx,(%esp)
  cmd = parseline(ps, es);
     a89:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     a8b:	b8 98 13 00 00       	mov    $0x1398,%eax
     a90:	89 44 24 08          	mov    %eax,0x8(%esp)
     a94:	e8 d7 fb ff ff       	call   670 <peek>
     a99:	85 c0                	test   %eax,%eax
     a9b:	74 41                	je     ade <parseblock+0xae>
  gettoken(ps, es, 0, 0);
     a9d:	31 d2                	xor    %edx,%edx
     a9f:	31 c0                	xor    %eax,%eax
     aa1:	89 54 24 08          	mov    %edx,0x8(%esp)
     aa5:	89 74 24 04          	mov    %esi,0x4(%esp)
     aa9:	89 1c 24             	mov    %ebx,(%esp)
     aac:	89 44 24 0c          	mov    %eax,0xc(%esp)
     ab0:	e8 5b fa ff ff       	call   510 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     ab5:	89 74 24 08          	mov    %esi,0x8(%esp)
     ab9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     abd:	89 3c 24             	mov    %edi,(%esp)
     ac0:	e8 1b fc ff ff       	call   6e0 <parseredirs>
}
     ac5:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     ac8:	8b 75 f8             	mov    -0x8(%ebp),%esi
     acb:	8b 7d fc             	mov    -0x4(%ebp),%edi
     ace:	89 ec                	mov    %ebp,%esp
     ad0:	5d                   	pop    %ebp
     ad1:	c3                   	ret    
    panic("parseblock");
     ad2:	c7 04 24 7c 13 00 00 	movl   $0x137c,(%esp)
     ad9:	e8 82 f6 ff ff       	call   160 <panic>
    panic("syntax - missing )");
     ade:	c7 04 24 87 13 00 00 	movl   $0x1387,(%esp)
     ae5:	e8 76 f6 ff ff       	call   160 <panic>
     aea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000af0 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     af0:	55                   	push   %ebp
     af1:	89 e5                	mov    %esp,%ebp
     af3:	53                   	push   %ebx
     af4:	83 ec 14             	sub    $0x14,%esp
     af7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     afa:	85 db                	test   %ebx,%ebx
     afc:	74 1d                	je     b1b <nulterminate+0x2b>
    return 0;

  switch(cmd->type){
     afe:	83 3b 05             	cmpl   $0x5,(%ebx)
     b01:	77 18                	ja     b1b <nulterminate+0x2b>
     b03:	8b 03                	mov    (%ebx),%eax
     b05:	ff 24 85 d8 13 00 00 	jmp    *0x13d8(,%eax,4)
     b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
     b10:	8b 43 04             	mov    0x4(%ebx),%eax
     b13:	89 04 24             	mov    %eax,(%esp)
     b16:	e8 d5 ff ff ff       	call   af0 <nulterminate>
    break;
  }
  return cmd;
}
     b1b:	83 c4 14             	add    $0x14,%esp
     b1e:	89 d8                	mov    %ebx,%eax
     b20:	5b                   	pop    %ebx
     b21:	5d                   	pop    %ebp
     b22:	c3                   	ret    
     b23:	90                   	nop
     b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(lcmd->left);
     b28:	8b 43 04             	mov    0x4(%ebx),%eax
     b2b:	89 04 24             	mov    %eax,(%esp)
     b2e:	e8 bd ff ff ff       	call   af0 <nulterminate>
    nulterminate(lcmd->right);
     b33:	8b 43 08             	mov    0x8(%ebx),%eax
     b36:	89 04 24             	mov    %eax,(%esp)
     b39:	e8 b2 ff ff ff       	call   af0 <nulterminate>
}
     b3e:	83 c4 14             	add    $0x14,%esp
     b41:	89 d8                	mov    %ebx,%eax
     b43:	5b                   	pop    %ebx
     b44:	5d                   	pop    %ebp
     b45:	c3                   	ret    
     b46:	8d 76 00             	lea    0x0(%esi),%esi
     b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    for(i=0; ecmd->argv[i]; i++)
     b50:	8b 4b 04             	mov    0x4(%ebx),%ecx
     b53:	8d 43 08             	lea    0x8(%ebx),%eax
     b56:	85 c9                	test   %ecx,%ecx
     b58:	74 c1                	je     b1b <nulterminate+0x2b>
     b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     b60:	8b 50 24             	mov    0x24(%eax),%edx
     b63:	83 c0 04             	add    $0x4,%eax
     b66:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     b69:	8b 50 fc             	mov    -0x4(%eax),%edx
     b6c:	85 d2                	test   %edx,%edx
     b6e:	75 f0                	jne    b60 <nulterminate+0x70>
}
     b70:	83 c4 14             	add    $0x14,%esp
     b73:	89 d8                	mov    %ebx,%eax
     b75:	5b                   	pop    %ebx
     b76:	5d                   	pop    %ebp
     b77:	c3                   	ret    
     b78:	90                   	nop
     b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(rcmd->cmd);
     b80:	8b 43 04             	mov    0x4(%ebx),%eax
     b83:	89 04 24             	mov    %eax,(%esp)
     b86:	e8 65 ff ff ff       	call   af0 <nulterminate>
    *rcmd->efile = 0;
     b8b:	8b 43 0c             	mov    0xc(%ebx),%eax
     b8e:	c6 00 00             	movb   $0x0,(%eax)
}
     b91:	83 c4 14             	add    $0x14,%esp
     b94:	89 d8                	mov    %ebx,%eax
     b96:	5b                   	pop    %ebx
     b97:	5d                   	pop    %ebp
     b98:	c3                   	ret    
     b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000ba0 <parsecmd>:
{
     ba0:	55                   	push   %ebp
     ba1:	89 e5                	mov    %esp,%ebp
     ba3:	56                   	push   %esi
     ba4:	53                   	push   %ebx
     ba5:	83 ec 10             	sub    $0x10,%esp
  es = s + strlen(s);
     ba8:	8b 5d 08             	mov    0x8(%ebp),%ebx
     bab:	89 1c 24             	mov    %ebx,(%esp)
     bae:	e8 cd 00 00 00       	call   c80 <strlen>
     bb3:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     bb5:	8d 45 08             	lea    0x8(%ebp),%eax
     bb8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     bbc:	89 04 24             	mov    %eax,(%esp)
     bbf:	e8 ac fd ff ff       	call   970 <parseline>
  peek(&s, es, "");
     bc4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  cmd = parseline(&s, es);
     bc8:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     bca:	b8 21 13 00 00       	mov    $0x1321,%eax
     bcf:	89 44 24 08          	mov    %eax,0x8(%esp)
     bd3:	8d 45 08             	lea    0x8(%ebp),%eax
     bd6:	89 04 24             	mov    %eax,(%esp)
     bd9:	e8 92 fa ff ff       	call   670 <peek>
  if(s != es){
     bde:	8b 45 08             	mov    0x8(%ebp),%eax
     be1:	39 d8                	cmp    %ebx,%eax
     be3:	75 11                	jne    bf6 <parsecmd+0x56>
  nulterminate(cmd);
     be5:	89 34 24             	mov    %esi,(%esp)
     be8:	e8 03 ff ff ff       	call   af0 <nulterminate>
}
     bed:	83 c4 10             	add    $0x10,%esp
     bf0:	89 f0                	mov    %esi,%eax
     bf2:	5b                   	pop    %ebx
     bf3:	5e                   	pop    %esi
     bf4:	5d                   	pop    %ebp
     bf5:	c3                   	ret    
    printf(2, "leftovers: %s\n", s);
     bf6:	89 44 24 08          	mov    %eax,0x8(%esp)
     bfa:	c7 44 24 04 9a 13 00 	movl   $0x139a,0x4(%esp)
     c01:	00 
     c02:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     c09:	e8 82 03 00 00       	call   f90 <printf>
    panic("syntax");
     c0e:	c7 04 24 5e 13 00 00 	movl   $0x135e,(%esp)
     c15:	e8 46 f5 ff ff       	call   160 <panic>
     c1a:	66 90                	xchg   %ax,%ax
     c1c:	66 90                	xchg   %ax,%ax
     c1e:	66 90                	xchg   %ax,%ax

00000c20 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     c20:	55                   	push   %ebp
     c21:	89 e5                	mov    %esp,%ebp
     c23:	8b 45 08             	mov    0x8(%ebp),%eax
     c26:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     c29:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     c2a:	89 c2                	mov    %eax,%edx
     c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c30:	41                   	inc    %ecx
     c31:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     c35:	42                   	inc    %edx
     c36:	84 db                	test   %bl,%bl
     c38:	88 5a ff             	mov    %bl,-0x1(%edx)
     c3b:	75 f3                	jne    c30 <strcpy+0x10>
    ;
  return os;
}
     c3d:	5b                   	pop    %ebx
     c3e:	5d                   	pop    %ebp
     c3f:	c3                   	ret    

00000c40 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     c40:	55                   	push   %ebp
     c41:	89 e5                	mov    %esp,%ebp
     c43:	8b 4d 08             	mov    0x8(%ebp),%ecx
     c46:	53                   	push   %ebx
     c47:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
     c4a:	0f b6 01             	movzbl (%ecx),%eax
     c4d:	0f b6 13             	movzbl (%ebx),%edx
     c50:	84 c0                	test   %al,%al
     c52:	75 18                	jne    c6c <strcmp+0x2c>
     c54:	eb 22                	jmp    c78 <strcmp+0x38>
     c56:	8d 76 00             	lea    0x0(%esi),%esi
     c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     c60:	41                   	inc    %ecx
  while(*p && *p == *q)
     c61:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
     c64:	43                   	inc    %ebx
     c65:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
     c68:	84 c0                	test   %al,%al
     c6a:	74 0c                	je     c78 <strcmp+0x38>
     c6c:	38 d0                	cmp    %dl,%al
     c6e:	74 f0                	je     c60 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
     c70:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
     c71:	29 d0                	sub    %edx,%eax
}
     c73:	5d                   	pop    %ebp
     c74:	c3                   	ret    
     c75:	8d 76 00             	lea    0x0(%esi),%esi
     c78:	5b                   	pop    %ebx
     c79:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     c7b:	29 d0                	sub    %edx,%eax
}
     c7d:	5d                   	pop    %ebp
     c7e:	c3                   	ret    
     c7f:	90                   	nop

00000c80 <strlen>:

uint
strlen(const char *s)
{
     c80:	55                   	push   %ebp
     c81:	89 e5                	mov    %esp,%ebp
     c83:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     c86:	80 39 00             	cmpb   $0x0,(%ecx)
     c89:	74 15                	je     ca0 <strlen+0x20>
     c8b:	31 d2                	xor    %edx,%edx
     c8d:	8d 76 00             	lea    0x0(%esi),%esi
     c90:	42                   	inc    %edx
     c91:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     c95:	89 d0                	mov    %edx,%eax
     c97:	75 f7                	jne    c90 <strlen+0x10>
    ;
  return n;
}
     c99:	5d                   	pop    %ebp
     c9a:	c3                   	ret    
     c9b:	90                   	nop
     c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
     ca0:	31 c0                	xor    %eax,%eax
}
     ca2:	5d                   	pop    %ebp
     ca3:	c3                   	ret    
     ca4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     caa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000cb0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     cb0:	55                   	push   %ebp
     cb1:	89 e5                	mov    %esp,%ebp
     cb3:	8b 55 08             	mov    0x8(%ebp),%edx
     cb6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     cb7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     cba:	8b 45 0c             	mov    0xc(%ebp),%eax
     cbd:	89 d7                	mov    %edx,%edi
     cbf:	fc                   	cld    
     cc0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     cc2:	5f                   	pop    %edi
     cc3:	89 d0                	mov    %edx,%eax
     cc5:	5d                   	pop    %ebp
     cc6:	c3                   	ret    
     cc7:	89 f6                	mov    %esi,%esi
     cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000cd0 <strchr>:

char*
strchr(const char *s, char c)
{
     cd0:	55                   	push   %ebp
     cd1:	89 e5                	mov    %esp,%ebp
     cd3:	8b 45 08             	mov    0x8(%ebp),%eax
     cd6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     cda:	0f b6 10             	movzbl (%eax),%edx
     cdd:	84 d2                	test   %dl,%dl
     cdf:	74 1b                	je     cfc <strchr+0x2c>
    if(*s == c)
     ce1:	38 d1                	cmp    %dl,%cl
     ce3:	75 0f                	jne    cf4 <strchr+0x24>
     ce5:	eb 17                	jmp    cfe <strchr+0x2e>
     ce7:	89 f6                	mov    %esi,%esi
     ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     cf0:	38 ca                	cmp    %cl,%dl
     cf2:	74 0a                	je     cfe <strchr+0x2e>
  for(; *s; s++)
     cf4:	40                   	inc    %eax
     cf5:	0f b6 10             	movzbl (%eax),%edx
     cf8:	84 d2                	test   %dl,%dl
     cfa:	75 f4                	jne    cf0 <strchr+0x20>
      return (char*)s;
  return 0;
     cfc:	31 c0                	xor    %eax,%eax
}
     cfe:	5d                   	pop    %ebp
     cff:	c3                   	ret    

00000d00 <gets>:

char*
gets(char *buf, int max)
{
     d00:	55                   	push   %ebp
     d01:	89 e5                	mov    %esp,%ebp
     d03:	57                   	push   %edi
     d04:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     d05:	31 f6                	xor    %esi,%esi
{
     d07:	53                   	push   %ebx
     d08:	83 ec 3c             	sub    $0x3c,%esp
     d0b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
     d0e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
     d11:	eb 32                	jmp    d45 <gets+0x45>
     d13:	90                   	nop
     d14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
     d18:	ba 01 00 00 00       	mov    $0x1,%edx
     d1d:	89 54 24 08          	mov    %edx,0x8(%esp)
     d21:	89 7c 24 04          	mov    %edi,0x4(%esp)
     d25:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     d2c:	e8 2f 01 00 00       	call   e60 <read>
    if(cc < 1)
     d31:	85 c0                	test   %eax,%eax
     d33:	7e 19                	jle    d4e <gets+0x4e>
      break;
    buf[i++] = c;
     d35:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     d39:	43                   	inc    %ebx
     d3a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
     d3d:	3c 0a                	cmp    $0xa,%al
     d3f:	74 1f                	je     d60 <gets+0x60>
     d41:	3c 0d                	cmp    $0xd,%al
     d43:	74 1b                	je     d60 <gets+0x60>
  for(i=0; i+1 < max; ){
     d45:	46                   	inc    %esi
     d46:	3b 75 0c             	cmp    0xc(%ebp),%esi
     d49:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
     d4c:	7c ca                	jl     d18 <gets+0x18>
      break;
  }
  buf[i] = '\0';
     d4e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     d51:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
     d54:	8b 45 08             	mov    0x8(%ebp),%eax
     d57:	83 c4 3c             	add    $0x3c,%esp
     d5a:	5b                   	pop    %ebx
     d5b:	5e                   	pop    %esi
     d5c:	5f                   	pop    %edi
     d5d:	5d                   	pop    %ebp
     d5e:	c3                   	ret    
     d5f:	90                   	nop
     d60:	8b 45 08             	mov    0x8(%ebp),%eax
     d63:	01 c6                	add    %eax,%esi
     d65:	89 75 d4             	mov    %esi,-0x2c(%ebp)
     d68:	eb e4                	jmp    d4e <gets+0x4e>
     d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000d70 <stat>:

int
stat(const char *n, struct stat *st)
{
     d70:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     d71:	31 c0                	xor    %eax,%eax
{
     d73:	89 e5                	mov    %esp,%ebp
     d75:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
     d78:	89 44 24 04          	mov    %eax,0x4(%esp)
     d7c:	8b 45 08             	mov    0x8(%ebp),%eax
{
     d7f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     d82:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
     d85:	89 04 24             	mov    %eax,(%esp)
     d88:	e8 fb 00 00 00       	call   e88 <open>
  if(fd < 0)
     d8d:	85 c0                	test   %eax,%eax
     d8f:	78 2f                	js     dc0 <stat+0x50>
     d91:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
     d93:	8b 45 0c             	mov    0xc(%ebp),%eax
     d96:	89 1c 24             	mov    %ebx,(%esp)
     d99:	89 44 24 04          	mov    %eax,0x4(%esp)
     d9d:	e8 fe 00 00 00       	call   ea0 <fstat>
  close(fd);
     da2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     da5:	89 c6                	mov    %eax,%esi
  close(fd);
     da7:	e8 c4 00 00 00       	call   e70 <close>
  return r;
}
     dac:	89 f0                	mov    %esi,%eax
     dae:	8b 5d f8             	mov    -0x8(%ebp),%ebx
     db1:	8b 75 fc             	mov    -0x4(%ebp),%esi
     db4:	89 ec                	mov    %ebp,%esp
     db6:	5d                   	pop    %ebp
     db7:	c3                   	ret    
     db8:	90                   	nop
     db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
     dc0:	be ff ff ff ff       	mov    $0xffffffff,%esi
     dc5:	eb e5                	jmp    dac <stat+0x3c>
     dc7:	89 f6                	mov    %esi,%esi
     dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000dd0 <atoi>:

int
atoi(const char *s)
{
     dd0:	55                   	push   %ebp
     dd1:	89 e5                	mov    %esp,%ebp
     dd3:	8b 4d 08             	mov    0x8(%ebp),%ecx
     dd6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     dd7:	0f be 11             	movsbl (%ecx),%edx
     dda:	88 d0                	mov    %dl,%al
     ddc:	2c 30                	sub    $0x30,%al
     dde:	3c 09                	cmp    $0x9,%al
  n = 0;
     de0:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
     de5:	77 1e                	ja     e05 <atoi+0x35>
     de7:	89 f6                	mov    %esi,%esi
     de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
     df0:	41                   	inc    %ecx
     df1:	8d 04 80             	lea    (%eax,%eax,4),%eax
     df4:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
     df8:	0f be 11             	movsbl (%ecx),%edx
     dfb:	88 d3                	mov    %dl,%bl
     dfd:	80 eb 30             	sub    $0x30,%bl
     e00:	80 fb 09             	cmp    $0x9,%bl
     e03:	76 eb                	jbe    df0 <atoi+0x20>
  return n;
}
     e05:	5b                   	pop    %ebx
     e06:	5d                   	pop    %ebp
     e07:	c3                   	ret    
     e08:	90                   	nop
     e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000e10 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     e10:	55                   	push   %ebp
     e11:	89 e5                	mov    %esp,%ebp
     e13:	56                   	push   %esi
     e14:	8b 45 08             	mov    0x8(%ebp),%eax
     e17:	53                   	push   %ebx
     e18:	8b 5d 10             	mov    0x10(%ebp),%ebx
     e1b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     e1e:	85 db                	test   %ebx,%ebx
     e20:	7e 1a                	jle    e3c <memmove+0x2c>
     e22:	31 d2                	xor    %edx,%edx
     e24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
     e30:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     e34:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     e37:	42                   	inc    %edx
  while(n-- > 0)
     e38:	39 d3                	cmp    %edx,%ebx
     e3a:	75 f4                	jne    e30 <memmove+0x20>
  return vdst;
}
     e3c:	5b                   	pop    %ebx
     e3d:	5e                   	pop    %esi
     e3e:	5d                   	pop    %ebp
     e3f:	c3                   	ret    

00000e40 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     e40:	b8 01 00 00 00       	mov    $0x1,%eax
     e45:	cd 40                	int    $0x40
     e47:	c3                   	ret    

00000e48 <exit>:
SYSCALL(exit)
     e48:	b8 02 00 00 00       	mov    $0x2,%eax
     e4d:	cd 40                	int    $0x40
     e4f:	c3                   	ret    

00000e50 <wait>:
SYSCALL(wait)
     e50:	b8 03 00 00 00       	mov    $0x3,%eax
     e55:	cd 40                	int    $0x40
     e57:	c3                   	ret    

00000e58 <pipe>:
SYSCALL(pipe)
     e58:	b8 04 00 00 00       	mov    $0x4,%eax
     e5d:	cd 40                	int    $0x40
     e5f:	c3                   	ret    

00000e60 <read>:
SYSCALL(read)
     e60:	b8 05 00 00 00       	mov    $0x5,%eax
     e65:	cd 40                	int    $0x40
     e67:	c3                   	ret    

00000e68 <write>:
SYSCALL(write)
     e68:	b8 10 00 00 00       	mov    $0x10,%eax
     e6d:	cd 40                	int    $0x40
     e6f:	c3                   	ret    

00000e70 <close>:
SYSCALL(close)
     e70:	b8 15 00 00 00       	mov    $0x15,%eax
     e75:	cd 40                	int    $0x40
     e77:	c3                   	ret    

00000e78 <kill>:
SYSCALL(kill)
     e78:	b8 06 00 00 00       	mov    $0x6,%eax
     e7d:	cd 40                	int    $0x40
     e7f:	c3                   	ret    

00000e80 <exec>:
SYSCALL(exec)
     e80:	b8 07 00 00 00       	mov    $0x7,%eax
     e85:	cd 40                	int    $0x40
     e87:	c3                   	ret    

00000e88 <open>:
SYSCALL(open)
     e88:	b8 0f 00 00 00       	mov    $0xf,%eax
     e8d:	cd 40                	int    $0x40
     e8f:	c3                   	ret    

00000e90 <mknod>:
SYSCALL(mknod)
     e90:	b8 11 00 00 00       	mov    $0x11,%eax
     e95:	cd 40                	int    $0x40
     e97:	c3                   	ret    

00000e98 <unlink>:
SYSCALL(unlink)
     e98:	b8 12 00 00 00       	mov    $0x12,%eax
     e9d:	cd 40                	int    $0x40
     e9f:	c3                   	ret    

00000ea0 <fstat>:
SYSCALL(fstat)
     ea0:	b8 08 00 00 00       	mov    $0x8,%eax
     ea5:	cd 40                	int    $0x40
     ea7:	c3                   	ret    

00000ea8 <link>:
SYSCALL(link)
     ea8:	b8 13 00 00 00       	mov    $0x13,%eax
     ead:	cd 40                	int    $0x40
     eaf:	c3                   	ret    

00000eb0 <mkdir>:
SYSCALL(mkdir)
     eb0:	b8 14 00 00 00       	mov    $0x14,%eax
     eb5:	cd 40                	int    $0x40
     eb7:	c3                   	ret    

00000eb8 <chdir>:
SYSCALL(chdir)
     eb8:	b8 09 00 00 00       	mov    $0x9,%eax
     ebd:	cd 40                	int    $0x40
     ebf:	c3                   	ret    

00000ec0 <dup>:
SYSCALL(dup)
     ec0:	b8 0a 00 00 00       	mov    $0xa,%eax
     ec5:	cd 40                	int    $0x40
     ec7:	c3                   	ret    

00000ec8 <getpid>:
SYSCALL(getpid)
     ec8:	b8 0b 00 00 00       	mov    $0xb,%eax
     ecd:	cd 40                	int    $0x40
     ecf:	c3                   	ret    

00000ed0 <sbrk>:
SYSCALL(sbrk)
     ed0:	b8 0c 00 00 00       	mov    $0xc,%eax
     ed5:	cd 40                	int    $0x40
     ed7:	c3                   	ret    

00000ed8 <sleep>:
SYSCALL(sleep)
     ed8:	b8 0d 00 00 00       	mov    $0xd,%eax
     edd:	cd 40                	int    $0x40
     edf:	c3                   	ret    

00000ee0 <uptime>:
SYSCALL(uptime)
     ee0:	b8 0e 00 00 00       	mov    $0xe,%eax
     ee5:	cd 40                	int    $0x40
     ee7:	c3                   	ret    
     ee8:	66 90                	xchg   %ax,%ax
     eea:	66 90                	xchg   %ax,%ax
     eec:	66 90                	xchg   %ax,%ax
     eee:	66 90                	xchg   %ax,%ax

00000ef0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     ef0:	55                   	push   %ebp
     ef1:	89 e5                	mov    %esp,%ebp
     ef3:	57                   	push   %edi
     ef4:	56                   	push   %esi
     ef5:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     ef6:	89 d3                	mov    %edx,%ebx
     ef8:	c1 eb 1f             	shr    $0x1f,%ebx
{
     efb:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
     efe:	84 db                	test   %bl,%bl
{
     f00:	89 45 c0             	mov    %eax,-0x40(%ebp)
     f03:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
     f05:	74 79                	je     f80 <printint+0x90>
     f07:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
     f0b:	74 73                	je     f80 <printint+0x90>
    neg = 1;
    x = -xx;
     f0d:	f7 d8                	neg    %eax
    neg = 1;
     f0f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
     f16:	31 f6                	xor    %esi,%esi
     f18:	8d 5d d7             	lea    -0x29(%ebp),%ebx
     f1b:	eb 05                	jmp    f22 <printint+0x32>
     f1d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
     f20:	89 fe                	mov    %edi,%esi
     f22:	31 d2                	xor    %edx,%edx
     f24:	f7 f1                	div    %ecx
     f26:	8d 7e 01             	lea    0x1(%esi),%edi
     f29:	0f b6 92 f8 13 00 00 	movzbl 0x13f8(%edx),%edx
  }while((x /= base) != 0);
     f30:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
     f32:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
     f35:	75 e9                	jne    f20 <printint+0x30>
  if(neg)
     f37:	8b 55 c4             	mov    -0x3c(%ebp),%edx
     f3a:	85 d2                	test   %edx,%edx
     f3c:	74 08                	je     f46 <printint+0x56>
    buf[i++] = '-';
     f3e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
     f43:	8d 7e 02             	lea    0x2(%esi),%edi
     f46:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
     f4a:	8b 7d c0             	mov    -0x40(%ebp),%edi
     f4d:	8d 76 00             	lea    0x0(%esi),%esi
     f50:	0f b6 06             	movzbl (%esi),%eax
     f53:	4e                   	dec    %esi
  write(fd, &c, 1);
     f54:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     f58:	89 3c 24             	mov    %edi,(%esp)
     f5b:	88 45 d7             	mov    %al,-0x29(%ebp)
     f5e:	b8 01 00 00 00       	mov    $0x1,%eax
     f63:	89 44 24 08          	mov    %eax,0x8(%esp)
     f67:	e8 fc fe ff ff       	call   e68 <write>

  while(--i >= 0)
     f6c:	39 de                	cmp    %ebx,%esi
     f6e:	75 e0                	jne    f50 <printint+0x60>
    putc(fd, buf[i]);
}
     f70:	83 c4 4c             	add    $0x4c,%esp
     f73:	5b                   	pop    %ebx
     f74:	5e                   	pop    %esi
     f75:	5f                   	pop    %edi
     f76:	5d                   	pop    %ebp
     f77:	c3                   	ret    
     f78:	90                   	nop
     f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
     f80:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     f87:	eb 8d                	jmp    f16 <printint+0x26>
     f89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000f90 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
     f90:	55                   	push   %ebp
     f91:	89 e5                	mov    %esp,%ebp
     f93:	57                   	push   %edi
     f94:	56                   	push   %esi
     f95:	53                   	push   %ebx
     f96:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     f99:	8b 75 0c             	mov    0xc(%ebp),%esi
     f9c:	0f b6 1e             	movzbl (%esi),%ebx
     f9f:	84 db                	test   %bl,%bl
     fa1:	0f 84 d1 00 00 00    	je     1078 <printf+0xe8>
  state = 0;
     fa7:	31 ff                	xor    %edi,%edi
     fa9:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
     faa:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
     fad:	89 fa                	mov    %edi,%edx
     faf:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
     fb2:	89 45 d0             	mov    %eax,-0x30(%ebp)
     fb5:	eb 41                	jmp    ff8 <printf+0x68>
     fb7:	89 f6                	mov    %esi,%esi
     fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     fc0:	83 f8 25             	cmp    $0x25,%eax
     fc3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
     fc6:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
     fcb:	74 1e                	je     feb <printf+0x5b>
  write(fd, &c, 1);
     fcd:	b8 01 00 00 00       	mov    $0x1,%eax
     fd2:	89 44 24 08          	mov    %eax,0x8(%esp)
     fd6:	8d 45 e2             	lea    -0x1e(%ebp),%eax
     fd9:	89 44 24 04          	mov    %eax,0x4(%esp)
     fdd:	89 3c 24             	mov    %edi,(%esp)
     fe0:	88 5d e2             	mov    %bl,-0x1e(%ebp)
     fe3:	e8 80 fe ff ff       	call   e68 <write>
     fe8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     feb:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
     fec:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
     ff0:	84 db                	test   %bl,%bl
     ff2:	0f 84 80 00 00 00    	je     1078 <printf+0xe8>
    if(state == 0){
     ff8:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
     ffa:	0f be cb             	movsbl %bl,%ecx
     ffd:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1000:	74 be                	je     fc0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1002:	83 fa 25             	cmp    $0x25,%edx
    1005:	75 e4                	jne    feb <printf+0x5b>
      if(c == 'd'){
    1007:	83 f8 64             	cmp    $0x64,%eax
    100a:	0f 84 f0 00 00 00    	je     1100 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1010:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    1016:	83 f9 70             	cmp    $0x70,%ecx
    1019:	74 65                	je     1080 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    101b:	83 f8 73             	cmp    $0x73,%eax
    101e:	0f 84 8c 00 00 00    	je     10b0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1024:	83 f8 63             	cmp    $0x63,%eax
    1027:	0f 84 13 01 00 00    	je     1140 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    102d:	83 f8 25             	cmp    $0x25,%eax
    1030:	0f 84 e2 00 00 00    	je     1118 <printf+0x188>
  write(fd, &c, 1);
    1036:	b8 01 00 00 00       	mov    $0x1,%eax
    103b:	46                   	inc    %esi
    103c:	89 44 24 08          	mov    %eax,0x8(%esp)
    1040:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1043:	89 44 24 04          	mov    %eax,0x4(%esp)
    1047:	89 3c 24             	mov    %edi,(%esp)
    104a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    104e:	e8 15 fe ff ff       	call   e68 <write>
    1053:	ba 01 00 00 00       	mov    $0x1,%edx
    1058:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    105b:	89 54 24 08          	mov    %edx,0x8(%esp)
    105f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1063:	89 3c 24             	mov    %edi,(%esp)
    1066:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    1069:	e8 fa fd ff ff       	call   e68 <write>
  for(i = 0; fmt[i]; i++){
    106e:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1072:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    1074:	84 db                	test   %bl,%bl
    1076:	75 80                	jne    ff8 <printf+0x68>
    }
  }
}
    1078:	83 c4 3c             	add    $0x3c,%esp
    107b:	5b                   	pop    %ebx
    107c:	5e                   	pop    %esi
    107d:	5f                   	pop    %edi
    107e:	5d                   	pop    %ebp
    107f:	c3                   	ret    
        printint(fd, *ap, 16, 0);
    1080:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1087:	b9 10 00 00 00       	mov    $0x10,%ecx
    108c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    108f:	89 f8                	mov    %edi,%eax
    1091:	8b 13                	mov    (%ebx),%edx
    1093:	e8 58 fe ff ff       	call   ef0 <printint>
        ap++;
    1098:	89 d8                	mov    %ebx,%eax
      state = 0;
    109a:	31 d2                	xor    %edx,%edx
        ap++;
    109c:	83 c0 04             	add    $0x4,%eax
    109f:	89 45 d0             	mov    %eax,-0x30(%ebp)
    10a2:	e9 44 ff ff ff       	jmp    feb <printf+0x5b>
    10a7:	89 f6                	mov    %esi,%esi
    10a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
    10b0:	8b 45 d0             	mov    -0x30(%ebp),%eax
    10b3:	8b 10                	mov    (%eax),%edx
        ap++;
    10b5:	83 c0 04             	add    $0x4,%eax
    10b8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    10bb:	85 d2                	test   %edx,%edx
    10bd:	0f 84 aa 00 00 00    	je     116d <printf+0x1dd>
        while(*s != 0){
    10c3:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
    10c6:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
    10c8:	84 c0                	test   %al,%al
    10ca:	74 27                	je     10f3 <printf+0x163>
    10cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    10d0:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    10d3:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
    10d8:	43                   	inc    %ebx
  write(fd, &c, 1);
    10d9:	89 44 24 08          	mov    %eax,0x8(%esp)
    10dd:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    10e0:	89 44 24 04          	mov    %eax,0x4(%esp)
    10e4:	89 3c 24             	mov    %edi,(%esp)
    10e7:	e8 7c fd ff ff       	call   e68 <write>
        while(*s != 0){
    10ec:	0f b6 03             	movzbl (%ebx),%eax
    10ef:	84 c0                	test   %al,%al
    10f1:	75 dd                	jne    10d0 <printf+0x140>
      state = 0;
    10f3:	31 d2                	xor    %edx,%edx
    10f5:	e9 f1 fe ff ff       	jmp    feb <printf+0x5b>
    10fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    1100:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1107:	b9 0a 00 00 00       	mov    $0xa,%ecx
    110c:	e9 7b ff ff ff       	jmp    108c <printf+0xfc>
    1111:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
    1118:	b9 01 00 00 00       	mov    $0x1,%ecx
    111d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1120:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    1124:	89 44 24 04          	mov    %eax,0x4(%esp)
    1128:	89 3c 24             	mov    %edi,(%esp)
    112b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    112e:	e8 35 fd ff ff       	call   e68 <write>
      state = 0;
    1133:	31 d2                	xor    %edx,%edx
    1135:	e9 b1 fe ff ff       	jmp    feb <printf+0x5b>
    113a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
    1140:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    1143:	8b 03                	mov    (%ebx),%eax
        ap++;
    1145:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    1148:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
    114b:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    114e:	b8 01 00 00 00       	mov    $0x1,%eax
    1153:	89 44 24 08          	mov    %eax,0x8(%esp)
    1157:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    115a:	89 44 24 04          	mov    %eax,0x4(%esp)
    115e:	e8 05 fd ff ff       	call   e68 <write>
      state = 0;
    1163:	31 d2                	xor    %edx,%edx
        ap++;
    1165:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    1168:	e9 7e fe ff ff       	jmp    feb <printf+0x5b>
          s = "(null)";
    116d:	bb f0 13 00 00       	mov    $0x13f0,%ebx
        while(*s != 0){
    1172:	b0 28                	mov    $0x28,%al
    1174:	e9 57 ff ff ff       	jmp    10d0 <printf+0x140>
    1179:	66 90                	xchg   %ax,%ax
    117b:	66 90                	xchg   %ax,%ax
    117d:	66 90                	xchg   %ax,%ax
    117f:	90                   	nop

00001180 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1180:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1181:	a1 24 1a 00 00       	mov    0x1a24,%eax
{
    1186:	89 e5                	mov    %esp,%ebp
    1188:	57                   	push   %edi
    1189:	56                   	push   %esi
    118a:	53                   	push   %ebx
    118b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    118e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1191:	eb 0d                	jmp    11a0 <free+0x20>
    1193:	90                   	nop
    1194:	90                   	nop
    1195:	90                   	nop
    1196:	90                   	nop
    1197:	90                   	nop
    1198:	90                   	nop
    1199:	90                   	nop
    119a:	90                   	nop
    119b:	90                   	nop
    119c:	90                   	nop
    119d:	90                   	nop
    119e:	90                   	nop
    119f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11a0:	39 c8                	cmp    %ecx,%eax
    11a2:	8b 10                	mov    (%eax),%edx
    11a4:	73 32                	jae    11d8 <free+0x58>
    11a6:	39 d1                	cmp    %edx,%ecx
    11a8:	72 04                	jb     11ae <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11aa:	39 d0                	cmp    %edx,%eax
    11ac:	72 32                	jb     11e0 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
    11ae:	8b 73 fc             	mov    -0x4(%ebx),%esi
    11b1:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    11b4:	39 fa                	cmp    %edi,%edx
    11b6:	74 30                	je     11e8 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    11b8:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    11bb:	8b 50 04             	mov    0x4(%eax),%edx
    11be:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    11c1:	39 f1                	cmp    %esi,%ecx
    11c3:	74 3c                	je     1201 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    11c5:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
    11c7:	5b                   	pop    %ebx
  freep = p;
    11c8:	a3 24 1a 00 00       	mov    %eax,0x1a24
}
    11cd:	5e                   	pop    %esi
    11ce:	5f                   	pop    %edi
    11cf:	5d                   	pop    %ebp
    11d0:	c3                   	ret    
    11d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11d8:	39 d0                	cmp    %edx,%eax
    11da:	72 04                	jb     11e0 <free+0x60>
    11dc:	39 d1                	cmp    %edx,%ecx
    11de:	72 ce                	jb     11ae <free+0x2e>
{
    11e0:	89 d0                	mov    %edx,%eax
    11e2:	eb bc                	jmp    11a0 <free+0x20>
    11e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    11e8:	8b 7a 04             	mov    0x4(%edx),%edi
    11eb:	01 fe                	add    %edi,%esi
    11ed:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    11f0:	8b 10                	mov    (%eax),%edx
    11f2:	8b 12                	mov    (%edx),%edx
    11f4:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    11f7:	8b 50 04             	mov    0x4(%eax),%edx
    11fa:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    11fd:	39 f1                	cmp    %esi,%ecx
    11ff:	75 c4                	jne    11c5 <free+0x45>
    p->s.size += bp->s.size;
    1201:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
    1204:	a3 24 1a 00 00       	mov    %eax,0x1a24
    p->s.size += bp->s.size;
    1209:	01 ca                	add    %ecx,%edx
    120b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    120e:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1211:	89 10                	mov    %edx,(%eax)
}
    1213:	5b                   	pop    %ebx
    1214:	5e                   	pop    %esi
    1215:	5f                   	pop    %edi
    1216:	5d                   	pop    %ebp
    1217:	c3                   	ret    
    1218:	90                   	nop
    1219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001220 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1220:	55                   	push   %ebp
    1221:	89 e5                	mov    %esp,%ebp
    1223:	57                   	push   %edi
    1224:	56                   	push   %esi
    1225:	53                   	push   %ebx
    1226:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1229:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    122c:	8b 15 24 1a 00 00    	mov    0x1a24,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1232:	8d 78 07             	lea    0x7(%eax),%edi
    1235:	c1 ef 03             	shr    $0x3,%edi
    1238:	47                   	inc    %edi
  if((prevp = freep) == 0){
    1239:	85 d2                	test   %edx,%edx
    123b:	0f 84 8f 00 00 00    	je     12d0 <malloc+0xb0>
    1241:	8b 02                	mov    (%edx),%eax
    1243:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1246:	39 cf                	cmp    %ecx,%edi
    1248:	76 66                	jbe    12b0 <malloc+0x90>
    124a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1250:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1255:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    1258:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    125f:	eb 10                	jmp    1271 <malloc+0x51>
    1261:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1268:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    126a:	8b 48 04             	mov    0x4(%eax),%ecx
    126d:	39 f9                	cmp    %edi,%ecx
    126f:	73 3f                	jae    12b0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1271:	39 05 24 1a 00 00    	cmp    %eax,0x1a24
    1277:	89 c2                	mov    %eax,%edx
    1279:	75 ed                	jne    1268 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    127b:	89 34 24             	mov    %esi,(%esp)
    127e:	e8 4d fc ff ff       	call   ed0 <sbrk>
  if(p == (char*)-1)
    1283:	83 f8 ff             	cmp    $0xffffffff,%eax
    1286:	74 18                	je     12a0 <malloc+0x80>
  hp->s.size = nu;
    1288:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    128b:	83 c0 08             	add    $0x8,%eax
    128e:	89 04 24             	mov    %eax,(%esp)
    1291:	e8 ea fe ff ff       	call   1180 <free>
  return freep;
    1296:	8b 15 24 1a 00 00    	mov    0x1a24,%edx
      if((p = morecore(nunits)) == 0)
    129c:	85 d2                	test   %edx,%edx
    129e:	75 c8                	jne    1268 <malloc+0x48>
        return 0;
  }
}
    12a0:	83 c4 1c             	add    $0x1c,%esp
        return 0;
    12a3:	31 c0                	xor    %eax,%eax
}
    12a5:	5b                   	pop    %ebx
    12a6:	5e                   	pop    %esi
    12a7:	5f                   	pop    %edi
    12a8:	5d                   	pop    %ebp
    12a9:	c3                   	ret    
    12aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    12b0:	39 cf                	cmp    %ecx,%edi
    12b2:	74 4c                	je     1300 <malloc+0xe0>
        p->s.size -= nunits;
    12b4:	29 f9                	sub    %edi,%ecx
    12b6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    12b9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    12bc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    12bf:	89 15 24 1a 00 00    	mov    %edx,0x1a24
}
    12c5:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
    12c8:	83 c0 08             	add    $0x8,%eax
}
    12cb:	5b                   	pop    %ebx
    12cc:	5e                   	pop    %esi
    12cd:	5f                   	pop    %edi
    12ce:	5d                   	pop    %ebp
    12cf:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    12d0:	b8 28 1a 00 00       	mov    $0x1a28,%eax
    12d5:	ba 28 1a 00 00       	mov    $0x1a28,%edx
    base.s.size = 0;
    12da:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
    12dc:	a3 24 1a 00 00       	mov    %eax,0x1a24
    base.s.size = 0;
    12e1:	b8 28 1a 00 00       	mov    $0x1a28,%eax
    base.s.ptr = freep = prevp = &base;
    12e6:	89 15 28 1a 00 00    	mov    %edx,0x1a28
    base.s.size = 0;
    12ec:	89 0d 2c 1a 00 00    	mov    %ecx,0x1a2c
    12f2:	e9 53 ff ff ff       	jmp    124a <malloc+0x2a>
    12f7:	89 f6                	mov    %esi,%esi
    12f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
    1300:	8b 08                	mov    (%eax),%ecx
    1302:	89 0a                	mov    %ecx,(%edx)
    1304:	eb b9                	jmp    12bf <malloc+0x9f>
