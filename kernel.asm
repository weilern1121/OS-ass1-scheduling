
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
8010002d:	b8 e0 2e 10 80       	mov    $0x80102ee0,%eax
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
80100041:	ba e0 86 10 80       	mov    $0x801086e0,%edx
  struct buf head;
} bcache;

void
binit(void)
{
80100046:	89 e5                	mov    %esp,%ebp
80100048:	53                   	push   %ebx
  initlock(&bcache.lock, "bcache");

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
80100049:	bb 1c 1d 11 80       	mov    $0x80111d1c,%ebx
  struct buf head;
} bcache;

void
binit(void)
{
8010004e:	83 ec 14             	sub    $0x14,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
80100051:	89 54 24 04          	mov    %edx,0x4(%esp)
80100055:	c7 04 24 20 d6 10 80 	movl   $0x8010d620,(%esp)
8010005c:	e8 0f 58 00 00       	call   80105870 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
80100061:	b9 1c 1d 11 80       	mov    $0x80111d1c,%ecx
  bcache.head.next = &bcache.head;
80100066:	ba 1c 1d 11 80       	mov    $0x80111d1c,%edx
8010006b:	89 1d 70 1d 11 80    	mov    %ebx,0x80111d70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100071:	bb 54 d6 10 80       	mov    $0x8010d654,%ebx

  initlock(&bcache.lock, "bcache");

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
80100076:	89 0d 6c 1d 11 80    	mov    %ecx,0x80111d6c
8010007c:	eb 04                	jmp    80100082 <binit+0x42>
8010007e:	66 90                	xchg   %ax,%ax
80100080:	89 c3                	mov    %eax,%ebx
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	b8 e7 86 10 80       	mov    $0x801086e7,%eax
//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
80100087:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008a:	c7 43 50 1c 1d 11 80 	movl   $0x80111d1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100091:	89 44 24 04          	mov    %eax,0x4(%esp)
80100095:	8d 43 0c             	lea    0xc(%ebx),%eax
80100098:	89 04 24             	mov    %eax,(%esp)
8010009b:	e8 a0 56 00 00       	call   80105740 <initsleeplock>
    bcache.head.next->prev = b;
801000a0:	a1 70 1d 11 80       	mov    0x80111d70,%eax
801000a5:	89 da                	mov    %ebx,%edx
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
801000b0:	3d 1c 1d 11 80       	cmp    $0x80111d1c,%eax
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
801000b5:	89 1d 70 1d 11 80    	mov    %ebx,0x80111d70

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000bb:	75 c3                	jne    80100080 <binit+0x40>
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
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
801000d6:	83 ec 2c             	sub    $0x2c,%esp
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000d9:	c7 04 24 20 d6 10 80 	movl   $0x8010d620,(%esp)
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000e0:	8b 75 08             	mov    0x8(%ebp),%esi
801000e3:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000e6:	e8 e5 58 00 00       	call   801059d0 <acquire>

  // Is the block already cached?
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
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c 1d 11 80    	mov    0x80111d6c,%ebx
80100126:	81 fb 1c 1d 11 80    	cmp    $0x80111d1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 5e                	jmp    8010018e <bread+0xbe>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c 1d 11 80    	cmp    $0x80111d1c,%ebx
80100139:	74 53                	je     8010018e <bread+0xbe>
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
80100161:	e8 0a 59 00 00       	call   80105a70 <release>
      acquiresleep(&b->lock);
80100166:	8d 43 0c             	lea    0xc(%ebx),%eax
80100169:	89 04 24             	mov    %eax,(%esp)
8010016c:	e8 0f 56 00 00       	call   80105780 <acquiresleep>
80100171:	89 d8                	mov    %ebx,%eax
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100173:	f6 03 02             	testb  $0x2,(%ebx)
80100176:	75 0e                	jne    80100186 <bread+0xb6>
    iderw(b);
80100178:	89 1c 24             	mov    %ebx,(%esp)
8010017b:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
8010017e:	e8 3d 20 00 00       	call   801021c0 <iderw>
80100183:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  }
  return b;
}
80100186:	83 c4 2c             	add    $0x2c,%esp
80100189:	5b                   	pop    %ebx
8010018a:	5e                   	pop    %esi
8010018b:	5f                   	pop    %edi
8010018c:	5d                   	pop    %ebp
8010018d:	c3                   	ret    
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
8010018e:	c7 04 24 ee 86 10 80 	movl   $0x801086ee,(%esp)
80100195:	e8 a6 01 00 00       	call   80100340 <panic>
8010019a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801001a0 <bwrite>:
}

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
801001b0:	e8 6b 56 00 00       	call   80105820 <holdingsleep>
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
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
801001c4:	e9 f7 1f 00 00       	jmp    801021c0 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001c9:	c7 04 24 ff 86 10 80 	movl   $0x801086ff,(%esp)
801001d0:	e8 6b 01 00 00       	call   80100340 <panic>
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
801001f1:	e8 2a 56 00 00       	call   80105820 <holdingsleep>
801001f6:	85 c0                	test   %eax,%eax
801001f8:	74 5a                	je     80100254 <brelse+0x74>
    panic("brelse");

  releasesleep(&b->lock);
801001fa:	89 34 24             	mov    %esi,(%esp)
801001fd:	e8 de 55 00 00       	call   801057e0 <releasesleep>

  acquire(&bcache.lock);
80100202:	c7 04 24 20 d6 10 80 	movl   $0x8010d620,(%esp)
80100209:	e8 c2 57 00 00       	call   801059d0 <acquire>
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
  b->refcnt--;
  if (b->refcnt == 0) {
    // no one is waiting for it.
    b->next->prev = b->prev;
    b->prev->next = b->next;
    b->next = bcache.head.next;
80100231:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
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
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
  
  release(&bcache.lock);
8010024f:	e9 1c 58 00 00       	jmp    80105a70 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100254:	c7 04 24 06 87 10 80 	movl   $0x80108706,(%esp)
8010025b:	e8 e0 00 00 00       	call   80100340 <panic>

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
8010026c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010026f:	89 3c 24             	mov    %edi,(%esp)
80100272:	e8 59 15 00 00       	call   801017d0 <iunlock>
  target = n;
  acquire(&cons.lock);
80100277:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010027e:	e8 4d 57 00 00       	call   801059d0 <acquire>
  while(n > 0){
80100283:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100286:	31 c0                	xor    %eax,%eax
80100288:	85 db                	test   %ebx,%ebx
8010028a:	7f 25                	jg     801002b1 <consoleread+0x51>
8010028c:	eb 5b                	jmp    801002e9 <consoleread+0x89>
8010028e:	66 90                	xchg   %ax,%ax
    while(input.r == input.w){
      if(myproc()->killed){
80100290:	e8 3b 37 00 00       	call   801039d0 <myproc>
80100295:	8b 50 24             	mov    0x24(%eax),%edx
80100298:	85 d2                	test   %edx,%edx
8010029a:	75 6c                	jne    80100308 <consoleread+0xa8>
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
8010029c:	b8 20 c5 10 80       	mov    $0x8010c520,%eax
801002a1:	89 44 24 04          	mov    %eax,0x4(%esp)
801002a5:	c7 04 24 00 20 11 80 	movl   $0x80112000,(%esp)
801002ac:	e8 cf 40 00 00       	call   80104380 <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
801002b1:	a1 00 20 11 80       	mov    0x80112000,%eax
801002b6:	3b 05 04 20 11 80    	cmp    0x80112004,%eax
801002bc:	74 d2                	je     80100290 <consoleread+0x30>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
801002be:	8d 50 01             	lea    0x1(%eax),%edx
801002c1:	89 15 00 20 11 80    	mov    %edx,0x80112000
801002c7:	89 c2                	mov    %eax,%edx
801002c9:	83 e2 7f             	and    $0x7f,%edx
801002cc:	0f be 92 80 1f 11 80 	movsbl -0x7feee080(%edx),%edx
    if(c == C('D')){  // EOF
801002d3:	83 fa 04             	cmp    $0x4,%edx
801002d6:	74 51                	je     80100329 <consoleread+0xc9>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002d8:	46                   	inc    %esi
    --n;
801002d9:	4b                   	dec    %ebx
    if(c == '\n')
801002da:	83 fa 0a             	cmp    $0xa,%edx
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002dd:	88 56 ff             	mov    %dl,-0x1(%esi)
    --n;
    if(c == '\n')
801002e0:	74 51                	je     80100333 <consoleread+0xd3>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
801002e2:	85 db                	test   %ebx,%ebx
801002e4:	75 cb                	jne    801002b1 <consoleread+0x51>
801002e6:	8b 45 10             	mov    0x10(%ebp),%eax
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
801002e9:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
801002f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801002f3:	e8 78 57 00 00       	call   80105a70 <release>
  ilock(ip);
801002f8:	89 3c 24             	mov    %edi,(%esp)
801002fb:	e8 f0 13 00 00       	call   801016f0 <ilock>
80100300:	8b 45 e4             	mov    -0x1c(%ebp),%eax

  return target - n;
80100303:	eb 1c                	jmp    80100321 <consoleread+0xc1>
80100305:	8d 76 00             	lea    0x0(%esi),%esi
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
      if(myproc()->killed){
        release(&cons.lock);
80100308:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010030f:	e8 5c 57 00 00       	call   80105a70 <release>
        ilock(ip);
80100314:	89 3c 24             	mov    %edi,(%esp)
80100317:	e8 d4 13 00 00       	call   801016f0 <ilock>
        return -1;
8010031c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100321:	83 c4 2c             	add    $0x2c,%esp
80100324:	5b                   	pop    %ebx
80100325:	5e                   	pop    %esi
80100326:	5f                   	pop    %edi
80100327:	5d                   	pop    %ebp
80100328:	c3                   	ret    
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
80100329:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010032c:	76 05                	jbe    80100333 <consoleread+0xd3>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
8010032e:	a3 00 20 11 80       	mov    %eax,0x80112000
80100333:	8b 45 10             	mov    0x10(%ebp),%eax
80100336:	29 d8                	sub    %ebx,%eax
80100338:	eb af                	jmp    801002e9 <consoleread+0x89>
8010033a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100340 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
80100340:	55                   	push   %ebp
80100341:	89 e5                	mov    %esp,%ebp
80100343:	56                   	push   %esi
80100344:	53                   	push   %ebx
80100345:	83 ec 40             	sub    $0x40,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100348:	fa                   	cli    
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
80100349:	31 d2                	xor    %edx,%edx
8010034b:	89 15 54 c5 10 80    	mov    %edx,0x8010c554
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
80100351:	8d 5d d0             	lea    -0x30(%ebp),%ebx
  uint pcs[10];

  cli();
  cons.locking = 0;
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
80100354:	e8 67 24 00 00       	call   801027c0 <lapicid>
80100359:	8d 75 f8             	lea    -0x8(%ebp),%esi
8010035c:	c7 04 24 0d 87 10 80 	movl   $0x8010870d,(%esp)
80100363:	89 44 24 04          	mov    %eax,0x4(%esp)
80100367:	e8 d4 02 00 00       	call   80100640 <cprintf>
  cprintf(s);
8010036c:	8b 45 08             	mov    0x8(%ebp),%eax
8010036f:	89 04 24             	mov    %eax,(%esp)
80100372:	e8 c9 02 00 00       	call   80100640 <cprintf>
  cprintf("\n");
80100377:	c7 04 24 01 8e 10 80 	movl   $0x80108e01,(%esp)
8010037e:	e8 bd 02 00 00       	call   80100640 <cprintf>
  getcallerpcs(&s, pcs);
80100383:	8d 45 08             	lea    0x8(%ebp),%eax
80100386:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010038a:	89 04 24             	mov    %eax,(%esp)
8010038d:	e8 fe 54 00 00       	call   80105890 <getcallerpcs>
80100392:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003a0:	8b 03                	mov    (%ebx),%eax
801003a2:	83 c3 04             	add    $0x4,%ebx
801003a5:	c7 04 24 21 87 10 80 	movl   $0x80108721,(%esp)
801003ac:	89 44 24 04          	mov    %eax,0x4(%esp)
801003b0:	e8 8b 02 00 00       	call   80100640 <cprintf>
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801003b5:	39 f3                	cmp    %esi,%ebx
801003b7:	75 e7                	jne    801003a0 <panic+0x60>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801003b9:	b8 01 00 00 00       	mov    $0x1,%eax
801003be:	a3 58 c5 10 80       	mov    %eax,0x8010c558
801003c3:	eb fe                	jmp    801003c3 <panic+0x83>
801003c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801003c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801003d0 <consputc>:
}

void
consputc(int c)
{
  if(panicked){
801003d0:	8b 15 58 c5 10 80    	mov    0x8010c558,%edx
801003d6:	85 d2                	test   %edx,%edx
801003d8:	74 06                	je     801003e0 <consputc+0x10>
801003da:	fa                   	cli    
801003db:	eb fe                	jmp    801003db <consputc+0xb>
801003dd:	8d 76 00             	lea    0x0(%esi),%esi
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
801003e0:	55                   	push   %ebp
801003e1:	89 e5                	mov    %esp,%ebp
801003e3:	57                   	push   %edi
801003e4:	56                   	push   %esi
801003e5:	53                   	push   %ebx
801003e6:	89 c3                	mov    %eax,%ebx
801003e8:	83 ec 2c             	sub    $0x2c,%esp
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
801003eb:	3d 00 01 00 00       	cmp    $0x100,%eax
801003f0:	0f 84 aa 00 00 00    	je     801004a0 <consputc+0xd0>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
801003f6:	89 04 24             	mov    %eax,(%esp)
801003f9:	e8 72 6e 00 00       	call   80107270 <uartputc>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801003fe:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100403:	b0 0e                	mov    $0xe,%al
80100405:	89 fa                	mov    %edi,%edx
80100407:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100408:	be d5 03 00 00       	mov    $0x3d5,%esi
8010040d:	89 f2                	mov    %esi,%edx
8010040f:	ec                   	in     (%dx),%al
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
80100410:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100413:	89 fa                	mov    %edi,%edx
80100415:	c1 e0 08             	shl    $0x8,%eax
80100418:	89 c1                	mov    %eax,%ecx
8010041a:	b0 0f                	mov    $0xf,%al
8010041c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010041d:	89 f2                	mov    %esi,%edx
8010041f:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
80100420:	0f b6 c0             	movzbl %al,%eax
80100423:	09 c8                	or     %ecx,%eax

  if(c == '\n')
80100425:	83 fb 0a             	cmp    $0xa,%ebx
80100428:	0f 84 07 01 00 00    	je     80100535 <consputc+0x165>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
8010042e:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
80100434:	0f 84 ef 00 00 00    	je     80100529 <consputc+0x159>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010043a:	0f b6 cb             	movzbl %bl,%ecx
8010043d:	81 c9 00 07 00 00    	or     $0x700,%ecx
80100443:	8d 50 01             	lea    0x1(%eax),%edx
80100446:	66 89 8c 00 00 80 0b 	mov    %cx,-0x7ff48000(%eax,%eax,1)
8010044d:	80 

  if(pos < 0 || pos > 25*80)
8010044e:	81 fa d0 07 00 00    	cmp    $0x7d0,%edx
80100454:	0f 8f c3 00 00 00    	jg     8010051d <consputc+0x14d>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
8010045a:	81 fa 7f 07 00 00    	cmp    $0x77f,%edx
80100460:	7f 67                	jg     801004c9 <consputc+0xf9>
80100462:	89 d0                	mov    %edx,%eax
80100464:	88 d3                	mov    %dl,%bl
80100466:	c1 e8 08             	shr    $0x8,%eax
80100469:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010046c:	8d 8c 12 00 80 0b 80 	lea    -0x7ff48000(%edx,%edx,1),%ecx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100473:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100478:	b0 0e                	mov    $0xe,%al
8010047a:	89 fa                	mov    %edi,%edx
8010047c:	ee                   	out    %al,(%dx)
8010047d:	be d5 03 00 00       	mov    $0x3d5,%esi
80100482:	0f b6 45 d8          	movzbl -0x28(%ebp),%eax
80100486:	89 f2                	mov    %esi,%edx
80100488:	ee                   	out    %al,(%dx)
80100489:	b0 0f                	mov    $0xf,%al
8010048b:	89 fa                	mov    %edi,%edx
8010048d:	ee                   	out    %al,(%dx)
8010048e:	88 d8                	mov    %bl,%al
80100490:	89 f2                	mov    %esi,%edx
80100492:	ee                   	out    %al,(%dx)

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
80100493:	66 c7 01 20 07       	movw   $0x720,(%ecx)
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
80100498:	83 c4 2c             	add    $0x2c,%esp
8010049b:	5b                   	pop    %ebx
8010049c:	5e                   	pop    %esi
8010049d:	5f                   	pop    %edi
8010049e:	5d                   	pop    %ebp
8010049f:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004a0:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004a7:	e8 c4 6d 00 00       	call   80107270 <uartputc>
801004ac:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004b3:	e8 b8 6d 00 00       	call   80107270 <uartputc>
801004b8:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004bf:	e8 ac 6d 00 00       	call   80107270 <uartputc>
801004c4:	e9 35 ff ff ff       	jmp    801003fe <consputc+0x2e>
801004c9:	89 55 d8             	mov    %edx,-0x28(%ebp)

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004cc:	b8 60 0e 00 00       	mov    $0xe60,%eax
801004d1:	ba a0 80 0b 80       	mov    $0x800b80a0,%edx
801004d6:	89 54 24 04          	mov    %edx,0x4(%esp)
801004da:	89 44 24 08          	mov    %eax,0x8(%esp)
801004de:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
801004e5:	e8 96 56 00 00       	call   80105b80 <memmove>
    pos -= 80;
801004ea:	8b 55 d8             	mov    -0x28(%ebp),%edx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004ed:	b8 80 07 00 00       	mov    $0x780,%eax
801004f2:	31 c9                	xor    %ecx,%ecx
801004f4:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
    pos -= 80;
801004f8:	8d 5a b0             	lea    -0x50(%edx),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004fb:	29 d8                	sub    %ebx,%eax
801004fd:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi
80100504:	01 c0                	add    %eax,%eax
80100506:	89 44 24 08          	mov    %eax,0x8(%esp)
8010050a:	89 34 24             	mov    %esi,(%esp)
8010050d:	e8 ae 55 00 00       	call   80105ac0 <memset>
80100512:	89 f1                	mov    %esi,%ecx
80100514:	c6 45 d8 07          	movb   $0x7,-0x28(%ebp)
80100518:	e9 56 ff ff ff       	jmp    80100473 <consputc+0xa3>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");
8010051d:	c7 04 24 25 87 10 80 	movl   $0x80108725,(%esp)
80100524:	e8 17 fe ff ff       	call   80100340 <panic>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
80100529:	85 c0                	test   %eax,%eax
8010052b:	74 22                	je     8010054f <consputc+0x17f>
8010052d:	8d 50 ff             	lea    -0x1(%eax),%edx
80100530:	e9 19 ff ff ff       	jmp    8010044e <consputc+0x7e>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
80100535:	ba 67 66 66 66       	mov    $0x66666667,%edx
8010053a:	f7 ea                	imul   %edx
8010053c:	89 d0                	mov    %edx,%eax
8010053e:	c1 f8 05             	sar    $0x5,%eax
80100541:	8d 04 80             	lea    (%eax,%eax,4),%eax
80100544:	c1 e0 04             	shl    $0x4,%eax
80100547:	8d 50 50             	lea    0x50(%eax),%edx
8010054a:	e9 ff fe ff ff       	jmp    8010044e <consputc+0x7e>
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
8010054f:	b9 00 80 0b 80       	mov    $0x800b8000,%ecx
80100554:	31 db                	xor    %ebx,%ebx
80100556:	c6 45 d8 00          	movb   $0x0,-0x28(%ebp)
8010055a:	e9 14 ff ff ff       	jmp    80100473 <consputc+0xa3>
8010055f:	90                   	nop

80100560 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100560:	55                   	push   %ebp
80100561:	89 e5                	mov    %esp,%ebp
80100563:	57                   	push   %edi
80100564:	56                   	push   %esi
80100565:	89 d6                	mov    %edx,%esi
80100567:	53                   	push   %ebx
80100568:	83 ec 2c             	sub    $0x2c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010056b:	85 c9                	test   %ecx,%ecx
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
8010056d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100570:	74 0c                	je     8010057e <printint+0x1e>
80100572:	89 c7                	mov    %eax,%edi
80100574:	c1 ef 1f             	shr    $0x1f,%edi
80100577:	85 c0                	test   %eax,%eax
80100579:	89 7d d4             	mov    %edi,-0x2c(%ebp)
8010057c:	78 57                	js     801005d5 <printint+0x75>
    x = -xx;
  else
    x = xx;

  i = 0;
8010057e:	31 ff                	xor    %edi,%edi
80100580:	8d 5d d7             	lea    -0x29(%ebp),%ebx
80100583:	eb 05                	jmp    8010058a <printint+0x2a>
80100585:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
80100588:	89 cf                	mov    %ecx,%edi
8010058a:	31 d2                	xor    %edx,%edx
8010058c:	f7 f6                	div    %esi
8010058e:	8d 4f 01             	lea    0x1(%edi),%ecx
80100591:	0f b6 92 50 87 10 80 	movzbl -0x7fef78b0(%edx),%edx
  }while((x /= base) != 0);
80100598:	85 c0                	test   %eax,%eax
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
8010059a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
8010059d:	75 e9                	jne    80100588 <printint+0x28>

  if(sign)
8010059f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005a2:	85 c0                	test   %eax,%eax
801005a4:	74 08                	je     801005ae <printint+0x4e>
    buf[i++] = '-';
801005a6:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
801005ab:	8d 4f 02             	lea    0x2(%edi),%ecx
801005ae:	8d 74 0d d7          	lea    -0x29(%ebp,%ecx,1),%esi
801005b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801005b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  while(--i >= 0)
    consputc(buf[i]);
801005c0:	0f be 06             	movsbl (%esi),%eax
801005c3:	4e                   	dec    %esi
801005c4:	e8 07 fe ff ff       	call   801003d0 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801005c9:	39 de                	cmp    %ebx,%esi
801005cb:	75 f3                	jne    801005c0 <printint+0x60>
    consputc(buf[i]);
}
801005cd:	83 c4 2c             	add    $0x2c,%esp
801005d0:	5b                   	pop    %ebx
801005d1:	5e                   	pop    %esi
801005d2:	5f                   	pop    %edi
801005d3:	5d                   	pop    %ebp
801005d4:	c3                   	ret    
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
801005d5:	f7 d8                	neg    %eax
801005d7:	eb a5                	jmp    8010057e <printint+0x1e>
801005d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801005e0 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005e0:	55                   	push   %ebp
801005e1:	89 e5                	mov    %esp,%ebp
801005e3:	57                   	push   %edi
801005e4:	56                   	push   %esi
801005e5:	53                   	push   %ebx
801005e6:	83 ec 1c             	sub    $0x1c,%esp
  int i;

  iunlock(ip);
801005e9:	8b 45 08             	mov    0x8(%ebp),%eax
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005ec:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
801005ef:	89 04 24             	mov    %eax,(%esp)
801005f2:	e8 d9 11 00 00       	call   801017d0 <iunlock>
  acquire(&cons.lock);
801005f7:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
801005fe:	e8 cd 53 00 00       	call   801059d0 <acquire>
80100603:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100606:	85 f6                	test   %esi,%esi
80100608:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010060b:	7e 10                	jle    8010061d <consolewrite+0x3d>
8010060d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100610:	0f b6 07             	movzbl (%edi),%eax
80100613:	47                   	inc    %edi
80100614:	e8 b7 fd ff ff       	call   801003d0 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
80100619:	39 df                	cmp    %ebx,%edi
8010061b:	75 f3                	jne    80100610 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
8010061d:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
80100624:	e8 47 54 00 00       	call   80105a70 <release>
  ilock(ip);
80100629:	8b 45 08             	mov    0x8(%ebp),%eax
8010062c:	89 04 24             	mov    %eax,(%esp)
8010062f:	e8 bc 10 00 00       	call   801016f0 <ilock>

  return n;
}
80100634:	83 c4 1c             	add    $0x1c,%esp
80100637:	89 f0                	mov    %esi,%eax
80100639:	5b                   	pop    %ebx
8010063a:	5e                   	pop    %esi
8010063b:	5f                   	pop    %edi
8010063c:	5d                   	pop    %ebp
8010063d:	c3                   	ret    
8010063e:	66 90                	xchg   %ax,%ax

80100640 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100640:	55                   	push   %ebp
80100641:	89 e5                	mov    %esp,%ebp
80100643:	57                   	push   %edi
80100644:	56                   	push   %esi
80100645:	53                   	push   %ebx
80100646:	83 ec 2c             	sub    $0x2c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100649:	a1 54 c5 10 80       	mov    0x8010c554,%eax
  if(locking)
8010064e:	85 c0                	test   %eax,%eax
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100650:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100653:	0f 85 2f 01 00 00    	jne    80100788 <cprintf+0x148>
    acquire(&cons.lock);

  if (fmt == 0)
80100659:	8b 45 08             	mov    0x8(%ebp),%eax
8010065c:	85 c0                	test   %eax,%eax
8010065e:	89 c1                	mov    %eax,%ecx
80100660:	0f 84 33 01 00 00    	je     80100799 <cprintf+0x159>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100666:	0f b6 00             	movzbl (%eax),%eax
80100669:	31 db                	xor    %ebx,%ebx
8010066b:	89 cf                	mov    %ecx,%edi
8010066d:	8d 75 0c             	lea    0xc(%ebp),%esi
80100670:	85 c0                	test   %eax,%eax
80100672:	75 51                	jne    801006c5 <cprintf+0x85>
80100674:	eb 62                	jmp    801006d8 <cprintf+0x98>
80100676:	8d 76 00             	lea    0x0(%esi),%esi
80100679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
80100680:	43                   	inc    %ebx
80100681:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
    if(c == 0)
80100685:	85 d2                	test   %edx,%edx
80100687:	74 4f                	je     801006d8 <cprintf+0x98>
      break;
    switch(c){
80100689:	83 fa 70             	cmp    $0x70,%edx
8010068c:	74 74                	je     80100702 <cprintf+0xc2>
8010068e:	7f 68                	jg     801006f8 <cprintf+0xb8>
80100690:	83 fa 25             	cmp    $0x25,%edx
80100693:	0f 84 a7 00 00 00    	je     80100740 <cprintf+0x100>
80100699:	83 fa 64             	cmp    $0x64,%edx
8010069c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801006a0:	75 7e                	jne    80100720 <cprintf+0xe0>
    case 'd':
      printint(*argp++, 10, 1);
801006a2:	8d 46 04             	lea    0x4(%esi),%eax
801006a5:	b9 01 00 00 00       	mov    $0x1,%ecx
801006aa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006ad:	8b 06                	mov    (%esi),%eax
801006af:	ba 0a 00 00 00       	mov    $0xa,%edx
801006b4:	e8 a7 fe ff ff       	call   80100560 <printint>
801006b9:	8b 75 e4             	mov    -0x1c(%ebp),%esi

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006bc:	43                   	inc    %ebx
801006bd:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006c1:	85 c0                	test   %eax,%eax
801006c3:	74 13                	je     801006d8 <cprintf+0x98>
    if(c != '%'){
801006c5:	83 f8 25             	cmp    $0x25,%eax
801006c8:	74 b6                	je     80100680 <cprintf+0x40>
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
801006ca:	e8 01 fd ff ff       	call   801003d0 <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006cf:	43                   	inc    %ebx
801006d0:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006d4:	85 c0                	test   %eax,%eax
801006d6:	75 ed                	jne    801006c5 <cprintf+0x85>
      consputc(c);
      break;
    }
  }

  if(locking)
801006d8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801006db:	85 c0                	test   %eax,%eax
801006dd:	74 0c                	je     801006eb <cprintf+0xab>
    release(&cons.lock);
801006df:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
801006e6:	e8 85 53 00 00       	call   80105a70 <release>
}
801006eb:	83 c4 2c             	add    $0x2c,%esp
801006ee:	5b                   	pop    %ebx
801006ef:	5e                   	pop    %esi
801006f0:	5f                   	pop    %edi
801006f1:	5d                   	pop    %ebp
801006f2:	c3                   	ret    
801006f3:	90                   	nop
801006f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
801006f8:	83 fa 73             	cmp    $0x73,%edx
801006fb:	74 53                	je     80100750 <cprintf+0x110>
801006fd:	83 fa 78             	cmp    $0x78,%edx
80100700:	75 1e                	jne    80100720 <cprintf+0xe0>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
80100702:	8d 46 04             	lea    0x4(%esi),%eax
80100705:	31 c9                	xor    %ecx,%ecx
80100707:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010070a:	8b 06                	mov    (%esi),%eax
8010070c:	ba 10 00 00 00       	mov    $0x10,%edx
80100711:	e8 4a fe ff ff       	call   80100560 <printint>
80100716:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      break;
80100719:	eb a1                	jmp    801006bc <cprintf+0x7c>
8010071b:	90                   	nop
8010071c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100720:	b8 25 00 00 00       	mov    $0x25,%eax
80100725:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100728:	e8 a3 fc ff ff       	call   801003d0 <consputc>
      consputc(c);
8010072d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100730:	89 d0                	mov    %edx,%eax
80100732:	e8 99 fc ff ff       	call   801003d0 <consputc>
      break;
80100737:	eb 83                	jmp    801006bc <cprintf+0x7c>
80100739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
80100740:	b8 25 00 00 00       	mov    $0x25,%eax
80100745:	e8 86 fc ff ff       	call   801003d0 <consputc>
8010074a:	eb 83                	jmp    801006cf <cprintf+0x8f>
8010074c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
80100750:	8d 46 04             	lea    0x4(%esi),%eax
80100753:	8b 36                	mov    (%esi),%esi
80100755:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        s = "(null)";
80100758:	b8 38 87 10 80       	mov    $0x80108738,%eax
8010075d:	85 f6                	test   %esi,%esi
8010075f:	0f 44 f0             	cmove  %eax,%esi
      for(; *s; s++)
80100762:	0f be 06             	movsbl (%esi),%eax
80100765:	84 c0                	test   %al,%al
80100767:	74 14                	je     8010077d <cprintf+0x13d>
80100769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100770:	46                   	inc    %esi
        consputc(*s);
80100771:	e8 5a fc ff ff       	call   801003d0 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
80100776:	0f be 06             	movsbl (%esi),%eax
80100779:	84 c0                	test   %al,%al
8010077b:	75 f3                	jne    80100770 <cprintf+0x130>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
8010077d:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80100780:	e9 37 ff ff ff       	jmp    801006bc <cprintf+0x7c>
80100785:	8d 76 00             	lea    0x0(%esi),%esi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
80100788:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010078f:	e8 3c 52 00 00       	call   801059d0 <acquire>
80100794:	e9 c0 fe ff ff       	jmp    80100659 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
80100799:	c7 04 24 3f 87 10 80 	movl   $0x8010873f,(%esp)
801007a0:	e8 9b fb ff ff       	call   80100340 <panic>
801007a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801007a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801007b0 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007b0:	55                   	push   %ebp
801007b1:	89 e5                	mov    %esp,%ebp
801007b3:	56                   	push   %esi
  int c, doprocdump = 0;
801007b4:	31 f6                	xor    %esi,%esi

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007b6:	53                   	push   %ebx
801007b7:	83 ec 20             	sub    $0x20,%esp
  int c, doprocdump = 0;

  acquire(&cons.lock);
801007ba:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007c1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c, doprocdump = 0;

  acquire(&cons.lock);
801007c4:	e8 07 52 00 00       	call   801059d0 <acquire>
801007c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while((c = getc()) >= 0){
801007d0:	ff d3                	call   *%ebx
801007d2:	85 c0                	test   %eax,%eax
801007d4:	89 c2                	mov    %eax,%edx
801007d6:	78 48                	js     80100820 <consoleintr+0x70>
    switch(c){
801007d8:	83 fa 10             	cmp    $0x10,%edx
801007db:	0f 84 37 01 00 00    	je     80100918 <consoleintr+0x168>
801007e1:	7e 5d                	jle    80100840 <consoleintr+0x90>
801007e3:	83 fa 15             	cmp    $0x15,%edx
801007e6:	0f 84 dc 00 00 00    	je     801008c8 <consoleintr+0x118>
801007ec:	83 fa 7f             	cmp    $0x7f,%edx
801007ef:	90                   	nop
801007f0:	75 53                	jne    80100845 <consoleintr+0x95>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
801007f2:	a1 08 20 11 80       	mov    0x80112008,%eax
801007f7:	3b 05 04 20 11 80    	cmp    0x80112004,%eax
801007fd:	74 d1                	je     801007d0 <consoleintr+0x20>
        input.e--;
801007ff:	48                   	dec    %eax
80100800:	a3 08 20 11 80       	mov    %eax,0x80112008
        consputc(BACKSPACE);
80100805:	b8 00 01 00 00       	mov    $0x100,%eax
8010080a:	e8 c1 fb ff ff       	call   801003d0 <consputc>
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
8010080f:	ff d3                	call   *%ebx
80100811:	85 c0                	test   %eax,%eax
80100813:	89 c2                	mov    %eax,%edx
80100815:	79 c1                	jns    801007d8 <consoleintr+0x28>
80100817:	89 f6                	mov    %esi,%esi
80100819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100820:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
80100827:	e8 44 52 00 00       	call   80105a70 <release>
  if(doprocdump) {
8010082c:	85 f6                	test   %esi,%esi
8010082e:	0f 85 f4 00 00 00    	jne    80100928 <consoleintr+0x178>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100834:	83 c4 20             	add    $0x20,%esp
80100837:	5b                   	pop    %ebx
80100838:	5e                   	pop    %esi
80100839:	5d                   	pop    %ebp
8010083a:	c3                   	ret    
8010083b:	90                   	nop
8010083c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
80100840:	83 fa 08             	cmp    $0x8,%edx
80100843:	74 ad                	je     801007f2 <consoleintr+0x42>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100845:	85 d2                	test   %edx,%edx
80100847:	74 87                	je     801007d0 <consoleintr+0x20>
80100849:	a1 08 20 11 80       	mov    0x80112008,%eax
8010084e:	89 c1                	mov    %eax,%ecx
80100850:	2b 0d 00 20 11 80    	sub    0x80112000,%ecx
80100856:	83 f9 7f             	cmp    $0x7f,%ecx
80100859:	0f 87 71 ff ff ff    	ja     801007d0 <consoleintr+0x20>
        c = (c == '\r') ? '\n' : c;
8010085f:	83 fa 0d             	cmp    $0xd,%edx
80100862:	0f 84 cb 00 00 00    	je     80100933 <consoleintr+0x183>
        input.buf[input.e++ % INPUT_BUF] = c;
80100868:	8d 48 01             	lea    0x1(%eax),%ecx
8010086b:	83 e0 7f             	and    $0x7f,%eax
8010086e:	88 90 80 1f 11 80    	mov    %dl,-0x7feee080(%eax)
        consputc(c);
80100874:	89 d0                	mov    %edx,%eax
80100876:	89 55 f4             	mov    %edx,-0xc(%ebp)
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
80100879:	89 0d 08 20 11 80    	mov    %ecx,0x80112008
        consputc(c);
8010087f:	e8 4c fb ff ff       	call   801003d0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100884:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100887:	83 fa 0a             	cmp    $0xa,%edx
8010088a:	0f 84 c0 00 00 00    	je     80100950 <consoleintr+0x1a0>
80100890:	83 fa 04             	cmp    $0x4,%edx
80100893:	0f 84 b7 00 00 00    	je     80100950 <consoleintr+0x1a0>
80100899:	a1 00 20 11 80       	mov    0x80112000,%eax
8010089e:	83 e8 80             	sub    $0xffffff80,%eax
801008a1:	39 05 08 20 11 80    	cmp    %eax,0x80112008
801008a7:	0f 85 23 ff ff ff    	jne    801007d0 <consoleintr+0x20>
          input.w = input.e;
          wakeup(&input.r);
801008ad:	c7 04 24 00 20 11 80 	movl   $0x80112000,(%esp)
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
801008b4:	a3 04 20 11 80       	mov    %eax,0x80112004
          wakeup(&input.r);
801008b9:	e8 e2 3c 00 00       	call   801045a0 <wakeup>
801008be:	e9 0d ff ff ff       	jmp    801007d0 <consoleintr+0x20>
801008c3:	90                   	nop
801008c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
801008c8:	a1 08 20 11 80       	mov    0x80112008,%eax
801008cd:	39 05 04 20 11 80    	cmp    %eax,0x80112004
801008d3:	75 2b                	jne    80100900 <consoleintr+0x150>
801008d5:	e9 f6 fe ff ff       	jmp    801007d0 <consoleintr+0x20>
801008da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
801008e0:	a3 08 20 11 80       	mov    %eax,0x80112008
        consputc(BACKSPACE);
801008e5:	b8 00 01 00 00       	mov    $0x100,%eax
801008ea:	e8 e1 fa ff ff       	call   801003d0 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
801008ef:	a1 08 20 11 80       	mov    0x80112008,%eax
801008f4:	3b 05 04 20 11 80    	cmp    0x80112004,%eax
801008fa:	0f 84 d0 fe ff ff    	je     801007d0 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100900:	48                   	dec    %eax
80100901:	89 c2                	mov    %eax,%edx
80100903:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100906:	80 ba 80 1f 11 80 0a 	cmpb   $0xa,-0x7feee080(%edx)
8010090d:	75 d1                	jne    801008e0 <consoleintr+0x130>
8010090f:	e9 bc fe ff ff       	jmp    801007d0 <consoleintr+0x20>
80100914:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
80100918:	be 01 00 00 00       	mov    $0x1,%esi
8010091d:	e9 ae fe ff ff       	jmp    801007d0 <consoleintr+0x20>
80100922:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100928:	83 c4 20             	add    $0x20,%esp
8010092b:	5b                   	pop    %ebx
8010092c:	5e                   	pop    %esi
8010092d:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
8010092e:	e9 1d 3d 00 00       	jmp    80104650 <procdump>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
80100933:	8d 50 01             	lea    0x1(%eax),%edx
80100936:	83 e0 7f             	and    $0x7f,%eax
80100939:	c6 80 80 1f 11 80 0a 	movb   $0xa,-0x7feee080(%eax)
        consputc(c);
80100940:	b8 0a 00 00 00       	mov    $0xa,%eax
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
80100945:	89 15 08 20 11 80    	mov    %edx,0x80112008
        consputc(c);
8010094b:	e8 80 fa ff ff       	call   801003d0 <consputc>
80100950:	a1 08 20 11 80       	mov    0x80112008,%eax
80100955:	e9 53 ff ff ff       	jmp    801008ad <consoleintr+0xfd>
8010095a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100960 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
80100960:	55                   	push   %ebp
  initlock(&cons.lock, "console");
80100961:	b8 48 87 10 80       	mov    $0x80108748,%eax
  return n;
}

void
consoleinit(void)
{
80100966:	89 e5                	mov    %esp,%ebp
80100968:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
8010096b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010096f:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
80100976:	e8 f5 4e 00 00       	call   80105870 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;
8010097b:	b8 01 00 00 00       	mov    $0x1,%eax
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
80100980:	ba e0 05 10 80       	mov    $0x801005e0,%edx
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;
80100985:	a3 54 c5 10 80       	mov    %eax,0x8010c554

  ioapicenable(IRQ_KBD, 0);
8010098a:	31 c0                	xor    %eax,%eax
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
8010098c:	b9 60 02 10 80       	mov    $0x80100260,%ecx
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100991:	89 44 24 04          	mov    %eax,0x4(%esp)
80100995:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
8010099c:	89 15 cc 29 11 80    	mov    %edx,0x801129cc
  devsw[CONSOLE].read = consoleread;
801009a2:	89 0d c8 29 11 80    	mov    %ecx,0x801129c8
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009a8:	e8 a3 19 00 00       	call   80102350 <ioapicenable>
}
801009ad:	c9                   	leave  
801009ae:	c3                   	ret    
801009af:	90                   	nop

801009b0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009b0:	55                   	push   %ebp
801009b1:	89 e5                	mov    %esp,%ebp
801009b3:	81 ec 38 01 00 00    	sub    $0x138,%esp
801009b9:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801009bc:	89 75 f8             	mov    %esi,-0x8(%ebp)
801009bf:	89 7d fc             	mov    %edi,-0x4(%ebp)
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801009c2:	e8 09 30 00 00       	call   801039d0 <myproc>
801009c7:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
801009cd:	e8 2e 22 00 00       	call   80102c00 <begin_op>

  if((ip = namei(path)) == 0){
801009d2:	8b 45 08             	mov    0x8(%ebp),%eax
801009d5:	89 04 24             	mov    %eax,(%esp)
801009d8:	e8 b3 15 00 00       	call   80101f90 <namei>
801009dd:	85 c0                	test   %eax,%eax
801009df:	0f 84 ca 01 00 00    	je     80100baf <exec+0x1ff>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
801009e5:	89 04 24             	mov    %eax,(%esp)
801009e8:	89 c7                	mov    %eax,%edi
801009ea:	e8 01 0d 00 00       	call   801016f0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
801009ef:	b8 34 00 00 00       	mov    $0x34,%eax
801009f4:	89 44 24 0c          	mov    %eax,0xc(%esp)
801009f8:	31 c0                	xor    %eax,%eax
801009fa:	89 44 24 08          	mov    %eax,0x8(%esp)
801009fe:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a04:	89 44 24 04          	mov    %eax,0x4(%esp)
80100a08:	89 3c 24             	mov    %edi,(%esp)
80100a0b:	e8 c0 0f 00 00       	call   801019d0 <readi>
80100a10:	83 f8 34             	cmp    $0x34,%eax
80100a13:	74 23                	je     80100a38 <exec+0x88>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a15:	89 3c 24             	mov    %edi,(%esp)
80100a18:	e8 63 0f 00 00       	call   80101980 <iunlockput>
    end_op();
80100a1d:	e8 4e 22 00 00       	call   80102c70 <end_op>
  }
  return -1;
80100a22:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a27:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100a2a:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100a2d:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100a30:	89 ec                	mov    %ebp,%esp
80100a32:	5d                   	pop    %ebp
80100a33:	c3                   	ret    
80100a34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100a38:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a3f:	45 4c 46 
80100a42:	75 d1                	jne    80100a15 <exec+0x65>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100a44:	e8 c7 79 00 00       	call   80108410 <setupkvm>
80100a49:	85 c0                	test   %eax,%eax
80100a4b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100a51:	74 c2                	je     80100a15 <exec+0x65>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a53:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a5a:	00 
80100a5b:	b8 00 00 00 00       	mov    $0x0,%eax
80100a60:	8b 9d 40 ff ff ff    	mov    -0xc0(%ebp),%ebx
80100a66:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100a6c:	0f 84 e1 00 00 00    	je     80100b53 <exec+0x1a3>
80100a72:	31 f6                	xor    %esi,%esi
80100a74:	eb 1d                	jmp    80100a93 <exec+0xe3>
80100a76:	8d 76 00             	lea    0x0(%esi),%esi
80100a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80100a80:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100a87:	46                   	inc    %esi
80100a88:	83 c3 20             	add    $0x20,%ebx
80100a8b:	39 f0                	cmp    %esi,%eax
80100a8d:	0f 8e c0 00 00 00    	jle    80100b53 <exec+0x1a3>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100a93:	b8 20 00 00 00       	mov    $0x20,%eax
80100a98:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100a9c:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100aa2:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100aa6:	89 44 24 04          	mov    %eax,0x4(%esp)
80100aaa:	89 3c 24             	mov    %edi,(%esp)
80100aad:	e8 1e 0f 00 00       	call   801019d0 <readi>
80100ab2:	83 f8 20             	cmp    $0x20,%eax
80100ab5:	0f 85 85 00 00 00    	jne    80100b40 <exec+0x190>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100abb:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100ac2:	75 bc                	jne    80100a80 <exec+0xd0>
      continue;
    if(ph.memsz < ph.filesz)
80100ac4:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100aca:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100ad0:	72 6e                	jb     80100b40 <exec+0x190>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100ad2:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ad8:	72 66                	jb     80100b40 <exec+0x190>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100ada:	89 44 24 08          	mov    %eax,0x8(%esp)
80100ade:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100ae4:	89 44 24 04          	mov    %eax,0x4(%esp)
80100ae8:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100aee:	89 04 24             	mov    %eax,(%esp)
80100af1:	e8 6a 77 00 00       	call   80108260 <allocuvm>
80100af6:	85 c0                	test   %eax,%eax
80100af8:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100afe:	74 40                	je     80100b40 <exec+0x190>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100b00:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b06:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b0b:	75 33                	jne    80100b40 <exec+0x190>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b0d:	8b 95 14 ff ff ff    	mov    -0xec(%ebp),%edx
80100b13:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b17:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b1d:	89 7c 24 08          	mov    %edi,0x8(%esp)
80100b21:	89 54 24 10          	mov    %edx,0x10(%esp)
80100b25:	8b 95 08 ff ff ff    	mov    -0xf8(%ebp),%edx
80100b2b:	89 04 24             	mov    %eax,(%esp)
80100b2e:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100b32:	e8 69 76 00 00       	call   801081a0 <loaduvm>
80100b37:	85 c0                	test   %eax,%eax
80100b39:	0f 89 41 ff ff ff    	jns    80100a80 <exec+0xd0>
80100b3f:	90                   	nop
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b40:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b46:	89 04 24             	mov    %eax,(%esp)
80100b49:	e8 42 78 00 00       	call   80108390 <freevm>
80100b4e:	e9 c2 fe ff ff       	jmp    80100a15 <exec+0x65>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100b53:	89 3c 24             	mov    %edi,(%esp)
80100b56:	e8 25 0e 00 00       	call   80101980 <iunlockput>
80100b5b:	90                   	nop
80100b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  end_op();
80100b60:	e8 0b 21 00 00       	call   80102c70 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100b65:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100b6b:	05 ff 0f 00 00       	add    $0xfff,%eax
80100b70:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b75:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100b7b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b7f:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b85:	89 54 24 08          	mov    %edx,0x8(%esp)
80100b89:	89 04 24             	mov    %eax,(%esp)
80100b8c:	e8 cf 76 00 00       	call   80108260 <allocuvm>
80100b91:	85 c0                	test   %eax,%eax
80100b93:	89 c6                	mov    %eax,%esi
80100b95:	75 33                	jne    80100bca <exec+0x21a>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b97:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b9d:	89 04 24             	mov    %eax,(%esp)
80100ba0:	e8 eb 77 00 00       	call   80108390 <freevm>
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100ba5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100baa:	e9 78 fe ff ff       	jmp    80100a27 <exec+0x77>
  struct proc *curproc = myproc();

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
80100baf:	e8 bc 20 00 00       	call   80102c70 <end_op>
    cprintf("exec: fail\n");
80100bb4:	c7 04 24 61 87 10 80 	movl   $0x80108761,(%esp)
80100bbb:	e8 80 fa ff ff       	call   80100640 <cprintf>
    return -1;
80100bc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bc5:	e9 5d fe ff ff       	jmp    80100a27 <exec+0x77>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bca:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bd0:	31 ff                	xor    %edi,%edi
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bd2:	89 44 24 04          	mov    %eax,0x4(%esp)
80100bd6:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bdc:	89 f3                	mov    %esi,%ebx
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bde:	89 04 24             	mov    %eax,(%esp)
80100be1:	e8 da 78 00 00       	call   801084c0 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100be6:	8b 45 0c             	mov    0xc(%ebp),%eax
80100be9:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100bef:	8b 00                	mov    (%eax),%eax
80100bf1:	85 c0                	test   %eax,%eax
80100bf3:	74 76                	je     80100c6b <exec+0x2bb>
80100bf5:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100bfb:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c01:	eb 0a                	jmp    80100c0d <exec+0x25d>
80100c03:	90                   	nop
80100c04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100c08:	83 ff 20             	cmp    $0x20,%edi
80100c0b:	74 8a                	je     80100b97 <exec+0x1e7>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c0d:	89 04 24             	mov    %eax,(%esp)
80100c10:	e8 db 50 00 00       	call   80105cf0 <strlen>
80100c15:	f7 d0                	not    %eax
80100c17:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c19:	8b 45 0c             	mov    0xc(%ebp),%eax

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c1c:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c1f:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c22:	89 04 24             	mov    %eax,(%esp)
80100c25:	e8 c6 50 00 00       	call   80105cf0 <strlen>
80100c2a:	40                   	inc    %eax
80100c2b:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c2f:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c32:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c35:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100c39:	89 34 24             	mov    %esi,(%esp)
80100c3c:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c40:	e8 eb 79 00 00       	call   80108630 <copyout>
80100c45:	85 c0                	test   %eax,%eax
80100c47:	0f 88 4a ff ff ff    	js     80100b97 <exec+0x1e7>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c4d:	8b 45 0c             	mov    0xc(%ebp),%eax
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c50:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c56:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c5d:	47                   	inc    %edi
80100c5e:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c61:	85 c0                	test   %eax,%eax
80100c63:	75 a3                	jne    80100c08 <exec+0x258>
80100c65:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100c6b:	31 c0                	xor    %eax,%eax

  ustack[0] = 0xffffffff;  // fake return PC
80100c6d:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100c72:	89 84 bd 64 ff ff ff 	mov    %eax,-0x9c(%ebp,%edi,4)

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c79:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
80100c80:	89 8d 58 ff ff ff    	mov    %ecx,-0xa8(%ebp)
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c86:	89 d9                	mov    %ebx,%ecx
80100c88:	29 c1                	sub    %eax,%ecx

  sp -= (3+argc+1) * 4;
80100c8a:	83 c0 0c             	add    $0xc,%eax
80100c8d:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c8f:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c93:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c99:	89 54 24 08          	mov    %edx,0x8(%esp)
80100c9d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
80100ca1:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100ca7:	89 04 24             	mov    %eax,(%esp)
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100caa:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cb0:	e8 7b 79 00 00       	call   80108630 <copyout>
80100cb5:	85 c0                	test   %eax,%eax
80100cb7:	0f 88 da fe ff ff    	js     80100b97 <exec+0x1e7>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cbd:	8b 45 08             	mov    0x8(%ebp),%eax
80100cc0:	0f b6 10             	movzbl (%eax),%edx
80100cc3:	84 d2                	test   %dl,%dl
80100cc5:	74 15                	je     80100cdc <exec+0x32c>
80100cc7:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100cca:	40                   	inc    %eax
    if(*s == '/')
      last = s+1;
80100ccb:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cce:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
80100cd1:	0f 44 c8             	cmove  %eax,%ecx
80100cd4:	40                   	inc    %eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cd5:	84 d2                	test   %dl,%dl
80100cd7:	75 f2                	jne    80100ccb <exec+0x31b>
80100cd9:	89 4d 08             	mov    %ecx,0x8(%ebp)
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cdc:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100ce2:	8b 45 08             	mov    0x8(%ebp),%eax
80100ce5:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80100cec:	00 
80100ced:	89 44 24 04          	mov    %eax,0x4(%esp)
80100cf1:	89 f8                	mov    %edi,%eax
80100cf3:	83 c0 6c             	add    $0x6c,%eax
80100cf6:	89 04 24             	mov    %eax,(%esp)
80100cf9:	e8 b2 4f 00 00       	call   80105cb0 <safestrcpy>

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100cfe:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100d04:	89 f8                	mov    %edi,%eax
80100d06:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->pgdir = pgdir;
  curproc->sz = sz;
80100d09:	89 30                	mov    %esi,(%eax)
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100d0b:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->sz = sz;
  curproc->tf->eip = elf.entry;  // main
80100d0e:	89 c1                	mov    %eax,%ecx
80100d10:	8b 40 18             	mov    0x18(%eax),%eax
80100d13:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d19:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d1c:	8b 41 18             	mov    0x18(%ecx),%eax
80100d1f:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d22:	89 0c 24             	mov    %ecx,(%esp)
80100d25:	e8 e6 72 00 00       	call   80108010 <switchuvm>
  freevm(oldpgdir);
80100d2a:	89 3c 24             	mov    %edi,(%esp)
80100d2d:	e8 5e 76 00 00       	call   80108390 <freevm>
  return 0;
80100d32:	31 c0                	xor    %eax,%eax
80100d34:	e9 ee fc ff ff       	jmp    80100a27 <exec+0x77>
80100d39:	66 90                	xchg   %ax,%ax
80100d3b:	66 90                	xchg   %ax,%ax
80100d3d:	66 90                	xchg   %ax,%ax
80100d3f:	90                   	nop

80100d40 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d40:	55                   	push   %ebp
  initlock(&ftable.lock, "ftable");
80100d41:	b8 6d 87 10 80       	mov    $0x8010876d,%eax
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d46:	89 e5                	mov    %esp,%ebp
80100d48:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100d4b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100d4f:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
80100d56:	e8 15 4b 00 00       	call   80105870 <initlock>
}
80100d5b:	c9                   	leave  
80100d5c:	c3                   	ret    
80100d5d:	8d 76 00             	lea    0x0(%esi),%esi

80100d60 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d60:	55                   	push   %ebp
80100d61:	89 e5                	mov    %esp,%ebp
80100d63:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d64:	bb 54 20 11 80       	mov    $0x80112054,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d69:	83 ec 14             	sub    $0x14,%esp
  struct file *f;

  acquire(&ftable.lock);
80100d6c:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
80100d73:	e8 58 4c 00 00       	call   801059d0 <acquire>
80100d78:	eb 11                	jmp    80100d8b <filealloc+0x2b>
80100d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d80:	83 c3 18             	add    $0x18,%ebx
80100d83:	81 fb b4 29 11 80    	cmp    $0x801129b4,%ebx
80100d89:	74 25                	je     80100db0 <filealloc+0x50>
    if(f->ref == 0){
80100d8b:	8b 43 04             	mov    0x4(%ebx),%eax
80100d8e:	85 c0                	test   %eax,%eax
80100d90:	75 ee                	jne    80100d80 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100d92:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
80100d99:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100da0:	e8 cb 4c 00 00       	call   80105a70 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100da5:	83 c4 14             	add    $0x14,%esp
  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
      release(&ftable.lock);
      return f;
80100da8:	89 d8                	mov    %ebx,%eax
    }
  }
  release(&ftable.lock);
  return 0;
}
80100daa:	5b                   	pop    %ebx
80100dab:	5d                   	pop    %ebp
80100dac:	c3                   	ret    
80100dad:	8d 76 00             	lea    0x0(%esi),%esi
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100db0:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
80100db7:	e8 b4 4c 00 00       	call   80105a70 <release>
  return 0;
}
80100dbc:	83 c4 14             	add    $0x14,%esp
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
80100dbf:	31 c0                	xor    %eax,%eax
}
80100dc1:	5b                   	pop    %ebx
80100dc2:	5d                   	pop    %ebp
80100dc3:	c3                   	ret    
80100dc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100dca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100dd0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100dd0:	55                   	push   %ebp
80100dd1:	89 e5                	mov    %esp,%ebp
80100dd3:	53                   	push   %ebx
80100dd4:	83 ec 14             	sub    $0x14,%esp
80100dd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dda:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
80100de1:	e8 ea 4b 00 00       	call   801059d0 <acquire>
  if(f->ref < 1)
80100de6:	8b 43 04             	mov    0x4(%ebx),%eax
80100de9:	85 c0                	test   %eax,%eax
80100deb:	7e 18                	jle    80100e05 <filedup+0x35>
    panic("filedup");
  f->ref++;
80100ded:	40                   	inc    %eax
80100dee:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100df1:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
80100df8:	e8 73 4c 00 00       	call   80105a70 <release>
  return f;
}
80100dfd:	83 c4 14             	add    $0x14,%esp
80100e00:	89 d8                	mov    %ebx,%eax
80100e02:	5b                   	pop    %ebx
80100e03:	5d                   	pop    %ebp
80100e04:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80100e05:	c7 04 24 74 87 10 80 	movl   $0x80108774,(%esp)
80100e0c:	e8 2f f5 ff ff       	call   80100340 <panic>
80100e11:	eb 0d                	jmp    80100e20 <fileclose>
80100e13:	90                   	nop
80100e14:	90                   	nop
80100e15:	90                   	nop
80100e16:	90                   	nop
80100e17:	90                   	nop
80100e18:	90                   	nop
80100e19:	90                   	nop
80100e1a:	90                   	nop
80100e1b:	90                   	nop
80100e1c:	90                   	nop
80100e1d:	90                   	nop
80100e1e:	90                   	nop
80100e1f:	90                   	nop

80100e20 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e20:	55                   	push   %ebp
80100e21:	89 e5                	mov    %esp,%ebp
80100e23:	83 ec 38             	sub    $0x38,%esp
80100e26:	89 7d fc             	mov    %edi,-0x4(%ebp)
80100e29:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100e2c:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e33:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80100e36:	89 75 f8             	mov    %esi,-0x8(%ebp)
  struct file ff;

  acquire(&ftable.lock);
80100e39:	e8 92 4b 00 00       	call   801059d0 <acquire>
  if(f->ref < 1)
80100e3e:	8b 47 04             	mov    0x4(%edi),%eax
80100e41:	85 c0                	test   %eax,%eax
80100e43:	0f 8e a0 00 00 00    	jle    80100ee9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80100e49:	48                   	dec    %eax
80100e4a:	85 c0                	test   %eax,%eax
80100e4c:	89 47 04             	mov    %eax,0x4(%edi)
80100e4f:	74 1f                	je     80100e70 <fileclose+0x50>
    release(&ftable.lock);
80100e51:	c7 45 08 20 20 11 80 	movl   $0x80112020,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e58:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100e5b:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100e5e:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100e61:	89 ec                	mov    %ebp,%esp
80100e63:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
80100e64:	e9 07 4c 00 00       	jmp    80105a70 <release>
80100e69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
80100e70:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80100e74:	8b 1f                	mov    (%edi),%ebx
80100e76:	8b 77 0c             	mov    0xc(%edi),%esi
  f->ref = 0;
  f->type = FD_NONE;
80100e79:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e7f:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e82:	8b 47 10             	mov    0x10(%edi),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e85:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e8c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e8f:	e8 dc 4b 00 00       	call   80105a70 <release>

  if(ff.type == FD_PIPE)
80100e94:	83 fb 01             	cmp    $0x1,%ebx
80100e97:	74 17                	je     80100eb0 <fileclose+0x90>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100e99:	83 fb 02             	cmp    $0x2,%ebx
80100e9c:	74 2a                	je     80100ec8 <fileclose+0xa8>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e9e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100ea1:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100ea4:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100ea7:	89 ec                	mov    %ebp,%esp
80100ea9:	5d                   	pop    %ebp
80100eaa:	c3                   	ret    
80100eab:	90                   	nop
80100eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80100eb0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100eb4:	89 34 24             	mov    %esi,(%esp)
80100eb7:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100ebb:	e8 50 25 00 00       	call   80103410 <pipeclose>
80100ec0:	eb dc                	jmp    80100e9e <fileclose+0x7e>
80100ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80100ec8:	e8 33 1d 00 00       	call   80102c00 <begin_op>
    iput(ff.ip);
80100ecd:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ed0:	89 04 24             	mov    %eax,(%esp)
80100ed3:	e8 48 09 00 00       	call   80101820 <iput>
    end_op();
  }
}
80100ed8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100edb:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100ede:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100ee1:	89 ec                	mov    %ebp,%esp
80100ee3:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
80100ee4:	e9 87 1d 00 00       	jmp    80102c70 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80100ee9:	c7 04 24 7c 87 10 80 	movl   $0x8010877c,(%esp)
80100ef0:	e8 4b f4 ff ff       	call   80100340 <panic>
80100ef5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f00 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f00:	55                   	push   %ebp
80100f01:	89 e5                	mov    %esp,%ebp
80100f03:	53                   	push   %ebx
80100f04:	83 ec 14             	sub    $0x14,%esp
80100f07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f0a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f0d:	75 31                	jne    80100f40 <filestat+0x40>
    ilock(f->ip);
80100f0f:	8b 43 10             	mov    0x10(%ebx),%eax
80100f12:	89 04 24             	mov    %eax,(%esp)
80100f15:	e8 d6 07 00 00       	call   801016f0 <ilock>
    stati(f->ip, st);
80100f1a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f1d:	89 44 24 04          	mov    %eax,0x4(%esp)
80100f21:	8b 43 10             	mov    0x10(%ebx),%eax
80100f24:	89 04 24             	mov    %eax,(%esp)
80100f27:	e8 74 0a 00 00       	call   801019a0 <stati>
    iunlock(f->ip);
80100f2c:	8b 43 10             	mov    0x10(%ebx),%eax
80100f2f:	89 04 24             	mov    %eax,(%esp)
80100f32:	e8 99 08 00 00       	call   801017d0 <iunlock>
    return 0;
  }
  return -1;
}
80100f37:	83 c4 14             	add    $0x14,%esp
{
  if(f->type == FD_INODE){
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
80100f3a:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f3c:	5b                   	pop    %ebx
80100f3d:	5d                   	pop    %ebp
80100f3e:	c3                   	ret    
80100f3f:	90                   	nop
80100f40:	83 c4 14             	add    $0x14,%esp
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80100f43:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f48:	5b                   	pop    %ebx
80100f49:	5d                   	pop    %ebp
80100f4a:	c3                   	ret    
80100f4b:	90                   	nop
80100f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f50 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f50:	55                   	push   %ebp
80100f51:	89 e5                	mov    %esp,%ebp
80100f53:	83 ec 28             	sub    $0x28,%esp
80100f56:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80100f59:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f5c:	89 75 f8             	mov    %esi,-0x8(%ebp)
80100f5f:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f62:	89 7d fc             	mov    %edi,-0x4(%ebp)
80100f65:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f68:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f6c:	74 72                	je     80100fe0 <fileread+0x90>
    return -1;
  if(f->type == FD_PIPE)
80100f6e:	8b 03                	mov    (%ebx),%eax
80100f70:	83 f8 01             	cmp    $0x1,%eax
80100f73:	74 53                	je     80100fc8 <fileread+0x78>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f75:	83 f8 02             	cmp    $0x2,%eax
80100f78:	75 6d                	jne    80100fe7 <fileread+0x97>
    ilock(f->ip);
80100f7a:	8b 43 10             	mov    0x10(%ebx),%eax
80100f7d:	89 04 24             	mov    %eax,(%esp)
80100f80:	e8 6b 07 00 00       	call   801016f0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f85:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80100f89:	8b 43 14             	mov    0x14(%ebx),%eax
80100f8c:	89 74 24 04          	mov    %esi,0x4(%esp)
80100f90:	89 44 24 08          	mov    %eax,0x8(%esp)
80100f94:	8b 43 10             	mov    0x10(%ebx),%eax
80100f97:	89 04 24             	mov    %eax,(%esp)
80100f9a:	e8 31 0a 00 00       	call   801019d0 <readi>
80100f9f:	85 c0                	test   %eax,%eax
80100fa1:	89 c6                	mov    %eax,%esi
80100fa3:	7e 03                	jle    80100fa8 <fileread+0x58>
      f->off += r;
80100fa5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100fa8:	8b 43 10             	mov    0x10(%ebx),%eax
80100fab:	89 04 24             	mov    %eax,(%esp)
80100fae:	e8 1d 08 00 00       	call   801017d0 <iunlock>
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100fb3:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100fb5:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100fb8:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100fbb:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100fbe:	89 ec                	mov    %ebp,%esp
80100fc0:	5d                   	pop    %ebp
80100fc1:	c3                   	ret    
80100fc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100fc8:	8b 43 0c             	mov    0xc(%ebx),%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100fcb:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100fce:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100fd1:	8b 7d fc             	mov    -0x4(%ebp),%edi
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100fd4:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100fd7:	89 ec                	mov    %ebp,%esp
80100fd9:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100fda:	e9 d1 25 00 00       	jmp    801035b0 <piperead>
80100fdf:	90                   	nop
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
80100fe0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100fe5:	eb ce                	jmp    80100fb5 <fileread+0x65>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
80100fe7:	c7 04 24 86 87 10 80 	movl   $0x80108786,(%esp)
80100fee:	e8 4d f3 ff ff       	call   80100340 <panic>
80100ff3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101000 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101000:	55                   	push   %ebp
80101001:	89 e5                	mov    %esp,%ebp
80101003:	57                   	push   %edi
80101004:	56                   	push   %esi
80101005:	53                   	push   %ebx
80101006:	83 ec 2c             	sub    $0x2c,%esp
80101009:	8b 45 0c             	mov    0xc(%ebp),%eax
8010100c:	8b 7d 08             	mov    0x8(%ebp),%edi
8010100f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101012:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101015:	80 7f 09 00          	cmpb   $0x0,0x9(%edi)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101019:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
8010101c:	0f 84 ae 00 00 00    	je     801010d0 <filewrite+0xd0>
    return -1;
  if(f->type == FD_PIPE)
80101022:	8b 07                	mov    (%edi),%eax
80101024:	83 f8 01             	cmp    $0x1,%eax
80101027:	0f 84 c2 00 00 00    	je     801010ef <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010102d:	83 f8 02             	cmp    $0x2,%eax
80101030:	0f 85 d7 00 00 00    	jne    8010110d <filewrite+0x10d>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101036:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101039:	31 f6                	xor    %esi,%esi
8010103b:	85 c0                	test   %eax,%eax
8010103d:	7f 31                	jg     80101070 <filewrite+0x70>
8010103f:	e9 9c 00 00 00       	jmp    801010e0 <filewrite+0xe0>
80101044:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
      iunlock(f->ip);
80101048:	8b 4f 10             	mov    0x10(%edi),%ecx
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
8010104b:	01 47 14             	add    %eax,0x14(%edi)
8010104e:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101051:	89 0c 24             	mov    %ecx,(%esp)
80101054:	e8 77 07 00 00       	call   801017d0 <iunlock>
      end_op();
80101059:	e8 12 1c 00 00       	call   80102c70 <end_op>
8010105e:	8b 45 e0             	mov    -0x20(%ebp),%eax

      if(r < 0)
        break;
      if(r != n1)
80101061:	39 d8                	cmp    %ebx,%eax
80101063:	0f 85 98 00 00 00    	jne    80101101 <filewrite+0x101>
        panic("short filewrite");
      i += r;
80101069:	01 c6                	add    %eax,%esi
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
8010106b:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010106e:	7e 70                	jle    801010e0 <filewrite+0xe0>
      int n1 = n - i;
80101070:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101073:	b8 00 06 00 00       	mov    $0x600,%eax
80101078:	29 f3                	sub    %esi,%ebx
8010107a:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101080:	0f 4f d8             	cmovg  %eax,%ebx
      if(n1 > max)
        n1 = max;

      begin_op();
80101083:	e8 78 1b 00 00       	call   80102c00 <begin_op>
      ilock(f->ip);
80101088:	8b 47 10             	mov    0x10(%edi),%eax
8010108b:	89 04 24             	mov    %eax,(%esp)
8010108e:	e8 5d 06 00 00       	call   801016f0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101093:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
80101097:	8b 47 14             	mov    0x14(%edi),%eax
8010109a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010109e:	8b 45 dc             	mov    -0x24(%ebp),%eax
801010a1:	01 f0                	add    %esi,%eax
801010a3:	89 44 24 04          	mov    %eax,0x4(%esp)
801010a7:	8b 47 10             	mov    0x10(%edi),%eax
801010aa:	89 04 24             	mov    %eax,(%esp)
801010ad:	e8 2e 0a 00 00       	call   80101ae0 <writei>
801010b2:	85 c0                	test   %eax,%eax
801010b4:	7f 92                	jg     80101048 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
801010b6:	8b 4f 10             	mov    0x10(%edi),%ecx
801010b9:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010bc:	89 0c 24             	mov    %ecx,(%esp)
801010bf:	e8 0c 07 00 00       	call   801017d0 <iunlock>
      end_op();
801010c4:	e8 a7 1b 00 00       	call   80102c70 <end_op>

      if(r < 0)
801010c9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010cc:	85 c0                	test   %eax,%eax
801010ce:	74 91                	je     80101061 <filewrite+0x61>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010d0:	83 c4 2c             	add    $0x2c,%esp
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801010d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
801010d8:	5b                   	pop    %ebx
801010d9:	5e                   	pop    %esi
801010da:	5f                   	pop    %edi
801010db:	5d                   	pop    %ebp
801010dc:	c3                   	ret    
801010dd:	8d 76 00             	lea    0x0(%esi),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801010e0:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
801010e3:	75 eb                	jne    801010d0 <filewrite+0xd0>
  }
  panic("filewrite");
}
801010e5:	83 c4 2c             	add    $0x2c,%esp
801010e8:	89 f0                	mov    %esi,%eax
801010ea:	5b                   	pop    %ebx
801010eb:	5e                   	pop    %esi
801010ec:	5f                   	pop    %edi
801010ed:	5d                   	pop    %ebp
801010ee:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801010ef:	8b 47 0c             	mov    0xc(%edi),%eax
801010f2:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010f5:	83 c4 2c             	add    $0x2c,%esp
801010f8:	5b                   	pop    %ebx
801010f9:	5e                   	pop    %esi
801010fa:	5f                   	pop    %edi
801010fb:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801010fc:	e9 af 23 00 00       	jmp    801034b0 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
80101101:	c7 04 24 8f 87 10 80 	movl   $0x8010878f,(%esp)
80101108:	e8 33 f2 ff ff       	call   80100340 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
8010110d:	c7 04 24 95 87 10 80 	movl   $0x80108795,(%esp)
80101114:	e8 27 f2 ff ff       	call   80100340 <panic>
80101119:	66 90                	xchg   %ax,%ax
8010111b:	66 90                	xchg   %ax,%ax
8010111d:	66 90                	xchg   %ax,%ax
8010111f:	90                   	nop

80101120 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101120:	55                   	push   %ebp
80101121:	89 e5                	mov    %esp,%ebp
80101123:	57                   	push   %edi
80101124:	56                   	push   %esi
80101125:	53                   	push   %ebx
80101126:	83 ec 2c             	sub    $0x2c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101129:	8b 1d 20 2a 11 80    	mov    0x80112a20,%ebx
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
8010112f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101132:	85 db                	test   %ebx,%ebx
80101134:	0f 84 7e 00 00 00    	je     801011b8 <balloc+0x98>
8010113a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101141:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101144:	8b 0d 38 2a 11 80    	mov    0x80112a38,%ecx
8010114a:	89 f0                	mov    %esi,%eax
8010114c:	c1 f8 0c             	sar    $0xc,%eax
8010114f:	01 c8                	add    %ecx,%eax
80101151:	89 44 24 04          	mov    %eax,0x4(%esp)
80101155:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101158:	89 04 24             	mov    %eax,(%esp)
8010115b:	e8 70 ef ff ff       	call   801000d0 <bread>
80101160:	89 c2                	mov    %eax,%edx
80101162:	a1 20 2a 11 80       	mov    0x80112a20,%eax
80101167:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010116a:	31 c0                	xor    %eax,%eax
8010116c:	eb 2b                	jmp    80101199 <balloc+0x79>
8010116e:	66 90                	xchg   %ax,%ax
      m = 1 << (bi % 8);
80101170:	89 c1                	mov    %eax,%ecx
80101172:	bf 01 00 00 00       	mov    $0x1,%edi
80101177:	83 e1 07             	and    $0x7,%ecx
8010117a:	d3 e7                	shl    %cl,%edi
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010117c:	89 c1                	mov    %eax,%ecx
8010117e:	c1 f9 03             	sar    $0x3,%ecx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
80101181:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101184:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101189:	85 7d e4             	test   %edi,-0x1c(%ebp)
8010118c:	89 fb                	mov    %edi,%ebx
8010118e:	74 38                	je     801011c8 <balloc+0xa8>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101190:	40                   	inc    %eax
80101191:	46                   	inc    %esi
80101192:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101197:	74 05                	je     8010119e <balloc+0x7e>
80101199:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010119c:	72 d2                	jb     80101170 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
8010119e:	89 14 24             	mov    %edx,(%esp)
801011a1:	e8 3a f0 ff ff       	call   801001e0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801011a6:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801011ad:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011b0:	39 05 20 2a 11 80    	cmp    %eax,0x80112a20
801011b6:	77 89                	ja     80101141 <balloc+0x21>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
801011b8:	c7 04 24 9f 87 10 80 	movl   $0x8010879f,(%esp)
801011bf:	e8 7c f1 ff ff       	call   80100340 <panic>
801011c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
801011c8:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
        log_write(bp);
801011cc:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
801011cf:	08 d8                	or     %bl,%al
801011d1:	88 44 0a 5c          	mov    %al,0x5c(%edx,%ecx,1)
        log_write(bp);
801011d5:	89 14 24             	mov    %edx,(%esp)
801011d8:	e8 c3 1b 00 00       	call   80102da0 <log_write>
        brelse(bp);
801011dd:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801011e0:	89 14 24             	mov    %edx,(%esp)
801011e3:	e8 f8 ef ff ff       	call   801001e0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
801011e8:	8b 45 d8             	mov    -0x28(%ebp),%eax
801011eb:	89 74 24 04          	mov    %esi,0x4(%esp)
801011ef:	89 04 24             	mov    %eax,(%esp)
801011f2:	e8 d9 ee ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
801011f7:	31 d2                	xor    %edx,%edx
801011f9:	89 54 24 04          	mov    %edx,0x4(%esp)
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
801011fd:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801011ff:	b8 00 02 00 00       	mov    $0x200,%eax
80101204:	89 44 24 08          	mov    %eax,0x8(%esp)
80101208:	8d 43 5c             	lea    0x5c(%ebx),%eax
8010120b:	89 04 24             	mov    %eax,(%esp)
8010120e:	e8 ad 48 00 00       	call   80105ac0 <memset>
  log_write(bp);
80101213:	89 1c 24             	mov    %ebx,(%esp)
80101216:	e8 85 1b 00 00       	call   80102da0 <log_write>
  brelse(bp);
8010121b:	89 1c 24             	mov    %ebx,(%esp)
8010121e:	e8 bd ef ff ff       	call   801001e0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
80101223:	83 c4 2c             	add    $0x2c,%esp
80101226:	89 f0                	mov    %esi,%eax
80101228:	5b                   	pop    %ebx
80101229:	5e                   	pop    %esi
8010122a:	5f                   	pop    %edi
8010122b:	5d                   	pop    %ebp
8010122c:	c3                   	ret    
8010122d:	8d 76 00             	lea    0x0(%esi),%esi

80101230 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101230:	55                   	push   %ebp
80101231:	89 e5                	mov    %esp,%ebp
80101233:	57                   	push   %edi
80101234:	89 c7                	mov    %eax,%edi
80101236:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101237:	31 f6                	xor    %esi,%esi
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101239:	53                   	push   %ebx

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010123a:	bb 74 2a 11 80       	mov    $0x80112a74,%ebx
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
8010123f:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101242:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101249:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
8010124c:	e8 7f 47 00 00       	call   801059d0 <acquire>

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101251:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101254:	eb 1c                	jmp    80101272 <iget+0x42>
80101256:	8d 76 00             	lea    0x0(%esi),%esi
80101259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101260:	85 f6                	test   %esi,%esi
80101262:	74 3c                	je     801012a0 <iget+0x70>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101264:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010126a:	81 fb 94 46 11 80    	cmp    $0x80114694,%ebx
80101270:	74 4e                	je     801012c0 <iget+0x90>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101272:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101275:	85 c9                	test   %ecx,%ecx
80101277:	7e e7                	jle    80101260 <iget+0x30>
80101279:	39 3b                	cmp    %edi,(%ebx)
8010127b:	75 e3                	jne    80101260 <iget+0x30>
8010127d:	39 53 04             	cmp    %edx,0x4(%ebx)
80101280:	75 de                	jne    80101260 <iget+0x30>
      ip->ref++;
80101282:	41                   	inc    %ecx
      release(&icache.lock);
      return ip;
80101283:	89 de                	mov    %ebx,%esi
  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
80101285:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
8010128c:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
8010128f:	e8 dc 47 00 00       	call   80105a70 <release>
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
80101294:	83 c4 2c             	add    $0x2c,%esp
80101297:	89 f0                	mov    %esi,%eax
80101299:	5b                   	pop    %ebx
8010129a:	5e                   	pop    %esi
8010129b:	5f                   	pop    %edi
8010129c:	5d                   	pop    %ebp
8010129d:	c3                   	ret    
8010129e:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801012a0:	85 c9                	test   %ecx,%ecx
801012a2:	0f 44 f3             	cmove  %ebx,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012a5:	81 c3 90 00 00 00    	add    $0x90,%ebx
801012ab:	81 fb 94 46 11 80    	cmp    $0x80114694,%ebx
801012b1:	75 bf                	jne    80101272 <iget+0x42>
801012b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801012b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801012c0:	85 f6                	test   %esi,%esi
801012c2:	74 29                	je     801012ed <iget+0xbd>
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
801012c4:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801012c6:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801012c9:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801012d0:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801012d7:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
801012de:	e8 8d 47 00 00       	call   80105a70 <release>

  return ip;
}
801012e3:	83 c4 2c             	add    $0x2c,%esp
801012e6:	89 f0                	mov    %esi,%eax
801012e8:	5b                   	pop    %ebx
801012e9:	5e                   	pop    %esi
801012ea:	5f                   	pop    %edi
801012eb:	5d                   	pop    %ebp
801012ec:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
801012ed:	c7 04 24 b5 87 10 80 	movl   $0x801087b5,(%esp)
801012f4:	e8 47 f0 ff ff       	call   80100340 <panic>
801012f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

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

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101309:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010130c:	89 c6                	mov    %eax,%esi
8010130e:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80101311:	89 7d fc             	mov    %edi,-0x4(%ebp)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101314:	77 1a                	ja     80101330 <bmap+0x30>
80101316:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
    if((addr = ip->addrs[bn]) == 0)
80101319:	8b 43 5c             	mov    0x5c(%ebx),%eax
8010131c:	85 c0                	test   %eax,%eax
8010131e:	74 70                	je     80101390 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
80101320:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101323:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101326:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101329:	89 ec                	mov    %ebp,%esp
8010132b:	5d                   	pop    %ebp
8010132c:	c3                   	ret    
8010132d:	8d 76 00             	lea    0x0(%esi),%esi
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101330:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101333:	83 fb 7f             	cmp    $0x7f,%ebx
80101336:	0f 87 83 00 00 00    	ja     801013bf <bmap+0xbf>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
8010133c:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101342:	85 c0                	test   %eax,%eax
80101344:	74 6a                	je     801013b0 <bmap+0xb0>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101346:	89 44 24 04          	mov    %eax,0x4(%esp)
8010134a:	8b 06                	mov    (%esi),%eax
8010134c:	89 04 24             	mov    %eax,(%esp)
8010134f:	e8 7c ed ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101354:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101358:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
8010135a:	8b 1a                	mov    (%edx),%ebx
8010135c:	85 db                	test   %ebx,%ebx
8010135e:	75 19                	jne    80101379 <bmap+0x79>
      a[bn] = addr = balloc(ip->dev);
80101360:	8b 06                	mov    (%esi),%eax
80101362:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101365:	e8 b6 fd ff ff       	call   80101120 <balloc>
8010136a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010136d:	89 02                	mov    %eax,(%edx)
8010136f:	89 c3                	mov    %eax,%ebx
      log_write(bp);
80101371:	89 3c 24             	mov    %edi,(%esp)
80101374:	e8 27 1a 00 00       	call   80102da0 <log_write>
    }
    brelse(bp);
80101379:	89 3c 24             	mov    %edi,(%esp)
8010137c:	e8 5f ee ff ff       	call   801001e0 <brelse>
80101381:	89 d8                	mov    %ebx,%eax
    return addr;
  }

  panic("bmap: out of range");
}
80101383:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101386:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101389:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010138c:	89 ec                	mov    %ebp,%esp
8010138e:	5d                   	pop    %ebp
8010138f:	c3                   	ret    
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80101390:	8b 06                	mov    (%esi),%eax
80101392:	e8 89 fd ff ff       	call   80101120 <balloc>
80101397:	89 43 5c             	mov    %eax,0x5c(%ebx)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010139a:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010139d:	8b 75 f8             	mov    -0x8(%ebp),%esi
801013a0:	8b 7d fc             	mov    -0x4(%ebp),%edi
801013a3:	89 ec                	mov    %ebp,%esp
801013a5:	5d                   	pop    %ebp
801013a6:	c3                   	ret    
801013a7:	89 f6                	mov    %esi,%esi
801013a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801013b0:	8b 06                	mov    (%esi),%eax
801013b2:	e8 69 fd ff ff       	call   80101120 <balloc>
801013b7:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801013bd:	eb 87                	jmp    80101346 <bmap+0x46>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
801013bf:	c7 04 24 c5 87 10 80 	movl   $0x801087c5,(%esp)
801013c6:	e8 75 ef ff ff       	call   80100340 <panic>
801013cb:	90                   	nop
801013cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801013d0 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
801013d0:	55                   	push   %ebp
  struct buf *bp;

  bp = bread(dev, 1);
801013d1:	b8 01 00 00 00       	mov    $0x1,%eax
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
801013d6:	89 e5                	mov    %esp,%ebp
801013d8:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;

  bp = bread(dev, 1);
801013db:	89 44 24 04          	mov    %eax,0x4(%esp)
801013df:	8b 45 08             	mov    0x8(%ebp),%eax
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
801013e2:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801013e5:	89 75 fc             	mov    %esi,-0x4(%ebp)
801013e8:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
801013eb:	89 04 24             	mov    %eax,(%esp)
801013ee:	e8 dd ec ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801013f3:	ba 1c 00 00 00       	mov    $0x1c,%edx
801013f8:	89 34 24             	mov    %esi,(%esp)
801013fb:	89 54 24 08          	mov    %edx,0x8(%esp)
void
readsb(int dev, struct superblock *sb)
{
  struct buf *bp;

  bp = bread(dev, 1);
801013ff:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101401:	8d 40 5c             	lea    0x5c(%eax),%eax
80101404:	89 44 24 04          	mov    %eax,0x4(%esp)
80101408:	e8 73 47 00 00       	call   80105b80 <memmove>
  brelse(bp);
}
8010140d:	8b 75 fc             	mov    -0x4(%ebp),%esi
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
80101410:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101413:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80101416:	89 ec                	mov    %ebp,%esp
80101418:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
80101419:	e9 c2 ed ff ff       	jmp    801001e0 <brelse>
8010141e:	66 90                	xchg   %ax,%ax

80101420 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101420:	55                   	push   %ebp
80101421:	89 e5                	mov    %esp,%ebp
80101423:	56                   	push   %esi
80101424:	89 c6                	mov    %eax,%esi
80101426:	53                   	push   %ebx
80101427:	89 d3                	mov    %edx,%ebx
80101429:	83 ec 10             	sub    $0x10,%esp
  struct buf *bp;
  int bi, m;

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
  bi = b % BPB;
  m = 1 << (bi % 8);
80101456:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101458:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
8010145e:	83 e1 07             	and    $0x7,%ecx
80101461:	ba 01 00 00 00       	mov    $0x1,%edx
  if((bp->data[bi/8] & m) == 0)
80101466:	c1 fb 03             	sar    $0x3,%ebx
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101469:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
8010146b:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101470:	85 d1                	test   %edx,%ecx
80101472:	74 23                	je     80101497 <bfree+0x77>
80101474:	89 c6                	mov    %eax,%esi
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101476:	f6 d2                	not    %dl
80101478:	89 c8                	mov    %ecx,%eax
8010147a:	20 d0                	and    %dl,%al
8010147c:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
80101480:	89 34 24             	mov    %esi,(%esp)
80101483:	e8 18 19 00 00       	call   80102da0 <log_write>
  brelse(bp);
80101488:	89 34 24             	mov    %esi,(%esp)
8010148b:	e8 50 ed ff ff       	call   801001e0 <brelse>
}
80101490:	83 c4 10             	add    $0x10,%esp
80101493:	5b                   	pop    %ebx
80101494:	5e                   	pop    %esi
80101495:	5d                   	pop    %ebp
80101496:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
80101497:	c7 04 24 d8 87 10 80 	movl   $0x801087d8,(%esp)
8010149e:	e8 9d ee ff ff       	call   80100340 <panic>
801014a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801014a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801014b0 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
801014b0:	55                   	push   %ebp
  int i = 0;
  
  initlock(&icache.lock, "icache");
801014b1:	b9 eb 87 10 80       	mov    $0x801087eb,%ecx
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
801014b6:	89 e5                	mov    %esp,%ebp
801014b8:	53                   	push   %ebx
801014b9:	bb 80 2a 11 80       	mov    $0x80112a80,%ebx
801014be:	83 ec 24             	sub    $0x24,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
801014c1:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801014c5:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
801014cc:	e8 9f 43 00 00       	call   80105870 <initlock>
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
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
801014e0:	ba f2 87 10 80       	mov    $0x801087f2,%edx
801014e5:	89 1c 24             	mov    %ebx,(%esp)
801014e8:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014ee:	89 54 24 04          	mov    %edx,0x4(%esp)
801014f2:	e8 49 42 00 00       	call   80105740 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
801014f7:	81 fb a0 46 11 80    	cmp    $0x801146a0,%ebx
801014fd:	75 e1                	jne    801014e0 <iinit+0x30>
    initsleeplock(&icache.inode[i].lock, "inode");
  }

  readsb(dev, &sb);
801014ff:	b8 20 2a 11 80       	mov    $0x80112a20,%eax
80101504:	89 44 24 04          	mov    %eax,0x4(%esp)
80101508:	8b 45 08             	mov    0x8(%ebp),%eax
8010150b:	89 04 24             	mov    %eax,(%esp)
8010150e:	e8 bd fe ff ff       	call   801013d0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101513:	a1 38 2a 11 80       	mov    0x80112a38,%eax
80101518:	c7 04 24 58 88 10 80 	movl   $0x80108858,(%esp)
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
80101559:	e8 e2 f0 ff ff       	call   80100640 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
8010155e:	83 c4 24             	add    $0x24,%esp
80101561:	5b                   	pop    %ebx
80101562:	5d                   	pop    %ebp
80101563:	c3                   	ret    
80101564:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010156a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101570 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101570:	55                   	push   %ebp
80101571:	89 e5                	mov    %esp,%ebp
80101573:	57                   	push   %edi
80101574:	56                   	push   %esi
80101575:	53                   	push   %ebx
80101576:	83 ec 2c             	sub    $0x2c,%esp
80101579:	0f bf 45 0c          	movswl 0xc(%ebp),%eax
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010157d:	83 3d 28 2a 11 80 01 	cmpl   $0x1,0x80112a28
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101584:	8b 75 08             	mov    0x8(%ebp),%esi
80101587:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010158a:	0f 86 91 00 00 00    	jbe    80101621 <ialloc+0xb1>
80101590:	bb 01 00 00 00       	mov    $0x1,%ebx
80101595:	eb 1a                	jmp    801015b1 <ialloc+0x41>
80101597:	89 f6                	mov    %esi,%esi
80101599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
801015a0:	89 3c 24             	mov    %edi,(%esp)
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801015a3:	43                   	inc    %ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
801015a4:	e8 37 ec ff ff       	call   801001e0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

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
801015f3:	e8 c8 44 00 00       	call   80105ac0 <memset>
      dip->type = type;
801015f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801015fb:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801015fe:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
80101601:	89 3c 24             	mov    %edi,(%esp)
80101604:	e8 97 17 00 00       	call   80102da0 <log_write>
      brelse(bp);
80101609:	89 3c 24             	mov    %edi,(%esp)
8010160c:	e8 cf eb ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101611:	83 c4 2c             	add    $0x2c,%esp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
80101614:	89 da                	mov    %ebx,%edx
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101616:	5b                   	pop    %ebx
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
80101617:	89 f0                	mov    %esi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101619:	5e                   	pop    %esi
8010161a:	5f                   	pop    %edi
8010161b:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
8010161c:	e9 0f fc ff ff       	jmp    80101230 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
80101621:	c7 04 24 f8 87 10 80 	movl   $0x801087f8,(%esp)
80101628:	e8 13 ed ff ff       	call   80100340 <panic>
8010162d:	8d 76 00             	lea    0x0(%esi),%esi

80101630 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
80101630:	55                   	push   %ebp
80101631:	89 e5                	mov    %esp,%ebp
80101633:	56                   	push   %esi
80101634:	53                   	push   %ebx
80101635:	83 ec 10             	sub    $0x10,%esp
80101638:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010163b:	8b 15 34 2a 11 80    	mov    0x80112a34,%edx
80101641:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101644:	83 c3 5c             	add    $0x5c,%ebx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101647:	c1 e8 03             	shr    $0x3,%eax
8010164a:	01 d0                	add    %edx,%eax
8010164c:	89 44 24 04          	mov    %eax,0x4(%esp)
80101650:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80101653:	89 04 24             	mov    %eax,(%esp)
80101656:	e8 75 ea ff ff       	call   801000d0 <bread>
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
8010165b:	0f bf 53 f4          	movswl -0xc(%ebx),%edx
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010165f:	b9 34 00 00 00       	mov    $0x34,%ecx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101664:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101666:	8b 43 a8             	mov    -0x58(%ebx),%eax
80101669:	83 e0 07             	and    $0x7,%eax
8010166c:	c1 e0 06             	shl    $0x6,%eax
8010166f:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101673:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101676:	83 c0 0c             	add    $0xc,%eax
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
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
801016a2:	e8 d9 44 00 00       	call   80105b80 <memmove>
  log_write(bp);
801016a7:	89 34 24             	mov    %esi,(%esp)
801016aa:	e8 f1 16 00 00       	call   80102da0 <log_write>
  brelse(bp);
801016af:	89 75 08             	mov    %esi,0x8(%ebp)
}
801016b2:	83 c4 10             	add    $0x10,%esp
801016b5:	5b                   	pop    %ebx
801016b6:	5e                   	pop    %esi
801016b7:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
801016b8:	e9 23 eb ff ff       	jmp    801001e0 <brelse>
801016bd:	8d 76 00             	lea    0x0(%esi),%esi

801016c0 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
801016c0:	55                   	push   %ebp
801016c1:	89 e5                	mov    %esp,%ebp
801016c3:	53                   	push   %ebx
801016c4:	83 ec 14             	sub    $0x14,%esp
801016c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801016ca:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
801016d1:	e8 fa 42 00 00       	call   801059d0 <acquire>
  ip->ref++;
801016d6:	ff 43 08             	incl   0x8(%ebx)
  release(&icache.lock);
801016d9:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
801016e0:	e8 8b 43 00 00       	call   80105a70 <release>
  return ip;
}
801016e5:	83 c4 14             	add    $0x14,%esp
801016e8:	89 d8                	mov    %ebx,%eax
801016ea:	5b                   	pop    %ebx
801016eb:	5d                   	pop    %ebp
801016ec:	c3                   	ret    
801016ed:	8d 76 00             	lea    0x0(%esi),%esi

801016f0 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
801016f0:	55                   	push   %ebp
801016f1:	89 e5                	mov    %esp,%ebp
801016f3:	56                   	push   %esi
801016f4:	53                   	push   %ebx
801016f5:	83 ec 10             	sub    $0x10,%esp
801016f8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
801016fb:	85 db                	test   %ebx,%ebx
801016fd:	0f 84 be 00 00 00    	je     801017c1 <ilock+0xd1>
80101703:	8b 43 08             	mov    0x8(%ebx),%eax
80101706:	85 c0                	test   %eax,%eax
80101708:	0f 8e b3 00 00 00    	jle    801017c1 <ilock+0xd1>
    panic("ilock");

  acquiresleep(&ip->lock);
8010170e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101711:	89 04 24             	mov    %eax,(%esp)
80101714:	e8 67 40 00 00       	call   80105780 <acquiresleep>

  if(ip->valid == 0){
80101719:	8b 73 4c             	mov    0x4c(%ebx),%esi
8010171c:	85 f6                	test   %esi,%esi
8010171e:	74 10                	je     80101730 <ilock+0x40>
    brelse(bp);
    ip->valid = 1;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
80101720:	83 c4 10             	add    $0x10,%esp
80101723:	5b                   	pop    %ebx
80101724:	5e                   	pop    %esi
80101725:	5d                   	pop    %ebp
80101726:	c3                   	ret    
80101727:	89 f6                	mov    %esi,%esi
80101729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101730:	8b 43 04             	mov    0x4(%ebx),%eax
80101733:	8b 15 34 2a 11 80    	mov    0x80112a34,%edx
80101739:	c1 e8 03             	shr    $0x3,%eax
8010173c:	01 d0                	add    %edx,%eax
8010173e:	89 44 24 04          	mov    %eax,0x4(%esp)
80101742:	8b 03                	mov    (%ebx),%eax
80101744:	89 04 24             	mov    %eax,(%esp)
80101747:	e8 84 e9 ff ff       	call   801000d0 <bread>
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010174c:	b9 34 00 00 00       	mov    $0x34,%ecx
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101751:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101753:	8b 43 04             	mov    0x4(%ebx),%eax
80101756:	83 e0 07             	and    $0x7,%eax
80101759:	c1 e0 06             	shl    $0x6,%eax
8010175c:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101760:	0f bf 10             	movswl (%eax),%edx
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101763:	83 c0 0c             	add    $0xc,%eax
  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
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
80101796:	e8 e5 43 00 00       	call   80105b80 <memmove>
    brelse(bp);
8010179b:	89 34 24             	mov    %esi,(%esp)
8010179e:	e8 3d ea ff ff       	call   801001e0 <brelse>
    ip->valid = 1;
    if(ip->type == 0)
801017a3:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    brelse(bp);
    ip->valid = 1;
801017a8:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801017af:	0f 85 6b ff ff ff    	jne    80101720 <ilock+0x30>
      panic("ilock: no type");
801017b5:	c7 04 24 10 88 10 80 	movl   $0x80108810,(%esp)
801017bc:	e8 7f eb ff ff       	call   80100340 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
801017c1:	c7 04 24 0a 88 10 80 	movl   $0x8010880a,(%esp)
801017c8:	e8 73 eb ff ff       	call   80100340 <panic>
801017cd:	8d 76 00             	lea    0x0(%esi),%esi

801017d0 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
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
801017e9:	e8 32 40 00 00       	call   80105820 <holdingsleep>
801017ee:	85 c0                	test   %eax,%eax
801017f0:	74 18                	je     8010180a <iunlock+0x3a>
801017f2:	8b 43 08             	mov    0x8(%ebx),%eax
801017f5:	85 c0                	test   %eax,%eax
801017f7:	7e 11                	jle    8010180a <iunlock+0x3a>
    panic("iunlock");

  releasesleep(&ip->lock);
801017f9:	89 75 08             	mov    %esi,0x8(%ebp)
}
801017fc:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801017ff:	8b 75 fc             	mov    -0x4(%ebp),%esi
80101802:	89 ec                	mov    %ebp,%esp
80101804:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
80101805:	e9 d6 3f 00 00       	jmp    801057e0 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
8010180a:	c7 04 24 1f 88 10 80 	movl   $0x8010881f,(%esp)
80101811:	e8 2a eb ff ff       	call   80100340 <panic>
80101816:	8d 76 00             	lea    0x0(%esi),%esi
80101819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101820 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101820:	55                   	push   %ebp
80101821:	89 e5                	mov    %esp,%ebp
80101823:	83 ec 38             	sub    $0x38,%esp
80101826:	89 75 f8             	mov    %esi,-0x8(%ebp)
80101829:	8b 75 08             	mov    0x8(%ebp),%esi
8010182c:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010182f:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  acquiresleep(&ip->lock);
80101832:	8d 7e 0c             	lea    0xc(%esi),%edi
80101835:	89 3c 24             	mov    %edi,(%esp)
80101838:	e8 43 3f 00 00       	call   80105780 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
8010183d:	8b 56 4c             	mov    0x4c(%esi),%edx
80101840:	85 d2                	test   %edx,%edx
80101842:	74 07                	je     8010184b <iput+0x2b>
80101844:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
80101849:	74 35                	je     80101880 <iput+0x60>
      ip->type = 0;
      iupdate(ip);
      ip->valid = 0;
    }
  }
  releasesleep(&ip->lock);
8010184b:	89 3c 24             	mov    %edi,(%esp)
8010184e:	e8 8d 3f 00 00       	call   801057e0 <releasesleep>

  acquire(&icache.lock);
80101853:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
8010185a:	e8 71 41 00 00       	call   801059d0 <acquire>
  ip->ref--;
8010185f:	ff 4e 08             	decl   0x8(%esi)
  release(&icache.lock);
80101862:	c7 45 08 40 2a 11 80 	movl   $0x80112a40,0x8(%ebp)
}
80101869:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010186c:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010186f:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101872:	89 ec                	mov    %ebp,%esp
80101874:	5d                   	pop    %ebp
  }
  releasesleep(&ip->lock);

  acquire(&icache.lock);
  ip->ref--;
  release(&icache.lock);
80101875:	e9 f6 41 00 00       	jmp    80105a70 <release>
8010187a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
void
iput(struct inode *ip)
{
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
80101880:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101887:	e8 44 41 00 00       	call   801059d0 <acquire>
    int r = ip->ref;
8010188c:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
8010188f:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101896:	e8 d5 41 00 00       	call   80105a70 <release>
    if(r == 1){
8010189b:	4b                   	dec    %ebx
8010189c:	75 ad                	jne    8010184b <iput+0x2b>
8010189e:	8d 8e 8c 00 00 00    	lea    0x8c(%esi),%ecx
801018a4:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801018a7:	8d 5e 5c             	lea    0x5c(%esi),%ebx
801018aa:	89 cf                	mov    %ecx,%edi
801018ac:	eb 09                	jmp    801018b7 <iput+0x97>
801018ae:	66 90                	xchg   %ax,%ax
801018b0:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801018b3:	39 fb                	cmp    %edi,%ebx
801018b5:	74 19                	je     801018d0 <iput+0xb0>
    if(ip->addrs[i]){
801018b7:	8b 13                	mov    (%ebx),%edx
801018b9:	85 d2                	test   %edx,%edx
801018bb:	74 f3                	je     801018b0 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
801018bd:	8b 06                	mov    (%esi),%eax
801018bf:	e8 5c fb ff ff       	call   80101420 <bfree>
      ip->addrs[i] = 0;
801018c4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801018ca:	eb e4                	jmp    801018b0 <iput+0x90>
801018cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
801018d0:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
801018d6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801018d9:	85 c0                	test   %eax,%eax
801018db:	75 33                	jne    80101910 <iput+0xf0>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
801018dd:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
801018e4:	89 34 24             	mov    %esi,(%esp)
801018e7:	e8 44 fd ff ff       	call   80101630 <iupdate>
    int r = ip->ref;
    release(&icache.lock);
    if(r == 1){
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
      ip->type = 0;
801018ec:	66 c7 46 50 00 00    	movw   $0x0,0x50(%esi)
      iupdate(ip);
801018f2:	89 34 24             	mov    %esi,(%esp)
801018f5:	e8 36 fd ff ff       	call   80101630 <iupdate>
      ip->valid = 0;
801018fa:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
80101901:	e9 45 ff ff ff       	jmp    8010184b <iput+0x2b>
80101906:	8d 76 00             	lea    0x0(%esi),%esi
80101909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101910:	89 44 24 04          	mov    %eax,0x4(%esp)
80101914:	8b 06                	mov    (%esi),%eax
80101916:	89 04 24             	mov    %eax,(%esp)
80101919:	e8 b2 e7 ff ff       	call   801000d0 <bread>
8010191e:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101921:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101927:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
8010192a:	8d 58 5c             	lea    0x5c(%eax),%ebx
8010192d:	89 cf                	mov    %ecx,%edi
8010192f:	eb 0e                	jmp    8010193f <iput+0x11f>
80101931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101938:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
8010193b:	39 fb                	cmp    %edi,%ebx
8010193d:	74 0f                	je     8010194e <iput+0x12e>
      if(a[j])
8010193f:	8b 13                	mov    (%ebx),%edx
80101941:	85 d2                	test   %edx,%edx
80101943:	74 f3                	je     80101938 <iput+0x118>
        bfree(ip->dev, a[j]);
80101945:	8b 06                	mov    (%esi),%eax
80101947:	e8 d4 fa ff ff       	call   80101420 <bfree>
8010194c:	eb ea                	jmp    80101938 <iput+0x118>
    }
    brelse(bp);
8010194e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101951:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101954:	89 04 24             	mov    %eax,(%esp)
80101957:	e8 84 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
8010195c:	8b 06                	mov    (%esi),%eax
8010195e:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
80101964:	e8 b7 fa ff ff       	call   80101420 <bfree>
    ip->addrs[NDIRECT] = 0;
80101969:	31 c0                	xor    %eax,%eax
8010196b:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101971:	e9 67 ff ff ff       	jmp    801018dd <iput+0xbd>
80101976:	8d 76 00             	lea    0x0(%esi),%esi
80101979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101980 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
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
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
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
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801019ed:	89 45 e0             	mov    %eax,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801019f0:	0f 84 ba 00 00 00    	je     80101ab0 <readi+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801019f6:	8b 47 58             	mov    0x58(%edi),%eax
801019f9:	39 f0                	cmp    %esi,%eax
801019fb:	0f 82 d7 00 00 00    	jb     80101ad8 <readi+0x108>
80101a01:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101a04:	89 da                	mov    %ebx,%edx
80101a06:	01 f2                	add    %esi,%edx
80101a08:	0f 82 ca 00 00 00    	jb     80101ad8 <readi+0x108>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101a0e:	89 c1                	mov    %eax,%ecx
80101a10:	29 f1                	sub    %esi,%ecx
80101a12:	39 d0                	cmp    %edx,%eax
80101a14:	0f 43 cb             	cmovae %ebx,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a17:	85 c9                	test   %ecx,%ecx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101a19:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a1c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101a23:	74 7f                	je     80101aa4 <readi+0xd4>
80101a25:	89 7d d4             	mov    %edi,-0x2c(%ebp)
80101a28:	90                   	nop
80101a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a30:	8b 7d d4             	mov    -0x2c(%ebp),%edi
80101a33:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101a35:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a3a:	c1 ea 09             	shr    $0x9,%edx
80101a3d:	89 f8                	mov    %edi,%eax
80101a3f:	e8 bc f8 ff ff       	call   80101300 <bmap>
80101a44:	89 44 24 04          	mov    %eax,0x4(%esp)
80101a48:	8b 07                	mov    (%edi),%eax
80101a4a:	89 04 24             	mov    %eax,(%esp)
80101a4d:	e8 7e e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101a52:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a55:	89 f1                	mov    %esi,%ecx
80101a57:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101a5d:	29 cb                	sub    %ecx,%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a5f:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101a61:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    memmove(dst, bp->data + off%BSIZE, m);
80101a64:	89 55 d8             	mov    %edx,-0x28(%ebp)
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101a67:	29 c7                	sub    %eax,%edi
80101a69:	39 fb                	cmp    %edi,%ebx
80101a6b:	0f 47 df             	cmova  %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a6e:	8b 7d dc             	mov    -0x24(%ebp),%edi
80101a71:	8d 44 0a 5c          	lea    0x5c(%edx,%ecx,1),%eax
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a75:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
80101a77:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101a7b:	89 44 24 04          	mov    %eax,0x4(%esp)
80101a7f:	89 3c 24             	mov    %edi,(%esp)
80101a82:	e8 f9 40 00 00       	call   80105b80 <memmove>
    brelse(bp);
80101a87:	8b 55 d8             	mov    -0x28(%ebp),%edx
80101a8a:	89 14 24             	mov    %edx,(%esp)
80101a8d:	e8 4e e7 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a92:	89 f9                	mov    %edi,%ecx
80101a94:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101a97:	01 d9                	add    %ebx,%ecx
80101a99:	89 4d dc             	mov    %ecx,-0x24(%ebp)
80101a9c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101a9f:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101aa2:	77 8c                	ja     80101a30 <readi+0x60>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101aa4:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101aa7:	83 c4 3c             	add    $0x3c,%esp
80101aaa:	5b                   	pop    %ebx
80101aab:	5e                   	pop    %esi
80101aac:	5f                   	pop    %edi
80101aad:	5d                   	pop    %ebp
80101aae:	c3                   	ret    
80101aaf:	90                   	nop
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101ab0:	0f bf 47 52          	movswl 0x52(%edi),%eax
80101ab4:	66 83 f8 09          	cmp    $0x9,%ax
80101ab8:	77 1e                	ja     80101ad8 <readi+0x108>
80101aba:	8b 04 c5 c0 29 11 80 	mov    -0x7feed640(,%eax,8),%eax
80101ac1:	85 c0                	test   %eax,%eax
80101ac3:	74 13                	je     80101ad8 <readi+0x108>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101ac5:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101ac8:	89 75 10             	mov    %esi,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
80101acb:	83 c4 3c             	add    $0x3c,%esp
80101ace:	5b                   	pop    %ebx
80101acf:	5e                   	pop    %esi
80101ad0:	5f                   	pop    %edi
80101ad1:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101ad2:	ff e0                	jmp    *%eax
80101ad4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101ad8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101add:	eb c8                	jmp    80101aa7 <readi+0xd7>
80101adf:	90                   	nop

80101ae0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101ae0:	55                   	push   %ebp
80101ae1:	89 e5                	mov    %esp,%ebp
80101ae3:	57                   	push   %edi
80101ae4:	56                   	push   %esi
80101ae5:	53                   	push   %ebx
80101ae6:	83 ec 2c             	sub    $0x2c,%esp
80101ae9:	8b 45 0c             	mov    0xc(%ebp),%eax
80101aec:	8b 7d 08             	mov    0x8(%ebp),%edi
80101aef:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101af2:	8b 45 10             	mov    0x10(%ebp),%eax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101af5:	66 83 7f 50 03       	cmpw   $0x3,0x50(%edi)
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101afa:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101afd:	8b 45 14             	mov    0x14(%ebp),%eax
80101b00:	89 45 dc             	mov    %eax,-0x24(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b03:	0f 84 c7 00 00 00    	je     80101bd0 <writei+0xf0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101b09:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101b0c:	39 77 58             	cmp    %esi,0x58(%edi)
80101b0f:	0f 82 fb 00 00 00    	jb     80101c10 <writei+0x130>
80101b15:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80101b18:	89 c8                	mov    %ecx,%eax
80101b1a:	01 f0                	add    %esi,%eax
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101b1c:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101b21:	0f 87 e9 00 00 00    	ja     80101c10 <writei+0x130>
80101b27:	39 c6                	cmp    %eax,%esi
80101b29:	0f 87 e1 00 00 00    	ja     80101c10 <writei+0x130>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b2f:	85 c9                	test   %ecx,%ecx
80101b31:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101b38:	0f 84 82 00 00 00    	je     80101bc0 <writei+0xe0>
80101b3e:	66 90                	xchg   %ax,%ax
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b40:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101b43:	89 f8                	mov    %edi,%eax
80101b45:	89 da                	mov    %ebx,%edx
80101b47:	c1 ea 09             	shr    $0x9,%edx
80101b4a:	e8 b1 f7 ff ff       	call   80101300 <bmap>
80101b4f:	89 44 24 04          	mov    %eax,0x4(%esp)
80101b53:	8b 07                	mov    (%edi),%eax
80101b55:	89 04 24             	mov    %eax,(%esp)
80101b58:	e8 73 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b5d:	89 d9                	mov    %ebx,%ecx
80101b5f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101b62:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101b68:	89 5d e0             	mov    %ebx,-0x20(%ebp)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b6b:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80101b6d:	b8 00 02 00 00       	mov    $0x200,%eax
80101b72:	29 c8                	sub    %ecx,%eax
80101b74:	89 c3                	mov    %eax,%ebx
80101b76:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101b79:	29 d0                	sub    %edx,%eax
80101b7b:	39 c3                	cmp    %eax,%ebx
80101b7d:	0f 47 d8             	cmova  %eax,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101b80:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b83:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101b87:	89 44 24 04          	mov    %eax,0x4(%esp)
80101b8b:	8d 44 0e 5c          	lea    0x5c(%esi,%ecx,1),%eax
80101b8f:	89 04 24             	mov    %eax,(%esp)
80101b92:	e8 e9 3f 00 00       	call   80105b80 <memmove>
    log_write(bp);
80101b97:	89 34 24             	mov    %esi,(%esp)
80101b9a:	e8 01 12 00 00       	call   80102da0 <log_write>
    brelse(bp);
80101b9f:	89 34 24             	mov    %esi,(%esp)
80101ba2:	e8 39 e6 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ba7:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101baa:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101bad:	01 5d d8             	add    %ebx,-0x28(%ebp)
80101bb0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101bb3:	39 55 dc             	cmp    %edx,-0x24(%ebp)
80101bb6:	77 88                	ja     80101b40 <writei+0x60>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80101bb8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101bbb:	3b 47 58             	cmp    0x58(%edi),%eax
80101bbe:	77 38                	ja     80101bf8 <writei+0x118>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101bc0:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
80101bc3:	83 c4 2c             	add    $0x2c,%esp
80101bc6:	5b                   	pop    %ebx
80101bc7:	5e                   	pop    %esi
80101bc8:	5f                   	pop    %edi
80101bc9:	5d                   	pop    %ebp
80101bca:	c3                   	ret    
80101bcb:	90                   	nop
80101bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101bd0:	0f bf 47 52          	movswl 0x52(%edi),%eax
80101bd4:	66 83 f8 09          	cmp    $0x9,%ax
80101bd8:	77 36                	ja     80101c10 <writei+0x130>
80101bda:	8b 04 c5 c4 29 11 80 	mov    -0x7feed63c(,%eax,8),%eax
80101be1:	85 c0                	test   %eax,%eax
80101be3:	74 2b                	je     80101c10 <writei+0x130>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101be5:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101be8:	89 75 10             	mov    %esi,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101beb:	83 c4 2c             	add    $0x2c,%esp
80101bee:	5b                   	pop    %ebx
80101bef:	5e                   	pop    %esi
80101bf0:	5f                   	pop    %edi
80101bf1:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101bf2:	ff e0                	jmp    *%eax
80101bf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101bf8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101bfb:	89 47 58             	mov    %eax,0x58(%edi)
    iupdate(ip);
80101bfe:	89 3c 24             	mov    %edi,(%esp)
80101c01:	e8 2a fa ff ff       	call   80101630 <iupdate>
80101c06:	eb b8                	jmp    80101bc0 <writei+0xe0>
80101c08:	90                   	nop
80101c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101c10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c15:	eb ac                	jmp    80101bc3 <writei+0xe3>
80101c17:	89 f6                	mov    %esi,%esi
80101c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c20 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101c20:	55                   	push   %ebp
  return strncmp(s, t, DIRSIZ);
80101c21:	b8 0e 00 00 00       	mov    $0xe,%eax
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101c26:	89 e5                	mov    %esp,%ebp
80101c28:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
80101c2b:	89 44 24 08          	mov    %eax,0x8(%esp)
80101c2f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c32:	89 44 24 04          	mov    %eax,0x4(%esp)
80101c36:	8b 45 08             	mov    0x8(%ebp),%eax
80101c39:	89 04 24             	mov    %eax,(%esp)
80101c3c:	e8 af 3f 00 00       	call   80105bf0 <strncmp>
}
80101c41:	c9                   	leave  
80101c42:	c3                   	ret    
80101c43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c50 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101c50:	55                   	push   %ebp
80101c51:	89 e5                	mov    %esp,%ebp
80101c53:	57                   	push   %edi
80101c54:	56                   	push   %esi
80101c55:	53                   	push   %ebx
80101c56:	83 ec 2c             	sub    $0x2c,%esp
80101c59:	8b 7d 08             	mov    0x8(%ebp),%edi
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101c5c:	66 83 7f 50 01       	cmpw   $0x1,0x50(%edi)
80101c61:	0f 85 97 00 00 00    	jne    80101cfe <dirlookup+0xae>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101c67:	8b 47 58             	mov    0x58(%edi),%eax
80101c6a:	31 f6                	xor    %esi,%esi
80101c6c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
80101c6f:	85 c0                	test   %eax,%eax
80101c71:	75 0d                	jne    80101c80 <dirlookup+0x30>
80101c73:	eb 73                	jmp    80101ce8 <dirlookup+0x98>
80101c75:	8d 76 00             	lea    0x0(%esi),%esi
80101c78:	83 c6 10             	add    $0x10,%esi
80101c7b:	39 77 58             	cmp    %esi,0x58(%edi)
80101c7e:	76 68                	jbe    80101ce8 <dirlookup+0x98>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101c80:	b9 10 00 00 00       	mov    $0x10,%ecx
80101c85:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80101c89:	89 74 24 08          	mov    %esi,0x8(%esp)
80101c8d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101c91:	89 3c 24             	mov    %edi,(%esp)
80101c94:	e8 37 fd ff ff       	call   801019d0 <readi>
80101c99:	83 f8 10             	cmp    $0x10,%eax
80101c9c:	75 54                	jne    80101cf2 <dirlookup+0xa2>
      panic("dirlookup read");
    if(de.inum == 0)
80101c9e:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101ca3:	74 d3                	je     80101c78 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
80101ca5:	8d 45 da             	lea    -0x26(%ebp),%eax
80101ca8:	ba 0e 00 00 00       	mov    $0xe,%edx
80101cad:	89 44 24 04          	mov    %eax,0x4(%esp)
80101cb1:	8b 45 0c             	mov    0xc(%ebp),%eax
80101cb4:	89 54 24 08          	mov    %edx,0x8(%esp)
80101cb8:	89 04 24             	mov    %eax,(%esp)
80101cbb:	e8 30 3f 00 00       	call   80105bf0 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80101cc0:	85 c0                	test   %eax,%eax
80101cc2:	75 b4                	jne    80101c78 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101cc4:	8b 45 10             	mov    0x10(%ebp),%eax
80101cc7:	85 c0                	test   %eax,%eax
80101cc9:	74 05                	je     80101cd0 <dirlookup+0x80>
        *poff = off;
80101ccb:	8b 45 10             	mov    0x10(%ebp),%eax
80101cce:	89 30                	mov    %esi,(%eax)
      inum = de.inum;
      return iget(dp->dev, inum);
80101cd0:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80101cd4:	8b 07                	mov    (%edi),%eax
80101cd6:	e8 55 f5 ff ff       	call   80101230 <iget>
    }
  }

  return 0;
}
80101cdb:	83 c4 2c             	add    $0x2c,%esp
80101cde:	5b                   	pop    %ebx
80101cdf:	5e                   	pop    %esi
80101ce0:	5f                   	pop    %edi
80101ce1:	5d                   	pop    %ebp
80101ce2:	c3                   	ret    
80101ce3:	90                   	nop
80101ce4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ce8:	83 c4 2c             	add    $0x2c,%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101ceb:	31 c0                	xor    %eax,%eax
}
80101ced:	5b                   	pop    %ebx
80101cee:	5e                   	pop    %esi
80101cef:	5f                   	pop    %edi
80101cf0:	5d                   	pop    %ebp
80101cf1:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
80101cf2:	c7 04 24 39 88 10 80 	movl   $0x80108839,(%esp)
80101cf9:	e8 42 e6 ff ff       	call   80100340 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101cfe:	c7 04 24 27 88 10 80 	movl   $0x80108827,(%esp)
80101d05:	e8 36 e6 ff ff       	call   80100340 <panic>
80101d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101d10 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d10:	55                   	push   %ebp
80101d11:	89 e5                	mov    %esp,%ebp
80101d13:	57                   	push   %edi
80101d14:	89 cf                	mov    %ecx,%edi
80101d16:	56                   	push   %esi
80101d17:	53                   	push   %ebx
80101d18:	89 c3                	mov    %eax,%ebx
80101d1a:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101d1d:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d20:	89 55 e0             	mov    %edx,-0x20(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101d23:	0f 84 49 01 00 00    	je     80101e72 <namex+0x162>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101d29:	e8 a2 1c 00 00       	call   801039d0 <myproc>
80101d2e:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101d31:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101d38:	e8 93 3c 00 00       	call   801059d0 <acquire>
  ip->ref++;
80101d3d:	ff 46 08             	incl   0x8(%esi)
  release(&icache.lock);
80101d40:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101d47:	e8 24 3d 00 00       	call   80105a70 <release>
80101d4c:	eb 03                	jmp    80101d51 <namex+0x41>
80101d4e:	66 90                	xchg   %ax,%ax
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101d50:	43                   	inc    %ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101d51:	0f b6 03             	movzbl (%ebx),%eax
80101d54:	3c 2f                	cmp    $0x2f,%al
80101d56:	74 f8                	je     80101d50 <namex+0x40>
    path++;
  if(*path == 0)
80101d58:	84 c0                	test   %al,%al
80101d5a:	0f 84 e7 00 00 00    	je     80101e47 <namex+0x137>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101d60:	0f b6 03             	movzbl (%ebx),%eax
80101d63:	89 da                	mov    %ebx,%edx
80101d65:	84 c0                	test   %al,%al
80101d67:	0f 84 af 00 00 00    	je     80101e1c <namex+0x10c>
80101d6d:	3c 2f                	cmp    $0x2f,%al
80101d6f:	75 13                	jne    80101d84 <namex+0x74>
80101d71:	e9 a6 00 00 00       	jmp    80101e1c <namex+0x10c>
80101d76:	8d 76 00             	lea    0x0(%esi),%esi
80101d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101d80:	84 c0                	test   %al,%al
80101d82:	74 08                	je     80101d8c <namex+0x7c>
    path++;
80101d84:	42                   	inc    %edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101d85:	0f b6 02             	movzbl (%edx),%eax
80101d88:	3c 2f                	cmp    $0x2f,%al
80101d8a:	75 f4                	jne    80101d80 <namex+0x70>
80101d8c:	89 d1                	mov    %edx,%ecx
80101d8e:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101d90:	83 f9 0d             	cmp    $0xd,%ecx
80101d93:	0f 8e 87 00 00 00    	jle    80101e20 <namex+0x110>
80101d99:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    memmove(name, s, DIRSIZ);
80101d9c:	ba 0e 00 00 00       	mov    $0xe,%edx
80101da1:	89 54 24 08          	mov    %edx,0x8(%esp)
80101da5:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101da9:	89 3c 24             	mov    %edi,(%esp)
80101dac:	e8 cf 3d 00 00       	call   80105b80 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101db1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101db4:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101db6:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101db9:	75 0b                	jne    80101dc6 <namex+0xb6>
80101dbb:	90                   	nop
80101dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101dc0:	43                   	inc    %ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101dc1:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101dc4:	74 fa                	je     80101dc0 <namex+0xb0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101dc6:	89 34 24             	mov    %esi,(%esp)
80101dc9:	e8 22 f9 ff ff       	call   801016f0 <ilock>
    if(ip->type != T_DIR){
80101dce:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101dd3:	0f 85 7f 00 00 00    	jne    80101e58 <namex+0x148>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101dd9:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101ddc:	85 c0                	test   %eax,%eax
80101dde:	74 09                	je     80101de9 <namex+0xd9>
80101de0:	80 3b 00             	cmpb   $0x0,(%ebx)
80101de3:	0f 84 9f 00 00 00    	je     80101e88 <namex+0x178>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101de9:	31 c9                	xor    %ecx,%ecx
80101deb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101def:	89 7c 24 04          	mov    %edi,0x4(%esp)
80101df3:	89 34 24             	mov    %esi,(%esp)
80101df6:	e8 55 fe ff ff       	call   80101c50 <dirlookup>
80101dfb:	85 c0                	test   %eax,%eax
80101dfd:	74 59                	je     80101e58 <namex+0x148>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101dff:	89 34 24             	mov    %esi,(%esp)
80101e02:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101e05:	e8 c6 f9 ff ff       	call   801017d0 <iunlock>
  iput(ip);
80101e0a:	89 34 24             	mov    %esi,(%esp)
80101e0d:	e8 0e fa ff ff       	call   80101820 <iput>
80101e12:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e15:	89 c6                	mov    %eax,%esi
80101e17:	e9 35 ff ff ff       	jmp    80101d51 <namex+0x41>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101e1c:	31 c9                	xor    %ecx,%ecx
80101e1e:	66 90                	xchg   %ax,%ax
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101e20:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101e24:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101e28:	89 3c 24             	mov    %edi,(%esp)
80101e2b:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101e2e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101e31:	e8 4a 3d 00 00       	call   80105b80 <memmove>
    name[len] = 0;
80101e36:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101e39:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101e3c:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101e40:	89 d3                	mov    %edx,%ebx
80101e42:	e9 6f ff ff ff       	jmp    80101db6 <namex+0xa6>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101e47:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e4a:	85 c0                	test   %eax,%eax
80101e4c:	75 4c                	jne    80101e9a <namex+0x18a>
80101e4e:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101e50:	83 c4 2c             	add    $0x2c,%esp
80101e53:	5b                   	pop    %ebx
80101e54:	5e                   	pop    %esi
80101e55:	5f                   	pop    %edi
80101e56:	5d                   	pop    %ebp
80101e57:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101e58:	89 34 24             	mov    %esi,(%esp)
80101e5b:	e8 70 f9 ff ff       	call   801017d0 <iunlock>
  iput(ip);
80101e60:	89 34 24             	mov    %esi,(%esp)
80101e63:	e8 b8 f9 ff ff       	call   80101820 <iput>
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101e68:	83 c4 2c             	add    $0x2c,%esp
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101e6b:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101e6d:	5b                   	pop    %ebx
80101e6e:	5e                   	pop    %esi
80101e6f:	5f                   	pop    %edi
80101e70:	5d                   	pop    %ebp
80101e71:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101e72:	ba 01 00 00 00       	mov    $0x1,%edx
80101e77:	b8 01 00 00 00       	mov    $0x1,%eax
80101e7c:	e8 af f3 ff ff       	call   80101230 <iget>
80101e81:	89 c6                	mov    %eax,%esi
80101e83:	e9 c9 fe ff ff       	jmp    80101d51 <namex+0x41>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101e88:	89 34 24             	mov    %esi,(%esp)
80101e8b:	e8 40 f9 ff ff       	call   801017d0 <iunlock>
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101e90:	83 c4 2c             	add    $0x2c,%esp
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
      return ip;
80101e93:	89 f0                	mov    %esi,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101e95:	5b                   	pop    %ebx
80101e96:	5e                   	pop    %esi
80101e97:	5f                   	pop    %edi
80101e98:	5d                   	pop    %ebp
80101e99:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101e9a:	89 34 24             	mov    %esi,(%esp)
80101e9d:	e8 7e f9 ff ff       	call   80101820 <iput>
    return 0;
80101ea2:	31 c0                	xor    %eax,%eax
80101ea4:	eb aa                	jmp    80101e50 <namex+0x140>
80101ea6:	8d 76 00             	lea    0x0(%esi),%esi
80101ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101eb0 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101eb0:	55                   	push   %ebp
80101eb1:	89 e5                	mov    %esp,%ebp
80101eb3:	57                   	push   %edi
80101eb4:	56                   	push   %esi
80101eb5:	53                   	push   %ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101eb6:	31 db                	xor    %ebx,%ebx
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101eb8:	83 ec 2c             	sub    $0x2c,%esp
80101ebb:	8b 7d 08             	mov    0x8(%ebp),%edi
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101ebe:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ec1:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101ec5:	89 3c 24             	mov    %edi,(%esp)
80101ec8:	89 44 24 04          	mov    %eax,0x4(%esp)
80101ecc:	e8 7f fd ff ff       	call   80101c50 <dirlookup>
80101ed1:	85 c0                	test   %eax,%eax
80101ed3:	0f 85 8e 00 00 00    	jne    80101f67 <dirlink+0xb7>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101ed9:	8b 5f 58             	mov    0x58(%edi),%ebx
80101edc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101edf:	85 db                	test   %ebx,%ebx
80101ee1:	74 3a                	je     80101f1d <dirlink+0x6d>
80101ee3:	31 db                	xor    %ebx,%ebx
80101ee5:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101ee8:	eb 0e                	jmp    80101ef8 <dirlink+0x48>
80101eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101ef0:	83 c3 10             	add    $0x10,%ebx
80101ef3:	39 5f 58             	cmp    %ebx,0x58(%edi)
80101ef6:	76 25                	jbe    80101f1d <dirlink+0x6d>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ef8:	b9 10 00 00 00       	mov    $0x10,%ecx
80101efd:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80101f01:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101f05:	89 74 24 04          	mov    %esi,0x4(%esp)
80101f09:	89 3c 24             	mov    %edi,(%esp)
80101f0c:	e8 bf fa ff ff       	call   801019d0 <readi>
80101f11:	83 f8 10             	cmp    $0x10,%eax
80101f14:	75 60                	jne    80101f76 <dirlink+0xc6>
      panic("dirlink read");
    if(de.inum == 0)
80101f16:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101f1b:	75 d3                	jne    80101ef0 <dirlink+0x40>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80101f1d:	b8 0e 00 00 00       	mov    $0xe,%eax
80101f22:	89 44 24 08          	mov    %eax,0x8(%esp)
80101f26:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f29:	89 44 24 04          	mov    %eax,0x4(%esp)
80101f2d:	8d 45 da             	lea    -0x26(%ebp),%eax
80101f30:	89 04 24             	mov    %eax,(%esp)
80101f33:	e8 18 3d 00 00       	call   80105c50 <strncpy>
  de.inum = inum;
80101f38:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f3b:	ba 10 00 00 00       	mov    $0x10,%edx
80101f40:	89 54 24 0c          	mov    %edx,0xc(%esp)
80101f44:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101f48:	89 74 24 04          	mov    %esi,0x4(%esp)
80101f4c:	89 3c 24             	mov    %edi,(%esp)
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
80101f4f:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f53:	e8 88 fb ff ff       	call   80101ae0 <writei>
80101f58:	83 f8 10             	cmp    $0x10,%eax
80101f5b:	75 25                	jne    80101f82 <dirlink+0xd2>
    panic("dirlink");

  return 0;
80101f5d:	31 c0                	xor    %eax,%eax
}
80101f5f:	83 c4 2c             	add    $0x2c,%esp
80101f62:	5b                   	pop    %ebx
80101f63:	5e                   	pop    %esi
80101f64:	5f                   	pop    %edi
80101f65:	5d                   	pop    %ebp
80101f66:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80101f67:	89 04 24             	mov    %eax,(%esp)
80101f6a:	e8 b1 f8 ff ff       	call   80101820 <iput>
    return -1;
80101f6f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f74:	eb e9                	jmp    80101f5f <dirlink+0xaf>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101f76:	c7 04 24 48 88 10 80 	movl   $0x80108848,(%esp)
80101f7d:	e8 be e3 ff ff       	call   80100340 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80101f82:	c7 04 24 ee 8e 10 80 	movl   $0x80108eee,(%esp)
80101f89:	e8 b2 e3 ff ff       	call   80100340 <panic>
80101f8e:	66 90                	xchg   %ax,%ax

80101f90 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80101f90:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101f91:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80101f93:	89 e5                	mov    %esp,%ebp
80101f95:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101f98:	8b 45 08             	mov    0x8(%ebp),%eax
80101f9b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101f9e:	e8 6d fd ff ff       	call   80101d10 <namex>
}
80101fa3:	c9                   	leave  
80101fa4:	c3                   	ret    
80101fa5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101fb0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101fb0:	55                   	push   %ebp
  return namex(path, 1, name);
80101fb1:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80101fb6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101fb8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101fbb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101fbe:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
80101fbf:	e9 4c fd ff ff       	jmp    80101d10 <namex>
80101fc4:	66 90                	xchg   %ax,%ax
80101fc6:	66 90                	xchg   %ax,%ax
80101fc8:	66 90                	xchg   %ax,%ax
80101fca:	66 90                	xchg   %ax,%ax
80101fcc:	66 90                	xchg   %ax,%ax
80101fce:	66 90                	xchg   %ax,%ax

80101fd0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101fd0:	55                   	push   %ebp
80101fd1:	89 e5                	mov    %esp,%ebp
80101fd3:	56                   	push   %esi
80101fd4:	53                   	push   %ebx
80101fd5:	83 ec 10             	sub    $0x10,%esp
  if(b == 0)
80101fd8:	85 c0                	test   %eax,%eax
80101fda:	0f 84 a6 00 00 00    	je     80102086 <idestart+0xb6>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101fe0:	8b 48 08             	mov    0x8(%eax),%ecx
80101fe3:	89 c6                	mov    %eax,%esi
80101fe5:	81 f9 e7 03 00 00    	cmp    $0x3e7,%ecx
80101feb:	0f 87 89 00 00 00    	ja     8010207a <idestart+0xaa>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101ff1:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101ff6:	8d 76 00             	lea    0x0(%esi),%esi
80101ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102000:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102001:	24 c0                	and    $0xc0,%al
80102003:	3c 40                	cmp    $0x40,%al
80102005:	75 f9                	jne    80102000 <idestart+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102007:	31 db                	xor    %ebx,%ebx
80102009:	ba f6 03 00 00       	mov    $0x3f6,%edx
8010200e:	88 d8                	mov    %bl,%al
80102010:	ee                   	out    %al,(%dx)
80102011:	ba f2 01 00 00       	mov    $0x1f2,%edx
80102016:	b0 01                	mov    $0x1,%al
80102018:	ee                   	out    %al,(%dx)
80102019:	ba f3 01 00 00       	mov    $0x1f3,%edx
8010201e:	88 c8                	mov    %cl,%al
80102020:	ee                   	out    %al,(%dx)
80102021:	89 c8                	mov    %ecx,%eax
80102023:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102028:	c1 f8 08             	sar    $0x8,%eax
8010202b:	ee                   	out    %al,(%dx)
8010202c:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102031:	88 d8                	mov    %bl,%al
80102033:	ee                   	out    %al,(%dx)
80102034:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80102038:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010203d:	24 01                	and    $0x1,%al
8010203f:	c0 e0 04             	shl    $0x4,%al
80102042:	0c e0                	or     $0xe0,%al
80102044:	ee                   	out    %al,(%dx)
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
80102045:	f6 06 04             	testb  $0x4,(%esi)
80102048:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010204d:	75 11                	jne    80102060 <idestart+0x90>
8010204f:	b0 20                	mov    $0x20,%al
80102051:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102052:	83 c4 10             	add    $0x10,%esp
80102055:	5b                   	pop    %ebx
80102056:	5e                   	pop    %esi
80102057:	5d                   	pop    %ebp
80102058:	c3                   	ret    
80102059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102060:	b0 30                	mov    $0x30,%al
80102062:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80102063:	b9 80 00 00 00       	mov    $0x80,%ecx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
80102068:	83 c6 5c             	add    $0x5c,%esi
8010206b:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102070:	fc                   	cld    
80102071:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102073:	83 c4 10             	add    $0x10,%esp
80102076:	5b                   	pop    %ebx
80102077:	5e                   	pop    %esi
80102078:	5d                   	pop    %ebp
80102079:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
8010207a:	c7 04 24 b4 88 10 80 	movl   $0x801088b4,(%esp)
80102081:	e8 ba e2 ff ff       	call   80100340 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
80102086:	c7 04 24 ab 88 10 80 	movl   $0x801088ab,(%esp)
8010208d:	e8 ae e2 ff ff       	call   80100340 <panic>
80102092:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801020a0 <ideinit>:
  return 0;
}

void
ideinit(void)
{
801020a0:	55                   	push   %ebp
  int i;

  initlock(&idelock, "ide");
801020a1:	ba c6 88 10 80       	mov    $0x801088c6,%edx
  return 0;
}

void
ideinit(void)
{
801020a6:	89 e5                	mov    %esp,%ebp
801020a8:	83 ec 18             	sub    $0x18,%esp
  int i;

  initlock(&idelock, "ide");
801020ab:	89 54 24 04          	mov    %edx,0x4(%esp)
801020af:	c7 04 24 80 c5 10 80 	movl   $0x8010c580,(%esp)
801020b6:	e8 b5 37 00 00       	call   80105870 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801020bb:	a1 60 4d 11 80       	mov    0x80114d60,%eax
801020c0:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
801020c7:	48                   	dec    %eax
801020c8:	89 44 24 04          	mov    %eax,0x4(%esp)
801020cc:	e8 7f 02 00 00       	call   80102350 <ioapicenable>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020d1:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020d6:	8d 76 00             	lea    0x0(%esi),%esi
801020d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801020e0:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020e1:	24 c0                	and    $0xc0,%al
801020e3:	3c 40                	cmp    $0x40,%al
801020e5:	75 f9                	jne    801020e0 <ideinit+0x40>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801020e7:	ba f6 01 00 00       	mov    $0x1f6,%edx
801020ec:	b0 f0                	mov    $0xf0,%al
801020ee:	ee                   	out    %al,(%dx)
801020ef:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020f4:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020f9:	eb 08                	jmp    80102103 <ideinit+0x63>
801020fb:	90                   	nop
801020fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102100:	49                   	dec    %ecx
80102101:	74 0f                	je     80102112 <ideinit+0x72>
80102103:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102104:	84 c0                	test   %al,%al
80102106:	74 f8                	je     80102100 <ideinit+0x60>
      havedisk1 = 1;
80102108:	b8 01 00 00 00       	mov    $0x1,%eax
8010210d:	a3 60 c5 10 80       	mov    %eax,0x8010c560
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102112:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102117:	b0 e0                	mov    $0xe0,%al
80102119:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
8010211a:	c9                   	leave  
8010211b:	c3                   	ret    
8010211c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102120 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
80102120:	55                   	push   %ebp
80102121:	89 e5                	mov    %esp,%ebp
80102123:	57                   	push   %edi
80102124:	56                   	push   %esi
80102125:	53                   	push   %ebx
80102126:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102129:	c7 04 24 80 c5 10 80 	movl   $0x8010c580,(%esp)
80102130:	e8 9b 38 00 00       	call   801059d0 <acquire>

  if((b = idequeue) == 0){
80102135:	8b 1d 64 c5 10 80    	mov    0x8010c564,%ebx
8010213b:	85 db                	test   %ebx,%ebx
8010213d:	74 30                	je     8010216f <ideintr+0x4f>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
8010213f:	8b 43 58             	mov    0x58(%ebx),%eax
80102142:	a3 64 c5 10 80       	mov    %eax,0x8010c564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102147:	8b 33                	mov    (%ebx),%esi
80102149:	f7 c6 04 00 00 00    	test   $0x4,%esi
8010214f:	74 37                	je     80102188 <ideintr+0x68>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102151:	83 e6 fb             	and    $0xfffffffb,%esi
80102154:	83 ce 02             	or     $0x2,%esi
80102157:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
80102159:	89 1c 24             	mov    %ebx,(%esp)
8010215c:	e8 3f 24 00 00       	call   801045a0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102161:	a1 64 c5 10 80       	mov    0x8010c564,%eax
80102166:	85 c0                	test   %eax,%eax
80102168:	74 05                	je     8010216f <ideintr+0x4f>
    idestart(idequeue);
8010216a:	e8 61 fe ff ff       	call   80101fd0 <idestart>

  // First queued buffer is the active request.
  acquire(&idelock);

  if((b = idequeue) == 0){
    release(&idelock);
8010216f:	c7 04 24 80 c5 10 80 	movl   $0x8010c580,(%esp)
80102176:	e8 f5 38 00 00       	call   80105a70 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
8010217b:	83 c4 1c             	add    $0x1c,%esp
8010217e:	5b                   	pop    %ebx
8010217f:	5e                   	pop    %esi
80102180:	5f                   	pop    %edi
80102181:	5d                   	pop    %ebp
80102182:	c3                   	ret    
80102183:	90                   	nop
80102184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102188:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010218d:	8d 76 00             	lea    0x0(%esi),%esi
80102190:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102191:	88 c1                	mov    %al,%cl
80102193:	80 e1 c0             	and    $0xc0,%cl
80102196:	80 f9 40             	cmp    $0x40,%cl
80102199:	75 f5                	jne    80102190 <ideintr+0x70>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010219b:	a8 21                	test   $0x21,%al
8010219d:	75 b2                	jne    80102151 <ideintr+0x31>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
8010219f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
801021a2:	b9 80 00 00 00       	mov    $0x80,%ecx
801021a7:	ba f0 01 00 00       	mov    $0x1f0,%edx
801021ac:	fc                   	cld    
801021ad:	f3 6d                	rep insl (%dx),%es:(%edi)
801021af:	8b 33                	mov    (%ebx),%esi
801021b1:	eb 9e                	jmp    80102151 <ideintr+0x31>
801021b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801021b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801021c0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801021c0:	55                   	push   %ebp
801021c1:	89 e5                	mov    %esp,%ebp
801021c3:	53                   	push   %ebx
801021c4:	83 ec 14             	sub    $0x14,%esp
801021c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801021ca:	8d 43 0c             	lea    0xc(%ebx),%eax
801021cd:	89 04 24             	mov    %eax,(%esp)
801021d0:	e8 4b 36 00 00       	call   80105820 <holdingsleep>
801021d5:	85 c0                	test   %eax,%eax
801021d7:	0f 84 9f 00 00 00    	je     8010227c <iderw+0xbc>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801021dd:	8b 03                	mov    (%ebx),%eax
801021df:	83 e0 06             	and    $0x6,%eax
801021e2:	83 f8 02             	cmp    $0x2,%eax
801021e5:	0f 84 a9 00 00 00    	je     80102294 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801021eb:	8b 4b 04             	mov    0x4(%ebx),%ecx
801021ee:	85 c9                	test   %ecx,%ecx
801021f0:	74 0e                	je     80102200 <iderw+0x40>
801021f2:	8b 15 60 c5 10 80    	mov    0x8010c560,%edx
801021f8:	85 d2                	test   %edx,%edx
801021fa:	0f 84 88 00 00 00    	je     80102288 <iderw+0xc8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102200:	c7 04 24 80 c5 10 80 	movl   $0x8010c580,(%esp)
80102207:	e8 c4 37 00 00       	call   801059d0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010220c:	8b 15 64 c5 10 80    	mov    0x8010c564,%edx
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
80102212:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102219:	85 d2                	test   %edx,%edx
8010221b:	75 05                	jne    80102222 <iderw+0x62>
8010221d:	eb 4d                	jmp    8010226c <iderw+0xac>
8010221f:	90                   	nop
80102220:	89 c2                	mov    %eax,%edx
80102222:	8b 42 58             	mov    0x58(%edx),%eax
80102225:	85 c0                	test   %eax,%eax
80102227:	75 f7                	jne    80102220 <iderw+0x60>
80102229:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010222c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010222e:	3b 1d 64 c5 10 80    	cmp    0x8010c564,%ebx
80102234:	75 1b                	jne    80102251 <iderw+0x91>
80102236:	eb 3b                	jmp    80102273 <iderw+0xb3>
80102238:	90                   	nop
80102239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
80102240:	b8 80 c5 10 80       	mov    $0x8010c580,%eax
80102245:	89 44 24 04          	mov    %eax,0x4(%esp)
80102249:	89 1c 24             	mov    %ebx,(%esp)
8010224c:	e8 2f 21 00 00       	call   80104380 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102251:	8b 03                	mov    (%ebx),%eax
80102253:	83 e0 06             	and    $0x6,%eax
80102256:	83 f8 02             	cmp    $0x2,%eax
80102259:	75 e5                	jne    80102240 <iderw+0x80>
    sleep(b, &idelock);
  }


  release(&idelock);
8010225b:	c7 45 08 80 c5 10 80 	movl   $0x8010c580,0x8(%ebp)
}
80102262:	83 c4 14             	add    $0x14,%esp
80102265:	5b                   	pop    %ebx
80102266:	5d                   	pop    %ebp
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }


  release(&idelock);
80102267:	e9 04 38 00 00       	jmp    80105a70 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010226c:	ba 64 c5 10 80       	mov    $0x8010c564,%edx
80102271:	eb b9                	jmp    8010222c <iderw+0x6c>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
80102273:	89 d8                	mov    %ebx,%eax
80102275:	e8 56 fd ff ff       	call   80101fd0 <idestart>
8010227a:	eb d5                	jmp    80102251 <iderw+0x91>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
8010227c:	c7 04 24 ca 88 10 80 	movl   $0x801088ca,(%esp)
80102283:	e8 b8 e0 ff ff       	call   80100340 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
80102288:	c7 04 24 f5 88 10 80 	movl   $0x801088f5,(%esp)
8010228f:	e8 ac e0 ff ff       	call   80100340 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
80102294:	c7 04 24 e0 88 10 80 	movl   $0x801088e0,(%esp)
8010229b:	e8 a0 e0 ff ff       	call   80100340 <panic>

801022a0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801022a0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801022a1:	b8 00 00 c0 fe       	mov    $0xfec00000,%eax
  ioapic->data = data;
}

void
ioapicinit(void)
{
801022a6:	89 e5                	mov    %esp,%ebp
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
801022a8:	ba 01 00 00 00       	mov    $0x1,%edx
  ioapic->data = data;
}

void
ioapicinit(void)
{
801022ad:	56                   	push   %esi
801022ae:	53                   	push   %ebx
801022af:	83 ec 10             	sub    $0x10,%esp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801022b2:	a3 94 46 11 80       	mov    %eax,0x80114694
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
801022b7:	89 15 00 00 c0 fe    	mov    %edx,0xfec00000
  return ioapic->data;
801022bd:	8b 15 94 46 11 80    	mov    0x80114694,%edx
801022c3:	8b 42 10             	mov    0x10(%edx),%eax
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
801022c6:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801022cc:	8b 0d 94 46 11 80    	mov    0x80114694,%ecx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801022d2:	0f b6 15 c0 47 11 80 	movzbl 0x801147c0,%edx
ioapicinit(void)
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801022d9:	c1 e8 10             	shr    $0x10,%eax
801022dc:	0f b6 f0             	movzbl %al,%esi

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
801022df:	8b 41 10             	mov    0x10(%ecx),%eax
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801022e2:	c1 e8 18             	shr    $0x18,%eax
801022e5:	39 d0                	cmp    %edx,%eax
801022e7:	74 12                	je     801022fb <ioapicinit+0x5b>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801022e9:	c7 04 24 14 89 10 80 	movl   $0x80108914,(%esp)
801022f0:	e8 4b e3 ff ff       	call   80100640 <cprintf>
801022f5:	8b 0d 94 46 11 80    	mov    0x80114694,%ecx
801022fb:	83 c6 21             	add    $0x21,%esi
  ioapic->data = data;
}

void
ioapicinit(void)
{
801022fe:	ba 10 00 00 00       	mov    $0x10,%edx
80102303:	b8 20 00 00 00       	mov    $0x20,%eax
80102308:	90                   	nop
80102309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102310:	89 11                	mov    %edx,(%ecx)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102312:	89 c3                	mov    %eax,%ebx
80102314:	40                   	inc    %eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102315:	8b 0d 94 46 11 80    	mov    0x80114694,%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010231b:	81 cb 00 00 01 00    	or     $0x10000,%ebx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102321:	89 59 10             	mov    %ebx,0x10(%ecx)
80102324:	8d 5a 01             	lea    0x1(%edx),%ebx
80102327:	83 c2 02             	add    $0x2,%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010232a:	89 19                	mov    %ebx,(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010232c:	39 f0                	cmp    %esi,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
8010232e:	8b 0d 94 46 11 80    	mov    0x80114694,%ecx
80102334:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010233b:	75 d3                	jne    80102310 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010233d:	83 c4 10             	add    $0x10,%esp
80102340:	5b                   	pop    %ebx
80102341:	5e                   	pop    %esi
80102342:	5d                   	pop    %ebp
80102343:	c3                   	ret    
80102344:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010234a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102350 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102350:	55                   	push   %ebp
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102351:	8b 0d 94 46 11 80    	mov    0x80114694,%ecx
  }
}

void
ioapicenable(int irq, int cpunum)
{
80102357:	89 e5                	mov    %esp,%ebp
80102359:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010235c:	8d 50 20             	lea    0x20(%eax),%edx
8010235f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102363:	89 01                	mov    %eax,(%ecx)
80102365:	40                   	inc    %eax
  ioapic->data = data;
80102366:	8b 0d 94 46 11 80    	mov    0x80114694,%ecx
8010236c:	89 51 10             	mov    %edx,0x10(%ecx)
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010236f:	8b 55 0c             	mov    0xc(%ebp),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102372:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102374:	a1 94 46 11 80       	mov    0x80114694,%eax
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102379:	c1 e2 18             	shl    $0x18,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
8010237c:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
8010237f:	5d                   	pop    %ebp
80102380:	c3                   	ret    
80102381:	66 90                	xchg   %ax,%ax
80102383:	66 90                	xchg   %ax,%ax
80102385:	66 90                	xchg   %ax,%ax
80102387:	66 90                	xchg   %ax,%ax
80102389:	66 90                	xchg   %ax,%ax
8010238b:	66 90                	xchg   %ax,%ax
8010238d:	66 90                	xchg   %ax,%ax
8010238f:	90                   	nop

80102390 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102390:	55                   	push   %ebp
80102391:	89 e5                	mov    %esp,%ebp
80102393:	53                   	push   %ebx
80102394:	83 ec 14             	sub    $0x14,%esp
80102397:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010239a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801023a0:	0f 85 80 00 00 00    	jne    80102426 <kfree+0x96>
801023a6:	81 fb 08 80 11 80    	cmp    $0x80118008,%ebx
801023ac:	72 78                	jb     80102426 <kfree+0x96>
801023ae:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801023b4:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801023b9:	77 6b                	ja     80102426 <kfree+0x96>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801023bb:	ba 00 10 00 00       	mov    $0x1000,%edx
801023c0:	b9 01 00 00 00       	mov    $0x1,%ecx
801023c5:	89 54 24 08          	mov    %edx,0x8(%esp)
801023c9:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801023cd:	89 1c 24             	mov    %ebx,(%esp)
801023d0:	e8 eb 36 00 00       	call   80105ac0 <memset>

  if(kmem.use_lock)
801023d5:	a1 d4 46 11 80       	mov    0x801146d4,%eax
801023da:	85 c0                	test   %eax,%eax
801023dc:	75 3a                	jne    80102418 <kfree+0x88>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801023de:	a1 d8 46 11 80       	mov    0x801146d8,%eax
801023e3:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801023e5:	a1 d4 46 11 80       	mov    0x801146d4,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
801023ea:	89 1d d8 46 11 80    	mov    %ebx,0x801146d8
  if(kmem.use_lock)
801023f0:	85 c0                	test   %eax,%eax
801023f2:	75 0c                	jne    80102400 <kfree+0x70>
    release(&kmem.lock);
}
801023f4:	83 c4 14             	add    $0x14,%esp
801023f7:	5b                   	pop    %ebx
801023f8:	5d                   	pop    %ebp
801023f9:	c3                   	ret    
801023fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102400:	c7 45 08 a0 46 11 80 	movl   $0x801146a0,0x8(%ebp)
}
80102407:	83 c4 14             	add    $0x14,%esp
8010240a:	5b                   	pop    %ebx
8010240b:	5d                   	pop    %ebp
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
8010240c:	e9 5f 36 00 00       	jmp    80105a70 <release>
80102411:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102418:	c7 04 24 a0 46 11 80 	movl   $0x801146a0,(%esp)
8010241f:	e8 ac 35 00 00       	call   801059d0 <acquire>
80102424:	eb b8                	jmp    801023de <kfree+0x4e>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
80102426:	c7 04 24 46 89 10 80 	movl   $0x80108946,(%esp)
8010242d:	e8 0e df ff ff       	call   80100340 <panic>
80102432:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102440 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102440:	55                   	push   %ebp
80102441:	89 e5                	mov    %esp,%ebp
80102443:	56                   	push   %esi
80102444:	53                   	push   %ebx
80102445:	83 ec 10             	sub    $0x10,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102448:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
8010244b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010244e:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102454:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010245a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102460:	39 de                	cmp    %ebx,%esi
80102462:	72 24                	jb     80102488 <freerange+0x48>
80102464:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010246a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    kfree(p);
80102470:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102476:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010247c:	89 04 24             	mov    %eax,(%esp)
8010247f:	e8 0c ff ff ff       	call   80102390 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102484:	39 f3                	cmp    %esi,%ebx
80102486:	76 e8                	jbe    80102470 <freerange+0x30>
    kfree(p);
}
80102488:	83 c4 10             	add    $0x10,%esp
8010248b:	5b                   	pop    %ebx
8010248c:	5e                   	pop    %esi
8010248d:	5d                   	pop    %ebp
8010248e:	c3                   	ret    
8010248f:	90                   	nop

80102490 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102490:	55                   	push   %ebp
  initlock(&kmem.lock, "kmem");
80102491:	b8 4c 89 10 80       	mov    $0x8010894c,%eax
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102496:	89 e5                	mov    %esp,%ebp
80102498:	56                   	push   %esi
80102499:	53                   	push   %ebx
8010249a:	83 ec 10             	sub    $0x10,%esp
  initlock(&kmem.lock, "kmem");
8010249d:	89 44 24 04          	mov    %eax,0x4(%esp)
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
801024a1:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801024a4:	c7 04 24 a0 46 11 80 	movl   $0x801146a0,(%esp)
801024ab:	e8 c0 33 00 00       	call   80105870 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801024b0:	8b 45 08             	mov    0x8(%ebp),%eax
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
801024b3:	31 d2                	xor    %edx,%edx
801024b5:	89 15 d4 46 11 80    	mov    %edx,0x801146d4

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801024bb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801024c1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024c7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801024cd:	39 de                	cmp    %ebx,%esi
801024cf:	72 27                	jb     801024f8 <kinit1+0x68>
801024d1:	eb 0d                	jmp    801024e0 <kinit1+0x50>
801024d3:	90                   	nop
801024d4:	90                   	nop
801024d5:	90                   	nop
801024d6:	90                   	nop
801024d7:	90                   	nop
801024d8:	90                   	nop
801024d9:	90                   	nop
801024da:	90                   	nop
801024db:	90                   	nop
801024dc:	90                   	nop
801024dd:	90                   	nop
801024de:	90                   	nop
801024df:	90                   	nop
    kfree(p);
801024e0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024e6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024ec:	89 04 24             	mov    %eax,(%esp)
801024ef:	e8 9c fe ff ff       	call   80102390 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024f4:	39 de                	cmp    %ebx,%esi
801024f6:	73 e8                	jae    801024e0 <kinit1+0x50>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
801024f8:	83 c4 10             	add    $0x10,%esp
801024fb:	5b                   	pop    %ebx
801024fc:	5e                   	pop    %esi
801024fd:	5d                   	pop    %ebp
801024fe:	c3                   	ret    
801024ff:	90                   	nop

80102500 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102500:	55                   	push   %ebp
80102501:	89 e5                	mov    %esp,%ebp
80102503:	56                   	push   %esi
80102504:	53                   	push   %ebx
80102505:	83 ec 10             	sub    $0x10,%esp

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102508:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
8010250b:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010250e:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102514:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010251a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102520:	39 de                	cmp    %ebx,%esi
80102522:	72 24                	jb     80102548 <kinit2+0x48>
80102524:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010252a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    kfree(p);
80102530:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102536:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010253c:	89 04 24             	mov    %eax,(%esp)
8010253f:	e8 4c fe ff ff       	call   80102390 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102544:	39 de                	cmp    %ebx,%esi
80102546:	73 e8                	jae    80102530 <kinit2+0x30>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
80102548:	b8 01 00 00 00       	mov    $0x1,%eax
8010254d:	a3 d4 46 11 80       	mov    %eax,0x801146d4
}
80102552:	83 c4 10             	add    $0x10,%esp
80102555:	5b                   	pop    %ebx
80102556:	5e                   	pop    %esi
80102557:	5d                   	pop    %ebp
80102558:	c3                   	ret    
80102559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102560 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102560:	55                   	push   %ebp
80102561:	89 e5                	mov    %esp,%ebp
80102563:	83 ec 28             	sub    $0x28,%esp
  struct run *r;

  if(kmem.use_lock)
80102566:	8b 15 d4 46 11 80    	mov    0x801146d4,%edx
8010256c:	85 d2                	test   %edx,%edx
8010256e:	75 38                	jne    801025a8 <kalloc+0x48>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102570:	a1 d8 46 11 80       	mov    0x801146d8,%eax
  if(r)
80102575:	85 c0                	test   %eax,%eax
80102577:	74 0c                	je     80102585 <kalloc+0x25>
    kmem.freelist = r->next;
80102579:	8b 08                	mov    (%eax),%ecx
8010257b:	89 0d d8 46 11 80    	mov    %ecx,0x801146d8
  if(kmem.use_lock)
80102581:	85 d2                	test   %edx,%edx
80102583:	75 0b                	jne    80102590 <kalloc+0x30>
    release(&kmem.lock);
  return (char*)r;
}
80102585:	c9                   	leave  
80102586:	c3                   	ret    
80102587:	89 f6                	mov    %esi,%esi
80102589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    acquire(&kmem.lock);
  r = kmem.freelist;
  if(r)
    kmem.freelist = r->next;
  if(kmem.use_lock)
    release(&kmem.lock);
80102590:	c7 04 24 a0 46 11 80 	movl   $0x801146a0,(%esp)
80102597:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010259a:	e8 d1 34 00 00       	call   80105a70 <release>
8010259f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  return (char*)r;
}
801025a2:	c9                   	leave  
801025a3:	c3                   	ret    
801025a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
801025a8:	c7 04 24 a0 46 11 80 	movl   $0x801146a0,(%esp)
801025af:	e8 1c 34 00 00       	call   801059d0 <acquire>
  r = kmem.freelist;
801025b4:	a1 d8 46 11 80       	mov    0x801146d8,%eax
801025b9:	8b 15 d4 46 11 80    	mov    0x801146d4,%edx
  if(r)
801025bf:	85 c0                	test   %eax,%eax
801025c1:	75 b6                	jne    80102579 <kalloc+0x19>
801025c3:	eb bc                	jmp    80102581 <kalloc+0x21>
801025c5:	66 90                	xchg   %ax,%ax
801025c7:	66 90                	xchg   %ax,%ax
801025c9:	66 90                	xchg   %ax,%ax
801025cb:	66 90                	xchg   %ax,%ax
801025cd:	66 90                	xchg   %ax,%ax
801025cf:	90                   	nop

801025d0 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
801025d0:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801025d1:	ba 64 00 00 00       	mov    $0x64,%edx
801025d6:	89 e5                	mov    %esp,%ebp
801025d8:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801025d9:	24 01                	and    $0x1,%al
801025db:	84 c0                	test   %al,%al
801025dd:	0f 84 ad 00 00 00    	je     80102690 <kbdgetc+0xc0>
801025e3:	ba 60 00 00 00       	mov    $0x60,%edx
801025e8:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
801025e9:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
801025ec:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
801025f2:	74 7c                	je     80102670 <kbdgetc+0xa0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801025f4:	84 c0                	test   %al,%al
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801025f6:	8b 0d b4 c5 10 80    	mov    0x8010c5b4,%ecx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801025fc:	79 2a                	jns    80102628 <kbdgetc+0x58>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801025fe:	f6 c1 40             	test   $0x40,%cl
80102601:	75 05                	jne    80102608 <kbdgetc+0x38>
80102603:	24 7f                	and    $0x7f,%al
80102605:	0f b6 d0             	movzbl %al,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102608:	0f b6 82 80 8a 10 80 	movzbl -0x7fef7580(%edx),%eax
8010260f:	0c 40                	or     $0x40,%al
80102611:	0f b6 c0             	movzbl %al,%eax
80102614:	f7 d0                	not    %eax
80102616:	21 c8                	and    %ecx,%eax
80102618:	a3 b4 c5 10 80       	mov    %eax,0x8010c5b4
    return 0;
8010261d:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010261f:	5d                   	pop    %ebp
80102620:	c3                   	ret    
80102621:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102628:	f6 c1 40             	test   $0x40,%cl
8010262b:	74 08                	je     80102635 <kbdgetc+0x65>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010262d:	0c 80                	or     $0x80,%al
    shift &= ~E0ESC;
8010262f:	83 e1 bf             	and    $0xffffffbf,%ecx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102632:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80102635:	0f b6 82 80 8a 10 80 	movzbl -0x7fef7580(%edx),%eax
8010263c:	09 c1                	or     %eax,%ecx
8010263e:	0f b6 82 80 89 10 80 	movzbl -0x7fef7680(%edx),%eax
80102645:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102647:	89 c8                	mov    %ecx,%eax
80102649:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010264c:	f6 c1 08             	test   $0x8,%cl
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
8010264f:	8b 04 85 60 89 10 80 	mov    -0x7fef76a0(,%eax,4),%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80102656:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
  c = charcode[shift & (CTL | SHIFT)][data];
8010265c:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102660:	74 bd                	je     8010261f <kbdgetc+0x4f>
    if('a' <= c && c <= 'z')
80102662:	8d 50 9f             	lea    -0x61(%eax),%edx
80102665:	83 fa 19             	cmp    $0x19,%edx
80102668:	77 16                	ja     80102680 <kbdgetc+0xb0>
      c += 'A' - 'a';
8010266a:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010266d:	5d                   	pop    %ebp
8010266e:	c3                   	ret    
8010266f:	90                   	nop
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
80102670:	31 c0                	xor    %eax,%eax
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102672:	83 0d b4 c5 10 80 40 	orl    $0x40,0x8010c5b4
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102679:	5d                   	pop    %ebp
8010267a:	c3                   	ret    
8010267b:	90                   	nop
8010267c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
80102680:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102683:	8d 50 20             	lea    0x20(%eax),%edx
80102686:	83 f9 19             	cmp    $0x19,%ecx
80102689:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
8010268c:	5d                   	pop    %ebp
8010268d:	c3                   	ret    
8010268e:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
80102690:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102695:	5d                   	pop    %ebp
80102696:	c3                   	ret    
80102697:	89 f6                	mov    %esi,%esi
80102699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801026a0 <kbdintr>:

void
kbdintr(void)
{
801026a0:	55                   	push   %ebp
801026a1:	89 e5                	mov    %esp,%ebp
801026a3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
801026a6:	c7 04 24 d0 25 10 80 	movl   $0x801025d0,(%esp)
801026ad:	e8 fe e0 ff ff       	call   801007b0 <consoleintr>
}
801026b2:	c9                   	leave  
801026b3:	c3                   	ret    
801026b4:	66 90                	xchg   %ax,%ax
801026b6:	66 90                	xchg   %ax,%ax
801026b8:	66 90                	xchg   %ax,%ax
801026ba:	66 90                	xchg   %ax,%ax
801026bc:	66 90                	xchg   %ax,%ax
801026be:	66 90                	xchg   %ax,%ax

801026c0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801026c0:	a1 dc 46 11 80       	mov    0x801146dc,%eax
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
801026c5:	55                   	push   %ebp
801026c6:	89 e5                	mov    %esp,%ebp
  if(!lapic)
801026c8:	85 c0                	test   %eax,%eax
801026ca:	0f 84 c6 00 00 00    	je     80102796 <lapicinit+0xd6>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026d0:	ba 3f 01 00 00       	mov    $0x13f,%edx
801026d5:	b9 0b 00 00 00       	mov    $0xb,%ecx
801026da:	89 90 f0 00 00 00    	mov    %edx,0xf0(%eax)
  lapic[ID];  // wait for write to finish, by reading
801026e0:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026e3:	89 88 e0 03 00 00    	mov    %ecx,0x3e0(%eax)
801026e9:	b9 80 96 98 00       	mov    $0x989680,%ecx
  lapic[ID];  // wait for write to finish, by reading
801026ee:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026f1:	ba 20 00 02 00       	mov    $0x20020,%edx
801026f6:	89 90 20 03 00 00    	mov    %edx,0x320(%eax)
  lapic[ID];  // wait for write to finish, by reading
801026fc:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026ff:	89 88 80 03 00 00    	mov    %ecx,0x380(%eax)
80102705:	b9 00 00 01 00       	mov    $0x10000,%ecx
  lapic[ID];  // wait for write to finish, by reading
8010270a:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010270d:	ba 00 00 01 00       	mov    $0x10000,%edx
80102712:	89 90 50 03 00 00    	mov    %edx,0x350(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102718:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010271b:	89 88 60 03 00 00    	mov    %ecx,0x360(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102721:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102724:	8b 50 30             	mov    0x30(%eax),%edx
80102727:	c1 ea 10             	shr    $0x10,%edx
8010272a:	80 fa 03             	cmp    $0x3,%dl
8010272d:	77 71                	ja     801027a0 <lapicinit+0xe0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010272f:	b9 33 00 00 00       	mov    $0x33,%ecx
80102734:	89 88 70 03 00 00    	mov    %ecx,0x370(%eax)
8010273a:	31 c9                	xor    %ecx,%ecx
  lapic[ID];  // wait for write to finish, by reading
8010273c:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010273f:	31 d2                	xor    %edx,%edx
80102741:	89 90 80 02 00 00    	mov    %edx,0x280(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102747:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010274a:	89 88 80 02 00 00    	mov    %ecx,0x280(%eax)
80102750:	31 c9                	xor    %ecx,%ecx
  lapic[ID];  // wait for write to finish, by reading
80102752:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102755:	31 d2                	xor    %edx,%edx
80102757:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010275d:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102760:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102766:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102769:	ba 00 85 08 00       	mov    $0x88500,%edx
8010276e:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102774:	8b 50 20             	mov    0x20(%eax),%edx
80102777:	89 f6                	mov    %esi,%esi
80102779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102780:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102786:	f6 c6 10             	test   $0x10,%dh
80102789:	75 f5                	jne    80102780 <lapicinit+0xc0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010278b:	31 d2                	xor    %edx,%edx
8010278d:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102793:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102796:	5d                   	pop    %ebp
80102797:	c3                   	ret    
80102798:	90                   	nop
80102799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027a0:	b9 00 00 01 00       	mov    $0x10000,%ecx
801027a5:	89 88 40 03 00 00    	mov    %ecx,0x340(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027ab:	8b 50 20             	mov    0x20(%eax),%edx
801027ae:	e9 7c ff ff ff       	jmp    8010272f <lapicinit+0x6f>
801027b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801027b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027c0 <lapicid>:
}

int
lapicid(void)
{
  if (!lapic)
801027c0:	a1 dc 46 11 80       	mov    0x801146dc,%eax
  lapicw(TPR, 0);
}

int
lapicid(void)
{
801027c5:	55                   	push   %ebp
801027c6:	89 e5                	mov    %esp,%ebp
  if (!lapic)
801027c8:	85 c0                	test   %eax,%eax
801027ca:	74 0c                	je     801027d8 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
801027cc:	8b 40 20             	mov    0x20(%eax),%eax
}
801027cf:	5d                   	pop    %ebp
int
lapicid(void)
{
  if (!lapic)
    return 0;
  return lapic[ID] >> 24;
801027d0:	c1 e8 18             	shr    $0x18,%eax
}
801027d3:	c3                   	ret    
801027d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

int
lapicid(void)
{
  if (!lapic)
    return 0;
801027d8:	31 c0                	xor    %eax,%eax
  return lapic[ID] >> 24;
}
801027da:	5d                   	pop    %ebp
801027db:	c3                   	ret    
801027dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801027e0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801027e0:	a1 dc 46 11 80       	mov    0x801146dc,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
801027e5:	55                   	push   %ebp
801027e6:	89 e5                	mov    %esp,%ebp
  if(lapic)
801027e8:	85 c0                	test   %eax,%eax
801027ea:	74 0b                	je     801027f7 <lapiceoi+0x17>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027ec:	31 d2                	xor    %edx,%edx
801027ee:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027f4:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
801027f7:	5d                   	pop    %ebp
801027f8:	c3                   	ret    
801027f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102800 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102800:	55                   	push   %ebp
80102801:	89 e5                	mov    %esp,%ebp
}
80102803:	5d                   	pop    %ebp
80102804:	c3                   	ret    
80102805:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102810 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102810:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102811:	ba 70 00 00 00       	mov    $0x70,%edx
80102816:	89 e5                	mov    %esp,%ebp
80102818:	b0 0f                	mov    $0xf,%al
8010281a:	53                   	push   %ebx
8010281b:	0f b6 4d 08          	movzbl 0x8(%ebp),%ecx
8010281f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80102822:	ee                   	out    %al,(%dx)
80102823:	ba 71 00 00 00       	mov    $0x71,%edx
80102828:	b0 0a                	mov    $0xa,%al
8010282a:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
8010282b:	31 c0                	xor    %eax,%eax
8010282d:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102833:	89 d8                	mov    %ebx,%eax
80102835:	c1 e8 04             	shr    $0x4,%eax
80102838:	66 a3 69 04 00 80    	mov    %ax,0x80000469

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010283e:	c1 e1 18             	shl    $0x18,%ecx
80102841:	a1 dc 46 11 80       	mov    0x801146dc,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102846:	c1 eb 0c             	shr    $0xc,%ebx
80102849:	81 cb 00 06 00 00    	or     $0x600,%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010284f:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102855:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102858:	ba 00 c5 00 00       	mov    $0xc500,%edx
8010285d:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102863:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102866:	ba 00 85 00 00       	mov    $0x8500,%edx
8010286b:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102871:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102874:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010287a:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010287d:	89 98 00 03 00 00    	mov    %ebx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102883:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102886:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010288c:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010288f:	89 98 00 03 00 00    	mov    %ebx,0x300(%eax)
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
80102895:	5b                   	pop    %ebx
//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
  lapic[ID];  // wait for write to finish, by reading
80102896:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
80102899:	5d                   	pop    %ebp
8010289a:	c3                   	ret    
8010289b:	90                   	nop
8010289c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801028a0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801028a0:	55                   	push   %ebp
801028a1:	ba 70 00 00 00       	mov    $0x70,%edx
801028a6:	89 e5                	mov    %esp,%ebp
801028a8:	b0 0b                	mov    $0xb,%al
801028aa:	57                   	push   %edi
801028ab:	56                   	push   %esi
801028ac:	53                   	push   %ebx
801028ad:	83 ec 5c             	sub    $0x5c,%esp
801028b0:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028b1:	ba 71 00 00 00       	mov    $0x71,%edx
801028b6:	ec                   	in     (%dx),%al
801028b7:	24 04                	and    $0x4,%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028b9:	31 db                	xor    %ebx,%ebx
801028bb:	88 45 b7             	mov    %al,-0x49(%ebp)
801028be:	8d 75 d0             	lea    -0x30(%ebp),%esi
801028c1:	bf 70 00 00 00       	mov    $0x70,%edi
801028c6:	8d 76 00             	lea    0x0(%esi),%esi
801028c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801028d0:	88 d8                	mov    %bl,%al
801028d2:	89 fa                	mov    %edi,%edx
801028d4:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028d5:	b9 71 00 00 00       	mov    $0x71,%ecx
801028da:	89 ca                	mov    %ecx,%edx
801028dc:	ec                   	in     (%dx),%al
}

static void
fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
801028dd:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028e0:	89 fa                	mov    %edi,%edx
801028e2:	89 45 b8             	mov    %eax,-0x48(%ebp)
801028e5:	b0 02                	mov    $0x2,%al
801028e7:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028e8:	89 ca                	mov    %ecx,%edx
801028ea:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
801028eb:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028ee:	89 fa                	mov    %edi,%edx
801028f0:	89 45 bc             	mov    %eax,-0x44(%ebp)
801028f3:	b0 04                	mov    $0x4,%al
801028f5:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028f6:	89 ca                	mov    %ecx,%edx
801028f8:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
801028f9:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028fc:	89 fa                	mov    %edi,%edx
801028fe:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102901:	b0 07                	mov    $0x7,%al
80102903:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102904:	89 ca                	mov    %ecx,%edx
80102906:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102907:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010290a:	89 fa                	mov    %edi,%edx
8010290c:	89 45 c4             	mov    %eax,-0x3c(%ebp)
8010290f:	b0 08                	mov    $0x8,%al
80102911:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102912:	89 ca                	mov    %ecx,%edx
80102914:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102915:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102918:	89 fa                	mov    %edi,%edx
8010291a:	89 45 c8             	mov    %eax,-0x38(%ebp)
8010291d:	b0 09                	mov    $0x9,%al
8010291f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102920:	89 ca                	mov    %ecx,%edx
80102922:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102923:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102926:	89 fa                	mov    %edi,%edx
80102928:	89 45 cc             	mov    %eax,-0x34(%ebp)
8010292b:	b0 0a                	mov    $0xa,%al
8010292d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010292e:	89 ca                	mov    %ecx,%edx
80102930:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102931:	84 c0                	test   %al,%al
80102933:	78 9b                	js     801028d0 <cmostime+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102935:	88 d8                	mov    %bl,%al
80102937:	89 fa                	mov    %edi,%edx
80102939:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010293a:	89 ca                	mov    %ecx,%edx
8010293c:	ec                   	in     (%dx),%al
}

static void
fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
8010293d:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102940:	89 fa                	mov    %edi,%edx
80102942:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102945:	b0 02                	mov    $0x2,%al
80102947:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102948:	89 ca                	mov    %ecx,%edx
8010294a:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
8010294b:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010294e:	89 fa                	mov    %edi,%edx
80102950:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102953:	b0 04                	mov    $0x4,%al
80102955:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102956:	89 ca                	mov    %ecx,%edx
80102958:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
80102959:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010295c:	89 fa                	mov    %edi,%edx
8010295e:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102961:	b0 07                	mov    $0x7,%al
80102963:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102964:	89 ca                	mov    %ecx,%edx
80102966:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102967:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010296a:	89 fa                	mov    %edi,%edx
8010296c:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010296f:	b0 08                	mov    $0x8,%al
80102971:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102972:	89 ca                	mov    %ecx,%edx
80102974:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102975:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102978:	89 fa                	mov    %edi,%edx
8010297a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010297d:	b0 09                	mov    $0x9,%al
8010297f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102980:	89 ca                	mov    %ecx,%edx
80102982:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102983:	0f b6 c0             	movzbl %al,%eax
80102986:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102989:	b8 18 00 00 00       	mov    $0x18,%eax
8010298e:	89 44 24 08          	mov    %eax,0x8(%esp)
80102992:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102995:	89 74 24 04          	mov    %esi,0x4(%esp)
80102999:	89 04 24             	mov    %eax,(%esp)
8010299c:	e8 7f 31 00 00       	call   80105b20 <memcmp>
801029a1:	85 c0                	test   %eax,%eax
801029a3:	0f 85 27 ff ff ff    	jne    801028d0 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
801029a9:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
801029ad:	75 78                	jne    80102a27 <cmostime+0x187>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801029af:	8b 45 b8             	mov    -0x48(%ebp),%eax
801029b2:	89 c2                	mov    %eax,%edx
801029b4:	83 e0 0f             	and    $0xf,%eax
801029b7:	c1 ea 04             	shr    $0x4,%edx
801029ba:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029bd:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029c0:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
801029c3:	8b 45 bc             	mov    -0x44(%ebp),%eax
801029c6:	89 c2                	mov    %eax,%edx
801029c8:	83 e0 0f             	and    $0xf,%eax
801029cb:	c1 ea 04             	shr    $0x4,%edx
801029ce:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029d1:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029d4:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
801029d7:	8b 45 c0             	mov    -0x40(%ebp),%eax
801029da:	89 c2                	mov    %eax,%edx
801029dc:	83 e0 0f             	and    $0xf,%eax
801029df:	c1 ea 04             	shr    $0x4,%edx
801029e2:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029e5:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029e8:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
801029eb:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029ee:	89 c2                	mov    %eax,%edx
801029f0:	83 e0 0f             	and    $0xf,%eax
801029f3:	c1 ea 04             	shr    $0x4,%edx
801029f6:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029f9:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029fc:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
801029ff:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a02:	89 c2                	mov    %eax,%edx
80102a04:	83 e0 0f             	and    $0xf,%eax
80102a07:	c1 ea 04             	shr    $0x4,%edx
80102a0a:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a0d:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a10:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102a13:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a16:	89 c2                	mov    %eax,%edx
80102a18:	83 e0 0f             	and    $0xf,%eax
80102a1b:	c1 ea 04             	shr    $0x4,%edx
80102a1e:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a21:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a24:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102a27:	31 c0                	xor    %eax,%eax
80102a29:	8b 54 05 b8          	mov    -0x48(%ebp,%eax,1),%edx
80102a2d:	8b 75 08             	mov    0x8(%ebp),%esi
80102a30:	89 14 06             	mov    %edx,(%esi,%eax,1)
80102a33:	83 c0 04             	add    $0x4,%eax
80102a36:	83 f8 18             	cmp    $0x18,%eax
80102a39:	72 ee                	jb     80102a29 <cmostime+0x189>
  r->year += 2000;
80102a3b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102a42:	83 c4 5c             	add    $0x5c,%esp
80102a45:	5b                   	pop    %ebx
80102a46:	5e                   	pop    %esi
80102a47:	5f                   	pop    %edi
80102a48:	5d                   	pop    %ebp
80102a49:	c3                   	ret    
80102a4a:	66 90                	xchg   %ax,%ax
80102a4c:	66 90                	xchg   %ax,%ax
80102a4e:	66 90                	xchg   %ax,%ax

80102a50 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a50:	8b 15 28 47 11 80    	mov    0x80114728,%edx
80102a56:	85 d2                	test   %edx,%edx
80102a58:	0f 8e 8a 00 00 00    	jle    80102ae8 <install_trans+0x98>
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102a5e:	55                   	push   %ebp
80102a5f:	89 e5                	mov    %esp,%ebp
80102a61:	57                   	push   %edi
80102a62:	56                   	push   %esi
80102a63:	53                   	push   %ebx
80102a64:	31 db                	xor    %ebx,%ebx
80102a66:	83 ec 1c             	sub    $0x1c,%esp
80102a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102a70:	a1 14 47 11 80       	mov    0x80114714,%eax
80102a75:	01 d8                	add    %ebx,%eax
80102a77:	40                   	inc    %eax
80102a78:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a7c:	a1 24 47 11 80       	mov    0x80114724,%eax
80102a81:	89 04 24             	mov    %eax,(%esp)
80102a84:	e8 47 d6 ff ff       	call   801000d0 <bread>
80102a89:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a8b:	8b 04 9d 2c 47 11 80 	mov    -0x7feeb8d4(,%ebx,4),%eax
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a92:	43                   	inc    %ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a93:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a97:	a1 24 47 11 80       	mov    0x80114724,%eax
80102a9c:	89 04 24             	mov    %eax,(%esp)
80102a9f:	e8 2c d6 ff ff       	call   801000d0 <bread>
80102aa4:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102aa6:	b8 00 02 00 00       	mov    $0x200,%eax
80102aab:	89 44 24 08          	mov    %eax,0x8(%esp)
80102aaf:	8d 47 5c             	lea    0x5c(%edi),%eax
80102ab2:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ab6:	8d 46 5c             	lea    0x5c(%esi),%eax
80102ab9:	89 04 24             	mov    %eax,(%esp)
80102abc:	e8 bf 30 00 00       	call   80105b80 <memmove>
    bwrite(dbuf);  // write dst to disk
80102ac1:	89 34 24             	mov    %esi,(%esp)
80102ac4:	e8 d7 d6 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102ac9:	89 3c 24             	mov    %edi,(%esp)
80102acc:	e8 0f d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102ad1:	89 34 24             	mov    %esi,(%esp)
80102ad4:	e8 07 d7 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ad9:	39 1d 28 47 11 80    	cmp    %ebx,0x80114728
80102adf:	7f 8f                	jg     80102a70 <install_trans+0x20>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102ae1:	83 c4 1c             	add    $0x1c,%esp
80102ae4:	5b                   	pop    %ebx
80102ae5:	5e                   	pop    %esi
80102ae6:	5f                   	pop    %edi
80102ae7:	5d                   	pop    %ebp
80102ae8:	c3                   	ret    
80102ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102af0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102af0:	55                   	push   %ebp
80102af1:	89 e5                	mov    %esp,%ebp
80102af3:	53                   	push   %ebx
80102af4:	83 ec 14             	sub    $0x14,%esp
  struct buf *buf = bread(log.dev, log.start);
80102af7:	a1 14 47 11 80       	mov    0x80114714,%eax
80102afc:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b00:	a1 24 47 11 80       	mov    0x80114724,%eax
80102b05:	89 04 24             	mov    %eax,(%esp)
80102b08:	e8 c3 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b0d:	8b 0d 28 47 11 80    	mov    0x80114728,%ecx
  for (i = 0; i < log.lh.n; i++) {
80102b13:	85 c9                	test   %ecx,%ecx
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b15:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b17:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102b1a:	7e 25                	jle    80102b41 <write_head+0x51>
80102b1c:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80102b23:	31 d2                	xor    %edx,%edx
80102b25:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    hb->block[i] = log.lh.block[i];
80102b30:	8b 8a 2c 47 11 80    	mov    -0x7feeb8d4(%edx),%ecx
80102b36:	89 4c 13 60          	mov    %ecx,0x60(%ebx,%edx,1)
80102b3a:	83 c2 04             	add    $0x4,%edx
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102b3d:	39 c2                	cmp    %eax,%edx
80102b3f:	75 ef                	jne    80102b30 <write_head+0x40>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102b41:	89 1c 24             	mov    %ebx,(%esp)
80102b44:	e8 57 d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102b49:	89 1c 24             	mov    %ebx,(%esp)
80102b4c:	e8 8f d6 ff ff       	call   801001e0 <brelse>
}
80102b51:	83 c4 14             	add    $0x14,%esp
80102b54:	5b                   	pop    %ebx
80102b55:	5d                   	pop    %ebp
80102b56:	c3                   	ret    
80102b57:	89 f6                	mov    %esi,%esi
80102b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b60 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102b60:	55                   	push   %ebp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102b61:	ba 80 8b 10 80       	mov    $0x80108b80,%edx
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102b66:	89 e5                	mov    %esp,%ebp
80102b68:	53                   	push   %ebx
80102b69:	83 ec 34             	sub    $0x34,%esp
80102b6c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102b6f:	89 54 24 04          	mov    %edx,0x4(%esp)
80102b73:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102b7a:	e8 f1 2c 00 00       	call   80105870 <initlock>
  readsb(dev, &sb);
80102b7f:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102b82:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b86:	89 1c 24             	mov    %ebx,(%esp)
80102b89:	e8 42 e8 ff ff       	call   801013d0 <readsb>
  log.start = sb.logstart;
80102b8e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  log.size = sb.nlog;
80102b91:	8b 55 e8             	mov    -0x18(%ebp),%edx

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b94:	89 1c 24             	mov    %ebx,(%esp)
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102b97:	89 1d 24 47 11 80    	mov    %ebx,0x80114724

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b9d:	89 44 24 04          	mov    %eax,0x4(%esp)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102ba1:	a3 14 47 11 80       	mov    %eax,0x80114714
  log.size = sb.nlog;
80102ba6:	89 15 18 47 11 80    	mov    %edx,0x80114718

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102bac:	e8 1f d5 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102bb1:	8b 48 5c             	mov    0x5c(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102bb4:	85 c9                	test   %ecx,%ecx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102bb6:	89 0d 28 47 11 80    	mov    %ecx,0x80114728
  for (i = 0; i < log.lh.n; i++) {
80102bbc:	7e 23                	jle    80102be1 <initlog+0x81>
80102bbe:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102bc5:	31 d2                	xor    %edx,%edx
80102bc7:	89 f6                	mov    %esi,%esi
80102bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log.lh.block[i] = lh->block[i];
80102bd0:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102bd4:	83 c2 04             	add    $0x4,%edx
80102bd7:	89 8a 28 47 11 80    	mov    %ecx,-0x7feeb8d8(%edx)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102bdd:	39 da                	cmp    %ebx,%edx
80102bdf:	75 ef                	jne    80102bd0 <initlog+0x70>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102be1:	89 04 24             	mov    %eax,(%esp)
80102be4:	e8 f7 d5 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102be9:	e8 62 fe ff ff       	call   80102a50 <install_trans>
  log.lh.n = 0;
80102bee:	31 c0                	xor    %eax,%eax
80102bf0:	a3 28 47 11 80       	mov    %eax,0x80114728
  write_head(); // clear the log
80102bf5:	e8 f6 fe ff ff       	call   80102af0 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102bfa:	83 c4 34             	add    $0x34,%esp
80102bfd:	5b                   	pop    %ebx
80102bfe:	5d                   	pop    %ebp
80102bff:	c3                   	ret    

80102c00 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102c00:	55                   	push   %ebp
80102c01:	89 e5                	mov    %esp,%ebp
80102c03:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
80102c06:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102c0d:	e8 be 2d 00 00       	call   801059d0 <acquire>
80102c12:	eb 19                	jmp    80102c2d <begin_op+0x2d>
80102c14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102c18:	b8 e0 46 11 80       	mov    $0x801146e0,%eax
80102c1d:	89 44 24 04          	mov    %eax,0x4(%esp)
80102c21:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102c28:	e8 53 17 00 00       	call   80104380 <sleep>
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102c2d:	8b 15 20 47 11 80    	mov    0x80114720,%edx
80102c33:	85 d2                	test   %edx,%edx
80102c35:	75 e1                	jne    80102c18 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102c37:	a1 1c 47 11 80       	mov    0x8011471c,%eax
80102c3c:	8b 15 28 47 11 80    	mov    0x80114728,%edx
80102c42:	40                   	inc    %eax
80102c43:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102c46:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102c49:	83 fa 1e             	cmp    $0x1e,%edx
80102c4c:	7f ca                	jg     80102c18 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102c4e:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102c55:	a3 1c 47 11 80       	mov    %eax,0x8011471c
      release(&log.lock);
80102c5a:	e8 11 2e 00 00       	call   80105a70 <release>
      break;
    }
  }
}
80102c5f:	c9                   	leave  
80102c60:	c3                   	ret    
80102c61:	eb 0d                	jmp    80102c70 <end_op>
80102c63:	90                   	nop
80102c64:	90                   	nop
80102c65:	90                   	nop
80102c66:	90                   	nop
80102c67:	90                   	nop
80102c68:	90                   	nop
80102c69:	90                   	nop
80102c6a:	90                   	nop
80102c6b:	90                   	nop
80102c6c:	90                   	nop
80102c6d:	90                   	nop
80102c6e:	90                   	nop
80102c6f:	90                   	nop

80102c70 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102c70:	55                   	push   %ebp
80102c71:	89 e5                	mov    %esp,%ebp
80102c73:	57                   	push   %edi
80102c74:	56                   	push   %esi
80102c75:	53                   	push   %ebx
80102c76:	83 ec 1c             	sub    $0x1c,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102c79:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102c80:	e8 4b 2d 00 00       	call   801059d0 <acquire>
  log.outstanding -= 1;
80102c85:	a1 1c 47 11 80       	mov    0x8011471c,%eax
  if(log.committing)
80102c8a:	8b 3d 20 47 11 80    	mov    0x80114720,%edi
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102c90:	48                   	dec    %eax
  if(log.committing)
80102c91:	85 ff                	test   %edi,%edi
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102c93:	a3 1c 47 11 80       	mov    %eax,0x8011471c
  if(log.committing)
80102c98:	0f 85 ed 00 00 00    	jne    80102d8b <end_op+0x11b>
    panic("log.committing");
  if(log.outstanding == 0){
80102c9e:	85 c0                	test   %eax,%eax
80102ca0:	0f 85 c5 00 00 00    	jne    80102d6b <end_op+0xfb>
    do_commit = 1;
    log.committing = 1;
80102ca6:	bb 01 00 00 00       	mov    $0x1,%ebx
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102cab:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102cb2:	89 1d 20 47 11 80    	mov    %ebx,0x80114720
}

static void
commit()
{
  if (log.lh.n > 0) {
80102cb8:	31 db                	xor    %ebx,%ebx
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102cba:	e8 b1 2d 00 00       	call   80105a70 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102cbf:	8b 35 28 47 11 80    	mov    0x80114728,%esi
80102cc5:	85 f6                	test   %esi,%esi
80102cc7:	0f 8e 8b 00 00 00    	jle    80102d58 <end_op+0xe8>
80102ccd:	8d 76 00             	lea    0x0(%esi),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102cd0:	a1 14 47 11 80       	mov    0x80114714,%eax
80102cd5:	01 d8                	add    %ebx,%eax
80102cd7:	40                   	inc    %eax
80102cd8:	89 44 24 04          	mov    %eax,0x4(%esp)
80102cdc:	a1 24 47 11 80       	mov    0x80114724,%eax
80102ce1:	89 04 24             	mov    %eax,(%esp)
80102ce4:	e8 e7 d3 ff ff       	call   801000d0 <bread>
80102ce9:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102ceb:	8b 04 9d 2c 47 11 80 	mov    -0x7feeb8d4(,%ebx,4),%eax
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102cf2:	43                   	inc    %ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102cf3:	89 44 24 04          	mov    %eax,0x4(%esp)
80102cf7:	a1 24 47 11 80       	mov    0x80114724,%eax
80102cfc:	89 04 24             	mov    %eax,(%esp)
80102cff:	e8 cc d3 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102d04:	b9 00 02 00 00       	mov    $0x200,%ecx
80102d09:	89 4c 24 08          	mov    %ecx,0x8(%esp)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d0d:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102d0f:	8d 40 5c             	lea    0x5c(%eax),%eax
80102d12:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d16:	8d 46 5c             	lea    0x5c(%esi),%eax
80102d19:	89 04 24             	mov    %eax,(%esp)
80102d1c:	e8 5f 2e 00 00       	call   80105b80 <memmove>
    bwrite(to);  // write the log
80102d21:	89 34 24             	mov    %esi,(%esp)
80102d24:	e8 77 d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102d29:	89 3c 24             	mov    %edi,(%esp)
80102d2c:	e8 af d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102d31:	89 34 24             	mov    %esi,(%esp)
80102d34:	e8 a7 d4 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d39:	3b 1d 28 47 11 80    	cmp    0x80114728,%ebx
80102d3f:	7c 8f                	jl     80102cd0 <end_op+0x60>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102d41:	e8 aa fd ff ff       	call   80102af0 <write_head>
    install_trans(); // Now install writes to home locations
80102d46:	e8 05 fd ff ff       	call   80102a50 <install_trans>
    log.lh.n = 0;
80102d4b:	31 d2                	xor    %edx,%edx
80102d4d:	89 15 28 47 11 80    	mov    %edx,0x80114728
    write_head();    // Erase the transaction from the log
80102d53:	e8 98 fd ff ff       	call   80102af0 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102d58:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102d5f:	e8 6c 2c 00 00       	call   801059d0 <acquire>
    log.committing = 0;
80102d64:	31 c0                	xor    %eax,%eax
80102d66:	a3 20 47 11 80       	mov    %eax,0x80114720
    wakeup(&log);
80102d6b:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102d72:	e8 29 18 00 00       	call   801045a0 <wakeup>
    release(&log.lock);
80102d77:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102d7e:	e8 ed 2c 00 00       	call   80105a70 <release>
  }
}
80102d83:	83 c4 1c             	add    $0x1c,%esp
80102d86:	5b                   	pop    %ebx
80102d87:	5e                   	pop    %esi
80102d88:	5f                   	pop    %edi
80102d89:	5d                   	pop    %ebp
80102d8a:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102d8b:	c7 04 24 84 8b 10 80 	movl   $0x80108b84,(%esp)
80102d92:	e8 a9 d5 ff ff       	call   80100340 <panic>
80102d97:	89 f6                	mov    %esi,%esi
80102d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102da0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102da0:	55                   	push   %ebp
80102da1:	89 e5                	mov    %esp,%ebp
80102da3:	53                   	push   %ebx
80102da4:	83 ec 14             	sub    $0x14,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102da7:	8b 15 28 47 11 80    	mov    0x80114728,%edx
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102dad:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102db0:	83 fa 1d             	cmp    $0x1d,%edx
80102db3:	0f 8f 8f 00 00 00    	jg     80102e48 <log_write+0xa8>
80102db9:	a1 18 47 11 80       	mov    0x80114718,%eax
80102dbe:	48                   	dec    %eax
80102dbf:	39 c2                	cmp    %eax,%edx
80102dc1:	0f 8d 81 00 00 00    	jge    80102e48 <log_write+0xa8>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102dc7:	a1 1c 47 11 80       	mov    0x8011471c,%eax
80102dcc:	85 c0                	test   %eax,%eax
80102dce:	0f 8e 80 00 00 00    	jle    80102e54 <log_write+0xb4>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102dd4:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102ddb:	e8 f0 2b 00 00       	call   801059d0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102de0:	8b 15 28 47 11 80    	mov    0x80114728,%edx
80102de6:	83 fa 00             	cmp    $0x0,%edx
80102de9:	7e 4e                	jle    80102e39 <log_write+0x99>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102deb:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102dee:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102df0:	3b 0d 2c 47 11 80    	cmp    0x8011472c,%ecx
80102df6:	75 11                	jne    80102e09 <log_write+0x69>
80102df8:	eb 36                	jmp    80102e30 <log_write+0x90>
80102dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102e00:	39 0c 85 2c 47 11 80 	cmp    %ecx,-0x7feeb8d4(,%eax,4)
80102e07:	74 27                	je     80102e30 <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102e09:	40                   	inc    %eax
80102e0a:	39 d0                	cmp    %edx,%eax
80102e0c:	75 f2                	jne    80102e00 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102e0e:	89 0c 95 2c 47 11 80 	mov    %ecx,-0x7feeb8d4(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102e15:	42                   	inc    %edx
80102e16:	89 15 28 47 11 80    	mov    %edx,0x80114728
  b->flags |= B_DIRTY; // prevent eviction
80102e1c:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102e1f:	c7 45 08 e0 46 11 80 	movl   $0x801146e0,0x8(%ebp)
}
80102e26:	83 c4 14             	add    $0x14,%esp
80102e29:	5b                   	pop    %ebx
80102e2a:	5d                   	pop    %ebp
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102e2b:	e9 40 2c 00 00       	jmp    80105a70 <release>
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102e30:	89 0c 85 2c 47 11 80 	mov    %ecx,-0x7feeb8d4(,%eax,4)
80102e37:	eb e3                	jmp    80102e1c <log_write+0x7c>
80102e39:	8b 43 08             	mov    0x8(%ebx),%eax
80102e3c:	a3 2c 47 11 80       	mov    %eax,0x8011472c
  if (i == log.lh.n)
80102e41:	75 d9                	jne    80102e1c <log_write+0x7c>
80102e43:	eb d0                	jmp    80102e15 <log_write+0x75>
80102e45:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102e48:	c7 04 24 93 8b 10 80 	movl   $0x80108b93,(%esp)
80102e4f:	e8 ec d4 ff ff       	call   80100340 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102e54:	c7 04 24 a9 8b 10 80 	movl   $0x80108ba9,(%esp)
80102e5b:	e8 e0 d4 ff ff       	call   80100340 <panic>

80102e60 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80102e60:	55                   	push   %ebp
80102e61:	89 e5                	mov    %esp,%ebp
80102e63:	53                   	push   %ebx
80102e64:	83 ec 14             	sub    $0x14,%esp
  switchkvm();
80102e67:	e8 84 51 00 00       	call   80107ff0 <switchkvm>
  seginit();
80102e6c:	e8 7f 50 00 00       	call   80107ef0 <seginit>
  lapicinit();
80102e71:	e8 4a f8 ff ff       	call   801026c0 <lapicinit>
}

static void
mpmain(void) //called by the non-boot AP cpus
{
  struct cpu* c = mycpu();
80102e76:	e8 b5 0a 00 00       	call   80103930 <mycpu>
80102e7b:	89 c3                	mov    %eax,%ebx
  cprintf("cpu%d: is witing for the \"pioneer\" cpu to finish its initialization.\n", cpuid());
80102e7d:	e8 2e 0b 00 00       	call   801039b0 <cpuid>
80102e82:	c7 04 24 c4 8b 10 80 	movl   $0x80108bc4,(%esp)
80102e89:	89 44 24 04          	mov    %eax,0x4(%esp)
80102e8d:	e8 ae d7 ff ff       	call   80100640 <cprintf>
  idtinit();       // load idt register
80102e92:	e8 d9 3f 00 00       	call   80106e70 <idtinit>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e97:	b8 01 00 00 00       	mov    $0x1,%eax
80102e9c:	f0 87 83 a0 00 00 00 	lock xchg %eax,0xa0(%ebx)
80102ea3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  xchg(&(c->started), 1); // tell startothers() we're up
  while(c->started != 0); // wait for the "pioneer" cpu to finish the scheduling data structures initialization
80102eb0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102eb6:	85 c0                	test   %eax,%eax
80102eb8:	75 f6                	jne    80102eb0 <mpenter+0x50>
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102eba:	e8 f1 0a 00 00       	call   801039b0 <cpuid>
80102ebf:	89 c3                	mov    %eax,%ebx
80102ec1:	e8 ea 0a 00 00       	call   801039b0 <cpuid>
80102ec6:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80102eca:	c7 04 24 14 8c 10 80 	movl   $0x80108c14,(%esp)
80102ed1:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ed5:	e8 66 d7 ff ff       	call   80100640 <cprintf>
  scheduler();     // start running processes
80102eda:	e8 a1 0f 00 00       	call   80103e80 <scheduler>
80102edf:	90                   	nop

80102ee0 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102ee0:	55                   	push   %ebp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102ee1:	b8 00 00 40 80       	mov    $0x80400000,%eax
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102ee6:	89 e5                	mov    %esp,%ebp
80102ee8:	53                   	push   %ebx
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102ee9:	bb e0 47 11 80       	mov    $0x801147e0,%ebx
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102eee:	83 e4 f0             	and    $0xfffffff0,%esp
80102ef1:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102ef4:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ef8:	c7 04 24 08 80 11 80 	movl   $0x80118008,(%esp)
80102eff:	e8 8c f5 ff ff       	call   80102490 <kinit1>
  kvmalloc();      // kernel page table
80102f04:	e8 97 55 00 00       	call   801084a0 <kvmalloc>
  mpinit();        // detect other processors
80102f09:	e8 02 02 00 00       	call   80103110 <mpinit>
80102f0e:	66 90                	xchg   %ax,%ax
  lapicinit();     // interrupt controller
80102f10:	e8 ab f7 ff ff       	call   801026c0 <lapicinit>
  seginit();       // segment descriptors
80102f15:	e8 d6 4f 00 00       	call   80107ef0 <seginit>
  picinit();       // disable pic
80102f1a:	e8 c1 03 00 00       	call   801032e0 <picinit>
80102f1f:	90                   	nop
  ioapicinit();    // another interrupt controller
80102f20:	e8 7b f3 ff ff       	call   801022a0 <ioapicinit>
  consoleinit();   // console hardware
80102f25:	e8 36 da ff ff       	call   80100960 <consoleinit>
  uartinit();      // serial port
80102f2a:	e8 91 42 00 00       	call   801071c0 <uartinit>
80102f2f:	90                   	nop
  pinit();         // process table
80102f30:	e8 db 09 00 00       	call   80103910 <pinit>
  tvinit();        // trap vectors
80102f35:	e8 96 3e 00 00       	call   80106dd0 <tvinit>
  binit();         // buffer cache
80102f3a:	e8 01 d1 ff ff       	call   80100040 <binit>
80102f3f:	90                   	nop
  fileinit();      // file table
80102f40:	e8 fb dd ff ff       	call   80100d40 <fileinit>
  ideinit();       // disk 
80102f45:	e8 56 f1 ff ff       	call   801020a0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102f4a:	b8 8a 00 00 00       	mov    $0x8a,%eax
80102f4f:	89 44 24 08          	mov    %eax,0x8(%esp)
80102f53:	b8 8c c4 10 80       	mov    $0x8010c48c,%eax
80102f58:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f5c:	c7 04 24 00 70 00 80 	movl   $0x80007000,(%esp)
80102f63:	e8 18 2c 00 00       	call   80105b80 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102f68:	a1 60 4d 11 80       	mov    0x80114d60,%eax
80102f6d:	8d 14 80             	lea    (%eax,%eax,4),%edx
80102f70:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102f73:	c1 e0 04             	shl    $0x4,%eax
80102f76:	05 e0 47 11 80       	add    $0x801147e0,%eax
80102f7b:	39 d8                	cmp    %ebx,%eax
80102f7d:	76 78                	jbe    80102ff7 <main+0x117>
80102f7f:	90                   	nop
    if(c == mycpu())  // We've started already.
80102f80:	e8 ab 09 00 00       	call   80103930 <mycpu>
80102f85:	39 d8                	cmp    %ebx,%eax
80102f87:	74 51                	je     80102fda <main+0xfa>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102f89:	e8 d2 f5 ff ff       	call   80102560 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102f8e:	ba 00 b0 10 00       	mov    $0x10b000,%edx

    lapicstartap(c->apicid, V2P(code));
80102f93:	b9 00 70 00 00       	mov    $0x7000,%ecx
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102f98:	89 15 f4 6f 00 80    	mov    %edx,0x80006ff4

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f9e:	05 00 10 00 00       	add    $0x1000,%eax
80102fa3:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void(**)(void))(code-8) = mpenter;
80102fa8:	b8 60 2e 10 80       	mov    $0x80102e60,%eax
80102fad:	a3 f8 6f 00 80       	mov    %eax,0x80006ff8
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80102fb2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80102fb6:	0f b6 03             	movzbl (%ebx),%eax
80102fb9:	89 04 24             	mov    %eax,(%esp)
80102fbc:	e8 4f f8 ff ff       	call   80102810 <lapicstartap>
80102fc1:	eb 0d                	jmp    80102fd0 <main+0xf0>
80102fc3:	90                   	nop
80102fc4:	90                   	nop
80102fc5:	90                   	nop
80102fc6:	90                   	nop
80102fc7:	90                   	nop
80102fc8:	90                   	nop
80102fc9:	90                   	nop
80102fca:	90                   	nop
80102fcb:	90                   	nop
80102fcc:	90                   	nop
80102fcd:	90                   	nop
80102fce:	90                   	nop
80102fcf:	90                   	nop

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102fd0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102fd6:	85 c0                	test   %eax,%eax
80102fd8:	74 f6                	je     80102fd0 <main+0xf0>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102fda:	a1 60 4d 11 80       	mov    0x80114d60,%eax
80102fdf:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102fe5:	8d 14 80             	lea    (%eax,%eax,4),%edx
80102fe8:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102feb:	c1 e0 04             	shl    $0x4,%eax
80102fee:	05 e0 47 11 80       	add    $0x801147e0,%eax
80102ff3:	39 c3                	cmp    %eax,%ebx
80102ff5:	72 89                	jb     80102f80 <main+0xa0>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk 
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102ff7:	bb 00 00 00 8e       	mov    $0x8e000000,%ebx
80102ffc:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80103000:	31 db                	xor    %ebx,%ebx
80103002:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
80103009:	e8 f2 f4 ff ff       	call   80102500 <kinit2>
  initSchedDS(); // initialize the data structures for the processes sceduling policies
8010300e:	e8 8d 1c 00 00       	call   80104ca0 <initSchedDS>
  userinit();      // first user process
  mpmainPioneer(); // finish this processor's setup
}

static void releasOthers() {
	__sync_synchronize();
80103013:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  for(struct cpu *c = cpus; c < cpus + ncpu; ++c) //releases the non-boot AP cpus that are wating at mpmain at main.c
80103018:	a1 60 4d 11 80       	mov    0x80114d60,%eax
8010301d:	8d 14 80             	lea    (%eax,%eax,4),%edx
80103020:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103023:	ba e0 47 11 80       	mov    $0x801147e0,%edx
80103028:	c1 e0 04             	shl    $0x4,%eax
8010302b:	05 e0 47 11 80       	add    $0x801147e0,%eax
80103030:	39 d0                	cmp    %edx,%eax
80103032:	89 c1                	mov    %eax,%ecx
80103034:	76 1d                	jbe    80103053 <main+0x173>
80103036:	8d 76 00             	lea    0x0(%esi),%esi
80103039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80103040:	89 d8                	mov    %ebx,%eax
80103042:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
80103049:	81 c2 b0 00 00 00    	add    $0xb0,%edx
8010304f:	39 ca                	cmp    %ecx,%edx
80103051:	72 ed                	jb     80103040 <main+0x160>
  ideinit();       // disk 
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
  initSchedDS(); // initialize the data structures for the processes sceduling policies
  releasOthers(); //releases the non-boot AP cpus that are wating at mpmain at main.c
  userinit();      // first user process
80103053:	e8 a8 0a 00 00       	call   80103b00 <userinit>
}

static void
mpmainPioneer(void) //called by the "pioneer" cpu
{
  cprintf("\"pioneer\" cpu%d: starting %d\n", cpuid(), cpuid());
80103058:	e8 53 09 00 00       	call   801039b0 <cpuid>
8010305d:	89 c3                	mov    %eax,%ebx
8010305f:	e8 4c 09 00 00       	call   801039b0 <cpuid>
80103064:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80103068:	c7 04 24 0a 8c 10 80 	movl   $0x80108c0a,(%esp)
8010306f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103073:	e8 c8 d5 ff ff       	call   80100640 <cprintf>
  idtinit();       // load idt register
80103078:	e8 f3 3d 00 00       	call   80106e70 <idtinit>
  scheduler();     // start running processes
8010307d:	e8 fe 0d 00 00       	call   80103e80 <scheduler>
80103082:	66 90                	xchg   %ax,%ax
80103084:	66 90                	xchg   %ax,%ax
80103086:	66 90                	xchg   %ax,%ax
80103088:	66 90                	xchg   %ax,%ax
8010308a:	66 90                	xchg   %ax,%ax
8010308c:	66 90                	xchg   %ax,%ax
8010308e:	66 90                	xchg   %ax,%ax

80103090 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103090:	55                   	push   %ebp
80103091:	89 e5                	mov    %esp,%ebp
80103093:	57                   	push   %edi
80103094:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103095:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
8010309b:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
8010309c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
8010309f:	83 ec 1c             	sub    $0x1c,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
801030a2:	39 de                	cmp    %ebx,%esi
801030a4:	72 13                	jb     801030b9 <mpsearch1+0x29>
801030a6:	eb 50                	jmp    801030f8 <mpsearch1+0x68>
801030a8:	90                   	nop
801030a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030b0:	8d 46 10             	lea    0x10(%esi),%eax
801030b3:	39 c3                	cmp    %eax,%ebx
801030b5:	89 c6                	mov    %eax,%esi
801030b7:	76 3f                	jbe    801030f8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030b9:	b8 04 00 00 00       	mov    $0x4,%eax
801030be:	ba 28 8c 10 80       	mov    $0x80108c28,%edx
801030c3:	89 44 24 08          	mov    %eax,0x8(%esp)
801030c7:	89 54 24 04          	mov    %edx,0x4(%esp)
801030cb:	89 34 24             	mov    %esi,(%esp)
801030ce:	e8 4d 2a 00 00       	call   80105b20 <memcmp>
801030d3:	85 c0                	test   %eax,%eax
801030d5:	75 d9                	jne    801030b0 <mpsearch1+0x20>
801030d7:	89 f2                	mov    %esi,%edx
801030d9:	31 c9                	xor    %ecx,%ecx
801030db:	8d 46 10             	lea    0x10(%esi),%eax
801030de:	66 90                	xchg   %ax,%ax
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
801030e0:	0f b6 3a             	movzbl (%edx),%edi
801030e3:	42                   	inc    %edx
801030e4:	01 f9                	add    %edi,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030e6:	39 c2                	cmp    %eax,%edx
801030e8:	75 f6                	jne    801030e0 <mpsearch1+0x50>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030ea:	84 c9                	test   %cl,%cl
801030ec:	75 c5                	jne    801030b3 <mpsearch1+0x23>
      return (struct mp*)p;
  return 0;
}
801030ee:	83 c4 1c             	add    $0x1c,%esp
801030f1:	89 f0                	mov    %esi,%eax
801030f3:	5b                   	pop    %ebx
801030f4:	5e                   	pop    %esi
801030f5:	5f                   	pop    %edi
801030f6:	5d                   	pop    %ebp
801030f7:	c3                   	ret    
801030f8:	83 c4 1c             	add    $0x1c,%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
801030fb:	31 c0                	xor    %eax,%eax
}
801030fd:	5b                   	pop    %ebx
801030fe:	5e                   	pop    %esi
801030ff:	5f                   	pop    %edi
80103100:	5d                   	pop    %ebp
80103101:	c3                   	ret    
80103102:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103110 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103110:	55                   	push   %ebp
80103111:	89 e5                	mov    %esp,%ebp
80103113:	57                   	push   %edi
80103114:	56                   	push   %esi
80103115:	53                   	push   %ebx
80103116:	83 ec 2c             	sub    $0x2c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103119:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103120:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103127:	c1 e0 08             	shl    $0x8,%eax
8010312a:	09 d0                	or     %edx,%eax
8010312c:	c1 e0 04             	shl    $0x4,%eax
8010312f:	75 1b                	jne    8010314c <mpinit+0x3c>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
80103131:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103138:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010313f:	c1 e0 08             	shl    $0x8,%eax
80103142:	09 d0                	or     %edx,%eax
80103144:	c1 e0 0a             	shl    $0xa,%eax
80103147:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
8010314c:	ba 00 04 00 00       	mov    $0x400,%edx
80103151:	e8 3a ff ff ff       	call   80103090 <mpsearch1>
80103156:	85 c0                	test   %eax,%eax
80103158:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010315b:	0f 84 38 01 00 00    	je     80103299 <mpinit+0x189>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103161:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103164:	8b 58 04             	mov    0x4(%eax),%ebx
80103167:	85 db                	test   %ebx,%ebx
80103169:	0f 84 44 01 00 00    	je     801032b3 <mpinit+0x1a3>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
8010316f:	b8 04 00 00 00       	mov    $0x4,%eax
80103174:	ba 2d 8c 10 80       	mov    $0x80108c2d,%edx
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103179:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
8010317f:	89 44 24 08          	mov    %eax,0x8(%esp)
80103183:	89 54 24 04          	mov    %edx,0x4(%esp)
80103187:	89 34 24             	mov    %esi,(%esp)
8010318a:	e8 91 29 00 00       	call   80105b20 <memcmp>
8010318f:	85 c0                	test   %eax,%eax
80103191:	0f 85 1c 01 00 00    	jne    801032b3 <mpinit+0x1a3>
    return 0;
  if(conf->version != 1 && conf->version != 4)
80103197:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
8010319e:	3c 01                	cmp    $0x1,%al
801031a0:	74 08                	je     801031aa <mpinit+0x9a>
801031a2:	3c 04                	cmp    $0x4,%al
801031a4:	0f 85 09 01 00 00    	jne    801032b3 <mpinit+0x1a3>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801031aa:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801031b1:	85 ff                	test   %edi,%edi
801031b3:	74 22                	je     801031d7 <mpinit+0xc7>
801031b5:	31 d2                	xor    %edx,%edx
801031b7:	31 c0                	xor    %eax,%eax
801031b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
801031c0:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
801031c7:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801031c8:	40                   	inc    %eax
    sum += addr[i];
801031c9:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801031cb:	39 c7                	cmp    %eax,%edi
801031cd:	75 f1                	jne    801031c0 <mpinit+0xb0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801031cf:	84 d2                	test   %dl,%dl
801031d1:	0f 85 dc 00 00 00    	jne    801032b3 <mpinit+0x1a3>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801031d7:	85 f6                	test   %esi,%esi
801031d9:	0f 84 d4 00 00 00    	je     801032b3 <mpinit+0x1a3>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801031df:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801031e5:	8d 93 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%edx
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
801031eb:	b9 01 00 00 00       	mov    $0x1,%ecx
  lapic = (uint*)conf->lapicaddr;
801031f0:	a3 dc 46 11 80       	mov    %eax,0x801146dc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801031f5:	0f b7 83 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%eax
801031fc:	01 c6                	add    %eax,%esi
801031fe:	66 90                	xchg   %ax,%ax
80103200:	39 d6                	cmp    %edx,%esi
80103202:	76 23                	jbe    80103227 <mpinit+0x117>
80103204:	0f b6 02             	movzbl (%edx),%eax
    switch(*p){
80103207:	3c 04                	cmp    $0x4,%al
80103209:	0f 87 c1 00 00 00    	ja     801032d0 <mpinit+0x1c0>
8010320f:	ff 24 85 6c 8c 10 80 	jmp    *-0x7fef7394(,%eax,4)
80103216:	8d 76 00             	lea    0x0(%esi),%esi
80103219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103220:	83 c2 08             	add    $0x8,%edx

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103223:	39 d6                	cmp    %edx,%esi
80103225:	77 dd                	ja     80103204 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103227:	85 c9                	test   %ecx,%ecx
80103229:	0f 84 90 00 00 00    	je     801032bf <mpinit+0x1af>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010322f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103232:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103236:	74 11                	je     80103249 <mpinit+0x139>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103238:	ba 22 00 00 00       	mov    $0x22,%edx
8010323d:	b0 70                	mov    $0x70,%al
8010323f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103240:	ba 23 00 00 00       	mov    $0x23,%edx
80103245:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103246:	0c 01                	or     $0x1,%al
80103248:	ee                   	out    %al,(%dx)
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103249:	83 c4 2c             	add    $0x2c,%esp
8010324c:	5b                   	pop    %ebx
8010324d:	5e                   	pop    %esi
8010324e:	5f                   	pop    %edi
8010324f:	5d                   	pop    %ebp
80103250:	c3                   	ret    
80103251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80103258:	8b 1d 60 4d 11 80    	mov    0x80114d60,%ebx
8010325e:	83 fb 07             	cmp    $0x7,%ebx
80103261:	7f 1a                	jg     8010327d <mpinit+0x16d>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103263:	0f b6 42 01          	movzbl 0x1(%edx),%eax
80103267:	8d 3c 9b             	lea    (%ebx,%ebx,4),%edi
8010326a:	8d 3c 7b             	lea    (%ebx,%edi,2),%edi
        ncpu++;
8010326d:	43                   	inc    %ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010326e:	c1 e7 04             	shl    $0x4,%edi
        ncpu++;
80103271:	89 1d 60 4d 11 80    	mov    %ebx,0x80114d60
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103277:	88 87 e0 47 11 80    	mov    %al,-0x7feeb820(%edi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
8010327d:	83 c2 14             	add    $0x14,%edx
      continue;
80103280:	e9 7b ff ff ff       	jmp    80103200 <mpinit+0xf0>
80103285:	8d 76 00             	lea    0x0(%esi),%esi
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80103288:	0f b6 42 01          	movzbl 0x1(%edx),%eax
      p += sizeof(struct mpioapic);
8010328c:	83 c2 08             	add    $0x8,%edx
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
8010328f:	a2 c0 47 11 80       	mov    %al,0x801147c0
      p += sizeof(struct mpioapic);
      continue;
80103294:	e9 67 ff ff ff       	jmp    80103200 <mpinit+0xf0>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
80103299:	ba 00 00 01 00       	mov    $0x10000,%edx
8010329e:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801032a3:	e8 e8 fd ff ff       	call   80103090 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801032a8:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801032aa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801032ad:	0f 85 ae fe ff ff    	jne    80103161 <mpinit+0x51>
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
801032b3:	c7 04 24 32 8c 10 80 	movl   $0x80108c32,(%esp)
801032ba:	e8 81 d0 ff ff       	call   80100340 <panic>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
801032bf:	c7 04 24 4c 8c 10 80 	movl   $0x80108c4c,(%esp)
801032c6:	e8 75 d0 ff ff       	call   80100340 <panic>
801032cb:	90                   	nop
801032cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
801032d0:	31 c9                	xor    %ecx,%ecx
801032d2:	e9 30 ff ff ff       	jmp    80103207 <mpinit+0xf7>
801032d7:	66 90                	xchg   %ax,%ax
801032d9:	66 90                	xchg   %ax,%ax
801032db:	66 90                	xchg   %ax,%ax
801032dd:	66 90                	xchg   %ax,%ax
801032df:	90                   	nop

801032e0 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801032e0:	55                   	push   %ebp
801032e1:	ba 21 00 00 00       	mov    $0x21,%edx
801032e6:	89 e5                	mov    %esp,%ebp
801032e8:	b0 ff                	mov    $0xff,%al
801032ea:	ee                   	out    %al,(%dx)
801032eb:	ba a1 00 00 00       	mov    $0xa1,%edx
801032f0:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801032f1:	5d                   	pop    %ebp
801032f2:	c3                   	ret    
801032f3:	66 90                	xchg   %ax,%ax
801032f5:	66 90                	xchg   %ax,%ax
801032f7:	66 90                	xchg   %ax,%ax
801032f9:	66 90                	xchg   %ax,%ax
801032fb:	66 90                	xchg   %ax,%ax
801032fd:	66 90                	xchg   %ax,%ax
801032ff:	90                   	nop

80103300 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103300:	55                   	push   %ebp
80103301:	89 e5                	mov    %esp,%ebp
80103303:	83 ec 28             	sub    $0x28,%esp
80103306:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80103309:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010330c:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010330f:	8b 75 08             	mov    0x8(%ebp),%esi
80103312:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
80103315:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010331b:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103321:	e8 3a da ff ff       	call   80100d60 <filealloc>
80103326:	85 c0                	test   %eax,%eax
80103328:	89 06                	mov    %eax,(%esi)
8010332a:	0f 84 ae 00 00 00    	je     801033de <pipealloc+0xde>
80103330:	e8 2b da ff ff       	call   80100d60 <filealloc>
80103335:	85 c0                	test   %eax,%eax
80103337:	89 03                	mov    %eax,(%ebx)
80103339:	0f 84 91 00 00 00    	je     801033d0 <pipealloc+0xd0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
8010333f:	e8 1c f2 ff ff       	call   80102560 <kalloc>
80103344:	85 c0                	test   %eax,%eax
80103346:	89 c7                	mov    %eax,%edi
80103348:	0f 84 b2 00 00 00    	je     80103400 <pipealloc+0x100>
    goto bad;
  p->readopen = 1;
8010334e:	b8 01 00 00 00       	mov    $0x1,%eax
  p->writeopen = 1;
80103353:	ba 01 00 00 00       	mov    $0x1,%edx
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
  p->readopen = 1;
80103358:	89 87 3c 02 00 00    	mov    %eax,0x23c(%edi)
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
8010335e:	31 c0                	xor    %eax,%eax
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
80103360:	31 c9                	xor    %ecx,%ecx
  p->nread = 0;
80103362:	89 87 34 02 00 00    	mov    %eax,0x234(%edi)
  initlock(&p->lock, "pipe");
80103368:	b8 80 8c 10 80       	mov    $0x80108c80,%eax
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
8010336d:	89 97 40 02 00 00    	mov    %edx,0x240(%edi)
  p->nwrite = 0;
80103373:	89 8f 38 02 00 00    	mov    %ecx,0x238(%edi)
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103379:	89 44 24 04          	mov    %eax,0x4(%esp)
8010337d:	89 3c 24             	mov    %edi,(%esp)
80103380:	e8 eb 24 00 00       	call   80105870 <initlock>
  (*f0)->type = FD_PIPE;
80103385:	8b 06                	mov    (%esi),%eax
80103387:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
8010338d:	8b 06                	mov    (%esi),%eax
8010338f:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103393:	8b 06                	mov    (%esi),%eax
80103395:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103399:	8b 06                	mov    (%esi),%eax
8010339b:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010339e:	8b 03                	mov    (%ebx),%eax
801033a0:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801033a6:	8b 03                	mov    (%ebx),%eax
801033a8:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801033ac:	8b 03                	mov    (%ebx),%eax
801033ae:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801033b2:	8b 03                	mov    (%ebx),%eax
801033b4:	89 78 0c             	mov    %edi,0xc(%eax)
  return 0;
801033b7:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801033b9:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801033bc:	8b 75 f8             	mov    -0x8(%ebp),%esi
801033bf:	8b 7d fc             	mov    -0x4(%ebp),%edi
801033c2:	89 ec                	mov    %ebp,%esp
801033c4:	5d                   	pop    %ebp
801033c5:	c3                   	ret    
801033c6:	8d 76 00             	lea    0x0(%esi),%esi
801033c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801033d0:	8b 06                	mov    (%esi),%eax
801033d2:	85 c0                	test   %eax,%eax
801033d4:	74 16                	je     801033ec <pipealloc+0xec>
    fileclose(*f0);
801033d6:	89 04 24             	mov    %eax,(%esp)
801033d9:	e8 42 da ff ff       	call   80100e20 <fileclose>
  if(*f1)
801033de:	8b 03                	mov    (%ebx),%eax
801033e0:	85 c0                	test   %eax,%eax
801033e2:	74 08                	je     801033ec <pipealloc+0xec>
    fileclose(*f1);
801033e4:	89 04 24             	mov    %eax,(%esp)
801033e7:	e8 34 da ff ff       	call   80100e20 <fileclose>
  return -1;
}
801033ec:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
801033ef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801033f4:	8b 75 f8             	mov    -0x8(%ebp),%esi
801033f7:	8b 7d fc             	mov    -0x4(%ebp),%edi
801033fa:	89 ec                	mov    %ebp,%esp
801033fc:	5d                   	pop    %ebp
801033fd:	c3                   	ret    
801033fe:	66 90                	xchg   %ax,%ax

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80103400:	8b 06                	mov    (%esi),%eax
80103402:	85 c0                	test   %eax,%eax
80103404:	75 d0                	jne    801033d6 <pipealloc+0xd6>
80103406:	eb d6                	jmp    801033de <pipealloc+0xde>
80103408:	90                   	nop
80103409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103410 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
80103410:	55                   	push   %ebp
80103411:	89 e5                	mov    %esp,%ebp
80103413:	83 ec 18             	sub    $0x18,%esp
80103416:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80103419:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010341c:	89 75 fc             	mov    %esi,-0x4(%ebp)
8010341f:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
80103422:	89 1c 24             	mov    %ebx,(%esp)
80103425:	e8 a6 25 00 00       	call   801059d0 <acquire>
  if(writable){
8010342a:	85 f6                	test   %esi,%esi
8010342c:	74 42                	je     80103470 <pipeclose+0x60>
    p->writeopen = 0;
8010342e:	31 f6                	xor    %esi,%esi
    wakeup(&p->nread);
80103430:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
80103436:	89 b3 40 02 00 00    	mov    %esi,0x240(%ebx)
    wakeup(&p->nread);
8010343c:	89 04 24             	mov    %eax,(%esp)
8010343f:	e8 5c 11 00 00       	call   801045a0 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103444:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010344a:	85 d2                	test   %edx,%edx
8010344c:	75 0a                	jne    80103458 <pipeclose+0x48>
8010344e:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103454:	85 c0                	test   %eax,%eax
80103456:	74 38                	je     80103490 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103458:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010345b:	8b 75 fc             	mov    -0x4(%ebp),%esi
8010345e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103461:	89 ec                	mov    %ebp,%esp
80103463:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103464:	e9 07 26 00 00       	jmp    80105a70 <release>
80103469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
80103470:	31 c9                	xor    %ecx,%ecx
    wakeup(&p->nwrite);
80103472:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
80103478:	89 8b 3c 02 00 00    	mov    %ecx,0x23c(%ebx)
    wakeup(&p->nwrite);
8010347e:	89 04 24             	mov    %eax,(%esp)
80103481:	e8 1a 11 00 00       	call   801045a0 <wakeup>
80103486:	eb bc                	jmp    80103444 <pipeclose+0x34>
80103488:	90                   	nop
80103489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80103490:	89 1c 24             	mov    %ebx,(%esp)
80103493:	e8 d8 25 00 00       	call   80105a70 <release>
    kfree((char*)p);
  } else
    release(&p->lock);
}
80103498:	8b 75 fc             	mov    -0x4(%ebp),%esi
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
8010349b:	89 5d 08             	mov    %ebx,0x8(%ebp)
  } else
    release(&p->lock);
}
8010349e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801034a1:	89 ec                	mov    %ebp,%esp
801034a3:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
801034a4:	e9 e7 ee ff ff       	jmp    80102390 <kfree>
801034a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801034b0 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801034b0:	55                   	push   %ebp
801034b1:	89 e5                	mov    %esp,%ebp
801034b3:	57                   	push   %edi
801034b4:	56                   	push   %esi
801034b5:	53                   	push   %ebx
801034b6:	83 ec 2c             	sub    $0x2c,%esp
801034b9:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i;

  acquire(&p->lock);
801034bc:	89 3c 24             	mov    %edi,(%esp)
801034bf:	e8 0c 25 00 00       	call   801059d0 <acquire>
  for(i = 0; i < n; i++){
801034c4:	8b 75 10             	mov    0x10(%ebp),%esi
801034c7:	85 f6                	test   %esi,%esi
801034c9:	0f 8e b8 00 00 00    	jle    80103587 <pipewrite+0xd7>
801034cf:	8b 45 0c             	mov    0xc(%ebp),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801034d2:	8d b7 34 02 00 00    	lea    0x234(%edi),%esi
801034d8:	8b 5d 10             	mov    0x10(%ebp),%ebx
801034db:	8b 8f 38 02 00 00    	mov    0x238(%edi),%ecx
801034e1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801034e4:	01 d8                	add    %ebx,%eax
801034e6:	89 45 e0             	mov    %eax,-0x20(%ebp)
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801034e9:	8d 9f 38 02 00 00    	lea    0x238(%edi),%ebx
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801034ef:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
801034f5:	05 00 02 00 00       	add    $0x200,%eax
801034fa:	39 c1                	cmp    %eax,%ecx
801034fc:	74 38                	je     80103536 <pipewrite+0x86>
801034fe:	eb 55                	jmp    80103555 <pipewrite+0xa5>
      if(p->readopen == 0 || myproc()->killed){
80103500:	e8 cb 04 00 00       	call   801039d0 <myproc>
80103505:	8b 40 24             	mov    0x24(%eax),%eax
80103508:	85 c0                	test   %eax,%eax
8010350a:	75 34                	jne    80103540 <pipewrite+0x90>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
8010350c:	89 34 24             	mov    %esi,(%esp)
8010350f:	e8 8c 10 00 00       	call   801045a0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103514:	89 7c 24 04          	mov    %edi,0x4(%esp)
80103518:	89 1c 24             	mov    %ebx,(%esp)
8010351b:	e8 60 0e 00 00       	call   80104380 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103520:	8b 8f 34 02 00 00    	mov    0x234(%edi),%ecx
80103526:	8b 87 38 02 00 00    	mov    0x238(%edi),%eax
8010352c:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103532:	39 d0                	cmp    %edx,%eax
80103534:	75 2a                	jne    80103560 <pipewrite+0xb0>
      if(p->readopen == 0 || myproc()->killed){
80103536:	8b 97 3c 02 00 00    	mov    0x23c(%edi),%edx
8010353c:	85 d2                	test   %edx,%edx
8010353e:	75 c0                	jne    80103500 <pipewrite+0x50>
        release(&p->lock);
80103540:	89 3c 24             	mov    %edi,(%esp)
80103543:	e8 28 25 00 00       	call   80105a70 <release>
        return -1;
80103548:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
8010354d:	83 c4 2c             	add    $0x2c,%esp
80103550:	5b                   	pop    %ebx
80103551:	5e                   	pop    %esi
80103552:	5f                   	pop    %edi
80103553:	5d                   	pop    %ebp
80103554:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103555:	89 c8                	mov    %ecx,%eax
80103557:	89 f6                	mov    %esi,%esi
80103559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103560:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103563:	8d 48 01             	lea    0x1(%eax),%ecx
80103566:	25 ff 01 00 00       	and    $0x1ff,%eax
8010356b:	89 8f 38 02 00 00    	mov    %ecx,0x238(%edi)
80103571:	ff 45 e4             	incl   -0x1c(%ebp)
80103574:	0f b6 12             	movzbl (%edx),%edx
80103577:	88 54 07 34          	mov    %dl,0x34(%edi,%eax,1)
8010357b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
8010357e:	3b 55 e0             	cmp    -0x20(%ebp),%edx
80103581:	0f 85 68 ff ff ff    	jne    801034ef <pipewrite+0x3f>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103587:	8d 87 34 02 00 00    	lea    0x234(%edi),%eax
8010358d:	89 04 24             	mov    %eax,(%esp)
80103590:	e8 0b 10 00 00       	call   801045a0 <wakeup>
  release(&p->lock);
80103595:	89 3c 24             	mov    %edi,(%esp)
80103598:	e8 d3 24 00 00       	call   80105a70 <release>
  return n;
8010359d:	8b 45 10             	mov    0x10(%ebp),%eax
801035a0:	eb ab                	jmp    8010354d <pipewrite+0x9d>
801035a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801035b0 <piperead>:
}

int
piperead(struct pipe *p, char *addr, int n)
{
801035b0:	55                   	push   %ebp
801035b1:	89 e5                	mov    %esp,%ebp
801035b3:	57                   	push   %edi
801035b4:	56                   	push   %esi
801035b5:	53                   	push   %ebx
801035b6:	83 ec 1c             	sub    $0x1c,%esp
801035b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801035bc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801035bf:	89 1c 24             	mov    %ebx,(%esp)
801035c2:	e8 09 24 00 00       	call   801059d0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801035c7:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801035cd:	39 83 38 02 00 00    	cmp    %eax,0x238(%ebx)
801035d3:	75 6b                	jne    80103640 <piperead+0x90>
801035d5:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
801035db:	85 f6                	test   %esi,%esi
801035dd:	0f 84 c5 00 00 00    	je     801036a8 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801035e3:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
801035e9:	eb 2d                	jmp    80103618 <piperead+0x68>
801035eb:	90                   	nop
801035ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035f0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801035f4:	89 34 24             	mov    %esi,(%esp)
801035f7:	e8 84 0d 00 00       	call   80104380 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801035fc:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103602:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
80103608:	75 36                	jne    80103640 <piperead+0x90>
8010360a:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
80103610:	85 d2                	test   %edx,%edx
80103612:	0f 84 90 00 00 00    	je     801036a8 <piperead+0xf8>
    if(myproc()->killed){
80103618:	e8 b3 03 00 00       	call   801039d0 <myproc>
8010361d:	8b 48 24             	mov    0x24(%eax),%ecx
80103620:	85 c9                	test   %ecx,%ecx
80103622:	74 cc                	je     801035f0 <piperead+0x40>
      release(&p->lock);
80103624:	89 1c 24             	mov    %ebx,(%esp)
80103627:	e8 44 24 00 00       	call   80105a70 <release>
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
8010362c:	83 c4 1c             	add    $0x1c,%esp

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(myproc()->killed){
      release(&p->lock);
      return -1;
8010362f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103634:	5b                   	pop    %ebx
80103635:	5e                   	pop    %esi
80103636:	5f                   	pop    %edi
80103637:	5d                   	pop    %ebp
80103638:	c3                   	ret    
80103639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103640:	8b 45 10             	mov    0x10(%ebp),%eax
80103643:	85 c0                	test   %eax,%eax
80103645:	7e 61                	jle    801036a8 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103647:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010364d:	31 c9                	xor    %ecx,%ecx
8010364f:	eb 15                	jmp    80103666 <piperead+0xb6>
80103651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103658:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010365e:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
80103664:	74 52                	je     801036b8 <piperead+0x108>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103666:	8d 70 01             	lea    0x1(%eax),%esi
80103669:	25 ff 01 00 00       	and    $0x1ff,%eax
8010366e:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
80103674:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
80103679:	88 04 0f             	mov    %al,(%edi,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010367c:	41                   	inc    %ecx
8010367d:	39 4d 10             	cmp    %ecx,0x10(%ebp)
80103680:	75 d6                	jne    80103658 <piperead+0xa8>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103682:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103688:	89 04 24             	mov    %eax,(%esp)
8010368b:	e8 10 0f 00 00       	call   801045a0 <wakeup>
  release(&p->lock);
80103690:	89 1c 24             	mov    %ebx,(%esp)
80103693:	e8 d8 23 00 00       	call   80105a70 <release>
  return i;
80103698:	8b 45 10             	mov    0x10(%ebp),%eax
}
8010369b:	83 c4 1c             	add    $0x1c,%esp
8010369e:	5b                   	pop    %ebx
8010369f:	5e                   	pop    %esi
801036a0:	5f                   	pop    %edi
801036a1:	5d                   	pop    %ebp
801036a2:	c3                   	ret    
801036a3:	90                   	nop
801036a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801036a8:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
801036af:	eb d1                	jmp    80103682 <piperead+0xd2>
801036b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036b8:	89 4d 10             	mov    %ecx,0x10(%ebp)
801036bb:	eb c5                	jmp    80103682 <piperead+0xd2>
801036bd:	66 90                	xchg   %ax,%ax
801036bf:	90                   	nop

801036c0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801036c0:	55                   	push   %ebp
801036c1:	89 e5                	mov    %esp,%ebp
801036c3:	53                   	push   %ebx
    struct proc *p;
    char *sp;

    acquire(&ptable.lock);

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801036c4:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801036c9:	83 ec 14             	sub    $0x14,%esp
    struct proc *p;
    char *sp;

    acquire(&ptable.lock);
801036cc:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801036d3:	e8 f8 22 00 00       	call   801059d0 <acquire>
801036d8:	eb 18                	jmp    801036f2 <allocproc+0x32>
801036da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801036e0:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
801036e6:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
801036ec:	0f 84 7e 00 00 00    	je     80103770 <allocproc+0xb0>
        if(p->state == UNUSED)
801036f2:	8b 43 0c             	mov    0xc(%ebx),%eax
801036f5:	85 c0                	test   %eax,%eax
801036f7:	75 e7                	jne    801036e0 <allocproc+0x20>
    release(&ptable.lock);
    return 0;

    found:
    p->state = EMBRYO;
    p->pid = nextpid++;
801036f9:	a1 08 c0 10 80       	mov    0x8010c008,%eax
    //TODO we can do ctime here;

    release(&ptable.lock);
801036fe:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)

    release(&ptable.lock);
    return 0;

    found:
    p->state = EMBRYO;
80103705:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
    p->pid = nextpid++;
8010370c:	8d 50 01             	lea    0x1(%eax),%edx
8010370f:	89 15 08 c0 10 80    	mov    %edx,0x8010c008
80103715:	89 43 10             	mov    %eax,0x10(%ebx)
    //TODO we can do ctime here;

    release(&ptable.lock);
80103718:	e8 53 23 00 00       	call   80105a70 <release>

    // Allocate kernel stack.
    if((p->kstack = kalloc()) == 0){
8010371d:	e8 3e ee ff ff       	call   80102560 <kalloc>
80103722:	85 c0                	test   %eax,%eax
80103724:	89 43 08             	mov    %eax,0x8(%ebx)
80103727:	74 5b                	je     80103784 <allocproc+0xc4>
        return 0;
    }
    sp = p->kstack + KSTACKSIZE;

    // Leave room for trap frame.
    sp -= sizeof *p->tf;
80103729:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
    sp -= 4;
    *(uint*)sp = (uint)trapret;

    sp -= sizeof *p->context;
    p->context = (struct context*)sp;
    memset(p->context, 0, sizeof *p->context);
8010372f:	b9 14 00 00 00       	mov    $0x14,%ecx
        return 0;
    }
    sp = p->kstack + KSTACKSIZE;

    // Leave room for trap frame.
    sp -= sizeof *p->tf;
80103734:	89 53 18             	mov    %edx,0x18(%ebx)
    p->tf = (struct trapframe*)sp;

    // Set up new context to start executing at forkret,
    // which returns to trapret.
    sp -= 4;
    *(uint*)sp = (uint)trapret;
80103737:	ba bf 6d 10 80       	mov    $0x80106dbf,%edx

    sp -= sizeof *p->context;
8010373c:	05 9c 0f 00 00       	add    $0xf9c,%eax
    p->tf = (struct trapframe*)sp;

    // Set up new context to start executing at forkret,
    // which returns to trapret.
    sp -= 4;
    *(uint*)sp = (uint)trapret;
80103741:	89 50 14             	mov    %edx,0x14(%eax)

    sp -= sizeof *p->context;
    p->context = (struct context*)sp;
    memset(p->context, 0, sizeof *p->context);
80103744:	31 d2                	xor    %edx,%edx
80103746:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010374a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010374e:	89 04 24             	mov    %eax,(%esp)
    // which returns to trapret.
    sp -= 4;
    *(uint*)sp = (uint)trapret;

    sp -= sizeof *p->context;
    p->context = (struct context*)sp;
80103751:	89 43 1c             	mov    %eax,0x1c(%ebx)
    memset(p->context, 0, sizeof *p->context);
80103754:	e8 67 23 00 00       	call   80105ac0 <memset>
    p->context->eip = (uint)forkret;
80103759:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010375c:	c7 40 10 90 37 10 80 	movl   $0x80103790,0x10(%eax)

    return p;
80103763:	89 d8                	mov    %ebx,%eax
}
80103765:	83 c4 14             	add    $0x14,%esp
80103768:	5b                   	pop    %ebx
80103769:	5d                   	pop    %ebp
8010376a:	c3                   	ret    
8010376b:	90                   	nop
8010376c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
        if(p->state == UNUSED)
            goto found;

    release(&ptable.lock);
80103770:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103777:	e8 f4 22 00 00       	call   80105a70 <release>
    p->context = (struct context*)sp;
    memset(p->context, 0, sizeof *p->context);
    p->context->eip = (uint)forkret;

    return p;
}
8010377c:	83 c4 14             	add    $0x14,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
        if(p->state == UNUSED)
            goto found;

    release(&ptable.lock);
    return 0;
8010377f:	31 c0                	xor    %eax,%eax
    p->context = (struct context*)sp;
    memset(p->context, 0, sizeof *p->context);
    p->context->eip = (uint)forkret;

    return p;
}
80103781:	5b                   	pop    %ebx
80103782:	5d                   	pop    %ebp
80103783:	c3                   	ret    

    release(&ptable.lock);

    // Allocate kernel stack.
    if((p->kstack = kalloc()) == 0){
        p->state = UNUSED;
80103784:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        return 0;
8010378b:	eb d8                	jmp    80103765 <allocproc+0xa5>
8010378d:	8d 76 00             	lea    0x0(%esi),%esi

80103790 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103790:	55                   	push   %ebp
80103791:	89 e5                	mov    %esp,%ebp
80103793:	83 ec 18             	sub    $0x18,%esp
    static int first = 1;
    // Still holding ptable.lock from scheduler.
    release(&ptable.lock);
80103796:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
8010379d:	e8 ce 22 00 00       	call   80105a70 <release>

    if (first) {
801037a2:	8b 15 00 c0 10 80    	mov    0x8010c000,%edx
801037a8:	85 d2                	test   %edx,%edx
801037aa:	75 04                	jne    801037b0 <forkret+0x20>
        iinit(ROOTDEV);
        initlog(ROOTDEV);
    }

    // Return to "caller", actually trapret (see allocproc).
}
801037ac:	c9                   	leave  
801037ad:	c3                   	ret    
801037ae:	66 90                	xchg   %ax,%ax

    if (first) {
        // Some initialization functions must be run in the context
        // of a regular process (e.g., they call sleep), and thus cannot
        // be run from main().
        first = 0;
801037b0:	31 c0                	xor    %eax,%eax
        iinit(ROOTDEV);
801037b2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)

    if (first) {
        // Some initialization functions must be run in the context
        // of a regular process (e.g., they call sleep), and thus cannot
        // be run from main().
        first = 0;
801037b9:	a3 00 c0 10 80       	mov    %eax,0x8010c000
        iinit(ROOTDEV);
801037be:	e8 ed dc ff ff       	call   801014b0 <iinit>
        initlog(ROOTDEV);
801037c3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801037ca:	e8 91 f3 ff ff       	call   80102b60 <initlog>
    }

    // Return to "caller", actually trapret (see allocproc).
}
801037cf:	c9                   	leave  
801037d0:	c3                   	ret    
801037d1:	eb 0d                	jmp    801037e0 <getAccumulator>
801037d3:	90                   	nop
801037d4:	90                   	nop
801037d5:	90                   	nop
801037d6:	90                   	nop
801037d7:	90                   	nop
801037d8:	90                   	nop
801037d9:	90                   	nop
801037da:	90                   	nop
801037db:	90                   	nop
801037dc:	90                   	nop
801037dd:	90                   	nop
801037de:	90                   	nop
801037df:	90                   	nop

801037e0 <getAccumulator>:
extern PriorityQueue pq;
extern RoundRobinQueue rrq;
extern RunningProcessesHolder rpholder;


long long getAccumulator(struct proc *p) {
801037e0:	55                   	push   %ebp
801037e1:	89 e5                	mov    %esp,%ebp
    return p->accumulator;
801037e3:	8b 45 08             	mov    0x8(%ebp),%eax
}
801037e6:	5d                   	pop    %ebp
extern RoundRobinQueue rrq;
extern RunningProcessesHolder rpholder;


long long getAccumulator(struct proc *p) {
    return p->accumulator;
801037e7:	8b 90 84 00 00 00    	mov    0x84(%eax),%edx
801037ed:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
}
801037f3:	c3                   	ret    
801037f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801037fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103800 <getMinAccumulator>:

long long getMinAccumulator(){
80103800:	55                   	push   %ebp
80103801:	89 e5                	mov    %esp,%ebp
80103803:	53                   	push   %ebx
80103804:	83 ec 24             	sub    $0x24,%esp
    long long tmp1=0,tmp2=0;
    boolean a=pq.getMinAccumulator(&tmp1);
80103807:	8d 45 e8             	lea    -0x18(%ebp),%eax
long long getAccumulator(struct proc *p) {
    return p->accumulator;
}

long long getMinAccumulator(){
    long long tmp1=0,tmp2=0;
8010380a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
80103811:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80103818:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
8010381f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    boolean a=pq.getMinAccumulator(&tmp1);
80103826:	89 04 24             	mov    %eax,(%esp)
80103829:	ff 15 ec c5 10 80    	call   *0x8010c5ec
8010382f:	89 c3                	mov    %eax,%ebx
    boolean b=rpholder.getMinAccumulator(&tmp2);
80103831:	8d 45 f0             	lea    -0x10(%ebp),%eax
80103834:	89 04 24             	mov    %eax,(%esp)
80103837:	ff 15 d0 c5 10 80    	call   *0x8010c5d0
    if(a&&b){
8010383d:	85 db                	test   %ebx,%ebx
8010383f:	74 1f                	je     80103860 <getMinAccumulator+0x60>
80103841:	85 c0                	test   %eax,%eax
80103843:	74 1b                	je     80103860 <getMinAccumulator+0x60>
80103845:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80103848:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010384b:	8b 5d f0             	mov    -0x10(%ebp),%ebx
8010384e:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103851:	39 ca                	cmp    %ecx,%edx
80103853:	7d 1b                	jge    80103870 <getMinAccumulator+0x70>
            return tmp1;
        else
            return tmp2;
    }

}
80103855:	83 c4 24             	add    $0x24,%esp
80103858:	5b                   	pop    %ebx
80103859:	5d                   	pop    %ebp
8010385a:	c3                   	ret    
8010385b:	90                   	nop
8010385c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(tmp1<tmp2)
            return tmp1;
        return tmp2;
    }
    else{
        if(a)
80103860:	85 db                	test   %ebx,%ebx
80103862:	75 1c                	jne    80103880 <getMinAccumulator+0x80>
            return tmp1;
        else
            return tmp2;
80103864:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103867:	8b 55 f4             	mov    -0xc(%ebp),%edx
    }

}
8010386a:	83 c4 24             	add    $0x24,%esp
8010386d:	5b                   	pop    %ebx
8010386e:	5d                   	pop    %ebp
8010386f:	c3                   	ret    
80103870:	7e 1e                	jle    80103890 <getMinAccumulator+0x90>
80103872:	83 c4 24             	add    $0x24,%esp
80103875:	89 d8                	mov    %ebx,%eax
80103877:	5b                   	pop    %ebx
80103878:	89 ca                	mov    %ecx,%edx
8010387a:	5d                   	pop    %ebp
8010387b:	c3                   	ret    
8010387c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            return tmp1;
        return tmp2;
    }
    else{
        if(a)
            return tmp1;
80103880:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103883:	8b 55 ec             	mov    -0x14(%ebp),%edx
        else
            return tmp2;
    }

}
80103886:	83 c4 24             	add    $0x24,%esp
80103889:	5b                   	pop    %ebx
8010388a:	5d                   	pop    %ebp
8010388b:	c3                   	ret    
8010388c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103890:	39 d8                	cmp    %ebx,%eax
80103892:	76 c1                	jbe    80103855 <getMinAccumulator+0x55>
80103894:	eb dc                	jmp    80103872 <getMinAccumulator+0x72>
80103896:	8d 76 00             	lea    0x0(%esi),%esi
80103899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801038a0 <update_procs_performances>:



void
update_procs_performances(void)
{
801038a0:	55                   	push   %ebp
801038a1:	89 e5                	mov    %esp,%ebp
801038a3:	83 ec 18             	sub    $0x18,%esp
    struct proc *p;


    acquire(&ptable.lock);
801038a6:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801038ad:	e8 1e 21 00 00       	call   801059d0 <acquire>

    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801038b2:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
801038b7:	eb 23                	jmp    801038dc <update_procs_performances+0x3c>
801038b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    {
        switch(p->state){
801038c0:	83 fa 04             	cmp    $0x4,%edx
801038c3:	74 43                	je     80103908 <update_procs_performances+0x68>
801038c5:	83 fa 02             	cmp    $0x2,%edx
801038c8:	75 06                	jne    801038d0 <update_procs_performances+0x30>
            case RUNNING:
                p->proc_perf.rutime++;
                break;

            case SLEEPING:
                p->proc_perf.stime++;
801038ca:	ff 80 94 00 00 00    	incl   0x94(%eax)
    struct proc *p;


    acquire(&ptable.lock);

    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801038d0:	05 a8 00 00 00       	add    $0xa8,%eax
801038d5:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
801038da:	74 1a                	je     801038f6 <update_procs_performances+0x56>
    {
        switch(p->state){
801038dc:	8b 50 0c             	mov    0xc(%eax),%edx
801038df:	83 fa 03             	cmp    $0x3,%edx
801038e2:	75 dc                	jne    801038c0 <update_procs_performances+0x20>
            case RUNNABLE:
                p->proc_perf.retime++;
801038e4:	ff 80 98 00 00 00    	incl   0x98(%eax)
    struct proc *p;


    acquire(&ptable.lock);

    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801038ea:	05 a8 00 00 00       	add    $0xa8,%eax
801038ef:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
801038f4:	75 e6                	jne    801038dc <update_procs_performances+0x3c>
                break;

        }
    }

    release(&ptable.lock);
801038f6:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801038fd:	e8 6e 21 00 00       	call   80105a70 <release>
}
80103902:	c9                   	leave  
80103903:	c3                   	ret    
80103904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            case RUNNABLE:
                p->proc_perf.retime++;
                break;

            case RUNNING:
                p->proc_perf.rutime++;
80103908:	ff 80 9c 00 00 00    	incl   0x9c(%eax)
                break;
8010390e:	eb c0                	jmp    801038d0 <update_procs_performances+0x30>

80103910 <pinit>:



void
pinit(void)
{
80103910:	55                   	push   %ebp
    initlock(&ptable.lock, "ptable");
80103911:	b8 85 8c 10 80       	mov    $0x80108c85,%eax



void
pinit(void)
{
80103916:	89 e5                	mov    %esp,%ebp
80103918:	83 ec 18             	sub    $0x18,%esp
    initlock(&ptable.lock, "ptable");
8010391b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010391f:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103926:	e8 45 1f 00 00       	call   80105870 <initlock>
}
8010392b:	c9                   	leave  
8010392c:	c3                   	ret    
8010392d:	8d 76 00             	lea    0x0(%esi),%esi

80103930 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
80103930:	55                   	push   %ebp
80103931:	89 e5                	mov    %esp,%ebp
80103933:	56                   	push   %esi
80103934:	53                   	push   %ebx
80103935:	83 ec 10             	sub    $0x10,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103938:	9c                   	pushf  
80103939:	58                   	pop    %eax
    int apicid, i;

    if(readeflags()&FL_IF)
8010393a:	f6 c4 02             	test   $0x2,%ah
8010393d:	75 58                	jne    80103997 <mycpu+0x67>
        panic("mycpu called with interrupts enabled\n");

    apicid = lapicid();
8010393f:	e8 7c ee ff ff       	call   801027c0 <lapicid>
    // APIC IDs are not guaranteed to be contiguous. Maybe we should have
    // a reverse map, or reserve a register to store &cpus[i].
    for (i = 0; i < ncpu; ++i) {
80103944:	8b 35 60 4d 11 80    	mov    0x80114d60,%esi
8010394a:	85 f6                	test   %esi,%esi
8010394c:	7e 3d                	jle    8010398b <mycpu+0x5b>
        if (cpus[i].apicid == apicid)
8010394e:	0f b6 15 e0 47 11 80 	movzbl 0x801147e0,%edx
80103955:	39 d0                	cmp    %edx,%eax
80103957:	74 2e                	je     80103987 <mycpu+0x57>
80103959:	b9 90 48 11 80       	mov    $0x80114890,%ecx
8010395e:	31 d2                	xor    %edx,%edx
        panic("mycpu called with interrupts enabled\n");

    apicid = lapicid();
    // APIC IDs are not guaranteed to be contiguous. Maybe we should have
    // a reverse map, or reserve a register to store &cpus[i].
    for (i = 0; i < ncpu; ++i) {
80103960:	42                   	inc    %edx
80103961:	39 f2                	cmp    %esi,%edx
80103963:	74 26                	je     8010398b <mycpu+0x5b>
        if (cpus[i].apicid == apicid)
80103965:	0f b6 19             	movzbl (%ecx),%ebx
80103968:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
8010396e:	39 d8                	cmp    %ebx,%eax
80103970:	75 ee                	jne    80103960 <mycpu+0x30>
            return &cpus[i];
    }
    panic("unknown apicid\n");
}
80103972:	83 c4 10             	add    $0x10,%esp
80103975:	5b                   	pop    %ebx
    apicid = lapicid();
    // APIC IDs are not guaranteed to be contiguous. Maybe we should have
    // a reverse map, or reserve a register to store &cpus[i].
    for (i = 0; i < ncpu; ++i) {
        if (cpus[i].apicid == apicid)
            return &cpus[i];
80103976:	8d 04 92             	lea    (%edx,%edx,4),%eax
80103979:	8d 04 42             	lea    (%edx,%eax,2),%eax
    }
    panic("unknown apicid\n");
}
8010397c:	5e                   	pop    %esi
    apicid = lapicid();
    // APIC IDs are not guaranteed to be contiguous. Maybe we should have
    // a reverse map, or reserve a register to store &cpus[i].
    for (i = 0; i < ncpu; ++i) {
        if (cpus[i].apicid == apicid)
            return &cpus[i];
8010397d:	c1 e0 04             	shl    $0x4,%eax
80103980:	05 e0 47 11 80       	add    $0x801147e0,%eax
    }
    panic("unknown apicid\n");
}
80103985:	5d                   	pop    %ebp
80103986:	c3                   	ret    
        panic("mycpu called with interrupts enabled\n");

    apicid = lapicid();
    // APIC IDs are not guaranteed to be contiguous. Maybe we should have
    // a reverse map, or reserve a register to store &cpus[i].
    for (i = 0; i < ncpu; ++i) {
80103987:	31 d2                	xor    %edx,%edx
80103989:	eb e7                	jmp    80103972 <mycpu+0x42>
        if (cpus[i].apicid == apicid)
            return &cpus[i];
    }
    panic("unknown apicid\n");
8010398b:	c7 04 24 8c 8c 10 80 	movl   $0x80108c8c,(%esp)
80103992:	e8 a9 c9 ff ff       	call   80100340 <panic>
mycpu(void)
{
    int apicid, i;

    if(readeflags()&FL_IF)
        panic("mycpu called with interrupts enabled\n");
80103997:	c7 04 24 80 8d 10 80 	movl   $0x80108d80,(%esp)
8010399e:	e8 9d c9 ff ff       	call   80100340 <panic>
801039a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801039a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801039b0 <cpuid>:
    initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
801039b0:	55                   	push   %ebp
801039b1:	89 e5                	mov    %esp,%ebp
801039b3:	83 ec 08             	sub    $0x8,%esp
    return mycpu()-cpus;
801039b6:	e8 75 ff ff ff       	call   80103930 <mycpu>
}
801039bb:	c9                   	leave  
}

// Must be called with interrupts disabled
int
cpuid() {
    return mycpu()-cpus;
801039bc:	2d e0 47 11 80       	sub    $0x801147e0,%eax
801039c1:	c1 f8 04             	sar    $0x4,%eax
801039c4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801039ca:	c3                   	ret    
801039cb:	90                   	nop
801039cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801039d0 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
801039d0:	55                   	push   %ebp
801039d1:	89 e5                	mov    %esp,%ebp
801039d3:	53                   	push   %ebx
801039d4:	83 ec 04             	sub    $0x4,%esp
    struct cpu *c;
    struct proc *p;
    pushcli();
801039d7:	e8 04 1f 00 00       	call   801058e0 <pushcli>
    c = mycpu();
801039dc:	e8 4f ff ff ff       	call   80103930 <mycpu>
    p = c->proc;
801039e1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
801039e7:	e8 34 1f 00 00       	call   80105920 <popcli>
    return p;
}
801039ec:	5a                   	pop    %edx
801039ed:	89 d8                	mov    %ebx,%eax
801039ef:	5b                   	pop    %ebx
801039f0:	5d                   	pop    %ebp
801039f1:	c3                   	ret    
801039f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a00 <updateAccumulator>:

void
updateAccumulator (struct proc* p){
80103a00:	55                   	push   %ebp
80103a01:	89 e5                	mov    %esp,%ebp
80103a03:	83 ec 08             	sub    $0x8,%esp
    //check if this is the only procces
    if(pq.isEmpty()&&rpholder.isEmpty()) //if the only process -> acc=0
80103a06:	ff 15 e4 c5 10 80    	call   *0x8010c5e4
80103a0c:	85 c0                	test   %eax,%eax
80103a0e:	74 0a                	je     80103a1a <updateAccumulator+0x1a>
80103a10:	ff 15 c4 c5 10 80    	call   *0x8010c5c4
80103a16:	85 c0                	test   %eax,%eax
80103a18:	75 26                	jne    80103a40 <updateAccumulator+0x40>
80103a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        p->accumulator=0;
    else //there are more than 1 procces -> change acc value to min
        p->accumulator=getMinAccumulator();
80103a20:	e8 db fd ff ff       	call   80103800 <getMinAccumulator>
80103a25:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103a28:	89 81 80 00 00 00    	mov    %eax,0x80(%ecx)
80103a2e:	89 91 84 00 00 00    	mov    %edx,0x84(%ecx)
}
80103a34:	c9                   	leave  
80103a35:	c3                   	ret    
80103a36:	8d 76 00             	lea    0x0(%esi),%esi
80103a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

void
updateAccumulator (struct proc* p){
    //check if this is the only procces
    if(pq.isEmpty()&&rpholder.isEmpty()) //if the only process -> acc=0
        p->accumulator=0;
80103a40:	8b 45 08             	mov    0x8(%ebp),%eax
80103a43:	31 d2                	xor    %edx,%edx
80103a45:	31 c9                	xor    %ecx,%ecx
80103a47:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
80103a4d:	89 88 84 00 00 00    	mov    %ecx,0x84(%eax)
    else //there are more than 1 procces -> change acc value to min
        p->accumulator=getMinAccumulator();
}
80103a53:	c9                   	leave  
80103a54:	c3                   	ret    
80103a55:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a60 <pushToSpecificQueue>:

void
pushToSpecificQueue(struct proc* p) {
    switch (currpolicy) {
80103a60:	a1 04 c0 10 80       	mov    0x8010c004,%eax
    else //there are more than 1 procces -> change acc value to min
        p->accumulator=getMinAccumulator();
}

void
pushToSpecificQueue(struct proc* p) {
80103a65:	55                   	push   %ebp
80103a66:	89 e5                	mov    %esp,%ebp
80103a68:	8b 55 08             	mov    0x8(%ebp),%edx
    switch (currpolicy) {
80103a6b:	83 f8 02             	cmp    $0x2,%eax
80103a6e:	74 10                	je     80103a80 <pushToSpecificQueue+0x20>
80103a70:	83 f8 03             	cmp    $0x3,%eax
80103a73:	74 0b                	je     80103a80 <pushToSpecificQueue+0x20>
80103a75:	48                   	dec    %eax
80103a76:	74 18                	je     80103a90 <pushToSpecificQueue+0x30>
            pq.put(p);
            break;
        default:
            break;
    }
}
80103a78:	5d                   	pop    %ebp
80103a79:	c3                   	ret    
80103a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            break;
        case 2:    //priority queue addition
            pq.put(p);
            break;
        case 3:    //priority queue addition
            pq.put(p);
80103a80:	89 55 08             	mov    %edx,0x8(%ebp)
            break;
        default:
            break;
    }
}
80103a83:	5d                   	pop    %ebp
            break;
        case 2:    //priority queue addition
            pq.put(p);
            break;
        case 3:    //priority queue addition
            pq.put(p);
80103a84:	ff 25 e8 c5 10 80    	jmp    *0x8010c5e8
80103a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            break;
        default:
            break;
    }
}
80103a90:	5d                   	pop    %ebp

void
pushToSpecificQueue(struct proc* p) {
    switch (currpolicy) {
        case 1://roundrobin addition
            rrq.enqueue(p);
80103a91:	ff 25 d8 c5 10 80    	jmp    *0x8010c5d8
80103a97:	89 f6                	mov    %esi,%esi
80103a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103aa0 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80103aa0:	55                   	push   %ebp
80103aa1:	89 e5                	mov    %esp,%ebp
80103aa3:	56                   	push   %esi
80103aa4:	89 c6                	mov    %eax,%esi
80103aa6:	53                   	push   %ebx
    struct proc *p;

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103aa7:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80103aac:	83 ec 10             	sub    $0x10,%esp
80103aaf:	eb 15                	jmp    80103ac6 <wakeup1+0x26>
80103ab1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct proc *p;

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ab8:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80103abe:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
80103ac4:	74 32                	je     80103af8 <wakeup1+0x58>
        if(p->state == SLEEPING && p->chan == chan){
80103ac6:	8b 53 0c             	mov    0xc(%ebx),%edx
80103ac9:	83 fa 02             	cmp    $0x2,%edx
80103acc:	75 ea                	jne    80103ab8 <wakeup1+0x18>
80103ace:	39 73 20             	cmp    %esi,0x20(%ebx)
80103ad1:	75 e5                	jne    80103ab8 <wakeup1+0x18>
            p->state = RUNNABLE;
            //update the accumulator field
            updateAccumulator(p);
80103ad3:	89 1c 24             	mov    %ebx,(%esp)
{
    struct proc *p;

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
        if(p->state == SLEEPING && p->chan == chan){
            p->state = RUNNABLE;
80103ad6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
            //update the accumulator field
            updateAccumulator(p);
80103add:	e8 1e ff ff ff       	call   80103a00 <updateAccumulator>
            pushToSpecificQueue(p);
80103ae2:	89 1c 24             	mov    %ebx,(%esp)
static void
wakeup1(void *chan)
{
    struct proc *p;

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ae5:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
        if(p->state == SLEEPING && p->chan == chan){
            p->state = RUNNABLE;
            //update the accumulator field
            updateAccumulator(p);
            pushToSpecificQueue(p);
80103aeb:	e8 70 ff ff ff       	call   80103a60 <pushToSpecificQueue>
static void
wakeup1(void *chan)
{
    struct proc *p;

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103af0:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
80103af6:	75 ce                	jne    80103ac6 <wakeup1+0x26>
            p->state = RUNNABLE;
            //update the accumulator field
            updateAccumulator(p);
            pushToSpecificQueue(p);
        }
}
80103af8:	83 c4 10             	add    $0x10,%esp
80103afb:	5b                   	pop    %ebx
80103afc:	5e                   	pop    %esi
80103afd:	5d                   	pop    %ebp
80103afe:	c3                   	ret    
80103aff:	90                   	nop

80103b00 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80103b00:	55                   	push   %ebp
80103b01:	89 e5                	mov    %esp,%ebp
80103b03:	53                   	push   %ebx
80103b04:	83 ec 14             	sub    $0x14,%esp
    struct proc *p;
    extern char _binary_initcode_start[], _binary_initcode_size[];

    p = allocproc();
80103b07:	e8 b4 fb ff ff       	call   801036c0 <allocproc>
80103b0c:	89 c3                	mov    %eax,%ebx

    initproc = p;
80103b0e:	a3 c0 c5 10 80       	mov    %eax,0x8010c5c0
    if((p->pgdir = setupkvm()) == 0)
80103b13:	e8 f8 48 00 00       	call   80108410 <setupkvm>
80103b18:	85 c0                	test   %eax,%eax
80103b1a:	89 43 04             	mov    %eax,0x4(%ebx)
80103b1d:	0f 84 25 01 00 00    	je     80103c48 <userinit+0x148>
        panic("userinit: out of memory?");
    inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103b23:	b9 60 c4 10 80       	mov    $0x8010c460,%ecx
80103b28:	ba 2c 00 00 00       	mov    $0x2c,%edx
80103b2d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80103b31:	89 54 24 08          	mov    %edx,0x8(%esp)
80103b35:	89 04 24             	mov    %eax,(%esp)
80103b38:	e8 d3 45 00 00       	call   80108110 <inituvm>
    p->sz = PGSIZE;
    memset(p->tf, 0, sizeof(*p->tf));
80103b3d:	b8 4c 00 00 00       	mov    $0x4c,%eax

    initproc = p;
    if((p->pgdir = setupkvm()) == 0)
        panic("userinit: out of memory?");
    inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
    p->sz = PGSIZE;
80103b42:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
    memset(p->tf, 0, sizeof(*p->tf));
80103b48:	89 44 24 08          	mov    %eax,0x8(%esp)
80103b4c:	31 c0                	xor    %eax,%eax
80103b4e:	89 44 24 04          	mov    %eax,0x4(%esp)
80103b52:	8b 43 18             	mov    0x18(%ebx),%eax
80103b55:	89 04 24             	mov    %eax,(%esp)
80103b58:	e8 63 1f 00 00       	call   80105ac0 <memset>
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
80103baa:	b8 b5 8c 10 80       	mov    $0x80108cb5,%eax
80103baf:	89 44 24 04          	mov    %eax,0x4(%esp)
80103bb3:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103bb6:	89 04 24             	mov    %eax,(%esp)
80103bb9:	e8 f2 20 00 00       	call   80105cb0 <safestrcpy>
    p->cwd = namei("/");
80103bbe:	c7 04 24 be 8c 10 80 	movl   $0x80108cbe,(%esp)
80103bc5:	e8 c6 e3 ff ff       	call   80101f90 <namei>
80103bca:	89 43 68             	mov    %eax,0x68(%ebx)

    // this assignment to p->state lets other cores
    // run this process. the acquire forces the above
    // writes to be visible, and the lock is also needed
    // because the assignment might not be atomic.
    acquire(&ptable.lock);
80103bcd:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103bd4:	e8 f7 1d 00 00       	call   801059d0 <acquire>

    p->state = RUNNABLE;
    p->priority=5;
80103bd9:	b8 05 00 00 00       	mov    $0x5,%eax
    p->RUNNABLE_wait_time=0;    //surely 0 because this is the first initialized process
80103bde:	31 d2                	xor    %edx,%edx
    // writes to be visible, and the lock is also needed
    // because the assignment might not be atomic.
    acquire(&ptable.lock);

    p->state = RUNNABLE;
    p->priority=5;
80103be0:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)
    p->RUNNABLE_wait_time=0;    //surely 0 because this is the first initialized process
80103be6:	31 c0                	xor    %eax,%eax
    p->accumulator=0;          //surely 0 because this is the first initialized process
80103be8:	31 c9                	xor    %ecx,%ecx
    // because the assignment might not be atomic.
    acquire(&ptable.lock);

    p->state = RUNNABLE;
    p->priority=5;
    p->RUNNABLE_wait_time=0;    //surely 0 because this is the first initialized process
80103bea:	89 83 a0 00 00 00    	mov    %eax,0xa0(%ebx)
    p->accumulator=0;          //surely 0 because this is the first initialized process
80103bf0:	31 c0                	xor    %eax,%eax
    // because the assignment might not be atomic.
    acquire(&ptable.lock);

    p->state = RUNNABLE;
    p->priority=5;
    p->RUNNABLE_wait_time=0;    //surely 0 because this is the first initialized process
80103bf2:	89 93 a4 00 00 00    	mov    %edx,0xa4(%ebx)
    p->accumulator=0;          //surely 0 because this is the first initialized process
80103bf8:	89 8b 80 00 00 00    	mov    %ecx,0x80(%ebx)
80103bfe:	89 83 84 00 00 00    	mov    %eax,0x84(%ebx)
    // run this process. the acquire forces the above
    // writes to be visible, and the lock is also needed
    // because the assignment might not be atomic.
    acquire(&ptable.lock);

    p->state = RUNNABLE;
80103c04:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
    p->priority=5;
    p->RUNNABLE_wait_time=0;    //surely 0 because this is the first initialized process
    p->accumulator=0;          //surely 0 because this is the first initialized process


    acquire(&tickslock);
80103c0b:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80103c12:	e8 b9 1d 00 00       	call   801059d0 <acquire>
    p->proc_perf.ctime = ticks;
80103c17:	a1 00 80 11 80       	mov    0x80118000,%eax
80103c1c:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
    //??        wakeup(&ticks);
    release(&tickslock);
80103c22:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80103c29:	e8 42 1e 00 00       	call   80105a70 <release>

    //add np (i.e currproc) to the priority queue
    pushToSpecificQueue(p);
80103c2e:	89 1c 24             	mov    %ebx,(%esp)
80103c31:	e8 2a fe ff ff       	call   80103a60 <pushToSpecificQueue>

    release(&ptable.lock);
80103c36:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103c3d:	e8 2e 1e 00 00       	call   80105a70 <release>
}
80103c42:	83 c4 14             	add    $0x14,%esp
80103c45:	5b                   	pop    %ebx
80103c46:	5d                   	pop    %ebp
80103c47:	c3                   	ret    

    p = allocproc();

    initproc = p;
    if((p->pgdir = setupkvm()) == 0)
        panic("userinit: out of memory?");
80103c48:	c7 04 24 9c 8c 10 80 	movl   $0x80108c9c,(%esp)
80103c4f:	e8 ec c6 ff ff       	call   80100340 <panic>
80103c54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103c5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103c60 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80103c60:	55                   	push   %ebp
80103c61:	89 e5                	mov    %esp,%ebp
80103c63:	56                   	push   %esi
80103c64:	53                   	push   %ebx
80103c65:	83 ec 10             	sub    $0x10,%esp
80103c68:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
    struct cpu *c;
    struct proc *p;
    pushcli();
80103c6b:	e8 70 1c 00 00       	call   801058e0 <pushcli>
    c = mycpu();
80103c70:	e8 bb fc ff ff       	call   80103930 <mycpu>
    p = c->proc;
80103c75:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
80103c7b:	e8 a0 1c 00 00       	call   80105920 <popcli>
{
    uint sz;
    struct proc *curproc = myproc();

    sz = curproc->sz;
    if(n > 0){
80103c80:	83 fe 00             	cmp    $0x0,%esi
growproc(int n)
{
    uint sz;
    struct proc *curproc = myproc();

    sz = curproc->sz;
80103c83:	8b 03                	mov    (%ebx),%eax
    if(n > 0){
80103c85:	7e 31                	jle    80103cb8 <growproc+0x58>
        if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103c87:	01 c6                	add    %eax,%esi
80103c89:	89 74 24 08          	mov    %esi,0x8(%esp)
80103c8d:	89 44 24 04          	mov    %eax,0x4(%esp)
80103c91:	8b 43 04             	mov    0x4(%ebx),%eax
80103c94:	89 04 24             	mov    %eax,(%esp)
80103c97:	e8 c4 45 00 00       	call   80108260 <allocuvm>
80103c9c:	85 c0                	test   %eax,%eax
80103c9e:	74 40                	je     80103ce0 <growproc+0x80>
            return -1;
    } else if(n < 0){
        if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
            return -1;
    }
    curproc->sz = sz;
80103ca0:	89 03                	mov    %eax,(%ebx)
    switchuvm(curproc);
80103ca2:	89 1c 24             	mov    %ebx,(%esp)
80103ca5:	e8 66 43 00 00       	call   80108010 <switchuvm>
    return 0;
80103caa:	31 c0                	xor    %eax,%eax
}
80103cac:	83 c4 10             	add    $0x10,%esp
80103caf:	5b                   	pop    %ebx
80103cb0:	5e                   	pop    %esi
80103cb1:	5d                   	pop    %ebp
80103cb2:	c3                   	ret    
80103cb3:	90                   	nop
80103cb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

    sz = curproc->sz;
    if(n > 0){
        if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
            return -1;
    } else if(n < 0){
80103cb8:	74 e6                	je     80103ca0 <growproc+0x40>
        if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103cba:	01 c6                	add    %eax,%esi
80103cbc:	89 74 24 08          	mov    %esi,0x8(%esp)
80103cc0:	89 44 24 04          	mov    %eax,0x4(%esp)
80103cc4:	8b 43 04             	mov    0x4(%ebx),%eax
80103cc7:	89 04 24             	mov    %eax,(%esp)
80103cca:	e8 91 46 00 00       	call   80108360 <deallocuvm>
80103ccf:	85 c0                	test   %eax,%eax
80103cd1:	75 cd                	jne    80103ca0 <growproc+0x40>
80103cd3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    struct proc *curproc = myproc();

    sz = curproc->sz;
    if(n > 0){
        if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
            return -1;
80103ce0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103ce5:	eb c5                	jmp    80103cac <growproc+0x4c>
80103ce7:	89 f6                	mov    %esi,%esi
80103ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103cf0 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103cf0:	55                   	push   %ebp
80103cf1:	89 e5                	mov    %esp,%ebp
80103cf3:	57                   	push   %edi
80103cf4:	56                   	push   %esi
80103cf5:	53                   	push   %ebx
80103cf6:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
    struct cpu *c;
    struct proc *p;
    pushcli();
80103cf9:	e8 e2 1b 00 00       	call   801058e0 <pushcli>
    c = mycpu();
80103cfe:	e8 2d fc ff ff       	call   80103930 <mycpu>
    p = c->proc;
80103d03:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
    popcli();
80103d09:	e8 12 1c 00 00       	call   80105920 <popcli>
    int i, pid;
    struct proc *np;
    struct proc *curproc = myproc();

    // Allocate process.
    if((np = allocproc()) == 0){
80103d0e:	e8 ad f9 ff ff       	call   801036c0 <allocproc>
80103d13:	85 c0                	test   %eax,%eax
80103d15:	0f 84 31 01 00 00    	je     80103e4c <fork+0x15c>
80103d1b:	89 c6                	mov    %eax,%esi
        return -1;
    }

    // Copy process state from proc.
    if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103d1d:	8b 07                	mov    (%edi),%eax
80103d1f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103d23:	8b 47 04             	mov    0x4(%edi),%eax
80103d26:	89 04 24             	mov    %eax,(%esp)
80103d29:	e8 c2 47 00 00       	call   801084f0 <copyuvm>
80103d2e:	85 c0                	test   %eax,%eax
80103d30:	89 46 04             	mov    %eax,0x4(%esi)
80103d33:	0f 84 1a 01 00 00    	je     80103e53 <fork+0x163>
        kfree(np->kstack);
        np->kstack = 0;
        np->state = UNUSED;
        return -1;
    }
    np->sz = curproc->sz;
80103d39:	8b 07                	mov    (%edi),%eax
    np->parent = curproc;
80103d3b:	89 7e 14             	mov    %edi,0x14(%esi)
    *np->tf = *curproc->tf;
80103d3e:	8b 4e 18             	mov    0x18(%esi),%ecx
        kfree(np->kstack);
        np->kstack = 0;
        np->state = UNUSED;
        return -1;
    }
    np->sz = curproc->sz;
80103d41:	89 06                	mov    %eax,(%esi)
    np->parent = curproc;
    *np->tf = *curproc->tf;
80103d43:	31 c0                	xor    %eax,%eax
80103d45:	8b 57 18             	mov    0x18(%edi),%edx
80103d48:	8b 1c 02             	mov    (%edx,%eax,1),%ebx
80103d4b:	89 1c 01             	mov    %ebx,(%ecx,%eax,1)
80103d4e:	83 c0 04             	add    $0x4,%eax
80103d51:	83 f8 4c             	cmp    $0x4c,%eax
80103d54:	72 f2                	jb     80103d48 <fork+0x58>

    // Clear %eax so that fork returns 0 in the child.
    np->tf->eax = 0;
80103d56:	8b 46 18             	mov    0x18(%esi),%eax

    for(i = 0; i < NOFILE; i++)
80103d59:	31 db                	xor    %ebx,%ebx
    np->sz = curproc->sz;
    np->parent = curproc;
    *np->tf = *curproc->tf;

    // Clear %eax so that fork returns 0 in the child.
    np->tf->eax = 0;
80103d5b:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103d62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

    for(i = 0; i < NOFILE; i++)
        if(curproc->ofile[i])
80103d70:	8b 44 9f 28          	mov    0x28(%edi,%ebx,4),%eax
80103d74:	85 c0                	test   %eax,%eax
80103d76:	74 0c                	je     80103d84 <fork+0x94>
            np->ofile[i] = filedup(curproc->ofile[i]);
80103d78:	89 04 24             	mov    %eax,(%esp)
80103d7b:	e8 50 d0 ff ff       	call   80100dd0 <filedup>
80103d80:	89 44 9e 28          	mov    %eax,0x28(%esi,%ebx,4)
    *np->tf = *curproc->tf;

    // Clear %eax so that fork returns 0 in the child.
    np->tf->eax = 0;

    for(i = 0; i < NOFILE; i++)
80103d84:	43                   	inc    %ebx
80103d85:	83 fb 10             	cmp    $0x10,%ebx
80103d88:	75 e6                	jne    80103d70 <fork+0x80>
        if(curproc->ofile[i])
            np->ofile[i] = filedup(curproc->ofile[i]);
    np->cwd = idup(curproc->cwd);
80103d8a:	8b 47 68             	mov    0x68(%edi),%eax

    safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d8d:	83 c7 6c             	add    $0x6c,%edi
    np->tf->eax = 0;

    for(i = 0; i < NOFILE; i++)
        if(curproc->ofile[i])
            np->ofile[i] = filedup(curproc->ofile[i]);
    np->cwd = idup(curproc->cwd);
80103d90:	89 04 24             	mov    %eax,(%esp)
80103d93:	e8 28 d9 ff ff       	call   801016c0 <idup>
80103d98:	89 46 68             	mov    %eax,0x68(%esi)

    safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d9b:	b8 10 00 00 00       	mov    $0x10,%eax
80103da0:	89 44 24 08          	mov    %eax,0x8(%esp)
80103da4:	8d 46 6c             	lea    0x6c(%esi),%eax
80103da7:	89 7c 24 04          	mov    %edi,0x4(%esp)
    np->RUNNABLE_wait_time=counter;

    acquire(&tickslock);
    np->proc_perf.ctime = ticks;
    np->proc_perf.retime = 0;
    np->proc_perf.rutime = 0;
80103dab:	31 ff                	xor    %edi,%edi
    for(i = 0; i < NOFILE; i++)
        if(curproc->ofile[i])
            np->ofile[i] = filedup(curproc->ofile[i]);
    np->cwd = idup(curproc->cwd);

    safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103dad:	89 04 24             	mov    %eax,(%esp)
80103db0:	e8 fb 1e 00 00       	call   80105cb0 <safestrcpy>

    pid = np->pid;
80103db5:	8b 5e 10             	mov    0x10(%esi),%ebx

    acquire(&ptable.lock);
80103db8:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103dbf:	e8 0c 1c 00 00       	call   801059d0 <acquire>

    np->state = RUNNABLE;
    np->priority=5;
80103dc4:	ba 05 00 00 00       	mov    $0x5,%edx

    pid = np->pid;

    acquire(&ptable.lock);

    np->state = RUNNABLE;
80103dc9:	c7 46 0c 03 00 00 00 	movl   $0x3,0xc(%esi)
    np->priority=5;
    np->RUNNABLE_wait_time=counter;
80103dd0:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
    pid = np->pid;

    acquire(&ptable.lock);

    np->state = RUNNABLE;
    np->priority=5;
80103dd5:	89 96 88 00 00 00    	mov    %edx,0x88(%esi)
    np->RUNNABLE_wait_time=counter;
80103ddb:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
80103de1:	89 86 a0 00 00 00    	mov    %eax,0xa0(%esi)
80103de7:	89 96 a4 00 00 00    	mov    %edx,0xa4(%esi)

    acquire(&tickslock);
80103ded:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80103df4:	e8 d7 1b 00 00       	call   801059d0 <acquire>
    np->proc_perf.ctime = ticks;
80103df9:	a1 00 80 11 80       	mov    0x80118000,%eax
    np->proc_perf.retime = 0;
80103dfe:	31 c9                	xor    %ecx,%ecx
80103e00:	89 8e 98 00 00 00    	mov    %ecx,0x98(%esi)
    np->proc_perf.rutime = 0;
80103e06:	89 be 9c 00 00 00    	mov    %edi,0x9c(%esi)
    np->state = RUNNABLE;
    np->priority=5;
    np->RUNNABLE_wait_time=counter;

    acquire(&tickslock);
    np->proc_perf.ctime = ticks;
80103e0c:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
    np->proc_perf.retime = 0;
    np->proc_perf.rutime = 0;
    np->proc_perf.stime = 0;
80103e12:	31 c0                	xor    %eax,%eax
80103e14:	89 86 94 00 00 00    	mov    %eax,0x94(%esi)
    //??        wakeup(&ticks);
    release(&tickslock);
80103e1a:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80103e21:	e8 4a 1c 00 00       	call   80105a70 <release>

    //update the accumulator value
    updateAccumulator(np);
80103e26:	89 34 24             	mov    %esi,(%esp)
80103e29:	e8 d2 fb ff ff       	call   80103a00 <updateAccumulator>
    //add np (i.e currproc) to the priority queue
    pushToSpecificQueue(np);
80103e2e:	89 34 24             	mov    %esi,(%esp)
80103e31:	e8 2a fc ff ff       	call   80103a60 <pushToSpecificQueue>

    release(&ptable.lock);
80103e36:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103e3d:	e8 2e 1c 00 00       	call   80105a70 <release>

    return pid;
80103e42:	89 d8                	mov    %ebx,%eax
}
80103e44:	83 c4 1c             	add    $0x1c,%esp
80103e47:	5b                   	pop    %ebx
80103e48:	5e                   	pop    %esi
80103e49:	5f                   	pop    %edi
80103e4a:	5d                   	pop    %ebp
80103e4b:	c3                   	ret    
    struct proc *np;
    struct proc *curproc = myproc();

    // Allocate process.
    if((np = allocproc()) == 0){
        return -1;
80103e4c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103e51:	eb f1                	jmp    80103e44 <fork+0x154>
    }

    // Copy process state from proc.
    if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
        kfree(np->kstack);
80103e53:	8b 46 08             	mov    0x8(%esi),%eax
80103e56:	89 04 24             	mov    %eax,(%esp)
80103e59:	e8 32 e5 ff ff       	call   80102390 <kfree>
        np->kstack = 0;
        np->state = UNUSED;
        return -1;
80103e5e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Copy process state from proc.
    if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
        kfree(np->kstack);
        np->kstack = 0;
80103e63:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
        np->state = UNUSED;
80103e6a:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
        return -1;
80103e71:	eb d1                	jmp    80103e44 <fork+0x154>
80103e73:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e80 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103e80:	55                   	push   %ebp
80103e81:	89 e5                	mov    %esp,%ebp
80103e83:	57                   	push   %edi
    struct proc *p;
    struct cpu *c = mycpu();
    struct proc *max_p=0;
    c->proc = 0;
80103e84:	31 ff                	xor    %edi,%edi
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103e86:	56                   	push   %esi
80103e87:	53                   	push   %ebx
80103e88:	83 ec 2c             	sub    $0x2c,%esp
    struct proc *p;
    struct cpu *c = mycpu();
80103e8b:	e8 a0 fa ff ff       	call   80103930 <mycpu>
    struct proc *max_p=0;
80103e90:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    c->proc = 0;
80103e97:	89 b8 ac 00 00 00    	mov    %edi,0xac(%eax)
//      via swtch back to the scheduler.
void
scheduler(void)
{
    struct proc *p;
    struct cpu *c = mycpu();
80103e9d:	89 c3                	mov    %eax,%ebx
80103e9f:	8d 78 04             	lea    0x4(%eax),%edi
80103ea2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103eb0:	fb                   	sti    

    for(;;){
        // Enable interrupts on this processor.
        sti();
        // Loop over process table looking for process to run.
        acquire(&ptable.lock);
80103eb1:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103eb8:	e8 13 1b 00 00       	call   801059d0 <acquire>

        counter++;
80103ebd:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
80103ec2:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
80103ec8:	83 c0 01             	add    $0x1,%eax
80103ecb:	83 d2 00             	adc    $0x0,%edx
80103ece:	a3 b8 c5 10 80       	mov    %eax,0x8010c5b8
80103ed3:	89 15 bc c5 10 80    	mov    %edx,0x8010c5bc

        //policies cases - depends on the global variable currpolicy
        switch (currpolicy) {
80103ed9:	a1 04 c0 10 80       	mov    0x8010c004,%eax
80103ede:	83 f8 02             	cmp    $0x2,%eax
80103ee1:	0f 84 a1 00 00 00    	je     80103f88 <scheduler+0x108>
80103ee7:	83 f8 03             	cmp    $0x3,%eax
80103eea:	0f 84 40 01 00 00    	je     80104030 <scheduler+0x1b0>
80103ef0:	48                   	dec    %eax
80103ef1:	be b4 4d 11 80       	mov    $0x80114db4,%esi
80103ef6:	75 16                	jne    80103f0e <scheduler+0x8e>
80103ef8:	e9 03 01 00 00       	jmp    80104000 <scheduler+0x180>
80103efd:	8d 76 00             	lea    0x0(%esi),%esi
                }
                break;


            default: //default case is what we got with the xv6
                for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103f00:	81 c6 a8 00 00 00    	add    $0xa8,%esi
80103f06:	81 fe b4 77 11 80    	cmp    $0x801177b4,%esi
80103f0c:	74 62                	je     80103f70 <scheduler+0xf0>
                    if (p->state != RUNNABLE)
80103f0e:	8b 46 0c             	mov    0xc(%esi),%eax
80103f11:	83 f8 03             	cmp    $0x3,%eax
80103f14:	75 ea                	jne    80103f00 <scheduler+0x80>
                        continue;

                    // Switch to chosen process.  It is the process's job
                    // to release ptable.lock and then reacquire it
                    // before jumping back to us.
                    c->proc = p;
80103f16:	89 b3 ac 00 00 00    	mov    %esi,0xac(%ebx)
                    switchuvm(p);
80103f1c:	89 34 24             	mov    %esi,(%esp)
80103f1f:	e8 ec 40 00 00       	call   80108010 <switchuvm>
                    p->state = RUNNING;
80103f24:	c7 46 0c 04 00 00 00 	movl   $0x4,0xc(%esi)

                    rpholder.add(p);
80103f2b:	89 34 24             	mov    %esi,(%esp)
                }
                break;


            default: //default case is what we got with the xv6
                for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103f2e:	81 c6 a8 00 00 00    	add    $0xa8,%esi
                    // before jumping back to us.
                    c->proc = p;
                    switchuvm(p);
                    p->state = RUNNING;

                    rpholder.add(p);
80103f34:	ff 15 c8 c5 10 80    	call   *0x8010c5c8

                    swtch(&(c->scheduler), p->context);
80103f3a:	8b 86 74 ff ff ff    	mov    -0x8c(%esi),%eax
80103f40:	89 3c 24             	mov    %edi,(%esp)
80103f43:	89 44 24 04          	mov    %eax,0x4(%esp)
80103f47:	e8 bd 1d 00 00       	call   80105d09 <swtch>
                    switchkvm();
80103f4c:	e8 9f 40 00 00       	call   80107ff0 <switchkvm>

                    // Process is done running for now.
                    // It should have changed its p->state before coming back.
                    c->proc = 0;
80103f51:	31 c0                	xor    %eax,%eax
                }
                break;


            default: //default case is what we got with the xv6
                for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103f53:	81 fe b4 77 11 80    	cmp    $0x801177b4,%esi
                    swtch(&(c->scheduler), p->context);
                    switchkvm();

                    // Process is done running for now.
                    // It should have changed its p->state before coming back.
                    c->proc = 0;
80103f59:	89 83 ac 00 00 00    	mov    %eax,0xac(%ebx)
                }
                break;


            default: //default case is what we got with the xv6
                for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103f5f:	75 ad                	jne    80103f0e <scheduler+0x8e>
80103f61:	eb 0d                	jmp    80103f70 <scheduler+0xf0>
80103f63:	90                   	nop
80103f64:	90                   	nop
80103f65:	90                   	nop
80103f66:	90                   	nop
80103f67:	90                   	nop
80103f68:	90                   	nop
80103f69:	90                   	nop
80103f6a:	90                   	nop
80103f6b:	90                   	nop
80103f6c:	90                   	nop
80103f6d:	90                   	nop
80103f6e:	90                   	nop
80103f6f:	90                   	nop
                    c->proc = 0;
                }
                break;

        }
        release(&ptable.lock);
80103f70:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103f77:	e8 f4 1a 00 00       	call   80105a70 <release>
    }
80103f7c:	e9 2f ff ff ff       	jmp    80103eb0 <scheduler+0x30>
80103f81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                    }
                }
                break;

            case 2: //3.2 - priority scheduling
                if (!pq.isEmpty()) {
80103f88:	ff 15 e4 c5 10 80    	call   *0x8010c5e4
80103f8e:	85 c0                	test   %eax,%eax
80103f90:	75 de                	jne    80103f70 <scheduler+0xf0>
                    p = pq.extractMin();
80103f92:	ff 15 f0 c5 10 80    	call   *0x8010c5f0
                    if (p != null) {
80103f98:	85 c0                	test   %eax,%eax
                }
                break;

            case 2: //3.2 - priority scheduling
                if (!pq.isEmpty()) {
                    p = pq.extractMin();
80103f9a:	89 c6                	mov    %eax,%esi
                    if (p != null) {
80103f9c:	74 d2                	je     80103f70 <scheduler+0xf0>
                    if (p != null) {

                        // Switch to chosen process.  It is the process's job
                        // to release ptable.lock and then reacquire it
                        // before jumping back to us.
                        c->proc = p;
80103f9e:	89 b3 ac 00 00 00    	mov    %esi,0xac(%ebx)
                        switchuvm(p);
80103fa4:	89 34 24             	mov    %esi,(%esp)
80103fa7:	e8 64 40 00 00       	call   80108010 <switchuvm>
                        p->state = RUNNING;
80103fac:	c7 46 0c 04 00 00 00 	movl   $0x4,0xc(%esi)

                        //save the last time of running
                        p->RUNNABLE_wait_time=counter;
80103fb3:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
80103fb8:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
80103fbe:	89 86 a0 00 00 00    	mov    %eax,0xa0(%esi)
80103fc4:	89 96 a4 00 00 00    	mov    %edx,0xa4(%esi)
                        rpholder.add(p);
80103fca:	89 34 24             	mov    %esi,(%esp)
80103fcd:	ff 15 c8 c5 10 80    	call   *0x8010c5c8


                        swtch(&(c->scheduler), p->context);
80103fd3:	8b 46 1c             	mov    0x1c(%esi),%eax
80103fd6:	89 3c 24             	mov    %edi,(%esp)
80103fd9:	89 44 24 04          	mov    %eax,0x4(%esp)
80103fdd:	e8 27 1d 00 00       	call   80105d09 <swtch>
                        switchkvm();
80103fe2:	e8 09 40 00 00       	call   80107ff0 <switchkvm>

                        // Process is done running for now.
                        // It should have changed its p->state before coming back.
                        c->proc = 0;
80103fe7:	31 d2                	xor    %edx,%edx
80103fe9:	89 93 ac 00 00 00    	mov    %edx,0xac(%ebx)
                    c->proc = 0;
                }
                break;

        }
        release(&ptable.lock);
80103fef:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103ff6:	e8 75 1a 00 00       	call   80105a70 <release>
80103ffb:	e9 b0 fe ff ff       	jmp    80103eb0 <scheduler+0x30>
        counter++;

        //policies cases - depends on the global variable currpolicy
        switch (currpolicy) {
            case 1: //round robin policy
                if (!rrq.isEmpty()) {
80104000:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
80104006:	85 c0                	test   %eax,%eax
80104008:	0f 85 62 ff ff ff    	jne    80103f70 <scheduler+0xf0>
8010400e:	66 90                	xchg   %ax,%ax
                    p = rrq.dequeue();
80104010:	ff 15 dc c5 10 80    	call   *0x8010c5dc
                    if (p != null) {
80104016:	85 c0                	test   %eax,%eax

        //policies cases - depends on the global variable currpolicy
        switch (currpolicy) {
            case 1: //round robin policy
                if (!rrq.isEmpty()) {
                    p = rrq.dequeue();
80104018:	89 c6                	mov    %eax,%esi
                    if (p != null) {
8010401a:	75 82                	jne    80103f9e <scheduler+0x11e>
                    c->proc = 0;
                }
                break;

        }
        release(&ptable.lock);
8010401c:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104023:	e8 48 1a 00 00       	call   80105a70 <release>
80104028:	e9 83 fe ff ff       	jmp    80103eb0 <scheduler+0x30>
8010402d:	8d 76 00             	lea    0x0(%esi),%esi
                    }
                }
                break;

            case 3: //3.3 - priority scheduling
                if (!pq.isEmpty()) {
80104030:	ff 15 e4 c5 10 80    	call   *0x8010c5e4
80104036:	85 c0                	test   %eax,%eax
80104038:	0f 85 32 ff ff ff    	jne    80103f70 <scheduler+0xf0>
                    if( counter % 100 == 0)
8010403e:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
80104043:	b9 64 00 00 00       	mov    $0x64,%ecx
80104048:	31 f6                	xor    %esi,%esi
8010404a:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
80104050:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80104054:	89 74 24 0c          	mov    %esi,0xc(%esp)
80104058:	89 04 24             	mov    %eax,(%esp)
8010405b:	89 54 24 04          	mov    %edx,0x4(%esp)
8010405f:	e8 fc 15 00 00       	call   80105660 <__moddi3>
80104064:	09 c2                	or     %eax,%edx
80104066:	0f 85 7f 00 00 00    	jne    801040eb <scheduler+0x26b>
                    {
                        long long min = counter;
8010406c:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
80104071:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
                        //find the process with max RUNNABLE waiting time
                        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104077:	89 5d e0             	mov    %ebx,-0x20(%ebp)
8010407a:	89 7d dc             	mov    %edi,-0x24(%ebp)
8010407d:	8b 7d e4             	mov    -0x1c(%ebp),%edi

            case 3: //3.3 - priority scheduling
                if (!pq.isEmpty()) {
                    if( counter % 100 == 0)
                    {
                        long long min = counter;
80104080:	89 d1                	mov    %edx,%ecx
80104082:	89 c2                	mov    %eax,%edx
                        //find the process with max RUNNABLE waiting time
                        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104084:	89 cb                	mov    %ecx,%ebx
80104086:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
8010408b:	89 d1                	mov    %edx,%ecx
8010408d:	eb 0d                	jmp    8010409c <scheduler+0x21c>
8010408f:	90                   	nop
80104090:	05 a8 00 00 00       	add    $0xa8,%eax
80104095:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
8010409a:	74 30                	je     801040cc <scheduler+0x24c>
                            if ((p->state == RUNNABLE) && (p->RUNNABLE_wait_time < min)){
8010409c:	8b 50 0c             	mov    0xc(%eax),%edx
8010409f:	83 fa 03             	cmp    $0x3,%edx
801040a2:	75 ec                	jne    80104090 <scheduler+0x210>
801040a4:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801040aa:	8b b0 a0 00 00 00    	mov    0xa0(%eax),%esi
801040b0:	39 da                	cmp    %ebx,%edx
801040b2:	7f dc                	jg     80104090 <scheduler+0x210>
801040b4:	7c 04                	jl     801040ba <scheduler+0x23a>
801040b6:	39 ce                	cmp    %ecx,%esi
801040b8:	73 d6                	jae    80104090 <scheduler+0x210>
801040ba:	89 c7                	mov    %eax,%edi
                if (!pq.isEmpty()) {
                    if( counter % 100 == 0)
                    {
                        long long min = counter;
                        //find the process with max RUNNABLE waiting time
                        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801040bc:	05 a8 00 00 00       	add    $0xa8,%eax
801040c1:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
                            if ((p->state == RUNNABLE) && (p->RUNNABLE_wait_time < min)){
801040c6:	89 f1                	mov    %esi,%ecx
801040c8:	89 d3                	mov    %edx,%ebx
                if (!pq.isEmpty()) {
                    if( counter % 100 == 0)
                    {
                        long long min = counter;
                        //find the process with max RUNNABLE waiting time
                        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801040ca:	75 d0                	jne    8010409c <scheduler+0x21c>
801040cc:	89 f8                	mov    %edi,%eax
801040ce:	8b 5d e0             	mov    -0x20(%ebp),%ebx
                            if ((p->state == RUNNABLE) && (p->RUNNABLE_wait_time < min)){
                                min = p->RUNNABLE_wait_time;
                                max_p = p;
                            }
                        }
                        if(max_p != 0)
801040d1:	85 c0                	test   %eax,%eax
801040d3:	89 c6                	mov    %eax,%esi
801040d5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801040d8:	8b 7d dc             	mov    -0x24(%ebp),%edi
801040db:	74 34                	je     80104111 <scheduler+0x291>
                        {
                            pq.extractProc(max_p);
801040dd:	89 04 24             	mov    %eax,(%esp)
801040e0:	ff 15 f8 c5 10 80    	call   *0x8010c5f8
801040e6:	e9 b3 fe ff ff       	jmp    80103f9e <scheduler+0x11e>
801040eb:	90                   	nop
801040ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                            p=max_p;
                        }

                    }
                    else {
                        p = pq.extractMin();
801040f0:	ff 15 f0 c5 10 80    	call   *0x8010c5f0
                    }

                    if (p != null) {
801040f6:	85 c0                	test   %eax,%eax
                            p=max_p;
                        }

                    }
                    else {
                        p = pq.extractMin();
801040f8:	89 c6                	mov    %eax,%esi
                    }

                    if (p != null) {
801040fa:	0f 85 9e fe ff ff    	jne    80103f9e <scheduler+0x11e>
                    c->proc = 0;
                }
                break;

        }
        release(&ptable.lock);
80104100:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104107:	e8 64 19 00 00       	call   80105a70 <release>
8010410c:	e9 9f fd ff ff       	jmp    80103eb0 <scheduler+0x30>
                if (!pq.isEmpty()) {
                    if( counter % 100 == 0)
                    {
                        long long min = counter;
                        //find the process with max RUNNABLE waiting time
                        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104111:	be b4 77 11 80       	mov    $0x801177b4,%esi
80104116:	e9 83 fe ff ff       	jmp    80103f9e <scheduler+0x11e>
8010411b:	90                   	nop
8010411c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104120 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80104120:	55                   	push   %ebp
80104121:	89 e5                	mov    %esp,%ebp
80104123:	56                   	push   %esi
80104124:	53                   	push   %ebx
80104125:	83 ec 10             	sub    $0x10,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
    struct cpu *c;
    struct proc *p;
    pushcli();
80104128:	e8 b3 17 00 00       	call   801058e0 <pushcli>
    c = mycpu();
8010412d:	e8 fe f7 ff ff       	call   80103930 <mycpu>
    p = c->proc;
80104132:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
80104138:	e8 e3 17 00 00       	call   80105920 <popcli>
sched(void)
{
    int intena;
    struct proc *p = myproc();

    if(!holding(&ptable.lock))
8010413d:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104144:	e8 47 18 00 00       	call   80105990 <holding>
80104149:	85 c0                	test   %eax,%eax
8010414b:	74 51                	je     8010419e <sched+0x7e>
        panic("sched ptable.lock");
    if(mycpu()->ncli != 1)
8010414d:	e8 de f7 ff ff       	call   80103930 <mycpu>
80104152:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80104159:	75 67                	jne    801041c2 <sched+0xa2>
        panic("sched locks");
    if(p->state == RUNNING)
8010415b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010415e:	83 f8 04             	cmp    $0x4,%eax
80104161:	74 53                	je     801041b6 <sched+0x96>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104163:	9c                   	pushf  
80104164:	58                   	pop    %eax
        panic("sched running");
    if(readeflags()&FL_IF)
80104165:	f6 c4 02             	test   $0x2,%ah
80104168:	75 40                	jne    801041aa <sched+0x8a>
        panic("sched interruptible");
    intena = mycpu()->intena;
8010416a:	e8 c1 f7 ff ff       	call   80103930 <mycpu>
    swtch(&p->context, mycpu()->scheduler);
8010416f:	83 c3 1c             	add    $0x1c,%ebx
        panic("sched locks");
    if(p->state == RUNNING)
        panic("sched running");
    if(readeflags()&FL_IF)
        panic("sched interruptible");
    intena = mycpu()->intena;
80104172:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
    swtch(&p->context, mycpu()->scheduler);
80104178:	e8 b3 f7 ff ff       	call   80103930 <mycpu>
8010417d:	8b 40 04             	mov    0x4(%eax),%eax
80104180:	89 1c 24             	mov    %ebx,(%esp)
80104183:	89 44 24 04          	mov    %eax,0x4(%esp)
80104187:	e8 7d 1b 00 00       	call   80105d09 <swtch>
    mycpu()->intena = intena;
8010418c:	e8 9f f7 ff ff       	call   80103930 <mycpu>
80104191:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104197:	83 c4 10             	add    $0x10,%esp
8010419a:	5b                   	pop    %ebx
8010419b:	5e                   	pop    %esi
8010419c:	5d                   	pop    %ebp
8010419d:	c3                   	ret    
{
    int intena;
    struct proc *p = myproc();

    if(!holding(&ptable.lock))
        panic("sched ptable.lock");
8010419e:	c7 04 24 c0 8c 10 80 	movl   $0x80108cc0,(%esp)
801041a5:	e8 96 c1 ff ff       	call   80100340 <panic>
    if(mycpu()->ncli != 1)
        panic("sched locks");
    if(p->state == RUNNING)
        panic("sched running");
    if(readeflags()&FL_IF)
        panic("sched interruptible");
801041aa:	c7 04 24 ec 8c 10 80 	movl   $0x80108cec,(%esp)
801041b1:	e8 8a c1 ff ff       	call   80100340 <panic>
    if(!holding(&ptable.lock))
        panic("sched ptable.lock");
    if(mycpu()->ncli != 1)
        panic("sched locks");
    if(p->state == RUNNING)
        panic("sched running");
801041b6:	c7 04 24 de 8c 10 80 	movl   $0x80108cde,(%esp)
801041bd:	e8 7e c1 ff ff       	call   80100340 <panic>
    struct proc *p = myproc();

    if(!holding(&ptable.lock))
        panic("sched ptable.lock");
    if(mycpu()->ncli != 1)
        panic("sched locks");
801041c2:	c7 04 24 d2 8c 10 80 	movl   $0x80108cd2,(%esp)
801041c9:	e8 72 c1 ff ff       	call   80100340 <panic>
801041ce:	66 90                	xchg   %ax,%ax

801041d0 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(int status)
{
801041d0:	55                   	push   %ebp
801041d1:	89 e5                	mov    %esp,%ebp
801041d3:	57                   	push   %edi
801041d4:	56                   	push   %esi
801041d5:	53                   	push   %ebx
801041d6:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
    struct cpu *c;
    struct proc *p;
    pushcli();
801041d9:	e8 02 17 00 00       	call   801058e0 <pushcli>
    c = mycpu();
801041de:	e8 4d f7 ff ff       	call   80103930 <mycpu>
    p = c->proc;
801041e3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
    popcli();
801041e9:	e8 32 17 00 00       	call   80105920 <popcli>
{
    struct proc *curproc = myproc();
    struct proc *p;
    int fd;

    curproc->exit_status=status;
801041ee:	8b 45 08             	mov    0x8(%ebp),%eax

    if(curproc == initproc)
801041f1:	39 35 c0 c5 10 80    	cmp    %esi,0x8010c5c0
801041f7:	8d 5e 28             	lea    0x28(%esi),%ebx
{
    struct proc *curproc = myproc();
    struct proc *p;
    int fd;

    curproc->exit_status=status;
801041fa:	89 46 7c             	mov    %eax,0x7c(%esi)
801041fd:	8d 7e 68             	lea    0x68(%esi),%edi

    if(curproc == initproc)
80104200:	0f 84 d2 00 00 00    	je     801042d8 <exit+0x108>
80104206:	8d 76 00             	lea    0x0(%esi),%esi
80104209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        panic("init exiting");

    // Close all open files.
    for(fd = 0; fd < NOFILE; fd++){
        if(curproc->ofile[fd]){
80104210:	8b 03                	mov    (%ebx),%eax
80104212:	85 c0                	test   %eax,%eax
80104214:	74 0e                	je     80104224 <exit+0x54>
            fileclose(curproc->ofile[fd]);
80104216:	89 04 24             	mov    %eax,(%esp)
80104219:	e8 02 cc ff ff       	call   80100e20 <fileclose>
            curproc->ofile[fd] = 0;
8010421e:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104224:	83 c3 04             	add    $0x4,%ebx

    if(curproc == initproc)
        panic("init exiting");

    // Close all open files.
    for(fd = 0; fd < NOFILE; fd++){
80104227:	39 fb                	cmp    %edi,%ebx
80104229:	75 e5                	jne    80104210 <exit+0x40>
            fileclose(curproc->ofile[fd]);
            curproc->ofile[fd] = 0;
        }
    }

    begin_op();
8010422b:	e8 d0 e9 ff ff       	call   80102c00 <begin_op>
    iput(curproc->cwd);
80104230:	8b 46 68             	mov    0x68(%esi),%eax

    // Parent might be sleeping in wait().
    wakeup1(curproc->parent);

    // Pass abandoned children to init.
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104233:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
            curproc->ofile[fd] = 0;
        }
    }

    begin_op();
    iput(curproc->cwd);
80104238:	89 04 24             	mov    %eax,(%esp)
8010423b:	e8 e0 d5 ff ff       	call   80101820 <iput>
    end_op();
80104240:	e8 2b ea ff ff       	call   80102c70 <end_op>
    curproc->cwd = 0;
80104245:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)

    acquire(&ptable.lock);
8010424c:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104253:	e8 78 17 00 00       	call   801059d0 <acquire>

    // TODO update termination time
    acquire(&tickslock);
80104258:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
8010425f:	e8 6c 17 00 00       	call   801059d0 <acquire>
    curproc->proc_perf.ttime = ticks;
80104264:	a1 00 80 11 80       	mov    0x80118000,%eax
80104269:	89 86 90 00 00 00    	mov    %eax,0x90(%esi)
    release(&tickslock);
8010426f:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80104276:	e8 f5 17 00 00       	call   80105a70 <release>
    cprintf(" RUTIME : %d     \n" , curproc->proc_perf.rutime);
    cprintf(" RETIME : %d     \n" , curproc->proc_perf.retime);
    cprintf(" STIME : %d     \n\n\n" , curproc->proc_perf.stime);*/

    // Parent might be sleeping in wait().
    wakeup1(curproc->parent);
8010427b:	8b 46 14             	mov    0x14(%esi),%eax
8010427e:	e8 1d f8 ff ff       	call   80103aa0 <wakeup1>
80104283:	eb 11                	jmp    80104296 <exit+0xc6>
80104285:	8d 76 00             	lea    0x0(%esi),%esi

    // Pass abandoned children to init.
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104288:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
8010428e:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
80104294:	74 2a                	je     801042c0 <exit+0xf0>
        if(p->parent == curproc){
80104296:	39 73 14             	cmp    %esi,0x14(%ebx)
80104299:	75 ed                	jne    80104288 <exit+0xb8>
            p->parent = initproc;
            if(p->state == ZOMBIE)
8010429b:	8b 53 0c             	mov    0xc(%ebx),%edx
    wakeup1(curproc->parent);

    // Pass abandoned children to init.
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        if(p->parent == curproc){
            p->parent = initproc;
8010429e:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
            if(p->state == ZOMBIE)
801042a3:	83 fa 05             	cmp    $0x5,%edx
    wakeup1(curproc->parent);

    // Pass abandoned children to init.
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        if(p->parent == curproc){
            p->parent = initproc;
801042a6:	89 43 14             	mov    %eax,0x14(%ebx)
            if(p->state == ZOMBIE)
801042a9:	75 dd                	jne    80104288 <exit+0xb8>

    // Parent might be sleeping in wait().
    wakeup1(curproc->parent);

    // Pass abandoned children to init.
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042ab:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
        if(p->parent == curproc){
            p->parent = initproc;
            if(p->state == ZOMBIE)
                wakeup1(initproc);
801042b1:	e8 ea f7 ff ff       	call   80103aa0 <wakeup1>

    // Parent might be sleeping in wait().
    wakeup1(curproc->parent);

    // Pass abandoned children to init.
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042b6:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
801042bc:	75 d8                	jne    80104296 <exit+0xc6>
801042be:	66 90                	xchg   %ax,%ax
        }
    }


    // Jump into the scheduler, never to return.
    curproc->state = ZOMBIE;
801042c0:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
    sched();
801042c7:	e8 54 fe ff ff       	call   80104120 <sched>
    panic("zombie exit");
801042cc:	c7 04 24 0d 8d 10 80 	movl   $0x80108d0d,(%esp)
801042d3:	e8 68 c0 ff ff       	call   80100340 <panic>
    int fd;

    curproc->exit_status=status;

    if(curproc == initproc)
        panic("init exiting");
801042d8:	c7 04 24 00 8d 10 80 	movl   $0x80108d00,(%esp)
801042df:	e8 5c c0 ff ff       	call   80100340 <panic>
801042e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801042ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801042f0 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
801042f0:	55                   	push   %ebp
801042f1:	89 e5                	mov    %esp,%ebp
801042f3:	53                   	push   %ebx
801042f4:	83 ec 14             	sub    $0x14,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
    struct cpu *c;
    struct proc *p;
    pushcli();
801042f7:	e8 e4 15 00 00       	call   801058e0 <pushcli>
    c = mycpu();
801042fc:	e8 2f f6 ff ff       	call   80103930 <mycpu>
    p = c->proc;
80104301:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
80104307:	e8 14 16 00 00       	call   80105920 <popcli>
void
yield(void)
{
    struct proc *p = myproc();

    acquire(&ptable.lock);  //DOC: yieldlock
8010430c:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104313:	e8 b8 16 00 00       	call   801059d0 <acquire>

    p->state = RUNNABLE;
80104318:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
    if(currpolicy == 2 || currpolicy == 3)
8010431f:	a1 04 c0 10 80       	mov    0x8010c004,%eax
80104324:	83 f8 02             	cmp    $0x2,%eax
80104327:	74 37                	je     80104360 <yield+0x70>
80104329:	a1 04 c0 10 80       	mov    0x8010c004,%eax
8010432e:	83 f8 03             	cmp    $0x3,%eax
80104331:	74 2d                	je     80104360 <yield+0x70>
    {
        p->accumulator+=p->priority;
    }

    pushToSpecificQueue(p);
80104333:	89 1c 24             	mov    %ebx,(%esp)
80104336:	e8 25 f7 ff ff       	call   80103a60 <pushToSpecificQueue>

    rpholder.remove(p);//remove from running queue
8010433b:	89 1c 24             	mov    %ebx,(%esp)
8010433e:	ff 15 cc c5 10 80    	call   *0x8010c5cc

    sched();
80104344:	e8 d7 fd ff ff       	call   80104120 <sched>
    release(&ptable.lock);
80104349:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104350:	e8 1b 17 00 00       	call   80105a70 <release>
}
80104355:	83 c4 14             	add    $0x14,%esp
80104358:	5b                   	pop    %ebx
80104359:	5d                   	pop    %ebp
8010435a:	c3                   	ret    
8010435b:	90                   	nop
8010435c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    acquire(&ptable.lock);  //DOC: yieldlock

    p->state = RUNNABLE;
    if(currpolicy == 2 || currpolicy == 3)
    {
        p->accumulator+=p->priority;
80104360:	8b 83 88 00 00 00    	mov    0x88(%ebx),%eax
80104366:	99                   	cltd   
80104367:	01 83 80 00 00 00    	add    %eax,0x80(%ebx)
8010436d:	11 93 84 00 00 00    	adc    %edx,0x84(%ebx)
80104373:	eb be                	jmp    80104333 <yield+0x43>
80104375:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104380 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104380:	55                   	push   %ebp
80104381:	89 e5                	mov    %esp,%ebp
80104383:	83 ec 28             	sub    $0x28,%esp
80104386:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80104389:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010438c:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010438f:	8b 75 08             	mov    0x8(%ebp),%esi
80104392:	89 7d fc             	mov    %edi,-0x4(%ebp)
// while reading proc from the cpu structure
struct proc*
myproc(void) {
    struct cpu *c;
    struct proc *p;
    pushcli();
80104395:	e8 46 15 00 00       	call   801058e0 <pushcli>
    c = mycpu();
8010439a:	e8 91 f5 ff ff       	call   80103930 <mycpu>
    p = c->proc;
8010439f:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
    popcli();
801043a5:	e8 76 15 00 00       	call   80105920 <popcli>
void
sleep(void *chan, struct spinlock *lk)
{
    struct proc *p = myproc();

    if(p == 0)
801043aa:	85 ff                	test   %edi,%edi
801043ac:	0f 84 c5 00 00 00    	je     80104477 <sleep+0xf7>
        panic("sleep");

    if(lk == 0)
801043b2:	85 db                	test   %ebx,%ebx
801043b4:	0f 84 b1 00 00 00    	je     8010446b <sleep+0xeb>
        panic("sleep without lk");


    if(currpolicy == 2 || currpolicy == 3)
801043ba:	a1 04 c0 10 80       	mov    0x8010c004,%eax
801043bf:	83 f8 02             	cmp    $0x2,%eax
801043c2:	74 6c                	je     80104430 <sleep+0xb0>
801043c4:	a1 04 c0 10 80       	mov    0x8010c004,%eax
801043c9:	83 f8 03             	cmp    $0x3,%eax
801043cc:	74 62                	je     80104430 <sleep+0xb0>
    {
        p->accumulator+=p->priority;
    }
    rpholder.remove(p); //remove p from RUNNING queue
801043ce:	89 3c 24             	mov    %edi,(%esp)
801043d1:	ff 15 cc c5 10 80    	call   *0x8010c5cc
    // change p->state and then call sched.
    // Once we hold ptable.lock, we can be
    // guaranteed that we won't miss any wakeup
    // (wakeup runs with ptable.lock locked),
    // so it's okay to release lk.
    if(lk != &ptable.lock){  //DOC: sleeplock0
801043d7:	81 fb 80 4d 11 80    	cmp    $0x80114d80,%ebx
801043dd:	74 69                	je     80104448 <sleep+0xc8>
        acquire(&ptable.lock);  //DOC: sleeplock1
801043df:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801043e6:	e8 e5 15 00 00       	call   801059d0 <acquire>
        release(lk);
801043eb:	89 1c 24             	mov    %ebx,(%esp)
801043ee:	e8 7d 16 00 00       	call   80105a70 <release>
    }
    // Go to sleep.
    p->chan = chan;
801043f3:	89 77 20             	mov    %esi,0x20(%edi)
    p->state = SLEEPING;
801043f6:	c7 47 0c 02 00 00 00 	movl   $0x2,0xc(%edi)

    sched();
801043fd:	e8 1e fd ff ff       	call   80104120 <sched>

    // Tidy up.
    p->chan = 0;
80104402:	c7 47 20 00 00 00 00 	movl   $0x0,0x20(%edi)

    // Reacquire original lock.
    if(lk != &ptable.lock){  //DOC: sleeplock2
        release(&ptable.lock);
80104409:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104410:	e8 5b 16 00 00       	call   80105a70 <release>
        acquire(lk);
    }
}
80104415:	8b 75 f8             	mov    -0x8(%ebp),%esi
    p->chan = 0;

    // Reacquire original lock.
    if(lk != &ptable.lock){  //DOC: sleeplock2
        release(&ptable.lock);
        acquire(lk);
80104418:	89 5d 08             	mov    %ebx,0x8(%ebp)
    }
}
8010441b:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010441e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104421:	89 ec                	mov    %ebp,%esp
80104423:	5d                   	pop    %ebp
    p->chan = 0;

    // Reacquire original lock.
    if(lk != &ptable.lock){  //DOC: sleeplock2
        release(&ptable.lock);
        acquire(lk);
80104424:	e9 a7 15 00 00       	jmp    801059d0 <acquire>
80104429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        panic("sleep without lk");


    if(currpolicy == 2 || currpolicy == 3)
    {
        p->accumulator+=p->priority;
80104430:	8b 87 88 00 00 00    	mov    0x88(%edi),%eax
80104436:	99                   	cltd   
80104437:	01 87 80 00 00 00    	add    %eax,0x80(%edi)
8010443d:	11 97 84 00 00 00    	adc    %edx,0x84(%edi)
80104443:	eb 89                	jmp    801043ce <sleep+0x4e>
80104445:	8d 76 00             	lea    0x0(%esi),%esi
    if(lk != &ptable.lock){  //DOC: sleeplock0
        acquire(&ptable.lock);  //DOC: sleeplock1
        release(lk);
    }
    // Go to sleep.
    p->chan = chan;
80104448:	89 77 20             	mov    %esi,0x20(%edi)
    p->state = SLEEPING;
8010444b:	c7 47 0c 02 00 00 00 	movl   $0x2,0xc(%edi)

    sched();
80104452:	e8 c9 fc ff ff       	call   80104120 <sched>

    // Tidy up.
    p->chan = 0;
80104457:	c7 47 20 00 00 00 00 	movl   $0x0,0x20(%edi)
    // Reacquire original lock.
    if(lk != &ptable.lock){  //DOC: sleeplock2
        release(&ptable.lock);
        acquire(lk);
    }
}
8010445e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104461:	8b 75 f8             	mov    -0x8(%ebp),%esi
80104464:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104467:	89 ec                	mov    %ebp,%esp
80104469:	5d                   	pop    %ebp
8010446a:	c3                   	ret    

    if(p == 0)
        panic("sleep");

    if(lk == 0)
        panic("sleep without lk");
8010446b:	c7 04 24 1f 8d 10 80 	movl   $0x80108d1f,(%esp)
80104472:	e8 c9 be ff ff       	call   80100340 <panic>
sleep(void *chan, struct spinlock *lk)
{
    struct proc *p = myproc();

    if(p == 0)
        panic("sleep");
80104477:	c7 04 24 19 8d 10 80 	movl   $0x80108d19,(%esp)
8010447e:	e8 bd be ff ff       	call   80100340 <panic>
80104483:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104490 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(int *status)
{
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	57                   	push   %edi
80104494:	56                   	push   %esi
80104495:	53                   	push   %ebx
80104496:	83 ec 1c             	sub    $0x1c,%esp
80104499:	8b 7d 08             	mov    0x8(%ebp),%edi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
    struct cpu *c;
    struct proc *p;
    pushcli();
8010449c:	e8 3f 14 00 00       	call   801058e0 <pushcli>
    c = mycpu();
801044a1:	e8 8a f4 ff ff       	call   80103930 <mycpu>
    p = c->proc;
801044a6:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
    popcli();
801044ac:	e8 6f 14 00 00       	call   80105920 <popcli>
{
    struct proc *p;
    int havekids, pid;
    struct proc *curproc = myproc();

    acquire(&ptable.lock);
801044b1:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801044b8:	e8 13 15 00 00       	call   801059d0 <acquire>
    for(;;){
        // Scan through table looking for exited children.
        havekids = 0;
801044bd:	31 c0                	xor    %eax,%eax
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044bf:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
801044c4:	eb 18                	jmp    801044de <wait+0x4e>
801044c6:	8d 76 00             	lea    0x0(%esi),%esi
801044c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801044d0:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
801044d6:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
801044dc:	74 22                	je     80104500 <wait+0x70>
            if(p->parent != curproc)
801044de:	39 73 14             	cmp    %esi,0x14(%ebx)
801044e1:	75 ed                	jne    801044d0 <wait+0x40>
                continue;
            havekids = 1;
            if(p->state == ZOMBIE){
801044e3:	8b 43 0c             	mov    0xc(%ebx),%eax
801044e6:	83 f8 05             	cmp    $0x5,%eax
801044e9:	74 33                	je     8010451e <wait+0x8e>

    acquire(&ptable.lock);
    for(;;){
        // Scan through table looking for exited children.
        havekids = 0;
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044eb:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
            if(p->parent != curproc)
                continue;
            havekids = 1;
801044f1:	b8 01 00 00 00       	mov    $0x1,%eax

    acquire(&ptable.lock);
    for(;;){
        // Scan through table looking for exited children.
        havekids = 0;
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044f6:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
801044fc:	75 e0                	jne    801044de <wait+0x4e>
801044fe:	66 90                	xchg   %ax,%ax
                return pid;
            }
        }

        // No point waiting if we don't have any children.
        if(!havekids || curproc->killed){
80104500:	85 c0                	test   %eax,%eax
80104502:	74 79                	je     8010457d <wait+0xed>
80104504:	8b 56 24             	mov    0x24(%esi),%edx
80104507:	85 d2                	test   %edx,%edx
80104509:	75 72                	jne    8010457d <wait+0xed>
            release(&ptable.lock);
            return -1;
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
8010450b:	b8 80 4d 11 80       	mov    $0x80114d80,%eax
80104510:	89 44 24 04          	mov    %eax,0x4(%esp)
80104514:	89 34 24             	mov    %esi,(%esp)
80104517:	e8 64 fe ff ff       	call   80104380 <sleep>
    }
8010451c:	eb 9f                	jmp    801044bd <wait+0x2d>
                continue;
            havekids = 1;
            if(p->state == ZOMBIE){
                // Found one.
                pid = p->pid;
                kfree(p->kstack);
8010451e:	8b 43 08             	mov    0x8(%ebx),%eax
            if(p->parent != curproc)
                continue;
            havekids = 1;
            if(p->state == ZOMBIE){
                // Found one.
                pid = p->pid;
80104521:	8b 73 10             	mov    0x10(%ebx),%esi
                kfree(p->kstack);
80104524:	89 04 24             	mov    %eax,(%esp)
80104527:	e8 64 de ff ff       	call   80102390 <kfree>
                p->kstack = 0;
                freevm(p->pgdir);
8010452c:	8b 43 04             	mov    0x4(%ebx),%eax
            havekids = 1;
            if(p->state == ZOMBIE){
                // Found one.
                pid = p->pid;
                kfree(p->kstack);
                p->kstack = 0;
8010452f:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
                freevm(p->pgdir);
80104536:	89 04 24             	mov    %eax,(%esp)
80104539:	e8 52 3e 00 00       	call   80108390 <freevm>
                p->pid = 0;
                p->parent = 0;
                p->name[0] = 0;
                p->killed = 0;
                p->state = UNUSED;
                if(status!=null)
8010453e:	85 ff                	test   %edi,%edi
                // Found one.
                pid = p->pid;
                kfree(p->kstack);
                p->kstack = 0;
                freevm(p->pgdir);
                p->pid = 0;
80104540:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
                p->parent = 0;
80104547:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
                p->name[0] = 0;
8010454e:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
                p->killed = 0;
80104552:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
                p->state = UNUSED;
80104559:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
                if(status!=null)
80104560:	74 05                	je     80104567 <wait+0xd7>
                    *status = (p->exit_status);
80104562:	8b 43 7c             	mov    0x7c(%ebx),%eax
80104565:	89 07                	mov    %eax,(%edi)

                release(&ptable.lock);
80104567:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
8010456e:	e8 fd 14 00 00       	call   80105a70 <release>
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
    }
}
80104573:	83 c4 1c             	add    $0x1c,%esp
                p->state = UNUSED;
                if(status!=null)
                    *status = (p->exit_status);

                release(&ptable.lock);
                return pid;
80104576:	89 f0                	mov    %esi,%eax
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
    }
}
80104578:	5b                   	pop    %ebx
80104579:	5e                   	pop    %esi
8010457a:	5f                   	pop    %edi
8010457b:	5d                   	pop    %ebp
8010457c:	c3                   	ret    
            }
        }

        // No point waiting if we don't have any children.
        if(!havekids || curproc->killed){
            release(&ptable.lock);
8010457d:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104584:	e8 e7 14 00 00       	call   80105a70 <release>
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
    }
}
80104589:	83 c4 1c             	add    $0x1c,%esp
        }

        // No point waiting if we don't have any children.
        if(!havekids || curproc->killed){
            release(&ptable.lock);
            return -1;
8010458c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
    }
}
80104591:	5b                   	pop    %ebx
80104592:	5e                   	pop    %esi
80104593:	5f                   	pop    %edi
80104594:	5d                   	pop    %ebp
80104595:	c3                   	ret    
80104596:	8d 76 00             	lea    0x0(%esi),%esi
80104599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045a0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801045a0:	55                   	push   %ebp
801045a1:	89 e5                	mov    %esp,%ebp
801045a3:	53                   	push   %ebx
801045a4:	83 ec 14             	sub    $0x14,%esp
801045a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
    acquire(&ptable.lock);
801045aa:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801045b1:	e8 1a 14 00 00       	call   801059d0 <acquire>
    wakeup1(chan);
801045b6:	89 d8                	mov    %ebx,%eax
801045b8:	e8 e3 f4 ff ff       	call   80103aa0 <wakeup1>
    release(&ptable.lock);
801045bd:	c7 45 08 80 4d 11 80 	movl   $0x80114d80,0x8(%ebp)
}
801045c4:	83 c4 14             	add    $0x14,%esp
801045c7:	5b                   	pop    %ebx
801045c8:	5d                   	pop    %ebp
void
wakeup(void *chan)
{
    acquire(&ptable.lock);
    wakeup1(chan);
    release(&ptable.lock);
801045c9:	e9 a2 14 00 00       	jmp    80105a70 <release>
801045ce:	66 90                	xchg   %ax,%ax

801045d0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801045d0:	55                   	push   %ebp
801045d1:	89 e5                	mov    %esp,%ebp
801045d3:	53                   	push   %ebx
801045d4:	83 ec 14             	sub    $0x14,%esp
    struct proc *p;

    acquire(&ptable.lock);
801045d7:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801045de:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct proc *p;

    acquire(&ptable.lock);
801045e1:	e8 ea 13 00 00       	call   801059d0 <acquire>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045e6:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
801045eb:	eb 0f                	jmp    801045fc <kill+0x2c>
801045ed:	8d 76 00             	lea    0x0(%esi),%esi
801045f0:	05 a8 00 00 00       	add    $0xa8,%eax
801045f5:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
801045fa:	74 2c                	je     80104628 <kill+0x58>
        if(p->pid == pid){
801045fc:	39 58 10             	cmp    %ebx,0x10(%eax)
801045ff:	75 ef                	jne    801045f0 <kill+0x20>
            p->killed = 1;
            // Wake process from sleep if necessary.
            if(p->state == SLEEPING){
80104601:	8b 50 0c             	mov    0xc(%eax),%edx
    struct proc *p;

    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        if(p->pid == pid){
            p->killed = 1;
80104604:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
            // Wake process from sleep if necessary.
            if(p->state == SLEEPING){
8010460b:	83 fa 02             	cmp    $0x2,%edx
8010460e:	74 2f                	je     8010463f <kill+0x6f>
                p->state = RUNNABLE;
                pushToSpecificQueue(p);
            }
            release(&ptable.lock);
80104610:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104617:	e8 54 14 00 00       	call   80105a70 <release>
            return 0;
        }
    }
    release(&ptable.lock);
    return -1;
}
8010461c:	83 c4 14             	add    $0x14,%esp
            if(p->state == SLEEPING){
                p->state = RUNNABLE;
                pushToSpecificQueue(p);
            }
            release(&ptable.lock);
            return 0;
8010461f:	31 c0                	xor    %eax,%eax
        }
    }
    release(&ptable.lock);
    return -1;
}
80104621:	5b                   	pop    %ebx
80104622:	5d                   	pop    %ebp
80104623:	c3                   	ret    
80104624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            }
            release(&ptable.lock);
            return 0;
        }
    }
    release(&ptable.lock);
80104628:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
8010462f:	e8 3c 14 00 00       	call   80105a70 <release>
    return -1;
}
80104634:	83 c4 14             	add    $0x14,%esp
            release(&ptable.lock);
            return 0;
        }
    }
    release(&ptable.lock);
    return -1;
80104637:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010463c:	5b                   	pop    %ebx
8010463d:	5d                   	pop    %ebp
8010463e:	c3                   	ret    
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        if(p->pid == pid){
            p->killed = 1;
            // Wake process from sleep if necessary.
            if(p->state == SLEEPING){
                p->state = RUNNABLE;
8010463f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
                pushToSpecificQueue(p);
80104646:	89 04 24             	mov    %eax,(%esp)
80104649:	e8 12 f4 ff ff       	call   80103a60 <pushToSpecificQueue>
8010464e:	eb c0                	jmp    80104610 <kill+0x40>

80104650 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
80104653:	57                   	push   %edi
80104654:	56                   	push   %esi
80104655:	53                   	push   %ebx
    int i;
    struct proc *p;
    char *state;
    uint pc[10];

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104656:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
8010465b:	83 ec 4c             	sub    $0x4c,%esp
8010465e:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104661:	eb 23                	jmp    80104686 <procdump+0x36>
80104663:	90                   	nop
80104664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(p->state == SLEEPING){
            getcallerpcs((uint*)p->context->ebp+2, pc);
            for(i=0; i<10 && pc[i] != 0; i++)
                cprintf(" %p", pc[i]);
        }
        cprintf("\n");
80104668:	c7 04 24 01 8e 10 80 	movl   $0x80108e01,(%esp)
8010466f:	e8 cc bf ff ff       	call   80100640 <cprintf>
    int i;
    struct proc *p;
    char *state;
    uint pc[10];

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104674:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
8010467a:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
80104680:	0f 84 aa 00 00 00    	je     80104730 <procdump+0xe0>
        if(p->state == UNUSED)
80104686:	8b 43 0c             	mov    0xc(%ebx),%eax
80104689:	85 c0                	test   %eax,%eax
8010468b:	74 e7                	je     80104674 <procdump+0x24>
            continue;
        if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010468d:	8b 43 0c             	mov    0xc(%ebx),%eax
            state = states[p->state];
        else
            state = "???";
80104690:	b8 30 8d 10 80       	mov    $0x80108d30,%eax
    uint pc[10];

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        if(p->state == UNUSED)
            continue;
        if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104695:	8b 53 0c             	mov    0xc(%ebx),%edx
80104698:	83 fa 05             	cmp    $0x5,%edx
8010469b:	77 18                	ja     801046b5 <procdump+0x65>
8010469d:	8b 53 0c             	mov    0xc(%ebx),%edx
801046a0:	8b 14 95 d8 8d 10 80 	mov    -0x7fef7228(,%edx,4),%edx
801046a7:	85 d2                	test   %edx,%edx
801046a9:	74 0a                	je     801046b5 <procdump+0x65>
            state = states[p->state];
801046ab:	8b 43 0c             	mov    0xc(%ebx),%eax
801046ae:	8b 04 85 d8 8d 10 80 	mov    -0x7fef7228(,%eax,4),%eax
        else
            state = "???";
        cprintf("%d %s %s", p->pid, state, p->name);
801046b5:	89 44 24 08          	mov    %eax,0x8(%esp)
801046b9:	8b 43 10             	mov    0x10(%ebx),%eax
801046bc:	8d 53 6c             	lea    0x6c(%ebx),%edx
801046bf:	89 54 24 0c          	mov    %edx,0xc(%esp)
801046c3:	c7 04 24 34 8d 10 80 	movl   $0x80108d34,(%esp)
801046ca:	89 44 24 04          	mov    %eax,0x4(%esp)
801046ce:	e8 6d bf ff ff       	call   80100640 <cprintf>
        if(p->state == SLEEPING){
801046d3:	8b 43 0c             	mov    0xc(%ebx),%eax
801046d6:	83 f8 02             	cmp    $0x2,%eax
801046d9:	75 8d                	jne    80104668 <procdump+0x18>
            getcallerpcs((uint*)p->context->ebp+2, pc);
801046db:	8d 45 c0             	lea    -0x40(%ebp),%eax
801046de:	89 44 24 04          	mov    %eax,0x4(%esp)
801046e2:	8b 43 1c             	mov    0x1c(%ebx),%eax
801046e5:	8d 7d c0             	lea    -0x40(%ebp),%edi
801046e8:	8b 40 0c             	mov    0xc(%eax),%eax
801046eb:	83 c0 08             	add    $0x8,%eax
801046ee:	89 04 24             	mov    %eax,(%esp)
801046f1:	e8 9a 11 00 00       	call   80105890 <getcallerpcs>
801046f6:	8d 76 00             	lea    0x0(%esi),%esi
801046f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            for(i=0; i<10 && pc[i] != 0; i++)
80104700:	8b 17                	mov    (%edi),%edx
80104702:	85 d2                	test   %edx,%edx
80104704:	0f 84 5e ff ff ff    	je     80104668 <procdump+0x18>
                cprintf(" %p", pc[i]);
8010470a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010470e:	83 c7 04             	add    $0x4,%edi
80104711:	c7 04 24 21 87 10 80 	movl   $0x80108721,(%esp)
80104718:	e8 23 bf ff ff       	call   80100640 <cprintf>
        else
            state = "???";
        cprintf("%d %s %s", p->pid, state, p->name);
        if(p->state == SLEEPING){
            getcallerpcs((uint*)p->context->ebp+2, pc);
            for(i=0; i<10 && pc[i] != 0; i++)
8010471d:	39 f7                	cmp    %esi,%edi
8010471f:	75 df                	jne    80104700 <procdump+0xb0>
80104721:	e9 42 ff ff ff       	jmp    80104668 <procdump+0x18>
80104726:	8d 76 00             	lea    0x0(%esi),%esi
80104729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
                cprintf(" %p", pc[i]);
        }
        cprintf("\n");
    }
}
80104730:	83 c4 4c             	add    $0x4c,%esp
80104733:	5b                   	pop    %ebx
80104734:	5e                   	pop    %esi
80104735:	5f                   	pop    %edi
80104736:	5d                   	pop    %ebp
80104737:	c3                   	ret    
80104738:	90                   	nop
80104739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104740 <detach>:



int
detach(int pid)
{
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
80104743:	56                   	push   %esi
80104744:	53                   	push   %ebx
80104745:	83 ec 10             	sub    $0x10,%esp
80104748:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
    struct cpu *c;
    struct proc *p;
    pushcli();
8010474b:	e8 90 11 00 00       	call   801058e0 <pushcli>
    c = mycpu();
80104750:	e8 db f1 ff ff       	call   80103930 <mycpu>
    p = c->proc;
80104755:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
8010475b:	e8 c0 11 00 00       	call   80105920 <popcli>
detach(int pid)
{
    struct proc *p;
    struct proc *curproc = myproc();

    acquire(&ptable.lock);
80104760:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104767:	e8 64 12 00 00       	call   801059d0 <acquire>
    // Scan through table looking for exited children with same pid as the argument.
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
8010476c:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
80104771:	eb 11                	jmp    80104784 <detach+0x44>
80104773:	90                   	nop
80104774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104778:	05 a8 00 00 00       	add    $0xa8,%eax
8010477d:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
80104782:	74 2c                	je     801047b0 <detach+0x70>
        if (p->parent != curproc)
80104784:	39 58 14             	cmp    %ebx,0x14(%eax)
80104787:	75 ef                	jne    80104778 <detach+0x38>
            continue;
        //check if the pid is same as argument
        if (p->pid == pid) {
80104789:	39 70 10             	cmp    %esi,0x10(%eax)
8010478c:	75 ea                	jne    80104778 <detach+0x38>
            //change the father of current proc
            p->parent = initproc;
8010478e:	8b 15 c0 c5 10 80    	mov    0x8010c5c0,%edx
80104794:	89 50 14             	mov    %edx,0x14(%eax)
            //release the ptable
            release(&ptable.lock);
80104797:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
8010479e:	e8 cd 12 00 00       	call   80105a70 <release>
        }
    }
    //if got here - didn't find proc with pid as argument - exit with error
    release(&ptable.lock);
    return -1;
}
801047a3:	83 c4 10             	add    $0x10,%esp
        if (p->pid == pid) {
            //change the father of current proc
            p->parent = initproc;
            //release the ptable
            release(&ptable.lock);
            return 0;
801047a6:	31 c0                	xor    %eax,%eax
        }
    }
    //if got here - didn't find proc with pid as argument - exit with error
    release(&ptable.lock);
    return -1;
}
801047a8:	5b                   	pop    %ebx
801047a9:	5e                   	pop    %esi
801047aa:	5d                   	pop    %ebp
801047ab:	c3                   	ret    
801047ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            release(&ptable.lock);
            return 0;
        }
    }
    //if got here - didn't find proc with pid as argument - exit with error
    release(&ptable.lock);
801047b0:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801047b7:	e8 b4 12 00 00       	call   80105a70 <release>
    return -1;
}
801047bc:	83 c4 10             	add    $0x10,%esp
            return 0;
        }
    }
    //if got here - didn't find proc with pid as argument - exit with error
    release(&ptable.lock);
    return -1;
801047bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801047c4:	5b                   	pop    %ebx
801047c5:	5e                   	pop    %esi
801047c6:	5d                   	pop    %ebp
801047c7:	c3                   	ret    
801047c8:	90                   	nop
801047c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801047d0 <priority>:



void
priority(int prio){
801047d0:	55                   	push   %ebp
801047d1:	89 e5                	mov    %esp,%ebp
801047d3:	83 ec 18             	sub    $0x18,%esp
801047d6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801047d9:	89 75 fc             	mov    %esi,-0x4(%ebp)
801047dc:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
    struct cpu *c;
    struct proc *p;
    pushcli();
801047df:	e8 fc 10 00 00       	call   801058e0 <pushcli>
    c = mycpu();
801047e4:	e8 47 f1 ff ff       	call   80103930 <mycpu>
    p = c->proc;
801047e9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
801047ef:	e8 2c 11 00 00       	call   80105920 <popcli>


void
priority(int prio){
    struct proc *curproc = myproc();
    if( curproc != null ) {
801047f4:	85 db                	test   %ebx,%ebx
801047f6:	74 68                	je     80104860 <priority+0x90>
        acquire(&ptable.lock);
801047f8:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801047ff:	e8 cc 11 00 00       	call   801059d0 <acquire>

        if (currpolicy == 2) {
80104804:	a1 04 c0 10 80       	mov    0x8010c004,%eax
80104809:	83 f8 02             	cmp    $0x2,%eax
8010480c:	74 22                	je     80104830 <priority+0x60>
            if (prio > 0 && prio < 11)
                curproc->priority = prio;
        }
        if (currpolicy == 3) {
8010480e:	a1 04 c0 10 80       	mov    0x8010c004,%eax
80104813:	83 f8 03             	cmp    $0x3,%eax
80104816:	74 38                	je     80104850 <priority+0x80>
            if (prio >= 0 && prio < 11)
                curproc->priority = prio;
        }

        release(&ptable.lock);
80104818:	c7 45 08 80 4d 11 80 	movl   $0x80114d80,0x8(%ebp)
    }
}
8010481f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104822:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104825:	89 ec                	mov    %ebp,%esp
80104827:	5d                   	pop    %ebp
        if (currpolicy == 3) {
            if (prio >= 0 && prio < 11)
                curproc->priority = prio;
        }

        release(&ptable.lock);
80104828:	e9 43 12 00 00       	jmp    80105a70 <release>
8010482d:	8d 76 00             	lea    0x0(%esi),%esi
    struct proc *curproc = myproc();
    if( curproc != null ) {
        acquire(&ptable.lock);

        if (currpolicy == 2) {
            if (prio > 0 && prio < 11)
80104830:	8d 46 ff             	lea    -0x1(%esi),%eax
80104833:	83 f8 09             	cmp    $0x9,%eax
80104836:	77 d6                	ja     8010480e <priority+0x3e>
                curproc->priority = prio;
        }
        if (currpolicy == 3) {
80104838:	a1 04 c0 10 80       	mov    0x8010c004,%eax
    if( curproc != null ) {
        acquire(&ptable.lock);

        if (currpolicy == 2) {
            if (prio > 0 && prio < 11)
                curproc->priority = prio;
8010483d:	89 b3 88 00 00 00    	mov    %esi,0x88(%ebx)
        }
        if (currpolicy == 3) {
80104843:	83 f8 03             	cmp    $0x3,%eax
80104846:	75 d0                	jne    80104818 <priority+0x48>
80104848:	90                   	nop
80104849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            if (prio >= 0 && prio < 11)
80104850:	83 fe 0a             	cmp    $0xa,%esi
80104853:	77 c3                	ja     80104818 <priority+0x48>
                curproc->priority = prio;
80104855:	89 b3 88 00 00 00    	mov    %esi,0x88(%ebx)
8010485b:	eb bb                	jmp    80104818 <priority+0x48>
8010485d:	8d 76 00             	lea    0x0(%esi),%esi
        }

        release(&ptable.lock);
    }
}
80104860:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104863:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104866:	89 ec                	mov    %ebp,%esp
80104868:	5d                   	pop    %ebp
80104869:	c3                   	ret    
8010486a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104870 <priorityUnExtended>:


void
priorityUnExtended(){
80104870:	55                   	push   %ebp
    struct proc *p;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104871:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
    }
}


void
priorityUnExtended(){
80104876:	89 e5                	mov    %esp,%ebp
80104878:	90                   	nop
80104879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct proc *p;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
        if (p->priority == 0)
80104880:	8b 88 88 00 00 00    	mov    0x88(%eax),%ecx
80104886:	85 c9                	test   %ecx,%ecx
80104888:	75 0b                	jne    80104895 <priorityUnExtended+0x25>
            p->priority = 1;
8010488a:	ba 01 00 00 00       	mov    $0x1,%edx
8010488f:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)


void
priorityUnExtended(){
    struct proc *p;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104895:	05 a8 00 00 00       	add    $0xa8,%eax
8010489a:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
8010489f:	75 df                	jne    80104880 <priorityUnExtended+0x10>
        if (p->priority == 0)
            p->priority = 1;
    }
}
801048a1:	5d                   	pop    %ebp
801048a2:	c3                   	ret    
801048a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801048a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048b0 <switchToRoundRobin>:

void
switchToRoundRobin(void){
801048b0:	55                   	push   %ebp
801048b1:	89 e5                	mov    %esp,%ebp
801048b3:	83 ec 18             	sub    $0x18,%esp
    struct proc *p;
    if(!pq.switchToRoundRobinPolicy())
801048b6:	ff 15 f4 c5 10 80    	call   *0x8010c5f4
801048bc:	85 c0                	test   %eax,%eax
801048be:	74 2b                	je     801048eb <switchToRoundRobin+0x3b>
801048c0:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
801048c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801048c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        panic("error in switch from policy 2/3 to policy 1\n");
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
        p->accumulator=0;
801048d0:	31 d2                	xor    %edx,%edx
801048d2:	31 c9                	xor    %ecx,%ecx
801048d4:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
void
switchToRoundRobin(void){
    struct proc *p;
    if(!pq.switchToRoundRobinPolicy())
        panic("error in switch from policy 2/3 to policy 1\n");
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801048da:	05 a8 00 00 00       	add    $0xa8,%eax
        p->accumulator=0;
801048df:	89 48 dc             	mov    %ecx,-0x24(%eax)
void
switchToRoundRobin(void){
    struct proc *p;
    if(!pq.switchToRoundRobinPolicy())
        panic("error in switch from policy 2/3 to policy 1\n");
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801048e2:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
801048e7:	75 e7                	jne    801048d0 <switchToRoundRobin+0x20>
        p->accumulator=0;
    }
}
801048e9:	c9                   	leave  
801048ea:	c3                   	ret    

void
switchToRoundRobin(void){
    struct proc *p;
    if(!pq.switchToRoundRobinPolicy())
        panic("error in switch from policy 2/3 to policy 1\n");
801048eb:	c7 04 24 a8 8d 10 80 	movl   $0x80108da8,(%esp)
801048f2:	e8 49 ba ff ff       	call   80100340 <panic>
801048f7:	89 f6                	mov    %esi,%esi
801048f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104900 <policy>:
        p->accumulator=0;
    }
}

void
policy(int num){
80104900:	55                   	push   %ebp
80104901:	89 e5                	mov    %esp,%ebp
80104903:	53                   	push   %ebx
80104904:	83 ec 14             	sub    $0x14,%esp
80104907:	8b 5d 08             	mov    0x8(%ebp),%ebx
    //check legal input
    //TODO- need to check if there is a need to change to default or to panic
    if(num>3 || num<1)
8010490a:	8d 43 ff             	lea    -0x1(%ebx),%eax
8010490d:	83 f8 02             	cmp    $0x2,%eax
80104910:	76 0e                	jbe    80104920 <policy+0x20>
    }
    currpolicy=num; //save the new policy
    release(&ptable.lock);


}
80104912:	83 c4 14             	add    $0x14,%esp
80104915:	5b                   	pop    %ebx
80104916:	5d                   	pop    %ebp
80104917:	c3                   	ret    
80104918:	90                   	nop
80104919:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80104920:	fb                   	sti    
    if(num>3 || num<1)
        return; //currpolicy get the default policy
    // Enable interrupts on this processor.
    sti();
    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80104921:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104928:	e8 a3 10 00 00       	call   801059d0 <acquire>
    switch (currpolicy){
8010492d:	a1 04 c0 10 80       	mov    0x8010c004,%eax
80104932:	83 f8 02             	cmp    $0x2,%eax
80104935:	74 41                	je     80104978 <policy+0x78>
80104937:	83 f8 03             	cmp    $0x3,%eax
8010493a:	74 14                	je     80104950 <policy+0x50>
8010493c:	48                   	dec    %eax
8010493d:	74 49                	je     80104988 <policy+0x88>
            if(num==2){
                priorityUnExtended();
            }
            break;
        default:
            panic("illegal policy number\n");
8010493f:	c7 04 24 3d 8d 10 80 	movl   $0x80108d3d,(%esp)
80104946:	e8 f5 b9 ff ff       	call   80100340 <panic>
8010494b:	90                   	nop
8010494c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                switchToRoundRobin();
            }
            break;

        case 3:
            if(num==1){
80104950:	83 fb 01             	cmp    $0x1,%ebx
80104953:	74 28                	je     8010497d <policy+0x7d>
                switchToRoundRobin();
            }
            if(num==2){
80104955:	83 fb 02             	cmp    $0x2,%ebx
80104958:	74 6e                	je     801049c8 <policy+0xc8>
            break;
        default:
            panic("illegal policy number\n");
            break;
    }
    currpolicy=num; //save the new policy
8010495a:	89 1d 04 c0 10 80    	mov    %ebx,0x8010c004
    release(&ptable.lock);
80104960:	c7 45 08 80 4d 11 80 	movl   $0x80114d80,0x8(%ebp)


}
80104967:	83 c4 14             	add    $0x14,%esp
8010496a:	5b                   	pop    %ebx
8010496b:	5d                   	pop    %ebp
        default:
            panic("illegal policy number\n");
            break;
    }
    currpolicy=num; //save the new policy
    release(&ptable.lock);
8010496c:	e9 ff 10 00 00       	jmp    80105a70 <release>
80104971:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                    priorityUnExtended();
            }
            break;

        case 2:
            if(num==1){
80104978:	83 fb 01             	cmp    $0x1,%ebx
8010497b:	75 dd                	jne    8010495a <policy+0x5a>
                switchToRoundRobin();
8010497d:	e8 2e ff ff ff       	call   801048b0 <switchToRoundRobin>
80104982:	eb d6                	jmp    8010495a <policy+0x5a>
80104984:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sti();
    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    switch (currpolicy){
        case 1:
            if(num==2 || num==3){
80104988:	8d 43 fe             	lea    -0x2(%ebx),%eax
8010498b:	83 f8 01             	cmp    $0x1,%eax
8010498e:	77 ca                	ja     8010495a <policy+0x5a>
                rrq.switchToPriorityQueuePolicy();
80104990:	ff 15 e0 c5 10 80    	call   *0x8010c5e0
                //if(!rrq.switchToPriorityQueuePolicy())
                //    panic("error in switch from rouncrobin to priority queue\n");
                //if num=2 ->check that there are no priority=0
                if(num==2)
80104996:	83 fb 02             	cmp    $0x2,%ebx
80104999:	75 bf                	jne    8010495a <policy+0x5a>
8010499b:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax

void
priorityUnExtended(){
    struct proc *p;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
        if (p->priority == 0)
801049a0:	8b 88 88 00 00 00    	mov    0x88(%eax),%ecx
801049a6:	85 c9                	test   %ecx,%ecx
801049a8:	75 0b                	jne    801049b5 <policy+0xb5>
            p->priority = 1;
801049aa:	ba 01 00 00 00       	mov    $0x1,%edx
801049af:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)


void
priorityUnExtended(){
    struct proc *p;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801049b5:	05 a8 00 00 00       	add    $0xa8,%eax
801049ba:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
801049bf:	75 df                	jne    801049a0 <policy+0xa0>
801049c1:	eb 97                	jmp    8010495a <policy+0x5a>
801049c3:	90                   	nop
801049c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801049c8:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
801049cd:	8d 76 00             	lea    0x0(%esi),%esi
        if (p->priority == 0)
801049d0:	8b 88 88 00 00 00    	mov    0x88(%eax),%ecx
801049d6:	85 c9                	test   %ecx,%ecx
801049d8:	75 0b                	jne    801049e5 <policy+0xe5>
            p->priority = 1;
801049da:	ba 01 00 00 00       	mov    $0x1,%edx
801049df:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)


void
priorityUnExtended(){
    struct proc *p;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801049e5:	05 a8 00 00 00       	add    $0xa8,%eax
801049ea:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
801049ef:	75 df                	jne    801049d0 <policy+0xd0>
801049f1:	e9 64 ff ff ff       	jmp    8010495a <policy+0x5a>
801049f6:	8d 76 00             	lea    0x0(%esi),%esi
801049f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a00 <wait_stat>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait_stat(int* status, struct perf* performance)
{
80104a00:	55                   	push   %ebp
80104a01:	89 e5                	mov    %esp,%ebp
80104a03:	57                   	push   %edi
80104a04:	56                   	push   %esi
80104a05:	53                   	push   %ebx
80104a06:	83 ec 1c             	sub    $0x1c,%esp
80104a09:	8b 75 0c             	mov    0xc(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
    struct cpu *c;
    struct proc *p;
    pushcli();
80104a0c:	e8 cf 0e 00 00       	call   801058e0 <pushcli>
    c = mycpu();
80104a11:	e8 1a ef ff ff       	call   80103930 <mycpu>
    p = c->proc;
80104a16:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
    popcli();
80104a1c:	e8 ff 0e 00 00       	call   80105920 <popcli>
{
    struct proc *p;
    int havekids, pid;
    struct proc *curproc = myproc();

    acquire(&ptable.lock);
80104a21:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104a28:	e8 a3 0f 00 00       	call   801059d0 <acquire>
    for(;;){
        // Scan through table looking for exited children.
        havekids = 0;
80104a2d:	31 d2                	xor    %edx,%edx
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a2f:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
80104a34:	eb 18                	jmp    80104a4e <wait_stat+0x4e>
80104a36:	8d 76 00             	lea    0x0(%esi),%esi
80104a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104a40:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80104a46:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
80104a4c:	74 22                	je     80104a70 <wait_stat+0x70>
            if(p->parent != curproc)
80104a4e:	39 7b 14             	cmp    %edi,0x14(%ebx)
80104a51:	75 ed                	jne    80104a40 <wait_stat+0x40>
                continue;
            havekids = 1;

            if(p->state == ZOMBIE){
80104a53:	8b 53 0c             	mov    0xc(%ebx),%edx
80104a56:	83 fa 05             	cmp    $0x5,%edx
80104a59:	74 3b                	je     80104a96 <wait_stat+0x96>

    acquire(&ptable.lock);
    for(;;){
        // Scan through table looking for exited children.
        havekids = 0;
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a5b:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
            if(p->parent != curproc)
                continue;
            havekids = 1;
80104a61:	ba 01 00 00 00       	mov    $0x1,%edx

    acquire(&ptable.lock);
    for(;;){
        // Scan through table looking for exited children.
        havekids = 0;
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a66:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
80104a6c:	75 e0                	jne    80104a4e <wait_stat+0x4e>
80104a6e:	66 90                	xchg   %ax,%ax
                return pid;
            }
        }

        // No point waiting if we don't have any children.
        if(!havekids || curproc->killed){
80104a70:	85 d2                	test   %edx,%edx
80104a72:	0f 84 ad 00 00 00    	je     80104b25 <wait_stat+0x125>
80104a78:	8b 57 24             	mov    0x24(%edi),%edx
80104a7b:	85 d2                	test   %edx,%edx
80104a7d:	0f 85 a2 00 00 00    	jne    80104b25 <wait_stat+0x125>
            release(&ptable.lock);
            return -1;
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104a83:	b8 80 4d 11 80       	mov    $0x80114d80,%eax
80104a88:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a8c:	89 3c 24             	mov    %edi,(%esp)
80104a8f:	e8 ec f8 ff ff       	call   80104380 <sleep>
    }
80104a94:	eb 97                	jmp    80104a2d <wait_stat+0x2d>
            havekids = 1;

            if(p->state == ZOMBIE){

                //TODO we added values here;
                performance->ctime = p->proc_perf.ctime;
80104a96:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80104a9c:	89 06                	mov    %eax,(%esi)
                performance->ttime = p->proc_perf.ttime;
80104a9e:	8b 83 90 00 00 00    	mov    0x90(%ebx),%eax
80104aa4:	89 46 04             	mov    %eax,0x4(%esi)
                performance->stime = p->proc_perf.stime;
80104aa7:	8b 83 94 00 00 00    	mov    0x94(%ebx),%eax
80104aad:	89 46 08             	mov    %eax,0x8(%esi)
                performance->retime = p->proc_perf.retime;
80104ab0:	8b 83 98 00 00 00    	mov    0x98(%ebx),%eax
80104ab6:	89 46 0c             	mov    %eax,0xc(%esi)
                performance->rutime = p->proc_perf.rutime;
80104ab9:	8b 83 9c 00 00 00    	mov    0x9c(%ebx),%eax
80104abf:	89 46 10             	mov    %eax,0x10(%esi)
                // Found one.
                pid = p->pid;
                kfree(p->kstack);
80104ac2:	8b 43 08             	mov    0x8(%ebx),%eax
                performance->ttime = p->proc_perf.ttime;
                performance->stime = p->proc_perf.stime;
                performance->retime = p->proc_perf.retime;
                performance->rutime = p->proc_perf.rutime;
                // Found one.
                pid = p->pid;
80104ac5:	8b 73 10             	mov    0x10(%ebx),%esi
                kfree(p->kstack);
80104ac8:	89 04 24             	mov    %eax,(%esp)
80104acb:	e8 c0 d8 ff ff       	call   80102390 <kfree>
                p->kstack = 0;
                freevm(p->pgdir);
80104ad0:	8b 43 04             	mov    0x4(%ebx),%eax
                performance->retime = p->proc_perf.retime;
                performance->rutime = p->proc_perf.rutime;
                // Found one.
                pid = p->pid;
                kfree(p->kstack);
                p->kstack = 0;
80104ad3:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
                freevm(p->pgdir);
80104ada:	89 04 24             	mov    %eax,(%esp)
80104add:	e8 ae 38 00 00       	call   80108390 <freevm>
                p->parent = 0;
                p->name[0] = 0;
                p->killed = 0;
                p->state = UNUSED;
                //TODO - maybe need to use argptr
                if(status!=null)
80104ae2:	8b 4d 08             	mov    0x8(%ebp),%ecx
                // Found one.
                pid = p->pid;
                kfree(p->kstack);
                p->kstack = 0;
                freevm(p->pgdir);
                p->pid = 0;
80104ae5:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
                p->parent = 0;
80104aec:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
                p->name[0] = 0;
80104af3:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
                p->killed = 0;
                p->state = UNUSED;
                //TODO - maybe need to use argptr
                if(status!=null)
80104af7:	85 c9                	test   %ecx,%ecx
                p->kstack = 0;
                freevm(p->pgdir);
                p->pid = 0;
                p->parent = 0;
                p->name[0] = 0;
                p->killed = 0;
80104af9:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
                p->state = UNUSED;
80104b00:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
                //TODO - maybe need to use argptr
                if(status!=null)
80104b07:	74 06                	je     80104b0f <wait_stat+0x10f>
                    p->exit_status= (int)status ;
80104b09:	8b 45 08             	mov    0x8(%ebp),%eax
80104b0c:	89 43 7c             	mov    %eax,0x7c(%ebx)

                release(&ptable.lock);
80104b0f:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104b16:	e8 55 0f 00 00       	call   80105a70 <release>
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
    }
}
80104b1b:	83 c4 1c             	add    $0x1c,%esp
                //TODO - maybe need to use argptr
                if(status!=null)
                    p->exit_status= (int)status ;

                release(&ptable.lock);
                return pid;
80104b1e:	89 f0                	mov    %esi,%eax
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
    }
}
80104b20:	5b                   	pop    %ebx
80104b21:	5e                   	pop    %esi
80104b22:	5f                   	pop    %edi
80104b23:	5d                   	pop    %ebp
80104b24:	c3                   	ret    
            }
        }

        // No point waiting if we don't have any children.
        if(!havekids || curproc->killed){
            release(&ptable.lock);
80104b25:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104b2c:	e8 3f 0f 00 00       	call   80105a70 <release>
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
    }
}
80104b31:	83 c4 1c             	add    $0x1c,%esp
        }

        // No point waiting if we don't have any children.
        if(!havekids || curproc->killed){
            release(&ptable.lock);
            return -1;
80104b34:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
    }
}
80104b39:	5b                   	pop    %ebx
80104b3a:	5e                   	pop    %esi
80104b3b:	5f                   	pop    %edi
80104b3c:	5d                   	pop    %ebp
80104b3d:	c3                   	ret    
80104b3e:	66 90                	xchg   %ax,%ax

80104b40 <isEmptyPriorityQueue>:
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
80104b40:	a1 14 c6 10 80       	mov    0x8010c614,%eax
	spaceLeft -= size;
	return ans;
}

//for pq
static boolean isEmptyPriorityQueue() {
80104b45:	55                   	push   %ebp
80104b46:	89 e5                	mov    %esp,%ebp
	return priorityQ->isEmpty();
}
80104b48:	5d                   	pop    %ebp
	return ans;
}

//for pq
static boolean isEmptyPriorityQueue() {
	return priorityQ->isEmpty();
80104b49:	8b 00                	mov    (%eax),%eax
80104b4b:	85 c0                	test   %eax,%eax
80104b4d:	0f 94 c0             	sete   %al
80104b50:	0f b6 c0             	movzbl %al,%eax
}
80104b53:	c3                   	ret    
80104b54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104b60 <getMinAccumulatorPriorityQueue>:
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
80104b60:	a1 14 c6 10 80       	mov    0x8010c614,%eax
80104b65:	8b 10                	mov    (%eax),%edx
	
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
	if(isEmpty())
80104b67:	85 d2                	test   %edx,%edx
80104b69:	75 07                	jne    80104b72 <getMinAccumulatorPriorityQueue+0x12>
80104b6b:	eb 2b                	jmp    80104b98 <getMinAccumulatorPriorityQueue+0x38>
80104b6d:	8d 76 00             	lea    0x0(%esi),%esi
	}
}

MapNode* MapNode::getMinNode() { //no recursion.
	MapNode* minNode = this;	
	while(minNode->left)
80104b70:	89 c2                	mov    %eax,%edx
80104b72:	8b 42 18             	mov    0x18(%edx),%eax
80104b75:	85 c0                	test   %eax,%eax
80104b77:	75 f7                	jne    80104b70 <getMinAccumulatorPriorityQueue+0x10>

static boolean putPriorityQueue(Proc* p) {
	return priorityQ->put(p);
}

static boolean getMinAccumulatorPriorityQueue(long long* pkey) {
80104b79:	55                   	push   %ebp
80104b7a:	89 e5                	mov    %esp,%ebp
80104b7c:	53                   	push   %ebx

	return minNode;
}

void MapNode::getMinKey(long long *pkey) {
	*pkey = getMinNode()->key;
80104b7d:	8b 45 08             	mov    0x8(%ebp),%eax
80104b80:	8b 5a 04             	mov    0x4(%edx),%ebx
80104b83:	8b 0a                	mov    (%edx),%ecx
80104b85:	89 58 04             	mov    %ebx,0x4(%eax)
80104b88:	89 08                	mov    %ecx,(%eax)
80104b8a:	b8 01 00 00 00       	mov    $0x1,%eax
	return priorityQ->put(p);
}

static boolean getMinAccumulatorPriorityQueue(long long* pkey) {
	return priorityQ->getMinKey(pkey);
}
80104b8f:	5b                   	pop    %ebx
80104b90:	5d                   	pop    %ebp
80104b91:	c3                   	ret    
80104b92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
	if(isEmpty())
80104b98:	31 c0                	xor    %eax,%eax
80104b9a:	c3                   	ret    
80104b9b:	90                   	nop
80104b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ba0 <isEmptyRoundRobinQueue>:

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
80104ba0:	a1 10 c6 10 80       	mov    0x8010c610,%eax
static boolean extractProcPriorityQueue(Proc *p) {
	return priorityQ->extractProc(p);
}

//for rrq
static boolean isEmptyRoundRobinQueue() {
80104ba5:	55                   	push   %ebp
80104ba6:	89 e5                	mov    %esp,%ebp
	return roundRobinQ->isEmpty();
}
80104ba8:	5d                   	pop    %ebp
	return priorityQ->extractProc(p);
}

//for rrq
static boolean isEmptyRoundRobinQueue() {
	return roundRobinQ->isEmpty();
80104ba9:	8b 00                	mov    (%eax),%eax
80104bab:	85 c0                	test   %eax,%eax
80104bad:	0f 94 c0             	sete   %al
80104bb0:	0f b6 c0             	movzbl %al,%eax
}
80104bb3:	c3                   	ret    
80104bb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104bba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104bc0 <dequeueRoundRobinQueue>:
static boolean enqueueRoundRobinQueue(Proc *p) {
	return roundRobinQ->enqueue(p);
}

static Proc* dequeueRoundRobinQueue() {
	return roundRobinQ->dequeue();
80104bc0:	8b 0d 10 c6 10 80    	mov    0x8010c610,%ecx

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
80104bc6:	8b 11                	mov    (%ecx),%edx
	append(link);
	return true;
}

Proc* LinkedList::dequeue() {
	if(isEmpty())
80104bc8:	85 d2                	test   %edx,%edx
80104bca:	74 4c                	je     80104c18 <dequeueRoundRobinQueue+0x58>

static boolean enqueueRoundRobinQueue(Proc *p) {
	return roundRobinQ->enqueue(p);
}

static Proc* dequeueRoundRobinQueue() {
80104bcc:	55                   	push   %ebp
80104bcd:	89 e5                	mov    %esp,%ebp
80104bcf:	83 ec 08             	sub    $0x8,%esp
80104bd2:	89 75 fc             	mov    %esi,-0x4(%ebp)
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80104bd5:	8b 35 08 c6 10 80    	mov    0x8010c608,%esi

static boolean enqueueRoundRobinQueue(Proc *p) {
	return roundRobinQ->enqueue(p);
}

static Proc* dequeueRoundRobinQueue() {
80104bdb:	89 5d f8             	mov    %ebx,-0x8(%ebp)
Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;

	Proc *p = first->p;
	Link *next = first->next;
80104bde:	8b 5a 04             	mov    0x4(%edx),%ebx

Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;

	Proc *p = first->p;
80104be1:	8b 02                	mov    (%edx),%eax
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80104be3:	89 72 04             	mov    %esi,0x4(%edx)
	freeLinks = link;
80104be6:	89 15 08 c6 10 80    	mov    %edx,0x8010c608
	
	deallocLink(first);
	
	first = next;

	if(isEmpty())
80104bec:	85 db                	test   %ebx,%ebx
	Proc *p = first->p;
	Link *next = first->next;
	
	deallocLink(first);
	
	first = next;
80104bee:	89 19                	mov    %ebx,(%ecx)

	if(isEmpty())
80104bf0:	74 0e                	je     80104c00 <dequeueRoundRobinQueue+0x40>
	return roundRobinQ->enqueue(p);
}

static Proc* dequeueRoundRobinQueue() {
	return roundRobinQ->dequeue();
}
80104bf2:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104bf5:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104bf8:	89 ec                	mov    %ebp,%esp
80104bfa:	5d                   	pop    %ebp
80104bfb:	c3                   	ret    
80104bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	deallocLink(first);
	
	first = next;

	if(isEmpty())
		last = null;
80104c00:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
	return roundRobinQ->enqueue(p);
}

static Proc* dequeueRoundRobinQueue() {
	return roundRobinQ->dequeue();
}
80104c07:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104c0a:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104c0d:	89 ec                	mov    %ebp,%esp
80104c0f:	5d                   	pop    %ebp
80104c10:	c3                   	ret    
80104c11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	return true;
}

Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;
80104c18:	31 c0                	xor    %eax,%eax
80104c1a:	c3                   	ret    
80104c1b:	90                   	nop
80104c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c20 <isEmptyRunningProcessHolder>:

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
80104c20:	a1 0c c6 10 80       	mov    0x8010c60c,%eax
static boolean switchToPriorityQueuePolicyRoundRobinQueue() {
	return roundRobinQ->transfer();
}

//for rpholder
static boolean isEmptyRunningProcessHolder() {
80104c25:	55                   	push   %ebp
80104c26:	89 e5                	mov    %esp,%ebp
	return runningProcHolder->isEmpty();
}
80104c28:	5d                   	pop    %ebp
	return roundRobinQ->transfer();
}

//for rpholder
static boolean isEmptyRunningProcessHolder() {
	return runningProcHolder->isEmpty();
80104c29:	8b 00                	mov    (%eax),%eax
80104c2b:	85 c0                	test   %eax,%eax
80104c2d:	0f 94 c0             	sete   %al
80104c30:	0f b6 c0             	movzbl %al,%eax
}
80104c33:	c3                   	ret    
80104c34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104c40 <_ZL8mymallocj>:
static MapNode                    *freeNodes;

static char                       *data;
static uint                       spaceLeft;
                
static char* mymalloc(uint size) {
80104c40:	55                   	push   %ebp
80104c41:	89 e5                	mov    %esp,%ebp
80104c43:	53                   	push   %ebx
80104c44:	89 c3                	mov    %eax,%ebx
80104c46:	83 ec 14             	sub    $0x14,%esp
	if(spaceLeft < size) {
80104c49:	8b 15 fc c5 10 80    	mov    0x8010c5fc,%edx
80104c4f:	39 c2                	cmp    %eax,%edx
80104c51:	73 26                	jae    80104c79 <_ZL8mymallocj+0x39>
		data = kalloc();
80104c53:	e8 08 d9 ff ff       	call   80102560 <kalloc>
		memset(data, 0, PGSIZE);
80104c58:	ba 00 10 00 00       	mov    $0x1000,%edx
80104c5d:	31 c9                	xor    %ecx,%ecx
80104c5f:	89 54 24 08          	mov    %edx,0x8(%esp)
80104c63:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80104c67:	89 04 24             	mov    %eax,(%esp)
static char                       *data;
static uint                       spaceLeft;
                
static char* mymalloc(uint size) {
	if(spaceLeft < size) {
		data = kalloc();
80104c6a:	a3 00 c6 10 80       	mov    %eax,0x8010c600
		memset(data, 0, PGSIZE);
80104c6f:	e8 4c 0e 00 00       	call   80105ac0 <memset>
80104c74:	ba 00 10 00 00       	mov    $0x1000,%edx
		spaceLeft = PGSIZE;
	}

	char* ans = data;
80104c79:	a1 00 c6 10 80       	mov    0x8010c600,%eax
	data += size;
	spaceLeft -= size;
80104c7e:	29 da                	sub    %ebx,%edx
80104c80:	89 15 fc c5 10 80    	mov    %edx,0x8010c5fc
		memset(data, 0, PGSIZE);
		spaceLeft = PGSIZE;
	}

	char* ans = data;
	data += size;
80104c86:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
80104c89:	89 0d 00 c6 10 80    	mov    %ecx,0x8010c600
	spaceLeft -= size;
	return ans;
}
80104c8f:	83 c4 14             	add    $0x14,%esp
80104c92:	5b                   	pop    %ebx
80104c93:	5d                   	pop    %ebp
80104c94:	c3                   	ret    
80104c95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ca0 <initSchedDS>:

static boolean getMinAccumulatorRunningProcessHolder(long long *pkey) {
	return runningProcHolder->getMinKey(pkey);
}

void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104ca0:	55                   	push   %ebp
	data               = null;
80104ca1:	31 c0                	xor    %eax,%eax

static boolean getMinAccumulatorRunningProcessHolder(long long *pkey) {
	return runningProcHolder->getMinKey(pkey);
}

void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104ca3:	89 e5                	mov    %esp,%ebp
80104ca5:	53                   	push   %ebx
	*roundRobinQ       = LinkedList();

	runningProcHolder  = (LinkedList*)mymalloc(sizeof(LinkedList));
	*runningProcHolder = LinkedList();

	freeLinks = null;
80104ca6:	bb 80 00 00 00       	mov    $0x80,%ebx

static boolean getMinAccumulatorRunningProcessHolder(long long *pkey) {
	return runningProcHolder->getMinKey(pkey);
}

void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104cab:	83 ec 04             	sub    $0x4,%esp
	data               = null;
80104cae:	a3 00 c6 10 80       	mov    %eax,0x8010c600
	spaceLeft          = 0u;
80104cb3:	31 c0                	xor    %eax,%eax
80104cb5:	a3 fc c5 10 80       	mov    %eax,0x8010c5fc

	priorityQ          = (Map*)mymalloc(sizeof(Map));
80104cba:	b8 04 00 00 00       	mov    $0x4,%eax
80104cbf:	e8 7c ff ff ff       	call   80104c40 <_ZL8mymallocj>
80104cc4:	a3 14 c6 10 80       	mov    %eax,0x8010c614
	*priorityQ         = Map();
80104cc9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	roundRobinQ        = (LinkedList*)mymalloc(sizeof(LinkedList));
80104ccf:	b8 08 00 00 00       	mov    $0x8,%eax
80104cd4:	e8 67 ff ff ff       	call   80104c40 <_ZL8mymallocj>
80104cd9:	a3 10 c6 10 80       	mov    %eax,0x8010c610
	*roundRobinQ       = LinkedList();
80104cde:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104ce4:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)

	runningProcHolder  = (LinkedList*)mymalloc(sizeof(LinkedList));
80104ceb:	b8 08 00 00 00       	mov    $0x8,%eax
80104cf0:	e8 4b ff ff ff       	call   80104c40 <_ZL8mymallocj>
80104cf5:	a3 0c c6 10 80       	mov    %eax,0x8010c60c
	*runningProcHolder = LinkedList();
80104cfa:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104d00:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)

	freeLinks = null;
80104d07:	31 c0                	xor    %eax,%eax
80104d09:	a3 08 c6 10 80       	mov    %eax,0x8010c608
80104d0e:	66 90                	xchg   %ax,%ax
	for(int i = 0; i < NPROCLIST; ++i) {
		Link *link = (Link*)mymalloc(sizeof(Link));
80104d10:	b8 08 00 00 00       	mov    $0x8,%eax
80104d15:	e8 26 ff ff ff       	call   80104c40 <_ZL8mymallocj>
		*link = Link();
		link->next = freeLinks;
80104d1a:	8b 15 08 c6 10 80    	mov    0x8010c608,%edx

	runningProcHolder  = (LinkedList*)mymalloc(sizeof(LinkedList));
	*runningProcHolder = LinkedList();

	freeLinks = null;
	for(int i = 0; i < NPROCLIST; ++i) {
80104d20:	4b                   	dec    %ebx
		Link *link = (Link*)mymalloc(sizeof(Link));
		*link = Link();
80104d21:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		link->next = freeLinks;
80104d27:	89 50 04             	mov    %edx,0x4(%eax)
		freeLinks = link;
80104d2a:	a3 08 c6 10 80       	mov    %eax,0x8010c608

	runningProcHolder  = (LinkedList*)mymalloc(sizeof(LinkedList));
	*runningProcHolder = LinkedList();

	freeLinks = null;
	for(int i = 0; i < NPROCLIST; ++i) {
80104d2f:	75 df                	jne    80104d10 <initSchedDS+0x70>
		*link = Link();
		link->next = freeLinks;
		freeLinks = link;
	}

	freeNodes = null;
80104d31:	31 c0                	xor    %eax,%eax
80104d33:	bb 80 00 00 00       	mov    $0x80,%ebx
80104d38:	a3 04 c6 10 80       	mov    %eax,0x8010c604
80104d3d:	8d 76 00             	lea    0x0(%esi),%esi
	for(int i = 0; i < NPROCMAP; ++i) {
		MapNode *node = (MapNode*)mymalloc(sizeof(MapNode));
80104d40:	b8 20 00 00 00       	mov    $0x20,%eax
80104d45:	e8 f6 fe ff ff       	call   80104c40 <_ZL8mymallocj>
		*node = MapNode();
		node->next = freeNodes;
80104d4a:	8b 15 04 c6 10 80    	mov    0x8010c604,%edx
		link->next = freeLinks;
		freeLinks = link;
	}

	freeNodes = null;
	for(int i = 0; i < NPROCMAP; ++i) {
80104d50:	4b                   	dec    %ebx
		MapNode *node = (MapNode*)mymalloc(sizeof(MapNode));
		*node = MapNode();
80104d51:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80104d58:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
80104d5f:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
80104d66:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
80104d6d:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
		node->next = freeNodes;
80104d74:	89 50 10             	mov    %edx,0x10(%eax)
		freeNodes = node;
80104d77:	a3 04 c6 10 80       	mov    %eax,0x8010c604
		link->next = freeLinks;
		freeLinks = link;
	}

	freeNodes = null;
	for(int i = 0; i < NPROCMAP; ++i) {
80104d7c:	75 c2                	jne    80104d40 <initSchedDS+0xa0>
		node->next = freeNodes;
		freeNodes = node;
	}

	//init pq
	pq.isEmpty                      = isEmptyPriorityQueue;
80104d7e:	b8 40 4b 10 80       	mov    $0x80104b40,%eax
	pq.put                          = putPriorityQueue;
80104d83:	ba e0 53 10 80       	mov    $0x801053e0,%edx
		node->next = freeNodes;
		freeNodes = node;
	}

	//init pq
	pq.isEmpty                      = isEmptyPriorityQueue;
80104d88:	a3 e4 c5 10 80       	mov    %eax,0x8010c5e4
	pq.put                          = putPriorityQueue;
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
	pq.extractMin                   = extractMinPriorityQueue;
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
80104d8d:	b8 70 55 10 80       	mov    $0x80105570,%eax
	}

	//init pq
	pq.isEmpty                      = isEmptyPriorityQueue;
	pq.put                          = putPriorityQueue;
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
80104d92:	b9 60 4b 10 80       	mov    $0x80104b60,%ecx
	pq.extractMin                   = extractMinPriorityQueue;
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
80104d97:	a3 f4 c5 10 80       	mov    %eax,0x8010c5f4
	pq.extractProc                  = extractProcPriorityQueue;
80104d9c:	b8 40 56 10 80       	mov    $0x80105640,%eax

	//init pq
	pq.isEmpty                      = isEmptyPriorityQueue;
	pq.put                          = putPriorityQueue;
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
	pq.extractMin                   = extractMinPriorityQueue;
80104da1:	bb 00 55 10 80       	mov    $0x80105500,%ebx
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
	pq.extractProc                  = extractProcPriorityQueue;
80104da6:	a3 f8 c5 10 80       	mov    %eax,0x8010c5f8

	//init rrq
	rrq.isEmpty                     = isEmptyRoundRobinQueue;
80104dab:	b8 a0 4b 10 80       	mov    $0x80104ba0,%eax
80104db0:	a3 d4 c5 10 80       	mov    %eax,0x8010c5d4
	rrq.enqueue                     = enqueueRoundRobinQueue;
80104db5:	b8 10 4f 10 80       	mov    $0x80104f10,%eax
80104dba:	a3 d8 c5 10 80       	mov    %eax,0x8010c5d8
	rrq.dequeue                     = dequeueRoundRobinQueue;
80104dbf:	b8 c0 4b 10 80       	mov    $0x80104bc0,%eax
80104dc4:	a3 dc c5 10 80       	mov    %eax,0x8010c5dc
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;
80104dc9:	b8 40 51 10 80       	mov    $0x80105140,%eax
		freeNodes = node;
	}

	//init pq
	pq.isEmpty                      = isEmptyPriorityQueue;
	pq.put                          = putPriorityQueue;
80104dce:	89 15 e8 c5 10 80    	mov    %edx,0x8010c5e8
	rrq.enqueue                     = enqueueRoundRobinQueue;
	rrq.dequeue                     = dequeueRoundRobinQueue;
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;

	//init rpholder
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
80104dd4:	ba 20 4c 10 80       	mov    $0x80104c20,%edx
	}

	//init pq
	pq.isEmpty                      = isEmptyPriorityQueue;
	pq.put                          = putPriorityQueue;
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
80104dd9:	89 0d ec c5 10 80    	mov    %ecx,0x8010c5ec
	rrq.dequeue                     = dequeueRoundRobinQueue;
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;

	//init rpholder
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
	rpholder.add                    = addRunningProcessHolder;
80104ddf:	b9 f0 4e 10 80       	mov    $0x80104ef0,%ecx

	//init pq
	pq.isEmpty                      = isEmptyPriorityQueue;
	pq.put                          = putPriorityQueue;
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
	pq.extractMin                   = extractMinPriorityQueue;
80104de4:	89 1d f0 c5 10 80    	mov    %ebx,0x8010c5f0
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;

	//init rpholder
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
	rpholder.add                    = addRunningProcessHolder;
	rpholder.remove                 = removeRunningProcessHolder;
80104dea:	bb a0 50 10 80       	mov    $0x801050a0,%ebx

	//init rrq
	rrq.isEmpty                     = isEmptyRoundRobinQueue;
	rrq.enqueue                     = enqueueRoundRobinQueue;
	rrq.dequeue                     = dequeueRoundRobinQueue;
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;
80104def:	a3 e0 c5 10 80       	mov    %eax,0x8010c5e0

	//init rpholder
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
	rpholder.add                    = addRunningProcessHolder;
	rpholder.remove                 = removeRunningProcessHolder;
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
80104df4:	b8 e0 51 10 80       	mov    $0x801051e0,%eax
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;

	//init rpholder
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
	rpholder.add                    = addRunningProcessHolder;
	rpholder.remove                 = removeRunningProcessHolder;
80104df9:	89 1d cc c5 10 80    	mov    %ebx,0x8010c5cc
	rrq.enqueue                     = enqueueRoundRobinQueue;
	rrq.dequeue                     = dequeueRoundRobinQueue;
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;

	//init rpholder
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
80104dff:	89 15 c4 c5 10 80    	mov    %edx,0x8010c5c4
	rpholder.add                    = addRunningProcessHolder;
80104e05:	89 0d c8 c5 10 80    	mov    %ecx,0x8010c5c8
	rpholder.remove                 = removeRunningProcessHolder;
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
80104e0b:	a3 d0 c5 10 80       	mov    %eax,0x8010c5d0
}
80104e10:	58                   	pop    %eax
80104e11:	5b                   	pop    %ebx
80104e12:	5d                   	pop    %ebp
80104e13:	c3                   	ret    
80104e14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104e20 <_ZN4Link7getLastEv>:
	}

	return ans;
}

Link* Link::getLast() {
80104e20:	55                   	push   %ebp
80104e21:	89 e5                	mov    %esp,%ebp
	Link* ans = this;
80104e23:	8b 45 08             	mov    0x8(%ebp),%eax
80104e26:	eb 0a                	jmp    80104e32 <_ZN4Link7getLastEv+0x12>
80104e28:	90                   	nop
80104e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e30:	89 d0                	mov    %edx,%eax
	
	while(ans->next)
80104e32:	8b 50 04             	mov    0x4(%eax),%edx
80104e35:	85 d2                	test   %edx,%edx
80104e37:	75 f7                	jne    80104e30 <_ZN4Link7getLastEv+0x10>
		ans = ans->next;

	return ans;
}
80104e39:	5d                   	pop    %ebp
80104e3a:	c3                   	ret    
80104e3b:	90                   	nop
80104e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104e40 <_ZN10LinkedList7isEmptyEv>:

bool LinkedList::isEmpty() {
80104e40:	55                   	push   %ebp
80104e41:	89 e5                	mov    %esp,%ebp
	return !first;
80104e43:	8b 45 08             	mov    0x8(%ebp),%eax
}
80104e46:	5d                   	pop    %ebp

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
80104e47:	8b 00                	mov    (%eax),%eax
80104e49:	85 c0                	test   %eax,%eax
80104e4b:	0f 94 c0             	sete   %al
}
80104e4e:	c3                   	ret    
80104e4f:	90                   	nop

80104e50 <_ZN10LinkedList6appendEP4Link>:

void LinkedList::append(Link *link) {
80104e50:	55                   	push   %ebp
80104e51:	89 e5                	mov    %esp,%ebp
80104e53:	8b 55 0c             	mov    0xc(%ebp),%edx
80104e56:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!link)
80104e59:	85 d2                	test   %edx,%edx
80104e5b:	74 1f                	je     80104e7c <_ZN10LinkedList6appendEP4Link+0x2c>
		return;

	if(isEmpty()) first = link;
80104e5d:	8b 01                	mov    (%ecx),%eax
80104e5f:	85 c0                	test   %eax,%eax
80104e61:	74 1d                	je     80104e80 <_ZN10LinkedList6appendEP4Link+0x30>
	else last->next = link;
80104e63:	8b 41 04             	mov    0x4(%ecx),%eax
80104e66:	89 50 04             	mov    %edx,0x4(%eax)
80104e69:	eb 07                	jmp    80104e72 <_ZN10LinkedList6appendEP4Link+0x22>
80104e6b:	90                   	nop
80104e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

Link* Link::getLast() {
	Link* ans = this;
	
	while(ans->next)
80104e70:	89 c2                	mov    %eax,%edx
80104e72:	8b 42 04             	mov    0x4(%edx),%eax
80104e75:	85 c0                	test   %eax,%eax
80104e77:	75 f7                	jne    80104e70 <_ZN10LinkedList6appendEP4Link+0x20>
		return;

	if(isEmpty()) first = link;
	else last->next = link;

	last = link->getLast();
80104e79:	89 51 04             	mov    %edx,0x4(%ecx)
}
80104e7c:	5d                   	pop    %ebp
80104e7d:	c3                   	ret    
80104e7e:	66 90                	xchg   %ax,%ax

void LinkedList::append(Link *link) {
	if(!link)
		return;

	if(isEmpty()) first = link;
80104e80:	89 11                	mov    %edx,(%ecx)
80104e82:	eb ee                	jmp    80104e72 <_ZN10LinkedList6appendEP4Link+0x22>
80104e84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104e90 <_ZN10LinkedList7enqueueEP4proc>:
	rpholder.remove                 = removeRunningProcessHolder;
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
}

static Link* allocLink(Proc *p) {
	if(!freeLinks)
80104e90:	8b 15 08 c6 10 80    	mov    0x8010c608,%edx
	else last->next = link;

	last = link->getLast();
}

bool LinkedList::enqueue(Proc *p) {
80104e96:	55                   	push   %ebp
80104e97:	89 e5                	mov    %esp,%ebp
80104e99:	8b 4d 08             	mov    0x8(%ebp),%ecx
	rpholder.remove                 = removeRunningProcessHolder;
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
}

static Link* allocLink(Proc *p) {
	if(!freeLinks)
80104e9c:	85 d2                	test   %edx,%edx
80104e9e:	74 40                	je     80104ee0 <_ZN10LinkedList7enqueueEP4proc+0x50>
		return null;

	Link *ans = freeLinks;
	freeLinks = freeLinks->next;
80104ea0:	8b 42 04             	mov    0x4(%edx),%eax
	ans->next = null;
80104ea3:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
static Link* allocLink(Proc *p) {
	if(!freeLinks)
		return null;

	Link *ans = freeLinks;
	freeLinks = freeLinks->next;
80104eaa:	a3 08 c6 10 80       	mov    %eax,0x8010c608
	ans->next = null;
	ans->p = p;
80104eaf:	8b 45 0c             	mov    0xc(%ebp),%eax
80104eb2:	89 02                	mov    %eax,(%edx)

void LinkedList::append(Link *link) {
	if(!link)
		return;

	if(isEmpty()) first = link;
80104eb4:	8b 01                	mov    (%ecx),%eax
80104eb6:	85 c0                	test   %eax,%eax
80104eb8:	74 2e                	je     80104ee8 <_ZN10LinkedList7enqueueEP4proc+0x58>
	else last->next = link;
80104eba:	8b 41 04             	mov    0x4(%ecx),%eax
80104ebd:	89 50 04             	mov    %edx,0x4(%eax)
80104ec0:	eb 08                	jmp    80104eca <_ZN10LinkedList7enqueueEP4proc+0x3a>
80104ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}

Link* Link::getLast() {
	Link* ans = this;
	
	while(ans->next)
80104ec8:	89 c2                	mov    %eax,%edx
80104eca:	8b 42 04             	mov    0x4(%edx),%eax
80104ecd:	85 c0                	test   %eax,%eax
80104ecf:	75 f7                	jne    80104ec8 <_ZN10LinkedList7enqueueEP4proc+0x38>
		return;

	if(isEmpty()) first = link;
	else last->next = link;

	last = link->getLast();
80104ed1:	89 51 04             	mov    %edx,0x4(%ecx)
	
	if(!link)
		return false;

	append(link);
	return true;
80104ed4:	b0 01                	mov    $0x1,%al
}
80104ed6:	5d                   	pop    %ebp
80104ed7:	c3                   	ret    
80104ed8:	90                   	nop
80104ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

bool LinkedList::enqueue(Proc *p) {
	Link *link = allocLink(p);
	
	if(!link)
		return false;
80104ee0:	31 c0                	xor    %eax,%eax

	append(link);
	return true;
}
80104ee2:	5d                   	pop    %ebp
80104ee3:	c3                   	ret    
80104ee4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void LinkedList::append(Link *link) {
	if(!link)
		return;

	if(isEmpty()) first = link;
80104ee8:	89 11                	mov    %edx,(%ecx)
80104eea:	eb de                	jmp    80104eca <_ZN10LinkedList7enqueueEP4proc+0x3a>
80104eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ef0 <addRunningProcessHolder>:
//for rpholder
static boolean isEmptyRunningProcessHolder() {
	return runningProcHolder->isEmpty();
}

static boolean addRunningProcessHolder(Proc* p) {
80104ef0:	55                   	push   %ebp
80104ef1:	89 e5                	mov    %esp,%ebp
80104ef3:	83 ec 08             	sub    $0x8,%esp
	return runningProcHolder->enqueue(p);
80104ef6:	8b 45 08             	mov    0x8(%ebp),%eax
80104ef9:	89 44 24 04          	mov    %eax,0x4(%esp)
80104efd:	a1 0c c6 10 80       	mov    0x8010c60c,%eax
80104f02:	89 04 24             	mov    %eax,(%esp)
80104f05:	e8 86 ff ff ff       	call   80104e90 <_ZN10LinkedList7enqueueEP4proc>
}
80104f0a:	c9                   	leave  
static boolean isEmptyRunningProcessHolder() {
	return runningProcHolder->isEmpty();
}

static boolean addRunningProcessHolder(Proc* p) {
	return runningProcHolder->enqueue(p);
80104f0b:	0f b6 c0             	movzbl %al,%eax
}
80104f0e:	c3                   	ret    
80104f0f:	90                   	nop

80104f10 <enqueueRoundRobinQueue>:
//for rrq
static boolean isEmptyRoundRobinQueue() {
	return roundRobinQ->isEmpty();
}

static boolean enqueueRoundRobinQueue(Proc *p) {
80104f10:	55                   	push   %ebp
80104f11:	89 e5                	mov    %esp,%ebp
80104f13:	83 ec 08             	sub    $0x8,%esp
	return roundRobinQ->enqueue(p);
80104f16:	8b 45 08             	mov    0x8(%ebp),%eax
80104f19:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f1d:	a1 10 c6 10 80       	mov    0x8010c610,%eax
80104f22:	89 04 24             	mov    %eax,(%esp)
80104f25:	e8 66 ff ff ff       	call   80104e90 <_ZN10LinkedList7enqueueEP4proc>
}
80104f2a:	c9                   	leave  
static boolean isEmptyRoundRobinQueue() {
	return roundRobinQ->isEmpty();
}

static boolean enqueueRoundRobinQueue(Proc *p) {
	return roundRobinQ->enqueue(p);
80104f2b:	0f b6 c0             	movzbl %al,%eax
}
80104f2e:	c3                   	ret    
80104f2f:	90                   	nop

80104f30 <_ZL9allocNodeP4procx>:
	ans->next = null;
	ans->key = key;
	return ans;
}

static MapNode* allocNode(Proc *p, long long key) {
80104f30:	55                   	push   %ebp
80104f31:	89 e5                	mov    %esp,%ebp
80104f33:	56                   	push   %esi
80104f34:	53                   	push   %ebx
80104f35:	83 ec 08             	sub    $0x8,%esp
	if(!freeNodes)
80104f38:	8b 1d 04 c6 10 80    	mov    0x8010c604,%ebx
80104f3e:	85 db                	test   %ebx,%ebx
80104f40:	74 28                	je     80104f6a <_ZL9allocNodeP4procx+0x3a>
static MapNode* allocNode(long long key) {
	if(!freeNodes)
		return null;

	MapNode *ans = freeNodes;
	freeNodes = freeNodes->next;
80104f42:	8b 73 10             	mov    0x10(%ebx),%esi
	ans->next = null;
	ans->key = key;
80104f45:	89 13                	mov    %edx,(%ebx)
	if(!freeNodes)
		return null;

	MapNode *ans = freeNodes;
	freeNodes = freeNodes->next;
	ans->next = null;
80104f47:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
	ans->key = key;
80104f4e:	89 4b 04             	mov    %ecx,0x4(%ebx)

	MapNode *ans = allocNode(key);
	if(!ans)
		return null;

	if(!ans->listOfProcs.enqueue(p)) {
80104f51:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f55:	8d 43 08             	lea    0x8(%ebx),%eax
80104f58:	89 04 24             	mov    %eax,(%esp)
static MapNode* allocNode(long long key) {
	if(!freeNodes)
		return null;

	MapNode *ans = freeNodes;
	freeNodes = freeNodes->next;
80104f5b:	89 35 04 c6 10 80    	mov    %esi,0x8010c604

	MapNode *ans = allocNode(key);
	if(!ans)
		return null;

	if(!ans->listOfProcs.enqueue(p)) {
80104f61:	e8 2a ff ff ff       	call   80104e90 <_ZN10LinkedList7enqueueEP4proc>
80104f66:	84 c0                	test   %al,%al
80104f68:	74 0e                	je     80104f78 <_ZL9allocNodeP4procx+0x48>
		deallocNode(ans);
		return null;
	}

	return ans;
}
80104f6a:	83 c4 08             	add    $0x8,%esp
80104f6d:	89 d8                	mov    %ebx,%eax
80104f6f:	5b                   	pop    %ebx
80104f70:	5e                   	pop    %esi
80104f71:	5d                   	pop    %ebp
80104f72:	c3                   	ret    
80104f73:	90                   	nop
80104f74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	link->next = freeLinks;
	freeLinks = link;
}

static void deallocNode(MapNode *node) {
	node->parent = node->left = node->right = null;
80104f78:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
80104f7f:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
80104f86:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
	node->next = freeNodes;
80104f8d:	89 73 10             	mov    %esi,0x10(%ebx)
	freeNodes = node;
80104f90:	89 1d 04 c6 10 80    	mov    %ebx,0x8010c604
	if(!ans)
		return null;

	if(!ans->listOfProcs.enqueue(p)) {
		deallocNode(ans);
		return null;
80104f96:	31 db                	xor    %ebx,%ebx
80104f98:	eb d0                	jmp    80104f6a <_ZL9allocNodeP4procx+0x3a>
80104f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104fa0 <_ZN10LinkedList7dequeueEv>:

	append(link);
	return true;
}

Proc* LinkedList::dequeue() {
80104fa0:	55                   	push   %ebp
80104fa1:	89 e5                	mov    %esp,%ebp
80104fa3:	83 ec 08             	sub    $0x8,%esp
80104fa6:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104fa9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80104fac:	89 75 fc             	mov    %esi,-0x4(%ebp)

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
80104faf:	8b 11                	mov    (%ecx),%edx
	append(link);
	return true;
}

Proc* LinkedList::dequeue() {
	if(isEmpty())
80104fb1:	85 d2                	test   %edx,%edx
80104fb3:	74 43                	je     80104ff8 <_ZN10LinkedList7dequeueEv+0x58>
		return null;

	Proc *p = first->p;
	Link *next = first->next;
80104fb5:	8b 5a 04             	mov    0x4(%edx),%ebx
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80104fb8:	8b 35 08 c6 10 80    	mov    0x8010c608,%esi

Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;

	Proc *p = first->p;
80104fbe:	8b 02                	mov    (%edx),%eax
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
	freeLinks = link;
80104fc0:	89 15 08 c6 10 80    	mov    %edx,0x8010c608
	
	deallocLink(first);
	
	first = next;

	if(isEmpty())
80104fc6:	85 db                	test   %ebx,%ebx
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80104fc8:	89 72 04             	mov    %esi,0x4(%edx)
	Proc *p = first->p;
	Link *next = first->next;
	
	deallocLink(first);
	
	first = next;
80104fcb:	89 19                	mov    %ebx,(%ecx)

	if(isEmpty())
80104fcd:	74 11                	je     80104fe0 <_ZN10LinkedList7dequeueEv+0x40>
		last = null;
	
	return p;
}
80104fcf:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104fd2:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104fd5:	89 ec                	mov    %ebp,%esp
80104fd7:	5d                   	pop    %ebp
80104fd8:	c3                   	ret    
80104fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	deallocLink(first);
	
	first = next;

	if(isEmpty())
		last = null;
80104fe0:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
	
	return p;
}
80104fe7:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104fea:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104fed:	89 ec                	mov    %ebp,%esp
80104fef:	5d                   	pop    %ebp
80104ff0:	c3                   	ret    
80104ff1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	return true;
}

Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;
80104ff8:	31 c0                	xor    %eax,%eax
80104ffa:	eb d3                	jmp    80104fcf <_ZN10LinkedList7dequeueEv+0x2f>
80104ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105000 <_ZN10LinkedList6removeEP4proc>:
		last = null;
	
	return p;
}

bool LinkedList::remove(Proc *p) {
80105000:	55                   	push   %ebp
80105001:	89 e5                	mov    %esp,%ebp
80105003:	56                   	push   %esi
80105004:	8b 75 08             	mov    0x8(%ebp),%esi
80105007:	53                   	push   %ebx
80105008:	8b 4d 0c             	mov    0xc(%ebp),%ecx

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
8010500b:	8b 1e                	mov    (%esi),%ebx
	
	return p;
}

bool LinkedList::remove(Proc *p) {
	if(isEmpty())
8010500d:	85 db                	test   %ebx,%ebx
8010500f:	74 57                	je     80105068 <_ZN10LinkedList6removeEP4proc+0x68>
		return false;
	
	if(first->p == p) {
80105011:	39 0b                	cmp    %ecx,(%ebx)
Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;

	Proc *p = first->p;
	Link *next = first->next;
80105013:	8b 53 04             	mov    0x4(%ebx),%edx

bool LinkedList::remove(Proc *p) {
	if(isEmpty())
		return false;
	
	if(first->p == p) {
80105016:	74 58                	je     80105070 <_ZN10LinkedList6removeEP4proc+0x70>
		return true;
	}

	Link *prev = first;
	Link *cur = first->next;
	while(cur) {
80105018:	85 d2                	test   %edx,%edx
8010501a:	74 4c                	je     80105068 <_ZN10LinkedList6removeEP4proc+0x68>
		if(cur->p == p) {
8010501c:	3b 0a                	cmp    (%edx),%ecx
8010501e:	66 90                	xchg   %ax,%ax
80105020:	75 0c                	jne    8010502e <_ZN10LinkedList6removeEP4proc+0x2e>
80105022:	eb 15                	jmp    80105039 <_ZN10LinkedList6removeEP4proc+0x39>
80105024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105028:	3b 08                	cmp    (%eax),%ecx
8010502a:	74 14                	je     80105040 <_ZN10LinkedList6removeEP4proc+0x40>
8010502c:	89 c2                	mov    %eax,%edx

			return true;
		}

		prev = cur;
		cur = cur->next;
8010502e:	8b 42 04             	mov    0x4(%edx),%eax
		return true;
	}

	Link *prev = first;
	Link *cur = first->next;
	while(cur) {
80105031:	85 c0                	test   %eax,%eax
80105033:	75 f3                	jne    80105028 <_ZN10LinkedList6removeEP4proc+0x28>
		cur = cur->next;
	}

	//didn't find the process
	return false;
}
80105035:	5b                   	pop    %ebx
80105036:	5e                   	pop    %esi
80105037:	5d                   	pop    %ebp
80105038:	c3                   	ret    
	}

	Link *prev = first;
	Link *cur = first->next;
	while(cur) {
		if(cur->p == p) {
80105039:	89 d0                	mov    %edx,%eax
8010503b:	89 da                	mov    %ebx,%edx
8010503d:	8d 76 00             	lea    0x0(%esi),%esi
			prev->next = cur->next;
80105040:	8b 48 04             	mov    0x4(%eax),%ecx
80105043:	89 4a 04             	mov    %ecx,0x4(%edx)
			
			if(!(cur->next)) //removes the last link
80105046:	8b 48 04             	mov    0x4(%eax),%ecx
80105049:	85 c9                	test   %ecx,%ecx
8010504b:	74 43                	je     80105090 <_ZN10LinkedList6removeEP4proc+0x90>
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
8010504d:	8b 15 08 c6 10 80    	mov    0x8010c608,%edx
	freeLinks = link;
80105053:	a3 08 c6 10 80       	mov    %eax,0x8010c608
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80105058:	89 50 04             	mov    %edx,0x4(%eax)
			if(!(cur->next)) //removes the last link
				last = prev;

			deallocLink(cur);

			return true;
8010505b:	b0 01                	mov    $0x1,%al
		cur = cur->next;
	}

	//didn't find the process
	return false;
}
8010505d:	5b                   	pop    %ebx
8010505e:	5e                   	pop    %esi
8010505f:	5d                   	pop    %ebp
80105060:	c3                   	ret    
80105061:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105068:	5b                   	pop    %ebx
	return p;
}

bool LinkedList::remove(Proc *p) {
	if(isEmpty())
		return false;
80105069:	31 c0                	xor    %eax,%eax
		cur = cur->next;
	}

	//didn't find the process
	return false;
}
8010506b:	5e                   	pop    %esi
8010506c:	5d                   	pop    %ebp
8010506d:	c3                   	ret    
8010506e:	66 90                	xchg   %ax,%ax
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80105070:	a1 08 c6 10 80       	mov    0x8010c608,%eax
	
	deallocLink(first);
	
	first = next;

	if(isEmpty())
80105075:	85 d2                	test   %edx,%edx
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
	freeLinks = link;
80105077:	89 1d 08 c6 10 80    	mov    %ebx,0x8010c608
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
8010507d:	89 43 04             	mov    %eax,0x4(%ebx)
	if(isEmpty())
		return false;
	
	if(first->p == p) {
		dequeue();
		return true;
80105080:	b0 01                	mov    $0x1,%al
	Proc *p = first->p;
	Link *next = first->next;
	
	deallocLink(first);
	
	first = next;
80105082:	89 16                	mov    %edx,(%esi)

	if(isEmpty())
80105084:	75 af                	jne    80105035 <_ZN10LinkedList6removeEP4proc+0x35>
		last = null;
80105086:	c7 46 04 00 00 00 00 	movl   $0x0,0x4(%esi)
8010508d:	eb a6                	jmp    80105035 <_ZN10LinkedList6removeEP4proc+0x35>
8010508f:	90                   	nop
	while(cur) {
		if(cur->p == p) {
			prev->next = cur->next;
			
			if(!(cur->next)) //removes the last link
				last = prev;
80105090:	89 56 04             	mov    %edx,0x4(%esi)
80105093:	eb b8                	jmp    8010504d <_ZN10LinkedList6removeEP4proc+0x4d>
80105095:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801050a0 <removeRunningProcessHolder>:

static boolean addRunningProcessHolder(Proc* p) {
	return runningProcHolder->enqueue(p);
}

static boolean removeRunningProcessHolder(Proc* p) {
801050a0:	55                   	push   %ebp
801050a1:	89 e5                	mov    %esp,%ebp
801050a3:	83 ec 08             	sub    $0x8,%esp
	return runningProcHolder->remove(p);
801050a6:	8b 45 08             	mov    0x8(%ebp),%eax
801050a9:	89 44 24 04          	mov    %eax,0x4(%esp)
801050ad:	a1 0c c6 10 80       	mov    0x8010c60c,%eax
801050b2:	89 04 24             	mov    %eax,(%esp)
801050b5:	e8 46 ff ff ff       	call   80105000 <_ZN10LinkedList6removeEP4proc>
}
801050ba:	c9                   	leave  
static boolean addRunningProcessHolder(Proc* p) {
	return runningProcHolder->enqueue(p);
}

static boolean removeRunningProcessHolder(Proc* p) {
	return runningProcHolder->remove(p);
801050bb:	0f b6 c0             	movzbl %al,%eax
}
801050be:	c3                   	ret    
801050bf:	90                   	nop

801050c0 <_ZN10LinkedList8transferEv>:
	//didn't find the process
	return false;
}

bool LinkedList::transfer() {
	if(!priorityQ->isEmpty())
801050c0:	8b 15 14 c6 10 80    	mov    0x8010c614,%edx
		return false;
801050c6:	31 c0                	xor    %eax,%eax

	//didn't find the process
	return false;
}

bool LinkedList::transfer() {
801050c8:	55                   	push   %ebp
801050c9:	89 e5                	mov    %esp,%ebp
801050cb:	53                   	push   %ebx
801050cc:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!priorityQ->isEmpty())
801050cf:	8b 1a                	mov    (%edx),%ebx
801050d1:	85 db                	test   %ebx,%ebx
801050d3:	74 0b                	je     801050e0 <_ZN10LinkedList8transferEv+0x20>
		node->listOfProcs.last = last;
		first = last = null;
		priorityQ->root = node;
	}
	return true;
}
801050d5:	5b                   	pop    %ebx
801050d6:	5d                   	pop    %ebp
801050d7:	c3                   	ret    
801050d8:	90                   	nop
801050d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

bool LinkedList::transfer() {
	if(!priorityQ->isEmpty())
		return false;
	
	if(!isEmpty()) {
801050e0:	8b 19                	mov    (%ecx),%ebx
801050e2:	85 db                	test   %ebx,%ebx
801050e4:	74 4a                	je     80105130 <_ZN10LinkedList8transferEv+0x70>
	node->next = freeNodes;
	freeNodes = node;
}

static MapNode* allocNode(long long key) {
	if(!freeNodes)
801050e6:	8b 1d 04 c6 10 80    	mov    0x8010c604,%ebx
801050ec:	85 db                	test   %ebx,%ebx
801050ee:	74 e5                	je     801050d5 <_ZN10LinkedList8transferEv+0x15>
		return null;

	MapNode *ans = freeNodes;
	freeNodes = freeNodes->next;
801050f0:	8b 43 10             	mov    0x10(%ebx),%eax
	ans->next = null;
	ans->key = key;
801050f3:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
	if(!freeNodes)
		return null;

	MapNode *ans = freeNodes;
	freeNodes = freeNodes->next;
	ans->next = null;
801050f9:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
	ans->key = key;
80105100:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
static MapNode* allocNode(long long key) {
	if(!freeNodes)
		return null;

	MapNode *ans = freeNodes;
	freeNodes = freeNodes->next;
80105107:	a3 04 c6 10 80       	mov    %eax,0x8010c604
	if(!isEmpty()) {
		MapNode *node = allocNode(0);
		if(!node)
			return false;
		
		node->listOfProcs.first = first;
8010510c:	8b 01                	mov    (%ecx),%eax
8010510e:	89 43 08             	mov    %eax,0x8(%ebx)
		node->listOfProcs.last = last;
80105111:	8b 41 04             	mov    0x4(%ecx),%eax
80105114:	89 43 0c             	mov    %eax,0xc(%ebx)
		first = last = null;
		priorityQ->root = node;
	}
	return true;
80105117:	b0 01                	mov    $0x1,%al
		if(!node)
			return false;
		
		node->listOfProcs.first = first;
		node->listOfProcs.last = last;
		first = last = null;
80105119:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
80105120:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
		priorityQ->root = node;
80105126:	89 1a                	mov    %ebx,(%edx)
	}
	return true;
}
80105128:	5b                   	pop    %ebx
80105129:	5d                   	pop    %ebp
8010512a:	c3                   	ret    
8010512b:	90                   	nop
8010512c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		node->listOfProcs.first = first;
		node->listOfProcs.last = last;
		first = last = null;
		priorityQ->root = node;
	}
	return true;
80105130:	b0 01                	mov    $0x1,%al
80105132:	eb a1                	jmp    801050d5 <_ZN10LinkedList8transferEv+0x15>
80105134:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010513a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105140 <switchToPriorityQueuePolicyRoundRobinQueue>:

static Proc* dequeueRoundRobinQueue() {
	return roundRobinQ->dequeue();
}

static boolean switchToPriorityQueuePolicyRoundRobinQueue() {
80105140:	55                   	push   %ebp
80105141:	89 e5                	mov    %esp,%ebp
80105143:	83 ec 04             	sub    $0x4,%esp
	return roundRobinQ->transfer();
80105146:	a1 10 c6 10 80       	mov    0x8010c610,%eax
8010514b:	89 04 24             	mov    %eax,(%esp)
8010514e:	e8 6d ff ff ff       	call   801050c0 <_ZN10LinkedList8transferEv>
}
80105153:	c9                   	leave  
static Proc* dequeueRoundRobinQueue() {
	return roundRobinQ->dequeue();
}

static boolean switchToPriorityQueuePolicyRoundRobinQueue() {
	return roundRobinQ->transfer();
80105154:	0f b6 c0             	movzbl %al,%eax
}
80105157:	c3                   	ret    
80105158:	90                   	nop
80105159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105160 <_ZN10LinkedList9getMinKeyEPx>:
		priorityQ->root = node;
	}
	return true;
}

bool LinkedList::getMinKey(long long *pkey) {
80105160:	55                   	push   %ebp
80105161:	89 e5                	mov    %esp,%ebp
80105163:	57                   	push   %edi
80105164:	56                   	push   %esi
80105165:	53                   	push   %ebx
80105166:	83 ec 1c             	sub    $0x1c,%esp
80105169:	8b 7d 08             	mov    0x8(%ebp),%edi

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
8010516c:	8b 07                	mov    (%edi),%eax
	}
	return true;
}

bool LinkedList::getMinKey(long long *pkey) {
	if(isEmpty())
8010516e:	85 c0                	test   %eax,%eax
80105170:	74 56                	je     801051c8 <_ZN10LinkedList9getMinKeyEPx+0x68>
		return false;

	long long minKey = getAccumulator(first->p);
80105172:	8b 00                	mov    (%eax),%eax
80105174:	89 04 24             	mov    %eax,(%esp)
80105177:	e8 64 e6 ff ff       	call   801037e0 <getAccumulator>
8010517c:	8b 3f                	mov    (%edi),%edi
	void append(Link *link); //appends the given list to the queue. No allocations always succeeds.
	
	template<typename Func>
	void forEach(const Func& accept) { //for-each loop. gets a function that applies the procin each link node.
		Link *link = first;
		while(link) {
8010517e:	85 ff                	test   %edi,%edi
80105180:	89 c6                	mov    %eax,%esi
80105182:	89 d3                	mov    %edx,%ebx
80105184:	74 29                	je     801051af <_ZN10LinkedList9getMinKeyEPx+0x4f>
80105186:	8d 76 00             	lea    0x0(%esi),%esi
80105189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	
	forEach([&](Proc *p) {
		long long key = getAccumulator(p);
80105190:	8b 07                	mov    (%edi),%eax
80105192:	89 04 24             	mov    %eax,(%esp)
80105195:	e8 46 e6 ff ff       	call   801037e0 <getAccumulator>
8010519a:	39 d3                	cmp    %edx,%ebx
8010519c:	7c 0a                	jl     801051a8 <_ZN10LinkedList9getMinKeyEPx+0x48>
8010519e:	7f 04                	jg     801051a4 <_ZN10LinkedList9getMinKeyEPx+0x44>
801051a0:	39 c6                	cmp    %eax,%esi
801051a2:	76 04                	jbe    801051a8 <_ZN10LinkedList9getMinKeyEPx+0x48>
801051a4:	89 c6                	mov    %eax,%esi
801051a6:	89 d3                	mov    %edx,%ebx
			accept(link->p);
			link = link->next;
801051a8:	8b 7f 04             	mov    0x4(%edi),%edi
	void append(Link *link); //appends the given list to the queue. No allocations always succeeds.
	
	template<typename Func>
	void forEach(const Func& accept) { //for-each loop. gets a function that applies the procin each link node.
		Link *link = first;
		while(link) {
801051ab:	85 ff                	test   %edi,%edi
801051ad:	75 e1                	jne    80105190 <_ZN10LinkedList9getMinKeyEPx+0x30>
		if(key < minKey)
			minKey = key;
	});

	*pkey = minKey;
801051af:	8b 45 0c             	mov    0xc(%ebp),%eax
801051b2:	89 30                	mov    %esi,(%eax)
801051b4:	89 58 04             	mov    %ebx,0x4(%eax)
	
	return true;
}
801051b7:	83 c4 1c             	add    $0x1c,%esp
			minKey = key;
	});

	*pkey = minKey;
	
	return true;
801051ba:	b0 01                	mov    $0x1,%al
}
801051bc:	5b                   	pop    %ebx
801051bd:	5e                   	pop    %esi
801051be:	5f                   	pop    %edi
801051bf:	5d                   	pop    %ebp
801051c0:	c3                   	ret    
801051c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051c8:	83 c4 1c             	add    $0x1c,%esp
	return true;
}

bool LinkedList::getMinKey(long long *pkey) {
	if(isEmpty())
		return false;
801051cb:	31 c0                	xor    %eax,%eax
	});

	*pkey = minKey;
	
	return true;
}
801051cd:	5b                   	pop    %ebx
801051ce:	5e                   	pop    %esi
801051cf:	5f                   	pop    %edi
801051d0:	5d                   	pop    %ebp
801051d1:	c3                   	ret    
801051d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801051e0 <getMinAccumulatorRunningProcessHolder>:

static boolean removeRunningProcessHolder(Proc* p) {
	return runningProcHolder->remove(p);
}

static boolean getMinAccumulatorRunningProcessHolder(long long *pkey) {
801051e0:	55                   	push   %ebp
801051e1:	89 e5                	mov    %esp,%ebp
801051e3:	83 ec 18             	sub    $0x18,%esp
	return runningProcHolder->getMinKey(pkey);
801051e6:	8b 45 08             	mov    0x8(%ebp),%eax
801051e9:	89 44 24 04          	mov    %eax,0x4(%esp)
801051ed:	a1 0c c6 10 80       	mov    0x8010c60c,%eax
801051f2:	89 04 24             	mov    %eax,(%esp)
801051f5:	e8 66 ff ff ff       	call   80105160 <_ZN10LinkedList9getMinKeyEPx>
}
801051fa:	c9                   	leave  
static boolean removeRunningProcessHolder(Proc* p) {
	return runningProcHolder->remove(p);
}

static boolean getMinAccumulatorRunningProcessHolder(long long *pkey) {
	return runningProcHolder->getMinKey(pkey);
801051fb:	0f b6 c0             	movzbl %al,%eax
}
801051fe:	c3                   	ret    
801051ff:	90                   	nop

80105200 <_ZN7MapNode7isEmptyEv>:
	*pkey = minKey;
	
	return true;
}

bool MapNode::isEmpty() {
80105200:	55                   	push   %ebp
80105201:	89 e5                	mov    %esp,%ebp
	return listOfProcs.isEmpty();
80105203:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105206:	5d                   	pop    %ebp
	
	return true;
}

bool MapNode::isEmpty() {
	return listOfProcs.isEmpty();
80105207:	8b 40 08             	mov    0x8(%eax),%eax
8010520a:	85 c0                	test   %eax,%eax
8010520c:	0f 94 c0             	sete   %al
}
8010520f:	c3                   	ret    

80105210 <_ZN7MapNode3putEP4proc>:

bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
80105210:	55                   	push   %ebp
80105211:	89 e5                	mov    %esp,%ebp
80105213:	57                   	push   %edi
80105214:	56                   	push   %esi
80105215:	53                   	push   %ebx
80105216:	83 ec 2c             	sub    $0x2c,%esp
80105219:	8b 45 0c             	mov    0xc(%ebp),%eax
8010521c:	8b 5d 08             	mov    0x8(%ebp),%ebx
	MapNode *node = this;
	long long key = getAccumulator(p);
8010521f:	89 04 24             	mov    %eax,(%esp)

bool MapNode::isEmpty() {
	return listOfProcs.isEmpty();
}

bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
80105222:	89 45 e0             	mov    %eax,-0x20(%ebp)
	MapNode *node = this;
	long long key = getAccumulator(p);
80105225:	e8 b6 e5 ff ff       	call   801037e0 <getAccumulator>
8010522a:	89 c6                	mov    %eax,%esi
8010522c:	89 d1                	mov    %edx,%ecx
8010522e:	66 90                	xchg   %ax,%ax
	for(;;) {
		if(key == node->key)
80105230:	8b 43 04             	mov    0x4(%ebx),%eax
80105233:	89 cf                	mov    %ecx,%edi
80105235:	8b 13                	mov    (%ebx),%edx
80105237:	31 c7                	xor    %eax,%edi
80105239:	89 7d e4             	mov    %edi,-0x1c(%ebp)
8010523c:	89 f7                	mov    %esi,%edi
8010523e:	31 d7                	xor    %edx,%edi
80105240:	0b 7d e4             	or     -0x1c(%ebp),%edi
80105243:	74 43                	je     80105288 <_ZN7MapNode3putEP4proc+0x78>
			return node->listOfProcs.enqueue(p);
		else if(key < node->key) { //left
80105245:	39 c1                	cmp    %eax,%ecx
80105247:	7f 17                	jg     80105260 <_ZN7MapNode3putEP4proc+0x50>
80105249:	7c 07                	jl     80105252 <_ZN7MapNode3putEP4proc+0x42>
8010524b:	39 d6                	cmp    %edx,%esi
8010524d:	8d 76 00             	lea    0x0(%esi),%esi
80105250:	73 0e                	jae    80105260 <_ZN7MapNode3putEP4proc+0x50>
			if(node->left)
80105252:	8b 43 18             	mov    0x18(%ebx),%eax
80105255:	85 c0                	test   %eax,%eax
80105257:	74 47                	je     801052a0 <_ZN7MapNode3putEP4proc+0x90>
80105259:	89 c3                	mov    %eax,%ebx
8010525b:	eb d3                	jmp    80105230 <_ZN7MapNode3putEP4proc+0x20>
8010525d:	8d 76 00             	lea    0x0(%esi),%esi
					return true;
				}
				return false;
			}
		} else { //right
			if(node->right)
80105260:	8b 43 1c             	mov    0x1c(%ebx),%eax
80105263:	85 c0                	test   %eax,%eax
80105265:	75 f2                	jne    80105259 <_ZN7MapNode3putEP4proc+0x49>
				node = node->right;
			else {
				node->right = allocNode(p, key);
80105267:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010526a:	89 f2                	mov    %esi,%edx
8010526c:	e8 bf fc ff ff       	call   80104f30 <_ZL9allocNodeP4procx>
				if(node->right) {
80105271:	85 c0                	test   %eax,%eax
			}
		} else { //right
			if(node->right)
				node = node->right;
			else {
				node->right = allocNode(p, key);
80105273:	89 43 1c             	mov    %eax,0x1c(%ebx)
				if(node->right) {
80105276:	74 39                	je     801052b1 <_ZN7MapNode3putEP4proc+0xa1>
					node->right->parent = node;
80105278:	89 58 14             	mov    %ebx,0x14(%eax)
					return true;
8010527b:	b0 01                	mov    $0x1,%al
				}
				return false;
			}
		}
	}
}
8010527d:	83 c4 2c             	add    $0x2c,%esp
80105280:	5b                   	pop    %ebx
80105281:	5e                   	pop    %esi
80105282:	5f                   	pop    %edi
80105283:	5d                   	pop    %ebp
80105284:	c3                   	ret    
80105285:	8d 76 00             	lea    0x0(%esi),%esi
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
	MapNode *node = this;
	long long key = getAccumulator(p);
	for(;;) {
		if(key == node->key)
			return node->listOfProcs.enqueue(p);
80105288:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010528b:	83 c3 08             	add    $0x8,%ebx
8010528e:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105291:	89 45 0c             	mov    %eax,0xc(%ebp)
				}
				return false;
			}
		}
	}
}
80105294:	83 c4 2c             	add    $0x2c,%esp
80105297:	5b                   	pop    %ebx
80105298:	5e                   	pop    %esi
80105299:	5f                   	pop    %edi
8010529a:	5d                   	pop    %ebp
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
	MapNode *node = this;
	long long key = getAccumulator(p);
	for(;;) {
		if(key == node->key)
			return node->listOfProcs.enqueue(p);
8010529b:	e9 f0 fb ff ff       	jmp    80104e90 <_ZN10LinkedList7enqueueEP4proc>
		else if(key < node->key) { //left
			if(node->left)
				node = node->left;
			else {
				node->left = allocNode(p, key);
801052a0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801052a3:	89 f2                	mov    %esi,%edx
801052a5:	e8 86 fc ff ff       	call   80104f30 <_ZL9allocNodeP4procx>
				if(node->left) {
801052aa:	85 c0                	test   %eax,%eax
			return node->listOfProcs.enqueue(p);
		else if(key < node->key) { //left
			if(node->left)
				node = node->left;
			else {
				node->left = allocNode(p, key);
801052ac:	89 43 18             	mov    %eax,0x18(%ebx)
				if(node->left) {
801052af:	75 c7                	jne    80105278 <_ZN7MapNode3putEP4proc+0x68>
					node->left->parent = node;
					return true;
				}
				return false;
801052b1:	31 c0                	xor    %eax,%eax
801052b3:	eb c8                	jmp    8010527d <_ZN7MapNode3putEP4proc+0x6d>
801052b5:	90                   	nop
801052b6:	8d 76 00             	lea    0x0(%esi),%esi
801052b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801052c0 <_ZN7MapNode10getMinNodeEv>:
			}
		}
	}
}

MapNode* MapNode::getMinNode() { //no recursion.
801052c0:	55                   	push   %ebp
801052c1:	89 e5                	mov    %esp,%ebp
	MapNode* minNode = this;	
801052c3:	8b 45 08             	mov    0x8(%ebp),%eax
801052c6:	eb 0a                	jmp    801052d2 <_ZN7MapNode10getMinNodeEv+0x12>
801052c8:	90                   	nop
801052c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052d0:	89 d0                	mov    %edx,%eax
	while(minNode->left)
801052d2:	8b 50 18             	mov    0x18(%eax),%edx
801052d5:	85 d2                	test   %edx,%edx
801052d7:	75 f7                	jne    801052d0 <_ZN7MapNode10getMinNodeEv+0x10>
		minNode = minNode->left;

	return minNode;
}
801052d9:	5d                   	pop    %ebp
801052da:	c3                   	ret    
801052db:	90                   	nop
801052dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801052e0 <_ZN7MapNode9getMinKeyEPx>:

void MapNode::getMinKey(long long *pkey) {
801052e0:	55                   	push   %ebp
801052e1:	89 e5                	mov    %esp,%ebp
		}
	}
}

MapNode* MapNode::getMinNode() { //no recursion.
	MapNode* minNode = this;	
801052e3:	8b 55 08             	mov    0x8(%ebp),%edx
		minNode = minNode->left;

	return minNode;
}

void MapNode::getMinKey(long long *pkey) {
801052e6:	53                   	push   %ebx
801052e7:	eb 09                	jmp    801052f2 <_ZN7MapNode9getMinKeyEPx+0x12>
801052e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	}
}

MapNode* MapNode::getMinNode() { //no recursion.
	MapNode* minNode = this;	
	while(minNode->left)
801052f0:	89 c2                	mov    %eax,%edx
801052f2:	8b 42 18             	mov    0x18(%edx),%eax
801052f5:	85 c0                	test   %eax,%eax
801052f7:	75 f7                	jne    801052f0 <_ZN7MapNode9getMinKeyEPx+0x10>

	return minNode;
}

void MapNode::getMinKey(long long *pkey) {
	*pkey = getMinNode()->key;
801052f9:	8b 5a 04             	mov    0x4(%edx),%ebx
801052fc:	8b 45 0c             	mov    0xc(%ebp),%eax
801052ff:	8b 0a                	mov    (%edx),%ecx
80105301:	89 58 04             	mov    %ebx,0x4(%eax)
80105304:	89 08                	mov    %ecx,(%eax)
}
80105306:	5b                   	pop    %ebx
80105307:	5d                   	pop    %ebp
80105308:	c3                   	ret    
80105309:	90                   	nop
8010530a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105310 <_ZN7MapNode7dequeueEv>:

Proc* MapNode::dequeue() {
80105310:	55                   	push   %ebp
80105311:	89 e5                	mov    %esp,%ebp
80105313:	83 ec 08             	sub    $0x8,%esp
80105316:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105319:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010531c:	89 75 fc             	mov    %esi,-0x4(%ebp)

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
8010531f:	8b 51 08             	mov    0x8(%ecx),%edx
	append(link);
	return true;
}

Proc* LinkedList::dequeue() {
	if(isEmpty())
80105322:	85 d2                	test   %edx,%edx
80105324:	74 42                	je     80105368 <_ZN7MapNode7dequeueEv+0x58>
		return null;

	Proc *p = first->p;
	Link *next = first->next;
80105326:	8b 5a 04             	mov    0x4(%edx),%ebx
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80105329:	8b 35 08 c6 10 80    	mov    0x8010c608,%esi

Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;

	Proc *p = first->p;
8010532f:	8b 02                	mov    (%edx),%eax
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
	freeLinks = link;
80105331:	89 15 08 c6 10 80    	mov    %edx,0x8010c608
	
	deallocLink(first);
	
	first = next;

	if(isEmpty())
80105337:	85 db                	test   %ebx,%ebx
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80105339:	89 72 04             	mov    %esi,0x4(%edx)
	Proc *p = first->p;
	Link *next = first->next;
	
	deallocLink(first);
	
	first = next;
8010533c:	89 59 08             	mov    %ebx,0x8(%ecx)

	if(isEmpty())
8010533f:	74 0f                	je     80105350 <_ZN7MapNode7dequeueEv+0x40>
	*pkey = getMinNode()->key;
}

Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}
80105341:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105344:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105347:	89 ec                	mov    %ebp,%esp
80105349:	5d                   	pop    %ebp
8010534a:	c3                   	ret    
8010534b:	90                   	nop
8010534c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	deallocLink(first);
	
	first = next;

	if(isEmpty())
		last = null;
80105350:	c7 41 0c 00 00 00 00 	movl   $0x0,0xc(%ecx)
	*pkey = getMinNode()->key;
}

Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}
80105357:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010535a:	8b 75 fc             	mov    -0x4(%ebp),%esi
8010535d:	89 ec                	mov    %ebp,%esp
8010535f:	5d                   	pop    %ebp
80105360:	c3                   	ret    
80105361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	return true;
}

Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;
80105368:	31 c0                	xor    %eax,%eax
8010536a:	eb d5                	jmp    80105341 <_ZN7MapNode7dequeueEv+0x31>
8010536c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105370 <_ZN3Map7isEmptyEv>:

Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
80105370:	55                   	push   %ebp
80105371:	89 e5                	mov    %esp,%ebp
	return !root;
80105373:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105376:	5d                   	pop    %ebp
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
80105377:	8b 00                	mov    (%eax),%eax
80105379:	85 c0                	test   %eax,%eax
8010537b:	0f 94 c0             	sete   %al
}
8010537e:	c3                   	ret    
8010537f:	90                   	nop

80105380 <_ZN3Map3putEP4proc>:

bool Map::put(Proc *p) {
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	83 ec 18             	sub    $0x18,%esp
80105386:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105389:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010538c:	89 75 fc             	mov    %esi,-0x4(%ebp)
8010538f:	8b 75 08             	mov    0x8(%ebp),%esi
	long long key = getAccumulator(p);
80105392:	89 1c 24             	mov    %ebx,(%esp)
80105395:	e8 46 e4 ff ff       	call   801037e0 <getAccumulator>
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
8010539a:	8b 0e                	mov    (%esi),%ecx
}

bool Map::put(Proc *p) {
	long long key = getAccumulator(p);
	if(isEmpty()) {
8010539c:	85 c9                	test   %ecx,%ecx
8010539e:	74 18                	je     801053b8 <_ZN3Map3putEP4proc+0x38>
		root = allocNode(p, key);
		return !isEmpty();
	}
	
	return root->put(p);
801053a0:	89 5d 0c             	mov    %ebx,0xc(%ebp)
}
801053a3:	8b 75 fc             	mov    -0x4(%ebp),%esi
	if(isEmpty()) {
		root = allocNode(p, key);
		return !isEmpty();
	}
	
	return root->put(p);
801053a6:	89 4d 08             	mov    %ecx,0x8(%ebp)
}
801053a9:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801053ac:	89 ec                	mov    %ebp,%esp
801053ae:	5d                   	pop    %ebp
	if(isEmpty()) {
		root = allocNode(p, key);
		return !isEmpty();
	}
	
	return root->put(p);
801053af:	e9 5c fe ff ff       	jmp    80105210 <_ZN7MapNode3putEP4proc>
801053b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

bool Map::put(Proc *p) {
	long long key = getAccumulator(p);
	if(isEmpty()) {
		root = allocNode(p, key);
801053b8:	89 d1                	mov    %edx,%ecx
801053ba:	89 c2                	mov    %eax,%edx
801053bc:	89 d8                	mov    %ebx,%eax
801053be:	e8 6d fb ff ff       	call   80104f30 <_ZL9allocNodeP4procx>
801053c3:	89 06                	mov    %eax,(%esi)
		return !isEmpty();
801053c5:	85 c0                	test   %eax,%eax
801053c7:	0f 95 c0             	setne  %al
	}
	
	return root->put(p);
}
801053ca:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801053cd:	8b 75 fc             	mov    -0x4(%ebp),%esi
801053d0:	89 ec                	mov    %ebp,%esp
801053d2:	5d                   	pop    %ebp
801053d3:	c3                   	ret    
801053d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801053da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801053e0 <putPriorityQueue>:
//for pq
static boolean isEmptyPriorityQueue() {
	return priorityQ->isEmpty();
}

static boolean putPriorityQueue(Proc* p) {
801053e0:	55                   	push   %ebp
801053e1:	89 e5                	mov    %esp,%ebp
801053e3:	83 ec 18             	sub    $0x18,%esp
	return priorityQ->put(p);
801053e6:	8b 45 08             	mov    0x8(%ebp),%eax
801053e9:	89 44 24 04          	mov    %eax,0x4(%esp)
801053ed:	a1 14 c6 10 80       	mov    0x8010c614,%eax
801053f2:	89 04 24             	mov    %eax,(%esp)
801053f5:	e8 86 ff ff ff       	call   80105380 <_ZN3Map3putEP4proc>
}
801053fa:	c9                   	leave  
static boolean isEmptyPriorityQueue() {
	return priorityQ->isEmpty();
}

static boolean putPriorityQueue(Proc* p) {
	return priorityQ->put(p);
801053fb:	0f b6 c0             	movzbl %al,%eax
}
801053fe:	c3                   	ret    
801053ff:	90                   	nop

80105400 <_ZN3Map9getMinKeyEPx>:
	}
	
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
80105400:	55                   	push   %ebp
80105401:	89 e5                	mov    %esp,%ebp
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
80105403:	8b 45 08             	mov    0x8(%ebp),%eax
	}
	
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
80105406:	53                   	push   %ebx
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
80105407:	8b 10                	mov    (%eax),%edx
	
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
	if(isEmpty())
80105409:	85 d2                	test   %edx,%edx
8010540b:	75 05                	jne    80105412 <_ZN3Map9getMinKeyEPx+0x12>
8010540d:	eb 21                	jmp    80105430 <_ZN3Map9getMinKeyEPx+0x30>
8010540f:	90                   	nop
	}
}

MapNode* MapNode::getMinNode() { //no recursion.
	MapNode* minNode = this;	
	while(minNode->left)
80105410:	89 c2                	mov    %eax,%edx
80105412:	8b 42 18             	mov    0x18(%edx),%eax
80105415:	85 c0                	test   %eax,%eax
80105417:	75 f7                	jne    80105410 <_ZN3Map9getMinKeyEPx+0x10>

	return minNode;
}

void MapNode::getMinKey(long long *pkey) {
	*pkey = getMinNode()->key;
80105419:	8b 45 0c             	mov    0xc(%ebp),%eax
8010541c:	8b 5a 04             	mov    0x4(%edx),%ebx
8010541f:	8b 0a                	mov    (%edx),%ecx
80105421:	89 58 04             	mov    %ebx,0x4(%eax)
80105424:	89 08                	mov    %ecx,(%eax)
bool Map::getMinKey(long long *pkey) {
	if(isEmpty())
		return false;

	root->getMinKey(pkey);
	return true;
80105426:	b0 01                	mov    $0x1,%al
}
80105428:	5b                   	pop    %ebx
80105429:	5d                   	pop    %ebp
8010542a:	c3                   	ret    
8010542b:	90                   	nop
8010542c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105430:	5b                   	pop    %ebx
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
	if(isEmpty())
		return false;
80105431:	31 c0                	xor    %eax,%eax

	root->getMinKey(pkey);
	return true;
}
80105433:	5d                   	pop    %ebp
80105434:	c3                   	ret    
80105435:	90                   	nop
80105436:	8d 76 00             	lea    0x0(%esi),%esi
80105439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105440 <_ZN3Map10extractMinEv>:

Proc* Map::extractMin() {
80105440:	55                   	push   %ebp
80105441:	89 e5                	mov    %esp,%ebp
80105443:	57                   	push   %edi
80105444:	56                   	push   %esi
80105445:	8b 75 08             	mov    0x8(%ebp),%esi
80105448:	53                   	push   %ebx
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
80105449:	8b 1e                	mov    (%esi),%ebx
	root->getMinKey(pkey);
	return true;
}

Proc* Map::extractMin() {
	if(isEmpty())
8010544b:	85 db                	test   %ebx,%ebx
8010544d:	0f 84 a2 00 00 00    	je     801054f5 <_ZN3Map10extractMinEv+0xb5>
80105453:	89 da                	mov    %ebx,%edx
80105455:	eb 0b                	jmp    80105462 <_ZN3Map10extractMinEv+0x22>
80105457:	89 f6                	mov    %esi,%esi
80105459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	}
}

MapNode* MapNode::getMinNode() { //no recursion.
	MapNode* minNode = this;	
	while(minNode->left)
80105460:	89 c2                	mov    %eax,%edx
80105462:	8b 42 18             	mov    0x18(%edx),%eax
80105465:	85 c0                	test   %eax,%eax
80105467:	75 f7                	jne    80105460 <_ZN3Map10extractMinEv+0x20>

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
80105469:	8b 4a 08             	mov    0x8(%edx),%ecx
	append(link);
	return true;
}

Proc* LinkedList::dequeue() {
	if(isEmpty())
8010546c:	85 c9                	test   %ecx,%ecx
8010546e:	74 20                	je     80105490 <_ZN3Map10extractMinEv+0x50>
		return null;

	Proc *p = first->p;
	Link *next = first->next;
80105470:	8b 59 04             	mov    0x4(%ecx),%ebx
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80105473:	8b 3d 08 c6 10 80    	mov    0x8010c608,%edi

Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;

	Proc *p = first->p;
80105479:	8b 01                	mov    (%ecx),%eax
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
	freeLinks = link;
8010547b:	89 0d 08 c6 10 80    	mov    %ecx,0x8010c608
	
	deallocLink(first);
	
	first = next;

	if(isEmpty())
80105481:	85 db                	test   %ebx,%ebx
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80105483:	89 79 04             	mov    %edi,0x4(%ecx)
	Proc *p = first->p;
	Link *next = first->next;
	
	deallocLink(first);
	
	first = next;
80105486:	89 5a 08             	mov    %ebx,0x8(%edx)

	if(isEmpty())
80105489:	74 4d                	je     801054d8 <_ZN3Map10extractMinEv+0x98>
		}
		deallocNode(minNode);
	}

	return p;
}
8010548b:	5b                   	pop    %ebx
8010548c:	5e                   	pop    %esi
8010548d:	5f                   	pop    %edi
8010548e:	5d                   	pop    %ebp
8010548f:	c3                   	ret    
	return true;
}

Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;
80105490:	31 c0                	xor    %eax,%eax
	MapNode *minNode = root->getMinNode();

	Proc *p = minNode->dequeue();
	
	if(minNode->isEmpty()) {
		if(minNode == root) {
80105492:	39 da                	cmp    %ebx,%edx
80105494:	74 4d                	je     801054e3 <_ZN3Map10extractMinEv+0xa3>
			root = minNode->right;
			if(!isEmpty())
				root->parent = null;
		} else {
			MapNode *parent = minNode->parent;
			parent->left = minNode->right;
80105496:	8b 4a 1c             	mov    0x1c(%edx),%ecx
		if(minNode == root) {
			root = minNode->right;
			if(!isEmpty())
				root->parent = null;
		} else {
			MapNode *parent = minNode->parent;
80105499:	8b 5a 14             	mov    0x14(%edx),%ebx
			parent->left = minNode->right;
8010549c:	89 4b 18             	mov    %ecx,0x18(%ebx)
			if(minNode->right)
8010549f:	8b 4a 1c             	mov    0x1c(%edx),%ecx
801054a2:	85 c9                	test   %ecx,%ecx
801054a4:	74 03                	je     801054a9 <_ZN3Map10extractMinEv+0x69>
				minNode->right->parent = parent;
801054a6:	89 59 14             	mov    %ebx,0x14(%ecx)
	freeLinks = link;
}

static void deallocNode(MapNode *node) {
	node->parent = node->left = node->right = null;
	node->next = freeNodes;
801054a9:	8b 0d 04 c6 10 80    	mov    0x8010c604,%ecx
	link->next = freeLinks;
	freeLinks = link;
}

static void deallocNode(MapNode *node) {
	node->parent = node->left = node->right = null;
801054af:	c7 42 1c 00 00 00 00 	movl   $0x0,0x1c(%edx)
801054b6:	c7 42 18 00 00 00 00 	movl   $0x0,0x18(%edx)
801054bd:	c7 42 14 00 00 00 00 	movl   $0x0,0x14(%edx)
	node->next = freeNodes;
801054c4:	89 4a 10             	mov    %ecx,0x10(%edx)
		}
		deallocNode(minNode);
	}

	return p;
}
801054c7:	5b                   	pop    %ebx
}

static void deallocNode(MapNode *node) {
	node->parent = node->left = node->right = null;
	node->next = freeNodes;
	freeNodes = node;
801054c8:	89 15 04 c6 10 80    	mov    %edx,0x8010c604
		}
		deallocNode(minNode);
	}

	return p;
}
801054ce:	5e                   	pop    %esi
801054cf:	5f                   	pop    %edi
801054d0:	5d                   	pop    %ebp
801054d1:	c3                   	ret    
801054d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	deallocLink(first);
	
	first = next;

	if(isEmpty())
		last = null;
801054d8:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
801054df:	8b 1e                	mov    (%esi),%ebx
801054e1:	eb af                	jmp    80105492 <_ZN3Map10extractMinEv+0x52>

	Proc *p = minNode->dequeue();
	
	if(minNode->isEmpty()) {
		if(minNode == root) {
			root = minNode->right;
801054e3:	8b 4a 1c             	mov    0x1c(%edx),%ecx
			if(!isEmpty())
801054e6:	85 c9                	test   %ecx,%ecx

	Proc *p = minNode->dequeue();
	
	if(minNode->isEmpty()) {
		if(minNode == root) {
			root = minNode->right;
801054e8:	89 0e                	mov    %ecx,(%esi)
			if(!isEmpty())
801054ea:	74 bd                	je     801054a9 <_ZN3Map10extractMinEv+0x69>
				root->parent = null;
801054ec:	c7 41 14 00 00 00 00 	movl   $0x0,0x14(%ecx)
801054f3:	eb b4                	jmp    801054a9 <_ZN3Map10extractMinEv+0x69>
	return true;
}

Proc* Map::extractMin() {
	if(isEmpty())
		return null;
801054f5:	31 c0                	xor    %eax,%eax
801054f7:	eb 92                	jmp    8010548b <_ZN3Map10extractMinEv+0x4b>
801054f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105500 <extractMinPriorityQueue>:

static boolean getMinAccumulatorPriorityQueue(long long* pkey) {
	return priorityQ->getMinKey(pkey);
}

static Proc* extractMinPriorityQueue() {
80105500:	55                   	push   %ebp
80105501:	89 e5                	mov    %esp,%ebp
80105503:	83 ec 04             	sub    $0x4,%esp
	return priorityQ->extractMin();
80105506:	a1 14 c6 10 80       	mov    0x8010c614,%eax
8010550b:	89 04 24             	mov    %eax,(%esp)
8010550e:	e8 2d ff ff ff       	call   80105440 <_ZN3Map10extractMinEv>
}
80105513:	c9                   	leave  
80105514:	c3                   	ret    
80105515:	90                   	nop
80105516:	8d 76 00             	lea    0x0(%esi),%esi
80105519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105520 <_ZN3Map8transferEv.part.1>:
	}

	return p;
}

bool Map::transfer() {
80105520:	55                   	push   %ebp
80105521:	89 e5                	mov    %esp,%ebp
80105523:	56                   	push   %esi
80105524:	53                   	push   %ebx
80105525:	83 ec 08             	sub    $0x8,%esp
	if(!roundRobinQ->isEmpty())
		return false;

	while(!isEmpty()) {
80105528:	8b 10                	mov    (%eax),%edx
8010552a:	8b 35 10 c6 10 80    	mov    0x8010c610,%esi
80105530:	85 d2                	test   %edx,%edx
80105532:	74 26                	je     8010555a <_ZN3Map8transferEv.part.1+0x3a>
80105534:	89 c3                	mov    %eax,%ebx
80105536:	8d 76 00             	lea    0x0(%esi),%esi
80105539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		Proc* p = extractMin();
80105540:	89 1c 24             	mov    %ebx,(%esp)
80105543:	e8 f8 fe ff ff       	call   80105440 <_ZN3Map10extractMinEv>
		roundRobinQ->enqueue(p); //should succeed.
80105548:	89 34 24             	mov    %esi,(%esp)
8010554b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010554f:	e8 3c f9 ff ff       	call   80104e90 <_ZN10LinkedList7enqueueEP4proc>

bool Map::transfer() {
	if(!roundRobinQ->isEmpty())
		return false;

	while(!isEmpty()) {
80105554:	8b 03                	mov    (%ebx),%eax
80105556:	85 c0                	test   %eax,%eax
80105558:	75 e6                	jne    80105540 <_ZN3Map8transferEv.part.1+0x20>
		Proc* p = extractMin();
		roundRobinQ->enqueue(p); //should succeed.
	}

	return true;
}
8010555a:	83 c4 08             	add    $0x8,%esp
8010555d:	b0 01                	mov    $0x1,%al
8010555f:	5b                   	pop    %ebx
80105560:	5e                   	pop    %esi
80105561:	5d                   	pop    %ebp
80105562:	c3                   	ret    
80105563:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105570 <switchToRoundRobinPolicyPriorityQueue>:

	return p;
}

bool Map::transfer() {
	if(!roundRobinQ->isEmpty())
80105570:	8b 15 10 c6 10 80    	mov    0x8010c610,%edx
80105576:	8b 02                	mov    (%edx),%eax
80105578:	85 c0                	test   %eax,%eax
8010557a:	74 04                	je     80105580 <switchToRoundRobinPolicyPriorityQueue+0x10>
8010557c:	31 c0                	xor    %eax,%eax
8010557e:	c3                   	ret    
8010557f:	90                   	nop
80105580:	a1 14 c6 10 80       	mov    0x8010c614,%eax

static Proc* extractMinPriorityQueue() {
	return priorityQ->extractMin();
}

static boolean switchToRoundRobinPolicyPriorityQueue() {
80105585:	55                   	push   %ebp
80105586:	89 e5                	mov    %esp,%ebp
80105588:	e8 93 ff ff ff       	call   80105520 <_ZN3Map8transferEv.part.1>
	return priorityQ->transfer();
}
8010558d:	5d                   	pop    %ebp
8010558e:	0f b6 c0             	movzbl %al,%eax
80105591:	c3                   	ret    
80105592:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055a0 <_ZN3Map8transferEv>:

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
801055a0:	8b 15 10 c6 10 80    	mov    0x8010c610,%edx
	}

	return p;
}

bool Map::transfer() {
801055a6:	55                   	push   %ebp
801055a7:	89 e5                	mov    %esp,%ebp
801055a9:	8b 45 08             	mov    0x8(%ebp),%eax
	if(!roundRobinQ->isEmpty())
801055ac:	8b 12                	mov    (%edx),%edx
801055ae:	85 d2                	test   %edx,%edx
801055b0:	74 0e                	je     801055c0 <_ZN3Map8transferEv+0x20>
		Proc* p = extractMin();
		roundRobinQ->enqueue(p); //should succeed.
	}

	return true;
}
801055b2:	31 c0                	xor    %eax,%eax
801055b4:	5d                   	pop    %ebp
801055b5:	c3                   	ret    
801055b6:	8d 76 00             	lea    0x0(%esi),%esi
801055b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801055c0:	5d                   	pop    %ebp
801055c1:	e9 5a ff ff ff       	jmp    80105520 <_ZN3Map8transferEv.part.1>
801055c6:	8d 76 00             	lea    0x0(%esi),%esi
801055c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055d0 <_ZN3Map11extractProcEP4proc>:

bool Map::extractProc(Proc *p) {
801055d0:	55                   	push   %ebp
801055d1:	89 e5                	mov    %esp,%ebp
801055d3:	57                   	push   %edi
801055d4:	56                   	push   %esi
801055d5:	53                   	push   %ebx
801055d6:	83 ec 2c             	sub    $0x2c,%esp
	if(!freeNodes)
801055d9:	8b 15 04 c6 10 80    	mov    0x8010c604,%edx
	}

	return true;
}

bool Map::extractProc(Proc *p) {
801055df:	8b 75 08             	mov    0x8(%ebp),%esi
801055e2:	8b 7d 0c             	mov    0xc(%ebp),%edi
	if(!freeNodes)
801055e5:	85 d2                	test   %edx,%edx
801055e7:	74 48                	je     80105631 <_ZN3Map11extractProcEP4proc+0x61>
	MapNode *next, *parent, *left, *right;
};

class Map {
public:
	Map(): root(null) {}
801055e9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
		return false;

	bool ans = false;
801055f0:	31 db                	xor    %ebx,%ebx
801055f2:	eb 12                	jmp    80105606 <_ZN3Map11extractProcEP4proc+0x36>
801055f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	Map tempMap;
	while(!isEmpty()) {
		Proc *otherP = extractMin();
801055f8:	89 34 24             	mov    %esi,(%esp)
801055fb:	e8 40 fe ff ff       	call   80105440 <_ZN3Map10extractMinEv>
		if(otherP != p)
80105600:	39 f8                	cmp    %edi,%eax
80105602:	75 1c                	jne    80105620 <_ZN3Map11extractProcEP4proc+0x50>
			tempMap.put(otherP); //should scucceed.
		else ans = true;
80105604:	b3 01                	mov    $0x1,%bl
	if(!freeNodes)
		return false;

	bool ans = false;
	Map tempMap;
	while(!isEmpty()) {
80105606:	8b 06                	mov    (%esi),%eax
80105608:	85 c0                	test   %eax,%eax
8010560a:	75 ec                	jne    801055f8 <_ZN3Map11extractProcEP4proc+0x28>
		Proc *otherP = extractMin();
		if(otherP != p)
			tempMap.put(otherP); //should scucceed.
		else ans = true;
	}
	root = tempMap.root;
8010560c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010560f:	89 06                	mov    %eax,(%esi)
	return ans;
}
80105611:	83 c4 2c             	add    $0x2c,%esp
		Proc *otherP = extractMin();
		if(otherP != p)
			tempMap.put(otherP); //should scucceed.
		else ans = true;
	}
	root = tempMap.root;
80105614:	88 d8                	mov    %bl,%al
	return ans;
}
80105616:	5b                   	pop    %ebx
80105617:	5e                   	pop    %esi
80105618:	5f                   	pop    %edi
80105619:	5d                   	pop    %ebp
8010561a:	c3                   	ret    
8010561b:	90                   	nop
8010561c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	bool ans = false;
	Map tempMap;
	while(!isEmpty()) {
		Proc *otherP = extractMin();
		if(otherP != p)
			tempMap.put(otherP); //should scucceed.
80105620:	89 44 24 04          	mov    %eax,0x4(%esp)
80105624:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105627:	89 04 24             	mov    %eax,(%esp)
8010562a:	e8 51 fd ff ff       	call   80105380 <_ZN3Map3putEP4proc>
8010562f:	eb d5                	jmp    80105606 <_ZN3Map11extractProcEP4proc+0x36>
		else ans = true;
	}
	root = tempMap.root;
	return ans;
}
80105631:	83 c4 2c             	add    $0x2c,%esp
	return true;
}

bool Map::extractProc(Proc *p) {
	if(!freeNodes)
		return false;
80105634:	31 c0                	xor    %eax,%eax
			tempMap.put(otherP); //should scucceed.
		else ans = true;
	}
	root = tempMap.root;
	return ans;
}
80105636:	5b                   	pop    %ebx
80105637:	5e                   	pop    %esi
80105638:	5f                   	pop    %edi
80105639:	5d                   	pop    %ebp
8010563a:	c3                   	ret    
8010563b:	90                   	nop
8010563c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105640 <extractProcPriorityQueue>:

static boolean switchToRoundRobinPolicyPriorityQueue() {
	return priorityQ->transfer();
}

static boolean extractProcPriorityQueue(Proc *p) {
80105640:	55                   	push   %ebp
80105641:	89 e5                	mov    %esp,%ebp
80105643:	83 ec 18             	sub    $0x18,%esp
	return priorityQ->extractProc(p);
80105646:	8b 45 08             	mov    0x8(%ebp),%eax
80105649:	89 44 24 04          	mov    %eax,0x4(%esp)
8010564d:	a1 14 c6 10 80       	mov    0x8010c614,%eax
80105652:	89 04 24             	mov    %eax,(%esp)
80105655:	e8 76 ff ff ff       	call   801055d0 <_ZN3Map11extractProcEP4proc>
}
8010565a:	c9                   	leave  
static boolean switchToRoundRobinPolicyPriorityQueue() {
	return priorityQ->transfer();
}

static boolean extractProcPriorityQueue(Proc *p) {
	return priorityQ->extractProc(p);
8010565b:	0f b6 c0             	movzbl %al,%eax
}
8010565e:	c3                   	ret    
8010565f:	90                   	nop

80105660 <__moddi3>:
	}
	root = tempMap.root;
	return ans;
}

long long __moddi3(long long number, long long divisor) { //returns number%divisor
80105660:	55                   	push   %ebp
80105661:	89 e5                	mov    %esp,%ebp
80105663:	57                   	push   %edi
80105664:	56                   	push   %esi
80105665:	53                   	push   %ebx
80105666:	83 ec 2c             	sub    $0x2c,%esp
80105669:	8b 45 08             	mov    0x8(%ebp),%eax
8010566c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010566f:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105672:	8b 45 10             	mov    0x10(%ebp),%eax
80105675:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80105678:	8b 55 14             	mov    0x14(%ebp),%edx
8010567b:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010567e:	89 d7                	mov    %edx,%edi
	if(divisor == 0)
80105680:	09 c2                	or     %eax,%edx
80105682:	0f 84 9d 00 00 00    	je     80105725 <__moddi3+0xc5>
		panic((char*)"divide by zero!!!\n");

	bool isNumberNegative = false;
	if(number < 0) {
80105688:	8b 45 e4             	mov    -0x1c(%ebp),%eax

long long __moddi3(long long number, long long divisor) { //returns number%divisor
	if(divisor == 0)
		panic((char*)"divide by zero!!!\n");

	bool isNumberNegative = false;
8010568b:	c6 45 df 00          	movb   $0x0,-0x21(%ebp)
	if(number < 0) {
8010568f:	85 c0                	test   %eax,%eax
80105691:	78 7f                	js     80105712 <__moddi3+0xb2>
80105693:	8b 55 d8             	mov    -0x28(%ebp),%edx
80105696:	89 f8                	mov    %edi,%eax
80105698:	c1 ff 1f             	sar    $0x1f,%edi
8010569b:	31 f8                	xor    %edi,%eax
8010569d:	89 f9                	mov    %edi,%ecx
8010569f:	31 fa                	xor    %edi,%edx
801056a1:	89 c7                	mov    %eax,%edi
801056a3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801056a6:	89 d6                	mov    %edx,%esi
801056a8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801056ab:	29 ce                	sub    %ecx,%esi
801056ad:	19 cf                	sbb    %ecx,%edi
801056af:	90                   	nop
	if(divisor < 0)
		divisor = -divisor;

	for(;;) {
		long long divisor2 = divisor;
		while(number >= divisor2) {
801056b0:	39 fa                	cmp    %edi,%edx
801056b2:	7d 1c                	jge    801056d0 <__moddi3+0x70>
			if(divisor2 + divisor2 > 0) //exponential decay.
				divisor2 += divisor2;
		}

		if(number < divisor)
			return isNumberNegative ? -number : number;
801056b4:	80 7d df 00          	cmpb   $0x0,-0x21(%ebp)
801056b8:	74 07                	je     801056c1 <__moddi3+0x61>
801056ba:	f7 d8                	neg    %eax
801056bc:	83 d2 00             	adc    $0x0,%edx
801056bf:	f7 da                	neg    %edx
	}
}
801056c1:	83 c4 2c             	add    $0x2c,%esp
801056c4:	5b                   	pop    %ebx
801056c5:	5e                   	pop    %esi
801056c6:	5f                   	pop    %edi
801056c7:	5d                   	pop    %ebp
801056c8:	c3                   	ret    
801056c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	if(divisor < 0)
		divisor = -divisor;

	for(;;) {
		long long divisor2 = divisor;
		while(number >= divisor2) {
801056d0:	7f 04                	jg     801056d6 <__moddi3+0x76>
801056d2:	39 f0                	cmp    %esi,%eax
801056d4:	72 de                	jb     801056b4 <__moddi3+0x54>
801056d6:	89 f1                	mov    %esi,%ecx
801056d8:	89 fb                	mov    %edi,%ebx
801056da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			number -= divisor2;
801056e0:	29 c8                	sub    %ecx,%eax
801056e2:	19 da                	sbb    %ebx,%edx
			if(divisor2 + divisor2 > 0) //exponential decay.
801056e4:	0f a4 cb 01          	shld   $0x1,%ecx,%ebx
801056e8:	01 c9                	add    %ecx,%ecx
	if(divisor < 0)
		divisor = -divisor;

	for(;;) {
		long long divisor2 = divisor;
		while(number >= divisor2) {
801056ea:	39 da                	cmp    %ebx,%edx
801056ec:	7f f2                	jg     801056e0 <__moddi3+0x80>
801056ee:	7d 18                	jge    80105708 <__moddi3+0xa8>
			number -= divisor2;
			if(divisor2 + divisor2 > 0) //exponential decay.
				divisor2 += divisor2;
		}

		if(number < divisor)
801056f0:	39 d7                	cmp    %edx,%edi
801056f2:	7c bc                	jl     801056b0 <__moddi3+0x50>
801056f4:	7f be                	jg     801056b4 <__moddi3+0x54>
801056f6:	39 c6                	cmp    %eax,%esi
801056f8:	76 b6                	jbe    801056b0 <__moddi3+0x50>
801056fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105700:	eb b2                	jmp    801056b4 <__moddi3+0x54>
80105702:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	if(divisor < 0)
		divisor = -divisor;

	for(;;) {
		long long divisor2 = divisor;
		while(number >= divisor2) {
80105708:	39 c8                	cmp    %ecx,%eax
8010570a:	73 d4                	jae    801056e0 <__moddi3+0x80>
8010570c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105710:	eb de                	jmp    801056f0 <__moddi3+0x90>
	if(divisor == 0)
		panic((char*)"divide by zero!!!\n");

	bool isNumberNegative = false;
	if(number < 0) {
		number = -number;
80105712:	f7 5d e0             	negl   -0x20(%ebp)
		isNumberNegative = true;
80105715:	c6 45 df 01          	movb   $0x1,-0x21(%ebp)
	if(divisor == 0)
		panic((char*)"divide by zero!!!\n");

	bool isNumberNegative = false;
	if(number < 0) {
		number = -number;
80105719:	83 55 e4 00          	adcl   $0x0,-0x1c(%ebp)
8010571d:	f7 5d e4             	negl   -0x1c(%ebp)
80105720:	e9 6e ff ff ff       	jmp    80105693 <__moddi3+0x33>
	return ans;
}

long long __moddi3(long long number, long long divisor) { //returns number%divisor
	if(divisor == 0)
		panic((char*)"divide by zero!!!\n");
80105725:	c7 04 24 f0 8d 10 80 	movl   $0x80108df0,(%esp)
8010572c:	e8 0f ac ff ff       	call   80100340 <panic>
80105731:	90                   	nop
80105732:	66 90                	xchg   %ax,%ax
80105734:	66 90                	xchg   %ax,%ax
80105736:	66 90                	xchg   %ax,%ax
80105738:	66 90                	xchg   %ax,%ax
8010573a:	66 90                	xchg   %ax,%ax
8010573c:	66 90                	xchg   %ax,%ax
8010573e:	66 90                	xchg   %ax,%ax

80105740 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80105740:	55                   	push   %ebp
  initlock(&lk->lk, "sleep lock");
80105741:	b8 03 8e 10 80       	mov    $0x80108e03,%eax
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80105746:	89 e5                	mov    %esp,%ebp
80105748:	53                   	push   %ebx
80105749:	83 ec 14             	sub    $0x14,%esp
8010574c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010574f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105753:	8d 43 04             	lea    0x4(%ebx),%eax
80105756:	89 04 24             	mov    %eax,(%esp)
80105759:	e8 12 01 00 00       	call   80105870 <initlock>
  lk->name = name;
8010575e:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80105761:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80105767:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
8010576e:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
80105771:	83 c4 14             	add    $0x14,%esp
80105774:	5b                   	pop    %ebx
80105775:	5d                   	pop    %ebp
80105776:	c3                   	ret    
80105777:	89 f6                	mov    %esi,%esi
80105779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105780 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80105780:	55                   	push   %ebp
80105781:	89 e5                	mov    %esp,%ebp
80105783:	56                   	push   %esi
80105784:	53                   	push   %ebx
80105785:	83 ec 10             	sub    $0x10,%esp
80105788:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010578b:	8d 73 04             	lea    0x4(%ebx),%esi
8010578e:	89 34 24             	mov    %esi,(%esp)
80105791:	e8 3a 02 00 00       	call   801059d0 <acquire>
  while (lk->locked) {
80105796:	8b 13                	mov    (%ebx),%edx
80105798:	85 d2                	test   %edx,%edx
8010579a:	74 16                	je     801057b2 <acquiresleep+0x32>
8010579c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
801057a0:	89 74 24 04          	mov    %esi,0x4(%esp)
801057a4:	89 1c 24             	mov    %ebx,(%esp)
801057a7:	e8 d4 eb ff ff       	call   80104380 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
801057ac:	8b 03                	mov    (%ebx),%eax
801057ae:	85 c0                	test   %eax,%eax
801057b0:	75 ee                	jne    801057a0 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
801057b2:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801057b8:	e8 13 e2 ff ff       	call   801039d0 <myproc>
801057bd:	8b 40 10             	mov    0x10(%eax),%eax
801057c0:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801057c3:	89 75 08             	mov    %esi,0x8(%ebp)
}
801057c6:	83 c4 10             	add    $0x10,%esp
801057c9:	5b                   	pop    %ebx
801057ca:	5e                   	pop    %esi
801057cb:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
801057cc:	e9 9f 02 00 00       	jmp    80105a70 <release>
801057d1:	eb 0d                	jmp    801057e0 <releasesleep>
801057d3:	90                   	nop
801057d4:	90                   	nop
801057d5:	90                   	nop
801057d6:	90                   	nop
801057d7:	90                   	nop
801057d8:	90                   	nop
801057d9:	90                   	nop
801057da:	90                   	nop
801057db:	90                   	nop
801057dc:	90                   	nop
801057dd:	90                   	nop
801057de:	90                   	nop
801057df:	90                   	nop

801057e0 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
801057e0:	55                   	push   %ebp
801057e1:	89 e5                	mov    %esp,%ebp
801057e3:	83 ec 18             	sub    $0x18,%esp
801057e6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801057e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801057ec:	89 75 fc             	mov    %esi,-0x4(%ebp)
  acquire(&lk->lk);
801057ef:	8d 73 04             	lea    0x4(%ebx),%esi
801057f2:	89 34 24             	mov    %esi,(%esp)
801057f5:	e8 d6 01 00 00       	call   801059d0 <acquire>
  lk->locked = 0;
801057fa:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80105800:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80105807:	89 1c 24             	mov    %ebx,(%esp)
8010580a:	e8 91 ed ff ff       	call   801045a0 <wakeup>
  release(&lk->lk);
}
8010580f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
80105812:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105815:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105818:	89 ec                	mov    %ebp,%esp
8010581a:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
8010581b:	e9 50 02 00 00       	jmp    80105a70 <release>

80105820 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
80105820:	55                   	push   %ebp
80105821:	89 e5                	mov    %esp,%ebp
80105823:	83 ec 28             	sub    $0x28,%esp
80105826:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80105829:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010582c:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010582f:	89 75 f8             	mov    %esi,-0x8(%ebp)
80105832:	31 f6                	xor    %esi,%esi
  int r;
  
  acquire(&lk->lk);
80105834:	8d 7b 04             	lea    0x4(%ebx),%edi
80105837:	89 3c 24             	mov    %edi,(%esp)
8010583a:	e8 91 01 00 00       	call   801059d0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
8010583f:	8b 03                	mov    (%ebx),%eax
80105841:	85 c0                	test   %eax,%eax
80105843:	74 11                	je     80105856 <holdingsleep+0x36>
80105845:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80105848:	e8 83 e1 ff ff       	call   801039d0 <myproc>
8010584d:	39 58 10             	cmp    %ebx,0x10(%eax)
80105850:	0f 94 c0             	sete   %al
80105853:	0f b6 f0             	movzbl %al,%esi
  release(&lk->lk);
80105856:	89 3c 24             	mov    %edi,(%esp)
80105859:	e8 12 02 00 00       	call   80105a70 <release>
  return r;
}
8010585e:	89 f0                	mov    %esi,%eax
80105860:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105863:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105866:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105869:	89 ec                	mov    %ebp,%esp
8010586b:	5d                   	pop    %ebp
8010586c:	c3                   	ret    
8010586d:	66 90                	xchg   %ax,%ax
8010586f:	90                   	nop

80105870 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105870:	55                   	push   %ebp
80105871:	89 e5                	mov    %esp,%ebp
80105873:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80105876:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80105879:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
8010587f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
80105882:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105889:	5d                   	pop    %ebp
8010588a:	c3                   	ret    
8010588b:	90                   	nop
8010588c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105890 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105890:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105891:	31 d2                	xor    %edx,%edx
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105893:	89 e5                	mov    %esp,%ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80105895:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105898:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010589b:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010589c:	83 e8 08             	sub    $0x8,%eax
8010589f:	90                   	nop
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801058a0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801058a6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801058ac:	77 12                	ja     801058c0 <getcallerpcs+0x30>
      break;
    pcs[i] = ebp[1];     // saved %eip
801058ae:	8b 58 04             	mov    0x4(%eax),%ebx
801058b1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801058b4:	42                   	inc    %edx
801058b5:	83 fa 0a             	cmp    $0xa,%edx
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
801058b8:	8b 00                	mov    (%eax),%eax
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801058ba:	75 e4                	jne    801058a0 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801058bc:	5b                   	pop    %ebx
801058bd:	5d                   	pop    %ebp
801058be:	c3                   	ret    
801058bf:	90                   	nop
801058c0:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801058c3:	8d 51 28             	lea    0x28(%ecx),%edx
801058c6:	8d 76 00             	lea    0x0(%esi),%esi
801058c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
801058d0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801058d6:	83 c0 04             	add    $0x4,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801058d9:	39 d0                	cmp    %edx,%eax
801058db:	75 f3                	jne    801058d0 <getcallerpcs+0x40>
    pcs[i] = 0;
}
801058dd:	5b                   	pop    %ebx
801058de:	5d                   	pop    %ebp
801058df:	c3                   	ret    

801058e0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801058e0:	55                   	push   %ebp
801058e1:	89 e5                	mov    %esp,%ebp
801058e3:	53                   	push   %ebx
801058e4:	83 ec 04             	sub    $0x4,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801058e7:	9c                   	pushf  
801058e8:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
801058e9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801058ea:	e8 41 e0 ff ff       	call   80103930 <mycpu>
801058ef:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801058f5:	85 d2                	test   %edx,%edx
801058f7:	75 11                	jne    8010590a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801058f9:	e8 32 e0 ff ff       	call   80103930 <mycpu>
801058fe:	81 e3 00 02 00 00    	and    $0x200,%ebx
80105904:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010590a:	e8 21 e0 ff ff       	call   80103930 <mycpu>
8010590f:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
}
80105915:	58                   	pop    %eax
80105916:	5b                   	pop    %ebx
80105917:	5d                   	pop    %ebp
80105918:	c3                   	ret    
80105919:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105920 <popcli>:

void
popcli(void)
{
80105920:	55                   	push   %ebp
80105921:	89 e5                	mov    %esp,%ebp
80105923:	83 ec 18             	sub    $0x18,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105926:	9c                   	pushf  
80105927:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80105928:	f6 c4 02             	test   $0x2,%ah
8010592b:	75 51                	jne    8010597e <popcli+0x5e>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010592d:	e8 fe df ff ff       	call   80103930 <mycpu>
80105932:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80105938:	8d 51 ff             	lea    -0x1(%ecx),%edx
8010593b:	85 d2                	test   %edx,%edx
8010593d:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80105943:	78 2d                	js     80105972 <popcli+0x52>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105945:	e8 e6 df ff ff       	call   80103930 <mycpu>
8010594a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105950:	85 d2                	test   %edx,%edx
80105952:	74 0c                	je     80105960 <popcli+0x40>
    sti();
}
80105954:	c9                   	leave  
80105955:	c3                   	ret    
80105956:	8d 76 00             	lea    0x0(%esi),%esi
80105959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105960:	e8 cb df ff ff       	call   80103930 <mycpu>
80105965:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010596b:	85 c0                	test   %eax,%eax
8010596d:	74 e5                	je     80105954 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
8010596f:	fb                   	sti    
    sti();
}
80105970:	c9                   	leave  
80105971:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
80105972:	c7 04 24 25 8e 10 80 	movl   $0x80108e25,(%esp)
80105979:	e8 c2 a9 ff ff       	call   80100340 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
8010597e:	c7 04 24 0e 8e 10 80 	movl   $0x80108e0e,(%esp)
80105985:	e8 b6 a9 ff ff       	call   80100340 <panic>
8010598a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105990 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80105990:	55                   	push   %ebp
80105991:	89 e5                	mov    %esp,%ebp
80105993:	83 ec 08             	sub    $0x8,%esp
80105996:	89 75 fc             	mov    %esi,-0x4(%ebp)
80105999:	8b 75 08             	mov    0x8(%ebp),%esi
8010599c:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010599f:	31 db                	xor    %ebx,%ebx
  int r;
  pushcli();
801059a1:	e8 3a ff ff ff       	call   801058e0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801059a6:	8b 06                	mov    (%esi),%eax
801059a8:	85 c0                	test   %eax,%eax
801059aa:	74 10                	je     801059bc <holding+0x2c>
801059ac:	8b 5e 08             	mov    0x8(%esi),%ebx
801059af:	e8 7c df ff ff       	call   80103930 <mycpu>
801059b4:	39 c3                	cmp    %eax,%ebx
801059b6:	0f 94 c3             	sete   %bl
801059b9:	0f b6 db             	movzbl %bl,%ebx
  popcli();
801059bc:	e8 5f ff ff ff       	call   80105920 <popcli>
  return r;
}
801059c1:	89 d8                	mov    %ebx,%eax
801059c3:	8b 75 fc             	mov    -0x4(%ebp),%esi
801059c6:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801059c9:	89 ec                	mov    %ebp,%esp
801059cb:	5d                   	pop    %ebp
801059cc:	c3                   	ret    
801059cd:	8d 76 00             	lea    0x0(%esi),%esi

801059d0 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
801059d0:	55                   	push   %ebp
801059d1:	89 e5                	mov    %esp,%ebp
801059d3:	56                   	push   %esi
801059d4:	53                   	push   %ebx
801059d5:	83 ec 10             	sub    $0x10,%esp
  pushcli(); // disable interrupts to avoid deadlock.
801059d8:	e8 03 ff ff ff       	call   801058e0 <pushcli>
  if(holding(lk))
801059dd:	8b 5d 08             	mov    0x8(%ebp),%ebx
801059e0:	89 1c 24             	mov    %ebx,(%esp)
801059e3:	e8 a8 ff ff ff       	call   80105990 <holding>
801059e8:	85 c0                	test   %eax,%eax
801059ea:	75 78                	jne    80105a64 <acquire+0x94>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801059ec:	ba 01 00 00 00       	mov    $0x1,%edx
801059f1:	eb 08                	jmp    801059fb <acquire+0x2b>
801059f3:	90                   	nop
801059f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801059f8:	8b 5d 08             	mov    0x8(%ebp),%ebx
801059fb:	89 d0                	mov    %edx,%eax
801059fd:	f0 87 03             	lock xchg %eax,(%ebx)
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
80105a00:	85 c0                	test   %eax,%eax
80105a02:	75 f4                	jne    801059f8 <acquire+0x28>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
80105a04:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
80105a09:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105a0c:	e8 1f df ff ff       	call   80103930 <mycpu>
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80105a11:	89 ea                	mov    %ebp,%edx
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
80105a13:	8d 73 0c             	lea    0xc(%ebx),%esi
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
80105a16:	89 43 08             	mov    %eax,0x8(%ebx)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105a19:	31 c0                	xor    %eax,%eax
80105a1b:	90                   	nop
80105a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105a20:	8d 8a 00 00 00 80    	lea    -0x80000000(%edx),%ecx
80105a26:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80105a2c:	77 1a                	ja     80105a48 <acquire+0x78>
      break;
    pcs[i] = ebp[1];     // saved %eip
80105a2e:	8b 4a 04             	mov    0x4(%edx),%ecx
80105a31:	89 0c 86             	mov    %ecx,(%esi,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105a34:	40                   	inc    %eax
80105a35:	83 f8 0a             	cmp    $0xa,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80105a38:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105a3a:	75 e4                	jne    80105a20 <acquire+0x50>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}
80105a3c:	83 c4 10             	add    $0x10,%esp
80105a3f:	5b                   	pop    %ebx
80105a40:	5e                   	pop    %esi
80105a41:	5d                   	pop    %ebp
80105a42:	c3                   	ret    
80105a43:	90                   	nop
80105a44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a48:	8d 04 86             	lea    (%esi,%eax,4),%eax
80105a4b:	8d 53 34             	lea    0x34(%ebx),%edx
80105a4e:	66 90                	xchg   %ax,%ax
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80105a50:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105a56:	83 c0 04             	add    $0x4,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80105a59:	39 d0                	cmp    %edx,%eax
80105a5b:	75 f3                	jne    80105a50 <acquire+0x80>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}
80105a5d:	83 c4 10             	add    $0x10,%esp
80105a60:	5b                   	pop    %ebx
80105a61:	5e                   	pop    %esi
80105a62:	5d                   	pop    %ebp
80105a63:	c3                   	ret    
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80105a64:	c7 04 24 2c 8e 10 80 	movl   $0x80108e2c,(%esp)
80105a6b:	e8 d0 a8 ff ff       	call   80100340 <panic>

80105a70 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
80105a70:	55                   	push   %ebp
80105a71:	89 e5                	mov    %esp,%ebp
80105a73:	53                   	push   %ebx
80105a74:	83 ec 14             	sub    $0x14,%esp
80105a77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80105a7a:	89 1c 24             	mov    %ebx,(%esp)
80105a7d:	e8 0e ff ff ff       	call   80105990 <holding>
80105a82:	85 c0                	test   %eax,%eax
80105a84:	74 23                	je     80105aa9 <release+0x39>
    panic("release");

  lk->pcs[0] = 0;
80105a86:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105a8d:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
80105a94:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80105a99:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
80105a9f:	83 c4 14             	add    $0x14,%esp
80105aa2:	5b                   	pop    %ebx
80105aa3:	5d                   	pop    %ebp
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
80105aa4:	e9 77 fe ff ff       	jmp    80105920 <popcli>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
80105aa9:	c7 04 24 34 8e 10 80 	movl   $0x80108e34,(%esp)
80105ab0:	e8 8b a8 ff ff       	call   80100340 <panic>
80105ab5:	66 90                	xchg   %ax,%ax
80105ab7:	66 90                	xchg   %ax,%ax
80105ab9:	66 90                	xchg   %ax,%ax
80105abb:	66 90                	xchg   %ax,%ax
80105abd:	66 90                	xchg   %ax,%ax
80105abf:	90                   	nop

80105ac0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105ac0:	55                   	push   %ebp
80105ac1:	89 e5                	mov    %esp,%ebp
80105ac3:	83 ec 08             	sub    $0x8,%esp
80105ac6:	8b 55 08             	mov    0x8(%ebp),%edx
80105ac9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105acc:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105acf:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if ((int)dst%4 == 0 && n%4 == 0){
80105ad2:	f6 c2 03             	test   $0x3,%dl
80105ad5:	75 05                	jne    80105adc <memset+0x1c>
80105ad7:	f6 c1 03             	test   $0x3,%cl
80105ada:	74 14                	je     80105af0 <memset+0x30>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
80105adc:	89 d7                	mov    %edx,%edi
80105ade:	8b 45 0c             	mov    0xc(%ebp),%eax
80105ae1:	fc                   	cld    
80105ae2:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80105ae4:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105ae7:	89 d0                	mov    %edx,%eax
80105ae9:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105aec:	89 ec                	mov    %ebp,%esp
80105aee:	5d                   	pop    %ebp
80105aef:	c3                   	ret    

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
80105af0:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
80105af4:	c1 e9 02             	shr    $0x2,%ecx
80105af7:	89 fb                	mov    %edi,%ebx
80105af9:	89 f8                	mov    %edi,%eax
80105afb:	c1 e3 18             	shl    $0x18,%ebx
80105afe:	c1 e0 10             	shl    $0x10,%eax
80105b01:	09 d8                	or     %ebx,%eax
80105b03:	09 f8                	or     %edi,%eax
80105b05:	c1 e7 08             	shl    $0x8,%edi
80105b08:	09 f8                	or     %edi,%eax
80105b0a:	89 d7                	mov    %edx,%edi
80105b0c:	fc                   	cld    
80105b0d:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80105b0f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105b12:	89 d0                	mov    %edx,%eax
80105b14:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105b17:	89 ec                	mov    %ebp,%esp
80105b19:	5d                   	pop    %ebp
80105b1a:	c3                   	ret    
80105b1b:	90                   	nop
80105b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b20 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105b20:	55                   	push   %ebp
80105b21:	89 e5                	mov    %esp,%ebp
80105b23:	8b 45 10             	mov    0x10(%ebp),%eax
80105b26:	57                   	push   %edi
80105b27:	56                   	push   %esi
80105b28:	8b 75 0c             	mov    0xc(%ebp),%esi
80105b2b:	53                   	push   %ebx
80105b2c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105b2f:	85 c0                	test   %eax,%eax
80105b31:	74 27                	je     80105b5a <memcmp+0x3a>
    if(*s1 != *s2)
80105b33:	0f b6 13             	movzbl (%ebx),%edx
80105b36:	0f b6 0e             	movzbl (%esi),%ecx
80105b39:	38 d1                	cmp    %dl,%cl
80105b3b:	75 2b                	jne    80105b68 <memcmp+0x48>
80105b3d:	8d 78 ff             	lea    -0x1(%eax),%edi
80105b40:	31 c0                	xor    %eax,%eax
80105b42:	eb 12                	jmp    80105b56 <memcmp+0x36>
80105b44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b48:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
80105b4d:	40                   	inc    %eax
80105b4e:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80105b52:	38 ca                	cmp    %cl,%dl
80105b54:	75 12                	jne    80105b68 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105b56:	39 f8                	cmp    %edi,%eax
80105b58:	75 ee                	jne    80105b48 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80105b5a:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
80105b5b:	31 c0                	xor    %eax,%eax
}
80105b5d:	5e                   	pop    %esi
80105b5e:	5f                   	pop    %edi
80105b5f:	5d                   	pop    %ebp
80105b60:	c3                   	ret    
80105b61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b68:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80105b69:	0f b6 c2             	movzbl %dl,%eax
80105b6c:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
80105b6e:	5e                   	pop    %esi
80105b6f:	5f                   	pop    %edi
80105b70:	5d                   	pop    %ebp
80105b71:	c3                   	ret    
80105b72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b80 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105b80:	55                   	push   %ebp
80105b81:	89 e5                	mov    %esp,%ebp
80105b83:	8b 45 08             	mov    0x8(%ebp),%eax
80105b86:	56                   	push   %esi
80105b87:	8b 75 0c             	mov    0xc(%ebp),%esi
80105b8a:	53                   	push   %ebx
80105b8b:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80105b8e:	39 c6                	cmp    %eax,%esi
80105b90:	73 36                	jae    80105bc8 <memmove+0x48>
80105b92:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
80105b95:	39 c8                	cmp    %ecx,%eax
80105b97:	73 2f                	jae    80105bc8 <memmove+0x48>
    s += n;
    d += n;
    while(n-- > 0)
80105b99:	85 db                	test   %ebx,%ebx
80105b9b:	8d 53 ff             	lea    -0x1(%ebx),%edx
80105b9e:	74 1d                	je     80105bbd <memmove+0x3d>
      *--d = *--s;
80105ba0:	29 d9                	sub    %ebx,%ecx
80105ba2:	89 cb                	mov    %ecx,%ebx
80105ba4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105baa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
80105bb0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105bb4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
80105bb7:	4a                   	dec    %edx
80105bb8:	83 fa ff             	cmp    $0xffffffff,%edx
80105bbb:	75 f3                	jne    80105bb0 <memmove+0x30>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80105bbd:	5b                   	pop    %ebx
80105bbe:	5e                   	pop    %esi
80105bbf:	5d                   	pop    %ebp
80105bc0:	c3                   	ret    
80105bc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80105bc8:	31 d2                	xor    %edx,%edx
80105bca:	85 db                	test   %ebx,%ebx
80105bcc:	74 ef                	je     80105bbd <memmove+0x3d>
80105bce:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80105bd0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80105bd4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80105bd7:	42                   	inc    %edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80105bd8:	39 d3                	cmp    %edx,%ebx
80105bda:	75 f4                	jne    80105bd0 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
80105bdc:	5b                   	pop    %ebx
80105bdd:	5e                   	pop    %esi
80105bde:	5d                   	pop    %ebp
80105bdf:	c3                   	ret    

80105be0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105be0:	55                   	push   %ebp
80105be1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80105be3:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80105be4:	eb 9a                	jmp    80105b80 <memmove>
80105be6:	8d 76 00             	lea    0x0(%esi),%esi
80105be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105bf0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80105bf0:	55                   	push   %ebp
80105bf1:	89 e5                	mov    %esp,%ebp
80105bf3:	57                   	push   %edi
80105bf4:	8b 7d 08             	mov    0x8(%ebp),%edi
80105bf7:	56                   	push   %esi
80105bf8:	8b 75 0c             	mov    0xc(%ebp),%esi
80105bfb:	53                   	push   %ebx
80105bfc:	8b 5d 10             	mov    0x10(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
80105bff:	85 db                	test   %ebx,%ebx
80105c01:	74 35                	je     80105c38 <strncmp+0x48>
80105c03:	0f b6 17             	movzbl (%edi),%edx
80105c06:	0f b6 0e             	movzbl (%esi),%ecx
80105c09:	84 d2                	test   %dl,%dl
80105c0b:	74 37                	je     80105c44 <strncmp+0x54>
80105c0d:	38 d1                	cmp    %dl,%cl
80105c0f:	75 33                	jne    80105c44 <strncmp+0x54>
80105c11:	8d 47 01             	lea    0x1(%edi),%eax
80105c14:	01 df                	add    %ebx,%edi
80105c16:	eb 19                	jmp    80105c31 <strncmp+0x41>
80105c18:	90                   	nop
80105c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c20:	0f b6 10             	movzbl (%eax),%edx
80105c23:	84 d2                	test   %dl,%dl
80105c25:	74 19                	je     80105c40 <strncmp+0x50>
80105c27:	0f b6 0b             	movzbl (%ebx),%ecx
80105c2a:	40                   	inc    %eax
80105c2b:	89 de                	mov    %ebx,%esi
80105c2d:	38 ca                	cmp    %cl,%dl
80105c2f:	75 13                	jne    80105c44 <strncmp+0x54>
80105c31:	39 c7                	cmp    %eax,%edi
    n--, p++, q++;
80105c33:	8d 5e 01             	lea    0x1(%esi),%ebx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80105c36:	75 e8                	jne    80105c20 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80105c38:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
80105c39:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
80105c3b:	5e                   	pop    %esi
80105c3c:	5f                   	pop    %edi
80105c3d:	5d                   	pop    %ebp
80105c3e:	c3                   	ret    
80105c3f:	90                   	nop
80105c40:	0f b6 4e 01          	movzbl 0x1(%esi),%ecx
80105c44:	5b                   	pop    %ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80105c45:	0f b6 c2             	movzbl %dl,%eax
80105c48:	29 c8                	sub    %ecx,%eax
}
80105c4a:	5e                   	pop    %esi
80105c4b:	5f                   	pop    %edi
80105c4c:	5d                   	pop    %ebp
80105c4d:	c3                   	ret    
80105c4e:	66 90                	xchg   %ax,%ax

80105c50 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105c50:	55                   	push   %ebp
80105c51:	89 e5                	mov    %esp,%ebp
80105c53:	8b 45 08             	mov    0x8(%ebp),%eax
80105c56:	56                   	push   %esi
80105c57:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105c5a:	53                   	push   %ebx
80105c5b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80105c5e:	89 c2                	mov    %eax,%edx
80105c60:	eb 15                	jmp    80105c77 <strncpy+0x27>
80105c62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105c68:	46                   	inc    %esi
80105c69:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
80105c6d:	42                   	inc    %edx
80105c6e:	84 c9                	test   %cl,%cl
80105c70:	88 4a ff             	mov    %cl,-0x1(%edx)
80105c73:	74 09                	je     80105c7e <strncpy+0x2e>
80105c75:	89 d9                	mov    %ebx,%ecx
80105c77:	85 c9                	test   %ecx,%ecx
80105c79:	8d 59 ff             	lea    -0x1(%ecx),%ebx
80105c7c:	7f ea                	jg     80105c68 <strncpy+0x18>
    ;
  while(n-- > 0)
80105c7e:	31 c9                	xor    %ecx,%ecx
80105c80:	85 db                	test   %ebx,%ebx
80105c82:	7e 19                	jle    80105c9d <strncpy+0x4d>
80105c84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105c8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *s++ = 0;
80105c90:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80105c94:	89 de                	mov    %ebx,%esi
80105c96:	41                   	inc    %ecx
80105c97:	29 ce                	sub    %ecx,%esi
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
80105c99:	85 f6                	test   %esi,%esi
80105c9b:	7f f3                	jg     80105c90 <strncpy+0x40>
    *s++ = 0;
  return os;
}
80105c9d:	5b                   	pop    %ebx
80105c9e:	5e                   	pop    %esi
80105c9f:	5d                   	pop    %ebp
80105ca0:	c3                   	ret    
80105ca1:	eb 0d                	jmp    80105cb0 <safestrcpy>
80105ca3:	90                   	nop
80105ca4:	90                   	nop
80105ca5:	90                   	nop
80105ca6:	90                   	nop
80105ca7:	90                   	nop
80105ca8:	90                   	nop
80105ca9:	90                   	nop
80105caa:	90                   	nop
80105cab:	90                   	nop
80105cac:	90                   	nop
80105cad:	90                   	nop
80105cae:	90                   	nop
80105caf:	90                   	nop

80105cb0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105cb0:	55                   	push   %ebp
80105cb1:	89 e5                	mov    %esp,%ebp
80105cb3:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105cb6:	56                   	push   %esi
80105cb7:	8b 45 08             	mov    0x8(%ebp),%eax
80105cba:	53                   	push   %ebx
80105cbb:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80105cbe:	85 c9                	test   %ecx,%ecx
80105cc0:	7e 22                	jle    80105ce4 <safestrcpy+0x34>
80105cc2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80105cc6:	89 c1                	mov    %eax,%ecx
80105cc8:	eb 13                	jmp    80105cdd <safestrcpy+0x2d>
80105cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105cd0:	42                   	inc    %edx
80105cd1:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80105cd5:	41                   	inc    %ecx
80105cd6:	84 db                	test   %bl,%bl
80105cd8:	88 59 ff             	mov    %bl,-0x1(%ecx)
80105cdb:	74 04                	je     80105ce1 <safestrcpy+0x31>
80105cdd:	39 f2                	cmp    %esi,%edx
80105cdf:	75 ef                	jne    80105cd0 <safestrcpy+0x20>
    ;
  *s = 0;
80105ce1:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80105ce4:	5b                   	pop    %ebx
80105ce5:	5e                   	pop    %esi
80105ce6:	5d                   	pop    %ebp
80105ce7:	c3                   	ret    
80105ce8:	90                   	nop
80105ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105cf0 <strlen>:

int
strlen(const char *s)
{
80105cf0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105cf1:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
80105cf3:	89 e5                	mov    %esp,%ebp
80105cf5:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80105cf8:	80 3a 00             	cmpb   $0x0,(%edx)
80105cfb:	74 0a                	je     80105d07 <strlen+0x17>
80105cfd:	8d 76 00             	lea    0x0(%esi),%esi
80105d00:	40                   	inc    %eax
80105d01:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105d05:	75 f9                	jne    80105d00 <strlen+0x10>
    ;
  return n;
}
80105d07:	5d                   	pop    %ebp
80105d08:	c3                   	ret    

80105d09 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80105d09:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80105d0d:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80105d11:	55                   	push   %ebp
  pushl %ebx
80105d12:	53                   	push   %ebx
  pushl %esi
80105d13:	56                   	push   %esi
  pushl %edi
80105d14:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105d15:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105d17:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80105d19:	5f                   	pop    %edi
  popl %esi
80105d1a:	5e                   	pop    %esi
  popl %ebx
80105d1b:	5b                   	pop    %ebx
  popl %ebp
80105d1c:	5d                   	pop    %ebp
  ret
80105d1d:	c3                   	ret    
80105d1e:	66 90                	xchg   %ax,%ax

80105d20 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105d20:	55                   	push   %ebp
80105d21:	89 e5                	mov    %esp,%ebp
80105d23:	53                   	push   %ebx
80105d24:	83 ec 04             	sub    $0x4,%esp
80105d27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80105d2a:	e8 a1 dc ff ff       	call   801039d0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105d2f:	8b 00                	mov    (%eax),%eax
80105d31:	39 d8                	cmp    %ebx,%eax
80105d33:	76 1b                	jbe    80105d50 <fetchint+0x30>
80105d35:	8d 53 04             	lea    0x4(%ebx),%edx
80105d38:	39 d0                	cmp    %edx,%eax
80105d3a:	72 14                	jb     80105d50 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80105d3c:	8b 45 0c             	mov    0xc(%ebp),%eax
80105d3f:	8b 13                	mov    (%ebx),%edx
80105d41:	89 10                	mov    %edx,(%eax)
  return 0;
80105d43:	31 c0                	xor    %eax,%eax
}
80105d45:	5a                   	pop    %edx
80105d46:	5b                   	pop    %ebx
80105d47:	5d                   	pop    %ebp
80105d48:	c3                   	ret    
80105d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80105d50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d55:	eb ee                	jmp    80105d45 <fetchint+0x25>
80105d57:	89 f6                	mov    %esi,%esi
80105d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105d60 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105d60:	55                   	push   %ebp
80105d61:	89 e5                	mov    %esp,%ebp
80105d63:	53                   	push   %ebx
80105d64:	83 ec 04             	sub    $0x4,%esp
80105d67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80105d6a:	e8 61 dc ff ff       	call   801039d0 <myproc>

  if(addr >= curproc->sz)
80105d6f:	39 18                	cmp    %ebx,(%eax)
80105d71:	76 27                	jbe    80105d9a <fetchstr+0x3a>
    return -1;
  *pp = (char*)addr;
80105d73:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105d76:	89 da                	mov    %ebx,%edx
80105d78:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80105d7a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80105d7c:	39 c3                	cmp    %eax,%ebx
80105d7e:	73 1a                	jae    80105d9a <fetchstr+0x3a>
    if(*s == 0)
80105d80:	80 3b 00             	cmpb   $0x0,(%ebx)
80105d83:	75 10                	jne    80105d95 <fetchstr+0x35>
80105d85:	eb 21                	jmp    80105da8 <fetchstr+0x48>
80105d87:	89 f6                	mov    %esi,%esi
80105d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105d90:	80 3a 00             	cmpb   $0x0,(%edx)
80105d93:	74 13                	je     80105da8 <fetchstr+0x48>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
80105d95:	42                   	inc    %edx
80105d96:	39 d0                	cmp    %edx,%eax
80105d98:	77 f6                	ja     80105d90 <fetchstr+0x30>
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80105d9a:	5a                   	pop    %edx
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
80105d9b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80105da0:	5b                   	pop    %ebx
80105da1:	5d                   	pop    %ebp
80105da2:	c3                   	ret    
80105da3:	90                   	nop
80105da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
80105da8:	89 d0                	mov    %edx,%eax
  }
  return -1;
}
80105daa:	5a                   	pop    %edx
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
80105dab:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80105dad:	5b                   	pop    %ebx
80105dae:	5d                   	pop    %ebp
80105daf:	c3                   	ret    

80105db0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105db0:	55                   	push   %ebp
80105db1:	89 e5                	mov    %esp,%ebp
80105db3:	56                   	push   %esi
80105db4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105db5:	e8 16 dc ff ff       	call   801039d0 <myproc>
80105dba:	8b 55 08             	mov    0x8(%ebp),%edx
80105dbd:	8b 40 18             	mov    0x18(%eax),%eax
80105dc0:	8b 40 44             	mov    0x44(%eax),%eax
80105dc3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();
80105dc6:	e8 05 dc ff ff       	call   801039d0 <myproc>

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105dcb:	8d 73 04             	lea    0x4(%ebx),%esi
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105dce:	8b 00                	mov    (%eax),%eax
80105dd0:	39 c6                	cmp    %eax,%esi
80105dd2:	73 1c                	jae    80105df0 <argint+0x40>
80105dd4:	8d 53 08             	lea    0x8(%ebx),%edx
80105dd7:	39 d0                	cmp    %edx,%eax
80105dd9:	72 15                	jb     80105df0 <argint+0x40>
    return -1;
  *ip = *(int*)(addr);
80105ddb:	8b 45 0c             	mov    0xc(%ebp),%eax
80105dde:	8b 53 04             	mov    0x4(%ebx),%edx
80105de1:	89 10                	mov    %edx,(%eax)
  return 0;
80105de3:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
}
80105de5:	5b                   	pop    %ebx
80105de6:	5e                   	pop    %esi
80105de7:	5d                   	pop    %ebp
80105de8:	c3                   	ret    
80105de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80105df0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105df5:	eb ee                	jmp    80105de5 <argint+0x35>
80105df7:	89 f6                	mov    %esi,%esi
80105df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e00 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105e00:	55                   	push   %ebp
80105e01:	89 e5                	mov    %esp,%ebp
80105e03:	56                   	push   %esi
80105e04:	53                   	push   %ebx
80105e05:	83 ec 20             	sub    $0x20,%esp
80105e08:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80105e0b:	e8 c0 db ff ff       	call   801039d0 <myproc>
80105e10:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80105e12:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e15:	89 44 24 04          	mov    %eax,0x4(%esp)
80105e19:	8b 45 08             	mov    0x8(%ebp),%eax
80105e1c:	89 04 24             	mov    %eax,(%esp)
80105e1f:	e8 8c ff ff ff       	call   80105db0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105e24:	c1 e8 1f             	shr    $0x1f,%eax
80105e27:	84 c0                	test   %al,%al
80105e29:	75 2d                	jne    80105e58 <argptr+0x58>
80105e2b:	89 d8                	mov    %ebx,%eax
80105e2d:	c1 e8 1f             	shr    $0x1f,%eax
80105e30:	84 c0                	test   %al,%al
80105e32:	75 24                	jne    80105e58 <argptr+0x58>
80105e34:	8b 16                	mov    (%esi),%edx
80105e36:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e39:	39 c2                	cmp    %eax,%edx
80105e3b:	76 1b                	jbe    80105e58 <argptr+0x58>
80105e3d:	01 c3                	add    %eax,%ebx
80105e3f:	39 da                	cmp    %ebx,%edx
80105e41:	72 15                	jb     80105e58 <argptr+0x58>
    return -1;
  *pp = (char*)i;
80105e43:	8b 55 0c             	mov    0xc(%ebp),%edx
80105e46:	89 02                	mov    %eax,(%edx)
  return 0;
80105e48:	31 c0                	xor    %eax,%eax
}
80105e4a:	83 c4 20             	add    $0x20,%esp
80105e4d:	5b                   	pop    %ebx
80105e4e:	5e                   	pop    %esi
80105e4f:	5d                   	pop    %ebp
80105e50:	c3                   	ret    
80105e51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
80105e58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e5d:	eb eb                	jmp    80105e4a <argptr+0x4a>
80105e5f:	90                   	nop

80105e60 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105e60:	55                   	push   %ebp
80105e61:	89 e5                	mov    %esp,%ebp
80105e63:	83 ec 28             	sub    $0x28,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105e66:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e69:	89 44 24 04          	mov    %eax,0x4(%esp)
80105e6d:	8b 45 08             	mov    0x8(%ebp),%eax
80105e70:	89 04 24             	mov    %eax,(%esp)
80105e73:	e8 38 ff ff ff       	call   80105db0 <argint>
80105e78:	85 c0                	test   %eax,%eax
80105e7a:	78 14                	js     80105e90 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80105e7c:	8b 45 0c             	mov    0xc(%ebp),%eax
80105e7f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105e83:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e86:	89 04 24             	mov    %eax,(%esp)
80105e89:	e8 d2 fe ff ff       	call   80105d60 <fetchstr>
}
80105e8e:	c9                   	leave  
80105e8f:	c3                   	ret    
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80105e90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80105e95:	c9                   	leave  
80105e96:	c3                   	ret    
80105e97:	89 f6                	mov    %esi,%esi
80105e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ea0 <syscall>:
[SYS_wait_stat]    sys_wait_stat,
};

void
syscall(void)
{
80105ea0:	55                   	push   %ebp
80105ea1:	89 e5                	mov    %esp,%ebp
80105ea3:	83 ec 18             	sub    $0x18,%esp
80105ea6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105ea9:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int num;
  struct proc *curproc = myproc();
80105eac:	e8 1f db ff ff       	call   801039d0 <myproc>

  num = curproc->tf->eax;
80105eb1:	8b 70 18             	mov    0x18(%eax),%esi

void
syscall(void)
{
  int num;
  struct proc *curproc = myproc();
80105eb4:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80105eb6:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105eb9:	8d 50 ff             	lea    -0x1(%eax),%edx
80105ebc:	83 fa 18             	cmp    $0x18,%edx
80105ebf:	77 1f                	ja     80105ee0 <syscall+0x40>
80105ec1:	8b 14 85 60 8e 10 80 	mov    -0x7fef71a0(,%eax,4),%edx
80105ec8:	85 d2                	test   %edx,%edx
80105eca:	74 14                	je     80105ee0 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80105ecc:	ff d2                	call   *%edx
80105ece:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105ed1:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105ed4:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105ed7:	89 ec                	mov    %ebp,%esp
80105ed9:	5d                   	pop    %ebp
80105eda:	c3                   	ret    
80105edb:	90                   	nop
80105edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80105ee0:	89 44 24 0c          	mov    %eax,0xc(%esp)
            curproc->pid, curproc->name, num);
80105ee4:	8d 43 6c             	lea    0x6c(%ebx),%eax
80105ee7:	89 44 24 08          	mov    %eax,0x8(%esp)

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80105eeb:	8b 43 10             	mov    0x10(%ebx),%eax
80105eee:	c7 04 24 3c 8e 10 80 	movl   $0x80108e3c,(%esp)
80105ef5:	89 44 24 04          	mov    %eax,0x4(%esp)
80105ef9:	e8 42 a7 ff ff       	call   80100640 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
80105efe:	8b 43 18             	mov    0x18(%ebx),%eax
80105f01:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80105f08:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105f0b:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105f0e:	89 ec                	mov    %ebp,%esp
80105f10:	5d                   	pop    %ebp
80105f11:	c3                   	ret    
80105f12:	66 90                	xchg   %ax,%ax
80105f14:	66 90                	xchg   %ax,%ax
80105f16:	66 90                	xchg   %ax,%ax
80105f18:	66 90                	xchg   %ax,%ax
80105f1a:	66 90                	xchg   %ax,%ax
80105f1c:	66 90                	xchg   %ax,%ax
80105f1e:	66 90                	xchg   %ax,%ax

80105f20 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105f20:	55                   	push   %ebp
80105f21:	0f bf d2             	movswl %dx,%edx
80105f24:	89 e5                	mov    %esp,%ebp
80105f26:	83 ec 58             	sub    $0x58,%esp
80105f29:	89 7d fc             	mov    %edi,-0x4(%ebp)
80105f2c:	0f bf 7d 08          	movswl 0x8(%ebp),%edi
80105f30:	0f bf c9             	movswl %cx,%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105f33:	89 04 24             	mov    %eax,(%esp)
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105f36:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80105f39:	89 75 f8             	mov    %esi,-0x8(%ebp)
80105f3c:	89 7d bc             	mov    %edi,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105f3f:	8d 7d da             	lea    -0x26(%ebp),%edi
80105f42:	89 7c 24 04          	mov    %edi,0x4(%esp)
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105f46:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80105f49:	89 4d c0             	mov    %ecx,-0x40(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105f4c:	e8 5f c0 ff ff       	call   80101fb0 <nameiparent>
80105f51:	85 c0                	test   %eax,%eax
80105f53:	0f 84 ef 00 00 00    	je     80106048 <create+0x128>
    return 0;
  ilock(dp);
80105f59:	89 04 24             	mov    %eax,(%esp)
80105f5c:	89 c3                	mov    %eax,%ebx
80105f5e:	e8 8d b7 ff ff       	call   801016f0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80105f63:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80105f66:	89 44 24 08          	mov    %eax,0x8(%esp)
80105f6a:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105f6e:	89 1c 24             	mov    %ebx,(%esp)
80105f71:	e8 da bc ff ff       	call   80101c50 <dirlookup>
80105f76:	85 c0                	test   %eax,%eax
80105f78:	89 c6                	mov    %eax,%esi
80105f7a:	74 54                	je     80105fd0 <create+0xb0>
    iunlockput(dp);
80105f7c:	89 1c 24             	mov    %ebx,(%esp)
80105f7f:	e8 fc b9 ff ff       	call   80101980 <iunlockput>
    ilock(ip);
80105f84:	89 34 24             	mov    %esi,(%esp)
80105f87:	e8 64 b7 ff ff       	call   801016f0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105f8c:	83 7d c4 02          	cmpl   $0x2,-0x3c(%ebp)
80105f90:	75 1e                	jne    80105fb0 <create+0x90>
80105f92:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80105f97:	89 f0                	mov    %esi,%eax
80105f99:	75 15                	jne    80105fb0 <create+0x90>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105f9b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105f9e:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105fa1:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105fa4:	89 ec                	mov    %ebp,%esp
80105fa6:	5d                   	pop    %ebp
80105fa7:	c3                   	ret    
80105fa8:	90                   	nop
80105fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80105fb0:	89 34 24             	mov    %esi,(%esp)
80105fb3:	e8 c8 b9 ff ff       	call   80101980 <iunlockput>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105fb8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
80105fbb:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105fbd:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105fc0:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105fc3:	89 ec                	mov    %ebp,%esp
80105fc5:	5d                   	pop    %ebp
80105fc6:	c3                   	ret    
80105fc7:	89 f6                	mov    %esi,%esi
80105fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80105fd0:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80105fd3:	89 44 24 04          	mov    %eax,0x4(%esp)
80105fd7:	8b 03                	mov    (%ebx),%eax
80105fd9:	89 04 24             	mov    %eax,(%esp)
80105fdc:	e8 8f b5 ff ff       	call   80101570 <ialloc>
80105fe1:	85 c0                	test   %eax,%eax
80105fe3:	89 c6                	mov    %eax,%esi
80105fe5:	0f 84 c1 00 00 00    	je     801060ac <create+0x18c>
    panic("create: ialloc");

  ilock(ip);
80105feb:	89 04 24             	mov    %eax,(%esp)
80105fee:	e8 fd b6 ff ff       	call   801016f0 <ilock>
  ip->major = major;
80105ff3:	8b 45 c0             	mov    -0x40(%ebp),%eax
  ip->minor = minor;
  ip->nlink = 1;
80105ff6:	66 c7 46 56 01 00    	movw   $0x1,0x56(%esi)

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");

  ilock(ip);
  ip->major = major;
80105ffc:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80106000:	8b 45 bc             	mov    -0x44(%ebp),%eax
80106003:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
  iupdate(ip);
80106007:	89 34 24             	mov    %esi,(%esp)
8010600a:	e8 21 b6 ff ff       	call   80101630 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
8010600f:	83 7d c4 01          	cmpl   $0x1,-0x3c(%ebp)
80106013:	74 3b                	je     80106050 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80106015:	8b 46 04             	mov    0x4(%esi),%eax
80106018:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010601c:	89 1c 24             	mov    %ebx,(%esp)
8010601f:	89 44 24 08          	mov    %eax,0x8(%esp)
80106023:	e8 88 be ff ff       	call   80101eb0 <dirlink>
80106028:	85 c0                	test   %eax,%eax
8010602a:	78 74                	js     801060a0 <create+0x180>
    panic("create: dirlink");

  iunlockput(dp);
8010602c:	89 1c 24             	mov    %ebx,(%esp)
8010602f:	e8 4c b9 ff ff       	call   80101980 <iunlockput>

  return ip;
80106034:	89 f0                	mov    %esi,%eax
}
80106036:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80106039:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010603c:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010603f:	89 ec                	mov    %ebp,%esp
80106041:	5d                   	pop    %ebp
80106042:	c3                   	ret    
80106043:	90                   	nop
80106044:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80106048:	31 c0                	xor    %eax,%eax
8010604a:	e9 4c ff ff ff       	jmp    80105f9b <create+0x7b>
8010604f:	90                   	nop
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80106050:	66 ff 43 56          	incw   0x56(%ebx)
    iupdate(dp);
80106054:	89 1c 24             	mov    %ebx,(%esp)
80106057:	e8 d4 b5 ff ff       	call   80101630 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010605c:	8b 46 04             	mov    0x4(%esi),%eax
8010605f:	ba e4 8e 10 80       	mov    $0x80108ee4,%edx
80106064:	89 54 24 04          	mov    %edx,0x4(%esp)
80106068:	89 34 24             	mov    %esi,(%esp)
8010606b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010606f:	e8 3c be ff ff       	call   80101eb0 <dirlink>
80106074:	85 c0                	test   %eax,%eax
80106076:	78 1c                	js     80106094 <create+0x174>
80106078:	8b 43 04             	mov    0x4(%ebx),%eax
8010607b:	89 34 24             	mov    %esi,(%esp)
8010607e:	89 44 24 08          	mov    %eax,0x8(%esp)
80106082:	b8 e3 8e 10 80       	mov    $0x80108ee3,%eax
80106087:	89 44 24 04          	mov    %eax,0x4(%esp)
8010608b:	e8 20 be ff ff       	call   80101eb0 <dirlink>
80106090:	85 c0                	test   %eax,%eax
80106092:	79 81                	jns    80106015 <create+0xf5>
      panic("create dots");
80106094:	c7 04 24 d7 8e 10 80 	movl   $0x80108ed7,(%esp)
8010609b:	e8 a0 a2 ff ff       	call   80100340 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
801060a0:	c7 04 24 e6 8e 10 80 	movl   $0x80108ee6,(%esp)
801060a7:	e8 94 a2 ff ff       	call   80100340 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
801060ac:	c7 04 24 c8 8e 10 80 	movl   $0x80108ec8,(%esp)
801060b3:	e8 88 a2 ff ff       	call   80100340 <panic>
801060b8:	90                   	nop
801060b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801060c0 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
801060c0:	55                   	push   %ebp
801060c1:	89 e5                	mov    %esp,%ebp
801060c3:	56                   	push   %esi
801060c4:	89 c6                	mov    %eax,%esi
801060c6:	53                   	push   %ebx
801060c7:	89 d3                	mov    %edx,%ebx
801060c9:	83 ec 20             	sub    $0x20,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
801060cc:	8d 45 f4             	lea    -0xc(%ebp),%eax
801060cf:	89 44 24 04          	mov    %eax,0x4(%esp)
801060d3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801060da:	e8 d1 fc ff ff       	call   80105db0 <argint>
801060df:	85 c0                	test   %eax,%eax
801060e1:	78 2d                	js     80106110 <argfd.constprop.0+0x50>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801060e3:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801060e7:	77 27                	ja     80106110 <argfd.constprop.0+0x50>
801060e9:	e8 e2 d8 ff ff       	call   801039d0 <myproc>
801060ee:	8b 55 f4             	mov    -0xc(%ebp),%edx
801060f1:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
801060f5:	85 c0                	test   %eax,%eax
801060f7:	74 17                	je     80106110 <argfd.constprop.0+0x50>
    return -1;
  if(pfd)
801060f9:	85 f6                	test   %esi,%esi
801060fb:	74 02                	je     801060ff <argfd.constprop.0+0x3f>
    *pfd = fd;
801060fd:	89 16                	mov    %edx,(%esi)
  if(pf)
801060ff:	85 db                	test   %ebx,%ebx
80106101:	74 1d                	je     80106120 <argfd.constprop.0+0x60>
    *pf = f;
80106103:	89 03                	mov    %eax,(%ebx)
  return 0;
80106105:	31 c0                	xor    %eax,%eax
}
80106107:	83 c4 20             	add    $0x20,%esp
8010610a:	5b                   	pop    %ebx
8010610b:	5e                   	pop    %esi
8010610c:	5d                   	pop    %ebp
8010610d:	c3                   	ret    
8010610e:	66 90                	xchg   %ax,%ax
80106110:	83 c4 20             	add    $0x20,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
80106113:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
80106118:	5b                   	pop    %ebx
80106119:	5e                   	pop    %esi
8010611a:	5d                   	pop    %ebp
8010611b:	c3                   	ret    
8010611c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
80106120:	31 c0                	xor    %eax,%eax
80106122:	eb e3                	jmp    80106107 <argfd.constprop.0+0x47>
80106124:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010612a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106130 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80106130:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80106131:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80106133:	89 e5                	mov    %esp,%ebp
80106135:	56                   	push   %esi
80106136:	53                   	push   %ebx
80106137:	83 ec 20             	sub    $0x20,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
8010613a:	8d 55 f4             	lea    -0xc(%ebp),%edx
8010613d:	e8 7e ff ff ff       	call   801060c0 <argfd.constprop.0>
80106142:	85 c0                	test   %eax,%eax
80106144:	78 18                	js     8010615e <sys_dup+0x2e>
    return -1;
  if((fd=fdalloc(f)) < 0)
80106146:	8b 75 f4             	mov    -0xc(%ebp),%esi
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80106149:	31 db                	xor    %ebx,%ebx
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
8010614b:	e8 80 d8 ff ff       	call   801039d0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80106150:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80106154:	85 d2                	test   %edx,%edx
80106156:	74 18                	je     80106170 <sys_dup+0x40>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80106158:	43                   	inc    %ebx
80106159:	83 fb 10             	cmp    $0x10,%ebx
8010615c:	75 f2                	jne    80106150 <sys_dup+0x20>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
8010615e:	83 c4 20             	add    $0x20,%esp
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80106161:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80106166:	5b                   	pop    %ebx
80106167:	5e                   	pop    %esi
80106168:	5d                   	pop    %ebp
80106169:	c3                   	ret    
8010616a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80106170:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80106174:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106177:	89 04 24             	mov    %eax,(%esp)
8010617a:	e8 51 ac ff ff       	call   80100dd0 <filedup>
  return fd;
}
8010617f:	83 c4 20             	add    $0x20,%esp
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
80106182:	89 d8                	mov    %ebx,%eax
}
80106184:	5b                   	pop    %ebx
80106185:	5e                   	pop    %esi
80106186:	5d                   	pop    %ebp
80106187:	c3                   	ret    
80106188:	90                   	nop
80106189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106190 <sys_read>:

int
sys_read(void)
{
80106190:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106191:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80106193:	89 e5                	mov    %esp,%ebp
80106195:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106198:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010619b:	e8 20 ff ff ff       	call   801060c0 <argfd.constprop.0>
801061a0:	85 c0                	test   %eax,%eax
801061a2:	78 54                	js     801061f8 <sys_read+0x68>
801061a4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801061a7:	89 44 24 04          	mov    %eax,0x4(%esp)
801061ab:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801061b2:	e8 f9 fb ff ff       	call   80105db0 <argint>
801061b7:	85 c0                	test   %eax,%eax
801061b9:	78 3d                	js     801061f8 <sys_read+0x68>
801061bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061be:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801061c5:	89 44 24 08          	mov    %eax,0x8(%esp)
801061c9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801061cc:	89 44 24 04          	mov    %eax,0x4(%esp)
801061d0:	e8 2b fc ff ff       	call   80105e00 <argptr>
801061d5:	85 c0                	test   %eax,%eax
801061d7:	78 1f                	js     801061f8 <sys_read+0x68>
    return -1;
  return fileread(f, p, n);
801061d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061dc:	89 44 24 08          	mov    %eax,0x8(%esp)
801061e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801061e3:	89 44 24 04          	mov    %eax,0x4(%esp)
801061e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801061ea:	89 04 24             	mov    %eax,(%esp)
801061ed:	e8 5e ad ff ff       	call   80100f50 <fileread>
}
801061f2:	c9                   	leave  
801061f3:	c3                   	ret    
801061f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
801061f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
801061fd:	c9                   	leave  
801061fe:	c3                   	ret    
801061ff:	90                   	nop

80106200 <sys_write>:

int
sys_write(void)
{
80106200:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106201:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80106203:	89 e5                	mov    %esp,%ebp
80106205:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106208:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010620b:	e8 b0 fe ff ff       	call   801060c0 <argfd.constprop.0>
80106210:	85 c0                	test   %eax,%eax
80106212:	78 54                	js     80106268 <sys_write+0x68>
80106214:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106217:	89 44 24 04          	mov    %eax,0x4(%esp)
8010621b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106222:	e8 89 fb ff ff       	call   80105db0 <argint>
80106227:	85 c0                	test   %eax,%eax
80106229:	78 3d                	js     80106268 <sys_write+0x68>
8010622b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010622e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106235:	89 44 24 08          	mov    %eax,0x8(%esp)
80106239:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010623c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106240:	e8 bb fb ff ff       	call   80105e00 <argptr>
80106245:	85 c0                	test   %eax,%eax
80106247:	78 1f                	js     80106268 <sys_write+0x68>
    return -1;
  return filewrite(f, p, n);
80106249:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010624c:	89 44 24 08          	mov    %eax,0x8(%esp)
80106250:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106253:	89 44 24 04          	mov    %eax,0x4(%esp)
80106257:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010625a:	89 04 24             	mov    %eax,(%esp)
8010625d:	e8 9e ad ff ff       	call   80101000 <filewrite>
}
80106262:	c9                   	leave  
80106263:	c3                   	ret    
80106264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80106268:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
8010626d:	c9                   	leave  
8010626e:	c3                   	ret    
8010626f:	90                   	nop

80106270 <sys_close>:

int
sys_close(void)
{
80106270:	55                   	push   %ebp
80106271:	89 e5                	mov    %esp,%ebp
80106273:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80106276:	8d 55 f4             	lea    -0xc(%ebp),%edx
80106279:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010627c:	e8 3f fe ff ff       	call   801060c0 <argfd.constprop.0>
80106281:	85 c0                	test   %eax,%eax
80106283:	78 23                	js     801062a8 <sys_close+0x38>
    return -1;
  myproc()->ofile[fd] = 0;
80106285:	e8 46 d7 ff ff       	call   801039d0 <myproc>
8010628a:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010628d:	31 c9                	xor    %ecx,%ecx
8010628f:	89 4c 90 28          	mov    %ecx,0x28(%eax,%edx,4)
  fileclose(f);
80106293:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106296:	89 04 24             	mov    %eax,(%esp)
80106299:	e8 82 ab ff ff       	call   80100e20 <fileclose>
  return 0;
8010629e:	31 c0                	xor    %eax,%eax
}
801062a0:	c9                   	leave  
801062a1:	c3                   	ret    
801062a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
801062a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
801062ad:	c9                   	leave  
801062ae:	c3                   	ret    
801062af:	90                   	nop

801062b0 <sys_fstat>:

int
sys_fstat(void)
{
801062b0:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801062b1:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
801062b3:	89 e5                	mov    %esp,%ebp
801062b5:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801062b8:	8d 55 f0             	lea    -0x10(%ebp),%edx
801062bb:	e8 00 fe ff ff       	call   801060c0 <argfd.constprop.0>
801062c0:	85 c0                	test   %eax,%eax
801062c2:	78 3c                	js     80106300 <sys_fstat+0x50>
801062c4:	b8 14 00 00 00       	mov    $0x14,%eax
801062c9:	89 44 24 08          	mov    %eax,0x8(%esp)
801062cd:	8d 45 f4             	lea    -0xc(%ebp),%eax
801062d0:	89 44 24 04          	mov    %eax,0x4(%esp)
801062d4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801062db:	e8 20 fb ff ff       	call   80105e00 <argptr>
801062e0:	85 c0                	test   %eax,%eax
801062e2:	78 1c                	js     80106300 <sys_fstat+0x50>
    return -1;
  return filestat(f, st);
801062e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062e7:	89 44 24 04          	mov    %eax,0x4(%esp)
801062eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801062ee:	89 04 24             	mov    %eax,(%esp)
801062f1:	e8 0a ac ff ff       	call   80100f00 <filestat>
}
801062f6:	c9                   	leave  
801062f7:	c3                   	ret    
801062f8:	90                   	nop
801062f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80106300:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80106305:	c9                   	leave  
80106306:	c3                   	ret    
80106307:	89 f6                	mov    %esi,%esi
80106309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106310 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80106310:	55                   	push   %ebp
80106311:	89 e5                	mov    %esp,%ebp
80106313:	57                   	push   %edi
80106314:	56                   	push   %esi
80106315:	53                   	push   %ebx
80106316:	83 ec 3c             	sub    $0x3c,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80106319:	8d 45 d4             	lea    -0x2c(%ebp),%eax
8010631c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106320:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106327:	e8 34 fb ff ff       	call   80105e60 <argstr>
8010632c:	85 c0                	test   %eax,%eax
8010632e:	0f 88 e5 00 00 00    	js     80106419 <sys_link+0x109>
80106334:	8d 45 d0             	lea    -0x30(%ebp),%eax
80106337:	89 44 24 04          	mov    %eax,0x4(%esp)
8010633b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106342:	e8 19 fb ff ff       	call   80105e60 <argstr>
80106347:	85 c0                	test   %eax,%eax
80106349:	0f 88 ca 00 00 00    	js     80106419 <sys_link+0x109>
    return -1;

  begin_op();
8010634f:	e8 ac c8 ff ff       	call   80102c00 <begin_op>
  if((ip = namei(old)) == 0){
80106354:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80106357:	89 04 24             	mov    %eax,(%esp)
8010635a:	e8 31 bc ff ff       	call   80101f90 <namei>
8010635f:	85 c0                	test   %eax,%eax
80106361:	89 c3                	mov    %eax,%ebx
80106363:	0f 84 ab 00 00 00    	je     80106414 <sys_link+0x104>
    end_op();
    return -1;
  }

  ilock(ip);
80106369:	89 04 24             	mov    %eax,(%esp)
8010636c:	e8 7f b3 ff ff       	call   801016f0 <ilock>
  if(ip->type == T_DIR){
80106371:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106376:	0f 84 90 00 00 00    	je     8010640c <sys_link+0xfc>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
8010637c:	66 ff 43 56          	incw   0x56(%ebx)
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80106380:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80106383:	89 1c 24             	mov    %ebx,(%esp)
80106386:	e8 a5 b2 ff ff       	call   80101630 <iupdate>
  iunlock(ip);
8010638b:	89 1c 24             	mov    %ebx,(%esp)
8010638e:	e8 3d b4 ff ff       	call   801017d0 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80106393:	8b 45 d0             	mov    -0x30(%ebp),%eax
80106396:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010639a:	89 04 24             	mov    %eax,(%esp)
8010639d:	e8 0e bc ff ff       	call   80101fb0 <nameiparent>
801063a2:	85 c0                	test   %eax,%eax
801063a4:	89 c6                	mov    %eax,%esi
801063a6:	74 50                	je     801063f8 <sys_link+0xe8>
    goto bad;
  ilock(dp);
801063a8:	89 04 24             	mov    %eax,(%esp)
801063ab:	e8 40 b3 ff ff       	call   801016f0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801063b0:	8b 03                	mov    (%ebx),%eax
801063b2:	39 06                	cmp    %eax,(%esi)
801063b4:	75 3a                	jne    801063f0 <sys_link+0xe0>
801063b6:	8b 43 04             	mov    0x4(%ebx),%eax
801063b9:	89 7c 24 04          	mov    %edi,0x4(%esp)
801063bd:	89 34 24             	mov    %esi,(%esp)
801063c0:	89 44 24 08          	mov    %eax,0x8(%esp)
801063c4:	e8 e7 ba ff ff       	call   80101eb0 <dirlink>
801063c9:	85 c0                	test   %eax,%eax
801063cb:	78 23                	js     801063f0 <sys_link+0xe0>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
801063cd:	89 34 24             	mov    %esi,(%esp)
801063d0:	e8 ab b5 ff ff       	call   80101980 <iunlockput>
  iput(ip);
801063d5:	89 1c 24             	mov    %ebx,(%esp)
801063d8:	e8 43 b4 ff ff       	call   80101820 <iput>

  end_op();
801063dd:	e8 8e c8 ff ff       	call   80102c70 <end_op>
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
801063e2:	83 c4 3c             	add    $0x3c,%esp
  iunlockput(dp);
  iput(ip);

  end_op();

  return 0;
801063e5:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
801063e7:	5b                   	pop    %ebx
801063e8:	5e                   	pop    %esi
801063e9:	5f                   	pop    %edi
801063ea:	5d                   	pop    %ebp
801063eb:	c3                   	ret    
801063ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
801063f0:	89 34 24             	mov    %esi,(%esp)
801063f3:	e8 88 b5 ff ff       	call   80101980 <iunlockput>
  end_op();

  return 0;

bad:
  ilock(ip);
801063f8:	89 1c 24             	mov    %ebx,(%esp)
801063fb:	e8 f0 b2 ff ff       	call   801016f0 <ilock>
  ip->nlink--;
80106400:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
80106404:	89 1c 24             	mov    %ebx,(%esp)
80106407:	e8 24 b2 ff ff       	call   80101630 <iupdate>
  iunlockput(ip);
8010640c:	89 1c 24             	mov    %ebx,(%esp)
8010640f:	e8 6c b5 ff ff       	call   80101980 <iunlockput>
  end_op();
80106414:	e8 57 c8 ff ff       	call   80102c70 <end_op>
  return -1;
}
80106419:	83 c4 3c             	add    $0x3c,%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
8010641c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106421:	5b                   	pop    %ebx
80106422:	5e                   	pop    %esi
80106423:	5f                   	pop    %edi
80106424:	5d                   	pop    %ebp
80106425:	c3                   	ret    
80106426:	8d 76 00             	lea    0x0(%esi),%esi
80106429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106430 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80106430:	55                   	push   %ebp
80106431:	89 e5                	mov    %esp,%ebp
80106433:	57                   	push   %edi
80106434:	56                   	push   %esi
80106435:	53                   	push   %ebx
80106436:	83 ec 5c             	sub    $0x5c,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80106439:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010643c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106440:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106447:	e8 14 fa ff ff       	call   80105e60 <argstr>
8010644c:	85 c0                	test   %eax,%eax
8010644e:	0f 88 75 01 00 00    	js     801065c9 <sys_unlink+0x199>
    return -1;

  begin_op();
80106454:	e8 a7 c7 ff ff       	call   80102c00 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80106459:	8b 45 c0             	mov    -0x40(%ebp),%eax
8010645c:	8d 5d ca             	lea    -0x36(%ebp),%ebx
8010645f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80106463:	89 04 24             	mov    %eax,(%esp)
80106466:	e8 45 bb ff ff       	call   80101fb0 <nameiparent>
8010646b:	85 c0                	test   %eax,%eax
8010646d:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80106470:	0f 84 4e 01 00 00    	je     801065c4 <sys_unlink+0x194>
    end_op();
    return -1;
  }

  ilock(dp);
80106476:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80106479:	89 34 24             	mov    %esi,(%esp)
8010647c:	e8 6f b2 ff ff       	call   801016f0 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80106481:	b8 e4 8e 10 80       	mov    $0x80108ee4,%eax
80106486:	89 44 24 04          	mov    %eax,0x4(%esp)
8010648a:	89 1c 24             	mov    %ebx,(%esp)
8010648d:	e8 8e b7 ff ff       	call   80101c20 <namecmp>
80106492:	85 c0                	test   %eax,%eax
80106494:	0f 84 1f 01 00 00    	je     801065b9 <sys_unlink+0x189>
8010649a:	b8 e3 8e 10 80       	mov    $0x80108ee3,%eax
8010649f:	89 44 24 04          	mov    %eax,0x4(%esp)
801064a3:	89 1c 24             	mov    %ebx,(%esp)
801064a6:	e8 75 b7 ff ff       	call   80101c20 <namecmp>
801064ab:	85 c0                	test   %eax,%eax
801064ad:	0f 84 06 01 00 00    	je     801065b9 <sys_unlink+0x189>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
801064b3:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801064b6:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801064ba:	89 44 24 08          	mov    %eax,0x8(%esp)
801064be:	89 34 24             	mov    %esi,(%esp)
801064c1:	e8 8a b7 ff ff       	call   80101c50 <dirlookup>
801064c6:	85 c0                	test   %eax,%eax
801064c8:	89 c3                	mov    %eax,%ebx
801064ca:	0f 84 e9 00 00 00    	je     801065b9 <sys_unlink+0x189>
    goto bad;
  ilock(ip);
801064d0:	89 04 24             	mov    %eax,(%esp)
801064d3:	e8 18 b2 ff ff       	call   801016f0 <ilock>

  if(ip->nlink < 1)
801064d8:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801064dd:	0f 8e 29 01 00 00    	jle    8010660c <sys_unlink+0x1dc>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
801064e3:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801064e8:	8d 75 d8             	lea    -0x28(%ebp),%esi
801064eb:	74 7b                	je     80106568 <sys_unlink+0x138>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
801064ed:	31 d2                	xor    %edx,%edx
801064ef:	b8 10 00 00 00       	mov    $0x10,%eax
801064f4:	89 54 24 04          	mov    %edx,0x4(%esp)
801064f8:	89 44 24 08          	mov    %eax,0x8(%esp)
801064fc:	89 34 24             	mov    %esi,(%esp)
801064ff:	e8 bc f5 ff ff       	call   80105ac0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80106504:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80106507:	b9 10 00 00 00       	mov    $0x10,%ecx
8010650c:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80106510:	89 74 24 04          	mov    %esi,0x4(%esp)
80106514:	89 44 24 08          	mov    %eax,0x8(%esp)
80106518:	8b 45 b4             	mov    -0x4c(%ebp),%eax
8010651b:	89 04 24             	mov    %eax,(%esp)
8010651e:	e8 bd b5 ff ff       	call   80101ae0 <writei>
80106523:	83 f8 10             	cmp    $0x10,%eax
80106526:	0f 85 d4 00 00 00    	jne    80106600 <sys_unlink+0x1d0>
    panic("unlink: writei");
  if(ip->type == T_DIR){
8010652c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106531:	0f 84 a9 00 00 00    	je     801065e0 <sys_unlink+0x1b0>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
80106537:	8b 45 b4             	mov    -0x4c(%ebp),%eax
8010653a:	89 04 24             	mov    %eax,(%esp)
8010653d:	e8 3e b4 ff ff       	call   80101980 <iunlockput>

  ip->nlink--;
80106542:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
80106546:	89 1c 24             	mov    %ebx,(%esp)
80106549:	e8 e2 b0 ff ff       	call   80101630 <iupdate>
  iunlockput(ip);
8010654e:	89 1c 24             	mov    %ebx,(%esp)
80106551:	e8 2a b4 ff ff       	call   80101980 <iunlockput>

  end_op();
80106556:	e8 15 c7 ff ff       	call   80102c70 <end_op>

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
8010655b:	83 c4 5c             	add    $0x5c,%esp
  iupdate(ip);
  iunlockput(ip);

  end_op();

  return 0;
8010655e:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80106560:	5b                   	pop    %ebx
80106561:	5e                   	pop    %esi
80106562:	5f                   	pop    %edi
80106563:	5d                   	pop    %ebp
80106564:	c3                   	ret    
80106565:	8d 76 00             	lea    0x0(%esi),%esi
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80106568:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
8010656c:	0f 86 7b ff ff ff    	jbe    801064ed <sys_unlink+0xbd>
80106572:	bf 20 00 00 00       	mov    $0x20,%edi
80106577:	eb 13                	jmp    8010658c <sys_unlink+0x15c>
80106579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106580:	83 c7 10             	add    $0x10,%edi
80106583:	3b 7b 58             	cmp    0x58(%ebx),%edi
80106586:	0f 83 61 ff ff ff    	jae    801064ed <sys_unlink+0xbd>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010658c:	b8 10 00 00 00       	mov    $0x10,%eax
80106591:	89 44 24 0c          	mov    %eax,0xc(%esp)
80106595:	89 7c 24 08          	mov    %edi,0x8(%esp)
80106599:	89 74 24 04          	mov    %esi,0x4(%esp)
8010659d:	89 1c 24             	mov    %ebx,(%esp)
801065a0:	e8 2b b4 ff ff       	call   801019d0 <readi>
801065a5:	83 f8 10             	cmp    $0x10,%eax
801065a8:	75 4a                	jne    801065f4 <sys_unlink+0x1c4>
      panic("isdirempty: readi");
    if(de.inum != 0)
801065aa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801065af:	74 cf                	je     80106580 <sys_unlink+0x150>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
801065b1:	89 1c 24             	mov    %ebx,(%esp)
801065b4:	e8 c7 b3 ff ff       	call   80101980 <iunlockput>
  end_op();

  return 0;

bad:
  iunlockput(dp);
801065b9:	8b 45 b4             	mov    -0x4c(%ebp),%eax
801065bc:	89 04 24             	mov    %eax,(%esp)
801065bf:	e8 bc b3 ff ff       	call   80101980 <iunlockput>
  end_op();
801065c4:	e8 a7 c6 ff ff       	call   80102c70 <end_op>
  return -1;
}
801065c9:	83 c4 5c             	add    $0x5c,%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
801065cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801065d1:	5b                   	pop    %ebx
801065d2:	5e                   	pop    %esi
801065d3:	5f                   	pop    %edi
801065d4:	5d                   	pop    %ebp
801065d5:	c3                   	ret    
801065d6:	8d 76 00             	lea    0x0(%esi),%esi
801065d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
801065e0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
801065e3:	66 ff 48 56          	decw   0x56(%eax)
    iupdate(dp);
801065e7:	89 04 24             	mov    %eax,(%esp)
801065ea:	e8 41 b0 ff ff       	call   80101630 <iupdate>
801065ef:	e9 43 ff ff ff       	jmp    80106537 <sys_unlink+0x107>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
801065f4:	c7 04 24 08 8f 10 80 	movl   $0x80108f08,(%esp)
801065fb:	e8 40 9d ff ff       	call   80100340 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
80106600:	c7 04 24 1a 8f 10 80 	movl   $0x80108f1a,(%esp)
80106607:	e8 34 9d ff ff       	call   80100340 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
8010660c:	c7 04 24 f6 8e 10 80 	movl   $0x80108ef6,(%esp)
80106613:	e8 28 9d ff ff       	call   80100340 <panic>
80106618:	90                   	nop
80106619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106620 <sys_open>:
  return ip;
}

int
sys_open(void)
{
80106620:	55                   	push   %ebp
80106621:	89 e5                	mov    %esp,%ebp
80106623:	57                   	push   %edi
80106624:	56                   	push   %esi
80106625:	53                   	push   %ebx
80106626:	83 ec 2c             	sub    $0x2c,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106629:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010662c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106630:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106637:	e8 24 f8 ff ff       	call   80105e60 <argstr>
8010663c:	85 c0                	test   %eax,%eax
8010663e:	0f 88 7f 00 00 00    	js     801066c3 <sys_open+0xa3>
80106644:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106647:	89 44 24 04          	mov    %eax,0x4(%esp)
8010664b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106652:	e8 59 f7 ff ff       	call   80105db0 <argint>
80106657:	85 c0                	test   %eax,%eax
80106659:	78 68                	js     801066c3 <sys_open+0xa3>
    return -1;

  begin_op();
8010665b:	e8 a0 c5 ff ff       	call   80102c00 <begin_op>

  if(omode & O_CREATE){
80106660:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80106664:	75 6a                	jne    801066d0 <sys_open+0xb0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80106666:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106669:	89 04 24             	mov    %eax,(%esp)
8010666c:	e8 1f b9 ff ff       	call   80101f90 <namei>
80106671:	85 c0                	test   %eax,%eax
80106673:	89 c6                	mov    %eax,%esi
80106675:	74 47                	je     801066be <sys_open+0x9e>
      end_op();
      return -1;
    }
    ilock(ip);
80106677:	89 04 24             	mov    %eax,(%esp)
8010667a:	e8 71 b0 ff ff       	call   801016f0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
8010667f:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80106684:	0f 84 a6 00 00 00    	je     80106730 <sys_open+0x110>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010668a:	e8 d1 a6 ff ff       	call   80100d60 <filealloc>
8010668f:	85 c0                	test   %eax,%eax
80106691:	89 c7                	mov    %eax,%edi
80106693:	74 21                	je     801066b6 <sys_open+0x96>
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80106695:	e8 36 d3 ff ff       	call   801039d0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
8010669a:	31 db                	xor    %ebx,%ebx
8010669c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801066a0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801066a4:	85 d2                	test   %edx,%edx
801066a6:	74 48                	je     801066f0 <sys_open+0xd0>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801066a8:	43                   	inc    %ebx
801066a9:	83 fb 10             	cmp    $0x10,%ebx
801066ac:	75 f2                	jne    801066a0 <sys_open+0x80>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
801066ae:	89 3c 24             	mov    %edi,(%esp)
801066b1:	e8 6a a7 ff ff       	call   80100e20 <fileclose>
    iunlockput(ip);
801066b6:	89 34 24             	mov    %esi,(%esp)
801066b9:	e8 c2 b2 ff ff       	call   80101980 <iunlockput>
    end_op();
801066be:	e8 ad c5 ff ff       	call   80102c70 <end_op>
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
801066c3:	83 c4 2c             	add    $0x2c,%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
801066c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
801066cb:	5b                   	pop    %ebx
801066cc:	5e                   	pop    %esi
801066cd:	5f                   	pop    %edi
801066ce:	5d                   	pop    %ebp
801066cf:	c3                   	ret    
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
801066d0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801066d3:	31 c9                	xor    %ecx,%ecx
801066d5:	ba 02 00 00 00       	mov    $0x2,%edx
801066da:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801066e1:	e8 3a f8 ff ff       	call   80105f20 <create>
    if(ip == 0){
801066e6:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
801066e8:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801066ea:	75 9e                	jne    8010668a <sys_open+0x6a>
801066ec:	eb d0                	jmp    801066be <sys_open+0x9e>
801066ee:	66 90                	xchg   %ax,%ax
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
801066f0:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801066f4:	89 34 24             	mov    %esi,(%esp)
801066f7:	e8 d4 b0 ff ff       	call   801017d0 <iunlock>
  end_op();
801066fc:	e8 6f c5 ff ff       	call   80102c70 <end_op>

  f->type = FD_INODE;
80106701:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80106707:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
8010670a:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
8010670d:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80106714:	89 d0                	mov    %edx,%eax
80106716:	83 e0 01             	and    $0x1,%eax
80106719:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010671c:	f6 c2 03             	test   $0x3,%dl
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
8010671f:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
80106722:	89 d8                	mov    %ebx,%eax

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106724:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80106728:	83 c4 2c             	add    $0x2c,%esp
8010672b:	5b                   	pop    %ebx
8010672c:	5e                   	pop    %esi
8010672d:	5f                   	pop    %edi
8010672e:	5d                   	pop    %ebp
8010672f:	c3                   	ret    
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
80106730:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106733:	85 c9                	test   %ecx,%ecx
80106735:	0f 84 4f ff ff ff    	je     8010668a <sys_open+0x6a>
8010673b:	e9 76 ff ff ff       	jmp    801066b6 <sys_open+0x96>

80106740 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80106740:	55                   	push   %ebp
80106741:	89 e5                	mov    %esp,%ebp
80106743:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
80106746:	e8 b5 c4 ff ff       	call   80102c00 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010674b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010674e:	89 44 24 04          	mov    %eax,0x4(%esp)
80106752:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106759:	e8 02 f7 ff ff       	call   80105e60 <argstr>
8010675e:	85 c0                	test   %eax,%eax
80106760:	78 2e                	js     80106790 <sys_mkdir+0x50>
80106762:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106765:	31 c9                	xor    %ecx,%ecx
80106767:	ba 01 00 00 00       	mov    $0x1,%edx
8010676c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106773:	e8 a8 f7 ff ff       	call   80105f20 <create>
80106778:	85 c0                	test   %eax,%eax
8010677a:	74 14                	je     80106790 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010677c:	89 04 24             	mov    %eax,(%esp)
8010677f:	e8 fc b1 ff ff       	call   80101980 <iunlockput>
  end_op();
80106784:	e8 e7 c4 ff ff       	call   80102c70 <end_op>
  return 0;
80106789:	31 c0                	xor    %eax,%eax
}
8010678b:	c9                   	leave  
8010678c:	c3                   	ret    
8010678d:	8d 76 00             	lea    0x0(%esi),%esi
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
80106790:	e8 db c4 ff ff       	call   80102c70 <end_op>
    return -1;
80106795:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010679a:	c9                   	leave  
8010679b:	c3                   	ret    
8010679c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801067a0 <sys_mknod>:

int
sys_mknod(void)
{
801067a0:	55                   	push   %ebp
801067a1:	89 e5                	mov    %esp,%ebp
801067a3:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801067a6:	e8 55 c4 ff ff       	call   80102c00 <begin_op>
  if((argstr(0, &path)) < 0 ||
801067ab:	8d 45 ec             	lea    -0x14(%ebp),%eax
801067ae:	89 44 24 04          	mov    %eax,0x4(%esp)
801067b2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801067b9:	e8 a2 f6 ff ff       	call   80105e60 <argstr>
801067be:	85 c0                	test   %eax,%eax
801067c0:	78 5e                	js     80106820 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801067c2:	8d 45 f0             	lea    -0x10(%ebp),%eax
801067c5:	89 44 24 04          	mov    %eax,0x4(%esp)
801067c9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801067d0:	e8 db f5 ff ff       	call   80105db0 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
801067d5:	85 c0                	test   %eax,%eax
801067d7:	78 47                	js     80106820 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
801067d9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801067dc:	89 44 24 04          	mov    %eax,0x4(%esp)
801067e0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801067e7:	e8 c4 f5 ff ff       	call   80105db0 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
801067ec:	85 c0                	test   %eax,%eax
801067ee:	78 30                	js     80106820 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801067f0:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801067f4:	ba 03 00 00 00       	mov    $0x3,%edx
801067f9:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801067fd:	89 04 24             	mov    %eax,(%esp)
80106800:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106803:	e8 18 f7 ff ff       	call   80105f20 <create>
80106808:	85 c0                	test   %eax,%eax
8010680a:	74 14                	je     80106820 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
8010680c:	89 04 24             	mov    %eax,(%esp)
8010680f:	e8 6c b1 ff ff       	call   80101980 <iunlockput>
  end_op();
80106814:	e8 57 c4 ff ff       	call   80102c70 <end_op>
  return 0;
80106819:	31 c0                	xor    %eax,%eax
}
8010681b:	c9                   	leave  
8010681c:	c3                   	ret    
8010681d:	8d 76 00             	lea    0x0(%esi),%esi
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80106820:	e8 4b c4 ff ff       	call   80102c70 <end_op>
    return -1;
80106825:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010682a:	c9                   	leave  
8010682b:	c3                   	ret    
8010682c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106830 <sys_chdir>:

int
sys_chdir(void)
{
80106830:	55                   	push   %ebp
80106831:	89 e5                	mov    %esp,%ebp
80106833:	56                   	push   %esi
80106834:	53                   	push   %ebx
80106835:	83 ec 20             	sub    $0x20,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80106838:	e8 93 d1 ff ff       	call   801039d0 <myproc>
8010683d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010683f:	e8 bc c3 ff ff       	call   80102c00 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106844:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106847:	89 44 24 04          	mov    %eax,0x4(%esp)
8010684b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106852:	e8 09 f6 ff ff       	call   80105e60 <argstr>
80106857:	85 c0                	test   %eax,%eax
80106859:	78 4a                	js     801068a5 <sys_chdir+0x75>
8010685b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010685e:	89 04 24             	mov    %eax,(%esp)
80106861:	e8 2a b7 ff ff       	call   80101f90 <namei>
80106866:	85 c0                	test   %eax,%eax
80106868:	89 c3                	mov    %eax,%ebx
8010686a:	74 39                	je     801068a5 <sys_chdir+0x75>
    end_op();
    return -1;
  }
  ilock(ip);
8010686c:	89 04 24             	mov    %eax,(%esp)
8010686f:	e8 7c ae ff ff       	call   801016f0 <ilock>
  if(ip->type != T_DIR){
80106874:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
    iunlockput(ip);
80106879:	89 1c 24             	mov    %ebx,(%esp)
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
8010687c:	75 22                	jne    801068a0 <sys_chdir+0x70>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
8010687e:	e8 4d af ff ff       	call   801017d0 <iunlock>
  iput(curproc->cwd);
80106883:	8b 46 68             	mov    0x68(%esi),%eax
80106886:	89 04 24             	mov    %eax,(%esp)
80106889:	e8 92 af ff ff       	call   80101820 <iput>
  end_op();
8010688e:	e8 dd c3 ff ff       	call   80102c70 <end_op>
  curproc->cwd = ip;
  return 0;
80106893:	31 c0                	xor    %eax,%eax
    return -1;
  }
  iunlock(ip);
  iput(curproc->cwd);
  end_op();
  curproc->cwd = ip;
80106895:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
}
80106898:	83 c4 20             	add    $0x20,%esp
8010689b:	5b                   	pop    %ebx
8010689c:	5e                   	pop    %esi
8010689d:	5d                   	pop    %ebp
8010689e:	c3                   	ret    
8010689f:	90                   	nop
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
801068a0:	e8 db b0 ff ff       	call   80101980 <iunlockput>
    end_op();
801068a5:	e8 c6 c3 ff ff       	call   80102c70 <end_op>
  iunlock(ip);
  iput(curproc->cwd);
  end_op();
  curproc->cwd = ip;
  return 0;
}
801068aa:	83 c4 20             	add    $0x20,%esp
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
    end_op();
    return -1;
801068ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  iunlock(ip);
  iput(curproc->cwd);
  end_op();
  curproc->cwd = ip;
  return 0;
}
801068b2:	5b                   	pop    %ebx
801068b3:	5e                   	pop    %esi
801068b4:	5d                   	pop    %ebp
801068b5:	c3                   	ret    
801068b6:	8d 76 00             	lea    0x0(%esi),%esi
801068b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801068c0 <sys_exec>:

int
sys_exec(void)
{
801068c0:	55                   	push   %ebp
801068c1:	89 e5                	mov    %esp,%ebp
801068c3:	57                   	push   %edi
801068c4:	56                   	push   %esi
801068c5:	53                   	push   %ebx
801068c6:	81 ec ac 00 00 00    	sub    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801068cc:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
801068d2:	89 44 24 04          	mov    %eax,0x4(%esp)
801068d6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801068dd:	e8 7e f5 ff ff       	call   80105e60 <argstr>
801068e2:	85 c0                	test   %eax,%eax
801068e4:	0f 88 82 00 00 00    	js     8010696c <sys_exec+0xac>
801068ea:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801068f0:	89 44 24 04          	mov    %eax,0x4(%esp)
801068f4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801068fb:	e8 b0 f4 ff ff       	call   80105db0 <argint>
80106900:	85 c0                	test   %eax,%eax
80106902:	78 68                	js     8010696c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80106904:	ba 80 00 00 00       	mov    $0x80,%edx
80106909:	31 c9                	xor    %ecx,%ecx
8010690b:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106911:	31 db                	xor    %ebx,%ebx
80106913:	89 54 24 08          	mov    %edx,0x8(%esp)
80106917:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
8010691d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80106921:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80106927:	89 04 24             	mov    %eax,(%esp)
8010692a:	e8 91 f1 ff ff       	call   80105ac0 <memset>
8010692f:	90                   	nop
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106930:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106936:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010693a:	8d 04 98             	lea    (%eax,%ebx,4),%eax
8010693d:	89 04 24             	mov    %eax,(%esp)
80106940:	e8 db f3 ff ff       	call   80105d20 <fetchint>
80106945:	85 c0                	test   %eax,%eax
80106947:	78 23                	js     8010696c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80106949:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010694f:	85 c0                	test   %eax,%eax
80106951:	74 2d                	je     80106980 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106953:	89 74 24 04          	mov    %esi,0x4(%esp)
80106957:	89 04 24             	mov    %eax,(%esp)
8010695a:	e8 01 f4 ff ff       	call   80105d60 <fetchstr>
8010695f:	85 c0                	test   %eax,%eax
80106961:	78 09                	js     8010696c <sys_exec+0xac>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80106963:	43                   	inc    %ebx
80106964:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
80106967:	83 fb 20             	cmp    $0x20,%ebx
8010696a:	75 c4                	jne    80106930 <sys_exec+0x70>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
8010696c:	81 c4 ac 00 00 00    	add    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
80106972:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80106977:	5b                   	pop    %ebx
80106978:	5e                   	pop    %esi
80106979:	5f                   	pop    %edi
8010697a:	5d                   	pop    %ebp
8010697b:	c3                   	ret    
8010697c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
80106980:	31 c0                	xor    %eax,%eax
80106982:	89 84 9d 68 ff ff ff 	mov    %eax,-0x98(%ebp,%ebx,4)
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80106989:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010698f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106993:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
80106999:	89 04 24             	mov    %eax,(%esp)
8010699c:	e8 0f a0 ff ff       	call   801009b0 <exec>
}
801069a1:	81 c4 ac 00 00 00    	add    $0xac,%esp
801069a7:	5b                   	pop    %ebx
801069a8:	5e                   	pop    %esi
801069a9:	5f                   	pop    %edi
801069aa:	5d                   	pop    %ebp
801069ab:	c3                   	ret    
801069ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801069b0 <sys_pipe>:

int
sys_pipe(void)
{
801069b0:	55                   	push   %ebp
801069b1:	89 e5                	mov    %esp,%ebp
801069b3:	57                   	push   %edi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801069b4:	bf 08 00 00 00       	mov    $0x8,%edi
  return exec(path, argv);
}

int
sys_pipe(void)
{
801069b9:	56                   	push   %esi
801069ba:	53                   	push   %ebx
801069bb:	83 ec 2c             	sub    $0x2c,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801069be:	8d 45 dc             	lea    -0x24(%ebp),%eax
801069c1:	89 7c 24 08          	mov    %edi,0x8(%esp)
801069c5:	89 44 24 04          	mov    %eax,0x4(%esp)
801069c9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801069d0:	e8 2b f4 ff ff       	call   80105e00 <argptr>
801069d5:	85 c0                	test   %eax,%eax
801069d7:	78 4b                	js     80106a24 <sys_pipe+0x74>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801069d9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801069dc:	89 44 24 04          	mov    %eax,0x4(%esp)
801069e0:	8d 45 e0             	lea    -0x20(%ebp),%eax
801069e3:	89 04 24             	mov    %eax,(%esp)
801069e6:	e8 15 c9 ff ff       	call   80103300 <pipealloc>
801069eb:	85 c0                	test   %eax,%eax
801069ed:	78 35                	js     80106a24 <sys_pipe+0x74>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801069ef:	8b 7d e0             	mov    -0x20(%ebp),%edi
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801069f2:	31 db                	xor    %ebx,%ebx
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801069f4:	e8 d7 cf ff ff       	call   801039d0 <myproc>
801069f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80106a00:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80106a04:	85 f6                	test   %esi,%esi
80106a06:	74 30                	je     80106a38 <sys_pipe+0x88>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80106a08:	43                   	inc    %ebx
80106a09:	83 fb 10             	cmp    $0x10,%ebx
80106a0c:	75 f2                	jne    80106a00 <sys_pipe+0x50>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80106a0e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106a11:	89 04 24             	mov    %eax,(%esp)
80106a14:	e8 07 a4 ff ff       	call   80100e20 <fileclose>
    fileclose(wf);
80106a19:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106a1c:	89 04 24             	mov    %eax,(%esp)
80106a1f:	e8 fc a3 ff ff       	call   80100e20 <fileclose>
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
80106a24:	83 c4 2c             	add    $0x2c,%esp
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
80106a27:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
80106a2c:	5b                   	pop    %ebx
80106a2d:	5e                   	pop    %esi
80106a2e:	5f                   	pop    %edi
80106a2f:	5d                   	pop    %ebp
80106a30:	c3                   	ret    
80106a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80106a38:	8d 73 08             	lea    0x8(%ebx),%esi
80106a3b:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106a3f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80106a42:	e8 89 cf ff ff       	call   801039d0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
80106a47:	31 d2                	xor    %edx,%edx
80106a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80106a50:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80106a54:	85 c9                	test   %ecx,%ecx
80106a56:	74 18                	je     80106a70 <sys_pipe+0xc0>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80106a58:	42                   	inc    %edx
80106a59:	83 fa 10             	cmp    $0x10,%edx
80106a5c:	75 f2                	jne    80106a50 <sys_pipe+0xa0>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80106a5e:	e8 6d cf ff ff       	call   801039d0 <myproc>
80106a63:	31 d2                	xor    %edx,%edx
80106a65:	89 54 b0 08          	mov    %edx,0x8(%eax,%esi,4)
80106a69:	eb a3                	jmp    80106a0e <sys_pipe+0x5e>
80106a6b:	90                   	nop
80106a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80106a70:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80106a74:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106a77:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106a79:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106a7c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
}
80106a7f:	83 c4 2c             	add    $0x2c,%esp
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
80106a82:	31 c0                	xor    %eax,%eax
}
80106a84:	5b                   	pop    %ebx
80106a85:	5e                   	pop    %esi
80106a86:	5f                   	pop    %edi
80106a87:	5d                   	pop    %ebp
80106a88:	c3                   	ret    
80106a89:	66 90                	xchg   %ax,%ax
80106a8b:	66 90                	xchg   %ax,%ax
80106a8d:	66 90                	xchg   %ax,%ax
80106a8f:	90                   	nop

80106a90 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106a90:	55                   	push   %ebp
80106a91:	89 e5                	mov    %esp,%ebp
  return fork();
}
80106a93:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80106a94:	e9 57 d2 ff ff       	jmp    80103cf0 <fork>
80106a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106aa0 <sys_exit>:
}

int
sys_exit(void)
{
80106aa0:	55                   	push   %ebp
80106aa1:	89 e5                	mov    %esp,%ebp
80106aa3:	83 ec 28             	sub    $0x28,%esp
    int stat;

    if(argint(0, &stat) < 0)
80106aa6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106aa9:	89 44 24 04          	mov    %eax,0x4(%esp)
80106aad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106ab4:	e8 f7 f2 ff ff       	call   80105db0 <argint>
80106ab9:	85 c0                	test   %eax,%eax
80106abb:	78 13                	js     80106ad0 <sys_exit+0x30>
        return -1;
    exit(stat);
80106abd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ac0:	89 04 24             	mov    %eax,(%esp)
80106ac3:	e8 08 d7 ff ff       	call   801041d0 <exit>
    return 0;
80106ac8:	31 c0                	xor    %eax,%eax
}
80106aca:	c9                   	leave  
80106acb:	c3                   	ret    
80106acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
sys_exit(void)
{
    int stat;

    if(argint(0, &stat) < 0)
        return -1;
80106ad0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    exit(stat);
    return 0;
}
80106ad5:	c9                   	leave  
80106ad6:	c3                   	ret    
80106ad7:	89 f6                	mov    %esi,%esi
80106ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ae0 <sys_wait>:

int
sys_wait(void)
{
80106ae0:	55                   	push   %ebp
    int *status;

    if(argptr(0, (void*)&status, sizeof(*status)) < 0)
80106ae1:	b8 04 00 00 00       	mov    $0x4,%eax
    return 0;
}

int
sys_wait(void)
{
80106ae6:	89 e5                	mov    %esp,%ebp
80106ae8:	83 ec 28             	sub    $0x28,%esp
    int *status;

    if(argptr(0, (void*)&status, sizeof(*status)) < 0)
80106aeb:	89 44 24 08          	mov    %eax,0x8(%esp)
80106aef:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106af2:	89 44 24 04          	mov    %eax,0x4(%esp)
80106af6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106afd:	e8 fe f2 ff ff       	call   80105e00 <argptr>
80106b02:	85 c0                	test   %eax,%eax
80106b04:	78 12                	js     80106b18 <sys_wait+0x38>
        return -1;
    return wait(status);
80106b06:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b09:	89 04 24             	mov    %eax,(%esp)
80106b0c:	e8 7f d9 ff ff       	call   80104490 <wait>
}
80106b11:	c9                   	leave  
80106b12:	c3                   	ret    
80106b13:	90                   	nop
80106b14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
sys_wait(void)
{
    int *status;

    if(argptr(0, (void*)&status, sizeof(*status)) < 0)
        return -1;
80106b18:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return wait(status);
}
80106b1d:	c9                   	leave  
80106b1e:	c3                   	ret    
80106b1f:	90                   	nop

80106b20 <sys_kill>:

int
sys_kill(void)
{
80106b20:	55                   	push   %ebp
80106b21:	89 e5                	mov    %esp,%ebp
80106b23:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106b26:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106b29:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b2d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106b34:	e8 77 f2 ff ff       	call   80105db0 <argint>
80106b39:	85 c0                	test   %eax,%eax
80106b3b:	78 13                	js     80106b50 <sys_kill+0x30>
    return -1;
  return kill(pid);
80106b3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b40:	89 04 24             	mov    %eax,(%esp)
80106b43:	e8 88 da ff ff       	call   801045d0 <kill>
}
80106b48:	c9                   	leave  
80106b49:	c3                   	ret    
80106b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
80106b50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
80106b55:	c9                   	leave  
80106b56:	c3                   	ret    
80106b57:	89 f6                	mov    %esi,%esi
80106b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b60 <sys_getpid>:

int
sys_getpid(void)
{
80106b60:	55                   	push   %ebp
80106b61:	89 e5                	mov    %esp,%ebp
80106b63:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106b66:	e8 65 ce ff ff       	call   801039d0 <myproc>
80106b6b:	8b 40 10             	mov    0x10(%eax),%eax
}
80106b6e:	c9                   	leave  
80106b6f:	c3                   	ret    

80106b70 <sys_sbrk>:

int
sys_sbrk(void)
{
80106b70:	55                   	push   %ebp
80106b71:	89 e5                	mov    %esp,%ebp
80106b73:	53                   	push   %ebx
80106b74:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106b77:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106b7a:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b7e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106b85:	e8 26 f2 ff ff       	call   80105db0 <argint>
80106b8a:	85 c0                	test   %eax,%eax
80106b8c:	78 22                	js     80106bb0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106b8e:	e8 3d ce ff ff       	call   801039d0 <myproc>
80106b93:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106b95:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b98:	89 04 24             	mov    %eax,(%esp)
80106b9b:	e8 c0 d0 ff ff       	call   80103c60 <growproc>
80106ba0:	85 c0                	test   %eax,%eax
80106ba2:	78 0c                	js     80106bb0 <sys_sbrk+0x40>
    return -1;
  return addr;
80106ba4:	89 d8                	mov    %ebx,%eax
}
80106ba6:	83 c4 24             	add    $0x24,%esp
80106ba9:	5b                   	pop    %ebx
80106baa:	5d                   	pop    %ebp
80106bab:	c3                   	ret    
80106bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80106bb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106bb5:	eb ef                	jmp    80106ba6 <sys_sbrk+0x36>
80106bb7:	89 f6                	mov    %esi,%esi
80106bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106bc0 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
80106bc0:	55                   	push   %ebp
80106bc1:	89 e5                	mov    %esp,%ebp
80106bc3:	53                   	push   %ebx
80106bc4:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106bc7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106bca:	89 44 24 04          	mov    %eax,0x4(%esp)
80106bce:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106bd5:	e8 d6 f1 ff ff       	call   80105db0 <argint>
80106bda:	85 c0                	test   %eax,%eax
80106bdc:	78 7e                	js     80106c5c <sys_sleep+0x9c>
    return -1;
  acquire(&tickslock);
80106bde:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80106be5:	e8 e6 ed ff ff       	call   801059d0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106bea:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
80106bed:	8b 1d 00 80 11 80    	mov    0x80118000,%ebx
  while(ticks - ticks0 < n){
80106bf3:	85 c9                	test   %ecx,%ecx
80106bf5:	75 2a                	jne    80106c21 <sys_sleep+0x61>
80106bf7:	eb 4f                	jmp    80106c48 <sys_sleep+0x88>
80106bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106c00:	b8 c0 77 11 80       	mov    $0x801177c0,%eax
80106c05:	89 44 24 04          	mov    %eax,0x4(%esp)
80106c09:	c7 04 24 00 80 11 80 	movl   $0x80118000,(%esp)
80106c10:	e8 6b d7 ff ff       	call   80104380 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106c15:	a1 00 80 11 80       	mov    0x80118000,%eax
80106c1a:	29 d8                	sub    %ebx,%eax
80106c1c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80106c1f:	73 27                	jae    80106c48 <sys_sleep+0x88>
    if(myproc()->killed){
80106c21:	e8 aa cd ff ff       	call   801039d0 <myproc>
80106c26:	8b 50 24             	mov    0x24(%eax),%edx
80106c29:	85 d2                	test   %edx,%edx
80106c2b:	74 d3                	je     80106c00 <sys_sleep+0x40>
      release(&tickslock);
80106c2d:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80106c34:	e8 37 ee ff ff       	call   80105a70 <release>
      return -1;
80106c39:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
80106c3e:	83 c4 24             	add    $0x24,%esp
80106c41:	5b                   	pop    %ebx
80106c42:	5d                   	pop    %ebp
80106c43:	c3                   	ret    
80106c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80106c48:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80106c4f:	e8 1c ee ff ff       	call   80105a70 <release>
  return 0;
}
80106c54:	83 c4 24             	add    $0x24,%esp
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
80106c57:	31 c0                	xor    %eax,%eax
}
80106c59:	5b                   	pop    %ebx
80106c5a:	5d                   	pop    %ebp
80106c5b:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
80106c5c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106c61:	eb db                	jmp    80106c3e <sys_sleep+0x7e>
80106c63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c70 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106c70:	55                   	push   %ebp
80106c71:	89 e5                	mov    %esp,%ebp
80106c73:	53                   	push   %ebx
80106c74:	83 ec 14             	sub    $0x14,%esp
  uint xticks;

  acquire(&tickslock);
80106c77:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80106c7e:	e8 4d ed ff ff       	call   801059d0 <acquire>
  xticks = ticks;
80106c83:	8b 1d 00 80 11 80    	mov    0x80118000,%ebx
  release(&tickslock);
80106c89:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80106c90:	e8 db ed ff ff       	call   80105a70 <release>
  return xticks;
}
80106c95:	83 c4 14             	add    $0x14,%esp
80106c98:	89 d8                	mov    %ebx,%eax
80106c9a:	5b                   	pop    %ebx
80106c9b:	5d                   	pop    %ebp
80106c9c:	c3                   	ret    
80106c9d:	8d 76 00             	lea    0x0(%esi),%esi

80106ca0 <sys_detach>:

int
sys_detach(void){
80106ca0:	55                   	push   %ebp
80106ca1:	89 e5                	mov    %esp,%ebp
80106ca3:	83 ec 28             	sub    $0x28,%esp
    int pid;
  if(argint(0, &pid) < 0)
80106ca6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106ca9:	89 44 24 04          	mov    %eax,0x4(%esp)
80106cad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106cb4:	e8 f7 f0 ff ff       	call   80105db0 <argint>
80106cb9:	85 c0                	test   %eax,%eax
80106cbb:	78 13                	js     80106cd0 <sys_detach+0x30>
    return -1;
  return detach(pid);
80106cbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106cc0:	89 04 24             	mov    %eax,(%esp)
80106cc3:	e8 78 da ff ff       	call   80104740 <detach>
}
80106cc8:	c9                   	leave  
80106cc9:	c3                   	ret    
80106cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

int
sys_detach(void){
    int pid;
  if(argint(0, &pid) < 0)
    return -1;
80106cd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return detach(pid);
}
80106cd5:	c9                   	leave  
80106cd6:	c3                   	ret    
80106cd7:	89 f6                	mov    %esi,%esi
80106cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ce0 <sys_policy>:

int
sys_policy(void){
80106ce0:	55                   	push   %ebp
80106ce1:	89 e5                	mov    %esp,%ebp
80106ce3:	83 ec 28             	sub    $0x28,%esp
    int pid;
    if(argint(0, &pid) < 0)
80106ce6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106ce9:	89 44 24 04          	mov    %eax,0x4(%esp)
80106ced:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106cf4:	e8 b7 f0 ff ff       	call   80105db0 <argint>
80106cf9:	85 c0                	test   %eax,%eax
80106cfb:	78 13                	js     80106d10 <sys_policy+0x30>
        return -1;
    policy(pid);
80106cfd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d00:	89 04 24             	mov    %eax,(%esp)
80106d03:	e8 f8 db ff ff       	call   80104900 <policy>
    return 0;
80106d08:	31 c0                	xor    %eax,%eax
}
80106d0a:	c9                   	leave  
80106d0b:	c3                   	ret    
80106d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

int
sys_policy(void){
    int pid;
    if(argint(0, &pid) < 0)
        return -1;
80106d10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    policy(pid);
    return 0;
}
80106d15:	c9                   	leave  
80106d16:	c3                   	ret    
80106d17:	89 f6                	mov    %esi,%esi
80106d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d20 <sys_priority>:

//TODO -need to understand how to call this sys_call
int
sys_priority(void){
80106d20:	55                   	push   %ebp
80106d21:	89 e5                	mov    %esp,%ebp
80106d23:	83 ec 28             	sub    $0x28,%esp
    int pid;
    if(argint(0, &pid) < 0)
80106d26:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106d29:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d2d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106d34:	e8 77 f0 ff ff       	call   80105db0 <argint>
80106d39:	85 c0                	test   %eax,%eax
80106d3b:	78 13                	js     80106d50 <sys_priority+0x30>
        return -1;
    priority(pid);
80106d3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d40:	89 04 24             	mov    %eax,(%esp)
80106d43:	e8 88 da ff ff       	call   801047d0 <priority>
    return 0;
80106d48:	31 c0                	xor    %eax,%eax
}
80106d4a:	c9                   	leave  
80106d4b:	c3                   	ret    
80106d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
//TODO -need to understand how to call this sys_call
int
sys_priority(void){
    int pid;
    if(argint(0, &pid) < 0)
        return -1;
80106d50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    priority(pid);
    return 0;
}
80106d55:	c9                   	leave  
80106d56:	c3                   	ret    
80106d57:	89 f6                	mov    %esi,%esi
80106d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d60 <sys_wait_stat>:


int
sys_wait_stat(void)
{
80106d60:	55                   	push   %ebp
    performance->ttime = 0;
    performance->stime = 0;
    performance->retime = 0;
    performance->rutime = 0;*/

    if(argptr(0, (void*)&status, sizeof(*status)) < 0)
80106d61:	ba 04 00 00 00       	mov    $0x4,%edx
}


int
sys_wait_stat(void)
{
80106d66:	89 e5                	mov    %esp,%ebp
80106d68:	83 ec 28             	sub    $0x28,%esp
    performance->ttime = 0;
    performance->stime = 0;
    performance->retime = 0;
    performance->rutime = 0;*/

    if(argptr(0, (void*)&status, sizeof(*status)) < 0)
80106d6b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106d6e:	89 54 24 08          	mov    %edx,0x8(%esp)
80106d72:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d76:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106d7d:	e8 7e f0 ff ff       	call   80105e00 <argptr>
80106d82:	85 c0                	test   %eax,%eax
80106d84:	78 1a                	js     80106da0 <sys_wait_stat+0x40>
        return -1;
    return wait_stat(status , performance);
80106d86:	31 c0                	xor    %eax,%eax
80106d88:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d8f:	89 04 24             	mov    %eax,(%esp)
80106d92:	e8 69 dc ff ff       	call   80104a00 <wait_stat>
}
80106d97:	c9                   	leave  
80106d98:	c3                   	ret    
80106d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    performance->stime = 0;
    performance->retime = 0;
    performance->rutime = 0;*/

    if(argptr(0, (void*)&status, sizeof(*status)) < 0)
        return -1;
80106da0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return wait_stat(status , performance);
}
80106da5:	c9                   	leave  
80106da6:	c3                   	ret    

80106da7 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106da7:	1e                   	push   %ds
  pushl %es
80106da8:	06                   	push   %es
  pushl %fs
80106da9:	0f a0                	push   %fs
  pushl %gs
80106dab:	0f a8                	push   %gs
  pushal
80106dad:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106dae:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106db2:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106db4:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106db6:	54                   	push   %esp
  call trap
80106db7:	e8 e4 00 00 00       	call   80106ea0 <trap>
  addl $4, %esp
80106dbc:	83 c4 04             	add    $0x4,%esp

80106dbf <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106dbf:	61                   	popa   
  popl %gs
80106dc0:	0f a9                	pop    %gs
  popl %fs
80106dc2:	0f a1                	pop    %fs
  popl %es
80106dc4:	07                   	pop    %es
  popl %ds
80106dc5:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106dc6:	83 c4 08             	add    $0x8,%esp
  iret
80106dc9:	cf                   	iret   
80106dca:	66 90                	xchg   %ax,%ax
80106dcc:	66 90                	xchg   %ax,%ax
80106dce:	66 90                	xchg   %ax,%ax

80106dd0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106dd0:	55                   	push   %ebp
80106dd1:	89 e5                	mov    %esp,%ebp
80106dd3:	83 ec 18             	sub    $0x18,%esp
  int i;
  pinit();
80106dd6:	e8 35 cb ff ff       	call   80103910 <pinit>
  for(i = 0; i < 256; i++)
80106ddb:	31 c0                	xor    %eax,%eax
80106ddd:	8d 76 00             	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106de0:	8b 14 85 0c c0 10 80 	mov    -0x7fef3ff4(,%eax,4),%edx
80106de7:	b9 08 00 00 00       	mov    $0x8,%ecx
80106dec:	66 89 0c c5 02 78 11 	mov    %cx,-0x7fee87fe(,%eax,8)
80106df3:	80 
80106df4:	31 c9                	xor    %ecx,%ecx
80106df6:	88 0c c5 04 78 11 80 	mov    %cl,-0x7fee87fc(,%eax,8)
80106dfd:	b1 8e                	mov    $0x8e,%cl
80106dff:	88 0c c5 05 78 11 80 	mov    %cl,-0x7fee87fb(,%eax,8)
80106e06:	66 89 14 c5 00 78 11 	mov    %dx,-0x7fee8800(,%eax,8)
80106e0d:	80 
80106e0e:	c1 ea 10             	shr    $0x10,%edx
80106e11:	66 89 14 c5 06 78 11 	mov    %dx,-0x7fee87fa(,%eax,8)
80106e18:	80 
void
tvinit(void)
{
  int i;
  pinit();
  for(i = 0; i < 256; i++)
80106e19:	40                   	inc    %eax
80106e1a:	3d 00 01 00 00       	cmp    $0x100,%eax
80106e1f:	75 bf                	jne    80106de0 <tvinit+0x10>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106e21:	a1 0c c1 10 80       	mov    0x8010c10c,%eax

  initlock(&tickslock, "time");
80106e26:	b9 29 8f 10 80       	mov    $0x80108f29,%ecx
{
  int i;
  pinit();
  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106e2b:	ba 08 00 00 00       	mov    $0x8,%edx

  initlock(&tickslock, "time");
80106e30:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80106e34:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
{
  int i;
  pinit();
  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106e3b:	66 89 15 02 7a 11 80 	mov    %dx,0x80117a02
80106e42:	66 a3 00 7a 11 80    	mov    %ax,0x80117a00
80106e48:	c1 e8 10             	shr    $0x10,%eax
80106e4b:	c6 05 04 7a 11 80 00 	movb   $0x0,0x80117a04
80106e52:	c6 05 05 7a 11 80 ef 	movb   $0xef,0x80117a05
80106e59:	66 a3 06 7a 11 80    	mov    %ax,0x80117a06

  initlock(&tickslock, "time");
80106e5f:	e8 0c ea ff ff       	call   80105870 <initlock>
}
80106e64:	c9                   	leave  
80106e65:	c3                   	ret    
80106e66:	8d 76 00             	lea    0x0(%esi),%esi
80106e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e70 <idtinit>:

void
idtinit(void)
{
80106e70:	55                   	push   %ebp
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  pd[1] = (uint)p;
80106e71:	b8 00 78 11 80       	mov    $0x80117800,%eax
80106e76:	89 e5                	mov    %esp,%ebp
80106e78:	0f b7 d0             	movzwl %ax,%edx
  pd[2] = (uint)p >> 16;
80106e7b:	c1 e8 10             	shr    $0x10,%eax
80106e7e:	83 ec 10             	sub    $0x10,%esp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106e81:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
80106e87:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106e8b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80106e8f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106e92:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106e95:	c9                   	leave  
80106e96:	c3                   	ret    
80106e97:	89 f6                	mov    %esi,%esi
80106e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ea0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106ea0:	55                   	push   %ebp
80106ea1:	89 e5                	mov    %esp,%ebp
80106ea3:	83 ec 48             	sub    $0x48,%esp
80106ea6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80106ea9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80106eac:	89 75 f8             	mov    %esi,-0x8(%ebp)
80106eaf:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(tf->trapno == T_SYSCALL){
80106eb2:	8b 43 30             	mov    0x30(%ebx),%eax
80106eb5:	83 f8 40             	cmp    $0x40,%eax
80106eb8:	0f 84 b2 01 00 00    	je     80107070 <trap+0x1d0>
    if(myproc()->killed)
      exit(0);
    return;
  }

  switch(tf->trapno){
80106ebe:	83 e8 20             	sub    $0x20,%eax
80106ec1:	83 f8 1f             	cmp    $0x1f,%eax
80106ec4:	77 0a                	ja     80106ed0 <trap+0x30>
80106ec6:	ff 24 85 d0 8f 10 80 	jmp    *-0x7fef7030(,%eax,4)
80106ecd:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80106ed0:	e8 fb ca ff ff       	call   801039d0 <myproc>
80106ed5:	85 c0                	test   %eax,%eax
80106ed7:	0f 84 27 02 00 00    	je     80107104 <trap+0x264>
80106edd:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106ee1:	0f 84 1d 02 00 00    	je     80107104 <trap+0x264>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106ee7:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106eea:	8b 53 38             	mov    0x38(%ebx),%edx
80106eed:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80106ef0:	89 55 dc             	mov    %edx,-0x24(%ebp)
80106ef3:	e8 b8 ca ff ff       	call   801039b0 <cpuid>
80106ef8:	8b 73 30             	mov    0x30(%ebx),%esi
80106efb:	89 c7                	mov    %eax,%edi
80106efd:	8b 43 34             	mov    0x34(%ebx),%eax
80106f00:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106f03:	e8 c8 ca ff ff       	call   801039d0 <myproc>
80106f08:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106f0b:	e8 c0 ca ff ff       	call   801039d0 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106f10:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106f13:	89 74 24 0c          	mov    %esi,0xc(%esp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106f17:	8b 75 e0             	mov    -0x20(%ebp),%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106f1a:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106f1d:	89 7c 24 14          	mov    %edi,0x14(%esp)
80106f21:	89 54 24 18          	mov    %edx,0x18(%esp)
80106f25:	8b 55 e4             	mov    -0x1c(%ebp),%edx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106f28:	83 c6 6c             	add    $0x6c,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106f2b:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106f2f:	89 74 24 08          	mov    %esi,0x8(%esp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106f33:	89 54 24 10          	mov    %edx,0x10(%esp)
80106f37:	8b 40 10             	mov    0x10(%eax),%eax
80106f3a:	c7 04 24 8c 8f 10 80 	movl   $0x80108f8c,(%esp)
80106f41:	89 44 24 04          	mov    %eax,0x4(%esp)
80106f45:	e8 f6 96 ff ff       	call   80100640 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80106f4a:	e8 81 ca ff ff       	call   801039d0 <myproc>
80106f4f:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80106f56:	8d 76 00             	lea    0x0(%esi),%esi
80106f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106f60:	e8 6b ca ff ff       	call   801039d0 <myproc>
80106f65:	85 c0                	test   %eax,%eax
80106f67:	74 0c                	je     80106f75 <trap+0xd5>
80106f69:	e8 62 ca ff ff       	call   801039d0 <myproc>
80106f6e:	8b 50 24             	mov    0x24(%eax),%edx
80106f71:	85 d2                	test   %edx,%edx
80106f73:	75 4b                	jne    80106fc0 <trap+0x120>
    exit(0);

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106f75:	e8 56 ca ff ff       	call   801039d0 <myproc>
80106f7a:	85 c0                	test   %eax,%eax
80106f7c:	74 0f                	je     80106f8d <trap+0xed>
80106f7e:	66 90                	xchg   %ax,%ax
80106f80:	e8 4b ca ff ff       	call   801039d0 <myproc>
80106f85:	8b 40 0c             	mov    0xc(%eax),%eax
80106f88:	83 f8 04             	cmp    $0x4,%eax
80106f8b:	74 53                	je     80106fe0 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106f8d:	e8 3e ca ff ff       	call   801039d0 <myproc>
80106f92:	85 c0                	test   %eax,%eax
80106f94:	74 1b                	je     80106fb1 <trap+0x111>
80106f96:	e8 35 ca ff ff       	call   801039d0 <myproc>
80106f9b:	8b 40 24             	mov    0x24(%eax),%eax
80106f9e:	85 c0                	test   %eax,%eax
80106fa0:	74 0f                	je     80106fb1 <trap+0x111>
80106fa2:	8b 43 3c             	mov    0x3c(%ebx),%eax
80106fa5:	83 e0 03             	and    $0x3,%eax
80106fa8:	83 f8 03             	cmp    $0x3,%eax
80106fab:	0f 84 e8 00 00 00    	je     80107099 <trap+0x1f9>
    exit(0);
}
80106fb1:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80106fb4:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106fb7:	8b 7d fc             	mov    -0x4(%ebp),%edi
80106fba:	89 ec                	mov    %ebp,%esp
80106fbc:	5d                   	pop    %ebp
80106fbd:	c3                   	ret    
80106fbe:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106fc0:	8b 43 3c             	mov    0x3c(%ebx),%eax
80106fc3:	83 e0 03             	and    $0x3,%eax
80106fc6:	83 f8 03             	cmp    $0x3,%eax
80106fc9:	75 aa                	jne    80106f75 <trap+0xd5>
    exit(0);
80106fcb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106fd2:	e8 f9 d1 ff ff       	call   801041d0 <exit>
80106fd7:	eb 9c                	jmp    80106f75 <trap+0xd5>
80106fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106fe0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106fe4:	75 a7                	jne    80106f8d <trap+0xed>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
80106fe6:	e8 05 d3 ff ff       	call   801042f0 <yield>
80106feb:	eb a0                	jmp    80106f8d <trap+0xed>
80106fed:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80106ff0:	e8 bb c9 ff ff       	call   801039b0 <cpuid>
80106ff5:	85 c0                	test   %eax,%eax
80106ff7:	0f 84 d3 00 00 00    	je     801070d0 <trap+0x230>
80106ffd:	8d 76 00             	lea    0x0(%esi),%esi
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80107000:	e8 db b7 ff ff       	call   801027e0 <lapiceoi>
    break;
80107005:	e9 56 ff ff ff       	jmp    80106f60 <trap+0xc0>
8010700a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80107010:	e8 8b b6 ff ff       	call   801026a0 <kbdintr>
    lapiceoi();
80107015:	e8 c6 b7 ff ff       	call   801027e0 <lapiceoi>
    break;
8010701a:	e9 41 ff ff ff       	jmp    80106f60 <trap+0xc0>
8010701f:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80107020:	e8 7b 02 00 00       	call   801072a0 <uartintr>
    lapiceoi();
80107025:	e8 b6 b7 ff ff       	call   801027e0 <lapiceoi>
    break;
8010702a:	e9 31 ff ff ff       	jmp    80106f60 <trap+0xc0>
8010702f:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80107030:	8b 7b 38             	mov    0x38(%ebx),%edi
80107033:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80107037:	e8 74 c9 ff ff       	call   801039b0 <cpuid>
8010703c:	c7 04 24 34 8f 10 80 	movl   $0x80108f34,(%esp)
80107043:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80107047:	89 74 24 08          	mov    %esi,0x8(%esp)
8010704b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010704f:	e8 ec 95 ff ff       	call   80100640 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
80107054:	e8 87 b7 ff ff       	call   801027e0 <lapiceoi>
    break;
80107059:	e9 02 ff ff ff       	jmp    80106f60 <trap+0xc0>
8010705e:	66 90                	xchg   %ax,%ax
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80107060:	e8 bb b0 ff ff       	call   80102120 <ideintr>
80107065:	eb 96                	jmp    80106ffd <trap+0x15d>
80107067:	89 f6                	mov    %esi,%esi
80107069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
80107070:	e8 5b c9 ff ff       	call   801039d0 <myproc>
80107075:	8b 70 24             	mov    0x24(%eax),%esi
80107078:	85 f6                	test   %esi,%esi
8010707a:	75 3c                	jne    801070b8 <trap+0x218>
      exit(0);
    myproc()->tf = tf;
8010707c:	e8 4f c9 ff ff       	call   801039d0 <myproc>
80107081:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80107084:	e8 17 ee ff ff       	call   80105ea0 <syscall>
    if(myproc()->killed)
80107089:	e8 42 c9 ff ff       	call   801039d0 <myproc>
8010708e:	8b 48 24             	mov    0x24(%eax),%ecx
80107091:	85 c9                	test   %ecx,%ecx
80107093:	0f 84 18 ff ff ff    	je     80106fb1 <trap+0x111>
      exit(0);
80107099:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit(0);
}
801070a0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801070a3:	8b 75 f8             	mov    -0x8(%ebp),%esi
801070a6:	8b 7d fc             	mov    -0x4(%ebp),%edi
801070a9:	89 ec                	mov    %ebp,%esp
801070ab:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit(0);
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit(0);
801070ac:	e9 1f d1 ff ff       	jmp    801041d0 <exit>
801070b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit(0);
801070b8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801070bf:	e8 0c d1 ff ff       	call   801041d0 <exit>
801070c4:	eb b6                	jmp    8010707c <trap+0x1dc>
801070c6:	8d 76 00             	lea    0x0(%esi),%esi
801070c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
801070d0:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
801070d7:	e8 f4 e8 ff ff       	call   801059d0 <acquire>
      ticks++;
      wakeup(&ticks);
801070dc:	c7 04 24 00 80 11 80 	movl   $0x80118000,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
801070e3:	ff 05 00 80 11 80    	incl   0x80118000
      wakeup(&ticks);
801070e9:	e8 b2 d4 ff ff       	call   801045a0 <wakeup>

      update_procs_performances();
801070ee:	e8 ad c7 ff ff       	call   801038a0 <update_procs_performances>

      release(&tickslock);
801070f3:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
801070fa:	e8 71 e9 ff ff       	call   80105a70 <release>
801070ff:	e9 f9 fe ff ff       	jmp    80106ffd <trap+0x15d>
80107104:	0f 20 d7             	mov    %cr2,%edi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80107107:	8b 73 38             	mov    0x38(%ebx),%esi
8010710a:	e8 a1 c8 ff ff       	call   801039b0 <cpuid>
8010710f:	89 7c 24 10          	mov    %edi,0x10(%esp)
80107113:	89 74 24 0c          	mov    %esi,0xc(%esp)
80107117:	89 44 24 08          	mov    %eax,0x8(%esp)
8010711b:	8b 43 30             	mov    0x30(%ebx),%eax
8010711e:	c7 04 24 58 8f 10 80 	movl   $0x80108f58,(%esp)
80107125:	89 44 24 04          	mov    %eax,0x4(%esp)
80107129:	e8 12 95 ff ff       	call   80100640 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
8010712e:	c7 04 24 2e 8f 10 80 	movl   $0x80108f2e,(%esp)
80107135:	e8 06 92 ff ff       	call   80100340 <panic>
8010713a:	66 90                	xchg   %ax,%ax
8010713c:	66 90                	xchg   %ax,%ax
8010713e:	66 90                	xchg   %ax,%ax

80107140 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80107140:	a1 18 c6 10 80       	mov    0x8010c618,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80107145:	55                   	push   %ebp
80107146:	89 e5                	mov    %esp,%ebp
  if(!uart)
80107148:	85 c0                	test   %eax,%eax
8010714a:	74 1c                	je     80107168 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010714c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80107151:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80107152:	24 01                	and    $0x1,%al
80107154:	84 c0                	test   %al,%al
80107156:	74 10                	je     80107168 <uartgetc+0x28>
80107158:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010715d:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010715e:	0f b6 c0             	movzbl %al,%eax
}
80107161:	5d                   	pop    %ebp
80107162:	c3                   	ret    
80107163:	90                   	nop
80107164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80107168:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
8010716d:	5d                   	pop    %ebp
8010716e:	c3                   	ret    
8010716f:	90                   	nop

80107170 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
80107170:	55                   	push   %ebp
80107171:	89 e5                	mov    %esp,%ebp
80107173:	57                   	push   %edi
80107174:	bf fd 03 00 00       	mov    $0x3fd,%edi
80107179:	56                   	push   %esi
8010717a:	be 80 00 00 00       	mov    $0x80,%esi
8010717f:	53                   	push   %ebx
80107180:	89 c3                	mov    %eax,%ebx
80107182:	83 ec 1c             	sub    $0x1c,%esp
80107185:	eb 18                	jmp    8010719f <uartputc.part.0+0x2f>
80107187:	89 f6                	mov    %esi,%esi
80107189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80107190:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80107197:	e8 64 b6 ff ff       	call   80102800 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010719c:	4e                   	dec    %esi
8010719d:	74 09                	je     801071a8 <uartputc.part.0+0x38>
8010719f:	89 fa                	mov    %edi,%edx
801071a1:	ec                   	in     (%dx),%al
801071a2:	24 20                	and    $0x20,%al
801071a4:	84 c0                	test   %al,%al
801071a6:	74 e8                	je     80107190 <uartputc.part.0+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801071a8:	ba f8 03 00 00       	mov    $0x3f8,%edx
801071ad:	88 d8                	mov    %bl,%al
801071af:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
801071b0:	83 c4 1c             	add    $0x1c,%esp
801071b3:	5b                   	pop    %ebx
801071b4:	5e                   	pop    %esi
801071b5:	5f                   	pop    %edi
801071b6:	5d                   	pop    %ebp
801071b7:	c3                   	ret    
801071b8:	90                   	nop
801071b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801071c0 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
801071c0:	55                   	push   %ebp
801071c1:	31 c9                	xor    %ecx,%ecx
801071c3:	89 e5                	mov    %esp,%ebp
801071c5:	88 c8                	mov    %cl,%al
801071c7:	57                   	push   %edi
801071c8:	56                   	push   %esi
801071c9:	53                   	push   %ebx
801071ca:	bb fa 03 00 00       	mov    $0x3fa,%ebx
801071cf:	83 ec 1c             	sub    $0x1c,%esp
801071d2:	89 da                	mov    %ebx,%edx
801071d4:	ee                   	out    %al,(%dx)
801071d5:	bf fb 03 00 00       	mov    $0x3fb,%edi
801071da:	b0 80                	mov    $0x80,%al
801071dc:	89 fa                	mov    %edi,%edx
801071de:	ee                   	out    %al,(%dx)
801071df:	b0 0c                	mov    $0xc,%al
801071e1:	ba f8 03 00 00       	mov    $0x3f8,%edx
801071e6:	ee                   	out    %al,(%dx)
801071e7:	be f9 03 00 00       	mov    $0x3f9,%esi
801071ec:	88 c8                	mov    %cl,%al
801071ee:	89 f2                	mov    %esi,%edx
801071f0:	ee                   	out    %al,(%dx)
801071f1:	b0 03                	mov    $0x3,%al
801071f3:	89 fa                	mov    %edi,%edx
801071f5:	ee                   	out    %al,(%dx)
801071f6:	ba fc 03 00 00       	mov    $0x3fc,%edx
801071fb:	88 c8                	mov    %cl,%al
801071fd:	ee                   	out    %al,(%dx)
801071fe:	b0 01                	mov    $0x1,%al
80107200:	89 f2                	mov    %esi,%edx
80107202:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80107203:	ba fd 03 00 00       	mov    $0x3fd,%edx
80107208:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80107209:	fe c0                	inc    %al
8010720b:	74 52                	je     8010725f <uartinit+0x9f>
    return;
  uart = 1;
8010720d:	b9 01 00 00 00       	mov    $0x1,%ecx
80107212:	89 da                	mov    %ebx,%edx
80107214:	89 0d 18 c6 10 80    	mov    %ecx,0x8010c618
8010721a:	ec                   	in     (%dx),%al
8010721b:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107220:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
80107221:	31 db                	xor    %ebx,%ebx
80107223:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80107227:	bb 50 90 10 80       	mov    $0x80109050,%ebx
8010722c:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80107233:	e8 18 b1 ff ff       	call   80102350 <ioapicenable>
80107238:	b8 78 00 00 00       	mov    $0x78,%eax
8010723d:	eb 09                	jmp    80107248 <uartinit+0x88>
8010723f:	90                   	nop

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80107240:	43                   	inc    %ebx
80107241:	0f be 03             	movsbl (%ebx),%eax
80107244:	84 c0                	test   %al,%al
80107246:	74 17                	je     8010725f <uartinit+0x9f>
void
uartputc(int c)
{
  int i;

  if(!uart)
80107248:	8b 15 18 c6 10 80    	mov    0x8010c618,%edx
8010724e:	85 d2                	test   %edx,%edx
80107250:	74 ee                	je     80107240 <uartinit+0x80>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80107252:	43                   	inc    %ebx
80107253:	e8 18 ff ff ff       	call   80107170 <uartputc.part.0>
80107258:	0f be 03             	movsbl (%ebx),%eax
8010725b:	84 c0                	test   %al,%al
8010725d:	75 e9                	jne    80107248 <uartinit+0x88>
    uartputc(*p);
}
8010725f:	83 c4 1c             	add    $0x1c,%esp
80107262:	5b                   	pop    %ebx
80107263:	5e                   	pop    %esi
80107264:	5f                   	pop    %edi
80107265:	5d                   	pop    %ebp
80107266:	c3                   	ret    
80107267:	89 f6                	mov    %esi,%esi
80107269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107270 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80107270:	8b 15 18 c6 10 80    	mov    0x8010c618,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80107276:	55                   	push   %ebp
80107277:	89 e5                	mov    %esp,%ebp
80107279:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
8010727c:	85 d2                	test   %edx,%edx
8010727e:	74 10                	je     80107290 <uartputc+0x20>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80107280:	5d                   	pop    %ebp
80107281:	e9 ea fe ff ff       	jmp    80107170 <uartputc.part.0>
80107286:	8d 76 00             	lea    0x0(%esi),%esi
80107289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107290:	5d                   	pop    %ebp
80107291:	c3                   	ret    
80107292:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801072a0 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
801072a0:	55                   	push   %ebp
801072a1:	89 e5                	mov    %esp,%ebp
801072a3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
801072a6:	c7 04 24 40 71 10 80 	movl   $0x80107140,(%esp)
801072ad:	e8 fe 94 ff ff       	call   801007b0 <consoleintr>
}
801072b2:	c9                   	leave  
801072b3:	c3                   	ret    

801072b4 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801072b4:	6a 00                	push   $0x0
  pushl $0
801072b6:	6a 00                	push   $0x0
  jmp alltraps
801072b8:	e9 ea fa ff ff       	jmp    80106da7 <alltraps>

801072bd <vector1>:
.globl vector1
vector1:
  pushl $0
801072bd:	6a 00                	push   $0x0
  pushl $1
801072bf:	6a 01                	push   $0x1
  jmp alltraps
801072c1:	e9 e1 fa ff ff       	jmp    80106da7 <alltraps>

801072c6 <vector2>:
.globl vector2
vector2:
  pushl $0
801072c6:	6a 00                	push   $0x0
  pushl $2
801072c8:	6a 02                	push   $0x2
  jmp alltraps
801072ca:	e9 d8 fa ff ff       	jmp    80106da7 <alltraps>

801072cf <vector3>:
.globl vector3
vector3:
  pushl $0
801072cf:	6a 00                	push   $0x0
  pushl $3
801072d1:	6a 03                	push   $0x3
  jmp alltraps
801072d3:	e9 cf fa ff ff       	jmp    80106da7 <alltraps>

801072d8 <vector4>:
.globl vector4
vector4:
  pushl $0
801072d8:	6a 00                	push   $0x0
  pushl $4
801072da:	6a 04                	push   $0x4
  jmp alltraps
801072dc:	e9 c6 fa ff ff       	jmp    80106da7 <alltraps>

801072e1 <vector5>:
.globl vector5
vector5:
  pushl $0
801072e1:	6a 00                	push   $0x0
  pushl $5
801072e3:	6a 05                	push   $0x5
  jmp alltraps
801072e5:	e9 bd fa ff ff       	jmp    80106da7 <alltraps>

801072ea <vector6>:
.globl vector6
vector6:
  pushl $0
801072ea:	6a 00                	push   $0x0
  pushl $6
801072ec:	6a 06                	push   $0x6
  jmp alltraps
801072ee:	e9 b4 fa ff ff       	jmp    80106da7 <alltraps>

801072f3 <vector7>:
.globl vector7
vector7:
  pushl $0
801072f3:	6a 00                	push   $0x0
  pushl $7
801072f5:	6a 07                	push   $0x7
  jmp alltraps
801072f7:	e9 ab fa ff ff       	jmp    80106da7 <alltraps>

801072fc <vector8>:
.globl vector8
vector8:
  pushl $8
801072fc:	6a 08                	push   $0x8
  jmp alltraps
801072fe:	e9 a4 fa ff ff       	jmp    80106da7 <alltraps>

80107303 <vector9>:
.globl vector9
vector9:
  pushl $0
80107303:	6a 00                	push   $0x0
  pushl $9
80107305:	6a 09                	push   $0x9
  jmp alltraps
80107307:	e9 9b fa ff ff       	jmp    80106da7 <alltraps>

8010730c <vector10>:
.globl vector10
vector10:
  pushl $10
8010730c:	6a 0a                	push   $0xa
  jmp alltraps
8010730e:	e9 94 fa ff ff       	jmp    80106da7 <alltraps>

80107313 <vector11>:
.globl vector11
vector11:
  pushl $11
80107313:	6a 0b                	push   $0xb
  jmp alltraps
80107315:	e9 8d fa ff ff       	jmp    80106da7 <alltraps>

8010731a <vector12>:
.globl vector12
vector12:
  pushl $12
8010731a:	6a 0c                	push   $0xc
  jmp alltraps
8010731c:	e9 86 fa ff ff       	jmp    80106da7 <alltraps>

80107321 <vector13>:
.globl vector13
vector13:
  pushl $13
80107321:	6a 0d                	push   $0xd
  jmp alltraps
80107323:	e9 7f fa ff ff       	jmp    80106da7 <alltraps>

80107328 <vector14>:
.globl vector14
vector14:
  pushl $14
80107328:	6a 0e                	push   $0xe
  jmp alltraps
8010732a:	e9 78 fa ff ff       	jmp    80106da7 <alltraps>

8010732f <vector15>:
.globl vector15
vector15:
  pushl $0
8010732f:	6a 00                	push   $0x0
  pushl $15
80107331:	6a 0f                	push   $0xf
  jmp alltraps
80107333:	e9 6f fa ff ff       	jmp    80106da7 <alltraps>

80107338 <vector16>:
.globl vector16
vector16:
  pushl $0
80107338:	6a 00                	push   $0x0
  pushl $16
8010733a:	6a 10                	push   $0x10
  jmp alltraps
8010733c:	e9 66 fa ff ff       	jmp    80106da7 <alltraps>

80107341 <vector17>:
.globl vector17
vector17:
  pushl $17
80107341:	6a 11                	push   $0x11
  jmp alltraps
80107343:	e9 5f fa ff ff       	jmp    80106da7 <alltraps>

80107348 <vector18>:
.globl vector18
vector18:
  pushl $0
80107348:	6a 00                	push   $0x0
  pushl $18
8010734a:	6a 12                	push   $0x12
  jmp alltraps
8010734c:	e9 56 fa ff ff       	jmp    80106da7 <alltraps>

80107351 <vector19>:
.globl vector19
vector19:
  pushl $0
80107351:	6a 00                	push   $0x0
  pushl $19
80107353:	6a 13                	push   $0x13
  jmp alltraps
80107355:	e9 4d fa ff ff       	jmp    80106da7 <alltraps>

8010735a <vector20>:
.globl vector20
vector20:
  pushl $0
8010735a:	6a 00                	push   $0x0
  pushl $20
8010735c:	6a 14                	push   $0x14
  jmp alltraps
8010735e:	e9 44 fa ff ff       	jmp    80106da7 <alltraps>

80107363 <vector21>:
.globl vector21
vector21:
  pushl $0
80107363:	6a 00                	push   $0x0
  pushl $21
80107365:	6a 15                	push   $0x15
  jmp alltraps
80107367:	e9 3b fa ff ff       	jmp    80106da7 <alltraps>

8010736c <vector22>:
.globl vector22
vector22:
  pushl $0
8010736c:	6a 00                	push   $0x0
  pushl $22
8010736e:	6a 16                	push   $0x16
  jmp alltraps
80107370:	e9 32 fa ff ff       	jmp    80106da7 <alltraps>

80107375 <vector23>:
.globl vector23
vector23:
  pushl $0
80107375:	6a 00                	push   $0x0
  pushl $23
80107377:	6a 17                	push   $0x17
  jmp alltraps
80107379:	e9 29 fa ff ff       	jmp    80106da7 <alltraps>

8010737e <vector24>:
.globl vector24
vector24:
  pushl $0
8010737e:	6a 00                	push   $0x0
  pushl $24
80107380:	6a 18                	push   $0x18
  jmp alltraps
80107382:	e9 20 fa ff ff       	jmp    80106da7 <alltraps>

80107387 <vector25>:
.globl vector25
vector25:
  pushl $0
80107387:	6a 00                	push   $0x0
  pushl $25
80107389:	6a 19                	push   $0x19
  jmp alltraps
8010738b:	e9 17 fa ff ff       	jmp    80106da7 <alltraps>

80107390 <vector26>:
.globl vector26
vector26:
  pushl $0
80107390:	6a 00                	push   $0x0
  pushl $26
80107392:	6a 1a                	push   $0x1a
  jmp alltraps
80107394:	e9 0e fa ff ff       	jmp    80106da7 <alltraps>

80107399 <vector27>:
.globl vector27
vector27:
  pushl $0
80107399:	6a 00                	push   $0x0
  pushl $27
8010739b:	6a 1b                	push   $0x1b
  jmp alltraps
8010739d:	e9 05 fa ff ff       	jmp    80106da7 <alltraps>

801073a2 <vector28>:
.globl vector28
vector28:
  pushl $0
801073a2:	6a 00                	push   $0x0
  pushl $28
801073a4:	6a 1c                	push   $0x1c
  jmp alltraps
801073a6:	e9 fc f9 ff ff       	jmp    80106da7 <alltraps>

801073ab <vector29>:
.globl vector29
vector29:
  pushl $0
801073ab:	6a 00                	push   $0x0
  pushl $29
801073ad:	6a 1d                	push   $0x1d
  jmp alltraps
801073af:	e9 f3 f9 ff ff       	jmp    80106da7 <alltraps>

801073b4 <vector30>:
.globl vector30
vector30:
  pushl $0
801073b4:	6a 00                	push   $0x0
  pushl $30
801073b6:	6a 1e                	push   $0x1e
  jmp alltraps
801073b8:	e9 ea f9 ff ff       	jmp    80106da7 <alltraps>

801073bd <vector31>:
.globl vector31
vector31:
  pushl $0
801073bd:	6a 00                	push   $0x0
  pushl $31
801073bf:	6a 1f                	push   $0x1f
  jmp alltraps
801073c1:	e9 e1 f9 ff ff       	jmp    80106da7 <alltraps>

801073c6 <vector32>:
.globl vector32
vector32:
  pushl $0
801073c6:	6a 00                	push   $0x0
  pushl $32
801073c8:	6a 20                	push   $0x20
  jmp alltraps
801073ca:	e9 d8 f9 ff ff       	jmp    80106da7 <alltraps>

801073cf <vector33>:
.globl vector33
vector33:
  pushl $0
801073cf:	6a 00                	push   $0x0
  pushl $33
801073d1:	6a 21                	push   $0x21
  jmp alltraps
801073d3:	e9 cf f9 ff ff       	jmp    80106da7 <alltraps>

801073d8 <vector34>:
.globl vector34
vector34:
  pushl $0
801073d8:	6a 00                	push   $0x0
  pushl $34
801073da:	6a 22                	push   $0x22
  jmp alltraps
801073dc:	e9 c6 f9 ff ff       	jmp    80106da7 <alltraps>

801073e1 <vector35>:
.globl vector35
vector35:
  pushl $0
801073e1:	6a 00                	push   $0x0
  pushl $35
801073e3:	6a 23                	push   $0x23
  jmp alltraps
801073e5:	e9 bd f9 ff ff       	jmp    80106da7 <alltraps>

801073ea <vector36>:
.globl vector36
vector36:
  pushl $0
801073ea:	6a 00                	push   $0x0
  pushl $36
801073ec:	6a 24                	push   $0x24
  jmp alltraps
801073ee:	e9 b4 f9 ff ff       	jmp    80106da7 <alltraps>

801073f3 <vector37>:
.globl vector37
vector37:
  pushl $0
801073f3:	6a 00                	push   $0x0
  pushl $37
801073f5:	6a 25                	push   $0x25
  jmp alltraps
801073f7:	e9 ab f9 ff ff       	jmp    80106da7 <alltraps>

801073fc <vector38>:
.globl vector38
vector38:
  pushl $0
801073fc:	6a 00                	push   $0x0
  pushl $38
801073fe:	6a 26                	push   $0x26
  jmp alltraps
80107400:	e9 a2 f9 ff ff       	jmp    80106da7 <alltraps>

80107405 <vector39>:
.globl vector39
vector39:
  pushl $0
80107405:	6a 00                	push   $0x0
  pushl $39
80107407:	6a 27                	push   $0x27
  jmp alltraps
80107409:	e9 99 f9 ff ff       	jmp    80106da7 <alltraps>

8010740e <vector40>:
.globl vector40
vector40:
  pushl $0
8010740e:	6a 00                	push   $0x0
  pushl $40
80107410:	6a 28                	push   $0x28
  jmp alltraps
80107412:	e9 90 f9 ff ff       	jmp    80106da7 <alltraps>

80107417 <vector41>:
.globl vector41
vector41:
  pushl $0
80107417:	6a 00                	push   $0x0
  pushl $41
80107419:	6a 29                	push   $0x29
  jmp alltraps
8010741b:	e9 87 f9 ff ff       	jmp    80106da7 <alltraps>

80107420 <vector42>:
.globl vector42
vector42:
  pushl $0
80107420:	6a 00                	push   $0x0
  pushl $42
80107422:	6a 2a                	push   $0x2a
  jmp alltraps
80107424:	e9 7e f9 ff ff       	jmp    80106da7 <alltraps>

80107429 <vector43>:
.globl vector43
vector43:
  pushl $0
80107429:	6a 00                	push   $0x0
  pushl $43
8010742b:	6a 2b                	push   $0x2b
  jmp alltraps
8010742d:	e9 75 f9 ff ff       	jmp    80106da7 <alltraps>

80107432 <vector44>:
.globl vector44
vector44:
  pushl $0
80107432:	6a 00                	push   $0x0
  pushl $44
80107434:	6a 2c                	push   $0x2c
  jmp alltraps
80107436:	e9 6c f9 ff ff       	jmp    80106da7 <alltraps>

8010743b <vector45>:
.globl vector45
vector45:
  pushl $0
8010743b:	6a 00                	push   $0x0
  pushl $45
8010743d:	6a 2d                	push   $0x2d
  jmp alltraps
8010743f:	e9 63 f9 ff ff       	jmp    80106da7 <alltraps>

80107444 <vector46>:
.globl vector46
vector46:
  pushl $0
80107444:	6a 00                	push   $0x0
  pushl $46
80107446:	6a 2e                	push   $0x2e
  jmp alltraps
80107448:	e9 5a f9 ff ff       	jmp    80106da7 <alltraps>

8010744d <vector47>:
.globl vector47
vector47:
  pushl $0
8010744d:	6a 00                	push   $0x0
  pushl $47
8010744f:	6a 2f                	push   $0x2f
  jmp alltraps
80107451:	e9 51 f9 ff ff       	jmp    80106da7 <alltraps>

80107456 <vector48>:
.globl vector48
vector48:
  pushl $0
80107456:	6a 00                	push   $0x0
  pushl $48
80107458:	6a 30                	push   $0x30
  jmp alltraps
8010745a:	e9 48 f9 ff ff       	jmp    80106da7 <alltraps>

8010745f <vector49>:
.globl vector49
vector49:
  pushl $0
8010745f:	6a 00                	push   $0x0
  pushl $49
80107461:	6a 31                	push   $0x31
  jmp alltraps
80107463:	e9 3f f9 ff ff       	jmp    80106da7 <alltraps>

80107468 <vector50>:
.globl vector50
vector50:
  pushl $0
80107468:	6a 00                	push   $0x0
  pushl $50
8010746a:	6a 32                	push   $0x32
  jmp alltraps
8010746c:	e9 36 f9 ff ff       	jmp    80106da7 <alltraps>

80107471 <vector51>:
.globl vector51
vector51:
  pushl $0
80107471:	6a 00                	push   $0x0
  pushl $51
80107473:	6a 33                	push   $0x33
  jmp alltraps
80107475:	e9 2d f9 ff ff       	jmp    80106da7 <alltraps>

8010747a <vector52>:
.globl vector52
vector52:
  pushl $0
8010747a:	6a 00                	push   $0x0
  pushl $52
8010747c:	6a 34                	push   $0x34
  jmp alltraps
8010747e:	e9 24 f9 ff ff       	jmp    80106da7 <alltraps>

80107483 <vector53>:
.globl vector53
vector53:
  pushl $0
80107483:	6a 00                	push   $0x0
  pushl $53
80107485:	6a 35                	push   $0x35
  jmp alltraps
80107487:	e9 1b f9 ff ff       	jmp    80106da7 <alltraps>

8010748c <vector54>:
.globl vector54
vector54:
  pushl $0
8010748c:	6a 00                	push   $0x0
  pushl $54
8010748e:	6a 36                	push   $0x36
  jmp alltraps
80107490:	e9 12 f9 ff ff       	jmp    80106da7 <alltraps>

80107495 <vector55>:
.globl vector55
vector55:
  pushl $0
80107495:	6a 00                	push   $0x0
  pushl $55
80107497:	6a 37                	push   $0x37
  jmp alltraps
80107499:	e9 09 f9 ff ff       	jmp    80106da7 <alltraps>

8010749e <vector56>:
.globl vector56
vector56:
  pushl $0
8010749e:	6a 00                	push   $0x0
  pushl $56
801074a0:	6a 38                	push   $0x38
  jmp alltraps
801074a2:	e9 00 f9 ff ff       	jmp    80106da7 <alltraps>

801074a7 <vector57>:
.globl vector57
vector57:
  pushl $0
801074a7:	6a 00                	push   $0x0
  pushl $57
801074a9:	6a 39                	push   $0x39
  jmp alltraps
801074ab:	e9 f7 f8 ff ff       	jmp    80106da7 <alltraps>

801074b0 <vector58>:
.globl vector58
vector58:
  pushl $0
801074b0:	6a 00                	push   $0x0
  pushl $58
801074b2:	6a 3a                	push   $0x3a
  jmp alltraps
801074b4:	e9 ee f8 ff ff       	jmp    80106da7 <alltraps>

801074b9 <vector59>:
.globl vector59
vector59:
  pushl $0
801074b9:	6a 00                	push   $0x0
  pushl $59
801074bb:	6a 3b                	push   $0x3b
  jmp alltraps
801074bd:	e9 e5 f8 ff ff       	jmp    80106da7 <alltraps>

801074c2 <vector60>:
.globl vector60
vector60:
  pushl $0
801074c2:	6a 00                	push   $0x0
  pushl $60
801074c4:	6a 3c                	push   $0x3c
  jmp alltraps
801074c6:	e9 dc f8 ff ff       	jmp    80106da7 <alltraps>

801074cb <vector61>:
.globl vector61
vector61:
  pushl $0
801074cb:	6a 00                	push   $0x0
  pushl $61
801074cd:	6a 3d                	push   $0x3d
  jmp alltraps
801074cf:	e9 d3 f8 ff ff       	jmp    80106da7 <alltraps>

801074d4 <vector62>:
.globl vector62
vector62:
  pushl $0
801074d4:	6a 00                	push   $0x0
  pushl $62
801074d6:	6a 3e                	push   $0x3e
  jmp alltraps
801074d8:	e9 ca f8 ff ff       	jmp    80106da7 <alltraps>

801074dd <vector63>:
.globl vector63
vector63:
  pushl $0
801074dd:	6a 00                	push   $0x0
  pushl $63
801074df:	6a 3f                	push   $0x3f
  jmp alltraps
801074e1:	e9 c1 f8 ff ff       	jmp    80106da7 <alltraps>

801074e6 <vector64>:
.globl vector64
vector64:
  pushl $0
801074e6:	6a 00                	push   $0x0
  pushl $64
801074e8:	6a 40                	push   $0x40
  jmp alltraps
801074ea:	e9 b8 f8 ff ff       	jmp    80106da7 <alltraps>

801074ef <vector65>:
.globl vector65
vector65:
  pushl $0
801074ef:	6a 00                	push   $0x0
  pushl $65
801074f1:	6a 41                	push   $0x41
  jmp alltraps
801074f3:	e9 af f8 ff ff       	jmp    80106da7 <alltraps>

801074f8 <vector66>:
.globl vector66
vector66:
  pushl $0
801074f8:	6a 00                	push   $0x0
  pushl $66
801074fa:	6a 42                	push   $0x42
  jmp alltraps
801074fc:	e9 a6 f8 ff ff       	jmp    80106da7 <alltraps>

80107501 <vector67>:
.globl vector67
vector67:
  pushl $0
80107501:	6a 00                	push   $0x0
  pushl $67
80107503:	6a 43                	push   $0x43
  jmp alltraps
80107505:	e9 9d f8 ff ff       	jmp    80106da7 <alltraps>

8010750a <vector68>:
.globl vector68
vector68:
  pushl $0
8010750a:	6a 00                	push   $0x0
  pushl $68
8010750c:	6a 44                	push   $0x44
  jmp alltraps
8010750e:	e9 94 f8 ff ff       	jmp    80106da7 <alltraps>

80107513 <vector69>:
.globl vector69
vector69:
  pushl $0
80107513:	6a 00                	push   $0x0
  pushl $69
80107515:	6a 45                	push   $0x45
  jmp alltraps
80107517:	e9 8b f8 ff ff       	jmp    80106da7 <alltraps>

8010751c <vector70>:
.globl vector70
vector70:
  pushl $0
8010751c:	6a 00                	push   $0x0
  pushl $70
8010751e:	6a 46                	push   $0x46
  jmp alltraps
80107520:	e9 82 f8 ff ff       	jmp    80106da7 <alltraps>

80107525 <vector71>:
.globl vector71
vector71:
  pushl $0
80107525:	6a 00                	push   $0x0
  pushl $71
80107527:	6a 47                	push   $0x47
  jmp alltraps
80107529:	e9 79 f8 ff ff       	jmp    80106da7 <alltraps>

8010752e <vector72>:
.globl vector72
vector72:
  pushl $0
8010752e:	6a 00                	push   $0x0
  pushl $72
80107530:	6a 48                	push   $0x48
  jmp alltraps
80107532:	e9 70 f8 ff ff       	jmp    80106da7 <alltraps>

80107537 <vector73>:
.globl vector73
vector73:
  pushl $0
80107537:	6a 00                	push   $0x0
  pushl $73
80107539:	6a 49                	push   $0x49
  jmp alltraps
8010753b:	e9 67 f8 ff ff       	jmp    80106da7 <alltraps>

80107540 <vector74>:
.globl vector74
vector74:
  pushl $0
80107540:	6a 00                	push   $0x0
  pushl $74
80107542:	6a 4a                	push   $0x4a
  jmp alltraps
80107544:	e9 5e f8 ff ff       	jmp    80106da7 <alltraps>

80107549 <vector75>:
.globl vector75
vector75:
  pushl $0
80107549:	6a 00                	push   $0x0
  pushl $75
8010754b:	6a 4b                	push   $0x4b
  jmp alltraps
8010754d:	e9 55 f8 ff ff       	jmp    80106da7 <alltraps>

80107552 <vector76>:
.globl vector76
vector76:
  pushl $0
80107552:	6a 00                	push   $0x0
  pushl $76
80107554:	6a 4c                	push   $0x4c
  jmp alltraps
80107556:	e9 4c f8 ff ff       	jmp    80106da7 <alltraps>

8010755b <vector77>:
.globl vector77
vector77:
  pushl $0
8010755b:	6a 00                	push   $0x0
  pushl $77
8010755d:	6a 4d                	push   $0x4d
  jmp alltraps
8010755f:	e9 43 f8 ff ff       	jmp    80106da7 <alltraps>

80107564 <vector78>:
.globl vector78
vector78:
  pushl $0
80107564:	6a 00                	push   $0x0
  pushl $78
80107566:	6a 4e                	push   $0x4e
  jmp alltraps
80107568:	e9 3a f8 ff ff       	jmp    80106da7 <alltraps>

8010756d <vector79>:
.globl vector79
vector79:
  pushl $0
8010756d:	6a 00                	push   $0x0
  pushl $79
8010756f:	6a 4f                	push   $0x4f
  jmp alltraps
80107571:	e9 31 f8 ff ff       	jmp    80106da7 <alltraps>

80107576 <vector80>:
.globl vector80
vector80:
  pushl $0
80107576:	6a 00                	push   $0x0
  pushl $80
80107578:	6a 50                	push   $0x50
  jmp alltraps
8010757a:	e9 28 f8 ff ff       	jmp    80106da7 <alltraps>

8010757f <vector81>:
.globl vector81
vector81:
  pushl $0
8010757f:	6a 00                	push   $0x0
  pushl $81
80107581:	6a 51                	push   $0x51
  jmp alltraps
80107583:	e9 1f f8 ff ff       	jmp    80106da7 <alltraps>

80107588 <vector82>:
.globl vector82
vector82:
  pushl $0
80107588:	6a 00                	push   $0x0
  pushl $82
8010758a:	6a 52                	push   $0x52
  jmp alltraps
8010758c:	e9 16 f8 ff ff       	jmp    80106da7 <alltraps>

80107591 <vector83>:
.globl vector83
vector83:
  pushl $0
80107591:	6a 00                	push   $0x0
  pushl $83
80107593:	6a 53                	push   $0x53
  jmp alltraps
80107595:	e9 0d f8 ff ff       	jmp    80106da7 <alltraps>

8010759a <vector84>:
.globl vector84
vector84:
  pushl $0
8010759a:	6a 00                	push   $0x0
  pushl $84
8010759c:	6a 54                	push   $0x54
  jmp alltraps
8010759e:	e9 04 f8 ff ff       	jmp    80106da7 <alltraps>

801075a3 <vector85>:
.globl vector85
vector85:
  pushl $0
801075a3:	6a 00                	push   $0x0
  pushl $85
801075a5:	6a 55                	push   $0x55
  jmp alltraps
801075a7:	e9 fb f7 ff ff       	jmp    80106da7 <alltraps>

801075ac <vector86>:
.globl vector86
vector86:
  pushl $0
801075ac:	6a 00                	push   $0x0
  pushl $86
801075ae:	6a 56                	push   $0x56
  jmp alltraps
801075b0:	e9 f2 f7 ff ff       	jmp    80106da7 <alltraps>

801075b5 <vector87>:
.globl vector87
vector87:
  pushl $0
801075b5:	6a 00                	push   $0x0
  pushl $87
801075b7:	6a 57                	push   $0x57
  jmp alltraps
801075b9:	e9 e9 f7 ff ff       	jmp    80106da7 <alltraps>

801075be <vector88>:
.globl vector88
vector88:
  pushl $0
801075be:	6a 00                	push   $0x0
  pushl $88
801075c0:	6a 58                	push   $0x58
  jmp alltraps
801075c2:	e9 e0 f7 ff ff       	jmp    80106da7 <alltraps>

801075c7 <vector89>:
.globl vector89
vector89:
  pushl $0
801075c7:	6a 00                	push   $0x0
  pushl $89
801075c9:	6a 59                	push   $0x59
  jmp alltraps
801075cb:	e9 d7 f7 ff ff       	jmp    80106da7 <alltraps>

801075d0 <vector90>:
.globl vector90
vector90:
  pushl $0
801075d0:	6a 00                	push   $0x0
  pushl $90
801075d2:	6a 5a                	push   $0x5a
  jmp alltraps
801075d4:	e9 ce f7 ff ff       	jmp    80106da7 <alltraps>

801075d9 <vector91>:
.globl vector91
vector91:
  pushl $0
801075d9:	6a 00                	push   $0x0
  pushl $91
801075db:	6a 5b                	push   $0x5b
  jmp alltraps
801075dd:	e9 c5 f7 ff ff       	jmp    80106da7 <alltraps>

801075e2 <vector92>:
.globl vector92
vector92:
  pushl $0
801075e2:	6a 00                	push   $0x0
  pushl $92
801075e4:	6a 5c                	push   $0x5c
  jmp alltraps
801075e6:	e9 bc f7 ff ff       	jmp    80106da7 <alltraps>

801075eb <vector93>:
.globl vector93
vector93:
  pushl $0
801075eb:	6a 00                	push   $0x0
  pushl $93
801075ed:	6a 5d                	push   $0x5d
  jmp alltraps
801075ef:	e9 b3 f7 ff ff       	jmp    80106da7 <alltraps>

801075f4 <vector94>:
.globl vector94
vector94:
  pushl $0
801075f4:	6a 00                	push   $0x0
  pushl $94
801075f6:	6a 5e                	push   $0x5e
  jmp alltraps
801075f8:	e9 aa f7 ff ff       	jmp    80106da7 <alltraps>

801075fd <vector95>:
.globl vector95
vector95:
  pushl $0
801075fd:	6a 00                	push   $0x0
  pushl $95
801075ff:	6a 5f                	push   $0x5f
  jmp alltraps
80107601:	e9 a1 f7 ff ff       	jmp    80106da7 <alltraps>

80107606 <vector96>:
.globl vector96
vector96:
  pushl $0
80107606:	6a 00                	push   $0x0
  pushl $96
80107608:	6a 60                	push   $0x60
  jmp alltraps
8010760a:	e9 98 f7 ff ff       	jmp    80106da7 <alltraps>

8010760f <vector97>:
.globl vector97
vector97:
  pushl $0
8010760f:	6a 00                	push   $0x0
  pushl $97
80107611:	6a 61                	push   $0x61
  jmp alltraps
80107613:	e9 8f f7 ff ff       	jmp    80106da7 <alltraps>

80107618 <vector98>:
.globl vector98
vector98:
  pushl $0
80107618:	6a 00                	push   $0x0
  pushl $98
8010761a:	6a 62                	push   $0x62
  jmp alltraps
8010761c:	e9 86 f7 ff ff       	jmp    80106da7 <alltraps>

80107621 <vector99>:
.globl vector99
vector99:
  pushl $0
80107621:	6a 00                	push   $0x0
  pushl $99
80107623:	6a 63                	push   $0x63
  jmp alltraps
80107625:	e9 7d f7 ff ff       	jmp    80106da7 <alltraps>

8010762a <vector100>:
.globl vector100
vector100:
  pushl $0
8010762a:	6a 00                	push   $0x0
  pushl $100
8010762c:	6a 64                	push   $0x64
  jmp alltraps
8010762e:	e9 74 f7 ff ff       	jmp    80106da7 <alltraps>

80107633 <vector101>:
.globl vector101
vector101:
  pushl $0
80107633:	6a 00                	push   $0x0
  pushl $101
80107635:	6a 65                	push   $0x65
  jmp alltraps
80107637:	e9 6b f7 ff ff       	jmp    80106da7 <alltraps>

8010763c <vector102>:
.globl vector102
vector102:
  pushl $0
8010763c:	6a 00                	push   $0x0
  pushl $102
8010763e:	6a 66                	push   $0x66
  jmp alltraps
80107640:	e9 62 f7 ff ff       	jmp    80106da7 <alltraps>

80107645 <vector103>:
.globl vector103
vector103:
  pushl $0
80107645:	6a 00                	push   $0x0
  pushl $103
80107647:	6a 67                	push   $0x67
  jmp alltraps
80107649:	e9 59 f7 ff ff       	jmp    80106da7 <alltraps>

8010764e <vector104>:
.globl vector104
vector104:
  pushl $0
8010764e:	6a 00                	push   $0x0
  pushl $104
80107650:	6a 68                	push   $0x68
  jmp alltraps
80107652:	e9 50 f7 ff ff       	jmp    80106da7 <alltraps>

80107657 <vector105>:
.globl vector105
vector105:
  pushl $0
80107657:	6a 00                	push   $0x0
  pushl $105
80107659:	6a 69                	push   $0x69
  jmp alltraps
8010765b:	e9 47 f7 ff ff       	jmp    80106da7 <alltraps>

80107660 <vector106>:
.globl vector106
vector106:
  pushl $0
80107660:	6a 00                	push   $0x0
  pushl $106
80107662:	6a 6a                	push   $0x6a
  jmp alltraps
80107664:	e9 3e f7 ff ff       	jmp    80106da7 <alltraps>

80107669 <vector107>:
.globl vector107
vector107:
  pushl $0
80107669:	6a 00                	push   $0x0
  pushl $107
8010766b:	6a 6b                	push   $0x6b
  jmp alltraps
8010766d:	e9 35 f7 ff ff       	jmp    80106da7 <alltraps>

80107672 <vector108>:
.globl vector108
vector108:
  pushl $0
80107672:	6a 00                	push   $0x0
  pushl $108
80107674:	6a 6c                	push   $0x6c
  jmp alltraps
80107676:	e9 2c f7 ff ff       	jmp    80106da7 <alltraps>

8010767b <vector109>:
.globl vector109
vector109:
  pushl $0
8010767b:	6a 00                	push   $0x0
  pushl $109
8010767d:	6a 6d                	push   $0x6d
  jmp alltraps
8010767f:	e9 23 f7 ff ff       	jmp    80106da7 <alltraps>

80107684 <vector110>:
.globl vector110
vector110:
  pushl $0
80107684:	6a 00                	push   $0x0
  pushl $110
80107686:	6a 6e                	push   $0x6e
  jmp alltraps
80107688:	e9 1a f7 ff ff       	jmp    80106da7 <alltraps>

8010768d <vector111>:
.globl vector111
vector111:
  pushl $0
8010768d:	6a 00                	push   $0x0
  pushl $111
8010768f:	6a 6f                	push   $0x6f
  jmp alltraps
80107691:	e9 11 f7 ff ff       	jmp    80106da7 <alltraps>

80107696 <vector112>:
.globl vector112
vector112:
  pushl $0
80107696:	6a 00                	push   $0x0
  pushl $112
80107698:	6a 70                	push   $0x70
  jmp alltraps
8010769a:	e9 08 f7 ff ff       	jmp    80106da7 <alltraps>

8010769f <vector113>:
.globl vector113
vector113:
  pushl $0
8010769f:	6a 00                	push   $0x0
  pushl $113
801076a1:	6a 71                	push   $0x71
  jmp alltraps
801076a3:	e9 ff f6 ff ff       	jmp    80106da7 <alltraps>

801076a8 <vector114>:
.globl vector114
vector114:
  pushl $0
801076a8:	6a 00                	push   $0x0
  pushl $114
801076aa:	6a 72                	push   $0x72
  jmp alltraps
801076ac:	e9 f6 f6 ff ff       	jmp    80106da7 <alltraps>

801076b1 <vector115>:
.globl vector115
vector115:
  pushl $0
801076b1:	6a 00                	push   $0x0
  pushl $115
801076b3:	6a 73                	push   $0x73
  jmp alltraps
801076b5:	e9 ed f6 ff ff       	jmp    80106da7 <alltraps>

801076ba <vector116>:
.globl vector116
vector116:
  pushl $0
801076ba:	6a 00                	push   $0x0
  pushl $116
801076bc:	6a 74                	push   $0x74
  jmp alltraps
801076be:	e9 e4 f6 ff ff       	jmp    80106da7 <alltraps>

801076c3 <vector117>:
.globl vector117
vector117:
  pushl $0
801076c3:	6a 00                	push   $0x0
  pushl $117
801076c5:	6a 75                	push   $0x75
  jmp alltraps
801076c7:	e9 db f6 ff ff       	jmp    80106da7 <alltraps>

801076cc <vector118>:
.globl vector118
vector118:
  pushl $0
801076cc:	6a 00                	push   $0x0
  pushl $118
801076ce:	6a 76                	push   $0x76
  jmp alltraps
801076d0:	e9 d2 f6 ff ff       	jmp    80106da7 <alltraps>

801076d5 <vector119>:
.globl vector119
vector119:
  pushl $0
801076d5:	6a 00                	push   $0x0
  pushl $119
801076d7:	6a 77                	push   $0x77
  jmp alltraps
801076d9:	e9 c9 f6 ff ff       	jmp    80106da7 <alltraps>

801076de <vector120>:
.globl vector120
vector120:
  pushl $0
801076de:	6a 00                	push   $0x0
  pushl $120
801076e0:	6a 78                	push   $0x78
  jmp alltraps
801076e2:	e9 c0 f6 ff ff       	jmp    80106da7 <alltraps>

801076e7 <vector121>:
.globl vector121
vector121:
  pushl $0
801076e7:	6a 00                	push   $0x0
  pushl $121
801076e9:	6a 79                	push   $0x79
  jmp alltraps
801076eb:	e9 b7 f6 ff ff       	jmp    80106da7 <alltraps>

801076f0 <vector122>:
.globl vector122
vector122:
  pushl $0
801076f0:	6a 00                	push   $0x0
  pushl $122
801076f2:	6a 7a                	push   $0x7a
  jmp alltraps
801076f4:	e9 ae f6 ff ff       	jmp    80106da7 <alltraps>

801076f9 <vector123>:
.globl vector123
vector123:
  pushl $0
801076f9:	6a 00                	push   $0x0
  pushl $123
801076fb:	6a 7b                	push   $0x7b
  jmp alltraps
801076fd:	e9 a5 f6 ff ff       	jmp    80106da7 <alltraps>

80107702 <vector124>:
.globl vector124
vector124:
  pushl $0
80107702:	6a 00                	push   $0x0
  pushl $124
80107704:	6a 7c                	push   $0x7c
  jmp alltraps
80107706:	e9 9c f6 ff ff       	jmp    80106da7 <alltraps>

8010770b <vector125>:
.globl vector125
vector125:
  pushl $0
8010770b:	6a 00                	push   $0x0
  pushl $125
8010770d:	6a 7d                	push   $0x7d
  jmp alltraps
8010770f:	e9 93 f6 ff ff       	jmp    80106da7 <alltraps>

80107714 <vector126>:
.globl vector126
vector126:
  pushl $0
80107714:	6a 00                	push   $0x0
  pushl $126
80107716:	6a 7e                	push   $0x7e
  jmp alltraps
80107718:	e9 8a f6 ff ff       	jmp    80106da7 <alltraps>

8010771d <vector127>:
.globl vector127
vector127:
  pushl $0
8010771d:	6a 00                	push   $0x0
  pushl $127
8010771f:	6a 7f                	push   $0x7f
  jmp alltraps
80107721:	e9 81 f6 ff ff       	jmp    80106da7 <alltraps>

80107726 <vector128>:
.globl vector128
vector128:
  pushl $0
80107726:	6a 00                	push   $0x0
  pushl $128
80107728:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010772d:	e9 75 f6 ff ff       	jmp    80106da7 <alltraps>

80107732 <vector129>:
.globl vector129
vector129:
  pushl $0
80107732:	6a 00                	push   $0x0
  pushl $129
80107734:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80107739:	e9 69 f6 ff ff       	jmp    80106da7 <alltraps>

8010773e <vector130>:
.globl vector130
vector130:
  pushl $0
8010773e:	6a 00                	push   $0x0
  pushl $130
80107740:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80107745:	e9 5d f6 ff ff       	jmp    80106da7 <alltraps>

8010774a <vector131>:
.globl vector131
vector131:
  pushl $0
8010774a:	6a 00                	push   $0x0
  pushl $131
8010774c:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80107751:	e9 51 f6 ff ff       	jmp    80106da7 <alltraps>

80107756 <vector132>:
.globl vector132
vector132:
  pushl $0
80107756:	6a 00                	push   $0x0
  pushl $132
80107758:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010775d:	e9 45 f6 ff ff       	jmp    80106da7 <alltraps>

80107762 <vector133>:
.globl vector133
vector133:
  pushl $0
80107762:	6a 00                	push   $0x0
  pushl $133
80107764:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80107769:	e9 39 f6 ff ff       	jmp    80106da7 <alltraps>

8010776e <vector134>:
.globl vector134
vector134:
  pushl $0
8010776e:	6a 00                	push   $0x0
  pushl $134
80107770:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107775:	e9 2d f6 ff ff       	jmp    80106da7 <alltraps>

8010777a <vector135>:
.globl vector135
vector135:
  pushl $0
8010777a:	6a 00                	push   $0x0
  pushl $135
8010777c:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107781:	e9 21 f6 ff ff       	jmp    80106da7 <alltraps>

80107786 <vector136>:
.globl vector136
vector136:
  pushl $0
80107786:	6a 00                	push   $0x0
  pushl $136
80107788:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010778d:	e9 15 f6 ff ff       	jmp    80106da7 <alltraps>

80107792 <vector137>:
.globl vector137
vector137:
  pushl $0
80107792:	6a 00                	push   $0x0
  pushl $137
80107794:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80107799:	e9 09 f6 ff ff       	jmp    80106da7 <alltraps>

8010779e <vector138>:
.globl vector138
vector138:
  pushl $0
8010779e:	6a 00                	push   $0x0
  pushl $138
801077a0:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801077a5:	e9 fd f5 ff ff       	jmp    80106da7 <alltraps>

801077aa <vector139>:
.globl vector139
vector139:
  pushl $0
801077aa:	6a 00                	push   $0x0
  pushl $139
801077ac:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801077b1:	e9 f1 f5 ff ff       	jmp    80106da7 <alltraps>

801077b6 <vector140>:
.globl vector140
vector140:
  pushl $0
801077b6:	6a 00                	push   $0x0
  pushl $140
801077b8:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801077bd:	e9 e5 f5 ff ff       	jmp    80106da7 <alltraps>

801077c2 <vector141>:
.globl vector141
vector141:
  pushl $0
801077c2:	6a 00                	push   $0x0
  pushl $141
801077c4:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801077c9:	e9 d9 f5 ff ff       	jmp    80106da7 <alltraps>

801077ce <vector142>:
.globl vector142
vector142:
  pushl $0
801077ce:	6a 00                	push   $0x0
  pushl $142
801077d0:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801077d5:	e9 cd f5 ff ff       	jmp    80106da7 <alltraps>

801077da <vector143>:
.globl vector143
vector143:
  pushl $0
801077da:	6a 00                	push   $0x0
  pushl $143
801077dc:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801077e1:	e9 c1 f5 ff ff       	jmp    80106da7 <alltraps>

801077e6 <vector144>:
.globl vector144
vector144:
  pushl $0
801077e6:	6a 00                	push   $0x0
  pushl $144
801077e8:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801077ed:	e9 b5 f5 ff ff       	jmp    80106da7 <alltraps>

801077f2 <vector145>:
.globl vector145
vector145:
  pushl $0
801077f2:	6a 00                	push   $0x0
  pushl $145
801077f4:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801077f9:	e9 a9 f5 ff ff       	jmp    80106da7 <alltraps>

801077fe <vector146>:
.globl vector146
vector146:
  pushl $0
801077fe:	6a 00                	push   $0x0
  pushl $146
80107800:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107805:	e9 9d f5 ff ff       	jmp    80106da7 <alltraps>

8010780a <vector147>:
.globl vector147
vector147:
  pushl $0
8010780a:	6a 00                	push   $0x0
  pushl $147
8010780c:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107811:	e9 91 f5 ff ff       	jmp    80106da7 <alltraps>

80107816 <vector148>:
.globl vector148
vector148:
  pushl $0
80107816:	6a 00                	push   $0x0
  pushl $148
80107818:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010781d:	e9 85 f5 ff ff       	jmp    80106da7 <alltraps>

80107822 <vector149>:
.globl vector149
vector149:
  pushl $0
80107822:	6a 00                	push   $0x0
  pushl $149
80107824:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80107829:	e9 79 f5 ff ff       	jmp    80106da7 <alltraps>

8010782e <vector150>:
.globl vector150
vector150:
  pushl $0
8010782e:	6a 00                	push   $0x0
  pushl $150
80107830:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107835:	e9 6d f5 ff ff       	jmp    80106da7 <alltraps>

8010783a <vector151>:
.globl vector151
vector151:
  pushl $0
8010783a:	6a 00                	push   $0x0
  pushl $151
8010783c:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80107841:	e9 61 f5 ff ff       	jmp    80106da7 <alltraps>

80107846 <vector152>:
.globl vector152
vector152:
  pushl $0
80107846:	6a 00                	push   $0x0
  pushl $152
80107848:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010784d:	e9 55 f5 ff ff       	jmp    80106da7 <alltraps>

80107852 <vector153>:
.globl vector153
vector153:
  pushl $0
80107852:	6a 00                	push   $0x0
  pushl $153
80107854:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80107859:	e9 49 f5 ff ff       	jmp    80106da7 <alltraps>

8010785e <vector154>:
.globl vector154
vector154:
  pushl $0
8010785e:	6a 00                	push   $0x0
  pushl $154
80107860:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80107865:	e9 3d f5 ff ff       	jmp    80106da7 <alltraps>

8010786a <vector155>:
.globl vector155
vector155:
  pushl $0
8010786a:	6a 00                	push   $0x0
  pushl $155
8010786c:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107871:	e9 31 f5 ff ff       	jmp    80106da7 <alltraps>

80107876 <vector156>:
.globl vector156
vector156:
  pushl $0
80107876:	6a 00                	push   $0x0
  pushl $156
80107878:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010787d:	e9 25 f5 ff ff       	jmp    80106da7 <alltraps>

80107882 <vector157>:
.globl vector157
vector157:
  pushl $0
80107882:	6a 00                	push   $0x0
  pushl $157
80107884:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80107889:	e9 19 f5 ff ff       	jmp    80106da7 <alltraps>

8010788e <vector158>:
.globl vector158
vector158:
  pushl $0
8010788e:	6a 00                	push   $0x0
  pushl $158
80107890:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107895:	e9 0d f5 ff ff       	jmp    80106da7 <alltraps>

8010789a <vector159>:
.globl vector159
vector159:
  pushl $0
8010789a:	6a 00                	push   $0x0
  pushl $159
8010789c:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801078a1:	e9 01 f5 ff ff       	jmp    80106da7 <alltraps>

801078a6 <vector160>:
.globl vector160
vector160:
  pushl $0
801078a6:	6a 00                	push   $0x0
  pushl $160
801078a8:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801078ad:	e9 f5 f4 ff ff       	jmp    80106da7 <alltraps>

801078b2 <vector161>:
.globl vector161
vector161:
  pushl $0
801078b2:	6a 00                	push   $0x0
  pushl $161
801078b4:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801078b9:	e9 e9 f4 ff ff       	jmp    80106da7 <alltraps>

801078be <vector162>:
.globl vector162
vector162:
  pushl $0
801078be:	6a 00                	push   $0x0
  pushl $162
801078c0:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801078c5:	e9 dd f4 ff ff       	jmp    80106da7 <alltraps>

801078ca <vector163>:
.globl vector163
vector163:
  pushl $0
801078ca:	6a 00                	push   $0x0
  pushl $163
801078cc:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801078d1:	e9 d1 f4 ff ff       	jmp    80106da7 <alltraps>

801078d6 <vector164>:
.globl vector164
vector164:
  pushl $0
801078d6:	6a 00                	push   $0x0
  pushl $164
801078d8:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801078dd:	e9 c5 f4 ff ff       	jmp    80106da7 <alltraps>

801078e2 <vector165>:
.globl vector165
vector165:
  pushl $0
801078e2:	6a 00                	push   $0x0
  pushl $165
801078e4:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801078e9:	e9 b9 f4 ff ff       	jmp    80106da7 <alltraps>

801078ee <vector166>:
.globl vector166
vector166:
  pushl $0
801078ee:	6a 00                	push   $0x0
  pushl $166
801078f0:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801078f5:	e9 ad f4 ff ff       	jmp    80106da7 <alltraps>

801078fa <vector167>:
.globl vector167
vector167:
  pushl $0
801078fa:	6a 00                	push   $0x0
  pushl $167
801078fc:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107901:	e9 a1 f4 ff ff       	jmp    80106da7 <alltraps>

80107906 <vector168>:
.globl vector168
vector168:
  pushl $0
80107906:	6a 00                	push   $0x0
  pushl $168
80107908:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010790d:	e9 95 f4 ff ff       	jmp    80106da7 <alltraps>

80107912 <vector169>:
.globl vector169
vector169:
  pushl $0
80107912:	6a 00                	push   $0x0
  pushl $169
80107914:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80107919:	e9 89 f4 ff ff       	jmp    80106da7 <alltraps>

8010791e <vector170>:
.globl vector170
vector170:
  pushl $0
8010791e:	6a 00                	push   $0x0
  pushl $170
80107920:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107925:	e9 7d f4 ff ff       	jmp    80106da7 <alltraps>

8010792a <vector171>:
.globl vector171
vector171:
  pushl $0
8010792a:	6a 00                	push   $0x0
  pushl $171
8010792c:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107931:	e9 71 f4 ff ff       	jmp    80106da7 <alltraps>

80107936 <vector172>:
.globl vector172
vector172:
  pushl $0
80107936:	6a 00                	push   $0x0
  pushl $172
80107938:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010793d:	e9 65 f4 ff ff       	jmp    80106da7 <alltraps>

80107942 <vector173>:
.globl vector173
vector173:
  pushl $0
80107942:	6a 00                	push   $0x0
  pushl $173
80107944:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80107949:	e9 59 f4 ff ff       	jmp    80106da7 <alltraps>

8010794e <vector174>:
.globl vector174
vector174:
  pushl $0
8010794e:	6a 00                	push   $0x0
  pushl $174
80107950:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107955:	e9 4d f4 ff ff       	jmp    80106da7 <alltraps>

8010795a <vector175>:
.globl vector175
vector175:
  pushl $0
8010795a:	6a 00                	push   $0x0
  pushl $175
8010795c:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107961:	e9 41 f4 ff ff       	jmp    80106da7 <alltraps>

80107966 <vector176>:
.globl vector176
vector176:
  pushl $0
80107966:	6a 00                	push   $0x0
  pushl $176
80107968:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010796d:	e9 35 f4 ff ff       	jmp    80106da7 <alltraps>

80107972 <vector177>:
.globl vector177
vector177:
  pushl $0
80107972:	6a 00                	push   $0x0
  pushl $177
80107974:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80107979:	e9 29 f4 ff ff       	jmp    80106da7 <alltraps>

8010797e <vector178>:
.globl vector178
vector178:
  pushl $0
8010797e:	6a 00                	push   $0x0
  pushl $178
80107980:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107985:	e9 1d f4 ff ff       	jmp    80106da7 <alltraps>

8010798a <vector179>:
.globl vector179
vector179:
  pushl $0
8010798a:	6a 00                	push   $0x0
  pushl $179
8010798c:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107991:	e9 11 f4 ff ff       	jmp    80106da7 <alltraps>

80107996 <vector180>:
.globl vector180
vector180:
  pushl $0
80107996:	6a 00                	push   $0x0
  pushl $180
80107998:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010799d:	e9 05 f4 ff ff       	jmp    80106da7 <alltraps>

801079a2 <vector181>:
.globl vector181
vector181:
  pushl $0
801079a2:	6a 00                	push   $0x0
  pushl $181
801079a4:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801079a9:	e9 f9 f3 ff ff       	jmp    80106da7 <alltraps>

801079ae <vector182>:
.globl vector182
vector182:
  pushl $0
801079ae:	6a 00                	push   $0x0
  pushl $182
801079b0:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801079b5:	e9 ed f3 ff ff       	jmp    80106da7 <alltraps>

801079ba <vector183>:
.globl vector183
vector183:
  pushl $0
801079ba:	6a 00                	push   $0x0
  pushl $183
801079bc:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801079c1:	e9 e1 f3 ff ff       	jmp    80106da7 <alltraps>

801079c6 <vector184>:
.globl vector184
vector184:
  pushl $0
801079c6:	6a 00                	push   $0x0
  pushl $184
801079c8:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801079cd:	e9 d5 f3 ff ff       	jmp    80106da7 <alltraps>

801079d2 <vector185>:
.globl vector185
vector185:
  pushl $0
801079d2:	6a 00                	push   $0x0
  pushl $185
801079d4:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801079d9:	e9 c9 f3 ff ff       	jmp    80106da7 <alltraps>

801079de <vector186>:
.globl vector186
vector186:
  pushl $0
801079de:	6a 00                	push   $0x0
  pushl $186
801079e0:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801079e5:	e9 bd f3 ff ff       	jmp    80106da7 <alltraps>

801079ea <vector187>:
.globl vector187
vector187:
  pushl $0
801079ea:	6a 00                	push   $0x0
  pushl $187
801079ec:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801079f1:	e9 b1 f3 ff ff       	jmp    80106da7 <alltraps>

801079f6 <vector188>:
.globl vector188
vector188:
  pushl $0
801079f6:	6a 00                	push   $0x0
  pushl $188
801079f8:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801079fd:	e9 a5 f3 ff ff       	jmp    80106da7 <alltraps>

80107a02 <vector189>:
.globl vector189
vector189:
  pushl $0
80107a02:	6a 00                	push   $0x0
  pushl $189
80107a04:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80107a09:	e9 99 f3 ff ff       	jmp    80106da7 <alltraps>

80107a0e <vector190>:
.globl vector190
vector190:
  pushl $0
80107a0e:	6a 00                	push   $0x0
  pushl $190
80107a10:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107a15:	e9 8d f3 ff ff       	jmp    80106da7 <alltraps>

80107a1a <vector191>:
.globl vector191
vector191:
  pushl $0
80107a1a:	6a 00                	push   $0x0
  pushl $191
80107a1c:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107a21:	e9 81 f3 ff ff       	jmp    80106da7 <alltraps>

80107a26 <vector192>:
.globl vector192
vector192:
  pushl $0
80107a26:	6a 00                	push   $0x0
  pushl $192
80107a28:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80107a2d:	e9 75 f3 ff ff       	jmp    80106da7 <alltraps>

80107a32 <vector193>:
.globl vector193
vector193:
  pushl $0
80107a32:	6a 00                	push   $0x0
  pushl $193
80107a34:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80107a39:	e9 69 f3 ff ff       	jmp    80106da7 <alltraps>

80107a3e <vector194>:
.globl vector194
vector194:
  pushl $0
80107a3e:	6a 00                	push   $0x0
  pushl $194
80107a40:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107a45:	e9 5d f3 ff ff       	jmp    80106da7 <alltraps>

80107a4a <vector195>:
.globl vector195
vector195:
  pushl $0
80107a4a:	6a 00                	push   $0x0
  pushl $195
80107a4c:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107a51:	e9 51 f3 ff ff       	jmp    80106da7 <alltraps>

80107a56 <vector196>:
.globl vector196
vector196:
  pushl $0
80107a56:	6a 00                	push   $0x0
  pushl $196
80107a58:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80107a5d:	e9 45 f3 ff ff       	jmp    80106da7 <alltraps>

80107a62 <vector197>:
.globl vector197
vector197:
  pushl $0
80107a62:	6a 00                	push   $0x0
  pushl $197
80107a64:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80107a69:	e9 39 f3 ff ff       	jmp    80106da7 <alltraps>

80107a6e <vector198>:
.globl vector198
vector198:
  pushl $0
80107a6e:	6a 00                	push   $0x0
  pushl $198
80107a70:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107a75:	e9 2d f3 ff ff       	jmp    80106da7 <alltraps>

80107a7a <vector199>:
.globl vector199
vector199:
  pushl $0
80107a7a:	6a 00                	push   $0x0
  pushl $199
80107a7c:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107a81:	e9 21 f3 ff ff       	jmp    80106da7 <alltraps>

80107a86 <vector200>:
.globl vector200
vector200:
  pushl $0
80107a86:	6a 00                	push   $0x0
  pushl $200
80107a88:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80107a8d:	e9 15 f3 ff ff       	jmp    80106da7 <alltraps>

80107a92 <vector201>:
.globl vector201
vector201:
  pushl $0
80107a92:	6a 00                	push   $0x0
  pushl $201
80107a94:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80107a99:	e9 09 f3 ff ff       	jmp    80106da7 <alltraps>

80107a9e <vector202>:
.globl vector202
vector202:
  pushl $0
80107a9e:	6a 00                	push   $0x0
  pushl $202
80107aa0:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107aa5:	e9 fd f2 ff ff       	jmp    80106da7 <alltraps>

80107aaa <vector203>:
.globl vector203
vector203:
  pushl $0
80107aaa:	6a 00                	push   $0x0
  pushl $203
80107aac:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107ab1:	e9 f1 f2 ff ff       	jmp    80106da7 <alltraps>

80107ab6 <vector204>:
.globl vector204
vector204:
  pushl $0
80107ab6:	6a 00                	push   $0x0
  pushl $204
80107ab8:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80107abd:	e9 e5 f2 ff ff       	jmp    80106da7 <alltraps>

80107ac2 <vector205>:
.globl vector205
vector205:
  pushl $0
80107ac2:	6a 00                	push   $0x0
  pushl $205
80107ac4:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80107ac9:	e9 d9 f2 ff ff       	jmp    80106da7 <alltraps>

80107ace <vector206>:
.globl vector206
vector206:
  pushl $0
80107ace:	6a 00                	push   $0x0
  pushl $206
80107ad0:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107ad5:	e9 cd f2 ff ff       	jmp    80106da7 <alltraps>

80107ada <vector207>:
.globl vector207
vector207:
  pushl $0
80107ada:	6a 00                	push   $0x0
  pushl $207
80107adc:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107ae1:	e9 c1 f2 ff ff       	jmp    80106da7 <alltraps>

80107ae6 <vector208>:
.globl vector208
vector208:
  pushl $0
80107ae6:	6a 00                	push   $0x0
  pushl $208
80107ae8:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80107aed:	e9 b5 f2 ff ff       	jmp    80106da7 <alltraps>

80107af2 <vector209>:
.globl vector209
vector209:
  pushl $0
80107af2:	6a 00                	push   $0x0
  pushl $209
80107af4:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80107af9:	e9 a9 f2 ff ff       	jmp    80106da7 <alltraps>

80107afe <vector210>:
.globl vector210
vector210:
  pushl $0
80107afe:	6a 00                	push   $0x0
  pushl $210
80107b00:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107b05:	e9 9d f2 ff ff       	jmp    80106da7 <alltraps>

80107b0a <vector211>:
.globl vector211
vector211:
  pushl $0
80107b0a:	6a 00                	push   $0x0
  pushl $211
80107b0c:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107b11:	e9 91 f2 ff ff       	jmp    80106da7 <alltraps>

80107b16 <vector212>:
.globl vector212
vector212:
  pushl $0
80107b16:	6a 00                	push   $0x0
  pushl $212
80107b18:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80107b1d:	e9 85 f2 ff ff       	jmp    80106da7 <alltraps>

80107b22 <vector213>:
.globl vector213
vector213:
  pushl $0
80107b22:	6a 00                	push   $0x0
  pushl $213
80107b24:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80107b29:	e9 79 f2 ff ff       	jmp    80106da7 <alltraps>

80107b2e <vector214>:
.globl vector214
vector214:
  pushl $0
80107b2e:	6a 00                	push   $0x0
  pushl $214
80107b30:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107b35:	e9 6d f2 ff ff       	jmp    80106da7 <alltraps>

80107b3a <vector215>:
.globl vector215
vector215:
  pushl $0
80107b3a:	6a 00                	push   $0x0
  pushl $215
80107b3c:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107b41:	e9 61 f2 ff ff       	jmp    80106da7 <alltraps>

80107b46 <vector216>:
.globl vector216
vector216:
  pushl $0
80107b46:	6a 00                	push   $0x0
  pushl $216
80107b48:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80107b4d:	e9 55 f2 ff ff       	jmp    80106da7 <alltraps>

80107b52 <vector217>:
.globl vector217
vector217:
  pushl $0
80107b52:	6a 00                	push   $0x0
  pushl $217
80107b54:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80107b59:	e9 49 f2 ff ff       	jmp    80106da7 <alltraps>

80107b5e <vector218>:
.globl vector218
vector218:
  pushl $0
80107b5e:	6a 00                	push   $0x0
  pushl $218
80107b60:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107b65:	e9 3d f2 ff ff       	jmp    80106da7 <alltraps>

80107b6a <vector219>:
.globl vector219
vector219:
  pushl $0
80107b6a:	6a 00                	push   $0x0
  pushl $219
80107b6c:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107b71:	e9 31 f2 ff ff       	jmp    80106da7 <alltraps>

80107b76 <vector220>:
.globl vector220
vector220:
  pushl $0
80107b76:	6a 00                	push   $0x0
  pushl $220
80107b78:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80107b7d:	e9 25 f2 ff ff       	jmp    80106da7 <alltraps>

80107b82 <vector221>:
.globl vector221
vector221:
  pushl $0
80107b82:	6a 00                	push   $0x0
  pushl $221
80107b84:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80107b89:	e9 19 f2 ff ff       	jmp    80106da7 <alltraps>

80107b8e <vector222>:
.globl vector222
vector222:
  pushl $0
80107b8e:	6a 00                	push   $0x0
  pushl $222
80107b90:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107b95:	e9 0d f2 ff ff       	jmp    80106da7 <alltraps>

80107b9a <vector223>:
.globl vector223
vector223:
  pushl $0
80107b9a:	6a 00                	push   $0x0
  pushl $223
80107b9c:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107ba1:	e9 01 f2 ff ff       	jmp    80106da7 <alltraps>

80107ba6 <vector224>:
.globl vector224
vector224:
  pushl $0
80107ba6:	6a 00                	push   $0x0
  pushl $224
80107ba8:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80107bad:	e9 f5 f1 ff ff       	jmp    80106da7 <alltraps>

80107bb2 <vector225>:
.globl vector225
vector225:
  pushl $0
80107bb2:	6a 00                	push   $0x0
  pushl $225
80107bb4:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107bb9:	e9 e9 f1 ff ff       	jmp    80106da7 <alltraps>

80107bbe <vector226>:
.globl vector226
vector226:
  pushl $0
80107bbe:	6a 00                	push   $0x0
  pushl $226
80107bc0:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107bc5:	e9 dd f1 ff ff       	jmp    80106da7 <alltraps>

80107bca <vector227>:
.globl vector227
vector227:
  pushl $0
80107bca:	6a 00                	push   $0x0
  pushl $227
80107bcc:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107bd1:	e9 d1 f1 ff ff       	jmp    80106da7 <alltraps>

80107bd6 <vector228>:
.globl vector228
vector228:
  pushl $0
80107bd6:	6a 00                	push   $0x0
  pushl $228
80107bd8:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80107bdd:	e9 c5 f1 ff ff       	jmp    80106da7 <alltraps>

80107be2 <vector229>:
.globl vector229
vector229:
  pushl $0
80107be2:	6a 00                	push   $0x0
  pushl $229
80107be4:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80107be9:	e9 b9 f1 ff ff       	jmp    80106da7 <alltraps>

80107bee <vector230>:
.globl vector230
vector230:
  pushl $0
80107bee:	6a 00                	push   $0x0
  pushl $230
80107bf0:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107bf5:	e9 ad f1 ff ff       	jmp    80106da7 <alltraps>

80107bfa <vector231>:
.globl vector231
vector231:
  pushl $0
80107bfa:	6a 00                	push   $0x0
  pushl $231
80107bfc:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107c01:	e9 a1 f1 ff ff       	jmp    80106da7 <alltraps>

80107c06 <vector232>:
.globl vector232
vector232:
  pushl $0
80107c06:	6a 00                	push   $0x0
  pushl $232
80107c08:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107c0d:	e9 95 f1 ff ff       	jmp    80106da7 <alltraps>

80107c12 <vector233>:
.globl vector233
vector233:
  pushl $0
80107c12:	6a 00                	push   $0x0
  pushl $233
80107c14:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107c19:	e9 89 f1 ff ff       	jmp    80106da7 <alltraps>

80107c1e <vector234>:
.globl vector234
vector234:
  pushl $0
80107c1e:	6a 00                	push   $0x0
  pushl $234
80107c20:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107c25:	e9 7d f1 ff ff       	jmp    80106da7 <alltraps>

80107c2a <vector235>:
.globl vector235
vector235:
  pushl $0
80107c2a:	6a 00                	push   $0x0
  pushl $235
80107c2c:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107c31:	e9 71 f1 ff ff       	jmp    80106da7 <alltraps>

80107c36 <vector236>:
.globl vector236
vector236:
  pushl $0
80107c36:	6a 00                	push   $0x0
  pushl $236
80107c38:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107c3d:	e9 65 f1 ff ff       	jmp    80106da7 <alltraps>

80107c42 <vector237>:
.globl vector237
vector237:
  pushl $0
80107c42:	6a 00                	push   $0x0
  pushl $237
80107c44:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107c49:	e9 59 f1 ff ff       	jmp    80106da7 <alltraps>

80107c4e <vector238>:
.globl vector238
vector238:
  pushl $0
80107c4e:	6a 00                	push   $0x0
  pushl $238
80107c50:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107c55:	e9 4d f1 ff ff       	jmp    80106da7 <alltraps>

80107c5a <vector239>:
.globl vector239
vector239:
  pushl $0
80107c5a:	6a 00                	push   $0x0
  pushl $239
80107c5c:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107c61:	e9 41 f1 ff ff       	jmp    80106da7 <alltraps>

80107c66 <vector240>:
.globl vector240
vector240:
  pushl $0
80107c66:	6a 00                	push   $0x0
  pushl $240
80107c68:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107c6d:	e9 35 f1 ff ff       	jmp    80106da7 <alltraps>

80107c72 <vector241>:
.globl vector241
vector241:
  pushl $0
80107c72:	6a 00                	push   $0x0
  pushl $241
80107c74:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107c79:	e9 29 f1 ff ff       	jmp    80106da7 <alltraps>

80107c7e <vector242>:
.globl vector242
vector242:
  pushl $0
80107c7e:	6a 00                	push   $0x0
  pushl $242
80107c80:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107c85:	e9 1d f1 ff ff       	jmp    80106da7 <alltraps>

80107c8a <vector243>:
.globl vector243
vector243:
  pushl $0
80107c8a:	6a 00                	push   $0x0
  pushl $243
80107c8c:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107c91:	e9 11 f1 ff ff       	jmp    80106da7 <alltraps>

80107c96 <vector244>:
.globl vector244
vector244:
  pushl $0
80107c96:	6a 00                	push   $0x0
  pushl $244
80107c98:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107c9d:	e9 05 f1 ff ff       	jmp    80106da7 <alltraps>

80107ca2 <vector245>:
.globl vector245
vector245:
  pushl $0
80107ca2:	6a 00                	push   $0x0
  pushl $245
80107ca4:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107ca9:	e9 f9 f0 ff ff       	jmp    80106da7 <alltraps>

80107cae <vector246>:
.globl vector246
vector246:
  pushl $0
80107cae:	6a 00                	push   $0x0
  pushl $246
80107cb0:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107cb5:	e9 ed f0 ff ff       	jmp    80106da7 <alltraps>

80107cba <vector247>:
.globl vector247
vector247:
  pushl $0
80107cba:	6a 00                	push   $0x0
  pushl $247
80107cbc:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107cc1:	e9 e1 f0 ff ff       	jmp    80106da7 <alltraps>

80107cc6 <vector248>:
.globl vector248
vector248:
  pushl $0
80107cc6:	6a 00                	push   $0x0
  pushl $248
80107cc8:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107ccd:	e9 d5 f0 ff ff       	jmp    80106da7 <alltraps>

80107cd2 <vector249>:
.globl vector249
vector249:
  pushl $0
80107cd2:	6a 00                	push   $0x0
  pushl $249
80107cd4:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107cd9:	e9 c9 f0 ff ff       	jmp    80106da7 <alltraps>

80107cde <vector250>:
.globl vector250
vector250:
  pushl $0
80107cde:	6a 00                	push   $0x0
  pushl $250
80107ce0:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107ce5:	e9 bd f0 ff ff       	jmp    80106da7 <alltraps>

80107cea <vector251>:
.globl vector251
vector251:
  pushl $0
80107cea:	6a 00                	push   $0x0
  pushl $251
80107cec:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107cf1:	e9 b1 f0 ff ff       	jmp    80106da7 <alltraps>

80107cf6 <vector252>:
.globl vector252
vector252:
  pushl $0
80107cf6:	6a 00                	push   $0x0
  pushl $252
80107cf8:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107cfd:	e9 a5 f0 ff ff       	jmp    80106da7 <alltraps>

80107d02 <vector253>:
.globl vector253
vector253:
  pushl $0
80107d02:	6a 00                	push   $0x0
  pushl $253
80107d04:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107d09:	e9 99 f0 ff ff       	jmp    80106da7 <alltraps>

80107d0e <vector254>:
.globl vector254
vector254:
  pushl $0
80107d0e:	6a 00                	push   $0x0
  pushl $254
80107d10:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107d15:	e9 8d f0 ff ff       	jmp    80106da7 <alltraps>

80107d1a <vector255>:
.globl vector255
vector255:
  pushl $0
80107d1a:	6a 00                	push   $0x0
  pushl $255
80107d1c:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107d21:	e9 81 f0 ff ff       	jmp    80106da7 <alltraps>
80107d26:	66 90                	xchg   %ax,%ax
80107d28:	66 90                	xchg   %ax,%ax
80107d2a:	66 90                	xchg   %ax,%ax
80107d2c:	66 90                	xchg   %ax,%ax
80107d2e:	66 90                	xchg   %ax,%ax

80107d30 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107d30:	55                   	push   %ebp
80107d31:	89 e5                	mov    %esp,%ebp
80107d33:	83 ec 28             	sub    $0x28,%esp
80107d36:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80107d39:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107d3b:	c1 ea 16             	shr    $0x16,%edx
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107d3e:	89 7d fc             	mov    %edi,-0x4(%ebp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107d41:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107d44:	89 75 f8             	mov    %esi,-0x8(%ebp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
80107d47:	8b 07                	mov    (%edi),%eax
80107d49:	a8 01                	test   $0x1,%al
80107d4b:	74 2b                	je     80107d78 <walkpgdir+0x48>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107d4d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107d52:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107d58:	c1 eb 0a             	shr    $0xa,%ebx
}
80107d5b:	8b 7d fc             	mov    -0x4(%ebp),%edi
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107d5e:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
80107d64:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
80107d67:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107d6a:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107d6d:	89 ec                	mov    %ebp,%esp
80107d6f:	5d                   	pop    %ebp
80107d70:	c3                   	ret    
80107d71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107d78:	85 c9                	test   %ecx,%ecx
80107d7a:	74 34                	je     80107db0 <walkpgdir+0x80>
80107d7c:	e8 df a7 ff ff       	call   80102560 <kalloc>
80107d81:	85 c0                	test   %eax,%eax
80107d83:	89 c6                	mov    %eax,%esi
80107d85:	74 29                	je     80107db0 <walkpgdir+0x80>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80107d87:	b8 00 10 00 00       	mov    $0x1000,%eax
80107d8c:	31 d2                	xor    %edx,%edx
80107d8e:	89 44 24 08          	mov    %eax,0x8(%esp)
80107d92:	89 54 24 04          	mov    %edx,0x4(%esp)
80107d96:	89 34 24             	mov    %esi,(%esp)
80107d99:	e8 22 dd ff ff       	call   80105ac0 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107d9e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107da4:	83 c8 07             	or     $0x7,%eax
80107da7:	89 07                	mov    %eax,(%edi)
80107da9:	eb ad                	jmp    80107d58 <walkpgdir+0x28>
80107dab:	90                   	nop
80107dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  return &pgtab[PTX(va)];
}
80107db0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
80107db3:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80107db5:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107db8:	8b 7d fc             	mov    -0x4(%ebp),%edi
80107dbb:	89 ec                	mov    %ebp,%esp
80107dbd:	5d                   	pop    %ebp
80107dbe:	c3                   	ret    
80107dbf:	90                   	nop

80107dc0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107dc0:	55                   	push   %ebp
80107dc1:	89 e5                	mov    %esp,%ebp
80107dc3:	57                   	push   %edi
80107dc4:	56                   	push   %esi
80107dc5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107dc6:	89 d3                	mov    %edx,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107dc8:	83 ec 2c             	sub    $0x2c,%esp
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107dcb:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107dd1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107dd4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107dd8:	8b 7d 08             	mov    0x8(%ebp),%edi
80107ddb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107de0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80107de3:	8b 45 0c             	mov    0xc(%ebp),%eax
80107de6:	29 df                	sub    %ebx,%edi
80107de8:	83 c8 01             	or     $0x1,%eax
80107deb:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107dee:	eb 17                	jmp    80107e07 <mappages+0x47>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80107df0:	f6 00 01             	testb  $0x1,(%eax)
80107df3:	75 45                	jne    80107e3a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80107df5:	8b 55 dc             	mov    -0x24(%ebp),%edx
80107df8:	09 d6                	or     %edx,%esi
    if(a == last)
80107dfa:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80107dfd:	89 30                	mov    %esi,(%eax)
    if(a == last)
80107dff:	74 2f                	je     80107e30 <mappages+0x70>
      break;
    a += PGSIZE;
80107e01:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107e07:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107e0a:	b9 01 00 00 00       	mov    $0x1,%ecx
80107e0f:	89 da                	mov    %ebx,%edx
80107e11:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80107e14:	e8 17 ff ff ff       	call   80107d30 <walkpgdir>
80107e19:	85 c0                	test   %eax,%eax
80107e1b:	75 d3                	jne    80107df0 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80107e1d:	83 c4 2c             	add    $0x2c,%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
80107e20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80107e25:	5b                   	pop    %ebx
80107e26:	5e                   	pop    %esi
80107e27:	5f                   	pop    %edi
80107e28:	5d                   	pop    %ebp
80107e29:	c3                   	ret    
80107e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107e30:	83 c4 2c             	add    $0x2c,%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80107e33:	31 c0                	xor    %eax,%eax
}
80107e35:	5b                   	pop    %ebx
80107e36:	5e                   	pop    %esi
80107e37:	5f                   	pop    %edi
80107e38:	5d                   	pop    %ebp
80107e39:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
80107e3a:	c7 04 24 58 90 10 80 	movl   $0x80109058,(%esp)
80107e41:	e8 fa 84 ff ff       	call   80100340 <panic>
80107e46:	8d 76 00             	lea    0x0(%esi),%esi
80107e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107e50 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107e50:	55                   	push   %ebp
80107e51:	89 e5                	mov    %esp,%ebp
80107e53:	57                   	push   %edi
80107e54:	89 c7                	mov    %eax,%edi
80107e56:	56                   	push   %esi
80107e57:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107e58:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107e5e:	83 ec 2c             	sub    $0x2c,%esp
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107e61:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107e67:	39 d3                	cmp    %edx,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107e69:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80107e6c:	73 62                	jae    80107ed0 <deallocuvm.part.0+0x80>
80107e6e:	89 d6                	mov    %edx,%esi
80107e70:	eb 39                	jmp    80107eab <deallocuvm.part.0+0x5b>
80107e72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80107e78:	8b 10                	mov    (%eax),%edx
80107e7a:	f6 c2 01             	test   $0x1,%dl
80107e7d:	74 22                	je     80107ea1 <deallocuvm.part.0+0x51>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80107e7f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107e85:	74 54                	je     80107edb <deallocuvm.part.0+0x8b>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80107e87:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80107e8d:	89 14 24             	mov    %edx,(%esp)
80107e90:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107e93:	e8 f8 a4 ff ff       	call   80102390 <kfree>
      *pte = 0;
80107e98:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107e9b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80107ea1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107ea7:	39 f3                	cmp    %esi,%ebx
80107ea9:	73 25                	jae    80107ed0 <deallocuvm.part.0+0x80>
    pte = walkpgdir(pgdir, (char*)a, 0);
80107eab:	31 c9                	xor    %ecx,%ecx
80107ead:	89 da                	mov    %ebx,%edx
80107eaf:	89 f8                	mov    %edi,%eax
80107eb1:	e8 7a fe ff ff       	call   80107d30 <walkpgdir>
    if(!pte)
80107eb6:	85 c0                	test   %eax,%eax
80107eb8:	75 be                	jne    80107e78 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107eba:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80107ec0:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80107ec6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107ecc:	39 f3                	cmp    %esi,%ebx
80107ece:	72 db                	jb     80107eab <deallocuvm.part.0+0x5b>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80107ed0:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107ed3:	83 c4 2c             	add    $0x2c,%esp
80107ed6:	5b                   	pop    %ebx
80107ed7:	5e                   	pop    %esi
80107ed8:	5f                   	pop    %edi
80107ed9:	5d                   	pop    %ebp
80107eda:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80107edb:	c7 04 24 46 89 10 80 	movl   $0x80108946,(%esp)
80107ee2:	e8 59 84 ff ff       	call   80100340 <panic>
80107ee7:	89 f6                	mov    %esi,%esi
80107ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107ef0 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80107ef0:	55                   	push   %ebp
80107ef1:	89 e5                	mov    %esp,%ebp
80107ef3:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80107ef6:	e8 b5 ba ff ff       	call   801039b0 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107efb:	31 c9                	xor    %ecx,%ecx
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80107efd:	66 c7 45 f2 2f 00    	movw   $0x2f,-0xe(%ebp)
80107f03:	8d 14 80             	lea    (%eax,%eax,4),%edx
80107f06:	8d 14 50             	lea    (%eax,%edx,2),%edx
80107f09:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107f0e:	c1 e2 04             	shl    $0x4,%edx
80107f11:	66 89 82 58 48 11 80 	mov    %ax,-0x7feeb7a8(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107f18:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107f1d:	66 89 82 60 48 11 80 	mov    %ax,-0x7feeb7a0(%edx)
80107f24:	31 c0                	xor    %eax,%eax
80107f26:	66 89 82 62 48 11 80 	mov    %ax,-0x7feeb79e(%edx)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107f2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107f32:	66 89 82 68 48 11 80 	mov    %ax,-0x7feeb798(%edx)
80107f39:	31 c0                	xor    %eax,%eax
80107f3b:	66 89 82 6a 48 11 80 	mov    %ax,-0x7feeb796(%edx)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107f42:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107f47:	66 89 82 70 48 11 80 	mov    %ax,-0x7feeb790(%edx)
80107f4e:	31 c0                	xor    %eax,%eax
80107f50:	66 89 82 72 48 11 80 	mov    %ax,-0x7feeb78e(%edx)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107f57:	66 89 8a 5a 48 11 80 	mov    %cx,-0x7feeb7a6(%edx)
80107f5e:	c6 82 5c 48 11 80 00 	movb   $0x0,-0x7feeb7a4(%edx)
80107f65:	c6 82 5d 48 11 80 9a 	movb   $0x9a,-0x7feeb7a3(%edx)
80107f6c:	c6 82 5e 48 11 80 cf 	movb   $0xcf,-0x7feeb7a2(%edx)
80107f73:	c6 82 5f 48 11 80 00 	movb   $0x0,-0x7feeb7a1(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107f7a:	c6 82 64 48 11 80 00 	movb   $0x0,-0x7feeb79c(%edx)
80107f81:	c6 82 65 48 11 80 92 	movb   $0x92,-0x7feeb79b(%edx)
80107f88:	c6 82 66 48 11 80 cf 	movb   $0xcf,-0x7feeb79a(%edx)
80107f8f:	c6 82 67 48 11 80 00 	movb   $0x0,-0x7feeb799(%edx)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107f96:	c6 82 6c 48 11 80 00 	movb   $0x0,-0x7feeb794(%edx)
80107f9d:	c6 82 6d 48 11 80 fa 	movb   $0xfa,-0x7feeb793(%edx)
80107fa4:	c6 82 6e 48 11 80 cf 	movb   $0xcf,-0x7feeb792(%edx)
80107fab:	c6 82 6f 48 11 80 00 	movb   $0x0,-0x7feeb791(%edx)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107fb2:	c6 82 74 48 11 80 00 	movb   $0x0,-0x7feeb78c(%edx)
80107fb9:	c6 82 75 48 11 80 f2 	movb   $0xf2,-0x7feeb78b(%edx)
80107fc0:	c6 82 76 48 11 80 cf 	movb   $0xcf,-0x7feeb78a(%edx)
80107fc7:	c6 82 77 48 11 80 00 	movb   $0x0,-0x7feeb789(%edx)
  lgdt(c->gdt, sizeof(c->gdt));
80107fce:	81 c2 50 48 11 80    	add    $0x80114850,%edx
  pd[1] = (uint)p;
80107fd4:	0f b7 c2             	movzwl %dx,%eax
  pd[2] = (uint)p >> 16;
80107fd7:	c1 ea 10             	shr    $0x10,%edx
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  pd[1] = (uint)p;
80107fda:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;

  asm volatile("lgdt (%0)" : : "r" (pd));
80107fde:	8d 45 f2             	lea    -0xe(%ebp),%eax
{
  volatile ushort pd[3];

  pd[0] = size-1;
  pd[1] = (uint)p;
  pd[2] = (uint)p >> 16;
80107fe1:	66 89 55 f6          	mov    %dx,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80107fe5:	0f 01 10             	lgdtl  (%eax)
}
80107fe8:	c9                   	leave  
80107fe9:	c3                   	ret    
80107fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107ff0 <switchkvm>:
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107ff0:	a1 04 80 11 80       	mov    0x80118004,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80107ff5:	55                   	push   %ebp
80107ff6:	89 e5                	mov    %esp,%ebp
80107ff8:	05 00 00 00 80       	add    $0x80000000,%eax
80107ffd:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
80108000:	5d                   	pop    %ebp
80108001:	c3                   	ret    
80108002:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108010 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80108010:	55                   	push   %ebp
80108011:	89 e5                	mov    %esp,%ebp
80108013:	57                   	push   %edi
80108014:	56                   	push   %esi
80108015:	53                   	push   %ebx
80108016:	83 ec 2c             	sub    $0x2c,%esp
80108019:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
8010801c:	85 f6                	test   %esi,%esi
8010801e:	0f 84 c7 00 00 00    	je     801080eb <switchuvm+0xdb>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80108024:	8b 5e 08             	mov    0x8(%esi),%ebx
80108027:	85 db                	test   %ebx,%ebx
80108029:	0f 84 d4 00 00 00    	je     80108103 <switchuvm+0xf3>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
8010802f:	8b 4e 04             	mov    0x4(%esi),%ecx
80108032:	85 c9                	test   %ecx,%ecx
80108034:	0f 84 bd 00 00 00    	je     801080f7 <switchuvm+0xe7>
    panic("switchuvm: no pgdir");

  pushcli();
8010803a:	e8 a1 d8 ff ff       	call   801058e0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010803f:	e8 ec b8 ff ff       	call   80103930 <mycpu>
80108044:	89 c3                	mov    %eax,%ebx
80108046:	e8 e5 b8 ff ff       	call   80103930 <mycpu>
8010804b:	89 c7                	mov    %eax,%edi
8010804d:	e8 de b8 ff ff       	call   80103930 <mycpu>
80108052:	83 c7 08             	add    $0x8,%edi
80108055:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108058:	e8 d3 b8 ff ff       	call   80103930 <mycpu>
8010805d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80108060:	ba 67 00 00 00       	mov    $0x67,%edx
80108065:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
8010806c:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80108073:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
8010807a:	83 c1 08             	add    $0x8,%ecx
8010807d:	c1 e9 10             	shr    $0x10,%ecx
80108080:	83 c0 08             	add    $0x8,%eax
80108083:	c1 e8 18             	shr    $0x18,%eax
80108086:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
8010808c:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80108093:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
80108099:	e8 92 b8 ff ff       	call   80103930 <mycpu>
8010809e:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801080a5:	e8 86 b8 ff ff       	call   80103930 <mycpu>
801080aa:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801080b0:	e8 7b b8 ff ff       	call   80103930 <mycpu>
801080b5:	8b 56 08             	mov    0x8(%esi),%edx
801080b8:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
801080be:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801080c1:	e8 6a b8 ff ff       	call   80103930 <mycpu>
801080c6:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
801080cc:	b8 28 00 00 00       	mov    $0x28,%eax
801080d1:	0f 00 d8             	ltr    %ax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801080d4:	8b 46 04             	mov    0x4(%esi),%eax
801080d7:	05 00 00 00 80       	add    $0x80000000,%eax
801080dc:	0f 22 d8             	mov    %eax,%cr3
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
801080df:	83 c4 2c             	add    $0x2c,%esp
801080e2:	5b                   	pop    %ebx
801080e3:	5e                   	pop    %esi
801080e4:	5f                   	pop    %edi
801080e5:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
801080e6:	e9 35 d8 ff ff       	jmp    80105920 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
801080eb:	c7 04 24 5e 90 10 80 	movl   $0x8010905e,(%esp)
801080f2:	e8 49 82 ff ff       	call   80100340 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
801080f7:	c7 04 24 89 90 10 80 	movl   $0x80109089,(%esp)
801080fe:	e8 3d 82 ff ff       	call   80100340 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
80108103:	c7 04 24 74 90 10 80 	movl   $0x80109074,(%esp)
8010810a:	e8 31 82 ff ff       	call   80100340 <panic>
8010810f:	90                   	nop

80108110 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80108110:	55                   	push   %ebp
80108111:	89 e5                	mov    %esp,%ebp
80108113:	83 ec 38             	sub    $0x38,%esp
80108116:	89 75 f8             	mov    %esi,-0x8(%ebp)
80108119:	8b 75 10             	mov    0x10(%ebp),%esi
8010811c:	8b 45 08             	mov    0x8(%ebp),%eax
8010811f:	89 7d fc             	mov    %edi,-0x4(%ebp)
80108122:	8b 7d 0c             	mov    0xc(%ebp),%edi
80108125:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80108128:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
8010812e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80108131:	77 59                	ja     8010818c <inituvm+0x7c>
    panic("inituvm: more than a page");
  mem = kalloc();
80108133:	e8 28 a4 ff ff       	call   80102560 <kalloc>
  memset(mem, 0, PGSIZE);
80108138:	31 d2                	xor    %edx,%edx
8010813a:	89 54 24 04          	mov    %edx,0x4(%esp)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
8010813e:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80108140:	b8 00 10 00 00       	mov    $0x1000,%eax
80108145:	89 1c 24             	mov    %ebx,(%esp)
80108148:	89 44 24 08          	mov    %eax,0x8(%esp)
8010814c:	e8 6f d9 ff ff       	call   80105ac0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80108151:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80108157:	b9 06 00 00 00       	mov    $0x6,%ecx
8010815c:	89 04 24             	mov    %eax,(%esp)
8010815f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108162:	31 d2                	xor    %edx,%edx
80108164:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80108168:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010816d:	e8 4e fc ff ff       	call   80107dc0 <mappages>
  memmove(mem, init, sz);
80108172:	89 75 10             	mov    %esi,0x10(%ebp)
}
80108175:	8b 75 f8             	mov    -0x8(%ebp),%esi
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80108178:	89 7d 0c             	mov    %edi,0xc(%ebp)
}
8010817b:	8b 7d fc             	mov    -0x4(%ebp),%edi
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
8010817e:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80108181:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80108184:	89 ec                	mov    %ebp,%esp
80108186:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80108187:	e9 f4 d9 ff ff       	jmp    80105b80 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
8010818c:	c7 04 24 9d 90 10 80 	movl   $0x8010909d,(%esp)
80108193:	e8 a8 81 ff ff       	call   80100340 <panic>
80108198:	90                   	nop
80108199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801081a0 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
801081a0:	55                   	push   %ebp
801081a1:	89 e5                	mov    %esp,%ebp
801081a3:	57                   	push   %edi
801081a4:	56                   	push   %esi
801081a5:	53                   	push   %ebx
801081a6:	83 ec 1c             	sub    $0x1c,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
801081a9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
801081b0:	0f 85 98 00 00 00    	jne    8010824e <loaduvm+0xae>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
801081b6:	8b 75 18             	mov    0x18(%ebp),%esi
801081b9:	31 db                	xor    %ebx,%ebx
801081bb:	85 f6                	test   %esi,%esi
801081bd:	75 1a                	jne    801081d9 <loaduvm+0x39>
801081bf:	eb 77                	jmp    80108238 <loaduvm+0x98>
801081c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801081c8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801081ce:	81 ee 00 10 00 00    	sub    $0x1000,%esi
801081d4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
801081d7:	76 5f                	jbe    80108238 <loaduvm+0x98>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801081d9:	8b 55 0c             	mov    0xc(%ebp),%edx
801081dc:	31 c9                	xor    %ecx,%ecx
801081de:	8b 45 08             	mov    0x8(%ebp),%eax
801081e1:	01 da                	add    %ebx,%edx
801081e3:	e8 48 fb ff ff       	call   80107d30 <walkpgdir>
801081e8:	85 c0                	test   %eax,%eax
801081ea:	74 56                	je     80108242 <loaduvm+0xa2>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
801081ec:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
801081ee:	bf 00 10 00 00       	mov    $0x1000,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
801081f3:	8b 4d 14             	mov    0x14(%ebp),%ecx
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
801081f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801081fb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80108201:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80108204:	05 00 00 00 80       	add    $0x80000000,%eax
80108209:	89 44 24 04          	mov    %eax,0x4(%esp)
8010820d:	8b 45 10             	mov    0x10(%ebp),%eax
80108210:	01 d9                	add    %ebx,%ecx
80108212:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80108216:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010821a:	89 04 24             	mov    %eax,(%esp)
8010821d:	e8 ae 97 ff ff       	call   801019d0 <readi>
80108222:	39 c7                	cmp    %eax,%edi
80108224:	74 a2                	je     801081c8 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80108226:	83 c4 1c             	add    $0x1c,%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80108229:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
8010822e:	5b                   	pop    %ebx
8010822f:	5e                   	pop    %esi
80108230:	5f                   	pop    %edi
80108231:	5d                   	pop    %ebp
80108232:	c3                   	ret    
80108233:	90                   	nop
80108234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108238:	83 c4 1c             	add    $0x1c,%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
8010823b:	31 c0                	xor    %eax,%eax
}
8010823d:	5b                   	pop    %ebx
8010823e:	5e                   	pop    %esi
8010823f:	5f                   	pop    %edi
80108240:	5d                   	pop    %ebp
80108241:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80108242:	c7 04 24 b7 90 10 80 	movl   $0x801090b7,(%esp)
80108249:	e8 f2 80 ff ff       	call   80100340 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
8010824e:	c7 04 24 58 91 10 80 	movl   $0x80109158,(%esp)
80108255:	e8 e6 80 ff ff       	call   80100340 <panic>
8010825a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108260 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80108260:	55                   	push   %ebp
80108261:	89 e5                	mov    %esp,%ebp
80108263:	57                   	push   %edi
80108264:	56                   	push   %esi
80108265:	53                   	push   %ebx
80108266:	83 ec 1c             	sub    $0x1c,%esp
80108269:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
8010826c:	85 ff                	test   %edi,%edi
8010826e:	0f 88 ca 00 00 00    	js     8010833e <allocuvm+0xde>
    return 0;
  if(newsz < oldsz)
80108274:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80108277:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
8010827a:	0f 82 89 00 00 00    	jb     80108309 <allocuvm+0xa9>
    return oldsz;

  a = PGROUNDUP(oldsz);
80108280:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80108286:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010828c:	39 df                	cmp    %ebx,%edi
8010828e:	77 4e                	ja     801082de <allocuvm+0x7e>
80108290:	e9 bb 00 00 00       	jmp    80108350 <allocuvm+0xf0>
80108295:	8d 76 00             	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80108298:	31 d2                	xor    %edx,%edx
8010829a:	b8 00 10 00 00       	mov    $0x1000,%eax
8010829f:	89 54 24 04          	mov    %edx,0x4(%esp)
801082a3:	89 44 24 08          	mov    %eax,0x8(%esp)
801082a7:	89 34 24             	mov    %esi,(%esp)
801082aa:	e8 11 d8 ff ff       	call   80105ac0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801082af:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801082b5:	b9 06 00 00 00       	mov    $0x6,%ecx
801082ba:	89 04 24             	mov    %eax,(%esp)
801082bd:	8b 45 08             	mov    0x8(%ebp),%eax
801082c0:	89 da                	mov    %ebx,%edx
801082c2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801082c6:	b9 00 10 00 00       	mov    $0x1000,%ecx
801082cb:	e8 f0 fa ff ff       	call   80107dc0 <mappages>
801082d0:	85 c0                	test   %eax,%eax
801082d2:	78 44                	js     80108318 <allocuvm+0xb8>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
801082d4:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801082da:	39 df                	cmp    %ebx,%edi
801082dc:	76 72                	jbe    80108350 <allocuvm+0xf0>
    mem = kalloc();
801082de:	e8 7d a2 ff ff       	call   80102560 <kalloc>
    if(mem == 0){
801082e3:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
801082e5:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801082e7:	75 af                	jne    80108298 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
801082e9:	c7 04 24 d5 90 10 80 	movl   $0x801090d5,(%esp)
801082f0:	e8 4b 83 ff ff       	call   80100640 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801082f5:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801082f8:	76 44                	jbe    8010833e <allocuvm+0xde>
801082fa:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801082fd:	89 fa                	mov    %edi,%edx
801082ff:	8b 45 08             	mov    0x8(%ebp),%eax
80108302:	e8 49 fb ff ff       	call   80107e50 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80108307:	31 c0                	xor    %eax,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80108309:	83 c4 1c             	add    $0x1c,%esp
8010830c:	5b                   	pop    %ebx
8010830d:	5e                   	pop    %esi
8010830e:	5f                   	pop    %edi
8010830f:	5d                   	pop    %ebp
80108310:	c3                   	ret    
80108311:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80108318:	c7 04 24 ed 90 10 80 	movl   $0x801090ed,(%esp)
8010831f:	e8 1c 83 ff ff       	call   80100640 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80108324:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80108327:	76 0d                	jbe    80108336 <allocuvm+0xd6>
80108329:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010832c:	89 fa                	mov    %edi,%edx
8010832e:	8b 45 08             	mov    0x8(%ebp),%eax
80108331:	e8 1a fb ff ff       	call   80107e50 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80108336:	89 34 24             	mov    %esi,(%esp)
80108339:	e8 52 a0 ff ff       	call   80102390 <kfree>
      return 0;
    }
  }
  return newsz;
}
8010833e:	83 c4 1c             	add    $0x1c,%esp
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80108341:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
80108343:	5b                   	pop    %ebx
80108344:	5e                   	pop    %esi
80108345:	5f                   	pop    %edi
80108346:	5d                   	pop    %ebp
80108347:	c3                   	ret    
80108348:	90                   	nop
80108349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108350:	83 c4 1c             	add    $0x1c,%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80108353:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80108355:	5b                   	pop    %ebx
80108356:	5e                   	pop    %esi
80108357:	5f                   	pop    %edi
80108358:	5d                   	pop    %ebp
80108359:	c3                   	ret    
8010835a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108360 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80108360:	55                   	push   %ebp
80108361:	89 e5                	mov    %esp,%ebp
80108363:	8b 55 0c             	mov    0xc(%ebp),%edx
80108366:	8b 4d 10             	mov    0x10(%ebp),%ecx
80108369:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
8010836c:	39 d1                	cmp    %edx,%ecx
8010836e:	73 10                	jae    80108380 <deallocuvm+0x20>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80108370:	5d                   	pop    %ebp
80108371:	e9 da fa ff ff       	jmp    80107e50 <deallocuvm.part.0>
80108376:	8d 76 00             	lea    0x0(%esi),%esi
80108379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80108380:	89 d0                	mov    %edx,%eax
80108382:	5d                   	pop    %ebp
80108383:	c3                   	ret    
80108384:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010838a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80108390 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80108390:	55                   	push   %ebp
80108391:	89 e5                	mov    %esp,%ebp
80108393:	57                   	push   %edi
80108394:	56                   	push   %esi
80108395:	53                   	push   %ebx
80108396:	83 ec 1c             	sub    $0x1c,%esp
80108399:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010839c:	85 f6                	test   %esi,%esi
8010839e:	74 55                	je     801083f5 <freevm+0x65>
801083a0:	31 c9                	xor    %ecx,%ecx
801083a2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801083a7:	89 f0                	mov    %esi,%eax
801083a9:	89 f3                	mov    %esi,%ebx
801083ab:	e8 a0 fa ff ff       	call   80107e50 <deallocuvm.part.0>
801083b0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801083b6:	eb 0f                	jmp    801083c7 <freevm+0x37>
801083b8:	90                   	nop
801083b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801083c0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801083c3:	39 fb                	cmp    %edi,%ebx
801083c5:	74 1f                	je     801083e6 <freevm+0x56>
    if(pgdir[i] & PTE_P){
801083c7:	8b 03                	mov    (%ebx),%eax
801083c9:	a8 01                	test   $0x1,%al
801083cb:	74 f3                	je     801083c0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
801083cd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801083d2:	83 c3 04             	add    $0x4,%ebx
801083d5:	05 00 00 00 80       	add    $0x80000000,%eax
801083da:	89 04 24             	mov    %eax,(%esp)
801083dd:	e8 ae 9f ff ff       	call   80102390 <kfree>
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801083e2:	39 fb                	cmp    %edi,%ebx
801083e4:	75 e1                	jne    801083c7 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801083e6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801083e9:	83 c4 1c             	add    $0x1c,%esp
801083ec:	5b                   	pop    %ebx
801083ed:	5e                   	pop    %esi
801083ee:	5f                   	pop    %edi
801083ef:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801083f0:	e9 9b 9f ff ff       	jmp    80102390 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
801083f5:	c7 04 24 09 91 10 80 	movl   $0x80109109,(%esp)
801083fc:	e8 3f 7f ff ff       	call   80100340 <panic>
80108401:	eb 0d                	jmp    80108410 <setupkvm>
80108403:	90                   	nop
80108404:	90                   	nop
80108405:	90                   	nop
80108406:	90                   	nop
80108407:	90                   	nop
80108408:	90                   	nop
80108409:	90                   	nop
8010840a:	90                   	nop
8010840b:	90                   	nop
8010840c:	90                   	nop
8010840d:	90                   	nop
8010840e:	90                   	nop
8010840f:	90                   	nop

80108410 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80108410:	55                   	push   %ebp
80108411:	89 e5                	mov    %esp,%ebp
80108413:	56                   	push   %esi
80108414:	53                   	push   %ebx
80108415:	83 ec 10             	sub    $0x10,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80108418:	e8 43 a1 ff ff       	call   80102560 <kalloc>
8010841d:	85 c0                	test   %eax,%eax
8010841f:	74 6f                	je     80108490 <setupkvm+0x80>
80108421:	89 c6                	mov    %eax,%esi
    return 0;
  memset(pgdir, 0, PGSIZE);
80108423:	31 d2                	xor    %edx,%edx
80108425:	b8 00 10 00 00       	mov    $0x1000,%eax
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010842a:	bb 20 c4 10 80       	mov    $0x8010c420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
8010842f:	89 44 24 08          	mov    %eax,0x8(%esp)
80108433:	89 54 24 04          	mov    %edx,0x4(%esp)
80108437:	89 34 24             	mov    %esi,(%esp)
8010843a:	e8 81 d6 ff ff       	call   80105ac0 <memset>
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010843f:	8b 53 0c             	mov    0xc(%ebx),%edx
80108442:	8b 43 04             	mov    0x4(%ebx),%eax
80108445:	8b 4b 08             	mov    0x8(%ebx),%ecx
80108448:	89 54 24 04          	mov    %edx,0x4(%esp)
8010844c:	8b 13                	mov    (%ebx),%edx
8010844e:	89 04 24             	mov    %eax,(%esp)
80108451:	29 c1                	sub    %eax,%ecx
80108453:	89 f0                	mov    %esi,%eax
80108455:	e8 66 f9 ff ff       	call   80107dc0 <mappages>
8010845a:	85 c0                	test   %eax,%eax
8010845c:	78 1a                	js     80108478 <setupkvm+0x68>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010845e:	83 c3 10             	add    $0x10,%ebx
80108461:	81 fb 60 c4 10 80    	cmp    $0x8010c460,%ebx
80108467:	75 d6                	jne    8010843f <setupkvm+0x2f>
80108469:	89 f0                	mov    %esi,%eax
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
8010846b:	83 c4 10             	add    $0x10,%esp
8010846e:	5b                   	pop    %ebx
8010846f:	5e                   	pop    %esi
80108470:	5d                   	pop    %ebp
80108471:	c3                   	ret    
80108472:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
80108478:	89 34 24             	mov    %esi,(%esp)
8010847b:	e8 10 ff ff ff       	call   80108390 <freevm>
      return 0;
    }
  return pgdir;
}
80108480:	83 c4 10             	add    $0x10,%esp
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
80108483:	31 c0                	xor    %eax,%eax
    }
  return pgdir;
}
80108485:	5b                   	pop    %ebx
80108486:	5e                   	pop    %esi
80108487:	5d                   	pop    %ebp
80108488:	c3                   	ret    
80108489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80108490:	31 c0                	xor    %eax,%eax
80108492:	eb d7                	jmp    8010846b <setupkvm+0x5b>
80108494:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010849a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801084a0 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
801084a0:	55                   	push   %ebp
801084a1:	89 e5                	mov    %esp,%ebp
801084a3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801084a6:	e8 65 ff ff ff       	call   80108410 <setupkvm>
801084ab:	a3 04 80 11 80       	mov    %eax,0x80118004
801084b0:	05 00 00 00 80       	add    $0x80000000,%eax
801084b5:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
801084b8:	c9                   	leave  
801084b9:	c3                   	ret    
801084ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801084c0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801084c0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801084c1:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801084c3:	89 e5                	mov    %esp,%ebp
801084c5:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801084c8:	8b 55 0c             	mov    0xc(%ebp),%edx
801084cb:	8b 45 08             	mov    0x8(%ebp),%eax
801084ce:	e8 5d f8 ff ff       	call   80107d30 <walkpgdir>
  if(pte == 0)
801084d3:	85 c0                	test   %eax,%eax
801084d5:	74 05                	je     801084dc <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
801084d7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801084da:	c9                   	leave  
801084db:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
801084dc:	c7 04 24 1a 91 10 80 	movl   $0x8010911a,(%esp)
801084e3:	e8 58 7e ff ff       	call   80100340 <panic>
801084e8:	90                   	nop
801084e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801084f0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801084f0:	55                   	push   %ebp
801084f1:	89 e5                	mov    %esp,%ebp
801084f3:	57                   	push   %edi
801084f4:	56                   	push   %esi
801084f5:	53                   	push   %ebx
801084f6:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801084f9:	e8 12 ff ff ff       	call   80108410 <setupkvm>
801084fe:	85 c0                	test   %eax,%eax
80108500:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108503:	0f 84 c1 00 00 00    	je     801085ca <copyuvm+0xda>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108509:	8b 55 0c             	mov    0xc(%ebp),%edx
8010850c:	85 d2                	test   %edx,%edx
8010850e:	0f 84 9c 00 00 00    	je     801085b0 <copyuvm+0xc0>
80108514:	31 ff                	xor    %edi,%edi
80108516:	eb 50                	jmp    80108568 <copyuvm+0x78>
80108518:	90                   	nop
80108519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80108520:	b8 00 10 00 00       	mov    $0x1000,%eax
80108525:	89 44 24 08          	mov    %eax,0x8(%esp)
80108529:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010852c:	89 34 24             	mov    %esi,(%esp)
8010852f:	05 00 00 00 80       	add    $0x80000000,%eax
80108534:	89 44 24 04          	mov    %eax,0x4(%esp)
80108538:	e8 43 d6 ff ff       	call   80105b80 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
8010853d:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80108543:	b9 00 10 00 00       	mov    $0x1000,%ecx
80108548:	89 04 24             	mov    %eax,(%esp)
8010854b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010854e:	89 fa                	mov    %edi,%edx
80108550:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80108554:	e8 67 f8 ff ff       	call   80107dc0 <mappages>
80108559:	85 c0                	test   %eax,%eax
8010855b:	78 63                	js     801085c0 <copyuvm+0xd0>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
8010855d:	81 c7 00 10 00 00    	add    $0x1000,%edi
80108563:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80108566:	76 48                	jbe    801085b0 <copyuvm+0xc0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80108568:	8b 45 08             	mov    0x8(%ebp),%eax
8010856b:	31 c9                	xor    %ecx,%ecx
8010856d:	89 fa                	mov    %edi,%edx
8010856f:	e8 bc f7 ff ff       	call   80107d30 <walkpgdir>
80108574:	85 c0                	test   %eax,%eax
80108576:	74 62                	je     801085da <copyuvm+0xea>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80108578:	8b 18                	mov    (%eax),%ebx
8010857a:	f6 c3 01             	test   $0x1,%bl
8010857d:	74 4f                	je     801085ce <copyuvm+0xde>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
8010857f:	89 d8                	mov    %ebx,%eax
    flags = PTE_FLAGS(*pte);
80108581:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80108587:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010858c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
8010858f:	e8 cc 9f ff ff       	call   80102560 <kalloc>
80108594:	85 c0                	test   %eax,%eax
80108596:	89 c6                	mov    %eax,%esi
80108598:	75 86                	jne    80108520 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
8010859a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010859d:	89 04 24             	mov    %eax,(%esp)
801085a0:	e8 eb fd ff ff       	call   80108390 <freevm>
  return 0;
801085a5:	31 c0                	xor    %eax,%eax
}
801085a7:	83 c4 2c             	add    $0x2c,%esp
801085aa:	5b                   	pop    %ebx
801085ab:	5e                   	pop    %esi
801085ac:	5f                   	pop    %edi
801085ad:	5d                   	pop    %ebp
801085ae:	c3                   	ret    
801085af:	90                   	nop
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801085b0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
801085b3:	83 c4 2c             	add    $0x2c,%esp
801085b6:	5b                   	pop    %ebx
801085b7:	5e                   	pop    %esi
801085b8:	5f                   	pop    %edi
801085b9:	5d                   	pop    %ebp
801085ba:	c3                   	ret    
801085bb:	90                   	nop
801085bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
      kfree(mem);
801085c0:	89 34 24             	mov    %esi,(%esp)
801085c3:	e8 c8 9d ff ff       	call   80102390 <kfree>
      goto bad;
801085c8:	eb d0                	jmp    8010859a <copyuvm+0xaa>
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
801085ca:	31 c0                	xor    %eax,%eax
801085cc:	eb d9                	jmp    801085a7 <copyuvm+0xb7>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
801085ce:	c7 04 24 3e 91 10 80 	movl   $0x8010913e,(%esp)
801085d5:	e8 66 7d ff ff       	call   80100340 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
801085da:	c7 04 24 24 91 10 80 	movl   $0x80109124,(%esp)
801085e1:	e8 5a 7d ff ff       	call   80100340 <panic>
801085e6:	8d 76 00             	lea    0x0(%esi),%esi
801085e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801085f0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801085f0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801085f1:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801085f3:	89 e5                	mov    %esp,%ebp
801085f5:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801085f8:	8b 55 0c             	mov    0xc(%ebp),%edx
801085fb:	8b 45 08             	mov    0x8(%ebp),%eax
801085fe:	e8 2d f7 ff ff       	call   80107d30 <walkpgdir>
  if((*pte & PTE_P) == 0)
80108603:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80108605:	89 c2                	mov    %eax,%edx
80108607:	83 e2 05             	and    $0x5,%edx
8010860a:	83 fa 05             	cmp    $0x5,%edx
8010860d:	75 11                	jne    80108620 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
8010860f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108614:	05 00 00 00 80       	add    $0x80000000,%eax
}
80108619:	c9                   	leave  
8010861a:	c3                   	ret    
8010861b:	90                   	nop
8010861c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
80108620:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
80108622:	c9                   	leave  
80108623:	c3                   	ret    
80108624:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010862a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80108630 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108630:	55                   	push   %ebp
80108631:	89 e5                	mov    %esp,%ebp
80108633:	57                   	push   %edi
80108634:	56                   	push   %esi
80108635:	53                   	push   %ebx
80108636:	83 ec 2c             	sub    $0x2c,%esp
80108639:	8b 75 14             	mov    0x14(%ebp),%esi
8010863c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
8010863f:	85 f6                	test   %esi,%esi
80108641:	89 da                	mov    %ebx,%edx
80108643:	75 41                	jne    80108686 <copyout+0x56>
80108645:	eb 71                	jmp    801086b8 <copyout+0x88>
80108647:	89 f6                	mov    %esi,%esi
80108649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80108650:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80108653:	89 df                	mov    %ebx,%edi
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80108655:	8b 4d 10             	mov    0x10(%ebp),%ecx
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80108658:	29 d7                	sub    %edx,%edi
8010865a:	81 c7 00 10 00 00    	add    $0x1000,%edi
80108660:	39 f7                	cmp    %esi,%edi
80108662:	0f 47 fe             	cmova  %esi,%edi
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80108665:	29 da                	sub    %ebx,%edx
80108667:	01 c2                	add    %eax,%edx
80108669:	89 14 24             	mov    %edx,(%esp)
8010866c:	89 7c 24 08          	mov    %edi,0x8(%esp)
80108670:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80108674:	e8 07 d5 ff ff       	call   80105b80 <memmove>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
80108679:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
8010867f:	01 7d 10             	add    %edi,0x10(%ebp)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80108682:	29 fe                	sub    %edi,%esi
80108684:	74 32                	je     801086b8 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
80108686:	8b 45 08             	mov    0x8(%ebp),%eax
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
80108689:	89 d3                	mov    %edx,%ebx
8010868b:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    pa0 = uva2ka(pgdir, (char*)va0);
80108691:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
80108695:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80108698:	89 04 24             	mov    %eax,(%esp)
8010869b:	e8 50 ff ff ff       	call   801085f0 <uva2ka>
    if(pa0 == 0)
801086a0:	85 c0                	test   %eax,%eax
801086a2:	75 ac                	jne    80108650 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
801086a4:	83 c4 2c             	add    $0x2c,%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
801086a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
801086ac:	5b                   	pop    %ebx
801086ad:	5e                   	pop    %esi
801086ae:	5f                   	pop    %edi
801086af:	5d                   	pop    %ebp
801086b0:	c3                   	ret    
801086b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801086b8:	83 c4 2c             	add    $0x2c,%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
801086bb:	31 c0                	xor    %eax,%eax
}
801086bd:	5b                   	pop    %ebx
801086be:	5e                   	pop    %esi
801086bf:	5f                   	pop    %edi
801086c0:	5d                   	pop    %ebp
801086c1:	c3                   	ret    
