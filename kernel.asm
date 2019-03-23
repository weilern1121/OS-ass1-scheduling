
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 b0 10 00       	mov    $0x10b000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3

  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 20 d6 10 80       	mov    $0x8010d620,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 80 2f 10 80       	mov    $0x80102f80,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
80100041:	ba 80 87 10 80       	mov    $0x80108780,%edx
{
80100046:	89 e5                	mov    %esp,%ebp
80100048:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
80100049:	bb 1c 1d 11 80       	mov    $0x80111d1c,%ebx
{
8010004e:	83 ec 14             	sub    $0x14,%esp
  initlock(&bcache.lock, "bcache");
80100051:	89 54 24 04          	mov    %edx,0x4(%esp)
80100055:	c7 04 24 20 d6 10 80 	movl   $0x8010d620,(%esp)
8010005c:	e8 1f 59 00 00       	call   80105980 <initlock>
  bcache.head.prev = &bcache.head;
80100061:	b9 1c 1d 11 80       	mov    $0x80111d1c,%ecx
  bcache.head.next = &bcache.head;
80100066:	ba 1c 1d 11 80       	mov    $0x80111d1c,%edx
8010006b:	89 1d 70 1d 11 80    	mov    %ebx,0x80111d70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100071:	bb 54 d6 10 80       	mov    $0x8010d654,%ebx
  bcache.head.prev = &bcache.head;
80100076:	89 0d 6c 1d 11 80    	mov    %ecx,0x80111d6c
8010007c:	eb 04                	jmp    80100082 <binit+0x42>
8010007e:	66 90                	xchg   %ax,%ax
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	b8 87 87 10 80       	mov    $0x80108787,%eax
    b->next = bcache.head.next;
80100087:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008a:	c7 43 50 1c 1d 11 80 	movl   $0x80111d1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100091:	89 44 24 04          	mov    %eax,0x4(%esp)
80100095:	8d 43 0c             	lea    0xc(%ebx),%eax
80100098:	89 04 24             	mov    %eax,(%esp)
8010009b:	e8 b0 57 00 00       	call   80105850 <initsleeplock>
    bcache.head.next->prev = b;
801000a0:	a1 70 1d 11 80       	mov    0x80111d70,%eax
801000a5:	89 da                	mov    %ebx,%edx
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
801000b0:	3d 1c 1d 11 80       	cmp    $0x80111d1c,%eax
    bcache.head.next = b;
801000b5:	89 1d 70 1d 11 80    	mov    %ebx,0x80111d70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	83 c4 14             	add    $0x14,%esp
801000c0:	5b                   	pop    %ebx
801000c1:	5d                   	pop    %ebp
801000c2:	c3                   	ret    
801000c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 1c             	sub    $0x1c,%esp
  acquire(&bcache.lock);
801000d9:	c7 04 24 20 d6 10 80 	movl   $0x8010d620,(%esp)
{
801000e0:	8b 75 08             	mov    0x8(%ebp),%esi
801000e3:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000e6:	e8 e5 59 00 00       	call   80105ad0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000eb:	8b 1d 70 1d 11 80    	mov    0x80111d70,%ebx
801000f1:	81 fb 1c 1d 11 80    	cmp    $0x80111d1c,%ebx
801000f7:	75 12                	jne    8010010b <bread+0x3b>
801000f9:	eb 25                	jmp    80100120 <bread+0x50>
801000fb:	90                   	nop
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c 1d 11 80    	cmp    $0x80111d1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	ff 43 4c             	incl   0x4c(%ebx)
80100118:	eb 40                	jmp    8010015a <bread+0x8a>
8010011a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c 1d 11 80    	mov    0x80111d6c,%ebx
80100126:	81 fb 1c 1d 11 80    	cmp    $0x80111d1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 58                	jmp    80100188 <bread+0xb8>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c 1d 11 80    	cmp    $0x80111d1c,%ebx
80100139:	74 4d                	je     80100188 <bread+0xb8>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	c7 04 24 20 d6 10 80 	movl   $0x8010d620,(%esp)
80100161:	e8 0a 5a 00 00       	call   80105b70 <release>
      acquiresleep(&b->lock);
80100166:	8d 43 0c             	lea    0xc(%ebx),%eax
80100169:	89 04 24             	mov    %eax,(%esp)
8010016c:	e8 1f 57 00 00       	call   80105890 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100171:	f6 03 02             	testb  $0x2,(%ebx)
80100174:	75 08                	jne    8010017e <bread+0xae>
    iderw(b);
80100176:	89 1c 24             	mov    %ebx,(%esp)
80100179:	e8 82 20 00 00       	call   80102200 <iderw>
  }
  return b;
}
8010017e:	83 c4 1c             	add    $0x1c,%esp
80100181:	89 d8                	mov    %ebx,%eax
80100183:	5b                   	pop    %ebx
80100184:	5e                   	pop    %esi
80100185:	5f                   	pop    %edi
80100186:	5d                   	pop    %ebp
80100187:	c3                   	ret    
  panic("bget: no buffers");
80100188:	c7 04 24 8e 87 10 80 	movl   $0x8010878e,(%esp)
8010018f:	e8 dc 01 00 00       	call   80100370 <panic>
80100194:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010019a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 14             	sub    $0x14,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	89 04 24             	mov    %eax,(%esp)
801001b0:	e8 7b 57 00 00       	call   80105930 <holdingsleep>
801001b5:	85 c0                	test   %eax,%eax
801001b7:	74 10                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001b9:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bc:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001bf:	83 c4 14             	add    $0x14,%esp
801001c2:	5b                   	pop    %ebx
801001c3:	5d                   	pop    %ebp
  iderw(b);
801001c4:	e9 37 20 00 00       	jmp    80102200 <iderw>
    panic("bwrite");
801001c9:	c7 04 24 9f 87 10 80 	movl   $0x8010879f,(%esp)
801001d0:	e8 9b 01 00 00       	call   80100370 <panic>
801001d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	83 ec 10             	sub    $0x10,%esp
801001e8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	89 34 24             	mov    %esi,(%esp)
801001f1:	e8 3a 57 00 00       	call   80105930 <holdingsleep>
801001f6:	85 c0                	test   %eax,%eax
801001f8:	74 5a                	je     80100254 <brelse+0x74>
    panic("brelse");

  releasesleep(&b->lock);
801001fa:	89 34 24             	mov    %esi,(%esp)
801001fd:	e8 ee 56 00 00       	call   801058f0 <releasesleep>

  acquire(&bcache.lock);
80100202:	c7 04 24 20 d6 10 80 	movl   $0x8010d620,(%esp)
80100209:	e8 c2 58 00 00       	call   80105ad0 <acquire>
  b->refcnt--;
  if (b->refcnt == 0) {
8010020e:	ff 4b 4c             	decl   0x4c(%ebx)
80100211:	75 2f                	jne    80100242 <brelse+0x62>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100213:	8b 43 54             	mov    0x54(%ebx),%eax
80100216:	8b 53 50             	mov    0x50(%ebx),%edx
80100219:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
8010021c:	8b 43 50             	mov    0x50(%ebx),%eax
8010021f:	8b 53 54             	mov    0x54(%ebx),%edx
80100222:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100225:	a1 70 1d 11 80       	mov    0x80111d70,%eax
    b->prev = &bcache.head;
8010022a:	c7 43 50 1c 1d 11 80 	movl   $0x80111d1c,0x50(%ebx)
    b->next = bcache.head.next;
80100231:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100234:	a1 70 1d 11 80       	mov    0x80111d70,%eax
80100239:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010023c:	89 1d 70 1d 11 80    	mov    %ebx,0x80111d70
  }
  
  release(&bcache.lock);
80100242:	c7 45 08 20 d6 10 80 	movl   $0x8010d620,0x8(%ebp)
}
80100249:	83 c4 10             	add    $0x10,%esp
8010024c:	5b                   	pop    %ebx
8010024d:	5e                   	pop    %esi
8010024e:	5d                   	pop    %ebp
  release(&bcache.lock);
8010024f:	e9 1c 59 00 00       	jmp    80105b70 <release>
    panic("brelse");
80100254:	c7 04 24 a6 87 10 80 	movl   $0x801087a6,(%esp)
8010025b:	e8 10 01 00 00       	call   80100370 <panic>

80100260 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100260:	55                   	push   %ebp
80100261:	89 e5                	mov    %esp,%ebp
80100263:	57                   	push   %edi
80100264:	56                   	push   %esi
80100265:	53                   	push   %ebx
80100266:	83 ec 2c             	sub    $0x2c,%esp
80100269:	8b 7d 08             	mov    0x8(%ebp),%edi
8010026c:	8b 75 10             	mov    0x10(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010026f:	89 3c 24             	mov    %edi,(%esp)
80100272:	e8 59 15 00 00       	call   801017d0 <iunlock>
  target = n;
  acquire(&cons.lock);
80100277:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010027e:	e8 4d 58 00 00       	call   80105ad0 <acquire>
  while(n > 0){
80100283:	31 c0                	xor    %eax,%eax
80100285:	85 f6                	test   %esi,%esi
80100287:	0f 8e a3 00 00 00    	jle    80100330 <consoleread+0xd0>
8010028d:	89 f3                	mov    %esi,%ebx
8010028f:	89 75 10             	mov    %esi,0x10(%ebp)
80100292:	8b 75 0c             	mov    0xc(%ebp),%esi
    while(input.r == input.w){
80100295:	8b 15 00 20 11 80    	mov    0x80112000,%edx
8010029b:	39 15 04 20 11 80    	cmp    %edx,0x80112004
801002a1:	74 28                	je     801002cb <consoleread+0x6b>
801002a3:	eb 5b                	jmp    80100300 <consoleread+0xa0>
801002a5:	8d 76 00             	lea    0x0(%esi),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002a8:	b8 20 c5 10 80       	mov    $0x8010c520,%eax
801002ad:	89 44 24 04          	mov    %eax,0x4(%esp)
801002b1:	c7 04 24 00 20 11 80 	movl   $0x80112000,(%esp)
801002b8:	e8 d3 40 00 00       	call   80104390 <sleep>
    while(input.r == input.w){
801002bd:	8b 15 00 20 11 80    	mov    0x80112000,%edx
801002c3:	3b 15 04 20 11 80    	cmp    0x80112004,%edx
801002c9:	75 35                	jne    80100300 <consoleread+0xa0>
      if(myproc()->killed){
801002cb:	e8 50 37 00 00       	call   80103a20 <myproc>
801002d0:	8b 50 24             	mov    0x24(%eax),%edx
801002d3:	85 d2                	test   %edx,%edx
801002d5:	74 d1                	je     801002a8 <consoleread+0x48>
        release(&cons.lock);
801002d7:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
801002de:	e8 8d 58 00 00       	call   80105b70 <release>
        ilock(ip);
801002e3:	89 3c 24             	mov    %edi,(%esp)
801002e6:	e8 05 14 00 00       	call   801016f0 <ilock>
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002eb:	83 c4 2c             	add    $0x2c,%esp
        return -1;
801002ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801002f3:	5b                   	pop    %ebx
801002f4:	5e                   	pop    %esi
801002f5:	5f                   	pop    %edi
801002f6:	5d                   	pop    %ebp
801002f7:	c3                   	ret    
801002f8:	90                   	nop
801002f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100300:	8d 42 01             	lea    0x1(%edx),%eax
80100303:	a3 00 20 11 80       	mov    %eax,0x80112000
80100308:	89 d0                	mov    %edx,%eax
8010030a:	83 e0 7f             	and    $0x7f,%eax
8010030d:	0f be 80 80 1f 11 80 	movsbl -0x7feee080(%eax),%eax
    if(c == C('D')){  // EOF
80100314:	83 f8 04             	cmp    $0x4,%eax
80100317:	74 39                	je     80100352 <consoleread+0xf2>
    *dst++ = c;
80100319:	46                   	inc    %esi
    --n;
8010031a:	4b                   	dec    %ebx
    if(c == '\n')
8010031b:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
8010031e:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100321:	74 42                	je     80100365 <consoleread+0x105>
  while(n > 0){
80100323:	85 db                	test   %ebx,%ebx
80100325:	0f 85 6a ff ff ff    	jne    80100295 <consoleread+0x35>
8010032b:	8b 75 10             	mov    0x10(%ebp),%esi
8010032e:	89 f0                	mov    %esi,%eax
  release(&cons.lock);
80100330:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
80100337:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010033a:	e8 31 58 00 00       	call   80105b70 <release>
  ilock(ip);
8010033f:	89 3c 24             	mov    %edi,(%esp)
80100342:	e8 a9 13 00 00       	call   801016f0 <ilock>
80100347:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
8010034a:	83 c4 2c             	add    $0x2c,%esp
8010034d:	5b                   	pop    %ebx
8010034e:	5e                   	pop    %esi
8010034f:	5f                   	pop    %edi
80100350:	5d                   	pop    %ebp
80100351:	c3                   	ret    
80100352:	8b 75 10             	mov    0x10(%ebp),%esi
80100355:	89 f0                	mov    %esi,%eax
80100357:	29 d8                	sub    %ebx,%eax
      if(n < target){
80100359:	39 f3                	cmp    %esi,%ebx
8010035b:	73 d3                	jae    80100330 <consoleread+0xd0>
        input.r--;
8010035d:	89 15 00 20 11 80    	mov    %edx,0x80112000
80100363:	eb cb                	jmp    80100330 <consoleread+0xd0>
80100365:	8b 75 10             	mov    0x10(%ebp),%esi
80100368:	89 f0                	mov    %esi,%eax
8010036a:	29 d8                	sub    %ebx,%eax
8010036c:	eb c2                	jmp    80100330 <consoleread+0xd0>
8010036e:	66 90                	xchg   %ax,%ax

80100370 <panic>:
{
80100370:	55                   	push   %ebp
80100371:	89 e5                	mov    %esp,%ebp
80100373:	56                   	push   %esi
80100374:	53                   	push   %ebx
80100375:	83 ec 40             	sub    $0x40,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100378:	fa                   	cli    
  cons.locking = 0;
80100379:	31 d2                	xor    %edx,%edx
8010037b:	89 15 54 c5 10 80    	mov    %edx,0x8010c554
  getcallerpcs(&s, pcs);
80100381:	8d 5d d0             	lea    -0x30(%ebp),%ebx
  cprintf("lapicid %d: panic: ", lapicid());
80100384:	e8 a7 24 00 00       	call   80102830 <lapicid>
80100389:	8d 75 f8             	lea    -0x8(%ebp),%esi
8010038c:	c7 04 24 ad 87 10 80 	movl   $0x801087ad,(%esp)
80100393:	89 44 24 04          	mov    %eax,0x4(%esp)
80100397:	e8 b4 02 00 00       	call   80100650 <cprintf>
  cprintf(s);
8010039c:	8b 45 08             	mov    0x8(%ebp),%eax
8010039f:	89 04 24             	mov    %eax,(%esp)
801003a2:	e8 a9 02 00 00       	call   80100650 <cprintf>
  cprintf("\n");
801003a7:	c7 04 24 a1 8f 10 80 	movl   $0x80108fa1,(%esp)
801003ae:	e8 9d 02 00 00       	call   80100650 <cprintf>
  getcallerpcs(&s, pcs);
801003b3:	8d 45 08             	lea    0x8(%ebp),%eax
801003b6:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801003ba:	89 04 24             	mov    %eax,(%esp)
801003bd:	e8 de 55 00 00       	call   801059a0 <getcallerpcs>
801003c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    cprintf(" %p", pcs[i]);
801003d0:	8b 03                	mov    (%ebx),%eax
801003d2:	83 c3 04             	add    $0x4,%ebx
801003d5:	c7 04 24 c1 87 10 80 	movl   $0x801087c1,(%esp)
801003dc:	89 44 24 04          	mov    %eax,0x4(%esp)
801003e0:	e8 6b 02 00 00       	call   80100650 <cprintf>
  for(i=0; i<10; i++)
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x60>
  panicked = 1; // freeze other CPU
801003e9:	b8 01 00 00 00       	mov    $0x1,%eax
801003ee:	a3 58 c5 10 80       	mov    %eax,0x8010c558
801003f3:	eb fe                	jmp    801003f3 <panic+0x83>
801003f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801003f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100400 <consputc>:
  if(panicked){
80100400:	8b 15 58 c5 10 80    	mov    0x8010c558,%edx
80100406:	85 d2                	test   %edx,%edx
80100408:	74 06                	je     80100410 <consputc+0x10>
8010040a:	fa                   	cli    
8010040b:	eb fe                	jmp    8010040b <consputc+0xb>
8010040d:	8d 76 00             	lea    0x0(%esi),%esi
{
80100410:	55                   	push   %ebp
80100411:	89 e5                	mov    %esp,%ebp
80100413:	57                   	push   %edi
80100414:	56                   	push   %esi
80100415:	53                   	push   %ebx
80100416:	89 c3                	mov    %eax,%ebx
80100418:	83 ec 2c             	sub    $0x2c,%esp
  if(c == BACKSPACE){
8010041b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100420:	0f 84 9f 00 00 00    	je     801004c5 <consputc+0xc5>
    uartputc(c);
80100426:	89 04 24             	mov    %eax,(%esp)
80100429:	e8 42 6f 00 00       	call   80107370 <uartputc>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010042e:	be d4 03 00 00       	mov    $0x3d4,%esi
80100433:	b0 0e                	mov    $0xe,%al
80100435:	89 f2                	mov    %esi,%edx
80100437:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100438:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010043d:	89 ca                	mov    %ecx,%edx
8010043f:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100440:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100443:	89 f2                	mov    %esi,%edx
80100445:	c1 e0 08             	shl    $0x8,%eax
80100448:	89 c7                	mov    %eax,%edi
8010044a:	b0 0f                	mov    $0xf,%al
8010044c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044d:	89 ca                	mov    %ecx,%edx
8010044f:	ec                   	in     (%dx),%al
80100450:	0f b6 c8             	movzbl %al,%ecx
  pos |= inb(CRTPORT+1);
80100453:	09 f9                	or     %edi,%ecx
  if(c == '\n')
80100455:	83 fb 0a             	cmp    $0xa,%ebx
80100458:	0f 84 ff 00 00 00    	je     8010055d <consputc+0x15d>
  else if(c == BACKSPACE){
8010045e:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
80100464:	0f 84 e5 00 00 00    	je     8010054f <consputc+0x14f>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010046a:	0f b6 c3             	movzbl %bl,%eax
8010046d:	0d 00 07 00 00       	or     $0x700,%eax
80100472:	66 89 84 09 00 80 0b 	mov    %ax,-0x7ff48000(%ecx,%ecx,1)
80100479:	80 
8010047a:	41                   	inc    %ecx
  if(pos < 0 || pos > 25*80)
8010047b:	81 f9 d0 07 00 00    	cmp    $0x7d0,%ecx
80100481:	0f 8f bc 00 00 00    	jg     80100543 <consputc+0x143>
  if((pos/80) >= 24){  // Scroll up.
80100487:	81 f9 7f 07 00 00    	cmp    $0x77f,%ecx
8010048d:	7f 5f                	jg     801004ee <consputc+0xee>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010048f:	be d4 03 00 00       	mov    $0x3d4,%esi
80100494:	b0 0e                	mov    $0xe,%al
80100496:	89 f2                	mov    %esi,%edx
80100498:	ee                   	out    %al,(%dx)
80100499:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  outb(CRTPORT+1, pos>>8);
8010049e:	89 c8                	mov    %ecx,%eax
801004a0:	c1 f8 08             	sar    $0x8,%eax
801004a3:	89 da                	mov    %ebx,%edx
801004a5:	ee                   	out    %al,(%dx)
801004a6:	b0 0f                	mov    $0xf,%al
801004a8:	89 f2                	mov    %esi,%edx
801004aa:	ee                   	out    %al,(%dx)
801004ab:	88 c8                	mov    %cl,%al
801004ad:	89 da                	mov    %ebx,%edx
801004af:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004b0:	b8 20 07 00 00       	mov    $0x720,%eax
801004b5:	66 89 84 09 00 80 0b 	mov    %ax,-0x7ff48000(%ecx,%ecx,1)
801004bc:	80 
}
801004bd:	83 c4 2c             	add    $0x2c,%esp
801004c0:	5b                   	pop    %ebx
801004c1:	5e                   	pop    %esi
801004c2:	5f                   	pop    %edi
801004c3:	5d                   	pop    %ebp
801004c4:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004c5:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004cc:	e8 9f 6e 00 00       	call   80107370 <uartputc>
801004d1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004d8:	e8 93 6e 00 00       	call   80107370 <uartputc>
801004dd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004e4:	e8 87 6e 00 00       	call   80107370 <uartputc>
801004e9:	e9 40 ff ff ff       	jmp    8010042e <consputc+0x2e>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004ee:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
801004f5:	00 
801004f6:	c7 44 24 04 a0 80 0b 	movl   $0x800b80a0,0x4(%esp)
801004fd:	80 
801004fe:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
80100505:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80100508:	e8 73 57 00 00       	call   80105c80 <memmove>
    pos -= 80;
8010050d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100510:	b8 80 07 00 00       	mov    $0x780,%eax
80100515:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010051c:	00 
    pos -= 80;
8010051d:	83 e9 50             	sub    $0x50,%ecx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100520:	29 c8                	sub    %ecx,%eax
80100522:	01 c0                	add    %eax,%eax
80100524:	89 44 24 08          	mov    %eax,0x8(%esp)
80100528:	8d 04 09             	lea    (%ecx,%ecx,1),%eax
8010052b:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100530:	89 04 24             	mov    %eax,(%esp)
80100533:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80100536:	e8 85 56 00 00       	call   80105bc0 <memset>
8010053b:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010053e:	e9 4c ff ff ff       	jmp    8010048f <consputc+0x8f>
    panic("pos under/overflow");
80100543:	c7 04 24 c5 87 10 80 	movl   $0x801087c5,(%esp)
8010054a:	e8 21 fe ff ff       	call   80100370 <panic>
    if(pos > 0) --pos;
8010054f:	85 c9                	test   %ecx,%ecx
80100551:	0f 84 38 ff ff ff    	je     8010048f <consputc+0x8f>
80100557:	49                   	dec    %ecx
80100558:	e9 1e ff ff ff       	jmp    8010047b <consputc+0x7b>
    pos += 80 - pos%80;
8010055d:	89 c8                	mov    %ecx,%eax
8010055f:	bb 50 00 00 00       	mov    $0x50,%ebx
80100564:	99                   	cltd   
80100565:	f7 fb                	idiv   %ebx
80100567:	29 d3                	sub    %edx,%ebx
80100569:	01 d9                	add    %ebx,%ecx
8010056b:	e9 0b ff ff ff       	jmp    8010047b <consputc+0x7b>

80100570 <printint>:
{
80100570:	55                   	push   %ebp
80100571:	89 e5                	mov    %esp,%ebp
80100573:	57                   	push   %edi
80100574:	56                   	push   %esi
80100575:	53                   	push   %ebx
80100576:	89 d3                	mov    %edx,%ebx
80100578:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010057b:	85 c9                	test   %ecx,%ecx
{
8010057d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100580:	74 04                	je     80100586 <printint+0x16>
80100582:	85 c0                	test   %eax,%eax
80100584:	78 62                	js     801005e8 <printint+0x78>
    x = xx;
80100586:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010058d:	31 c9                	xor    %ecx,%ecx
8010058f:	8d 75 d7             	lea    -0x29(%ebp),%esi
80100592:	eb 06                	jmp    8010059a <printint+0x2a>
80100594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
80100598:	89 f9                	mov    %edi,%ecx
8010059a:	31 d2                	xor    %edx,%edx
8010059c:	f7 f3                	div    %ebx
8010059e:	8d 79 01             	lea    0x1(%ecx),%edi
801005a1:	0f b6 92 f0 87 10 80 	movzbl -0x7fef7810(%edx),%edx
  }while((x /= base) != 0);
801005a8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005aa:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
801005ad:	75 e9                	jne    80100598 <printint+0x28>
  if(sign)
801005af:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005b2:	85 c0                	test   %eax,%eax
801005b4:	74 08                	je     801005be <printint+0x4e>
    buf[i++] = '-';
801005b6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
801005bb:	8d 79 02             	lea    0x2(%ecx),%edi
801005be:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801005c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    consputc(buf[i]);
801005d0:	0f be 03             	movsbl (%ebx),%eax
801005d3:	4b                   	dec    %ebx
801005d4:	e8 27 fe ff ff       	call   80100400 <consputc>
  while(--i >= 0)
801005d9:	39 f3                	cmp    %esi,%ebx
801005db:	75 f3                	jne    801005d0 <printint+0x60>
}
801005dd:	83 c4 2c             	add    $0x2c,%esp
801005e0:	5b                   	pop    %ebx
801005e1:	5e                   	pop    %esi
801005e2:	5f                   	pop    %edi
801005e3:	5d                   	pop    %ebp
801005e4:	c3                   	ret    
801005e5:	8d 76 00             	lea    0x0(%esi),%esi
    x = -xx;
801005e8:	f7 d8                	neg    %eax
801005ea:	eb a1                	jmp    8010058d <printint+0x1d>
801005ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801005f0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005f0:	55                   	push   %ebp
801005f1:	89 e5                	mov    %esp,%ebp
801005f3:	57                   	push   %edi
801005f4:	56                   	push   %esi
801005f5:	53                   	push   %ebx
801005f6:	83 ec 1c             	sub    $0x1c,%esp
  int i;

  iunlock(ip);
801005f9:	8b 45 08             	mov    0x8(%ebp),%eax
{
801005fc:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
801005ff:	89 04 24             	mov    %eax,(%esp)
80100602:	e8 c9 11 00 00       	call   801017d0 <iunlock>
  acquire(&cons.lock);
80100607:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010060e:	e8 bd 54 00 00       	call   80105ad0 <acquire>
  for(i = 0; i < n; i++)
80100613:	85 f6                	test   %esi,%esi
80100615:	7e 16                	jle    8010062d <consolewrite+0x3d>
80100617:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010061a:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010061d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100620:	0f b6 07             	movzbl (%edi),%eax
80100623:	47                   	inc    %edi
80100624:	e8 d7 fd ff ff       	call   80100400 <consputc>
  for(i = 0; i < n; i++)
80100629:	39 fb                	cmp    %edi,%ebx
8010062b:	75 f3                	jne    80100620 <consolewrite+0x30>
  release(&cons.lock);
8010062d:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
80100634:	e8 37 55 00 00       	call   80105b70 <release>
  ilock(ip);
80100639:	8b 45 08             	mov    0x8(%ebp),%eax
8010063c:	89 04 24             	mov    %eax,(%esp)
8010063f:	e8 ac 10 00 00       	call   801016f0 <ilock>

  return n;
}
80100644:	83 c4 1c             	add    $0x1c,%esp
80100647:	89 f0                	mov    %esi,%eax
80100649:	5b                   	pop    %ebx
8010064a:	5e                   	pop    %esi
8010064b:	5f                   	pop    %edi
8010064c:	5d                   	pop    %ebp
8010064d:	c3                   	ret    
8010064e:	66 90                	xchg   %ax,%ax

80100650 <cprintf>:
{
80100650:	55                   	push   %ebp
80100651:	89 e5                	mov    %esp,%ebp
80100653:	57                   	push   %edi
80100654:	56                   	push   %esi
80100655:	53                   	push   %ebx
80100656:	83 ec 2c             	sub    $0x2c,%esp
  locking = cons.locking;
80100659:	a1 54 c5 10 80       	mov    0x8010c554,%eax
  if(locking)
8010065e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100660:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100663:	0f 85 47 01 00 00    	jne    801007b0 <cprintf+0x160>
  if (fmt == 0)
80100669:	8b 45 08             	mov    0x8(%ebp),%eax
8010066c:	85 c0                	test   %eax,%eax
8010066e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100671:	0f 84 4a 01 00 00    	je     801007c1 <cprintf+0x171>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100677:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
8010067a:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010067d:	31 db                	xor    %ebx,%ebx
8010067f:	89 cf                	mov    %ecx,%edi
80100681:	85 c0                	test   %eax,%eax
80100683:	75 59                	jne    801006de <cprintf+0x8e>
80100685:	eb 79                	jmp    80100700 <cprintf+0xb0>
80100687:	89 f6                	mov    %esi,%esi
80100689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
80100690:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
80100693:	85 d2                	test   %edx,%edx
80100695:	74 69                	je     80100700 <cprintf+0xb0>
80100697:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010069a:	83 c3 02             	add    $0x2,%ebx
    switch(c){
8010069d:	83 fa 70             	cmp    $0x70,%edx
801006a0:	8d 34 18             	lea    (%eax,%ebx,1),%esi
801006a3:	0f 84 81 00 00 00    	je     8010072a <cprintf+0xda>
801006a9:	7f 75                	jg     80100720 <cprintf+0xd0>
801006ab:	83 fa 25             	cmp    $0x25,%edx
801006ae:	0f 84 e4 00 00 00    	je     80100798 <cprintf+0x148>
801006b4:	83 fa 64             	cmp    $0x64,%edx
801006b7:	0f 85 8b 00 00 00    	jne    80100748 <cprintf+0xf8>
      printint(*argp++, 10, 1);
801006bd:	8d 47 04             	lea    0x4(%edi),%eax
801006c0:	b9 01 00 00 00       	mov    $0x1,%ecx
801006c5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801006c8:	8b 07                	mov    (%edi),%eax
801006ca:	ba 0a 00 00 00       	mov    $0xa,%edx
801006cf:	e8 9c fe ff ff       	call   80100570 <printint>
801006d4:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006d7:	0f b6 06             	movzbl (%esi),%eax
801006da:	85 c0                	test   %eax,%eax
801006dc:	74 22                	je     80100700 <cprintf+0xb0>
801006de:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801006e1:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801006e4:	83 f8 25             	cmp    $0x25,%eax
801006e7:	8d 34 11             	lea    (%ecx,%edx,1),%esi
801006ea:	74 a4                	je     80100690 <cprintf+0x40>
801006ec:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801006ef:	e8 0c fd ff ff       	call   80100400 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006f4:	0f b6 06             	movzbl (%esi),%eax
      continue;
801006f7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fa:	85 c0                	test   %eax,%eax
      continue;
801006fc:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fe:	75 de                	jne    801006de <cprintf+0x8e>
  if(locking)
80100700:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100703:	85 c0                	test   %eax,%eax
80100705:	74 0c                	je     80100713 <cprintf+0xc3>
    release(&cons.lock);
80100707:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010070e:	e8 5d 54 00 00       	call   80105b70 <release>
}
80100713:	83 c4 2c             	add    $0x2c,%esp
80100716:	5b                   	pop    %ebx
80100717:	5e                   	pop    %esi
80100718:	5f                   	pop    %edi
80100719:	5d                   	pop    %ebp
8010071a:	c3                   	ret    
8010071b:	90                   	nop
8010071c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100720:	83 fa 73             	cmp    $0x73,%edx
80100723:	74 43                	je     80100768 <cprintf+0x118>
80100725:	83 fa 78             	cmp    $0x78,%edx
80100728:	75 1e                	jne    80100748 <cprintf+0xf8>
      printint(*argp++, 16, 0);
8010072a:	8d 47 04             	lea    0x4(%edi),%eax
8010072d:	31 c9                	xor    %ecx,%ecx
8010072f:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100732:	8b 07                	mov    (%edi),%eax
80100734:	ba 10 00 00 00       	mov    $0x10,%edx
80100739:	e8 32 fe ff ff       	call   80100570 <printint>
8010073e:	8b 7d e0             	mov    -0x20(%ebp),%edi
      break;
80100741:	eb 94                	jmp    801006d7 <cprintf+0x87>
80100743:	90                   	nop
80100744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100748:	b8 25 00 00 00       	mov    $0x25,%eax
8010074d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100750:	e8 ab fc ff ff       	call   80100400 <consputc>
      consputc(c);
80100755:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100758:	89 d0                	mov    %edx,%eax
8010075a:	e8 a1 fc ff ff       	call   80100400 <consputc>
      break;
8010075f:	e9 73 ff ff ff       	jmp    801006d7 <cprintf+0x87>
80100764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100768:	8d 47 04             	lea    0x4(%edi),%eax
8010076b:	8b 3f                	mov    (%edi),%edi
8010076d:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100770:	85 ff                	test   %edi,%edi
80100772:	75 12                	jne    80100786 <cprintf+0x136>
        s = "(null)";
80100774:	bf d8 87 10 80       	mov    $0x801087d8,%edi
      for(; *s; s++)
80100779:	b8 28 00 00 00       	mov    $0x28,%eax
8010077e:	66 90                	xchg   %ax,%ax
        consputc(*s);
80100780:	e8 7b fc ff ff       	call   80100400 <consputc>
      for(; *s; s++)
80100785:	47                   	inc    %edi
80100786:	0f be 07             	movsbl (%edi),%eax
80100789:	84 c0                	test   %al,%al
8010078b:	75 f3                	jne    80100780 <cprintf+0x130>
      if((s = (char*)*argp++) == 0)
8010078d:	8b 7d e0             	mov    -0x20(%ebp),%edi
80100790:	e9 42 ff ff ff       	jmp    801006d7 <cprintf+0x87>
80100795:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
80100798:	b8 25 00 00 00       	mov    $0x25,%eax
8010079d:	e8 5e fc ff ff       	call   80100400 <consputc>
      break;
801007a2:	e9 30 ff ff ff       	jmp    801006d7 <cprintf+0x87>
801007a7:	89 f6                	mov    %esi,%esi
801007a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    acquire(&cons.lock);
801007b0:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
801007b7:	e8 14 53 00 00       	call   80105ad0 <acquire>
801007bc:	e9 a8 fe ff ff       	jmp    80100669 <cprintf+0x19>
    panic("null fmt");
801007c1:	c7 04 24 df 87 10 80 	movl   $0x801087df,(%esp)
801007c8:	e8 a3 fb ff ff       	call   80100370 <panic>
801007cd:	8d 76 00             	lea    0x0(%esi),%esi

801007d0 <consoleintr>:
{
801007d0:	55                   	push   %ebp
801007d1:	89 e5                	mov    %esp,%ebp
801007d3:	56                   	push   %esi
  int c, doprocdump = 0;
801007d4:	31 f6                	xor    %esi,%esi
{
801007d6:	53                   	push   %ebx
801007d7:	83 ec 20             	sub    $0x20,%esp
  acquire(&cons.lock);
801007da:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
{
801007e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
801007e4:	e8 e7 52 00 00       	call   80105ad0 <acquire>
801007e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while((c = getc()) >= 0){
801007f0:	ff d3                	call   *%ebx
801007f2:	85 c0                	test   %eax,%eax
801007f4:	89 c2                	mov    %eax,%edx
801007f6:	78 48                	js     80100840 <consoleintr+0x70>
    switch(c){
801007f8:	83 fa 10             	cmp    $0x10,%edx
801007fb:	0f 84 e7 00 00 00    	je     801008e8 <consoleintr+0x118>
80100801:	7e 5d                	jle    80100860 <consoleintr+0x90>
80100803:	83 fa 15             	cmp    $0x15,%edx
80100806:	0f 84 ec 00 00 00    	je     801008f8 <consoleintr+0x128>
8010080c:	83 fa 7f             	cmp    $0x7f,%edx
8010080f:	90                   	nop
80100810:	75 53                	jne    80100865 <consoleintr+0x95>
      if(input.e != input.w){
80100812:	a1 08 20 11 80       	mov    0x80112008,%eax
80100817:	3b 05 04 20 11 80    	cmp    0x80112004,%eax
8010081d:	74 d1                	je     801007f0 <consoleintr+0x20>
        input.e--;
8010081f:	48                   	dec    %eax
80100820:	a3 08 20 11 80       	mov    %eax,0x80112008
        consputc(BACKSPACE);
80100825:	b8 00 01 00 00       	mov    $0x100,%eax
8010082a:	e8 d1 fb ff ff       	call   80100400 <consputc>
  while((c = getc()) >= 0){
8010082f:	ff d3                	call   *%ebx
80100831:	85 c0                	test   %eax,%eax
80100833:	89 c2                	mov    %eax,%edx
80100835:	79 c1                	jns    801007f8 <consoleintr+0x28>
80100837:	89 f6                	mov    %esi,%esi
80100839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&cons.lock);
80100840:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
80100847:	e8 24 53 00 00       	call   80105b70 <release>
  if(doprocdump) {
8010084c:	85 f6                	test   %esi,%esi
8010084e:	0f 85 f4 00 00 00    	jne    80100948 <consoleintr+0x178>
}
80100854:	83 c4 20             	add    $0x20,%esp
80100857:	5b                   	pop    %ebx
80100858:	5e                   	pop    %esi
80100859:	5d                   	pop    %ebp
8010085a:	c3                   	ret    
8010085b:	90                   	nop
8010085c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100860:	83 fa 08             	cmp    $0x8,%edx
80100863:	74 ad                	je     80100812 <consoleintr+0x42>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100865:	85 d2                	test   %edx,%edx
80100867:	74 87                	je     801007f0 <consoleintr+0x20>
80100869:	a1 08 20 11 80       	mov    0x80112008,%eax
8010086e:	89 c1                	mov    %eax,%ecx
80100870:	2b 0d 00 20 11 80    	sub    0x80112000,%ecx
80100876:	83 f9 7f             	cmp    $0x7f,%ecx
80100879:	0f 87 71 ff ff ff    	ja     801007f0 <consoleintr+0x20>
8010087f:	8d 48 01             	lea    0x1(%eax),%ecx
80100882:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
80100885:	83 fa 0d             	cmp    $0xd,%edx
        input.buf[input.e++ % INPUT_BUF] = c;
80100888:	89 0d 08 20 11 80    	mov    %ecx,0x80112008
        c = (c == '\r') ? '\n' : c;
8010088e:	0f 84 c4 00 00 00    	je     80100958 <consoleintr+0x188>
        input.buf[input.e++ % INPUT_BUF] = c;
80100894:	88 90 80 1f 11 80    	mov    %dl,-0x7feee080(%eax)
        consputc(c);
8010089a:	89 d0                	mov    %edx,%eax
8010089c:	89 55 f4             	mov    %edx,-0xc(%ebp)
8010089f:	e8 5c fb ff ff       	call   80100400 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008a4:	8b 55 f4             	mov    -0xc(%ebp),%edx
801008a7:	83 fa 0a             	cmp    $0xa,%edx
801008aa:	0f 84 b9 00 00 00    	je     80100969 <consoleintr+0x199>
801008b0:	83 fa 04             	cmp    $0x4,%edx
801008b3:	0f 84 b0 00 00 00    	je     80100969 <consoleintr+0x199>
801008b9:	a1 00 20 11 80       	mov    0x80112000,%eax
801008be:	83 e8 80             	sub    $0xffffff80,%eax
801008c1:	39 05 08 20 11 80    	cmp    %eax,0x80112008
801008c7:	0f 85 23 ff ff ff    	jne    801007f0 <consoleintr+0x20>
          wakeup(&input.r);
801008cd:	c7 04 24 00 20 11 80 	movl   $0x80112000,(%esp)
          input.w = input.e;
801008d4:	a3 04 20 11 80       	mov    %eax,0x80112004
          wakeup(&input.r);
801008d9:	e8 b2 3c 00 00       	call   80104590 <wakeup>
801008de:	e9 0d ff ff ff       	jmp    801007f0 <consoleintr+0x20>
801008e3:	90                   	nop
801008e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
801008e8:	be 01 00 00 00       	mov    $0x1,%esi
801008ed:	e9 fe fe ff ff       	jmp    801007f0 <consoleintr+0x20>
801008f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
801008f8:	a1 08 20 11 80       	mov    0x80112008,%eax
801008fd:	39 05 04 20 11 80    	cmp    %eax,0x80112004
80100903:	75 2b                	jne    80100930 <consoleintr+0x160>
80100905:	e9 e6 fe ff ff       	jmp    801007f0 <consoleintr+0x20>
8010090a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100910:	a3 08 20 11 80       	mov    %eax,0x80112008
        consputc(BACKSPACE);
80100915:	b8 00 01 00 00       	mov    $0x100,%eax
8010091a:	e8 e1 fa ff ff       	call   80100400 <consputc>
      while(input.e != input.w &&
8010091f:	a1 08 20 11 80       	mov    0x80112008,%eax
80100924:	3b 05 04 20 11 80    	cmp    0x80112004,%eax
8010092a:	0f 84 c0 fe ff ff    	je     801007f0 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100930:	48                   	dec    %eax
80100931:	89 c2                	mov    %eax,%edx
80100933:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100936:	80 ba 80 1f 11 80 0a 	cmpb   $0xa,-0x7feee080(%edx)
8010093d:	75 d1                	jne    80100910 <consoleintr+0x140>
8010093f:	e9 ac fe ff ff       	jmp    801007f0 <consoleintr+0x20>
80100944:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80100948:	83 c4 20             	add    $0x20,%esp
8010094b:	5b                   	pop    %ebx
8010094c:	5e                   	pop    %esi
8010094d:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
8010094e:	e9 0d 3d 00 00       	jmp    80104660 <procdump>
80100953:	90                   	nop
80100954:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
80100958:	c6 80 80 1f 11 80 0a 	movb   $0xa,-0x7feee080(%eax)
        consputc(c);
8010095f:	b8 0a 00 00 00       	mov    $0xa,%eax
80100964:	e8 97 fa ff ff       	call   80100400 <consputc>
80100969:	a1 08 20 11 80       	mov    0x80112008,%eax
8010096e:	e9 5a ff ff ff       	jmp    801008cd <consoleintr+0xfd>
80100973:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100980 <consoleinit>:

void
consoleinit(void)
{
80100980:	55                   	push   %ebp
  initlock(&cons.lock, "console");
80100981:	b8 e8 87 10 80       	mov    $0x801087e8,%eax
{
80100986:	89 e5                	mov    %esp,%ebp
80100988:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
8010098b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010098f:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
80100996:	e8 e5 4f 00 00       	call   80105980 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;
8010099b:	b8 01 00 00 00       	mov    $0x1,%eax
  devsw[CONSOLE].write = consolewrite;
801009a0:	ba f0 05 10 80       	mov    $0x801005f0,%edx
  cons.locking = 1;
801009a5:	a3 54 c5 10 80       	mov    %eax,0x8010c554

  ioapicenable(IRQ_KBD, 0);
801009aa:	31 c0                	xor    %eax,%eax
  devsw[CONSOLE].read = consoleread;
801009ac:	b9 60 02 10 80       	mov    $0x80100260,%ecx
  ioapicenable(IRQ_KBD, 0);
801009b1:	89 44 24 04          	mov    %eax,0x4(%esp)
801009b5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  devsw[CONSOLE].write = consolewrite;
801009bc:	89 15 cc 29 11 80    	mov    %edx,0x801129cc
  devsw[CONSOLE].read = consoleread;
801009c2:	89 0d c8 29 11 80    	mov    %ecx,0x801129c8
  ioapicenable(IRQ_KBD, 0);
801009c8:	e8 d3 19 00 00       	call   801023a0 <ioapicenable>
}
801009cd:	c9                   	leave  
801009ce:	c3                   	ret    
801009cf:	90                   	nop

801009d0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009d0:	55                   	push   %ebp
801009d1:	89 e5                	mov    %esp,%ebp
801009d3:	57                   	push   %edi
801009d4:	56                   	push   %esi
801009d5:	53                   	push   %ebx
801009d6:	81 ec 2c 01 00 00    	sub    $0x12c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801009dc:	e8 3f 30 00 00       	call   80103a20 <myproc>
801009e1:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
801009e7:	e8 a4 22 00 00       	call   80102c90 <begin_op>

  if((ip = namei(path)) == 0){
801009ec:	8b 45 08             	mov    0x8(%ebp),%eax
801009ef:	89 04 24             	mov    %eax,(%esp)
801009f2:	e8 d9 15 00 00       	call   80101fd0 <namei>
801009f7:	85 c0                	test   %eax,%eax
801009f9:	0f 84 b6 01 00 00    	je     80100bb5 <exec+0x1e5>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
801009ff:	89 04 24             	mov    %eax,(%esp)
80100a02:	89 c7                	mov    %eax,%edi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a04:	31 db                	xor    %ebx,%ebx
  ilock(ip);
80100a06:	e8 e5 0c 00 00       	call   801016f0 <ilock>
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a0b:	b9 34 00 00 00       	mov    $0x34,%ecx
80100a10:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a16:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80100a1a:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100a1e:	89 44 24 04          	mov    %eax,0x4(%esp)
80100a22:	89 3c 24             	mov    %edi,(%esp)
80100a25:	e8 a6 0f 00 00       	call   801019d0 <readi>
80100a2a:	83 f8 34             	cmp    $0x34,%eax
80100a2d:	74 21                	je     80100a50 <exec+0x80>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a2f:	89 3c 24             	mov    %edi,(%esp)
80100a32:	e8 49 0f 00 00       	call   80101980 <iunlockput>
    end_op();
80100a37:	e8 c4 22 00 00       	call   80102d00 <end_op>
  }
  return -1;
80100a3c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a41:	81 c4 2c 01 00 00    	add    $0x12c,%esp
80100a47:	5b                   	pop    %ebx
80100a48:	5e                   	pop    %esi
80100a49:	5f                   	pop    %edi
80100a4a:	5d                   	pop    %ebp
80100a4b:	c3                   	ret    
80100a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100a50:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a57:	45 4c 46 
80100a5a:	75 d3                	jne    80100a2f <exec+0x5f>
  if((pgdir = setupkvm()) == 0)
80100a5c:	e8 6f 7a 00 00       	call   801084d0 <setupkvm>
80100a61:	85 c0                	test   %eax,%eax
80100a63:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100a69:	74 c4                	je     80100a2f <exec+0x5f>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a6b:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  sz = 0;
80100a71:	31 f6                	xor    %esi,%esi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a73:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a7a:	00 
80100a7b:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100a81:	0f 84 b8 02 00 00    	je     80100d3f <exec+0x36f>
80100a87:	31 db                	xor    %ebx,%ebx
80100a89:	e9 8c 00 00 00       	jmp    80100b1a <exec+0x14a>
80100a8e:	66 90                	xchg   %ax,%ax
    if(ph.type != ELF_PROG_LOAD)
80100a90:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100a97:	75 75                	jne    80100b0e <exec+0x13e>
    if(ph.memsz < ph.filesz)
80100a99:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100a9f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100aa5:	0f 82 a4 00 00 00    	jb     80100b4f <exec+0x17f>
80100aab:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ab1:	0f 82 98 00 00 00    	jb     80100b4f <exec+0x17f>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100ab7:	89 44 24 08          	mov    %eax,0x8(%esp)
80100abb:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ac1:	89 74 24 04          	mov    %esi,0x4(%esp)
80100ac5:	89 04 24             	mov    %eax,(%esp)
80100ac8:	e8 23 78 00 00       	call   801082f0 <allocuvm>
80100acd:	85 c0                	test   %eax,%eax
80100acf:	89 c6                	mov    %eax,%esi
80100ad1:	74 7c                	je     80100b4f <exec+0x17f>
    if(ph.vaddr % PGSIZE != 0)
80100ad3:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100ad9:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100ade:	75 6f                	jne    80100b4f <exec+0x17f>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100ae0:	8b 95 14 ff ff ff    	mov    -0xec(%ebp),%edx
80100ae6:	89 44 24 04          	mov    %eax,0x4(%esp)
80100aea:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100af0:	89 7c 24 08          	mov    %edi,0x8(%esp)
80100af4:	89 54 24 10          	mov    %edx,0x10(%esp)
80100af8:	8b 95 08 ff ff ff    	mov    -0xf8(%ebp),%edx
80100afe:	89 04 24             	mov    %eax,(%esp)
80100b01:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100b05:	e8 26 77 00 00       	call   80108230 <loaduvm>
80100b0a:	85 c0                	test   %eax,%eax
80100b0c:	78 41                	js     80100b4f <exec+0x17f>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b0e:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b15:	43                   	inc    %ebx
80100b16:	39 d8                	cmp    %ebx,%eax
80100b18:	7e 48                	jle    80100b62 <exec+0x192>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b1a:	8b 95 ec fe ff ff    	mov    -0x114(%ebp),%edx
80100b20:	b8 20 00 00 00       	mov    $0x20,%eax
80100b25:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100b29:	89 d8                	mov    %ebx,%eax
80100b2b:	c1 e0 05             	shl    $0x5,%eax
80100b2e:	89 3c 24             	mov    %edi,(%esp)
80100b31:	01 d0                	add    %edx,%eax
80100b33:	89 44 24 08          	mov    %eax,0x8(%esp)
80100b37:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b3d:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b41:	e8 8a 0e 00 00       	call   801019d0 <readi>
80100b46:	83 f8 20             	cmp    $0x20,%eax
80100b49:	0f 84 41 ff ff ff    	je     80100a90 <exec+0xc0>
    freevm(pgdir);
80100b4f:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b55:	89 04 24             	mov    %eax,(%esp)
80100b58:	e8 f3 78 00 00       	call   80108450 <freevm>
80100b5d:	e9 cd fe ff ff       	jmp    80100a2f <exec+0x5f>
80100b62:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80100b68:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80100b6e:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
  iunlockput(ip);
80100b74:	89 3c 24             	mov    %edi,(%esp)
80100b77:	e8 04 0e 00 00       	call   80101980 <iunlockput>
  end_op();
80100b7c:	e8 7f 21 00 00       	call   80102d00 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b81:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b87:	89 74 24 04          	mov    %esi,0x4(%esp)
80100b8b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100b8f:	89 04 24             	mov    %eax,(%esp)
80100b92:	e8 59 77 00 00       	call   801082f0 <allocuvm>
80100b97:	85 c0                	test   %eax,%eax
80100b99:	89 c6                	mov    %eax,%esi
80100b9b:	75 33                	jne    80100bd0 <exec+0x200>
    freevm(pgdir);
80100b9d:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ba3:	89 04 24             	mov    %eax,(%esp)
80100ba6:	e8 a5 78 00 00       	call   80108450 <freevm>
  return -1;
80100bab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bb0:	e9 8c fe ff ff       	jmp    80100a41 <exec+0x71>
    end_op();
80100bb5:	e8 46 21 00 00       	call   80102d00 <end_op>
    cprintf("exec: fail\n");
80100bba:	c7 04 24 01 88 10 80 	movl   $0x80108801,(%esp)
80100bc1:	e8 8a fa ff ff       	call   80100650 <cprintf>
    return -1;
80100bc6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bcb:	e9 71 fe ff ff       	jmp    80100a41 <exec+0x71>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bd0:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80100bd6:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bd8:	89 44 24 04          	mov    %eax,0x4(%esp)
80100bdc:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  for(argc = 0; argv[argc]; argc++) {
80100be2:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100be4:	89 04 24             	mov    %eax,(%esp)
80100be7:	e8 84 79 00 00       	call   80108570 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100bec:	8b 45 0c             	mov    0xc(%ebp),%eax
80100bef:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100bf5:	8b 00                	mov    (%eax),%eax
80100bf7:	85 c0                	test   %eax,%eax
80100bf9:	74 78                	je     80100c73 <exec+0x2a3>
80100bfb:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100c01:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c07:	eb 0c                	jmp    80100c15 <exec+0x245>
80100c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100c10:	83 ff 20             	cmp    $0x20,%edi
80100c13:	74 88                	je     80100b9d <exec+0x1cd>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c15:	89 04 24             	mov    %eax,(%esp)
80100c18:	e8 c3 51 00 00       	call   80105de0 <strlen>
80100c1d:	f7 d0                	not    %eax
80100c1f:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c21:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c24:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c27:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c2a:	89 04 24             	mov    %eax,(%esp)
80100c2d:	e8 ae 51 00 00       	call   80105de0 <strlen>
80100c32:	40                   	inc    %eax
80100c33:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c37:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c3a:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c3d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100c41:	89 34 24             	mov    %esi,(%esp)
80100c44:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c48:	e8 93 7a 00 00       	call   801086e0 <copyout>
80100c4d:	85 c0                	test   %eax,%eax
80100c4f:	0f 88 48 ff ff ff    	js     80100b9d <exec+0x1cd>
  for(argc = 0; argv[argc]; argc++) {
80100c55:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c58:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c5e:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c65:	47                   	inc    %edi
80100c66:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c69:	85 c0                	test   %eax,%eax
80100c6b:	75 a3                	jne    80100c10 <exec+0x240>
80100c6d:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  ustack[3+argc] = 0;
80100c73:	31 c0                	xor    %eax,%eax
  ustack[0] = 0xffffffff;  // fake return PC
80100c75:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  ustack[3+argc] = 0;
80100c7a:	89 84 bd 64 ff ff ff 	mov    %eax,-0x9c(%ebp,%edi,4)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c81:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
  ustack[0] = 0xffffffff;  // fake return PC
80100c88:	89 8d 58 ff ff ff    	mov    %ecx,-0xa8(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c8e:	89 d9                	mov    %ebx,%ecx
80100c90:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100c92:	83 c0 0c             	add    $0xc,%eax
80100c95:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c97:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c9b:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ca1:	89 54 24 08          	mov    %edx,0x8(%esp)
80100ca5:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  ustack[1] = argc;
80100ca9:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100caf:	89 04 24             	mov    %eax,(%esp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb2:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cb8:	e8 23 7a 00 00       	call   801086e0 <copyout>
80100cbd:	85 c0                	test   %eax,%eax
80100cbf:	0f 88 d8 fe ff ff    	js     80100b9d <exec+0x1cd>
  for(last=s=path; *s; s++)
80100cc5:	8b 45 08             	mov    0x8(%ebp),%eax
80100cc8:	0f b6 00             	movzbl (%eax),%eax
80100ccb:	84 c0                	test   %al,%al
80100ccd:	74 15                	je     80100ce4 <exec+0x314>
80100ccf:	8b 55 08             	mov    0x8(%ebp),%edx
80100cd2:	89 d1                	mov    %edx,%ecx
80100cd4:	41                   	inc    %ecx
80100cd5:	3c 2f                	cmp    $0x2f,%al
80100cd7:	0f b6 01             	movzbl (%ecx),%eax
80100cda:	0f 44 d1             	cmove  %ecx,%edx
80100cdd:	84 c0                	test   %al,%al
80100cdf:	75 f3                	jne    80100cd4 <exec+0x304>
80100ce1:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100ce4:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cea:	8b 45 08             	mov    0x8(%ebp),%eax
80100ced:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80100cf4:	00 
80100cf5:	89 44 24 04          	mov    %eax,0x4(%esp)
80100cf9:	89 f8                	mov    %edi,%eax
80100cfb:	83 c0 6c             	add    $0x6c,%eax
80100cfe:	89 04 24             	mov    %eax,(%esp)
80100d01:	e8 9a 50 00 00       	call   80105da0 <safestrcpy>
  curproc->pgdir = pgdir;
80100d06:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  oldpgdir = curproc->pgdir;
80100d0c:	89 f9                	mov    %edi,%ecx
80100d0e:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
80100d11:	89 31                	mov    %esi,(%ecx)
  curproc->tf->eip = elf.entry;  // main
80100d13:	8b 41 18             	mov    0x18(%ecx),%eax
  curproc->pgdir = pgdir;
80100d16:	89 51 04             	mov    %edx,0x4(%ecx)
  curproc->tf->eip = elf.entry;  // main
80100d19:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d1f:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d22:	8b 41 18             	mov    0x18(%ecx),%eax
80100d25:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d28:	89 0c 24             	mov    %ecx,(%esp)
80100d2b:	e8 70 73 00 00       	call   801080a0 <switchuvm>
  freevm(oldpgdir);
80100d30:	89 3c 24             	mov    %edi,(%esp)
80100d33:	e8 18 77 00 00       	call   80108450 <freevm>
  return 0;
80100d38:	31 c0                	xor    %eax,%eax
80100d3a:	e9 02 fd ff ff       	jmp    80100a41 <exec+0x71>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d3f:	bb 00 20 00 00       	mov    $0x2000,%ebx
80100d44:	e9 2b fe ff ff       	jmp    80100b74 <exec+0x1a4>
80100d49:	66 90                	xchg   %ax,%ax
80100d4b:	66 90                	xchg   %ax,%ax
80100d4d:	66 90                	xchg   %ax,%ax
80100d4f:	90                   	nop

80100d50 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d50:	55                   	push   %ebp
  initlock(&ftable.lock, "ftable");
80100d51:	b8 0d 88 10 80       	mov    $0x8010880d,%eax
{
80100d56:	89 e5                	mov    %esp,%ebp
80100d58:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100d5b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100d5f:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
80100d66:	e8 15 4c 00 00       	call   80105980 <initlock>
}
80100d6b:	c9                   	leave  
80100d6c:	c3                   	ret    
80100d6d:	8d 76 00             	lea    0x0(%esi),%esi

80100d70 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d70:	55                   	push   %ebp
80100d71:	89 e5                	mov    %esp,%ebp
80100d73:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d74:	bb 54 20 11 80       	mov    $0x80112054,%ebx
{
80100d79:	83 ec 14             	sub    $0x14,%esp
  acquire(&ftable.lock);
80100d7c:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
80100d83:	e8 48 4d 00 00       	call   80105ad0 <acquire>
80100d88:	eb 11                	jmp    80100d9b <filealloc+0x2b>
80100d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d90:	83 c3 18             	add    $0x18,%ebx
80100d93:	81 fb b4 29 11 80    	cmp    $0x801129b4,%ebx
80100d99:	73 25                	jae    80100dc0 <filealloc+0x50>
    if(f->ref == 0){
80100d9b:	8b 43 04             	mov    0x4(%ebx),%eax
80100d9e:	85 c0                	test   %eax,%eax
80100da0:	75 ee                	jne    80100d90 <filealloc+0x20>
      f->ref = 1;
80100da2:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100da9:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
80100db0:	e8 bb 4d 00 00       	call   80105b70 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100db5:	83 c4 14             	add    $0x14,%esp
80100db8:	89 d8                	mov    %ebx,%eax
80100dba:	5b                   	pop    %ebx
80100dbb:	5d                   	pop    %ebp
80100dbc:	c3                   	ret    
80100dbd:	8d 76 00             	lea    0x0(%esi),%esi
  release(&ftable.lock);
80100dc0:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
  return 0;
80100dc7:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100dc9:	e8 a2 4d 00 00       	call   80105b70 <release>
}
80100dce:	83 c4 14             	add    $0x14,%esp
80100dd1:	89 d8                	mov    %ebx,%eax
80100dd3:	5b                   	pop    %ebx
80100dd4:	5d                   	pop    %ebp
80100dd5:	c3                   	ret    
80100dd6:	8d 76 00             	lea    0x0(%esi),%esi
80100dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100de0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100de0:	55                   	push   %ebp
80100de1:	89 e5                	mov    %esp,%ebp
80100de3:	53                   	push   %ebx
80100de4:	83 ec 14             	sub    $0x14,%esp
80100de7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dea:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
80100df1:	e8 da 4c 00 00       	call   80105ad0 <acquire>
  if(f->ref < 1)
80100df6:	8b 43 04             	mov    0x4(%ebx),%eax
80100df9:	85 c0                	test   %eax,%eax
80100dfb:	7e 18                	jle    80100e15 <filedup+0x35>
    panic("filedup");
  f->ref++;
80100dfd:	40                   	inc    %eax
80100dfe:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e01:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
80100e08:	e8 63 4d 00 00       	call   80105b70 <release>
  return f;
}
80100e0d:	83 c4 14             	add    $0x14,%esp
80100e10:	89 d8                	mov    %ebx,%eax
80100e12:	5b                   	pop    %ebx
80100e13:	5d                   	pop    %ebp
80100e14:	c3                   	ret    
    panic("filedup");
80100e15:	c7 04 24 14 88 10 80 	movl   $0x80108814,(%esp)
80100e1c:	e8 4f f5 ff ff       	call   80100370 <panic>
80100e21:	eb 0d                	jmp    80100e30 <fileclose>
80100e23:	90                   	nop
80100e24:	90                   	nop
80100e25:	90                   	nop
80100e26:	90                   	nop
80100e27:	90                   	nop
80100e28:	90                   	nop
80100e29:	90                   	nop
80100e2a:	90                   	nop
80100e2b:	90                   	nop
80100e2c:	90                   	nop
80100e2d:	90                   	nop
80100e2e:	90                   	nop
80100e2f:	90                   	nop

80100e30 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	83 ec 38             	sub    $0x38,%esp
80100e36:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80100e39:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100e3c:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
{
80100e43:	89 75 f8             	mov    %esi,-0x8(%ebp)
80100e46:	89 7d fc             	mov    %edi,-0x4(%ebp)
  acquire(&ftable.lock);
80100e49:	e8 82 4c 00 00       	call   80105ad0 <acquire>
  if(f->ref < 1)
80100e4e:	8b 43 04             	mov    0x4(%ebx),%eax
80100e51:	85 c0                	test   %eax,%eax
80100e53:	0f 8e a0 00 00 00    	jle    80100ef9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80100e59:	48                   	dec    %eax
80100e5a:	85 c0                	test   %eax,%eax
80100e5c:	89 43 04             	mov    %eax,0x4(%ebx)
80100e5f:	74 1f                	je     80100e80 <fileclose+0x50>
    release(&ftable.lock);
80100e61:	c7 45 08 20 20 11 80 	movl   $0x80112020,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e68:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100e6b:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100e6e:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100e71:	89 ec                	mov    %ebp,%esp
80100e73:	5d                   	pop    %ebp
    release(&ftable.lock);
80100e74:	e9 f7 4c 00 00       	jmp    80105b70 <release>
80100e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100e80:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100e84:	8b 3b                	mov    (%ebx),%edi
80100e86:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100e89:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100e8f:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e92:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100e95:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
  ff = *f;
80100e9c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100e9f:	e8 cc 4c 00 00       	call   80105b70 <release>
  if(ff.type == FD_PIPE)
80100ea4:	83 ff 01             	cmp    $0x1,%edi
80100ea7:	74 17                	je     80100ec0 <fileclose+0x90>
  else if(ff.type == FD_INODE){
80100ea9:	83 ff 02             	cmp    $0x2,%edi
80100eac:	74 2a                	je     80100ed8 <fileclose+0xa8>
}
80100eae:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100eb1:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100eb4:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100eb7:	89 ec                	mov    %ebp,%esp
80100eb9:	5d                   	pop    %ebp
80100eba:	c3                   	ret    
80100ebb:	90                   	nop
80100ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pipeclose(ff.pipe, ff.writable);
80100ec0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100ec4:	89 34 24             	mov    %esi,(%esp)
80100ec7:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100ecb:	e8 f0 25 00 00       	call   801034c0 <pipeclose>
80100ed0:	eb dc                	jmp    80100eae <fileclose+0x7e>
80100ed2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    begin_op();
80100ed8:	e8 b3 1d 00 00       	call   80102c90 <begin_op>
    iput(ff.ip);
80100edd:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ee0:	89 04 24             	mov    %eax,(%esp)
80100ee3:	e8 38 09 00 00       	call   80101820 <iput>
}
80100ee8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100eeb:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100eee:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100ef1:	89 ec                	mov    %ebp,%esp
80100ef3:	5d                   	pop    %ebp
    end_op();
80100ef4:	e9 07 1e 00 00       	jmp    80102d00 <end_op>
    panic("fileclose");
80100ef9:	c7 04 24 1c 88 10 80 	movl   $0x8010881c,(%esp)
80100f00:	e8 6b f4 ff ff       	call   80100370 <panic>
80100f05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f10 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f10:	55                   	push   %ebp
80100f11:	89 e5                	mov    %esp,%ebp
80100f13:	53                   	push   %ebx
80100f14:	83 ec 14             	sub    $0x14,%esp
80100f17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f1a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f1d:	75 31                	jne    80100f50 <filestat+0x40>
    ilock(f->ip);
80100f1f:	8b 43 10             	mov    0x10(%ebx),%eax
80100f22:	89 04 24             	mov    %eax,(%esp)
80100f25:	e8 c6 07 00 00       	call   801016f0 <ilock>
    stati(f->ip, st);
80100f2a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f2d:	89 44 24 04          	mov    %eax,0x4(%esp)
80100f31:	8b 43 10             	mov    0x10(%ebx),%eax
80100f34:	89 04 24             	mov    %eax,(%esp)
80100f37:	e8 64 0a 00 00       	call   801019a0 <stati>
    iunlock(f->ip);
80100f3c:	8b 43 10             	mov    0x10(%ebx),%eax
80100f3f:	89 04 24             	mov    %eax,(%esp)
80100f42:	e8 89 08 00 00       	call   801017d0 <iunlock>
    return 0;
80100f47:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f49:	83 c4 14             	add    $0x14,%esp
80100f4c:	5b                   	pop    %ebx
80100f4d:	5d                   	pop    %ebp
80100f4e:	c3                   	ret    
80100f4f:	90                   	nop
  return -1;
80100f50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f55:	eb f2                	jmp    80100f49 <filestat+0x39>
80100f57:	89 f6                	mov    %esi,%esi
80100f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f60 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f60:	55                   	push   %ebp
80100f61:	89 e5                	mov    %esp,%ebp
80100f63:	83 ec 38             	sub    $0x38,%esp
80100f66:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80100f69:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f6c:	89 75 f8             	mov    %esi,-0x8(%ebp)
80100f6f:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f72:	89 7d fc             	mov    %edi,-0x4(%ebp)
80100f75:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f78:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f7c:	74 72                	je     80100ff0 <fileread+0x90>
    return -1;
  if(f->type == FD_PIPE)
80100f7e:	8b 03                	mov    (%ebx),%eax
80100f80:	83 f8 01             	cmp    $0x1,%eax
80100f83:	74 53                	je     80100fd8 <fileread+0x78>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f85:	83 f8 02             	cmp    $0x2,%eax
80100f88:	75 6d                	jne    80100ff7 <fileread+0x97>
    ilock(f->ip);
80100f8a:	8b 43 10             	mov    0x10(%ebx),%eax
80100f8d:	89 04 24             	mov    %eax,(%esp)
80100f90:	e8 5b 07 00 00       	call   801016f0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f95:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80100f99:	8b 43 14             	mov    0x14(%ebx),%eax
80100f9c:	89 74 24 04          	mov    %esi,0x4(%esp)
80100fa0:	89 44 24 08          	mov    %eax,0x8(%esp)
80100fa4:	8b 43 10             	mov    0x10(%ebx),%eax
80100fa7:	89 04 24             	mov    %eax,(%esp)
80100faa:	e8 21 0a 00 00       	call   801019d0 <readi>
80100faf:	85 c0                	test   %eax,%eax
80100fb1:	7e 03                	jle    80100fb6 <fileread+0x56>
      f->off += r;
80100fb3:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100fb6:	8b 53 10             	mov    0x10(%ebx),%edx
80100fb9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100fbc:	89 14 24             	mov    %edx,(%esp)
80100fbf:	e8 0c 08 00 00       	call   801017d0 <iunlock>
    return r;
80100fc4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  }
  panic("fileread");
}
80100fc7:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100fca:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100fcd:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100fd0:	89 ec                	mov    %ebp,%esp
80100fd2:	5d                   	pop    %ebp
80100fd3:	c3                   	ret    
80100fd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return piperead(f->pipe, addr, n);
80100fd8:	8b 43 0c             	mov    0xc(%ebx),%eax
}
80100fdb:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100fde:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100fe1:	8b 7d fc             	mov    -0x4(%ebp),%edi
    return piperead(f->pipe, addr, n);
80100fe4:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100fe7:	89 ec                	mov    %ebp,%esp
80100fe9:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100fea:	e9 81 26 00 00       	jmp    80103670 <piperead>
80100fef:	90                   	nop
    return -1;
80100ff0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100ff5:	eb d0                	jmp    80100fc7 <fileread+0x67>
  panic("fileread");
80100ff7:	c7 04 24 26 88 10 80 	movl   $0x80108826,(%esp)
80100ffe:	e8 6d f3 ff ff       	call   80100370 <panic>
80101003:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101010 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101010:	55                   	push   %ebp
80101011:	89 e5                	mov    %esp,%ebp
80101013:	57                   	push   %edi
80101014:	56                   	push   %esi
80101015:	53                   	push   %ebx
80101016:	83 ec 2c             	sub    $0x2c,%esp
80101019:	8b 45 0c             	mov    0xc(%ebp),%eax
8010101c:	8b 7d 08             	mov    0x8(%ebp),%edi
8010101f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101022:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101025:	80 7f 09 00          	cmpb   $0x0,0x9(%edi)
{
80101029:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010102c:	0f 84 ae 00 00 00    	je     801010e0 <filewrite+0xd0>
    return -1;
  if(f->type == FD_PIPE)
80101032:	8b 07                	mov    (%edi),%eax
80101034:	83 f8 01             	cmp    $0x1,%eax
80101037:	0f 84 c3 00 00 00    	je     80101100 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010103d:	83 f8 02             	cmp    $0x2,%eax
80101040:	0f 85 d8 00 00 00    	jne    8010111e <filewrite+0x10e>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101046:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101049:	31 f6                	xor    %esi,%esi
    while(i < n){
8010104b:	85 c0                	test   %eax,%eax
8010104d:	7f 31                	jg     80101080 <filewrite+0x70>
8010104f:	e9 9c 00 00 00       	jmp    801010f0 <filewrite+0xe0>
80101054:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
      iunlock(f->ip);
80101058:	8b 4f 10             	mov    0x10(%edi),%ecx
        f->off += r;
8010105b:	01 47 14             	add    %eax,0x14(%edi)
8010105e:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101061:	89 0c 24             	mov    %ecx,(%esp)
80101064:	e8 67 07 00 00       	call   801017d0 <iunlock>
      end_op();
80101069:	e8 92 1c 00 00       	call   80102d00 <end_op>
8010106e:	8b 45 e0             	mov    -0x20(%ebp),%eax

      if(r < 0)
        break;
      if(r != n1)
80101071:	39 c3                	cmp    %eax,%ebx
80101073:	0f 85 99 00 00 00    	jne    80101112 <filewrite+0x102>
        panic("short filewrite");
      i += r;
80101079:	01 de                	add    %ebx,%esi
    while(i < n){
8010107b:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010107e:	7e 70                	jle    801010f0 <filewrite+0xe0>
      int n1 = n - i;
80101080:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101083:	b8 00 06 00 00       	mov    $0x600,%eax
80101088:	29 f3                	sub    %esi,%ebx
8010108a:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101090:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101093:	e8 f8 1b 00 00       	call   80102c90 <begin_op>
      ilock(f->ip);
80101098:	8b 47 10             	mov    0x10(%edi),%eax
8010109b:	89 04 24             	mov    %eax,(%esp)
8010109e:	e8 4d 06 00 00       	call   801016f0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801010a3:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
801010a7:	8b 47 14             	mov    0x14(%edi),%eax
801010aa:	89 44 24 08          	mov    %eax,0x8(%esp)
801010ae:	8b 45 dc             	mov    -0x24(%ebp),%eax
801010b1:	01 f0                	add    %esi,%eax
801010b3:	89 44 24 04          	mov    %eax,0x4(%esp)
801010b7:	8b 47 10             	mov    0x10(%edi),%eax
801010ba:	89 04 24             	mov    %eax,(%esp)
801010bd:	e8 2e 0a 00 00       	call   80101af0 <writei>
801010c2:	85 c0                	test   %eax,%eax
801010c4:	7f 92                	jg     80101058 <filewrite+0x48>
      iunlock(f->ip);
801010c6:	8b 4f 10             	mov    0x10(%edi),%ecx
801010c9:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010cc:	89 0c 24             	mov    %ecx,(%esp)
801010cf:	e8 fc 06 00 00       	call   801017d0 <iunlock>
      end_op();
801010d4:	e8 27 1c 00 00       	call   80102d00 <end_op>
      if(r < 0)
801010d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010dc:	85 c0                	test   %eax,%eax
801010de:	74 91                	je     80101071 <filewrite+0x61>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010e0:	83 c4 2c             	add    $0x2c,%esp
    return -1;
801010e3:	be ff ff ff ff       	mov    $0xffffffff,%esi
}
801010e8:	5b                   	pop    %ebx
801010e9:	89 f0                	mov    %esi,%eax
801010eb:	5e                   	pop    %esi
801010ec:	5f                   	pop    %edi
801010ed:	5d                   	pop    %ebp
801010ee:	c3                   	ret    
801010ef:	90                   	nop
    return i == n ? n : -1;
801010f0:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
801010f3:	75 eb                	jne    801010e0 <filewrite+0xd0>
}
801010f5:	83 c4 2c             	add    $0x2c,%esp
801010f8:	89 f0                	mov    %esi,%eax
801010fa:	5b                   	pop    %ebx
801010fb:	5e                   	pop    %esi
801010fc:	5f                   	pop    %edi
801010fd:	5d                   	pop    %ebp
801010fe:	c3                   	ret    
801010ff:	90                   	nop
    return pipewrite(f->pipe, addr, n);
80101100:	8b 47 0c             	mov    0xc(%edi),%eax
80101103:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101106:	83 c4 2c             	add    $0x2c,%esp
80101109:	5b                   	pop    %ebx
8010110a:	5e                   	pop    %esi
8010110b:	5f                   	pop    %edi
8010110c:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
8010110d:	e9 4e 24 00 00       	jmp    80103560 <pipewrite>
        panic("short filewrite");
80101112:	c7 04 24 2f 88 10 80 	movl   $0x8010882f,(%esp)
80101119:	e8 52 f2 ff ff       	call   80100370 <panic>
  panic("filewrite");
8010111e:	c7 04 24 35 88 10 80 	movl   $0x80108835,(%esp)
80101125:	e8 46 f2 ff ff       	call   80100370 <panic>
8010112a:	66 90                	xchg   %ax,%ax
8010112c:	66 90                	xchg   %ax,%ax
8010112e:	66 90                	xchg   %ax,%ax

80101130 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101130:	55                   	push   %ebp
80101131:	89 e5                	mov    %esp,%ebp
80101133:	57                   	push   %edi
80101134:	56                   	push   %esi
80101135:	53                   	push   %ebx
80101136:	83 ec 2c             	sub    $0x2c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101139:	8b 35 20 2a 11 80    	mov    0x80112a20,%esi
{
8010113f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101142:	85 f6                	test   %esi,%esi
80101144:	0f 84 7e 00 00 00    	je     801011c8 <balloc+0x98>
8010114a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101151:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101154:	8b 1d 38 2a 11 80    	mov    0x80112a38,%ebx
8010115a:	89 f0                	mov    %esi,%eax
8010115c:	c1 f8 0c             	sar    $0xc,%eax
8010115f:	01 d8                	add    %ebx,%eax
80101161:	89 44 24 04          	mov    %eax,0x4(%esp)
80101165:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101168:	89 04 24             	mov    %eax,(%esp)
8010116b:	e8 60 ef ff ff       	call   801000d0 <bread>
80101170:	89 c3                	mov    %eax,%ebx
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101172:	a1 20 2a 11 80       	mov    0x80112a20,%eax
80101177:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010117a:	31 c0                	xor    %eax,%eax
8010117c:	eb 2b                	jmp    801011a9 <balloc+0x79>
8010117e:	66 90                	xchg   %ax,%ax
      m = 1 << (bi % 8);
80101180:	89 c1                	mov    %eax,%ecx
80101182:	bf 01 00 00 00       	mov    $0x1,%edi
80101187:	83 e1 07             	and    $0x7,%ecx
8010118a:	d3 e7                	shl    %cl,%edi
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010118c:	89 c1                	mov    %eax,%ecx
8010118e:	c1 f9 03             	sar    $0x3,%ecx
      m = 1 << (bi % 8);
80101191:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101194:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
80101199:	85 7d e4             	test   %edi,-0x1c(%ebp)
8010119c:	89 fa                	mov    %edi,%edx
8010119e:	74 38                	je     801011d8 <balloc+0xa8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011a0:	40                   	inc    %eax
801011a1:	46                   	inc    %esi
801011a2:	3d 00 10 00 00       	cmp    $0x1000,%eax
801011a7:	74 05                	je     801011ae <balloc+0x7e>
801011a9:	39 75 e0             	cmp    %esi,-0x20(%ebp)
801011ac:	77 d2                	ja     80101180 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801011ae:	89 1c 24             	mov    %ebx,(%esp)
801011b1:	e8 2a f0 ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801011b6:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801011bd:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011c0:	39 05 20 2a 11 80    	cmp    %eax,0x80112a20
801011c6:	77 89                	ja     80101151 <balloc+0x21>
  }
  panic("balloc: out of blocks");
801011c8:	c7 04 24 3f 88 10 80 	movl   $0x8010883f,(%esp)
801011cf:	e8 9c f1 ff ff       	call   80100370 <panic>
801011d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
801011d8:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
801011dc:	08 c2                	or     %al,%dl
801011de:	88 54 0b 5c          	mov    %dl,0x5c(%ebx,%ecx,1)
        log_write(bp);
801011e2:	89 1c 24             	mov    %ebx,(%esp)
801011e5:	e8 46 1c 00 00       	call   80102e30 <log_write>
        brelse(bp);
801011ea:	89 1c 24             	mov    %ebx,(%esp)
801011ed:	e8 ee ef ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
801011f2:	8b 45 d8             	mov    -0x28(%ebp),%eax
801011f5:	89 74 24 04          	mov    %esi,0x4(%esp)
801011f9:	89 04 24             	mov    %eax,(%esp)
801011fc:	e8 cf ee ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101201:	ba 00 02 00 00       	mov    $0x200,%edx
80101206:	31 c9                	xor    %ecx,%ecx
80101208:	89 54 24 08          	mov    %edx,0x8(%esp)
8010120c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  bp = bread(dev, bno);
80101210:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101212:	8d 40 5c             	lea    0x5c(%eax),%eax
80101215:	89 04 24             	mov    %eax,(%esp)
80101218:	e8 a3 49 00 00       	call   80105bc0 <memset>
  log_write(bp);
8010121d:	89 1c 24             	mov    %ebx,(%esp)
80101220:	e8 0b 1c 00 00       	call   80102e30 <log_write>
  brelse(bp);
80101225:	89 1c 24             	mov    %ebx,(%esp)
80101228:	e8 b3 ef ff ff       	call   801001e0 <brelse>
}
8010122d:	83 c4 2c             	add    $0x2c,%esp
80101230:	89 f0                	mov    %esi,%eax
80101232:	5b                   	pop    %ebx
80101233:	5e                   	pop    %esi
80101234:	5f                   	pop    %edi
80101235:	5d                   	pop    %ebp
80101236:	c3                   	ret    
80101237:	89 f6                	mov    %esi,%esi
80101239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101240 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101240:	55                   	push   %ebp
80101241:	89 e5                	mov    %esp,%ebp
80101243:	57                   	push   %edi
80101244:	89 c7                	mov    %eax,%edi
80101246:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101247:	31 f6                	xor    %esi,%esi
{
80101249:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010124a:	bb 74 2a 11 80       	mov    $0x80112a74,%ebx
{
8010124f:	83 ec 2c             	sub    $0x2c,%esp
  acquire(&icache.lock);
80101252:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
{
80101259:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
8010125c:	e8 6f 48 00 00       	call   80105ad0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101261:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101264:	eb 18                	jmp    8010127e <iget+0x3e>
80101266:	8d 76 00             	lea    0x0(%esi),%esi
80101269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101270:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101276:	81 fb 94 46 11 80    	cmp    $0x80114694,%ebx
8010127c:	73 22                	jae    801012a0 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010127e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101281:	85 c9                	test   %ecx,%ecx
80101283:	7e 04                	jle    80101289 <iget+0x49>
80101285:	39 3b                	cmp    %edi,(%ebx)
80101287:	74 47                	je     801012d0 <iget+0x90>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101289:	85 f6                	test   %esi,%esi
8010128b:	75 e3                	jne    80101270 <iget+0x30>
8010128d:	85 c9                	test   %ecx,%ecx
8010128f:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101292:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101298:	81 fb 94 46 11 80    	cmp    $0x80114694,%ebx
8010129e:	72 de                	jb     8010127e <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801012a0:	85 f6                	test   %esi,%esi
801012a2:	74 4d                	je     801012f1 <iget+0xb1>
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
801012a4:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801012a6:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801012a9:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801012b0:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801012b7:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
801012be:	e8 ad 48 00 00       	call   80105b70 <release>

  return ip;
}
801012c3:	83 c4 2c             	add    $0x2c,%esp
801012c6:	89 f0                	mov    %esi,%eax
801012c8:	5b                   	pop    %ebx
801012c9:	5e                   	pop    %esi
801012ca:	5f                   	pop    %edi
801012cb:	5d                   	pop    %ebp
801012cc:	c3                   	ret    
801012cd:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012d0:	39 53 04             	cmp    %edx,0x4(%ebx)
801012d3:	75 b4                	jne    80101289 <iget+0x49>
      ip->ref++;
801012d5:	41                   	inc    %ecx
      return ip;
801012d6:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801012d8:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
      ip->ref++;
801012df:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801012e2:	e8 89 48 00 00       	call   80105b70 <release>
}
801012e7:	83 c4 2c             	add    $0x2c,%esp
801012ea:	89 f0                	mov    %esi,%eax
801012ec:	5b                   	pop    %ebx
801012ed:	5e                   	pop    %esi
801012ee:	5f                   	pop    %edi
801012ef:	5d                   	pop    %ebp
801012f0:	c3                   	ret    
    panic("iget: no inodes");
801012f1:	c7 04 24 55 88 10 80 	movl   $0x80108855,(%esp)
801012f8:	e8 73 f0 ff ff       	call   80100370 <panic>
801012fd:	8d 76 00             	lea    0x0(%esi),%esi

80101300 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101300:	55                   	push   %ebp
80101301:	89 e5                	mov    %esp,%ebp
80101303:	83 ec 38             	sub    $0x38,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101306:	83 fa 0b             	cmp    $0xb,%edx
{
80101309:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010130c:	89 c6                	mov    %eax,%esi
8010130e:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80101311:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(bn < NDIRECT){
80101314:	77 1a                	ja     80101330 <bmap+0x30>
80101316:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
80101319:	8b 5f 5c             	mov    0x5c(%edi),%ebx
8010131c:	85 db                	test   %ebx,%ebx
8010131e:	74 70                	je     80101390 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
80101320:	89 d8                	mov    %ebx,%eax
80101322:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101325:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101328:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010132b:	89 ec                	mov    %ebp,%esp
8010132d:	5d                   	pop    %ebp
8010132e:	c3                   	ret    
8010132f:	90                   	nop
  bn -= NDIRECT;
80101330:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
80101333:	83 fb 7f             	cmp    $0x7f,%ebx
80101336:	0f 87 85 00 00 00    	ja     801013c1 <bmap+0xc1>
    if((addr = ip->addrs[NDIRECT]) == 0)
8010133c:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
80101342:	8b 00                	mov    (%eax),%eax
80101344:	85 d2                	test   %edx,%edx
80101346:	74 68                	je     801013b0 <bmap+0xb0>
    bp = bread(ip->dev, addr);
80101348:	89 54 24 04          	mov    %edx,0x4(%esp)
8010134c:	89 04 24             	mov    %eax,(%esp)
8010134f:	e8 7c ed ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
80101354:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
    bp = bread(ip->dev, addr);
80101358:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
8010135a:	8b 1a                	mov    (%edx),%ebx
8010135c:	85 db                	test   %ebx,%ebx
8010135e:	75 19                	jne    80101379 <bmap+0x79>
      a[bn] = addr = balloc(ip->dev);
80101360:	8b 06                	mov    (%esi),%eax
80101362:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101365:	e8 c6 fd ff ff       	call   80101130 <balloc>
8010136a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010136d:	89 02                	mov    %eax,(%edx)
8010136f:	89 c3                	mov    %eax,%ebx
      log_write(bp);
80101371:	89 3c 24             	mov    %edi,(%esp)
80101374:	e8 b7 1a 00 00       	call   80102e30 <log_write>
    brelse(bp);
80101379:	89 3c 24             	mov    %edi,(%esp)
8010137c:	e8 5f ee ff ff       	call   801001e0 <brelse>
}
80101381:	89 d8                	mov    %ebx,%eax
80101383:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101386:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101389:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010138c:	89 ec                	mov    %ebp,%esp
8010138e:	5d                   	pop    %ebp
8010138f:	c3                   	ret    
      ip->addrs[bn] = addr = balloc(ip->dev);
80101390:	8b 00                	mov    (%eax),%eax
80101392:	e8 99 fd ff ff       	call   80101130 <balloc>
80101397:	89 47 5c             	mov    %eax,0x5c(%edi)
8010139a:	89 c3                	mov    %eax,%ebx
}
8010139c:	89 d8                	mov    %ebx,%eax
8010139e:	8b 75 f8             	mov    -0x8(%ebp),%esi
801013a1:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801013a4:	8b 7d fc             	mov    -0x4(%ebp),%edi
801013a7:	89 ec                	mov    %ebp,%esp
801013a9:	5d                   	pop    %ebp
801013aa:	c3                   	ret    
801013ab:	90                   	nop
801013ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801013b0:	e8 7b fd ff ff       	call   80101130 <balloc>
801013b5:	89 c2                	mov    %eax,%edx
801013b7:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801013bd:	8b 06                	mov    (%esi),%eax
801013bf:	eb 87                	jmp    80101348 <bmap+0x48>
  panic("bmap: out of range");
801013c1:	c7 04 24 65 88 10 80 	movl   $0x80108865,(%esp)
801013c8:	e8 a3 ef ff ff       	call   80100370 <panic>
801013cd:	8d 76 00             	lea    0x0(%esi),%esi

801013d0 <readsb>:
{
801013d0:	55                   	push   %ebp
  bp = bread(dev, 1);
801013d1:	b8 01 00 00 00       	mov    $0x1,%eax
{
801013d6:	89 e5                	mov    %esp,%ebp
801013d8:	83 ec 18             	sub    $0x18,%esp
  bp = bread(dev, 1);
801013db:	89 44 24 04          	mov    %eax,0x4(%esp)
801013df:	8b 45 08             	mov    0x8(%ebp),%eax
{
801013e2:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801013e5:	89 75 fc             	mov    %esi,-0x4(%ebp)
801013e8:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801013eb:	89 04 24             	mov    %eax,(%esp)
801013ee:	e8 dd ec ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801013f3:	ba 1c 00 00 00       	mov    $0x1c,%edx
801013f8:	89 34 24             	mov    %esi,(%esp)
801013fb:	89 54 24 08          	mov    %edx,0x8(%esp)
  bp = bread(dev, 1);
801013ff:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101401:	8d 40 5c             	lea    0x5c(%eax),%eax
80101404:	89 44 24 04          	mov    %eax,0x4(%esp)
80101408:	e8 73 48 00 00       	call   80105c80 <memmove>
}
8010140d:	8b 75 fc             	mov    -0x4(%ebp),%esi
  brelse(bp);
80101410:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101413:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80101416:	89 ec                	mov    %ebp,%esp
80101418:	5d                   	pop    %ebp
  brelse(bp);
80101419:	e9 c2 ed ff ff       	jmp    801001e0 <brelse>
8010141e:	66 90                	xchg   %ax,%ax

80101420 <bfree>:
{
80101420:	55                   	push   %ebp
80101421:	89 e5                	mov    %esp,%ebp
80101423:	56                   	push   %esi
80101424:	89 c6                	mov    %eax,%esi
80101426:	53                   	push   %ebx
80101427:	89 d3                	mov    %edx,%ebx
80101429:	83 ec 10             	sub    $0x10,%esp
  readsb(dev, &sb);
8010142c:	ba 20 2a 11 80       	mov    $0x80112a20,%edx
80101431:	89 54 24 04          	mov    %edx,0x4(%esp)
80101435:	89 04 24             	mov    %eax,(%esp)
80101438:	e8 93 ff ff ff       	call   801013d0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
8010143d:	8b 0d 38 2a 11 80    	mov    0x80112a38,%ecx
80101443:	89 da                	mov    %ebx,%edx
80101445:	c1 ea 0c             	shr    $0xc,%edx
80101448:	89 34 24             	mov    %esi,(%esp)
8010144b:	01 ca                	add    %ecx,%edx
8010144d:	89 54 24 04          	mov    %edx,0x4(%esp)
80101451:	e8 7a ec ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
80101456:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101458:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
8010145b:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
8010145e:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101464:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80101466:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
8010146b:	0f b6 54 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%edx
  m = 1 << (bi % 8);
80101470:	d3 e0                	shl    %cl,%eax
80101472:	89 c1                	mov    %eax,%ecx
  if((bp->data[bi/8] & m) == 0)
80101474:	85 c2                	test   %eax,%edx
80101476:	74 1f                	je     80101497 <bfree+0x77>
  bp->data[bi/8] &= ~m;
80101478:	f6 d1                	not    %cl
8010147a:	20 d1                	and    %dl,%cl
8010147c:	88 4c 1e 5c          	mov    %cl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101480:	89 34 24             	mov    %esi,(%esp)
80101483:	e8 a8 19 00 00       	call   80102e30 <log_write>
  brelse(bp);
80101488:	89 34 24             	mov    %esi,(%esp)
8010148b:	e8 50 ed ff ff       	call   801001e0 <brelse>
}
80101490:	83 c4 10             	add    $0x10,%esp
80101493:	5b                   	pop    %ebx
80101494:	5e                   	pop    %esi
80101495:	5d                   	pop    %ebp
80101496:	c3                   	ret    
    panic("freeing free block");
80101497:	c7 04 24 78 88 10 80 	movl   $0x80108878,(%esp)
8010149e:	e8 cd ee ff ff       	call   80100370 <panic>
801014a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801014a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801014b0 <iinit>:
{
801014b0:	55                   	push   %ebp
  initlock(&icache.lock, "icache");
801014b1:	b9 8b 88 10 80       	mov    $0x8010888b,%ecx
{
801014b6:	89 e5                	mov    %esp,%ebp
801014b8:	53                   	push   %ebx
801014b9:	bb 80 2a 11 80       	mov    $0x80112a80,%ebx
801014be:	83 ec 24             	sub    $0x24,%esp
  initlock(&icache.lock, "icache");
801014c1:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801014c5:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
801014cc:	e8 af 44 00 00       	call   80105980 <initlock>
801014d1:	eb 0d                	jmp    801014e0 <iinit+0x30>
801014d3:	90                   	nop
801014d4:	90                   	nop
801014d5:	90                   	nop
801014d6:	90                   	nop
801014d7:	90                   	nop
801014d8:	90                   	nop
801014d9:	90                   	nop
801014da:	90                   	nop
801014db:	90                   	nop
801014dc:	90                   	nop
801014dd:	90                   	nop
801014de:	90                   	nop
801014df:	90                   	nop
    initsleeplock(&icache.inode[i].lock, "inode");
801014e0:	ba 92 88 10 80       	mov    $0x80108892,%edx
801014e5:	89 1c 24             	mov    %ebx,(%esp)
801014e8:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014ee:	89 54 24 04          	mov    %edx,0x4(%esp)
801014f2:	e8 59 43 00 00       	call   80105850 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014f7:	81 fb a0 46 11 80    	cmp    $0x801146a0,%ebx
801014fd:	75 e1                	jne    801014e0 <iinit+0x30>
  readsb(dev, &sb);
801014ff:	b8 20 2a 11 80       	mov    $0x80112a20,%eax
80101504:	89 44 24 04          	mov    %eax,0x4(%esp)
80101508:	8b 45 08             	mov    0x8(%ebp),%eax
8010150b:	89 04 24             	mov    %eax,(%esp)
8010150e:	e8 bd fe ff ff       	call   801013d0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101513:	a1 38 2a 11 80       	mov    0x80112a38,%eax
80101518:	c7 04 24 f8 88 10 80 	movl   $0x801088f8,(%esp)
8010151f:	89 44 24 1c          	mov    %eax,0x1c(%esp)
80101523:	a1 34 2a 11 80       	mov    0x80112a34,%eax
80101528:	89 44 24 18          	mov    %eax,0x18(%esp)
8010152c:	a1 30 2a 11 80       	mov    0x80112a30,%eax
80101531:	89 44 24 14          	mov    %eax,0x14(%esp)
80101535:	a1 2c 2a 11 80       	mov    0x80112a2c,%eax
8010153a:	89 44 24 10          	mov    %eax,0x10(%esp)
8010153e:	a1 28 2a 11 80       	mov    0x80112a28,%eax
80101543:	89 44 24 0c          	mov    %eax,0xc(%esp)
80101547:	a1 24 2a 11 80       	mov    0x80112a24,%eax
8010154c:	89 44 24 08          	mov    %eax,0x8(%esp)
80101550:	a1 20 2a 11 80       	mov    0x80112a20,%eax
80101555:	89 44 24 04          	mov    %eax,0x4(%esp)
80101559:	e8 f2 f0 ff ff       	call   80100650 <cprintf>
}
8010155e:	83 c4 24             	add    $0x24,%esp
80101561:	5b                   	pop    %ebx
80101562:	5d                   	pop    %ebp
80101563:	c3                   	ret    
80101564:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010156a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101570 <ialloc>:
{
80101570:	55                   	push   %ebp
80101571:	89 e5                	mov    %esp,%ebp
80101573:	57                   	push   %edi
80101574:	56                   	push   %esi
80101575:	53                   	push   %ebx
80101576:	83 ec 2c             	sub    $0x2c,%esp
80101579:	0f bf 45 0c          	movswl 0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010157d:	83 3d 28 2a 11 80 01 	cmpl   $0x1,0x80112a28
{
80101584:	8b 75 08             	mov    0x8(%ebp),%esi
80101587:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
8010158a:	0f 86 91 00 00 00    	jbe    80101621 <ialloc+0xb1>
80101590:	bb 01 00 00 00       	mov    $0x1,%ebx
80101595:	eb 1a                	jmp    801015b1 <ialloc+0x41>
80101597:	89 f6                	mov    %esi,%esi
80101599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
801015a0:	89 3c 24             	mov    %edi,(%esp)
  for(inum = 1; inum < sb.ninodes; inum++){
801015a3:	43                   	inc    %ebx
    brelse(bp);
801015a4:	e8 37 ec ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801015a9:	39 1d 28 2a 11 80    	cmp    %ebx,0x80112a28
801015af:	76 70                	jbe    80101621 <ialloc+0xb1>
    bp = bread(dev, IBLOCK(inum, sb));
801015b1:	8b 0d 34 2a 11 80    	mov    0x80112a34,%ecx
801015b7:	89 d8                	mov    %ebx,%eax
801015b9:	c1 e8 03             	shr    $0x3,%eax
801015bc:	89 34 24             	mov    %esi,(%esp)
801015bf:	01 c8                	add    %ecx,%eax
801015c1:	89 44 24 04          	mov    %eax,0x4(%esp)
801015c5:	e8 06 eb ff ff       	call   801000d0 <bread>
801015ca:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
801015cc:	89 d8                	mov    %ebx,%eax
801015ce:	83 e0 07             	and    $0x7,%eax
801015d1:	c1 e0 06             	shl    $0x6,%eax
801015d4:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801015d8:	66 83 39 00          	cmpw   $0x0,(%ecx)
801015dc:	75 c2                	jne    801015a0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801015de:	31 d2                	xor    %edx,%edx
801015e0:	b8 40 00 00 00       	mov    $0x40,%eax
801015e5:	89 54 24 04          	mov    %edx,0x4(%esp)
801015e9:	89 0c 24             	mov    %ecx,(%esp)
801015ec:	89 44 24 08          	mov    %eax,0x8(%esp)
801015f0:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801015f3:	e8 c8 45 00 00       	call   80105bc0 <memset>
      dip->type = type;
801015f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801015fb:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801015fe:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
80101601:	89 3c 24             	mov    %edi,(%esp)
80101604:	e8 27 18 00 00       	call   80102e30 <log_write>
      brelse(bp);
80101609:	89 3c 24             	mov    %edi,(%esp)
8010160c:	e8 cf eb ff ff       	call   801001e0 <brelse>
}
80101611:	83 c4 2c             	add    $0x2c,%esp
      return iget(dev, inum);
80101614:	89 da                	mov    %ebx,%edx
}
80101616:	5b                   	pop    %ebx
      return iget(dev, inum);
80101617:	89 f0                	mov    %esi,%eax
}
80101619:	5e                   	pop    %esi
8010161a:	5f                   	pop    %edi
8010161b:	5d                   	pop    %ebp
      return iget(dev, inum);
8010161c:	e9 1f fc ff ff       	jmp    80101240 <iget>
  panic("ialloc: no inodes");
80101621:	c7 04 24 98 88 10 80 	movl   $0x80108898,(%esp)
80101628:	e8 43 ed ff ff       	call   80100370 <panic>
8010162d:	8d 76 00             	lea    0x0(%esi),%esi

80101630 <iupdate>:
{
80101630:	55                   	push   %ebp
80101631:	89 e5                	mov    %esp,%ebp
80101633:	56                   	push   %esi
80101634:	53                   	push   %ebx
80101635:	83 ec 10             	sub    $0x10,%esp
80101638:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010163b:	8b 15 34 2a 11 80    	mov    0x80112a34,%edx
80101641:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101644:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101647:	c1 e8 03             	shr    $0x3,%eax
8010164a:	01 d0                	add    %edx,%eax
8010164c:	89 44 24 04          	mov    %eax,0x4(%esp)
80101650:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80101653:	89 04 24             	mov    %eax,(%esp)
80101656:	e8 75 ea ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
8010165b:	0f bf 53 f4          	movswl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010165f:	b9 34 00 00 00       	mov    $0x34,%ecx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101664:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101666:	8b 43 a8             	mov    -0x58(%ebx),%eax
80101669:	83 e0 07             	and    $0x7,%eax
8010166c:	c1 e0 06             	shl    $0x6,%eax
8010166f:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101673:	66 89 10             	mov    %dx,(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101676:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101679:	0f bf 53 f6          	movswl -0xa(%ebx),%edx
8010167d:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101681:	0f bf 53 f8          	movswl -0x8(%ebx),%edx
80101685:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
80101689:	0f bf 53 fa          	movswl -0x6(%ebx),%edx
8010168d:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101691:	8b 53 fc             	mov    -0x4(%ebx),%edx
80101694:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101697:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010169b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010169f:	89 04 24             	mov    %eax,(%esp)
801016a2:	e8 d9 45 00 00       	call   80105c80 <memmove>
  log_write(bp);
801016a7:	89 34 24             	mov    %esi,(%esp)
801016aa:	e8 81 17 00 00       	call   80102e30 <log_write>
  brelse(bp);
801016af:	89 75 08             	mov    %esi,0x8(%ebp)
}
801016b2:	83 c4 10             	add    $0x10,%esp
801016b5:	5b                   	pop    %ebx
801016b6:	5e                   	pop    %esi
801016b7:	5d                   	pop    %ebp
  brelse(bp);
801016b8:	e9 23 eb ff ff       	jmp    801001e0 <brelse>
801016bd:	8d 76 00             	lea    0x0(%esi),%esi

801016c0 <idup>:
{
801016c0:	55                   	push   %ebp
801016c1:	89 e5                	mov    %esp,%ebp
801016c3:	53                   	push   %ebx
801016c4:	83 ec 14             	sub    $0x14,%esp
801016c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801016ca:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
801016d1:	e8 fa 43 00 00       	call   80105ad0 <acquire>
  ip->ref++;
801016d6:	ff 43 08             	incl   0x8(%ebx)
  release(&icache.lock);
801016d9:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
801016e0:	e8 8b 44 00 00       	call   80105b70 <release>
}
801016e5:	83 c4 14             	add    $0x14,%esp
801016e8:	89 d8                	mov    %ebx,%eax
801016ea:	5b                   	pop    %ebx
801016eb:	5d                   	pop    %ebp
801016ec:	c3                   	ret    
801016ed:	8d 76 00             	lea    0x0(%esi),%esi

801016f0 <ilock>:
{
801016f0:	55                   	push   %ebp
801016f1:	89 e5                	mov    %esp,%ebp
801016f3:	56                   	push   %esi
801016f4:	53                   	push   %ebx
801016f5:	83 ec 10             	sub    $0x10,%esp
801016f8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801016fb:	85 db                	test   %ebx,%ebx
801016fd:	0f 84 be 00 00 00    	je     801017c1 <ilock+0xd1>
80101703:	8b 43 08             	mov    0x8(%ebx),%eax
80101706:	85 c0                	test   %eax,%eax
80101708:	0f 8e b3 00 00 00    	jle    801017c1 <ilock+0xd1>
  acquiresleep(&ip->lock);
8010170e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101711:	89 04 24             	mov    %eax,(%esp)
80101714:	e8 77 41 00 00       	call   80105890 <acquiresleep>
  if(ip->valid == 0){
80101719:	8b 73 4c             	mov    0x4c(%ebx),%esi
8010171c:	85 f6                	test   %esi,%esi
8010171e:	74 10                	je     80101730 <ilock+0x40>
}
80101720:	83 c4 10             	add    $0x10,%esp
80101723:	5b                   	pop    %ebx
80101724:	5e                   	pop    %esi
80101725:	5d                   	pop    %ebp
80101726:	c3                   	ret    
80101727:	89 f6                	mov    %esi,%esi
80101729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101730:	8b 43 04             	mov    0x4(%ebx),%eax
80101733:	8b 15 34 2a 11 80    	mov    0x80112a34,%edx
80101739:	c1 e8 03             	shr    $0x3,%eax
8010173c:	01 d0                	add    %edx,%eax
8010173e:	89 44 24 04          	mov    %eax,0x4(%esp)
80101742:	8b 03                	mov    (%ebx),%eax
80101744:	89 04 24             	mov    %eax,(%esp)
80101747:	e8 84 e9 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010174c:	b9 34 00 00 00       	mov    $0x34,%ecx
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101751:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101753:	8b 43 04             	mov    0x4(%ebx),%eax
80101756:	83 e0 07             	and    $0x7,%eax
80101759:	c1 e0 06             	shl    $0x6,%eax
8010175c:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101760:	0f bf 10             	movswl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101763:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
80101766:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
8010176a:	0f bf 50 f6          	movswl -0xa(%eax),%edx
8010176e:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101772:	0f bf 50 f8          	movswl -0x8(%eax),%edx
80101776:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
8010177a:	0f bf 50 fa          	movswl -0x6(%eax),%edx
8010177e:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101782:	8b 50 fc             	mov    -0x4(%eax),%edx
80101785:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101788:	89 44 24 04          	mov    %eax,0x4(%esp)
8010178c:	8d 43 5c             	lea    0x5c(%ebx),%eax
8010178f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101793:	89 04 24             	mov    %eax,(%esp)
80101796:	e8 e5 44 00 00       	call   80105c80 <memmove>
    brelse(bp);
8010179b:	89 34 24             	mov    %esi,(%esp)
8010179e:	e8 3d ea ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
801017a3:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
801017a8:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801017af:	0f 85 6b ff ff ff    	jne    80101720 <ilock+0x30>
      panic("ilock: no type");
801017b5:	c7 04 24 b0 88 10 80 	movl   $0x801088b0,(%esp)
801017bc:	e8 af eb ff ff       	call   80100370 <panic>
    panic("ilock");
801017c1:	c7 04 24 aa 88 10 80 	movl   $0x801088aa,(%esp)
801017c8:	e8 a3 eb ff ff       	call   80100370 <panic>
801017cd:	8d 76 00             	lea    0x0(%esi),%esi

801017d0 <iunlock>:
{
801017d0:	55                   	push   %ebp
801017d1:	89 e5                	mov    %esp,%ebp
801017d3:	83 ec 18             	sub    $0x18,%esp
801017d6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801017d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801017dc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801017df:	85 db                	test   %ebx,%ebx
801017e1:	74 27                	je     8010180a <iunlock+0x3a>
801017e3:	8d 73 0c             	lea    0xc(%ebx),%esi
801017e6:	89 34 24             	mov    %esi,(%esp)
801017e9:	e8 42 41 00 00       	call   80105930 <holdingsleep>
801017ee:	85 c0                	test   %eax,%eax
801017f0:	74 18                	je     8010180a <iunlock+0x3a>
801017f2:	8b 43 08             	mov    0x8(%ebx),%eax
801017f5:	85 c0                	test   %eax,%eax
801017f7:	7e 11                	jle    8010180a <iunlock+0x3a>
  releasesleep(&ip->lock);
801017f9:	89 75 08             	mov    %esi,0x8(%ebp)
}
801017fc:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801017ff:	8b 75 fc             	mov    -0x4(%ebp),%esi
80101802:	89 ec                	mov    %ebp,%esp
80101804:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
80101805:	e9 e6 40 00 00       	jmp    801058f0 <releasesleep>
    panic("iunlock");
8010180a:	c7 04 24 bf 88 10 80 	movl   $0x801088bf,(%esp)
80101811:	e8 5a eb ff ff       	call   80100370 <panic>
80101816:	8d 76 00             	lea    0x0(%esi),%esi
80101819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101820 <iput>:
{
80101820:	55                   	push   %ebp
80101821:	89 e5                	mov    %esp,%ebp
80101823:	83 ec 38             	sub    $0x38,%esp
80101826:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80101829:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010182c:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010182f:	89 75 f8             	mov    %esi,-0x8(%ebp)
  acquiresleep(&ip->lock);
80101832:	8d 7b 0c             	lea    0xc(%ebx),%edi
80101835:	89 3c 24             	mov    %edi,(%esp)
80101838:	e8 53 40 00 00       	call   80105890 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
8010183d:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101840:	85 d2                	test   %edx,%edx
80101842:	74 07                	je     8010184b <iput+0x2b>
80101844:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101849:	74 35                	je     80101880 <iput+0x60>
  releasesleep(&ip->lock);
8010184b:	89 3c 24             	mov    %edi,(%esp)
8010184e:	e8 9d 40 00 00       	call   801058f0 <releasesleep>
  acquire(&icache.lock);
80101853:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
8010185a:	e8 71 42 00 00       	call   80105ad0 <acquire>
  ip->ref--;
8010185f:	ff 4b 08             	decl   0x8(%ebx)
  release(&icache.lock);
80101862:	c7 45 08 40 2a 11 80 	movl   $0x80112a40,0x8(%ebp)
}
80101869:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010186c:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010186f:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101872:	89 ec                	mov    %ebp,%esp
80101874:	5d                   	pop    %ebp
  release(&icache.lock);
80101875:	e9 f6 42 00 00       	jmp    80105b70 <release>
8010187a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101880:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101887:	e8 44 42 00 00       	call   80105ad0 <acquire>
    int r = ip->ref;
8010188c:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
8010188f:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101896:	e8 d5 42 00 00       	call   80105b70 <release>
    if(r == 1){
8010189b:	4e                   	dec    %esi
8010189c:	75 ad                	jne    8010184b <iput+0x2b>
8010189e:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
801018a4:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801018a7:	8d 73 5c             	lea    0x5c(%ebx),%esi
801018aa:	89 cf                	mov    %ecx,%edi
801018ac:	eb 09                	jmp    801018b7 <iput+0x97>
801018ae:	66 90                	xchg   %ax,%ax
801018b0:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801018b3:	39 fe                	cmp    %edi,%esi
801018b5:	74 19                	je     801018d0 <iput+0xb0>
    if(ip->addrs[i]){
801018b7:	8b 16                	mov    (%esi),%edx
801018b9:	85 d2                	test   %edx,%edx
801018bb:	74 f3                	je     801018b0 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
801018bd:	8b 03                	mov    (%ebx),%eax
801018bf:	e8 5c fb ff ff       	call   80101420 <bfree>
      ip->addrs[i] = 0;
801018c4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801018ca:	eb e4                	jmp    801018b0 <iput+0x90>
801018cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
801018d0:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
801018d6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801018d9:	85 c0                	test   %eax,%eax
801018db:	75 33                	jne    80101910 <iput+0xf0>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
801018dd:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
801018e4:	89 1c 24             	mov    %ebx,(%esp)
801018e7:	e8 44 fd ff ff       	call   80101630 <iupdate>
      ip->type = 0;
801018ec:	66 c7 43 50 00 00    	movw   $0x0,0x50(%ebx)
      iupdate(ip);
801018f2:	89 1c 24             	mov    %ebx,(%esp)
801018f5:	e8 36 fd ff ff       	call   80101630 <iupdate>
      ip->valid = 0;
801018fa:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101901:	e9 45 ff ff ff       	jmp    8010184b <iput+0x2b>
80101906:	8d 76 00             	lea    0x0(%esi),%esi
80101909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101910:	89 44 24 04          	mov    %eax,0x4(%esp)
80101914:	8b 03                	mov    (%ebx),%eax
80101916:	89 04 24             	mov    %eax,(%esp)
80101919:	e8 b2 e7 ff ff       	call   801000d0 <bread>
8010191e:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101921:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101927:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
8010192a:	8d 70 5c             	lea    0x5c(%eax),%esi
8010192d:	89 cf                	mov    %ecx,%edi
8010192f:	eb 0e                	jmp    8010193f <iput+0x11f>
80101931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101938:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
8010193b:	39 fe                	cmp    %edi,%esi
8010193d:	74 0f                	je     8010194e <iput+0x12e>
      if(a[j])
8010193f:	8b 16                	mov    (%esi),%edx
80101941:	85 d2                	test   %edx,%edx
80101943:	74 f3                	je     80101938 <iput+0x118>
        bfree(ip->dev, a[j]);
80101945:	8b 03                	mov    (%ebx),%eax
80101947:	e8 d4 fa ff ff       	call   80101420 <bfree>
8010194c:	eb ea                	jmp    80101938 <iput+0x118>
    brelse(bp);
8010194e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101951:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101954:	89 04 24             	mov    %eax,(%esp)
80101957:	e8 84 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
8010195c:	8b 03                	mov    (%ebx),%eax
8010195e:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101964:	e8 b7 fa ff ff       	call   80101420 <bfree>
    ip->addrs[NDIRECT] = 0;
80101969:	31 c0                	xor    %eax,%eax
8010196b:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
80101971:	e9 67 ff ff ff       	jmp    801018dd <iput+0xbd>
80101976:	8d 76 00             	lea    0x0(%esi),%esi
80101979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101980 <iunlockput>:
{
80101980:	55                   	push   %ebp
80101981:	89 e5                	mov    %esp,%ebp
80101983:	53                   	push   %ebx
80101984:	83 ec 14             	sub    $0x14,%esp
80101987:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010198a:	89 1c 24             	mov    %ebx,(%esp)
8010198d:	e8 3e fe ff ff       	call   801017d0 <iunlock>
  iput(ip);
80101992:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101995:	83 c4 14             	add    $0x14,%esp
80101998:	5b                   	pop    %ebx
80101999:	5d                   	pop    %ebp
  iput(ip);
8010199a:	e9 81 fe ff ff       	jmp    80101820 <iput>
8010199f:	90                   	nop

801019a0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
801019a0:	55                   	push   %ebp
801019a1:	89 e5                	mov    %esp,%ebp
801019a3:	8b 55 08             	mov    0x8(%ebp),%edx
801019a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
801019a9:	8b 0a                	mov    (%edx),%ecx
801019ab:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
801019ae:	8b 4a 04             	mov    0x4(%edx),%ecx
801019b1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
801019b4:	0f bf 4a 50          	movswl 0x50(%edx),%ecx
801019b8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
801019bb:	0f bf 4a 56          	movswl 0x56(%edx),%ecx
801019bf:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
801019c3:	8b 52 58             	mov    0x58(%edx),%edx
801019c6:	89 50 10             	mov    %edx,0x10(%eax)
}
801019c9:	5d                   	pop    %ebp
801019ca:	c3                   	ret    
801019cb:	90                   	nop
801019cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801019d0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801019d0:	55                   	push   %ebp
801019d1:	89 e5                	mov    %esp,%ebp
801019d3:	57                   	push   %edi
801019d4:	56                   	push   %esi
801019d5:	53                   	push   %ebx
801019d6:	83 ec 3c             	sub    $0x3c,%esp
801019d9:	8b 45 0c             	mov    0xc(%ebp),%eax
801019dc:	8b 7d 08             	mov    0x8(%ebp),%edi
801019df:	8b 75 10             	mov    0x10(%ebp),%esi
801019e2:	89 45 dc             	mov    %eax,-0x24(%ebp)
801019e5:	8b 45 14             	mov    0x14(%ebp),%eax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801019e8:	66 83 7f 50 03       	cmpw   $0x3,0x50(%edi)
{
801019ed:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(ip->type == T_DEV){
801019f0:	0f 84 ca 00 00 00    	je     80101ac0 <readi+0xf0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801019f6:	8b 47 58             	mov    0x58(%edi),%eax
801019f9:	39 c6                	cmp    %eax,%esi
801019fb:	0f 87 e3 00 00 00    	ja     80101ae4 <readi+0x114>
80101a01:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101a04:	01 f2                	add    %esi,%edx
80101a06:	0f 82 d8 00 00 00    	jb     80101ae4 <readi+0x114>
    return -1;
  if(off + n > ip->size)
80101a0c:	39 d0                	cmp    %edx,%eax
80101a0e:	0f 82 9c 00 00 00    	jb     80101ab0 <readi+0xe0>
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a14:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101a17:	85 c0                	test   %eax,%eax
80101a19:	0f 84 86 00 00 00    	je     80101aa5 <readi+0xd5>
80101a1f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101a26:	89 7d d4             	mov    %edi,-0x2c(%ebp)
80101a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a30:	8b 7d d4             	mov    -0x2c(%ebp),%edi
80101a33:	89 f2                	mov    %esi,%edx
80101a35:	c1 ea 09             	shr    $0x9,%edx
80101a38:	89 f8                	mov    %edi,%eax
80101a3a:	e8 c1 f8 ff ff       	call   80101300 <bmap>
80101a3f:	89 44 24 04          	mov    %eax,0x4(%esp)
80101a43:	8b 07                	mov    (%edi),%eax
80101a45:	89 04 24             	mov    %eax,(%esp)
80101a48:	e8 83 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101a4d:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101a50:	b9 00 02 00 00       	mov    $0x200,%ecx
80101a55:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a58:	29 df                	sub    %ebx,%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a5a:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101a5c:	89 f0                	mov    %esi,%eax
80101a5e:	25 ff 01 00 00       	and    $0x1ff,%eax
80101a63:	89 fb                	mov    %edi,%ebx
80101a65:	29 c1                	sub    %eax,%ecx
80101a67:	39 f9                	cmp    %edi,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101a69:	8b 7d dc             	mov    -0x24(%ebp),%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101a6c:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a6f:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a73:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101a75:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101a79:	89 44 24 04          	mov    %eax,0x4(%esp)
80101a7d:	89 3c 24             	mov    %edi,(%esp)
80101a80:	89 55 d8             	mov    %edx,-0x28(%ebp)
80101a83:	e8 f8 41 00 00       	call   80105c80 <memmove>
    brelse(bp);
80101a88:	8b 55 d8             	mov    -0x28(%ebp),%edx
80101a8b:	89 14 24             	mov    %edx,(%esp)
80101a8e:	e8 4d e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a93:	89 f9                	mov    %edi,%ecx
80101a95:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101a98:	01 d9                	add    %ebx,%ecx
80101a9a:	89 4d dc             	mov    %ecx,-0x24(%ebp)
80101a9d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101aa0:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101aa3:	77 8b                	ja     80101a30 <readi+0x60>
  }
  return n;
80101aa5:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101aa8:	83 c4 3c             	add    $0x3c,%esp
80101aab:	5b                   	pop    %ebx
80101aac:	5e                   	pop    %esi
80101aad:	5f                   	pop    %edi
80101aae:	5d                   	pop    %ebp
80101aaf:	c3                   	ret    
    n = ip->size - off;
80101ab0:	29 f0                	sub    %esi,%eax
80101ab2:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101ab5:	e9 5a ff ff ff       	jmp    80101a14 <readi+0x44>
80101aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101ac0:	0f bf 47 52          	movswl 0x52(%edi),%eax
80101ac4:	66 83 f8 09          	cmp    $0x9,%ax
80101ac8:	77 1a                	ja     80101ae4 <readi+0x114>
80101aca:	8b 04 c5 c0 29 11 80 	mov    -0x7feed640(,%eax,8),%eax
80101ad1:	85 c0                	test   %eax,%eax
80101ad3:	74 0f                	je     80101ae4 <readi+0x114>
    return devsw[ip->major].read(ip, dst, n);
80101ad5:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101ad8:	89 75 10             	mov    %esi,0x10(%ebp)
}
80101adb:	83 c4 3c             	add    $0x3c,%esp
80101ade:	5b                   	pop    %ebx
80101adf:	5e                   	pop    %esi
80101ae0:	5f                   	pop    %edi
80101ae1:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101ae2:	ff e0                	jmp    *%eax
      return -1;
80101ae4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ae9:	eb bd                	jmp    80101aa8 <readi+0xd8>
80101aeb:	90                   	nop
80101aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101af0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101af0:	55                   	push   %ebp
80101af1:	89 e5                	mov    %esp,%ebp
80101af3:	57                   	push   %edi
80101af4:	56                   	push   %esi
80101af5:	53                   	push   %ebx
80101af6:	83 ec 2c             	sub    $0x2c,%esp
80101af9:	8b 45 0c             	mov    0xc(%ebp),%eax
80101afc:	8b 7d 08             	mov    0x8(%ebp),%edi
80101aff:	8b 75 10             	mov    0x10(%ebp),%esi
80101b02:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101b05:	8b 45 14             	mov    0x14(%ebp),%eax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b08:	66 83 7f 50 03       	cmpw   $0x3,0x50(%edi)
{
80101b0d:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(ip->type == T_DEV){
80101b10:	0f 84 da 00 00 00    	je     80101bf0 <writei+0x100>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101b16:	39 77 58             	cmp    %esi,0x58(%edi)
80101b19:	0f 82 09 01 00 00    	jb     80101c28 <writei+0x138>
80101b1f:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101b22:	31 d2                	xor    %edx,%edx
80101b24:	01 f0                	add    %esi,%eax
80101b26:	0f 82 03 01 00 00    	jb     80101c2f <writei+0x13f>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101b2c:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101b31:	0f 87 f1 00 00 00    	ja     80101c28 <writei+0x138>
80101b37:	85 d2                	test   %edx,%edx
80101b39:	0f 85 e9 00 00 00    	jne    80101c28 <writei+0x138>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b3f:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80101b42:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101b49:	85 c9                	test   %ecx,%ecx
80101b4b:	0f 84 8c 00 00 00    	je     80101bdd <writei+0xed>
80101b51:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101b54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101b5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b60:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101b63:	89 f8                	mov    %edi,%eax
80101b65:	89 da                	mov    %ebx,%edx
80101b67:	c1 ea 09             	shr    $0x9,%edx
80101b6a:	e8 91 f7 ff ff       	call   80101300 <bmap>
80101b6f:	89 44 24 04          	mov    %eax,0x4(%esp)
80101b73:	8b 07                	mov    (%edi),%eax
80101b75:	89 04 24             	mov    %eax,(%esp)
80101b78:	e8 53 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b7d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101b80:	b9 00 02 00 00       	mov    $0x200,%ecx
80101b85:	89 5d e0             	mov    %ebx,-0x20(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b88:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80101b8a:	89 d8                	mov    %ebx,%eax
80101b8c:	8b 5d dc             	mov    -0x24(%ebp),%ebx
80101b8f:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b94:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101b96:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b9a:	29 d3                	sub    %edx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101b9c:	8b 55 d8             	mov    -0x28(%ebp),%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101b9f:	39 d9                	cmp    %ebx,%ecx
80101ba1:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101ba4:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101ba8:	89 54 24 04          	mov    %edx,0x4(%esp)
80101bac:	89 04 24             	mov    %eax,(%esp)
80101baf:	e8 cc 40 00 00       	call   80105c80 <memmove>
    log_write(bp);
80101bb4:	89 34 24             	mov    %esi,(%esp)
80101bb7:	e8 74 12 00 00       	call   80102e30 <log_write>
    brelse(bp);
80101bbc:	89 34 24             	mov    %esi,(%esp)
80101bbf:	e8 1c e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101bc4:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101bc7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101bca:	01 5d d8             	add    %ebx,-0x28(%ebp)
80101bcd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101bd0:	39 4d dc             	cmp    %ecx,-0x24(%ebp)
80101bd3:	77 8b                	ja     80101b60 <writei+0x70>
80101bd5:	8b 75 e0             	mov    -0x20(%ebp),%esi
  }

  if(n > 0 && off > ip->size){
80101bd8:	3b 77 58             	cmp    0x58(%edi),%esi
80101bdb:	77 3b                	ja     80101c18 <writei+0x128>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101bdd:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
80101be0:	83 c4 2c             	add    $0x2c,%esp
80101be3:	5b                   	pop    %ebx
80101be4:	5e                   	pop    %esi
80101be5:	5f                   	pop    %edi
80101be6:	5d                   	pop    %ebp
80101be7:	c3                   	ret    
80101be8:	90                   	nop
80101be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101bf0:	0f bf 47 52          	movswl 0x52(%edi),%eax
80101bf4:	66 83 f8 09          	cmp    $0x9,%ax
80101bf8:	77 2e                	ja     80101c28 <writei+0x138>
80101bfa:	8b 04 c5 c4 29 11 80 	mov    -0x7feed63c(,%eax,8),%eax
80101c01:	85 c0                	test   %eax,%eax
80101c03:	74 23                	je     80101c28 <writei+0x138>
    return devsw[ip->major].write(ip, src, n);
80101c05:	8b 7d dc             	mov    -0x24(%ebp),%edi
80101c08:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101c0b:	83 c4 2c             	add    $0x2c,%esp
80101c0e:	5b                   	pop    %ebx
80101c0f:	5e                   	pop    %esi
80101c10:	5f                   	pop    %edi
80101c11:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101c12:	ff e0                	jmp    *%eax
80101c14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101c18:	89 77 58             	mov    %esi,0x58(%edi)
    iupdate(ip);
80101c1b:	89 3c 24             	mov    %edi,(%esp)
80101c1e:	e8 0d fa ff ff       	call   80101630 <iupdate>
80101c23:	eb b8                	jmp    80101bdd <writei+0xed>
80101c25:	8d 76 00             	lea    0x0(%esi),%esi
      return -1;
80101c28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c2d:	eb b1                	jmp    80101be0 <writei+0xf0>
80101c2f:	ba 01 00 00 00       	mov    $0x1,%edx
80101c34:	e9 f3 fe ff ff       	jmp    80101b2c <writei+0x3c>
80101c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101c40 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101c40:	55                   	push   %ebp
  return strncmp(s, t, DIRSIZ);
80101c41:	b8 0e 00 00 00       	mov    $0xe,%eax
{
80101c46:	89 e5                	mov    %esp,%ebp
80101c48:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
80101c4b:	89 44 24 08          	mov    %eax,0x8(%esp)
80101c4f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c52:	89 44 24 04          	mov    %eax,0x4(%esp)
80101c56:	8b 45 08             	mov    0x8(%ebp),%eax
80101c59:	89 04 24             	mov    %eax,(%esp)
80101c5c:	e8 7f 40 00 00       	call   80105ce0 <strncmp>
}
80101c61:	c9                   	leave  
80101c62:	c3                   	ret    
80101c63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c70 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101c70:	55                   	push   %ebp
80101c71:	89 e5                	mov    %esp,%ebp
80101c73:	57                   	push   %edi
80101c74:	56                   	push   %esi
80101c75:	53                   	push   %ebx
80101c76:	83 ec 2c             	sub    $0x2c,%esp
80101c79:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101c7c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101c81:	0f 85 a4 00 00 00    	jne    80101d2b <dirlookup+0xbb>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101c87:	8b 43 58             	mov    0x58(%ebx),%eax
80101c8a:	31 ff                	xor    %edi,%edi
80101c8c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101c8f:	85 c0                	test   %eax,%eax
80101c91:	74 59                	je     80101cec <dirlookup+0x7c>
80101c93:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ca0:	b9 10 00 00 00       	mov    $0x10,%ecx
80101ca5:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80101ca9:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101cad:	89 74 24 04          	mov    %esi,0x4(%esp)
80101cb1:	89 1c 24             	mov    %ebx,(%esp)
80101cb4:	e8 17 fd ff ff       	call   801019d0 <readi>
80101cb9:	83 f8 10             	cmp    $0x10,%eax
80101cbc:	75 61                	jne    80101d1f <dirlookup+0xaf>
      panic("dirlookup read");
    if(de.inum == 0)
80101cbe:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101cc3:	74 1f                	je     80101ce4 <dirlookup+0x74>
  return strncmp(s, t, DIRSIZ);
80101cc5:	8d 45 da             	lea    -0x26(%ebp),%eax
80101cc8:	ba 0e 00 00 00       	mov    $0xe,%edx
80101ccd:	89 44 24 04          	mov    %eax,0x4(%esp)
80101cd1:	8b 45 0c             	mov    0xc(%ebp),%eax
80101cd4:	89 54 24 08          	mov    %edx,0x8(%esp)
80101cd8:	89 04 24             	mov    %eax,(%esp)
80101cdb:	e8 00 40 00 00       	call   80105ce0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101ce0:	85 c0                	test   %eax,%eax
80101ce2:	74 1c                	je     80101d00 <dirlookup+0x90>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101ce4:	83 c7 10             	add    $0x10,%edi
80101ce7:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101cea:	72 b4                	jb     80101ca0 <dirlookup+0x30>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101cec:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80101cef:	31 c0                	xor    %eax,%eax
}
80101cf1:	5b                   	pop    %ebx
80101cf2:	5e                   	pop    %esi
80101cf3:	5f                   	pop    %edi
80101cf4:	5d                   	pop    %ebp
80101cf5:	c3                   	ret    
80101cf6:	8d 76 00             	lea    0x0(%esi),%esi
80101cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(poff)
80101d00:	8b 45 10             	mov    0x10(%ebp),%eax
80101d03:	85 c0                	test   %eax,%eax
80101d05:	74 05                	je     80101d0c <dirlookup+0x9c>
        *poff = off;
80101d07:	8b 45 10             	mov    0x10(%ebp),%eax
80101d0a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101d0c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101d10:	8b 03                	mov    (%ebx),%eax
80101d12:	e8 29 f5 ff ff       	call   80101240 <iget>
}
80101d17:	83 c4 2c             	add    $0x2c,%esp
80101d1a:	5b                   	pop    %ebx
80101d1b:	5e                   	pop    %esi
80101d1c:	5f                   	pop    %edi
80101d1d:	5d                   	pop    %ebp
80101d1e:	c3                   	ret    
      panic("dirlookup read");
80101d1f:	c7 04 24 d9 88 10 80 	movl   $0x801088d9,(%esp)
80101d26:	e8 45 e6 ff ff       	call   80100370 <panic>
    panic("dirlookup not DIR");
80101d2b:	c7 04 24 c7 88 10 80 	movl   $0x801088c7,(%esp)
80101d32:	e8 39 e6 ff ff       	call   80100370 <panic>
80101d37:	89 f6                	mov    %esi,%esi
80101d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101d40 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d40:	55                   	push   %ebp
80101d41:	89 e5                	mov    %esp,%ebp
80101d43:	57                   	push   %edi
80101d44:	89 cf                	mov    %ecx,%edi
80101d46:	56                   	push   %esi
80101d47:	53                   	push   %ebx
80101d48:	89 c3                	mov    %eax,%ebx
80101d4a:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101d4d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101d50:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101d53:	0f 84 5b 01 00 00    	je     80101eb4 <namex+0x174>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101d59:	e8 c2 1c 00 00       	call   80103a20 <myproc>
80101d5e:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101d61:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101d68:	e8 63 3d 00 00       	call   80105ad0 <acquire>
  ip->ref++;
80101d6d:	ff 46 08             	incl   0x8(%esi)
  release(&icache.lock);
80101d70:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101d77:	e8 f4 3d 00 00       	call   80105b70 <release>
80101d7c:	eb 03                	jmp    80101d81 <namex+0x41>
80101d7e:	66 90                	xchg   %ax,%ax
    path++;
80101d80:	43                   	inc    %ebx
  while(*path == '/')
80101d81:	0f b6 03             	movzbl (%ebx),%eax
80101d84:	3c 2f                	cmp    $0x2f,%al
80101d86:	74 f8                	je     80101d80 <namex+0x40>
  if(*path == 0)
80101d88:	84 c0                	test   %al,%al
80101d8a:	0f 84 f0 00 00 00    	je     80101e80 <namex+0x140>
  while(*path != '/' && *path != 0)
80101d90:	0f b6 03             	movzbl (%ebx),%eax
80101d93:	3c 2f                	cmp    $0x2f,%al
80101d95:	0f 84 b5 00 00 00    	je     80101e50 <namex+0x110>
80101d9b:	84 c0                	test   %al,%al
80101d9d:	89 da                	mov    %ebx,%edx
80101d9f:	75 13                	jne    80101db4 <namex+0x74>
80101da1:	e9 aa 00 00 00       	jmp    80101e50 <namex+0x110>
80101da6:	8d 76 00             	lea    0x0(%esi),%esi
80101da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101db0:	84 c0                	test   %al,%al
80101db2:	74 08                	je     80101dbc <namex+0x7c>
    path++;
80101db4:	42                   	inc    %edx
  while(*path != '/' && *path != 0)
80101db5:	0f b6 02             	movzbl (%edx),%eax
80101db8:	3c 2f                	cmp    $0x2f,%al
80101dba:	75 f4                	jne    80101db0 <namex+0x70>
80101dbc:	89 d1                	mov    %edx,%ecx
80101dbe:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101dc0:	83 f9 0d             	cmp    $0xd,%ecx
80101dc3:	0f 8e 8b 00 00 00    	jle    80101e54 <namex+0x114>
    memmove(name, s, DIRSIZ);
80101dc9:	b8 0e 00 00 00       	mov    $0xe,%eax
80101dce:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101dd2:	89 44 24 08          	mov    %eax,0x8(%esp)
80101dd6:	89 3c 24             	mov    %edi,(%esp)
80101dd9:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101ddc:	e8 9f 3e 00 00       	call   80105c80 <memmove>
    path++;
80101de1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101de4:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101de6:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101de9:	75 0b                	jne    80101df6 <namex+0xb6>
80101deb:	90                   	nop
80101dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101df0:	43                   	inc    %ebx
  while(*path == '/')
80101df1:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101df4:	74 fa                	je     80101df0 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101df6:	89 34 24             	mov    %esi,(%esp)
80101df9:	e8 f2 f8 ff ff       	call   801016f0 <ilock>
    if(ip->type != T_DIR){
80101dfe:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101e03:	0f 85 8f 00 00 00    	jne    80101e98 <namex+0x158>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101e09:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e0c:	85 c0                	test   %eax,%eax
80101e0e:	74 09                	je     80101e19 <namex+0xd9>
80101e10:	80 3b 00             	cmpb   $0x0,(%ebx)
80101e13:	0f 84 b1 00 00 00    	je     80101eca <namex+0x18a>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101e19:	31 c9                	xor    %ecx,%ecx
80101e1b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101e1f:	89 7c 24 04          	mov    %edi,0x4(%esp)
80101e23:	89 34 24             	mov    %esi,(%esp)
80101e26:	e8 45 fe ff ff       	call   80101c70 <dirlookup>
80101e2b:	85 c0                	test   %eax,%eax
80101e2d:	74 69                	je     80101e98 <namex+0x158>
  iunlock(ip);
80101e2f:	89 34 24             	mov    %esi,(%esp)
80101e32:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101e35:	e8 96 f9 ff ff       	call   801017d0 <iunlock>
  iput(ip);
80101e3a:	89 34 24             	mov    %esi,(%esp)
80101e3d:	e8 de f9 ff ff       	call   80101820 <iput>
80101e42:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e45:	89 c6                	mov    %eax,%esi
80101e47:	e9 35 ff ff ff       	jmp    80101d81 <namex+0x41>
80101e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101e50:	89 da                	mov    %ebx,%edx
80101e52:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101e54:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101e58:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101e5c:	89 3c 24             	mov    %edi,(%esp)
80101e5f:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101e62:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101e65:	e8 16 3e 00 00       	call   80105c80 <memmove>
    name[len] = 0;
80101e6a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101e6d:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101e70:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101e74:	89 d3                	mov    %edx,%ebx
80101e76:	e9 6b ff ff ff       	jmp    80101de6 <namex+0xa6>
80101e7b:	90                   	nop
80101e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101e80:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101e83:	85 d2                	test   %edx,%edx
80101e85:	75 55                	jne    80101edc <namex+0x19c>
    iput(ip);
    return 0;
  }
  return ip;
}
80101e87:	83 c4 2c             	add    $0x2c,%esp
80101e8a:	89 f0                	mov    %esi,%eax
80101e8c:	5b                   	pop    %ebx
80101e8d:	5e                   	pop    %esi
80101e8e:	5f                   	pop    %edi
80101e8f:	5d                   	pop    %ebp
80101e90:	c3                   	ret    
80101e91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101e98:	89 34 24             	mov    %esi,(%esp)
80101e9b:	e8 30 f9 ff ff       	call   801017d0 <iunlock>
  iput(ip);
80101ea0:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101ea3:	31 f6                	xor    %esi,%esi
  iput(ip);
80101ea5:	e8 76 f9 ff ff       	call   80101820 <iput>
}
80101eaa:	83 c4 2c             	add    $0x2c,%esp
80101ead:	89 f0                	mov    %esi,%eax
80101eaf:	5b                   	pop    %ebx
80101eb0:	5e                   	pop    %esi
80101eb1:	5f                   	pop    %edi
80101eb2:	5d                   	pop    %ebp
80101eb3:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101eb4:	ba 01 00 00 00       	mov    $0x1,%edx
80101eb9:	b8 01 00 00 00       	mov    $0x1,%eax
80101ebe:	e8 7d f3 ff ff       	call   80101240 <iget>
80101ec3:	89 c6                	mov    %eax,%esi
80101ec5:	e9 b7 fe ff ff       	jmp    80101d81 <namex+0x41>
      iunlock(ip);
80101eca:	89 34 24             	mov    %esi,(%esp)
80101ecd:	e8 fe f8 ff ff       	call   801017d0 <iunlock>
}
80101ed2:	83 c4 2c             	add    $0x2c,%esp
80101ed5:	89 f0                	mov    %esi,%eax
80101ed7:	5b                   	pop    %ebx
80101ed8:	5e                   	pop    %esi
80101ed9:	5f                   	pop    %edi
80101eda:	5d                   	pop    %ebp
80101edb:	c3                   	ret    
    iput(ip);
80101edc:	89 34 24             	mov    %esi,(%esp)
    return 0;
80101edf:	31 f6                	xor    %esi,%esi
    iput(ip);
80101ee1:	e8 3a f9 ff ff       	call   80101820 <iput>
    return 0;
80101ee6:	eb 9f                	jmp    80101e87 <namex+0x147>
80101ee8:	90                   	nop
80101ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101ef0 <dirlink>:
{
80101ef0:	55                   	push   %ebp
80101ef1:	89 e5                	mov    %esp,%ebp
80101ef3:	57                   	push   %edi
80101ef4:	56                   	push   %esi
80101ef5:	53                   	push   %ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101ef6:	31 db                	xor    %ebx,%ebx
{
80101ef8:	83 ec 2c             	sub    $0x2c,%esp
80101efb:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((ip = dirlookup(dp, name, 0)) != 0){
80101efe:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f01:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101f05:	89 3c 24             	mov    %edi,(%esp)
80101f08:	89 44 24 04          	mov    %eax,0x4(%esp)
80101f0c:	e8 5f fd ff ff       	call   80101c70 <dirlookup>
80101f11:	85 c0                	test   %eax,%eax
80101f13:	0f 85 8e 00 00 00    	jne    80101fa7 <dirlink+0xb7>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101f19:	8b 5f 58             	mov    0x58(%edi),%ebx
80101f1c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f1f:	85 db                	test   %ebx,%ebx
80101f21:	74 3a                	je     80101f5d <dirlink+0x6d>
80101f23:	31 db                	xor    %ebx,%ebx
80101f25:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f28:	eb 0e                	jmp    80101f38 <dirlink+0x48>
80101f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101f30:	83 c3 10             	add    $0x10,%ebx
80101f33:	3b 5f 58             	cmp    0x58(%edi),%ebx
80101f36:	73 25                	jae    80101f5d <dirlink+0x6d>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f38:	b9 10 00 00 00       	mov    $0x10,%ecx
80101f3d:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80101f41:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101f45:	89 74 24 04          	mov    %esi,0x4(%esp)
80101f49:	89 3c 24             	mov    %edi,(%esp)
80101f4c:	e8 7f fa ff ff       	call   801019d0 <readi>
80101f51:	83 f8 10             	cmp    $0x10,%eax
80101f54:	75 60                	jne    80101fb6 <dirlink+0xc6>
    if(de.inum == 0)
80101f56:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101f5b:	75 d3                	jne    80101f30 <dirlink+0x40>
  strncpy(de.name, name, DIRSIZ);
80101f5d:	b8 0e 00 00 00       	mov    $0xe,%eax
80101f62:	89 44 24 08          	mov    %eax,0x8(%esp)
80101f66:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f69:	89 44 24 04          	mov    %eax,0x4(%esp)
80101f6d:	8d 45 da             	lea    -0x26(%ebp),%eax
80101f70:	89 04 24             	mov    %eax,(%esp)
80101f73:	e8 c8 3d 00 00       	call   80105d40 <strncpy>
  de.inum = inum;
80101f78:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f7b:	ba 10 00 00 00       	mov    $0x10,%edx
80101f80:	89 54 24 0c          	mov    %edx,0xc(%esp)
80101f84:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101f88:	89 74 24 04          	mov    %esi,0x4(%esp)
80101f8c:	89 3c 24             	mov    %edi,(%esp)
  de.inum = inum;
80101f8f:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f93:	e8 58 fb ff ff       	call   80101af0 <writei>
80101f98:	83 f8 10             	cmp    $0x10,%eax
80101f9b:	75 25                	jne    80101fc2 <dirlink+0xd2>
  return 0;
80101f9d:	31 c0                	xor    %eax,%eax
}
80101f9f:	83 c4 2c             	add    $0x2c,%esp
80101fa2:	5b                   	pop    %ebx
80101fa3:	5e                   	pop    %esi
80101fa4:	5f                   	pop    %edi
80101fa5:	5d                   	pop    %ebp
80101fa6:	c3                   	ret    
    iput(ip);
80101fa7:	89 04 24             	mov    %eax,(%esp)
80101faa:	e8 71 f8 ff ff       	call   80101820 <iput>
    return -1;
80101faf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101fb4:	eb e9                	jmp    80101f9f <dirlink+0xaf>
      panic("dirlink read");
80101fb6:	c7 04 24 e8 88 10 80 	movl   $0x801088e8,(%esp)
80101fbd:	e8 ae e3 ff ff       	call   80100370 <panic>
    panic("dirlink");
80101fc2:	c7 04 24 86 90 10 80 	movl   $0x80109086,(%esp)
80101fc9:	e8 a2 e3 ff ff       	call   80100370 <panic>
80101fce:	66 90                	xchg   %ax,%ax

80101fd0 <namei>:

struct inode*
namei(char *path)
{
80101fd0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101fd1:	31 d2                	xor    %edx,%edx
{
80101fd3:	89 e5                	mov    %esp,%ebp
80101fd5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101fd8:	8b 45 08             	mov    0x8(%ebp),%eax
80101fdb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101fde:	e8 5d fd ff ff       	call   80101d40 <namex>
}
80101fe3:	c9                   	leave  
80101fe4:	c3                   	ret    
80101fe5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ff0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101ff0:	55                   	push   %ebp
  return namex(path, 1, name);
80101ff1:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101ff6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101ff8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101ffb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101ffe:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101fff:	e9 3c fd ff ff       	jmp    80101d40 <namex>
80102004:	66 90                	xchg   %ax,%ax
80102006:	66 90                	xchg   %ax,%ax
80102008:	66 90                	xchg   %ax,%ax
8010200a:	66 90                	xchg   %ax,%ax
8010200c:	66 90                	xchg   %ax,%ax
8010200e:	66 90                	xchg   %ax,%ax

80102010 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102010:	55                   	push   %ebp
80102011:	89 e5                	mov    %esp,%ebp
80102013:	56                   	push   %esi
80102014:	53                   	push   %ebx
80102015:	83 ec 10             	sub    $0x10,%esp
  if(b == 0)
80102018:	85 c0                	test   %eax,%eax
8010201a:	0f 84 a8 00 00 00    	je     801020c8 <idestart+0xb8>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102020:	8b 48 08             	mov    0x8(%eax),%ecx
80102023:	89 c6                	mov    %eax,%esi
80102025:	81 f9 e7 03 00 00    	cmp    $0x3e7,%ecx
8010202b:	0f 87 8b 00 00 00    	ja     801020bc <idestart+0xac>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102031:	bb f7 01 00 00       	mov    $0x1f7,%ebx
80102036:	8d 76 00             	lea    0x0(%esi),%esi
80102039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102040:	89 da                	mov    %ebx,%edx
80102042:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102043:	24 c0                	and    $0xc0,%al
80102045:	3c 40                	cmp    $0x40,%al
80102047:	75 f7                	jne    80102040 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102049:	ba f6 03 00 00       	mov    $0x3f6,%edx
8010204e:	31 c0                	xor    %eax,%eax
80102050:	ee                   	out    %al,(%dx)
80102051:	b0 01                	mov    $0x1,%al
80102053:	ba f2 01 00 00       	mov    $0x1f2,%edx
80102058:	ee                   	out    %al,(%dx)
80102059:	ba f3 01 00 00       	mov    $0x1f3,%edx
8010205e:	88 c8                	mov    %cl,%al
80102060:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102061:	c1 f9 08             	sar    $0x8,%ecx
80102064:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102069:	89 c8                	mov    %ecx,%eax
8010206b:	ee                   	out    %al,(%dx)
8010206c:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102071:	31 c0                	xor    %eax,%eax
80102073:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102074:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80102078:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010207d:	c0 e0 04             	shl    $0x4,%al
80102080:	24 10                	and    $0x10,%al
80102082:	0c e0                	or     $0xe0,%al
80102084:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80102085:	f6 06 04             	testb  $0x4,(%esi)
80102088:	75 16                	jne    801020a0 <idestart+0x90>
8010208a:	b0 20                	mov    $0x20,%al
8010208c:	89 da                	mov    %ebx,%edx
8010208e:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010208f:	83 c4 10             	add    $0x10,%esp
80102092:	5b                   	pop    %ebx
80102093:	5e                   	pop    %esi
80102094:	5d                   	pop    %ebp
80102095:	c3                   	ret    
80102096:	8d 76 00             	lea    0x0(%esi),%esi
80102099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801020a0:	b0 30                	mov    $0x30,%al
801020a2:	89 da                	mov    %ebx,%edx
801020a4:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
801020a5:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
801020aa:	83 c6 5c             	add    $0x5c,%esi
801020ad:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020b2:	fc                   	cld    
801020b3:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
801020b5:	83 c4 10             	add    $0x10,%esp
801020b8:	5b                   	pop    %ebx
801020b9:	5e                   	pop    %esi
801020ba:	5d                   	pop    %ebp
801020bb:	c3                   	ret    
    panic("incorrect blockno");
801020bc:	c7 04 24 54 89 10 80 	movl   $0x80108954,(%esp)
801020c3:	e8 a8 e2 ff ff       	call   80100370 <panic>
    panic("idestart");
801020c8:	c7 04 24 4b 89 10 80 	movl   $0x8010894b,(%esp)
801020cf:	e8 9c e2 ff ff       	call   80100370 <panic>
801020d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801020da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801020e0 <ideinit>:
{
801020e0:	55                   	push   %ebp
  initlock(&idelock, "ide");
801020e1:	ba 66 89 10 80       	mov    $0x80108966,%edx
{
801020e6:	89 e5                	mov    %esp,%ebp
801020e8:	83 ec 18             	sub    $0x18,%esp
  initlock(&idelock, "ide");
801020eb:	89 54 24 04          	mov    %edx,0x4(%esp)
801020ef:	c7 04 24 80 c5 10 80 	movl   $0x8010c580,(%esp)
801020f6:	e8 85 38 00 00       	call   80105980 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801020fb:	a1 60 4d 11 80       	mov    0x80114d60,%eax
80102100:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102107:	48                   	dec    %eax
80102108:	89 44 24 04          	mov    %eax,0x4(%esp)
8010210c:	e8 8f 02 00 00       	call   801023a0 <ioapicenable>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102111:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102116:	8d 76 00             	lea    0x0(%esi),%esi
80102119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102120:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102121:	24 c0                	and    $0xc0,%al
80102123:	3c 40                	cmp    $0x40,%al
80102125:	75 f9                	jne    80102120 <ideinit+0x40>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102127:	b0 f0                	mov    $0xf0,%al
80102129:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010212e:	ee                   	out    %al,(%dx)
8010212f:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102134:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102139:	eb 08                	jmp    80102143 <ideinit+0x63>
8010213b:	90                   	nop
8010213c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i=0; i<1000; i++){
80102140:	49                   	dec    %ecx
80102141:	74 0f                	je     80102152 <ideinit+0x72>
80102143:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102144:	84 c0                	test   %al,%al
80102146:	74 f8                	je     80102140 <ideinit+0x60>
      havedisk1 = 1;
80102148:	b8 01 00 00 00       	mov    $0x1,%eax
8010214d:	a3 60 c5 10 80       	mov    %eax,0x8010c560
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102152:	b0 e0                	mov    $0xe0,%al
80102154:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102159:	ee                   	out    %al,(%dx)
}
8010215a:	c9                   	leave  
8010215b:	c3                   	ret    
8010215c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102160 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102160:	55                   	push   %ebp
80102161:	89 e5                	mov    %esp,%ebp
80102163:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102166:	c7 04 24 80 c5 10 80 	movl   $0x8010c580,(%esp)
{
8010216d:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80102170:	89 75 f8             	mov    %esi,-0x8(%ebp)
80102173:	89 7d fc             	mov    %edi,-0x4(%ebp)
  acquire(&idelock);
80102176:	e8 55 39 00 00       	call   80105ad0 <acquire>

  if((b = idequeue) == 0){
8010217b:	8b 1d 64 c5 10 80    	mov    0x8010c564,%ebx
80102181:	85 db                	test   %ebx,%ebx
80102183:	74 5c                	je     801021e1 <ideintr+0x81>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102185:	8b 43 58             	mov    0x58(%ebx),%eax
80102188:	a3 64 c5 10 80       	mov    %eax,0x8010c564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
8010218d:	8b 0b                	mov    (%ebx),%ecx
8010218f:	f6 c1 04             	test   $0x4,%cl
80102192:	75 2f                	jne    801021c3 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102194:	be f7 01 00 00       	mov    $0x1f7,%esi
80102199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021a0:	89 f2                	mov    %esi,%edx
801021a2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021a3:	88 c2                	mov    %al,%dl
801021a5:	80 e2 c0             	and    $0xc0,%dl
801021a8:	80 fa 40             	cmp    $0x40,%dl
801021ab:	75 f3                	jne    801021a0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801021ad:	a8 21                	test   $0x21,%al
801021af:	75 12                	jne    801021c3 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
801021b1:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801021b4:	b9 80 00 00 00       	mov    $0x80,%ecx
801021b9:	ba f0 01 00 00       	mov    $0x1f0,%edx
801021be:	fc                   	cld    
801021bf:	f3 6d                	rep insl (%dx),%es:(%edi)
801021c1:	8b 0b                	mov    (%ebx),%ecx

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801021c3:	83 e1 fb             	and    $0xfffffffb,%ecx
801021c6:	83 c9 02             	or     $0x2,%ecx
801021c9:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
801021cb:	89 1c 24             	mov    %ebx,(%esp)
801021ce:	e8 bd 23 00 00       	call   80104590 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801021d3:	a1 64 c5 10 80       	mov    0x8010c564,%eax
801021d8:	85 c0                	test   %eax,%eax
801021da:	74 05                	je     801021e1 <ideintr+0x81>
    idestart(idequeue);
801021dc:	e8 2f fe ff ff       	call   80102010 <idestart>
    release(&idelock);
801021e1:	c7 04 24 80 c5 10 80 	movl   $0x8010c580,(%esp)
801021e8:	e8 83 39 00 00       	call   80105b70 <release>

  release(&idelock);
}
801021ed:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801021f0:	8b 75 f8             	mov    -0x8(%ebp),%esi
801021f3:	8b 7d fc             	mov    -0x4(%ebp),%edi
801021f6:	89 ec                	mov    %ebp,%esp
801021f8:	5d                   	pop    %ebp
801021f9:	c3                   	ret    
801021fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102200 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102200:	55                   	push   %ebp
80102201:	89 e5                	mov    %esp,%ebp
80102203:	53                   	push   %ebx
80102204:	83 ec 14             	sub    $0x14,%esp
80102207:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010220a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010220d:	89 04 24             	mov    %eax,(%esp)
80102210:	e8 1b 37 00 00       	call   80105930 <holdingsleep>
80102215:	85 c0                	test   %eax,%eax
80102217:	0f 84 b6 00 00 00    	je     801022d3 <iderw+0xd3>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010221d:	8b 03                	mov    (%ebx),%eax
8010221f:	83 e0 06             	and    $0x6,%eax
80102222:	83 f8 02             	cmp    $0x2,%eax
80102225:	0f 84 9c 00 00 00    	je     801022c7 <iderw+0xc7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010222b:	8b 4b 04             	mov    0x4(%ebx),%ecx
8010222e:	85 c9                	test   %ecx,%ecx
80102230:	74 0e                	je     80102240 <iderw+0x40>
80102232:	8b 15 60 c5 10 80    	mov    0x8010c560,%edx
80102238:	85 d2                	test   %edx,%edx
8010223a:	0f 84 9f 00 00 00    	je     801022df <iderw+0xdf>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102240:	c7 04 24 80 c5 10 80 	movl   $0x8010c580,(%esp)
80102247:	e8 84 38 00 00       	call   80105ad0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010224c:	8b 15 64 c5 10 80    	mov    0x8010c564,%edx
  b->qnext = 0;
80102252:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102259:	85 d2                	test   %edx,%edx
8010225b:	75 05                	jne    80102262 <iderw+0x62>
8010225d:	eb 61                	jmp    801022c0 <iderw+0xc0>
8010225f:	90                   	nop
80102260:	89 c2                	mov    %eax,%edx
80102262:	8b 42 58             	mov    0x58(%edx),%eax
80102265:	85 c0                	test   %eax,%eax
80102267:	75 f7                	jne    80102260 <iderw+0x60>
80102269:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010226c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010226e:	39 1d 64 c5 10 80    	cmp    %ebx,0x8010c564
80102274:	75 1b                	jne    80102291 <iderw+0x91>
80102276:	eb 38                	jmp    801022b0 <iderw+0xb0>
80102278:	90                   	nop
80102279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
80102280:	b8 80 c5 10 80       	mov    $0x8010c580,%eax
80102285:	89 44 24 04          	mov    %eax,0x4(%esp)
80102289:	89 1c 24             	mov    %ebx,(%esp)
8010228c:	e8 ff 20 00 00       	call   80104390 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102291:	8b 03                	mov    (%ebx),%eax
80102293:	83 e0 06             	and    $0x6,%eax
80102296:	83 f8 02             	cmp    $0x2,%eax
80102299:	75 e5                	jne    80102280 <iderw+0x80>
  }


  release(&idelock);
8010229b:	c7 45 08 80 c5 10 80 	movl   $0x8010c580,0x8(%ebp)
}
801022a2:	83 c4 14             	add    $0x14,%esp
801022a5:	5b                   	pop    %ebx
801022a6:	5d                   	pop    %ebp
  release(&idelock);
801022a7:	e9 c4 38 00 00       	jmp    80105b70 <release>
801022ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
801022b0:	89 d8                	mov    %ebx,%eax
801022b2:	e8 59 fd ff ff       	call   80102010 <idestart>
801022b7:	eb d8                	jmp    80102291 <iderw+0x91>
801022b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022c0:	ba 64 c5 10 80       	mov    $0x8010c564,%edx
801022c5:	eb a5                	jmp    8010226c <iderw+0x6c>
    panic("iderw: nothing to do");
801022c7:	c7 04 24 80 89 10 80 	movl   $0x80108980,(%esp)
801022ce:	e8 9d e0 ff ff       	call   80100370 <panic>
    panic("iderw: buf not locked");
801022d3:	c7 04 24 6a 89 10 80 	movl   $0x8010896a,(%esp)
801022da:	e8 91 e0 ff ff       	call   80100370 <panic>
    panic("iderw: ide disk 1 not present");
801022df:	c7 04 24 95 89 10 80 	movl   $0x80108995,(%esp)
801022e6:	e8 85 e0 ff ff       	call   80100370 <panic>
801022eb:	66 90                	xchg   %ax,%ax
801022ed:	66 90                	xchg   %ax,%ax
801022ef:	90                   	nop

801022f0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801022f0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801022f1:	b8 00 00 c0 fe       	mov    $0xfec00000,%eax
{
801022f6:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
801022f8:	ba 01 00 00 00       	mov    $0x1,%edx
{
801022fd:	56                   	push   %esi
801022fe:	53                   	push   %ebx
801022ff:	83 ec 10             	sub    $0x10,%esp
  ioapic = (volatile struct ioapic*)IOAPIC;
80102302:	a3 94 46 11 80       	mov    %eax,0x80114694
  ioapic->reg = reg;
80102307:	89 15 00 00 c0 fe    	mov    %edx,0xfec00000
  return ioapic->data;
8010230d:	a1 94 46 11 80       	mov    0x80114694,%eax
80102312:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102315:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
8010231b:	8b 0d 94 46 11 80    	mov    0x80114694,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102321:	0f b6 15 c0 47 11 80 	movzbl 0x801147c0,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102328:	c1 eb 10             	shr    $0x10,%ebx
8010232b:	0f b6 db             	movzbl %bl,%ebx
  return ioapic->data;
8010232e:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
80102331:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102334:	39 c2                	cmp    %eax,%edx
80102336:	74 12                	je     8010234a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102338:	c7 04 24 b4 89 10 80 	movl   $0x801089b4,(%esp)
8010233f:	e8 0c e3 ff ff       	call   80100650 <cprintf>
80102344:	8b 0d 94 46 11 80    	mov    0x80114694,%ecx
8010234a:	83 c3 21             	add    $0x21,%ebx
{
8010234d:	ba 10 00 00 00       	mov    $0x10,%edx
80102352:	b8 20 00 00 00       	mov    $0x20,%eax
80102357:	89 f6                	mov    %esi,%esi
80102359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
80102360:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102362:	89 c6                	mov    %eax,%esi
80102364:	40                   	inc    %eax
  ioapic->data = data;
80102365:	8b 0d 94 46 11 80    	mov    0x80114694,%ecx
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010236b:	81 ce 00 00 01 00    	or     $0x10000,%esi
  ioapic->data = data;
80102371:	89 71 10             	mov    %esi,0x10(%ecx)
80102374:	8d 72 01             	lea    0x1(%edx),%esi
80102377:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
8010237a:	89 31                	mov    %esi,(%ecx)
  for(i = 0; i <= maxintr; i++){
8010237c:	39 d8                	cmp    %ebx,%eax
  ioapic->data = data;
8010237e:	8b 0d 94 46 11 80    	mov    0x80114694,%ecx
80102384:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010238b:	75 d3                	jne    80102360 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010238d:	83 c4 10             	add    $0x10,%esp
80102390:	5b                   	pop    %ebx
80102391:	5e                   	pop    %esi
80102392:	5d                   	pop    %ebp
80102393:	c3                   	ret    
80102394:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010239a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801023a0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801023a0:	55                   	push   %ebp
  ioapic->reg = reg;
801023a1:	8b 0d 94 46 11 80    	mov    0x80114694,%ecx
{
801023a7:	89 e5                	mov    %esp,%ebp
801023a9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801023ac:	8d 50 20             	lea    0x20(%eax),%edx
801023af:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801023b3:	89 01                	mov    %eax,(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023b5:	40                   	inc    %eax
  ioapic->data = data;
801023b6:	8b 0d 94 46 11 80    	mov    0x80114694,%ecx
801023bc:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801023c2:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801023c4:	a1 94 46 11 80       	mov    0x80114694,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023c9:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801023cc:	89 50 10             	mov    %edx,0x10(%eax)
}
801023cf:	5d                   	pop    %ebp
801023d0:	c3                   	ret    
801023d1:	66 90                	xchg   %ax,%ax
801023d3:	66 90                	xchg   %ax,%ax
801023d5:	66 90                	xchg   %ax,%ax
801023d7:	66 90                	xchg   %ax,%ax
801023d9:	66 90                	xchg   %ax,%ax
801023db:	66 90                	xchg   %ax,%ax
801023dd:	66 90                	xchg   %ax,%ax
801023df:	90                   	nop

801023e0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801023e0:	55                   	push   %ebp
801023e1:	89 e5                	mov    %esp,%ebp
801023e3:	53                   	push   %ebx
801023e4:	83 ec 14             	sub    $0x14,%esp
801023e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801023ea:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801023f0:	0f 85 80 00 00 00    	jne    80102476 <kfree+0x96>
801023f6:	81 fb 08 80 11 80    	cmp    $0x80118008,%ebx
801023fc:	72 78                	jb     80102476 <kfree+0x96>
801023fe:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102404:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102409:	77 6b                	ja     80102476 <kfree+0x96>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
8010240b:	ba 00 10 00 00       	mov    $0x1000,%edx
80102410:	b9 01 00 00 00       	mov    $0x1,%ecx
80102415:	89 54 24 08          	mov    %edx,0x8(%esp)
80102419:	89 4c 24 04          	mov    %ecx,0x4(%esp)
8010241d:	89 1c 24             	mov    %ebx,(%esp)
80102420:	e8 9b 37 00 00       	call   80105bc0 <memset>

  if(kmem.use_lock)
80102425:	a1 d4 46 11 80       	mov    0x801146d4,%eax
8010242a:	85 c0                	test   %eax,%eax
8010242c:	75 3a                	jne    80102468 <kfree+0x88>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
8010242e:	a1 d8 46 11 80       	mov    0x801146d8,%eax
80102433:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
80102435:	a1 d4 46 11 80       	mov    0x801146d4,%eax
  kmem.freelist = r;
8010243a:	89 1d d8 46 11 80    	mov    %ebx,0x801146d8
  if(kmem.use_lock)
80102440:	85 c0                	test   %eax,%eax
80102442:	75 0c                	jne    80102450 <kfree+0x70>
    release(&kmem.lock);
}
80102444:	83 c4 14             	add    $0x14,%esp
80102447:	5b                   	pop    %ebx
80102448:	5d                   	pop    %ebp
80102449:	c3                   	ret    
8010244a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102450:	c7 45 08 a0 46 11 80 	movl   $0x801146a0,0x8(%ebp)
}
80102457:	83 c4 14             	add    $0x14,%esp
8010245a:	5b                   	pop    %ebx
8010245b:	5d                   	pop    %ebp
    release(&kmem.lock);
8010245c:	e9 0f 37 00 00       	jmp    80105b70 <release>
80102461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&kmem.lock);
80102468:	c7 04 24 a0 46 11 80 	movl   $0x801146a0,(%esp)
8010246f:	e8 5c 36 00 00       	call   80105ad0 <acquire>
80102474:	eb b8                	jmp    8010242e <kfree+0x4e>
    panic("kfree");
80102476:	c7 04 24 e6 89 10 80 	movl   $0x801089e6,(%esp)
8010247d:	e8 ee de ff ff       	call   80100370 <panic>
80102482:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102490 <freerange>:
{
80102490:	55                   	push   %ebp
80102491:	89 e5                	mov    %esp,%ebp
80102493:	56                   	push   %esi
80102494:	53                   	push   %ebx
80102495:	83 ec 10             	sub    $0x10,%esp
  p = (char*)PGROUNDUP((uint)vstart);
80102498:	8b 45 08             	mov    0x8(%ebp),%eax
{
8010249b:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010249e:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801024a4:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024aa:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801024b0:	39 de                	cmp    %ebx,%esi
801024b2:	72 24                	jb     801024d8 <freerange+0x48>
801024b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801024ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    kfree(p);
801024c0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024c6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024cc:	89 04 24             	mov    %eax,(%esp)
801024cf:	e8 0c ff ff ff       	call   801023e0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024d4:	39 f3                	cmp    %esi,%ebx
801024d6:	76 e8                	jbe    801024c0 <freerange+0x30>
}
801024d8:	83 c4 10             	add    $0x10,%esp
801024db:	5b                   	pop    %ebx
801024dc:	5e                   	pop    %esi
801024dd:	5d                   	pop    %ebp
801024de:	c3                   	ret    
801024df:	90                   	nop

801024e0 <kinit1>:
{
801024e0:	55                   	push   %ebp
  initlock(&kmem.lock, "kmem");
801024e1:	b8 ec 89 10 80       	mov    $0x801089ec,%eax
{
801024e6:	89 e5                	mov    %esp,%ebp
801024e8:	56                   	push   %esi
801024e9:	53                   	push   %ebx
801024ea:	83 ec 10             	sub    $0x10,%esp
  initlock(&kmem.lock, "kmem");
801024ed:	89 44 24 04          	mov    %eax,0x4(%esp)
{
801024f1:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801024f4:	c7 04 24 a0 46 11 80 	movl   $0x801146a0,(%esp)
801024fb:	e8 80 34 00 00       	call   80105980 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
80102500:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 0;
80102503:	31 d2                	xor    %edx,%edx
80102505:	89 15 d4 46 11 80    	mov    %edx,0x801146d4
  p = (char*)PGROUNDUP((uint)vstart);
8010250b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102511:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102517:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010251d:	39 de                	cmp    %ebx,%esi
8010251f:	72 27                	jb     80102548 <kinit1+0x68>
80102521:	eb 0d                	jmp    80102530 <kinit1+0x50>
80102523:	90                   	nop
80102524:	90                   	nop
80102525:	90                   	nop
80102526:	90                   	nop
80102527:	90                   	nop
80102528:	90                   	nop
80102529:	90                   	nop
8010252a:	90                   	nop
8010252b:	90                   	nop
8010252c:	90                   	nop
8010252d:	90                   	nop
8010252e:	90                   	nop
8010252f:	90                   	nop
    kfree(p);
80102530:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102536:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010253c:	89 04 24             	mov    %eax,(%esp)
8010253f:	e8 9c fe ff ff       	call   801023e0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102544:	39 de                	cmp    %ebx,%esi
80102546:	73 e8                	jae    80102530 <kinit1+0x50>
}
80102548:	83 c4 10             	add    $0x10,%esp
8010254b:	5b                   	pop    %ebx
8010254c:	5e                   	pop    %esi
8010254d:	5d                   	pop    %ebp
8010254e:	c3                   	ret    
8010254f:	90                   	nop

80102550 <kinit2>:
{
80102550:	55                   	push   %ebp
80102551:	89 e5                	mov    %esp,%ebp
80102553:	56                   	push   %esi
80102554:	53                   	push   %ebx
80102555:	83 ec 10             	sub    $0x10,%esp
  p = (char*)PGROUNDUP((uint)vstart);
80102558:	8b 45 08             	mov    0x8(%ebp),%eax
{
8010255b:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010255e:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102564:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010256a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102570:	39 de                	cmp    %ebx,%esi
80102572:	72 24                	jb     80102598 <kinit2+0x48>
80102574:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010257a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    kfree(p);
80102580:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102586:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010258c:	89 04 24             	mov    %eax,(%esp)
8010258f:	e8 4c fe ff ff       	call   801023e0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102594:	39 de                	cmp    %ebx,%esi
80102596:	73 e8                	jae    80102580 <kinit2+0x30>
  kmem.use_lock = 1;
80102598:	b8 01 00 00 00       	mov    $0x1,%eax
8010259d:	a3 d4 46 11 80       	mov    %eax,0x801146d4
}
801025a2:	83 c4 10             	add    $0x10,%esp
801025a5:	5b                   	pop    %ebx
801025a6:	5e                   	pop    %esi
801025a7:	5d                   	pop    %ebp
801025a8:	c3                   	ret    
801025a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801025b0 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
801025b0:	a1 d4 46 11 80       	mov    0x801146d4,%eax
801025b5:	85 c0                	test   %eax,%eax
801025b7:	75 1f                	jne    801025d8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801025b9:	a1 d8 46 11 80       	mov    0x801146d8,%eax
  if(r)
801025be:	85 c0                	test   %eax,%eax
801025c0:	74 0e                	je     801025d0 <kalloc+0x20>
    kmem.freelist = r->next;
801025c2:	8b 10                	mov    (%eax),%edx
801025c4:	89 15 d8 46 11 80    	mov    %edx,0x801146d8
801025ca:	c3                   	ret    
801025cb:	90                   	nop
801025cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
801025d0:	c3                   	ret    
801025d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
801025d8:	55                   	push   %ebp
801025d9:	89 e5                	mov    %esp,%ebp
801025db:	83 ec 28             	sub    $0x28,%esp
    acquire(&kmem.lock);
801025de:	c7 04 24 a0 46 11 80 	movl   $0x801146a0,(%esp)
801025e5:	e8 e6 34 00 00       	call   80105ad0 <acquire>
  r = kmem.freelist;
801025ea:	a1 d8 46 11 80       	mov    0x801146d8,%eax
801025ef:	8b 15 d4 46 11 80    	mov    0x801146d4,%edx
  if(r)
801025f5:	85 c0                	test   %eax,%eax
801025f7:	74 08                	je     80102601 <kalloc+0x51>
    kmem.freelist = r->next;
801025f9:	8b 08                	mov    (%eax),%ecx
801025fb:	89 0d d8 46 11 80    	mov    %ecx,0x801146d8
  if(kmem.use_lock)
80102601:	85 d2                	test   %edx,%edx
80102603:	74 12                	je     80102617 <kalloc+0x67>
    release(&kmem.lock);
80102605:	c7 04 24 a0 46 11 80 	movl   $0x801146a0,(%esp)
8010260c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010260f:	e8 5c 35 00 00       	call   80105b70 <release>
  return (char*)r;
80102614:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102617:	c9                   	leave  
80102618:	c3                   	ret    
80102619:	66 90                	xchg   %ax,%ax
8010261b:	66 90                	xchg   %ax,%ax
8010261d:	66 90                	xchg   %ax,%ax
8010261f:	90                   	nop

80102620 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102620:	ba 64 00 00 00       	mov    $0x64,%edx
80102625:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102626:	24 01                	and    $0x1,%al
80102628:	84 c0                	test   %al,%al
8010262a:	0f 84 d0 00 00 00    	je     80102700 <kbdgetc+0xe0>
{
80102630:	55                   	push   %ebp
80102631:	ba 60 00 00 00       	mov    $0x60,%edx
80102636:	89 e5                	mov    %esp,%ebp
80102638:	53                   	push   %ebx
80102639:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
8010263a:	0f b6 d0             	movzbl %al,%edx
8010263d:	8b 1d b4 c5 10 80    	mov    0x8010c5b4,%ebx

  if(data == 0xE0){
80102643:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102649:	0f 84 89 00 00 00    	je     801026d8 <kbdgetc+0xb8>
8010264f:	89 d9                	mov    %ebx,%ecx
80102651:	83 e1 40             	and    $0x40,%ecx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102654:	84 c0                	test   %al,%al
80102656:	78 58                	js     801026b0 <kbdgetc+0x90>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102658:	85 c9                	test   %ecx,%ecx
8010265a:	74 08                	je     80102664 <kbdgetc+0x44>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010265c:	0c 80                	or     $0x80,%al
    shift &= ~E0ESC;
8010265e:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102661:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102664:	0f b6 8a 20 8b 10 80 	movzbl -0x7fef74e0(%edx),%ecx
  shift ^= togglecode[data];
8010266b:	0f b6 82 20 8a 10 80 	movzbl -0x7fef75e0(%edx),%eax
  shift |= shiftcode[data];
80102672:	09 d9                	or     %ebx,%ecx
  shift ^= togglecode[data];
80102674:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102676:	89 c8                	mov    %ecx,%eax
80102678:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010267b:	f6 c1 08             	test   $0x8,%cl
  c = charcode[shift & (CTL | SHIFT)][data];
8010267e:	8b 04 85 00 8a 10 80 	mov    -0x7fef7600(,%eax,4),%eax
  shift ^= togglecode[data];
80102685:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
  c = charcode[shift & (CTL | SHIFT)][data];
8010268b:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010268f:	74 40                	je     801026d1 <kbdgetc+0xb1>
    if('a' <= c && c <= 'z')
80102691:	8d 50 9f             	lea    -0x61(%eax),%edx
80102694:	83 fa 19             	cmp    $0x19,%edx
80102697:	76 57                	jbe    801026f0 <kbdgetc+0xd0>
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
80102699:	8d 50 bf             	lea    -0x41(%eax),%edx
8010269c:	83 fa 19             	cmp    $0x19,%edx
8010269f:	77 30                	ja     801026d1 <kbdgetc+0xb1>
      c += 'a' - 'A';
801026a1:	83 c0 20             	add    $0x20,%eax
  }
  return c;
801026a4:	eb 2b                	jmp    801026d1 <kbdgetc+0xb1>
801026a6:	8d 76 00             	lea    0x0(%esi),%esi
801026a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    data = (shift & E0ESC ? data : data & 0x7F);
801026b0:	85 c9                	test   %ecx,%ecx
801026b2:	75 05                	jne    801026b9 <kbdgetc+0x99>
801026b4:	24 7f                	and    $0x7f,%al
801026b6:	0f b6 d0             	movzbl %al,%edx
    shift &= ~(shiftcode[data] | E0ESC);
801026b9:	0f b6 82 20 8b 10 80 	movzbl -0x7fef74e0(%edx),%eax
801026c0:	0c 40                	or     $0x40,%al
801026c2:	0f b6 c8             	movzbl %al,%ecx
    return 0;
801026c5:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801026c7:	f7 d1                	not    %ecx
801026c9:	21 d9                	and    %ebx,%ecx
801026cb:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
}
801026d1:	5b                   	pop    %ebx
801026d2:	5d                   	pop    %ebp
801026d3:	c3                   	ret    
801026d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801026d8:	83 cb 40             	or     $0x40,%ebx
    return 0;
801026db:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801026dd:	89 1d b4 c5 10 80    	mov    %ebx,0x8010c5b4
}
801026e3:	5b                   	pop    %ebx
801026e4:	5d                   	pop    %ebp
801026e5:	c3                   	ret    
801026e6:	8d 76 00             	lea    0x0(%esi),%esi
801026e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801026f0:	5b                   	pop    %ebx
      c += 'A' - 'a';
801026f1:	83 e8 20             	sub    $0x20,%eax
}
801026f4:	5d                   	pop    %ebp
801026f5:	c3                   	ret    
801026f6:	8d 76 00             	lea    0x0(%esi),%esi
801026f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102700:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102705:	c3                   	ret    
80102706:	8d 76 00             	lea    0x0(%esi),%esi
80102709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102710 <kbdintr>:

void
kbdintr(void)
{
80102710:	55                   	push   %ebp
80102711:	89 e5                	mov    %esp,%ebp
80102713:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
80102716:	c7 04 24 20 26 10 80 	movl   $0x80102620,(%esp)
8010271d:	e8 ae e0 ff ff       	call   801007d0 <consoleintr>
}
80102722:	c9                   	leave  
80102723:	c3                   	ret    
80102724:	66 90                	xchg   %ax,%ax
80102726:	66 90                	xchg   %ax,%ax
80102728:	66 90                	xchg   %ax,%ax
8010272a:	66 90                	xchg   %ax,%ax
8010272c:	66 90                	xchg   %ax,%ax
8010272e:	66 90                	xchg   %ax,%ax

80102730 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102730:	a1 dc 46 11 80       	mov    0x801146dc,%eax
{
80102735:	55                   	push   %ebp
80102736:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102738:	85 c0                	test   %eax,%eax
8010273a:	0f 84 c6 00 00 00    	je     80102806 <lapicinit+0xd6>
  lapic[index] = value;
80102740:	ba 3f 01 00 00       	mov    $0x13f,%edx
80102745:	b9 0b 00 00 00       	mov    $0xb,%ecx
8010274a:	89 90 f0 00 00 00    	mov    %edx,0xf0(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102750:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102753:	89 88 e0 03 00 00    	mov    %ecx,0x3e0(%eax)
80102759:	b9 80 96 98 00       	mov    $0x989680,%ecx
  lapic[ID];  // wait for write to finish, by reading
8010275e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102761:	ba 20 00 02 00       	mov    $0x20020,%edx
80102766:	89 90 20 03 00 00    	mov    %edx,0x320(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010276c:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010276f:	89 88 80 03 00 00    	mov    %ecx,0x380(%eax)
80102775:	b9 00 00 01 00       	mov    $0x10000,%ecx
  lapic[ID];  // wait for write to finish, by reading
8010277a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010277d:	ba 00 00 01 00       	mov    $0x10000,%edx
80102782:	89 90 50 03 00 00    	mov    %edx,0x350(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102788:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010278b:	89 88 60 03 00 00    	mov    %ecx,0x360(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102791:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102794:	8b 50 30             	mov    0x30(%eax),%edx
80102797:	c1 ea 10             	shr    $0x10,%edx
8010279a:	80 fa 03             	cmp    $0x3,%dl
8010279d:	77 71                	ja     80102810 <lapicinit+0xe0>
  lapic[index] = value;
8010279f:	b9 33 00 00 00       	mov    $0x33,%ecx
801027a4:	89 88 70 03 00 00    	mov    %ecx,0x370(%eax)
801027aa:	31 c9                	xor    %ecx,%ecx
  lapic[ID];  // wait for write to finish, by reading
801027ac:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027af:	31 d2                	xor    %edx,%edx
801027b1:	89 90 80 02 00 00    	mov    %edx,0x280(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027b7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027ba:	89 88 80 02 00 00    	mov    %ecx,0x280(%eax)
801027c0:	31 c9                	xor    %ecx,%ecx
  lapic[ID];  // wait for write to finish, by reading
801027c2:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027c5:	31 d2                	xor    %edx,%edx
801027c7:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027cd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027d0:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027d6:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027d9:	ba 00 85 08 00       	mov    $0x88500,%edx
801027de:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027e4:	8b 50 20             	mov    0x20(%eax),%edx
801027e7:	89 f6                	mov    %esi,%esi
801027e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801027f0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801027f6:	f6 c6 10             	test   $0x10,%dh
801027f9:	75 f5                	jne    801027f0 <lapicinit+0xc0>
  lapic[index] = value;
801027fb:	31 d2                	xor    %edx,%edx
801027fd:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102803:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102806:	5d                   	pop    %ebp
80102807:	c3                   	ret    
80102808:	90                   	nop
80102809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102810:	b9 00 00 01 00       	mov    $0x10000,%ecx
80102815:	89 88 40 03 00 00    	mov    %ecx,0x340(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010281b:	8b 50 20             	mov    0x20(%eax),%edx
8010281e:	e9 7c ff ff ff       	jmp    8010279f <lapicinit+0x6f>
80102823:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102830 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102830:	a1 dc 46 11 80       	mov    0x801146dc,%eax
{
80102835:	55                   	push   %ebp
80102836:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102838:	85 c0                	test   %eax,%eax
8010283a:	74 0c                	je     80102848 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
8010283c:	8b 40 20             	mov    0x20(%eax),%eax
}
8010283f:	5d                   	pop    %ebp
  return lapic[ID] >> 24;
80102840:	c1 e8 18             	shr    $0x18,%eax
}
80102843:	c3                   	ret    
80102844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80102848:	31 c0                	xor    %eax,%eax
}
8010284a:	5d                   	pop    %ebp
8010284b:	c3                   	ret    
8010284c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102850 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102850:	a1 dc 46 11 80       	mov    0x801146dc,%eax
{
80102855:	55                   	push   %ebp
80102856:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102858:	85 c0                	test   %eax,%eax
8010285a:	74 0b                	je     80102867 <lapiceoi+0x17>
  lapic[index] = value;
8010285c:	31 d2                	xor    %edx,%edx
8010285e:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102864:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102867:	5d                   	pop    %ebp
80102868:	c3                   	ret    
80102869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102870 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102870:	55                   	push   %ebp
80102871:	89 e5                	mov    %esp,%ebp
}
80102873:	5d                   	pop    %ebp
80102874:	c3                   	ret    
80102875:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102880 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102880:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102881:	b0 0f                	mov    $0xf,%al
80102883:	89 e5                	mov    %esp,%ebp
80102885:	ba 70 00 00 00       	mov    $0x70,%edx
8010288a:	53                   	push   %ebx
8010288b:	0f b6 4d 08          	movzbl 0x8(%ebp),%ecx
8010288f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80102892:	ee                   	out    %al,(%dx)
80102893:	b0 0a                	mov    $0xa,%al
80102895:	ba 71 00 00 00       	mov    $0x71,%edx
8010289a:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
8010289b:	31 c0                	xor    %eax,%eax
8010289d:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801028a3:	89 d8                	mov    %ebx,%eax
801028a5:	c1 e8 04             	shr    $0x4,%eax
801028a8:	66 a3 69 04 00 80    	mov    %ax,0x80000469

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801028ae:	c1 e1 18             	shl    $0x18,%ecx
  lapic[index] = value;
801028b1:	a1 dc 46 11 80       	mov    0x801146dc,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801028b6:	c1 eb 0c             	shr    $0xc,%ebx
801028b9:	81 cb 00 06 00 00    	or     $0x600,%ebx
  lapic[index] = value;
801028bf:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028c5:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028c8:	ba 00 c5 00 00       	mov    $0xc500,%edx
801028cd:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028d3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028d6:	ba 00 85 00 00       	mov    $0x8500,%edx
801028db:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028e1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028e4:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028ea:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028ed:	89 98 00 03 00 00    	mov    %ebx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028f3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028f6:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028fc:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028ff:	89 98 00 03 00 00    	mov    %ebx,0x300(%eax)
    microdelay(200);
  }
}
80102905:	5b                   	pop    %ebx
  lapic[ID];  // wait for write to finish, by reading
80102906:	8b 40 20             	mov    0x20(%eax),%eax
}
80102909:	5d                   	pop    %ebp
8010290a:	c3                   	ret    
8010290b:	90                   	nop
8010290c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102910 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102910:	55                   	push   %ebp
80102911:	b0 0b                	mov    $0xb,%al
80102913:	89 e5                	mov    %esp,%ebp
80102915:	ba 70 00 00 00       	mov    $0x70,%edx
8010291a:	57                   	push   %edi
8010291b:	56                   	push   %esi
8010291c:	53                   	push   %ebx
8010291d:	83 ec 5c             	sub    $0x5c,%esp
80102920:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102921:	ba 71 00 00 00       	mov    $0x71,%edx
80102926:	ec                   	in     (%dx),%al
80102927:	24 04                	and    $0x4,%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102929:	be 70 00 00 00       	mov    $0x70,%esi
8010292e:	88 45 b2             	mov    %al,-0x4e(%ebp)
80102931:	8d 7d d0             	lea    -0x30(%ebp),%edi
80102934:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010293a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
80102940:	31 c0                	xor    %eax,%eax
80102942:	89 f2                	mov    %esi,%edx
80102944:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102945:	bb 71 00 00 00       	mov    $0x71,%ebx
8010294a:	89 da                	mov    %ebx,%edx
8010294c:	ec                   	in     (%dx),%al
8010294d:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102950:	89 f2                	mov    %esi,%edx
80102952:	b0 02                	mov    $0x2,%al
80102954:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102955:	89 da                	mov    %ebx,%edx
80102957:	ec                   	in     (%dx),%al
80102958:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010295b:	89 f2                	mov    %esi,%edx
8010295d:	b0 04                	mov    $0x4,%al
8010295f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102960:	89 da                	mov    %ebx,%edx
80102962:	ec                   	in     (%dx),%al
80102963:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102966:	89 f2                	mov    %esi,%edx
80102968:	b0 07                	mov    $0x7,%al
8010296a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010296b:	89 da                	mov    %ebx,%edx
8010296d:	ec                   	in     (%dx),%al
8010296e:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102971:	89 f2                	mov    %esi,%edx
80102973:	b0 08                	mov    $0x8,%al
80102975:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102976:	89 da                	mov    %ebx,%edx
80102978:	ec                   	in     (%dx),%al
80102979:	88 45 b3             	mov    %al,-0x4d(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010297c:	89 f2                	mov    %esi,%edx
8010297e:	b0 09                	mov    $0x9,%al
80102980:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102981:	89 da                	mov    %ebx,%edx
80102983:	ec                   	in     (%dx),%al
80102984:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102987:	89 f2                	mov    %esi,%edx
80102989:	b0 0a                	mov    $0xa,%al
8010298b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010298c:	89 da                	mov    %ebx,%edx
8010298e:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
8010298f:	84 c0                	test   %al,%al
80102991:	78 ad                	js     80102940 <cmostime+0x30>
  return inb(CMOS_RETURN);
80102993:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102997:	89 f2                	mov    %esi,%edx
80102999:	89 4d cc             	mov    %ecx,-0x34(%ebp)
8010299c:	89 45 b8             	mov    %eax,-0x48(%ebp)
8010299f:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
801029a3:	89 45 bc             	mov    %eax,-0x44(%ebp)
801029a6:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
801029aa:	89 45 c0             	mov    %eax,-0x40(%ebp)
801029ad:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801029b1:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801029b4:	0f b6 45 b3          	movzbl -0x4d(%ebp),%eax
801029b8:	89 45 c8             	mov    %eax,-0x38(%ebp)
801029bb:	31 c0                	xor    %eax,%eax
801029bd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029be:	89 da                	mov    %ebx,%edx
801029c0:	ec                   	in     (%dx),%al
801029c1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029c4:	89 f2                	mov    %esi,%edx
801029c6:	89 45 d0             	mov    %eax,-0x30(%ebp)
801029c9:	b0 02                	mov    $0x2,%al
801029cb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029cc:	89 da                	mov    %ebx,%edx
801029ce:	ec                   	in     (%dx),%al
801029cf:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029d2:	89 f2                	mov    %esi,%edx
801029d4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801029d7:	b0 04                	mov    $0x4,%al
801029d9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029da:	89 da                	mov    %ebx,%edx
801029dc:	ec                   	in     (%dx),%al
801029dd:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029e0:	89 f2                	mov    %esi,%edx
801029e2:	89 45 d8             	mov    %eax,-0x28(%ebp)
801029e5:	b0 07                	mov    $0x7,%al
801029e7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029e8:	89 da                	mov    %ebx,%edx
801029ea:	ec                   	in     (%dx),%al
801029eb:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029ee:	89 f2                	mov    %esi,%edx
801029f0:	89 45 dc             	mov    %eax,-0x24(%ebp)
801029f3:	b0 08                	mov    $0x8,%al
801029f5:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029f6:	89 da                	mov    %ebx,%edx
801029f8:	ec                   	in     (%dx),%al
801029f9:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029fc:	89 f2                	mov    %esi,%edx
801029fe:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102a01:	b0 09                	mov    $0x9,%al
80102a03:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a04:	89 da                	mov    %ebx,%edx
80102a06:	ec                   	in     (%dx),%al
80102a07:	0f b6 c0             	movzbl %al,%eax
80102a0a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102a0d:	b8 18 00 00 00       	mov    $0x18,%eax
80102a12:	89 44 24 08          	mov    %eax,0x8(%esp)
80102a16:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102a19:	89 7c 24 04          	mov    %edi,0x4(%esp)
80102a1d:	89 04 24             	mov    %eax,(%esp)
80102a20:	e8 fb 31 00 00       	call   80105c20 <memcmp>
80102a25:	85 c0                	test   %eax,%eax
80102a27:	0f 85 13 ff ff ff    	jne    80102940 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80102a2d:	80 7d b2 00          	cmpb   $0x0,-0x4e(%ebp)
80102a31:	75 78                	jne    80102aab <cmostime+0x19b>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102a33:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a36:	89 c2                	mov    %eax,%edx
80102a38:	83 e0 0f             	and    $0xf,%eax
80102a3b:	c1 ea 04             	shr    $0x4,%edx
80102a3e:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a41:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a44:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102a47:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a4a:	89 c2                	mov    %eax,%edx
80102a4c:	83 e0 0f             	and    $0xf,%eax
80102a4f:	c1 ea 04             	shr    $0x4,%edx
80102a52:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a55:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a58:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102a5b:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a5e:	89 c2                	mov    %eax,%edx
80102a60:	83 e0 0f             	and    $0xf,%eax
80102a63:	c1 ea 04             	shr    $0x4,%edx
80102a66:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a69:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a6c:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102a6f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a72:	89 c2                	mov    %eax,%edx
80102a74:	83 e0 0f             	and    $0xf,%eax
80102a77:	c1 ea 04             	shr    $0x4,%edx
80102a7a:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a7d:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a80:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102a83:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a86:	89 c2                	mov    %eax,%edx
80102a88:	83 e0 0f             	and    $0xf,%eax
80102a8b:	c1 ea 04             	shr    $0x4,%edx
80102a8e:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a91:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a94:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102a97:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a9a:	89 c2                	mov    %eax,%edx
80102a9c:	83 e0 0f             	and    $0xf,%eax
80102a9f:	c1 ea 04             	shr    $0x4,%edx
80102aa2:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102aa5:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102aa8:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102aab:	31 c0                	xor    %eax,%eax
80102aad:	8b 54 05 b8          	mov    -0x48(%ebp,%eax,1),%edx
80102ab1:	8b 7d 08             	mov    0x8(%ebp),%edi
80102ab4:	89 14 07             	mov    %edx,(%edi,%eax,1)
80102ab7:	83 c0 04             	add    $0x4,%eax
80102aba:	83 f8 18             	cmp    $0x18,%eax
80102abd:	72 ee                	jb     80102aad <cmostime+0x19d>
  r->year += 2000;
80102abf:	81 47 14 d0 07 00 00 	addl   $0x7d0,0x14(%edi)
}
80102ac6:	83 c4 5c             	add    $0x5c,%esp
80102ac9:	5b                   	pop    %ebx
80102aca:	5e                   	pop    %esi
80102acb:	5f                   	pop    %edi
80102acc:	5d                   	pop    %ebp
80102acd:	c3                   	ret    
80102ace:	66 90                	xchg   %ax,%ax

80102ad0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ad0:	8b 15 28 47 11 80    	mov    0x80114728,%edx
80102ad6:	85 d2                	test   %edx,%edx
80102ad8:	0f 8e 92 00 00 00    	jle    80102b70 <install_trans+0xa0>
{
80102ade:	55                   	push   %ebp
80102adf:	89 e5                	mov    %esp,%ebp
80102ae1:	57                   	push   %edi
80102ae2:	56                   	push   %esi
80102ae3:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102ae4:	31 db                	xor    %ebx,%ebx
{
80102ae6:	83 ec 1c             	sub    $0x1c,%esp
80102ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102af0:	a1 14 47 11 80       	mov    0x80114714,%eax
80102af5:	01 d8                	add    %ebx,%eax
80102af7:	40                   	inc    %eax
80102af8:	89 44 24 04          	mov    %eax,0x4(%esp)
80102afc:	a1 24 47 11 80       	mov    0x80114724,%eax
80102b01:	89 04 24             	mov    %eax,(%esp)
80102b04:	e8 c7 d5 ff ff       	call   801000d0 <bread>
80102b09:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b0b:	8b 04 9d 2c 47 11 80 	mov    -0x7feeb8d4(,%ebx,4),%eax
  for (tail = 0; tail < log.lh.n; tail++) {
80102b12:	43                   	inc    %ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b13:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b17:	a1 24 47 11 80       	mov    0x80114724,%eax
80102b1c:	89 04 24             	mov    %eax,(%esp)
80102b1f:	e8 ac d5 ff ff       	call   801000d0 <bread>
80102b24:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102b26:	b8 00 02 00 00       	mov    $0x200,%eax
80102b2b:	89 44 24 08          	mov    %eax,0x8(%esp)
80102b2f:	8d 47 5c             	lea    0x5c(%edi),%eax
80102b32:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b36:	8d 46 5c             	lea    0x5c(%esi),%eax
80102b39:	89 04 24             	mov    %eax,(%esp)
80102b3c:	e8 3f 31 00 00       	call   80105c80 <memmove>
    bwrite(dbuf);  // write dst to disk
80102b41:	89 34 24             	mov    %esi,(%esp)
80102b44:	e8 57 d6 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102b49:	89 3c 24             	mov    %edi,(%esp)
80102b4c:	e8 8f d6 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102b51:	89 34 24             	mov    %esi,(%esp)
80102b54:	e8 87 d6 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102b59:	39 1d 28 47 11 80    	cmp    %ebx,0x80114728
80102b5f:	7f 8f                	jg     80102af0 <install_trans+0x20>
  }
}
80102b61:	83 c4 1c             	add    $0x1c,%esp
80102b64:	5b                   	pop    %ebx
80102b65:	5e                   	pop    %esi
80102b66:	5f                   	pop    %edi
80102b67:	5d                   	pop    %ebp
80102b68:	c3                   	ret    
80102b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b70:	c3                   	ret    
80102b71:	eb 0d                	jmp    80102b80 <write_head>
80102b73:	90                   	nop
80102b74:	90                   	nop
80102b75:	90                   	nop
80102b76:	90                   	nop
80102b77:	90                   	nop
80102b78:	90                   	nop
80102b79:	90                   	nop
80102b7a:	90                   	nop
80102b7b:	90                   	nop
80102b7c:	90                   	nop
80102b7d:	90                   	nop
80102b7e:	90                   	nop
80102b7f:	90                   	nop

80102b80 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102b80:	55                   	push   %ebp
80102b81:	89 e5                	mov    %esp,%ebp
80102b83:	56                   	push   %esi
80102b84:	53                   	push   %ebx
80102b85:	83 ec 10             	sub    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102b88:	a1 14 47 11 80       	mov    0x80114714,%eax
80102b8d:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b91:	a1 24 47 11 80       	mov    0x80114724,%eax
80102b96:	89 04 24             	mov    %eax,(%esp)
80102b99:	e8 32 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b9e:	8b 1d 28 47 11 80    	mov    0x80114728,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102ba4:	85 db                	test   %ebx,%ebx
  struct buf *buf = bread(log.dev, log.start);
80102ba6:	89 c6                	mov    %eax,%esi
  hb->n = log.lh.n;
80102ba8:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102bab:	7e 24                	jle    80102bd1 <write_head+0x51>
80102bad:	c1 e3 02             	shl    $0x2,%ebx
80102bb0:	31 d2                	xor    %edx,%edx
80102bb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    hb->block[i] = log.lh.block[i];
80102bc0:	8b 8a 2c 47 11 80    	mov    -0x7feeb8d4(%edx),%ecx
80102bc6:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102bca:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102bcd:	39 da                	cmp    %ebx,%edx
80102bcf:	75 ef                	jne    80102bc0 <write_head+0x40>
  }
  bwrite(buf);
80102bd1:	89 34 24             	mov    %esi,(%esp)
80102bd4:	e8 c7 d5 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102bd9:	89 34 24             	mov    %esi,(%esp)
80102bdc:	e8 ff d5 ff ff       	call   801001e0 <brelse>
}
80102be1:	83 c4 10             	add    $0x10,%esp
80102be4:	5b                   	pop    %ebx
80102be5:	5e                   	pop    %esi
80102be6:	5d                   	pop    %ebp
80102be7:	c3                   	ret    
80102be8:	90                   	nop
80102be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102bf0 <initlog>:
{
80102bf0:	55                   	push   %ebp
  initlock(&log.lock, "log");
80102bf1:	ba 20 8c 10 80       	mov    $0x80108c20,%edx
{
80102bf6:	89 e5                	mov    %esp,%ebp
80102bf8:	53                   	push   %ebx
80102bf9:	83 ec 34             	sub    $0x34,%esp
80102bfc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102bff:	89 54 24 04          	mov    %edx,0x4(%esp)
80102c03:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102c0a:	e8 71 2d 00 00       	call   80105980 <initlock>
  readsb(dev, &sb);
80102c0f:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102c12:	89 44 24 04          	mov    %eax,0x4(%esp)
80102c16:	89 1c 24             	mov    %ebx,(%esp)
80102c19:	e8 b2 e7 ff ff       	call   801013d0 <readsb>
  log.start = sb.logstart;
80102c1e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  log.size = sb.nlog;
80102c21:	8b 55 e8             	mov    -0x18(%ebp),%edx
  struct buf *buf = bread(log.dev, log.start);
80102c24:	89 1c 24             	mov    %ebx,(%esp)
  log.dev = dev;
80102c27:	89 1d 24 47 11 80    	mov    %ebx,0x80114724
  struct buf *buf = bread(log.dev, log.start);
80102c2d:	89 44 24 04          	mov    %eax,0x4(%esp)
  log.start = sb.logstart;
80102c31:	a3 14 47 11 80       	mov    %eax,0x80114714
  log.size = sb.nlog;
80102c36:	89 15 18 47 11 80    	mov    %edx,0x80114718
  struct buf *buf = bread(log.dev, log.start);
80102c3c:	e8 8f d4 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102c41:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102c44:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102c46:	89 1d 28 47 11 80    	mov    %ebx,0x80114728
  for (i = 0; i < log.lh.n; i++) {
80102c4c:	7e 23                	jle    80102c71 <initlog+0x81>
80102c4e:	c1 e3 02             	shl    $0x2,%ebx
80102c51:	31 d2                	xor    %edx,%edx
80102c53:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log.lh.block[i] = lh->block[i];
80102c60:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102c64:	83 c2 04             	add    $0x4,%edx
80102c67:	89 8a 28 47 11 80    	mov    %ecx,-0x7feeb8d8(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102c6d:	39 d3                	cmp    %edx,%ebx
80102c6f:	75 ef                	jne    80102c60 <initlog+0x70>
  brelse(buf);
80102c71:	89 04 24             	mov    %eax,(%esp)
80102c74:	e8 67 d5 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102c79:	e8 52 fe ff ff       	call   80102ad0 <install_trans>
  log.lh.n = 0;
80102c7e:	31 c0                	xor    %eax,%eax
80102c80:	a3 28 47 11 80       	mov    %eax,0x80114728
  write_head(); // clear the log
80102c85:	e8 f6 fe ff ff       	call   80102b80 <write_head>
}
80102c8a:	83 c4 34             	add    $0x34,%esp
80102c8d:	5b                   	pop    %ebx
80102c8e:	5d                   	pop    %ebp
80102c8f:	c3                   	ret    

80102c90 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102c90:	55                   	push   %ebp
80102c91:	89 e5                	mov    %esp,%ebp
80102c93:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
80102c96:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102c9d:	e8 2e 2e 00 00       	call   80105ad0 <acquire>
80102ca2:	eb 19                	jmp    80102cbd <begin_op+0x2d>
80102ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102ca8:	b8 e0 46 11 80       	mov    $0x801146e0,%eax
80102cad:	89 44 24 04          	mov    %eax,0x4(%esp)
80102cb1:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102cb8:	e8 d3 16 00 00       	call   80104390 <sleep>
    if(log.committing){
80102cbd:	8b 15 20 47 11 80    	mov    0x80114720,%edx
80102cc3:	85 d2                	test   %edx,%edx
80102cc5:	75 e1                	jne    80102ca8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102cc7:	a1 1c 47 11 80       	mov    0x8011471c,%eax
80102ccc:	8b 15 28 47 11 80    	mov    0x80114728,%edx
80102cd2:	40                   	inc    %eax
80102cd3:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102cd6:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102cd9:	83 fa 1e             	cmp    $0x1e,%edx
80102cdc:	7f ca                	jg     80102ca8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102cde:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
      log.outstanding += 1;
80102ce5:	a3 1c 47 11 80       	mov    %eax,0x8011471c
      release(&log.lock);
80102cea:	e8 81 2e 00 00       	call   80105b70 <release>
      break;
    }
  }
}
80102cef:	c9                   	leave  
80102cf0:	c3                   	ret    
80102cf1:	eb 0d                	jmp    80102d00 <end_op>
80102cf3:	90                   	nop
80102cf4:	90                   	nop
80102cf5:	90                   	nop
80102cf6:	90                   	nop
80102cf7:	90                   	nop
80102cf8:	90                   	nop
80102cf9:	90                   	nop
80102cfa:	90                   	nop
80102cfb:	90                   	nop
80102cfc:	90                   	nop
80102cfd:	90                   	nop
80102cfe:	90                   	nop
80102cff:	90                   	nop

80102d00 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102d00:	55                   	push   %ebp
80102d01:	89 e5                	mov    %esp,%ebp
80102d03:	57                   	push   %edi
80102d04:	56                   	push   %esi
80102d05:	53                   	push   %ebx
80102d06:	83 ec 1c             	sub    $0x1c,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102d09:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102d10:	e8 bb 2d 00 00       	call   80105ad0 <acquire>
  log.outstanding -= 1;
80102d15:	a1 1c 47 11 80       	mov    0x8011471c,%eax
80102d1a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102d1d:	a1 20 47 11 80       	mov    0x80114720,%eax
  log.outstanding -= 1;
80102d22:	89 1d 1c 47 11 80    	mov    %ebx,0x8011471c
  if(log.committing)
80102d28:	85 c0                	test   %eax,%eax
80102d2a:	0f 85 e8 00 00 00    	jne    80102e18 <end_op+0x118>
    panic("log.committing");
  if(log.outstanding == 0){
80102d30:	85 db                	test   %ebx,%ebx
80102d32:	0f 85 c0 00 00 00    	jne    80102df8 <end_op+0xf8>
    do_commit = 1;
    log.committing = 1;
80102d38:	be 01 00 00 00       	mov    $0x1,%esi
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102d3d:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
    log.committing = 1;
80102d44:	89 35 20 47 11 80    	mov    %esi,0x80114720
  release(&log.lock);
80102d4a:	e8 21 2e 00 00       	call   80105b70 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102d4f:	8b 3d 28 47 11 80    	mov    0x80114728,%edi
80102d55:	85 ff                	test   %edi,%edi
80102d57:	0f 8e 88 00 00 00    	jle    80102de5 <end_op+0xe5>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102d5d:	a1 14 47 11 80       	mov    0x80114714,%eax
80102d62:	01 d8                	add    %ebx,%eax
80102d64:	40                   	inc    %eax
80102d65:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d69:	a1 24 47 11 80       	mov    0x80114724,%eax
80102d6e:	89 04 24             	mov    %eax,(%esp)
80102d71:	e8 5a d3 ff ff       	call   801000d0 <bread>
80102d76:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d78:	8b 04 9d 2c 47 11 80 	mov    -0x7feeb8d4(,%ebx,4),%eax
  for (tail = 0; tail < log.lh.n; tail++) {
80102d7f:	43                   	inc    %ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d80:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d84:	a1 24 47 11 80       	mov    0x80114724,%eax
80102d89:	89 04 24             	mov    %eax,(%esp)
80102d8c:	e8 3f d3 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102d91:	b9 00 02 00 00       	mov    $0x200,%ecx
80102d96:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d9a:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102d9c:	8d 40 5c             	lea    0x5c(%eax),%eax
80102d9f:	89 44 24 04          	mov    %eax,0x4(%esp)
80102da3:	8d 46 5c             	lea    0x5c(%esi),%eax
80102da6:	89 04 24             	mov    %eax,(%esp)
80102da9:	e8 d2 2e 00 00       	call   80105c80 <memmove>
    bwrite(to);  // write the log
80102dae:	89 34 24             	mov    %esi,(%esp)
80102db1:	e8 ea d3 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102db6:	89 3c 24             	mov    %edi,(%esp)
80102db9:	e8 22 d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102dbe:	89 34 24             	mov    %esi,(%esp)
80102dc1:	e8 1a d4 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102dc6:	3b 1d 28 47 11 80    	cmp    0x80114728,%ebx
80102dcc:	7c 8f                	jl     80102d5d <end_op+0x5d>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102dce:	e8 ad fd ff ff       	call   80102b80 <write_head>
    install_trans(); // Now install writes to home locations
80102dd3:	e8 f8 fc ff ff       	call   80102ad0 <install_trans>
    log.lh.n = 0;
80102dd8:	31 d2                	xor    %edx,%edx
80102dda:	89 15 28 47 11 80    	mov    %edx,0x80114728
    write_head();    // Erase the transaction from the log
80102de0:	e8 9b fd ff ff       	call   80102b80 <write_head>
    acquire(&log.lock);
80102de5:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102dec:	e8 df 2c 00 00       	call   80105ad0 <acquire>
    log.committing = 0;
80102df1:	31 c0                	xor    %eax,%eax
80102df3:	a3 20 47 11 80       	mov    %eax,0x80114720
    wakeup(&log);
80102df8:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102dff:	e8 8c 17 00 00       	call   80104590 <wakeup>
    release(&log.lock);
80102e04:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102e0b:	e8 60 2d 00 00       	call   80105b70 <release>
}
80102e10:	83 c4 1c             	add    $0x1c,%esp
80102e13:	5b                   	pop    %ebx
80102e14:	5e                   	pop    %esi
80102e15:	5f                   	pop    %edi
80102e16:	5d                   	pop    %ebp
80102e17:	c3                   	ret    
    panic("log.committing");
80102e18:	c7 04 24 24 8c 10 80 	movl   $0x80108c24,(%esp)
80102e1f:	e8 4c d5 ff ff       	call   80100370 <panic>
80102e24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102e2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102e30 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102e30:	55                   	push   %ebp
80102e31:	89 e5                	mov    %esp,%ebp
80102e33:	53                   	push   %ebx
80102e34:	83 ec 14             	sub    $0x14,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e37:	8b 15 28 47 11 80    	mov    0x80114728,%edx
{
80102e3d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e40:	83 fa 1d             	cmp    $0x1d,%edx
80102e43:	0f 8f 95 00 00 00    	jg     80102ede <log_write+0xae>
80102e49:	a1 18 47 11 80       	mov    0x80114718,%eax
80102e4e:	48                   	dec    %eax
80102e4f:	39 c2                	cmp    %eax,%edx
80102e51:	0f 8d 87 00 00 00    	jge    80102ede <log_write+0xae>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102e57:	a1 1c 47 11 80       	mov    0x8011471c,%eax
80102e5c:	85 c0                	test   %eax,%eax
80102e5e:	0f 8e 86 00 00 00    	jle    80102eea <log_write+0xba>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102e64:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102e6b:	e8 60 2c 00 00       	call   80105ad0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102e70:	8b 0d 28 47 11 80    	mov    0x80114728,%ecx
80102e76:	83 f9 00             	cmp    $0x0,%ecx
80102e79:	7e 55                	jle    80102ed0 <log_write+0xa0>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e7b:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102e7e:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e80:	3b 15 2c 47 11 80    	cmp    0x8011472c,%edx
80102e86:	75 11                	jne    80102e99 <log_write+0x69>
80102e88:	eb 36                	jmp    80102ec0 <log_write+0x90>
80102e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102e90:	39 14 85 2c 47 11 80 	cmp    %edx,-0x7feeb8d4(,%eax,4)
80102e97:	74 27                	je     80102ec0 <log_write+0x90>
  for (i = 0; i < log.lh.n; i++) {
80102e99:	40                   	inc    %eax
80102e9a:	39 c1                	cmp    %eax,%ecx
80102e9c:	75 f2                	jne    80102e90 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102e9e:	89 14 85 2c 47 11 80 	mov    %edx,-0x7feeb8d4(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102ea5:	40                   	inc    %eax
80102ea6:	a3 28 47 11 80       	mov    %eax,0x80114728
  b->flags |= B_DIRTY; // prevent eviction
80102eab:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102eae:	c7 45 08 e0 46 11 80 	movl   $0x801146e0,0x8(%ebp)
}
80102eb5:	83 c4 14             	add    $0x14,%esp
80102eb8:	5b                   	pop    %ebx
80102eb9:	5d                   	pop    %ebp
  release(&log.lock);
80102eba:	e9 b1 2c 00 00       	jmp    80105b70 <release>
80102ebf:	90                   	nop
  log.lh.block[i] = b->blockno;
80102ec0:	89 14 85 2c 47 11 80 	mov    %edx,-0x7feeb8d4(,%eax,4)
80102ec7:	eb e2                	jmp    80102eab <log_write+0x7b>
80102ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ed0:	8b 43 08             	mov    0x8(%ebx),%eax
80102ed3:	a3 2c 47 11 80       	mov    %eax,0x8011472c
  if (i == log.lh.n)
80102ed8:	75 d1                	jne    80102eab <log_write+0x7b>
80102eda:	31 c0                	xor    %eax,%eax
80102edc:	eb c7                	jmp    80102ea5 <log_write+0x75>
    panic("too big a transaction");
80102ede:	c7 04 24 33 8c 10 80 	movl   $0x80108c33,(%esp)
80102ee5:	e8 86 d4 ff ff       	call   80100370 <panic>
    panic("log_write outside of trans");
80102eea:	c7 04 24 49 8c 10 80 	movl   $0x80108c49,(%esp)
80102ef1:	e8 7a d4 ff ff       	call   80100370 <panic>
80102ef6:	66 90                	xchg   %ax,%ax
80102ef8:	66 90                	xchg   %ax,%ax
80102efa:	66 90                	xchg   %ax,%ax
80102efc:	66 90                	xchg   %ax,%ax
80102efe:	66 90                	xchg   %ax,%ax

80102f00 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80102f00:	55                   	push   %ebp
80102f01:	89 e5                	mov    %esp,%ebp
80102f03:	53                   	push   %ebx
80102f04:	83 ec 14             	sub    $0x14,%esp
  switchkvm();
80102f07:	e8 74 51 00 00       	call   80108080 <switchkvm>
  seginit();
80102f0c:	e8 df 50 00 00       	call   80107ff0 <seginit>
  lapicinit();
80102f11:	e8 1a f8 ff ff       	call   80102730 <lapicinit>
}

static void
mpmain(void) //called by the non-boot AP cpus
{
  struct cpu* c = mycpu();
80102f16:	e8 65 0a 00 00       	call   80103980 <mycpu>
80102f1b:	89 c3                	mov    %eax,%ebx
  cprintf("cpu%d: is witing for the \"pioneer\" cpu to finish its initialization.\n", cpuid());
80102f1d:	e8 de 0a 00 00       	call   80103a00 <cpuid>
80102f22:	c7 04 24 64 8c 10 80 	movl   $0x80108c64,(%esp)
80102f29:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f2d:	e8 1e d7 ff ff       	call   80100650 <cprintf>
  idtinit();       // load idt register
80102f32:	e8 f9 3f 00 00       	call   80106f30 <idtinit>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102f37:	b8 01 00 00 00       	mov    $0x1,%eax
80102f3c:	f0 87 83 a0 00 00 00 	lock xchg %eax,0xa0(%ebx)
80102f43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  xchg(&(c->started), 1); // tell startothers() we're up
  while(c->started != 0); // wait for the "pioneer" cpu to finish the scheduling data structures initialization
80102f50:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102f56:	85 c0                	test   %eax,%eax
80102f58:	75 f6                	jne    80102f50 <mpenter+0x50>
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102f5a:	e8 a1 0a 00 00       	call   80103a00 <cpuid>
80102f5f:	89 c3                	mov    %eax,%ebx
80102f61:	e8 9a 0a 00 00       	call   80103a00 <cpuid>
80102f66:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80102f6a:	c7 04 24 b4 8c 10 80 	movl   $0x80108cb4,(%esp)
80102f71:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f75:	e8 d6 d6 ff ff       	call   80100650 <cprintf>
  scheduler();     // start running processes
80102f7a:	e8 e1 0e 00 00       	call   80103e60 <scheduler>
80102f7f:	90                   	nop

80102f80 <main>:
{
80102f80:	55                   	push   %ebp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102f81:	b8 00 00 40 80       	mov    $0x80400000,%eax
{
80102f86:	89 e5                	mov    %esp,%ebp
80102f88:	53                   	push   %ebx
80102f89:	83 e4 f0             	and    $0xfffffff0,%esp
80102f8c:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102f8f:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f93:	c7 04 24 08 80 11 80 	movl   $0x80118008,(%esp)
80102f9a:	e8 41 f5 ff ff       	call   801024e0 <kinit1>
  kvmalloc();      // kernel page table
80102f9f:	e8 ac 55 00 00       	call   80108550 <kvmalloc>
  mpinit();        // detect other processors
80102fa4:	e8 17 02 00 00       	call   801031c0 <mpinit>
  lapicinit();     // interrupt controller
80102fa9:	e8 82 f7 ff ff       	call   80102730 <lapicinit>
80102fae:	66 90                	xchg   %ax,%ax
  seginit();       // segment descriptors
80102fb0:	e8 3b 50 00 00       	call   80107ff0 <seginit>
  picinit();       // disable pic
80102fb5:	e8 e6 03 00 00       	call   801033a0 <picinit>
  ioapicinit();    // another interrupt controller
80102fba:	e8 31 f3 ff ff       	call   801022f0 <ioapicinit>
80102fbf:	90                   	nop
  consoleinit();   // console hardware
80102fc0:	e8 bb d9 ff ff       	call   80100980 <consoleinit>
  uartinit();      // serial port
80102fc5:	e8 f6 42 00 00       	call   801072c0 <uartinit>
  pinit();         // process table
80102fca:	e8 91 09 00 00       	call   80103960 <pinit>
80102fcf:	90                   	nop
  tvinit();        // trap vectors
80102fd0:	e8 db 3e 00 00       	call   80106eb0 <tvinit>
  binit();         // buffer cache
80102fd5:	e8 66 d0 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102fda:	e8 71 dd ff ff       	call   80100d50 <fileinit>
80102fdf:	90                   	nop
  ideinit();       // disk 
80102fe0:	e8 fb f0 ff ff       	call   801020e0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102fe5:	b8 8a 00 00 00       	mov    $0x8a,%eax
80102fea:	89 44 24 08          	mov    %eax,0x8(%esp)
80102fee:	b8 8c c4 10 80       	mov    $0x8010c48c,%eax
80102ff3:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ff7:	c7 04 24 00 70 00 80 	movl   $0x80007000,(%esp)
80102ffe:	e8 7d 2c 00 00       	call   80105c80 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103003:	a1 60 4d 11 80       	mov    0x80114d60,%eax
80103008:	8d 14 80             	lea    (%eax,%eax,4),%edx
8010300b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010300e:	c1 e0 04             	shl    $0x4,%eax
80103011:	05 e0 47 11 80       	add    $0x801147e0,%eax
80103016:	3d e0 47 11 80       	cmp    $0x801147e0,%eax
8010301b:	0f 86 86 00 00 00    	jbe    801030a7 <main+0x127>
80103021:	bb e0 47 11 80       	mov    $0x801147e0,%ebx
80103026:	8d 76 00             	lea    0x0(%esi),%esi
80103029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80103030:	e8 4b 09 00 00       	call   80103980 <mycpu>
80103035:	39 d8                	cmp    %ebx,%eax
80103037:	74 51                	je     8010308a <main+0x10a>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103039:	e8 72 f5 ff ff       	call   801025b0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
8010303e:	ba 00 2f 10 80       	mov    $0x80102f00,%edx
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103043:	b9 00 b0 10 00       	mov    $0x10b000,%ecx
    *(void(**)(void))(code-8) = mpenter;
80103048:	89 15 f8 6f 00 80    	mov    %edx,0x80006ff8
    *(int**)(code-12) = (void *) V2P(entrypgdir);
8010304e:	89 0d f4 6f 00 80    	mov    %ecx,0x80006ff4
    *(void**)(code-4) = stack + KSTACKSIZE;
80103054:	05 00 10 00 00       	add    $0x1000,%eax
80103059:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
8010305e:	b8 00 70 00 00       	mov    $0x7000,%eax
80103063:	89 44 24 04          	mov    %eax,0x4(%esp)
80103067:	0f b6 03             	movzbl (%ebx),%eax
8010306a:	89 04 24             	mov    %eax,(%esp)
8010306d:	e8 0e f8 ff ff       	call   80102880 <lapicstartap>
80103072:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103080:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103086:	85 c0                	test   %eax,%eax
80103088:	74 f6                	je     80103080 <main+0x100>
  for(c = cpus; c < cpus+ncpu; c++){
8010308a:	a1 60 4d 11 80       	mov    0x80114d60,%eax
8010308f:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103095:	8d 14 80             	lea    (%eax,%eax,4),%edx
80103098:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010309b:	c1 e0 04             	shl    $0x4,%eax
8010309e:	05 e0 47 11 80       	add    $0x801147e0,%eax
801030a3:	39 c3                	cmp    %eax,%ebx
801030a5:	72 89                	jb     80103030 <main+0xb0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801030a7:	b8 00 00 00 8e       	mov    $0x8e000000,%eax
801030ac:	89 44 24 04          	mov    %eax,0x4(%esp)
801030b0:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
801030b7:	e8 94 f4 ff ff       	call   80102550 <kinit2>
  initSchedDS(); // initialize the data structures for the processes sceduling policies
801030bc:	e8 2f 1d 00 00       	call   80104df0 <initSchedDS>
	__sync_synchronize();
801030c1:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  for(struct cpu *c = cpus; c < cpus + ncpu; ++c) //releases the non-boot AP cpus that are wating at mpmain at main.c
801030c6:	a1 60 4d 11 80       	mov    0x80114d60,%eax
801030cb:	8d 14 80             	lea    (%eax,%eax,4),%edx
801030ce:	8d 0c 50             	lea    (%eax,%edx,2),%ecx
801030d1:	c1 e1 04             	shl    $0x4,%ecx
801030d4:	81 c1 e0 47 11 80    	add    $0x801147e0,%ecx
801030da:	81 f9 e0 47 11 80    	cmp    $0x801147e0,%ecx
801030e0:	76 21                	jbe    80103103 <main+0x183>
801030e2:	ba e0 47 11 80       	mov    $0x801147e0,%edx
801030e7:	31 db                	xor    %ebx,%ebx
801030e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030f0:	89 d8                	mov    %ebx,%eax
801030f2:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
801030f9:	81 c2 b0 00 00 00    	add    $0xb0,%edx
801030ff:	39 ca                	cmp    %ecx,%edx
80103101:	72 ed                	jb     801030f0 <main+0x170>
  userinit();      // first user process
80103103:	e8 f8 09 00 00       	call   80103b00 <userinit>
  cprintf("\"pioneer\" cpu%d: starting %d\n", cpuid(), cpuid());
80103108:	e8 f3 08 00 00       	call   80103a00 <cpuid>
8010310d:	89 c3                	mov    %eax,%ebx
8010310f:	e8 ec 08 00 00       	call   80103a00 <cpuid>
80103114:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80103118:	c7 04 24 aa 8c 10 80 	movl   $0x80108caa,(%esp)
8010311f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103123:	e8 28 d5 ff ff       	call   80100650 <cprintf>
  idtinit();       // load idt register
80103128:	e8 03 3e 00 00       	call   80106f30 <idtinit>
  scheduler();     // start running processes
8010312d:	e8 2e 0d 00 00       	call   80103e60 <scheduler>
80103132:	66 90                	xchg   %ax,%ax
80103134:	66 90                	xchg   %ax,%ax
80103136:	66 90                	xchg   %ax,%ax
80103138:	66 90                	xchg   %ax,%ax
8010313a:	66 90                	xchg   %ax,%ax
8010313c:	66 90                	xchg   %ax,%ax
8010313e:	66 90                	xchg   %ax,%ax

80103140 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103140:	55                   	push   %ebp
80103141:	89 e5                	mov    %esp,%ebp
80103143:	57                   	push   %edi
80103144:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103145:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010314b:	53                   	push   %ebx
  e = addr+len;
8010314c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010314f:	83 ec 1c             	sub    $0x1c,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103152:	39 de                	cmp    %ebx,%esi
80103154:	72 10                	jb     80103166 <mpsearch1+0x26>
80103156:	eb 58                	jmp    801031b0 <mpsearch1+0x70>
80103158:	90                   	nop
80103159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103160:	39 d3                	cmp    %edx,%ebx
80103162:	89 d6                	mov    %edx,%esi
80103164:	76 4a                	jbe    801031b0 <mpsearch1+0x70>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103166:	ba c8 8c 10 80       	mov    $0x80108cc8,%edx
8010316b:	b8 04 00 00 00       	mov    $0x4,%eax
80103170:	89 54 24 04          	mov    %edx,0x4(%esp)
80103174:	89 44 24 08          	mov    %eax,0x8(%esp)
80103178:	89 34 24             	mov    %esi,(%esp)
8010317b:	e8 a0 2a 00 00       	call   80105c20 <memcmp>
80103180:	8d 56 10             	lea    0x10(%esi),%edx
80103183:	85 c0                	test   %eax,%eax
80103185:	75 d9                	jne    80103160 <mpsearch1+0x20>
80103187:	89 f1                	mov    %esi,%ecx
80103189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103190:	0f b6 39             	movzbl (%ecx),%edi
80103193:	41                   	inc    %ecx
80103194:	01 f8                	add    %edi,%eax
  for(i=0; i<len; i++)
80103196:	39 d1                	cmp    %edx,%ecx
80103198:	75 f6                	jne    80103190 <mpsearch1+0x50>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010319a:	84 c0                	test   %al,%al
8010319c:	75 c2                	jne    80103160 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
8010319e:	83 c4 1c             	add    $0x1c,%esp
801031a1:	89 f0                	mov    %esi,%eax
801031a3:	5b                   	pop    %ebx
801031a4:	5e                   	pop    %esi
801031a5:	5f                   	pop    %edi
801031a6:	5d                   	pop    %ebp
801031a7:	c3                   	ret    
801031a8:	90                   	nop
801031a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031b0:	83 c4 1c             	add    $0x1c,%esp
  return 0;
801031b3:	31 f6                	xor    %esi,%esi
}
801031b5:	5b                   	pop    %ebx
801031b6:	89 f0                	mov    %esi,%eax
801031b8:	5e                   	pop    %esi
801031b9:	5f                   	pop    %edi
801031ba:	5d                   	pop    %ebp
801031bb:	c3                   	ret    
801031bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801031c0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801031c0:	55                   	push   %ebp
801031c1:	89 e5                	mov    %esp,%ebp
801031c3:	57                   	push   %edi
801031c4:	56                   	push   %esi
801031c5:	53                   	push   %ebx
801031c6:	83 ec 2c             	sub    $0x2c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801031c9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801031d0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801031d7:	c1 e0 08             	shl    $0x8,%eax
801031da:	09 d0                	or     %edx,%eax
801031dc:	c1 e0 04             	shl    $0x4,%eax
801031df:	75 1b                	jne    801031fc <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801031e1:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801031e8:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801031ef:	c1 e0 08             	shl    $0x8,%eax
801031f2:	09 d0                	or     %edx,%eax
801031f4:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801031f7:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
801031fc:	ba 00 04 00 00       	mov    $0x400,%edx
80103201:	e8 3a ff ff ff       	call   80103140 <mpsearch1>
80103206:	85 c0                	test   %eax,%eax
80103208:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010320b:	0f 84 4f 01 00 00    	je     80103360 <mpinit+0x1a0>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103211:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103214:	8b 58 04             	mov    0x4(%eax),%ebx
80103217:	85 db                	test   %ebx,%ebx
80103219:	0f 84 61 01 00 00    	je     80103380 <mpinit+0x1c0>
  if(memcmp(conf, "PCMP", 4) != 0)
8010321f:	b8 04 00 00 00       	mov    $0x4,%eax
80103224:	ba e5 8c 10 80       	mov    $0x80108ce5,%edx
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103229:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
8010322f:	89 44 24 08          	mov    %eax,0x8(%esp)
80103233:	89 54 24 04          	mov    %edx,0x4(%esp)
80103237:	89 34 24             	mov    %esi,(%esp)
8010323a:	e8 e1 29 00 00       	call   80105c20 <memcmp>
8010323f:	85 c0                	test   %eax,%eax
80103241:	0f 85 39 01 00 00    	jne    80103380 <mpinit+0x1c0>
  if(conf->version != 1 && conf->version != 4)
80103247:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
8010324e:	3c 01                	cmp    $0x1,%al
80103250:	0f 95 c2             	setne  %dl
80103253:	3c 04                	cmp    $0x4,%al
80103255:	0f 95 c0             	setne  %al
80103258:	20 d0                	and    %dl,%al
8010325a:	0f 85 20 01 00 00    	jne    80103380 <mpinit+0x1c0>
  if(sum((uchar*)conf, conf->length) != 0)
80103260:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
80103267:	85 ff                	test   %edi,%edi
80103269:	74 24                	je     8010328f <mpinit+0xcf>
8010326b:	89 f0                	mov    %esi,%eax
8010326d:	01 f7                	add    %esi,%edi
  sum = 0;
8010326f:	31 d2                	xor    %edx,%edx
80103271:	eb 0d                	jmp    80103280 <mpinit+0xc0>
80103273:	90                   	nop
80103274:	90                   	nop
80103275:	90                   	nop
80103276:	90                   	nop
80103277:	90                   	nop
80103278:	90                   	nop
80103279:	90                   	nop
8010327a:	90                   	nop
8010327b:	90                   	nop
8010327c:	90                   	nop
8010327d:	90                   	nop
8010327e:	90                   	nop
8010327f:	90                   	nop
    sum += addr[i];
80103280:	0f b6 08             	movzbl (%eax),%ecx
80103283:	40                   	inc    %eax
80103284:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103286:	39 c7                	cmp    %eax,%edi
80103288:	75 f6                	jne    80103280 <mpinit+0xc0>
8010328a:	84 d2                	test   %dl,%dl
8010328c:	0f 95 c0             	setne  %al
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
8010328f:	85 f6                	test   %esi,%esi
80103291:	0f 84 e9 00 00 00    	je     80103380 <mpinit+0x1c0>
80103297:	84 c0                	test   %al,%al
80103299:	0f 85 e1 00 00 00    	jne    80103380 <mpinit+0x1c0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
8010329f:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032a5:	8d 93 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%edx
  ismp = 1;
801032ab:	b9 01 00 00 00       	mov    $0x1,%ecx
  lapic = (uint*)conf->lapicaddr;
801032b0:	a3 dc 46 11 80       	mov    %eax,0x801146dc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032b5:	0f b7 83 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%eax
801032bc:	01 c6                	add    %eax,%esi
801032be:	66 90                	xchg   %ax,%ax
801032c0:	39 d6                	cmp    %edx,%esi
801032c2:	76 23                	jbe    801032e7 <mpinit+0x127>
    switch(*p){
801032c4:	0f b6 02             	movzbl (%edx),%eax
801032c7:	3c 04                	cmp    $0x4,%al
801032c9:	0f 87 c9 00 00 00    	ja     80103398 <mpinit+0x1d8>
801032cf:	ff 24 85 0c 8d 10 80 	jmp    *-0x7fef72f4(,%eax,4)
801032d6:	8d 76 00             	lea    0x0(%esi),%esi
801032d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801032e0:	83 c2 08             	add    $0x8,%edx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032e3:	39 d6                	cmp    %edx,%esi
801032e5:	77 dd                	ja     801032c4 <mpinit+0x104>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801032e7:	85 c9                	test   %ecx,%ecx
801032e9:	0f 84 9d 00 00 00    	je     8010338c <mpinit+0x1cc>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801032ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801032f2:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
801032f6:	74 11                	je     80103309 <mpinit+0x149>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032f8:	b0 70                	mov    $0x70,%al
801032fa:	ba 22 00 00 00       	mov    $0x22,%edx
801032ff:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103300:	ba 23 00 00 00       	mov    $0x23,%edx
80103305:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103306:	0c 01                	or     $0x1,%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103308:	ee                   	out    %al,(%dx)
  }
}
80103309:	83 c4 2c             	add    $0x2c,%esp
8010330c:	5b                   	pop    %ebx
8010330d:	5e                   	pop    %esi
8010330e:	5f                   	pop    %edi
8010330f:	5d                   	pop    %ebp
80103310:	c3                   	ret    
80103311:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
80103318:	8b 1d 60 4d 11 80    	mov    0x80114d60,%ebx
8010331e:	83 fb 07             	cmp    $0x7,%ebx
80103321:	7f 1a                	jg     8010333d <mpinit+0x17d>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103323:	0f b6 42 01          	movzbl 0x1(%edx),%eax
80103327:	8d 3c 9b             	lea    (%ebx,%ebx,4),%edi
8010332a:	8d 3c 7b             	lea    (%ebx,%edi,2),%edi
        ncpu++;
8010332d:	43                   	inc    %ebx
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010332e:	c1 e7 04             	shl    $0x4,%edi
        ncpu++;
80103331:	89 1d 60 4d 11 80    	mov    %ebx,0x80114d60
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103337:	88 87 e0 47 11 80    	mov    %al,-0x7feeb820(%edi)
      p += sizeof(struct mpproc);
8010333d:	83 c2 14             	add    $0x14,%edx
      continue;
80103340:	e9 7b ff ff ff       	jmp    801032c0 <mpinit+0x100>
80103345:	8d 76 00             	lea    0x0(%esi),%esi
      ioapicid = ioapic->apicno;
80103348:	0f b6 42 01          	movzbl 0x1(%edx),%eax
      p += sizeof(struct mpioapic);
8010334c:	83 c2 08             	add    $0x8,%edx
      ioapicid = ioapic->apicno;
8010334f:	a2 c0 47 11 80       	mov    %al,0x801147c0
      continue;
80103354:	e9 67 ff ff ff       	jmp    801032c0 <mpinit+0x100>
80103359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return mpsearch1(0xF0000, 0x10000);
80103360:	ba 00 00 01 00       	mov    $0x10000,%edx
80103365:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010336a:	e8 d1 fd ff ff       	call   80103140 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010336f:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
80103371:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103374:	0f 85 97 fe ff ff    	jne    80103211 <mpinit+0x51>
8010337a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103380:	c7 04 24 cd 8c 10 80 	movl   $0x80108ccd,(%esp)
80103387:	e8 e4 cf ff ff       	call   80100370 <panic>
    panic("Didn't find a suitable machine");
8010338c:	c7 04 24 ec 8c 10 80 	movl   $0x80108cec,(%esp)
80103393:	e8 d8 cf ff ff       	call   80100370 <panic>
      ismp = 0;
80103398:	31 c9                	xor    %ecx,%ecx
8010339a:	e9 28 ff ff ff       	jmp    801032c7 <mpinit+0x107>
8010339f:	90                   	nop

801033a0 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801033a0:	55                   	push   %ebp
801033a1:	b0 ff                	mov    $0xff,%al
801033a3:	89 e5                	mov    %esp,%ebp
801033a5:	ba 21 00 00 00       	mov    $0x21,%edx
801033aa:	ee                   	out    %al,(%dx)
801033ab:	ba a1 00 00 00       	mov    $0xa1,%edx
801033b0:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801033b1:	5d                   	pop    %ebp
801033b2:	c3                   	ret    
801033b3:	66 90                	xchg   %ax,%ax
801033b5:	66 90                	xchg   %ax,%ax
801033b7:	66 90                	xchg   %ax,%ax
801033b9:	66 90                	xchg   %ax,%ax
801033bb:	66 90                	xchg   %ax,%ax
801033bd:	66 90                	xchg   %ax,%ax
801033bf:	90                   	nop

801033c0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801033c0:	55                   	push   %ebp
801033c1:	89 e5                	mov    %esp,%ebp
801033c3:	56                   	push   %esi
801033c4:	53                   	push   %ebx
801033c5:	83 ec 20             	sub    $0x20,%esp
801033c8:	8b 5d 08             	mov    0x8(%ebp),%ebx
801033cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801033ce:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801033d4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801033da:	e8 91 d9 ff ff       	call   80100d70 <filealloc>
801033df:	85 c0                	test   %eax,%eax
801033e1:	89 03                	mov    %eax,(%ebx)
801033e3:	74 1b                	je     80103400 <pipealloc+0x40>
801033e5:	e8 86 d9 ff ff       	call   80100d70 <filealloc>
801033ea:	85 c0                	test   %eax,%eax
801033ec:	89 06                	mov    %eax,(%esi)
801033ee:	74 30                	je     80103420 <pipealloc+0x60>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801033f0:	e8 bb f1 ff ff       	call   801025b0 <kalloc>
801033f5:	85 c0                	test   %eax,%eax
801033f7:	75 47                	jne    80103440 <pipealloc+0x80>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801033f9:	8b 03                	mov    (%ebx),%eax
801033fb:	85 c0                	test   %eax,%eax
801033fd:	75 27                	jne    80103426 <pipealloc+0x66>
801033ff:	90                   	nop
    fileclose(*f0);
  if(*f1)
80103400:	8b 06                	mov    (%esi),%eax
80103402:	85 c0                	test   %eax,%eax
80103404:	74 08                	je     8010340e <pipealloc+0x4e>
    fileclose(*f1);
80103406:	89 04 24             	mov    %eax,(%esp)
80103409:	e8 22 da ff ff       	call   80100e30 <fileclose>
  return -1;
}
8010340e:	83 c4 20             	add    $0x20,%esp
  return -1;
80103411:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103416:	5b                   	pop    %ebx
80103417:	5e                   	pop    %esi
80103418:	5d                   	pop    %ebp
80103419:	c3                   	ret    
8010341a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(*f0)
80103420:	8b 03                	mov    (%ebx),%eax
80103422:	85 c0                	test   %eax,%eax
80103424:	74 e8                	je     8010340e <pipealloc+0x4e>
    fileclose(*f0);
80103426:	89 04 24             	mov    %eax,(%esp)
80103429:	e8 02 da ff ff       	call   80100e30 <fileclose>
  if(*f1)
8010342e:	8b 06                	mov    (%esi),%eax
80103430:	85 c0                	test   %eax,%eax
80103432:	75 d2                	jne    80103406 <pipealloc+0x46>
80103434:	eb d8                	jmp    8010340e <pipealloc+0x4e>
80103436:	8d 76 00             	lea    0x0(%esi),%esi
80103439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  p->readopen = 1;
80103440:	ba 01 00 00 00       	mov    $0x1,%edx
  p->writeopen = 1;
80103445:	b9 01 00 00 00       	mov    $0x1,%ecx
  p->readopen = 1;
8010344a:	89 90 3c 02 00 00    	mov    %edx,0x23c(%eax)
  p->nwrite = 0;
80103450:	31 d2                	xor    %edx,%edx
  p->writeopen = 1;
80103452:	89 88 40 02 00 00    	mov    %ecx,0x240(%eax)
  p->nread = 0;
80103458:	31 c9                	xor    %ecx,%ecx
  p->nwrite = 0;
8010345a:	89 90 38 02 00 00    	mov    %edx,0x238(%eax)
  initlock(&p->lock, "pipe");
80103460:	ba 20 8d 10 80       	mov    $0x80108d20,%edx
  p->nread = 0;
80103465:	89 88 34 02 00 00    	mov    %ecx,0x234(%eax)
  initlock(&p->lock, "pipe");
8010346b:	89 54 24 04          	mov    %edx,0x4(%esp)
8010346f:	89 04 24             	mov    %eax,(%esp)
80103472:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103475:	e8 06 25 00 00       	call   80105980 <initlock>
  (*f0)->type = FD_PIPE;
8010347a:	8b 13                	mov    (%ebx),%edx
  (*f0)->pipe = p;
8010347c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  (*f0)->type = FD_PIPE;
8010347f:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
  (*f0)->readable = 1;
80103485:	8b 13                	mov    (%ebx),%edx
80103487:	c6 42 08 01          	movb   $0x1,0x8(%edx)
  (*f0)->writable = 0;
8010348b:	8b 13                	mov    (%ebx),%edx
8010348d:	c6 42 09 00          	movb   $0x0,0x9(%edx)
  (*f0)->pipe = p;
80103491:	8b 13                	mov    (%ebx),%edx
80103493:	89 42 0c             	mov    %eax,0xc(%edx)
  (*f1)->type = FD_PIPE;
80103496:	8b 16                	mov    (%esi),%edx
80103498:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
  (*f1)->readable = 0;
8010349e:	8b 16                	mov    (%esi),%edx
801034a0:	c6 42 08 00          	movb   $0x0,0x8(%edx)
  (*f1)->writable = 1;
801034a4:	8b 16                	mov    (%esi),%edx
801034a6:	c6 42 09 01          	movb   $0x1,0x9(%edx)
  (*f1)->pipe = p;
801034aa:	8b 16                	mov    (%esi),%edx
801034ac:	89 42 0c             	mov    %eax,0xc(%edx)
}
801034af:	83 c4 20             	add    $0x20,%esp
  return 0;
801034b2:	31 c0                	xor    %eax,%eax
}
801034b4:	5b                   	pop    %ebx
801034b5:	5e                   	pop    %esi
801034b6:	5d                   	pop    %ebp
801034b7:	c3                   	ret    
801034b8:	90                   	nop
801034b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801034c0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801034c0:	55                   	push   %ebp
801034c1:	89 e5                	mov    %esp,%ebp
801034c3:	83 ec 18             	sub    $0x18,%esp
801034c6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801034c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801034cc:	89 75 fc             	mov    %esi,-0x4(%ebp)
801034cf:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801034d2:	89 1c 24             	mov    %ebx,(%esp)
801034d5:	e8 f6 25 00 00       	call   80105ad0 <acquire>
  if(writable){
801034da:	85 f6                	test   %esi,%esi
801034dc:	74 42                	je     80103520 <pipeclose+0x60>
    p->writeopen = 0;
801034de:	31 f6                	xor    %esi,%esi
    wakeup(&p->nread);
801034e0:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
801034e6:	89 b3 40 02 00 00    	mov    %esi,0x240(%ebx)
    wakeup(&p->nread);
801034ec:	89 04 24             	mov    %eax,(%esp)
801034ef:	e8 9c 10 00 00       	call   80104590 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801034f4:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801034fa:	85 d2                	test   %edx,%edx
801034fc:	75 0a                	jne    80103508 <pipeclose+0x48>
801034fe:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103504:	85 c0                	test   %eax,%eax
80103506:	74 38                	je     80103540 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103508:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010350b:	8b 75 fc             	mov    -0x4(%ebp),%esi
8010350e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103511:	89 ec                	mov    %ebp,%esp
80103513:	5d                   	pop    %ebp
    release(&p->lock);
80103514:	e9 57 26 00 00       	jmp    80105b70 <release>
80103519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->readopen = 0;
80103520:	31 c9                	xor    %ecx,%ecx
    wakeup(&p->nwrite);
80103522:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103528:	89 8b 3c 02 00 00    	mov    %ecx,0x23c(%ebx)
    wakeup(&p->nwrite);
8010352e:	89 04 24             	mov    %eax,(%esp)
80103531:	e8 5a 10 00 00       	call   80104590 <wakeup>
80103536:	eb bc                	jmp    801034f4 <pipeclose+0x34>
80103538:	90                   	nop
80103539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103540:	89 1c 24             	mov    %ebx,(%esp)
80103543:	e8 28 26 00 00       	call   80105b70 <release>
}
80103548:	8b 75 fc             	mov    -0x4(%ebp),%esi
    kfree((char*)p);
8010354b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010354e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103551:	89 ec                	mov    %ebp,%esp
80103553:	5d                   	pop    %ebp
    kfree((char*)p);
80103554:	e9 87 ee ff ff       	jmp    801023e0 <kfree>
80103559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103560 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103560:	55                   	push   %ebp
80103561:	89 e5                	mov    %esp,%ebp
80103563:	57                   	push   %edi
80103564:	56                   	push   %esi
80103565:	53                   	push   %ebx
80103566:	83 ec 2c             	sub    $0x2c,%esp
80103569:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i;

  acquire(&p->lock);
8010356c:	89 3c 24             	mov    %edi,(%esp)
8010356f:	e8 5c 25 00 00       	call   80105ad0 <acquire>
  for(i = 0; i < n; i++){
80103574:	8b 75 10             	mov    0x10(%ebp),%esi
80103577:	85 f6                	test   %esi,%esi
80103579:	0f 8e c7 00 00 00    	jle    80103646 <pipewrite+0xe6>
8010357f:	8b 45 0c             	mov    0xc(%ebp),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103582:	8d b7 34 02 00 00    	lea    0x234(%edi),%esi
80103588:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010358b:	8b 8f 38 02 00 00    	mov    0x238(%edi),%ecx
80103591:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103594:	01 d8                	add    %ebx,%eax
80103596:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103599:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
8010359f:	05 00 02 00 00       	add    $0x200,%eax
801035a4:	39 c1                	cmp    %eax,%ecx
801035a6:	75 6c                	jne    80103614 <pipewrite+0xb4>
      if(p->readopen == 0 || myproc()->killed){
801035a8:	8b 87 3c 02 00 00    	mov    0x23c(%edi),%eax
801035ae:	85 c0                	test   %eax,%eax
801035b0:	74 4d                	je     801035ff <pipewrite+0x9f>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035b2:	8d 9f 38 02 00 00    	lea    0x238(%edi),%ebx
801035b8:	eb 39                	jmp    801035f3 <pipewrite+0x93>
801035ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
801035c0:	89 34 24             	mov    %esi,(%esp)
801035c3:	e8 c8 0f 00 00       	call   80104590 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035c8:	89 7c 24 04          	mov    %edi,0x4(%esp)
801035cc:	89 1c 24             	mov    %ebx,(%esp)
801035cf:	e8 bc 0d 00 00       	call   80104390 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035d4:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
801035da:	8b 97 38 02 00 00    	mov    0x238(%edi),%edx
801035e0:	05 00 02 00 00       	add    $0x200,%eax
801035e5:	39 c2                	cmp    %eax,%edx
801035e7:	75 37                	jne    80103620 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
801035e9:	8b 8f 3c 02 00 00    	mov    0x23c(%edi),%ecx
801035ef:	85 c9                	test   %ecx,%ecx
801035f1:	74 0c                	je     801035ff <pipewrite+0x9f>
801035f3:	e8 28 04 00 00       	call   80103a20 <myproc>
801035f8:	8b 50 24             	mov    0x24(%eax),%edx
801035fb:	85 d2                	test   %edx,%edx
801035fd:	74 c1                	je     801035c0 <pipewrite+0x60>
        release(&p->lock);
801035ff:	89 3c 24             	mov    %edi,(%esp)
80103602:	e8 69 25 00 00       	call   80105b70 <release>
        return -1;
80103607:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
8010360c:	83 c4 2c             	add    $0x2c,%esp
8010360f:	5b                   	pop    %ebx
80103610:	5e                   	pop    %esi
80103611:	5f                   	pop    %edi
80103612:	5d                   	pop    %ebp
80103613:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103614:	89 ca                	mov    %ecx,%edx
80103616:	8d 76 00             	lea    0x0(%esi),%esi
80103619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103620:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103623:	8d 4a 01             	lea    0x1(%edx),%ecx
80103626:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010362c:	89 8f 38 02 00 00    	mov    %ecx,0x238(%edi)
80103632:	0f b6 03             	movzbl (%ebx),%eax
80103635:	43                   	inc    %ebx
  for(i = 0; i < n; i++){
80103636:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
80103639:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010363c:	88 44 17 34          	mov    %al,0x34(%edi,%edx,1)
  for(i = 0; i < n; i++){
80103640:	0f 85 53 ff ff ff    	jne    80103599 <pipewrite+0x39>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103646:	8d 87 34 02 00 00    	lea    0x234(%edi),%eax
8010364c:	89 04 24             	mov    %eax,(%esp)
8010364f:	e8 3c 0f 00 00       	call   80104590 <wakeup>
  release(&p->lock);
80103654:	89 3c 24             	mov    %edi,(%esp)
80103657:	e8 14 25 00 00       	call   80105b70 <release>
  return n;
8010365c:	8b 45 10             	mov    0x10(%ebp),%eax
8010365f:	eb ab                	jmp    8010360c <pipewrite+0xac>
80103661:	eb 0d                	jmp    80103670 <piperead>
80103663:	90                   	nop
80103664:	90                   	nop
80103665:	90                   	nop
80103666:	90                   	nop
80103667:	90                   	nop
80103668:	90                   	nop
80103669:	90                   	nop
8010366a:	90                   	nop
8010366b:	90                   	nop
8010366c:	90                   	nop
8010366d:	90                   	nop
8010366e:	90                   	nop
8010366f:	90                   	nop

80103670 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103670:	55                   	push   %ebp
80103671:	89 e5                	mov    %esp,%ebp
80103673:	57                   	push   %edi
80103674:	56                   	push   %esi
80103675:	53                   	push   %ebx
80103676:	83 ec 1c             	sub    $0x1c,%esp
80103679:	8b 75 08             	mov    0x8(%ebp),%esi
8010367c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010367f:	89 34 24             	mov    %esi,(%esp)
80103682:	e8 49 24 00 00       	call   80105ad0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103687:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010368d:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103693:	75 6b                	jne    80103700 <piperead+0x90>
80103695:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010369b:	85 db                	test   %ebx,%ebx
8010369d:	0f 84 bd 00 00 00    	je     80103760 <piperead+0xf0>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801036a3:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801036a9:	eb 2d                	jmp    801036d8 <piperead+0x68>
801036ab:	90                   	nop
801036ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036b0:	89 74 24 04          	mov    %esi,0x4(%esp)
801036b4:	89 1c 24             	mov    %ebx,(%esp)
801036b7:	e8 d4 0c 00 00       	call   80104390 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036bc:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801036c2:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801036c8:	75 36                	jne    80103700 <piperead+0x90>
801036ca:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
801036d0:	85 d2                	test   %edx,%edx
801036d2:	0f 84 88 00 00 00    	je     80103760 <piperead+0xf0>
    if(myproc()->killed){
801036d8:	e8 43 03 00 00       	call   80103a20 <myproc>
801036dd:	8b 48 24             	mov    0x24(%eax),%ecx
801036e0:	85 c9                	test   %ecx,%ecx
801036e2:	74 cc                	je     801036b0 <piperead+0x40>
      release(&p->lock);
801036e4:	89 34 24             	mov    %esi,(%esp)
      return -1;
801036e7:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801036ec:	e8 7f 24 00 00       	call   80105b70 <release>
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801036f1:	83 c4 1c             	add    $0x1c,%esp
801036f4:	89 d8                	mov    %ebx,%eax
801036f6:	5b                   	pop    %ebx
801036f7:	5e                   	pop    %esi
801036f8:	5f                   	pop    %edi
801036f9:	5d                   	pop    %ebp
801036fa:	c3                   	ret    
801036fb:	90                   	nop
801036fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103700:	8b 45 10             	mov    0x10(%ebp),%eax
80103703:	85 c0                	test   %eax,%eax
80103705:	7e 59                	jle    80103760 <piperead+0xf0>
    if(p->nread == p->nwrite)
80103707:	31 db                	xor    %ebx,%ebx
80103709:	eb 13                	jmp    8010371e <piperead+0xae>
8010370b:	90                   	nop
8010370c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103710:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103716:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
8010371c:	74 1d                	je     8010373b <piperead+0xcb>
    addr[i] = p->data[p->nread++ % PIPESIZE];
8010371e:	8d 41 01             	lea    0x1(%ecx),%eax
80103721:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103727:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
8010372d:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
80103732:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103735:	43                   	inc    %ebx
80103736:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103739:	75 d5                	jne    80103710 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010373b:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103741:	89 04 24             	mov    %eax,(%esp)
80103744:	e8 47 0e 00 00       	call   80104590 <wakeup>
  release(&p->lock);
80103749:	89 34 24             	mov    %esi,(%esp)
8010374c:	e8 1f 24 00 00       	call   80105b70 <release>
}
80103751:	83 c4 1c             	add    $0x1c,%esp
80103754:	89 d8                	mov    %ebx,%eax
80103756:	5b                   	pop    %ebx
80103757:	5e                   	pop    %esi
80103758:	5f                   	pop    %edi
80103759:	5d                   	pop    %ebp
8010375a:	c3                   	ret    
8010375b:	90                   	nop
8010375c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103760:	31 db                	xor    %ebx,%ebx
80103762:	eb d7                	jmp    8010373b <piperead+0xcb>
80103764:	66 90                	xchg   %ax,%ax
80103766:	66 90                	xchg   %ax,%ax
80103768:	66 90                	xchg   %ax,%ax
8010376a:	66 90                	xchg   %ax,%ax
8010376c:	66 90                	xchg   %ax,%ax
8010376e:	66 90                	xchg   %ax,%ax

80103770 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103770:	55                   	push   %ebp
80103771:	89 e5                	mov    %esp,%ebp
80103773:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103774:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
{
80103779:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);
8010377c:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103783:	e8 48 23 00 00       	call   80105ad0 <acquire>
80103788:	eb 18                	jmp    801037a2 <allocproc+0x32>
8010378a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103790:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80103796:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
8010379c:	0f 83 7e 00 00 00    	jae    80103820 <allocproc+0xb0>
    if(p->state == UNUSED)
801037a2:	8b 43 0c             	mov    0xc(%ebx),%eax
801037a5:	85 c0                	test   %eax,%eax
801037a7:	75 e7                	jne    80103790 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801037a9:	a1 08 c0 10 80       	mov    0x8010c008,%eax
  p->state = EMBRYO;
801037ae:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
801037b5:	8d 50 01             	lea    0x1(%eax),%edx
801037b8:	89 43 10             	mov    %eax,0x10(%ebx)

  release(&ptable.lock);
801037bb:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
  p->pid = nextpid++;
801037c2:	89 15 08 c0 10 80    	mov    %edx,0x8010c008
  release(&ptable.lock);
801037c8:	e8 a3 23 00 00       	call   80105b70 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801037cd:	e8 de ed ff ff       	call   801025b0 <kalloc>
801037d2:	85 c0                	test   %eax,%eax
801037d4:	89 43 08             	mov    %eax,0x8(%ebx)
801037d7:	74 5d                	je     80103836 <allocproc+0xc6>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801037d9:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801037df:	b9 14 00 00 00       	mov    $0x14,%ecx
  sp -= sizeof *p->tf;
801037e4:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
801037e7:	ba 9f 6e 10 80       	mov    $0x80106e9f,%edx
  sp -= sizeof *p->context;
801037ec:	05 9c 0f 00 00       	add    $0xf9c,%eax
  *(uint*)sp = (uint)trapret;
801037f1:	89 50 14             	mov    %edx,0x14(%eax)
  memset(p->context, 0, sizeof *p->context);
801037f4:	31 d2                	xor    %edx,%edx
  p->context = (struct context*)sp;
801037f6:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801037f9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801037fd:	89 54 24 04          	mov    %edx,0x4(%esp)
80103801:	89 04 24             	mov    %eax,(%esp)
80103804:	e8 b7 23 00 00       	call   80105bc0 <memset>
  p->context->eip = (uint)forkret;
80103809:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010380c:	c7 40 10 50 38 10 80 	movl   $0x80103850,0x10(%eax)

  return p;
}
80103813:	83 c4 14             	add    $0x14,%esp
80103816:	89 d8                	mov    %ebx,%eax
80103818:	5b                   	pop    %ebx
80103819:	5d                   	pop    %ebp
8010381a:	c3                   	ret    
8010381b:	90                   	nop
8010381c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80103820:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
  return 0;
80103827:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103829:	e8 42 23 00 00       	call   80105b70 <release>
}
8010382e:	83 c4 14             	add    $0x14,%esp
80103831:	89 d8                	mov    %ebx,%eax
80103833:	5b                   	pop    %ebx
80103834:	5d                   	pop    %ebp
80103835:	c3                   	ret    
    p->state = UNUSED;
80103836:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
8010383d:	31 db                	xor    %ebx,%ebx
8010383f:	eb d2                	jmp    80103813 <allocproc+0xa3>
80103841:	eb 0d                	jmp    80103850 <forkret>
80103843:	90                   	nop
80103844:	90                   	nop
80103845:	90                   	nop
80103846:	90                   	nop
80103847:	90                   	nop
80103848:	90                   	nop
80103849:	90                   	nop
8010384a:	90                   	nop
8010384b:	90                   	nop
8010384c:	90                   	nop
8010384d:	90                   	nop
8010384e:	90                   	nop
8010384f:	90                   	nop

80103850 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103850:	55                   	push   %ebp
80103851:	89 e5                	mov    %esp,%ebp
80103853:	83 ec 18             	sub    $0x18,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103856:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
8010385d:	e8 0e 23 00 00       	call   80105b70 <release>

  if (first) {
80103862:	8b 15 00 c0 10 80    	mov    0x8010c000,%edx
80103868:	85 d2                	test   %edx,%edx
8010386a:	75 04                	jne    80103870 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010386c:	c9                   	leave  
8010386d:	c3                   	ret    
8010386e:	66 90                	xchg   %ax,%ax
    first = 0;
80103870:	31 c0                	xor    %eax,%eax
    iinit(ROOTDEV);
80103872:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    first = 0;
80103879:	a3 00 c0 10 80       	mov    %eax,0x8010c000
    iinit(ROOTDEV);
8010387e:	e8 2d dc ff ff       	call   801014b0 <iinit>
    initlog(ROOTDEV);
80103883:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010388a:	e8 61 f3 ff ff       	call   80102bf0 <initlog>
}
8010388f:	c9                   	leave  
80103890:	c3                   	ret    
80103891:	eb 0d                	jmp    801038a0 <getAccumulator>
80103893:	90                   	nop
80103894:	90                   	nop
80103895:	90                   	nop
80103896:	90                   	nop
80103897:	90                   	nop
80103898:	90                   	nop
80103899:	90                   	nop
8010389a:	90                   	nop
8010389b:	90                   	nop
8010389c:	90                   	nop
8010389d:	90                   	nop
8010389e:	90                   	nop
8010389f:	90                   	nop

801038a0 <getAccumulator>:
long long getAccumulator(struct proc *p) {
801038a0:	55                   	push   %ebp
801038a1:	89 e5                	mov    %esp,%ebp
	return p->accumulator;
801038a3:	8b 45 08             	mov    0x8(%ebp),%eax
}
801038a6:	5d                   	pop    %ebp
	return p->accumulator;
801038a7:	8b 90 84 00 00 00    	mov    0x84(%eax),%edx
801038ad:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
}
801038b3:	c3                   	ret    
801038b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801038ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801038c0 <getMinAccumulator>:
long long getMinAccumulator(){
801038c0:	55                   	push   %ebp
801038c1:	89 e5                	mov    %esp,%ebp
801038c3:	53                   	push   %ebx
801038c4:	83 ec 24             	sub    $0x24,%esp
  boolean a=pq.getMinAccumulator(&tmp1);
801038c7:	8d 45 e8             	lea    -0x18(%ebp),%eax
  long long tmp1=999999999999999,tmp2=999999999999999;
801038ca:	c7 45 e8 ff 7f c6 a4 	movl   $0xa4c67fff,-0x18(%ebp)
801038d1:	c7 45 ec 7e 8d 03 00 	movl   $0x38d7e,-0x14(%ebp)
801038d8:	c7 45 f0 ff 7f c6 a4 	movl   $0xa4c67fff,-0x10(%ebp)
801038df:	c7 45 f4 7e 8d 03 00 	movl   $0x38d7e,-0xc(%ebp)
  boolean a=pq.getMinAccumulator(&tmp1);
801038e6:	89 04 24             	mov    %eax,(%esp)
801038e9:	ff 15 ec c5 10 80    	call   *0x8010c5ec
801038ef:	89 c3                	mov    %eax,%ebx
  boolean b=rpholder.getMinAccumulator(&tmp2);
801038f1:	8d 45 f0             	lea    -0x10(%ebp),%eax
801038f4:	89 04 24             	mov    %eax,(%esp)
801038f7:	ff 15 d0 c5 10 80    	call   *0x8010c5d0
  if(a&&b){
801038fd:	85 db                	test   %ebx,%ebx
801038ff:	74 1f                	je     80103920 <getMinAccumulator+0x60>
80103901:	85 c0                	test   %eax,%eax
80103903:	74 1b                	je     80103920 <getMinAccumulator+0x60>
80103905:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80103908:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010390b:	8b 5d f0             	mov    -0x10(%ebp),%ebx
8010390e:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103911:	39 ca                	cmp    %ecx,%edx
80103913:	7d 1b                	jge    80103930 <getMinAccumulator+0x70>
}
80103915:	83 c4 24             	add    $0x24,%esp
80103918:	5b                   	pop    %ebx
80103919:	5d                   	pop    %ebp
8010391a:	c3                   	ret    
8010391b:	90                   	nop
8010391c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(a)
80103920:	85 db                	test   %ebx,%ebx
80103922:	75 1c                	jne    80103940 <getMinAccumulator+0x80>
          return tmp2;
80103924:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103927:	8b 55 f4             	mov    -0xc(%ebp),%edx
}
8010392a:	83 c4 24             	add    $0x24,%esp
8010392d:	5b                   	pop    %ebx
8010392e:	5d                   	pop    %ebp
8010392f:	c3                   	ret    
80103930:	7e 1e                	jle    80103950 <getMinAccumulator+0x90>
80103932:	83 c4 24             	add    $0x24,%esp
80103935:	89 d8                	mov    %ebx,%eax
80103937:	5b                   	pop    %ebx
80103938:	89 ca                	mov    %ecx,%edx
8010393a:	5d                   	pop    %ebp
8010393b:	c3                   	ret    
8010393c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          return tmp1;
80103940:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103943:	8b 55 ec             	mov    -0x14(%ebp),%edx
}
80103946:	83 c4 24             	add    $0x24,%esp
80103949:	5b                   	pop    %ebx
8010394a:	5d                   	pop    %ebp
8010394b:	c3                   	ret    
8010394c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103950:	39 d8                	cmp    %ebx,%eax
80103952:	76 c1                	jbe    80103915 <getMinAccumulator+0x55>
80103954:	eb dc                	jmp    80103932 <getMinAccumulator+0x72>
80103956:	8d 76 00             	lea    0x0(%esi),%esi
80103959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103960 <pinit>:
{
80103960:	55                   	push   %ebp
  initlock(&ptable.lock, "ptable");
80103961:	b8 25 8d 10 80       	mov    $0x80108d25,%eax
{
80103966:	89 e5                	mov    %esp,%ebp
80103968:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
8010396b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010396f:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103976:	e8 05 20 00 00       	call   80105980 <initlock>
}
8010397b:	c9                   	leave  
8010397c:	c3                   	ret    
8010397d:	8d 76 00             	lea    0x0(%esi),%esi

80103980 <mycpu>:
{
80103980:	55                   	push   %ebp
80103981:	89 e5                	mov    %esp,%ebp
80103983:	56                   	push   %esi
80103984:	53                   	push   %ebx
80103985:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103988:	9c                   	pushf  
80103989:	58                   	pop    %eax
  if(readeflags()&FL_IF)
8010398a:	f6 c4 02             	test   $0x2,%ah
8010398d:	75 5b                	jne    801039ea <mycpu+0x6a>
  apicid = lapicid();
8010398f:	e8 9c ee ff ff       	call   80102830 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103994:	8b 35 60 4d 11 80    	mov    0x80114d60,%esi
8010399a:	85 f6                	test   %esi,%esi
8010399c:	7e 40                	jle    801039de <mycpu+0x5e>
    if (cpus[i].apicid == apicid)
8010399e:	0f b6 15 e0 47 11 80 	movzbl 0x801147e0,%edx
801039a5:	39 d0                	cmp    %edx,%eax
801039a7:	74 2e                	je     801039d7 <mycpu+0x57>
801039a9:	b9 90 48 11 80       	mov    $0x80114890,%ecx
  for (i = 0; i < ncpu; ++i) {
801039ae:	31 d2                	xor    %edx,%edx
801039b0:	42                   	inc    %edx
801039b1:	39 f2                	cmp    %esi,%edx
801039b3:	74 29                	je     801039de <mycpu+0x5e>
    if (cpus[i].apicid == apicid)
801039b5:	0f b6 19             	movzbl (%ecx),%ebx
801039b8:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
801039be:	39 c3                	cmp    %eax,%ebx
801039c0:	75 ee                	jne    801039b0 <mycpu+0x30>
801039c2:	8d 04 92             	lea    (%edx,%edx,4),%eax
801039c5:	8d 04 42             	lea    (%edx,%eax,2),%eax
801039c8:	c1 e0 04             	shl    $0x4,%eax
801039cb:	05 e0 47 11 80       	add    $0x801147e0,%eax
}
801039d0:	83 c4 10             	add    $0x10,%esp
801039d3:	5b                   	pop    %ebx
801039d4:	5e                   	pop    %esi
801039d5:	5d                   	pop    %ebp
801039d6:	c3                   	ret    
    if (cpus[i].apicid == apicid)
801039d7:	b8 e0 47 11 80       	mov    $0x801147e0,%eax
      return &cpus[i];
801039dc:	eb f2                	jmp    801039d0 <mycpu+0x50>
  panic("unknown apicid\n");
801039de:	c7 04 24 2c 8d 10 80 	movl   $0x80108d2c,(%esp)
801039e5:	e8 86 c9 ff ff       	call   80100370 <panic>
    panic("mycpu called with interrupts enabled\n");
801039ea:	c7 04 24 20 8e 10 80 	movl   $0x80108e20,(%esp)
801039f1:	e8 7a c9 ff ff       	call   80100370 <panic>
801039f6:	8d 76 00             	lea    0x0(%esi),%esi
801039f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a00 <cpuid>:
cpuid() {
80103a00:	55                   	push   %ebp
80103a01:	89 e5                	mov    %esp,%ebp
80103a03:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103a06:	e8 75 ff ff ff       	call   80103980 <mycpu>
}
80103a0b:	c9                   	leave  
  return mycpu()-cpus;
80103a0c:	2d e0 47 11 80       	sub    $0x801147e0,%eax
80103a11:	c1 f8 04             	sar    $0x4,%eax
80103a14:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103a1a:	c3                   	ret    
80103a1b:	90                   	nop
80103a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103a20 <myproc>:
myproc(void) {
80103a20:	55                   	push   %ebp
80103a21:	89 e5                	mov    %esp,%ebp
80103a23:	53                   	push   %ebx
80103a24:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103a27:	e8 c4 1f 00 00       	call   801059f0 <pushcli>
  c = mycpu();
80103a2c:	e8 4f ff ff ff       	call   80103980 <mycpu>
  p = c->proc;
80103a31:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a37:	e8 f4 1f 00 00       	call   80105a30 <popcli>
}
80103a3c:	5a                   	pop    %edx
80103a3d:	89 d8                	mov    %ebx,%eax
80103a3f:	5b                   	pop    %ebx
80103a40:	5d                   	pop    %ebp
80103a41:	c3                   	ret    
80103a42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a50 <pushToSpecificQueue>:
    switch (currpolicy) {
80103a50:	a1 04 c0 10 80       	mov    0x8010c004,%eax
pushToSpecificQueue(struct proc* p) {
80103a55:	55                   	push   %ebp
80103a56:	89 e5                	mov    %esp,%ebp
    switch (currpolicy) {
80103a58:	83 f8 02             	cmp    $0x2,%eax
80103a5b:	74 13                	je     80103a70 <pushToSpecificQueue+0x20>
80103a5d:	83 f8 03             	cmp    $0x3,%eax
80103a60:	74 0e                	je     80103a70 <pushToSpecificQueue+0x20>
80103a62:	48                   	dec    %eax
80103a63:	74 1b                	je     80103a80 <pushToSpecificQueue+0x30>
}
80103a65:	5d                   	pop    %ebp
80103a66:	c3                   	ret    
80103a67:	89 f6                	mov    %esi,%esi
80103a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80103a70:	5d                   	pop    %ebp
            pq.put(p);
80103a71:	ff 25 e8 c5 10 80    	jmp    *0x8010c5e8
80103a77:	89 f6                	mov    %esi,%esi
80103a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80103a80:	5d                   	pop    %ebp
            rrq.enqueue(p);
80103a81:	ff 25 d8 c5 10 80    	jmp    *0x8010c5d8
80103a87:	89 f6                	mov    %esi,%esi
80103a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a90 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80103a90:	55                   	push   %ebp
80103a91:	89 e5                	mov    %esp,%ebp
80103a93:	56                   	push   %esi
80103a94:	89 c6                	mov    %eax,%esi
80103a96:	53                   	push   %ebx
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a97:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
{
80103a9c:	83 ec 10             	sub    $0x10,%esp
80103a9f:	eb 15                	jmp    80103ab6 <wakeup1+0x26>
80103aa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103aa8:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80103aae:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
80103ab4:	73 3d                	jae    80103af3 <wakeup1+0x63>
    if(p->state == SLEEPING && p->chan == chan){
80103ab6:	8b 53 0c             	mov    0xc(%ebx),%edx
80103ab9:	83 fa 02             	cmp    $0x2,%edx
80103abc:	75 ea                	jne    80103aa8 <wakeup1+0x18>
80103abe:	39 73 20             	cmp    %esi,0x20(%ebx)
80103ac1:	75 e5                	jne    80103aa8 <wakeup1+0x18>
        p->state = RUNNABLE;
        //TODO- roundrobin addition
        //rrq.enqueue(p);
        //TODO- priority queue addition
        p->accumulator+=p->priority;
80103ac3:	8b 83 88 00 00 00    	mov    0x88(%ebx),%eax
        p->state = RUNNABLE;
80103ac9:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
        //pq.put(p);
        pushToSpecificQueue(p);
80103ad0:	89 1c 24             	mov    %ebx,(%esp)
        p->accumulator+=p->priority;
80103ad3:	99                   	cltd   
80103ad4:	01 83 80 00 00 00    	add    %eax,0x80(%ebx)
80103ada:	11 93 84 00 00 00    	adc    %edx,0x84(%ebx)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ae0:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
        pushToSpecificQueue(p);
80103ae6:	e8 65 ff ff ff       	call   80103a50 <pushToSpecificQueue>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103aeb:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
80103af1:	72 c3                	jb     80103ab6 <wakeup1+0x26>
    }
}
80103af3:	83 c4 10             	add    $0x10,%esp
80103af6:	5b                   	pop    %ebx
80103af7:	5e                   	pop    %esi
80103af8:	5d                   	pop    %ebp
80103af9:	c3                   	ret    
80103afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103b00 <userinit>:
{
80103b00:	55                   	push   %ebp
80103b01:	89 e5                	mov    %esp,%ebp
80103b03:	53                   	push   %ebx
80103b04:	83 ec 14             	sub    $0x14,%esp
  p = allocproc();
80103b07:	e8 64 fc ff ff       	call   80103770 <allocproc>
80103b0c:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103b0e:	a3 c0 c5 10 80       	mov    %eax,0x8010c5c0
  if((p->pgdir = setupkvm()) == 0)
80103b13:	e8 b8 49 00 00       	call   801084d0 <setupkvm>
80103b18:	85 c0                	test   %eax,%eax
80103b1a:	89 43 04             	mov    %eax,0x4(%ebx)
80103b1d:	0f 84 31 01 00 00    	je     80103c54 <userinit+0x154>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103b23:	b9 60 c4 10 80       	mov    $0x8010c460,%ecx
80103b28:	ba 2c 00 00 00       	mov    $0x2c,%edx
80103b2d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80103b31:	89 54 24 08          	mov    %edx,0x8(%esp)
80103b35:	89 04 24             	mov    %eax,(%esp)
80103b38:	e8 63 46 00 00       	call   801081a0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103b3d:	b8 4c 00 00 00       	mov    $0x4c,%eax
  p->sz = PGSIZE;
80103b42:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103b48:	89 44 24 08          	mov    %eax,0x8(%esp)
80103b4c:	31 c0                	xor    %eax,%eax
80103b4e:	89 44 24 04          	mov    %eax,0x4(%esp)
80103b52:	8b 43 18             	mov    0x18(%ebx),%eax
80103b55:	89 04 24             	mov    %eax,(%esp)
80103b58:	e8 63 20 00 00       	call   80105bc0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103b5d:	8b 43 18             	mov    0x18(%ebx),%eax
80103b60:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103b66:	8b 43 18             	mov    0x18(%ebx),%eax
80103b69:	66 c7 40 2c 23 00    	movw   $0x23,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103b6f:	8b 43 18             	mov    0x18(%ebx),%eax
80103b72:	8b 50 2c             	mov    0x2c(%eax),%edx
80103b75:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103b79:	8b 43 18             	mov    0x18(%ebx),%eax
80103b7c:	8b 50 2c             	mov    0x2c(%eax),%edx
80103b7f:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103b83:	8b 43 18             	mov    0x18(%ebx),%eax
80103b86:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103b8d:	8b 43 18             	mov    0x18(%ebx),%eax
80103b90:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103b97:	8b 43 18             	mov    0x18(%ebx),%eax
80103b9a:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103ba1:	b8 10 00 00 00       	mov    $0x10,%eax
80103ba6:	89 44 24 08          	mov    %eax,0x8(%esp)
80103baa:	b8 55 8d 10 80       	mov    $0x80108d55,%eax
80103baf:	89 44 24 04          	mov    %eax,0x4(%esp)
80103bb3:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103bb6:	89 04 24             	mov    %eax,(%esp)
80103bb9:	e8 e2 21 00 00       	call   80105da0 <safestrcpy>
  p->cwd = namei("/");
80103bbe:	c7 04 24 5e 8d 10 80 	movl   $0x80108d5e,(%esp)
80103bc5:	e8 06 e4 ff ff       	call   80101fd0 <namei>
80103bca:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103bcd:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103bd4:	e8 f7 1e 00 00       	call   80105ad0 <acquire>
  p->state = RUNNABLE;
80103bd9:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  if(currpolicy==1)
80103be0:	a1 04 c0 10 80       	mov    0x8010c004,%eax
80103be5:	48                   	dec    %eax
80103be6:	75 09                	jne    80103bf1 <userinit+0xf1>
    rrq.enqueue(p);
80103be8:	89 1c 24             	mov    %ebx,(%esp)
80103beb:	ff 15 d8 c5 10 80    	call   *0x8010c5d8
  p->priority=5;
80103bf1:	b8 05 00 00 00       	mov    $0x5,%eax
  p->RUNNABLE_wait_time=0; //surely 0 because this is the first initialized process
80103bf6:	31 d2                	xor    %edx,%edx
  p->priority=5;
80103bf8:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)
  p->accumulator=0; //is surely 0 because this is the first initialized process
80103bfe:	31 c0                	xor    %eax,%eax
  p->RUNNABLE_wait_time=0; //surely 0 because this is the first initialized process
80103c00:	31 c9                	xor    %ecx,%ecx
  p->accumulator=0; //is surely 0 because this is the first initialized process
80103c02:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
80103c08:	31 c0                	xor    %eax,%eax
80103c0a:	89 83 84 00 00 00    	mov    %eax,0x84(%ebx)
  if(currpolicy==2 || currpolicy==3)
80103c10:	a1 04 c0 10 80       	mov    0x8010c004,%eax
  p->RUNNABLE_wait_time=0; //surely 0 because this is the first initialized process
80103c15:	89 93 a0 00 00 00    	mov    %edx,0xa0(%ebx)
80103c1b:	89 8b a4 00 00 00    	mov    %ecx,0xa4(%ebx)
  if(currpolicy==2 || currpolicy==3)
80103c21:	83 f8 02             	cmp    $0x2,%eax
80103c24:	75 22                	jne    80103c48 <userinit+0x148>
    pq.put(p);
80103c26:	89 1c 24             	mov    %ebx,(%esp)
80103c29:	ff 15 e8 c5 10 80    	call   *0x8010c5e8
  release(&ptable.lock);
80103c2f:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103c36:	e8 35 1f 00 00       	call   80105b70 <release>
}
80103c3b:	83 c4 14             	add    $0x14,%esp
80103c3e:	5b                   	pop    %ebx
80103c3f:	5d                   	pop    %ebp
80103c40:	c3                   	ret    
80103c41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(currpolicy==2 || currpolicy==3)
80103c48:	a1 04 c0 10 80       	mov    0x8010c004,%eax
80103c4d:	83 f8 03             	cmp    $0x3,%eax
80103c50:	75 dd                	jne    80103c2f <userinit+0x12f>
80103c52:	eb d2                	jmp    80103c26 <userinit+0x126>
    panic("userinit: out of memory?");
80103c54:	c7 04 24 3c 8d 10 80 	movl   $0x80108d3c,(%esp)
80103c5b:	e8 10 c7 ff ff       	call   80100370 <panic>

80103c60 <growproc>:
{
80103c60:	55                   	push   %ebp
80103c61:	89 e5                	mov    %esp,%ebp
80103c63:	56                   	push   %esi
80103c64:	53                   	push   %ebx
80103c65:	83 ec 10             	sub    $0x10,%esp
80103c68:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103c6b:	e8 80 1d 00 00       	call   801059f0 <pushcli>
  c = mycpu();
80103c70:	e8 0b fd ff ff       	call   80103980 <mycpu>
  p = c->proc;
80103c75:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c7b:	e8 b0 1d 00 00       	call   80105a30 <popcli>
  if(n > 0){
80103c80:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103c83:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103c85:	7f 19                	jg     80103ca0 <growproc+0x40>
  } else if(n < 0){
80103c87:	75 37                	jne    80103cc0 <growproc+0x60>
  curproc->sz = sz;
80103c89:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103c8b:	89 1c 24             	mov    %ebx,(%esp)
80103c8e:	e8 0d 44 00 00       	call   801080a0 <switchuvm>
  return 0;
80103c93:	31 c0                	xor    %eax,%eax
}
80103c95:	83 c4 10             	add    $0x10,%esp
80103c98:	5b                   	pop    %ebx
80103c99:	5e                   	pop    %esi
80103c9a:	5d                   	pop    %ebp
80103c9b:	c3                   	ret    
80103c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103ca0:	01 c6                	add    %eax,%esi
80103ca2:	89 74 24 08          	mov    %esi,0x8(%esp)
80103ca6:	89 44 24 04          	mov    %eax,0x4(%esp)
80103caa:	8b 43 04             	mov    0x4(%ebx),%eax
80103cad:	89 04 24             	mov    %eax,(%esp)
80103cb0:	e8 3b 46 00 00       	call   801082f0 <allocuvm>
80103cb5:	85 c0                	test   %eax,%eax
80103cb7:	75 d0                	jne    80103c89 <growproc+0x29>
      return -1;
80103cb9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103cbe:	eb d5                	jmp    80103c95 <growproc+0x35>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103cc0:	01 c6                	add    %eax,%esi
80103cc2:	89 74 24 08          	mov    %esi,0x8(%esp)
80103cc6:	89 44 24 04          	mov    %eax,0x4(%esp)
80103cca:	8b 43 04             	mov    0x4(%ebx),%eax
80103ccd:	89 04 24             	mov    %eax,(%esp)
80103cd0:	e8 4b 47 00 00       	call   80108420 <deallocuvm>
80103cd5:	85 c0                	test   %eax,%eax
80103cd7:	75 b0                	jne    80103c89 <growproc+0x29>
80103cd9:	eb de                	jmp    80103cb9 <growproc+0x59>
80103cdb:	90                   	nop
80103cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103ce0 <fork>:
{
80103ce0:	55                   	push   %ebp
80103ce1:	89 e5                	mov    %esp,%ebp
80103ce3:	57                   	push   %edi
80103ce4:	56                   	push   %esi
80103ce5:	53                   	push   %ebx
80103ce6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103ce9:	e8 02 1d 00 00       	call   801059f0 <pushcli>
  c = mycpu();
80103cee:	e8 8d fc ff ff       	call   80103980 <mycpu>
  p = c->proc;
80103cf3:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
80103cf9:	e8 32 1d 00 00       	call   80105a30 <popcli>
  if((np = allocproc()) == 0){
80103cfe:	e8 6d fa ff ff       	call   80103770 <allocproc>
80103d03:	85 c0                	test   %eax,%eax
80103d05:	0f 84 28 01 00 00    	je     80103e33 <fork+0x153>
80103d0b:	89 c6                	mov    %eax,%esi
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103d0d:	8b 07                	mov    (%edi),%eax
80103d0f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103d13:	8b 47 04             	mov    0x4(%edi),%eax
80103d16:	89 04 24             	mov    %eax,(%esp)
80103d19:	e8 82 48 00 00       	call   801085a0 <copyuvm>
80103d1e:	85 c0                	test   %eax,%eax
80103d20:	89 46 04             	mov    %eax,0x4(%esi)
80103d23:	0f 84 11 01 00 00    	je     80103e3a <fork+0x15a>
  np->sz = curproc->sz;
80103d29:	8b 07                	mov    (%edi),%eax
  np->parent = curproc;
80103d2b:	89 7e 14             	mov    %edi,0x14(%esi)
  *np->tf = *curproc->tf;
80103d2e:	8b 56 18             	mov    0x18(%esi),%edx
  np->sz = curproc->sz;
80103d31:	89 06                	mov    %eax,(%esi)
  *np->tf = *curproc->tf;
80103d33:	31 c0                	xor    %eax,%eax
80103d35:	8b 4f 18             	mov    0x18(%edi),%ecx
80103d38:	8b 1c 01             	mov    (%ecx,%eax,1),%ebx
80103d3b:	89 1c 02             	mov    %ebx,(%edx,%eax,1)
80103d3e:	83 c0 04             	add    $0x4,%eax
80103d41:	83 f8 4c             	cmp    $0x4c,%eax
80103d44:	72 f2                	jb     80103d38 <fork+0x58>
  np->tf->eax = 0;
80103d46:	8b 46 18             	mov    0x18(%esi),%eax
  for(i = 0; i < NOFILE; i++)
80103d49:	31 db                	xor    %ebx,%ebx
  np->tf->eax = 0;
80103d4b:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103d52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(curproc->ofile[i])
80103d60:	8b 44 9f 28          	mov    0x28(%edi,%ebx,4),%eax
80103d64:	85 c0                	test   %eax,%eax
80103d66:	74 0c                	je     80103d74 <fork+0x94>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103d68:	89 04 24             	mov    %eax,(%esp)
80103d6b:	e8 70 d0 ff ff       	call   80100de0 <filedup>
80103d70:	89 44 9e 28          	mov    %eax,0x28(%esi,%ebx,4)
  for(i = 0; i < NOFILE; i++)
80103d74:	43                   	inc    %ebx
80103d75:	83 fb 10             	cmp    $0x10,%ebx
80103d78:	75 e6                	jne    80103d60 <fork+0x80>
  np->cwd = idup(curproc->cwd);
80103d7a:	8b 47 68             	mov    0x68(%edi),%eax
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d7d:	83 c7 6c             	add    $0x6c,%edi
  np->cwd = idup(curproc->cwd);
80103d80:	89 04 24             	mov    %eax,(%esp)
80103d83:	e8 38 d9 ff ff       	call   801016c0 <idup>
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d88:	b9 10 00 00 00       	mov    $0x10,%ecx
  np->cwd = idup(curproc->cwd);
80103d8d:	89 46 68             	mov    %eax,0x68(%esi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d90:	8d 46 6c             	lea    0x6c(%esi),%eax
80103d93:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80103d97:	89 7c 24 04          	mov    %edi,0x4(%esp)
  np->priority=5;
80103d9b:	bf 05 00 00 00       	mov    $0x5,%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103da0:	89 04 24             	mov    %eax,(%esp)
80103da3:	e8 f8 1f 00 00       	call   80105da0 <safestrcpy>
  pid = np->pid;
80103da8:	8b 5e 10             	mov    0x10(%esi),%ebx
  acquire(&ptable.lock);
80103dab:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103db2:	e8 19 1d 00 00       	call   80105ad0 <acquire>
  np->state = RUNNABLE;
80103db7:	c7 46 0c 03 00 00 00 	movl   $0x3,0xc(%esi)
  np->RUNNABLE_wait_time=counter;
80103dbe:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
80103dc3:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
  np->priority=5;
80103dc9:	89 be 88 00 00 00    	mov    %edi,0x88(%esi)
  np->RUNNABLE_wait_time=counter;
80103dcf:	89 86 a0 00 00 00    	mov    %eax,0xa0(%esi)
80103dd5:	89 96 a4 00 00 00    	mov    %edx,0xa4(%esi)
  if(pq.isEmpty()&&rpholder.isEmpty()) //if the only process -> acc=0
80103ddb:	ff 15 e4 c5 10 80    	call   *0x8010c5e4
80103de1:	85 c0                	test   %eax,%eax
80103de3:	74 3b                	je     80103e20 <fork+0x140>
80103de5:	ff 15 c4 c5 10 80    	call   *0x8010c5c4
80103deb:	85 c0                	test   %eax,%eax
80103ded:	8d 76 00             	lea    0x0(%esi),%esi
80103df0:	74 2e                	je     80103e20 <fork+0x140>
    np->accumulator=0;
80103df2:	31 c0                	xor    %eax,%eax
80103df4:	31 d2                	xor    %edx,%edx
80103df6:	89 86 80 00 00 00    	mov    %eax,0x80(%esi)
80103dfc:	89 96 84 00 00 00    	mov    %edx,0x84(%esi)
  pushToSpecificQueue(np);
80103e02:	89 34 24             	mov    %esi,(%esp)
80103e05:	e8 46 fc ff ff       	call   80103a50 <pushToSpecificQueue>
  release(&ptable.lock);
80103e0a:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103e11:	e8 5a 1d 00 00       	call   80105b70 <release>
}
80103e16:	83 c4 1c             	add    $0x1c,%esp
80103e19:	89 d8                	mov    %ebx,%eax
80103e1b:	5b                   	pop    %ebx
80103e1c:	5e                   	pop    %esi
80103e1d:	5f                   	pop    %edi
80103e1e:	5d                   	pop    %ebp
80103e1f:	c3                   	ret    
    np->accumulator=getMinAccumulator();
80103e20:	e8 9b fa ff ff       	call   801038c0 <getMinAccumulator>
80103e25:	89 86 80 00 00 00    	mov    %eax,0x80(%esi)
80103e2b:	89 96 84 00 00 00    	mov    %edx,0x84(%esi)
80103e31:	eb cf                	jmp    80103e02 <fork+0x122>
    return -1;
80103e33:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103e38:	eb dc                	jmp    80103e16 <fork+0x136>
    kfree(np->kstack);
80103e3a:	8b 46 08             	mov    0x8(%esi),%eax
    return -1;
80103e3d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    kfree(np->kstack);
80103e42:	89 04 24             	mov    %eax,(%esp)
80103e45:	e8 96 e5 ff ff       	call   801023e0 <kfree>
    np->kstack = 0;
80103e4a:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
    np->state = UNUSED;
80103e51:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    return -1;
80103e58:	eb bc                	jmp    80103e16 <fork+0x136>
80103e5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103e60 <scheduler>:
{
80103e60:	55                   	push   %ebp
80103e61:	89 e5                	mov    %esp,%ebp
80103e63:	57                   	push   %edi
80103e64:	56                   	push   %esi
80103e65:	53                   	push   %ebx
80103e66:	83 ec 2c             	sub    $0x2c,%esp
  struct cpu *c = mycpu();
80103e69:	e8 12 fb ff ff       	call   80103980 <mycpu>
  struct proc *max_p=ptable.proc; //just a dummy initialized value to compiled
80103e6e:	c7 45 e4 b4 4d 11 80 	movl   $0x80114db4,-0x1c(%ebp)
  struct cpu *c = mycpu();
80103e75:	89 c3                	mov    %eax,%ebx
    c->proc = 0;
80103e77:	31 c0                	xor    %eax,%eax
80103e79:	89 83 ac 00 00 00    	mov    %eax,0xac(%ebx)
80103e7f:	8d 73 04             	lea    0x4(%ebx),%esi
80103e82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  asm volatile("sti");
80103e90:	fb                   	sti    
    acquire(&ptable.lock);
80103e91:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103e98:	e8 33 1c 00 00       	call   80105ad0 <acquire>
    counter++;
80103e9d:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
80103ea2:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
80103ea8:	83 c0 01             	add    $0x1,%eax
80103eab:	83 d2 00             	adc    $0x0,%edx
80103eae:	a3 b8 c5 10 80       	mov    %eax,0x8010c5b8
80103eb3:	89 15 bc c5 10 80    	mov    %edx,0x8010c5bc
    switch (currpolicy) {
80103eb9:	a1 04 c0 10 80       	mov    0x8010c004,%eax
80103ebe:	83 f8 02             	cmp    $0x2,%eax
80103ec1:	0f 84 69 01 00 00    	je     80104030 <scheduler+0x1d0>
80103ec7:	83 f8 03             	cmp    $0x3,%eax
80103eca:	0f 84 e0 00 00 00    	je     80103fb0 <scheduler+0x150>
80103ed0:	48                   	dec    %eax
            for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103ed1:	bf b4 4d 11 80       	mov    $0x80114db4,%edi
    switch (currpolicy) {
80103ed6:	74 70                	je     80103f48 <scheduler+0xe8>
80103ed8:	90                   	nop
80103ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                if (p->state != RUNNABLE)
80103ee0:	8b 47 0c             	mov    0xc(%edi),%eax
80103ee3:	83 f8 03             	cmp    $0x3,%eax
80103ee6:	75 3a                	jne    80103f22 <scheduler+0xc2>
                c->proc = p;
80103ee8:	89 bb ac 00 00 00    	mov    %edi,0xac(%ebx)
                switchuvm(p);
80103eee:	89 3c 24             	mov    %edi,(%esp)
80103ef1:	e8 aa 41 00 00       	call   801080a0 <switchuvm>
                p->state = RUNNING;
80103ef6:	c7 47 0c 04 00 00 00 	movl   $0x4,0xc(%edi)
                rpholder.add(p);
80103efd:	89 3c 24             	mov    %edi,(%esp)
80103f00:	ff 15 c8 c5 10 80    	call   *0x8010c5c8
                swtch(&(c->scheduler), p->context);
80103f06:	8b 47 1c             	mov    0x1c(%edi),%eax
80103f09:	89 34 24             	mov    %esi,(%esp)
80103f0c:	89 44 24 04          	mov    %eax,0x4(%esp)
80103f10:	e8 e4 1e 00 00       	call   80105df9 <swtch>
                switchkvm();
80103f15:	e8 66 41 00 00       	call   80108080 <switchkvm>
                c->proc = 0;
80103f1a:	31 c0                	xor    %eax,%eax
80103f1c:	89 83 ac 00 00 00    	mov    %eax,0xac(%ebx)
            for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103f22:	81 c7 a8 00 00 00    	add    $0xa8,%edi
80103f28:	81 ff b4 77 11 80    	cmp    $0x801177b4,%edi
80103f2e:	72 b0                	jb     80103ee0 <scheduler+0x80>
      release(&ptable.lock);
80103f30:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103f37:	e8 34 1c 00 00       	call   80105b70 <release>
    sti();
80103f3c:	e9 4f ff ff ff       	jmp    80103e90 <scheduler+0x30>
80103f41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            if (!rrq.isEmpty()) {
80103f48:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
80103f4e:	85 c0                	test   %eax,%eax
80103f50:	75 de                	jne    80103f30 <scheduler+0xd0>
                p = rrq.dequeue();
80103f52:	ff 15 dc c5 10 80    	call   *0x8010c5dc
                if (p != null) {
80103f58:	85 c0                	test   %eax,%eax
                p = rrq.dequeue();
80103f5a:	89 c7                	mov    %eax,%edi
                if (p != null) {
80103f5c:	74 d2                	je     80103f30 <scheduler+0xd0>
                    c->proc = p;
80103f5e:	89 bb ac 00 00 00    	mov    %edi,0xac(%ebx)
                    switchuvm(p);
80103f64:	89 3c 24             	mov    %edi,(%esp)
80103f67:	e8 34 41 00 00       	call   801080a0 <switchuvm>
                    p->state = RUNNING;
80103f6c:	c7 47 0c 04 00 00 00 	movl   $0x4,0xc(%edi)
                    rpholder.add(p);
80103f73:	89 3c 24             	mov    %edi,(%esp)
80103f76:	ff 15 c8 c5 10 80    	call   *0x8010c5c8
                    swtch(&(c->scheduler), p->context);
80103f7c:	8b 47 1c             	mov    0x1c(%edi),%eax
80103f7f:	89 34 24             	mov    %esi,(%esp)
80103f82:	89 44 24 04          	mov    %eax,0x4(%esp)
80103f86:	e8 6e 1e 00 00       	call   80105df9 <swtch>
                    switchkvm();
80103f8b:	e8 f0 40 00 00       	call   80108080 <switchkvm>
                    c->proc = 0;
80103f90:	31 d2                	xor    %edx,%edx
80103f92:	89 93 ac 00 00 00    	mov    %edx,0xac(%ebx)
      release(&ptable.lock);
80103f98:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103f9f:	e8 cc 1b 00 00       	call   80105b70 <release>
80103fa4:	e9 e7 fe ff ff       	jmp    80103e90 <scheduler+0x30>
80103fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            if (!pq.isEmpty()) {
80103fb0:	ff 15 e4 c5 10 80    	call   *0x8010c5e4
80103fb6:	85 c0                	test   %eax,%eax
80103fb8:	0f 85 72 ff ff ff    	jne    80103f30 <scheduler+0xd0>
                if( counter % 100 == 0)
80103fbe:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
80103fc3:	b9 64 00 00 00       	mov    $0x64,%ecx
80103fc8:	31 ff                	xor    %edi,%edi
80103fca:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
80103fd0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80103fd4:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80103fd8:	89 04 24             	mov    %eax,(%esp)
80103fdb:	89 54 24 04          	mov    %edx,0x4(%esp)
80103fdf:	e8 9c 17 00 00       	call   80105780 <__moddi3>
80103fe4:	09 c2                	or     %eax,%edx
80103fe6:	74 79                	je     80104061 <scheduler+0x201>
                    p = pq.extractMin();
80103fe8:	ff 15 f0 c5 10 80    	call   *0x8010c5f0
80103fee:	89 c7                	mov    %eax,%edi
                if (p != null) {
80103ff0:	85 ff                	test   %edi,%edi
80103ff2:	0f 84 38 ff ff ff    	je     80103f30 <scheduler+0xd0>
                    c->proc = p;
80103ff8:	89 bb ac 00 00 00    	mov    %edi,0xac(%ebx)
                    switchuvm(p);
80103ffe:	89 3c 24             	mov    %edi,(%esp)
80104001:	e8 9a 40 00 00       	call   801080a0 <switchuvm>
                    p->state = RUNNING;
80104006:	c7 47 0c 04 00 00 00 	movl   $0x4,0xc(%edi)
                    p->RUNNABLE_wait_time=counter;
8010400d:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
80104012:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
80104018:	89 87 a0 00 00 00    	mov    %eax,0xa0(%edi)
8010401e:	89 97 a4 00 00 00    	mov    %edx,0xa4(%edi)
80104024:	e9 4a ff ff ff       	jmp    80103f73 <scheduler+0x113>
80104029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            if (!pq.isEmpty()) {
80104030:	ff 15 e4 c5 10 80    	call   *0x8010c5e4
80104036:	85 c0                	test   %eax,%eax
80104038:	0f 85 f2 fe ff ff    	jne    80103f30 <scheduler+0xd0>
8010403e:	66 90                	xchg   %ax,%ax
                p = pq.extractMin();
80104040:	ff 15 f0 c5 10 80    	call   *0x8010c5f0
                if (p != null) {
80104046:	85 c0                	test   %eax,%eax
                p = pq.extractMin();
80104048:	89 c7                	mov    %eax,%edi
                if (p != null) {
8010404a:	0f 85 0e ff ff ff    	jne    80103f5e <scheduler+0xfe>
      release(&ptable.lock);
80104050:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104057:	e8 14 1b 00 00       	call   80105b70 <release>
8010405c:	e9 2f fe ff ff       	jmp    80103e90 <scheduler+0x30>
                    long long min = counter;
80104061:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
80104066:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
                    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
8010406c:	89 5d e0             	mov    %ebx,-0x20(%ebp)
                    long long min = counter;
8010406f:	89 d1                	mov    %edx,%ecx
80104071:	89 c2                	mov    %eax,%edx
                    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104073:	89 cb                	mov    %ecx,%ebx
80104075:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
8010407a:	89 d1                	mov    %edx,%ecx
8010407c:	eb 0e                	jmp    8010408c <scheduler+0x22c>
8010407e:	66 90                	xchg   %ax,%ax
80104080:	05 a8 00 00 00       	add    $0xa8,%eax
80104085:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
8010408a:	73 31                	jae    801040bd <scheduler+0x25d>
                        if ((p->state == RUNNABLE) && (p->RUNNABLE_wait_time < min)){
8010408c:	8b 50 0c             	mov    0xc(%eax),%edx
8010408f:	83 fa 03             	cmp    $0x3,%edx
80104092:	75 ec                	jne    80104080 <scheduler+0x220>
80104094:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
8010409a:	8b b8 a0 00 00 00    	mov    0xa0(%eax),%edi
801040a0:	39 da                	cmp    %ebx,%edx
801040a2:	7f dc                	jg     80104080 <scheduler+0x220>
801040a4:	7c 04                	jl     801040aa <scheduler+0x24a>
801040a6:	39 cf                	cmp    %ecx,%edi
801040a8:	73 d6                	jae    80104080 <scheduler+0x220>
801040aa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801040ad:	05 a8 00 00 00       	add    $0xa8,%eax
                        if ((p->state == RUNNABLE) && (p->RUNNABLE_wait_time < min)){
801040b2:	89 f9                	mov    %edi,%ecx
                    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801040b4:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
                        if ((p->state == RUNNABLE) && (p->RUNNABLE_wait_time < min)){
801040b9:	89 d3                	mov    %edx,%ebx
                    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801040bb:	72 cf                	jb     8010408c <scheduler+0x22c>
                    pq.extractProc(max_p);
801040bd:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801040c0:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801040c3:	89 3c 24             	mov    %edi,(%esp)
801040c6:	ff 15 f8 c5 10 80    	call   *0x8010c5f8
801040cc:	e9 1f ff ff ff       	jmp    80103ff0 <scheduler+0x190>
801040d1:	eb 0d                	jmp    801040e0 <sched>
801040d3:	90                   	nop
801040d4:	90                   	nop
801040d5:	90                   	nop
801040d6:	90                   	nop
801040d7:	90                   	nop
801040d8:	90                   	nop
801040d9:	90                   	nop
801040da:	90                   	nop
801040db:	90                   	nop
801040dc:	90                   	nop
801040dd:	90                   	nop
801040de:	90                   	nop
801040df:	90                   	nop

801040e0 <sched>:
{
801040e0:	55                   	push   %ebp
801040e1:	89 e5                	mov    %esp,%ebp
801040e3:	56                   	push   %esi
801040e4:	53                   	push   %ebx
801040e5:	83 ec 10             	sub    $0x10,%esp
  pushcli();
801040e8:	e8 03 19 00 00       	call   801059f0 <pushcli>
  c = mycpu();
801040ed:	e8 8e f8 ff ff       	call   80103980 <mycpu>
  p = c->proc;
801040f2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801040f8:	e8 33 19 00 00       	call   80105a30 <popcli>
  if(!holding(&ptable.lock))
801040fd:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104104:	e8 87 19 00 00       	call   80105a90 <holding>
80104109:	85 c0                	test   %eax,%eax
8010410b:	74 51                	je     8010415e <sched+0x7e>
  if(mycpu()->ncli != 1)
8010410d:	e8 6e f8 ff ff       	call   80103980 <mycpu>
80104112:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80104119:	75 67                	jne    80104182 <sched+0xa2>
  if(p->state == RUNNING)
8010411b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010411e:	83 f8 04             	cmp    $0x4,%eax
80104121:	74 53                	je     80104176 <sched+0x96>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104123:	9c                   	pushf  
80104124:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104125:	f6 c4 02             	test   $0x2,%ah
80104128:	75 40                	jne    8010416a <sched+0x8a>
  intena = mycpu()->intena;
8010412a:	e8 51 f8 ff ff       	call   80103980 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
8010412f:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104132:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104138:	e8 43 f8 ff ff       	call   80103980 <mycpu>
8010413d:	8b 40 04             	mov    0x4(%eax),%eax
80104140:	89 1c 24             	mov    %ebx,(%esp)
80104143:	89 44 24 04          	mov    %eax,0x4(%esp)
80104147:	e8 ad 1c 00 00       	call   80105df9 <swtch>
  mycpu()->intena = intena;
8010414c:	e8 2f f8 ff ff       	call   80103980 <mycpu>
80104151:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104157:	83 c4 10             	add    $0x10,%esp
8010415a:	5b                   	pop    %ebx
8010415b:	5e                   	pop    %esi
8010415c:	5d                   	pop    %ebp
8010415d:	c3                   	ret    
    panic("sched ptable.lock");
8010415e:	c7 04 24 60 8d 10 80 	movl   $0x80108d60,(%esp)
80104165:	e8 06 c2 ff ff       	call   80100370 <panic>
    panic("sched interruptible");
8010416a:	c7 04 24 8c 8d 10 80 	movl   $0x80108d8c,(%esp)
80104171:	e8 fa c1 ff ff       	call   80100370 <panic>
    panic("sched running");
80104176:	c7 04 24 7e 8d 10 80 	movl   $0x80108d7e,(%esp)
8010417d:	e8 ee c1 ff ff       	call   80100370 <panic>
    panic("sched locks");
80104182:	c7 04 24 72 8d 10 80 	movl   $0x80108d72,(%esp)
80104189:	e8 e2 c1 ff ff       	call   80100370 <panic>
8010418e:	66 90                	xchg   %ax,%ax

80104190 <exit>:
{
80104190:	55                   	push   %ebp
80104191:	89 e5                	mov    %esp,%ebp
80104193:	57                   	push   %edi
80104194:	56                   	push   %esi
80104195:	53                   	push   %ebx
80104196:	83 ec 1c             	sub    $0x1c,%esp
80104199:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
8010419c:	e8 4f 18 00 00       	call   801059f0 <pushcli>
  c = mycpu();
801041a1:	e8 da f7 ff ff       	call   80103980 <mycpu>
  p = c->proc;
801041a6:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801041ac:	e8 7f 18 00 00       	call   80105a30 <popcli>
  cprintf("**exit** status=  %d\t curproc->exit_status=  %d\n",status,curproc->exit_status);
801041b1:	8b 46 7c             	mov    0x7c(%esi),%eax
801041b4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801041b8:	c7 04 24 48 8e 10 80 	movl   $0x80108e48,(%esp)
801041bf:	89 44 24 08          	mov    %eax,0x8(%esp)
801041c3:	e8 88 c4 ff ff       	call   80100650 <cprintf>
    if(curproc == initproc)
801041c8:	39 35 c0 c5 10 80    	cmp    %esi,0x8010c5c0
  curproc->exit_status=status;
801041ce:	89 5e 7c             	mov    %ebx,0x7c(%esi)
    if(curproc == initproc)
801041d1:	0f 84 b1 00 00 00    	je     80104288 <exit+0xf8>
801041d7:	8d 5e 28             	lea    0x28(%esi),%ebx
801041da:	8d 7e 68             	lea    0x68(%esi),%edi
801041dd:	8d 76 00             	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
801041e0:	8b 03                	mov    (%ebx),%eax
801041e2:	85 c0                	test   %eax,%eax
801041e4:	74 0e                	je     801041f4 <exit+0x64>
      fileclose(curproc->ofile[fd]);
801041e6:	89 04 24             	mov    %eax,(%esp)
801041e9:	e8 42 cc ff ff       	call   80100e30 <fileclose>
      curproc->ofile[fd] = 0;
801041ee:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801041f4:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
801041f7:	39 df                	cmp    %ebx,%edi
801041f9:	75 e5                	jne    801041e0 <exit+0x50>
  begin_op();
801041fb:	e8 90 ea ff ff       	call   80102c90 <begin_op>
  iput(curproc->cwd);
80104200:	8b 46 68             	mov    0x68(%esi),%eax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104203:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
  iput(curproc->cwd);
80104208:	89 04 24             	mov    %eax,(%esp)
8010420b:	e8 10 d6 ff ff       	call   80101820 <iput>
  end_op();
80104210:	e8 eb ea ff ff       	call   80102d00 <end_op>
  curproc->cwd = 0;
80104215:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
8010421c:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104223:	e8 a8 18 00 00       	call   80105ad0 <acquire>
  wakeup1(curproc->parent);
80104228:	8b 46 14             	mov    0x14(%esi),%eax
8010422b:	e8 60 f8 ff ff       	call   80103a90 <wakeup1>
80104230:	eb 14                	jmp    80104246 <exit+0xb6>
80104232:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104238:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
8010423e:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
80104244:	73 2a                	jae    80104270 <exit+0xe0>
    if(p->parent == curproc){
80104246:	39 73 14             	cmp    %esi,0x14(%ebx)
80104249:	75 ed                	jne    80104238 <exit+0xa8>
      if(p->state == ZOMBIE)
8010424b:	8b 53 0c             	mov    0xc(%ebx),%edx
      p->parent = initproc;
8010424e:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
      if(p->state == ZOMBIE)
80104253:	83 fa 05             	cmp    $0x5,%edx
      p->parent = initproc;
80104256:	89 43 14             	mov    %eax,0x14(%ebx)
      if(p->state == ZOMBIE)
80104259:	75 dd                	jne    80104238 <exit+0xa8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010425b:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
        wakeup1(initproc);
80104261:	e8 2a f8 ff ff       	call   80103a90 <wakeup1>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104266:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
8010426c:	72 d8                	jb     80104246 <exit+0xb6>
8010426e:	66 90                	xchg   %ax,%ax
  curproc->state = ZOMBIE;
80104270:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80104277:	e8 64 fe ff ff       	call   801040e0 <sched>
  panic("zombie exit");
8010427c:	c7 04 24 ad 8d 10 80 	movl   $0x80108dad,(%esp)
80104283:	e8 e8 c0 ff ff       	call   80100370 <panic>
    panic("init exiting");
80104288:	c7 04 24 a0 8d 10 80 	movl   $0x80108da0,(%esp)
8010428f:	e8 dc c0 ff ff       	call   80100370 <panic>
80104294:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010429a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801042a0 <yield>:
{
801042a0:	55                   	push   %ebp
801042a1:	89 e5                	mov    %esp,%ebp
801042a3:	56                   	push   %esi
801042a4:	53                   	push   %ebx
801042a5:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801042a8:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801042af:	e8 1c 18 00 00       	call   80105ad0 <acquire>
  pushcli();
801042b4:	e8 37 17 00 00       	call   801059f0 <pushcli>
  c = mycpu();
801042b9:	e8 c2 f6 ff ff       	call   80103980 <mycpu>
  p = c->proc;
801042be:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801042c4:	e8 67 17 00 00       	call   80105a30 <popcli>
  myproc()->state = RUNNABLE;
801042c9:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  pushcli();
801042d0:	e8 1b 17 00 00       	call   801059f0 <pushcli>
  c = mycpu();
801042d5:	e8 a6 f6 ff ff       	call   80103980 <mycpu>
  p = c->proc;
801042da:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801042e0:	e8 4b 17 00 00       	call   80105a30 <popcli>
  myproc()->accumulator+=myproc()->priority;
801042e5:	8b 9b 88 00 00 00    	mov    0x88(%ebx),%ebx
  pushcli();
801042eb:	e8 00 17 00 00       	call   801059f0 <pushcli>
  c = mycpu();
801042f0:	e8 8b f6 ff ff       	call   80103980 <mycpu>
  p = c->proc;
801042f5:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801042fb:	e8 30 17 00 00       	call   80105a30 <popcli>
  myproc()->accumulator+=myproc()->priority;
80104300:	89 d8                	mov    %ebx,%eax
80104302:	99                   	cltd   
80104303:	01 9e 80 00 00 00    	add    %ebx,0x80(%esi)
  rrq.enqueue(myproc());
80104309:	8b 1d d8 c5 10 80    	mov    0x8010c5d8,%ebx
  myproc()->accumulator+=myproc()->priority;
8010430f:	11 96 84 00 00 00    	adc    %edx,0x84(%esi)
  pushcli();
80104315:	e8 d6 16 00 00       	call   801059f0 <pushcli>
  c = mycpu();
8010431a:	e8 61 f6 ff ff       	call   80103980 <mycpu>
  p = c->proc;
8010431f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104325:	e8 06 17 00 00       	call   80105a30 <popcli>
  rrq.enqueue(myproc());
8010432a:	89 34 24             	mov    %esi,(%esp)
8010432d:	ff d3                	call   *%ebx
  pq.put(myproc()); //add to runabble queue
8010432f:	8b 1d e8 c5 10 80    	mov    0x8010c5e8,%ebx
  pushcli();
80104335:	e8 b6 16 00 00       	call   801059f0 <pushcli>
  c = mycpu();
8010433a:	e8 41 f6 ff ff       	call   80103980 <mycpu>
  p = c->proc;
8010433f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104345:	e8 e6 16 00 00       	call   80105a30 <popcli>
  pq.put(myproc()); //add to runabble queue
8010434a:	89 34 24             	mov    %esi,(%esp)
8010434d:	ff d3                	call   *%ebx
  rpholder.remove(myproc());//remove from running queue
8010434f:	8b 1d cc c5 10 80    	mov    0x8010c5cc,%ebx
  pushcli();
80104355:	e8 96 16 00 00       	call   801059f0 <pushcli>
  c = mycpu();
8010435a:	e8 21 f6 ff ff       	call   80103980 <mycpu>
  p = c->proc;
8010435f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104365:	e8 c6 16 00 00       	call   80105a30 <popcli>
  rpholder.remove(myproc());//remove from running queue
8010436a:	89 34 24             	mov    %esi,(%esp)
8010436d:	ff d3                	call   *%ebx
  sched();
8010436f:	e8 6c fd ff ff       	call   801040e0 <sched>
  release(&ptable.lock);
80104374:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
8010437b:	e8 f0 17 00 00       	call   80105b70 <release>
}
80104380:	83 c4 10             	add    $0x10,%esp
80104383:	5b                   	pop    %ebx
80104384:	5e                   	pop    %esi
80104385:	5d                   	pop    %ebp
80104386:	c3                   	ret    
80104387:	89 f6                	mov    %esi,%esi
80104389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104390 <sleep>:
{
80104390:	55                   	push   %ebp
80104391:	89 e5                	mov    %esp,%ebp
80104393:	83 ec 28             	sub    $0x28,%esp
80104396:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80104399:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010439c:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010439f:	8b 75 08             	mov    0x8(%ebp),%esi
801043a2:	89 7d fc             	mov    %edi,-0x4(%ebp)
  pushcli();
801043a5:	e8 46 16 00 00       	call   801059f0 <pushcli>
  c = mycpu();
801043aa:	e8 d1 f5 ff ff       	call   80103980 <mycpu>
  p = c->proc;
801043af:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
801043b5:	e8 76 16 00 00       	call   80105a30 <popcli>
  if(p == 0)
801043ba:	85 ff                	test   %edi,%edi
801043bc:	0f 84 ad 00 00 00    	je     8010446f <sleep+0xdf>
  if(lk == 0)
801043c2:	85 db                	test   %ebx,%ebx
801043c4:	0f 84 99 00 00 00    	je     80104463 <sleep+0xd3>
  p->accumulator+=p->priority;  // add the priority to the acc
801043ca:	8b 87 88 00 00 00    	mov    0x88(%edi),%eax
801043d0:	99                   	cltd   
801043d1:	01 87 80 00 00 00    	add    %eax,0x80(%edi)
801043d7:	11 97 84 00 00 00    	adc    %edx,0x84(%edi)
  rpholder.remove(p); //remove p from RUNNING queue
801043dd:	89 3c 24             	mov    %edi,(%esp)
801043e0:	ff 15 cc c5 10 80    	call   *0x8010c5cc
  if(lk != &ptable.lock){  //DOC: sleeplock0
801043e6:	81 fb 80 4d 11 80    	cmp    $0x80114d80,%ebx
801043ec:	74 52                	je     80104440 <sleep+0xb0>
    acquire(&ptable.lock);  //DOC: sleeplock1
801043ee:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801043f5:	e8 d6 16 00 00       	call   80105ad0 <acquire>
    release(lk);
801043fa:	89 1c 24             	mov    %ebx,(%esp)
801043fd:	e8 6e 17 00 00       	call   80105b70 <release>
  p->chan = chan;
80104402:	89 77 20             	mov    %esi,0x20(%edi)
  p->state = SLEEPING;
80104405:	c7 47 0c 02 00 00 00 	movl   $0x2,0xc(%edi)
  sched();
8010440c:	e8 cf fc ff ff       	call   801040e0 <sched>
  p->chan = 0;
80104411:	c7 47 20 00 00 00 00 	movl   $0x0,0x20(%edi)
    release(&ptable.lock);
80104418:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
8010441f:	e8 4c 17 00 00       	call   80105b70 <release>
}
80104424:	8b 75 f8             	mov    -0x8(%ebp),%esi
    acquire(lk);
80104427:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010442a:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010442d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104430:	89 ec                	mov    %ebp,%esp
80104432:	5d                   	pop    %ebp
    acquire(lk);
80104433:	e9 98 16 00 00       	jmp    80105ad0 <acquire>
80104438:	90                   	nop
80104439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104440:	89 77 20             	mov    %esi,0x20(%edi)
  p->state = SLEEPING;
80104443:	c7 47 0c 02 00 00 00 	movl   $0x2,0xc(%edi)
  sched();
8010444a:	e8 91 fc ff ff       	call   801040e0 <sched>
  p->chan = 0;
8010444f:	c7 47 20 00 00 00 00 	movl   $0x0,0x20(%edi)
}
80104456:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104459:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010445c:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010445f:	89 ec                	mov    %ebp,%esp
80104461:	5d                   	pop    %ebp
80104462:	c3                   	ret    
    panic("sleep without lk");
80104463:	c7 04 24 bf 8d 10 80 	movl   $0x80108dbf,(%esp)
8010446a:	e8 01 bf ff ff       	call   80100370 <panic>
    panic("sleep");
8010446f:	c7 04 24 b9 8d 10 80 	movl   $0x80108db9,(%esp)
80104476:	e8 f5 be ff ff       	call   80100370 <panic>
8010447b:	90                   	nop
8010447c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104480 <wait>:
{
80104480:	55                   	push   %ebp
80104481:	89 e5                	mov    %esp,%ebp
80104483:	56                   	push   %esi
80104484:	53                   	push   %ebx
80104485:	83 ec 10             	sub    $0x10,%esp
  pushcli();
80104488:	e8 63 15 00 00       	call   801059f0 <pushcli>
  c = mycpu();
8010448d:	e8 ee f4 ff ff       	call   80103980 <mycpu>
  p = c->proc;
80104492:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104498:	e8 93 15 00 00       	call   80105a30 <popcli>
  acquire(&ptable.lock);
8010449d:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801044a4:	e8 27 16 00 00       	call   80105ad0 <acquire>
    havekids = 0;
801044a9:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044ab:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
801044b0:	eb 14                	jmp    801044c6 <wait+0x46>
801044b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801044b8:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
801044be:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
801044c4:	73 20                	jae    801044e6 <wait+0x66>
      if(p->parent != curproc)
801044c6:	39 73 14             	cmp    %esi,0x14(%ebx)
801044c9:	75 ed                	jne    801044b8 <wait+0x38>
      if(p->state == ZOMBIE){
801044cb:	8b 43 0c             	mov    0xc(%ebx),%eax
801044ce:	83 f8 05             	cmp    $0x5,%eax
801044d1:	74 3d                	je     80104510 <wait+0x90>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044d3:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
      havekids = 1;
801044d9:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044de:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
801044e4:	72 e0                	jb     801044c6 <wait+0x46>
    if(!havekids || curproc->killed){
801044e6:	85 c0                	test   %eax,%eax
801044e8:	0f 84 8e 00 00 00    	je     8010457c <wait+0xfc>
801044ee:	8b 56 24             	mov    0x24(%esi),%edx
801044f1:	85 d2                	test   %edx,%edx
801044f3:	0f 85 83 00 00 00    	jne    8010457c <wait+0xfc>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
801044f9:	b8 80 4d 11 80       	mov    $0x80114d80,%eax
801044fe:	89 44 24 04          	mov    %eax,0x4(%esp)
80104502:	89 34 24             	mov    %esi,(%esp)
80104505:	e8 86 fe ff ff       	call   80104390 <sleep>
    havekids = 0;
8010450a:	eb 9d                	jmp    801044a9 <wait+0x29>
8010450c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80104510:	8b 43 08             	mov    0x8(%ebx),%eax
        pid = p->pid;
80104513:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104516:	89 04 24             	mov    %eax,(%esp)
80104519:	e8 c2 de ff ff       	call   801023e0 <kfree>
        freevm(p->pgdir);
8010451e:	8b 43 04             	mov    0x4(%ebx),%eax
        p->kstack = 0;
80104521:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104528:	89 04 24             	mov    %eax,(%esp)
8010452b:	e8 20 3f 00 00       	call   80108450 <freevm>
        status = (int *) p->exit_status;
80104530:	8b 53 7c             	mov    0x7c(%ebx),%edx
        cprintf("**wait**  status= %d\t p.exit_status= %d\n",status,p->exit_status);
80104533:	c7 04 24 7c 8e 10 80 	movl   $0x80108e7c,(%esp)
        p->pid = 0;
8010453a:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104541:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        cprintf("**wait**  status= %d\t p.exit_status= %d\n",status,p->exit_status);
80104548:	89 54 24 08          	mov    %edx,0x8(%esp)
8010454c:	89 54 24 04          	mov    %edx,0x4(%esp)
        p->name[0] = 0;
80104550:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104554:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
8010455b:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        cprintf("**wait**  status= %d\t p.exit_status= %d\n",status,p->exit_status);
80104562:	e8 e9 c0 ff ff       	call   80100650 <cprintf>
        release(&ptable.lock);
80104567:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
8010456e:	e8 fd 15 00 00       	call   80105b70 <release>
}
80104573:	83 c4 10             	add    $0x10,%esp
80104576:	89 f0                	mov    %esi,%eax
80104578:	5b                   	pop    %ebx
80104579:	5e                   	pop    %esi
8010457a:	5d                   	pop    %ebp
8010457b:	c3                   	ret    
      release(&ptable.lock);
8010457c:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
      return -1;
80104583:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104588:	e8 e3 15 00 00       	call   80105b70 <release>
      return -1;
8010458d:	eb e4                	jmp    80104573 <wait+0xf3>
8010458f:	90                   	nop

80104590 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104590:	55                   	push   %ebp
80104591:	89 e5                	mov    %esp,%ebp
80104593:	53                   	push   %ebx
80104594:	83 ec 14             	sub    $0x14,%esp
80104597:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010459a:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801045a1:	e8 2a 15 00 00       	call   80105ad0 <acquire>
  wakeup1(chan);
801045a6:	89 d8                	mov    %ebx,%eax
801045a8:	e8 e3 f4 ff ff       	call   80103a90 <wakeup1>
  release(&ptable.lock);
801045ad:	c7 45 08 80 4d 11 80 	movl   $0x80114d80,0x8(%ebp)
}
801045b4:	83 c4 14             	add    $0x14,%esp
801045b7:	5b                   	pop    %ebx
801045b8:	5d                   	pop    %ebp
  release(&ptable.lock);
801045b9:	e9 b2 15 00 00       	jmp    80105b70 <release>
801045be:	66 90                	xchg   %ax,%ax

801045c0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801045c0:	55                   	push   %ebp
801045c1:	89 e5                	mov    %esp,%ebp
801045c3:	53                   	push   %ebx
801045c4:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;

  acquire(&ptable.lock);
801045c7:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
{
801045ce:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801045d1:	e8 fa 14 00 00       	call   80105ad0 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045d6:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
801045db:	eb 0f                	jmp    801045ec <kill+0x2c>
801045dd:	8d 76 00             	lea    0x0(%esi),%esi
801045e0:	05 a8 00 00 00       	add    $0xa8,%eax
801045e5:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
801045ea:	73 54                	jae    80104640 <kill+0x80>
    if(p->pid == pid){
801045ec:	39 58 10             	cmp    %ebx,0x10(%eax)
801045ef:	75 ef                	jne    801045e0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING){
801045f1:	8b 50 0c             	mov    0xc(%eax),%edx
      p->killed = 1;
801045f4:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING){
801045fb:	83 fa 02             	cmp    $0x2,%edx
801045fe:	74 18                	je     80104618 <kill+0x58>
          //TODO- priority queue addition
          p->accumulator+=p->priority;
          //pq.put(p);
          pushToSpecificQueue(p);
      }
      release(&ptable.lock);
80104600:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104607:	e8 64 15 00 00       	call   80105b70 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
8010460c:	83 c4 14             	add    $0x14,%esp
      return 0;
8010460f:	31 c0                	xor    %eax,%eax
}
80104611:	5b                   	pop    %ebx
80104612:	5d                   	pop    %ebp
80104613:	c3                   	ret    
80104614:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          p->accumulator+=p->priority;
80104618:	8b 88 88 00 00 00    	mov    0x88(%eax),%ecx
          p->state = RUNNABLE;
8010461e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
          p->accumulator+=p->priority;
80104625:	89 cb                	mov    %ecx,%ebx
80104627:	c1 fb 1f             	sar    $0x1f,%ebx
8010462a:	01 88 80 00 00 00    	add    %ecx,0x80(%eax)
80104630:	11 98 84 00 00 00    	adc    %ebx,0x84(%eax)
          pushToSpecificQueue(p);
80104636:	89 04 24             	mov    %eax,(%esp)
80104639:	e8 12 f4 ff ff       	call   80103a50 <pushToSpecificQueue>
8010463e:	eb c0                	jmp    80104600 <kill+0x40>
  release(&ptable.lock);
80104640:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104647:	e8 24 15 00 00       	call   80105b70 <release>
}
8010464c:	83 c4 14             	add    $0x14,%esp
  return -1;
8010464f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104654:	5b                   	pop    %ebx
80104655:	5d                   	pop    %ebp
80104656:	c3                   	ret    
80104657:	89 f6                	mov    %esi,%esi
80104659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104660 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104660:	55                   	push   %ebp
80104661:	89 e5                	mov    %esp,%ebp
80104663:	57                   	push   %edi
80104664:	56                   	push   %esi
80104665:	53                   	push   %ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104666:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
{
8010466b:	83 ec 4c             	sub    $0x4c,%esp
8010466e:	eb 1e                	jmp    8010468e <procdump+0x2e>
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104670:	c7 04 24 a1 8f 10 80 	movl   $0x80108fa1,(%esp)
80104677:	e8 d4 bf ff ff       	call   80100650 <cprintf>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010467c:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80104682:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
80104688:	0f 83 b2 00 00 00    	jae    80104740 <procdump+0xe0>
    if(p->state == UNUSED)
8010468e:	8b 43 0c             	mov    0xc(%ebx),%eax
80104691:	85 c0                	test   %eax,%eax
80104693:	74 e7                	je     8010467c <procdump+0x1c>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104695:	8b 43 0c             	mov    0xc(%ebx),%eax
      state = "???";
80104698:	b8 d0 8d 10 80       	mov    $0x80108dd0,%eax
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010469d:	8b 53 0c             	mov    0xc(%ebx),%edx
801046a0:	83 fa 05             	cmp    $0x5,%edx
801046a3:	77 18                	ja     801046bd <procdump+0x5d>
801046a5:	8b 53 0c             	mov    0xc(%ebx),%edx
801046a8:	8b 14 95 78 8f 10 80 	mov    -0x7fef7088(,%edx,4),%edx
801046af:	85 d2                	test   %edx,%edx
801046b1:	74 0a                	je     801046bd <procdump+0x5d>
      state = states[p->state];
801046b3:	8b 43 0c             	mov    0xc(%ebx),%eax
801046b6:	8b 04 85 78 8f 10 80 	mov    -0x7fef7088(,%eax,4),%eax
    cprintf("%d %s %s", p->pid, state, p->name);
801046bd:	89 44 24 08          	mov    %eax,0x8(%esp)
801046c1:	8b 43 10             	mov    0x10(%ebx),%eax
801046c4:	8d 53 6c             	lea    0x6c(%ebx),%edx
801046c7:	89 54 24 0c          	mov    %edx,0xc(%esp)
801046cb:	c7 04 24 d4 8d 10 80 	movl   $0x80108dd4,(%esp)
801046d2:	89 44 24 04          	mov    %eax,0x4(%esp)
801046d6:	e8 75 bf ff ff       	call   80100650 <cprintf>
    if(p->state == SLEEPING){
801046db:	8b 43 0c             	mov    0xc(%ebx),%eax
801046de:	83 f8 02             	cmp    $0x2,%eax
801046e1:	75 8d                	jne    80104670 <procdump+0x10>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801046e3:	8d 45 c0             	lea    -0x40(%ebp),%eax
801046e6:	89 44 24 04          	mov    %eax,0x4(%esp)
801046ea:	8b 43 1c             	mov    0x1c(%ebx),%eax
801046ed:	8d 75 c0             	lea    -0x40(%ebp),%esi
801046f0:	8d 7d e8             	lea    -0x18(%ebp),%edi
801046f3:	8b 40 0c             	mov    0xc(%eax),%eax
801046f6:	83 c0 08             	add    $0x8,%eax
801046f9:	89 04 24             	mov    %eax,(%esp)
801046fc:	e8 9f 12 00 00       	call   801059a0 <getcallerpcs>
80104701:	eb 0d                	jmp    80104710 <procdump+0xb0>
80104703:	90                   	nop
80104704:	90                   	nop
80104705:	90                   	nop
80104706:	90                   	nop
80104707:	90                   	nop
80104708:	90                   	nop
80104709:	90                   	nop
8010470a:	90                   	nop
8010470b:	90                   	nop
8010470c:	90                   	nop
8010470d:	90                   	nop
8010470e:	90                   	nop
8010470f:	90                   	nop
      for(i=0; i<10 && pc[i] != 0; i++)
80104710:	8b 16                	mov    (%esi),%edx
80104712:	85 d2                	test   %edx,%edx
80104714:	0f 84 56 ff ff ff    	je     80104670 <procdump+0x10>
        cprintf(" %p", pc[i]);
8010471a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010471e:	83 c6 04             	add    $0x4,%esi
80104721:	c7 04 24 c1 87 10 80 	movl   $0x801087c1,(%esp)
80104728:	e8 23 bf ff ff       	call   80100650 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
8010472d:	39 f7                	cmp    %esi,%edi
8010472f:	75 df                	jne    80104710 <procdump+0xb0>
80104731:	e9 3a ff ff ff       	jmp    80104670 <procdump+0x10>
80104736:	8d 76 00             	lea    0x0(%esi),%esi
80104739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }
}
80104740:	83 c4 4c             	add    $0x4c,%esp
80104743:	5b                   	pop    %ebx
80104744:	5e                   	pop    %esi
80104745:	5f                   	pop    %edi
80104746:	5d                   	pop    %ebp
80104747:	c3                   	ret    
80104748:	90                   	nop
80104749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104750 <detach>:

//TODO

int
detach(int pid)
{
80104750:	55                   	push   %ebp
80104751:	89 e5                	mov    %esp,%ebp
80104753:	56                   	push   %esi
80104754:	53                   	push   %ebx
80104755:	83 ec 10             	sub    $0x10,%esp
80104758:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
8010475b:	e8 90 12 00 00       	call   801059f0 <pushcli>
  c = mycpu();
80104760:	e8 1b f2 ff ff       	call   80103980 <mycpu>
  p = c->proc;
80104765:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010476b:	e8 c0 12 00 00       	call   80105a30 <popcli>
    struct proc *p;
    struct proc *curproc = myproc();

    for(;;){
        // Scan through table looking for exited children with same pid as the argument.
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104770:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
80104775:	eb 15                	jmp    8010478c <detach+0x3c>
80104777:	89 f6                	mov    %esi,%esi
80104779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104780:	05 a8 00 00 00       	add    $0xa8,%eax
80104785:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
8010478a:	73 2c                	jae    801047b8 <detach+0x68>
            if (p->parent != curproc)
8010478c:	39 58 14             	cmp    %ebx,0x14(%eax)
8010478f:	75 ef                	jne    80104780 <detach+0x30>
                continue;
            //check if the pid is same as argument
            if (p->pid == pid) {
80104791:	39 70 10             	cmp    %esi,0x10(%eax)
80104794:	75 ea                	jne    80104780 <detach+0x30>
                //change the father of current proc
                p->parent = initproc;
80104796:	8b 15 c0 c5 10 80    	mov    0x8010c5c0,%edx
8010479c:	89 50 14             	mov    %edx,0x14(%eax)
                //release the ptable
                release(&ptable.lock);
8010479f:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801047a6:	e8 c5 13 00 00       	call   80105b70 <release>
        }
        //if got here - didn't find proc with pid as argument - exit with error
        release(&ptable.lock);
        return -1;
    }
}
801047ab:	83 c4 10             	add    $0x10,%esp
                return 0;
801047ae:	31 c0                	xor    %eax,%eax
}
801047b0:	5b                   	pop    %ebx
801047b1:	5e                   	pop    %esi
801047b2:	5d                   	pop    %ebp
801047b3:	c3                   	ret    
801047b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        release(&ptable.lock);
801047b8:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801047bf:	e8 ac 13 00 00       	call   80105b70 <release>
}
801047c4:	83 c4 10             	add    $0x10,%esp
        return -1;
801047c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801047cc:	5b                   	pop    %ebx
801047cd:	5e                   	pop    %esi
801047ce:	5d                   	pop    %ebp
801047cf:	c3                   	ret    

801047d0 <priority>:


void
priority(int prio){
801047d0:	55                   	push   %ebp
801047d1:	89 e5                	mov    %esp,%ebp
801047d3:	53                   	push   %ebx
801047d4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801047d7:	e8 14 12 00 00       	call   801059f0 <pushcli>
  c = mycpu();
801047dc:	e8 9f f1 ff ff       	call   80103980 <mycpu>
  p = c->proc;
801047e1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801047e7:	e8 44 12 00 00       	call   80105a30 <popcli>
    struct proc *curproc = myproc();
    if(currpolicy==2){
801047ec:	a1 04 c0 10 80       	mov    0x8010c004,%eax
801047f1:	83 f8 02             	cmp    $0x2,%eax
801047f4:	74 2a                	je     80104820 <priority+0x50>
        if(prio>0 &&prio<11)
            curproc->priority=prio;
    }
    if(currpolicy==3){
801047f6:	a1 04 c0 10 80       	mov    0x8010c004,%eax
801047fb:	83 f8 03             	cmp    $0x3,%eax
801047fe:	74 08                	je     80104808 <priority+0x38>
        if(prio>-1 &&prio<11)
            curproc->priority=prio;
    }
    //curproc->priority=prio;
}
80104800:	58                   	pop    %eax
80104801:	5b                   	pop    %ebx
80104802:	5d                   	pop    %ebp
80104803:	c3                   	ret    
80104804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(prio>-1 &&prio<11)
80104808:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
8010480c:	77 f2                	ja     80104800 <priority+0x30>
            curproc->priority=prio;
8010480e:	8b 45 08             	mov    0x8(%ebp),%eax
80104811:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)
}
80104817:	58                   	pop    %eax
80104818:	5b                   	pop    %ebx
80104819:	5d                   	pop    %ebp
8010481a:	c3                   	ret    
8010481b:	90                   	nop
8010481c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(prio>0 &&prio<11)
80104820:	8b 45 08             	mov    0x8(%ebp),%eax
80104823:	48                   	dec    %eax
80104824:	83 f8 09             	cmp    $0x9,%eax
80104827:	77 cd                	ja     801047f6 <priority+0x26>
            curproc->priority=prio;
80104829:	8b 45 08             	mov    0x8(%ebp),%eax
8010482c:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)
80104832:	eb c2                	jmp    801047f6 <priority+0x26>
80104834:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010483a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104840 <priorityUnExtended>:


void
priorityUnExtended(){
80104840:	55                   	push   %ebp
    struct proc *p;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104841:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
priorityUnExtended(){
80104846:	89 e5                	mov    %esp,%ebp
80104848:	90                   	nop
80104849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if (p->priority == 0)
80104850:	8b 88 88 00 00 00    	mov    0x88(%eax),%ecx
80104856:	85 c9                	test   %ecx,%ecx
80104858:	75 0b                	jne    80104865 <priorityUnExtended+0x25>
            p->priority = 1;
8010485a:	ba 01 00 00 00       	mov    $0x1,%edx
8010485f:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104865:	05 a8 00 00 00       	add    $0xa8,%eax
8010486a:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
8010486f:	72 df                	jb     80104850 <priorityUnExtended+0x10>
    }
}
80104871:	5d                   	pop    %ebp
80104872:	c3                   	ret    
80104873:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104880 <switchToRoundRobin>:

void
switchToRoundRobin(void){
80104880:	55                   	push   %ebp
80104881:	89 e5                	mov    %esp,%ebp
80104883:	83 ec 18             	sub    $0x18,%esp
    struct proc *p;
    if(!pq.switchToRoundRobinPolicy())
80104886:	ff 15 f4 c5 10 80    	call   *0x8010c5f4
8010488c:	85 c0                	test   %eax,%eax
8010488e:	74 2b                	je     801048bb <switchToRoundRobin+0x3b>
        panic("error in switch from policy 2/3 to policy 1\n");
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104890:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
80104895:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        p->accumulator=0;
801048a0:	31 d2                	xor    %edx,%edx
801048a2:	31 c9                	xor    %ecx,%ecx
801048a4:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801048aa:	05 a8 00 00 00       	add    $0xa8,%eax
        p->accumulator=0;
801048af:	89 48 dc             	mov    %ecx,-0x24(%eax)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801048b2:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
801048b7:	72 e7                	jb     801048a0 <switchToRoundRobin+0x20>
    }
}
801048b9:	c9                   	leave  
801048ba:	c3                   	ret    
        panic("error in switch from policy 2/3 to policy 1\n");
801048bb:	c7 04 24 a8 8e 10 80 	movl   $0x80108ea8,(%esp)
801048c2:	e8 a9 ba ff ff       	call   80100370 <panic>
801048c7:	89 f6                	mov    %esi,%esi
801048c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048d0 <policy>:

void
policy(int num){
801048d0:	55                   	push   %ebp
801048d1:	89 e5                	mov    %esp,%ebp
801048d3:	53                   	push   %ebx
801048d4:	83 ec 14             	sub    $0x14,%esp
801048d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
    //check legal input
    //TODO- need to check if there is a need to change to default or to panic
    if(num>3 || num<1)
801048da:	8d 43 ff             	lea    -0x1(%ebx),%eax
801048dd:	83 f8 02             	cmp    $0x2,%eax
801048e0:	76 0e                	jbe    801048f0 <policy+0x20>
        default:
            panic("illegal policy number\n");
            break;
    }
    release(&ptable.lock);
}
801048e2:	83 c4 14             	add    $0x14,%esp
801048e5:	5b                   	pop    %ebx
801048e6:	5d                   	pop    %ebp
801048e7:	c3                   	ret    
801048e8:	90                   	nop
801048e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("sti");
801048f0:	fb                   	sti    
    acquire(&ptable.lock);
801048f1:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801048f8:	e8 d3 11 00 00       	call   80105ad0 <acquire>
    switch (currpolicy){
801048fd:	a1 04 c0 10 80       	mov    0x8010c004,%eax
80104902:	83 f8 02             	cmp    $0x2,%eax
80104905:	74 39                	je     80104940 <policy+0x70>
80104907:	83 f8 03             	cmp    $0x3,%eax
8010490a:	74 14                	je     80104920 <policy+0x50>
8010490c:	48                   	dec    %eax
8010490d:	74 41                	je     80104950 <policy+0x80>
            panic("illegal policy number\n");
8010490f:	c7 04 24 dd 8d 10 80 	movl   $0x80108ddd,(%esp)
80104916:	e8 55 ba ff ff       	call   80100370 <panic>
8010491b:	90                   	nop
8010491c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            if(num==1){
80104920:	83 fb 01             	cmp    $0x1,%ebx
80104923:	74 1e                	je     80104943 <policy+0x73>
            if(num==2){
80104925:	83 fb 02             	cmp    $0x2,%ebx
80104928:	74 6e                	je     80104998 <policy+0xc8>
    release(&ptable.lock);
8010492a:	c7 45 08 80 4d 11 80 	movl   $0x80114d80,0x8(%ebp)
}
80104931:	83 c4 14             	add    $0x14,%esp
80104934:	5b                   	pop    %ebx
80104935:	5d                   	pop    %ebp
    release(&ptable.lock);
80104936:	e9 35 12 00 00       	jmp    80105b70 <release>
8010493b:	90                   	nop
8010493c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            if(num==1){
80104940:	4b                   	dec    %ebx
80104941:	75 e7                	jne    8010492a <policy+0x5a>
                switchToRoundRobin();
80104943:	e8 38 ff ff ff       	call   80104880 <switchToRoundRobin>
80104948:	eb e0                	jmp    8010492a <policy+0x5a>
8010494a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            if(num==2 || num==3){
80104950:	8d 43 fe             	lea    -0x2(%ebx),%eax
80104953:	83 f8 01             	cmp    $0x1,%eax
80104956:	77 d2                	ja     8010492a <policy+0x5a>
                if(!rrq.switchToPriorityQueuePolicy())
80104958:	ff 15 e0 c5 10 80    	call   *0x8010c5e0
8010495e:	85 c0                	test   %eax,%eax
80104960:	74 64                	je     801049c6 <policy+0xf6>
                if(num==2)
80104962:	83 fb 02             	cmp    $0x2,%ebx
80104965:	75 c3                	jne    8010492a <policy+0x5a>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104967:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
8010496c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if (p->priority == 0)
80104970:	8b 90 88 00 00 00    	mov    0x88(%eax),%edx
80104976:	85 d2                	test   %edx,%edx
80104978:	75 0b                	jne    80104985 <policy+0xb5>
            p->priority = 1;
8010497a:	bb 01 00 00 00       	mov    $0x1,%ebx
8010497f:	89 98 88 00 00 00    	mov    %ebx,0x88(%eax)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104985:	05 a8 00 00 00       	add    $0xa8,%eax
8010498a:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
8010498f:	72 df                	jb     80104970 <policy+0xa0>
80104991:	eb 97                	jmp    8010492a <policy+0x5a>
80104993:	90                   	nop
80104994:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104998:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
8010499d:	8d 76 00             	lea    0x0(%esi),%esi
        if (p->priority == 0)
801049a0:	8b 88 88 00 00 00    	mov    0x88(%eax),%ecx
801049a6:	85 c9                	test   %ecx,%ecx
801049a8:	75 0b                	jne    801049b5 <policy+0xe5>
            p->priority = 1;
801049aa:	ba 01 00 00 00       	mov    $0x1,%edx
801049af:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801049b5:	05 a8 00 00 00       	add    $0xa8,%eax
801049ba:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
801049bf:	72 df                	jb     801049a0 <policy+0xd0>
801049c1:	e9 64 ff ff ff       	jmp    8010492a <policy+0x5a>
                    panic("error in switch from rouncrobin to priority queue\n");
801049c6:	c7 04 24 d8 8e 10 80 	movl   $0x80108ed8,(%esp)
801049cd:	e8 9e b9 ff ff       	call   80100370 <panic>
801049d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049e0 <wait_stat>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait_stat(int* status, struct perf* performance)
{
801049e0:	55                   	push   %ebp
801049e1:	89 e5                	mov    %esp,%ebp
801049e3:	57                   	push   %edi
801049e4:	56                   	push   %esi
801049e5:	53                   	push   %ebx
801049e6:	83 ec 2c             	sub    $0x2c,%esp
801049e9:	8b 7d 08             	mov    0x8(%ebp),%edi
  pushcli();
801049ec:	e8 ff 0f 00 00       	call   801059f0 <pushcli>
  c = mycpu();
801049f1:	e8 8a ef ff ff       	call   80103980 <mycpu>
  p = c->proc;
801049f6:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801049fc:	e8 2f 10 00 00       	call   80105a30 <popcli>
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();

  acquire(&ptable.lock);
80104a01:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104a08:	e8 c3 10 00 00       	call   80105ad0 <acquire>
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80104a0d:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a0f:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
80104a14:	eb 18                	jmp    80104a2e <wait_stat+0x4e>
80104a16:	8d 76 00             	lea    0x0(%esi),%esi
80104a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104a20:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80104a26:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
80104a2c:	73 20                	jae    80104a4e <wait_stat+0x6e>
      if(p->parent != curproc)
80104a2e:	39 73 14             	cmp    %esi,0x14(%ebx)
80104a31:	75 ed                	jne    80104a20 <wait_stat+0x40>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80104a33:	8b 43 0c             	mov    0xc(%ebx),%eax
80104a36:	83 f8 05             	cmp    $0x5,%eax
80104a39:	74 3d                	je     80104a78 <wait_stat+0x98>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a3b:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
      havekids = 1;
80104a41:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a46:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
80104a4c:	72 e0                	jb     80104a2e <wait_stat+0x4e>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80104a4e:	85 c0                	test   %eax,%eax
80104a50:	0f 84 ca 00 00 00    	je     80104b20 <wait_stat+0x140>
80104a56:	8b 56 24             	mov    0x24(%esi),%edx
80104a59:	85 d2                	test   %edx,%edx
80104a5b:	0f 85 bf 00 00 00    	jne    80104b20 <wait_stat+0x140>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104a61:	b8 80 4d 11 80       	mov    $0x80114d80,%eax
80104a66:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a6a:	89 34 24             	mov    %esi,(%esp)
80104a6d:	e8 1e f9 ff ff       	call   80104390 <sleep>
    havekids = 0;
80104a72:	eb 99                	jmp    80104a0d <wait_stat+0x2d>
80104a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80104a78:	8b 43 08             	mov    0x8(%ebx),%eax
        pid = p->pid;
80104a7b:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104a7e:	89 04 24             	mov    %eax,(%esp)
80104a81:	e8 5a d9 ff ff       	call   801023e0 <kfree>
        freevm(p->pgdir);
80104a86:	8b 43 04             	mov    0x4(%ebx),%eax
        p->kstack = 0;
80104a89:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104a90:	89 04 24             	mov    %eax,(%esp)
80104a93:	e8 b8 39 00 00       	call   80108450 <freevm>
        if(status!=null)
80104a98:	85 ff                	test   %edi,%edi
        p->pid = 0;
80104a9a:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104aa1:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104aa8:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104aac:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104ab3:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        if(status!=null)
80104aba:	74 03                	je     80104abf <wait_stat+0xdf>
          p->exit_status= (int)status ;
80104abc:	89 7b 7c             	mov    %edi,0x7c(%ebx)
        p->perf.ttime=p->perf.ctime+p->perf.rutime+p->perf.retime+p->perf.stime;
80104abf:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80104ac5:	8b 8b 9c 00 00 00    	mov    0x9c(%ebx),%ecx
80104acb:	8b 93 98 00 00 00    	mov    0x98(%ebx),%edx
80104ad1:	8b bb 94 00 00 00    	mov    0x94(%ebx),%edi
        cprintf("process pid:  %d \n creation time:  %d\nRUNNING time:  %d\n"
80104ad7:	89 44 24 08          	mov    %eax,0x8(%esp)
80104adb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
        p->perf.ttime=p->perf.ctime+p->perf.rutime+p->perf.retime+p->perf.stime;
80104adf:	89 54 24 10          	mov    %edx,0x10(%esp)
80104ae3:	8d 14 08             	lea    (%eax,%ecx,1),%edx
80104ae6:	03 54 24 10          	add    0x10(%esp),%edx
        cprintf("process pid:  %d \n creation time:  %d\nRUNNING time:  %d\n"
80104aea:	89 7c 24 14          	mov    %edi,0x14(%esp)
80104aee:	89 74 24 04          	mov    %esi,0x4(%esp)
        p->perf.ttime=p->perf.ctime+p->perf.rutime+p->perf.retime+p->perf.stime;
80104af2:	01 fa                	add    %edi,%edx
        cprintf("process pid:  %d \n creation time:  %d\nRUNNING time:  %d\n"
80104af4:	89 54 24 18          	mov    %edx,0x18(%esp)
80104af8:	c7 04 24 0c 8f 10 80 	movl   $0x80108f0c,(%esp)
        p->perf.ttime=p->perf.ctime+p->perf.rutime+p->perf.retime+p->perf.stime;
80104aff:	89 93 90 00 00 00    	mov    %edx,0x90(%ebx)
        cprintf("process pid:  %d \n creation time:  %d\nRUNNING time:  %d\n"
80104b05:	e8 46 bb ff ff       	call   80100650 <cprintf>
        release(&ptable.lock);
80104b0a:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104b11:	e8 5a 10 00 00       	call   80105b70 <release>
  }
}
80104b16:	83 c4 2c             	add    $0x2c,%esp
80104b19:	89 f0                	mov    %esi,%eax
80104b1b:	5b                   	pop    %ebx
80104b1c:	5e                   	pop    %esi
80104b1d:	5f                   	pop    %edi
80104b1e:	5d                   	pop    %ebp
80104b1f:	c3                   	ret    
      release(&ptable.lock);
80104b20:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
      return -1;
80104b27:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104b2c:	e8 3f 10 00 00       	call   80105b70 <release>
      return -1;
80104b31:	eb e3                	jmp    80104b16 <wait_stat+0x136>
80104b33:	66 90                	xchg   %ax,%ax
80104b35:	66 90                	xchg   %ax,%ax
80104b37:	66 90                	xchg   %ax,%ax
80104b39:	66 90                	xchg   %ax,%ax
80104b3b:	66 90                	xchg   %ax,%ax
80104b3d:	66 90                	xchg   %ax,%ax
80104b3f:	90                   	nop

80104b40 <isEmptyPriorityQueue>:
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
80104b40:	a1 14 c6 10 80       	mov    0x8010c614,%eax
static boolean isEmptyPriorityQueue() {
80104b45:	55                   	push   %ebp
80104b46:	89 e5                	mov    %esp,%ebp
}
80104b48:	5d                   	pop    %ebp
	return !root;
80104b49:	8b 00                	mov    (%eax),%eax
80104b4b:	85 c0                	test   %eax,%eax
80104b4d:	0f 94 c0             	sete   %al
80104b50:	0f b6 c0             	movzbl %al,%eax
}
80104b53:	c3                   	ret    
80104b54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104b60 <getMinAccumulatorPriorityQueue>:
	return !root;
80104b60:	a1 14 c6 10 80       	mov    0x8010c614,%eax
80104b65:	8b 10                	mov    (%eax),%edx
	
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
	if(isEmpty())
80104b67:	85 d2                	test   %edx,%edx
80104b69:	74 35                	je     80104ba0 <getMinAccumulatorPriorityQueue+0x40>
static boolean getMinAccumulatorPriorityQueue(long long* pkey) {
80104b6b:	55                   	push   %ebp
80104b6c:	89 e5                	mov    %esp,%ebp
80104b6e:	53                   	push   %ebx
80104b6f:	eb 09                	jmp    80104b7a <getMinAccumulatorPriorityQueue+0x1a>
80104b71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	while(minNode->left)
80104b78:	89 c2                	mov    %eax,%edx
80104b7a:	8b 42 18             	mov    0x18(%edx),%eax
80104b7d:	85 c0                	test   %eax,%eax
80104b7f:	75 f7                	jne    80104b78 <getMinAccumulatorPriorityQueue+0x18>
	*pkey = getMinNode()->key;
80104b81:	8b 45 08             	mov    0x8(%ebp),%eax
80104b84:	8b 5a 04             	mov    0x4(%edx),%ebx
80104b87:	8b 0a                	mov    (%edx),%ecx
80104b89:	89 58 04             	mov    %ebx,0x4(%eax)
80104b8c:	89 08                	mov    %ecx,(%eax)
80104b8e:	b8 01 00 00 00       	mov    $0x1,%eax
}
80104b93:	5b                   	pop    %ebx
80104b94:	5d                   	pop    %ebp
80104b95:	c3                   	ret    
80104b96:	8d 76 00             	lea    0x0(%esi),%esi
80104b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	if(isEmpty())
80104ba0:	31 c0                	xor    %eax,%eax
}
80104ba2:	c3                   	ret    
80104ba3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104bb0 <isEmptyRoundRobinQueue>:
	return !first;
80104bb0:	a1 10 c6 10 80       	mov    0x8010c610,%eax
static boolean isEmptyRoundRobinQueue() {
80104bb5:	55                   	push   %ebp
80104bb6:	89 e5                	mov    %esp,%ebp
}
80104bb8:	5d                   	pop    %ebp
	return !first;
80104bb9:	8b 00                	mov    (%eax),%eax
80104bbb:	85 c0                	test   %eax,%eax
80104bbd:	0f 94 c0             	sete   %al
80104bc0:	0f b6 c0             	movzbl %al,%eax
}
80104bc3:	c3                   	ret    
80104bc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104bca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104bd0 <enqueueRoundRobinQueue>:
	if(!freeLinks)
80104bd0:	a1 08 c6 10 80       	mov    0x8010c608,%eax
80104bd5:	85 c0                	test   %eax,%eax
80104bd7:	74 47                	je     80104c20 <enqueueRoundRobinQueue+0x50>
static boolean enqueueRoundRobinQueue(Proc *p) {
80104bd9:	55                   	push   %ebp
	return roundRobinQ->enqueue(p);
80104bda:	8b 0d 10 c6 10 80    	mov    0x8010c610,%ecx
	freeLinks = freeLinks->next;
80104be0:	8b 50 04             	mov    0x4(%eax),%edx
static boolean enqueueRoundRobinQueue(Proc *p) {
80104be3:	89 e5                	mov    %esp,%ebp
	ans->next = null;
80104be5:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
80104bec:	89 15 08 c6 10 80    	mov    %edx,0x8010c608
	ans->p = p;
80104bf2:	8b 55 08             	mov    0x8(%ebp),%edx
80104bf5:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80104bf7:	8b 11                	mov    (%ecx),%edx
80104bf9:	85 d2                	test   %edx,%edx
80104bfb:	74 2b                	je     80104c28 <enqueueRoundRobinQueue+0x58>
	else last->next = link;
80104bfd:	8b 51 04             	mov    0x4(%ecx),%edx
80104c00:	89 42 04             	mov    %eax,0x4(%edx)
80104c03:	eb 05                	jmp    80104c0a <enqueueRoundRobinQueue+0x3a>
80104c05:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
80104c08:	89 d0                	mov    %edx,%eax
80104c0a:	8b 50 04             	mov    0x4(%eax),%edx
80104c0d:	85 d2                	test   %edx,%edx
80104c0f:	75 f7                	jne    80104c08 <enqueueRoundRobinQueue+0x38>
	last = link->getLast();
80104c11:	89 41 04             	mov    %eax,0x4(%ecx)
80104c14:	b8 01 00 00 00       	mov    $0x1,%eax
}
80104c19:	5d                   	pop    %ebp
80104c1a:	c3                   	ret    
80104c1b:	90                   	nop
80104c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!freeLinks)
80104c20:	31 c0                	xor    %eax,%eax
}
80104c22:	c3                   	ret    
80104c23:	90                   	nop
80104c24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
80104c28:	89 01                	mov    %eax,(%ecx)
80104c2a:	eb de                	jmp    80104c0a <enqueueRoundRobinQueue+0x3a>
80104c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c30 <dequeueRoundRobinQueue>:
	return roundRobinQ->dequeue();
80104c30:	8b 0d 10 c6 10 80    	mov    0x8010c610,%ecx
	return !first;
80104c36:	8b 11                	mov    (%ecx),%edx
	if(isEmpty())
80104c38:	85 d2                	test   %edx,%edx
80104c3a:	74 3c                	je     80104c78 <dequeueRoundRobinQueue+0x48>
static Proc* dequeueRoundRobinQueue() {
80104c3c:	55                   	push   %ebp
80104c3d:	89 e5                	mov    %esp,%ebp
80104c3f:	83 ec 08             	sub    $0x8,%esp
80104c42:	89 75 fc             	mov    %esi,-0x4(%ebp)
	link->next = freeLinks;
80104c45:	8b 35 08 c6 10 80    	mov    0x8010c608,%esi
static Proc* dequeueRoundRobinQueue() {
80104c4b:	89 5d f8             	mov    %ebx,-0x8(%ebp)
	Link *next = first->next;
80104c4e:	8b 5a 04             	mov    0x4(%edx),%ebx
	Proc *p = first->p;
80104c51:	8b 02                	mov    (%edx),%eax
	link->next = freeLinks;
80104c53:	89 72 04             	mov    %esi,0x4(%edx)
	freeLinks = link;
80104c56:	89 15 08 c6 10 80    	mov    %edx,0x8010c608
	if(isEmpty())
80104c5c:	85 db                	test   %ebx,%ebx
	first = next;
80104c5e:	89 19                	mov    %ebx,(%ecx)
	if(isEmpty())
80104c60:	75 07                	jne    80104c69 <dequeueRoundRobinQueue+0x39>
		last = null;
80104c62:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
}
80104c69:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104c6c:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104c6f:	89 ec                	mov    %ebp,%esp
80104c71:	5d                   	pop    %ebp
80104c72:	c3                   	ret    
80104c73:	90                   	nop
80104c74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		return null;
80104c78:	31 c0                	xor    %eax,%eax
}
80104c7a:	c3                   	ret    
80104c7b:	90                   	nop
80104c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c80 <isEmptyRunningProcessHolder>:
	return !first;
80104c80:	a1 0c c6 10 80       	mov    0x8010c60c,%eax
static boolean isEmptyRunningProcessHolder() {
80104c85:	55                   	push   %ebp
80104c86:	89 e5                	mov    %esp,%ebp
}
80104c88:	5d                   	pop    %ebp
	return !first;
80104c89:	8b 00                	mov    (%eax),%eax
80104c8b:	85 c0                	test   %eax,%eax
80104c8d:	0f 94 c0             	sete   %al
80104c90:	0f b6 c0             	movzbl %al,%eax
}
80104c93:	c3                   	ret    
80104c94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104ca0 <addRunningProcessHolder>:
	if(!freeLinks)
80104ca0:	a1 08 c6 10 80       	mov    0x8010c608,%eax
80104ca5:	85 c0                	test   %eax,%eax
80104ca7:	74 47                	je     80104cf0 <addRunningProcessHolder+0x50>
static boolean addRunningProcessHolder(Proc* p) {
80104ca9:	55                   	push   %ebp
	return runningProcHolder->enqueue(p);
80104caa:	8b 0d 0c c6 10 80    	mov    0x8010c60c,%ecx
	freeLinks = freeLinks->next;
80104cb0:	8b 50 04             	mov    0x4(%eax),%edx
static boolean addRunningProcessHolder(Proc* p) {
80104cb3:	89 e5                	mov    %esp,%ebp
	ans->next = null;
80104cb5:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
80104cbc:	89 15 08 c6 10 80    	mov    %edx,0x8010c608
	ans->p = p;
80104cc2:	8b 55 08             	mov    0x8(%ebp),%edx
80104cc5:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80104cc7:	8b 11                	mov    (%ecx),%edx
80104cc9:	85 d2                	test   %edx,%edx
80104ccb:	74 2b                	je     80104cf8 <addRunningProcessHolder+0x58>
	else last->next = link;
80104ccd:	8b 51 04             	mov    0x4(%ecx),%edx
80104cd0:	89 42 04             	mov    %eax,0x4(%edx)
80104cd3:	eb 05                	jmp    80104cda <addRunningProcessHolder+0x3a>
80104cd5:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
80104cd8:	89 d0                	mov    %edx,%eax
80104cda:	8b 50 04             	mov    0x4(%eax),%edx
80104cdd:	85 d2                	test   %edx,%edx
80104cdf:	75 f7                	jne    80104cd8 <addRunningProcessHolder+0x38>
	last = link->getLast();
80104ce1:	89 41 04             	mov    %eax,0x4(%ecx)
80104ce4:	b8 01 00 00 00       	mov    $0x1,%eax
}
80104ce9:	5d                   	pop    %ebp
80104cea:	c3                   	ret    
80104ceb:	90                   	nop
80104cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!freeLinks)
80104cf0:	31 c0                	xor    %eax,%eax
}
80104cf2:	c3                   	ret    
80104cf3:	90                   	nop
80104cf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
80104cf8:	89 01                	mov    %eax,(%ecx)
80104cfa:	eb de                	jmp    80104cda <addRunningProcessHolder+0x3a>
80104cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104d00 <_ZL9allocNodeP4procx>:
static MapNode* allocNode(Proc *p, long long key) {
80104d00:	55                   	push   %ebp
80104d01:	89 e5                	mov    %esp,%ebp
80104d03:	56                   	push   %esi
80104d04:	53                   	push   %ebx
	if(!freeNodes)
80104d05:	8b 1d 04 c6 10 80    	mov    0x8010c604,%ebx
80104d0b:	85 db                	test   %ebx,%ebx
80104d0d:	74 4d                	je     80104d5c <_ZL9allocNodeP4procx+0x5c>
	ans->key = key;
80104d0f:	89 13                	mov    %edx,(%ebx)
	if(!freeLinks)
80104d11:	8b 15 08 c6 10 80    	mov    0x8010c608,%edx
	freeNodes = freeNodes->next;
80104d17:	8b 73 10             	mov    0x10(%ebx),%esi
	ans->key = key;
80104d1a:	89 4b 04             	mov    %ecx,0x4(%ebx)
	ans->next = null;
80104d1d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
	if(!freeLinks)
80104d24:	85 d2                	test   %edx,%edx
	freeNodes = freeNodes->next;
80104d26:	89 35 04 c6 10 80    	mov    %esi,0x8010c604
	if(!freeLinks)
80104d2c:	74 3f                	je     80104d6d <_ZL9allocNodeP4procx+0x6d>
	freeLinks = freeLinks->next;
80104d2e:	8b 4a 04             	mov    0x4(%edx),%ecx
	ans->p = p;
80104d31:	89 02                	mov    %eax,(%edx)
	ans->next = null;
80104d33:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
	if(isEmpty()) first = link;
80104d3a:	8b 43 08             	mov    0x8(%ebx),%eax
	freeLinks = freeLinks->next;
80104d3d:	89 0d 08 c6 10 80    	mov    %ecx,0x8010c608
	if(isEmpty()) first = link;
80104d43:	85 c0                	test   %eax,%eax
80104d45:	74 21                	je     80104d68 <_ZL9allocNodeP4procx+0x68>
	else last->next = link;
80104d47:	8b 43 0c             	mov    0xc(%ebx),%eax
80104d4a:	89 50 04             	mov    %edx,0x4(%eax)
80104d4d:	eb 03                	jmp    80104d52 <_ZL9allocNodeP4procx+0x52>
80104d4f:	90                   	nop
	while(ans->next)
80104d50:	89 ca                	mov    %ecx,%edx
80104d52:	8b 4a 04             	mov    0x4(%edx),%ecx
80104d55:	85 c9                	test   %ecx,%ecx
80104d57:	75 f7                	jne    80104d50 <_ZL9allocNodeP4procx+0x50>
	last = link->getLast();
80104d59:	89 53 0c             	mov    %edx,0xc(%ebx)
}
80104d5c:	89 d8                	mov    %ebx,%eax
80104d5e:	5b                   	pop    %ebx
80104d5f:	5e                   	pop    %esi
80104d60:	5d                   	pop    %ebp
80104d61:	c3                   	ret    
80104d62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	if(isEmpty()) first = link;
80104d68:	89 53 08             	mov    %edx,0x8(%ebx)
80104d6b:	eb e5                	jmp    80104d52 <_ZL9allocNodeP4procx+0x52>
	node->parent = node->left = node->right = null;
80104d6d:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
80104d74:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
80104d7b:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
	node->next = freeNodes;
80104d82:	89 73 10             	mov    %esi,0x10(%ebx)
	freeNodes = node;
80104d85:	89 1d 04 c6 10 80    	mov    %ebx,0x8010c604
		return null;
80104d8b:	31 db                	xor    %ebx,%ebx
80104d8d:	eb cd                	jmp    80104d5c <_ZL9allocNodeP4procx+0x5c>
80104d8f:	90                   	nop

80104d90 <_ZL8mymallocj>:
static char* mymalloc(uint size) {
80104d90:	55                   	push   %ebp
80104d91:	89 e5                	mov    %esp,%ebp
80104d93:	53                   	push   %ebx
80104d94:	89 c3                	mov    %eax,%ebx
80104d96:	83 ec 14             	sub    $0x14,%esp
	if(spaceLeft < size) {
80104d99:	8b 15 fc c5 10 80    	mov    0x8010c5fc,%edx
80104d9f:	39 c2                	cmp    %eax,%edx
80104da1:	73 26                	jae    80104dc9 <_ZL8mymallocj+0x39>
		data = kalloc();
80104da3:	e8 08 d8 ff ff       	call   801025b0 <kalloc>
		memset(data, 0, PGSIZE);
80104da8:	ba 00 10 00 00       	mov    $0x1000,%edx
80104dad:	31 c9                	xor    %ecx,%ecx
80104daf:	89 54 24 08          	mov    %edx,0x8(%esp)
80104db3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80104db7:	89 04 24             	mov    %eax,(%esp)
		data = kalloc();
80104dba:	a3 00 c6 10 80       	mov    %eax,0x8010c600
		memset(data, 0, PGSIZE);
80104dbf:	e8 fc 0d 00 00       	call   80105bc0 <memset>
80104dc4:	ba 00 10 00 00       	mov    $0x1000,%edx
	char* ans = data;
80104dc9:	a1 00 c6 10 80       	mov    0x8010c600,%eax
	spaceLeft -= size;
80104dce:	29 da                	sub    %ebx,%edx
80104dd0:	89 15 fc c5 10 80    	mov    %edx,0x8010c5fc
	data += size;
80104dd6:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
80104dd9:	89 0d 00 c6 10 80    	mov    %ecx,0x8010c600
}
80104ddf:	83 c4 14             	add    $0x14,%esp
80104de2:	5b                   	pop    %ebx
80104de3:	5d                   	pop    %ebp
80104de4:	c3                   	ret    
80104de5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104df0 <initSchedDS>:
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104df0:	55                   	push   %ebp
	data               = null;
80104df1:	31 c0                	xor    %eax,%eax
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104df3:	89 e5                	mov    %esp,%ebp
80104df5:	53                   	push   %ebx
	freeLinks = null;
80104df6:	bb 80 00 00 00       	mov    $0x80,%ebx
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104dfb:	83 ec 04             	sub    $0x4,%esp
	data               = null;
80104dfe:	a3 00 c6 10 80       	mov    %eax,0x8010c600
	spaceLeft          = 0u;
80104e03:	31 c0                	xor    %eax,%eax
80104e05:	a3 fc c5 10 80       	mov    %eax,0x8010c5fc
	priorityQ          = (Map*)mymalloc(sizeof(Map));
80104e0a:	b8 04 00 00 00       	mov    $0x4,%eax
80104e0f:	e8 7c ff ff ff       	call   80104d90 <_ZL8mymallocj>
80104e14:	a3 14 c6 10 80       	mov    %eax,0x8010c614
	*priorityQ         = Map();
80104e19:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	roundRobinQ        = (LinkedList*)mymalloc(sizeof(LinkedList));
80104e1f:	b8 08 00 00 00       	mov    $0x8,%eax
80104e24:	e8 67 ff ff ff       	call   80104d90 <_ZL8mymallocj>
80104e29:	a3 10 c6 10 80       	mov    %eax,0x8010c610
	*roundRobinQ       = LinkedList();
80104e2e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104e34:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	runningProcHolder  = (LinkedList*)mymalloc(sizeof(LinkedList));
80104e3b:	b8 08 00 00 00       	mov    $0x8,%eax
80104e40:	e8 4b ff ff ff       	call   80104d90 <_ZL8mymallocj>
80104e45:	a3 0c c6 10 80       	mov    %eax,0x8010c60c
	*runningProcHolder = LinkedList();
80104e4a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104e50:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = null;
80104e57:	31 c0                	xor    %eax,%eax
80104e59:	a3 08 c6 10 80       	mov    %eax,0x8010c608
80104e5e:	66 90                	xchg   %ax,%ax
		Link *link = (Link*)mymalloc(sizeof(Link));
80104e60:	b8 08 00 00 00       	mov    $0x8,%eax
80104e65:	e8 26 ff ff ff       	call   80104d90 <_ZL8mymallocj>
		link->next = freeLinks;
80104e6a:	8b 15 08 c6 10 80    	mov    0x8010c608,%edx
	for(int i = 0; i < NPROCLIST; ++i) {
80104e70:	4b                   	dec    %ebx
		*link = Link();
80104e71:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		link->next = freeLinks;
80104e77:	89 50 04             	mov    %edx,0x4(%eax)
		freeLinks = link;
80104e7a:	a3 08 c6 10 80       	mov    %eax,0x8010c608
	for(int i = 0; i < NPROCLIST; ++i) {
80104e7f:	75 df                	jne    80104e60 <initSchedDS+0x70>
	freeNodes = null;
80104e81:	31 c0                	xor    %eax,%eax
80104e83:	bb 80 00 00 00       	mov    $0x80,%ebx
80104e88:	a3 04 c6 10 80       	mov    %eax,0x8010c604
80104e8d:	8d 76 00             	lea    0x0(%esi),%esi
		MapNode *node = (MapNode*)mymalloc(sizeof(MapNode));
80104e90:	b8 20 00 00 00       	mov    $0x20,%eax
80104e95:	e8 f6 fe ff ff       	call   80104d90 <_ZL8mymallocj>
		node->next = freeNodes;
80104e9a:	8b 15 04 c6 10 80    	mov    0x8010c604,%edx
	for(int i = 0; i < NPROCMAP; ++i) {
80104ea0:	4b                   	dec    %ebx
		*node = MapNode();
80104ea1:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80104ea8:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
80104eaf:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
80104eb6:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
80104ebd:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
		node->next = freeNodes;
80104ec4:	89 50 10             	mov    %edx,0x10(%eax)
		freeNodes = node;
80104ec7:	a3 04 c6 10 80       	mov    %eax,0x8010c604
	for(int i = 0; i < NPROCMAP; ++i) {
80104ecc:	75 c2                	jne    80104e90 <initSchedDS+0xa0>
	pq.isEmpty                      = isEmptyPriorityQueue;
80104ece:	b8 40 4b 10 80       	mov    $0x80104b40,%eax
	pq.put                          = putPriorityQueue;
80104ed3:	ba c0 54 10 80       	mov    $0x801054c0,%edx
	pq.isEmpty                      = isEmptyPriorityQueue;
80104ed8:	a3 e4 c5 10 80       	mov    %eax,0x8010c5e4
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
80104edd:	b8 80 56 10 80       	mov    $0x80105680,%eax
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
80104ee2:	b9 60 4b 10 80       	mov    $0x80104b60,%ecx
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
80104ee7:	a3 f4 c5 10 80       	mov    %eax,0x8010c5f4
	pq.extractProc                  = extractProcPriorityQueue;
80104eec:	b8 60 57 10 80       	mov    $0x80105760,%eax
	pq.extractMin                   = extractMinPriorityQueue;
80104ef1:	bb e0 55 10 80       	mov    $0x801055e0,%ebx
	pq.extractProc                  = extractProcPriorityQueue;
80104ef6:	a3 f8 c5 10 80       	mov    %eax,0x8010c5f8
	rrq.isEmpty                     = isEmptyRoundRobinQueue;
80104efb:	b8 b0 4b 10 80       	mov    $0x80104bb0,%eax
80104f00:	a3 d4 c5 10 80       	mov    %eax,0x8010c5d4
	rrq.enqueue                     = enqueueRoundRobinQueue;
80104f05:	b8 d0 4b 10 80       	mov    $0x80104bd0,%eax
80104f0a:	a3 d8 c5 10 80       	mov    %eax,0x8010c5d8
	rrq.dequeue                     = dequeueRoundRobinQueue;
80104f0f:	b8 30 4c 10 80       	mov    $0x80104c30,%eax
80104f14:	a3 dc c5 10 80       	mov    %eax,0x8010c5dc
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;
80104f19:	b8 f0 51 10 80       	mov    $0x801051f0,%eax
	pq.put                          = putPriorityQueue;
80104f1e:	89 15 e8 c5 10 80    	mov    %edx,0x8010c5e8
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
80104f24:	ba 80 4c 10 80       	mov    $0x80104c80,%edx
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
80104f29:	89 0d ec c5 10 80    	mov    %ecx,0x8010c5ec
	rpholder.add                    = addRunningProcessHolder;
80104f2f:	b9 a0 4c 10 80       	mov    $0x80104ca0,%ecx
	pq.extractMin                   = extractMinPriorityQueue;
80104f34:	89 1d f0 c5 10 80    	mov    %ebx,0x8010c5f0
	rpholder.remove                 = removeRunningProcessHolder;
80104f3a:	bb 50 51 10 80       	mov    $0x80105150,%ebx
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;
80104f3f:	a3 e0 c5 10 80       	mov    %eax,0x8010c5e0
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
80104f44:	b8 80 52 10 80       	mov    $0x80105280,%eax
	rpholder.remove                 = removeRunningProcessHolder;
80104f49:	89 1d cc c5 10 80    	mov    %ebx,0x8010c5cc
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
80104f4f:	89 15 c4 c5 10 80    	mov    %edx,0x8010c5c4
	rpholder.add                    = addRunningProcessHolder;
80104f55:	89 0d c8 c5 10 80    	mov    %ecx,0x8010c5c8
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
80104f5b:	a3 d0 c5 10 80       	mov    %eax,0x8010c5d0
}
80104f60:	58                   	pop    %eax
80104f61:	5b                   	pop    %ebx
80104f62:	5d                   	pop    %ebp
80104f63:	c3                   	ret    
80104f64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104f70 <_ZN4Link7getLastEv>:
Link* Link::getLast() {
80104f70:	55                   	push   %ebp
80104f71:	89 e5                	mov    %esp,%ebp
80104f73:	8b 45 08             	mov    0x8(%ebp),%eax
80104f76:	eb 0a                	jmp    80104f82 <_ZN4Link7getLastEv+0x12>
80104f78:	90                   	nop
80104f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f80:	89 d0                	mov    %edx,%eax
	while(ans->next)
80104f82:	8b 50 04             	mov    0x4(%eax),%edx
80104f85:	85 d2                	test   %edx,%edx
80104f87:	75 f7                	jne    80104f80 <_ZN4Link7getLastEv+0x10>
}
80104f89:	5d                   	pop    %ebp
80104f8a:	c3                   	ret    
80104f8b:	90                   	nop
80104f8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104f90 <_ZN10LinkedList7isEmptyEv>:
bool LinkedList::isEmpty() {
80104f90:	55                   	push   %ebp
80104f91:	89 e5                	mov    %esp,%ebp
	return !first;
80104f93:	8b 45 08             	mov    0x8(%ebp),%eax
}
80104f96:	5d                   	pop    %ebp
	return !first;
80104f97:	8b 00                	mov    (%eax),%eax
80104f99:	85 c0                	test   %eax,%eax
80104f9b:	0f 94 c0             	sete   %al
}
80104f9e:	c3                   	ret    
80104f9f:	90                   	nop

80104fa0 <_ZN10LinkedList6appendEP4Link>:
void LinkedList::append(Link *link) {
80104fa0:	55                   	push   %ebp
80104fa1:	89 e5                	mov    %esp,%ebp
80104fa3:	8b 55 0c             	mov    0xc(%ebp),%edx
80104fa6:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!link)
80104fa9:	85 d2                	test   %edx,%edx
80104fab:	74 1f                	je     80104fcc <_ZN10LinkedList6appendEP4Link+0x2c>
	if(isEmpty()) first = link;
80104fad:	8b 01                	mov    (%ecx),%eax
80104faf:	85 c0                	test   %eax,%eax
80104fb1:	74 1d                	je     80104fd0 <_ZN10LinkedList6appendEP4Link+0x30>
	else last->next = link;
80104fb3:	8b 41 04             	mov    0x4(%ecx),%eax
80104fb6:	89 50 04             	mov    %edx,0x4(%eax)
80104fb9:	eb 07                	jmp    80104fc2 <_ZN10LinkedList6appendEP4Link+0x22>
80104fbb:	90                   	nop
80104fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	while(ans->next)
80104fc0:	89 c2                	mov    %eax,%edx
80104fc2:	8b 42 04             	mov    0x4(%edx),%eax
80104fc5:	85 c0                	test   %eax,%eax
80104fc7:	75 f7                	jne    80104fc0 <_ZN10LinkedList6appendEP4Link+0x20>
	last = link->getLast();
80104fc9:	89 51 04             	mov    %edx,0x4(%ecx)
}
80104fcc:	5d                   	pop    %ebp
80104fcd:	c3                   	ret    
80104fce:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
80104fd0:	89 11                	mov    %edx,(%ecx)
80104fd2:	eb ee                	jmp    80104fc2 <_ZN10LinkedList6appendEP4Link+0x22>
80104fd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104fda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104fe0 <_ZN10LinkedList7enqueueEP4proc>:
	if(!freeLinks)
80104fe0:	a1 08 c6 10 80       	mov    0x8010c608,%eax
bool LinkedList::enqueue(Proc *p) {
80104fe5:	55                   	push   %ebp
80104fe6:	89 e5                	mov    %esp,%ebp
80104fe8:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!freeLinks)
80104feb:	85 c0                	test   %eax,%eax
80104fed:	74 41                	je     80105030 <_ZN10LinkedList7enqueueEP4proc+0x50>
	freeLinks = freeLinks->next;
80104fef:	8b 50 04             	mov    0x4(%eax),%edx
	ans->next = null;
80104ff2:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
80104ff9:	89 15 08 c6 10 80    	mov    %edx,0x8010c608
	ans->p = p;
80104fff:	8b 55 0c             	mov    0xc(%ebp),%edx
80105002:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80105004:	8b 11                	mov    (%ecx),%edx
80105006:	85 d2                	test   %edx,%edx
80105008:	74 2e                	je     80105038 <_ZN10LinkedList7enqueueEP4proc+0x58>
	else last->next = link;
8010500a:	8b 51 04             	mov    0x4(%ecx),%edx
8010500d:	89 42 04             	mov    %eax,0x4(%edx)
80105010:	eb 08                	jmp    8010501a <_ZN10LinkedList7enqueueEP4proc+0x3a>
80105012:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	while(ans->next)
80105018:	89 d0                	mov    %edx,%eax
8010501a:	8b 50 04             	mov    0x4(%eax),%edx
8010501d:	85 d2                	test   %edx,%edx
8010501f:	75 f7                	jne    80105018 <_ZN10LinkedList7enqueueEP4proc+0x38>
	last = link->getLast();
80105021:	89 41 04             	mov    %eax,0x4(%ecx)
	return true;
80105024:	b0 01                	mov    $0x1,%al
}
80105026:	5d                   	pop    %ebp
80105027:	c3                   	ret    
80105028:	90                   	nop
80105029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return false;
80105030:	31 c0                	xor    %eax,%eax
}
80105032:	5d                   	pop    %ebp
80105033:	c3                   	ret    
80105034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
80105038:	89 01                	mov    %eax,(%ecx)
8010503a:	eb de                	jmp    8010501a <_ZN10LinkedList7enqueueEP4proc+0x3a>
8010503c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105040 <_ZN10LinkedList7dequeueEv>:
Proc* LinkedList::dequeue() {
80105040:	55                   	push   %ebp
80105041:	89 e5                	mov    %esp,%ebp
80105043:	83 ec 08             	sub    $0x8,%esp
80105046:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105049:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010504c:	89 75 fc             	mov    %esi,-0x4(%ebp)
	return !first;
8010504f:	8b 11                	mov    (%ecx),%edx
	if(isEmpty())
80105051:	85 d2                	test   %edx,%edx
80105053:	74 2b                	je     80105080 <_ZN10LinkedList7dequeueEv+0x40>
	Link *next = first->next;
80105055:	8b 5a 04             	mov    0x4(%edx),%ebx
	link->next = freeLinks;
80105058:	8b 35 08 c6 10 80    	mov    0x8010c608,%esi
	Proc *p = first->p;
8010505e:	8b 02                	mov    (%edx),%eax
	freeLinks = link;
80105060:	89 15 08 c6 10 80    	mov    %edx,0x8010c608
	if(isEmpty())
80105066:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
80105068:	89 72 04             	mov    %esi,0x4(%edx)
	first = next;
8010506b:	89 19                	mov    %ebx,(%ecx)
	if(isEmpty())
8010506d:	75 07                	jne    80105076 <_ZN10LinkedList7dequeueEv+0x36>
		last = null;
8010506f:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
}
80105076:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105079:	8b 75 fc             	mov    -0x4(%ebp),%esi
8010507c:	89 ec                	mov    %ebp,%esp
8010507e:	5d                   	pop    %ebp
8010507f:	c3                   	ret    
		return null;
80105080:	31 c0                	xor    %eax,%eax
80105082:	eb f2                	jmp    80105076 <_ZN10LinkedList7dequeueEv+0x36>
80105084:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010508a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105090 <_ZN10LinkedList6removeEP4proc>:
bool LinkedList::remove(Proc *p) {
80105090:	55                   	push   %ebp
80105091:	89 e5                	mov    %esp,%ebp
80105093:	56                   	push   %esi
80105094:	8b 75 08             	mov    0x8(%ebp),%esi
80105097:	53                   	push   %ebx
80105098:	8b 4d 0c             	mov    0xc(%ebp),%ecx
	return !first;
8010509b:	8b 1e                	mov    (%esi),%ebx
	if(isEmpty())
8010509d:	85 db                	test   %ebx,%ebx
8010509f:	74 2f                	je     801050d0 <_ZN10LinkedList6removeEP4proc+0x40>
	if(first->p == p) {
801050a1:	39 0b                	cmp    %ecx,(%ebx)
801050a3:	8b 53 04             	mov    0x4(%ebx),%edx
801050a6:	74 70                	je     80105118 <_ZN10LinkedList6removeEP4proc+0x88>
	while(cur) {
801050a8:	85 d2                	test   %edx,%edx
801050aa:	74 24                	je     801050d0 <_ZN10LinkedList6removeEP4proc+0x40>
		if(cur->p == p) {
801050ac:	3b 0a                	cmp    (%edx),%ecx
801050ae:	66 90                	xchg   %ax,%ax
801050b0:	75 0c                	jne    801050be <_ZN10LinkedList6removeEP4proc+0x2e>
801050b2:	eb 2c                	jmp    801050e0 <_ZN10LinkedList6removeEP4proc+0x50>
801050b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801050b8:	39 08                	cmp    %ecx,(%eax)
801050ba:	74 34                	je     801050f0 <_ZN10LinkedList6removeEP4proc+0x60>
801050bc:	89 c2                	mov    %eax,%edx
		cur = cur->next;
801050be:	8b 42 04             	mov    0x4(%edx),%eax
	while(cur) {
801050c1:	85 c0                	test   %eax,%eax
801050c3:	75 f3                	jne    801050b8 <_ZN10LinkedList6removeEP4proc+0x28>
}
801050c5:	5b                   	pop    %ebx
801050c6:	5e                   	pop    %esi
801050c7:	5d                   	pop    %ebp
801050c8:	c3                   	ret    
801050c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050d0:	5b                   	pop    %ebx
		return false;
801050d1:	31 c0                	xor    %eax,%eax
}
801050d3:	5e                   	pop    %esi
801050d4:	5d                   	pop    %ebp
801050d5:	c3                   	ret    
801050d6:	8d 76 00             	lea    0x0(%esi),%esi
801050d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		if(cur->p == p) {
801050e0:	89 d0                	mov    %edx,%eax
801050e2:	89 da                	mov    %ebx,%edx
801050e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801050ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
			prev->next = cur->next;
801050f0:	8b 48 04             	mov    0x4(%eax),%ecx
801050f3:	89 4a 04             	mov    %ecx,0x4(%edx)
			if(!(cur->next)) //removes the last link
801050f6:	8b 48 04             	mov    0x4(%eax),%ecx
801050f9:	85 c9                	test   %ecx,%ecx
801050fb:	74 43                	je     80105140 <_ZN10LinkedList6removeEP4proc+0xb0>
	link->next = freeLinks;
801050fd:	8b 15 08 c6 10 80    	mov    0x8010c608,%edx
	freeLinks = link;
80105103:	a3 08 c6 10 80       	mov    %eax,0x8010c608
	link->next = freeLinks;
80105108:	89 50 04             	mov    %edx,0x4(%eax)
			return true;
8010510b:	b0 01                	mov    $0x1,%al
}
8010510d:	5b                   	pop    %ebx
8010510e:	5e                   	pop    %esi
8010510f:	5d                   	pop    %ebp
80105110:	c3                   	ret    
80105111:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	link->next = freeLinks;
80105118:	a1 08 c6 10 80       	mov    0x8010c608,%eax
	if(isEmpty())
8010511d:	85 d2                	test   %edx,%edx
	freeLinks = link;
8010511f:	89 1d 08 c6 10 80    	mov    %ebx,0x8010c608
	link->next = freeLinks;
80105125:	89 43 04             	mov    %eax,0x4(%ebx)
		return true;
80105128:	b0 01                	mov    $0x1,%al
	first = next;
8010512a:	89 16                	mov    %edx,(%esi)
	if(isEmpty())
8010512c:	75 97                	jne    801050c5 <_ZN10LinkedList6removeEP4proc+0x35>
		last = null;
8010512e:	c7 46 04 00 00 00 00 	movl   $0x0,0x4(%esi)
80105135:	eb 8e                	jmp    801050c5 <_ZN10LinkedList6removeEP4proc+0x35>
80105137:	89 f6                	mov    %esi,%esi
80105139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
				last = prev;
80105140:	89 56 04             	mov    %edx,0x4(%esi)
80105143:	eb b8                	jmp    801050fd <_ZN10LinkedList6removeEP4proc+0x6d>
80105145:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105150 <removeRunningProcessHolder>:
static boolean removeRunningProcessHolder(Proc* p) {
80105150:	55                   	push   %ebp
80105151:	89 e5                	mov    %esp,%ebp
80105153:	83 ec 08             	sub    $0x8,%esp
	return runningProcHolder->remove(p);
80105156:	8b 45 08             	mov    0x8(%ebp),%eax
80105159:	89 44 24 04          	mov    %eax,0x4(%esp)
8010515d:	a1 0c c6 10 80       	mov    0x8010c60c,%eax
80105162:	89 04 24             	mov    %eax,(%esp)
80105165:	e8 26 ff ff ff       	call   80105090 <_ZN10LinkedList6removeEP4proc>
}
8010516a:	c9                   	leave  
	return runningProcHolder->remove(p);
8010516b:	0f b6 c0             	movzbl %al,%eax
}
8010516e:	c3                   	ret    
8010516f:	90                   	nop

80105170 <_ZN10LinkedList8transferEv>:
	if(!priorityQ->isEmpty())
80105170:	8b 15 14 c6 10 80    	mov    0x8010c614,%edx
		return false;
80105176:	31 c0                	xor    %eax,%eax
bool LinkedList::transfer() {
80105178:	55                   	push   %ebp
80105179:	89 e5                	mov    %esp,%ebp
8010517b:	53                   	push   %ebx
8010517c:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!priorityQ->isEmpty())
8010517f:	8b 1a                	mov    (%edx),%ebx
80105181:	85 db                	test   %ebx,%ebx
80105183:	74 0b                	je     80105190 <_ZN10LinkedList8transferEv+0x20>
}
80105185:	5b                   	pop    %ebx
80105186:	5d                   	pop    %ebp
80105187:	c3                   	ret    
80105188:	90                   	nop
80105189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	if(!isEmpty()) {
80105190:	8b 19                	mov    (%ecx),%ebx
80105192:	85 db                	test   %ebx,%ebx
80105194:	74 4a                	je     801051e0 <_ZN10LinkedList8transferEv+0x70>
	if(!freeNodes)
80105196:	8b 1d 04 c6 10 80    	mov    0x8010c604,%ebx
8010519c:	85 db                	test   %ebx,%ebx
8010519e:	74 e5                	je     80105185 <_ZN10LinkedList8transferEv+0x15>
	freeNodes = freeNodes->next;
801051a0:	8b 43 10             	mov    0x10(%ebx),%eax
	ans->key = key;
801051a3:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
	ans->next = null;
801051a9:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
	ans->key = key;
801051b0:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
	freeNodes = freeNodes->next;
801051b7:	a3 04 c6 10 80       	mov    %eax,0x8010c604
		node->listOfProcs.first = first;
801051bc:	8b 01                	mov    (%ecx),%eax
801051be:	89 43 08             	mov    %eax,0x8(%ebx)
		node->listOfProcs.last = last;
801051c1:	8b 41 04             	mov    0x4(%ecx),%eax
801051c4:	89 43 0c             	mov    %eax,0xc(%ebx)
	return true;
801051c7:	b0 01                	mov    $0x1,%al
		first = last = null;
801051c9:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
801051d0:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
		priorityQ->root = node;
801051d6:	89 1a                	mov    %ebx,(%edx)
}
801051d8:	5b                   	pop    %ebx
801051d9:	5d                   	pop    %ebp
801051da:	c3                   	ret    
801051db:	90                   	nop
801051dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	return true;
801051e0:	b0 01                	mov    $0x1,%al
801051e2:	eb a1                	jmp    80105185 <_ZN10LinkedList8transferEv+0x15>
801051e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801051ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801051f0 <switchToPriorityQueuePolicyRoundRobinQueue>:
static boolean switchToPriorityQueuePolicyRoundRobinQueue() {
801051f0:	55                   	push   %ebp
801051f1:	89 e5                	mov    %esp,%ebp
801051f3:	83 ec 04             	sub    $0x4,%esp
	return roundRobinQ->transfer();
801051f6:	a1 10 c6 10 80       	mov    0x8010c610,%eax
801051fb:	89 04 24             	mov    %eax,(%esp)
801051fe:	e8 6d ff ff ff       	call   80105170 <_ZN10LinkedList8transferEv>
}
80105203:	c9                   	leave  
	return roundRobinQ->transfer();
80105204:	0f b6 c0             	movzbl %al,%eax
}
80105207:	c3                   	ret    
80105208:	90                   	nop
80105209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105210 <_ZN10LinkedList9getMinKeyEPx>:
bool LinkedList::getMinKey(long long *pkey) {
80105210:	55                   	push   %ebp
80105211:	31 c0                	xor    %eax,%eax
80105213:	89 e5                	mov    %esp,%ebp
80105215:	57                   	push   %edi
80105216:	56                   	push   %esi
80105217:	53                   	push   %ebx
80105218:	83 ec 1c             	sub    $0x1c,%esp
8010521b:	8b 7d 08             	mov    0x8(%ebp),%edi
	return !first;
8010521e:	8b 17                	mov    (%edi),%edx
	if(isEmpty())
80105220:	85 d2                	test   %edx,%edx
80105222:	74 41                	je     80105265 <_ZN10LinkedList9getMinKeyEPx+0x55>
	long long minKey = getAccumulator(first->p);
80105224:	8b 02                	mov    (%edx),%eax
80105226:	89 04 24             	mov    %eax,(%esp)
80105229:	e8 72 e6 ff ff       	call   801038a0 <getAccumulator>
	forEach([&](Proc *p) {
8010522e:	8b 3f                	mov    (%edi),%edi
	void append(Link *link); //appends the given list to the queue. No allocations always succeeds.
	
	template<typename Func>
	void forEach(const Func& accept) { //for-each loop. gets a function that applies the procin each link node.
		Link *link = first;
		while(link) {
80105230:	85 ff                	test   %edi,%edi
	long long minKey = getAccumulator(first->p);
80105232:	89 c6                	mov    %eax,%esi
80105234:	89 d3                	mov    %edx,%ebx
80105236:	74 23                	je     8010525b <_ZN10LinkedList9getMinKeyEPx+0x4b>
80105238:	90                   	nop
80105239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		long long key = getAccumulator(p);
80105240:	8b 07                	mov    (%edi),%eax
80105242:	89 04 24             	mov    %eax,(%esp)
80105245:	e8 56 e6 ff ff       	call   801038a0 <getAccumulator>
8010524a:	39 d3                	cmp    %edx,%ebx
8010524c:	7c 06                	jl     80105254 <_ZN10LinkedList9getMinKeyEPx+0x44>
8010524e:	7f 20                	jg     80105270 <_ZN10LinkedList9getMinKeyEPx+0x60>
80105250:	39 c6                	cmp    %eax,%esi
80105252:	77 1c                	ja     80105270 <_ZN10LinkedList9getMinKeyEPx+0x60>
			accept(link->p);
			link = link->next;
80105254:	8b 7f 04             	mov    0x4(%edi),%edi
		while(link) {
80105257:	85 ff                	test   %edi,%edi
80105259:	75 e5                	jne    80105240 <_ZN10LinkedList9getMinKeyEPx+0x30>
	*pkey = minKey;
8010525b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010525e:	89 30                	mov    %esi,(%eax)
80105260:	89 58 04             	mov    %ebx,0x4(%eax)
	return true;
80105263:	b0 01                	mov    $0x1,%al
}
80105265:	83 c4 1c             	add    $0x1c,%esp
80105268:	5b                   	pop    %ebx
80105269:	5e                   	pop    %esi
8010526a:	5f                   	pop    %edi
8010526b:	5d                   	pop    %ebp
8010526c:	c3                   	ret    
8010526d:	8d 76 00             	lea    0x0(%esi),%esi
			link = link->next;
80105270:	8b 7f 04             	mov    0x4(%edi),%edi
80105273:	89 c6                	mov    %eax,%esi
80105275:	89 d3                	mov    %edx,%ebx
		while(link) {
80105277:	85 ff                	test   %edi,%edi
80105279:	75 c5                	jne    80105240 <_ZN10LinkedList9getMinKeyEPx+0x30>
8010527b:	eb de                	jmp    8010525b <_ZN10LinkedList9getMinKeyEPx+0x4b>
8010527d:	8d 76 00             	lea    0x0(%esi),%esi

80105280 <getMinAccumulatorRunningProcessHolder>:
static boolean getMinAccumulatorRunningProcessHolder(long long *pkey) {
80105280:	55                   	push   %ebp
80105281:	89 e5                	mov    %esp,%ebp
80105283:	83 ec 18             	sub    $0x18,%esp
	return runningProcHolder->getMinKey(pkey);
80105286:	8b 45 08             	mov    0x8(%ebp),%eax
80105289:	89 44 24 04          	mov    %eax,0x4(%esp)
8010528d:	a1 0c c6 10 80       	mov    0x8010c60c,%eax
80105292:	89 04 24             	mov    %eax,(%esp)
80105295:	e8 76 ff ff ff       	call   80105210 <_ZN10LinkedList9getMinKeyEPx>
}
8010529a:	c9                   	leave  
	return runningProcHolder->getMinKey(pkey);
8010529b:	0f b6 c0             	movzbl %al,%eax
}
8010529e:	c3                   	ret    
8010529f:	90                   	nop

801052a0 <_ZN7MapNode7isEmptyEv>:
bool MapNode::isEmpty() {
801052a0:	55                   	push   %ebp
801052a1:	89 e5                	mov    %esp,%ebp
	return !first;
801052a3:	8b 45 08             	mov    0x8(%ebp),%eax
}
801052a6:	5d                   	pop    %ebp
	return !first;
801052a7:	8b 40 08             	mov    0x8(%eax),%eax
801052aa:	85 c0                	test   %eax,%eax
801052ac:	0f 94 c0             	sete   %al
}
801052af:	c3                   	ret    

801052b0 <_ZN7MapNode3putEP4proc>:
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
801052b0:	55                   	push   %ebp
801052b1:	89 e5                	mov    %esp,%ebp
801052b3:	57                   	push   %edi
801052b4:	56                   	push   %esi
801052b5:	53                   	push   %ebx
801052b6:	83 ec 2c             	sub    $0x2c,%esp
	long long key = getAccumulator(p);
801052b9:	8b 45 0c             	mov    0xc(%ebp),%eax
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
801052bc:	8b 5d 08             	mov    0x8(%ebp),%ebx
	long long key = getAccumulator(p);
801052bf:	89 04 24             	mov    %eax,(%esp)
801052c2:	e8 d9 e5 ff ff       	call   801038a0 <getAccumulator>
801052c7:	89 d1                	mov    %edx,%ecx
801052c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801052cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		if(key == node->key)
801052d0:	8b 13                	mov    (%ebx),%edx
801052d2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801052d5:	8b 43 04             	mov    0x4(%ebx),%eax
801052d8:	31 d7                	xor    %edx,%edi
801052da:	89 fe                	mov    %edi,%esi
801052dc:	89 c7                	mov    %eax,%edi
801052de:	31 cf                	xor    %ecx,%edi
801052e0:	09 fe                	or     %edi,%esi
801052e2:	74 4c                	je     80105330 <_ZN7MapNode3putEP4proc+0x80>
		else if(key < node->key) { //left
801052e4:	39 c8                	cmp    %ecx,%eax
801052e6:	7c 20                	jl     80105308 <_ZN7MapNode3putEP4proc+0x58>
801052e8:	7f 08                	jg     801052f2 <_ZN7MapNode3putEP4proc+0x42>
801052ea:	3b 55 e4             	cmp    -0x1c(%ebp),%edx
801052ed:	8d 76 00             	lea    0x0(%esi),%esi
801052f0:	76 16                	jbe    80105308 <_ZN7MapNode3putEP4proc+0x58>
			if(node->left)
801052f2:	8b 43 18             	mov    0x18(%ebx),%eax
801052f5:	85 c0                	test   %eax,%eax
801052f7:	0f 84 83 00 00 00    	je     80105380 <_ZN7MapNode3putEP4proc+0xd0>
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
801052fd:	89 c3                	mov    %eax,%ebx
801052ff:	eb cf                	jmp    801052d0 <_ZN7MapNode3putEP4proc+0x20>
80105301:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			if(node->right)
80105308:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010530b:	85 c0                	test   %eax,%eax
8010530d:	75 ee                	jne    801052fd <_ZN7MapNode3putEP4proc+0x4d>
8010530f:	8b 75 e4             	mov    -0x1c(%ebp),%esi
				node->right = allocNode(p, key);
80105312:	8b 45 0c             	mov    0xc(%ebp),%eax
80105315:	89 f2                	mov    %esi,%edx
80105317:	e8 e4 f9 ff ff       	call   80104d00 <_ZL9allocNodeP4procx>
				if(node->right) {
8010531c:	85 c0                	test   %eax,%eax
				node->right = allocNode(p, key);
8010531e:	89 43 1c             	mov    %eax,0x1c(%ebx)
				if(node->right) {
80105321:	74 71                	je     80105394 <_ZN7MapNode3putEP4proc+0xe4>
					node->right->parent = node;
80105323:	89 58 14             	mov    %ebx,0x14(%eax)
}
80105326:	83 c4 2c             	add    $0x2c,%esp
					return true;
80105329:	b0 01                	mov    $0x1,%al
}
8010532b:	5b                   	pop    %ebx
8010532c:	5e                   	pop    %esi
8010532d:	5f                   	pop    %edi
8010532e:	5d                   	pop    %ebp
8010532f:	c3                   	ret    
	if(!freeLinks)
80105330:	a1 08 c6 10 80       	mov    0x8010c608,%eax
80105335:	85 c0                	test   %eax,%eax
80105337:	74 5b                	je     80105394 <_ZN7MapNode3putEP4proc+0xe4>
	ans->p = p;
80105339:	8b 75 0c             	mov    0xc(%ebp),%esi
	freeLinks = freeLinks->next;
8010533c:	8b 50 04             	mov    0x4(%eax),%edx
	ans->next = null;
8010533f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	ans->p = p;
80105346:	89 30                	mov    %esi,(%eax)
	freeLinks = freeLinks->next;
80105348:	89 15 08 c6 10 80    	mov    %edx,0x8010c608
	if(isEmpty()) first = link;
8010534e:	8b 53 08             	mov    0x8(%ebx),%edx
80105351:	85 d2                	test   %edx,%edx
80105353:	74 4b                	je     801053a0 <_ZN7MapNode3putEP4proc+0xf0>
	else last->next = link;
80105355:	8b 53 0c             	mov    0xc(%ebx),%edx
80105358:	89 42 04             	mov    %eax,0x4(%edx)
8010535b:	eb 05                	jmp    80105362 <_ZN7MapNode3putEP4proc+0xb2>
8010535d:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
80105360:	89 d0                	mov    %edx,%eax
80105362:	8b 50 04             	mov    0x4(%eax),%edx
80105365:	85 d2                	test   %edx,%edx
80105367:	75 f7                	jne    80105360 <_ZN7MapNode3putEP4proc+0xb0>
	last = link->getLast();
80105369:	89 43 0c             	mov    %eax,0xc(%ebx)
}
8010536c:	83 c4 2c             	add    $0x2c,%esp
	return true;
8010536f:	b0 01                	mov    $0x1,%al
}
80105371:	5b                   	pop    %ebx
80105372:	5e                   	pop    %esi
80105373:	5f                   	pop    %edi
80105374:	5d                   	pop    %ebp
80105375:	c3                   	ret    
80105376:	8d 76 00             	lea    0x0(%esi),%esi
80105379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105380:	8b 75 e4             	mov    -0x1c(%ebp),%esi
				node->left = allocNode(p, key);
80105383:	8b 45 0c             	mov    0xc(%ebp),%eax
80105386:	89 f2                	mov    %esi,%edx
80105388:	e8 73 f9 ff ff       	call   80104d00 <_ZL9allocNodeP4procx>
				if(node->left) {
8010538d:	85 c0                	test   %eax,%eax
				node->left = allocNode(p, key);
8010538f:	89 43 18             	mov    %eax,0x18(%ebx)
				if(node->left) {
80105392:	75 8f                	jne    80105323 <_ZN7MapNode3putEP4proc+0x73>
}
80105394:	83 c4 2c             	add    $0x2c,%esp
		return false;
80105397:	31 c0                	xor    %eax,%eax
}
80105399:	5b                   	pop    %ebx
8010539a:	5e                   	pop    %esi
8010539b:	5f                   	pop    %edi
8010539c:	5d                   	pop    %ebp
8010539d:	c3                   	ret    
8010539e:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
801053a0:	89 43 08             	mov    %eax,0x8(%ebx)
801053a3:	eb bd                	jmp    80105362 <_ZN7MapNode3putEP4proc+0xb2>
801053a5:	90                   	nop
801053a6:	8d 76 00             	lea    0x0(%esi),%esi
801053a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801053b0 <_ZN7MapNode10getMinNodeEv>:
MapNode* MapNode::getMinNode() { //no recursion.
801053b0:	55                   	push   %ebp
801053b1:	89 e5                	mov    %esp,%ebp
801053b3:	8b 45 08             	mov    0x8(%ebp),%eax
801053b6:	eb 0a                	jmp    801053c2 <_ZN7MapNode10getMinNodeEv+0x12>
801053b8:	90                   	nop
801053b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801053c0:	89 d0                	mov    %edx,%eax
	while(minNode->left)
801053c2:	8b 50 18             	mov    0x18(%eax),%edx
801053c5:	85 d2                	test   %edx,%edx
801053c7:	75 f7                	jne    801053c0 <_ZN7MapNode10getMinNodeEv+0x10>
}
801053c9:	5d                   	pop    %ebp
801053ca:	c3                   	ret    
801053cb:	90                   	nop
801053cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801053d0 <_ZN7MapNode9getMinKeyEPx>:
void MapNode::getMinKey(long long *pkey) {
801053d0:	55                   	push   %ebp
801053d1:	89 e5                	mov    %esp,%ebp
801053d3:	8b 55 08             	mov    0x8(%ebp),%edx
801053d6:	53                   	push   %ebx
801053d7:	eb 09                	jmp    801053e2 <_ZN7MapNode9getMinKeyEPx+0x12>
801053d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	while(minNode->left)
801053e0:	89 c2                	mov    %eax,%edx
801053e2:	8b 42 18             	mov    0x18(%edx),%eax
801053e5:	85 c0                	test   %eax,%eax
801053e7:	75 f7                	jne    801053e0 <_ZN7MapNode9getMinKeyEPx+0x10>
	*pkey = getMinNode()->key;
801053e9:	8b 5a 04             	mov    0x4(%edx),%ebx
801053ec:	8b 45 0c             	mov    0xc(%ebp),%eax
801053ef:	8b 0a                	mov    (%edx),%ecx
801053f1:	89 58 04             	mov    %ebx,0x4(%eax)
801053f4:	89 08                	mov    %ecx,(%eax)
}
801053f6:	5b                   	pop    %ebx
801053f7:	5d                   	pop    %ebp
801053f8:	c3                   	ret    
801053f9:	90                   	nop
801053fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105400 <_ZN7MapNode7dequeueEv>:
Proc* MapNode::dequeue() {
80105400:	55                   	push   %ebp
80105401:	89 e5                	mov    %esp,%ebp
80105403:	83 ec 08             	sub    $0x8,%esp
80105406:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105409:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010540c:	89 75 fc             	mov    %esi,-0x4(%ebp)
	return !first;
8010540f:	8b 51 08             	mov    0x8(%ecx),%edx
	if(isEmpty())
80105412:	85 d2                	test   %edx,%edx
80105414:	74 32                	je     80105448 <_ZN7MapNode7dequeueEv+0x48>
	Link *next = first->next;
80105416:	8b 5a 04             	mov    0x4(%edx),%ebx
	link->next = freeLinks;
80105419:	8b 35 08 c6 10 80    	mov    0x8010c608,%esi
	Proc *p = first->p;
8010541f:	8b 02                	mov    (%edx),%eax
	freeLinks = link;
80105421:	89 15 08 c6 10 80    	mov    %edx,0x8010c608
	if(isEmpty())
80105427:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
80105429:	89 72 04             	mov    %esi,0x4(%edx)
	first = next;
8010542c:	89 59 08             	mov    %ebx,0x8(%ecx)
	if(isEmpty())
8010542f:	75 07                	jne    80105438 <_ZN7MapNode7dequeueEv+0x38>
		last = null;
80105431:	c7 41 0c 00 00 00 00 	movl   $0x0,0xc(%ecx)
}
80105438:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010543b:	8b 75 fc             	mov    -0x4(%ebp),%esi
8010543e:	89 ec                	mov    %ebp,%esp
80105440:	5d                   	pop    %ebp
80105441:	c3                   	ret    
80105442:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		return null;
80105448:	31 c0                	xor    %eax,%eax
	return listOfProcs.dequeue();
8010544a:	eb ec                	jmp    80105438 <_ZN7MapNode7dequeueEv+0x38>
8010544c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105450 <_ZN3Map7isEmptyEv>:
bool Map::isEmpty() {
80105450:	55                   	push   %ebp
80105451:	89 e5                	mov    %esp,%ebp
	return !root;
80105453:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105456:	5d                   	pop    %ebp
	return !root;
80105457:	8b 00                	mov    (%eax),%eax
80105459:	85 c0                	test   %eax,%eax
8010545b:	0f 94 c0             	sete   %al
}
8010545e:	c3                   	ret    
8010545f:	90                   	nop

80105460 <_ZN3Map3putEP4proc>:
bool Map::put(Proc *p) {
80105460:	55                   	push   %ebp
80105461:	89 e5                	mov    %esp,%ebp
80105463:	83 ec 18             	sub    $0x18,%esp
80105466:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105469:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010546c:	89 75 fc             	mov    %esi,-0x4(%ebp)
8010546f:	8b 75 08             	mov    0x8(%ebp),%esi
	long long key = getAccumulator(p);
80105472:	89 1c 24             	mov    %ebx,(%esp)
80105475:	e8 26 e4 ff ff       	call   801038a0 <getAccumulator>
	return !root;
8010547a:	8b 0e                	mov    (%esi),%ecx
	if(isEmpty()) {
8010547c:	85 c9                	test   %ecx,%ecx
8010547e:	74 18                	je     80105498 <_ZN3Map3putEP4proc+0x38>
	return root->put(p);
80105480:	89 5d 0c             	mov    %ebx,0xc(%ebp)
}
80105483:	8b 75 fc             	mov    -0x4(%ebp),%esi
	return root->put(p);
80105486:	89 4d 08             	mov    %ecx,0x8(%ebp)
}
80105489:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010548c:	89 ec                	mov    %ebp,%esp
8010548e:	5d                   	pop    %ebp
	return root->put(p);
8010548f:	e9 1c fe ff ff       	jmp    801052b0 <_ZN7MapNode3putEP4proc>
80105494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		root = allocNode(p, key);
80105498:	89 d1                	mov    %edx,%ecx
8010549a:	89 c2                	mov    %eax,%edx
8010549c:	89 d8                	mov    %ebx,%eax
8010549e:	e8 5d f8 ff ff       	call   80104d00 <_ZL9allocNodeP4procx>
801054a3:	89 06                	mov    %eax,(%esi)
		return !isEmpty();
801054a5:	85 c0                	test   %eax,%eax
801054a7:	0f 95 c0             	setne  %al
}
801054aa:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801054ad:	8b 75 fc             	mov    -0x4(%ebp),%esi
801054b0:	89 ec                	mov    %ebp,%esp
801054b2:	5d                   	pop    %ebp
801054b3:	c3                   	ret    
801054b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801054ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801054c0 <putPriorityQueue>:
static boolean putPriorityQueue(Proc* p) {
801054c0:	55                   	push   %ebp
801054c1:	89 e5                	mov    %esp,%ebp
801054c3:	83 ec 18             	sub    $0x18,%esp
	return priorityQ->put(p);
801054c6:	8b 45 08             	mov    0x8(%ebp),%eax
801054c9:	89 44 24 04          	mov    %eax,0x4(%esp)
801054cd:	a1 14 c6 10 80       	mov    0x8010c614,%eax
801054d2:	89 04 24             	mov    %eax,(%esp)
801054d5:	e8 86 ff ff ff       	call   80105460 <_ZN3Map3putEP4proc>
}
801054da:	c9                   	leave  
	return priorityQ->put(p);
801054db:	0f b6 c0             	movzbl %al,%eax
}
801054de:	c3                   	ret    
801054df:	90                   	nop

801054e0 <_ZN3Map9getMinKeyEPx>:
bool Map::getMinKey(long long *pkey) {
801054e0:	55                   	push   %ebp
801054e1:	89 e5                	mov    %esp,%ebp
	return !root;
801054e3:	8b 45 08             	mov    0x8(%ebp),%eax
bool Map::getMinKey(long long *pkey) {
801054e6:	53                   	push   %ebx
	return !root;
801054e7:	8b 10                	mov    (%eax),%edx
	if(isEmpty())
801054e9:	85 d2                	test   %edx,%edx
801054eb:	75 05                	jne    801054f2 <_ZN3Map9getMinKeyEPx+0x12>
801054ed:	eb 21                	jmp    80105510 <_ZN3Map9getMinKeyEPx+0x30>
801054ef:	90                   	nop
	while(minNode->left)
801054f0:	89 c2                	mov    %eax,%edx
801054f2:	8b 42 18             	mov    0x18(%edx),%eax
801054f5:	85 c0                	test   %eax,%eax
801054f7:	75 f7                	jne    801054f0 <_ZN3Map9getMinKeyEPx+0x10>
	*pkey = getMinNode()->key;
801054f9:	8b 45 0c             	mov    0xc(%ebp),%eax
801054fc:	8b 5a 04             	mov    0x4(%edx),%ebx
801054ff:	8b 0a                	mov    (%edx),%ecx
80105501:	89 58 04             	mov    %ebx,0x4(%eax)
80105504:	89 08                	mov    %ecx,(%eax)
		return false;

	root->getMinKey(pkey);
	return true;
80105506:	b0 01                	mov    $0x1,%al
}
80105508:	5b                   	pop    %ebx
80105509:	5d                   	pop    %ebp
8010550a:	c3                   	ret    
8010550b:	90                   	nop
8010550c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105510:	5b                   	pop    %ebx
		return false;
80105511:	31 c0                	xor    %eax,%eax
}
80105513:	5d                   	pop    %ebp
80105514:	c3                   	ret    
80105515:	90                   	nop
80105516:	8d 76 00             	lea    0x0(%esi),%esi
80105519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105520 <_ZN3Map10extractMinEv>:

Proc* Map::extractMin() {
80105520:	55                   	push   %ebp
80105521:	89 e5                	mov    %esp,%ebp
80105523:	57                   	push   %edi
80105524:	56                   	push   %esi
80105525:	8b 75 08             	mov    0x8(%ebp),%esi
80105528:	53                   	push   %ebx
	return !root;
80105529:	8b 1e                	mov    (%esi),%ebx
	if(isEmpty())
8010552b:	85 db                	test   %ebx,%ebx
8010552d:	0f 84 a5 00 00 00    	je     801055d8 <_ZN3Map10extractMinEv+0xb8>
80105533:	89 da                	mov    %ebx,%edx
80105535:	eb 0b                	jmp    80105542 <_ZN3Map10extractMinEv+0x22>
80105537:	89 f6                	mov    %esi,%esi
80105539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	while(minNode->left)
80105540:	89 c2                	mov    %eax,%edx
80105542:	8b 42 18             	mov    0x18(%edx),%eax
80105545:	85 c0                	test   %eax,%eax
80105547:	75 f7                	jne    80105540 <_ZN3Map10extractMinEv+0x20>
	return !first;
80105549:	8b 4a 08             	mov    0x8(%edx),%ecx
	if(isEmpty())
8010554c:	85 c9                	test   %ecx,%ecx
8010554e:	74 70                	je     801055c0 <_ZN3Map10extractMinEv+0xa0>
	Link *next = first->next;
80105550:	8b 59 04             	mov    0x4(%ecx),%ebx
	link->next = freeLinks;
80105553:	8b 3d 08 c6 10 80    	mov    0x8010c608,%edi
	Proc *p = first->p;
80105559:	8b 01                	mov    (%ecx),%eax
	freeLinks = link;
8010555b:	89 0d 08 c6 10 80    	mov    %ecx,0x8010c608
	if(isEmpty())
80105561:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
80105563:	89 79 04             	mov    %edi,0x4(%ecx)
	first = next;
80105566:	89 5a 08             	mov    %ebx,0x8(%edx)
	if(isEmpty())
80105569:	74 05                	je     80105570 <_ZN3Map10extractMinEv+0x50>
		}
		deallocNode(minNode);
	}

	return p;
}
8010556b:	5b                   	pop    %ebx
8010556c:	5e                   	pop    %esi
8010556d:	5f                   	pop    %edi
8010556e:	5d                   	pop    %ebp
8010556f:	c3                   	ret    
		last = null;
80105570:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
80105577:	8b 4a 1c             	mov    0x1c(%edx),%ecx
8010557a:	8b 1e                	mov    (%esi),%ebx
		if(minNode == root) {
8010557c:	39 da                	cmp    %ebx,%edx
8010557e:	74 49                	je     801055c9 <_ZN3Map10extractMinEv+0xa9>
			MapNode *parent = minNode->parent;
80105580:	8b 5a 14             	mov    0x14(%edx),%ebx
			parent->left = minNode->right;
80105583:	89 4b 18             	mov    %ecx,0x18(%ebx)
			if(minNode->right)
80105586:	8b 4a 1c             	mov    0x1c(%edx),%ecx
80105589:	85 c9                	test   %ecx,%ecx
8010558b:	74 03                	je     80105590 <_ZN3Map10extractMinEv+0x70>
				minNode->right->parent = parent;
8010558d:	89 59 14             	mov    %ebx,0x14(%ecx)
	node->next = freeNodes;
80105590:	8b 0d 04 c6 10 80    	mov    0x8010c604,%ecx
	node->parent = node->left = node->right = null;
80105596:	c7 42 1c 00 00 00 00 	movl   $0x0,0x1c(%edx)
8010559d:	c7 42 18 00 00 00 00 	movl   $0x0,0x18(%edx)
801055a4:	c7 42 14 00 00 00 00 	movl   $0x0,0x14(%edx)
	node->next = freeNodes;
801055ab:	89 4a 10             	mov    %ecx,0x10(%edx)
}
801055ae:	5b                   	pop    %ebx
	freeNodes = node;
801055af:	89 15 04 c6 10 80    	mov    %edx,0x8010c604
}
801055b5:	5e                   	pop    %esi
801055b6:	5f                   	pop    %edi
801055b7:	5d                   	pop    %ebp
801055b8:	c3                   	ret    
801055b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return null;
801055c0:	31 c0                	xor    %eax,%eax
		if(minNode == root) {
801055c2:	39 da                	cmp    %ebx,%edx
801055c4:	8b 4a 1c             	mov    0x1c(%edx),%ecx
801055c7:	75 b7                	jne    80105580 <_ZN3Map10extractMinEv+0x60>
			if(!isEmpty())
801055c9:	85 c9                	test   %ecx,%ecx
			root = minNode->right;
801055cb:	89 0e                	mov    %ecx,(%esi)
			if(!isEmpty())
801055cd:	74 c1                	je     80105590 <_ZN3Map10extractMinEv+0x70>
				root->parent = null;
801055cf:	c7 41 14 00 00 00 00 	movl   $0x0,0x14(%ecx)
801055d6:	eb b8                	jmp    80105590 <_ZN3Map10extractMinEv+0x70>
		return null;
801055d8:	31 c0                	xor    %eax,%eax
801055da:	eb 8f                	jmp    8010556b <_ZN3Map10extractMinEv+0x4b>
801055dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801055e0 <extractMinPriorityQueue>:
static Proc* extractMinPriorityQueue() {
801055e0:	55                   	push   %ebp
801055e1:	89 e5                	mov    %esp,%ebp
801055e3:	83 ec 04             	sub    $0x4,%esp
	return priorityQ->extractMin();
801055e6:	a1 14 c6 10 80       	mov    0x8010c614,%eax
801055eb:	89 04 24             	mov    %eax,(%esp)
801055ee:	e8 2d ff ff ff       	call   80105520 <_ZN3Map10extractMinEv>
}
801055f3:	c9                   	leave  
801055f4:	c3                   	ret    
801055f5:	90                   	nop
801055f6:	8d 76 00             	lea    0x0(%esi),%esi
801055f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105600 <_ZN3Map8transferEv.part.1>:

bool Map::transfer() {
80105600:	55                   	push   %ebp
80105601:	89 e5                	mov    %esp,%ebp
80105603:	56                   	push   %esi
80105604:	53                   	push   %ebx
80105605:	89 c3                	mov    %eax,%ebx
80105607:	83 ec 04             	sub    $0x4,%esp
8010560a:	eb 16                	jmp    80105622 <_ZN3Map8transferEv.part.1+0x22>
8010560c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!roundRobinQ->isEmpty())
		return false;

	while(!isEmpty()) {
		Proc* p = extractMin();
80105610:	89 1c 24             	mov    %ebx,(%esp)
80105613:	e8 08 ff ff ff       	call   80105520 <_ZN3Map10extractMinEv>
	if(!freeLinks)
80105618:	8b 15 08 c6 10 80    	mov    0x8010c608,%edx
8010561e:	85 d2                	test   %edx,%edx
80105620:	75 0e                	jne    80105630 <_ZN3Map8transferEv.part.1+0x30>
	while(!isEmpty()) {
80105622:	8b 03                	mov    (%ebx),%eax
80105624:	85 c0                	test   %eax,%eax
80105626:	75 e8                	jne    80105610 <_ZN3Map8transferEv.part.1+0x10>
		roundRobinQ->enqueue(p); //should succeed.
	}

	return true;
}
80105628:	5a                   	pop    %edx
80105629:	b0 01                	mov    $0x1,%al
8010562b:	5b                   	pop    %ebx
8010562c:	5e                   	pop    %esi
8010562d:	5d                   	pop    %ebp
8010562e:	c3                   	ret    
8010562f:	90                   	nop
	freeLinks = freeLinks->next;
80105630:	8b 72 04             	mov    0x4(%edx),%esi
		roundRobinQ->enqueue(p); //should succeed.
80105633:	8b 0d 10 c6 10 80    	mov    0x8010c610,%ecx
	ans->next = null;
80105639:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
	ans->p = p;
80105640:	89 02                	mov    %eax,(%edx)
	freeLinks = freeLinks->next;
80105642:	89 35 08 c6 10 80    	mov    %esi,0x8010c608
	if(isEmpty()) first = link;
80105648:	8b 31                	mov    (%ecx),%esi
8010564a:	85 f6                	test   %esi,%esi
8010564c:	74 22                	je     80105670 <_ZN3Map8transferEv.part.1+0x70>
	else last->next = link;
8010564e:	8b 41 04             	mov    0x4(%ecx),%eax
80105651:	89 50 04             	mov    %edx,0x4(%eax)
80105654:	eb 0c                	jmp    80105662 <_ZN3Map8transferEv.part.1+0x62>
80105656:	8d 76 00             	lea    0x0(%esi),%esi
80105659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	while(ans->next)
80105660:	89 c2                	mov    %eax,%edx
80105662:	8b 42 04             	mov    0x4(%edx),%eax
80105665:	85 c0                	test   %eax,%eax
80105667:	75 f7                	jne    80105660 <_ZN3Map8transferEv.part.1+0x60>
	last = link->getLast();
80105669:	89 51 04             	mov    %edx,0x4(%ecx)
8010566c:	eb b4                	jmp    80105622 <_ZN3Map8transferEv.part.1+0x22>
8010566e:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
80105670:	89 11                	mov    %edx,(%ecx)
80105672:	eb ee                	jmp    80105662 <_ZN3Map8transferEv.part.1+0x62>
80105674:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010567a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105680 <switchToRoundRobinPolicyPriorityQueue>:
	if(!roundRobinQ->isEmpty())
80105680:	8b 15 10 c6 10 80    	mov    0x8010c610,%edx
80105686:	8b 02                	mov    (%edx),%eax
80105688:	85 c0                	test   %eax,%eax
8010568a:	74 04                	je     80105690 <switchToRoundRobinPolicyPriorityQueue+0x10>
8010568c:	31 c0                	xor    %eax,%eax
}
8010568e:	c3                   	ret    
8010568f:	90                   	nop
80105690:	a1 14 c6 10 80       	mov    0x8010c614,%eax
static boolean switchToRoundRobinPolicyPriorityQueue() {
80105695:	55                   	push   %ebp
80105696:	89 e5                	mov    %esp,%ebp
80105698:	e8 63 ff ff ff       	call   80105600 <_ZN3Map8transferEv.part.1>
}
8010569d:	5d                   	pop    %ebp
8010569e:	0f b6 c0             	movzbl %al,%eax
801056a1:	c3                   	ret    
801056a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801056b0 <_ZN3Map8transferEv>:
	return !first;
801056b0:	8b 15 10 c6 10 80    	mov    0x8010c610,%edx
bool Map::transfer() {
801056b6:	55                   	push   %ebp
801056b7:	89 e5                	mov    %esp,%ebp
801056b9:	8b 45 08             	mov    0x8(%ebp),%eax
	if(!roundRobinQ->isEmpty())
801056bc:	8b 12                	mov    (%edx),%edx
801056be:	85 d2                	test   %edx,%edx
801056c0:	74 0e                	je     801056d0 <_ZN3Map8transferEv+0x20>
}
801056c2:	31 c0                	xor    %eax,%eax
801056c4:	5d                   	pop    %ebp
801056c5:	c3                   	ret    
801056c6:	8d 76 00             	lea    0x0(%esi),%esi
801056c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801056d0:	5d                   	pop    %ebp
801056d1:	e9 2a ff ff ff       	jmp    80105600 <_ZN3Map8transferEv.part.1>
801056d6:	8d 76 00             	lea    0x0(%esi),%esi
801056d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801056e0 <_ZN3Map11extractProcEP4proc>:

bool Map::extractProc(Proc *p) {
801056e0:	55                   	push   %ebp
801056e1:	89 e5                	mov    %esp,%ebp
801056e3:	56                   	push   %esi
801056e4:	53                   	push   %ebx
801056e5:	83 ec 30             	sub    $0x30,%esp
	if(!freeNodes)
801056e8:	8b 15 04 c6 10 80    	mov    0x8010c604,%edx
bool Map::extractProc(Proc *p) {
801056ee:	8b 5d 08             	mov    0x8(%ebp),%ebx
801056f1:	8b 75 0c             	mov    0xc(%ebp),%esi
	if(!freeNodes)
801056f4:	85 d2                	test   %edx,%edx
801056f6:	74 50                	je     80105748 <_ZN3Map11extractProcEP4proc+0x68>
	MapNode *next, *parent, *left, *right;
};

class Map {
public:
	Map(): root(null) {}
801056f8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		return false;

	bool ans = false;
801056ff:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
80105703:	eb 13                	jmp    80105718 <_ZN3Map11extractProcEP4proc+0x38>
80105705:	8d 76 00             	lea    0x0(%esi),%esi
	Map tempMap;
	while(!isEmpty()) {
		Proc *otherP = extractMin();
80105708:	89 1c 24             	mov    %ebx,(%esp)
8010570b:	e8 10 fe ff ff       	call   80105520 <_ZN3Map10extractMinEv>
		if(otherP != p)
80105710:	39 f0                	cmp    %esi,%eax
80105712:	75 1c                	jne    80105730 <_ZN3Map11extractProcEP4proc+0x50>
			tempMap.put(otherP); //should scucceed.
		else ans = true;
80105714:	c6 45 e7 01          	movb   $0x1,-0x19(%ebp)
	while(!isEmpty()) {
80105718:	8b 03                	mov    (%ebx),%eax
8010571a:	85 c0                	test   %eax,%eax
8010571c:	75 ea                	jne    80105708 <_ZN3Map11extractProcEP4proc+0x28>
	}
	root = tempMap.root;
8010571e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105721:	89 03                	mov    %eax,(%ebx)
	return ans;
}
80105723:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80105727:	83 c4 30             	add    $0x30,%esp
8010572a:	5b                   	pop    %ebx
8010572b:	5e                   	pop    %esi
8010572c:	5d                   	pop    %ebp
8010572d:	c3                   	ret    
8010572e:	66 90                	xchg   %ax,%ax
			tempMap.put(otherP); //should scucceed.
80105730:	89 44 24 04          	mov    %eax,0x4(%esp)
80105734:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105737:	89 04 24             	mov    %eax,(%esp)
8010573a:	e8 21 fd ff ff       	call   80105460 <_ZN3Map3putEP4proc>
8010573f:	eb d7                	jmp    80105718 <_ZN3Map11extractProcEP4proc+0x38>
80105741:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return false;
80105748:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
}
8010574c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80105750:	83 c4 30             	add    $0x30,%esp
80105753:	5b                   	pop    %ebx
80105754:	5e                   	pop    %esi
80105755:	5d                   	pop    %ebp
80105756:	c3                   	ret    
80105757:	89 f6                	mov    %esi,%esi
80105759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105760 <extractProcPriorityQueue>:
static boolean extractProcPriorityQueue(Proc *p) {
80105760:	55                   	push   %ebp
80105761:	89 e5                	mov    %esp,%ebp
80105763:	83 ec 18             	sub    $0x18,%esp
	return priorityQ->extractProc(p);
80105766:	8b 45 08             	mov    0x8(%ebp),%eax
80105769:	89 44 24 04          	mov    %eax,0x4(%esp)
8010576d:	a1 14 c6 10 80       	mov    0x8010c614,%eax
80105772:	89 04 24             	mov    %eax,(%esp)
80105775:	e8 66 ff ff ff       	call   801056e0 <_ZN3Map11extractProcEP4proc>
}
8010577a:	c9                   	leave  
	return priorityQ->extractProc(p);
8010577b:	0f b6 c0             	movzbl %al,%eax
}
8010577e:	c3                   	ret    
8010577f:	90                   	nop

80105780 <__moddi3>:

long long __moddi3(long long number, long long divisor) { //returns number%divisor
80105780:	55                   	push   %ebp
80105781:	89 e5                	mov    %esp,%ebp
80105783:	57                   	push   %edi
80105784:	56                   	push   %esi
80105785:	53                   	push   %ebx
80105786:	83 ec 2c             	sub    $0x2c,%esp
80105789:	8b 45 08             	mov    0x8(%ebp),%eax
8010578c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010578f:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105792:	8b 45 10             	mov    0x10(%ebp),%eax
80105795:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80105798:	8b 55 14             	mov    0x14(%ebp),%edx
8010579b:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010579e:	89 d7                	mov    %edx,%edi
	if(divisor == 0)
801057a0:	09 c2                	or     %eax,%edx
801057a2:	0f 84 9a 00 00 00    	je     80105842 <__moddi3+0xc2>
		panic((char*)"divide by zero!!!\n");

	bool isNumberNegative = false;
	if(number < 0) {
801057a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
	bool isNumberNegative = false;
801057ab:	c6 45 df 00          	movb   $0x0,-0x21(%ebp)
	if(number < 0) {
801057af:	85 c0                	test   %eax,%eax
801057b1:	79 0e                	jns    801057c1 <__moddi3+0x41>
		number = -number;
801057b3:	f7 5d e0             	negl   -0x20(%ebp)
		isNumberNegative = true;
801057b6:	c6 45 df 01          	movb   $0x1,-0x21(%ebp)
		number = -number;
801057ba:	83 55 e4 00          	adcl   $0x0,-0x1c(%ebp)
801057be:	f7 5d e4             	negl   -0x1c(%ebp)
801057c1:	8b 55 d8             	mov    -0x28(%ebp),%edx
801057c4:	89 f8                	mov    %edi,%eax
801057c6:	c1 ff 1f             	sar    $0x1f,%edi
801057c9:	31 f8                	xor    %edi,%eax
801057cb:	89 f9                	mov    %edi,%ecx
801057cd:	31 fa                	xor    %edi,%edx
801057cf:	89 c7                	mov    %eax,%edi
801057d1:	8b 45 e0             	mov    -0x20(%ebp),%eax
801057d4:	89 d6                	mov    %edx,%esi
801057d6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801057d9:	29 ce                	sub    %ecx,%esi
801057db:	19 cf                	sbb    %ecx,%edi
	if(divisor < 0)
		divisor = -divisor;

	for(;;) {
		long long divisor2 = divisor;
		while(number >= divisor2) {
801057dd:	39 fa                	cmp    %edi,%edx
801057df:	7d 1f                	jge    80105800 <__moddi3+0x80>
			if(divisor2 + divisor2 > 0) //exponential decay.
				divisor2 += divisor2;
		}

		if(number < divisor)
			return isNumberNegative ? -number : number;
801057e1:	80 7d df 00          	cmpb   $0x0,-0x21(%ebp)
801057e5:	74 07                	je     801057ee <__moddi3+0x6e>
801057e7:	f7 d8                	neg    %eax
801057e9:	83 d2 00             	adc    $0x0,%edx
801057ec:	f7 da                	neg    %edx
	}
}
801057ee:	83 c4 2c             	add    $0x2c,%esp
801057f1:	5b                   	pop    %ebx
801057f2:	5e                   	pop    %esi
801057f3:	5f                   	pop    %edi
801057f4:	5d                   	pop    %ebp
801057f5:	c3                   	ret    
801057f6:	8d 76 00             	lea    0x0(%esi),%esi
801057f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		while(number >= divisor2) {
80105800:	7f 04                	jg     80105806 <__moddi3+0x86>
80105802:	39 f0                	cmp    %esi,%eax
80105804:	72 db                	jb     801057e1 <__moddi3+0x61>
80105806:	89 f1                	mov    %esi,%ecx
80105808:	89 fb                	mov    %edi,%ebx
8010580a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			number -= divisor2;
80105810:	29 c8                	sub    %ecx,%eax
80105812:	19 da                	sbb    %ebx,%edx
				divisor2 += divisor2;
80105814:	0f a4 cb 01          	shld   $0x1,%ecx,%ebx
80105818:	01 c9                	add    %ecx,%ecx
		while(number >= divisor2) {
8010581a:	39 da                	cmp    %ebx,%edx
8010581c:	7f f2                	jg     80105810 <__moddi3+0x90>
8010581e:	7d 18                	jge    80105838 <__moddi3+0xb8>
		if(number < divisor)
80105820:	39 d7                	cmp    %edx,%edi
80105822:	7c b9                	jl     801057dd <__moddi3+0x5d>
80105824:	7f bb                	jg     801057e1 <__moddi3+0x61>
80105826:	39 c6                	cmp    %eax,%esi
80105828:	76 b3                	jbe    801057dd <__moddi3+0x5d>
8010582a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105830:	eb af                	jmp    801057e1 <__moddi3+0x61>
80105832:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		while(number >= divisor2) {
80105838:	39 c8                	cmp    %ecx,%eax
8010583a:	73 d4                	jae    80105810 <__moddi3+0x90>
8010583c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105840:	eb de                	jmp    80105820 <__moddi3+0xa0>
		panic((char*)"divide by zero!!!\n");
80105842:	c7 04 24 90 8f 10 80 	movl   $0x80108f90,(%esp)
80105849:	e8 22 ab ff ff       	call   80100370 <panic>
8010584e:	66 90                	xchg   %ax,%ax

80105850 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80105850:	55                   	push   %ebp
  initlock(&lk->lk, "sleep lock");
80105851:	b8 a3 8f 10 80       	mov    $0x80108fa3,%eax
{
80105856:	89 e5                	mov    %esp,%ebp
80105858:	53                   	push   %ebx
80105859:	83 ec 14             	sub    $0x14,%esp
8010585c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010585f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105863:	8d 43 04             	lea    0x4(%ebx),%eax
80105866:	89 04 24             	mov    %eax,(%esp)
80105869:	e8 12 01 00 00       	call   80105980 <initlock>
  lk->name = name;
8010586e:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80105871:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80105877:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010587e:	89 43 38             	mov    %eax,0x38(%ebx)
}
80105881:	83 c4 14             	add    $0x14,%esp
80105884:	5b                   	pop    %ebx
80105885:	5d                   	pop    %ebp
80105886:	c3                   	ret    
80105887:	89 f6                	mov    %esi,%esi
80105889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105890 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80105890:	55                   	push   %ebp
80105891:	89 e5                	mov    %esp,%ebp
80105893:	56                   	push   %esi
80105894:	53                   	push   %ebx
80105895:	83 ec 10             	sub    $0x10,%esp
80105898:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010589b:	8d 73 04             	lea    0x4(%ebx),%esi
8010589e:	89 34 24             	mov    %esi,(%esp)
801058a1:	e8 2a 02 00 00       	call   80105ad0 <acquire>
  while (lk->locked) {
801058a6:	8b 13                	mov    (%ebx),%edx
801058a8:	85 d2                	test   %edx,%edx
801058aa:	74 16                	je     801058c2 <acquiresleep+0x32>
801058ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
801058b0:	89 74 24 04          	mov    %esi,0x4(%esp)
801058b4:	89 1c 24             	mov    %ebx,(%esp)
801058b7:	e8 d4 ea ff ff       	call   80104390 <sleep>
  while (lk->locked) {
801058bc:	8b 03                	mov    (%ebx),%eax
801058be:	85 c0                	test   %eax,%eax
801058c0:	75 ee                	jne    801058b0 <acquiresleep+0x20>
  }
  lk->locked = 1;
801058c2:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801058c8:	e8 53 e1 ff ff       	call   80103a20 <myproc>
801058cd:	8b 40 10             	mov    0x10(%eax),%eax
801058d0:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801058d3:	89 75 08             	mov    %esi,0x8(%ebp)
}
801058d6:	83 c4 10             	add    $0x10,%esp
801058d9:	5b                   	pop    %ebx
801058da:	5e                   	pop    %esi
801058db:	5d                   	pop    %ebp
  release(&lk->lk);
801058dc:	e9 8f 02 00 00       	jmp    80105b70 <release>
801058e1:	eb 0d                	jmp    801058f0 <releasesleep>
801058e3:	90                   	nop
801058e4:	90                   	nop
801058e5:	90                   	nop
801058e6:	90                   	nop
801058e7:	90                   	nop
801058e8:	90                   	nop
801058e9:	90                   	nop
801058ea:	90                   	nop
801058eb:	90                   	nop
801058ec:	90                   	nop
801058ed:	90                   	nop
801058ee:	90                   	nop
801058ef:	90                   	nop

801058f0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801058f0:	55                   	push   %ebp
801058f1:	89 e5                	mov    %esp,%ebp
801058f3:	83 ec 18             	sub    $0x18,%esp
801058f6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801058f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801058fc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  acquire(&lk->lk);
801058ff:	8d 73 04             	lea    0x4(%ebx),%esi
80105902:	89 34 24             	mov    %esi,(%esp)
80105905:	e8 c6 01 00 00       	call   80105ad0 <acquire>
  lk->locked = 0;
8010590a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80105910:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80105917:	89 1c 24             	mov    %ebx,(%esp)
8010591a:	e8 71 ec ff ff       	call   80104590 <wakeup>
  release(&lk->lk);
}
8010591f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  release(&lk->lk);
80105922:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105925:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105928:	89 ec                	mov    %ebp,%esp
8010592a:	5d                   	pop    %ebp
  release(&lk->lk);
8010592b:	e9 40 02 00 00       	jmp    80105b70 <release>

80105930 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80105930:	55                   	push   %ebp
80105931:	89 e5                	mov    %esp,%ebp
80105933:	83 ec 28             	sub    $0x28,%esp
80105936:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80105939:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010593c:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010593f:	89 75 f8             	mov    %esi,-0x8(%ebp)
80105942:	31 f6                	xor    %esi,%esi
  int r;
  
  acquire(&lk->lk);
80105944:	8d 7b 04             	lea    0x4(%ebx),%edi
80105947:	89 3c 24             	mov    %edi,(%esp)
8010594a:	e8 81 01 00 00       	call   80105ad0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
8010594f:	8b 03                	mov    (%ebx),%eax
80105951:	85 c0                	test   %eax,%eax
80105953:	74 11                	je     80105966 <holdingsleep+0x36>
80105955:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80105958:	e8 c3 e0 ff ff       	call   80103a20 <myproc>
8010595d:	39 58 10             	cmp    %ebx,0x10(%eax)
80105960:	0f 94 c0             	sete   %al
80105963:	0f b6 f0             	movzbl %al,%esi
  release(&lk->lk);
80105966:	89 3c 24             	mov    %edi,(%esp)
80105969:	e8 02 02 00 00       	call   80105b70 <release>
  return r;
}
8010596e:	89 f0                	mov    %esi,%eax
80105970:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105973:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105976:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105979:	89 ec                	mov    %ebp,%esp
8010597b:	5d                   	pop    %ebp
8010597c:	c3                   	ret    
8010597d:	66 90                	xchg   %ax,%ax
8010597f:	90                   	nop

80105980 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105980:	55                   	push   %ebp
80105981:	89 e5                	mov    %esp,%ebp
80105983:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80105986:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80105989:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010598f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80105992:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105999:	5d                   	pop    %ebp
8010599a:	c3                   	ret    
8010599b:	90                   	nop
8010599c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801059a0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801059a0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801059a1:	31 d2                	xor    %edx,%edx
{
801059a3:	89 e5                	mov    %esp,%ebp
  ebp = (uint*)v - 2;
801059a5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801059a8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801059ab:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801059ac:	83 e8 08             	sub    $0x8,%eax
801059af:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801059b0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801059b6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801059bc:	77 12                	ja     801059d0 <getcallerpcs+0x30>
      break;
    pcs[i] = ebp[1];     // saved %eip
801059be:	8b 58 04             	mov    0x4(%eax),%ebx
801059c1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801059c4:	42                   	inc    %edx
801059c5:	83 fa 0a             	cmp    $0xa,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801059c8:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801059ca:	75 e4                	jne    801059b0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801059cc:	5b                   	pop    %ebx
801059cd:	5d                   	pop    %ebp
801059ce:	c3                   	ret    
801059cf:	90                   	nop
801059d0:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801059d3:	83 c1 28             	add    $0x28,%ecx
801059d6:	8d 76 00             	lea    0x0(%esi),%esi
801059d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
801059e0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801059e6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801059e9:	39 c1                	cmp    %eax,%ecx
801059eb:	75 f3                	jne    801059e0 <getcallerpcs+0x40>
}
801059ed:	5b                   	pop    %ebx
801059ee:	5d                   	pop    %ebp
801059ef:	c3                   	ret    

801059f0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801059f0:	55                   	push   %ebp
801059f1:	89 e5                	mov    %esp,%ebp
801059f3:	53                   	push   %ebx
801059f4:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801059f7:	9c                   	pushf  
801059f8:	5b                   	pop    %ebx
  asm volatile("cli");
801059f9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801059fa:	e8 81 df ff ff       	call   80103980 <mycpu>
801059ff:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105a05:	85 d2                	test   %edx,%edx
80105a07:	75 11                	jne    80105a1a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80105a09:	e8 72 df ff ff       	call   80103980 <mycpu>
80105a0e:	81 e3 00 02 00 00    	and    $0x200,%ebx
80105a14:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
80105a1a:	e8 61 df ff ff       	call   80103980 <mycpu>
80105a1f:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
}
80105a25:	58                   	pop    %eax
80105a26:	5b                   	pop    %ebx
80105a27:	5d                   	pop    %ebp
80105a28:	c3                   	ret    
80105a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105a30 <popcli>:

void
popcli(void)
{
80105a30:	55                   	push   %ebp
80105a31:	89 e5                	mov    %esp,%ebp
80105a33:	83 ec 18             	sub    $0x18,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105a36:	9c                   	pushf  
80105a37:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80105a38:	f6 c4 02             	test   $0x2,%ah
80105a3b:	75 35                	jne    80105a72 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80105a3d:	e8 3e df ff ff       	call   80103980 <mycpu>
80105a42:	ff 88 a4 00 00 00    	decl   0xa4(%eax)
80105a48:	78 34                	js     80105a7e <popcli+0x4e>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105a4a:	e8 31 df ff ff       	call   80103980 <mycpu>
80105a4f:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105a55:	85 d2                	test   %edx,%edx
80105a57:	74 07                	je     80105a60 <popcli+0x30>
    sti();
}
80105a59:	c9                   	leave  
80105a5a:	c3                   	ret    
80105a5b:	90                   	nop
80105a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105a60:	e8 1b df ff ff       	call   80103980 <mycpu>
80105a65:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80105a6b:	85 c0                	test   %eax,%eax
80105a6d:	74 ea                	je     80105a59 <popcli+0x29>
  asm volatile("sti");
80105a6f:	fb                   	sti    
}
80105a70:	c9                   	leave  
80105a71:	c3                   	ret    
    panic("popcli - interruptible");
80105a72:	c7 04 24 ae 8f 10 80 	movl   $0x80108fae,(%esp)
80105a79:	e8 f2 a8 ff ff       	call   80100370 <panic>
    panic("popcli");
80105a7e:	c7 04 24 c5 8f 10 80 	movl   $0x80108fc5,(%esp)
80105a85:	e8 e6 a8 ff ff       	call   80100370 <panic>
80105a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105a90 <holding>:
{
80105a90:	55                   	push   %ebp
80105a91:	89 e5                	mov    %esp,%ebp
80105a93:	83 ec 08             	sub    $0x8,%esp
80105a96:	89 75 fc             	mov    %esi,-0x4(%ebp)
80105a99:	8b 75 08             	mov    0x8(%ebp),%esi
80105a9c:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105a9f:	31 db                	xor    %ebx,%ebx
  pushcli();
80105aa1:	e8 4a ff ff ff       	call   801059f0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105aa6:	8b 06                	mov    (%esi),%eax
80105aa8:	85 c0                	test   %eax,%eax
80105aaa:	74 10                	je     80105abc <holding+0x2c>
80105aac:	8b 5e 08             	mov    0x8(%esi),%ebx
80105aaf:	e8 cc de ff ff       	call   80103980 <mycpu>
80105ab4:	39 c3                	cmp    %eax,%ebx
80105ab6:	0f 94 c3             	sete   %bl
80105ab9:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80105abc:	e8 6f ff ff ff       	call   80105a30 <popcli>
}
80105ac1:	89 d8                	mov    %ebx,%eax
80105ac3:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105ac6:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105ac9:	89 ec                	mov    %ebp,%esp
80105acb:	5d                   	pop    %ebp
80105acc:	c3                   	ret    
80105acd:	8d 76 00             	lea    0x0(%esi),%esi

80105ad0 <acquire>:
{
80105ad0:	55                   	push   %ebp
80105ad1:	89 e5                	mov    %esp,%ebp
80105ad3:	56                   	push   %esi
80105ad4:	53                   	push   %ebx
80105ad5:	83 ec 10             	sub    $0x10,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105ad8:	e8 13 ff ff ff       	call   801059f0 <pushcli>
  if(holding(lk))
80105add:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105ae0:	89 1c 24             	mov    %ebx,(%esp)
80105ae3:	e8 a8 ff ff ff       	call   80105a90 <holding>
80105ae8:	85 c0                	test   %eax,%eax
80105aea:	75 78                	jne    80105b64 <acquire+0x94>
80105aec:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80105aee:	ba 01 00 00 00       	mov    $0x1,%edx
80105af3:	eb 06                	jmp    80105afb <acquire+0x2b>
80105af5:	8d 76 00             	lea    0x0(%esi),%esi
80105af8:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105afb:	89 d0                	mov    %edx,%eax
80105afd:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80105b00:	85 c0                	test   %eax,%eax
80105b02:	75 f4                	jne    80105af8 <acquire+0x28>
  __sync_synchronize();
80105b04:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80105b09:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105b0c:	e8 6f de ff ff       	call   80103980 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80105b11:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
80105b14:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80105b17:	89 e8                	mov    %ebp,%eax
80105b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105b20:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
80105b26:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80105b2c:	77 1a                	ja     80105b48 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
80105b2e:	8b 48 04             	mov    0x4(%eax),%ecx
80105b31:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
80105b34:	46                   	inc    %esi
80105b35:	83 fe 0a             	cmp    $0xa,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80105b38:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105b3a:	75 e4                	jne    80105b20 <acquire+0x50>
}
80105b3c:	83 c4 10             	add    $0x10,%esp
80105b3f:	5b                   	pop    %ebx
80105b40:	5e                   	pop    %esi
80105b41:	5d                   	pop    %ebp
80105b42:	c3                   	ret    
80105b43:	90                   	nop
80105b44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b48:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80105b4b:	83 c2 28             	add    $0x28,%edx
80105b4e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80105b50:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105b56:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80105b59:	39 d0                	cmp    %edx,%eax
80105b5b:	75 f3                	jne    80105b50 <acquire+0x80>
}
80105b5d:	83 c4 10             	add    $0x10,%esp
80105b60:	5b                   	pop    %ebx
80105b61:	5e                   	pop    %esi
80105b62:	5d                   	pop    %ebp
80105b63:	c3                   	ret    
    panic("acquire");
80105b64:	c7 04 24 cc 8f 10 80 	movl   $0x80108fcc,(%esp)
80105b6b:	e8 00 a8 ff ff       	call   80100370 <panic>

80105b70 <release>:
{
80105b70:	55                   	push   %ebp
80105b71:	89 e5                	mov    %esp,%ebp
80105b73:	53                   	push   %ebx
80105b74:	83 ec 14             	sub    $0x14,%esp
80105b77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80105b7a:	89 1c 24             	mov    %ebx,(%esp)
80105b7d:	e8 0e ff ff ff       	call   80105a90 <holding>
80105b82:	85 c0                	test   %eax,%eax
80105b84:	74 23                	je     80105ba9 <release+0x39>
  lk->pcs[0] = 0;
80105b86:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105b8d:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105b94:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80105b99:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105b9f:	83 c4 14             	add    $0x14,%esp
80105ba2:	5b                   	pop    %ebx
80105ba3:	5d                   	pop    %ebp
  popcli();
80105ba4:	e9 87 fe ff ff       	jmp    80105a30 <popcli>
    panic("release");
80105ba9:	c7 04 24 d4 8f 10 80 	movl   $0x80108fd4,(%esp)
80105bb0:	e8 bb a7 ff ff       	call   80100370 <panic>
80105bb5:	66 90                	xchg   %ax,%ax
80105bb7:	66 90                	xchg   %ax,%ax
80105bb9:	66 90                	xchg   %ax,%ax
80105bbb:	66 90                	xchg   %ax,%ax
80105bbd:	66 90                	xchg   %ax,%ax
80105bbf:	90                   	nop

80105bc0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105bc0:	55                   	push   %ebp
80105bc1:	89 e5                	mov    %esp,%ebp
80105bc3:	83 ec 08             	sub    $0x8,%esp
80105bc6:	8b 55 08             	mov    0x8(%ebp),%edx
80105bc9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105bcc:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105bcf:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if ((int)dst%4 == 0 && n%4 == 0){
80105bd2:	f6 c2 03             	test   $0x3,%dl
80105bd5:	75 05                	jne    80105bdc <memset+0x1c>
80105bd7:	f6 c1 03             	test   $0x3,%cl
80105bda:	74 14                	je     80105bf0 <memset+0x30>
  asm volatile("cld; rep stosb" :
80105bdc:	89 d7                	mov    %edx,%edi
80105bde:	8b 45 0c             	mov    0xc(%ebp),%eax
80105be1:	fc                   	cld    
80105be2:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80105be4:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105be7:	89 d0                	mov    %edx,%eax
80105be9:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105bec:	89 ec                	mov    %ebp,%esp
80105bee:	5d                   	pop    %ebp
80105bef:	c3                   	ret    
    c &= 0xFF;
80105bf0:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80105bf4:	c1 e9 02             	shr    $0x2,%ecx
80105bf7:	89 f8                	mov    %edi,%eax
80105bf9:	89 fb                	mov    %edi,%ebx
80105bfb:	c1 e0 18             	shl    $0x18,%eax
80105bfe:	c1 e3 10             	shl    $0x10,%ebx
80105c01:	09 d8                	or     %ebx,%eax
80105c03:	09 f8                	or     %edi,%eax
80105c05:	c1 e7 08             	shl    $0x8,%edi
80105c08:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80105c0a:	89 d7                	mov    %edx,%edi
80105c0c:	fc                   	cld    
80105c0d:	f3 ab                	rep stos %eax,%es:(%edi)
}
80105c0f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105c12:	89 d0                	mov    %edx,%eax
80105c14:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105c17:	89 ec                	mov    %ebp,%esp
80105c19:	5d                   	pop    %ebp
80105c1a:	c3                   	ret    
80105c1b:	90                   	nop
80105c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c20 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105c20:	55                   	push   %ebp
80105c21:	89 e5                	mov    %esp,%ebp
80105c23:	57                   	push   %edi
80105c24:	8b 7d 0c             	mov    0xc(%ebp),%edi
80105c27:	56                   	push   %esi
80105c28:	8b 75 08             	mov    0x8(%ebp),%esi
80105c2b:	53                   	push   %ebx
80105c2c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105c2f:	85 db                	test   %ebx,%ebx
80105c31:	74 27                	je     80105c5a <memcmp+0x3a>
    if(*s1 != *s2)
80105c33:	0f b6 16             	movzbl (%esi),%edx
80105c36:	0f b6 0f             	movzbl (%edi),%ecx
80105c39:	38 d1                	cmp    %dl,%cl
80105c3b:	75 2b                	jne    80105c68 <memcmp+0x48>
80105c3d:	b8 01 00 00 00       	mov    $0x1,%eax
80105c42:	eb 12                	jmp    80105c56 <memcmp+0x36>
80105c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c48:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80105c4c:	40                   	inc    %eax
80105c4d:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80105c52:	38 ca                	cmp    %cl,%dl
80105c54:	75 12                	jne    80105c68 <memcmp+0x48>
  while(n-- > 0){
80105c56:	39 d8                	cmp    %ebx,%eax
80105c58:	75 ee                	jne    80105c48 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80105c5a:	5b                   	pop    %ebx
  return 0;
80105c5b:	31 c0                	xor    %eax,%eax
}
80105c5d:	5e                   	pop    %esi
80105c5e:	5f                   	pop    %edi
80105c5f:	5d                   	pop    %ebp
80105c60:	c3                   	ret    
80105c61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c68:	5b                   	pop    %ebx
      return *s1 - *s2;
80105c69:	0f b6 c2             	movzbl %dl,%eax
80105c6c:	29 c8                	sub    %ecx,%eax
}
80105c6e:	5e                   	pop    %esi
80105c6f:	5f                   	pop    %edi
80105c70:	5d                   	pop    %ebp
80105c71:	c3                   	ret    
80105c72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105c80 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105c80:	55                   	push   %ebp
80105c81:	89 e5                	mov    %esp,%ebp
80105c83:	56                   	push   %esi
80105c84:	8b 45 08             	mov    0x8(%ebp),%eax
80105c87:	53                   	push   %ebx
80105c88:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80105c8b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80105c8e:	39 c3                	cmp    %eax,%ebx
80105c90:	73 26                	jae    80105cb8 <memmove+0x38>
80105c92:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80105c95:	39 c8                	cmp    %ecx,%eax
80105c97:	73 1f                	jae    80105cb8 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80105c99:	85 f6                	test   %esi,%esi
80105c9b:	8d 56 ff             	lea    -0x1(%esi),%edx
80105c9e:	74 0d                	je     80105cad <memmove+0x2d>
      *--d = *--s;
80105ca0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105ca4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80105ca7:	4a                   	dec    %edx
80105ca8:	83 fa ff             	cmp    $0xffffffff,%edx
80105cab:	75 f3                	jne    80105ca0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80105cad:	5b                   	pop    %ebx
80105cae:	5e                   	pop    %esi
80105caf:	5d                   	pop    %ebp
80105cb0:	c3                   	ret    
80105cb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80105cb8:	31 d2                	xor    %edx,%edx
80105cba:	85 f6                	test   %esi,%esi
80105cbc:	74 ef                	je     80105cad <memmove+0x2d>
80105cbe:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80105cc0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105cc4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80105cc7:	42                   	inc    %edx
    while(n-- > 0)
80105cc8:	39 d6                	cmp    %edx,%esi
80105cca:	75 f4                	jne    80105cc0 <memmove+0x40>
}
80105ccc:	5b                   	pop    %ebx
80105ccd:	5e                   	pop    %esi
80105cce:	5d                   	pop    %ebp
80105ccf:	c3                   	ret    

80105cd0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105cd0:	55                   	push   %ebp
80105cd1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80105cd3:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80105cd4:	eb aa                	jmp    80105c80 <memmove>
80105cd6:	8d 76 00             	lea    0x0(%esi),%esi
80105cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ce0 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80105ce0:	55                   	push   %ebp
80105ce1:	89 e5                	mov    %esp,%ebp
80105ce3:	57                   	push   %edi
80105ce4:	8b 7d 10             	mov    0x10(%ebp),%edi
80105ce7:	56                   	push   %esi
80105ce8:	8b 75 0c             	mov    0xc(%ebp),%esi
80105ceb:	53                   	push   %ebx
80105cec:	8b 5d 08             	mov    0x8(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
80105cef:	85 ff                	test   %edi,%edi
80105cf1:	74 2d                	je     80105d20 <strncmp+0x40>
80105cf3:	0f b6 03             	movzbl (%ebx),%eax
80105cf6:	0f b6 0e             	movzbl (%esi),%ecx
80105cf9:	84 c0                	test   %al,%al
80105cfb:	74 37                	je     80105d34 <strncmp+0x54>
80105cfd:	38 c1                	cmp    %al,%cl
80105cff:	75 33                	jne    80105d34 <strncmp+0x54>
80105d01:	01 f7                	add    %esi,%edi
80105d03:	eb 13                	jmp    80105d18 <strncmp+0x38>
80105d05:	8d 76 00             	lea    0x0(%esi),%esi
80105d08:	0f b6 03             	movzbl (%ebx),%eax
80105d0b:	84 c0                	test   %al,%al
80105d0d:	74 21                	je     80105d30 <strncmp+0x50>
80105d0f:	0f b6 0a             	movzbl (%edx),%ecx
80105d12:	89 d6                	mov    %edx,%esi
80105d14:	38 c8                	cmp    %cl,%al
80105d16:	75 1c                	jne    80105d34 <strncmp+0x54>
    n--, p++, q++;
80105d18:	8d 56 01             	lea    0x1(%esi),%edx
80105d1b:	43                   	inc    %ebx
  while(n > 0 && *p && *p == *q)
80105d1c:	39 fa                	cmp    %edi,%edx
80105d1e:	75 e8                	jne    80105d08 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80105d20:	5b                   	pop    %ebx
    return 0;
80105d21:	31 c0                	xor    %eax,%eax
}
80105d23:	5e                   	pop    %esi
80105d24:	5f                   	pop    %edi
80105d25:	5d                   	pop    %ebp
80105d26:	c3                   	ret    
80105d27:	89 f6                	mov    %esi,%esi
80105d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105d30:	0f b6 4e 01          	movzbl 0x1(%esi),%ecx
80105d34:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
80105d35:	29 c8                	sub    %ecx,%eax
}
80105d37:	5e                   	pop    %esi
80105d38:	5f                   	pop    %edi
80105d39:	5d                   	pop    %ebp
80105d3a:	c3                   	ret    
80105d3b:	90                   	nop
80105d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d40 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105d40:	55                   	push   %ebp
80105d41:	89 e5                	mov    %esp,%ebp
80105d43:	8b 45 08             	mov    0x8(%ebp),%eax
80105d46:	56                   	push   %esi
80105d47:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105d4a:	53                   	push   %ebx
80105d4b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80105d4e:	89 c2                	mov    %eax,%edx
80105d50:	eb 15                	jmp    80105d67 <strncpy+0x27>
80105d52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105d58:	46                   	inc    %esi
80105d59:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
80105d5d:	42                   	inc    %edx
80105d5e:	84 c9                	test   %cl,%cl
80105d60:	88 4a ff             	mov    %cl,-0x1(%edx)
80105d63:	74 09                	je     80105d6e <strncpy+0x2e>
80105d65:	89 d9                	mov    %ebx,%ecx
80105d67:	85 c9                	test   %ecx,%ecx
80105d69:	8d 59 ff             	lea    -0x1(%ecx),%ebx
80105d6c:	7f ea                	jg     80105d58 <strncpy+0x18>
    ;
  while(n-- > 0)
80105d6e:	31 c9                	xor    %ecx,%ecx
80105d70:	85 db                	test   %ebx,%ebx
80105d72:	7e 19                	jle    80105d8d <strncpy+0x4d>
80105d74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105d7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *s++ = 0;
80105d80:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80105d84:	89 de                	mov    %ebx,%esi
80105d86:	41                   	inc    %ecx
80105d87:	29 ce                	sub    %ecx,%esi
  while(n-- > 0)
80105d89:	85 f6                	test   %esi,%esi
80105d8b:	7f f3                	jg     80105d80 <strncpy+0x40>
  return os;
}
80105d8d:	5b                   	pop    %ebx
80105d8e:	5e                   	pop    %esi
80105d8f:	5d                   	pop    %ebp
80105d90:	c3                   	ret    
80105d91:	eb 0d                	jmp    80105da0 <safestrcpy>
80105d93:	90                   	nop
80105d94:	90                   	nop
80105d95:	90                   	nop
80105d96:	90                   	nop
80105d97:	90                   	nop
80105d98:	90                   	nop
80105d99:	90                   	nop
80105d9a:	90                   	nop
80105d9b:	90                   	nop
80105d9c:	90                   	nop
80105d9d:	90                   	nop
80105d9e:	90                   	nop
80105d9f:	90                   	nop

80105da0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105da0:	55                   	push   %ebp
80105da1:	89 e5                	mov    %esp,%ebp
80105da3:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105da6:	56                   	push   %esi
80105da7:	8b 45 08             	mov    0x8(%ebp),%eax
80105daa:	53                   	push   %ebx
80105dab:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80105dae:	85 c9                	test   %ecx,%ecx
80105db0:	7e 22                	jle    80105dd4 <safestrcpy+0x34>
80105db2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80105db6:	89 c1                	mov    %eax,%ecx
80105db8:	eb 13                	jmp    80105dcd <safestrcpy+0x2d>
80105dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105dc0:	42                   	inc    %edx
80105dc1:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80105dc5:	41                   	inc    %ecx
80105dc6:	84 db                	test   %bl,%bl
80105dc8:	88 59 ff             	mov    %bl,-0x1(%ecx)
80105dcb:	74 04                	je     80105dd1 <safestrcpy+0x31>
80105dcd:	39 f2                	cmp    %esi,%edx
80105dcf:	75 ef                	jne    80105dc0 <safestrcpy+0x20>
    ;
  *s = 0;
80105dd1:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80105dd4:	5b                   	pop    %ebx
80105dd5:	5e                   	pop    %esi
80105dd6:	5d                   	pop    %ebp
80105dd7:	c3                   	ret    
80105dd8:	90                   	nop
80105dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105de0 <strlen>:

int
strlen(const char *s)
{
80105de0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105de1:	31 c0                	xor    %eax,%eax
{
80105de3:	89 e5                	mov    %esp,%ebp
80105de5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105de8:	80 3a 00             	cmpb   $0x0,(%edx)
80105deb:	74 0a                	je     80105df7 <strlen+0x17>
80105ded:	8d 76 00             	lea    0x0(%esi),%esi
80105df0:	40                   	inc    %eax
80105df1:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105df5:	75 f9                	jne    80105df0 <strlen+0x10>
    ;
  return n;
}
80105df7:	5d                   	pop    %ebp
80105df8:	c3                   	ret    

80105df9 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80105df9:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80105dfd:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80105e01:	55                   	push   %ebp
  pushl %ebx
80105e02:	53                   	push   %ebx
  pushl %esi
80105e03:	56                   	push   %esi
  pushl %edi
80105e04:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105e05:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105e07:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80105e09:	5f                   	pop    %edi
  popl %esi
80105e0a:	5e                   	pop    %esi
  popl %ebx
80105e0b:	5b                   	pop    %ebx
  popl %ebp
80105e0c:	5d                   	pop    %ebp
  ret
80105e0d:	c3                   	ret    
80105e0e:	66 90                	xchg   %ax,%ax

80105e10 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105e10:	55                   	push   %ebp
80105e11:	89 e5                	mov    %esp,%ebp
80105e13:	53                   	push   %ebx
80105e14:	83 ec 04             	sub    $0x4,%esp
80105e17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80105e1a:	e8 01 dc ff ff       	call   80103a20 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105e1f:	8b 00                	mov    (%eax),%eax
80105e21:	39 d8                	cmp    %ebx,%eax
80105e23:	76 1b                	jbe    80105e40 <fetchint+0x30>
80105e25:	8d 53 04             	lea    0x4(%ebx),%edx
80105e28:	39 d0                	cmp    %edx,%eax
80105e2a:	72 14                	jb     80105e40 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80105e2c:	8b 45 0c             	mov    0xc(%ebp),%eax
80105e2f:	8b 13                	mov    (%ebx),%edx
80105e31:	89 10                	mov    %edx,(%eax)
  return 0;
80105e33:	31 c0                	xor    %eax,%eax
}
80105e35:	5a                   	pop    %edx
80105e36:	5b                   	pop    %ebx
80105e37:	5d                   	pop    %ebp
80105e38:	c3                   	ret    
80105e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105e40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e45:	eb ee                	jmp    80105e35 <fetchint+0x25>
80105e47:	89 f6                	mov    %esi,%esi
80105e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e50 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105e50:	55                   	push   %ebp
80105e51:	89 e5                	mov    %esp,%ebp
80105e53:	53                   	push   %ebx
80105e54:	83 ec 04             	sub    $0x4,%esp
80105e57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80105e5a:	e8 c1 db ff ff       	call   80103a20 <myproc>

  if(addr >= curproc->sz)
80105e5f:	39 18                	cmp    %ebx,(%eax)
80105e61:	76 27                	jbe    80105e8a <fetchstr+0x3a>
    return -1;
  *pp = (char*)addr;
80105e63:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105e66:	89 da                	mov    %ebx,%edx
80105e68:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80105e6a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80105e6c:	39 c3                	cmp    %eax,%ebx
80105e6e:	73 1a                	jae    80105e8a <fetchstr+0x3a>
    if(*s == 0)
80105e70:	80 3b 00             	cmpb   $0x0,(%ebx)
80105e73:	75 10                	jne    80105e85 <fetchstr+0x35>
80105e75:	eb 29                	jmp    80105ea0 <fetchstr+0x50>
80105e77:	89 f6                	mov    %esi,%esi
80105e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105e80:	80 3a 00             	cmpb   $0x0,(%edx)
80105e83:	74 13                	je     80105e98 <fetchstr+0x48>
  for(s = *pp; s < ep; s++){
80105e85:	42                   	inc    %edx
80105e86:	39 d0                	cmp    %edx,%eax
80105e88:	77 f6                	ja     80105e80 <fetchstr+0x30>
    return -1;
80105e8a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80105e8f:	5a                   	pop    %edx
80105e90:	5b                   	pop    %ebx
80105e91:	5d                   	pop    %ebp
80105e92:	c3                   	ret    
80105e93:	90                   	nop
80105e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e98:	89 d0                	mov    %edx,%eax
80105e9a:	5a                   	pop    %edx
80105e9b:	29 d8                	sub    %ebx,%eax
80105e9d:	5b                   	pop    %ebx
80105e9e:	5d                   	pop    %ebp
80105e9f:	c3                   	ret    
    if(*s == 0)
80105ea0:	31 c0                	xor    %eax,%eax
      return s - *pp;
80105ea2:	eb eb                	jmp    80105e8f <fetchstr+0x3f>
80105ea4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105eaa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105eb0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105eb0:	55                   	push   %ebp
80105eb1:	89 e5                	mov    %esp,%ebp
80105eb3:	56                   	push   %esi
80105eb4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105eb5:	e8 66 db ff ff       	call   80103a20 <myproc>
80105eba:	8b 55 08             	mov    0x8(%ebp),%edx
80105ebd:	8b 40 18             	mov    0x18(%eax),%eax
80105ec0:	8b 40 44             	mov    0x44(%eax),%eax
80105ec3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105ec6:	e8 55 db ff ff       	call   80103a20 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105ecb:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105ece:	8b 00                	mov    (%eax),%eax
80105ed0:	39 c6                	cmp    %eax,%esi
80105ed2:	73 1c                	jae    80105ef0 <argint+0x40>
80105ed4:	8d 53 08             	lea    0x8(%ebx),%edx
80105ed7:	39 d0                	cmp    %edx,%eax
80105ed9:	72 15                	jb     80105ef0 <argint+0x40>
  *ip = *(int*)(addr);
80105edb:	8b 45 0c             	mov    0xc(%ebp),%eax
80105ede:	8b 53 04             	mov    0x4(%ebx),%edx
80105ee1:	89 10                	mov    %edx,(%eax)
  return 0;
80105ee3:	31 c0                	xor    %eax,%eax
}
80105ee5:	5b                   	pop    %ebx
80105ee6:	5e                   	pop    %esi
80105ee7:	5d                   	pop    %ebp
80105ee8:	c3                   	ret    
80105ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105ef0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105ef5:	eb ee                	jmp    80105ee5 <argint+0x35>
80105ef7:	89 f6                	mov    %esi,%esi
80105ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105f00 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105f00:	55                   	push   %ebp
80105f01:	89 e5                	mov    %esp,%ebp
80105f03:	56                   	push   %esi
80105f04:	53                   	push   %ebx
80105f05:	83 ec 20             	sub    $0x20,%esp
80105f08:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80105f0b:	e8 10 db ff ff       	call   80103a20 <myproc>
80105f10:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80105f12:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f15:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f19:	8b 45 08             	mov    0x8(%ebp),%eax
80105f1c:	89 04 24             	mov    %eax,(%esp)
80105f1f:	e8 8c ff ff ff       	call   80105eb0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105f24:	c1 e8 1f             	shr    $0x1f,%eax
80105f27:	84 c0                	test   %al,%al
80105f29:	75 2d                	jne    80105f58 <argptr+0x58>
80105f2b:	89 d8                	mov    %ebx,%eax
80105f2d:	c1 e8 1f             	shr    $0x1f,%eax
80105f30:	84 c0                	test   %al,%al
80105f32:	75 24                	jne    80105f58 <argptr+0x58>
80105f34:	8b 16                	mov    (%esi),%edx
80105f36:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f39:	39 c2                	cmp    %eax,%edx
80105f3b:	76 1b                	jbe    80105f58 <argptr+0x58>
80105f3d:	01 c3                	add    %eax,%ebx
80105f3f:	39 da                	cmp    %ebx,%edx
80105f41:	72 15                	jb     80105f58 <argptr+0x58>
    return -1;
  *pp = (char*)i;
80105f43:	8b 55 0c             	mov    0xc(%ebp),%edx
80105f46:	89 02                	mov    %eax,(%edx)
  return 0;
80105f48:	31 c0                	xor    %eax,%eax
}
80105f4a:	83 c4 20             	add    $0x20,%esp
80105f4d:	5b                   	pop    %ebx
80105f4e:	5e                   	pop    %esi
80105f4f:	5d                   	pop    %ebp
80105f50:	c3                   	ret    
80105f51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105f58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f5d:	eb eb                	jmp    80105f4a <argptr+0x4a>
80105f5f:	90                   	nop

80105f60 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105f60:	55                   	push   %ebp
80105f61:	89 e5                	mov    %esp,%ebp
80105f63:	83 ec 28             	sub    $0x28,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105f66:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f69:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f6d:	8b 45 08             	mov    0x8(%ebp),%eax
80105f70:	89 04 24             	mov    %eax,(%esp)
80105f73:	e8 38 ff ff ff       	call   80105eb0 <argint>
80105f78:	85 c0                	test   %eax,%eax
80105f7a:	78 14                	js     80105f90 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80105f7c:	8b 45 0c             	mov    0xc(%ebp),%eax
80105f7f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f83:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f86:	89 04 24             	mov    %eax,(%esp)
80105f89:	e8 c2 fe ff ff       	call   80105e50 <fetchstr>
}
80105f8e:	c9                   	leave  
80105f8f:	c3                   	ret    
    return -1;
80105f90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f95:	c9                   	leave  
80105f96:	c3                   	ret    
80105f97:	89 f6                	mov    %esi,%esi
80105f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105fa0 <syscall>:
[SYS_policy]  sys_policy,
};

void
syscall(void)
{
80105fa0:	55                   	push   %ebp
80105fa1:	89 e5                	mov    %esp,%ebp
80105fa3:	53                   	push   %ebx
80105fa4:	83 ec 14             	sub    $0x14,%esp
  int num;
  struct proc *curproc = myproc();
80105fa7:	e8 74 da ff ff       	call   80103a20 <myproc>
80105fac:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80105fae:	8b 40 18             	mov    0x18(%eax),%eax
80105fb1:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105fb4:	8d 50 ff             	lea    -0x1(%eax),%edx
80105fb7:	83 fa 16             	cmp    $0x16,%edx
80105fba:	77 1c                	ja     80105fd8 <syscall+0x38>
80105fbc:	8b 14 85 00 90 10 80 	mov    -0x7fef7000(,%eax,4),%edx
80105fc3:	85 d2                	test   %edx,%edx
80105fc5:	74 11                	je     80105fd8 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80105fc7:	ff d2                	call   *%edx
80105fc9:	8b 53 18             	mov    0x18(%ebx),%edx
80105fcc:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105fcf:	83 c4 14             	add    $0x14,%esp
80105fd2:	5b                   	pop    %ebx
80105fd3:	5d                   	pop    %ebp
80105fd4:	c3                   	ret    
80105fd5:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80105fd8:	89 44 24 0c          	mov    %eax,0xc(%esp)
            curproc->pid, curproc->name, num);
80105fdc:	8d 43 6c             	lea    0x6c(%ebx),%eax
80105fdf:	89 44 24 08          	mov    %eax,0x8(%esp)
    cprintf("%d %s: unknown sys call %d\n",
80105fe3:	8b 43 10             	mov    0x10(%ebx),%eax
80105fe6:	c7 04 24 dc 8f 10 80 	movl   $0x80108fdc,(%esp)
80105fed:	89 44 24 04          	mov    %eax,0x4(%esp)
80105ff1:	e8 5a a6 ff ff       	call   80100650 <cprintf>
    curproc->tf->eax = -1;
80105ff6:	8b 43 18             	mov    0x18(%ebx),%eax
80105ff9:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80106000:	83 c4 14             	add    $0x14,%esp
80106003:	5b                   	pop    %ebx
80106004:	5d                   	pop    %ebp
80106005:	c3                   	ret    
80106006:	66 90                	xchg   %ax,%ax
80106008:	66 90                	xchg   %ax,%ax
8010600a:	66 90                	xchg   %ax,%ax
8010600c:	66 90                	xchg   %ax,%ax
8010600e:	66 90                	xchg   %ax,%ax

80106010 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80106010:	55                   	push   %ebp
80106011:	0f bf d2             	movswl %dx,%edx
80106014:	89 e5                	mov    %esp,%ebp
80106016:	83 ec 58             	sub    $0x58,%esp
80106019:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010601c:	0f bf 7d 08          	movswl 0x8(%ebp),%edi
80106020:	0f bf c9             	movswl %cx,%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80106023:	89 04 24             	mov    %eax,(%esp)
{
80106026:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80106029:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010602c:	89 7d bc             	mov    %edi,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010602f:	8d 7d da             	lea    -0x26(%ebp),%edi
80106032:	89 7c 24 04          	mov    %edi,0x4(%esp)
{
80106036:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80106039:	89 4d c0             	mov    %ecx,-0x40(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010603c:	e8 af bf ff ff       	call   80101ff0 <nameiparent>
80106041:	85 c0                	test   %eax,%eax
80106043:	0f 84 4f 01 00 00    	je     80106198 <create+0x188>
    return 0;
  ilock(dp);
80106049:	89 04 24             	mov    %eax,(%esp)
8010604c:	89 c3                	mov    %eax,%ebx
8010604e:	e8 9d b6 ff ff       	call   801016f0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80106053:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80106056:	89 44 24 08          	mov    %eax,0x8(%esp)
8010605a:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010605e:	89 1c 24             	mov    %ebx,(%esp)
80106061:	e8 0a bc ff ff       	call   80101c70 <dirlookup>
80106066:	85 c0                	test   %eax,%eax
80106068:	89 c6                	mov    %eax,%esi
8010606a:	74 34                	je     801060a0 <create+0x90>
    iunlockput(dp);
8010606c:	89 1c 24             	mov    %ebx,(%esp)
8010606f:	e8 0c b9 ff ff       	call   80101980 <iunlockput>
    ilock(ip);
80106074:	89 34 24             	mov    %esi,(%esp)
80106077:	e8 74 b6 ff ff       	call   801016f0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010607c:	83 7d c4 02          	cmpl   $0x2,-0x3c(%ebp)
80106080:	0f 85 9a 00 00 00    	jne    80106120 <create+0x110>
80106086:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010608b:	0f 85 8f 00 00 00    	jne    80106120 <create+0x110>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80106091:	89 f0                	mov    %esi,%eax
80106093:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80106096:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106099:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010609c:	89 ec                	mov    %ebp,%esp
8010609e:	5d                   	pop    %ebp
8010609f:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
801060a0:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801060a3:	89 44 24 04          	mov    %eax,0x4(%esp)
801060a7:	8b 03                	mov    (%ebx),%eax
801060a9:	89 04 24             	mov    %eax,(%esp)
801060ac:	e8 bf b4 ff ff       	call   80101570 <ialloc>
801060b1:	85 c0                	test   %eax,%eax
801060b3:	89 c6                	mov    %eax,%esi
801060b5:	0f 84 f0 00 00 00    	je     801061ab <create+0x19b>
  ilock(ip);
801060bb:	89 04 24             	mov    %eax,(%esp)
801060be:	e8 2d b6 ff ff       	call   801016f0 <ilock>
  ip->major = major;
801060c3:	8b 45 c0             	mov    -0x40(%ebp),%eax
  ip->nlink = 1;
801060c6:	66 c7 46 56 01 00    	movw   $0x1,0x56(%esi)
  ip->major = major;
801060cc:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
801060d0:	8b 45 bc             	mov    -0x44(%ebp),%eax
801060d3:	66 89 46 54          	mov    %ax,0x54(%esi)
  iupdate(ip);
801060d7:	89 34 24             	mov    %esi,(%esp)
801060da:	e8 51 b5 ff ff       	call   80101630 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
801060df:	83 7d c4 01          	cmpl   $0x1,-0x3c(%ebp)
801060e3:	74 5b                	je     80106140 <create+0x130>
  if(dirlink(dp, name, ip->inum) < 0)
801060e5:	8b 46 04             	mov    0x4(%esi),%eax
801060e8:	89 7c 24 04          	mov    %edi,0x4(%esp)
801060ec:	89 1c 24             	mov    %ebx,(%esp)
801060ef:	89 44 24 08          	mov    %eax,0x8(%esp)
801060f3:	e8 f8 bd ff ff       	call   80101ef0 <dirlink>
801060f8:	85 c0                	test   %eax,%eax
801060fa:	0f 88 9f 00 00 00    	js     8010619f <create+0x18f>
  iunlockput(dp);
80106100:	89 1c 24             	mov    %ebx,(%esp)
80106103:	e8 78 b8 ff ff       	call   80101980 <iunlockput>
}
80106108:	89 f0                	mov    %esi,%eax
8010610a:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010610d:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106110:	8b 7d fc             	mov    -0x4(%ebp),%edi
80106113:	89 ec                	mov    %ebp,%esp
80106115:	5d                   	pop    %ebp
80106116:	c3                   	ret    
80106117:	89 f6                	mov    %esi,%esi
80106119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80106120:	89 34 24             	mov    %esi,(%esp)
    return 0;
80106123:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80106125:	e8 56 b8 ff ff       	call   80101980 <iunlockput>
}
8010612a:	89 f0                	mov    %esi,%eax
8010612c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010612f:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106132:	8b 7d fc             	mov    -0x4(%ebp),%edi
80106135:	89 ec                	mov    %ebp,%esp
80106137:	5d                   	pop    %ebp
80106138:	c3                   	ret    
80106139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80106140:	66 ff 43 56          	incw   0x56(%ebx)
    iupdate(dp);
80106144:	89 1c 24             	mov    %ebx,(%esp)
80106147:	e8 e4 b4 ff ff       	call   80101630 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010614c:	8b 46 04             	mov    0x4(%esi),%eax
8010614f:	ba 7c 90 10 80       	mov    $0x8010907c,%edx
80106154:	89 54 24 04          	mov    %edx,0x4(%esp)
80106158:	89 34 24             	mov    %esi,(%esp)
8010615b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010615f:	e8 8c bd ff ff       	call   80101ef0 <dirlink>
80106164:	85 c0                	test   %eax,%eax
80106166:	78 20                	js     80106188 <create+0x178>
80106168:	8b 43 04             	mov    0x4(%ebx),%eax
8010616b:	89 34 24             	mov    %esi,(%esp)
8010616e:	89 44 24 08          	mov    %eax,0x8(%esp)
80106172:	b8 7b 90 10 80       	mov    $0x8010907b,%eax
80106177:	89 44 24 04          	mov    %eax,0x4(%esp)
8010617b:	e8 70 bd ff ff       	call   80101ef0 <dirlink>
80106180:	85 c0                	test   %eax,%eax
80106182:	0f 89 5d ff ff ff    	jns    801060e5 <create+0xd5>
      panic("create dots");
80106188:	c7 04 24 6f 90 10 80 	movl   $0x8010906f,(%esp)
8010618f:	e8 dc a1 ff ff       	call   80100370 <panic>
80106194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80106198:	31 f6                	xor    %esi,%esi
8010619a:	e9 f2 fe ff ff       	jmp    80106091 <create+0x81>
    panic("create: dirlink");
8010619f:	c7 04 24 7e 90 10 80 	movl   $0x8010907e,(%esp)
801061a6:	e8 c5 a1 ff ff       	call   80100370 <panic>
    panic("create: ialloc");
801061ab:	c7 04 24 60 90 10 80 	movl   $0x80109060,(%esp)
801061b2:	e8 b9 a1 ff ff       	call   80100370 <panic>
801061b7:	89 f6                	mov    %esi,%esi
801061b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801061c0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
801061c0:	55                   	push   %ebp
801061c1:	89 e5                	mov    %esp,%ebp
801061c3:	56                   	push   %esi
801061c4:	89 d6                	mov    %edx,%esi
801061c6:	53                   	push   %ebx
801061c7:	89 c3                	mov    %eax,%ebx
801061c9:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
801061cc:	8d 45 f4             	lea    -0xc(%ebp),%eax
801061cf:	89 44 24 04          	mov    %eax,0x4(%esp)
801061d3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801061da:	e8 d1 fc ff ff       	call   80105eb0 <argint>
801061df:	85 c0                	test   %eax,%eax
801061e1:	78 2d                	js     80106210 <argfd.constprop.0+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801061e3:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801061e7:	77 27                	ja     80106210 <argfd.constprop.0+0x50>
801061e9:	e8 32 d8 ff ff       	call   80103a20 <myproc>
801061ee:	8b 55 f4             	mov    -0xc(%ebp),%edx
801061f1:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
801061f5:	85 c0                	test   %eax,%eax
801061f7:	74 17                	je     80106210 <argfd.constprop.0+0x50>
  if(pfd)
801061f9:	85 db                	test   %ebx,%ebx
801061fb:	74 02                	je     801061ff <argfd.constprop.0+0x3f>
    *pfd = fd;
801061fd:	89 13                	mov    %edx,(%ebx)
    *pf = f;
801061ff:	89 06                	mov    %eax,(%esi)
  return 0;
80106201:	31 c0                	xor    %eax,%eax
}
80106203:	83 c4 20             	add    $0x20,%esp
80106206:	5b                   	pop    %ebx
80106207:	5e                   	pop    %esi
80106208:	5d                   	pop    %ebp
80106209:	c3                   	ret    
8010620a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106210:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106215:	eb ec                	jmp    80106203 <argfd.constprop.0+0x43>
80106217:	89 f6                	mov    %esi,%esi
80106219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106220 <sys_dup>:
{
80106220:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80106221:	31 c0                	xor    %eax,%eax
{
80106223:	89 e5                	mov    %esp,%ebp
80106225:	56                   	push   %esi
80106226:	53                   	push   %ebx
80106227:	83 ec 20             	sub    $0x20,%esp
  if(argfd(0, 0, &f) < 0)
8010622a:	8d 55 f4             	lea    -0xc(%ebp),%edx
8010622d:	e8 8e ff ff ff       	call   801061c0 <argfd.constprop.0>
80106232:	85 c0                	test   %eax,%eax
80106234:	78 3a                	js     80106270 <sys_dup+0x50>
  if((fd=fdalloc(f)) < 0)
80106236:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106239:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010623b:	e8 e0 d7 ff ff       	call   80103a20 <myproc>
80106240:	eb 0c                	jmp    8010624e <sys_dup+0x2e>
80106242:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106248:	43                   	inc    %ebx
80106249:	83 fb 10             	cmp    $0x10,%ebx
8010624c:	74 22                	je     80106270 <sys_dup+0x50>
    if(curproc->ofile[fd] == 0){
8010624e:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80106252:	85 d2                	test   %edx,%edx
80106254:	75 f2                	jne    80106248 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80106256:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
8010625a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010625d:	89 04 24             	mov    %eax,(%esp)
80106260:	e8 7b ab ff ff       	call   80100de0 <filedup>
}
80106265:	83 c4 20             	add    $0x20,%esp
80106268:	89 d8                	mov    %ebx,%eax
8010626a:	5b                   	pop    %ebx
8010626b:	5e                   	pop    %esi
8010626c:	5d                   	pop    %ebp
8010626d:	c3                   	ret    
8010626e:	66 90                	xchg   %ax,%ax
80106270:	83 c4 20             	add    $0x20,%esp
    return -1;
80106273:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80106278:	89 d8                	mov    %ebx,%eax
8010627a:	5b                   	pop    %ebx
8010627b:	5e                   	pop    %esi
8010627c:	5d                   	pop    %ebp
8010627d:	c3                   	ret    
8010627e:	66 90                	xchg   %ax,%ax

80106280 <sys_read>:
{
80106280:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106281:	31 c0                	xor    %eax,%eax
{
80106283:	89 e5                	mov    %esp,%ebp
80106285:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106288:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010628b:	e8 30 ff ff ff       	call   801061c0 <argfd.constprop.0>
80106290:	85 c0                	test   %eax,%eax
80106292:	78 54                	js     801062e8 <sys_read+0x68>
80106294:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106297:	89 44 24 04          	mov    %eax,0x4(%esp)
8010629b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801062a2:	e8 09 fc ff ff       	call   80105eb0 <argint>
801062a7:	85 c0                	test   %eax,%eax
801062a9:	78 3d                	js     801062e8 <sys_read+0x68>
801062ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
801062ae:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801062b5:	89 44 24 08          	mov    %eax,0x8(%esp)
801062b9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801062bc:	89 44 24 04          	mov    %eax,0x4(%esp)
801062c0:	e8 3b fc ff ff       	call   80105f00 <argptr>
801062c5:	85 c0                	test   %eax,%eax
801062c7:	78 1f                	js     801062e8 <sys_read+0x68>
  return fileread(f, p, n);
801062c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801062cc:	89 44 24 08          	mov    %eax,0x8(%esp)
801062d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062d3:	89 44 24 04          	mov    %eax,0x4(%esp)
801062d7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801062da:	89 04 24             	mov    %eax,(%esp)
801062dd:	e8 7e ac ff ff       	call   80100f60 <fileread>
}
801062e2:	c9                   	leave  
801062e3:	c3                   	ret    
801062e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801062e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801062ed:	c9                   	leave  
801062ee:	c3                   	ret    
801062ef:	90                   	nop

801062f0 <sys_write>:
{
801062f0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801062f1:	31 c0                	xor    %eax,%eax
{
801062f3:	89 e5                	mov    %esp,%ebp
801062f5:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801062f8:	8d 55 ec             	lea    -0x14(%ebp),%edx
801062fb:	e8 c0 fe ff ff       	call   801061c0 <argfd.constprop.0>
80106300:	85 c0                	test   %eax,%eax
80106302:	78 54                	js     80106358 <sys_write+0x68>
80106304:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106307:	89 44 24 04          	mov    %eax,0x4(%esp)
8010630b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106312:	e8 99 fb ff ff       	call   80105eb0 <argint>
80106317:	85 c0                	test   %eax,%eax
80106319:	78 3d                	js     80106358 <sys_write+0x68>
8010631b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010631e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106325:	89 44 24 08          	mov    %eax,0x8(%esp)
80106329:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010632c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106330:	e8 cb fb ff ff       	call   80105f00 <argptr>
80106335:	85 c0                	test   %eax,%eax
80106337:	78 1f                	js     80106358 <sys_write+0x68>
  return filewrite(f, p, n);
80106339:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010633c:	89 44 24 08          	mov    %eax,0x8(%esp)
80106340:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106343:	89 44 24 04          	mov    %eax,0x4(%esp)
80106347:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010634a:	89 04 24             	mov    %eax,(%esp)
8010634d:	e8 be ac ff ff       	call   80101010 <filewrite>
}
80106352:	c9                   	leave  
80106353:	c3                   	ret    
80106354:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106358:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010635d:	c9                   	leave  
8010635e:	c3                   	ret    
8010635f:	90                   	nop

80106360 <sys_close>:
{
80106360:	55                   	push   %ebp
80106361:	89 e5                	mov    %esp,%ebp
80106363:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, &fd, &f) < 0)
80106366:	8d 55 f4             	lea    -0xc(%ebp),%edx
80106369:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010636c:	e8 4f fe ff ff       	call   801061c0 <argfd.constprop.0>
80106371:	85 c0                	test   %eax,%eax
80106373:	78 23                	js     80106398 <sys_close+0x38>
  myproc()->ofile[fd] = 0;
80106375:	e8 a6 d6 ff ff       	call   80103a20 <myproc>
8010637a:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010637d:	31 c9                	xor    %ecx,%ecx
8010637f:	89 4c 90 28          	mov    %ecx,0x28(%eax,%edx,4)
  fileclose(f);
80106383:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106386:	89 04 24             	mov    %eax,(%esp)
80106389:	e8 a2 aa ff ff       	call   80100e30 <fileclose>
  return 0;
8010638e:	31 c0                	xor    %eax,%eax
}
80106390:	c9                   	leave  
80106391:	c3                   	ret    
80106392:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106398:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010639d:	c9                   	leave  
8010639e:	c3                   	ret    
8010639f:	90                   	nop

801063a0 <sys_fstat>:
{
801063a0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801063a1:	31 c0                	xor    %eax,%eax
{
801063a3:	89 e5                	mov    %esp,%ebp
801063a5:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801063a8:	8d 55 f0             	lea    -0x10(%ebp),%edx
801063ab:	e8 10 fe ff ff       	call   801061c0 <argfd.constprop.0>
801063b0:	85 c0                	test   %eax,%eax
801063b2:	78 3c                	js     801063f0 <sys_fstat+0x50>
801063b4:	b8 14 00 00 00       	mov    $0x14,%eax
801063b9:	89 44 24 08          	mov    %eax,0x8(%esp)
801063bd:	8d 45 f4             	lea    -0xc(%ebp),%eax
801063c0:	89 44 24 04          	mov    %eax,0x4(%esp)
801063c4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801063cb:	e8 30 fb ff ff       	call   80105f00 <argptr>
801063d0:	85 c0                	test   %eax,%eax
801063d2:	78 1c                	js     801063f0 <sys_fstat+0x50>
  return filestat(f, st);
801063d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063d7:	89 44 24 04          	mov    %eax,0x4(%esp)
801063db:	8b 45 f0             	mov    -0x10(%ebp),%eax
801063de:	89 04 24             	mov    %eax,(%esp)
801063e1:	e8 2a ab ff ff       	call   80100f10 <filestat>
}
801063e6:	c9                   	leave  
801063e7:	c3                   	ret    
801063e8:	90                   	nop
801063e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801063f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801063f5:	c9                   	leave  
801063f6:	c3                   	ret    
801063f7:	89 f6                	mov    %esi,%esi
801063f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106400 <sys_link>:
{
80106400:	55                   	push   %ebp
80106401:	89 e5                	mov    %esp,%ebp
80106403:	57                   	push   %edi
80106404:	56                   	push   %esi
80106405:	53                   	push   %ebx
80106406:	83 ec 3c             	sub    $0x3c,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80106409:	8d 45 d4             	lea    -0x2c(%ebp),%eax
8010640c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106410:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106417:	e8 44 fb ff ff       	call   80105f60 <argstr>
8010641c:	85 c0                	test   %eax,%eax
8010641e:	0f 88 e5 00 00 00    	js     80106509 <sys_link+0x109>
80106424:	8d 45 d0             	lea    -0x30(%ebp),%eax
80106427:	89 44 24 04          	mov    %eax,0x4(%esp)
8010642b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106432:	e8 29 fb ff ff       	call   80105f60 <argstr>
80106437:	85 c0                	test   %eax,%eax
80106439:	0f 88 ca 00 00 00    	js     80106509 <sys_link+0x109>
  begin_op();
8010643f:	e8 4c c8 ff ff       	call   80102c90 <begin_op>
  if((ip = namei(old)) == 0){
80106444:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80106447:	89 04 24             	mov    %eax,(%esp)
8010644a:	e8 81 bb ff ff       	call   80101fd0 <namei>
8010644f:	85 c0                	test   %eax,%eax
80106451:	89 c3                	mov    %eax,%ebx
80106453:	0f 84 ab 00 00 00    	je     80106504 <sys_link+0x104>
  ilock(ip);
80106459:	89 04 24             	mov    %eax,(%esp)
8010645c:	e8 8f b2 ff ff       	call   801016f0 <ilock>
  if(ip->type == T_DIR){
80106461:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106466:	0f 84 90 00 00 00    	je     801064fc <sys_link+0xfc>
  ip->nlink++;
8010646c:	66 ff 43 56          	incw   0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80106470:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80106473:	89 1c 24             	mov    %ebx,(%esp)
80106476:	e8 b5 b1 ff ff       	call   80101630 <iupdate>
  iunlock(ip);
8010647b:	89 1c 24             	mov    %ebx,(%esp)
8010647e:	e8 4d b3 ff ff       	call   801017d0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80106483:	8b 45 d0             	mov    -0x30(%ebp),%eax
80106486:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010648a:	89 04 24             	mov    %eax,(%esp)
8010648d:	e8 5e bb ff ff       	call   80101ff0 <nameiparent>
80106492:	85 c0                	test   %eax,%eax
80106494:	89 c6                	mov    %eax,%esi
80106496:	74 50                	je     801064e8 <sys_link+0xe8>
  ilock(dp);
80106498:	89 04 24             	mov    %eax,(%esp)
8010649b:	e8 50 b2 ff ff       	call   801016f0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801064a0:	8b 03                	mov    (%ebx),%eax
801064a2:	39 06                	cmp    %eax,(%esi)
801064a4:	75 3a                	jne    801064e0 <sys_link+0xe0>
801064a6:	8b 43 04             	mov    0x4(%ebx),%eax
801064a9:	89 7c 24 04          	mov    %edi,0x4(%esp)
801064ad:	89 34 24             	mov    %esi,(%esp)
801064b0:	89 44 24 08          	mov    %eax,0x8(%esp)
801064b4:	e8 37 ba ff ff       	call   80101ef0 <dirlink>
801064b9:	85 c0                	test   %eax,%eax
801064bb:	78 23                	js     801064e0 <sys_link+0xe0>
  iunlockput(dp);
801064bd:	89 34 24             	mov    %esi,(%esp)
801064c0:	e8 bb b4 ff ff       	call   80101980 <iunlockput>
  iput(ip);
801064c5:	89 1c 24             	mov    %ebx,(%esp)
801064c8:	e8 53 b3 ff ff       	call   80101820 <iput>
  end_op();
801064cd:	e8 2e c8 ff ff       	call   80102d00 <end_op>
}
801064d2:	83 c4 3c             	add    $0x3c,%esp
  return 0;
801064d5:	31 c0                	xor    %eax,%eax
}
801064d7:	5b                   	pop    %ebx
801064d8:	5e                   	pop    %esi
801064d9:	5f                   	pop    %edi
801064da:	5d                   	pop    %ebp
801064db:	c3                   	ret    
801064dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(dp);
801064e0:	89 34 24             	mov    %esi,(%esp)
801064e3:	e8 98 b4 ff ff       	call   80101980 <iunlockput>
  ilock(ip);
801064e8:	89 1c 24             	mov    %ebx,(%esp)
801064eb:	e8 00 b2 ff ff       	call   801016f0 <ilock>
  ip->nlink--;
801064f0:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
801064f4:	89 1c 24             	mov    %ebx,(%esp)
801064f7:	e8 34 b1 ff ff       	call   80101630 <iupdate>
  iunlockput(ip);
801064fc:	89 1c 24             	mov    %ebx,(%esp)
801064ff:	e8 7c b4 ff ff       	call   80101980 <iunlockput>
  end_op();
80106504:	e8 f7 c7 ff ff       	call   80102d00 <end_op>
}
80106509:	83 c4 3c             	add    $0x3c,%esp
  return -1;
8010650c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106511:	5b                   	pop    %ebx
80106512:	5e                   	pop    %esi
80106513:	5f                   	pop    %edi
80106514:	5d                   	pop    %ebp
80106515:	c3                   	ret    
80106516:	8d 76 00             	lea    0x0(%esi),%esi
80106519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106520 <sys_unlink>:
{
80106520:	55                   	push   %ebp
80106521:	89 e5                	mov    %esp,%ebp
80106523:	57                   	push   %edi
80106524:	56                   	push   %esi
80106525:	53                   	push   %ebx
80106526:	83 ec 5c             	sub    $0x5c,%esp
  if(argstr(0, &path) < 0)
80106529:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010652c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106530:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106537:	e8 24 fa ff ff       	call   80105f60 <argstr>
8010653c:	85 c0                	test   %eax,%eax
8010653e:	0f 88 68 01 00 00    	js     801066ac <sys_unlink+0x18c>
  begin_op();
80106544:	e8 47 c7 ff ff       	call   80102c90 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80106549:	8b 45 c0             	mov    -0x40(%ebp),%eax
8010654c:	8d 5d ca             	lea    -0x36(%ebp),%ebx
8010654f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80106553:	89 04 24             	mov    %eax,(%esp)
80106556:	e8 95 ba ff ff       	call   80101ff0 <nameiparent>
8010655b:	85 c0                	test   %eax,%eax
8010655d:	89 c6                	mov    %eax,%esi
8010655f:	0f 84 42 01 00 00    	je     801066a7 <sys_unlink+0x187>
  ilock(dp);
80106565:	89 04 24             	mov    %eax,(%esp)
80106568:	e8 83 b1 ff ff       	call   801016f0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010656d:	b8 7c 90 10 80       	mov    $0x8010907c,%eax
80106572:	89 44 24 04          	mov    %eax,0x4(%esp)
80106576:	89 1c 24             	mov    %ebx,(%esp)
80106579:	e8 c2 b6 ff ff       	call   80101c40 <namecmp>
8010657e:	85 c0                	test   %eax,%eax
80106580:	0f 84 19 01 00 00    	je     8010669f <sys_unlink+0x17f>
80106586:	b8 7b 90 10 80       	mov    $0x8010907b,%eax
8010658b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010658f:	89 1c 24             	mov    %ebx,(%esp)
80106592:	e8 a9 b6 ff ff       	call   80101c40 <namecmp>
80106597:	85 c0                	test   %eax,%eax
80106599:	0f 84 00 01 00 00    	je     8010669f <sys_unlink+0x17f>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010659f:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801065a2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801065a6:	89 44 24 08          	mov    %eax,0x8(%esp)
801065aa:	89 34 24             	mov    %esi,(%esp)
801065ad:	e8 be b6 ff ff       	call   80101c70 <dirlookup>
801065b2:	85 c0                	test   %eax,%eax
801065b4:	89 c3                	mov    %eax,%ebx
801065b6:	0f 84 e3 00 00 00    	je     8010669f <sys_unlink+0x17f>
  ilock(ip);
801065bc:	89 04 24             	mov    %eax,(%esp)
801065bf:	e8 2c b1 ff ff       	call   801016f0 <ilock>
  if(ip->nlink < 1)
801065c4:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801065c9:	0f 8e 0e 01 00 00    	jle    801066dd <sys_unlink+0x1bd>
  if(ip->type == T_DIR && !isdirempty(ip)){
801065cf:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801065d4:	8d 7d d8             	lea    -0x28(%ebp),%edi
801065d7:	74 77                	je     80106650 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
801065d9:	31 d2                	xor    %edx,%edx
801065db:	b8 10 00 00 00       	mov    $0x10,%eax
801065e0:	89 54 24 04          	mov    %edx,0x4(%esp)
801065e4:	89 44 24 08          	mov    %eax,0x8(%esp)
801065e8:	89 3c 24             	mov    %edi,(%esp)
801065eb:	e8 d0 f5 ff ff       	call   80105bc0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801065f0:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801065f3:	b9 10 00 00 00       	mov    $0x10,%ecx
801065f8:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
801065fc:	89 7c 24 04          	mov    %edi,0x4(%esp)
80106600:	89 34 24             	mov    %esi,(%esp)
80106603:	89 44 24 08          	mov    %eax,0x8(%esp)
80106607:	e8 e4 b4 ff ff       	call   80101af0 <writei>
8010660c:	83 f8 10             	cmp    $0x10,%eax
8010660f:	0f 85 d4 00 00 00    	jne    801066e9 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
80106615:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010661a:	0f 84 a0 00 00 00    	je     801066c0 <sys_unlink+0x1a0>
  iunlockput(dp);
80106620:	89 34 24             	mov    %esi,(%esp)
80106623:	e8 58 b3 ff ff       	call   80101980 <iunlockput>
  ip->nlink--;
80106628:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
8010662c:	89 1c 24             	mov    %ebx,(%esp)
8010662f:	e8 fc af ff ff       	call   80101630 <iupdate>
  iunlockput(ip);
80106634:	89 1c 24             	mov    %ebx,(%esp)
80106637:	e8 44 b3 ff ff       	call   80101980 <iunlockput>
  end_op();
8010663c:	e8 bf c6 ff ff       	call   80102d00 <end_op>
}
80106641:	83 c4 5c             	add    $0x5c,%esp
  return 0;
80106644:	31 c0                	xor    %eax,%eax
}
80106646:	5b                   	pop    %ebx
80106647:	5e                   	pop    %esi
80106648:	5f                   	pop    %edi
80106649:	5d                   	pop    %ebp
8010664a:	c3                   	ret    
8010664b:	90                   	nop
8010664c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80106650:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80106654:	76 83                	jbe    801065d9 <sys_unlink+0xb9>
80106656:	ba 20 00 00 00       	mov    $0x20,%edx
8010665b:	eb 0f                	jmp    8010666c <sys_unlink+0x14c>
8010665d:	8d 76 00             	lea    0x0(%esi),%esi
80106660:	83 c2 10             	add    $0x10,%edx
80106663:	3b 53 58             	cmp    0x58(%ebx),%edx
80106666:	0f 83 6d ff ff ff    	jae    801065d9 <sys_unlink+0xb9>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010666c:	b8 10 00 00 00       	mov    $0x10,%eax
80106671:	89 54 24 08          	mov    %edx,0x8(%esp)
80106675:	89 44 24 0c          	mov    %eax,0xc(%esp)
80106679:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010667d:	89 1c 24             	mov    %ebx,(%esp)
80106680:	89 55 b4             	mov    %edx,-0x4c(%ebp)
80106683:	e8 48 b3 ff ff       	call   801019d0 <readi>
80106688:	8b 55 b4             	mov    -0x4c(%ebp),%edx
8010668b:	83 f8 10             	cmp    $0x10,%eax
8010668e:	75 41                	jne    801066d1 <sys_unlink+0x1b1>
    if(de.inum != 0)
80106690:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80106695:	74 c9                	je     80106660 <sys_unlink+0x140>
    iunlockput(ip);
80106697:	89 1c 24             	mov    %ebx,(%esp)
8010669a:	e8 e1 b2 ff ff       	call   80101980 <iunlockput>
  iunlockput(dp);
8010669f:	89 34 24             	mov    %esi,(%esp)
801066a2:	e8 d9 b2 ff ff       	call   80101980 <iunlockput>
  end_op();
801066a7:	e8 54 c6 ff ff       	call   80102d00 <end_op>
}
801066ac:	83 c4 5c             	add    $0x5c,%esp
  return -1;
801066af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801066b4:	5b                   	pop    %ebx
801066b5:	5e                   	pop    %esi
801066b6:	5f                   	pop    %edi
801066b7:	5d                   	pop    %ebp
801066b8:	c3                   	ret    
801066b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
801066c0:	66 ff 4e 56          	decw   0x56(%esi)
    iupdate(dp);
801066c4:	89 34 24             	mov    %esi,(%esp)
801066c7:	e8 64 af ff ff       	call   80101630 <iupdate>
801066cc:	e9 4f ff ff ff       	jmp    80106620 <sys_unlink+0x100>
      panic("isdirempty: readi");
801066d1:	c7 04 24 a0 90 10 80 	movl   $0x801090a0,(%esp)
801066d8:	e8 93 9c ff ff       	call   80100370 <panic>
    panic("unlink: nlink < 1");
801066dd:	c7 04 24 8e 90 10 80 	movl   $0x8010908e,(%esp)
801066e4:	e8 87 9c ff ff       	call   80100370 <panic>
    panic("unlink: writei");
801066e9:	c7 04 24 b2 90 10 80 	movl   $0x801090b2,(%esp)
801066f0:	e8 7b 9c ff ff       	call   80100370 <panic>
801066f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801066f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106700 <sys_open>:

int
sys_open(void)
{
80106700:	55                   	push   %ebp
80106701:	89 e5                	mov    %esp,%ebp
80106703:	57                   	push   %edi
80106704:	56                   	push   %esi
80106705:	53                   	push   %ebx
80106706:	83 ec 2c             	sub    $0x2c,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106709:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010670c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106710:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106717:	e8 44 f8 ff ff       	call   80105f60 <argstr>
8010671c:	85 c0                	test   %eax,%eax
8010671e:	0f 88 e9 00 00 00    	js     8010680d <sys_open+0x10d>
80106724:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106727:	89 44 24 04          	mov    %eax,0x4(%esp)
8010672b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106732:	e8 79 f7 ff ff       	call   80105eb0 <argint>
80106737:	85 c0                	test   %eax,%eax
80106739:	0f 88 ce 00 00 00    	js     8010680d <sys_open+0x10d>
    return -1;

  begin_op();
8010673f:	e8 4c c5 ff ff       	call   80102c90 <begin_op>

  if(omode & O_CREATE){
80106744:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80106748:	0f 85 9a 00 00 00    	jne    801067e8 <sys_open+0xe8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
8010674e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106751:	89 04 24             	mov    %eax,(%esp)
80106754:	e8 77 b8 ff ff       	call   80101fd0 <namei>
80106759:	85 c0                	test   %eax,%eax
8010675b:	89 c6                	mov    %eax,%esi
8010675d:	0f 84 a5 00 00 00    	je     80106808 <sys_open+0x108>
      end_op();
      return -1;
    }
    ilock(ip);
80106763:	89 04 24             	mov    %eax,(%esp)
80106766:	e8 85 af ff ff       	call   801016f0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
8010676b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80106770:	0f 84 a2 00 00 00    	je     80106818 <sys_open+0x118>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80106776:	e8 f5 a5 ff ff       	call   80100d70 <filealloc>
8010677b:	85 c0                	test   %eax,%eax
8010677d:	89 c7                	mov    %eax,%edi
8010677f:	0f 84 9e 00 00 00    	je     80106823 <sys_open+0x123>
  struct proc *curproc = myproc();
80106785:	e8 96 d2 ff ff       	call   80103a20 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010678a:	31 db                	xor    %ebx,%ebx
8010678c:	eb 0c                	jmp    8010679a <sys_open+0x9a>
8010678e:	66 90                	xchg   %ax,%ax
80106790:	43                   	inc    %ebx
80106791:	83 fb 10             	cmp    $0x10,%ebx
80106794:	0f 84 96 00 00 00    	je     80106830 <sys_open+0x130>
    if(curproc->ofile[fd] == 0){
8010679a:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
8010679e:	85 d2                	test   %edx,%edx
801067a0:	75 ee                	jne    80106790 <sys_open+0x90>
      curproc->ofile[fd] = f;
801067a2:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801067a6:	89 34 24             	mov    %esi,(%esp)
801067a9:	e8 22 b0 ff ff       	call   801017d0 <iunlock>
  end_op();
801067ae:	e8 4d c5 ff ff       	call   80102d00 <end_op>

  f->type = FD_INODE;
801067b3:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801067b9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->ip = ip;
801067bc:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801067bf:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801067c6:	89 d0                	mov    %edx,%eax
801067c8:	f7 d0                	not    %eax
801067ca:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801067cd:	f6 c2 03             	test   $0x3,%dl
  f->readable = !(omode & O_WRONLY);
801067d0:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801067d3:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801067d7:	83 c4 2c             	add    $0x2c,%esp
801067da:	89 d8                	mov    %ebx,%eax
801067dc:	5b                   	pop    %ebx
801067dd:	5e                   	pop    %esi
801067de:	5f                   	pop    %edi
801067df:	5d                   	pop    %ebp
801067e0:	c3                   	ret    
801067e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
801067e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801067eb:	31 c9                	xor    %ecx,%ecx
801067ed:	ba 02 00 00 00       	mov    $0x2,%edx
801067f2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801067f9:	e8 12 f8 ff ff       	call   80106010 <create>
    if(ip == 0){
801067fe:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80106800:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80106802:	0f 85 6e ff ff ff    	jne    80106776 <sys_open+0x76>
    end_op();
80106808:	e8 f3 c4 ff ff       	call   80102d00 <end_op>
    return -1;
8010680d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106812:	eb c3                	jmp    801067d7 <sys_open+0xd7>
80106814:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80106818:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010681b:	85 c9                	test   %ecx,%ecx
8010681d:	0f 84 53 ff ff ff    	je     80106776 <sys_open+0x76>
    iunlockput(ip);
80106823:	89 34 24             	mov    %esi,(%esp)
80106826:	e8 55 b1 ff ff       	call   80101980 <iunlockput>
8010682b:	eb db                	jmp    80106808 <sys_open+0x108>
8010682d:	8d 76 00             	lea    0x0(%esi),%esi
      fileclose(f);
80106830:	89 3c 24             	mov    %edi,(%esp)
80106833:	e8 f8 a5 ff ff       	call   80100e30 <fileclose>
80106838:	eb e9                	jmp    80106823 <sys_open+0x123>
8010683a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106840 <sys_mkdir>:

int
sys_mkdir(void)
{
80106840:	55                   	push   %ebp
80106841:	89 e5                	mov    %esp,%ebp
80106843:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
80106846:	e8 45 c4 ff ff       	call   80102c90 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010684b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010684e:	89 44 24 04          	mov    %eax,0x4(%esp)
80106852:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106859:	e8 02 f7 ff ff       	call   80105f60 <argstr>
8010685e:	85 c0                	test   %eax,%eax
80106860:	78 2e                	js     80106890 <sys_mkdir+0x50>
80106862:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106865:	31 c9                	xor    %ecx,%ecx
80106867:	ba 01 00 00 00       	mov    $0x1,%edx
8010686c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106873:	e8 98 f7 ff ff       	call   80106010 <create>
80106878:	85 c0                	test   %eax,%eax
8010687a:	74 14                	je     80106890 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010687c:	89 04 24             	mov    %eax,(%esp)
8010687f:	e8 fc b0 ff ff       	call   80101980 <iunlockput>
  end_op();
80106884:	e8 77 c4 ff ff       	call   80102d00 <end_op>
  return 0;
80106889:	31 c0                	xor    %eax,%eax
}
8010688b:	c9                   	leave  
8010688c:	c3                   	ret    
8010688d:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
80106890:	e8 6b c4 ff ff       	call   80102d00 <end_op>
    return -1;
80106895:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010689a:	c9                   	leave  
8010689b:	c3                   	ret    
8010689c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801068a0 <sys_mknod>:

int
sys_mknod(void)
{
801068a0:	55                   	push   %ebp
801068a1:	89 e5                	mov    %esp,%ebp
801068a3:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801068a6:	e8 e5 c3 ff ff       	call   80102c90 <begin_op>
  if((argstr(0, &path)) < 0 ||
801068ab:	8d 45 ec             	lea    -0x14(%ebp),%eax
801068ae:	89 44 24 04          	mov    %eax,0x4(%esp)
801068b2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801068b9:	e8 a2 f6 ff ff       	call   80105f60 <argstr>
801068be:	85 c0                	test   %eax,%eax
801068c0:	78 5e                	js     80106920 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801068c2:	8d 45 f0             	lea    -0x10(%ebp),%eax
801068c5:	89 44 24 04          	mov    %eax,0x4(%esp)
801068c9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801068d0:	e8 db f5 ff ff       	call   80105eb0 <argint>
  if((argstr(0, &path)) < 0 ||
801068d5:	85 c0                	test   %eax,%eax
801068d7:	78 47                	js     80106920 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801068d9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801068dc:	89 44 24 04          	mov    %eax,0x4(%esp)
801068e0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801068e7:	e8 c4 f5 ff ff       	call   80105eb0 <argint>
     argint(1, &major) < 0 ||
801068ec:	85 c0                	test   %eax,%eax
801068ee:	78 30                	js     80106920 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801068f0:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
801068f4:	ba 03 00 00 00       	mov    $0x3,%edx
     (ip = create(path, T_DEV, major, minor)) == 0){
801068f9:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801068fd:	89 04 24             	mov    %eax,(%esp)
     argint(2, &minor) < 0 ||
80106900:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106903:	e8 08 f7 ff ff       	call   80106010 <create>
80106908:	85 c0                	test   %eax,%eax
8010690a:	74 14                	je     80106920 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010690c:	89 04 24             	mov    %eax,(%esp)
8010690f:	e8 6c b0 ff ff       	call   80101980 <iunlockput>
  end_op();
80106914:	e8 e7 c3 ff ff       	call   80102d00 <end_op>
  return 0;
80106919:	31 c0                	xor    %eax,%eax
}
8010691b:	c9                   	leave  
8010691c:	c3                   	ret    
8010691d:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
80106920:	e8 db c3 ff ff       	call   80102d00 <end_op>
    return -1;
80106925:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010692a:	c9                   	leave  
8010692b:	c3                   	ret    
8010692c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106930 <sys_chdir>:

int
sys_chdir(void)
{
80106930:	55                   	push   %ebp
80106931:	89 e5                	mov    %esp,%ebp
80106933:	56                   	push   %esi
80106934:	53                   	push   %ebx
80106935:	83 ec 20             	sub    $0x20,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80106938:	e8 e3 d0 ff ff       	call   80103a20 <myproc>
8010693d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010693f:	e8 4c c3 ff ff       	call   80102c90 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106944:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106947:	89 44 24 04          	mov    %eax,0x4(%esp)
8010694b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106952:	e8 09 f6 ff ff       	call   80105f60 <argstr>
80106957:	85 c0                	test   %eax,%eax
80106959:	78 4a                	js     801069a5 <sys_chdir+0x75>
8010695b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010695e:	89 04 24             	mov    %eax,(%esp)
80106961:	e8 6a b6 ff ff       	call   80101fd0 <namei>
80106966:	85 c0                	test   %eax,%eax
80106968:	89 c3                	mov    %eax,%ebx
8010696a:	74 39                	je     801069a5 <sys_chdir+0x75>
    end_op();
    return -1;
  }
  ilock(ip);
8010696c:	89 04 24             	mov    %eax,(%esp)
8010696f:	e8 7c ad ff ff       	call   801016f0 <ilock>
  if(ip->type != T_DIR){
80106974:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
    iunlockput(ip);
80106979:	89 1c 24             	mov    %ebx,(%esp)
  if(ip->type != T_DIR){
8010697c:	75 22                	jne    801069a0 <sys_chdir+0x70>
    end_op();
    return -1;
  }
  iunlock(ip);
8010697e:	e8 4d ae ff ff       	call   801017d0 <iunlock>
  iput(curproc->cwd);
80106983:	8b 46 68             	mov    0x68(%esi),%eax
80106986:	89 04 24             	mov    %eax,(%esp)
80106989:	e8 92 ae ff ff       	call   80101820 <iput>
  end_op();
8010698e:	e8 6d c3 ff ff       	call   80102d00 <end_op>
  curproc->cwd = ip;
  return 0;
80106993:	31 c0                	xor    %eax,%eax
  curproc->cwd = ip;
80106995:	89 5e 68             	mov    %ebx,0x68(%esi)
}
80106998:	83 c4 20             	add    $0x20,%esp
8010699b:	5b                   	pop    %ebx
8010699c:	5e                   	pop    %esi
8010699d:	5d                   	pop    %ebp
8010699e:	c3                   	ret    
8010699f:	90                   	nop
    iunlockput(ip);
801069a0:	e8 db af ff ff       	call   80101980 <iunlockput>
    end_op();
801069a5:	e8 56 c3 ff ff       	call   80102d00 <end_op>
    return -1;
801069aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801069af:	eb e7                	jmp    80106998 <sys_chdir+0x68>
801069b1:	eb 0d                	jmp    801069c0 <sys_exec>
801069b3:	90                   	nop
801069b4:	90                   	nop
801069b5:	90                   	nop
801069b6:	90                   	nop
801069b7:	90                   	nop
801069b8:	90                   	nop
801069b9:	90                   	nop
801069ba:	90                   	nop
801069bb:	90                   	nop
801069bc:	90                   	nop
801069bd:	90                   	nop
801069be:	90                   	nop
801069bf:	90                   	nop

801069c0 <sys_exec>:

int
sys_exec(void)
{
801069c0:	55                   	push   %ebp
801069c1:	89 e5                	mov    %esp,%ebp
801069c3:	57                   	push   %edi
801069c4:	56                   	push   %esi
801069c5:	53                   	push   %ebx
801069c6:	81 ec ac 00 00 00    	sub    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801069cc:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
801069d2:	89 44 24 04          	mov    %eax,0x4(%esp)
801069d6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801069dd:	e8 7e f5 ff ff       	call   80105f60 <argstr>
801069e2:	85 c0                	test   %eax,%eax
801069e4:	0f 88 8e 00 00 00    	js     80106a78 <sys_exec+0xb8>
801069ea:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801069f0:	89 44 24 04          	mov    %eax,0x4(%esp)
801069f4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801069fb:	e8 b0 f4 ff ff       	call   80105eb0 <argint>
80106a00:	85 c0                	test   %eax,%eax
80106a02:	78 74                	js     80106a78 <sys_exec+0xb8>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80106a04:	ba 80 00 00 00       	mov    $0x80,%edx
80106a09:	31 c9                	xor    %ecx,%ecx
80106a0b:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
80106a11:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80106a13:	89 54 24 08          	mov    %edx,0x8(%esp)
80106a17:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80106a1d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80106a21:	89 04 24             	mov    %eax,(%esp)
80106a24:	e8 97 f1 ff ff       	call   80105bc0 <memset>
80106a29:	eb 2e                	jmp    80106a59 <sys_exec+0x99>
80106a2b:	90                   	nop
80106a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80106a30:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80106a36:	85 c0                	test   %eax,%eax
80106a38:	74 56                	je     80106a90 <sys_exec+0xd0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106a3a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80106a40:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80106a43:	89 54 24 04          	mov    %edx,0x4(%esp)
80106a47:	89 04 24             	mov    %eax,(%esp)
80106a4a:	e8 01 f4 ff ff       	call   80105e50 <fetchstr>
80106a4f:	85 c0                	test   %eax,%eax
80106a51:	78 25                	js     80106a78 <sys_exec+0xb8>
  for(i=0;; i++){
80106a53:	43                   	inc    %ebx
    if(i >= NELEM(argv))
80106a54:	83 fb 20             	cmp    $0x20,%ebx
80106a57:	74 1f                	je     80106a78 <sys_exec+0xb8>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106a59:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106a5f:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80106a66:	89 7c 24 04          	mov    %edi,0x4(%esp)
80106a6a:	01 f0                	add    %esi,%eax
80106a6c:	89 04 24             	mov    %eax,(%esp)
80106a6f:	e8 9c f3 ff ff       	call   80105e10 <fetchint>
80106a74:	85 c0                	test   %eax,%eax
80106a76:	79 b8                	jns    80106a30 <sys_exec+0x70>
      return -1;
  }
  return exec(path, argv);
}
80106a78:	81 c4 ac 00 00 00    	add    $0xac,%esp
    return -1;
80106a7e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106a83:	5b                   	pop    %ebx
80106a84:	5e                   	pop    %esi
80106a85:	5f                   	pop    %edi
80106a86:	5d                   	pop    %ebp
80106a87:	c3                   	ret    
80106a88:	90                   	nop
80106a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80106a90:	31 c0                	xor    %eax,%eax
80106a92:	89 84 9d 68 ff ff ff 	mov    %eax,-0x98(%ebp,%ebx,4)
  return exec(path, argv);
80106a99:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106a9f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106aa3:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
80106aa9:	89 04 24             	mov    %eax,(%esp)
80106aac:	e8 1f 9f ff ff       	call   801009d0 <exec>
}
80106ab1:	81 c4 ac 00 00 00    	add    $0xac,%esp
80106ab7:	5b                   	pop    %ebx
80106ab8:	5e                   	pop    %esi
80106ab9:	5f                   	pop    %edi
80106aba:	5d                   	pop    %ebp
80106abb:	c3                   	ret    
80106abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106ac0 <sys_pipe>:

int
sys_pipe(void)
{
80106ac0:	55                   	push   %ebp
80106ac1:	89 e5                	mov    %esp,%ebp
80106ac3:	57                   	push   %edi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106ac4:	bf 08 00 00 00       	mov    $0x8,%edi
{
80106ac9:	56                   	push   %esi
80106aca:	53                   	push   %ebx
80106acb:	83 ec 2c             	sub    $0x2c,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106ace:	8d 45 dc             	lea    -0x24(%ebp),%eax
80106ad1:	89 7c 24 08          	mov    %edi,0x8(%esp)
80106ad5:	89 44 24 04          	mov    %eax,0x4(%esp)
80106ad9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106ae0:	e8 1b f4 ff ff       	call   80105f00 <argptr>
80106ae5:	85 c0                	test   %eax,%eax
80106ae7:	0f 88 a9 00 00 00    	js     80106b96 <sys_pipe+0xd6>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80106aed:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106af0:	89 44 24 04          	mov    %eax,0x4(%esp)
80106af4:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106af7:	89 04 24             	mov    %eax,(%esp)
80106afa:	e8 c1 c8 ff ff       	call   801033c0 <pipealloc>
80106aff:	85 c0                	test   %eax,%eax
80106b01:	0f 88 8f 00 00 00    	js     80106b96 <sys_pipe+0xd6>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106b07:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80106b0a:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80106b0c:	e8 0f cf ff ff       	call   80103a20 <myproc>
80106b11:	eb 0b                	jmp    80106b1e <sys_pipe+0x5e>
80106b13:	90                   	nop
80106b14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106b18:	43                   	inc    %ebx
80106b19:	83 fb 10             	cmp    $0x10,%ebx
80106b1c:	74 62                	je     80106b80 <sys_pipe+0xc0>
    if(curproc->ofile[fd] == 0){
80106b1e:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80106b22:	85 f6                	test   %esi,%esi
80106b24:	75 f2                	jne    80106b18 <sys_pipe+0x58>
      curproc->ofile[fd] = f;
80106b26:	8d 73 08             	lea    0x8(%ebx),%esi
80106b29:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106b2d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80106b30:	e8 eb ce ff ff       	call   80103a20 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106b35:	31 d2                	xor    %edx,%edx
80106b37:	eb 0d                	jmp    80106b46 <sys_pipe+0x86>
80106b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b40:	42                   	inc    %edx
80106b41:	83 fa 10             	cmp    $0x10,%edx
80106b44:	74 2a                	je     80106b70 <sys_pipe+0xb0>
    if(curproc->ofile[fd] == 0){
80106b46:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80106b4a:	85 c9                	test   %ecx,%ecx
80106b4c:	75 f2                	jne    80106b40 <sys_pipe+0x80>
      curproc->ofile[fd] = f;
80106b4e:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80106b52:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106b55:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106b57:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106b5a:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80106b5d:	31 c0                	xor    %eax,%eax
}
80106b5f:	83 c4 2c             	add    $0x2c,%esp
80106b62:	5b                   	pop    %ebx
80106b63:	5e                   	pop    %esi
80106b64:	5f                   	pop    %edi
80106b65:	5d                   	pop    %ebp
80106b66:	c3                   	ret    
80106b67:	89 f6                	mov    %esi,%esi
80106b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      myproc()->ofile[fd0] = 0;
80106b70:	e8 ab ce ff ff       	call   80103a20 <myproc>
80106b75:	31 d2                	xor    %edx,%edx
80106b77:	89 54 b0 08          	mov    %edx,0x8(%eax,%esi,4)
80106b7b:	90                   	nop
80106b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fileclose(rf);
80106b80:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106b83:	89 04 24             	mov    %eax,(%esp)
80106b86:	e8 a5 a2 ff ff       	call   80100e30 <fileclose>
    fileclose(wf);
80106b8b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106b8e:	89 04 24             	mov    %eax,(%esp)
80106b91:	e8 9a a2 ff ff       	call   80100e30 <fileclose>
    return -1;
80106b96:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106b9b:	eb c2                	jmp    80106b5f <sys_pipe+0x9f>
80106b9d:	66 90                	xchg   %ax,%ax
80106b9f:	90                   	nop

80106ba0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106ba0:	55                   	push   %ebp
80106ba1:	89 e5                	mov    %esp,%ebp
  return fork();
}
80106ba3:	5d                   	pop    %ebp
  return fork();
80106ba4:	e9 37 d1 ff ff       	jmp    80103ce0 <fork>
80106ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106bb0 <sys_exit>:

int
sys_exit(void)
{
80106bb0:	55                   	push   %ebp
80106bb1:	89 e5                	mov    %esp,%ebp
80106bb3:	83 ec 28             	sub    $0x28,%esp
    int stat;

    if(argint(0, &stat) < 0)
80106bb6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106bb9:	89 44 24 04          	mov    %eax,0x4(%esp)
80106bbd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106bc4:	e8 e7 f2 ff ff       	call   80105eb0 <argint>
80106bc9:	85 c0                	test   %eax,%eax
80106bcb:	78 13                	js     80106be0 <sys_exit+0x30>
        return -1;
    exit(stat);
80106bcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106bd0:	89 04 24             	mov    %eax,(%esp)
80106bd3:	e8 b8 d5 ff ff       	call   80104190 <exit>
    return 0;
80106bd8:	31 c0                	xor    %eax,%eax
}
80106bda:	c9                   	leave  
80106bdb:	c3                   	ret    
80106bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
80106be0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106be5:	c9                   	leave  
80106be6:	c3                   	ret    
80106be7:	89 f6                	mov    %esi,%esi
80106be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106bf0 <sys_wait>:

int
sys_wait(void)
{
80106bf0:	55                   	push   %ebp
    int status = 4;

    if(argptr(0, (char **)status , 1) < 0)
80106bf1:	b8 01 00 00 00       	mov    $0x1,%eax
{
80106bf6:	89 e5                	mov    %esp,%ebp
    if(argptr(0, (char **)status , 1) < 0)
80106bf8:	ba 04 00 00 00       	mov    $0x4,%edx
{
80106bfd:	83 ec 28             	sub    $0x28,%esp
    if(argptr(0, (char **)status , 1) < 0)
80106c00:	89 44 24 08          	mov    %eax,0x8(%esp)
80106c04:	89 54 24 04          	mov    %edx,0x4(%esp)
80106c08:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    int status = 4;
80106c0f:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
    if(argptr(0, (char **)status , 1) < 0)
80106c16:	e8 e5 f2 ff ff       	call   80105f00 <argptr>
80106c1b:	85 c0                	test   %eax,%eax
80106c1d:	78 11                	js     80106c30 <sys_wait+0x40>
        return -1;
    return wait(&status);
80106c1f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106c22:	89 04 24             	mov    %eax,(%esp)
80106c25:	e8 56 d8 ff ff       	call   80104480 <wait>
}
80106c2a:	c9                   	leave  
80106c2b:	c3                   	ret    
80106c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
80106c30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106c35:	c9                   	leave  
80106c36:	c3                   	ret    
80106c37:	89 f6                	mov    %esi,%esi
80106c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c40 <sys_kill>:

int
sys_kill(void)
{
80106c40:	55                   	push   %ebp
80106c41:	89 e5                	mov    %esp,%ebp
80106c43:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106c46:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106c49:	89 44 24 04          	mov    %eax,0x4(%esp)
80106c4d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106c54:	e8 57 f2 ff ff       	call   80105eb0 <argint>
80106c59:	85 c0                	test   %eax,%eax
80106c5b:	78 13                	js     80106c70 <sys_kill+0x30>
    return -1;
  return kill(pid);
80106c5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106c60:	89 04 24             	mov    %eax,(%esp)
80106c63:	e8 58 d9 ff ff       	call   801045c0 <kill>
}
80106c68:	c9                   	leave  
80106c69:	c3                   	ret    
80106c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106c70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106c75:	c9                   	leave  
80106c76:	c3                   	ret    
80106c77:	89 f6                	mov    %esi,%esi
80106c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c80 <sys_getpid>:

int
sys_getpid(void)
{
80106c80:	55                   	push   %ebp
80106c81:	89 e5                	mov    %esp,%ebp
80106c83:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106c86:	e8 95 cd ff ff       	call   80103a20 <myproc>
80106c8b:	8b 40 10             	mov    0x10(%eax),%eax
}
80106c8e:	c9                   	leave  
80106c8f:	c3                   	ret    

80106c90 <sys_sbrk>:

int
sys_sbrk(void)
{
80106c90:	55                   	push   %ebp
80106c91:	89 e5                	mov    %esp,%ebp
80106c93:	53                   	push   %ebx
80106c94:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106c97:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106c9a:	89 44 24 04          	mov    %eax,0x4(%esp)
80106c9e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106ca5:	e8 06 f2 ff ff       	call   80105eb0 <argint>
80106caa:	85 c0                	test   %eax,%eax
80106cac:	78 22                	js     80106cd0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106cae:	e8 6d cd ff ff       	call   80103a20 <myproc>
80106cb3:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106cb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106cb8:	89 04 24             	mov    %eax,(%esp)
80106cbb:	e8 a0 cf ff ff       	call   80103c60 <growproc>
80106cc0:	85 c0                	test   %eax,%eax
80106cc2:	78 0c                	js     80106cd0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106cc4:	83 c4 24             	add    $0x24,%esp
80106cc7:	89 d8                	mov    %ebx,%eax
80106cc9:	5b                   	pop    %ebx
80106cca:	5d                   	pop    %ebp
80106ccb:	c3                   	ret    
80106ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106cd0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106cd5:	eb ed                	jmp    80106cc4 <sys_sbrk+0x34>
80106cd7:	89 f6                	mov    %esi,%esi
80106cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ce0 <sys_sleep>:

int
sys_sleep(void)
{
80106ce0:	55                   	push   %ebp
80106ce1:	89 e5                	mov    %esp,%ebp
80106ce3:	53                   	push   %ebx
80106ce4:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106ce7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106cea:	89 44 24 04          	mov    %eax,0x4(%esp)
80106cee:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106cf5:	e8 b6 f1 ff ff       	call   80105eb0 <argint>
80106cfa:	85 c0                	test   %eax,%eax
80106cfc:	78 7e                	js     80106d7c <sys_sleep+0x9c>
    return -1;
  acquire(&tickslock);
80106cfe:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80106d05:	e8 c6 ed ff ff       	call   80105ad0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106d0a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  ticks0 = ticks;
80106d0d:	8b 1d 00 80 11 80    	mov    0x80118000,%ebx
  while(ticks - ticks0 < n){
80106d13:	85 c9                	test   %ecx,%ecx
80106d15:	75 2a                	jne    80106d41 <sys_sleep+0x61>
80106d17:	eb 4f                	jmp    80106d68 <sys_sleep+0x88>
80106d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106d20:	b8 c0 77 11 80       	mov    $0x801177c0,%eax
80106d25:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d29:	c7 04 24 00 80 11 80 	movl   $0x80118000,(%esp)
80106d30:	e8 5b d6 ff ff       	call   80104390 <sleep>
  while(ticks - ticks0 < n){
80106d35:	a1 00 80 11 80       	mov    0x80118000,%eax
80106d3a:	29 d8                	sub    %ebx,%eax
80106d3c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80106d3f:	73 27                	jae    80106d68 <sys_sleep+0x88>
    if(myproc()->killed){
80106d41:	e8 da cc ff ff       	call   80103a20 <myproc>
80106d46:	8b 50 24             	mov    0x24(%eax),%edx
80106d49:	85 d2                	test   %edx,%edx
80106d4b:	74 d3                	je     80106d20 <sys_sleep+0x40>
      release(&tickslock);
80106d4d:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80106d54:	e8 17 ee ff ff       	call   80105b70 <release>
  }
  release(&tickslock);
  return 0;
}
80106d59:	83 c4 24             	add    $0x24,%esp
      return -1;
80106d5c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106d61:	5b                   	pop    %ebx
80106d62:	5d                   	pop    %ebp
80106d63:	c3                   	ret    
80106d64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&tickslock);
80106d68:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80106d6f:	e8 fc ed ff ff       	call   80105b70 <release>
  return 0;
80106d74:	31 c0                	xor    %eax,%eax
}
80106d76:	83 c4 24             	add    $0x24,%esp
80106d79:	5b                   	pop    %ebx
80106d7a:	5d                   	pop    %ebp
80106d7b:	c3                   	ret    
    return -1;
80106d7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106d81:	eb f3                	jmp    80106d76 <sys_sleep+0x96>
80106d83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d90 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106d90:	55                   	push   %ebp
80106d91:	89 e5                	mov    %esp,%ebp
80106d93:	53                   	push   %ebx
80106d94:	83 ec 14             	sub    $0x14,%esp
  uint xticks;

  acquire(&tickslock);
80106d97:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80106d9e:	e8 2d ed ff ff       	call   80105ad0 <acquire>
  xticks = ticks;
80106da3:	8b 1d 00 80 11 80    	mov    0x80118000,%ebx
  release(&tickslock);
80106da9:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80106db0:	e8 bb ed ff ff       	call   80105b70 <release>
  return xticks;
}
80106db5:	83 c4 14             	add    $0x14,%esp
80106db8:	89 d8                	mov    %ebx,%eax
80106dba:	5b                   	pop    %ebx
80106dbb:	5d                   	pop    %ebp
80106dbc:	c3                   	ret    
80106dbd:	8d 76 00             	lea    0x0(%esi),%esi

80106dc0 <sys_detach>:

int
sys_detach(void){
80106dc0:	55                   	push   %ebp
80106dc1:	89 e5                	mov    %esp,%ebp
80106dc3:	83 ec 28             	sub    $0x28,%esp
    int pid;
  if(argint(0, &pid) < 0)
80106dc6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106dc9:	89 44 24 04          	mov    %eax,0x4(%esp)
80106dcd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106dd4:	e8 d7 f0 ff ff       	call   80105eb0 <argint>
80106dd9:	85 c0                	test   %eax,%eax
80106ddb:	78 13                	js     80106df0 <sys_detach+0x30>
    return -1;
  return detach(pid);
80106ddd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106de0:	89 04 24             	mov    %eax,(%esp)
80106de3:	e8 68 d9 ff ff       	call   80104750 <detach>
}
80106de8:	c9                   	leave  
80106de9:	c3                   	ret    
80106dea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106df0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106df5:	c9                   	leave  
80106df6:	c3                   	ret    
80106df7:	89 f6                	mov    %esi,%esi
80106df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e00 <sys_priority>:
//TODO -need to understand how to call this sys_call
int
sys_priority(void){
80106e00:	55                   	push   %ebp
80106e01:	89 e5                	mov    %esp,%ebp
80106e03:	83 ec 28             	sub    $0x28,%esp
  int pid;
  if(argint(0, &pid) < 0)
80106e06:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106e09:	89 44 24 04          	mov    %eax,0x4(%esp)
80106e0d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106e14:	e8 97 f0 ff ff       	call   80105eb0 <argint>
80106e19:	85 c0                	test   %eax,%eax
80106e1b:	78 13                	js     80106e30 <sys_priority+0x30>
    return -1;
  priority(pid);
80106e1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e20:	89 04 24             	mov    %eax,(%esp)
80106e23:	e8 a8 d9 ff ff       	call   801047d0 <priority>
  return 0;
80106e28:	31 c0                	xor    %eax,%eax
}
80106e2a:	c9                   	leave  
80106e2b:	c3                   	ret    
80106e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106e30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106e35:	c9                   	leave  
80106e36:	c3                   	ret    
80106e37:	89 f6                	mov    %esi,%esi
80106e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e40 <sys_policy>:

int
sys_policy(void){
80106e40:	55                   	push   %ebp
80106e41:	89 e5                	mov    %esp,%ebp
80106e43:	83 ec 28             	sub    $0x28,%esp
    int pid;
    if(argint(0, &pid) < 0)
80106e46:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106e49:	89 44 24 04          	mov    %eax,0x4(%esp)
80106e4d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106e54:	e8 57 f0 ff ff       	call   80105eb0 <argint>
80106e59:	85 c0                	test   %eax,%eax
80106e5b:	78 13                	js     80106e70 <sys_policy+0x30>
        return -1;
    policy(pid);
80106e5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e60:	89 04 24             	mov    %eax,(%esp)
80106e63:	e8 68 da ff ff       	call   801048d0 <policy>
    return 0;
80106e68:	31 c0                	xor    %eax,%eax
}
80106e6a:	c9                   	leave  
80106e6b:	c3                   	ret    
80106e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
80106e70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106e75:	c9                   	leave  
80106e76:	c3                   	ret    
80106e77:	89 f6                	mov    %esi,%esi
80106e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e80 <sys_wait_stat>:


int
sys_wait_stat(void)
{
80106e80:	55                   	push   %ebp
  //TODO - add perf struct to the args of the function
  return 0;
}
80106e81:	31 c0                	xor    %eax,%eax
{
80106e83:	89 e5                	mov    %esp,%ebp
}
80106e85:	5d                   	pop    %ebp
80106e86:	c3                   	ret    

80106e87 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106e87:	1e                   	push   %ds
  pushl %es
80106e88:	06                   	push   %es
  pushl %fs
80106e89:	0f a0                	push   %fs
  pushl %gs
80106e8b:	0f a8                	push   %gs
  pushal
80106e8d:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106e8e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106e92:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106e94:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106e96:	54                   	push   %esp
  call trap
80106e97:	e8 c4 00 00 00       	call   80106f60 <trap>
  addl $4, %esp
80106e9c:	83 c4 04             	add    $0x4,%esp

80106e9f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106e9f:	61                   	popa   
  popl %gs
80106ea0:	0f a9                	pop    %gs
  popl %fs
80106ea2:	0f a1                	pop    %fs
  popl %es
80106ea4:	07                   	pop    %es
  popl %ds
80106ea5:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106ea6:	83 c4 08             	add    $0x8,%esp
  iret
80106ea9:	cf                   	iret   
80106eaa:	66 90                	xchg   %ax,%ax
80106eac:	66 90                	xchg   %ax,%ax
80106eae:	66 90                	xchg   %ax,%ax

80106eb0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106eb0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106eb1:	31 c0                	xor    %eax,%eax
{
80106eb3:	89 e5                	mov    %esp,%ebp
80106eb5:	83 ec 18             	sub    $0x18,%esp
80106eb8:	90                   	nop
80106eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106ec0:	8b 14 85 0c c0 10 80 	mov    -0x7fef3ff4(,%eax,4),%edx
80106ec7:	b9 08 00 00 8e       	mov    $0x8e000008,%ecx
80106ecc:	89 0c c5 02 78 11 80 	mov    %ecx,-0x7fee87fe(,%eax,8)
80106ed3:	66 89 14 c5 00 78 11 	mov    %dx,-0x7fee8800(,%eax,8)
80106eda:	80 
80106edb:	c1 ea 10             	shr    $0x10,%edx
80106ede:	66 89 14 c5 06 78 11 	mov    %dx,-0x7fee87fa(,%eax,8)
80106ee5:	80 
  for(i = 0; i < 256; i++)
80106ee6:	40                   	inc    %eax
80106ee7:	3d 00 01 00 00       	cmp    $0x100,%eax
80106eec:	75 d2                	jne    80106ec0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106eee:	a1 0c c1 10 80       	mov    0x8010c10c,%eax

  initlock(&tickslock, "time");
80106ef3:	b9 c1 90 10 80       	mov    $0x801090c1,%ecx
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106ef8:	ba 08 00 00 ef       	mov    $0xef000008,%edx
  initlock(&tickslock, "time");
80106efd:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80106f01:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106f08:	89 15 02 7a 11 80    	mov    %edx,0x80117a02
80106f0e:	66 a3 00 7a 11 80    	mov    %ax,0x80117a00
80106f14:	c1 e8 10             	shr    $0x10,%eax
80106f17:	66 a3 06 7a 11 80    	mov    %ax,0x80117a06
  initlock(&tickslock, "time");
80106f1d:	e8 5e ea ff ff       	call   80105980 <initlock>
}
80106f22:	c9                   	leave  
80106f23:	c3                   	ret    
80106f24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106f2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106f30 <idtinit>:

void
idtinit(void)
{
80106f30:	55                   	push   %ebp
  pd[1] = (uint)p;
80106f31:	b8 00 78 11 80       	mov    $0x80117800,%eax
80106f36:	89 e5                	mov    %esp,%ebp
80106f38:	0f b7 d0             	movzwl %ax,%edx
  pd[2] = (uint)p >> 16;
80106f3b:	c1 e8 10             	shr    $0x10,%eax
80106f3e:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
80106f41:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
80106f47:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106f4b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80106f4f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106f52:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106f55:	c9                   	leave  
80106f56:	c3                   	ret    
80106f57:	89 f6                	mov    %esi,%esi
80106f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f60 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106f60:	55                   	push   %ebp
80106f61:	89 e5                	mov    %esp,%ebp
80106f63:	83 ec 48             	sub    $0x48,%esp
80106f66:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80106f69:	8b 5d 08             	mov    0x8(%ebp),%ebx
80106f6c:	89 75 f8             	mov    %esi,-0x8(%ebp)
80106f6f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(tf->trapno == T_SYSCALL){
80106f72:	8b 43 30             	mov    0x30(%ebx),%eax
80106f75:	83 f8 40             	cmp    $0x40,%eax
80106f78:	0f 84 02 01 00 00    	je     80107080 <trap+0x120>
    if(myproc()->killed)
      exit(0);
    return;
  }

  switch(tf->trapno){
80106f7e:	83 e8 20             	sub    $0x20,%eax
80106f81:	83 f8 1f             	cmp    $0x1f,%eax
80106f84:	77 0a                	ja     80106f90 <trap+0x30>
80106f86:	ff 24 85 68 91 10 80 	jmp    *-0x7fef6e98(,%eax,4)
80106f8d:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80106f90:	e8 8b ca ff ff       	call   80103a20 <myproc>
80106f95:	8b 7b 38             	mov    0x38(%ebx),%edi
80106f98:	85 c0                	test   %eax,%eax
80106f9a:	0f 84 5f 02 00 00    	je     801071ff <trap+0x29f>
80106fa0:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106fa4:	0f 84 55 02 00 00    	je     801071ff <trap+0x29f>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106faa:	0f 20 d1             	mov    %cr2,%ecx
80106fad:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106fb0:	e8 4b ca ff ff       	call   80103a00 <cpuid>
80106fb5:	8b 73 30             	mov    0x30(%ebx),%esi
80106fb8:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106fbb:	8b 43 34             	mov    0x34(%ebx),%eax
80106fbe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106fc1:	e8 5a ca ff ff       	call   80103a20 <myproc>
80106fc6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106fc9:	e8 52 ca ff ff       	call   80103a20 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106fce:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106fd1:	89 74 24 0c          	mov    %esi,0xc(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
80106fd5:	8b 75 e0             	mov    -0x20(%ebp),%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106fd8:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106fdb:	89 7c 24 18          	mov    %edi,0x18(%esp)
80106fdf:	89 54 24 14          	mov    %edx,0x14(%esp)
80106fe3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
            myproc()->pid, myproc()->name, tf->trapno,
80106fe6:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106fe9:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
80106fed:	89 74 24 08          	mov    %esi,0x8(%esp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106ff1:	89 54 24 10          	mov    %edx,0x10(%esp)
80106ff5:	8b 40 10             	mov    0x10(%eax),%eax
80106ff8:	c7 04 24 24 91 10 80 	movl   $0x80109124,(%esp)
80106fff:	89 44 24 04          	mov    %eax,0x4(%esp)
80107003:	e8 48 96 ff ff       	call   80100650 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80107008:	e8 13 ca ff ff       	call   80103a20 <myproc>
8010700d:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107014:	e8 07 ca ff ff       	call   80103a20 <myproc>
80107019:	85 c0                	test   %eax,%eax
8010701b:	74 1b                	je     80107038 <trap+0xd8>
8010701d:	e8 fe c9 ff ff       	call   80103a20 <myproc>
80107022:	8b 50 24             	mov    0x24(%eax),%edx
80107025:	85 d2                	test   %edx,%edx
80107027:	74 0f                	je     80107038 <trap+0xd8>
80107029:	8b 43 3c             	mov    0x3c(%ebx),%eax
8010702c:	83 e0 03             	and    $0x3,%eax
8010702f:	83 f8 03             	cmp    $0x3,%eax
80107032:	0f 84 80 01 00 00    	je     801071b8 <trap+0x258>
    exit(0);

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80107038:	e8 e3 c9 ff ff       	call   80103a20 <myproc>
8010703d:	85 c0                	test   %eax,%eax
8010703f:	74 0d                	je     8010704e <trap+0xee>
80107041:	e8 da c9 ff ff       	call   80103a20 <myproc>
80107046:	8b 40 0c             	mov    0xc(%eax),%eax
80107049:	83 f8 04             	cmp    $0x4,%eax
8010704c:	74 7a                	je     801070c8 <trap+0x168>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010704e:	e8 cd c9 ff ff       	call   80103a20 <myproc>
80107053:	85 c0                	test   %eax,%eax
80107055:	74 17                	je     8010706e <trap+0x10e>
80107057:	e8 c4 c9 ff ff       	call   80103a20 <myproc>
8010705c:	8b 40 24             	mov    0x24(%eax),%eax
8010705f:	85 c0                	test   %eax,%eax
80107061:	74 0b                	je     8010706e <trap+0x10e>
80107063:	8b 43 3c             	mov    0x3c(%ebx),%eax
80107066:	83 e0 03             	and    $0x3,%eax
80107069:	83 f8 03             	cmp    $0x3,%eax
8010706c:	74 3b                	je     801070a9 <trap+0x149>
    exit(0);
}
8010706e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107071:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107074:	8b 7d fc             	mov    -0x4(%ebp),%edi
80107077:	89 ec                	mov    %ebp,%esp
80107079:	5d                   	pop    %ebp
8010707a:	c3                   	ret    
8010707b:	90                   	nop
8010707c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80107080:	e8 9b c9 ff ff       	call   80103a20 <myproc>
80107085:	8b 70 24             	mov    0x24(%eax),%esi
80107088:	85 f6                	test   %esi,%esi
8010708a:	0f 85 10 01 00 00    	jne    801071a0 <trap+0x240>
    myproc()->tf = tf;
80107090:	e8 8b c9 ff ff       	call   80103a20 <myproc>
80107095:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80107098:	e8 03 ef ff ff       	call   80105fa0 <syscall>
    if(myproc()->killed)
8010709d:	e8 7e c9 ff ff       	call   80103a20 <myproc>
801070a2:	8b 48 24             	mov    0x24(%eax),%ecx
801070a5:	85 c9                	test   %ecx,%ecx
801070a7:	74 c5                	je     8010706e <trap+0x10e>
      exit(0);
801070a9:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
}
801070b0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801070b3:	8b 75 f8             	mov    -0x8(%ebp),%esi
801070b6:	8b 7d fc             	mov    -0x4(%ebp),%edi
801070b9:	89 ec                	mov    %ebp,%esp
801070bb:	5d                   	pop    %ebp
      exit(0);
801070bc:	e9 cf d0 ff ff       	jmp    80104190 <exit>
801070c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(myproc() && myproc()->state == RUNNING &&
801070c8:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
801070cc:	75 80                	jne    8010704e <trap+0xee>
    yield();
801070ce:	e8 cd d1 ff ff       	call   801042a0 <yield>
801070d3:	e9 76 ff ff ff       	jmp    8010704e <trap+0xee>
801070d8:	90                   	nop
801070d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
801070e0:	e8 1b c9 ff ff       	call   80103a00 <cpuid>
801070e5:	85 c0                	test   %eax,%eax
801070e7:	0f 84 e3 00 00 00    	je     801071d0 <trap+0x270>
801070ed:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
801070f0:	e8 5b b7 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801070f5:	e8 26 c9 ff ff       	call   80103a20 <myproc>
801070fa:	85 c0                	test   %eax,%eax
801070fc:	0f 85 1b ff ff ff    	jne    8010701d <trap+0xbd>
80107102:	e9 31 ff ff ff       	jmp    80107038 <trap+0xd8>
80107107:	89 f6                	mov    %esi,%esi
80107109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    kbdintr();
80107110:	e8 fb b5 ff ff       	call   80102710 <kbdintr>
    lapiceoi();
80107115:	e8 36 b7 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010711a:	e8 01 c9 ff ff       	call   80103a20 <myproc>
8010711f:	85 c0                	test   %eax,%eax
80107121:	0f 85 f6 fe ff ff    	jne    8010701d <trap+0xbd>
80107127:	e9 0c ff ff ff       	jmp    80107038 <trap+0xd8>
8010712c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80107130:	e8 6b 02 00 00       	call   801073a0 <uartintr>
    lapiceoi();
80107135:	e8 16 b7 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010713a:	e8 e1 c8 ff ff       	call   80103a20 <myproc>
8010713f:	85 c0                	test   %eax,%eax
80107141:	0f 85 d6 fe ff ff    	jne    8010701d <trap+0xbd>
80107147:	e9 ec fe ff ff       	jmp    80107038 <trap+0xd8>
8010714c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80107150:	8b 7b 38             	mov    0x38(%ebx),%edi
80107153:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80107157:	e8 a4 c8 ff ff       	call   80103a00 <cpuid>
8010715c:	c7 04 24 cc 90 10 80 	movl   $0x801090cc,(%esp)
80107163:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80107167:	89 74 24 08          	mov    %esi,0x8(%esp)
8010716b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010716f:	e8 dc 94 ff ff       	call   80100650 <cprintf>
    lapiceoi();
80107174:	e8 d7 b6 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107179:	e8 a2 c8 ff ff       	call   80103a20 <myproc>
8010717e:	85 c0                	test   %eax,%eax
80107180:	0f 85 97 fe ff ff    	jne    8010701d <trap+0xbd>
80107186:	e9 ad fe ff ff       	jmp    80107038 <trap+0xd8>
8010718b:	90                   	nop
8010718c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80107190:	e8 cb af ff ff       	call   80102160 <ideintr>
80107195:	e9 53 ff ff ff       	jmp    801070ed <trap+0x18d>
8010719a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit(0);
801071a0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801071a7:	e8 e4 cf ff ff       	call   80104190 <exit>
801071ac:	e9 df fe ff ff       	jmp    80107090 <trap+0x130>
801071b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit(0);
801071b8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801071bf:	e8 cc cf ff ff       	call   80104190 <exit>
801071c4:	e9 6f fe ff ff       	jmp    80107038 <trap+0xd8>
801071c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      acquire(&tickslock);
801071d0:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
801071d7:	e8 f4 e8 ff ff       	call   80105ad0 <acquire>
      wakeup(&ticks);
801071dc:	c7 04 24 00 80 11 80 	movl   $0x80118000,(%esp)
      ticks++;
801071e3:	ff 05 00 80 11 80    	incl   0x80118000
      wakeup(&ticks);
801071e9:	e8 a2 d3 ff ff       	call   80104590 <wakeup>
      release(&tickslock);
801071ee:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
801071f5:	e8 76 e9 ff ff       	call   80105b70 <release>
801071fa:	e9 ee fe ff ff       	jmp    801070ed <trap+0x18d>
801071ff:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80107202:	e8 f9 c7 ff ff       	call   80103a00 <cpuid>
80107207:	89 74 24 10          	mov    %esi,0x10(%esp)
8010720b:	89 7c 24 0c          	mov    %edi,0xc(%esp)
8010720f:	89 44 24 08          	mov    %eax,0x8(%esp)
80107213:	8b 43 30             	mov    0x30(%ebx),%eax
80107216:	c7 04 24 f0 90 10 80 	movl   $0x801090f0,(%esp)
8010721d:	89 44 24 04          	mov    %eax,0x4(%esp)
80107221:	e8 2a 94 ff ff       	call   80100650 <cprintf>
      panic("trap");
80107226:	c7 04 24 c6 90 10 80 	movl   $0x801090c6,(%esp)
8010722d:	e8 3e 91 ff ff       	call   80100370 <panic>
80107232:	66 90                	xchg   %ax,%ax
80107234:	66 90                	xchg   %ax,%ax
80107236:	66 90                	xchg   %ax,%ax
80107238:	66 90                	xchg   %ax,%ax
8010723a:	66 90                	xchg   %ax,%ax
8010723c:	66 90                	xchg   %ax,%ax
8010723e:	66 90                	xchg   %ax,%ax

80107240 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80107240:	a1 18 c6 10 80       	mov    0x8010c618,%eax
{
80107245:	55                   	push   %ebp
80107246:	89 e5                	mov    %esp,%ebp
  if(!uart)
80107248:	85 c0                	test   %eax,%eax
8010724a:	74 1c                	je     80107268 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010724c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80107251:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80107252:	24 01                	and    $0x1,%al
80107254:	84 c0                	test   %al,%al
80107256:	74 10                	je     80107268 <uartgetc+0x28>
80107258:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010725d:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010725e:	0f b6 c0             	movzbl %al,%eax
}
80107261:	5d                   	pop    %ebp
80107262:	c3                   	ret    
80107263:	90                   	nop
80107264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80107268:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010726d:	5d                   	pop    %ebp
8010726e:	c3                   	ret    
8010726f:	90                   	nop

80107270 <uartputc.part.0>:
uartputc(int c)
80107270:	55                   	push   %ebp
80107271:	89 e5                	mov    %esp,%ebp
80107273:	56                   	push   %esi
80107274:	be fd 03 00 00       	mov    $0x3fd,%esi
80107279:	53                   	push   %ebx
8010727a:	bb 80 00 00 00       	mov    $0x80,%ebx
8010727f:	83 ec 20             	sub    $0x20,%esp
80107282:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107285:	eb 18                	jmp    8010729f <uartputc.part.0+0x2f>
80107287:	89 f6                	mov    %esi,%esi
80107289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80107290:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80107297:	e8 d4 b5 ff ff       	call   80102870 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010729c:	4b                   	dec    %ebx
8010729d:	74 09                	je     801072a8 <uartputc.part.0+0x38>
8010729f:	89 f2                	mov    %esi,%edx
801072a1:	ec                   	in     (%dx),%al
801072a2:	24 20                	and    $0x20,%al
801072a4:	84 c0                	test   %al,%al
801072a6:	74 e8                	je     80107290 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801072a8:	ba f8 03 00 00       	mov    $0x3f8,%edx
801072ad:	0f b6 45 f4          	movzbl -0xc(%ebp),%eax
801072b1:	ee                   	out    %al,(%dx)
}
801072b2:	83 c4 20             	add    $0x20,%esp
801072b5:	5b                   	pop    %ebx
801072b6:	5e                   	pop    %esi
801072b7:	5d                   	pop    %ebp
801072b8:	c3                   	ret    
801072b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801072c0 <uartinit>:
{
801072c0:	55                   	push   %ebp
801072c1:	31 c9                	xor    %ecx,%ecx
801072c3:	89 e5                	mov    %esp,%ebp
801072c5:	88 c8                	mov    %cl,%al
801072c7:	57                   	push   %edi
801072c8:	56                   	push   %esi
801072c9:	53                   	push   %ebx
801072ca:	bb fa 03 00 00       	mov    $0x3fa,%ebx
801072cf:	83 ec 1c             	sub    $0x1c,%esp
801072d2:	89 da                	mov    %ebx,%edx
801072d4:	ee                   	out    %al,(%dx)
801072d5:	bf fb 03 00 00       	mov    $0x3fb,%edi
801072da:	b0 80                	mov    $0x80,%al
801072dc:	89 fa                	mov    %edi,%edx
801072de:	ee                   	out    %al,(%dx)
801072df:	b0 0c                	mov    $0xc,%al
801072e1:	ba f8 03 00 00       	mov    $0x3f8,%edx
801072e6:	ee                   	out    %al,(%dx)
801072e7:	be f9 03 00 00       	mov    $0x3f9,%esi
801072ec:	88 c8                	mov    %cl,%al
801072ee:	89 f2                	mov    %esi,%edx
801072f0:	ee                   	out    %al,(%dx)
801072f1:	b0 03                	mov    $0x3,%al
801072f3:	89 fa                	mov    %edi,%edx
801072f5:	ee                   	out    %al,(%dx)
801072f6:	ba fc 03 00 00       	mov    $0x3fc,%edx
801072fb:	88 c8                	mov    %cl,%al
801072fd:	ee                   	out    %al,(%dx)
801072fe:	b0 01                	mov    $0x1,%al
80107300:	89 f2                	mov    %esi,%edx
80107302:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80107303:	ba fd 03 00 00       	mov    $0x3fd,%edx
80107308:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80107309:	fe c0                	inc    %al
8010730b:	74 52                	je     8010735f <uartinit+0x9f>
  uart = 1;
8010730d:	b9 01 00 00 00       	mov    $0x1,%ecx
80107312:	89 da                	mov    %ebx,%edx
80107314:	89 0d 18 c6 10 80    	mov    %ecx,0x8010c618
8010731a:	ec                   	in     (%dx),%al
8010731b:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107320:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80107321:	31 db                	xor    %ebx,%ebx
80107323:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  for(p="xv6...\n"; *p; p++)
80107327:	bb e8 91 10 80       	mov    $0x801091e8,%ebx
  ioapicenable(IRQ_COM1, 0);
8010732c:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80107333:	e8 68 b0 ff ff       	call   801023a0 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
80107338:	b8 78 00 00 00       	mov    $0x78,%eax
8010733d:	eb 09                	jmp    80107348 <uartinit+0x88>
8010733f:	90                   	nop
80107340:	43                   	inc    %ebx
80107341:	0f be 03             	movsbl (%ebx),%eax
80107344:	84 c0                	test   %al,%al
80107346:	74 17                	je     8010735f <uartinit+0x9f>
  if(!uart)
80107348:	8b 15 18 c6 10 80    	mov    0x8010c618,%edx
8010734e:	85 d2                	test   %edx,%edx
80107350:	74 ee                	je     80107340 <uartinit+0x80>
  for(p="xv6...\n"; *p; p++)
80107352:	43                   	inc    %ebx
80107353:	e8 18 ff ff ff       	call   80107270 <uartputc.part.0>
80107358:	0f be 03             	movsbl (%ebx),%eax
8010735b:	84 c0                	test   %al,%al
8010735d:	75 e9                	jne    80107348 <uartinit+0x88>
}
8010735f:	83 c4 1c             	add    $0x1c,%esp
80107362:	5b                   	pop    %ebx
80107363:	5e                   	pop    %esi
80107364:	5f                   	pop    %edi
80107365:	5d                   	pop    %ebp
80107366:	c3                   	ret    
80107367:	89 f6                	mov    %esi,%esi
80107369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107370 <uartputc>:
  if(!uart)
80107370:	8b 15 18 c6 10 80    	mov    0x8010c618,%edx
{
80107376:	55                   	push   %ebp
80107377:	89 e5                	mov    %esp,%ebp
80107379:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
8010737c:	85 d2                	test   %edx,%edx
8010737e:	74 10                	je     80107390 <uartputc+0x20>
}
80107380:	5d                   	pop    %ebp
80107381:	e9 ea fe ff ff       	jmp    80107270 <uartputc.part.0>
80107386:	8d 76 00             	lea    0x0(%esi),%esi
80107389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107390:	5d                   	pop    %ebp
80107391:	c3                   	ret    
80107392:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801073a0 <uartintr>:

void
uartintr(void)
{
801073a0:	55                   	push   %ebp
801073a1:	89 e5                	mov    %esp,%ebp
801073a3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
801073a6:	c7 04 24 40 72 10 80 	movl   $0x80107240,(%esp)
801073ad:	e8 1e 94 ff ff       	call   801007d0 <consoleintr>
}
801073b2:	c9                   	leave  
801073b3:	c3                   	ret    

801073b4 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801073b4:	6a 00                	push   $0x0
  pushl $0
801073b6:	6a 00                	push   $0x0
  jmp alltraps
801073b8:	e9 ca fa ff ff       	jmp    80106e87 <alltraps>

801073bd <vector1>:
.globl vector1
vector1:
  pushl $0
801073bd:	6a 00                	push   $0x0
  pushl $1
801073bf:	6a 01                	push   $0x1
  jmp alltraps
801073c1:	e9 c1 fa ff ff       	jmp    80106e87 <alltraps>

801073c6 <vector2>:
.globl vector2
vector2:
  pushl $0
801073c6:	6a 00                	push   $0x0
  pushl $2
801073c8:	6a 02                	push   $0x2
  jmp alltraps
801073ca:	e9 b8 fa ff ff       	jmp    80106e87 <alltraps>

801073cf <vector3>:
.globl vector3
vector3:
  pushl $0
801073cf:	6a 00                	push   $0x0
  pushl $3
801073d1:	6a 03                	push   $0x3
  jmp alltraps
801073d3:	e9 af fa ff ff       	jmp    80106e87 <alltraps>

801073d8 <vector4>:
.globl vector4
vector4:
  pushl $0
801073d8:	6a 00                	push   $0x0
  pushl $4
801073da:	6a 04                	push   $0x4
  jmp alltraps
801073dc:	e9 a6 fa ff ff       	jmp    80106e87 <alltraps>

801073e1 <vector5>:
.globl vector5
vector5:
  pushl $0
801073e1:	6a 00                	push   $0x0
  pushl $5
801073e3:	6a 05                	push   $0x5
  jmp alltraps
801073e5:	e9 9d fa ff ff       	jmp    80106e87 <alltraps>

801073ea <vector6>:
.globl vector6
vector6:
  pushl $0
801073ea:	6a 00                	push   $0x0
  pushl $6
801073ec:	6a 06                	push   $0x6
  jmp alltraps
801073ee:	e9 94 fa ff ff       	jmp    80106e87 <alltraps>

801073f3 <vector7>:
.globl vector7
vector7:
  pushl $0
801073f3:	6a 00                	push   $0x0
  pushl $7
801073f5:	6a 07                	push   $0x7
  jmp alltraps
801073f7:	e9 8b fa ff ff       	jmp    80106e87 <alltraps>

801073fc <vector8>:
.globl vector8
vector8:
  pushl $8
801073fc:	6a 08                	push   $0x8
  jmp alltraps
801073fe:	e9 84 fa ff ff       	jmp    80106e87 <alltraps>

80107403 <vector9>:
.globl vector9
vector9:
  pushl $0
80107403:	6a 00                	push   $0x0
  pushl $9
80107405:	6a 09                	push   $0x9
  jmp alltraps
80107407:	e9 7b fa ff ff       	jmp    80106e87 <alltraps>

8010740c <vector10>:
.globl vector10
vector10:
  pushl $10
8010740c:	6a 0a                	push   $0xa
  jmp alltraps
8010740e:	e9 74 fa ff ff       	jmp    80106e87 <alltraps>

80107413 <vector11>:
.globl vector11
vector11:
  pushl $11
80107413:	6a 0b                	push   $0xb
  jmp alltraps
80107415:	e9 6d fa ff ff       	jmp    80106e87 <alltraps>

8010741a <vector12>:
.globl vector12
vector12:
  pushl $12
8010741a:	6a 0c                	push   $0xc
  jmp alltraps
8010741c:	e9 66 fa ff ff       	jmp    80106e87 <alltraps>

80107421 <vector13>:
.globl vector13
vector13:
  pushl $13
80107421:	6a 0d                	push   $0xd
  jmp alltraps
80107423:	e9 5f fa ff ff       	jmp    80106e87 <alltraps>

80107428 <vector14>:
.globl vector14
vector14:
  pushl $14
80107428:	6a 0e                	push   $0xe
  jmp alltraps
8010742a:	e9 58 fa ff ff       	jmp    80106e87 <alltraps>

8010742f <vector15>:
.globl vector15
vector15:
  pushl $0
8010742f:	6a 00                	push   $0x0
  pushl $15
80107431:	6a 0f                	push   $0xf
  jmp alltraps
80107433:	e9 4f fa ff ff       	jmp    80106e87 <alltraps>

80107438 <vector16>:
.globl vector16
vector16:
  pushl $0
80107438:	6a 00                	push   $0x0
  pushl $16
8010743a:	6a 10                	push   $0x10
  jmp alltraps
8010743c:	e9 46 fa ff ff       	jmp    80106e87 <alltraps>

80107441 <vector17>:
.globl vector17
vector17:
  pushl $17
80107441:	6a 11                	push   $0x11
  jmp alltraps
80107443:	e9 3f fa ff ff       	jmp    80106e87 <alltraps>

80107448 <vector18>:
.globl vector18
vector18:
  pushl $0
80107448:	6a 00                	push   $0x0
  pushl $18
8010744a:	6a 12                	push   $0x12
  jmp alltraps
8010744c:	e9 36 fa ff ff       	jmp    80106e87 <alltraps>

80107451 <vector19>:
.globl vector19
vector19:
  pushl $0
80107451:	6a 00                	push   $0x0
  pushl $19
80107453:	6a 13                	push   $0x13
  jmp alltraps
80107455:	e9 2d fa ff ff       	jmp    80106e87 <alltraps>

8010745a <vector20>:
.globl vector20
vector20:
  pushl $0
8010745a:	6a 00                	push   $0x0
  pushl $20
8010745c:	6a 14                	push   $0x14
  jmp alltraps
8010745e:	e9 24 fa ff ff       	jmp    80106e87 <alltraps>

80107463 <vector21>:
.globl vector21
vector21:
  pushl $0
80107463:	6a 00                	push   $0x0
  pushl $21
80107465:	6a 15                	push   $0x15
  jmp alltraps
80107467:	e9 1b fa ff ff       	jmp    80106e87 <alltraps>

8010746c <vector22>:
.globl vector22
vector22:
  pushl $0
8010746c:	6a 00                	push   $0x0
  pushl $22
8010746e:	6a 16                	push   $0x16
  jmp alltraps
80107470:	e9 12 fa ff ff       	jmp    80106e87 <alltraps>

80107475 <vector23>:
.globl vector23
vector23:
  pushl $0
80107475:	6a 00                	push   $0x0
  pushl $23
80107477:	6a 17                	push   $0x17
  jmp alltraps
80107479:	e9 09 fa ff ff       	jmp    80106e87 <alltraps>

8010747e <vector24>:
.globl vector24
vector24:
  pushl $0
8010747e:	6a 00                	push   $0x0
  pushl $24
80107480:	6a 18                	push   $0x18
  jmp alltraps
80107482:	e9 00 fa ff ff       	jmp    80106e87 <alltraps>

80107487 <vector25>:
.globl vector25
vector25:
  pushl $0
80107487:	6a 00                	push   $0x0
  pushl $25
80107489:	6a 19                	push   $0x19
  jmp alltraps
8010748b:	e9 f7 f9 ff ff       	jmp    80106e87 <alltraps>

80107490 <vector26>:
.globl vector26
vector26:
  pushl $0
80107490:	6a 00                	push   $0x0
  pushl $26
80107492:	6a 1a                	push   $0x1a
  jmp alltraps
80107494:	e9 ee f9 ff ff       	jmp    80106e87 <alltraps>

80107499 <vector27>:
.globl vector27
vector27:
  pushl $0
80107499:	6a 00                	push   $0x0
  pushl $27
8010749b:	6a 1b                	push   $0x1b
  jmp alltraps
8010749d:	e9 e5 f9 ff ff       	jmp    80106e87 <alltraps>

801074a2 <vector28>:
.globl vector28
vector28:
  pushl $0
801074a2:	6a 00                	push   $0x0
  pushl $28
801074a4:	6a 1c                	push   $0x1c
  jmp alltraps
801074a6:	e9 dc f9 ff ff       	jmp    80106e87 <alltraps>

801074ab <vector29>:
.globl vector29
vector29:
  pushl $0
801074ab:	6a 00                	push   $0x0
  pushl $29
801074ad:	6a 1d                	push   $0x1d
  jmp alltraps
801074af:	e9 d3 f9 ff ff       	jmp    80106e87 <alltraps>

801074b4 <vector30>:
.globl vector30
vector30:
  pushl $0
801074b4:	6a 00                	push   $0x0
  pushl $30
801074b6:	6a 1e                	push   $0x1e
  jmp alltraps
801074b8:	e9 ca f9 ff ff       	jmp    80106e87 <alltraps>

801074bd <vector31>:
.globl vector31
vector31:
  pushl $0
801074bd:	6a 00                	push   $0x0
  pushl $31
801074bf:	6a 1f                	push   $0x1f
  jmp alltraps
801074c1:	e9 c1 f9 ff ff       	jmp    80106e87 <alltraps>

801074c6 <vector32>:
.globl vector32
vector32:
  pushl $0
801074c6:	6a 00                	push   $0x0
  pushl $32
801074c8:	6a 20                	push   $0x20
  jmp alltraps
801074ca:	e9 b8 f9 ff ff       	jmp    80106e87 <alltraps>

801074cf <vector33>:
.globl vector33
vector33:
  pushl $0
801074cf:	6a 00                	push   $0x0
  pushl $33
801074d1:	6a 21                	push   $0x21
  jmp alltraps
801074d3:	e9 af f9 ff ff       	jmp    80106e87 <alltraps>

801074d8 <vector34>:
.globl vector34
vector34:
  pushl $0
801074d8:	6a 00                	push   $0x0
  pushl $34
801074da:	6a 22                	push   $0x22
  jmp alltraps
801074dc:	e9 a6 f9 ff ff       	jmp    80106e87 <alltraps>

801074e1 <vector35>:
.globl vector35
vector35:
  pushl $0
801074e1:	6a 00                	push   $0x0
  pushl $35
801074e3:	6a 23                	push   $0x23
  jmp alltraps
801074e5:	e9 9d f9 ff ff       	jmp    80106e87 <alltraps>

801074ea <vector36>:
.globl vector36
vector36:
  pushl $0
801074ea:	6a 00                	push   $0x0
  pushl $36
801074ec:	6a 24                	push   $0x24
  jmp alltraps
801074ee:	e9 94 f9 ff ff       	jmp    80106e87 <alltraps>

801074f3 <vector37>:
.globl vector37
vector37:
  pushl $0
801074f3:	6a 00                	push   $0x0
  pushl $37
801074f5:	6a 25                	push   $0x25
  jmp alltraps
801074f7:	e9 8b f9 ff ff       	jmp    80106e87 <alltraps>

801074fc <vector38>:
.globl vector38
vector38:
  pushl $0
801074fc:	6a 00                	push   $0x0
  pushl $38
801074fe:	6a 26                	push   $0x26
  jmp alltraps
80107500:	e9 82 f9 ff ff       	jmp    80106e87 <alltraps>

80107505 <vector39>:
.globl vector39
vector39:
  pushl $0
80107505:	6a 00                	push   $0x0
  pushl $39
80107507:	6a 27                	push   $0x27
  jmp alltraps
80107509:	e9 79 f9 ff ff       	jmp    80106e87 <alltraps>

8010750e <vector40>:
.globl vector40
vector40:
  pushl $0
8010750e:	6a 00                	push   $0x0
  pushl $40
80107510:	6a 28                	push   $0x28
  jmp alltraps
80107512:	e9 70 f9 ff ff       	jmp    80106e87 <alltraps>

80107517 <vector41>:
.globl vector41
vector41:
  pushl $0
80107517:	6a 00                	push   $0x0
  pushl $41
80107519:	6a 29                	push   $0x29
  jmp alltraps
8010751b:	e9 67 f9 ff ff       	jmp    80106e87 <alltraps>

80107520 <vector42>:
.globl vector42
vector42:
  pushl $0
80107520:	6a 00                	push   $0x0
  pushl $42
80107522:	6a 2a                	push   $0x2a
  jmp alltraps
80107524:	e9 5e f9 ff ff       	jmp    80106e87 <alltraps>

80107529 <vector43>:
.globl vector43
vector43:
  pushl $0
80107529:	6a 00                	push   $0x0
  pushl $43
8010752b:	6a 2b                	push   $0x2b
  jmp alltraps
8010752d:	e9 55 f9 ff ff       	jmp    80106e87 <alltraps>

80107532 <vector44>:
.globl vector44
vector44:
  pushl $0
80107532:	6a 00                	push   $0x0
  pushl $44
80107534:	6a 2c                	push   $0x2c
  jmp alltraps
80107536:	e9 4c f9 ff ff       	jmp    80106e87 <alltraps>

8010753b <vector45>:
.globl vector45
vector45:
  pushl $0
8010753b:	6a 00                	push   $0x0
  pushl $45
8010753d:	6a 2d                	push   $0x2d
  jmp alltraps
8010753f:	e9 43 f9 ff ff       	jmp    80106e87 <alltraps>

80107544 <vector46>:
.globl vector46
vector46:
  pushl $0
80107544:	6a 00                	push   $0x0
  pushl $46
80107546:	6a 2e                	push   $0x2e
  jmp alltraps
80107548:	e9 3a f9 ff ff       	jmp    80106e87 <alltraps>

8010754d <vector47>:
.globl vector47
vector47:
  pushl $0
8010754d:	6a 00                	push   $0x0
  pushl $47
8010754f:	6a 2f                	push   $0x2f
  jmp alltraps
80107551:	e9 31 f9 ff ff       	jmp    80106e87 <alltraps>

80107556 <vector48>:
.globl vector48
vector48:
  pushl $0
80107556:	6a 00                	push   $0x0
  pushl $48
80107558:	6a 30                	push   $0x30
  jmp alltraps
8010755a:	e9 28 f9 ff ff       	jmp    80106e87 <alltraps>

8010755f <vector49>:
.globl vector49
vector49:
  pushl $0
8010755f:	6a 00                	push   $0x0
  pushl $49
80107561:	6a 31                	push   $0x31
  jmp alltraps
80107563:	e9 1f f9 ff ff       	jmp    80106e87 <alltraps>

80107568 <vector50>:
.globl vector50
vector50:
  pushl $0
80107568:	6a 00                	push   $0x0
  pushl $50
8010756a:	6a 32                	push   $0x32
  jmp alltraps
8010756c:	e9 16 f9 ff ff       	jmp    80106e87 <alltraps>

80107571 <vector51>:
.globl vector51
vector51:
  pushl $0
80107571:	6a 00                	push   $0x0
  pushl $51
80107573:	6a 33                	push   $0x33
  jmp alltraps
80107575:	e9 0d f9 ff ff       	jmp    80106e87 <alltraps>

8010757a <vector52>:
.globl vector52
vector52:
  pushl $0
8010757a:	6a 00                	push   $0x0
  pushl $52
8010757c:	6a 34                	push   $0x34
  jmp alltraps
8010757e:	e9 04 f9 ff ff       	jmp    80106e87 <alltraps>

80107583 <vector53>:
.globl vector53
vector53:
  pushl $0
80107583:	6a 00                	push   $0x0
  pushl $53
80107585:	6a 35                	push   $0x35
  jmp alltraps
80107587:	e9 fb f8 ff ff       	jmp    80106e87 <alltraps>

8010758c <vector54>:
.globl vector54
vector54:
  pushl $0
8010758c:	6a 00                	push   $0x0
  pushl $54
8010758e:	6a 36                	push   $0x36
  jmp alltraps
80107590:	e9 f2 f8 ff ff       	jmp    80106e87 <alltraps>

80107595 <vector55>:
.globl vector55
vector55:
  pushl $0
80107595:	6a 00                	push   $0x0
  pushl $55
80107597:	6a 37                	push   $0x37
  jmp alltraps
80107599:	e9 e9 f8 ff ff       	jmp    80106e87 <alltraps>

8010759e <vector56>:
.globl vector56
vector56:
  pushl $0
8010759e:	6a 00                	push   $0x0
  pushl $56
801075a0:	6a 38                	push   $0x38
  jmp alltraps
801075a2:	e9 e0 f8 ff ff       	jmp    80106e87 <alltraps>

801075a7 <vector57>:
.globl vector57
vector57:
  pushl $0
801075a7:	6a 00                	push   $0x0
  pushl $57
801075a9:	6a 39                	push   $0x39
  jmp alltraps
801075ab:	e9 d7 f8 ff ff       	jmp    80106e87 <alltraps>

801075b0 <vector58>:
.globl vector58
vector58:
  pushl $0
801075b0:	6a 00                	push   $0x0
  pushl $58
801075b2:	6a 3a                	push   $0x3a
  jmp alltraps
801075b4:	e9 ce f8 ff ff       	jmp    80106e87 <alltraps>

801075b9 <vector59>:
.globl vector59
vector59:
  pushl $0
801075b9:	6a 00                	push   $0x0
  pushl $59
801075bb:	6a 3b                	push   $0x3b
  jmp alltraps
801075bd:	e9 c5 f8 ff ff       	jmp    80106e87 <alltraps>

801075c2 <vector60>:
.globl vector60
vector60:
  pushl $0
801075c2:	6a 00                	push   $0x0
  pushl $60
801075c4:	6a 3c                	push   $0x3c
  jmp alltraps
801075c6:	e9 bc f8 ff ff       	jmp    80106e87 <alltraps>

801075cb <vector61>:
.globl vector61
vector61:
  pushl $0
801075cb:	6a 00                	push   $0x0
  pushl $61
801075cd:	6a 3d                	push   $0x3d
  jmp alltraps
801075cf:	e9 b3 f8 ff ff       	jmp    80106e87 <alltraps>

801075d4 <vector62>:
.globl vector62
vector62:
  pushl $0
801075d4:	6a 00                	push   $0x0
  pushl $62
801075d6:	6a 3e                	push   $0x3e
  jmp alltraps
801075d8:	e9 aa f8 ff ff       	jmp    80106e87 <alltraps>

801075dd <vector63>:
.globl vector63
vector63:
  pushl $0
801075dd:	6a 00                	push   $0x0
  pushl $63
801075df:	6a 3f                	push   $0x3f
  jmp alltraps
801075e1:	e9 a1 f8 ff ff       	jmp    80106e87 <alltraps>

801075e6 <vector64>:
.globl vector64
vector64:
  pushl $0
801075e6:	6a 00                	push   $0x0
  pushl $64
801075e8:	6a 40                	push   $0x40
  jmp alltraps
801075ea:	e9 98 f8 ff ff       	jmp    80106e87 <alltraps>

801075ef <vector65>:
.globl vector65
vector65:
  pushl $0
801075ef:	6a 00                	push   $0x0
  pushl $65
801075f1:	6a 41                	push   $0x41
  jmp alltraps
801075f3:	e9 8f f8 ff ff       	jmp    80106e87 <alltraps>

801075f8 <vector66>:
.globl vector66
vector66:
  pushl $0
801075f8:	6a 00                	push   $0x0
  pushl $66
801075fa:	6a 42                	push   $0x42
  jmp alltraps
801075fc:	e9 86 f8 ff ff       	jmp    80106e87 <alltraps>

80107601 <vector67>:
.globl vector67
vector67:
  pushl $0
80107601:	6a 00                	push   $0x0
  pushl $67
80107603:	6a 43                	push   $0x43
  jmp alltraps
80107605:	e9 7d f8 ff ff       	jmp    80106e87 <alltraps>

8010760a <vector68>:
.globl vector68
vector68:
  pushl $0
8010760a:	6a 00                	push   $0x0
  pushl $68
8010760c:	6a 44                	push   $0x44
  jmp alltraps
8010760e:	e9 74 f8 ff ff       	jmp    80106e87 <alltraps>

80107613 <vector69>:
.globl vector69
vector69:
  pushl $0
80107613:	6a 00                	push   $0x0
  pushl $69
80107615:	6a 45                	push   $0x45
  jmp alltraps
80107617:	e9 6b f8 ff ff       	jmp    80106e87 <alltraps>

8010761c <vector70>:
.globl vector70
vector70:
  pushl $0
8010761c:	6a 00                	push   $0x0
  pushl $70
8010761e:	6a 46                	push   $0x46
  jmp alltraps
80107620:	e9 62 f8 ff ff       	jmp    80106e87 <alltraps>

80107625 <vector71>:
.globl vector71
vector71:
  pushl $0
80107625:	6a 00                	push   $0x0
  pushl $71
80107627:	6a 47                	push   $0x47
  jmp alltraps
80107629:	e9 59 f8 ff ff       	jmp    80106e87 <alltraps>

8010762e <vector72>:
.globl vector72
vector72:
  pushl $0
8010762e:	6a 00                	push   $0x0
  pushl $72
80107630:	6a 48                	push   $0x48
  jmp alltraps
80107632:	e9 50 f8 ff ff       	jmp    80106e87 <alltraps>

80107637 <vector73>:
.globl vector73
vector73:
  pushl $0
80107637:	6a 00                	push   $0x0
  pushl $73
80107639:	6a 49                	push   $0x49
  jmp alltraps
8010763b:	e9 47 f8 ff ff       	jmp    80106e87 <alltraps>

80107640 <vector74>:
.globl vector74
vector74:
  pushl $0
80107640:	6a 00                	push   $0x0
  pushl $74
80107642:	6a 4a                	push   $0x4a
  jmp alltraps
80107644:	e9 3e f8 ff ff       	jmp    80106e87 <alltraps>

80107649 <vector75>:
.globl vector75
vector75:
  pushl $0
80107649:	6a 00                	push   $0x0
  pushl $75
8010764b:	6a 4b                	push   $0x4b
  jmp alltraps
8010764d:	e9 35 f8 ff ff       	jmp    80106e87 <alltraps>

80107652 <vector76>:
.globl vector76
vector76:
  pushl $0
80107652:	6a 00                	push   $0x0
  pushl $76
80107654:	6a 4c                	push   $0x4c
  jmp alltraps
80107656:	e9 2c f8 ff ff       	jmp    80106e87 <alltraps>

8010765b <vector77>:
.globl vector77
vector77:
  pushl $0
8010765b:	6a 00                	push   $0x0
  pushl $77
8010765d:	6a 4d                	push   $0x4d
  jmp alltraps
8010765f:	e9 23 f8 ff ff       	jmp    80106e87 <alltraps>

80107664 <vector78>:
.globl vector78
vector78:
  pushl $0
80107664:	6a 00                	push   $0x0
  pushl $78
80107666:	6a 4e                	push   $0x4e
  jmp alltraps
80107668:	e9 1a f8 ff ff       	jmp    80106e87 <alltraps>

8010766d <vector79>:
.globl vector79
vector79:
  pushl $0
8010766d:	6a 00                	push   $0x0
  pushl $79
8010766f:	6a 4f                	push   $0x4f
  jmp alltraps
80107671:	e9 11 f8 ff ff       	jmp    80106e87 <alltraps>

80107676 <vector80>:
.globl vector80
vector80:
  pushl $0
80107676:	6a 00                	push   $0x0
  pushl $80
80107678:	6a 50                	push   $0x50
  jmp alltraps
8010767a:	e9 08 f8 ff ff       	jmp    80106e87 <alltraps>

8010767f <vector81>:
.globl vector81
vector81:
  pushl $0
8010767f:	6a 00                	push   $0x0
  pushl $81
80107681:	6a 51                	push   $0x51
  jmp alltraps
80107683:	e9 ff f7 ff ff       	jmp    80106e87 <alltraps>

80107688 <vector82>:
.globl vector82
vector82:
  pushl $0
80107688:	6a 00                	push   $0x0
  pushl $82
8010768a:	6a 52                	push   $0x52
  jmp alltraps
8010768c:	e9 f6 f7 ff ff       	jmp    80106e87 <alltraps>

80107691 <vector83>:
.globl vector83
vector83:
  pushl $0
80107691:	6a 00                	push   $0x0
  pushl $83
80107693:	6a 53                	push   $0x53
  jmp alltraps
80107695:	e9 ed f7 ff ff       	jmp    80106e87 <alltraps>

8010769a <vector84>:
.globl vector84
vector84:
  pushl $0
8010769a:	6a 00                	push   $0x0
  pushl $84
8010769c:	6a 54                	push   $0x54
  jmp alltraps
8010769e:	e9 e4 f7 ff ff       	jmp    80106e87 <alltraps>

801076a3 <vector85>:
.globl vector85
vector85:
  pushl $0
801076a3:	6a 00                	push   $0x0
  pushl $85
801076a5:	6a 55                	push   $0x55
  jmp alltraps
801076a7:	e9 db f7 ff ff       	jmp    80106e87 <alltraps>

801076ac <vector86>:
.globl vector86
vector86:
  pushl $0
801076ac:	6a 00                	push   $0x0
  pushl $86
801076ae:	6a 56                	push   $0x56
  jmp alltraps
801076b0:	e9 d2 f7 ff ff       	jmp    80106e87 <alltraps>

801076b5 <vector87>:
.globl vector87
vector87:
  pushl $0
801076b5:	6a 00                	push   $0x0
  pushl $87
801076b7:	6a 57                	push   $0x57
  jmp alltraps
801076b9:	e9 c9 f7 ff ff       	jmp    80106e87 <alltraps>

801076be <vector88>:
.globl vector88
vector88:
  pushl $0
801076be:	6a 00                	push   $0x0
  pushl $88
801076c0:	6a 58                	push   $0x58
  jmp alltraps
801076c2:	e9 c0 f7 ff ff       	jmp    80106e87 <alltraps>

801076c7 <vector89>:
.globl vector89
vector89:
  pushl $0
801076c7:	6a 00                	push   $0x0
  pushl $89
801076c9:	6a 59                	push   $0x59
  jmp alltraps
801076cb:	e9 b7 f7 ff ff       	jmp    80106e87 <alltraps>

801076d0 <vector90>:
.globl vector90
vector90:
  pushl $0
801076d0:	6a 00                	push   $0x0
  pushl $90
801076d2:	6a 5a                	push   $0x5a
  jmp alltraps
801076d4:	e9 ae f7 ff ff       	jmp    80106e87 <alltraps>

801076d9 <vector91>:
.globl vector91
vector91:
  pushl $0
801076d9:	6a 00                	push   $0x0
  pushl $91
801076db:	6a 5b                	push   $0x5b
  jmp alltraps
801076dd:	e9 a5 f7 ff ff       	jmp    80106e87 <alltraps>

801076e2 <vector92>:
.globl vector92
vector92:
  pushl $0
801076e2:	6a 00                	push   $0x0
  pushl $92
801076e4:	6a 5c                	push   $0x5c
  jmp alltraps
801076e6:	e9 9c f7 ff ff       	jmp    80106e87 <alltraps>

801076eb <vector93>:
.globl vector93
vector93:
  pushl $0
801076eb:	6a 00                	push   $0x0
  pushl $93
801076ed:	6a 5d                	push   $0x5d
  jmp alltraps
801076ef:	e9 93 f7 ff ff       	jmp    80106e87 <alltraps>

801076f4 <vector94>:
.globl vector94
vector94:
  pushl $0
801076f4:	6a 00                	push   $0x0
  pushl $94
801076f6:	6a 5e                	push   $0x5e
  jmp alltraps
801076f8:	e9 8a f7 ff ff       	jmp    80106e87 <alltraps>

801076fd <vector95>:
.globl vector95
vector95:
  pushl $0
801076fd:	6a 00                	push   $0x0
  pushl $95
801076ff:	6a 5f                	push   $0x5f
  jmp alltraps
80107701:	e9 81 f7 ff ff       	jmp    80106e87 <alltraps>

80107706 <vector96>:
.globl vector96
vector96:
  pushl $0
80107706:	6a 00                	push   $0x0
  pushl $96
80107708:	6a 60                	push   $0x60
  jmp alltraps
8010770a:	e9 78 f7 ff ff       	jmp    80106e87 <alltraps>

8010770f <vector97>:
.globl vector97
vector97:
  pushl $0
8010770f:	6a 00                	push   $0x0
  pushl $97
80107711:	6a 61                	push   $0x61
  jmp alltraps
80107713:	e9 6f f7 ff ff       	jmp    80106e87 <alltraps>

80107718 <vector98>:
.globl vector98
vector98:
  pushl $0
80107718:	6a 00                	push   $0x0
  pushl $98
8010771a:	6a 62                	push   $0x62
  jmp alltraps
8010771c:	e9 66 f7 ff ff       	jmp    80106e87 <alltraps>

80107721 <vector99>:
.globl vector99
vector99:
  pushl $0
80107721:	6a 00                	push   $0x0
  pushl $99
80107723:	6a 63                	push   $0x63
  jmp alltraps
80107725:	e9 5d f7 ff ff       	jmp    80106e87 <alltraps>

8010772a <vector100>:
.globl vector100
vector100:
  pushl $0
8010772a:	6a 00                	push   $0x0
  pushl $100
8010772c:	6a 64                	push   $0x64
  jmp alltraps
8010772e:	e9 54 f7 ff ff       	jmp    80106e87 <alltraps>

80107733 <vector101>:
.globl vector101
vector101:
  pushl $0
80107733:	6a 00                	push   $0x0
  pushl $101
80107735:	6a 65                	push   $0x65
  jmp alltraps
80107737:	e9 4b f7 ff ff       	jmp    80106e87 <alltraps>

8010773c <vector102>:
.globl vector102
vector102:
  pushl $0
8010773c:	6a 00                	push   $0x0
  pushl $102
8010773e:	6a 66                	push   $0x66
  jmp alltraps
80107740:	e9 42 f7 ff ff       	jmp    80106e87 <alltraps>

80107745 <vector103>:
.globl vector103
vector103:
  pushl $0
80107745:	6a 00                	push   $0x0
  pushl $103
80107747:	6a 67                	push   $0x67
  jmp alltraps
80107749:	e9 39 f7 ff ff       	jmp    80106e87 <alltraps>

8010774e <vector104>:
.globl vector104
vector104:
  pushl $0
8010774e:	6a 00                	push   $0x0
  pushl $104
80107750:	6a 68                	push   $0x68
  jmp alltraps
80107752:	e9 30 f7 ff ff       	jmp    80106e87 <alltraps>

80107757 <vector105>:
.globl vector105
vector105:
  pushl $0
80107757:	6a 00                	push   $0x0
  pushl $105
80107759:	6a 69                	push   $0x69
  jmp alltraps
8010775b:	e9 27 f7 ff ff       	jmp    80106e87 <alltraps>

80107760 <vector106>:
.globl vector106
vector106:
  pushl $0
80107760:	6a 00                	push   $0x0
  pushl $106
80107762:	6a 6a                	push   $0x6a
  jmp alltraps
80107764:	e9 1e f7 ff ff       	jmp    80106e87 <alltraps>

80107769 <vector107>:
.globl vector107
vector107:
  pushl $0
80107769:	6a 00                	push   $0x0
  pushl $107
8010776b:	6a 6b                	push   $0x6b
  jmp alltraps
8010776d:	e9 15 f7 ff ff       	jmp    80106e87 <alltraps>

80107772 <vector108>:
.globl vector108
vector108:
  pushl $0
80107772:	6a 00                	push   $0x0
  pushl $108
80107774:	6a 6c                	push   $0x6c
  jmp alltraps
80107776:	e9 0c f7 ff ff       	jmp    80106e87 <alltraps>

8010777b <vector109>:
.globl vector109
vector109:
  pushl $0
8010777b:	6a 00                	push   $0x0
  pushl $109
8010777d:	6a 6d                	push   $0x6d
  jmp alltraps
8010777f:	e9 03 f7 ff ff       	jmp    80106e87 <alltraps>

80107784 <vector110>:
.globl vector110
vector110:
  pushl $0
80107784:	6a 00                	push   $0x0
  pushl $110
80107786:	6a 6e                	push   $0x6e
  jmp alltraps
80107788:	e9 fa f6 ff ff       	jmp    80106e87 <alltraps>

8010778d <vector111>:
.globl vector111
vector111:
  pushl $0
8010778d:	6a 00                	push   $0x0
  pushl $111
8010778f:	6a 6f                	push   $0x6f
  jmp alltraps
80107791:	e9 f1 f6 ff ff       	jmp    80106e87 <alltraps>

80107796 <vector112>:
.globl vector112
vector112:
  pushl $0
80107796:	6a 00                	push   $0x0
  pushl $112
80107798:	6a 70                	push   $0x70
  jmp alltraps
8010779a:	e9 e8 f6 ff ff       	jmp    80106e87 <alltraps>

8010779f <vector113>:
.globl vector113
vector113:
  pushl $0
8010779f:	6a 00                	push   $0x0
  pushl $113
801077a1:	6a 71                	push   $0x71
  jmp alltraps
801077a3:	e9 df f6 ff ff       	jmp    80106e87 <alltraps>

801077a8 <vector114>:
.globl vector114
vector114:
  pushl $0
801077a8:	6a 00                	push   $0x0
  pushl $114
801077aa:	6a 72                	push   $0x72
  jmp alltraps
801077ac:	e9 d6 f6 ff ff       	jmp    80106e87 <alltraps>

801077b1 <vector115>:
.globl vector115
vector115:
  pushl $0
801077b1:	6a 00                	push   $0x0
  pushl $115
801077b3:	6a 73                	push   $0x73
  jmp alltraps
801077b5:	e9 cd f6 ff ff       	jmp    80106e87 <alltraps>

801077ba <vector116>:
.globl vector116
vector116:
  pushl $0
801077ba:	6a 00                	push   $0x0
  pushl $116
801077bc:	6a 74                	push   $0x74
  jmp alltraps
801077be:	e9 c4 f6 ff ff       	jmp    80106e87 <alltraps>

801077c3 <vector117>:
.globl vector117
vector117:
  pushl $0
801077c3:	6a 00                	push   $0x0
  pushl $117
801077c5:	6a 75                	push   $0x75
  jmp alltraps
801077c7:	e9 bb f6 ff ff       	jmp    80106e87 <alltraps>

801077cc <vector118>:
.globl vector118
vector118:
  pushl $0
801077cc:	6a 00                	push   $0x0
  pushl $118
801077ce:	6a 76                	push   $0x76
  jmp alltraps
801077d0:	e9 b2 f6 ff ff       	jmp    80106e87 <alltraps>

801077d5 <vector119>:
.globl vector119
vector119:
  pushl $0
801077d5:	6a 00                	push   $0x0
  pushl $119
801077d7:	6a 77                	push   $0x77
  jmp alltraps
801077d9:	e9 a9 f6 ff ff       	jmp    80106e87 <alltraps>

801077de <vector120>:
.globl vector120
vector120:
  pushl $0
801077de:	6a 00                	push   $0x0
  pushl $120
801077e0:	6a 78                	push   $0x78
  jmp alltraps
801077e2:	e9 a0 f6 ff ff       	jmp    80106e87 <alltraps>

801077e7 <vector121>:
.globl vector121
vector121:
  pushl $0
801077e7:	6a 00                	push   $0x0
  pushl $121
801077e9:	6a 79                	push   $0x79
  jmp alltraps
801077eb:	e9 97 f6 ff ff       	jmp    80106e87 <alltraps>

801077f0 <vector122>:
.globl vector122
vector122:
  pushl $0
801077f0:	6a 00                	push   $0x0
  pushl $122
801077f2:	6a 7a                	push   $0x7a
  jmp alltraps
801077f4:	e9 8e f6 ff ff       	jmp    80106e87 <alltraps>

801077f9 <vector123>:
.globl vector123
vector123:
  pushl $0
801077f9:	6a 00                	push   $0x0
  pushl $123
801077fb:	6a 7b                	push   $0x7b
  jmp alltraps
801077fd:	e9 85 f6 ff ff       	jmp    80106e87 <alltraps>

80107802 <vector124>:
.globl vector124
vector124:
  pushl $0
80107802:	6a 00                	push   $0x0
  pushl $124
80107804:	6a 7c                	push   $0x7c
  jmp alltraps
80107806:	e9 7c f6 ff ff       	jmp    80106e87 <alltraps>

8010780b <vector125>:
.globl vector125
vector125:
  pushl $0
8010780b:	6a 00                	push   $0x0
  pushl $125
8010780d:	6a 7d                	push   $0x7d
  jmp alltraps
8010780f:	e9 73 f6 ff ff       	jmp    80106e87 <alltraps>

80107814 <vector126>:
.globl vector126
vector126:
  pushl $0
80107814:	6a 00                	push   $0x0
  pushl $126
80107816:	6a 7e                	push   $0x7e
  jmp alltraps
80107818:	e9 6a f6 ff ff       	jmp    80106e87 <alltraps>

8010781d <vector127>:
.globl vector127
vector127:
  pushl $0
8010781d:	6a 00                	push   $0x0
  pushl $127
8010781f:	6a 7f                	push   $0x7f
  jmp alltraps
80107821:	e9 61 f6 ff ff       	jmp    80106e87 <alltraps>

80107826 <vector128>:
.globl vector128
vector128:
  pushl $0
80107826:	6a 00                	push   $0x0
  pushl $128
80107828:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010782d:	e9 55 f6 ff ff       	jmp    80106e87 <alltraps>

80107832 <vector129>:
.globl vector129
vector129:
  pushl $0
80107832:	6a 00                	push   $0x0
  pushl $129
80107834:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80107839:	e9 49 f6 ff ff       	jmp    80106e87 <alltraps>

8010783e <vector130>:
.globl vector130
vector130:
  pushl $0
8010783e:	6a 00                	push   $0x0
  pushl $130
80107840:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80107845:	e9 3d f6 ff ff       	jmp    80106e87 <alltraps>

8010784a <vector131>:
.globl vector131
vector131:
  pushl $0
8010784a:	6a 00                	push   $0x0
  pushl $131
8010784c:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80107851:	e9 31 f6 ff ff       	jmp    80106e87 <alltraps>

80107856 <vector132>:
.globl vector132
vector132:
  pushl $0
80107856:	6a 00                	push   $0x0
  pushl $132
80107858:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010785d:	e9 25 f6 ff ff       	jmp    80106e87 <alltraps>

80107862 <vector133>:
.globl vector133
vector133:
  pushl $0
80107862:	6a 00                	push   $0x0
  pushl $133
80107864:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80107869:	e9 19 f6 ff ff       	jmp    80106e87 <alltraps>

8010786e <vector134>:
.globl vector134
vector134:
  pushl $0
8010786e:	6a 00                	push   $0x0
  pushl $134
80107870:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107875:	e9 0d f6 ff ff       	jmp    80106e87 <alltraps>

8010787a <vector135>:
.globl vector135
vector135:
  pushl $0
8010787a:	6a 00                	push   $0x0
  pushl $135
8010787c:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107881:	e9 01 f6 ff ff       	jmp    80106e87 <alltraps>

80107886 <vector136>:
.globl vector136
vector136:
  pushl $0
80107886:	6a 00                	push   $0x0
  pushl $136
80107888:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010788d:	e9 f5 f5 ff ff       	jmp    80106e87 <alltraps>

80107892 <vector137>:
.globl vector137
vector137:
  pushl $0
80107892:	6a 00                	push   $0x0
  pushl $137
80107894:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80107899:	e9 e9 f5 ff ff       	jmp    80106e87 <alltraps>

8010789e <vector138>:
.globl vector138
vector138:
  pushl $0
8010789e:	6a 00                	push   $0x0
  pushl $138
801078a0:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801078a5:	e9 dd f5 ff ff       	jmp    80106e87 <alltraps>

801078aa <vector139>:
.globl vector139
vector139:
  pushl $0
801078aa:	6a 00                	push   $0x0
  pushl $139
801078ac:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801078b1:	e9 d1 f5 ff ff       	jmp    80106e87 <alltraps>

801078b6 <vector140>:
.globl vector140
vector140:
  pushl $0
801078b6:	6a 00                	push   $0x0
  pushl $140
801078b8:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801078bd:	e9 c5 f5 ff ff       	jmp    80106e87 <alltraps>

801078c2 <vector141>:
.globl vector141
vector141:
  pushl $0
801078c2:	6a 00                	push   $0x0
  pushl $141
801078c4:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801078c9:	e9 b9 f5 ff ff       	jmp    80106e87 <alltraps>

801078ce <vector142>:
.globl vector142
vector142:
  pushl $0
801078ce:	6a 00                	push   $0x0
  pushl $142
801078d0:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801078d5:	e9 ad f5 ff ff       	jmp    80106e87 <alltraps>

801078da <vector143>:
.globl vector143
vector143:
  pushl $0
801078da:	6a 00                	push   $0x0
  pushl $143
801078dc:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801078e1:	e9 a1 f5 ff ff       	jmp    80106e87 <alltraps>

801078e6 <vector144>:
.globl vector144
vector144:
  pushl $0
801078e6:	6a 00                	push   $0x0
  pushl $144
801078e8:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801078ed:	e9 95 f5 ff ff       	jmp    80106e87 <alltraps>

801078f2 <vector145>:
.globl vector145
vector145:
  pushl $0
801078f2:	6a 00                	push   $0x0
  pushl $145
801078f4:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801078f9:	e9 89 f5 ff ff       	jmp    80106e87 <alltraps>

801078fe <vector146>:
.globl vector146
vector146:
  pushl $0
801078fe:	6a 00                	push   $0x0
  pushl $146
80107900:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107905:	e9 7d f5 ff ff       	jmp    80106e87 <alltraps>

8010790a <vector147>:
.globl vector147
vector147:
  pushl $0
8010790a:	6a 00                	push   $0x0
  pushl $147
8010790c:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107911:	e9 71 f5 ff ff       	jmp    80106e87 <alltraps>

80107916 <vector148>:
.globl vector148
vector148:
  pushl $0
80107916:	6a 00                	push   $0x0
  pushl $148
80107918:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010791d:	e9 65 f5 ff ff       	jmp    80106e87 <alltraps>

80107922 <vector149>:
.globl vector149
vector149:
  pushl $0
80107922:	6a 00                	push   $0x0
  pushl $149
80107924:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80107929:	e9 59 f5 ff ff       	jmp    80106e87 <alltraps>

8010792e <vector150>:
.globl vector150
vector150:
  pushl $0
8010792e:	6a 00                	push   $0x0
  pushl $150
80107930:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107935:	e9 4d f5 ff ff       	jmp    80106e87 <alltraps>

8010793a <vector151>:
.globl vector151
vector151:
  pushl $0
8010793a:	6a 00                	push   $0x0
  pushl $151
8010793c:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80107941:	e9 41 f5 ff ff       	jmp    80106e87 <alltraps>

80107946 <vector152>:
.globl vector152
vector152:
  pushl $0
80107946:	6a 00                	push   $0x0
  pushl $152
80107948:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010794d:	e9 35 f5 ff ff       	jmp    80106e87 <alltraps>

80107952 <vector153>:
.globl vector153
vector153:
  pushl $0
80107952:	6a 00                	push   $0x0
  pushl $153
80107954:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80107959:	e9 29 f5 ff ff       	jmp    80106e87 <alltraps>

8010795e <vector154>:
.globl vector154
vector154:
  pushl $0
8010795e:	6a 00                	push   $0x0
  pushl $154
80107960:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80107965:	e9 1d f5 ff ff       	jmp    80106e87 <alltraps>

8010796a <vector155>:
.globl vector155
vector155:
  pushl $0
8010796a:	6a 00                	push   $0x0
  pushl $155
8010796c:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107971:	e9 11 f5 ff ff       	jmp    80106e87 <alltraps>

80107976 <vector156>:
.globl vector156
vector156:
  pushl $0
80107976:	6a 00                	push   $0x0
  pushl $156
80107978:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010797d:	e9 05 f5 ff ff       	jmp    80106e87 <alltraps>

80107982 <vector157>:
.globl vector157
vector157:
  pushl $0
80107982:	6a 00                	push   $0x0
  pushl $157
80107984:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80107989:	e9 f9 f4 ff ff       	jmp    80106e87 <alltraps>

8010798e <vector158>:
.globl vector158
vector158:
  pushl $0
8010798e:	6a 00                	push   $0x0
  pushl $158
80107990:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107995:	e9 ed f4 ff ff       	jmp    80106e87 <alltraps>

8010799a <vector159>:
.globl vector159
vector159:
  pushl $0
8010799a:	6a 00                	push   $0x0
  pushl $159
8010799c:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801079a1:	e9 e1 f4 ff ff       	jmp    80106e87 <alltraps>

801079a6 <vector160>:
.globl vector160
vector160:
  pushl $0
801079a6:	6a 00                	push   $0x0
  pushl $160
801079a8:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801079ad:	e9 d5 f4 ff ff       	jmp    80106e87 <alltraps>

801079b2 <vector161>:
.globl vector161
vector161:
  pushl $0
801079b2:	6a 00                	push   $0x0
  pushl $161
801079b4:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801079b9:	e9 c9 f4 ff ff       	jmp    80106e87 <alltraps>

801079be <vector162>:
.globl vector162
vector162:
  pushl $0
801079be:	6a 00                	push   $0x0
  pushl $162
801079c0:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801079c5:	e9 bd f4 ff ff       	jmp    80106e87 <alltraps>

801079ca <vector163>:
.globl vector163
vector163:
  pushl $0
801079ca:	6a 00                	push   $0x0
  pushl $163
801079cc:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801079d1:	e9 b1 f4 ff ff       	jmp    80106e87 <alltraps>

801079d6 <vector164>:
.globl vector164
vector164:
  pushl $0
801079d6:	6a 00                	push   $0x0
  pushl $164
801079d8:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801079dd:	e9 a5 f4 ff ff       	jmp    80106e87 <alltraps>

801079e2 <vector165>:
.globl vector165
vector165:
  pushl $0
801079e2:	6a 00                	push   $0x0
  pushl $165
801079e4:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801079e9:	e9 99 f4 ff ff       	jmp    80106e87 <alltraps>

801079ee <vector166>:
.globl vector166
vector166:
  pushl $0
801079ee:	6a 00                	push   $0x0
  pushl $166
801079f0:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801079f5:	e9 8d f4 ff ff       	jmp    80106e87 <alltraps>

801079fa <vector167>:
.globl vector167
vector167:
  pushl $0
801079fa:	6a 00                	push   $0x0
  pushl $167
801079fc:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107a01:	e9 81 f4 ff ff       	jmp    80106e87 <alltraps>

80107a06 <vector168>:
.globl vector168
vector168:
  pushl $0
80107a06:	6a 00                	push   $0x0
  pushl $168
80107a08:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80107a0d:	e9 75 f4 ff ff       	jmp    80106e87 <alltraps>

80107a12 <vector169>:
.globl vector169
vector169:
  pushl $0
80107a12:	6a 00                	push   $0x0
  pushl $169
80107a14:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80107a19:	e9 69 f4 ff ff       	jmp    80106e87 <alltraps>

80107a1e <vector170>:
.globl vector170
vector170:
  pushl $0
80107a1e:	6a 00                	push   $0x0
  pushl $170
80107a20:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107a25:	e9 5d f4 ff ff       	jmp    80106e87 <alltraps>

80107a2a <vector171>:
.globl vector171
vector171:
  pushl $0
80107a2a:	6a 00                	push   $0x0
  pushl $171
80107a2c:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107a31:	e9 51 f4 ff ff       	jmp    80106e87 <alltraps>

80107a36 <vector172>:
.globl vector172
vector172:
  pushl $0
80107a36:	6a 00                	push   $0x0
  pushl $172
80107a38:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80107a3d:	e9 45 f4 ff ff       	jmp    80106e87 <alltraps>

80107a42 <vector173>:
.globl vector173
vector173:
  pushl $0
80107a42:	6a 00                	push   $0x0
  pushl $173
80107a44:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80107a49:	e9 39 f4 ff ff       	jmp    80106e87 <alltraps>

80107a4e <vector174>:
.globl vector174
vector174:
  pushl $0
80107a4e:	6a 00                	push   $0x0
  pushl $174
80107a50:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107a55:	e9 2d f4 ff ff       	jmp    80106e87 <alltraps>

80107a5a <vector175>:
.globl vector175
vector175:
  pushl $0
80107a5a:	6a 00                	push   $0x0
  pushl $175
80107a5c:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107a61:	e9 21 f4 ff ff       	jmp    80106e87 <alltraps>

80107a66 <vector176>:
.globl vector176
vector176:
  pushl $0
80107a66:	6a 00                	push   $0x0
  pushl $176
80107a68:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80107a6d:	e9 15 f4 ff ff       	jmp    80106e87 <alltraps>

80107a72 <vector177>:
.globl vector177
vector177:
  pushl $0
80107a72:	6a 00                	push   $0x0
  pushl $177
80107a74:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80107a79:	e9 09 f4 ff ff       	jmp    80106e87 <alltraps>

80107a7e <vector178>:
.globl vector178
vector178:
  pushl $0
80107a7e:	6a 00                	push   $0x0
  pushl $178
80107a80:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107a85:	e9 fd f3 ff ff       	jmp    80106e87 <alltraps>

80107a8a <vector179>:
.globl vector179
vector179:
  pushl $0
80107a8a:	6a 00                	push   $0x0
  pushl $179
80107a8c:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107a91:	e9 f1 f3 ff ff       	jmp    80106e87 <alltraps>

80107a96 <vector180>:
.globl vector180
vector180:
  pushl $0
80107a96:	6a 00                	push   $0x0
  pushl $180
80107a98:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80107a9d:	e9 e5 f3 ff ff       	jmp    80106e87 <alltraps>

80107aa2 <vector181>:
.globl vector181
vector181:
  pushl $0
80107aa2:	6a 00                	push   $0x0
  pushl $181
80107aa4:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80107aa9:	e9 d9 f3 ff ff       	jmp    80106e87 <alltraps>

80107aae <vector182>:
.globl vector182
vector182:
  pushl $0
80107aae:	6a 00                	push   $0x0
  pushl $182
80107ab0:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107ab5:	e9 cd f3 ff ff       	jmp    80106e87 <alltraps>

80107aba <vector183>:
.globl vector183
vector183:
  pushl $0
80107aba:	6a 00                	push   $0x0
  pushl $183
80107abc:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107ac1:	e9 c1 f3 ff ff       	jmp    80106e87 <alltraps>

80107ac6 <vector184>:
.globl vector184
vector184:
  pushl $0
80107ac6:	6a 00                	push   $0x0
  pushl $184
80107ac8:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80107acd:	e9 b5 f3 ff ff       	jmp    80106e87 <alltraps>

80107ad2 <vector185>:
.globl vector185
vector185:
  pushl $0
80107ad2:	6a 00                	push   $0x0
  pushl $185
80107ad4:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80107ad9:	e9 a9 f3 ff ff       	jmp    80106e87 <alltraps>

80107ade <vector186>:
.globl vector186
vector186:
  pushl $0
80107ade:	6a 00                	push   $0x0
  pushl $186
80107ae0:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107ae5:	e9 9d f3 ff ff       	jmp    80106e87 <alltraps>

80107aea <vector187>:
.globl vector187
vector187:
  pushl $0
80107aea:	6a 00                	push   $0x0
  pushl $187
80107aec:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107af1:	e9 91 f3 ff ff       	jmp    80106e87 <alltraps>

80107af6 <vector188>:
.globl vector188
vector188:
  pushl $0
80107af6:	6a 00                	push   $0x0
  pushl $188
80107af8:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80107afd:	e9 85 f3 ff ff       	jmp    80106e87 <alltraps>

80107b02 <vector189>:
.globl vector189
vector189:
  pushl $0
80107b02:	6a 00                	push   $0x0
  pushl $189
80107b04:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80107b09:	e9 79 f3 ff ff       	jmp    80106e87 <alltraps>

80107b0e <vector190>:
.globl vector190
vector190:
  pushl $0
80107b0e:	6a 00                	push   $0x0
  pushl $190
80107b10:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107b15:	e9 6d f3 ff ff       	jmp    80106e87 <alltraps>

80107b1a <vector191>:
.globl vector191
vector191:
  pushl $0
80107b1a:	6a 00                	push   $0x0
  pushl $191
80107b1c:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107b21:	e9 61 f3 ff ff       	jmp    80106e87 <alltraps>

80107b26 <vector192>:
.globl vector192
vector192:
  pushl $0
80107b26:	6a 00                	push   $0x0
  pushl $192
80107b28:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80107b2d:	e9 55 f3 ff ff       	jmp    80106e87 <alltraps>

80107b32 <vector193>:
.globl vector193
vector193:
  pushl $0
80107b32:	6a 00                	push   $0x0
  pushl $193
80107b34:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80107b39:	e9 49 f3 ff ff       	jmp    80106e87 <alltraps>

80107b3e <vector194>:
.globl vector194
vector194:
  pushl $0
80107b3e:	6a 00                	push   $0x0
  pushl $194
80107b40:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107b45:	e9 3d f3 ff ff       	jmp    80106e87 <alltraps>

80107b4a <vector195>:
.globl vector195
vector195:
  pushl $0
80107b4a:	6a 00                	push   $0x0
  pushl $195
80107b4c:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107b51:	e9 31 f3 ff ff       	jmp    80106e87 <alltraps>

80107b56 <vector196>:
.globl vector196
vector196:
  pushl $0
80107b56:	6a 00                	push   $0x0
  pushl $196
80107b58:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80107b5d:	e9 25 f3 ff ff       	jmp    80106e87 <alltraps>

80107b62 <vector197>:
.globl vector197
vector197:
  pushl $0
80107b62:	6a 00                	push   $0x0
  pushl $197
80107b64:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80107b69:	e9 19 f3 ff ff       	jmp    80106e87 <alltraps>

80107b6e <vector198>:
.globl vector198
vector198:
  pushl $0
80107b6e:	6a 00                	push   $0x0
  pushl $198
80107b70:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107b75:	e9 0d f3 ff ff       	jmp    80106e87 <alltraps>

80107b7a <vector199>:
.globl vector199
vector199:
  pushl $0
80107b7a:	6a 00                	push   $0x0
  pushl $199
80107b7c:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107b81:	e9 01 f3 ff ff       	jmp    80106e87 <alltraps>

80107b86 <vector200>:
.globl vector200
vector200:
  pushl $0
80107b86:	6a 00                	push   $0x0
  pushl $200
80107b88:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80107b8d:	e9 f5 f2 ff ff       	jmp    80106e87 <alltraps>

80107b92 <vector201>:
.globl vector201
vector201:
  pushl $0
80107b92:	6a 00                	push   $0x0
  pushl $201
80107b94:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80107b99:	e9 e9 f2 ff ff       	jmp    80106e87 <alltraps>

80107b9e <vector202>:
.globl vector202
vector202:
  pushl $0
80107b9e:	6a 00                	push   $0x0
  pushl $202
80107ba0:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107ba5:	e9 dd f2 ff ff       	jmp    80106e87 <alltraps>

80107baa <vector203>:
.globl vector203
vector203:
  pushl $0
80107baa:	6a 00                	push   $0x0
  pushl $203
80107bac:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107bb1:	e9 d1 f2 ff ff       	jmp    80106e87 <alltraps>

80107bb6 <vector204>:
.globl vector204
vector204:
  pushl $0
80107bb6:	6a 00                	push   $0x0
  pushl $204
80107bb8:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80107bbd:	e9 c5 f2 ff ff       	jmp    80106e87 <alltraps>

80107bc2 <vector205>:
.globl vector205
vector205:
  pushl $0
80107bc2:	6a 00                	push   $0x0
  pushl $205
80107bc4:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80107bc9:	e9 b9 f2 ff ff       	jmp    80106e87 <alltraps>

80107bce <vector206>:
.globl vector206
vector206:
  pushl $0
80107bce:	6a 00                	push   $0x0
  pushl $206
80107bd0:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107bd5:	e9 ad f2 ff ff       	jmp    80106e87 <alltraps>

80107bda <vector207>:
.globl vector207
vector207:
  pushl $0
80107bda:	6a 00                	push   $0x0
  pushl $207
80107bdc:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107be1:	e9 a1 f2 ff ff       	jmp    80106e87 <alltraps>

80107be6 <vector208>:
.globl vector208
vector208:
  pushl $0
80107be6:	6a 00                	push   $0x0
  pushl $208
80107be8:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80107bed:	e9 95 f2 ff ff       	jmp    80106e87 <alltraps>

80107bf2 <vector209>:
.globl vector209
vector209:
  pushl $0
80107bf2:	6a 00                	push   $0x0
  pushl $209
80107bf4:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80107bf9:	e9 89 f2 ff ff       	jmp    80106e87 <alltraps>

80107bfe <vector210>:
.globl vector210
vector210:
  pushl $0
80107bfe:	6a 00                	push   $0x0
  pushl $210
80107c00:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107c05:	e9 7d f2 ff ff       	jmp    80106e87 <alltraps>

80107c0a <vector211>:
.globl vector211
vector211:
  pushl $0
80107c0a:	6a 00                	push   $0x0
  pushl $211
80107c0c:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107c11:	e9 71 f2 ff ff       	jmp    80106e87 <alltraps>

80107c16 <vector212>:
.globl vector212
vector212:
  pushl $0
80107c16:	6a 00                	push   $0x0
  pushl $212
80107c18:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80107c1d:	e9 65 f2 ff ff       	jmp    80106e87 <alltraps>

80107c22 <vector213>:
.globl vector213
vector213:
  pushl $0
80107c22:	6a 00                	push   $0x0
  pushl $213
80107c24:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80107c29:	e9 59 f2 ff ff       	jmp    80106e87 <alltraps>

80107c2e <vector214>:
.globl vector214
vector214:
  pushl $0
80107c2e:	6a 00                	push   $0x0
  pushl $214
80107c30:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107c35:	e9 4d f2 ff ff       	jmp    80106e87 <alltraps>

80107c3a <vector215>:
.globl vector215
vector215:
  pushl $0
80107c3a:	6a 00                	push   $0x0
  pushl $215
80107c3c:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107c41:	e9 41 f2 ff ff       	jmp    80106e87 <alltraps>

80107c46 <vector216>:
.globl vector216
vector216:
  pushl $0
80107c46:	6a 00                	push   $0x0
  pushl $216
80107c48:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80107c4d:	e9 35 f2 ff ff       	jmp    80106e87 <alltraps>

80107c52 <vector217>:
.globl vector217
vector217:
  pushl $0
80107c52:	6a 00                	push   $0x0
  pushl $217
80107c54:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80107c59:	e9 29 f2 ff ff       	jmp    80106e87 <alltraps>

80107c5e <vector218>:
.globl vector218
vector218:
  pushl $0
80107c5e:	6a 00                	push   $0x0
  pushl $218
80107c60:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107c65:	e9 1d f2 ff ff       	jmp    80106e87 <alltraps>

80107c6a <vector219>:
.globl vector219
vector219:
  pushl $0
80107c6a:	6a 00                	push   $0x0
  pushl $219
80107c6c:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107c71:	e9 11 f2 ff ff       	jmp    80106e87 <alltraps>

80107c76 <vector220>:
.globl vector220
vector220:
  pushl $0
80107c76:	6a 00                	push   $0x0
  pushl $220
80107c78:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80107c7d:	e9 05 f2 ff ff       	jmp    80106e87 <alltraps>

80107c82 <vector221>:
.globl vector221
vector221:
  pushl $0
80107c82:	6a 00                	push   $0x0
  pushl $221
80107c84:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80107c89:	e9 f9 f1 ff ff       	jmp    80106e87 <alltraps>

80107c8e <vector222>:
.globl vector222
vector222:
  pushl $0
80107c8e:	6a 00                	push   $0x0
  pushl $222
80107c90:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107c95:	e9 ed f1 ff ff       	jmp    80106e87 <alltraps>

80107c9a <vector223>:
.globl vector223
vector223:
  pushl $0
80107c9a:	6a 00                	push   $0x0
  pushl $223
80107c9c:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107ca1:	e9 e1 f1 ff ff       	jmp    80106e87 <alltraps>

80107ca6 <vector224>:
.globl vector224
vector224:
  pushl $0
80107ca6:	6a 00                	push   $0x0
  pushl $224
80107ca8:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80107cad:	e9 d5 f1 ff ff       	jmp    80106e87 <alltraps>

80107cb2 <vector225>:
.globl vector225
vector225:
  pushl $0
80107cb2:	6a 00                	push   $0x0
  pushl $225
80107cb4:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107cb9:	e9 c9 f1 ff ff       	jmp    80106e87 <alltraps>

80107cbe <vector226>:
.globl vector226
vector226:
  pushl $0
80107cbe:	6a 00                	push   $0x0
  pushl $226
80107cc0:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107cc5:	e9 bd f1 ff ff       	jmp    80106e87 <alltraps>

80107cca <vector227>:
.globl vector227
vector227:
  pushl $0
80107cca:	6a 00                	push   $0x0
  pushl $227
80107ccc:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107cd1:	e9 b1 f1 ff ff       	jmp    80106e87 <alltraps>

80107cd6 <vector228>:
.globl vector228
vector228:
  pushl $0
80107cd6:	6a 00                	push   $0x0
  pushl $228
80107cd8:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80107cdd:	e9 a5 f1 ff ff       	jmp    80106e87 <alltraps>

80107ce2 <vector229>:
.globl vector229
vector229:
  pushl $0
80107ce2:	6a 00                	push   $0x0
  pushl $229
80107ce4:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80107ce9:	e9 99 f1 ff ff       	jmp    80106e87 <alltraps>

80107cee <vector230>:
.globl vector230
vector230:
  pushl $0
80107cee:	6a 00                	push   $0x0
  pushl $230
80107cf0:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107cf5:	e9 8d f1 ff ff       	jmp    80106e87 <alltraps>

80107cfa <vector231>:
.globl vector231
vector231:
  pushl $0
80107cfa:	6a 00                	push   $0x0
  pushl $231
80107cfc:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107d01:	e9 81 f1 ff ff       	jmp    80106e87 <alltraps>

80107d06 <vector232>:
.globl vector232
vector232:
  pushl $0
80107d06:	6a 00                	push   $0x0
  pushl $232
80107d08:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107d0d:	e9 75 f1 ff ff       	jmp    80106e87 <alltraps>

80107d12 <vector233>:
.globl vector233
vector233:
  pushl $0
80107d12:	6a 00                	push   $0x0
  pushl $233
80107d14:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107d19:	e9 69 f1 ff ff       	jmp    80106e87 <alltraps>

80107d1e <vector234>:
.globl vector234
vector234:
  pushl $0
80107d1e:	6a 00                	push   $0x0
  pushl $234
80107d20:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107d25:	e9 5d f1 ff ff       	jmp    80106e87 <alltraps>

80107d2a <vector235>:
.globl vector235
vector235:
  pushl $0
80107d2a:	6a 00                	push   $0x0
  pushl $235
80107d2c:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107d31:	e9 51 f1 ff ff       	jmp    80106e87 <alltraps>

80107d36 <vector236>:
.globl vector236
vector236:
  pushl $0
80107d36:	6a 00                	push   $0x0
  pushl $236
80107d38:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107d3d:	e9 45 f1 ff ff       	jmp    80106e87 <alltraps>

80107d42 <vector237>:
.globl vector237
vector237:
  pushl $0
80107d42:	6a 00                	push   $0x0
  pushl $237
80107d44:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107d49:	e9 39 f1 ff ff       	jmp    80106e87 <alltraps>

80107d4e <vector238>:
.globl vector238
vector238:
  pushl $0
80107d4e:	6a 00                	push   $0x0
  pushl $238
80107d50:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107d55:	e9 2d f1 ff ff       	jmp    80106e87 <alltraps>

80107d5a <vector239>:
.globl vector239
vector239:
  pushl $0
80107d5a:	6a 00                	push   $0x0
  pushl $239
80107d5c:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107d61:	e9 21 f1 ff ff       	jmp    80106e87 <alltraps>

80107d66 <vector240>:
.globl vector240
vector240:
  pushl $0
80107d66:	6a 00                	push   $0x0
  pushl $240
80107d68:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107d6d:	e9 15 f1 ff ff       	jmp    80106e87 <alltraps>

80107d72 <vector241>:
.globl vector241
vector241:
  pushl $0
80107d72:	6a 00                	push   $0x0
  pushl $241
80107d74:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107d79:	e9 09 f1 ff ff       	jmp    80106e87 <alltraps>

80107d7e <vector242>:
.globl vector242
vector242:
  pushl $0
80107d7e:	6a 00                	push   $0x0
  pushl $242
80107d80:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107d85:	e9 fd f0 ff ff       	jmp    80106e87 <alltraps>

80107d8a <vector243>:
.globl vector243
vector243:
  pushl $0
80107d8a:	6a 00                	push   $0x0
  pushl $243
80107d8c:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107d91:	e9 f1 f0 ff ff       	jmp    80106e87 <alltraps>

80107d96 <vector244>:
.globl vector244
vector244:
  pushl $0
80107d96:	6a 00                	push   $0x0
  pushl $244
80107d98:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107d9d:	e9 e5 f0 ff ff       	jmp    80106e87 <alltraps>

80107da2 <vector245>:
.globl vector245
vector245:
  pushl $0
80107da2:	6a 00                	push   $0x0
  pushl $245
80107da4:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107da9:	e9 d9 f0 ff ff       	jmp    80106e87 <alltraps>

80107dae <vector246>:
.globl vector246
vector246:
  pushl $0
80107dae:	6a 00                	push   $0x0
  pushl $246
80107db0:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107db5:	e9 cd f0 ff ff       	jmp    80106e87 <alltraps>

80107dba <vector247>:
.globl vector247
vector247:
  pushl $0
80107dba:	6a 00                	push   $0x0
  pushl $247
80107dbc:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107dc1:	e9 c1 f0 ff ff       	jmp    80106e87 <alltraps>

80107dc6 <vector248>:
.globl vector248
vector248:
  pushl $0
80107dc6:	6a 00                	push   $0x0
  pushl $248
80107dc8:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107dcd:	e9 b5 f0 ff ff       	jmp    80106e87 <alltraps>

80107dd2 <vector249>:
.globl vector249
vector249:
  pushl $0
80107dd2:	6a 00                	push   $0x0
  pushl $249
80107dd4:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107dd9:	e9 a9 f0 ff ff       	jmp    80106e87 <alltraps>

80107dde <vector250>:
.globl vector250
vector250:
  pushl $0
80107dde:	6a 00                	push   $0x0
  pushl $250
80107de0:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107de5:	e9 9d f0 ff ff       	jmp    80106e87 <alltraps>

80107dea <vector251>:
.globl vector251
vector251:
  pushl $0
80107dea:	6a 00                	push   $0x0
  pushl $251
80107dec:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107df1:	e9 91 f0 ff ff       	jmp    80106e87 <alltraps>

80107df6 <vector252>:
.globl vector252
vector252:
  pushl $0
80107df6:	6a 00                	push   $0x0
  pushl $252
80107df8:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107dfd:	e9 85 f0 ff ff       	jmp    80106e87 <alltraps>

80107e02 <vector253>:
.globl vector253
vector253:
  pushl $0
80107e02:	6a 00                	push   $0x0
  pushl $253
80107e04:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107e09:	e9 79 f0 ff ff       	jmp    80106e87 <alltraps>

80107e0e <vector254>:
.globl vector254
vector254:
  pushl $0
80107e0e:	6a 00                	push   $0x0
  pushl $254
80107e10:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107e15:	e9 6d f0 ff ff       	jmp    80106e87 <alltraps>

80107e1a <vector255>:
.globl vector255
vector255:
  pushl $0
80107e1a:	6a 00                	push   $0x0
  pushl $255
80107e1c:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107e21:	e9 61 f0 ff ff       	jmp    80106e87 <alltraps>
80107e26:	66 90                	xchg   %ax,%ax
80107e28:	66 90                	xchg   %ax,%ax
80107e2a:	66 90                	xchg   %ax,%ax
80107e2c:	66 90                	xchg   %ax,%ax
80107e2e:	66 90                	xchg   %ax,%ax

80107e30 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107e30:	55                   	push   %ebp
80107e31:	89 e5                	mov    %esp,%ebp
80107e33:	83 ec 28             	sub    $0x28,%esp
80107e36:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107e39:	89 d3                	mov    %edx,%ebx
80107e3b:	c1 eb 16             	shr    $0x16,%ebx
{
80107e3e:	89 75 f8             	mov    %esi,-0x8(%ebp)
  pde = &pgdir[PDX(va)];
80107e41:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80107e44:	89 7d fc             	mov    %edi,-0x4(%ebp)
80107e47:	89 d7                	mov    %edx,%edi
  if(*pde & PTE_P){
80107e49:	8b 06                	mov    (%esi),%eax
80107e4b:	a8 01                	test   $0x1,%al
80107e4d:	74 29                	je     80107e78 <walkpgdir+0x48>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107e4f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107e54:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107e5a:	c1 ef 0a             	shr    $0xa,%edi
}
80107e5d:	8b 75 f8             	mov    -0x8(%ebp),%esi
  return &pgtab[PTX(va)];
80107e60:	89 fa                	mov    %edi,%edx
}
80107e62:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return &pgtab[PTX(va)];
80107e65:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107e6b:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80107e6e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107e71:	89 ec                	mov    %ebp,%esp
80107e73:	5d                   	pop    %ebp
80107e74:	c3                   	ret    
80107e75:	8d 76 00             	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107e78:	85 c9                	test   %ecx,%ecx
80107e7a:	74 34                	je     80107eb0 <walkpgdir+0x80>
80107e7c:	e8 2f a7 ff ff       	call   801025b0 <kalloc>
80107e81:	85 c0                	test   %eax,%eax
80107e83:	89 c3                	mov    %eax,%ebx
80107e85:	74 29                	je     80107eb0 <walkpgdir+0x80>
    memset(pgtab, 0, PGSIZE);
80107e87:	b8 00 10 00 00       	mov    $0x1000,%eax
80107e8c:	31 d2                	xor    %edx,%edx
80107e8e:	89 44 24 08          	mov    %eax,0x8(%esp)
80107e92:	89 54 24 04          	mov    %edx,0x4(%esp)
80107e96:	89 1c 24             	mov    %ebx,(%esp)
80107e99:	e8 22 dd ff ff       	call   80105bc0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107e9e:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107ea4:	83 c8 07             	or     $0x7,%eax
80107ea7:	89 06                	mov    %eax,(%esi)
80107ea9:	eb af                	jmp    80107e5a <walkpgdir+0x2a>
80107eab:	90                   	nop
80107eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80107eb0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
      return 0;
80107eb3:	31 c0                	xor    %eax,%eax
}
80107eb5:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107eb8:	8b 7d fc             	mov    -0x4(%ebp),%edi
80107ebb:	89 ec                	mov    %ebp,%esp
80107ebd:	5d                   	pop    %ebp
80107ebe:	c3                   	ret    
80107ebf:	90                   	nop

80107ec0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107ec0:	55                   	push   %ebp
80107ec1:	89 e5                	mov    %esp,%ebp
80107ec3:	57                   	push   %edi
80107ec4:	56                   	push   %esi
80107ec5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107ec6:	89 d3                	mov    %edx,%ebx
{
80107ec8:	83 ec 2c             	sub    $0x2c,%esp
  a = (char*)PGROUNDDOWN((uint)va);
80107ecb:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80107ed1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107ed4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107ed8:	8b 7d 08             	mov    0x8(%ebp),%edi
80107edb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107ee0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80107ee3:	8b 45 0c             	mov    0xc(%ebp),%eax
80107ee6:	29 df                	sub    %ebx,%edi
80107ee8:	83 c8 01             	or     $0x1,%eax
80107eeb:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107eee:	eb 17                	jmp    80107f07 <mappages+0x47>
    if(*pte & PTE_P)
80107ef0:	f6 00 01             	testb  $0x1,(%eax)
80107ef3:	75 45                	jne    80107f3a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80107ef5:	8b 55 dc             	mov    -0x24(%ebp),%edx
80107ef8:	09 d6                	or     %edx,%esi
    if(a == last)
80107efa:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
80107efd:	89 30                	mov    %esi,(%eax)
    if(a == last)
80107eff:	74 2f                	je     80107f30 <mappages+0x70>
      break;
    a += PGSIZE;
80107f01:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107f07:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107f0a:	b9 01 00 00 00       	mov    $0x1,%ecx
80107f0f:	89 da                	mov    %ebx,%edx
80107f11:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80107f14:	e8 17 ff ff ff       	call   80107e30 <walkpgdir>
80107f19:	85 c0                	test   %eax,%eax
80107f1b:	75 d3                	jne    80107ef0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80107f1d:	83 c4 2c             	add    $0x2c,%esp
      return -1;
80107f20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107f25:	5b                   	pop    %ebx
80107f26:	5e                   	pop    %esi
80107f27:	5f                   	pop    %edi
80107f28:	5d                   	pop    %ebp
80107f29:	c3                   	ret    
80107f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107f30:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80107f33:	31 c0                	xor    %eax,%eax
}
80107f35:	5b                   	pop    %ebx
80107f36:	5e                   	pop    %esi
80107f37:	5f                   	pop    %edi
80107f38:	5d                   	pop    %ebp
80107f39:	c3                   	ret    
      panic("remap");
80107f3a:	c7 04 24 f0 91 10 80 	movl   $0x801091f0,(%esp)
80107f41:	e8 2a 84 ff ff       	call   80100370 <panic>
80107f46:	8d 76 00             	lea    0x0(%esi),%esi
80107f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107f50 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107f50:	55                   	push   %ebp
80107f51:	89 e5                	mov    %esp,%ebp
80107f53:	57                   	push   %edi
80107f54:	89 c7                	mov    %eax,%edi
80107f56:	56                   	push   %esi
80107f57:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107f58:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107f5e:	83 ec 2c             	sub    $0x2c,%esp
  a = PGROUNDUP(newsz);
80107f61:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107f67:	39 d3                	cmp    %edx,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107f69:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107f6c:	73 62                	jae    80107fd0 <deallocuvm.part.0+0x80>
80107f6e:	89 d6                	mov    %edx,%esi
80107f70:	eb 39                	jmp    80107fab <deallocuvm.part.0+0x5b>
80107f72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80107f78:	8b 10                	mov    (%eax),%edx
80107f7a:	f6 c2 01             	test   $0x1,%dl
80107f7d:	74 22                	je     80107fa1 <deallocuvm.part.0+0x51>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80107f7f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107f85:	74 54                	je     80107fdb <deallocuvm.part.0+0x8b>
        panic("kfree");
      char *v = P2V(pa);
80107f87:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
80107f8d:	89 14 24             	mov    %edx,(%esp)
80107f90:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107f93:	e8 48 a4 ff ff       	call   801023e0 <kfree>
      *pte = 0;
80107f98:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107f9b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80107fa1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107fa7:	39 f3                	cmp    %esi,%ebx
80107fa9:	73 25                	jae    80107fd0 <deallocuvm.part.0+0x80>
    pte = walkpgdir(pgdir, (char*)a, 0);
80107fab:	31 c9                	xor    %ecx,%ecx
80107fad:	89 da                	mov    %ebx,%edx
80107faf:	89 f8                	mov    %edi,%eax
80107fb1:	e8 7a fe ff ff       	call   80107e30 <walkpgdir>
    if(!pte)
80107fb6:	85 c0                	test   %eax,%eax
80107fb8:	75 be                	jne    80107f78 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107fba:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80107fc0:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107fc6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107fcc:	39 f3                	cmp    %esi,%ebx
80107fce:	72 db                	jb     80107fab <deallocuvm.part.0+0x5b>
    }
  }
  return newsz;
}
80107fd0:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107fd3:	83 c4 2c             	add    $0x2c,%esp
80107fd6:	5b                   	pop    %ebx
80107fd7:	5e                   	pop    %esi
80107fd8:	5f                   	pop    %edi
80107fd9:	5d                   	pop    %ebp
80107fda:	c3                   	ret    
        panic("kfree");
80107fdb:	c7 04 24 e6 89 10 80 	movl   $0x801089e6,(%esp)
80107fe2:	e8 89 83 ff ff       	call   80100370 <panic>
80107fe7:	89 f6                	mov    %esi,%esi
80107fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107ff0 <seginit>:
{
80107ff0:	55                   	push   %ebp
80107ff1:	89 e5                	mov    %esp,%ebp
80107ff3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107ff6:	e8 05 ba ff ff       	call   80103a00 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107ffb:	b9 00 9a cf 00       	mov    $0xcf9a00,%ecx
  pd[0] = size-1;
80108000:	66 c7 45 f2 2f 00    	movw   $0x2f,-0xe(%ebp)
80108006:	8d 14 80             	lea    (%eax,%eax,4),%edx
80108009:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010800c:	ba ff ff 00 00       	mov    $0xffff,%edx
80108011:	c1 e0 04             	shl    $0x4,%eax
80108014:	89 90 58 48 11 80    	mov    %edx,-0x7feeb7a8(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010801a:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010801f:	89 88 5c 48 11 80    	mov    %ecx,-0x7feeb7a4(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80108025:	b9 00 92 cf 00       	mov    $0xcf9200,%ecx
8010802a:	89 90 60 48 11 80    	mov    %edx,-0x7feeb7a0(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80108030:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80108035:	89 88 64 48 11 80    	mov    %ecx,-0x7feeb79c(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010803b:	b9 00 fa cf 00       	mov    $0xcffa00,%ecx
80108040:	89 90 68 48 11 80    	mov    %edx,-0x7feeb798(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80108046:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010804b:	89 88 6c 48 11 80    	mov    %ecx,-0x7feeb794(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80108051:	b9 00 f2 cf 00       	mov    $0xcff200,%ecx
80108056:	89 90 70 48 11 80    	mov    %edx,-0x7feeb790(%eax)
8010805c:	89 88 74 48 11 80    	mov    %ecx,-0x7feeb78c(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80108062:	05 50 48 11 80       	add    $0x80114850,%eax
  pd[1] = (uint)p;
80108067:	0f b7 d0             	movzwl %ax,%edx
  pd[2] = (uint)p >> 16;
8010806a:	c1 e8 10             	shr    $0x10,%eax
  pd[1] = (uint)p;
8010806d:	66 89 55 f4          	mov    %dx,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80108071:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80108075:	8d 45 f2             	lea    -0xe(%ebp),%eax
80108078:	0f 01 10             	lgdtl  (%eax)
}
8010807b:	c9                   	leave  
8010807c:	c3                   	ret    
8010807d:	8d 76 00             	lea    0x0(%esi),%esi

80108080 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108080:	a1 04 80 11 80       	mov    0x80118004,%eax
{
80108085:	55                   	push   %ebp
80108086:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108088:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010808d:	0f 22 d8             	mov    %eax,%cr3
}
80108090:	5d                   	pop    %ebp
80108091:	c3                   	ret    
80108092:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801080a0 <switchuvm>:
{
801080a0:	55                   	push   %ebp
801080a1:	89 e5                	mov    %esp,%ebp
801080a3:	57                   	push   %edi
801080a4:	56                   	push   %esi
801080a5:	53                   	push   %ebx
801080a6:	83 ec 2c             	sub    $0x2c,%esp
801080a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
801080ac:	85 db                	test   %ebx,%ebx
801080ae:	0f 84 c5 00 00 00    	je     80108179 <switchuvm+0xd9>
  if(p->kstack == 0)
801080b4:	8b 7b 08             	mov    0x8(%ebx),%edi
801080b7:	85 ff                	test   %edi,%edi
801080b9:	0f 84 d2 00 00 00    	je     80108191 <switchuvm+0xf1>
  if(p->pgdir == 0)
801080bf:	8b 73 04             	mov    0x4(%ebx),%esi
801080c2:	85 f6                	test   %esi,%esi
801080c4:	0f 84 bb 00 00 00    	je     80108185 <switchuvm+0xe5>
  pushcli();
801080ca:	e8 21 d9 ff ff       	call   801059f0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801080cf:	e8 ac b8 ff ff       	call   80103980 <mycpu>
801080d4:	89 c6                	mov    %eax,%esi
801080d6:	e8 a5 b8 ff ff       	call   80103980 <mycpu>
801080db:	89 c7                	mov    %eax,%edi
801080dd:	e8 9e b8 ff ff       	call   80103980 <mycpu>
801080e2:	83 c7 08             	add    $0x8,%edi
801080e5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801080e8:	e8 93 b8 ff ff       	call   80103980 <mycpu>
801080ed:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801080f0:	ba 67 00 00 00       	mov    $0x67,%edx
801080f5:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
801080fc:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80108103:	83 c1 08             	add    $0x8,%ecx
80108106:	c1 e9 10             	shr    $0x10,%ecx
80108109:	83 c0 08             	add    $0x8,%eax
8010810c:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80108112:	c1 e8 18             	shr    $0x18,%eax
80108115:	b9 99 40 00 00       	mov    $0x4099,%ecx
8010811a:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
80108121:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->gdt[SEG_TSS].s = 0;
80108127:	e8 54 b8 ff ff       	call   80103980 <mycpu>
8010812c:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80108133:	e8 48 b8 ff ff       	call   80103980 <mycpu>
80108138:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
8010813e:	8b 73 08             	mov    0x8(%ebx),%esi
80108141:	e8 3a b8 ff ff       	call   80103980 <mycpu>
80108146:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010814c:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010814f:	e8 2c b8 ff ff       	call   80103980 <mycpu>
80108154:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
8010815a:	b8 28 00 00 00       	mov    $0x28,%eax
8010815f:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80108162:	8b 43 04             	mov    0x4(%ebx),%eax
80108165:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010816a:	0f 22 d8             	mov    %eax,%cr3
}
8010816d:	83 c4 2c             	add    $0x2c,%esp
80108170:	5b                   	pop    %ebx
80108171:	5e                   	pop    %esi
80108172:	5f                   	pop    %edi
80108173:	5d                   	pop    %ebp
  popcli();
80108174:	e9 b7 d8 ff ff       	jmp    80105a30 <popcli>
    panic("switchuvm: no process");
80108179:	c7 04 24 f6 91 10 80 	movl   $0x801091f6,(%esp)
80108180:	e8 eb 81 ff ff       	call   80100370 <panic>
    panic("switchuvm: no pgdir");
80108185:	c7 04 24 21 92 10 80 	movl   $0x80109221,(%esp)
8010818c:	e8 df 81 ff ff       	call   80100370 <panic>
    panic("switchuvm: no kstack");
80108191:	c7 04 24 0c 92 10 80 	movl   $0x8010920c,(%esp)
80108198:	e8 d3 81 ff ff       	call   80100370 <panic>
8010819d:	8d 76 00             	lea    0x0(%esi),%esi

801081a0 <inituvm>:
{
801081a0:	55                   	push   %ebp
801081a1:	89 e5                	mov    %esp,%ebp
801081a3:	83 ec 38             	sub    $0x38,%esp
801081a6:	89 75 f8             	mov    %esi,-0x8(%ebp)
801081a9:	8b 75 10             	mov    0x10(%ebp),%esi
801081ac:	8b 45 08             	mov    0x8(%ebp),%eax
801081af:	89 7d fc             	mov    %edi,-0x4(%ebp)
801081b2:	8b 7d 0c             	mov    0xc(%ebp),%edi
801081b5:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  if(sz >= PGSIZE)
801081b8:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
801081be:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
801081c1:	77 59                	ja     8010821c <inituvm+0x7c>
  mem = kalloc();
801081c3:	e8 e8 a3 ff ff       	call   801025b0 <kalloc>
  memset(mem, 0, PGSIZE);
801081c8:	31 d2                	xor    %edx,%edx
801081ca:	89 54 24 04          	mov    %edx,0x4(%esp)
  mem = kalloc();
801081ce:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801081d0:	b8 00 10 00 00       	mov    $0x1000,%eax
801081d5:	89 1c 24             	mov    %ebx,(%esp)
801081d8:	89 44 24 08          	mov    %eax,0x8(%esp)
801081dc:	e8 df d9 ff ff       	call   80105bc0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801081e1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801081e7:	b9 06 00 00 00       	mov    $0x6,%ecx
801081ec:	89 04 24             	mov    %eax,(%esp)
801081ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801081f2:	31 d2                	xor    %edx,%edx
801081f4:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801081f8:	b9 00 10 00 00       	mov    $0x1000,%ecx
801081fd:	e8 be fc ff ff       	call   80107ec0 <mappages>
  memmove(mem, init, sz);
80108202:	89 75 10             	mov    %esi,0x10(%ebp)
}
80108205:	8b 75 f8             	mov    -0x8(%ebp),%esi
  memmove(mem, init, sz);
80108208:	89 7d 0c             	mov    %edi,0xc(%ebp)
}
8010820b:	8b 7d fc             	mov    -0x4(%ebp),%edi
  memmove(mem, init, sz);
8010820e:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80108211:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80108214:	89 ec                	mov    %ebp,%esp
80108216:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80108217:	e9 64 da ff ff       	jmp    80105c80 <memmove>
    panic("inituvm: more than a page");
8010821c:	c7 04 24 35 92 10 80 	movl   $0x80109235,(%esp)
80108223:	e8 48 81 ff ff       	call   80100370 <panic>
80108228:	90                   	nop
80108229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108230 <loaduvm>:
{
80108230:	55                   	push   %ebp
80108231:	89 e5                	mov    %esp,%ebp
80108233:	57                   	push   %edi
80108234:	56                   	push   %esi
80108235:	53                   	push   %ebx
80108236:	83 ec 1c             	sub    $0x1c,%esp
  if((uint) addr % PGSIZE != 0)
80108239:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80108240:	0f 85 98 00 00 00    	jne    801082de <loaduvm+0xae>
  for(i = 0; i < sz; i += PGSIZE){
80108246:	8b 75 18             	mov    0x18(%ebp),%esi
80108249:	31 db                	xor    %ebx,%ebx
8010824b:	85 f6                	test   %esi,%esi
8010824d:	75 1a                	jne    80108269 <loaduvm+0x39>
8010824f:	eb 77                	jmp    801082c8 <loaduvm+0x98>
80108251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108258:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010825e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80108264:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80108267:	76 5f                	jbe    801082c8 <loaduvm+0x98>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80108269:	8b 55 0c             	mov    0xc(%ebp),%edx
8010826c:	31 c9                	xor    %ecx,%ecx
8010826e:	8b 45 08             	mov    0x8(%ebp),%eax
80108271:	01 da                	add    %ebx,%edx
80108273:	e8 b8 fb ff ff       	call   80107e30 <walkpgdir>
80108278:	85 c0                	test   %eax,%eax
8010827a:	74 56                	je     801082d2 <loaduvm+0xa2>
    pa = PTE_ADDR(*pte);
8010827c:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
8010827e:	bf 00 10 00 00       	mov    $0x1000,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80108283:	8b 4d 14             	mov    0x14(%ebp),%ecx
    pa = PTE_ADDR(*pte);
80108286:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
8010828b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80108291:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80108294:	05 00 00 00 80       	add    $0x80000000,%eax
80108299:	89 44 24 04          	mov    %eax,0x4(%esp)
8010829d:	8b 45 10             	mov    0x10(%ebp),%eax
801082a0:	01 d9                	add    %ebx,%ecx
801082a2:	89 7c 24 0c          	mov    %edi,0xc(%esp)
801082a6:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801082aa:	89 04 24             	mov    %eax,(%esp)
801082ad:	e8 1e 97 ff ff       	call   801019d0 <readi>
801082b2:	39 f8                	cmp    %edi,%eax
801082b4:	74 a2                	je     80108258 <loaduvm+0x28>
}
801082b6:	83 c4 1c             	add    $0x1c,%esp
      return -1;
801082b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801082be:	5b                   	pop    %ebx
801082bf:	5e                   	pop    %esi
801082c0:	5f                   	pop    %edi
801082c1:	5d                   	pop    %ebp
801082c2:	c3                   	ret    
801082c3:	90                   	nop
801082c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801082c8:	83 c4 1c             	add    $0x1c,%esp
  return 0;
801082cb:	31 c0                	xor    %eax,%eax
}
801082cd:	5b                   	pop    %ebx
801082ce:	5e                   	pop    %esi
801082cf:	5f                   	pop    %edi
801082d0:	5d                   	pop    %ebp
801082d1:	c3                   	ret    
      panic("loaduvm: address should exist");
801082d2:	c7 04 24 4f 92 10 80 	movl   $0x8010924f,(%esp)
801082d9:	e8 92 80 ff ff       	call   80100370 <panic>
    panic("loaduvm: addr must be page aligned");
801082de:	c7 04 24 f0 92 10 80 	movl   $0x801092f0,(%esp)
801082e5:	e8 86 80 ff ff       	call   80100370 <panic>
801082ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801082f0 <allocuvm>:
{
801082f0:	55                   	push   %ebp
801082f1:	89 e5                	mov    %esp,%ebp
801082f3:	57                   	push   %edi
801082f4:	56                   	push   %esi
801082f5:	53                   	push   %ebx
801082f6:	83 ec 2c             	sub    $0x2c,%esp
  if(newsz >= KERNBASE)
801082f9:	8b 7d 10             	mov    0x10(%ebp),%edi
801082fc:	85 ff                	test   %edi,%edi
801082fe:	0f 88 91 00 00 00    	js     80108395 <allocuvm+0xa5>
  if(newsz < oldsz)
80108304:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80108307:	0f 82 9b 00 00 00    	jb     801083a8 <allocuvm+0xb8>
  a = PGROUNDUP(oldsz);
8010830d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108310:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80108316:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010831c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010831f:	0f 86 86 00 00 00    	jbe    801083ab <allocuvm+0xbb>
80108325:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80108328:	8b 7d 08             	mov    0x8(%ebp),%edi
8010832b:	eb 49                	jmp    80108376 <allocuvm+0x86>
8010832d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80108330:	31 d2                	xor    %edx,%edx
80108332:	b8 00 10 00 00       	mov    $0x1000,%eax
80108337:	89 54 24 04          	mov    %edx,0x4(%esp)
8010833b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010833f:	89 34 24             	mov    %esi,(%esp)
80108342:	e8 79 d8 ff ff       	call   80105bc0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80108347:	b9 06 00 00 00       	mov    $0x6,%ecx
8010834c:	89 da                	mov    %ebx,%edx
8010834e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80108354:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80108358:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010835d:	89 04 24             	mov    %eax,(%esp)
80108360:	89 f8                	mov    %edi,%eax
80108362:	e8 59 fb ff ff       	call   80107ec0 <mappages>
80108367:	85 c0                	test   %eax,%eax
80108369:	78 4d                	js     801083b8 <allocuvm+0xc8>
  for(; a < newsz; a += PGSIZE){
8010836b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80108371:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80108374:	76 7a                	jbe    801083f0 <allocuvm+0x100>
    mem = kalloc();
80108376:	e8 35 a2 ff ff       	call   801025b0 <kalloc>
    if(mem == 0){
8010837b:	85 c0                	test   %eax,%eax
    mem = kalloc();
8010837d:	89 c6                	mov    %eax,%esi
    if(mem == 0){
8010837f:	75 af                	jne    80108330 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80108381:	c7 04 24 6d 92 10 80 	movl   $0x8010926d,(%esp)
80108388:	e8 c3 82 ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
8010838d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108390:	39 45 10             	cmp    %eax,0x10(%ebp)
80108393:	77 6b                	ja     80108400 <allocuvm+0x110>
}
80108395:	83 c4 2c             	add    $0x2c,%esp
    return 0;
80108398:	31 ff                	xor    %edi,%edi
}
8010839a:	5b                   	pop    %ebx
8010839b:	89 f8                	mov    %edi,%eax
8010839d:	5e                   	pop    %esi
8010839e:	5f                   	pop    %edi
8010839f:	5d                   	pop    %ebp
801083a0:	c3                   	ret    
801083a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
801083a8:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
801083ab:	83 c4 2c             	add    $0x2c,%esp
801083ae:	89 f8                	mov    %edi,%eax
801083b0:	5b                   	pop    %ebx
801083b1:	5e                   	pop    %esi
801083b2:	5f                   	pop    %edi
801083b3:	5d                   	pop    %ebp
801083b4:	c3                   	ret    
801083b5:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
801083b8:	c7 04 24 85 92 10 80 	movl   $0x80109285,(%esp)
801083bf:	e8 8c 82 ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
801083c4:	8b 45 0c             	mov    0xc(%ebp),%eax
801083c7:	39 45 10             	cmp    %eax,0x10(%ebp)
801083ca:	76 0d                	jbe    801083d9 <allocuvm+0xe9>
801083cc:	89 c1                	mov    %eax,%ecx
801083ce:	8b 55 10             	mov    0x10(%ebp),%edx
801083d1:	8b 45 08             	mov    0x8(%ebp),%eax
801083d4:	e8 77 fb ff ff       	call   80107f50 <deallocuvm.part.0>
      kfree(mem);
801083d9:	89 34 24             	mov    %esi,(%esp)
      return 0;
801083dc:	31 ff                	xor    %edi,%edi
      kfree(mem);
801083de:	e8 fd 9f ff ff       	call   801023e0 <kfree>
}
801083e3:	83 c4 2c             	add    $0x2c,%esp
801083e6:	89 f8                	mov    %edi,%eax
801083e8:	5b                   	pop    %ebx
801083e9:	5e                   	pop    %esi
801083ea:	5f                   	pop    %edi
801083eb:	5d                   	pop    %ebp
801083ec:	c3                   	ret    
801083ed:	8d 76 00             	lea    0x0(%esi),%esi
801083f0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801083f3:	83 c4 2c             	add    $0x2c,%esp
801083f6:	5b                   	pop    %ebx
801083f7:	5e                   	pop    %esi
801083f8:	89 f8                	mov    %edi,%eax
801083fa:	5f                   	pop    %edi
801083fb:	5d                   	pop    %ebp
801083fc:	c3                   	ret    
801083fd:	8d 76 00             	lea    0x0(%esi),%esi
80108400:	89 c1                	mov    %eax,%ecx
80108402:	8b 55 10             	mov    0x10(%ebp),%edx
      return 0;
80108405:	31 ff                	xor    %edi,%edi
80108407:	8b 45 08             	mov    0x8(%ebp),%eax
8010840a:	e8 41 fb ff ff       	call   80107f50 <deallocuvm.part.0>
8010840f:	eb 9a                	jmp    801083ab <allocuvm+0xbb>
80108411:	eb 0d                	jmp    80108420 <deallocuvm>
80108413:	90                   	nop
80108414:	90                   	nop
80108415:	90                   	nop
80108416:	90                   	nop
80108417:	90                   	nop
80108418:	90                   	nop
80108419:	90                   	nop
8010841a:	90                   	nop
8010841b:	90                   	nop
8010841c:	90                   	nop
8010841d:	90                   	nop
8010841e:	90                   	nop
8010841f:	90                   	nop

80108420 <deallocuvm>:
{
80108420:	55                   	push   %ebp
80108421:	89 e5                	mov    %esp,%ebp
80108423:	8b 55 0c             	mov    0xc(%ebp),%edx
80108426:	8b 4d 10             	mov    0x10(%ebp),%ecx
80108429:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010842c:	39 d1                	cmp    %edx,%ecx
8010842e:	73 10                	jae    80108440 <deallocuvm+0x20>
}
80108430:	5d                   	pop    %ebp
80108431:	e9 1a fb ff ff       	jmp    80107f50 <deallocuvm.part.0>
80108436:	8d 76 00             	lea    0x0(%esi),%esi
80108439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80108440:	89 d0                	mov    %edx,%eax
80108442:	5d                   	pop    %ebp
80108443:	c3                   	ret    
80108444:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010844a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80108450 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80108450:	55                   	push   %ebp
80108451:	89 e5                	mov    %esp,%ebp
80108453:	57                   	push   %edi
80108454:	56                   	push   %esi
80108455:	53                   	push   %ebx
80108456:	83 ec 1c             	sub    $0x1c,%esp
80108459:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010845c:	85 f6                	test   %esi,%esi
8010845e:	74 55                	je     801084b5 <freevm+0x65>
80108460:	31 c9                	xor    %ecx,%ecx
80108462:	ba 00 00 00 80       	mov    $0x80000000,%edx
80108467:	89 f0                	mov    %esi,%eax
80108469:	89 f3                	mov    %esi,%ebx
8010846b:	e8 e0 fa ff ff       	call   80107f50 <deallocuvm.part.0>
80108470:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80108476:	eb 0f                	jmp    80108487 <freevm+0x37>
80108478:	90                   	nop
80108479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108480:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80108483:	39 fb                	cmp    %edi,%ebx
80108485:	74 1f                	je     801084a6 <freevm+0x56>
    if(pgdir[i] & PTE_P){
80108487:	8b 03                	mov    (%ebx),%eax
80108489:	a8 01                	test   $0x1,%al
8010848b:	74 f3                	je     80108480 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010848d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108492:	83 c3 04             	add    $0x4,%ebx
80108495:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010849a:	89 04 24             	mov    %eax,(%esp)
8010849d:	e8 3e 9f ff ff       	call   801023e0 <kfree>
  for(i = 0; i < NPDENTRIES; i++){
801084a2:	39 fb                	cmp    %edi,%ebx
801084a4:	75 e1                	jne    80108487 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
801084a6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801084a9:	83 c4 1c             	add    $0x1c,%esp
801084ac:	5b                   	pop    %ebx
801084ad:	5e                   	pop    %esi
801084ae:	5f                   	pop    %edi
801084af:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801084b0:	e9 2b 9f ff ff       	jmp    801023e0 <kfree>
    panic("freevm: no pgdir");
801084b5:	c7 04 24 a1 92 10 80 	movl   $0x801092a1,(%esp)
801084bc:	e8 af 7e ff ff       	call   80100370 <panic>
801084c1:	eb 0d                	jmp    801084d0 <setupkvm>
801084c3:	90                   	nop
801084c4:	90                   	nop
801084c5:	90                   	nop
801084c6:	90                   	nop
801084c7:	90                   	nop
801084c8:	90                   	nop
801084c9:	90                   	nop
801084ca:	90                   	nop
801084cb:	90                   	nop
801084cc:	90                   	nop
801084cd:	90                   	nop
801084ce:	90                   	nop
801084cf:	90                   	nop

801084d0 <setupkvm>:
{
801084d0:	55                   	push   %ebp
801084d1:	89 e5                	mov    %esp,%ebp
801084d3:	56                   	push   %esi
801084d4:	53                   	push   %ebx
801084d5:	83 ec 10             	sub    $0x10,%esp
  if((pgdir = (pde_t*)kalloc()) == 0)
801084d8:	e8 d3 a0 ff ff       	call   801025b0 <kalloc>
801084dd:	85 c0                	test   %eax,%eax
801084df:	89 c6                	mov    %eax,%esi
801084e1:	74 46                	je     80108529 <setupkvm+0x59>
  memset(pgdir, 0, PGSIZE);
801084e3:	b8 00 10 00 00       	mov    $0x1000,%eax
801084e8:	31 d2                	xor    %edx,%edx
801084ea:	89 44 24 08          	mov    %eax,0x8(%esp)
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801084ee:	bb 20 c4 10 80       	mov    $0x8010c420,%ebx
  memset(pgdir, 0, PGSIZE);
801084f3:	89 54 24 04          	mov    %edx,0x4(%esp)
801084f7:	89 34 24             	mov    %esi,(%esp)
801084fa:	e8 c1 d6 ff ff       	call   80105bc0 <memset>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801084ff:	8b 53 0c             	mov    0xc(%ebx),%edx
                (uint)k->phys_start, k->perm) < 0) {
80108502:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80108505:	8b 4b 08             	mov    0x8(%ebx),%ecx
80108508:	89 54 24 04          	mov    %edx,0x4(%esp)
8010850c:	8b 13                	mov    (%ebx),%edx
8010850e:	89 04 24             	mov    %eax,(%esp)
80108511:	29 c1                	sub    %eax,%ecx
80108513:	89 f0                	mov    %esi,%eax
80108515:	e8 a6 f9 ff ff       	call   80107ec0 <mappages>
8010851a:	85 c0                	test   %eax,%eax
8010851c:	78 1a                	js     80108538 <setupkvm+0x68>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010851e:	83 c3 10             	add    $0x10,%ebx
80108521:	81 fb 60 c4 10 80    	cmp    $0x8010c460,%ebx
80108527:	75 d6                	jne    801084ff <setupkvm+0x2f>
}
80108529:	83 c4 10             	add    $0x10,%esp
8010852c:	89 f0                	mov    %esi,%eax
8010852e:	5b                   	pop    %ebx
8010852f:	5e                   	pop    %esi
80108530:	5d                   	pop    %ebp
80108531:	c3                   	ret    
80108532:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      freevm(pgdir);
80108538:	89 34 24             	mov    %esi,(%esp)
      return 0;
8010853b:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
8010853d:	e8 0e ff ff ff       	call   80108450 <freevm>
}
80108542:	83 c4 10             	add    $0x10,%esp
80108545:	89 f0                	mov    %esi,%eax
80108547:	5b                   	pop    %ebx
80108548:	5e                   	pop    %esi
80108549:	5d                   	pop    %ebp
8010854a:	c3                   	ret    
8010854b:	90                   	nop
8010854c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80108550 <kvmalloc>:
{
80108550:	55                   	push   %ebp
80108551:	89 e5                	mov    %esp,%ebp
80108553:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80108556:	e8 75 ff ff ff       	call   801084d0 <setupkvm>
8010855b:	a3 04 80 11 80       	mov    %eax,0x80118004
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108560:	05 00 00 00 80       	add    $0x80000000,%eax
80108565:	0f 22 d8             	mov    %eax,%cr3
}
80108568:	c9                   	leave  
80108569:	c3                   	ret    
8010856a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108570 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108570:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108571:	31 c9                	xor    %ecx,%ecx
{
80108573:	89 e5                	mov    %esp,%ebp
80108575:	83 ec 18             	sub    $0x18,%esp
  pte = walkpgdir(pgdir, uva, 0);
80108578:	8b 55 0c             	mov    0xc(%ebp),%edx
8010857b:	8b 45 08             	mov    0x8(%ebp),%eax
8010857e:	e8 ad f8 ff ff       	call   80107e30 <walkpgdir>
  if(pte == 0)
80108583:	85 c0                	test   %eax,%eax
80108585:	74 05                	je     8010858c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80108587:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010858a:	c9                   	leave  
8010858b:	c3                   	ret    
    panic("clearpteu");
8010858c:	c7 04 24 b2 92 10 80 	movl   $0x801092b2,(%esp)
80108593:	e8 d8 7d ff ff       	call   80100370 <panic>
80108598:	90                   	nop
80108599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801085a0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801085a0:	55                   	push   %ebp
801085a1:	89 e5                	mov    %esp,%ebp
801085a3:	57                   	push   %edi
801085a4:	56                   	push   %esi
801085a5:	53                   	push   %ebx
801085a6:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801085a9:	e8 22 ff ff ff       	call   801084d0 <setupkvm>
801085ae:	85 c0                	test   %eax,%eax
801085b0:	89 45 e0             	mov    %eax,-0x20(%ebp)
801085b3:	0f 84 a3 00 00 00    	je     8010865c <copyuvm+0xbc>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801085b9:	8b 55 0c             	mov    0xc(%ebp),%edx
801085bc:	85 d2                	test   %edx,%edx
801085be:	0f 84 98 00 00 00    	je     8010865c <copyuvm+0xbc>
801085c4:	31 ff                	xor    %edi,%edi
801085c6:	eb 50                	jmp    80108618 <copyuvm+0x78>
801085c8:	90                   	nop
801085c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801085d0:	b8 00 10 00 00       	mov    $0x1000,%eax
801085d5:	89 44 24 08          	mov    %eax,0x8(%esp)
801085d9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801085dc:	89 34 24             	mov    %esi,(%esp)
801085df:	05 00 00 00 80       	add    $0x80000000,%eax
801085e4:	89 44 24 04          	mov    %eax,0x4(%esp)
801085e8:	e8 93 d6 ff ff       	call   80105c80 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801085ed:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801085f3:	b9 00 10 00 00       	mov    $0x1000,%ecx
801085f8:	89 04 24             	mov    %eax,(%esp)
801085fb:	8b 45 e0             	mov    -0x20(%ebp),%eax
801085fe:	89 fa                	mov    %edi,%edx
80108600:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80108604:	e8 b7 f8 ff ff       	call   80107ec0 <mappages>
80108609:	85 c0                	test   %eax,%eax
8010860b:	78 63                	js     80108670 <copyuvm+0xd0>
  for(i = 0; i < sz; i += PGSIZE){
8010860d:	81 c7 00 10 00 00    	add    $0x1000,%edi
80108613:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80108616:	76 44                	jbe    8010865c <copyuvm+0xbc>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80108618:	8b 45 08             	mov    0x8(%ebp),%eax
8010861b:	31 c9                	xor    %ecx,%ecx
8010861d:	89 fa                	mov    %edi,%edx
8010861f:	e8 0c f8 ff ff       	call   80107e30 <walkpgdir>
80108624:	85 c0                	test   %eax,%eax
80108626:	74 5e                	je     80108686 <copyuvm+0xe6>
    if(!(*pte & PTE_P))
80108628:	8b 18                	mov    (%eax),%ebx
8010862a:	f6 c3 01             	test   $0x1,%bl
8010862d:	74 4b                	je     8010867a <copyuvm+0xda>
    pa = PTE_ADDR(*pte);
8010862f:	89 d8                	mov    %ebx,%eax
    flags = PTE_FLAGS(*pte);
80108631:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
80108637:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010863c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
8010863f:	e8 6c 9f ff ff       	call   801025b0 <kalloc>
80108644:	85 c0                	test   %eax,%eax
80108646:	89 c6                	mov    %eax,%esi
80108648:	75 86                	jne    801085d0 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
8010864a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010864d:	89 04 24             	mov    %eax,(%esp)
80108650:	e8 fb fd ff ff       	call   80108450 <freevm>
  return 0;
80108655:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
8010865c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010865f:	83 c4 2c             	add    $0x2c,%esp
80108662:	5b                   	pop    %ebx
80108663:	5e                   	pop    %esi
80108664:	5f                   	pop    %edi
80108665:	5d                   	pop    %ebp
80108666:	c3                   	ret    
80108667:	89 f6                	mov    %esi,%esi
80108669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      kfree(mem);
80108670:	89 34 24             	mov    %esi,(%esp)
80108673:	e8 68 9d ff ff       	call   801023e0 <kfree>
      goto bad;
80108678:	eb d0                	jmp    8010864a <copyuvm+0xaa>
      panic("copyuvm: page not present");
8010867a:	c7 04 24 d6 92 10 80 	movl   $0x801092d6,(%esp)
80108681:	e8 ea 7c ff ff       	call   80100370 <panic>
      panic("copyuvm: pte should exist");
80108686:	c7 04 24 bc 92 10 80 	movl   $0x801092bc,(%esp)
8010868d:	e8 de 7c ff ff       	call   80100370 <panic>
80108692:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801086a0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801086a0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801086a1:	31 c9                	xor    %ecx,%ecx
{
801086a3:	89 e5                	mov    %esp,%ebp
801086a5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
801086a8:	8b 55 0c             	mov    0xc(%ebp),%edx
801086ab:	8b 45 08             	mov    0x8(%ebp),%eax
801086ae:	e8 7d f7 ff ff       	call   80107e30 <walkpgdir>
  if((*pte & PTE_P) == 0)
801086b3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
801086b5:	89 c2                	mov    %eax,%edx
801086b7:	83 e2 05             	and    $0x5,%edx
801086ba:	83 fa 05             	cmp    $0x5,%edx
801086bd:	75 11                	jne    801086d0 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
801086bf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801086c4:	05 00 00 00 80       	add    $0x80000000,%eax
}
801086c9:	c9                   	leave  
801086ca:	c3                   	ret    
801086cb:	90                   	nop
801086cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
801086d0:	31 c0                	xor    %eax,%eax
}
801086d2:	c9                   	leave  
801086d3:	c3                   	ret    
801086d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801086da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801086e0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801086e0:	55                   	push   %ebp
801086e1:	89 e5                	mov    %esp,%ebp
801086e3:	57                   	push   %edi
801086e4:	56                   	push   %esi
801086e5:	53                   	push   %ebx
801086e6:	83 ec 2c             	sub    $0x2c,%esp
801086e9:	8b 75 14             	mov    0x14(%ebp),%esi
801086ec:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801086ef:	85 f6                	test   %esi,%esi
801086f1:	74 75                	je     80108768 <copyout+0x88>
801086f3:	89 da                	mov    %ebx,%edx
801086f5:	eb 3f                	jmp    80108736 <copyout+0x56>
801086f7:	89 f6                	mov    %esi,%esi
801086f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80108700:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80108703:	89 df                	mov    %ebx,%edi
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80108705:	8b 4d 10             	mov    0x10(%ebp),%ecx
    n = PGSIZE - (va - va0);
80108708:	29 d7                	sub    %edx,%edi
8010870a:	81 c7 00 10 00 00    	add    $0x1000,%edi
80108710:	39 f7                	cmp    %esi,%edi
80108712:	0f 47 fe             	cmova  %esi,%edi
    memmove(pa0 + (va - va0), buf, n);
80108715:	29 da                	sub    %ebx,%edx
80108717:	01 c2                	add    %eax,%edx
80108719:	89 14 24             	mov    %edx,(%esp)
8010871c:	89 7c 24 08          	mov    %edi,0x8(%esp)
80108720:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80108724:	e8 57 d5 ff ff       	call   80105c80 <memmove>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
80108729:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    buf += n;
8010872f:	01 7d 10             	add    %edi,0x10(%ebp)
  while(len > 0){
80108732:	29 fe                	sub    %edi,%esi
80108734:	74 32                	je     80108768 <copyout+0x88>
    pa0 = uva2ka(pgdir, (char*)va0);
80108736:	8b 45 08             	mov    0x8(%ebp),%eax
    va0 = (uint)PGROUNDDOWN(va);
80108739:	89 d3                	mov    %edx,%ebx
8010873b:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    pa0 = uva2ka(pgdir, (char*)va0);
80108741:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    va0 = (uint)PGROUNDDOWN(va);
80108745:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80108748:	89 04 24             	mov    %eax,(%esp)
8010874b:	e8 50 ff ff ff       	call   801086a0 <uva2ka>
    if(pa0 == 0)
80108750:	85 c0                	test   %eax,%eax
80108752:	75 ac                	jne    80108700 <copyout+0x20>
  }
  return 0;
}
80108754:	83 c4 2c             	add    $0x2c,%esp
      return -1;
80108757:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010875c:	5b                   	pop    %ebx
8010875d:	5e                   	pop    %esi
8010875e:	5f                   	pop    %edi
8010875f:	5d                   	pop    %ebp
80108760:	c3                   	ret    
80108761:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108768:	83 c4 2c             	add    $0x2c,%esp
  return 0;
8010876b:	31 c0                	xor    %eax,%eax
}
8010876d:	5b                   	pop    %ebx
8010876e:	5e                   	pop    %esi
8010876f:	5f                   	pop    %edi
80108770:	5d                   	pop    %ebp
80108771:	c3                   	ret    
