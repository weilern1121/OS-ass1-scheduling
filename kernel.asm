
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
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
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
80100028:	bc 20 c6 10 80       	mov    $0x8010c620,%esp

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
80100041:	ba e0 84 10 80       	mov    $0x801084e0,%edx
{
80100046:	89 e5                	mov    %esp,%ebp
80100048:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
80100049:	bb 1c 0d 11 80       	mov    $0x80110d1c,%ebx
{
8010004e:	83 ec 14             	sub    $0x14,%esp
  initlock(&bcache.lock, "bcache");
80100051:	89 54 24 04          	mov    %edx,0x4(%esp)
80100055:	c7 04 24 20 c6 10 80 	movl   $0x8010c620,(%esp)
8010005c:	e8 bf 56 00 00       	call   80105720 <initlock>
  bcache.head.prev = &bcache.head;
80100061:	b9 1c 0d 11 80       	mov    $0x80110d1c,%ecx
  bcache.head.next = &bcache.head;
80100066:	ba 1c 0d 11 80       	mov    $0x80110d1c,%edx
8010006b:	89 1d 70 0d 11 80    	mov    %ebx,0x80110d70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100071:	bb 54 c6 10 80       	mov    $0x8010c654,%ebx
  bcache.head.prev = &bcache.head;
80100076:	89 0d 6c 0d 11 80    	mov    %ecx,0x80110d6c
8010007c:	eb 04                	jmp    80100082 <binit+0x42>
8010007e:	66 90                	xchg   %ax,%ax
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	b8 e7 84 10 80       	mov    $0x801084e7,%eax
    b->next = bcache.head.next;
80100087:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008a:	c7 43 50 1c 0d 11 80 	movl   $0x80110d1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100091:	89 44 24 04          	mov    %eax,0x4(%esp)
80100095:	8d 43 0c             	lea    0xc(%ebx),%eax
80100098:	89 04 24             	mov    %eax,(%esp)
8010009b:	e8 50 55 00 00       	call   801055f0 <initsleeplock>
    bcache.head.next->prev = b;
801000a0:	a1 70 0d 11 80       	mov    0x80110d70,%eax
801000a5:	89 da                	mov    %ebx,%edx
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
801000b0:	3d 1c 0d 11 80       	cmp    $0x80110d1c,%eax
    bcache.head.next = b;
801000b5:	89 1d 70 0d 11 80    	mov    %ebx,0x80110d70
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
801000d9:	c7 04 24 20 c6 10 80 	movl   $0x8010c620,(%esp)
{
801000e0:	8b 75 08             	mov    0x8(%ebp),%esi
801000e3:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000e6:	e8 85 57 00 00       	call   80105870 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000eb:	8b 1d 70 0d 11 80    	mov    0x80110d70,%ebx
801000f1:	81 fb 1c 0d 11 80    	cmp    $0x80110d1c,%ebx
801000f7:	75 12                	jne    8010010b <bread+0x3b>
801000f9:	eb 25                	jmp    80100120 <bread+0x50>
801000fb:	90                   	nop
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c 0d 11 80    	cmp    $0x80110d1c,%ebx
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
80100120:	8b 1d 6c 0d 11 80    	mov    0x80110d6c,%ebx
80100126:	81 fb 1c 0d 11 80    	cmp    $0x80110d1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 58                	jmp    80100188 <bread+0xb8>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c 0d 11 80    	cmp    $0x80110d1c,%ebx
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
8010015a:	c7 04 24 20 c6 10 80 	movl   $0x8010c620,(%esp)
80100161:	e8 aa 57 00 00       	call   80105910 <release>
      acquiresleep(&b->lock);
80100166:	8d 43 0c             	lea    0xc(%ebx),%eax
80100169:	89 04 24             	mov    %eax,(%esp)
8010016c:	e8 bf 54 00 00       	call   80105630 <acquiresleep>
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
80100188:	c7 04 24 ee 84 10 80 	movl   $0x801084ee,(%esp)
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
801001b0:	e8 1b 55 00 00       	call   801056d0 <holdingsleep>
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
801001c9:	c7 04 24 ff 84 10 80 	movl   $0x801084ff,(%esp)
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
801001f1:	e8 da 54 00 00       	call   801056d0 <holdingsleep>
801001f6:	85 c0                	test   %eax,%eax
801001f8:	74 5a                	je     80100254 <brelse+0x74>
    panic("brelse");

  releasesleep(&b->lock);
801001fa:	89 34 24             	mov    %esi,(%esp)
801001fd:	e8 8e 54 00 00       	call   80105690 <releasesleep>

  acquire(&bcache.lock);
80100202:	c7 04 24 20 c6 10 80 	movl   $0x8010c620,(%esp)
80100209:	e8 62 56 00 00       	call   80105870 <acquire>
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
80100225:	a1 70 0d 11 80       	mov    0x80110d70,%eax
    b->prev = &bcache.head;
8010022a:	c7 43 50 1c 0d 11 80 	movl   $0x80110d1c,0x50(%ebx)
    b->next = bcache.head.next;
80100231:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100234:	a1 70 0d 11 80       	mov    0x80110d70,%eax
80100239:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010023c:	89 1d 70 0d 11 80    	mov    %ebx,0x80110d70
  }
  
  release(&bcache.lock);
80100242:	c7 45 08 20 c6 10 80 	movl   $0x8010c620,0x8(%ebp)
}
80100249:	83 c4 10             	add    $0x10,%esp
8010024c:	5b                   	pop    %ebx
8010024d:	5e                   	pop    %esi
8010024e:	5d                   	pop    %ebp
  release(&bcache.lock);
8010024f:	e9 bc 56 00 00       	jmp    80105910 <release>
    panic("brelse");
80100254:	c7 04 24 06 85 10 80 	movl   $0x80108506,(%esp)
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
80100277:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010027e:	e8 ed 55 00 00       	call   80105870 <acquire>
  while(n > 0){
80100283:	31 c0                	xor    %eax,%eax
80100285:	85 f6                	test   %esi,%esi
80100287:	0f 8e a3 00 00 00    	jle    80100330 <consoleread+0xd0>
8010028d:	89 f3                	mov    %esi,%ebx
8010028f:	89 75 10             	mov    %esi,0x10(%ebp)
80100292:	8b 75 0c             	mov    0xc(%ebp),%esi
    while(input.r == input.w){
80100295:	8b 15 00 10 11 80    	mov    0x80111000,%edx
8010029b:	39 15 04 10 11 80    	cmp    %edx,0x80111004
801002a1:	74 28                	je     801002cb <consoleread+0x6b>
801002a3:	eb 5b                	jmp    80100300 <consoleread+0xa0>
801002a5:	8d 76 00             	lea    0x0(%esi),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002a8:	b8 20 b5 10 80       	mov    $0x8010b520,%eax
801002ad:	89 44 24 04          	mov    %eax,0x4(%esp)
801002b1:	c7 04 24 00 10 11 80 	movl   $0x80111000,(%esp)
801002b8:	e8 73 40 00 00       	call   80104330 <sleep>
    while(input.r == input.w){
801002bd:	8b 15 00 10 11 80    	mov    0x80111000,%edx
801002c3:	3b 15 04 10 11 80    	cmp    0x80111004,%edx
801002c9:	75 35                	jne    80100300 <consoleread+0xa0>
      if(myproc()->killed){
801002cb:	e8 50 37 00 00       	call   80103a20 <myproc>
801002d0:	8b 50 24             	mov    0x24(%eax),%edx
801002d3:	85 d2                	test   %edx,%edx
801002d5:	74 d1                	je     801002a8 <consoleread+0x48>
        release(&cons.lock);
801002d7:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
801002de:	e8 2d 56 00 00       	call   80105910 <release>
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
80100303:	a3 00 10 11 80       	mov    %eax,0x80111000
80100308:	89 d0                	mov    %edx,%eax
8010030a:	83 e0 7f             	and    $0x7f,%eax
8010030d:	0f be 80 80 0f 11 80 	movsbl -0x7feef080(%eax),%eax
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
80100330:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
80100337:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010033a:	e8 d1 55 00 00       	call   80105910 <release>
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
8010035d:	89 15 00 10 11 80    	mov    %edx,0x80111000
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
8010037b:	89 15 54 b5 10 80    	mov    %edx,0x8010b554
  getcallerpcs(&s, pcs);
80100381:	8d 5d d0             	lea    -0x30(%ebp),%ebx
  cprintf("lapicid %d: panic: ", lapicid());
80100384:	e8 a7 24 00 00       	call   80102830 <lapicid>
80100389:	8d 75 f8             	lea    -0x8(%ebp),%esi
8010038c:	c7 04 24 0d 85 10 80 	movl   $0x8010850d,(%esp)
80100393:	89 44 24 04          	mov    %eax,0x4(%esp)
80100397:	e8 b4 02 00 00       	call   80100650 <cprintf>
  cprintf(s);
8010039c:	8b 45 08             	mov    0x8(%ebp),%eax
8010039f:	89 04 24             	mov    %eax,(%esp)
801003a2:	e8 a9 02 00 00       	call   80100650 <cprintf>
  cprintf("\n");
801003a7:	c7 04 24 b9 8b 10 80 	movl   $0x80108bb9,(%esp)
801003ae:	e8 9d 02 00 00       	call   80100650 <cprintf>
  getcallerpcs(&s, pcs);
801003b3:	8d 45 08             	lea    0x8(%ebp),%eax
801003b6:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801003ba:	89 04 24             	mov    %eax,(%esp)
801003bd:	e8 7e 53 00 00       	call   80105740 <getcallerpcs>
801003c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    cprintf(" %p", pcs[i]);
801003d0:	8b 03                	mov    (%ebx),%eax
801003d2:	83 c3 04             	add    $0x4,%ebx
801003d5:	c7 04 24 21 85 10 80 	movl   $0x80108521,(%esp)
801003dc:	89 44 24 04          	mov    %eax,0x4(%esp)
801003e0:	e8 6b 02 00 00       	call   80100650 <cprintf>
  for(i=0; i<10; i++)
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x60>
  panicked = 1; // freeze other CPU
801003e9:	b8 01 00 00 00       	mov    $0x1,%eax
801003ee:	a3 58 b5 10 80       	mov    %eax,0x8010b558
801003f3:	eb fe                	jmp    801003f3 <panic+0x83>
801003f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801003f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100400 <consputc>:
  if(panicked){
80100400:	8b 15 58 b5 10 80    	mov    0x8010b558,%edx
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
80100429:	e8 92 6c 00 00       	call   801070c0 <uartputc>
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
801004cc:	e8 ef 6b 00 00       	call   801070c0 <uartputc>
801004d1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004d8:	e8 e3 6b 00 00       	call   801070c0 <uartputc>
801004dd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004e4:	e8 d7 6b 00 00       	call   801070c0 <uartputc>
801004e9:	e9 40 ff ff ff       	jmp    8010042e <consputc+0x2e>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004ee:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
801004f5:	00 
801004f6:	c7 44 24 04 a0 80 0b 	movl   $0x800b80a0,0x4(%esp)
801004fd:	80 
801004fe:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
80100505:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80100508:	e8 13 55 00 00       	call   80105a20 <memmove>
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
80100536:	e8 25 54 00 00       	call   80105960 <memset>
8010053b:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010053e:	e9 4c ff ff ff       	jmp    8010048f <consputc+0x8f>
    panic("pos under/overflow");
80100543:	c7 04 24 25 85 10 80 	movl   $0x80108525,(%esp)
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
801005a1:	0f b6 92 50 85 10 80 	movzbl -0x7fef7ab0(%edx),%edx
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
80100607:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010060e:	e8 5d 52 00 00       	call   80105870 <acquire>
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
8010062d:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
80100634:	e8 d7 52 00 00       	call   80105910 <release>
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
80100659:	a1 54 b5 10 80       	mov    0x8010b554,%eax
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
80100707:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010070e:	e8 fd 51 00 00       	call   80105910 <release>
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
80100774:	bf 38 85 10 80       	mov    $0x80108538,%edi
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
801007b0:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
801007b7:	e8 b4 50 00 00       	call   80105870 <acquire>
801007bc:	e9 a8 fe ff ff       	jmp    80100669 <cprintf+0x19>
    panic("null fmt");
801007c1:	c7 04 24 3f 85 10 80 	movl   $0x8010853f,(%esp)
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
801007da:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
{
801007e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
801007e4:	e8 87 50 00 00       	call   80105870 <acquire>
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
80100812:	a1 08 10 11 80       	mov    0x80111008,%eax
80100817:	3b 05 04 10 11 80    	cmp    0x80111004,%eax
8010081d:	74 d1                	je     801007f0 <consoleintr+0x20>
        input.e--;
8010081f:	48                   	dec    %eax
80100820:	a3 08 10 11 80       	mov    %eax,0x80111008
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
80100840:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
80100847:	e8 c4 50 00 00       	call   80105910 <release>
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
80100869:	a1 08 10 11 80       	mov    0x80111008,%eax
8010086e:	89 c1                	mov    %eax,%ecx
80100870:	2b 0d 00 10 11 80    	sub    0x80111000,%ecx
80100876:	83 f9 7f             	cmp    $0x7f,%ecx
80100879:	0f 87 71 ff ff ff    	ja     801007f0 <consoleintr+0x20>
8010087f:	8d 48 01             	lea    0x1(%eax),%ecx
80100882:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
80100885:	83 fa 0d             	cmp    $0xd,%edx
        input.buf[input.e++ % INPUT_BUF] = c;
80100888:	89 0d 08 10 11 80    	mov    %ecx,0x80111008
        c = (c == '\r') ? '\n' : c;
8010088e:	0f 84 c4 00 00 00    	je     80100958 <consoleintr+0x188>
        input.buf[input.e++ % INPUT_BUF] = c;
80100894:	88 90 80 0f 11 80    	mov    %dl,-0x7feef080(%eax)
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
801008b9:	a1 00 10 11 80       	mov    0x80111000,%eax
801008be:	83 e8 80             	sub    $0xffffff80,%eax
801008c1:	39 05 08 10 11 80    	cmp    %eax,0x80111008
801008c7:	0f 85 23 ff ff ff    	jne    801007f0 <consoleintr+0x20>
          wakeup(&input.r);
801008cd:	c7 04 24 00 10 11 80 	movl   $0x80111000,(%esp)
          input.w = input.e;
801008d4:	a3 04 10 11 80       	mov    %eax,0x80111004
          wakeup(&input.r);
801008d9:	e8 42 3c 00 00       	call   80104520 <wakeup>
801008de:	e9 0d ff ff ff       	jmp    801007f0 <consoleintr+0x20>
801008e3:	90                   	nop
801008e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
801008e8:	be 01 00 00 00       	mov    $0x1,%esi
801008ed:	e9 fe fe ff ff       	jmp    801007f0 <consoleintr+0x20>
801008f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
801008f8:	a1 08 10 11 80       	mov    0x80111008,%eax
801008fd:	39 05 04 10 11 80    	cmp    %eax,0x80111004
80100903:	75 2b                	jne    80100930 <consoleintr+0x160>
80100905:	e9 e6 fe ff ff       	jmp    801007f0 <consoleintr+0x20>
8010090a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100910:	a3 08 10 11 80       	mov    %eax,0x80111008
        consputc(BACKSPACE);
80100915:	b8 00 01 00 00       	mov    $0x100,%eax
8010091a:	e8 e1 fa ff ff       	call   80100400 <consputc>
      while(input.e != input.w &&
8010091f:	a1 08 10 11 80       	mov    0x80111008,%eax
80100924:	3b 05 04 10 11 80    	cmp    0x80111004,%eax
8010092a:	0f 84 c0 fe ff ff    	je     801007f0 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100930:	48                   	dec    %eax
80100931:	89 c2                	mov    %eax,%edx
80100933:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100936:	80 ba 80 0f 11 80 0a 	cmpb   $0xa,-0x7feef080(%edx)
8010093d:	75 d1                	jne    80100910 <consoleintr+0x140>
8010093f:	e9 ac fe ff ff       	jmp    801007f0 <consoleintr+0x20>
80100944:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80100948:	83 c4 20             	add    $0x20,%esp
8010094b:	5b                   	pop    %ebx
8010094c:	5e                   	pop    %esi
8010094d:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
8010094e:	e9 9d 3c 00 00       	jmp    801045f0 <procdump>
80100953:	90                   	nop
80100954:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
80100958:	c6 80 80 0f 11 80 0a 	movb   $0xa,-0x7feef080(%eax)
        consputc(c);
8010095f:	b8 0a 00 00 00       	mov    $0xa,%eax
80100964:	e8 97 fa ff ff       	call   80100400 <consputc>
80100969:	a1 08 10 11 80       	mov    0x80111008,%eax
8010096e:	e9 5a ff ff ff       	jmp    801008cd <consoleintr+0xfd>
80100973:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100980 <consoleinit>:

void
consoleinit(void)
{
80100980:	55                   	push   %ebp
  initlock(&cons.lock, "console");
80100981:	b8 48 85 10 80       	mov    $0x80108548,%eax
{
80100986:	89 e5                	mov    %esp,%ebp
80100988:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
8010098b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010098f:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
80100996:	e8 85 4d 00 00       	call   80105720 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;
8010099b:	b8 01 00 00 00       	mov    $0x1,%eax
  devsw[CONSOLE].write = consolewrite;
801009a0:	ba f0 05 10 80       	mov    $0x801005f0,%edx
  cons.locking = 1;
801009a5:	a3 54 b5 10 80       	mov    %eax,0x8010b554

  ioapicenable(IRQ_KBD, 0);
801009aa:	31 c0                	xor    %eax,%eax
  devsw[CONSOLE].read = consoleread;
801009ac:	b9 60 02 10 80       	mov    $0x80100260,%ecx
  ioapicenable(IRQ_KBD, 0);
801009b1:	89 44 24 04          	mov    %eax,0x4(%esp)
801009b5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  devsw[CONSOLE].write = consolewrite;
801009bc:	89 15 cc 19 11 80    	mov    %edx,0x801119cc
  devsw[CONSOLE].read = consoleread;
801009c2:	89 0d c8 19 11 80    	mov    %ecx,0x801119c8
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
80100a5c:	e8 bf 77 00 00       	call   80108220 <setupkvm>
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
80100ac8:	e8 73 75 00 00       	call   80108040 <allocuvm>
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
80100b05:	e8 76 74 00 00       	call   80107f80 <loaduvm>
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
80100b58:	e8 43 76 00 00       	call   801081a0 <freevm>
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
80100b92:	e8 a9 74 00 00       	call   80108040 <allocuvm>
80100b97:	85 c0                	test   %eax,%eax
80100b99:	89 c6                	mov    %eax,%esi
80100b9b:	75 33                	jne    80100bd0 <exec+0x200>
    freevm(pgdir);
80100b9d:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ba3:	89 04 24             	mov    %eax,(%esp)
80100ba6:	e8 f5 75 00 00       	call   801081a0 <freevm>
  return -1;
80100bab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bb0:	e9 8c fe ff ff       	jmp    80100a41 <exec+0x71>
    end_op();
80100bb5:	e8 46 21 00 00       	call   80102d00 <end_op>
    cprintf("exec: fail\n");
80100bba:	c7 04 24 61 85 10 80 	movl   $0x80108561,(%esp)
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
80100be7:	e8 d4 76 00 00       	call   801082c0 <clearpteu>
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
80100c18:	e8 63 4f 00 00       	call   80105b80 <strlen>
80100c1d:	f7 d0                	not    %eax
80100c1f:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c21:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c24:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c27:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c2a:	89 04 24             	mov    %eax,(%esp)
80100c2d:	e8 4e 4f 00 00       	call   80105b80 <strlen>
80100c32:	40                   	inc    %eax
80100c33:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c37:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c3a:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c3d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100c41:	89 34 24             	mov    %esi,(%esp)
80100c44:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c48:	e8 e3 77 00 00       	call   80108430 <copyout>
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
80100cb8:	e8 73 77 00 00       	call   80108430 <copyout>
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
80100d01:	e8 3a 4e 00 00       	call   80105b40 <safestrcpy>
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
80100d2b:	e8 c0 70 00 00       	call   80107df0 <switchuvm>
  freevm(oldpgdir);
80100d30:	89 3c 24             	mov    %edi,(%esp)
80100d33:	e8 68 74 00 00       	call   801081a0 <freevm>
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
80100d51:	b8 6d 85 10 80       	mov    $0x8010856d,%eax
{
80100d56:	89 e5                	mov    %esp,%ebp
80100d58:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100d5b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100d5f:	c7 04 24 20 10 11 80 	movl   $0x80111020,(%esp)
80100d66:	e8 b5 49 00 00       	call   80105720 <initlock>
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
80100d74:	bb 54 10 11 80       	mov    $0x80111054,%ebx
{
80100d79:	83 ec 14             	sub    $0x14,%esp
  acquire(&ftable.lock);
80100d7c:	c7 04 24 20 10 11 80 	movl   $0x80111020,(%esp)
80100d83:	e8 e8 4a 00 00       	call   80105870 <acquire>
80100d88:	eb 11                	jmp    80100d9b <filealloc+0x2b>
80100d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d90:	83 c3 18             	add    $0x18,%ebx
80100d93:	81 fb b4 19 11 80    	cmp    $0x801119b4,%ebx
80100d99:	73 25                	jae    80100dc0 <filealloc+0x50>
    if(f->ref == 0){
80100d9b:	8b 43 04             	mov    0x4(%ebx),%eax
80100d9e:	85 c0                	test   %eax,%eax
80100da0:	75 ee                	jne    80100d90 <filealloc+0x20>
      f->ref = 1;
80100da2:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100da9:	c7 04 24 20 10 11 80 	movl   $0x80111020,(%esp)
80100db0:	e8 5b 4b 00 00       	call   80105910 <release>
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
80100dc0:	c7 04 24 20 10 11 80 	movl   $0x80111020,(%esp)
  return 0;
80100dc7:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100dc9:	e8 42 4b 00 00       	call   80105910 <release>
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
80100dea:	c7 04 24 20 10 11 80 	movl   $0x80111020,(%esp)
80100df1:	e8 7a 4a 00 00       	call   80105870 <acquire>
  if(f->ref < 1)
80100df6:	8b 43 04             	mov    0x4(%ebx),%eax
80100df9:	85 c0                	test   %eax,%eax
80100dfb:	7e 18                	jle    80100e15 <filedup+0x35>
    panic("filedup");
  f->ref++;
80100dfd:	40                   	inc    %eax
80100dfe:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e01:	c7 04 24 20 10 11 80 	movl   $0x80111020,(%esp)
80100e08:	e8 03 4b 00 00       	call   80105910 <release>
  return f;
}
80100e0d:	83 c4 14             	add    $0x14,%esp
80100e10:	89 d8                	mov    %ebx,%eax
80100e12:	5b                   	pop    %ebx
80100e13:	5d                   	pop    %ebp
80100e14:	c3                   	ret    
    panic("filedup");
80100e15:	c7 04 24 74 85 10 80 	movl   $0x80108574,(%esp)
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
80100e3c:	c7 04 24 20 10 11 80 	movl   $0x80111020,(%esp)
{
80100e43:	89 75 f8             	mov    %esi,-0x8(%ebp)
80100e46:	89 7d fc             	mov    %edi,-0x4(%ebp)
  acquire(&ftable.lock);
80100e49:	e8 22 4a 00 00       	call   80105870 <acquire>
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
80100e61:	c7 45 08 20 10 11 80 	movl   $0x80111020,0x8(%ebp)
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
80100e74:	e9 97 4a 00 00       	jmp    80105910 <release>
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
80100e95:	c7 04 24 20 10 11 80 	movl   $0x80111020,(%esp)
  ff = *f;
80100e9c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100e9f:	e8 6c 4a 00 00       	call   80105910 <release>
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
80100ef9:	c7 04 24 7c 85 10 80 	movl   $0x8010857c,(%esp)
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
80100ff7:	c7 04 24 86 85 10 80 	movl   $0x80108586,(%esp)
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
80101112:	c7 04 24 8f 85 10 80 	movl   $0x8010858f,(%esp)
80101119:	e8 52 f2 ff ff       	call   80100370 <panic>
  panic("filewrite");
8010111e:	c7 04 24 95 85 10 80 	movl   $0x80108595,(%esp)
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
80101139:	8b 35 20 1a 11 80    	mov    0x80111a20,%esi
{
8010113f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101142:	85 f6                	test   %esi,%esi
80101144:	0f 84 7e 00 00 00    	je     801011c8 <balloc+0x98>
8010114a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101151:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101154:	8b 1d 38 1a 11 80    	mov    0x80111a38,%ebx
8010115a:	89 f0                	mov    %esi,%eax
8010115c:	c1 f8 0c             	sar    $0xc,%eax
8010115f:	01 d8                	add    %ebx,%eax
80101161:	89 44 24 04          	mov    %eax,0x4(%esp)
80101165:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101168:	89 04 24             	mov    %eax,(%esp)
8010116b:	e8 60 ef ff ff       	call   801000d0 <bread>
80101170:	89 c3                	mov    %eax,%ebx
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101172:	a1 20 1a 11 80       	mov    0x80111a20,%eax
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
801011c0:	39 05 20 1a 11 80    	cmp    %eax,0x80111a20
801011c6:	77 89                	ja     80101151 <balloc+0x21>
  }
  panic("balloc: out of blocks");
801011c8:	c7 04 24 9f 85 10 80 	movl   $0x8010859f,(%esp)
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
80101218:	e8 43 47 00 00       	call   80105960 <memset>
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
8010124a:	bb 74 1a 11 80       	mov    $0x80111a74,%ebx
{
8010124f:	83 ec 2c             	sub    $0x2c,%esp
  acquire(&icache.lock);
80101252:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
{
80101259:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
8010125c:	e8 0f 46 00 00       	call   80105870 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101261:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101264:	eb 18                	jmp    8010127e <iget+0x3e>
80101266:	8d 76 00             	lea    0x0(%esi),%esi
80101269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101270:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101276:	81 fb 94 36 11 80    	cmp    $0x80113694,%ebx
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
80101298:	81 fb 94 36 11 80    	cmp    $0x80113694,%ebx
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
801012b7:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
801012be:	e8 4d 46 00 00       	call   80105910 <release>

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
801012d8:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
      ip->ref++;
801012df:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801012e2:	e8 29 46 00 00       	call   80105910 <release>
}
801012e7:	83 c4 2c             	add    $0x2c,%esp
801012ea:	89 f0                	mov    %esi,%eax
801012ec:	5b                   	pop    %ebx
801012ed:	5e                   	pop    %esi
801012ee:	5f                   	pop    %edi
801012ef:	5d                   	pop    %ebp
801012f0:	c3                   	ret    
    panic("iget: no inodes");
801012f1:	c7 04 24 b5 85 10 80 	movl   $0x801085b5,(%esp)
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
801013c1:	c7 04 24 c5 85 10 80 	movl   $0x801085c5,(%esp)
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
80101408:	e8 13 46 00 00       	call   80105a20 <memmove>
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
8010142c:	ba 20 1a 11 80       	mov    $0x80111a20,%edx
80101431:	89 54 24 04          	mov    %edx,0x4(%esp)
80101435:	89 04 24             	mov    %eax,(%esp)
80101438:	e8 93 ff ff ff       	call   801013d0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
8010143d:	8b 0d 38 1a 11 80    	mov    0x80111a38,%ecx
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
80101497:	c7 04 24 d8 85 10 80 	movl   $0x801085d8,(%esp)
8010149e:	e8 cd ee ff ff       	call   80100370 <panic>
801014a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801014a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801014b0 <iinit>:
{
801014b0:	55                   	push   %ebp
  initlock(&icache.lock, "icache");
801014b1:	b9 eb 85 10 80       	mov    $0x801085eb,%ecx
{
801014b6:	89 e5                	mov    %esp,%ebp
801014b8:	53                   	push   %ebx
801014b9:	bb 80 1a 11 80       	mov    $0x80111a80,%ebx
801014be:	83 ec 24             	sub    $0x24,%esp
  initlock(&icache.lock, "icache");
801014c1:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801014c5:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
801014cc:	e8 4f 42 00 00       	call   80105720 <initlock>
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
801014e0:	ba f2 85 10 80       	mov    $0x801085f2,%edx
801014e5:	89 1c 24             	mov    %ebx,(%esp)
801014e8:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014ee:	89 54 24 04          	mov    %edx,0x4(%esp)
801014f2:	e8 f9 40 00 00       	call   801055f0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014f7:	81 fb a0 36 11 80    	cmp    $0x801136a0,%ebx
801014fd:	75 e1                	jne    801014e0 <iinit+0x30>
  readsb(dev, &sb);
801014ff:	b8 20 1a 11 80       	mov    $0x80111a20,%eax
80101504:	89 44 24 04          	mov    %eax,0x4(%esp)
80101508:	8b 45 08             	mov    0x8(%ebp),%eax
8010150b:	89 04 24             	mov    %eax,(%esp)
8010150e:	e8 bd fe ff ff       	call   801013d0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101513:	a1 38 1a 11 80       	mov    0x80111a38,%eax
80101518:	c7 04 24 58 86 10 80 	movl   $0x80108658,(%esp)
8010151f:	89 44 24 1c          	mov    %eax,0x1c(%esp)
80101523:	a1 34 1a 11 80       	mov    0x80111a34,%eax
80101528:	89 44 24 18          	mov    %eax,0x18(%esp)
8010152c:	a1 30 1a 11 80       	mov    0x80111a30,%eax
80101531:	89 44 24 14          	mov    %eax,0x14(%esp)
80101535:	a1 2c 1a 11 80       	mov    0x80111a2c,%eax
8010153a:	89 44 24 10          	mov    %eax,0x10(%esp)
8010153e:	a1 28 1a 11 80       	mov    0x80111a28,%eax
80101543:	89 44 24 0c          	mov    %eax,0xc(%esp)
80101547:	a1 24 1a 11 80       	mov    0x80111a24,%eax
8010154c:	89 44 24 08          	mov    %eax,0x8(%esp)
80101550:	a1 20 1a 11 80       	mov    0x80111a20,%eax
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
8010157d:	83 3d 28 1a 11 80 01 	cmpl   $0x1,0x80111a28
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
801015a9:	39 1d 28 1a 11 80    	cmp    %ebx,0x80111a28
801015af:	76 70                	jbe    80101621 <ialloc+0xb1>
    bp = bread(dev, IBLOCK(inum, sb));
801015b1:	8b 0d 34 1a 11 80    	mov    0x80111a34,%ecx
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
801015f3:	e8 68 43 00 00       	call   80105960 <memset>
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
80101621:	c7 04 24 f8 85 10 80 	movl   $0x801085f8,(%esp)
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
8010163b:	8b 15 34 1a 11 80    	mov    0x80111a34,%edx
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
801016a2:	e8 79 43 00 00       	call   80105a20 <memmove>
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
801016ca:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
801016d1:	e8 9a 41 00 00       	call   80105870 <acquire>
  ip->ref++;
801016d6:	ff 43 08             	incl   0x8(%ebx)
  release(&icache.lock);
801016d9:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
801016e0:	e8 2b 42 00 00       	call   80105910 <release>
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
80101714:	e8 17 3f 00 00       	call   80105630 <acquiresleep>
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
80101733:	8b 15 34 1a 11 80    	mov    0x80111a34,%edx
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
80101796:	e8 85 42 00 00       	call   80105a20 <memmove>
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
801017b5:	c7 04 24 10 86 10 80 	movl   $0x80108610,(%esp)
801017bc:	e8 af eb ff ff       	call   80100370 <panic>
    panic("ilock");
801017c1:	c7 04 24 0a 86 10 80 	movl   $0x8010860a,(%esp)
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
801017e9:	e8 e2 3e 00 00       	call   801056d0 <holdingsleep>
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
80101805:	e9 86 3e 00 00       	jmp    80105690 <releasesleep>
    panic("iunlock");
8010180a:	c7 04 24 1f 86 10 80 	movl   $0x8010861f,(%esp)
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
80101838:	e8 f3 3d 00 00       	call   80105630 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
8010183d:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101840:	85 d2                	test   %edx,%edx
80101842:	74 07                	je     8010184b <iput+0x2b>
80101844:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101849:	74 35                	je     80101880 <iput+0x60>
  releasesleep(&ip->lock);
8010184b:	89 3c 24             	mov    %edi,(%esp)
8010184e:	e8 3d 3e 00 00       	call   80105690 <releasesleep>
  acquire(&icache.lock);
80101853:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
8010185a:	e8 11 40 00 00       	call   80105870 <acquire>
  ip->ref--;
8010185f:	ff 4b 08             	decl   0x8(%ebx)
  release(&icache.lock);
80101862:	c7 45 08 40 1a 11 80 	movl   $0x80111a40,0x8(%ebp)
}
80101869:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010186c:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010186f:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101872:	89 ec                	mov    %ebp,%esp
80101874:	5d                   	pop    %ebp
  release(&icache.lock);
80101875:	e9 96 40 00 00       	jmp    80105910 <release>
8010187a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101880:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
80101887:	e8 e4 3f 00 00       	call   80105870 <acquire>
    int r = ip->ref;
8010188c:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
8010188f:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
80101896:	e8 75 40 00 00       	call   80105910 <release>
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
80101a83:	e8 98 3f 00 00       	call   80105a20 <memmove>
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
80101aca:	8b 04 c5 c0 19 11 80 	mov    -0x7feee640(,%eax,8),%eax
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
80101baf:	e8 6c 3e 00 00       	call   80105a20 <memmove>
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
80101bfa:	8b 04 c5 c4 19 11 80 	mov    -0x7feee63c(,%eax,8),%eax
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
80101c5c:	e8 1f 3e 00 00       	call   80105a80 <strncmp>
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
80101cdb:	e8 a0 3d 00 00       	call   80105a80 <strncmp>
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
80101d1f:	c7 04 24 39 86 10 80 	movl   $0x80108639,(%esp)
80101d26:	e8 45 e6 ff ff       	call   80100370 <panic>
    panic("dirlookup not DIR");
80101d2b:	c7 04 24 27 86 10 80 	movl   $0x80108627,(%esp)
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
80101d61:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
80101d68:	e8 03 3b 00 00       	call   80105870 <acquire>
  ip->ref++;
80101d6d:	ff 46 08             	incl   0x8(%esi)
  release(&icache.lock);
80101d70:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
80101d77:	e8 94 3b 00 00       	call   80105910 <release>
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
80101ddc:	e8 3f 3c 00 00       	call   80105a20 <memmove>
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
80101e65:	e8 b6 3b 00 00       	call   80105a20 <memmove>
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
80101f73:	e8 68 3b 00 00       	call   80105ae0 <strncpy>
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
80101fb6:	c7 04 24 48 86 10 80 	movl   $0x80108648,(%esp)
80101fbd:	e8 ae e3 ff ff       	call   80100370 <panic>
    panic("dirlink");
80101fc2:	c7 04 24 a2 8c 10 80 	movl   $0x80108ca2,(%esp)
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
801020bc:	c7 04 24 b4 86 10 80 	movl   $0x801086b4,(%esp)
801020c3:	e8 a8 e2 ff ff       	call   80100370 <panic>
    panic("idestart");
801020c8:	c7 04 24 ab 86 10 80 	movl   $0x801086ab,(%esp)
801020cf:	e8 9c e2 ff ff       	call   80100370 <panic>
801020d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801020da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801020e0 <ideinit>:
{
801020e0:	55                   	push   %ebp
  initlock(&idelock, "ide");
801020e1:	ba c6 86 10 80       	mov    $0x801086c6,%edx
{
801020e6:	89 e5                	mov    %esp,%ebp
801020e8:	83 ec 18             	sub    $0x18,%esp
  initlock(&idelock, "ide");
801020eb:	89 54 24 04          	mov    %edx,0x4(%esp)
801020ef:	c7 04 24 80 b5 10 80 	movl   $0x8010b580,(%esp)
801020f6:	e8 25 36 00 00       	call   80105720 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801020fb:	a1 60 3d 11 80       	mov    0x80113d60,%eax
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
8010214d:	a3 60 b5 10 80       	mov    %eax,0x8010b560
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
80102166:	c7 04 24 80 b5 10 80 	movl   $0x8010b580,(%esp)
{
8010216d:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80102170:	89 75 f8             	mov    %esi,-0x8(%ebp)
80102173:	89 7d fc             	mov    %edi,-0x4(%ebp)
  acquire(&idelock);
80102176:	e8 f5 36 00 00       	call   80105870 <acquire>

  if((b = idequeue) == 0){
8010217b:	8b 1d 64 b5 10 80    	mov    0x8010b564,%ebx
80102181:	85 db                	test   %ebx,%ebx
80102183:	74 5c                	je     801021e1 <ideintr+0x81>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102185:	8b 43 58             	mov    0x58(%ebx),%eax
80102188:	a3 64 b5 10 80       	mov    %eax,0x8010b564

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
801021ce:	e8 4d 23 00 00       	call   80104520 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801021d3:	a1 64 b5 10 80       	mov    0x8010b564,%eax
801021d8:	85 c0                	test   %eax,%eax
801021da:	74 05                	je     801021e1 <ideintr+0x81>
    idestart(idequeue);
801021dc:	e8 2f fe ff ff       	call   80102010 <idestart>
    release(&idelock);
801021e1:	c7 04 24 80 b5 10 80 	movl   $0x8010b580,(%esp)
801021e8:	e8 23 37 00 00       	call   80105910 <release>

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
80102210:	e8 bb 34 00 00       	call   801056d0 <holdingsleep>
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
80102232:	8b 15 60 b5 10 80    	mov    0x8010b560,%edx
80102238:	85 d2                	test   %edx,%edx
8010223a:	0f 84 9f 00 00 00    	je     801022df <iderw+0xdf>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102240:	c7 04 24 80 b5 10 80 	movl   $0x8010b580,(%esp)
80102247:	e8 24 36 00 00       	call   80105870 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010224c:	8b 15 64 b5 10 80    	mov    0x8010b564,%edx
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
8010226e:	39 1d 64 b5 10 80    	cmp    %ebx,0x8010b564
80102274:	75 1b                	jne    80102291 <iderw+0x91>
80102276:	eb 38                	jmp    801022b0 <iderw+0xb0>
80102278:	90                   	nop
80102279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
80102280:	b8 80 b5 10 80       	mov    $0x8010b580,%eax
80102285:	89 44 24 04          	mov    %eax,0x4(%esp)
80102289:	89 1c 24             	mov    %ebx,(%esp)
8010228c:	e8 9f 20 00 00       	call   80104330 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102291:	8b 03                	mov    (%ebx),%eax
80102293:	83 e0 06             	and    $0x6,%eax
80102296:	83 f8 02             	cmp    $0x2,%eax
80102299:	75 e5                	jne    80102280 <iderw+0x80>
  }


  release(&idelock);
8010229b:	c7 45 08 80 b5 10 80 	movl   $0x8010b580,0x8(%ebp)
}
801022a2:	83 c4 14             	add    $0x14,%esp
801022a5:	5b                   	pop    %ebx
801022a6:	5d                   	pop    %ebp
  release(&idelock);
801022a7:	e9 64 36 00 00       	jmp    80105910 <release>
801022ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
801022b0:	89 d8                	mov    %ebx,%eax
801022b2:	e8 59 fd ff ff       	call   80102010 <idestart>
801022b7:	eb d8                	jmp    80102291 <iderw+0x91>
801022b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022c0:	ba 64 b5 10 80       	mov    $0x8010b564,%edx
801022c5:	eb a5                	jmp    8010226c <iderw+0x6c>
    panic("iderw: nothing to do");
801022c7:	c7 04 24 e0 86 10 80 	movl   $0x801086e0,(%esp)
801022ce:	e8 9d e0 ff ff       	call   80100370 <panic>
    panic("iderw: buf not locked");
801022d3:	c7 04 24 ca 86 10 80 	movl   $0x801086ca,(%esp)
801022da:	e8 91 e0 ff ff       	call   80100370 <panic>
    panic("iderw: ide disk 1 not present");
801022df:	c7 04 24 f5 86 10 80 	movl   $0x801086f5,(%esp)
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
80102302:	a3 94 36 11 80       	mov    %eax,0x80113694
  ioapic->reg = reg;
80102307:	89 15 00 00 c0 fe    	mov    %edx,0xfec00000
  return ioapic->data;
8010230d:	a1 94 36 11 80       	mov    0x80113694,%eax
80102312:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102315:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
8010231b:	8b 0d 94 36 11 80    	mov    0x80113694,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102321:	0f b6 15 c0 37 11 80 	movzbl 0x801137c0,%edx
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
80102338:	c7 04 24 14 87 10 80 	movl   $0x80108714,(%esp)
8010233f:	e8 0c e3 ff ff       	call   80100650 <cprintf>
80102344:	8b 0d 94 36 11 80    	mov    0x80113694,%ecx
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
80102365:	8b 0d 94 36 11 80    	mov    0x80113694,%ecx
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
8010237e:	8b 0d 94 36 11 80    	mov    0x80113694,%ecx
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
801023a1:	8b 0d 94 36 11 80    	mov    0x80113694,%ecx
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
801023b6:	8b 0d 94 36 11 80    	mov    0x80113694,%ecx
801023bc:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801023c2:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801023c4:	a1 94 36 11 80       	mov    0x80113694,%eax
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
801023f6:	81 fb 08 6f 11 80    	cmp    $0x80116f08,%ebx
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
80102420:	e8 3b 35 00 00       	call   80105960 <memset>

  if(kmem.use_lock)
80102425:	a1 d4 36 11 80       	mov    0x801136d4,%eax
8010242a:	85 c0                	test   %eax,%eax
8010242c:	75 3a                	jne    80102468 <kfree+0x88>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
8010242e:	a1 d8 36 11 80       	mov    0x801136d8,%eax
80102433:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
80102435:	a1 d4 36 11 80       	mov    0x801136d4,%eax
  kmem.freelist = r;
8010243a:	89 1d d8 36 11 80    	mov    %ebx,0x801136d8
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
80102450:	c7 45 08 a0 36 11 80 	movl   $0x801136a0,0x8(%ebp)
}
80102457:	83 c4 14             	add    $0x14,%esp
8010245a:	5b                   	pop    %ebx
8010245b:	5d                   	pop    %ebp
    release(&kmem.lock);
8010245c:	e9 af 34 00 00       	jmp    80105910 <release>
80102461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&kmem.lock);
80102468:	c7 04 24 a0 36 11 80 	movl   $0x801136a0,(%esp)
8010246f:	e8 fc 33 00 00       	call   80105870 <acquire>
80102474:	eb b8                	jmp    8010242e <kfree+0x4e>
    panic("kfree");
80102476:	c7 04 24 46 87 10 80 	movl   $0x80108746,(%esp)
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
801024e1:	b8 4c 87 10 80       	mov    $0x8010874c,%eax
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
801024f4:	c7 04 24 a0 36 11 80 	movl   $0x801136a0,(%esp)
801024fb:	e8 20 32 00 00       	call   80105720 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
80102500:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 0;
80102503:	31 d2                	xor    %edx,%edx
80102505:	89 15 d4 36 11 80    	mov    %edx,0x801136d4
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
8010259d:	a3 d4 36 11 80       	mov    %eax,0x801136d4
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
801025b0:	a1 d4 36 11 80       	mov    0x801136d4,%eax
801025b5:	85 c0                	test   %eax,%eax
801025b7:	75 1f                	jne    801025d8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801025b9:	a1 d8 36 11 80       	mov    0x801136d8,%eax
  if(r)
801025be:	85 c0                	test   %eax,%eax
801025c0:	74 0e                	je     801025d0 <kalloc+0x20>
    kmem.freelist = r->next;
801025c2:	8b 10                	mov    (%eax),%edx
801025c4:	89 15 d8 36 11 80    	mov    %edx,0x801136d8
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
801025de:	c7 04 24 a0 36 11 80 	movl   $0x801136a0,(%esp)
801025e5:	e8 86 32 00 00       	call   80105870 <acquire>
  r = kmem.freelist;
801025ea:	a1 d8 36 11 80       	mov    0x801136d8,%eax
801025ef:	8b 15 d4 36 11 80    	mov    0x801136d4,%edx
  if(r)
801025f5:	85 c0                	test   %eax,%eax
801025f7:	74 08                	je     80102601 <kalloc+0x51>
    kmem.freelist = r->next;
801025f9:	8b 08                	mov    (%eax),%ecx
801025fb:	89 0d d8 36 11 80    	mov    %ecx,0x801136d8
  if(kmem.use_lock)
80102601:	85 d2                	test   %edx,%edx
80102603:	74 12                	je     80102617 <kalloc+0x67>
    release(&kmem.lock);
80102605:	c7 04 24 a0 36 11 80 	movl   $0x801136a0,(%esp)
8010260c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010260f:	e8 fc 32 00 00       	call   80105910 <release>
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
8010263d:	8b 1d b4 b5 10 80    	mov    0x8010b5b4,%ebx

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
80102664:	0f b6 8a 80 88 10 80 	movzbl -0x7fef7780(%edx),%ecx
  shift ^= togglecode[data];
8010266b:	0f b6 82 80 87 10 80 	movzbl -0x7fef7880(%edx),%eax
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
8010267e:	8b 04 85 60 87 10 80 	mov    -0x7fef78a0(,%eax,4),%eax
  shift ^= togglecode[data];
80102685:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
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
801026b9:	0f b6 82 80 88 10 80 	movzbl -0x7fef7780(%edx),%eax
801026c0:	0c 40                	or     $0x40,%al
801026c2:	0f b6 c8             	movzbl %al,%ecx
    return 0;
801026c5:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801026c7:	f7 d1                	not    %ecx
801026c9:	21 d9                	and    %ebx,%ecx
801026cb:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
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
801026dd:	89 1d b4 b5 10 80    	mov    %ebx,0x8010b5b4
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
80102730:	a1 dc 36 11 80       	mov    0x801136dc,%eax
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
80102830:	a1 dc 36 11 80       	mov    0x801136dc,%eax
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
80102850:	a1 dc 36 11 80       	mov    0x801136dc,%eax
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
801028b1:	a1 dc 36 11 80       	mov    0x801136dc,%eax
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
80102a20:	e8 9b 2f 00 00       	call   801059c0 <memcmp>
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
80102ad0:	8b 15 28 37 11 80    	mov    0x80113728,%edx
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
80102af0:	a1 14 37 11 80       	mov    0x80113714,%eax
80102af5:	01 d8                	add    %ebx,%eax
80102af7:	40                   	inc    %eax
80102af8:	89 44 24 04          	mov    %eax,0x4(%esp)
80102afc:	a1 24 37 11 80       	mov    0x80113724,%eax
80102b01:	89 04 24             	mov    %eax,(%esp)
80102b04:	e8 c7 d5 ff ff       	call   801000d0 <bread>
80102b09:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b0b:	8b 04 9d 2c 37 11 80 	mov    -0x7feec8d4(,%ebx,4),%eax
  for (tail = 0; tail < log.lh.n; tail++) {
80102b12:	43                   	inc    %ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b13:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b17:	a1 24 37 11 80       	mov    0x80113724,%eax
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
80102b3c:	e8 df 2e 00 00       	call   80105a20 <memmove>
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
80102b59:	39 1d 28 37 11 80    	cmp    %ebx,0x80113728
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
80102b88:	a1 14 37 11 80       	mov    0x80113714,%eax
80102b8d:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b91:	a1 24 37 11 80       	mov    0x80113724,%eax
80102b96:	89 04 24             	mov    %eax,(%esp)
80102b99:	e8 32 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b9e:	8b 1d 28 37 11 80    	mov    0x80113728,%ebx
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
80102bc0:	8b 8a 2c 37 11 80    	mov    -0x7feec8d4(%edx),%ecx
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
80102bf1:	ba 80 89 10 80       	mov    $0x80108980,%edx
{
80102bf6:	89 e5                	mov    %esp,%ebp
80102bf8:	53                   	push   %ebx
80102bf9:	83 ec 34             	sub    $0x34,%esp
80102bfc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102bff:	89 54 24 04          	mov    %edx,0x4(%esp)
80102c03:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
80102c0a:	e8 11 2b 00 00       	call   80105720 <initlock>
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
80102c27:	89 1d 24 37 11 80    	mov    %ebx,0x80113724
  struct buf *buf = bread(log.dev, log.start);
80102c2d:	89 44 24 04          	mov    %eax,0x4(%esp)
  log.start = sb.logstart;
80102c31:	a3 14 37 11 80       	mov    %eax,0x80113714
  log.size = sb.nlog;
80102c36:	89 15 18 37 11 80    	mov    %edx,0x80113718
  struct buf *buf = bread(log.dev, log.start);
80102c3c:	e8 8f d4 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102c41:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102c44:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102c46:	89 1d 28 37 11 80    	mov    %ebx,0x80113728
  for (i = 0; i < log.lh.n; i++) {
80102c4c:	7e 23                	jle    80102c71 <initlog+0x81>
80102c4e:	c1 e3 02             	shl    $0x2,%ebx
80102c51:	31 d2                	xor    %edx,%edx
80102c53:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log.lh.block[i] = lh->block[i];
80102c60:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102c64:	83 c2 04             	add    $0x4,%edx
80102c67:	89 8a 28 37 11 80    	mov    %ecx,-0x7feec8d8(%edx)
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
80102c80:	a3 28 37 11 80       	mov    %eax,0x80113728
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
80102c96:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
80102c9d:	e8 ce 2b 00 00       	call   80105870 <acquire>
80102ca2:	eb 19                	jmp    80102cbd <begin_op+0x2d>
80102ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102ca8:	b8 e0 36 11 80       	mov    $0x801136e0,%eax
80102cad:	89 44 24 04          	mov    %eax,0x4(%esp)
80102cb1:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
80102cb8:	e8 73 16 00 00       	call   80104330 <sleep>
    if(log.committing){
80102cbd:	8b 15 20 37 11 80    	mov    0x80113720,%edx
80102cc3:	85 d2                	test   %edx,%edx
80102cc5:	75 e1                	jne    80102ca8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102cc7:	a1 1c 37 11 80       	mov    0x8011371c,%eax
80102ccc:	8b 15 28 37 11 80    	mov    0x80113728,%edx
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
80102cde:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
      log.outstanding += 1;
80102ce5:	a3 1c 37 11 80       	mov    %eax,0x8011371c
      release(&log.lock);
80102cea:	e8 21 2c 00 00       	call   80105910 <release>
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
80102d09:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
80102d10:	e8 5b 2b 00 00       	call   80105870 <acquire>
  log.outstanding -= 1;
80102d15:	a1 1c 37 11 80       	mov    0x8011371c,%eax
80102d1a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102d1d:	a1 20 37 11 80       	mov    0x80113720,%eax
  log.outstanding -= 1;
80102d22:	89 1d 1c 37 11 80    	mov    %ebx,0x8011371c
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
80102d3d:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
    log.committing = 1;
80102d44:	89 35 20 37 11 80    	mov    %esi,0x80113720
  release(&log.lock);
80102d4a:	e8 c1 2b 00 00       	call   80105910 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102d4f:	8b 3d 28 37 11 80    	mov    0x80113728,%edi
80102d55:	85 ff                	test   %edi,%edi
80102d57:	0f 8e 88 00 00 00    	jle    80102de5 <end_op+0xe5>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102d5d:	a1 14 37 11 80       	mov    0x80113714,%eax
80102d62:	01 d8                	add    %ebx,%eax
80102d64:	40                   	inc    %eax
80102d65:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d69:	a1 24 37 11 80       	mov    0x80113724,%eax
80102d6e:	89 04 24             	mov    %eax,(%esp)
80102d71:	e8 5a d3 ff ff       	call   801000d0 <bread>
80102d76:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d78:	8b 04 9d 2c 37 11 80 	mov    -0x7feec8d4(,%ebx,4),%eax
  for (tail = 0; tail < log.lh.n; tail++) {
80102d7f:	43                   	inc    %ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d80:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d84:	a1 24 37 11 80       	mov    0x80113724,%eax
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
80102da9:	e8 72 2c 00 00       	call   80105a20 <memmove>
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
80102dc6:	3b 1d 28 37 11 80    	cmp    0x80113728,%ebx
80102dcc:	7c 8f                	jl     80102d5d <end_op+0x5d>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102dce:	e8 ad fd ff ff       	call   80102b80 <write_head>
    install_trans(); // Now install writes to home locations
80102dd3:	e8 f8 fc ff ff       	call   80102ad0 <install_trans>
    log.lh.n = 0;
80102dd8:	31 d2                	xor    %edx,%edx
80102dda:	89 15 28 37 11 80    	mov    %edx,0x80113728
    write_head();    // Erase the transaction from the log
80102de0:	e8 9b fd ff ff       	call   80102b80 <write_head>
    acquire(&log.lock);
80102de5:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
80102dec:	e8 7f 2a 00 00       	call   80105870 <acquire>
    log.committing = 0;
80102df1:	31 c0                	xor    %eax,%eax
80102df3:	a3 20 37 11 80       	mov    %eax,0x80113720
    wakeup(&log);
80102df8:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
80102dff:	e8 1c 17 00 00       	call   80104520 <wakeup>
    release(&log.lock);
80102e04:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
80102e0b:	e8 00 2b 00 00       	call   80105910 <release>
}
80102e10:	83 c4 1c             	add    $0x1c,%esp
80102e13:	5b                   	pop    %ebx
80102e14:	5e                   	pop    %esi
80102e15:	5f                   	pop    %edi
80102e16:	5d                   	pop    %ebp
80102e17:	c3                   	ret    
    panic("log.committing");
80102e18:	c7 04 24 84 89 10 80 	movl   $0x80108984,(%esp)
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
80102e37:	8b 15 28 37 11 80    	mov    0x80113728,%edx
{
80102e3d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e40:	83 fa 1d             	cmp    $0x1d,%edx
80102e43:	0f 8f 95 00 00 00    	jg     80102ede <log_write+0xae>
80102e49:	a1 18 37 11 80       	mov    0x80113718,%eax
80102e4e:	48                   	dec    %eax
80102e4f:	39 c2                	cmp    %eax,%edx
80102e51:	0f 8d 87 00 00 00    	jge    80102ede <log_write+0xae>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102e57:	a1 1c 37 11 80       	mov    0x8011371c,%eax
80102e5c:	85 c0                	test   %eax,%eax
80102e5e:	0f 8e 86 00 00 00    	jle    80102eea <log_write+0xba>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102e64:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
80102e6b:	e8 00 2a 00 00       	call   80105870 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102e70:	8b 0d 28 37 11 80    	mov    0x80113728,%ecx
80102e76:	83 f9 00             	cmp    $0x0,%ecx
80102e79:	7e 55                	jle    80102ed0 <log_write+0xa0>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e7b:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102e7e:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e80:	3b 15 2c 37 11 80    	cmp    0x8011372c,%edx
80102e86:	75 11                	jne    80102e99 <log_write+0x69>
80102e88:	eb 36                	jmp    80102ec0 <log_write+0x90>
80102e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102e90:	39 14 85 2c 37 11 80 	cmp    %edx,-0x7feec8d4(,%eax,4)
80102e97:	74 27                	je     80102ec0 <log_write+0x90>
  for (i = 0; i < log.lh.n; i++) {
80102e99:	40                   	inc    %eax
80102e9a:	39 c1                	cmp    %eax,%ecx
80102e9c:	75 f2                	jne    80102e90 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102e9e:	89 14 85 2c 37 11 80 	mov    %edx,-0x7feec8d4(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102ea5:	40                   	inc    %eax
80102ea6:	a3 28 37 11 80       	mov    %eax,0x80113728
  b->flags |= B_DIRTY; // prevent eviction
80102eab:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102eae:	c7 45 08 e0 36 11 80 	movl   $0x801136e0,0x8(%ebp)
}
80102eb5:	83 c4 14             	add    $0x14,%esp
80102eb8:	5b                   	pop    %ebx
80102eb9:	5d                   	pop    %ebp
  release(&log.lock);
80102eba:	e9 51 2a 00 00       	jmp    80105910 <release>
80102ebf:	90                   	nop
  log.lh.block[i] = b->blockno;
80102ec0:	89 14 85 2c 37 11 80 	mov    %edx,-0x7feec8d4(,%eax,4)
80102ec7:	eb e2                	jmp    80102eab <log_write+0x7b>
80102ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ed0:	8b 43 08             	mov    0x8(%ebx),%eax
80102ed3:	a3 2c 37 11 80       	mov    %eax,0x8011372c
  if (i == log.lh.n)
80102ed8:	75 d1                	jne    80102eab <log_write+0x7b>
80102eda:	31 c0                	xor    %eax,%eax
80102edc:	eb c7                	jmp    80102ea5 <log_write+0x75>
    panic("too big a transaction");
80102ede:	c7 04 24 93 89 10 80 	movl   $0x80108993,(%esp)
80102ee5:	e8 86 d4 ff ff       	call   80100370 <panic>
    panic("log_write outside of trans");
80102eea:	c7 04 24 a9 89 10 80 	movl   $0x801089a9,(%esp)
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
80102f07:	e8 c4 4e 00 00       	call   80107dd0 <switchkvm>
  seginit();
80102f0c:	e8 2f 4e 00 00       	call   80107d40 <seginit>
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
80102f22:	c7 04 24 c4 89 10 80 	movl   $0x801089c4,(%esp)
80102f29:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f2d:	e8 1e d7 ff ff       	call   80100650 <cprintf>
  idtinit();       // load idt register
80102f32:	e8 49 3d 00 00       	call   80106c80 <idtinit>
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
80102f6a:	c7 04 24 14 8a 10 80 	movl   $0x80108a14,(%esp)
80102f71:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f75:	e8 d6 d6 ff ff       	call   80100650 <cprintf>
  scheduler();     // start running processes
80102f7a:	e8 d1 0e 00 00       	call   80103e50 <scheduler>
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
80102f93:	c7 04 24 08 6f 11 80 	movl   $0x80116f08,(%esp)
80102f9a:	e8 41 f5 ff ff       	call   801024e0 <kinit1>
  kvmalloc();      // kernel page table
80102f9f:	e8 fc 52 00 00       	call   801082a0 <kvmalloc>
  mpinit();        // detect other processors
80102fa4:	e8 17 02 00 00       	call   801031c0 <mpinit>
  lapicinit();     // interrupt controller
80102fa9:	e8 82 f7 ff ff       	call   80102730 <lapicinit>
80102fae:	66 90                	xchg   %ax,%ax
  seginit();       // segment descriptors
80102fb0:	e8 8b 4d 00 00       	call   80107d40 <seginit>
  picinit();       // disable pic
80102fb5:	e8 e6 03 00 00       	call   801033a0 <picinit>
  ioapicinit();    // another interrupt controller
80102fba:	e8 31 f3 ff ff       	call   801022f0 <ioapicinit>
80102fbf:	90                   	nop
  consoleinit();   // console hardware
80102fc0:	e8 bb d9 ff ff       	call   80100980 <consoleinit>
  uartinit();      // serial port
80102fc5:	e8 46 40 00 00       	call   80107010 <uartinit>
  pinit();         // process table
80102fca:	e8 91 09 00 00       	call   80103960 <pinit>
80102fcf:	90                   	nop
  tvinit();        // trap vectors
80102fd0:	e8 2b 3c 00 00       	call   80106c00 <tvinit>
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
80102fee:	b8 8c b4 10 80       	mov    $0x8010b48c,%eax
80102ff3:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ff7:	c7 04 24 00 70 00 80 	movl   $0x80007000,(%esp)
80102ffe:	e8 1d 2a 00 00       	call   80105a20 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103003:	a1 60 3d 11 80       	mov    0x80113d60,%eax
80103008:	8d 14 80             	lea    (%eax,%eax,4),%edx
8010300b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010300e:	c1 e0 04             	shl    $0x4,%eax
80103011:	05 e0 37 11 80       	add    $0x801137e0,%eax
80103016:	3d e0 37 11 80       	cmp    $0x801137e0,%eax
8010301b:	0f 86 86 00 00 00    	jbe    801030a7 <main+0x127>
80103021:	bb e0 37 11 80       	mov    $0x801137e0,%ebx
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
80103043:	b9 00 a0 10 00       	mov    $0x10a000,%ecx
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
8010308a:	a1 60 3d 11 80       	mov    0x80113d60,%eax
8010308f:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103095:	8d 14 80             	lea    (%eax,%eax,4),%edx
80103098:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010309b:	c1 e0 04             	shl    $0x4,%eax
8010309e:	05 e0 37 11 80       	add    $0x801137e0,%eax
801030a3:	39 c3                	cmp    %eax,%ebx
801030a5:	72 89                	jb     80103030 <main+0xb0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801030a7:	b8 00 00 00 8e       	mov    $0x8e000000,%eax
801030ac:	89 44 24 04          	mov    %eax,0x4(%esp)
801030b0:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
801030b7:	e8 94 f4 ff ff       	call   80102550 <kinit2>
  initSchedDS(); // initialize the data structures for the processes sceduling policies
801030bc:	e8 cf 1a 00 00       	call   80104b90 <initSchedDS>
	__sync_synchronize();
801030c1:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  for(struct cpu *c = cpus; c < cpus + ncpu; ++c) //releases the non-boot AP cpus that are wating at mpmain at main.c
801030c6:	a1 60 3d 11 80       	mov    0x80113d60,%eax
801030cb:	8d 14 80             	lea    (%eax,%eax,4),%edx
801030ce:	8d 0c 50             	lea    (%eax,%edx,2),%ecx
801030d1:	c1 e1 04             	shl    $0x4,%ecx
801030d4:	81 c1 e0 37 11 80    	add    $0x801137e0,%ecx
801030da:	81 f9 e0 37 11 80    	cmp    $0x801137e0,%ecx
801030e0:	76 21                	jbe    80103103 <main+0x183>
801030e2:	ba e0 37 11 80       	mov    $0x801137e0,%edx
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
80103118:	c7 04 24 0a 8a 10 80 	movl   $0x80108a0a,(%esp)
8010311f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103123:	e8 28 d5 ff ff       	call   80100650 <cprintf>
  idtinit();       // load idt register
80103128:	e8 53 3b 00 00       	call   80106c80 <idtinit>
  scheduler();     // start running processes
8010312d:	e8 1e 0d 00 00       	call   80103e50 <scheduler>
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
80103166:	ba 28 8a 10 80       	mov    $0x80108a28,%edx
8010316b:	b8 04 00 00 00       	mov    $0x4,%eax
80103170:	89 54 24 04          	mov    %edx,0x4(%esp)
80103174:	89 44 24 08          	mov    %eax,0x8(%esp)
80103178:	89 34 24             	mov    %esi,(%esp)
8010317b:	e8 40 28 00 00       	call   801059c0 <memcmp>
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
80103224:	ba 45 8a 10 80       	mov    $0x80108a45,%edx
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103229:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
8010322f:	89 44 24 08          	mov    %eax,0x8(%esp)
80103233:	89 54 24 04          	mov    %edx,0x4(%esp)
80103237:	89 34 24             	mov    %esi,(%esp)
8010323a:	e8 81 27 00 00       	call   801059c0 <memcmp>
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
801032b0:	a3 dc 36 11 80       	mov    %eax,0x801136dc
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
801032cf:	ff 24 85 6c 8a 10 80 	jmp    *-0x7fef7594(,%eax,4)
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
80103318:	8b 1d 60 3d 11 80    	mov    0x80113d60,%ebx
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
80103331:	89 1d 60 3d 11 80    	mov    %ebx,0x80113d60
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103337:	88 87 e0 37 11 80    	mov    %al,-0x7feec820(%edi)
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
8010334f:	a2 c0 37 11 80       	mov    %al,0x801137c0
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
80103380:	c7 04 24 2d 8a 10 80 	movl   $0x80108a2d,(%esp)
80103387:	e8 e4 cf ff ff       	call   80100370 <panic>
    panic("Didn't find a suitable machine");
8010338c:	c7 04 24 4c 8a 10 80 	movl   $0x80108a4c,(%esp)
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
80103460:	ba 80 8a 10 80       	mov    $0x80108a80,%edx
  p->nread = 0;
80103465:	89 88 34 02 00 00    	mov    %ecx,0x234(%eax)
  initlock(&p->lock, "pipe");
8010346b:	89 54 24 04          	mov    %edx,0x4(%esp)
8010346f:	89 04 24             	mov    %eax,(%esp)
80103472:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103475:	e8 a6 22 00 00       	call   80105720 <initlock>
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
801034d5:	e8 96 23 00 00       	call   80105870 <acquire>
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
801034ef:	e8 2c 10 00 00       	call   80104520 <wakeup>
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
80103514:	e9 f7 23 00 00       	jmp    80105910 <release>
80103519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->readopen = 0;
80103520:	31 c9                	xor    %ecx,%ecx
    wakeup(&p->nwrite);
80103522:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103528:	89 8b 3c 02 00 00    	mov    %ecx,0x23c(%ebx)
    wakeup(&p->nwrite);
8010352e:	89 04 24             	mov    %eax,(%esp)
80103531:	e8 ea 0f 00 00       	call   80104520 <wakeup>
80103536:	eb bc                	jmp    801034f4 <pipeclose+0x34>
80103538:	90                   	nop
80103539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103540:	89 1c 24             	mov    %ebx,(%esp)
80103543:	e8 c8 23 00 00       	call   80105910 <release>
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
8010356f:	e8 fc 22 00 00       	call   80105870 <acquire>
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
801035c3:	e8 58 0f 00 00       	call   80104520 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035c8:	89 7c 24 04          	mov    %edi,0x4(%esp)
801035cc:	89 1c 24             	mov    %ebx,(%esp)
801035cf:	e8 5c 0d 00 00       	call   80104330 <sleep>
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
80103602:	e8 09 23 00 00       	call   80105910 <release>
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
8010364f:	e8 cc 0e 00 00       	call   80104520 <wakeup>
  release(&p->lock);
80103654:	89 3c 24             	mov    %edi,(%esp)
80103657:	e8 b4 22 00 00       	call   80105910 <release>
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
80103682:	e8 e9 21 00 00       	call   80105870 <acquire>
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
801036b7:	e8 74 0c 00 00       	call   80104330 <sleep>
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
801036ec:	e8 1f 22 00 00       	call   80105910 <release>
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
80103744:	e8 d7 0d 00 00       	call   80104520 <wakeup>
  release(&p->lock);
80103749:	89 34 24             	mov    %esi,(%esp)
8010374c:	e8 bf 21 00 00       	call   80105910 <release>
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
80103774:	bb b4 3d 11 80       	mov    $0x80113db4,%ebx
{
80103779:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);
8010377c:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103783:	e8 e8 20 00 00       	call   80105870 <acquire>
80103788:	eb 18                	jmp    801037a2 <allocproc+0x32>
8010378a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103790:	81 c3 a4 00 00 00    	add    $0xa4,%ebx
80103796:	81 fb b4 66 11 80    	cmp    $0x801166b4,%ebx
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
801037a9:	a1 08 b0 10 80       	mov    0x8010b008,%eax
  p->state = EMBRYO;
801037ae:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
801037b5:	8d 50 01             	lea    0x1(%eax),%edx
801037b8:	89 43 10             	mov    %eax,0x10(%ebx)

  release(&ptable.lock);
801037bb:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
  p->pid = nextpid++;
801037c2:	89 15 08 b0 10 80    	mov    %edx,0x8010b008
  release(&ptable.lock);
801037c8:	e8 43 21 00 00       	call   80105910 <release>

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
801037e7:	ba ef 6b 10 80       	mov    $0x80106bef,%edx
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
80103804:	e8 57 21 00 00       	call   80105960 <memset>
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
80103820:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
  return 0;
80103827:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103829:	e8 e2 20 00 00       	call   80105910 <release>
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
80103856:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
8010385d:	e8 ae 20 00 00       	call   80105910 <release>

  if (first) {
80103862:	8b 15 00 b0 10 80    	mov    0x8010b000,%edx
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
80103879:	a3 00 b0 10 80       	mov    %eax,0x8010b000
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
801038e9:	ff 15 e8 b5 10 80    	call   *0x8010b5e8
801038ef:	89 c3                	mov    %eax,%ebx
  boolean b=rpholder.getMinAccumulator(&tmp2);
801038f1:	8d 45 f0             	lea    -0x10(%ebp),%eax
801038f4:	89 04 24             	mov    %eax,(%esp)
801038f7:	ff 15 cc b5 10 80    	call   *0x8010b5cc
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
80103961:	b8 85 8a 10 80       	mov    $0x80108a85,%eax
{
80103966:	89 e5                	mov    %esp,%ebp
80103968:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
8010396b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010396f:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103976:	e8 a5 1d 00 00       	call   80105720 <initlock>
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
80103994:	8b 35 60 3d 11 80    	mov    0x80113d60,%esi
8010399a:	85 f6                	test   %esi,%esi
8010399c:	7e 40                	jle    801039de <mycpu+0x5e>
    if (cpus[i].apicid == apicid)
8010399e:	0f b6 15 e0 37 11 80 	movzbl 0x801137e0,%edx
801039a5:	39 d0                	cmp    %edx,%eax
801039a7:	74 2e                	je     801039d7 <mycpu+0x57>
801039a9:	b9 90 38 11 80       	mov    $0x80113890,%ecx
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
801039cb:	05 e0 37 11 80       	add    $0x801137e0,%eax
}
801039d0:	83 c4 10             	add    $0x10,%esp
801039d3:	5b                   	pop    %ebx
801039d4:	5e                   	pop    %esi
801039d5:	5d                   	pop    %ebp
801039d6:	c3                   	ret    
    if (cpus[i].apicid == apicid)
801039d7:	b8 e0 37 11 80       	mov    $0x801137e0,%eax
      return &cpus[i];
801039dc:	eb f2                	jmp    801039d0 <mycpu+0x50>
  panic("unknown apicid\n");
801039de:	c7 04 24 8c 8a 10 80 	movl   $0x80108a8c,(%esp)
801039e5:	e8 86 c9 ff ff       	call   80100370 <panic>
    panic("mycpu called with interrupts enabled\n");
801039ea:	c7 04 24 68 8b 10 80 	movl   $0x80108b68,(%esp)
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
80103a0c:	2d e0 37 11 80       	sub    $0x801137e0,%eax
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
80103a27:	e8 64 1d 00 00       	call   80105790 <pushcli>
  c = mycpu();
80103a2c:	e8 4f ff ff ff       	call   80103980 <mycpu>
  p = c->proc;
80103a31:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a37:	e8 94 1d 00 00       	call   801057d0 <popcli>
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
80103a50:	a1 04 b0 10 80       	mov    0x8010b004,%eax
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
80103a71:	ff 25 e4 b5 10 80    	jmp    *0x8010b5e4
80103a77:	89 f6                	mov    %esi,%esi
80103a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80103a80:	5d                   	pop    %ebp
            rrq.enqueue(p);
80103a81:	ff 25 d4 b5 10 80    	jmp    *0x8010b5d4
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
80103a97:	bb b4 3d 11 80       	mov    $0x80113db4,%ebx
{
80103a9c:	83 ec 10             	sub    $0x10,%esp
80103a9f:	eb 15                	jmp    80103ab6 <wakeup1+0x26>
80103aa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103aa8:	81 c3 a4 00 00 00    	add    $0xa4,%ebx
80103aae:	81 fb b4 66 11 80    	cmp    $0x801166b4,%ebx
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
80103ae0:	81 c3 a4 00 00 00    	add    $0xa4,%ebx
        pushToSpecificQueue(p);
80103ae6:	e8 65 ff ff ff       	call   80103a50 <pushToSpecificQueue>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103aeb:	81 fb b4 66 11 80    	cmp    $0x801166b4,%ebx
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
80103b0e:	a3 bc b5 10 80       	mov    %eax,0x8010b5bc
  if((p->pgdir = setupkvm()) == 0)
80103b13:	e8 08 47 00 00       	call   80108220 <setupkvm>
80103b18:	85 c0                	test   %eax,%eax
80103b1a:	89 43 04             	mov    %eax,0x4(%ebx)
80103b1d:	0f 84 18 01 00 00    	je     80103c3b <userinit+0x13b>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103b23:	b9 60 b4 10 80       	mov    $0x8010b460,%ecx
80103b28:	ba 2c 00 00 00       	mov    $0x2c,%edx
80103b2d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80103b31:	89 54 24 08          	mov    %edx,0x8(%esp)
80103b35:	89 04 24             	mov    %eax,(%esp)
80103b38:	e8 b3 43 00 00       	call   80107ef0 <inituvm>
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
80103b58:	e8 03 1e 00 00       	call   80105960 <memset>
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
80103baa:	b8 b5 8a 10 80       	mov    $0x80108ab5,%eax
80103baf:	89 44 24 04          	mov    %eax,0x4(%esp)
80103bb3:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103bb6:	89 04 24             	mov    %eax,(%esp)
80103bb9:	e8 82 1f 00 00       	call   80105b40 <safestrcpy>
  p->cwd = namei("/");
80103bbe:	c7 04 24 be 8a 10 80 	movl   $0x80108abe,(%esp)
80103bc5:	e8 06 e4 ff ff       	call   80101fd0 <namei>
80103bca:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103bcd:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103bd4:	e8 97 1c 00 00       	call   80105870 <acquire>
  if(currpolicy==1)
80103bd9:	a1 04 b0 10 80       	mov    0x8010b004,%eax
  p->state = RUNNABLE;
80103bde:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  if(currpolicy==1)
80103be5:	83 f8 01             	cmp    $0x1,%eax
80103be8:	75 0e                	jne    80103bf8 <userinit+0xf8>
    rrq.enqueue(p);
80103bea:	89 1c 24             	mov    %ebx,(%esp)
80103bed:	ff 15 d4 b5 10 80    	call   *0x8010b5d4
80103bf3:	a1 04 b0 10 80       	mov    0x8010b004,%eax
  p->RUNNABLE_wait_time=0; //surely 0 because this is the first initialized process
80103bf8:	31 c9                	xor    %ecx,%ecx
  p->priority=5;
80103bfa:	ba 05 00 00 00       	mov    $0x5,%edx
80103bff:	89 93 88 00 00 00    	mov    %edx,0x88(%ebx)
  p->accumulator=0; //is surely 0 because this is the first initialized process
80103c05:	31 d2                	xor    %edx,%edx
  p->RUNNABLE_wait_time=0; //surely 0 because this is the first initialized process
80103c07:	89 8b a0 00 00 00    	mov    %ecx,0xa0(%ebx)
  p->accumulator=0; //is surely 0 because this is the first initialized process
80103c0d:	31 c9                	xor    %ecx,%ecx
  if(currpolicy==2)
80103c0f:	83 f8 02             	cmp    $0x2,%eax
  p->accumulator=0; //is surely 0 because this is the first initialized process
80103c12:	89 93 80 00 00 00    	mov    %edx,0x80(%ebx)
80103c18:	89 8b 84 00 00 00    	mov    %ecx,0x84(%ebx)
  if(currpolicy==2)
80103c1e:	75 09                	jne    80103c29 <userinit+0x129>
    pq.put(p);
80103c20:	89 1c 24             	mov    %ebx,(%esp)
80103c23:	ff 15 e4 b5 10 80    	call   *0x8010b5e4
  release(&ptable.lock);
80103c29:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103c30:	e8 db 1c 00 00       	call   80105910 <release>
}
80103c35:	83 c4 14             	add    $0x14,%esp
80103c38:	5b                   	pop    %ebx
80103c39:	5d                   	pop    %ebp
80103c3a:	c3                   	ret    
    panic("userinit: out of memory?");
80103c3b:	c7 04 24 9c 8a 10 80 	movl   $0x80108a9c,(%esp)
80103c42:	e8 29 c7 ff ff       	call   80100370 <panic>
80103c47:	89 f6                	mov    %esi,%esi
80103c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c50 <growproc>:
{
80103c50:	55                   	push   %ebp
80103c51:	89 e5                	mov    %esp,%ebp
80103c53:	56                   	push   %esi
80103c54:	53                   	push   %ebx
80103c55:	83 ec 10             	sub    $0x10,%esp
80103c58:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103c5b:	e8 30 1b 00 00       	call   80105790 <pushcli>
  c = mycpu();
80103c60:	e8 1b fd ff ff       	call   80103980 <mycpu>
  p = c->proc;
80103c65:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c6b:	e8 60 1b 00 00       	call   801057d0 <popcli>
  if(n > 0){
80103c70:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103c73:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103c75:	7f 19                	jg     80103c90 <growproc+0x40>
  } else if(n < 0){
80103c77:	75 37                	jne    80103cb0 <growproc+0x60>
  curproc->sz = sz;
80103c79:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103c7b:	89 1c 24             	mov    %ebx,(%esp)
80103c7e:	e8 6d 41 00 00       	call   80107df0 <switchuvm>
  return 0;
80103c83:	31 c0                	xor    %eax,%eax
}
80103c85:	83 c4 10             	add    $0x10,%esp
80103c88:	5b                   	pop    %ebx
80103c89:	5e                   	pop    %esi
80103c8a:	5d                   	pop    %ebp
80103c8b:	c3                   	ret    
80103c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103c90:	01 c6                	add    %eax,%esi
80103c92:	89 74 24 08          	mov    %esi,0x8(%esp)
80103c96:	89 44 24 04          	mov    %eax,0x4(%esp)
80103c9a:	8b 43 04             	mov    0x4(%ebx),%eax
80103c9d:	89 04 24             	mov    %eax,(%esp)
80103ca0:	e8 9b 43 00 00       	call   80108040 <allocuvm>
80103ca5:	85 c0                	test   %eax,%eax
80103ca7:	75 d0                	jne    80103c79 <growproc+0x29>
      return -1;
80103ca9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103cae:	eb d5                	jmp    80103c85 <growproc+0x35>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103cb0:	01 c6                	add    %eax,%esi
80103cb2:	89 74 24 08          	mov    %esi,0x8(%esp)
80103cb6:	89 44 24 04          	mov    %eax,0x4(%esp)
80103cba:	8b 43 04             	mov    0x4(%ebx),%eax
80103cbd:	89 04 24             	mov    %eax,(%esp)
80103cc0:	e8 ab 44 00 00       	call   80108170 <deallocuvm>
80103cc5:	85 c0                	test   %eax,%eax
80103cc7:	75 b0                	jne    80103c79 <growproc+0x29>
80103cc9:	eb de                	jmp    80103ca9 <growproc+0x59>
80103ccb:	90                   	nop
80103ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103cd0 <fork>:
{
80103cd0:	55                   	push   %ebp
80103cd1:	89 e5                	mov    %esp,%ebp
80103cd3:	57                   	push   %edi
80103cd4:	56                   	push   %esi
80103cd5:	53                   	push   %ebx
80103cd6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103cd9:	e8 b2 1a 00 00       	call   80105790 <pushcli>
  c = mycpu();
80103cde:	e8 9d fc ff ff       	call   80103980 <mycpu>
  p = c->proc;
80103ce3:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
80103ce9:	e8 e2 1a 00 00       	call   801057d0 <popcli>
  if((np = allocproc()) == 0){
80103cee:	e8 7d fa ff ff       	call   80103770 <allocproc>
80103cf3:	85 c0                	test   %eax,%eax
80103cf5:	0f 84 20 01 00 00    	je     80103e1b <fork+0x14b>
80103cfb:	89 c6                	mov    %eax,%esi
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103cfd:	8b 07                	mov    (%edi),%eax
80103cff:	89 44 24 04          	mov    %eax,0x4(%esp)
80103d03:	8b 47 04             	mov    0x4(%edi),%eax
80103d06:	89 04 24             	mov    %eax,(%esp)
80103d09:	e8 e2 45 00 00       	call   801082f0 <copyuvm>
80103d0e:	85 c0                	test   %eax,%eax
80103d10:	89 46 04             	mov    %eax,0x4(%esi)
80103d13:	0f 84 09 01 00 00    	je     80103e22 <fork+0x152>
  np->sz = curproc->sz;
80103d19:	8b 07                	mov    (%edi),%eax
  np->parent = curproc;
80103d1b:	89 7e 14             	mov    %edi,0x14(%esi)
  *np->tf = *curproc->tf;
80103d1e:	8b 56 18             	mov    0x18(%esi),%edx
  np->sz = curproc->sz;
80103d21:	89 06                	mov    %eax,(%esi)
  *np->tf = *curproc->tf;
80103d23:	31 c0                	xor    %eax,%eax
80103d25:	8b 4f 18             	mov    0x18(%edi),%ecx
80103d28:	8b 1c 01             	mov    (%ecx,%eax,1),%ebx
80103d2b:	89 1c 02             	mov    %ebx,(%edx,%eax,1)
80103d2e:	83 c0 04             	add    $0x4,%eax
80103d31:	83 f8 4c             	cmp    $0x4c,%eax
80103d34:	72 f2                	jb     80103d28 <fork+0x58>
  np->tf->eax = 0;
80103d36:	8b 46 18             	mov    0x18(%esi),%eax
  for(i = 0; i < NOFILE; i++)
80103d39:	31 db                	xor    %ebx,%ebx
  np->tf->eax = 0;
80103d3b:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103d42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(curproc->ofile[i])
80103d50:	8b 44 9f 28          	mov    0x28(%edi,%ebx,4),%eax
80103d54:	85 c0                	test   %eax,%eax
80103d56:	74 0c                	je     80103d64 <fork+0x94>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103d58:	89 04 24             	mov    %eax,(%esp)
80103d5b:	e8 80 d0 ff ff       	call   80100de0 <filedup>
80103d60:	89 44 9e 28          	mov    %eax,0x28(%esi,%ebx,4)
  for(i = 0; i < NOFILE; i++)
80103d64:	43                   	inc    %ebx
80103d65:	83 fb 10             	cmp    $0x10,%ebx
80103d68:	75 e6                	jne    80103d50 <fork+0x80>
  np->cwd = idup(curproc->cwd);
80103d6a:	8b 47 68             	mov    0x68(%edi),%eax
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d6d:	83 c7 6c             	add    $0x6c,%edi
  np->cwd = idup(curproc->cwd);
80103d70:	89 04 24             	mov    %eax,(%esp)
80103d73:	e8 48 d9 ff ff       	call   801016c0 <idup>
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d78:	b9 10 00 00 00       	mov    $0x10,%ecx
  np->cwd = idup(curproc->cwd);
80103d7d:	89 46 68             	mov    %eax,0x68(%esi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d80:	8d 46 6c             	lea    0x6c(%esi),%eax
80103d83:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80103d87:	89 7c 24 04          	mov    %edi,0x4(%esp)
  np->priority=5;
80103d8b:	bf 05 00 00 00       	mov    $0x5,%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d90:	89 04 24             	mov    %eax,(%esp)
80103d93:	e8 a8 1d 00 00       	call   80105b40 <safestrcpy>
  pid = np->pid;
80103d98:	8b 5e 10             	mov    0x10(%esi),%ebx
  acquire(&ptable.lock);
80103d9b:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103da2:	e8 c9 1a 00 00       	call   80105870 <acquire>
  np->state = RUNNABLE;
80103da7:	c7 46 0c 03 00 00 00 	movl   $0x3,0xc(%esi)
  np->RUNNABLE_wait_time=counter;
80103dae:	a1 b8 b5 10 80       	mov    0x8010b5b8,%eax
  np->priority=5;
80103db3:	89 be 88 00 00 00    	mov    %edi,0x88(%esi)
  np->RUNNABLE_wait_time=counter;
80103db9:	89 86 a0 00 00 00    	mov    %eax,0xa0(%esi)
  if(pq.isEmpty()&&rpholder.isEmpty()) //if the only process -> acc=0
80103dbf:	ff 15 e0 b5 10 80    	call   *0x8010b5e0
80103dc5:	85 c0                	test   %eax,%eax
80103dc7:	74 3f                	je     80103e08 <fork+0x138>
80103dc9:	ff 15 c0 b5 10 80    	call   *0x8010b5c0
80103dcf:	85 c0                	test   %eax,%eax
80103dd1:	74 35                	je     80103e08 <fork+0x138>
    np->accumulator=0;
80103dd3:	31 c0                	xor    %eax,%eax
80103dd5:	31 d2                	xor    %edx,%edx
80103dd7:	89 86 80 00 00 00    	mov    %eax,0x80(%esi)
80103ddd:	89 96 84 00 00 00    	mov    %edx,0x84(%esi)
  pushToSpecificQueue(np);
80103de3:	89 34 24             	mov    %esi,(%esp)
80103de6:	e8 65 fc ff ff       	call   80103a50 <pushToSpecificQueue>
  release(&ptable.lock);
80103deb:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103df2:	e8 19 1b 00 00       	call   80105910 <release>
}
80103df7:	83 c4 1c             	add    $0x1c,%esp
80103dfa:	89 d8                	mov    %ebx,%eax
80103dfc:	5b                   	pop    %ebx
80103dfd:	5e                   	pop    %esi
80103dfe:	5f                   	pop    %edi
80103dff:	5d                   	pop    %ebp
80103e00:	c3                   	ret    
80103e01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    np->accumulator=getMinAccumulator();
80103e08:	e8 b3 fa ff ff       	call   801038c0 <getMinAccumulator>
80103e0d:	89 86 80 00 00 00    	mov    %eax,0x80(%esi)
80103e13:	89 96 84 00 00 00    	mov    %edx,0x84(%esi)
80103e19:	eb c8                	jmp    80103de3 <fork+0x113>
    return -1;
80103e1b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103e20:	eb d5                	jmp    80103df7 <fork+0x127>
    kfree(np->kstack);
80103e22:	8b 46 08             	mov    0x8(%esi),%eax
    return -1;
80103e25:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    kfree(np->kstack);
80103e2a:	89 04 24             	mov    %eax,(%esp)
80103e2d:	e8 ae e5 ff ff       	call   801023e0 <kfree>
    np->kstack = 0;
80103e32:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
    np->state = UNUSED;
80103e39:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    return -1;
80103e40:	eb b5                	jmp    80103df7 <fork+0x127>
80103e42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e50 <scheduler>:
{
80103e50:	55                   	push   %ebp
80103e51:	89 e5                	mov    %esp,%ebp
80103e53:	57                   	push   %edi
80103e54:	56                   	push   %esi
80103e55:	53                   	push   %ebx
80103e56:	83 ec 2c             	sub    $0x2c,%esp
  struct cpu *c = mycpu();
80103e59:	e8 22 fb ff ff       	call   80103980 <mycpu>
80103e5e:	89 c3                	mov    %eax,%ebx
  pushcli();
80103e60:	e8 2b 19 00 00       	call   80105790 <pushcli>
80103e65:	8d 73 04             	lea    0x4(%ebx),%esi
  c = mycpu();
80103e68:	e8 13 fb ff ff       	call   80103980 <mycpu>
  p = c->proc;
80103e6d:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80103e73:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  popcli();
80103e76:	e8 55 19 00 00       	call   801057d0 <popcli>
    c->proc = 0;
80103e7b:	31 c9                	xor    %ecx,%ecx
80103e7d:	89 8b ac 00 00 00    	mov    %ecx,0xac(%ebx)
80103e83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  asm volatile("sti");
80103e90:	fb                   	sti    
    acquire(&ptable.lock);
80103e91:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103e98:	e8 d3 19 00 00       	call   80105870 <acquire>
    counter++;
80103e9d:	a1 b8 b5 10 80       	mov    0x8010b5b8,%eax
80103ea2:	40                   	inc    %eax
80103ea3:	a3 b8 b5 10 80       	mov    %eax,0x8010b5b8
    switch (currpolicy) {
80103ea8:	a1 04 b0 10 80       	mov    0x8010b004,%eax
80103ead:	83 f8 02             	cmp    $0x2,%eax
80103eb0:	0f 84 5a 01 00 00    	je     80104010 <scheduler+0x1c0>
80103eb6:	83 f8 03             	cmp    $0x3,%eax
80103eb9:	0f 84 e1 00 00 00    	je     80103fa0 <scheduler+0x150>
80103ebf:	48                   	dec    %eax
            for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103ec0:	bf b4 3d 11 80       	mov    $0x80113db4,%edi
    switch (currpolicy) {
80103ec5:	74 71                	je     80103f38 <scheduler+0xe8>
80103ec7:	89 f6                	mov    %esi,%esi
80103ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
                if (p->state != RUNNABLE)
80103ed0:	8b 47 0c             	mov    0xc(%edi),%eax
80103ed3:	83 f8 03             	cmp    $0x3,%eax
80103ed6:	75 3a                	jne    80103f12 <scheduler+0xc2>
                c->proc = p;
80103ed8:	89 bb ac 00 00 00    	mov    %edi,0xac(%ebx)
                switchuvm(p);
80103ede:	89 3c 24             	mov    %edi,(%esp)
80103ee1:	e8 0a 3f 00 00       	call   80107df0 <switchuvm>
                p->state = RUNNING;
80103ee6:	c7 47 0c 04 00 00 00 	movl   $0x4,0xc(%edi)
                rpholder.add(p);
80103eed:	89 3c 24             	mov    %edi,(%esp)
80103ef0:	ff 15 c4 b5 10 80    	call   *0x8010b5c4
                swtch(&(c->scheduler), p->context);
80103ef6:	8b 47 1c             	mov    0x1c(%edi),%eax
80103ef9:	89 34 24             	mov    %esi,(%esp)
80103efc:	89 44 24 04          	mov    %eax,0x4(%esp)
80103f00:	e8 94 1c 00 00       	call   80105b99 <swtch>
                switchkvm();
80103f05:	e8 c6 3e 00 00       	call   80107dd0 <switchkvm>
                c->proc = 0;
80103f0a:	31 c0                	xor    %eax,%eax
80103f0c:	89 83 ac 00 00 00    	mov    %eax,0xac(%ebx)
            for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103f12:	81 c7 a4 00 00 00    	add    $0xa4,%edi
80103f18:	81 ff b4 66 11 80    	cmp    $0x801166b4,%edi
80103f1e:	72 b0                	jb     80103ed0 <scheduler+0x80>
      release(&ptable.lock);
80103f20:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103f27:	e8 e4 19 00 00       	call   80105910 <release>
    sti();
80103f2c:	e9 5f ff ff ff       	jmp    80103e90 <scheduler+0x40>
80103f31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            if (!rrq.isEmpty()) {
80103f38:	ff 15 d0 b5 10 80    	call   *0x8010b5d0
80103f3e:	85 c0                	test   %eax,%eax
80103f40:	75 de                	jne    80103f20 <scheduler+0xd0>
                p = rrq.dequeue();
80103f42:	ff 15 d8 b5 10 80    	call   *0x8010b5d8
                if (p != null) {
80103f48:	85 c0                	test   %eax,%eax
                p = rrq.dequeue();
80103f4a:	89 c7                	mov    %eax,%edi
                if (p != null) {
80103f4c:	74 d2                	je     80103f20 <scheduler+0xd0>
                    c->proc = p;
80103f4e:	89 bb ac 00 00 00    	mov    %edi,0xac(%ebx)
                    switchuvm(p);
80103f54:	89 3c 24             	mov    %edi,(%esp)
80103f57:	e8 94 3e 00 00       	call   80107df0 <switchuvm>
                    p->state = RUNNING;
80103f5c:	c7 47 0c 04 00 00 00 	movl   $0x4,0xc(%edi)
                    rpholder.add(p);
80103f63:	89 3c 24             	mov    %edi,(%esp)
80103f66:	ff 15 c4 b5 10 80    	call   *0x8010b5c4
                    swtch(&(c->scheduler), p->context);
80103f6c:	8b 47 1c             	mov    0x1c(%edi),%eax
80103f6f:	89 34 24             	mov    %esi,(%esp)
80103f72:	89 44 24 04          	mov    %eax,0x4(%esp)
80103f76:	e8 1e 1c 00 00       	call   80105b99 <swtch>
                    switchkvm();
80103f7b:	e8 50 3e 00 00       	call   80107dd0 <switchkvm>
                    c->proc = 0;
80103f80:	31 d2                	xor    %edx,%edx
80103f82:	89 93 ac 00 00 00    	mov    %edx,0xac(%ebx)
      release(&ptable.lock);
80103f88:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103f8f:	e8 7c 19 00 00       	call   80105910 <release>
80103f94:	e9 f7 fe ff ff       	jmp    80103e90 <scheduler+0x40>
80103f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            if (!pq.isEmpty()) {
80103fa0:	ff 15 e0 b5 10 80    	call   *0x8010b5e0
80103fa6:	85 c0                	test   %eax,%eax
80103fa8:	0f 85 72 ff ff ff    	jne    80103f20 <scheduler+0xd0>
                if( counter % 100 == 0)
80103fae:	8b 0d b8 b5 10 80    	mov    0x8010b5b8,%ecx
80103fb4:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
80103fb9:	f7 e9                	imul   %ecx
80103fbb:	89 d0                	mov    %edx,%eax
80103fbd:	89 ca                	mov    %ecx,%edx
80103fbf:	c1 f8 05             	sar    $0x5,%eax
80103fc2:	c1 fa 1f             	sar    $0x1f,%edx
80103fc5:	29 d0                	sub    %edx,%eax
80103fc7:	8d 04 80             	lea    (%eax,%eax,4),%eax
80103fca:	8d 04 80             	lea    (%eax,%eax,4),%eax
80103fcd:	c1 e0 02             	shl    $0x2,%eax
80103fd0:	39 c1                	cmp    %eax,%ecx
80103fd2:	74 6d                	je     80104041 <scheduler+0x1f1>
                    p = pq.extractMin();
80103fd4:	ff 15 ec b5 10 80    	call   *0x8010b5ec
80103fda:	89 c7                	mov    %eax,%edi
                if (p != null) {
80103fdc:	85 ff                	test   %edi,%edi
80103fde:	0f 84 3c ff ff ff    	je     80103f20 <scheduler+0xd0>
                    c->proc = p;
80103fe4:	89 bb ac 00 00 00    	mov    %edi,0xac(%ebx)
                    switchuvm(p);
80103fea:	89 3c 24             	mov    %edi,(%esp)
80103fed:	e8 fe 3d 00 00       	call   80107df0 <switchuvm>
                    p->state = RUNNING;
80103ff2:	c7 47 0c 04 00 00 00 	movl   $0x4,0xc(%edi)
                    p->RUNNABLE_wait_time=counter;
80103ff9:	a1 b8 b5 10 80       	mov    0x8010b5b8,%eax
80103ffe:	89 87 a0 00 00 00    	mov    %eax,0xa0(%edi)
80104004:	e9 5a ff ff ff       	jmp    80103f63 <scheduler+0x113>
80104009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            if (!pq.isEmpty()) {
80104010:	ff 15 e0 b5 10 80    	call   *0x8010b5e0
80104016:	85 c0                	test   %eax,%eax
80104018:	0f 85 02 ff ff ff    	jne    80103f20 <scheduler+0xd0>
8010401e:	66 90                	xchg   %ax,%ax
                p = pq.extractMin();
80104020:	ff 15 ec b5 10 80    	call   *0x8010b5ec
                if (p != null) {
80104026:	85 c0                	test   %eax,%eax
                p = pq.extractMin();
80104028:	89 c7                	mov    %eax,%edi
                if (p != null) {
8010402a:	0f 85 1e ff ff ff    	jne    80103f4e <scheduler+0xfe>
      release(&ptable.lock);
80104030:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80104037:	e8 d4 18 00 00       	call   80105910 <release>
8010403c:	e9 4f fe ff ff       	jmp    80103e90 <scheduler+0x40>
                    int min = MAXINT;
80104041:	b9 ff e7 76 48       	mov    $0x4876e7ff,%ecx
                    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104046:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
8010404b:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010404e:	eb 0c                	jmp    8010405c <scheduler+0x20c>
80104050:	05 a4 00 00 00       	add    $0xa4,%eax
80104055:	3d b4 66 11 80       	cmp    $0x801166b4,%eax
8010405a:	73 22                	jae    8010407e <scheduler+0x22e>
                        if ((p->state == RUNNABLE) && (p->RUNNABLE_wait_time < min)){
8010405c:	8b 50 0c             	mov    0xc(%eax),%edx
8010405f:	83 fa 03             	cmp    $0x3,%edx
80104062:	75 ec                	jne    80104050 <scheduler+0x200>
80104064:	8b 90 a0 00 00 00    	mov    0xa0(%eax),%edx
8010406a:	39 ca                	cmp    %ecx,%edx
8010406c:	7d e2                	jge    80104050 <scheduler+0x200>
8010406e:	89 c7                	mov    %eax,%edi
                    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104070:	05 a4 00 00 00       	add    $0xa4,%eax
80104075:	3d b4 66 11 80       	cmp    $0x801166b4,%eax
                        if ((p->state == RUNNABLE) && (p->RUNNABLE_wait_time < min)){
8010407a:	89 d1                	mov    %edx,%ecx
                    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
8010407c:	72 de                	jb     8010405c <scheduler+0x20c>
8010407e:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80104081:	e9 56 ff ff ff       	jmp    80103fdc <scheduler+0x18c>
80104086:	8d 76 00             	lea    0x0(%esi),%esi
80104089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104090 <sched>:
{
80104090:	55                   	push   %ebp
80104091:	89 e5                	mov    %esp,%ebp
80104093:	56                   	push   %esi
80104094:	53                   	push   %ebx
80104095:	83 ec 10             	sub    $0x10,%esp
  pushcli();
80104098:	e8 f3 16 00 00       	call   80105790 <pushcli>
  c = mycpu();
8010409d:	e8 de f8 ff ff       	call   80103980 <mycpu>
  p = c->proc;
801040a2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801040a8:	e8 23 17 00 00       	call   801057d0 <popcli>
  if(!holding(&ptable.lock))
801040ad:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
801040b4:	e8 77 17 00 00       	call   80105830 <holding>
801040b9:	85 c0                	test   %eax,%eax
801040bb:	74 51                	je     8010410e <sched+0x7e>
  if(mycpu()->ncli != 1)
801040bd:	e8 be f8 ff ff       	call   80103980 <mycpu>
801040c2:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
801040c9:	75 67                	jne    80104132 <sched+0xa2>
  if(p->state == RUNNING)
801040cb:	8b 43 0c             	mov    0xc(%ebx),%eax
801040ce:	83 f8 04             	cmp    $0x4,%eax
801040d1:	74 53                	je     80104126 <sched+0x96>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801040d3:	9c                   	pushf  
801040d4:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801040d5:	f6 c4 02             	test   $0x2,%ah
801040d8:	75 40                	jne    8010411a <sched+0x8a>
  intena = mycpu()->intena;
801040da:	e8 a1 f8 ff ff       	call   80103980 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
801040df:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
801040e2:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
801040e8:	e8 93 f8 ff ff       	call   80103980 <mycpu>
801040ed:	8b 40 04             	mov    0x4(%eax),%eax
801040f0:	89 1c 24             	mov    %ebx,(%esp)
801040f3:	89 44 24 04          	mov    %eax,0x4(%esp)
801040f7:	e8 9d 1a 00 00       	call   80105b99 <swtch>
  mycpu()->intena = intena;
801040fc:	e8 7f f8 ff ff       	call   80103980 <mycpu>
80104101:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104107:	83 c4 10             	add    $0x10,%esp
8010410a:	5b                   	pop    %ebx
8010410b:	5e                   	pop    %esi
8010410c:	5d                   	pop    %ebp
8010410d:	c3                   	ret    
    panic("sched ptable.lock");
8010410e:	c7 04 24 c0 8a 10 80 	movl   $0x80108ac0,(%esp)
80104115:	e8 56 c2 ff ff       	call   80100370 <panic>
    panic("sched interruptible");
8010411a:	c7 04 24 ec 8a 10 80 	movl   $0x80108aec,(%esp)
80104121:	e8 4a c2 ff ff       	call   80100370 <panic>
    panic("sched running");
80104126:	c7 04 24 de 8a 10 80 	movl   $0x80108ade,(%esp)
8010412d:	e8 3e c2 ff ff       	call   80100370 <panic>
    panic("sched locks");
80104132:	c7 04 24 d2 8a 10 80 	movl   $0x80108ad2,(%esp)
80104139:	e8 32 c2 ff ff       	call   80100370 <panic>
8010413e:	66 90                	xchg   %ax,%ax

80104140 <exit>:
{
80104140:	55                   	push   %ebp
80104141:	89 e5                	mov    %esp,%ebp
80104143:	57                   	push   %edi
80104144:	56                   	push   %esi
80104145:	53                   	push   %ebx
80104146:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80104149:	e8 42 16 00 00       	call   80105790 <pushcli>
  c = mycpu();
8010414e:	e8 2d f8 ff ff       	call   80103980 <mycpu>
  p = c->proc;
80104153:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104159:	e8 72 16 00 00       	call   801057d0 <popcli>
  curproc->exit_status=status;
8010415e:	8b 45 08             	mov    0x8(%ebp),%eax
  if(curproc == initproc)
80104161:	39 35 bc b5 10 80    	cmp    %esi,0x8010b5bc
  curproc->exit_status=status;
80104167:	89 46 7c             	mov    %eax,0x7c(%esi)
  if(curproc == initproc)
8010416a:	0f 84 b8 00 00 00    	je     80104228 <exit+0xe8>
80104170:	8d 5e 28             	lea    0x28(%esi),%ebx
80104173:	8d 7e 68             	lea    0x68(%esi),%edi
80104176:	8d 76 00             	lea    0x0(%esi),%esi
80104179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(curproc->ofile[fd]){
80104180:	8b 03                	mov    (%ebx),%eax
80104182:	85 c0                	test   %eax,%eax
80104184:	74 0e                	je     80104194 <exit+0x54>
      fileclose(curproc->ofile[fd]);
80104186:	89 04 24             	mov    %eax,(%esp)
80104189:	e8 a2 cc ff ff       	call   80100e30 <fileclose>
      curproc->ofile[fd] = 0;
8010418e:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104194:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80104197:	39 df                	cmp    %ebx,%edi
80104199:	75 e5                	jne    80104180 <exit+0x40>
  begin_op();
8010419b:	e8 f0 ea ff ff       	call   80102c90 <begin_op>
  iput(curproc->cwd);
801041a0:	8b 46 68             	mov    0x68(%esi),%eax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041a3:	bb b4 3d 11 80       	mov    $0x80113db4,%ebx
  iput(curproc->cwd);
801041a8:	89 04 24             	mov    %eax,(%esp)
801041ab:	e8 70 d6 ff ff       	call   80101820 <iput>
  end_op();
801041b0:	e8 4b eb ff ff       	call   80102d00 <end_op>
  curproc->cwd = 0;
801041b5:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
801041bc:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
801041c3:	e8 a8 16 00 00       	call   80105870 <acquire>
  wakeup1(curproc->parent);
801041c8:	8b 46 14             	mov    0x14(%esi),%eax
801041cb:	e8 c0 f8 ff ff       	call   80103a90 <wakeup1>
801041d0:	eb 14                	jmp    801041e6 <exit+0xa6>
801041d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041d8:	81 c3 a4 00 00 00    	add    $0xa4,%ebx
801041de:	81 fb b4 66 11 80    	cmp    $0x801166b4,%ebx
801041e4:	73 2a                	jae    80104210 <exit+0xd0>
    if(p->parent == curproc){
801041e6:	39 73 14             	cmp    %esi,0x14(%ebx)
801041e9:	75 ed                	jne    801041d8 <exit+0x98>
      if(p->state == ZOMBIE)
801041eb:	8b 53 0c             	mov    0xc(%ebx),%edx
      p->parent = initproc;
801041ee:	a1 bc b5 10 80       	mov    0x8010b5bc,%eax
      if(p->state == ZOMBIE)
801041f3:	83 fa 05             	cmp    $0x5,%edx
      p->parent = initproc;
801041f6:	89 43 14             	mov    %eax,0x14(%ebx)
      if(p->state == ZOMBIE)
801041f9:	75 dd                	jne    801041d8 <exit+0x98>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041fb:	81 c3 a4 00 00 00    	add    $0xa4,%ebx
        wakeup1(initproc);
80104201:	e8 8a f8 ff ff       	call   80103a90 <wakeup1>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104206:	81 fb b4 66 11 80    	cmp    $0x801166b4,%ebx
8010420c:	72 d8                	jb     801041e6 <exit+0xa6>
8010420e:	66 90                	xchg   %ax,%ax
  curproc->state = ZOMBIE;
80104210:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80104217:	e8 74 fe ff ff       	call   80104090 <sched>
  panic("zombie exit");
8010421c:	c7 04 24 0d 8b 10 80 	movl   $0x80108b0d,(%esp)
80104223:	e8 48 c1 ff ff       	call   80100370 <panic>
    panic("init exiting");
80104228:	c7 04 24 00 8b 10 80 	movl   $0x80108b00,(%esp)
8010422f:	e8 3c c1 ff ff       	call   80100370 <panic>
80104234:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010423a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104240 <yield>:
{
80104240:	55                   	push   %ebp
80104241:	89 e5                	mov    %esp,%ebp
80104243:	56                   	push   %esi
80104244:	53                   	push   %ebx
80104245:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104248:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
8010424f:	e8 1c 16 00 00       	call   80105870 <acquire>
  pushcli();
80104254:	e8 37 15 00 00       	call   80105790 <pushcli>
  c = mycpu();
80104259:	e8 22 f7 ff ff       	call   80103980 <mycpu>
  p = c->proc;
8010425e:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104264:	e8 67 15 00 00       	call   801057d0 <popcli>
  myproc()->state = RUNNABLE;
80104269:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  pushcli();
80104270:	e8 1b 15 00 00       	call   80105790 <pushcli>
  c = mycpu();
80104275:	e8 06 f7 ff ff       	call   80103980 <mycpu>
  p = c->proc;
8010427a:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104280:	e8 4b 15 00 00       	call   801057d0 <popcli>
  myproc()->accumulator+=myproc()->priority;
80104285:	8b 9b 88 00 00 00    	mov    0x88(%ebx),%ebx
  pushcli();
8010428b:	e8 00 15 00 00       	call   80105790 <pushcli>
  c = mycpu();
80104290:	e8 eb f6 ff ff       	call   80103980 <mycpu>
  p = c->proc;
80104295:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
8010429b:	e8 30 15 00 00       	call   801057d0 <popcli>
  myproc()->accumulator+=myproc()->priority;
801042a0:	89 d8                	mov    %ebx,%eax
801042a2:	99                   	cltd   
801042a3:	01 9e 80 00 00 00    	add    %ebx,0x80(%esi)
  rrq.enqueue(myproc());
801042a9:	8b 1d d4 b5 10 80    	mov    0x8010b5d4,%ebx
  myproc()->accumulator+=myproc()->priority;
801042af:	11 96 84 00 00 00    	adc    %edx,0x84(%esi)
  pushcli();
801042b5:	e8 d6 14 00 00       	call   80105790 <pushcli>
  c = mycpu();
801042ba:	e8 c1 f6 ff ff       	call   80103980 <mycpu>
  p = c->proc;
801042bf:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801042c5:	e8 06 15 00 00       	call   801057d0 <popcli>
  rrq.enqueue(myproc());
801042ca:	89 34 24             	mov    %esi,(%esp)
801042cd:	ff d3                	call   *%ebx
  pq.put(myproc()); //add to runabble queue
801042cf:	8b 1d e4 b5 10 80    	mov    0x8010b5e4,%ebx
  pushcli();
801042d5:	e8 b6 14 00 00       	call   80105790 <pushcli>
  c = mycpu();
801042da:	e8 a1 f6 ff ff       	call   80103980 <mycpu>
  p = c->proc;
801042df:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801042e5:	e8 e6 14 00 00       	call   801057d0 <popcli>
  pq.put(myproc()); //add to runabble queue
801042ea:	89 34 24             	mov    %esi,(%esp)
801042ed:	ff d3                	call   *%ebx
  rpholder.remove(myproc());//remove from running queue
801042ef:	8b 1d c8 b5 10 80    	mov    0x8010b5c8,%ebx
  pushcli();
801042f5:	e8 96 14 00 00       	call   80105790 <pushcli>
  c = mycpu();
801042fa:	e8 81 f6 ff ff       	call   80103980 <mycpu>
  p = c->proc;
801042ff:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104305:	e8 c6 14 00 00       	call   801057d0 <popcli>
  rpholder.remove(myproc());//remove from running queue
8010430a:	89 34 24             	mov    %esi,(%esp)
8010430d:	ff d3                	call   *%ebx
  sched();
8010430f:	e8 7c fd ff ff       	call   80104090 <sched>
  release(&ptable.lock);
80104314:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
8010431b:	e8 f0 15 00 00       	call   80105910 <release>
}
80104320:	83 c4 10             	add    $0x10,%esp
80104323:	5b                   	pop    %ebx
80104324:	5e                   	pop    %esi
80104325:	5d                   	pop    %ebp
80104326:	c3                   	ret    
80104327:	89 f6                	mov    %esi,%esi
80104329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104330 <sleep>:
{
80104330:	55                   	push   %ebp
80104331:	89 e5                	mov    %esp,%ebp
80104333:	83 ec 28             	sub    $0x28,%esp
80104336:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80104339:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010433c:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010433f:	8b 75 08             	mov    0x8(%ebp),%esi
80104342:	89 7d fc             	mov    %edi,-0x4(%ebp)
  pushcli();
80104345:	e8 46 14 00 00       	call   80105790 <pushcli>
  c = mycpu();
8010434a:	e8 31 f6 ff ff       	call   80103980 <mycpu>
  p = c->proc;
8010434f:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
80104355:	e8 76 14 00 00       	call   801057d0 <popcli>
  if(p == 0)
8010435a:	85 ff                	test   %edi,%edi
8010435c:	0f 84 ad 00 00 00    	je     8010440f <sleep+0xdf>
  if(lk == 0)
80104362:	85 db                	test   %ebx,%ebx
80104364:	0f 84 99 00 00 00    	je     80104403 <sleep+0xd3>
  p->accumulator+=p->priority;  // add the priority to the acc
8010436a:	8b 87 88 00 00 00    	mov    0x88(%edi),%eax
80104370:	99                   	cltd   
80104371:	01 87 80 00 00 00    	add    %eax,0x80(%edi)
80104377:	11 97 84 00 00 00    	adc    %edx,0x84(%edi)
  rpholder.remove(p); //remove p from RUNNING queue
8010437d:	89 3c 24             	mov    %edi,(%esp)
80104380:	ff 15 c8 b5 10 80    	call   *0x8010b5c8
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104386:	81 fb 80 3d 11 80    	cmp    $0x80113d80,%ebx
8010438c:	74 52                	je     801043e0 <sleep+0xb0>
    acquire(&ptable.lock);  //DOC: sleeplock1
8010438e:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80104395:	e8 d6 14 00 00       	call   80105870 <acquire>
    release(lk);
8010439a:	89 1c 24             	mov    %ebx,(%esp)
8010439d:	e8 6e 15 00 00       	call   80105910 <release>
  p->chan = chan;
801043a2:	89 77 20             	mov    %esi,0x20(%edi)
  p->state = SLEEPING;
801043a5:	c7 47 0c 02 00 00 00 	movl   $0x2,0xc(%edi)
  sched();
801043ac:	e8 df fc ff ff       	call   80104090 <sched>
  p->chan = 0;
801043b1:	c7 47 20 00 00 00 00 	movl   $0x0,0x20(%edi)
    release(&ptable.lock);
801043b8:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
801043bf:	e8 4c 15 00 00       	call   80105910 <release>
}
801043c4:	8b 75 f8             	mov    -0x8(%ebp),%esi
    acquire(lk);
801043c7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801043ca:	8b 7d fc             	mov    -0x4(%ebp),%edi
801043cd:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801043d0:	89 ec                	mov    %ebp,%esp
801043d2:	5d                   	pop    %ebp
    acquire(lk);
801043d3:	e9 98 14 00 00       	jmp    80105870 <acquire>
801043d8:	90                   	nop
801043d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
801043e0:	89 77 20             	mov    %esi,0x20(%edi)
  p->state = SLEEPING;
801043e3:	c7 47 0c 02 00 00 00 	movl   $0x2,0xc(%edi)
  sched();
801043ea:	e8 a1 fc ff ff       	call   80104090 <sched>
  p->chan = 0;
801043ef:	c7 47 20 00 00 00 00 	movl   $0x0,0x20(%edi)
}
801043f6:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801043f9:	8b 75 f8             	mov    -0x8(%ebp),%esi
801043fc:	8b 7d fc             	mov    -0x4(%ebp),%edi
801043ff:	89 ec                	mov    %ebp,%esp
80104401:	5d                   	pop    %ebp
80104402:	c3                   	ret    
    panic("sleep without lk");
80104403:	c7 04 24 1f 8b 10 80 	movl   $0x80108b1f,(%esp)
8010440a:	e8 61 bf ff ff       	call   80100370 <panic>
    panic("sleep");
8010440f:	c7 04 24 19 8b 10 80 	movl   $0x80108b19,(%esp)
80104416:	e8 55 bf ff ff       	call   80100370 <panic>
8010441b:	90                   	nop
8010441c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104420 <wait>:
{
80104420:	55                   	push   %ebp
80104421:	89 e5                	mov    %esp,%ebp
80104423:	56                   	push   %esi
80104424:	53                   	push   %ebx
80104425:	83 ec 10             	sub    $0x10,%esp
  pushcli();
80104428:	e8 63 13 00 00       	call   80105790 <pushcli>
  c = mycpu();
8010442d:	e8 4e f5 ff ff       	call   80103980 <mycpu>
  p = c->proc;
80104432:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104438:	e8 93 13 00 00       	call   801057d0 <popcli>
  acquire(&ptable.lock);
8010443d:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80104444:	e8 27 14 00 00       	call   80105870 <acquire>
    havekids = 0;
80104449:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010444b:	bb b4 3d 11 80       	mov    $0x80113db4,%ebx
80104450:	eb 14                	jmp    80104466 <wait+0x46>
80104452:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104458:	81 c3 a4 00 00 00    	add    $0xa4,%ebx
8010445e:	81 fb b4 66 11 80    	cmp    $0x801166b4,%ebx
80104464:	73 20                	jae    80104486 <wait+0x66>
      if(p->parent != curproc)
80104466:	39 73 14             	cmp    %esi,0x14(%ebx)
80104469:	75 ed                	jne    80104458 <wait+0x38>
      if(p->state == ZOMBIE){
8010446b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010446e:	83 f8 05             	cmp    $0x5,%eax
80104471:	74 35                	je     801044a8 <wait+0x88>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104473:	81 c3 a4 00 00 00    	add    $0xa4,%ebx
      havekids = 1;
80104479:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010447e:	81 fb b4 66 11 80    	cmp    $0x801166b4,%ebx
80104484:	72 e0                	jb     80104466 <wait+0x46>
    if(!havekids || curproc->killed){
80104486:	85 c0                	test   %eax,%eax
80104488:	74 79                	je     80104503 <wait+0xe3>
8010448a:	8b 56 24             	mov    0x24(%esi),%edx
8010448d:	85 d2                	test   %edx,%edx
8010448f:	75 72                	jne    80104503 <wait+0xe3>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104491:	b8 80 3d 11 80       	mov    $0x80113d80,%eax
80104496:	89 44 24 04          	mov    %eax,0x4(%esp)
8010449a:	89 34 24             	mov    %esi,(%esp)
8010449d:	e8 8e fe ff ff       	call   80104330 <sleep>
    havekids = 0;
801044a2:	eb a5                	jmp    80104449 <wait+0x29>
801044a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
801044a8:	8b 43 08             	mov    0x8(%ebx),%eax
        pid = p->pid;
801044ab:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801044ae:	89 04 24             	mov    %eax,(%esp)
801044b1:	e8 2a df ff ff       	call   801023e0 <kfree>
        freevm(p->pgdir);
801044b6:	8b 43 04             	mov    0x4(%ebx),%eax
        p->kstack = 0;
801044b9:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801044c0:	89 04 24             	mov    %eax,(%esp)
801044c3:	e8 d8 3c 00 00       	call   801081a0 <freevm>
        p->exit_status = (int)status ;
801044c8:	8b 45 08             	mov    0x8(%ebp),%eax
        release(&ptable.lock);
801044cb:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
        p->pid = 0;
801044d2:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801044d9:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801044e0:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801044e4:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801044eb:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        p->exit_status = (int)status ;
801044f2:	89 43 7c             	mov    %eax,0x7c(%ebx)
        release(&ptable.lock);
801044f5:	e8 16 14 00 00       	call   80105910 <release>
}
801044fa:	83 c4 10             	add    $0x10,%esp
801044fd:	89 f0                	mov    %esi,%eax
801044ff:	5b                   	pop    %ebx
80104500:	5e                   	pop    %esi
80104501:	5d                   	pop    %ebp
80104502:	c3                   	ret    
      release(&ptable.lock);
80104503:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
      return -1;
8010450a:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010450f:	e8 fc 13 00 00       	call   80105910 <release>
      return -1;
80104514:	eb e4                	jmp    801044fa <wait+0xda>
80104516:	8d 76 00             	lea    0x0(%esi),%esi
80104519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104520 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104520:	55                   	push   %ebp
80104521:	89 e5                	mov    %esp,%ebp
80104523:	53                   	push   %ebx
80104524:	83 ec 14             	sub    $0x14,%esp
80104527:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010452a:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80104531:	e8 3a 13 00 00       	call   80105870 <acquire>
  wakeup1(chan);
80104536:	89 d8                	mov    %ebx,%eax
80104538:	e8 53 f5 ff ff       	call   80103a90 <wakeup1>
  release(&ptable.lock);
8010453d:	c7 45 08 80 3d 11 80 	movl   $0x80113d80,0x8(%ebp)
}
80104544:	83 c4 14             	add    $0x14,%esp
80104547:	5b                   	pop    %ebx
80104548:	5d                   	pop    %ebp
  release(&ptable.lock);
80104549:	e9 c2 13 00 00       	jmp    80105910 <release>
8010454e:	66 90                	xchg   %ax,%ax

80104550 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104550:	55                   	push   %ebp
80104551:	89 e5                	mov    %esp,%ebp
80104553:	53                   	push   %ebx
80104554:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;

  acquire(&ptable.lock);
80104557:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
{
8010455e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80104561:	e8 0a 13 00 00       	call   80105870 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104566:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
8010456b:	eb 0f                	jmp    8010457c <kill+0x2c>
8010456d:	8d 76 00             	lea    0x0(%esi),%esi
80104570:	05 a4 00 00 00       	add    $0xa4,%eax
80104575:	3d b4 66 11 80       	cmp    $0x801166b4,%eax
8010457a:	73 54                	jae    801045d0 <kill+0x80>
    if(p->pid == pid){
8010457c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010457f:	75 ef                	jne    80104570 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING){
80104581:	8b 50 0c             	mov    0xc(%eax),%edx
      p->killed = 1;
80104584:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING){
8010458b:	83 fa 02             	cmp    $0x2,%edx
8010458e:	74 18                	je     801045a8 <kill+0x58>
          //TODO- priority queue addition
          p->accumulator+=p->priority;
          //pq.put(p);
          pushToSpecificQueue(p);
      }
      release(&ptable.lock);
80104590:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80104597:	e8 74 13 00 00       	call   80105910 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
8010459c:	83 c4 14             	add    $0x14,%esp
      return 0;
8010459f:	31 c0                	xor    %eax,%eax
}
801045a1:	5b                   	pop    %ebx
801045a2:	5d                   	pop    %ebp
801045a3:	c3                   	ret    
801045a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          p->accumulator+=p->priority;
801045a8:	8b 88 88 00 00 00    	mov    0x88(%eax),%ecx
          p->state = RUNNABLE;
801045ae:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
          p->accumulator+=p->priority;
801045b5:	89 cb                	mov    %ecx,%ebx
801045b7:	c1 fb 1f             	sar    $0x1f,%ebx
801045ba:	01 88 80 00 00 00    	add    %ecx,0x80(%eax)
801045c0:	11 98 84 00 00 00    	adc    %ebx,0x84(%eax)
          pushToSpecificQueue(p);
801045c6:	89 04 24             	mov    %eax,(%esp)
801045c9:	e8 82 f4 ff ff       	call   80103a50 <pushToSpecificQueue>
801045ce:	eb c0                	jmp    80104590 <kill+0x40>
  release(&ptable.lock);
801045d0:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
801045d7:	e8 34 13 00 00       	call   80105910 <release>
}
801045dc:	83 c4 14             	add    $0x14,%esp
  return -1;
801045df:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801045e4:	5b                   	pop    %ebx
801045e5:	5d                   	pop    %ebp
801045e6:	c3                   	ret    
801045e7:	89 f6                	mov    %esi,%esi
801045e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045f0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801045f0:	55                   	push   %ebp
801045f1:	89 e5                	mov    %esp,%ebp
801045f3:	57                   	push   %edi
801045f4:	56                   	push   %esi
801045f5:	53                   	push   %ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045f6:	bb b4 3d 11 80       	mov    $0x80113db4,%ebx
{
801045fb:	83 ec 4c             	sub    $0x4c,%esp
801045fe:	eb 1e                	jmp    8010461e <procdump+0x2e>
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104600:	c7 04 24 b9 8b 10 80 	movl   $0x80108bb9,(%esp)
80104607:	e8 44 c0 ff ff       	call   80100650 <cprintf>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010460c:	81 c3 a4 00 00 00    	add    $0xa4,%ebx
80104612:	81 fb b4 66 11 80    	cmp    $0x801166b4,%ebx
80104618:	0f 83 b2 00 00 00    	jae    801046d0 <procdump+0xe0>
    if(p->state == UNUSED)
8010461e:	8b 43 0c             	mov    0xc(%ebx),%eax
80104621:	85 c0                	test   %eax,%eax
80104623:	74 e7                	je     8010460c <procdump+0x1c>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104625:	8b 43 0c             	mov    0xc(%ebx),%eax
      state = "???";
80104628:	b8 30 8b 10 80       	mov    $0x80108b30,%eax
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010462d:	8b 53 0c             	mov    0xc(%ebx),%edx
80104630:	83 fa 05             	cmp    $0x5,%edx
80104633:	77 18                	ja     8010464d <procdump+0x5d>
80104635:	8b 53 0c             	mov    0xc(%ebx),%edx
80104638:	8b 14 95 90 8b 10 80 	mov    -0x7fef7470(,%edx,4),%edx
8010463f:	85 d2                	test   %edx,%edx
80104641:	74 0a                	je     8010464d <procdump+0x5d>
      state = states[p->state];
80104643:	8b 43 0c             	mov    0xc(%ebx),%eax
80104646:	8b 04 85 90 8b 10 80 	mov    -0x7fef7470(,%eax,4),%eax
    cprintf("%d %s %s", p->pid, state, p->name);
8010464d:	89 44 24 08          	mov    %eax,0x8(%esp)
80104651:	8b 43 10             	mov    0x10(%ebx),%eax
80104654:	8d 53 6c             	lea    0x6c(%ebx),%edx
80104657:	89 54 24 0c          	mov    %edx,0xc(%esp)
8010465b:	c7 04 24 34 8b 10 80 	movl   $0x80108b34,(%esp)
80104662:	89 44 24 04          	mov    %eax,0x4(%esp)
80104666:	e8 e5 bf ff ff       	call   80100650 <cprintf>
    if(p->state == SLEEPING){
8010466b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010466e:	83 f8 02             	cmp    $0x2,%eax
80104671:	75 8d                	jne    80104600 <procdump+0x10>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104673:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104676:	89 44 24 04          	mov    %eax,0x4(%esp)
8010467a:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010467d:	8d 75 c0             	lea    -0x40(%ebp),%esi
80104680:	8d 7d e8             	lea    -0x18(%ebp),%edi
80104683:	8b 40 0c             	mov    0xc(%eax),%eax
80104686:	83 c0 08             	add    $0x8,%eax
80104689:	89 04 24             	mov    %eax,(%esp)
8010468c:	e8 af 10 00 00       	call   80105740 <getcallerpcs>
80104691:	eb 0d                	jmp    801046a0 <procdump+0xb0>
80104693:	90                   	nop
80104694:	90                   	nop
80104695:	90                   	nop
80104696:	90                   	nop
80104697:	90                   	nop
80104698:	90                   	nop
80104699:	90                   	nop
8010469a:	90                   	nop
8010469b:	90                   	nop
8010469c:	90                   	nop
8010469d:	90                   	nop
8010469e:	90                   	nop
8010469f:	90                   	nop
      for(i=0; i<10 && pc[i] != 0; i++)
801046a0:	8b 16                	mov    (%esi),%edx
801046a2:	85 d2                	test   %edx,%edx
801046a4:	0f 84 56 ff ff ff    	je     80104600 <procdump+0x10>
        cprintf(" %p", pc[i]);
801046aa:	89 54 24 04          	mov    %edx,0x4(%esp)
801046ae:	83 c6 04             	add    $0x4,%esi
801046b1:	c7 04 24 21 85 10 80 	movl   $0x80108521,(%esp)
801046b8:	e8 93 bf ff ff       	call   80100650 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801046bd:	39 f7                	cmp    %esi,%edi
801046bf:	75 df                	jne    801046a0 <procdump+0xb0>
801046c1:	e9 3a ff ff ff       	jmp    80104600 <procdump+0x10>
801046c6:	8d 76 00             	lea    0x0(%esi),%esi
801046c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }
}
801046d0:	83 c4 4c             	add    $0x4c,%esp
801046d3:	5b                   	pop    %ebx
801046d4:	5e                   	pop    %esi
801046d5:	5f                   	pop    %edi
801046d6:	5d                   	pop    %ebp
801046d7:	c3                   	ret    
801046d8:	90                   	nop
801046d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801046e0 <detach>:

//TODO

int
detach(int pid)
{
801046e0:	55                   	push   %ebp
801046e1:	89 e5                	mov    %esp,%ebp
801046e3:	56                   	push   %esi
801046e4:	53                   	push   %ebx
801046e5:	83 ec 10             	sub    $0x10,%esp
801046e8:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801046eb:	e8 a0 10 00 00       	call   80105790 <pushcli>
  c = mycpu();
801046f0:	e8 8b f2 ff ff       	call   80103980 <mycpu>
  p = c->proc;
801046f5:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801046fb:	e8 d0 10 00 00       	call   801057d0 <popcli>
    struct proc *p;
    struct proc *curproc = myproc();
    //lock the ptable
    acquire(&ptable.lock);
80104700:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80104707:	e8 64 11 00 00       	call   80105870 <acquire>
    for(;;){
        // Scan through table looking for exited children with same pid as the argument.
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
8010470c:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
80104711:	eb 11                	jmp    80104724 <detach+0x44>
80104713:	90                   	nop
80104714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104718:	05 a4 00 00 00       	add    $0xa4,%eax
8010471d:	3d b4 66 11 80       	cmp    $0x801166b4,%eax
80104722:	73 2c                	jae    80104750 <detach+0x70>
            if (p->parent != curproc)
80104724:	39 58 14             	cmp    %ebx,0x14(%eax)
80104727:	75 ef                	jne    80104718 <detach+0x38>
                continue;
            //check if the pid is same as argument
            if (p->pid == pid) {
80104729:	39 70 10             	cmp    %esi,0x10(%eax)
8010472c:	75 ea                	jne    80104718 <detach+0x38>
                //change the father of current proc
                p->parent = initproc;
8010472e:	8b 15 bc b5 10 80    	mov    0x8010b5bc,%edx
80104734:	89 50 14             	mov    %edx,0x14(%eax)
                //release the ptable
                release(&ptable.lock);
80104737:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
8010473e:	e8 cd 11 00 00       	call   80105910 <release>
        }
        //if got here - didn't find proc with pid as argument - exit with error
        release(&ptable.lock);
        return -1;
    }
}
80104743:	83 c4 10             	add    $0x10,%esp
                return 0;
80104746:	31 c0                	xor    %eax,%eax
}
80104748:	5b                   	pop    %ebx
80104749:	5e                   	pop    %esi
8010474a:	5d                   	pop    %ebp
8010474b:	c3                   	ret    
8010474c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        release(&ptable.lock);
80104750:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80104757:	e8 b4 11 00 00       	call   80105910 <release>
}
8010475c:	83 c4 10             	add    $0x10,%esp
        return -1;
8010475f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104764:	5b                   	pop    %ebx
80104765:	5e                   	pop    %esi
80104766:	5d                   	pop    %ebp
80104767:	c3                   	ret    
80104768:	90                   	nop
80104769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104770 <priority>:


void
priority(int prio){
80104770:	55                   	push   %ebp
80104771:	89 e5                	mov    %esp,%ebp
80104773:	53                   	push   %ebx
80104774:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104777:	e8 14 10 00 00       	call   80105790 <pushcli>
  c = mycpu();
8010477c:	e8 ff f1 ff ff       	call   80103980 <mycpu>
  p = c->proc;
80104781:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104787:	e8 44 10 00 00       	call   801057d0 <popcli>
    struct proc *curproc = myproc();
    if(currpolicy==2){
8010478c:	a1 04 b0 10 80       	mov    0x8010b004,%eax
80104791:	83 f8 02             	cmp    $0x2,%eax
80104794:	74 1a                	je     801047b0 <priority+0x40>
        if(prio>0 &&prio<11)
            curproc->priority=prio;
    }
    if(currpolicy==3){
80104796:	83 f8 03             	cmp    $0x3,%eax
80104799:	75 0f                	jne    801047aa <priority+0x3a>
        if(prio>=0 &&prio<11)
8010479b:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
8010479f:	77 09                	ja     801047aa <priority+0x3a>
            curproc->priority=prio;
801047a1:	8b 45 08             	mov    0x8(%ebp),%eax
801047a4:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)
    }
    //curproc->priority=prio;
}
801047aa:	58                   	pop    %eax
801047ab:	5b                   	pop    %ebx
801047ac:	5d                   	pop    %ebp
801047ad:	c3                   	ret    
801047ae:	66 90                	xchg   %ax,%ax
        if(prio>0 &&prio<11)
801047b0:	8b 45 08             	mov    0x8(%ebp),%eax
801047b3:	48                   	dec    %eax
801047b4:	83 f8 09             	cmp    $0x9,%eax
801047b7:	76 e8                	jbe    801047a1 <priority+0x31>
}
801047b9:	58                   	pop    %eax
801047ba:	5b                   	pop    %ebx
801047bb:	5d                   	pop    %ebp
801047bc:	c3                   	ret    
801047bd:	8d 76 00             	lea    0x0(%esi),%esi

801047c0 <policy>:

void
policy(int num){
801047c0:	55                   	push   %ebp
801047c1:	89 e5                	mov    %esp,%ebp
801047c3:	8b 45 08             	mov    0x8(%ebp),%eax
  //TODO- need to check if there is a need to change to default or to panic
  if(num>3 || num<1)
    currpolicy=88; //currpolicy get the default policy
  else
    currpolicy=num;
}
801047c6:	5d                   	pop    %ebp
  if(num>3 || num<1)
801047c7:	8d 50 ff             	lea    -0x1(%eax),%edx
    currpolicy=88; //currpolicy get the default policy
801047ca:	83 fa 03             	cmp    $0x3,%edx
801047cd:	ba 58 00 00 00       	mov    $0x58,%edx
801047d2:	0f 43 c2             	cmovae %edx,%eax
801047d5:	a3 04 b0 10 80       	mov    %eax,0x8010b004
}
801047da:	c3                   	ret    
801047db:	90                   	nop
801047dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801047e0 <wait_stat>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait_stat(int* status, struct perf* performance)
{
801047e0:	55                   	push   %ebp
801047e1:	89 e5                	mov    %esp,%ebp
801047e3:	57                   	push   %edi
801047e4:	56                   	push   %esi
801047e5:	53                   	push   %ebx
801047e6:	83 ec 1c             	sub    $0x1c,%esp
801047e9:	8b 7d 08             	mov    0x8(%ebp),%edi
  pushcli();
801047ec:	e8 9f 0f 00 00       	call   80105790 <pushcli>
  c = mycpu();
801047f1:	e8 8a f1 ff ff       	call   80103980 <mycpu>
  p = c->proc;
801047f6:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801047fc:	e8 cf 0f 00 00       	call   801057d0 <popcli>
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();

  acquire(&ptable.lock);
80104801:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80104808:	e8 63 10 00 00       	call   80105870 <acquire>
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
8010480d:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010480f:	bb b4 3d 11 80       	mov    $0x80113db4,%ebx
80104814:	eb 18                	jmp    8010482e <wait_stat+0x4e>
80104816:	8d 76 00             	lea    0x0(%esi),%esi
80104819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104820:	81 c3 a4 00 00 00    	add    $0xa4,%ebx
80104826:	81 fb b4 66 11 80    	cmp    $0x801166b4,%ebx
8010482c:	73 20                	jae    8010484e <wait_stat+0x6e>
      if(p->parent != curproc)
8010482e:	39 73 14             	cmp    %esi,0x14(%ebx)
80104831:	75 ed                	jne    80104820 <wait_stat+0x40>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80104833:	8b 43 0c             	mov    0xc(%ebx),%eax
80104836:	83 f8 05             	cmp    $0x5,%eax
80104839:	74 35                	je     80104870 <wait_stat+0x90>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010483b:	81 c3 a4 00 00 00    	add    $0xa4,%ebx
      havekids = 1;
80104841:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104846:	81 fb b4 66 11 80    	cmp    $0x801166b4,%ebx
8010484c:	72 e0                	jb     8010482e <wait_stat+0x4e>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
8010484e:	85 c0                	test   %eax,%eax
80104850:	74 7b                	je     801048cd <wait_stat+0xed>
80104852:	8b 56 24             	mov    0x24(%esi),%edx
80104855:	85 d2                	test   %edx,%edx
80104857:	75 74                	jne    801048cd <wait_stat+0xed>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104859:	b8 80 3d 11 80       	mov    $0x80113d80,%eax
8010485e:	89 44 24 04          	mov    %eax,0x4(%esp)
80104862:	89 34 24             	mov    %esi,(%esp)
80104865:	e8 c6 fa ff ff       	call   80104330 <sleep>
    havekids = 0;
8010486a:	eb a1                	jmp    8010480d <wait_stat+0x2d>
8010486c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80104870:	8b 43 08             	mov    0x8(%ebx),%eax
        pid = p->pid;
80104873:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104876:	89 04 24             	mov    %eax,(%esp)
80104879:	e8 62 db ff ff       	call   801023e0 <kfree>
        freevm(p->pgdir);
8010487e:	8b 43 04             	mov    0x4(%ebx),%eax
        p->kstack = 0;
80104881:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104888:	89 04 24             	mov    %eax,(%esp)
8010488b:	e8 10 39 00 00       	call   801081a0 <freevm>
        if(status!=null)
80104890:	85 ff                	test   %edi,%edi
        p->pid = 0;
80104892:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104899:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801048a0:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801048a4:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801048ab:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        if(status!=null)
801048b2:	74 03                	je     801048b7 <wait_stat+0xd7>
          p->exit_status= (int)status ;
801048b4:	89 7b 7c             	mov    %edi,0x7c(%ebx)
        release(&ptable.lock);
801048b7:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
801048be:	e8 4d 10 00 00       	call   80105910 <release>
  }
}
801048c3:	83 c4 1c             	add    $0x1c,%esp
801048c6:	89 f0                	mov    %esi,%eax
801048c8:	5b                   	pop    %ebx
801048c9:	5e                   	pop    %esi
801048ca:	5f                   	pop    %edi
801048cb:	5d                   	pop    %ebp
801048cc:	c3                   	ret    
      release(&ptable.lock);
801048cd:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
      return -1;
801048d4:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801048d9:	e8 32 10 00 00       	call   80105910 <release>
      return -1;
801048de:	eb e3                	jmp    801048c3 <wait_stat+0xe3>

801048e0 <isEmptyPriorityQueue>:
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
801048e0:	a1 10 b6 10 80       	mov    0x8010b610,%eax
static boolean isEmptyPriorityQueue() {
801048e5:	55                   	push   %ebp
801048e6:	89 e5                	mov    %esp,%ebp
}
801048e8:	5d                   	pop    %ebp
	return !root;
801048e9:	8b 00                	mov    (%eax),%eax
801048eb:	85 c0                	test   %eax,%eax
801048ed:	0f 94 c0             	sete   %al
801048f0:	0f b6 c0             	movzbl %al,%eax
}
801048f3:	c3                   	ret    
801048f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801048fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104900 <getMinAccumulatorPriorityQueue>:
	return !root;
80104900:	a1 10 b6 10 80       	mov    0x8010b610,%eax
80104905:	8b 10                	mov    (%eax),%edx
	
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
	if(isEmpty())
80104907:	85 d2                	test   %edx,%edx
80104909:	74 35                	je     80104940 <getMinAccumulatorPriorityQueue+0x40>
static boolean getMinAccumulatorPriorityQueue(long long* pkey) {
8010490b:	55                   	push   %ebp
8010490c:	89 e5                	mov    %esp,%ebp
8010490e:	53                   	push   %ebx
8010490f:	eb 09                	jmp    8010491a <getMinAccumulatorPriorityQueue+0x1a>
80104911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	while(minNode->left)
80104918:	89 c2                	mov    %eax,%edx
8010491a:	8b 42 18             	mov    0x18(%edx),%eax
8010491d:	85 c0                	test   %eax,%eax
8010491f:	75 f7                	jne    80104918 <getMinAccumulatorPriorityQueue+0x18>
	*pkey = getMinNode()->key;
80104921:	8b 45 08             	mov    0x8(%ebp),%eax
80104924:	8b 5a 04             	mov    0x4(%edx),%ebx
80104927:	8b 0a                	mov    (%edx),%ecx
80104929:	89 58 04             	mov    %ebx,0x4(%eax)
8010492c:	89 08                	mov    %ecx,(%eax)
8010492e:	b8 01 00 00 00       	mov    $0x1,%eax
}
80104933:	5b                   	pop    %ebx
80104934:	5d                   	pop    %ebp
80104935:	c3                   	ret    
80104936:	8d 76 00             	lea    0x0(%esi),%esi
80104939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	if(isEmpty())
80104940:	31 c0                	xor    %eax,%eax
}
80104942:	c3                   	ret    
80104943:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104950 <isEmptyRoundRobinQueue>:
	return !first;
80104950:	a1 0c b6 10 80       	mov    0x8010b60c,%eax
static boolean isEmptyRoundRobinQueue() {
80104955:	55                   	push   %ebp
80104956:	89 e5                	mov    %esp,%ebp
}
80104958:	5d                   	pop    %ebp
	return !first;
80104959:	8b 00                	mov    (%eax),%eax
8010495b:	85 c0                	test   %eax,%eax
8010495d:	0f 94 c0             	sete   %al
80104960:	0f b6 c0             	movzbl %al,%eax
}
80104963:	c3                   	ret    
80104964:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010496a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104970 <enqueueRoundRobinQueue>:
	if(!freeLinks)
80104970:	a1 04 b6 10 80       	mov    0x8010b604,%eax
80104975:	85 c0                	test   %eax,%eax
80104977:	74 47                	je     801049c0 <enqueueRoundRobinQueue+0x50>
static boolean enqueueRoundRobinQueue(Proc *p) {
80104979:	55                   	push   %ebp
	return roundRobinQ->enqueue(p);
8010497a:	8b 0d 0c b6 10 80    	mov    0x8010b60c,%ecx
	freeLinks = freeLinks->next;
80104980:	8b 50 04             	mov    0x4(%eax),%edx
static boolean enqueueRoundRobinQueue(Proc *p) {
80104983:	89 e5                	mov    %esp,%ebp
	ans->next = null;
80104985:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
8010498c:	89 15 04 b6 10 80    	mov    %edx,0x8010b604
	ans->p = p;
80104992:	8b 55 08             	mov    0x8(%ebp),%edx
80104995:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80104997:	8b 11                	mov    (%ecx),%edx
80104999:	85 d2                	test   %edx,%edx
8010499b:	74 2b                	je     801049c8 <enqueueRoundRobinQueue+0x58>
	else last->next = link;
8010499d:	8b 51 04             	mov    0x4(%ecx),%edx
801049a0:	89 42 04             	mov    %eax,0x4(%edx)
801049a3:	eb 05                	jmp    801049aa <enqueueRoundRobinQueue+0x3a>
801049a5:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
801049a8:	89 d0                	mov    %edx,%eax
801049aa:	8b 50 04             	mov    0x4(%eax),%edx
801049ad:	85 d2                	test   %edx,%edx
801049af:	75 f7                	jne    801049a8 <enqueueRoundRobinQueue+0x38>
	last = link->getLast();
801049b1:	89 41 04             	mov    %eax,0x4(%ecx)
801049b4:	b8 01 00 00 00       	mov    $0x1,%eax
}
801049b9:	5d                   	pop    %ebp
801049ba:	c3                   	ret    
801049bb:	90                   	nop
801049bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!freeLinks)
801049c0:	31 c0                	xor    %eax,%eax
}
801049c2:	c3                   	ret    
801049c3:	90                   	nop
801049c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
801049c8:	89 01                	mov    %eax,(%ecx)
801049ca:	eb de                	jmp    801049aa <enqueueRoundRobinQueue+0x3a>
801049cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801049d0 <dequeueRoundRobinQueue>:
	return roundRobinQ->dequeue();
801049d0:	8b 0d 0c b6 10 80    	mov    0x8010b60c,%ecx
	return !first;
801049d6:	8b 11                	mov    (%ecx),%edx
	if(isEmpty())
801049d8:	85 d2                	test   %edx,%edx
801049da:	74 3c                	je     80104a18 <dequeueRoundRobinQueue+0x48>
static Proc* dequeueRoundRobinQueue() {
801049dc:	55                   	push   %ebp
801049dd:	89 e5                	mov    %esp,%ebp
801049df:	83 ec 08             	sub    $0x8,%esp
801049e2:	89 75 fc             	mov    %esi,-0x4(%ebp)
	link->next = freeLinks;
801049e5:	8b 35 04 b6 10 80    	mov    0x8010b604,%esi
static Proc* dequeueRoundRobinQueue() {
801049eb:	89 5d f8             	mov    %ebx,-0x8(%ebp)
	Link *next = first->next;
801049ee:	8b 5a 04             	mov    0x4(%edx),%ebx
	Proc *p = first->p;
801049f1:	8b 02                	mov    (%edx),%eax
	link->next = freeLinks;
801049f3:	89 72 04             	mov    %esi,0x4(%edx)
	freeLinks = link;
801049f6:	89 15 04 b6 10 80    	mov    %edx,0x8010b604
	if(isEmpty())
801049fc:	85 db                	test   %ebx,%ebx
	first = next;
801049fe:	89 19                	mov    %ebx,(%ecx)
	if(isEmpty())
80104a00:	75 07                	jne    80104a09 <dequeueRoundRobinQueue+0x39>
		last = null;
80104a02:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
}
80104a09:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104a0c:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104a0f:	89 ec                	mov    %ebp,%esp
80104a11:	5d                   	pop    %ebp
80104a12:	c3                   	ret    
80104a13:	90                   	nop
80104a14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		return null;
80104a18:	31 c0                	xor    %eax,%eax
}
80104a1a:	c3                   	ret    
80104a1b:	90                   	nop
80104a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104a20 <isEmptyRunningProcessHolder>:
	return !first;
80104a20:	a1 08 b6 10 80       	mov    0x8010b608,%eax
static boolean isEmptyRunningProcessHolder() {
80104a25:	55                   	push   %ebp
80104a26:	89 e5                	mov    %esp,%ebp
}
80104a28:	5d                   	pop    %ebp
	return !first;
80104a29:	8b 00                	mov    (%eax),%eax
80104a2b:	85 c0                	test   %eax,%eax
80104a2d:	0f 94 c0             	sete   %al
80104a30:	0f b6 c0             	movzbl %al,%eax
}
80104a33:	c3                   	ret    
80104a34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104a40 <addRunningProcessHolder>:
	if(!freeLinks)
80104a40:	a1 04 b6 10 80       	mov    0x8010b604,%eax
80104a45:	85 c0                	test   %eax,%eax
80104a47:	74 47                	je     80104a90 <addRunningProcessHolder+0x50>
static boolean addRunningProcessHolder(Proc* p) {
80104a49:	55                   	push   %ebp
	return runningProcHolder->enqueue(p);
80104a4a:	8b 0d 08 b6 10 80    	mov    0x8010b608,%ecx
	freeLinks = freeLinks->next;
80104a50:	8b 50 04             	mov    0x4(%eax),%edx
static boolean addRunningProcessHolder(Proc* p) {
80104a53:	89 e5                	mov    %esp,%ebp
	ans->next = null;
80104a55:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
80104a5c:	89 15 04 b6 10 80    	mov    %edx,0x8010b604
	ans->p = p;
80104a62:	8b 55 08             	mov    0x8(%ebp),%edx
80104a65:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80104a67:	8b 11                	mov    (%ecx),%edx
80104a69:	85 d2                	test   %edx,%edx
80104a6b:	74 2b                	je     80104a98 <addRunningProcessHolder+0x58>
	else last->next = link;
80104a6d:	8b 51 04             	mov    0x4(%ecx),%edx
80104a70:	89 42 04             	mov    %eax,0x4(%edx)
80104a73:	eb 05                	jmp    80104a7a <addRunningProcessHolder+0x3a>
80104a75:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
80104a78:	89 d0                	mov    %edx,%eax
80104a7a:	8b 50 04             	mov    0x4(%eax),%edx
80104a7d:	85 d2                	test   %edx,%edx
80104a7f:	75 f7                	jne    80104a78 <addRunningProcessHolder+0x38>
	last = link->getLast();
80104a81:	89 41 04             	mov    %eax,0x4(%ecx)
80104a84:	b8 01 00 00 00       	mov    $0x1,%eax
}
80104a89:	5d                   	pop    %ebp
80104a8a:	c3                   	ret    
80104a8b:	90                   	nop
80104a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!freeLinks)
80104a90:	31 c0                	xor    %eax,%eax
}
80104a92:	c3                   	ret    
80104a93:	90                   	nop
80104a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
80104a98:	89 01                	mov    %eax,(%ecx)
80104a9a:	eb de                	jmp    80104a7a <addRunningProcessHolder+0x3a>
80104a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104aa0 <_ZL9allocNodeP4procx>:
static MapNode* allocNode(Proc *p, long long key) {
80104aa0:	55                   	push   %ebp
80104aa1:	89 e5                	mov    %esp,%ebp
80104aa3:	56                   	push   %esi
80104aa4:	53                   	push   %ebx
	if(!freeNodes)
80104aa5:	8b 1d 00 b6 10 80    	mov    0x8010b600,%ebx
80104aab:	85 db                	test   %ebx,%ebx
80104aad:	74 4d                	je     80104afc <_ZL9allocNodeP4procx+0x5c>
	ans->key = key;
80104aaf:	89 13                	mov    %edx,(%ebx)
	if(!freeLinks)
80104ab1:	8b 15 04 b6 10 80    	mov    0x8010b604,%edx
	freeNodes = freeNodes->next;
80104ab7:	8b 73 10             	mov    0x10(%ebx),%esi
	ans->key = key;
80104aba:	89 4b 04             	mov    %ecx,0x4(%ebx)
	ans->next = null;
80104abd:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
	if(!freeLinks)
80104ac4:	85 d2                	test   %edx,%edx
	freeNodes = freeNodes->next;
80104ac6:	89 35 00 b6 10 80    	mov    %esi,0x8010b600
	if(!freeLinks)
80104acc:	74 3f                	je     80104b0d <_ZL9allocNodeP4procx+0x6d>
	freeLinks = freeLinks->next;
80104ace:	8b 4a 04             	mov    0x4(%edx),%ecx
	ans->p = p;
80104ad1:	89 02                	mov    %eax,(%edx)
	ans->next = null;
80104ad3:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
	if(isEmpty()) first = link;
80104ada:	8b 43 08             	mov    0x8(%ebx),%eax
	freeLinks = freeLinks->next;
80104add:	89 0d 04 b6 10 80    	mov    %ecx,0x8010b604
	if(isEmpty()) first = link;
80104ae3:	85 c0                	test   %eax,%eax
80104ae5:	74 21                	je     80104b08 <_ZL9allocNodeP4procx+0x68>
	else last->next = link;
80104ae7:	8b 43 0c             	mov    0xc(%ebx),%eax
80104aea:	89 50 04             	mov    %edx,0x4(%eax)
80104aed:	eb 03                	jmp    80104af2 <_ZL9allocNodeP4procx+0x52>
80104aef:	90                   	nop
	while(ans->next)
80104af0:	89 ca                	mov    %ecx,%edx
80104af2:	8b 4a 04             	mov    0x4(%edx),%ecx
80104af5:	85 c9                	test   %ecx,%ecx
80104af7:	75 f7                	jne    80104af0 <_ZL9allocNodeP4procx+0x50>
	last = link->getLast();
80104af9:	89 53 0c             	mov    %edx,0xc(%ebx)
}
80104afc:	89 d8                	mov    %ebx,%eax
80104afe:	5b                   	pop    %ebx
80104aff:	5e                   	pop    %esi
80104b00:	5d                   	pop    %ebp
80104b01:	c3                   	ret    
80104b02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	if(isEmpty()) first = link;
80104b08:	89 53 08             	mov    %edx,0x8(%ebx)
80104b0b:	eb e5                	jmp    80104af2 <_ZL9allocNodeP4procx+0x52>
	node->parent = node->left = node->right = null;
80104b0d:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
80104b14:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
80104b1b:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
	node->next = freeNodes;
80104b22:	89 73 10             	mov    %esi,0x10(%ebx)
	freeNodes = node;
80104b25:	89 1d 00 b6 10 80    	mov    %ebx,0x8010b600
		return null;
80104b2b:	31 db                	xor    %ebx,%ebx
80104b2d:	eb cd                	jmp    80104afc <_ZL9allocNodeP4procx+0x5c>
80104b2f:	90                   	nop

80104b30 <_ZL8mymallocj>:
static char* mymalloc(uint size) {
80104b30:	55                   	push   %ebp
80104b31:	89 e5                	mov    %esp,%ebp
80104b33:	53                   	push   %ebx
80104b34:	89 c3                	mov    %eax,%ebx
80104b36:	83 ec 14             	sub    $0x14,%esp
	if(spaceLeft < size) {
80104b39:	8b 15 f8 b5 10 80    	mov    0x8010b5f8,%edx
80104b3f:	39 c2                	cmp    %eax,%edx
80104b41:	73 26                	jae    80104b69 <_ZL8mymallocj+0x39>
		data = kalloc();
80104b43:	e8 68 da ff ff       	call   801025b0 <kalloc>
		memset(data, 0, PGSIZE);
80104b48:	ba 00 10 00 00       	mov    $0x1000,%edx
80104b4d:	31 c9                	xor    %ecx,%ecx
80104b4f:	89 54 24 08          	mov    %edx,0x8(%esp)
80104b53:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80104b57:	89 04 24             	mov    %eax,(%esp)
		data = kalloc();
80104b5a:	a3 fc b5 10 80       	mov    %eax,0x8010b5fc
		memset(data, 0, PGSIZE);
80104b5f:	e8 fc 0d 00 00       	call   80105960 <memset>
80104b64:	ba 00 10 00 00       	mov    $0x1000,%edx
	char* ans = data;
80104b69:	a1 fc b5 10 80       	mov    0x8010b5fc,%eax
	spaceLeft -= size;
80104b6e:	29 da                	sub    %ebx,%edx
80104b70:	89 15 f8 b5 10 80    	mov    %edx,0x8010b5f8
	data += size;
80104b76:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
80104b79:	89 0d fc b5 10 80    	mov    %ecx,0x8010b5fc
}
80104b7f:	83 c4 14             	add    $0x14,%esp
80104b82:	5b                   	pop    %ebx
80104b83:	5d                   	pop    %ebp
80104b84:	c3                   	ret    
80104b85:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b90 <initSchedDS>:
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104b90:	55                   	push   %ebp
	data               = null;
80104b91:	31 c0                	xor    %eax,%eax
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104b93:	89 e5                	mov    %esp,%ebp
80104b95:	53                   	push   %ebx
	freeLinks = null;
80104b96:	bb 80 00 00 00       	mov    $0x80,%ebx
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104b9b:	83 ec 04             	sub    $0x4,%esp
	data               = null;
80104b9e:	a3 fc b5 10 80       	mov    %eax,0x8010b5fc
	spaceLeft          = 0u;
80104ba3:	31 c0                	xor    %eax,%eax
80104ba5:	a3 f8 b5 10 80       	mov    %eax,0x8010b5f8
	priorityQ          = (Map*)mymalloc(sizeof(Map));
80104baa:	b8 04 00 00 00       	mov    $0x4,%eax
80104baf:	e8 7c ff ff ff       	call   80104b30 <_ZL8mymallocj>
80104bb4:	a3 10 b6 10 80       	mov    %eax,0x8010b610
	*priorityQ         = Map();
80104bb9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	roundRobinQ        = (LinkedList*)mymalloc(sizeof(LinkedList));
80104bbf:	b8 08 00 00 00       	mov    $0x8,%eax
80104bc4:	e8 67 ff ff ff       	call   80104b30 <_ZL8mymallocj>
80104bc9:	a3 0c b6 10 80       	mov    %eax,0x8010b60c
	*roundRobinQ       = LinkedList();
80104bce:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104bd4:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	runningProcHolder  = (LinkedList*)mymalloc(sizeof(LinkedList));
80104bdb:	b8 08 00 00 00       	mov    $0x8,%eax
80104be0:	e8 4b ff ff ff       	call   80104b30 <_ZL8mymallocj>
80104be5:	a3 08 b6 10 80       	mov    %eax,0x8010b608
	*runningProcHolder = LinkedList();
80104bea:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104bf0:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = null;
80104bf7:	31 c0                	xor    %eax,%eax
80104bf9:	a3 04 b6 10 80       	mov    %eax,0x8010b604
80104bfe:	66 90                	xchg   %ax,%ax
		Link *link = (Link*)mymalloc(sizeof(Link));
80104c00:	b8 08 00 00 00       	mov    $0x8,%eax
80104c05:	e8 26 ff ff ff       	call   80104b30 <_ZL8mymallocj>
		link->next = freeLinks;
80104c0a:	8b 15 04 b6 10 80    	mov    0x8010b604,%edx
	for(int i = 0; i < NPROCLIST; ++i) {
80104c10:	4b                   	dec    %ebx
		*link = Link();
80104c11:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		link->next = freeLinks;
80104c17:	89 50 04             	mov    %edx,0x4(%eax)
		freeLinks = link;
80104c1a:	a3 04 b6 10 80       	mov    %eax,0x8010b604
	for(int i = 0; i < NPROCLIST; ++i) {
80104c1f:	75 df                	jne    80104c00 <initSchedDS+0x70>
	freeNodes = null;
80104c21:	31 c0                	xor    %eax,%eax
80104c23:	bb 80 00 00 00       	mov    $0x80,%ebx
80104c28:	a3 00 b6 10 80       	mov    %eax,0x8010b600
80104c2d:	8d 76 00             	lea    0x0(%esi),%esi
		MapNode *node = (MapNode*)mymalloc(sizeof(MapNode));
80104c30:	b8 20 00 00 00       	mov    $0x20,%eax
80104c35:	e8 f6 fe ff ff       	call   80104b30 <_ZL8mymallocj>
		node->next = freeNodes;
80104c3a:	8b 15 00 b6 10 80    	mov    0x8010b600,%edx
	for(int i = 0; i < NPROCMAP; ++i) {
80104c40:	4b                   	dec    %ebx
		*node = MapNode();
80104c41:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80104c48:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
80104c4f:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
80104c56:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
80104c5d:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
		node->next = freeNodes;
80104c64:	89 50 10             	mov    %edx,0x10(%eax)
		freeNodes = node;
80104c67:	a3 00 b6 10 80       	mov    %eax,0x8010b600
	for(int i = 0; i < NPROCMAP; ++i) {
80104c6c:	75 c2                	jne    80104c30 <initSchedDS+0xa0>
	pq.isEmpty                      = isEmptyPriorityQueue;
80104c6e:	b8 e0 48 10 80       	mov    $0x801048e0,%eax
	pq.put                          = putPriorityQueue;
80104c73:	ba 60 52 10 80       	mov    $0x80105260,%edx
	pq.isEmpty                      = isEmptyPriorityQueue;
80104c78:	a3 e0 b5 10 80       	mov    %eax,0x8010b5e0
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
80104c7d:	b8 20 54 10 80       	mov    $0x80105420,%eax
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
80104c82:	b9 00 49 10 80       	mov    $0x80104900,%ecx
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
80104c87:	a3 f0 b5 10 80       	mov    %eax,0x8010b5f0
	pq.extractProc                  = extractProcPriorityQueue;
80104c8c:	b8 00 55 10 80       	mov    $0x80105500,%eax
	pq.extractMin                   = extractMinPriorityQueue;
80104c91:	bb 80 53 10 80       	mov    $0x80105380,%ebx
	pq.extractProc                  = extractProcPriorityQueue;
80104c96:	a3 f4 b5 10 80       	mov    %eax,0x8010b5f4
	rrq.isEmpty                     = isEmptyRoundRobinQueue;
80104c9b:	b8 50 49 10 80       	mov    $0x80104950,%eax
80104ca0:	a3 d0 b5 10 80       	mov    %eax,0x8010b5d0
	rrq.enqueue                     = enqueueRoundRobinQueue;
80104ca5:	b8 70 49 10 80       	mov    $0x80104970,%eax
80104caa:	a3 d4 b5 10 80       	mov    %eax,0x8010b5d4
	rrq.dequeue                     = dequeueRoundRobinQueue;
80104caf:	b8 d0 49 10 80       	mov    $0x801049d0,%eax
80104cb4:	a3 d8 b5 10 80       	mov    %eax,0x8010b5d8
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;
80104cb9:	b8 90 4f 10 80       	mov    $0x80104f90,%eax
	pq.put                          = putPriorityQueue;
80104cbe:	89 15 e4 b5 10 80    	mov    %edx,0x8010b5e4
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
80104cc4:	ba 20 4a 10 80       	mov    $0x80104a20,%edx
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
80104cc9:	89 0d e8 b5 10 80    	mov    %ecx,0x8010b5e8
	rpholder.add                    = addRunningProcessHolder;
80104ccf:	b9 40 4a 10 80       	mov    $0x80104a40,%ecx
	pq.extractMin                   = extractMinPriorityQueue;
80104cd4:	89 1d ec b5 10 80    	mov    %ebx,0x8010b5ec
	rpholder.remove                 = removeRunningProcessHolder;
80104cda:	bb f0 4e 10 80       	mov    $0x80104ef0,%ebx
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;
80104cdf:	a3 dc b5 10 80       	mov    %eax,0x8010b5dc
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
80104ce4:	b8 20 50 10 80       	mov    $0x80105020,%eax
	rpholder.remove                 = removeRunningProcessHolder;
80104ce9:	89 1d c8 b5 10 80    	mov    %ebx,0x8010b5c8
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
80104cef:	89 15 c0 b5 10 80    	mov    %edx,0x8010b5c0
	rpholder.add                    = addRunningProcessHolder;
80104cf5:	89 0d c4 b5 10 80    	mov    %ecx,0x8010b5c4
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
80104cfb:	a3 cc b5 10 80       	mov    %eax,0x8010b5cc
}
80104d00:	58                   	pop    %eax
80104d01:	5b                   	pop    %ebx
80104d02:	5d                   	pop    %ebp
80104d03:	c3                   	ret    
80104d04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104d10 <_ZN4Link7getLastEv>:
Link* Link::getLast() {
80104d10:	55                   	push   %ebp
80104d11:	89 e5                	mov    %esp,%ebp
80104d13:	8b 45 08             	mov    0x8(%ebp),%eax
80104d16:	eb 0a                	jmp    80104d22 <_ZN4Link7getLastEv+0x12>
80104d18:	90                   	nop
80104d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d20:	89 d0                	mov    %edx,%eax
	while(ans->next)
80104d22:	8b 50 04             	mov    0x4(%eax),%edx
80104d25:	85 d2                	test   %edx,%edx
80104d27:	75 f7                	jne    80104d20 <_ZN4Link7getLastEv+0x10>
}
80104d29:	5d                   	pop    %ebp
80104d2a:	c3                   	ret    
80104d2b:	90                   	nop
80104d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104d30 <_ZN10LinkedList7isEmptyEv>:
bool LinkedList::isEmpty() {
80104d30:	55                   	push   %ebp
80104d31:	89 e5                	mov    %esp,%ebp
	return !first;
80104d33:	8b 45 08             	mov    0x8(%ebp),%eax
}
80104d36:	5d                   	pop    %ebp
	return !first;
80104d37:	8b 00                	mov    (%eax),%eax
80104d39:	85 c0                	test   %eax,%eax
80104d3b:	0f 94 c0             	sete   %al
}
80104d3e:	c3                   	ret    
80104d3f:	90                   	nop

80104d40 <_ZN10LinkedList6appendEP4Link>:
void LinkedList::append(Link *link) {
80104d40:	55                   	push   %ebp
80104d41:	89 e5                	mov    %esp,%ebp
80104d43:	8b 55 0c             	mov    0xc(%ebp),%edx
80104d46:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!link)
80104d49:	85 d2                	test   %edx,%edx
80104d4b:	74 1f                	je     80104d6c <_ZN10LinkedList6appendEP4Link+0x2c>
	if(isEmpty()) first = link;
80104d4d:	8b 01                	mov    (%ecx),%eax
80104d4f:	85 c0                	test   %eax,%eax
80104d51:	74 1d                	je     80104d70 <_ZN10LinkedList6appendEP4Link+0x30>
	else last->next = link;
80104d53:	8b 41 04             	mov    0x4(%ecx),%eax
80104d56:	89 50 04             	mov    %edx,0x4(%eax)
80104d59:	eb 07                	jmp    80104d62 <_ZN10LinkedList6appendEP4Link+0x22>
80104d5b:	90                   	nop
80104d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	while(ans->next)
80104d60:	89 c2                	mov    %eax,%edx
80104d62:	8b 42 04             	mov    0x4(%edx),%eax
80104d65:	85 c0                	test   %eax,%eax
80104d67:	75 f7                	jne    80104d60 <_ZN10LinkedList6appendEP4Link+0x20>
	last = link->getLast();
80104d69:	89 51 04             	mov    %edx,0x4(%ecx)
}
80104d6c:	5d                   	pop    %ebp
80104d6d:	c3                   	ret    
80104d6e:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
80104d70:	89 11                	mov    %edx,(%ecx)
80104d72:	eb ee                	jmp    80104d62 <_ZN10LinkedList6appendEP4Link+0x22>
80104d74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104d80 <_ZN10LinkedList7enqueueEP4proc>:
	if(!freeLinks)
80104d80:	a1 04 b6 10 80       	mov    0x8010b604,%eax
bool LinkedList::enqueue(Proc *p) {
80104d85:	55                   	push   %ebp
80104d86:	89 e5                	mov    %esp,%ebp
80104d88:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!freeLinks)
80104d8b:	85 c0                	test   %eax,%eax
80104d8d:	74 41                	je     80104dd0 <_ZN10LinkedList7enqueueEP4proc+0x50>
	freeLinks = freeLinks->next;
80104d8f:	8b 50 04             	mov    0x4(%eax),%edx
	ans->next = null;
80104d92:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
80104d99:	89 15 04 b6 10 80    	mov    %edx,0x8010b604
	ans->p = p;
80104d9f:	8b 55 0c             	mov    0xc(%ebp),%edx
80104da2:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80104da4:	8b 11                	mov    (%ecx),%edx
80104da6:	85 d2                	test   %edx,%edx
80104da8:	74 2e                	je     80104dd8 <_ZN10LinkedList7enqueueEP4proc+0x58>
	else last->next = link;
80104daa:	8b 51 04             	mov    0x4(%ecx),%edx
80104dad:	89 42 04             	mov    %eax,0x4(%edx)
80104db0:	eb 08                	jmp    80104dba <_ZN10LinkedList7enqueueEP4proc+0x3a>
80104db2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	while(ans->next)
80104db8:	89 d0                	mov    %edx,%eax
80104dba:	8b 50 04             	mov    0x4(%eax),%edx
80104dbd:	85 d2                	test   %edx,%edx
80104dbf:	75 f7                	jne    80104db8 <_ZN10LinkedList7enqueueEP4proc+0x38>
	last = link->getLast();
80104dc1:	89 41 04             	mov    %eax,0x4(%ecx)
	return true;
80104dc4:	b0 01                	mov    $0x1,%al
}
80104dc6:	5d                   	pop    %ebp
80104dc7:	c3                   	ret    
80104dc8:	90                   	nop
80104dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return false;
80104dd0:	31 c0                	xor    %eax,%eax
}
80104dd2:	5d                   	pop    %ebp
80104dd3:	c3                   	ret    
80104dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
80104dd8:	89 01                	mov    %eax,(%ecx)
80104dda:	eb de                	jmp    80104dba <_ZN10LinkedList7enqueueEP4proc+0x3a>
80104ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104de0 <_ZN10LinkedList7dequeueEv>:
Proc* LinkedList::dequeue() {
80104de0:	55                   	push   %ebp
80104de1:	89 e5                	mov    %esp,%ebp
80104de3:	83 ec 08             	sub    $0x8,%esp
80104de6:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104de9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80104dec:	89 75 fc             	mov    %esi,-0x4(%ebp)
	return !first;
80104def:	8b 11                	mov    (%ecx),%edx
	if(isEmpty())
80104df1:	85 d2                	test   %edx,%edx
80104df3:	74 2b                	je     80104e20 <_ZN10LinkedList7dequeueEv+0x40>
	Link *next = first->next;
80104df5:	8b 5a 04             	mov    0x4(%edx),%ebx
	link->next = freeLinks;
80104df8:	8b 35 04 b6 10 80    	mov    0x8010b604,%esi
	Proc *p = first->p;
80104dfe:	8b 02                	mov    (%edx),%eax
	freeLinks = link;
80104e00:	89 15 04 b6 10 80    	mov    %edx,0x8010b604
	if(isEmpty())
80104e06:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
80104e08:	89 72 04             	mov    %esi,0x4(%edx)
	first = next;
80104e0b:	89 19                	mov    %ebx,(%ecx)
	if(isEmpty())
80104e0d:	75 07                	jne    80104e16 <_ZN10LinkedList7dequeueEv+0x36>
		last = null;
80104e0f:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
}
80104e16:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104e19:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104e1c:	89 ec                	mov    %ebp,%esp
80104e1e:	5d                   	pop    %ebp
80104e1f:	c3                   	ret    
		return null;
80104e20:	31 c0                	xor    %eax,%eax
80104e22:	eb f2                	jmp    80104e16 <_ZN10LinkedList7dequeueEv+0x36>
80104e24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104e30 <_ZN10LinkedList6removeEP4proc>:
bool LinkedList::remove(Proc *p) {
80104e30:	55                   	push   %ebp
80104e31:	89 e5                	mov    %esp,%ebp
80104e33:	56                   	push   %esi
80104e34:	8b 75 08             	mov    0x8(%ebp),%esi
80104e37:	53                   	push   %ebx
80104e38:	8b 4d 0c             	mov    0xc(%ebp),%ecx
	return !first;
80104e3b:	8b 1e                	mov    (%esi),%ebx
	if(isEmpty())
80104e3d:	85 db                	test   %ebx,%ebx
80104e3f:	74 2f                	je     80104e70 <_ZN10LinkedList6removeEP4proc+0x40>
	if(first->p == p) {
80104e41:	39 0b                	cmp    %ecx,(%ebx)
80104e43:	8b 53 04             	mov    0x4(%ebx),%edx
80104e46:	74 70                	je     80104eb8 <_ZN10LinkedList6removeEP4proc+0x88>
	while(cur) {
80104e48:	85 d2                	test   %edx,%edx
80104e4a:	74 24                	je     80104e70 <_ZN10LinkedList6removeEP4proc+0x40>
		if(cur->p == p) {
80104e4c:	3b 0a                	cmp    (%edx),%ecx
80104e4e:	66 90                	xchg   %ax,%ax
80104e50:	75 0c                	jne    80104e5e <_ZN10LinkedList6removeEP4proc+0x2e>
80104e52:	eb 2c                	jmp    80104e80 <_ZN10LinkedList6removeEP4proc+0x50>
80104e54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e58:	39 08                	cmp    %ecx,(%eax)
80104e5a:	74 34                	je     80104e90 <_ZN10LinkedList6removeEP4proc+0x60>
80104e5c:	89 c2                	mov    %eax,%edx
		cur = cur->next;
80104e5e:	8b 42 04             	mov    0x4(%edx),%eax
	while(cur) {
80104e61:	85 c0                	test   %eax,%eax
80104e63:	75 f3                	jne    80104e58 <_ZN10LinkedList6removeEP4proc+0x28>
}
80104e65:	5b                   	pop    %ebx
80104e66:	5e                   	pop    %esi
80104e67:	5d                   	pop    %ebp
80104e68:	c3                   	ret    
80104e69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e70:	5b                   	pop    %ebx
		return false;
80104e71:	31 c0                	xor    %eax,%eax
}
80104e73:	5e                   	pop    %esi
80104e74:	5d                   	pop    %ebp
80104e75:	c3                   	ret    
80104e76:	8d 76 00             	lea    0x0(%esi),%esi
80104e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		if(cur->p == p) {
80104e80:	89 d0                	mov    %edx,%eax
80104e82:	89 da                	mov    %ebx,%edx
80104e84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
			prev->next = cur->next;
80104e90:	8b 48 04             	mov    0x4(%eax),%ecx
80104e93:	89 4a 04             	mov    %ecx,0x4(%edx)
			if(!(cur->next)) //removes the last link
80104e96:	8b 48 04             	mov    0x4(%eax),%ecx
80104e99:	85 c9                	test   %ecx,%ecx
80104e9b:	74 43                	je     80104ee0 <_ZN10LinkedList6removeEP4proc+0xb0>
	link->next = freeLinks;
80104e9d:	8b 15 04 b6 10 80    	mov    0x8010b604,%edx
	freeLinks = link;
80104ea3:	a3 04 b6 10 80       	mov    %eax,0x8010b604
	link->next = freeLinks;
80104ea8:	89 50 04             	mov    %edx,0x4(%eax)
			return true;
80104eab:	b0 01                	mov    $0x1,%al
}
80104ead:	5b                   	pop    %ebx
80104eae:	5e                   	pop    %esi
80104eaf:	5d                   	pop    %ebp
80104eb0:	c3                   	ret    
80104eb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	link->next = freeLinks;
80104eb8:	a1 04 b6 10 80       	mov    0x8010b604,%eax
	if(isEmpty())
80104ebd:	85 d2                	test   %edx,%edx
	freeLinks = link;
80104ebf:	89 1d 04 b6 10 80    	mov    %ebx,0x8010b604
	link->next = freeLinks;
80104ec5:	89 43 04             	mov    %eax,0x4(%ebx)
		return true;
80104ec8:	b0 01                	mov    $0x1,%al
	first = next;
80104eca:	89 16                	mov    %edx,(%esi)
	if(isEmpty())
80104ecc:	75 97                	jne    80104e65 <_ZN10LinkedList6removeEP4proc+0x35>
		last = null;
80104ece:	c7 46 04 00 00 00 00 	movl   $0x0,0x4(%esi)
80104ed5:	eb 8e                	jmp    80104e65 <_ZN10LinkedList6removeEP4proc+0x35>
80104ed7:	89 f6                	mov    %esi,%esi
80104ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
				last = prev;
80104ee0:	89 56 04             	mov    %edx,0x4(%esi)
80104ee3:	eb b8                	jmp    80104e9d <_ZN10LinkedList6removeEP4proc+0x6d>
80104ee5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ef0 <removeRunningProcessHolder>:
static boolean removeRunningProcessHolder(Proc* p) {
80104ef0:	55                   	push   %ebp
80104ef1:	89 e5                	mov    %esp,%ebp
80104ef3:	83 ec 08             	sub    $0x8,%esp
	return runningProcHolder->remove(p);
80104ef6:	8b 45 08             	mov    0x8(%ebp),%eax
80104ef9:	89 44 24 04          	mov    %eax,0x4(%esp)
80104efd:	a1 08 b6 10 80       	mov    0x8010b608,%eax
80104f02:	89 04 24             	mov    %eax,(%esp)
80104f05:	e8 26 ff ff ff       	call   80104e30 <_ZN10LinkedList6removeEP4proc>
}
80104f0a:	c9                   	leave  
	return runningProcHolder->remove(p);
80104f0b:	0f b6 c0             	movzbl %al,%eax
}
80104f0e:	c3                   	ret    
80104f0f:	90                   	nop

80104f10 <_ZN10LinkedList8transferEv>:
	if(!priorityQ->isEmpty())
80104f10:	8b 15 10 b6 10 80    	mov    0x8010b610,%edx
		return false;
80104f16:	31 c0                	xor    %eax,%eax
bool LinkedList::transfer() {
80104f18:	55                   	push   %ebp
80104f19:	89 e5                	mov    %esp,%ebp
80104f1b:	53                   	push   %ebx
80104f1c:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!priorityQ->isEmpty())
80104f1f:	8b 1a                	mov    (%edx),%ebx
80104f21:	85 db                	test   %ebx,%ebx
80104f23:	74 0b                	je     80104f30 <_ZN10LinkedList8transferEv+0x20>
}
80104f25:	5b                   	pop    %ebx
80104f26:	5d                   	pop    %ebp
80104f27:	c3                   	ret    
80104f28:	90                   	nop
80104f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	if(!isEmpty()) {
80104f30:	8b 19                	mov    (%ecx),%ebx
80104f32:	85 db                	test   %ebx,%ebx
80104f34:	74 4a                	je     80104f80 <_ZN10LinkedList8transferEv+0x70>
	if(!freeNodes)
80104f36:	8b 1d 00 b6 10 80    	mov    0x8010b600,%ebx
80104f3c:	85 db                	test   %ebx,%ebx
80104f3e:	74 e5                	je     80104f25 <_ZN10LinkedList8transferEv+0x15>
	freeNodes = freeNodes->next;
80104f40:	8b 43 10             	mov    0x10(%ebx),%eax
	ans->key = key;
80104f43:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
	ans->next = null;
80104f49:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
	ans->key = key;
80104f50:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
	freeNodes = freeNodes->next;
80104f57:	a3 00 b6 10 80       	mov    %eax,0x8010b600
		node->listOfProcs.first = first;
80104f5c:	8b 01                	mov    (%ecx),%eax
80104f5e:	89 43 08             	mov    %eax,0x8(%ebx)
		node->listOfProcs.last = last;
80104f61:	8b 41 04             	mov    0x4(%ecx),%eax
80104f64:	89 43 0c             	mov    %eax,0xc(%ebx)
	return true;
80104f67:	b0 01                	mov    $0x1,%al
		first = last = null;
80104f69:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
80104f70:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
		priorityQ->root = node;
80104f76:	89 1a                	mov    %ebx,(%edx)
}
80104f78:	5b                   	pop    %ebx
80104f79:	5d                   	pop    %ebp
80104f7a:	c3                   	ret    
80104f7b:	90                   	nop
80104f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	return true;
80104f80:	b0 01                	mov    $0x1,%al
80104f82:	eb a1                	jmp    80104f25 <_ZN10LinkedList8transferEv+0x15>
80104f84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104f90 <switchToPriorityQueuePolicyRoundRobinQueue>:
static boolean switchToPriorityQueuePolicyRoundRobinQueue() {
80104f90:	55                   	push   %ebp
80104f91:	89 e5                	mov    %esp,%ebp
80104f93:	83 ec 04             	sub    $0x4,%esp
	return roundRobinQ->transfer();
80104f96:	a1 0c b6 10 80       	mov    0x8010b60c,%eax
80104f9b:	89 04 24             	mov    %eax,(%esp)
80104f9e:	e8 6d ff ff ff       	call   80104f10 <_ZN10LinkedList8transferEv>
}
80104fa3:	c9                   	leave  
	return roundRobinQ->transfer();
80104fa4:	0f b6 c0             	movzbl %al,%eax
}
80104fa7:	c3                   	ret    
80104fa8:	90                   	nop
80104fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104fb0 <_ZN10LinkedList9getMinKeyEPx>:
bool LinkedList::getMinKey(long long *pkey) {
80104fb0:	55                   	push   %ebp
80104fb1:	31 c0                	xor    %eax,%eax
80104fb3:	89 e5                	mov    %esp,%ebp
80104fb5:	57                   	push   %edi
80104fb6:	56                   	push   %esi
80104fb7:	53                   	push   %ebx
80104fb8:	83 ec 1c             	sub    $0x1c,%esp
80104fbb:	8b 7d 08             	mov    0x8(%ebp),%edi
	return !first;
80104fbe:	8b 17                	mov    (%edi),%edx
	if(isEmpty())
80104fc0:	85 d2                	test   %edx,%edx
80104fc2:	74 41                	je     80105005 <_ZN10LinkedList9getMinKeyEPx+0x55>
	long long minKey = getAccumulator(first->p);
80104fc4:	8b 02                	mov    (%edx),%eax
80104fc6:	89 04 24             	mov    %eax,(%esp)
80104fc9:	e8 d2 e8 ff ff       	call   801038a0 <getAccumulator>
	forEach([&](Proc *p) {
80104fce:	8b 3f                	mov    (%edi),%edi
	void append(Link *link); //appends the given list to the queue. No allocations always succeeds.
	
	template<typename Func>
	void forEach(const Func& accept) { //for-each loop. gets a function that applies the procin each link node.
		Link *link = first;
		while(link) {
80104fd0:	85 ff                	test   %edi,%edi
	long long minKey = getAccumulator(first->p);
80104fd2:	89 c6                	mov    %eax,%esi
80104fd4:	89 d3                	mov    %edx,%ebx
80104fd6:	74 23                	je     80104ffb <_ZN10LinkedList9getMinKeyEPx+0x4b>
80104fd8:	90                   	nop
80104fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		long long key = getAccumulator(p);
80104fe0:	8b 07                	mov    (%edi),%eax
80104fe2:	89 04 24             	mov    %eax,(%esp)
80104fe5:	e8 b6 e8 ff ff       	call   801038a0 <getAccumulator>
80104fea:	39 d3                	cmp    %edx,%ebx
80104fec:	7c 06                	jl     80104ff4 <_ZN10LinkedList9getMinKeyEPx+0x44>
80104fee:	7f 20                	jg     80105010 <_ZN10LinkedList9getMinKeyEPx+0x60>
80104ff0:	39 c6                	cmp    %eax,%esi
80104ff2:	77 1c                	ja     80105010 <_ZN10LinkedList9getMinKeyEPx+0x60>
			accept(link->p);
			link = link->next;
80104ff4:	8b 7f 04             	mov    0x4(%edi),%edi
		while(link) {
80104ff7:	85 ff                	test   %edi,%edi
80104ff9:	75 e5                	jne    80104fe0 <_ZN10LinkedList9getMinKeyEPx+0x30>
	*pkey = minKey;
80104ffb:	8b 45 0c             	mov    0xc(%ebp),%eax
80104ffe:	89 30                	mov    %esi,(%eax)
80105000:	89 58 04             	mov    %ebx,0x4(%eax)
	return true;
80105003:	b0 01                	mov    $0x1,%al
}
80105005:	83 c4 1c             	add    $0x1c,%esp
80105008:	5b                   	pop    %ebx
80105009:	5e                   	pop    %esi
8010500a:	5f                   	pop    %edi
8010500b:	5d                   	pop    %ebp
8010500c:	c3                   	ret    
8010500d:	8d 76 00             	lea    0x0(%esi),%esi
			link = link->next;
80105010:	8b 7f 04             	mov    0x4(%edi),%edi
80105013:	89 c6                	mov    %eax,%esi
80105015:	89 d3                	mov    %edx,%ebx
		while(link) {
80105017:	85 ff                	test   %edi,%edi
80105019:	75 c5                	jne    80104fe0 <_ZN10LinkedList9getMinKeyEPx+0x30>
8010501b:	eb de                	jmp    80104ffb <_ZN10LinkedList9getMinKeyEPx+0x4b>
8010501d:	8d 76 00             	lea    0x0(%esi),%esi

80105020 <getMinAccumulatorRunningProcessHolder>:
static boolean getMinAccumulatorRunningProcessHolder(long long *pkey) {
80105020:	55                   	push   %ebp
80105021:	89 e5                	mov    %esp,%ebp
80105023:	83 ec 18             	sub    $0x18,%esp
	return runningProcHolder->getMinKey(pkey);
80105026:	8b 45 08             	mov    0x8(%ebp),%eax
80105029:	89 44 24 04          	mov    %eax,0x4(%esp)
8010502d:	a1 08 b6 10 80       	mov    0x8010b608,%eax
80105032:	89 04 24             	mov    %eax,(%esp)
80105035:	e8 76 ff ff ff       	call   80104fb0 <_ZN10LinkedList9getMinKeyEPx>
}
8010503a:	c9                   	leave  
	return runningProcHolder->getMinKey(pkey);
8010503b:	0f b6 c0             	movzbl %al,%eax
}
8010503e:	c3                   	ret    
8010503f:	90                   	nop

80105040 <_ZN7MapNode7isEmptyEv>:
bool MapNode::isEmpty() {
80105040:	55                   	push   %ebp
80105041:	89 e5                	mov    %esp,%ebp
	return !first;
80105043:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105046:	5d                   	pop    %ebp
	return !first;
80105047:	8b 40 08             	mov    0x8(%eax),%eax
8010504a:	85 c0                	test   %eax,%eax
8010504c:	0f 94 c0             	sete   %al
}
8010504f:	c3                   	ret    

80105050 <_ZN7MapNode3putEP4proc>:
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
80105050:	55                   	push   %ebp
80105051:	89 e5                	mov    %esp,%ebp
80105053:	57                   	push   %edi
80105054:	56                   	push   %esi
80105055:	53                   	push   %ebx
80105056:	83 ec 2c             	sub    $0x2c,%esp
	long long key = getAccumulator(p);
80105059:	8b 45 0c             	mov    0xc(%ebp),%eax
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
8010505c:	8b 5d 08             	mov    0x8(%ebp),%ebx
	long long key = getAccumulator(p);
8010505f:	89 04 24             	mov    %eax,(%esp)
80105062:	e8 39 e8 ff ff       	call   801038a0 <getAccumulator>
80105067:	89 d1                	mov    %edx,%ecx
80105069:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010506c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		if(key == node->key)
80105070:	8b 13                	mov    (%ebx),%edx
80105072:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80105075:	8b 43 04             	mov    0x4(%ebx),%eax
80105078:	31 d7                	xor    %edx,%edi
8010507a:	89 fe                	mov    %edi,%esi
8010507c:	89 c7                	mov    %eax,%edi
8010507e:	31 cf                	xor    %ecx,%edi
80105080:	09 fe                	or     %edi,%esi
80105082:	74 4c                	je     801050d0 <_ZN7MapNode3putEP4proc+0x80>
		else if(key < node->key) { //left
80105084:	39 c8                	cmp    %ecx,%eax
80105086:	7c 20                	jl     801050a8 <_ZN7MapNode3putEP4proc+0x58>
80105088:	7f 08                	jg     80105092 <_ZN7MapNode3putEP4proc+0x42>
8010508a:	3b 55 e4             	cmp    -0x1c(%ebp),%edx
8010508d:	8d 76 00             	lea    0x0(%esi),%esi
80105090:	76 16                	jbe    801050a8 <_ZN7MapNode3putEP4proc+0x58>
			if(node->left)
80105092:	8b 43 18             	mov    0x18(%ebx),%eax
80105095:	85 c0                	test   %eax,%eax
80105097:	0f 84 83 00 00 00    	je     80105120 <_ZN7MapNode3putEP4proc+0xd0>
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
8010509d:	89 c3                	mov    %eax,%ebx
8010509f:	eb cf                	jmp    80105070 <_ZN7MapNode3putEP4proc+0x20>
801050a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			if(node->right)
801050a8:	8b 43 1c             	mov    0x1c(%ebx),%eax
801050ab:	85 c0                	test   %eax,%eax
801050ad:	75 ee                	jne    8010509d <_ZN7MapNode3putEP4proc+0x4d>
801050af:	8b 75 e4             	mov    -0x1c(%ebp),%esi
				node->right = allocNode(p, key);
801050b2:	8b 45 0c             	mov    0xc(%ebp),%eax
801050b5:	89 f2                	mov    %esi,%edx
801050b7:	e8 e4 f9 ff ff       	call   80104aa0 <_ZL9allocNodeP4procx>
				if(node->right) {
801050bc:	85 c0                	test   %eax,%eax
				node->right = allocNode(p, key);
801050be:	89 43 1c             	mov    %eax,0x1c(%ebx)
				if(node->right) {
801050c1:	74 71                	je     80105134 <_ZN7MapNode3putEP4proc+0xe4>
					node->right->parent = node;
801050c3:	89 58 14             	mov    %ebx,0x14(%eax)
}
801050c6:	83 c4 2c             	add    $0x2c,%esp
					return true;
801050c9:	b0 01                	mov    $0x1,%al
}
801050cb:	5b                   	pop    %ebx
801050cc:	5e                   	pop    %esi
801050cd:	5f                   	pop    %edi
801050ce:	5d                   	pop    %ebp
801050cf:	c3                   	ret    
	if(!freeLinks)
801050d0:	a1 04 b6 10 80       	mov    0x8010b604,%eax
801050d5:	85 c0                	test   %eax,%eax
801050d7:	74 5b                	je     80105134 <_ZN7MapNode3putEP4proc+0xe4>
	ans->p = p;
801050d9:	8b 75 0c             	mov    0xc(%ebp),%esi
	freeLinks = freeLinks->next;
801050dc:	8b 50 04             	mov    0x4(%eax),%edx
	ans->next = null;
801050df:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	ans->p = p;
801050e6:	89 30                	mov    %esi,(%eax)
	freeLinks = freeLinks->next;
801050e8:	89 15 04 b6 10 80    	mov    %edx,0x8010b604
	if(isEmpty()) first = link;
801050ee:	8b 53 08             	mov    0x8(%ebx),%edx
801050f1:	85 d2                	test   %edx,%edx
801050f3:	74 4b                	je     80105140 <_ZN7MapNode3putEP4proc+0xf0>
	else last->next = link;
801050f5:	8b 53 0c             	mov    0xc(%ebx),%edx
801050f8:	89 42 04             	mov    %eax,0x4(%edx)
801050fb:	eb 05                	jmp    80105102 <_ZN7MapNode3putEP4proc+0xb2>
801050fd:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
80105100:	89 d0                	mov    %edx,%eax
80105102:	8b 50 04             	mov    0x4(%eax),%edx
80105105:	85 d2                	test   %edx,%edx
80105107:	75 f7                	jne    80105100 <_ZN7MapNode3putEP4proc+0xb0>
	last = link->getLast();
80105109:	89 43 0c             	mov    %eax,0xc(%ebx)
}
8010510c:	83 c4 2c             	add    $0x2c,%esp
	return true;
8010510f:	b0 01                	mov    $0x1,%al
}
80105111:	5b                   	pop    %ebx
80105112:	5e                   	pop    %esi
80105113:	5f                   	pop    %edi
80105114:	5d                   	pop    %ebp
80105115:	c3                   	ret    
80105116:	8d 76 00             	lea    0x0(%esi),%esi
80105119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105120:	8b 75 e4             	mov    -0x1c(%ebp),%esi
				node->left = allocNode(p, key);
80105123:	8b 45 0c             	mov    0xc(%ebp),%eax
80105126:	89 f2                	mov    %esi,%edx
80105128:	e8 73 f9 ff ff       	call   80104aa0 <_ZL9allocNodeP4procx>
				if(node->left) {
8010512d:	85 c0                	test   %eax,%eax
				node->left = allocNode(p, key);
8010512f:	89 43 18             	mov    %eax,0x18(%ebx)
				if(node->left) {
80105132:	75 8f                	jne    801050c3 <_ZN7MapNode3putEP4proc+0x73>
}
80105134:	83 c4 2c             	add    $0x2c,%esp
		return false;
80105137:	31 c0                	xor    %eax,%eax
}
80105139:	5b                   	pop    %ebx
8010513a:	5e                   	pop    %esi
8010513b:	5f                   	pop    %edi
8010513c:	5d                   	pop    %ebp
8010513d:	c3                   	ret    
8010513e:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
80105140:	89 43 08             	mov    %eax,0x8(%ebx)
80105143:	eb bd                	jmp    80105102 <_ZN7MapNode3putEP4proc+0xb2>
80105145:	90                   	nop
80105146:	8d 76 00             	lea    0x0(%esi),%esi
80105149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105150 <_ZN7MapNode10getMinNodeEv>:
MapNode* MapNode::getMinNode() { //no recursion.
80105150:	55                   	push   %ebp
80105151:	89 e5                	mov    %esp,%ebp
80105153:	8b 45 08             	mov    0x8(%ebp),%eax
80105156:	eb 0a                	jmp    80105162 <_ZN7MapNode10getMinNodeEv+0x12>
80105158:	90                   	nop
80105159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105160:	89 d0                	mov    %edx,%eax
	while(minNode->left)
80105162:	8b 50 18             	mov    0x18(%eax),%edx
80105165:	85 d2                	test   %edx,%edx
80105167:	75 f7                	jne    80105160 <_ZN7MapNode10getMinNodeEv+0x10>
}
80105169:	5d                   	pop    %ebp
8010516a:	c3                   	ret    
8010516b:	90                   	nop
8010516c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105170 <_ZN7MapNode9getMinKeyEPx>:
void MapNode::getMinKey(long long *pkey) {
80105170:	55                   	push   %ebp
80105171:	89 e5                	mov    %esp,%ebp
80105173:	8b 55 08             	mov    0x8(%ebp),%edx
80105176:	53                   	push   %ebx
80105177:	eb 09                	jmp    80105182 <_ZN7MapNode9getMinKeyEPx+0x12>
80105179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	while(minNode->left)
80105180:	89 c2                	mov    %eax,%edx
80105182:	8b 42 18             	mov    0x18(%edx),%eax
80105185:	85 c0                	test   %eax,%eax
80105187:	75 f7                	jne    80105180 <_ZN7MapNode9getMinKeyEPx+0x10>
	*pkey = getMinNode()->key;
80105189:	8b 5a 04             	mov    0x4(%edx),%ebx
8010518c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010518f:	8b 0a                	mov    (%edx),%ecx
80105191:	89 58 04             	mov    %ebx,0x4(%eax)
80105194:	89 08                	mov    %ecx,(%eax)
}
80105196:	5b                   	pop    %ebx
80105197:	5d                   	pop    %ebp
80105198:	c3                   	ret    
80105199:	90                   	nop
8010519a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801051a0 <_ZN7MapNode7dequeueEv>:
Proc* MapNode::dequeue() {
801051a0:	55                   	push   %ebp
801051a1:	89 e5                	mov    %esp,%ebp
801051a3:	83 ec 08             	sub    $0x8,%esp
801051a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
801051a9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801051ac:	89 75 fc             	mov    %esi,-0x4(%ebp)
	return !first;
801051af:	8b 51 08             	mov    0x8(%ecx),%edx
	if(isEmpty())
801051b2:	85 d2                	test   %edx,%edx
801051b4:	74 32                	je     801051e8 <_ZN7MapNode7dequeueEv+0x48>
	Link *next = first->next;
801051b6:	8b 5a 04             	mov    0x4(%edx),%ebx
	link->next = freeLinks;
801051b9:	8b 35 04 b6 10 80    	mov    0x8010b604,%esi
	Proc *p = first->p;
801051bf:	8b 02                	mov    (%edx),%eax
	freeLinks = link;
801051c1:	89 15 04 b6 10 80    	mov    %edx,0x8010b604
	if(isEmpty())
801051c7:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
801051c9:	89 72 04             	mov    %esi,0x4(%edx)
	first = next;
801051cc:	89 59 08             	mov    %ebx,0x8(%ecx)
	if(isEmpty())
801051cf:	75 07                	jne    801051d8 <_ZN7MapNode7dequeueEv+0x38>
		last = null;
801051d1:	c7 41 0c 00 00 00 00 	movl   $0x0,0xc(%ecx)
}
801051d8:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801051db:	8b 75 fc             	mov    -0x4(%ebp),%esi
801051de:	89 ec                	mov    %ebp,%esp
801051e0:	5d                   	pop    %ebp
801051e1:	c3                   	ret    
801051e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		return null;
801051e8:	31 c0                	xor    %eax,%eax
	return listOfProcs.dequeue();
801051ea:	eb ec                	jmp    801051d8 <_ZN7MapNode7dequeueEv+0x38>
801051ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801051f0 <_ZN3Map7isEmptyEv>:
bool Map::isEmpty() {
801051f0:	55                   	push   %ebp
801051f1:	89 e5                	mov    %esp,%ebp
	return !root;
801051f3:	8b 45 08             	mov    0x8(%ebp),%eax
}
801051f6:	5d                   	pop    %ebp
	return !root;
801051f7:	8b 00                	mov    (%eax),%eax
801051f9:	85 c0                	test   %eax,%eax
801051fb:	0f 94 c0             	sete   %al
}
801051fe:	c3                   	ret    
801051ff:	90                   	nop

80105200 <_ZN3Map3putEP4proc>:
bool Map::put(Proc *p) {
80105200:	55                   	push   %ebp
80105201:	89 e5                	mov    %esp,%ebp
80105203:	83 ec 18             	sub    $0x18,%esp
80105206:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105209:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010520c:	89 75 fc             	mov    %esi,-0x4(%ebp)
8010520f:	8b 75 08             	mov    0x8(%ebp),%esi
	long long key = getAccumulator(p);
80105212:	89 1c 24             	mov    %ebx,(%esp)
80105215:	e8 86 e6 ff ff       	call   801038a0 <getAccumulator>
	return !root;
8010521a:	8b 0e                	mov    (%esi),%ecx
	if(isEmpty()) {
8010521c:	85 c9                	test   %ecx,%ecx
8010521e:	74 18                	je     80105238 <_ZN3Map3putEP4proc+0x38>
	return root->put(p);
80105220:	89 5d 0c             	mov    %ebx,0xc(%ebp)
}
80105223:	8b 75 fc             	mov    -0x4(%ebp),%esi
	return root->put(p);
80105226:	89 4d 08             	mov    %ecx,0x8(%ebp)
}
80105229:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010522c:	89 ec                	mov    %ebp,%esp
8010522e:	5d                   	pop    %ebp
	return root->put(p);
8010522f:	e9 1c fe ff ff       	jmp    80105050 <_ZN7MapNode3putEP4proc>
80105234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		root = allocNode(p, key);
80105238:	89 d1                	mov    %edx,%ecx
8010523a:	89 c2                	mov    %eax,%edx
8010523c:	89 d8                	mov    %ebx,%eax
8010523e:	e8 5d f8 ff ff       	call   80104aa0 <_ZL9allocNodeP4procx>
80105243:	89 06                	mov    %eax,(%esi)
		return !isEmpty();
80105245:	85 c0                	test   %eax,%eax
80105247:	0f 95 c0             	setne  %al
}
8010524a:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010524d:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105250:	89 ec                	mov    %ebp,%esp
80105252:	5d                   	pop    %ebp
80105253:	c3                   	ret    
80105254:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010525a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105260 <putPriorityQueue>:
static boolean putPriorityQueue(Proc* p) {
80105260:	55                   	push   %ebp
80105261:	89 e5                	mov    %esp,%ebp
80105263:	83 ec 18             	sub    $0x18,%esp
	return priorityQ->put(p);
80105266:	8b 45 08             	mov    0x8(%ebp),%eax
80105269:	89 44 24 04          	mov    %eax,0x4(%esp)
8010526d:	a1 10 b6 10 80       	mov    0x8010b610,%eax
80105272:	89 04 24             	mov    %eax,(%esp)
80105275:	e8 86 ff ff ff       	call   80105200 <_ZN3Map3putEP4proc>
}
8010527a:	c9                   	leave  
	return priorityQ->put(p);
8010527b:	0f b6 c0             	movzbl %al,%eax
}
8010527e:	c3                   	ret    
8010527f:	90                   	nop

80105280 <_ZN3Map9getMinKeyEPx>:
bool Map::getMinKey(long long *pkey) {
80105280:	55                   	push   %ebp
80105281:	89 e5                	mov    %esp,%ebp
	return !root;
80105283:	8b 45 08             	mov    0x8(%ebp),%eax
bool Map::getMinKey(long long *pkey) {
80105286:	53                   	push   %ebx
	return !root;
80105287:	8b 10                	mov    (%eax),%edx
	if(isEmpty())
80105289:	85 d2                	test   %edx,%edx
8010528b:	75 05                	jne    80105292 <_ZN3Map9getMinKeyEPx+0x12>
8010528d:	eb 21                	jmp    801052b0 <_ZN3Map9getMinKeyEPx+0x30>
8010528f:	90                   	nop
	while(minNode->left)
80105290:	89 c2                	mov    %eax,%edx
80105292:	8b 42 18             	mov    0x18(%edx),%eax
80105295:	85 c0                	test   %eax,%eax
80105297:	75 f7                	jne    80105290 <_ZN3Map9getMinKeyEPx+0x10>
	*pkey = getMinNode()->key;
80105299:	8b 45 0c             	mov    0xc(%ebp),%eax
8010529c:	8b 5a 04             	mov    0x4(%edx),%ebx
8010529f:	8b 0a                	mov    (%edx),%ecx
801052a1:	89 58 04             	mov    %ebx,0x4(%eax)
801052a4:	89 08                	mov    %ecx,(%eax)
		return false;

	root->getMinKey(pkey);
	return true;
801052a6:	b0 01                	mov    $0x1,%al
}
801052a8:	5b                   	pop    %ebx
801052a9:	5d                   	pop    %ebp
801052aa:	c3                   	ret    
801052ab:	90                   	nop
801052ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801052b0:	5b                   	pop    %ebx
		return false;
801052b1:	31 c0                	xor    %eax,%eax
}
801052b3:	5d                   	pop    %ebp
801052b4:	c3                   	ret    
801052b5:	90                   	nop
801052b6:	8d 76 00             	lea    0x0(%esi),%esi
801052b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801052c0 <_ZN3Map10extractMinEv>:

Proc* Map::extractMin() {
801052c0:	55                   	push   %ebp
801052c1:	89 e5                	mov    %esp,%ebp
801052c3:	57                   	push   %edi
801052c4:	56                   	push   %esi
801052c5:	8b 75 08             	mov    0x8(%ebp),%esi
801052c8:	53                   	push   %ebx
	return !root;
801052c9:	8b 1e                	mov    (%esi),%ebx
	if(isEmpty())
801052cb:	85 db                	test   %ebx,%ebx
801052cd:	0f 84 a5 00 00 00    	je     80105378 <_ZN3Map10extractMinEv+0xb8>
801052d3:	89 da                	mov    %ebx,%edx
801052d5:	eb 0b                	jmp    801052e2 <_ZN3Map10extractMinEv+0x22>
801052d7:	89 f6                	mov    %esi,%esi
801052d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	while(minNode->left)
801052e0:	89 c2                	mov    %eax,%edx
801052e2:	8b 42 18             	mov    0x18(%edx),%eax
801052e5:	85 c0                	test   %eax,%eax
801052e7:	75 f7                	jne    801052e0 <_ZN3Map10extractMinEv+0x20>
	return !first;
801052e9:	8b 4a 08             	mov    0x8(%edx),%ecx
	if(isEmpty())
801052ec:	85 c9                	test   %ecx,%ecx
801052ee:	74 70                	je     80105360 <_ZN3Map10extractMinEv+0xa0>
	Link *next = first->next;
801052f0:	8b 59 04             	mov    0x4(%ecx),%ebx
	link->next = freeLinks;
801052f3:	8b 3d 04 b6 10 80    	mov    0x8010b604,%edi
	Proc *p = first->p;
801052f9:	8b 01                	mov    (%ecx),%eax
	freeLinks = link;
801052fb:	89 0d 04 b6 10 80    	mov    %ecx,0x8010b604
	if(isEmpty())
80105301:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
80105303:	89 79 04             	mov    %edi,0x4(%ecx)
	first = next;
80105306:	89 5a 08             	mov    %ebx,0x8(%edx)
	if(isEmpty())
80105309:	74 05                	je     80105310 <_ZN3Map10extractMinEv+0x50>
		}
		deallocNode(minNode);
	}

	return p;
}
8010530b:	5b                   	pop    %ebx
8010530c:	5e                   	pop    %esi
8010530d:	5f                   	pop    %edi
8010530e:	5d                   	pop    %ebp
8010530f:	c3                   	ret    
		last = null;
80105310:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
80105317:	8b 4a 1c             	mov    0x1c(%edx),%ecx
8010531a:	8b 1e                	mov    (%esi),%ebx
		if(minNode == root) {
8010531c:	39 da                	cmp    %ebx,%edx
8010531e:	74 49                	je     80105369 <_ZN3Map10extractMinEv+0xa9>
			MapNode *parent = minNode->parent;
80105320:	8b 5a 14             	mov    0x14(%edx),%ebx
			parent->left = minNode->right;
80105323:	89 4b 18             	mov    %ecx,0x18(%ebx)
			if(minNode->right)
80105326:	8b 4a 1c             	mov    0x1c(%edx),%ecx
80105329:	85 c9                	test   %ecx,%ecx
8010532b:	74 03                	je     80105330 <_ZN3Map10extractMinEv+0x70>
				minNode->right->parent = parent;
8010532d:	89 59 14             	mov    %ebx,0x14(%ecx)
	node->next = freeNodes;
80105330:	8b 0d 00 b6 10 80    	mov    0x8010b600,%ecx
	node->parent = node->left = node->right = null;
80105336:	c7 42 1c 00 00 00 00 	movl   $0x0,0x1c(%edx)
8010533d:	c7 42 18 00 00 00 00 	movl   $0x0,0x18(%edx)
80105344:	c7 42 14 00 00 00 00 	movl   $0x0,0x14(%edx)
	node->next = freeNodes;
8010534b:	89 4a 10             	mov    %ecx,0x10(%edx)
}
8010534e:	5b                   	pop    %ebx
	freeNodes = node;
8010534f:	89 15 00 b6 10 80    	mov    %edx,0x8010b600
}
80105355:	5e                   	pop    %esi
80105356:	5f                   	pop    %edi
80105357:	5d                   	pop    %ebp
80105358:	c3                   	ret    
80105359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return null;
80105360:	31 c0                	xor    %eax,%eax
		if(minNode == root) {
80105362:	39 da                	cmp    %ebx,%edx
80105364:	8b 4a 1c             	mov    0x1c(%edx),%ecx
80105367:	75 b7                	jne    80105320 <_ZN3Map10extractMinEv+0x60>
			if(!isEmpty())
80105369:	85 c9                	test   %ecx,%ecx
			root = minNode->right;
8010536b:	89 0e                	mov    %ecx,(%esi)
			if(!isEmpty())
8010536d:	74 c1                	je     80105330 <_ZN3Map10extractMinEv+0x70>
				root->parent = null;
8010536f:	c7 41 14 00 00 00 00 	movl   $0x0,0x14(%ecx)
80105376:	eb b8                	jmp    80105330 <_ZN3Map10extractMinEv+0x70>
		return null;
80105378:	31 c0                	xor    %eax,%eax
8010537a:	eb 8f                	jmp    8010530b <_ZN3Map10extractMinEv+0x4b>
8010537c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105380 <extractMinPriorityQueue>:
static Proc* extractMinPriorityQueue() {
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	83 ec 04             	sub    $0x4,%esp
	return priorityQ->extractMin();
80105386:	a1 10 b6 10 80       	mov    0x8010b610,%eax
8010538b:	89 04 24             	mov    %eax,(%esp)
8010538e:	e8 2d ff ff ff       	call   801052c0 <_ZN3Map10extractMinEv>
}
80105393:	c9                   	leave  
80105394:	c3                   	ret    
80105395:	90                   	nop
80105396:	8d 76 00             	lea    0x0(%esi),%esi
80105399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801053a0 <_ZN3Map8transferEv.part.1>:

bool Map::transfer() {
801053a0:	55                   	push   %ebp
801053a1:	89 e5                	mov    %esp,%ebp
801053a3:	56                   	push   %esi
801053a4:	53                   	push   %ebx
801053a5:	89 c3                	mov    %eax,%ebx
801053a7:	83 ec 04             	sub    $0x4,%esp
801053aa:	eb 16                	jmp    801053c2 <_ZN3Map8transferEv.part.1+0x22>
801053ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!roundRobinQ->isEmpty())
		return false;

	while(!isEmpty()) {
		Proc* p = extractMin();
801053b0:	89 1c 24             	mov    %ebx,(%esp)
801053b3:	e8 08 ff ff ff       	call   801052c0 <_ZN3Map10extractMinEv>
	if(!freeLinks)
801053b8:	8b 15 04 b6 10 80    	mov    0x8010b604,%edx
801053be:	85 d2                	test   %edx,%edx
801053c0:	75 0e                	jne    801053d0 <_ZN3Map8transferEv.part.1+0x30>
	while(!isEmpty()) {
801053c2:	8b 03                	mov    (%ebx),%eax
801053c4:	85 c0                	test   %eax,%eax
801053c6:	75 e8                	jne    801053b0 <_ZN3Map8transferEv.part.1+0x10>
		roundRobinQ->enqueue(p); //should succeed.
	}

	return true;
}
801053c8:	5a                   	pop    %edx
801053c9:	b0 01                	mov    $0x1,%al
801053cb:	5b                   	pop    %ebx
801053cc:	5e                   	pop    %esi
801053cd:	5d                   	pop    %ebp
801053ce:	c3                   	ret    
801053cf:	90                   	nop
	freeLinks = freeLinks->next;
801053d0:	8b 72 04             	mov    0x4(%edx),%esi
		roundRobinQ->enqueue(p); //should succeed.
801053d3:	8b 0d 0c b6 10 80    	mov    0x8010b60c,%ecx
	ans->next = null;
801053d9:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
	ans->p = p;
801053e0:	89 02                	mov    %eax,(%edx)
	freeLinks = freeLinks->next;
801053e2:	89 35 04 b6 10 80    	mov    %esi,0x8010b604
	if(isEmpty()) first = link;
801053e8:	8b 31                	mov    (%ecx),%esi
801053ea:	85 f6                	test   %esi,%esi
801053ec:	74 22                	je     80105410 <_ZN3Map8transferEv.part.1+0x70>
	else last->next = link;
801053ee:	8b 41 04             	mov    0x4(%ecx),%eax
801053f1:	89 50 04             	mov    %edx,0x4(%eax)
801053f4:	eb 0c                	jmp    80105402 <_ZN3Map8transferEv.part.1+0x62>
801053f6:	8d 76 00             	lea    0x0(%esi),%esi
801053f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	while(ans->next)
80105400:	89 c2                	mov    %eax,%edx
80105402:	8b 42 04             	mov    0x4(%edx),%eax
80105405:	85 c0                	test   %eax,%eax
80105407:	75 f7                	jne    80105400 <_ZN3Map8transferEv.part.1+0x60>
	last = link->getLast();
80105409:	89 51 04             	mov    %edx,0x4(%ecx)
8010540c:	eb b4                	jmp    801053c2 <_ZN3Map8transferEv.part.1+0x22>
8010540e:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
80105410:	89 11                	mov    %edx,(%ecx)
80105412:	eb ee                	jmp    80105402 <_ZN3Map8transferEv.part.1+0x62>
80105414:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010541a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105420 <switchToRoundRobinPolicyPriorityQueue>:
	if(!roundRobinQ->isEmpty())
80105420:	8b 15 0c b6 10 80    	mov    0x8010b60c,%edx
80105426:	8b 02                	mov    (%edx),%eax
80105428:	85 c0                	test   %eax,%eax
8010542a:	74 04                	je     80105430 <switchToRoundRobinPolicyPriorityQueue+0x10>
8010542c:	31 c0                	xor    %eax,%eax
}
8010542e:	c3                   	ret    
8010542f:	90                   	nop
80105430:	a1 10 b6 10 80       	mov    0x8010b610,%eax
static boolean switchToRoundRobinPolicyPriorityQueue() {
80105435:	55                   	push   %ebp
80105436:	89 e5                	mov    %esp,%ebp
80105438:	e8 63 ff ff ff       	call   801053a0 <_ZN3Map8transferEv.part.1>
}
8010543d:	5d                   	pop    %ebp
8010543e:	0f b6 c0             	movzbl %al,%eax
80105441:	c3                   	ret    
80105442:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105450 <_ZN3Map8transferEv>:
	return !first;
80105450:	8b 15 0c b6 10 80    	mov    0x8010b60c,%edx
bool Map::transfer() {
80105456:	55                   	push   %ebp
80105457:	89 e5                	mov    %esp,%ebp
80105459:	8b 45 08             	mov    0x8(%ebp),%eax
	if(!roundRobinQ->isEmpty())
8010545c:	8b 12                	mov    (%edx),%edx
8010545e:	85 d2                	test   %edx,%edx
80105460:	74 0e                	je     80105470 <_ZN3Map8transferEv+0x20>
}
80105462:	31 c0                	xor    %eax,%eax
80105464:	5d                   	pop    %ebp
80105465:	c3                   	ret    
80105466:	8d 76 00             	lea    0x0(%esi),%esi
80105469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105470:	5d                   	pop    %ebp
80105471:	e9 2a ff ff ff       	jmp    801053a0 <_ZN3Map8transferEv.part.1>
80105476:	8d 76 00             	lea    0x0(%esi),%esi
80105479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105480 <_ZN3Map11extractProcEP4proc>:

bool Map::extractProc(Proc *p) {
80105480:	55                   	push   %ebp
80105481:	89 e5                	mov    %esp,%ebp
80105483:	56                   	push   %esi
80105484:	53                   	push   %ebx
80105485:	83 ec 30             	sub    $0x30,%esp
	if(!freeNodes)
80105488:	8b 15 00 b6 10 80    	mov    0x8010b600,%edx
bool Map::extractProc(Proc *p) {
8010548e:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105491:	8b 75 0c             	mov    0xc(%ebp),%esi
	if(!freeNodes)
80105494:	85 d2                	test   %edx,%edx
80105496:	74 50                	je     801054e8 <_ZN3Map11extractProcEP4proc+0x68>
	MapNode *next, *parent, *left, *right;
};

class Map {
public:
	Map(): root(null) {}
80105498:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		return false;

	bool ans = false;
8010549f:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
801054a3:	eb 13                	jmp    801054b8 <_ZN3Map11extractProcEP4proc+0x38>
801054a5:	8d 76 00             	lea    0x0(%esi),%esi
	Map tempMap;
	while(!isEmpty()) {
		Proc *otherP = extractMin();
801054a8:	89 1c 24             	mov    %ebx,(%esp)
801054ab:	e8 10 fe ff ff       	call   801052c0 <_ZN3Map10extractMinEv>
		if(otherP != p)
801054b0:	39 f0                	cmp    %esi,%eax
801054b2:	75 1c                	jne    801054d0 <_ZN3Map11extractProcEP4proc+0x50>
			tempMap.put(otherP); //should scucceed.
		else ans = true;
801054b4:	c6 45 e7 01          	movb   $0x1,-0x19(%ebp)
	while(!isEmpty()) {
801054b8:	8b 03                	mov    (%ebx),%eax
801054ba:	85 c0                	test   %eax,%eax
801054bc:	75 ea                	jne    801054a8 <_ZN3Map11extractProcEP4proc+0x28>
	}
	root = tempMap.root;
801054be:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054c1:	89 03                	mov    %eax,(%ebx)
	return ans;
}
801054c3:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801054c7:	83 c4 30             	add    $0x30,%esp
801054ca:	5b                   	pop    %ebx
801054cb:	5e                   	pop    %esi
801054cc:	5d                   	pop    %ebp
801054cd:	c3                   	ret    
801054ce:	66 90                	xchg   %ax,%ax
			tempMap.put(otherP); //should scucceed.
801054d0:	89 44 24 04          	mov    %eax,0x4(%esp)
801054d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054d7:	89 04 24             	mov    %eax,(%esp)
801054da:	e8 21 fd ff ff       	call   80105200 <_ZN3Map3putEP4proc>
801054df:	eb d7                	jmp    801054b8 <_ZN3Map11extractProcEP4proc+0x38>
801054e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return false;
801054e8:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
}
801054ec:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801054f0:	83 c4 30             	add    $0x30,%esp
801054f3:	5b                   	pop    %ebx
801054f4:	5e                   	pop    %esi
801054f5:	5d                   	pop    %ebp
801054f6:	c3                   	ret    
801054f7:	89 f6                	mov    %esi,%esi
801054f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105500 <extractProcPriorityQueue>:
static boolean extractProcPriorityQueue(Proc *p) {
80105500:	55                   	push   %ebp
80105501:	89 e5                	mov    %esp,%ebp
80105503:	83 ec 18             	sub    $0x18,%esp
	return priorityQ->extractProc(p);
80105506:	8b 45 08             	mov    0x8(%ebp),%eax
80105509:	89 44 24 04          	mov    %eax,0x4(%esp)
8010550d:	a1 10 b6 10 80       	mov    0x8010b610,%eax
80105512:	89 04 24             	mov    %eax,(%esp)
80105515:	e8 66 ff ff ff       	call   80105480 <_ZN3Map11extractProcEP4proc>
}
8010551a:	c9                   	leave  
	return priorityQ->extractProc(p);
8010551b:	0f b6 c0             	movzbl %al,%eax
}
8010551e:	c3                   	ret    
8010551f:	90                   	nop

80105520 <__moddi3>:

long long __moddi3(long long number, long long divisor) { //returns number%divisor
80105520:	55                   	push   %ebp
80105521:	89 e5                	mov    %esp,%ebp
80105523:	57                   	push   %edi
80105524:	56                   	push   %esi
80105525:	53                   	push   %ebx
80105526:	83 ec 2c             	sub    $0x2c,%esp
80105529:	8b 45 08             	mov    0x8(%ebp),%eax
8010552c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010552f:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105532:	8b 45 10             	mov    0x10(%ebp),%eax
80105535:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80105538:	8b 55 14             	mov    0x14(%ebp),%edx
8010553b:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010553e:	89 d7                	mov    %edx,%edi
	if(divisor == 0)
80105540:	09 c2                	or     %eax,%edx
80105542:	0f 84 9a 00 00 00    	je     801055e2 <__moddi3+0xc2>
		panic((char*)"divide by zero!!!\n");

	bool isNumberNegative = false;
	if(number < 0) {
80105548:	8b 45 e4             	mov    -0x1c(%ebp),%eax
	bool isNumberNegative = false;
8010554b:	c6 45 df 00          	movb   $0x0,-0x21(%ebp)
	if(number < 0) {
8010554f:	85 c0                	test   %eax,%eax
80105551:	79 0e                	jns    80105561 <__moddi3+0x41>
		number = -number;
80105553:	f7 5d e0             	negl   -0x20(%ebp)
		isNumberNegative = true;
80105556:	c6 45 df 01          	movb   $0x1,-0x21(%ebp)
		number = -number;
8010555a:	83 55 e4 00          	adcl   $0x0,-0x1c(%ebp)
8010555e:	f7 5d e4             	negl   -0x1c(%ebp)
80105561:	8b 55 d8             	mov    -0x28(%ebp),%edx
80105564:	89 f8                	mov    %edi,%eax
80105566:	c1 ff 1f             	sar    $0x1f,%edi
80105569:	31 f8                	xor    %edi,%eax
8010556b:	89 f9                	mov    %edi,%ecx
8010556d:	31 fa                	xor    %edi,%edx
8010556f:	89 c7                	mov    %eax,%edi
80105571:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105574:	89 d6                	mov    %edx,%esi
80105576:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105579:	29 ce                	sub    %ecx,%esi
8010557b:	19 cf                	sbb    %ecx,%edi
	if(divisor < 0)
		divisor = -divisor;

	for(;;) {
		long long divisor2 = divisor;
		while(number >= divisor2) {
8010557d:	39 fa                	cmp    %edi,%edx
8010557f:	7d 1f                	jge    801055a0 <__moddi3+0x80>
			if(divisor2 + divisor2 > 0) //exponential decay.
				divisor2 += divisor2;
		}

		if(number < divisor)
			return isNumberNegative ? -number : number;
80105581:	80 7d df 00          	cmpb   $0x0,-0x21(%ebp)
80105585:	74 07                	je     8010558e <__moddi3+0x6e>
80105587:	f7 d8                	neg    %eax
80105589:	83 d2 00             	adc    $0x0,%edx
8010558c:	f7 da                	neg    %edx
	}
}
8010558e:	83 c4 2c             	add    $0x2c,%esp
80105591:	5b                   	pop    %ebx
80105592:	5e                   	pop    %esi
80105593:	5f                   	pop    %edi
80105594:	5d                   	pop    %ebp
80105595:	c3                   	ret    
80105596:	8d 76 00             	lea    0x0(%esi),%esi
80105599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		while(number >= divisor2) {
801055a0:	7f 04                	jg     801055a6 <__moddi3+0x86>
801055a2:	39 f0                	cmp    %esi,%eax
801055a4:	72 db                	jb     80105581 <__moddi3+0x61>
801055a6:	89 f1                	mov    %esi,%ecx
801055a8:	89 fb                	mov    %edi,%ebx
801055aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			number -= divisor2;
801055b0:	29 c8                	sub    %ecx,%eax
801055b2:	19 da                	sbb    %ebx,%edx
				divisor2 += divisor2;
801055b4:	0f a4 cb 01          	shld   $0x1,%ecx,%ebx
801055b8:	01 c9                	add    %ecx,%ecx
		while(number >= divisor2) {
801055ba:	39 da                	cmp    %ebx,%edx
801055bc:	7f f2                	jg     801055b0 <__moddi3+0x90>
801055be:	7d 18                	jge    801055d8 <__moddi3+0xb8>
		if(number < divisor)
801055c0:	39 d7                	cmp    %edx,%edi
801055c2:	7c b9                	jl     8010557d <__moddi3+0x5d>
801055c4:	7f bb                	jg     80105581 <__moddi3+0x61>
801055c6:	39 c6                	cmp    %eax,%esi
801055c8:	76 b3                	jbe    8010557d <__moddi3+0x5d>
801055ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801055d0:	eb af                	jmp    80105581 <__moddi3+0x61>
801055d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		while(number >= divisor2) {
801055d8:	39 c8                	cmp    %ecx,%eax
801055da:	73 d4                	jae    801055b0 <__moddi3+0x90>
801055dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801055e0:	eb de                	jmp    801055c0 <__moddi3+0xa0>
		panic((char*)"divide by zero!!!\n");
801055e2:	c7 04 24 a8 8b 10 80 	movl   $0x80108ba8,(%esp)
801055e9:	e8 82 ad ff ff       	call   80100370 <panic>
801055ee:	66 90                	xchg   %ax,%ax

801055f0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801055f0:	55                   	push   %ebp
  initlock(&lk->lk, "sleep lock");
801055f1:	b8 bb 8b 10 80       	mov    $0x80108bbb,%eax
{
801055f6:	89 e5                	mov    %esp,%ebp
801055f8:	53                   	push   %ebx
801055f9:	83 ec 14             	sub    $0x14,%esp
801055fc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801055ff:	89 44 24 04          	mov    %eax,0x4(%esp)
80105603:	8d 43 04             	lea    0x4(%ebx),%eax
80105606:	89 04 24             	mov    %eax,(%esp)
80105609:	e8 12 01 00 00       	call   80105720 <initlock>
  lk->name = name;
8010560e:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80105611:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80105617:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010561e:	89 43 38             	mov    %eax,0x38(%ebx)
}
80105621:	83 c4 14             	add    $0x14,%esp
80105624:	5b                   	pop    %ebx
80105625:	5d                   	pop    %ebp
80105626:	c3                   	ret    
80105627:	89 f6                	mov    %esi,%esi
80105629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105630 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80105630:	55                   	push   %ebp
80105631:	89 e5                	mov    %esp,%ebp
80105633:	56                   	push   %esi
80105634:	53                   	push   %ebx
80105635:	83 ec 10             	sub    $0x10,%esp
80105638:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010563b:	8d 73 04             	lea    0x4(%ebx),%esi
8010563e:	89 34 24             	mov    %esi,(%esp)
80105641:	e8 2a 02 00 00       	call   80105870 <acquire>
  while (lk->locked) {
80105646:	8b 13                	mov    (%ebx),%edx
80105648:	85 d2                	test   %edx,%edx
8010564a:	74 16                	je     80105662 <acquiresleep+0x32>
8010564c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80105650:	89 74 24 04          	mov    %esi,0x4(%esp)
80105654:	89 1c 24             	mov    %ebx,(%esp)
80105657:	e8 d4 ec ff ff       	call   80104330 <sleep>
  while (lk->locked) {
8010565c:	8b 03                	mov    (%ebx),%eax
8010565e:	85 c0                	test   %eax,%eax
80105660:	75 ee                	jne    80105650 <acquiresleep+0x20>
  }
  lk->locked = 1;
80105662:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80105668:	e8 b3 e3 ff ff       	call   80103a20 <myproc>
8010566d:	8b 40 10             	mov    0x10(%eax),%eax
80105670:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80105673:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105676:	83 c4 10             	add    $0x10,%esp
80105679:	5b                   	pop    %ebx
8010567a:	5e                   	pop    %esi
8010567b:	5d                   	pop    %ebp
  release(&lk->lk);
8010567c:	e9 8f 02 00 00       	jmp    80105910 <release>
80105681:	eb 0d                	jmp    80105690 <releasesleep>
80105683:	90                   	nop
80105684:	90                   	nop
80105685:	90                   	nop
80105686:	90                   	nop
80105687:	90                   	nop
80105688:	90                   	nop
80105689:	90                   	nop
8010568a:	90                   	nop
8010568b:	90                   	nop
8010568c:	90                   	nop
8010568d:	90                   	nop
8010568e:	90                   	nop
8010568f:	90                   	nop

80105690 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80105690:	55                   	push   %ebp
80105691:	89 e5                	mov    %esp,%ebp
80105693:	83 ec 18             	sub    $0x18,%esp
80105696:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105699:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010569c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  acquire(&lk->lk);
8010569f:	8d 73 04             	lea    0x4(%ebx),%esi
801056a2:	89 34 24             	mov    %esi,(%esp)
801056a5:	e8 c6 01 00 00       	call   80105870 <acquire>
  lk->locked = 0;
801056aa:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801056b0:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801056b7:	89 1c 24             	mov    %ebx,(%esp)
801056ba:	e8 61 ee ff ff       	call   80104520 <wakeup>
  release(&lk->lk);
}
801056bf:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  release(&lk->lk);
801056c2:	89 75 08             	mov    %esi,0x8(%ebp)
}
801056c5:	8b 75 fc             	mov    -0x4(%ebp),%esi
801056c8:	89 ec                	mov    %ebp,%esp
801056ca:	5d                   	pop    %ebp
  release(&lk->lk);
801056cb:	e9 40 02 00 00       	jmp    80105910 <release>

801056d0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801056d0:	55                   	push   %ebp
801056d1:	89 e5                	mov    %esp,%ebp
801056d3:	83 ec 28             	sub    $0x28,%esp
801056d6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801056d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801056dc:	89 7d fc             	mov    %edi,-0x4(%ebp)
801056df:	89 75 f8             	mov    %esi,-0x8(%ebp)
801056e2:	31 f6                	xor    %esi,%esi
  int r;
  
  acquire(&lk->lk);
801056e4:	8d 7b 04             	lea    0x4(%ebx),%edi
801056e7:	89 3c 24             	mov    %edi,(%esp)
801056ea:	e8 81 01 00 00       	call   80105870 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801056ef:	8b 03                	mov    (%ebx),%eax
801056f1:	85 c0                	test   %eax,%eax
801056f3:	74 11                	je     80105706 <holdingsleep+0x36>
801056f5:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801056f8:	e8 23 e3 ff ff       	call   80103a20 <myproc>
801056fd:	39 58 10             	cmp    %ebx,0x10(%eax)
80105700:	0f 94 c0             	sete   %al
80105703:	0f b6 f0             	movzbl %al,%esi
  release(&lk->lk);
80105706:	89 3c 24             	mov    %edi,(%esp)
80105709:	e8 02 02 00 00       	call   80105910 <release>
  return r;
}
8010570e:	89 f0                	mov    %esi,%eax
80105710:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105713:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105716:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105719:	89 ec                	mov    %ebp,%esp
8010571b:	5d                   	pop    %ebp
8010571c:	c3                   	ret    
8010571d:	66 90                	xchg   %ax,%ax
8010571f:	90                   	nop

80105720 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105720:	55                   	push   %ebp
80105721:	89 e5                	mov    %esp,%ebp
80105723:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80105726:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80105729:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010572f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80105732:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105739:	5d                   	pop    %ebp
8010573a:	c3                   	ret    
8010573b:	90                   	nop
8010573c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105740 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105740:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105741:	31 d2                	xor    %edx,%edx
{
80105743:	89 e5                	mov    %esp,%ebp
  ebp = (uint*)v - 2;
80105745:	8b 45 08             	mov    0x8(%ebp),%eax
{
80105748:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010574b:	53                   	push   %ebx
  ebp = (uint*)v - 2;
8010574c:	83 e8 08             	sub    $0x8,%eax
8010574f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105750:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80105756:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010575c:	77 12                	ja     80105770 <getcallerpcs+0x30>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010575e:	8b 58 04             	mov    0x4(%eax),%ebx
80105761:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80105764:	42                   	inc    %edx
80105765:	83 fa 0a             	cmp    $0xa,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80105768:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
8010576a:	75 e4                	jne    80105750 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010576c:	5b                   	pop    %ebx
8010576d:	5d                   	pop    %ebp
8010576e:	c3                   	ret    
8010576f:	90                   	nop
80105770:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80105773:	83 c1 28             	add    $0x28,%ecx
80105776:	8d 76 00             	lea    0x0(%esi),%esi
80105779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80105780:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105786:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80105789:	39 c1                	cmp    %eax,%ecx
8010578b:	75 f3                	jne    80105780 <getcallerpcs+0x40>
}
8010578d:	5b                   	pop    %ebx
8010578e:	5d                   	pop    %ebp
8010578f:	c3                   	ret    

80105790 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105790:	55                   	push   %ebp
80105791:	89 e5                	mov    %esp,%ebp
80105793:	53                   	push   %ebx
80105794:	83 ec 04             	sub    $0x4,%esp
80105797:	9c                   	pushf  
80105798:	5b                   	pop    %ebx
  asm volatile("cli");
80105799:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010579a:	e8 e1 e1 ff ff       	call   80103980 <mycpu>
8010579f:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801057a5:	85 d2                	test   %edx,%edx
801057a7:	75 11                	jne    801057ba <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801057a9:	e8 d2 e1 ff ff       	call   80103980 <mycpu>
801057ae:	81 e3 00 02 00 00    	and    $0x200,%ebx
801057b4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801057ba:	e8 c1 e1 ff ff       	call   80103980 <mycpu>
801057bf:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
}
801057c5:	58                   	pop    %eax
801057c6:	5b                   	pop    %ebx
801057c7:	5d                   	pop    %ebp
801057c8:	c3                   	ret    
801057c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801057d0 <popcli>:

void
popcli(void)
{
801057d0:	55                   	push   %ebp
801057d1:	89 e5                	mov    %esp,%ebp
801057d3:	83 ec 18             	sub    $0x18,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801057d6:	9c                   	pushf  
801057d7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801057d8:	f6 c4 02             	test   $0x2,%ah
801057db:	75 35                	jne    80105812 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801057dd:	e8 9e e1 ff ff       	call   80103980 <mycpu>
801057e2:	ff 88 a4 00 00 00    	decl   0xa4(%eax)
801057e8:	78 34                	js     8010581e <popcli+0x4e>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801057ea:	e8 91 e1 ff ff       	call   80103980 <mycpu>
801057ef:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801057f5:	85 d2                	test   %edx,%edx
801057f7:	74 07                	je     80105800 <popcli+0x30>
    sti();
}
801057f9:	c9                   	leave  
801057fa:	c3                   	ret    
801057fb:	90                   	nop
801057fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105800:	e8 7b e1 ff ff       	call   80103980 <mycpu>
80105805:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010580b:	85 c0                	test   %eax,%eax
8010580d:	74 ea                	je     801057f9 <popcli+0x29>
  asm volatile("sti");
8010580f:	fb                   	sti    
}
80105810:	c9                   	leave  
80105811:	c3                   	ret    
    panic("popcli - interruptible");
80105812:	c7 04 24 c6 8b 10 80 	movl   $0x80108bc6,(%esp)
80105819:	e8 52 ab ff ff       	call   80100370 <panic>
    panic("popcli");
8010581e:	c7 04 24 dd 8b 10 80 	movl   $0x80108bdd,(%esp)
80105825:	e8 46 ab ff ff       	call   80100370 <panic>
8010582a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105830 <holding>:
{
80105830:	55                   	push   %ebp
80105831:	89 e5                	mov    %esp,%ebp
80105833:	83 ec 08             	sub    $0x8,%esp
80105836:	89 75 fc             	mov    %esi,-0x4(%ebp)
80105839:	8b 75 08             	mov    0x8(%ebp),%esi
8010583c:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010583f:	31 db                	xor    %ebx,%ebx
  pushcli();
80105841:	e8 4a ff ff ff       	call   80105790 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105846:	8b 06                	mov    (%esi),%eax
80105848:	85 c0                	test   %eax,%eax
8010584a:	74 10                	je     8010585c <holding+0x2c>
8010584c:	8b 5e 08             	mov    0x8(%esi),%ebx
8010584f:	e8 2c e1 ff ff       	call   80103980 <mycpu>
80105854:	39 c3                	cmp    %eax,%ebx
80105856:	0f 94 c3             	sete   %bl
80105859:	0f b6 db             	movzbl %bl,%ebx
  popcli();
8010585c:	e8 6f ff ff ff       	call   801057d0 <popcli>
}
80105861:	89 d8                	mov    %ebx,%eax
80105863:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105866:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105869:	89 ec                	mov    %ebp,%esp
8010586b:	5d                   	pop    %ebp
8010586c:	c3                   	ret    
8010586d:	8d 76 00             	lea    0x0(%esi),%esi

80105870 <acquire>:
{
80105870:	55                   	push   %ebp
80105871:	89 e5                	mov    %esp,%ebp
80105873:	56                   	push   %esi
80105874:	53                   	push   %ebx
80105875:	83 ec 10             	sub    $0x10,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105878:	e8 13 ff ff ff       	call   80105790 <pushcli>
  if(holding(lk))
8010587d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105880:	89 1c 24             	mov    %ebx,(%esp)
80105883:	e8 a8 ff ff ff       	call   80105830 <holding>
80105888:	85 c0                	test   %eax,%eax
8010588a:	75 78                	jne    80105904 <acquire+0x94>
8010588c:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
8010588e:	ba 01 00 00 00       	mov    $0x1,%edx
80105893:	eb 06                	jmp    8010589b <acquire+0x2b>
80105895:	8d 76 00             	lea    0x0(%esi),%esi
80105898:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010589b:	89 d0                	mov    %edx,%eax
8010589d:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
801058a0:	85 c0                	test   %eax,%eax
801058a2:	75 f4                	jne    80105898 <acquire+0x28>
  __sync_synchronize();
801058a4:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801058a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801058ac:	e8 cf e0 ff ff       	call   80103980 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801058b1:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
801058b4:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
801058b7:	89 e8                	mov    %ebp,%eax
801058b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801058c0:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
801058c6:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
801058cc:	77 1a                	ja     801058e8 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
801058ce:	8b 48 04             	mov    0x4(%eax),%ecx
801058d1:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
801058d4:	46                   	inc    %esi
801058d5:	83 fe 0a             	cmp    $0xa,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
801058d8:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801058da:	75 e4                	jne    801058c0 <acquire+0x50>
}
801058dc:	83 c4 10             	add    $0x10,%esp
801058df:	5b                   	pop    %ebx
801058e0:	5e                   	pop    %esi
801058e1:	5d                   	pop    %ebp
801058e2:	c3                   	ret    
801058e3:	90                   	nop
801058e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801058e8:	8d 04 b2             	lea    (%edx,%esi,4),%eax
801058eb:	83 c2 28             	add    $0x28,%edx
801058ee:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
801058f0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801058f6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801058f9:	39 d0                	cmp    %edx,%eax
801058fb:	75 f3                	jne    801058f0 <acquire+0x80>
}
801058fd:	83 c4 10             	add    $0x10,%esp
80105900:	5b                   	pop    %ebx
80105901:	5e                   	pop    %esi
80105902:	5d                   	pop    %ebp
80105903:	c3                   	ret    
    panic("acquire");
80105904:	c7 04 24 e4 8b 10 80 	movl   $0x80108be4,(%esp)
8010590b:	e8 60 aa ff ff       	call   80100370 <panic>

80105910 <release>:
{
80105910:	55                   	push   %ebp
80105911:	89 e5                	mov    %esp,%ebp
80105913:	53                   	push   %ebx
80105914:	83 ec 14             	sub    $0x14,%esp
80105917:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010591a:	89 1c 24             	mov    %ebx,(%esp)
8010591d:	e8 0e ff ff ff       	call   80105830 <holding>
80105922:	85 c0                	test   %eax,%eax
80105924:	74 23                	je     80105949 <release+0x39>
  lk->pcs[0] = 0;
80105926:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010592d:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105934:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80105939:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
8010593f:	83 c4 14             	add    $0x14,%esp
80105942:	5b                   	pop    %ebx
80105943:	5d                   	pop    %ebp
  popcli();
80105944:	e9 87 fe ff ff       	jmp    801057d0 <popcli>
    panic("release");
80105949:	c7 04 24 ec 8b 10 80 	movl   $0x80108bec,(%esp)
80105950:	e8 1b aa ff ff       	call   80100370 <panic>
80105955:	66 90                	xchg   %ax,%ax
80105957:	66 90                	xchg   %ax,%ax
80105959:	66 90                	xchg   %ax,%ax
8010595b:	66 90                	xchg   %ax,%ax
8010595d:	66 90                	xchg   %ax,%ax
8010595f:	90                   	nop

80105960 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105960:	55                   	push   %ebp
80105961:	89 e5                	mov    %esp,%ebp
80105963:	83 ec 08             	sub    $0x8,%esp
80105966:	8b 55 08             	mov    0x8(%ebp),%edx
80105969:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010596c:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010596f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if ((int)dst%4 == 0 && n%4 == 0){
80105972:	f6 c2 03             	test   $0x3,%dl
80105975:	75 05                	jne    8010597c <memset+0x1c>
80105977:	f6 c1 03             	test   $0x3,%cl
8010597a:	74 14                	je     80105990 <memset+0x30>
  asm volatile("cld; rep stosb" :
8010597c:	89 d7                	mov    %edx,%edi
8010597e:	8b 45 0c             	mov    0xc(%ebp),%eax
80105981:	fc                   	cld    
80105982:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80105984:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105987:	89 d0                	mov    %edx,%eax
80105989:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010598c:	89 ec                	mov    %ebp,%esp
8010598e:	5d                   	pop    %ebp
8010598f:	c3                   	ret    
    c &= 0xFF;
80105990:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80105994:	c1 e9 02             	shr    $0x2,%ecx
80105997:	89 f8                	mov    %edi,%eax
80105999:	89 fb                	mov    %edi,%ebx
8010599b:	c1 e0 18             	shl    $0x18,%eax
8010599e:	c1 e3 10             	shl    $0x10,%ebx
801059a1:	09 d8                	or     %ebx,%eax
801059a3:	09 f8                	or     %edi,%eax
801059a5:	c1 e7 08             	shl    $0x8,%edi
801059a8:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
801059aa:	89 d7                	mov    %edx,%edi
801059ac:	fc                   	cld    
801059ad:	f3 ab                	rep stos %eax,%es:(%edi)
}
801059af:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801059b2:	89 d0                	mov    %edx,%eax
801059b4:	8b 7d fc             	mov    -0x4(%ebp),%edi
801059b7:	89 ec                	mov    %ebp,%esp
801059b9:	5d                   	pop    %ebp
801059ba:	c3                   	ret    
801059bb:	90                   	nop
801059bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801059c0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801059c0:	55                   	push   %ebp
801059c1:	89 e5                	mov    %esp,%ebp
801059c3:	57                   	push   %edi
801059c4:	8b 7d 0c             	mov    0xc(%ebp),%edi
801059c7:	56                   	push   %esi
801059c8:	8b 75 08             	mov    0x8(%ebp),%esi
801059cb:	53                   	push   %ebx
801059cc:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801059cf:	85 db                	test   %ebx,%ebx
801059d1:	74 27                	je     801059fa <memcmp+0x3a>
    if(*s1 != *s2)
801059d3:	0f b6 16             	movzbl (%esi),%edx
801059d6:	0f b6 0f             	movzbl (%edi),%ecx
801059d9:	38 d1                	cmp    %dl,%cl
801059db:	75 2b                	jne    80105a08 <memcmp+0x48>
801059dd:	b8 01 00 00 00       	mov    $0x1,%eax
801059e2:	eb 12                	jmp    801059f6 <memcmp+0x36>
801059e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801059e8:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
801059ec:	40                   	inc    %eax
801059ed:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
801059f2:	38 ca                	cmp    %cl,%dl
801059f4:	75 12                	jne    80105a08 <memcmp+0x48>
  while(n-- > 0){
801059f6:	39 d8                	cmp    %ebx,%eax
801059f8:	75 ee                	jne    801059e8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
801059fa:	5b                   	pop    %ebx
  return 0;
801059fb:	31 c0                	xor    %eax,%eax
}
801059fd:	5e                   	pop    %esi
801059fe:	5f                   	pop    %edi
801059ff:	5d                   	pop    %ebp
80105a00:	c3                   	ret    
80105a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a08:	5b                   	pop    %ebx
      return *s1 - *s2;
80105a09:	0f b6 c2             	movzbl %dl,%eax
80105a0c:	29 c8                	sub    %ecx,%eax
}
80105a0e:	5e                   	pop    %esi
80105a0f:	5f                   	pop    %edi
80105a10:	5d                   	pop    %ebp
80105a11:	c3                   	ret    
80105a12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a20 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105a20:	55                   	push   %ebp
80105a21:	89 e5                	mov    %esp,%ebp
80105a23:	56                   	push   %esi
80105a24:	8b 45 08             	mov    0x8(%ebp),%eax
80105a27:	53                   	push   %ebx
80105a28:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80105a2b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80105a2e:	39 c3                	cmp    %eax,%ebx
80105a30:	73 26                	jae    80105a58 <memmove+0x38>
80105a32:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80105a35:	39 c8                	cmp    %ecx,%eax
80105a37:	73 1f                	jae    80105a58 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80105a39:	85 f6                	test   %esi,%esi
80105a3b:	8d 56 ff             	lea    -0x1(%esi),%edx
80105a3e:	74 0d                	je     80105a4d <memmove+0x2d>
      *--d = *--s;
80105a40:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105a44:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80105a47:	4a                   	dec    %edx
80105a48:	83 fa ff             	cmp    $0xffffffff,%edx
80105a4b:	75 f3                	jne    80105a40 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80105a4d:	5b                   	pop    %ebx
80105a4e:	5e                   	pop    %esi
80105a4f:	5d                   	pop    %ebp
80105a50:	c3                   	ret    
80105a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80105a58:	31 d2                	xor    %edx,%edx
80105a5a:	85 f6                	test   %esi,%esi
80105a5c:	74 ef                	je     80105a4d <memmove+0x2d>
80105a5e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80105a60:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105a64:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80105a67:	42                   	inc    %edx
    while(n-- > 0)
80105a68:	39 d6                	cmp    %edx,%esi
80105a6a:	75 f4                	jne    80105a60 <memmove+0x40>
}
80105a6c:	5b                   	pop    %ebx
80105a6d:	5e                   	pop    %esi
80105a6e:	5d                   	pop    %ebp
80105a6f:	c3                   	ret    

80105a70 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105a70:	55                   	push   %ebp
80105a71:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80105a73:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80105a74:	eb aa                	jmp    80105a20 <memmove>
80105a76:	8d 76 00             	lea    0x0(%esi),%esi
80105a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a80 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80105a80:	55                   	push   %ebp
80105a81:	89 e5                	mov    %esp,%ebp
80105a83:	57                   	push   %edi
80105a84:	8b 7d 10             	mov    0x10(%ebp),%edi
80105a87:	56                   	push   %esi
80105a88:	8b 75 0c             	mov    0xc(%ebp),%esi
80105a8b:	53                   	push   %ebx
80105a8c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
80105a8f:	85 ff                	test   %edi,%edi
80105a91:	74 2d                	je     80105ac0 <strncmp+0x40>
80105a93:	0f b6 03             	movzbl (%ebx),%eax
80105a96:	0f b6 0e             	movzbl (%esi),%ecx
80105a99:	84 c0                	test   %al,%al
80105a9b:	74 37                	je     80105ad4 <strncmp+0x54>
80105a9d:	38 c1                	cmp    %al,%cl
80105a9f:	75 33                	jne    80105ad4 <strncmp+0x54>
80105aa1:	01 f7                	add    %esi,%edi
80105aa3:	eb 13                	jmp    80105ab8 <strncmp+0x38>
80105aa5:	8d 76 00             	lea    0x0(%esi),%esi
80105aa8:	0f b6 03             	movzbl (%ebx),%eax
80105aab:	84 c0                	test   %al,%al
80105aad:	74 21                	je     80105ad0 <strncmp+0x50>
80105aaf:	0f b6 0a             	movzbl (%edx),%ecx
80105ab2:	89 d6                	mov    %edx,%esi
80105ab4:	38 c8                	cmp    %cl,%al
80105ab6:	75 1c                	jne    80105ad4 <strncmp+0x54>
    n--, p++, q++;
80105ab8:	8d 56 01             	lea    0x1(%esi),%edx
80105abb:	43                   	inc    %ebx
  while(n > 0 && *p && *p == *q)
80105abc:	39 fa                	cmp    %edi,%edx
80105abe:	75 e8                	jne    80105aa8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80105ac0:	5b                   	pop    %ebx
    return 0;
80105ac1:	31 c0                	xor    %eax,%eax
}
80105ac3:	5e                   	pop    %esi
80105ac4:	5f                   	pop    %edi
80105ac5:	5d                   	pop    %ebp
80105ac6:	c3                   	ret    
80105ac7:	89 f6                	mov    %esi,%esi
80105ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105ad0:	0f b6 4e 01          	movzbl 0x1(%esi),%ecx
80105ad4:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
80105ad5:	29 c8                	sub    %ecx,%eax
}
80105ad7:	5e                   	pop    %esi
80105ad8:	5f                   	pop    %edi
80105ad9:	5d                   	pop    %ebp
80105ada:	c3                   	ret    
80105adb:	90                   	nop
80105adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ae0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105ae0:	55                   	push   %ebp
80105ae1:	89 e5                	mov    %esp,%ebp
80105ae3:	8b 45 08             	mov    0x8(%ebp),%eax
80105ae6:	56                   	push   %esi
80105ae7:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105aea:	53                   	push   %ebx
80105aeb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80105aee:	89 c2                	mov    %eax,%edx
80105af0:	eb 15                	jmp    80105b07 <strncpy+0x27>
80105af2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105af8:	46                   	inc    %esi
80105af9:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
80105afd:	42                   	inc    %edx
80105afe:	84 c9                	test   %cl,%cl
80105b00:	88 4a ff             	mov    %cl,-0x1(%edx)
80105b03:	74 09                	je     80105b0e <strncpy+0x2e>
80105b05:	89 d9                	mov    %ebx,%ecx
80105b07:	85 c9                	test   %ecx,%ecx
80105b09:	8d 59 ff             	lea    -0x1(%ecx),%ebx
80105b0c:	7f ea                	jg     80105af8 <strncpy+0x18>
    ;
  while(n-- > 0)
80105b0e:	31 c9                	xor    %ecx,%ecx
80105b10:	85 db                	test   %ebx,%ebx
80105b12:	7e 19                	jle    80105b2d <strncpy+0x4d>
80105b14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105b1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *s++ = 0;
80105b20:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80105b24:	89 de                	mov    %ebx,%esi
80105b26:	41                   	inc    %ecx
80105b27:	29 ce                	sub    %ecx,%esi
  while(n-- > 0)
80105b29:	85 f6                	test   %esi,%esi
80105b2b:	7f f3                	jg     80105b20 <strncpy+0x40>
  return os;
}
80105b2d:	5b                   	pop    %ebx
80105b2e:	5e                   	pop    %esi
80105b2f:	5d                   	pop    %ebp
80105b30:	c3                   	ret    
80105b31:	eb 0d                	jmp    80105b40 <safestrcpy>
80105b33:	90                   	nop
80105b34:	90                   	nop
80105b35:	90                   	nop
80105b36:	90                   	nop
80105b37:	90                   	nop
80105b38:	90                   	nop
80105b39:	90                   	nop
80105b3a:	90                   	nop
80105b3b:	90                   	nop
80105b3c:	90                   	nop
80105b3d:	90                   	nop
80105b3e:	90                   	nop
80105b3f:	90                   	nop

80105b40 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105b40:	55                   	push   %ebp
80105b41:	89 e5                	mov    %esp,%ebp
80105b43:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105b46:	56                   	push   %esi
80105b47:	8b 45 08             	mov    0x8(%ebp),%eax
80105b4a:	53                   	push   %ebx
80105b4b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80105b4e:	85 c9                	test   %ecx,%ecx
80105b50:	7e 22                	jle    80105b74 <safestrcpy+0x34>
80105b52:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80105b56:	89 c1                	mov    %eax,%ecx
80105b58:	eb 13                	jmp    80105b6d <safestrcpy+0x2d>
80105b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105b60:	42                   	inc    %edx
80105b61:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80105b65:	41                   	inc    %ecx
80105b66:	84 db                	test   %bl,%bl
80105b68:	88 59 ff             	mov    %bl,-0x1(%ecx)
80105b6b:	74 04                	je     80105b71 <safestrcpy+0x31>
80105b6d:	39 f2                	cmp    %esi,%edx
80105b6f:	75 ef                	jne    80105b60 <safestrcpy+0x20>
    ;
  *s = 0;
80105b71:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80105b74:	5b                   	pop    %ebx
80105b75:	5e                   	pop    %esi
80105b76:	5d                   	pop    %ebp
80105b77:	c3                   	ret    
80105b78:	90                   	nop
80105b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105b80 <strlen>:

int
strlen(const char *s)
{
80105b80:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105b81:	31 c0                	xor    %eax,%eax
{
80105b83:	89 e5                	mov    %esp,%ebp
80105b85:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105b88:	80 3a 00             	cmpb   $0x0,(%edx)
80105b8b:	74 0a                	je     80105b97 <strlen+0x17>
80105b8d:	8d 76 00             	lea    0x0(%esi),%esi
80105b90:	40                   	inc    %eax
80105b91:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105b95:	75 f9                	jne    80105b90 <strlen+0x10>
    ;
  return n;
}
80105b97:	5d                   	pop    %ebp
80105b98:	c3                   	ret    

80105b99 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80105b99:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80105b9d:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80105ba1:	55                   	push   %ebp
  pushl %ebx
80105ba2:	53                   	push   %ebx
  pushl %esi
80105ba3:	56                   	push   %esi
  pushl %edi
80105ba4:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105ba5:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105ba7:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80105ba9:	5f                   	pop    %edi
  popl %esi
80105baa:	5e                   	pop    %esi
  popl %ebx
80105bab:	5b                   	pop    %ebx
  popl %ebp
80105bac:	5d                   	pop    %ebp
  ret
80105bad:	c3                   	ret    
80105bae:	66 90                	xchg   %ax,%ax

80105bb0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105bb0:	55                   	push   %ebp
80105bb1:	89 e5                	mov    %esp,%ebp
80105bb3:	53                   	push   %ebx
80105bb4:	83 ec 04             	sub    $0x4,%esp
80105bb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80105bba:	e8 61 de ff ff       	call   80103a20 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105bbf:	8b 00                	mov    (%eax),%eax
80105bc1:	39 d8                	cmp    %ebx,%eax
80105bc3:	76 1b                	jbe    80105be0 <fetchint+0x30>
80105bc5:	8d 53 04             	lea    0x4(%ebx),%edx
80105bc8:	39 d0                	cmp    %edx,%eax
80105bca:	72 14                	jb     80105be0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80105bcc:	8b 45 0c             	mov    0xc(%ebp),%eax
80105bcf:	8b 13                	mov    (%ebx),%edx
80105bd1:	89 10                	mov    %edx,(%eax)
  return 0;
80105bd3:	31 c0                	xor    %eax,%eax
}
80105bd5:	5a                   	pop    %edx
80105bd6:	5b                   	pop    %ebx
80105bd7:	5d                   	pop    %ebp
80105bd8:	c3                   	ret    
80105bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105be0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105be5:	eb ee                	jmp    80105bd5 <fetchint+0x25>
80105be7:	89 f6                	mov    %esi,%esi
80105be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105bf0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105bf0:	55                   	push   %ebp
80105bf1:	89 e5                	mov    %esp,%ebp
80105bf3:	53                   	push   %ebx
80105bf4:	83 ec 04             	sub    $0x4,%esp
80105bf7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80105bfa:	e8 21 de ff ff       	call   80103a20 <myproc>

  if(addr >= curproc->sz)
80105bff:	39 18                	cmp    %ebx,(%eax)
80105c01:	76 27                	jbe    80105c2a <fetchstr+0x3a>
    return -1;
  *pp = (char*)addr;
80105c03:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105c06:	89 da                	mov    %ebx,%edx
80105c08:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80105c0a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80105c0c:	39 c3                	cmp    %eax,%ebx
80105c0e:	73 1a                	jae    80105c2a <fetchstr+0x3a>
    if(*s == 0)
80105c10:	80 3b 00             	cmpb   $0x0,(%ebx)
80105c13:	75 10                	jne    80105c25 <fetchstr+0x35>
80105c15:	eb 29                	jmp    80105c40 <fetchstr+0x50>
80105c17:	89 f6                	mov    %esi,%esi
80105c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105c20:	80 3a 00             	cmpb   $0x0,(%edx)
80105c23:	74 13                	je     80105c38 <fetchstr+0x48>
  for(s = *pp; s < ep; s++){
80105c25:	42                   	inc    %edx
80105c26:	39 d0                	cmp    %edx,%eax
80105c28:	77 f6                	ja     80105c20 <fetchstr+0x30>
    return -1;
80105c2a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80105c2f:	5a                   	pop    %edx
80105c30:	5b                   	pop    %ebx
80105c31:	5d                   	pop    %ebp
80105c32:	c3                   	ret    
80105c33:	90                   	nop
80105c34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c38:	89 d0                	mov    %edx,%eax
80105c3a:	5a                   	pop    %edx
80105c3b:	29 d8                	sub    %ebx,%eax
80105c3d:	5b                   	pop    %ebx
80105c3e:	5d                   	pop    %ebp
80105c3f:	c3                   	ret    
    if(*s == 0)
80105c40:	31 c0                	xor    %eax,%eax
      return s - *pp;
80105c42:	eb eb                	jmp    80105c2f <fetchstr+0x3f>
80105c44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105c4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105c50 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105c50:	55                   	push   %ebp
80105c51:	89 e5                	mov    %esp,%ebp
80105c53:	56                   	push   %esi
80105c54:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105c55:	e8 c6 dd ff ff       	call   80103a20 <myproc>
80105c5a:	8b 55 08             	mov    0x8(%ebp),%edx
80105c5d:	8b 40 18             	mov    0x18(%eax),%eax
80105c60:	8b 40 44             	mov    0x44(%eax),%eax
80105c63:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105c66:	e8 b5 dd ff ff       	call   80103a20 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105c6b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105c6e:	8b 00                	mov    (%eax),%eax
80105c70:	39 c6                	cmp    %eax,%esi
80105c72:	73 1c                	jae    80105c90 <argint+0x40>
80105c74:	8d 53 08             	lea    0x8(%ebx),%edx
80105c77:	39 d0                	cmp    %edx,%eax
80105c79:	72 15                	jb     80105c90 <argint+0x40>
  *ip = *(int*)(addr);
80105c7b:	8b 45 0c             	mov    0xc(%ebp),%eax
80105c7e:	8b 53 04             	mov    0x4(%ebx),%edx
80105c81:	89 10                	mov    %edx,(%eax)
  return 0;
80105c83:	31 c0                	xor    %eax,%eax
}
80105c85:	5b                   	pop    %ebx
80105c86:	5e                   	pop    %esi
80105c87:	5d                   	pop    %ebp
80105c88:	c3                   	ret    
80105c89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105c90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105c95:	eb ee                	jmp    80105c85 <argint+0x35>
80105c97:	89 f6                	mov    %esi,%esi
80105c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ca0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105ca0:	55                   	push   %ebp
80105ca1:	89 e5                	mov    %esp,%ebp
80105ca3:	56                   	push   %esi
80105ca4:	53                   	push   %ebx
80105ca5:	83 ec 20             	sub    $0x20,%esp
80105ca8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80105cab:	e8 70 dd ff ff       	call   80103a20 <myproc>
80105cb0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80105cb2:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105cb5:	89 44 24 04          	mov    %eax,0x4(%esp)
80105cb9:	8b 45 08             	mov    0x8(%ebp),%eax
80105cbc:	89 04 24             	mov    %eax,(%esp)
80105cbf:	e8 8c ff ff ff       	call   80105c50 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105cc4:	c1 e8 1f             	shr    $0x1f,%eax
80105cc7:	84 c0                	test   %al,%al
80105cc9:	75 2d                	jne    80105cf8 <argptr+0x58>
80105ccb:	89 d8                	mov    %ebx,%eax
80105ccd:	c1 e8 1f             	shr    $0x1f,%eax
80105cd0:	84 c0                	test   %al,%al
80105cd2:	75 24                	jne    80105cf8 <argptr+0x58>
80105cd4:	8b 16                	mov    (%esi),%edx
80105cd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cd9:	39 c2                	cmp    %eax,%edx
80105cdb:	76 1b                	jbe    80105cf8 <argptr+0x58>
80105cdd:	01 c3                	add    %eax,%ebx
80105cdf:	39 da                	cmp    %ebx,%edx
80105ce1:	72 15                	jb     80105cf8 <argptr+0x58>
    return -1;
  *pp = (char*)i;
80105ce3:	8b 55 0c             	mov    0xc(%ebp),%edx
80105ce6:	89 02                	mov    %eax,(%edx)
  return 0;
80105ce8:	31 c0                	xor    %eax,%eax
}
80105cea:	83 c4 20             	add    $0x20,%esp
80105ced:	5b                   	pop    %ebx
80105cee:	5e                   	pop    %esi
80105cef:	5d                   	pop    %ebp
80105cf0:	c3                   	ret    
80105cf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105cf8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cfd:	eb eb                	jmp    80105cea <argptr+0x4a>
80105cff:	90                   	nop

80105d00 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105d00:	55                   	push   %ebp
80105d01:	89 e5                	mov    %esp,%ebp
80105d03:	83 ec 28             	sub    $0x28,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105d06:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d09:	89 44 24 04          	mov    %eax,0x4(%esp)
80105d0d:	8b 45 08             	mov    0x8(%ebp),%eax
80105d10:	89 04 24             	mov    %eax,(%esp)
80105d13:	e8 38 ff ff ff       	call   80105c50 <argint>
80105d18:	85 c0                	test   %eax,%eax
80105d1a:	78 14                	js     80105d30 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80105d1c:	8b 45 0c             	mov    0xc(%ebp),%eax
80105d1f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105d23:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d26:	89 04 24             	mov    %eax,(%esp)
80105d29:	e8 c2 fe ff ff       	call   80105bf0 <fetchstr>
}
80105d2e:	c9                   	leave  
80105d2f:	c3                   	ret    
    return -1;
80105d30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d35:	c9                   	leave  
80105d36:	c3                   	ret    
80105d37:	89 f6                	mov    %esi,%esi
80105d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105d40 <syscall>:
[SYS_detach]  sys_detach,
};

void
syscall(void)
{
80105d40:	55                   	push   %ebp
80105d41:	89 e5                	mov    %esp,%ebp
80105d43:	53                   	push   %ebx
80105d44:	83 ec 14             	sub    $0x14,%esp
  int num;
  struct proc *curproc = myproc();
80105d47:	e8 d4 dc ff ff       	call   80103a20 <myproc>
80105d4c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80105d4e:	8b 40 18             	mov    0x18(%eax),%eax
80105d51:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105d54:	8d 50 ff             	lea    -0x1(%eax),%edx
80105d57:	83 fa 15             	cmp    $0x15,%edx
80105d5a:	77 1c                	ja     80105d78 <syscall+0x38>
80105d5c:	8b 14 85 20 8c 10 80 	mov    -0x7fef73e0(,%eax,4),%edx
80105d63:	85 d2                	test   %edx,%edx
80105d65:	74 11                	je     80105d78 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80105d67:	ff d2                	call   *%edx
80105d69:	8b 53 18             	mov    0x18(%ebx),%edx
80105d6c:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105d6f:	83 c4 14             	add    $0x14,%esp
80105d72:	5b                   	pop    %ebx
80105d73:	5d                   	pop    %ebp
80105d74:	c3                   	ret    
80105d75:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80105d78:	89 44 24 0c          	mov    %eax,0xc(%esp)
            curproc->pid, curproc->name, num);
80105d7c:	8d 43 6c             	lea    0x6c(%ebx),%eax
80105d7f:	89 44 24 08          	mov    %eax,0x8(%esp)
    cprintf("%d %s: unknown sys call %d\n",
80105d83:	8b 43 10             	mov    0x10(%ebx),%eax
80105d86:	c7 04 24 f4 8b 10 80 	movl   $0x80108bf4,(%esp)
80105d8d:	89 44 24 04          	mov    %eax,0x4(%esp)
80105d91:	e8 ba a8 ff ff       	call   80100650 <cprintf>
    curproc->tf->eax = -1;
80105d96:	8b 43 18             	mov    0x18(%ebx),%eax
80105d99:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80105da0:	83 c4 14             	add    $0x14,%esp
80105da3:	5b                   	pop    %ebx
80105da4:	5d                   	pop    %ebp
80105da5:	c3                   	ret    
80105da6:	66 90                	xchg   %ax,%ax
80105da8:	66 90                	xchg   %ax,%ax
80105daa:	66 90                	xchg   %ax,%ax
80105dac:	66 90                	xchg   %ax,%ax
80105dae:	66 90                	xchg   %ax,%ax

80105db0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105db0:	55                   	push   %ebp
80105db1:	0f bf d2             	movswl %dx,%edx
80105db4:	89 e5                	mov    %esp,%ebp
80105db6:	83 ec 58             	sub    $0x58,%esp
80105db9:	89 7d fc             	mov    %edi,-0x4(%ebp)
80105dbc:	0f bf 7d 08          	movswl 0x8(%ebp),%edi
80105dc0:	0f bf c9             	movswl %cx,%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105dc3:	89 04 24             	mov    %eax,(%esp)
{
80105dc6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80105dc9:	89 75 f8             	mov    %esi,-0x8(%ebp)
80105dcc:	89 7d bc             	mov    %edi,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80105dcf:	8d 7d da             	lea    -0x26(%ebp),%edi
80105dd2:	89 7c 24 04          	mov    %edi,0x4(%esp)
{
80105dd6:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80105dd9:	89 4d c0             	mov    %ecx,-0x40(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80105ddc:	e8 0f c2 ff ff       	call   80101ff0 <nameiparent>
80105de1:	85 c0                	test   %eax,%eax
80105de3:	0f 84 4f 01 00 00    	je     80105f38 <create+0x188>
    return 0;
  ilock(dp);
80105de9:	89 04 24             	mov    %eax,(%esp)
80105dec:	89 c3                	mov    %eax,%ebx
80105dee:	e8 fd b8 ff ff       	call   801016f0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80105df3:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80105df6:	89 44 24 08          	mov    %eax,0x8(%esp)
80105dfa:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105dfe:	89 1c 24             	mov    %ebx,(%esp)
80105e01:	e8 6a be ff ff       	call   80101c70 <dirlookup>
80105e06:	85 c0                	test   %eax,%eax
80105e08:	89 c6                	mov    %eax,%esi
80105e0a:	74 34                	je     80105e40 <create+0x90>
    iunlockput(dp);
80105e0c:	89 1c 24             	mov    %ebx,(%esp)
80105e0f:	e8 6c bb ff ff       	call   80101980 <iunlockput>
    ilock(ip);
80105e14:	89 34 24             	mov    %esi,(%esp)
80105e17:	e8 d4 b8 ff ff       	call   801016f0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105e1c:	83 7d c4 02          	cmpl   $0x2,-0x3c(%ebp)
80105e20:	0f 85 9a 00 00 00    	jne    80105ec0 <create+0x110>
80105e26:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80105e2b:	0f 85 8f 00 00 00    	jne    80105ec0 <create+0x110>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105e31:	89 f0                	mov    %esi,%eax
80105e33:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105e36:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105e39:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105e3c:	89 ec                	mov    %ebp,%esp
80105e3e:	5d                   	pop    %ebp
80105e3f:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80105e40:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80105e43:	89 44 24 04          	mov    %eax,0x4(%esp)
80105e47:	8b 03                	mov    (%ebx),%eax
80105e49:	89 04 24             	mov    %eax,(%esp)
80105e4c:	e8 1f b7 ff ff       	call   80101570 <ialloc>
80105e51:	85 c0                	test   %eax,%eax
80105e53:	89 c6                	mov    %eax,%esi
80105e55:	0f 84 f0 00 00 00    	je     80105f4b <create+0x19b>
  ilock(ip);
80105e5b:	89 04 24             	mov    %eax,(%esp)
80105e5e:	e8 8d b8 ff ff       	call   801016f0 <ilock>
  ip->major = major;
80105e63:	8b 45 c0             	mov    -0x40(%ebp),%eax
  ip->nlink = 1;
80105e66:	66 c7 46 56 01 00    	movw   $0x1,0x56(%esi)
  ip->major = major;
80105e6c:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80105e70:	8b 45 bc             	mov    -0x44(%ebp),%eax
80105e73:	66 89 46 54          	mov    %ax,0x54(%esi)
  iupdate(ip);
80105e77:	89 34 24             	mov    %esi,(%esp)
80105e7a:	e8 b1 b7 ff ff       	call   80101630 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105e7f:	83 7d c4 01          	cmpl   $0x1,-0x3c(%ebp)
80105e83:	74 5b                	je     80105ee0 <create+0x130>
  if(dirlink(dp, name, ip->inum) < 0)
80105e85:	8b 46 04             	mov    0x4(%esi),%eax
80105e88:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105e8c:	89 1c 24             	mov    %ebx,(%esp)
80105e8f:	89 44 24 08          	mov    %eax,0x8(%esp)
80105e93:	e8 58 c0 ff ff       	call   80101ef0 <dirlink>
80105e98:	85 c0                	test   %eax,%eax
80105e9a:	0f 88 9f 00 00 00    	js     80105f3f <create+0x18f>
  iunlockput(dp);
80105ea0:	89 1c 24             	mov    %ebx,(%esp)
80105ea3:	e8 d8 ba ff ff       	call   80101980 <iunlockput>
}
80105ea8:	89 f0                	mov    %esi,%eax
80105eaa:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105ead:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105eb0:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105eb3:	89 ec                	mov    %ebp,%esp
80105eb5:	5d                   	pop    %ebp
80105eb6:	c3                   	ret    
80105eb7:	89 f6                	mov    %esi,%esi
80105eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105ec0:	89 34 24             	mov    %esi,(%esp)
    return 0;
80105ec3:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80105ec5:	e8 b6 ba ff ff       	call   80101980 <iunlockput>
}
80105eca:	89 f0                	mov    %esi,%eax
80105ecc:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105ecf:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105ed2:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105ed5:	89 ec                	mov    %ebp,%esp
80105ed7:	5d                   	pop    %ebp
80105ed8:	c3                   	ret    
80105ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80105ee0:	66 ff 43 56          	incw   0x56(%ebx)
    iupdate(dp);
80105ee4:	89 1c 24             	mov    %ebx,(%esp)
80105ee7:	e8 44 b7 ff ff       	call   80101630 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105eec:	8b 46 04             	mov    0x4(%esi),%eax
80105eef:	ba 98 8c 10 80       	mov    $0x80108c98,%edx
80105ef4:	89 54 24 04          	mov    %edx,0x4(%esp)
80105ef8:	89 34 24             	mov    %esi,(%esp)
80105efb:	89 44 24 08          	mov    %eax,0x8(%esp)
80105eff:	e8 ec bf ff ff       	call   80101ef0 <dirlink>
80105f04:	85 c0                	test   %eax,%eax
80105f06:	78 20                	js     80105f28 <create+0x178>
80105f08:	8b 43 04             	mov    0x4(%ebx),%eax
80105f0b:	89 34 24             	mov    %esi,(%esp)
80105f0e:	89 44 24 08          	mov    %eax,0x8(%esp)
80105f12:	b8 97 8c 10 80       	mov    $0x80108c97,%eax
80105f17:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f1b:	e8 d0 bf ff ff       	call   80101ef0 <dirlink>
80105f20:	85 c0                	test   %eax,%eax
80105f22:	0f 89 5d ff ff ff    	jns    80105e85 <create+0xd5>
      panic("create dots");
80105f28:	c7 04 24 8b 8c 10 80 	movl   $0x80108c8b,(%esp)
80105f2f:	e8 3c a4 ff ff       	call   80100370 <panic>
80105f34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80105f38:	31 f6                	xor    %esi,%esi
80105f3a:	e9 f2 fe ff ff       	jmp    80105e31 <create+0x81>
    panic("create: dirlink");
80105f3f:	c7 04 24 9a 8c 10 80 	movl   $0x80108c9a,(%esp)
80105f46:	e8 25 a4 ff ff       	call   80100370 <panic>
    panic("create: ialloc");
80105f4b:	c7 04 24 7c 8c 10 80 	movl   $0x80108c7c,(%esp)
80105f52:	e8 19 a4 ff ff       	call   80100370 <panic>
80105f57:	89 f6                	mov    %esi,%esi
80105f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105f60 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80105f60:	55                   	push   %ebp
80105f61:	89 e5                	mov    %esp,%ebp
80105f63:	56                   	push   %esi
80105f64:	89 d6                	mov    %edx,%esi
80105f66:	53                   	push   %ebx
80105f67:	89 c3                	mov    %eax,%ebx
80105f69:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
80105f6c:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f6f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f73:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105f7a:	e8 d1 fc ff ff       	call   80105c50 <argint>
80105f7f:	85 c0                	test   %eax,%eax
80105f81:	78 2d                	js     80105fb0 <argfd.constprop.0+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105f83:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105f87:	77 27                	ja     80105fb0 <argfd.constprop.0+0x50>
80105f89:	e8 92 da ff ff       	call   80103a20 <myproc>
80105f8e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105f91:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80105f95:	85 c0                	test   %eax,%eax
80105f97:	74 17                	je     80105fb0 <argfd.constprop.0+0x50>
  if(pfd)
80105f99:	85 db                	test   %ebx,%ebx
80105f9b:	74 02                	je     80105f9f <argfd.constprop.0+0x3f>
    *pfd = fd;
80105f9d:	89 13                	mov    %edx,(%ebx)
    *pf = f;
80105f9f:	89 06                	mov    %eax,(%esi)
  return 0;
80105fa1:	31 c0                	xor    %eax,%eax
}
80105fa3:	83 c4 20             	add    $0x20,%esp
80105fa6:	5b                   	pop    %ebx
80105fa7:	5e                   	pop    %esi
80105fa8:	5d                   	pop    %ebp
80105fa9:	c3                   	ret    
80105faa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105fb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fb5:	eb ec                	jmp    80105fa3 <argfd.constprop.0+0x43>
80105fb7:	89 f6                	mov    %esi,%esi
80105fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105fc0 <sys_dup>:
{
80105fc0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80105fc1:	31 c0                	xor    %eax,%eax
{
80105fc3:	89 e5                	mov    %esp,%ebp
80105fc5:	56                   	push   %esi
80105fc6:	53                   	push   %ebx
80105fc7:	83 ec 20             	sub    $0x20,%esp
  if(argfd(0, 0, &f) < 0)
80105fca:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105fcd:	e8 8e ff ff ff       	call   80105f60 <argfd.constprop.0>
80105fd2:	85 c0                	test   %eax,%eax
80105fd4:	78 3a                	js     80106010 <sys_dup+0x50>
  if((fd=fdalloc(f)) < 0)
80105fd6:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105fd9:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105fdb:	e8 40 da ff ff       	call   80103a20 <myproc>
80105fe0:	eb 0c                	jmp    80105fee <sys_dup+0x2e>
80105fe2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105fe8:	43                   	inc    %ebx
80105fe9:	83 fb 10             	cmp    $0x10,%ebx
80105fec:	74 22                	je     80106010 <sys_dup+0x50>
    if(curproc->ofile[fd] == 0){
80105fee:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105ff2:	85 d2                	test   %edx,%edx
80105ff4:	75 f2                	jne    80105fe8 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80105ff6:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80105ffa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ffd:	89 04 24             	mov    %eax,(%esp)
80106000:	e8 db ad ff ff       	call   80100de0 <filedup>
}
80106005:	83 c4 20             	add    $0x20,%esp
80106008:	89 d8                	mov    %ebx,%eax
8010600a:	5b                   	pop    %ebx
8010600b:	5e                   	pop    %esi
8010600c:	5d                   	pop    %ebp
8010600d:	c3                   	ret    
8010600e:	66 90                	xchg   %ax,%ax
80106010:	83 c4 20             	add    $0x20,%esp
    return -1;
80106013:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80106018:	89 d8                	mov    %ebx,%eax
8010601a:	5b                   	pop    %ebx
8010601b:	5e                   	pop    %esi
8010601c:	5d                   	pop    %ebp
8010601d:	c3                   	ret    
8010601e:	66 90                	xchg   %ax,%ax

80106020 <sys_read>:
{
80106020:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106021:	31 c0                	xor    %eax,%eax
{
80106023:	89 e5                	mov    %esp,%ebp
80106025:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106028:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010602b:	e8 30 ff ff ff       	call   80105f60 <argfd.constprop.0>
80106030:	85 c0                	test   %eax,%eax
80106032:	78 54                	js     80106088 <sys_read+0x68>
80106034:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106037:	89 44 24 04          	mov    %eax,0x4(%esp)
8010603b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106042:	e8 09 fc ff ff       	call   80105c50 <argint>
80106047:	85 c0                	test   %eax,%eax
80106049:	78 3d                	js     80106088 <sys_read+0x68>
8010604b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010604e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106055:	89 44 24 08          	mov    %eax,0x8(%esp)
80106059:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010605c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106060:	e8 3b fc ff ff       	call   80105ca0 <argptr>
80106065:	85 c0                	test   %eax,%eax
80106067:	78 1f                	js     80106088 <sys_read+0x68>
  return fileread(f, p, n);
80106069:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010606c:	89 44 24 08          	mov    %eax,0x8(%esp)
80106070:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106073:	89 44 24 04          	mov    %eax,0x4(%esp)
80106077:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010607a:	89 04 24             	mov    %eax,(%esp)
8010607d:	e8 de ae ff ff       	call   80100f60 <fileread>
}
80106082:	c9                   	leave  
80106083:	c3                   	ret    
80106084:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106088:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010608d:	c9                   	leave  
8010608e:	c3                   	ret    
8010608f:	90                   	nop

80106090 <sys_write>:
{
80106090:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106091:	31 c0                	xor    %eax,%eax
{
80106093:	89 e5                	mov    %esp,%ebp
80106095:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106098:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010609b:	e8 c0 fe ff ff       	call   80105f60 <argfd.constprop.0>
801060a0:	85 c0                	test   %eax,%eax
801060a2:	78 54                	js     801060f8 <sys_write+0x68>
801060a4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801060a7:	89 44 24 04          	mov    %eax,0x4(%esp)
801060ab:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801060b2:	e8 99 fb ff ff       	call   80105c50 <argint>
801060b7:	85 c0                	test   %eax,%eax
801060b9:	78 3d                	js     801060f8 <sys_write+0x68>
801060bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801060be:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801060c5:	89 44 24 08          	mov    %eax,0x8(%esp)
801060c9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801060cc:	89 44 24 04          	mov    %eax,0x4(%esp)
801060d0:	e8 cb fb ff ff       	call   80105ca0 <argptr>
801060d5:	85 c0                	test   %eax,%eax
801060d7:	78 1f                	js     801060f8 <sys_write+0x68>
  return filewrite(f, p, n);
801060d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801060dc:	89 44 24 08          	mov    %eax,0x8(%esp)
801060e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060e3:	89 44 24 04          	mov    %eax,0x4(%esp)
801060e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801060ea:	89 04 24             	mov    %eax,(%esp)
801060ed:	e8 1e af ff ff       	call   80101010 <filewrite>
}
801060f2:	c9                   	leave  
801060f3:	c3                   	ret    
801060f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801060f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801060fd:	c9                   	leave  
801060fe:	c3                   	ret    
801060ff:	90                   	nop

80106100 <sys_close>:
{
80106100:	55                   	push   %ebp
80106101:	89 e5                	mov    %esp,%ebp
80106103:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, &fd, &f) < 0)
80106106:	8d 55 f4             	lea    -0xc(%ebp),%edx
80106109:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010610c:	e8 4f fe ff ff       	call   80105f60 <argfd.constprop.0>
80106111:	85 c0                	test   %eax,%eax
80106113:	78 23                	js     80106138 <sys_close+0x38>
  myproc()->ofile[fd] = 0;
80106115:	e8 06 d9 ff ff       	call   80103a20 <myproc>
8010611a:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010611d:	31 c9                	xor    %ecx,%ecx
8010611f:	89 4c 90 28          	mov    %ecx,0x28(%eax,%edx,4)
  fileclose(f);
80106123:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106126:	89 04 24             	mov    %eax,(%esp)
80106129:	e8 02 ad ff ff       	call   80100e30 <fileclose>
  return 0;
8010612e:	31 c0                	xor    %eax,%eax
}
80106130:	c9                   	leave  
80106131:	c3                   	ret    
80106132:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106138:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010613d:	c9                   	leave  
8010613e:	c3                   	ret    
8010613f:	90                   	nop

80106140 <sys_fstat>:
{
80106140:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80106141:	31 c0                	xor    %eax,%eax
{
80106143:	89 e5                	mov    %esp,%ebp
80106145:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80106148:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010614b:	e8 10 fe ff ff       	call   80105f60 <argfd.constprop.0>
80106150:	85 c0                	test   %eax,%eax
80106152:	78 3c                	js     80106190 <sys_fstat+0x50>
80106154:	b8 14 00 00 00       	mov    $0x14,%eax
80106159:	89 44 24 08          	mov    %eax,0x8(%esp)
8010615d:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106160:	89 44 24 04          	mov    %eax,0x4(%esp)
80106164:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010616b:	e8 30 fb ff ff       	call   80105ca0 <argptr>
80106170:	85 c0                	test   %eax,%eax
80106172:	78 1c                	js     80106190 <sys_fstat+0x50>
  return filestat(f, st);
80106174:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106177:	89 44 24 04          	mov    %eax,0x4(%esp)
8010617b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010617e:	89 04 24             	mov    %eax,(%esp)
80106181:	e8 8a ad ff ff       	call   80100f10 <filestat>
}
80106186:	c9                   	leave  
80106187:	c3                   	ret    
80106188:	90                   	nop
80106189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106190:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106195:	c9                   	leave  
80106196:	c3                   	ret    
80106197:	89 f6                	mov    %esi,%esi
80106199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801061a0 <sys_link>:
{
801061a0:	55                   	push   %ebp
801061a1:	89 e5                	mov    %esp,%ebp
801061a3:	57                   	push   %edi
801061a4:	56                   	push   %esi
801061a5:	53                   	push   %ebx
801061a6:	83 ec 3c             	sub    $0x3c,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801061a9:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801061ac:	89 44 24 04          	mov    %eax,0x4(%esp)
801061b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801061b7:	e8 44 fb ff ff       	call   80105d00 <argstr>
801061bc:	85 c0                	test   %eax,%eax
801061be:	0f 88 e5 00 00 00    	js     801062a9 <sys_link+0x109>
801061c4:	8d 45 d0             	lea    -0x30(%ebp),%eax
801061c7:	89 44 24 04          	mov    %eax,0x4(%esp)
801061cb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801061d2:	e8 29 fb ff ff       	call   80105d00 <argstr>
801061d7:	85 c0                	test   %eax,%eax
801061d9:	0f 88 ca 00 00 00    	js     801062a9 <sys_link+0x109>
  begin_op();
801061df:	e8 ac ca ff ff       	call   80102c90 <begin_op>
  if((ip = namei(old)) == 0){
801061e4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801061e7:	89 04 24             	mov    %eax,(%esp)
801061ea:	e8 e1 bd ff ff       	call   80101fd0 <namei>
801061ef:	85 c0                	test   %eax,%eax
801061f1:	89 c3                	mov    %eax,%ebx
801061f3:	0f 84 ab 00 00 00    	je     801062a4 <sys_link+0x104>
  ilock(ip);
801061f9:	89 04 24             	mov    %eax,(%esp)
801061fc:	e8 ef b4 ff ff       	call   801016f0 <ilock>
  if(ip->type == T_DIR){
80106201:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106206:	0f 84 90 00 00 00    	je     8010629c <sys_link+0xfc>
  ip->nlink++;
8010620c:	66 ff 43 56          	incw   0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80106210:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80106213:	89 1c 24             	mov    %ebx,(%esp)
80106216:	e8 15 b4 ff ff       	call   80101630 <iupdate>
  iunlock(ip);
8010621b:	89 1c 24             	mov    %ebx,(%esp)
8010621e:	e8 ad b5 ff ff       	call   801017d0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80106223:	8b 45 d0             	mov    -0x30(%ebp),%eax
80106226:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010622a:	89 04 24             	mov    %eax,(%esp)
8010622d:	e8 be bd ff ff       	call   80101ff0 <nameiparent>
80106232:	85 c0                	test   %eax,%eax
80106234:	89 c6                	mov    %eax,%esi
80106236:	74 50                	je     80106288 <sys_link+0xe8>
  ilock(dp);
80106238:	89 04 24             	mov    %eax,(%esp)
8010623b:	e8 b0 b4 ff ff       	call   801016f0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80106240:	8b 03                	mov    (%ebx),%eax
80106242:	39 06                	cmp    %eax,(%esi)
80106244:	75 3a                	jne    80106280 <sys_link+0xe0>
80106246:	8b 43 04             	mov    0x4(%ebx),%eax
80106249:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010624d:	89 34 24             	mov    %esi,(%esp)
80106250:	89 44 24 08          	mov    %eax,0x8(%esp)
80106254:	e8 97 bc ff ff       	call   80101ef0 <dirlink>
80106259:	85 c0                	test   %eax,%eax
8010625b:	78 23                	js     80106280 <sys_link+0xe0>
  iunlockput(dp);
8010625d:	89 34 24             	mov    %esi,(%esp)
80106260:	e8 1b b7 ff ff       	call   80101980 <iunlockput>
  iput(ip);
80106265:	89 1c 24             	mov    %ebx,(%esp)
80106268:	e8 b3 b5 ff ff       	call   80101820 <iput>
  end_op();
8010626d:	e8 8e ca ff ff       	call   80102d00 <end_op>
}
80106272:	83 c4 3c             	add    $0x3c,%esp
  return 0;
80106275:	31 c0                	xor    %eax,%eax
}
80106277:	5b                   	pop    %ebx
80106278:	5e                   	pop    %esi
80106279:	5f                   	pop    %edi
8010627a:	5d                   	pop    %ebp
8010627b:	c3                   	ret    
8010627c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(dp);
80106280:	89 34 24             	mov    %esi,(%esp)
80106283:	e8 f8 b6 ff ff       	call   80101980 <iunlockput>
  ilock(ip);
80106288:	89 1c 24             	mov    %ebx,(%esp)
8010628b:	e8 60 b4 ff ff       	call   801016f0 <ilock>
  ip->nlink--;
80106290:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
80106294:	89 1c 24             	mov    %ebx,(%esp)
80106297:	e8 94 b3 ff ff       	call   80101630 <iupdate>
  iunlockput(ip);
8010629c:	89 1c 24             	mov    %ebx,(%esp)
8010629f:	e8 dc b6 ff ff       	call   80101980 <iunlockput>
  end_op();
801062a4:	e8 57 ca ff ff       	call   80102d00 <end_op>
}
801062a9:	83 c4 3c             	add    $0x3c,%esp
  return -1;
801062ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801062b1:	5b                   	pop    %ebx
801062b2:	5e                   	pop    %esi
801062b3:	5f                   	pop    %edi
801062b4:	5d                   	pop    %ebp
801062b5:	c3                   	ret    
801062b6:	8d 76 00             	lea    0x0(%esi),%esi
801062b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801062c0 <sys_unlink>:
{
801062c0:	55                   	push   %ebp
801062c1:	89 e5                	mov    %esp,%ebp
801062c3:	57                   	push   %edi
801062c4:	56                   	push   %esi
801062c5:	53                   	push   %ebx
801062c6:	83 ec 5c             	sub    $0x5c,%esp
  if(argstr(0, &path) < 0)
801062c9:	8d 45 c0             	lea    -0x40(%ebp),%eax
801062cc:	89 44 24 04          	mov    %eax,0x4(%esp)
801062d0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801062d7:	e8 24 fa ff ff       	call   80105d00 <argstr>
801062dc:	85 c0                	test   %eax,%eax
801062de:	0f 88 68 01 00 00    	js     8010644c <sys_unlink+0x18c>
  begin_op();
801062e4:	e8 a7 c9 ff ff       	call   80102c90 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801062e9:	8b 45 c0             	mov    -0x40(%ebp),%eax
801062ec:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801062ef:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801062f3:	89 04 24             	mov    %eax,(%esp)
801062f6:	e8 f5 bc ff ff       	call   80101ff0 <nameiparent>
801062fb:	85 c0                	test   %eax,%eax
801062fd:	89 c6                	mov    %eax,%esi
801062ff:	0f 84 42 01 00 00    	je     80106447 <sys_unlink+0x187>
  ilock(dp);
80106305:	89 04 24             	mov    %eax,(%esp)
80106308:	e8 e3 b3 ff ff       	call   801016f0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010630d:	b8 98 8c 10 80       	mov    $0x80108c98,%eax
80106312:	89 44 24 04          	mov    %eax,0x4(%esp)
80106316:	89 1c 24             	mov    %ebx,(%esp)
80106319:	e8 22 b9 ff ff       	call   80101c40 <namecmp>
8010631e:	85 c0                	test   %eax,%eax
80106320:	0f 84 19 01 00 00    	je     8010643f <sys_unlink+0x17f>
80106326:	b8 97 8c 10 80       	mov    $0x80108c97,%eax
8010632b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010632f:	89 1c 24             	mov    %ebx,(%esp)
80106332:	e8 09 b9 ff ff       	call   80101c40 <namecmp>
80106337:	85 c0                	test   %eax,%eax
80106339:	0f 84 00 01 00 00    	je     8010643f <sys_unlink+0x17f>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010633f:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80106342:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80106346:	89 44 24 08          	mov    %eax,0x8(%esp)
8010634a:	89 34 24             	mov    %esi,(%esp)
8010634d:	e8 1e b9 ff ff       	call   80101c70 <dirlookup>
80106352:	85 c0                	test   %eax,%eax
80106354:	89 c3                	mov    %eax,%ebx
80106356:	0f 84 e3 00 00 00    	je     8010643f <sys_unlink+0x17f>
  ilock(ip);
8010635c:	89 04 24             	mov    %eax,(%esp)
8010635f:	e8 8c b3 ff ff       	call   801016f0 <ilock>
  if(ip->nlink < 1)
80106364:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80106369:	0f 8e 0e 01 00 00    	jle    8010647d <sys_unlink+0x1bd>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010636f:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106374:	8d 7d d8             	lea    -0x28(%ebp),%edi
80106377:	74 77                	je     801063f0 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
80106379:	31 d2                	xor    %edx,%edx
8010637b:	b8 10 00 00 00       	mov    $0x10,%eax
80106380:	89 54 24 04          	mov    %edx,0x4(%esp)
80106384:	89 44 24 08          	mov    %eax,0x8(%esp)
80106388:	89 3c 24             	mov    %edi,(%esp)
8010638b:	e8 d0 f5 ff ff       	call   80105960 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80106390:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80106393:	b9 10 00 00 00       	mov    $0x10,%ecx
80106398:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
8010639c:	89 7c 24 04          	mov    %edi,0x4(%esp)
801063a0:	89 34 24             	mov    %esi,(%esp)
801063a3:	89 44 24 08          	mov    %eax,0x8(%esp)
801063a7:	e8 44 b7 ff ff       	call   80101af0 <writei>
801063ac:	83 f8 10             	cmp    $0x10,%eax
801063af:	0f 85 d4 00 00 00    	jne    80106489 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
801063b5:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801063ba:	0f 84 a0 00 00 00    	je     80106460 <sys_unlink+0x1a0>
  iunlockput(dp);
801063c0:	89 34 24             	mov    %esi,(%esp)
801063c3:	e8 b8 b5 ff ff       	call   80101980 <iunlockput>
  ip->nlink--;
801063c8:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
801063cc:	89 1c 24             	mov    %ebx,(%esp)
801063cf:	e8 5c b2 ff ff       	call   80101630 <iupdate>
  iunlockput(ip);
801063d4:	89 1c 24             	mov    %ebx,(%esp)
801063d7:	e8 a4 b5 ff ff       	call   80101980 <iunlockput>
  end_op();
801063dc:	e8 1f c9 ff ff       	call   80102d00 <end_op>
}
801063e1:	83 c4 5c             	add    $0x5c,%esp
  return 0;
801063e4:	31 c0                	xor    %eax,%eax
}
801063e6:	5b                   	pop    %ebx
801063e7:	5e                   	pop    %esi
801063e8:	5f                   	pop    %edi
801063e9:	5d                   	pop    %ebp
801063ea:	c3                   	ret    
801063eb:	90                   	nop
801063ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801063f0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801063f4:	76 83                	jbe    80106379 <sys_unlink+0xb9>
801063f6:	ba 20 00 00 00       	mov    $0x20,%edx
801063fb:	eb 0f                	jmp    8010640c <sys_unlink+0x14c>
801063fd:	8d 76 00             	lea    0x0(%esi),%esi
80106400:	83 c2 10             	add    $0x10,%edx
80106403:	3b 53 58             	cmp    0x58(%ebx),%edx
80106406:	0f 83 6d ff ff ff    	jae    80106379 <sys_unlink+0xb9>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010640c:	b8 10 00 00 00       	mov    $0x10,%eax
80106411:	89 54 24 08          	mov    %edx,0x8(%esp)
80106415:	89 44 24 0c          	mov    %eax,0xc(%esp)
80106419:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010641d:	89 1c 24             	mov    %ebx,(%esp)
80106420:	89 55 b4             	mov    %edx,-0x4c(%ebp)
80106423:	e8 a8 b5 ff ff       	call   801019d0 <readi>
80106428:	8b 55 b4             	mov    -0x4c(%ebp),%edx
8010642b:	83 f8 10             	cmp    $0x10,%eax
8010642e:	75 41                	jne    80106471 <sys_unlink+0x1b1>
    if(de.inum != 0)
80106430:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80106435:	74 c9                	je     80106400 <sys_unlink+0x140>
    iunlockput(ip);
80106437:	89 1c 24             	mov    %ebx,(%esp)
8010643a:	e8 41 b5 ff ff       	call   80101980 <iunlockput>
  iunlockput(dp);
8010643f:	89 34 24             	mov    %esi,(%esp)
80106442:	e8 39 b5 ff ff       	call   80101980 <iunlockput>
  end_op();
80106447:	e8 b4 c8 ff ff       	call   80102d00 <end_op>
}
8010644c:	83 c4 5c             	add    $0x5c,%esp
  return -1;
8010644f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106454:	5b                   	pop    %ebx
80106455:	5e                   	pop    %esi
80106456:	5f                   	pop    %edi
80106457:	5d                   	pop    %ebp
80106458:	c3                   	ret    
80106459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80106460:	66 ff 4e 56          	decw   0x56(%esi)
    iupdate(dp);
80106464:	89 34 24             	mov    %esi,(%esp)
80106467:	e8 c4 b1 ff ff       	call   80101630 <iupdate>
8010646c:	e9 4f ff ff ff       	jmp    801063c0 <sys_unlink+0x100>
      panic("isdirempty: readi");
80106471:	c7 04 24 bc 8c 10 80 	movl   $0x80108cbc,(%esp)
80106478:	e8 f3 9e ff ff       	call   80100370 <panic>
    panic("unlink: nlink < 1");
8010647d:	c7 04 24 aa 8c 10 80 	movl   $0x80108caa,(%esp)
80106484:	e8 e7 9e ff ff       	call   80100370 <panic>
    panic("unlink: writei");
80106489:	c7 04 24 ce 8c 10 80 	movl   $0x80108cce,(%esp)
80106490:	e8 db 9e ff ff       	call   80100370 <panic>
80106495:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801064a0 <sys_open>:

int
sys_open(void)
{
801064a0:	55                   	push   %ebp
801064a1:	89 e5                	mov    %esp,%ebp
801064a3:	57                   	push   %edi
801064a4:	56                   	push   %esi
801064a5:	53                   	push   %ebx
801064a6:	83 ec 2c             	sub    $0x2c,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801064a9:	8d 45 e0             	lea    -0x20(%ebp),%eax
801064ac:	89 44 24 04          	mov    %eax,0x4(%esp)
801064b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801064b7:	e8 44 f8 ff ff       	call   80105d00 <argstr>
801064bc:	85 c0                	test   %eax,%eax
801064be:	0f 88 e9 00 00 00    	js     801065ad <sys_open+0x10d>
801064c4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801064c7:	89 44 24 04          	mov    %eax,0x4(%esp)
801064cb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801064d2:	e8 79 f7 ff ff       	call   80105c50 <argint>
801064d7:	85 c0                	test   %eax,%eax
801064d9:	0f 88 ce 00 00 00    	js     801065ad <sys_open+0x10d>
    return -1;

  begin_op();
801064df:	e8 ac c7 ff ff       	call   80102c90 <begin_op>

  if(omode & O_CREATE){
801064e4:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801064e8:	0f 85 9a 00 00 00    	jne    80106588 <sys_open+0xe8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801064ee:	8b 45 e0             	mov    -0x20(%ebp),%eax
801064f1:	89 04 24             	mov    %eax,(%esp)
801064f4:	e8 d7 ba ff ff       	call   80101fd0 <namei>
801064f9:	85 c0                	test   %eax,%eax
801064fb:	89 c6                	mov    %eax,%esi
801064fd:	0f 84 a5 00 00 00    	je     801065a8 <sys_open+0x108>
      end_op();
      return -1;
    }
    ilock(ip);
80106503:	89 04 24             	mov    %eax,(%esp)
80106506:	e8 e5 b1 ff ff       	call   801016f0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
8010650b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80106510:	0f 84 a2 00 00 00    	je     801065b8 <sys_open+0x118>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80106516:	e8 55 a8 ff ff       	call   80100d70 <filealloc>
8010651b:	85 c0                	test   %eax,%eax
8010651d:	89 c7                	mov    %eax,%edi
8010651f:	0f 84 9e 00 00 00    	je     801065c3 <sys_open+0x123>
  struct proc *curproc = myproc();
80106525:	e8 f6 d4 ff ff       	call   80103a20 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010652a:	31 db                	xor    %ebx,%ebx
8010652c:	eb 0c                	jmp    8010653a <sys_open+0x9a>
8010652e:	66 90                	xchg   %ax,%ax
80106530:	43                   	inc    %ebx
80106531:	83 fb 10             	cmp    $0x10,%ebx
80106534:	0f 84 96 00 00 00    	je     801065d0 <sys_open+0x130>
    if(curproc->ofile[fd] == 0){
8010653a:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
8010653e:	85 d2                	test   %edx,%edx
80106540:	75 ee                	jne    80106530 <sys_open+0x90>
      curproc->ofile[fd] = f;
80106542:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80106546:	89 34 24             	mov    %esi,(%esp)
80106549:	e8 82 b2 ff ff       	call   801017d0 <iunlock>
  end_op();
8010654e:	e8 ad c7 ff ff       	call   80102d00 <end_op>

  f->type = FD_INODE;
80106553:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80106559:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->ip = ip;
8010655c:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
8010655f:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80106566:	89 d0                	mov    %edx,%eax
80106568:	f7 d0                	not    %eax
8010656a:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010656d:	f6 c2 03             	test   $0x3,%dl
  f->readable = !(omode & O_WRONLY);
80106570:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106573:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80106577:	83 c4 2c             	add    $0x2c,%esp
8010657a:	89 d8                	mov    %ebx,%eax
8010657c:	5b                   	pop    %ebx
8010657d:	5e                   	pop    %esi
8010657e:	5f                   	pop    %edi
8010657f:	5d                   	pop    %ebp
80106580:	c3                   	ret    
80106581:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80106588:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010658b:	31 c9                	xor    %ecx,%ecx
8010658d:	ba 02 00 00 00       	mov    $0x2,%edx
80106592:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106599:	e8 12 f8 ff ff       	call   80105db0 <create>
    if(ip == 0){
8010659e:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
801065a0:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801065a2:	0f 85 6e ff ff ff    	jne    80106516 <sys_open+0x76>
    end_op();
801065a8:	e8 53 c7 ff ff       	call   80102d00 <end_op>
    return -1;
801065ad:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801065b2:	eb c3                	jmp    80106577 <sys_open+0xd7>
801065b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
801065b8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801065bb:	85 c9                	test   %ecx,%ecx
801065bd:	0f 84 53 ff ff ff    	je     80106516 <sys_open+0x76>
    iunlockput(ip);
801065c3:	89 34 24             	mov    %esi,(%esp)
801065c6:	e8 b5 b3 ff ff       	call   80101980 <iunlockput>
801065cb:	eb db                	jmp    801065a8 <sys_open+0x108>
801065cd:	8d 76 00             	lea    0x0(%esi),%esi
      fileclose(f);
801065d0:	89 3c 24             	mov    %edi,(%esp)
801065d3:	e8 58 a8 ff ff       	call   80100e30 <fileclose>
801065d8:	eb e9                	jmp    801065c3 <sys_open+0x123>
801065da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801065e0 <sys_mkdir>:

int
sys_mkdir(void)
{
801065e0:	55                   	push   %ebp
801065e1:	89 e5                	mov    %esp,%ebp
801065e3:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
801065e6:	e8 a5 c6 ff ff       	call   80102c90 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801065eb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801065ee:	89 44 24 04          	mov    %eax,0x4(%esp)
801065f2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801065f9:	e8 02 f7 ff ff       	call   80105d00 <argstr>
801065fe:	85 c0                	test   %eax,%eax
80106600:	78 2e                	js     80106630 <sys_mkdir+0x50>
80106602:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106605:	31 c9                	xor    %ecx,%ecx
80106607:	ba 01 00 00 00       	mov    $0x1,%edx
8010660c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106613:	e8 98 f7 ff ff       	call   80105db0 <create>
80106618:	85 c0                	test   %eax,%eax
8010661a:	74 14                	je     80106630 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010661c:	89 04 24             	mov    %eax,(%esp)
8010661f:	e8 5c b3 ff ff       	call   80101980 <iunlockput>
  end_op();
80106624:	e8 d7 c6 ff ff       	call   80102d00 <end_op>
  return 0;
80106629:	31 c0                	xor    %eax,%eax
}
8010662b:	c9                   	leave  
8010662c:	c3                   	ret    
8010662d:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
80106630:	e8 cb c6 ff ff       	call   80102d00 <end_op>
    return -1;
80106635:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010663a:	c9                   	leave  
8010663b:	c3                   	ret    
8010663c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106640 <sys_mknod>:

int
sys_mknod(void)
{
80106640:	55                   	push   %ebp
80106641:	89 e5                	mov    %esp,%ebp
80106643:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80106646:	e8 45 c6 ff ff       	call   80102c90 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010664b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010664e:	89 44 24 04          	mov    %eax,0x4(%esp)
80106652:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106659:	e8 a2 f6 ff ff       	call   80105d00 <argstr>
8010665e:	85 c0                	test   %eax,%eax
80106660:	78 5e                	js     801066c0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80106662:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106665:	89 44 24 04          	mov    %eax,0x4(%esp)
80106669:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106670:	e8 db f5 ff ff       	call   80105c50 <argint>
  if((argstr(0, &path)) < 0 ||
80106675:	85 c0                	test   %eax,%eax
80106677:	78 47                	js     801066c0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80106679:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010667c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106680:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106687:	e8 c4 f5 ff ff       	call   80105c50 <argint>
     argint(1, &major) < 0 ||
8010668c:	85 c0                	test   %eax,%eax
8010668e:	78 30                	js     801066c0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80106690:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
80106694:	ba 03 00 00 00       	mov    $0x3,%edx
     (ip = create(path, T_DEV, major, minor)) == 0){
80106699:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
8010669d:	89 04 24             	mov    %eax,(%esp)
     argint(2, &minor) < 0 ||
801066a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801066a3:	e8 08 f7 ff ff       	call   80105db0 <create>
801066a8:	85 c0                	test   %eax,%eax
801066aa:	74 14                	je     801066c0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801066ac:	89 04 24             	mov    %eax,(%esp)
801066af:	e8 cc b2 ff ff       	call   80101980 <iunlockput>
  end_op();
801066b4:	e8 47 c6 ff ff       	call   80102d00 <end_op>
  return 0;
801066b9:	31 c0                	xor    %eax,%eax
}
801066bb:	c9                   	leave  
801066bc:	c3                   	ret    
801066bd:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
801066c0:	e8 3b c6 ff ff       	call   80102d00 <end_op>
    return -1;
801066c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801066ca:	c9                   	leave  
801066cb:	c3                   	ret    
801066cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801066d0 <sys_chdir>:

int
sys_chdir(void)
{
801066d0:	55                   	push   %ebp
801066d1:	89 e5                	mov    %esp,%ebp
801066d3:	56                   	push   %esi
801066d4:	53                   	push   %ebx
801066d5:	83 ec 20             	sub    $0x20,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801066d8:	e8 43 d3 ff ff       	call   80103a20 <myproc>
801066dd:	89 c6                	mov    %eax,%esi
  
  begin_op();
801066df:	e8 ac c5 ff ff       	call   80102c90 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801066e4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801066e7:	89 44 24 04          	mov    %eax,0x4(%esp)
801066eb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801066f2:	e8 09 f6 ff ff       	call   80105d00 <argstr>
801066f7:	85 c0                	test   %eax,%eax
801066f9:	78 4a                	js     80106745 <sys_chdir+0x75>
801066fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066fe:	89 04 24             	mov    %eax,(%esp)
80106701:	e8 ca b8 ff ff       	call   80101fd0 <namei>
80106706:	85 c0                	test   %eax,%eax
80106708:	89 c3                	mov    %eax,%ebx
8010670a:	74 39                	je     80106745 <sys_chdir+0x75>
    end_op();
    return -1;
  }
  ilock(ip);
8010670c:	89 04 24             	mov    %eax,(%esp)
8010670f:	e8 dc af ff ff       	call   801016f0 <ilock>
  if(ip->type != T_DIR){
80106714:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
    iunlockput(ip);
80106719:	89 1c 24             	mov    %ebx,(%esp)
  if(ip->type != T_DIR){
8010671c:	75 22                	jne    80106740 <sys_chdir+0x70>
    end_op();
    return -1;
  }
  iunlock(ip);
8010671e:	e8 ad b0 ff ff       	call   801017d0 <iunlock>
  iput(curproc->cwd);
80106723:	8b 46 68             	mov    0x68(%esi),%eax
80106726:	89 04 24             	mov    %eax,(%esp)
80106729:	e8 f2 b0 ff ff       	call   80101820 <iput>
  end_op();
8010672e:	e8 cd c5 ff ff       	call   80102d00 <end_op>
  curproc->cwd = ip;
  return 0;
80106733:	31 c0                	xor    %eax,%eax
  curproc->cwd = ip;
80106735:	89 5e 68             	mov    %ebx,0x68(%esi)
}
80106738:	83 c4 20             	add    $0x20,%esp
8010673b:	5b                   	pop    %ebx
8010673c:	5e                   	pop    %esi
8010673d:	5d                   	pop    %ebp
8010673e:	c3                   	ret    
8010673f:	90                   	nop
    iunlockput(ip);
80106740:	e8 3b b2 ff ff       	call   80101980 <iunlockput>
    end_op();
80106745:	e8 b6 c5 ff ff       	call   80102d00 <end_op>
    return -1;
8010674a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010674f:	eb e7                	jmp    80106738 <sys_chdir+0x68>
80106751:	eb 0d                	jmp    80106760 <sys_exec>
80106753:	90                   	nop
80106754:	90                   	nop
80106755:	90                   	nop
80106756:	90                   	nop
80106757:	90                   	nop
80106758:	90                   	nop
80106759:	90                   	nop
8010675a:	90                   	nop
8010675b:	90                   	nop
8010675c:	90                   	nop
8010675d:	90                   	nop
8010675e:	90                   	nop
8010675f:	90                   	nop

80106760 <sys_exec>:

int
sys_exec(void)
{
80106760:	55                   	push   %ebp
80106761:	89 e5                	mov    %esp,%ebp
80106763:	57                   	push   %edi
80106764:	56                   	push   %esi
80106765:	53                   	push   %ebx
80106766:	81 ec ac 00 00 00    	sub    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
8010676c:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80106772:	89 44 24 04          	mov    %eax,0x4(%esp)
80106776:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010677d:	e8 7e f5 ff ff       	call   80105d00 <argstr>
80106782:	85 c0                	test   %eax,%eax
80106784:	0f 88 8e 00 00 00    	js     80106818 <sys_exec+0xb8>
8010678a:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80106790:	89 44 24 04          	mov    %eax,0x4(%esp)
80106794:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010679b:	e8 b0 f4 ff ff       	call   80105c50 <argint>
801067a0:	85 c0                	test   %eax,%eax
801067a2:	78 74                	js     80106818 <sys_exec+0xb8>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801067a4:	ba 80 00 00 00       	mov    $0x80,%edx
801067a9:	31 c9                	xor    %ecx,%ecx
801067ab:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
801067b1:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801067b3:	89 54 24 08          	mov    %edx,0x8(%esp)
801067b7:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801067bd:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801067c1:	89 04 24             	mov    %eax,(%esp)
801067c4:	e8 97 f1 ff ff       	call   80105960 <memset>
801067c9:	eb 2e                	jmp    801067f9 <sys_exec+0x99>
801067cb:	90                   	nop
801067cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
801067d0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801067d6:	85 c0                	test   %eax,%eax
801067d8:	74 56                	je     80106830 <sys_exec+0xd0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801067da:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
801067e0:	8d 14 31             	lea    (%ecx,%esi,1),%edx
801067e3:	89 54 24 04          	mov    %edx,0x4(%esp)
801067e7:	89 04 24             	mov    %eax,(%esp)
801067ea:	e8 01 f4 ff ff       	call   80105bf0 <fetchstr>
801067ef:	85 c0                	test   %eax,%eax
801067f1:	78 25                	js     80106818 <sys_exec+0xb8>
  for(i=0;; i++){
801067f3:	43                   	inc    %ebx
    if(i >= NELEM(argv))
801067f4:	83 fb 20             	cmp    $0x20,%ebx
801067f7:	74 1f                	je     80106818 <sys_exec+0xb8>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801067f9:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801067ff:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80106806:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010680a:	01 f0                	add    %esi,%eax
8010680c:	89 04 24             	mov    %eax,(%esp)
8010680f:	e8 9c f3 ff ff       	call   80105bb0 <fetchint>
80106814:	85 c0                	test   %eax,%eax
80106816:	79 b8                	jns    801067d0 <sys_exec+0x70>
      return -1;
  }
  return exec(path, argv);
}
80106818:	81 c4 ac 00 00 00    	add    $0xac,%esp
    return -1;
8010681e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106823:	5b                   	pop    %ebx
80106824:	5e                   	pop    %esi
80106825:	5f                   	pop    %edi
80106826:	5d                   	pop    %ebp
80106827:	c3                   	ret    
80106828:	90                   	nop
80106829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80106830:	31 c0                	xor    %eax,%eax
80106832:	89 84 9d 68 ff ff ff 	mov    %eax,-0x98(%ebp,%ebx,4)
  return exec(path, argv);
80106839:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010683f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106843:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
80106849:	89 04 24             	mov    %eax,(%esp)
8010684c:	e8 7f a1 ff ff       	call   801009d0 <exec>
}
80106851:	81 c4 ac 00 00 00    	add    $0xac,%esp
80106857:	5b                   	pop    %ebx
80106858:	5e                   	pop    %esi
80106859:	5f                   	pop    %edi
8010685a:	5d                   	pop    %ebp
8010685b:	c3                   	ret    
8010685c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106860 <sys_pipe>:

int
sys_pipe(void)
{
80106860:	55                   	push   %ebp
80106861:	89 e5                	mov    %esp,%ebp
80106863:	57                   	push   %edi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106864:	bf 08 00 00 00       	mov    $0x8,%edi
{
80106869:	56                   	push   %esi
8010686a:	53                   	push   %ebx
8010686b:	83 ec 2c             	sub    $0x2c,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010686e:	8d 45 dc             	lea    -0x24(%ebp),%eax
80106871:	89 7c 24 08          	mov    %edi,0x8(%esp)
80106875:	89 44 24 04          	mov    %eax,0x4(%esp)
80106879:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106880:	e8 1b f4 ff ff       	call   80105ca0 <argptr>
80106885:	85 c0                	test   %eax,%eax
80106887:	0f 88 a9 00 00 00    	js     80106936 <sys_pipe+0xd6>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010688d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106890:	89 44 24 04          	mov    %eax,0x4(%esp)
80106894:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106897:	89 04 24             	mov    %eax,(%esp)
8010689a:	e8 21 cb ff ff       	call   801033c0 <pipealloc>
8010689f:	85 c0                	test   %eax,%eax
801068a1:	0f 88 8f 00 00 00    	js     80106936 <sys_pipe+0xd6>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801068a7:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801068aa:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801068ac:	e8 6f d1 ff ff       	call   80103a20 <myproc>
801068b1:	eb 0b                	jmp    801068be <sys_pipe+0x5e>
801068b3:	90                   	nop
801068b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
801068b8:	43                   	inc    %ebx
801068b9:	83 fb 10             	cmp    $0x10,%ebx
801068bc:	74 62                	je     80106920 <sys_pipe+0xc0>
    if(curproc->ofile[fd] == 0){
801068be:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801068c2:	85 f6                	test   %esi,%esi
801068c4:	75 f2                	jne    801068b8 <sys_pipe+0x58>
      curproc->ofile[fd] = f;
801068c6:	8d 73 08             	lea    0x8(%ebx),%esi
801068c9:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801068cd:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801068d0:	e8 4b d1 ff ff       	call   80103a20 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801068d5:	31 d2                	xor    %edx,%edx
801068d7:	eb 0d                	jmp    801068e6 <sys_pipe+0x86>
801068d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068e0:	42                   	inc    %edx
801068e1:	83 fa 10             	cmp    $0x10,%edx
801068e4:	74 2a                	je     80106910 <sys_pipe+0xb0>
    if(curproc->ofile[fd] == 0){
801068e6:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801068ea:	85 c9                	test   %ecx,%ecx
801068ec:	75 f2                	jne    801068e0 <sys_pipe+0x80>
      curproc->ofile[fd] = f;
801068ee:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
801068f2:	8b 45 dc             	mov    -0x24(%ebp),%eax
801068f5:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801068f7:	8b 45 dc             	mov    -0x24(%ebp),%eax
801068fa:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801068fd:	31 c0                	xor    %eax,%eax
}
801068ff:	83 c4 2c             	add    $0x2c,%esp
80106902:	5b                   	pop    %ebx
80106903:	5e                   	pop    %esi
80106904:	5f                   	pop    %edi
80106905:	5d                   	pop    %ebp
80106906:	c3                   	ret    
80106907:	89 f6                	mov    %esi,%esi
80106909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      myproc()->ofile[fd0] = 0;
80106910:	e8 0b d1 ff ff       	call   80103a20 <myproc>
80106915:	31 d2                	xor    %edx,%edx
80106917:	89 54 b0 08          	mov    %edx,0x8(%eax,%esi,4)
8010691b:	90                   	nop
8010691c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fileclose(rf);
80106920:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106923:	89 04 24             	mov    %eax,(%esp)
80106926:	e8 05 a5 ff ff       	call   80100e30 <fileclose>
    fileclose(wf);
8010692b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010692e:	89 04 24             	mov    %eax,(%esp)
80106931:	e8 fa a4 ff ff       	call   80100e30 <fileclose>
    return -1;
80106936:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010693b:	eb c2                	jmp    801068ff <sys_pipe+0x9f>
8010693d:	66 90                	xchg   %ax,%ax
8010693f:	90                   	nop

80106940 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106940:	55                   	push   %ebp
80106941:	89 e5                	mov    %esp,%ebp
  return fork();
}
80106943:	5d                   	pop    %ebp
  return fork();
80106944:	e9 87 d3 ff ff       	jmp    80103cd0 <fork>
80106949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106950 <sys_exit>:

int
sys_exit(void)
{
80106950:	55                   	push   %ebp
80106951:	89 e5                	mov    %esp,%ebp
80106953:	83 ec 18             	sub    $0x18,%esp
  exit(0);
80106956:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010695d:	e8 de d7 ff ff       	call   80104140 <exit>
  return 0;  // not reached
}
80106962:	31 c0                	xor    %eax,%eax
80106964:	c9                   	leave  
80106965:	c3                   	ret    
80106966:	8d 76 00             	lea    0x0(%esi),%esi
80106969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106970 <sys_wait>:

int
sys_wait(void)
{
80106970:	55                   	push   %ebp
80106971:	89 e5                	mov    %esp,%ebp
80106973:	83 ec 18             	sub    $0x18,%esp
  return wait(0);
80106976:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010697d:	e8 9e da ff ff       	call   80104420 <wait>
}
80106982:	c9                   	leave  
80106983:	c3                   	ret    
80106984:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010698a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106990 <sys_kill>:

int
sys_kill(void)
{
80106990:	55                   	push   %ebp
80106991:	89 e5                	mov    %esp,%ebp
80106993:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106996:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106999:	89 44 24 04          	mov    %eax,0x4(%esp)
8010699d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801069a4:	e8 a7 f2 ff ff       	call   80105c50 <argint>
801069a9:	85 c0                	test   %eax,%eax
801069ab:	78 13                	js     801069c0 <sys_kill+0x30>
    return -1;
  return kill(pid);
801069ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069b0:	89 04 24             	mov    %eax,(%esp)
801069b3:	e8 98 db ff ff       	call   80104550 <kill>
}
801069b8:	c9                   	leave  
801069b9:	c3                   	ret    
801069ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801069c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801069c5:	c9                   	leave  
801069c6:	c3                   	ret    
801069c7:	89 f6                	mov    %esi,%esi
801069c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801069d0 <sys_getpid>:

int
sys_getpid(void)
{
801069d0:	55                   	push   %ebp
801069d1:	89 e5                	mov    %esp,%ebp
801069d3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801069d6:	e8 45 d0 ff ff       	call   80103a20 <myproc>
801069db:	8b 40 10             	mov    0x10(%eax),%eax
}
801069de:	c9                   	leave  
801069df:	c3                   	ret    

801069e0 <sys_sbrk>:

int
sys_sbrk(void)
{
801069e0:	55                   	push   %ebp
801069e1:	89 e5                	mov    %esp,%ebp
801069e3:	53                   	push   %ebx
801069e4:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801069e7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801069ea:	89 44 24 04          	mov    %eax,0x4(%esp)
801069ee:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801069f5:	e8 56 f2 ff ff       	call   80105c50 <argint>
801069fa:	85 c0                	test   %eax,%eax
801069fc:	78 22                	js     80106a20 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801069fe:	e8 1d d0 ff ff       	call   80103a20 <myproc>
80106a03:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106a05:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a08:	89 04 24             	mov    %eax,(%esp)
80106a0b:	e8 40 d2 ff ff       	call   80103c50 <growproc>
80106a10:	85 c0                	test   %eax,%eax
80106a12:	78 0c                	js     80106a20 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106a14:	83 c4 24             	add    $0x24,%esp
80106a17:	89 d8                	mov    %ebx,%eax
80106a19:	5b                   	pop    %ebx
80106a1a:	5d                   	pop    %ebp
80106a1b:	c3                   	ret    
80106a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106a20:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106a25:	eb ed                	jmp    80106a14 <sys_sbrk+0x34>
80106a27:	89 f6                	mov    %esi,%esi
80106a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106a30 <sys_sleep>:

int
sys_sleep(void)
{
80106a30:	55                   	push   %ebp
80106a31:	89 e5                	mov    %esp,%ebp
80106a33:	53                   	push   %ebx
80106a34:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106a37:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106a3a:	89 44 24 04          	mov    %eax,0x4(%esp)
80106a3e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106a45:	e8 06 f2 ff ff       	call   80105c50 <argint>
80106a4a:	85 c0                	test   %eax,%eax
80106a4c:	78 7e                	js     80106acc <sys_sleep+0x9c>
    return -1;
  acquire(&tickslock);
80106a4e:	c7 04 24 c0 66 11 80 	movl   $0x801166c0,(%esp)
80106a55:	e8 16 ee ff ff       	call   80105870 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106a5a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  ticks0 = ticks;
80106a5d:	8b 1d 00 6f 11 80    	mov    0x80116f00,%ebx
  while(ticks - ticks0 < n){
80106a63:	85 c9                	test   %ecx,%ecx
80106a65:	75 2a                	jne    80106a91 <sys_sleep+0x61>
80106a67:	eb 4f                	jmp    80106ab8 <sys_sleep+0x88>
80106a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106a70:	b8 c0 66 11 80       	mov    $0x801166c0,%eax
80106a75:	89 44 24 04          	mov    %eax,0x4(%esp)
80106a79:	c7 04 24 00 6f 11 80 	movl   $0x80116f00,(%esp)
80106a80:	e8 ab d8 ff ff       	call   80104330 <sleep>
  while(ticks - ticks0 < n){
80106a85:	a1 00 6f 11 80       	mov    0x80116f00,%eax
80106a8a:	29 d8                	sub    %ebx,%eax
80106a8c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80106a8f:	73 27                	jae    80106ab8 <sys_sleep+0x88>
    if(myproc()->killed){
80106a91:	e8 8a cf ff ff       	call   80103a20 <myproc>
80106a96:	8b 50 24             	mov    0x24(%eax),%edx
80106a99:	85 d2                	test   %edx,%edx
80106a9b:	74 d3                	je     80106a70 <sys_sleep+0x40>
      release(&tickslock);
80106a9d:	c7 04 24 c0 66 11 80 	movl   $0x801166c0,(%esp)
80106aa4:	e8 67 ee ff ff       	call   80105910 <release>
  }
  release(&tickslock);
  return 0;
}
80106aa9:	83 c4 24             	add    $0x24,%esp
      return -1;
80106aac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106ab1:	5b                   	pop    %ebx
80106ab2:	5d                   	pop    %ebp
80106ab3:	c3                   	ret    
80106ab4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&tickslock);
80106ab8:	c7 04 24 c0 66 11 80 	movl   $0x801166c0,(%esp)
80106abf:	e8 4c ee ff ff       	call   80105910 <release>
  return 0;
80106ac4:	31 c0                	xor    %eax,%eax
}
80106ac6:	83 c4 24             	add    $0x24,%esp
80106ac9:	5b                   	pop    %ebx
80106aca:	5d                   	pop    %ebp
80106acb:	c3                   	ret    
    return -1;
80106acc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106ad1:	eb f3                	jmp    80106ac6 <sys_sleep+0x96>
80106ad3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ae0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106ae0:	55                   	push   %ebp
80106ae1:	89 e5                	mov    %esp,%ebp
80106ae3:	53                   	push   %ebx
80106ae4:	83 ec 14             	sub    $0x14,%esp
  uint xticks;

  acquire(&tickslock);
80106ae7:	c7 04 24 c0 66 11 80 	movl   $0x801166c0,(%esp)
80106aee:	e8 7d ed ff ff       	call   80105870 <acquire>
  xticks = ticks;
80106af3:	8b 1d 00 6f 11 80    	mov    0x80116f00,%ebx
  release(&tickslock);
80106af9:	c7 04 24 c0 66 11 80 	movl   $0x801166c0,(%esp)
80106b00:	e8 0b ee ff ff       	call   80105910 <release>
  return xticks;
}
80106b05:	83 c4 14             	add    $0x14,%esp
80106b08:	89 d8                	mov    %ebx,%eax
80106b0a:	5b                   	pop    %ebx
80106b0b:	5d                   	pop    %ebp
80106b0c:	c3                   	ret    
80106b0d:	8d 76 00             	lea    0x0(%esi),%esi

80106b10 <sys_detach>:

int
sys_detach(void){
80106b10:	55                   	push   %ebp
80106b11:	89 e5                	mov    %esp,%ebp
80106b13:	83 ec 28             	sub    $0x28,%esp
    int pid;
  if(argint(0, &pid) < 0)
80106b16:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106b19:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b1d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106b24:	e8 27 f1 ff ff       	call   80105c50 <argint>
80106b29:	85 c0                	test   %eax,%eax
80106b2b:	78 13                	js     80106b40 <sys_detach+0x30>
    return -1;
  return detach(pid);
80106b2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b30:	89 04 24             	mov    %eax,(%esp)
80106b33:	e8 a8 db ff ff       	call   801046e0 <detach>
}
80106b38:	c9                   	leave  
80106b39:	c3                   	ret    
80106b3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106b40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106b45:	c9                   	leave  
80106b46:	c3                   	ret    
80106b47:	89 f6                	mov    %esi,%esi
80106b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b50 <sys_priority>:
//TODO -need to understand how to call this sys_call
int
sys_priority(void){
80106b50:	55                   	push   %ebp
80106b51:	89 e5                	mov    %esp,%ebp
80106b53:	83 ec 28             	sub    $0x28,%esp
  int pid;
  if(argint(0, &pid) < 0)
80106b56:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106b59:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b5d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106b64:	e8 e7 f0 ff ff       	call   80105c50 <argint>
80106b69:	85 c0                	test   %eax,%eax
80106b6b:	78 13                	js     80106b80 <sys_priority+0x30>
    return -1;
  priority(pid);
80106b6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b70:	89 04 24             	mov    %eax,(%esp)
80106b73:	e8 f8 db ff ff       	call   80104770 <priority>
  return 0;
80106b78:	31 c0                	xor    %eax,%eax
}
80106b7a:	c9                   	leave  
80106b7b:	c3                   	ret    
80106b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106b80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106b85:	c9                   	leave  
80106b86:	c3                   	ret    
80106b87:	89 f6                	mov    %esi,%esi
80106b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b90 <sys_policy>:

int
sys_policy(void){
80106b90:	55                   	push   %ebp
80106b91:	89 e5                	mov    %esp,%ebp
80106b93:	83 ec 28             	sub    $0x28,%esp
    int pid;
    if(argint(0, &pid) < 0)
80106b96:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106b99:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b9d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106ba4:	e8 a7 f0 ff ff       	call   80105c50 <argint>
80106ba9:	85 c0                	test   %eax,%eax
80106bab:	78 13                	js     80106bc0 <sys_policy+0x30>
        return -1;
    policy(pid);
80106bad:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106bb0:	89 04 24             	mov    %eax,(%esp)
80106bb3:	e8 08 dc ff ff       	call   801047c0 <policy>
    return 0;
80106bb8:	31 c0                	xor    %eax,%eax
}
80106bba:	c9                   	leave  
80106bbb:	c3                   	ret    
80106bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
80106bc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106bc5:	c9                   	leave  
80106bc6:	c3                   	ret    
80106bc7:	89 f6                	mov    %esi,%esi
80106bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106bd0 <sys_wait_stat>:


int
sys_wait_stat(void)
{
80106bd0:	55                   	push   %ebp
  //TODO - add perf struct to the args of the function
  return 0;
}
80106bd1:	31 c0                	xor    %eax,%eax
{
80106bd3:	89 e5                	mov    %esp,%ebp
}
80106bd5:	5d                   	pop    %ebp
80106bd6:	c3                   	ret    

80106bd7 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106bd7:	1e                   	push   %ds
  pushl %es
80106bd8:	06                   	push   %es
  pushl %fs
80106bd9:	0f a0                	push   %fs
  pushl %gs
80106bdb:	0f a8                	push   %gs
  pushal
80106bdd:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106bde:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106be2:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106be4:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106be6:	54                   	push   %esp
  call trap
80106be7:	e8 c4 00 00 00       	call   80106cb0 <trap>
  addl $4, %esp
80106bec:	83 c4 04             	add    $0x4,%esp

80106bef <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106bef:	61                   	popa   
  popl %gs
80106bf0:	0f a9                	pop    %gs
  popl %fs
80106bf2:	0f a1                	pop    %fs
  popl %es
80106bf4:	07                   	pop    %es
  popl %ds
80106bf5:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106bf6:	83 c4 08             	add    $0x8,%esp
  iret
80106bf9:	cf                   	iret   
80106bfa:	66 90                	xchg   %ax,%ax
80106bfc:	66 90                	xchg   %ax,%ax
80106bfe:	66 90                	xchg   %ax,%ax

80106c00 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106c00:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106c01:	31 c0                	xor    %eax,%eax
{
80106c03:	89 e5                	mov    %esp,%ebp
80106c05:	83 ec 18             	sub    $0x18,%esp
80106c08:	90                   	nop
80106c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106c10:	8b 14 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%edx
80106c17:	b9 08 00 00 8e       	mov    $0x8e000008,%ecx
80106c1c:	89 0c c5 02 67 11 80 	mov    %ecx,-0x7fee98fe(,%eax,8)
80106c23:	66 89 14 c5 00 67 11 	mov    %dx,-0x7fee9900(,%eax,8)
80106c2a:	80 
80106c2b:	c1 ea 10             	shr    $0x10,%edx
80106c2e:	66 89 14 c5 06 67 11 	mov    %dx,-0x7fee98fa(,%eax,8)
80106c35:	80 
  for(i = 0; i < 256; i++)
80106c36:	40                   	inc    %eax
80106c37:	3d 00 01 00 00       	cmp    $0x100,%eax
80106c3c:	75 d2                	jne    80106c10 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106c3e:	a1 0c b1 10 80       	mov    0x8010b10c,%eax

  initlock(&tickslock, "time");
80106c43:	b9 dd 8c 10 80       	mov    $0x80108cdd,%ecx
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106c48:	ba 08 00 00 ef       	mov    $0xef000008,%edx
  initlock(&tickslock, "time");
80106c4d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80106c51:	c7 04 24 c0 66 11 80 	movl   $0x801166c0,(%esp)
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106c58:	89 15 02 69 11 80    	mov    %edx,0x80116902
80106c5e:	66 a3 00 69 11 80    	mov    %ax,0x80116900
80106c64:	c1 e8 10             	shr    $0x10,%eax
80106c67:	66 a3 06 69 11 80    	mov    %ax,0x80116906
  initlock(&tickslock, "time");
80106c6d:	e8 ae ea ff ff       	call   80105720 <initlock>
}
80106c72:	c9                   	leave  
80106c73:	c3                   	ret    
80106c74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106c80 <idtinit>:

void
idtinit(void)
{
80106c80:	55                   	push   %ebp
  pd[1] = (uint)p;
80106c81:	b8 00 67 11 80       	mov    $0x80116700,%eax
80106c86:	89 e5                	mov    %esp,%ebp
80106c88:	0f b7 d0             	movzwl %ax,%edx
  pd[2] = (uint)p >> 16;
80106c8b:	c1 e8 10             	shr    $0x10,%eax
80106c8e:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
80106c91:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
80106c97:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106c9b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80106c9f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106ca2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106ca5:	c9                   	leave  
80106ca6:	c3                   	ret    
80106ca7:	89 f6                	mov    %esi,%esi
80106ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106cb0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106cb0:	55                   	push   %ebp
80106cb1:	89 e5                	mov    %esp,%ebp
80106cb3:	83 ec 48             	sub    $0x48,%esp
80106cb6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80106cb9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80106cbc:	89 75 f8             	mov    %esi,-0x8(%ebp)
80106cbf:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(tf->trapno == T_SYSCALL){
80106cc2:	8b 43 30             	mov    0x30(%ebx),%eax
80106cc5:	83 f8 40             	cmp    $0x40,%eax
80106cc8:	0f 84 02 01 00 00    	je     80106dd0 <trap+0x120>
    if(myproc()->killed)
      exit(0);
    return;
  }

  switch(tf->trapno){
80106cce:	83 e8 20             	sub    $0x20,%eax
80106cd1:	83 f8 1f             	cmp    $0x1f,%eax
80106cd4:	77 0a                	ja     80106ce0 <trap+0x30>
80106cd6:	ff 24 85 84 8d 10 80 	jmp    *-0x7fef727c(,%eax,4)
80106cdd:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80106ce0:	e8 3b cd ff ff       	call   80103a20 <myproc>
80106ce5:	8b 7b 38             	mov    0x38(%ebx),%edi
80106ce8:	85 c0                	test   %eax,%eax
80106cea:	0f 84 5f 02 00 00    	je     80106f4f <trap+0x29f>
80106cf0:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106cf4:	0f 84 55 02 00 00    	je     80106f4f <trap+0x29f>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106cfa:	0f 20 d1             	mov    %cr2,%ecx
80106cfd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106d00:	e8 fb cc ff ff       	call   80103a00 <cpuid>
80106d05:	8b 73 30             	mov    0x30(%ebx),%esi
80106d08:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106d0b:	8b 43 34             	mov    0x34(%ebx),%eax
80106d0e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106d11:	e8 0a cd ff ff       	call   80103a20 <myproc>
80106d16:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106d19:	e8 02 cd ff ff       	call   80103a20 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106d1e:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106d21:	89 74 24 0c          	mov    %esi,0xc(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
80106d25:	8b 75 e0             	mov    -0x20(%ebp),%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106d28:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106d2b:	89 7c 24 18          	mov    %edi,0x18(%esp)
80106d2f:	89 54 24 14          	mov    %edx,0x14(%esp)
80106d33:	8b 55 e4             	mov    -0x1c(%ebp),%edx
            myproc()->pid, myproc()->name, tf->trapno,
80106d36:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106d39:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
80106d3d:	89 74 24 08          	mov    %esi,0x8(%esp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106d41:	89 54 24 10          	mov    %edx,0x10(%esp)
80106d45:	8b 40 10             	mov    0x10(%eax),%eax
80106d48:	c7 04 24 40 8d 10 80 	movl   $0x80108d40,(%esp)
80106d4f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d53:	e8 f8 98 ff ff       	call   80100650 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80106d58:	e8 c3 cc ff ff       	call   80103a20 <myproc>
80106d5d:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106d64:	e8 b7 cc ff ff       	call   80103a20 <myproc>
80106d69:	85 c0                	test   %eax,%eax
80106d6b:	74 1b                	je     80106d88 <trap+0xd8>
80106d6d:	e8 ae cc ff ff       	call   80103a20 <myproc>
80106d72:	8b 50 24             	mov    0x24(%eax),%edx
80106d75:	85 d2                	test   %edx,%edx
80106d77:	74 0f                	je     80106d88 <trap+0xd8>
80106d79:	8b 43 3c             	mov    0x3c(%ebx),%eax
80106d7c:	83 e0 03             	and    $0x3,%eax
80106d7f:	83 f8 03             	cmp    $0x3,%eax
80106d82:	0f 84 80 01 00 00    	je     80106f08 <trap+0x258>
    exit(0);

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106d88:	e8 93 cc ff ff       	call   80103a20 <myproc>
80106d8d:	85 c0                	test   %eax,%eax
80106d8f:	74 0d                	je     80106d9e <trap+0xee>
80106d91:	e8 8a cc ff ff       	call   80103a20 <myproc>
80106d96:	8b 40 0c             	mov    0xc(%eax),%eax
80106d99:	83 f8 04             	cmp    $0x4,%eax
80106d9c:	74 7a                	je     80106e18 <trap+0x168>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106d9e:	e8 7d cc ff ff       	call   80103a20 <myproc>
80106da3:	85 c0                	test   %eax,%eax
80106da5:	74 17                	je     80106dbe <trap+0x10e>
80106da7:	e8 74 cc ff ff       	call   80103a20 <myproc>
80106dac:	8b 40 24             	mov    0x24(%eax),%eax
80106daf:	85 c0                	test   %eax,%eax
80106db1:	74 0b                	je     80106dbe <trap+0x10e>
80106db3:	8b 43 3c             	mov    0x3c(%ebx),%eax
80106db6:	83 e0 03             	and    $0x3,%eax
80106db9:	83 f8 03             	cmp    $0x3,%eax
80106dbc:	74 3b                	je     80106df9 <trap+0x149>
    exit(0);
}
80106dbe:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80106dc1:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106dc4:	8b 7d fc             	mov    -0x4(%ebp),%edi
80106dc7:	89 ec                	mov    %ebp,%esp
80106dc9:	5d                   	pop    %ebp
80106dca:	c3                   	ret    
80106dcb:	90                   	nop
80106dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80106dd0:	e8 4b cc ff ff       	call   80103a20 <myproc>
80106dd5:	8b 70 24             	mov    0x24(%eax),%esi
80106dd8:	85 f6                	test   %esi,%esi
80106dda:	0f 85 10 01 00 00    	jne    80106ef0 <trap+0x240>
    myproc()->tf = tf;
80106de0:	e8 3b cc ff ff       	call   80103a20 <myproc>
80106de5:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80106de8:	e8 53 ef ff ff       	call   80105d40 <syscall>
    if(myproc()->killed)
80106ded:	e8 2e cc ff ff       	call   80103a20 <myproc>
80106df2:	8b 48 24             	mov    0x24(%eax),%ecx
80106df5:	85 c9                	test   %ecx,%ecx
80106df7:	74 c5                	je     80106dbe <trap+0x10e>
      exit(0);
80106df9:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
}
80106e00:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80106e03:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106e06:	8b 7d fc             	mov    -0x4(%ebp),%edi
80106e09:	89 ec                	mov    %ebp,%esp
80106e0b:	5d                   	pop    %ebp
      exit(0);
80106e0c:	e9 2f d3 ff ff       	jmp    80104140 <exit>
80106e11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(myproc() && myproc()->state == RUNNING &&
80106e18:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106e1c:	75 80                	jne    80106d9e <trap+0xee>
    yield();
80106e1e:	e8 1d d4 ff ff       	call   80104240 <yield>
80106e23:	e9 76 ff ff ff       	jmp    80106d9e <trap+0xee>
80106e28:	90                   	nop
80106e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80106e30:	e8 cb cb ff ff       	call   80103a00 <cpuid>
80106e35:	85 c0                	test   %eax,%eax
80106e37:	0f 84 e3 00 00 00    	je     80106f20 <trap+0x270>
80106e3d:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
80106e40:	e8 0b ba ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106e45:	e8 d6 cb ff ff       	call   80103a20 <myproc>
80106e4a:	85 c0                	test   %eax,%eax
80106e4c:	0f 85 1b ff ff ff    	jne    80106d6d <trap+0xbd>
80106e52:	e9 31 ff ff ff       	jmp    80106d88 <trap+0xd8>
80106e57:	89 f6                	mov    %esi,%esi
80106e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    kbdintr();
80106e60:	e8 ab b8 ff ff       	call   80102710 <kbdintr>
    lapiceoi();
80106e65:	e8 e6 b9 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106e6a:	e8 b1 cb ff ff       	call   80103a20 <myproc>
80106e6f:	85 c0                	test   %eax,%eax
80106e71:	0f 85 f6 fe ff ff    	jne    80106d6d <trap+0xbd>
80106e77:	e9 0c ff ff ff       	jmp    80106d88 <trap+0xd8>
80106e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106e80:	e8 6b 02 00 00       	call   801070f0 <uartintr>
    lapiceoi();
80106e85:	e8 c6 b9 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106e8a:	e8 91 cb ff ff       	call   80103a20 <myproc>
80106e8f:	85 c0                	test   %eax,%eax
80106e91:	0f 85 d6 fe ff ff    	jne    80106d6d <trap+0xbd>
80106e97:	e9 ec fe ff ff       	jmp    80106d88 <trap+0xd8>
80106e9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106ea0:	8b 7b 38             	mov    0x38(%ebx),%edi
80106ea3:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80106ea7:	e8 54 cb ff ff       	call   80103a00 <cpuid>
80106eac:	c7 04 24 e8 8c 10 80 	movl   $0x80108ce8,(%esp)
80106eb3:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80106eb7:	89 74 24 08          	mov    %esi,0x8(%esp)
80106ebb:	89 44 24 04          	mov    %eax,0x4(%esp)
80106ebf:	e8 8c 97 ff ff       	call   80100650 <cprintf>
    lapiceoi();
80106ec4:	e8 87 b9 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106ec9:	e8 52 cb ff ff       	call   80103a20 <myproc>
80106ece:	85 c0                	test   %eax,%eax
80106ed0:	0f 85 97 fe ff ff    	jne    80106d6d <trap+0xbd>
80106ed6:	e9 ad fe ff ff       	jmp    80106d88 <trap+0xd8>
80106edb:	90                   	nop
80106edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80106ee0:	e8 7b b2 ff ff       	call   80102160 <ideintr>
80106ee5:	e9 53 ff ff ff       	jmp    80106e3d <trap+0x18d>
80106eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit(0);
80106ef0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106ef7:	e8 44 d2 ff ff       	call   80104140 <exit>
80106efc:	e9 df fe ff ff       	jmp    80106de0 <trap+0x130>
80106f01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit(0);
80106f08:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106f0f:	e8 2c d2 ff ff       	call   80104140 <exit>
80106f14:	e9 6f fe ff ff       	jmp    80106d88 <trap+0xd8>
80106f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      acquire(&tickslock);
80106f20:	c7 04 24 c0 66 11 80 	movl   $0x801166c0,(%esp)
80106f27:	e8 44 e9 ff ff       	call   80105870 <acquire>
      wakeup(&ticks);
80106f2c:	c7 04 24 00 6f 11 80 	movl   $0x80116f00,(%esp)
      ticks++;
80106f33:	ff 05 00 6f 11 80    	incl   0x80116f00
      wakeup(&ticks);
80106f39:	e8 e2 d5 ff ff       	call   80104520 <wakeup>
      release(&tickslock);
80106f3e:	c7 04 24 c0 66 11 80 	movl   $0x801166c0,(%esp)
80106f45:	e8 c6 e9 ff ff       	call   80105910 <release>
80106f4a:	e9 ee fe ff ff       	jmp    80106e3d <trap+0x18d>
80106f4f:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106f52:	e8 a9 ca ff ff       	call   80103a00 <cpuid>
80106f57:	89 74 24 10          	mov    %esi,0x10(%esp)
80106f5b:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80106f5f:	89 44 24 08          	mov    %eax,0x8(%esp)
80106f63:	8b 43 30             	mov    0x30(%ebx),%eax
80106f66:	c7 04 24 0c 8d 10 80 	movl   $0x80108d0c,(%esp)
80106f6d:	89 44 24 04          	mov    %eax,0x4(%esp)
80106f71:	e8 da 96 ff ff       	call   80100650 <cprintf>
      panic("trap");
80106f76:	c7 04 24 e2 8c 10 80 	movl   $0x80108ce2,(%esp)
80106f7d:	e8 ee 93 ff ff       	call   80100370 <panic>
80106f82:	66 90                	xchg   %ax,%ax
80106f84:	66 90                	xchg   %ax,%ax
80106f86:	66 90                	xchg   %ax,%ax
80106f88:	66 90                	xchg   %ax,%ax
80106f8a:	66 90                	xchg   %ax,%ax
80106f8c:	66 90                	xchg   %ax,%ax
80106f8e:	66 90                	xchg   %ax,%ax

80106f90 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106f90:	a1 14 b6 10 80       	mov    0x8010b614,%eax
{
80106f95:	55                   	push   %ebp
80106f96:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106f98:	85 c0                	test   %eax,%eax
80106f9a:	74 1c                	je     80106fb8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106f9c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106fa1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106fa2:	24 01                	and    $0x1,%al
80106fa4:	84 c0                	test   %al,%al
80106fa6:	74 10                	je     80106fb8 <uartgetc+0x28>
80106fa8:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106fad:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106fae:	0f b6 c0             	movzbl %al,%eax
}
80106fb1:	5d                   	pop    %ebp
80106fb2:	c3                   	ret    
80106fb3:	90                   	nop
80106fb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106fb8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106fbd:	5d                   	pop    %ebp
80106fbe:	c3                   	ret    
80106fbf:	90                   	nop

80106fc0 <uartputc.part.0>:
uartputc(int c)
80106fc0:	55                   	push   %ebp
80106fc1:	89 e5                	mov    %esp,%ebp
80106fc3:	56                   	push   %esi
80106fc4:	be fd 03 00 00       	mov    $0x3fd,%esi
80106fc9:	53                   	push   %ebx
80106fca:	bb 80 00 00 00       	mov    $0x80,%ebx
80106fcf:	83 ec 20             	sub    $0x20,%esp
80106fd2:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106fd5:	eb 18                	jmp    80106fef <uartputc.part.0+0x2f>
80106fd7:	89 f6                	mov    %esi,%esi
80106fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80106fe0:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80106fe7:	e8 84 b8 ff ff       	call   80102870 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106fec:	4b                   	dec    %ebx
80106fed:	74 09                	je     80106ff8 <uartputc.part.0+0x38>
80106fef:	89 f2                	mov    %esi,%edx
80106ff1:	ec                   	in     (%dx),%al
80106ff2:	24 20                	and    $0x20,%al
80106ff4:	84 c0                	test   %al,%al
80106ff6:	74 e8                	je     80106fe0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106ff8:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106ffd:	0f b6 45 f4          	movzbl -0xc(%ebp),%eax
80107001:	ee                   	out    %al,(%dx)
}
80107002:	83 c4 20             	add    $0x20,%esp
80107005:	5b                   	pop    %ebx
80107006:	5e                   	pop    %esi
80107007:	5d                   	pop    %ebp
80107008:	c3                   	ret    
80107009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107010 <uartinit>:
{
80107010:	55                   	push   %ebp
80107011:	31 c9                	xor    %ecx,%ecx
80107013:	89 e5                	mov    %esp,%ebp
80107015:	88 c8                	mov    %cl,%al
80107017:	57                   	push   %edi
80107018:	56                   	push   %esi
80107019:	53                   	push   %ebx
8010701a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010701f:	83 ec 1c             	sub    $0x1c,%esp
80107022:	89 da                	mov    %ebx,%edx
80107024:	ee                   	out    %al,(%dx)
80107025:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010702a:	b0 80                	mov    $0x80,%al
8010702c:	89 fa                	mov    %edi,%edx
8010702e:	ee                   	out    %al,(%dx)
8010702f:	b0 0c                	mov    $0xc,%al
80107031:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107036:	ee                   	out    %al,(%dx)
80107037:	be f9 03 00 00       	mov    $0x3f9,%esi
8010703c:	88 c8                	mov    %cl,%al
8010703e:	89 f2                	mov    %esi,%edx
80107040:	ee                   	out    %al,(%dx)
80107041:	b0 03                	mov    $0x3,%al
80107043:	89 fa                	mov    %edi,%edx
80107045:	ee                   	out    %al,(%dx)
80107046:	ba fc 03 00 00       	mov    $0x3fc,%edx
8010704b:	88 c8                	mov    %cl,%al
8010704d:	ee                   	out    %al,(%dx)
8010704e:	b0 01                	mov    $0x1,%al
80107050:	89 f2                	mov    %esi,%edx
80107052:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80107053:	ba fd 03 00 00       	mov    $0x3fd,%edx
80107058:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80107059:	fe c0                	inc    %al
8010705b:	74 52                	je     801070af <uartinit+0x9f>
  uart = 1;
8010705d:	b9 01 00 00 00       	mov    $0x1,%ecx
80107062:	89 da                	mov    %ebx,%edx
80107064:	89 0d 14 b6 10 80    	mov    %ecx,0x8010b614
8010706a:	ec                   	in     (%dx),%al
8010706b:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107070:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80107071:	31 db                	xor    %ebx,%ebx
80107073:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  for(p="xv6...\n"; *p; p++)
80107077:	bb 04 8e 10 80       	mov    $0x80108e04,%ebx
  ioapicenable(IRQ_COM1, 0);
8010707c:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80107083:	e8 18 b3 ff ff       	call   801023a0 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
80107088:	b8 78 00 00 00       	mov    $0x78,%eax
8010708d:	eb 09                	jmp    80107098 <uartinit+0x88>
8010708f:	90                   	nop
80107090:	43                   	inc    %ebx
80107091:	0f be 03             	movsbl (%ebx),%eax
80107094:	84 c0                	test   %al,%al
80107096:	74 17                	je     801070af <uartinit+0x9f>
  if(!uart)
80107098:	8b 15 14 b6 10 80    	mov    0x8010b614,%edx
8010709e:	85 d2                	test   %edx,%edx
801070a0:	74 ee                	je     80107090 <uartinit+0x80>
  for(p="xv6...\n"; *p; p++)
801070a2:	43                   	inc    %ebx
801070a3:	e8 18 ff ff ff       	call   80106fc0 <uartputc.part.0>
801070a8:	0f be 03             	movsbl (%ebx),%eax
801070ab:	84 c0                	test   %al,%al
801070ad:	75 e9                	jne    80107098 <uartinit+0x88>
}
801070af:	83 c4 1c             	add    $0x1c,%esp
801070b2:	5b                   	pop    %ebx
801070b3:	5e                   	pop    %esi
801070b4:	5f                   	pop    %edi
801070b5:	5d                   	pop    %ebp
801070b6:	c3                   	ret    
801070b7:	89 f6                	mov    %esi,%esi
801070b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801070c0 <uartputc>:
  if(!uart)
801070c0:	8b 15 14 b6 10 80    	mov    0x8010b614,%edx
{
801070c6:	55                   	push   %ebp
801070c7:	89 e5                	mov    %esp,%ebp
801070c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
801070cc:	85 d2                	test   %edx,%edx
801070ce:	74 10                	je     801070e0 <uartputc+0x20>
}
801070d0:	5d                   	pop    %ebp
801070d1:	e9 ea fe ff ff       	jmp    80106fc0 <uartputc.part.0>
801070d6:	8d 76 00             	lea    0x0(%esi),%esi
801070d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801070e0:	5d                   	pop    %ebp
801070e1:	c3                   	ret    
801070e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801070f0 <uartintr>:

void
uartintr(void)
{
801070f0:	55                   	push   %ebp
801070f1:	89 e5                	mov    %esp,%ebp
801070f3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
801070f6:	c7 04 24 90 6f 10 80 	movl   $0x80106f90,(%esp)
801070fd:	e8 ce 96 ff ff       	call   801007d0 <consoleintr>
}
80107102:	c9                   	leave  
80107103:	c3                   	ret    

80107104 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80107104:	6a 00                	push   $0x0
  pushl $0
80107106:	6a 00                	push   $0x0
  jmp alltraps
80107108:	e9 ca fa ff ff       	jmp    80106bd7 <alltraps>

8010710d <vector1>:
.globl vector1
vector1:
  pushl $0
8010710d:	6a 00                	push   $0x0
  pushl $1
8010710f:	6a 01                	push   $0x1
  jmp alltraps
80107111:	e9 c1 fa ff ff       	jmp    80106bd7 <alltraps>

80107116 <vector2>:
.globl vector2
vector2:
  pushl $0
80107116:	6a 00                	push   $0x0
  pushl $2
80107118:	6a 02                	push   $0x2
  jmp alltraps
8010711a:	e9 b8 fa ff ff       	jmp    80106bd7 <alltraps>

8010711f <vector3>:
.globl vector3
vector3:
  pushl $0
8010711f:	6a 00                	push   $0x0
  pushl $3
80107121:	6a 03                	push   $0x3
  jmp alltraps
80107123:	e9 af fa ff ff       	jmp    80106bd7 <alltraps>

80107128 <vector4>:
.globl vector4
vector4:
  pushl $0
80107128:	6a 00                	push   $0x0
  pushl $4
8010712a:	6a 04                	push   $0x4
  jmp alltraps
8010712c:	e9 a6 fa ff ff       	jmp    80106bd7 <alltraps>

80107131 <vector5>:
.globl vector5
vector5:
  pushl $0
80107131:	6a 00                	push   $0x0
  pushl $5
80107133:	6a 05                	push   $0x5
  jmp alltraps
80107135:	e9 9d fa ff ff       	jmp    80106bd7 <alltraps>

8010713a <vector6>:
.globl vector6
vector6:
  pushl $0
8010713a:	6a 00                	push   $0x0
  pushl $6
8010713c:	6a 06                	push   $0x6
  jmp alltraps
8010713e:	e9 94 fa ff ff       	jmp    80106bd7 <alltraps>

80107143 <vector7>:
.globl vector7
vector7:
  pushl $0
80107143:	6a 00                	push   $0x0
  pushl $7
80107145:	6a 07                	push   $0x7
  jmp alltraps
80107147:	e9 8b fa ff ff       	jmp    80106bd7 <alltraps>

8010714c <vector8>:
.globl vector8
vector8:
  pushl $8
8010714c:	6a 08                	push   $0x8
  jmp alltraps
8010714e:	e9 84 fa ff ff       	jmp    80106bd7 <alltraps>

80107153 <vector9>:
.globl vector9
vector9:
  pushl $0
80107153:	6a 00                	push   $0x0
  pushl $9
80107155:	6a 09                	push   $0x9
  jmp alltraps
80107157:	e9 7b fa ff ff       	jmp    80106bd7 <alltraps>

8010715c <vector10>:
.globl vector10
vector10:
  pushl $10
8010715c:	6a 0a                	push   $0xa
  jmp alltraps
8010715e:	e9 74 fa ff ff       	jmp    80106bd7 <alltraps>

80107163 <vector11>:
.globl vector11
vector11:
  pushl $11
80107163:	6a 0b                	push   $0xb
  jmp alltraps
80107165:	e9 6d fa ff ff       	jmp    80106bd7 <alltraps>

8010716a <vector12>:
.globl vector12
vector12:
  pushl $12
8010716a:	6a 0c                	push   $0xc
  jmp alltraps
8010716c:	e9 66 fa ff ff       	jmp    80106bd7 <alltraps>

80107171 <vector13>:
.globl vector13
vector13:
  pushl $13
80107171:	6a 0d                	push   $0xd
  jmp alltraps
80107173:	e9 5f fa ff ff       	jmp    80106bd7 <alltraps>

80107178 <vector14>:
.globl vector14
vector14:
  pushl $14
80107178:	6a 0e                	push   $0xe
  jmp alltraps
8010717a:	e9 58 fa ff ff       	jmp    80106bd7 <alltraps>

8010717f <vector15>:
.globl vector15
vector15:
  pushl $0
8010717f:	6a 00                	push   $0x0
  pushl $15
80107181:	6a 0f                	push   $0xf
  jmp alltraps
80107183:	e9 4f fa ff ff       	jmp    80106bd7 <alltraps>

80107188 <vector16>:
.globl vector16
vector16:
  pushl $0
80107188:	6a 00                	push   $0x0
  pushl $16
8010718a:	6a 10                	push   $0x10
  jmp alltraps
8010718c:	e9 46 fa ff ff       	jmp    80106bd7 <alltraps>

80107191 <vector17>:
.globl vector17
vector17:
  pushl $17
80107191:	6a 11                	push   $0x11
  jmp alltraps
80107193:	e9 3f fa ff ff       	jmp    80106bd7 <alltraps>

80107198 <vector18>:
.globl vector18
vector18:
  pushl $0
80107198:	6a 00                	push   $0x0
  pushl $18
8010719a:	6a 12                	push   $0x12
  jmp alltraps
8010719c:	e9 36 fa ff ff       	jmp    80106bd7 <alltraps>

801071a1 <vector19>:
.globl vector19
vector19:
  pushl $0
801071a1:	6a 00                	push   $0x0
  pushl $19
801071a3:	6a 13                	push   $0x13
  jmp alltraps
801071a5:	e9 2d fa ff ff       	jmp    80106bd7 <alltraps>

801071aa <vector20>:
.globl vector20
vector20:
  pushl $0
801071aa:	6a 00                	push   $0x0
  pushl $20
801071ac:	6a 14                	push   $0x14
  jmp alltraps
801071ae:	e9 24 fa ff ff       	jmp    80106bd7 <alltraps>

801071b3 <vector21>:
.globl vector21
vector21:
  pushl $0
801071b3:	6a 00                	push   $0x0
  pushl $21
801071b5:	6a 15                	push   $0x15
  jmp alltraps
801071b7:	e9 1b fa ff ff       	jmp    80106bd7 <alltraps>

801071bc <vector22>:
.globl vector22
vector22:
  pushl $0
801071bc:	6a 00                	push   $0x0
  pushl $22
801071be:	6a 16                	push   $0x16
  jmp alltraps
801071c0:	e9 12 fa ff ff       	jmp    80106bd7 <alltraps>

801071c5 <vector23>:
.globl vector23
vector23:
  pushl $0
801071c5:	6a 00                	push   $0x0
  pushl $23
801071c7:	6a 17                	push   $0x17
  jmp alltraps
801071c9:	e9 09 fa ff ff       	jmp    80106bd7 <alltraps>

801071ce <vector24>:
.globl vector24
vector24:
  pushl $0
801071ce:	6a 00                	push   $0x0
  pushl $24
801071d0:	6a 18                	push   $0x18
  jmp alltraps
801071d2:	e9 00 fa ff ff       	jmp    80106bd7 <alltraps>

801071d7 <vector25>:
.globl vector25
vector25:
  pushl $0
801071d7:	6a 00                	push   $0x0
  pushl $25
801071d9:	6a 19                	push   $0x19
  jmp alltraps
801071db:	e9 f7 f9 ff ff       	jmp    80106bd7 <alltraps>

801071e0 <vector26>:
.globl vector26
vector26:
  pushl $0
801071e0:	6a 00                	push   $0x0
  pushl $26
801071e2:	6a 1a                	push   $0x1a
  jmp alltraps
801071e4:	e9 ee f9 ff ff       	jmp    80106bd7 <alltraps>

801071e9 <vector27>:
.globl vector27
vector27:
  pushl $0
801071e9:	6a 00                	push   $0x0
  pushl $27
801071eb:	6a 1b                	push   $0x1b
  jmp alltraps
801071ed:	e9 e5 f9 ff ff       	jmp    80106bd7 <alltraps>

801071f2 <vector28>:
.globl vector28
vector28:
  pushl $0
801071f2:	6a 00                	push   $0x0
  pushl $28
801071f4:	6a 1c                	push   $0x1c
  jmp alltraps
801071f6:	e9 dc f9 ff ff       	jmp    80106bd7 <alltraps>

801071fb <vector29>:
.globl vector29
vector29:
  pushl $0
801071fb:	6a 00                	push   $0x0
  pushl $29
801071fd:	6a 1d                	push   $0x1d
  jmp alltraps
801071ff:	e9 d3 f9 ff ff       	jmp    80106bd7 <alltraps>

80107204 <vector30>:
.globl vector30
vector30:
  pushl $0
80107204:	6a 00                	push   $0x0
  pushl $30
80107206:	6a 1e                	push   $0x1e
  jmp alltraps
80107208:	e9 ca f9 ff ff       	jmp    80106bd7 <alltraps>

8010720d <vector31>:
.globl vector31
vector31:
  pushl $0
8010720d:	6a 00                	push   $0x0
  pushl $31
8010720f:	6a 1f                	push   $0x1f
  jmp alltraps
80107211:	e9 c1 f9 ff ff       	jmp    80106bd7 <alltraps>

80107216 <vector32>:
.globl vector32
vector32:
  pushl $0
80107216:	6a 00                	push   $0x0
  pushl $32
80107218:	6a 20                	push   $0x20
  jmp alltraps
8010721a:	e9 b8 f9 ff ff       	jmp    80106bd7 <alltraps>

8010721f <vector33>:
.globl vector33
vector33:
  pushl $0
8010721f:	6a 00                	push   $0x0
  pushl $33
80107221:	6a 21                	push   $0x21
  jmp alltraps
80107223:	e9 af f9 ff ff       	jmp    80106bd7 <alltraps>

80107228 <vector34>:
.globl vector34
vector34:
  pushl $0
80107228:	6a 00                	push   $0x0
  pushl $34
8010722a:	6a 22                	push   $0x22
  jmp alltraps
8010722c:	e9 a6 f9 ff ff       	jmp    80106bd7 <alltraps>

80107231 <vector35>:
.globl vector35
vector35:
  pushl $0
80107231:	6a 00                	push   $0x0
  pushl $35
80107233:	6a 23                	push   $0x23
  jmp alltraps
80107235:	e9 9d f9 ff ff       	jmp    80106bd7 <alltraps>

8010723a <vector36>:
.globl vector36
vector36:
  pushl $0
8010723a:	6a 00                	push   $0x0
  pushl $36
8010723c:	6a 24                	push   $0x24
  jmp alltraps
8010723e:	e9 94 f9 ff ff       	jmp    80106bd7 <alltraps>

80107243 <vector37>:
.globl vector37
vector37:
  pushl $0
80107243:	6a 00                	push   $0x0
  pushl $37
80107245:	6a 25                	push   $0x25
  jmp alltraps
80107247:	e9 8b f9 ff ff       	jmp    80106bd7 <alltraps>

8010724c <vector38>:
.globl vector38
vector38:
  pushl $0
8010724c:	6a 00                	push   $0x0
  pushl $38
8010724e:	6a 26                	push   $0x26
  jmp alltraps
80107250:	e9 82 f9 ff ff       	jmp    80106bd7 <alltraps>

80107255 <vector39>:
.globl vector39
vector39:
  pushl $0
80107255:	6a 00                	push   $0x0
  pushl $39
80107257:	6a 27                	push   $0x27
  jmp alltraps
80107259:	e9 79 f9 ff ff       	jmp    80106bd7 <alltraps>

8010725e <vector40>:
.globl vector40
vector40:
  pushl $0
8010725e:	6a 00                	push   $0x0
  pushl $40
80107260:	6a 28                	push   $0x28
  jmp alltraps
80107262:	e9 70 f9 ff ff       	jmp    80106bd7 <alltraps>

80107267 <vector41>:
.globl vector41
vector41:
  pushl $0
80107267:	6a 00                	push   $0x0
  pushl $41
80107269:	6a 29                	push   $0x29
  jmp alltraps
8010726b:	e9 67 f9 ff ff       	jmp    80106bd7 <alltraps>

80107270 <vector42>:
.globl vector42
vector42:
  pushl $0
80107270:	6a 00                	push   $0x0
  pushl $42
80107272:	6a 2a                	push   $0x2a
  jmp alltraps
80107274:	e9 5e f9 ff ff       	jmp    80106bd7 <alltraps>

80107279 <vector43>:
.globl vector43
vector43:
  pushl $0
80107279:	6a 00                	push   $0x0
  pushl $43
8010727b:	6a 2b                	push   $0x2b
  jmp alltraps
8010727d:	e9 55 f9 ff ff       	jmp    80106bd7 <alltraps>

80107282 <vector44>:
.globl vector44
vector44:
  pushl $0
80107282:	6a 00                	push   $0x0
  pushl $44
80107284:	6a 2c                	push   $0x2c
  jmp alltraps
80107286:	e9 4c f9 ff ff       	jmp    80106bd7 <alltraps>

8010728b <vector45>:
.globl vector45
vector45:
  pushl $0
8010728b:	6a 00                	push   $0x0
  pushl $45
8010728d:	6a 2d                	push   $0x2d
  jmp alltraps
8010728f:	e9 43 f9 ff ff       	jmp    80106bd7 <alltraps>

80107294 <vector46>:
.globl vector46
vector46:
  pushl $0
80107294:	6a 00                	push   $0x0
  pushl $46
80107296:	6a 2e                	push   $0x2e
  jmp alltraps
80107298:	e9 3a f9 ff ff       	jmp    80106bd7 <alltraps>

8010729d <vector47>:
.globl vector47
vector47:
  pushl $0
8010729d:	6a 00                	push   $0x0
  pushl $47
8010729f:	6a 2f                	push   $0x2f
  jmp alltraps
801072a1:	e9 31 f9 ff ff       	jmp    80106bd7 <alltraps>

801072a6 <vector48>:
.globl vector48
vector48:
  pushl $0
801072a6:	6a 00                	push   $0x0
  pushl $48
801072a8:	6a 30                	push   $0x30
  jmp alltraps
801072aa:	e9 28 f9 ff ff       	jmp    80106bd7 <alltraps>

801072af <vector49>:
.globl vector49
vector49:
  pushl $0
801072af:	6a 00                	push   $0x0
  pushl $49
801072b1:	6a 31                	push   $0x31
  jmp alltraps
801072b3:	e9 1f f9 ff ff       	jmp    80106bd7 <alltraps>

801072b8 <vector50>:
.globl vector50
vector50:
  pushl $0
801072b8:	6a 00                	push   $0x0
  pushl $50
801072ba:	6a 32                	push   $0x32
  jmp alltraps
801072bc:	e9 16 f9 ff ff       	jmp    80106bd7 <alltraps>

801072c1 <vector51>:
.globl vector51
vector51:
  pushl $0
801072c1:	6a 00                	push   $0x0
  pushl $51
801072c3:	6a 33                	push   $0x33
  jmp alltraps
801072c5:	e9 0d f9 ff ff       	jmp    80106bd7 <alltraps>

801072ca <vector52>:
.globl vector52
vector52:
  pushl $0
801072ca:	6a 00                	push   $0x0
  pushl $52
801072cc:	6a 34                	push   $0x34
  jmp alltraps
801072ce:	e9 04 f9 ff ff       	jmp    80106bd7 <alltraps>

801072d3 <vector53>:
.globl vector53
vector53:
  pushl $0
801072d3:	6a 00                	push   $0x0
  pushl $53
801072d5:	6a 35                	push   $0x35
  jmp alltraps
801072d7:	e9 fb f8 ff ff       	jmp    80106bd7 <alltraps>

801072dc <vector54>:
.globl vector54
vector54:
  pushl $0
801072dc:	6a 00                	push   $0x0
  pushl $54
801072de:	6a 36                	push   $0x36
  jmp alltraps
801072e0:	e9 f2 f8 ff ff       	jmp    80106bd7 <alltraps>

801072e5 <vector55>:
.globl vector55
vector55:
  pushl $0
801072e5:	6a 00                	push   $0x0
  pushl $55
801072e7:	6a 37                	push   $0x37
  jmp alltraps
801072e9:	e9 e9 f8 ff ff       	jmp    80106bd7 <alltraps>

801072ee <vector56>:
.globl vector56
vector56:
  pushl $0
801072ee:	6a 00                	push   $0x0
  pushl $56
801072f0:	6a 38                	push   $0x38
  jmp alltraps
801072f2:	e9 e0 f8 ff ff       	jmp    80106bd7 <alltraps>

801072f7 <vector57>:
.globl vector57
vector57:
  pushl $0
801072f7:	6a 00                	push   $0x0
  pushl $57
801072f9:	6a 39                	push   $0x39
  jmp alltraps
801072fb:	e9 d7 f8 ff ff       	jmp    80106bd7 <alltraps>

80107300 <vector58>:
.globl vector58
vector58:
  pushl $0
80107300:	6a 00                	push   $0x0
  pushl $58
80107302:	6a 3a                	push   $0x3a
  jmp alltraps
80107304:	e9 ce f8 ff ff       	jmp    80106bd7 <alltraps>

80107309 <vector59>:
.globl vector59
vector59:
  pushl $0
80107309:	6a 00                	push   $0x0
  pushl $59
8010730b:	6a 3b                	push   $0x3b
  jmp alltraps
8010730d:	e9 c5 f8 ff ff       	jmp    80106bd7 <alltraps>

80107312 <vector60>:
.globl vector60
vector60:
  pushl $0
80107312:	6a 00                	push   $0x0
  pushl $60
80107314:	6a 3c                	push   $0x3c
  jmp alltraps
80107316:	e9 bc f8 ff ff       	jmp    80106bd7 <alltraps>

8010731b <vector61>:
.globl vector61
vector61:
  pushl $0
8010731b:	6a 00                	push   $0x0
  pushl $61
8010731d:	6a 3d                	push   $0x3d
  jmp alltraps
8010731f:	e9 b3 f8 ff ff       	jmp    80106bd7 <alltraps>

80107324 <vector62>:
.globl vector62
vector62:
  pushl $0
80107324:	6a 00                	push   $0x0
  pushl $62
80107326:	6a 3e                	push   $0x3e
  jmp alltraps
80107328:	e9 aa f8 ff ff       	jmp    80106bd7 <alltraps>

8010732d <vector63>:
.globl vector63
vector63:
  pushl $0
8010732d:	6a 00                	push   $0x0
  pushl $63
8010732f:	6a 3f                	push   $0x3f
  jmp alltraps
80107331:	e9 a1 f8 ff ff       	jmp    80106bd7 <alltraps>

80107336 <vector64>:
.globl vector64
vector64:
  pushl $0
80107336:	6a 00                	push   $0x0
  pushl $64
80107338:	6a 40                	push   $0x40
  jmp alltraps
8010733a:	e9 98 f8 ff ff       	jmp    80106bd7 <alltraps>

8010733f <vector65>:
.globl vector65
vector65:
  pushl $0
8010733f:	6a 00                	push   $0x0
  pushl $65
80107341:	6a 41                	push   $0x41
  jmp alltraps
80107343:	e9 8f f8 ff ff       	jmp    80106bd7 <alltraps>

80107348 <vector66>:
.globl vector66
vector66:
  pushl $0
80107348:	6a 00                	push   $0x0
  pushl $66
8010734a:	6a 42                	push   $0x42
  jmp alltraps
8010734c:	e9 86 f8 ff ff       	jmp    80106bd7 <alltraps>

80107351 <vector67>:
.globl vector67
vector67:
  pushl $0
80107351:	6a 00                	push   $0x0
  pushl $67
80107353:	6a 43                	push   $0x43
  jmp alltraps
80107355:	e9 7d f8 ff ff       	jmp    80106bd7 <alltraps>

8010735a <vector68>:
.globl vector68
vector68:
  pushl $0
8010735a:	6a 00                	push   $0x0
  pushl $68
8010735c:	6a 44                	push   $0x44
  jmp alltraps
8010735e:	e9 74 f8 ff ff       	jmp    80106bd7 <alltraps>

80107363 <vector69>:
.globl vector69
vector69:
  pushl $0
80107363:	6a 00                	push   $0x0
  pushl $69
80107365:	6a 45                	push   $0x45
  jmp alltraps
80107367:	e9 6b f8 ff ff       	jmp    80106bd7 <alltraps>

8010736c <vector70>:
.globl vector70
vector70:
  pushl $0
8010736c:	6a 00                	push   $0x0
  pushl $70
8010736e:	6a 46                	push   $0x46
  jmp alltraps
80107370:	e9 62 f8 ff ff       	jmp    80106bd7 <alltraps>

80107375 <vector71>:
.globl vector71
vector71:
  pushl $0
80107375:	6a 00                	push   $0x0
  pushl $71
80107377:	6a 47                	push   $0x47
  jmp alltraps
80107379:	e9 59 f8 ff ff       	jmp    80106bd7 <alltraps>

8010737e <vector72>:
.globl vector72
vector72:
  pushl $0
8010737e:	6a 00                	push   $0x0
  pushl $72
80107380:	6a 48                	push   $0x48
  jmp alltraps
80107382:	e9 50 f8 ff ff       	jmp    80106bd7 <alltraps>

80107387 <vector73>:
.globl vector73
vector73:
  pushl $0
80107387:	6a 00                	push   $0x0
  pushl $73
80107389:	6a 49                	push   $0x49
  jmp alltraps
8010738b:	e9 47 f8 ff ff       	jmp    80106bd7 <alltraps>

80107390 <vector74>:
.globl vector74
vector74:
  pushl $0
80107390:	6a 00                	push   $0x0
  pushl $74
80107392:	6a 4a                	push   $0x4a
  jmp alltraps
80107394:	e9 3e f8 ff ff       	jmp    80106bd7 <alltraps>

80107399 <vector75>:
.globl vector75
vector75:
  pushl $0
80107399:	6a 00                	push   $0x0
  pushl $75
8010739b:	6a 4b                	push   $0x4b
  jmp alltraps
8010739d:	e9 35 f8 ff ff       	jmp    80106bd7 <alltraps>

801073a2 <vector76>:
.globl vector76
vector76:
  pushl $0
801073a2:	6a 00                	push   $0x0
  pushl $76
801073a4:	6a 4c                	push   $0x4c
  jmp alltraps
801073a6:	e9 2c f8 ff ff       	jmp    80106bd7 <alltraps>

801073ab <vector77>:
.globl vector77
vector77:
  pushl $0
801073ab:	6a 00                	push   $0x0
  pushl $77
801073ad:	6a 4d                	push   $0x4d
  jmp alltraps
801073af:	e9 23 f8 ff ff       	jmp    80106bd7 <alltraps>

801073b4 <vector78>:
.globl vector78
vector78:
  pushl $0
801073b4:	6a 00                	push   $0x0
  pushl $78
801073b6:	6a 4e                	push   $0x4e
  jmp alltraps
801073b8:	e9 1a f8 ff ff       	jmp    80106bd7 <alltraps>

801073bd <vector79>:
.globl vector79
vector79:
  pushl $0
801073bd:	6a 00                	push   $0x0
  pushl $79
801073bf:	6a 4f                	push   $0x4f
  jmp alltraps
801073c1:	e9 11 f8 ff ff       	jmp    80106bd7 <alltraps>

801073c6 <vector80>:
.globl vector80
vector80:
  pushl $0
801073c6:	6a 00                	push   $0x0
  pushl $80
801073c8:	6a 50                	push   $0x50
  jmp alltraps
801073ca:	e9 08 f8 ff ff       	jmp    80106bd7 <alltraps>

801073cf <vector81>:
.globl vector81
vector81:
  pushl $0
801073cf:	6a 00                	push   $0x0
  pushl $81
801073d1:	6a 51                	push   $0x51
  jmp alltraps
801073d3:	e9 ff f7 ff ff       	jmp    80106bd7 <alltraps>

801073d8 <vector82>:
.globl vector82
vector82:
  pushl $0
801073d8:	6a 00                	push   $0x0
  pushl $82
801073da:	6a 52                	push   $0x52
  jmp alltraps
801073dc:	e9 f6 f7 ff ff       	jmp    80106bd7 <alltraps>

801073e1 <vector83>:
.globl vector83
vector83:
  pushl $0
801073e1:	6a 00                	push   $0x0
  pushl $83
801073e3:	6a 53                	push   $0x53
  jmp alltraps
801073e5:	e9 ed f7 ff ff       	jmp    80106bd7 <alltraps>

801073ea <vector84>:
.globl vector84
vector84:
  pushl $0
801073ea:	6a 00                	push   $0x0
  pushl $84
801073ec:	6a 54                	push   $0x54
  jmp alltraps
801073ee:	e9 e4 f7 ff ff       	jmp    80106bd7 <alltraps>

801073f3 <vector85>:
.globl vector85
vector85:
  pushl $0
801073f3:	6a 00                	push   $0x0
  pushl $85
801073f5:	6a 55                	push   $0x55
  jmp alltraps
801073f7:	e9 db f7 ff ff       	jmp    80106bd7 <alltraps>

801073fc <vector86>:
.globl vector86
vector86:
  pushl $0
801073fc:	6a 00                	push   $0x0
  pushl $86
801073fe:	6a 56                	push   $0x56
  jmp alltraps
80107400:	e9 d2 f7 ff ff       	jmp    80106bd7 <alltraps>

80107405 <vector87>:
.globl vector87
vector87:
  pushl $0
80107405:	6a 00                	push   $0x0
  pushl $87
80107407:	6a 57                	push   $0x57
  jmp alltraps
80107409:	e9 c9 f7 ff ff       	jmp    80106bd7 <alltraps>

8010740e <vector88>:
.globl vector88
vector88:
  pushl $0
8010740e:	6a 00                	push   $0x0
  pushl $88
80107410:	6a 58                	push   $0x58
  jmp alltraps
80107412:	e9 c0 f7 ff ff       	jmp    80106bd7 <alltraps>

80107417 <vector89>:
.globl vector89
vector89:
  pushl $0
80107417:	6a 00                	push   $0x0
  pushl $89
80107419:	6a 59                	push   $0x59
  jmp alltraps
8010741b:	e9 b7 f7 ff ff       	jmp    80106bd7 <alltraps>

80107420 <vector90>:
.globl vector90
vector90:
  pushl $0
80107420:	6a 00                	push   $0x0
  pushl $90
80107422:	6a 5a                	push   $0x5a
  jmp alltraps
80107424:	e9 ae f7 ff ff       	jmp    80106bd7 <alltraps>

80107429 <vector91>:
.globl vector91
vector91:
  pushl $0
80107429:	6a 00                	push   $0x0
  pushl $91
8010742b:	6a 5b                	push   $0x5b
  jmp alltraps
8010742d:	e9 a5 f7 ff ff       	jmp    80106bd7 <alltraps>

80107432 <vector92>:
.globl vector92
vector92:
  pushl $0
80107432:	6a 00                	push   $0x0
  pushl $92
80107434:	6a 5c                	push   $0x5c
  jmp alltraps
80107436:	e9 9c f7 ff ff       	jmp    80106bd7 <alltraps>

8010743b <vector93>:
.globl vector93
vector93:
  pushl $0
8010743b:	6a 00                	push   $0x0
  pushl $93
8010743d:	6a 5d                	push   $0x5d
  jmp alltraps
8010743f:	e9 93 f7 ff ff       	jmp    80106bd7 <alltraps>

80107444 <vector94>:
.globl vector94
vector94:
  pushl $0
80107444:	6a 00                	push   $0x0
  pushl $94
80107446:	6a 5e                	push   $0x5e
  jmp alltraps
80107448:	e9 8a f7 ff ff       	jmp    80106bd7 <alltraps>

8010744d <vector95>:
.globl vector95
vector95:
  pushl $0
8010744d:	6a 00                	push   $0x0
  pushl $95
8010744f:	6a 5f                	push   $0x5f
  jmp alltraps
80107451:	e9 81 f7 ff ff       	jmp    80106bd7 <alltraps>

80107456 <vector96>:
.globl vector96
vector96:
  pushl $0
80107456:	6a 00                	push   $0x0
  pushl $96
80107458:	6a 60                	push   $0x60
  jmp alltraps
8010745a:	e9 78 f7 ff ff       	jmp    80106bd7 <alltraps>

8010745f <vector97>:
.globl vector97
vector97:
  pushl $0
8010745f:	6a 00                	push   $0x0
  pushl $97
80107461:	6a 61                	push   $0x61
  jmp alltraps
80107463:	e9 6f f7 ff ff       	jmp    80106bd7 <alltraps>

80107468 <vector98>:
.globl vector98
vector98:
  pushl $0
80107468:	6a 00                	push   $0x0
  pushl $98
8010746a:	6a 62                	push   $0x62
  jmp alltraps
8010746c:	e9 66 f7 ff ff       	jmp    80106bd7 <alltraps>

80107471 <vector99>:
.globl vector99
vector99:
  pushl $0
80107471:	6a 00                	push   $0x0
  pushl $99
80107473:	6a 63                	push   $0x63
  jmp alltraps
80107475:	e9 5d f7 ff ff       	jmp    80106bd7 <alltraps>

8010747a <vector100>:
.globl vector100
vector100:
  pushl $0
8010747a:	6a 00                	push   $0x0
  pushl $100
8010747c:	6a 64                	push   $0x64
  jmp alltraps
8010747e:	e9 54 f7 ff ff       	jmp    80106bd7 <alltraps>

80107483 <vector101>:
.globl vector101
vector101:
  pushl $0
80107483:	6a 00                	push   $0x0
  pushl $101
80107485:	6a 65                	push   $0x65
  jmp alltraps
80107487:	e9 4b f7 ff ff       	jmp    80106bd7 <alltraps>

8010748c <vector102>:
.globl vector102
vector102:
  pushl $0
8010748c:	6a 00                	push   $0x0
  pushl $102
8010748e:	6a 66                	push   $0x66
  jmp alltraps
80107490:	e9 42 f7 ff ff       	jmp    80106bd7 <alltraps>

80107495 <vector103>:
.globl vector103
vector103:
  pushl $0
80107495:	6a 00                	push   $0x0
  pushl $103
80107497:	6a 67                	push   $0x67
  jmp alltraps
80107499:	e9 39 f7 ff ff       	jmp    80106bd7 <alltraps>

8010749e <vector104>:
.globl vector104
vector104:
  pushl $0
8010749e:	6a 00                	push   $0x0
  pushl $104
801074a0:	6a 68                	push   $0x68
  jmp alltraps
801074a2:	e9 30 f7 ff ff       	jmp    80106bd7 <alltraps>

801074a7 <vector105>:
.globl vector105
vector105:
  pushl $0
801074a7:	6a 00                	push   $0x0
  pushl $105
801074a9:	6a 69                	push   $0x69
  jmp alltraps
801074ab:	e9 27 f7 ff ff       	jmp    80106bd7 <alltraps>

801074b0 <vector106>:
.globl vector106
vector106:
  pushl $0
801074b0:	6a 00                	push   $0x0
  pushl $106
801074b2:	6a 6a                	push   $0x6a
  jmp alltraps
801074b4:	e9 1e f7 ff ff       	jmp    80106bd7 <alltraps>

801074b9 <vector107>:
.globl vector107
vector107:
  pushl $0
801074b9:	6a 00                	push   $0x0
  pushl $107
801074bb:	6a 6b                	push   $0x6b
  jmp alltraps
801074bd:	e9 15 f7 ff ff       	jmp    80106bd7 <alltraps>

801074c2 <vector108>:
.globl vector108
vector108:
  pushl $0
801074c2:	6a 00                	push   $0x0
  pushl $108
801074c4:	6a 6c                	push   $0x6c
  jmp alltraps
801074c6:	e9 0c f7 ff ff       	jmp    80106bd7 <alltraps>

801074cb <vector109>:
.globl vector109
vector109:
  pushl $0
801074cb:	6a 00                	push   $0x0
  pushl $109
801074cd:	6a 6d                	push   $0x6d
  jmp alltraps
801074cf:	e9 03 f7 ff ff       	jmp    80106bd7 <alltraps>

801074d4 <vector110>:
.globl vector110
vector110:
  pushl $0
801074d4:	6a 00                	push   $0x0
  pushl $110
801074d6:	6a 6e                	push   $0x6e
  jmp alltraps
801074d8:	e9 fa f6 ff ff       	jmp    80106bd7 <alltraps>

801074dd <vector111>:
.globl vector111
vector111:
  pushl $0
801074dd:	6a 00                	push   $0x0
  pushl $111
801074df:	6a 6f                	push   $0x6f
  jmp alltraps
801074e1:	e9 f1 f6 ff ff       	jmp    80106bd7 <alltraps>

801074e6 <vector112>:
.globl vector112
vector112:
  pushl $0
801074e6:	6a 00                	push   $0x0
  pushl $112
801074e8:	6a 70                	push   $0x70
  jmp alltraps
801074ea:	e9 e8 f6 ff ff       	jmp    80106bd7 <alltraps>

801074ef <vector113>:
.globl vector113
vector113:
  pushl $0
801074ef:	6a 00                	push   $0x0
  pushl $113
801074f1:	6a 71                	push   $0x71
  jmp alltraps
801074f3:	e9 df f6 ff ff       	jmp    80106bd7 <alltraps>

801074f8 <vector114>:
.globl vector114
vector114:
  pushl $0
801074f8:	6a 00                	push   $0x0
  pushl $114
801074fa:	6a 72                	push   $0x72
  jmp alltraps
801074fc:	e9 d6 f6 ff ff       	jmp    80106bd7 <alltraps>

80107501 <vector115>:
.globl vector115
vector115:
  pushl $0
80107501:	6a 00                	push   $0x0
  pushl $115
80107503:	6a 73                	push   $0x73
  jmp alltraps
80107505:	e9 cd f6 ff ff       	jmp    80106bd7 <alltraps>

8010750a <vector116>:
.globl vector116
vector116:
  pushl $0
8010750a:	6a 00                	push   $0x0
  pushl $116
8010750c:	6a 74                	push   $0x74
  jmp alltraps
8010750e:	e9 c4 f6 ff ff       	jmp    80106bd7 <alltraps>

80107513 <vector117>:
.globl vector117
vector117:
  pushl $0
80107513:	6a 00                	push   $0x0
  pushl $117
80107515:	6a 75                	push   $0x75
  jmp alltraps
80107517:	e9 bb f6 ff ff       	jmp    80106bd7 <alltraps>

8010751c <vector118>:
.globl vector118
vector118:
  pushl $0
8010751c:	6a 00                	push   $0x0
  pushl $118
8010751e:	6a 76                	push   $0x76
  jmp alltraps
80107520:	e9 b2 f6 ff ff       	jmp    80106bd7 <alltraps>

80107525 <vector119>:
.globl vector119
vector119:
  pushl $0
80107525:	6a 00                	push   $0x0
  pushl $119
80107527:	6a 77                	push   $0x77
  jmp alltraps
80107529:	e9 a9 f6 ff ff       	jmp    80106bd7 <alltraps>

8010752e <vector120>:
.globl vector120
vector120:
  pushl $0
8010752e:	6a 00                	push   $0x0
  pushl $120
80107530:	6a 78                	push   $0x78
  jmp alltraps
80107532:	e9 a0 f6 ff ff       	jmp    80106bd7 <alltraps>

80107537 <vector121>:
.globl vector121
vector121:
  pushl $0
80107537:	6a 00                	push   $0x0
  pushl $121
80107539:	6a 79                	push   $0x79
  jmp alltraps
8010753b:	e9 97 f6 ff ff       	jmp    80106bd7 <alltraps>

80107540 <vector122>:
.globl vector122
vector122:
  pushl $0
80107540:	6a 00                	push   $0x0
  pushl $122
80107542:	6a 7a                	push   $0x7a
  jmp alltraps
80107544:	e9 8e f6 ff ff       	jmp    80106bd7 <alltraps>

80107549 <vector123>:
.globl vector123
vector123:
  pushl $0
80107549:	6a 00                	push   $0x0
  pushl $123
8010754b:	6a 7b                	push   $0x7b
  jmp alltraps
8010754d:	e9 85 f6 ff ff       	jmp    80106bd7 <alltraps>

80107552 <vector124>:
.globl vector124
vector124:
  pushl $0
80107552:	6a 00                	push   $0x0
  pushl $124
80107554:	6a 7c                	push   $0x7c
  jmp alltraps
80107556:	e9 7c f6 ff ff       	jmp    80106bd7 <alltraps>

8010755b <vector125>:
.globl vector125
vector125:
  pushl $0
8010755b:	6a 00                	push   $0x0
  pushl $125
8010755d:	6a 7d                	push   $0x7d
  jmp alltraps
8010755f:	e9 73 f6 ff ff       	jmp    80106bd7 <alltraps>

80107564 <vector126>:
.globl vector126
vector126:
  pushl $0
80107564:	6a 00                	push   $0x0
  pushl $126
80107566:	6a 7e                	push   $0x7e
  jmp alltraps
80107568:	e9 6a f6 ff ff       	jmp    80106bd7 <alltraps>

8010756d <vector127>:
.globl vector127
vector127:
  pushl $0
8010756d:	6a 00                	push   $0x0
  pushl $127
8010756f:	6a 7f                	push   $0x7f
  jmp alltraps
80107571:	e9 61 f6 ff ff       	jmp    80106bd7 <alltraps>

80107576 <vector128>:
.globl vector128
vector128:
  pushl $0
80107576:	6a 00                	push   $0x0
  pushl $128
80107578:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010757d:	e9 55 f6 ff ff       	jmp    80106bd7 <alltraps>

80107582 <vector129>:
.globl vector129
vector129:
  pushl $0
80107582:	6a 00                	push   $0x0
  pushl $129
80107584:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80107589:	e9 49 f6 ff ff       	jmp    80106bd7 <alltraps>

8010758e <vector130>:
.globl vector130
vector130:
  pushl $0
8010758e:	6a 00                	push   $0x0
  pushl $130
80107590:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80107595:	e9 3d f6 ff ff       	jmp    80106bd7 <alltraps>

8010759a <vector131>:
.globl vector131
vector131:
  pushl $0
8010759a:	6a 00                	push   $0x0
  pushl $131
8010759c:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801075a1:	e9 31 f6 ff ff       	jmp    80106bd7 <alltraps>

801075a6 <vector132>:
.globl vector132
vector132:
  pushl $0
801075a6:	6a 00                	push   $0x0
  pushl $132
801075a8:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801075ad:	e9 25 f6 ff ff       	jmp    80106bd7 <alltraps>

801075b2 <vector133>:
.globl vector133
vector133:
  pushl $0
801075b2:	6a 00                	push   $0x0
  pushl $133
801075b4:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801075b9:	e9 19 f6 ff ff       	jmp    80106bd7 <alltraps>

801075be <vector134>:
.globl vector134
vector134:
  pushl $0
801075be:	6a 00                	push   $0x0
  pushl $134
801075c0:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801075c5:	e9 0d f6 ff ff       	jmp    80106bd7 <alltraps>

801075ca <vector135>:
.globl vector135
vector135:
  pushl $0
801075ca:	6a 00                	push   $0x0
  pushl $135
801075cc:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801075d1:	e9 01 f6 ff ff       	jmp    80106bd7 <alltraps>

801075d6 <vector136>:
.globl vector136
vector136:
  pushl $0
801075d6:	6a 00                	push   $0x0
  pushl $136
801075d8:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801075dd:	e9 f5 f5 ff ff       	jmp    80106bd7 <alltraps>

801075e2 <vector137>:
.globl vector137
vector137:
  pushl $0
801075e2:	6a 00                	push   $0x0
  pushl $137
801075e4:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801075e9:	e9 e9 f5 ff ff       	jmp    80106bd7 <alltraps>

801075ee <vector138>:
.globl vector138
vector138:
  pushl $0
801075ee:	6a 00                	push   $0x0
  pushl $138
801075f0:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801075f5:	e9 dd f5 ff ff       	jmp    80106bd7 <alltraps>

801075fa <vector139>:
.globl vector139
vector139:
  pushl $0
801075fa:	6a 00                	push   $0x0
  pushl $139
801075fc:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80107601:	e9 d1 f5 ff ff       	jmp    80106bd7 <alltraps>

80107606 <vector140>:
.globl vector140
vector140:
  pushl $0
80107606:	6a 00                	push   $0x0
  pushl $140
80107608:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010760d:	e9 c5 f5 ff ff       	jmp    80106bd7 <alltraps>

80107612 <vector141>:
.globl vector141
vector141:
  pushl $0
80107612:	6a 00                	push   $0x0
  pushl $141
80107614:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80107619:	e9 b9 f5 ff ff       	jmp    80106bd7 <alltraps>

8010761e <vector142>:
.globl vector142
vector142:
  pushl $0
8010761e:	6a 00                	push   $0x0
  pushl $142
80107620:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80107625:	e9 ad f5 ff ff       	jmp    80106bd7 <alltraps>

8010762a <vector143>:
.globl vector143
vector143:
  pushl $0
8010762a:	6a 00                	push   $0x0
  pushl $143
8010762c:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80107631:	e9 a1 f5 ff ff       	jmp    80106bd7 <alltraps>

80107636 <vector144>:
.globl vector144
vector144:
  pushl $0
80107636:	6a 00                	push   $0x0
  pushl $144
80107638:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010763d:	e9 95 f5 ff ff       	jmp    80106bd7 <alltraps>

80107642 <vector145>:
.globl vector145
vector145:
  pushl $0
80107642:	6a 00                	push   $0x0
  pushl $145
80107644:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80107649:	e9 89 f5 ff ff       	jmp    80106bd7 <alltraps>

8010764e <vector146>:
.globl vector146
vector146:
  pushl $0
8010764e:	6a 00                	push   $0x0
  pushl $146
80107650:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107655:	e9 7d f5 ff ff       	jmp    80106bd7 <alltraps>

8010765a <vector147>:
.globl vector147
vector147:
  pushl $0
8010765a:	6a 00                	push   $0x0
  pushl $147
8010765c:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107661:	e9 71 f5 ff ff       	jmp    80106bd7 <alltraps>

80107666 <vector148>:
.globl vector148
vector148:
  pushl $0
80107666:	6a 00                	push   $0x0
  pushl $148
80107668:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010766d:	e9 65 f5 ff ff       	jmp    80106bd7 <alltraps>

80107672 <vector149>:
.globl vector149
vector149:
  pushl $0
80107672:	6a 00                	push   $0x0
  pushl $149
80107674:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80107679:	e9 59 f5 ff ff       	jmp    80106bd7 <alltraps>

8010767e <vector150>:
.globl vector150
vector150:
  pushl $0
8010767e:	6a 00                	push   $0x0
  pushl $150
80107680:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107685:	e9 4d f5 ff ff       	jmp    80106bd7 <alltraps>

8010768a <vector151>:
.globl vector151
vector151:
  pushl $0
8010768a:	6a 00                	push   $0x0
  pushl $151
8010768c:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80107691:	e9 41 f5 ff ff       	jmp    80106bd7 <alltraps>

80107696 <vector152>:
.globl vector152
vector152:
  pushl $0
80107696:	6a 00                	push   $0x0
  pushl $152
80107698:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010769d:	e9 35 f5 ff ff       	jmp    80106bd7 <alltraps>

801076a2 <vector153>:
.globl vector153
vector153:
  pushl $0
801076a2:	6a 00                	push   $0x0
  pushl $153
801076a4:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801076a9:	e9 29 f5 ff ff       	jmp    80106bd7 <alltraps>

801076ae <vector154>:
.globl vector154
vector154:
  pushl $0
801076ae:	6a 00                	push   $0x0
  pushl $154
801076b0:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801076b5:	e9 1d f5 ff ff       	jmp    80106bd7 <alltraps>

801076ba <vector155>:
.globl vector155
vector155:
  pushl $0
801076ba:	6a 00                	push   $0x0
  pushl $155
801076bc:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801076c1:	e9 11 f5 ff ff       	jmp    80106bd7 <alltraps>

801076c6 <vector156>:
.globl vector156
vector156:
  pushl $0
801076c6:	6a 00                	push   $0x0
  pushl $156
801076c8:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801076cd:	e9 05 f5 ff ff       	jmp    80106bd7 <alltraps>

801076d2 <vector157>:
.globl vector157
vector157:
  pushl $0
801076d2:	6a 00                	push   $0x0
  pushl $157
801076d4:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801076d9:	e9 f9 f4 ff ff       	jmp    80106bd7 <alltraps>

801076de <vector158>:
.globl vector158
vector158:
  pushl $0
801076de:	6a 00                	push   $0x0
  pushl $158
801076e0:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801076e5:	e9 ed f4 ff ff       	jmp    80106bd7 <alltraps>

801076ea <vector159>:
.globl vector159
vector159:
  pushl $0
801076ea:	6a 00                	push   $0x0
  pushl $159
801076ec:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801076f1:	e9 e1 f4 ff ff       	jmp    80106bd7 <alltraps>

801076f6 <vector160>:
.globl vector160
vector160:
  pushl $0
801076f6:	6a 00                	push   $0x0
  pushl $160
801076f8:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801076fd:	e9 d5 f4 ff ff       	jmp    80106bd7 <alltraps>

80107702 <vector161>:
.globl vector161
vector161:
  pushl $0
80107702:	6a 00                	push   $0x0
  pushl $161
80107704:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80107709:	e9 c9 f4 ff ff       	jmp    80106bd7 <alltraps>

8010770e <vector162>:
.globl vector162
vector162:
  pushl $0
8010770e:	6a 00                	push   $0x0
  pushl $162
80107710:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80107715:	e9 bd f4 ff ff       	jmp    80106bd7 <alltraps>

8010771a <vector163>:
.globl vector163
vector163:
  pushl $0
8010771a:	6a 00                	push   $0x0
  pushl $163
8010771c:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80107721:	e9 b1 f4 ff ff       	jmp    80106bd7 <alltraps>

80107726 <vector164>:
.globl vector164
vector164:
  pushl $0
80107726:	6a 00                	push   $0x0
  pushl $164
80107728:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010772d:	e9 a5 f4 ff ff       	jmp    80106bd7 <alltraps>

80107732 <vector165>:
.globl vector165
vector165:
  pushl $0
80107732:	6a 00                	push   $0x0
  pushl $165
80107734:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80107739:	e9 99 f4 ff ff       	jmp    80106bd7 <alltraps>

8010773e <vector166>:
.globl vector166
vector166:
  pushl $0
8010773e:	6a 00                	push   $0x0
  pushl $166
80107740:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107745:	e9 8d f4 ff ff       	jmp    80106bd7 <alltraps>

8010774a <vector167>:
.globl vector167
vector167:
  pushl $0
8010774a:	6a 00                	push   $0x0
  pushl $167
8010774c:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107751:	e9 81 f4 ff ff       	jmp    80106bd7 <alltraps>

80107756 <vector168>:
.globl vector168
vector168:
  pushl $0
80107756:	6a 00                	push   $0x0
  pushl $168
80107758:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010775d:	e9 75 f4 ff ff       	jmp    80106bd7 <alltraps>

80107762 <vector169>:
.globl vector169
vector169:
  pushl $0
80107762:	6a 00                	push   $0x0
  pushl $169
80107764:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80107769:	e9 69 f4 ff ff       	jmp    80106bd7 <alltraps>

8010776e <vector170>:
.globl vector170
vector170:
  pushl $0
8010776e:	6a 00                	push   $0x0
  pushl $170
80107770:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107775:	e9 5d f4 ff ff       	jmp    80106bd7 <alltraps>

8010777a <vector171>:
.globl vector171
vector171:
  pushl $0
8010777a:	6a 00                	push   $0x0
  pushl $171
8010777c:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107781:	e9 51 f4 ff ff       	jmp    80106bd7 <alltraps>

80107786 <vector172>:
.globl vector172
vector172:
  pushl $0
80107786:	6a 00                	push   $0x0
  pushl $172
80107788:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010778d:	e9 45 f4 ff ff       	jmp    80106bd7 <alltraps>

80107792 <vector173>:
.globl vector173
vector173:
  pushl $0
80107792:	6a 00                	push   $0x0
  pushl $173
80107794:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80107799:	e9 39 f4 ff ff       	jmp    80106bd7 <alltraps>

8010779e <vector174>:
.globl vector174
vector174:
  pushl $0
8010779e:	6a 00                	push   $0x0
  pushl $174
801077a0:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801077a5:	e9 2d f4 ff ff       	jmp    80106bd7 <alltraps>

801077aa <vector175>:
.globl vector175
vector175:
  pushl $0
801077aa:	6a 00                	push   $0x0
  pushl $175
801077ac:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801077b1:	e9 21 f4 ff ff       	jmp    80106bd7 <alltraps>

801077b6 <vector176>:
.globl vector176
vector176:
  pushl $0
801077b6:	6a 00                	push   $0x0
  pushl $176
801077b8:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801077bd:	e9 15 f4 ff ff       	jmp    80106bd7 <alltraps>

801077c2 <vector177>:
.globl vector177
vector177:
  pushl $0
801077c2:	6a 00                	push   $0x0
  pushl $177
801077c4:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801077c9:	e9 09 f4 ff ff       	jmp    80106bd7 <alltraps>

801077ce <vector178>:
.globl vector178
vector178:
  pushl $0
801077ce:	6a 00                	push   $0x0
  pushl $178
801077d0:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801077d5:	e9 fd f3 ff ff       	jmp    80106bd7 <alltraps>

801077da <vector179>:
.globl vector179
vector179:
  pushl $0
801077da:	6a 00                	push   $0x0
  pushl $179
801077dc:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801077e1:	e9 f1 f3 ff ff       	jmp    80106bd7 <alltraps>

801077e6 <vector180>:
.globl vector180
vector180:
  pushl $0
801077e6:	6a 00                	push   $0x0
  pushl $180
801077e8:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801077ed:	e9 e5 f3 ff ff       	jmp    80106bd7 <alltraps>

801077f2 <vector181>:
.globl vector181
vector181:
  pushl $0
801077f2:	6a 00                	push   $0x0
  pushl $181
801077f4:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801077f9:	e9 d9 f3 ff ff       	jmp    80106bd7 <alltraps>

801077fe <vector182>:
.globl vector182
vector182:
  pushl $0
801077fe:	6a 00                	push   $0x0
  pushl $182
80107800:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107805:	e9 cd f3 ff ff       	jmp    80106bd7 <alltraps>

8010780a <vector183>:
.globl vector183
vector183:
  pushl $0
8010780a:	6a 00                	push   $0x0
  pushl $183
8010780c:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107811:	e9 c1 f3 ff ff       	jmp    80106bd7 <alltraps>

80107816 <vector184>:
.globl vector184
vector184:
  pushl $0
80107816:	6a 00                	push   $0x0
  pushl $184
80107818:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010781d:	e9 b5 f3 ff ff       	jmp    80106bd7 <alltraps>

80107822 <vector185>:
.globl vector185
vector185:
  pushl $0
80107822:	6a 00                	push   $0x0
  pushl $185
80107824:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80107829:	e9 a9 f3 ff ff       	jmp    80106bd7 <alltraps>

8010782e <vector186>:
.globl vector186
vector186:
  pushl $0
8010782e:	6a 00                	push   $0x0
  pushl $186
80107830:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107835:	e9 9d f3 ff ff       	jmp    80106bd7 <alltraps>

8010783a <vector187>:
.globl vector187
vector187:
  pushl $0
8010783a:	6a 00                	push   $0x0
  pushl $187
8010783c:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107841:	e9 91 f3 ff ff       	jmp    80106bd7 <alltraps>

80107846 <vector188>:
.globl vector188
vector188:
  pushl $0
80107846:	6a 00                	push   $0x0
  pushl $188
80107848:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010784d:	e9 85 f3 ff ff       	jmp    80106bd7 <alltraps>

80107852 <vector189>:
.globl vector189
vector189:
  pushl $0
80107852:	6a 00                	push   $0x0
  pushl $189
80107854:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80107859:	e9 79 f3 ff ff       	jmp    80106bd7 <alltraps>

8010785e <vector190>:
.globl vector190
vector190:
  pushl $0
8010785e:	6a 00                	push   $0x0
  pushl $190
80107860:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107865:	e9 6d f3 ff ff       	jmp    80106bd7 <alltraps>

8010786a <vector191>:
.globl vector191
vector191:
  pushl $0
8010786a:	6a 00                	push   $0x0
  pushl $191
8010786c:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107871:	e9 61 f3 ff ff       	jmp    80106bd7 <alltraps>

80107876 <vector192>:
.globl vector192
vector192:
  pushl $0
80107876:	6a 00                	push   $0x0
  pushl $192
80107878:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010787d:	e9 55 f3 ff ff       	jmp    80106bd7 <alltraps>

80107882 <vector193>:
.globl vector193
vector193:
  pushl $0
80107882:	6a 00                	push   $0x0
  pushl $193
80107884:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80107889:	e9 49 f3 ff ff       	jmp    80106bd7 <alltraps>

8010788e <vector194>:
.globl vector194
vector194:
  pushl $0
8010788e:	6a 00                	push   $0x0
  pushl $194
80107890:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107895:	e9 3d f3 ff ff       	jmp    80106bd7 <alltraps>

8010789a <vector195>:
.globl vector195
vector195:
  pushl $0
8010789a:	6a 00                	push   $0x0
  pushl $195
8010789c:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801078a1:	e9 31 f3 ff ff       	jmp    80106bd7 <alltraps>

801078a6 <vector196>:
.globl vector196
vector196:
  pushl $0
801078a6:	6a 00                	push   $0x0
  pushl $196
801078a8:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801078ad:	e9 25 f3 ff ff       	jmp    80106bd7 <alltraps>

801078b2 <vector197>:
.globl vector197
vector197:
  pushl $0
801078b2:	6a 00                	push   $0x0
  pushl $197
801078b4:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801078b9:	e9 19 f3 ff ff       	jmp    80106bd7 <alltraps>

801078be <vector198>:
.globl vector198
vector198:
  pushl $0
801078be:	6a 00                	push   $0x0
  pushl $198
801078c0:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801078c5:	e9 0d f3 ff ff       	jmp    80106bd7 <alltraps>

801078ca <vector199>:
.globl vector199
vector199:
  pushl $0
801078ca:	6a 00                	push   $0x0
  pushl $199
801078cc:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801078d1:	e9 01 f3 ff ff       	jmp    80106bd7 <alltraps>

801078d6 <vector200>:
.globl vector200
vector200:
  pushl $0
801078d6:	6a 00                	push   $0x0
  pushl $200
801078d8:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801078dd:	e9 f5 f2 ff ff       	jmp    80106bd7 <alltraps>

801078e2 <vector201>:
.globl vector201
vector201:
  pushl $0
801078e2:	6a 00                	push   $0x0
  pushl $201
801078e4:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801078e9:	e9 e9 f2 ff ff       	jmp    80106bd7 <alltraps>

801078ee <vector202>:
.globl vector202
vector202:
  pushl $0
801078ee:	6a 00                	push   $0x0
  pushl $202
801078f0:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801078f5:	e9 dd f2 ff ff       	jmp    80106bd7 <alltraps>

801078fa <vector203>:
.globl vector203
vector203:
  pushl $0
801078fa:	6a 00                	push   $0x0
  pushl $203
801078fc:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107901:	e9 d1 f2 ff ff       	jmp    80106bd7 <alltraps>

80107906 <vector204>:
.globl vector204
vector204:
  pushl $0
80107906:	6a 00                	push   $0x0
  pushl $204
80107908:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010790d:	e9 c5 f2 ff ff       	jmp    80106bd7 <alltraps>

80107912 <vector205>:
.globl vector205
vector205:
  pushl $0
80107912:	6a 00                	push   $0x0
  pushl $205
80107914:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80107919:	e9 b9 f2 ff ff       	jmp    80106bd7 <alltraps>

8010791e <vector206>:
.globl vector206
vector206:
  pushl $0
8010791e:	6a 00                	push   $0x0
  pushl $206
80107920:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107925:	e9 ad f2 ff ff       	jmp    80106bd7 <alltraps>

8010792a <vector207>:
.globl vector207
vector207:
  pushl $0
8010792a:	6a 00                	push   $0x0
  pushl $207
8010792c:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107931:	e9 a1 f2 ff ff       	jmp    80106bd7 <alltraps>

80107936 <vector208>:
.globl vector208
vector208:
  pushl $0
80107936:	6a 00                	push   $0x0
  pushl $208
80107938:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010793d:	e9 95 f2 ff ff       	jmp    80106bd7 <alltraps>

80107942 <vector209>:
.globl vector209
vector209:
  pushl $0
80107942:	6a 00                	push   $0x0
  pushl $209
80107944:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80107949:	e9 89 f2 ff ff       	jmp    80106bd7 <alltraps>

8010794e <vector210>:
.globl vector210
vector210:
  pushl $0
8010794e:	6a 00                	push   $0x0
  pushl $210
80107950:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107955:	e9 7d f2 ff ff       	jmp    80106bd7 <alltraps>

8010795a <vector211>:
.globl vector211
vector211:
  pushl $0
8010795a:	6a 00                	push   $0x0
  pushl $211
8010795c:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107961:	e9 71 f2 ff ff       	jmp    80106bd7 <alltraps>

80107966 <vector212>:
.globl vector212
vector212:
  pushl $0
80107966:	6a 00                	push   $0x0
  pushl $212
80107968:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010796d:	e9 65 f2 ff ff       	jmp    80106bd7 <alltraps>

80107972 <vector213>:
.globl vector213
vector213:
  pushl $0
80107972:	6a 00                	push   $0x0
  pushl $213
80107974:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80107979:	e9 59 f2 ff ff       	jmp    80106bd7 <alltraps>

8010797e <vector214>:
.globl vector214
vector214:
  pushl $0
8010797e:	6a 00                	push   $0x0
  pushl $214
80107980:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107985:	e9 4d f2 ff ff       	jmp    80106bd7 <alltraps>

8010798a <vector215>:
.globl vector215
vector215:
  pushl $0
8010798a:	6a 00                	push   $0x0
  pushl $215
8010798c:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107991:	e9 41 f2 ff ff       	jmp    80106bd7 <alltraps>

80107996 <vector216>:
.globl vector216
vector216:
  pushl $0
80107996:	6a 00                	push   $0x0
  pushl $216
80107998:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010799d:	e9 35 f2 ff ff       	jmp    80106bd7 <alltraps>

801079a2 <vector217>:
.globl vector217
vector217:
  pushl $0
801079a2:	6a 00                	push   $0x0
  pushl $217
801079a4:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801079a9:	e9 29 f2 ff ff       	jmp    80106bd7 <alltraps>

801079ae <vector218>:
.globl vector218
vector218:
  pushl $0
801079ae:	6a 00                	push   $0x0
  pushl $218
801079b0:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801079b5:	e9 1d f2 ff ff       	jmp    80106bd7 <alltraps>

801079ba <vector219>:
.globl vector219
vector219:
  pushl $0
801079ba:	6a 00                	push   $0x0
  pushl $219
801079bc:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801079c1:	e9 11 f2 ff ff       	jmp    80106bd7 <alltraps>

801079c6 <vector220>:
.globl vector220
vector220:
  pushl $0
801079c6:	6a 00                	push   $0x0
  pushl $220
801079c8:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801079cd:	e9 05 f2 ff ff       	jmp    80106bd7 <alltraps>

801079d2 <vector221>:
.globl vector221
vector221:
  pushl $0
801079d2:	6a 00                	push   $0x0
  pushl $221
801079d4:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801079d9:	e9 f9 f1 ff ff       	jmp    80106bd7 <alltraps>

801079de <vector222>:
.globl vector222
vector222:
  pushl $0
801079de:	6a 00                	push   $0x0
  pushl $222
801079e0:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801079e5:	e9 ed f1 ff ff       	jmp    80106bd7 <alltraps>

801079ea <vector223>:
.globl vector223
vector223:
  pushl $0
801079ea:	6a 00                	push   $0x0
  pushl $223
801079ec:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801079f1:	e9 e1 f1 ff ff       	jmp    80106bd7 <alltraps>

801079f6 <vector224>:
.globl vector224
vector224:
  pushl $0
801079f6:	6a 00                	push   $0x0
  pushl $224
801079f8:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801079fd:	e9 d5 f1 ff ff       	jmp    80106bd7 <alltraps>

80107a02 <vector225>:
.globl vector225
vector225:
  pushl $0
80107a02:	6a 00                	push   $0x0
  pushl $225
80107a04:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107a09:	e9 c9 f1 ff ff       	jmp    80106bd7 <alltraps>

80107a0e <vector226>:
.globl vector226
vector226:
  pushl $0
80107a0e:	6a 00                	push   $0x0
  pushl $226
80107a10:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107a15:	e9 bd f1 ff ff       	jmp    80106bd7 <alltraps>

80107a1a <vector227>:
.globl vector227
vector227:
  pushl $0
80107a1a:	6a 00                	push   $0x0
  pushl $227
80107a1c:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107a21:	e9 b1 f1 ff ff       	jmp    80106bd7 <alltraps>

80107a26 <vector228>:
.globl vector228
vector228:
  pushl $0
80107a26:	6a 00                	push   $0x0
  pushl $228
80107a28:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80107a2d:	e9 a5 f1 ff ff       	jmp    80106bd7 <alltraps>

80107a32 <vector229>:
.globl vector229
vector229:
  pushl $0
80107a32:	6a 00                	push   $0x0
  pushl $229
80107a34:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80107a39:	e9 99 f1 ff ff       	jmp    80106bd7 <alltraps>

80107a3e <vector230>:
.globl vector230
vector230:
  pushl $0
80107a3e:	6a 00                	push   $0x0
  pushl $230
80107a40:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107a45:	e9 8d f1 ff ff       	jmp    80106bd7 <alltraps>

80107a4a <vector231>:
.globl vector231
vector231:
  pushl $0
80107a4a:	6a 00                	push   $0x0
  pushl $231
80107a4c:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107a51:	e9 81 f1 ff ff       	jmp    80106bd7 <alltraps>

80107a56 <vector232>:
.globl vector232
vector232:
  pushl $0
80107a56:	6a 00                	push   $0x0
  pushl $232
80107a58:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107a5d:	e9 75 f1 ff ff       	jmp    80106bd7 <alltraps>

80107a62 <vector233>:
.globl vector233
vector233:
  pushl $0
80107a62:	6a 00                	push   $0x0
  pushl $233
80107a64:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107a69:	e9 69 f1 ff ff       	jmp    80106bd7 <alltraps>

80107a6e <vector234>:
.globl vector234
vector234:
  pushl $0
80107a6e:	6a 00                	push   $0x0
  pushl $234
80107a70:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107a75:	e9 5d f1 ff ff       	jmp    80106bd7 <alltraps>

80107a7a <vector235>:
.globl vector235
vector235:
  pushl $0
80107a7a:	6a 00                	push   $0x0
  pushl $235
80107a7c:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107a81:	e9 51 f1 ff ff       	jmp    80106bd7 <alltraps>

80107a86 <vector236>:
.globl vector236
vector236:
  pushl $0
80107a86:	6a 00                	push   $0x0
  pushl $236
80107a88:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107a8d:	e9 45 f1 ff ff       	jmp    80106bd7 <alltraps>

80107a92 <vector237>:
.globl vector237
vector237:
  pushl $0
80107a92:	6a 00                	push   $0x0
  pushl $237
80107a94:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107a99:	e9 39 f1 ff ff       	jmp    80106bd7 <alltraps>

80107a9e <vector238>:
.globl vector238
vector238:
  pushl $0
80107a9e:	6a 00                	push   $0x0
  pushl $238
80107aa0:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107aa5:	e9 2d f1 ff ff       	jmp    80106bd7 <alltraps>

80107aaa <vector239>:
.globl vector239
vector239:
  pushl $0
80107aaa:	6a 00                	push   $0x0
  pushl $239
80107aac:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107ab1:	e9 21 f1 ff ff       	jmp    80106bd7 <alltraps>

80107ab6 <vector240>:
.globl vector240
vector240:
  pushl $0
80107ab6:	6a 00                	push   $0x0
  pushl $240
80107ab8:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107abd:	e9 15 f1 ff ff       	jmp    80106bd7 <alltraps>

80107ac2 <vector241>:
.globl vector241
vector241:
  pushl $0
80107ac2:	6a 00                	push   $0x0
  pushl $241
80107ac4:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107ac9:	e9 09 f1 ff ff       	jmp    80106bd7 <alltraps>

80107ace <vector242>:
.globl vector242
vector242:
  pushl $0
80107ace:	6a 00                	push   $0x0
  pushl $242
80107ad0:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107ad5:	e9 fd f0 ff ff       	jmp    80106bd7 <alltraps>

80107ada <vector243>:
.globl vector243
vector243:
  pushl $0
80107ada:	6a 00                	push   $0x0
  pushl $243
80107adc:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107ae1:	e9 f1 f0 ff ff       	jmp    80106bd7 <alltraps>

80107ae6 <vector244>:
.globl vector244
vector244:
  pushl $0
80107ae6:	6a 00                	push   $0x0
  pushl $244
80107ae8:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107aed:	e9 e5 f0 ff ff       	jmp    80106bd7 <alltraps>

80107af2 <vector245>:
.globl vector245
vector245:
  pushl $0
80107af2:	6a 00                	push   $0x0
  pushl $245
80107af4:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107af9:	e9 d9 f0 ff ff       	jmp    80106bd7 <alltraps>

80107afe <vector246>:
.globl vector246
vector246:
  pushl $0
80107afe:	6a 00                	push   $0x0
  pushl $246
80107b00:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107b05:	e9 cd f0 ff ff       	jmp    80106bd7 <alltraps>

80107b0a <vector247>:
.globl vector247
vector247:
  pushl $0
80107b0a:	6a 00                	push   $0x0
  pushl $247
80107b0c:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107b11:	e9 c1 f0 ff ff       	jmp    80106bd7 <alltraps>

80107b16 <vector248>:
.globl vector248
vector248:
  pushl $0
80107b16:	6a 00                	push   $0x0
  pushl $248
80107b18:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107b1d:	e9 b5 f0 ff ff       	jmp    80106bd7 <alltraps>

80107b22 <vector249>:
.globl vector249
vector249:
  pushl $0
80107b22:	6a 00                	push   $0x0
  pushl $249
80107b24:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107b29:	e9 a9 f0 ff ff       	jmp    80106bd7 <alltraps>

80107b2e <vector250>:
.globl vector250
vector250:
  pushl $0
80107b2e:	6a 00                	push   $0x0
  pushl $250
80107b30:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107b35:	e9 9d f0 ff ff       	jmp    80106bd7 <alltraps>

80107b3a <vector251>:
.globl vector251
vector251:
  pushl $0
80107b3a:	6a 00                	push   $0x0
  pushl $251
80107b3c:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107b41:	e9 91 f0 ff ff       	jmp    80106bd7 <alltraps>

80107b46 <vector252>:
.globl vector252
vector252:
  pushl $0
80107b46:	6a 00                	push   $0x0
  pushl $252
80107b48:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107b4d:	e9 85 f0 ff ff       	jmp    80106bd7 <alltraps>

80107b52 <vector253>:
.globl vector253
vector253:
  pushl $0
80107b52:	6a 00                	push   $0x0
  pushl $253
80107b54:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107b59:	e9 79 f0 ff ff       	jmp    80106bd7 <alltraps>

80107b5e <vector254>:
.globl vector254
vector254:
  pushl $0
80107b5e:	6a 00                	push   $0x0
  pushl $254
80107b60:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107b65:	e9 6d f0 ff ff       	jmp    80106bd7 <alltraps>

80107b6a <vector255>:
.globl vector255
vector255:
  pushl $0
80107b6a:	6a 00                	push   $0x0
  pushl $255
80107b6c:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107b71:	e9 61 f0 ff ff       	jmp    80106bd7 <alltraps>
80107b76:	66 90                	xchg   %ax,%ax
80107b78:	66 90                	xchg   %ax,%ax
80107b7a:	66 90                	xchg   %ax,%ax
80107b7c:	66 90                	xchg   %ax,%ax
80107b7e:	66 90                	xchg   %ax,%ax

80107b80 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107b80:	55                   	push   %ebp
80107b81:	89 e5                	mov    %esp,%ebp
80107b83:	83 ec 28             	sub    $0x28,%esp
80107b86:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107b89:	89 d3                	mov    %edx,%ebx
80107b8b:	c1 eb 16             	shr    $0x16,%ebx
{
80107b8e:	89 75 f8             	mov    %esi,-0x8(%ebp)
  pde = &pgdir[PDX(va)];
80107b91:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80107b94:	89 7d fc             	mov    %edi,-0x4(%ebp)
80107b97:	89 d7                	mov    %edx,%edi
  if(*pde & PTE_P){
80107b99:	8b 06                	mov    (%esi),%eax
80107b9b:	a8 01                	test   $0x1,%al
80107b9d:	74 29                	je     80107bc8 <walkpgdir+0x48>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107b9f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107ba4:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107baa:	c1 ef 0a             	shr    $0xa,%edi
}
80107bad:	8b 75 f8             	mov    -0x8(%ebp),%esi
  return &pgtab[PTX(va)];
80107bb0:	89 fa                	mov    %edi,%edx
}
80107bb2:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return &pgtab[PTX(va)];
80107bb5:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107bbb:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80107bbe:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107bc1:	89 ec                	mov    %ebp,%esp
80107bc3:	5d                   	pop    %ebp
80107bc4:	c3                   	ret    
80107bc5:	8d 76 00             	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107bc8:	85 c9                	test   %ecx,%ecx
80107bca:	74 34                	je     80107c00 <walkpgdir+0x80>
80107bcc:	e8 df a9 ff ff       	call   801025b0 <kalloc>
80107bd1:	85 c0                	test   %eax,%eax
80107bd3:	89 c3                	mov    %eax,%ebx
80107bd5:	74 29                	je     80107c00 <walkpgdir+0x80>
    memset(pgtab, 0, PGSIZE);
80107bd7:	b8 00 10 00 00       	mov    $0x1000,%eax
80107bdc:	31 d2                	xor    %edx,%edx
80107bde:	89 44 24 08          	mov    %eax,0x8(%esp)
80107be2:	89 54 24 04          	mov    %edx,0x4(%esp)
80107be6:	89 1c 24             	mov    %ebx,(%esp)
80107be9:	e8 72 dd ff ff       	call   80105960 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107bee:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107bf4:	83 c8 07             	or     $0x7,%eax
80107bf7:	89 06                	mov    %eax,(%esi)
80107bf9:	eb af                	jmp    80107baa <walkpgdir+0x2a>
80107bfb:	90                   	nop
80107bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80107c00:	8b 5d f4             	mov    -0xc(%ebp),%ebx
      return 0;
80107c03:	31 c0                	xor    %eax,%eax
}
80107c05:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107c08:	8b 7d fc             	mov    -0x4(%ebp),%edi
80107c0b:	89 ec                	mov    %ebp,%esp
80107c0d:	5d                   	pop    %ebp
80107c0e:	c3                   	ret    
80107c0f:	90                   	nop

80107c10 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107c10:	55                   	push   %ebp
80107c11:	89 e5                	mov    %esp,%ebp
80107c13:	57                   	push   %edi
80107c14:	56                   	push   %esi
80107c15:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107c16:	89 d3                	mov    %edx,%ebx
{
80107c18:	83 ec 2c             	sub    $0x2c,%esp
  a = (char*)PGROUNDDOWN((uint)va);
80107c1b:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80107c21:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107c24:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107c28:	8b 7d 08             	mov    0x8(%ebp),%edi
80107c2b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107c30:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80107c33:	8b 45 0c             	mov    0xc(%ebp),%eax
80107c36:	29 df                	sub    %ebx,%edi
80107c38:	83 c8 01             	or     $0x1,%eax
80107c3b:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107c3e:	eb 17                	jmp    80107c57 <mappages+0x47>
    if(*pte & PTE_P)
80107c40:	f6 00 01             	testb  $0x1,(%eax)
80107c43:	75 45                	jne    80107c8a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80107c45:	8b 55 dc             	mov    -0x24(%ebp),%edx
80107c48:	09 d6                	or     %edx,%esi
    if(a == last)
80107c4a:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
80107c4d:	89 30                	mov    %esi,(%eax)
    if(a == last)
80107c4f:	74 2f                	je     80107c80 <mappages+0x70>
      break;
    a += PGSIZE;
80107c51:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107c57:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107c5a:	b9 01 00 00 00       	mov    $0x1,%ecx
80107c5f:	89 da                	mov    %ebx,%edx
80107c61:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80107c64:	e8 17 ff ff ff       	call   80107b80 <walkpgdir>
80107c69:	85 c0                	test   %eax,%eax
80107c6b:	75 d3                	jne    80107c40 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80107c6d:	83 c4 2c             	add    $0x2c,%esp
      return -1;
80107c70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107c75:	5b                   	pop    %ebx
80107c76:	5e                   	pop    %esi
80107c77:	5f                   	pop    %edi
80107c78:	5d                   	pop    %ebp
80107c79:	c3                   	ret    
80107c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107c80:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80107c83:	31 c0                	xor    %eax,%eax
}
80107c85:	5b                   	pop    %ebx
80107c86:	5e                   	pop    %esi
80107c87:	5f                   	pop    %edi
80107c88:	5d                   	pop    %ebp
80107c89:	c3                   	ret    
      panic("remap");
80107c8a:	c7 04 24 0c 8e 10 80 	movl   $0x80108e0c,(%esp)
80107c91:	e8 da 86 ff ff       	call   80100370 <panic>
80107c96:	8d 76 00             	lea    0x0(%esi),%esi
80107c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107ca0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107ca0:	55                   	push   %ebp
80107ca1:	89 e5                	mov    %esp,%ebp
80107ca3:	57                   	push   %edi
80107ca4:	89 c7                	mov    %eax,%edi
80107ca6:	56                   	push   %esi
80107ca7:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107ca8:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107cae:	83 ec 2c             	sub    $0x2c,%esp
  a = PGROUNDUP(newsz);
80107cb1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107cb7:	39 d3                	cmp    %edx,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107cb9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107cbc:	73 62                	jae    80107d20 <deallocuvm.part.0+0x80>
80107cbe:	89 d6                	mov    %edx,%esi
80107cc0:	eb 39                	jmp    80107cfb <deallocuvm.part.0+0x5b>
80107cc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80107cc8:	8b 10                	mov    (%eax),%edx
80107cca:	f6 c2 01             	test   $0x1,%dl
80107ccd:	74 22                	je     80107cf1 <deallocuvm.part.0+0x51>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80107ccf:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107cd5:	74 54                	je     80107d2b <deallocuvm.part.0+0x8b>
        panic("kfree");
      char *v = P2V(pa);
80107cd7:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
80107cdd:	89 14 24             	mov    %edx,(%esp)
80107ce0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107ce3:	e8 f8 a6 ff ff       	call   801023e0 <kfree>
      *pte = 0;
80107ce8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107ceb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80107cf1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107cf7:	39 f3                	cmp    %esi,%ebx
80107cf9:	73 25                	jae    80107d20 <deallocuvm.part.0+0x80>
    pte = walkpgdir(pgdir, (char*)a, 0);
80107cfb:	31 c9                	xor    %ecx,%ecx
80107cfd:	89 da                	mov    %ebx,%edx
80107cff:	89 f8                	mov    %edi,%eax
80107d01:	e8 7a fe ff ff       	call   80107b80 <walkpgdir>
    if(!pte)
80107d06:	85 c0                	test   %eax,%eax
80107d08:	75 be                	jne    80107cc8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107d0a:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80107d10:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107d16:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107d1c:	39 f3                	cmp    %esi,%ebx
80107d1e:	72 db                	jb     80107cfb <deallocuvm.part.0+0x5b>
    }
  }
  return newsz;
}
80107d20:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107d23:	83 c4 2c             	add    $0x2c,%esp
80107d26:	5b                   	pop    %ebx
80107d27:	5e                   	pop    %esi
80107d28:	5f                   	pop    %edi
80107d29:	5d                   	pop    %ebp
80107d2a:	c3                   	ret    
        panic("kfree");
80107d2b:	c7 04 24 46 87 10 80 	movl   $0x80108746,(%esp)
80107d32:	e8 39 86 ff ff       	call   80100370 <panic>
80107d37:	89 f6                	mov    %esi,%esi
80107d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107d40 <seginit>:
{
80107d40:	55                   	push   %ebp
80107d41:	89 e5                	mov    %esp,%ebp
80107d43:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107d46:	e8 b5 bc ff ff       	call   80103a00 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107d4b:	b9 00 9a cf 00       	mov    $0xcf9a00,%ecx
  pd[0] = size-1;
80107d50:	66 c7 45 f2 2f 00    	movw   $0x2f,-0xe(%ebp)
80107d56:	8d 14 80             	lea    (%eax,%eax,4),%edx
80107d59:	8d 04 50             	lea    (%eax,%edx,2),%eax
80107d5c:	ba ff ff 00 00       	mov    $0xffff,%edx
80107d61:	c1 e0 04             	shl    $0x4,%eax
80107d64:	89 90 58 38 11 80    	mov    %edx,-0x7feec7a8(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107d6a:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107d6f:	89 88 5c 38 11 80    	mov    %ecx,-0x7feec7a4(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107d75:	b9 00 92 cf 00       	mov    $0xcf9200,%ecx
80107d7a:	89 90 60 38 11 80    	mov    %edx,-0x7feec7a0(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107d80:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107d85:	89 88 64 38 11 80    	mov    %ecx,-0x7feec79c(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107d8b:	b9 00 fa cf 00       	mov    $0xcffa00,%ecx
80107d90:	89 90 68 38 11 80    	mov    %edx,-0x7feec798(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107d96:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107d9b:	89 88 6c 38 11 80    	mov    %ecx,-0x7feec794(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107da1:	b9 00 f2 cf 00       	mov    $0xcff200,%ecx
80107da6:	89 90 70 38 11 80    	mov    %edx,-0x7feec790(%eax)
80107dac:	89 88 74 38 11 80    	mov    %ecx,-0x7feec78c(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80107db2:	05 50 38 11 80       	add    $0x80113850,%eax
  pd[1] = (uint)p;
80107db7:	0f b7 d0             	movzwl %ax,%edx
  pd[2] = (uint)p >> 16;
80107dba:	c1 e8 10             	shr    $0x10,%eax
  pd[1] = (uint)p;
80107dbd:	66 89 55 f4          	mov    %dx,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107dc1:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80107dc5:	8d 45 f2             	lea    -0xe(%ebp),%eax
80107dc8:	0f 01 10             	lgdtl  (%eax)
}
80107dcb:	c9                   	leave  
80107dcc:	c3                   	ret    
80107dcd:	8d 76 00             	lea    0x0(%esi),%esi

80107dd0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107dd0:	a1 04 6f 11 80       	mov    0x80116f04,%eax
{
80107dd5:	55                   	push   %ebp
80107dd6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107dd8:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107ddd:	0f 22 d8             	mov    %eax,%cr3
}
80107de0:	5d                   	pop    %ebp
80107de1:	c3                   	ret    
80107de2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107df0 <switchuvm>:
{
80107df0:	55                   	push   %ebp
80107df1:	89 e5                	mov    %esp,%ebp
80107df3:	57                   	push   %edi
80107df4:	56                   	push   %esi
80107df5:	53                   	push   %ebx
80107df6:	83 ec 2c             	sub    $0x2c,%esp
80107df9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
80107dfc:	85 db                	test   %ebx,%ebx
80107dfe:	0f 84 c5 00 00 00    	je     80107ec9 <switchuvm+0xd9>
  if(p->kstack == 0)
80107e04:	8b 7b 08             	mov    0x8(%ebx),%edi
80107e07:	85 ff                	test   %edi,%edi
80107e09:	0f 84 d2 00 00 00    	je     80107ee1 <switchuvm+0xf1>
  if(p->pgdir == 0)
80107e0f:	8b 73 04             	mov    0x4(%ebx),%esi
80107e12:	85 f6                	test   %esi,%esi
80107e14:	0f 84 bb 00 00 00    	je     80107ed5 <switchuvm+0xe5>
  pushcli();
80107e1a:	e8 71 d9 ff ff       	call   80105790 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107e1f:	e8 5c bb ff ff       	call   80103980 <mycpu>
80107e24:	89 c6                	mov    %eax,%esi
80107e26:	e8 55 bb ff ff       	call   80103980 <mycpu>
80107e2b:	89 c7                	mov    %eax,%edi
80107e2d:	e8 4e bb ff ff       	call   80103980 <mycpu>
80107e32:	83 c7 08             	add    $0x8,%edi
80107e35:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107e38:	e8 43 bb ff ff       	call   80103980 <mycpu>
80107e3d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107e40:	ba 67 00 00 00       	mov    $0x67,%edx
80107e45:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80107e4c:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80107e53:	83 c1 08             	add    $0x8,%ecx
80107e56:	c1 e9 10             	shr    $0x10,%ecx
80107e59:	83 c0 08             	add    $0x8,%eax
80107e5c:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80107e62:	c1 e8 18             	shr    $0x18,%eax
80107e65:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107e6a:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
80107e71:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->gdt[SEG_TSS].s = 0;
80107e77:	e8 04 bb ff ff       	call   80103980 <mycpu>
80107e7c:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107e83:	e8 f8 ba ff ff       	call   80103980 <mycpu>
80107e88:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107e8e:	8b 73 08             	mov    0x8(%ebx),%esi
80107e91:	e8 ea ba ff ff       	call   80103980 <mycpu>
80107e96:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107e9c:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107e9f:	e8 dc ba ff ff       	call   80103980 <mycpu>
80107ea4:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107eaa:	b8 28 00 00 00       	mov    $0x28,%eax
80107eaf:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107eb2:	8b 43 04             	mov    0x4(%ebx),%eax
80107eb5:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107eba:	0f 22 d8             	mov    %eax,%cr3
}
80107ebd:	83 c4 2c             	add    $0x2c,%esp
80107ec0:	5b                   	pop    %ebx
80107ec1:	5e                   	pop    %esi
80107ec2:	5f                   	pop    %edi
80107ec3:	5d                   	pop    %ebp
  popcli();
80107ec4:	e9 07 d9 ff ff       	jmp    801057d0 <popcli>
    panic("switchuvm: no process");
80107ec9:	c7 04 24 12 8e 10 80 	movl   $0x80108e12,(%esp)
80107ed0:	e8 9b 84 ff ff       	call   80100370 <panic>
    panic("switchuvm: no pgdir");
80107ed5:	c7 04 24 3d 8e 10 80 	movl   $0x80108e3d,(%esp)
80107edc:	e8 8f 84 ff ff       	call   80100370 <panic>
    panic("switchuvm: no kstack");
80107ee1:	c7 04 24 28 8e 10 80 	movl   $0x80108e28,(%esp)
80107ee8:	e8 83 84 ff ff       	call   80100370 <panic>
80107eed:	8d 76 00             	lea    0x0(%esi),%esi

80107ef0 <inituvm>:
{
80107ef0:	55                   	push   %ebp
80107ef1:	89 e5                	mov    %esp,%ebp
80107ef3:	83 ec 38             	sub    $0x38,%esp
80107ef6:	89 75 f8             	mov    %esi,-0x8(%ebp)
80107ef9:	8b 75 10             	mov    0x10(%ebp),%esi
80107efc:	8b 45 08             	mov    0x8(%ebp),%eax
80107eff:	89 7d fc             	mov    %edi,-0x4(%ebp)
80107f02:	8b 7d 0c             	mov    0xc(%ebp),%edi
80107f05:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  if(sz >= PGSIZE)
80107f08:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80107f0e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107f11:	77 59                	ja     80107f6c <inituvm+0x7c>
  mem = kalloc();
80107f13:	e8 98 a6 ff ff       	call   801025b0 <kalloc>
  memset(mem, 0, PGSIZE);
80107f18:	31 d2                	xor    %edx,%edx
80107f1a:	89 54 24 04          	mov    %edx,0x4(%esp)
  mem = kalloc();
80107f1e:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107f20:	b8 00 10 00 00       	mov    $0x1000,%eax
80107f25:	89 1c 24             	mov    %ebx,(%esp)
80107f28:	89 44 24 08          	mov    %eax,0x8(%esp)
80107f2c:	e8 2f da ff ff       	call   80105960 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107f31:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107f37:	b9 06 00 00 00       	mov    $0x6,%ecx
80107f3c:	89 04 24             	mov    %eax,(%esp)
80107f3f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107f42:	31 d2                	xor    %edx,%edx
80107f44:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80107f48:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107f4d:	e8 be fc ff ff       	call   80107c10 <mappages>
  memmove(mem, init, sz);
80107f52:	89 75 10             	mov    %esi,0x10(%ebp)
}
80107f55:	8b 75 f8             	mov    -0x8(%ebp),%esi
  memmove(mem, init, sz);
80107f58:	89 7d 0c             	mov    %edi,0xc(%ebp)
}
80107f5b:	8b 7d fc             	mov    -0x4(%ebp),%edi
  memmove(mem, init, sz);
80107f5e:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80107f61:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107f64:	89 ec                	mov    %ebp,%esp
80107f66:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107f67:	e9 b4 da ff ff       	jmp    80105a20 <memmove>
    panic("inituvm: more than a page");
80107f6c:	c7 04 24 51 8e 10 80 	movl   $0x80108e51,(%esp)
80107f73:	e8 f8 83 ff ff       	call   80100370 <panic>
80107f78:	90                   	nop
80107f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107f80 <loaduvm>:
{
80107f80:	55                   	push   %ebp
80107f81:	89 e5                	mov    %esp,%ebp
80107f83:	57                   	push   %edi
80107f84:	56                   	push   %esi
80107f85:	53                   	push   %ebx
80107f86:	83 ec 1c             	sub    $0x1c,%esp
  if((uint) addr % PGSIZE != 0)
80107f89:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107f90:	0f 85 98 00 00 00    	jne    8010802e <loaduvm+0xae>
  for(i = 0; i < sz; i += PGSIZE){
80107f96:	8b 75 18             	mov    0x18(%ebp),%esi
80107f99:	31 db                	xor    %ebx,%ebx
80107f9b:	85 f6                	test   %esi,%esi
80107f9d:	75 1a                	jne    80107fb9 <loaduvm+0x39>
80107f9f:	eb 77                	jmp    80108018 <loaduvm+0x98>
80107fa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107fa8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107fae:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80107fb4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80107fb7:	76 5f                	jbe    80108018 <loaduvm+0x98>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107fb9:	8b 55 0c             	mov    0xc(%ebp),%edx
80107fbc:	31 c9                	xor    %ecx,%ecx
80107fbe:	8b 45 08             	mov    0x8(%ebp),%eax
80107fc1:	01 da                	add    %ebx,%edx
80107fc3:	e8 b8 fb ff ff       	call   80107b80 <walkpgdir>
80107fc8:	85 c0                	test   %eax,%eax
80107fca:	74 56                	je     80108022 <loaduvm+0xa2>
    pa = PTE_ADDR(*pte);
80107fcc:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
80107fce:	bf 00 10 00 00       	mov    $0x1000,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107fd3:	8b 4d 14             	mov    0x14(%ebp),%ecx
    pa = PTE_ADDR(*pte);
80107fd6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80107fdb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80107fe1:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107fe4:	05 00 00 00 80       	add    $0x80000000,%eax
80107fe9:	89 44 24 04          	mov    %eax,0x4(%esp)
80107fed:	8b 45 10             	mov    0x10(%ebp),%eax
80107ff0:	01 d9                	add    %ebx,%ecx
80107ff2:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80107ff6:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80107ffa:	89 04 24             	mov    %eax,(%esp)
80107ffd:	e8 ce 99 ff ff       	call   801019d0 <readi>
80108002:	39 f8                	cmp    %edi,%eax
80108004:	74 a2                	je     80107fa8 <loaduvm+0x28>
}
80108006:	83 c4 1c             	add    $0x1c,%esp
      return -1;
80108009:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010800e:	5b                   	pop    %ebx
8010800f:	5e                   	pop    %esi
80108010:	5f                   	pop    %edi
80108011:	5d                   	pop    %ebp
80108012:	c3                   	ret    
80108013:	90                   	nop
80108014:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108018:	83 c4 1c             	add    $0x1c,%esp
  return 0;
8010801b:	31 c0                	xor    %eax,%eax
}
8010801d:	5b                   	pop    %ebx
8010801e:	5e                   	pop    %esi
8010801f:	5f                   	pop    %edi
80108020:	5d                   	pop    %ebp
80108021:	c3                   	ret    
      panic("loaduvm: address should exist");
80108022:	c7 04 24 6b 8e 10 80 	movl   $0x80108e6b,(%esp)
80108029:	e8 42 83 ff ff       	call   80100370 <panic>
    panic("loaduvm: addr must be page aligned");
8010802e:	c7 04 24 0c 8f 10 80 	movl   $0x80108f0c,(%esp)
80108035:	e8 36 83 ff ff       	call   80100370 <panic>
8010803a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108040 <allocuvm>:
{
80108040:	55                   	push   %ebp
80108041:	89 e5                	mov    %esp,%ebp
80108043:	57                   	push   %edi
80108044:	56                   	push   %esi
80108045:	53                   	push   %ebx
80108046:	83 ec 2c             	sub    $0x2c,%esp
  if(newsz >= KERNBASE)
80108049:	8b 7d 10             	mov    0x10(%ebp),%edi
8010804c:	85 ff                	test   %edi,%edi
8010804e:	0f 88 91 00 00 00    	js     801080e5 <allocuvm+0xa5>
  if(newsz < oldsz)
80108054:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80108057:	0f 82 9b 00 00 00    	jb     801080f8 <allocuvm+0xb8>
  a = PGROUNDUP(oldsz);
8010805d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108060:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80108066:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010806c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010806f:	0f 86 86 00 00 00    	jbe    801080fb <allocuvm+0xbb>
80108075:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80108078:	8b 7d 08             	mov    0x8(%ebp),%edi
8010807b:	eb 49                	jmp    801080c6 <allocuvm+0x86>
8010807d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80108080:	31 d2                	xor    %edx,%edx
80108082:	b8 00 10 00 00       	mov    $0x1000,%eax
80108087:	89 54 24 04          	mov    %edx,0x4(%esp)
8010808b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010808f:	89 34 24             	mov    %esi,(%esp)
80108092:	e8 c9 d8 ff ff       	call   80105960 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80108097:	b9 06 00 00 00       	mov    $0x6,%ecx
8010809c:	89 da                	mov    %ebx,%edx
8010809e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801080a4:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801080a8:	b9 00 10 00 00       	mov    $0x1000,%ecx
801080ad:	89 04 24             	mov    %eax,(%esp)
801080b0:	89 f8                	mov    %edi,%eax
801080b2:	e8 59 fb ff ff       	call   80107c10 <mappages>
801080b7:	85 c0                	test   %eax,%eax
801080b9:	78 4d                	js     80108108 <allocuvm+0xc8>
  for(; a < newsz; a += PGSIZE){
801080bb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801080c1:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801080c4:	76 7a                	jbe    80108140 <allocuvm+0x100>
    mem = kalloc();
801080c6:	e8 e5 a4 ff ff       	call   801025b0 <kalloc>
    if(mem == 0){
801080cb:	85 c0                	test   %eax,%eax
    mem = kalloc();
801080cd:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801080cf:	75 af                	jne    80108080 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
801080d1:	c7 04 24 89 8e 10 80 	movl   $0x80108e89,(%esp)
801080d8:	e8 73 85 ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
801080dd:	8b 45 0c             	mov    0xc(%ebp),%eax
801080e0:	39 45 10             	cmp    %eax,0x10(%ebp)
801080e3:	77 6b                	ja     80108150 <allocuvm+0x110>
}
801080e5:	83 c4 2c             	add    $0x2c,%esp
    return 0;
801080e8:	31 ff                	xor    %edi,%edi
}
801080ea:	5b                   	pop    %ebx
801080eb:	89 f8                	mov    %edi,%eax
801080ed:	5e                   	pop    %esi
801080ee:	5f                   	pop    %edi
801080ef:	5d                   	pop    %ebp
801080f0:	c3                   	ret    
801080f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
801080f8:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
801080fb:	83 c4 2c             	add    $0x2c,%esp
801080fe:	89 f8                	mov    %edi,%eax
80108100:	5b                   	pop    %ebx
80108101:	5e                   	pop    %esi
80108102:	5f                   	pop    %edi
80108103:	5d                   	pop    %ebp
80108104:	c3                   	ret    
80108105:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80108108:	c7 04 24 a1 8e 10 80 	movl   $0x80108ea1,(%esp)
8010810f:	e8 3c 85 ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
80108114:	8b 45 0c             	mov    0xc(%ebp),%eax
80108117:	39 45 10             	cmp    %eax,0x10(%ebp)
8010811a:	76 0d                	jbe    80108129 <allocuvm+0xe9>
8010811c:	89 c1                	mov    %eax,%ecx
8010811e:	8b 55 10             	mov    0x10(%ebp),%edx
80108121:	8b 45 08             	mov    0x8(%ebp),%eax
80108124:	e8 77 fb ff ff       	call   80107ca0 <deallocuvm.part.0>
      kfree(mem);
80108129:	89 34 24             	mov    %esi,(%esp)
      return 0;
8010812c:	31 ff                	xor    %edi,%edi
      kfree(mem);
8010812e:	e8 ad a2 ff ff       	call   801023e0 <kfree>
}
80108133:	83 c4 2c             	add    $0x2c,%esp
80108136:	89 f8                	mov    %edi,%eax
80108138:	5b                   	pop    %ebx
80108139:	5e                   	pop    %esi
8010813a:	5f                   	pop    %edi
8010813b:	5d                   	pop    %ebp
8010813c:	c3                   	ret    
8010813d:	8d 76 00             	lea    0x0(%esi),%esi
80108140:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80108143:	83 c4 2c             	add    $0x2c,%esp
80108146:	5b                   	pop    %ebx
80108147:	5e                   	pop    %esi
80108148:	89 f8                	mov    %edi,%eax
8010814a:	5f                   	pop    %edi
8010814b:	5d                   	pop    %ebp
8010814c:	c3                   	ret    
8010814d:	8d 76 00             	lea    0x0(%esi),%esi
80108150:	89 c1                	mov    %eax,%ecx
80108152:	8b 55 10             	mov    0x10(%ebp),%edx
      return 0;
80108155:	31 ff                	xor    %edi,%edi
80108157:	8b 45 08             	mov    0x8(%ebp),%eax
8010815a:	e8 41 fb ff ff       	call   80107ca0 <deallocuvm.part.0>
8010815f:	eb 9a                	jmp    801080fb <allocuvm+0xbb>
80108161:	eb 0d                	jmp    80108170 <deallocuvm>
80108163:	90                   	nop
80108164:	90                   	nop
80108165:	90                   	nop
80108166:	90                   	nop
80108167:	90                   	nop
80108168:	90                   	nop
80108169:	90                   	nop
8010816a:	90                   	nop
8010816b:	90                   	nop
8010816c:	90                   	nop
8010816d:	90                   	nop
8010816e:	90                   	nop
8010816f:	90                   	nop

80108170 <deallocuvm>:
{
80108170:	55                   	push   %ebp
80108171:	89 e5                	mov    %esp,%ebp
80108173:	8b 55 0c             	mov    0xc(%ebp),%edx
80108176:	8b 4d 10             	mov    0x10(%ebp),%ecx
80108179:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010817c:	39 d1                	cmp    %edx,%ecx
8010817e:	73 10                	jae    80108190 <deallocuvm+0x20>
}
80108180:	5d                   	pop    %ebp
80108181:	e9 1a fb ff ff       	jmp    80107ca0 <deallocuvm.part.0>
80108186:	8d 76 00             	lea    0x0(%esi),%esi
80108189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80108190:	89 d0                	mov    %edx,%eax
80108192:	5d                   	pop    %ebp
80108193:	c3                   	ret    
80108194:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010819a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801081a0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801081a0:	55                   	push   %ebp
801081a1:	89 e5                	mov    %esp,%ebp
801081a3:	57                   	push   %edi
801081a4:	56                   	push   %esi
801081a5:	53                   	push   %ebx
801081a6:	83 ec 1c             	sub    $0x1c,%esp
801081a9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801081ac:	85 f6                	test   %esi,%esi
801081ae:	74 55                	je     80108205 <freevm+0x65>
801081b0:	31 c9                	xor    %ecx,%ecx
801081b2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801081b7:	89 f0                	mov    %esi,%eax
801081b9:	89 f3                	mov    %esi,%ebx
801081bb:	e8 e0 fa ff ff       	call   80107ca0 <deallocuvm.part.0>
801081c0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801081c6:	eb 0f                	jmp    801081d7 <freevm+0x37>
801081c8:	90                   	nop
801081c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801081d0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801081d3:	39 fb                	cmp    %edi,%ebx
801081d5:	74 1f                	je     801081f6 <freevm+0x56>
    if(pgdir[i] & PTE_P){
801081d7:	8b 03                	mov    (%ebx),%eax
801081d9:	a8 01                	test   $0x1,%al
801081db:	74 f3                	je     801081d0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801081dd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801081e2:	83 c3 04             	add    $0x4,%ebx
801081e5:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801081ea:	89 04 24             	mov    %eax,(%esp)
801081ed:	e8 ee a1 ff ff       	call   801023e0 <kfree>
  for(i = 0; i < NPDENTRIES; i++){
801081f2:	39 fb                	cmp    %edi,%ebx
801081f4:	75 e1                	jne    801081d7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
801081f6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801081f9:	83 c4 1c             	add    $0x1c,%esp
801081fc:	5b                   	pop    %ebx
801081fd:	5e                   	pop    %esi
801081fe:	5f                   	pop    %edi
801081ff:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80108200:	e9 db a1 ff ff       	jmp    801023e0 <kfree>
    panic("freevm: no pgdir");
80108205:	c7 04 24 bd 8e 10 80 	movl   $0x80108ebd,(%esp)
8010820c:	e8 5f 81 ff ff       	call   80100370 <panic>
80108211:	eb 0d                	jmp    80108220 <setupkvm>
80108213:	90                   	nop
80108214:	90                   	nop
80108215:	90                   	nop
80108216:	90                   	nop
80108217:	90                   	nop
80108218:	90                   	nop
80108219:	90                   	nop
8010821a:	90                   	nop
8010821b:	90                   	nop
8010821c:	90                   	nop
8010821d:	90                   	nop
8010821e:	90                   	nop
8010821f:	90                   	nop

80108220 <setupkvm>:
{
80108220:	55                   	push   %ebp
80108221:	89 e5                	mov    %esp,%ebp
80108223:	56                   	push   %esi
80108224:	53                   	push   %ebx
80108225:	83 ec 10             	sub    $0x10,%esp
  if((pgdir = (pde_t*)kalloc()) == 0)
80108228:	e8 83 a3 ff ff       	call   801025b0 <kalloc>
8010822d:	85 c0                	test   %eax,%eax
8010822f:	89 c6                	mov    %eax,%esi
80108231:	74 46                	je     80108279 <setupkvm+0x59>
  memset(pgdir, 0, PGSIZE);
80108233:	b8 00 10 00 00       	mov    $0x1000,%eax
80108238:	31 d2                	xor    %edx,%edx
8010823a:	89 44 24 08          	mov    %eax,0x8(%esp)
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010823e:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80108243:	89 54 24 04          	mov    %edx,0x4(%esp)
80108247:	89 34 24             	mov    %esi,(%esp)
8010824a:	e8 11 d7 ff ff       	call   80105960 <memset>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010824f:	8b 53 0c             	mov    0xc(%ebx),%edx
                (uint)k->phys_start, k->perm) < 0) {
80108252:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80108255:	8b 4b 08             	mov    0x8(%ebx),%ecx
80108258:	89 54 24 04          	mov    %edx,0x4(%esp)
8010825c:	8b 13                	mov    (%ebx),%edx
8010825e:	89 04 24             	mov    %eax,(%esp)
80108261:	29 c1                	sub    %eax,%ecx
80108263:	89 f0                	mov    %esi,%eax
80108265:	e8 a6 f9 ff ff       	call   80107c10 <mappages>
8010826a:	85 c0                	test   %eax,%eax
8010826c:	78 1a                	js     80108288 <setupkvm+0x68>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010826e:	83 c3 10             	add    $0x10,%ebx
80108271:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80108277:	75 d6                	jne    8010824f <setupkvm+0x2f>
}
80108279:	83 c4 10             	add    $0x10,%esp
8010827c:	89 f0                	mov    %esi,%eax
8010827e:	5b                   	pop    %ebx
8010827f:	5e                   	pop    %esi
80108280:	5d                   	pop    %ebp
80108281:	c3                   	ret    
80108282:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      freevm(pgdir);
80108288:	89 34 24             	mov    %esi,(%esp)
      return 0;
8010828b:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
8010828d:	e8 0e ff ff ff       	call   801081a0 <freevm>
}
80108292:	83 c4 10             	add    $0x10,%esp
80108295:	89 f0                	mov    %esi,%eax
80108297:	5b                   	pop    %ebx
80108298:	5e                   	pop    %esi
80108299:	5d                   	pop    %ebp
8010829a:	c3                   	ret    
8010829b:	90                   	nop
8010829c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801082a0 <kvmalloc>:
{
801082a0:	55                   	push   %ebp
801082a1:	89 e5                	mov    %esp,%ebp
801082a3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801082a6:	e8 75 ff ff ff       	call   80108220 <setupkvm>
801082ab:	a3 04 6f 11 80       	mov    %eax,0x80116f04
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801082b0:	05 00 00 00 80       	add    $0x80000000,%eax
801082b5:	0f 22 d8             	mov    %eax,%cr3
}
801082b8:	c9                   	leave  
801082b9:	c3                   	ret    
801082ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801082c0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801082c0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801082c1:	31 c9                	xor    %ecx,%ecx
{
801082c3:	89 e5                	mov    %esp,%ebp
801082c5:	83 ec 18             	sub    $0x18,%esp
  pte = walkpgdir(pgdir, uva, 0);
801082c8:	8b 55 0c             	mov    0xc(%ebp),%edx
801082cb:	8b 45 08             	mov    0x8(%ebp),%eax
801082ce:	e8 ad f8 ff ff       	call   80107b80 <walkpgdir>
  if(pte == 0)
801082d3:	85 c0                	test   %eax,%eax
801082d5:	74 05                	je     801082dc <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
801082d7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801082da:	c9                   	leave  
801082db:	c3                   	ret    
    panic("clearpteu");
801082dc:	c7 04 24 ce 8e 10 80 	movl   $0x80108ece,(%esp)
801082e3:	e8 88 80 ff ff       	call   80100370 <panic>
801082e8:	90                   	nop
801082e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801082f0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801082f0:	55                   	push   %ebp
801082f1:	89 e5                	mov    %esp,%ebp
801082f3:	57                   	push   %edi
801082f4:	56                   	push   %esi
801082f5:	53                   	push   %ebx
801082f6:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801082f9:	e8 22 ff ff ff       	call   80108220 <setupkvm>
801082fe:	85 c0                	test   %eax,%eax
80108300:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108303:	0f 84 a3 00 00 00    	je     801083ac <copyuvm+0xbc>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108309:	8b 55 0c             	mov    0xc(%ebp),%edx
8010830c:	85 d2                	test   %edx,%edx
8010830e:	0f 84 98 00 00 00    	je     801083ac <copyuvm+0xbc>
80108314:	31 ff                	xor    %edi,%edi
80108316:	eb 50                	jmp    80108368 <copyuvm+0x78>
80108318:	90                   	nop
80108319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80108320:	b8 00 10 00 00       	mov    $0x1000,%eax
80108325:	89 44 24 08          	mov    %eax,0x8(%esp)
80108329:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010832c:	89 34 24             	mov    %esi,(%esp)
8010832f:	05 00 00 00 80       	add    $0x80000000,%eax
80108334:	89 44 24 04          	mov    %eax,0x4(%esp)
80108338:	e8 e3 d6 ff ff       	call   80105a20 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
8010833d:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80108343:	b9 00 10 00 00       	mov    $0x1000,%ecx
80108348:	89 04 24             	mov    %eax,(%esp)
8010834b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010834e:	89 fa                	mov    %edi,%edx
80108350:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80108354:	e8 b7 f8 ff ff       	call   80107c10 <mappages>
80108359:	85 c0                	test   %eax,%eax
8010835b:	78 63                	js     801083c0 <copyuvm+0xd0>
  for(i = 0; i < sz; i += PGSIZE){
8010835d:	81 c7 00 10 00 00    	add    $0x1000,%edi
80108363:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80108366:	76 44                	jbe    801083ac <copyuvm+0xbc>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80108368:	8b 45 08             	mov    0x8(%ebp),%eax
8010836b:	31 c9                	xor    %ecx,%ecx
8010836d:	89 fa                	mov    %edi,%edx
8010836f:	e8 0c f8 ff ff       	call   80107b80 <walkpgdir>
80108374:	85 c0                	test   %eax,%eax
80108376:	74 5e                	je     801083d6 <copyuvm+0xe6>
    if(!(*pte & PTE_P))
80108378:	8b 18                	mov    (%eax),%ebx
8010837a:	f6 c3 01             	test   $0x1,%bl
8010837d:	74 4b                	je     801083ca <copyuvm+0xda>
    pa = PTE_ADDR(*pte);
8010837f:	89 d8                	mov    %ebx,%eax
    flags = PTE_FLAGS(*pte);
80108381:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
80108387:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010838c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
8010838f:	e8 1c a2 ff ff       	call   801025b0 <kalloc>
80108394:	85 c0                	test   %eax,%eax
80108396:	89 c6                	mov    %eax,%esi
80108398:	75 86                	jne    80108320 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
8010839a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010839d:	89 04 24             	mov    %eax,(%esp)
801083a0:	e8 fb fd ff ff       	call   801081a0 <freevm>
  return 0;
801083a5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
801083ac:	8b 45 e0             	mov    -0x20(%ebp),%eax
801083af:	83 c4 2c             	add    $0x2c,%esp
801083b2:	5b                   	pop    %ebx
801083b3:	5e                   	pop    %esi
801083b4:	5f                   	pop    %edi
801083b5:	5d                   	pop    %ebp
801083b6:	c3                   	ret    
801083b7:	89 f6                	mov    %esi,%esi
801083b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      kfree(mem);
801083c0:	89 34 24             	mov    %esi,(%esp)
801083c3:	e8 18 a0 ff ff       	call   801023e0 <kfree>
      goto bad;
801083c8:	eb d0                	jmp    8010839a <copyuvm+0xaa>
      panic("copyuvm: page not present");
801083ca:	c7 04 24 f2 8e 10 80 	movl   $0x80108ef2,(%esp)
801083d1:	e8 9a 7f ff ff       	call   80100370 <panic>
      panic("copyuvm: pte should exist");
801083d6:	c7 04 24 d8 8e 10 80 	movl   $0x80108ed8,(%esp)
801083dd:	e8 8e 7f ff ff       	call   80100370 <panic>
801083e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801083e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801083f0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801083f0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801083f1:	31 c9                	xor    %ecx,%ecx
{
801083f3:	89 e5                	mov    %esp,%ebp
801083f5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
801083f8:	8b 55 0c             	mov    0xc(%ebp),%edx
801083fb:	8b 45 08             	mov    0x8(%ebp),%eax
801083fe:	e8 7d f7 ff ff       	call   80107b80 <walkpgdir>
  if((*pte & PTE_P) == 0)
80108403:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80108405:	89 c2                	mov    %eax,%edx
80108407:	83 e2 05             	and    $0x5,%edx
8010840a:	83 fa 05             	cmp    $0x5,%edx
8010840d:	75 11                	jne    80108420 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
8010840f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108414:	05 00 00 00 80       	add    $0x80000000,%eax
}
80108419:	c9                   	leave  
8010841a:	c3                   	ret    
8010841b:	90                   	nop
8010841c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80108420:	31 c0                	xor    %eax,%eax
}
80108422:	c9                   	leave  
80108423:	c3                   	ret    
80108424:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010842a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80108430 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108430:	55                   	push   %ebp
80108431:	89 e5                	mov    %esp,%ebp
80108433:	57                   	push   %edi
80108434:	56                   	push   %esi
80108435:	53                   	push   %ebx
80108436:	83 ec 2c             	sub    $0x2c,%esp
80108439:	8b 75 14             	mov    0x14(%ebp),%esi
8010843c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
8010843f:	85 f6                	test   %esi,%esi
80108441:	74 75                	je     801084b8 <copyout+0x88>
80108443:	89 da                	mov    %ebx,%edx
80108445:	eb 3f                	jmp    80108486 <copyout+0x56>
80108447:	89 f6                	mov    %esi,%esi
80108449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80108450:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80108453:	89 df                	mov    %ebx,%edi
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80108455:	8b 4d 10             	mov    0x10(%ebp),%ecx
    n = PGSIZE - (va - va0);
80108458:	29 d7                	sub    %edx,%edi
8010845a:	81 c7 00 10 00 00    	add    $0x1000,%edi
80108460:	39 f7                	cmp    %esi,%edi
80108462:	0f 47 fe             	cmova  %esi,%edi
    memmove(pa0 + (va - va0), buf, n);
80108465:	29 da                	sub    %ebx,%edx
80108467:	01 c2                	add    %eax,%edx
80108469:	89 14 24             	mov    %edx,(%esp)
8010846c:	89 7c 24 08          	mov    %edi,0x8(%esp)
80108470:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80108474:	e8 a7 d5 ff ff       	call   80105a20 <memmove>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
80108479:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    buf += n;
8010847f:	01 7d 10             	add    %edi,0x10(%ebp)
  while(len > 0){
80108482:	29 fe                	sub    %edi,%esi
80108484:	74 32                	je     801084b8 <copyout+0x88>
    pa0 = uva2ka(pgdir, (char*)va0);
80108486:	8b 45 08             	mov    0x8(%ebp),%eax
    va0 = (uint)PGROUNDDOWN(va);
80108489:	89 d3                	mov    %edx,%ebx
8010848b:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    pa0 = uva2ka(pgdir, (char*)va0);
80108491:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    va0 = (uint)PGROUNDDOWN(va);
80108495:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80108498:	89 04 24             	mov    %eax,(%esp)
8010849b:	e8 50 ff ff ff       	call   801083f0 <uva2ka>
    if(pa0 == 0)
801084a0:	85 c0                	test   %eax,%eax
801084a2:	75 ac                	jne    80108450 <copyout+0x20>
  }
  return 0;
}
801084a4:	83 c4 2c             	add    $0x2c,%esp
      return -1;
801084a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801084ac:	5b                   	pop    %ebx
801084ad:	5e                   	pop    %esi
801084ae:	5f                   	pop    %edi
801084af:	5d                   	pop    %ebp
801084b0:	c3                   	ret    
801084b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801084b8:	83 c4 2c             	add    $0x2c,%esp
  return 0;
801084bb:	31 c0                	xor    %eax,%eax
}
801084bd:	5b                   	pop    %ebx
801084be:	5e                   	pop    %esi
801084bf:	5f                   	pop    %edi
801084c0:	5d                   	pop    %ebp
801084c1:	c3                   	ret    
