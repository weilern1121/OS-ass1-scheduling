
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
80100041:	ba e0 7c 10 80       	mov    $0x80107ce0,%edx
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
8010005c:	e8 df 4f 00 00       	call   80105040 <initlock>
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
80100082:	b8 e7 7c 10 80       	mov    $0x80107ce7,%eax
    b->next = bcache.head.next;
80100087:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008a:	c7 43 50 1c 0d 11 80 	movl   $0x80110d1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100091:	89 44 24 04          	mov    %eax,0x4(%esp)
80100095:	8d 43 0c             	lea    0xc(%ebx),%eax
80100098:	89 04 24             	mov    %eax,(%esp)
8010009b:	e8 70 4e 00 00       	call   80104f10 <initsleeplock>
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
801000e6:	e8 a5 50 00 00       	call   80105190 <acquire>
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
80100161:	e8 ca 50 00 00       	call   80105230 <release>
      acquiresleep(&b->lock);
80100166:	8d 43 0c             	lea    0xc(%ebx),%eax
80100169:	89 04 24             	mov    %eax,(%esp)
8010016c:	e8 df 4d 00 00       	call   80104f50 <acquiresleep>
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
80100188:	c7 04 24 ee 7c 10 80 	movl   $0x80107cee,(%esp)
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
801001b0:	e8 3b 4e 00 00       	call   80104ff0 <holdingsleep>
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
801001c9:	c7 04 24 ff 7c 10 80 	movl   $0x80107cff,(%esp)
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
801001f1:	e8 fa 4d 00 00       	call   80104ff0 <holdingsleep>
801001f6:	85 c0                	test   %eax,%eax
801001f8:	74 5a                	je     80100254 <brelse+0x74>
    panic("brelse");

  releasesleep(&b->lock);
801001fa:	89 34 24             	mov    %esi,(%esp)
801001fd:	e8 ae 4d 00 00       	call   80104fb0 <releasesleep>

  acquire(&bcache.lock);
80100202:	c7 04 24 20 c6 10 80 	movl   $0x8010c620,(%esp)
80100209:	e8 82 4f 00 00       	call   80105190 <acquire>
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
8010024f:	e9 dc 4f 00 00       	jmp    80105230 <release>
    panic("brelse");
80100254:	c7 04 24 06 7d 10 80 	movl   $0x80107d06,(%esp)
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
8010027e:	e8 0d 4f 00 00       	call   80105190 <acquire>
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
801002b8:	e8 53 3c 00 00       	call   80103f10 <sleep>
    while(input.r == input.w){
801002bd:	8b 15 00 10 11 80    	mov    0x80111000,%edx
801002c3:	3b 15 04 10 11 80    	cmp    0x80111004,%edx
801002c9:	75 35                	jne    80100300 <consoleread+0xa0>
      if(myproc()->killed){
801002cb:	e8 a0 36 00 00       	call   80103970 <myproc>
801002d0:	8b 50 24             	mov    0x24(%eax),%edx
801002d3:	85 d2                	test   %edx,%edx
801002d5:	74 d1                	je     801002a8 <consoleread+0x48>
        release(&cons.lock);
801002d7:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
801002de:	e8 4d 4f 00 00       	call   80105230 <release>
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
8010033a:	e8 f1 4e 00 00       	call   80105230 <release>
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
8010038c:	c7 04 24 0d 7d 10 80 	movl   $0x80107d0d,(%esp)
80100393:	89 44 24 04          	mov    %eax,0x4(%esp)
80100397:	e8 b4 02 00 00       	call   80100650 <cprintf>
  cprintf(s);
8010039c:	8b 45 08             	mov    0x8(%ebp),%eax
8010039f:	89 04 24             	mov    %eax,(%esp)
801003a2:	e8 a9 02 00 00       	call   80100650 <cprintf>
  cprintf("\n");
801003a7:	c7 04 24 d7 86 10 80 	movl   $0x801086d7,(%esp)
801003ae:	e8 9d 02 00 00       	call   80100650 <cprintf>
  getcallerpcs(&s, pcs);
801003b3:	8d 45 08             	lea    0x8(%ebp),%eax
801003b6:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801003ba:	89 04 24             	mov    %eax,(%esp)
801003bd:	e8 9e 4c 00 00       	call   80105060 <getcallerpcs>
801003c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    cprintf(" %p", pcs[i]);
801003d0:	8b 03                	mov    (%ebx),%eax
801003d2:	83 c3 04             	add    $0x4,%ebx
801003d5:	c7 04 24 21 7d 10 80 	movl   $0x80107d21,(%esp)
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
80100429:	e8 a2 64 00 00       	call   801068d0 <uartputc>
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
801004cc:	e8 ff 63 00 00       	call   801068d0 <uartputc>
801004d1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004d8:	e8 f3 63 00 00       	call   801068d0 <uartputc>
801004dd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004e4:	e8 e7 63 00 00       	call   801068d0 <uartputc>
801004e9:	e9 40 ff ff ff       	jmp    8010042e <consputc+0x2e>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004ee:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
801004f5:	00 
801004f6:	c7 44 24 04 a0 80 0b 	movl   $0x800b80a0,0x4(%esp)
801004fd:	80 
801004fe:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
80100505:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80100508:	e8 33 4e 00 00       	call   80105340 <memmove>
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
80100536:	e8 45 4d 00 00       	call   80105280 <memset>
8010053b:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010053e:	e9 4c ff ff ff       	jmp    8010048f <consputc+0x8f>
    panic("pos under/overflow");
80100543:	c7 04 24 25 7d 10 80 	movl   $0x80107d25,(%esp)
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
801005a1:	0f b6 92 50 7d 10 80 	movzbl -0x7fef82b0(%edx),%edx
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
8010060e:	e8 7d 4b 00 00       	call   80105190 <acquire>
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
80100634:	e8 f7 4b 00 00       	call   80105230 <release>
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
8010070e:	e8 1d 4b 00 00       	call   80105230 <release>
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
80100774:	bf 38 7d 10 80       	mov    $0x80107d38,%edi
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
801007b7:	e8 d4 49 00 00       	call   80105190 <acquire>
801007bc:	e9 a8 fe ff ff       	jmp    80100669 <cprintf+0x19>
    panic("null fmt");
801007c1:	c7 04 24 3f 7d 10 80 	movl   $0x80107d3f,(%esp)
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
801007e4:	e8 a7 49 00 00       	call   80105190 <acquire>
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
80100847:	e8 e4 49 00 00       	call   80105230 <release>
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
801008d9:	e8 f2 37 00 00       	call   801040d0 <wakeup>
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
8010094e:	e9 5d 38 00 00       	jmp    801041b0 <procdump>
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
80100981:	b8 48 7d 10 80       	mov    $0x80107d48,%eax
{
80100986:	89 e5                	mov    %esp,%ebp
80100988:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
8010098b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010098f:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
80100996:	e8 a5 46 00 00       	call   80105040 <initlock>

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
801009dc:	e8 8f 2f 00 00       	call   80103970 <myproc>
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
80100a5c:	e8 cf 6f 00 00       	call   80107a30 <setupkvm>
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
80100ac8:	e8 83 6d 00 00       	call   80107850 <allocuvm>
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
80100b05:	e8 86 6c 00 00       	call   80107790 <loaduvm>
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
80100b58:	e8 53 6e 00 00       	call   801079b0 <freevm>
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
80100b92:	e8 b9 6c 00 00       	call   80107850 <allocuvm>
80100b97:	85 c0                	test   %eax,%eax
80100b99:	89 c6                	mov    %eax,%esi
80100b9b:	75 33                	jne    80100bd0 <exec+0x200>
    freevm(pgdir);
80100b9d:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ba3:	89 04 24             	mov    %eax,(%esp)
80100ba6:	e8 05 6e 00 00       	call   801079b0 <freevm>
  return -1;
80100bab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bb0:	e9 8c fe ff ff       	jmp    80100a41 <exec+0x71>
    end_op();
80100bb5:	e8 46 21 00 00       	call   80102d00 <end_op>
    cprintf("exec: fail\n");
80100bba:	c7 04 24 61 7d 10 80 	movl   $0x80107d61,(%esp)
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
80100be7:	e8 e4 6e 00 00       	call   80107ad0 <clearpteu>
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
80100c18:	e8 83 48 00 00       	call   801054a0 <strlen>
80100c1d:	f7 d0                	not    %eax
80100c1f:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c21:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c24:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c27:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c2a:	89 04 24             	mov    %eax,(%esp)
80100c2d:	e8 6e 48 00 00       	call   801054a0 <strlen>
80100c32:	40                   	inc    %eax
80100c33:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c37:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c3a:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c3d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100c41:	89 34 24             	mov    %esi,(%esp)
80100c44:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c48:	e8 f3 6f 00 00       	call   80107c40 <copyout>
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
80100cb8:	e8 83 6f 00 00       	call   80107c40 <copyout>
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
80100d01:	e8 5a 47 00 00       	call   80105460 <safestrcpy>
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
80100d2b:	e8 d0 68 00 00       	call   80107600 <switchuvm>
  freevm(oldpgdir);
80100d30:	89 3c 24             	mov    %edi,(%esp)
80100d33:	e8 78 6c 00 00       	call   801079b0 <freevm>
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
80100d51:	b8 6d 7d 10 80       	mov    $0x80107d6d,%eax
{
80100d56:	89 e5                	mov    %esp,%ebp
80100d58:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100d5b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100d5f:	c7 04 24 20 10 11 80 	movl   $0x80111020,(%esp)
80100d66:	e8 d5 42 00 00       	call   80105040 <initlock>
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
80100d83:	e8 08 44 00 00       	call   80105190 <acquire>
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
80100db0:	e8 7b 44 00 00       	call   80105230 <release>
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
80100dc9:	e8 62 44 00 00       	call   80105230 <release>
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
80100df1:	e8 9a 43 00 00       	call   80105190 <acquire>
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
80100e08:	e8 23 44 00 00       	call   80105230 <release>
  return f;
}
80100e0d:	83 c4 14             	add    $0x14,%esp
80100e10:	89 d8                	mov    %ebx,%eax
80100e12:	5b                   	pop    %ebx
80100e13:	5d                   	pop    %ebp
80100e14:	c3                   	ret    
    panic("filedup");
80100e15:	c7 04 24 74 7d 10 80 	movl   $0x80107d74,(%esp)
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
80100e49:	e8 42 43 00 00       	call   80105190 <acquire>
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
80100e74:	e9 b7 43 00 00       	jmp    80105230 <release>
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
80100e9f:	e8 8c 43 00 00       	call   80105230 <release>
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
80100ef9:	c7 04 24 7c 7d 10 80 	movl   $0x80107d7c,(%esp)
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
80100ff7:	c7 04 24 86 7d 10 80 	movl   $0x80107d86,(%esp)
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
80101112:	c7 04 24 8f 7d 10 80 	movl   $0x80107d8f,(%esp)
80101119:	e8 52 f2 ff ff       	call   80100370 <panic>
  panic("filewrite");
8010111e:	c7 04 24 95 7d 10 80 	movl   $0x80107d95,(%esp)
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
801011c8:	c7 04 24 9f 7d 10 80 	movl   $0x80107d9f,(%esp)
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
80101218:	e8 63 40 00 00       	call   80105280 <memset>
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
8010125c:	e8 2f 3f 00 00       	call   80105190 <acquire>
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
801012be:	e8 6d 3f 00 00       	call   80105230 <release>

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
801012e2:	e8 49 3f 00 00       	call   80105230 <release>
}
801012e7:	83 c4 2c             	add    $0x2c,%esp
801012ea:	89 f0                	mov    %esi,%eax
801012ec:	5b                   	pop    %ebx
801012ed:	5e                   	pop    %esi
801012ee:	5f                   	pop    %edi
801012ef:	5d                   	pop    %ebp
801012f0:	c3                   	ret    
    panic("iget: no inodes");
801012f1:	c7 04 24 b5 7d 10 80 	movl   $0x80107db5,(%esp)
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
801013c1:	c7 04 24 c5 7d 10 80 	movl   $0x80107dc5,(%esp)
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
80101408:	e8 33 3f 00 00       	call   80105340 <memmove>
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
80101497:	c7 04 24 d8 7d 10 80 	movl   $0x80107dd8,(%esp)
8010149e:	e8 cd ee ff ff       	call   80100370 <panic>
801014a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801014a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801014b0 <iinit>:
{
801014b0:	55                   	push   %ebp
  initlock(&icache.lock, "icache");
801014b1:	b9 eb 7d 10 80       	mov    $0x80107deb,%ecx
{
801014b6:	89 e5                	mov    %esp,%ebp
801014b8:	53                   	push   %ebx
801014b9:	bb 80 1a 11 80       	mov    $0x80111a80,%ebx
801014be:	83 ec 24             	sub    $0x24,%esp
  initlock(&icache.lock, "icache");
801014c1:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801014c5:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
801014cc:	e8 6f 3b 00 00       	call   80105040 <initlock>
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
801014e0:	ba f2 7d 10 80       	mov    $0x80107df2,%edx
801014e5:	89 1c 24             	mov    %ebx,(%esp)
801014e8:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014ee:	89 54 24 04          	mov    %edx,0x4(%esp)
801014f2:	e8 19 3a 00 00       	call   80104f10 <initsleeplock>
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
80101518:	c7 04 24 58 7e 10 80 	movl   $0x80107e58,(%esp)
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
801015f3:	e8 88 3c 00 00       	call   80105280 <memset>
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
80101621:	c7 04 24 f8 7d 10 80 	movl   $0x80107df8,(%esp)
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
801016a2:	e8 99 3c 00 00       	call   80105340 <memmove>
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
801016d1:	e8 ba 3a 00 00       	call   80105190 <acquire>
  ip->ref++;
801016d6:	ff 43 08             	incl   0x8(%ebx)
  release(&icache.lock);
801016d9:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
801016e0:	e8 4b 3b 00 00       	call   80105230 <release>
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
80101714:	e8 37 38 00 00       	call   80104f50 <acquiresleep>
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
80101796:	e8 a5 3b 00 00       	call   80105340 <memmove>
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
801017b5:	c7 04 24 10 7e 10 80 	movl   $0x80107e10,(%esp)
801017bc:	e8 af eb ff ff       	call   80100370 <panic>
    panic("ilock");
801017c1:	c7 04 24 0a 7e 10 80 	movl   $0x80107e0a,(%esp)
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
801017e9:	e8 02 38 00 00       	call   80104ff0 <holdingsleep>
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
80101805:	e9 a6 37 00 00       	jmp    80104fb0 <releasesleep>
    panic("iunlock");
8010180a:	c7 04 24 1f 7e 10 80 	movl   $0x80107e1f,(%esp)
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
80101838:	e8 13 37 00 00       	call   80104f50 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
8010183d:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101840:	85 d2                	test   %edx,%edx
80101842:	74 07                	je     8010184b <iput+0x2b>
80101844:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101849:	74 35                	je     80101880 <iput+0x60>
  releasesleep(&ip->lock);
8010184b:	89 3c 24             	mov    %edi,(%esp)
8010184e:	e8 5d 37 00 00       	call   80104fb0 <releasesleep>
  acquire(&icache.lock);
80101853:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
8010185a:	e8 31 39 00 00       	call   80105190 <acquire>
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
80101875:	e9 b6 39 00 00       	jmp    80105230 <release>
8010187a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101880:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
80101887:	e8 04 39 00 00       	call   80105190 <acquire>
    int r = ip->ref;
8010188c:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
8010188f:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
80101896:	e8 95 39 00 00       	call   80105230 <release>
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
80101a83:	e8 b8 38 00 00       	call   80105340 <memmove>
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
80101baf:	e8 8c 37 00 00       	call   80105340 <memmove>
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
80101c5c:	e8 3f 37 00 00       	call   801053a0 <strncmp>
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
80101cdb:	e8 c0 36 00 00       	call   801053a0 <strncmp>
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
80101d1f:	c7 04 24 39 7e 10 80 	movl   $0x80107e39,(%esp)
80101d26:	e8 45 e6 ff ff       	call   80100370 <panic>
    panic("dirlookup not DIR");
80101d2b:	c7 04 24 27 7e 10 80 	movl   $0x80107e27,(%esp)
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
80101d59:	e8 12 1c 00 00       	call   80103970 <myproc>
80101d5e:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101d61:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
80101d68:	e8 23 34 00 00       	call   80105190 <acquire>
  ip->ref++;
80101d6d:	ff 46 08             	incl   0x8(%esi)
  release(&icache.lock);
80101d70:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
80101d77:	e8 b4 34 00 00       	call   80105230 <release>
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
80101ddc:	e8 5f 35 00 00       	call   80105340 <memmove>
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
80101e65:	e8 d6 34 00 00       	call   80105340 <memmove>
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
80101f73:	e8 88 34 00 00       	call   80105400 <strncpy>
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
80101fb6:	c7 04 24 48 7e 10 80 	movl   $0x80107e48,(%esp)
80101fbd:	e8 ae e3 ff ff       	call   80100370 <panic>
    panic("dirlink");
80101fc2:	c7 04 24 be 84 10 80 	movl   $0x801084be,(%esp)
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
801020bc:	c7 04 24 b4 7e 10 80 	movl   $0x80107eb4,(%esp)
801020c3:	e8 a8 e2 ff ff       	call   80100370 <panic>
    panic("idestart");
801020c8:	c7 04 24 ab 7e 10 80 	movl   $0x80107eab,(%esp)
801020cf:	e8 9c e2 ff ff       	call   80100370 <panic>
801020d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801020da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801020e0 <ideinit>:
{
801020e0:	55                   	push   %ebp
  initlock(&idelock, "ide");
801020e1:	ba c6 7e 10 80       	mov    $0x80107ec6,%edx
{
801020e6:	89 e5                	mov    %esp,%ebp
801020e8:	83 ec 18             	sub    $0x18,%esp
  initlock(&idelock, "ide");
801020eb:	89 54 24 04          	mov    %edx,0x4(%esp)
801020ef:	c7 04 24 80 b5 10 80 	movl   $0x8010b580,(%esp)
801020f6:	e8 45 2f 00 00       	call   80105040 <initlock>
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
80102176:	e8 15 30 00 00       	call   80105190 <acquire>

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
801021ce:	e8 fd 1e 00 00       	call   801040d0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801021d3:	a1 64 b5 10 80       	mov    0x8010b564,%eax
801021d8:	85 c0                	test   %eax,%eax
801021da:	74 05                	je     801021e1 <ideintr+0x81>
    idestart(idequeue);
801021dc:	e8 2f fe ff ff       	call   80102010 <idestart>
    release(&idelock);
801021e1:	c7 04 24 80 b5 10 80 	movl   $0x8010b580,(%esp)
801021e8:	e8 43 30 00 00       	call   80105230 <release>

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
80102210:	e8 db 2d 00 00       	call   80104ff0 <holdingsleep>
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
80102247:	e8 44 2f 00 00       	call   80105190 <acquire>

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
8010228c:	e8 7f 1c 00 00       	call   80103f10 <sleep>
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
801022a7:	e9 84 2f 00 00       	jmp    80105230 <release>
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
801022c7:	c7 04 24 e0 7e 10 80 	movl   $0x80107ee0,(%esp)
801022ce:	e8 9d e0 ff ff       	call   80100370 <panic>
    panic("iderw: buf not locked");
801022d3:	c7 04 24 ca 7e 10 80 	movl   $0x80107eca,(%esp)
801022da:	e8 91 e0 ff ff       	call   80100370 <panic>
    panic("iderw: ide disk 1 not present");
801022df:	c7 04 24 f5 7e 10 80 	movl   $0x80107ef5,(%esp)
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
80102338:	c7 04 24 14 7f 10 80 	movl   $0x80107f14,(%esp)
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
801023f6:	81 fb 08 65 11 80    	cmp    $0x80116508,%ebx
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
80102420:	e8 5b 2e 00 00       	call   80105280 <memset>

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
8010245c:	e9 cf 2d 00 00       	jmp    80105230 <release>
80102461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&kmem.lock);
80102468:	c7 04 24 a0 36 11 80 	movl   $0x801136a0,(%esp)
8010246f:	e8 1c 2d 00 00       	call   80105190 <acquire>
80102474:	eb b8                	jmp    8010242e <kfree+0x4e>
    panic("kfree");
80102476:	c7 04 24 46 7f 10 80 	movl   $0x80107f46,(%esp)
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
801024e1:	b8 4c 7f 10 80       	mov    $0x80107f4c,%eax
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
801024fb:	e8 40 2b 00 00       	call   80105040 <initlock>
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
801025e5:	e8 a6 2b 00 00       	call   80105190 <acquire>
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
8010260f:	e8 1c 2c 00 00       	call   80105230 <release>
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
80102664:	0f b6 8a 80 80 10 80 	movzbl -0x7fef7f80(%edx),%ecx
  shift ^= togglecode[data];
8010266b:	0f b6 82 80 7f 10 80 	movzbl -0x7fef8080(%edx),%eax
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
8010267e:	8b 04 85 60 7f 10 80 	mov    -0x7fef80a0(,%eax,4),%eax
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
801026b9:	0f b6 82 80 80 10 80 	movzbl -0x7fef7f80(%edx),%eax
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
80102a20:	e8 bb 28 00 00       	call   801052e0 <memcmp>
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
80102b3c:	e8 ff 27 00 00       	call   80105340 <memmove>
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
80102bf1:	ba 80 81 10 80       	mov    $0x80108180,%edx
{
80102bf6:	89 e5                	mov    %esp,%ebp
80102bf8:	53                   	push   %ebx
80102bf9:	83 ec 34             	sub    $0x34,%esp
80102bfc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102bff:	89 54 24 04          	mov    %edx,0x4(%esp)
80102c03:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
80102c0a:	e8 31 24 00 00       	call   80105040 <initlock>
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
80102c9d:	e8 ee 24 00 00       	call   80105190 <acquire>
80102ca2:	eb 19                	jmp    80102cbd <begin_op+0x2d>
80102ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102ca8:	b8 e0 36 11 80       	mov    $0x801136e0,%eax
80102cad:	89 44 24 04          	mov    %eax,0x4(%esp)
80102cb1:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
80102cb8:	e8 53 12 00 00       	call   80103f10 <sleep>
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
80102cea:	e8 41 25 00 00       	call   80105230 <release>
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
80102d10:	e8 7b 24 00 00       	call   80105190 <acquire>
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
80102d4a:	e8 e1 24 00 00       	call   80105230 <release>
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
80102da9:	e8 92 25 00 00       	call   80105340 <memmove>
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
80102dec:	e8 9f 23 00 00       	call   80105190 <acquire>
    log.committing = 0;
80102df1:	31 c0                	xor    %eax,%eax
80102df3:	a3 20 37 11 80       	mov    %eax,0x80113720
    wakeup(&log);
80102df8:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
80102dff:	e8 cc 12 00 00       	call   801040d0 <wakeup>
    release(&log.lock);
80102e04:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
80102e0b:	e8 20 24 00 00       	call   80105230 <release>
}
80102e10:	83 c4 1c             	add    $0x1c,%esp
80102e13:	5b                   	pop    %ebx
80102e14:	5e                   	pop    %esi
80102e15:	5f                   	pop    %edi
80102e16:	5d                   	pop    %ebp
80102e17:	c3                   	ret    
    panic("log.committing");
80102e18:	c7 04 24 84 81 10 80 	movl   $0x80108184,(%esp)
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
80102e6b:	e8 20 23 00 00       	call   80105190 <acquire>
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
80102eba:	e9 71 23 00 00       	jmp    80105230 <release>
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
80102ede:	c7 04 24 93 81 10 80 	movl   $0x80108193,(%esp)
80102ee5:	e8 86 d4 ff ff       	call   80100370 <panic>
    panic("log_write outside of trans");
80102eea:	c7 04 24 a9 81 10 80 	movl   $0x801081a9,(%esp)
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
80102f07:	e8 d4 46 00 00       	call   801075e0 <switchkvm>
  seginit();
80102f0c:	e8 3f 46 00 00       	call   80107550 <seginit>
  lapicinit();
80102f11:	e8 1a f8 ff ff       	call   80102730 <lapicinit>
}

static void
mpmain(void) //called by the non-boot AP cpus
{
  struct cpu* c = mycpu();
80102f16:	e8 b5 09 00 00       	call   801038d0 <mycpu>
80102f1b:	89 c3                	mov    %eax,%ebx
  cprintf("cpu%d: is witing for the \"pioneer\" cpu to finish its initialization.\n", cpuid());
80102f1d:	e8 2e 0a 00 00       	call   80103950 <cpuid>
80102f22:	c7 04 24 c4 81 10 80 	movl   $0x801081c4,(%esp)
80102f29:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f2d:	e8 1e d7 ff ff       	call   80100650 <cprintf>
  idtinit();       // load idt register
80102f32:	e8 79 35 00 00       	call   801064b0 <idtinit>
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
80102f5a:	e8 f1 09 00 00       	call   80103950 <cpuid>
80102f5f:	89 c3                	mov    %eax,%ebx
80102f61:	e8 ea 09 00 00       	call   80103950 <cpuid>
80102f66:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80102f6a:	c7 04 24 14 82 10 80 	movl   $0x80108214,(%esp)
80102f71:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f75:	e8 d6 d6 ff ff       	call   80100650 <cprintf>
  scheduler();     // start running processes
80102f7a:	e8 c1 0c 00 00       	call   80103c40 <scheduler>
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
80102f93:	c7 04 24 08 65 11 80 	movl   $0x80116508,(%esp)
80102f9a:	e8 41 f5 ff ff       	call   801024e0 <kinit1>
  kvmalloc();      // kernel page table
80102f9f:	e8 0c 4b 00 00       	call   80107ab0 <kvmalloc>
  mpinit();        // detect other processors
80102fa4:	e8 17 02 00 00       	call   801031c0 <mpinit>
  lapicinit();     // interrupt controller
80102fa9:	e8 82 f7 ff ff       	call   80102730 <lapicinit>
80102fae:	66 90                	xchg   %ax,%ax
  seginit();       // segment descriptors
80102fb0:	e8 9b 45 00 00       	call   80107550 <seginit>
  picinit();       // disable pic
80102fb5:	e8 e6 03 00 00       	call   801033a0 <picinit>
  ioapicinit();    // another interrupt controller
80102fba:	e8 31 f3 ff ff       	call   801022f0 <ioapicinit>
80102fbf:	90                   	nop
  consoleinit();   // console hardware
80102fc0:	e8 bb d9 ff ff       	call   80100980 <consoleinit>
  uartinit();      // serial port
80102fc5:	e8 56 38 00 00       	call   80106820 <uartinit>
  pinit();         // process table
80102fca:	e8 e1 08 00 00       	call   801038b0 <pinit>
80102fcf:	90                   	nop
  tvinit();        // trap vectors
80102fd0:	e8 5b 34 00 00       	call   80106430 <tvinit>
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
80102ffe:	e8 3d 23 00 00       	call   80105340 <memmove>

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
80103030:	e8 9b 08 00 00       	call   801038d0 <mycpu>
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
801030bc:	e8 ef 14 00 00       	call   801045b0 <initSchedDS>
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
80103103:	e8 98 08 00 00       	call   801039a0 <userinit>
  cprintf("\"pioneer\" cpu%d: starting %d\n", cpuid(), cpuid());
80103108:	e8 43 08 00 00       	call   80103950 <cpuid>
8010310d:	89 c3                	mov    %eax,%ebx
8010310f:	e8 3c 08 00 00       	call   80103950 <cpuid>
80103114:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80103118:	c7 04 24 0a 82 10 80 	movl   $0x8010820a,(%esp)
8010311f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103123:	e8 28 d5 ff ff       	call   80100650 <cprintf>
  idtinit();       // load idt register
80103128:	e8 83 33 00 00       	call   801064b0 <idtinit>
  scheduler();     // start running processes
8010312d:	e8 0e 0b 00 00       	call   80103c40 <scheduler>
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
80103166:	ba 28 82 10 80       	mov    $0x80108228,%edx
8010316b:	b8 04 00 00 00       	mov    $0x4,%eax
80103170:	89 54 24 04          	mov    %edx,0x4(%esp)
80103174:	89 44 24 08          	mov    %eax,0x8(%esp)
80103178:	89 34 24             	mov    %esi,(%esp)
8010317b:	e8 60 21 00 00       	call   801052e0 <memcmp>
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
80103224:	ba 45 82 10 80       	mov    $0x80108245,%edx
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103229:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
8010322f:	89 44 24 08          	mov    %eax,0x8(%esp)
80103233:	89 54 24 04          	mov    %edx,0x4(%esp)
80103237:	89 34 24             	mov    %esi,(%esp)
8010323a:	e8 a1 20 00 00       	call   801052e0 <memcmp>
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
801032cf:	ff 24 85 6c 82 10 80 	jmp    *-0x7fef7d94(,%eax,4)
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
80103380:	c7 04 24 2d 82 10 80 	movl   $0x8010822d,(%esp)
80103387:	e8 e4 cf ff ff       	call   80100370 <panic>
    panic("Didn't find a suitable machine");
8010338c:	c7 04 24 4c 82 10 80 	movl   $0x8010824c,(%esp)
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
80103460:	ba 80 82 10 80       	mov    $0x80108280,%edx
  p->nread = 0;
80103465:	89 88 34 02 00 00    	mov    %ecx,0x234(%eax)
  initlock(&p->lock, "pipe");
8010346b:	89 54 24 04          	mov    %edx,0x4(%esp)
8010346f:	89 04 24             	mov    %eax,(%esp)
80103472:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103475:	e8 c6 1b 00 00       	call   80105040 <initlock>
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
801034d5:	e8 b6 1c 00 00       	call   80105190 <acquire>
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
801034ef:	e8 dc 0b 00 00       	call   801040d0 <wakeup>
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
80103514:	e9 17 1d 00 00       	jmp    80105230 <release>
80103519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->readopen = 0;
80103520:	31 c9                	xor    %ecx,%ecx
    wakeup(&p->nwrite);
80103522:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103528:	89 8b 3c 02 00 00    	mov    %ecx,0x23c(%ebx)
    wakeup(&p->nwrite);
8010352e:	89 04 24             	mov    %eax,(%esp)
80103531:	e8 9a 0b 00 00       	call   801040d0 <wakeup>
80103536:	eb bc                	jmp    801034f4 <pipeclose+0x34>
80103538:	90                   	nop
80103539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103540:	89 1c 24             	mov    %ebx,(%esp)
80103543:	e8 e8 1c 00 00       	call   80105230 <release>
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
8010356f:	e8 1c 1c 00 00       	call   80105190 <acquire>
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
801035c3:	e8 08 0b 00 00       	call   801040d0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035c8:	89 7c 24 04          	mov    %edi,0x4(%esp)
801035cc:	89 1c 24             	mov    %ebx,(%esp)
801035cf:	e8 3c 09 00 00       	call   80103f10 <sleep>
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
801035f3:	e8 78 03 00 00       	call   80103970 <myproc>
801035f8:	8b 50 24             	mov    0x24(%eax),%edx
801035fb:	85 d2                	test   %edx,%edx
801035fd:	74 c1                	je     801035c0 <pipewrite+0x60>
        release(&p->lock);
801035ff:	89 3c 24             	mov    %edi,(%esp)
80103602:	e8 29 1c 00 00       	call   80105230 <release>
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
8010364f:	e8 7c 0a 00 00       	call   801040d0 <wakeup>
  release(&p->lock);
80103654:	89 3c 24             	mov    %edi,(%esp)
80103657:	e8 d4 1b 00 00       	call   80105230 <release>
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
80103682:	e8 09 1b 00 00       	call   80105190 <acquire>
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
801036b7:	e8 54 08 00 00       	call   80103f10 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036bc:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801036c2:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801036c8:	75 36                	jne    80103700 <piperead+0x90>
801036ca:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
801036d0:	85 d2                	test   %edx,%edx
801036d2:	0f 84 88 00 00 00    	je     80103760 <piperead+0xf0>
    if(myproc()->killed){
801036d8:	e8 93 02 00 00       	call   80103970 <myproc>
801036dd:	8b 48 24             	mov    0x24(%eax),%ecx
801036e0:	85 c9                	test   %ecx,%ecx
801036e2:	74 cc                	je     801036b0 <piperead+0x40>
      release(&p->lock);
801036e4:	89 34 24             	mov    %esi,(%esp)
      return -1;
801036e7:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801036ec:	e8 3f 1b 00 00       	call   80105230 <release>
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
80103744:	e8 87 09 00 00       	call   801040d0 <wakeup>
  release(&p->lock);
80103749:	89 34 24             	mov    %esi,(%esp)
8010374c:	e8 df 1a 00 00       	call   80105230 <release>
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
80103783:	e8 08 1a 00 00       	call   80105190 <acquire>
80103788:	eb 11                	jmp    8010379b <allocproc+0x2b>
8010378a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103790:	83 c3 7c             	add    $0x7c,%ebx
80103793:	81 fb b4 5c 11 80    	cmp    $0x80115cb4,%ebx
80103799:	73 7d                	jae    80103818 <allocproc+0xa8>
    if(p->state == UNUSED)
8010379b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010379e:	85 c0                	test   %eax,%eax
801037a0:	75 ee                	jne    80103790 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801037a2:	a1 04 b0 10 80       	mov    0x8010b004,%eax
  p->state = EMBRYO;
801037a7:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
801037ae:	8d 50 01             	lea    0x1(%eax),%edx
801037b1:	89 43 10             	mov    %eax,0x10(%ebx)

  release(&ptable.lock);
801037b4:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
  p->pid = nextpid++;
801037bb:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
801037c1:	e8 6a 1a 00 00       	call   80105230 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801037c6:	e8 e5 ed ff ff       	call   801025b0 <kalloc>
801037cb:	85 c0                	test   %eax,%eax
801037cd:	89 43 08             	mov    %eax,0x8(%ebx)
801037d0:	74 5c                	je     8010382e <allocproc+0xbe>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801037d2:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801037d8:	b9 14 00 00 00       	mov    $0x14,%ecx
  sp -= sizeof *p->tf;
801037dd:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
801037e0:	ba 25 64 10 80       	mov    $0x80106425,%edx
  sp -= sizeof *p->context;
801037e5:	05 9c 0f 00 00       	add    $0xf9c,%eax
  *(uint*)sp = (uint)trapret;
801037ea:	89 50 14             	mov    %edx,0x14(%eax)
  memset(p->context, 0, sizeof *p->context);
801037ed:	31 d2                	xor    %edx,%edx
  p->context = (struct context*)sp;
801037ef:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801037f2:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801037f6:	89 54 24 04          	mov    %edx,0x4(%esp)
801037fa:	89 04 24             	mov    %eax,(%esp)
801037fd:	e8 7e 1a 00 00       	call   80105280 <memset>
  p->context->eip = (uint)forkret;
80103802:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103805:	c7 40 10 40 38 10 80 	movl   $0x80103840,0x10(%eax)

  return p;
}
8010380c:	83 c4 14             	add    $0x14,%esp
8010380f:	89 d8                	mov    %ebx,%eax
80103811:	5b                   	pop    %ebx
80103812:	5d                   	pop    %ebp
80103813:	c3                   	ret    
80103814:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80103818:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
  return 0;
8010381f:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103821:	e8 0a 1a 00 00       	call   80105230 <release>
}
80103826:	83 c4 14             	add    $0x14,%esp
80103829:	89 d8                	mov    %ebx,%eax
8010382b:	5b                   	pop    %ebx
8010382c:	5d                   	pop    %ebp
8010382d:	c3                   	ret    
    p->state = UNUSED;
8010382e:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103835:	31 db                	xor    %ebx,%ebx
80103837:	eb d3                	jmp    8010380c <allocproc+0x9c>
80103839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103840 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103840:	55                   	push   %ebp
80103841:	89 e5                	mov    %esp,%ebp
80103843:	83 ec 18             	sub    $0x18,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103846:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
8010384d:	e8 de 19 00 00       	call   80105230 <release>

  if (first) {
80103852:	8b 15 00 b0 10 80    	mov    0x8010b000,%edx
80103858:	85 d2                	test   %edx,%edx
8010385a:	75 04                	jne    80103860 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010385c:	c9                   	leave  
8010385d:	c3                   	ret    
8010385e:	66 90                	xchg   %ax,%ax
    first = 0;
80103860:	31 c0                	xor    %eax,%eax
    iinit(ROOTDEV);
80103862:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    first = 0;
80103869:	a3 00 b0 10 80       	mov    %eax,0x8010b000
    iinit(ROOTDEV);
8010386e:	e8 3d dc ff ff       	call   801014b0 <iinit>
    initlog(ROOTDEV);
80103873:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010387a:	e8 71 f3 ff ff       	call   80102bf0 <initlog>
}
8010387f:	c9                   	leave  
80103880:	c3                   	ret    
80103881:	eb 0d                	jmp    80103890 <getAccumulator>
80103883:	90                   	nop
80103884:	90                   	nop
80103885:	90                   	nop
80103886:	90                   	nop
80103887:	90                   	nop
80103888:	90                   	nop
80103889:	90                   	nop
8010388a:	90                   	nop
8010388b:	90                   	nop
8010388c:	90                   	nop
8010388d:	90                   	nop
8010388e:	90                   	nop
8010388f:	90                   	nop

80103890 <getAccumulator>:
long long getAccumulator(struct proc *p) {
80103890:	55                   	push   %ebp
80103891:	89 e5                	mov    %esp,%ebp
80103893:	83 ec 18             	sub    $0x18,%esp
	panic("getAccumulator: not implemented\n");
80103896:	c7 04 24 88 82 10 80 	movl   $0x80108288,(%esp)
8010389d:	e8 ce ca ff ff       	call   80100370 <panic>
801038a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801038b0 <pinit>:
{
801038b0:	55                   	push   %ebp
  initlock(&ptable.lock, "ptable");
801038b1:	b8 d2 82 10 80       	mov    $0x801082d2,%eax
{
801038b6:	89 e5                	mov    %esp,%ebp
801038b8:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
801038bb:	89 44 24 04          	mov    %eax,0x4(%esp)
801038bf:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
801038c6:	e8 75 17 00 00       	call   80105040 <initlock>
}
801038cb:	c9                   	leave  
801038cc:	c3                   	ret    
801038cd:	8d 76 00             	lea    0x0(%esi),%esi

801038d0 <mycpu>:
{
801038d0:	55                   	push   %ebp
801038d1:	89 e5                	mov    %esp,%ebp
801038d3:	56                   	push   %esi
801038d4:	53                   	push   %ebx
801038d5:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801038d8:	9c                   	pushf  
801038d9:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801038da:	f6 c4 02             	test   $0x2,%ah
801038dd:	75 5b                	jne    8010393a <mycpu+0x6a>
  apicid = lapicid();
801038df:	e8 4c ef ff ff       	call   80102830 <lapicid>
  for (i = 0; i < ncpu; ++i) {
801038e4:	8b 35 60 3d 11 80    	mov    0x80113d60,%esi
801038ea:	85 f6                	test   %esi,%esi
801038ec:	7e 40                	jle    8010392e <mycpu+0x5e>
    if (cpus[i].apicid == apicid)
801038ee:	0f b6 15 e0 37 11 80 	movzbl 0x801137e0,%edx
801038f5:	39 d0                	cmp    %edx,%eax
801038f7:	74 2e                	je     80103927 <mycpu+0x57>
801038f9:	b9 90 38 11 80       	mov    $0x80113890,%ecx
  for (i = 0; i < ncpu; ++i) {
801038fe:	31 d2                	xor    %edx,%edx
80103900:	42                   	inc    %edx
80103901:	39 f2                	cmp    %esi,%edx
80103903:	74 29                	je     8010392e <mycpu+0x5e>
    if (cpus[i].apicid == apicid)
80103905:	0f b6 19             	movzbl (%ecx),%ebx
80103908:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
8010390e:	39 c3                	cmp    %eax,%ebx
80103910:	75 ee                	jne    80103900 <mycpu+0x30>
80103912:	8d 04 92             	lea    (%edx,%edx,4),%eax
80103915:	8d 04 42             	lea    (%edx,%eax,2),%eax
80103918:	c1 e0 04             	shl    $0x4,%eax
8010391b:	05 e0 37 11 80       	add    $0x801137e0,%eax
}
80103920:	83 c4 10             	add    $0x10,%esp
80103923:	5b                   	pop    %ebx
80103924:	5e                   	pop    %esi
80103925:	5d                   	pop    %ebp
80103926:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103927:	b8 e0 37 11 80       	mov    $0x801137e0,%eax
      return &cpus[i];
8010392c:	eb f2                	jmp    80103920 <mycpu+0x50>
  panic("unknown apicid\n");
8010392e:	c7 04 24 d9 82 10 80 	movl   $0x801082d9,(%esp)
80103935:	e8 36 ca ff ff       	call   80100370 <panic>
    panic("mycpu called with interrupts enabled\n");
8010393a:	c7 04 24 ac 82 10 80 	movl   $0x801082ac,(%esp)
80103941:	e8 2a ca ff ff       	call   80100370 <panic>
80103946:	8d 76 00             	lea    0x0(%esi),%esi
80103949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103950 <cpuid>:
cpuid() {
80103950:	55                   	push   %ebp
80103951:	89 e5                	mov    %esp,%ebp
80103953:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103956:	e8 75 ff ff ff       	call   801038d0 <mycpu>
}
8010395b:	c9                   	leave  
  return mycpu()-cpus;
8010395c:	2d e0 37 11 80       	sub    $0x801137e0,%eax
80103961:	c1 f8 04             	sar    $0x4,%eax
80103964:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010396a:	c3                   	ret    
8010396b:	90                   	nop
8010396c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103970 <myproc>:
myproc(void) {
80103970:	55                   	push   %ebp
80103971:	89 e5                	mov    %esp,%ebp
80103973:	53                   	push   %ebx
80103974:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103977:	e8 34 17 00 00       	call   801050b0 <pushcli>
  c = mycpu();
8010397c:	e8 4f ff ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103981:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103987:	e8 64 17 00 00       	call   801050f0 <popcli>
}
8010398c:	5a                   	pop    %edx
8010398d:	89 d8                	mov    %ebx,%eax
8010398f:	5b                   	pop    %ebx
80103990:	5d                   	pop    %ebp
80103991:	c3                   	ret    
80103992:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801039a0 <userinit>:
{
801039a0:	55                   	push   %ebp
801039a1:	89 e5                	mov    %esp,%ebp
801039a3:	53                   	push   %ebx
801039a4:	83 ec 14             	sub    $0x14,%esp
  p = allocproc();
801039a7:	e8 c4 fd ff ff       	call   80103770 <allocproc>
801039ac:	89 c3                	mov    %eax,%ebx
  initproc = p;
801039ae:	a3 b8 b5 10 80       	mov    %eax,0x8010b5b8
  if((p->pgdir = setupkvm()) == 0)
801039b3:	e8 78 40 00 00       	call   80107a30 <setupkvm>
801039b8:	85 c0                	test   %eax,%eax
801039ba:	89 43 04             	mov    %eax,0x4(%ebx)
801039bd:	0f 84 cf 00 00 00    	je     80103a92 <userinit+0xf2>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801039c3:	b9 60 b4 10 80       	mov    $0x8010b460,%ecx
801039c8:	ba 2c 00 00 00       	mov    $0x2c,%edx
801039cd:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801039d1:	89 54 24 08          	mov    %edx,0x8(%esp)
801039d5:	89 04 24             	mov    %eax,(%esp)
801039d8:	e8 23 3d 00 00       	call   80107700 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
801039dd:	b8 4c 00 00 00       	mov    $0x4c,%eax
  p->sz = PGSIZE;
801039e2:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801039e8:	89 44 24 08          	mov    %eax,0x8(%esp)
801039ec:	31 c0                	xor    %eax,%eax
801039ee:	89 44 24 04          	mov    %eax,0x4(%esp)
801039f2:	8b 43 18             	mov    0x18(%ebx),%eax
801039f5:	89 04 24             	mov    %eax,(%esp)
801039f8:	e8 83 18 00 00       	call   80105280 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801039fd:	8b 43 18             	mov    0x18(%ebx),%eax
80103a00:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a06:	8b 43 18             	mov    0x18(%ebx),%eax
80103a09:	66 c7 40 2c 23 00    	movw   $0x23,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103a0f:	8b 43 18             	mov    0x18(%ebx),%eax
80103a12:	8b 50 2c             	mov    0x2c(%eax),%edx
80103a15:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103a19:	8b 43 18             	mov    0x18(%ebx),%eax
80103a1c:	8b 50 2c             	mov    0x2c(%eax),%edx
80103a1f:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103a23:	8b 43 18             	mov    0x18(%ebx),%eax
80103a26:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103a2d:	8b 43 18             	mov    0x18(%ebx),%eax
80103a30:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103a37:	8b 43 18             	mov    0x18(%ebx),%eax
80103a3a:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a41:	b8 10 00 00 00       	mov    $0x10,%eax
80103a46:	89 44 24 08          	mov    %eax,0x8(%esp)
80103a4a:	b8 02 83 10 80       	mov    $0x80108302,%eax
80103a4f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a53:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103a56:	89 04 24             	mov    %eax,(%esp)
80103a59:	e8 02 1a 00 00       	call   80105460 <safestrcpy>
  p->cwd = namei("/");
80103a5e:	c7 04 24 0b 83 10 80 	movl   $0x8010830b,(%esp)
80103a65:	e8 66 e5 ff ff       	call   80101fd0 <namei>
80103a6a:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103a6d:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103a74:	e8 17 17 00 00       	call   80105190 <acquire>
  p->state = RUNNABLE;
80103a79:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103a80:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103a87:	e8 a4 17 00 00       	call   80105230 <release>
}
80103a8c:	83 c4 14             	add    $0x14,%esp
80103a8f:	5b                   	pop    %ebx
80103a90:	5d                   	pop    %ebp
80103a91:	c3                   	ret    
    panic("userinit: out of memory?");
80103a92:	c7 04 24 e9 82 10 80 	movl   $0x801082e9,(%esp)
80103a99:	e8 d2 c8 ff ff       	call   80100370 <panic>
80103a9e:	66 90                	xchg   %ax,%ax

80103aa0 <growproc>:
{
80103aa0:	55                   	push   %ebp
80103aa1:	89 e5                	mov    %esp,%ebp
80103aa3:	56                   	push   %esi
80103aa4:	53                   	push   %ebx
80103aa5:	83 ec 10             	sub    $0x10,%esp
80103aa8:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103aab:	e8 00 16 00 00       	call   801050b0 <pushcli>
  c = mycpu();
80103ab0:	e8 1b fe ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103ab5:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103abb:	e8 30 16 00 00       	call   801050f0 <popcli>
  if(n > 0){
80103ac0:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103ac3:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103ac5:	7f 19                	jg     80103ae0 <growproc+0x40>
  } else if(n < 0){
80103ac7:	75 37                	jne    80103b00 <growproc+0x60>
  curproc->sz = sz;
80103ac9:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103acb:	89 1c 24             	mov    %ebx,(%esp)
80103ace:	e8 2d 3b 00 00       	call   80107600 <switchuvm>
  return 0;
80103ad3:	31 c0                	xor    %eax,%eax
}
80103ad5:	83 c4 10             	add    $0x10,%esp
80103ad8:	5b                   	pop    %ebx
80103ad9:	5e                   	pop    %esi
80103ada:	5d                   	pop    %ebp
80103adb:	c3                   	ret    
80103adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103ae0:	01 c6                	add    %eax,%esi
80103ae2:	89 74 24 08          	mov    %esi,0x8(%esp)
80103ae6:	89 44 24 04          	mov    %eax,0x4(%esp)
80103aea:	8b 43 04             	mov    0x4(%ebx),%eax
80103aed:	89 04 24             	mov    %eax,(%esp)
80103af0:	e8 5b 3d 00 00       	call   80107850 <allocuvm>
80103af5:	85 c0                	test   %eax,%eax
80103af7:	75 d0                	jne    80103ac9 <growproc+0x29>
      return -1;
80103af9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103afe:	eb d5                	jmp    80103ad5 <growproc+0x35>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103b00:	01 c6                	add    %eax,%esi
80103b02:	89 74 24 08          	mov    %esi,0x8(%esp)
80103b06:	89 44 24 04          	mov    %eax,0x4(%esp)
80103b0a:	8b 43 04             	mov    0x4(%ebx),%eax
80103b0d:	89 04 24             	mov    %eax,(%esp)
80103b10:	e8 6b 3e 00 00       	call   80107980 <deallocuvm>
80103b15:	85 c0                	test   %eax,%eax
80103b17:	75 b0                	jne    80103ac9 <growproc+0x29>
80103b19:	eb de                	jmp    80103af9 <growproc+0x59>
80103b1b:	90                   	nop
80103b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103b20 <fork>:
{
80103b20:	55                   	push   %ebp
80103b21:	89 e5                	mov    %esp,%ebp
80103b23:	57                   	push   %edi
80103b24:	56                   	push   %esi
80103b25:	53                   	push   %ebx
80103b26:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103b29:	e8 82 15 00 00       	call   801050b0 <pushcli>
  c = mycpu();
80103b2e:	e8 9d fd ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103b33:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
80103b39:	e8 b2 15 00 00       	call   801050f0 <popcli>
  if((np = allocproc()) == 0){
80103b3e:	e8 2d fc ff ff       	call   80103770 <allocproc>
80103b43:	85 c0                	test   %eax,%eax
80103b45:	0f 84 c4 00 00 00    	je     80103c0f <fork+0xef>
80103b4b:	89 c6                	mov    %eax,%esi
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103b4d:	8b 07                	mov    (%edi),%eax
80103b4f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103b53:	8b 47 04             	mov    0x4(%edi),%eax
80103b56:	89 04 24             	mov    %eax,(%esp)
80103b59:	e8 a2 3f 00 00       	call   80107b00 <copyuvm>
80103b5e:	85 c0                	test   %eax,%eax
80103b60:	89 46 04             	mov    %eax,0x4(%esi)
80103b63:	0f 84 ad 00 00 00    	je     80103c16 <fork+0xf6>
  np->sz = curproc->sz;
80103b69:	8b 07                	mov    (%edi),%eax
  np->parent = curproc;
80103b6b:	89 7e 14             	mov    %edi,0x14(%esi)
  *np->tf = *curproc->tf;
80103b6e:	8b 56 18             	mov    0x18(%esi),%edx
  np->sz = curproc->sz;
80103b71:	89 06                	mov    %eax,(%esi)
  *np->tf = *curproc->tf;
80103b73:	31 c0                	xor    %eax,%eax
80103b75:	8b 4f 18             	mov    0x18(%edi),%ecx
80103b78:	8b 1c 01             	mov    (%ecx,%eax,1),%ebx
80103b7b:	89 1c 02             	mov    %ebx,(%edx,%eax,1)
80103b7e:	83 c0 04             	add    $0x4,%eax
80103b81:	83 f8 4c             	cmp    $0x4c,%eax
80103b84:	72 f2                	jb     80103b78 <fork+0x58>
  np->tf->eax = 0;
80103b86:	8b 46 18             	mov    0x18(%esi),%eax
  for(i = 0; i < NOFILE; i++)
80103b89:	31 db                	xor    %ebx,%ebx
  np->tf->eax = 0;
80103b8b:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103b92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(curproc->ofile[i])
80103ba0:	8b 44 9f 28          	mov    0x28(%edi,%ebx,4),%eax
80103ba4:	85 c0                	test   %eax,%eax
80103ba6:	74 0c                	je     80103bb4 <fork+0x94>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103ba8:	89 04 24             	mov    %eax,(%esp)
80103bab:	e8 30 d2 ff ff       	call   80100de0 <filedup>
80103bb0:	89 44 9e 28          	mov    %eax,0x28(%esi,%ebx,4)
  for(i = 0; i < NOFILE; i++)
80103bb4:	43                   	inc    %ebx
80103bb5:	83 fb 10             	cmp    $0x10,%ebx
80103bb8:	75 e6                	jne    80103ba0 <fork+0x80>
  np->cwd = idup(curproc->cwd);
80103bba:	8b 47 68             	mov    0x68(%edi),%eax
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103bbd:	83 c7 6c             	add    $0x6c,%edi
  np->cwd = idup(curproc->cwd);
80103bc0:	89 04 24             	mov    %eax,(%esp)
80103bc3:	e8 f8 da ff ff       	call   801016c0 <idup>
80103bc8:	89 46 68             	mov    %eax,0x68(%esi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103bcb:	b8 10 00 00 00       	mov    $0x10,%eax
80103bd0:	89 44 24 08          	mov    %eax,0x8(%esp)
80103bd4:	8d 46 6c             	lea    0x6c(%esi),%eax
80103bd7:	89 7c 24 04          	mov    %edi,0x4(%esp)
80103bdb:	89 04 24             	mov    %eax,(%esp)
80103bde:	e8 7d 18 00 00       	call   80105460 <safestrcpy>
  pid = np->pid;
80103be3:	8b 5e 10             	mov    0x10(%esi),%ebx
  acquire(&ptable.lock);
80103be6:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103bed:	e8 9e 15 00 00       	call   80105190 <acquire>
  np->state = RUNNABLE;
80103bf2:	c7 46 0c 03 00 00 00 	movl   $0x3,0xc(%esi)
  release(&ptable.lock);
80103bf9:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103c00:	e8 2b 16 00 00       	call   80105230 <release>
}
80103c05:	83 c4 1c             	add    $0x1c,%esp
80103c08:	89 d8                	mov    %ebx,%eax
80103c0a:	5b                   	pop    %ebx
80103c0b:	5e                   	pop    %esi
80103c0c:	5f                   	pop    %edi
80103c0d:	5d                   	pop    %ebp
80103c0e:	c3                   	ret    
    return -1;
80103c0f:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103c14:	eb ef                	jmp    80103c05 <fork+0xe5>
    kfree(np->kstack);
80103c16:	8b 46 08             	mov    0x8(%esi),%eax
    return -1;
80103c19:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    kfree(np->kstack);
80103c1e:	89 04 24             	mov    %eax,(%esp)
80103c21:	e8 ba e7 ff ff       	call   801023e0 <kfree>
    np->kstack = 0;
80103c26:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
    np->state = UNUSED;
80103c2d:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    return -1;
80103c34:	eb cf                	jmp    80103c05 <fork+0xe5>
80103c36:	8d 76 00             	lea    0x0(%esi),%esi
80103c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c40 <scheduler>:
{
80103c40:	55                   	push   %ebp
80103c41:	89 e5                	mov    %esp,%ebp
80103c43:	57                   	push   %edi
80103c44:	56                   	push   %esi
80103c45:	53                   	push   %ebx
80103c46:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
80103c49:	e8 82 fc ff ff       	call   801038d0 <mycpu>
  c->proc = 0;
80103c4e:	31 d2                	xor    %edx,%edx
  struct cpu *c = mycpu();
80103c50:	89 c7                	mov    %eax,%edi
  c->proc = 0;
80103c52:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
80103c58:	8d 70 04             	lea    0x4(%eax),%esi
80103c5b:	90                   	nop
80103c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("sti");
80103c60:	fb                   	sti    
    acquire(&ptable.lock);
80103c61:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c68:	bb b4 3d 11 80       	mov    $0x80113db4,%ebx
    acquire(&ptable.lock);
80103c6d:	e8 1e 15 00 00       	call   80105190 <acquire>
80103c72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(p->state != RUNNABLE)
80103c80:	8b 53 0c             	mov    0xc(%ebx),%edx
80103c83:	83 fa 03             	cmp    $0x3,%edx
80103c86:	75 31                	jne    80103cb9 <scheduler+0x79>
      c->proc = p;
80103c88:	89 9f ac 00 00 00    	mov    %ebx,0xac(%edi)
      switchuvm(p);
80103c8e:	89 1c 24             	mov    %ebx,(%esp)
80103c91:	e8 6a 39 00 00       	call   80107600 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103c96:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103c99:	89 34 24             	mov    %esi,(%esp)
      p->state = RUNNING;
80103c9c:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103ca3:	89 44 24 04          	mov    %eax,0x4(%esp)
80103ca7:	e8 0d 18 00 00       	call   801054b9 <swtch>
      switchkvm();
80103cac:	e8 2f 39 00 00       	call   801075e0 <switchkvm>
      c->proc = 0;
80103cb1:	31 c0                	xor    %eax,%eax
80103cb3:	89 87 ac 00 00 00    	mov    %eax,0xac(%edi)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103cb9:	83 c3 7c             	add    $0x7c,%ebx
80103cbc:	81 fb b4 5c 11 80    	cmp    $0x80115cb4,%ebx
80103cc2:	72 bc                	jb     80103c80 <scheduler+0x40>
    release(&ptable.lock);
80103cc4:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103ccb:	e8 60 15 00 00       	call   80105230 <release>
    sti();
80103cd0:	eb 8e                	jmp    80103c60 <scheduler+0x20>
80103cd2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ce0 <sched>:
{
80103ce0:	55                   	push   %ebp
80103ce1:	89 e5                	mov    %esp,%ebp
80103ce3:	56                   	push   %esi
80103ce4:	53                   	push   %ebx
80103ce5:	83 ec 10             	sub    $0x10,%esp
  pushcli();
80103ce8:	e8 c3 13 00 00       	call   801050b0 <pushcli>
  c = mycpu();
80103ced:	e8 de fb ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103cf2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103cf8:	e8 f3 13 00 00       	call   801050f0 <popcli>
  if(!holding(&ptable.lock))
80103cfd:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103d04:	e8 47 14 00 00       	call   80105150 <holding>
80103d09:	85 c0                	test   %eax,%eax
80103d0b:	74 51                	je     80103d5e <sched+0x7e>
  if(mycpu()->ncli != 1)
80103d0d:	e8 be fb ff ff       	call   801038d0 <mycpu>
80103d12:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103d19:	75 67                	jne    80103d82 <sched+0xa2>
  if(p->state == RUNNING)
80103d1b:	8b 43 0c             	mov    0xc(%ebx),%eax
80103d1e:	83 f8 04             	cmp    $0x4,%eax
80103d21:	74 53                	je     80103d76 <sched+0x96>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103d23:	9c                   	pushf  
80103d24:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103d25:	f6 c4 02             	test   $0x2,%ah
80103d28:	75 40                	jne    80103d6a <sched+0x8a>
  intena = mycpu()->intena;
80103d2a:	e8 a1 fb ff ff       	call   801038d0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103d2f:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103d32:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103d38:	e8 93 fb ff ff       	call   801038d0 <mycpu>
80103d3d:	8b 40 04             	mov    0x4(%eax),%eax
80103d40:	89 1c 24             	mov    %ebx,(%esp)
80103d43:	89 44 24 04          	mov    %eax,0x4(%esp)
80103d47:	e8 6d 17 00 00       	call   801054b9 <swtch>
  mycpu()->intena = intena;
80103d4c:	e8 7f fb ff ff       	call   801038d0 <mycpu>
80103d51:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103d57:	83 c4 10             	add    $0x10,%esp
80103d5a:	5b                   	pop    %ebx
80103d5b:	5e                   	pop    %esi
80103d5c:	5d                   	pop    %ebp
80103d5d:	c3                   	ret    
    panic("sched ptable.lock");
80103d5e:	c7 04 24 0d 83 10 80 	movl   $0x8010830d,(%esp)
80103d65:	e8 06 c6 ff ff       	call   80100370 <panic>
    panic("sched interruptible");
80103d6a:	c7 04 24 39 83 10 80 	movl   $0x80108339,(%esp)
80103d71:	e8 fa c5 ff ff       	call   80100370 <panic>
    panic("sched running");
80103d76:	c7 04 24 2b 83 10 80 	movl   $0x8010832b,(%esp)
80103d7d:	e8 ee c5 ff ff       	call   80100370 <panic>
    panic("sched locks");
80103d82:	c7 04 24 1f 83 10 80 	movl   $0x8010831f,(%esp)
80103d89:	e8 e2 c5 ff ff       	call   80100370 <panic>
80103d8e:	66 90                	xchg   %ax,%ax

80103d90 <exit>:
{
80103d90:	55                   	push   %ebp
80103d91:	89 e5                	mov    %esp,%ebp
80103d93:	57                   	push   %edi
80103d94:	56                   	push   %esi
80103d95:	53                   	push   %ebx
80103d96:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103d99:	e8 12 13 00 00       	call   801050b0 <pushcli>
  c = mycpu();
80103d9e:	e8 2d fb ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103da3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103da9:	e8 42 13 00 00       	call   801050f0 <popcli>
  if(curproc == initproc)
80103dae:	39 1d b8 b5 10 80    	cmp    %ebx,0x8010b5b8
80103db4:	0f 84 ee 00 00 00    	je     80103ea8 <exit+0x118>
80103dba:	8d 73 28             	lea    0x28(%ebx),%esi
80103dbd:	8d 7b 68             	lea    0x68(%ebx),%edi
    if(curproc->ofile[fd]){
80103dc0:	8b 06                	mov    (%esi),%eax
80103dc2:	85 c0                	test   %eax,%eax
80103dc4:	74 0e                	je     80103dd4 <exit+0x44>
      fileclose(curproc->ofile[fd]);
80103dc6:	89 04 24             	mov    %eax,(%esp)
80103dc9:	e8 62 d0 ff ff       	call   80100e30 <fileclose>
      curproc->ofile[fd] = 0;
80103dce:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103dd4:	83 c6 04             	add    $0x4,%esi
  for(fd = 0; fd < NOFILE; fd++){
80103dd7:	39 fe                	cmp    %edi,%esi
80103dd9:	75 e5                	jne    80103dc0 <exit+0x30>
  begin_op();
80103ddb:	e8 b0 ee ff ff       	call   80102c90 <begin_op>
  iput(curproc->cwd);
80103de0:	8b 43 68             	mov    0x68(%ebx),%eax
80103de3:	89 04 24             	mov    %eax,(%esp)
80103de6:	e8 35 da ff ff       	call   80101820 <iput>
  end_op();
80103deb:	e8 10 ef ff ff       	call   80102d00 <end_op>
  curproc->cwd = 0;
80103df0:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80103df7:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103dfe:	e8 8d 13 00 00       	call   80105190 <acquire>
  wakeup1(curproc->parent);
80103e03:	8b 4b 14             	mov    0x14(%ebx),%ecx
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e06:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
80103e0b:	eb 0d                	jmp    80103e1a <exit+0x8a>
80103e0d:	8d 76 00             	lea    0x0(%esi),%esi
80103e10:	83 c0 7c             	add    $0x7c,%eax
80103e13:	3d b4 5c 11 80       	cmp    $0x80115cb4,%eax
80103e18:	73 1e                	jae    80103e38 <exit+0xa8>
    if(p->state == SLEEPING && p->chan == chan)
80103e1a:	8b 50 0c             	mov    0xc(%eax),%edx
80103e1d:	83 fa 02             	cmp    $0x2,%edx
80103e20:	75 ee                	jne    80103e10 <exit+0x80>
80103e22:	3b 48 20             	cmp    0x20(%eax),%ecx
80103e25:	75 e9                	jne    80103e10 <exit+0x80>
      p->state = RUNNABLE;
80103e27:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e2e:	83 c0 7c             	add    $0x7c,%eax
80103e31:	3d b4 5c 11 80       	cmp    $0x80115cb4,%eax
80103e36:	72 e2                	jb     80103e1a <exit+0x8a>
      p->parent = initproc;
80103e38:	8b 35 b8 b5 10 80    	mov    0x8010b5b8,%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e3e:	b9 b4 3d 11 80       	mov    $0x80113db4,%ecx
80103e43:	eb 0e                	jmp    80103e53 <exit+0xc3>
80103e45:	8d 76 00             	lea    0x0(%esi),%esi
80103e48:	83 c1 7c             	add    $0x7c,%ecx
80103e4b:	81 f9 b4 5c 11 80    	cmp    $0x80115cb4,%ecx
80103e51:	73 3d                	jae    80103e90 <exit+0x100>
    if(p->parent == curproc){
80103e53:	39 59 14             	cmp    %ebx,0x14(%ecx)
80103e56:	75 f0                	jne    80103e48 <exit+0xb8>
      if(p->state == ZOMBIE)
80103e58:	8b 41 0c             	mov    0xc(%ecx),%eax
      p->parent = initproc;
80103e5b:	89 71 14             	mov    %esi,0x14(%ecx)
      if(p->state == ZOMBIE)
80103e5e:	83 f8 05             	cmp    $0x5,%eax
80103e61:	75 e5                	jne    80103e48 <exit+0xb8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e63:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
80103e68:	eb 10                	jmp    80103e7a <exit+0xea>
80103e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103e70:	83 c0 7c             	add    $0x7c,%eax
80103e73:	3d b4 5c 11 80       	cmp    $0x80115cb4,%eax
80103e78:	73 ce                	jae    80103e48 <exit+0xb8>
    if(p->state == SLEEPING && p->chan == chan)
80103e7a:	8b 50 0c             	mov    0xc(%eax),%edx
80103e7d:	83 fa 02             	cmp    $0x2,%edx
80103e80:	75 ee                	jne    80103e70 <exit+0xe0>
80103e82:	3b 70 20             	cmp    0x20(%eax),%esi
80103e85:	75 e9                	jne    80103e70 <exit+0xe0>
      p->state = RUNNABLE;
80103e87:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103e8e:	eb e0                	jmp    80103e70 <exit+0xe0>
  curproc->state = ZOMBIE;
80103e90:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103e97:	e8 44 fe ff ff       	call   80103ce0 <sched>
  panic("zombie exit");
80103e9c:	c7 04 24 5a 83 10 80 	movl   $0x8010835a,(%esp)
80103ea3:	e8 c8 c4 ff ff       	call   80100370 <panic>
    panic("init exiting");
80103ea8:	c7 04 24 4d 83 10 80 	movl   $0x8010834d,(%esp)
80103eaf:	e8 bc c4 ff ff       	call   80100370 <panic>
80103eb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103eba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103ec0 <yield>:
{
80103ec0:	55                   	push   %ebp
80103ec1:	89 e5                	mov    %esp,%ebp
80103ec3:	53                   	push   %ebx
80103ec4:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103ec7:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103ece:	e8 bd 12 00 00       	call   80105190 <acquire>
  pushcli();
80103ed3:	e8 d8 11 00 00       	call   801050b0 <pushcli>
  c = mycpu();
80103ed8:	e8 f3 f9 ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103edd:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ee3:	e8 08 12 00 00       	call   801050f0 <popcli>
  myproc()->state = RUNNABLE;
80103ee8:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103eef:	e8 ec fd ff ff       	call   80103ce0 <sched>
  release(&ptable.lock);
80103ef4:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103efb:	e8 30 13 00 00       	call   80105230 <release>
}
80103f00:	83 c4 14             	add    $0x14,%esp
80103f03:	5b                   	pop    %ebx
80103f04:	5d                   	pop    %ebp
80103f05:	c3                   	ret    
80103f06:	8d 76 00             	lea    0x0(%esi),%esi
80103f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103f10 <sleep>:
{
80103f10:	55                   	push   %ebp
80103f11:	89 e5                	mov    %esp,%ebp
80103f13:	83 ec 28             	sub    $0x28,%esp
80103f16:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80103f19:	89 75 f8             	mov    %esi,-0x8(%ebp)
80103f1c:	8b 75 0c             	mov    0xc(%ebp),%esi
80103f1f:	89 7d fc             	mov    %edi,-0x4(%ebp)
80103f22:	8b 7d 08             	mov    0x8(%ebp),%edi
  pushcli();
80103f25:	e8 86 11 00 00       	call   801050b0 <pushcli>
  c = mycpu();
80103f2a:	e8 a1 f9 ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103f2f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f35:	e8 b6 11 00 00       	call   801050f0 <popcli>
  if(p == 0)
80103f3a:	85 db                	test   %ebx,%ebx
80103f3c:	0f 84 8d 00 00 00    	je     80103fcf <sleep+0xbf>
  if(lk == 0)
80103f42:	85 f6                	test   %esi,%esi
80103f44:	74 7d                	je     80103fc3 <sleep+0xb3>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103f46:	81 fe 80 3d 11 80    	cmp    $0x80113d80,%esi
80103f4c:	74 52                	je     80103fa0 <sleep+0x90>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103f4e:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103f55:	e8 36 12 00 00       	call   80105190 <acquire>
    release(lk);
80103f5a:	89 34 24             	mov    %esi,(%esp)
80103f5d:	e8 ce 12 00 00       	call   80105230 <release>
  p->chan = chan;
80103f62:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103f65:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103f6c:	e8 6f fd ff ff       	call   80103ce0 <sched>
  p->chan = 0;
80103f71:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103f78:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103f7f:	e8 ac 12 00 00       	call   80105230 <release>
}
80103f84:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    acquire(lk);
80103f87:	89 75 08             	mov    %esi,0x8(%ebp)
}
80103f8a:	8b 7d fc             	mov    -0x4(%ebp),%edi
80103f8d:	8b 75 f8             	mov    -0x8(%ebp),%esi
80103f90:	89 ec                	mov    %ebp,%esp
80103f92:	5d                   	pop    %ebp
    acquire(lk);
80103f93:	e9 f8 11 00 00       	jmp    80105190 <acquire>
80103f98:	90                   	nop
80103f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80103fa0:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103fa3:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103faa:	e8 31 fd ff ff       	call   80103ce0 <sched>
  p->chan = 0;
80103faf:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103fb6:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80103fb9:	8b 75 f8             	mov    -0x8(%ebp),%esi
80103fbc:	8b 7d fc             	mov    -0x4(%ebp),%edi
80103fbf:	89 ec                	mov    %ebp,%esp
80103fc1:	5d                   	pop    %ebp
80103fc2:	c3                   	ret    
    panic("sleep without lk");
80103fc3:	c7 04 24 6c 83 10 80 	movl   $0x8010836c,(%esp)
80103fca:	e8 a1 c3 ff ff       	call   80100370 <panic>
    panic("sleep");
80103fcf:	c7 04 24 66 83 10 80 	movl   $0x80108366,(%esp)
80103fd6:	e8 95 c3 ff ff       	call   80100370 <panic>
80103fdb:	90                   	nop
80103fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103fe0 <wait>:
{
80103fe0:	55                   	push   %ebp
80103fe1:	89 e5                	mov    %esp,%ebp
80103fe3:	56                   	push   %esi
80103fe4:	53                   	push   %ebx
80103fe5:	83 ec 10             	sub    $0x10,%esp
  pushcli();
80103fe8:	e8 c3 10 00 00       	call   801050b0 <pushcli>
  c = mycpu();
80103fed:	e8 de f8 ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103ff2:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103ff8:	e8 f3 10 00 00       	call   801050f0 <popcli>
  acquire(&ptable.lock);
80103ffd:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80104004:	e8 87 11 00 00       	call   80105190 <acquire>
    havekids = 0;
80104009:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010400b:	bb b4 3d 11 80       	mov    $0x80113db4,%ebx
80104010:	eb 11                	jmp    80104023 <wait+0x43>
80104012:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104018:	83 c3 7c             	add    $0x7c,%ebx
8010401b:	81 fb b4 5c 11 80    	cmp    $0x80115cb4,%ebx
80104021:	73 1d                	jae    80104040 <wait+0x60>
      if(p->parent != curproc)
80104023:	39 73 14             	cmp    %esi,0x14(%ebx)
80104026:	75 f0                	jne    80104018 <wait+0x38>
      if(p->state == ZOMBIE){
80104028:	8b 43 0c             	mov    0xc(%ebx),%eax
8010402b:	83 f8 05             	cmp    $0x5,%eax
8010402e:	74 30                	je     80104060 <wait+0x80>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104030:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
80104033:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104038:	81 fb b4 5c 11 80    	cmp    $0x80115cb4,%ebx
8010403e:	72 e3                	jb     80104023 <wait+0x43>
    if(!havekids || curproc->killed){
80104040:	85 c0                	test   %eax,%eax
80104042:	74 71                	je     801040b5 <wait+0xd5>
80104044:	8b 56 24             	mov    0x24(%esi),%edx
80104047:	85 d2                	test   %edx,%edx
80104049:	75 6a                	jne    801040b5 <wait+0xd5>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
8010404b:	b8 80 3d 11 80       	mov    $0x80113d80,%eax
80104050:	89 44 24 04          	mov    %eax,0x4(%esp)
80104054:	89 34 24             	mov    %esi,(%esp)
80104057:	e8 b4 fe ff ff       	call   80103f10 <sleep>
    havekids = 0;
8010405c:	eb ab                	jmp    80104009 <wait+0x29>
8010405e:	66 90                	xchg   %ax,%ax
        kfree(p->kstack);
80104060:	8b 43 08             	mov    0x8(%ebx),%eax
        pid = p->pid;
80104063:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104066:	89 04 24             	mov    %eax,(%esp)
80104069:	e8 72 e3 ff ff       	call   801023e0 <kfree>
        freevm(p->pgdir);
8010406e:	8b 43 04             	mov    0x4(%ebx),%eax
        p->kstack = 0;
80104071:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104078:	89 04 24             	mov    %eax,(%esp)
8010407b:	e8 30 39 00 00       	call   801079b0 <freevm>
        release(&ptable.lock);
80104080:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
        p->pid = 0;
80104087:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
8010408e:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104095:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104099:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801040a0:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801040a7:	e8 84 11 00 00       	call   80105230 <release>
}
801040ac:	83 c4 10             	add    $0x10,%esp
801040af:	89 f0                	mov    %esi,%eax
801040b1:	5b                   	pop    %ebx
801040b2:	5e                   	pop    %esi
801040b3:	5d                   	pop    %ebp
801040b4:	c3                   	ret    
      release(&ptable.lock);
801040b5:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
      return -1;
801040bc:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801040c1:	e8 6a 11 00 00       	call   80105230 <release>
      return -1;
801040c6:	eb e4                	jmp    801040ac <wait+0xcc>
801040c8:	90                   	nop
801040c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801040d0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801040d0:	55                   	push   %ebp
801040d1:	89 e5                	mov    %esp,%ebp
801040d3:	53                   	push   %ebx
801040d4:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);
801040d7:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
{
801040de:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801040e1:	e8 aa 10 00 00       	call   80105190 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040e6:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
801040eb:	eb 0d                	jmp    801040fa <wakeup+0x2a>
801040ed:	8d 76 00             	lea    0x0(%esi),%esi
801040f0:	83 c0 7c             	add    $0x7c,%eax
801040f3:	3d b4 5c 11 80       	cmp    $0x80115cb4,%eax
801040f8:	73 1e                	jae    80104118 <wakeup+0x48>
    if(p->state == SLEEPING && p->chan == chan)
801040fa:	8b 50 0c             	mov    0xc(%eax),%edx
801040fd:	83 fa 02             	cmp    $0x2,%edx
80104100:	75 ee                	jne    801040f0 <wakeup+0x20>
80104102:	3b 58 20             	cmp    0x20(%eax),%ebx
80104105:	75 e9                	jne    801040f0 <wakeup+0x20>
      p->state = RUNNABLE;
80104107:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010410e:	83 c0 7c             	add    $0x7c,%eax
80104111:	3d b4 5c 11 80       	cmp    $0x80115cb4,%eax
80104116:	72 e2                	jb     801040fa <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104118:	c7 45 08 80 3d 11 80 	movl   $0x80113d80,0x8(%ebp)
}
8010411f:	83 c4 14             	add    $0x14,%esp
80104122:	5b                   	pop    %ebx
80104123:	5d                   	pop    %ebp
  release(&ptable.lock);
80104124:	e9 07 11 00 00       	jmp    80105230 <release>
80104129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104130 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104130:	55                   	push   %ebp
80104131:	89 e5                	mov    %esp,%ebp
80104133:	53                   	push   %ebx
80104134:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;

  acquire(&ptable.lock);
80104137:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
{
8010413e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80104141:	e8 4a 10 00 00       	call   80105190 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104146:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
8010414b:	eb 0d                	jmp    8010415a <kill+0x2a>
8010414d:	8d 76 00             	lea    0x0(%esi),%esi
80104150:	83 c0 7c             	add    $0x7c,%eax
80104153:	3d b4 5c 11 80       	cmp    $0x80115cb4,%eax
80104158:	73 36                	jae    80104190 <kill+0x60>
    if(p->pid == pid){
8010415a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010415d:	75 f1                	jne    80104150 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010415f:	8b 50 0c             	mov    0xc(%eax),%edx
      p->killed = 1;
80104162:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
80104169:	83 fa 02             	cmp    $0x2,%edx
8010416c:	75 07                	jne    80104175 <kill+0x45>
        p->state = RUNNABLE;
8010416e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104175:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
8010417c:	e8 af 10 00 00       	call   80105230 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104181:	83 c4 14             	add    $0x14,%esp
      return 0;
80104184:	31 c0                	xor    %eax,%eax
}
80104186:	5b                   	pop    %ebx
80104187:	5d                   	pop    %ebp
80104188:	c3                   	ret    
80104189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104190:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80104197:	e8 94 10 00 00       	call   80105230 <release>
}
8010419c:	83 c4 14             	add    $0x14,%esp
  return -1;
8010419f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801041a4:	5b                   	pop    %ebx
801041a5:	5d                   	pop    %ebp
801041a6:	c3                   	ret    
801041a7:	89 f6                	mov    %esi,%esi
801041a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801041b0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801041b0:	55                   	push   %ebp
801041b1:	89 e5                	mov    %esp,%ebp
801041b3:	57                   	push   %edi
801041b4:	56                   	push   %esi
801041b5:	53                   	push   %ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041b6:	bb b4 3d 11 80       	mov    $0x80113db4,%ebx
{
801041bb:	83 ec 4c             	sub    $0x4c,%esp
801041be:	eb 1b                	jmp    801041db <procdump+0x2b>
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801041c0:	c7 04 24 d7 86 10 80 	movl   $0x801086d7,(%esp)
801041c7:	e8 84 c4 ff ff       	call   80100650 <cprintf>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041cc:	83 c3 7c             	add    $0x7c,%ebx
801041cf:	81 fb b4 5c 11 80    	cmp    $0x80115cb4,%ebx
801041d5:	0f 83 a5 00 00 00    	jae    80104280 <procdump+0xd0>
    if(p->state == UNUSED)
801041db:	8b 43 0c             	mov    0xc(%ebx),%eax
801041de:	85 c0                	test   %eax,%eax
801041e0:	74 ea                	je     801041cc <procdump+0x1c>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801041e2:	8b 43 0c             	mov    0xc(%ebx),%eax
      state = "???";
801041e5:	b8 7d 83 10 80       	mov    $0x8010837d,%eax
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801041ea:	8b 53 0c             	mov    0xc(%ebx),%edx
801041ed:	83 fa 05             	cmp    $0x5,%edx
801041f0:	77 18                	ja     8010420a <procdump+0x5a>
801041f2:	8b 53 0c             	mov    0xc(%ebx),%edx
801041f5:	8b 14 95 b4 83 10 80 	mov    -0x7fef7c4c(,%edx,4),%edx
801041fc:	85 d2                	test   %edx,%edx
801041fe:	74 0a                	je     8010420a <procdump+0x5a>
      state = states[p->state];
80104200:	8b 43 0c             	mov    0xc(%ebx),%eax
80104203:	8b 04 85 b4 83 10 80 	mov    -0x7fef7c4c(,%eax,4),%eax
    cprintf("%d %s %s", p->pid, state, p->name);
8010420a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010420e:	8b 43 10             	mov    0x10(%ebx),%eax
80104211:	8d 53 6c             	lea    0x6c(%ebx),%edx
80104214:	89 54 24 0c          	mov    %edx,0xc(%esp)
80104218:	c7 04 24 81 83 10 80 	movl   $0x80108381,(%esp)
8010421f:	89 44 24 04          	mov    %eax,0x4(%esp)
80104223:	e8 28 c4 ff ff       	call   80100650 <cprintf>
    if(p->state == SLEEPING){
80104228:	8b 43 0c             	mov    0xc(%ebx),%eax
8010422b:	83 f8 02             	cmp    $0x2,%eax
8010422e:	75 90                	jne    801041c0 <procdump+0x10>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104230:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104233:	89 44 24 04          	mov    %eax,0x4(%esp)
80104237:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010423a:	8d 75 c0             	lea    -0x40(%ebp),%esi
8010423d:	8d 7d e8             	lea    -0x18(%ebp),%edi
80104240:	8b 40 0c             	mov    0xc(%eax),%eax
80104243:	83 c0 08             	add    $0x8,%eax
80104246:	89 04 24             	mov    %eax,(%esp)
80104249:	e8 12 0e 00 00       	call   80105060 <getcallerpcs>
8010424e:	66 90                	xchg   %ax,%ax
      for(i=0; i<10 && pc[i] != 0; i++)
80104250:	8b 16                	mov    (%esi),%edx
80104252:	85 d2                	test   %edx,%edx
80104254:	0f 84 66 ff ff ff    	je     801041c0 <procdump+0x10>
        cprintf(" %p", pc[i]);
8010425a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010425e:	83 c6 04             	add    $0x4,%esi
80104261:	c7 04 24 21 7d 10 80 	movl   $0x80107d21,(%esp)
80104268:	e8 e3 c3 ff ff       	call   80100650 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
8010426d:	39 f7                	cmp    %esi,%edi
8010426f:	75 df                	jne    80104250 <procdump+0xa0>
80104271:	e9 4a ff ff ff       	jmp    801041c0 <procdump+0x10>
80104276:	8d 76 00             	lea    0x0(%esi),%esi
80104279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }
}
80104280:	83 c4 4c             	add    $0x4c,%esp
80104283:	5b                   	pop    %ebx
80104284:	5e                   	pop    %esi
80104285:	5f                   	pop    %edi
80104286:	5d                   	pop    %ebp
80104287:	c3                   	ret    
80104288:	66 90                	xchg   %ax,%ax
8010428a:	66 90                	xchg   %ax,%ax
8010428c:	66 90                	xchg   %ax,%ax
8010428e:	66 90                	xchg   %ax,%ax

80104290 <isEmptyPriorityQueue>:
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
80104290:	a1 0c b6 10 80       	mov    0x8010b60c,%eax
static boolean isEmptyPriorityQueue() {
80104295:	55                   	push   %ebp
80104296:	89 e5                	mov    %esp,%ebp
}
80104298:	5d                   	pop    %ebp
	return !root;
80104299:	8b 00                	mov    (%eax),%eax
8010429b:	85 c0                	test   %eax,%eax
8010429d:	0f 94 c0             	sete   %al
801042a0:	0f b6 c0             	movzbl %al,%eax
}
801042a3:	c3                   	ret    
801042a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801042aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801042b0 <getMinAccumulatorPriorityQueue>:
	return !root;
801042b0:	a1 0c b6 10 80       	mov    0x8010b60c,%eax
801042b5:	8b 10                	mov    (%eax),%edx
	
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
	if(isEmpty())
801042b7:	85 d2                	test   %edx,%edx
801042b9:	74 35                	je     801042f0 <getMinAccumulatorPriorityQueue+0x40>
static boolean getMinAccumulatorPriorityQueue(long long* pkey) {
801042bb:	55                   	push   %ebp
801042bc:	89 e5                	mov    %esp,%ebp
801042be:	53                   	push   %ebx
801042bf:	eb 09                	jmp    801042ca <getMinAccumulatorPriorityQueue+0x1a>
801042c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	while(minNode->left)
801042c8:	89 c2                	mov    %eax,%edx
801042ca:	8b 42 18             	mov    0x18(%edx),%eax
801042cd:	85 c0                	test   %eax,%eax
801042cf:	75 f7                	jne    801042c8 <getMinAccumulatorPriorityQueue+0x18>
	*pkey = getMinNode()->key;
801042d1:	8b 45 08             	mov    0x8(%ebp),%eax
801042d4:	8b 5a 04             	mov    0x4(%edx),%ebx
801042d7:	8b 0a                	mov    (%edx),%ecx
801042d9:	89 58 04             	mov    %ebx,0x4(%eax)
801042dc:	89 08                	mov    %ecx,(%eax)
801042de:	b8 01 00 00 00       	mov    $0x1,%eax
}
801042e3:	5b                   	pop    %ebx
801042e4:	5d                   	pop    %ebp
801042e5:	c3                   	ret    
801042e6:	8d 76 00             	lea    0x0(%esi),%esi
801042e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	if(isEmpty())
801042f0:	31 c0                	xor    %eax,%eax
}
801042f2:	c3                   	ret    
801042f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801042f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104300 <isEmptyRoundRobinQueue>:
	return !first;
80104300:	a1 08 b6 10 80       	mov    0x8010b608,%eax
static boolean isEmptyRoundRobinQueue() {
80104305:	55                   	push   %ebp
80104306:	89 e5                	mov    %esp,%ebp
}
80104308:	5d                   	pop    %ebp
	return !first;
80104309:	8b 00                	mov    (%eax),%eax
8010430b:	85 c0                	test   %eax,%eax
8010430d:	0f 94 c0             	sete   %al
80104310:	0f b6 c0             	movzbl %al,%eax
}
80104313:	c3                   	ret    
80104314:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010431a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104320 <enqueueRoundRobinQueue>:
	if(!freeLinks)
80104320:	a1 00 b6 10 80       	mov    0x8010b600,%eax
80104325:	85 c0                	test   %eax,%eax
80104327:	74 47                	je     80104370 <enqueueRoundRobinQueue+0x50>
static boolean enqueueRoundRobinQueue(Proc *p) {
80104329:	55                   	push   %ebp
	return roundRobinQ->enqueue(p);
8010432a:	8b 0d 08 b6 10 80    	mov    0x8010b608,%ecx
	freeLinks = freeLinks->next;
80104330:	8b 50 04             	mov    0x4(%eax),%edx
static boolean enqueueRoundRobinQueue(Proc *p) {
80104333:	89 e5                	mov    %esp,%ebp
	ans->next = null;
80104335:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
8010433c:	89 15 00 b6 10 80    	mov    %edx,0x8010b600
	ans->p = p;
80104342:	8b 55 08             	mov    0x8(%ebp),%edx
80104345:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80104347:	8b 11                	mov    (%ecx),%edx
80104349:	85 d2                	test   %edx,%edx
8010434b:	74 2b                	je     80104378 <enqueueRoundRobinQueue+0x58>
	else last->next = link;
8010434d:	8b 51 04             	mov    0x4(%ecx),%edx
80104350:	89 42 04             	mov    %eax,0x4(%edx)
80104353:	eb 05                	jmp    8010435a <enqueueRoundRobinQueue+0x3a>
80104355:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
80104358:	89 d0                	mov    %edx,%eax
8010435a:	8b 50 04             	mov    0x4(%eax),%edx
8010435d:	85 d2                	test   %edx,%edx
8010435f:	75 f7                	jne    80104358 <enqueueRoundRobinQueue+0x38>
	last = link->getLast();
80104361:	89 41 04             	mov    %eax,0x4(%ecx)
80104364:	b8 01 00 00 00       	mov    $0x1,%eax
}
80104369:	5d                   	pop    %ebp
8010436a:	c3                   	ret    
8010436b:	90                   	nop
8010436c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!freeLinks)
80104370:	31 c0                	xor    %eax,%eax
}
80104372:	c3                   	ret    
80104373:	90                   	nop
80104374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
80104378:	89 01                	mov    %eax,(%ecx)
8010437a:	eb de                	jmp    8010435a <enqueueRoundRobinQueue+0x3a>
8010437c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104380 <dequeueRoundRobinQueue>:
	return roundRobinQ->dequeue();
80104380:	8b 0d 08 b6 10 80    	mov    0x8010b608,%ecx
	return !first;
80104386:	8b 11                	mov    (%ecx),%edx
	if(isEmpty())
80104388:	85 d2                	test   %edx,%edx
8010438a:	74 3c                	je     801043c8 <dequeueRoundRobinQueue+0x48>
static Proc* dequeueRoundRobinQueue() {
8010438c:	55                   	push   %ebp
8010438d:	89 e5                	mov    %esp,%ebp
8010438f:	83 ec 08             	sub    $0x8,%esp
80104392:	89 75 fc             	mov    %esi,-0x4(%ebp)
	link->next = freeLinks;
80104395:	8b 35 00 b6 10 80    	mov    0x8010b600,%esi
static Proc* dequeueRoundRobinQueue() {
8010439b:	89 5d f8             	mov    %ebx,-0x8(%ebp)
	Link *next = first->next;
8010439e:	8b 5a 04             	mov    0x4(%edx),%ebx
	Proc *p = first->p;
801043a1:	8b 02                	mov    (%edx),%eax
	link->next = freeLinks;
801043a3:	89 72 04             	mov    %esi,0x4(%edx)
	freeLinks = link;
801043a6:	89 15 00 b6 10 80    	mov    %edx,0x8010b600
	if(isEmpty())
801043ac:	85 db                	test   %ebx,%ebx
	first = next;
801043ae:	89 19                	mov    %ebx,(%ecx)
	if(isEmpty())
801043b0:	75 07                	jne    801043b9 <dequeueRoundRobinQueue+0x39>
		last = null;
801043b2:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
}
801043b9:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801043bc:	8b 75 fc             	mov    -0x4(%ebp),%esi
801043bf:	89 ec                	mov    %ebp,%esp
801043c1:	5d                   	pop    %ebp
801043c2:	c3                   	ret    
801043c3:	90                   	nop
801043c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		return null;
801043c8:	31 c0                	xor    %eax,%eax
}
801043ca:	c3                   	ret    
801043cb:	90                   	nop
801043cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801043d0 <switchToPriorityQueuePolicyRoundRobinQueue>:
	if(!priorityQ->isEmpty())
801043d0:	8b 15 0c b6 10 80    	mov    0x8010b60c,%edx
801043d6:	31 c0                	xor    %eax,%eax
801043d8:	8b 0a                	mov    (%edx),%ecx
801043da:	85 c9                	test   %ecx,%ecx
801043dc:	74 02                	je     801043e0 <switchToPriorityQueuePolicyRoundRobinQueue+0x10>
}
801043de:	c3                   	ret    
801043df:	90                   	nop
	if(!freeNodes)
801043e0:	8b 0d fc b5 10 80    	mov    0x8010b5fc,%ecx
801043e6:	85 c9                	test   %ecx,%ecx
801043e8:	74 f4                	je     801043de <switchToPriorityQueuePolicyRoundRobinQueue+0xe>
static boolean switchToPriorityQueuePolicyRoundRobinQueue() {
801043ea:	55                   	push   %ebp
	return roundRobinQ->transfer();
801043eb:	a1 08 b6 10 80       	mov    0x8010b608,%eax
static boolean switchToPriorityQueuePolicyRoundRobinQueue() {
801043f0:	89 e5                	mov    %esp,%ebp
801043f2:	53                   	push   %ebx
	freeNodes = freeNodes->next;
801043f3:	8b 59 10             	mov    0x10(%ecx),%ebx
	ans->key = key;
801043f6:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
	ans->next = null;
801043fc:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
	ans->key = key;
80104403:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
	freeNodes = freeNodes->next;
8010440a:	89 1d fc b5 10 80    	mov    %ebx,0x8010b5fc
	node->listOfProcs.first = first;
80104410:	8b 18                	mov    (%eax),%ebx
80104412:	89 59 08             	mov    %ebx,0x8(%ecx)
	node->listOfProcs.last = last;
80104415:	8b 58 04             	mov    0x4(%eax),%ebx
80104418:	89 59 0c             	mov    %ebx,0xc(%ecx)
	first = last = null;
8010441b:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
80104422:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	priorityQ->root = node;
80104428:	b8 01 00 00 00       	mov    $0x1,%eax
8010442d:	89 0a                	mov    %ecx,(%edx)
}
8010442f:	5b                   	pop    %ebx
80104430:	5d                   	pop    %ebp
80104431:	c3                   	ret    
80104432:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104440 <isEmptyRunningProcessHolder>:
	return !first;
80104440:	a1 04 b6 10 80       	mov    0x8010b604,%eax
static boolean isEmptyRunningProcessHolder() {
80104445:	55                   	push   %ebp
80104446:	89 e5                	mov    %esp,%ebp
}
80104448:	5d                   	pop    %ebp
	return !first;
80104449:	8b 00                	mov    (%eax),%eax
8010444b:	85 c0                	test   %eax,%eax
8010444d:	0f 94 c0             	sete   %al
80104450:	0f b6 c0             	movzbl %al,%eax
}
80104453:	c3                   	ret    
80104454:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010445a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104460 <addRunningProcessHolder>:
	if(!freeLinks)
80104460:	a1 00 b6 10 80       	mov    0x8010b600,%eax
80104465:	85 c0                	test   %eax,%eax
80104467:	74 47                	je     801044b0 <addRunningProcessHolder+0x50>
static boolean addRunningProcessHolder(Proc* p) {
80104469:	55                   	push   %ebp
	return runningProcHolder->enqueue(p);
8010446a:	8b 0d 04 b6 10 80    	mov    0x8010b604,%ecx
	freeLinks = freeLinks->next;
80104470:	8b 50 04             	mov    0x4(%eax),%edx
static boolean addRunningProcessHolder(Proc* p) {
80104473:	89 e5                	mov    %esp,%ebp
	ans->next = null;
80104475:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
8010447c:	89 15 00 b6 10 80    	mov    %edx,0x8010b600
	ans->p = p;
80104482:	8b 55 08             	mov    0x8(%ebp),%edx
80104485:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80104487:	8b 11                	mov    (%ecx),%edx
80104489:	85 d2                	test   %edx,%edx
8010448b:	74 2b                	je     801044b8 <addRunningProcessHolder+0x58>
	else last->next = link;
8010448d:	8b 51 04             	mov    0x4(%ecx),%edx
80104490:	89 42 04             	mov    %eax,0x4(%edx)
80104493:	eb 05                	jmp    8010449a <addRunningProcessHolder+0x3a>
80104495:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
80104498:	89 d0                	mov    %edx,%eax
8010449a:	8b 50 04             	mov    0x4(%eax),%edx
8010449d:	85 d2                	test   %edx,%edx
8010449f:	75 f7                	jne    80104498 <addRunningProcessHolder+0x38>
	last = link->getLast();
801044a1:	89 41 04             	mov    %eax,0x4(%ecx)
801044a4:	b8 01 00 00 00       	mov    $0x1,%eax
}
801044a9:	5d                   	pop    %ebp
801044aa:	c3                   	ret    
801044ab:	90                   	nop
801044ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!freeLinks)
801044b0:	31 c0                	xor    %eax,%eax
}
801044b2:	c3                   	ret    
801044b3:	90                   	nop
801044b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
801044b8:	89 01                	mov    %eax,(%ecx)
801044ba:	eb de                	jmp    8010449a <addRunningProcessHolder+0x3a>
801044bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801044c0 <_ZL9allocNodeP4procx>:
static MapNode* allocNode(Proc *p, long long key) {
801044c0:	55                   	push   %ebp
801044c1:	89 e5                	mov    %esp,%ebp
801044c3:	56                   	push   %esi
801044c4:	53                   	push   %ebx
	if(!freeNodes)
801044c5:	8b 1d fc b5 10 80    	mov    0x8010b5fc,%ebx
801044cb:	85 db                	test   %ebx,%ebx
801044cd:	74 4d                	je     8010451c <_ZL9allocNodeP4procx+0x5c>
	ans->key = key;
801044cf:	89 13                	mov    %edx,(%ebx)
	if(!freeLinks)
801044d1:	8b 15 00 b6 10 80    	mov    0x8010b600,%edx
	freeNodes = freeNodes->next;
801044d7:	8b 73 10             	mov    0x10(%ebx),%esi
	ans->key = key;
801044da:	89 4b 04             	mov    %ecx,0x4(%ebx)
	ans->next = null;
801044dd:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
	if(!freeLinks)
801044e4:	85 d2                	test   %edx,%edx
	freeNodes = freeNodes->next;
801044e6:	89 35 fc b5 10 80    	mov    %esi,0x8010b5fc
	if(!freeLinks)
801044ec:	74 3f                	je     8010452d <_ZL9allocNodeP4procx+0x6d>
	freeLinks = freeLinks->next;
801044ee:	8b 4a 04             	mov    0x4(%edx),%ecx
	ans->p = p;
801044f1:	89 02                	mov    %eax,(%edx)
	ans->next = null;
801044f3:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
	if(isEmpty()) first = link;
801044fa:	8b 43 08             	mov    0x8(%ebx),%eax
	freeLinks = freeLinks->next;
801044fd:	89 0d 00 b6 10 80    	mov    %ecx,0x8010b600
	if(isEmpty()) first = link;
80104503:	85 c0                	test   %eax,%eax
80104505:	74 21                	je     80104528 <_ZL9allocNodeP4procx+0x68>
	else last->next = link;
80104507:	8b 43 0c             	mov    0xc(%ebx),%eax
8010450a:	89 50 04             	mov    %edx,0x4(%eax)
8010450d:	eb 03                	jmp    80104512 <_ZL9allocNodeP4procx+0x52>
8010450f:	90                   	nop
	while(ans->next)
80104510:	89 ca                	mov    %ecx,%edx
80104512:	8b 4a 04             	mov    0x4(%edx),%ecx
80104515:	85 c9                	test   %ecx,%ecx
80104517:	75 f7                	jne    80104510 <_ZL9allocNodeP4procx+0x50>
	last = link->getLast();
80104519:	89 53 0c             	mov    %edx,0xc(%ebx)
}
8010451c:	89 d8                	mov    %ebx,%eax
8010451e:	5b                   	pop    %ebx
8010451f:	5e                   	pop    %esi
80104520:	5d                   	pop    %ebp
80104521:	c3                   	ret    
80104522:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	if(isEmpty()) first = link;
80104528:	89 53 08             	mov    %edx,0x8(%ebx)
8010452b:	eb e5                	jmp    80104512 <_ZL9allocNodeP4procx+0x52>
	node->parent = node->left = node->right = null;
8010452d:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
80104534:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
8010453b:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
	node->next = freeNodes;
80104542:	89 73 10             	mov    %esi,0x10(%ebx)
	freeNodes = node;
80104545:	89 1d fc b5 10 80    	mov    %ebx,0x8010b5fc
		return null;
8010454b:	31 db                	xor    %ebx,%ebx
8010454d:	eb cd                	jmp    8010451c <_ZL9allocNodeP4procx+0x5c>
8010454f:	90                   	nop

80104550 <_ZL8mymallocj>:
static char* mymalloc(uint size) {
80104550:	55                   	push   %ebp
80104551:	89 e5                	mov    %esp,%ebp
80104553:	53                   	push   %ebx
80104554:	89 c3                	mov    %eax,%ebx
80104556:	83 ec 14             	sub    $0x14,%esp
	if(spaceLeft < size) {
80104559:	8b 15 f4 b5 10 80    	mov    0x8010b5f4,%edx
8010455f:	39 c2                	cmp    %eax,%edx
80104561:	73 26                	jae    80104589 <_ZL8mymallocj+0x39>
		data = kalloc();
80104563:	e8 48 e0 ff ff       	call   801025b0 <kalloc>
		memset(data, 0, PGSIZE);
80104568:	ba 00 10 00 00       	mov    $0x1000,%edx
8010456d:	31 c9                	xor    %ecx,%ecx
8010456f:	89 54 24 08          	mov    %edx,0x8(%esp)
80104573:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80104577:	89 04 24             	mov    %eax,(%esp)
		data = kalloc();
8010457a:	a3 f8 b5 10 80       	mov    %eax,0x8010b5f8
		memset(data, 0, PGSIZE);
8010457f:	e8 fc 0c 00 00       	call   80105280 <memset>
80104584:	ba 00 10 00 00       	mov    $0x1000,%edx
	char* ans = data;
80104589:	a1 f8 b5 10 80       	mov    0x8010b5f8,%eax
	spaceLeft -= size;
8010458e:	29 da                	sub    %ebx,%edx
80104590:	89 15 f4 b5 10 80    	mov    %edx,0x8010b5f4
	data += size;
80104596:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
80104599:	89 0d f8 b5 10 80    	mov    %ecx,0x8010b5f8
}
8010459f:	83 c4 14             	add    $0x14,%esp
801045a2:	5b                   	pop    %ebx
801045a3:	5d                   	pop    %ebp
801045a4:	c3                   	ret    
801045a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045b0 <initSchedDS>:
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
801045b0:	55                   	push   %ebp
	data               = null;
801045b1:	31 c0                	xor    %eax,%eax
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
801045b3:	89 e5                	mov    %esp,%ebp
801045b5:	53                   	push   %ebx
	freeLinks = null;
801045b6:	bb 80 00 00 00       	mov    $0x80,%ebx
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
801045bb:	83 ec 04             	sub    $0x4,%esp
	data               = null;
801045be:	a3 f8 b5 10 80       	mov    %eax,0x8010b5f8
	spaceLeft          = 0u;
801045c3:	31 c0                	xor    %eax,%eax
801045c5:	a3 f4 b5 10 80       	mov    %eax,0x8010b5f4
	priorityQ          = (Map*)mymalloc(sizeof(Map));
801045ca:	b8 04 00 00 00       	mov    $0x4,%eax
801045cf:	e8 7c ff ff ff       	call   80104550 <_ZL8mymallocj>
801045d4:	a3 0c b6 10 80       	mov    %eax,0x8010b60c
	*priorityQ         = Map();
801045d9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	roundRobinQ        = (LinkedList*)mymalloc(sizeof(LinkedList));
801045df:	b8 08 00 00 00       	mov    $0x8,%eax
801045e4:	e8 67 ff ff ff       	call   80104550 <_ZL8mymallocj>
801045e9:	a3 08 b6 10 80       	mov    %eax,0x8010b608
	*roundRobinQ       = LinkedList();
801045ee:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801045f4:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	runningProcHolder  = (LinkedList*)mymalloc(sizeof(LinkedList));
801045fb:	b8 08 00 00 00       	mov    $0x8,%eax
80104600:	e8 4b ff ff ff       	call   80104550 <_ZL8mymallocj>
80104605:	a3 04 b6 10 80       	mov    %eax,0x8010b604
	*runningProcHolder = LinkedList();
8010460a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104610:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = null;
80104617:	31 c0                	xor    %eax,%eax
80104619:	a3 00 b6 10 80       	mov    %eax,0x8010b600
8010461e:	66 90                	xchg   %ax,%ax
		Link *link = (Link*)mymalloc(sizeof(Link));
80104620:	b8 08 00 00 00       	mov    $0x8,%eax
80104625:	e8 26 ff ff ff       	call   80104550 <_ZL8mymallocj>
		link->next = freeLinks;
8010462a:	8b 15 00 b6 10 80    	mov    0x8010b600,%edx
	for(int i = 0; i < NPROCLIST; ++i) {
80104630:	4b                   	dec    %ebx
		*link = Link();
80104631:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		link->next = freeLinks;
80104637:	89 50 04             	mov    %edx,0x4(%eax)
		freeLinks = link;
8010463a:	a3 00 b6 10 80       	mov    %eax,0x8010b600
	for(int i = 0; i < NPROCLIST; ++i) {
8010463f:	75 df                	jne    80104620 <initSchedDS+0x70>
	freeNodes = null;
80104641:	31 c0                	xor    %eax,%eax
80104643:	bb 80 00 00 00       	mov    $0x80,%ebx
80104648:	a3 fc b5 10 80       	mov    %eax,0x8010b5fc
8010464d:	8d 76 00             	lea    0x0(%esi),%esi
		MapNode *node = (MapNode*)mymalloc(sizeof(MapNode));
80104650:	b8 20 00 00 00       	mov    $0x20,%eax
80104655:	e8 f6 fe ff ff       	call   80104550 <_ZL8mymallocj>
		node->next = freeNodes;
8010465a:	8b 15 fc b5 10 80    	mov    0x8010b5fc,%edx
	for(int i = 0; i < NPROCMAP; ++i) {
80104660:	4b                   	dec    %ebx
		*node = MapNode();
80104661:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80104668:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
8010466f:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
80104676:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
8010467d:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
		node->next = freeNodes;
80104684:	89 50 10             	mov    %edx,0x10(%eax)
		freeNodes = node;
80104687:	a3 fc b5 10 80       	mov    %eax,0x8010b5fc
	for(int i = 0; i < NPROCMAP; ++i) {
8010468c:	75 c2                	jne    80104650 <initSchedDS+0xa0>
	pq.isEmpty                      = isEmptyPriorityQueue;
8010468e:	b8 90 42 10 80       	mov    $0x80104290,%eax
	pq.put                          = putPriorityQueue;
80104693:	ba 50 4c 10 80       	mov    $0x80104c50,%edx
	pq.isEmpty                      = isEmptyPriorityQueue;
80104698:	a3 dc b5 10 80       	mov    %eax,0x8010b5dc
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
8010469d:	b8 10 4e 10 80       	mov    $0x80104e10,%eax
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
801046a2:	b9 b0 42 10 80       	mov    $0x801042b0,%ecx
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
801046a7:	a3 ec b5 10 80       	mov    %eax,0x8010b5ec
	pq.extractProc                  = extractProcPriorityQueue;
801046ac:	b8 f0 4e 10 80       	mov    $0x80104ef0,%eax
	pq.extractMin                   = extractMinPriorityQueue;
801046b1:	bb 70 4d 10 80       	mov    $0x80104d70,%ebx
	pq.extractProc                  = extractProcPriorityQueue;
801046b6:	a3 f0 b5 10 80       	mov    %eax,0x8010b5f0
	rrq.isEmpty                     = isEmptyRoundRobinQueue;
801046bb:	b8 00 43 10 80       	mov    $0x80104300,%eax
801046c0:	a3 cc b5 10 80       	mov    %eax,0x8010b5cc
	rrq.enqueue                     = enqueueRoundRobinQueue;
801046c5:	b8 20 43 10 80       	mov    $0x80104320,%eax
801046ca:	a3 d0 b5 10 80       	mov    %eax,0x8010b5d0
	rrq.dequeue                     = dequeueRoundRobinQueue;
801046cf:	b8 80 43 10 80       	mov    $0x80104380,%eax
801046d4:	a3 d4 b5 10 80       	mov    %eax,0x8010b5d4
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;
801046d9:	b8 d0 43 10 80       	mov    $0x801043d0,%eax
	pq.put                          = putPriorityQueue;
801046de:	89 15 e0 b5 10 80    	mov    %edx,0x8010b5e0
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
801046e4:	ba 40 44 10 80       	mov    $0x80104440,%edx
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
801046e9:	89 0d e4 b5 10 80    	mov    %ecx,0x8010b5e4
	rpholder.add                    = addRunningProcessHolder;
801046ef:	b9 60 44 10 80       	mov    $0x80104460,%ecx
	pq.extractMin                   = extractMinPriorityQueue;
801046f4:	89 1d e8 b5 10 80    	mov    %ebx,0x8010b5e8
	rpholder.remove                 = removeRunningProcessHolder;
801046fa:	bb 10 49 10 80       	mov    $0x80104910,%ebx
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;
801046ff:	a3 d8 b5 10 80       	mov    %eax,0x8010b5d8
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
80104704:	b8 10 4a 10 80       	mov    $0x80104a10,%eax
	rpholder.remove                 = removeRunningProcessHolder;
80104709:	89 1d c4 b5 10 80    	mov    %ebx,0x8010b5c4
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
8010470f:	89 15 bc b5 10 80    	mov    %edx,0x8010b5bc
	rpholder.add                    = addRunningProcessHolder;
80104715:	89 0d c0 b5 10 80    	mov    %ecx,0x8010b5c0
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
8010471b:	a3 c8 b5 10 80       	mov    %eax,0x8010b5c8
}
80104720:	58                   	pop    %eax
80104721:	5b                   	pop    %ebx
80104722:	5d                   	pop    %ebp
80104723:	c3                   	ret    
80104724:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010472a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104730 <_ZN4Link7getLastEv>:
Link* Link::getLast() {
80104730:	55                   	push   %ebp
80104731:	89 e5                	mov    %esp,%ebp
80104733:	8b 45 08             	mov    0x8(%ebp),%eax
80104736:	eb 0a                	jmp    80104742 <_ZN4Link7getLastEv+0x12>
80104738:	90                   	nop
80104739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104740:	89 d0                	mov    %edx,%eax
	while(ans->next)
80104742:	8b 50 04             	mov    0x4(%eax),%edx
80104745:	85 d2                	test   %edx,%edx
80104747:	75 f7                	jne    80104740 <_ZN4Link7getLastEv+0x10>
}
80104749:	5d                   	pop    %ebp
8010474a:	c3                   	ret    
8010474b:	90                   	nop
8010474c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104750 <_ZN10LinkedList7isEmptyEv>:
bool LinkedList::isEmpty() {
80104750:	55                   	push   %ebp
80104751:	89 e5                	mov    %esp,%ebp
	return !first;
80104753:	8b 45 08             	mov    0x8(%ebp),%eax
}
80104756:	5d                   	pop    %ebp
	return !first;
80104757:	8b 00                	mov    (%eax),%eax
80104759:	85 c0                	test   %eax,%eax
8010475b:	0f 94 c0             	sete   %al
}
8010475e:	c3                   	ret    
8010475f:	90                   	nop

80104760 <_ZN10LinkedList6appendEP4Link>:
void LinkedList::append(Link *link) {
80104760:	55                   	push   %ebp
80104761:	89 e5                	mov    %esp,%ebp
80104763:	8b 55 0c             	mov    0xc(%ebp),%edx
80104766:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!link)
80104769:	85 d2                	test   %edx,%edx
8010476b:	74 1f                	je     8010478c <_ZN10LinkedList6appendEP4Link+0x2c>
	if(isEmpty()) first = link;
8010476d:	8b 01                	mov    (%ecx),%eax
8010476f:	85 c0                	test   %eax,%eax
80104771:	74 1d                	je     80104790 <_ZN10LinkedList6appendEP4Link+0x30>
	else last->next = link;
80104773:	8b 41 04             	mov    0x4(%ecx),%eax
80104776:	89 50 04             	mov    %edx,0x4(%eax)
80104779:	eb 07                	jmp    80104782 <_ZN10LinkedList6appendEP4Link+0x22>
8010477b:	90                   	nop
8010477c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	while(ans->next)
80104780:	89 c2                	mov    %eax,%edx
80104782:	8b 42 04             	mov    0x4(%edx),%eax
80104785:	85 c0                	test   %eax,%eax
80104787:	75 f7                	jne    80104780 <_ZN10LinkedList6appendEP4Link+0x20>
	last = link->getLast();
80104789:	89 51 04             	mov    %edx,0x4(%ecx)
}
8010478c:	5d                   	pop    %ebp
8010478d:	c3                   	ret    
8010478e:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
80104790:	89 11                	mov    %edx,(%ecx)
80104792:	eb ee                	jmp    80104782 <_ZN10LinkedList6appendEP4Link+0x22>
80104794:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010479a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801047a0 <_ZN10LinkedList7enqueueEP4proc>:
	if(!freeLinks)
801047a0:	a1 00 b6 10 80       	mov    0x8010b600,%eax
bool LinkedList::enqueue(Proc *p) {
801047a5:	55                   	push   %ebp
801047a6:	89 e5                	mov    %esp,%ebp
801047a8:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!freeLinks)
801047ab:	85 c0                	test   %eax,%eax
801047ad:	74 41                	je     801047f0 <_ZN10LinkedList7enqueueEP4proc+0x50>
	freeLinks = freeLinks->next;
801047af:	8b 50 04             	mov    0x4(%eax),%edx
	ans->next = null;
801047b2:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
801047b9:	89 15 00 b6 10 80    	mov    %edx,0x8010b600
	ans->p = p;
801047bf:	8b 55 0c             	mov    0xc(%ebp),%edx
801047c2:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
801047c4:	8b 11                	mov    (%ecx),%edx
801047c6:	85 d2                	test   %edx,%edx
801047c8:	74 2e                	je     801047f8 <_ZN10LinkedList7enqueueEP4proc+0x58>
	else last->next = link;
801047ca:	8b 51 04             	mov    0x4(%ecx),%edx
801047cd:	89 42 04             	mov    %eax,0x4(%edx)
801047d0:	eb 08                	jmp    801047da <_ZN10LinkedList7enqueueEP4proc+0x3a>
801047d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	while(ans->next)
801047d8:	89 d0                	mov    %edx,%eax
801047da:	8b 50 04             	mov    0x4(%eax),%edx
801047dd:	85 d2                	test   %edx,%edx
801047df:	75 f7                	jne    801047d8 <_ZN10LinkedList7enqueueEP4proc+0x38>
	last = link->getLast();
801047e1:	89 41 04             	mov    %eax,0x4(%ecx)
	return true;
801047e4:	b0 01                	mov    $0x1,%al
}
801047e6:	5d                   	pop    %ebp
801047e7:	c3                   	ret    
801047e8:	90                   	nop
801047e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return false;
801047f0:	31 c0                	xor    %eax,%eax
}
801047f2:	5d                   	pop    %ebp
801047f3:	c3                   	ret    
801047f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
801047f8:	89 01                	mov    %eax,(%ecx)
801047fa:	eb de                	jmp    801047da <_ZN10LinkedList7enqueueEP4proc+0x3a>
801047fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104800 <_ZN10LinkedList7dequeueEv>:
Proc* LinkedList::dequeue() {
80104800:	55                   	push   %ebp
80104801:	89 e5                	mov    %esp,%ebp
80104803:	83 ec 08             	sub    $0x8,%esp
80104806:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104809:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010480c:	89 75 fc             	mov    %esi,-0x4(%ebp)
	return !first;
8010480f:	8b 11                	mov    (%ecx),%edx
	if(isEmpty())
80104811:	85 d2                	test   %edx,%edx
80104813:	74 2b                	je     80104840 <_ZN10LinkedList7dequeueEv+0x40>
	Link *next = first->next;
80104815:	8b 5a 04             	mov    0x4(%edx),%ebx
	link->next = freeLinks;
80104818:	8b 35 00 b6 10 80    	mov    0x8010b600,%esi
	Proc *p = first->p;
8010481e:	8b 02                	mov    (%edx),%eax
	freeLinks = link;
80104820:	89 15 00 b6 10 80    	mov    %edx,0x8010b600
	if(isEmpty())
80104826:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
80104828:	89 72 04             	mov    %esi,0x4(%edx)
	first = next;
8010482b:	89 19                	mov    %ebx,(%ecx)
	if(isEmpty())
8010482d:	75 07                	jne    80104836 <_ZN10LinkedList7dequeueEv+0x36>
		last = null;
8010482f:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
}
80104836:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104839:	8b 75 fc             	mov    -0x4(%ebp),%esi
8010483c:	89 ec                	mov    %ebp,%esp
8010483e:	5d                   	pop    %ebp
8010483f:	c3                   	ret    
		return null;
80104840:	31 c0                	xor    %eax,%eax
80104842:	eb f2                	jmp    80104836 <_ZN10LinkedList7dequeueEv+0x36>
80104844:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010484a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104850 <_ZN10LinkedList6removeEP4proc>:
bool LinkedList::remove(Proc *p) {
80104850:	55                   	push   %ebp
80104851:	89 e5                	mov    %esp,%ebp
80104853:	56                   	push   %esi
80104854:	8b 75 08             	mov    0x8(%ebp),%esi
80104857:	53                   	push   %ebx
80104858:	8b 4d 0c             	mov    0xc(%ebp),%ecx
	return !first;
8010485b:	8b 1e                	mov    (%esi),%ebx
	if(isEmpty())
8010485d:	85 db                	test   %ebx,%ebx
8010485f:	74 2f                	je     80104890 <_ZN10LinkedList6removeEP4proc+0x40>
	if(first->p == p) {
80104861:	39 0b                	cmp    %ecx,(%ebx)
80104863:	8b 53 04             	mov    0x4(%ebx),%edx
80104866:	74 70                	je     801048d8 <_ZN10LinkedList6removeEP4proc+0x88>
	while(cur) {
80104868:	85 d2                	test   %edx,%edx
8010486a:	74 24                	je     80104890 <_ZN10LinkedList6removeEP4proc+0x40>
		if(cur->p == p) {
8010486c:	3b 0a                	cmp    (%edx),%ecx
8010486e:	66 90                	xchg   %ax,%ax
80104870:	75 0c                	jne    8010487e <_ZN10LinkedList6removeEP4proc+0x2e>
80104872:	eb 2c                	jmp    801048a0 <_ZN10LinkedList6removeEP4proc+0x50>
80104874:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104878:	39 08                	cmp    %ecx,(%eax)
8010487a:	74 34                	je     801048b0 <_ZN10LinkedList6removeEP4proc+0x60>
8010487c:	89 c2                	mov    %eax,%edx
		cur = cur->next;
8010487e:	8b 42 04             	mov    0x4(%edx),%eax
	while(cur) {
80104881:	85 c0                	test   %eax,%eax
80104883:	75 f3                	jne    80104878 <_ZN10LinkedList6removeEP4proc+0x28>
}
80104885:	5b                   	pop    %ebx
80104886:	5e                   	pop    %esi
80104887:	5d                   	pop    %ebp
80104888:	c3                   	ret    
80104889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104890:	5b                   	pop    %ebx
		return false;
80104891:	31 c0                	xor    %eax,%eax
}
80104893:	5e                   	pop    %esi
80104894:	5d                   	pop    %ebp
80104895:	c3                   	ret    
80104896:	8d 76 00             	lea    0x0(%esi),%esi
80104899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		if(cur->p == p) {
801048a0:	89 d0                	mov    %edx,%eax
801048a2:	89 da                	mov    %ebx,%edx
801048a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801048aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
			prev->next = cur->next;
801048b0:	8b 48 04             	mov    0x4(%eax),%ecx
801048b3:	89 4a 04             	mov    %ecx,0x4(%edx)
			if(!(cur->next)) //removes the last link
801048b6:	8b 48 04             	mov    0x4(%eax),%ecx
801048b9:	85 c9                	test   %ecx,%ecx
801048bb:	74 43                	je     80104900 <_ZN10LinkedList6removeEP4proc+0xb0>
	link->next = freeLinks;
801048bd:	8b 15 00 b6 10 80    	mov    0x8010b600,%edx
	freeLinks = link;
801048c3:	a3 00 b6 10 80       	mov    %eax,0x8010b600
	link->next = freeLinks;
801048c8:	89 50 04             	mov    %edx,0x4(%eax)
			return true;
801048cb:	b0 01                	mov    $0x1,%al
}
801048cd:	5b                   	pop    %ebx
801048ce:	5e                   	pop    %esi
801048cf:	5d                   	pop    %ebp
801048d0:	c3                   	ret    
801048d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	link->next = freeLinks;
801048d8:	a1 00 b6 10 80       	mov    0x8010b600,%eax
	if(isEmpty())
801048dd:	85 d2                	test   %edx,%edx
	freeLinks = link;
801048df:	89 1d 00 b6 10 80    	mov    %ebx,0x8010b600
	link->next = freeLinks;
801048e5:	89 43 04             	mov    %eax,0x4(%ebx)
		return true;
801048e8:	b0 01                	mov    $0x1,%al
	first = next;
801048ea:	89 16                	mov    %edx,(%esi)
	if(isEmpty())
801048ec:	75 97                	jne    80104885 <_ZN10LinkedList6removeEP4proc+0x35>
		last = null;
801048ee:	c7 46 04 00 00 00 00 	movl   $0x0,0x4(%esi)
801048f5:	eb 8e                	jmp    80104885 <_ZN10LinkedList6removeEP4proc+0x35>
801048f7:	89 f6                	mov    %esi,%esi
801048f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
				last = prev;
80104900:	89 56 04             	mov    %edx,0x4(%esi)
80104903:	eb b8                	jmp    801048bd <_ZN10LinkedList6removeEP4proc+0x6d>
80104905:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104910 <removeRunningProcessHolder>:
static boolean removeRunningProcessHolder(Proc* p) {
80104910:	55                   	push   %ebp
80104911:	89 e5                	mov    %esp,%ebp
80104913:	83 ec 08             	sub    $0x8,%esp
	return runningProcHolder->remove(p);
80104916:	8b 45 08             	mov    0x8(%ebp),%eax
80104919:	89 44 24 04          	mov    %eax,0x4(%esp)
8010491d:	a1 04 b6 10 80       	mov    0x8010b604,%eax
80104922:	89 04 24             	mov    %eax,(%esp)
80104925:	e8 26 ff ff ff       	call   80104850 <_ZN10LinkedList6removeEP4proc>
}
8010492a:	c9                   	leave  
	return runningProcHolder->remove(p);
8010492b:	0f b6 c0             	movzbl %al,%eax
}
8010492e:	c3                   	ret    
8010492f:	90                   	nop

80104930 <_ZN10LinkedList8transferEv>:
	if(!priorityQ->isEmpty())
80104930:	8b 15 0c b6 10 80    	mov    0x8010b60c,%edx
		return false;
80104936:	31 c0                	xor    %eax,%eax
bool LinkedList::transfer() {
80104938:	55                   	push   %ebp
80104939:	89 e5                	mov    %esp,%ebp
8010493b:	53                   	push   %ebx
8010493c:	8b 5d 08             	mov    0x8(%ebp),%ebx
	if(!priorityQ->isEmpty())
8010493f:	8b 0a                	mov    (%edx),%ecx
80104941:	85 c9                	test   %ecx,%ecx
80104943:	74 0b                	je     80104950 <_ZN10LinkedList8transferEv+0x20>
}
80104945:	5b                   	pop    %ebx
80104946:	5d                   	pop    %ebp
80104947:	c3                   	ret    
80104948:	90                   	nop
80104949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	if(!freeNodes)
80104950:	8b 0d fc b5 10 80    	mov    0x8010b5fc,%ecx
80104956:	85 c9                	test   %ecx,%ecx
80104958:	74 eb                	je     80104945 <_ZN10LinkedList8transferEv+0x15>
	freeNodes = freeNodes->next;
8010495a:	8b 41 10             	mov    0x10(%ecx),%eax
	ans->key = key;
8010495d:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
	ans->next = null;
80104963:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
	ans->key = key;
8010496a:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
	freeNodes = freeNodes->next;
80104971:	a3 fc b5 10 80       	mov    %eax,0x8010b5fc
	node->listOfProcs.first = first;
80104976:	8b 03                	mov    (%ebx),%eax
80104978:	89 41 08             	mov    %eax,0x8(%ecx)
	node->listOfProcs.last = last;
8010497b:	8b 43 04             	mov    0x4(%ebx),%eax
8010497e:	89 41 0c             	mov    %eax,0xc(%ecx)
	return true;
80104981:	b0 01                	mov    $0x1,%al
	first = last = null;
80104983:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
8010498a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
	priorityQ->root = node;
80104990:	89 0a                	mov    %ecx,(%edx)
}
80104992:	5b                   	pop    %ebx
80104993:	5d                   	pop    %ebp
80104994:	c3                   	ret    
80104995:	90                   	nop
80104996:	8d 76 00             	lea    0x0(%esi),%esi
80104999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049a0 <_ZN10LinkedList9getMinKeyEPx>:
bool LinkedList::getMinKey(long long *pkey) {
801049a0:	55                   	push   %ebp
801049a1:	31 c0                	xor    %eax,%eax
801049a3:	89 e5                	mov    %esp,%ebp
801049a5:	57                   	push   %edi
801049a6:	56                   	push   %esi
801049a7:	53                   	push   %ebx
801049a8:	83 ec 1c             	sub    $0x1c,%esp
801049ab:	8b 7d 08             	mov    0x8(%ebp),%edi
	return !first;
801049ae:	8b 17                	mov    (%edi),%edx
	if(isEmpty())
801049b0:	85 d2                	test   %edx,%edx
801049b2:	74 41                	je     801049f5 <_ZN10LinkedList9getMinKeyEPx+0x55>
	long long minKey = getAccumulator(first->p);
801049b4:	8b 02                	mov    (%edx),%eax
801049b6:	89 04 24             	mov    %eax,(%esp)
801049b9:	e8 d2 ee ff ff       	call   80103890 <getAccumulator>
	forEach([&](Proc *p) {
801049be:	8b 3f                	mov    (%edi),%edi
	void append(Link *link); //appends the given list to the queue. No allocations always succeeds.
	
	template<typename Func>
	void forEach(const Func& accept) { //for-each loop. gets a function that applies the procin each link node.
		Link *link = first;
		while(link) {
801049c0:	85 ff                	test   %edi,%edi
	long long minKey = getAccumulator(first->p);
801049c2:	89 c6                	mov    %eax,%esi
801049c4:	89 d3                	mov    %edx,%ebx
801049c6:	74 23                	je     801049eb <_ZN10LinkedList9getMinKeyEPx+0x4b>
801049c8:	90                   	nop
801049c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		long long key = getAccumulator(p);
801049d0:	8b 07                	mov    (%edi),%eax
801049d2:	89 04 24             	mov    %eax,(%esp)
801049d5:	e8 b6 ee ff ff       	call   80103890 <getAccumulator>
801049da:	39 d3                	cmp    %edx,%ebx
801049dc:	7c 06                	jl     801049e4 <_ZN10LinkedList9getMinKeyEPx+0x44>
801049de:	7f 20                	jg     80104a00 <_ZN10LinkedList9getMinKeyEPx+0x60>
801049e0:	39 c6                	cmp    %eax,%esi
801049e2:	77 1c                	ja     80104a00 <_ZN10LinkedList9getMinKeyEPx+0x60>
			accept(link->p);
			link = link->next;
801049e4:	8b 7f 04             	mov    0x4(%edi),%edi
		while(link) {
801049e7:	85 ff                	test   %edi,%edi
801049e9:	75 e5                	jne    801049d0 <_ZN10LinkedList9getMinKeyEPx+0x30>
	*pkey = minKey;
801049eb:	8b 45 0c             	mov    0xc(%ebp),%eax
801049ee:	89 30                	mov    %esi,(%eax)
801049f0:	89 58 04             	mov    %ebx,0x4(%eax)
	return true;
801049f3:	b0 01                	mov    $0x1,%al
}
801049f5:	83 c4 1c             	add    $0x1c,%esp
801049f8:	5b                   	pop    %ebx
801049f9:	5e                   	pop    %esi
801049fa:	5f                   	pop    %edi
801049fb:	5d                   	pop    %ebp
801049fc:	c3                   	ret    
801049fd:	8d 76 00             	lea    0x0(%esi),%esi
			link = link->next;
80104a00:	8b 7f 04             	mov    0x4(%edi),%edi
80104a03:	89 c6                	mov    %eax,%esi
80104a05:	89 d3                	mov    %edx,%ebx
		while(link) {
80104a07:	85 ff                	test   %edi,%edi
80104a09:	75 c5                	jne    801049d0 <_ZN10LinkedList9getMinKeyEPx+0x30>
80104a0b:	eb de                	jmp    801049eb <_ZN10LinkedList9getMinKeyEPx+0x4b>
80104a0d:	8d 76 00             	lea    0x0(%esi),%esi

80104a10 <getMinAccumulatorRunningProcessHolder>:
static boolean getMinAccumulatorRunningProcessHolder(long long *pkey) {
80104a10:	55                   	push   %ebp
80104a11:	89 e5                	mov    %esp,%ebp
80104a13:	83 ec 18             	sub    $0x18,%esp
	return runningProcHolder->getMinKey(pkey);
80104a16:	8b 45 08             	mov    0x8(%ebp),%eax
80104a19:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a1d:	a1 04 b6 10 80       	mov    0x8010b604,%eax
80104a22:	89 04 24             	mov    %eax,(%esp)
80104a25:	e8 76 ff ff ff       	call   801049a0 <_ZN10LinkedList9getMinKeyEPx>
}
80104a2a:	c9                   	leave  
	return runningProcHolder->getMinKey(pkey);
80104a2b:	0f b6 c0             	movzbl %al,%eax
}
80104a2e:	c3                   	ret    
80104a2f:	90                   	nop

80104a30 <_ZN7MapNode7isEmptyEv>:
bool MapNode::isEmpty() {
80104a30:	55                   	push   %ebp
80104a31:	89 e5                	mov    %esp,%ebp
	return !first;
80104a33:	8b 45 08             	mov    0x8(%ebp),%eax
}
80104a36:	5d                   	pop    %ebp
	return !first;
80104a37:	8b 40 08             	mov    0x8(%eax),%eax
80104a3a:	85 c0                	test   %eax,%eax
80104a3c:	0f 94 c0             	sete   %al
}
80104a3f:	c3                   	ret    

80104a40 <_ZN7MapNode3putEP4proc>:
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
80104a40:	55                   	push   %ebp
80104a41:	89 e5                	mov    %esp,%ebp
80104a43:	57                   	push   %edi
80104a44:	56                   	push   %esi
80104a45:	53                   	push   %ebx
80104a46:	83 ec 2c             	sub    $0x2c,%esp
	long long key = getAccumulator(p);
80104a49:	8b 45 0c             	mov    0xc(%ebp),%eax
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
80104a4c:	8b 5d 08             	mov    0x8(%ebp),%ebx
	long long key = getAccumulator(p);
80104a4f:	89 04 24             	mov    %eax,(%esp)
80104a52:	e8 39 ee ff ff       	call   80103890 <getAccumulator>
80104a57:	89 d1                	mov    %edx,%ecx
80104a59:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		if(key == node->key)
80104a60:	8b 13                	mov    (%ebx),%edx
80104a62:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80104a65:	8b 43 04             	mov    0x4(%ebx),%eax
80104a68:	31 d7                	xor    %edx,%edi
80104a6a:	89 fe                	mov    %edi,%esi
80104a6c:	89 c7                	mov    %eax,%edi
80104a6e:	31 cf                	xor    %ecx,%edi
80104a70:	09 fe                	or     %edi,%esi
80104a72:	74 4c                	je     80104ac0 <_ZN7MapNode3putEP4proc+0x80>
		else if(key < node->key) { //left
80104a74:	39 c8                	cmp    %ecx,%eax
80104a76:	7c 20                	jl     80104a98 <_ZN7MapNode3putEP4proc+0x58>
80104a78:	7f 08                	jg     80104a82 <_ZN7MapNode3putEP4proc+0x42>
80104a7a:	3b 55 e4             	cmp    -0x1c(%ebp),%edx
80104a7d:	8d 76 00             	lea    0x0(%esi),%esi
80104a80:	76 16                	jbe    80104a98 <_ZN7MapNode3putEP4proc+0x58>
			if(node->left)
80104a82:	8b 43 18             	mov    0x18(%ebx),%eax
80104a85:	85 c0                	test   %eax,%eax
80104a87:	0f 84 83 00 00 00    	je     80104b10 <_ZN7MapNode3putEP4proc+0xd0>
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
80104a8d:	89 c3                	mov    %eax,%ebx
80104a8f:	eb cf                	jmp    80104a60 <_ZN7MapNode3putEP4proc+0x20>
80104a91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			if(node->right)
80104a98:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104a9b:	85 c0                	test   %eax,%eax
80104a9d:	75 ee                	jne    80104a8d <_ZN7MapNode3putEP4proc+0x4d>
80104a9f:	8b 75 e4             	mov    -0x1c(%ebp),%esi
				node->right = allocNode(p, key);
80104aa2:	8b 45 0c             	mov    0xc(%ebp),%eax
80104aa5:	89 f2                	mov    %esi,%edx
80104aa7:	e8 14 fa ff ff       	call   801044c0 <_ZL9allocNodeP4procx>
				if(node->right) {
80104aac:	85 c0                	test   %eax,%eax
				node->right = allocNode(p, key);
80104aae:	89 43 1c             	mov    %eax,0x1c(%ebx)
				if(node->right) {
80104ab1:	74 71                	je     80104b24 <_ZN7MapNode3putEP4proc+0xe4>
					node->right->parent = node;
80104ab3:	89 58 14             	mov    %ebx,0x14(%eax)
}
80104ab6:	83 c4 2c             	add    $0x2c,%esp
					return true;
80104ab9:	b0 01                	mov    $0x1,%al
}
80104abb:	5b                   	pop    %ebx
80104abc:	5e                   	pop    %esi
80104abd:	5f                   	pop    %edi
80104abe:	5d                   	pop    %ebp
80104abf:	c3                   	ret    
	if(!freeLinks)
80104ac0:	a1 00 b6 10 80       	mov    0x8010b600,%eax
80104ac5:	85 c0                	test   %eax,%eax
80104ac7:	74 5b                	je     80104b24 <_ZN7MapNode3putEP4proc+0xe4>
	ans->p = p;
80104ac9:	8b 75 0c             	mov    0xc(%ebp),%esi
	freeLinks = freeLinks->next;
80104acc:	8b 50 04             	mov    0x4(%eax),%edx
	ans->next = null;
80104acf:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	ans->p = p;
80104ad6:	89 30                	mov    %esi,(%eax)
	freeLinks = freeLinks->next;
80104ad8:	89 15 00 b6 10 80    	mov    %edx,0x8010b600
	if(isEmpty()) first = link;
80104ade:	8b 53 08             	mov    0x8(%ebx),%edx
80104ae1:	85 d2                	test   %edx,%edx
80104ae3:	74 4b                	je     80104b30 <_ZN7MapNode3putEP4proc+0xf0>
	else last->next = link;
80104ae5:	8b 53 0c             	mov    0xc(%ebx),%edx
80104ae8:	89 42 04             	mov    %eax,0x4(%edx)
80104aeb:	eb 05                	jmp    80104af2 <_ZN7MapNode3putEP4proc+0xb2>
80104aed:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
80104af0:	89 d0                	mov    %edx,%eax
80104af2:	8b 50 04             	mov    0x4(%eax),%edx
80104af5:	85 d2                	test   %edx,%edx
80104af7:	75 f7                	jne    80104af0 <_ZN7MapNode3putEP4proc+0xb0>
	last = link->getLast();
80104af9:	89 43 0c             	mov    %eax,0xc(%ebx)
}
80104afc:	83 c4 2c             	add    $0x2c,%esp
	return true;
80104aff:	b0 01                	mov    $0x1,%al
}
80104b01:	5b                   	pop    %ebx
80104b02:	5e                   	pop    %esi
80104b03:	5f                   	pop    %edi
80104b04:	5d                   	pop    %ebp
80104b05:	c3                   	ret    
80104b06:	8d 76 00             	lea    0x0(%esi),%esi
80104b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104b10:	8b 75 e4             	mov    -0x1c(%ebp),%esi
				node->left = allocNode(p, key);
80104b13:	8b 45 0c             	mov    0xc(%ebp),%eax
80104b16:	89 f2                	mov    %esi,%edx
80104b18:	e8 a3 f9 ff ff       	call   801044c0 <_ZL9allocNodeP4procx>
				if(node->left) {
80104b1d:	85 c0                	test   %eax,%eax
				node->left = allocNode(p, key);
80104b1f:	89 43 18             	mov    %eax,0x18(%ebx)
				if(node->left) {
80104b22:	75 8f                	jne    80104ab3 <_ZN7MapNode3putEP4proc+0x73>
}
80104b24:	83 c4 2c             	add    $0x2c,%esp
		return false;
80104b27:	31 c0                	xor    %eax,%eax
}
80104b29:	5b                   	pop    %ebx
80104b2a:	5e                   	pop    %esi
80104b2b:	5f                   	pop    %edi
80104b2c:	5d                   	pop    %ebp
80104b2d:	c3                   	ret    
80104b2e:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
80104b30:	89 43 08             	mov    %eax,0x8(%ebx)
80104b33:	eb bd                	jmp    80104af2 <_ZN7MapNode3putEP4proc+0xb2>
80104b35:	90                   	nop
80104b36:	8d 76 00             	lea    0x0(%esi),%esi
80104b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b40 <_ZN7MapNode10getMinNodeEv>:
MapNode* MapNode::getMinNode() { //no recursion.
80104b40:	55                   	push   %ebp
80104b41:	89 e5                	mov    %esp,%ebp
80104b43:	8b 45 08             	mov    0x8(%ebp),%eax
80104b46:	eb 0a                	jmp    80104b52 <_ZN7MapNode10getMinNodeEv+0x12>
80104b48:	90                   	nop
80104b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b50:	89 d0                	mov    %edx,%eax
	while(minNode->left)
80104b52:	8b 50 18             	mov    0x18(%eax),%edx
80104b55:	85 d2                	test   %edx,%edx
80104b57:	75 f7                	jne    80104b50 <_ZN7MapNode10getMinNodeEv+0x10>
}
80104b59:	5d                   	pop    %ebp
80104b5a:	c3                   	ret    
80104b5b:	90                   	nop
80104b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104b60 <_ZN7MapNode9getMinKeyEPx>:
void MapNode::getMinKey(long long *pkey) {
80104b60:	55                   	push   %ebp
80104b61:	89 e5                	mov    %esp,%ebp
80104b63:	8b 55 08             	mov    0x8(%ebp),%edx
80104b66:	53                   	push   %ebx
80104b67:	eb 09                	jmp    80104b72 <_ZN7MapNode9getMinKeyEPx+0x12>
80104b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	while(minNode->left)
80104b70:	89 c2                	mov    %eax,%edx
80104b72:	8b 42 18             	mov    0x18(%edx),%eax
80104b75:	85 c0                	test   %eax,%eax
80104b77:	75 f7                	jne    80104b70 <_ZN7MapNode9getMinKeyEPx+0x10>
	*pkey = getMinNode()->key;
80104b79:	8b 5a 04             	mov    0x4(%edx),%ebx
80104b7c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104b7f:	8b 0a                	mov    (%edx),%ecx
80104b81:	89 58 04             	mov    %ebx,0x4(%eax)
80104b84:	89 08                	mov    %ecx,(%eax)
}
80104b86:	5b                   	pop    %ebx
80104b87:	5d                   	pop    %ebp
80104b88:	c3                   	ret    
80104b89:	90                   	nop
80104b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104b90 <_ZN7MapNode7dequeueEv>:
Proc* MapNode::dequeue() {
80104b90:	55                   	push   %ebp
80104b91:	89 e5                	mov    %esp,%ebp
80104b93:	83 ec 08             	sub    $0x8,%esp
80104b96:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104b99:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80104b9c:	89 75 fc             	mov    %esi,-0x4(%ebp)
	return !first;
80104b9f:	8b 51 08             	mov    0x8(%ecx),%edx
	if(isEmpty())
80104ba2:	85 d2                	test   %edx,%edx
80104ba4:	74 32                	je     80104bd8 <_ZN7MapNode7dequeueEv+0x48>
	Link *next = first->next;
80104ba6:	8b 5a 04             	mov    0x4(%edx),%ebx
	link->next = freeLinks;
80104ba9:	8b 35 00 b6 10 80    	mov    0x8010b600,%esi
	Proc *p = first->p;
80104baf:	8b 02                	mov    (%edx),%eax
	freeLinks = link;
80104bb1:	89 15 00 b6 10 80    	mov    %edx,0x8010b600
	if(isEmpty())
80104bb7:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
80104bb9:	89 72 04             	mov    %esi,0x4(%edx)
	first = next;
80104bbc:	89 59 08             	mov    %ebx,0x8(%ecx)
	if(isEmpty())
80104bbf:	75 07                	jne    80104bc8 <_ZN7MapNode7dequeueEv+0x38>
		last = null;
80104bc1:	c7 41 0c 00 00 00 00 	movl   $0x0,0xc(%ecx)
}
80104bc8:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104bcb:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104bce:	89 ec                	mov    %ebp,%esp
80104bd0:	5d                   	pop    %ebp
80104bd1:	c3                   	ret    
80104bd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		return null;
80104bd8:	31 c0                	xor    %eax,%eax
	return listOfProcs.dequeue();
80104bda:	eb ec                	jmp    80104bc8 <_ZN7MapNode7dequeueEv+0x38>
80104bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104be0 <_ZN3Map7isEmptyEv>:
bool Map::isEmpty() {
80104be0:	55                   	push   %ebp
80104be1:	89 e5                	mov    %esp,%ebp
	return !root;
80104be3:	8b 45 08             	mov    0x8(%ebp),%eax
}
80104be6:	5d                   	pop    %ebp
	return !root;
80104be7:	8b 00                	mov    (%eax),%eax
80104be9:	85 c0                	test   %eax,%eax
80104beb:	0f 94 c0             	sete   %al
}
80104bee:	c3                   	ret    
80104bef:	90                   	nop

80104bf0 <_ZN3Map3putEP4proc>:
bool Map::put(Proc *p) {
80104bf0:	55                   	push   %ebp
80104bf1:	89 e5                	mov    %esp,%ebp
80104bf3:	83 ec 18             	sub    $0x18,%esp
80104bf6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80104bf9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104bfc:	89 75 fc             	mov    %esi,-0x4(%ebp)
80104bff:	8b 75 08             	mov    0x8(%ebp),%esi
	long long key = getAccumulator(p);
80104c02:	89 1c 24             	mov    %ebx,(%esp)
80104c05:	e8 86 ec ff ff       	call   80103890 <getAccumulator>
	return !root;
80104c0a:	8b 0e                	mov    (%esi),%ecx
	if(isEmpty()) {
80104c0c:	85 c9                	test   %ecx,%ecx
80104c0e:	74 18                	je     80104c28 <_ZN3Map3putEP4proc+0x38>
	return root->put(p);
80104c10:	89 5d 0c             	mov    %ebx,0xc(%ebp)
}
80104c13:	8b 75 fc             	mov    -0x4(%ebp),%esi
	return root->put(p);
80104c16:	89 4d 08             	mov    %ecx,0x8(%ebp)
}
80104c19:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104c1c:	89 ec                	mov    %ebp,%esp
80104c1e:	5d                   	pop    %ebp
	return root->put(p);
80104c1f:	e9 1c fe ff ff       	jmp    80104a40 <_ZN7MapNode3putEP4proc>
80104c24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		root = allocNode(p, key);
80104c28:	89 d1                	mov    %edx,%ecx
80104c2a:	89 c2                	mov    %eax,%edx
80104c2c:	89 d8                	mov    %ebx,%eax
80104c2e:	e8 8d f8 ff ff       	call   801044c0 <_ZL9allocNodeP4procx>
80104c33:	89 06                	mov    %eax,(%esi)
		return !isEmpty();
80104c35:	85 c0                	test   %eax,%eax
80104c37:	0f 95 c0             	setne  %al
}
80104c3a:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104c3d:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104c40:	89 ec                	mov    %ebp,%esp
80104c42:	5d                   	pop    %ebp
80104c43:	c3                   	ret    
80104c44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104c50 <putPriorityQueue>:
static boolean putPriorityQueue(Proc* p) {
80104c50:	55                   	push   %ebp
80104c51:	89 e5                	mov    %esp,%ebp
80104c53:	83 ec 18             	sub    $0x18,%esp
	return priorityQ->put(p);
80104c56:	8b 45 08             	mov    0x8(%ebp),%eax
80104c59:	89 44 24 04          	mov    %eax,0x4(%esp)
80104c5d:	a1 0c b6 10 80       	mov    0x8010b60c,%eax
80104c62:	89 04 24             	mov    %eax,(%esp)
80104c65:	e8 86 ff ff ff       	call   80104bf0 <_ZN3Map3putEP4proc>
}
80104c6a:	c9                   	leave  
	return priorityQ->put(p);
80104c6b:	0f b6 c0             	movzbl %al,%eax
}
80104c6e:	c3                   	ret    
80104c6f:	90                   	nop

80104c70 <_ZN3Map9getMinKeyEPx>:
bool Map::getMinKey(long long *pkey) {
80104c70:	55                   	push   %ebp
80104c71:	89 e5                	mov    %esp,%ebp
	return !root;
80104c73:	8b 45 08             	mov    0x8(%ebp),%eax
bool Map::getMinKey(long long *pkey) {
80104c76:	53                   	push   %ebx
	return !root;
80104c77:	8b 10                	mov    (%eax),%edx
	if(isEmpty())
80104c79:	85 d2                	test   %edx,%edx
80104c7b:	75 05                	jne    80104c82 <_ZN3Map9getMinKeyEPx+0x12>
80104c7d:	eb 21                	jmp    80104ca0 <_ZN3Map9getMinKeyEPx+0x30>
80104c7f:	90                   	nop
	while(minNode->left)
80104c80:	89 c2                	mov    %eax,%edx
80104c82:	8b 42 18             	mov    0x18(%edx),%eax
80104c85:	85 c0                	test   %eax,%eax
80104c87:	75 f7                	jne    80104c80 <_ZN3Map9getMinKeyEPx+0x10>
	*pkey = getMinNode()->key;
80104c89:	8b 45 0c             	mov    0xc(%ebp),%eax
80104c8c:	8b 5a 04             	mov    0x4(%edx),%ebx
80104c8f:	8b 0a                	mov    (%edx),%ecx
80104c91:	89 58 04             	mov    %ebx,0x4(%eax)
80104c94:	89 08                	mov    %ecx,(%eax)
		return false;

	root->getMinKey(pkey);
	return true;
80104c96:	b0 01                	mov    $0x1,%al
}
80104c98:	5b                   	pop    %ebx
80104c99:	5d                   	pop    %ebp
80104c9a:	c3                   	ret    
80104c9b:	90                   	nop
80104c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ca0:	5b                   	pop    %ebx
		return false;
80104ca1:	31 c0                	xor    %eax,%eax
}
80104ca3:	5d                   	pop    %ebp
80104ca4:	c3                   	ret    
80104ca5:	90                   	nop
80104ca6:	8d 76 00             	lea    0x0(%esi),%esi
80104ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104cb0 <_ZN3Map10extractMinEv>:

Proc* Map::extractMin() {
80104cb0:	55                   	push   %ebp
80104cb1:	89 e5                	mov    %esp,%ebp
80104cb3:	57                   	push   %edi
80104cb4:	56                   	push   %esi
80104cb5:	8b 75 08             	mov    0x8(%ebp),%esi
80104cb8:	53                   	push   %ebx
	return !root;
80104cb9:	8b 1e                	mov    (%esi),%ebx
	if(isEmpty())
80104cbb:	85 db                	test   %ebx,%ebx
80104cbd:	0f 84 a5 00 00 00    	je     80104d68 <_ZN3Map10extractMinEv+0xb8>
80104cc3:	89 da                	mov    %ebx,%edx
80104cc5:	eb 0b                	jmp    80104cd2 <_ZN3Map10extractMinEv+0x22>
80104cc7:	89 f6                	mov    %esi,%esi
80104cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	while(minNode->left)
80104cd0:	89 c2                	mov    %eax,%edx
80104cd2:	8b 42 18             	mov    0x18(%edx),%eax
80104cd5:	85 c0                	test   %eax,%eax
80104cd7:	75 f7                	jne    80104cd0 <_ZN3Map10extractMinEv+0x20>
	return !first;
80104cd9:	8b 4a 08             	mov    0x8(%edx),%ecx
	if(isEmpty())
80104cdc:	85 c9                	test   %ecx,%ecx
80104cde:	74 70                	je     80104d50 <_ZN3Map10extractMinEv+0xa0>
	Link *next = first->next;
80104ce0:	8b 59 04             	mov    0x4(%ecx),%ebx
	link->next = freeLinks;
80104ce3:	8b 3d 00 b6 10 80    	mov    0x8010b600,%edi
	Proc *p = first->p;
80104ce9:	8b 01                	mov    (%ecx),%eax
	freeLinks = link;
80104ceb:	89 0d 00 b6 10 80    	mov    %ecx,0x8010b600
	if(isEmpty())
80104cf1:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
80104cf3:	89 79 04             	mov    %edi,0x4(%ecx)
	first = next;
80104cf6:	89 5a 08             	mov    %ebx,0x8(%edx)
	if(isEmpty())
80104cf9:	74 05                	je     80104d00 <_ZN3Map10extractMinEv+0x50>
		}
		deallocNode(minNode);
	}

	return p;
}
80104cfb:	5b                   	pop    %ebx
80104cfc:	5e                   	pop    %esi
80104cfd:	5f                   	pop    %edi
80104cfe:	5d                   	pop    %ebp
80104cff:	c3                   	ret    
		last = null;
80104d00:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
80104d07:	8b 4a 1c             	mov    0x1c(%edx),%ecx
80104d0a:	8b 1e                	mov    (%esi),%ebx
		if(minNode == root) {
80104d0c:	39 da                	cmp    %ebx,%edx
80104d0e:	74 49                	je     80104d59 <_ZN3Map10extractMinEv+0xa9>
			MapNode *parent = minNode->parent;
80104d10:	8b 5a 14             	mov    0x14(%edx),%ebx
			parent->left = minNode->right;
80104d13:	89 4b 18             	mov    %ecx,0x18(%ebx)
			if(minNode->right)
80104d16:	8b 4a 1c             	mov    0x1c(%edx),%ecx
80104d19:	85 c9                	test   %ecx,%ecx
80104d1b:	74 03                	je     80104d20 <_ZN3Map10extractMinEv+0x70>
				minNode->right->parent = parent;
80104d1d:	89 59 14             	mov    %ebx,0x14(%ecx)
	node->next = freeNodes;
80104d20:	8b 0d fc b5 10 80    	mov    0x8010b5fc,%ecx
	node->parent = node->left = node->right = null;
80104d26:	c7 42 1c 00 00 00 00 	movl   $0x0,0x1c(%edx)
80104d2d:	c7 42 18 00 00 00 00 	movl   $0x0,0x18(%edx)
80104d34:	c7 42 14 00 00 00 00 	movl   $0x0,0x14(%edx)
	node->next = freeNodes;
80104d3b:	89 4a 10             	mov    %ecx,0x10(%edx)
}
80104d3e:	5b                   	pop    %ebx
	freeNodes = node;
80104d3f:	89 15 fc b5 10 80    	mov    %edx,0x8010b5fc
}
80104d45:	5e                   	pop    %esi
80104d46:	5f                   	pop    %edi
80104d47:	5d                   	pop    %ebp
80104d48:	c3                   	ret    
80104d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return null;
80104d50:	31 c0                	xor    %eax,%eax
		if(minNode == root) {
80104d52:	39 da                	cmp    %ebx,%edx
80104d54:	8b 4a 1c             	mov    0x1c(%edx),%ecx
80104d57:	75 b7                	jne    80104d10 <_ZN3Map10extractMinEv+0x60>
			if(!isEmpty())
80104d59:	85 c9                	test   %ecx,%ecx
			root = minNode->right;
80104d5b:	89 0e                	mov    %ecx,(%esi)
			if(!isEmpty())
80104d5d:	74 c1                	je     80104d20 <_ZN3Map10extractMinEv+0x70>
				root->parent = null;
80104d5f:	c7 41 14 00 00 00 00 	movl   $0x0,0x14(%ecx)
80104d66:	eb b8                	jmp    80104d20 <_ZN3Map10extractMinEv+0x70>
		return null;
80104d68:	31 c0                	xor    %eax,%eax
80104d6a:	eb 8f                	jmp    80104cfb <_ZN3Map10extractMinEv+0x4b>
80104d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104d70 <extractMinPriorityQueue>:
static Proc* extractMinPriorityQueue() {
80104d70:	55                   	push   %ebp
80104d71:	89 e5                	mov    %esp,%ebp
80104d73:	83 ec 04             	sub    $0x4,%esp
	return priorityQ->extractMin();
80104d76:	a1 0c b6 10 80       	mov    0x8010b60c,%eax
80104d7b:	89 04 24             	mov    %eax,(%esp)
80104d7e:	e8 2d ff ff ff       	call   80104cb0 <_ZN3Map10extractMinEv>
}
80104d83:	c9                   	leave  
80104d84:	c3                   	ret    
80104d85:	90                   	nop
80104d86:	8d 76 00             	lea    0x0(%esi),%esi
80104d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d90 <_ZN3Map8transferEv.part.1>:

bool Map::transfer() {
80104d90:	55                   	push   %ebp
80104d91:	89 e5                	mov    %esp,%ebp
80104d93:	56                   	push   %esi
80104d94:	53                   	push   %ebx
80104d95:	89 c3                	mov    %eax,%ebx
80104d97:	83 ec 04             	sub    $0x4,%esp
80104d9a:	eb 16                	jmp    80104db2 <_ZN3Map8transferEv.part.1+0x22>
80104d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!roundRobinQ->isEmpty())
		return false;

	while(!isEmpty()) {
		Proc* p = extractMin();
80104da0:	89 1c 24             	mov    %ebx,(%esp)
80104da3:	e8 08 ff ff ff       	call   80104cb0 <_ZN3Map10extractMinEv>
	if(!freeLinks)
80104da8:	8b 15 00 b6 10 80    	mov    0x8010b600,%edx
80104dae:	85 d2                	test   %edx,%edx
80104db0:	75 0e                	jne    80104dc0 <_ZN3Map8transferEv.part.1+0x30>
	while(!isEmpty()) {
80104db2:	8b 03                	mov    (%ebx),%eax
80104db4:	85 c0                	test   %eax,%eax
80104db6:	75 e8                	jne    80104da0 <_ZN3Map8transferEv.part.1+0x10>
		roundRobinQ->enqueue(p); //should succeed.
	}

	return true;
}
80104db8:	5a                   	pop    %edx
80104db9:	b0 01                	mov    $0x1,%al
80104dbb:	5b                   	pop    %ebx
80104dbc:	5e                   	pop    %esi
80104dbd:	5d                   	pop    %ebp
80104dbe:	c3                   	ret    
80104dbf:	90                   	nop
	freeLinks = freeLinks->next;
80104dc0:	8b 72 04             	mov    0x4(%edx),%esi
		roundRobinQ->enqueue(p); //should succeed.
80104dc3:	8b 0d 08 b6 10 80    	mov    0x8010b608,%ecx
	ans->next = null;
80104dc9:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
	ans->p = p;
80104dd0:	89 02                	mov    %eax,(%edx)
	freeLinks = freeLinks->next;
80104dd2:	89 35 00 b6 10 80    	mov    %esi,0x8010b600
	if(isEmpty()) first = link;
80104dd8:	8b 31                	mov    (%ecx),%esi
80104dda:	85 f6                	test   %esi,%esi
80104ddc:	74 22                	je     80104e00 <_ZN3Map8transferEv.part.1+0x70>
	else last->next = link;
80104dde:	8b 41 04             	mov    0x4(%ecx),%eax
80104de1:	89 50 04             	mov    %edx,0x4(%eax)
80104de4:	eb 0c                	jmp    80104df2 <_ZN3Map8transferEv.part.1+0x62>
80104de6:	8d 76 00             	lea    0x0(%esi),%esi
80104de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	while(ans->next)
80104df0:	89 c2                	mov    %eax,%edx
80104df2:	8b 42 04             	mov    0x4(%edx),%eax
80104df5:	85 c0                	test   %eax,%eax
80104df7:	75 f7                	jne    80104df0 <_ZN3Map8transferEv.part.1+0x60>
	last = link->getLast();
80104df9:	89 51 04             	mov    %edx,0x4(%ecx)
80104dfc:	eb b4                	jmp    80104db2 <_ZN3Map8transferEv.part.1+0x22>
80104dfe:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
80104e00:	89 11                	mov    %edx,(%ecx)
80104e02:	eb ee                	jmp    80104df2 <_ZN3Map8transferEv.part.1+0x62>
80104e04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104e10 <switchToRoundRobinPolicyPriorityQueue>:
	if(!roundRobinQ->isEmpty())
80104e10:	8b 15 08 b6 10 80    	mov    0x8010b608,%edx
80104e16:	8b 02                	mov    (%edx),%eax
80104e18:	85 c0                	test   %eax,%eax
80104e1a:	74 04                	je     80104e20 <switchToRoundRobinPolicyPriorityQueue+0x10>
80104e1c:	31 c0                	xor    %eax,%eax
}
80104e1e:	c3                   	ret    
80104e1f:	90                   	nop
80104e20:	a1 0c b6 10 80       	mov    0x8010b60c,%eax
static boolean switchToRoundRobinPolicyPriorityQueue() {
80104e25:	55                   	push   %ebp
80104e26:	89 e5                	mov    %esp,%ebp
80104e28:	e8 63 ff ff ff       	call   80104d90 <_ZN3Map8transferEv.part.1>
}
80104e2d:	5d                   	pop    %ebp
80104e2e:	0f b6 c0             	movzbl %al,%eax
80104e31:	c3                   	ret    
80104e32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e40 <_ZN3Map8transferEv>:
	return !first;
80104e40:	8b 15 08 b6 10 80    	mov    0x8010b608,%edx
bool Map::transfer() {
80104e46:	55                   	push   %ebp
80104e47:	89 e5                	mov    %esp,%ebp
80104e49:	8b 45 08             	mov    0x8(%ebp),%eax
	if(!roundRobinQ->isEmpty())
80104e4c:	8b 12                	mov    (%edx),%edx
80104e4e:	85 d2                	test   %edx,%edx
80104e50:	74 0e                	je     80104e60 <_ZN3Map8transferEv+0x20>
}
80104e52:	31 c0                	xor    %eax,%eax
80104e54:	5d                   	pop    %ebp
80104e55:	c3                   	ret    
80104e56:	8d 76 00             	lea    0x0(%esi),%esi
80104e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104e60:	5d                   	pop    %ebp
80104e61:	e9 2a ff ff ff       	jmp    80104d90 <_ZN3Map8transferEv.part.1>
80104e66:	8d 76 00             	lea    0x0(%esi),%esi
80104e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e70 <_ZN3Map11extractProcEP4proc>:

bool Map::extractProc(Proc *p) {
80104e70:	55                   	push   %ebp
80104e71:	89 e5                	mov    %esp,%ebp
80104e73:	56                   	push   %esi
80104e74:	53                   	push   %ebx
80104e75:	83 ec 30             	sub    $0x30,%esp
	if(!freeNodes)
80104e78:	8b 15 fc b5 10 80    	mov    0x8010b5fc,%edx
bool Map::extractProc(Proc *p) {
80104e7e:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104e81:	8b 75 0c             	mov    0xc(%ebp),%esi
	if(!freeNodes)
80104e84:	85 d2                	test   %edx,%edx
80104e86:	74 50                	je     80104ed8 <_ZN3Map11extractProcEP4proc+0x68>
	MapNode *next, *parent, *left, *right;
};

class Map {
public:
	Map(): root(null) {}
80104e88:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		return false;

	bool ans = false;
80104e8f:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
80104e93:	eb 13                	jmp    80104ea8 <_ZN3Map11extractProcEP4proc+0x38>
80104e95:	8d 76 00             	lea    0x0(%esi),%esi
	Map tempMap;
	while(!isEmpty()) {
		Proc *otherP = extractMin();
80104e98:	89 1c 24             	mov    %ebx,(%esp)
80104e9b:	e8 10 fe ff ff       	call   80104cb0 <_ZN3Map10extractMinEv>
		if(otherP != p)
80104ea0:	39 f0                	cmp    %esi,%eax
80104ea2:	75 1c                	jne    80104ec0 <_ZN3Map11extractProcEP4proc+0x50>
			tempMap.put(otherP); //should scucceed.
		else ans = true;
80104ea4:	c6 45 e7 01          	movb   $0x1,-0x19(%ebp)
	while(!isEmpty()) {
80104ea8:	8b 03                	mov    (%ebx),%eax
80104eaa:	85 c0                	test   %eax,%eax
80104eac:	75 ea                	jne    80104e98 <_ZN3Map11extractProcEP4proc+0x28>
	}
	root = tempMap.root;
80104eae:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104eb1:	89 03                	mov    %eax,(%ebx)
	return ans;
}
80104eb3:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80104eb7:	83 c4 30             	add    $0x30,%esp
80104eba:	5b                   	pop    %ebx
80104ebb:	5e                   	pop    %esi
80104ebc:	5d                   	pop    %ebp
80104ebd:	c3                   	ret    
80104ebe:	66 90                	xchg   %ax,%ax
			tempMap.put(otherP); //should scucceed.
80104ec0:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ec4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ec7:	89 04 24             	mov    %eax,(%esp)
80104eca:	e8 21 fd ff ff       	call   80104bf0 <_ZN3Map3putEP4proc>
80104ecf:	eb d7                	jmp    80104ea8 <_ZN3Map11extractProcEP4proc+0x38>
80104ed1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return false;
80104ed8:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
}
80104edc:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80104ee0:	83 c4 30             	add    $0x30,%esp
80104ee3:	5b                   	pop    %ebx
80104ee4:	5e                   	pop    %esi
80104ee5:	5d                   	pop    %ebp
80104ee6:	c3                   	ret    
80104ee7:	89 f6                	mov    %esi,%esi
80104ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ef0 <extractProcPriorityQueue>:
static boolean extractProcPriorityQueue(Proc *p) {
80104ef0:	55                   	push   %ebp
80104ef1:	89 e5                	mov    %esp,%ebp
80104ef3:	83 ec 18             	sub    $0x18,%esp
	return priorityQ->extractProc(p);
80104ef6:	8b 45 08             	mov    0x8(%ebp),%eax
80104ef9:	89 44 24 04          	mov    %eax,0x4(%esp)
80104efd:	a1 0c b6 10 80       	mov    0x8010b60c,%eax
80104f02:	89 04 24             	mov    %eax,(%esp)
80104f05:	e8 66 ff ff ff       	call   80104e70 <_ZN3Map11extractProcEP4proc>
}
80104f0a:	c9                   	leave  
	return priorityQ->extractProc(p);
80104f0b:	0f b6 c0             	movzbl %al,%eax
}
80104f0e:	c3                   	ret    
80104f0f:	90                   	nop

80104f10 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104f10:	55                   	push   %ebp
  initlock(&lk->lk, "sleep lock");
80104f11:	b8 cc 83 10 80       	mov    $0x801083cc,%eax
{
80104f16:	89 e5                	mov    %esp,%ebp
80104f18:	53                   	push   %ebx
80104f19:	83 ec 14             	sub    $0x14,%esp
80104f1c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104f1f:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f23:	8d 43 04             	lea    0x4(%ebx),%eax
80104f26:	89 04 24             	mov    %eax,(%esp)
80104f29:	e8 12 01 00 00       	call   80105040 <initlock>
  lk->name = name;
80104f2e:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104f31:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104f37:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104f3e:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104f41:	83 c4 14             	add    $0x14,%esp
80104f44:	5b                   	pop    %ebx
80104f45:	5d                   	pop    %ebp
80104f46:	c3                   	ret    
80104f47:	89 f6                	mov    %esi,%esi
80104f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f50 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104f50:	55                   	push   %ebp
80104f51:	89 e5                	mov    %esp,%ebp
80104f53:	56                   	push   %esi
80104f54:	53                   	push   %ebx
80104f55:	83 ec 10             	sub    $0x10,%esp
80104f58:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104f5b:	8d 73 04             	lea    0x4(%ebx),%esi
80104f5e:	89 34 24             	mov    %esi,(%esp)
80104f61:	e8 2a 02 00 00       	call   80105190 <acquire>
  while (lk->locked) {
80104f66:	8b 13                	mov    (%ebx),%edx
80104f68:	85 d2                	test   %edx,%edx
80104f6a:	74 16                	je     80104f82 <acquiresleep+0x32>
80104f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80104f70:	89 74 24 04          	mov    %esi,0x4(%esp)
80104f74:	89 1c 24             	mov    %ebx,(%esp)
80104f77:	e8 94 ef ff ff       	call   80103f10 <sleep>
  while (lk->locked) {
80104f7c:	8b 03                	mov    (%ebx),%eax
80104f7e:	85 c0                	test   %eax,%eax
80104f80:	75 ee                	jne    80104f70 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104f82:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104f88:	e8 e3 e9 ff ff       	call   80103970 <myproc>
80104f8d:	8b 40 10             	mov    0x10(%eax),%eax
80104f90:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104f93:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104f96:	83 c4 10             	add    $0x10,%esp
80104f99:	5b                   	pop    %ebx
80104f9a:	5e                   	pop    %esi
80104f9b:	5d                   	pop    %ebp
  release(&lk->lk);
80104f9c:	e9 8f 02 00 00       	jmp    80105230 <release>
80104fa1:	eb 0d                	jmp    80104fb0 <releasesleep>
80104fa3:	90                   	nop
80104fa4:	90                   	nop
80104fa5:	90                   	nop
80104fa6:	90                   	nop
80104fa7:	90                   	nop
80104fa8:	90                   	nop
80104fa9:	90                   	nop
80104faa:	90                   	nop
80104fab:	90                   	nop
80104fac:	90                   	nop
80104fad:	90                   	nop
80104fae:	90                   	nop
80104faf:	90                   	nop

80104fb0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104fb0:	55                   	push   %ebp
80104fb1:	89 e5                	mov    %esp,%ebp
80104fb3:	83 ec 18             	sub    $0x18,%esp
80104fb6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80104fb9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104fbc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  acquire(&lk->lk);
80104fbf:	8d 73 04             	lea    0x4(%ebx),%esi
80104fc2:	89 34 24             	mov    %esi,(%esp)
80104fc5:	e8 c6 01 00 00       	call   80105190 <acquire>
  lk->locked = 0;
80104fca:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104fd0:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104fd7:	89 1c 24             	mov    %ebx,(%esp)
80104fda:	e8 f1 f0 ff ff       	call   801040d0 <wakeup>
  release(&lk->lk);
}
80104fdf:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  release(&lk->lk);
80104fe2:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104fe5:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104fe8:	89 ec                	mov    %ebp,%esp
80104fea:	5d                   	pop    %ebp
  release(&lk->lk);
80104feb:	e9 40 02 00 00       	jmp    80105230 <release>

80104ff0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104ff0:	55                   	push   %ebp
80104ff1:	89 e5                	mov    %esp,%ebp
80104ff3:	83 ec 28             	sub    $0x28,%esp
80104ff6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80104ff9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104ffc:	89 7d fc             	mov    %edi,-0x4(%ebp)
80104fff:	89 75 f8             	mov    %esi,-0x8(%ebp)
80105002:	31 f6                	xor    %esi,%esi
  int r;
  
  acquire(&lk->lk);
80105004:	8d 7b 04             	lea    0x4(%ebx),%edi
80105007:	89 3c 24             	mov    %edi,(%esp)
8010500a:	e8 81 01 00 00       	call   80105190 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
8010500f:	8b 03                	mov    (%ebx),%eax
80105011:	85 c0                	test   %eax,%eax
80105013:	74 11                	je     80105026 <holdingsleep+0x36>
80105015:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80105018:	e8 53 e9 ff ff       	call   80103970 <myproc>
8010501d:	39 58 10             	cmp    %ebx,0x10(%eax)
80105020:	0f 94 c0             	sete   %al
80105023:	0f b6 f0             	movzbl %al,%esi
  release(&lk->lk);
80105026:	89 3c 24             	mov    %edi,(%esp)
80105029:	e8 02 02 00 00       	call   80105230 <release>
  return r;
}
8010502e:	89 f0                	mov    %esi,%eax
80105030:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105033:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105036:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105039:	89 ec                	mov    %ebp,%esp
8010503b:	5d                   	pop    %ebp
8010503c:	c3                   	ret    
8010503d:	66 90                	xchg   %ax,%ax
8010503f:	90                   	nop

80105040 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105040:	55                   	push   %ebp
80105041:	89 e5                	mov    %esp,%ebp
80105043:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80105046:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80105049:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010504f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80105052:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105059:	5d                   	pop    %ebp
8010505a:	c3                   	ret    
8010505b:	90                   	nop
8010505c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105060 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105060:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105061:	31 d2                	xor    %edx,%edx
{
80105063:	89 e5                	mov    %esp,%ebp
  ebp = (uint*)v - 2;
80105065:	8b 45 08             	mov    0x8(%ebp),%eax
{
80105068:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010506b:	53                   	push   %ebx
  ebp = (uint*)v - 2;
8010506c:	83 e8 08             	sub    $0x8,%eax
8010506f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105070:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80105076:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010507c:	77 12                	ja     80105090 <getcallerpcs+0x30>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010507e:	8b 58 04             	mov    0x4(%eax),%ebx
80105081:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80105084:	42                   	inc    %edx
80105085:	83 fa 0a             	cmp    $0xa,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80105088:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
8010508a:	75 e4                	jne    80105070 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010508c:	5b                   	pop    %ebx
8010508d:	5d                   	pop    %ebp
8010508e:	c3                   	ret    
8010508f:	90                   	nop
80105090:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80105093:	83 c1 28             	add    $0x28,%ecx
80105096:	8d 76 00             	lea    0x0(%esi),%esi
80105099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
801050a0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801050a6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801050a9:	39 c1                	cmp    %eax,%ecx
801050ab:	75 f3                	jne    801050a0 <getcallerpcs+0x40>
}
801050ad:	5b                   	pop    %ebx
801050ae:	5d                   	pop    %ebp
801050af:	c3                   	ret    

801050b0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801050b0:	55                   	push   %ebp
801050b1:	89 e5                	mov    %esp,%ebp
801050b3:	53                   	push   %ebx
801050b4:	83 ec 04             	sub    $0x4,%esp
801050b7:	9c                   	pushf  
801050b8:	5b                   	pop    %ebx
  asm volatile("cli");
801050b9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801050ba:	e8 11 e8 ff ff       	call   801038d0 <mycpu>
801050bf:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801050c5:	85 d2                	test   %edx,%edx
801050c7:	75 11                	jne    801050da <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801050c9:	e8 02 e8 ff ff       	call   801038d0 <mycpu>
801050ce:	81 e3 00 02 00 00    	and    $0x200,%ebx
801050d4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801050da:	e8 f1 e7 ff ff       	call   801038d0 <mycpu>
801050df:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
}
801050e5:	58                   	pop    %eax
801050e6:	5b                   	pop    %ebx
801050e7:	5d                   	pop    %ebp
801050e8:	c3                   	ret    
801050e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801050f0 <popcli>:

void
popcli(void)
{
801050f0:	55                   	push   %ebp
801050f1:	89 e5                	mov    %esp,%ebp
801050f3:	83 ec 18             	sub    $0x18,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801050f6:	9c                   	pushf  
801050f7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801050f8:	f6 c4 02             	test   $0x2,%ah
801050fb:	75 35                	jne    80105132 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801050fd:	e8 ce e7 ff ff       	call   801038d0 <mycpu>
80105102:	ff 88 a4 00 00 00    	decl   0xa4(%eax)
80105108:	78 34                	js     8010513e <popcli+0x4e>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010510a:	e8 c1 e7 ff ff       	call   801038d0 <mycpu>
8010510f:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105115:	85 d2                	test   %edx,%edx
80105117:	74 07                	je     80105120 <popcli+0x30>
    sti();
}
80105119:	c9                   	leave  
8010511a:	c3                   	ret    
8010511b:	90                   	nop
8010511c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105120:	e8 ab e7 ff ff       	call   801038d0 <mycpu>
80105125:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010512b:	85 c0                	test   %eax,%eax
8010512d:	74 ea                	je     80105119 <popcli+0x29>
  asm volatile("sti");
8010512f:	fb                   	sti    
}
80105130:	c9                   	leave  
80105131:	c3                   	ret    
    panic("popcli - interruptible");
80105132:	c7 04 24 d7 83 10 80 	movl   $0x801083d7,(%esp)
80105139:	e8 32 b2 ff ff       	call   80100370 <panic>
    panic("popcli");
8010513e:	c7 04 24 ee 83 10 80 	movl   $0x801083ee,(%esp)
80105145:	e8 26 b2 ff ff       	call   80100370 <panic>
8010514a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105150 <holding>:
{
80105150:	55                   	push   %ebp
80105151:	89 e5                	mov    %esp,%ebp
80105153:	83 ec 08             	sub    $0x8,%esp
80105156:	89 75 fc             	mov    %esi,-0x4(%ebp)
80105159:	8b 75 08             	mov    0x8(%ebp),%esi
8010515c:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010515f:	31 db                	xor    %ebx,%ebx
  pushcli();
80105161:	e8 4a ff ff ff       	call   801050b0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105166:	8b 06                	mov    (%esi),%eax
80105168:	85 c0                	test   %eax,%eax
8010516a:	74 10                	je     8010517c <holding+0x2c>
8010516c:	8b 5e 08             	mov    0x8(%esi),%ebx
8010516f:	e8 5c e7 ff ff       	call   801038d0 <mycpu>
80105174:	39 c3                	cmp    %eax,%ebx
80105176:	0f 94 c3             	sete   %bl
80105179:	0f b6 db             	movzbl %bl,%ebx
  popcli();
8010517c:	e8 6f ff ff ff       	call   801050f0 <popcli>
}
80105181:	89 d8                	mov    %ebx,%eax
80105183:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105186:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105189:	89 ec                	mov    %ebp,%esp
8010518b:	5d                   	pop    %ebp
8010518c:	c3                   	ret    
8010518d:	8d 76 00             	lea    0x0(%esi),%esi

80105190 <acquire>:
{
80105190:	55                   	push   %ebp
80105191:	89 e5                	mov    %esp,%ebp
80105193:	56                   	push   %esi
80105194:	53                   	push   %ebx
80105195:	83 ec 10             	sub    $0x10,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105198:	e8 13 ff ff ff       	call   801050b0 <pushcli>
  if(holding(lk))
8010519d:	8b 5d 08             	mov    0x8(%ebp),%ebx
801051a0:	89 1c 24             	mov    %ebx,(%esp)
801051a3:	e8 a8 ff ff ff       	call   80105150 <holding>
801051a8:	85 c0                	test   %eax,%eax
801051aa:	75 78                	jne    80105224 <acquire+0x94>
801051ac:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
801051ae:	ba 01 00 00 00       	mov    $0x1,%edx
801051b3:	eb 06                	jmp    801051bb <acquire+0x2b>
801051b5:	8d 76 00             	lea    0x0(%esi),%esi
801051b8:	8b 5d 08             	mov    0x8(%ebp),%ebx
801051bb:	89 d0                	mov    %edx,%eax
801051bd:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
801051c0:	85 c0                	test   %eax,%eax
801051c2:	75 f4                	jne    801051b8 <acquire+0x28>
  __sync_synchronize();
801051c4:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801051c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801051cc:	e8 ff e6 ff ff       	call   801038d0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801051d1:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
801051d4:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
801051d7:	89 e8                	mov    %ebp,%eax
801051d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801051e0:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
801051e6:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
801051ec:	77 1a                	ja     80105208 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
801051ee:	8b 48 04             	mov    0x4(%eax),%ecx
801051f1:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
801051f4:	46                   	inc    %esi
801051f5:	83 fe 0a             	cmp    $0xa,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
801051f8:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801051fa:	75 e4                	jne    801051e0 <acquire+0x50>
}
801051fc:	83 c4 10             	add    $0x10,%esp
801051ff:	5b                   	pop    %ebx
80105200:	5e                   	pop    %esi
80105201:	5d                   	pop    %ebp
80105202:	c3                   	ret    
80105203:	90                   	nop
80105204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105208:	8d 04 b2             	lea    (%edx,%esi,4),%eax
8010520b:	83 c2 28             	add    $0x28,%edx
8010520e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80105210:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105216:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80105219:	39 d0                	cmp    %edx,%eax
8010521b:	75 f3                	jne    80105210 <acquire+0x80>
}
8010521d:	83 c4 10             	add    $0x10,%esp
80105220:	5b                   	pop    %ebx
80105221:	5e                   	pop    %esi
80105222:	5d                   	pop    %ebp
80105223:	c3                   	ret    
    panic("acquire");
80105224:	c7 04 24 f5 83 10 80 	movl   $0x801083f5,(%esp)
8010522b:	e8 40 b1 ff ff       	call   80100370 <panic>

80105230 <release>:
{
80105230:	55                   	push   %ebp
80105231:	89 e5                	mov    %esp,%ebp
80105233:	53                   	push   %ebx
80105234:	83 ec 14             	sub    $0x14,%esp
80105237:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010523a:	89 1c 24             	mov    %ebx,(%esp)
8010523d:	e8 0e ff ff ff       	call   80105150 <holding>
80105242:	85 c0                	test   %eax,%eax
80105244:	74 23                	je     80105269 <release+0x39>
  lk->pcs[0] = 0;
80105246:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010524d:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105254:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80105259:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
8010525f:	83 c4 14             	add    $0x14,%esp
80105262:	5b                   	pop    %ebx
80105263:	5d                   	pop    %ebp
  popcli();
80105264:	e9 87 fe ff ff       	jmp    801050f0 <popcli>
    panic("release");
80105269:	c7 04 24 fd 83 10 80 	movl   $0x801083fd,(%esp)
80105270:	e8 fb b0 ff ff       	call   80100370 <panic>
80105275:	66 90                	xchg   %ax,%ax
80105277:	66 90                	xchg   %ax,%ax
80105279:	66 90                	xchg   %ax,%ax
8010527b:	66 90                	xchg   %ax,%ax
8010527d:	66 90                	xchg   %ax,%ax
8010527f:	90                   	nop

80105280 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105280:	55                   	push   %ebp
80105281:	89 e5                	mov    %esp,%ebp
80105283:	83 ec 08             	sub    $0x8,%esp
80105286:	8b 55 08             	mov    0x8(%ebp),%edx
80105289:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010528c:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010528f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if ((int)dst%4 == 0 && n%4 == 0){
80105292:	f6 c2 03             	test   $0x3,%dl
80105295:	75 05                	jne    8010529c <memset+0x1c>
80105297:	f6 c1 03             	test   $0x3,%cl
8010529a:	74 14                	je     801052b0 <memset+0x30>
  asm volatile("cld; rep stosb" :
8010529c:	89 d7                	mov    %edx,%edi
8010529e:	8b 45 0c             	mov    0xc(%ebp),%eax
801052a1:	fc                   	cld    
801052a2:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801052a4:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801052a7:	89 d0                	mov    %edx,%eax
801052a9:	8b 7d fc             	mov    -0x4(%ebp),%edi
801052ac:	89 ec                	mov    %ebp,%esp
801052ae:	5d                   	pop    %ebp
801052af:	c3                   	ret    
    c &= 0xFF;
801052b0:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801052b4:	c1 e9 02             	shr    $0x2,%ecx
801052b7:	89 f8                	mov    %edi,%eax
801052b9:	89 fb                	mov    %edi,%ebx
801052bb:	c1 e0 18             	shl    $0x18,%eax
801052be:	c1 e3 10             	shl    $0x10,%ebx
801052c1:	09 d8                	or     %ebx,%eax
801052c3:	09 f8                	or     %edi,%eax
801052c5:	c1 e7 08             	shl    $0x8,%edi
801052c8:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
801052ca:	89 d7                	mov    %edx,%edi
801052cc:	fc                   	cld    
801052cd:	f3 ab                	rep stos %eax,%es:(%edi)
}
801052cf:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801052d2:	89 d0                	mov    %edx,%eax
801052d4:	8b 7d fc             	mov    -0x4(%ebp),%edi
801052d7:	89 ec                	mov    %ebp,%esp
801052d9:	5d                   	pop    %ebp
801052da:	c3                   	ret    
801052db:	90                   	nop
801052dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801052e0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801052e0:	55                   	push   %ebp
801052e1:	89 e5                	mov    %esp,%ebp
801052e3:	57                   	push   %edi
801052e4:	8b 7d 0c             	mov    0xc(%ebp),%edi
801052e7:	56                   	push   %esi
801052e8:	8b 75 08             	mov    0x8(%ebp),%esi
801052eb:	53                   	push   %ebx
801052ec:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801052ef:	85 db                	test   %ebx,%ebx
801052f1:	74 27                	je     8010531a <memcmp+0x3a>
    if(*s1 != *s2)
801052f3:	0f b6 16             	movzbl (%esi),%edx
801052f6:	0f b6 0f             	movzbl (%edi),%ecx
801052f9:	38 d1                	cmp    %dl,%cl
801052fb:	75 2b                	jne    80105328 <memcmp+0x48>
801052fd:	b8 01 00 00 00       	mov    $0x1,%eax
80105302:	eb 12                	jmp    80105316 <memcmp+0x36>
80105304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105308:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
8010530c:	40                   	inc    %eax
8010530d:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80105312:	38 ca                	cmp    %cl,%dl
80105314:	75 12                	jne    80105328 <memcmp+0x48>
  while(n-- > 0){
80105316:	39 d8                	cmp    %ebx,%eax
80105318:	75 ee                	jne    80105308 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010531a:	5b                   	pop    %ebx
  return 0;
8010531b:	31 c0                	xor    %eax,%eax
}
8010531d:	5e                   	pop    %esi
8010531e:	5f                   	pop    %edi
8010531f:	5d                   	pop    %ebp
80105320:	c3                   	ret    
80105321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105328:	5b                   	pop    %ebx
      return *s1 - *s2;
80105329:	0f b6 c2             	movzbl %dl,%eax
8010532c:	29 c8                	sub    %ecx,%eax
}
8010532e:	5e                   	pop    %esi
8010532f:	5f                   	pop    %edi
80105330:	5d                   	pop    %ebp
80105331:	c3                   	ret    
80105332:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105340 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105340:	55                   	push   %ebp
80105341:	89 e5                	mov    %esp,%ebp
80105343:	56                   	push   %esi
80105344:	8b 45 08             	mov    0x8(%ebp),%eax
80105347:	53                   	push   %ebx
80105348:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010534b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010534e:	39 c3                	cmp    %eax,%ebx
80105350:	73 26                	jae    80105378 <memmove+0x38>
80105352:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80105355:	39 c8                	cmp    %ecx,%eax
80105357:	73 1f                	jae    80105378 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80105359:	85 f6                	test   %esi,%esi
8010535b:	8d 56 ff             	lea    -0x1(%esi),%edx
8010535e:	74 0d                	je     8010536d <memmove+0x2d>
      *--d = *--s;
80105360:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105364:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80105367:	4a                   	dec    %edx
80105368:	83 fa ff             	cmp    $0xffffffff,%edx
8010536b:	75 f3                	jne    80105360 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010536d:	5b                   	pop    %ebx
8010536e:	5e                   	pop    %esi
8010536f:	5d                   	pop    %ebp
80105370:	c3                   	ret    
80105371:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80105378:	31 d2                	xor    %edx,%edx
8010537a:	85 f6                	test   %esi,%esi
8010537c:	74 ef                	je     8010536d <memmove+0x2d>
8010537e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80105380:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105384:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80105387:	42                   	inc    %edx
    while(n-- > 0)
80105388:	39 d6                	cmp    %edx,%esi
8010538a:	75 f4                	jne    80105380 <memmove+0x40>
}
8010538c:	5b                   	pop    %ebx
8010538d:	5e                   	pop    %esi
8010538e:	5d                   	pop    %ebp
8010538f:	c3                   	ret    

80105390 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105390:	55                   	push   %ebp
80105391:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80105393:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80105394:	eb aa                	jmp    80105340 <memmove>
80105396:	8d 76 00             	lea    0x0(%esi),%esi
80105399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801053a0 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
801053a0:	55                   	push   %ebp
801053a1:	89 e5                	mov    %esp,%ebp
801053a3:	57                   	push   %edi
801053a4:	8b 7d 10             	mov    0x10(%ebp),%edi
801053a7:	56                   	push   %esi
801053a8:	8b 75 0c             	mov    0xc(%ebp),%esi
801053ab:	53                   	push   %ebx
801053ac:	8b 5d 08             	mov    0x8(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
801053af:	85 ff                	test   %edi,%edi
801053b1:	74 2d                	je     801053e0 <strncmp+0x40>
801053b3:	0f b6 03             	movzbl (%ebx),%eax
801053b6:	0f b6 0e             	movzbl (%esi),%ecx
801053b9:	84 c0                	test   %al,%al
801053bb:	74 37                	je     801053f4 <strncmp+0x54>
801053bd:	38 c1                	cmp    %al,%cl
801053bf:	75 33                	jne    801053f4 <strncmp+0x54>
801053c1:	01 f7                	add    %esi,%edi
801053c3:	eb 13                	jmp    801053d8 <strncmp+0x38>
801053c5:	8d 76 00             	lea    0x0(%esi),%esi
801053c8:	0f b6 03             	movzbl (%ebx),%eax
801053cb:	84 c0                	test   %al,%al
801053cd:	74 21                	je     801053f0 <strncmp+0x50>
801053cf:	0f b6 0a             	movzbl (%edx),%ecx
801053d2:	89 d6                	mov    %edx,%esi
801053d4:	38 c8                	cmp    %cl,%al
801053d6:	75 1c                	jne    801053f4 <strncmp+0x54>
    n--, p++, q++;
801053d8:	8d 56 01             	lea    0x1(%esi),%edx
801053db:	43                   	inc    %ebx
  while(n > 0 && *p && *p == *q)
801053dc:	39 fa                	cmp    %edi,%edx
801053de:	75 e8                	jne    801053c8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
801053e0:	5b                   	pop    %ebx
    return 0;
801053e1:	31 c0                	xor    %eax,%eax
}
801053e3:	5e                   	pop    %esi
801053e4:	5f                   	pop    %edi
801053e5:	5d                   	pop    %ebp
801053e6:	c3                   	ret    
801053e7:	89 f6                	mov    %esi,%esi
801053e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801053f0:	0f b6 4e 01          	movzbl 0x1(%esi),%ecx
801053f4:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
801053f5:	29 c8                	sub    %ecx,%eax
}
801053f7:	5e                   	pop    %esi
801053f8:	5f                   	pop    %edi
801053f9:	5d                   	pop    %ebp
801053fa:	c3                   	ret    
801053fb:	90                   	nop
801053fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105400 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105400:	55                   	push   %ebp
80105401:	89 e5                	mov    %esp,%ebp
80105403:	8b 45 08             	mov    0x8(%ebp),%eax
80105406:	56                   	push   %esi
80105407:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010540a:	53                   	push   %ebx
8010540b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010540e:	89 c2                	mov    %eax,%edx
80105410:	eb 15                	jmp    80105427 <strncpy+0x27>
80105412:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105418:	46                   	inc    %esi
80105419:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
8010541d:	42                   	inc    %edx
8010541e:	84 c9                	test   %cl,%cl
80105420:	88 4a ff             	mov    %cl,-0x1(%edx)
80105423:	74 09                	je     8010542e <strncpy+0x2e>
80105425:	89 d9                	mov    %ebx,%ecx
80105427:	85 c9                	test   %ecx,%ecx
80105429:	8d 59 ff             	lea    -0x1(%ecx),%ebx
8010542c:	7f ea                	jg     80105418 <strncpy+0x18>
    ;
  while(n-- > 0)
8010542e:	31 c9                	xor    %ecx,%ecx
80105430:	85 db                	test   %ebx,%ebx
80105432:	7e 19                	jle    8010544d <strncpy+0x4d>
80105434:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010543a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *s++ = 0;
80105440:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80105444:	89 de                	mov    %ebx,%esi
80105446:	41                   	inc    %ecx
80105447:	29 ce                	sub    %ecx,%esi
  while(n-- > 0)
80105449:	85 f6                	test   %esi,%esi
8010544b:	7f f3                	jg     80105440 <strncpy+0x40>
  return os;
}
8010544d:	5b                   	pop    %ebx
8010544e:	5e                   	pop    %esi
8010544f:	5d                   	pop    %ebp
80105450:	c3                   	ret    
80105451:	eb 0d                	jmp    80105460 <safestrcpy>
80105453:	90                   	nop
80105454:	90                   	nop
80105455:	90                   	nop
80105456:	90                   	nop
80105457:	90                   	nop
80105458:	90                   	nop
80105459:	90                   	nop
8010545a:	90                   	nop
8010545b:	90                   	nop
8010545c:	90                   	nop
8010545d:	90                   	nop
8010545e:	90                   	nop
8010545f:	90                   	nop

80105460 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105460:	55                   	push   %ebp
80105461:	89 e5                	mov    %esp,%ebp
80105463:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105466:	56                   	push   %esi
80105467:	8b 45 08             	mov    0x8(%ebp),%eax
8010546a:	53                   	push   %ebx
8010546b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010546e:	85 c9                	test   %ecx,%ecx
80105470:	7e 22                	jle    80105494 <safestrcpy+0x34>
80105472:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80105476:	89 c1                	mov    %eax,%ecx
80105478:	eb 13                	jmp    8010548d <safestrcpy+0x2d>
8010547a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105480:	42                   	inc    %edx
80105481:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80105485:	41                   	inc    %ecx
80105486:	84 db                	test   %bl,%bl
80105488:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010548b:	74 04                	je     80105491 <safestrcpy+0x31>
8010548d:	39 f2                	cmp    %esi,%edx
8010548f:	75 ef                	jne    80105480 <safestrcpy+0x20>
    ;
  *s = 0;
80105491:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80105494:	5b                   	pop    %ebx
80105495:	5e                   	pop    %esi
80105496:	5d                   	pop    %ebp
80105497:	c3                   	ret    
80105498:	90                   	nop
80105499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801054a0 <strlen>:

int
strlen(const char *s)
{
801054a0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
801054a1:	31 c0                	xor    %eax,%eax
{
801054a3:	89 e5                	mov    %esp,%ebp
801054a5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
801054a8:	80 3a 00             	cmpb   $0x0,(%edx)
801054ab:	74 0a                	je     801054b7 <strlen+0x17>
801054ad:	8d 76 00             	lea    0x0(%esi),%esi
801054b0:	40                   	inc    %eax
801054b1:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801054b5:	75 f9                	jne    801054b0 <strlen+0x10>
    ;
  return n;
}
801054b7:	5d                   	pop    %ebp
801054b8:	c3                   	ret    

801054b9 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
801054b9:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801054bd:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
801054c1:	55                   	push   %ebp
  pushl %ebx
801054c2:	53                   	push   %ebx
  pushl %esi
801054c3:	56                   	push   %esi
  pushl %edi
801054c4:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801054c5:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801054c7:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
801054c9:	5f                   	pop    %edi
  popl %esi
801054ca:	5e                   	pop    %esi
  popl %ebx
801054cb:	5b                   	pop    %ebx
  popl %ebp
801054cc:	5d                   	pop    %ebp
  ret
801054cd:	c3                   	ret    
801054ce:	66 90                	xchg   %ax,%ax

801054d0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801054d0:	55                   	push   %ebp
801054d1:	89 e5                	mov    %esp,%ebp
801054d3:	53                   	push   %ebx
801054d4:	83 ec 04             	sub    $0x4,%esp
801054d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801054da:	e8 91 e4 ff ff       	call   80103970 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801054df:	8b 00                	mov    (%eax),%eax
801054e1:	39 d8                	cmp    %ebx,%eax
801054e3:	76 1b                	jbe    80105500 <fetchint+0x30>
801054e5:	8d 53 04             	lea    0x4(%ebx),%edx
801054e8:	39 d0                	cmp    %edx,%eax
801054ea:	72 14                	jb     80105500 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801054ec:	8b 45 0c             	mov    0xc(%ebp),%eax
801054ef:	8b 13                	mov    (%ebx),%edx
801054f1:	89 10                	mov    %edx,(%eax)
  return 0;
801054f3:	31 c0                	xor    %eax,%eax
}
801054f5:	5a                   	pop    %edx
801054f6:	5b                   	pop    %ebx
801054f7:	5d                   	pop    %ebp
801054f8:	c3                   	ret    
801054f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105500:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105505:	eb ee                	jmp    801054f5 <fetchint+0x25>
80105507:	89 f6                	mov    %esi,%esi
80105509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105510 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105510:	55                   	push   %ebp
80105511:	89 e5                	mov    %esp,%ebp
80105513:	53                   	push   %ebx
80105514:	83 ec 04             	sub    $0x4,%esp
80105517:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010551a:	e8 51 e4 ff ff       	call   80103970 <myproc>

  if(addr >= curproc->sz)
8010551f:	39 18                	cmp    %ebx,(%eax)
80105521:	76 27                	jbe    8010554a <fetchstr+0x3a>
    return -1;
  *pp = (char*)addr;
80105523:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105526:	89 da                	mov    %ebx,%edx
80105528:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010552a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010552c:	39 c3                	cmp    %eax,%ebx
8010552e:	73 1a                	jae    8010554a <fetchstr+0x3a>
    if(*s == 0)
80105530:	80 3b 00             	cmpb   $0x0,(%ebx)
80105533:	75 10                	jne    80105545 <fetchstr+0x35>
80105535:	eb 29                	jmp    80105560 <fetchstr+0x50>
80105537:	89 f6                	mov    %esi,%esi
80105539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105540:	80 3a 00             	cmpb   $0x0,(%edx)
80105543:	74 13                	je     80105558 <fetchstr+0x48>
  for(s = *pp; s < ep; s++){
80105545:	42                   	inc    %edx
80105546:	39 d0                	cmp    %edx,%eax
80105548:	77 f6                	ja     80105540 <fetchstr+0x30>
    return -1;
8010554a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
8010554f:	5a                   	pop    %edx
80105550:	5b                   	pop    %ebx
80105551:	5d                   	pop    %ebp
80105552:	c3                   	ret    
80105553:	90                   	nop
80105554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105558:	89 d0                	mov    %edx,%eax
8010555a:	5a                   	pop    %edx
8010555b:	29 d8                	sub    %ebx,%eax
8010555d:	5b                   	pop    %ebx
8010555e:	5d                   	pop    %ebp
8010555f:	c3                   	ret    
    if(*s == 0)
80105560:	31 c0                	xor    %eax,%eax
      return s - *pp;
80105562:	eb eb                	jmp    8010554f <fetchstr+0x3f>
80105564:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010556a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105570 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105570:	55                   	push   %ebp
80105571:	89 e5                	mov    %esp,%ebp
80105573:	56                   	push   %esi
80105574:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105575:	e8 f6 e3 ff ff       	call   80103970 <myproc>
8010557a:	8b 55 08             	mov    0x8(%ebp),%edx
8010557d:	8b 40 18             	mov    0x18(%eax),%eax
80105580:	8b 40 44             	mov    0x44(%eax),%eax
80105583:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105586:	e8 e5 e3 ff ff       	call   80103970 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010558b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010558e:	8b 00                	mov    (%eax),%eax
80105590:	39 c6                	cmp    %eax,%esi
80105592:	73 1c                	jae    801055b0 <argint+0x40>
80105594:	8d 53 08             	lea    0x8(%ebx),%edx
80105597:	39 d0                	cmp    %edx,%eax
80105599:	72 15                	jb     801055b0 <argint+0x40>
  *ip = *(int*)(addr);
8010559b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010559e:	8b 53 04             	mov    0x4(%ebx),%edx
801055a1:	89 10                	mov    %edx,(%eax)
  return 0;
801055a3:	31 c0                	xor    %eax,%eax
}
801055a5:	5b                   	pop    %ebx
801055a6:	5e                   	pop    %esi
801055a7:	5d                   	pop    %ebp
801055a8:	c3                   	ret    
801055a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801055b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801055b5:	eb ee                	jmp    801055a5 <argint+0x35>
801055b7:	89 f6                	mov    %esi,%esi
801055b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055c0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801055c0:	55                   	push   %ebp
801055c1:	89 e5                	mov    %esp,%ebp
801055c3:	56                   	push   %esi
801055c4:	53                   	push   %ebx
801055c5:	83 ec 20             	sub    $0x20,%esp
801055c8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801055cb:	e8 a0 e3 ff ff       	call   80103970 <myproc>
801055d0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
801055d2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801055d5:	89 44 24 04          	mov    %eax,0x4(%esp)
801055d9:	8b 45 08             	mov    0x8(%ebp),%eax
801055dc:	89 04 24             	mov    %eax,(%esp)
801055df:	e8 8c ff ff ff       	call   80105570 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801055e4:	c1 e8 1f             	shr    $0x1f,%eax
801055e7:	84 c0                	test   %al,%al
801055e9:	75 2d                	jne    80105618 <argptr+0x58>
801055eb:	89 d8                	mov    %ebx,%eax
801055ed:	c1 e8 1f             	shr    $0x1f,%eax
801055f0:	84 c0                	test   %al,%al
801055f2:	75 24                	jne    80105618 <argptr+0x58>
801055f4:	8b 16                	mov    (%esi),%edx
801055f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055f9:	39 c2                	cmp    %eax,%edx
801055fb:	76 1b                	jbe    80105618 <argptr+0x58>
801055fd:	01 c3                	add    %eax,%ebx
801055ff:	39 da                	cmp    %ebx,%edx
80105601:	72 15                	jb     80105618 <argptr+0x58>
    return -1;
  *pp = (char*)i;
80105603:	8b 55 0c             	mov    0xc(%ebp),%edx
80105606:	89 02                	mov    %eax,(%edx)
  return 0;
80105608:	31 c0                	xor    %eax,%eax
}
8010560a:	83 c4 20             	add    $0x20,%esp
8010560d:	5b                   	pop    %ebx
8010560e:	5e                   	pop    %esi
8010560f:	5d                   	pop    %ebp
80105610:	c3                   	ret    
80105611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105618:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010561d:	eb eb                	jmp    8010560a <argptr+0x4a>
8010561f:	90                   	nop

80105620 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105620:	55                   	push   %ebp
80105621:	89 e5                	mov    %esp,%ebp
80105623:	83 ec 28             	sub    $0x28,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105626:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105629:	89 44 24 04          	mov    %eax,0x4(%esp)
8010562d:	8b 45 08             	mov    0x8(%ebp),%eax
80105630:	89 04 24             	mov    %eax,(%esp)
80105633:	e8 38 ff ff ff       	call   80105570 <argint>
80105638:	85 c0                	test   %eax,%eax
8010563a:	78 14                	js     80105650 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
8010563c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010563f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105643:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105646:	89 04 24             	mov    %eax,(%esp)
80105649:	e8 c2 fe ff ff       	call   80105510 <fetchstr>
}
8010564e:	c9                   	leave  
8010564f:	c3                   	ret    
    return -1;
80105650:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105655:	c9                   	leave  
80105656:	c3                   	ret    
80105657:	89 f6                	mov    %esi,%esi
80105659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105660 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80105660:	55                   	push   %ebp
80105661:	89 e5                	mov    %esp,%ebp
80105663:	53                   	push   %ebx
80105664:	83 ec 14             	sub    $0x14,%esp
  int num;
  struct proc *curproc = myproc();
80105667:	e8 04 e3 ff ff       	call   80103970 <myproc>
8010566c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010566e:	8b 40 18             	mov    0x18(%eax),%eax
80105671:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105674:	8d 50 ff             	lea    -0x1(%eax),%edx
80105677:	83 fa 14             	cmp    $0x14,%edx
8010567a:	77 1c                	ja     80105698 <syscall+0x38>
8010567c:	8b 14 85 40 84 10 80 	mov    -0x7fef7bc0(,%eax,4),%edx
80105683:	85 d2                	test   %edx,%edx
80105685:	74 11                	je     80105698 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80105687:	ff d2                	call   *%edx
80105689:	8b 53 18             	mov    0x18(%ebx),%edx
8010568c:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
8010568f:	83 c4 14             	add    $0x14,%esp
80105692:	5b                   	pop    %ebx
80105693:	5d                   	pop    %ebp
80105694:	c3                   	ret    
80105695:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80105698:	89 44 24 0c          	mov    %eax,0xc(%esp)
            curproc->pid, curproc->name, num);
8010569c:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010569f:	89 44 24 08          	mov    %eax,0x8(%esp)
    cprintf("%d %s: unknown sys call %d\n",
801056a3:	8b 43 10             	mov    0x10(%ebx),%eax
801056a6:	c7 04 24 05 84 10 80 	movl   $0x80108405,(%esp)
801056ad:	89 44 24 04          	mov    %eax,0x4(%esp)
801056b1:	e8 9a af ff ff       	call   80100650 <cprintf>
    curproc->tf->eax = -1;
801056b6:	8b 43 18             	mov    0x18(%ebx),%eax
801056b9:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801056c0:	83 c4 14             	add    $0x14,%esp
801056c3:	5b                   	pop    %ebx
801056c4:	5d                   	pop    %ebp
801056c5:	c3                   	ret    
801056c6:	66 90                	xchg   %ax,%ax
801056c8:	66 90                	xchg   %ax,%ax
801056ca:	66 90                	xchg   %ax,%ax
801056cc:	66 90                	xchg   %ax,%ax
801056ce:	66 90                	xchg   %ax,%ax

801056d0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801056d0:	55                   	push   %ebp
801056d1:	0f bf d2             	movswl %dx,%edx
801056d4:	89 e5                	mov    %esp,%ebp
801056d6:	83 ec 58             	sub    $0x58,%esp
801056d9:	89 7d fc             	mov    %edi,-0x4(%ebp)
801056dc:	0f bf 7d 08          	movswl 0x8(%ebp),%edi
801056e0:	0f bf c9             	movswl %cx,%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801056e3:	89 04 24             	mov    %eax,(%esp)
{
801056e6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801056e9:	89 75 f8             	mov    %esi,-0x8(%ebp)
801056ec:	89 7d bc             	mov    %edi,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801056ef:	8d 7d da             	lea    -0x26(%ebp),%edi
801056f2:	89 7c 24 04          	mov    %edi,0x4(%esp)
{
801056f6:	89 55 c4             	mov    %edx,-0x3c(%ebp)
801056f9:	89 4d c0             	mov    %ecx,-0x40(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801056fc:	e8 ef c8 ff ff       	call   80101ff0 <nameiparent>
80105701:	85 c0                	test   %eax,%eax
80105703:	0f 84 4f 01 00 00    	je     80105858 <create+0x188>
    return 0;
  ilock(dp);
80105709:	89 04 24             	mov    %eax,(%esp)
8010570c:	89 c3                	mov    %eax,%ebx
8010570e:	e8 dd bf ff ff       	call   801016f0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80105713:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80105716:	89 44 24 08          	mov    %eax,0x8(%esp)
8010571a:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010571e:	89 1c 24             	mov    %ebx,(%esp)
80105721:	e8 4a c5 ff ff       	call   80101c70 <dirlookup>
80105726:	85 c0                	test   %eax,%eax
80105728:	89 c6                	mov    %eax,%esi
8010572a:	74 34                	je     80105760 <create+0x90>
    iunlockput(dp);
8010572c:	89 1c 24             	mov    %ebx,(%esp)
8010572f:	e8 4c c2 ff ff       	call   80101980 <iunlockput>
    ilock(ip);
80105734:	89 34 24             	mov    %esi,(%esp)
80105737:	e8 b4 bf ff ff       	call   801016f0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010573c:	83 7d c4 02          	cmpl   $0x2,-0x3c(%ebp)
80105740:	0f 85 9a 00 00 00    	jne    801057e0 <create+0x110>
80105746:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010574b:	0f 85 8f 00 00 00    	jne    801057e0 <create+0x110>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105751:	89 f0                	mov    %esi,%eax
80105753:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105756:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105759:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010575c:	89 ec                	mov    %ebp,%esp
8010575e:	5d                   	pop    %ebp
8010575f:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80105760:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80105763:	89 44 24 04          	mov    %eax,0x4(%esp)
80105767:	8b 03                	mov    (%ebx),%eax
80105769:	89 04 24             	mov    %eax,(%esp)
8010576c:	e8 ff bd ff ff       	call   80101570 <ialloc>
80105771:	85 c0                	test   %eax,%eax
80105773:	89 c6                	mov    %eax,%esi
80105775:	0f 84 f0 00 00 00    	je     8010586b <create+0x19b>
  ilock(ip);
8010577b:	89 04 24             	mov    %eax,(%esp)
8010577e:	e8 6d bf ff ff       	call   801016f0 <ilock>
  ip->major = major;
80105783:	8b 45 c0             	mov    -0x40(%ebp),%eax
  ip->nlink = 1;
80105786:	66 c7 46 56 01 00    	movw   $0x1,0x56(%esi)
  ip->major = major;
8010578c:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80105790:	8b 45 bc             	mov    -0x44(%ebp),%eax
80105793:	66 89 46 54          	mov    %ax,0x54(%esi)
  iupdate(ip);
80105797:	89 34 24             	mov    %esi,(%esp)
8010579a:	e8 91 be ff ff       	call   80101630 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
8010579f:	83 7d c4 01          	cmpl   $0x1,-0x3c(%ebp)
801057a3:	74 5b                	je     80105800 <create+0x130>
  if(dirlink(dp, name, ip->inum) < 0)
801057a5:	8b 46 04             	mov    0x4(%esi),%eax
801057a8:	89 7c 24 04          	mov    %edi,0x4(%esp)
801057ac:	89 1c 24             	mov    %ebx,(%esp)
801057af:	89 44 24 08          	mov    %eax,0x8(%esp)
801057b3:	e8 38 c7 ff ff       	call   80101ef0 <dirlink>
801057b8:	85 c0                	test   %eax,%eax
801057ba:	0f 88 9f 00 00 00    	js     8010585f <create+0x18f>
  iunlockput(dp);
801057c0:	89 1c 24             	mov    %ebx,(%esp)
801057c3:	e8 b8 c1 ff ff       	call   80101980 <iunlockput>
}
801057c8:	89 f0                	mov    %esi,%eax
801057ca:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801057cd:	8b 75 f8             	mov    -0x8(%ebp),%esi
801057d0:	8b 7d fc             	mov    -0x4(%ebp),%edi
801057d3:	89 ec                	mov    %ebp,%esp
801057d5:	5d                   	pop    %ebp
801057d6:	c3                   	ret    
801057d7:	89 f6                	mov    %esi,%esi
801057d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
801057e0:	89 34 24             	mov    %esi,(%esp)
    return 0;
801057e3:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
801057e5:	e8 96 c1 ff ff       	call   80101980 <iunlockput>
}
801057ea:	89 f0                	mov    %esi,%eax
801057ec:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801057ef:	8b 75 f8             	mov    -0x8(%ebp),%esi
801057f2:	8b 7d fc             	mov    -0x4(%ebp),%edi
801057f5:	89 ec                	mov    %ebp,%esp
801057f7:	5d                   	pop    %ebp
801057f8:	c3                   	ret    
801057f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80105800:	66 ff 43 56          	incw   0x56(%ebx)
    iupdate(dp);
80105804:	89 1c 24             	mov    %ebx,(%esp)
80105807:	e8 24 be ff ff       	call   80101630 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010580c:	8b 46 04             	mov    0x4(%esi),%eax
8010580f:	ba b4 84 10 80       	mov    $0x801084b4,%edx
80105814:	89 54 24 04          	mov    %edx,0x4(%esp)
80105818:	89 34 24             	mov    %esi,(%esp)
8010581b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010581f:	e8 cc c6 ff ff       	call   80101ef0 <dirlink>
80105824:	85 c0                	test   %eax,%eax
80105826:	78 20                	js     80105848 <create+0x178>
80105828:	8b 43 04             	mov    0x4(%ebx),%eax
8010582b:	89 34 24             	mov    %esi,(%esp)
8010582e:	89 44 24 08          	mov    %eax,0x8(%esp)
80105832:	b8 b3 84 10 80       	mov    $0x801084b3,%eax
80105837:	89 44 24 04          	mov    %eax,0x4(%esp)
8010583b:	e8 b0 c6 ff ff       	call   80101ef0 <dirlink>
80105840:	85 c0                	test   %eax,%eax
80105842:	0f 89 5d ff ff ff    	jns    801057a5 <create+0xd5>
      panic("create dots");
80105848:	c7 04 24 a7 84 10 80 	movl   $0x801084a7,(%esp)
8010584f:	e8 1c ab ff ff       	call   80100370 <panic>
80105854:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80105858:	31 f6                	xor    %esi,%esi
8010585a:	e9 f2 fe ff ff       	jmp    80105751 <create+0x81>
    panic("create: dirlink");
8010585f:	c7 04 24 b6 84 10 80 	movl   $0x801084b6,(%esp)
80105866:	e8 05 ab ff ff       	call   80100370 <panic>
    panic("create: ialloc");
8010586b:	c7 04 24 98 84 10 80 	movl   $0x80108498,(%esp)
80105872:	e8 f9 aa ff ff       	call   80100370 <panic>
80105877:	89 f6                	mov    %esi,%esi
80105879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105880 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80105880:	55                   	push   %ebp
80105881:	89 e5                	mov    %esp,%ebp
80105883:	56                   	push   %esi
80105884:	89 d6                	mov    %edx,%esi
80105886:	53                   	push   %ebx
80105887:	89 c3                	mov    %eax,%ebx
80105889:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
8010588c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010588f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105893:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010589a:	e8 d1 fc ff ff       	call   80105570 <argint>
8010589f:	85 c0                	test   %eax,%eax
801058a1:	78 2d                	js     801058d0 <argfd.constprop.0+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801058a3:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801058a7:	77 27                	ja     801058d0 <argfd.constprop.0+0x50>
801058a9:	e8 c2 e0 ff ff       	call   80103970 <myproc>
801058ae:	8b 55 f4             	mov    -0xc(%ebp),%edx
801058b1:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
801058b5:	85 c0                	test   %eax,%eax
801058b7:	74 17                	je     801058d0 <argfd.constprop.0+0x50>
  if(pfd)
801058b9:	85 db                	test   %ebx,%ebx
801058bb:	74 02                	je     801058bf <argfd.constprop.0+0x3f>
    *pfd = fd;
801058bd:	89 13                	mov    %edx,(%ebx)
    *pf = f;
801058bf:	89 06                	mov    %eax,(%esi)
  return 0;
801058c1:	31 c0                	xor    %eax,%eax
}
801058c3:	83 c4 20             	add    $0x20,%esp
801058c6:	5b                   	pop    %ebx
801058c7:	5e                   	pop    %esi
801058c8:	5d                   	pop    %ebp
801058c9:	c3                   	ret    
801058ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801058d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058d5:	eb ec                	jmp    801058c3 <argfd.constprop.0+0x43>
801058d7:	89 f6                	mov    %esi,%esi
801058d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058e0 <sys_dup>:
{
801058e0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
801058e1:	31 c0                	xor    %eax,%eax
{
801058e3:	89 e5                	mov    %esp,%ebp
801058e5:	56                   	push   %esi
801058e6:	53                   	push   %ebx
801058e7:	83 ec 20             	sub    $0x20,%esp
  if(argfd(0, 0, &f) < 0)
801058ea:	8d 55 f4             	lea    -0xc(%ebp),%edx
801058ed:	e8 8e ff ff ff       	call   80105880 <argfd.constprop.0>
801058f2:	85 c0                	test   %eax,%eax
801058f4:	78 3a                	js     80105930 <sys_dup+0x50>
  if((fd=fdalloc(f)) < 0)
801058f6:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
801058f9:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801058fb:	e8 70 e0 ff ff       	call   80103970 <myproc>
80105900:	eb 0c                	jmp    8010590e <sys_dup+0x2e>
80105902:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105908:	43                   	inc    %ebx
80105909:	83 fb 10             	cmp    $0x10,%ebx
8010590c:	74 22                	je     80105930 <sys_dup+0x50>
    if(curproc->ofile[fd] == 0){
8010590e:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105912:	85 d2                	test   %edx,%edx
80105914:	75 f2                	jne    80105908 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80105916:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
8010591a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010591d:	89 04 24             	mov    %eax,(%esp)
80105920:	e8 bb b4 ff ff       	call   80100de0 <filedup>
}
80105925:	83 c4 20             	add    $0x20,%esp
80105928:	89 d8                	mov    %ebx,%eax
8010592a:	5b                   	pop    %ebx
8010592b:	5e                   	pop    %esi
8010592c:	5d                   	pop    %ebp
8010592d:	c3                   	ret    
8010592e:	66 90                	xchg   %ax,%ax
80105930:	83 c4 20             	add    $0x20,%esp
    return -1;
80105933:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105938:	89 d8                	mov    %ebx,%eax
8010593a:	5b                   	pop    %ebx
8010593b:	5e                   	pop    %esi
8010593c:	5d                   	pop    %ebp
8010593d:	c3                   	ret    
8010593e:	66 90                	xchg   %ax,%ax

80105940 <sys_read>:
{
80105940:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105941:	31 c0                	xor    %eax,%eax
{
80105943:	89 e5                	mov    %esp,%ebp
80105945:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105948:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010594b:	e8 30 ff ff ff       	call   80105880 <argfd.constprop.0>
80105950:	85 c0                	test   %eax,%eax
80105952:	78 54                	js     801059a8 <sys_read+0x68>
80105954:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105957:	89 44 24 04          	mov    %eax,0x4(%esp)
8010595b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80105962:	e8 09 fc ff ff       	call   80105570 <argint>
80105967:	85 c0                	test   %eax,%eax
80105969:	78 3d                	js     801059a8 <sys_read+0x68>
8010596b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010596e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105975:	89 44 24 08          	mov    %eax,0x8(%esp)
80105979:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010597c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105980:	e8 3b fc ff ff       	call   801055c0 <argptr>
80105985:	85 c0                	test   %eax,%eax
80105987:	78 1f                	js     801059a8 <sys_read+0x68>
  return fileread(f, p, n);
80105989:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010598c:	89 44 24 08          	mov    %eax,0x8(%esp)
80105990:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105993:	89 44 24 04          	mov    %eax,0x4(%esp)
80105997:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010599a:	89 04 24             	mov    %eax,(%esp)
8010599d:	e8 be b5 ff ff       	call   80100f60 <fileread>
}
801059a2:	c9                   	leave  
801059a3:	c3                   	ret    
801059a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801059a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059ad:	c9                   	leave  
801059ae:	c3                   	ret    
801059af:	90                   	nop

801059b0 <sys_write>:
{
801059b0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801059b1:	31 c0                	xor    %eax,%eax
{
801059b3:	89 e5                	mov    %esp,%ebp
801059b5:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801059b8:	8d 55 ec             	lea    -0x14(%ebp),%edx
801059bb:	e8 c0 fe ff ff       	call   80105880 <argfd.constprop.0>
801059c0:	85 c0                	test   %eax,%eax
801059c2:	78 54                	js     80105a18 <sys_write+0x68>
801059c4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801059c7:	89 44 24 04          	mov    %eax,0x4(%esp)
801059cb:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801059d2:	e8 99 fb ff ff       	call   80105570 <argint>
801059d7:	85 c0                	test   %eax,%eax
801059d9:	78 3d                	js     80105a18 <sys_write+0x68>
801059db:	8b 45 f0             	mov    -0x10(%ebp),%eax
801059de:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801059e5:	89 44 24 08          	mov    %eax,0x8(%esp)
801059e9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801059ec:	89 44 24 04          	mov    %eax,0x4(%esp)
801059f0:	e8 cb fb ff ff       	call   801055c0 <argptr>
801059f5:	85 c0                	test   %eax,%eax
801059f7:	78 1f                	js     80105a18 <sys_write+0x68>
  return filewrite(f, p, n);
801059f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801059fc:	89 44 24 08          	mov    %eax,0x8(%esp)
80105a00:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a03:	89 44 24 04          	mov    %eax,0x4(%esp)
80105a07:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105a0a:	89 04 24             	mov    %eax,(%esp)
80105a0d:	e8 fe b5 ff ff       	call   80101010 <filewrite>
}
80105a12:	c9                   	leave  
80105a13:	c3                   	ret    
80105a14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105a18:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a1d:	c9                   	leave  
80105a1e:	c3                   	ret    
80105a1f:	90                   	nop

80105a20 <sys_close>:
{
80105a20:	55                   	push   %ebp
80105a21:	89 e5                	mov    %esp,%ebp
80105a23:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, &fd, &f) < 0)
80105a26:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105a29:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a2c:	e8 4f fe ff ff       	call   80105880 <argfd.constprop.0>
80105a31:	85 c0                	test   %eax,%eax
80105a33:	78 23                	js     80105a58 <sys_close+0x38>
  myproc()->ofile[fd] = 0;
80105a35:	e8 36 df ff ff       	call   80103970 <myproc>
80105a3a:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105a3d:	31 c9                	xor    %ecx,%ecx
80105a3f:	89 4c 90 28          	mov    %ecx,0x28(%eax,%edx,4)
  fileclose(f);
80105a43:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a46:	89 04 24             	mov    %eax,(%esp)
80105a49:	e8 e2 b3 ff ff       	call   80100e30 <fileclose>
  return 0;
80105a4e:	31 c0                	xor    %eax,%eax
}
80105a50:	c9                   	leave  
80105a51:	c3                   	ret    
80105a52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105a58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a5d:	c9                   	leave  
80105a5e:	c3                   	ret    
80105a5f:	90                   	nop

80105a60 <sys_fstat>:
{
80105a60:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105a61:	31 c0                	xor    %eax,%eax
{
80105a63:	89 e5                	mov    %esp,%ebp
80105a65:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105a68:	8d 55 f0             	lea    -0x10(%ebp),%edx
80105a6b:	e8 10 fe ff ff       	call   80105880 <argfd.constprop.0>
80105a70:	85 c0                	test   %eax,%eax
80105a72:	78 3c                	js     80105ab0 <sys_fstat+0x50>
80105a74:	b8 14 00 00 00       	mov    $0x14,%eax
80105a79:	89 44 24 08          	mov    %eax,0x8(%esp)
80105a7d:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a80:	89 44 24 04          	mov    %eax,0x4(%esp)
80105a84:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105a8b:	e8 30 fb ff ff       	call   801055c0 <argptr>
80105a90:	85 c0                	test   %eax,%eax
80105a92:	78 1c                	js     80105ab0 <sys_fstat+0x50>
  return filestat(f, st);
80105a94:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a97:	89 44 24 04          	mov    %eax,0x4(%esp)
80105a9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a9e:	89 04 24             	mov    %eax,(%esp)
80105aa1:	e8 6a b4 ff ff       	call   80100f10 <filestat>
}
80105aa6:	c9                   	leave  
80105aa7:	c3                   	ret    
80105aa8:	90                   	nop
80105aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105ab0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ab5:	c9                   	leave  
80105ab6:	c3                   	ret    
80105ab7:	89 f6                	mov    %esi,%esi
80105ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ac0 <sys_link>:
{
80105ac0:	55                   	push   %ebp
80105ac1:	89 e5                	mov    %esp,%ebp
80105ac3:	57                   	push   %edi
80105ac4:	56                   	push   %esi
80105ac5:	53                   	push   %ebx
80105ac6:	83 ec 3c             	sub    $0x3c,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105ac9:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80105acc:	89 44 24 04          	mov    %eax,0x4(%esp)
80105ad0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105ad7:	e8 44 fb ff ff       	call   80105620 <argstr>
80105adc:	85 c0                	test   %eax,%eax
80105ade:	0f 88 e5 00 00 00    	js     80105bc9 <sys_link+0x109>
80105ae4:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105ae7:	89 44 24 04          	mov    %eax,0x4(%esp)
80105aeb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105af2:	e8 29 fb ff ff       	call   80105620 <argstr>
80105af7:	85 c0                	test   %eax,%eax
80105af9:	0f 88 ca 00 00 00    	js     80105bc9 <sys_link+0x109>
  begin_op();
80105aff:	e8 8c d1 ff ff       	call   80102c90 <begin_op>
  if((ip = namei(old)) == 0){
80105b04:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80105b07:	89 04 24             	mov    %eax,(%esp)
80105b0a:	e8 c1 c4 ff ff       	call   80101fd0 <namei>
80105b0f:	85 c0                	test   %eax,%eax
80105b11:	89 c3                	mov    %eax,%ebx
80105b13:	0f 84 ab 00 00 00    	je     80105bc4 <sys_link+0x104>
  ilock(ip);
80105b19:	89 04 24             	mov    %eax,(%esp)
80105b1c:	e8 cf bb ff ff       	call   801016f0 <ilock>
  if(ip->type == T_DIR){
80105b21:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105b26:	0f 84 90 00 00 00    	je     80105bbc <sys_link+0xfc>
  ip->nlink++;
80105b2c:	66 ff 43 56          	incw   0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105b30:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105b33:	89 1c 24             	mov    %ebx,(%esp)
80105b36:	e8 f5 ba ff ff       	call   80101630 <iupdate>
  iunlock(ip);
80105b3b:	89 1c 24             	mov    %ebx,(%esp)
80105b3e:	e8 8d bc ff ff       	call   801017d0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105b43:	8b 45 d0             	mov    -0x30(%ebp),%eax
80105b46:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105b4a:	89 04 24             	mov    %eax,(%esp)
80105b4d:	e8 9e c4 ff ff       	call   80101ff0 <nameiparent>
80105b52:	85 c0                	test   %eax,%eax
80105b54:	89 c6                	mov    %eax,%esi
80105b56:	74 50                	je     80105ba8 <sys_link+0xe8>
  ilock(dp);
80105b58:	89 04 24             	mov    %eax,(%esp)
80105b5b:	e8 90 bb ff ff       	call   801016f0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105b60:	8b 03                	mov    (%ebx),%eax
80105b62:	39 06                	cmp    %eax,(%esi)
80105b64:	75 3a                	jne    80105ba0 <sys_link+0xe0>
80105b66:	8b 43 04             	mov    0x4(%ebx),%eax
80105b69:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105b6d:	89 34 24             	mov    %esi,(%esp)
80105b70:	89 44 24 08          	mov    %eax,0x8(%esp)
80105b74:	e8 77 c3 ff ff       	call   80101ef0 <dirlink>
80105b79:	85 c0                	test   %eax,%eax
80105b7b:	78 23                	js     80105ba0 <sys_link+0xe0>
  iunlockput(dp);
80105b7d:	89 34 24             	mov    %esi,(%esp)
80105b80:	e8 fb bd ff ff       	call   80101980 <iunlockput>
  iput(ip);
80105b85:	89 1c 24             	mov    %ebx,(%esp)
80105b88:	e8 93 bc ff ff       	call   80101820 <iput>
  end_op();
80105b8d:	e8 6e d1 ff ff       	call   80102d00 <end_op>
}
80105b92:	83 c4 3c             	add    $0x3c,%esp
  return 0;
80105b95:	31 c0                	xor    %eax,%eax
}
80105b97:	5b                   	pop    %ebx
80105b98:	5e                   	pop    %esi
80105b99:	5f                   	pop    %edi
80105b9a:	5d                   	pop    %ebp
80105b9b:	c3                   	ret    
80105b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(dp);
80105ba0:	89 34 24             	mov    %esi,(%esp)
80105ba3:	e8 d8 bd ff ff       	call   80101980 <iunlockput>
  ilock(ip);
80105ba8:	89 1c 24             	mov    %ebx,(%esp)
80105bab:	e8 40 bb ff ff       	call   801016f0 <ilock>
  ip->nlink--;
80105bb0:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
80105bb4:	89 1c 24             	mov    %ebx,(%esp)
80105bb7:	e8 74 ba ff ff       	call   80101630 <iupdate>
  iunlockput(ip);
80105bbc:	89 1c 24             	mov    %ebx,(%esp)
80105bbf:	e8 bc bd ff ff       	call   80101980 <iunlockput>
  end_op();
80105bc4:	e8 37 d1 ff ff       	call   80102d00 <end_op>
}
80105bc9:	83 c4 3c             	add    $0x3c,%esp
  return -1;
80105bcc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105bd1:	5b                   	pop    %ebx
80105bd2:	5e                   	pop    %esi
80105bd3:	5f                   	pop    %edi
80105bd4:	5d                   	pop    %ebp
80105bd5:	c3                   	ret    
80105bd6:	8d 76 00             	lea    0x0(%esi),%esi
80105bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105be0 <sys_unlink>:
{
80105be0:	55                   	push   %ebp
80105be1:	89 e5                	mov    %esp,%ebp
80105be3:	57                   	push   %edi
80105be4:	56                   	push   %esi
80105be5:	53                   	push   %ebx
80105be6:	83 ec 5c             	sub    $0x5c,%esp
  if(argstr(0, &path) < 0)
80105be9:	8d 45 c0             	lea    -0x40(%ebp),%eax
80105bec:	89 44 24 04          	mov    %eax,0x4(%esp)
80105bf0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105bf7:	e8 24 fa ff ff       	call   80105620 <argstr>
80105bfc:	85 c0                	test   %eax,%eax
80105bfe:	0f 88 68 01 00 00    	js     80105d6c <sys_unlink+0x18c>
  begin_op();
80105c04:	e8 87 d0 ff ff       	call   80102c90 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105c09:	8b 45 c0             	mov    -0x40(%ebp),%eax
80105c0c:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105c0f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80105c13:	89 04 24             	mov    %eax,(%esp)
80105c16:	e8 d5 c3 ff ff       	call   80101ff0 <nameiparent>
80105c1b:	85 c0                	test   %eax,%eax
80105c1d:	89 c6                	mov    %eax,%esi
80105c1f:	0f 84 42 01 00 00    	je     80105d67 <sys_unlink+0x187>
  ilock(dp);
80105c25:	89 04 24             	mov    %eax,(%esp)
80105c28:	e8 c3 ba ff ff       	call   801016f0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105c2d:	b8 b4 84 10 80       	mov    $0x801084b4,%eax
80105c32:	89 44 24 04          	mov    %eax,0x4(%esp)
80105c36:	89 1c 24             	mov    %ebx,(%esp)
80105c39:	e8 02 c0 ff ff       	call   80101c40 <namecmp>
80105c3e:	85 c0                	test   %eax,%eax
80105c40:	0f 84 19 01 00 00    	je     80105d5f <sys_unlink+0x17f>
80105c46:	b8 b3 84 10 80       	mov    $0x801084b3,%eax
80105c4b:	89 44 24 04          	mov    %eax,0x4(%esp)
80105c4f:	89 1c 24             	mov    %ebx,(%esp)
80105c52:	e8 e9 bf ff ff       	call   80101c40 <namecmp>
80105c57:	85 c0                	test   %eax,%eax
80105c59:	0f 84 00 01 00 00    	je     80105d5f <sys_unlink+0x17f>
  if((ip = dirlookup(dp, name, &off)) == 0)
80105c5f:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105c62:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80105c66:	89 44 24 08          	mov    %eax,0x8(%esp)
80105c6a:	89 34 24             	mov    %esi,(%esp)
80105c6d:	e8 fe bf ff ff       	call   80101c70 <dirlookup>
80105c72:	85 c0                	test   %eax,%eax
80105c74:	89 c3                	mov    %eax,%ebx
80105c76:	0f 84 e3 00 00 00    	je     80105d5f <sys_unlink+0x17f>
  ilock(ip);
80105c7c:	89 04 24             	mov    %eax,(%esp)
80105c7f:	e8 6c ba ff ff       	call   801016f0 <ilock>
  if(ip->nlink < 1)
80105c84:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105c89:	0f 8e 0e 01 00 00    	jle    80105d9d <sys_unlink+0x1bd>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105c8f:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105c94:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105c97:	74 77                	je     80105d10 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
80105c99:	31 d2                	xor    %edx,%edx
80105c9b:	b8 10 00 00 00       	mov    $0x10,%eax
80105ca0:	89 54 24 04          	mov    %edx,0x4(%esp)
80105ca4:	89 44 24 08          	mov    %eax,0x8(%esp)
80105ca8:	89 3c 24             	mov    %edi,(%esp)
80105cab:	e8 d0 f5 ff ff       	call   80105280 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105cb0:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80105cb3:	b9 10 00 00 00       	mov    $0x10,%ecx
80105cb8:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80105cbc:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105cc0:	89 34 24             	mov    %esi,(%esp)
80105cc3:	89 44 24 08          	mov    %eax,0x8(%esp)
80105cc7:	e8 24 be ff ff       	call   80101af0 <writei>
80105ccc:	83 f8 10             	cmp    $0x10,%eax
80105ccf:	0f 85 d4 00 00 00    	jne    80105da9 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
80105cd5:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105cda:	0f 84 a0 00 00 00    	je     80105d80 <sys_unlink+0x1a0>
  iunlockput(dp);
80105ce0:	89 34 24             	mov    %esi,(%esp)
80105ce3:	e8 98 bc ff ff       	call   80101980 <iunlockput>
  ip->nlink--;
80105ce8:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
80105cec:	89 1c 24             	mov    %ebx,(%esp)
80105cef:	e8 3c b9 ff ff       	call   80101630 <iupdate>
  iunlockput(ip);
80105cf4:	89 1c 24             	mov    %ebx,(%esp)
80105cf7:	e8 84 bc ff ff       	call   80101980 <iunlockput>
  end_op();
80105cfc:	e8 ff cf ff ff       	call   80102d00 <end_op>
}
80105d01:	83 c4 5c             	add    $0x5c,%esp
  return 0;
80105d04:	31 c0                	xor    %eax,%eax
}
80105d06:	5b                   	pop    %ebx
80105d07:	5e                   	pop    %esi
80105d08:	5f                   	pop    %edi
80105d09:	5d                   	pop    %ebp
80105d0a:	c3                   	ret    
80105d0b:	90                   	nop
80105d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105d10:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105d14:	76 83                	jbe    80105c99 <sys_unlink+0xb9>
80105d16:	ba 20 00 00 00       	mov    $0x20,%edx
80105d1b:	eb 0f                	jmp    80105d2c <sys_unlink+0x14c>
80105d1d:	8d 76 00             	lea    0x0(%esi),%esi
80105d20:	83 c2 10             	add    $0x10,%edx
80105d23:	3b 53 58             	cmp    0x58(%ebx),%edx
80105d26:	0f 83 6d ff ff ff    	jae    80105c99 <sys_unlink+0xb9>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105d2c:	b8 10 00 00 00       	mov    $0x10,%eax
80105d31:	89 54 24 08          	mov    %edx,0x8(%esp)
80105d35:	89 44 24 0c          	mov    %eax,0xc(%esp)
80105d39:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105d3d:	89 1c 24             	mov    %ebx,(%esp)
80105d40:	89 55 b4             	mov    %edx,-0x4c(%ebp)
80105d43:	e8 88 bc ff ff       	call   801019d0 <readi>
80105d48:	8b 55 b4             	mov    -0x4c(%ebp),%edx
80105d4b:	83 f8 10             	cmp    $0x10,%eax
80105d4e:	75 41                	jne    80105d91 <sys_unlink+0x1b1>
    if(de.inum != 0)
80105d50:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105d55:	74 c9                	je     80105d20 <sys_unlink+0x140>
    iunlockput(ip);
80105d57:	89 1c 24             	mov    %ebx,(%esp)
80105d5a:	e8 21 bc ff ff       	call   80101980 <iunlockput>
  iunlockput(dp);
80105d5f:	89 34 24             	mov    %esi,(%esp)
80105d62:	e8 19 bc ff ff       	call   80101980 <iunlockput>
  end_op();
80105d67:	e8 94 cf ff ff       	call   80102d00 <end_op>
}
80105d6c:	83 c4 5c             	add    $0x5c,%esp
  return -1;
80105d6f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d74:	5b                   	pop    %ebx
80105d75:	5e                   	pop    %esi
80105d76:	5f                   	pop    %edi
80105d77:	5d                   	pop    %ebp
80105d78:	c3                   	ret    
80105d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80105d80:	66 ff 4e 56          	decw   0x56(%esi)
    iupdate(dp);
80105d84:	89 34 24             	mov    %esi,(%esp)
80105d87:	e8 a4 b8 ff ff       	call   80101630 <iupdate>
80105d8c:	e9 4f ff ff ff       	jmp    80105ce0 <sys_unlink+0x100>
      panic("isdirempty: readi");
80105d91:	c7 04 24 d8 84 10 80 	movl   $0x801084d8,(%esp)
80105d98:	e8 d3 a5 ff ff       	call   80100370 <panic>
    panic("unlink: nlink < 1");
80105d9d:	c7 04 24 c6 84 10 80 	movl   $0x801084c6,(%esp)
80105da4:	e8 c7 a5 ff ff       	call   80100370 <panic>
    panic("unlink: writei");
80105da9:	c7 04 24 ea 84 10 80 	movl   $0x801084ea,(%esp)
80105db0:	e8 bb a5 ff ff       	call   80100370 <panic>
80105db5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105dc0 <sys_open>:

int
sys_open(void)
{
80105dc0:	55                   	push   %ebp
80105dc1:	89 e5                	mov    %esp,%ebp
80105dc3:	57                   	push   %edi
80105dc4:	56                   	push   %esi
80105dc5:	53                   	push   %ebx
80105dc6:	83 ec 2c             	sub    $0x2c,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105dc9:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105dcc:	89 44 24 04          	mov    %eax,0x4(%esp)
80105dd0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105dd7:	e8 44 f8 ff ff       	call   80105620 <argstr>
80105ddc:	85 c0                	test   %eax,%eax
80105dde:	0f 88 e9 00 00 00    	js     80105ecd <sys_open+0x10d>
80105de4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105de7:	89 44 24 04          	mov    %eax,0x4(%esp)
80105deb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105df2:	e8 79 f7 ff ff       	call   80105570 <argint>
80105df7:	85 c0                	test   %eax,%eax
80105df9:	0f 88 ce 00 00 00    	js     80105ecd <sys_open+0x10d>
    return -1;

  begin_op();
80105dff:	e8 8c ce ff ff       	call   80102c90 <begin_op>

  if(omode & O_CREATE){
80105e04:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105e08:	0f 85 9a 00 00 00    	jne    80105ea8 <sys_open+0xe8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105e0e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105e11:	89 04 24             	mov    %eax,(%esp)
80105e14:	e8 b7 c1 ff ff       	call   80101fd0 <namei>
80105e19:	85 c0                	test   %eax,%eax
80105e1b:	89 c6                	mov    %eax,%esi
80105e1d:	0f 84 a5 00 00 00    	je     80105ec8 <sys_open+0x108>
      end_op();
      return -1;
    }
    ilock(ip);
80105e23:	89 04 24             	mov    %eax,(%esp)
80105e26:	e8 c5 b8 ff ff       	call   801016f0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105e2b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105e30:	0f 84 a2 00 00 00    	je     80105ed8 <sys_open+0x118>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105e36:	e8 35 af ff ff       	call   80100d70 <filealloc>
80105e3b:	85 c0                	test   %eax,%eax
80105e3d:	89 c7                	mov    %eax,%edi
80105e3f:	0f 84 9e 00 00 00    	je     80105ee3 <sys_open+0x123>
  struct proc *curproc = myproc();
80105e45:	e8 26 db ff ff       	call   80103970 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105e4a:	31 db                	xor    %ebx,%ebx
80105e4c:	eb 0c                	jmp    80105e5a <sys_open+0x9a>
80105e4e:	66 90                	xchg   %ax,%ax
80105e50:	43                   	inc    %ebx
80105e51:	83 fb 10             	cmp    $0x10,%ebx
80105e54:	0f 84 96 00 00 00    	je     80105ef0 <sys_open+0x130>
    if(curproc->ofile[fd] == 0){
80105e5a:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105e5e:	85 d2                	test   %edx,%edx
80105e60:	75 ee                	jne    80105e50 <sys_open+0x90>
      curproc->ofile[fd] = f;
80105e62:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105e66:	89 34 24             	mov    %esi,(%esp)
80105e69:	e8 62 b9 ff ff       	call   801017d0 <iunlock>
  end_op();
80105e6e:	e8 8d ce ff ff       	call   80102d00 <end_op>

  f->type = FD_INODE;
80105e73:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105e79:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->ip = ip;
80105e7c:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105e7f:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105e86:	89 d0                	mov    %edx,%eax
80105e88:	f7 d0                	not    %eax
80105e8a:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105e8d:	f6 c2 03             	test   $0x3,%dl
  f->readable = !(omode & O_WRONLY);
80105e90:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105e93:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105e97:	83 c4 2c             	add    $0x2c,%esp
80105e9a:	89 d8                	mov    %ebx,%eax
80105e9c:	5b                   	pop    %ebx
80105e9d:	5e                   	pop    %esi
80105e9e:	5f                   	pop    %edi
80105e9f:	5d                   	pop    %ebp
80105ea0:	c3                   	ret    
80105ea1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105ea8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105eab:	31 c9                	xor    %ecx,%ecx
80105ead:	ba 02 00 00 00       	mov    $0x2,%edx
80105eb2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105eb9:	e8 12 f8 ff ff       	call   801056d0 <create>
    if(ip == 0){
80105ebe:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105ec0:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105ec2:	0f 85 6e ff ff ff    	jne    80105e36 <sys_open+0x76>
    end_op();
80105ec8:	e8 33 ce ff ff       	call   80102d00 <end_op>
    return -1;
80105ecd:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105ed2:	eb c3                	jmp    80105e97 <sys_open+0xd7>
80105ed4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105ed8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105edb:	85 c9                	test   %ecx,%ecx
80105edd:	0f 84 53 ff ff ff    	je     80105e36 <sys_open+0x76>
    iunlockput(ip);
80105ee3:	89 34 24             	mov    %esi,(%esp)
80105ee6:	e8 95 ba ff ff       	call   80101980 <iunlockput>
80105eeb:	eb db                	jmp    80105ec8 <sys_open+0x108>
80105eed:	8d 76 00             	lea    0x0(%esi),%esi
      fileclose(f);
80105ef0:	89 3c 24             	mov    %edi,(%esp)
80105ef3:	e8 38 af ff ff       	call   80100e30 <fileclose>
80105ef8:	eb e9                	jmp    80105ee3 <sys_open+0x123>
80105efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105f00 <sys_mkdir>:

int
sys_mkdir(void)
{
80105f00:	55                   	push   %ebp
80105f01:	89 e5                	mov    %esp,%ebp
80105f03:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105f06:	e8 85 cd ff ff       	call   80102c90 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105f0b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f0e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f12:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105f19:	e8 02 f7 ff ff       	call   80105620 <argstr>
80105f1e:	85 c0                	test   %eax,%eax
80105f20:	78 2e                	js     80105f50 <sys_mkdir+0x50>
80105f22:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f25:	31 c9                	xor    %ecx,%ecx
80105f27:	ba 01 00 00 00       	mov    $0x1,%edx
80105f2c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105f33:	e8 98 f7 ff ff       	call   801056d0 <create>
80105f38:	85 c0                	test   %eax,%eax
80105f3a:	74 14                	je     80105f50 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105f3c:	89 04 24             	mov    %eax,(%esp)
80105f3f:	e8 3c ba ff ff       	call   80101980 <iunlockput>
  end_op();
80105f44:	e8 b7 cd ff ff       	call   80102d00 <end_op>
  return 0;
80105f49:	31 c0                	xor    %eax,%eax
}
80105f4b:	c9                   	leave  
80105f4c:	c3                   	ret    
80105f4d:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
80105f50:	e8 ab cd ff ff       	call   80102d00 <end_op>
    return -1;
80105f55:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f5a:	c9                   	leave  
80105f5b:	c3                   	ret    
80105f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105f60 <sys_mknod>:

int
sys_mknod(void)
{
80105f60:	55                   	push   %ebp
80105f61:	89 e5                	mov    %esp,%ebp
80105f63:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105f66:	e8 25 cd ff ff       	call   80102c90 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105f6b:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105f6e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f72:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105f79:	e8 a2 f6 ff ff       	call   80105620 <argstr>
80105f7e:	85 c0                	test   %eax,%eax
80105f80:	78 5e                	js     80105fe0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105f82:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105f85:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f89:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105f90:	e8 db f5 ff ff       	call   80105570 <argint>
  if((argstr(0, &path)) < 0 ||
80105f95:	85 c0                	test   %eax,%eax
80105f97:	78 47                	js     80105fe0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105f99:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f9c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105fa0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80105fa7:	e8 c4 f5 ff ff       	call   80105570 <argint>
     argint(1, &major) < 0 ||
80105fac:	85 c0                	test   %eax,%eax
80105fae:	78 30                	js     80105fe0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105fb0:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
80105fb4:	ba 03 00 00 00       	mov    $0x3,%edx
     (ip = create(path, T_DEV, major, minor)) == 0){
80105fb9:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105fbd:	89 04 24             	mov    %eax,(%esp)
     argint(2, &minor) < 0 ||
80105fc0:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105fc3:	e8 08 f7 ff ff       	call   801056d0 <create>
80105fc8:	85 c0                	test   %eax,%eax
80105fca:	74 14                	je     80105fe0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105fcc:	89 04 24             	mov    %eax,(%esp)
80105fcf:	e8 ac b9 ff ff       	call   80101980 <iunlockput>
  end_op();
80105fd4:	e8 27 cd ff ff       	call   80102d00 <end_op>
  return 0;
80105fd9:	31 c0                	xor    %eax,%eax
}
80105fdb:	c9                   	leave  
80105fdc:	c3                   	ret    
80105fdd:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
80105fe0:	e8 1b cd ff ff       	call   80102d00 <end_op>
    return -1;
80105fe5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105fea:	c9                   	leave  
80105feb:	c3                   	ret    
80105fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ff0 <sys_chdir>:

int
sys_chdir(void)
{
80105ff0:	55                   	push   %ebp
80105ff1:	89 e5                	mov    %esp,%ebp
80105ff3:	56                   	push   %esi
80105ff4:	53                   	push   %ebx
80105ff5:	83 ec 20             	sub    $0x20,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105ff8:	e8 73 d9 ff ff       	call   80103970 <myproc>
80105ffd:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105fff:	e8 8c cc ff ff       	call   80102c90 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106004:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106007:	89 44 24 04          	mov    %eax,0x4(%esp)
8010600b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106012:	e8 09 f6 ff ff       	call   80105620 <argstr>
80106017:	85 c0                	test   %eax,%eax
80106019:	78 4a                	js     80106065 <sys_chdir+0x75>
8010601b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010601e:	89 04 24             	mov    %eax,(%esp)
80106021:	e8 aa bf ff ff       	call   80101fd0 <namei>
80106026:	85 c0                	test   %eax,%eax
80106028:	89 c3                	mov    %eax,%ebx
8010602a:	74 39                	je     80106065 <sys_chdir+0x75>
    end_op();
    return -1;
  }
  ilock(ip);
8010602c:	89 04 24             	mov    %eax,(%esp)
8010602f:	e8 bc b6 ff ff       	call   801016f0 <ilock>
  if(ip->type != T_DIR){
80106034:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
    iunlockput(ip);
80106039:	89 1c 24             	mov    %ebx,(%esp)
  if(ip->type != T_DIR){
8010603c:	75 22                	jne    80106060 <sys_chdir+0x70>
    end_op();
    return -1;
  }
  iunlock(ip);
8010603e:	e8 8d b7 ff ff       	call   801017d0 <iunlock>
  iput(curproc->cwd);
80106043:	8b 46 68             	mov    0x68(%esi),%eax
80106046:	89 04 24             	mov    %eax,(%esp)
80106049:	e8 d2 b7 ff ff       	call   80101820 <iput>
  end_op();
8010604e:	e8 ad cc ff ff       	call   80102d00 <end_op>
  curproc->cwd = ip;
  return 0;
80106053:	31 c0                	xor    %eax,%eax
  curproc->cwd = ip;
80106055:	89 5e 68             	mov    %ebx,0x68(%esi)
}
80106058:	83 c4 20             	add    $0x20,%esp
8010605b:	5b                   	pop    %ebx
8010605c:	5e                   	pop    %esi
8010605d:	5d                   	pop    %ebp
8010605e:	c3                   	ret    
8010605f:	90                   	nop
    iunlockput(ip);
80106060:	e8 1b b9 ff ff       	call   80101980 <iunlockput>
    end_op();
80106065:	e8 96 cc ff ff       	call   80102d00 <end_op>
    return -1;
8010606a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010606f:	eb e7                	jmp    80106058 <sys_chdir+0x68>
80106071:	eb 0d                	jmp    80106080 <sys_exec>
80106073:	90                   	nop
80106074:	90                   	nop
80106075:	90                   	nop
80106076:	90                   	nop
80106077:	90                   	nop
80106078:	90                   	nop
80106079:	90                   	nop
8010607a:	90                   	nop
8010607b:	90                   	nop
8010607c:	90                   	nop
8010607d:	90                   	nop
8010607e:	90                   	nop
8010607f:	90                   	nop

80106080 <sys_exec>:

int
sys_exec(void)
{
80106080:	55                   	push   %ebp
80106081:	89 e5                	mov    %esp,%ebp
80106083:	57                   	push   %edi
80106084:	56                   	push   %esi
80106085:	53                   	push   %ebx
80106086:	81 ec ac 00 00 00    	sub    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
8010608c:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80106092:	89 44 24 04          	mov    %eax,0x4(%esp)
80106096:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010609d:	e8 7e f5 ff ff       	call   80105620 <argstr>
801060a2:	85 c0                	test   %eax,%eax
801060a4:	0f 88 8e 00 00 00    	js     80106138 <sys_exec+0xb8>
801060aa:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801060b0:	89 44 24 04          	mov    %eax,0x4(%esp)
801060b4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801060bb:	e8 b0 f4 ff ff       	call   80105570 <argint>
801060c0:	85 c0                	test   %eax,%eax
801060c2:	78 74                	js     80106138 <sys_exec+0xb8>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801060c4:	ba 80 00 00 00       	mov    $0x80,%edx
801060c9:	31 c9                	xor    %ecx,%ecx
801060cb:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
801060d1:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801060d3:	89 54 24 08          	mov    %edx,0x8(%esp)
801060d7:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801060dd:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801060e1:	89 04 24             	mov    %eax,(%esp)
801060e4:	e8 97 f1 ff ff       	call   80105280 <memset>
801060e9:	eb 2e                	jmp    80106119 <sys_exec+0x99>
801060eb:	90                   	nop
801060ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
801060f0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801060f6:	85 c0                	test   %eax,%eax
801060f8:	74 56                	je     80106150 <sys_exec+0xd0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801060fa:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80106100:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80106103:	89 54 24 04          	mov    %edx,0x4(%esp)
80106107:	89 04 24             	mov    %eax,(%esp)
8010610a:	e8 01 f4 ff ff       	call   80105510 <fetchstr>
8010610f:	85 c0                	test   %eax,%eax
80106111:	78 25                	js     80106138 <sys_exec+0xb8>
  for(i=0;; i++){
80106113:	43                   	inc    %ebx
    if(i >= NELEM(argv))
80106114:	83 fb 20             	cmp    $0x20,%ebx
80106117:	74 1f                	je     80106138 <sys_exec+0xb8>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106119:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
8010611f:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80106126:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010612a:	01 f0                	add    %esi,%eax
8010612c:	89 04 24             	mov    %eax,(%esp)
8010612f:	e8 9c f3 ff ff       	call   801054d0 <fetchint>
80106134:	85 c0                	test   %eax,%eax
80106136:	79 b8                	jns    801060f0 <sys_exec+0x70>
      return -1;
  }
  return exec(path, argv);
}
80106138:	81 c4 ac 00 00 00    	add    $0xac,%esp
    return -1;
8010613e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106143:	5b                   	pop    %ebx
80106144:	5e                   	pop    %esi
80106145:	5f                   	pop    %edi
80106146:	5d                   	pop    %ebp
80106147:	c3                   	ret    
80106148:	90                   	nop
80106149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80106150:	31 c0                	xor    %eax,%eax
80106152:	89 84 9d 68 ff ff ff 	mov    %eax,-0x98(%ebp,%ebx,4)
  return exec(path, argv);
80106159:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010615f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106163:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
80106169:	89 04 24             	mov    %eax,(%esp)
8010616c:	e8 5f a8 ff ff       	call   801009d0 <exec>
}
80106171:	81 c4 ac 00 00 00    	add    $0xac,%esp
80106177:	5b                   	pop    %ebx
80106178:	5e                   	pop    %esi
80106179:	5f                   	pop    %edi
8010617a:	5d                   	pop    %ebp
8010617b:	c3                   	ret    
8010617c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106180 <sys_pipe>:

int
sys_pipe(void)
{
80106180:	55                   	push   %ebp
80106181:	89 e5                	mov    %esp,%ebp
80106183:	57                   	push   %edi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106184:	bf 08 00 00 00       	mov    $0x8,%edi
{
80106189:	56                   	push   %esi
8010618a:	53                   	push   %ebx
8010618b:	83 ec 2c             	sub    $0x2c,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010618e:	8d 45 dc             	lea    -0x24(%ebp),%eax
80106191:	89 7c 24 08          	mov    %edi,0x8(%esp)
80106195:	89 44 24 04          	mov    %eax,0x4(%esp)
80106199:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801061a0:	e8 1b f4 ff ff       	call   801055c0 <argptr>
801061a5:	85 c0                	test   %eax,%eax
801061a7:	0f 88 a9 00 00 00    	js     80106256 <sys_pipe+0xd6>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801061ad:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801061b0:	89 44 24 04          	mov    %eax,0x4(%esp)
801061b4:	8d 45 e0             	lea    -0x20(%ebp),%eax
801061b7:	89 04 24             	mov    %eax,(%esp)
801061ba:	e8 01 d2 ff ff       	call   801033c0 <pipealloc>
801061bf:	85 c0                	test   %eax,%eax
801061c1:	0f 88 8f 00 00 00    	js     80106256 <sys_pipe+0xd6>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801061c7:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801061ca:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801061cc:	e8 9f d7 ff ff       	call   80103970 <myproc>
801061d1:	eb 0b                	jmp    801061de <sys_pipe+0x5e>
801061d3:	90                   	nop
801061d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
801061d8:	43                   	inc    %ebx
801061d9:	83 fb 10             	cmp    $0x10,%ebx
801061dc:	74 62                	je     80106240 <sys_pipe+0xc0>
    if(curproc->ofile[fd] == 0){
801061de:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801061e2:	85 f6                	test   %esi,%esi
801061e4:	75 f2                	jne    801061d8 <sys_pipe+0x58>
      curproc->ofile[fd] = f;
801061e6:	8d 73 08             	lea    0x8(%ebx),%esi
801061e9:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801061ed:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801061f0:	e8 7b d7 ff ff       	call   80103970 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801061f5:	31 d2                	xor    %edx,%edx
801061f7:	eb 0d                	jmp    80106206 <sys_pipe+0x86>
801061f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106200:	42                   	inc    %edx
80106201:	83 fa 10             	cmp    $0x10,%edx
80106204:	74 2a                	je     80106230 <sys_pipe+0xb0>
    if(curproc->ofile[fd] == 0){
80106206:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
8010620a:	85 c9                	test   %ecx,%ecx
8010620c:	75 f2                	jne    80106200 <sys_pipe+0x80>
      curproc->ofile[fd] = f;
8010620e:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80106212:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106215:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106217:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010621a:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
8010621d:	31 c0                	xor    %eax,%eax
}
8010621f:	83 c4 2c             	add    $0x2c,%esp
80106222:	5b                   	pop    %ebx
80106223:	5e                   	pop    %esi
80106224:	5f                   	pop    %edi
80106225:	5d                   	pop    %ebp
80106226:	c3                   	ret    
80106227:	89 f6                	mov    %esi,%esi
80106229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      myproc()->ofile[fd0] = 0;
80106230:	e8 3b d7 ff ff       	call   80103970 <myproc>
80106235:	31 d2                	xor    %edx,%edx
80106237:	89 54 b0 08          	mov    %edx,0x8(%eax,%esi,4)
8010623b:	90                   	nop
8010623c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fileclose(rf);
80106240:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106243:	89 04 24             	mov    %eax,(%esp)
80106246:	e8 e5 ab ff ff       	call   80100e30 <fileclose>
    fileclose(wf);
8010624b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010624e:	89 04 24             	mov    %eax,(%esp)
80106251:	e8 da ab ff ff       	call   80100e30 <fileclose>
    return -1;
80106256:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010625b:	eb c2                	jmp    8010621f <sys_pipe+0x9f>
8010625d:	66 90                	xchg   %ax,%ax
8010625f:	90                   	nop

80106260 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106260:	55                   	push   %ebp
80106261:	89 e5                	mov    %esp,%ebp
  return fork();
}
80106263:	5d                   	pop    %ebp
  return fork();
80106264:	e9 b7 d8 ff ff       	jmp    80103b20 <fork>
80106269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106270 <sys_exit>:

int
sys_exit(void)
{
80106270:	55                   	push   %ebp
80106271:	89 e5                	mov    %esp,%ebp
80106273:	83 ec 08             	sub    $0x8,%esp
  exit();
80106276:	e8 15 db ff ff       	call   80103d90 <exit>
  return 0;  // not reached
}
8010627b:	31 c0                	xor    %eax,%eax
8010627d:	c9                   	leave  
8010627e:	c3                   	ret    
8010627f:	90                   	nop

80106280 <sys_wait>:

int
sys_wait(void)
{
80106280:	55                   	push   %ebp
80106281:	89 e5                	mov    %esp,%ebp
  return wait();
}
80106283:	5d                   	pop    %ebp
  return wait();
80106284:	e9 57 dd ff ff       	jmp    80103fe0 <wait>
80106289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106290 <sys_kill>:

int
sys_kill(void)
{
80106290:	55                   	push   %ebp
80106291:	89 e5                	mov    %esp,%ebp
80106293:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106296:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106299:	89 44 24 04          	mov    %eax,0x4(%esp)
8010629d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801062a4:	e8 c7 f2 ff ff       	call   80105570 <argint>
801062a9:	85 c0                	test   %eax,%eax
801062ab:	78 13                	js     801062c0 <sys_kill+0x30>
    return -1;
  return kill(pid);
801062ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062b0:	89 04 24             	mov    %eax,(%esp)
801062b3:	e8 78 de ff ff       	call   80104130 <kill>
}
801062b8:	c9                   	leave  
801062b9:	c3                   	ret    
801062ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801062c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801062c5:	c9                   	leave  
801062c6:	c3                   	ret    
801062c7:	89 f6                	mov    %esi,%esi
801062c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801062d0 <sys_getpid>:

int
sys_getpid(void)
{
801062d0:	55                   	push   %ebp
801062d1:	89 e5                	mov    %esp,%ebp
801062d3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801062d6:	e8 95 d6 ff ff       	call   80103970 <myproc>
801062db:	8b 40 10             	mov    0x10(%eax),%eax
}
801062de:	c9                   	leave  
801062df:	c3                   	ret    

801062e0 <sys_sbrk>:

int
sys_sbrk(void)
{
801062e0:	55                   	push   %ebp
801062e1:	89 e5                	mov    %esp,%ebp
801062e3:	53                   	push   %ebx
801062e4:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801062e7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801062ea:	89 44 24 04          	mov    %eax,0x4(%esp)
801062ee:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801062f5:	e8 76 f2 ff ff       	call   80105570 <argint>
801062fa:	85 c0                	test   %eax,%eax
801062fc:	78 22                	js     80106320 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801062fe:	e8 6d d6 ff ff       	call   80103970 <myproc>
80106303:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106305:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106308:	89 04 24             	mov    %eax,(%esp)
8010630b:	e8 90 d7 ff ff       	call   80103aa0 <growproc>
80106310:	85 c0                	test   %eax,%eax
80106312:	78 0c                	js     80106320 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106314:	83 c4 24             	add    $0x24,%esp
80106317:	89 d8                	mov    %ebx,%eax
80106319:	5b                   	pop    %ebx
8010631a:	5d                   	pop    %ebp
8010631b:	c3                   	ret    
8010631c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106320:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106325:	eb ed                	jmp    80106314 <sys_sbrk+0x34>
80106327:	89 f6                	mov    %esi,%esi
80106329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106330 <sys_sleep>:

int
sys_sleep(void)
{
80106330:	55                   	push   %ebp
80106331:	89 e5                	mov    %esp,%ebp
80106333:	53                   	push   %ebx
80106334:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106337:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010633a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010633e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106345:	e8 26 f2 ff ff       	call   80105570 <argint>
8010634a:	85 c0                	test   %eax,%eax
8010634c:	78 7e                	js     801063cc <sys_sleep+0x9c>
    return -1;
  acquire(&tickslock);
8010634e:	c7 04 24 c0 5c 11 80 	movl   $0x80115cc0,(%esp)
80106355:	e8 36 ee ff ff       	call   80105190 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010635a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  ticks0 = ticks;
8010635d:	8b 1d 00 65 11 80    	mov    0x80116500,%ebx
  while(ticks - ticks0 < n){
80106363:	85 c9                	test   %ecx,%ecx
80106365:	75 2a                	jne    80106391 <sys_sleep+0x61>
80106367:	eb 4f                	jmp    801063b8 <sys_sleep+0x88>
80106369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106370:	b8 c0 5c 11 80       	mov    $0x80115cc0,%eax
80106375:	89 44 24 04          	mov    %eax,0x4(%esp)
80106379:	c7 04 24 00 65 11 80 	movl   $0x80116500,(%esp)
80106380:	e8 8b db ff ff       	call   80103f10 <sleep>
  while(ticks - ticks0 < n){
80106385:	a1 00 65 11 80       	mov    0x80116500,%eax
8010638a:	29 d8                	sub    %ebx,%eax
8010638c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010638f:	73 27                	jae    801063b8 <sys_sleep+0x88>
    if(myproc()->killed){
80106391:	e8 da d5 ff ff       	call   80103970 <myproc>
80106396:	8b 50 24             	mov    0x24(%eax),%edx
80106399:	85 d2                	test   %edx,%edx
8010639b:	74 d3                	je     80106370 <sys_sleep+0x40>
      release(&tickslock);
8010639d:	c7 04 24 c0 5c 11 80 	movl   $0x80115cc0,(%esp)
801063a4:	e8 87 ee ff ff       	call   80105230 <release>
  }
  release(&tickslock);
  return 0;
}
801063a9:	83 c4 24             	add    $0x24,%esp
      return -1;
801063ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801063b1:	5b                   	pop    %ebx
801063b2:	5d                   	pop    %ebp
801063b3:	c3                   	ret    
801063b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&tickslock);
801063b8:	c7 04 24 c0 5c 11 80 	movl   $0x80115cc0,(%esp)
801063bf:	e8 6c ee ff ff       	call   80105230 <release>
  return 0;
801063c4:	31 c0                	xor    %eax,%eax
}
801063c6:	83 c4 24             	add    $0x24,%esp
801063c9:	5b                   	pop    %ebx
801063ca:	5d                   	pop    %ebp
801063cb:	c3                   	ret    
    return -1;
801063cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063d1:	eb f3                	jmp    801063c6 <sys_sleep+0x96>
801063d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801063d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801063e0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801063e0:	55                   	push   %ebp
801063e1:	89 e5                	mov    %esp,%ebp
801063e3:	53                   	push   %ebx
801063e4:	83 ec 14             	sub    $0x14,%esp
  uint xticks;

  acquire(&tickslock);
801063e7:	c7 04 24 c0 5c 11 80 	movl   $0x80115cc0,(%esp)
801063ee:	e8 9d ed ff ff       	call   80105190 <acquire>
  xticks = ticks;
801063f3:	8b 1d 00 65 11 80    	mov    0x80116500,%ebx
  release(&tickslock);
801063f9:	c7 04 24 c0 5c 11 80 	movl   $0x80115cc0,(%esp)
80106400:	e8 2b ee ff ff       	call   80105230 <release>
  return xticks;
}
80106405:	83 c4 14             	add    $0x14,%esp
80106408:	89 d8                	mov    %ebx,%eax
8010640a:	5b                   	pop    %ebx
8010640b:	5d                   	pop    %ebp
8010640c:	c3                   	ret    

8010640d <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
8010640d:	1e                   	push   %ds
  pushl %es
8010640e:	06                   	push   %es
  pushl %fs
8010640f:	0f a0                	push   %fs
  pushl %gs
80106411:	0f a8                	push   %gs
  pushal
80106413:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106414:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106418:	8e d8                	mov    %eax,%ds
  movw %ax, %es
8010641a:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
8010641c:	54                   	push   %esp
  call trap
8010641d:	e8 be 00 00 00       	call   801064e0 <trap>
  addl $4, %esp
80106422:	83 c4 04             	add    $0x4,%esp

80106425 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106425:	61                   	popa   
  popl %gs
80106426:	0f a9                	pop    %gs
  popl %fs
80106428:	0f a1                	pop    %fs
  popl %es
8010642a:	07                   	pop    %es
  popl %ds
8010642b:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
8010642c:	83 c4 08             	add    $0x8,%esp
  iret
8010642f:	cf                   	iret   

80106430 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106430:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106431:	31 c0                	xor    %eax,%eax
{
80106433:	89 e5                	mov    %esp,%ebp
80106435:	83 ec 18             	sub    $0x18,%esp
80106438:	90                   	nop
80106439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106440:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80106447:	b9 08 00 00 8e       	mov    $0x8e000008,%ecx
8010644c:	89 0c c5 02 5d 11 80 	mov    %ecx,-0x7feea2fe(,%eax,8)
80106453:	66 89 14 c5 00 5d 11 	mov    %dx,-0x7feea300(,%eax,8)
8010645a:	80 
8010645b:	c1 ea 10             	shr    $0x10,%edx
8010645e:	66 89 14 c5 06 5d 11 	mov    %dx,-0x7feea2fa(,%eax,8)
80106465:	80 
  for(i = 0; i < 256; i++)
80106466:	40                   	inc    %eax
80106467:	3d 00 01 00 00       	cmp    $0x100,%eax
8010646c:	75 d2                	jne    80106440 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010646e:	a1 08 b1 10 80       	mov    0x8010b108,%eax

  initlock(&tickslock, "time");
80106473:	b9 f9 84 10 80       	mov    $0x801084f9,%ecx
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106478:	ba 08 00 00 ef       	mov    $0xef000008,%edx
  initlock(&tickslock, "time");
8010647d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80106481:	c7 04 24 c0 5c 11 80 	movl   $0x80115cc0,(%esp)
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106488:	89 15 02 5f 11 80    	mov    %edx,0x80115f02
8010648e:	66 a3 00 5f 11 80    	mov    %ax,0x80115f00
80106494:	c1 e8 10             	shr    $0x10,%eax
80106497:	66 a3 06 5f 11 80    	mov    %ax,0x80115f06
  initlock(&tickslock, "time");
8010649d:	e8 9e eb ff ff       	call   80105040 <initlock>
}
801064a2:	c9                   	leave  
801064a3:	c3                   	ret    
801064a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801064aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801064b0 <idtinit>:

void
idtinit(void)
{
801064b0:	55                   	push   %ebp
  pd[1] = (uint)p;
801064b1:	b8 00 5d 11 80       	mov    $0x80115d00,%eax
801064b6:	89 e5                	mov    %esp,%ebp
801064b8:	0f b7 d0             	movzwl %ax,%edx
  pd[2] = (uint)p >> 16;
801064bb:	c1 e8 10             	shr    $0x10,%eax
801064be:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
801064c1:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
801064c7:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801064cb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801064cf:	8d 45 fa             	lea    -0x6(%ebp),%eax
801064d2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801064d5:	c9                   	leave  
801064d6:	c3                   	ret    
801064d7:	89 f6                	mov    %esi,%esi
801064d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801064e0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801064e0:	55                   	push   %ebp
801064e1:	89 e5                	mov    %esp,%ebp
801064e3:	83 ec 48             	sub    $0x48,%esp
801064e6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801064e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801064ec:	89 75 f8             	mov    %esi,-0x8(%ebp)
801064ef:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(tf->trapno == T_SYSCALL){
801064f2:	8b 43 30             	mov    0x30(%ebx),%eax
801064f5:	83 f8 40             	cmp    $0x40,%eax
801064f8:	0f 84 02 01 00 00    	je     80106600 <trap+0x120>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801064fe:	83 e8 20             	sub    $0x20,%eax
80106501:	83 f8 1f             	cmp    $0x1f,%eax
80106504:	77 0a                	ja     80106510 <trap+0x30>
80106506:	ff 24 85 a0 85 10 80 	jmp    *-0x7fef7a60(,%eax,4)
8010650d:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80106510:	e8 5b d4 ff ff       	call   80103970 <myproc>
80106515:	8b 7b 38             	mov    0x38(%ebx),%edi
80106518:	85 c0                	test   %eax,%eax
8010651a:	0f 84 3f 02 00 00    	je     8010675f <trap+0x27f>
80106520:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106524:	0f 84 35 02 00 00    	je     8010675f <trap+0x27f>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010652a:	0f 20 d1             	mov    %cr2,%ecx
8010652d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106530:	e8 1b d4 ff ff       	call   80103950 <cpuid>
80106535:	8b 73 30             	mov    0x30(%ebx),%esi
80106538:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010653b:	8b 43 34             	mov    0x34(%ebx),%eax
8010653e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106541:	e8 2a d4 ff ff       	call   80103970 <myproc>
80106546:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106549:	e8 22 d4 ff ff       	call   80103970 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010654e:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106551:	89 74 24 0c          	mov    %esi,0xc(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
80106555:	8b 75 e0             	mov    -0x20(%ebp),%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106558:	8b 4d d8             	mov    -0x28(%ebp),%ecx
8010655b:	89 7c 24 18          	mov    %edi,0x18(%esp)
8010655f:	89 54 24 14          	mov    %edx,0x14(%esp)
80106563:	8b 55 e4             	mov    -0x1c(%ebp),%edx
            myproc()->pid, myproc()->name, tf->trapno,
80106566:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106569:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
8010656d:	89 74 24 08          	mov    %esi,0x8(%esp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106571:	89 54 24 10          	mov    %edx,0x10(%esp)
80106575:	8b 40 10             	mov    0x10(%eax),%eax
80106578:	c7 04 24 5c 85 10 80 	movl   $0x8010855c,(%esp)
8010657f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106583:	e8 c8 a0 ff ff       	call   80100650 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80106588:	e8 e3 d3 ff ff       	call   80103970 <myproc>
8010658d:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106594:	e8 d7 d3 ff ff       	call   80103970 <myproc>
80106599:	85 c0                	test   %eax,%eax
8010659b:	74 1b                	je     801065b8 <trap+0xd8>
8010659d:	e8 ce d3 ff ff       	call   80103970 <myproc>
801065a2:	8b 50 24             	mov    0x24(%eax),%edx
801065a5:	85 d2                	test   %edx,%edx
801065a7:	74 0f                	je     801065b8 <trap+0xd8>
801065a9:	8b 43 3c             	mov    0x3c(%ebx),%eax
801065ac:	83 e0 03             	and    $0x3,%eax
801065af:	83 f8 03             	cmp    $0x3,%eax
801065b2:	0f 84 68 01 00 00    	je     80106720 <trap+0x240>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801065b8:	e8 b3 d3 ff ff       	call   80103970 <myproc>
801065bd:	85 c0                	test   %eax,%eax
801065bf:	74 0d                	je     801065ce <trap+0xee>
801065c1:	e8 aa d3 ff ff       	call   80103970 <myproc>
801065c6:	8b 40 0c             	mov    0xc(%eax),%eax
801065c9:	83 f8 04             	cmp    $0x4,%eax
801065cc:	74 72                	je     80106640 <trap+0x160>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801065ce:	e8 9d d3 ff ff       	call   80103970 <myproc>
801065d3:	85 c0                	test   %eax,%eax
801065d5:	74 17                	je     801065ee <trap+0x10e>
801065d7:	e8 94 d3 ff ff       	call   80103970 <myproc>
801065dc:	8b 40 24             	mov    0x24(%eax),%eax
801065df:	85 c0                	test   %eax,%eax
801065e1:	74 0b                	je     801065ee <trap+0x10e>
801065e3:	8b 43 3c             	mov    0x3c(%ebx),%eax
801065e6:	83 e0 03             	and    $0x3,%eax
801065e9:	83 f8 03             	cmp    $0x3,%eax
801065ec:	74 3b                	je     80106629 <trap+0x149>
    exit();
}
801065ee:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801065f1:	8b 75 f8             	mov    -0x8(%ebp),%esi
801065f4:	8b 7d fc             	mov    -0x4(%ebp),%edi
801065f7:	89 ec                	mov    %ebp,%esp
801065f9:	5d                   	pop    %ebp
801065fa:	c3                   	ret    
801065fb:	90                   	nop
801065fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80106600:	e8 6b d3 ff ff       	call   80103970 <myproc>
80106605:	8b 70 24             	mov    0x24(%eax),%esi
80106608:	85 f6                	test   %esi,%esi
8010660a:	0f 85 00 01 00 00    	jne    80106710 <trap+0x230>
    myproc()->tf = tf;
80106610:	e8 5b d3 ff ff       	call   80103970 <myproc>
80106615:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80106618:	e8 43 f0 ff ff       	call   80105660 <syscall>
    if(myproc()->killed)
8010661d:	e8 4e d3 ff ff       	call   80103970 <myproc>
80106622:	8b 48 24             	mov    0x24(%eax),%ecx
80106625:	85 c9                	test   %ecx,%ecx
80106627:	74 c5                	je     801065ee <trap+0x10e>
}
80106629:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010662c:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010662f:	8b 7d fc             	mov    -0x4(%ebp),%edi
80106632:	89 ec                	mov    %ebp,%esp
80106634:	5d                   	pop    %ebp
      exit();
80106635:	e9 56 d7 ff ff       	jmp    80103d90 <exit>
8010663a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80106640:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106644:	75 88                	jne    801065ce <trap+0xee>
    yield();
80106646:	e8 75 d8 ff ff       	call   80103ec0 <yield>
8010664b:	eb 81                	jmp    801065ce <trap+0xee>
8010664d:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80106650:	e8 fb d2 ff ff       	call   80103950 <cpuid>
80106655:	85 c0                	test   %eax,%eax
80106657:	0f 84 d3 00 00 00    	je     80106730 <trap+0x250>
8010665d:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
80106660:	e8 eb c1 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106665:	e8 06 d3 ff ff       	call   80103970 <myproc>
8010666a:	85 c0                	test   %eax,%eax
8010666c:	0f 85 2b ff ff ff    	jne    8010659d <trap+0xbd>
80106672:	e9 41 ff ff ff       	jmp    801065b8 <trap+0xd8>
80106677:	89 f6                	mov    %esi,%esi
80106679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    kbdintr();
80106680:	e8 8b c0 ff ff       	call   80102710 <kbdintr>
    lapiceoi();
80106685:	e8 c6 c1 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010668a:	e8 e1 d2 ff ff       	call   80103970 <myproc>
8010668f:	85 c0                	test   %eax,%eax
80106691:	0f 85 06 ff ff ff    	jne    8010659d <trap+0xbd>
80106697:	e9 1c ff ff ff       	jmp    801065b8 <trap+0xd8>
8010669c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
801066a0:	e8 5b 02 00 00       	call   80106900 <uartintr>
    lapiceoi();
801066a5:	e8 a6 c1 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801066aa:	e8 c1 d2 ff ff       	call   80103970 <myproc>
801066af:	85 c0                	test   %eax,%eax
801066b1:	0f 85 e6 fe ff ff    	jne    8010659d <trap+0xbd>
801066b7:	e9 fc fe ff ff       	jmp    801065b8 <trap+0xd8>
801066bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801066c0:	8b 7b 38             	mov    0x38(%ebx),%edi
801066c3:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801066c7:	e8 84 d2 ff ff       	call   80103950 <cpuid>
801066cc:	c7 04 24 04 85 10 80 	movl   $0x80108504,(%esp)
801066d3:	89 7c 24 0c          	mov    %edi,0xc(%esp)
801066d7:	89 74 24 08          	mov    %esi,0x8(%esp)
801066db:	89 44 24 04          	mov    %eax,0x4(%esp)
801066df:	e8 6c 9f ff ff       	call   80100650 <cprintf>
    lapiceoi();
801066e4:	e8 67 c1 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801066e9:	e8 82 d2 ff ff       	call   80103970 <myproc>
801066ee:	85 c0                	test   %eax,%eax
801066f0:	0f 85 a7 fe ff ff    	jne    8010659d <trap+0xbd>
801066f6:	e9 bd fe ff ff       	jmp    801065b8 <trap+0xd8>
801066fb:	90                   	nop
801066fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80106700:	e8 5b ba ff ff       	call   80102160 <ideintr>
80106705:	e9 53 ff ff ff       	jmp    8010665d <trap+0x17d>
8010670a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106710:	e8 7b d6 ff ff       	call   80103d90 <exit>
80106715:	e9 f6 fe ff ff       	jmp    80106610 <trap+0x130>
8010671a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
80106720:	e8 6b d6 ff ff       	call   80103d90 <exit>
80106725:	e9 8e fe ff ff       	jmp    801065b8 <trap+0xd8>
8010672a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80106730:	c7 04 24 c0 5c 11 80 	movl   $0x80115cc0,(%esp)
80106737:	e8 54 ea ff ff       	call   80105190 <acquire>
      wakeup(&ticks);
8010673c:	c7 04 24 00 65 11 80 	movl   $0x80116500,(%esp)
      ticks++;
80106743:	ff 05 00 65 11 80    	incl   0x80116500
      wakeup(&ticks);
80106749:	e8 82 d9 ff ff       	call   801040d0 <wakeup>
      release(&tickslock);
8010674e:	c7 04 24 c0 5c 11 80 	movl   $0x80115cc0,(%esp)
80106755:	e8 d6 ea ff ff       	call   80105230 <release>
8010675a:	e9 fe fe ff ff       	jmp    8010665d <trap+0x17d>
8010675f:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106762:	e8 e9 d1 ff ff       	call   80103950 <cpuid>
80106767:	89 74 24 10          	mov    %esi,0x10(%esp)
8010676b:	89 7c 24 0c          	mov    %edi,0xc(%esp)
8010676f:	89 44 24 08          	mov    %eax,0x8(%esp)
80106773:	8b 43 30             	mov    0x30(%ebx),%eax
80106776:	c7 04 24 28 85 10 80 	movl   $0x80108528,(%esp)
8010677d:	89 44 24 04          	mov    %eax,0x4(%esp)
80106781:	e8 ca 9e ff ff       	call   80100650 <cprintf>
      panic("trap");
80106786:	c7 04 24 fe 84 10 80 	movl   $0x801084fe,(%esp)
8010678d:	e8 de 9b ff ff       	call   80100370 <panic>
80106792:	66 90                	xchg   %ax,%ax
80106794:	66 90                	xchg   %ax,%ax
80106796:	66 90                	xchg   %ax,%ax
80106798:	66 90                	xchg   %ax,%ax
8010679a:	66 90                	xchg   %ax,%ax
8010679c:	66 90                	xchg   %ax,%ax
8010679e:	66 90                	xchg   %ax,%ax

801067a0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801067a0:	a1 10 b6 10 80       	mov    0x8010b610,%eax
{
801067a5:	55                   	push   %ebp
801067a6:	89 e5                	mov    %esp,%ebp
  if(!uart)
801067a8:	85 c0                	test   %eax,%eax
801067aa:	74 1c                	je     801067c8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801067ac:	ba fd 03 00 00       	mov    $0x3fd,%edx
801067b1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801067b2:	24 01                	and    $0x1,%al
801067b4:	84 c0                	test   %al,%al
801067b6:	74 10                	je     801067c8 <uartgetc+0x28>
801067b8:	ba f8 03 00 00       	mov    $0x3f8,%edx
801067bd:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801067be:	0f b6 c0             	movzbl %al,%eax
}
801067c1:	5d                   	pop    %ebp
801067c2:	c3                   	ret    
801067c3:	90                   	nop
801067c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801067c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801067cd:	5d                   	pop    %ebp
801067ce:	c3                   	ret    
801067cf:	90                   	nop

801067d0 <uartputc.part.0>:
uartputc(int c)
801067d0:	55                   	push   %ebp
801067d1:	89 e5                	mov    %esp,%ebp
801067d3:	56                   	push   %esi
801067d4:	be fd 03 00 00       	mov    $0x3fd,%esi
801067d9:	53                   	push   %ebx
801067da:	bb 80 00 00 00       	mov    $0x80,%ebx
801067df:	83 ec 20             	sub    $0x20,%esp
801067e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
801067e5:	eb 18                	jmp    801067ff <uartputc.part.0+0x2f>
801067e7:	89 f6                	mov    %esi,%esi
801067e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
801067f0:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
801067f7:	e8 74 c0 ff ff       	call   80102870 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801067fc:	4b                   	dec    %ebx
801067fd:	74 09                	je     80106808 <uartputc.part.0+0x38>
801067ff:	89 f2                	mov    %esi,%edx
80106801:	ec                   	in     (%dx),%al
80106802:	24 20                	and    $0x20,%al
80106804:	84 c0                	test   %al,%al
80106806:	74 e8                	je     801067f0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106808:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010680d:	0f b6 45 f4          	movzbl -0xc(%ebp),%eax
80106811:	ee                   	out    %al,(%dx)
}
80106812:	83 c4 20             	add    $0x20,%esp
80106815:	5b                   	pop    %ebx
80106816:	5e                   	pop    %esi
80106817:	5d                   	pop    %ebp
80106818:	c3                   	ret    
80106819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106820 <uartinit>:
{
80106820:	55                   	push   %ebp
80106821:	31 c9                	xor    %ecx,%ecx
80106823:	89 e5                	mov    %esp,%ebp
80106825:	88 c8                	mov    %cl,%al
80106827:	57                   	push   %edi
80106828:	56                   	push   %esi
80106829:	53                   	push   %ebx
8010682a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010682f:	83 ec 1c             	sub    $0x1c,%esp
80106832:	89 da                	mov    %ebx,%edx
80106834:	ee                   	out    %al,(%dx)
80106835:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010683a:	b0 80                	mov    $0x80,%al
8010683c:	89 fa                	mov    %edi,%edx
8010683e:	ee                   	out    %al,(%dx)
8010683f:	b0 0c                	mov    $0xc,%al
80106841:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106846:	ee                   	out    %al,(%dx)
80106847:	be f9 03 00 00       	mov    $0x3f9,%esi
8010684c:	88 c8                	mov    %cl,%al
8010684e:	89 f2                	mov    %esi,%edx
80106850:	ee                   	out    %al,(%dx)
80106851:	b0 03                	mov    $0x3,%al
80106853:	89 fa                	mov    %edi,%edx
80106855:	ee                   	out    %al,(%dx)
80106856:	ba fc 03 00 00       	mov    $0x3fc,%edx
8010685b:	88 c8                	mov    %cl,%al
8010685d:	ee                   	out    %al,(%dx)
8010685e:	b0 01                	mov    $0x1,%al
80106860:	89 f2                	mov    %esi,%edx
80106862:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106863:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106868:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106869:	fe c0                	inc    %al
8010686b:	74 52                	je     801068bf <uartinit+0x9f>
  uart = 1;
8010686d:	b9 01 00 00 00       	mov    $0x1,%ecx
80106872:	89 da                	mov    %ebx,%edx
80106874:	89 0d 10 b6 10 80    	mov    %ecx,0x8010b610
8010687a:	ec                   	in     (%dx),%al
8010687b:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106880:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106881:	31 db                	xor    %ebx,%ebx
80106883:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  for(p="xv6...\n"; *p; p++)
80106887:	bb 20 86 10 80       	mov    $0x80108620,%ebx
  ioapicenable(IRQ_COM1, 0);
8010688c:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80106893:	e8 08 bb ff ff       	call   801023a0 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
80106898:	b8 78 00 00 00       	mov    $0x78,%eax
8010689d:	eb 09                	jmp    801068a8 <uartinit+0x88>
8010689f:	90                   	nop
801068a0:	43                   	inc    %ebx
801068a1:	0f be 03             	movsbl (%ebx),%eax
801068a4:	84 c0                	test   %al,%al
801068a6:	74 17                	je     801068bf <uartinit+0x9f>
  if(!uart)
801068a8:	8b 15 10 b6 10 80    	mov    0x8010b610,%edx
801068ae:	85 d2                	test   %edx,%edx
801068b0:	74 ee                	je     801068a0 <uartinit+0x80>
  for(p="xv6...\n"; *p; p++)
801068b2:	43                   	inc    %ebx
801068b3:	e8 18 ff ff ff       	call   801067d0 <uartputc.part.0>
801068b8:	0f be 03             	movsbl (%ebx),%eax
801068bb:	84 c0                	test   %al,%al
801068bd:	75 e9                	jne    801068a8 <uartinit+0x88>
}
801068bf:	83 c4 1c             	add    $0x1c,%esp
801068c2:	5b                   	pop    %ebx
801068c3:	5e                   	pop    %esi
801068c4:	5f                   	pop    %edi
801068c5:	5d                   	pop    %ebp
801068c6:	c3                   	ret    
801068c7:	89 f6                	mov    %esi,%esi
801068c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801068d0 <uartputc>:
  if(!uart)
801068d0:	8b 15 10 b6 10 80    	mov    0x8010b610,%edx
{
801068d6:	55                   	push   %ebp
801068d7:	89 e5                	mov    %esp,%ebp
801068d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
801068dc:	85 d2                	test   %edx,%edx
801068de:	74 10                	je     801068f0 <uartputc+0x20>
}
801068e0:	5d                   	pop    %ebp
801068e1:	e9 ea fe ff ff       	jmp    801067d0 <uartputc.part.0>
801068e6:	8d 76 00             	lea    0x0(%esi),%esi
801068e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801068f0:	5d                   	pop    %ebp
801068f1:	c3                   	ret    
801068f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106900 <uartintr>:

void
uartintr(void)
{
80106900:	55                   	push   %ebp
80106901:	89 e5                	mov    %esp,%ebp
80106903:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80106906:	c7 04 24 a0 67 10 80 	movl   $0x801067a0,(%esp)
8010690d:	e8 be 9e ff ff       	call   801007d0 <consoleintr>
}
80106912:	c9                   	leave  
80106913:	c3                   	ret    

80106914 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106914:	6a 00                	push   $0x0
  pushl $0
80106916:	6a 00                	push   $0x0
  jmp alltraps
80106918:	e9 f0 fa ff ff       	jmp    8010640d <alltraps>

8010691d <vector1>:
.globl vector1
vector1:
  pushl $0
8010691d:	6a 00                	push   $0x0
  pushl $1
8010691f:	6a 01                	push   $0x1
  jmp alltraps
80106921:	e9 e7 fa ff ff       	jmp    8010640d <alltraps>

80106926 <vector2>:
.globl vector2
vector2:
  pushl $0
80106926:	6a 00                	push   $0x0
  pushl $2
80106928:	6a 02                	push   $0x2
  jmp alltraps
8010692a:	e9 de fa ff ff       	jmp    8010640d <alltraps>

8010692f <vector3>:
.globl vector3
vector3:
  pushl $0
8010692f:	6a 00                	push   $0x0
  pushl $3
80106931:	6a 03                	push   $0x3
  jmp alltraps
80106933:	e9 d5 fa ff ff       	jmp    8010640d <alltraps>

80106938 <vector4>:
.globl vector4
vector4:
  pushl $0
80106938:	6a 00                	push   $0x0
  pushl $4
8010693a:	6a 04                	push   $0x4
  jmp alltraps
8010693c:	e9 cc fa ff ff       	jmp    8010640d <alltraps>

80106941 <vector5>:
.globl vector5
vector5:
  pushl $0
80106941:	6a 00                	push   $0x0
  pushl $5
80106943:	6a 05                	push   $0x5
  jmp alltraps
80106945:	e9 c3 fa ff ff       	jmp    8010640d <alltraps>

8010694a <vector6>:
.globl vector6
vector6:
  pushl $0
8010694a:	6a 00                	push   $0x0
  pushl $6
8010694c:	6a 06                	push   $0x6
  jmp alltraps
8010694e:	e9 ba fa ff ff       	jmp    8010640d <alltraps>

80106953 <vector7>:
.globl vector7
vector7:
  pushl $0
80106953:	6a 00                	push   $0x0
  pushl $7
80106955:	6a 07                	push   $0x7
  jmp alltraps
80106957:	e9 b1 fa ff ff       	jmp    8010640d <alltraps>

8010695c <vector8>:
.globl vector8
vector8:
  pushl $8
8010695c:	6a 08                	push   $0x8
  jmp alltraps
8010695e:	e9 aa fa ff ff       	jmp    8010640d <alltraps>

80106963 <vector9>:
.globl vector9
vector9:
  pushl $0
80106963:	6a 00                	push   $0x0
  pushl $9
80106965:	6a 09                	push   $0x9
  jmp alltraps
80106967:	e9 a1 fa ff ff       	jmp    8010640d <alltraps>

8010696c <vector10>:
.globl vector10
vector10:
  pushl $10
8010696c:	6a 0a                	push   $0xa
  jmp alltraps
8010696e:	e9 9a fa ff ff       	jmp    8010640d <alltraps>

80106973 <vector11>:
.globl vector11
vector11:
  pushl $11
80106973:	6a 0b                	push   $0xb
  jmp alltraps
80106975:	e9 93 fa ff ff       	jmp    8010640d <alltraps>

8010697a <vector12>:
.globl vector12
vector12:
  pushl $12
8010697a:	6a 0c                	push   $0xc
  jmp alltraps
8010697c:	e9 8c fa ff ff       	jmp    8010640d <alltraps>

80106981 <vector13>:
.globl vector13
vector13:
  pushl $13
80106981:	6a 0d                	push   $0xd
  jmp alltraps
80106983:	e9 85 fa ff ff       	jmp    8010640d <alltraps>

80106988 <vector14>:
.globl vector14
vector14:
  pushl $14
80106988:	6a 0e                	push   $0xe
  jmp alltraps
8010698a:	e9 7e fa ff ff       	jmp    8010640d <alltraps>

8010698f <vector15>:
.globl vector15
vector15:
  pushl $0
8010698f:	6a 00                	push   $0x0
  pushl $15
80106991:	6a 0f                	push   $0xf
  jmp alltraps
80106993:	e9 75 fa ff ff       	jmp    8010640d <alltraps>

80106998 <vector16>:
.globl vector16
vector16:
  pushl $0
80106998:	6a 00                	push   $0x0
  pushl $16
8010699a:	6a 10                	push   $0x10
  jmp alltraps
8010699c:	e9 6c fa ff ff       	jmp    8010640d <alltraps>

801069a1 <vector17>:
.globl vector17
vector17:
  pushl $17
801069a1:	6a 11                	push   $0x11
  jmp alltraps
801069a3:	e9 65 fa ff ff       	jmp    8010640d <alltraps>

801069a8 <vector18>:
.globl vector18
vector18:
  pushl $0
801069a8:	6a 00                	push   $0x0
  pushl $18
801069aa:	6a 12                	push   $0x12
  jmp alltraps
801069ac:	e9 5c fa ff ff       	jmp    8010640d <alltraps>

801069b1 <vector19>:
.globl vector19
vector19:
  pushl $0
801069b1:	6a 00                	push   $0x0
  pushl $19
801069b3:	6a 13                	push   $0x13
  jmp alltraps
801069b5:	e9 53 fa ff ff       	jmp    8010640d <alltraps>

801069ba <vector20>:
.globl vector20
vector20:
  pushl $0
801069ba:	6a 00                	push   $0x0
  pushl $20
801069bc:	6a 14                	push   $0x14
  jmp alltraps
801069be:	e9 4a fa ff ff       	jmp    8010640d <alltraps>

801069c3 <vector21>:
.globl vector21
vector21:
  pushl $0
801069c3:	6a 00                	push   $0x0
  pushl $21
801069c5:	6a 15                	push   $0x15
  jmp alltraps
801069c7:	e9 41 fa ff ff       	jmp    8010640d <alltraps>

801069cc <vector22>:
.globl vector22
vector22:
  pushl $0
801069cc:	6a 00                	push   $0x0
  pushl $22
801069ce:	6a 16                	push   $0x16
  jmp alltraps
801069d0:	e9 38 fa ff ff       	jmp    8010640d <alltraps>

801069d5 <vector23>:
.globl vector23
vector23:
  pushl $0
801069d5:	6a 00                	push   $0x0
  pushl $23
801069d7:	6a 17                	push   $0x17
  jmp alltraps
801069d9:	e9 2f fa ff ff       	jmp    8010640d <alltraps>

801069de <vector24>:
.globl vector24
vector24:
  pushl $0
801069de:	6a 00                	push   $0x0
  pushl $24
801069e0:	6a 18                	push   $0x18
  jmp alltraps
801069e2:	e9 26 fa ff ff       	jmp    8010640d <alltraps>

801069e7 <vector25>:
.globl vector25
vector25:
  pushl $0
801069e7:	6a 00                	push   $0x0
  pushl $25
801069e9:	6a 19                	push   $0x19
  jmp alltraps
801069eb:	e9 1d fa ff ff       	jmp    8010640d <alltraps>

801069f0 <vector26>:
.globl vector26
vector26:
  pushl $0
801069f0:	6a 00                	push   $0x0
  pushl $26
801069f2:	6a 1a                	push   $0x1a
  jmp alltraps
801069f4:	e9 14 fa ff ff       	jmp    8010640d <alltraps>

801069f9 <vector27>:
.globl vector27
vector27:
  pushl $0
801069f9:	6a 00                	push   $0x0
  pushl $27
801069fb:	6a 1b                	push   $0x1b
  jmp alltraps
801069fd:	e9 0b fa ff ff       	jmp    8010640d <alltraps>

80106a02 <vector28>:
.globl vector28
vector28:
  pushl $0
80106a02:	6a 00                	push   $0x0
  pushl $28
80106a04:	6a 1c                	push   $0x1c
  jmp alltraps
80106a06:	e9 02 fa ff ff       	jmp    8010640d <alltraps>

80106a0b <vector29>:
.globl vector29
vector29:
  pushl $0
80106a0b:	6a 00                	push   $0x0
  pushl $29
80106a0d:	6a 1d                	push   $0x1d
  jmp alltraps
80106a0f:	e9 f9 f9 ff ff       	jmp    8010640d <alltraps>

80106a14 <vector30>:
.globl vector30
vector30:
  pushl $0
80106a14:	6a 00                	push   $0x0
  pushl $30
80106a16:	6a 1e                	push   $0x1e
  jmp alltraps
80106a18:	e9 f0 f9 ff ff       	jmp    8010640d <alltraps>

80106a1d <vector31>:
.globl vector31
vector31:
  pushl $0
80106a1d:	6a 00                	push   $0x0
  pushl $31
80106a1f:	6a 1f                	push   $0x1f
  jmp alltraps
80106a21:	e9 e7 f9 ff ff       	jmp    8010640d <alltraps>

80106a26 <vector32>:
.globl vector32
vector32:
  pushl $0
80106a26:	6a 00                	push   $0x0
  pushl $32
80106a28:	6a 20                	push   $0x20
  jmp alltraps
80106a2a:	e9 de f9 ff ff       	jmp    8010640d <alltraps>

80106a2f <vector33>:
.globl vector33
vector33:
  pushl $0
80106a2f:	6a 00                	push   $0x0
  pushl $33
80106a31:	6a 21                	push   $0x21
  jmp alltraps
80106a33:	e9 d5 f9 ff ff       	jmp    8010640d <alltraps>

80106a38 <vector34>:
.globl vector34
vector34:
  pushl $0
80106a38:	6a 00                	push   $0x0
  pushl $34
80106a3a:	6a 22                	push   $0x22
  jmp alltraps
80106a3c:	e9 cc f9 ff ff       	jmp    8010640d <alltraps>

80106a41 <vector35>:
.globl vector35
vector35:
  pushl $0
80106a41:	6a 00                	push   $0x0
  pushl $35
80106a43:	6a 23                	push   $0x23
  jmp alltraps
80106a45:	e9 c3 f9 ff ff       	jmp    8010640d <alltraps>

80106a4a <vector36>:
.globl vector36
vector36:
  pushl $0
80106a4a:	6a 00                	push   $0x0
  pushl $36
80106a4c:	6a 24                	push   $0x24
  jmp alltraps
80106a4e:	e9 ba f9 ff ff       	jmp    8010640d <alltraps>

80106a53 <vector37>:
.globl vector37
vector37:
  pushl $0
80106a53:	6a 00                	push   $0x0
  pushl $37
80106a55:	6a 25                	push   $0x25
  jmp alltraps
80106a57:	e9 b1 f9 ff ff       	jmp    8010640d <alltraps>

80106a5c <vector38>:
.globl vector38
vector38:
  pushl $0
80106a5c:	6a 00                	push   $0x0
  pushl $38
80106a5e:	6a 26                	push   $0x26
  jmp alltraps
80106a60:	e9 a8 f9 ff ff       	jmp    8010640d <alltraps>

80106a65 <vector39>:
.globl vector39
vector39:
  pushl $0
80106a65:	6a 00                	push   $0x0
  pushl $39
80106a67:	6a 27                	push   $0x27
  jmp alltraps
80106a69:	e9 9f f9 ff ff       	jmp    8010640d <alltraps>

80106a6e <vector40>:
.globl vector40
vector40:
  pushl $0
80106a6e:	6a 00                	push   $0x0
  pushl $40
80106a70:	6a 28                	push   $0x28
  jmp alltraps
80106a72:	e9 96 f9 ff ff       	jmp    8010640d <alltraps>

80106a77 <vector41>:
.globl vector41
vector41:
  pushl $0
80106a77:	6a 00                	push   $0x0
  pushl $41
80106a79:	6a 29                	push   $0x29
  jmp alltraps
80106a7b:	e9 8d f9 ff ff       	jmp    8010640d <alltraps>

80106a80 <vector42>:
.globl vector42
vector42:
  pushl $0
80106a80:	6a 00                	push   $0x0
  pushl $42
80106a82:	6a 2a                	push   $0x2a
  jmp alltraps
80106a84:	e9 84 f9 ff ff       	jmp    8010640d <alltraps>

80106a89 <vector43>:
.globl vector43
vector43:
  pushl $0
80106a89:	6a 00                	push   $0x0
  pushl $43
80106a8b:	6a 2b                	push   $0x2b
  jmp alltraps
80106a8d:	e9 7b f9 ff ff       	jmp    8010640d <alltraps>

80106a92 <vector44>:
.globl vector44
vector44:
  pushl $0
80106a92:	6a 00                	push   $0x0
  pushl $44
80106a94:	6a 2c                	push   $0x2c
  jmp alltraps
80106a96:	e9 72 f9 ff ff       	jmp    8010640d <alltraps>

80106a9b <vector45>:
.globl vector45
vector45:
  pushl $0
80106a9b:	6a 00                	push   $0x0
  pushl $45
80106a9d:	6a 2d                	push   $0x2d
  jmp alltraps
80106a9f:	e9 69 f9 ff ff       	jmp    8010640d <alltraps>

80106aa4 <vector46>:
.globl vector46
vector46:
  pushl $0
80106aa4:	6a 00                	push   $0x0
  pushl $46
80106aa6:	6a 2e                	push   $0x2e
  jmp alltraps
80106aa8:	e9 60 f9 ff ff       	jmp    8010640d <alltraps>

80106aad <vector47>:
.globl vector47
vector47:
  pushl $0
80106aad:	6a 00                	push   $0x0
  pushl $47
80106aaf:	6a 2f                	push   $0x2f
  jmp alltraps
80106ab1:	e9 57 f9 ff ff       	jmp    8010640d <alltraps>

80106ab6 <vector48>:
.globl vector48
vector48:
  pushl $0
80106ab6:	6a 00                	push   $0x0
  pushl $48
80106ab8:	6a 30                	push   $0x30
  jmp alltraps
80106aba:	e9 4e f9 ff ff       	jmp    8010640d <alltraps>

80106abf <vector49>:
.globl vector49
vector49:
  pushl $0
80106abf:	6a 00                	push   $0x0
  pushl $49
80106ac1:	6a 31                	push   $0x31
  jmp alltraps
80106ac3:	e9 45 f9 ff ff       	jmp    8010640d <alltraps>

80106ac8 <vector50>:
.globl vector50
vector50:
  pushl $0
80106ac8:	6a 00                	push   $0x0
  pushl $50
80106aca:	6a 32                	push   $0x32
  jmp alltraps
80106acc:	e9 3c f9 ff ff       	jmp    8010640d <alltraps>

80106ad1 <vector51>:
.globl vector51
vector51:
  pushl $0
80106ad1:	6a 00                	push   $0x0
  pushl $51
80106ad3:	6a 33                	push   $0x33
  jmp alltraps
80106ad5:	e9 33 f9 ff ff       	jmp    8010640d <alltraps>

80106ada <vector52>:
.globl vector52
vector52:
  pushl $0
80106ada:	6a 00                	push   $0x0
  pushl $52
80106adc:	6a 34                	push   $0x34
  jmp alltraps
80106ade:	e9 2a f9 ff ff       	jmp    8010640d <alltraps>

80106ae3 <vector53>:
.globl vector53
vector53:
  pushl $0
80106ae3:	6a 00                	push   $0x0
  pushl $53
80106ae5:	6a 35                	push   $0x35
  jmp alltraps
80106ae7:	e9 21 f9 ff ff       	jmp    8010640d <alltraps>

80106aec <vector54>:
.globl vector54
vector54:
  pushl $0
80106aec:	6a 00                	push   $0x0
  pushl $54
80106aee:	6a 36                	push   $0x36
  jmp alltraps
80106af0:	e9 18 f9 ff ff       	jmp    8010640d <alltraps>

80106af5 <vector55>:
.globl vector55
vector55:
  pushl $0
80106af5:	6a 00                	push   $0x0
  pushl $55
80106af7:	6a 37                	push   $0x37
  jmp alltraps
80106af9:	e9 0f f9 ff ff       	jmp    8010640d <alltraps>

80106afe <vector56>:
.globl vector56
vector56:
  pushl $0
80106afe:	6a 00                	push   $0x0
  pushl $56
80106b00:	6a 38                	push   $0x38
  jmp alltraps
80106b02:	e9 06 f9 ff ff       	jmp    8010640d <alltraps>

80106b07 <vector57>:
.globl vector57
vector57:
  pushl $0
80106b07:	6a 00                	push   $0x0
  pushl $57
80106b09:	6a 39                	push   $0x39
  jmp alltraps
80106b0b:	e9 fd f8 ff ff       	jmp    8010640d <alltraps>

80106b10 <vector58>:
.globl vector58
vector58:
  pushl $0
80106b10:	6a 00                	push   $0x0
  pushl $58
80106b12:	6a 3a                	push   $0x3a
  jmp alltraps
80106b14:	e9 f4 f8 ff ff       	jmp    8010640d <alltraps>

80106b19 <vector59>:
.globl vector59
vector59:
  pushl $0
80106b19:	6a 00                	push   $0x0
  pushl $59
80106b1b:	6a 3b                	push   $0x3b
  jmp alltraps
80106b1d:	e9 eb f8 ff ff       	jmp    8010640d <alltraps>

80106b22 <vector60>:
.globl vector60
vector60:
  pushl $0
80106b22:	6a 00                	push   $0x0
  pushl $60
80106b24:	6a 3c                	push   $0x3c
  jmp alltraps
80106b26:	e9 e2 f8 ff ff       	jmp    8010640d <alltraps>

80106b2b <vector61>:
.globl vector61
vector61:
  pushl $0
80106b2b:	6a 00                	push   $0x0
  pushl $61
80106b2d:	6a 3d                	push   $0x3d
  jmp alltraps
80106b2f:	e9 d9 f8 ff ff       	jmp    8010640d <alltraps>

80106b34 <vector62>:
.globl vector62
vector62:
  pushl $0
80106b34:	6a 00                	push   $0x0
  pushl $62
80106b36:	6a 3e                	push   $0x3e
  jmp alltraps
80106b38:	e9 d0 f8 ff ff       	jmp    8010640d <alltraps>

80106b3d <vector63>:
.globl vector63
vector63:
  pushl $0
80106b3d:	6a 00                	push   $0x0
  pushl $63
80106b3f:	6a 3f                	push   $0x3f
  jmp alltraps
80106b41:	e9 c7 f8 ff ff       	jmp    8010640d <alltraps>

80106b46 <vector64>:
.globl vector64
vector64:
  pushl $0
80106b46:	6a 00                	push   $0x0
  pushl $64
80106b48:	6a 40                	push   $0x40
  jmp alltraps
80106b4a:	e9 be f8 ff ff       	jmp    8010640d <alltraps>

80106b4f <vector65>:
.globl vector65
vector65:
  pushl $0
80106b4f:	6a 00                	push   $0x0
  pushl $65
80106b51:	6a 41                	push   $0x41
  jmp alltraps
80106b53:	e9 b5 f8 ff ff       	jmp    8010640d <alltraps>

80106b58 <vector66>:
.globl vector66
vector66:
  pushl $0
80106b58:	6a 00                	push   $0x0
  pushl $66
80106b5a:	6a 42                	push   $0x42
  jmp alltraps
80106b5c:	e9 ac f8 ff ff       	jmp    8010640d <alltraps>

80106b61 <vector67>:
.globl vector67
vector67:
  pushl $0
80106b61:	6a 00                	push   $0x0
  pushl $67
80106b63:	6a 43                	push   $0x43
  jmp alltraps
80106b65:	e9 a3 f8 ff ff       	jmp    8010640d <alltraps>

80106b6a <vector68>:
.globl vector68
vector68:
  pushl $0
80106b6a:	6a 00                	push   $0x0
  pushl $68
80106b6c:	6a 44                	push   $0x44
  jmp alltraps
80106b6e:	e9 9a f8 ff ff       	jmp    8010640d <alltraps>

80106b73 <vector69>:
.globl vector69
vector69:
  pushl $0
80106b73:	6a 00                	push   $0x0
  pushl $69
80106b75:	6a 45                	push   $0x45
  jmp alltraps
80106b77:	e9 91 f8 ff ff       	jmp    8010640d <alltraps>

80106b7c <vector70>:
.globl vector70
vector70:
  pushl $0
80106b7c:	6a 00                	push   $0x0
  pushl $70
80106b7e:	6a 46                	push   $0x46
  jmp alltraps
80106b80:	e9 88 f8 ff ff       	jmp    8010640d <alltraps>

80106b85 <vector71>:
.globl vector71
vector71:
  pushl $0
80106b85:	6a 00                	push   $0x0
  pushl $71
80106b87:	6a 47                	push   $0x47
  jmp alltraps
80106b89:	e9 7f f8 ff ff       	jmp    8010640d <alltraps>

80106b8e <vector72>:
.globl vector72
vector72:
  pushl $0
80106b8e:	6a 00                	push   $0x0
  pushl $72
80106b90:	6a 48                	push   $0x48
  jmp alltraps
80106b92:	e9 76 f8 ff ff       	jmp    8010640d <alltraps>

80106b97 <vector73>:
.globl vector73
vector73:
  pushl $0
80106b97:	6a 00                	push   $0x0
  pushl $73
80106b99:	6a 49                	push   $0x49
  jmp alltraps
80106b9b:	e9 6d f8 ff ff       	jmp    8010640d <alltraps>

80106ba0 <vector74>:
.globl vector74
vector74:
  pushl $0
80106ba0:	6a 00                	push   $0x0
  pushl $74
80106ba2:	6a 4a                	push   $0x4a
  jmp alltraps
80106ba4:	e9 64 f8 ff ff       	jmp    8010640d <alltraps>

80106ba9 <vector75>:
.globl vector75
vector75:
  pushl $0
80106ba9:	6a 00                	push   $0x0
  pushl $75
80106bab:	6a 4b                	push   $0x4b
  jmp alltraps
80106bad:	e9 5b f8 ff ff       	jmp    8010640d <alltraps>

80106bb2 <vector76>:
.globl vector76
vector76:
  pushl $0
80106bb2:	6a 00                	push   $0x0
  pushl $76
80106bb4:	6a 4c                	push   $0x4c
  jmp alltraps
80106bb6:	e9 52 f8 ff ff       	jmp    8010640d <alltraps>

80106bbb <vector77>:
.globl vector77
vector77:
  pushl $0
80106bbb:	6a 00                	push   $0x0
  pushl $77
80106bbd:	6a 4d                	push   $0x4d
  jmp alltraps
80106bbf:	e9 49 f8 ff ff       	jmp    8010640d <alltraps>

80106bc4 <vector78>:
.globl vector78
vector78:
  pushl $0
80106bc4:	6a 00                	push   $0x0
  pushl $78
80106bc6:	6a 4e                	push   $0x4e
  jmp alltraps
80106bc8:	e9 40 f8 ff ff       	jmp    8010640d <alltraps>

80106bcd <vector79>:
.globl vector79
vector79:
  pushl $0
80106bcd:	6a 00                	push   $0x0
  pushl $79
80106bcf:	6a 4f                	push   $0x4f
  jmp alltraps
80106bd1:	e9 37 f8 ff ff       	jmp    8010640d <alltraps>

80106bd6 <vector80>:
.globl vector80
vector80:
  pushl $0
80106bd6:	6a 00                	push   $0x0
  pushl $80
80106bd8:	6a 50                	push   $0x50
  jmp alltraps
80106bda:	e9 2e f8 ff ff       	jmp    8010640d <alltraps>

80106bdf <vector81>:
.globl vector81
vector81:
  pushl $0
80106bdf:	6a 00                	push   $0x0
  pushl $81
80106be1:	6a 51                	push   $0x51
  jmp alltraps
80106be3:	e9 25 f8 ff ff       	jmp    8010640d <alltraps>

80106be8 <vector82>:
.globl vector82
vector82:
  pushl $0
80106be8:	6a 00                	push   $0x0
  pushl $82
80106bea:	6a 52                	push   $0x52
  jmp alltraps
80106bec:	e9 1c f8 ff ff       	jmp    8010640d <alltraps>

80106bf1 <vector83>:
.globl vector83
vector83:
  pushl $0
80106bf1:	6a 00                	push   $0x0
  pushl $83
80106bf3:	6a 53                	push   $0x53
  jmp alltraps
80106bf5:	e9 13 f8 ff ff       	jmp    8010640d <alltraps>

80106bfa <vector84>:
.globl vector84
vector84:
  pushl $0
80106bfa:	6a 00                	push   $0x0
  pushl $84
80106bfc:	6a 54                	push   $0x54
  jmp alltraps
80106bfe:	e9 0a f8 ff ff       	jmp    8010640d <alltraps>

80106c03 <vector85>:
.globl vector85
vector85:
  pushl $0
80106c03:	6a 00                	push   $0x0
  pushl $85
80106c05:	6a 55                	push   $0x55
  jmp alltraps
80106c07:	e9 01 f8 ff ff       	jmp    8010640d <alltraps>

80106c0c <vector86>:
.globl vector86
vector86:
  pushl $0
80106c0c:	6a 00                	push   $0x0
  pushl $86
80106c0e:	6a 56                	push   $0x56
  jmp alltraps
80106c10:	e9 f8 f7 ff ff       	jmp    8010640d <alltraps>

80106c15 <vector87>:
.globl vector87
vector87:
  pushl $0
80106c15:	6a 00                	push   $0x0
  pushl $87
80106c17:	6a 57                	push   $0x57
  jmp alltraps
80106c19:	e9 ef f7 ff ff       	jmp    8010640d <alltraps>

80106c1e <vector88>:
.globl vector88
vector88:
  pushl $0
80106c1e:	6a 00                	push   $0x0
  pushl $88
80106c20:	6a 58                	push   $0x58
  jmp alltraps
80106c22:	e9 e6 f7 ff ff       	jmp    8010640d <alltraps>

80106c27 <vector89>:
.globl vector89
vector89:
  pushl $0
80106c27:	6a 00                	push   $0x0
  pushl $89
80106c29:	6a 59                	push   $0x59
  jmp alltraps
80106c2b:	e9 dd f7 ff ff       	jmp    8010640d <alltraps>

80106c30 <vector90>:
.globl vector90
vector90:
  pushl $0
80106c30:	6a 00                	push   $0x0
  pushl $90
80106c32:	6a 5a                	push   $0x5a
  jmp alltraps
80106c34:	e9 d4 f7 ff ff       	jmp    8010640d <alltraps>

80106c39 <vector91>:
.globl vector91
vector91:
  pushl $0
80106c39:	6a 00                	push   $0x0
  pushl $91
80106c3b:	6a 5b                	push   $0x5b
  jmp alltraps
80106c3d:	e9 cb f7 ff ff       	jmp    8010640d <alltraps>

80106c42 <vector92>:
.globl vector92
vector92:
  pushl $0
80106c42:	6a 00                	push   $0x0
  pushl $92
80106c44:	6a 5c                	push   $0x5c
  jmp alltraps
80106c46:	e9 c2 f7 ff ff       	jmp    8010640d <alltraps>

80106c4b <vector93>:
.globl vector93
vector93:
  pushl $0
80106c4b:	6a 00                	push   $0x0
  pushl $93
80106c4d:	6a 5d                	push   $0x5d
  jmp alltraps
80106c4f:	e9 b9 f7 ff ff       	jmp    8010640d <alltraps>

80106c54 <vector94>:
.globl vector94
vector94:
  pushl $0
80106c54:	6a 00                	push   $0x0
  pushl $94
80106c56:	6a 5e                	push   $0x5e
  jmp alltraps
80106c58:	e9 b0 f7 ff ff       	jmp    8010640d <alltraps>

80106c5d <vector95>:
.globl vector95
vector95:
  pushl $0
80106c5d:	6a 00                	push   $0x0
  pushl $95
80106c5f:	6a 5f                	push   $0x5f
  jmp alltraps
80106c61:	e9 a7 f7 ff ff       	jmp    8010640d <alltraps>

80106c66 <vector96>:
.globl vector96
vector96:
  pushl $0
80106c66:	6a 00                	push   $0x0
  pushl $96
80106c68:	6a 60                	push   $0x60
  jmp alltraps
80106c6a:	e9 9e f7 ff ff       	jmp    8010640d <alltraps>

80106c6f <vector97>:
.globl vector97
vector97:
  pushl $0
80106c6f:	6a 00                	push   $0x0
  pushl $97
80106c71:	6a 61                	push   $0x61
  jmp alltraps
80106c73:	e9 95 f7 ff ff       	jmp    8010640d <alltraps>

80106c78 <vector98>:
.globl vector98
vector98:
  pushl $0
80106c78:	6a 00                	push   $0x0
  pushl $98
80106c7a:	6a 62                	push   $0x62
  jmp alltraps
80106c7c:	e9 8c f7 ff ff       	jmp    8010640d <alltraps>

80106c81 <vector99>:
.globl vector99
vector99:
  pushl $0
80106c81:	6a 00                	push   $0x0
  pushl $99
80106c83:	6a 63                	push   $0x63
  jmp alltraps
80106c85:	e9 83 f7 ff ff       	jmp    8010640d <alltraps>

80106c8a <vector100>:
.globl vector100
vector100:
  pushl $0
80106c8a:	6a 00                	push   $0x0
  pushl $100
80106c8c:	6a 64                	push   $0x64
  jmp alltraps
80106c8e:	e9 7a f7 ff ff       	jmp    8010640d <alltraps>

80106c93 <vector101>:
.globl vector101
vector101:
  pushl $0
80106c93:	6a 00                	push   $0x0
  pushl $101
80106c95:	6a 65                	push   $0x65
  jmp alltraps
80106c97:	e9 71 f7 ff ff       	jmp    8010640d <alltraps>

80106c9c <vector102>:
.globl vector102
vector102:
  pushl $0
80106c9c:	6a 00                	push   $0x0
  pushl $102
80106c9e:	6a 66                	push   $0x66
  jmp alltraps
80106ca0:	e9 68 f7 ff ff       	jmp    8010640d <alltraps>

80106ca5 <vector103>:
.globl vector103
vector103:
  pushl $0
80106ca5:	6a 00                	push   $0x0
  pushl $103
80106ca7:	6a 67                	push   $0x67
  jmp alltraps
80106ca9:	e9 5f f7 ff ff       	jmp    8010640d <alltraps>

80106cae <vector104>:
.globl vector104
vector104:
  pushl $0
80106cae:	6a 00                	push   $0x0
  pushl $104
80106cb0:	6a 68                	push   $0x68
  jmp alltraps
80106cb2:	e9 56 f7 ff ff       	jmp    8010640d <alltraps>

80106cb7 <vector105>:
.globl vector105
vector105:
  pushl $0
80106cb7:	6a 00                	push   $0x0
  pushl $105
80106cb9:	6a 69                	push   $0x69
  jmp alltraps
80106cbb:	e9 4d f7 ff ff       	jmp    8010640d <alltraps>

80106cc0 <vector106>:
.globl vector106
vector106:
  pushl $0
80106cc0:	6a 00                	push   $0x0
  pushl $106
80106cc2:	6a 6a                	push   $0x6a
  jmp alltraps
80106cc4:	e9 44 f7 ff ff       	jmp    8010640d <alltraps>

80106cc9 <vector107>:
.globl vector107
vector107:
  pushl $0
80106cc9:	6a 00                	push   $0x0
  pushl $107
80106ccb:	6a 6b                	push   $0x6b
  jmp alltraps
80106ccd:	e9 3b f7 ff ff       	jmp    8010640d <alltraps>

80106cd2 <vector108>:
.globl vector108
vector108:
  pushl $0
80106cd2:	6a 00                	push   $0x0
  pushl $108
80106cd4:	6a 6c                	push   $0x6c
  jmp alltraps
80106cd6:	e9 32 f7 ff ff       	jmp    8010640d <alltraps>

80106cdb <vector109>:
.globl vector109
vector109:
  pushl $0
80106cdb:	6a 00                	push   $0x0
  pushl $109
80106cdd:	6a 6d                	push   $0x6d
  jmp alltraps
80106cdf:	e9 29 f7 ff ff       	jmp    8010640d <alltraps>

80106ce4 <vector110>:
.globl vector110
vector110:
  pushl $0
80106ce4:	6a 00                	push   $0x0
  pushl $110
80106ce6:	6a 6e                	push   $0x6e
  jmp alltraps
80106ce8:	e9 20 f7 ff ff       	jmp    8010640d <alltraps>

80106ced <vector111>:
.globl vector111
vector111:
  pushl $0
80106ced:	6a 00                	push   $0x0
  pushl $111
80106cef:	6a 6f                	push   $0x6f
  jmp alltraps
80106cf1:	e9 17 f7 ff ff       	jmp    8010640d <alltraps>

80106cf6 <vector112>:
.globl vector112
vector112:
  pushl $0
80106cf6:	6a 00                	push   $0x0
  pushl $112
80106cf8:	6a 70                	push   $0x70
  jmp alltraps
80106cfa:	e9 0e f7 ff ff       	jmp    8010640d <alltraps>

80106cff <vector113>:
.globl vector113
vector113:
  pushl $0
80106cff:	6a 00                	push   $0x0
  pushl $113
80106d01:	6a 71                	push   $0x71
  jmp alltraps
80106d03:	e9 05 f7 ff ff       	jmp    8010640d <alltraps>

80106d08 <vector114>:
.globl vector114
vector114:
  pushl $0
80106d08:	6a 00                	push   $0x0
  pushl $114
80106d0a:	6a 72                	push   $0x72
  jmp alltraps
80106d0c:	e9 fc f6 ff ff       	jmp    8010640d <alltraps>

80106d11 <vector115>:
.globl vector115
vector115:
  pushl $0
80106d11:	6a 00                	push   $0x0
  pushl $115
80106d13:	6a 73                	push   $0x73
  jmp alltraps
80106d15:	e9 f3 f6 ff ff       	jmp    8010640d <alltraps>

80106d1a <vector116>:
.globl vector116
vector116:
  pushl $0
80106d1a:	6a 00                	push   $0x0
  pushl $116
80106d1c:	6a 74                	push   $0x74
  jmp alltraps
80106d1e:	e9 ea f6 ff ff       	jmp    8010640d <alltraps>

80106d23 <vector117>:
.globl vector117
vector117:
  pushl $0
80106d23:	6a 00                	push   $0x0
  pushl $117
80106d25:	6a 75                	push   $0x75
  jmp alltraps
80106d27:	e9 e1 f6 ff ff       	jmp    8010640d <alltraps>

80106d2c <vector118>:
.globl vector118
vector118:
  pushl $0
80106d2c:	6a 00                	push   $0x0
  pushl $118
80106d2e:	6a 76                	push   $0x76
  jmp alltraps
80106d30:	e9 d8 f6 ff ff       	jmp    8010640d <alltraps>

80106d35 <vector119>:
.globl vector119
vector119:
  pushl $0
80106d35:	6a 00                	push   $0x0
  pushl $119
80106d37:	6a 77                	push   $0x77
  jmp alltraps
80106d39:	e9 cf f6 ff ff       	jmp    8010640d <alltraps>

80106d3e <vector120>:
.globl vector120
vector120:
  pushl $0
80106d3e:	6a 00                	push   $0x0
  pushl $120
80106d40:	6a 78                	push   $0x78
  jmp alltraps
80106d42:	e9 c6 f6 ff ff       	jmp    8010640d <alltraps>

80106d47 <vector121>:
.globl vector121
vector121:
  pushl $0
80106d47:	6a 00                	push   $0x0
  pushl $121
80106d49:	6a 79                	push   $0x79
  jmp alltraps
80106d4b:	e9 bd f6 ff ff       	jmp    8010640d <alltraps>

80106d50 <vector122>:
.globl vector122
vector122:
  pushl $0
80106d50:	6a 00                	push   $0x0
  pushl $122
80106d52:	6a 7a                	push   $0x7a
  jmp alltraps
80106d54:	e9 b4 f6 ff ff       	jmp    8010640d <alltraps>

80106d59 <vector123>:
.globl vector123
vector123:
  pushl $0
80106d59:	6a 00                	push   $0x0
  pushl $123
80106d5b:	6a 7b                	push   $0x7b
  jmp alltraps
80106d5d:	e9 ab f6 ff ff       	jmp    8010640d <alltraps>

80106d62 <vector124>:
.globl vector124
vector124:
  pushl $0
80106d62:	6a 00                	push   $0x0
  pushl $124
80106d64:	6a 7c                	push   $0x7c
  jmp alltraps
80106d66:	e9 a2 f6 ff ff       	jmp    8010640d <alltraps>

80106d6b <vector125>:
.globl vector125
vector125:
  pushl $0
80106d6b:	6a 00                	push   $0x0
  pushl $125
80106d6d:	6a 7d                	push   $0x7d
  jmp alltraps
80106d6f:	e9 99 f6 ff ff       	jmp    8010640d <alltraps>

80106d74 <vector126>:
.globl vector126
vector126:
  pushl $0
80106d74:	6a 00                	push   $0x0
  pushl $126
80106d76:	6a 7e                	push   $0x7e
  jmp alltraps
80106d78:	e9 90 f6 ff ff       	jmp    8010640d <alltraps>

80106d7d <vector127>:
.globl vector127
vector127:
  pushl $0
80106d7d:	6a 00                	push   $0x0
  pushl $127
80106d7f:	6a 7f                	push   $0x7f
  jmp alltraps
80106d81:	e9 87 f6 ff ff       	jmp    8010640d <alltraps>

80106d86 <vector128>:
.globl vector128
vector128:
  pushl $0
80106d86:	6a 00                	push   $0x0
  pushl $128
80106d88:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106d8d:	e9 7b f6 ff ff       	jmp    8010640d <alltraps>

80106d92 <vector129>:
.globl vector129
vector129:
  pushl $0
80106d92:	6a 00                	push   $0x0
  pushl $129
80106d94:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106d99:	e9 6f f6 ff ff       	jmp    8010640d <alltraps>

80106d9e <vector130>:
.globl vector130
vector130:
  pushl $0
80106d9e:	6a 00                	push   $0x0
  pushl $130
80106da0:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106da5:	e9 63 f6 ff ff       	jmp    8010640d <alltraps>

80106daa <vector131>:
.globl vector131
vector131:
  pushl $0
80106daa:	6a 00                	push   $0x0
  pushl $131
80106dac:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106db1:	e9 57 f6 ff ff       	jmp    8010640d <alltraps>

80106db6 <vector132>:
.globl vector132
vector132:
  pushl $0
80106db6:	6a 00                	push   $0x0
  pushl $132
80106db8:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106dbd:	e9 4b f6 ff ff       	jmp    8010640d <alltraps>

80106dc2 <vector133>:
.globl vector133
vector133:
  pushl $0
80106dc2:	6a 00                	push   $0x0
  pushl $133
80106dc4:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106dc9:	e9 3f f6 ff ff       	jmp    8010640d <alltraps>

80106dce <vector134>:
.globl vector134
vector134:
  pushl $0
80106dce:	6a 00                	push   $0x0
  pushl $134
80106dd0:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106dd5:	e9 33 f6 ff ff       	jmp    8010640d <alltraps>

80106dda <vector135>:
.globl vector135
vector135:
  pushl $0
80106dda:	6a 00                	push   $0x0
  pushl $135
80106ddc:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106de1:	e9 27 f6 ff ff       	jmp    8010640d <alltraps>

80106de6 <vector136>:
.globl vector136
vector136:
  pushl $0
80106de6:	6a 00                	push   $0x0
  pushl $136
80106de8:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106ded:	e9 1b f6 ff ff       	jmp    8010640d <alltraps>

80106df2 <vector137>:
.globl vector137
vector137:
  pushl $0
80106df2:	6a 00                	push   $0x0
  pushl $137
80106df4:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106df9:	e9 0f f6 ff ff       	jmp    8010640d <alltraps>

80106dfe <vector138>:
.globl vector138
vector138:
  pushl $0
80106dfe:	6a 00                	push   $0x0
  pushl $138
80106e00:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106e05:	e9 03 f6 ff ff       	jmp    8010640d <alltraps>

80106e0a <vector139>:
.globl vector139
vector139:
  pushl $0
80106e0a:	6a 00                	push   $0x0
  pushl $139
80106e0c:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106e11:	e9 f7 f5 ff ff       	jmp    8010640d <alltraps>

80106e16 <vector140>:
.globl vector140
vector140:
  pushl $0
80106e16:	6a 00                	push   $0x0
  pushl $140
80106e18:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106e1d:	e9 eb f5 ff ff       	jmp    8010640d <alltraps>

80106e22 <vector141>:
.globl vector141
vector141:
  pushl $0
80106e22:	6a 00                	push   $0x0
  pushl $141
80106e24:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106e29:	e9 df f5 ff ff       	jmp    8010640d <alltraps>

80106e2e <vector142>:
.globl vector142
vector142:
  pushl $0
80106e2e:	6a 00                	push   $0x0
  pushl $142
80106e30:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106e35:	e9 d3 f5 ff ff       	jmp    8010640d <alltraps>

80106e3a <vector143>:
.globl vector143
vector143:
  pushl $0
80106e3a:	6a 00                	push   $0x0
  pushl $143
80106e3c:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106e41:	e9 c7 f5 ff ff       	jmp    8010640d <alltraps>

80106e46 <vector144>:
.globl vector144
vector144:
  pushl $0
80106e46:	6a 00                	push   $0x0
  pushl $144
80106e48:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106e4d:	e9 bb f5 ff ff       	jmp    8010640d <alltraps>

80106e52 <vector145>:
.globl vector145
vector145:
  pushl $0
80106e52:	6a 00                	push   $0x0
  pushl $145
80106e54:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106e59:	e9 af f5 ff ff       	jmp    8010640d <alltraps>

80106e5e <vector146>:
.globl vector146
vector146:
  pushl $0
80106e5e:	6a 00                	push   $0x0
  pushl $146
80106e60:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106e65:	e9 a3 f5 ff ff       	jmp    8010640d <alltraps>

80106e6a <vector147>:
.globl vector147
vector147:
  pushl $0
80106e6a:	6a 00                	push   $0x0
  pushl $147
80106e6c:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106e71:	e9 97 f5 ff ff       	jmp    8010640d <alltraps>

80106e76 <vector148>:
.globl vector148
vector148:
  pushl $0
80106e76:	6a 00                	push   $0x0
  pushl $148
80106e78:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106e7d:	e9 8b f5 ff ff       	jmp    8010640d <alltraps>

80106e82 <vector149>:
.globl vector149
vector149:
  pushl $0
80106e82:	6a 00                	push   $0x0
  pushl $149
80106e84:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106e89:	e9 7f f5 ff ff       	jmp    8010640d <alltraps>

80106e8e <vector150>:
.globl vector150
vector150:
  pushl $0
80106e8e:	6a 00                	push   $0x0
  pushl $150
80106e90:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106e95:	e9 73 f5 ff ff       	jmp    8010640d <alltraps>

80106e9a <vector151>:
.globl vector151
vector151:
  pushl $0
80106e9a:	6a 00                	push   $0x0
  pushl $151
80106e9c:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106ea1:	e9 67 f5 ff ff       	jmp    8010640d <alltraps>

80106ea6 <vector152>:
.globl vector152
vector152:
  pushl $0
80106ea6:	6a 00                	push   $0x0
  pushl $152
80106ea8:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106ead:	e9 5b f5 ff ff       	jmp    8010640d <alltraps>

80106eb2 <vector153>:
.globl vector153
vector153:
  pushl $0
80106eb2:	6a 00                	push   $0x0
  pushl $153
80106eb4:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106eb9:	e9 4f f5 ff ff       	jmp    8010640d <alltraps>

80106ebe <vector154>:
.globl vector154
vector154:
  pushl $0
80106ebe:	6a 00                	push   $0x0
  pushl $154
80106ec0:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106ec5:	e9 43 f5 ff ff       	jmp    8010640d <alltraps>

80106eca <vector155>:
.globl vector155
vector155:
  pushl $0
80106eca:	6a 00                	push   $0x0
  pushl $155
80106ecc:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106ed1:	e9 37 f5 ff ff       	jmp    8010640d <alltraps>

80106ed6 <vector156>:
.globl vector156
vector156:
  pushl $0
80106ed6:	6a 00                	push   $0x0
  pushl $156
80106ed8:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106edd:	e9 2b f5 ff ff       	jmp    8010640d <alltraps>

80106ee2 <vector157>:
.globl vector157
vector157:
  pushl $0
80106ee2:	6a 00                	push   $0x0
  pushl $157
80106ee4:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106ee9:	e9 1f f5 ff ff       	jmp    8010640d <alltraps>

80106eee <vector158>:
.globl vector158
vector158:
  pushl $0
80106eee:	6a 00                	push   $0x0
  pushl $158
80106ef0:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106ef5:	e9 13 f5 ff ff       	jmp    8010640d <alltraps>

80106efa <vector159>:
.globl vector159
vector159:
  pushl $0
80106efa:	6a 00                	push   $0x0
  pushl $159
80106efc:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106f01:	e9 07 f5 ff ff       	jmp    8010640d <alltraps>

80106f06 <vector160>:
.globl vector160
vector160:
  pushl $0
80106f06:	6a 00                	push   $0x0
  pushl $160
80106f08:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106f0d:	e9 fb f4 ff ff       	jmp    8010640d <alltraps>

80106f12 <vector161>:
.globl vector161
vector161:
  pushl $0
80106f12:	6a 00                	push   $0x0
  pushl $161
80106f14:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106f19:	e9 ef f4 ff ff       	jmp    8010640d <alltraps>

80106f1e <vector162>:
.globl vector162
vector162:
  pushl $0
80106f1e:	6a 00                	push   $0x0
  pushl $162
80106f20:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106f25:	e9 e3 f4 ff ff       	jmp    8010640d <alltraps>

80106f2a <vector163>:
.globl vector163
vector163:
  pushl $0
80106f2a:	6a 00                	push   $0x0
  pushl $163
80106f2c:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106f31:	e9 d7 f4 ff ff       	jmp    8010640d <alltraps>

80106f36 <vector164>:
.globl vector164
vector164:
  pushl $0
80106f36:	6a 00                	push   $0x0
  pushl $164
80106f38:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106f3d:	e9 cb f4 ff ff       	jmp    8010640d <alltraps>

80106f42 <vector165>:
.globl vector165
vector165:
  pushl $0
80106f42:	6a 00                	push   $0x0
  pushl $165
80106f44:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106f49:	e9 bf f4 ff ff       	jmp    8010640d <alltraps>

80106f4e <vector166>:
.globl vector166
vector166:
  pushl $0
80106f4e:	6a 00                	push   $0x0
  pushl $166
80106f50:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106f55:	e9 b3 f4 ff ff       	jmp    8010640d <alltraps>

80106f5a <vector167>:
.globl vector167
vector167:
  pushl $0
80106f5a:	6a 00                	push   $0x0
  pushl $167
80106f5c:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106f61:	e9 a7 f4 ff ff       	jmp    8010640d <alltraps>

80106f66 <vector168>:
.globl vector168
vector168:
  pushl $0
80106f66:	6a 00                	push   $0x0
  pushl $168
80106f68:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106f6d:	e9 9b f4 ff ff       	jmp    8010640d <alltraps>

80106f72 <vector169>:
.globl vector169
vector169:
  pushl $0
80106f72:	6a 00                	push   $0x0
  pushl $169
80106f74:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106f79:	e9 8f f4 ff ff       	jmp    8010640d <alltraps>

80106f7e <vector170>:
.globl vector170
vector170:
  pushl $0
80106f7e:	6a 00                	push   $0x0
  pushl $170
80106f80:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106f85:	e9 83 f4 ff ff       	jmp    8010640d <alltraps>

80106f8a <vector171>:
.globl vector171
vector171:
  pushl $0
80106f8a:	6a 00                	push   $0x0
  pushl $171
80106f8c:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106f91:	e9 77 f4 ff ff       	jmp    8010640d <alltraps>

80106f96 <vector172>:
.globl vector172
vector172:
  pushl $0
80106f96:	6a 00                	push   $0x0
  pushl $172
80106f98:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106f9d:	e9 6b f4 ff ff       	jmp    8010640d <alltraps>

80106fa2 <vector173>:
.globl vector173
vector173:
  pushl $0
80106fa2:	6a 00                	push   $0x0
  pushl $173
80106fa4:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106fa9:	e9 5f f4 ff ff       	jmp    8010640d <alltraps>

80106fae <vector174>:
.globl vector174
vector174:
  pushl $0
80106fae:	6a 00                	push   $0x0
  pushl $174
80106fb0:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106fb5:	e9 53 f4 ff ff       	jmp    8010640d <alltraps>

80106fba <vector175>:
.globl vector175
vector175:
  pushl $0
80106fba:	6a 00                	push   $0x0
  pushl $175
80106fbc:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106fc1:	e9 47 f4 ff ff       	jmp    8010640d <alltraps>

80106fc6 <vector176>:
.globl vector176
vector176:
  pushl $0
80106fc6:	6a 00                	push   $0x0
  pushl $176
80106fc8:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106fcd:	e9 3b f4 ff ff       	jmp    8010640d <alltraps>

80106fd2 <vector177>:
.globl vector177
vector177:
  pushl $0
80106fd2:	6a 00                	push   $0x0
  pushl $177
80106fd4:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106fd9:	e9 2f f4 ff ff       	jmp    8010640d <alltraps>

80106fde <vector178>:
.globl vector178
vector178:
  pushl $0
80106fde:	6a 00                	push   $0x0
  pushl $178
80106fe0:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106fe5:	e9 23 f4 ff ff       	jmp    8010640d <alltraps>

80106fea <vector179>:
.globl vector179
vector179:
  pushl $0
80106fea:	6a 00                	push   $0x0
  pushl $179
80106fec:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106ff1:	e9 17 f4 ff ff       	jmp    8010640d <alltraps>

80106ff6 <vector180>:
.globl vector180
vector180:
  pushl $0
80106ff6:	6a 00                	push   $0x0
  pushl $180
80106ff8:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106ffd:	e9 0b f4 ff ff       	jmp    8010640d <alltraps>

80107002 <vector181>:
.globl vector181
vector181:
  pushl $0
80107002:	6a 00                	push   $0x0
  pushl $181
80107004:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80107009:	e9 ff f3 ff ff       	jmp    8010640d <alltraps>

8010700e <vector182>:
.globl vector182
vector182:
  pushl $0
8010700e:	6a 00                	push   $0x0
  pushl $182
80107010:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107015:	e9 f3 f3 ff ff       	jmp    8010640d <alltraps>

8010701a <vector183>:
.globl vector183
vector183:
  pushl $0
8010701a:	6a 00                	push   $0x0
  pushl $183
8010701c:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107021:	e9 e7 f3 ff ff       	jmp    8010640d <alltraps>

80107026 <vector184>:
.globl vector184
vector184:
  pushl $0
80107026:	6a 00                	push   $0x0
  pushl $184
80107028:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010702d:	e9 db f3 ff ff       	jmp    8010640d <alltraps>

80107032 <vector185>:
.globl vector185
vector185:
  pushl $0
80107032:	6a 00                	push   $0x0
  pushl $185
80107034:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80107039:	e9 cf f3 ff ff       	jmp    8010640d <alltraps>

8010703e <vector186>:
.globl vector186
vector186:
  pushl $0
8010703e:	6a 00                	push   $0x0
  pushl $186
80107040:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107045:	e9 c3 f3 ff ff       	jmp    8010640d <alltraps>

8010704a <vector187>:
.globl vector187
vector187:
  pushl $0
8010704a:	6a 00                	push   $0x0
  pushl $187
8010704c:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107051:	e9 b7 f3 ff ff       	jmp    8010640d <alltraps>

80107056 <vector188>:
.globl vector188
vector188:
  pushl $0
80107056:	6a 00                	push   $0x0
  pushl $188
80107058:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010705d:	e9 ab f3 ff ff       	jmp    8010640d <alltraps>

80107062 <vector189>:
.globl vector189
vector189:
  pushl $0
80107062:	6a 00                	push   $0x0
  pushl $189
80107064:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80107069:	e9 9f f3 ff ff       	jmp    8010640d <alltraps>

8010706e <vector190>:
.globl vector190
vector190:
  pushl $0
8010706e:	6a 00                	push   $0x0
  pushl $190
80107070:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107075:	e9 93 f3 ff ff       	jmp    8010640d <alltraps>

8010707a <vector191>:
.globl vector191
vector191:
  pushl $0
8010707a:	6a 00                	push   $0x0
  pushl $191
8010707c:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107081:	e9 87 f3 ff ff       	jmp    8010640d <alltraps>

80107086 <vector192>:
.globl vector192
vector192:
  pushl $0
80107086:	6a 00                	push   $0x0
  pushl $192
80107088:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010708d:	e9 7b f3 ff ff       	jmp    8010640d <alltraps>

80107092 <vector193>:
.globl vector193
vector193:
  pushl $0
80107092:	6a 00                	push   $0x0
  pushl $193
80107094:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80107099:	e9 6f f3 ff ff       	jmp    8010640d <alltraps>

8010709e <vector194>:
.globl vector194
vector194:
  pushl $0
8010709e:	6a 00                	push   $0x0
  pushl $194
801070a0:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801070a5:	e9 63 f3 ff ff       	jmp    8010640d <alltraps>

801070aa <vector195>:
.globl vector195
vector195:
  pushl $0
801070aa:	6a 00                	push   $0x0
  pushl $195
801070ac:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801070b1:	e9 57 f3 ff ff       	jmp    8010640d <alltraps>

801070b6 <vector196>:
.globl vector196
vector196:
  pushl $0
801070b6:	6a 00                	push   $0x0
  pushl $196
801070b8:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801070bd:	e9 4b f3 ff ff       	jmp    8010640d <alltraps>

801070c2 <vector197>:
.globl vector197
vector197:
  pushl $0
801070c2:	6a 00                	push   $0x0
  pushl $197
801070c4:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801070c9:	e9 3f f3 ff ff       	jmp    8010640d <alltraps>

801070ce <vector198>:
.globl vector198
vector198:
  pushl $0
801070ce:	6a 00                	push   $0x0
  pushl $198
801070d0:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801070d5:	e9 33 f3 ff ff       	jmp    8010640d <alltraps>

801070da <vector199>:
.globl vector199
vector199:
  pushl $0
801070da:	6a 00                	push   $0x0
  pushl $199
801070dc:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801070e1:	e9 27 f3 ff ff       	jmp    8010640d <alltraps>

801070e6 <vector200>:
.globl vector200
vector200:
  pushl $0
801070e6:	6a 00                	push   $0x0
  pushl $200
801070e8:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801070ed:	e9 1b f3 ff ff       	jmp    8010640d <alltraps>

801070f2 <vector201>:
.globl vector201
vector201:
  pushl $0
801070f2:	6a 00                	push   $0x0
  pushl $201
801070f4:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801070f9:	e9 0f f3 ff ff       	jmp    8010640d <alltraps>

801070fe <vector202>:
.globl vector202
vector202:
  pushl $0
801070fe:	6a 00                	push   $0x0
  pushl $202
80107100:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107105:	e9 03 f3 ff ff       	jmp    8010640d <alltraps>

8010710a <vector203>:
.globl vector203
vector203:
  pushl $0
8010710a:	6a 00                	push   $0x0
  pushl $203
8010710c:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107111:	e9 f7 f2 ff ff       	jmp    8010640d <alltraps>

80107116 <vector204>:
.globl vector204
vector204:
  pushl $0
80107116:	6a 00                	push   $0x0
  pushl $204
80107118:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010711d:	e9 eb f2 ff ff       	jmp    8010640d <alltraps>

80107122 <vector205>:
.globl vector205
vector205:
  pushl $0
80107122:	6a 00                	push   $0x0
  pushl $205
80107124:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80107129:	e9 df f2 ff ff       	jmp    8010640d <alltraps>

8010712e <vector206>:
.globl vector206
vector206:
  pushl $0
8010712e:	6a 00                	push   $0x0
  pushl $206
80107130:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107135:	e9 d3 f2 ff ff       	jmp    8010640d <alltraps>

8010713a <vector207>:
.globl vector207
vector207:
  pushl $0
8010713a:	6a 00                	push   $0x0
  pushl $207
8010713c:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107141:	e9 c7 f2 ff ff       	jmp    8010640d <alltraps>

80107146 <vector208>:
.globl vector208
vector208:
  pushl $0
80107146:	6a 00                	push   $0x0
  pushl $208
80107148:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010714d:	e9 bb f2 ff ff       	jmp    8010640d <alltraps>

80107152 <vector209>:
.globl vector209
vector209:
  pushl $0
80107152:	6a 00                	push   $0x0
  pushl $209
80107154:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80107159:	e9 af f2 ff ff       	jmp    8010640d <alltraps>

8010715e <vector210>:
.globl vector210
vector210:
  pushl $0
8010715e:	6a 00                	push   $0x0
  pushl $210
80107160:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107165:	e9 a3 f2 ff ff       	jmp    8010640d <alltraps>

8010716a <vector211>:
.globl vector211
vector211:
  pushl $0
8010716a:	6a 00                	push   $0x0
  pushl $211
8010716c:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107171:	e9 97 f2 ff ff       	jmp    8010640d <alltraps>

80107176 <vector212>:
.globl vector212
vector212:
  pushl $0
80107176:	6a 00                	push   $0x0
  pushl $212
80107178:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010717d:	e9 8b f2 ff ff       	jmp    8010640d <alltraps>

80107182 <vector213>:
.globl vector213
vector213:
  pushl $0
80107182:	6a 00                	push   $0x0
  pushl $213
80107184:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80107189:	e9 7f f2 ff ff       	jmp    8010640d <alltraps>

8010718e <vector214>:
.globl vector214
vector214:
  pushl $0
8010718e:	6a 00                	push   $0x0
  pushl $214
80107190:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107195:	e9 73 f2 ff ff       	jmp    8010640d <alltraps>

8010719a <vector215>:
.globl vector215
vector215:
  pushl $0
8010719a:	6a 00                	push   $0x0
  pushl $215
8010719c:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801071a1:	e9 67 f2 ff ff       	jmp    8010640d <alltraps>

801071a6 <vector216>:
.globl vector216
vector216:
  pushl $0
801071a6:	6a 00                	push   $0x0
  pushl $216
801071a8:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801071ad:	e9 5b f2 ff ff       	jmp    8010640d <alltraps>

801071b2 <vector217>:
.globl vector217
vector217:
  pushl $0
801071b2:	6a 00                	push   $0x0
  pushl $217
801071b4:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801071b9:	e9 4f f2 ff ff       	jmp    8010640d <alltraps>

801071be <vector218>:
.globl vector218
vector218:
  pushl $0
801071be:	6a 00                	push   $0x0
  pushl $218
801071c0:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801071c5:	e9 43 f2 ff ff       	jmp    8010640d <alltraps>

801071ca <vector219>:
.globl vector219
vector219:
  pushl $0
801071ca:	6a 00                	push   $0x0
  pushl $219
801071cc:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801071d1:	e9 37 f2 ff ff       	jmp    8010640d <alltraps>

801071d6 <vector220>:
.globl vector220
vector220:
  pushl $0
801071d6:	6a 00                	push   $0x0
  pushl $220
801071d8:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801071dd:	e9 2b f2 ff ff       	jmp    8010640d <alltraps>

801071e2 <vector221>:
.globl vector221
vector221:
  pushl $0
801071e2:	6a 00                	push   $0x0
  pushl $221
801071e4:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801071e9:	e9 1f f2 ff ff       	jmp    8010640d <alltraps>

801071ee <vector222>:
.globl vector222
vector222:
  pushl $0
801071ee:	6a 00                	push   $0x0
  pushl $222
801071f0:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801071f5:	e9 13 f2 ff ff       	jmp    8010640d <alltraps>

801071fa <vector223>:
.globl vector223
vector223:
  pushl $0
801071fa:	6a 00                	push   $0x0
  pushl $223
801071fc:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107201:	e9 07 f2 ff ff       	jmp    8010640d <alltraps>

80107206 <vector224>:
.globl vector224
vector224:
  pushl $0
80107206:	6a 00                	push   $0x0
  pushl $224
80107208:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010720d:	e9 fb f1 ff ff       	jmp    8010640d <alltraps>

80107212 <vector225>:
.globl vector225
vector225:
  pushl $0
80107212:	6a 00                	push   $0x0
  pushl $225
80107214:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107219:	e9 ef f1 ff ff       	jmp    8010640d <alltraps>

8010721e <vector226>:
.globl vector226
vector226:
  pushl $0
8010721e:	6a 00                	push   $0x0
  pushl $226
80107220:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107225:	e9 e3 f1 ff ff       	jmp    8010640d <alltraps>

8010722a <vector227>:
.globl vector227
vector227:
  pushl $0
8010722a:	6a 00                	push   $0x0
  pushl $227
8010722c:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107231:	e9 d7 f1 ff ff       	jmp    8010640d <alltraps>

80107236 <vector228>:
.globl vector228
vector228:
  pushl $0
80107236:	6a 00                	push   $0x0
  pushl $228
80107238:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010723d:	e9 cb f1 ff ff       	jmp    8010640d <alltraps>

80107242 <vector229>:
.globl vector229
vector229:
  pushl $0
80107242:	6a 00                	push   $0x0
  pushl $229
80107244:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80107249:	e9 bf f1 ff ff       	jmp    8010640d <alltraps>

8010724e <vector230>:
.globl vector230
vector230:
  pushl $0
8010724e:	6a 00                	push   $0x0
  pushl $230
80107250:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107255:	e9 b3 f1 ff ff       	jmp    8010640d <alltraps>

8010725a <vector231>:
.globl vector231
vector231:
  pushl $0
8010725a:	6a 00                	push   $0x0
  pushl $231
8010725c:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107261:	e9 a7 f1 ff ff       	jmp    8010640d <alltraps>

80107266 <vector232>:
.globl vector232
vector232:
  pushl $0
80107266:	6a 00                	push   $0x0
  pushl $232
80107268:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010726d:	e9 9b f1 ff ff       	jmp    8010640d <alltraps>

80107272 <vector233>:
.globl vector233
vector233:
  pushl $0
80107272:	6a 00                	push   $0x0
  pushl $233
80107274:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107279:	e9 8f f1 ff ff       	jmp    8010640d <alltraps>

8010727e <vector234>:
.globl vector234
vector234:
  pushl $0
8010727e:	6a 00                	push   $0x0
  pushl $234
80107280:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107285:	e9 83 f1 ff ff       	jmp    8010640d <alltraps>

8010728a <vector235>:
.globl vector235
vector235:
  pushl $0
8010728a:	6a 00                	push   $0x0
  pushl $235
8010728c:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107291:	e9 77 f1 ff ff       	jmp    8010640d <alltraps>

80107296 <vector236>:
.globl vector236
vector236:
  pushl $0
80107296:	6a 00                	push   $0x0
  pushl $236
80107298:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010729d:	e9 6b f1 ff ff       	jmp    8010640d <alltraps>

801072a2 <vector237>:
.globl vector237
vector237:
  pushl $0
801072a2:	6a 00                	push   $0x0
  pushl $237
801072a4:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801072a9:	e9 5f f1 ff ff       	jmp    8010640d <alltraps>

801072ae <vector238>:
.globl vector238
vector238:
  pushl $0
801072ae:	6a 00                	push   $0x0
  pushl $238
801072b0:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801072b5:	e9 53 f1 ff ff       	jmp    8010640d <alltraps>

801072ba <vector239>:
.globl vector239
vector239:
  pushl $0
801072ba:	6a 00                	push   $0x0
  pushl $239
801072bc:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801072c1:	e9 47 f1 ff ff       	jmp    8010640d <alltraps>

801072c6 <vector240>:
.globl vector240
vector240:
  pushl $0
801072c6:	6a 00                	push   $0x0
  pushl $240
801072c8:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801072cd:	e9 3b f1 ff ff       	jmp    8010640d <alltraps>

801072d2 <vector241>:
.globl vector241
vector241:
  pushl $0
801072d2:	6a 00                	push   $0x0
  pushl $241
801072d4:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801072d9:	e9 2f f1 ff ff       	jmp    8010640d <alltraps>

801072de <vector242>:
.globl vector242
vector242:
  pushl $0
801072de:	6a 00                	push   $0x0
  pushl $242
801072e0:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801072e5:	e9 23 f1 ff ff       	jmp    8010640d <alltraps>

801072ea <vector243>:
.globl vector243
vector243:
  pushl $0
801072ea:	6a 00                	push   $0x0
  pushl $243
801072ec:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801072f1:	e9 17 f1 ff ff       	jmp    8010640d <alltraps>

801072f6 <vector244>:
.globl vector244
vector244:
  pushl $0
801072f6:	6a 00                	push   $0x0
  pushl $244
801072f8:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801072fd:	e9 0b f1 ff ff       	jmp    8010640d <alltraps>

80107302 <vector245>:
.globl vector245
vector245:
  pushl $0
80107302:	6a 00                	push   $0x0
  pushl $245
80107304:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107309:	e9 ff f0 ff ff       	jmp    8010640d <alltraps>

8010730e <vector246>:
.globl vector246
vector246:
  pushl $0
8010730e:	6a 00                	push   $0x0
  pushl $246
80107310:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107315:	e9 f3 f0 ff ff       	jmp    8010640d <alltraps>

8010731a <vector247>:
.globl vector247
vector247:
  pushl $0
8010731a:	6a 00                	push   $0x0
  pushl $247
8010731c:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107321:	e9 e7 f0 ff ff       	jmp    8010640d <alltraps>

80107326 <vector248>:
.globl vector248
vector248:
  pushl $0
80107326:	6a 00                	push   $0x0
  pushl $248
80107328:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010732d:	e9 db f0 ff ff       	jmp    8010640d <alltraps>

80107332 <vector249>:
.globl vector249
vector249:
  pushl $0
80107332:	6a 00                	push   $0x0
  pushl $249
80107334:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107339:	e9 cf f0 ff ff       	jmp    8010640d <alltraps>

8010733e <vector250>:
.globl vector250
vector250:
  pushl $0
8010733e:	6a 00                	push   $0x0
  pushl $250
80107340:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107345:	e9 c3 f0 ff ff       	jmp    8010640d <alltraps>

8010734a <vector251>:
.globl vector251
vector251:
  pushl $0
8010734a:	6a 00                	push   $0x0
  pushl $251
8010734c:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107351:	e9 b7 f0 ff ff       	jmp    8010640d <alltraps>

80107356 <vector252>:
.globl vector252
vector252:
  pushl $0
80107356:	6a 00                	push   $0x0
  pushl $252
80107358:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010735d:	e9 ab f0 ff ff       	jmp    8010640d <alltraps>

80107362 <vector253>:
.globl vector253
vector253:
  pushl $0
80107362:	6a 00                	push   $0x0
  pushl $253
80107364:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107369:	e9 9f f0 ff ff       	jmp    8010640d <alltraps>

8010736e <vector254>:
.globl vector254
vector254:
  pushl $0
8010736e:	6a 00                	push   $0x0
  pushl $254
80107370:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107375:	e9 93 f0 ff ff       	jmp    8010640d <alltraps>

8010737a <vector255>:
.globl vector255
vector255:
  pushl $0
8010737a:	6a 00                	push   $0x0
  pushl $255
8010737c:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107381:	e9 87 f0 ff ff       	jmp    8010640d <alltraps>
80107386:	66 90                	xchg   %ax,%ax
80107388:	66 90                	xchg   %ax,%ax
8010738a:	66 90                	xchg   %ax,%ax
8010738c:	66 90                	xchg   %ax,%ax
8010738e:	66 90                	xchg   %ax,%ax

80107390 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107390:	55                   	push   %ebp
80107391:	89 e5                	mov    %esp,%ebp
80107393:	83 ec 28             	sub    $0x28,%esp
80107396:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107399:	89 d3                	mov    %edx,%ebx
8010739b:	c1 eb 16             	shr    $0x16,%ebx
{
8010739e:	89 75 f8             	mov    %esi,-0x8(%ebp)
  pde = &pgdir[PDX(va)];
801073a1:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
801073a4:	89 7d fc             	mov    %edi,-0x4(%ebp)
801073a7:	89 d7                	mov    %edx,%edi
  if(*pde & PTE_P){
801073a9:	8b 06                	mov    (%esi),%eax
801073ab:	a8 01                	test   $0x1,%al
801073ad:	74 29                	je     801073d8 <walkpgdir+0x48>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801073af:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801073b4:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801073ba:	c1 ef 0a             	shr    $0xa,%edi
}
801073bd:	8b 75 f8             	mov    -0x8(%ebp),%esi
  return &pgtab[PTX(va)];
801073c0:	89 fa                	mov    %edi,%edx
}
801073c2:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return &pgtab[PTX(va)];
801073c5:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801073cb:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
801073ce:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801073d1:	89 ec                	mov    %ebp,%esp
801073d3:	5d                   	pop    %ebp
801073d4:	c3                   	ret    
801073d5:	8d 76 00             	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801073d8:	85 c9                	test   %ecx,%ecx
801073da:	74 34                	je     80107410 <walkpgdir+0x80>
801073dc:	e8 cf b1 ff ff       	call   801025b0 <kalloc>
801073e1:	85 c0                	test   %eax,%eax
801073e3:	89 c3                	mov    %eax,%ebx
801073e5:	74 29                	je     80107410 <walkpgdir+0x80>
    memset(pgtab, 0, PGSIZE);
801073e7:	b8 00 10 00 00       	mov    $0x1000,%eax
801073ec:	31 d2                	xor    %edx,%edx
801073ee:	89 44 24 08          	mov    %eax,0x8(%esp)
801073f2:	89 54 24 04          	mov    %edx,0x4(%esp)
801073f6:	89 1c 24             	mov    %ebx,(%esp)
801073f9:	e8 82 de ff ff       	call   80105280 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801073fe:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107404:	83 c8 07             	or     $0x7,%eax
80107407:	89 06                	mov    %eax,(%esi)
80107409:	eb af                	jmp    801073ba <walkpgdir+0x2a>
8010740b:	90                   	nop
8010740c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80107410:	8b 5d f4             	mov    -0xc(%ebp),%ebx
      return 0;
80107413:	31 c0                	xor    %eax,%eax
}
80107415:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107418:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010741b:	89 ec                	mov    %ebp,%esp
8010741d:	5d                   	pop    %ebp
8010741e:	c3                   	ret    
8010741f:	90                   	nop

80107420 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107420:	55                   	push   %ebp
80107421:	89 e5                	mov    %esp,%ebp
80107423:	57                   	push   %edi
80107424:	56                   	push   %esi
80107425:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107426:	89 d3                	mov    %edx,%ebx
{
80107428:	83 ec 2c             	sub    $0x2c,%esp
  a = (char*)PGROUNDDOWN((uint)va);
8010742b:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80107431:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107434:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107438:	8b 7d 08             	mov    0x8(%ebp),%edi
8010743b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107440:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80107443:	8b 45 0c             	mov    0xc(%ebp),%eax
80107446:	29 df                	sub    %ebx,%edi
80107448:	83 c8 01             	or     $0x1,%eax
8010744b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010744e:	eb 17                	jmp    80107467 <mappages+0x47>
    if(*pte & PTE_P)
80107450:	f6 00 01             	testb  $0x1,(%eax)
80107453:	75 45                	jne    8010749a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80107455:	8b 55 dc             	mov    -0x24(%ebp),%edx
80107458:	09 d6                	or     %edx,%esi
    if(a == last)
8010745a:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
8010745d:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010745f:	74 2f                	je     80107490 <mappages+0x70>
      break;
    a += PGSIZE;
80107461:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107467:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010746a:	b9 01 00 00 00       	mov    $0x1,%ecx
8010746f:	89 da                	mov    %ebx,%edx
80107471:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80107474:	e8 17 ff ff ff       	call   80107390 <walkpgdir>
80107479:	85 c0                	test   %eax,%eax
8010747b:	75 d3                	jne    80107450 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010747d:	83 c4 2c             	add    $0x2c,%esp
      return -1;
80107480:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107485:	5b                   	pop    %ebx
80107486:	5e                   	pop    %esi
80107487:	5f                   	pop    %edi
80107488:	5d                   	pop    %ebp
80107489:	c3                   	ret    
8010748a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107490:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80107493:	31 c0                	xor    %eax,%eax
}
80107495:	5b                   	pop    %ebx
80107496:	5e                   	pop    %esi
80107497:	5f                   	pop    %edi
80107498:	5d                   	pop    %ebp
80107499:	c3                   	ret    
      panic("remap");
8010749a:	c7 04 24 28 86 10 80 	movl   $0x80108628,(%esp)
801074a1:	e8 ca 8e ff ff       	call   80100370 <panic>
801074a6:	8d 76 00             	lea    0x0(%esi),%esi
801074a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801074b0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801074b0:	55                   	push   %ebp
801074b1:	89 e5                	mov    %esp,%ebp
801074b3:	57                   	push   %edi
801074b4:	89 c7                	mov    %eax,%edi
801074b6:	56                   	push   %esi
801074b7:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801074b8:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801074be:	83 ec 2c             	sub    $0x2c,%esp
  a = PGROUNDUP(newsz);
801074c1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801074c7:	39 d3                	cmp    %edx,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801074c9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801074cc:	73 62                	jae    80107530 <deallocuvm.part.0+0x80>
801074ce:	89 d6                	mov    %edx,%esi
801074d0:	eb 39                	jmp    8010750b <deallocuvm.part.0+0x5b>
801074d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
801074d8:	8b 10                	mov    (%eax),%edx
801074da:	f6 c2 01             	test   $0x1,%dl
801074dd:	74 22                	je     80107501 <deallocuvm.part.0+0x51>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801074df:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801074e5:	74 54                	je     8010753b <deallocuvm.part.0+0x8b>
        panic("kfree");
      char *v = P2V(pa);
801074e7:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
801074ed:	89 14 24             	mov    %edx,(%esp)
801074f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801074f3:	e8 e8 ae ff ff       	call   801023e0 <kfree>
      *pte = 0;
801074f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801074fb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80107501:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107507:	39 f3                	cmp    %esi,%ebx
80107509:	73 25                	jae    80107530 <deallocuvm.part.0+0x80>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010750b:	31 c9                	xor    %ecx,%ecx
8010750d:	89 da                	mov    %ebx,%edx
8010750f:	89 f8                	mov    %edi,%eax
80107511:	e8 7a fe ff ff       	call   80107390 <walkpgdir>
    if(!pte)
80107516:	85 c0                	test   %eax,%eax
80107518:	75 be                	jne    801074d8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010751a:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80107520:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107526:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010752c:	39 f3                	cmp    %esi,%ebx
8010752e:	72 db                	jb     8010750b <deallocuvm.part.0+0x5b>
    }
  }
  return newsz;
}
80107530:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107533:	83 c4 2c             	add    $0x2c,%esp
80107536:	5b                   	pop    %ebx
80107537:	5e                   	pop    %esi
80107538:	5f                   	pop    %edi
80107539:	5d                   	pop    %ebp
8010753a:	c3                   	ret    
        panic("kfree");
8010753b:	c7 04 24 46 7f 10 80 	movl   $0x80107f46,(%esp)
80107542:	e8 29 8e ff ff       	call   80100370 <panic>
80107547:	89 f6                	mov    %esi,%esi
80107549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107550 <seginit>:
{
80107550:	55                   	push   %ebp
80107551:	89 e5                	mov    %esp,%ebp
80107553:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107556:	e8 f5 c3 ff ff       	call   80103950 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010755b:	b9 00 9a cf 00       	mov    $0xcf9a00,%ecx
  pd[0] = size-1;
80107560:	66 c7 45 f2 2f 00    	movw   $0x2f,-0xe(%ebp)
80107566:	8d 14 80             	lea    (%eax,%eax,4),%edx
80107569:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010756c:	ba ff ff 00 00       	mov    $0xffff,%edx
80107571:	c1 e0 04             	shl    $0x4,%eax
80107574:	89 90 58 38 11 80    	mov    %edx,-0x7feec7a8(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010757a:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010757f:	89 88 5c 38 11 80    	mov    %ecx,-0x7feec7a4(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107585:	b9 00 92 cf 00       	mov    $0xcf9200,%ecx
8010758a:	89 90 60 38 11 80    	mov    %edx,-0x7feec7a0(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107590:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107595:	89 88 64 38 11 80    	mov    %ecx,-0x7feec79c(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010759b:	b9 00 fa cf 00       	mov    $0xcffa00,%ecx
801075a0:	89 90 68 38 11 80    	mov    %edx,-0x7feec798(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801075a6:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801075ab:	89 88 6c 38 11 80    	mov    %ecx,-0x7feec794(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801075b1:	b9 00 f2 cf 00       	mov    $0xcff200,%ecx
801075b6:	89 90 70 38 11 80    	mov    %edx,-0x7feec790(%eax)
801075bc:	89 88 74 38 11 80    	mov    %ecx,-0x7feec78c(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
801075c2:	05 50 38 11 80       	add    $0x80113850,%eax
  pd[1] = (uint)p;
801075c7:	0f b7 d0             	movzwl %ax,%edx
  pd[2] = (uint)p >> 16;
801075ca:	c1 e8 10             	shr    $0x10,%eax
  pd[1] = (uint)p;
801075cd:	66 89 55 f4          	mov    %dx,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801075d1:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801075d5:	8d 45 f2             	lea    -0xe(%ebp),%eax
801075d8:	0f 01 10             	lgdtl  (%eax)
}
801075db:	c9                   	leave  
801075dc:	c3                   	ret    
801075dd:	8d 76 00             	lea    0x0(%esi),%esi

801075e0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801075e0:	a1 04 65 11 80       	mov    0x80116504,%eax
{
801075e5:	55                   	push   %ebp
801075e6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801075e8:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801075ed:	0f 22 d8             	mov    %eax,%cr3
}
801075f0:	5d                   	pop    %ebp
801075f1:	c3                   	ret    
801075f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801075f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107600 <switchuvm>:
{
80107600:	55                   	push   %ebp
80107601:	89 e5                	mov    %esp,%ebp
80107603:	57                   	push   %edi
80107604:	56                   	push   %esi
80107605:	53                   	push   %ebx
80107606:	83 ec 2c             	sub    $0x2c,%esp
80107609:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
8010760c:	85 db                	test   %ebx,%ebx
8010760e:	0f 84 c5 00 00 00    	je     801076d9 <switchuvm+0xd9>
  if(p->kstack == 0)
80107614:	8b 7b 08             	mov    0x8(%ebx),%edi
80107617:	85 ff                	test   %edi,%edi
80107619:	0f 84 d2 00 00 00    	je     801076f1 <switchuvm+0xf1>
  if(p->pgdir == 0)
8010761f:	8b 73 04             	mov    0x4(%ebx),%esi
80107622:	85 f6                	test   %esi,%esi
80107624:	0f 84 bb 00 00 00    	je     801076e5 <switchuvm+0xe5>
  pushcli();
8010762a:	e8 81 da ff ff       	call   801050b0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010762f:	e8 9c c2 ff ff       	call   801038d0 <mycpu>
80107634:	89 c6                	mov    %eax,%esi
80107636:	e8 95 c2 ff ff       	call   801038d0 <mycpu>
8010763b:	89 c7                	mov    %eax,%edi
8010763d:	e8 8e c2 ff ff       	call   801038d0 <mycpu>
80107642:	83 c7 08             	add    $0x8,%edi
80107645:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107648:	e8 83 c2 ff ff       	call   801038d0 <mycpu>
8010764d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107650:	ba 67 00 00 00       	mov    $0x67,%edx
80107655:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
8010765c:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80107663:	83 c1 08             	add    $0x8,%ecx
80107666:	c1 e9 10             	shr    $0x10,%ecx
80107669:	83 c0 08             	add    $0x8,%eax
8010766c:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80107672:	c1 e8 18             	shr    $0x18,%eax
80107675:	b9 99 40 00 00       	mov    $0x4099,%ecx
8010767a:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
80107681:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->gdt[SEG_TSS].s = 0;
80107687:	e8 44 c2 ff ff       	call   801038d0 <mycpu>
8010768c:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107693:	e8 38 c2 ff ff       	call   801038d0 <mycpu>
80107698:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
8010769e:	8b 73 08             	mov    0x8(%ebx),%esi
801076a1:	e8 2a c2 ff ff       	call   801038d0 <mycpu>
801076a6:	81 c6 00 10 00 00    	add    $0x1000,%esi
801076ac:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801076af:	e8 1c c2 ff ff       	call   801038d0 <mycpu>
801076b4:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801076ba:	b8 28 00 00 00       	mov    $0x28,%eax
801076bf:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
801076c2:	8b 43 04             	mov    0x4(%ebx),%eax
801076c5:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801076ca:	0f 22 d8             	mov    %eax,%cr3
}
801076cd:	83 c4 2c             	add    $0x2c,%esp
801076d0:	5b                   	pop    %ebx
801076d1:	5e                   	pop    %esi
801076d2:	5f                   	pop    %edi
801076d3:	5d                   	pop    %ebp
  popcli();
801076d4:	e9 17 da ff ff       	jmp    801050f0 <popcli>
    panic("switchuvm: no process");
801076d9:	c7 04 24 2e 86 10 80 	movl   $0x8010862e,(%esp)
801076e0:	e8 8b 8c ff ff       	call   80100370 <panic>
    panic("switchuvm: no pgdir");
801076e5:	c7 04 24 59 86 10 80 	movl   $0x80108659,(%esp)
801076ec:	e8 7f 8c ff ff       	call   80100370 <panic>
    panic("switchuvm: no kstack");
801076f1:	c7 04 24 44 86 10 80 	movl   $0x80108644,(%esp)
801076f8:	e8 73 8c ff ff       	call   80100370 <panic>
801076fd:	8d 76 00             	lea    0x0(%esi),%esi

80107700 <inituvm>:
{
80107700:	55                   	push   %ebp
80107701:	89 e5                	mov    %esp,%ebp
80107703:	83 ec 38             	sub    $0x38,%esp
80107706:	89 75 f8             	mov    %esi,-0x8(%ebp)
80107709:	8b 75 10             	mov    0x10(%ebp),%esi
8010770c:	8b 45 08             	mov    0x8(%ebp),%eax
8010770f:	89 7d fc             	mov    %edi,-0x4(%ebp)
80107712:	8b 7d 0c             	mov    0xc(%ebp),%edi
80107715:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  if(sz >= PGSIZE)
80107718:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
8010771e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107721:	77 59                	ja     8010777c <inituvm+0x7c>
  mem = kalloc();
80107723:	e8 88 ae ff ff       	call   801025b0 <kalloc>
  memset(mem, 0, PGSIZE);
80107728:	31 d2                	xor    %edx,%edx
8010772a:	89 54 24 04          	mov    %edx,0x4(%esp)
  mem = kalloc();
8010772e:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107730:	b8 00 10 00 00       	mov    $0x1000,%eax
80107735:	89 1c 24             	mov    %ebx,(%esp)
80107738:	89 44 24 08          	mov    %eax,0x8(%esp)
8010773c:	e8 3f db ff ff       	call   80105280 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107741:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107747:	b9 06 00 00 00       	mov    $0x6,%ecx
8010774c:	89 04 24             	mov    %eax,(%esp)
8010774f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107752:	31 d2                	xor    %edx,%edx
80107754:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80107758:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010775d:	e8 be fc ff ff       	call   80107420 <mappages>
  memmove(mem, init, sz);
80107762:	89 75 10             	mov    %esi,0x10(%ebp)
}
80107765:	8b 75 f8             	mov    -0x8(%ebp),%esi
  memmove(mem, init, sz);
80107768:	89 7d 0c             	mov    %edi,0xc(%ebp)
}
8010776b:	8b 7d fc             	mov    -0x4(%ebp),%edi
  memmove(mem, init, sz);
8010776e:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80107771:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107774:	89 ec                	mov    %ebp,%esp
80107776:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107777:	e9 c4 db ff ff       	jmp    80105340 <memmove>
    panic("inituvm: more than a page");
8010777c:	c7 04 24 6d 86 10 80 	movl   $0x8010866d,(%esp)
80107783:	e8 e8 8b ff ff       	call   80100370 <panic>
80107788:	90                   	nop
80107789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107790 <loaduvm>:
{
80107790:	55                   	push   %ebp
80107791:	89 e5                	mov    %esp,%ebp
80107793:	57                   	push   %edi
80107794:	56                   	push   %esi
80107795:	53                   	push   %ebx
80107796:	83 ec 1c             	sub    $0x1c,%esp
  if((uint) addr % PGSIZE != 0)
80107799:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
801077a0:	0f 85 98 00 00 00    	jne    8010783e <loaduvm+0xae>
  for(i = 0; i < sz; i += PGSIZE){
801077a6:	8b 75 18             	mov    0x18(%ebp),%esi
801077a9:	31 db                	xor    %ebx,%ebx
801077ab:	85 f6                	test   %esi,%esi
801077ad:	75 1a                	jne    801077c9 <loaduvm+0x39>
801077af:	eb 77                	jmp    80107828 <loaduvm+0x98>
801077b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801077b8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801077be:	81 ee 00 10 00 00    	sub    $0x1000,%esi
801077c4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
801077c7:	76 5f                	jbe    80107828 <loaduvm+0x98>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801077c9:	8b 55 0c             	mov    0xc(%ebp),%edx
801077cc:	31 c9                	xor    %ecx,%ecx
801077ce:	8b 45 08             	mov    0x8(%ebp),%eax
801077d1:	01 da                	add    %ebx,%edx
801077d3:	e8 b8 fb ff ff       	call   80107390 <walkpgdir>
801077d8:	85 c0                	test   %eax,%eax
801077da:	74 56                	je     80107832 <loaduvm+0xa2>
    pa = PTE_ADDR(*pte);
801077dc:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
801077de:	bf 00 10 00 00       	mov    $0x1000,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801077e3:	8b 4d 14             	mov    0x14(%ebp),%ecx
    pa = PTE_ADDR(*pte);
801077e6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801077eb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801077f1:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801077f4:	05 00 00 00 80       	add    $0x80000000,%eax
801077f9:	89 44 24 04          	mov    %eax,0x4(%esp)
801077fd:	8b 45 10             	mov    0x10(%ebp),%eax
80107800:	01 d9                	add    %ebx,%ecx
80107802:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80107806:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010780a:	89 04 24             	mov    %eax,(%esp)
8010780d:	e8 be a1 ff ff       	call   801019d0 <readi>
80107812:	39 f8                	cmp    %edi,%eax
80107814:	74 a2                	je     801077b8 <loaduvm+0x28>
}
80107816:	83 c4 1c             	add    $0x1c,%esp
      return -1;
80107819:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010781e:	5b                   	pop    %ebx
8010781f:	5e                   	pop    %esi
80107820:	5f                   	pop    %edi
80107821:	5d                   	pop    %ebp
80107822:	c3                   	ret    
80107823:	90                   	nop
80107824:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107828:	83 c4 1c             	add    $0x1c,%esp
  return 0;
8010782b:	31 c0                	xor    %eax,%eax
}
8010782d:	5b                   	pop    %ebx
8010782e:	5e                   	pop    %esi
8010782f:	5f                   	pop    %edi
80107830:	5d                   	pop    %ebp
80107831:	c3                   	ret    
      panic("loaduvm: address should exist");
80107832:	c7 04 24 87 86 10 80 	movl   $0x80108687,(%esp)
80107839:	e8 32 8b ff ff       	call   80100370 <panic>
    panic("loaduvm: addr must be page aligned");
8010783e:	c7 04 24 28 87 10 80 	movl   $0x80108728,(%esp)
80107845:	e8 26 8b ff ff       	call   80100370 <panic>
8010784a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107850 <allocuvm>:
{
80107850:	55                   	push   %ebp
80107851:	89 e5                	mov    %esp,%ebp
80107853:	57                   	push   %edi
80107854:	56                   	push   %esi
80107855:	53                   	push   %ebx
80107856:	83 ec 2c             	sub    $0x2c,%esp
  if(newsz >= KERNBASE)
80107859:	8b 7d 10             	mov    0x10(%ebp),%edi
8010785c:	85 ff                	test   %edi,%edi
8010785e:	0f 88 91 00 00 00    	js     801078f5 <allocuvm+0xa5>
  if(newsz < oldsz)
80107864:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80107867:	0f 82 9b 00 00 00    	jb     80107908 <allocuvm+0xb8>
  a = PGROUNDUP(oldsz);
8010786d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107870:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80107876:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010787c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010787f:	0f 86 86 00 00 00    	jbe    8010790b <allocuvm+0xbb>
80107885:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80107888:	8b 7d 08             	mov    0x8(%ebp),%edi
8010788b:	eb 49                	jmp    801078d6 <allocuvm+0x86>
8010788d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80107890:	31 d2                	xor    %edx,%edx
80107892:	b8 00 10 00 00       	mov    $0x1000,%eax
80107897:	89 54 24 04          	mov    %edx,0x4(%esp)
8010789b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010789f:	89 34 24             	mov    %esi,(%esp)
801078a2:	e8 d9 d9 ff ff       	call   80105280 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801078a7:	b9 06 00 00 00       	mov    $0x6,%ecx
801078ac:	89 da                	mov    %ebx,%edx
801078ae:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801078b4:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801078b8:	b9 00 10 00 00       	mov    $0x1000,%ecx
801078bd:	89 04 24             	mov    %eax,(%esp)
801078c0:	89 f8                	mov    %edi,%eax
801078c2:	e8 59 fb ff ff       	call   80107420 <mappages>
801078c7:	85 c0                	test   %eax,%eax
801078c9:	78 4d                	js     80107918 <allocuvm+0xc8>
  for(; a < newsz; a += PGSIZE){
801078cb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801078d1:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801078d4:	76 7a                	jbe    80107950 <allocuvm+0x100>
    mem = kalloc();
801078d6:	e8 d5 ac ff ff       	call   801025b0 <kalloc>
    if(mem == 0){
801078db:	85 c0                	test   %eax,%eax
    mem = kalloc();
801078dd:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801078df:	75 af                	jne    80107890 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
801078e1:	c7 04 24 a5 86 10 80 	movl   $0x801086a5,(%esp)
801078e8:	e8 63 8d ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
801078ed:	8b 45 0c             	mov    0xc(%ebp),%eax
801078f0:	39 45 10             	cmp    %eax,0x10(%ebp)
801078f3:	77 6b                	ja     80107960 <allocuvm+0x110>
}
801078f5:	83 c4 2c             	add    $0x2c,%esp
    return 0;
801078f8:	31 ff                	xor    %edi,%edi
}
801078fa:	5b                   	pop    %ebx
801078fb:	89 f8                	mov    %edi,%eax
801078fd:	5e                   	pop    %esi
801078fe:	5f                   	pop    %edi
801078ff:	5d                   	pop    %ebp
80107900:	c3                   	ret    
80107901:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107908:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
8010790b:	83 c4 2c             	add    $0x2c,%esp
8010790e:	89 f8                	mov    %edi,%eax
80107910:	5b                   	pop    %ebx
80107911:	5e                   	pop    %esi
80107912:	5f                   	pop    %edi
80107913:	5d                   	pop    %ebp
80107914:	c3                   	ret    
80107915:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107918:	c7 04 24 bd 86 10 80 	movl   $0x801086bd,(%esp)
8010791f:	e8 2c 8d ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
80107924:	8b 45 0c             	mov    0xc(%ebp),%eax
80107927:	39 45 10             	cmp    %eax,0x10(%ebp)
8010792a:	76 0d                	jbe    80107939 <allocuvm+0xe9>
8010792c:	89 c1                	mov    %eax,%ecx
8010792e:	8b 55 10             	mov    0x10(%ebp),%edx
80107931:	8b 45 08             	mov    0x8(%ebp),%eax
80107934:	e8 77 fb ff ff       	call   801074b0 <deallocuvm.part.0>
      kfree(mem);
80107939:	89 34 24             	mov    %esi,(%esp)
      return 0;
8010793c:	31 ff                	xor    %edi,%edi
      kfree(mem);
8010793e:	e8 9d aa ff ff       	call   801023e0 <kfree>
}
80107943:	83 c4 2c             	add    $0x2c,%esp
80107946:	89 f8                	mov    %edi,%eax
80107948:	5b                   	pop    %ebx
80107949:	5e                   	pop    %esi
8010794a:	5f                   	pop    %edi
8010794b:	5d                   	pop    %ebp
8010794c:	c3                   	ret    
8010794d:	8d 76 00             	lea    0x0(%esi),%esi
80107950:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80107953:	83 c4 2c             	add    $0x2c,%esp
80107956:	5b                   	pop    %ebx
80107957:	5e                   	pop    %esi
80107958:	89 f8                	mov    %edi,%eax
8010795a:	5f                   	pop    %edi
8010795b:	5d                   	pop    %ebp
8010795c:	c3                   	ret    
8010795d:	8d 76 00             	lea    0x0(%esi),%esi
80107960:	89 c1                	mov    %eax,%ecx
80107962:	8b 55 10             	mov    0x10(%ebp),%edx
      return 0;
80107965:	31 ff                	xor    %edi,%edi
80107967:	8b 45 08             	mov    0x8(%ebp),%eax
8010796a:	e8 41 fb ff ff       	call   801074b0 <deallocuvm.part.0>
8010796f:	eb 9a                	jmp    8010790b <allocuvm+0xbb>
80107971:	eb 0d                	jmp    80107980 <deallocuvm>
80107973:	90                   	nop
80107974:	90                   	nop
80107975:	90                   	nop
80107976:	90                   	nop
80107977:	90                   	nop
80107978:	90                   	nop
80107979:	90                   	nop
8010797a:	90                   	nop
8010797b:	90                   	nop
8010797c:	90                   	nop
8010797d:	90                   	nop
8010797e:	90                   	nop
8010797f:	90                   	nop

80107980 <deallocuvm>:
{
80107980:	55                   	push   %ebp
80107981:	89 e5                	mov    %esp,%ebp
80107983:	8b 55 0c             	mov    0xc(%ebp),%edx
80107986:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107989:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010798c:	39 d1                	cmp    %edx,%ecx
8010798e:	73 10                	jae    801079a0 <deallocuvm+0x20>
}
80107990:	5d                   	pop    %ebp
80107991:	e9 1a fb ff ff       	jmp    801074b0 <deallocuvm.part.0>
80107996:	8d 76 00             	lea    0x0(%esi),%esi
80107999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801079a0:	89 d0                	mov    %edx,%eax
801079a2:	5d                   	pop    %ebp
801079a3:	c3                   	ret    
801079a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801079aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801079b0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801079b0:	55                   	push   %ebp
801079b1:	89 e5                	mov    %esp,%ebp
801079b3:	57                   	push   %edi
801079b4:	56                   	push   %esi
801079b5:	53                   	push   %ebx
801079b6:	83 ec 1c             	sub    $0x1c,%esp
801079b9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801079bc:	85 f6                	test   %esi,%esi
801079be:	74 55                	je     80107a15 <freevm+0x65>
801079c0:	31 c9                	xor    %ecx,%ecx
801079c2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801079c7:	89 f0                	mov    %esi,%eax
801079c9:	89 f3                	mov    %esi,%ebx
801079cb:	e8 e0 fa ff ff       	call   801074b0 <deallocuvm.part.0>
801079d0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801079d6:	eb 0f                	jmp    801079e7 <freevm+0x37>
801079d8:	90                   	nop
801079d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801079e0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801079e3:	39 fb                	cmp    %edi,%ebx
801079e5:	74 1f                	je     80107a06 <freevm+0x56>
    if(pgdir[i] & PTE_P){
801079e7:	8b 03                	mov    (%ebx),%eax
801079e9:	a8 01                	test   $0x1,%al
801079eb:	74 f3                	je     801079e0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801079ed:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801079f2:	83 c3 04             	add    $0x4,%ebx
801079f5:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801079fa:	89 04 24             	mov    %eax,(%esp)
801079fd:	e8 de a9 ff ff       	call   801023e0 <kfree>
  for(i = 0; i < NPDENTRIES; i++){
80107a02:	39 fb                	cmp    %edi,%ebx
80107a04:	75 e1                	jne    801079e7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80107a06:	89 75 08             	mov    %esi,0x8(%ebp)
}
80107a09:	83 c4 1c             	add    $0x1c,%esp
80107a0c:	5b                   	pop    %ebx
80107a0d:	5e                   	pop    %esi
80107a0e:	5f                   	pop    %edi
80107a0f:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107a10:	e9 cb a9 ff ff       	jmp    801023e0 <kfree>
    panic("freevm: no pgdir");
80107a15:	c7 04 24 d9 86 10 80 	movl   $0x801086d9,(%esp)
80107a1c:	e8 4f 89 ff ff       	call   80100370 <panic>
80107a21:	eb 0d                	jmp    80107a30 <setupkvm>
80107a23:	90                   	nop
80107a24:	90                   	nop
80107a25:	90                   	nop
80107a26:	90                   	nop
80107a27:	90                   	nop
80107a28:	90                   	nop
80107a29:	90                   	nop
80107a2a:	90                   	nop
80107a2b:	90                   	nop
80107a2c:	90                   	nop
80107a2d:	90                   	nop
80107a2e:	90                   	nop
80107a2f:	90                   	nop

80107a30 <setupkvm>:
{
80107a30:	55                   	push   %ebp
80107a31:	89 e5                	mov    %esp,%ebp
80107a33:	56                   	push   %esi
80107a34:	53                   	push   %ebx
80107a35:	83 ec 10             	sub    $0x10,%esp
  if((pgdir = (pde_t*)kalloc()) == 0)
80107a38:	e8 73 ab ff ff       	call   801025b0 <kalloc>
80107a3d:	85 c0                	test   %eax,%eax
80107a3f:	89 c6                	mov    %eax,%esi
80107a41:	74 46                	je     80107a89 <setupkvm+0x59>
  memset(pgdir, 0, PGSIZE);
80107a43:	b8 00 10 00 00       	mov    $0x1000,%eax
80107a48:	31 d2                	xor    %edx,%edx
80107a4a:	89 44 24 08          	mov    %eax,0x8(%esp)
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107a4e:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107a53:	89 54 24 04          	mov    %edx,0x4(%esp)
80107a57:	89 34 24             	mov    %esi,(%esp)
80107a5a:	e8 21 d8 ff ff       	call   80105280 <memset>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107a5f:	8b 53 0c             	mov    0xc(%ebx),%edx
                (uint)k->phys_start, k->perm) < 0) {
80107a62:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107a65:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107a68:	89 54 24 04          	mov    %edx,0x4(%esp)
80107a6c:	8b 13                	mov    (%ebx),%edx
80107a6e:	89 04 24             	mov    %eax,(%esp)
80107a71:	29 c1                	sub    %eax,%ecx
80107a73:	89 f0                	mov    %esi,%eax
80107a75:	e8 a6 f9 ff ff       	call   80107420 <mappages>
80107a7a:	85 c0                	test   %eax,%eax
80107a7c:	78 1a                	js     80107a98 <setupkvm+0x68>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107a7e:	83 c3 10             	add    $0x10,%ebx
80107a81:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107a87:	75 d6                	jne    80107a5f <setupkvm+0x2f>
}
80107a89:	83 c4 10             	add    $0x10,%esp
80107a8c:	89 f0                	mov    %esi,%eax
80107a8e:	5b                   	pop    %ebx
80107a8f:	5e                   	pop    %esi
80107a90:	5d                   	pop    %ebp
80107a91:	c3                   	ret    
80107a92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      freevm(pgdir);
80107a98:	89 34 24             	mov    %esi,(%esp)
      return 0;
80107a9b:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107a9d:	e8 0e ff ff ff       	call   801079b0 <freevm>
}
80107aa2:	83 c4 10             	add    $0x10,%esp
80107aa5:	89 f0                	mov    %esi,%eax
80107aa7:	5b                   	pop    %ebx
80107aa8:	5e                   	pop    %esi
80107aa9:	5d                   	pop    %ebp
80107aaa:	c3                   	ret    
80107aab:	90                   	nop
80107aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107ab0 <kvmalloc>:
{
80107ab0:	55                   	push   %ebp
80107ab1:	89 e5                	mov    %esp,%ebp
80107ab3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107ab6:	e8 75 ff ff ff       	call   80107a30 <setupkvm>
80107abb:	a3 04 65 11 80       	mov    %eax,0x80116504
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107ac0:	05 00 00 00 80       	add    $0x80000000,%eax
80107ac5:	0f 22 d8             	mov    %eax,%cr3
}
80107ac8:	c9                   	leave  
80107ac9:	c3                   	ret    
80107aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107ad0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107ad0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107ad1:	31 c9                	xor    %ecx,%ecx
{
80107ad3:	89 e5                	mov    %esp,%ebp
80107ad5:	83 ec 18             	sub    $0x18,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107ad8:	8b 55 0c             	mov    0xc(%ebp),%edx
80107adb:	8b 45 08             	mov    0x8(%ebp),%eax
80107ade:	e8 ad f8 ff ff       	call   80107390 <walkpgdir>
  if(pte == 0)
80107ae3:	85 c0                	test   %eax,%eax
80107ae5:	74 05                	je     80107aec <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107ae7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107aea:	c9                   	leave  
80107aeb:	c3                   	ret    
    panic("clearpteu");
80107aec:	c7 04 24 ea 86 10 80 	movl   $0x801086ea,(%esp)
80107af3:	e8 78 88 ff ff       	call   80100370 <panic>
80107af8:	90                   	nop
80107af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107b00 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107b00:	55                   	push   %ebp
80107b01:	89 e5                	mov    %esp,%ebp
80107b03:	57                   	push   %edi
80107b04:	56                   	push   %esi
80107b05:	53                   	push   %ebx
80107b06:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107b09:	e8 22 ff ff ff       	call   80107a30 <setupkvm>
80107b0e:	85 c0                	test   %eax,%eax
80107b10:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107b13:	0f 84 a3 00 00 00    	je     80107bbc <copyuvm+0xbc>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107b19:	8b 55 0c             	mov    0xc(%ebp),%edx
80107b1c:	85 d2                	test   %edx,%edx
80107b1e:	0f 84 98 00 00 00    	je     80107bbc <copyuvm+0xbc>
80107b24:	31 ff                	xor    %edi,%edi
80107b26:	eb 50                	jmp    80107b78 <copyuvm+0x78>
80107b28:	90                   	nop
80107b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107b30:	b8 00 10 00 00       	mov    $0x1000,%eax
80107b35:	89 44 24 08          	mov    %eax,0x8(%esp)
80107b39:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107b3c:	89 34 24             	mov    %esi,(%esp)
80107b3f:	05 00 00 00 80       	add    $0x80000000,%eax
80107b44:	89 44 24 04          	mov    %eax,0x4(%esp)
80107b48:	e8 f3 d7 ff ff       	call   80105340 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107b4d:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107b53:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107b58:	89 04 24             	mov    %eax,(%esp)
80107b5b:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107b5e:	89 fa                	mov    %edi,%edx
80107b60:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80107b64:	e8 b7 f8 ff ff       	call   80107420 <mappages>
80107b69:	85 c0                	test   %eax,%eax
80107b6b:	78 63                	js     80107bd0 <copyuvm+0xd0>
  for(i = 0; i < sz; i += PGSIZE){
80107b6d:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107b73:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80107b76:	76 44                	jbe    80107bbc <copyuvm+0xbc>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107b78:	8b 45 08             	mov    0x8(%ebp),%eax
80107b7b:	31 c9                	xor    %ecx,%ecx
80107b7d:	89 fa                	mov    %edi,%edx
80107b7f:	e8 0c f8 ff ff       	call   80107390 <walkpgdir>
80107b84:	85 c0                	test   %eax,%eax
80107b86:	74 5e                	je     80107be6 <copyuvm+0xe6>
    if(!(*pte & PTE_P))
80107b88:	8b 18                	mov    (%eax),%ebx
80107b8a:	f6 c3 01             	test   $0x1,%bl
80107b8d:	74 4b                	je     80107bda <copyuvm+0xda>
    pa = PTE_ADDR(*pte);
80107b8f:	89 d8                	mov    %ebx,%eax
    flags = PTE_FLAGS(*pte);
80107b91:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
80107b97:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107b9c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80107b9f:	e8 0c aa ff ff       	call   801025b0 <kalloc>
80107ba4:	85 c0                	test   %eax,%eax
80107ba6:	89 c6                	mov    %eax,%esi
80107ba8:	75 86                	jne    80107b30 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80107baa:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107bad:	89 04 24             	mov    %eax,(%esp)
80107bb0:	e8 fb fd ff ff       	call   801079b0 <freevm>
  return 0;
80107bb5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107bbc:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107bbf:	83 c4 2c             	add    $0x2c,%esp
80107bc2:	5b                   	pop    %ebx
80107bc3:	5e                   	pop    %esi
80107bc4:	5f                   	pop    %edi
80107bc5:	5d                   	pop    %ebp
80107bc6:	c3                   	ret    
80107bc7:	89 f6                	mov    %esi,%esi
80107bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      kfree(mem);
80107bd0:	89 34 24             	mov    %esi,(%esp)
80107bd3:	e8 08 a8 ff ff       	call   801023e0 <kfree>
      goto bad;
80107bd8:	eb d0                	jmp    80107baa <copyuvm+0xaa>
      panic("copyuvm: page not present");
80107bda:	c7 04 24 0e 87 10 80 	movl   $0x8010870e,(%esp)
80107be1:	e8 8a 87 ff ff       	call   80100370 <panic>
      panic("copyuvm: pte should exist");
80107be6:	c7 04 24 f4 86 10 80 	movl   $0x801086f4,(%esp)
80107bed:	e8 7e 87 ff ff       	call   80100370 <panic>
80107bf2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107c00 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107c00:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107c01:	31 c9                	xor    %ecx,%ecx
{
80107c03:	89 e5                	mov    %esp,%ebp
80107c05:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107c08:	8b 55 0c             	mov    0xc(%ebp),%edx
80107c0b:	8b 45 08             	mov    0x8(%ebp),%eax
80107c0e:	e8 7d f7 ff ff       	call   80107390 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107c13:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80107c15:	89 c2                	mov    %eax,%edx
80107c17:	83 e2 05             	and    $0x5,%edx
80107c1a:	83 fa 05             	cmp    $0x5,%edx
80107c1d:	75 11                	jne    80107c30 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80107c1f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107c24:	05 00 00 00 80       	add    $0x80000000,%eax
}
80107c29:	c9                   	leave  
80107c2a:	c3                   	ret    
80107c2b:	90                   	nop
80107c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80107c30:	31 c0                	xor    %eax,%eax
}
80107c32:	c9                   	leave  
80107c33:	c3                   	ret    
80107c34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107c3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107c40 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107c40:	55                   	push   %ebp
80107c41:	89 e5                	mov    %esp,%ebp
80107c43:	57                   	push   %edi
80107c44:	56                   	push   %esi
80107c45:	53                   	push   %ebx
80107c46:	83 ec 2c             	sub    $0x2c,%esp
80107c49:	8b 75 14             	mov    0x14(%ebp),%esi
80107c4c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107c4f:	85 f6                	test   %esi,%esi
80107c51:	74 75                	je     80107cc8 <copyout+0x88>
80107c53:	89 da                	mov    %ebx,%edx
80107c55:	eb 3f                	jmp    80107c96 <copyout+0x56>
80107c57:	89 f6                	mov    %esi,%esi
80107c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107c60:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107c63:	89 df                	mov    %ebx,%edi
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107c65:	8b 4d 10             	mov    0x10(%ebp),%ecx
    n = PGSIZE - (va - va0);
80107c68:	29 d7                	sub    %edx,%edi
80107c6a:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107c70:	39 f7                	cmp    %esi,%edi
80107c72:	0f 47 fe             	cmova  %esi,%edi
    memmove(pa0 + (va - va0), buf, n);
80107c75:	29 da                	sub    %ebx,%edx
80107c77:	01 c2                	add    %eax,%edx
80107c79:	89 14 24             	mov    %edx,(%esp)
80107c7c:	89 7c 24 08          	mov    %edi,0x8(%esp)
80107c80:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80107c84:	e8 b7 d6 ff ff       	call   80105340 <memmove>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
80107c89:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    buf += n;
80107c8f:	01 7d 10             	add    %edi,0x10(%ebp)
  while(len > 0){
80107c92:	29 fe                	sub    %edi,%esi
80107c94:	74 32                	je     80107cc8 <copyout+0x88>
    pa0 = uva2ka(pgdir, (char*)va0);
80107c96:	8b 45 08             	mov    0x8(%ebp),%eax
    va0 = (uint)PGROUNDDOWN(va);
80107c99:	89 d3                	mov    %edx,%ebx
80107c9b:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    pa0 = uva2ka(pgdir, (char*)va0);
80107ca1:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    va0 = (uint)PGROUNDDOWN(va);
80107ca5:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80107ca8:	89 04 24             	mov    %eax,(%esp)
80107cab:	e8 50 ff ff ff       	call   80107c00 <uva2ka>
    if(pa0 == 0)
80107cb0:	85 c0                	test   %eax,%eax
80107cb2:	75 ac                	jne    80107c60 <copyout+0x20>
  }
  return 0;
}
80107cb4:	83 c4 2c             	add    $0x2c,%esp
      return -1;
80107cb7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107cbc:	5b                   	pop    %ebx
80107cbd:	5e                   	pop    %esi
80107cbe:	5f                   	pop    %edi
80107cbf:	5d                   	pop    %ebp
80107cc0:	c3                   	ret    
80107cc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107cc8:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80107ccb:	31 c0                	xor    %eax,%eax
}
80107ccd:	5b                   	pop    %ebx
80107cce:	5e                   	pop    %esi
80107ccf:	5f                   	pop    %edi
80107cd0:	5d                   	pop    %ebp
80107cd1:	c3                   	ret    
