
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
80100041:	ba 40 88 10 80       	mov    $0x80108840,%edx
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
8010005c:	e8 9f 59 00 00       	call   80105a00 <initlock>
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
80100082:	b8 47 88 10 80       	mov    $0x80108847,%eax
    b->next = bcache.head.next;
80100087:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008a:	c7 43 50 1c 1d 11 80 	movl   $0x80111d1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100091:	89 44 24 04          	mov    %eax,0x4(%esp)
80100095:	8d 43 0c             	lea    0xc(%ebx),%eax
80100098:	89 04 24             	mov    %eax,(%esp)
8010009b:	e8 30 58 00 00       	call   801058d0 <initsleeplock>
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
801000e6:	e8 65 5a 00 00       	call   80105b50 <acquire>
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
80100161:	e8 8a 5a 00 00       	call   80105bf0 <release>
      acquiresleep(&b->lock);
80100166:	8d 43 0c             	lea    0xc(%ebx),%eax
80100169:	89 04 24             	mov    %eax,(%esp)
8010016c:	e8 9f 57 00 00       	call   80105910 <acquiresleep>
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
80100188:	c7 04 24 4e 88 10 80 	movl   $0x8010884e,(%esp)
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
801001b0:	e8 fb 57 00 00       	call   801059b0 <holdingsleep>
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
801001c9:	c7 04 24 5f 88 10 80 	movl   $0x8010885f,(%esp)
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
801001f1:	e8 ba 57 00 00       	call   801059b0 <holdingsleep>
801001f6:	85 c0                	test   %eax,%eax
801001f8:	74 5a                	je     80100254 <brelse+0x74>
    panic("brelse");

  releasesleep(&b->lock);
801001fa:	89 34 24             	mov    %esi,(%esp)
801001fd:	e8 6e 57 00 00       	call   80105970 <releasesleep>

  acquire(&bcache.lock);
80100202:	c7 04 24 20 d6 10 80 	movl   $0x8010d620,(%esp)
80100209:	e8 42 59 00 00       	call   80105b50 <acquire>
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
8010024f:	e9 9c 59 00 00       	jmp    80105bf0 <release>
    panic("brelse");
80100254:	c7 04 24 66 88 10 80 	movl   $0x80108866,(%esp)
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
8010027e:	e8 cd 58 00 00       	call   80105b50 <acquire>
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
801002b8:	e8 43 41 00 00       	call   80104400 <sleep>
    while(input.r == input.w){
801002bd:	8b 15 00 20 11 80    	mov    0x80112000,%edx
801002c3:	3b 15 04 20 11 80    	cmp    0x80112004,%edx
801002c9:	75 35                	jne    80100300 <consoleread+0xa0>
      if(myproc()->killed){
801002cb:	e8 e0 37 00 00       	call   80103ab0 <myproc>
801002d0:	8b 50 24             	mov    0x24(%eax),%edx
801002d3:	85 d2                	test   %edx,%edx
801002d5:	74 d1                	je     801002a8 <consoleread+0x48>
        release(&cons.lock);
801002d7:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
801002de:	e8 0d 59 00 00       	call   80105bf0 <release>
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
8010033a:	e8 b1 58 00 00       	call   80105bf0 <release>
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
8010038c:	c7 04 24 6d 88 10 80 	movl   $0x8010886d,(%esp)
80100393:	89 44 24 04          	mov    %eax,0x4(%esp)
80100397:	e8 b4 02 00 00       	call   80100650 <cprintf>
  cprintf(s);
8010039c:	8b 45 08             	mov    0x8(%ebp),%eax
8010039f:	89 04 24             	mov    %eax,(%esp)
801003a2:	e8 a9 02 00 00       	call   80100650 <cprintf>
  cprintf("\n");
801003a7:	c7 04 24 61 8f 10 80 	movl   $0x80108f61,(%esp)
801003ae:	e8 9d 02 00 00       	call   80100650 <cprintf>
  getcallerpcs(&s, pcs);
801003b3:	8d 45 08             	lea    0x8(%ebp),%eax
801003b6:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801003ba:	89 04 24             	mov    %eax,(%esp)
801003bd:	e8 5e 56 00 00       	call   80105a20 <getcallerpcs>
801003c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    cprintf(" %p", pcs[i]);
801003d0:	8b 03                	mov    (%ebx),%eax
801003d2:	83 c3 04             	add    $0x4,%ebx
801003d5:	c7 04 24 81 88 10 80 	movl   $0x80108881,(%esp)
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
80100429:	e8 f2 6f 00 00       	call   80107420 <uartputc>
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
801004cc:	e8 4f 6f 00 00       	call   80107420 <uartputc>
801004d1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004d8:	e8 43 6f 00 00       	call   80107420 <uartputc>
801004dd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004e4:	e8 37 6f 00 00       	call   80107420 <uartputc>
801004e9:	e9 40 ff ff ff       	jmp    8010042e <consputc+0x2e>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004ee:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
801004f5:	00 
801004f6:	c7 44 24 04 a0 80 0b 	movl   $0x800b80a0,0x4(%esp)
801004fd:	80 
801004fe:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
80100505:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80100508:	e8 f3 57 00 00       	call   80105d00 <memmove>
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
80100536:	e8 05 57 00 00       	call   80105c40 <memset>
8010053b:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010053e:	e9 4c ff ff ff       	jmp    8010048f <consputc+0x8f>
    panic("pos under/overflow");
80100543:	c7 04 24 85 88 10 80 	movl   $0x80108885,(%esp)
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
801005a1:	0f b6 92 b0 88 10 80 	movzbl -0x7fef7750(%edx),%edx
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
8010060e:	e8 3d 55 00 00       	call   80105b50 <acquire>
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
80100634:	e8 b7 55 00 00       	call   80105bf0 <release>
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
8010070e:	e8 dd 54 00 00       	call   80105bf0 <release>
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
80100774:	bf 98 88 10 80       	mov    $0x80108898,%edi
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
801007b7:	e8 94 53 00 00       	call   80105b50 <acquire>
801007bc:	e9 a8 fe ff ff       	jmp    80100669 <cprintf+0x19>
    panic("null fmt");
801007c1:	c7 04 24 9f 88 10 80 	movl   $0x8010889f,(%esp)
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
801007e4:	e8 67 53 00 00       	call   80105b50 <acquire>
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
80100847:	e8 a4 53 00 00       	call   80105bf0 <release>
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
801008d9:	e8 42 3d 00 00       	call   80104620 <wakeup>
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
8010094e:	e9 8d 3d 00 00       	jmp    801046e0 <procdump>
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
80100981:	b8 a8 88 10 80       	mov    $0x801088a8,%eax
{
80100986:	89 e5                	mov    %esp,%ebp
80100988:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
8010098b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010098f:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
80100996:	e8 65 50 00 00       	call   80105a00 <initlock>

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
801009dc:	e8 cf 30 00 00       	call   80103ab0 <myproc>
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
80100a5c:	e8 1f 7b 00 00       	call   80108580 <setupkvm>
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
80100ac8:	e8 d3 78 00 00       	call   801083a0 <allocuvm>
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
80100b05:	e8 d6 77 00 00       	call   801082e0 <loaduvm>
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
80100b58:	e8 a3 79 00 00       	call   80108500 <freevm>
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
80100b92:	e8 09 78 00 00       	call   801083a0 <allocuvm>
80100b97:	85 c0                	test   %eax,%eax
80100b99:	89 c6                	mov    %eax,%esi
80100b9b:	75 33                	jne    80100bd0 <exec+0x200>
    freevm(pgdir);
80100b9d:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ba3:	89 04 24             	mov    %eax,(%esp)
80100ba6:	e8 55 79 00 00       	call   80108500 <freevm>
  return -1;
80100bab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bb0:	e9 8c fe ff ff       	jmp    80100a41 <exec+0x71>
    end_op();
80100bb5:	e8 46 21 00 00       	call   80102d00 <end_op>
    cprintf("exec: fail\n");
80100bba:	c7 04 24 c1 88 10 80 	movl   $0x801088c1,(%esp)
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
80100be7:	e8 34 7a 00 00       	call   80108620 <clearpteu>
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
80100c18:	e8 43 52 00 00       	call   80105e60 <strlen>
80100c1d:	f7 d0                	not    %eax
80100c1f:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c21:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c24:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c27:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c2a:	89 04 24             	mov    %eax,(%esp)
80100c2d:	e8 2e 52 00 00       	call   80105e60 <strlen>
80100c32:	40                   	inc    %eax
80100c33:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c37:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c3a:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c3d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100c41:	89 34 24             	mov    %esi,(%esp)
80100c44:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c48:	e8 43 7b 00 00       	call   80108790 <copyout>
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
80100cb8:	e8 d3 7a 00 00       	call   80108790 <copyout>
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
80100d01:	e8 1a 51 00 00       	call   80105e20 <safestrcpy>
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
80100d2b:	e8 20 74 00 00       	call   80108150 <switchuvm>
  freevm(oldpgdir);
80100d30:	89 3c 24             	mov    %edi,(%esp)
80100d33:	e8 c8 77 00 00       	call   80108500 <freevm>
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
80100d51:	b8 cd 88 10 80       	mov    $0x801088cd,%eax
{
80100d56:	89 e5                	mov    %esp,%ebp
80100d58:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100d5b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100d5f:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
80100d66:	e8 95 4c 00 00       	call   80105a00 <initlock>
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
80100d83:	e8 c8 4d 00 00       	call   80105b50 <acquire>
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
80100db0:	e8 3b 4e 00 00       	call   80105bf0 <release>
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
80100dc9:	e8 22 4e 00 00       	call   80105bf0 <release>
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
80100df1:	e8 5a 4d 00 00       	call   80105b50 <acquire>
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
80100e08:	e8 e3 4d 00 00       	call   80105bf0 <release>
  return f;
}
80100e0d:	83 c4 14             	add    $0x14,%esp
80100e10:	89 d8                	mov    %ebx,%eax
80100e12:	5b                   	pop    %ebx
80100e13:	5d                   	pop    %ebp
80100e14:	c3                   	ret    
    panic("filedup");
80100e15:	c7 04 24 d4 88 10 80 	movl   $0x801088d4,(%esp)
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
80100e49:	e8 02 4d 00 00       	call   80105b50 <acquire>
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
80100e74:	e9 77 4d 00 00       	jmp    80105bf0 <release>
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
80100e9f:	e8 4c 4d 00 00       	call   80105bf0 <release>
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
80100ef9:	c7 04 24 dc 88 10 80 	movl   $0x801088dc,(%esp)
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
80100ff7:	c7 04 24 e6 88 10 80 	movl   $0x801088e6,(%esp)
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
80101112:	c7 04 24 ef 88 10 80 	movl   $0x801088ef,(%esp)
80101119:	e8 52 f2 ff ff       	call   80100370 <panic>
  panic("filewrite");
8010111e:	c7 04 24 f5 88 10 80 	movl   $0x801088f5,(%esp)
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
801011c8:	c7 04 24 ff 88 10 80 	movl   $0x801088ff,(%esp)
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
80101218:	e8 23 4a 00 00       	call   80105c40 <memset>
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
8010125c:	e8 ef 48 00 00       	call   80105b50 <acquire>
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
801012be:	e8 2d 49 00 00       	call   80105bf0 <release>

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
801012e2:	e8 09 49 00 00       	call   80105bf0 <release>
}
801012e7:	83 c4 2c             	add    $0x2c,%esp
801012ea:	89 f0                	mov    %esi,%eax
801012ec:	5b                   	pop    %ebx
801012ed:	5e                   	pop    %esi
801012ee:	5f                   	pop    %edi
801012ef:	5d                   	pop    %ebp
801012f0:	c3                   	ret    
    panic("iget: no inodes");
801012f1:	c7 04 24 15 89 10 80 	movl   $0x80108915,(%esp)
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
801013c1:	c7 04 24 25 89 10 80 	movl   $0x80108925,(%esp)
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
80101408:	e8 f3 48 00 00       	call   80105d00 <memmove>
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
80101497:	c7 04 24 38 89 10 80 	movl   $0x80108938,(%esp)
8010149e:	e8 cd ee ff ff       	call   80100370 <panic>
801014a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801014a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801014b0 <iinit>:
{
801014b0:	55                   	push   %ebp
  initlock(&icache.lock, "icache");
801014b1:	b9 4b 89 10 80       	mov    $0x8010894b,%ecx
{
801014b6:	89 e5                	mov    %esp,%ebp
801014b8:	53                   	push   %ebx
801014b9:	bb 80 2a 11 80       	mov    $0x80112a80,%ebx
801014be:	83 ec 24             	sub    $0x24,%esp
  initlock(&icache.lock, "icache");
801014c1:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801014c5:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
801014cc:	e8 2f 45 00 00       	call   80105a00 <initlock>
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
801014e0:	ba 52 89 10 80       	mov    $0x80108952,%edx
801014e5:	89 1c 24             	mov    %ebx,(%esp)
801014e8:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014ee:	89 54 24 04          	mov    %edx,0x4(%esp)
801014f2:	e8 d9 43 00 00       	call   801058d0 <initsleeplock>
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
80101518:	c7 04 24 b8 89 10 80 	movl   $0x801089b8,(%esp)
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
801015f3:	e8 48 46 00 00       	call   80105c40 <memset>
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
80101621:	c7 04 24 58 89 10 80 	movl   $0x80108958,(%esp)
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
801016a2:	e8 59 46 00 00       	call   80105d00 <memmove>
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
801016d1:	e8 7a 44 00 00       	call   80105b50 <acquire>
  ip->ref++;
801016d6:	ff 43 08             	incl   0x8(%ebx)
  release(&icache.lock);
801016d9:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
801016e0:	e8 0b 45 00 00       	call   80105bf0 <release>
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
80101714:	e8 f7 41 00 00       	call   80105910 <acquiresleep>
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
80101796:	e8 65 45 00 00       	call   80105d00 <memmove>
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
801017b5:	c7 04 24 70 89 10 80 	movl   $0x80108970,(%esp)
801017bc:	e8 af eb ff ff       	call   80100370 <panic>
    panic("ilock");
801017c1:	c7 04 24 6a 89 10 80 	movl   $0x8010896a,(%esp)
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
801017e9:	e8 c2 41 00 00       	call   801059b0 <holdingsleep>
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
80101805:	e9 66 41 00 00       	jmp    80105970 <releasesleep>
    panic("iunlock");
8010180a:	c7 04 24 7f 89 10 80 	movl   $0x8010897f,(%esp)
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
80101838:	e8 d3 40 00 00       	call   80105910 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
8010183d:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101840:	85 d2                	test   %edx,%edx
80101842:	74 07                	je     8010184b <iput+0x2b>
80101844:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101849:	74 35                	je     80101880 <iput+0x60>
  releasesleep(&ip->lock);
8010184b:	89 3c 24             	mov    %edi,(%esp)
8010184e:	e8 1d 41 00 00       	call   80105970 <releasesleep>
  acquire(&icache.lock);
80101853:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
8010185a:	e8 f1 42 00 00       	call   80105b50 <acquire>
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
80101875:	e9 76 43 00 00       	jmp    80105bf0 <release>
8010187a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101880:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101887:	e8 c4 42 00 00       	call   80105b50 <acquire>
    int r = ip->ref;
8010188c:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
8010188f:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101896:	e8 55 43 00 00       	call   80105bf0 <release>
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
80101a83:	e8 78 42 00 00       	call   80105d00 <memmove>
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
80101baf:	e8 4c 41 00 00       	call   80105d00 <memmove>
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
80101c5c:	e8 ff 40 00 00       	call   80105d60 <strncmp>
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
80101cdb:	e8 80 40 00 00       	call   80105d60 <strncmp>
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
80101d1f:	c7 04 24 99 89 10 80 	movl   $0x80108999,(%esp)
80101d26:	e8 45 e6 ff ff       	call   80100370 <panic>
    panic("dirlookup not DIR");
80101d2b:	c7 04 24 87 89 10 80 	movl   $0x80108987,(%esp)
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
80101d59:	e8 52 1d 00 00       	call   80103ab0 <myproc>
80101d5e:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101d61:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101d68:	e8 e3 3d 00 00       	call   80105b50 <acquire>
  ip->ref++;
80101d6d:	ff 46 08             	incl   0x8(%esi)
  release(&icache.lock);
80101d70:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101d77:	e8 74 3e 00 00       	call   80105bf0 <release>
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
80101ddc:	e8 1f 3f 00 00       	call   80105d00 <memmove>
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
80101e65:	e8 96 3e 00 00       	call   80105d00 <memmove>
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
80101f73:	e8 48 3e 00 00       	call   80105dc0 <strncpy>
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
80101fb6:	c7 04 24 a8 89 10 80 	movl   $0x801089a8,(%esp)
80101fbd:	e8 ae e3 ff ff       	call   80100370 <panic>
    panic("dirlink");
80101fc2:	c7 04 24 4e 90 10 80 	movl   $0x8010904e,(%esp)
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
801020bc:	c7 04 24 14 8a 10 80 	movl   $0x80108a14,(%esp)
801020c3:	e8 a8 e2 ff ff       	call   80100370 <panic>
    panic("idestart");
801020c8:	c7 04 24 0b 8a 10 80 	movl   $0x80108a0b,(%esp)
801020cf:	e8 9c e2 ff ff       	call   80100370 <panic>
801020d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801020da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801020e0 <ideinit>:
{
801020e0:	55                   	push   %ebp
  initlock(&idelock, "ide");
801020e1:	ba 26 8a 10 80       	mov    $0x80108a26,%edx
{
801020e6:	89 e5                	mov    %esp,%ebp
801020e8:	83 ec 18             	sub    $0x18,%esp
  initlock(&idelock, "ide");
801020eb:	89 54 24 04          	mov    %edx,0x4(%esp)
801020ef:	c7 04 24 80 c5 10 80 	movl   $0x8010c580,(%esp)
801020f6:	e8 05 39 00 00       	call   80105a00 <initlock>
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
80102176:	e8 d5 39 00 00       	call   80105b50 <acquire>

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
801021ce:	e8 4d 24 00 00       	call   80104620 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801021d3:	a1 64 c5 10 80       	mov    0x8010c564,%eax
801021d8:	85 c0                	test   %eax,%eax
801021da:	74 05                	je     801021e1 <ideintr+0x81>
    idestart(idequeue);
801021dc:	e8 2f fe ff ff       	call   80102010 <idestart>
    release(&idelock);
801021e1:	c7 04 24 80 c5 10 80 	movl   $0x8010c580,(%esp)
801021e8:	e8 03 3a 00 00       	call   80105bf0 <release>

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
80102210:	e8 9b 37 00 00       	call   801059b0 <holdingsleep>
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
80102247:	e8 04 39 00 00       	call   80105b50 <acquire>

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
8010228c:	e8 6f 21 00 00       	call   80104400 <sleep>
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
801022a7:	e9 44 39 00 00       	jmp    80105bf0 <release>
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
801022c7:	c7 04 24 40 8a 10 80 	movl   $0x80108a40,(%esp)
801022ce:	e8 9d e0 ff ff       	call   80100370 <panic>
    panic("iderw: buf not locked");
801022d3:	c7 04 24 2a 8a 10 80 	movl   $0x80108a2a,(%esp)
801022da:	e8 91 e0 ff ff       	call   80100370 <panic>
    panic("iderw: ide disk 1 not present");
801022df:	c7 04 24 55 8a 10 80 	movl   $0x80108a55,(%esp)
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
80102338:	c7 04 24 74 8a 10 80 	movl   $0x80108a74,(%esp)
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
80102420:	e8 1b 38 00 00       	call   80105c40 <memset>

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
8010245c:	e9 8f 37 00 00       	jmp    80105bf0 <release>
80102461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&kmem.lock);
80102468:	c7 04 24 a0 46 11 80 	movl   $0x801146a0,(%esp)
8010246f:	e8 dc 36 00 00       	call   80105b50 <acquire>
80102474:	eb b8                	jmp    8010242e <kfree+0x4e>
    panic("kfree");
80102476:	c7 04 24 a6 8a 10 80 	movl   $0x80108aa6,(%esp)
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
801024e1:	b8 ac 8a 10 80       	mov    $0x80108aac,%eax
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
801024fb:	e8 00 35 00 00       	call   80105a00 <initlock>
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
801025e5:	e8 66 35 00 00       	call   80105b50 <acquire>
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
8010260f:	e8 dc 35 00 00       	call   80105bf0 <release>
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
80102664:	0f b6 8a e0 8b 10 80 	movzbl -0x7fef7420(%edx),%ecx
  shift ^= togglecode[data];
8010266b:	0f b6 82 e0 8a 10 80 	movzbl -0x7fef7520(%edx),%eax
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
8010267e:	8b 04 85 c0 8a 10 80 	mov    -0x7fef7540(,%eax,4),%eax
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
801026b9:	0f b6 82 e0 8b 10 80 	movzbl -0x7fef7420(%edx),%eax
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
80102a20:	e8 7b 32 00 00       	call   80105ca0 <memcmp>
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
80102b3c:	e8 bf 31 00 00       	call   80105d00 <memmove>
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
80102bf1:	ba e0 8c 10 80       	mov    $0x80108ce0,%edx
{
80102bf6:	89 e5                	mov    %esp,%ebp
80102bf8:	53                   	push   %ebx
80102bf9:	83 ec 34             	sub    $0x34,%esp
80102bfc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102bff:	89 54 24 04          	mov    %edx,0x4(%esp)
80102c03:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102c0a:	e8 f1 2d 00 00       	call   80105a00 <initlock>
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
80102c9d:	e8 ae 2e 00 00       	call   80105b50 <acquire>
80102ca2:	eb 19                	jmp    80102cbd <begin_op+0x2d>
80102ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102ca8:	b8 e0 46 11 80       	mov    $0x801146e0,%eax
80102cad:	89 44 24 04          	mov    %eax,0x4(%esp)
80102cb1:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102cb8:	e8 43 17 00 00       	call   80104400 <sleep>
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
80102cea:	e8 01 2f 00 00       	call   80105bf0 <release>
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
80102d10:	e8 3b 2e 00 00       	call   80105b50 <acquire>
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
80102d4a:	e8 a1 2e 00 00       	call   80105bf0 <release>
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
80102da9:	e8 52 2f 00 00       	call   80105d00 <memmove>
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
80102dec:	e8 5f 2d 00 00       	call   80105b50 <acquire>
    log.committing = 0;
80102df1:	31 c0                	xor    %eax,%eax
80102df3:	a3 20 47 11 80       	mov    %eax,0x80114720
    wakeup(&log);
80102df8:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102dff:	e8 1c 18 00 00       	call   80104620 <wakeup>
    release(&log.lock);
80102e04:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102e0b:	e8 e0 2d 00 00       	call   80105bf0 <release>
}
80102e10:	83 c4 1c             	add    $0x1c,%esp
80102e13:	5b                   	pop    %ebx
80102e14:	5e                   	pop    %esi
80102e15:	5f                   	pop    %edi
80102e16:	5d                   	pop    %ebp
80102e17:	c3                   	ret    
    panic("log.committing");
80102e18:	c7 04 24 e4 8c 10 80 	movl   $0x80108ce4,(%esp)
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
80102e6b:	e8 e0 2c 00 00       	call   80105b50 <acquire>
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
80102eba:	e9 31 2d 00 00       	jmp    80105bf0 <release>
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
80102ede:	c7 04 24 f3 8c 10 80 	movl   $0x80108cf3,(%esp)
80102ee5:	e8 86 d4 ff ff       	call   80100370 <panic>
    panic("log_write outside of trans");
80102eea:	c7 04 24 09 8d 10 80 	movl   $0x80108d09,(%esp)
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
80102f07:	e8 24 52 00 00       	call   80108130 <switchkvm>
  seginit();
80102f0c:	e8 8f 51 00 00       	call   801080a0 <seginit>
  lapicinit();
80102f11:	e8 1a f8 ff ff       	call   80102730 <lapicinit>
}

static void
mpmain(void) //called by the non-boot AP cpus
{
  struct cpu* c = mycpu();
80102f16:	e8 f5 0a 00 00       	call   80103a10 <mycpu>
80102f1b:	89 c3                	mov    %eax,%ebx
  cprintf("cpu%d: is witing for the \"pioneer\" cpu to finish its initialization.\n", cpuid());
80102f1d:	e8 6e 0b 00 00       	call   80103a90 <cpuid>
80102f22:	c7 04 24 24 8d 10 80 	movl   $0x80108d24,(%esp)
80102f29:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f2d:	e8 1e d7 ff ff       	call   80100650 <cprintf>
  idtinit();       // load idt register
80102f32:	e8 a9 40 00 00       	call   80106fe0 <idtinit>
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
80102f5a:	e8 31 0b 00 00       	call   80103a90 <cpuid>
80102f5f:	89 c3                	mov    %eax,%ebx
80102f61:	e8 2a 0b 00 00       	call   80103a90 <cpuid>
80102f66:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80102f6a:	c7 04 24 74 8d 10 80 	movl   $0x80108d74,(%esp)
80102f71:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f75:	e8 d6 d6 ff ff       	call   80100650 <cprintf>
  scheduler();     // start running processes
80102f7a:	e8 d1 0f 00 00       	call   80103f50 <scheduler>
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
80102f9f:	e8 5c 56 00 00       	call   80108600 <kvmalloc>
  mpinit();        // detect other processors
80102fa4:	e8 17 02 00 00       	call   801031c0 <mpinit>
  lapicinit();     // interrupt controller
80102fa9:	e8 82 f7 ff ff       	call   80102730 <lapicinit>
80102fae:	66 90                	xchg   %ax,%ax
  seginit();       // segment descriptors
80102fb0:	e8 eb 50 00 00       	call   801080a0 <seginit>
  picinit();       // disable pic
80102fb5:	e8 e6 03 00 00       	call   801033a0 <picinit>
  ioapicinit();    // another interrupt controller
80102fba:	e8 31 f3 ff ff       	call   801022f0 <ioapicinit>
80102fbf:	90                   	nop
  consoleinit();   // console hardware
80102fc0:	e8 bb d9 ff ff       	call   80100980 <consoleinit>
  uartinit();      // serial port
80102fc5:	e8 a6 43 00 00       	call   80107370 <uartinit>
  pinit();         // process table
80102fca:	e8 21 0a 00 00       	call   801039f0 <pinit>
80102fcf:	90                   	nop
  tvinit();        // trap vectors
80102fd0:	e8 8b 3f 00 00       	call   80106f60 <tvinit>
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
80102ffe:	e8 fd 2c 00 00       	call   80105d00 <memmove>

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
80103030:	e8 db 09 00 00       	call   80103a10 <mycpu>
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
801030bc:	e8 af 1d 00 00       	call   80104e70 <initSchedDS>
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
80103103:	e8 d8 0a 00 00       	call   80103be0 <userinit>
  cprintf("\"pioneer\" cpu%d: starting %d\n", cpuid(), cpuid());
80103108:	e8 83 09 00 00       	call   80103a90 <cpuid>
8010310d:	89 c3                	mov    %eax,%ebx
8010310f:	e8 7c 09 00 00       	call   80103a90 <cpuid>
80103114:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80103118:	c7 04 24 6a 8d 10 80 	movl   $0x80108d6a,(%esp)
8010311f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103123:	e8 28 d5 ff ff       	call   80100650 <cprintf>
  idtinit();       // load idt register
80103128:	e8 b3 3e 00 00       	call   80106fe0 <idtinit>
  scheduler();     // start running processes
8010312d:	e8 1e 0e 00 00       	call   80103f50 <scheduler>
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
80103166:	ba 88 8d 10 80       	mov    $0x80108d88,%edx
8010316b:	b8 04 00 00 00       	mov    $0x4,%eax
80103170:	89 54 24 04          	mov    %edx,0x4(%esp)
80103174:	89 44 24 08          	mov    %eax,0x8(%esp)
80103178:	89 34 24             	mov    %esi,(%esp)
8010317b:	e8 20 2b 00 00       	call   80105ca0 <memcmp>
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
80103224:	ba a5 8d 10 80       	mov    $0x80108da5,%edx
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103229:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
8010322f:	89 44 24 08          	mov    %eax,0x8(%esp)
80103233:	89 54 24 04          	mov    %edx,0x4(%esp)
80103237:	89 34 24             	mov    %esi,(%esp)
8010323a:	e8 61 2a 00 00       	call   80105ca0 <memcmp>
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
801032cf:	ff 24 85 cc 8d 10 80 	jmp    *-0x7fef7234(,%eax,4)
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
80103380:	c7 04 24 8d 8d 10 80 	movl   $0x80108d8d,(%esp)
80103387:	e8 e4 cf ff ff       	call   80100370 <panic>
    panic("Didn't find a suitable machine");
8010338c:	c7 04 24 ac 8d 10 80 	movl   $0x80108dac,(%esp)
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
80103460:	ba e0 8d 10 80       	mov    $0x80108de0,%edx
  p->nread = 0;
80103465:	89 88 34 02 00 00    	mov    %ecx,0x234(%eax)
  initlock(&p->lock, "pipe");
8010346b:	89 54 24 04          	mov    %edx,0x4(%esp)
8010346f:	89 04 24             	mov    %eax,(%esp)
80103472:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103475:	e8 86 25 00 00       	call   80105a00 <initlock>
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
801034d5:	e8 76 26 00 00       	call   80105b50 <acquire>
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
801034ef:	e8 2c 11 00 00       	call   80104620 <wakeup>
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
80103514:	e9 d7 26 00 00       	jmp    80105bf0 <release>
80103519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->readopen = 0;
80103520:	31 c9                	xor    %ecx,%ecx
    wakeup(&p->nwrite);
80103522:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103528:	89 8b 3c 02 00 00    	mov    %ecx,0x23c(%ebx)
    wakeup(&p->nwrite);
8010352e:	89 04 24             	mov    %eax,(%esp)
80103531:	e8 ea 10 00 00       	call   80104620 <wakeup>
80103536:	eb bc                	jmp    801034f4 <pipeclose+0x34>
80103538:	90                   	nop
80103539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103540:	89 1c 24             	mov    %ebx,(%esp)
80103543:	e8 a8 26 00 00       	call   80105bf0 <release>
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
8010356f:	e8 dc 25 00 00       	call   80105b50 <acquire>
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
801035c3:	e8 58 10 00 00       	call   80104620 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035c8:	89 7c 24 04          	mov    %edi,0x4(%esp)
801035cc:	89 1c 24             	mov    %ebx,(%esp)
801035cf:	e8 2c 0e 00 00       	call   80104400 <sleep>
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
801035f3:	e8 b8 04 00 00       	call   80103ab0 <myproc>
801035f8:	8b 50 24             	mov    0x24(%eax),%edx
801035fb:	85 d2                	test   %edx,%edx
801035fd:	74 c1                	je     801035c0 <pipewrite+0x60>
        release(&p->lock);
801035ff:	89 3c 24             	mov    %edi,(%esp)
80103602:	e8 e9 25 00 00       	call   80105bf0 <release>
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
8010364f:	e8 cc 0f 00 00       	call   80104620 <wakeup>
  release(&p->lock);
80103654:	89 3c 24             	mov    %edi,(%esp)
80103657:	e8 94 25 00 00       	call   80105bf0 <release>
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
80103682:	e8 c9 24 00 00       	call   80105b50 <acquire>
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
801036b7:	e8 44 0d 00 00       	call   80104400 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036bc:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801036c2:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801036c8:	75 36                	jne    80103700 <piperead+0x90>
801036ca:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
801036d0:	85 d2                	test   %edx,%edx
801036d2:	0f 84 88 00 00 00    	je     80103760 <piperead+0xf0>
    if(myproc()->killed){
801036d8:	e8 d3 03 00 00       	call   80103ab0 <myproc>
801036dd:	8b 48 24             	mov    0x24(%eax),%ecx
801036e0:	85 c9                	test   %ecx,%ecx
801036e2:	74 cc                	je     801036b0 <piperead+0x40>
      release(&p->lock);
801036e4:	89 34 24             	mov    %esi,(%esp)
      return -1;
801036e7:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801036ec:	e8 ff 24 00 00       	call   80105bf0 <release>
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
80103744:	e8 d7 0e 00 00       	call   80104620 <wakeup>
  release(&p->lock);
80103749:	89 34 24             	mov    %esi,(%esp)
8010374c:	e8 9f 24 00 00       	call   80105bf0 <release>
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
80103783:	e8 c8 23 00 00       	call   80105b50 <acquire>
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
    //TODO we can do ctime here;

    release(&ptable.lock);
801037bb:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
    p->pid = nextpid++;
801037c2:	89 15 08 c0 10 80    	mov    %edx,0x8010c008
    release(&ptable.lock);
801037c8:	e8 23 24 00 00       	call   80105bf0 <release>

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
801037e7:	ba 4f 6f 10 80       	mov    $0x80106f4f,%edx
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
80103804:	e8 37 24 00 00       	call   80105c40 <memset>
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
80103829:	e8 c2 23 00 00       	call   80105bf0 <release>
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
8010385d:	e8 8e 23 00 00       	call   80105bf0 <release>

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
    long long tmp1=0,tmp2=0;
801038ca:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
801038d1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
801038d8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801038df:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
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

80103960 <update_procs_performances>:
{
80103960:	55                   	push   %ebp
80103961:	89 e5                	mov    %esp,%ebp
80103963:	83 ec 18             	sub    $0x18,%esp
    counter++;
80103966:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
8010396b:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
    acquire(&ptable.lock);
80103971:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
    counter++;
80103978:	83 c0 01             	add    $0x1,%eax
8010397b:	83 d2 00             	adc    $0x0,%edx
8010397e:	a3 b8 c5 10 80       	mov    %eax,0x8010c5b8
80103983:	89 15 bc c5 10 80    	mov    %edx,0x8010c5bc
    acquire(&ptable.lock);
80103989:	e8 c2 21 00 00       	call   80105b50 <acquire>
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010398e:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
80103993:	eb 1f                	jmp    801039b4 <update_procs_performances+0x54>
80103995:	8d 76 00             	lea    0x0(%esi),%esi
        switch(p->state){
80103998:	83 fa 04             	cmp    $0x4,%edx
8010399b:	74 43                	je     801039e0 <update_procs_performances+0x80>
8010399d:	83 fa 02             	cmp    $0x2,%edx
801039a0:	75 06                	jne    801039a8 <update_procs_performances+0x48>
                p->proc_perf.stime++;
801039a2:	ff 80 94 00 00 00    	incl   0x94(%eax)
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801039a8:	05 a8 00 00 00       	add    $0xa8,%eax
801039ad:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
801039b2:	73 1a                	jae    801039ce <update_procs_performances+0x6e>
        switch(p->state){
801039b4:	8b 50 0c             	mov    0xc(%eax),%edx
801039b7:	83 fa 03             	cmp    $0x3,%edx
801039ba:	75 dc                	jne    80103998 <update_procs_performances+0x38>
                p->proc_perf.retime++;
801039bc:	ff 80 98 00 00 00    	incl   0x98(%eax)
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801039c2:	05 a8 00 00 00       	add    $0xa8,%eax
801039c7:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
801039cc:	72 e6                	jb     801039b4 <update_procs_performances+0x54>
    release(&ptable.lock);
801039ce:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801039d5:	e8 16 22 00 00       	call   80105bf0 <release>
}
801039da:	c9                   	leave  
801039db:	c3                   	ret    
801039dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                p->proc_perf.rutime++;
801039e0:	ff 80 9c 00 00 00    	incl   0x9c(%eax)
                break;
801039e6:	eb c0                	jmp    801039a8 <update_procs_performances+0x48>
801039e8:	90                   	nop
801039e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801039f0 <pinit>:
{
801039f0:	55                   	push   %ebp
    initlock(&ptable.lock, "ptable");
801039f1:	b8 e5 8d 10 80       	mov    $0x80108de5,%eax
{
801039f6:	89 e5                	mov    %esp,%ebp
801039f8:	83 ec 18             	sub    $0x18,%esp
    initlock(&ptable.lock, "ptable");
801039fb:	89 44 24 04          	mov    %eax,0x4(%esp)
801039ff:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103a06:	e8 f5 1f 00 00       	call   80105a00 <initlock>
}
80103a0b:	c9                   	leave  
80103a0c:	c3                   	ret    
80103a0d:	8d 76 00             	lea    0x0(%esi),%esi

80103a10 <mycpu>:
{
80103a10:	55                   	push   %ebp
80103a11:	89 e5                	mov    %esp,%ebp
80103a13:	56                   	push   %esi
80103a14:	53                   	push   %ebx
80103a15:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103a18:	9c                   	pushf  
80103a19:	58                   	pop    %eax
    if(readeflags()&FL_IF)
80103a1a:	f6 c4 02             	test   $0x2,%ah
80103a1d:	75 5b                	jne    80103a7a <mycpu+0x6a>
    apicid = lapicid();
80103a1f:	e8 0c ee ff ff       	call   80102830 <lapicid>
    for (i = 0; i < ncpu; ++i) {
80103a24:	8b 35 60 4d 11 80    	mov    0x80114d60,%esi
80103a2a:	85 f6                	test   %esi,%esi
80103a2c:	7e 40                	jle    80103a6e <mycpu+0x5e>
        if (cpus[i].apicid == apicid)
80103a2e:	0f b6 15 e0 47 11 80 	movzbl 0x801147e0,%edx
80103a35:	39 d0                	cmp    %edx,%eax
80103a37:	74 2e                	je     80103a67 <mycpu+0x57>
80103a39:	b9 90 48 11 80       	mov    $0x80114890,%ecx
    for (i = 0; i < ncpu; ++i) {
80103a3e:	31 d2                	xor    %edx,%edx
80103a40:	42                   	inc    %edx
80103a41:	39 f2                	cmp    %esi,%edx
80103a43:	74 29                	je     80103a6e <mycpu+0x5e>
        if (cpus[i].apicid == apicid)
80103a45:	0f b6 19             	movzbl (%ecx),%ebx
80103a48:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103a4e:	39 c3                	cmp    %eax,%ebx
80103a50:	75 ee                	jne    80103a40 <mycpu+0x30>
80103a52:	8d 04 92             	lea    (%edx,%edx,4),%eax
80103a55:	8d 04 42             	lea    (%edx,%eax,2),%eax
80103a58:	c1 e0 04             	shl    $0x4,%eax
80103a5b:	05 e0 47 11 80       	add    $0x801147e0,%eax
}
80103a60:	83 c4 10             	add    $0x10,%esp
80103a63:	5b                   	pop    %ebx
80103a64:	5e                   	pop    %esi
80103a65:	5d                   	pop    %ebp
80103a66:	c3                   	ret    
        if (cpus[i].apicid == apicid)
80103a67:	b8 e0 47 11 80       	mov    $0x801147e0,%eax
            return &cpus[i];
80103a6c:	eb f2                	jmp    80103a60 <mycpu+0x50>
    panic("unknown apicid\n");
80103a6e:	c7 04 24 ec 8d 10 80 	movl   $0x80108dec,(%esp)
80103a75:	e8 f6 c8 ff ff       	call   80100370 <panic>
        panic("mycpu called with interrupts enabled\n");
80103a7a:	c7 04 24 e0 8e 10 80 	movl   $0x80108ee0,(%esp)
80103a81:	e8 ea c8 ff ff       	call   80100370 <panic>
80103a86:	8d 76 00             	lea    0x0(%esi),%esi
80103a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a90 <cpuid>:
cpuid() {
80103a90:	55                   	push   %ebp
80103a91:	89 e5                	mov    %esp,%ebp
80103a93:	83 ec 08             	sub    $0x8,%esp
    return mycpu()-cpus;
80103a96:	e8 75 ff ff ff       	call   80103a10 <mycpu>
}
80103a9b:	c9                   	leave  
    return mycpu()-cpus;
80103a9c:	2d e0 47 11 80       	sub    $0x801147e0,%eax
80103aa1:	c1 f8 04             	sar    $0x4,%eax
80103aa4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103aaa:	c3                   	ret    
80103aab:	90                   	nop
80103aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103ab0 <myproc>:
myproc(void) {
80103ab0:	55                   	push   %ebp
80103ab1:	89 e5                	mov    %esp,%ebp
80103ab3:	53                   	push   %ebx
80103ab4:	83 ec 04             	sub    $0x4,%esp
    pushcli();
80103ab7:	e8 b4 1f 00 00       	call   80105a70 <pushcli>
    c = mycpu();
80103abc:	e8 4f ff ff ff       	call   80103a10 <mycpu>
    p = c->proc;
80103ac1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
80103ac7:	e8 e4 1f 00 00       	call   80105ab0 <popcli>
}
80103acc:	5a                   	pop    %edx
80103acd:	89 d8                	mov    %ebx,%eax
80103acf:	5b                   	pop    %ebx
80103ad0:	5d                   	pop    %ebp
80103ad1:	c3                   	ret    
80103ad2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ae0 <updateAccumulator>:
updateAccumulator (struct proc* p){
80103ae0:	55                   	push   %ebp
80103ae1:	89 e5                	mov    %esp,%ebp
80103ae3:	83 ec 08             	sub    $0x8,%esp
    if(pq.isEmpty()&&rpholder.isEmpty()) //if the only process -> acc=0
80103ae6:	ff 15 e4 c5 10 80    	call   *0x8010c5e4
80103aec:	85 c0                	test   %eax,%eax
80103aee:	74 0a                	je     80103afa <updateAccumulator+0x1a>
80103af0:	ff 15 c4 c5 10 80    	call   *0x8010c5c4
80103af6:	85 c0                	test   %eax,%eax
80103af8:	75 26                	jne    80103b20 <updateAccumulator+0x40>
80103afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        p->accumulator=getMinAccumulator();
80103b00:	e8 bb fd ff ff       	call   801038c0 <getMinAccumulator>
80103b05:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103b08:	89 81 80 00 00 00    	mov    %eax,0x80(%ecx)
80103b0e:	89 91 84 00 00 00    	mov    %edx,0x84(%ecx)
}
80103b14:	c9                   	leave  
80103b15:	c3                   	ret    
80103b16:	8d 76 00             	lea    0x0(%esi),%esi
80103b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        p->accumulator=0;
80103b20:	8b 45 08             	mov    0x8(%ebp),%eax
80103b23:	31 d2                	xor    %edx,%edx
80103b25:	31 c9                	xor    %ecx,%ecx
80103b27:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
80103b2d:	89 88 84 00 00 00    	mov    %ecx,0x84(%eax)
}
80103b33:	c9                   	leave  
80103b34:	c3                   	ret    
80103b35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b40 <pushToSpecificQueue>:
    switch (currpolicy) {
80103b40:	a1 04 c0 10 80       	mov    0x8010c004,%eax
pushToSpecificQueue(struct proc* p) {
80103b45:	55                   	push   %ebp
80103b46:	89 e5                	mov    %esp,%ebp
    switch (currpolicy) {
80103b48:	83 f8 02             	cmp    $0x2,%eax
80103b4b:	74 13                	je     80103b60 <pushToSpecificQueue+0x20>
80103b4d:	83 f8 03             	cmp    $0x3,%eax
80103b50:	74 0e                	je     80103b60 <pushToSpecificQueue+0x20>
80103b52:	48                   	dec    %eax
80103b53:	74 1b                	je     80103b70 <pushToSpecificQueue+0x30>
}
80103b55:	5d                   	pop    %ebp
80103b56:	c3                   	ret    
80103b57:	89 f6                	mov    %esi,%esi
80103b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80103b60:	5d                   	pop    %ebp
            pq.put(p);
80103b61:	ff 25 e8 c5 10 80    	jmp    *0x8010c5e8
80103b67:	89 f6                	mov    %esi,%esi
80103b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80103b70:	5d                   	pop    %ebp
            rrq.enqueue(p);
80103b71:	ff 25 d8 c5 10 80    	jmp    *0x8010c5d8
80103b77:	89 f6                	mov    %esi,%esi
80103b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b80 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80103b80:	55                   	push   %ebp
80103b81:	89 e5                	mov    %esp,%ebp
80103b83:	56                   	push   %esi
80103b84:	89 c6                	mov    %eax,%esi
80103b86:	53                   	push   %ebx
    struct proc *p;

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103b87:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
{
80103b8c:	83 ec 10             	sub    $0x10,%esp
80103b8f:	eb 15                	jmp    80103ba6 <wakeup1+0x26>
80103b91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103b98:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80103b9e:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
80103ba4:	73 32                	jae    80103bd8 <wakeup1+0x58>
        if(p->state == SLEEPING && p->chan == chan){
80103ba6:	8b 53 0c             	mov    0xc(%ebx),%edx
80103ba9:	83 fa 02             	cmp    $0x2,%edx
80103bac:	75 ea                	jne    80103b98 <wakeup1+0x18>
80103bae:	39 73 20             	cmp    %esi,0x20(%ebx)
80103bb1:	75 e5                	jne    80103b98 <wakeup1+0x18>
            p->state = RUNNABLE;
            //update the accumulator field
            updateAccumulator(p);
80103bb3:	89 1c 24             	mov    %ebx,(%esp)
            p->state = RUNNABLE;
80103bb6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
            updateAccumulator(p);
80103bbd:	e8 1e ff ff ff       	call   80103ae0 <updateAccumulator>
            pushToSpecificQueue(p);
80103bc2:	89 1c 24             	mov    %ebx,(%esp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103bc5:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
            pushToSpecificQueue(p);
80103bcb:	e8 70 ff ff ff       	call   80103b40 <pushToSpecificQueue>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103bd0:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
80103bd6:	72 ce                	jb     80103ba6 <wakeup1+0x26>
        }
}
80103bd8:	83 c4 10             	add    $0x10,%esp
80103bdb:	5b                   	pop    %ebx
80103bdc:	5e                   	pop    %esi
80103bdd:	5d                   	pop    %ebp
80103bde:	c3                   	ret    
80103bdf:	90                   	nop

80103be0 <userinit>:
{
80103be0:	55                   	push   %ebp
80103be1:	89 e5                	mov    %esp,%ebp
80103be3:	53                   	push   %ebx
80103be4:	83 ec 14             	sub    $0x14,%esp
    p = allocproc();
80103be7:	e8 84 fb ff ff       	call   80103770 <allocproc>
80103bec:	89 c3                	mov    %eax,%ebx
    initproc = p;
80103bee:	a3 c0 c5 10 80       	mov    %eax,0x8010c5c0
    if((p->pgdir = setupkvm()) == 0)
80103bf3:	e8 88 49 00 00       	call   80108580 <setupkvm>
80103bf8:	85 c0                	test   %eax,%eax
80103bfa:	89 43 04             	mov    %eax,0x4(%ebx)
80103bfd:	0f 84 25 01 00 00    	je     80103d28 <userinit+0x148>
    inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103c03:	b9 60 c4 10 80       	mov    $0x8010c460,%ecx
80103c08:	ba 2c 00 00 00       	mov    $0x2c,%edx
80103c0d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80103c11:	89 54 24 08          	mov    %edx,0x8(%esp)
80103c15:	89 04 24             	mov    %eax,(%esp)
80103c18:	e8 33 46 00 00       	call   80108250 <inituvm>
    memset(p->tf, 0, sizeof(*p->tf));
80103c1d:	b8 4c 00 00 00       	mov    $0x4c,%eax
    p->sz = PGSIZE;
80103c22:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
    memset(p->tf, 0, sizeof(*p->tf));
80103c28:	89 44 24 08          	mov    %eax,0x8(%esp)
80103c2c:	31 c0                	xor    %eax,%eax
80103c2e:	89 44 24 04          	mov    %eax,0x4(%esp)
80103c32:	8b 43 18             	mov    0x18(%ebx),%eax
80103c35:	89 04 24             	mov    %eax,(%esp)
80103c38:	e8 03 20 00 00       	call   80105c40 <memset>
    p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103c3d:	8b 43 18             	mov    0x18(%ebx),%eax
80103c40:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
    p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103c46:	8b 43 18             	mov    0x18(%ebx),%eax
80103c49:	66 c7 40 2c 23 00    	movw   $0x23,0x2c(%eax)
    p->tf->es = p->tf->ds;
80103c4f:	8b 43 18             	mov    0x18(%ebx),%eax
80103c52:	8b 50 2c             	mov    0x2c(%eax),%edx
80103c55:	66 89 50 28          	mov    %dx,0x28(%eax)
    p->tf->ss = p->tf->ds;
80103c59:	8b 43 18             	mov    0x18(%ebx),%eax
80103c5c:	8b 50 2c             	mov    0x2c(%eax),%edx
80103c5f:	66 89 50 48          	mov    %dx,0x48(%eax)
    p->tf->eflags = FL_IF;
80103c63:	8b 43 18             	mov    0x18(%ebx),%eax
80103c66:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
    p->tf->esp = PGSIZE;
80103c6d:	8b 43 18             	mov    0x18(%ebx),%eax
80103c70:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
    p->tf->eip = 0;  // beginning of initcode.S
80103c77:	8b 43 18             	mov    0x18(%ebx),%eax
80103c7a:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
    safestrcpy(p->name, "initcode", sizeof(p->name));
80103c81:	b8 10 00 00 00       	mov    $0x10,%eax
80103c86:	89 44 24 08          	mov    %eax,0x8(%esp)
80103c8a:	b8 15 8e 10 80       	mov    $0x80108e15,%eax
80103c8f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103c93:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103c96:	89 04 24             	mov    %eax,(%esp)
80103c99:	e8 82 21 00 00       	call   80105e20 <safestrcpy>
    p->cwd = namei("/");
80103c9e:	c7 04 24 1e 8e 10 80 	movl   $0x80108e1e,(%esp)
80103ca5:	e8 26 e3 ff ff       	call   80101fd0 <namei>
80103caa:	89 43 68             	mov    %eax,0x68(%ebx)
    acquire(&ptable.lock);
80103cad:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103cb4:	e8 97 1e 00 00       	call   80105b50 <acquire>
    p->priority=5;
80103cb9:	b8 05 00 00 00       	mov    $0x5,%eax
    p->RUNNABLE_wait_time=0;    //surely 0 because this is the first initialized process
80103cbe:	31 d2                	xor    %edx,%edx
    p->priority=5;
80103cc0:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)
    p->RUNNABLE_wait_time=0;    //surely 0 because this is the first initialized process
80103cc6:	31 c0                	xor    %eax,%eax
    p->accumulator=0;          //surely 0 because this is the first initialized process
80103cc8:	31 c9                	xor    %ecx,%ecx
    p->RUNNABLE_wait_time=0;    //surely 0 because this is the first initialized process
80103cca:	89 83 a0 00 00 00    	mov    %eax,0xa0(%ebx)
    p->accumulator=0;          //surely 0 because this is the first initialized process
80103cd0:	31 c0                	xor    %eax,%eax
    p->RUNNABLE_wait_time=0;    //surely 0 because this is the first initialized process
80103cd2:	89 93 a4 00 00 00    	mov    %edx,0xa4(%ebx)
    p->accumulator=0;          //surely 0 because this is the first initialized process
80103cd8:	89 8b 80 00 00 00    	mov    %ecx,0x80(%ebx)
80103cde:	89 83 84 00 00 00    	mov    %eax,0x84(%ebx)
    p->state = RUNNABLE;
80103ce4:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
    acquire(&tickslock);
80103ceb:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80103cf2:	e8 59 1e 00 00       	call   80105b50 <acquire>
    p->proc_perf.ctime = ticks;
80103cf7:	a1 00 80 11 80       	mov    0x80118000,%eax
80103cfc:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
    release(&tickslock);
80103d02:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80103d09:	e8 e2 1e 00 00       	call   80105bf0 <release>
    pushToSpecificQueue(p);
80103d0e:	89 1c 24             	mov    %ebx,(%esp)
80103d11:	e8 2a fe ff ff       	call   80103b40 <pushToSpecificQueue>
    release(&ptable.lock);
80103d16:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103d1d:	e8 ce 1e 00 00       	call   80105bf0 <release>
}
80103d22:	83 c4 14             	add    $0x14,%esp
80103d25:	5b                   	pop    %ebx
80103d26:	5d                   	pop    %ebp
80103d27:	c3                   	ret    
        panic("userinit: out of memory?");
80103d28:	c7 04 24 fc 8d 10 80 	movl   $0x80108dfc,(%esp)
80103d2f:	e8 3c c6 ff ff       	call   80100370 <panic>
80103d34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103d3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103d40 <growproc>:
{
80103d40:	55                   	push   %ebp
80103d41:	89 e5                	mov    %esp,%ebp
80103d43:	56                   	push   %esi
80103d44:	53                   	push   %ebx
80103d45:	83 ec 10             	sub    $0x10,%esp
80103d48:	8b 75 08             	mov    0x8(%ebp),%esi
    pushcli();
80103d4b:	e8 20 1d 00 00       	call   80105a70 <pushcli>
    c = mycpu();
80103d50:	e8 bb fc ff ff       	call   80103a10 <mycpu>
    p = c->proc;
80103d55:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
80103d5b:	e8 50 1d 00 00       	call   80105ab0 <popcli>
    if(n > 0){
80103d60:	83 fe 00             	cmp    $0x0,%esi
    sz = curproc->sz;
80103d63:	8b 03                	mov    (%ebx),%eax
    if(n > 0){
80103d65:	7f 19                	jg     80103d80 <growproc+0x40>
    } else if(n < 0){
80103d67:	75 37                	jne    80103da0 <growproc+0x60>
    curproc->sz = sz;
80103d69:	89 03                	mov    %eax,(%ebx)
    switchuvm(curproc);
80103d6b:	89 1c 24             	mov    %ebx,(%esp)
80103d6e:	e8 dd 43 00 00       	call   80108150 <switchuvm>
    return 0;
80103d73:	31 c0                	xor    %eax,%eax
}
80103d75:	83 c4 10             	add    $0x10,%esp
80103d78:	5b                   	pop    %ebx
80103d79:	5e                   	pop    %esi
80103d7a:	5d                   	pop    %ebp
80103d7b:	c3                   	ret    
80103d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103d80:	01 c6                	add    %eax,%esi
80103d82:	89 74 24 08          	mov    %esi,0x8(%esp)
80103d86:	89 44 24 04          	mov    %eax,0x4(%esp)
80103d8a:	8b 43 04             	mov    0x4(%ebx),%eax
80103d8d:	89 04 24             	mov    %eax,(%esp)
80103d90:	e8 0b 46 00 00       	call   801083a0 <allocuvm>
80103d95:	85 c0                	test   %eax,%eax
80103d97:	75 d0                	jne    80103d69 <growproc+0x29>
            return -1;
80103d99:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103d9e:	eb d5                	jmp    80103d75 <growproc+0x35>
        if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103da0:	01 c6                	add    %eax,%esi
80103da2:	89 74 24 08          	mov    %esi,0x8(%esp)
80103da6:	89 44 24 04          	mov    %eax,0x4(%esp)
80103daa:	8b 43 04             	mov    0x4(%ebx),%eax
80103dad:	89 04 24             	mov    %eax,(%esp)
80103db0:	e8 1b 47 00 00       	call   801084d0 <deallocuvm>
80103db5:	85 c0                	test   %eax,%eax
80103db7:	75 b0                	jne    80103d69 <growproc+0x29>
80103db9:	eb de                	jmp    80103d99 <growproc+0x59>
80103dbb:	90                   	nop
80103dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103dc0 <fork>:
{
80103dc0:	55                   	push   %ebp
80103dc1:	89 e5                	mov    %esp,%ebp
80103dc3:	57                   	push   %edi
80103dc4:	56                   	push   %esi
80103dc5:	53                   	push   %ebx
80103dc6:	83 ec 1c             	sub    $0x1c,%esp
    pushcli();
80103dc9:	e8 a2 1c 00 00       	call   80105a70 <pushcli>
    c = mycpu();
80103dce:	e8 3d fc ff ff       	call   80103a10 <mycpu>
    p = c->proc;
80103dd3:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
    popcli();
80103dd9:	e8 d2 1c 00 00       	call   80105ab0 <popcli>
    if((np = allocproc()) == 0){
80103dde:	e8 8d f9 ff ff       	call   80103770 <allocproc>
80103de3:	85 c0                	test   %eax,%eax
80103de5:	0f 84 31 01 00 00    	je     80103f1c <fork+0x15c>
80103deb:	89 c6                	mov    %eax,%esi
    if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103ded:	8b 07                	mov    (%edi),%eax
80103def:	89 44 24 04          	mov    %eax,0x4(%esp)
80103df3:	8b 47 04             	mov    0x4(%edi),%eax
80103df6:	89 04 24             	mov    %eax,(%esp)
80103df9:	e8 52 48 00 00       	call   80108650 <copyuvm>
80103dfe:	85 c0                	test   %eax,%eax
80103e00:	89 46 04             	mov    %eax,0x4(%esi)
80103e03:	0f 84 1a 01 00 00    	je     80103f23 <fork+0x163>
    np->sz = curproc->sz;
80103e09:	8b 07                	mov    (%edi),%eax
    np->parent = curproc;
80103e0b:	89 7e 14             	mov    %edi,0x14(%esi)
    *np->tf = *curproc->tf;
80103e0e:	8b 56 18             	mov    0x18(%esi),%edx
    np->sz = curproc->sz;
80103e11:	89 06                	mov    %eax,(%esi)
    *np->tf = *curproc->tf;
80103e13:	31 c0                	xor    %eax,%eax
80103e15:	8b 4f 18             	mov    0x18(%edi),%ecx
80103e18:	8b 1c 01             	mov    (%ecx,%eax,1),%ebx
80103e1b:	89 1c 02             	mov    %ebx,(%edx,%eax,1)
80103e1e:	83 c0 04             	add    $0x4,%eax
80103e21:	83 f8 4c             	cmp    $0x4c,%eax
80103e24:	72 f2                	jb     80103e18 <fork+0x58>
    np->tf->eax = 0;
80103e26:	8b 46 18             	mov    0x18(%esi),%eax
    for(i = 0; i < NOFILE; i++)
80103e29:	31 db                	xor    %ebx,%ebx
    np->tf->eax = 0;
80103e2b:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103e32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        if(curproc->ofile[i])
80103e40:	8b 44 9f 28          	mov    0x28(%edi,%ebx,4),%eax
80103e44:	85 c0                	test   %eax,%eax
80103e46:	74 0c                	je     80103e54 <fork+0x94>
            np->ofile[i] = filedup(curproc->ofile[i]);
80103e48:	89 04 24             	mov    %eax,(%esp)
80103e4b:	e8 90 cf ff ff       	call   80100de0 <filedup>
80103e50:	89 44 9e 28          	mov    %eax,0x28(%esi,%ebx,4)
    for(i = 0; i < NOFILE; i++)
80103e54:	43                   	inc    %ebx
80103e55:	83 fb 10             	cmp    $0x10,%ebx
80103e58:	75 e6                	jne    80103e40 <fork+0x80>
    np->cwd = idup(curproc->cwd);
80103e5a:	8b 47 68             	mov    0x68(%edi),%eax
    safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103e5d:	83 c7 6c             	add    $0x6c,%edi
    np->cwd = idup(curproc->cwd);
80103e60:	89 04 24             	mov    %eax,(%esp)
80103e63:	e8 58 d8 ff ff       	call   801016c0 <idup>
80103e68:	89 46 68             	mov    %eax,0x68(%esi)
    safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103e6b:	b8 10 00 00 00       	mov    $0x10,%eax
80103e70:	89 44 24 08          	mov    %eax,0x8(%esp)
80103e74:	8d 46 6c             	lea    0x6c(%esi),%eax
80103e77:	89 7c 24 04          	mov    %edi,0x4(%esp)
    np->proc_perf.rutime = 0;
80103e7b:	31 ff                	xor    %edi,%edi
    safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103e7d:	89 04 24             	mov    %eax,(%esp)
80103e80:	e8 9b 1f 00 00       	call   80105e20 <safestrcpy>
    pid = np->pid;
80103e85:	8b 5e 10             	mov    0x10(%esi),%ebx
    acquire(&ptable.lock);
80103e88:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103e8f:	e8 bc 1c 00 00       	call   80105b50 <acquire>
    np->priority=5;
80103e94:	ba 05 00 00 00       	mov    $0x5,%edx
    np->state = RUNNABLE;
80103e99:	c7 46 0c 03 00 00 00 	movl   $0x3,0xc(%esi)
    np->RUNNABLE_wait_time=counter;
80103ea0:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
    np->priority=5;
80103ea5:	89 96 88 00 00 00    	mov    %edx,0x88(%esi)
    np->RUNNABLE_wait_time=counter;
80103eab:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
80103eb1:	89 86 a0 00 00 00    	mov    %eax,0xa0(%esi)
80103eb7:	89 96 a4 00 00 00    	mov    %edx,0xa4(%esi)
    acquire(&tickslock);
80103ebd:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80103ec4:	e8 87 1c 00 00       	call   80105b50 <acquire>
    np->proc_perf.ctime = ticks;
80103ec9:	a1 00 80 11 80       	mov    0x80118000,%eax
    np->proc_perf.retime = 0;
80103ece:	31 c9                	xor    %ecx,%ecx
80103ed0:	89 8e 98 00 00 00    	mov    %ecx,0x98(%esi)
    np->proc_perf.rutime = 0;
80103ed6:	89 be 9c 00 00 00    	mov    %edi,0x9c(%esi)
    np->proc_perf.ctime = ticks;
80103edc:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
    np->proc_perf.stime = 0;
80103ee2:	31 c0                	xor    %eax,%eax
80103ee4:	89 86 94 00 00 00    	mov    %eax,0x94(%esi)
    release(&tickslock);
80103eea:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80103ef1:	e8 fa 1c 00 00       	call   80105bf0 <release>
    updateAccumulator(np);
80103ef6:	89 34 24             	mov    %esi,(%esp)
80103ef9:	e8 e2 fb ff ff       	call   80103ae0 <updateAccumulator>
    pushToSpecificQueue(np);
80103efe:	89 34 24             	mov    %esi,(%esp)
80103f01:	e8 3a fc ff ff       	call   80103b40 <pushToSpecificQueue>
    release(&ptable.lock);
80103f06:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103f0d:	e8 de 1c 00 00       	call   80105bf0 <release>
}
80103f12:	83 c4 1c             	add    $0x1c,%esp
80103f15:	89 d8                	mov    %ebx,%eax
80103f17:	5b                   	pop    %ebx
80103f18:	5e                   	pop    %esi
80103f19:	5f                   	pop    %edi
80103f1a:	5d                   	pop    %ebp
80103f1b:	c3                   	ret    
        return -1;
80103f1c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103f21:	eb ef                	jmp    80103f12 <fork+0x152>
        kfree(np->kstack);
80103f23:	8b 46 08             	mov    0x8(%esi),%eax
        return -1;
80103f26:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
        kfree(np->kstack);
80103f2b:	89 04 24             	mov    %eax,(%esp)
80103f2e:	e8 ad e4 ff ff       	call   801023e0 <kfree>
        np->kstack = 0;
80103f33:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
        np->state = UNUSED;
80103f3a:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
        return -1;
80103f41:	eb cf                	jmp    80103f12 <fork+0x152>
80103f43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103f50 <scheduler>:
{
80103f50:	55                   	push   %ebp
80103f51:	89 e5                	mov    %esp,%ebp
80103f53:	57                   	push   %edi
80103f54:	56                   	push   %esi
80103f55:	53                   	push   %ebx
80103f56:	83 ec 2c             	sub    $0x2c,%esp
    pushcli();
80103f59:	e8 12 1b 00 00       	call   80105a70 <pushcli>
    c = mycpu();
80103f5e:	e8 ad fa ff ff       	call   80103a10 <mycpu>
    popcli();
80103f63:	e8 48 1b 00 00       	call   80105ab0 <popcli>
    struct cpu *c = mycpu();
80103f68:	e8 a3 fa ff ff       	call   80103a10 <mycpu>
80103f6d:	89 c3                	mov    %eax,%ebx
    pushcli();
80103f6f:	e8 fc 1a 00 00       	call   80105a70 <pushcli>
80103f74:	8d 73 04             	lea    0x4(%ebx),%esi
    c = mycpu();
80103f77:	e8 94 fa ff ff       	call   80103a10 <mycpu>
    p = c->proc;
80103f7c:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80103f82:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    popcli();
80103f85:	e8 26 1b 00 00       	call   80105ab0 <popcli>
    c->proc = 0;
80103f8a:	31 c0                	xor    %eax,%eax
80103f8c:	89 83 ac 00 00 00    	mov    %eax,0xac(%ebx)
80103f92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  asm volatile("sti");
80103fa0:	fb                   	sti    
        acquire(&ptable.lock);
80103fa1:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103fa8:	e8 a3 1b 00 00       	call   80105b50 <acquire>
        switch (currpolicy) {
80103fad:	a1 04 c0 10 80       	mov    0x8010c004,%eax
80103fb2:	83 f8 02             	cmp    $0x2,%eax
80103fb5:	0f 84 55 01 00 00    	je     80104110 <scheduler+0x1c0>
80103fbb:	83 f8 03             	cmp    $0x3,%eax
80103fbe:	0f 84 ec 00 00 00    	je     801040b0 <scheduler+0x160>
80103fc4:	48                   	dec    %eax
                for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103fc5:	bf b4 4d 11 80       	mov    $0x80114db4,%edi
        switch (currpolicy) {
80103fca:	74 6c                	je     80104038 <scheduler+0xe8>
80103fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                    if (p->state != RUNNABLE)
80103fd0:	8b 47 0c             	mov    0xc(%edi),%eax
80103fd3:	83 f8 03             	cmp    $0x3,%eax
80103fd6:	75 3a                	jne    80104012 <scheduler+0xc2>
                    c->proc = p;
80103fd8:	89 bb ac 00 00 00    	mov    %edi,0xac(%ebx)
                    switchuvm(p);
80103fde:	89 3c 24             	mov    %edi,(%esp)
80103fe1:	e8 6a 41 00 00       	call   80108150 <switchuvm>
                    p->state = RUNNING;
80103fe6:	c7 47 0c 04 00 00 00 	movl   $0x4,0xc(%edi)
                    rpholder.add(p);
80103fed:	89 3c 24             	mov    %edi,(%esp)
80103ff0:	ff 15 c8 c5 10 80    	call   *0x8010c5c8
                    swtch(&(c->scheduler), p->context);
80103ff6:	8b 47 1c             	mov    0x1c(%edi),%eax
80103ff9:	89 34 24             	mov    %esi,(%esp)
80103ffc:	89 44 24 04          	mov    %eax,0x4(%esp)
80104000:	e8 74 1e 00 00       	call   80105e79 <swtch>
                    switchkvm();
80104005:	e8 26 41 00 00       	call   80108130 <switchkvm>
                    c->proc = 0;
8010400a:	31 c0                	xor    %eax,%eax
8010400c:	89 83 ac 00 00 00    	mov    %eax,0xac(%ebx)
                for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104012:	81 c7 a8 00 00 00    	add    $0xa8,%edi
80104018:	81 ff b4 77 11 80    	cmp    $0x801177b4,%edi
8010401e:	72 b0                	jb     80103fd0 <scheduler+0x80>
        release(&ptable.lock);
80104020:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104027:	e8 c4 1b 00 00       	call   80105bf0 <release>
        sti();
8010402c:	e9 6f ff ff ff       	jmp    80103fa0 <scheduler+0x50>
80104031:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                if (!rrq.isEmpty()) {
80104038:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
8010403e:	85 c0                	test   %eax,%eax
80104040:	75 de                	jne    80104020 <scheduler+0xd0>
                    p = rrq.dequeue();
80104042:	ff 15 dc c5 10 80    	call   *0x8010c5dc
                    if (p != null) {
80104048:	85 c0                	test   %eax,%eax
                    p = rrq.dequeue();
8010404a:	89 c7                	mov    %eax,%edi
                    if (p != null) {
8010404c:	74 d2                	je     80104020 <scheduler+0xd0>
                        c->proc = p;
8010404e:	89 bb ac 00 00 00    	mov    %edi,0xac(%ebx)
                        switchuvm(p);
80104054:	89 3c 24             	mov    %edi,(%esp)
80104057:	e8 f4 40 00 00       	call   80108150 <switchuvm>
                        p->state = RUNNING;
8010405c:	c7 47 0c 04 00 00 00 	movl   $0x4,0xc(%edi)
                        p->RUNNABLE_wait_time=counter;
80104063:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
80104068:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
8010406e:	89 87 a0 00 00 00    	mov    %eax,0xa0(%edi)
80104074:	89 97 a4 00 00 00    	mov    %edx,0xa4(%edi)
                        rpholder.add(p);
8010407a:	89 3c 24             	mov    %edi,(%esp)
8010407d:	ff 15 c8 c5 10 80    	call   *0x8010c5c8
                        swtch(&(c->scheduler), p->context);
80104083:	8b 47 1c             	mov    0x1c(%edi),%eax
80104086:	89 34 24             	mov    %esi,(%esp)
80104089:	89 44 24 04          	mov    %eax,0x4(%esp)
8010408d:	e8 e7 1d 00 00       	call   80105e79 <swtch>
                        switchkvm();
80104092:	e8 99 40 00 00       	call   80108130 <switchkvm>
                        c->proc = 0;
80104097:	31 d2                	xor    %edx,%edx
80104099:	89 93 ac 00 00 00    	mov    %edx,0xac(%ebx)
        release(&ptable.lock);
8010409f:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801040a6:	e8 45 1b 00 00       	call   80105bf0 <release>
801040ab:	e9 f0 fe ff ff       	jmp    80103fa0 <scheduler+0x50>
                if (!pq.isEmpty()) {
801040b0:	ff 15 e4 c5 10 80    	call   *0x8010c5e4
801040b6:	85 c0                	test   %eax,%eax
801040b8:	0f 85 62 ff ff ff    	jne    80104020 <scheduler+0xd0>
                    if( counter % 100 == 0)
801040be:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
801040c3:	b9 64 00 00 00       	mov    $0x64,%ecx
801040c8:	31 ff                	xor    %edi,%edi
801040ca:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
801040d0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801040d4:	89 7c 24 0c          	mov    %edi,0xc(%esp)
801040d8:	89 04 24             	mov    %eax,(%esp)
801040db:	89 54 24 04          	mov    %edx,0x4(%esp)
801040df:	e8 1c 17 00 00       	call   80105800 <__moddi3>
801040e4:	09 c2                	or     %eax,%edx
801040e6:	74 43                	je     8010412b <scheduler+0x1db>
                        p = pq.extractMin();
801040e8:	ff 15 f0 c5 10 80    	call   *0x8010c5f0
801040ee:	89 c7                	mov    %eax,%edi
                    if (p != null) {
801040f0:	85 ff                	test   %edi,%edi
801040f2:	0f 85 56 ff ff ff    	jne    8010404e <scheduler+0xfe>
        release(&ptable.lock);
801040f8:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801040ff:	e8 ec 1a 00 00       	call   80105bf0 <release>
80104104:	e9 97 fe ff ff       	jmp    80103fa0 <scheduler+0x50>
80104109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                if (!pq.isEmpty()) {
80104110:	ff 15 e4 c5 10 80    	call   *0x8010c5e4
80104116:	85 c0                	test   %eax,%eax
80104118:	74 ce                	je     801040e8 <scheduler+0x198>
        release(&ptable.lock);
8010411a:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104121:	e8 ca 1a 00 00       	call   80105bf0 <release>
80104126:	e9 75 fe ff ff       	jmp    80103fa0 <scheduler+0x50>
                        long long min = counter;
8010412b:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
                        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104130:	bf b4 4d 11 80       	mov    $0x80114db4,%edi
                        long long min = counter;
80104135:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
                        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
8010413b:	89 5d e0             	mov    %ebx,-0x20(%ebp)
8010413e:	eb 0e                	jmp    8010414e <scheduler+0x1fe>
80104140:	81 c7 a8 00 00 00    	add    $0xa8,%edi
80104146:	81 ff b4 77 11 80    	cmp    $0x801177b4,%edi
8010414c:	73 33                	jae    80104181 <scheduler+0x231>
                            if ((p->state == RUNNABLE) && (p->RUNNABLE_wait_time < min)){
8010414e:	8b 4f 0c             	mov    0xc(%edi),%ecx
80104151:	83 f9 03             	cmp    $0x3,%ecx
80104154:	75 ea                	jne    80104140 <scheduler+0x1f0>
80104156:	8b 8f a4 00 00 00    	mov    0xa4(%edi),%ecx
8010415c:	8b 9f a0 00 00 00    	mov    0xa0(%edi),%ebx
80104162:	39 d1                	cmp    %edx,%ecx
80104164:	7f da                	jg     80104140 <scheduler+0x1f0>
80104166:	7c 04                	jl     8010416c <scheduler+0x21c>
80104168:	39 c3                	cmp    %eax,%ebx
8010416a:	73 d4                	jae    80104140 <scheduler+0x1f0>
8010416c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
                        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
8010416f:	81 c7 a8 00 00 00    	add    $0xa8,%edi
                            if ((p->state == RUNNABLE) && (p->RUNNABLE_wait_time < min)){
80104175:	89 d8                	mov    %ebx,%eax
                        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104177:	81 ff b4 77 11 80    	cmp    $0x801177b4,%edi
                            if ((p->state == RUNNABLE) && (p->RUNNABLE_wait_time < min)){
8010417d:	89 ca                	mov    %ecx,%edx
                        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
8010417f:	72 cd                	jb     8010414e <scheduler+0x1fe>
                        if(max_p != 0)
80104181:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80104184:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80104187:	85 c0                	test   %eax,%eax
80104189:	0f 84 61 ff ff ff    	je     801040f0 <scheduler+0x1a0>
                            pq.extractProc(max_p);
8010418f:	89 04 24             	mov    %eax,(%esp)
80104192:	89 c7                	mov    %eax,%edi
80104194:	ff 15 f8 c5 10 80    	call   *0x8010c5f8
8010419a:	e9 af fe ff ff       	jmp    8010404e <scheduler+0xfe>
8010419f:	90                   	nop

801041a0 <sched>:
{
801041a0:	55                   	push   %ebp
801041a1:	89 e5                	mov    %esp,%ebp
801041a3:	56                   	push   %esi
801041a4:	53                   	push   %ebx
801041a5:	83 ec 10             	sub    $0x10,%esp
    pushcli();
801041a8:	e8 c3 18 00 00       	call   80105a70 <pushcli>
    c = mycpu();
801041ad:	e8 5e f8 ff ff       	call   80103a10 <mycpu>
    p = c->proc;
801041b2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
801041b8:	e8 f3 18 00 00       	call   80105ab0 <popcli>
    if(!holding(&ptable.lock))
801041bd:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801041c4:	e8 47 19 00 00       	call   80105b10 <holding>
801041c9:	85 c0                	test   %eax,%eax
801041cb:	74 51                	je     8010421e <sched+0x7e>
    if(mycpu()->ncli != 1)
801041cd:	e8 3e f8 ff ff       	call   80103a10 <mycpu>
801041d2:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
801041d9:	75 67                	jne    80104242 <sched+0xa2>
    if(p->state == RUNNING)
801041db:	8b 43 0c             	mov    0xc(%ebx),%eax
801041de:	83 f8 04             	cmp    $0x4,%eax
801041e1:	74 53                	je     80104236 <sched+0x96>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801041e3:	9c                   	pushf  
801041e4:	58                   	pop    %eax
    if(readeflags()&FL_IF)
801041e5:	f6 c4 02             	test   $0x2,%ah
801041e8:	75 40                	jne    8010422a <sched+0x8a>
    intena = mycpu()->intena;
801041ea:	e8 21 f8 ff ff       	call   80103a10 <mycpu>
    swtch(&p->context, mycpu()->scheduler);
801041ef:	83 c3 1c             	add    $0x1c,%ebx
    intena = mycpu()->intena;
801041f2:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
    swtch(&p->context, mycpu()->scheduler);
801041f8:	e8 13 f8 ff ff       	call   80103a10 <mycpu>
801041fd:	8b 40 04             	mov    0x4(%eax),%eax
80104200:	89 1c 24             	mov    %ebx,(%esp)
80104203:	89 44 24 04          	mov    %eax,0x4(%esp)
80104207:	e8 6d 1c 00 00       	call   80105e79 <swtch>
    mycpu()->intena = intena;
8010420c:	e8 ff f7 ff ff       	call   80103a10 <mycpu>
80104211:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104217:	83 c4 10             	add    $0x10,%esp
8010421a:	5b                   	pop    %ebx
8010421b:	5e                   	pop    %esi
8010421c:	5d                   	pop    %ebp
8010421d:	c3                   	ret    
        panic("sched ptable.lock");
8010421e:	c7 04 24 20 8e 10 80 	movl   $0x80108e20,(%esp)
80104225:	e8 46 c1 ff ff       	call   80100370 <panic>
        panic("sched interruptible");
8010422a:	c7 04 24 4c 8e 10 80 	movl   $0x80108e4c,(%esp)
80104231:	e8 3a c1 ff ff       	call   80100370 <panic>
        panic("sched running");
80104236:	c7 04 24 3e 8e 10 80 	movl   $0x80108e3e,(%esp)
8010423d:	e8 2e c1 ff ff       	call   80100370 <panic>
        panic("sched locks");
80104242:	c7 04 24 32 8e 10 80 	movl   $0x80108e32,(%esp)
80104249:	e8 22 c1 ff ff       	call   80100370 <panic>
8010424e:	66 90                	xchg   %ax,%ax

80104250 <exit>:
{
80104250:	55                   	push   %ebp
80104251:	89 e5                	mov    %esp,%ebp
80104253:	57                   	push   %edi
80104254:	56                   	push   %esi
80104255:	53                   	push   %ebx
80104256:	83 ec 1c             	sub    $0x1c,%esp
    pushcli();
80104259:	e8 12 18 00 00       	call   80105a70 <pushcli>
    c = mycpu();
8010425e:	e8 ad f7 ff ff       	call   80103a10 <mycpu>
    p = c->proc;
80104263:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
    popcli();
80104269:	e8 42 18 00 00       	call   80105ab0 <popcli>
    curproc->exit_status=status;
8010426e:	8b 45 08             	mov    0x8(%ebp),%eax
    if(curproc == initproc)
80104271:	39 35 c0 c5 10 80    	cmp    %esi,0x8010c5c0
    curproc->exit_status=status;
80104277:	89 46 7c             	mov    %eax,0x7c(%esi)
    if(curproc == initproc)
8010427a:	0f 84 d8 00 00 00    	je     80104358 <exit+0x108>
80104280:	8d 5e 28             	lea    0x28(%esi),%ebx
80104283:	8d 7e 68             	lea    0x68(%esi),%edi
80104286:	8d 76 00             	lea    0x0(%esi),%esi
80104289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        if(curproc->ofile[fd]){
80104290:	8b 03                	mov    (%ebx),%eax
80104292:	85 c0                	test   %eax,%eax
80104294:	74 0e                	je     801042a4 <exit+0x54>
            fileclose(curproc->ofile[fd]);
80104296:	89 04 24             	mov    %eax,(%esp)
80104299:	e8 92 cb ff ff       	call   80100e30 <fileclose>
            curproc->ofile[fd] = 0;
8010429e:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801042a4:	83 c3 04             	add    $0x4,%ebx
    for(fd = 0; fd < NOFILE; fd++){
801042a7:	39 df                	cmp    %ebx,%edi
801042a9:	75 e5                	jne    80104290 <exit+0x40>
    begin_op();
801042ab:	e8 e0 e9 ff ff       	call   80102c90 <begin_op>
    iput(curproc->cwd);
801042b0:	8b 46 68             	mov    0x68(%esi),%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042b3:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
    iput(curproc->cwd);
801042b8:	89 04 24             	mov    %eax,(%esp)
801042bb:	e8 60 d5 ff ff       	call   80101820 <iput>
    end_op();
801042c0:	e8 3b ea ff ff       	call   80102d00 <end_op>
    curproc->cwd = 0;
801042c5:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
    acquire(&ptable.lock);
801042cc:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801042d3:	e8 78 18 00 00       	call   80105b50 <acquire>
    acquire(&tickslock);
801042d8:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
801042df:	e8 6c 18 00 00       	call   80105b50 <acquire>
    curproc->proc_perf.ttime = ticks;
801042e4:	a1 00 80 11 80       	mov    0x80118000,%eax
801042e9:	89 86 90 00 00 00    	mov    %eax,0x90(%esi)
    release(&tickslock);
801042ef:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
801042f6:	e8 f5 18 00 00       	call   80105bf0 <release>
    wakeup1(curproc->parent);
801042fb:	8b 46 14             	mov    0x14(%esi),%eax
801042fe:	e8 7d f8 ff ff       	call   80103b80 <wakeup1>
80104303:	eb 11                	jmp    80104316 <exit+0xc6>
80104305:	8d 76 00             	lea    0x0(%esi),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104308:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
8010430e:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
80104314:	73 2a                	jae    80104340 <exit+0xf0>
        if(p->parent == curproc){
80104316:	39 73 14             	cmp    %esi,0x14(%ebx)
80104319:	75 ed                	jne    80104308 <exit+0xb8>
            if(p->state == ZOMBIE)
8010431b:	8b 53 0c             	mov    0xc(%ebx),%edx
            p->parent = initproc;
8010431e:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
            if(p->state == ZOMBIE)
80104323:	83 fa 05             	cmp    $0x5,%edx
            p->parent = initproc;
80104326:	89 43 14             	mov    %eax,0x14(%ebx)
            if(p->state == ZOMBIE)
80104329:	75 dd                	jne    80104308 <exit+0xb8>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010432b:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
                wakeup1(initproc);
80104331:	e8 4a f8 ff ff       	call   80103b80 <wakeup1>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104336:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
8010433c:	72 d8                	jb     80104316 <exit+0xc6>
8010433e:	66 90                	xchg   %ax,%ax
    curproc->state = ZOMBIE;
80104340:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
    sched();
80104347:	e8 54 fe ff ff       	call   801041a0 <sched>
    panic("zombie exit");
8010434c:	c7 04 24 6d 8e 10 80 	movl   $0x80108e6d,(%esp)
80104353:	e8 18 c0 ff ff       	call   80100370 <panic>
        panic("init exiting");
80104358:	c7 04 24 60 8e 10 80 	movl   $0x80108e60,(%esp)
8010435f:	e8 0c c0 ff ff       	call   80100370 <panic>
80104364:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010436a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104370 <yield>:
{
80104370:	55                   	push   %ebp
80104371:	89 e5                	mov    %esp,%ebp
80104373:	53                   	push   %ebx
80104374:	83 ec 14             	sub    $0x14,%esp
    pushcli();
80104377:	e8 f4 16 00 00       	call   80105a70 <pushcli>
    c = mycpu();
8010437c:	e8 8f f6 ff ff       	call   80103a10 <mycpu>
    p = c->proc;
80104381:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
80104387:	e8 24 17 00 00       	call   80105ab0 <popcli>
    acquire(&ptable.lock);  //DOC: yieldlock
8010438c:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104393:	e8 b8 17 00 00       	call   80105b50 <acquire>
    p->state = RUNNABLE;
80104398:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
    if(currpolicy == 2 || currpolicy == 3)
8010439f:	a1 04 c0 10 80       	mov    0x8010c004,%eax
801043a4:	83 f8 02             	cmp    $0x2,%eax
801043a7:	74 37                	je     801043e0 <yield+0x70>
801043a9:	a1 04 c0 10 80       	mov    0x8010c004,%eax
801043ae:	83 f8 03             	cmp    $0x3,%eax
801043b1:	74 2d                	je     801043e0 <yield+0x70>
    pushToSpecificQueue(p);
801043b3:	89 1c 24             	mov    %ebx,(%esp)
801043b6:	e8 85 f7 ff ff       	call   80103b40 <pushToSpecificQueue>
    rpholder.remove(p);//remove from running queue
801043bb:	89 1c 24             	mov    %ebx,(%esp)
801043be:	ff 15 cc c5 10 80    	call   *0x8010c5cc
    sched();
801043c4:	e8 d7 fd ff ff       	call   801041a0 <sched>
    release(&ptable.lock);
801043c9:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801043d0:	e8 1b 18 00 00       	call   80105bf0 <release>
}
801043d5:	83 c4 14             	add    $0x14,%esp
801043d8:	5b                   	pop    %ebx
801043d9:	5d                   	pop    %ebp
801043da:	c3                   	ret    
801043db:	90                   	nop
801043dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->accumulator+=p->priority;
801043e0:	8b 83 88 00 00 00    	mov    0x88(%ebx),%eax
801043e6:	99                   	cltd   
801043e7:	01 83 80 00 00 00    	add    %eax,0x80(%ebx)
801043ed:	11 93 84 00 00 00    	adc    %edx,0x84(%ebx)
801043f3:	eb be                	jmp    801043b3 <yield+0x43>
801043f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801043f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104400 <sleep>:
{
80104400:	55                   	push   %ebp
80104401:	89 e5                	mov    %esp,%ebp
80104403:	83 ec 28             	sub    $0x28,%esp
80104406:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80104409:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010440c:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010440f:	8b 75 08             	mov    0x8(%ebp),%esi
80104412:	89 7d fc             	mov    %edi,-0x4(%ebp)
    pushcli();
80104415:	e8 56 16 00 00       	call   80105a70 <pushcli>
    c = mycpu();
8010441a:	e8 f1 f5 ff ff       	call   80103a10 <mycpu>
    p = c->proc;
8010441f:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
    popcli();
80104425:	e8 86 16 00 00       	call   80105ab0 <popcli>
    if(p == 0)
8010442a:	85 ff                	test   %edi,%edi
8010442c:	0f 84 c5 00 00 00    	je     801044f7 <sleep+0xf7>
    if(lk == 0)
80104432:	85 db                	test   %ebx,%ebx
80104434:	0f 84 b1 00 00 00    	je     801044eb <sleep+0xeb>
    if(currpolicy == 2 || currpolicy == 3)
8010443a:	a1 04 c0 10 80       	mov    0x8010c004,%eax
8010443f:	83 f8 02             	cmp    $0x2,%eax
80104442:	74 6c                	je     801044b0 <sleep+0xb0>
80104444:	a1 04 c0 10 80       	mov    0x8010c004,%eax
80104449:	83 f8 03             	cmp    $0x3,%eax
8010444c:	74 62                	je     801044b0 <sleep+0xb0>
    rpholder.remove(p); //remove p from RUNNING queue
8010444e:	89 3c 24             	mov    %edi,(%esp)
80104451:	ff 15 cc c5 10 80    	call   *0x8010c5cc
    if(lk != &ptable.lock){  //DOC: sleeplock0
80104457:	81 fb 80 4d 11 80    	cmp    $0x80114d80,%ebx
8010445d:	74 69                	je     801044c8 <sleep+0xc8>
        acquire(&ptable.lock);  //DOC: sleeplock1
8010445f:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104466:	e8 e5 16 00 00       	call   80105b50 <acquire>
        release(lk);
8010446b:	89 1c 24             	mov    %ebx,(%esp)
8010446e:	e8 7d 17 00 00       	call   80105bf0 <release>
    p->chan = chan;
80104473:	89 77 20             	mov    %esi,0x20(%edi)
    p->state = SLEEPING;
80104476:	c7 47 0c 02 00 00 00 	movl   $0x2,0xc(%edi)
    sched();
8010447d:	e8 1e fd ff ff       	call   801041a0 <sched>
    p->chan = 0;
80104482:	c7 47 20 00 00 00 00 	movl   $0x0,0x20(%edi)
        release(&ptable.lock);
80104489:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104490:	e8 5b 17 00 00       	call   80105bf0 <release>
}
80104495:	8b 75 f8             	mov    -0x8(%ebp),%esi
        acquire(lk);
80104498:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010449b:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010449e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801044a1:	89 ec                	mov    %ebp,%esp
801044a3:	5d                   	pop    %ebp
        acquire(lk);
801044a4:	e9 a7 16 00 00       	jmp    80105b50 <acquire>
801044a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        p->accumulator+=p->priority;
801044b0:	8b 87 88 00 00 00    	mov    0x88(%edi),%eax
801044b6:	99                   	cltd   
801044b7:	01 87 80 00 00 00    	add    %eax,0x80(%edi)
801044bd:	11 97 84 00 00 00    	adc    %edx,0x84(%edi)
801044c3:	eb 89                	jmp    8010444e <sleep+0x4e>
801044c5:	8d 76 00             	lea    0x0(%esi),%esi
    p->chan = chan;
801044c8:	89 77 20             	mov    %esi,0x20(%edi)
    p->state = SLEEPING;
801044cb:	c7 47 0c 02 00 00 00 	movl   $0x2,0xc(%edi)
    sched();
801044d2:	e8 c9 fc ff ff       	call   801041a0 <sched>
    p->chan = 0;
801044d7:	c7 47 20 00 00 00 00 	movl   $0x0,0x20(%edi)
}
801044de:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801044e1:	8b 75 f8             	mov    -0x8(%ebp),%esi
801044e4:	8b 7d fc             	mov    -0x4(%ebp),%edi
801044e7:	89 ec                	mov    %ebp,%esp
801044e9:	5d                   	pop    %ebp
801044ea:	c3                   	ret    
        panic("sleep without lk");
801044eb:	c7 04 24 7f 8e 10 80 	movl   $0x80108e7f,(%esp)
801044f2:	e8 79 be ff ff       	call   80100370 <panic>
        panic("sleep");
801044f7:	c7 04 24 79 8e 10 80 	movl   $0x80108e79,(%esp)
801044fe:	e8 6d be ff ff       	call   80100370 <panic>
80104503:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104510 <wait>:
{
80104510:	55                   	push   %ebp
80104511:	89 e5                	mov    %esp,%ebp
80104513:	57                   	push   %edi
80104514:	56                   	push   %esi
80104515:	53                   	push   %ebx
80104516:	83 ec 1c             	sub    $0x1c,%esp
80104519:	8b 7d 08             	mov    0x8(%ebp),%edi
    pushcli();
8010451c:	e8 4f 15 00 00       	call   80105a70 <pushcli>
    c = mycpu();
80104521:	e8 ea f4 ff ff       	call   80103a10 <mycpu>
    p = c->proc;
80104526:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
    popcli();
8010452c:	e8 7f 15 00 00       	call   80105ab0 <popcli>
    acquire(&ptable.lock);
80104531:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104538:	e8 13 16 00 00       	call   80105b50 <acquire>
        havekids = 0;
8010453d:	31 c0                	xor    %eax,%eax
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010453f:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
80104544:	eb 18                	jmp    8010455e <wait+0x4e>
80104546:	8d 76 00             	lea    0x0(%esi),%esi
80104549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104550:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80104556:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
8010455c:	73 20                	jae    8010457e <wait+0x6e>
            if(p->parent != curproc)
8010455e:	39 73 14             	cmp    %esi,0x14(%ebx)
80104561:	75 ed                	jne    80104550 <wait+0x40>
            if(p->state == ZOMBIE){
80104563:	8b 43 0c             	mov    0xc(%ebx),%eax
80104566:	83 f8 05             	cmp    $0x5,%eax
80104569:	74 35                	je     801045a0 <wait+0x90>
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010456b:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
            havekids = 1;
80104571:	b8 01 00 00 00       	mov    $0x1,%eax
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104576:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
8010457c:	72 e0                	jb     8010455e <wait+0x4e>
        if(!havekids || curproc->killed){
8010457e:	85 c0                	test   %eax,%eax
80104580:	74 7d                	je     801045ff <wait+0xef>
80104582:	8b 56 24             	mov    0x24(%esi),%edx
80104585:	85 d2                	test   %edx,%edx
80104587:	75 76                	jne    801045ff <wait+0xef>
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104589:	b8 80 4d 11 80       	mov    $0x80114d80,%eax
8010458e:	89 44 24 04          	mov    %eax,0x4(%esp)
80104592:	89 34 24             	mov    %esi,(%esp)
80104595:	e8 66 fe ff ff       	call   80104400 <sleep>
        havekids = 0;
8010459a:	eb a1                	jmp    8010453d <wait+0x2d>
8010459c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                kfree(p->kstack);
801045a0:	8b 43 08             	mov    0x8(%ebx),%eax
                pid = p->pid;
801045a3:	8b 73 10             	mov    0x10(%ebx),%esi
                kfree(p->kstack);
801045a6:	89 04 24             	mov    %eax,(%esp)
801045a9:	e8 32 de ff ff       	call   801023e0 <kfree>
                freevm(p->pgdir);
801045ae:	8b 43 04             	mov    0x4(%ebx),%eax
                p->kstack = 0;
801045b1:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
                freevm(p->pgdir);
801045b8:	89 04 24             	mov    %eax,(%esp)
801045bb:	e8 40 3f 00 00       	call   80108500 <freevm>
                if(status!=null)
801045c0:	85 ff                	test   %edi,%edi
                p->pid = 0;
801045c2:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
                p->parent = 0;
801045c9:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
                p->name[0] = 0;
801045d0:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
                p->killed = 0;
801045d4:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
                p->state = UNUSED;
801045db:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
                if(status!=null)
801045e2:	74 05                	je     801045e9 <wait+0xd9>
                    *status = (p->exit_status);
801045e4:	8b 43 7c             	mov    0x7c(%ebx),%eax
801045e7:	89 07                	mov    %eax,(%edi)
                release(&ptable.lock);
801045e9:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801045f0:	e8 fb 15 00 00       	call   80105bf0 <release>
}
801045f5:	83 c4 1c             	add    $0x1c,%esp
801045f8:	89 f0                	mov    %esi,%eax
801045fa:	5b                   	pop    %ebx
801045fb:	5e                   	pop    %esi
801045fc:	5f                   	pop    %edi
801045fd:	5d                   	pop    %ebp
801045fe:	c3                   	ret    
            release(&ptable.lock);
801045ff:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
            return -1;
80104606:	be ff ff ff ff       	mov    $0xffffffff,%esi
            release(&ptable.lock);
8010460b:	e8 e0 15 00 00       	call   80105bf0 <release>
            return -1;
80104610:	eb e3                	jmp    801045f5 <wait+0xe5>
80104612:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104620 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104620:	55                   	push   %ebp
80104621:	89 e5                	mov    %esp,%ebp
80104623:	53                   	push   %ebx
80104624:	83 ec 14             	sub    $0x14,%esp
80104627:	8b 5d 08             	mov    0x8(%ebp),%ebx
    acquire(&ptable.lock);
8010462a:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104631:	e8 1a 15 00 00       	call   80105b50 <acquire>
    wakeup1(chan);
80104636:	89 d8                	mov    %ebx,%eax
80104638:	e8 43 f5 ff ff       	call   80103b80 <wakeup1>
    release(&ptable.lock);
8010463d:	c7 45 08 80 4d 11 80 	movl   $0x80114d80,0x8(%ebp)
}
80104644:	83 c4 14             	add    $0x14,%esp
80104647:	5b                   	pop    %ebx
80104648:	5d                   	pop    %ebp
    release(&ptable.lock);
80104649:	e9 a2 15 00 00       	jmp    80105bf0 <release>
8010464e:	66 90                	xchg   %ax,%ax

80104650 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
80104653:	53                   	push   %ebx
80104654:	83 ec 14             	sub    $0x14,%esp
    struct proc *p;

    acquire(&ptable.lock);
80104657:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
{
8010465e:	8b 5d 08             	mov    0x8(%ebp),%ebx
    acquire(&ptable.lock);
80104661:	e8 ea 14 00 00       	call   80105b50 <acquire>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104666:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
8010466b:	eb 0f                	jmp    8010467c <kill+0x2c>
8010466d:	8d 76 00             	lea    0x0(%esi),%esi
80104670:	05 a8 00 00 00       	add    $0xa8,%eax
80104675:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
8010467a:	73 44                	jae    801046c0 <kill+0x70>
        if(p->pid == pid){
8010467c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010467f:	75 ef                	jne    80104670 <kill+0x20>
            p->killed = 1;
            // Wake process from sleep if necessary.
            if(p->state == SLEEPING){
80104681:	8b 50 0c             	mov    0xc(%eax),%edx
            p->killed = 1;
80104684:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
            if(p->state == SLEEPING){
8010468b:	83 fa 02             	cmp    $0x2,%edx
8010468e:	74 18                	je     801046a8 <kill+0x58>
                p->state = RUNNABLE;
                pushToSpecificQueue(p);
            }
            release(&ptable.lock);
80104690:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104697:	e8 54 15 00 00       	call   80105bf0 <release>
            return 0;
        }
    }
    release(&ptable.lock);
    return -1;
}
8010469c:	83 c4 14             	add    $0x14,%esp
            return 0;
8010469f:	31 c0                	xor    %eax,%eax
}
801046a1:	5b                   	pop    %ebx
801046a2:	5d                   	pop    %ebp
801046a3:	c3                   	ret    
801046a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                p->state = RUNNABLE;
801046a8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
                pushToSpecificQueue(p);
801046af:	89 04 24             	mov    %eax,(%esp)
801046b2:	e8 89 f4 ff ff       	call   80103b40 <pushToSpecificQueue>
801046b7:	eb d7                	jmp    80104690 <kill+0x40>
801046b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&ptable.lock);
801046c0:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801046c7:	e8 24 15 00 00       	call   80105bf0 <release>
}
801046cc:	83 c4 14             	add    $0x14,%esp
    return -1;
801046cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801046d4:	5b                   	pop    %ebx
801046d5:	5d                   	pop    %ebp
801046d6:	c3                   	ret    
801046d7:	89 f6                	mov    %esi,%esi
801046d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046e0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801046e0:	55                   	push   %ebp
801046e1:	89 e5                	mov    %esp,%ebp
801046e3:	57                   	push   %edi
801046e4:	56                   	push   %esi
801046e5:	53                   	push   %ebx
    int i;
    struct proc *p;
    char *state;
    uint pc[10];

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046e6:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
{
801046eb:	83 ec 4c             	sub    $0x4c,%esp
801046ee:	eb 1e                	jmp    8010470e <procdump+0x2e>
        if(p->state == SLEEPING){
            getcallerpcs((uint*)p->context->ebp+2, pc);
            for(i=0; i<10 && pc[i] != 0; i++)
                cprintf(" %p", pc[i]);
        }
        cprintf("\n");
801046f0:	c7 04 24 61 8f 10 80 	movl   $0x80108f61,(%esp)
801046f7:	e8 54 bf ff ff       	call   80100650 <cprintf>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046fc:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80104702:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
80104708:	0f 83 b2 00 00 00    	jae    801047c0 <procdump+0xe0>
        if(p->state == UNUSED)
8010470e:	8b 43 0c             	mov    0xc(%ebx),%eax
80104711:	85 c0                	test   %eax,%eax
80104713:	74 e7                	je     801046fc <procdump+0x1c>
        if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104715:	8b 43 0c             	mov    0xc(%ebx),%eax
            state = "???";
80104718:	b8 90 8e 10 80       	mov    $0x80108e90,%eax
        if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010471d:	8b 53 0c             	mov    0xc(%ebx),%edx
80104720:	83 fa 05             	cmp    $0x5,%edx
80104723:	77 18                	ja     8010473d <procdump+0x5d>
80104725:	8b 53 0c             	mov    0xc(%ebx),%edx
80104728:	8b 14 95 38 8f 10 80 	mov    -0x7fef70c8(,%edx,4),%edx
8010472f:	85 d2                	test   %edx,%edx
80104731:	74 0a                	je     8010473d <procdump+0x5d>
            state = states[p->state];
80104733:	8b 43 0c             	mov    0xc(%ebx),%eax
80104736:	8b 04 85 38 8f 10 80 	mov    -0x7fef70c8(,%eax,4),%eax
        cprintf("%d %s %s", p->pid, state, p->name);
8010473d:	89 44 24 08          	mov    %eax,0x8(%esp)
80104741:	8b 43 10             	mov    0x10(%ebx),%eax
80104744:	8d 53 6c             	lea    0x6c(%ebx),%edx
80104747:	89 54 24 0c          	mov    %edx,0xc(%esp)
8010474b:	c7 04 24 94 8e 10 80 	movl   $0x80108e94,(%esp)
80104752:	89 44 24 04          	mov    %eax,0x4(%esp)
80104756:	e8 f5 be ff ff       	call   80100650 <cprintf>
        if(p->state == SLEEPING){
8010475b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010475e:	83 f8 02             	cmp    $0x2,%eax
80104761:	75 8d                	jne    801046f0 <procdump+0x10>
            getcallerpcs((uint*)p->context->ebp+2, pc);
80104763:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104766:	89 44 24 04          	mov    %eax,0x4(%esp)
8010476a:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010476d:	8d 75 c0             	lea    -0x40(%ebp),%esi
80104770:	8d 7d e8             	lea    -0x18(%ebp),%edi
80104773:	8b 40 0c             	mov    0xc(%eax),%eax
80104776:	83 c0 08             	add    $0x8,%eax
80104779:	89 04 24             	mov    %eax,(%esp)
8010477c:	e8 9f 12 00 00       	call   80105a20 <getcallerpcs>
80104781:	eb 0d                	jmp    80104790 <procdump+0xb0>
80104783:	90                   	nop
80104784:	90                   	nop
80104785:	90                   	nop
80104786:	90                   	nop
80104787:	90                   	nop
80104788:	90                   	nop
80104789:	90                   	nop
8010478a:	90                   	nop
8010478b:	90                   	nop
8010478c:	90                   	nop
8010478d:	90                   	nop
8010478e:	90                   	nop
8010478f:	90                   	nop
            for(i=0; i<10 && pc[i] != 0; i++)
80104790:	8b 16                	mov    (%esi),%edx
80104792:	85 d2                	test   %edx,%edx
80104794:	0f 84 56 ff ff ff    	je     801046f0 <procdump+0x10>
                cprintf(" %p", pc[i]);
8010479a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010479e:	83 c6 04             	add    $0x4,%esi
801047a1:	c7 04 24 81 88 10 80 	movl   $0x80108881,(%esp)
801047a8:	e8 a3 be ff ff       	call   80100650 <cprintf>
            for(i=0; i<10 && pc[i] != 0; i++)
801047ad:	39 f7                	cmp    %esi,%edi
801047af:	75 df                	jne    80104790 <procdump+0xb0>
801047b1:	e9 3a ff ff ff       	jmp    801046f0 <procdump+0x10>
801047b6:	8d 76 00             	lea    0x0(%esi),%esi
801047b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    }
}
801047c0:	83 c4 4c             	add    $0x4c,%esp
801047c3:	5b                   	pop    %ebx
801047c4:	5e                   	pop    %esi
801047c5:	5f                   	pop    %edi
801047c6:	5d                   	pop    %ebp
801047c7:	c3                   	ret    
801047c8:	90                   	nop
801047c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801047d0 <detach>:



int
detach(int pid)
{
801047d0:	55                   	push   %ebp
801047d1:	89 e5                	mov    %esp,%ebp
801047d3:	56                   	push   %esi
801047d4:	53                   	push   %ebx
801047d5:	83 ec 10             	sub    $0x10,%esp
801047d8:	8b 75 08             	mov    0x8(%ebp),%esi
    pushcli();
801047db:	e8 90 12 00 00       	call   80105a70 <pushcli>
    c = mycpu();
801047e0:	e8 2b f2 ff ff       	call   80103a10 <mycpu>
    p = c->proc;
801047e5:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
801047eb:	e8 c0 12 00 00       	call   80105ab0 <popcli>
    struct proc *p;
    struct proc *curproc = myproc();

    acquire(&ptable.lock);
801047f0:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801047f7:	e8 54 13 00 00       	call   80105b50 <acquire>
    // Scan through table looking for exited children with same pid as the argument.
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801047fc:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
80104801:	eb 11                	jmp    80104814 <detach+0x44>
80104803:	90                   	nop
80104804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104808:	05 a8 00 00 00       	add    $0xa8,%eax
8010480d:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
80104812:	73 2c                	jae    80104840 <detach+0x70>
        if (p->parent != curproc)
80104814:	39 58 14             	cmp    %ebx,0x14(%eax)
80104817:	75 ef                	jne    80104808 <detach+0x38>
            continue;
        //check if the pid is same as argument
        if (p->pid == pid) {
80104819:	39 70 10             	cmp    %esi,0x10(%eax)
8010481c:	75 ea                	jne    80104808 <detach+0x38>
            //change the father of current proc
            p->parent = initproc;
8010481e:	8b 15 c0 c5 10 80    	mov    0x8010c5c0,%edx
80104824:	89 50 14             	mov    %edx,0x14(%eax)
            //release the ptable
            release(&ptable.lock);
80104827:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
8010482e:	e8 bd 13 00 00       	call   80105bf0 <release>
        }
    }
    //if got here - didn't find proc with pid as argument - exit with error
    release(&ptable.lock);
    return -1;
}
80104833:	83 c4 10             	add    $0x10,%esp
            return 0;
80104836:	31 c0                	xor    %eax,%eax
}
80104838:	5b                   	pop    %ebx
80104839:	5e                   	pop    %esi
8010483a:	5d                   	pop    %ebp
8010483b:	c3                   	ret    
8010483c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    release(&ptable.lock);
80104840:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104847:	e8 a4 13 00 00       	call   80105bf0 <release>
}
8010484c:	83 c4 10             	add    $0x10,%esp
    return -1;
8010484f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104854:	5b                   	pop    %ebx
80104855:	5e                   	pop    %esi
80104856:	5d                   	pop    %ebp
80104857:	c3                   	ret    
80104858:	90                   	nop
80104859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104860 <priority>:



void
priority(int prio){
80104860:	55                   	push   %ebp
80104861:	89 e5                	mov    %esp,%ebp
80104863:	83 ec 18             	sub    $0x18,%esp
80104866:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80104869:	89 75 fc             	mov    %esi,-0x4(%ebp)
8010486c:	8b 75 08             	mov    0x8(%ebp),%esi
    pushcli();
8010486f:	e8 fc 11 00 00       	call   80105a70 <pushcli>
    c = mycpu();
80104874:	e8 97 f1 ff ff       	call   80103a10 <mycpu>
    p = c->proc;
80104879:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
8010487f:	e8 2c 12 00 00       	call   80105ab0 <popcli>
    struct proc *curproc = myproc();
    if( curproc != null ) {
80104884:	85 db                	test   %ebx,%ebx
80104886:	74 38                	je     801048c0 <priority+0x60>
        acquire(&ptable.lock);
80104888:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
8010488f:	e8 bc 12 00 00       	call   80105b50 <acquire>

        if (currpolicy == 2) {
80104894:	a1 04 c0 10 80       	mov    0x8010c004,%eax
80104899:	83 f8 02             	cmp    $0x2,%eax
8010489c:	74 42                	je     801048e0 <priority+0x80>
            if (prio > 0 && prio < 11)
                curproc->priority = prio;
        }
        if (currpolicy == 3) {
8010489e:	a1 04 c0 10 80       	mov    0x8010c004,%eax
801048a3:	83 f8 03             	cmp    $0x3,%eax
801048a6:	74 28                	je     801048d0 <priority+0x70>
            if (prio >= 0 && prio < 11)
                curproc->priority = prio;
        }

        release(&ptable.lock);
801048a8:	c7 45 08 80 4d 11 80 	movl   $0x80114d80,0x8(%ebp)
    }
}
801048af:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801048b2:	8b 75 fc             	mov    -0x4(%ebp),%esi
801048b5:	89 ec                	mov    %ebp,%esp
801048b7:	5d                   	pop    %ebp
        release(&ptable.lock);
801048b8:	e9 33 13 00 00       	jmp    80105bf0 <release>
801048bd:	8d 76 00             	lea    0x0(%esi),%esi
}
801048c0:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801048c3:	8b 75 fc             	mov    -0x4(%ebp),%esi
801048c6:	89 ec                	mov    %ebp,%esp
801048c8:	5d                   	pop    %ebp
801048c9:	c3                   	ret    
801048ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            if (prio >= 0 && prio < 11)
801048d0:	83 fe 0a             	cmp    $0xa,%esi
801048d3:	77 d3                	ja     801048a8 <priority+0x48>
                curproc->priority = prio;
801048d5:	89 b3 88 00 00 00    	mov    %esi,0x88(%ebx)
801048db:	eb cb                	jmp    801048a8 <priority+0x48>
801048dd:	8d 76 00             	lea    0x0(%esi),%esi
            if (prio > 0 && prio < 11)
801048e0:	8d 46 ff             	lea    -0x1(%esi),%eax
801048e3:	83 f8 09             	cmp    $0x9,%eax
801048e6:	77 b6                	ja     8010489e <priority+0x3e>
                curproc->priority = prio;
801048e8:	89 b3 88 00 00 00    	mov    %esi,0x88(%ebx)
801048ee:	eb ae                	jmp    8010489e <priority+0x3e>

801048f0 <priorityUnExtended>:


void
priorityUnExtended(){
801048f0:	55                   	push   %ebp
    struct proc *p;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801048f1:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
priorityUnExtended(){
801048f6:	89 e5                	mov    %esp,%ebp
801048f8:	90                   	nop
801048f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if (p->priority == 0)
80104900:	8b 88 88 00 00 00    	mov    0x88(%eax),%ecx
80104906:	85 c9                	test   %ecx,%ecx
80104908:	75 0b                	jne    80104915 <priorityUnExtended+0x25>
            p->priority = 1;
8010490a:	ba 01 00 00 00       	mov    $0x1,%edx
8010490f:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104915:	05 a8 00 00 00       	add    $0xa8,%eax
8010491a:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
8010491f:	72 df                	jb     80104900 <priorityUnExtended+0x10>
    }
}
80104921:	5d                   	pop    %ebp
80104922:	c3                   	ret    
80104923:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104930 <switchToRoundRobin>:

void
switchToRoundRobin(void){
80104930:	55                   	push   %ebp
80104931:	89 e5                	mov    %esp,%ebp
80104933:	83 ec 18             	sub    $0x18,%esp
    struct proc *p;
    if(!pq.switchToRoundRobinPolicy())
80104936:	ff 15 f4 c5 10 80    	call   *0x8010c5f4
8010493c:	85 c0                	test   %eax,%eax
8010493e:	74 2b                	je     8010496b <switchToRoundRobin+0x3b>
        panic("error in switch from policy 2/3 to policy 1\n");
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104940:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
80104945:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        p->accumulator=0;
80104950:	31 d2                	xor    %edx,%edx
80104952:	31 c9                	xor    %ecx,%ecx
80104954:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
8010495a:	05 a8 00 00 00       	add    $0xa8,%eax
        p->accumulator=0;
8010495f:	89 48 dc             	mov    %ecx,-0x24(%eax)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104962:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
80104967:	72 e7                	jb     80104950 <switchToRoundRobin+0x20>
    }
}
80104969:	c9                   	leave  
8010496a:	c3                   	ret    
        panic("error in switch from policy 2/3 to policy 1\n");
8010496b:	c7 04 24 08 8f 10 80 	movl   $0x80108f08,(%esp)
80104972:	e8 f9 b9 ff ff       	call   80100370 <panic>
80104977:	89 f6                	mov    %esi,%esi
80104979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104980 <policy>:

void
policy(int num){
80104980:	55                   	push   %ebp
80104981:	89 e5                	mov    %esp,%ebp
80104983:	53                   	push   %ebx
80104984:	83 ec 14             	sub    $0x14,%esp
80104987:	8b 5d 08             	mov    0x8(%ebp),%ebx
    //check legal input
    //TODO- need to check if there is a need to change to default or to panic
    if(num>3 || num<1)
8010498a:	8d 43 ff             	lea    -0x1(%ebx),%eax
8010498d:	83 f8 02             	cmp    $0x2,%eax
80104990:	76 0e                	jbe    801049a0 <policy+0x20>
    }
    currpolicy=num; //save the new policy
    release(&ptable.lock);


}
80104992:	83 c4 14             	add    $0x14,%esp
80104995:	5b                   	pop    %ebx
80104996:	5d                   	pop    %ebp
80104997:	c3                   	ret    
80104998:	90                   	nop
80104999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("sti");
801049a0:	fb                   	sti    
    acquire(&ptable.lock);
801049a1:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801049a8:	e8 a3 11 00 00       	call   80105b50 <acquire>
    switch (currpolicy){
801049ad:	a1 04 c0 10 80       	mov    0x8010c004,%eax
801049b2:	83 f8 02             	cmp    $0x2,%eax
801049b5:	74 41                	je     801049f8 <policy+0x78>
801049b7:	83 f8 03             	cmp    $0x3,%eax
801049ba:	74 14                	je     801049d0 <policy+0x50>
801049bc:	48                   	dec    %eax
801049bd:	74 49                	je     80104a08 <policy+0x88>
            panic("illegal policy number\n");
801049bf:	c7 04 24 9d 8e 10 80 	movl   $0x80108e9d,(%esp)
801049c6:	e8 a5 b9 ff ff       	call   80100370 <panic>
801049cb:	90                   	nop
801049cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            if(num==1){
801049d0:	83 fb 01             	cmp    $0x1,%ebx
801049d3:	74 28                	je     801049fd <policy+0x7d>
            if(num==2){
801049d5:	83 fb 02             	cmp    $0x2,%ebx
801049d8:	74 6e                	je     80104a48 <policy+0xc8>
    currpolicy=num; //save the new policy
801049da:	89 1d 04 c0 10 80    	mov    %ebx,0x8010c004
    release(&ptable.lock);
801049e0:	c7 45 08 80 4d 11 80 	movl   $0x80114d80,0x8(%ebp)
}
801049e7:	83 c4 14             	add    $0x14,%esp
801049ea:	5b                   	pop    %ebx
801049eb:	5d                   	pop    %ebp
    release(&ptable.lock);
801049ec:	e9 ff 11 00 00       	jmp    80105bf0 <release>
801049f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            if(num==1){
801049f8:	83 fb 01             	cmp    $0x1,%ebx
801049fb:	75 dd                	jne    801049da <policy+0x5a>
                switchToRoundRobin();
801049fd:	e8 2e ff ff ff       	call   80104930 <switchToRoundRobin>
80104a02:	eb d6                	jmp    801049da <policy+0x5a>
80104a04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            if(num==2 || num==3){
80104a08:	8d 43 fe             	lea    -0x2(%ebx),%eax
80104a0b:	83 f8 01             	cmp    $0x1,%eax
80104a0e:	77 ca                	ja     801049da <policy+0x5a>
                rrq.switchToPriorityQueuePolicy();
80104a10:	ff 15 e0 c5 10 80    	call   *0x8010c5e0
                if(num==2)
80104a16:	83 fb 02             	cmp    $0x2,%ebx
80104a19:	75 bf                	jne    801049da <policy+0x5a>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104a1b:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
        if (p->priority == 0)
80104a20:	8b 88 88 00 00 00    	mov    0x88(%eax),%ecx
80104a26:	85 c9                	test   %ecx,%ecx
80104a28:	75 0b                	jne    80104a35 <policy+0xb5>
            p->priority = 1;
80104a2a:	ba 01 00 00 00       	mov    $0x1,%edx
80104a2f:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104a35:	05 a8 00 00 00       	add    $0xa8,%eax
80104a3a:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
80104a3f:	72 df                	jb     80104a20 <policy+0xa0>
80104a41:	eb 97                	jmp    801049da <policy+0x5a>
80104a43:	90                   	nop
80104a44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a48:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
80104a4d:	8d 76 00             	lea    0x0(%esi),%esi
        if (p->priority == 0)
80104a50:	8b 88 88 00 00 00    	mov    0x88(%eax),%ecx
80104a56:	85 c9                	test   %ecx,%ecx
80104a58:	75 0b                	jne    80104a65 <policy+0xe5>
            p->priority = 1;
80104a5a:	ba 01 00 00 00       	mov    $0x1,%edx
80104a5f:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104a65:	05 a8 00 00 00       	add    $0xa8,%eax
80104a6a:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
80104a6f:	72 df                	jb     80104a50 <policy+0xd0>
80104a71:	e9 64 ff ff ff       	jmp    801049da <policy+0x5a>
80104a76:	8d 76 00             	lea    0x0(%esi),%esi
80104a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a80 <wait_stat>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait_stat(int* status, struct perf* performance)
{
80104a80:	55                   	push   %ebp
80104a81:	89 e5                	mov    %esp,%ebp
80104a83:	57                   	push   %edi
80104a84:	56                   	push   %esi
80104a85:	53                   	push   %ebx
80104a86:	83 ec 1c             	sub    $0x1c,%esp
80104a89:	8b 7d 0c             	mov    0xc(%ebp),%edi
    pushcli();
80104a8c:	e8 df 0f 00 00       	call   80105a70 <pushcli>
    c = mycpu();
80104a91:	e8 7a ef ff ff       	call   80103a10 <mycpu>
    p = c->proc;
80104a96:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
    popcli();
80104a9c:	e8 0f 10 00 00       	call   80105ab0 <popcli>
    struct proc *p;
    int havekids, pid;
    struct proc *curproc = myproc();

    acquire(&ptable.lock);
80104aa1:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104aa8:	e8 a3 10 00 00       	call   80105b50 <acquire>
    for(;;){
        // Scan through table looking for exited children.
        havekids = 0;
80104aad:	31 c0                	xor    %eax,%eax
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104aaf:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
80104ab4:	eb 18                	jmp    80104ace <wait_stat+0x4e>
80104ab6:	8d 76 00             	lea    0x0(%esi),%esi
80104ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104ac0:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80104ac6:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
80104acc:	73 20                	jae    80104aee <wait_stat+0x6e>
            if(p->parent != curproc)
80104ace:	39 73 14             	cmp    %esi,0x14(%ebx)
80104ad1:	75 ed                	jne    80104ac0 <wait_stat+0x40>
                continue;
            havekids = 1;

            if(p->state == ZOMBIE){
80104ad3:	8b 43 0c             	mov    0xc(%ebx),%eax
80104ad6:	83 f8 05             	cmp    $0x5,%eax
80104ad9:	74 3d                	je     80104b18 <wait_stat+0x98>
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104adb:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
            havekids = 1;
80104ae1:	b8 01 00 00 00       	mov    $0x1,%eax
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104ae6:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
80104aec:	72 e0                	jb     80104ace <wait_stat+0x4e>
                return pid;
            }
        }

        // No point waiting if we don't have any children.
        if(!havekids || curproc->killed){
80104aee:	85 c0                	test   %eax,%eax
80104af0:	0f 84 b1 00 00 00    	je     80104ba7 <wait_stat+0x127>
80104af6:	8b 56 24             	mov    0x24(%esi),%edx
80104af9:	85 d2                	test   %edx,%edx
80104afb:	0f 85 a6 00 00 00    	jne    80104ba7 <wait_stat+0x127>
            release(&ptable.lock);
            return -1;
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104b01:	b8 80 4d 11 80       	mov    $0x80114d80,%eax
80104b06:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b0a:	89 34 24             	mov    %esi,(%esp)
80104b0d:	e8 ee f8 ff ff       	call   80104400 <sleep>
        havekids = 0;
80104b12:	eb 99                	jmp    80104aad <wait_stat+0x2d>
80104b14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                performance->ctime = p->proc_perf.ctime;
80104b18:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80104b1e:	89 07                	mov    %eax,(%edi)
                performance->ttime = p->proc_perf.ttime;
80104b20:	8b 83 90 00 00 00    	mov    0x90(%ebx),%eax
80104b26:	89 47 04             	mov    %eax,0x4(%edi)
                performance->stime = p->proc_perf.stime;
80104b29:	8b 83 94 00 00 00    	mov    0x94(%ebx),%eax
80104b2f:	89 47 08             	mov    %eax,0x8(%edi)
                performance->retime = p->proc_perf.retime;
80104b32:	8b 83 98 00 00 00    	mov    0x98(%ebx),%eax
80104b38:	89 47 0c             	mov    %eax,0xc(%edi)
                performance->rutime = p->proc_perf.rutime;
80104b3b:	8b 83 9c 00 00 00    	mov    0x9c(%ebx),%eax
80104b41:	89 47 10             	mov    %eax,0x10(%edi)
                kfree(p->kstack);
80104b44:	8b 43 08             	mov    0x8(%ebx),%eax
                pid = p->pid;
80104b47:	8b 73 10             	mov    0x10(%ebx),%esi
                kfree(p->kstack);
80104b4a:	89 04 24             	mov    %eax,(%esp)
80104b4d:	e8 8e d8 ff ff       	call   801023e0 <kfree>
                freevm(p->pgdir);
80104b52:	8b 43 04             	mov    0x4(%ebx),%eax
                p->kstack = 0;
80104b55:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
                freevm(p->pgdir);
80104b5c:	89 04 24             	mov    %eax,(%esp)
80104b5f:	e8 9c 39 00 00       	call   80108500 <freevm>
                if(status!=null)
80104b64:	8b 4d 08             	mov    0x8(%ebp),%ecx
                p->pid = 0;
80104b67:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
                p->parent = 0;
80104b6e:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
                p->name[0] = 0;
80104b75:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
                if(status!=null)
80104b79:	85 c9                	test   %ecx,%ecx
                p->killed = 0;
80104b7b:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
                p->state = UNUSED;
80104b82:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
                if(status!=null)
80104b89:	74 06                	je     80104b91 <wait_stat+0x111>
                    p->exit_status= (int)status ;
80104b8b:	8b 45 08             	mov    0x8(%ebp),%eax
80104b8e:	89 43 7c             	mov    %eax,0x7c(%ebx)
                release(&ptable.lock);
80104b91:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104b98:	e8 53 10 00 00       	call   80105bf0 <release>
    }
}
80104b9d:	83 c4 1c             	add    $0x1c,%esp
80104ba0:	89 f0                	mov    %esi,%eax
80104ba2:	5b                   	pop    %ebx
80104ba3:	5e                   	pop    %esi
80104ba4:	5f                   	pop    %edi
80104ba5:	5d                   	pop    %ebp
80104ba6:	c3                   	ret    
            release(&ptable.lock);
80104ba7:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
            return -1;
80104bae:	be ff ff ff ff       	mov    $0xffffffff,%esi
            release(&ptable.lock);
80104bb3:	e8 38 10 00 00       	call   80105bf0 <release>
            return -1;
80104bb8:	eb e3                	jmp    80104b9d <wait_stat+0x11d>
80104bba:	66 90                	xchg   %ax,%ax
80104bbc:	66 90                	xchg   %ax,%ax
80104bbe:	66 90                	xchg   %ax,%ax

80104bc0 <isEmptyPriorityQueue>:
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
80104bc0:	a1 14 c6 10 80       	mov    0x8010c614,%eax
static boolean isEmptyPriorityQueue() {
80104bc5:	55                   	push   %ebp
80104bc6:	89 e5                	mov    %esp,%ebp
}
80104bc8:	5d                   	pop    %ebp
	return !root;
80104bc9:	8b 00                	mov    (%eax),%eax
80104bcb:	85 c0                	test   %eax,%eax
80104bcd:	0f 94 c0             	sete   %al
80104bd0:	0f b6 c0             	movzbl %al,%eax
}
80104bd3:	c3                   	ret    
80104bd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104bda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104be0 <getMinAccumulatorPriorityQueue>:
	return !root;
80104be0:	a1 14 c6 10 80       	mov    0x8010c614,%eax
80104be5:	8b 10                	mov    (%eax),%edx
	
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
	if(isEmpty())
80104be7:	85 d2                	test   %edx,%edx
80104be9:	74 35                	je     80104c20 <getMinAccumulatorPriorityQueue+0x40>
static boolean getMinAccumulatorPriorityQueue(long long* pkey) {
80104beb:	55                   	push   %ebp
80104bec:	89 e5                	mov    %esp,%ebp
80104bee:	53                   	push   %ebx
80104bef:	eb 09                	jmp    80104bfa <getMinAccumulatorPriorityQueue+0x1a>
80104bf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	while(minNode->left)
80104bf8:	89 c2                	mov    %eax,%edx
80104bfa:	8b 42 18             	mov    0x18(%edx),%eax
80104bfd:	85 c0                	test   %eax,%eax
80104bff:	75 f7                	jne    80104bf8 <getMinAccumulatorPriorityQueue+0x18>
	*pkey = getMinNode()->key;
80104c01:	8b 45 08             	mov    0x8(%ebp),%eax
80104c04:	8b 5a 04             	mov    0x4(%edx),%ebx
80104c07:	8b 0a                	mov    (%edx),%ecx
80104c09:	89 58 04             	mov    %ebx,0x4(%eax)
80104c0c:	89 08                	mov    %ecx,(%eax)
80104c0e:	b8 01 00 00 00       	mov    $0x1,%eax
}
80104c13:	5b                   	pop    %ebx
80104c14:	5d                   	pop    %ebp
80104c15:	c3                   	ret    
80104c16:	8d 76 00             	lea    0x0(%esi),%esi
80104c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	if(isEmpty())
80104c20:	31 c0                	xor    %eax,%eax
}
80104c22:	c3                   	ret    
80104c23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c30 <isEmptyRoundRobinQueue>:
	return !first;
80104c30:	a1 10 c6 10 80       	mov    0x8010c610,%eax
static boolean isEmptyRoundRobinQueue() {
80104c35:	55                   	push   %ebp
80104c36:	89 e5                	mov    %esp,%ebp
}
80104c38:	5d                   	pop    %ebp
	return !first;
80104c39:	8b 00                	mov    (%eax),%eax
80104c3b:	85 c0                	test   %eax,%eax
80104c3d:	0f 94 c0             	sete   %al
80104c40:	0f b6 c0             	movzbl %al,%eax
}
80104c43:	c3                   	ret    
80104c44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104c50 <enqueueRoundRobinQueue>:
	if(!freeLinks)
80104c50:	a1 08 c6 10 80       	mov    0x8010c608,%eax
80104c55:	85 c0                	test   %eax,%eax
80104c57:	74 47                	je     80104ca0 <enqueueRoundRobinQueue+0x50>
static boolean enqueueRoundRobinQueue(Proc *p) {
80104c59:	55                   	push   %ebp
	return roundRobinQ->enqueue(p);
80104c5a:	8b 0d 10 c6 10 80    	mov    0x8010c610,%ecx
	freeLinks = freeLinks->next;
80104c60:	8b 50 04             	mov    0x4(%eax),%edx
static boolean enqueueRoundRobinQueue(Proc *p) {
80104c63:	89 e5                	mov    %esp,%ebp
	ans->next = null;
80104c65:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
80104c6c:	89 15 08 c6 10 80    	mov    %edx,0x8010c608
	ans->p = p;
80104c72:	8b 55 08             	mov    0x8(%ebp),%edx
80104c75:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80104c77:	8b 11                	mov    (%ecx),%edx
80104c79:	85 d2                	test   %edx,%edx
80104c7b:	74 2b                	je     80104ca8 <enqueueRoundRobinQueue+0x58>
	else last->next = link;
80104c7d:	8b 51 04             	mov    0x4(%ecx),%edx
80104c80:	89 42 04             	mov    %eax,0x4(%edx)
80104c83:	eb 05                	jmp    80104c8a <enqueueRoundRobinQueue+0x3a>
80104c85:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
80104c88:	89 d0                	mov    %edx,%eax
80104c8a:	8b 50 04             	mov    0x4(%eax),%edx
80104c8d:	85 d2                	test   %edx,%edx
80104c8f:	75 f7                	jne    80104c88 <enqueueRoundRobinQueue+0x38>
	last = link->getLast();
80104c91:	89 41 04             	mov    %eax,0x4(%ecx)
80104c94:	b8 01 00 00 00       	mov    $0x1,%eax
}
80104c99:	5d                   	pop    %ebp
80104c9a:	c3                   	ret    
80104c9b:	90                   	nop
80104c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!freeLinks)
80104ca0:	31 c0                	xor    %eax,%eax
}
80104ca2:	c3                   	ret    
80104ca3:	90                   	nop
80104ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
80104ca8:	89 01                	mov    %eax,(%ecx)
80104caa:	eb de                	jmp    80104c8a <enqueueRoundRobinQueue+0x3a>
80104cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104cb0 <dequeueRoundRobinQueue>:
	return roundRobinQ->dequeue();
80104cb0:	8b 0d 10 c6 10 80    	mov    0x8010c610,%ecx
	return !first;
80104cb6:	8b 11                	mov    (%ecx),%edx
	if(isEmpty())
80104cb8:	85 d2                	test   %edx,%edx
80104cba:	74 3c                	je     80104cf8 <dequeueRoundRobinQueue+0x48>
static Proc* dequeueRoundRobinQueue() {
80104cbc:	55                   	push   %ebp
80104cbd:	89 e5                	mov    %esp,%ebp
80104cbf:	83 ec 08             	sub    $0x8,%esp
80104cc2:	89 75 fc             	mov    %esi,-0x4(%ebp)
	link->next = freeLinks;
80104cc5:	8b 35 08 c6 10 80    	mov    0x8010c608,%esi
static Proc* dequeueRoundRobinQueue() {
80104ccb:	89 5d f8             	mov    %ebx,-0x8(%ebp)
	Link *next = first->next;
80104cce:	8b 5a 04             	mov    0x4(%edx),%ebx
	Proc *p = first->p;
80104cd1:	8b 02                	mov    (%edx),%eax
	link->next = freeLinks;
80104cd3:	89 72 04             	mov    %esi,0x4(%edx)
	freeLinks = link;
80104cd6:	89 15 08 c6 10 80    	mov    %edx,0x8010c608
	if(isEmpty())
80104cdc:	85 db                	test   %ebx,%ebx
	first = next;
80104cde:	89 19                	mov    %ebx,(%ecx)
	if(isEmpty())
80104ce0:	75 07                	jne    80104ce9 <dequeueRoundRobinQueue+0x39>
		last = null;
80104ce2:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
}
80104ce9:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104cec:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104cef:	89 ec                	mov    %ebp,%esp
80104cf1:	5d                   	pop    %ebp
80104cf2:	c3                   	ret    
80104cf3:	90                   	nop
80104cf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		return null;
80104cf8:	31 c0                	xor    %eax,%eax
}
80104cfa:	c3                   	ret    
80104cfb:	90                   	nop
80104cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104d00 <isEmptyRunningProcessHolder>:
	return !first;
80104d00:	a1 0c c6 10 80       	mov    0x8010c60c,%eax
static boolean isEmptyRunningProcessHolder() {
80104d05:	55                   	push   %ebp
80104d06:	89 e5                	mov    %esp,%ebp
}
80104d08:	5d                   	pop    %ebp
	return !first;
80104d09:	8b 00                	mov    (%eax),%eax
80104d0b:	85 c0                	test   %eax,%eax
80104d0d:	0f 94 c0             	sete   %al
80104d10:	0f b6 c0             	movzbl %al,%eax
}
80104d13:	c3                   	ret    
80104d14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104d20 <addRunningProcessHolder>:
	if(!freeLinks)
80104d20:	a1 08 c6 10 80       	mov    0x8010c608,%eax
80104d25:	85 c0                	test   %eax,%eax
80104d27:	74 47                	je     80104d70 <addRunningProcessHolder+0x50>
static boolean addRunningProcessHolder(Proc* p) {
80104d29:	55                   	push   %ebp
	return runningProcHolder->enqueue(p);
80104d2a:	8b 0d 0c c6 10 80    	mov    0x8010c60c,%ecx
	freeLinks = freeLinks->next;
80104d30:	8b 50 04             	mov    0x4(%eax),%edx
static boolean addRunningProcessHolder(Proc* p) {
80104d33:	89 e5                	mov    %esp,%ebp
	ans->next = null;
80104d35:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
80104d3c:	89 15 08 c6 10 80    	mov    %edx,0x8010c608
	ans->p = p;
80104d42:	8b 55 08             	mov    0x8(%ebp),%edx
80104d45:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80104d47:	8b 11                	mov    (%ecx),%edx
80104d49:	85 d2                	test   %edx,%edx
80104d4b:	74 2b                	je     80104d78 <addRunningProcessHolder+0x58>
	else last->next = link;
80104d4d:	8b 51 04             	mov    0x4(%ecx),%edx
80104d50:	89 42 04             	mov    %eax,0x4(%edx)
80104d53:	eb 05                	jmp    80104d5a <addRunningProcessHolder+0x3a>
80104d55:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
80104d58:	89 d0                	mov    %edx,%eax
80104d5a:	8b 50 04             	mov    0x4(%eax),%edx
80104d5d:	85 d2                	test   %edx,%edx
80104d5f:	75 f7                	jne    80104d58 <addRunningProcessHolder+0x38>
	last = link->getLast();
80104d61:	89 41 04             	mov    %eax,0x4(%ecx)
80104d64:	b8 01 00 00 00       	mov    $0x1,%eax
}
80104d69:	5d                   	pop    %ebp
80104d6a:	c3                   	ret    
80104d6b:	90                   	nop
80104d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!freeLinks)
80104d70:	31 c0                	xor    %eax,%eax
}
80104d72:	c3                   	ret    
80104d73:	90                   	nop
80104d74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
80104d78:	89 01                	mov    %eax,(%ecx)
80104d7a:	eb de                	jmp    80104d5a <addRunningProcessHolder+0x3a>
80104d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104d80 <_ZL9allocNodeP4procx>:
static MapNode* allocNode(Proc *p, long long key) {
80104d80:	55                   	push   %ebp
80104d81:	89 e5                	mov    %esp,%ebp
80104d83:	56                   	push   %esi
80104d84:	53                   	push   %ebx
	if(!freeNodes)
80104d85:	8b 1d 04 c6 10 80    	mov    0x8010c604,%ebx
80104d8b:	85 db                	test   %ebx,%ebx
80104d8d:	74 4d                	je     80104ddc <_ZL9allocNodeP4procx+0x5c>
	ans->key = key;
80104d8f:	89 13                	mov    %edx,(%ebx)
	if(!freeLinks)
80104d91:	8b 15 08 c6 10 80    	mov    0x8010c608,%edx
	freeNodes = freeNodes->next;
80104d97:	8b 73 10             	mov    0x10(%ebx),%esi
	ans->key = key;
80104d9a:	89 4b 04             	mov    %ecx,0x4(%ebx)
	ans->next = null;
80104d9d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
	if(!freeLinks)
80104da4:	85 d2                	test   %edx,%edx
	freeNodes = freeNodes->next;
80104da6:	89 35 04 c6 10 80    	mov    %esi,0x8010c604
	if(!freeLinks)
80104dac:	74 3f                	je     80104ded <_ZL9allocNodeP4procx+0x6d>
	freeLinks = freeLinks->next;
80104dae:	8b 4a 04             	mov    0x4(%edx),%ecx
	ans->p = p;
80104db1:	89 02                	mov    %eax,(%edx)
	ans->next = null;
80104db3:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
	if(isEmpty()) first = link;
80104dba:	8b 43 08             	mov    0x8(%ebx),%eax
	freeLinks = freeLinks->next;
80104dbd:	89 0d 08 c6 10 80    	mov    %ecx,0x8010c608
	if(isEmpty()) first = link;
80104dc3:	85 c0                	test   %eax,%eax
80104dc5:	74 21                	je     80104de8 <_ZL9allocNodeP4procx+0x68>
	else last->next = link;
80104dc7:	8b 43 0c             	mov    0xc(%ebx),%eax
80104dca:	89 50 04             	mov    %edx,0x4(%eax)
80104dcd:	eb 03                	jmp    80104dd2 <_ZL9allocNodeP4procx+0x52>
80104dcf:	90                   	nop
	while(ans->next)
80104dd0:	89 ca                	mov    %ecx,%edx
80104dd2:	8b 4a 04             	mov    0x4(%edx),%ecx
80104dd5:	85 c9                	test   %ecx,%ecx
80104dd7:	75 f7                	jne    80104dd0 <_ZL9allocNodeP4procx+0x50>
	last = link->getLast();
80104dd9:	89 53 0c             	mov    %edx,0xc(%ebx)
}
80104ddc:	89 d8                	mov    %ebx,%eax
80104dde:	5b                   	pop    %ebx
80104ddf:	5e                   	pop    %esi
80104de0:	5d                   	pop    %ebp
80104de1:	c3                   	ret    
80104de2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	if(isEmpty()) first = link;
80104de8:	89 53 08             	mov    %edx,0x8(%ebx)
80104deb:	eb e5                	jmp    80104dd2 <_ZL9allocNodeP4procx+0x52>
	node->parent = node->left = node->right = null;
80104ded:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
80104df4:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
80104dfb:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
	node->next = freeNodes;
80104e02:	89 73 10             	mov    %esi,0x10(%ebx)
	freeNodes = node;
80104e05:	89 1d 04 c6 10 80    	mov    %ebx,0x8010c604
		return null;
80104e0b:	31 db                	xor    %ebx,%ebx
80104e0d:	eb cd                	jmp    80104ddc <_ZL9allocNodeP4procx+0x5c>
80104e0f:	90                   	nop

80104e10 <_ZL8mymallocj>:
static char* mymalloc(uint size) {
80104e10:	55                   	push   %ebp
80104e11:	89 e5                	mov    %esp,%ebp
80104e13:	53                   	push   %ebx
80104e14:	89 c3                	mov    %eax,%ebx
80104e16:	83 ec 14             	sub    $0x14,%esp
	if(spaceLeft < size) {
80104e19:	8b 15 fc c5 10 80    	mov    0x8010c5fc,%edx
80104e1f:	39 c2                	cmp    %eax,%edx
80104e21:	73 26                	jae    80104e49 <_ZL8mymallocj+0x39>
		data = kalloc();
80104e23:	e8 88 d7 ff ff       	call   801025b0 <kalloc>
		memset(data, 0, PGSIZE);
80104e28:	ba 00 10 00 00       	mov    $0x1000,%edx
80104e2d:	31 c9                	xor    %ecx,%ecx
80104e2f:	89 54 24 08          	mov    %edx,0x8(%esp)
80104e33:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80104e37:	89 04 24             	mov    %eax,(%esp)
		data = kalloc();
80104e3a:	a3 00 c6 10 80       	mov    %eax,0x8010c600
		memset(data, 0, PGSIZE);
80104e3f:	e8 fc 0d 00 00       	call   80105c40 <memset>
80104e44:	ba 00 10 00 00       	mov    $0x1000,%edx
	char* ans = data;
80104e49:	a1 00 c6 10 80       	mov    0x8010c600,%eax
	spaceLeft -= size;
80104e4e:	29 da                	sub    %ebx,%edx
80104e50:	89 15 fc c5 10 80    	mov    %edx,0x8010c5fc
	data += size;
80104e56:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
80104e59:	89 0d 00 c6 10 80    	mov    %ecx,0x8010c600
}
80104e5f:	83 c4 14             	add    $0x14,%esp
80104e62:	5b                   	pop    %ebx
80104e63:	5d                   	pop    %ebp
80104e64:	c3                   	ret    
80104e65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e70 <initSchedDS>:
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104e70:	55                   	push   %ebp
	data               = null;
80104e71:	31 c0                	xor    %eax,%eax
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104e73:	89 e5                	mov    %esp,%ebp
80104e75:	53                   	push   %ebx
	freeLinks = null;
80104e76:	bb 80 00 00 00       	mov    $0x80,%ebx
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104e7b:	83 ec 04             	sub    $0x4,%esp
	data               = null;
80104e7e:	a3 00 c6 10 80       	mov    %eax,0x8010c600
	spaceLeft          = 0u;
80104e83:	31 c0                	xor    %eax,%eax
80104e85:	a3 fc c5 10 80       	mov    %eax,0x8010c5fc
	priorityQ          = (Map*)mymalloc(sizeof(Map));
80104e8a:	b8 04 00 00 00       	mov    $0x4,%eax
80104e8f:	e8 7c ff ff ff       	call   80104e10 <_ZL8mymallocj>
80104e94:	a3 14 c6 10 80       	mov    %eax,0x8010c614
	*priorityQ         = Map();
80104e99:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	roundRobinQ        = (LinkedList*)mymalloc(sizeof(LinkedList));
80104e9f:	b8 08 00 00 00       	mov    $0x8,%eax
80104ea4:	e8 67 ff ff ff       	call   80104e10 <_ZL8mymallocj>
80104ea9:	a3 10 c6 10 80       	mov    %eax,0x8010c610
	*roundRobinQ       = LinkedList();
80104eae:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104eb4:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	runningProcHolder  = (LinkedList*)mymalloc(sizeof(LinkedList));
80104ebb:	b8 08 00 00 00       	mov    $0x8,%eax
80104ec0:	e8 4b ff ff ff       	call   80104e10 <_ZL8mymallocj>
80104ec5:	a3 0c c6 10 80       	mov    %eax,0x8010c60c
	*runningProcHolder = LinkedList();
80104eca:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104ed0:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = null;
80104ed7:	31 c0                	xor    %eax,%eax
80104ed9:	a3 08 c6 10 80       	mov    %eax,0x8010c608
80104ede:	66 90                	xchg   %ax,%ax
		Link *link = (Link*)mymalloc(sizeof(Link));
80104ee0:	b8 08 00 00 00       	mov    $0x8,%eax
80104ee5:	e8 26 ff ff ff       	call   80104e10 <_ZL8mymallocj>
		link->next = freeLinks;
80104eea:	8b 15 08 c6 10 80    	mov    0x8010c608,%edx
	for(int i = 0; i < NPROCLIST; ++i) {
80104ef0:	4b                   	dec    %ebx
		*link = Link();
80104ef1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		link->next = freeLinks;
80104ef7:	89 50 04             	mov    %edx,0x4(%eax)
		freeLinks = link;
80104efa:	a3 08 c6 10 80       	mov    %eax,0x8010c608
	for(int i = 0; i < NPROCLIST; ++i) {
80104eff:	75 df                	jne    80104ee0 <initSchedDS+0x70>
	freeNodes = null;
80104f01:	31 c0                	xor    %eax,%eax
80104f03:	bb 80 00 00 00       	mov    $0x80,%ebx
80104f08:	a3 04 c6 10 80       	mov    %eax,0x8010c604
80104f0d:	8d 76 00             	lea    0x0(%esi),%esi
		MapNode *node = (MapNode*)mymalloc(sizeof(MapNode));
80104f10:	b8 20 00 00 00       	mov    $0x20,%eax
80104f15:	e8 f6 fe ff ff       	call   80104e10 <_ZL8mymallocj>
		node->next = freeNodes;
80104f1a:	8b 15 04 c6 10 80    	mov    0x8010c604,%edx
	for(int i = 0; i < NPROCMAP; ++i) {
80104f20:	4b                   	dec    %ebx
		*node = MapNode();
80104f21:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80104f28:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
80104f2f:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
80104f36:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
80104f3d:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
		node->next = freeNodes;
80104f44:	89 50 10             	mov    %edx,0x10(%eax)
		freeNodes = node;
80104f47:	a3 04 c6 10 80       	mov    %eax,0x8010c604
	for(int i = 0; i < NPROCMAP; ++i) {
80104f4c:	75 c2                	jne    80104f10 <initSchedDS+0xa0>
	pq.isEmpty                      = isEmptyPriorityQueue;
80104f4e:	b8 c0 4b 10 80       	mov    $0x80104bc0,%eax
	pq.put                          = putPriorityQueue;
80104f53:	ba 40 55 10 80       	mov    $0x80105540,%edx
	pq.isEmpty                      = isEmptyPriorityQueue;
80104f58:	a3 e4 c5 10 80       	mov    %eax,0x8010c5e4
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
80104f5d:	b8 00 57 10 80       	mov    $0x80105700,%eax
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
80104f62:	b9 e0 4b 10 80       	mov    $0x80104be0,%ecx
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
80104f67:	a3 f4 c5 10 80       	mov    %eax,0x8010c5f4
	pq.extractProc                  = extractProcPriorityQueue;
80104f6c:	b8 e0 57 10 80       	mov    $0x801057e0,%eax
	pq.extractMin                   = extractMinPriorityQueue;
80104f71:	bb 60 56 10 80       	mov    $0x80105660,%ebx
	pq.extractProc                  = extractProcPriorityQueue;
80104f76:	a3 f8 c5 10 80       	mov    %eax,0x8010c5f8
	rrq.isEmpty                     = isEmptyRoundRobinQueue;
80104f7b:	b8 30 4c 10 80       	mov    $0x80104c30,%eax
80104f80:	a3 d4 c5 10 80       	mov    %eax,0x8010c5d4
	rrq.enqueue                     = enqueueRoundRobinQueue;
80104f85:	b8 50 4c 10 80       	mov    $0x80104c50,%eax
80104f8a:	a3 d8 c5 10 80       	mov    %eax,0x8010c5d8
	rrq.dequeue                     = dequeueRoundRobinQueue;
80104f8f:	b8 b0 4c 10 80       	mov    $0x80104cb0,%eax
80104f94:	a3 dc c5 10 80       	mov    %eax,0x8010c5dc
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;
80104f99:	b8 70 52 10 80       	mov    $0x80105270,%eax
	pq.put                          = putPriorityQueue;
80104f9e:	89 15 e8 c5 10 80    	mov    %edx,0x8010c5e8
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
80104fa4:	ba 00 4d 10 80       	mov    $0x80104d00,%edx
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
80104fa9:	89 0d ec c5 10 80    	mov    %ecx,0x8010c5ec
	rpholder.add                    = addRunningProcessHolder;
80104faf:	b9 20 4d 10 80       	mov    $0x80104d20,%ecx
	pq.extractMin                   = extractMinPriorityQueue;
80104fb4:	89 1d f0 c5 10 80    	mov    %ebx,0x8010c5f0
	rpholder.remove                 = removeRunningProcessHolder;
80104fba:	bb d0 51 10 80       	mov    $0x801051d0,%ebx
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;
80104fbf:	a3 e0 c5 10 80       	mov    %eax,0x8010c5e0
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
80104fc4:	b8 00 53 10 80       	mov    $0x80105300,%eax
	rpholder.remove                 = removeRunningProcessHolder;
80104fc9:	89 1d cc c5 10 80    	mov    %ebx,0x8010c5cc
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
80104fcf:	89 15 c4 c5 10 80    	mov    %edx,0x8010c5c4
	rpholder.add                    = addRunningProcessHolder;
80104fd5:	89 0d c8 c5 10 80    	mov    %ecx,0x8010c5c8
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
80104fdb:	a3 d0 c5 10 80       	mov    %eax,0x8010c5d0
}
80104fe0:	58                   	pop    %eax
80104fe1:	5b                   	pop    %ebx
80104fe2:	5d                   	pop    %ebp
80104fe3:	c3                   	ret    
80104fe4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104fea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104ff0 <_ZN4Link7getLastEv>:
Link* Link::getLast() {
80104ff0:	55                   	push   %ebp
80104ff1:	89 e5                	mov    %esp,%ebp
80104ff3:	8b 45 08             	mov    0x8(%ebp),%eax
80104ff6:	eb 0a                	jmp    80105002 <_ZN4Link7getLastEv+0x12>
80104ff8:	90                   	nop
80104ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105000:	89 d0                	mov    %edx,%eax
	while(ans->next)
80105002:	8b 50 04             	mov    0x4(%eax),%edx
80105005:	85 d2                	test   %edx,%edx
80105007:	75 f7                	jne    80105000 <_ZN4Link7getLastEv+0x10>
}
80105009:	5d                   	pop    %ebp
8010500a:	c3                   	ret    
8010500b:	90                   	nop
8010500c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105010 <_ZN10LinkedList7isEmptyEv>:
bool LinkedList::isEmpty() {
80105010:	55                   	push   %ebp
80105011:	89 e5                	mov    %esp,%ebp
	return !first;
80105013:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105016:	5d                   	pop    %ebp
	return !first;
80105017:	8b 00                	mov    (%eax),%eax
80105019:	85 c0                	test   %eax,%eax
8010501b:	0f 94 c0             	sete   %al
}
8010501e:	c3                   	ret    
8010501f:	90                   	nop

80105020 <_ZN10LinkedList6appendEP4Link>:
void LinkedList::append(Link *link) {
80105020:	55                   	push   %ebp
80105021:	89 e5                	mov    %esp,%ebp
80105023:	8b 55 0c             	mov    0xc(%ebp),%edx
80105026:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!link)
80105029:	85 d2                	test   %edx,%edx
8010502b:	74 1f                	je     8010504c <_ZN10LinkedList6appendEP4Link+0x2c>
	if(isEmpty()) first = link;
8010502d:	8b 01                	mov    (%ecx),%eax
8010502f:	85 c0                	test   %eax,%eax
80105031:	74 1d                	je     80105050 <_ZN10LinkedList6appendEP4Link+0x30>
	else last->next = link;
80105033:	8b 41 04             	mov    0x4(%ecx),%eax
80105036:	89 50 04             	mov    %edx,0x4(%eax)
80105039:	eb 07                	jmp    80105042 <_ZN10LinkedList6appendEP4Link+0x22>
8010503b:	90                   	nop
8010503c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	while(ans->next)
80105040:	89 c2                	mov    %eax,%edx
80105042:	8b 42 04             	mov    0x4(%edx),%eax
80105045:	85 c0                	test   %eax,%eax
80105047:	75 f7                	jne    80105040 <_ZN10LinkedList6appendEP4Link+0x20>
	last = link->getLast();
80105049:	89 51 04             	mov    %edx,0x4(%ecx)
}
8010504c:	5d                   	pop    %ebp
8010504d:	c3                   	ret    
8010504e:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
80105050:	89 11                	mov    %edx,(%ecx)
80105052:	eb ee                	jmp    80105042 <_ZN10LinkedList6appendEP4Link+0x22>
80105054:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010505a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105060 <_ZN10LinkedList7enqueueEP4proc>:
	if(!freeLinks)
80105060:	a1 08 c6 10 80       	mov    0x8010c608,%eax
bool LinkedList::enqueue(Proc *p) {
80105065:	55                   	push   %ebp
80105066:	89 e5                	mov    %esp,%ebp
80105068:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!freeLinks)
8010506b:	85 c0                	test   %eax,%eax
8010506d:	74 41                	je     801050b0 <_ZN10LinkedList7enqueueEP4proc+0x50>
	freeLinks = freeLinks->next;
8010506f:	8b 50 04             	mov    0x4(%eax),%edx
	ans->next = null;
80105072:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
80105079:	89 15 08 c6 10 80    	mov    %edx,0x8010c608
	ans->p = p;
8010507f:	8b 55 0c             	mov    0xc(%ebp),%edx
80105082:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80105084:	8b 11                	mov    (%ecx),%edx
80105086:	85 d2                	test   %edx,%edx
80105088:	74 2e                	je     801050b8 <_ZN10LinkedList7enqueueEP4proc+0x58>
	else last->next = link;
8010508a:	8b 51 04             	mov    0x4(%ecx),%edx
8010508d:	89 42 04             	mov    %eax,0x4(%edx)
80105090:	eb 08                	jmp    8010509a <_ZN10LinkedList7enqueueEP4proc+0x3a>
80105092:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	while(ans->next)
80105098:	89 d0                	mov    %edx,%eax
8010509a:	8b 50 04             	mov    0x4(%eax),%edx
8010509d:	85 d2                	test   %edx,%edx
8010509f:	75 f7                	jne    80105098 <_ZN10LinkedList7enqueueEP4proc+0x38>
	last = link->getLast();
801050a1:	89 41 04             	mov    %eax,0x4(%ecx)
	return true;
801050a4:	b0 01                	mov    $0x1,%al
}
801050a6:	5d                   	pop    %ebp
801050a7:	c3                   	ret    
801050a8:	90                   	nop
801050a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return false;
801050b0:	31 c0                	xor    %eax,%eax
}
801050b2:	5d                   	pop    %ebp
801050b3:	c3                   	ret    
801050b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
801050b8:	89 01                	mov    %eax,(%ecx)
801050ba:	eb de                	jmp    8010509a <_ZN10LinkedList7enqueueEP4proc+0x3a>
801050bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801050c0 <_ZN10LinkedList7dequeueEv>:
Proc* LinkedList::dequeue() {
801050c0:	55                   	push   %ebp
801050c1:	89 e5                	mov    %esp,%ebp
801050c3:	83 ec 08             	sub    $0x8,%esp
801050c6:	8b 4d 08             	mov    0x8(%ebp),%ecx
801050c9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801050cc:	89 75 fc             	mov    %esi,-0x4(%ebp)
	return !first;
801050cf:	8b 11                	mov    (%ecx),%edx
	if(isEmpty())
801050d1:	85 d2                	test   %edx,%edx
801050d3:	74 2b                	je     80105100 <_ZN10LinkedList7dequeueEv+0x40>
	Link *next = first->next;
801050d5:	8b 5a 04             	mov    0x4(%edx),%ebx
	link->next = freeLinks;
801050d8:	8b 35 08 c6 10 80    	mov    0x8010c608,%esi
	Proc *p = first->p;
801050de:	8b 02                	mov    (%edx),%eax
	freeLinks = link;
801050e0:	89 15 08 c6 10 80    	mov    %edx,0x8010c608
	if(isEmpty())
801050e6:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
801050e8:	89 72 04             	mov    %esi,0x4(%edx)
	first = next;
801050eb:	89 19                	mov    %ebx,(%ecx)
	if(isEmpty())
801050ed:	75 07                	jne    801050f6 <_ZN10LinkedList7dequeueEv+0x36>
		last = null;
801050ef:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
}
801050f6:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801050f9:	8b 75 fc             	mov    -0x4(%ebp),%esi
801050fc:	89 ec                	mov    %ebp,%esp
801050fe:	5d                   	pop    %ebp
801050ff:	c3                   	ret    
		return null;
80105100:	31 c0                	xor    %eax,%eax
80105102:	eb f2                	jmp    801050f6 <_ZN10LinkedList7dequeueEv+0x36>
80105104:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010510a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105110 <_ZN10LinkedList6removeEP4proc>:
bool LinkedList::remove(Proc *p) {
80105110:	55                   	push   %ebp
80105111:	89 e5                	mov    %esp,%ebp
80105113:	56                   	push   %esi
80105114:	8b 75 08             	mov    0x8(%ebp),%esi
80105117:	53                   	push   %ebx
80105118:	8b 4d 0c             	mov    0xc(%ebp),%ecx
	return !first;
8010511b:	8b 1e                	mov    (%esi),%ebx
	if(isEmpty())
8010511d:	85 db                	test   %ebx,%ebx
8010511f:	74 2f                	je     80105150 <_ZN10LinkedList6removeEP4proc+0x40>
	if(first->p == p) {
80105121:	39 0b                	cmp    %ecx,(%ebx)
80105123:	8b 53 04             	mov    0x4(%ebx),%edx
80105126:	74 70                	je     80105198 <_ZN10LinkedList6removeEP4proc+0x88>
	while(cur) {
80105128:	85 d2                	test   %edx,%edx
8010512a:	74 24                	je     80105150 <_ZN10LinkedList6removeEP4proc+0x40>
		if(cur->p == p) {
8010512c:	3b 0a                	cmp    (%edx),%ecx
8010512e:	66 90                	xchg   %ax,%ax
80105130:	75 0c                	jne    8010513e <_ZN10LinkedList6removeEP4proc+0x2e>
80105132:	eb 2c                	jmp    80105160 <_ZN10LinkedList6removeEP4proc+0x50>
80105134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105138:	39 08                	cmp    %ecx,(%eax)
8010513a:	74 34                	je     80105170 <_ZN10LinkedList6removeEP4proc+0x60>
8010513c:	89 c2                	mov    %eax,%edx
		cur = cur->next;
8010513e:	8b 42 04             	mov    0x4(%edx),%eax
	while(cur) {
80105141:	85 c0                	test   %eax,%eax
80105143:	75 f3                	jne    80105138 <_ZN10LinkedList6removeEP4proc+0x28>
}
80105145:	5b                   	pop    %ebx
80105146:	5e                   	pop    %esi
80105147:	5d                   	pop    %ebp
80105148:	c3                   	ret    
80105149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105150:	5b                   	pop    %ebx
		return false;
80105151:	31 c0                	xor    %eax,%eax
}
80105153:	5e                   	pop    %esi
80105154:	5d                   	pop    %ebp
80105155:	c3                   	ret    
80105156:	8d 76 00             	lea    0x0(%esi),%esi
80105159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		if(cur->p == p) {
80105160:	89 d0                	mov    %edx,%eax
80105162:	89 da                	mov    %ebx,%edx
80105164:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010516a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
			prev->next = cur->next;
80105170:	8b 48 04             	mov    0x4(%eax),%ecx
80105173:	89 4a 04             	mov    %ecx,0x4(%edx)
			if(!(cur->next)) //removes the last link
80105176:	8b 48 04             	mov    0x4(%eax),%ecx
80105179:	85 c9                	test   %ecx,%ecx
8010517b:	74 43                	je     801051c0 <_ZN10LinkedList6removeEP4proc+0xb0>
	link->next = freeLinks;
8010517d:	8b 15 08 c6 10 80    	mov    0x8010c608,%edx
	freeLinks = link;
80105183:	a3 08 c6 10 80       	mov    %eax,0x8010c608
	link->next = freeLinks;
80105188:	89 50 04             	mov    %edx,0x4(%eax)
			return true;
8010518b:	b0 01                	mov    $0x1,%al
}
8010518d:	5b                   	pop    %ebx
8010518e:	5e                   	pop    %esi
8010518f:	5d                   	pop    %ebp
80105190:	c3                   	ret    
80105191:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	link->next = freeLinks;
80105198:	a1 08 c6 10 80       	mov    0x8010c608,%eax
	if(isEmpty())
8010519d:	85 d2                	test   %edx,%edx
	freeLinks = link;
8010519f:	89 1d 08 c6 10 80    	mov    %ebx,0x8010c608
	link->next = freeLinks;
801051a5:	89 43 04             	mov    %eax,0x4(%ebx)
		return true;
801051a8:	b0 01                	mov    $0x1,%al
	first = next;
801051aa:	89 16                	mov    %edx,(%esi)
	if(isEmpty())
801051ac:	75 97                	jne    80105145 <_ZN10LinkedList6removeEP4proc+0x35>
		last = null;
801051ae:	c7 46 04 00 00 00 00 	movl   $0x0,0x4(%esi)
801051b5:	eb 8e                	jmp    80105145 <_ZN10LinkedList6removeEP4proc+0x35>
801051b7:	89 f6                	mov    %esi,%esi
801051b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
				last = prev;
801051c0:	89 56 04             	mov    %edx,0x4(%esi)
801051c3:	eb b8                	jmp    8010517d <_ZN10LinkedList6removeEP4proc+0x6d>
801051c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801051c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801051d0 <removeRunningProcessHolder>:
static boolean removeRunningProcessHolder(Proc* p) {
801051d0:	55                   	push   %ebp
801051d1:	89 e5                	mov    %esp,%ebp
801051d3:	83 ec 08             	sub    $0x8,%esp
	return runningProcHolder->remove(p);
801051d6:	8b 45 08             	mov    0x8(%ebp),%eax
801051d9:	89 44 24 04          	mov    %eax,0x4(%esp)
801051dd:	a1 0c c6 10 80       	mov    0x8010c60c,%eax
801051e2:	89 04 24             	mov    %eax,(%esp)
801051e5:	e8 26 ff ff ff       	call   80105110 <_ZN10LinkedList6removeEP4proc>
}
801051ea:	c9                   	leave  
	return runningProcHolder->remove(p);
801051eb:	0f b6 c0             	movzbl %al,%eax
}
801051ee:	c3                   	ret    
801051ef:	90                   	nop

801051f0 <_ZN10LinkedList8transferEv>:
	if(!priorityQ->isEmpty())
801051f0:	8b 15 14 c6 10 80    	mov    0x8010c614,%edx
		return false;
801051f6:	31 c0                	xor    %eax,%eax
bool LinkedList::transfer() {
801051f8:	55                   	push   %ebp
801051f9:	89 e5                	mov    %esp,%ebp
801051fb:	53                   	push   %ebx
801051fc:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!priorityQ->isEmpty())
801051ff:	8b 1a                	mov    (%edx),%ebx
80105201:	85 db                	test   %ebx,%ebx
80105203:	74 0b                	je     80105210 <_ZN10LinkedList8transferEv+0x20>
}
80105205:	5b                   	pop    %ebx
80105206:	5d                   	pop    %ebp
80105207:	c3                   	ret    
80105208:	90                   	nop
80105209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	if(!isEmpty()) {
80105210:	8b 19                	mov    (%ecx),%ebx
80105212:	85 db                	test   %ebx,%ebx
80105214:	74 4a                	je     80105260 <_ZN10LinkedList8transferEv+0x70>
	if(!freeNodes)
80105216:	8b 1d 04 c6 10 80    	mov    0x8010c604,%ebx
8010521c:	85 db                	test   %ebx,%ebx
8010521e:	74 e5                	je     80105205 <_ZN10LinkedList8transferEv+0x15>
	freeNodes = freeNodes->next;
80105220:	8b 43 10             	mov    0x10(%ebx),%eax
	ans->key = key;
80105223:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
	ans->next = null;
80105229:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
	ans->key = key;
80105230:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
	freeNodes = freeNodes->next;
80105237:	a3 04 c6 10 80       	mov    %eax,0x8010c604
		node->listOfProcs.first = first;
8010523c:	8b 01                	mov    (%ecx),%eax
8010523e:	89 43 08             	mov    %eax,0x8(%ebx)
		node->listOfProcs.last = last;
80105241:	8b 41 04             	mov    0x4(%ecx),%eax
80105244:	89 43 0c             	mov    %eax,0xc(%ebx)
	return true;
80105247:	b0 01                	mov    $0x1,%al
		first = last = null;
80105249:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
80105250:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
		priorityQ->root = node;
80105256:	89 1a                	mov    %ebx,(%edx)
}
80105258:	5b                   	pop    %ebx
80105259:	5d                   	pop    %ebp
8010525a:	c3                   	ret    
8010525b:	90                   	nop
8010525c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	return true;
80105260:	b0 01                	mov    $0x1,%al
80105262:	eb a1                	jmp    80105205 <_ZN10LinkedList8transferEv+0x15>
80105264:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010526a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105270 <switchToPriorityQueuePolicyRoundRobinQueue>:
static boolean switchToPriorityQueuePolicyRoundRobinQueue() {
80105270:	55                   	push   %ebp
80105271:	89 e5                	mov    %esp,%ebp
80105273:	83 ec 04             	sub    $0x4,%esp
	return roundRobinQ->transfer();
80105276:	a1 10 c6 10 80       	mov    0x8010c610,%eax
8010527b:	89 04 24             	mov    %eax,(%esp)
8010527e:	e8 6d ff ff ff       	call   801051f0 <_ZN10LinkedList8transferEv>
}
80105283:	c9                   	leave  
	return roundRobinQ->transfer();
80105284:	0f b6 c0             	movzbl %al,%eax
}
80105287:	c3                   	ret    
80105288:	90                   	nop
80105289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105290 <_ZN10LinkedList9getMinKeyEPx>:
bool LinkedList::getMinKey(long long *pkey) {
80105290:	55                   	push   %ebp
80105291:	31 c0                	xor    %eax,%eax
80105293:	89 e5                	mov    %esp,%ebp
80105295:	57                   	push   %edi
80105296:	56                   	push   %esi
80105297:	53                   	push   %ebx
80105298:	83 ec 1c             	sub    $0x1c,%esp
8010529b:	8b 7d 08             	mov    0x8(%ebp),%edi
	return !first;
8010529e:	8b 17                	mov    (%edi),%edx
	if(isEmpty())
801052a0:	85 d2                	test   %edx,%edx
801052a2:	74 41                	je     801052e5 <_ZN10LinkedList9getMinKeyEPx+0x55>
	long long minKey = getAccumulator(first->p);
801052a4:	8b 02                	mov    (%edx),%eax
801052a6:	89 04 24             	mov    %eax,(%esp)
801052a9:	e8 f2 e5 ff ff       	call   801038a0 <getAccumulator>
	forEach([&](Proc *p) {
801052ae:	8b 3f                	mov    (%edi),%edi
	void append(Link *link); //appends the given list to the queue. No allocations always succeeds.
	
	template<typename Func>
	void forEach(const Func& accept) { //for-each loop. gets a function that applies the procin each link node.
		Link *link = first;
		while(link) {
801052b0:	85 ff                	test   %edi,%edi
	long long minKey = getAccumulator(first->p);
801052b2:	89 c6                	mov    %eax,%esi
801052b4:	89 d3                	mov    %edx,%ebx
801052b6:	74 23                	je     801052db <_ZN10LinkedList9getMinKeyEPx+0x4b>
801052b8:	90                   	nop
801052b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		long long key = getAccumulator(p);
801052c0:	8b 07                	mov    (%edi),%eax
801052c2:	89 04 24             	mov    %eax,(%esp)
801052c5:	e8 d6 e5 ff ff       	call   801038a0 <getAccumulator>
801052ca:	39 d3                	cmp    %edx,%ebx
801052cc:	7c 06                	jl     801052d4 <_ZN10LinkedList9getMinKeyEPx+0x44>
801052ce:	7f 20                	jg     801052f0 <_ZN10LinkedList9getMinKeyEPx+0x60>
801052d0:	39 c6                	cmp    %eax,%esi
801052d2:	77 1c                	ja     801052f0 <_ZN10LinkedList9getMinKeyEPx+0x60>
			accept(link->p);
			link = link->next;
801052d4:	8b 7f 04             	mov    0x4(%edi),%edi
		while(link) {
801052d7:	85 ff                	test   %edi,%edi
801052d9:	75 e5                	jne    801052c0 <_ZN10LinkedList9getMinKeyEPx+0x30>
	*pkey = minKey;
801052db:	8b 45 0c             	mov    0xc(%ebp),%eax
801052de:	89 30                	mov    %esi,(%eax)
801052e0:	89 58 04             	mov    %ebx,0x4(%eax)
	return true;
801052e3:	b0 01                	mov    $0x1,%al
}
801052e5:	83 c4 1c             	add    $0x1c,%esp
801052e8:	5b                   	pop    %ebx
801052e9:	5e                   	pop    %esi
801052ea:	5f                   	pop    %edi
801052eb:	5d                   	pop    %ebp
801052ec:	c3                   	ret    
801052ed:	8d 76 00             	lea    0x0(%esi),%esi
			link = link->next;
801052f0:	8b 7f 04             	mov    0x4(%edi),%edi
801052f3:	89 c6                	mov    %eax,%esi
801052f5:	89 d3                	mov    %edx,%ebx
		while(link) {
801052f7:	85 ff                	test   %edi,%edi
801052f9:	75 c5                	jne    801052c0 <_ZN10LinkedList9getMinKeyEPx+0x30>
801052fb:	eb de                	jmp    801052db <_ZN10LinkedList9getMinKeyEPx+0x4b>
801052fd:	8d 76 00             	lea    0x0(%esi),%esi

80105300 <getMinAccumulatorRunningProcessHolder>:
static boolean getMinAccumulatorRunningProcessHolder(long long *pkey) {
80105300:	55                   	push   %ebp
80105301:	89 e5                	mov    %esp,%ebp
80105303:	83 ec 18             	sub    $0x18,%esp
	return runningProcHolder->getMinKey(pkey);
80105306:	8b 45 08             	mov    0x8(%ebp),%eax
80105309:	89 44 24 04          	mov    %eax,0x4(%esp)
8010530d:	a1 0c c6 10 80       	mov    0x8010c60c,%eax
80105312:	89 04 24             	mov    %eax,(%esp)
80105315:	e8 76 ff ff ff       	call   80105290 <_ZN10LinkedList9getMinKeyEPx>
}
8010531a:	c9                   	leave  
	return runningProcHolder->getMinKey(pkey);
8010531b:	0f b6 c0             	movzbl %al,%eax
}
8010531e:	c3                   	ret    
8010531f:	90                   	nop

80105320 <_ZN7MapNode7isEmptyEv>:
bool MapNode::isEmpty() {
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
	return !first;
80105323:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105326:	5d                   	pop    %ebp
	return !first;
80105327:	8b 40 08             	mov    0x8(%eax),%eax
8010532a:	85 c0                	test   %eax,%eax
8010532c:	0f 94 c0             	sete   %al
}
8010532f:	c3                   	ret    

80105330 <_ZN7MapNode3putEP4proc>:
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
80105330:	55                   	push   %ebp
80105331:	89 e5                	mov    %esp,%ebp
80105333:	57                   	push   %edi
80105334:	56                   	push   %esi
80105335:	53                   	push   %ebx
80105336:	83 ec 2c             	sub    $0x2c,%esp
	long long key = getAccumulator(p);
80105339:	8b 45 0c             	mov    0xc(%ebp),%eax
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
8010533c:	8b 5d 08             	mov    0x8(%ebp),%ebx
	long long key = getAccumulator(p);
8010533f:	89 04 24             	mov    %eax,(%esp)
80105342:	e8 59 e5 ff ff       	call   801038a0 <getAccumulator>
80105347:	89 d1                	mov    %edx,%ecx
80105349:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010534c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		if(key == node->key)
80105350:	8b 13                	mov    (%ebx),%edx
80105352:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80105355:	8b 43 04             	mov    0x4(%ebx),%eax
80105358:	31 d7                	xor    %edx,%edi
8010535a:	89 fe                	mov    %edi,%esi
8010535c:	89 c7                	mov    %eax,%edi
8010535e:	31 cf                	xor    %ecx,%edi
80105360:	09 fe                	or     %edi,%esi
80105362:	74 4c                	je     801053b0 <_ZN7MapNode3putEP4proc+0x80>
		else if(key < node->key) { //left
80105364:	39 c8                	cmp    %ecx,%eax
80105366:	7c 20                	jl     80105388 <_ZN7MapNode3putEP4proc+0x58>
80105368:	7f 08                	jg     80105372 <_ZN7MapNode3putEP4proc+0x42>
8010536a:	3b 55 e4             	cmp    -0x1c(%ebp),%edx
8010536d:	8d 76 00             	lea    0x0(%esi),%esi
80105370:	76 16                	jbe    80105388 <_ZN7MapNode3putEP4proc+0x58>
			if(node->left)
80105372:	8b 43 18             	mov    0x18(%ebx),%eax
80105375:	85 c0                	test   %eax,%eax
80105377:	0f 84 83 00 00 00    	je     80105400 <_ZN7MapNode3putEP4proc+0xd0>
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
8010537d:	89 c3                	mov    %eax,%ebx
8010537f:	eb cf                	jmp    80105350 <_ZN7MapNode3putEP4proc+0x20>
80105381:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			if(node->right)
80105388:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010538b:	85 c0                	test   %eax,%eax
8010538d:	75 ee                	jne    8010537d <_ZN7MapNode3putEP4proc+0x4d>
8010538f:	8b 75 e4             	mov    -0x1c(%ebp),%esi
				node->right = allocNode(p, key);
80105392:	8b 45 0c             	mov    0xc(%ebp),%eax
80105395:	89 f2                	mov    %esi,%edx
80105397:	e8 e4 f9 ff ff       	call   80104d80 <_ZL9allocNodeP4procx>
				if(node->right) {
8010539c:	85 c0                	test   %eax,%eax
				node->right = allocNode(p, key);
8010539e:	89 43 1c             	mov    %eax,0x1c(%ebx)
				if(node->right) {
801053a1:	74 71                	je     80105414 <_ZN7MapNode3putEP4proc+0xe4>
					node->right->parent = node;
801053a3:	89 58 14             	mov    %ebx,0x14(%eax)
}
801053a6:	83 c4 2c             	add    $0x2c,%esp
					return true;
801053a9:	b0 01                	mov    $0x1,%al
}
801053ab:	5b                   	pop    %ebx
801053ac:	5e                   	pop    %esi
801053ad:	5f                   	pop    %edi
801053ae:	5d                   	pop    %ebp
801053af:	c3                   	ret    
	if(!freeLinks)
801053b0:	a1 08 c6 10 80       	mov    0x8010c608,%eax
801053b5:	85 c0                	test   %eax,%eax
801053b7:	74 5b                	je     80105414 <_ZN7MapNode3putEP4proc+0xe4>
	ans->p = p;
801053b9:	8b 75 0c             	mov    0xc(%ebp),%esi
	freeLinks = freeLinks->next;
801053bc:	8b 50 04             	mov    0x4(%eax),%edx
	ans->next = null;
801053bf:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	ans->p = p;
801053c6:	89 30                	mov    %esi,(%eax)
	freeLinks = freeLinks->next;
801053c8:	89 15 08 c6 10 80    	mov    %edx,0x8010c608
	if(isEmpty()) first = link;
801053ce:	8b 53 08             	mov    0x8(%ebx),%edx
801053d1:	85 d2                	test   %edx,%edx
801053d3:	74 4b                	je     80105420 <_ZN7MapNode3putEP4proc+0xf0>
	else last->next = link;
801053d5:	8b 53 0c             	mov    0xc(%ebx),%edx
801053d8:	89 42 04             	mov    %eax,0x4(%edx)
801053db:	eb 05                	jmp    801053e2 <_ZN7MapNode3putEP4proc+0xb2>
801053dd:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
801053e0:	89 d0                	mov    %edx,%eax
801053e2:	8b 50 04             	mov    0x4(%eax),%edx
801053e5:	85 d2                	test   %edx,%edx
801053e7:	75 f7                	jne    801053e0 <_ZN7MapNode3putEP4proc+0xb0>
	last = link->getLast();
801053e9:	89 43 0c             	mov    %eax,0xc(%ebx)
}
801053ec:	83 c4 2c             	add    $0x2c,%esp
	return true;
801053ef:	b0 01                	mov    $0x1,%al
}
801053f1:	5b                   	pop    %ebx
801053f2:	5e                   	pop    %esi
801053f3:	5f                   	pop    %edi
801053f4:	5d                   	pop    %ebp
801053f5:	c3                   	ret    
801053f6:	8d 76 00             	lea    0x0(%esi),%esi
801053f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105400:	8b 75 e4             	mov    -0x1c(%ebp),%esi
				node->left = allocNode(p, key);
80105403:	8b 45 0c             	mov    0xc(%ebp),%eax
80105406:	89 f2                	mov    %esi,%edx
80105408:	e8 73 f9 ff ff       	call   80104d80 <_ZL9allocNodeP4procx>
				if(node->left) {
8010540d:	85 c0                	test   %eax,%eax
				node->left = allocNode(p, key);
8010540f:	89 43 18             	mov    %eax,0x18(%ebx)
				if(node->left) {
80105412:	75 8f                	jne    801053a3 <_ZN7MapNode3putEP4proc+0x73>
}
80105414:	83 c4 2c             	add    $0x2c,%esp
		return false;
80105417:	31 c0                	xor    %eax,%eax
}
80105419:	5b                   	pop    %ebx
8010541a:	5e                   	pop    %esi
8010541b:	5f                   	pop    %edi
8010541c:	5d                   	pop    %ebp
8010541d:	c3                   	ret    
8010541e:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
80105420:	89 43 08             	mov    %eax,0x8(%ebx)
80105423:	eb bd                	jmp    801053e2 <_ZN7MapNode3putEP4proc+0xb2>
80105425:	90                   	nop
80105426:	8d 76 00             	lea    0x0(%esi),%esi
80105429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105430 <_ZN7MapNode10getMinNodeEv>:
MapNode* MapNode::getMinNode() { //no recursion.
80105430:	55                   	push   %ebp
80105431:	89 e5                	mov    %esp,%ebp
80105433:	8b 45 08             	mov    0x8(%ebp),%eax
80105436:	eb 0a                	jmp    80105442 <_ZN7MapNode10getMinNodeEv+0x12>
80105438:	90                   	nop
80105439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105440:	89 d0                	mov    %edx,%eax
	while(minNode->left)
80105442:	8b 50 18             	mov    0x18(%eax),%edx
80105445:	85 d2                	test   %edx,%edx
80105447:	75 f7                	jne    80105440 <_ZN7MapNode10getMinNodeEv+0x10>
}
80105449:	5d                   	pop    %ebp
8010544a:	c3                   	ret    
8010544b:	90                   	nop
8010544c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105450 <_ZN7MapNode9getMinKeyEPx>:
void MapNode::getMinKey(long long *pkey) {
80105450:	55                   	push   %ebp
80105451:	89 e5                	mov    %esp,%ebp
80105453:	8b 55 08             	mov    0x8(%ebp),%edx
80105456:	53                   	push   %ebx
80105457:	eb 09                	jmp    80105462 <_ZN7MapNode9getMinKeyEPx+0x12>
80105459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	while(minNode->left)
80105460:	89 c2                	mov    %eax,%edx
80105462:	8b 42 18             	mov    0x18(%edx),%eax
80105465:	85 c0                	test   %eax,%eax
80105467:	75 f7                	jne    80105460 <_ZN7MapNode9getMinKeyEPx+0x10>
	*pkey = getMinNode()->key;
80105469:	8b 5a 04             	mov    0x4(%edx),%ebx
8010546c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010546f:	8b 0a                	mov    (%edx),%ecx
80105471:	89 58 04             	mov    %ebx,0x4(%eax)
80105474:	89 08                	mov    %ecx,(%eax)
}
80105476:	5b                   	pop    %ebx
80105477:	5d                   	pop    %ebp
80105478:	c3                   	ret    
80105479:	90                   	nop
8010547a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105480 <_ZN7MapNode7dequeueEv>:
Proc* MapNode::dequeue() {
80105480:	55                   	push   %ebp
80105481:	89 e5                	mov    %esp,%ebp
80105483:	83 ec 08             	sub    $0x8,%esp
80105486:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105489:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010548c:	89 75 fc             	mov    %esi,-0x4(%ebp)
	return !first;
8010548f:	8b 51 08             	mov    0x8(%ecx),%edx
	if(isEmpty())
80105492:	85 d2                	test   %edx,%edx
80105494:	74 32                	je     801054c8 <_ZN7MapNode7dequeueEv+0x48>
	Link *next = first->next;
80105496:	8b 5a 04             	mov    0x4(%edx),%ebx
	link->next = freeLinks;
80105499:	8b 35 08 c6 10 80    	mov    0x8010c608,%esi
	Proc *p = first->p;
8010549f:	8b 02                	mov    (%edx),%eax
	freeLinks = link;
801054a1:	89 15 08 c6 10 80    	mov    %edx,0x8010c608
	if(isEmpty())
801054a7:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
801054a9:	89 72 04             	mov    %esi,0x4(%edx)
	first = next;
801054ac:	89 59 08             	mov    %ebx,0x8(%ecx)
	if(isEmpty())
801054af:	75 07                	jne    801054b8 <_ZN7MapNode7dequeueEv+0x38>
		last = null;
801054b1:	c7 41 0c 00 00 00 00 	movl   $0x0,0xc(%ecx)
}
801054b8:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801054bb:	8b 75 fc             	mov    -0x4(%ebp),%esi
801054be:	89 ec                	mov    %ebp,%esp
801054c0:	5d                   	pop    %ebp
801054c1:	c3                   	ret    
801054c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		return null;
801054c8:	31 c0                	xor    %eax,%eax
	return listOfProcs.dequeue();
801054ca:	eb ec                	jmp    801054b8 <_ZN7MapNode7dequeueEv+0x38>
801054cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054d0 <_ZN3Map7isEmptyEv>:
bool Map::isEmpty() {
801054d0:	55                   	push   %ebp
801054d1:	89 e5                	mov    %esp,%ebp
	return !root;
801054d3:	8b 45 08             	mov    0x8(%ebp),%eax
}
801054d6:	5d                   	pop    %ebp
	return !root;
801054d7:	8b 00                	mov    (%eax),%eax
801054d9:	85 c0                	test   %eax,%eax
801054db:	0f 94 c0             	sete   %al
}
801054de:	c3                   	ret    
801054df:	90                   	nop

801054e0 <_ZN3Map3putEP4proc>:
bool Map::put(Proc *p) {
801054e0:	55                   	push   %ebp
801054e1:	89 e5                	mov    %esp,%ebp
801054e3:	83 ec 18             	sub    $0x18,%esp
801054e6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801054e9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801054ec:	89 75 fc             	mov    %esi,-0x4(%ebp)
801054ef:	8b 75 08             	mov    0x8(%ebp),%esi
	long long key = getAccumulator(p);
801054f2:	89 1c 24             	mov    %ebx,(%esp)
801054f5:	e8 a6 e3 ff ff       	call   801038a0 <getAccumulator>
	return !root;
801054fa:	8b 0e                	mov    (%esi),%ecx
	if(isEmpty()) {
801054fc:	85 c9                	test   %ecx,%ecx
801054fe:	74 18                	je     80105518 <_ZN3Map3putEP4proc+0x38>
	return root->put(p);
80105500:	89 5d 0c             	mov    %ebx,0xc(%ebp)
}
80105503:	8b 75 fc             	mov    -0x4(%ebp),%esi
	return root->put(p);
80105506:	89 4d 08             	mov    %ecx,0x8(%ebp)
}
80105509:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010550c:	89 ec                	mov    %ebp,%esp
8010550e:	5d                   	pop    %ebp
	return root->put(p);
8010550f:	e9 1c fe ff ff       	jmp    80105330 <_ZN7MapNode3putEP4proc>
80105514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		root = allocNode(p, key);
80105518:	89 d1                	mov    %edx,%ecx
8010551a:	89 c2                	mov    %eax,%edx
8010551c:	89 d8                	mov    %ebx,%eax
8010551e:	e8 5d f8 ff ff       	call   80104d80 <_ZL9allocNodeP4procx>
80105523:	89 06                	mov    %eax,(%esi)
		return !isEmpty();
80105525:	85 c0                	test   %eax,%eax
80105527:	0f 95 c0             	setne  %al
}
8010552a:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010552d:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105530:	89 ec                	mov    %ebp,%esp
80105532:	5d                   	pop    %ebp
80105533:	c3                   	ret    
80105534:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010553a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105540 <putPriorityQueue>:
static boolean putPriorityQueue(Proc* p) {
80105540:	55                   	push   %ebp
80105541:	89 e5                	mov    %esp,%ebp
80105543:	83 ec 18             	sub    $0x18,%esp
	return priorityQ->put(p);
80105546:	8b 45 08             	mov    0x8(%ebp),%eax
80105549:	89 44 24 04          	mov    %eax,0x4(%esp)
8010554d:	a1 14 c6 10 80       	mov    0x8010c614,%eax
80105552:	89 04 24             	mov    %eax,(%esp)
80105555:	e8 86 ff ff ff       	call   801054e0 <_ZN3Map3putEP4proc>
}
8010555a:	c9                   	leave  
	return priorityQ->put(p);
8010555b:	0f b6 c0             	movzbl %al,%eax
}
8010555e:	c3                   	ret    
8010555f:	90                   	nop

80105560 <_ZN3Map9getMinKeyEPx>:
bool Map::getMinKey(long long *pkey) {
80105560:	55                   	push   %ebp
80105561:	89 e5                	mov    %esp,%ebp
	return !root;
80105563:	8b 45 08             	mov    0x8(%ebp),%eax
bool Map::getMinKey(long long *pkey) {
80105566:	53                   	push   %ebx
	return !root;
80105567:	8b 10                	mov    (%eax),%edx
	if(isEmpty())
80105569:	85 d2                	test   %edx,%edx
8010556b:	75 05                	jne    80105572 <_ZN3Map9getMinKeyEPx+0x12>
8010556d:	eb 21                	jmp    80105590 <_ZN3Map9getMinKeyEPx+0x30>
8010556f:	90                   	nop
	while(minNode->left)
80105570:	89 c2                	mov    %eax,%edx
80105572:	8b 42 18             	mov    0x18(%edx),%eax
80105575:	85 c0                	test   %eax,%eax
80105577:	75 f7                	jne    80105570 <_ZN3Map9getMinKeyEPx+0x10>
	*pkey = getMinNode()->key;
80105579:	8b 45 0c             	mov    0xc(%ebp),%eax
8010557c:	8b 5a 04             	mov    0x4(%edx),%ebx
8010557f:	8b 0a                	mov    (%edx),%ecx
80105581:	89 58 04             	mov    %ebx,0x4(%eax)
80105584:	89 08                	mov    %ecx,(%eax)
		return false;

	root->getMinKey(pkey);
	return true;
80105586:	b0 01                	mov    $0x1,%al
}
80105588:	5b                   	pop    %ebx
80105589:	5d                   	pop    %ebp
8010558a:	c3                   	ret    
8010558b:	90                   	nop
8010558c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105590:	5b                   	pop    %ebx
		return false;
80105591:	31 c0                	xor    %eax,%eax
}
80105593:	5d                   	pop    %ebp
80105594:	c3                   	ret    
80105595:	90                   	nop
80105596:	8d 76 00             	lea    0x0(%esi),%esi
80105599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055a0 <_ZN3Map10extractMinEv>:

Proc* Map::extractMin() {
801055a0:	55                   	push   %ebp
801055a1:	89 e5                	mov    %esp,%ebp
801055a3:	57                   	push   %edi
801055a4:	56                   	push   %esi
801055a5:	8b 75 08             	mov    0x8(%ebp),%esi
801055a8:	53                   	push   %ebx
	return !root;
801055a9:	8b 1e                	mov    (%esi),%ebx
	if(isEmpty())
801055ab:	85 db                	test   %ebx,%ebx
801055ad:	0f 84 a5 00 00 00    	je     80105658 <_ZN3Map10extractMinEv+0xb8>
801055b3:	89 da                	mov    %ebx,%edx
801055b5:	eb 0b                	jmp    801055c2 <_ZN3Map10extractMinEv+0x22>
801055b7:	89 f6                	mov    %esi,%esi
801055b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	while(minNode->left)
801055c0:	89 c2                	mov    %eax,%edx
801055c2:	8b 42 18             	mov    0x18(%edx),%eax
801055c5:	85 c0                	test   %eax,%eax
801055c7:	75 f7                	jne    801055c0 <_ZN3Map10extractMinEv+0x20>
	return !first;
801055c9:	8b 4a 08             	mov    0x8(%edx),%ecx
	if(isEmpty())
801055cc:	85 c9                	test   %ecx,%ecx
801055ce:	74 70                	je     80105640 <_ZN3Map10extractMinEv+0xa0>
	Link *next = first->next;
801055d0:	8b 59 04             	mov    0x4(%ecx),%ebx
	link->next = freeLinks;
801055d3:	8b 3d 08 c6 10 80    	mov    0x8010c608,%edi
	Proc *p = first->p;
801055d9:	8b 01                	mov    (%ecx),%eax
	freeLinks = link;
801055db:	89 0d 08 c6 10 80    	mov    %ecx,0x8010c608
	if(isEmpty())
801055e1:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
801055e3:	89 79 04             	mov    %edi,0x4(%ecx)
	first = next;
801055e6:	89 5a 08             	mov    %ebx,0x8(%edx)
	if(isEmpty())
801055e9:	74 05                	je     801055f0 <_ZN3Map10extractMinEv+0x50>
		}
		deallocNode(minNode);
	}

	return p;
}
801055eb:	5b                   	pop    %ebx
801055ec:	5e                   	pop    %esi
801055ed:	5f                   	pop    %edi
801055ee:	5d                   	pop    %ebp
801055ef:	c3                   	ret    
		last = null;
801055f0:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
801055f7:	8b 4a 1c             	mov    0x1c(%edx),%ecx
801055fa:	8b 1e                	mov    (%esi),%ebx
		if(minNode == root) {
801055fc:	39 da                	cmp    %ebx,%edx
801055fe:	74 49                	je     80105649 <_ZN3Map10extractMinEv+0xa9>
			MapNode *parent = minNode->parent;
80105600:	8b 5a 14             	mov    0x14(%edx),%ebx
			parent->left = minNode->right;
80105603:	89 4b 18             	mov    %ecx,0x18(%ebx)
			if(minNode->right)
80105606:	8b 4a 1c             	mov    0x1c(%edx),%ecx
80105609:	85 c9                	test   %ecx,%ecx
8010560b:	74 03                	je     80105610 <_ZN3Map10extractMinEv+0x70>
				minNode->right->parent = parent;
8010560d:	89 59 14             	mov    %ebx,0x14(%ecx)
	node->next = freeNodes;
80105610:	8b 0d 04 c6 10 80    	mov    0x8010c604,%ecx
	node->parent = node->left = node->right = null;
80105616:	c7 42 1c 00 00 00 00 	movl   $0x0,0x1c(%edx)
8010561d:	c7 42 18 00 00 00 00 	movl   $0x0,0x18(%edx)
80105624:	c7 42 14 00 00 00 00 	movl   $0x0,0x14(%edx)
	node->next = freeNodes;
8010562b:	89 4a 10             	mov    %ecx,0x10(%edx)
}
8010562e:	5b                   	pop    %ebx
	freeNodes = node;
8010562f:	89 15 04 c6 10 80    	mov    %edx,0x8010c604
}
80105635:	5e                   	pop    %esi
80105636:	5f                   	pop    %edi
80105637:	5d                   	pop    %ebp
80105638:	c3                   	ret    
80105639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return null;
80105640:	31 c0                	xor    %eax,%eax
		if(minNode == root) {
80105642:	39 da                	cmp    %ebx,%edx
80105644:	8b 4a 1c             	mov    0x1c(%edx),%ecx
80105647:	75 b7                	jne    80105600 <_ZN3Map10extractMinEv+0x60>
			if(!isEmpty())
80105649:	85 c9                	test   %ecx,%ecx
			root = minNode->right;
8010564b:	89 0e                	mov    %ecx,(%esi)
			if(!isEmpty())
8010564d:	74 c1                	je     80105610 <_ZN3Map10extractMinEv+0x70>
				root->parent = null;
8010564f:	c7 41 14 00 00 00 00 	movl   $0x0,0x14(%ecx)
80105656:	eb b8                	jmp    80105610 <_ZN3Map10extractMinEv+0x70>
		return null;
80105658:	31 c0                	xor    %eax,%eax
8010565a:	eb 8f                	jmp    801055eb <_ZN3Map10extractMinEv+0x4b>
8010565c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105660 <extractMinPriorityQueue>:
static Proc* extractMinPriorityQueue() {
80105660:	55                   	push   %ebp
80105661:	89 e5                	mov    %esp,%ebp
80105663:	83 ec 04             	sub    $0x4,%esp
	return priorityQ->extractMin();
80105666:	a1 14 c6 10 80       	mov    0x8010c614,%eax
8010566b:	89 04 24             	mov    %eax,(%esp)
8010566e:	e8 2d ff ff ff       	call   801055a0 <_ZN3Map10extractMinEv>
}
80105673:	c9                   	leave  
80105674:	c3                   	ret    
80105675:	90                   	nop
80105676:	8d 76 00             	lea    0x0(%esi),%esi
80105679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105680 <_ZN3Map8transferEv.part.1>:

bool Map::transfer() {
80105680:	55                   	push   %ebp
80105681:	89 e5                	mov    %esp,%ebp
80105683:	56                   	push   %esi
80105684:	53                   	push   %ebx
80105685:	89 c3                	mov    %eax,%ebx
80105687:	83 ec 04             	sub    $0x4,%esp
8010568a:	eb 16                	jmp    801056a2 <_ZN3Map8transferEv.part.1+0x22>
8010568c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!roundRobinQ->isEmpty())
		return false;

	while(!isEmpty()) {
		Proc* p = extractMin();
80105690:	89 1c 24             	mov    %ebx,(%esp)
80105693:	e8 08 ff ff ff       	call   801055a0 <_ZN3Map10extractMinEv>
	if(!freeLinks)
80105698:	8b 15 08 c6 10 80    	mov    0x8010c608,%edx
8010569e:	85 d2                	test   %edx,%edx
801056a0:	75 0e                	jne    801056b0 <_ZN3Map8transferEv.part.1+0x30>
	while(!isEmpty()) {
801056a2:	8b 03                	mov    (%ebx),%eax
801056a4:	85 c0                	test   %eax,%eax
801056a6:	75 e8                	jne    80105690 <_ZN3Map8transferEv.part.1+0x10>
		roundRobinQ->enqueue(p); //should succeed.
	}

	return true;
}
801056a8:	5a                   	pop    %edx
801056a9:	b0 01                	mov    $0x1,%al
801056ab:	5b                   	pop    %ebx
801056ac:	5e                   	pop    %esi
801056ad:	5d                   	pop    %ebp
801056ae:	c3                   	ret    
801056af:	90                   	nop
	freeLinks = freeLinks->next;
801056b0:	8b 72 04             	mov    0x4(%edx),%esi
		roundRobinQ->enqueue(p); //should succeed.
801056b3:	8b 0d 10 c6 10 80    	mov    0x8010c610,%ecx
	ans->next = null;
801056b9:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
	ans->p = p;
801056c0:	89 02                	mov    %eax,(%edx)
	freeLinks = freeLinks->next;
801056c2:	89 35 08 c6 10 80    	mov    %esi,0x8010c608
	if(isEmpty()) first = link;
801056c8:	8b 31                	mov    (%ecx),%esi
801056ca:	85 f6                	test   %esi,%esi
801056cc:	74 22                	je     801056f0 <_ZN3Map8transferEv.part.1+0x70>
	else last->next = link;
801056ce:	8b 41 04             	mov    0x4(%ecx),%eax
801056d1:	89 50 04             	mov    %edx,0x4(%eax)
801056d4:	eb 0c                	jmp    801056e2 <_ZN3Map8transferEv.part.1+0x62>
801056d6:	8d 76 00             	lea    0x0(%esi),%esi
801056d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	while(ans->next)
801056e0:	89 c2                	mov    %eax,%edx
801056e2:	8b 42 04             	mov    0x4(%edx),%eax
801056e5:	85 c0                	test   %eax,%eax
801056e7:	75 f7                	jne    801056e0 <_ZN3Map8transferEv.part.1+0x60>
	last = link->getLast();
801056e9:	89 51 04             	mov    %edx,0x4(%ecx)
801056ec:	eb b4                	jmp    801056a2 <_ZN3Map8transferEv.part.1+0x22>
801056ee:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
801056f0:	89 11                	mov    %edx,(%ecx)
801056f2:	eb ee                	jmp    801056e2 <_ZN3Map8transferEv.part.1+0x62>
801056f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801056fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105700 <switchToRoundRobinPolicyPriorityQueue>:
	if(!roundRobinQ->isEmpty())
80105700:	8b 15 10 c6 10 80    	mov    0x8010c610,%edx
80105706:	8b 02                	mov    (%edx),%eax
80105708:	85 c0                	test   %eax,%eax
8010570a:	74 04                	je     80105710 <switchToRoundRobinPolicyPriorityQueue+0x10>
8010570c:	31 c0                	xor    %eax,%eax
}
8010570e:	c3                   	ret    
8010570f:	90                   	nop
80105710:	a1 14 c6 10 80       	mov    0x8010c614,%eax
static boolean switchToRoundRobinPolicyPriorityQueue() {
80105715:	55                   	push   %ebp
80105716:	89 e5                	mov    %esp,%ebp
80105718:	e8 63 ff ff ff       	call   80105680 <_ZN3Map8transferEv.part.1>
}
8010571d:	5d                   	pop    %ebp
8010571e:	0f b6 c0             	movzbl %al,%eax
80105721:	c3                   	ret    
80105722:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105730 <_ZN3Map8transferEv>:
	return !first;
80105730:	8b 15 10 c6 10 80    	mov    0x8010c610,%edx
bool Map::transfer() {
80105736:	55                   	push   %ebp
80105737:	89 e5                	mov    %esp,%ebp
80105739:	8b 45 08             	mov    0x8(%ebp),%eax
	if(!roundRobinQ->isEmpty())
8010573c:	8b 12                	mov    (%edx),%edx
8010573e:	85 d2                	test   %edx,%edx
80105740:	74 0e                	je     80105750 <_ZN3Map8transferEv+0x20>
}
80105742:	31 c0                	xor    %eax,%eax
80105744:	5d                   	pop    %ebp
80105745:	c3                   	ret    
80105746:	8d 76 00             	lea    0x0(%esi),%esi
80105749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105750:	5d                   	pop    %ebp
80105751:	e9 2a ff ff ff       	jmp    80105680 <_ZN3Map8transferEv.part.1>
80105756:	8d 76 00             	lea    0x0(%esi),%esi
80105759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105760 <_ZN3Map11extractProcEP4proc>:

bool Map::extractProc(Proc *p) {
80105760:	55                   	push   %ebp
80105761:	89 e5                	mov    %esp,%ebp
80105763:	56                   	push   %esi
80105764:	53                   	push   %ebx
80105765:	83 ec 30             	sub    $0x30,%esp
	if(!freeNodes)
80105768:	8b 15 04 c6 10 80    	mov    0x8010c604,%edx
bool Map::extractProc(Proc *p) {
8010576e:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105771:	8b 75 0c             	mov    0xc(%ebp),%esi
	if(!freeNodes)
80105774:	85 d2                	test   %edx,%edx
80105776:	74 50                	je     801057c8 <_ZN3Map11extractProcEP4proc+0x68>
	MapNode *next, *parent, *left, *right;
};

class Map {
public:
	Map(): root(null) {}
80105778:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		return false;

	bool ans = false;
8010577f:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
80105783:	eb 13                	jmp    80105798 <_ZN3Map11extractProcEP4proc+0x38>
80105785:	8d 76 00             	lea    0x0(%esi),%esi
	Map tempMap;
	while(!isEmpty()) {
		Proc *otherP = extractMin();
80105788:	89 1c 24             	mov    %ebx,(%esp)
8010578b:	e8 10 fe ff ff       	call   801055a0 <_ZN3Map10extractMinEv>
		if(otherP != p)
80105790:	39 f0                	cmp    %esi,%eax
80105792:	75 1c                	jne    801057b0 <_ZN3Map11extractProcEP4proc+0x50>
			tempMap.put(otherP); //should scucceed.
		else ans = true;
80105794:	c6 45 e7 01          	movb   $0x1,-0x19(%ebp)
	while(!isEmpty()) {
80105798:	8b 03                	mov    (%ebx),%eax
8010579a:	85 c0                	test   %eax,%eax
8010579c:	75 ea                	jne    80105788 <_ZN3Map11extractProcEP4proc+0x28>
	}
	root = tempMap.root;
8010579e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057a1:	89 03                	mov    %eax,(%ebx)
	return ans;
}
801057a3:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801057a7:	83 c4 30             	add    $0x30,%esp
801057aa:	5b                   	pop    %ebx
801057ab:	5e                   	pop    %esi
801057ac:	5d                   	pop    %ebp
801057ad:	c3                   	ret    
801057ae:	66 90                	xchg   %ax,%ax
			tempMap.put(otherP); //should scucceed.
801057b0:	89 44 24 04          	mov    %eax,0x4(%esp)
801057b4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057b7:	89 04 24             	mov    %eax,(%esp)
801057ba:	e8 21 fd ff ff       	call   801054e0 <_ZN3Map3putEP4proc>
801057bf:	eb d7                	jmp    80105798 <_ZN3Map11extractProcEP4proc+0x38>
801057c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return false;
801057c8:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
}
801057cc:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801057d0:	83 c4 30             	add    $0x30,%esp
801057d3:	5b                   	pop    %ebx
801057d4:	5e                   	pop    %esi
801057d5:	5d                   	pop    %ebp
801057d6:	c3                   	ret    
801057d7:	89 f6                	mov    %esi,%esi
801057d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057e0 <extractProcPriorityQueue>:
static boolean extractProcPriorityQueue(Proc *p) {
801057e0:	55                   	push   %ebp
801057e1:	89 e5                	mov    %esp,%ebp
801057e3:	83 ec 18             	sub    $0x18,%esp
	return priorityQ->extractProc(p);
801057e6:	8b 45 08             	mov    0x8(%ebp),%eax
801057e9:	89 44 24 04          	mov    %eax,0x4(%esp)
801057ed:	a1 14 c6 10 80       	mov    0x8010c614,%eax
801057f2:	89 04 24             	mov    %eax,(%esp)
801057f5:	e8 66 ff ff ff       	call   80105760 <_ZN3Map11extractProcEP4proc>
}
801057fa:	c9                   	leave  
	return priorityQ->extractProc(p);
801057fb:	0f b6 c0             	movzbl %al,%eax
}
801057fe:	c3                   	ret    
801057ff:	90                   	nop

80105800 <__moddi3>:

long long __moddi3(long long number, long long divisor) { //returns number%divisor
80105800:	55                   	push   %ebp
80105801:	89 e5                	mov    %esp,%ebp
80105803:	57                   	push   %edi
80105804:	56                   	push   %esi
80105805:	53                   	push   %ebx
80105806:	83 ec 2c             	sub    $0x2c,%esp
80105809:	8b 45 08             	mov    0x8(%ebp),%eax
8010580c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010580f:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105812:	8b 45 10             	mov    0x10(%ebp),%eax
80105815:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80105818:	8b 55 14             	mov    0x14(%ebp),%edx
8010581b:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010581e:	89 d7                	mov    %edx,%edi
	if(divisor == 0)
80105820:	09 c2                	or     %eax,%edx
80105822:	0f 84 9a 00 00 00    	je     801058c2 <__moddi3+0xc2>
		panic((char*)"divide by zero!!!\n");

	bool isNumberNegative = false;
	if(number < 0) {
80105828:	8b 45 e4             	mov    -0x1c(%ebp),%eax
	bool isNumberNegative = false;
8010582b:	c6 45 df 00          	movb   $0x0,-0x21(%ebp)
	if(number < 0) {
8010582f:	85 c0                	test   %eax,%eax
80105831:	79 0e                	jns    80105841 <__moddi3+0x41>
		number = -number;
80105833:	f7 5d e0             	negl   -0x20(%ebp)
		isNumberNegative = true;
80105836:	c6 45 df 01          	movb   $0x1,-0x21(%ebp)
		number = -number;
8010583a:	83 55 e4 00          	adcl   $0x0,-0x1c(%ebp)
8010583e:	f7 5d e4             	negl   -0x1c(%ebp)
80105841:	8b 55 d8             	mov    -0x28(%ebp),%edx
80105844:	89 f8                	mov    %edi,%eax
80105846:	c1 ff 1f             	sar    $0x1f,%edi
80105849:	31 f8                	xor    %edi,%eax
8010584b:	89 f9                	mov    %edi,%ecx
8010584d:	31 fa                	xor    %edi,%edx
8010584f:	89 c7                	mov    %eax,%edi
80105851:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105854:	89 d6                	mov    %edx,%esi
80105856:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105859:	29 ce                	sub    %ecx,%esi
8010585b:	19 cf                	sbb    %ecx,%edi
	if(divisor < 0)
		divisor = -divisor;

	for(;;) {
		long long divisor2 = divisor;
		while(number >= divisor2) {
8010585d:	39 fa                	cmp    %edi,%edx
8010585f:	7d 1f                	jge    80105880 <__moddi3+0x80>
			if(divisor2 + divisor2 > 0) //exponential decay.
				divisor2 += divisor2;
		}

		if(number < divisor)
			return isNumberNegative ? -number : number;
80105861:	80 7d df 00          	cmpb   $0x0,-0x21(%ebp)
80105865:	74 07                	je     8010586e <__moddi3+0x6e>
80105867:	f7 d8                	neg    %eax
80105869:	83 d2 00             	adc    $0x0,%edx
8010586c:	f7 da                	neg    %edx
	}
}
8010586e:	83 c4 2c             	add    $0x2c,%esp
80105871:	5b                   	pop    %ebx
80105872:	5e                   	pop    %esi
80105873:	5f                   	pop    %edi
80105874:	5d                   	pop    %ebp
80105875:	c3                   	ret    
80105876:	8d 76 00             	lea    0x0(%esi),%esi
80105879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		while(number >= divisor2) {
80105880:	7f 04                	jg     80105886 <__moddi3+0x86>
80105882:	39 f0                	cmp    %esi,%eax
80105884:	72 db                	jb     80105861 <__moddi3+0x61>
80105886:	89 f1                	mov    %esi,%ecx
80105888:	89 fb                	mov    %edi,%ebx
8010588a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			number -= divisor2;
80105890:	29 c8                	sub    %ecx,%eax
80105892:	19 da                	sbb    %ebx,%edx
				divisor2 += divisor2;
80105894:	0f a4 cb 01          	shld   $0x1,%ecx,%ebx
80105898:	01 c9                	add    %ecx,%ecx
		while(number >= divisor2) {
8010589a:	39 da                	cmp    %ebx,%edx
8010589c:	7f f2                	jg     80105890 <__moddi3+0x90>
8010589e:	7d 18                	jge    801058b8 <__moddi3+0xb8>
		if(number < divisor)
801058a0:	39 d7                	cmp    %edx,%edi
801058a2:	7c b9                	jl     8010585d <__moddi3+0x5d>
801058a4:	7f bb                	jg     80105861 <__moddi3+0x61>
801058a6:	39 c6                	cmp    %eax,%esi
801058a8:	76 b3                	jbe    8010585d <__moddi3+0x5d>
801058aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801058b0:	eb af                	jmp    80105861 <__moddi3+0x61>
801058b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		while(number >= divisor2) {
801058b8:	39 c8                	cmp    %ecx,%eax
801058ba:	73 d4                	jae    80105890 <__moddi3+0x90>
801058bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801058c0:	eb de                	jmp    801058a0 <__moddi3+0xa0>
		panic((char*)"divide by zero!!!\n");
801058c2:	c7 04 24 50 8f 10 80 	movl   $0x80108f50,(%esp)
801058c9:	e8 a2 aa ff ff       	call   80100370 <panic>
801058ce:	66 90                	xchg   %ax,%ax

801058d0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801058d0:	55                   	push   %ebp
  initlock(&lk->lk, "sleep lock");
801058d1:	b8 63 8f 10 80       	mov    $0x80108f63,%eax
{
801058d6:	89 e5                	mov    %esp,%ebp
801058d8:	53                   	push   %ebx
801058d9:	83 ec 14             	sub    $0x14,%esp
801058dc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801058df:	89 44 24 04          	mov    %eax,0x4(%esp)
801058e3:	8d 43 04             	lea    0x4(%ebx),%eax
801058e6:	89 04 24             	mov    %eax,(%esp)
801058e9:	e8 12 01 00 00       	call   80105a00 <initlock>
  lk->name = name;
801058ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801058f1:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801058f7:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801058fe:	89 43 38             	mov    %eax,0x38(%ebx)
}
80105901:	83 c4 14             	add    $0x14,%esp
80105904:	5b                   	pop    %ebx
80105905:	5d                   	pop    %ebp
80105906:	c3                   	ret    
80105907:	89 f6                	mov    %esi,%esi
80105909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105910 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80105910:	55                   	push   %ebp
80105911:	89 e5                	mov    %esp,%ebp
80105913:	56                   	push   %esi
80105914:	53                   	push   %ebx
80105915:	83 ec 10             	sub    $0x10,%esp
80105918:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010591b:	8d 73 04             	lea    0x4(%ebx),%esi
8010591e:	89 34 24             	mov    %esi,(%esp)
80105921:	e8 2a 02 00 00       	call   80105b50 <acquire>
  while (lk->locked) {
80105926:	8b 13                	mov    (%ebx),%edx
80105928:	85 d2                	test   %edx,%edx
8010592a:	74 16                	je     80105942 <acquiresleep+0x32>
8010592c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80105930:	89 74 24 04          	mov    %esi,0x4(%esp)
80105934:	89 1c 24             	mov    %ebx,(%esp)
80105937:	e8 c4 ea ff ff       	call   80104400 <sleep>
  while (lk->locked) {
8010593c:	8b 03                	mov    (%ebx),%eax
8010593e:	85 c0                	test   %eax,%eax
80105940:	75 ee                	jne    80105930 <acquiresleep+0x20>
  }
  lk->locked = 1;
80105942:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80105948:	e8 63 e1 ff ff       	call   80103ab0 <myproc>
8010594d:	8b 40 10             	mov    0x10(%eax),%eax
80105950:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80105953:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105956:	83 c4 10             	add    $0x10,%esp
80105959:	5b                   	pop    %ebx
8010595a:	5e                   	pop    %esi
8010595b:	5d                   	pop    %ebp
  release(&lk->lk);
8010595c:	e9 8f 02 00 00       	jmp    80105bf0 <release>
80105961:	eb 0d                	jmp    80105970 <releasesleep>
80105963:	90                   	nop
80105964:	90                   	nop
80105965:	90                   	nop
80105966:	90                   	nop
80105967:	90                   	nop
80105968:	90                   	nop
80105969:	90                   	nop
8010596a:	90                   	nop
8010596b:	90                   	nop
8010596c:	90                   	nop
8010596d:	90                   	nop
8010596e:	90                   	nop
8010596f:	90                   	nop

80105970 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80105970:	55                   	push   %ebp
80105971:	89 e5                	mov    %esp,%ebp
80105973:	83 ec 18             	sub    $0x18,%esp
80105976:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105979:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010597c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  acquire(&lk->lk);
8010597f:	8d 73 04             	lea    0x4(%ebx),%esi
80105982:	89 34 24             	mov    %esi,(%esp)
80105985:	e8 c6 01 00 00       	call   80105b50 <acquire>
  lk->locked = 0;
8010598a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80105990:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80105997:	89 1c 24             	mov    %ebx,(%esp)
8010599a:	e8 81 ec ff ff       	call   80104620 <wakeup>
  release(&lk->lk);
}
8010599f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  release(&lk->lk);
801059a2:	89 75 08             	mov    %esi,0x8(%ebp)
}
801059a5:	8b 75 fc             	mov    -0x4(%ebp),%esi
801059a8:	89 ec                	mov    %ebp,%esp
801059aa:	5d                   	pop    %ebp
  release(&lk->lk);
801059ab:	e9 40 02 00 00       	jmp    80105bf0 <release>

801059b0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801059b0:	55                   	push   %ebp
801059b1:	89 e5                	mov    %esp,%ebp
801059b3:	83 ec 28             	sub    $0x28,%esp
801059b6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801059b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801059bc:	89 7d fc             	mov    %edi,-0x4(%ebp)
801059bf:	89 75 f8             	mov    %esi,-0x8(%ebp)
801059c2:	31 f6                	xor    %esi,%esi
  int r;
  
  acquire(&lk->lk);
801059c4:	8d 7b 04             	lea    0x4(%ebx),%edi
801059c7:	89 3c 24             	mov    %edi,(%esp)
801059ca:	e8 81 01 00 00       	call   80105b50 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801059cf:	8b 03                	mov    (%ebx),%eax
801059d1:	85 c0                	test   %eax,%eax
801059d3:	74 11                	je     801059e6 <holdingsleep+0x36>
801059d5:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801059d8:	e8 d3 e0 ff ff       	call   80103ab0 <myproc>
801059dd:	39 58 10             	cmp    %ebx,0x10(%eax)
801059e0:	0f 94 c0             	sete   %al
801059e3:	0f b6 f0             	movzbl %al,%esi
  release(&lk->lk);
801059e6:	89 3c 24             	mov    %edi,(%esp)
801059e9:	e8 02 02 00 00       	call   80105bf0 <release>
  return r;
}
801059ee:	89 f0                	mov    %esi,%eax
801059f0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801059f3:	8b 75 f8             	mov    -0x8(%ebp),%esi
801059f6:	8b 7d fc             	mov    -0x4(%ebp),%edi
801059f9:	89 ec                	mov    %ebp,%esp
801059fb:	5d                   	pop    %ebp
801059fc:	c3                   	ret    
801059fd:	66 90                	xchg   %ax,%ax
801059ff:	90                   	nop

80105a00 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105a00:	55                   	push   %ebp
80105a01:	89 e5                	mov    %esp,%ebp
80105a03:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80105a06:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80105a09:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80105a0f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80105a12:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105a19:	5d                   	pop    %ebp
80105a1a:	c3                   	ret    
80105a1b:	90                   	nop
80105a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105a20 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105a20:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105a21:	31 d2                	xor    %edx,%edx
{
80105a23:	89 e5                	mov    %esp,%ebp
  ebp = (uint*)v - 2;
80105a25:	8b 45 08             	mov    0x8(%ebp),%eax
{
80105a28:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105a2b:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80105a2c:	83 e8 08             	sub    $0x8,%eax
80105a2f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105a30:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80105a36:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80105a3c:	77 12                	ja     80105a50 <getcallerpcs+0x30>
      break;
    pcs[i] = ebp[1];     // saved %eip
80105a3e:	8b 58 04             	mov    0x4(%eax),%ebx
80105a41:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80105a44:	42                   	inc    %edx
80105a45:	83 fa 0a             	cmp    $0xa,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80105a48:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105a4a:	75 e4                	jne    80105a30 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80105a4c:	5b                   	pop    %ebx
80105a4d:	5d                   	pop    %ebp
80105a4e:	c3                   	ret    
80105a4f:	90                   	nop
80105a50:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80105a53:	83 c1 28             	add    $0x28,%ecx
80105a56:	8d 76 00             	lea    0x0(%esi),%esi
80105a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80105a60:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105a66:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80105a69:	39 c1                	cmp    %eax,%ecx
80105a6b:	75 f3                	jne    80105a60 <getcallerpcs+0x40>
}
80105a6d:	5b                   	pop    %ebx
80105a6e:	5d                   	pop    %ebp
80105a6f:	c3                   	ret    

80105a70 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105a70:	55                   	push   %ebp
80105a71:	89 e5                	mov    %esp,%ebp
80105a73:	53                   	push   %ebx
80105a74:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105a77:	9c                   	pushf  
80105a78:	5b                   	pop    %ebx
  asm volatile("cli");
80105a79:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80105a7a:	e8 91 df ff ff       	call   80103a10 <mycpu>
80105a7f:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105a85:	85 d2                	test   %edx,%edx
80105a87:	75 11                	jne    80105a9a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80105a89:	e8 82 df ff ff       	call   80103a10 <mycpu>
80105a8e:	81 e3 00 02 00 00    	and    $0x200,%ebx
80105a94:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
80105a9a:	e8 71 df ff ff       	call   80103a10 <mycpu>
80105a9f:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
}
80105aa5:	58                   	pop    %eax
80105aa6:	5b                   	pop    %ebx
80105aa7:	5d                   	pop    %ebp
80105aa8:	c3                   	ret    
80105aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ab0 <popcli>:

void
popcli(void)
{
80105ab0:	55                   	push   %ebp
80105ab1:	89 e5                	mov    %esp,%ebp
80105ab3:	83 ec 18             	sub    $0x18,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105ab6:	9c                   	pushf  
80105ab7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80105ab8:	f6 c4 02             	test   $0x2,%ah
80105abb:	75 35                	jne    80105af2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80105abd:	e8 4e df ff ff       	call   80103a10 <mycpu>
80105ac2:	ff 88 a4 00 00 00    	decl   0xa4(%eax)
80105ac8:	78 34                	js     80105afe <popcli+0x4e>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105aca:	e8 41 df ff ff       	call   80103a10 <mycpu>
80105acf:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105ad5:	85 d2                	test   %edx,%edx
80105ad7:	74 07                	je     80105ae0 <popcli+0x30>
    sti();
}
80105ad9:	c9                   	leave  
80105ada:	c3                   	ret    
80105adb:	90                   	nop
80105adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105ae0:	e8 2b df ff ff       	call   80103a10 <mycpu>
80105ae5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80105aeb:	85 c0                	test   %eax,%eax
80105aed:	74 ea                	je     80105ad9 <popcli+0x29>
  asm volatile("sti");
80105aef:	fb                   	sti    
}
80105af0:	c9                   	leave  
80105af1:	c3                   	ret    
    panic("popcli - interruptible");
80105af2:	c7 04 24 6e 8f 10 80 	movl   $0x80108f6e,(%esp)
80105af9:	e8 72 a8 ff ff       	call   80100370 <panic>
    panic("popcli");
80105afe:	c7 04 24 85 8f 10 80 	movl   $0x80108f85,(%esp)
80105b05:	e8 66 a8 ff ff       	call   80100370 <panic>
80105b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105b10 <holding>:
{
80105b10:	55                   	push   %ebp
80105b11:	89 e5                	mov    %esp,%ebp
80105b13:	83 ec 08             	sub    $0x8,%esp
80105b16:	89 75 fc             	mov    %esi,-0x4(%ebp)
80105b19:	8b 75 08             	mov    0x8(%ebp),%esi
80105b1c:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105b1f:	31 db                	xor    %ebx,%ebx
  pushcli();
80105b21:	e8 4a ff ff ff       	call   80105a70 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105b26:	8b 06                	mov    (%esi),%eax
80105b28:	85 c0                	test   %eax,%eax
80105b2a:	74 10                	je     80105b3c <holding+0x2c>
80105b2c:	8b 5e 08             	mov    0x8(%esi),%ebx
80105b2f:	e8 dc de ff ff       	call   80103a10 <mycpu>
80105b34:	39 c3                	cmp    %eax,%ebx
80105b36:	0f 94 c3             	sete   %bl
80105b39:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80105b3c:	e8 6f ff ff ff       	call   80105ab0 <popcli>
}
80105b41:	89 d8                	mov    %ebx,%eax
80105b43:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105b46:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105b49:	89 ec                	mov    %ebp,%esp
80105b4b:	5d                   	pop    %ebp
80105b4c:	c3                   	ret    
80105b4d:	8d 76 00             	lea    0x0(%esi),%esi

80105b50 <acquire>:
{
80105b50:	55                   	push   %ebp
80105b51:	89 e5                	mov    %esp,%ebp
80105b53:	56                   	push   %esi
80105b54:	53                   	push   %ebx
80105b55:	83 ec 10             	sub    $0x10,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105b58:	e8 13 ff ff ff       	call   80105a70 <pushcli>
  if(holding(lk))
80105b5d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105b60:	89 1c 24             	mov    %ebx,(%esp)
80105b63:	e8 a8 ff ff ff       	call   80105b10 <holding>
80105b68:	85 c0                	test   %eax,%eax
80105b6a:	75 78                	jne    80105be4 <acquire+0x94>
80105b6c:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80105b6e:	ba 01 00 00 00       	mov    $0x1,%edx
80105b73:	eb 06                	jmp    80105b7b <acquire+0x2b>
80105b75:	8d 76 00             	lea    0x0(%esi),%esi
80105b78:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105b7b:	89 d0                	mov    %edx,%eax
80105b7d:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80105b80:	85 c0                	test   %eax,%eax
80105b82:	75 f4                	jne    80105b78 <acquire+0x28>
  __sync_synchronize();
80105b84:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80105b89:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105b8c:	e8 7f de ff ff       	call   80103a10 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80105b91:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
80105b94:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80105b97:	89 e8                	mov    %ebp,%eax
80105b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105ba0:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
80105ba6:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80105bac:	77 1a                	ja     80105bc8 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
80105bae:	8b 48 04             	mov    0x4(%eax),%ecx
80105bb1:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
80105bb4:	46                   	inc    %esi
80105bb5:	83 fe 0a             	cmp    $0xa,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80105bb8:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105bba:	75 e4                	jne    80105ba0 <acquire+0x50>
}
80105bbc:	83 c4 10             	add    $0x10,%esp
80105bbf:	5b                   	pop    %ebx
80105bc0:	5e                   	pop    %esi
80105bc1:	5d                   	pop    %ebp
80105bc2:	c3                   	ret    
80105bc3:	90                   	nop
80105bc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105bc8:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80105bcb:	83 c2 28             	add    $0x28,%edx
80105bce:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80105bd0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105bd6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80105bd9:	39 d0                	cmp    %edx,%eax
80105bdb:	75 f3                	jne    80105bd0 <acquire+0x80>
}
80105bdd:	83 c4 10             	add    $0x10,%esp
80105be0:	5b                   	pop    %ebx
80105be1:	5e                   	pop    %esi
80105be2:	5d                   	pop    %ebp
80105be3:	c3                   	ret    
    panic("acquire");
80105be4:	c7 04 24 8c 8f 10 80 	movl   $0x80108f8c,(%esp)
80105beb:	e8 80 a7 ff ff       	call   80100370 <panic>

80105bf0 <release>:
{
80105bf0:	55                   	push   %ebp
80105bf1:	89 e5                	mov    %esp,%ebp
80105bf3:	53                   	push   %ebx
80105bf4:	83 ec 14             	sub    $0x14,%esp
80105bf7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80105bfa:	89 1c 24             	mov    %ebx,(%esp)
80105bfd:	e8 0e ff ff ff       	call   80105b10 <holding>
80105c02:	85 c0                	test   %eax,%eax
80105c04:	74 23                	je     80105c29 <release+0x39>
  lk->pcs[0] = 0;
80105c06:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105c0d:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105c14:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80105c19:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105c1f:	83 c4 14             	add    $0x14,%esp
80105c22:	5b                   	pop    %ebx
80105c23:	5d                   	pop    %ebp
  popcli();
80105c24:	e9 87 fe ff ff       	jmp    80105ab0 <popcli>
    panic("release");
80105c29:	c7 04 24 94 8f 10 80 	movl   $0x80108f94,(%esp)
80105c30:	e8 3b a7 ff ff       	call   80100370 <panic>
80105c35:	66 90                	xchg   %ax,%ax
80105c37:	66 90                	xchg   %ax,%ax
80105c39:	66 90                	xchg   %ax,%ax
80105c3b:	66 90                	xchg   %ax,%ax
80105c3d:	66 90                	xchg   %ax,%ax
80105c3f:	90                   	nop

80105c40 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105c40:	55                   	push   %ebp
80105c41:	89 e5                	mov    %esp,%ebp
80105c43:	83 ec 08             	sub    $0x8,%esp
80105c46:	8b 55 08             	mov    0x8(%ebp),%edx
80105c49:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105c4c:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105c4f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if ((int)dst%4 == 0 && n%4 == 0){
80105c52:	f6 c2 03             	test   $0x3,%dl
80105c55:	75 05                	jne    80105c5c <memset+0x1c>
80105c57:	f6 c1 03             	test   $0x3,%cl
80105c5a:	74 14                	je     80105c70 <memset+0x30>
  asm volatile("cld; rep stosb" :
80105c5c:	89 d7                	mov    %edx,%edi
80105c5e:	8b 45 0c             	mov    0xc(%ebp),%eax
80105c61:	fc                   	cld    
80105c62:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80105c64:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105c67:	89 d0                	mov    %edx,%eax
80105c69:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105c6c:	89 ec                	mov    %ebp,%esp
80105c6e:	5d                   	pop    %ebp
80105c6f:	c3                   	ret    
    c &= 0xFF;
80105c70:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80105c74:	c1 e9 02             	shr    $0x2,%ecx
80105c77:	89 f8                	mov    %edi,%eax
80105c79:	89 fb                	mov    %edi,%ebx
80105c7b:	c1 e0 18             	shl    $0x18,%eax
80105c7e:	c1 e3 10             	shl    $0x10,%ebx
80105c81:	09 d8                	or     %ebx,%eax
80105c83:	09 f8                	or     %edi,%eax
80105c85:	c1 e7 08             	shl    $0x8,%edi
80105c88:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80105c8a:	89 d7                	mov    %edx,%edi
80105c8c:	fc                   	cld    
80105c8d:	f3 ab                	rep stos %eax,%es:(%edi)
}
80105c8f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105c92:	89 d0                	mov    %edx,%eax
80105c94:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105c97:	89 ec                	mov    %ebp,%esp
80105c99:	5d                   	pop    %ebp
80105c9a:	c3                   	ret    
80105c9b:	90                   	nop
80105c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ca0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105ca0:	55                   	push   %ebp
80105ca1:	89 e5                	mov    %esp,%ebp
80105ca3:	57                   	push   %edi
80105ca4:	8b 7d 0c             	mov    0xc(%ebp),%edi
80105ca7:	56                   	push   %esi
80105ca8:	8b 75 08             	mov    0x8(%ebp),%esi
80105cab:	53                   	push   %ebx
80105cac:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105caf:	85 db                	test   %ebx,%ebx
80105cb1:	74 27                	je     80105cda <memcmp+0x3a>
    if(*s1 != *s2)
80105cb3:	0f b6 16             	movzbl (%esi),%edx
80105cb6:	0f b6 0f             	movzbl (%edi),%ecx
80105cb9:	38 d1                	cmp    %dl,%cl
80105cbb:	75 2b                	jne    80105ce8 <memcmp+0x48>
80105cbd:	b8 01 00 00 00       	mov    $0x1,%eax
80105cc2:	eb 12                	jmp    80105cd6 <memcmp+0x36>
80105cc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105cc8:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80105ccc:	40                   	inc    %eax
80105ccd:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80105cd2:	38 ca                	cmp    %cl,%dl
80105cd4:	75 12                	jne    80105ce8 <memcmp+0x48>
  while(n-- > 0){
80105cd6:	39 d8                	cmp    %ebx,%eax
80105cd8:	75 ee                	jne    80105cc8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80105cda:	5b                   	pop    %ebx
  return 0;
80105cdb:	31 c0                	xor    %eax,%eax
}
80105cdd:	5e                   	pop    %esi
80105cde:	5f                   	pop    %edi
80105cdf:	5d                   	pop    %ebp
80105ce0:	c3                   	ret    
80105ce1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ce8:	5b                   	pop    %ebx
      return *s1 - *s2;
80105ce9:	0f b6 c2             	movzbl %dl,%eax
80105cec:	29 c8                	sub    %ecx,%eax
}
80105cee:	5e                   	pop    %esi
80105cef:	5f                   	pop    %edi
80105cf0:	5d                   	pop    %ebp
80105cf1:	c3                   	ret    
80105cf2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105d00 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105d00:	55                   	push   %ebp
80105d01:	89 e5                	mov    %esp,%ebp
80105d03:	56                   	push   %esi
80105d04:	8b 45 08             	mov    0x8(%ebp),%eax
80105d07:	53                   	push   %ebx
80105d08:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80105d0b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80105d0e:	39 c3                	cmp    %eax,%ebx
80105d10:	73 26                	jae    80105d38 <memmove+0x38>
80105d12:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80105d15:	39 c8                	cmp    %ecx,%eax
80105d17:	73 1f                	jae    80105d38 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80105d19:	85 f6                	test   %esi,%esi
80105d1b:	8d 56 ff             	lea    -0x1(%esi),%edx
80105d1e:	74 0d                	je     80105d2d <memmove+0x2d>
      *--d = *--s;
80105d20:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105d24:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80105d27:	4a                   	dec    %edx
80105d28:	83 fa ff             	cmp    $0xffffffff,%edx
80105d2b:	75 f3                	jne    80105d20 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80105d2d:	5b                   	pop    %ebx
80105d2e:	5e                   	pop    %esi
80105d2f:	5d                   	pop    %ebp
80105d30:	c3                   	ret    
80105d31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80105d38:	31 d2                	xor    %edx,%edx
80105d3a:	85 f6                	test   %esi,%esi
80105d3c:	74 ef                	je     80105d2d <memmove+0x2d>
80105d3e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80105d40:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105d44:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80105d47:	42                   	inc    %edx
    while(n-- > 0)
80105d48:	39 d6                	cmp    %edx,%esi
80105d4a:	75 f4                	jne    80105d40 <memmove+0x40>
}
80105d4c:	5b                   	pop    %ebx
80105d4d:	5e                   	pop    %esi
80105d4e:	5d                   	pop    %ebp
80105d4f:	c3                   	ret    

80105d50 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105d50:	55                   	push   %ebp
80105d51:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80105d53:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80105d54:	eb aa                	jmp    80105d00 <memmove>
80105d56:	8d 76 00             	lea    0x0(%esi),%esi
80105d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105d60 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80105d60:	55                   	push   %ebp
80105d61:	89 e5                	mov    %esp,%ebp
80105d63:	57                   	push   %edi
80105d64:	8b 7d 10             	mov    0x10(%ebp),%edi
80105d67:	56                   	push   %esi
80105d68:	8b 75 0c             	mov    0xc(%ebp),%esi
80105d6b:	53                   	push   %ebx
80105d6c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
80105d6f:	85 ff                	test   %edi,%edi
80105d71:	74 2d                	je     80105da0 <strncmp+0x40>
80105d73:	0f b6 03             	movzbl (%ebx),%eax
80105d76:	0f b6 0e             	movzbl (%esi),%ecx
80105d79:	84 c0                	test   %al,%al
80105d7b:	74 37                	je     80105db4 <strncmp+0x54>
80105d7d:	38 c1                	cmp    %al,%cl
80105d7f:	75 33                	jne    80105db4 <strncmp+0x54>
80105d81:	01 f7                	add    %esi,%edi
80105d83:	eb 13                	jmp    80105d98 <strncmp+0x38>
80105d85:	8d 76 00             	lea    0x0(%esi),%esi
80105d88:	0f b6 03             	movzbl (%ebx),%eax
80105d8b:	84 c0                	test   %al,%al
80105d8d:	74 21                	je     80105db0 <strncmp+0x50>
80105d8f:	0f b6 0a             	movzbl (%edx),%ecx
80105d92:	89 d6                	mov    %edx,%esi
80105d94:	38 c8                	cmp    %cl,%al
80105d96:	75 1c                	jne    80105db4 <strncmp+0x54>
    n--, p++, q++;
80105d98:	8d 56 01             	lea    0x1(%esi),%edx
80105d9b:	43                   	inc    %ebx
  while(n > 0 && *p && *p == *q)
80105d9c:	39 fa                	cmp    %edi,%edx
80105d9e:	75 e8                	jne    80105d88 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80105da0:	5b                   	pop    %ebx
    return 0;
80105da1:	31 c0                	xor    %eax,%eax
}
80105da3:	5e                   	pop    %esi
80105da4:	5f                   	pop    %edi
80105da5:	5d                   	pop    %ebp
80105da6:	c3                   	ret    
80105da7:	89 f6                	mov    %esi,%esi
80105da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105db0:	0f b6 4e 01          	movzbl 0x1(%esi),%ecx
80105db4:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
80105db5:	29 c8                	sub    %ecx,%eax
}
80105db7:	5e                   	pop    %esi
80105db8:	5f                   	pop    %edi
80105db9:	5d                   	pop    %ebp
80105dba:	c3                   	ret    
80105dbb:	90                   	nop
80105dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105dc0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105dc0:	55                   	push   %ebp
80105dc1:	89 e5                	mov    %esp,%ebp
80105dc3:	8b 45 08             	mov    0x8(%ebp),%eax
80105dc6:	56                   	push   %esi
80105dc7:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105dca:	53                   	push   %ebx
80105dcb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80105dce:	89 c2                	mov    %eax,%edx
80105dd0:	eb 15                	jmp    80105de7 <strncpy+0x27>
80105dd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105dd8:	46                   	inc    %esi
80105dd9:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
80105ddd:	42                   	inc    %edx
80105dde:	84 c9                	test   %cl,%cl
80105de0:	88 4a ff             	mov    %cl,-0x1(%edx)
80105de3:	74 09                	je     80105dee <strncpy+0x2e>
80105de5:	89 d9                	mov    %ebx,%ecx
80105de7:	85 c9                	test   %ecx,%ecx
80105de9:	8d 59 ff             	lea    -0x1(%ecx),%ebx
80105dec:	7f ea                	jg     80105dd8 <strncpy+0x18>
    ;
  while(n-- > 0)
80105dee:	31 c9                	xor    %ecx,%ecx
80105df0:	85 db                	test   %ebx,%ebx
80105df2:	7e 19                	jle    80105e0d <strncpy+0x4d>
80105df4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105dfa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *s++ = 0;
80105e00:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80105e04:	89 de                	mov    %ebx,%esi
80105e06:	41                   	inc    %ecx
80105e07:	29 ce                	sub    %ecx,%esi
  while(n-- > 0)
80105e09:	85 f6                	test   %esi,%esi
80105e0b:	7f f3                	jg     80105e00 <strncpy+0x40>
  return os;
}
80105e0d:	5b                   	pop    %ebx
80105e0e:	5e                   	pop    %esi
80105e0f:	5d                   	pop    %ebp
80105e10:	c3                   	ret    
80105e11:	eb 0d                	jmp    80105e20 <safestrcpy>
80105e13:	90                   	nop
80105e14:	90                   	nop
80105e15:	90                   	nop
80105e16:	90                   	nop
80105e17:	90                   	nop
80105e18:	90                   	nop
80105e19:	90                   	nop
80105e1a:	90                   	nop
80105e1b:	90                   	nop
80105e1c:	90                   	nop
80105e1d:	90                   	nop
80105e1e:	90                   	nop
80105e1f:	90                   	nop

80105e20 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105e20:	55                   	push   %ebp
80105e21:	89 e5                	mov    %esp,%ebp
80105e23:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105e26:	56                   	push   %esi
80105e27:	8b 45 08             	mov    0x8(%ebp),%eax
80105e2a:	53                   	push   %ebx
80105e2b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80105e2e:	85 c9                	test   %ecx,%ecx
80105e30:	7e 22                	jle    80105e54 <safestrcpy+0x34>
80105e32:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80105e36:	89 c1                	mov    %eax,%ecx
80105e38:	eb 13                	jmp    80105e4d <safestrcpy+0x2d>
80105e3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105e40:	42                   	inc    %edx
80105e41:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80105e45:	41                   	inc    %ecx
80105e46:	84 db                	test   %bl,%bl
80105e48:	88 59 ff             	mov    %bl,-0x1(%ecx)
80105e4b:	74 04                	je     80105e51 <safestrcpy+0x31>
80105e4d:	39 f2                	cmp    %esi,%edx
80105e4f:	75 ef                	jne    80105e40 <safestrcpy+0x20>
    ;
  *s = 0;
80105e51:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80105e54:	5b                   	pop    %ebx
80105e55:	5e                   	pop    %esi
80105e56:	5d                   	pop    %ebp
80105e57:	c3                   	ret    
80105e58:	90                   	nop
80105e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e60 <strlen>:

int
strlen(const char *s)
{
80105e60:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105e61:	31 c0                	xor    %eax,%eax
{
80105e63:	89 e5                	mov    %esp,%ebp
80105e65:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105e68:	80 3a 00             	cmpb   $0x0,(%edx)
80105e6b:	74 0a                	je     80105e77 <strlen+0x17>
80105e6d:	8d 76 00             	lea    0x0(%esi),%esi
80105e70:	40                   	inc    %eax
80105e71:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105e75:	75 f9                	jne    80105e70 <strlen+0x10>
    ;
  return n;
}
80105e77:	5d                   	pop    %ebp
80105e78:	c3                   	ret    

80105e79 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80105e79:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80105e7d:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80105e81:	55                   	push   %ebp
  pushl %ebx
80105e82:	53                   	push   %ebx
  pushl %esi
80105e83:	56                   	push   %esi
  pushl %edi
80105e84:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105e85:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105e87:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80105e89:	5f                   	pop    %edi
  popl %esi
80105e8a:	5e                   	pop    %esi
  popl %ebx
80105e8b:	5b                   	pop    %ebx
  popl %ebp
80105e8c:	5d                   	pop    %ebp
  ret
80105e8d:	c3                   	ret    
80105e8e:	66 90                	xchg   %ax,%ax

80105e90 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105e90:	55                   	push   %ebp
80105e91:	89 e5                	mov    %esp,%ebp
80105e93:	53                   	push   %ebx
80105e94:	83 ec 04             	sub    $0x4,%esp
80105e97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80105e9a:	e8 11 dc ff ff       	call   80103ab0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105e9f:	8b 00                	mov    (%eax),%eax
80105ea1:	39 d8                	cmp    %ebx,%eax
80105ea3:	76 1b                	jbe    80105ec0 <fetchint+0x30>
80105ea5:	8d 53 04             	lea    0x4(%ebx),%edx
80105ea8:	39 d0                	cmp    %edx,%eax
80105eaa:	72 14                	jb     80105ec0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80105eac:	8b 45 0c             	mov    0xc(%ebp),%eax
80105eaf:	8b 13                	mov    (%ebx),%edx
80105eb1:	89 10                	mov    %edx,(%eax)
  return 0;
80105eb3:	31 c0                	xor    %eax,%eax
}
80105eb5:	5a                   	pop    %edx
80105eb6:	5b                   	pop    %ebx
80105eb7:	5d                   	pop    %ebp
80105eb8:	c3                   	ret    
80105eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105ec0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ec5:	eb ee                	jmp    80105eb5 <fetchint+0x25>
80105ec7:	89 f6                	mov    %esi,%esi
80105ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ed0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105ed0:	55                   	push   %ebp
80105ed1:	89 e5                	mov    %esp,%ebp
80105ed3:	53                   	push   %ebx
80105ed4:	83 ec 04             	sub    $0x4,%esp
80105ed7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80105eda:	e8 d1 db ff ff       	call   80103ab0 <myproc>

  if(addr >= curproc->sz)
80105edf:	39 18                	cmp    %ebx,(%eax)
80105ee1:	76 27                	jbe    80105f0a <fetchstr+0x3a>
    return -1;
  *pp = (char*)addr;
80105ee3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105ee6:	89 da                	mov    %ebx,%edx
80105ee8:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80105eea:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80105eec:	39 c3                	cmp    %eax,%ebx
80105eee:	73 1a                	jae    80105f0a <fetchstr+0x3a>
    if(*s == 0)
80105ef0:	80 3b 00             	cmpb   $0x0,(%ebx)
80105ef3:	75 10                	jne    80105f05 <fetchstr+0x35>
80105ef5:	eb 29                	jmp    80105f20 <fetchstr+0x50>
80105ef7:	89 f6                	mov    %esi,%esi
80105ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105f00:	80 3a 00             	cmpb   $0x0,(%edx)
80105f03:	74 13                	je     80105f18 <fetchstr+0x48>
  for(s = *pp; s < ep; s++){
80105f05:	42                   	inc    %edx
80105f06:	39 d0                	cmp    %edx,%eax
80105f08:	77 f6                	ja     80105f00 <fetchstr+0x30>
    return -1;
80105f0a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80105f0f:	5a                   	pop    %edx
80105f10:	5b                   	pop    %ebx
80105f11:	5d                   	pop    %ebp
80105f12:	c3                   	ret    
80105f13:	90                   	nop
80105f14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105f18:	89 d0                	mov    %edx,%eax
80105f1a:	5a                   	pop    %edx
80105f1b:	29 d8                	sub    %ebx,%eax
80105f1d:	5b                   	pop    %ebx
80105f1e:	5d                   	pop    %ebp
80105f1f:	c3                   	ret    
    if(*s == 0)
80105f20:	31 c0                	xor    %eax,%eax
      return s - *pp;
80105f22:	eb eb                	jmp    80105f0f <fetchstr+0x3f>
80105f24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105f2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105f30 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105f30:	55                   	push   %ebp
80105f31:	89 e5                	mov    %esp,%ebp
80105f33:	56                   	push   %esi
80105f34:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105f35:	e8 76 db ff ff       	call   80103ab0 <myproc>
80105f3a:	8b 55 08             	mov    0x8(%ebp),%edx
80105f3d:	8b 40 18             	mov    0x18(%eax),%eax
80105f40:	8b 40 44             	mov    0x44(%eax),%eax
80105f43:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105f46:	e8 65 db ff ff       	call   80103ab0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105f4b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105f4e:	8b 00                	mov    (%eax),%eax
80105f50:	39 c6                	cmp    %eax,%esi
80105f52:	73 1c                	jae    80105f70 <argint+0x40>
80105f54:	8d 53 08             	lea    0x8(%ebx),%edx
80105f57:	39 d0                	cmp    %edx,%eax
80105f59:	72 15                	jb     80105f70 <argint+0x40>
  *ip = *(int*)(addr);
80105f5b:	8b 45 0c             	mov    0xc(%ebp),%eax
80105f5e:	8b 53 04             	mov    0x4(%ebx),%edx
80105f61:	89 10                	mov    %edx,(%eax)
  return 0;
80105f63:	31 c0                	xor    %eax,%eax
}
80105f65:	5b                   	pop    %ebx
80105f66:	5e                   	pop    %esi
80105f67:	5d                   	pop    %ebp
80105f68:	c3                   	ret    
80105f69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105f70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105f75:	eb ee                	jmp    80105f65 <argint+0x35>
80105f77:	89 f6                	mov    %esi,%esi
80105f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105f80 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105f80:	55                   	push   %ebp
80105f81:	89 e5                	mov    %esp,%ebp
80105f83:	56                   	push   %esi
80105f84:	53                   	push   %ebx
80105f85:	83 ec 20             	sub    $0x20,%esp
80105f88:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80105f8b:	e8 20 db ff ff       	call   80103ab0 <myproc>
80105f90:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80105f92:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f95:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f99:	8b 45 08             	mov    0x8(%ebp),%eax
80105f9c:	89 04 24             	mov    %eax,(%esp)
80105f9f:	e8 8c ff ff ff       	call   80105f30 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105fa4:	c1 e8 1f             	shr    $0x1f,%eax
80105fa7:	84 c0                	test   %al,%al
80105fa9:	75 2d                	jne    80105fd8 <argptr+0x58>
80105fab:	89 d8                	mov    %ebx,%eax
80105fad:	c1 e8 1f             	shr    $0x1f,%eax
80105fb0:	84 c0                	test   %al,%al
80105fb2:	75 24                	jne    80105fd8 <argptr+0x58>
80105fb4:	8b 16                	mov    (%esi),%edx
80105fb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105fb9:	39 c2                	cmp    %eax,%edx
80105fbb:	76 1b                	jbe    80105fd8 <argptr+0x58>
80105fbd:	01 c3                	add    %eax,%ebx
80105fbf:	39 da                	cmp    %ebx,%edx
80105fc1:	72 15                	jb     80105fd8 <argptr+0x58>
    return -1;
  *pp = (char*)i;
80105fc3:	8b 55 0c             	mov    0xc(%ebp),%edx
80105fc6:	89 02                	mov    %eax,(%edx)
  return 0;
80105fc8:	31 c0                	xor    %eax,%eax
}
80105fca:	83 c4 20             	add    $0x20,%esp
80105fcd:	5b                   	pop    %ebx
80105fce:	5e                   	pop    %esi
80105fcf:	5d                   	pop    %ebp
80105fd0:	c3                   	ret    
80105fd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105fd8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fdd:	eb eb                	jmp    80105fca <argptr+0x4a>
80105fdf:	90                   	nop

80105fe0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105fe0:	55                   	push   %ebp
80105fe1:	89 e5                	mov    %esp,%ebp
80105fe3:	83 ec 28             	sub    $0x28,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105fe6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105fe9:	89 44 24 04          	mov    %eax,0x4(%esp)
80105fed:	8b 45 08             	mov    0x8(%ebp),%eax
80105ff0:	89 04 24             	mov    %eax,(%esp)
80105ff3:	e8 38 ff ff ff       	call   80105f30 <argint>
80105ff8:	85 c0                	test   %eax,%eax
80105ffa:	78 14                	js     80106010 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80105ffc:	8b 45 0c             	mov    0xc(%ebp),%eax
80105fff:	89 44 24 04          	mov    %eax,0x4(%esp)
80106003:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106006:	89 04 24             	mov    %eax,(%esp)
80106009:	e8 c2 fe ff ff       	call   80105ed0 <fetchstr>
}
8010600e:	c9                   	leave  
8010600f:	c3                   	ret    
    return -1;
80106010:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106015:	c9                   	leave  
80106016:	c3                   	ret    
80106017:	89 f6                	mov    %esi,%esi
80106019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106020 <syscall>:
[SYS_wait_stat]    sys_wait_stat,
};

void
syscall(void)
{
80106020:	55                   	push   %ebp
80106021:	89 e5                	mov    %esp,%ebp
80106023:	53                   	push   %ebx
80106024:	83 ec 14             	sub    $0x14,%esp
  int num;
  struct proc *curproc = myproc();
80106027:	e8 84 da ff ff       	call   80103ab0 <myproc>
8010602c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010602e:	8b 40 18             	mov    0x18(%eax),%eax
80106031:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80106034:	8d 50 ff             	lea    -0x1(%eax),%edx
80106037:	83 fa 18             	cmp    $0x18,%edx
8010603a:	77 1c                	ja     80106058 <syscall+0x38>
8010603c:	8b 14 85 c0 8f 10 80 	mov    -0x7fef7040(,%eax,4),%edx
80106043:	85 d2                	test   %edx,%edx
80106045:	74 11                	je     80106058 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80106047:	ff d2                	call   *%edx
80106049:	8b 53 18             	mov    0x18(%ebx),%edx
8010604c:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
8010604f:	83 c4 14             	add    $0x14,%esp
80106052:	5b                   	pop    %ebx
80106053:	5d                   	pop    %ebp
80106054:	c3                   	ret    
80106055:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80106058:	89 44 24 0c          	mov    %eax,0xc(%esp)
            curproc->pid, curproc->name, num);
8010605c:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010605f:	89 44 24 08          	mov    %eax,0x8(%esp)
    cprintf("%d %s: unknown sys call %d\n",
80106063:	8b 43 10             	mov    0x10(%ebx),%eax
80106066:	c7 04 24 9c 8f 10 80 	movl   $0x80108f9c,(%esp)
8010606d:	89 44 24 04          	mov    %eax,0x4(%esp)
80106071:	e8 da a5 ff ff       	call   80100650 <cprintf>
    curproc->tf->eax = -1;
80106076:	8b 43 18             	mov    0x18(%ebx),%eax
80106079:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80106080:	83 c4 14             	add    $0x14,%esp
80106083:	5b                   	pop    %ebx
80106084:	5d                   	pop    %ebp
80106085:	c3                   	ret    
80106086:	66 90                	xchg   %ax,%ax
80106088:	66 90                	xchg   %ax,%ax
8010608a:	66 90                	xchg   %ax,%ax
8010608c:	66 90                	xchg   %ax,%ax
8010608e:	66 90                	xchg   %ax,%ax

80106090 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80106090:	55                   	push   %ebp
80106091:	0f bf d2             	movswl %dx,%edx
80106094:	89 e5                	mov    %esp,%ebp
80106096:	83 ec 58             	sub    $0x58,%esp
80106099:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010609c:	0f bf 7d 08          	movswl 0x8(%ebp),%edi
801060a0:	0f bf c9             	movswl %cx,%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801060a3:	89 04 24             	mov    %eax,(%esp)
{
801060a6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801060a9:	89 75 f8             	mov    %esi,-0x8(%ebp)
801060ac:	89 7d bc             	mov    %edi,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801060af:	8d 7d da             	lea    -0x26(%ebp),%edi
801060b2:	89 7c 24 04          	mov    %edi,0x4(%esp)
{
801060b6:	89 55 c4             	mov    %edx,-0x3c(%ebp)
801060b9:	89 4d c0             	mov    %ecx,-0x40(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801060bc:	e8 2f bf ff ff       	call   80101ff0 <nameiparent>
801060c1:	85 c0                	test   %eax,%eax
801060c3:	0f 84 4f 01 00 00    	je     80106218 <create+0x188>
    return 0;
  ilock(dp);
801060c9:	89 04 24             	mov    %eax,(%esp)
801060cc:	89 c3                	mov    %eax,%ebx
801060ce:	e8 1d b6 ff ff       	call   801016f0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
801060d3:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801060d6:	89 44 24 08          	mov    %eax,0x8(%esp)
801060da:	89 7c 24 04          	mov    %edi,0x4(%esp)
801060de:	89 1c 24             	mov    %ebx,(%esp)
801060e1:	e8 8a bb ff ff       	call   80101c70 <dirlookup>
801060e6:	85 c0                	test   %eax,%eax
801060e8:	89 c6                	mov    %eax,%esi
801060ea:	74 34                	je     80106120 <create+0x90>
    iunlockput(dp);
801060ec:	89 1c 24             	mov    %ebx,(%esp)
801060ef:	e8 8c b8 ff ff       	call   80101980 <iunlockput>
    ilock(ip);
801060f4:	89 34 24             	mov    %esi,(%esp)
801060f7:	e8 f4 b5 ff ff       	call   801016f0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801060fc:	83 7d c4 02          	cmpl   $0x2,-0x3c(%ebp)
80106100:	0f 85 9a 00 00 00    	jne    801061a0 <create+0x110>
80106106:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010610b:	0f 85 8f 00 00 00    	jne    801061a0 <create+0x110>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80106111:	89 f0                	mov    %esi,%eax
80106113:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80106116:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106119:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010611c:	89 ec                	mov    %ebp,%esp
8010611e:	5d                   	pop    %ebp
8010611f:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80106120:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80106123:	89 44 24 04          	mov    %eax,0x4(%esp)
80106127:	8b 03                	mov    (%ebx),%eax
80106129:	89 04 24             	mov    %eax,(%esp)
8010612c:	e8 3f b4 ff ff       	call   80101570 <ialloc>
80106131:	85 c0                	test   %eax,%eax
80106133:	89 c6                	mov    %eax,%esi
80106135:	0f 84 f0 00 00 00    	je     8010622b <create+0x19b>
  ilock(ip);
8010613b:	89 04 24             	mov    %eax,(%esp)
8010613e:	e8 ad b5 ff ff       	call   801016f0 <ilock>
  ip->major = major;
80106143:	8b 45 c0             	mov    -0x40(%ebp),%eax
  ip->nlink = 1;
80106146:	66 c7 46 56 01 00    	movw   $0x1,0x56(%esi)
  ip->major = major;
8010614c:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80106150:	8b 45 bc             	mov    -0x44(%ebp),%eax
80106153:	66 89 46 54          	mov    %ax,0x54(%esi)
  iupdate(ip);
80106157:	89 34 24             	mov    %esi,(%esp)
8010615a:	e8 d1 b4 ff ff       	call   80101630 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
8010615f:	83 7d c4 01          	cmpl   $0x1,-0x3c(%ebp)
80106163:	74 5b                	je     801061c0 <create+0x130>
  if(dirlink(dp, name, ip->inum) < 0)
80106165:	8b 46 04             	mov    0x4(%esi),%eax
80106168:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010616c:	89 1c 24             	mov    %ebx,(%esp)
8010616f:	89 44 24 08          	mov    %eax,0x8(%esp)
80106173:	e8 78 bd ff ff       	call   80101ef0 <dirlink>
80106178:	85 c0                	test   %eax,%eax
8010617a:	0f 88 9f 00 00 00    	js     8010621f <create+0x18f>
  iunlockput(dp);
80106180:	89 1c 24             	mov    %ebx,(%esp)
80106183:	e8 f8 b7 ff ff       	call   80101980 <iunlockput>
}
80106188:	89 f0                	mov    %esi,%eax
8010618a:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010618d:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106190:	8b 7d fc             	mov    -0x4(%ebp),%edi
80106193:	89 ec                	mov    %ebp,%esp
80106195:	5d                   	pop    %ebp
80106196:	c3                   	ret    
80106197:	89 f6                	mov    %esi,%esi
80106199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
801061a0:	89 34 24             	mov    %esi,(%esp)
    return 0;
801061a3:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
801061a5:	e8 d6 b7 ff ff       	call   80101980 <iunlockput>
}
801061aa:	89 f0                	mov    %esi,%eax
801061ac:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801061af:	8b 75 f8             	mov    -0x8(%ebp),%esi
801061b2:	8b 7d fc             	mov    -0x4(%ebp),%edi
801061b5:	89 ec                	mov    %ebp,%esp
801061b7:	5d                   	pop    %ebp
801061b8:	c3                   	ret    
801061b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
801061c0:	66 ff 43 56          	incw   0x56(%ebx)
    iupdate(dp);
801061c4:	89 1c 24             	mov    %ebx,(%esp)
801061c7:	e8 64 b4 ff ff       	call   80101630 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801061cc:	8b 46 04             	mov    0x4(%esi),%eax
801061cf:	ba 44 90 10 80       	mov    $0x80109044,%edx
801061d4:	89 54 24 04          	mov    %edx,0x4(%esp)
801061d8:	89 34 24             	mov    %esi,(%esp)
801061db:	89 44 24 08          	mov    %eax,0x8(%esp)
801061df:	e8 0c bd ff ff       	call   80101ef0 <dirlink>
801061e4:	85 c0                	test   %eax,%eax
801061e6:	78 20                	js     80106208 <create+0x178>
801061e8:	8b 43 04             	mov    0x4(%ebx),%eax
801061eb:	89 34 24             	mov    %esi,(%esp)
801061ee:	89 44 24 08          	mov    %eax,0x8(%esp)
801061f2:	b8 43 90 10 80       	mov    $0x80109043,%eax
801061f7:	89 44 24 04          	mov    %eax,0x4(%esp)
801061fb:	e8 f0 bc ff ff       	call   80101ef0 <dirlink>
80106200:	85 c0                	test   %eax,%eax
80106202:	0f 89 5d ff ff ff    	jns    80106165 <create+0xd5>
      panic("create dots");
80106208:	c7 04 24 37 90 10 80 	movl   $0x80109037,(%esp)
8010620f:	e8 5c a1 ff ff       	call   80100370 <panic>
80106214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80106218:	31 f6                	xor    %esi,%esi
8010621a:	e9 f2 fe ff ff       	jmp    80106111 <create+0x81>
    panic("create: dirlink");
8010621f:	c7 04 24 46 90 10 80 	movl   $0x80109046,(%esp)
80106226:	e8 45 a1 ff ff       	call   80100370 <panic>
    panic("create: ialloc");
8010622b:	c7 04 24 28 90 10 80 	movl   $0x80109028,(%esp)
80106232:	e8 39 a1 ff ff       	call   80100370 <panic>
80106237:	89 f6                	mov    %esi,%esi
80106239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106240 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80106240:	55                   	push   %ebp
80106241:	89 e5                	mov    %esp,%ebp
80106243:	56                   	push   %esi
80106244:	89 d6                	mov    %edx,%esi
80106246:	53                   	push   %ebx
80106247:	89 c3                	mov    %eax,%ebx
80106249:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
8010624c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010624f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106253:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010625a:	e8 d1 fc ff ff       	call   80105f30 <argint>
8010625f:	85 c0                	test   %eax,%eax
80106261:	78 2d                	js     80106290 <argfd.constprop.0+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80106263:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80106267:	77 27                	ja     80106290 <argfd.constprop.0+0x50>
80106269:	e8 42 d8 ff ff       	call   80103ab0 <myproc>
8010626e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106271:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80106275:	85 c0                	test   %eax,%eax
80106277:	74 17                	je     80106290 <argfd.constprop.0+0x50>
  if(pfd)
80106279:	85 db                	test   %ebx,%ebx
8010627b:	74 02                	je     8010627f <argfd.constprop.0+0x3f>
    *pfd = fd;
8010627d:	89 13                	mov    %edx,(%ebx)
    *pf = f;
8010627f:	89 06                	mov    %eax,(%esi)
  return 0;
80106281:	31 c0                	xor    %eax,%eax
}
80106283:	83 c4 20             	add    $0x20,%esp
80106286:	5b                   	pop    %ebx
80106287:	5e                   	pop    %esi
80106288:	5d                   	pop    %ebp
80106289:	c3                   	ret    
8010628a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106290:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106295:	eb ec                	jmp    80106283 <argfd.constprop.0+0x43>
80106297:	89 f6                	mov    %esi,%esi
80106299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801062a0 <sys_dup>:
{
801062a0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
801062a1:	31 c0                	xor    %eax,%eax
{
801062a3:	89 e5                	mov    %esp,%ebp
801062a5:	56                   	push   %esi
801062a6:	53                   	push   %ebx
801062a7:	83 ec 20             	sub    $0x20,%esp
  if(argfd(0, 0, &f) < 0)
801062aa:	8d 55 f4             	lea    -0xc(%ebp),%edx
801062ad:	e8 8e ff ff ff       	call   80106240 <argfd.constprop.0>
801062b2:	85 c0                	test   %eax,%eax
801062b4:	78 3a                	js     801062f0 <sys_dup+0x50>
  if((fd=fdalloc(f)) < 0)
801062b6:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
801062b9:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801062bb:	e8 f0 d7 ff ff       	call   80103ab0 <myproc>
801062c0:	eb 0c                	jmp    801062ce <sys_dup+0x2e>
801062c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
801062c8:	43                   	inc    %ebx
801062c9:	83 fb 10             	cmp    $0x10,%ebx
801062cc:	74 22                	je     801062f0 <sys_dup+0x50>
    if(curproc->ofile[fd] == 0){
801062ce:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801062d2:	85 d2                	test   %edx,%edx
801062d4:	75 f2                	jne    801062c8 <sys_dup+0x28>
      curproc->ofile[fd] = f;
801062d6:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
801062da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062dd:	89 04 24             	mov    %eax,(%esp)
801062e0:	e8 fb aa ff ff       	call   80100de0 <filedup>
}
801062e5:	83 c4 20             	add    $0x20,%esp
801062e8:	89 d8                	mov    %ebx,%eax
801062ea:	5b                   	pop    %ebx
801062eb:	5e                   	pop    %esi
801062ec:	5d                   	pop    %ebp
801062ed:	c3                   	ret    
801062ee:	66 90                	xchg   %ax,%ax
801062f0:	83 c4 20             	add    $0x20,%esp
    return -1;
801062f3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
801062f8:	89 d8                	mov    %ebx,%eax
801062fa:	5b                   	pop    %ebx
801062fb:	5e                   	pop    %esi
801062fc:	5d                   	pop    %ebp
801062fd:	c3                   	ret    
801062fe:	66 90                	xchg   %ax,%ax

80106300 <sys_read>:
{
80106300:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106301:	31 c0                	xor    %eax,%eax
{
80106303:	89 e5                	mov    %esp,%ebp
80106305:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106308:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010630b:	e8 30 ff ff ff       	call   80106240 <argfd.constprop.0>
80106310:	85 c0                	test   %eax,%eax
80106312:	78 54                	js     80106368 <sys_read+0x68>
80106314:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106317:	89 44 24 04          	mov    %eax,0x4(%esp)
8010631b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106322:	e8 09 fc ff ff       	call   80105f30 <argint>
80106327:	85 c0                	test   %eax,%eax
80106329:	78 3d                	js     80106368 <sys_read+0x68>
8010632b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010632e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106335:	89 44 24 08          	mov    %eax,0x8(%esp)
80106339:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010633c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106340:	e8 3b fc ff ff       	call   80105f80 <argptr>
80106345:	85 c0                	test   %eax,%eax
80106347:	78 1f                	js     80106368 <sys_read+0x68>
  return fileread(f, p, n);
80106349:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010634c:	89 44 24 08          	mov    %eax,0x8(%esp)
80106350:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106353:	89 44 24 04          	mov    %eax,0x4(%esp)
80106357:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010635a:	89 04 24             	mov    %eax,(%esp)
8010635d:	e8 fe ab ff ff       	call   80100f60 <fileread>
}
80106362:	c9                   	leave  
80106363:	c3                   	ret    
80106364:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106368:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010636d:	c9                   	leave  
8010636e:	c3                   	ret    
8010636f:	90                   	nop

80106370 <sys_write>:
{
80106370:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106371:	31 c0                	xor    %eax,%eax
{
80106373:	89 e5                	mov    %esp,%ebp
80106375:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106378:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010637b:	e8 c0 fe ff ff       	call   80106240 <argfd.constprop.0>
80106380:	85 c0                	test   %eax,%eax
80106382:	78 54                	js     801063d8 <sys_write+0x68>
80106384:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106387:	89 44 24 04          	mov    %eax,0x4(%esp)
8010638b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106392:	e8 99 fb ff ff       	call   80105f30 <argint>
80106397:	85 c0                	test   %eax,%eax
80106399:	78 3d                	js     801063d8 <sys_write+0x68>
8010639b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010639e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801063a5:	89 44 24 08          	mov    %eax,0x8(%esp)
801063a9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801063ac:	89 44 24 04          	mov    %eax,0x4(%esp)
801063b0:	e8 cb fb ff ff       	call   80105f80 <argptr>
801063b5:	85 c0                	test   %eax,%eax
801063b7:	78 1f                	js     801063d8 <sys_write+0x68>
  return filewrite(f, p, n);
801063b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801063bc:	89 44 24 08          	mov    %eax,0x8(%esp)
801063c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063c3:	89 44 24 04          	mov    %eax,0x4(%esp)
801063c7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801063ca:	89 04 24             	mov    %eax,(%esp)
801063cd:	e8 3e ac ff ff       	call   80101010 <filewrite>
}
801063d2:	c9                   	leave  
801063d3:	c3                   	ret    
801063d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801063d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801063dd:	c9                   	leave  
801063de:	c3                   	ret    
801063df:	90                   	nop

801063e0 <sys_close>:
{
801063e0:	55                   	push   %ebp
801063e1:	89 e5                	mov    %esp,%ebp
801063e3:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, &fd, &f) < 0)
801063e6:	8d 55 f4             	lea    -0xc(%ebp),%edx
801063e9:	8d 45 f0             	lea    -0x10(%ebp),%eax
801063ec:	e8 4f fe ff ff       	call   80106240 <argfd.constprop.0>
801063f1:	85 c0                	test   %eax,%eax
801063f3:	78 23                	js     80106418 <sys_close+0x38>
  myproc()->ofile[fd] = 0;
801063f5:	e8 b6 d6 ff ff       	call   80103ab0 <myproc>
801063fa:	8b 55 f0             	mov    -0x10(%ebp),%edx
801063fd:	31 c9                	xor    %ecx,%ecx
801063ff:	89 4c 90 28          	mov    %ecx,0x28(%eax,%edx,4)
  fileclose(f);
80106403:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106406:	89 04 24             	mov    %eax,(%esp)
80106409:	e8 22 aa ff ff       	call   80100e30 <fileclose>
  return 0;
8010640e:	31 c0                	xor    %eax,%eax
}
80106410:	c9                   	leave  
80106411:	c3                   	ret    
80106412:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106418:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010641d:	c9                   	leave  
8010641e:	c3                   	ret    
8010641f:	90                   	nop

80106420 <sys_fstat>:
{
80106420:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80106421:	31 c0                	xor    %eax,%eax
{
80106423:	89 e5                	mov    %esp,%ebp
80106425:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80106428:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010642b:	e8 10 fe ff ff       	call   80106240 <argfd.constprop.0>
80106430:	85 c0                	test   %eax,%eax
80106432:	78 3c                	js     80106470 <sys_fstat+0x50>
80106434:	b8 14 00 00 00       	mov    $0x14,%eax
80106439:	89 44 24 08          	mov    %eax,0x8(%esp)
8010643d:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106440:	89 44 24 04          	mov    %eax,0x4(%esp)
80106444:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010644b:	e8 30 fb ff ff       	call   80105f80 <argptr>
80106450:	85 c0                	test   %eax,%eax
80106452:	78 1c                	js     80106470 <sys_fstat+0x50>
  return filestat(f, st);
80106454:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106457:	89 44 24 04          	mov    %eax,0x4(%esp)
8010645b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010645e:	89 04 24             	mov    %eax,(%esp)
80106461:	e8 aa aa ff ff       	call   80100f10 <filestat>
}
80106466:	c9                   	leave  
80106467:	c3                   	ret    
80106468:	90                   	nop
80106469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106470:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106475:	c9                   	leave  
80106476:	c3                   	ret    
80106477:	89 f6                	mov    %esi,%esi
80106479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106480 <sys_link>:
{
80106480:	55                   	push   %ebp
80106481:	89 e5                	mov    %esp,%ebp
80106483:	57                   	push   %edi
80106484:	56                   	push   %esi
80106485:	53                   	push   %ebx
80106486:	83 ec 3c             	sub    $0x3c,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80106489:	8d 45 d4             	lea    -0x2c(%ebp),%eax
8010648c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106490:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106497:	e8 44 fb ff ff       	call   80105fe0 <argstr>
8010649c:	85 c0                	test   %eax,%eax
8010649e:	0f 88 e5 00 00 00    	js     80106589 <sys_link+0x109>
801064a4:	8d 45 d0             	lea    -0x30(%ebp),%eax
801064a7:	89 44 24 04          	mov    %eax,0x4(%esp)
801064ab:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801064b2:	e8 29 fb ff ff       	call   80105fe0 <argstr>
801064b7:	85 c0                	test   %eax,%eax
801064b9:	0f 88 ca 00 00 00    	js     80106589 <sys_link+0x109>
  begin_op();
801064bf:	e8 cc c7 ff ff       	call   80102c90 <begin_op>
  if((ip = namei(old)) == 0){
801064c4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801064c7:	89 04 24             	mov    %eax,(%esp)
801064ca:	e8 01 bb ff ff       	call   80101fd0 <namei>
801064cf:	85 c0                	test   %eax,%eax
801064d1:	89 c3                	mov    %eax,%ebx
801064d3:	0f 84 ab 00 00 00    	je     80106584 <sys_link+0x104>
  ilock(ip);
801064d9:	89 04 24             	mov    %eax,(%esp)
801064dc:	e8 0f b2 ff ff       	call   801016f0 <ilock>
  if(ip->type == T_DIR){
801064e1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801064e6:	0f 84 90 00 00 00    	je     8010657c <sys_link+0xfc>
  ip->nlink++;
801064ec:	66 ff 43 56          	incw   0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
801064f0:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801064f3:	89 1c 24             	mov    %ebx,(%esp)
801064f6:	e8 35 b1 ff ff       	call   80101630 <iupdate>
  iunlock(ip);
801064fb:	89 1c 24             	mov    %ebx,(%esp)
801064fe:	e8 cd b2 ff ff       	call   801017d0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80106503:	8b 45 d0             	mov    -0x30(%ebp),%eax
80106506:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010650a:	89 04 24             	mov    %eax,(%esp)
8010650d:	e8 de ba ff ff       	call   80101ff0 <nameiparent>
80106512:	85 c0                	test   %eax,%eax
80106514:	89 c6                	mov    %eax,%esi
80106516:	74 50                	je     80106568 <sys_link+0xe8>
  ilock(dp);
80106518:	89 04 24             	mov    %eax,(%esp)
8010651b:	e8 d0 b1 ff ff       	call   801016f0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80106520:	8b 03                	mov    (%ebx),%eax
80106522:	39 06                	cmp    %eax,(%esi)
80106524:	75 3a                	jne    80106560 <sys_link+0xe0>
80106526:	8b 43 04             	mov    0x4(%ebx),%eax
80106529:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010652d:	89 34 24             	mov    %esi,(%esp)
80106530:	89 44 24 08          	mov    %eax,0x8(%esp)
80106534:	e8 b7 b9 ff ff       	call   80101ef0 <dirlink>
80106539:	85 c0                	test   %eax,%eax
8010653b:	78 23                	js     80106560 <sys_link+0xe0>
  iunlockput(dp);
8010653d:	89 34 24             	mov    %esi,(%esp)
80106540:	e8 3b b4 ff ff       	call   80101980 <iunlockput>
  iput(ip);
80106545:	89 1c 24             	mov    %ebx,(%esp)
80106548:	e8 d3 b2 ff ff       	call   80101820 <iput>
  end_op();
8010654d:	e8 ae c7 ff ff       	call   80102d00 <end_op>
}
80106552:	83 c4 3c             	add    $0x3c,%esp
  return 0;
80106555:	31 c0                	xor    %eax,%eax
}
80106557:	5b                   	pop    %ebx
80106558:	5e                   	pop    %esi
80106559:	5f                   	pop    %edi
8010655a:	5d                   	pop    %ebp
8010655b:	c3                   	ret    
8010655c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(dp);
80106560:	89 34 24             	mov    %esi,(%esp)
80106563:	e8 18 b4 ff ff       	call   80101980 <iunlockput>
  ilock(ip);
80106568:	89 1c 24             	mov    %ebx,(%esp)
8010656b:	e8 80 b1 ff ff       	call   801016f0 <ilock>
  ip->nlink--;
80106570:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
80106574:	89 1c 24             	mov    %ebx,(%esp)
80106577:	e8 b4 b0 ff ff       	call   80101630 <iupdate>
  iunlockput(ip);
8010657c:	89 1c 24             	mov    %ebx,(%esp)
8010657f:	e8 fc b3 ff ff       	call   80101980 <iunlockput>
  end_op();
80106584:	e8 77 c7 ff ff       	call   80102d00 <end_op>
}
80106589:	83 c4 3c             	add    $0x3c,%esp
  return -1;
8010658c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106591:	5b                   	pop    %ebx
80106592:	5e                   	pop    %esi
80106593:	5f                   	pop    %edi
80106594:	5d                   	pop    %ebp
80106595:	c3                   	ret    
80106596:	8d 76 00             	lea    0x0(%esi),%esi
80106599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801065a0 <sys_unlink>:
{
801065a0:	55                   	push   %ebp
801065a1:	89 e5                	mov    %esp,%ebp
801065a3:	57                   	push   %edi
801065a4:	56                   	push   %esi
801065a5:	53                   	push   %ebx
801065a6:	83 ec 5c             	sub    $0x5c,%esp
  if(argstr(0, &path) < 0)
801065a9:	8d 45 c0             	lea    -0x40(%ebp),%eax
801065ac:	89 44 24 04          	mov    %eax,0x4(%esp)
801065b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801065b7:	e8 24 fa ff ff       	call   80105fe0 <argstr>
801065bc:	85 c0                	test   %eax,%eax
801065be:	0f 88 68 01 00 00    	js     8010672c <sys_unlink+0x18c>
  begin_op();
801065c4:	e8 c7 c6 ff ff       	call   80102c90 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801065c9:	8b 45 c0             	mov    -0x40(%ebp),%eax
801065cc:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801065cf:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801065d3:	89 04 24             	mov    %eax,(%esp)
801065d6:	e8 15 ba ff ff       	call   80101ff0 <nameiparent>
801065db:	85 c0                	test   %eax,%eax
801065dd:	89 c6                	mov    %eax,%esi
801065df:	0f 84 42 01 00 00    	je     80106727 <sys_unlink+0x187>
  ilock(dp);
801065e5:	89 04 24             	mov    %eax,(%esp)
801065e8:	e8 03 b1 ff ff       	call   801016f0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801065ed:	b8 44 90 10 80       	mov    $0x80109044,%eax
801065f2:	89 44 24 04          	mov    %eax,0x4(%esp)
801065f6:	89 1c 24             	mov    %ebx,(%esp)
801065f9:	e8 42 b6 ff ff       	call   80101c40 <namecmp>
801065fe:	85 c0                	test   %eax,%eax
80106600:	0f 84 19 01 00 00    	je     8010671f <sys_unlink+0x17f>
80106606:	b8 43 90 10 80       	mov    $0x80109043,%eax
8010660b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010660f:	89 1c 24             	mov    %ebx,(%esp)
80106612:	e8 29 b6 ff ff       	call   80101c40 <namecmp>
80106617:	85 c0                	test   %eax,%eax
80106619:	0f 84 00 01 00 00    	je     8010671f <sys_unlink+0x17f>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010661f:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80106622:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80106626:	89 44 24 08          	mov    %eax,0x8(%esp)
8010662a:	89 34 24             	mov    %esi,(%esp)
8010662d:	e8 3e b6 ff ff       	call   80101c70 <dirlookup>
80106632:	85 c0                	test   %eax,%eax
80106634:	89 c3                	mov    %eax,%ebx
80106636:	0f 84 e3 00 00 00    	je     8010671f <sys_unlink+0x17f>
  ilock(ip);
8010663c:	89 04 24             	mov    %eax,(%esp)
8010663f:	e8 ac b0 ff ff       	call   801016f0 <ilock>
  if(ip->nlink < 1)
80106644:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80106649:	0f 8e 0e 01 00 00    	jle    8010675d <sys_unlink+0x1bd>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010664f:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106654:	8d 7d d8             	lea    -0x28(%ebp),%edi
80106657:	74 77                	je     801066d0 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
80106659:	31 d2                	xor    %edx,%edx
8010665b:	b8 10 00 00 00       	mov    $0x10,%eax
80106660:	89 54 24 04          	mov    %edx,0x4(%esp)
80106664:	89 44 24 08          	mov    %eax,0x8(%esp)
80106668:	89 3c 24             	mov    %edi,(%esp)
8010666b:	e8 d0 f5 ff ff       	call   80105c40 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80106670:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80106673:	b9 10 00 00 00       	mov    $0x10,%ecx
80106678:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
8010667c:	89 7c 24 04          	mov    %edi,0x4(%esp)
80106680:	89 34 24             	mov    %esi,(%esp)
80106683:	89 44 24 08          	mov    %eax,0x8(%esp)
80106687:	e8 64 b4 ff ff       	call   80101af0 <writei>
8010668c:	83 f8 10             	cmp    $0x10,%eax
8010668f:	0f 85 d4 00 00 00    	jne    80106769 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
80106695:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010669a:	0f 84 a0 00 00 00    	je     80106740 <sys_unlink+0x1a0>
  iunlockput(dp);
801066a0:	89 34 24             	mov    %esi,(%esp)
801066a3:	e8 d8 b2 ff ff       	call   80101980 <iunlockput>
  ip->nlink--;
801066a8:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
801066ac:	89 1c 24             	mov    %ebx,(%esp)
801066af:	e8 7c af ff ff       	call   80101630 <iupdate>
  iunlockput(ip);
801066b4:	89 1c 24             	mov    %ebx,(%esp)
801066b7:	e8 c4 b2 ff ff       	call   80101980 <iunlockput>
  end_op();
801066bc:	e8 3f c6 ff ff       	call   80102d00 <end_op>
}
801066c1:	83 c4 5c             	add    $0x5c,%esp
  return 0;
801066c4:	31 c0                	xor    %eax,%eax
}
801066c6:	5b                   	pop    %ebx
801066c7:	5e                   	pop    %esi
801066c8:	5f                   	pop    %edi
801066c9:	5d                   	pop    %ebp
801066ca:	c3                   	ret    
801066cb:	90                   	nop
801066cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801066d0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801066d4:	76 83                	jbe    80106659 <sys_unlink+0xb9>
801066d6:	ba 20 00 00 00       	mov    $0x20,%edx
801066db:	eb 0f                	jmp    801066ec <sys_unlink+0x14c>
801066dd:	8d 76 00             	lea    0x0(%esi),%esi
801066e0:	83 c2 10             	add    $0x10,%edx
801066e3:	3b 53 58             	cmp    0x58(%ebx),%edx
801066e6:	0f 83 6d ff ff ff    	jae    80106659 <sys_unlink+0xb9>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801066ec:	b8 10 00 00 00       	mov    $0x10,%eax
801066f1:	89 54 24 08          	mov    %edx,0x8(%esp)
801066f5:	89 44 24 0c          	mov    %eax,0xc(%esp)
801066f9:	89 7c 24 04          	mov    %edi,0x4(%esp)
801066fd:	89 1c 24             	mov    %ebx,(%esp)
80106700:	89 55 b4             	mov    %edx,-0x4c(%ebp)
80106703:	e8 c8 b2 ff ff       	call   801019d0 <readi>
80106708:	8b 55 b4             	mov    -0x4c(%ebp),%edx
8010670b:	83 f8 10             	cmp    $0x10,%eax
8010670e:	75 41                	jne    80106751 <sys_unlink+0x1b1>
    if(de.inum != 0)
80106710:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80106715:	74 c9                	je     801066e0 <sys_unlink+0x140>
    iunlockput(ip);
80106717:	89 1c 24             	mov    %ebx,(%esp)
8010671a:	e8 61 b2 ff ff       	call   80101980 <iunlockput>
  iunlockput(dp);
8010671f:	89 34 24             	mov    %esi,(%esp)
80106722:	e8 59 b2 ff ff       	call   80101980 <iunlockput>
  end_op();
80106727:	e8 d4 c5 ff ff       	call   80102d00 <end_op>
}
8010672c:	83 c4 5c             	add    $0x5c,%esp
  return -1;
8010672f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106734:	5b                   	pop    %ebx
80106735:	5e                   	pop    %esi
80106736:	5f                   	pop    %edi
80106737:	5d                   	pop    %ebp
80106738:	c3                   	ret    
80106739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80106740:	66 ff 4e 56          	decw   0x56(%esi)
    iupdate(dp);
80106744:	89 34 24             	mov    %esi,(%esp)
80106747:	e8 e4 ae ff ff       	call   80101630 <iupdate>
8010674c:	e9 4f ff ff ff       	jmp    801066a0 <sys_unlink+0x100>
      panic("isdirempty: readi");
80106751:	c7 04 24 68 90 10 80 	movl   $0x80109068,(%esp)
80106758:	e8 13 9c ff ff       	call   80100370 <panic>
    panic("unlink: nlink < 1");
8010675d:	c7 04 24 56 90 10 80 	movl   $0x80109056,(%esp)
80106764:	e8 07 9c ff ff       	call   80100370 <panic>
    panic("unlink: writei");
80106769:	c7 04 24 7a 90 10 80 	movl   $0x8010907a,(%esp)
80106770:	e8 fb 9b ff ff       	call   80100370 <panic>
80106775:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106780 <sys_open>:

int
sys_open(void)
{
80106780:	55                   	push   %ebp
80106781:	89 e5                	mov    %esp,%ebp
80106783:	57                   	push   %edi
80106784:	56                   	push   %esi
80106785:	53                   	push   %ebx
80106786:	83 ec 2c             	sub    $0x2c,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106789:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010678c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106790:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106797:	e8 44 f8 ff ff       	call   80105fe0 <argstr>
8010679c:	85 c0                	test   %eax,%eax
8010679e:	0f 88 e9 00 00 00    	js     8010688d <sys_open+0x10d>
801067a4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801067a7:	89 44 24 04          	mov    %eax,0x4(%esp)
801067ab:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801067b2:	e8 79 f7 ff ff       	call   80105f30 <argint>
801067b7:	85 c0                	test   %eax,%eax
801067b9:	0f 88 ce 00 00 00    	js     8010688d <sys_open+0x10d>
    return -1;

  begin_op();
801067bf:	e8 cc c4 ff ff       	call   80102c90 <begin_op>

  if(omode & O_CREATE){
801067c4:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801067c8:	0f 85 9a 00 00 00    	jne    80106868 <sys_open+0xe8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801067ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
801067d1:	89 04 24             	mov    %eax,(%esp)
801067d4:	e8 f7 b7 ff ff       	call   80101fd0 <namei>
801067d9:	85 c0                	test   %eax,%eax
801067db:	89 c6                	mov    %eax,%esi
801067dd:	0f 84 a5 00 00 00    	je     80106888 <sys_open+0x108>
      end_op();
      return -1;
    }
    ilock(ip);
801067e3:	89 04 24             	mov    %eax,(%esp)
801067e6:	e8 05 af ff ff       	call   801016f0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801067eb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801067f0:	0f 84 a2 00 00 00    	je     80106898 <sys_open+0x118>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801067f6:	e8 75 a5 ff ff       	call   80100d70 <filealloc>
801067fb:	85 c0                	test   %eax,%eax
801067fd:	89 c7                	mov    %eax,%edi
801067ff:	0f 84 9e 00 00 00    	je     801068a3 <sys_open+0x123>
  struct proc *curproc = myproc();
80106805:	e8 a6 d2 ff ff       	call   80103ab0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010680a:	31 db                	xor    %ebx,%ebx
8010680c:	eb 0c                	jmp    8010681a <sys_open+0x9a>
8010680e:	66 90                	xchg   %ax,%ax
80106810:	43                   	inc    %ebx
80106811:	83 fb 10             	cmp    $0x10,%ebx
80106814:	0f 84 96 00 00 00    	je     801068b0 <sys_open+0x130>
    if(curproc->ofile[fd] == 0){
8010681a:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
8010681e:	85 d2                	test   %edx,%edx
80106820:	75 ee                	jne    80106810 <sys_open+0x90>
      curproc->ofile[fd] = f;
80106822:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80106826:	89 34 24             	mov    %esi,(%esp)
80106829:	e8 a2 af ff ff       	call   801017d0 <iunlock>
  end_op();
8010682e:	e8 cd c4 ff ff       	call   80102d00 <end_op>

  f->type = FD_INODE;
80106833:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80106839:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->ip = ip;
8010683c:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
8010683f:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80106846:	89 d0                	mov    %edx,%eax
80106848:	f7 d0                	not    %eax
8010684a:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010684d:	f6 c2 03             	test   $0x3,%dl
  f->readable = !(omode & O_WRONLY);
80106850:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106853:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80106857:	83 c4 2c             	add    $0x2c,%esp
8010685a:	89 d8                	mov    %ebx,%eax
8010685c:	5b                   	pop    %ebx
8010685d:	5e                   	pop    %esi
8010685e:	5f                   	pop    %edi
8010685f:	5d                   	pop    %ebp
80106860:	c3                   	ret    
80106861:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80106868:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010686b:	31 c9                	xor    %ecx,%ecx
8010686d:	ba 02 00 00 00       	mov    $0x2,%edx
80106872:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106879:	e8 12 f8 ff ff       	call   80106090 <create>
    if(ip == 0){
8010687e:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80106880:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80106882:	0f 85 6e ff ff ff    	jne    801067f6 <sys_open+0x76>
    end_op();
80106888:	e8 73 c4 ff ff       	call   80102d00 <end_op>
    return -1;
8010688d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106892:	eb c3                	jmp    80106857 <sys_open+0xd7>
80106894:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80106898:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010689b:	85 c9                	test   %ecx,%ecx
8010689d:	0f 84 53 ff ff ff    	je     801067f6 <sys_open+0x76>
    iunlockput(ip);
801068a3:	89 34 24             	mov    %esi,(%esp)
801068a6:	e8 d5 b0 ff ff       	call   80101980 <iunlockput>
801068ab:	eb db                	jmp    80106888 <sys_open+0x108>
801068ad:	8d 76 00             	lea    0x0(%esi),%esi
      fileclose(f);
801068b0:	89 3c 24             	mov    %edi,(%esp)
801068b3:	e8 78 a5 ff ff       	call   80100e30 <fileclose>
801068b8:	eb e9                	jmp    801068a3 <sys_open+0x123>
801068ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801068c0 <sys_mkdir>:

int
sys_mkdir(void)
{
801068c0:	55                   	push   %ebp
801068c1:	89 e5                	mov    %esp,%ebp
801068c3:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
801068c6:	e8 c5 c3 ff ff       	call   80102c90 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801068cb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801068ce:	89 44 24 04          	mov    %eax,0x4(%esp)
801068d2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801068d9:	e8 02 f7 ff ff       	call   80105fe0 <argstr>
801068de:	85 c0                	test   %eax,%eax
801068e0:	78 2e                	js     80106910 <sys_mkdir+0x50>
801068e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801068e5:	31 c9                	xor    %ecx,%ecx
801068e7:	ba 01 00 00 00       	mov    $0x1,%edx
801068ec:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801068f3:	e8 98 f7 ff ff       	call   80106090 <create>
801068f8:	85 c0                	test   %eax,%eax
801068fa:	74 14                	je     80106910 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801068fc:	89 04 24             	mov    %eax,(%esp)
801068ff:	e8 7c b0 ff ff       	call   80101980 <iunlockput>
  end_op();
80106904:	e8 f7 c3 ff ff       	call   80102d00 <end_op>
  return 0;
80106909:	31 c0                	xor    %eax,%eax
}
8010690b:	c9                   	leave  
8010690c:	c3                   	ret    
8010690d:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
80106910:	e8 eb c3 ff ff       	call   80102d00 <end_op>
    return -1;
80106915:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010691a:	c9                   	leave  
8010691b:	c3                   	ret    
8010691c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106920 <sys_mknod>:

int
sys_mknod(void)
{
80106920:	55                   	push   %ebp
80106921:	89 e5                	mov    %esp,%ebp
80106923:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80106926:	e8 65 c3 ff ff       	call   80102c90 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010692b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010692e:	89 44 24 04          	mov    %eax,0x4(%esp)
80106932:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106939:	e8 a2 f6 ff ff       	call   80105fe0 <argstr>
8010693e:	85 c0                	test   %eax,%eax
80106940:	78 5e                	js     801069a0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80106942:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106945:	89 44 24 04          	mov    %eax,0x4(%esp)
80106949:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106950:	e8 db f5 ff ff       	call   80105f30 <argint>
  if((argstr(0, &path)) < 0 ||
80106955:	85 c0                	test   %eax,%eax
80106957:	78 47                	js     801069a0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80106959:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010695c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106960:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106967:	e8 c4 f5 ff ff       	call   80105f30 <argint>
     argint(1, &major) < 0 ||
8010696c:	85 c0                	test   %eax,%eax
8010696e:	78 30                	js     801069a0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80106970:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
80106974:	ba 03 00 00 00       	mov    $0x3,%edx
     (ip = create(path, T_DEV, major, minor)) == 0){
80106979:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
8010697d:	89 04 24             	mov    %eax,(%esp)
     argint(2, &minor) < 0 ||
80106980:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106983:	e8 08 f7 ff ff       	call   80106090 <create>
80106988:	85 c0                	test   %eax,%eax
8010698a:	74 14                	je     801069a0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010698c:	89 04 24             	mov    %eax,(%esp)
8010698f:	e8 ec af ff ff       	call   80101980 <iunlockput>
  end_op();
80106994:	e8 67 c3 ff ff       	call   80102d00 <end_op>
  return 0;
80106999:	31 c0                	xor    %eax,%eax
}
8010699b:	c9                   	leave  
8010699c:	c3                   	ret    
8010699d:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
801069a0:	e8 5b c3 ff ff       	call   80102d00 <end_op>
    return -1;
801069a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801069aa:	c9                   	leave  
801069ab:	c3                   	ret    
801069ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801069b0 <sys_chdir>:

int
sys_chdir(void)
{
801069b0:	55                   	push   %ebp
801069b1:	89 e5                	mov    %esp,%ebp
801069b3:	56                   	push   %esi
801069b4:	53                   	push   %ebx
801069b5:	83 ec 20             	sub    $0x20,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801069b8:	e8 f3 d0 ff ff       	call   80103ab0 <myproc>
801069bd:	89 c6                	mov    %eax,%esi
  
  begin_op();
801069bf:	e8 cc c2 ff ff       	call   80102c90 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801069c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801069c7:	89 44 24 04          	mov    %eax,0x4(%esp)
801069cb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801069d2:	e8 09 f6 ff ff       	call   80105fe0 <argstr>
801069d7:	85 c0                	test   %eax,%eax
801069d9:	78 4a                	js     80106a25 <sys_chdir+0x75>
801069db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069de:	89 04 24             	mov    %eax,(%esp)
801069e1:	e8 ea b5 ff ff       	call   80101fd0 <namei>
801069e6:	85 c0                	test   %eax,%eax
801069e8:	89 c3                	mov    %eax,%ebx
801069ea:	74 39                	je     80106a25 <sys_chdir+0x75>
    end_op();
    return -1;
  }
  ilock(ip);
801069ec:	89 04 24             	mov    %eax,(%esp)
801069ef:	e8 fc ac ff ff       	call   801016f0 <ilock>
  if(ip->type != T_DIR){
801069f4:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
    iunlockput(ip);
801069f9:	89 1c 24             	mov    %ebx,(%esp)
  if(ip->type != T_DIR){
801069fc:	75 22                	jne    80106a20 <sys_chdir+0x70>
    end_op();
    return -1;
  }
  iunlock(ip);
801069fe:	e8 cd ad ff ff       	call   801017d0 <iunlock>
  iput(curproc->cwd);
80106a03:	8b 46 68             	mov    0x68(%esi),%eax
80106a06:	89 04 24             	mov    %eax,(%esp)
80106a09:	e8 12 ae ff ff       	call   80101820 <iput>
  end_op();
80106a0e:	e8 ed c2 ff ff       	call   80102d00 <end_op>
  curproc->cwd = ip;
  return 0;
80106a13:	31 c0                	xor    %eax,%eax
  curproc->cwd = ip;
80106a15:	89 5e 68             	mov    %ebx,0x68(%esi)
}
80106a18:	83 c4 20             	add    $0x20,%esp
80106a1b:	5b                   	pop    %ebx
80106a1c:	5e                   	pop    %esi
80106a1d:	5d                   	pop    %ebp
80106a1e:	c3                   	ret    
80106a1f:	90                   	nop
    iunlockput(ip);
80106a20:	e8 5b af ff ff       	call   80101980 <iunlockput>
    end_op();
80106a25:	e8 d6 c2 ff ff       	call   80102d00 <end_op>
    return -1;
80106a2a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a2f:	eb e7                	jmp    80106a18 <sys_chdir+0x68>
80106a31:	eb 0d                	jmp    80106a40 <sys_exec>
80106a33:	90                   	nop
80106a34:	90                   	nop
80106a35:	90                   	nop
80106a36:	90                   	nop
80106a37:	90                   	nop
80106a38:	90                   	nop
80106a39:	90                   	nop
80106a3a:	90                   	nop
80106a3b:	90                   	nop
80106a3c:	90                   	nop
80106a3d:	90                   	nop
80106a3e:	90                   	nop
80106a3f:	90                   	nop

80106a40 <sys_exec>:

int
sys_exec(void)
{
80106a40:	55                   	push   %ebp
80106a41:	89 e5                	mov    %esp,%ebp
80106a43:	57                   	push   %edi
80106a44:	56                   	push   %esi
80106a45:	53                   	push   %ebx
80106a46:	81 ec ac 00 00 00    	sub    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106a4c:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80106a52:	89 44 24 04          	mov    %eax,0x4(%esp)
80106a56:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106a5d:	e8 7e f5 ff ff       	call   80105fe0 <argstr>
80106a62:	85 c0                	test   %eax,%eax
80106a64:	0f 88 8e 00 00 00    	js     80106af8 <sys_exec+0xb8>
80106a6a:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80106a70:	89 44 24 04          	mov    %eax,0x4(%esp)
80106a74:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106a7b:	e8 b0 f4 ff ff       	call   80105f30 <argint>
80106a80:	85 c0                	test   %eax,%eax
80106a82:	78 74                	js     80106af8 <sys_exec+0xb8>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80106a84:	ba 80 00 00 00       	mov    $0x80,%edx
80106a89:	31 c9                	xor    %ecx,%ecx
80106a8b:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
80106a91:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80106a93:	89 54 24 08          	mov    %edx,0x8(%esp)
80106a97:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80106a9d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80106aa1:	89 04 24             	mov    %eax,(%esp)
80106aa4:	e8 97 f1 ff ff       	call   80105c40 <memset>
80106aa9:	eb 2e                	jmp    80106ad9 <sys_exec+0x99>
80106aab:	90                   	nop
80106aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80106ab0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80106ab6:	85 c0                	test   %eax,%eax
80106ab8:	74 56                	je     80106b10 <sys_exec+0xd0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106aba:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80106ac0:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80106ac3:	89 54 24 04          	mov    %edx,0x4(%esp)
80106ac7:	89 04 24             	mov    %eax,(%esp)
80106aca:	e8 01 f4 ff ff       	call   80105ed0 <fetchstr>
80106acf:	85 c0                	test   %eax,%eax
80106ad1:	78 25                	js     80106af8 <sys_exec+0xb8>
  for(i=0;; i++){
80106ad3:	43                   	inc    %ebx
    if(i >= NELEM(argv))
80106ad4:	83 fb 20             	cmp    $0x20,%ebx
80106ad7:	74 1f                	je     80106af8 <sys_exec+0xb8>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106ad9:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106adf:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80106ae6:	89 7c 24 04          	mov    %edi,0x4(%esp)
80106aea:	01 f0                	add    %esi,%eax
80106aec:	89 04 24             	mov    %eax,(%esp)
80106aef:	e8 9c f3 ff ff       	call   80105e90 <fetchint>
80106af4:	85 c0                	test   %eax,%eax
80106af6:	79 b8                	jns    80106ab0 <sys_exec+0x70>
      return -1;
  }
  return exec(path, argv);
}
80106af8:	81 c4 ac 00 00 00    	add    $0xac,%esp
    return -1;
80106afe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106b03:	5b                   	pop    %ebx
80106b04:	5e                   	pop    %esi
80106b05:	5f                   	pop    %edi
80106b06:	5d                   	pop    %ebp
80106b07:	c3                   	ret    
80106b08:	90                   	nop
80106b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80106b10:	31 c0                	xor    %eax,%eax
80106b12:	89 84 9d 68 ff ff ff 	mov    %eax,-0x98(%ebp,%ebx,4)
  return exec(path, argv);
80106b19:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106b1f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b23:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
80106b29:	89 04 24             	mov    %eax,(%esp)
80106b2c:	e8 9f 9e ff ff       	call   801009d0 <exec>
}
80106b31:	81 c4 ac 00 00 00    	add    $0xac,%esp
80106b37:	5b                   	pop    %ebx
80106b38:	5e                   	pop    %esi
80106b39:	5f                   	pop    %edi
80106b3a:	5d                   	pop    %ebp
80106b3b:	c3                   	ret    
80106b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106b40 <sys_pipe>:

int
sys_pipe(void)
{
80106b40:	55                   	push   %ebp
80106b41:	89 e5                	mov    %esp,%ebp
80106b43:	57                   	push   %edi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106b44:	bf 08 00 00 00       	mov    $0x8,%edi
{
80106b49:	56                   	push   %esi
80106b4a:	53                   	push   %ebx
80106b4b:	83 ec 2c             	sub    $0x2c,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106b4e:	8d 45 dc             	lea    -0x24(%ebp),%eax
80106b51:	89 7c 24 08          	mov    %edi,0x8(%esp)
80106b55:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b59:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106b60:	e8 1b f4 ff ff       	call   80105f80 <argptr>
80106b65:	85 c0                	test   %eax,%eax
80106b67:	0f 88 a9 00 00 00    	js     80106c16 <sys_pipe+0xd6>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80106b6d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106b70:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b74:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106b77:	89 04 24             	mov    %eax,(%esp)
80106b7a:	e8 41 c8 ff ff       	call   801033c0 <pipealloc>
80106b7f:	85 c0                	test   %eax,%eax
80106b81:	0f 88 8f 00 00 00    	js     80106c16 <sys_pipe+0xd6>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106b87:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80106b8a:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80106b8c:	e8 1f cf ff ff       	call   80103ab0 <myproc>
80106b91:	eb 0b                	jmp    80106b9e <sys_pipe+0x5e>
80106b93:	90                   	nop
80106b94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106b98:	43                   	inc    %ebx
80106b99:	83 fb 10             	cmp    $0x10,%ebx
80106b9c:	74 62                	je     80106c00 <sys_pipe+0xc0>
    if(curproc->ofile[fd] == 0){
80106b9e:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80106ba2:	85 f6                	test   %esi,%esi
80106ba4:	75 f2                	jne    80106b98 <sys_pipe+0x58>
      curproc->ofile[fd] = f;
80106ba6:	8d 73 08             	lea    0x8(%ebx),%esi
80106ba9:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106bad:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80106bb0:	e8 fb ce ff ff       	call   80103ab0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106bb5:	31 d2                	xor    %edx,%edx
80106bb7:	eb 0d                	jmp    80106bc6 <sys_pipe+0x86>
80106bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106bc0:	42                   	inc    %edx
80106bc1:	83 fa 10             	cmp    $0x10,%edx
80106bc4:	74 2a                	je     80106bf0 <sys_pipe+0xb0>
    if(curproc->ofile[fd] == 0){
80106bc6:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80106bca:	85 c9                	test   %ecx,%ecx
80106bcc:	75 f2                	jne    80106bc0 <sys_pipe+0x80>
      curproc->ofile[fd] = f;
80106bce:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80106bd2:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106bd5:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106bd7:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106bda:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80106bdd:	31 c0                	xor    %eax,%eax
}
80106bdf:	83 c4 2c             	add    $0x2c,%esp
80106be2:	5b                   	pop    %ebx
80106be3:	5e                   	pop    %esi
80106be4:	5f                   	pop    %edi
80106be5:	5d                   	pop    %ebp
80106be6:	c3                   	ret    
80106be7:	89 f6                	mov    %esi,%esi
80106be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      myproc()->ofile[fd0] = 0;
80106bf0:	e8 bb ce ff ff       	call   80103ab0 <myproc>
80106bf5:	31 d2                	xor    %edx,%edx
80106bf7:	89 54 b0 08          	mov    %edx,0x8(%eax,%esi,4)
80106bfb:	90                   	nop
80106bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fileclose(rf);
80106c00:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106c03:	89 04 24             	mov    %eax,(%esp)
80106c06:	e8 25 a2 ff ff       	call   80100e30 <fileclose>
    fileclose(wf);
80106c0b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106c0e:	89 04 24             	mov    %eax,(%esp)
80106c11:	e8 1a a2 ff ff       	call   80100e30 <fileclose>
    return -1;
80106c16:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106c1b:	eb c2                	jmp    80106bdf <sys_pipe+0x9f>
80106c1d:	66 90                	xchg   %ax,%ax
80106c1f:	90                   	nop

80106c20 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106c20:	55                   	push   %ebp
80106c21:	89 e5                	mov    %esp,%ebp
  return fork();
}
80106c23:	5d                   	pop    %ebp
  return fork();
80106c24:	e9 97 d1 ff ff       	jmp    80103dc0 <fork>
80106c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106c30 <sys_exit>:

int
sys_exit(void)
{
80106c30:	55                   	push   %ebp
80106c31:	89 e5                	mov    %esp,%ebp
80106c33:	83 ec 28             	sub    $0x28,%esp
    int stat;

    if(argint(0, &stat) < 0)
80106c36:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106c39:	89 44 24 04          	mov    %eax,0x4(%esp)
80106c3d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106c44:	e8 e7 f2 ff ff       	call   80105f30 <argint>
80106c49:	85 c0                	test   %eax,%eax
80106c4b:	78 13                	js     80106c60 <sys_exit+0x30>
        return -1;
    exit(stat);
80106c4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106c50:	89 04 24             	mov    %eax,(%esp)
80106c53:	e8 f8 d5 ff ff       	call   80104250 <exit>
    return 0;
80106c58:	31 c0                	xor    %eax,%eax
}
80106c5a:	c9                   	leave  
80106c5b:	c3                   	ret    
80106c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
80106c60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106c65:	c9                   	leave  
80106c66:	c3                   	ret    
80106c67:	89 f6                	mov    %esi,%esi
80106c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c70 <sys_wait>:

int
sys_wait(void)
{
80106c70:	55                   	push   %ebp
    int *status;

    if(argptr(0, (void*)&status, sizeof(*status)) < 0)
80106c71:	b8 04 00 00 00       	mov    $0x4,%eax
{
80106c76:	89 e5                	mov    %esp,%ebp
80106c78:	83 ec 28             	sub    $0x28,%esp
    if(argptr(0, (void*)&status, sizeof(*status)) < 0)
80106c7b:	89 44 24 08          	mov    %eax,0x8(%esp)
80106c7f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106c82:	89 44 24 04          	mov    %eax,0x4(%esp)
80106c86:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106c8d:	e8 ee f2 ff ff       	call   80105f80 <argptr>
80106c92:	85 c0                	test   %eax,%eax
80106c94:	78 12                	js     80106ca8 <sys_wait+0x38>
        return -1;
    return wait(status);
80106c96:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106c99:	89 04 24             	mov    %eax,(%esp)
80106c9c:	e8 6f d8 ff ff       	call   80104510 <wait>
}
80106ca1:	c9                   	leave  
80106ca2:	c3                   	ret    
80106ca3:	90                   	nop
80106ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
80106ca8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106cad:	c9                   	leave  
80106cae:	c3                   	ret    
80106caf:	90                   	nop

80106cb0 <sys_kill>:

int
sys_kill(void)
{
80106cb0:	55                   	push   %ebp
80106cb1:	89 e5                	mov    %esp,%ebp
80106cb3:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106cb6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106cb9:	89 44 24 04          	mov    %eax,0x4(%esp)
80106cbd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106cc4:	e8 67 f2 ff ff       	call   80105f30 <argint>
80106cc9:	85 c0                	test   %eax,%eax
80106ccb:	78 13                	js     80106ce0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80106ccd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106cd0:	89 04 24             	mov    %eax,(%esp)
80106cd3:	e8 78 d9 ff ff       	call   80104650 <kill>
}
80106cd8:	c9                   	leave  
80106cd9:	c3                   	ret    
80106cda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106ce0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106ce5:	c9                   	leave  
80106ce6:	c3                   	ret    
80106ce7:	89 f6                	mov    %esi,%esi
80106ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106cf0 <sys_getpid>:

int
sys_getpid(void)
{
80106cf0:	55                   	push   %ebp
80106cf1:	89 e5                	mov    %esp,%ebp
80106cf3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106cf6:	e8 b5 cd ff ff       	call   80103ab0 <myproc>
80106cfb:	8b 40 10             	mov    0x10(%eax),%eax
}
80106cfe:	c9                   	leave  
80106cff:	c3                   	ret    

80106d00 <sys_sbrk>:

int
sys_sbrk(void)
{
80106d00:	55                   	push   %ebp
80106d01:	89 e5                	mov    %esp,%ebp
80106d03:	53                   	push   %ebx
80106d04:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106d07:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106d0a:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d0e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106d15:	e8 16 f2 ff ff       	call   80105f30 <argint>
80106d1a:	85 c0                	test   %eax,%eax
80106d1c:	78 22                	js     80106d40 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106d1e:	e8 8d cd ff ff       	call   80103ab0 <myproc>
80106d23:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106d25:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d28:	89 04 24             	mov    %eax,(%esp)
80106d2b:	e8 10 d0 ff ff       	call   80103d40 <growproc>
80106d30:	85 c0                	test   %eax,%eax
80106d32:	78 0c                	js     80106d40 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106d34:	83 c4 24             	add    $0x24,%esp
80106d37:	89 d8                	mov    %ebx,%eax
80106d39:	5b                   	pop    %ebx
80106d3a:	5d                   	pop    %ebp
80106d3b:	c3                   	ret    
80106d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106d40:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106d45:	eb ed                	jmp    80106d34 <sys_sbrk+0x34>
80106d47:	89 f6                	mov    %esi,%esi
80106d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d50 <sys_sleep>:

int
sys_sleep(void)
{
80106d50:	55                   	push   %ebp
80106d51:	89 e5                	mov    %esp,%ebp
80106d53:	53                   	push   %ebx
80106d54:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106d57:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106d5a:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d5e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106d65:	e8 c6 f1 ff ff       	call   80105f30 <argint>
80106d6a:	85 c0                	test   %eax,%eax
80106d6c:	78 7e                	js     80106dec <sys_sleep+0x9c>
    return -1;
  acquire(&tickslock);
80106d6e:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80106d75:	e8 d6 ed ff ff       	call   80105b50 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106d7a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  ticks0 = ticks;
80106d7d:	8b 1d 00 80 11 80    	mov    0x80118000,%ebx
  while(ticks - ticks0 < n){
80106d83:	85 c9                	test   %ecx,%ecx
80106d85:	75 2a                	jne    80106db1 <sys_sleep+0x61>
80106d87:	eb 4f                	jmp    80106dd8 <sys_sleep+0x88>
80106d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106d90:	b8 c0 77 11 80       	mov    $0x801177c0,%eax
80106d95:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d99:	c7 04 24 00 80 11 80 	movl   $0x80118000,(%esp)
80106da0:	e8 5b d6 ff ff       	call   80104400 <sleep>
  while(ticks - ticks0 < n){
80106da5:	a1 00 80 11 80       	mov    0x80118000,%eax
80106daa:	29 d8                	sub    %ebx,%eax
80106dac:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80106daf:	73 27                	jae    80106dd8 <sys_sleep+0x88>
    if(myproc()->killed){
80106db1:	e8 fa cc ff ff       	call   80103ab0 <myproc>
80106db6:	8b 50 24             	mov    0x24(%eax),%edx
80106db9:	85 d2                	test   %edx,%edx
80106dbb:	74 d3                	je     80106d90 <sys_sleep+0x40>
      release(&tickslock);
80106dbd:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80106dc4:	e8 27 ee ff ff       	call   80105bf0 <release>
  }
  release(&tickslock);
  return 0;
}
80106dc9:	83 c4 24             	add    $0x24,%esp
      return -1;
80106dcc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106dd1:	5b                   	pop    %ebx
80106dd2:	5d                   	pop    %ebp
80106dd3:	c3                   	ret    
80106dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&tickslock);
80106dd8:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80106ddf:	e8 0c ee ff ff       	call   80105bf0 <release>
  return 0;
80106de4:	31 c0                	xor    %eax,%eax
}
80106de6:	83 c4 24             	add    $0x24,%esp
80106de9:	5b                   	pop    %ebx
80106dea:	5d                   	pop    %ebp
80106deb:	c3                   	ret    
    return -1;
80106dec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106df1:	eb f3                	jmp    80106de6 <sys_sleep+0x96>
80106df3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e00 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106e00:	55                   	push   %ebp
80106e01:	89 e5                	mov    %esp,%ebp
80106e03:	53                   	push   %ebx
80106e04:	83 ec 14             	sub    $0x14,%esp
  uint xticks;

  acquire(&tickslock);
80106e07:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80106e0e:	e8 3d ed ff ff       	call   80105b50 <acquire>
  xticks = ticks;
80106e13:	8b 1d 00 80 11 80    	mov    0x80118000,%ebx
  release(&tickslock);
80106e19:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80106e20:	e8 cb ed ff ff       	call   80105bf0 <release>
  return xticks;
}
80106e25:	83 c4 14             	add    $0x14,%esp
80106e28:	89 d8                	mov    %ebx,%eax
80106e2a:	5b                   	pop    %ebx
80106e2b:	5d                   	pop    %ebp
80106e2c:	c3                   	ret    
80106e2d:	8d 76 00             	lea    0x0(%esi),%esi

80106e30 <sys_detach>:

int
sys_detach(void){
80106e30:	55                   	push   %ebp
80106e31:	89 e5                	mov    %esp,%ebp
80106e33:	83 ec 28             	sub    $0x28,%esp
    int pid;
  if(argint(0, &pid) < 0)
80106e36:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106e39:	89 44 24 04          	mov    %eax,0x4(%esp)
80106e3d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106e44:	e8 e7 f0 ff ff       	call   80105f30 <argint>
80106e49:	85 c0                	test   %eax,%eax
80106e4b:	78 13                	js     80106e60 <sys_detach+0x30>
    return -1;
  return detach(pid);
80106e4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e50:	89 04 24             	mov    %eax,(%esp)
80106e53:	e8 78 d9 ff ff       	call   801047d0 <detach>
}
80106e58:	c9                   	leave  
80106e59:	c3                   	ret    
80106e5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106e60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106e65:	c9                   	leave  
80106e66:	c3                   	ret    
80106e67:	89 f6                	mov    %esi,%esi
80106e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e70 <sys_policy>:

int
sys_policy(void){
80106e70:	55                   	push   %ebp
80106e71:	89 e5                	mov    %esp,%ebp
80106e73:	83 ec 28             	sub    $0x28,%esp
    int pid;
    if(argint(0, &pid) < 0)
80106e76:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106e79:	89 44 24 04          	mov    %eax,0x4(%esp)
80106e7d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106e84:	e8 a7 f0 ff ff       	call   80105f30 <argint>
80106e89:	85 c0                	test   %eax,%eax
80106e8b:	78 13                	js     80106ea0 <sys_policy+0x30>
        return -1;
    policy(pid);
80106e8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e90:	89 04 24             	mov    %eax,(%esp)
80106e93:	e8 e8 da ff ff       	call   80104980 <policy>
    return 0;
80106e98:	31 c0                	xor    %eax,%eax
}
80106e9a:	c9                   	leave  
80106e9b:	c3                   	ret    
80106e9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
80106ea0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106ea5:	c9                   	leave  
80106ea6:	c3                   	ret    
80106ea7:	89 f6                	mov    %esi,%esi
80106ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106eb0 <sys_priority>:

//TODO -need to understand how to call this sys_call
int
sys_priority(void){
80106eb0:	55                   	push   %ebp
80106eb1:	89 e5                	mov    %esp,%ebp
80106eb3:	83 ec 28             	sub    $0x28,%esp
    int pid;
    if(argint(0, &pid) < 0)
80106eb6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106eb9:	89 44 24 04          	mov    %eax,0x4(%esp)
80106ebd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106ec4:	e8 67 f0 ff ff       	call   80105f30 <argint>
80106ec9:	85 c0                	test   %eax,%eax
80106ecb:	78 13                	js     80106ee0 <sys_priority+0x30>
        return -1;
    priority(pid);
80106ecd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ed0:	89 04 24             	mov    %eax,(%esp)
80106ed3:	e8 88 d9 ff ff       	call   80104860 <priority>
    return 0;
80106ed8:	31 c0                	xor    %eax,%eax
}
80106eda:	c9                   	leave  
80106edb:	c3                   	ret    
80106edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
80106ee0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106ee5:	c9                   	leave  
80106ee6:	c3                   	ret    
80106ee7:	89 f6                	mov    %esi,%esi
80106ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ef0 <sys_wait_stat>:


int
sys_wait_stat(void)
{
80106ef0:	55                   	push   %ebp
    performance->ttime = 0;
    performance->stime = 0;
    performance->retime = 0;
    performance->rutime = 0;*/

    if(argptr(0, (void*)&status, sizeof(*status)) < 0)
80106ef1:	ba 04 00 00 00       	mov    $0x4,%edx
{
80106ef6:	89 e5                	mov    %esp,%ebp
80106ef8:	83 ec 28             	sub    $0x28,%esp
    if(argptr(0, (void*)&status, sizeof(*status)) < 0)
80106efb:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106efe:	89 54 24 08          	mov    %edx,0x8(%esp)
80106f02:	89 44 24 04          	mov    %eax,0x4(%esp)
80106f06:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106f0d:	e8 6e f0 ff ff       	call   80105f80 <argptr>
80106f12:	85 c0                	test   %eax,%eax
80106f14:	78 1a                	js     80106f30 <sys_wait_stat+0x40>
        return -1;
    return wait_stat(status , performance);
80106f16:	31 c0                	xor    %eax,%eax
80106f18:	89 44 24 04          	mov    %eax,0x4(%esp)
80106f1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f1f:	89 04 24             	mov    %eax,(%esp)
80106f22:	e8 59 db ff ff       	call   80104a80 <wait_stat>
}
80106f27:	c9                   	leave  
80106f28:	c3                   	ret    
80106f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return -1;
80106f30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106f35:	c9                   	leave  
80106f36:	c3                   	ret    

80106f37 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106f37:	1e                   	push   %ds
  pushl %es
80106f38:	06                   	push   %es
  pushl %fs
80106f39:	0f a0                	push   %fs
  pushl %gs
80106f3b:	0f a8                	push   %gs
  pushal
80106f3d:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106f3e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106f42:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106f44:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106f46:	54                   	push   %esp
  call trap
80106f47:	e8 c4 00 00 00       	call   80107010 <trap>
  addl $4, %esp
80106f4c:	83 c4 04             	add    $0x4,%esp

80106f4f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106f4f:	61                   	popa   
  popl %gs
80106f50:	0f a9                	pop    %gs
  popl %fs
80106f52:	0f a1                	pop    %fs
  popl %es
80106f54:	07                   	pop    %es
  popl %ds
80106f55:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106f56:	83 c4 08             	add    $0x8,%esp
  iret
80106f59:	cf                   	iret   
80106f5a:	66 90                	xchg   %ax,%ax
80106f5c:	66 90                	xchg   %ax,%ax
80106f5e:	66 90                	xchg   %ax,%ax

80106f60 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106f60:	55                   	push   %ebp
80106f61:	89 e5                	mov    %esp,%ebp
80106f63:	83 ec 18             	sub    $0x18,%esp
  int i;
  pinit();
80106f66:	e8 85 ca ff ff       	call   801039f0 <pinit>
  for(i = 0; i < 256; i++)
80106f6b:	31 c0                	xor    %eax,%eax
80106f6d:	8d 76 00             	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106f70:	8b 14 85 0c c0 10 80 	mov    -0x7fef3ff4(,%eax,4),%edx
80106f77:	b9 08 00 00 8e       	mov    $0x8e000008,%ecx
80106f7c:	89 0c c5 02 78 11 80 	mov    %ecx,-0x7fee87fe(,%eax,8)
80106f83:	66 89 14 c5 00 78 11 	mov    %dx,-0x7fee8800(,%eax,8)
80106f8a:	80 
80106f8b:	c1 ea 10             	shr    $0x10,%edx
80106f8e:	66 89 14 c5 06 78 11 	mov    %dx,-0x7fee87fa(,%eax,8)
80106f95:	80 
  for(i = 0; i < 256; i++)
80106f96:	40                   	inc    %eax
80106f97:	3d 00 01 00 00       	cmp    $0x100,%eax
80106f9c:	75 d2                	jne    80106f70 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106f9e:	a1 0c c1 10 80       	mov    0x8010c10c,%eax

  initlock(&tickslock, "time");
80106fa3:	b9 89 90 10 80       	mov    $0x80109089,%ecx
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106fa8:	ba 08 00 00 ef       	mov    $0xef000008,%edx
  initlock(&tickslock, "time");
80106fad:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80106fb1:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106fb8:	89 15 02 7a 11 80    	mov    %edx,0x80117a02
80106fbe:	66 a3 00 7a 11 80    	mov    %ax,0x80117a00
80106fc4:	c1 e8 10             	shr    $0x10,%eax
80106fc7:	66 a3 06 7a 11 80    	mov    %ax,0x80117a06
  initlock(&tickslock, "time");
80106fcd:	e8 2e ea ff ff       	call   80105a00 <initlock>
}
80106fd2:	c9                   	leave  
80106fd3:	c3                   	ret    
80106fd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106fda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106fe0 <idtinit>:

void
idtinit(void)
{
80106fe0:	55                   	push   %ebp
  pd[1] = (uint)p;
80106fe1:	b8 00 78 11 80       	mov    $0x80117800,%eax
80106fe6:	89 e5                	mov    %esp,%ebp
80106fe8:	0f b7 d0             	movzwl %ax,%edx
  pd[2] = (uint)p >> 16;
80106feb:	c1 e8 10             	shr    $0x10,%eax
80106fee:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
80106ff1:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
80106ff7:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106ffb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80106fff:	8d 45 fa             	lea    -0x6(%ebp),%eax
80107002:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80107005:	c9                   	leave  
80107006:	c3                   	ret    
80107007:	89 f6                	mov    %esi,%esi
80107009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107010 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80107010:	55                   	push   %ebp
80107011:	89 e5                	mov    %esp,%ebp
80107013:	83 ec 48             	sub    $0x48,%esp
80107016:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80107019:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010701c:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010701f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(tf->trapno == T_SYSCALL){
80107022:	8b 43 30             	mov    0x30(%ebx),%eax
80107025:	83 f8 40             	cmp    $0x40,%eax
80107028:	0f 84 02 01 00 00    	je     80107130 <trap+0x120>
    if(myproc()->killed)
      exit(0);
    return;
  }

  switch(tf->trapno){
8010702e:	83 e8 20             	sub    $0x20,%eax
80107031:	83 f8 1f             	cmp    $0x1f,%eax
80107034:	77 0a                	ja     80107040 <trap+0x30>
80107036:	ff 24 85 30 91 10 80 	jmp    *-0x7fef6ed0(,%eax,4)
8010703d:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80107040:	e8 6b ca ff ff       	call   80103ab0 <myproc>
80107045:	8b 7b 38             	mov    0x38(%ebx),%edi
80107048:	85 c0                	test   %eax,%eax
8010704a:	0f 84 64 02 00 00    	je     801072b4 <trap+0x2a4>
80107050:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80107054:	0f 84 5a 02 00 00    	je     801072b4 <trap+0x2a4>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010705a:	0f 20 d1             	mov    %cr2,%ecx
8010705d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107060:	e8 2b ca ff ff       	call   80103a90 <cpuid>
80107065:	8b 73 30             	mov    0x30(%ebx),%esi
80107068:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010706b:	8b 43 34             	mov    0x34(%ebx),%eax
8010706e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80107071:	e8 3a ca ff ff       	call   80103ab0 <myproc>
80107076:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107079:	e8 32 ca ff ff       	call   80103ab0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010707e:	8b 55 dc             	mov    -0x24(%ebp),%edx
80107081:	89 74 24 0c          	mov    %esi,0xc(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
80107085:	8b 75 e0             	mov    -0x20(%ebp),%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107088:	8b 4d d8             	mov    -0x28(%ebp),%ecx
8010708b:	89 7c 24 18          	mov    %edi,0x18(%esp)
8010708f:	89 54 24 14          	mov    %edx,0x14(%esp)
80107093:	8b 55 e4             	mov    -0x1c(%ebp),%edx
            myproc()->pid, myproc()->name, tf->trapno,
80107096:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107099:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
8010709d:	89 74 24 08          	mov    %esi,0x8(%esp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801070a1:	89 54 24 10          	mov    %edx,0x10(%esp)
801070a5:	8b 40 10             	mov    0x10(%eax),%eax
801070a8:	c7 04 24 ec 90 10 80 	movl   $0x801090ec,(%esp)
801070af:	89 44 24 04          	mov    %eax,0x4(%esp)
801070b3:	e8 98 95 ff ff       	call   80100650 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
801070b8:	e8 f3 c9 ff ff       	call   80103ab0 <myproc>
801070bd:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801070c4:	e8 e7 c9 ff ff       	call   80103ab0 <myproc>
801070c9:	85 c0                	test   %eax,%eax
801070cb:	74 1b                	je     801070e8 <trap+0xd8>
801070cd:	e8 de c9 ff ff       	call   80103ab0 <myproc>
801070d2:	8b 50 24             	mov    0x24(%eax),%edx
801070d5:	85 d2                	test   %edx,%edx
801070d7:	74 0f                	je     801070e8 <trap+0xd8>
801070d9:	8b 43 3c             	mov    0x3c(%ebx),%eax
801070dc:	83 e0 03             	and    $0x3,%eax
801070df:	83 f8 03             	cmp    $0x3,%eax
801070e2:	0f 84 80 01 00 00    	je     80107268 <trap+0x258>
    exit(0);

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801070e8:	e8 c3 c9 ff ff       	call   80103ab0 <myproc>
801070ed:	85 c0                	test   %eax,%eax
801070ef:	74 0d                	je     801070fe <trap+0xee>
801070f1:	e8 ba c9 ff ff       	call   80103ab0 <myproc>
801070f6:	8b 40 0c             	mov    0xc(%eax),%eax
801070f9:	83 f8 04             	cmp    $0x4,%eax
801070fc:	74 7a                	je     80107178 <trap+0x168>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801070fe:	e8 ad c9 ff ff       	call   80103ab0 <myproc>
80107103:	85 c0                	test   %eax,%eax
80107105:	74 17                	je     8010711e <trap+0x10e>
80107107:	e8 a4 c9 ff ff       	call   80103ab0 <myproc>
8010710c:	8b 40 24             	mov    0x24(%eax),%eax
8010710f:	85 c0                	test   %eax,%eax
80107111:	74 0b                	je     8010711e <trap+0x10e>
80107113:	8b 43 3c             	mov    0x3c(%ebx),%eax
80107116:	83 e0 03             	and    $0x3,%eax
80107119:	83 f8 03             	cmp    $0x3,%eax
8010711c:	74 3b                	je     80107159 <trap+0x149>
    exit(0);
}
8010711e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107121:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107124:	8b 7d fc             	mov    -0x4(%ebp),%edi
80107127:	89 ec                	mov    %ebp,%esp
80107129:	5d                   	pop    %ebp
8010712a:	c3                   	ret    
8010712b:	90                   	nop
8010712c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80107130:	e8 7b c9 ff ff       	call   80103ab0 <myproc>
80107135:	8b 70 24             	mov    0x24(%eax),%esi
80107138:	85 f6                	test   %esi,%esi
8010713a:	0f 85 10 01 00 00    	jne    80107250 <trap+0x240>
    myproc()->tf = tf;
80107140:	e8 6b c9 ff ff       	call   80103ab0 <myproc>
80107145:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80107148:	e8 d3 ee ff ff       	call   80106020 <syscall>
    if(myproc()->killed)
8010714d:	e8 5e c9 ff ff       	call   80103ab0 <myproc>
80107152:	8b 48 24             	mov    0x24(%eax),%ecx
80107155:	85 c9                	test   %ecx,%ecx
80107157:	74 c5                	je     8010711e <trap+0x10e>
      exit(0);
80107159:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
}
80107160:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107163:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107166:	8b 7d fc             	mov    -0x4(%ebp),%edi
80107169:	89 ec                	mov    %ebp,%esp
8010716b:	5d                   	pop    %ebp
      exit(0);
8010716c:	e9 df d0 ff ff       	jmp    80104250 <exit>
80107171:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(myproc() && myproc()->state == RUNNING &&
80107178:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
8010717c:	75 80                	jne    801070fe <trap+0xee>
    yield();
8010717e:	e8 ed d1 ff ff       	call   80104370 <yield>
80107183:	e9 76 ff ff ff       	jmp    801070fe <trap+0xee>
80107188:	90                   	nop
80107189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80107190:	e8 fb c8 ff ff       	call   80103a90 <cpuid>
80107195:	85 c0                	test   %eax,%eax
80107197:	0f 84 e3 00 00 00    	je     80107280 <trap+0x270>
8010719d:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
801071a0:	e8 ab b6 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801071a5:	e8 06 c9 ff ff       	call   80103ab0 <myproc>
801071aa:	85 c0                	test   %eax,%eax
801071ac:	0f 85 1b ff ff ff    	jne    801070cd <trap+0xbd>
801071b2:	e9 31 ff ff ff       	jmp    801070e8 <trap+0xd8>
801071b7:	89 f6                	mov    %esi,%esi
801071b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    kbdintr();
801071c0:	e8 4b b5 ff ff       	call   80102710 <kbdintr>
    lapiceoi();
801071c5:	e8 86 b6 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801071ca:	e8 e1 c8 ff ff       	call   80103ab0 <myproc>
801071cf:	85 c0                	test   %eax,%eax
801071d1:	0f 85 f6 fe ff ff    	jne    801070cd <trap+0xbd>
801071d7:	e9 0c ff ff ff       	jmp    801070e8 <trap+0xd8>
801071dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
801071e0:	e8 6b 02 00 00       	call   80107450 <uartintr>
    lapiceoi();
801071e5:	e8 66 b6 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801071ea:	e8 c1 c8 ff ff       	call   80103ab0 <myproc>
801071ef:	85 c0                	test   %eax,%eax
801071f1:	0f 85 d6 fe ff ff    	jne    801070cd <trap+0xbd>
801071f7:	e9 ec fe ff ff       	jmp    801070e8 <trap+0xd8>
801071fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80107200:	8b 7b 38             	mov    0x38(%ebx),%edi
80107203:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80107207:	e8 84 c8 ff ff       	call   80103a90 <cpuid>
8010720c:	c7 04 24 94 90 10 80 	movl   $0x80109094,(%esp)
80107213:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80107217:	89 74 24 08          	mov    %esi,0x8(%esp)
8010721b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010721f:	e8 2c 94 ff ff       	call   80100650 <cprintf>
    lapiceoi();
80107224:	e8 27 b6 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107229:	e8 82 c8 ff ff       	call   80103ab0 <myproc>
8010722e:	85 c0                	test   %eax,%eax
80107230:	0f 85 97 fe ff ff    	jne    801070cd <trap+0xbd>
80107236:	e9 ad fe ff ff       	jmp    801070e8 <trap+0xd8>
8010723b:	90                   	nop
8010723c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80107240:	e8 1b af ff ff       	call   80102160 <ideintr>
80107245:	e9 53 ff ff ff       	jmp    8010719d <trap+0x18d>
8010724a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit(0);
80107250:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80107257:	e8 f4 cf ff ff       	call   80104250 <exit>
8010725c:	e9 df fe ff ff       	jmp    80107140 <trap+0x130>
80107261:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit(0);
80107268:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010726f:	e8 dc cf ff ff       	call   80104250 <exit>
80107274:	e9 6f fe ff ff       	jmp    801070e8 <trap+0xd8>
80107279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      acquire(&tickslock);
80107280:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80107287:	e8 c4 e8 ff ff       	call   80105b50 <acquire>
        wakeup(&ticks);
8010728c:	c7 04 24 00 80 11 80 	movl   $0x80118000,(%esp)
      ticks++;
80107293:	ff 05 00 80 11 80    	incl   0x80118000
        wakeup(&ticks);
80107299:	e8 82 d3 ff ff       	call   80104620 <wakeup>
      update_procs_performances();
8010729e:	e8 bd c6 ff ff       	call   80103960 <update_procs_performances>
      release(&tickslock);
801072a3:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
801072aa:	e8 41 e9 ff ff       	call   80105bf0 <release>
801072af:	e9 e9 fe ff ff       	jmp    8010719d <trap+0x18d>
801072b4:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801072b7:	e8 d4 c7 ff ff       	call   80103a90 <cpuid>
801072bc:	89 74 24 10          	mov    %esi,0x10(%esp)
801072c0:	89 7c 24 0c          	mov    %edi,0xc(%esp)
801072c4:	89 44 24 08          	mov    %eax,0x8(%esp)
801072c8:	8b 43 30             	mov    0x30(%ebx),%eax
801072cb:	c7 04 24 b8 90 10 80 	movl   $0x801090b8,(%esp)
801072d2:	89 44 24 04          	mov    %eax,0x4(%esp)
801072d6:	e8 75 93 ff ff       	call   80100650 <cprintf>
      panic("trap");
801072db:	c7 04 24 8e 90 10 80 	movl   $0x8010908e,(%esp)
801072e2:	e8 89 90 ff ff       	call   80100370 <panic>
801072e7:	66 90                	xchg   %ax,%ax
801072e9:	66 90                	xchg   %ax,%ax
801072eb:	66 90                	xchg   %ax,%ax
801072ed:	66 90                	xchg   %ax,%ax
801072ef:	90                   	nop

801072f0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801072f0:	a1 18 c6 10 80       	mov    0x8010c618,%eax
{
801072f5:	55                   	push   %ebp
801072f6:	89 e5                	mov    %esp,%ebp
  if(!uart)
801072f8:	85 c0                	test   %eax,%eax
801072fa:	74 1c                	je     80107318 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801072fc:	ba fd 03 00 00       	mov    $0x3fd,%edx
80107301:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80107302:	24 01                	and    $0x1,%al
80107304:	84 c0                	test   %al,%al
80107306:	74 10                	je     80107318 <uartgetc+0x28>
80107308:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010730d:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010730e:	0f b6 c0             	movzbl %al,%eax
}
80107311:	5d                   	pop    %ebp
80107312:	c3                   	ret    
80107313:	90                   	nop
80107314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80107318:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010731d:	5d                   	pop    %ebp
8010731e:	c3                   	ret    
8010731f:	90                   	nop

80107320 <uartputc.part.0>:
uartputc(int c)
80107320:	55                   	push   %ebp
80107321:	89 e5                	mov    %esp,%ebp
80107323:	56                   	push   %esi
80107324:	be fd 03 00 00       	mov    $0x3fd,%esi
80107329:	53                   	push   %ebx
8010732a:	bb 80 00 00 00       	mov    $0x80,%ebx
8010732f:	83 ec 20             	sub    $0x20,%esp
80107332:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107335:	eb 18                	jmp    8010734f <uartputc.part.0+0x2f>
80107337:	89 f6                	mov    %esi,%esi
80107339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80107340:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80107347:	e8 24 b5 ff ff       	call   80102870 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010734c:	4b                   	dec    %ebx
8010734d:	74 09                	je     80107358 <uartputc.part.0+0x38>
8010734f:	89 f2                	mov    %esi,%edx
80107351:	ec                   	in     (%dx),%al
80107352:	24 20                	and    $0x20,%al
80107354:	84 c0                	test   %al,%al
80107356:	74 e8                	je     80107340 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107358:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010735d:	0f b6 45 f4          	movzbl -0xc(%ebp),%eax
80107361:	ee                   	out    %al,(%dx)
}
80107362:	83 c4 20             	add    $0x20,%esp
80107365:	5b                   	pop    %ebx
80107366:	5e                   	pop    %esi
80107367:	5d                   	pop    %ebp
80107368:	c3                   	ret    
80107369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107370 <uartinit>:
{
80107370:	55                   	push   %ebp
80107371:	31 c9                	xor    %ecx,%ecx
80107373:	89 e5                	mov    %esp,%ebp
80107375:	88 c8                	mov    %cl,%al
80107377:	57                   	push   %edi
80107378:	56                   	push   %esi
80107379:	53                   	push   %ebx
8010737a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010737f:	83 ec 1c             	sub    $0x1c,%esp
80107382:	89 da                	mov    %ebx,%edx
80107384:	ee                   	out    %al,(%dx)
80107385:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010738a:	b0 80                	mov    $0x80,%al
8010738c:	89 fa                	mov    %edi,%edx
8010738e:	ee                   	out    %al,(%dx)
8010738f:	b0 0c                	mov    $0xc,%al
80107391:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107396:	ee                   	out    %al,(%dx)
80107397:	be f9 03 00 00       	mov    $0x3f9,%esi
8010739c:	88 c8                	mov    %cl,%al
8010739e:	89 f2                	mov    %esi,%edx
801073a0:	ee                   	out    %al,(%dx)
801073a1:	b0 03                	mov    $0x3,%al
801073a3:	89 fa                	mov    %edi,%edx
801073a5:	ee                   	out    %al,(%dx)
801073a6:	ba fc 03 00 00       	mov    $0x3fc,%edx
801073ab:	88 c8                	mov    %cl,%al
801073ad:	ee                   	out    %al,(%dx)
801073ae:	b0 01                	mov    $0x1,%al
801073b0:	89 f2                	mov    %esi,%edx
801073b2:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801073b3:	ba fd 03 00 00       	mov    $0x3fd,%edx
801073b8:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801073b9:	fe c0                	inc    %al
801073bb:	74 52                	je     8010740f <uartinit+0x9f>
  uart = 1;
801073bd:	b9 01 00 00 00       	mov    $0x1,%ecx
801073c2:	89 da                	mov    %ebx,%edx
801073c4:	89 0d 18 c6 10 80    	mov    %ecx,0x8010c618
801073ca:	ec                   	in     (%dx),%al
801073cb:	ba f8 03 00 00       	mov    $0x3f8,%edx
801073d0:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801073d1:	31 db                	xor    %ebx,%ebx
801073d3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  for(p="xv6...\n"; *p; p++)
801073d7:	bb b0 91 10 80       	mov    $0x801091b0,%ebx
  ioapicenable(IRQ_COM1, 0);
801073dc:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
801073e3:	e8 b8 af ff ff       	call   801023a0 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
801073e8:	b8 78 00 00 00       	mov    $0x78,%eax
801073ed:	eb 09                	jmp    801073f8 <uartinit+0x88>
801073ef:	90                   	nop
801073f0:	43                   	inc    %ebx
801073f1:	0f be 03             	movsbl (%ebx),%eax
801073f4:	84 c0                	test   %al,%al
801073f6:	74 17                	je     8010740f <uartinit+0x9f>
  if(!uart)
801073f8:	8b 15 18 c6 10 80    	mov    0x8010c618,%edx
801073fe:	85 d2                	test   %edx,%edx
80107400:	74 ee                	je     801073f0 <uartinit+0x80>
  for(p="xv6...\n"; *p; p++)
80107402:	43                   	inc    %ebx
80107403:	e8 18 ff ff ff       	call   80107320 <uartputc.part.0>
80107408:	0f be 03             	movsbl (%ebx),%eax
8010740b:	84 c0                	test   %al,%al
8010740d:	75 e9                	jne    801073f8 <uartinit+0x88>
}
8010740f:	83 c4 1c             	add    $0x1c,%esp
80107412:	5b                   	pop    %ebx
80107413:	5e                   	pop    %esi
80107414:	5f                   	pop    %edi
80107415:	5d                   	pop    %ebp
80107416:	c3                   	ret    
80107417:	89 f6                	mov    %esi,%esi
80107419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107420 <uartputc>:
  if(!uart)
80107420:	8b 15 18 c6 10 80    	mov    0x8010c618,%edx
{
80107426:	55                   	push   %ebp
80107427:	89 e5                	mov    %esp,%ebp
80107429:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
8010742c:	85 d2                	test   %edx,%edx
8010742e:	74 10                	je     80107440 <uartputc+0x20>
}
80107430:	5d                   	pop    %ebp
80107431:	e9 ea fe ff ff       	jmp    80107320 <uartputc.part.0>
80107436:	8d 76 00             	lea    0x0(%esi),%esi
80107439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107440:	5d                   	pop    %ebp
80107441:	c3                   	ret    
80107442:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107450 <uartintr>:

void
uartintr(void)
{
80107450:	55                   	push   %ebp
80107451:	89 e5                	mov    %esp,%ebp
80107453:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80107456:	c7 04 24 f0 72 10 80 	movl   $0x801072f0,(%esp)
8010745d:	e8 6e 93 ff ff       	call   801007d0 <consoleintr>
}
80107462:	c9                   	leave  
80107463:	c3                   	ret    

80107464 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80107464:	6a 00                	push   $0x0
  pushl $0
80107466:	6a 00                	push   $0x0
  jmp alltraps
80107468:	e9 ca fa ff ff       	jmp    80106f37 <alltraps>

8010746d <vector1>:
.globl vector1
vector1:
  pushl $0
8010746d:	6a 00                	push   $0x0
  pushl $1
8010746f:	6a 01                	push   $0x1
  jmp alltraps
80107471:	e9 c1 fa ff ff       	jmp    80106f37 <alltraps>

80107476 <vector2>:
.globl vector2
vector2:
  pushl $0
80107476:	6a 00                	push   $0x0
  pushl $2
80107478:	6a 02                	push   $0x2
  jmp alltraps
8010747a:	e9 b8 fa ff ff       	jmp    80106f37 <alltraps>

8010747f <vector3>:
.globl vector3
vector3:
  pushl $0
8010747f:	6a 00                	push   $0x0
  pushl $3
80107481:	6a 03                	push   $0x3
  jmp alltraps
80107483:	e9 af fa ff ff       	jmp    80106f37 <alltraps>

80107488 <vector4>:
.globl vector4
vector4:
  pushl $0
80107488:	6a 00                	push   $0x0
  pushl $4
8010748a:	6a 04                	push   $0x4
  jmp alltraps
8010748c:	e9 a6 fa ff ff       	jmp    80106f37 <alltraps>

80107491 <vector5>:
.globl vector5
vector5:
  pushl $0
80107491:	6a 00                	push   $0x0
  pushl $5
80107493:	6a 05                	push   $0x5
  jmp alltraps
80107495:	e9 9d fa ff ff       	jmp    80106f37 <alltraps>

8010749a <vector6>:
.globl vector6
vector6:
  pushl $0
8010749a:	6a 00                	push   $0x0
  pushl $6
8010749c:	6a 06                	push   $0x6
  jmp alltraps
8010749e:	e9 94 fa ff ff       	jmp    80106f37 <alltraps>

801074a3 <vector7>:
.globl vector7
vector7:
  pushl $0
801074a3:	6a 00                	push   $0x0
  pushl $7
801074a5:	6a 07                	push   $0x7
  jmp alltraps
801074a7:	e9 8b fa ff ff       	jmp    80106f37 <alltraps>

801074ac <vector8>:
.globl vector8
vector8:
  pushl $8
801074ac:	6a 08                	push   $0x8
  jmp alltraps
801074ae:	e9 84 fa ff ff       	jmp    80106f37 <alltraps>

801074b3 <vector9>:
.globl vector9
vector9:
  pushl $0
801074b3:	6a 00                	push   $0x0
  pushl $9
801074b5:	6a 09                	push   $0x9
  jmp alltraps
801074b7:	e9 7b fa ff ff       	jmp    80106f37 <alltraps>

801074bc <vector10>:
.globl vector10
vector10:
  pushl $10
801074bc:	6a 0a                	push   $0xa
  jmp alltraps
801074be:	e9 74 fa ff ff       	jmp    80106f37 <alltraps>

801074c3 <vector11>:
.globl vector11
vector11:
  pushl $11
801074c3:	6a 0b                	push   $0xb
  jmp alltraps
801074c5:	e9 6d fa ff ff       	jmp    80106f37 <alltraps>

801074ca <vector12>:
.globl vector12
vector12:
  pushl $12
801074ca:	6a 0c                	push   $0xc
  jmp alltraps
801074cc:	e9 66 fa ff ff       	jmp    80106f37 <alltraps>

801074d1 <vector13>:
.globl vector13
vector13:
  pushl $13
801074d1:	6a 0d                	push   $0xd
  jmp alltraps
801074d3:	e9 5f fa ff ff       	jmp    80106f37 <alltraps>

801074d8 <vector14>:
.globl vector14
vector14:
  pushl $14
801074d8:	6a 0e                	push   $0xe
  jmp alltraps
801074da:	e9 58 fa ff ff       	jmp    80106f37 <alltraps>

801074df <vector15>:
.globl vector15
vector15:
  pushl $0
801074df:	6a 00                	push   $0x0
  pushl $15
801074e1:	6a 0f                	push   $0xf
  jmp alltraps
801074e3:	e9 4f fa ff ff       	jmp    80106f37 <alltraps>

801074e8 <vector16>:
.globl vector16
vector16:
  pushl $0
801074e8:	6a 00                	push   $0x0
  pushl $16
801074ea:	6a 10                	push   $0x10
  jmp alltraps
801074ec:	e9 46 fa ff ff       	jmp    80106f37 <alltraps>

801074f1 <vector17>:
.globl vector17
vector17:
  pushl $17
801074f1:	6a 11                	push   $0x11
  jmp alltraps
801074f3:	e9 3f fa ff ff       	jmp    80106f37 <alltraps>

801074f8 <vector18>:
.globl vector18
vector18:
  pushl $0
801074f8:	6a 00                	push   $0x0
  pushl $18
801074fa:	6a 12                	push   $0x12
  jmp alltraps
801074fc:	e9 36 fa ff ff       	jmp    80106f37 <alltraps>

80107501 <vector19>:
.globl vector19
vector19:
  pushl $0
80107501:	6a 00                	push   $0x0
  pushl $19
80107503:	6a 13                	push   $0x13
  jmp alltraps
80107505:	e9 2d fa ff ff       	jmp    80106f37 <alltraps>

8010750a <vector20>:
.globl vector20
vector20:
  pushl $0
8010750a:	6a 00                	push   $0x0
  pushl $20
8010750c:	6a 14                	push   $0x14
  jmp alltraps
8010750e:	e9 24 fa ff ff       	jmp    80106f37 <alltraps>

80107513 <vector21>:
.globl vector21
vector21:
  pushl $0
80107513:	6a 00                	push   $0x0
  pushl $21
80107515:	6a 15                	push   $0x15
  jmp alltraps
80107517:	e9 1b fa ff ff       	jmp    80106f37 <alltraps>

8010751c <vector22>:
.globl vector22
vector22:
  pushl $0
8010751c:	6a 00                	push   $0x0
  pushl $22
8010751e:	6a 16                	push   $0x16
  jmp alltraps
80107520:	e9 12 fa ff ff       	jmp    80106f37 <alltraps>

80107525 <vector23>:
.globl vector23
vector23:
  pushl $0
80107525:	6a 00                	push   $0x0
  pushl $23
80107527:	6a 17                	push   $0x17
  jmp alltraps
80107529:	e9 09 fa ff ff       	jmp    80106f37 <alltraps>

8010752e <vector24>:
.globl vector24
vector24:
  pushl $0
8010752e:	6a 00                	push   $0x0
  pushl $24
80107530:	6a 18                	push   $0x18
  jmp alltraps
80107532:	e9 00 fa ff ff       	jmp    80106f37 <alltraps>

80107537 <vector25>:
.globl vector25
vector25:
  pushl $0
80107537:	6a 00                	push   $0x0
  pushl $25
80107539:	6a 19                	push   $0x19
  jmp alltraps
8010753b:	e9 f7 f9 ff ff       	jmp    80106f37 <alltraps>

80107540 <vector26>:
.globl vector26
vector26:
  pushl $0
80107540:	6a 00                	push   $0x0
  pushl $26
80107542:	6a 1a                	push   $0x1a
  jmp alltraps
80107544:	e9 ee f9 ff ff       	jmp    80106f37 <alltraps>

80107549 <vector27>:
.globl vector27
vector27:
  pushl $0
80107549:	6a 00                	push   $0x0
  pushl $27
8010754b:	6a 1b                	push   $0x1b
  jmp alltraps
8010754d:	e9 e5 f9 ff ff       	jmp    80106f37 <alltraps>

80107552 <vector28>:
.globl vector28
vector28:
  pushl $0
80107552:	6a 00                	push   $0x0
  pushl $28
80107554:	6a 1c                	push   $0x1c
  jmp alltraps
80107556:	e9 dc f9 ff ff       	jmp    80106f37 <alltraps>

8010755b <vector29>:
.globl vector29
vector29:
  pushl $0
8010755b:	6a 00                	push   $0x0
  pushl $29
8010755d:	6a 1d                	push   $0x1d
  jmp alltraps
8010755f:	e9 d3 f9 ff ff       	jmp    80106f37 <alltraps>

80107564 <vector30>:
.globl vector30
vector30:
  pushl $0
80107564:	6a 00                	push   $0x0
  pushl $30
80107566:	6a 1e                	push   $0x1e
  jmp alltraps
80107568:	e9 ca f9 ff ff       	jmp    80106f37 <alltraps>

8010756d <vector31>:
.globl vector31
vector31:
  pushl $0
8010756d:	6a 00                	push   $0x0
  pushl $31
8010756f:	6a 1f                	push   $0x1f
  jmp alltraps
80107571:	e9 c1 f9 ff ff       	jmp    80106f37 <alltraps>

80107576 <vector32>:
.globl vector32
vector32:
  pushl $0
80107576:	6a 00                	push   $0x0
  pushl $32
80107578:	6a 20                	push   $0x20
  jmp alltraps
8010757a:	e9 b8 f9 ff ff       	jmp    80106f37 <alltraps>

8010757f <vector33>:
.globl vector33
vector33:
  pushl $0
8010757f:	6a 00                	push   $0x0
  pushl $33
80107581:	6a 21                	push   $0x21
  jmp alltraps
80107583:	e9 af f9 ff ff       	jmp    80106f37 <alltraps>

80107588 <vector34>:
.globl vector34
vector34:
  pushl $0
80107588:	6a 00                	push   $0x0
  pushl $34
8010758a:	6a 22                	push   $0x22
  jmp alltraps
8010758c:	e9 a6 f9 ff ff       	jmp    80106f37 <alltraps>

80107591 <vector35>:
.globl vector35
vector35:
  pushl $0
80107591:	6a 00                	push   $0x0
  pushl $35
80107593:	6a 23                	push   $0x23
  jmp alltraps
80107595:	e9 9d f9 ff ff       	jmp    80106f37 <alltraps>

8010759a <vector36>:
.globl vector36
vector36:
  pushl $0
8010759a:	6a 00                	push   $0x0
  pushl $36
8010759c:	6a 24                	push   $0x24
  jmp alltraps
8010759e:	e9 94 f9 ff ff       	jmp    80106f37 <alltraps>

801075a3 <vector37>:
.globl vector37
vector37:
  pushl $0
801075a3:	6a 00                	push   $0x0
  pushl $37
801075a5:	6a 25                	push   $0x25
  jmp alltraps
801075a7:	e9 8b f9 ff ff       	jmp    80106f37 <alltraps>

801075ac <vector38>:
.globl vector38
vector38:
  pushl $0
801075ac:	6a 00                	push   $0x0
  pushl $38
801075ae:	6a 26                	push   $0x26
  jmp alltraps
801075b0:	e9 82 f9 ff ff       	jmp    80106f37 <alltraps>

801075b5 <vector39>:
.globl vector39
vector39:
  pushl $0
801075b5:	6a 00                	push   $0x0
  pushl $39
801075b7:	6a 27                	push   $0x27
  jmp alltraps
801075b9:	e9 79 f9 ff ff       	jmp    80106f37 <alltraps>

801075be <vector40>:
.globl vector40
vector40:
  pushl $0
801075be:	6a 00                	push   $0x0
  pushl $40
801075c0:	6a 28                	push   $0x28
  jmp alltraps
801075c2:	e9 70 f9 ff ff       	jmp    80106f37 <alltraps>

801075c7 <vector41>:
.globl vector41
vector41:
  pushl $0
801075c7:	6a 00                	push   $0x0
  pushl $41
801075c9:	6a 29                	push   $0x29
  jmp alltraps
801075cb:	e9 67 f9 ff ff       	jmp    80106f37 <alltraps>

801075d0 <vector42>:
.globl vector42
vector42:
  pushl $0
801075d0:	6a 00                	push   $0x0
  pushl $42
801075d2:	6a 2a                	push   $0x2a
  jmp alltraps
801075d4:	e9 5e f9 ff ff       	jmp    80106f37 <alltraps>

801075d9 <vector43>:
.globl vector43
vector43:
  pushl $0
801075d9:	6a 00                	push   $0x0
  pushl $43
801075db:	6a 2b                	push   $0x2b
  jmp alltraps
801075dd:	e9 55 f9 ff ff       	jmp    80106f37 <alltraps>

801075e2 <vector44>:
.globl vector44
vector44:
  pushl $0
801075e2:	6a 00                	push   $0x0
  pushl $44
801075e4:	6a 2c                	push   $0x2c
  jmp alltraps
801075e6:	e9 4c f9 ff ff       	jmp    80106f37 <alltraps>

801075eb <vector45>:
.globl vector45
vector45:
  pushl $0
801075eb:	6a 00                	push   $0x0
  pushl $45
801075ed:	6a 2d                	push   $0x2d
  jmp alltraps
801075ef:	e9 43 f9 ff ff       	jmp    80106f37 <alltraps>

801075f4 <vector46>:
.globl vector46
vector46:
  pushl $0
801075f4:	6a 00                	push   $0x0
  pushl $46
801075f6:	6a 2e                	push   $0x2e
  jmp alltraps
801075f8:	e9 3a f9 ff ff       	jmp    80106f37 <alltraps>

801075fd <vector47>:
.globl vector47
vector47:
  pushl $0
801075fd:	6a 00                	push   $0x0
  pushl $47
801075ff:	6a 2f                	push   $0x2f
  jmp alltraps
80107601:	e9 31 f9 ff ff       	jmp    80106f37 <alltraps>

80107606 <vector48>:
.globl vector48
vector48:
  pushl $0
80107606:	6a 00                	push   $0x0
  pushl $48
80107608:	6a 30                	push   $0x30
  jmp alltraps
8010760a:	e9 28 f9 ff ff       	jmp    80106f37 <alltraps>

8010760f <vector49>:
.globl vector49
vector49:
  pushl $0
8010760f:	6a 00                	push   $0x0
  pushl $49
80107611:	6a 31                	push   $0x31
  jmp alltraps
80107613:	e9 1f f9 ff ff       	jmp    80106f37 <alltraps>

80107618 <vector50>:
.globl vector50
vector50:
  pushl $0
80107618:	6a 00                	push   $0x0
  pushl $50
8010761a:	6a 32                	push   $0x32
  jmp alltraps
8010761c:	e9 16 f9 ff ff       	jmp    80106f37 <alltraps>

80107621 <vector51>:
.globl vector51
vector51:
  pushl $0
80107621:	6a 00                	push   $0x0
  pushl $51
80107623:	6a 33                	push   $0x33
  jmp alltraps
80107625:	e9 0d f9 ff ff       	jmp    80106f37 <alltraps>

8010762a <vector52>:
.globl vector52
vector52:
  pushl $0
8010762a:	6a 00                	push   $0x0
  pushl $52
8010762c:	6a 34                	push   $0x34
  jmp alltraps
8010762e:	e9 04 f9 ff ff       	jmp    80106f37 <alltraps>

80107633 <vector53>:
.globl vector53
vector53:
  pushl $0
80107633:	6a 00                	push   $0x0
  pushl $53
80107635:	6a 35                	push   $0x35
  jmp alltraps
80107637:	e9 fb f8 ff ff       	jmp    80106f37 <alltraps>

8010763c <vector54>:
.globl vector54
vector54:
  pushl $0
8010763c:	6a 00                	push   $0x0
  pushl $54
8010763e:	6a 36                	push   $0x36
  jmp alltraps
80107640:	e9 f2 f8 ff ff       	jmp    80106f37 <alltraps>

80107645 <vector55>:
.globl vector55
vector55:
  pushl $0
80107645:	6a 00                	push   $0x0
  pushl $55
80107647:	6a 37                	push   $0x37
  jmp alltraps
80107649:	e9 e9 f8 ff ff       	jmp    80106f37 <alltraps>

8010764e <vector56>:
.globl vector56
vector56:
  pushl $0
8010764e:	6a 00                	push   $0x0
  pushl $56
80107650:	6a 38                	push   $0x38
  jmp alltraps
80107652:	e9 e0 f8 ff ff       	jmp    80106f37 <alltraps>

80107657 <vector57>:
.globl vector57
vector57:
  pushl $0
80107657:	6a 00                	push   $0x0
  pushl $57
80107659:	6a 39                	push   $0x39
  jmp alltraps
8010765b:	e9 d7 f8 ff ff       	jmp    80106f37 <alltraps>

80107660 <vector58>:
.globl vector58
vector58:
  pushl $0
80107660:	6a 00                	push   $0x0
  pushl $58
80107662:	6a 3a                	push   $0x3a
  jmp alltraps
80107664:	e9 ce f8 ff ff       	jmp    80106f37 <alltraps>

80107669 <vector59>:
.globl vector59
vector59:
  pushl $0
80107669:	6a 00                	push   $0x0
  pushl $59
8010766b:	6a 3b                	push   $0x3b
  jmp alltraps
8010766d:	e9 c5 f8 ff ff       	jmp    80106f37 <alltraps>

80107672 <vector60>:
.globl vector60
vector60:
  pushl $0
80107672:	6a 00                	push   $0x0
  pushl $60
80107674:	6a 3c                	push   $0x3c
  jmp alltraps
80107676:	e9 bc f8 ff ff       	jmp    80106f37 <alltraps>

8010767b <vector61>:
.globl vector61
vector61:
  pushl $0
8010767b:	6a 00                	push   $0x0
  pushl $61
8010767d:	6a 3d                	push   $0x3d
  jmp alltraps
8010767f:	e9 b3 f8 ff ff       	jmp    80106f37 <alltraps>

80107684 <vector62>:
.globl vector62
vector62:
  pushl $0
80107684:	6a 00                	push   $0x0
  pushl $62
80107686:	6a 3e                	push   $0x3e
  jmp alltraps
80107688:	e9 aa f8 ff ff       	jmp    80106f37 <alltraps>

8010768d <vector63>:
.globl vector63
vector63:
  pushl $0
8010768d:	6a 00                	push   $0x0
  pushl $63
8010768f:	6a 3f                	push   $0x3f
  jmp alltraps
80107691:	e9 a1 f8 ff ff       	jmp    80106f37 <alltraps>

80107696 <vector64>:
.globl vector64
vector64:
  pushl $0
80107696:	6a 00                	push   $0x0
  pushl $64
80107698:	6a 40                	push   $0x40
  jmp alltraps
8010769a:	e9 98 f8 ff ff       	jmp    80106f37 <alltraps>

8010769f <vector65>:
.globl vector65
vector65:
  pushl $0
8010769f:	6a 00                	push   $0x0
  pushl $65
801076a1:	6a 41                	push   $0x41
  jmp alltraps
801076a3:	e9 8f f8 ff ff       	jmp    80106f37 <alltraps>

801076a8 <vector66>:
.globl vector66
vector66:
  pushl $0
801076a8:	6a 00                	push   $0x0
  pushl $66
801076aa:	6a 42                	push   $0x42
  jmp alltraps
801076ac:	e9 86 f8 ff ff       	jmp    80106f37 <alltraps>

801076b1 <vector67>:
.globl vector67
vector67:
  pushl $0
801076b1:	6a 00                	push   $0x0
  pushl $67
801076b3:	6a 43                	push   $0x43
  jmp alltraps
801076b5:	e9 7d f8 ff ff       	jmp    80106f37 <alltraps>

801076ba <vector68>:
.globl vector68
vector68:
  pushl $0
801076ba:	6a 00                	push   $0x0
  pushl $68
801076bc:	6a 44                	push   $0x44
  jmp alltraps
801076be:	e9 74 f8 ff ff       	jmp    80106f37 <alltraps>

801076c3 <vector69>:
.globl vector69
vector69:
  pushl $0
801076c3:	6a 00                	push   $0x0
  pushl $69
801076c5:	6a 45                	push   $0x45
  jmp alltraps
801076c7:	e9 6b f8 ff ff       	jmp    80106f37 <alltraps>

801076cc <vector70>:
.globl vector70
vector70:
  pushl $0
801076cc:	6a 00                	push   $0x0
  pushl $70
801076ce:	6a 46                	push   $0x46
  jmp alltraps
801076d0:	e9 62 f8 ff ff       	jmp    80106f37 <alltraps>

801076d5 <vector71>:
.globl vector71
vector71:
  pushl $0
801076d5:	6a 00                	push   $0x0
  pushl $71
801076d7:	6a 47                	push   $0x47
  jmp alltraps
801076d9:	e9 59 f8 ff ff       	jmp    80106f37 <alltraps>

801076de <vector72>:
.globl vector72
vector72:
  pushl $0
801076de:	6a 00                	push   $0x0
  pushl $72
801076e0:	6a 48                	push   $0x48
  jmp alltraps
801076e2:	e9 50 f8 ff ff       	jmp    80106f37 <alltraps>

801076e7 <vector73>:
.globl vector73
vector73:
  pushl $0
801076e7:	6a 00                	push   $0x0
  pushl $73
801076e9:	6a 49                	push   $0x49
  jmp alltraps
801076eb:	e9 47 f8 ff ff       	jmp    80106f37 <alltraps>

801076f0 <vector74>:
.globl vector74
vector74:
  pushl $0
801076f0:	6a 00                	push   $0x0
  pushl $74
801076f2:	6a 4a                	push   $0x4a
  jmp alltraps
801076f4:	e9 3e f8 ff ff       	jmp    80106f37 <alltraps>

801076f9 <vector75>:
.globl vector75
vector75:
  pushl $0
801076f9:	6a 00                	push   $0x0
  pushl $75
801076fb:	6a 4b                	push   $0x4b
  jmp alltraps
801076fd:	e9 35 f8 ff ff       	jmp    80106f37 <alltraps>

80107702 <vector76>:
.globl vector76
vector76:
  pushl $0
80107702:	6a 00                	push   $0x0
  pushl $76
80107704:	6a 4c                	push   $0x4c
  jmp alltraps
80107706:	e9 2c f8 ff ff       	jmp    80106f37 <alltraps>

8010770b <vector77>:
.globl vector77
vector77:
  pushl $0
8010770b:	6a 00                	push   $0x0
  pushl $77
8010770d:	6a 4d                	push   $0x4d
  jmp alltraps
8010770f:	e9 23 f8 ff ff       	jmp    80106f37 <alltraps>

80107714 <vector78>:
.globl vector78
vector78:
  pushl $0
80107714:	6a 00                	push   $0x0
  pushl $78
80107716:	6a 4e                	push   $0x4e
  jmp alltraps
80107718:	e9 1a f8 ff ff       	jmp    80106f37 <alltraps>

8010771d <vector79>:
.globl vector79
vector79:
  pushl $0
8010771d:	6a 00                	push   $0x0
  pushl $79
8010771f:	6a 4f                	push   $0x4f
  jmp alltraps
80107721:	e9 11 f8 ff ff       	jmp    80106f37 <alltraps>

80107726 <vector80>:
.globl vector80
vector80:
  pushl $0
80107726:	6a 00                	push   $0x0
  pushl $80
80107728:	6a 50                	push   $0x50
  jmp alltraps
8010772a:	e9 08 f8 ff ff       	jmp    80106f37 <alltraps>

8010772f <vector81>:
.globl vector81
vector81:
  pushl $0
8010772f:	6a 00                	push   $0x0
  pushl $81
80107731:	6a 51                	push   $0x51
  jmp alltraps
80107733:	e9 ff f7 ff ff       	jmp    80106f37 <alltraps>

80107738 <vector82>:
.globl vector82
vector82:
  pushl $0
80107738:	6a 00                	push   $0x0
  pushl $82
8010773a:	6a 52                	push   $0x52
  jmp alltraps
8010773c:	e9 f6 f7 ff ff       	jmp    80106f37 <alltraps>

80107741 <vector83>:
.globl vector83
vector83:
  pushl $0
80107741:	6a 00                	push   $0x0
  pushl $83
80107743:	6a 53                	push   $0x53
  jmp alltraps
80107745:	e9 ed f7 ff ff       	jmp    80106f37 <alltraps>

8010774a <vector84>:
.globl vector84
vector84:
  pushl $0
8010774a:	6a 00                	push   $0x0
  pushl $84
8010774c:	6a 54                	push   $0x54
  jmp alltraps
8010774e:	e9 e4 f7 ff ff       	jmp    80106f37 <alltraps>

80107753 <vector85>:
.globl vector85
vector85:
  pushl $0
80107753:	6a 00                	push   $0x0
  pushl $85
80107755:	6a 55                	push   $0x55
  jmp alltraps
80107757:	e9 db f7 ff ff       	jmp    80106f37 <alltraps>

8010775c <vector86>:
.globl vector86
vector86:
  pushl $0
8010775c:	6a 00                	push   $0x0
  pushl $86
8010775e:	6a 56                	push   $0x56
  jmp alltraps
80107760:	e9 d2 f7 ff ff       	jmp    80106f37 <alltraps>

80107765 <vector87>:
.globl vector87
vector87:
  pushl $0
80107765:	6a 00                	push   $0x0
  pushl $87
80107767:	6a 57                	push   $0x57
  jmp alltraps
80107769:	e9 c9 f7 ff ff       	jmp    80106f37 <alltraps>

8010776e <vector88>:
.globl vector88
vector88:
  pushl $0
8010776e:	6a 00                	push   $0x0
  pushl $88
80107770:	6a 58                	push   $0x58
  jmp alltraps
80107772:	e9 c0 f7 ff ff       	jmp    80106f37 <alltraps>

80107777 <vector89>:
.globl vector89
vector89:
  pushl $0
80107777:	6a 00                	push   $0x0
  pushl $89
80107779:	6a 59                	push   $0x59
  jmp alltraps
8010777b:	e9 b7 f7 ff ff       	jmp    80106f37 <alltraps>

80107780 <vector90>:
.globl vector90
vector90:
  pushl $0
80107780:	6a 00                	push   $0x0
  pushl $90
80107782:	6a 5a                	push   $0x5a
  jmp alltraps
80107784:	e9 ae f7 ff ff       	jmp    80106f37 <alltraps>

80107789 <vector91>:
.globl vector91
vector91:
  pushl $0
80107789:	6a 00                	push   $0x0
  pushl $91
8010778b:	6a 5b                	push   $0x5b
  jmp alltraps
8010778d:	e9 a5 f7 ff ff       	jmp    80106f37 <alltraps>

80107792 <vector92>:
.globl vector92
vector92:
  pushl $0
80107792:	6a 00                	push   $0x0
  pushl $92
80107794:	6a 5c                	push   $0x5c
  jmp alltraps
80107796:	e9 9c f7 ff ff       	jmp    80106f37 <alltraps>

8010779b <vector93>:
.globl vector93
vector93:
  pushl $0
8010779b:	6a 00                	push   $0x0
  pushl $93
8010779d:	6a 5d                	push   $0x5d
  jmp alltraps
8010779f:	e9 93 f7 ff ff       	jmp    80106f37 <alltraps>

801077a4 <vector94>:
.globl vector94
vector94:
  pushl $0
801077a4:	6a 00                	push   $0x0
  pushl $94
801077a6:	6a 5e                	push   $0x5e
  jmp alltraps
801077a8:	e9 8a f7 ff ff       	jmp    80106f37 <alltraps>

801077ad <vector95>:
.globl vector95
vector95:
  pushl $0
801077ad:	6a 00                	push   $0x0
  pushl $95
801077af:	6a 5f                	push   $0x5f
  jmp alltraps
801077b1:	e9 81 f7 ff ff       	jmp    80106f37 <alltraps>

801077b6 <vector96>:
.globl vector96
vector96:
  pushl $0
801077b6:	6a 00                	push   $0x0
  pushl $96
801077b8:	6a 60                	push   $0x60
  jmp alltraps
801077ba:	e9 78 f7 ff ff       	jmp    80106f37 <alltraps>

801077bf <vector97>:
.globl vector97
vector97:
  pushl $0
801077bf:	6a 00                	push   $0x0
  pushl $97
801077c1:	6a 61                	push   $0x61
  jmp alltraps
801077c3:	e9 6f f7 ff ff       	jmp    80106f37 <alltraps>

801077c8 <vector98>:
.globl vector98
vector98:
  pushl $0
801077c8:	6a 00                	push   $0x0
  pushl $98
801077ca:	6a 62                	push   $0x62
  jmp alltraps
801077cc:	e9 66 f7 ff ff       	jmp    80106f37 <alltraps>

801077d1 <vector99>:
.globl vector99
vector99:
  pushl $0
801077d1:	6a 00                	push   $0x0
  pushl $99
801077d3:	6a 63                	push   $0x63
  jmp alltraps
801077d5:	e9 5d f7 ff ff       	jmp    80106f37 <alltraps>

801077da <vector100>:
.globl vector100
vector100:
  pushl $0
801077da:	6a 00                	push   $0x0
  pushl $100
801077dc:	6a 64                	push   $0x64
  jmp alltraps
801077de:	e9 54 f7 ff ff       	jmp    80106f37 <alltraps>

801077e3 <vector101>:
.globl vector101
vector101:
  pushl $0
801077e3:	6a 00                	push   $0x0
  pushl $101
801077e5:	6a 65                	push   $0x65
  jmp alltraps
801077e7:	e9 4b f7 ff ff       	jmp    80106f37 <alltraps>

801077ec <vector102>:
.globl vector102
vector102:
  pushl $0
801077ec:	6a 00                	push   $0x0
  pushl $102
801077ee:	6a 66                	push   $0x66
  jmp alltraps
801077f0:	e9 42 f7 ff ff       	jmp    80106f37 <alltraps>

801077f5 <vector103>:
.globl vector103
vector103:
  pushl $0
801077f5:	6a 00                	push   $0x0
  pushl $103
801077f7:	6a 67                	push   $0x67
  jmp alltraps
801077f9:	e9 39 f7 ff ff       	jmp    80106f37 <alltraps>

801077fe <vector104>:
.globl vector104
vector104:
  pushl $0
801077fe:	6a 00                	push   $0x0
  pushl $104
80107800:	6a 68                	push   $0x68
  jmp alltraps
80107802:	e9 30 f7 ff ff       	jmp    80106f37 <alltraps>

80107807 <vector105>:
.globl vector105
vector105:
  pushl $0
80107807:	6a 00                	push   $0x0
  pushl $105
80107809:	6a 69                	push   $0x69
  jmp alltraps
8010780b:	e9 27 f7 ff ff       	jmp    80106f37 <alltraps>

80107810 <vector106>:
.globl vector106
vector106:
  pushl $0
80107810:	6a 00                	push   $0x0
  pushl $106
80107812:	6a 6a                	push   $0x6a
  jmp alltraps
80107814:	e9 1e f7 ff ff       	jmp    80106f37 <alltraps>

80107819 <vector107>:
.globl vector107
vector107:
  pushl $0
80107819:	6a 00                	push   $0x0
  pushl $107
8010781b:	6a 6b                	push   $0x6b
  jmp alltraps
8010781d:	e9 15 f7 ff ff       	jmp    80106f37 <alltraps>

80107822 <vector108>:
.globl vector108
vector108:
  pushl $0
80107822:	6a 00                	push   $0x0
  pushl $108
80107824:	6a 6c                	push   $0x6c
  jmp alltraps
80107826:	e9 0c f7 ff ff       	jmp    80106f37 <alltraps>

8010782b <vector109>:
.globl vector109
vector109:
  pushl $0
8010782b:	6a 00                	push   $0x0
  pushl $109
8010782d:	6a 6d                	push   $0x6d
  jmp alltraps
8010782f:	e9 03 f7 ff ff       	jmp    80106f37 <alltraps>

80107834 <vector110>:
.globl vector110
vector110:
  pushl $0
80107834:	6a 00                	push   $0x0
  pushl $110
80107836:	6a 6e                	push   $0x6e
  jmp alltraps
80107838:	e9 fa f6 ff ff       	jmp    80106f37 <alltraps>

8010783d <vector111>:
.globl vector111
vector111:
  pushl $0
8010783d:	6a 00                	push   $0x0
  pushl $111
8010783f:	6a 6f                	push   $0x6f
  jmp alltraps
80107841:	e9 f1 f6 ff ff       	jmp    80106f37 <alltraps>

80107846 <vector112>:
.globl vector112
vector112:
  pushl $0
80107846:	6a 00                	push   $0x0
  pushl $112
80107848:	6a 70                	push   $0x70
  jmp alltraps
8010784a:	e9 e8 f6 ff ff       	jmp    80106f37 <alltraps>

8010784f <vector113>:
.globl vector113
vector113:
  pushl $0
8010784f:	6a 00                	push   $0x0
  pushl $113
80107851:	6a 71                	push   $0x71
  jmp alltraps
80107853:	e9 df f6 ff ff       	jmp    80106f37 <alltraps>

80107858 <vector114>:
.globl vector114
vector114:
  pushl $0
80107858:	6a 00                	push   $0x0
  pushl $114
8010785a:	6a 72                	push   $0x72
  jmp alltraps
8010785c:	e9 d6 f6 ff ff       	jmp    80106f37 <alltraps>

80107861 <vector115>:
.globl vector115
vector115:
  pushl $0
80107861:	6a 00                	push   $0x0
  pushl $115
80107863:	6a 73                	push   $0x73
  jmp alltraps
80107865:	e9 cd f6 ff ff       	jmp    80106f37 <alltraps>

8010786a <vector116>:
.globl vector116
vector116:
  pushl $0
8010786a:	6a 00                	push   $0x0
  pushl $116
8010786c:	6a 74                	push   $0x74
  jmp alltraps
8010786e:	e9 c4 f6 ff ff       	jmp    80106f37 <alltraps>

80107873 <vector117>:
.globl vector117
vector117:
  pushl $0
80107873:	6a 00                	push   $0x0
  pushl $117
80107875:	6a 75                	push   $0x75
  jmp alltraps
80107877:	e9 bb f6 ff ff       	jmp    80106f37 <alltraps>

8010787c <vector118>:
.globl vector118
vector118:
  pushl $0
8010787c:	6a 00                	push   $0x0
  pushl $118
8010787e:	6a 76                	push   $0x76
  jmp alltraps
80107880:	e9 b2 f6 ff ff       	jmp    80106f37 <alltraps>

80107885 <vector119>:
.globl vector119
vector119:
  pushl $0
80107885:	6a 00                	push   $0x0
  pushl $119
80107887:	6a 77                	push   $0x77
  jmp alltraps
80107889:	e9 a9 f6 ff ff       	jmp    80106f37 <alltraps>

8010788e <vector120>:
.globl vector120
vector120:
  pushl $0
8010788e:	6a 00                	push   $0x0
  pushl $120
80107890:	6a 78                	push   $0x78
  jmp alltraps
80107892:	e9 a0 f6 ff ff       	jmp    80106f37 <alltraps>

80107897 <vector121>:
.globl vector121
vector121:
  pushl $0
80107897:	6a 00                	push   $0x0
  pushl $121
80107899:	6a 79                	push   $0x79
  jmp alltraps
8010789b:	e9 97 f6 ff ff       	jmp    80106f37 <alltraps>

801078a0 <vector122>:
.globl vector122
vector122:
  pushl $0
801078a0:	6a 00                	push   $0x0
  pushl $122
801078a2:	6a 7a                	push   $0x7a
  jmp alltraps
801078a4:	e9 8e f6 ff ff       	jmp    80106f37 <alltraps>

801078a9 <vector123>:
.globl vector123
vector123:
  pushl $0
801078a9:	6a 00                	push   $0x0
  pushl $123
801078ab:	6a 7b                	push   $0x7b
  jmp alltraps
801078ad:	e9 85 f6 ff ff       	jmp    80106f37 <alltraps>

801078b2 <vector124>:
.globl vector124
vector124:
  pushl $0
801078b2:	6a 00                	push   $0x0
  pushl $124
801078b4:	6a 7c                	push   $0x7c
  jmp alltraps
801078b6:	e9 7c f6 ff ff       	jmp    80106f37 <alltraps>

801078bb <vector125>:
.globl vector125
vector125:
  pushl $0
801078bb:	6a 00                	push   $0x0
  pushl $125
801078bd:	6a 7d                	push   $0x7d
  jmp alltraps
801078bf:	e9 73 f6 ff ff       	jmp    80106f37 <alltraps>

801078c4 <vector126>:
.globl vector126
vector126:
  pushl $0
801078c4:	6a 00                	push   $0x0
  pushl $126
801078c6:	6a 7e                	push   $0x7e
  jmp alltraps
801078c8:	e9 6a f6 ff ff       	jmp    80106f37 <alltraps>

801078cd <vector127>:
.globl vector127
vector127:
  pushl $0
801078cd:	6a 00                	push   $0x0
  pushl $127
801078cf:	6a 7f                	push   $0x7f
  jmp alltraps
801078d1:	e9 61 f6 ff ff       	jmp    80106f37 <alltraps>

801078d6 <vector128>:
.globl vector128
vector128:
  pushl $0
801078d6:	6a 00                	push   $0x0
  pushl $128
801078d8:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801078dd:	e9 55 f6 ff ff       	jmp    80106f37 <alltraps>

801078e2 <vector129>:
.globl vector129
vector129:
  pushl $0
801078e2:	6a 00                	push   $0x0
  pushl $129
801078e4:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801078e9:	e9 49 f6 ff ff       	jmp    80106f37 <alltraps>

801078ee <vector130>:
.globl vector130
vector130:
  pushl $0
801078ee:	6a 00                	push   $0x0
  pushl $130
801078f0:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801078f5:	e9 3d f6 ff ff       	jmp    80106f37 <alltraps>

801078fa <vector131>:
.globl vector131
vector131:
  pushl $0
801078fa:	6a 00                	push   $0x0
  pushl $131
801078fc:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80107901:	e9 31 f6 ff ff       	jmp    80106f37 <alltraps>

80107906 <vector132>:
.globl vector132
vector132:
  pushl $0
80107906:	6a 00                	push   $0x0
  pushl $132
80107908:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010790d:	e9 25 f6 ff ff       	jmp    80106f37 <alltraps>

80107912 <vector133>:
.globl vector133
vector133:
  pushl $0
80107912:	6a 00                	push   $0x0
  pushl $133
80107914:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80107919:	e9 19 f6 ff ff       	jmp    80106f37 <alltraps>

8010791e <vector134>:
.globl vector134
vector134:
  pushl $0
8010791e:	6a 00                	push   $0x0
  pushl $134
80107920:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107925:	e9 0d f6 ff ff       	jmp    80106f37 <alltraps>

8010792a <vector135>:
.globl vector135
vector135:
  pushl $0
8010792a:	6a 00                	push   $0x0
  pushl $135
8010792c:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107931:	e9 01 f6 ff ff       	jmp    80106f37 <alltraps>

80107936 <vector136>:
.globl vector136
vector136:
  pushl $0
80107936:	6a 00                	push   $0x0
  pushl $136
80107938:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010793d:	e9 f5 f5 ff ff       	jmp    80106f37 <alltraps>

80107942 <vector137>:
.globl vector137
vector137:
  pushl $0
80107942:	6a 00                	push   $0x0
  pushl $137
80107944:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80107949:	e9 e9 f5 ff ff       	jmp    80106f37 <alltraps>

8010794e <vector138>:
.globl vector138
vector138:
  pushl $0
8010794e:	6a 00                	push   $0x0
  pushl $138
80107950:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107955:	e9 dd f5 ff ff       	jmp    80106f37 <alltraps>

8010795a <vector139>:
.globl vector139
vector139:
  pushl $0
8010795a:	6a 00                	push   $0x0
  pushl $139
8010795c:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80107961:	e9 d1 f5 ff ff       	jmp    80106f37 <alltraps>

80107966 <vector140>:
.globl vector140
vector140:
  pushl $0
80107966:	6a 00                	push   $0x0
  pushl $140
80107968:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010796d:	e9 c5 f5 ff ff       	jmp    80106f37 <alltraps>

80107972 <vector141>:
.globl vector141
vector141:
  pushl $0
80107972:	6a 00                	push   $0x0
  pushl $141
80107974:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80107979:	e9 b9 f5 ff ff       	jmp    80106f37 <alltraps>

8010797e <vector142>:
.globl vector142
vector142:
  pushl $0
8010797e:	6a 00                	push   $0x0
  pushl $142
80107980:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80107985:	e9 ad f5 ff ff       	jmp    80106f37 <alltraps>

8010798a <vector143>:
.globl vector143
vector143:
  pushl $0
8010798a:	6a 00                	push   $0x0
  pushl $143
8010798c:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80107991:	e9 a1 f5 ff ff       	jmp    80106f37 <alltraps>

80107996 <vector144>:
.globl vector144
vector144:
  pushl $0
80107996:	6a 00                	push   $0x0
  pushl $144
80107998:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010799d:	e9 95 f5 ff ff       	jmp    80106f37 <alltraps>

801079a2 <vector145>:
.globl vector145
vector145:
  pushl $0
801079a2:	6a 00                	push   $0x0
  pushl $145
801079a4:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801079a9:	e9 89 f5 ff ff       	jmp    80106f37 <alltraps>

801079ae <vector146>:
.globl vector146
vector146:
  pushl $0
801079ae:	6a 00                	push   $0x0
  pushl $146
801079b0:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801079b5:	e9 7d f5 ff ff       	jmp    80106f37 <alltraps>

801079ba <vector147>:
.globl vector147
vector147:
  pushl $0
801079ba:	6a 00                	push   $0x0
  pushl $147
801079bc:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801079c1:	e9 71 f5 ff ff       	jmp    80106f37 <alltraps>

801079c6 <vector148>:
.globl vector148
vector148:
  pushl $0
801079c6:	6a 00                	push   $0x0
  pushl $148
801079c8:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801079cd:	e9 65 f5 ff ff       	jmp    80106f37 <alltraps>

801079d2 <vector149>:
.globl vector149
vector149:
  pushl $0
801079d2:	6a 00                	push   $0x0
  pushl $149
801079d4:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801079d9:	e9 59 f5 ff ff       	jmp    80106f37 <alltraps>

801079de <vector150>:
.globl vector150
vector150:
  pushl $0
801079de:	6a 00                	push   $0x0
  pushl $150
801079e0:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801079e5:	e9 4d f5 ff ff       	jmp    80106f37 <alltraps>

801079ea <vector151>:
.globl vector151
vector151:
  pushl $0
801079ea:	6a 00                	push   $0x0
  pushl $151
801079ec:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801079f1:	e9 41 f5 ff ff       	jmp    80106f37 <alltraps>

801079f6 <vector152>:
.globl vector152
vector152:
  pushl $0
801079f6:	6a 00                	push   $0x0
  pushl $152
801079f8:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801079fd:	e9 35 f5 ff ff       	jmp    80106f37 <alltraps>

80107a02 <vector153>:
.globl vector153
vector153:
  pushl $0
80107a02:	6a 00                	push   $0x0
  pushl $153
80107a04:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80107a09:	e9 29 f5 ff ff       	jmp    80106f37 <alltraps>

80107a0e <vector154>:
.globl vector154
vector154:
  pushl $0
80107a0e:	6a 00                	push   $0x0
  pushl $154
80107a10:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80107a15:	e9 1d f5 ff ff       	jmp    80106f37 <alltraps>

80107a1a <vector155>:
.globl vector155
vector155:
  pushl $0
80107a1a:	6a 00                	push   $0x0
  pushl $155
80107a1c:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107a21:	e9 11 f5 ff ff       	jmp    80106f37 <alltraps>

80107a26 <vector156>:
.globl vector156
vector156:
  pushl $0
80107a26:	6a 00                	push   $0x0
  pushl $156
80107a28:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80107a2d:	e9 05 f5 ff ff       	jmp    80106f37 <alltraps>

80107a32 <vector157>:
.globl vector157
vector157:
  pushl $0
80107a32:	6a 00                	push   $0x0
  pushl $157
80107a34:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80107a39:	e9 f9 f4 ff ff       	jmp    80106f37 <alltraps>

80107a3e <vector158>:
.globl vector158
vector158:
  pushl $0
80107a3e:	6a 00                	push   $0x0
  pushl $158
80107a40:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107a45:	e9 ed f4 ff ff       	jmp    80106f37 <alltraps>

80107a4a <vector159>:
.globl vector159
vector159:
  pushl $0
80107a4a:	6a 00                	push   $0x0
  pushl $159
80107a4c:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80107a51:	e9 e1 f4 ff ff       	jmp    80106f37 <alltraps>

80107a56 <vector160>:
.globl vector160
vector160:
  pushl $0
80107a56:	6a 00                	push   $0x0
  pushl $160
80107a58:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80107a5d:	e9 d5 f4 ff ff       	jmp    80106f37 <alltraps>

80107a62 <vector161>:
.globl vector161
vector161:
  pushl $0
80107a62:	6a 00                	push   $0x0
  pushl $161
80107a64:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80107a69:	e9 c9 f4 ff ff       	jmp    80106f37 <alltraps>

80107a6e <vector162>:
.globl vector162
vector162:
  pushl $0
80107a6e:	6a 00                	push   $0x0
  pushl $162
80107a70:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80107a75:	e9 bd f4 ff ff       	jmp    80106f37 <alltraps>

80107a7a <vector163>:
.globl vector163
vector163:
  pushl $0
80107a7a:	6a 00                	push   $0x0
  pushl $163
80107a7c:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80107a81:	e9 b1 f4 ff ff       	jmp    80106f37 <alltraps>

80107a86 <vector164>:
.globl vector164
vector164:
  pushl $0
80107a86:	6a 00                	push   $0x0
  pushl $164
80107a88:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80107a8d:	e9 a5 f4 ff ff       	jmp    80106f37 <alltraps>

80107a92 <vector165>:
.globl vector165
vector165:
  pushl $0
80107a92:	6a 00                	push   $0x0
  pushl $165
80107a94:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80107a99:	e9 99 f4 ff ff       	jmp    80106f37 <alltraps>

80107a9e <vector166>:
.globl vector166
vector166:
  pushl $0
80107a9e:	6a 00                	push   $0x0
  pushl $166
80107aa0:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107aa5:	e9 8d f4 ff ff       	jmp    80106f37 <alltraps>

80107aaa <vector167>:
.globl vector167
vector167:
  pushl $0
80107aaa:	6a 00                	push   $0x0
  pushl $167
80107aac:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107ab1:	e9 81 f4 ff ff       	jmp    80106f37 <alltraps>

80107ab6 <vector168>:
.globl vector168
vector168:
  pushl $0
80107ab6:	6a 00                	push   $0x0
  pushl $168
80107ab8:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80107abd:	e9 75 f4 ff ff       	jmp    80106f37 <alltraps>

80107ac2 <vector169>:
.globl vector169
vector169:
  pushl $0
80107ac2:	6a 00                	push   $0x0
  pushl $169
80107ac4:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80107ac9:	e9 69 f4 ff ff       	jmp    80106f37 <alltraps>

80107ace <vector170>:
.globl vector170
vector170:
  pushl $0
80107ace:	6a 00                	push   $0x0
  pushl $170
80107ad0:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107ad5:	e9 5d f4 ff ff       	jmp    80106f37 <alltraps>

80107ada <vector171>:
.globl vector171
vector171:
  pushl $0
80107ada:	6a 00                	push   $0x0
  pushl $171
80107adc:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107ae1:	e9 51 f4 ff ff       	jmp    80106f37 <alltraps>

80107ae6 <vector172>:
.globl vector172
vector172:
  pushl $0
80107ae6:	6a 00                	push   $0x0
  pushl $172
80107ae8:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80107aed:	e9 45 f4 ff ff       	jmp    80106f37 <alltraps>

80107af2 <vector173>:
.globl vector173
vector173:
  pushl $0
80107af2:	6a 00                	push   $0x0
  pushl $173
80107af4:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80107af9:	e9 39 f4 ff ff       	jmp    80106f37 <alltraps>

80107afe <vector174>:
.globl vector174
vector174:
  pushl $0
80107afe:	6a 00                	push   $0x0
  pushl $174
80107b00:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107b05:	e9 2d f4 ff ff       	jmp    80106f37 <alltraps>

80107b0a <vector175>:
.globl vector175
vector175:
  pushl $0
80107b0a:	6a 00                	push   $0x0
  pushl $175
80107b0c:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107b11:	e9 21 f4 ff ff       	jmp    80106f37 <alltraps>

80107b16 <vector176>:
.globl vector176
vector176:
  pushl $0
80107b16:	6a 00                	push   $0x0
  pushl $176
80107b18:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80107b1d:	e9 15 f4 ff ff       	jmp    80106f37 <alltraps>

80107b22 <vector177>:
.globl vector177
vector177:
  pushl $0
80107b22:	6a 00                	push   $0x0
  pushl $177
80107b24:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80107b29:	e9 09 f4 ff ff       	jmp    80106f37 <alltraps>

80107b2e <vector178>:
.globl vector178
vector178:
  pushl $0
80107b2e:	6a 00                	push   $0x0
  pushl $178
80107b30:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107b35:	e9 fd f3 ff ff       	jmp    80106f37 <alltraps>

80107b3a <vector179>:
.globl vector179
vector179:
  pushl $0
80107b3a:	6a 00                	push   $0x0
  pushl $179
80107b3c:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107b41:	e9 f1 f3 ff ff       	jmp    80106f37 <alltraps>

80107b46 <vector180>:
.globl vector180
vector180:
  pushl $0
80107b46:	6a 00                	push   $0x0
  pushl $180
80107b48:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80107b4d:	e9 e5 f3 ff ff       	jmp    80106f37 <alltraps>

80107b52 <vector181>:
.globl vector181
vector181:
  pushl $0
80107b52:	6a 00                	push   $0x0
  pushl $181
80107b54:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80107b59:	e9 d9 f3 ff ff       	jmp    80106f37 <alltraps>

80107b5e <vector182>:
.globl vector182
vector182:
  pushl $0
80107b5e:	6a 00                	push   $0x0
  pushl $182
80107b60:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107b65:	e9 cd f3 ff ff       	jmp    80106f37 <alltraps>

80107b6a <vector183>:
.globl vector183
vector183:
  pushl $0
80107b6a:	6a 00                	push   $0x0
  pushl $183
80107b6c:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107b71:	e9 c1 f3 ff ff       	jmp    80106f37 <alltraps>

80107b76 <vector184>:
.globl vector184
vector184:
  pushl $0
80107b76:	6a 00                	push   $0x0
  pushl $184
80107b78:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80107b7d:	e9 b5 f3 ff ff       	jmp    80106f37 <alltraps>

80107b82 <vector185>:
.globl vector185
vector185:
  pushl $0
80107b82:	6a 00                	push   $0x0
  pushl $185
80107b84:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80107b89:	e9 a9 f3 ff ff       	jmp    80106f37 <alltraps>

80107b8e <vector186>:
.globl vector186
vector186:
  pushl $0
80107b8e:	6a 00                	push   $0x0
  pushl $186
80107b90:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107b95:	e9 9d f3 ff ff       	jmp    80106f37 <alltraps>

80107b9a <vector187>:
.globl vector187
vector187:
  pushl $0
80107b9a:	6a 00                	push   $0x0
  pushl $187
80107b9c:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107ba1:	e9 91 f3 ff ff       	jmp    80106f37 <alltraps>

80107ba6 <vector188>:
.globl vector188
vector188:
  pushl $0
80107ba6:	6a 00                	push   $0x0
  pushl $188
80107ba8:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80107bad:	e9 85 f3 ff ff       	jmp    80106f37 <alltraps>

80107bb2 <vector189>:
.globl vector189
vector189:
  pushl $0
80107bb2:	6a 00                	push   $0x0
  pushl $189
80107bb4:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80107bb9:	e9 79 f3 ff ff       	jmp    80106f37 <alltraps>

80107bbe <vector190>:
.globl vector190
vector190:
  pushl $0
80107bbe:	6a 00                	push   $0x0
  pushl $190
80107bc0:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107bc5:	e9 6d f3 ff ff       	jmp    80106f37 <alltraps>

80107bca <vector191>:
.globl vector191
vector191:
  pushl $0
80107bca:	6a 00                	push   $0x0
  pushl $191
80107bcc:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107bd1:	e9 61 f3 ff ff       	jmp    80106f37 <alltraps>

80107bd6 <vector192>:
.globl vector192
vector192:
  pushl $0
80107bd6:	6a 00                	push   $0x0
  pushl $192
80107bd8:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80107bdd:	e9 55 f3 ff ff       	jmp    80106f37 <alltraps>

80107be2 <vector193>:
.globl vector193
vector193:
  pushl $0
80107be2:	6a 00                	push   $0x0
  pushl $193
80107be4:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80107be9:	e9 49 f3 ff ff       	jmp    80106f37 <alltraps>

80107bee <vector194>:
.globl vector194
vector194:
  pushl $0
80107bee:	6a 00                	push   $0x0
  pushl $194
80107bf0:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107bf5:	e9 3d f3 ff ff       	jmp    80106f37 <alltraps>

80107bfa <vector195>:
.globl vector195
vector195:
  pushl $0
80107bfa:	6a 00                	push   $0x0
  pushl $195
80107bfc:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107c01:	e9 31 f3 ff ff       	jmp    80106f37 <alltraps>

80107c06 <vector196>:
.globl vector196
vector196:
  pushl $0
80107c06:	6a 00                	push   $0x0
  pushl $196
80107c08:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80107c0d:	e9 25 f3 ff ff       	jmp    80106f37 <alltraps>

80107c12 <vector197>:
.globl vector197
vector197:
  pushl $0
80107c12:	6a 00                	push   $0x0
  pushl $197
80107c14:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80107c19:	e9 19 f3 ff ff       	jmp    80106f37 <alltraps>

80107c1e <vector198>:
.globl vector198
vector198:
  pushl $0
80107c1e:	6a 00                	push   $0x0
  pushl $198
80107c20:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107c25:	e9 0d f3 ff ff       	jmp    80106f37 <alltraps>

80107c2a <vector199>:
.globl vector199
vector199:
  pushl $0
80107c2a:	6a 00                	push   $0x0
  pushl $199
80107c2c:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107c31:	e9 01 f3 ff ff       	jmp    80106f37 <alltraps>

80107c36 <vector200>:
.globl vector200
vector200:
  pushl $0
80107c36:	6a 00                	push   $0x0
  pushl $200
80107c38:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80107c3d:	e9 f5 f2 ff ff       	jmp    80106f37 <alltraps>

80107c42 <vector201>:
.globl vector201
vector201:
  pushl $0
80107c42:	6a 00                	push   $0x0
  pushl $201
80107c44:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80107c49:	e9 e9 f2 ff ff       	jmp    80106f37 <alltraps>

80107c4e <vector202>:
.globl vector202
vector202:
  pushl $0
80107c4e:	6a 00                	push   $0x0
  pushl $202
80107c50:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107c55:	e9 dd f2 ff ff       	jmp    80106f37 <alltraps>

80107c5a <vector203>:
.globl vector203
vector203:
  pushl $0
80107c5a:	6a 00                	push   $0x0
  pushl $203
80107c5c:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107c61:	e9 d1 f2 ff ff       	jmp    80106f37 <alltraps>

80107c66 <vector204>:
.globl vector204
vector204:
  pushl $0
80107c66:	6a 00                	push   $0x0
  pushl $204
80107c68:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80107c6d:	e9 c5 f2 ff ff       	jmp    80106f37 <alltraps>

80107c72 <vector205>:
.globl vector205
vector205:
  pushl $0
80107c72:	6a 00                	push   $0x0
  pushl $205
80107c74:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80107c79:	e9 b9 f2 ff ff       	jmp    80106f37 <alltraps>

80107c7e <vector206>:
.globl vector206
vector206:
  pushl $0
80107c7e:	6a 00                	push   $0x0
  pushl $206
80107c80:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107c85:	e9 ad f2 ff ff       	jmp    80106f37 <alltraps>

80107c8a <vector207>:
.globl vector207
vector207:
  pushl $0
80107c8a:	6a 00                	push   $0x0
  pushl $207
80107c8c:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107c91:	e9 a1 f2 ff ff       	jmp    80106f37 <alltraps>

80107c96 <vector208>:
.globl vector208
vector208:
  pushl $0
80107c96:	6a 00                	push   $0x0
  pushl $208
80107c98:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80107c9d:	e9 95 f2 ff ff       	jmp    80106f37 <alltraps>

80107ca2 <vector209>:
.globl vector209
vector209:
  pushl $0
80107ca2:	6a 00                	push   $0x0
  pushl $209
80107ca4:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80107ca9:	e9 89 f2 ff ff       	jmp    80106f37 <alltraps>

80107cae <vector210>:
.globl vector210
vector210:
  pushl $0
80107cae:	6a 00                	push   $0x0
  pushl $210
80107cb0:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107cb5:	e9 7d f2 ff ff       	jmp    80106f37 <alltraps>

80107cba <vector211>:
.globl vector211
vector211:
  pushl $0
80107cba:	6a 00                	push   $0x0
  pushl $211
80107cbc:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107cc1:	e9 71 f2 ff ff       	jmp    80106f37 <alltraps>

80107cc6 <vector212>:
.globl vector212
vector212:
  pushl $0
80107cc6:	6a 00                	push   $0x0
  pushl $212
80107cc8:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80107ccd:	e9 65 f2 ff ff       	jmp    80106f37 <alltraps>

80107cd2 <vector213>:
.globl vector213
vector213:
  pushl $0
80107cd2:	6a 00                	push   $0x0
  pushl $213
80107cd4:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80107cd9:	e9 59 f2 ff ff       	jmp    80106f37 <alltraps>

80107cde <vector214>:
.globl vector214
vector214:
  pushl $0
80107cde:	6a 00                	push   $0x0
  pushl $214
80107ce0:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107ce5:	e9 4d f2 ff ff       	jmp    80106f37 <alltraps>

80107cea <vector215>:
.globl vector215
vector215:
  pushl $0
80107cea:	6a 00                	push   $0x0
  pushl $215
80107cec:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107cf1:	e9 41 f2 ff ff       	jmp    80106f37 <alltraps>

80107cf6 <vector216>:
.globl vector216
vector216:
  pushl $0
80107cf6:	6a 00                	push   $0x0
  pushl $216
80107cf8:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80107cfd:	e9 35 f2 ff ff       	jmp    80106f37 <alltraps>

80107d02 <vector217>:
.globl vector217
vector217:
  pushl $0
80107d02:	6a 00                	push   $0x0
  pushl $217
80107d04:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80107d09:	e9 29 f2 ff ff       	jmp    80106f37 <alltraps>

80107d0e <vector218>:
.globl vector218
vector218:
  pushl $0
80107d0e:	6a 00                	push   $0x0
  pushl $218
80107d10:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107d15:	e9 1d f2 ff ff       	jmp    80106f37 <alltraps>

80107d1a <vector219>:
.globl vector219
vector219:
  pushl $0
80107d1a:	6a 00                	push   $0x0
  pushl $219
80107d1c:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107d21:	e9 11 f2 ff ff       	jmp    80106f37 <alltraps>

80107d26 <vector220>:
.globl vector220
vector220:
  pushl $0
80107d26:	6a 00                	push   $0x0
  pushl $220
80107d28:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80107d2d:	e9 05 f2 ff ff       	jmp    80106f37 <alltraps>

80107d32 <vector221>:
.globl vector221
vector221:
  pushl $0
80107d32:	6a 00                	push   $0x0
  pushl $221
80107d34:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80107d39:	e9 f9 f1 ff ff       	jmp    80106f37 <alltraps>

80107d3e <vector222>:
.globl vector222
vector222:
  pushl $0
80107d3e:	6a 00                	push   $0x0
  pushl $222
80107d40:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107d45:	e9 ed f1 ff ff       	jmp    80106f37 <alltraps>

80107d4a <vector223>:
.globl vector223
vector223:
  pushl $0
80107d4a:	6a 00                	push   $0x0
  pushl $223
80107d4c:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107d51:	e9 e1 f1 ff ff       	jmp    80106f37 <alltraps>

80107d56 <vector224>:
.globl vector224
vector224:
  pushl $0
80107d56:	6a 00                	push   $0x0
  pushl $224
80107d58:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80107d5d:	e9 d5 f1 ff ff       	jmp    80106f37 <alltraps>

80107d62 <vector225>:
.globl vector225
vector225:
  pushl $0
80107d62:	6a 00                	push   $0x0
  pushl $225
80107d64:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107d69:	e9 c9 f1 ff ff       	jmp    80106f37 <alltraps>

80107d6e <vector226>:
.globl vector226
vector226:
  pushl $0
80107d6e:	6a 00                	push   $0x0
  pushl $226
80107d70:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107d75:	e9 bd f1 ff ff       	jmp    80106f37 <alltraps>

80107d7a <vector227>:
.globl vector227
vector227:
  pushl $0
80107d7a:	6a 00                	push   $0x0
  pushl $227
80107d7c:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107d81:	e9 b1 f1 ff ff       	jmp    80106f37 <alltraps>

80107d86 <vector228>:
.globl vector228
vector228:
  pushl $0
80107d86:	6a 00                	push   $0x0
  pushl $228
80107d88:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80107d8d:	e9 a5 f1 ff ff       	jmp    80106f37 <alltraps>

80107d92 <vector229>:
.globl vector229
vector229:
  pushl $0
80107d92:	6a 00                	push   $0x0
  pushl $229
80107d94:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80107d99:	e9 99 f1 ff ff       	jmp    80106f37 <alltraps>

80107d9e <vector230>:
.globl vector230
vector230:
  pushl $0
80107d9e:	6a 00                	push   $0x0
  pushl $230
80107da0:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107da5:	e9 8d f1 ff ff       	jmp    80106f37 <alltraps>

80107daa <vector231>:
.globl vector231
vector231:
  pushl $0
80107daa:	6a 00                	push   $0x0
  pushl $231
80107dac:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107db1:	e9 81 f1 ff ff       	jmp    80106f37 <alltraps>

80107db6 <vector232>:
.globl vector232
vector232:
  pushl $0
80107db6:	6a 00                	push   $0x0
  pushl $232
80107db8:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107dbd:	e9 75 f1 ff ff       	jmp    80106f37 <alltraps>

80107dc2 <vector233>:
.globl vector233
vector233:
  pushl $0
80107dc2:	6a 00                	push   $0x0
  pushl $233
80107dc4:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107dc9:	e9 69 f1 ff ff       	jmp    80106f37 <alltraps>

80107dce <vector234>:
.globl vector234
vector234:
  pushl $0
80107dce:	6a 00                	push   $0x0
  pushl $234
80107dd0:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107dd5:	e9 5d f1 ff ff       	jmp    80106f37 <alltraps>

80107dda <vector235>:
.globl vector235
vector235:
  pushl $0
80107dda:	6a 00                	push   $0x0
  pushl $235
80107ddc:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107de1:	e9 51 f1 ff ff       	jmp    80106f37 <alltraps>

80107de6 <vector236>:
.globl vector236
vector236:
  pushl $0
80107de6:	6a 00                	push   $0x0
  pushl $236
80107de8:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107ded:	e9 45 f1 ff ff       	jmp    80106f37 <alltraps>

80107df2 <vector237>:
.globl vector237
vector237:
  pushl $0
80107df2:	6a 00                	push   $0x0
  pushl $237
80107df4:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107df9:	e9 39 f1 ff ff       	jmp    80106f37 <alltraps>

80107dfe <vector238>:
.globl vector238
vector238:
  pushl $0
80107dfe:	6a 00                	push   $0x0
  pushl $238
80107e00:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107e05:	e9 2d f1 ff ff       	jmp    80106f37 <alltraps>

80107e0a <vector239>:
.globl vector239
vector239:
  pushl $0
80107e0a:	6a 00                	push   $0x0
  pushl $239
80107e0c:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107e11:	e9 21 f1 ff ff       	jmp    80106f37 <alltraps>

80107e16 <vector240>:
.globl vector240
vector240:
  pushl $0
80107e16:	6a 00                	push   $0x0
  pushl $240
80107e18:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107e1d:	e9 15 f1 ff ff       	jmp    80106f37 <alltraps>

80107e22 <vector241>:
.globl vector241
vector241:
  pushl $0
80107e22:	6a 00                	push   $0x0
  pushl $241
80107e24:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107e29:	e9 09 f1 ff ff       	jmp    80106f37 <alltraps>

80107e2e <vector242>:
.globl vector242
vector242:
  pushl $0
80107e2e:	6a 00                	push   $0x0
  pushl $242
80107e30:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107e35:	e9 fd f0 ff ff       	jmp    80106f37 <alltraps>

80107e3a <vector243>:
.globl vector243
vector243:
  pushl $0
80107e3a:	6a 00                	push   $0x0
  pushl $243
80107e3c:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107e41:	e9 f1 f0 ff ff       	jmp    80106f37 <alltraps>

80107e46 <vector244>:
.globl vector244
vector244:
  pushl $0
80107e46:	6a 00                	push   $0x0
  pushl $244
80107e48:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107e4d:	e9 e5 f0 ff ff       	jmp    80106f37 <alltraps>

80107e52 <vector245>:
.globl vector245
vector245:
  pushl $0
80107e52:	6a 00                	push   $0x0
  pushl $245
80107e54:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107e59:	e9 d9 f0 ff ff       	jmp    80106f37 <alltraps>

80107e5e <vector246>:
.globl vector246
vector246:
  pushl $0
80107e5e:	6a 00                	push   $0x0
  pushl $246
80107e60:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107e65:	e9 cd f0 ff ff       	jmp    80106f37 <alltraps>

80107e6a <vector247>:
.globl vector247
vector247:
  pushl $0
80107e6a:	6a 00                	push   $0x0
  pushl $247
80107e6c:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107e71:	e9 c1 f0 ff ff       	jmp    80106f37 <alltraps>

80107e76 <vector248>:
.globl vector248
vector248:
  pushl $0
80107e76:	6a 00                	push   $0x0
  pushl $248
80107e78:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107e7d:	e9 b5 f0 ff ff       	jmp    80106f37 <alltraps>

80107e82 <vector249>:
.globl vector249
vector249:
  pushl $0
80107e82:	6a 00                	push   $0x0
  pushl $249
80107e84:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107e89:	e9 a9 f0 ff ff       	jmp    80106f37 <alltraps>

80107e8e <vector250>:
.globl vector250
vector250:
  pushl $0
80107e8e:	6a 00                	push   $0x0
  pushl $250
80107e90:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107e95:	e9 9d f0 ff ff       	jmp    80106f37 <alltraps>

80107e9a <vector251>:
.globl vector251
vector251:
  pushl $0
80107e9a:	6a 00                	push   $0x0
  pushl $251
80107e9c:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107ea1:	e9 91 f0 ff ff       	jmp    80106f37 <alltraps>

80107ea6 <vector252>:
.globl vector252
vector252:
  pushl $0
80107ea6:	6a 00                	push   $0x0
  pushl $252
80107ea8:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107ead:	e9 85 f0 ff ff       	jmp    80106f37 <alltraps>

80107eb2 <vector253>:
.globl vector253
vector253:
  pushl $0
80107eb2:	6a 00                	push   $0x0
  pushl $253
80107eb4:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107eb9:	e9 79 f0 ff ff       	jmp    80106f37 <alltraps>

80107ebe <vector254>:
.globl vector254
vector254:
  pushl $0
80107ebe:	6a 00                	push   $0x0
  pushl $254
80107ec0:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107ec5:	e9 6d f0 ff ff       	jmp    80106f37 <alltraps>

80107eca <vector255>:
.globl vector255
vector255:
  pushl $0
80107eca:	6a 00                	push   $0x0
  pushl $255
80107ecc:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107ed1:	e9 61 f0 ff ff       	jmp    80106f37 <alltraps>
80107ed6:	66 90                	xchg   %ax,%ax
80107ed8:	66 90                	xchg   %ax,%ax
80107eda:	66 90                	xchg   %ax,%ax
80107edc:	66 90                	xchg   %ax,%ax
80107ede:	66 90                	xchg   %ax,%ax

80107ee0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107ee0:	55                   	push   %ebp
80107ee1:	89 e5                	mov    %esp,%ebp
80107ee3:	83 ec 28             	sub    $0x28,%esp
80107ee6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107ee9:	89 d3                	mov    %edx,%ebx
80107eeb:	c1 eb 16             	shr    $0x16,%ebx
{
80107eee:	89 75 f8             	mov    %esi,-0x8(%ebp)
  pde = &pgdir[PDX(va)];
80107ef1:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80107ef4:	89 7d fc             	mov    %edi,-0x4(%ebp)
80107ef7:	89 d7                	mov    %edx,%edi
  if(*pde & PTE_P){
80107ef9:	8b 06                	mov    (%esi),%eax
80107efb:	a8 01                	test   $0x1,%al
80107efd:	74 29                	je     80107f28 <walkpgdir+0x48>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107eff:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107f04:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107f0a:	c1 ef 0a             	shr    $0xa,%edi
}
80107f0d:	8b 75 f8             	mov    -0x8(%ebp),%esi
  return &pgtab[PTX(va)];
80107f10:	89 fa                	mov    %edi,%edx
}
80107f12:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return &pgtab[PTX(va)];
80107f15:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107f1b:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80107f1e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107f21:	89 ec                	mov    %ebp,%esp
80107f23:	5d                   	pop    %ebp
80107f24:	c3                   	ret    
80107f25:	8d 76 00             	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107f28:	85 c9                	test   %ecx,%ecx
80107f2a:	74 34                	je     80107f60 <walkpgdir+0x80>
80107f2c:	e8 7f a6 ff ff       	call   801025b0 <kalloc>
80107f31:	85 c0                	test   %eax,%eax
80107f33:	89 c3                	mov    %eax,%ebx
80107f35:	74 29                	je     80107f60 <walkpgdir+0x80>
    memset(pgtab, 0, PGSIZE);
80107f37:	b8 00 10 00 00       	mov    $0x1000,%eax
80107f3c:	31 d2                	xor    %edx,%edx
80107f3e:	89 44 24 08          	mov    %eax,0x8(%esp)
80107f42:	89 54 24 04          	mov    %edx,0x4(%esp)
80107f46:	89 1c 24             	mov    %ebx,(%esp)
80107f49:	e8 f2 dc ff ff       	call   80105c40 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107f4e:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107f54:	83 c8 07             	or     $0x7,%eax
80107f57:	89 06                	mov    %eax,(%esi)
80107f59:	eb af                	jmp    80107f0a <walkpgdir+0x2a>
80107f5b:	90                   	nop
80107f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80107f60:	8b 5d f4             	mov    -0xc(%ebp),%ebx
      return 0;
80107f63:	31 c0                	xor    %eax,%eax
}
80107f65:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107f68:	8b 7d fc             	mov    -0x4(%ebp),%edi
80107f6b:	89 ec                	mov    %ebp,%esp
80107f6d:	5d                   	pop    %ebp
80107f6e:	c3                   	ret    
80107f6f:	90                   	nop

80107f70 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107f70:	55                   	push   %ebp
80107f71:	89 e5                	mov    %esp,%ebp
80107f73:	57                   	push   %edi
80107f74:	56                   	push   %esi
80107f75:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107f76:	89 d3                	mov    %edx,%ebx
{
80107f78:	83 ec 2c             	sub    $0x2c,%esp
  a = (char*)PGROUNDDOWN((uint)va);
80107f7b:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80107f81:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107f84:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107f88:	8b 7d 08             	mov    0x8(%ebp),%edi
80107f8b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107f90:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80107f93:	8b 45 0c             	mov    0xc(%ebp),%eax
80107f96:	29 df                	sub    %ebx,%edi
80107f98:	83 c8 01             	or     $0x1,%eax
80107f9b:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107f9e:	eb 17                	jmp    80107fb7 <mappages+0x47>
    if(*pte & PTE_P)
80107fa0:	f6 00 01             	testb  $0x1,(%eax)
80107fa3:	75 45                	jne    80107fea <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80107fa5:	8b 55 dc             	mov    -0x24(%ebp),%edx
80107fa8:	09 d6                	or     %edx,%esi
    if(a == last)
80107faa:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
80107fad:	89 30                	mov    %esi,(%eax)
    if(a == last)
80107faf:	74 2f                	je     80107fe0 <mappages+0x70>
      break;
    a += PGSIZE;
80107fb1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107fb7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107fba:	b9 01 00 00 00       	mov    $0x1,%ecx
80107fbf:	89 da                	mov    %ebx,%edx
80107fc1:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80107fc4:	e8 17 ff ff ff       	call   80107ee0 <walkpgdir>
80107fc9:	85 c0                	test   %eax,%eax
80107fcb:	75 d3                	jne    80107fa0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80107fcd:	83 c4 2c             	add    $0x2c,%esp
      return -1;
80107fd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107fd5:	5b                   	pop    %ebx
80107fd6:	5e                   	pop    %esi
80107fd7:	5f                   	pop    %edi
80107fd8:	5d                   	pop    %ebp
80107fd9:	c3                   	ret    
80107fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107fe0:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80107fe3:	31 c0                	xor    %eax,%eax
}
80107fe5:	5b                   	pop    %ebx
80107fe6:	5e                   	pop    %esi
80107fe7:	5f                   	pop    %edi
80107fe8:	5d                   	pop    %ebp
80107fe9:	c3                   	ret    
      panic("remap");
80107fea:	c7 04 24 b8 91 10 80 	movl   $0x801091b8,(%esp)
80107ff1:	e8 7a 83 ff ff       	call   80100370 <panic>
80107ff6:	8d 76 00             	lea    0x0(%esi),%esi
80107ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108000 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80108000:	55                   	push   %ebp
80108001:	89 e5                	mov    %esp,%ebp
80108003:	57                   	push   %edi
80108004:	89 c7                	mov    %eax,%edi
80108006:	56                   	push   %esi
80108007:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80108008:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010800e:	83 ec 2c             	sub    $0x2c,%esp
  a = PGROUNDUP(newsz);
80108011:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80108017:	39 d3                	cmp    %edx,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80108019:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010801c:	73 62                	jae    80108080 <deallocuvm.part.0+0x80>
8010801e:	89 d6                	mov    %edx,%esi
80108020:	eb 39                	jmp    8010805b <deallocuvm.part.0+0x5b>
80108022:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80108028:	8b 10                	mov    (%eax),%edx
8010802a:	f6 c2 01             	test   $0x1,%dl
8010802d:	74 22                	je     80108051 <deallocuvm.part.0+0x51>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010802f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80108035:	74 54                	je     8010808b <deallocuvm.part.0+0x8b>
        panic("kfree");
      char *v = P2V(pa);
80108037:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
8010803d:	89 14 24             	mov    %edx,(%esp)
80108040:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108043:	e8 98 a3 ff ff       	call   801023e0 <kfree>
      *pte = 0;
80108048:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010804b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80108051:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80108057:	39 f3                	cmp    %esi,%ebx
80108059:	73 25                	jae    80108080 <deallocuvm.part.0+0x80>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010805b:	31 c9                	xor    %ecx,%ecx
8010805d:	89 da                	mov    %ebx,%edx
8010805f:	89 f8                	mov    %edi,%eax
80108061:	e8 7a fe ff ff       	call   80107ee0 <walkpgdir>
    if(!pte)
80108066:	85 c0                	test   %eax,%eax
80108068:	75 be                	jne    80108028 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010806a:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80108070:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80108076:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010807c:	39 f3                	cmp    %esi,%ebx
8010807e:	72 db                	jb     8010805b <deallocuvm.part.0+0x5b>
    }
  }
  return newsz;
}
80108080:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108083:	83 c4 2c             	add    $0x2c,%esp
80108086:	5b                   	pop    %ebx
80108087:	5e                   	pop    %esi
80108088:	5f                   	pop    %edi
80108089:	5d                   	pop    %ebp
8010808a:	c3                   	ret    
        panic("kfree");
8010808b:	c7 04 24 a6 8a 10 80 	movl   $0x80108aa6,(%esp)
80108092:	e8 d9 82 ff ff       	call   80100370 <panic>
80108097:	89 f6                	mov    %esi,%esi
80108099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801080a0 <seginit>:
{
801080a0:	55                   	push   %ebp
801080a1:	89 e5                	mov    %esp,%ebp
801080a3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
801080a6:	e8 e5 b9 ff ff       	call   80103a90 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801080ab:	b9 00 9a cf 00       	mov    $0xcf9a00,%ecx
  pd[0] = size-1;
801080b0:	66 c7 45 f2 2f 00    	movw   $0x2f,-0xe(%ebp)
801080b6:	8d 14 80             	lea    (%eax,%eax,4),%edx
801080b9:	8d 04 50             	lea    (%eax,%edx,2),%eax
801080bc:	ba ff ff 00 00       	mov    $0xffff,%edx
801080c1:	c1 e0 04             	shl    $0x4,%eax
801080c4:	89 90 58 48 11 80    	mov    %edx,-0x7feeb7a8(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801080ca:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801080cf:	89 88 5c 48 11 80    	mov    %ecx,-0x7feeb7a4(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801080d5:	b9 00 92 cf 00       	mov    $0xcf9200,%ecx
801080da:	89 90 60 48 11 80    	mov    %edx,-0x7feeb7a0(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801080e0:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801080e5:	89 88 64 48 11 80    	mov    %ecx,-0x7feeb79c(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801080eb:	b9 00 fa cf 00       	mov    $0xcffa00,%ecx
801080f0:	89 90 68 48 11 80    	mov    %edx,-0x7feeb798(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801080f6:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801080fb:	89 88 6c 48 11 80    	mov    %ecx,-0x7feeb794(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80108101:	b9 00 f2 cf 00       	mov    $0xcff200,%ecx
80108106:	89 90 70 48 11 80    	mov    %edx,-0x7feeb790(%eax)
8010810c:	89 88 74 48 11 80    	mov    %ecx,-0x7feeb78c(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80108112:	05 50 48 11 80       	add    $0x80114850,%eax
  pd[1] = (uint)p;
80108117:	0f b7 d0             	movzwl %ax,%edx
  pd[2] = (uint)p >> 16;
8010811a:	c1 e8 10             	shr    $0x10,%eax
  pd[1] = (uint)p;
8010811d:	66 89 55 f4          	mov    %dx,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80108121:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80108125:	8d 45 f2             	lea    -0xe(%ebp),%eax
80108128:	0f 01 10             	lgdtl  (%eax)
}
8010812b:	c9                   	leave  
8010812c:	c3                   	ret    
8010812d:	8d 76 00             	lea    0x0(%esi),%esi

80108130 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108130:	a1 04 80 11 80       	mov    0x80118004,%eax
{
80108135:	55                   	push   %ebp
80108136:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108138:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010813d:	0f 22 d8             	mov    %eax,%cr3
}
80108140:	5d                   	pop    %ebp
80108141:	c3                   	ret    
80108142:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108150 <switchuvm>:
{
80108150:	55                   	push   %ebp
80108151:	89 e5                	mov    %esp,%ebp
80108153:	57                   	push   %edi
80108154:	56                   	push   %esi
80108155:	53                   	push   %ebx
80108156:	83 ec 2c             	sub    $0x2c,%esp
80108159:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
8010815c:	85 db                	test   %ebx,%ebx
8010815e:	0f 84 c5 00 00 00    	je     80108229 <switchuvm+0xd9>
  if(p->kstack == 0)
80108164:	8b 7b 08             	mov    0x8(%ebx),%edi
80108167:	85 ff                	test   %edi,%edi
80108169:	0f 84 d2 00 00 00    	je     80108241 <switchuvm+0xf1>
  if(p->pgdir == 0)
8010816f:	8b 73 04             	mov    0x4(%ebx),%esi
80108172:	85 f6                	test   %esi,%esi
80108174:	0f 84 bb 00 00 00    	je     80108235 <switchuvm+0xe5>
  pushcli();
8010817a:	e8 f1 d8 ff ff       	call   80105a70 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010817f:	e8 8c b8 ff ff       	call   80103a10 <mycpu>
80108184:	89 c6                	mov    %eax,%esi
80108186:	e8 85 b8 ff ff       	call   80103a10 <mycpu>
8010818b:	89 c7                	mov    %eax,%edi
8010818d:	e8 7e b8 ff ff       	call   80103a10 <mycpu>
80108192:	83 c7 08             	add    $0x8,%edi
80108195:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108198:	e8 73 b8 ff ff       	call   80103a10 <mycpu>
8010819d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801081a0:	ba 67 00 00 00       	mov    $0x67,%edx
801081a5:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
801081ac:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
801081b3:	83 c1 08             	add    $0x8,%ecx
801081b6:	c1 e9 10             	shr    $0x10,%ecx
801081b9:	83 c0 08             	add    $0x8,%eax
801081bc:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
801081c2:	c1 e8 18             	shr    $0x18,%eax
801081c5:	b9 99 40 00 00       	mov    $0x4099,%ecx
801081ca:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
801081d1:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->gdt[SEG_TSS].s = 0;
801081d7:	e8 34 b8 ff ff       	call   80103a10 <mycpu>
801081dc:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801081e3:	e8 28 b8 ff ff       	call   80103a10 <mycpu>
801081e8:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801081ee:	8b 73 08             	mov    0x8(%ebx),%esi
801081f1:	e8 1a b8 ff ff       	call   80103a10 <mycpu>
801081f6:	81 c6 00 10 00 00    	add    $0x1000,%esi
801081fc:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801081ff:	e8 0c b8 ff ff       	call   80103a10 <mycpu>
80108204:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
8010820a:	b8 28 00 00 00       	mov    $0x28,%eax
8010820f:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80108212:	8b 43 04             	mov    0x4(%ebx),%eax
80108215:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010821a:	0f 22 d8             	mov    %eax,%cr3
}
8010821d:	83 c4 2c             	add    $0x2c,%esp
80108220:	5b                   	pop    %ebx
80108221:	5e                   	pop    %esi
80108222:	5f                   	pop    %edi
80108223:	5d                   	pop    %ebp
  popcli();
80108224:	e9 87 d8 ff ff       	jmp    80105ab0 <popcli>
    panic("switchuvm: no process");
80108229:	c7 04 24 be 91 10 80 	movl   $0x801091be,(%esp)
80108230:	e8 3b 81 ff ff       	call   80100370 <panic>
    panic("switchuvm: no pgdir");
80108235:	c7 04 24 e9 91 10 80 	movl   $0x801091e9,(%esp)
8010823c:	e8 2f 81 ff ff       	call   80100370 <panic>
    panic("switchuvm: no kstack");
80108241:	c7 04 24 d4 91 10 80 	movl   $0x801091d4,(%esp)
80108248:	e8 23 81 ff ff       	call   80100370 <panic>
8010824d:	8d 76 00             	lea    0x0(%esi),%esi

80108250 <inituvm>:
{
80108250:	55                   	push   %ebp
80108251:	89 e5                	mov    %esp,%ebp
80108253:	83 ec 38             	sub    $0x38,%esp
80108256:	89 75 f8             	mov    %esi,-0x8(%ebp)
80108259:	8b 75 10             	mov    0x10(%ebp),%esi
8010825c:	8b 45 08             	mov    0x8(%ebp),%eax
8010825f:	89 7d fc             	mov    %edi,-0x4(%ebp)
80108262:	8b 7d 0c             	mov    0xc(%ebp),%edi
80108265:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  if(sz >= PGSIZE)
80108268:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
8010826e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80108271:	77 59                	ja     801082cc <inituvm+0x7c>
  mem = kalloc();
80108273:	e8 38 a3 ff ff       	call   801025b0 <kalloc>
  memset(mem, 0, PGSIZE);
80108278:	31 d2                	xor    %edx,%edx
8010827a:	89 54 24 04          	mov    %edx,0x4(%esp)
  mem = kalloc();
8010827e:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80108280:	b8 00 10 00 00       	mov    $0x1000,%eax
80108285:	89 1c 24             	mov    %ebx,(%esp)
80108288:	89 44 24 08          	mov    %eax,0x8(%esp)
8010828c:	e8 af d9 ff ff       	call   80105c40 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80108291:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80108297:	b9 06 00 00 00       	mov    $0x6,%ecx
8010829c:	89 04 24             	mov    %eax,(%esp)
8010829f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801082a2:	31 d2                	xor    %edx,%edx
801082a4:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801082a8:	b9 00 10 00 00       	mov    $0x1000,%ecx
801082ad:	e8 be fc ff ff       	call   80107f70 <mappages>
  memmove(mem, init, sz);
801082b2:	89 75 10             	mov    %esi,0x10(%ebp)
}
801082b5:	8b 75 f8             	mov    -0x8(%ebp),%esi
  memmove(mem, init, sz);
801082b8:	89 7d 0c             	mov    %edi,0xc(%ebp)
}
801082bb:	8b 7d fc             	mov    -0x4(%ebp),%edi
  memmove(mem, init, sz);
801082be:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801082c1:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801082c4:	89 ec                	mov    %ebp,%esp
801082c6:	5d                   	pop    %ebp
  memmove(mem, init, sz);
801082c7:	e9 34 da ff ff       	jmp    80105d00 <memmove>
    panic("inituvm: more than a page");
801082cc:	c7 04 24 fd 91 10 80 	movl   $0x801091fd,(%esp)
801082d3:	e8 98 80 ff ff       	call   80100370 <panic>
801082d8:	90                   	nop
801082d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801082e0 <loaduvm>:
{
801082e0:	55                   	push   %ebp
801082e1:	89 e5                	mov    %esp,%ebp
801082e3:	57                   	push   %edi
801082e4:	56                   	push   %esi
801082e5:	53                   	push   %ebx
801082e6:	83 ec 1c             	sub    $0x1c,%esp
  if((uint) addr % PGSIZE != 0)
801082e9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
801082f0:	0f 85 98 00 00 00    	jne    8010838e <loaduvm+0xae>
  for(i = 0; i < sz; i += PGSIZE){
801082f6:	8b 75 18             	mov    0x18(%ebp),%esi
801082f9:	31 db                	xor    %ebx,%ebx
801082fb:	85 f6                	test   %esi,%esi
801082fd:	75 1a                	jne    80108319 <loaduvm+0x39>
801082ff:	eb 77                	jmp    80108378 <loaduvm+0x98>
80108301:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108308:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010830e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80108314:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80108317:	76 5f                	jbe    80108378 <loaduvm+0x98>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80108319:	8b 55 0c             	mov    0xc(%ebp),%edx
8010831c:	31 c9                	xor    %ecx,%ecx
8010831e:	8b 45 08             	mov    0x8(%ebp),%eax
80108321:	01 da                	add    %ebx,%edx
80108323:	e8 b8 fb ff ff       	call   80107ee0 <walkpgdir>
80108328:	85 c0                	test   %eax,%eax
8010832a:	74 56                	je     80108382 <loaduvm+0xa2>
    pa = PTE_ADDR(*pte);
8010832c:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
8010832e:	bf 00 10 00 00       	mov    $0x1000,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80108333:	8b 4d 14             	mov    0x14(%ebp),%ecx
    pa = PTE_ADDR(*pte);
80108336:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
8010833b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80108341:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80108344:	05 00 00 00 80       	add    $0x80000000,%eax
80108349:	89 44 24 04          	mov    %eax,0x4(%esp)
8010834d:	8b 45 10             	mov    0x10(%ebp),%eax
80108350:	01 d9                	add    %ebx,%ecx
80108352:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80108356:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010835a:	89 04 24             	mov    %eax,(%esp)
8010835d:	e8 6e 96 ff ff       	call   801019d0 <readi>
80108362:	39 f8                	cmp    %edi,%eax
80108364:	74 a2                	je     80108308 <loaduvm+0x28>
}
80108366:	83 c4 1c             	add    $0x1c,%esp
      return -1;
80108369:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010836e:	5b                   	pop    %ebx
8010836f:	5e                   	pop    %esi
80108370:	5f                   	pop    %edi
80108371:	5d                   	pop    %ebp
80108372:	c3                   	ret    
80108373:	90                   	nop
80108374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108378:	83 c4 1c             	add    $0x1c,%esp
  return 0;
8010837b:	31 c0                	xor    %eax,%eax
}
8010837d:	5b                   	pop    %ebx
8010837e:	5e                   	pop    %esi
8010837f:	5f                   	pop    %edi
80108380:	5d                   	pop    %ebp
80108381:	c3                   	ret    
      panic("loaduvm: address should exist");
80108382:	c7 04 24 17 92 10 80 	movl   $0x80109217,(%esp)
80108389:	e8 e2 7f ff ff       	call   80100370 <panic>
    panic("loaduvm: addr must be page aligned");
8010838e:	c7 04 24 b8 92 10 80 	movl   $0x801092b8,(%esp)
80108395:	e8 d6 7f ff ff       	call   80100370 <panic>
8010839a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801083a0 <allocuvm>:
{
801083a0:	55                   	push   %ebp
801083a1:	89 e5                	mov    %esp,%ebp
801083a3:	57                   	push   %edi
801083a4:	56                   	push   %esi
801083a5:	53                   	push   %ebx
801083a6:	83 ec 2c             	sub    $0x2c,%esp
  if(newsz >= KERNBASE)
801083a9:	8b 7d 10             	mov    0x10(%ebp),%edi
801083ac:	85 ff                	test   %edi,%edi
801083ae:	0f 88 91 00 00 00    	js     80108445 <allocuvm+0xa5>
  if(newsz < oldsz)
801083b4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801083b7:	0f 82 9b 00 00 00    	jb     80108458 <allocuvm+0xb8>
  a = PGROUNDUP(oldsz);
801083bd:	8b 45 0c             	mov    0xc(%ebp),%eax
801083c0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801083c6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
801083cc:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801083cf:	0f 86 86 00 00 00    	jbe    8010845b <allocuvm+0xbb>
801083d5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801083d8:	8b 7d 08             	mov    0x8(%ebp),%edi
801083db:	eb 49                	jmp    80108426 <allocuvm+0x86>
801083dd:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
801083e0:	31 d2                	xor    %edx,%edx
801083e2:	b8 00 10 00 00       	mov    $0x1000,%eax
801083e7:	89 54 24 04          	mov    %edx,0x4(%esp)
801083eb:	89 44 24 08          	mov    %eax,0x8(%esp)
801083ef:	89 34 24             	mov    %esi,(%esp)
801083f2:	e8 49 d8 ff ff       	call   80105c40 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801083f7:	b9 06 00 00 00       	mov    $0x6,%ecx
801083fc:	89 da                	mov    %ebx,%edx
801083fe:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80108404:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80108408:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010840d:	89 04 24             	mov    %eax,(%esp)
80108410:	89 f8                	mov    %edi,%eax
80108412:	e8 59 fb ff ff       	call   80107f70 <mappages>
80108417:	85 c0                	test   %eax,%eax
80108419:	78 4d                	js     80108468 <allocuvm+0xc8>
  for(; a < newsz; a += PGSIZE){
8010841b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80108421:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80108424:	76 7a                	jbe    801084a0 <allocuvm+0x100>
    mem = kalloc();
80108426:	e8 85 a1 ff ff       	call   801025b0 <kalloc>
    if(mem == 0){
8010842b:	85 c0                	test   %eax,%eax
    mem = kalloc();
8010842d:	89 c6                	mov    %eax,%esi
    if(mem == 0){
8010842f:	75 af                	jne    801083e0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80108431:	c7 04 24 35 92 10 80 	movl   $0x80109235,(%esp)
80108438:	e8 13 82 ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
8010843d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108440:	39 45 10             	cmp    %eax,0x10(%ebp)
80108443:	77 6b                	ja     801084b0 <allocuvm+0x110>
}
80108445:	83 c4 2c             	add    $0x2c,%esp
    return 0;
80108448:	31 ff                	xor    %edi,%edi
}
8010844a:	5b                   	pop    %ebx
8010844b:	89 f8                	mov    %edi,%eax
8010844d:	5e                   	pop    %esi
8010844e:	5f                   	pop    %edi
8010844f:	5d                   	pop    %ebp
80108450:	c3                   	ret    
80108451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80108458:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
8010845b:	83 c4 2c             	add    $0x2c,%esp
8010845e:	89 f8                	mov    %edi,%eax
80108460:	5b                   	pop    %ebx
80108461:	5e                   	pop    %esi
80108462:	5f                   	pop    %edi
80108463:	5d                   	pop    %ebp
80108464:	c3                   	ret    
80108465:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80108468:	c7 04 24 4d 92 10 80 	movl   $0x8010924d,(%esp)
8010846f:	e8 dc 81 ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
80108474:	8b 45 0c             	mov    0xc(%ebp),%eax
80108477:	39 45 10             	cmp    %eax,0x10(%ebp)
8010847a:	76 0d                	jbe    80108489 <allocuvm+0xe9>
8010847c:	89 c1                	mov    %eax,%ecx
8010847e:	8b 55 10             	mov    0x10(%ebp),%edx
80108481:	8b 45 08             	mov    0x8(%ebp),%eax
80108484:	e8 77 fb ff ff       	call   80108000 <deallocuvm.part.0>
      kfree(mem);
80108489:	89 34 24             	mov    %esi,(%esp)
      return 0;
8010848c:	31 ff                	xor    %edi,%edi
      kfree(mem);
8010848e:	e8 4d 9f ff ff       	call   801023e0 <kfree>
}
80108493:	83 c4 2c             	add    $0x2c,%esp
80108496:	89 f8                	mov    %edi,%eax
80108498:	5b                   	pop    %ebx
80108499:	5e                   	pop    %esi
8010849a:	5f                   	pop    %edi
8010849b:	5d                   	pop    %ebp
8010849c:	c3                   	ret    
8010849d:	8d 76 00             	lea    0x0(%esi),%esi
801084a0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801084a3:	83 c4 2c             	add    $0x2c,%esp
801084a6:	5b                   	pop    %ebx
801084a7:	5e                   	pop    %esi
801084a8:	89 f8                	mov    %edi,%eax
801084aa:	5f                   	pop    %edi
801084ab:	5d                   	pop    %ebp
801084ac:	c3                   	ret    
801084ad:	8d 76 00             	lea    0x0(%esi),%esi
801084b0:	89 c1                	mov    %eax,%ecx
801084b2:	8b 55 10             	mov    0x10(%ebp),%edx
      return 0;
801084b5:	31 ff                	xor    %edi,%edi
801084b7:	8b 45 08             	mov    0x8(%ebp),%eax
801084ba:	e8 41 fb ff ff       	call   80108000 <deallocuvm.part.0>
801084bf:	eb 9a                	jmp    8010845b <allocuvm+0xbb>
801084c1:	eb 0d                	jmp    801084d0 <deallocuvm>
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

801084d0 <deallocuvm>:
{
801084d0:	55                   	push   %ebp
801084d1:	89 e5                	mov    %esp,%ebp
801084d3:	8b 55 0c             	mov    0xc(%ebp),%edx
801084d6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801084d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801084dc:	39 d1                	cmp    %edx,%ecx
801084de:	73 10                	jae    801084f0 <deallocuvm+0x20>
}
801084e0:	5d                   	pop    %ebp
801084e1:	e9 1a fb ff ff       	jmp    80108000 <deallocuvm.part.0>
801084e6:	8d 76 00             	lea    0x0(%esi),%esi
801084e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801084f0:	89 d0                	mov    %edx,%eax
801084f2:	5d                   	pop    %ebp
801084f3:	c3                   	ret    
801084f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801084fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80108500 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80108500:	55                   	push   %ebp
80108501:	89 e5                	mov    %esp,%ebp
80108503:	57                   	push   %edi
80108504:	56                   	push   %esi
80108505:	53                   	push   %ebx
80108506:	83 ec 1c             	sub    $0x1c,%esp
80108509:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010850c:	85 f6                	test   %esi,%esi
8010850e:	74 55                	je     80108565 <freevm+0x65>
80108510:	31 c9                	xor    %ecx,%ecx
80108512:	ba 00 00 00 80       	mov    $0x80000000,%edx
80108517:	89 f0                	mov    %esi,%eax
80108519:	89 f3                	mov    %esi,%ebx
8010851b:	e8 e0 fa ff ff       	call   80108000 <deallocuvm.part.0>
80108520:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80108526:	eb 0f                	jmp    80108537 <freevm+0x37>
80108528:	90                   	nop
80108529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108530:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80108533:	39 fb                	cmp    %edi,%ebx
80108535:	74 1f                	je     80108556 <freevm+0x56>
    if(pgdir[i] & PTE_P){
80108537:	8b 03                	mov    (%ebx),%eax
80108539:	a8 01                	test   $0x1,%al
8010853b:	74 f3                	je     80108530 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010853d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108542:	83 c3 04             	add    $0x4,%ebx
80108545:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010854a:	89 04 24             	mov    %eax,(%esp)
8010854d:	e8 8e 9e ff ff       	call   801023e0 <kfree>
  for(i = 0; i < NPDENTRIES; i++){
80108552:	39 fb                	cmp    %edi,%ebx
80108554:	75 e1                	jne    80108537 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80108556:	89 75 08             	mov    %esi,0x8(%ebp)
}
80108559:	83 c4 1c             	add    $0x1c,%esp
8010855c:	5b                   	pop    %ebx
8010855d:	5e                   	pop    %esi
8010855e:	5f                   	pop    %edi
8010855f:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80108560:	e9 7b 9e ff ff       	jmp    801023e0 <kfree>
    panic("freevm: no pgdir");
80108565:	c7 04 24 69 92 10 80 	movl   $0x80109269,(%esp)
8010856c:	e8 ff 7d ff ff       	call   80100370 <panic>
80108571:	eb 0d                	jmp    80108580 <setupkvm>
80108573:	90                   	nop
80108574:	90                   	nop
80108575:	90                   	nop
80108576:	90                   	nop
80108577:	90                   	nop
80108578:	90                   	nop
80108579:	90                   	nop
8010857a:	90                   	nop
8010857b:	90                   	nop
8010857c:	90                   	nop
8010857d:	90                   	nop
8010857e:	90                   	nop
8010857f:	90                   	nop

80108580 <setupkvm>:
{
80108580:	55                   	push   %ebp
80108581:	89 e5                	mov    %esp,%ebp
80108583:	56                   	push   %esi
80108584:	53                   	push   %ebx
80108585:	83 ec 10             	sub    $0x10,%esp
  if((pgdir = (pde_t*)kalloc()) == 0)
80108588:	e8 23 a0 ff ff       	call   801025b0 <kalloc>
8010858d:	85 c0                	test   %eax,%eax
8010858f:	89 c6                	mov    %eax,%esi
80108591:	74 46                	je     801085d9 <setupkvm+0x59>
  memset(pgdir, 0, PGSIZE);
80108593:	b8 00 10 00 00       	mov    $0x1000,%eax
80108598:	31 d2                	xor    %edx,%edx
8010859a:	89 44 24 08          	mov    %eax,0x8(%esp)
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010859e:	bb 20 c4 10 80       	mov    $0x8010c420,%ebx
  memset(pgdir, 0, PGSIZE);
801085a3:	89 54 24 04          	mov    %edx,0x4(%esp)
801085a7:	89 34 24             	mov    %esi,(%esp)
801085aa:	e8 91 d6 ff ff       	call   80105c40 <memset>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801085af:	8b 53 0c             	mov    0xc(%ebx),%edx
                (uint)k->phys_start, k->perm) < 0) {
801085b2:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801085b5:	8b 4b 08             	mov    0x8(%ebx),%ecx
801085b8:	89 54 24 04          	mov    %edx,0x4(%esp)
801085bc:	8b 13                	mov    (%ebx),%edx
801085be:	89 04 24             	mov    %eax,(%esp)
801085c1:	29 c1                	sub    %eax,%ecx
801085c3:	89 f0                	mov    %esi,%eax
801085c5:	e8 a6 f9 ff ff       	call   80107f70 <mappages>
801085ca:	85 c0                	test   %eax,%eax
801085cc:	78 1a                	js     801085e8 <setupkvm+0x68>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801085ce:	83 c3 10             	add    $0x10,%ebx
801085d1:	81 fb 60 c4 10 80    	cmp    $0x8010c460,%ebx
801085d7:	75 d6                	jne    801085af <setupkvm+0x2f>
}
801085d9:	83 c4 10             	add    $0x10,%esp
801085dc:	89 f0                	mov    %esi,%eax
801085de:	5b                   	pop    %ebx
801085df:	5e                   	pop    %esi
801085e0:	5d                   	pop    %ebp
801085e1:	c3                   	ret    
801085e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      freevm(pgdir);
801085e8:	89 34 24             	mov    %esi,(%esp)
      return 0;
801085eb:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
801085ed:	e8 0e ff ff ff       	call   80108500 <freevm>
}
801085f2:	83 c4 10             	add    $0x10,%esp
801085f5:	89 f0                	mov    %esi,%eax
801085f7:	5b                   	pop    %ebx
801085f8:	5e                   	pop    %esi
801085f9:	5d                   	pop    %ebp
801085fa:	c3                   	ret    
801085fb:	90                   	nop
801085fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80108600 <kvmalloc>:
{
80108600:	55                   	push   %ebp
80108601:	89 e5                	mov    %esp,%ebp
80108603:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80108606:	e8 75 ff ff ff       	call   80108580 <setupkvm>
8010860b:	a3 04 80 11 80       	mov    %eax,0x80118004
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108610:	05 00 00 00 80       	add    $0x80000000,%eax
80108615:	0f 22 d8             	mov    %eax,%cr3
}
80108618:	c9                   	leave  
80108619:	c3                   	ret    
8010861a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108620 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108620:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108621:	31 c9                	xor    %ecx,%ecx
{
80108623:	89 e5                	mov    %esp,%ebp
80108625:	83 ec 18             	sub    $0x18,%esp
  pte = walkpgdir(pgdir, uva, 0);
80108628:	8b 55 0c             	mov    0xc(%ebp),%edx
8010862b:	8b 45 08             	mov    0x8(%ebp),%eax
8010862e:	e8 ad f8 ff ff       	call   80107ee0 <walkpgdir>
  if(pte == 0)
80108633:	85 c0                	test   %eax,%eax
80108635:	74 05                	je     8010863c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80108637:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010863a:	c9                   	leave  
8010863b:	c3                   	ret    
    panic("clearpteu");
8010863c:	c7 04 24 7a 92 10 80 	movl   $0x8010927a,(%esp)
80108643:	e8 28 7d ff ff       	call   80100370 <panic>
80108648:	90                   	nop
80108649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108650 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80108650:	55                   	push   %ebp
80108651:	89 e5                	mov    %esp,%ebp
80108653:	57                   	push   %edi
80108654:	56                   	push   %esi
80108655:	53                   	push   %ebx
80108656:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80108659:	e8 22 ff ff ff       	call   80108580 <setupkvm>
8010865e:	85 c0                	test   %eax,%eax
80108660:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108663:	0f 84 a3 00 00 00    	je     8010870c <copyuvm+0xbc>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108669:	8b 55 0c             	mov    0xc(%ebp),%edx
8010866c:	85 d2                	test   %edx,%edx
8010866e:	0f 84 98 00 00 00    	je     8010870c <copyuvm+0xbc>
80108674:	31 ff                	xor    %edi,%edi
80108676:	eb 50                	jmp    801086c8 <copyuvm+0x78>
80108678:	90                   	nop
80108679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80108680:	b8 00 10 00 00       	mov    $0x1000,%eax
80108685:	89 44 24 08          	mov    %eax,0x8(%esp)
80108689:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010868c:	89 34 24             	mov    %esi,(%esp)
8010868f:	05 00 00 00 80       	add    $0x80000000,%eax
80108694:	89 44 24 04          	mov    %eax,0x4(%esp)
80108698:	e8 63 d6 ff ff       	call   80105d00 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
8010869d:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801086a3:	b9 00 10 00 00       	mov    $0x1000,%ecx
801086a8:	89 04 24             	mov    %eax,(%esp)
801086ab:	8b 45 e0             	mov    -0x20(%ebp),%eax
801086ae:	89 fa                	mov    %edi,%edx
801086b0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801086b4:	e8 b7 f8 ff ff       	call   80107f70 <mappages>
801086b9:	85 c0                	test   %eax,%eax
801086bb:	78 63                	js     80108720 <copyuvm+0xd0>
  for(i = 0; i < sz; i += PGSIZE){
801086bd:	81 c7 00 10 00 00    	add    $0x1000,%edi
801086c3:	39 7d 0c             	cmp    %edi,0xc(%ebp)
801086c6:	76 44                	jbe    8010870c <copyuvm+0xbc>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801086c8:	8b 45 08             	mov    0x8(%ebp),%eax
801086cb:	31 c9                	xor    %ecx,%ecx
801086cd:	89 fa                	mov    %edi,%edx
801086cf:	e8 0c f8 ff ff       	call   80107ee0 <walkpgdir>
801086d4:	85 c0                	test   %eax,%eax
801086d6:	74 5e                	je     80108736 <copyuvm+0xe6>
    if(!(*pte & PTE_P))
801086d8:	8b 18                	mov    (%eax),%ebx
801086da:	f6 c3 01             	test   $0x1,%bl
801086dd:	74 4b                	je     8010872a <copyuvm+0xda>
    pa = PTE_ADDR(*pte);
801086df:	89 d8                	mov    %ebx,%eax
    flags = PTE_FLAGS(*pte);
801086e1:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
801086e7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801086ec:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
801086ef:	e8 bc 9e ff ff       	call   801025b0 <kalloc>
801086f4:	85 c0                	test   %eax,%eax
801086f6:	89 c6                	mov    %eax,%esi
801086f8:	75 86                	jne    80108680 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
801086fa:	8b 45 e0             	mov    -0x20(%ebp),%eax
801086fd:	89 04 24             	mov    %eax,(%esp)
80108700:	e8 fb fd ff ff       	call   80108500 <freevm>
  return 0;
80108705:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
8010870c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010870f:	83 c4 2c             	add    $0x2c,%esp
80108712:	5b                   	pop    %ebx
80108713:	5e                   	pop    %esi
80108714:	5f                   	pop    %edi
80108715:	5d                   	pop    %ebp
80108716:	c3                   	ret    
80108717:	89 f6                	mov    %esi,%esi
80108719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      kfree(mem);
80108720:	89 34 24             	mov    %esi,(%esp)
80108723:	e8 b8 9c ff ff       	call   801023e0 <kfree>
      goto bad;
80108728:	eb d0                	jmp    801086fa <copyuvm+0xaa>
      panic("copyuvm: page not present");
8010872a:	c7 04 24 9e 92 10 80 	movl   $0x8010929e,(%esp)
80108731:	e8 3a 7c ff ff       	call   80100370 <panic>
      panic("copyuvm: pte should exist");
80108736:	c7 04 24 84 92 10 80 	movl   $0x80109284,(%esp)
8010873d:	e8 2e 7c ff ff       	call   80100370 <panic>
80108742:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108750 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108750:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108751:	31 c9                	xor    %ecx,%ecx
{
80108753:	89 e5                	mov    %esp,%ebp
80108755:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80108758:	8b 55 0c             	mov    0xc(%ebp),%edx
8010875b:	8b 45 08             	mov    0x8(%ebp),%eax
8010875e:	e8 7d f7 ff ff       	call   80107ee0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80108763:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80108765:	89 c2                	mov    %eax,%edx
80108767:	83 e2 05             	and    $0x5,%edx
8010876a:	83 fa 05             	cmp    $0x5,%edx
8010876d:	75 11                	jne    80108780 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
8010876f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108774:	05 00 00 00 80       	add    $0x80000000,%eax
}
80108779:	c9                   	leave  
8010877a:	c3                   	ret    
8010877b:	90                   	nop
8010877c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80108780:	31 c0                	xor    %eax,%eax
}
80108782:	c9                   	leave  
80108783:	c3                   	ret    
80108784:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010878a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80108790 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108790:	55                   	push   %ebp
80108791:	89 e5                	mov    %esp,%ebp
80108793:	57                   	push   %edi
80108794:	56                   	push   %esi
80108795:	53                   	push   %ebx
80108796:	83 ec 2c             	sub    $0x2c,%esp
80108799:	8b 75 14             	mov    0x14(%ebp),%esi
8010879c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
8010879f:	85 f6                	test   %esi,%esi
801087a1:	74 75                	je     80108818 <copyout+0x88>
801087a3:	89 da                	mov    %ebx,%edx
801087a5:	eb 3f                	jmp    801087e6 <copyout+0x56>
801087a7:	89 f6                	mov    %esi,%esi
801087a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801087b0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801087b3:	89 df                	mov    %ebx,%edi
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801087b5:	8b 4d 10             	mov    0x10(%ebp),%ecx
    n = PGSIZE - (va - va0);
801087b8:	29 d7                	sub    %edx,%edi
801087ba:	81 c7 00 10 00 00    	add    $0x1000,%edi
801087c0:	39 f7                	cmp    %esi,%edi
801087c2:	0f 47 fe             	cmova  %esi,%edi
    memmove(pa0 + (va - va0), buf, n);
801087c5:	29 da                	sub    %ebx,%edx
801087c7:	01 c2                	add    %eax,%edx
801087c9:	89 14 24             	mov    %edx,(%esp)
801087cc:	89 7c 24 08          	mov    %edi,0x8(%esp)
801087d0:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801087d4:	e8 27 d5 ff ff       	call   80105d00 <memmove>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
801087d9:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    buf += n;
801087df:	01 7d 10             	add    %edi,0x10(%ebp)
  while(len > 0){
801087e2:	29 fe                	sub    %edi,%esi
801087e4:	74 32                	je     80108818 <copyout+0x88>
    pa0 = uva2ka(pgdir, (char*)va0);
801087e6:	8b 45 08             	mov    0x8(%ebp),%eax
    va0 = (uint)PGROUNDDOWN(va);
801087e9:	89 d3                	mov    %edx,%ebx
801087eb:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    pa0 = uva2ka(pgdir, (char*)va0);
801087f1:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    va0 = (uint)PGROUNDDOWN(va);
801087f5:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
801087f8:	89 04 24             	mov    %eax,(%esp)
801087fb:	e8 50 ff ff ff       	call   80108750 <uva2ka>
    if(pa0 == 0)
80108800:	85 c0                	test   %eax,%eax
80108802:	75 ac                	jne    801087b0 <copyout+0x20>
  }
  return 0;
}
80108804:	83 c4 2c             	add    $0x2c,%esp
      return -1;
80108807:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010880c:	5b                   	pop    %ebx
8010880d:	5e                   	pop    %esi
8010880e:	5f                   	pop    %edi
8010880f:	5d                   	pop    %ebp
80108810:	c3                   	ret    
80108811:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108818:	83 c4 2c             	add    $0x2c,%esp
  return 0;
8010881b:	31 c0                	xor    %eax,%eax
}
8010881d:	5b                   	pop    %ebx
8010881e:	5e                   	pop    %esi
8010881f:	5f                   	pop    %edi
80108820:	5d                   	pop    %ebp
80108821:	c3                   	ret    
