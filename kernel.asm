
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
80100041:	ba 40 86 10 80       	mov    $0x80108640,%edx
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
8010005c:	e8 af 57 00 00       	call   80105810 <initlock>

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
80100082:	b8 47 86 10 80       	mov    $0x80108647,%eax
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
8010009b:	e8 40 56 00 00       	call   801056e0 <initsleeplock>
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
801000e6:	e8 85 58 00 00       	call   80105970 <acquire>

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
80100161:	e8 aa 58 00 00       	call   80105a10 <release>
      acquiresleep(&b->lock);
80100166:	8d 43 0c             	lea    0xc(%ebx),%eax
80100169:	89 04 24             	mov    %eax,(%esp)
8010016c:	e8 af 55 00 00       	call   80105720 <acquiresleep>
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
8010018e:	c7 04 24 4e 86 10 80 	movl   $0x8010864e,(%esp)
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
801001b0:	e8 0b 56 00 00       	call   801057c0 <holdingsleep>
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
801001c9:	c7 04 24 5f 86 10 80 	movl   $0x8010865f,(%esp)
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
801001f1:	e8 ca 55 00 00       	call   801057c0 <holdingsleep>
801001f6:	85 c0                	test   %eax,%eax
801001f8:	74 5a                	je     80100254 <brelse+0x74>
    panic("brelse");

  releasesleep(&b->lock);
801001fa:	89 34 24             	mov    %esi,(%esp)
801001fd:	e8 7e 55 00 00       	call   80105780 <releasesleep>

  acquire(&bcache.lock);
80100202:	c7 04 24 20 d6 10 80 	movl   $0x8010d620,(%esp)
80100209:	e8 62 57 00 00       	call   80105970 <acquire>
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
8010024f:	e9 bc 57 00 00       	jmp    80105a10 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100254:	c7 04 24 66 86 10 80 	movl   $0x80108666,(%esp)
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
8010027e:	e8 ed 56 00 00       	call   80105970 <acquire>
  while(n > 0){
80100283:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100286:	31 c0                	xor    %eax,%eax
80100288:	85 db                	test   %ebx,%ebx
8010028a:	7f 25                	jg     801002b1 <consoleread+0x51>
8010028c:	eb 5b                	jmp    801002e9 <consoleread+0x89>
8010028e:	66 90                	xchg   %ax,%ax
    while(input.r == input.w){
      if(myproc()->killed){
80100290:	e8 cb 36 00 00       	call   80103960 <myproc>
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
801002ac:	e8 5f 40 00 00       	call   80104310 <sleep>

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
801002f3:	e8 18 57 00 00       	call   80105a10 <release>
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
8010030f:	e8 fc 56 00 00       	call   80105a10 <release>
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
8010035c:	c7 04 24 6d 86 10 80 	movl   $0x8010866d,(%esp)
80100363:	89 44 24 04          	mov    %eax,0x4(%esp)
80100367:	e8 d4 02 00 00       	call   80100640 <cprintf>
  cprintf(s);
8010036c:	8b 45 08             	mov    0x8(%ebp),%eax
8010036f:	89 04 24             	mov    %eax,(%esp)
80100372:	e8 c9 02 00 00       	call   80100640 <cprintf>
  cprintf("\n");
80100377:	c7 04 24 61 8e 10 80 	movl   $0x80108e61,(%esp)
8010037e:	e8 bd 02 00 00       	call   80100640 <cprintf>
  getcallerpcs(&s, pcs);
80100383:	8d 45 08             	lea    0x8(%ebp),%eax
80100386:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010038a:	89 04 24             	mov    %eax,(%esp)
8010038d:	e8 9e 54 00 00       	call   80105830 <getcallerpcs>
80100392:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003a0:	8b 03                	mov    (%ebx),%eax
801003a2:	83 c3 04             	add    $0x4,%ebx
801003a5:	c7 04 24 81 86 10 80 	movl   $0x80108681,(%esp)
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
801003f9:	e8 d2 6d 00 00       	call   801071d0 <uartputc>
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
801004a7:	e8 24 6d 00 00       	call   801071d0 <uartputc>
801004ac:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004b3:	e8 18 6d 00 00       	call   801071d0 <uartputc>
801004b8:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004bf:	e8 0c 6d 00 00       	call   801071d0 <uartputc>
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
801004e5:	e8 36 56 00 00       	call   80105b20 <memmove>
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
8010050d:	e8 4e 55 00 00       	call   80105a60 <memset>
80100512:	89 f1                	mov    %esi,%ecx
80100514:	c6 45 d8 07          	movb   $0x7,-0x28(%ebp)
80100518:	e9 56 ff ff ff       	jmp    80100473 <consputc+0xa3>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");
8010051d:	c7 04 24 85 86 10 80 	movl   $0x80108685,(%esp)
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
80100591:	0f b6 92 b0 86 10 80 	movzbl -0x7fef7950(%edx),%edx
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
801005fe:	e8 6d 53 00 00       	call   80105970 <acquire>
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
80100624:	e8 e7 53 00 00       	call   80105a10 <release>
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
801006e6:	e8 25 53 00 00       	call   80105a10 <release>
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
80100758:	b8 98 86 10 80       	mov    $0x80108698,%eax
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
8010078f:	e8 dc 51 00 00       	call   80105970 <acquire>
80100794:	e9 c0 fe ff ff       	jmp    80100659 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
80100799:	c7 04 24 9f 86 10 80 	movl   $0x8010869f,(%esp)
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
801007c4:	e8 a7 51 00 00       	call   80105970 <acquire>
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
80100827:	e8 e4 51 00 00       	call   80105a10 <release>
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
801008b9:	e8 72 3c 00 00       	call   80104530 <wakeup>
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
8010092e:	e9 cd 3c 00 00       	jmp    80104600 <procdump>
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
80100961:	b8 a8 86 10 80       	mov    $0x801086a8,%eax
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
80100976:	e8 95 4e 00 00       	call   80105810 <initlock>

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
801009c2:	e8 99 2f 00 00       	call   80103960 <myproc>
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
80100a44:	e8 27 79 00 00       	call   80108370 <setupkvm>
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
80100af1:	e8 ca 76 00 00       	call   801081c0 <allocuvm>
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
80100b32:	e8 c9 75 00 00       	call   80108100 <loaduvm>
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
80100b49:	e8 a2 77 00 00       	call   801082f0 <freevm>
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
80100b8c:	e8 2f 76 00 00       	call   801081c0 <allocuvm>
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
80100ba0:	e8 4b 77 00 00       	call   801082f0 <freevm>
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
80100bb4:	c7 04 24 c1 86 10 80 	movl   $0x801086c1,(%esp)
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
80100be1:	e8 3a 78 00 00       	call   80108420 <clearpteu>
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
80100c10:	e8 7b 50 00 00       	call   80105c90 <strlen>
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
80100c25:	e8 66 50 00 00       	call   80105c90 <strlen>
80100c2a:	40                   	inc    %eax
80100c2b:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c2f:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c32:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c35:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100c39:	89 34 24             	mov    %esi,(%esp)
80100c3c:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c40:	e8 4b 79 00 00       	call   80108590 <copyout>
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
80100cb0:	e8 db 78 00 00       	call   80108590 <copyout>
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
80100cf9:	e8 52 4f 00 00       	call   80105c50 <safestrcpy>

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
80100d25:	e8 46 72 00 00       	call   80107f70 <switchuvm>
  freevm(oldpgdir);
80100d2a:	89 3c 24             	mov    %edi,(%esp)
80100d2d:	e8 be 75 00 00       	call   801082f0 <freevm>
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
80100d41:	b8 cd 86 10 80       	mov    $0x801086cd,%eax
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
80100d56:	e8 b5 4a 00 00       	call   80105810 <initlock>
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
80100d73:	e8 f8 4b 00 00       	call   80105970 <acquire>
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
80100da0:	e8 6b 4c 00 00       	call   80105a10 <release>
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
80100db7:	e8 54 4c 00 00       	call   80105a10 <release>
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
80100de1:	e8 8a 4b 00 00       	call   80105970 <acquire>
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
80100df8:	e8 13 4c 00 00       	call   80105a10 <release>
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
80100e05:	c7 04 24 d4 86 10 80 	movl   $0x801086d4,(%esp)
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
80100e39:	e8 32 4b 00 00       	call   80105970 <acquire>
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
80100e64:	e9 a7 4b 00 00       	jmp    80105a10 <release>
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
80100e8f:	e8 7c 4b 00 00       	call   80105a10 <release>

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
80100ee9:	c7 04 24 dc 86 10 80 	movl   $0x801086dc,(%esp)
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
80100fe7:	c7 04 24 e6 86 10 80 	movl   $0x801086e6,(%esp)
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
80101101:	c7 04 24 ef 86 10 80 	movl   $0x801086ef,(%esp)
80101108:	e8 33 f2 ff ff       	call   80100340 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
8010110d:	c7 04 24 f5 86 10 80 	movl   $0x801086f5,(%esp)
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
801011b8:	c7 04 24 ff 86 10 80 	movl   $0x801086ff,(%esp)
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
8010120e:	e8 4d 48 00 00       	call   80105a60 <memset>
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
8010124c:	e8 1f 47 00 00       	call   80105970 <acquire>

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
8010128f:	e8 7c 47 00 00       	call   80105a10 <release>
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
801012de:	e8 2d 47 00 00       	call   80105a10 <release>

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
801012ed:	c7 04 24 15 87 10 80 	movl   $0x80108715,(%esp)
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
801013bf:	c7 04 24 25 87 10 80 	movl   $0x80108725,(%esp)
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
80101408:	e8 13 47 00 00       	call   80105b20 <memmove>
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
80101497:	c7 04 24 38 87 10 80 	movl   $0x80108738,(%esp)
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
801014b1:	b9 4b 87 10 80       	mov    $0x8010874b,%ecx
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
801014cc:	e8 3f 43 00 00       	call   80105810 <initlock>
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
801014e0:	ba 52 87 10 80       	mov    $0x80108752,%edx
801014e5:	89 1c 24             	mov    %ebx,(%esp)
801014e8:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014ee:	89 54 24 04          	mov    %edx,0x4(%esp)
801014f2:	e8 e9 41 00 00       	call   801056e0 <initsleeplock>
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
80101518:	c7 04 24 b8 87 10 80 	movl   $0x801087b8,(%esp)
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
801015f3:	e8 68 44 00 00       	call   80105a60 <memset>
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
80101621:	c7 04 24 58 87 10 80 	movl   $0x80108758,(%esp)
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
801016a2:	e8 79 44 00 00       	call   80105b20 <memmove>
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
801016d1:	e8 9a 42 00 00       	call   80105970 <acquire>
  ip->ref++;
801016d6:	ff 43 08             	incl   0x8(%ebx)
  release(&icache.lock);
801016d9:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
801016e0:	e8 2b 43 00 00       	call   80105a10 <release>
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
80101714:	e8 07 40 00 00       	call   80105720 <acquiresleep>

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
80101796:	e8 85 43 00 00       	call   80105b20 <memmove>
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
801017b5:	c7 04 24 70 87 10 80 	movl   $0x80108770,(%esp)
801017bc:	e8 7f eb ff ff       	call   80100340 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
801017c1:	c7 04 24 6a 87 10 80 	movl   $0x8010876a,(%esp)
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
801017e9:	e8 d2 3f 00 00       	call   801057c0 <holdingsleep>
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
80101805:	e9 76 3f 00 00       	jmp    80105780 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
8010180a:	c7 04 24 7f 87 10 80 	movl   $0x8010877f,(%esp)
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
80101838:	e8 e3 3e 00 00       	call   80105720 <acquiresleep>
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
8010184e:	e8 2d 3f 00 00       	call   80105780 <releasesleep>

  acquire(&icache.lock);
80101853:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
8010185a:	e8 11 41 00 00       	call   80105970 <acquire>
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
80101875:	e9 96 41 00 00       	jmp    80105a10 <release>
8010187a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
void
iput(struct inode *ip)
{
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
80101880:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101887:	e8 e4 40 00 00       	call   80105970 <acquire>
    int r = ip->ref;
8010188c:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
8010188f:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101896:	e8 75 41 00 00       	call   80105a10 <release>
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
80101a82:	e8 99 40 00 00       	call   80105b20 <memmove>
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
80101b92:	e8 89 3f 00 00       	call   80105b20 <memmove>
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
80101c3c:	e8 4f 3f 00 00       	call   80105b90 <strncmp>
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
80101cbb:	e8 d0 3e 00 00       	call   80105b90 <strncmp>
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
80101cf2:	c7 04 24 99 87 10 80 	movl   $0x80108799,(%esp)
80101cf9:	e8 42 e6 ff ff       	call   80100340 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101cfe:	c7 04 24 87 87 10 80 	movl   $0x80108787,(%esp)
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
80101d29:	e8 32 1c 00 00       	call   80103960 <myproc>
80101d2e:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101d31:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101d38:	e8 33 3c 00 00       	call   80105970 <acquire>
  ip->ref++;
80101d3d:	ff 46 08             	incl   0x8(%esi)
  release(&icache.lock);
80101d40:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101d47:	e8 c4 3c 00 00       	call   80105a10 <release>
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
80101dac:	e8 6f 3d 00 00       	call   80105b20 <memmove>
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
80101e31:	e8 ea 3c 00 00       	call   80105b20 <memmove>
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
80101f33:	e8 b8 3c 00 00       	call   80105bf0 <strncpy>
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
80101f76:	c7 04 24 a8 87 10 80 	movl   $0x801087a8,(%esp)
80101f7d:	e8 be e3 ff ff       	call   80100340 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80101f82:	c7 04 24 46 8f 10 80 	movl   $0x80108f46,(%esp)
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
8010207a:	c7 04 24 14 88 10 80 	movl   $0x80108814,(%esp)
80102081:	e8 ba e2 ff ff       	call   80100340 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
80102086:	c7 04 24 0b 88 10 80 	movl   $0x8010880b,(%esp)
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
801020a1:	ba 26 88 10 80       	mov    $0x80108826,%edx
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
801020b6:	e8 55 37 00 00       	call   80105810 <initlock>
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
80102130:	e8 3b 38 00 00       	call   80105970 <acquire>

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
8010215c:	e8 cf 23 00 00       	call   80104530 <wakeup>

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
80102176:	e8 95 38 00 00       	call   80105a10 <release>
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
801021d0:	e8 eb 35 00 00       	call   801057c0 <holdingsleep>
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
80102207:	e8 64 37 00 00       	call   80105970 <acquire>

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
8010224c:	e8 bf 20 00 00       	call   80104310 <sleep>
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
80102267:	e9 a4 37 00 00       	jmp    80105a10 <release>

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
8010227c:	c7 04 24 2a 88 10 80 	movl   $0x8010882a,(%esp)
80102283:	e8 b8 e0 ff ff       	call   80100340 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
80102288:	c7 04 24 55 88 10 80 	movl   $0x80108855,(%esp)
8010228f:	e8 ac e0 ff ff       	call   80100340 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
80102294:	c7 04 24 40 88 10 80 	movl   $0x80108840,(%esp)
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
801022e9:	c7 04 24 74 88 10 80 	movl   $0x80108874,(%esp)
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
801023d0:	e8 8b 36 00 00       	call   80105a60 <memset>

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
8010240c:	e9 ff 35 00 00       	jmp    80105a10 <release>
80102411:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102418:	c7 04 24 a0 46 11 80 	movl   $0x801146a0,(%esp)
8010241f:	e8 4c 35 00 00       	call   80105970 <acquire>
80102424:	eb b8                	jmp    801023de <kfree+0x4e>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
80102426:	c7 04 24 a6 88 10 80 	movl   $0x801088a6,(%esp)
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
80102491:	b8 ac 88 10 80       	mov    $0x801088ac,%eax
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
801024ab:	e8 60 33 00 00       	call   80105810 <initlock>

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
8010259a:	e8 71 34 00 00       	call   80105a10 <release>
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
801025af:	e8 bc 33 00 00       	call   80105970 <acquire>
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
80102608:	0f b6 82 e0 89 10 80 	movzbl -0x7fef7620(%edx),%eax
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
80102635:	0f b6 82 e0 89 10 80 	movzbl -0x7fef7620(%edx),%eax
8010263c:	09 c1                	or     %eax,%ecx
8010263e:	0f b6 82 e0 88 10 80 	movzbl -0x7fef7720(%edx),%eax
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
8010264f:	8b 04 85 c0 88 10 80 	mov    -0x7fef7740(,%eax,4),%eax
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
8010299c:	e8 1f 31 00 00       	call   80105ac0 <memcmp>
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
80102abc:	e8 5f 30 00 00       	call   80105b20 <memmove>
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
80102b61:	ba e0 8a 10 80       	mov    $0x80108ae0,%edx
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
80102b7a:	e8 91 2c 00 00       	call   80105810 <initlock>
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
80102c0d:	e8 5e 2d 00 00       	call   80105970 <acquire>
80102c12:	eb 19                	jmp    80102c2d <begin_op+0x2d>
80102c14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102c18:	b8 e0 46 11 80       	mov    $0x801146e0,%eax
80102c1d:	89 44 24 04          	mov    %eax,0x4(%esp)
80102c21:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102c28:	e8 e3 16 00 00       	call   80104310 <sleep>
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
80102c5a:	e8 b1 2d 00 00       	call   80105a10 <release>
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
80102c80:	e8 eb 2c 00 00       	call   80105970 <acquire>
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
80102cba:	e8 51 2d 00 00       	call   80105a10 <release>
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
80102d1c:	e8 ff 2d 00 00       	call   80105b20 <memmove>
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
80102d5f:	e8 0c 2c 00 00       	call   80105970 <acquire>
    log.committing = 0;
80102d64:	31 c0                	xor    %eax,%eax
80102d66:	a3 20 47 11 80       	mov    %eax,0x80114720
    wakeup(&log);
80102d6b:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102d72:	e8 b9 17 00 00       	call   80104530 <wakeup>
    release(&log.lock);
80102d77:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102d7e:	e8 8d 2c 00 00       	call   80105a10 <release>
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
80102d8b:	c7 04 24 e4 8a 10 80 	movl   $0x80108ae4,(%esp)
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
80102ddb:	e8 90 2b 00 00       	call   80105970 <acquire>
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
80102e2b:	e9 e0 2b 00 00       	jmp    80105a10 <release>
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
80102e48:	c7 04 24 f3 8a 10 80 	movl   $0x80108af3,(%esp)
80102e4f:	e8 ec d4 ff ff       	call   80100340 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102e54:	c7 04 24 09 8b 10 80 	movl   $0x80108b09,(%esp)
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
80102e67:	e8 e4 50 00 00       	call   80107f50 <switchkvm>
  seginit();
80102e6c:	e8 df 4f 00 00       	call   80107e50 <seginit>
  lapicinit();
80102e71:	e8 4a f8 ff ff       	call   801026c0 <lapicinit>
}

static void
mpmain(void) //called by the non-boot AP cpus
{
  struct cpu* c = mycpu();
80102e76:	e8 45 0a 00 00       	call   801038c0 <mycpu>
80102e7b:	89 c3                	mov    %eax,%ebx
  cprintf("cpu%d: is witing for the \"pioneer\" cpu to finish its initialization.\n", cpuid());
80102e7d:	e8 be 0a 00 00       	call   80103940 <cpuid>
80102e82:	c7 04 24 24 8b 10 80 	movl   $0x80108b24,(%esp)
80102e89:	89 44 24 04          	mov    %eax,0x4(%esp)
80102e8d:	e8 ae d7 ff ff       	call   80100640 <cprintf>
  idtinit();       // load idt register
80102e92:	e8 39 3f 00 00       	call   80106dd0 <idtinit>
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
80102eba:	e8 81 0a 00 00       	call   80103940 <cpuid>
80102ebf:	89 c3                	mov    %eax,%ebx
80102ec1:	e8 7a 0a 00 00       	call   80103940 <cpuid>
80102ec6:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80102eca:	c7 04 24 74 8b 10 80 	movl   $0x80108b74,(%esp)
80102ed1:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ed5:	e8 66 d7 ff ff       	call   80100640 <cprintf>
  scheduler();     // start running processes
80102eda:	e8 e1 0e 00 00       	call   80103dc0 <scheduler>
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
80102f04:	e8 f7 54 00 00       	call   80108400 <kvmalloc>
  mpinit();        // detect other processors
80102f09:	e8 02 02 00 00       	call   80103110 <mpinit>
80102f0e:	66 90                	xchg   %ax,%ax
  lapicinit();     // interrupt controller
80102f10:	e8 ab f7 ff ff       	call   801026c0 <lapicinit>
  seginit();       // segment descriptors
80102f15:	e8 36 4f 00 00       	call   80107e50 <seginit>
  picinit();       // disable pic
80102f1a:	e8 c1 03 00 00       	call   801032e0 <picinit>
80102f1f:	90                   	nop
  ioapicinit();    // another interrupt controller
80102f20:	e8 7b f3 ff ff       	call   801022a0 <ioapicinit>
  consoleinit();   // console hardware
80102f25:	e8 36 da ff ff       	call   80100960 <consoleinit>
  uartinit();      // serial port
80102f2a:	e8 f1 41 00 00       	call   80107120 <uartinit>
80102f2f:	90                   	nop
  pinit();         // process table
80102f30:	e8 6b 09 00 00       	call   801038a0 <pinit>
  tvinit();        // trap vectors
80102f35:	e8 f6 3d 00 00       	call   80106d30 <tvinit>
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
80102f63:	e8 b8 2b 00 00       	call   80105b20 <memmove>

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
80102f80:	e8 3b 09 00 00       	call   801038c0 <mycpu>
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
8010300e:	e8 2d 1c 00 00       	call   80104c40 <initSchedDS>
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
80103053:	e8 e8 09 00 00       	call   80103a40 <userinit>
}

static void
mpmainPioneer(void) //called by the "pioneer" cpu
{
  cprintf("\"pioneer\" cpu%d: starting %d\n", cpuid(), cpuid());
80103058:	e8 e3 08 00 00       	call   80103940 <cpuid>
8010305d:	89 c3                	mov    %eax,%ebx
8010305f:	e8 dc 08 00 00       	call   80103940 <cpuid>
80103064:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80103068:	c7 04 24 6a 8b 10 80 	movl   $0x80108b6a,(%esp)
8010306f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103073:	e8 c8 d5 ff ff       	call   80100640 <cprintf>
  idtinit();       // load idt register
80103078:	e8 53 3d 00 00       	call   80106dd0 <idtinit>
  scheduler();     // start running processes
8010307d:	e8 3e 0d 00 00       	call   80103dc0 <scheduler>
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
801030be:	ba 88 8b 10 80       	mov    $0x80108b88,%edx
801030c3:	89 44 24 08          	mov    %eax,0x8(%esp)
801030c7:	89 54 24 04          	mov    %edx,0x4(%esp)
801030cb:	89 34 24             	mov    %esi,(%esp)
801030ce:	e8 ed 29 00 00       	call   80105ac0 <memcmp>
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
80103174:	ba 8d 8b 10 80       	mov    $0x80108b8d,%edx
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
8010318a:	e8 31 29 00 00       	call   80105ac0 <memcmp>
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
8010320f:	ff 24 85 cc 8b 10 80 	jmp    *-0x7fef7434(,%eax,4)
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
801032b3:	c7 04 24 92 8b 10 80 	movl   $0x80108b92,(%esp)
801032ba:	e8 81 d0 ff ff       	call   80100340 <panic>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
801032bf:	c7 04 24 ac 8b 10 80 	movl   $0x80108bac,(%esp)
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
80103368:	b8 e0 8b 10 80       	mov    $0x80108be0,%eax
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
80103380:	e8 8b 24 00 00       	call   80105810 <initlock>
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
80103425:	e8 46 25 00 00       	call   80105970 <acquire>
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
8010343f:	e8 ec 10 00 00       	call   80104530 <wakeup>
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
80103464:	e9 a7 25 00 00       	jmp    80105a10 <release>
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
80103481:	e8 aa 10 00 00       	call   80104530 <wakeup>
80103486:	eb bc                	jmp    80103444 <pipeclose+0x34>
80103488:	90                   	nop
80103489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80103490:	89 1c 24             	mov    %ebx,(%esp)
80103493:	e8 78 25 00 00       	call   80105a10 <release>
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
801034bf:	e8 ac 24 00 00       	call   80105970 <acquire>
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
80103500:	e8 5b 04 00 00       	call   80103960 <myproc>
80103505:	8b 40 24             	mov    0x24(%eax),%eax
80103508:	85 c0                	test   %eax,%eax
8010350a:	75 34                	jne    80103540 <pipewrite+0x90>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
8010350c:	89 34 24             	mov    %esi,(%esp)
8010350f:	e8 1c 10 00 00       	call   80104530 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103514:	89 7c 24 04          	mov    %edi,0x4(%esp)
80103518:	89 1c 24             	mov    %ebx,(%esp)
8010351b:	e8 f0 0d 00 00       	call   80104310 <sleep>
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
80103543:	e8 c8 24 00 00       	call   80105a10 <release>
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
80103590:	e8 9b 0f 00 00       	call   80104530 <wakeup>
  release(&p->lock);
80103595:	89 3c 24             	mov    %edi,(%esp)
80103598:	e8 73 24 00 00       	call   80105a10 <release>
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
801035c2:	e8 a9 23 00 00       	call   80105970 <acquire>
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
801035f7:	e8 14 0d 00 00       	call   80104310 <sleep>
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
80103618:	e8 43 03 00 00       	call   80103960 <myproc>
8010361d:	8b 48 24             	mov    0x24(%eax),%ecx
80103620:	85 c9                	test   %ecx,%ecx
80103622:	74 cc                	je     801035f0 <piperead+0x40>
      release(&p->lock);
80103624:	89 1c 24             	mov    %ebx,(%esp)
80103627:	e8 e4 23 00 00       	call   80105a10 <release>
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
8010368b:	e8 a0 0e 00 00       	call   80104530 <wakeup>
  release(&p->lock);
80103690:	89 1c 24             	mov    %ebx,(%esp)
80103693:	e8 78 23 00 00       	call   80105a10 <release>
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
801036d3:	e8 98 22 00 00       	call   80105970 <acquire>
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

  release(&ptable.lock);
80103718:	e8 f3 22 00 00       	call   80105a10 <release>

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
80103737:	ba 1f 6d 10 80       	mov    $0x80106d1f,%edx

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
80103754:	e8 07 23 00 00       	call   80105a60 <memset>
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
80103777:	e8 94 22 00 00       	call   80105a10 <release>
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
8010379d:	e8 6e 22 00 00       	call   80105a10 <release>

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
extern RoundRobinQueue rrq;
extern RunningProcessesHolder rpholder;

#define MAXINT 1215752191

long long getAccumulator(struct proc *p) {
801037e0:	55                   	push   %ebp
801037e1:	89 e5                	mov    %esp,%ebp
	return p->accumulator;
801037e3:	8b 45 08             	mov    0x8(%ebp),%eax
}
801037e6:	5d                   	pop    %ebp
extern RunningProcessesHolder rpholder;

#define MAXINT 1215752191

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
  long long tmp1=999999999999999,tmp2=999999999999999;
  boolean a=pq.getMinAccumulator(&tmp1);
80103807:	8d 45 e8             	lea    -0x18(%ebp),%eax
long long getAccumulator(struct proc *p) {
	return p->accumulator;
}

long long getMinAccumulator(){
  long long tmp1=999999999999999,tmp2=999999999999999;
8010380a:	c7 45 e8 ff 7f c6 a4 	movl   $0xa4c67fff,-0x18(%ebp)
80103811:	c7 45 ec 7e 8d 03 00 	movl   $0x38d7e,-0x14(%ebp)
80103818:	c7 45 f0 ff 7f c6 a4 	movl   $0xa4c67fff,-0x10(%ebp)
8010381f:	c7 45 f4 7e 8d 03 00 	movl   $0x38d7e,-0xc(%ebp)
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

801038a0 <pinit>:



void
pinit(void)
{
801038a0:	55                   	push   %ebp
  initlock(&ptable.lock, "ptable");
801038a1:	b8 e5 8b 10 80       	mov    $0x80108be5,%eax



void
pinit(void)
{
801038a6:	89 e5                	mov    %esp,%ebp
801038a8:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
801038ab:	89 44 24 04          	mov    %eax,0x4(%esp)
801038af:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801038b6:	e8 55 1f 00 00       	call   80105810 <initlock>
}
801038bb:	c9                   	leave  
801038bc:	c3                   	ret    
801038bd:	8d 76 00             	lea    0x0(%esi),%esi

801038c0 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
801038c0:	55                   	push   %ebp
801038c1:	89 e5                	mov    %esp,%ebp
801038c3:	56                   	push   %esi
801038c4:	53                   	push   %ebx
801038c5:	83 ec 10             	sub    $0x10,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801038c8:	9c                   	pushf  
801038c9:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
801038ca:	f6 c4 02             	test   $0x2,%ah
801038cd:	75 58                	jne    80103927 <mycpu+0x67>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
801038cf:	e8 ec ee ff ff       	call   801027c0 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
801038d4:	8b 35 60 4d 11 80    	mov    0x80114d60,%esi
801038da:	85 f6                	test   %esi,%esi
801038dc:	7e 3d                	jle    8010391b <mycpu+0x5b>
    if (cpus[i].apicid == apicid)
801038de:	0f b6 15 e0 47 11 80 	movzbl 0x801147e0,%edx
801038e5:	39 d0                	cmp    %edx,%eax
801038e7:	74 2e                	je     80103917 <mycpu+0x57>
801038e9:	b9 90 48 11 80       	mov    $0x80114890,%ecx
801038ee:	31 d2                	xor    %edx,%edx
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
801038f0:	42                   	inc    %edx
801038f1:	39 f2                	cmp    %esi,%edx
801038f3:	74 26                	je     8010391b <mycpu+0x5b>
    if (cpus[i].apicid == apicid)
801038f5:	0f b6 19             	movzbl (%ecx),%ebx
801038f8:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
801038fe:	39 d8                	cmp    %ebx,%eax
80103900:	75 ee                	jne    801038f0 <mycpu+0x30>
      return &cpus[i];
  }
  panic("unknown apicid\n");
}
80103902:	83 c4 10             	add    $0x10,%esp
80103905:	5b                   	pop    %ebx
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
80103906:	8d 04 92             	lea    (%edx,%edx,4),%eax
80103909:	8d 04 42             	lea    (%edx,%eax,2),%eax
  }
  panic("unknown apicid\n");
}
8010390c:	5e                   	pop    %esi
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
8010390d:	c1 e0 04             	shl    $0x4,%eax
80103910:	05 e0 47 11 80       	add    $0x801147e0,%eax
  }
  panic("unknown apicid\n");
}
80103915:	5d                   	pop    %ebp
80103916:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103917:	31 d2                	xor    %edx,%edx
80103919:	eb e7                	jmp    80103902 <mycpu+0x42>
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
8010391b:	c7 04 24 ec 8b 10 80 	movl   $0x80108bec,(%esp)
80103922:	e8 19 ca ff ff       	call   80100340 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
80103927:	c7 04 24 e0 8c 10 80 	movl   $0x80108ce0,(%esp)
8010392e:	e8 0d ca ff ff       	call   80100340 <panic>
80103933:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103940 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
80103940:	55                   	push   %ebp
80103941:	89 e5                	mov    %esp,%ebp
80103943:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103946:	e8 75 ff ff ff       	call   801038c0 <mycpu>
}
8010394b:	c9                   	leave  
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
8010394c:	2d e0 47 11 80       	sub    $0x801147e0,%eax
80103951:	c1 f8 04             	sar    $0x4,%eax
80103954:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010395a:	c3                   	ret    
8010395b:	90                   	nop
8010395c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103960 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
80103960:	55                   	push   %ebp
80103961:	89 e5                	mov    %esp,%ebp
80103963:	53                   	push   %ebx
80103964:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
80103967:	e8 14 1f 00 00       	call   80105880 <pushcli>
  c = mycpu();
8010396c:	e8 4f ff ff ff       	call   801038c0 <mycpu>
  p = c->proc;
80103971:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103977:	e8 44 1f 00 00       	call   801058c0 <popcli>
  return p;
}
8010397c:	5a                   	pop    %edx
8010397d:	89 d8                	mov    %ebx,%eax
8010397f:	5b                   	pop    %ebx
80103980:	5d                   	pop    %ebp
80103981:	c3                   	ret    
80103982:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103990 <pushToSpecificQueue>:

void
pushToSpecificQueue(struct proc* p) {
    switch (currpolicy) {
80103990:	a1 04 c0 10 80       	mov    0x8010c004,%eax
  popcli();
  return p;
}

void
pushToSpecificQueue(struct proc* p) {
80103995:	55                   	push   %ebp
80103996:	89 e5                	mov    %esp,%ebp
80103998:	8b 55 08             	mov    0x8(%ebp),%edx
    switch (currpolicy) {
8010399b:	83 f8 02             	cmp    $0x2,%eax
8010399e:	74 10                	je     801039b0 <pushToSpecificQueue+0x20>
801039a0:	83 f8 03             	cmp    $0x3,%eax
801039a3:	74 0b                	je     801039b0 <pushToSpecificQueue+0x20>
801039a5:	48                   	dec    %eax
801039a6:	74 18                	je     801039c0 <pushToSpecificQueue+0x30>
            pq.put(p);
            break;
        default:
            break;
    }
}
801039a8:	5d                   	pop    %ebp
801039a9:	c3                   	ret    
801039aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            //myproc()->accumulator += myproc()->priority;
            pq.put(p);
            break;
        case 3:    //priority queue addition
            //myproc()->accumulator += myproc()->priority;
            pq.put(p);
801039b0:	89 55 08             	mov    %edx,0x8(%ebp)
            break;
        default:
            break;
    }
}
801039b3:	5d                   	pop    %ebp
            //myproc()->accumulator += myproc()->priority;
            pq.put(p);
            break;
        case 3:    //priority queue addition
            //myproc()->accumulator += myproc()->priority;
            pq.put(p);
801039b4:	ff 25 e8 c5 10 80    	jmp    *0x8010c5e8
801039ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            break;
        default:
            break;
    }
}
801039c0:	5d                   	pop    %ebp

void
pushToSpecificQueue(struct proc* p) {
    switch (currpolicy) {
        case 1://roundrobin addition
            rrq.enqueue(p);
801039c1:	ff 25 d8 c5 10 80    	jmp    *0x8010c5d8
801039c7:	89 f6                	mov    %esi,%esi
801039c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801039d0 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
801039d0:	55                   	push   %ebp
801039d1:	89 e5                	mov    %esp,%ebp
801039d3:	56                   	push   %esi
801039d4:	89 c6                	mov    %eax,%esi
801039d6:	53                   	push   %ebx
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801039d7:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
801039dc:	83 ec 10             	sub    $0x10,%esp
801039df:	eb 15                	jmp    801039f6 <wakeup1+0x26>
801039e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801039e8:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
801039ee:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
801039f4:	74 3d                	je     80103a33 <wakeup1+0x63>
    if(p->state == SLEEPING && p->chan == chan){
801039f6:	8b 53 0c             	mov    0xc(%ebx),%edx
801039f9:	83 fa 02             	cmp    $0x2,%edx
801039fc:	75 ea                	jne    801039e8 <wakeup1+0x18>
801039fe:	39 73 20             	cmp    %esi,0x20(%ebx)
80103a01:	75 e5                	jne    801039e8 <wakeup1+0x18>
        p->state = RUNNABLE;
        //TODO- roundrobin addition
        //rrq.enqueue(p);
        //TODO- priority queue addition
        p->accumulator+=p->priority;
80103a03:	8b 83 88 00 00 00    	mov    0x88(%ebx),%eax
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == SLEEPING && p->chan == chan){
        p->state = RUNNABLE;
80103a09:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
        //TODO- roundrobin addition
        //rrq.enqueue(p);
        //TODO- priority queue addition
        p->accumulator+=p->priority;
        //pq.put(p);
        pushToSpecificQueue(p);
80103a10:	89 1c 24             	mov    %ebx,(%esp)
    if(p->state == SLEEPING && p->chan == chan){
        p->state = RUNNABLE;
        //TODO- roundrobin addition
        //rrq.enqueue(p);
        //TODO- priority queue addition
        p->accumulator+=p->priority;
80103a13:	99                   	cltd   
80103a14:	01 83 80 00 00 00    	add    %eax,0x80(%ebx)
80103a1a:	11 93 84 00 00 00    	adc    %edx,0x84(%ebx)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a20:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
        //TODO- roundrobin addition
        //rrq.enqueue(p);
        //TODO- priority queue addition
        p->accumulator+=p->priority;
        //pq.put(p);
        pushToSpecificQueue(p);
80103a26:	e8 65 ff ff ff       	call   80103990 <pushToSpecificQueue>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a2b:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
80103a31:	75 c3                	jne    801039f6 <wakeup1+0x26>
        //TODO- priority queue addition
        p->accumulator+=p->priority;
        //pq.put(p);
        pushToSpecificQueue(p);
    }
}
80103a33:	83 c4 10             	add    $0x10,%esp
80103a36:	5b                   	pop    %ebx
80103a37:	5e                   	pop    %esi
80103a38:	5d                   	pop    %ebp
80103a39:	c3                   	ret    
80103a3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103a40 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80103a40:	55                   	push   %ebp
80103a41:	89 e5                	mov    %esp,%ebp
80103a43:	53                   	push   %ebx
80103a44:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
80103a47:	e8 74 fc ff ff       	call   801036c0 <allocproc>
80103a4c:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
80103a4e:	a3 c0 c5 10 80       	mov    %eax,0x8010c5c0
  if((p->pgdir = setupkvm()) == 0)
80103a53:	e8 18 49 00 00       	call   80108370 <setupkvm>
80103a58:	85 c0                	test   %eax,%eax
80103a5a:	89 43 04             	mov    %eax,0x4(%ebx)
80103a5d:	0f 84 38 01 00 00    	je     80103b9b <userinit+0x15b>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103a63:	b9 60 c4 10 80       	mov    $0x8010c460,%ecx
80103a68:	ba 2c 00 00 00       	mov    $0x2c,%edx
80103a6d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80103a71:	89 54 24 08          	mov    %edx,0x8(%esp)
80103a75:	89 04 24             	mov    %eax,(%esp)
80103a78:	e8 f3 45 00 00       	call   80108070 <inituvm>
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
80103a7d:	b8 4c 00 00 00       	mov    $0x4c,%eax
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
80103a82:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103a88:	89 44 24 08          	mov    %eax,0x8(%esp)
80103a8c:	31 c0                	xor    %eax,%eax
80103a8e:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a92:	8b 43 18             	mov    0x18(%ebx),%eax
80103a95:	89 04 24             	mov    %eax,(%esp)
80103a98:	e8 c3 1f 00 00       	call   80105a60 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a9d:	8b 43 18             	mov    0x18(%ebx),%eax
80103aa0:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103aa6:	8b 43 18             	mov    0x18(%ebx),%eax
80103aa9:	66 c7 40 2c 23 00    	movw   $0x23,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103aaf:	8b 43 18             	mov    0x18(%ebx),%eax
80103ab2:	8b 50 2c             	mov    0x2c(%eax),%edx
80103ab5:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103ab9:	8b 43 18             	mov    0x18(%ebx),%eax
80103abc:	8b 50 2c             	mov    0x2c(%eax),%edx
80103abf:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103ac3:	8b 43 18             	mov    0x18(%ebx),%eax
80103ac6:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103acd:	8b 43 18             	mov    0x18(%ebx),%eax
80103ad0:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103ad7:	8b 43 18             	mov    0x18(%ebx),%eax
80103ada:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103ae1:	b8 10 00 00 00       	mov    $0x10,%eax
80103ae6:	89 44 24 08          	mov    %eax,0x8(%esp)
80103aea:	b8 15 8c 10 80       	mov    $0x80108c15,%eax
80103aef:	89 44 24 04          	mov    %eax,0x4(%esp)
80103af3:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103af6:	89 04 24             	mov    %eax,(%esp)
80103af9:	e8 52 21 00 00       	call   80105c50 <safestrcpy>
  p->cwd = namei("/");
80103afe:	c7 04 24 1e 8c 10 80 	movl   $0x80108c1e,(%esp)
80103b05:	e8 86 e4 ff ff       	call   80101f90 <namei>
80103b0a:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80103b0d:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103b14:	e8 57 1e 00 00       	call   80105970 <acquire>

  p->state = RUNNABLE;
80103b19:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
    //TODO- roundrobin addition
  if(currpolicy==1)
80103b20:	a1 04 c0 10 80       	mov    0x8010c004,%eax
80103b25:	48                   	dec    %eax
80103b26:	74 68                	je     80103b90 <userinit+0x150>
    rrq.enqueue(p);
  //TODO- priority queue addition
  p->priority=5;
80103b28:	b8 05 00 00 00       	mov    $0x5,%eax
  p->RUNNABLE_wait_time=0; //surely 0 because this is the first initialized process
80103b2d:	31 d2                	xor    %edx,%edx
  p->state = RUNNABLE;
    //TODO- roundrobin addition
  if(currpolicy==1)
    rrq.enqueue(p);
  //TODO- priority queue addition
  p->priority=5;
80103b2f:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)
  p->RUNNABLE_wait_time=0; //surely 0 because this is the first initialized process
  p->accumulator=0; //is surely 0 because this is the first initialized process
80103b35:	31 c0                	xor    %eax,%eax
    //TODO- roundrobin addition
  if(currpolicy==1)
    rrq.enqueue(p);
  //TODO- priority queue addition
  p->priority=5;
  p->RUNNABLE_wait_time=0; //surely 0 because this is the first initialized process
80103b37:	31 c9                	xor    %ecx,%ecx
  p->accumulator=0; //is surely 0 because this is the first initialized process
80103b39:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
80103b3f:	31 c0                	xor    %eax,%eax
80103b41:	89 83 84 00 00 00    	mov    %eax,0x84(%ebx)
  if(currpolicy==2 || currpolicy==3)
80103b47:	a1 04 c0 10 80       	mov    0x8010c004,%eax
    //TODO- roundrobin addition
  if(currpolicy==1)
    rrq.enqueue(p);
  //TODO- priority queue addition
  p->priority=5;
  p->RUNNABLE_wait_time=0; //surely 0 because this is the first initialized process
80103b4c:	89 93 a0 00 00 00    	mov    %edx,0xa0(%ebx)
80103b52:	89 8b a4 00 00 00    	mov    %ecx,0xa4(%ebx)
  p->accumulator=0; //is surely 0 because this is the first initialized process
  if(currpolicy==2 || currpolicy==3)
80103b58:	83 f8 02             	cmp    $0x2,%eax
80103b5b:	74 23                	je     80103b80 <userinit+0x140>
80103b5d:	a1 04 c0 10 80       	mov    0x8010c004,%eax
80103b62:	83 f8 03             	cmp    $0x3,%eax
80103b65:	74 19                	je     80103b80 <userinit+0x140>
    pq.put(p);

  release(&ptable.lock);
80103b67:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103b6e:	e8 9d 1e 00 00       	call   80105a10 <release>
}
80103b73:	83 c4 14             	add    $0x14,%esp
80103b76:	5b                   	pop    %ebx
80103b77:	5d                   	pop    %ebp
80103b78:	c3                   	ret    
80103b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  //TODO- priority queue addition
  p->priority=5;
  p->RUNNABLE_wait_time=0; //surely 0 because this is the first initialized process
  p->accumulator=0; //is surely 0 because this is the first initialized process
  if(currpolicy==2 || currpolicy==3)
    pq.put(p);
80103b80:	89 1c 24             	mov    %ebx,(%esp)
80103b83:	ff 15 e8 c5 10 80    	call   *0x8010c5e8
80103b89:	eb dc                	jmp    80103b67 <userinit+0x127>
80103b8b:	90                   	nop
80103b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&ptable.lock);

  p->state = RUNNABLE;
    //TODO- roundrobin addition
  if(currpolicy==1)
    rrq.enqueue(p);
80103b90:	89 1c 24             	mov    %ebx,(%esp)
80103b93:	ff 15 d8 c5 10 80    	call   *0x8010c5d8
80103b99:	eb 8d                	jmp    80103b28 <userinit+0xe8>

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
80103b9b:	c7 04 24 fc 8b 10 80 	movl   $0x80108bfc,(%esp)
80103ba2:	e8 99 c7 ff ff       	call   80100340 <panic>
80103ba7:	89 f6                	mov    %esi,%esi
80103ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103bb0 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80103bb0:	55                   	push   %ebp
80103bb1:	89 e5                	mov    %esp,%ebp
80103bb3:	56                   	push   %esi
80103bb4:	53                   	push   %ebx
80103bb5:	83 ec 10             	sub    $0x10,%esp
80103bb8:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103bbb:	e8 c0 1c 00 00       	call   80105880 <pushcli>
  c = mycpu();
80103bc0:	e8 fb fc ff ff       	call   801038c0 <mycpu>
  p = c->proc;
80103bc5:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103bcb:	e8 f0 1c 00 00       	call   801058c0 <popcli>
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
80103bd0:	83 fe 00             	cmp    $0x0,%esi
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
80103bd3:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103bd5:	7e 31                	jle    80103c08 <growproc+0x58>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103bd7:	01 c6                	add    %eax,%esi
80103bd9:	89 74 24 08          	mov    %esi,0x8(%esp)
80103bdd:	89 44 24 04          	mov    %eax,0x4(%esp)
80103be1:	8b 43 04             	mov    0x4(%ebx),%eax
80103be4:	89 04 24             	mov    %eax,(%esp)
80103be7:	e8 d4 45 00 00       	call   801081c0 <allocuvm>
80103bec:	85 c0                	test   %eax,%eax
80103bee:	74 40                	je     80103c30 <growproc+0x80>
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
80103bf0:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103bf2:	89 1c 24             	mov    %ebx,(%esp)
80103bf5:	e8 76 43 00 00       	call   80107f70 <switchuvm>
  return 0;
80103bfa:	31 c0                	xor    %eax,%eax
}
80103bfc:	83 c4 10             	add    $0x10,%esp
80103bff:	5b                   	pop    %ebx
80103c00:	5e                   	pop    %esi
80103c01:	5d                   	pop    %ebp
80103c02:	c3                   	ret    
80103c03:	90                   	nop
80103c04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80103c08:	74 e6                	je     80103bf0 <growproc+0x40>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103c0a:	01 c6                	add    %eax,%esi
80103c0c:	89 74 24 08          	mov    %esi,0x8(%esp)
80103c10:	89 44 24 04          	mov    %eax,0x4(%esp)
80103c14:	8b 43 04             	mov    0x4(%ebx),%eax
80103c17:	89 04 24             	mov    %eax,(%esp)
80103c1a:	e8 a1 46 00 00       	call   801082c0 <deallocuvm>
80103c1f:	85 c0                	test   %eax,%eax
80103c21:	75 cd                	jne    80103bf0 <growproc+0x40>
80103c23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
80103c30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103c35:	eb c5                	jmp    80103bfc <growproc+0x4c>
80103c37:	89 f6                	mov    %esi,%esi
80103c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c40 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103c40:	55                   	push   %ebp
80103c41:	89 e5                	mov    %esp,%ebp
80103c43:	57                   	push   %edi
80103c44:	56                   	push   %esi
80103c45:	53                   	push   %ebx
80103c46:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103c49:	e8 32 1c 00 00       	call   80105880 <pushcli>
  c = mycpu();
80103c4e:	e8 6d fc ff ff       	call   801038c0 <mycpu>
  p = c->proc;
80103c53:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
80103c59:	e8 62 1c 00 00       	call   801058c0 <popcli>
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
80103c5e:	e8 5d fa ff ff       	call   801036c0 <allocproc>
80103c63:	85 c0                	test   %eax,%eax
80103c65:	0f 84 28 01 00 00    	je     80103d93 <fork+0x153>
80103c6b:	89 c6                	mov    %eax,%esi
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103c6d:	8b 07                	mov    (%edi),%eax
80103c6f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103c73:	8b 47 04             	mov    0x4(%edi),%eax
80103c76:	89 04 24             	mov    %eax,(%esp)
80103c79:	e8 d2 47 00 00       	call   80108450 <copyuvm>
80103c7e:	85 c0                	test   %eax,%eax
80103c80:	89 46 04             	mov    %eax,0x4(%esi)
80103c83:	0f 84 11 01 00 00    	je     80103d9a <fork+0x15a>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
80103c89:	8b 07                	mov    (%edi),%eax
  np->parent = curproc;
80103c8b:	89 7e 14             	mov    %edi,0x14(%esi)
  *np->tf = *curproc->tf;
80103c8e:	8b 4e 18             	mov    0x18(%esi),%ecx
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
80103c91:	89 06                	mov    %eax,(%esi)
  np->parent = curproc;
  *np->tf = *curproc->tf;
80103c93:	31 c0                	xor    %eax,%eax
80103c95:	8b 57 18             	mov    0x18(%edi),%edx
80103c98:	8b 1c 02             	mov    (%edx,%eax,1),%ebx
80103c9b:	89 1c 01             	mov    %ebx,(%ecx,%eax,1)
80103c9e:	83 c0 04             	add    $0x4,%eax
80103ca1:	83 f8 4c             	cmp    $0x4c,%eax
80103ca4:	72 f2                	jb     80103c98 <fork+0x58>

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103ca6:	8b 46 18             	mov    0x18(%esi),%eax

  for(i = 0; i < NOFILE; i++)
80103ca9:	31 db                	xor    %ebx,%ebx
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103cab:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103cb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
80103cc0:	8b 44 9f 28          	mov    0x28(%edi,%ebx,4),%eax
80103cc4:	85 c0                	test   %eax,%eax
80103cc6:	74 0c                	je     80103cd4 <fork+0x94>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103cc8:	89 04 24             	mov    %eax,(%esp)
80103ccb:	e8 00 d1 ff ff       	call   80100dd0 <filedup>
80103cd0:	89 44 9e 28          	mov    %eax,0x28(%esi,%ebx,4)
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103cd4:	43                   	inc    %ebx
80103cd5:	83 fb 10             	cmp    $0x10,%ebx
80103cd8:	75 e6                	jne    80103cc0 <fork+0x80>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103cda:	8b 47 68             	mov    0x68(%edi),%eax

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103cdd:	83 c7 6c             	add    $0x6c,%edi
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103ce0:	89 04 24             	mov    %eax,(%esp)
80103ce3:	e8 d8 d9 ff ff       	call   801016c0 <idup>

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ce8:	b9 10 00 00 00       	mov    $0x10,%ecx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103ced:	89 46 68             	mov    %eax,0x68(%esi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103cf0:	8d 46 6c             	lea    0x6c(%esi),%eax
80103cf3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80103cf7:	89 7c 24 04          	mov    %edi,0x4(%esp)

  np->state = RUNNABLE;
    //TODO- roundrobin addition
  //rrq.enqueue(np);
  //TODO - priority addition
  np->priority=5;
80103cfb:	bf 05 00 00 00       	mov    $0x5,%edi
  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d00:	89 04 24             	mov    %eax,(%esp)
80103d03:	e8 48 1f 00 00       	call   80105c50 <safestrcpy>

  pid = np->pid;
80103d08:	8b 5e 10             	mov    0x10(%esi),%ebx

  acquire(&ptable.lock);
80103d0b:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103d12:	e8 59 1c 00 00       	call   80105970 <acquire>

  np->state = RUNNABLE;
80103d17:	c7 46 0c 03 00 00 00 	movl   $0x3,0xc(%esi)
    //TODO- roundrobin addition
  //rrq.enqueue(np);
  //TODO - priority addition
  np->priority=5;
  np->RUNNABLE_wait_time=counter;
80103d1e:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
80103d23:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx

  np->state = RUNNABLE;
    //TODO- roundrobin addition
  //rrq.enqueue(np);
  //TODO - priority addition
  np->priority=5;
80103d29:	89 be 88 00 00 00    	mov    %edi,0x88(%esi)
  np->RUNNABLE_wait_time=counter;
80103d2f:	89 86 a0 00 00 00    	mov    %eax,0xa0(%esi)
80103d35:	89 96 a4 00 00 00    	mov    %edx,0xa4(%esi)
  //check if this is the only procces
  if(pq.isEmpty()&&rpholder.isEmpty()) //if the only process -> acc=0
80103d3b:	ff 15 e4 c5 10 80    	call   *0x8010c5e4
80103d41:	85 c0                	test   %eax,%eax
80103d43:	74 3b                	je     80103d80 <fork+0x140>
80103d45:	ff 15 c4 c5 10 80    	call   *0x8010c5c4
80103d4b:	85 c0                	test   %eax,%eax
80103d4d:	8d 76 00             	lea    0x0(%esi),%esi
80103d50:	74 2e                	je     80103d80 <fork+0x140>
    np->accumulator=0;
80103d52:	31 c0                	xor    %eax,%eax
80103d54:	31 d2                	xor    %edx,%edx
80103d56:	89 86 80 00 00 00    	mov    %eax,0x80(%esi)
80103d5c:	89 96 84 00 00 00    	mov    %edx,0x84(%esi)
  else //there are more than 1 procces -> change acc value to min
    np->accumulator=getMinAccumulator();
  //add np (i.e currproc) to the priority queue
  //pq.put(np);
  pushToSpecificQueue(np);
80103d62:	89 34 24             	mov    %esi,(%esp)
80103d65:	e8 26 fc ff ff       	call   80103990 <pushToSpecificQueue>

  release(&ptable.lock);
80103d6a:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103d71:	e8 9a 1c 00 00       	call   80105a10 <release>

  return pid;
80103d76:	89 d8                	mov    %ebx,%eax
}
80103d78:	83 c4 1c             	add    $0x1c,%esp
80103d7b:	5b                   	pop    %ebx
80103d7c:	5e                   	pop    %esi
80103d7d:	5f                   	pop    %edi
80103d7e:	5d                   	pop    %ebp
80103d7f:	c3                   	ret    
  np->RUNNABLE_wait_time=counter;
  //check if this is the only procces
  if(pq.isEmpty()&&rpholder.isEmpty()) //if the only process -> acc=0
    np->accumulator=0;
  else //there are more than 1 procces -> change acc value to min
    np->accumulator=getMinAccumulator();
80103d80:	e8 7b fa ff ff       	call   80103800 <getMinAccumulator>
80103d85:	89 86 80 00 00 00    	mov    %eax,0x80(%esi)
80103d8b:	89 96 84 00 00 00    	mov    %edx,0x84(%esi)
80103d91:	eb cf                	jmp    80103d62 <fork+0x122>
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103d93:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103d98:	eb de                	jmp    80103d78 <fork+0x138>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
80103d9a:	8b 46 08             	mov    0x8(%esi),%eax
80103d9d:	89 04 24             	mov    %eax,(%esp)
80103da0:	e8 eb e5 ff ff       	call   80102390 <kfree>
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
80103da5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
80103daa:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
    np->state = UNUSED;
80103db1:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    return -1;
80103db8:	eb be                	jmp    80103d78 <fork+0x138>
80103dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103dc0 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103dc0:	55                   	push   %ebp
80103dc1:	89 e5                	mov    %esp,%ebp
80103dc3:	57                   	push   %edi
80103dc4:	56                   	push   %esi
  struct proc *p;
  struct cpu *c = mycpu();
  struct proc *max_p=ptable.proc; //just a dummy initialized value to compiled
    c->proc = 0;
80103dc5:	31 f6                	xor    %esi,%esi
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103dc7:	53                   	push   %ebx
80103dc8:	83 ec 2c             	sub    $0x2c,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80103dcb:	e8 f0 fa ff ff       	call   801038c0 <mycpu>
  struct proc *max_p=ptable.proc; //just a dummy initialized value to compiled
80103dd0:	c7 45 e4 b4 4d 11 80 	movl   $0x80114db4,-0x1c(%ebp)
    c->proc = 0;
80103dd7:	89 b0 ac 00 00 00    	mov    %esi,0xac(%eax)
//      via swtch back to the scheduler.
void
scheduler(void)
{
  struct proc *p;
  struct cpu *c = mycpu();
80103ddd:	89 c7                	mov    %eax,%edi
80103ddf:	8d 70 04             	lea    0x4(%eax),%esi
80103de2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103df0:	fb                   	sti    
  
  for(;;){
    // Enable interrupts on this processor.
    sti();
    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103df1:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103df8:	e8 73 1b 00 00       	call   80105970 <acquire>

    counter++;
80103dfd:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
80103e02:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
80103e08:	83 c0 01             	add    $0x1,%eax
80103e0b:	83 d2 00             	adc    $0x0,%edx
80103e0e:	a3 b8 c5 10 80       	mov    %eax,0x8010c5b8
80103e13:	89 15 bc c5 10 80    	mov    %edx,0x8010c5bc

    //policies cases - depends on the global variable currpolicy
    switch (currpolicy) {
80103e19:	a1 04 c0 10 80       	mov    0x8010c004,%eax
80103e1e:	83 f8 02             	cmp    $0x2,%eax
80103e21:	0f 84 a1 00 00 00    	je     80103ec8 <scheduler+0x108>
80103e27:	83 f8 03             	cmp    $0x3,%eax
80103e2a:	0f 84 30 01 00 00    	je     80103f60 <scheduler+0x1a0>
80103e30:	48                   	dec    %eax
80103e31:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
80103e36:	75 16                	jne    80103e4e <scheduler+0x8e>
80103e38:	e9 f3 00 00 00       	jmp    80103f30 <scheduler+0x170>
80103e3d:	8d 76 00             	lea    0x0(%esi),%esi
            }
            break;


        default: //default case is what we got with the xv6
            for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103e40:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80103e46:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
80103e4c:	74 62                	je     80103eb0 <scheduler+0xf0>
                if (p->state != RUNNABLE)
80103e4e:	8b 43 0c             	mov    0xc(%ebx),%eax
80103e51:	83 f8 03             	cmp    $0x3,%eax
80103e54:	75 ea                	jne    80103e40 <scheduler+0x80>
                    continue;

                // Switch to chosen process.  It is the process's job
                // to release ptable.lock and then reacquire it
                // before jumping back to us.
                c->proc = p;
80103e56:	89 9f ac 00 00 00    	mov    %ebx,0xac(%edi)
                switchuvm(p);
80103e5c:	89 1c 24             	mov    %ebx,(%esp)
80103e5f:	e8 0c 41 00 00       	call   80107f70 <switchuvm>
                p->state = RUNNING;
80103e64:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
                //TODO - adittion to priority queue
                rpholder.add(p);
80103e6b:	89 1c 24             	mov    %ebx,(%esp)
            }
            break;


        default: //default case is what we got with the xv6
            for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103e6e:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
                // before jumping back to us.
                c->proc = p;
                switchuvm(p);
                p->state = RUNNING;
                //TODO - adittion to priority queue
                rpholder.add(p);
80103e74:	ff 15 c8 c5 10 80    	call   *0x8010c5c8

                swtch(&(c->scheduler), p->context);
80103e7a:	8b 83 74 ff ff ff    	mov    -0x8c(%ebx),%eax
80103e80:	89 34 24             	mov    %esi,(%esp)
80103e83:	89 44 24 04          	mov    %eax,0x4(%esp)
80103e87:	e8 1d 1e 00 00       	call   80105ca9 <swtch>
                switchkvm();
80103e8c:	e8 bf 40 00 00       	call   80107f50 <switchkvm>

                // Process is done running for now.
                // It should have changed its p->state before coming back.
                c->proc = 0;
80103e91:	31 c0                	xor    %eax,%eax
            }
            break;


        default: //default case is what we got with the xv6
            for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103e93:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
                swtch(&(c->scheduler), p->context);
                switchkvm();

                // Process is done running for now.
                // It should have changed its p->state before coming back.
                c->proc = 0;
80103e99:	89 87 ac 00 00 00    	mov    %eax,0xac(%edi)
            }
            break;


        default: //default case is what we got with the xv6
            for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103e9f:	75 ad                	jne    80103e4e <scheduler+0x8e>
80103ea1:	eb 0d                	jmp    80103eb0 <scheduler+0xf0>
80103ea3:	90                   	nop
80103ea4:	90                   	nop
80103ea5:	90                   	nop
80103ea6:	90                   	nop
80103ea7:	90                   	nop
80103ea8:	90                   	nop
80103ea9:	90                   	nop
80103eaa:	90                   	nop
80103eab:	90                   	nop
80103eac:	90                   	nop
80103ead:	90                   	nop
80103eae:	90                   	nop
80103eaf:	90                   	nop
                c->proc = 0;
            }
            break;

    }
      release(&ptable.lock);
80103eb0:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103eb7:	e8 54 1b 00 00       	call   80105a10 <release>
  }
80103ebc:	e9 2f ff ff ff       	jmp    80103df0 <scheduler+0x30>
80103ec1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                }
            }
            break;

        case 2: //3.2 - priority scheduling
            if (!pq.isEmpty()) {
80103ec8:	ff 15 e4 c5 10 80    	call   *0x8010c5e4
80103ece:	85 c0                	test   %eax,%eax
80103ed0:	75 de                	jne    80103eb0 <scheduler+0xf0>
                p = pq.extractMin();
80103ed2:	ff 15 f0 c5 10 80    	call   *0x8010c5f0
                if (p != null) {
80103ed8:	85 c0                	test   %eax,%eax
            }
            break;

        case 2: //3.2 - priority scheduling
            if (!pq.isEmpty()) {
                p = pq.extractMin();
80103eda:	89 c3                	mov    %eax,%ebx
                if (p != null) {
80103edc:	74 d2                	je     80103eb0 <scheduler+0xf0>
                    //cprintf("curr policy= %d,\n",currpolicy);

                    // Switch to chosen process.  It is the process's job
                    // to release ptable.lock and then reacquire it
                    // before jumping back to us.
                    c->proc = p;
80103ede:	89 9f ac 00 00 00    	mov    %ebx,0xac(%edi)
                    switchuvm(p);
80103ee4:	89 1c 24             	mov    %ebx,(%esp)
80103ee7:	e8 84 40 00 00       	call   80107f70 <switchuvm>
                    p->state = RUNNING;
80103eec:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
                    switchuvm(p);
                    p->state = RUNNING;
                    //TODO - adittion to priority queue
                    //save the last time of running
                    p->RUNNABLE_wait_time=counter;
                    rpholder.add(p);
80103ef3:	89 1c 24             	mov    %ebx,(%esp)
80103ef6:	ff 15 c8 c5 10 80    	call   *0x8010c5c8


                    swtch(&(c->scheduler), p->context);
80103efc:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103eff:	89 34 24             	mov    %esi,(%esp)
80103f02:	89 44 24 04          	mov    %eax,0x4(%esp)
80103f06:	e8 9e 1d 00 00       	call   80105ca9 <swtch>
                    switchkvm();
80103f0b:	e8 40 40 00 00       	call   80107f50 <switchkvm>

                    // Process is done running for now.
                    // It should have changed its p->state before coming back.
                    c->proc = 0;
80103f10:	31 d2                	xor    %edx,%edx
80103f12:	89 97 ac 00 00 00    	mov    %edx,0xac(%edi)
                c->proc = 0;
            }
            break;

    }
      release(&ptable.lock);
80103f18:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103f1f:	e8 ec 1a 00 00       	call   80105a10 <release>
80103f24:	e9 c7 fe ff ff       	jmp    80103df0 <scheduler+0x30>
80103f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    counter++;

    //policies cases - depends on the global variable currpolicy
    switch (currpolicy) {
        case 1: //round robin policy
            if (!rrq.isEmpty()) {
80103f30:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
80103f36:	85 c0                	test   %eax,%eax
80103f38:	0f 85 72 ff ff ff    	jne    80103eb0 <scheduler+0xf0>
80103f3e:	66 90                	xchg   %ax,%ax
                p = rrq.dequeue();
80103f40:	ff 15 dc c5 10 80    	call   *0x8010c5dc
                if (p != null) {
80103f46:	85 c0                	test   %eax,%eax

    //policies cases - depends on the global variable currpolicy
    switch (currpolicy) {
        case 1: //round robin policy
            if (!rrq.isEmpty()) {
                p = rrq.dequeue();
80103f48:	89 c3                	mov    %eax,%ebx
                if (p != null) {
80103f4a:	75 92                	jne    80103ede <scheduler+0x11e>
                c->proc = 0;
            }
            break;

    }
      release(&ptable.lock);
80103f4c:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103f53:	e8 b8 1a 00 00       	call   80105a10 <release>
80103f58:	e9 93 fe ff ff       	jmp    80103df0 <scheduler+0x30>
80103f5d:	8d 76 00             	lea    0x0(%esi),%esi
	    // TODO we must consider case where we want to add another int wating time
            // that counts time between running periods or just use the max total waiting time
            //of all process.

        case 3: //3.3 - priority scheduling
            if (!pq.isEmpty()) {
80103f60:	ff 15 e4 c5 10 80    	call   *0x8010c5e4
80103f66:	85 c0                	test   %eax,%eax
80103f68:	0f 85 42 ff ff ff    	jne    80103eb0 <scheduler+0xf0>
                if( counter % 100 == 0)
80103f6e:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
80103f73:	b9 64 00 00 00       	mov    $0x64,%ecx
80103f78:	31 db                	xor    %ebx,%ebx
80103f7a:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
80103f80:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80103f84:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
80103f88:	89 04 24             	mov    %eax,(%esp)
80103f8b:	89 54 24 04          	mov    %edx,0x4(%esp)
80103f8f:	e8 6c 16 00 00       	call   80105600 <__moddi3>
80103f94:	09 c2                	or     %eax,%edx
80103f96:	0f 85 b5 00 00 00    	jne    80104051 <scheduler+0x291>
                {
                    //cprintf("counter= %d,\n",counter);
                    long long min = counter;
80103f9c:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
80103fa1:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
80103fa7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
                    //find the process with max RUNNABLE waiting time
                    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103faa:	89 75 e0             	mov    %esi,-0x20(%ebp)
80103fad:	89 7d e4             	mov    %edi,-0x1c(%ebp)
        case 3: //3.3 - priority scheduling
            if (!pq.isEmpty()) {
                if( counter % 100 == 0)
                {
                    //cprintf("counter= %d,\n",counter);
                    long long min = counter;
80103fb0:	89 d1                	mov    %edx,%ecx
80103fb2:	89 c2                	mov    %eax,%edx
                    //find the process with max RUNNABLE waiting time
                    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103fb4:	89 df                	mov    %ebx,%edi
80103fb6:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
80103fbb:	89 cb                	mov    %ecx,%ebx
80103fbd:	89 d1                	mov    %edx,%ecx
80103fbf:	eb 13                	jmp    80103fd4 <scheduler+0x214>
80103fc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103fc8:	05 a8 00 00 00       	add    $0xa8,%eax
80103fcd:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
80103fd2:	74 30                	je     80104004 <scheduler+0x244>
                        if ((p->state == RUNNABLE) && (p->RUNNABLE_wait_time < min)){
80103fd4:	8b 50 0c             	mov    0xc(%eax),%edx
80103fd7:	83 fa 03             	cmp    $0x3,%edx
80103fda:	75 ec                	jne    80103fc8 <scheduler+0x208>
80103fdc:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80103fe2:	8b b0 a0 00 00 00    	mov    0xa0(%eax),%esi
80103fe8:	39 da                	cmp    %ebx,%edx
80103fea:	7f dc                	jg     80103fc8 <scheduler+0x208>
80103fec:	7c 04                	jl     80103ff2 <scheduler+0x232>
80103fee:	39 ce                	cmp    %ecx,%esi
80103ff0:	73 d6                	jae    80103fc8 <scheduler+0x208>
80103ff2:	89 c7                	mov    %eax,%edi
                if( counter % 100 == 0)
                {
                    //cprintf("counter= %d,\n",counter);
                    long long min = counter;
                    //find the process with max RUNNABLE waiting time
                    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103ff4:	05 a8 00 00 00       	add    $0xa8,%eax
80103ff9:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
                        if ((p->state == RUNNABLE) && (p->RUNNABLE_wait_time < min)){
80103ffe:	89 f1                	mov    %esi,%ecx
80104000:	89 d3                	mov    %edx,%ebx
                if( counter % 100 == 0)
                {
                    //cprintf("counter= %d,\n",counter);
                    long long min = counter;
                    //find the process with max RUNNABLE waiting time
                    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104002:	75 d0                	jne    80103fd4 <scheduler+0x214>
80104004:	89 fb                	mov    %edi,%ebx
80104006:	8b 75 e0             	mov    -0x20(%ebp),%esi
                            min = p->RUNNABLE_wait_time;
                            max_p = p;
                        }
                    }

                    pq.extractProc(max_p);
80104009:	89 1c 24             	mov    %ebx,(%esp)
8010400c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010400f:	ff 15 f8 c5 10 80    	call   *0x8010c5f8
80104015:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
                    p=max_p;
                }
                else {
                    p = pq.extractMin();
                }
                if (p != null) {
80104018:	85 db                	test   %ebx,%ebx
8010401a:	0f 84 90 fe ff ff    	je     80103eb0 <scheduler+0xf0>
                    //cprintf("curr policy= %d,\n",currpolicy);

                    // Switch to chosen process.  It is the process's job
                    // to release ptable.lock and then reacquire it
                    // before jumping back to us.
                    c->proc = p;
80104020:	89 9f ac 00 00 00    	mov    %ebx,0xac(%edi)
                    switchuvm(p);
80104026:	89 1c 24             	mov    %ebx,(%esp)
80104029:	e8 42 3f 00 00       	call   80107f70 <switchuvm>
                    p->state = RUNNING;
8010402e:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
                    //TODO - adittion to priority queue
                    //save the last time of running
                    p->RUNNABLE_wait_time=counter;
80104035:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
8010403a:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
80104040:	89 83 a0 00 00 00    	mov    %eax,0xa0(%ebx)
80104046:	89 93 a4 00 00 00    	mov    %edx,0xa4(%ebx)
8010404c:	e9 a2 fe ff ff       	jmp    80103ef3 <scheduler+0x133>

                    pq.extractProc(max_p);
                    p=max_p;
                }
                else {
                    p = pq.extractMin();
80104051:	ff 15 f0 c5 10 80    	call   *0x8010c5f0
80104057:	89 c3                	mov    %eax,%ebx
80104059:	eb bd                	jmp    80104018 <scheduler+0x258>
8010405b:	90                   	nop
8010405c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104060 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80104060:	55                   	push   %ebp
80104061:	89 e5                	mov    %esp,%ebp
80104063:	56                   	push   %esi
80104064:	53                   	push   %ebx
80104065:	83 ec 10             	sub    $0x10,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80104068:	e8 13 18 00 00       	call   80105880 <pushcli>
  c = mycpu();
8010406d:	e8 4e f8 ff ff       	call   801038c0 <mycpu>
  p = c->proc;
80104072:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104078:	e8 43 18 00 00       	call   801058c0 <popcli>
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
8010407d:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104084:	e8 a7 18 00 00       	call   80105930 <holding>
80104089:	85 c0                	test   %eax,%eax
8010408b:	74 51                	je     801040de <sched+0x7e>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
8010408d:	e8 2e f8 ff ff       	call   801038c0 <mycpu>
80104092:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80104099:	75 67                	jne    80104102 <sched+0xa2>
    panic("sched locks");
  if(p->state == RUNNING)
8010409b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010409e:	83 f8 04             	cmp    $0x4,%eax
801040a1:	74 53                	je     801040f6 <sched+0x96>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801040a3:	9c                   	pushf  
801040a4:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
801040a5:	f6 c4 02             	test   $0x2,%ah
801040a8:	75 40                	jne    801040ea <sched+0x8a>
    panic("sched interruptible");
  intena = mycpu()->intena;
801040aa:	e8 11 f8 ff ff       	call   801038c0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
801040af:	83 c3 1c             	add    $0x1c,%ebx
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
801040b2:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
801040b8:	e8 03 f8 ff ff       	call   801038c0 <mycpu>
801040bd:	8b 40 04             	mov    0x4(%eax),%eax
801040c0:	89 1c 24             	mov    %ebx,(%esp)
801040c3:	89 44 24 04          	mov    %eax,0x4(%esp)
801040c7:	e8 dd 1b 00 00       	call   80105ca9 <swtch>
  mycpu()->intena = intena;
801040cc:	e8 ef f7 ff ff       	call   801038c0 <mycpu>
801040d1:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
801040d7:	83 c4 10             	add    $0x10,%esp
801040da:	5b                   	pop    %ebx
801040db:	5e                   	pop    %esi
801040dc:	5d                   	pop    %ebp
801040dd:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
801040de:	c7 04 24 20 8c 10 80 	movl   $0x80108c20,(%esp)
801040e5:	e8 56 c2 ff ff       	call   80100340 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
801040ea:	c7 04 24 4c 8c 10 80 	movl   $0x80108c4c,(%esp)
801040f1:	e8 4a c2 ff ff       	call   80100340 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
801040f6:	c7 04 24 3e 8c 10 80 	movl   $0x80108c3e,(%esp)
801040fd:	e8 3e c2 ff ff       	call   80100340 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80104102:	c7 04 24 32 8c 10 80 	movl   $0x80108c32,(%esp)
80104109:	e8 32 c2 ff ff       	call   80100340 <panic>
8010410e:	66 90                	xchg   %ax,%ax

80104110 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(int status)
{
80104110:	55                   	push   %ebp
80104111:	89 e5                	mov    %esp,%ebp
80104113:	57                   	push   %edi
80104114:	56                   	push   %esi
80104115:	53                   	push   %ebx
80104116:	83 ec 1c             	sub    $0x1c,%esp
80104119:	8b 5d 08             	mov    0x8(%ebp),%ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
8010411c:	e8 5f 17 00 00       	call   80105880 <pushcli>
  c = mycpu();
80104121:	e8 9a f7 ff ff       	call   801038c0 <mycpu>
  p = c->proc;
80104126:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
8010412c:	e8 8f 17 00 00       	call   801058c0 <popcli>
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  //TODO - the addition
  cprintf("**exit** status=  %d\t curproc->exit_status=  %d\n",status,curproc->exit_status);
80104131:	8b 46 7c             	mov    0x7c(%esi),%eax
80104134:	8d 7e 68             	lea    0x68(%esi),%edi
80104137:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010413b:	c7 04 24 08 8d 10 80 	movl   $0x80108d08,(%esp)
80104142:	89 44 24 08          	mov    %eax,0x8(%esp)
80104146:	e8 f5 c4 ff ff       	call   80100640 <cprintf>
  curproc->exit_status=status;

    if(curproc == initproc)
8010414b:	39 35 c0 c5 10 80    	cmp    %esi,0x8010c5c0
  struct proc *p;
  int fd;

  //TODO - the addition
  cprintf("**exit** status=  %d\t curproc->exit_status=  %d\n",status,curproc->exit_status);
  curproc->exit_status=status;
80104151:	89 5e 7c             	mov    %ebx,0x7c(%esi)
80104154:	8d 5e 28             	lea    0x28(%esi),%ebx

    if(curproc == initproc)
80104157:	0f 84 ab 00 00 00    	je     80104208 <exit+0xf8>
8010415d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
80104160:	8b 03                	mov    (%ebx),%eax
80104162:	85 c0                	test   %eax,%eax
80104164:	74 0e                	je     80104174 <exit+0x64>
      fileclose(curproc->ofile[fd]);
80104166:	89 04 24             	mov    %eax,(%esp)
80104169:	e8 b2 cc ff ff       	call   80100e20 <fileclose>
      curproc->ofile[fd] = 0;
8010416e:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104174:	83 c3 04             	add    $0x4,%ebx

    if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80104177:	39 fb                	cmp    %edi,%ebx
80104179:	75 e5                	jne    80104160 <exit+0x50>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
8010417b:	e8 80 ea ff ff       	call   80102c00 <begin_op>
  iput(curproc->cwd);
80104180:	8b 46 68             	mov    0x68(%esi),%eax

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104183:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(curproc->cwd);
80104188:	89 04 24             	mov    %eax,(%esp)
8010418b:	e8 90 d6 ff ff       	call   80101820 <iput>
  end_op();
80104190:	e8 db ea ff ff       	call   80102c70 <end_op>
  curproc->cwd = 0;
80104195:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)

  acquire(&ptable.lock);
8010419c:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801041a3:	e8 c8 17 00 00       	call   80105970 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
801041a8:	8b 46 14             	mov    0x14(%esi),%eax
801041ab:	e8 20 f8 ff ff       	call   801039d0 <wakeup1>
801041b0:	eb 14                	jmp    801041c6 <exit+0xb6>
801041b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041b8:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
801041be:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
801041c4:	74 2a                	je     801041f0 <exit+0xe0>
    if(p->parent == curproc){
801041c6:	39 73 14             	cmp    %esi,0x14(%ebx)
801041c9:	75 ed                	jne    801041b8 <exit+0xa8>
      p->parent = initproc;
      if(p->state == ZOMBIE)
801041cb:	8b 53 0c             	mov    0xc(%ebx),%edx
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
801041ce:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
      if(p->state == ZOMBIE)
801041d3:	83 fa 05             	cmp    $0x5,%edx
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
801041d6:	89 43 14             	mov    %eax,0x14(%ebx)
      if(p->state == ZOMBIE)
801041d9:	75 dd                	jne    801041b8 <exit+0xa8>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041db:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
    if(p->parent == curproc){
      p->parent = initproc;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
801041e1:	e8 ea f7 ff ff       	call   801039d0 <wakeup1>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041e6:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
801041ec:	75 d8                	jne    801041c6 <exit+0xb6>
801041ee:	66 90                	xchg   %ax,%ax
    }
  }


  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
801041f0:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
801041f7:	e8 64 fe ff ff       	call   80104060 <sched>
  panic("zombie exit");
801041fc:	c7 04 24 6d 8c 10 80 	movl   $0x80108c6d,(%esp)
80104203:	e8 38 c1 ff ff       	call   80100340 <panic>
  //TODO - the addition
  cprintf("**exit** status=  %d\t curproc->exit_status=  %d\n",status,curproc->exit_status);
  curproc->exit_status=status;

    if(curproc == initproc)
    panic("init exiting");
80104208:	c7 04 24 60 8c 10 80 	movl   $0x80108c60,(%esp)
8010420f:	e8 2c c1 ff ff       	call   80100340 <panic>
80104214:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010421a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104220 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80104220:	55                   	push   %ebp
80104221:	89 e5                	mov    %esp,%ebp
80104223:	56                   	push   %esi
80104224:	53                   	push   %ebx
80104225:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104228:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
8010422f:	e8 3c 17 00 00       	call   80105970 <acquire>
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80104234:	e8 47 16 00 00       	call   80105880 <pushcli>
  c = mycpu();
80104239:	e8 82 f6 ff ff       	call   801038c0 <mycpu>
  p = c->proc;
8010423e:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104244:	e8 77 16 00 00       	call   801058c0 <popcli>
// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
80104249:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80104250:	e8 2b 16 00 00       	call   80105880 <pushcli>
  c = mycpu();
80104255:	e8 66 f6 ff ff       	call   801038c0 <mycpu>
  p = c->proc;
8010425a:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104260:	e8 5b 16 00 00       	call   801058c0 <popcli>
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
  myproc()->accumulator+=myproc()->priority;
80104265:	8b 9b 88 00 00 00    	mov    0x88(%ebx),%ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
8010426b:	e8 10 16 00 00       	call   80105880 <pushcli>
  c = mycpu();
80104270:	e8 4b f6 ff ff       	call   801038c0 <mycpu>
  p = c->proc;
80104275:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
8010427b:	e8 40 16 00 00       	call   801058c0 <popcli>
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
  myproc()->accumulator+=myproc()->priority;
80104280:	89 d8                	mov    %ebx,%eax
80104282:	99                   	cltd   
80104283:	01 9e 80 00 00 00    	add    %ebx,0x80(%esi)
  //TODO - addition to round-robin scheduling
  rrq.enqueue(myproc());
80104289:	8b 1d d8 c5 10 80    	mov    0x8010c5d8,%ebx
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
  myproc()->accumulator+=myproc()->priority;
8010428f:	11 96 84 00 00 00    	adc    %edx,0x84(%esi)
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80104295:	e8 e6 15 00 00       	call   80105880 <pushcli>
  c = mycpu();
8010429a:	e8 21 f6 ff ff       	call   801038c0 <mycpu>
  p = c->proc;
8010429f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801042a5:	e8 16 16 00 00       	call   801058c0 <popcli>
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
  myproc()->accumulator+=myproc()->priority;
  //TODO - addition to round-robin scheduling
  rrq.enqueue(myproc());
801042aa:	89 34 24             	mov    %esi,(%esp)
801042ad:	ff d3                	call   *%ebx
  //TODO- priority queue addition
  pq.put(myproc()); //add to runabble queue
801042af:	8b 1d e8 c5 10 80    	mov    0x8010c5e8,%ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
801042b5:	e8 c6 15 00 00       	call   80105880 <pushcli>
  c = mycpu();
801042ba:	e8 01 f6 ff ff       	call   801038c0 <mycpu>
  p = c->proc;
801042bf:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801042c5:	e8 f6 15 00 00       	call   801058c0 <popcli>
  myproc()->state = RUNNABLE;
  myproc()->accumulator+=myproc()->priority;
  //TODO - addition to round-robin scheduling
  rrq.enqueue(myproc());
  //TODO- priority queue addition
  pq.put(myproc()); //add to runabble queue
801042ca:	89 34 24             	mov    %esi,(%esp)
801042cd:	ff d3                	call   *%ebx
  rpholder.remove(myproc());//remove from running queue
801042cf:	8b 1d cc c5 10 80    	mov    0x8010c5cc,%ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
801042d5:	e8 a6 15 00 00       	call   80105880 <pushcli>
  c = mycpu();
801042da:	e8 e1 f5 ff ff       	call   801038c0 <mycpu>
  p = c->proc;
801042df:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801042e5:	e8 d6 15 00 00       	call   801058c0 <popcli>
  myproc()->accumulator+=myproc()->priority;
  //TODO - addition to round-robin scheduling
  rrq.enqueue(myproc());
  //TODO- priority queue addition
  pq.put(myproc()); //add to runabble queue
  rpholder.remove(myproc());//remove from running queue
801042ea:	89 34 24             	mov    %esi,(%esp)
801042ed:	ff d3                	call   *%ebx

  sched();
801042ef:	e8 6c fd ff ff       	call   80104060 <sched>
  release(&ptable.lock);
801042f4:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801042fb:	e8 10 17 00 00       	call   80105a10 <release>
}
80104300:	83 c4 10             	add    $0x10,%esp
80104303:	5b                   	pop    %ebx
80104304:	5e                   	pop    %esi
80104305:	5d                   	pop    %ebp
80104306:	c3                   	ret    
80104307:	89 f6                	mov    %esi,%esi
80104309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104310 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104310:	55                   	push   %ebp
80104311:	89 e5                	mov    %esp,%ebp
80104313:	83 ec 28             	sub    $0x28,%esp
80104316:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80104319:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010431c:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010431f:	8b 75 08             	mov    0x8(%ebp),%esi
80104322:	89 7d fc             	mov    %edi,-0x4(%ebp)
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80104325:	e8 56 15 00 00       	call   80105880 <pushcli>
  c = mycpu();
8010432a:	e8 91 f5 ff ff       	call   801038c0 <mycpu>
  p = c->proc;
8010432f:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
80104335:	e8 86 15 00 00       	call   801058c0 <popcli>
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
8010433a:	85 ff                	test   %edi,%edi
8010433c:	0f 84 ad 00 00 00    	je     801043ef <sleep+0xdf>
    panic("sleep");

  if(lk == 0)
80104342:	85 db                	test   %ebx,%ebx
80104344:	0f 84 99 00 00 00    	je     801043e3 <sleep+0xd3>
    panic("sleep without lk");

  //TODO - addition to priority queue
  p->accumulator+=p->priority;  // add the priority to the acc
8010434a:	8b 87 88 00 00 00    	mov    0x88(%edi),%eax
80104350:	99                   	cltd   
80104351:	01 87 80 00 00 00    	add    %eax,0x80(%edi)
80104357:	11 97 84 00 00 00    	adc    %edx,0x84(%edi)
  rpholder.remove(p); //remove p from RUNNING queue
8010435d:	89 3c 24             	mov    %edi,(%esp)
80104360:	ff 15 cc c5 10 80    	call   *0x8010c5cc
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104366:	81 fb 80 4d 11 80    	cmp    $0x80114d80,%ebx
8010436c:	74 52                	je     801043c0 <sleep+0xb0>
    acquire(&ptable.lock);  //DOC: sleeplock1
8010436e:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104375:	e8 f6 15 00 00       	call   80105970 <acquire>
    release(lk);
8010437a:	89 1c 24             	mov    %ebx,(%esp)
8010437d:	e8 8e 16 00 00       	call   80105a10 <release>
  }
  // Go to sleep.
  p->chan = chan;
80104382:	89 77 20             	mov    %esi,0x20(%edi)
  p->state = SLEEPING;
80104385:	c7 47 0c 02 00 00 00 	movl   $0x2,0xc(%edi)

  sched();
8010438c:	e8 cf fc ff ff       	call   80104060 <sched>

  // Tidy up.
  p->chan = 0;
80104391:	c7 47 20 00 00 00 00 	movl   $0x0,0x20(%edi)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80104398:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
8010439f:	e8 6c 16 00 00       	call   80105a10 <release>
    acquire(lk);
  }
}
801043a4:	8b 75 f8             	mov    -0x8(%ebp),%esi
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
801043a7:	89 5d 08             	mov    %ebx,0x8(%ebp)
  }
}
801043aa:	8b 7d fc             	mov    -0x4(%ebp),%edi
801043ad:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801043b0:	89 ec                	mov    %ebp,%esp
801043b2:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
801043b3:	e9 b8 15 00 00       	jmp    80105970 <acquire>
801043b8:	90                   	nop
801043b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
801043c0:	89 77 20             	mov    %esi,0x20(%edi)
  p->state = SLEEPING;
801043c3:	c7 47 0c 02 00 00 00 	movl   $0x2,0xc(%edi)

  sched();
801043ca:	e8 91 fc ff ff       	call   80104060 <sched>

  // Tidy up.
  p->chan = 0;
801043cf:	c7 47 20 00 00 00 00 	movl   $0x0,0x20(%edi)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
801043d6:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801043d9:	8b 75 f8             	mov    -0x8(%ebp),%esi
801043dc:	8b 7d fc             	mov    -0x4(%ebp),%edi
801043df:	89 ec                	mov    %ebp,%esp
801043e1:	5d                   	pop    %ebp
801043e2:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
801043e3:	c7 04 24 7f 8c 10 80 	movl   $0x80108c7f,(%esp)
801043ea:	e8 51 bf ff ff       	call   80100340 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
801043ef:	c7 04 24 79 8c 10 80 	movl   $0x80108c79,(%esp)
801043f6:	e8 45 bf ff ff       	call   80100340 <panic>
801043fb:	90                   	nop
801043fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104400 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(int *status)
{
80104400:	55                   	push   %ebp
80104401:	89 e5                	mov    %esp,%ebp
80104403:	57                   	push   %edi
80104404:	56                   	push   %esi
80104405:	53                   	push   %ebx
80104406:	83 ec 1c             	sub    $0x1c,%esp
80104409:	8b 7d 08             	mov    0x8(%ebp),%edi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
8010440c:	e8 6f 14 00 00       	call   80105880 <pushcli>
  c = mycpu();
80104411:	e8 aa f4 ff ff       	call   801038c0 <mycpu>
  p = c->proc;
80104416:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
8010441c:	e8 9f 14 00 00       	call   801058c0 <popcli>
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();

  acquire(&ptable.lock);
80104421:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104428:	e8 43 15 00 00       	call   80105970 <acquire>
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
8010442d:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010442f:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
80104434:	eb 18                	jmp    8010444e <wait+0x4e>
80104436:	8d 76 00             	lea    0x0(%esi),%esi
80104439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104440:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80104446:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
8010444c:	74 22                	je     80104470 <wait+0x70>
      if(p->parent != curproc)
8010444e:	39 73 14             	cmp    %esi,0x14(%ebx)
80104451:	75 ed                	jne    80104440 <wait+0x40>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80104453:	8b 43 0c             	mov    0xc(%ebx),%eax
80104456:	83 f8 05             	cmp    $0x5,%eax
80104459:	74 3b                	je     80104496 <wait+0x96>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010445b:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
      if(p->parent != curproc)
        continue;
      havekids = 1;
80104461:	b8 01 00 00 00       	mov    $0x1,%eax

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104466:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
8010446c:	75 e0                	jne    8010444e <wait+0x4e>
8010446e:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80104470:	85 c0                	test   %eax,%eax
80104472:	0f 84 90 00 00 00    	je     80104508 <wait+0x108>
80104478:	8b 56 24             	mov    0x24(%esi),%edx
8010447b:	85 d2                	test   %edx,%edx
8010447d:	0f 85 85 00 00 00    	jne    80104508 <wait+0x108>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104483:	b8 80 4d 11 80       	mov    $0x80114d80,%eax
80104488:	89 44 24 04          	mov    %eax,0x4(%esp)
8010448c:	89 34 24             	mov    %esi,(%esp)
8010448f:	e8 7c fe ff ff       	call   80104310 <sleep>
  }
80104494:	eb 97                	jmp    8010442d <wait+0x2d>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
80104496:	8b 43 08             	mov    0x8(%ebx),%eax
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80104499:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
8010449c:	89 04 24             	mov    %eax,(%esp)
8010449f:	e8 ec de ff ff       	call   80102390 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
801044a4:	8b 43 04             	mov    0x4(%ebx),%eax
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
801044a7:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801044ae:	89 04 24             	mov    %eax,(%esp)
801044b1:	e8 3a 3e 00 00       	call   801082f0 <freevm>
        p->killed = 0;
        p->state = UNUSED;
        //TODO - maybe need to use argptr
        //if(status!=null)
        //argptr()
        *status = (p->exit_status);
801044b6:	8b 43 7c             	mov    0x7c(%ebx),%eax
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
801044b9:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801044c0:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801044c7:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801044cb:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801044d2:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        //TODO - maybe need to use argptr
        //if(status!=null)
        //argptr()
        *status = (p->exit_status);
801044d9:	89 07                	mov    %eax,(%edi)
        cprintf("**wait**  status= %d\t p.exit_status= %d\n",status,p->exit_status);
801044db:	8b 43 7c             	mov    0x7c(%ebx),%eax
801044de:	89 7c 24 04          	mov    %edi,0x4(%esp)
801044e2:	c7 04 24 3c 8d 10 80 	movl   $0x80108d3c,(%esp)
801044e9:	89 44 24 08          	mov    %eax,0x8(%esp)
801044ed:	e8 4e c1 ff ff       	call   80100640 <cprintf>

        release(&ptable.lock);
801044f2:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801044f9:	e8 12 15 00 00       	call   80105a10 <release>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
801044fe:	83 c4 1c             	add    $0x1c,%esp
        //argptr()
        *status = (p->exit_status);
        cprintf("**wait**  status= %d\t p.exit_status= %d\n",status,p->exit_status);

        release(&ptable.lock);
        return pid;
80104501:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104503:	5b                   	pop    %ebx
80104504:	5e                   	pop    %esi
80104505:	5f                   	pop    %edi
80104506:	5d                   	pop    %ebp
80104507:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
80104508:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
8010450f:	e8 fc 14 00 00       	call   80105a10 <release>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104514:	83 c4 1c             	add    $0x1c,%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
80104517:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
8010451c:	5b                   	pop    %ebx
8010451d:	5e                   	pop    %esi
8010451e:	5f                   	pop    %edi
8010451f:	5d                   	pop    %ebp
80104520:	c3                   	ret    
80104521:	eb 0d                	jmp    80104530 <wakeup>
80104523:	90                   	nop
80104524:	90                   	nop
80104525:	90                   	nop
80104526:	90                   	nop
80104527:	90                   	nop
80104528:	90                   	nop
80104529:	90                   	nop
8010452a:	90                   	nop
8010452b:	90                   	nop
8010452c:	90                   	nop
8010452d:	90                   	nop
8010452e:	90                   	nop
8010452f:	90                   	nop

80104530 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104530:	55                   	push   %ebp
80104531:	89 e5                	mov    %esp,%ebp
80104533:	53                   	push   %ebx
80104534:	83 ec 14             	sub    $0x14,%esp
80104537:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010453a:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104541:	e8 2a 14 00 00       	call   80105970 <acquire>
  wakeup1(chan);
80104546:	89 d8                	mov    %ebx,%eax
80104548:	e8 83 f4 ff ff       	call   801039d0 <wakeup1>
  release(&ptable.lock);
8010454d:	c7 45 08 80 4d 11 80 	movl   $0x80114d80,0x8(%ebp)
}
80104554:	83 c4 14             	add    $0x14,%esp
80104557:	5b                   	pop    %ebx
80104558:	5d                   	pop    %ebp
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80104559:	e9 b2 14 00 00       	jmp    80105a10 <release>
8010455e:	66 90                	xchg   %ax,%ax

80104560 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104560:	55                   	push   %ebp
80104561:	89 e5                	mov    %esp,%ebp
80104563:	53                   	push   %ebx
80104564:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;

  acquire(&ptable.lock);
80104567:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
8010456e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80104571:	e8 fa 13 00 00       	call   80105970 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104576:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
8010457b:	eb 0f                	jmp    8010458c <kill+0x2c>
8010457d:	8d 76 00             	lea    0x0(%esi),%esi
80104580:	05 a8 00 00 00       	add    $0xa8,%eax
80104585:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
8010458a:	74 2c                	je     801045b8 <kill+0x58>
    if(p->pid == pid){
8010458c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010458f:	75 ef                	jne    80104580 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING){
80104591:	8b 50 0c             	mov    0xc(%eax),%edx
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
80104594:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING){
8010459b:	83 fa 02             	cmp    $0x2,%edx
8010459e:	74 2f                	je     801045cf <kill+0x6f>
          //TODO- priority queue addition
          p->accumulator+=p->priority;
          //pq.put(p);
          pushToSpecificQueue(p);
      }
      release(&ptable.lock);
801045a0:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801045a7:	e8 64 14 00 00       	call   80105a10 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
801045ac:	83 c4 14             	add    $0x14,%esp
          p->accumulator+=p->priority;
          //pq.put(p);
          pushToSpecificQueue(p);
      }
      release(&ptable.lock);
      return 0;
801045af:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
801045b1:	5b                   	pop    %ebx
801045b2:	5d                   	pop    %ebp
801045b3:	c3                   	ret    
801045b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      }
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
801045b8:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801045bf:	e8 4c 14 00 00       	call   80105a10 <release>
  return -1;
}
801045c4:	83 c4 14             	add    $0x14,%esp
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
801045c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801045cc:	5b                   	pop    %ebx
801045cd:	5d                   	pop    %ebp
801045ce:	c3                   	ret    
      if(p->state == SLEEPING){
          p->state = RUNNABLE;
          //TODO- roundrobin addition
          //rrq.enqueue(p);
          //TODO- priority queue addition
          p->accumulator+=p->priority;
801045cf:	8b 88 88 00 00 00    	mov    0x88(%eax),%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING){
          p->state = RUNNABLE;
801045d5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
          //TODO- roundrobin addition
          //rrq.enqueue(p);
          //TODO- priority queue addition
          p->accumulator+=p->priority;
801045dc:	89 cb                	mov    %ecx,%ebx
801045de:	c1 fb 1f             	sar    $0x1f,%ebx
801045e1:	01 88 80 00 00 00    	add    %ecx,0x80(%eax)
801045e7:	11 98 84 00 00 00    	adc    %ebx,0x84(%eax)
          //pq.put(p);
          pushToSpecificQueue(p);
801045ed:	89 04 24             	mov    %eax,(%esp)
801045f0:	e8 9b f3 ff ff       	call   80103990 <pushToSpecificQueue>
801045f5:	eb a9                	jmp    801045a0 <kill+0x40>
801045f7:	89 f6                	mov    %esi,%esi
801045f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104600 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104600:	55                   	push   %ebp
80104601:	89 e5                	mov    %esp,%ebp
80104603:	57                   	push   %edi
80104604:	56                   	push   %esi
80104605:	53                   	push   %ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104606:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
8010460b:	83 ec 4c             	sub    $0x4c,%esp
8010460e:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104611:	eb 23                	jmp    80104636 <procdump+0x36>
80104613:	90                   	nop
80104614:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104618:	c7 04 24 61 8e 10 80 	movl   $0x80108e61,(%esp)
8010461f:	e8 1c c0 ff ff       	call   80100640 <cprintf>
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104624:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
8010462a:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
80104630:	0f 84 aa 00 00 00    	je     801046e0 <procdump+0xe0>
    if(p->state == UNUSED)
80104636:	8b 43 0c             	mov    0xc(%ebx),%eax
80104639:	85 c0                	test   %eax,%eax
8010463b:	74 e7                	je     80104624 <procdump+0x24>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010463d:	8b 43 0c             	mov    0xc(%ebx),%eax
      state = states[p->state];
    else
      state = "???";
80104640:	b8 90 8c 10 80       	mov    $0x80108c90,%eax
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104645:	8b 53 0c             	mov    0xc(%ebx),%edx
80104648:	83 fa 05             	cmp    $0x5,%edx
8010464b:	77 18                	ja     80104665 <procdump+0x65>
8010464d:	8b 53 0c             	mov    0xc(%ebx),%edx
80104650:	8b 14 95 38 8e 10 80 	mov    -0x7fef71c8(,%edx,4),%edx
80104657:	85 d2                	test   %edx,%edx
80104659:	74 0a                	je     80104665 <procdump+0x65>
      state = states[p->state];
8010465b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010465e:	8b 04 85 38 8e 10 80 	mov    -0x7fef71c8(,%eax,4),%eax
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
80104665:	89 44 24 08          	mov    %eax,0x8(%esp)
80104669:	8b 43 10             	mov    0x10(%ebx),%eax
8010466c:	8d 53 6c             	lea    0x6c(%ebx),%edx
8010466f:	89 54 24 0c          	mov    %edx,0xc(%esp)
80104673:	c7 04 24 94 8c 10 80 	movl   $0x80108c94,(%esp)
8010467a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010467e:	e8 bd bf ff ff       	call   80100640 <cprintf>
    if(p->state == SLEEPING){
80104683:	8b 43 0c             	mov    0xc(%ebx),%eax
80104686:	83 f8 02             	cmp    $0x2,%eax
80104689:	75 8d                	jne    80104618 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
8010468b:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010468e:	89 44 24 04          	mov    %eax,0x4(%esp)
80104692:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104695:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104698:	8b 40 0c             	mov    0xc(%eax),%eax
8010469b:	83 c0 08             	add    $0x8,%eax
8010469e:	89 04 24             	mov    %eax,(%esp)
801046a1:	e8 8a 11 00 00       	call   80105830 <getcallerpcs>
801046a6:	8d 76 00             	lea    0x0(%esi),%esi
801046a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      for(i=0; i<10 && pc[i] != 0; i++)
801046b0:	8b 17                	mov    (%edi),%edx
801046b2:	85 d2                	test   %edx,%edx
801046b4:	0f 84 5e ff ff ff    	je     80104618 <procdump+0x18>
        cprintf(" %p", pc[i]);
801046ba:	89 54 24 04          	mov    %edx,0x4(%esp)
801046be:	83 c7 04             	add    $0x4,%edi
801046c1:	c7 04 24 81 86 10 80 	movl   $0x80108681,(%esp)
801046c8:	e8 73 bf ff ff       	call   80100640 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
801046cd:	39 f7                	cmp    %esi,%edi
801046cf:	75 df                	jne    801046b0 <procdump+0xb0>
801046d1:	e9 42 ff ff ff       	jmp    80104618 <procdump+0x18>
801046d6:	8d 76 00             	lea    0x0(%esi),%esi
801046d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
801046e0:	83 c4 4c             	add    $0x4c,%esp
801046e3:	5b                   	pop    %ebx
801046e4:	5e                   	pop    %esi
801046e5:	5f                   	pop    %edi
801046e6:	5d                   	pop    %ebp
801046e7:	c3                   	ret    
801046e8:	90                   	nop
801046e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801046f0 <detach>:

//TODO

int
detach(int pid)
{
801046f0:	55                   	push   %ebp
801046f1:	89 e5                	mov    %esp,%ebp
801046f3:	56                   	push   %esi
801046f4:	53                   	push   %ebx
801046f5:	83 ec 10             	sub    $0x10,%esp
801046f8:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
801046fb:	e8 80 11 00 00       	call   80105880 <pushcli>
  c = mycpu();
80104700:	e8 bb f1 ff ff       	call   801038c0 <mycpu>
  p = c->proc;
80104705:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010470b:	e8 b0 11 00 00       	call   801058c0 <popcli>
    struct proc *p;
    struct proc *curproc = myproc();

    for(;;){
        // Scan through table looking for exited children with same pid as the argument.
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104710:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
80104715:	eb 15                	jmp    8010472c <detach+0x3c>
80104717:	89 f6                	mov    %esi,%esi
80104719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104720:	05 a8 00 00 00       	add    $0xa8,%eax
80104725:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
8010472a:	74 2c                	je     80104758 <detach+0x68>
            if (p->parent != curproc)
8010472c:	39 58 14             	cmp    %ebx,0x14(%eax)
8010472f:	75 ef                	jne    80104720 <detach+0x30>
                continue;
            //check if the pid is same as argument
            if (p->pid == pid) {
80104731:	39 70 10             	cmp    %esi,0x10(%eax)
80104734:	75 ea                	jne    80104720 <detach+0x30>
                //change the father of current proc
                p->parent = initproc;
80104736:	8b 15 c0 c5 10 80    	mov    0x8010c5c0,%edx
8010473c:	89 50 14             	mov    %edx,0x14(%eax)
                //release the ptable
                release(&ptable.lock);
8010473f:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104746:	e8 c5 12 00 00       	call   80105a10 <release>
        }
        //if got here - didn't find proc with pid as argument - exit with error
        release(&ptable.lock);
        return -1;
    }
}
8010474b:	83 c4 10             	add    $0x10,%esp
            if (p->pid == pid) {
                //change the father of current proc
                p->parent = initproc;
                //release the ptable
                release(&ptable.lock);
                return 0;
8010474e:	31 c0                	xor    %eax,%eax
        }
        //if got here - didn't find proc with pid as argument - exit with error
        release(&ptable.lock);
        return -1;
    }
}
80104750:	5b                   	pop    %ebx
80104751:	5e                   	pop    %esi
80104752:	5d                   	pop    %ebp
80104753:	c3                   	ret    
80104754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                release(&ptable.lock);
                return 0;
            }
        }
        //if got here - didn't find proc with pid as argument - exit with error
        release(&ptable.lock);
80104758:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
8010475f:	e8 ac 12 00 00       	call   80105a10 <release>
        return -1;
    }
}
80104764:	83 c4 10             	add    $0x10,%esp
                return 0;
            }
        }
        //if got here - didn't find proc with pid as argument - exit with error
        release(&ptable.lock);
        return -1;
80104767:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
}
8010476c:	5b                   	pop    %ebx
8010476d:	5e                   	pop    %esi
8010476e:	5d                   	pop    %ebp
8010476f:	c3                   	ret    

80104770 <priority>:


void
priority(int prio){
80104770:	55                   	push   %ebp
80104771:	89 e5                	mov    %esp,%ebp
80104773:	53                   	push   %ebx
80104774:	83 ec 04             	sub    $0x4,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80104777:	e8 04 11 00 00       	call   80105880 <pushcli>
  c = mycpu();
8010477c:	e8 3f f1 ff ff       	call   801038c0 <mycpu>
  p = c->proc;
80104781:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104787:	e8 34 11 00 00       	call   801058c0 <popcli>


void
priority(int prio){
    struct proc *curproc = myproc();
    if(currpolicy==2){
8010478c:	a1 04 c0 10 80       	mov    0x8010c004,%eax
80104791:	83 f8 02             	cmp    $0x2,%eax
80104794:	74 2a                	je     801047c0 <priority+0x50>
        if(prio>0 &&prio<11)
            curproc->priority=prio;
    }
    if(currpolicy==3){
80104796:	a1 04 c0 10 80       	mov    0x8010c004,%eax
8010479b:	83 f8 03             	cmp    $0x3,%eax
8010479e:	74 08                	je     801047a8 <priority+0x38>
        if(prio>-1 &&prio<11)
            curproc->priority=prio;
    }
    //curproc->priority=prio;
}
801047a0:	58                   	pop    %eax
801047a1:	5b                   	pop    %ebx
801047a2:	5d                   	pop    %ebp
801047a3:	c3                   	ret    
801047a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(currpolicy==2){
        if(prio>0 &&prio<11)
            curproc->priority=prio;
    }
    if(currpolicy==3){
        if(prio>-1 &&prio<11)
801047a8:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
801047ac:	77 f2                	ja     801047a0 <priority+0x30>
            curproc->priority=prio;
801047ae:	8b 45 08             	mov    0x8(%ebp),%eax
801047b1:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)
    }
    //curproc->priority=prio;
}
801047b7:	58                   	pop    %eax
801047b8:	5b                   	pop    %ebx
801047b9:	5d                   	pop    %ebp
801047ba:	c3                   	ret    
801047bb:	90                   	nop
801047bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void
priority(int prio){
    struct proc *curproc = myproc();
    if(currpolicy==2){
        if(prio>0 &&prio<11)
801047c0:	8b 45 08             	mov    0x8(%ebp),%eax
801047c3:	48                   	dec    %eax
801047c4:	83 f8 09             	cmp    $0x9,%eax
801047c7:	77 cd                	ja     80104796 <priority+0x26>
            curproc->priority=prio;
801047c9:	8b 45 08             	mov    0x8(%ebp),%eax
801047cc:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)
801047d2:	eb c2                	jmp    80104796 <priority+0x26>
801047d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801047da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801047e0 <priorityUnExtended>:
    //curproc->priority=prio;
}


void
priorityUnExtended(){
801047e0:	55                   	push   %ebp
    struct proc *p;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801047e1:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
    //curproc->priority=prio;
}


void
priorityUnExtended(){
801047e6:	89 e5                	mov    %esp,%ebp
801047e8:	90                   	nop
801047e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct proc *p;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
        if (p->priority == 0)
801047f0:	8b 88 88 00 00 00    	mov    0x88(%eax),%ecx
801047f6:	85 c9                	test   %ecx,%ecx
801047f8:	75 0b                	jne    80104805 <priorityUnExtended+0x25>
            p->priority = 1;
801047fa:	ba 01 00 00 00       	mov    $0x1,%edx
801047ff:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)


void
priorityUnExtended(){
    struct proc *p;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104805:	05 a8 00 00 00       	add    $0xa8,%eax
8010480a:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
8010480f:	75 df                	jne    801047f0 <priorityUnExtended+0x10>
        if (p->priority == 0)
            p->priority = 1;
    }
}
80104811:	5d                   	pop    %ebp
80104812:	c3                   	ret    
80104813:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104820 <switchToRoundRobin>:

void
switchToRoundRobin(void){
80104820:	55                   	push   %ebp
80104821:	89 e5                	mov    %esp,%ebp
80104823:	83 ec 18             	sub    $0x18,%esp
    struct proc *p;
    if(!pq.switchToRoundRobinPolicy())
80104826:	ff 15 f4 c5 10 80    	call   *0x8010c5f4
8010482c:	85 c0                	test   %eax,%eax
8010482e:	74 2b                	je     8010485b <switchToRoundRobin+0x3b>
80104830:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
80104835:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        panic("error in switch from policy 2/3 to policy 1\n");
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
        p->accumulator=0;
80104840:	31 d2                	xor    %edx,%edx
80104842:	31 c9                	xor    %ecx,%ecx
80104844:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
void
switchToRoundRobin(void){
    struct proc *p;
    if(!pq.switchToRoundRobinPolicy())
        panic("error in switch from policy 2/3 to policy 1\n");
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
8010484a:	05 a8 00 00 00       	add    $0xa8,%eax
        p->accumulator=0;
8010484f:	89 48 dc             	mov    %ecx,-0x24(%eax)
void
switchToRoundRobin(void){
    struct proc *p;
    if(!pq.switchToRoundRobinPolicy())
        panic("error in switch from policy 2/3 to policy 1\n");
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104852:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
80104857:	75 e7                	jne    80104840 <switchToRoundRobin+0x20>
        p->accumulator=0;
    }
}
80104859:	c9                   	leave  
8010485a:	c3                   	ret    

void
switchToRoundRobin(void){
    struct proc *p;
    if(!pq.switchToRoundRobinPolicy())
        panic("error in switch from policy 2/3 to policy 1\n");
8010485b:	c7 04 24 68 8d 10 80 	movl   $0x80108d68,(%esp)
80104862:	e8 d9 ba ff ff       	call   80100340 <panic>
80104867:	89 f6                	mov    %esi,%esi
80104869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104870 <policy>:
        p->accumulator=0;
    }
}

void
policy(int num){
80104870:	55                   	push   %ebp
80104871:	89 e5                	mov    %esp,%ebp
80104873:	53                   	push   %ebx
80104874:	83 ec 14             	sub    $0x14,%esp
80104877:	8b 5d 08             	mov    0x8(%ebp),%ebx
    //check legal input
    //TODO- need to check if there is a need to change to default or to panic
    if(num>3 || num<1)
8010487a:	8d 43 ff             	lea    -0x1(%ebx),%eax
8010487d:	83 f8 02             	cmp    $0x2,%eax
80104880:	76 0e                	jbe    80104890 <policy+0x20>
        default:
            panic("illegal policy number\n");
            break;
    }
    release(&ptable.lock);
}
80104882:	83 c4 14             	add    $0x14,%esp
80104885:	5b                   	pop    %ebx
80104886:	5d                   	pop    %ebp
80104887:	c3                   	ret    
80104888:	90                   	nop
80104889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80104890:	fb                   	sti    
    if(num>3 || num<1)
        return; //currpolicy get the default policy
    // Enable interrupts on this processor.
    sti();
    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80104891:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104898:	e8 d3 10 00 00       	call   80105970 <acquire>
    switch (currpolicy){
8010489d:	a1 04 c0 10 80       	mov    0x8010c004,%eax
801048a2:	83 f8 02             	cmp    $0x2,%eax
801048a5:	74 39                	je     801048e0 <policy+0x70>
801048a7:	83 f8 03             	cmp    $0x3,%eax
801048aa:	74 14                	je     801048c0 <policy+0x50>
801048ac:	48                   	dec    %eax
801048ad:	74 41                	je     801048f0 <policy+0x80>
            if(num==2){
                priorityUnExtended();
            }
            break;
        default:
            panic("illegal policy number\n");
801048af:	c7 04 24 9d 8c 10 80 	movl   $0x80108c9d,(%esp)
801048b6:	e8 85 ba ff ff       	call   80100340 <panic>
801048bb:	90                   	nop
801048bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                switchToRoundRobin();
            }
            break;

        case 3:
            if(num==1){
801048c0:	83 fb 01             	cmp    $0x1,%ebx
801048c3:	74 1e                	je     801048e3 <policy+0x73>
                switchToRoundRobin();
            }
            if(num==2){
801048c5:	83 fb 02             	cmp    $0x2,%ebx
801048c8:	74 6e                	je     80104938 <policy+0xc8>
            break;
        default:
            panic("illegal policy number\n");
            break;
    }
    release(&ptable.lock);
801048ca:	c7 45 08 80 4d 11 80 	movl   $0x80114d80,0x8(%ebp)
}
801048d1:	83 c4 14             	add    $0x14,%esp
801048d4:	5b                   	pop    %ebx
801048d5:	5d                   	pop    %ebp
            break;
        default:
            panic("illegal policy number\n");
            break;
    }
    release(&ptable.lock);
801048d6:	e9 35 11 00 00       	jmp    80105a10 <release>
801048db:	90                   	nop
801048dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                    priorityUnExtended();
            }
            break;

        case 2:
            if(num==1){
801048e0:	4b                   	dec    %ebx
801048e1:	75 e7                	jne    801048ca <policy+0x5a>
                switchToRoundRobin();
801048e3:	e8 38 ff ff ff       	call   80104820 <switchToRoundRobin>
801048e8:	eb e0                	jmp    801048ca <policy+0x5a>
801048ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sti();
    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    switch (currpolicy){
        case 1:
            if(num==2 || num==3){
801048f0:	8d 43 fe             	lea    -0x2(%ebx),%eax
801048f3:	83 f8 01             	cmp    $0x1,%eax
801048f6:	77 d2                	ja     801048ca <policy+0x5a>
                if(!rrq.switchToPriorityQueuePolicy())
801048f8:	ff 15 e0 c5 10 80    	call   *0x8010c5e0
801048fe:	85 c0                	test   %eax,%eax
80104900:	74 64                	je     80104966 <policy+0xf6>
                    panic("error in switch from rouncrobin to priority queue\n");
                //if num=2 ->check that there are no priority=0
                if(num==2)
80104902:	83 fb 02             	cmp    $0x2,%ebx
80104905:	75 c3                	jne    801048ca <policy+0x5a>
80104907:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
8010490c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void
priorityUnExtended(){
    struct proc *p;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
        if (p->priority == 0)
80104910:	8b 90 88 00 00 00    	mov    0x88(%eax),%edx
80104916:	85 d2                	test   %edx,%edx
80104918:	75 0b                	jne    80104925 <policy+0xb5>
            p->priority = 1;
8010491a:	bb 01 00 00 00       	mov    $0x1,%ebx
8010491f:	89 98 88 00 00 00    	mov    %ebx,0x88(%eax)


void
priorityUnExtended(){
    struct proc *p;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104925:	05 a8 00 00 00       	add    $0xa8,%eax
8010492a:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
8010492f:	75 df                	jne    80104910 <policy+0xa0>
80104931:	eb 97                	jmp    801048ca <policy+0x5a>
80104933:	90                   	nop
80104934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104938:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
8010493d:	8d 76 00             	lea    0x0(%esi),%esi
        if (p->priority == 0)
80104940:	8b 88 88 00 00 00    	mov    0x88(%eax),%ecx
80104946:	85 c9                	test   %ecx,%ecx
80104948:	75 0b                	jne    80104955 <policy+0xe5>
            p->priority = 1;
8010494a:	ba 01 00 00 00       	mov    $0x1,%edx
8010494f:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)


void
priorityUnExtended(){
    struct proc *p;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104955:	05 a8 00 00 00       	add    $0xa8,%eax
8010495a:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
8010495f:	75 df                	jne    80104940 <policy+0xd0>
80104961:	e9 64 ff ff ff       	jmp    801048ca <policy+0x5a>
    acquire(&ptable.lock);
    switch (currpolicy){
        case 1:
            if(num==2 || num==3){
                if(!rrq.switchToPriorityQueuePolicy())
                    panic("error in switch from rouncrobin to priority queue\n");
80104966:	c7 04 24 98 8d 10 80 	movl   $0x80108d98,(%esp)
8010496d:	e8 ce b9 ff ff       	call   80100340 <panic>
80104972:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104980 <wait_stat>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait_stat(int* status, struct perf* performance)
{
80104980:	55                   	push   %ebp
80104981:	89 e5                	mov    %esp,%ebp
80104983:	57                   	push   %edi
80104984:	56                   	push   %esi
80104985:	53                   	push   %ebx
80104986:	83 ec 2c             	sub    $0x2c,%esp
80104989:	8b 7d 08             	mov    0x8(%ebp),%edi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
8010498c:	e8 ef 0e 00 00       	call   80105880 <pushcli>
  c = mycpu();
80104991:	e8 2a ef ff ff       	call   801038c0 <mycpu>
  p = c->proc;
80104996:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
8010499c:	e8 1f 0f 00 00       	call   801058c0 <popcli>
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();

  acquire(&ptable.lock);
801049a1:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801049a8:	e8 c3 0f 00 00       	call   80105970 <acquire>
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
801049ad:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049af:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
801049b4:	eb 18                	jmp    801049ce <wait_stat+0x4e>
801049b6:	8d 76 00             	lea    0x0(%esi),%esi
801049b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801049c0:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
801049c6:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
801049cc:	74 22                	je     801049f0 <wait_stat+0x70>
      if(p->parent != curproc)
801049ce:	39 73 14             	cmp    %esi,0x14(%ebx)
801049d1:	75 ed                	jne    801049c0 <wait_stat+0x40>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
801049d3:	8b 43 0c             	mov    0xc(%ebx),%eax
801049d6:	83 f8 05             	cmp    $0x5,%eax
801049d9:	74 3b                	je     80104a16 <wait_stat+0x96>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049db:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
      if(p->parent != curproc)
        continue;
      havekids = 1;
801049e1:	b8 01 00 00 00       	mov    $0x1,%eax

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049e6:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
801049ec:	75 e0                	jne    801049ce <wait_stat+0x4e>
801049ee:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
801049f0:	85 c0                	test   %eax,%eax
801049f2:	0f 84 c6 00 00 00    	je     80104abe <wait_stat+0x13e>
801049f8:	8b 56 24             	mov    0x24(%esi),%edx
801049fb:	85 d2                	test   %edx,%edx
801049fd:	0f 85 bb 00 00 00    	jne    80104abe <wait_stat+0x13e>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104a03:	b8 80 4d 11 80       	mov    $0x80114d80,%eax
80104a08:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a0c:	89 34 24             	mov    %esi,(%esp)
80104a0f:	e8 fc f8 ff ff       	call   80104310 <sleep>
  }
80104a14:	eb 97                	jmp    801049ad <wait_stat+0x2d>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
80104a16:	8b 43 08             	mov    0x8(%ebx),%eax
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80104a19:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104a1c:	89 04 24             	mov    %eax,(%esp)
80104a1f:	e8 6c d9 ff ff       	call   80102390 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
80104a24:	8b 43 04             	mov    0x4(%ebx),%eax
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80104a27:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104a2e:	89 04 24             	mov    %eax,(%esp)
80104a31:	e8 ba 38 00 00       	call   801082f0 <freevm>
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        //TODO - maybe need to use argptr
        if(status!=null)
80104a36:	85 ff                	test   %edi,%edi
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
80104a38:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104a3f:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104a46:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104a4a:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104a51:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        //TODO - maybe need to use argptr
        if(status!=null)
80104a58:	74 03                	je     80104a5d <wait_stat+0xdd>
          p->exit_status= (int)status ;
80104a5a:	89 7b 7c             	mov    %edi,0x7c(%ebx)
        //ent time= creation time+run time+sleep time+ready time
        p->perf.ttime=p->perf.ctime+p->perf.rutime+p->perf.retime+p->perf.stime;
80104a5d:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80104a63:	8b 8b 9c 00 00 00    	mov    0x9c(%ebx),%ecx
80104a69:	8b 93 98 00 00 00    	mov    0x98(%ebx),%edx
80104a6f:	8b bb 94 00 00 00    	mov    0x94(%ebx),%edi
        cprintf("process pid:  %d \n creation time:  %d\nRUNNING time:  %d\n"
80104a75:	89 44 24 08          	mov    %eax,0x8(%esp)
80104a79:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
        p->state = UNUSED;
        //TODO - maybe need to use argptr
        if(status!=null)
          p->exit_status= (int)status ;
        //ent time= creation time+run time+sleep time+ready time
        p->perf.ttime=p->perf.ctime+p->perf.rutime+p->perf.retime+p->perf.stime;
80104a7d:	89 54 24 10          	mov    %edx,0x10(%esp)
80104a81:	8d 14 08             	lea    (%eax,%ecx,1),%edx
80104a84:	03 54 24 10          	add    0x10(%esp),%edx
        cprintf("process pid:  %d \n creation time:  %d\nRUNNING time:  %d\n"
80104a88:	89 7c 24 14          	mov    %edi,0x14(%esp)
80104a8c:	89 74 24 04          	mov    %esi,0x4(%esp)
        p->state = UNUSED;
        //TODO - maybe need to use argptr
        if(status!=null)
          p->exit_status= (int)status ;
        //ent time= creation time+run time+sleep time+ready time
        p->perf.ttime=p->perf.ctime+p->perf.rutime+p->perf.retime+p->perf.stime;
80104a90:	01 fa                	add    %edi,%edx
        cprintf("process pid:  %d \n creation time:  %d\nRUNNING time:  %d\n"
80104a92:	89 54 24 18          	mov    %edx,0x18(%esp)
80104a96:	c7 04 24 cc 8d 10 80 	movl   $0x80108dcc,(%esp)
        p->state = UNUSED;
        //TODO - maybe need to use argptr
        if(status!=null)
          p->exit_status= (int)status ;
        //ent time= creation time+run time+sleep time+ready time
        p->perf.ttime=p->perf.ctime+p->perf.rutime+p->perf.retime+p->perf.stime;
80104a9d:	89 93 90 00 00 00    	mov    %edx,0x90(%ebx)
        cprintf("process pid:  %d \n creation time:  %d\nRUNNING time:  %d\n"
80104aa3:	e8 98 bb ff ff       	call   80100640 <cprintf>
                "READY time:  %d\nSLEEPING time:  %d\nend time:  %d\n",
                pid,p->perf.ctime,p->perf.rutime,p->perf.retime,p->perf.stime,p->perf.ttime);
        release(&ptable.lock);
80104aa8:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104aaf:	e8 5c 0f 00 00       	call   80105a10 <release>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104ab4:	83 c4 2c             	add    $0x2c,%esp
        p->perf.ttime=p->perf.ctime+p->perf.rutime+p->perf.retime+p->perf.stime;
        cprintf("process pid:  %d \n creation time:  %d\nRUNNING time:  %d\n"
                "READY time:  %d\nSLEEPING time:  %d\nend time:  %d\n",
                pid,p->perf.ctime,p->perf.rutime,p->perf.retime,p->perf.stime,p->perf.ttime);
        release(&ptable.lock);
        return pid;
80104ab7:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104ab9:	5b                   	pop    %ebx
80104aba:	5e                   	pop    %esi
80104abb:	5f                   	pop    %edi
80104abc:	5d                   	pop    %ebp
80104abd:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
80104abe:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104ac5:	e8 46 0f 00 00       	call   80105a10 <release>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104aca:	83 c4 2c             	add    $0x2c,%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
80104acd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104ad2:	5b                   	pop    %ebx
80104ad3:	5e                   	pop    %esi
80104ad4:	5f                   	pop    %edi
80104ad5:	5d                   	pop    %ebp
80104ad6:	c3                   	ret    
80104ad7:	66 90                	xchg   %ax,%ax
80104ad9:	66 90                	xchg   %ax,%ax
80104adb:	66 90                	xchg   %ax,%ax
80104add:	66 90                	xchg   %ax,%ax
80104adf:	90                   	nop

80104ae0 <isEmptyPriorityQueue>:
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
80104ae0:	a1 14 c6 10 80       	mov    0x8010c614,%eax
	spaceLeft -= size;
	return ans;
}

//for pq
static boolean isEmptyPriorityQueue() {
80104ae5:	55                   	push   %ebp
80104ae6:	89 e5                	mov    %esp,%ebp
	return priorityQ->isEmpty();
}
80104ae8:	5d                   	pop    %ebp
	return ans;
}

//for pq
static boolean isEmptyPriorityQueue() {
	return priorityQ->isEmpty();
80104ae9:	8b 00                	mov    (%eax),%eax
80104aeb:	85 c0                	test   %eax,%eax
80104aed:	0f 94 c0             	sete   %al
80104af0:	0f b6 c0             	movzbl %al,%eax
}
80104af3:	c3                   	ret    
80104af4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104afa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104b00 <getMinAccumulatorPriorityQueue>:
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
80104b00:	a1 14 c6 10 80       	mov    0x8010c614,%eax
80104b05:	8b 10                	mov    (%eax),%edx
	
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
	if(isEmpty())
80104b07:	85 d2                	test   %edx,%edx
80104b09:	75 07                	jne    80104b12 <getMinAccumulatorPriorityQueue+0x12>
80104b0b:	eb 2b                	jmp    80104b38 <getMinAccumulatorPriorityQueue+0x38>
80104b0d:	8d 76 00             	lea    0x0(%esi),%esi
	}
}

MapNode* MapNode::getMinNode() { //no recursion.
	MapNode* minNode = this;	
	while(minNode->left)
80104b10:	89 c2                	mov    %eax,%edx
80104b12:	8b 42 18             	mov    0x18(%edx),%eax
80104b15:	85 c0                	test   %eax,%eax
80104b17:	75 f7                	jne    80104b10 <getMinAccumulatorPriorityQueue+0x10>

static boolean putPriorityQueue(Proc* p) {
	return priorityQ->put(p);
}

static boolean getMinAccumulatorPriorityQueue(long long* pkey) {
80104b19:	55                   	push   %ebp
80104b1a:	89 e5                	mov    %esp,%ebp
80104b1c:	53                   	push   %ebx

	return minNode;
}

void MapNode::getMinKey(long long *pkey) {
	*pkey = getMinNode()->key;
80104b1d:	8b 45 08             	mov    0x8(%ebp),%eax
80104b20:	8b 5a 04             	mov    0x4(%edx),%ebx
80104b23:	8b 0a                	mov    (%edx),%ecx
80104b25:	89 58 04             	mov    %ebx,0x4(%eax)
80104b28:	89 08                	mov    %ecx,(%eax)
80104b2a:	b8 01 00 00 00       	mov    $0x1,%eax
	return priorityQ->put(p);
}

static boolean getMinAccumulatorPriorityQueue(long long* pkey) {
	return priorityQ->getMinKey(pkey);
}
80104b2f:	5b                   	pop    %ebx
80104b30:	5d                   	pop    %ebp
80104b31:	c3                   	ret    
80104b32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
	if(isEmpty())
80104b38:	31 c0                	xor    %eax,%eax
80104b3a:	c3                   	ret    
80104b3b:	90                   	nop
80104b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104b40 <isEmptyRoundRobinQueue>:

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
80104b40:	a1 10 c6 10 80       	mov    0x8010c610,%eax
static boolean extractProcPriorityQueue(Proc *p) {
	return priorityQ->extractProc(p);
}

//for rrq
static boolean isEmptyRoundRobinQueue() {
80104b45:	55                   	push   %ebp
80104b46:	89 e5                	mov    %esp,%ebp
	return roundRobinQ->isEmpty();
}
80104b48:	5d                   	pop    %ebp
	return priorityQ->extractProc(p);
}

//for rrq
static boolean isEmptyRoundRobinQueue() {
	return roundRobinQ->isEmpty();
80104b49:	8b 00                	mov    (%eax),%eax
80104b4b:	85 c0                	test   %eax,%eax
80104b4d:	0f 94 c0             	sete   %al
80104b50:	0f b6 c0             	movzbl %al,%eax
}
80104b53:	c3                   	ret    
80104b54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104b60 <dequeueRoundRobinQueue>:
static boolean enqueueRoundRobinQueue(Proc *p) {
	return roundRobinQ->enqueue(p);
}

static Proc* dequeueRoundRobinQueue() {
	return roundRobinQ->dequeue();
80104b60:	8b 0d 10 c6 10 80    	mov    0x8010c610,%ecx

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
80104b66:	8b 11                	mov    (%ecx),%edx
	append(link);
	return true;
}

Proc* LinkedList::dequeue() {
	if(isEmpty())
80104b68:	85 d2                	test   %edx,%edx
80104b6a:	74 4c                	je     80104bb8 <dequeueRoundRobinQueue+0x58>

static boolean enqueueRoundRobinQueue(Proc *p) {
	return roundRobinQ->enqueue(p);
}

static Proc* dequeueRoundRobinQueue() {
80104b6c:	55                   	push   %ebp
80104b6d:	89 e5                	mov    %esp,%ebp
80104b6f:	83 ec 08             	sub    $0x8,%esp
80104b72:	89 75 fc             	mov    %esi,-0x4(%ebp)
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80104b75:	8b 35 08 c6 10 80    	mov    0x8010c608,%esi

static boolean enqueueRoundRobinQueue(Proc *p) {
	return roundRobinQ->enqueue(p);
}

static Proc* dequeueRoundRobinQueue() {
80104b7b:	89 5d f8             	mov    %ebx,-0x8(%ebp)
Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;

	Proc *p = first->p;
	Link *next = first->next;
80104b7e:	8b 5a 04             	mov    0x4(%edx),%ebx

Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;

	Proc *p = first->p;
80104b81:	8b 02                	mov    (%edx),%eax
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80104b83:	89 72 04             	mov    %esi,0x4(%edx)
	freeLinks = link;
80104b86:	89 15 08 c6 10 80    	mov    %edx,0x8010c608
	
	deallocLink(first);
	
	first = next;

	if(isEmpty())
80104b8c:	85 db                	test   %ebx,%ebx
	Proc *p = first->p;
	Link *next = first->next;
	
	deallocLink(first);
	
	first = next;
80104b8e:	89 19                	mov    %ebx,(%ecx)

	if(isEmpty())
80104b90:	74 0e                	je     80104ba0 <dequeueRoundRobinQueue+0x40>
	return roundRobinQ->enqueue(p);
}

static Proc* dequeueRoundRobinQueue() {
	return roundRobinQ->dequeue();
}
80104b92:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104b95:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104b98:	89 ec                	mov    %ebp,%esp
80104b9a:	5d                   	pop    %ebp
80104b9b:	c3                   	ret    
80104b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	deallocLink(first);
	
	first = next;

	if(isEmpty())
		last = null;
80104ba0:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
	return roundRobinQ->enqueue(p);
}

static Proc* dequeueRoundRobinQueue() {
	return roundRobinQ->dequeue();
}
80104ba7:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104baa:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104bad:	89 ec                	mov    %ebp,%esp
80104baf:	5d                   	pop    %ebp
80104bb0:	c3                   	ret    
80104bb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	return true;
}

Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;
80104bb8:	31 c0                	xor    %eax,%eax
80104bba:	c3                   	ret    
80104bbb:	90                   	nop
80104bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104bc0 <isEmptyRunningProcessHolder>:

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
80104bc0:	a1 0c c6 10 80       	mov    0x8010c60c,%eax
static boolean switchToPriorityQueuePolicyRoundRobinQueue() {
	return roundRobinQ->transfer();
}

//for rpholder
static boolean isEmptyRunningProcessHolder() {
80104bc5:	55                   	push   %ebp
80104bc6:	89 e5                	mov    %esp,%ebp
	return runningProcHolder->isEmpty();
}
80104bc8:	5d                   	pop    %ebp
	return roundRobinQ->transfer();
}

//for rpholder
static boolean isEmptyRunningProcessHolder() {
	return runningProcHolder->isEmpty();
80104bc9:	8b 00                	mov    (%eax),%eax
80104bcb:	85 c0                	test   %eax,%eax
80104bcd:	0f 94 c0             	sete   %al
80104bd0:	0f b6 c0             	movzbl %al,%eax
}
80104bd3:	c3                   	ret    
80104bd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104bda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104be0 <_ZL8mymallocj>:
static MapNode                    *freeNodes;

static char                       *data;
static uint                       spaceLeft;
                
static char* mymalloc(uint size) {
80104be0:	55                   	push   %ebp
80104be1:	89 e5                	mov    %esp,%ebp
80104be3:	53                   	push   %ebx
80104be4:	89 c3                	mov    %eax,%ebx
80104be6:	83 ec 14             	sub    $0x14,%esp
	if(spaceLeft < size) {
80104be9:	8b 15 fc c5 10 80    	mov    0x8010c5fc,%edx
80104bef:	39 c2                	cmp    %eax,%edx
80104bf1:	73 26                	jae    80104c19 <_ZL8mymallocj+0x39>
		data = kalloc();
80104bf3:	e8 68 d9 ff ff       	call   80102560 <kalloc>
		memset(data, 0, PGSIZE);
80104bf8:	ba 00 10 00 00       	mov    $0x1000,%edx
80104bfd:	31 c9                	xor    %ecx,%ecx
80104bff:	89 54 24 08          	mov    %edx,0x8(%esp)
80104c03:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80104c07:	89 04 24             	mov    %eax,(%esp)
static char                       *data;
static uint                       spaceLeft;
                
static char* mymalloc(uint size) {
	if(spaceLeft < size) {
		data = kalloc();
80104c0a:	a3 00 c6 10 80       	mov    %eax,0x8010c600
		memset(data, 0, PGSIZE);
80104c0f:	e8 4c 0e 00 00       	call   80105a60 <memset>
80104c14:	ba 00 10 00 00       	mov    $0x1000,%edx
		spaceLeft = PGSIZE;
	}

	char* ans = data;
80104c19:	a1 00 c6 10 80       	mov    0x8010c600,%eax
	data += size;
	spaceLeft -= size;
80104c1e:	29 da                	sub    %ebx,%edx
80104c20:	89 15 fc c5 10 80    	mov    %edx,0x8010c5fc
		memset(data, 0, PGSIZE);
		spaceLeft = PGSIZE;
	}

	char* ans = data;
	data += size;
80104c26:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
80104c29:	89 0d 00 c6 10 80    	mov    %ecx,0x8010c600
	spaceLeft -= size;
	return ans;
}
80104c2f:	83 c4 14             	add    $0x14,%esp
80104c32:	5b                   	pop    %ebx
80104c33:	5d                   	pop    %ebp
80104c34:	c3                   	ret    
80104c35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c40 <initSchedDS>:

static boolean getMinAccumulatorRunningProcessHolder(long long *pkey) {
	return runningProcHolder->getMinKey(pkey);
}

void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104c40:	55                   	push   %ebp
	data               = null;
80104c41:	31 c0                	xor    %eax,%eax

static boolean getMinAccumulatorRunningProcessHolder(long long *pkey) {
	return runningProcHolder->getMinKey(pkey);
}

void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104c43:	89 e5                	mov    %esp,%ebp
80104c45:	53                   	push   %ebx
	*roundRobinQ       = LinkedList();

	runningProcHolder  = (LinkedList*)mymalloc(sizeof(LinkedList));
	*runningProcHolder = LinkedList();

	freeLinks = null;
80104c46:	bb 80 00 00 00       	mov    $0x80,%ebx

static boolean getMinAccumulatorRunningProcessHolder(long long *pkey) {
	return runningProcHolder->getMinKey(pkey);
}

void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104c4b:	83 ec 04             	sub    $0x4,%esp
	data               = null;
80104c4e:	a3 00 c6 10 80       	mov    %eax,0x8010c600
	spaceLeft          = 0u;
80104c53:	31 c0                	xor    %eax,%eax
80104c55:	a3 fc c5 10 80       	mov    %eax,0x8010c5fc

	priorityQ          = (Map*)mymalloc(sizeof(Map));
80104c5a:	b8 04 00 00 00       	mov    $0x4,%eax
80104c5f:	e8 7c ff ff ff       	call   80104be0 <_ZL8mymallocj>
80104c64:	a3 14 c6 10 80       	mov    %eax,0x8010c614
	*priorityQ         = Map();
80104c69:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	roundRobinQ        = (LinkedList*)mymalloc(sizeof(LinkedList));
80104c6f:	b8 08 00 00 00       	mov    $0x8,%eax
80104c74:	e8 67 ff ff ff       	call   80104be0 <_ZL8mymallocj>
80104c79:	a3 10 c6 10 80       	mov    %eax,0x8010c610
	*roundRobinQ       = LinkedList();
80104c7e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104c84:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)

	runningProcHolder  = (LinkedList*)mymalloc(sizeof(LinkedList));
80104c8b:	b8 08 00 00 00       	mov    $0x8,%eax
80104c90:	e8 4b ff ff ff       	call   80104be0 <_ZL8mymallocj>
80104c95:	a3 0c c6 10 80       	mov    %eax,0x8010c60c
	*runningProcHolder = LinkedList();
80104c9a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104ca0:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)

	freeLinks = null;
80104ca7:	31 c0                	xor    %eax,%eax
80104ca9:	a3 08 c6 10 80       	mov    %eax,0x8010c608
80104cae:	66 90                	xchg   %ax,%ax
	for(int i = 0; i < NPROCLIST; ++i) {
		Link *link = (Link*)mymalloc(sizeof(Link));
80104cb0:	b8 08 00 00 00       	mov    $0x8,%eax
80104cb5:	e8 26 ff ff ff       	call   80104be0 <_ZL8mymallocj>
		*link = Link();
		link->next = freeLinks;
80104cba:	8b 15 08 c6 10 80    	mov    0x8010c608,%edx

	runningProcHolder  = (LinkedList*)mymalloc(sizeof(LinkedList));
	*runningProcHolder = LinkedList();

	freeLinks = null;
	for(int i = 0; i < NPROCLIST; ++i) {
80104cc0:	4b                   	dec    %ebx
		Link *link = (Link*)mymalloc(sizeof(Link));
		*link = Link();
80104cc1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		link->next = freeLinks;
80104cc7:	89 50 04             	mov    %edx,0x4(%eax)
		freeLinks = link;
80104cca:	a3 08 c6 10 80       	mov    %eax,0x8010c608

	runningProcHolder  = (LinkedList*)mymalloc(sizeof(LinkedList));
	*runningProcHolder = LinkedList();

	freeLinks = null;
	for(int i = 0; i < NPROCLIST; ++i) {
80104ccf:	75 df                	jne    80104cb0 <initSchedDS+0x70>
		*link = Link();
		link->next = freeLinks;
		freeLinks = link;
	}

	freeNodes = null;
80104cd1:	31 c0                	xor    %eax,%eax
80104cd3:	bb 80 00 00 00       	mov    $0x80,%ebx
80104cd8:	a3 04 c6 10 80       	mov    %eax,0x8010c604
80104cdd:	8d 76 00             	lea    0x0(%esi),%esi
	for(int i = 0; i < NPROCMAP; ++i) {
		MapNode *node = (MapNode*)mymalloc(sizeof(MapNode));
80104ce0:	b8 20 00 00 00       	mov    $0x20,%eax
80104ce5:	e8 f6 fe ff ff       	call   80104be0 <_ZL8mymallocj>
		*node = MapNode();
		node->next = freeNodes;
80104cea:	8b 15 04 c6 10 80    	mov    0x8010c604,%edx
		link->next = freeLinks;
		freeLinks = link;
	}

	freeNodes = null;
	for(int i = 0; i < NPROCMAP; ++i) {
80104cf0:	4b                   	dec    %ebx
		MapNode *node = (MapNode*)mymalloc(sizeof(MapNode));
		*node = MapNode();
80104cf1:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80104cf8:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
80104cff:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
80104d06:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
80104d0d:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
		node->next = freeNodes;
80104d14:	89 50 10             	mov    %edx,0x10(%eax)
		freeNodes = node;
80104d17:	a3 04 c6 10 80       	mov    %eax,0x8010c604
		link->next = freeLinks;
		freeLinks = link;
	}

	freeNodes = null;
	for(int i = 0; i < NPROCMAP; ++i) {
80104d1c:	75 c2                	jne    80104ce0 <initSchedDS+0xa0>
		node->next = freeNodes;
		freeNodes = node;
	}

	//init pq
	pq.isEmpty                      = isEmptyPriorityQueue;
80104d1e:	b8 e0 4a 10 80       	mov    $0x80104ae0,%eax
	pq.put                          = putPriorityQueue;
80104d23:	ba 80 53 10 80       	mov    $0x80105380,%edx
		node->next = freeNodes;
		freeNodes = node;
	}

	//init pq
	pq.isEmpty                      = isEmptyPriorityQueue;
80104d28:	a3 e4 c5 10 80       	mov    %eax,0x8010c5e4
	pq.put                          = putPriorityQueue;
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
	pq.extractMin                   = extractMinPriorityQueue;
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
80104d2d:	b8 10 55 10 80       	mov    $0x80105510,%eax
	}

	//init pq
	pq.isEmpty                      = isEmptyPriorityQueue;
	pq.put                          = putPriorityQueue;
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
80104d32:	b9 00 4b 10 80       	mov    $0x80104b00,%ecx
	pq.extractMin                   = extractMinPriorityQueue;
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
80104d37:	a3 f4 c5 10 80       	mov    %eax,0x8010c5f4
	pq.extractProc                  = extractProcPriorityQueue;
80104d3c:	b8 e0 55 10 80       	mov    $0x801055e0,%eax

	//init pq
	pq.isEmpty                      = isEmptyPriorityQueue;
	pq.put                          = putPriorityQueue;
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
	pq.extractMin                   = extractMinPriorityQueue;
80104d41:	bb a0 54 10 80       	mov    $0x801054a0,%ebx
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
	pq.extractProc                  = extractProcPriorityQueue;
80104d46:	a3 f8 c5 10 80       	mov    %eax,0x8010c5f8

	//init rrq
	rrq.isEmpty                     = isEmptyRoundRobinQueue;
80104d4b:	b8 40 4b 10 80       	mov    $0x80104b40,%eax
80104d50:	a3 d4 c5 10 80       	mov    %eax,0x8010c5d4
	rrq.enqueue                     = enqueueRoundRobinQueue;
80104d55:	b8 b0 4e 10 80       	mov    $0x80104eb0,%eax
80104d5a:	a3 d8 c5 10 80       	mov    %eax,0x8010c5d8
	rrq.dequeue                     = dequeueRoundRobinQueue;
80104d5f:	b8 60 4b 10 80       	mov    $0x80104b60,%eax
80104d64:	a3 dc c5 10 80       	mov    %eax,0x8010c5dc
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;
80104d69:	b8 e0 50 10 80       	mov    $0x801050e0,%eax
		freeNodes = node;
	}

	//init pq
	pq.isEmpty                      = isEmptyPriorityQueue;
	pq.put                          = putPriorityQueue;
80104d6e:	89 15 e8 c5 10 80    	mov    %edx,0x8010c5e8
	rrq.enqueue                     = enqueueRoundRobinQueue;
	rrq.dequeue                     = dequeueRoundRobinQueue;
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;

	//init rpholder
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
80104d74:	ba c0 4b 10 80       	mov    $0x80104bc0,%edx
	}

	//init pq
	pq.isEmpty                      = isEmptyPriorityQueue;
	pq.put                          = putPriorityQueue;
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
80104d79:	89 0d ec c5 10 80    	mov    %ecx,0x8010c5ec
	rrq.dequeue                     = dequeueRoundRobinQueue;
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;

	//init rpholder
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
	rpholder.add                    = addRunningProcessHolder;
80104d7f:	b9 90 4e 10 80       	mov    $0x80104e90,%ecx

	//init pq
	pq.isEmpty                      = isEmptyPriorityQueue;
	pq.put                          = putPriorityQueue;
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
	pq.extractMin                   = extractMinPriorityQueue;
80104d84:	89 1d f0 c5 10 80    	mov    %ebx,0x8010c5f0
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;

	//init rpholder
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
	rpholder.add                    = addRunningProcessHolder;
	rpholder.remove                 = removeRunningProcessHolder;
80104d8a:	bb 40 50 10 80       	mov    $0x80105040,%ebx

	//init rrq
	rrq.isEmpty                     = isEmptyRoundRobinQueue;
	rrq.enqueue                     = enqueueRoundRobinQueue;
	rrq.dequeue                     = dequeueRoundRobinQueue;
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;
80104d8f:	a3 e0 c5 10 80       	mov    %eax,0x8010c5e0

	//init rpholder
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
	rpholder.add                    = addRunningProcessHolder;
	rpholder.remove                 = removeRunningProcessHolder;
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
80104d94:	b8 80 51 10 80       	mov    $0x80105180,%eax
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;

	//init rpholder
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
	rpholder.add                    = addRunningProcessHolder;
	rpholder.remove                 = removeRunningProcessHolder;
80104d99:	89 1d cc c5 10 80    	mov    %ebx,0x8010c5cc
	rrq.enqueue                     = enqueueRoundRobinQueue;
	rrq.dequeue                     = dequeueRoundRobinQueue;
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;

	//init rpholder
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
80104d9f:	89 15 c4 c5 10 80    	mov    %edx,0x8010c5c4
	rpholder.add                    = addRunningProcessHolder;
80104da5:	89 0d c8 c5 10 80    	mov    %ecx,0x8010c5c8
	rpholder.remove                 = removeRunningProcessHolder;
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
80104dab:	a3 d0 c5 10 80       	mov    %eax,0x8010c5d0
}
80104db0:	58                   	pop    %eax
80104db1:	5b                   	pop    %ebx
80104db2:	5d                   	pop    %ebp
80104db3:	c3                   	ret    
80104db4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104dba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104dc0 <_ZN4Link7getLastEv>:
	}

	return ans;
}

Link* Link::getLast() {
80104dc0:	55                   	push   %ebp
80104dc1:	89 e5                	mov    %esp,%ebp
	Link* ans = this;
80104dc3:	8b 45 08             	mov    0x8(%ebp),%eax
80104dc6:	eb 0a                	jmp    80104dd2 <_ZN4Link7getLastEv+0x12>
80104dc8:	90                   	nop
80104dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dd0:	89 d0                	mov    %edx,%eax
	
	while(ans->next)
80104dd2:	8b 50 04             	mov    0x4(%eax),%edx
80104dd5:	85 d2                	test   %edx,%edx
80104dd7:	75 f7                	jne    80104dd0 <_ZN4Link7getLastEv+0x10>
		ans = ans->next;

	return ans;
}
80104dd9:	5d                   	pop    %ebp
80104dda:	c3                   	ret    
80104ddb:	90                   	nop
80104ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104de0 <_ZN10LinkedList7isEmptyEv>:

bool LinkedList::isEmpty() {
80104de0:	55                   	push   %ebp
80104de1:	89 e5                	mov    %esp,%ebp
	return !first;
80104de3:	8b 45 08             	mov    0x8(%ebp),%eax
}
80104de6:	5d                   	pop    %ebp

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
80104de7:	8b 00                	mov    (%eax),%eax
80104de9:	85 c0                	test   %eax,%eax
80104deb:	0f 94 c0             	sete   %al
}
80104dee:	c3                   	ret    
80104def:	90                   	nop

80104df0 <_ZN10LinkedList6appendEP4Link>:

void LinkedList::append(Link *link) {
80104df0:	55                   	push   %ebp
80104df1:	89 e5                	mov    %esp,%ebp
80104df3:	8b 55 0c             	mov    0xc(%ebp),%edx
80104df6:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!link)
80104df9:	85 d2                	test   %edx,%edx
80104dfb:	74 1f                	je     80104e1c <_ZN10LinkedList6appendEP4Link+0x2c>
		return;

	if(isEmpty()) first = link;
80104dfd:	8b 01                	mov    (%ecx),%eax
80104dff:	85 c0                	test   %eax,%eax
80104e01:	74 1d                	je     80104e20 <_ZN10LinkedList6appendEP4Link+0x30>
	else last->next = link;
80104e03:	8b 41 04             	mov    0x4(%ecx),%eax
80104e06:	89 50 04             	mov    %edx,0x4(%eax)
80104e09:	eb 07                	jmp    80104e12 <_ZN10LinkedList6appendEP4Link+0x22>
80104e0b:	90                   	nop
80104e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

Link* Link::getLast() {
	Link* ans = this;
	
	while(ans->next)
80104e10:	89 c2                	mov    %eax,%edx
80104e12:	8b 42 04             	mov    0x4(%edx),%eax
80104e15:	85 c0                	test   %eax,%eax
80104e17:	75 f7                	jne    80104e10 <_ZN10LinkedList6appendEP4Link+0x20>
		return;

	if(isEmpty()) first = link;
	else last->next = link;

	last = link->getLast();
80104e19:	89 51 04             	mov    %edx,0x4(%ecx)
}
80104e1c:	5d                   	pop    %ebp
80104e1d:	c3                   	ret    
80104e1e:	66 90                	xchg   %ax,%ax

void LinkedList::append(Link *link) {
	if(!link)
		return;

	if(isEmpty()) first = link;
80104e20:	89 11                	mov    %edx,(%ecx)
80104e22:	eb ee                	jmp    80104e12 <_ZN10LinkedList6appendEP4Link+0x22>
80104e24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104e30 <_ZN10LinkedList7enqueueEP4proc>:
	rpholder.remove                 = removeRunningProcessHolder;
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
}

static Link* allocLink(Proc *p) {
	if(!freeLinks)
80104e30:	8b 15 08 c6 10 80    	mov    0x8010c608,%edx
	else last->next = link;

	last = link->getLast();
}

bool LinkedList::enqueue(Proc *p) {
80104e36:	55                   	push   %ebp
80104e37:	89 e5                	mov    %esp,%ebp
80104e39:	8b 4d 08             	mov    0x8(%ebp),%ecx
	rpholder.remove                 = removeRunningProcessHolder;
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
}

static Link* allocLink(Proc *p) {
	if(!freeLinks)
80104e3c:	85 d2                	test   %edx,%edx
80104e3e:	74 40                	je     80104e80 <_ZN10LinkedList7enqueueEP4proc+0x50>
		return null;

	Link *ans = freeLinks;
	freeLinks = freeLinks->next;
80104e40:	8b 42 04             	mov    0x4(%edx),%eax
	ans->next = null;
80104e43:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
static Link* allocLink(Proc *p) {
	if(!freeLinks)
		return null;

	Link *ans = freeLinks;
	freeLinks = freeLinks->next;
80104e4a:	a3 08 c6 10 80       	mov    %eax,0x8010c608
	ans->next = null;
	ans->p = p;
80104e4f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e52:	89 02                	mov    %eax,(%edx)

void LinkedList::append(Link *link) {
	if(!link)
		return;

	if(isEmpty()) first = link;
80104e54:	8b 01                	mov    (%ecx),%eax
80104e56:	85 c0                	test   %eax,%eax
80104e58:	74 2e                	je     80104e88 <_ZN10LinkedList7enqueueEP4proc+0x58>
	else last->next = link;
80104e5a:	8b 41 04             	mov    0x4(%ecx),%eax
80104e5d:	89 50 04             	mov    %edx,0x4(%eax)
80104e60:	eb 08                	jmp    80104e6a <_ZN10LinkedList7enqueueEP4proc+0x3a>
80104e62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}

Link* Link::getLast() {
	Link* ans = this;
	
	while(ans->next)
80104e68:	89 c2                	mov    %eax,%edx
80104e6a:	8b 42 04             	mov    0x4(%edx),%eax
80104e6d:	85 c0                	test   %eax,%eax
80104e6f:	75 f7                	jne    80104e68 <_ZN10LinkedList7enqueueEP4proc+0x38>
		return;

	if(isEmpty()) first = link;
	else last->next = link;

	last = link->getLast();
80104e71:	89 51 04             	mov    %edx,0x4(%ecx)
	
	if(!link)
		return false;

	append(link);
	return true;
80104e74:	b0 01                	mov    $0x1,%al
}
80104e76:	5d                   	pop    %ebp
80104e77:	c3                   	ret    
80104e78:	90                   	nop
80104e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

bool LinkedList::enqueue(Proc *p) {
	Link *link = allocLink(p);
	
	if(!link)
		return false;
80104e80:	31 c0                	xor    %eax,%eax

	append(link);
	return true;
}
80104e82:	5d                   	pop    %ebp
80104e83:	c3                   	ret    
80104e84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void LinkedList::append(Link *link) {
	if(!link)
		return;

	if(isEmpty()) first = link;
80104e88:	89 11                	mov    %edx,(%ecx)
80104e8a:	eb de                	jmp    80104e6a <_ZN10LinkedList7enqueueEP4proc+0x3a>
80104e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104e90 <addRunningProcessHolder>:
//for rpholder
static boolean isEmptyRunningProcessHolder() {
	return runningProcHolder->isEmpty();
}

static boolean addRunningProcessHolder(Proc* p) {
80104e90:	55                   	push   %ebp
80104e91:	89 e5                	mov    %esp,%ebp
80104e93:	83 ec 08             	sub    $0x8,%esp
	return runningProcHolder->enqueue(p);
80104e96:	8b 45 08             	mov    0x8(%ebp),%eax
80104e99:	89 44 24 04          	mov    %eax,0x4(%esp)
80104e9d:	a1 0c c6 10 80       	mov    0x8010c60c,%eax
80104ea2:	89 04 24             	mov    %eax,(%esp)
80104ea5:	e8 86 ff ff ff       	call   80104e30 <_ZN10LinkedList7enqueueEP4proc>
}
80104eaa:	c9                   	leave  
static boolean isEmptyRunningProcessHolder() {
	return runningProcHolder->isEmpty();
}

static boolean addRunningProcessHolder(Proc* p) {
	return runningProcHolder->enqueue(p);
80104eab:	0f b6 c0             	movzbl %al,%eax
}
80104eae:	c3                   	ret    
80104eaf:	90                   	nop

80104eb0 <enqueueRoundRobinQueue>:
//for rrq
static boolean isEmptyRoundRobinQueue() {
	return roundRobinQ->isEmpty();
}

static boolean enqueueRoundRobinQueue(Proc *p) {
80104eb0:	55                   	push   %ebp
80104eb1:	89 e5                	mov    %esp,%ebp
80104eb3:	83 ec 08             	sub    $0x8,%esp
	return roundRobinQ->enqueue(p);
80104eb6:	8b 45 08             	mov    0x8(%ebp),%eax
80104eb9:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ebd:	a1 10 c6 10 80       	mov    0x8010c610,%eax
80104ec2:	89 04 24             	mov    %eax,(%esp)
80104ec5:	e8 66 ff ff ff       	call   80104e30 <_ZN10LinkedList7enqueueEP4proc>
}
80104eca:	c9                   	leave  
static boolean isEmptyRoundRobinQueue() {
	return roundRobinQ->isEmpty();
}

static boolean enqueueRoundRobinQueue(Proc *p) {
	return roundRobinQ->enqueue(p);
80104ecb:	0f b6 c0             	movzbl %al,%eax
}
80104ece:	c3                   	ret    
80104ecf:	90                   	nop

80104ed0 <_ZL9allocNodeP4procx>:
	ans->next = null;
	ans->key = key;
	return ans;
}

static MapNode* allocNode(Proc *p, long long key) {
80104ed0:	55                   	push   %ebp
80104ed1:	89 e5                	mov    %esp,%ebp
80104ed3:	56                   	push   %esi
80104ed4:	53                   	push   %ebx
80104ed5:	83 ec 08             	sub    $0x8,%esp
	if(!freeNodes)
80104ed8:	8b 1d 04 c6 10 80    	mov    0x8010c604,%ebx
80104ede:	85 db                	test   %ebx,%ebx
80104ee0:	74 28                	je     80104f0a <_ZL9allocNodeP4procx+0x3a>
static MapNode* allocNode(long long key) {
	if(!freeNodes)
		return null;

	MapNode *ans = freeNodes;
	freeNodes = freeNodes->next;
80104ee2:	8b 73 10             	mov    0x10(%ebx),%esi
	ans->next = null;
	ans->key = key;
80104ee5:	89 13                	mov    %edx,(%ebx)
	if(!freeNodes)
		return null;

	MapNode *ans = freeNodes;
	freeNodes = freeNodes->next;
	ans->next = null;
80104ee7:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
	ans->key = key;
80104eee:	89 4b 04             	mov    %ecx,0x4(%ebx)

	MapNode *ans = allocNode(key);
	if(!ans)
		return null;

	if(!ans->listOfProcs.enqueue(p)) {
80104ef1:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ef5:	8d 43 08             	lea    0x8(%ebx),%eax
80104ef8:	89 04 24             	mov    %eax,(%esp)
static MapNode* allocNode(long long key) {
	if(!freeNodes)
		return null;

	MapNode *ans = freeNodes;
	freeNodes = freeNodes->next;
80104efb:	89 35 04 c6 10 80    	mov    %esi,0x8010c604

	MapNode *ans = allocNode(key);
	if(!ans)
		return null;

	if(!ans->listOfProcs.enqueue(p)) {
80104f01:	e8 2a ff ff ff       	call   80104e30 <_ZN10LinkedList7enqueueEP4proc>
80104f06:	84 c0                	test   %al,%al
80104f08:	74 0e                	je     80104f18 <_ZL9allocNodeP4procx+0x48>
		deallocNode(ans);
		return null;
	}

	return ans;
}
80104f0a:	83 c4 08             	add    $0x8,%esp
80104f0d:	89 d8                	mov    %ebx,%eax
80104f0f:	5b                   	pop    %ebx
80104f10:	5e                   	pop    %esi
80104f11:	5d                   	pop    %ebp
80104f12:	c3                   	ret    
80104f13:	90                   	nop
80104f14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	link->next = freeLinks;
	freeLinks = link;
}

static void deallocNode(MapNode *node) {
	node->parent = node->left = node->right = null;
80104f18:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
80104f1f:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
80104f26:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
	node->next = freeNodes;
80104f2d:	89 73 10             	mov    %esi,0x10(%ebx)
	freeNodes = node;
80104f30:	89 1d 04 c6 10 80    	mov    %ebx,0x8010c604
	if(!ans)
		return null;

	if(!ans->listOfProcs.enqueue(p)) {
		deallocNode(ans);
		return null;
80104f36:	31 db                	xor    %ebx,%ebx
80104f38:	eb d0                	jmp    80104f0a <_ZL9allocNodeP4procx+0x3a>
80104f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104f40 <_ZN10LinkedList7dequeueEv>:

	append(link);
	return true;
}

Proc* LinkedList::dequeue() {
80104f40:	55                   	push   %ebp
80104f41:	89 e5                	mov    %esp,%ebp
80104f43:	83 ec 08             	sub    $0x8,%esp
80104f46:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104f49:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80104f4c:	89 75 fc             	mov    %esi,-0x4(%ebp)

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
80104f4f:	8b 11                	mov    (%ecx),%edx
	append(link);
	return true;
}

Proc* LinkedList::dequeue() {
	if(isEmpty())
80104f51:	85 d2                	test   %edx,%edx
80104f53:	74 43                	je     80104f98 <_ZN10LinkedList7dequeueEv+0x58>
		return null;

	Proc *p = first->p;
	Link *next = first->next;
80104f55:	8b 5a 04             	mov    0x4(%edx),%ebx
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80104f58:	8b 35 08 c6 10 80    	mov    0x8010c608,%esi

Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;

	Proc *p = first->p;
80104f5e:	8b 02                	mov    (%edx),%eax
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
	freeLinks = link;
80104f60:	89 15 08 c6 10 80    	mov    %edx,0x8010c608
	
	deallocLink(first);
	
	first = next;

	if(isEmpty())
80104f66:	85 db                	test   %ebx,%ebx
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80104f68:	89 72 04             	mov    %esi,0x4(%edx)
	Proc *p = first->p;
	Link *next = first->next;
	
	deallocLink(first);
	
	first = next;
80104f6b:	89 19                	mov    %ebx,(%ecx)

	if(isEmpty())
80104f6d:	74 11                	je     80104f80 <_ZN10LinkedList7dequeueEv+0x40>
		last = null;
	
	return p;
}
80104f6f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104f72:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104f75:	89 ec                	mov    %ebp,%esp
80104f77:	5d                   	pop    %ebp
80104f78:	c3                   	ret    
80104f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	deallocLink(first);
	
	first = next;

	if(isEmpty())
		last = null;
80104f80:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
	
	return p;
}
80104f87:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104f8a:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104f8d:	89 ec                	mov    %ebp,%esp
80104f8f:	5d                   	pop    %ebp
80104f90:	c3                   	ret    
80104f91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	return true;
}

Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;
80104f98:	31 c0                	xor    %eax,%eax
80104f9a:	eb d3                	jmp    80104f6f <_ZN10LinkedList7dequeueEv+0x2f>
80104f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104fa0 <_ZN10LinkedList6removeEP4proc>:
		last = null;
	
	return p;
}

bool LinkedList::remove(Proc *p) {
80104fa0:	55                   	push   %ebp
80104fa1:	89 e5                	mov    %esp,%ebp
80104fa3:	56                   	push   %esi
80104fa4:	8b 75 08             	mov    0x8(%ebp),%esi
80104fa7:	53                   	push   %ebx
80104fa8:	8b 4d 0c             	mov    0xc(%ebp),%ecx

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
80104fab:	8b 1e                	mov    (%esi),%ebx
	
	return p;
}

bool LinkedList::remove(Proc *p) {
	if(isEmpty())
80104fad:	85 db                	test   %ebx,%ebx
80104faf:	74 57                	je     80105008 <_ZN10LinkedList6removeEP4proc+0x68>
		return false;
	
	if(first->p == p) {
80104fb1:	39 0b                	cmp    %ecx,(%ebx)
Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;

	Proc *p = first->p;
	Link *next = first->next;
80104fb3:	8b 53 04             	mov    0x4(%ebx),%edx

bool LinkedList::remove(Proc *p) {
	if(isEmpty())
		return false;
	
	if(first->p == p) {
80104fb6:	74 58                	je     80105010 <_ZN10LinkedList6removeEP4proc+0x70>
		return true;
	}

	Link *prev = first;
	Link *cur = first->next;
	while(cur) {
80104fb8:	85 d2                	test   %edx,%edx
80104fba:	74 4c                	je     80105008 <_ZN10LinkedList6removeEP4proc+0x68>
		if(cur->p == p) {
80104fbc:	3b 0a                	cmp    (%edx),%ecx
80104fbe:	66 90                	xchg   %ax,%ax
80104fc0:	75 0c                	jne    80104fce <_ZN10LinkedList6removeEP4proc+0x2e>
80104fc2:	eb 15                	jmp    80104fd9 <_ZN10LinkedList6removeEP4proc+0x39>
80104fc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fc8:	3b 08                	cmp    (%eax),%ecx
80104fca:	74 14                	je     80104fe0 <_ZN10LinkedList6removeEP4proc+0x40>
80104fcc:	89 c2                	mov    %eax,%edx

			return true;
		}

		prev = cur;
		cur = cur->next;
80104fce:	8b 42 04             	mov    0x4(%edx),%eax
		return true;
	}

	Link *prev = first;
	Link *cur = first->next;
	while(cur) {
80104fd1:	85 c0                	test   %eax,%eax
80104fd3:	75 f3                	jne    80104fc8 <_ZN10LinkedList6removeEP4proc+0x28>
		cur = cur->next;
	}

	//didn't find the process
	return false;
}
80104fd5:	5b                   	pop    %ebx
80104fd6:	5e                   	pop    %esi
80104fd7:	5d                   	pop    %ebp
80104fd8:	c3                   	ret    
	}

	Link *prev = first;
	Link *cur = first->next;
	while(cur) {
		if(cur->p == p) {
80104fd9:	89 d0                	mov    %edx,%eax
80104fdb:	89 da                	mov    %ebx,%edx
80104fdd:	8d 76 00             	lea    0x0(%esi),%esi
			prev->next = cur->next;
80104fe0:	8b 48 04             	mov    0x4(%eax),%ecx
80104fe3:	89 4a 04             	mov    %ecx,0x4(%edx)
			
			if(!(cur->next)) //removes the last link
80104fe6:	8b 48 04             	mov    0x4(%eax),%ecx
80104fe9:	85 c9                	test   %ecx,%ecx
80104feb:	74 43                	je     80105030 <_ZN10LinkedList6removeEP4proc+0x90>
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80104fed:	8b 15 08 c6 10 80    	mov    0x8010c608,%edx
	freeLinks = link;
80104ff3:	a3 08 c6 10 80       	mov    %eax,0x8010c608
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80104ff8:	89 50 04             	mov    %edx,0x4(%eax)
			if(!(cur->next)) //removes the last link
				last = prev;

			deallocLink(cur);

			return true;
80104ffb:	b0 01                	mov    $0x1,%al
		cur = cur->next;
	}

	//didn't find the process
	return false;
}
80104ffd:	5b                   	pop    %ebx
80104ffe:	5e                   	pop    %esi
80104fff:	5d                   	pop    %ebp
80105000:	c3                   	ret    
80105001:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105008:	5b                   	pop    %ebx
	return p;
}

bool LinkedList::remove(Proc *p) {
	if(isEmpty())
		return false;
80105009:	31 c0                	xor    %eax,%eax
		cur = cur->next;
	}

	//didn't find the process
	return false;
}
8010500b:	5e                   	pop    %esi
8010500c:	5d                   	pop    %ebp
8010500d:	c3                   	ret    
8010500e:	66 90                	xchg   %ax,%ax
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80105010:	a1 08 c6 10 80       	mov    0x8010c608,%eax
	
	deallocLink(first);
	
	first = next;

	if(isEmpty())
80105015:	85 d2                	test   %edx,%edx
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
	freeLinks = link;
80105017:	89 1d 08 c6 10 80    	mov    %ebx,0x8010c608
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
8010501d:	89 43 04             	mov    %eax,0x4(%ebx)
	if(isEmpty())
		return false;
	
	if(first->p == p) {
		dequeue();
		return true;
80105020:	b0 01                	mov    $0x1,%al
	Proc *p = first->p;
	Link *next = first->next;
	
	deallocLink(first);
	
	first = next;
80105022:	89 16                	mov    %edx,(%esi)

	if(isEmpty())
80105024:	75 af                	jne    80104fd5 <_ZN10LinkedList6removeEP4proc+0x35>
		last = null;
80105026:	c7 46 04 00 00 00 00 	movl   $0x0,0x4(%esi)
8010502d:	eb a6                	jmp    80104fd5 <_ZN10LinkedList6removeEP4proc+0x35>
8010502f:	90                   	nop
	while(cur) {
		if(cur->p == p) {
			prev->next = cur->next;
			
			if(!(cur->next)) //removes the last link
				last = prev;
80105030:	89 56 04             	mov    %edx,0x4(%esi)
80105033:	eb b8                	jmp    80104fed <_ZN10LinkedList6removeEP4proc+0x4d>
80105035:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105040 <removeRunningProcessHolder>:

static boolean addRunningProcessHolder(Proc* p) {
	return runningProcHolder->enqueue(p);
}

static boolean removeRunningProcessHolder(Proc* p) {
80105040:	55                   	push   %ebp
80105041:	89 e5                	mov    %esp,%ebp
80105043:	83 ec 08             	sub    $0x8,%esp
	return runningProcHolder->remove(p);
80105046:	8b 45 08             	mov    0x8(%ebp),%eax
80105049:	89 44 24 04          	mov    %eax,0x4(%esp)
8010504d:	a1 0c c6 10 80       	mov    0x8010c60c,%eax
80105052:	89 04 24             	mov    %eax,(%esp)
80105055:	e8 46 ff ff ff       	call   80104fa0 <_ZN10LinkedList6removeEP4proc>
}
8010505a:	c9                   	leave  
static boolean addRunningProcessHolder(Proc* p) {
	return runningProcHolder->enqueue(p);
}

static boolean removeRunningProcessHolder(Proc* p) {
	return runningProcHolder->remove(p);
8010505b:	0f b6 c0             	movzbl %al,%eax
}
8010505e:	c3                   	ret    
8010505f:	90                   	nop

80105060 <_ZN10LinkedList8transferEv>:
	//didn't find the process
	return false;
}

bool LinkedList::transfer() {
	if(!priorityQ->isEmpty())
80105060:	8b 15 14 c6 10 80    	mov    0x8010c614,%edx
		return false;
80105066:	31 c0                	xor    %eax,%eax

	//didn't find the process
	return false;
}

bool LinkedList::transfer() {
80105068:	55                   	push   %ebp
80105069:	89 e5                	mov    %esp,%ebp
8010506b:	53                   	push   %ebx
8010506c:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!priorityQ->isEmpty())
8010506f:	8b 1a                	mov    (%edx),%ebx
80105071:	85 db                	test   %ebx,%ebx
80105073:	74 0b                	je     80105080 <_ZN10LinkedList8transferEv+0x20>
		node->listOfProcs.last = last;
		first = last = null;
		priorityQ->root = node;
	}
	return true;
}
80105075:	5b                   	pop    %ebx
80105076:	5d                   	pop    %ebp
80105077:	c3                   	ret    
80105078:	90                   	nop
80105079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

bool LinkedList::transfer() {
	if(!priorityQ->isEmpty())
		return false;
	
	if(!isEmpty()) {
80105080:	8b 19                	mov    (%ecx),%ebx
80105082:	85 db                	test   %ebx,%ebx
80105084:	74 4a                	je     801050d0 <_ZN10LinkedList8transferEv+0x70>
	node->next = freeNodes;
	freeNodes = node;
}

static MapNode* allocNode(long long key) {
	if(!freeNodes)
80105086:	8b 1d 04 c6 10 80    	mov    0x8010c604,%ebx
8010508c:	85 db                	test   %ebx,%ebx
8010508e:	74 e5                	je     80105075 <_ZN10LinkedList8transferEv+0x15>
		return null;

	MapNode *ans = freeNodes;
	freeNodes = freeNodes->next;
80105090:	8b 43 10             	mov    0x10(%ebx),%eax
	ans->next = null;
	ans->key = key;
80105093:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
	if(!freeNodes)
		return null;

	MapNode *ans = freeNodes;
	freeNodes = freeNodes->next;
	ans->next = null;
80105099:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
	ans->key = key;
801050a0:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
static MapNode* allocNode(long long key) {
	if(!freeNodes)
		return null;

	MapNode *ans = freeNodes;
	freeNodes = freeNodes->next;
801050a7:	a3 04 c6 10 80       	mov    %eax,0x8010c604
	if(!isEmpty()) {
		MapNode *node = allocNode(0);
		if(!node)
			return false;
		
		node->listOfProcs.first = first;
801050ac:	8b 01                	mov    (%ecx),%eax
801050ae:	89 43 08             	mov    %eax,0x8(%ebx)
		node->listOfProcs.last = last;
801050b1:	8b 41 04             	mov    0x4(%ecx),%eax
801050b4:	89 43 0c             	mov    %eax,0xc(%ebx)
		first = last = null;
		priorityQ->root = node;
	}
	return true;
801050b7:	b0 01                	mov    $0x1,%al
		if(!node)
			return false;
		
		node->listOfProcs.first = first;
		node->listOfProcs.last = last;
		first = last = null;
801050b9:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
801050c0:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
		priorityQ->root = node;
801050c6:	89 1a                	mov    %ebx,(%edx)
	}
	return true;
}
801050c8:	5b                   	pop    %ebx
801050c9:	5d                   	pop    %ebp
801050ca:	c3                   	ret    
801050cb:	90                   	nop
801050cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		node->listOfProcs.first = first;
		node->listOfProcs.last = last;
		first = last = null;
		priorityQ->root = node;
	}
	return true;
801050d0:	b0 01                	mov    $0x1,%al
801050d2:	eb a1                	jmp    80105075 <_ZN10LinkedList8transferEv+0x15>
801050d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801050da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801050e0 <switchToPriorityQueuePolicyRoundRobinQueue>:

static Proc* dequeueRoundRobinQueue() {
	return roundRobinQ->dequeue();
}

static boolean switchToPriorityQueuePolicyRoundRobinQueue() {
801050e0:	55                   	push   %ebp
801050e1:	89 e5                	mov    %esp,%ebp
801050e3:	83 ec 04             	sub    $0x4,%esp
	return roundRobinQ->transfer();
801050e6:	a1 10 c6 10 80       	mov    0x8010c610,%eax
801050eb:	89 04 24             	mov    %eax,(%esp)
801050ee:	e8 6d ff ff ff       	call   80105060 <_ZN10LinkedList8transferEv>
}
801050f3:	c9                   	leave  
static Proc* dequeueRoundRobinQueue() {
	return roundRobinQ->dequeue();
}

static boolean switchToPriorityQueuePolicyRoundRobinQueue() {
	return roundRobinQ->transfer();
801050f4:	0f b6 c0             	movzbl %al,%eax
}
801050f7:	c3                   	ret    
801050f8:	90                   	nop
801050f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105100 <_ZN10LinkedList9getMinKeyEPx>:
		priorityQ->root = node;
	}
	return true;
}

bool LinkedList::getMinKey(long long *pkey) {
80105100:	55                   	push   %ebp
80105101:	89 e5                	mov    %esp,%ebp
80105103:	57                   	push   %edi
80105104:	56                   	push   %esi
80105105:	53                   	push   %ebx
80105106:	83 ec 1c             	sub    $0x1c,%esp
80105109:	8b 7d 08             	mov    0x8(%ebp),%edi

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
8010510c:	8b 07                	mov    (%edi),%eax
	}
	return true;
}

bool LinkedList::getMinKey(long long *pkey) {
	if(isEmpty())
8010510e:	85 c0                	test   %eax,%eax
80105110:	74 56                	je     80105168 <_ZN10LinkedList9getMinKeyEPx+0x68>
		return false;

	long long minKey = getAccumulator(first->p);
80105112:	8b 00                	mov    (%eax),%eax
80105114:	89 04 24             	mov    %eax,(%esp)
80105117:	e8 c4 e6 ff ff       	call   801037e0 <getAccumulator>
8010511c:	8b 3f                	mov    (%edi),%edi
	void append(Link *link); //appends the given list to the queue. No allocations always succeeds.
	
	template<typename Func>
	void forEach(const Func& accept) { //for-each loop. gets a function that applies the procin each link node.
		Link *link = first;
		while(link) {
8010511e:	85 ff                	test   %edi,%edi
80105120:	89 c6                	mov    %eax,%esi
80105122:	89 d3                	mov    %edx,%ebx
80105124:	74 29                	je     8010514f <_ZN10LinkedList9getMinKeyEPx+0x4f>
80105126:	8d 76 00             	lea    0x0(%esi),%esi
80105129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	
	forEach([&](Proc *p) {
		long long key = getAccumulator(p);
80105130:	8b 07                	mov    (%edi),%eax
80105132:	89 04 24             	mov    %eax,(%esp)
80105135:	e8 a6 e6 ff ff       	call   801037e0 <getAccumulator>
8010513a:	39 d3                	cmp    %edx,%ebx
8010513c:	7c 0a                	jl     80105148 <_ZN10LinkedList9getMinKeyEPx+0x48>
8010513e:	7f 04                	jg     80105144 <_ZN10LinkedList9getMinKeyEPx+0x44>
80105140:	39 c6                	cmp    %eax,%esi
80105142:	76 04                	jbe    80105148 <_ZN10LinkedList9getMinKeyEPx+0x48>
80105144:	89 c6                	mov    %eax,%esi
80105146:	89 d3                	mov    %edx,%ebx
			accept(link->p);
			link = link->next;
80105148:	8b 7f 04             	mov    0x4(%edi),%edi
	void append(Link *link); //appends the given list to the queue. No allocations always succeeds.
	
	template<typename Func>
	void forEach(const Func& accept) { //for-each loop. gets a function that applies the procin each link node.
		Link *link = first;
		while(link) {
8010514b:	85 ff                	test   %edi,%edi
8010514d:	75 e1                	jne    80105130 <_ZN10LinkedList9getMinKeyEPx+0x30>
		if(key < minKey)
			minKey = key;
	});

	*pkey = minKey;
8010514f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105152:	89 30                	mov    %esi,(%eax)
80105154:	89 58 04             	mov    %ebx,0x4(%eax)
	
	return true;
}
80105157:	83 c4 1c             	add    $0x1c,%esp
			minKey = key;
	});

	*pkey = minKey;
	
	return true;
8010515a:	b0 01                	mov    $0x1,%al
}
8010515c:	5b                   	pop    %ebx
8010515d:	5e                   	pop    %esi
8010515e:	5f                   	pop    %edi
8010515f:	5d                   	pop    %ebp
80105160:	c3                   	ret    
80105161:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105168:	83 c4 1c             	add    $0x1c,%esp
	return true;
}

bool LinkedList::getMinKey(long long *pkey) {
	if(isEmpty())
		return false;
8010516b:	31 c0                	xor    %eax,%eax
	});

	*pkey = minKey;
	
	return true;
}
8010516d:	5b                   	pop    %ebx
8010516e:	5e                   	pop    %esi
8010516f:	5f                   	pop    %edi
80105170:	5d                   	pop    %ebp
80105171:	c3                   	ret    
80105172:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105180 <getMinAccumulatorRunningProcessHolder>:

static boolean removeRunningProcessHolder(Proc* p) {
	return runningProcHolder->remove(p);
}

static boolean getMinAccumulatorRunningProcessHolder(long long *pkey) {
80105180:	55                   	push   %ebp
80105181:	89 e5                	mov    %esp,%ebp
80105183:	83 ec 18             	sub    $0x18,%esp
	return runningProcHolder->getMinKey(pkey);
80105186:	8b 45 08             	mov    0x8(%ebp),%eax
80105189:	89 44 24 04          	mov    %eax,0x4(%esp)
8010518d:	a1 0c c6 10 80       	mov    0x8010c60c,%eax
80105192:	89 04 24             	mov    %eax,(%esp)
80105195:	e8 66 ff ff ff       	call   80105100 <_ZN10LinkedList9getMinKeyEPx>
}
8010519a:	c9                   	leave  
static boolean removeRunningProcessHolder(Proc* p) {
	return runningProcHolder->remove(p);
}

static boolean getMinAccumulatorRunningProcessHolder(long long *pkey) {
	return runningProcHolder->getMinKey(pkey);
8010519b:	0f b6 c0             	movzbl %al,%eax
}
8010519e:	c3                   	ret    
8010519f:	90                   	nop

801051a0 <_ZN7MapNode7isEmptyEv>:
	*pkey = minKey;
	
	return true;
}

bool MapNode::isEmpty() {
801051a0:	55                   	push   %ebp
801051a1:	89 e5                	mov    %esp,%ebp
	return listOfProcs.isEmpty();
801051a3:	8b 45 08             	mov    0x8(%ebp),%eax
}
801051a6:	5d                   	pop    %ebp
	
	return true;
}

bool MapNode::isEmpty() {
	return listOfProcs.isEmpty();
801051a7:	8b 40 08             	mov    0x8(%eax),%eax
801051aa:	85 c0                	test   %eax,%eax
801051ac:	0f 94 c0             	sete   %al
}
801051af:	c3                   	ret    

801051b0 <_ZN7MapNode3putEP4proc>:

bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
801051b0:	55                   	push   %ebp
801051b1:	89 e5                	mov    %esp,%ebp
801051b3:	57                   	push   %edi
801051b4:	56                   	push   %esi
801051b5:	53                   	push   %ebx
801051b6:	83 ec 2c             	sub    $0x2c,%esp
801051b9:	8b 45 0c             	mov    0xc(%ebp),%eax
801051bc:	8b 5d 08             	mov    0x8(%ebp),%ebx
	MapNode *node = this;
	long long key = getAccumulator(p);
801051bf:	89 04 24             	mov    %eax,(%esp)

bool MapNode::isEmpty() {
	return listOfProcs.isEmpty();
}

bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
801051c2:	89 45 e0             	mov    %eax,-0x20(%ebp)
	MapNode *node = this;
	long long key = getAccumulator(p);
801051c5:	e8 16 e6 ff ff       	call   801037e0 <getAccumulator>
801051ca:	89 c6                	mov    %eax,%esi
801051cc:	89 d1                	mov    %edx,%ecx
801051ce:	66 90                	xchg   %ax,%ax
	for(;;) {
		if(key == node->key)
801051d0:	8b 43 04             	mov    0x4(%ebx),%eax
801051d3:	89 cf                	mov    %ecx,%edi
801051d5:	8b 13                	mov    (%ebx),%edx
801051d7:	31 c7                	xor    %eax,%edi
801051d9:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801051dc:	89 f7                	mov    %esi,%edi
801051de:	31 d7                	xor    %edx,%edi
801051e0:	0b 7d e4             	or     -0x1c(%ebp),%edi
801051e3:	74 43                	je     80105228 <_ZN7MapNode3putEP4proc+0x78>
			return node->listOfProcs.enqueue(p);
		else if(key < node->key) { //left
801051e5:	39 c1                	cmp    %eax,%ecx
801051e7:	7f 17                	jg     80105200 <_ZN7MapNode3putEP4proc+0x50>
801051e9:	7c 07                	jl     801051f2 <_ZN7MapNode3putEP4proc+0x42>
801051eb:	39 d6                	cmp    %edx,%esi
801051ed:	8d 76 00             	lea    0x0(%esi),%esi
801051f0:	73 0e                	jae    80105200 <_ZN7MapNode3putEP4proc+0x50>
			if(node->left)
801051f2:	8b 43 18             	mov    0x18(%ebx),%eax
801051f5:	85 c0                	test   %eax,%eax
801051f7:	74 47                	je     80105240 <_ZN7MapNode3putEP4proc+0x90>
801051f9:	89 c3                	mov    %eax,%ebx
801051fb:	eb d3                	jmp    801051d0 <_ZN7MapNode3putEP4proc+0x20>
801051fd:	8d 76 00             	lea    0x0(%esi),%esi
					return true;
				}
				return false;
			}
		} else { //right
			if(node->right)
80105200:	8b 43 1c             	mov    0x1c(%ebx),%eax
80105203:	85 c0                	test   %eax,%eax
80105205:	75 f2                	jne    801051f9 <_ZN7MapNode3putEP4proc+0x49>
				node = node->right;
			else {
				node->right = allocNode(p, key);
80105207:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010520a:	89 f2                	mov    %esi,%edx
8010520c:	e8 bf fc ff ff       	call   80104ed0 <_ZL9allocNodeP4procx>
				if(node->right) {
80105211:	85 c0                	test   %eax,%eax
			}
		} else { //right
			if(node->right)
				node = node->right;
			else {
				node->right = allocNode(p, key);
80105213:	89 43 1c             	mov    %eax,0x1c(%ebx)
				if(node->right) {
80105216:	74 39                	je     80105251 <_ZN7MapNode3putEP4proc+0xa1>
					node->right->parent = node;
80105218:	89 58 14             	mov    %ebx,0x14(%eax)
					return true;
8010521b:	b0 01                	mov    $0x1,%al
				}
				return false;
			}
		}
	}
}
8010521d:	83 c4 2c             	add    $0x2c,%esp
80105220:	5b                   	pop    %ebx
80105221:	5e                   	pop    %esi
80105222:	5f                   	pop    %edi
80105223:	5d                   	pop    %ebp
80105224:	c3                   	ret    
80105225:	8d 76 00             	lea    0x0(%esi),%esi
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
	MapNode *node = this;
	long long key = getAccumulator(p);
	for(;;) {
		if(key == node->key)
			return node->listOfProcs.enqueue(p);
80105228:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010522b:	83 c3 08             	add    $0x8,%ebx
8010522e:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105231:	89 45 0c             	mov    %eax,0xc(%ebp)
				}
				return false;
			}
		}
	}
}
80105234:	83 c4 2c             	add    $0x2c,%esp
80105237:	5b                   	pop    %ebx
80105238:	5e                   	pop    %esi
80105239:	5f                   	pop    %edi
8010523a:	5d                   	pop    %ebp
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
	MapNode *node = this;
	long long key = getAccumulator(p);
	for(;;) {
		if(key == node->key)
			return node->listOfProcs.enqueue(p);
8010523b:	e9 f0 fb ff ff       	jmp    80104e30 <_ZN10LinkedList7enqueueEP4proc>
		else if(key < node->key) { //left
			if(node->left)
				node = node->left;
			else {
				node->left = allocNode(p, key);
80105240:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105243:	89 f2                	mov    %esi,%edx
80105245:	e8 86 fc ff ff       	call   80104ed0 <_ZL9allocNodeP4procx>
				if(node->left) {
8010524a:	85 c0                	test   %eax,%eax
			return node->listOfProcs.enqueue(p);
		else if(key < node->key) { //left
			if(node->left)
				node = node->left;
			else {
				node->left = allocNode(p, key);
8010524c:	89 43 18             	mov    %eax,0x18(%ebx)
				if(node->left) {
8010524f:	75 c7                	jne    80105218 <_ZN7MapNode3putEP4proc+0x68>
					node->left->parent = node;
					return true;
				}
				return false;
80105251:	31 c0                	xor    %eax,%eax
80105253:	eb c8                	jmp    8010521d <_ZN7MapNode3putEP4proc+0x6d>
80105255:	90                   	nop
80105256:	8d 76 00             	lea    0x0(%esi),%esi
80105259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105260 <_ZN7MapNode10getMinNodeEv>:
			}
		}
	}
}

MapNode* MapNode::getMinNode() { //no recursion.
80105260:	55                   	push   %ebp
80105261:	89 e5                	mov    %esp,%ebp
	MapNode* minNode = this;	
80105263:	8b 45 08             	mov    0x8(%ebp),%eax
80105266:	eb 0a                	jmp    80105272 <_ZN7MapNode10getMinNodeEv+0x12>
80105268:	90                   	nop
80105269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105270:	89 d0                	mov    %edx,%eax
	while(minNode->left)
80105272:	8b 50 18             	mov    0x18(%eax),%edx
80105275:	85 d2                	test   %edx,%edx
80105277:	75 f7                	jne    80105270 <_ZN7MapNode10getMinNodeEv+0x10>
		minNode = minNode->left;

	return minNode;
}
80105279:	5d                   	pop    %ebp
8010527a:	c3                   	ret    
8010527b:	90                   	nop
8010527c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105280 <_ZN7MapNode9getMinKeyEPx>:

void MapNode::getMinKey(long long *pkey) {
80105280:	55                   	push   %ebp
80105281:	89 e5                	mov    %esp,%ebp
		}
	}
}

MapNode* MapNode::getMinNode() { //no recursion.
	MapNode* minNode = this;	
80105283:	8b 55 08             	mov    0x8(%ebp),%edx
		minNode = minNode->left;

	return minNode;
}

void MapNode::getMinKey(long long *pkey) {
80105286:	53                   	push   %ebx
80105287:	eb 09                	jmp    80105292 <_ZN7MapNode9getMinKeyEPx+0x12>
80105289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	}
}

MapNode* MapNode::getMinNode() { //no recursion.
	MapNode* minNode = this;	
	while(minNode->left)
80105290:	89 c2                	mov    %eax,%edx
80105292:	8b 42 18             	mov    0x18(%edx),%eax
80105295:	85 c0                	test   %eax,%eax
80105297:	75 f7                	jne    80105290 <_ZN7MapNode9getMinKeyEPx+0x10>

	return minNode;
}

void MapNode::getMinKey(long long *pkey) {
	*pkey = getMinNode()->key;
80105299:	8b 5a 04             	mov    0x4(%edx),%ebx
8010529c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010529f:	8b 0a                	mov    (%edx),%ecx
801052a1:	89 58 04             	mov    %ebx,0x4(%eax)
801052a4:	89 08                	mov    %ecx,(%eax)
}
801052a6:	5b                   	pop    %ebx
801052a7:	5d                   	pop    %ebp
801052a8:	c3                   	ret    
801052a9:	90                   	nop
801052aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801052b0 <_ZN7MapNode7dequeueEv>:

Proc* MapNode::dequeue() {
801052b0:	55                   	push   %ebp
801052b1:	89 e5                	mov    %esp,%ebp
801052b3:	83 ec 08             	sub    $0x8,%esp
801052b6:	8b 4d 08             	mov    0x8(%ebp),%ecx
801052b9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801052bc:	89 75 fc             	mov    %esi,-0x4(%ebp)

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
801052bf:	8b 51 08             	mov    0x8(%ecx),%edx
	append(link);
	return true;
}

Proc* LinkedList::dequeue() {
	if(isEmpty())
801052c2:	85 d2                	test   %edx,%edx
801052c4:	74 42                	je     80105308 <_ZN7MapNode7dequeueEv+0x58>
		return null;

	Proc *p = first->p;
	Link *next = first->next;
801052c6:	8b 5a 04             	mov    0x4(%edx),%ebx
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
801052c9:	8b 35 08 c6 10 80    	mov    0x8010c608,%esi

Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;

	Proc *p = first->p;
801052cf:	8b 02                	mov    (%edx),%eax
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
	freeLinks = link;
801052d1:	89 15 08 c6 10 80    	mov    %edx,0x8010c608
	
	deallocLink(first);
	
	first = next;

	if(isEmpty())
801052d7:	85 db                	test   %ebx,%ebx
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
801052d9:	89 72 04             	mov    %esi,0x4(%edx)
	Proc *p = first->p;
	Link *next = first->next;
	
	deallocLink(first);
	
	first = next;
801052dc:	89 59 08             	mov    %ebx,0x8(%ecx)

	if(isEmpty())
801052df:	74 0f                	je     801052f0 <_ZN7MapNode7dequeueEv+0x40>
	*pkey = getMinNode()->key;
}

Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}
801052e1:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801052e4:	8b 75 fc             	mov    -0x4(%ebp),%esi
801052e7:	89 ec                	mov    %ebp,%esp
801052e9:	5d                   	pop    %ebp
801052ea:	c3                   	ret    
801052eb:	90                   	nop
801052ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	deallocLink(first);
	
	first = next;

	if(isEmpty())
		last = null;
801052f0:	c7 41 0c 00 00 00 00 	movl   $0x0,0xc(%ecx)
	*pkey = getMinNode()->key;
}

Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}
801052f7:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801052fa:	8b 75 fc             	mov    -0x4(%ebp),%esi
801052fd:	89 ec                	mov    %ebp,%esp
801052ff:	5d                   	pop    %ebp
80105300:	c3                   	ret    
80105301:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	return true;
}

Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;
80105308:	31 c0                	xor    %eax,%eax
8010530a:	eb d5                	jmp    801052e1 <_ZN7MapNode7dequeueEv+0x31>
8010530c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105310 <_ZN3Map7isEmptyEv>:

Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
80105310:	55                   	push   %ebp
80105311:	89 e5                	mov    %esp,%ebp
	return !root;
80105313:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105316:	5d                   	pop    %ebp
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
80105317:	8b 00                	mov    (%eax),%eax
80105319:	85 c0                	test   %eax,%eax
8010531b:	0f 94 c0             	sete   %al
}
8010531e:	c3                   	ret    
8010531f:	90                   	nop

80105320 <_ZN3Map3putEP4proc>:

bool Map::put(Proc *p) {
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	83 ec 18             	sub    $0x18,%esp
80105326:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105329:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010532c:	89 75 fc             	mov    %esi,-0x4(%ebp)
8010532f:	8b 75 08             	mov    0x8(%ebp),%esi
	long long key = getAccumulator(p);
80105332:	89 1c 24             	mov    %ebx,(%esp)
80105335:	e8 a6 e4 ff ff       	call   801037e0 <getAccumulator>
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
8010533a:	8b 0e                	mov    (%esi),%ecx
}

bool Map::put(Proc *p) {
	long long key = getAccumulator(p);
	if(isEmpty()) {
8010533c:	85 c9                	test   %ecx,%ecx
8010533e:	74 18                	je     80105358 <_ZN3Map3putEP4proc+0x38>
		root = allocNode(p, key);
		return !isEmpty();
	}
	
	return root->put(p);
80105340:	89 5d 0c             	mov    %ebx,0xc(%ebp)
}
80105343:	8b 75 fc             	mov    -0x4(%ebp),%esi
	if(isEmpty()) {
		root = allocNode(p, key);
		return !isEmpty();
	}
	
	return root->put(p);
80105346:	89 4d 08             	mov    %ecx,0x8(%ebp)
}
80105349:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010534c:	89 ec                	mov    %ebp,%esp
8010534e:	5d                   	pop    %ebp
	if(isEmpty()) {
		root = allocNode(p, key);
		return !isEmpty();
	}
	
	return root->put(p);
8010534f:	e9 5c fe ff ff       	jmp    801051b0 <_ZN7MapNode3putEP4proc>
80105354:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

bool Map::put(Proc *p) {
	long long key = getAccumulator(p);
	if(isEmpty()) {
		root = allocNode(p, key);
80105358:	89 d1                	mov    %edx,%ecx
8010535a:	89 c2                	mov    %eax,%edx
8010535c:	89 d8                	mov    %ebx,%eax
8010535e:	e8 6d fb ff ff       	call   80104ed0 <_ZL9allocNodeP4procx>
80105363:	89 06                	mov    %eax,(%esi)
		return !isEmpty();
80105365:	85 c0                	test   %eax,%eax
80105367:	0f 95 c0             	setne  %al
	}
	
	return root->put(p);
}
8010536a:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010536d:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105370:	89 ec                	mov    %ebp,%esp
80105372:	5d                   	pop    %ebp
80105373:	c3                   	ret    
80105374:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010537a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105380 <putPriorityQueue>:
//for pq
static boolean isEmptyPriorityQueue() {
	return priorityQ->isEmpty();
}

static boolean putPriorityQueue(Proc* p) {
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	83 ec 18             	sub    $0x18,%esp
	return priorityQ->put(p);
80105386:	8b 45 08             	mov    0x8(%ebp),%eax
80105389:	89 44 24 04          	mov    %eax,0x4(%esp)
8010538d:	a1 14 c6 10 80       	mov    0x8010c614,%eax
80105392:	89 04 24             	mov    %eax,(%esp)
80105395:	e8 86 ff ff ff       	call   80105320 <_ZN3Map3putEP4proc>
}
8010539a:	c9                   	leave  
static boolean isEmptyPriorityQueue() {
	return priorityQ->isEmpty();
}

static boolean putPriorityQueue(Proc* p) {
	return priorityQ->put(p);
8010539b:	0f b6 c0             	movzbl %al,%eax
}
8010539e:	c3                   	ret    
8010539f:	90                   	nop

801053a0 <_ZN3Map9getMinKeyEPx>:
	}
	
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
801053a0:	55                   	push   %ebp
801053a1:	89 e5                	mov    %esp,%ebp
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
801053a3:	8b 45 08             	mov    0x8(%ebp),%eax
	}
	
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
801053a6:	53                   	push   %ebx
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
801053a7:	8b 10                	mov    (%eax),%edx
	
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
	if(isEmpty())
801053a9:	85 d2                	test   %edx,%edx
801053ab:	75 05                	jne    801053b2 <_ZN3Map9getMinKeyEPx+0x12>
801053ad:	eb 21                	jmp    801053d0 <_ZN3Map9getMinKeyEPx+0x30>
801053af:	90                   	nop
	}
}

MapNode* MapNode::getMinNode() { //no recursion.
	MapNode* minNode = this;	
	while(minNode->left)
801053b0:	89 c2                	mov    %eax,%edx
801053b2:	8b 42 18             	mov    0x18(%edx),%eax
801053b5:	85 c0                	test   %eax,%eax
801053b7:	75 f7                	jne    801053b0 <_ZN3Map9getMinKeyEPx+0x10>

	return minNode;
}

void MapNode::getMinKey(long long *pkey) {
	*pkey = getMinNode()->key;
801053b9:	8b 45 0c             	mov    0xc(%ebp),%eax
801053bc:	8b 5a 04             	mov    0x4(%edx),%ebx
801053bf:	8b 0a                	mov    (%edx),%ecx
801053c1:	89 58 04             	mov    %ebx,0x4(%eax)
801053c4:	89 08                	mov    %ecx,(%eax)
bool Map::getMinKey(long long *pkey) {
	if(isEmpty())
		return false;

	root->getMinKey(pkey);
	return true;
801053c6:	b0 01                	mov    $0x1,%al
}
801053c8:	5b                   	pop    %ebx
801053c9:	5d                   	pop    %ebp
801053ca:	c3                   	ret    
801053cb:	90                   	nop
801053cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801053d0:	5b                   	pop    %ebx
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
	if(isEmpty())
		return false;
801053d1:	31 c0                	xor    %eax,%eax

	root->getMinKey(pkey);
	return true;
}
801053d3:	5d                   	pop    %ebp
801053d4:	c3                   	ret    
801053d5:	90                   	nop
801053d6:	8d 76 00             	lea    0x0(%esi),%esi
801053d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801053e0 <_ZN3Map10extractMinEv>:

Proc* Map::extractMin() {
801053e0:	55                   	push   %ebp
801053e1:	89 e5                	mov    %esp,%ebp
801053e3:	57                   	push   %edi
801053e4:	56                   	push   %esi
801053e5:	8b 75 08             	mov    0x8(%ebp),%esi
801053e8:	53                   	push   %ebx
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
801053e9:	8b 1e                	mov    (%esi),%ebx
	root->getMinKey(pkey);
	return true;
}

Proc* Map::extractMin() {
	if(isEmpty())
801053eb:	85 db                	test   %ebx,%ebx
801053ed:	0f 84 a2 00 00 00    	je     80105495 <_ZN3Map10extractMinEv+0xb5>
801053f3:	89 da                	mov    %ebx,%edx
801053f5:	eb 0b                	jmp    80105402 <_ZN3Map10extractMinEv+0x22>
801053f7:	89 f6                	mov    %esi,%esi
801053f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	}
}

MapNode* MapNode::getMinNode() { //no recursion.
	MapNode* minNode = this;	
	while(minNode->left)
80105400:	89 c2                	mov    %eax,%edx
80105402:	8b 42 18             	mov    0x18(%edx),%eax
80105405:	85 c0                	test   %eax,%eax
80105407:	75 f7                	jne    80105400 <_ZN3Map10extractMinEv+0x20>

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
80105409:	8b 4a 08             	mov    0x8(%edx),%ecx
	append(link);
	return true;
}

Proc* LinkedList::dequeue() {
	if(isEmpty())
8010540c:	85 c9                	test   %ecx,%ecx
8010540e:	74 20                	je     80105430 <_ZN3Map10extractMinEv+0x50>
		return null;

	Proc *p = first->p;
	Link *next = first->next;
80105410:	8b 59 04             	mov    0x4(%ecx),%ebx
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80105413:	8b 3d 08 c6 10 80    	mov    0x8010c608,%edi

Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;

	Proc *p = first->p;
80105419:	8b 01                	mov    (%ecx),%eax
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
	freeLinks = link;
8010541b:	89 0d 08 c6 10 80    	mov    %ecx,0x8010c608
	
	deallocLink(first);
	
	first = next;

	if(isEmpty())
80105421:	85 db                	test   %ebx,%ebx
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80105423:	89 79 04             	mov    %edi,0x4(%ecx)
	Proc *p = first->p;
	Link *next = first->next;
	
	deallocLink(first);
	
	first = next;
80105426:	89 5a 08             	mov    %ebx,0x8(%edx)

	if(isEmpty())
80105429:	74 4d                	je     80105478 <_ZN3Map10extractMinEv+0x98>
		}
		deallocNode(minNode);
	}

	return p;
}
8010542b:	5b                   	pop    %ebx
8010542c:	5e                   	pop    %esi
8010542d:	5f                   	pop    %edi
8010542e:	5d                   	pop    %ebp
8010542f:	c3                   	ret    
	return true;
}

Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;
80105430:	31 c0                	xor    %eax,%eax
	MapNode *minNode = root->getMinNode();

	Proc *p = minNode->dequeue();
	
	if(minNode->isEmpty()) {
		if(minNode == root) {
80105432:	39 da                	cmp    %ebx,%edx
80105434:	74 4d                	je     80105483 <_ZN3Map10extractMinEv+0xa3>
			root = minNode->right;
			if(!isEmpty())
				root->parent = null;
		} else {
			MapNode *parent = minNode->parent;
			parent->left = minNode->right;
80105436:	8b 4a 1c             	mov    0x1c(%edx),%ecx
		if(minNode == root) {
			root = minNode->right;
			if(!isEmpty())
				root->parent = null;
		} else {
			MapNode *parent = minNode->parent;
80105439:	8b 5a 14             	mov    0x14(%edx),%ebx
			parent->left = minNode->right;
8010543c:	89 4b 18             	mov    %ecx,0x18(%ebx)
			if(minNode->right)
8010543f:	8b 4a 1c             	mov    0x1c(%edx),%ecx
80105442:	85 c9                	test   %ecx,%ecx
80105444:	74 03                	je     80105449 <_ZN3Map10extractMinEv+0x69>
				minNode->right->parent = parent;
80105446:	89 59 14             	mov    %ebx,0x14(%ecx)
	freeLinks = link;
}

static void deallocNode(MapNode *node) {
	node->parent = node->left = node->right = null;
	node->next = freeNodes;
80105449:	8b 0d 04 c6 10 80    	mov    0x8010c604,%ecx
	link->next = freeLinks;
	freeLinks = link;
}

static void deallocNode(MapNode *node) {
	node->parent = node->left = node->right = null;
8010544f:	c7 42 1c 00 00 00 00 	movl   $0x0,0x1c(%edx)
80105456:	c7 42 18 00 00 00 00 	movl   $0x0,0x18(%edx)
8010545d:	c7 42 14 00 00 00 00 	movl   $0x0,0x14(%edx)
	node->next = freeNodes;
80105464:	89 4a 10             	mov    %ecx,0x10(%edx)
		}
		deallocNode(minNode);
	}

	return p;
}
80105467:	5b                   	pop    %ebx
}

static void deallocNode(MapNode *node) {
	node->parent = node->left = node->right = null;
	node->next = freeNodes;
	freeNodes = node;
80105468:	89 15 04 c6 10 80    	mov    %edx,0x8010c604
		}
		deallocNode(minNode);
	}

	return p;
}
8010546e:	5e                   	pop    %esi
8010546f:	5f                   	pop    %edi
80105470:	5d                   	pop    %ebp
80105471:	c3                   	ret    
80105472:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	deallocLink(first);
	
	first = next;

	if(isEmpty())
		last = null;
80105478:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
8010547f:	8b 1e                	mov    (%esi),%ebx
80105481:	eb af                	jmp    80105432 <_ZN3Map10extractMinEv+0x52>

	Proc *p = minNode->dequeue();
	
	if(minNode->isEmpty()) {
		if(minNode == root) {
			root = minNode->right;
80105483:	8b 4a 1c             	mov    0x1c(%edx),%ecx
			if(!isEmpty())
80105486:	85 c9                	test   %ecx,%ecx

	Proc *p = minNode->dequeue();
	
	if(minNode->isEmpty()) {
		if(minNode == root) {
			root = minNode->right;
80105488:	89 0e                	mov    %ecx,(%esi)
			if(!isEmpty())
8010548a:	74 bd                	je     80105449 <_ZN3Map10extractMinEv+0x69>
				root->parent = null;
8010548c:	c7 41 14 00 00 00 00 	movl   $0x0,0x14(%ecx)
80105493:	eb b4                	jmp    80105449 <_ZN3Map10extractMinEv+0x69>
	return true;
}

Proc* Map::extractMin() {
	if(isEmpty())
		return null;
80105495:	31 c0                	xor    %eax,%eax
80105497:	eb 92                	jmp    8010542b <_ZN3Map10extractMinEv+0x4b>
80105499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801054a0 <extractMinPriorityQueue>:

static boolean getMinAccumulatorPriorityQueue(long long* pkey) {
	return priorityQ->getMinKey(pkey);
}

static Proc* extractMinPriorityQueue() {
801054a0:	55                   	push   %ebp
801054a1:	89 e5                	mov    %esp,%ebp
801054a3:	83 ec 04             	sub    $0x4,%esp
	return priorityQ->extractMin();
801054a6:	a1 14 c6 10 80       	mov    0x8010c614,%eax
801054ab:	89 04 24             	mov    %eax,(%esp)
801054ae:	e8 2d ff ff ff       	call   801053e0 <_ZN3Map10extractMinEv>
}
801054b3:	c9                   	leave  
801054b4:	c3                   	ret    
801054b5:	90                   	nop
801054b6:	8d 76 00             	lea    0x0(%esi),%esi
801054b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801054c0 <_ZN3Map8transferEv.part.1>:
	}

	return p;
}

bool Map::transfer() {
801054c0:	55                   	push   %ebp
801054c1:	89 e5                	mov    %esp,%ebp
801054c3:	56                   	push   %esi
801054c4:	53                   	push   %ebx
801054c5:	83 ec 08             	sub    $0x8,%esp
	if(!roundRobinQ->isEmpty())
		return false;

	while(!isEmpty()) {
801054c8:	8b 10                	mov    (%eax),%edx
801054ca:	8b 35 10 c6 10 80    	mov    0x8010c610,%esi
801054d0:	85 d2                	test   %edx,%edx
801054d2:	74 26                	je     801054fa <_ZN3Map8transferEv.part.1+0x3a>
801054d4:	89 c3                	mov    %eax,%ebx
801054d6:	8d 76 00             	lea    0x0(%esi),%esi
801054d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		Proc* p = extractMin();
801054e0:	89 1c 24             	mov    %ebx,(%esp)
801054e3:	e8 f8 fe ff ff       	call   801053e0 <_ZN3Map10extractMinEv>
		roundRobinQ->enqueue(p); //should succeed.
801054e8:	89 34 24             	mov    %esi,(%esp)
801054eb:	89 44 24 04          	mov    %eax,0x4(%esp)
801054ef:	e8 3c f9 ff ff       	call   80104e30 <_ZN10LinkedList7enqueueEP4proc>

bool Map::transfer() {
	if(!roundRobinQ->isEmpty())
		return false;

	while(!isEmpty()) {
801054f4:	8b 03                	mov    (%ebx),%eax
801054f6:	85 c0                	test   %eax,%eax
801054f8:	75 e6                	jne    801054e0 <_ZN3Map8transferEv.part.1+0x20>
		Proc* p = extractMin();
		roundRobinQ->enqueue(p); //should succeed.
	}

	return true;
}
801054fa:	83 c4 08             	add    $0x8,%esp
801054fd:	b0 01                	mov    $0x1,%al
801054ff:	5b                   	pop    %ebx
80105500:	5e                   	pop    %esi
80105501:	5d                   	pop    %ebp
80105502:	c3                   	ret    
80105503:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105510 <switchToRoundRobinPolicyPriorityQueue>:

	return p;
}

bool Map::transfer() {
	if(!roundRobinQ->isEmpty())
80105510:	8b 15 10 c6 10 80    	mov    0x8010c610,%edx
80105516:	8b 02                	mov    (%edx),%eax
80105518:	85 c0                	test   %eax,%eax
8010551a:	74 04                	je     80105520 <switchToRoundRobinPolicyPriorityQueue+0x10>
8010551c:	31 c0                	xor    %eax,%eax
8010551e:	c3                   	ret    
8010551f:	90                   	nop
80105520:	a1 14 c6 10 80       	mov    0x8010c614,%eax

static Proc* extractMinPriorityQueue() {
	return priorityQ->extractMin();
}

static boolean switchToRoundRobinPolicyPriorityQueue() {
80105525:	55                   	push   %ebp
80105526:	89 e5                	mov    %esp,%ebp
80105528:	e8 93 ff ff ff       	call   801054c0 <_ZN3Map8transferEv.part.1>
	return priorityQ->transfer();
}
8010552d:	5d                   	pop    %ebp
8010552e:	0f b6 c0             	movzbl %al,%eax
80105531:	c3                   	ret    
80105532:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105540 <_ZN3Map8transferEv>:

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
80105540:	8b 15 10 c6 10 80    	mov    0x8010c610,%edx
	}

	return p;
}

bool Map::transfer() {
80105546:	55                   	push   %ebp
80105547:	89 e5                	mov    %esp,%ebp
80105549:	8b 45 08             	mov    0x8(%ebp),%eax
	if(!roundRobinQ->isEmpty())
8010554c:	8b 12                	mov    (%edx),%edx
8010554e:	85 d2                	test   %edx,%edx
80105550:	74 0e                	je     80105560 <_ZN3Map8transferEv+0x20>
		Proc* p = extractMin();
		roundRobinQ->enqueue(p); //should succeed.
	}

	return true;
}
80105552:	31 c0                	xor    %eax,%eax
80105554:	5d                   	pop    %ebp
80105555:	c3                   	ret    
80105556:	8d 76 00             	lea    0x0(%esi),%esi
80105559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105560:	5d                   	pop    %ebp
80105561:	e9 5a ff ff ff       	jmp    801054c0 <_ZN3Map8transferEv.part.1>
80105566:	8d 76 00             	lea    0x0(%esi),%esi
80105569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105570 <_ZN3Map11extractProcEP4proc>:

bool Map::extractProc(Proc *p) {
80105570:	55                   	push   %ebp
80105571:	89 e5                	mov    %esp,%ebp
80105573:	57                   	push   %edi
80105574:	56                   	push   %esi
80105575:	53                   	push   %ebx
80105576:	83 ec 2c             	sub    $0x2c,%esp
	if(!freeNodes)
80105579:	8b 15 04 c6 10 80    	mov    0x8010c604,%edx
	}

	return true;
}

bool Map::extractProc(Proc *p) {
8010557f:	8b 75 08             	mov    0x8(%ebp),%esi
80105582:	8b 7d 0c             	mov    0xc(%ebp),%edi
	if(!freeNodes)
80105585:	85 d2                	test   %edx,%edx
80105587:	74 48                	je     801055d1 <_ZN3Map11extractProcEP4proc+0x61>
	MapNode *next, *parent, *left, *right;
};

class Map {
public:
	Map(): root(null) {}
80105589:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
		return false;

	bool ans = false;
80105590:	31 db                	xor    %ebx,%ebx
80105592:	eb 12                	jmp    801055a6 <_ZN3Map11extractProcEP4proc+0x36>
80105594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	Map tempMap;
	while(!isEmpty()) {
		Proc *otherP = extractMin();
80105598:	89 34 24             	mov    %esi,(%esp)
8010559b:	e8 40 fe ff ff       	call   801053e0 <_ZN3Map10extractMinEv>
		if(otherP != p)
801055a0:	39 f8                	cmp    %edi,%eax
801055a2:	75 1c                	jne    801055c0 <_ZN3Map11extractProcEP4proc+0x50>
			tempMap.put(otherP); //should scucceed.
		else ans = true;
801055a4:	b3 01                	mov    $0x1,%bl
	if(!freeNodes)
		return false;

	bool ans = false;
	Map tempMap;
	while(!isEmpty()) {
801055a6:	8b 06                	mov    (%esi),%eax
801055a8:	85 c0                	test   %eax,%eax
801055aa:	75 ec                	jne    80105598 <_ZN3Map11extractProcEP4proc+0x28>
		Proc *otherP = extractMin();
		if(otherP != p)
			tempMap.put(otherP); //should scucceed.
		else ans = true;
	}
	root = tempMap.root;
801055ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801055af:	89 06                	mov    %eax,(%esi)
	return ans;
}
801055b1:	83 c4 2c             	add    $0x2c,%esp
		Proc *otherP = extractMin();
		if(otherP != p)
			tempMap.put(otherP); //should scucceed.
		else ans = true;
	}
	root = tempMap.root;
801055b4:	88 d8                	mov    %bl,%al
	return ans;
}
801055b6:	5b                   	pop    %ebx
801055b7:	5e                   	pop    %esi
801055b8:	5f                   	pop    %edi
801055b9:	5d                   	pop    %ebp
801055ba:	c3                   	ret    
801055bb:	90                   	nop
801055bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	bool ans = false;
	Map tempMap;
	while(!isEmpty()) {
		Proc *otherP = extractMin();
		if(otherP != p)
			tempMap.put(otherP); //should scucceed.
801055c0:	89 44 24 04          	mov    %eax,0x4(%esp)
801055c4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801055c7:	89 04 24             	mov    %eax,(%esp)
801055ca:	e8 51 fd ff ff       	call   80105320 <_ZN3Map3putEP4proc>
801055cf:	eb d5                	jmp    801055a6 <_ZN3Map11extractProcEP4proc+0x36>
		else ans = true;
	}
	root = tempMap.root;
	return ans;
}
801055d1:	83 c4 2c             	add    $0x2c,%esp
	return true;
}

bool Map::extractProc(Proc *p) {
	if(!freeNodes)
		return false;
801055d4:	31 c0                	xor    %eax,%eax
			tempMap.put(otherP); //should scucceed.
		else ans = true;
	}
	root = tempMap.root;
	return ans;
}
801055d6:	5b                   	pop    %ebx
801055d7:	5e                   	pop    %esi
801055d8:	5f                   	pop    %edi
801055d9:	5d                   	pop    %ebp
801055da:	c3                   	ret    
801055db:	90                   	nop
801055dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801055e0 <extractProcPriorityQueue>:

static boolean switchToRoundRobinPolicyPriorityQueue() {
	return priorityQ->transfer();
}

static boolean extractProcPriorityQueue(Proc *p) {
801055e0:	55                   	push   %ebp
801055e1:	89 e5                	mov    %esp,%ebp
801055e3:	83 ec 18             	sub    $0x18,%esp
	return priorityQ->extractProc(p);
801055e6:	8b 45 08             	mov    0x8(%ebp),%eax
801055e9:	89 44 24 04          	mov    %eax,0x4(%esp)
801055ed:	a1 14 c6 10 80       	mov    0x8010c614,%eax
801055f2:	89 04 24             	mov    %eax,(%esp)
801055f5:	e8 76 ff ff ff       	call   80105570 <_ZN3Map11extractProcEP4proc>
}
801055fa:	c9                   	leave  
static boolean switchToRoundRobinPolicyPriorityQueue() {
	return priorityQ->transfer();
}

static boolean extractProcPriorityQueue(Proc *p) {
	return priorityQ->extractProc(p);
801055fb:	0f b6 c0             	movzbl %al,%eax
}
801055fe:	c3                   	ret    
801055ff:	90                   	nop

80105600 <__moddi3>:
	}
	root = tempMap.root;
	return ans;
}

long long __moddi3(long long number, long long divisor) { //returns number%divisor
80105600:	55                   	push   %ebp
80105601:	89 e5                	mov    %esp,%ebp
80105603:	57                   	push   %edi
80105604:	56                   	push   %esi
80105605:	53                   	push   %ebx
80105606:	83 ec 2c             	sub    $0x2c,%esp
80105609:	8b 45 08             	mov    0x8(%ebp),%eax
8010560c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010560f:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105612:	8b 45 10             	mov    0x10(%ebp),%eax
80105615:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80105618:	8b 55 14             	mov    0x14(%ebp),%edx
8010561b:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010561e:	89 d7                	mov    %edx,%edi
	if(divisor == 0)
80105620:	09 c2                	or     %eax,%edx
80105622:	0f 84 9d 00 00 00    	je     801056c5 <__moddi3+0xc5>
		panic((char*)"divide by zero!!!\n");

	bool isNumberNegative = false;
	if(number < 0) {
80105628:	8b 45 e4             	mov    -0x1c(%ebp),%eax

long long __moddi3(long long number, long long divisor) { //returns number%divisor
	if(divisor == 0)
		panic((char*)"divide by zero!!!\n");

	bool isNumberNegative = false;
8010562b:	c6 45 df 00          	movb   $0x0,-0x21(%ebp)
	if(number < 0) {
8010562f:	85 c0                	test   %eax,%eax
80105631:	78 7f                	js     801056b2 <__moddi3+0xb2>
80105633:	8b 55 d8             	mov    -0x28(%ebp),%edx
80105636:	89 f8                	mov    %edi,%eax
80105638:	c1 ff 1f             	sar    $0x1f,%edi
8010563b:	31 f8                	xor    %edi,%eax
8010563d:	89 f9                	mov    %edi,%ecx
8010563f:	31 fa                	xor    %edi,%edx
80105641:	89 c7                	mov    %eax,%edi
80105643:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105646:	89 d6                	mov    %edx,%esi
80105648:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010564b:	29 ce                	sub    %ecx,%esi
8010564d:	19 cf                	sbb    %ecx,%edi
8010564f:	90                   	nop
	if(divisor < 0)
		divisor = -divisor;

	for(;;) {
		long long divisor2 = divisor;
		while(number >= divisor2) {
80105650:	39 fa                	cmp    %edi,%edx
80105652:	7d 1c                	jge    80105670 <__moddi3+0x70>
			if(divisor2 + divisor2 > 0) //exponential decay.
				divisor2 += divisor2;
		}

		if(number < divisor)
			return isNumberNegative ? -number : number;
80105654:	80 7d df 00          	cmpb   $0x0,-0x21(%ebp)
80105658:	74 07                	je     80105661 <__moddi3+0x61>
8010565a:	f7 d8                	neg    %eax
8010565c:	83 d2 00             	adc    $0x0,%edx
8010565f:	f7 da                	neg    %edx
	}
}
80105661:	83 c4 2c             	add    $0x2c,%esp
80105664:	5b                   	pop    %ebx
80105665:	5e                   	pop    %esi
80105666:	5f                   	pop    %edi
80105667:	5d                   	pop    %ebp
80105668:	c3                   	ret    
80105669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	if(divisor < 0)
		divisor = -divisor;

	for(;;) {
		long long divisor2 = divisor;
		while(number >= divisor2) {
80105670:	7f 04                	jg     80105676 <__moddi3+0x76>
80105672:	39 f0                	cmp    %esi,%eax
80105674:	72 de                	jb     80105654 <__moddi3+0x54>
80105676:	89 f1                	mov    %esi,%ecx
80105678:	89 fb                	mov    %edi,%ebx
8010567a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			number -= divisor2;
80105680:	29 c8                	sub    %ecx,%eax
80105682:	19 da                	sbb    %ebx,%edx
			if(divisor2 + divisor2 > 0) //exponential decay.
80105684:	0f a4 cb 01          	shld   $0x1,%ecx,%ebx
80105688:	01 c9                	add    %ecx,%ecx
	if(divisor < 0)
		divisor = -divisor;

	for(;;) {
		long long divisor2 = divisor;
		while(number >= divisor2) {
8010568a:	39 da                	cmp    %ebx,%edx
8010568c:	7f f2                	jg     80105680 <__moddi3+0x80>
8010568e:	7d 18                	jge    801056a8 <__moddi3+0xa8>
			number -= divisor2;
			if(divisor2 + divisor2 > 0) //exponential decay.
				divisor2 += divisor2;
		}

		if(number < divisor)
80105690:	39 d7                	cmp    %edx,%edi
80105692:	7c bc                	jl     80105650 <__moddi3+0x50>
80105694:	7f be                	jg     80105654 <__moddi3+0x54>
80105696:	39 c6                	cmp    %eax,%esi
80105698:	76 b6                	jbe    80105650 <__moddi3+0x50>
8010569a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801056a0:	eb b2                	jmp    80105654 <__moddi3+0x54>
801056a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	if(divisor < 0)
		divisor = -divisor;

	for(;;) {
		long long divisor2 = divisor;
		while(number >= divisor2) {
801056a8:	39 c8                	cmp    %ecx,%eax
801056aa:	73 d4                	jae    80105680 <__moddi3+0x80>
801056ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801056b0:	eb de                	jmp    80105690 <__moddi3+0x90>
	if(divisor == 0)
		panic((char*)"divide by zero!!!\n");

	bool isNumberNegative = false;
	if(number < 0) {
		number = -number;
801056b2:	f7 5d e0             	negl   -0x20(%ebp)
		isNumberNegative = true;
801056b5:	c6 45 df 01          	movb   $0x1,-0x21(%ebp)
	if(divisor == 0)
		panic((char*)"divide by zero!!!\n");

	bool isNumberNegative = false;
	if(number < 0) {
		number = -number;
801056b9:	83 55 e4 00          	adcl   $0x0,-0x1c(%ebp)
801056bd:	f7 5d e4             	negl   -0x1c(%ebp)
801056c0:	e9 6e ff ff ff       	jmp    80105633 <__moddi3+0x33>
	return ans;
}

long long __moddi3(long long number, long long divisor) { //returns number%divisor
	if(divisor == 0)
		panic((char*)"divide by zero!!!\n");
801056c5:	c7 04 24 50 8e 10 80 	movl   $0x80108e50,(%esp)
801056cc:	e8 6f ac ff ff       	call   80100340 <panic>
801056d1:	90                   	nop
801056d2:	66 90                	xchg   %ax,%ax
801056d4:	66 90                	xchg   %ax,%ax
801056d6:	66 90                	xchg   %ax,%ax
801056d8:	66 90                	xchg   %ax,%ax
801056da:	66 90                	xchg   %ax,%ax
801056dc:	66 90                	xchg   %ax,%ax
801056de:	66 90                	xchg   %ax,%ax

801056e0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801056e0:	55                   	push   %ebp
  initlock(&lk->lk, "sleep lock");
801056e1:	b8 63 8e 10 80       	mov    $0x80108e63,%eax
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801056e6:	89 e5                	mov    %esp,%ebp
801056e8:	53                   	push   %ebx
801056e9:	83 ec 14             	sub    $0x14,%esp
801056ec:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801056ef:	89 44 24 04          	mov    %eax,0x4(%esp)
801056f3:	8d 43 04             	lea    0x4(%ebx),%eax
801056f6:	89 04 24             	mov    %eax,(%esp)
801056f9:	e8 12 01 00 00       	call   80105810 <initlock>
  lk->name = name;
801056fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80105701:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80105707:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
8010570e:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
80105711:	83 c4 14             	add    $0x14,%esp
80105714:	5b                   	pop    %ebx
80105715:	5d                   	pop    %ebp
80105716:	c3                   	ret    
80105717:	89 f6                	mov    %esi,%esi
80105719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105720 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80105720:	55                   	push   %ebp
80105721:	89 e5                	mov    %esp,%ebp
80105723:	56                   	push   %esi
80105724:	53                   	push   %ebx
80105725:	83 ec 10             	sub    $0x10,%esp
80105728:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010572b:	8d 73 04             	lea    0x4(%ebx),%esi
8010572e:	89 34 24             	mov    %esi,(%esp)
80105731:	e8 3a 02 00 00       	call   80105970 <acquire>
  while (lk->locked) {
80105736:	8b 13                	mov    (%ebx),%edx
80105738:	85 d2                	test   %edx,%edx
8010573a:	74 16                	je     80105752 <acquiresleep+0x32>
8010573c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80105740:	89 74 24 04          	mov    %esi,0x4(%esp)
80105744:	89 1c 24             	mov    %ebx,(%esp)
80105747:	e8 c4 eb ff ff       	call   80104310 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
8010574c:	8b 03                	mov    (%ebx),%eax
8010574e:	85 c0                	test   %eax,%eax
80105750:	75 ee                	jne    80105740 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80105752:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80105758:	e8 03 e2 ff ff       	call   80103960 <myproc>
8010575d:	8b 40 10             	mov    0x10(%eax),%eax
80105760:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80105763:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105766:	83 c4 10             	add    $0x10,%esp
80105769:	5b                   	pop    %ebx
8010576a:	5e                   	pop    %esi
8010576b:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
8010576c:	e9 9f 02 00 00       	jmp    80105a10 <release>
80105771:	eb 0d                	jmp    80105780 <releasesleep>
80105773:	90                   	nop
80105774:	90                   	nop
80105775:	90                   	nop
80105776:	90                   	nop
80105777:	90                   	nop
80105778:	90                   	nop
80105779:	90                   	nop
8010577a:	90                   	nop
8010577b:	90                   	nop
8010577c:	90                   	nop
8010577d:	90                   	nop
8010577e:	90                   	nop
8010577f:	90                   	nop

80105780 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
80105780:	55                   	push   %ebp
80105781:	89 e5                	mov    %esp,%ebp
80105783:	83 ec 18             	sub    $0x18,%esp
80105786:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105789:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010578c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  acquire(&lk->lk);
8010578f:	8d 73 04             	lea    0x4(%ebx),%esi
80105792:	89 34 24             	mov    %esi,(%esp)
80105795:	e8 d6 01 00 00       	call   80105970 <acquire>
  lk->locked = 0;
8010579a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801057a0:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801057a7:	89 1c 24             	mov    %ebx,(%esp)
801057aa:	e8 81 ed ff ff       	call   80104530 <wakeup>
  release(&lk->lk);
}
801057af:	8b 5d f8             	mov    -0x8(%ebp),%ebx
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
801057b2:	89 75 08             	mov    %esi,0x8(%ebp)
}
801057b5:	8b 75 fc             	mov    -0x4(%ebp),%esi
801057b8:	89 ec                	mov    %ebp,%esp
801057ba:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
801057bb:	e9 50 02 00 00       	jmp    80105a10 <release>

801057c0 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
801057c0:	55                   	push   %ebp
801057c1:	89 e5                	mov    %esp,%ebp
801057c3:	83 ec 28             	sub    $0x28,%esp
801057c6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801057c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801057cc:	89 7d fc             	mov    %edi,-0x4(%ebp)
801057cf:	89 75 f8             	mov    %esi,-0x8(%ebp)
801057d2:	31 f6                	xor    %esi,%esi
  int r;
  
  acquire(&lk->lk);
801057d4:	8d 7b 04             	lea    0x4(%ebx),%edi
801057d7:	89 3c 24             	mov    %edi,(%esp)
801057da:	e8 91 01 00 00       	call   80105970 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801057df:	8b 03                	mov    (%ebx),%eax
801057e1:	85 c0                	test   %eax,%eax
801057e3:	74 11                	je     801057f6 <holdingsleep+0x36>
801057e5:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801057e8:	e8 73 e1 ff ff       	call   80103960 <myproc>
801057ed:	39 58 10             	cmp    %ebx,0x10(%eax)
801057f0:	0f 94 c0             	sete   %al
801057f3:	0f b6 f0             	movzbl %al,%esi
  release(&lk->lk);
801057f6:	89 3c 24             	mov    %edi,(%esp)
801057f9:	e8 12 02 00 00       	call   80105a10 <release>
  return r;
}
801057fe:	89 f0                	mov    %esi,%eax
80105800:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105803:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105806:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105809:	89 ec                	mov    %ebp,%esp
8010580b:	5d                   	pop    %ebp
8010580c:	c3                   	ret    
8010580d:	66 90                	xchg   %ax,%ax
8010580f:	90                   	nop

80105810 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105810:	55                   	push   %ebp
80105811:	89 e5                	mov    %esp,%ebp
80105813:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80105816:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80105819:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
8010581f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
80105822:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105829:	5d                   	pop    %ebp
8010582a:	c3                   	ret    
8010582b:	90                   	nop
8010582c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105830 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105830:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105831:	31 d2                	xor    %edx,%edx
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105833:	89 e5                	mov    %esp,%ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80105835:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105838:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010583b:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010583c:	83 e8 08             	sub    $0x8,%eax
8010583f:	90                   	nop
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105840:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80105846:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010584c:	77 12                	ja     80105860 <getcallerpcs+0x30>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010584e:	8b 58 04             	mov    0x4(%eax),%ebx
80105851:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105854:	42                   	inc    %edx
80105855:	83 fa 0a             	cmp    $0xa,%edx
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80105858:	8b 00                	mov    (%eax),%eax
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
8010585a:	75 e4                	jne    80105840 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010585c:	5b                   	pop    %ebx
8010585d:	5d                   	pop    %ebp
8010585e:	c3                   	ret    
8010585f:	90                   	nop
80105860:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80105863:	8d 51 28             	lea    0x28(%ecx),%edx
80105866:	8d 76 00             	lea    0x0(%esi),%esi
80105869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80105870:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105876:	83 c0 04             	add    $0x4,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80105879:	39 d0                	cmp    %edx,%eax
8010587b:	75 f3                	jne    80105870 <getcallerpcs+0x40>
    pcs[i] = 0;
}
8010587d:	5b                   	pop    %ebx
8010587e:	5d                   	pop    %ebp
8010587f:	c3                   	ret    

80105880 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105880:	55                   	push   %ebp
80105881:	89 e5                	mov    %esp,%ebp
80105883:	53                   	push   %ebx
80105884:	83 ec 04             	sub    $0x4,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105887:	9c                   	pushf  
80105888:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
80105889:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010588a:	e8 31 e0 ff ff       	call   801038c0 <mycpu>
8010588f:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105895:	85 d2                	test   %edx,%edx
80105897:	75 11                	jne    801058aa <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80105899:	e8 22 e0 ff ff       	call   801038c0 <mycpu>
8010589e:	81 e3 00 02 00 00    	and    $0x200,%ebx
801058a4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801058aa:	e8 11 e0 ff ff       	call   801038c0 <mycpu>
801058af:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
}
801058b5:	58                   	pop    %eax
801058b6:	5b                   	pop    %ebx
801058b7:	5d                   	pop    %ebp
801058b8:	c3                   	ret    
801058b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801058c0 <popcli>:

void
popcli(void)
{
801058c0:	55                   	push   %ebp
801058c1:	89 e5                	mov    %esp,%ebp
801058c3:	83 ec 18             	sub    $0x18,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801058c6:	9c                   	pushf  
801058c7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801058c8:	f6 c4 02             	test   $0x2,%ah
801058cb:	75 51                	jne    8010591e <popcli+0x5e>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801058cd:	e8 ee df ff ff       	call   801038c0 <mycpu>
801058d2:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
801058d8:	8d 51 ff             	lea    -0x1(%ecx),%edx
801058db:	85 d2                	test   %edx,%edx
801058dd:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
801058e3:	78 2d                	js     80105912 <popcli+0x52>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801058e5:	e8 d6 df ff ff       	call   801038c0 <mycpu>
801058ea:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801058f0:	85 d2                	test   %edx,%edx
801058f2:	74 0c                	je     80105900 <popcli+0x40>
    sti();
}
801058f4:	c9                   	leave  
801058f5:	c3                   	ret    
801058f6:	8d 76 00             	lea    0x0(%esi),%esi
801058f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105900:	e8 bb df ff ff       	call   801038c0 <mycpu>
80105905:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010590b:	85 c0                	test   %eax,%eax
8010590d:	74 e5                	je     801058f4 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
8010590f:	fb                   	sti    
    sti();
}
80105910:	c9                   	leave  
80105911:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
80105912:	c7 04 24 85 8e 10 80 	movl   $0x80108e85,(%esp)
80105919:	e8 22 aa ff ff       	call   80100340 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
8010591e:	c7 04 24 6e 8e 10 80 	movl   $0x80108e6e,(%esp)
80105925:	e8 16 aa ff ff       	call   80100340 <panic>
8010592a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105930 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80105930:	55                   	push   %ebp
80105931:	89 e5                	mov    %esp,%ebp
80105933:	83 ec 08             	sub    $0x8,%esp
80105936:	89 75 fc             	mov    %esi,-0x4(%ebp)
80105939:	8b 75 08             	mov    0x8(%ebp),%esi
8010593c:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010593f:	31 db                	xor    %ebx,%ebx
  int r;
  pushcli();
80105941:	e8 3a ff ff ff       	call   80105880 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105946:	8b 06                	mov    (%esi),%eax
80105948:	85 c0                	test   %eax,%eax
8010594a:	74 10                	je     8010595c <holding+0x2c>
8010594c:	8b 5e 08             	mov    0x8(%esi),%ebx
8010594f:	e8 6c df ff ff       	call   801038c0 <mycpu>
80105954:	39 c3                	cmp    %eax,%ebx
80105956:	0f 94 c3             	sete   %bl
80105959:	0f b6 db             	movzbl %bl,%ebx
  popcli();
8010595c:	e8 5f ff ff ff       	call   801058c0 <popcli>
  return r;
}
80105961:	89 d8                	mov    %ebx,%eax
80105963:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105966:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105969:	89 ec                	mov    %ebp,%esp
8010596b:	5d                   	pop    %ebp
8010596c:	c3                   	ret    
8010596d:	8d 76 00             	lea    0x0(%esi),%esi

80105970 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80105970:	55                   	push   %ebp
80105971:	89 e5                	mov    %esp,%ebp
80105973:	56                   	push   %esi
80105974:	53                   	push   %ebx
80105975:	83 ec 10             	sub    $0x10,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105978:	e8 03 ff ff ff       	call   80105880 <pushcli>
  if(holding(lk))
8010597d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105980:	89 1c 24             	mov    %ebx,(%esp)
80105983:	e8 a8 ff ff ff       	call   80105930 <holding>
80105988:	85 c0                	test   %eax,%eax
8010598a:	75 78                	jne    80105a04 <acquire+0x94>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010598c:	ba 01 00 00 00       	mov    $0x1,%edx
80105991:	eb 08                	jmp    8010599b <acquire+0x2b>
80105993:	90                   	nop
80105994:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105998:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010599b:	89 d0                	mov    %edx,%eax
8010599d:	f0 87 03             	lock xchg %eax,(%ebx)
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
801059a0:	85 c0                	test   %eax,%eax
801059a2:	75 f4                	jne    80105998 <acquire+0x28>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
801059a4:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
801059a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801059ac:	e8 0f df ff ff       	call   801038c0 <mycpu>
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801059b1:	89 ea                	mov    %ebp,%edx
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
801059b3:	8d 73 0c             	lea    0xc(%ebx),%esi
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
801059b6:	89 43 08             	mov    %eax,0x8(%ebx)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801059b9:	31 c0                	xor    %eax,%eax
801059bb:	90                   	nop
801059bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801059c0:	8d 8a 00 00 00 80    	lea    -0x80000000(%edx),%ecx
801059c6:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
801059cc:	77 1a                	ja     801059e8 <acquire+0x78>
      break;
    pcs[i] = ebp[1];     // saved %eip
801059ce:	8b 4a 04             	mov    0x4(%edx),%ecx
801059d1:	89 0c 86             	mov    %ecx,(%esi,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801059d4:	40                   	inc    %eax
801059d5:	83 f8 0a             	cmp    $0xa,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
801059d8:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801059da:	75 e4                	jne    801059c0 <acquire+0x50>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}
801059dc:	83 c4 10             	add    $0x10,%esp
801059df:	5b                   	pop    %ebx
801059e0:	5e                   	pop    %esi
801059e1:	5d                   	pop    %ebp
801059e2:	c3                   	ret    
801059e3:	90                   	nop
801059e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801059e8:	8d 04 86             	lea    (%esi,%eax,4),%eax
801059eb:	8d 53 34             	lea    0x34(%ebx),%edx
801059ee:	66 90                	xchg   %ax,%ax
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
801059f0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801059f6:	83 c0 04             	add    $0x4,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801059f9:	39 d0                	cmp    %edx,%eax
801059fb:	75 f3                	jne    801059f0 <acquire+0x80>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}
801059fd:	83 c4 10             	add    $0x10,%esp
80105a00:	5b                   	pop    %ebx
80105a01:	5e                   	pop    %esi
80105a02:	5d                   	pop    %ebp
80105a03:	c3                   	ret    
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80105a04:	c7 04 24 8c 8e 10 80 	movl   $0x80108e8c,(%esp)
80105a0b:	e8 30 a9 ff ff       	call   80100340 <panic>

80105a10 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
80105a10:	55                   	push   %ebp
80105a11:	89 e5                	mov    %esp,%ebp
80105a13:	53                   	push   %ebx
80105a14:	83 ec 14             	sub    $0x14,%esp
80105a17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80105a1a:	89 1c 24             	mov    %ebx,(%esp)
80105a1d:	e8 0e ff ff ff       	call   80105930 <holding>
80105a22:	85 c0                	test   %eax,%eax
80105a24:	74 23                	je     80105a49 <release+0x39>
    panic("release");

  lk->pcs[0] = 0;
80105a26:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105a2d:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
80105a34:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80105a39:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
80105a3f:	83 c4 14             	add    $0x14,%esp
80105a42:	5b                   	pop    %ebx
80105a43:	5d                   	pop    %ebp
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
80105a44:	e9 77 fe ff ff       	jmp    801058c0 <popcli>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
80105a49:	c7 04 24 94 8e 10 80 	movl   $0x80108e94,(%esp)
80105a50:	e8 eb a8 ff ff       	call   80100340 <panic>
80105a55:	66 90                	xchg   %ax,%ax
80105a57:	66 90                	xchg   %ax,%ax
80105a59:	66 90                	xchg   %ax,%ax
80105a5b:	66 90                	xchg   %ax,%ax
80105a5d:	66 90                	xchg   %ax,%ax
80105a5f:	90                   	nop

80105a60 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105a60:	55                   	push   %ebp
80105a61:	89 e5                	mov    %esp,%ebp
80105a63:	83 ec 08             	sub    $0x8,%esp
80105a66:	8b 55 08             	mov    0x8(%ebp),%edx
80105a69:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105a6c:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105a6f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if ((int)dst%4 == 0 && n%4 == 0){
80105a72:	f6 c2 03             	test   $0x3,%dl
80105a75:	75 05                	jne    80105a7c <memset+0x1c>
80105a77:	f6 c1 03             	test   $0x3,%cl
80105a7a:	74 14                	je     80105a90 <memset+0x30>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
80105a7c:	89 d7                	mov    %edx,%edi
80105a7e:	8b 45 0c             	mov    0xc(%ebp),%eax
80105a81:	fc                   	cld    
80105a82:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80105a84:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105a87:	89 d0                	mov    %edx,%eax
80105a89:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105a8c:	89 ec                	mov    %ebp,%esp
80105a8e:	5d                   	pop    %ebp
80105a8f:	c3                   	ret    

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
80105a90:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
80105a94:	c1 e9 02             	shr    $0x2,%ecx
80105a97:	89 fb                	mov    %edi,%ebx
80105a99:	89 f8                	mov    %edi,%eax
80105a9b:	c1 e3 18             	shl    $0x18,%ebx
80105a9e:	c1 e0 10             	shl    $0x10,%eax
80105aa1:	09 d8                	or     %ebx,%eax
80105aa3:	09 f8                	or     %edi,%eax
80105aa5:	c1 e7 08             	shl    $0x8,%edi
80105aa8:	09 f8                	or     %edi,%eax
80105aaa:	89 d7                	mov    %edx,%edi
80105aac:	fc                   	cld    
80105aad:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80105aaf:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105ab2:	89 d0                	mov    %edx,%eax
80105ab4:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105ab7:	89 ec                	mov    %ebp,%esp
80105ab9:	5d                   	pop    %ebp
80105aba:	c3                   	ret    
80105abb:	90                   	nop
80105abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ac0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105ac0:	55                   	push   %ebp
80105ac1:	89 e5                	mov    %esp,%ebp
80105ac3:	8b 45 10             	mov    0x10(%ebp),%eax
80105ac6:	57                   	push   %edi
80105ac7:	56                   	push   %esi
80105ac8:	8b 75 0c             	mov    0xc(%ebp),%esi
80105acb:	53                   	push   %ebx
80105acc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105acf:	85 c0                	test   %eax,%eax
80105ad1:	74 27                	je     80105afa <memcmp+0x3a>
    if(*s1 != *s2)
80105ad3:	0f b6 13             	movzbl (%ebx),%edx
80105ad6:	0f b6 0e             	movzbl (%esi),%ecx
80105ad9:	38 d1                	cmp    %dl,%cl
80105adb:	75 2b                	jne    80105b08 <memcmp+0x48>
80105add:	8d 78 ff             	lea    -0x1(%eax),%edi
80105ae0:	31 c0                	xor    %eax,%eax
80105ae2:	eb 12                	jmp    80105af6 <memcmp+0x36>
80105ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105ae8:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
80105aed:	40                   	inc    %eax
80105aee:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80105af2:	38 ca                	cmp    %cl,%dl
80105af4:	75 12                	jne    80105b08 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105af6:	39 f8                	cmp    %edi,%eax
80105af8:	75 ee                	jne    80105ae8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80105afa:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
80105afb:	31 c0                	xor    %eax,%eax
}
80105afd:	5e                   	pop    %esi
80105afe:	5f                   	pop    %edi
80105aff:	5d                   	pop    %ebp
80105b00:	c3                   	ret    
80105b01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b08:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80105b09:	0f b6 c2             	movzbl %dl,%eax
80105b0c:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
80105b0e:	5e                   	pop    %esi
80105b0f:	5f                   	pop    %edi
80105b10:	5d                   	pop    %ebp
80105b11:	c3                   	ret    
80105b12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b20 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105b20:	55                   	push   %ebp
80105b21:	89 e5                	mov    %esp,%ebp
80105b23:	8b 45 08             	mov    0x8(%ebp),%eax
80105b26:	56                   	push   %esi
80105b27:	8b 75 0c             	mov    0xc(%ebp),%esi
80105b2a:	53                   	push   %ebx
80105b2b:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80105b2e:	39 c6                	cmp    %eax,%esi
80105b30:	73 36                	jae    80105b68 <memmove+0x48>
80105b32:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
80105b35:	39 c8                	cmp    %ecx,%eax
80105b37:	73 2f                	jae    80105b68 <memmove+0x48>
    s += n;
    d += n;
    while(n-- > 0)
80105b39:	85 db                	test   %ebx,%ebx
80105b3b:	8d 53 ff             	lea    -0x1(%ebx),%edx
80105b3e:	74 1d                	je     80105b5d <memmove+0x3d>
      *--d = *--s;
80105b40:	29 d9                	sub    %ebx,%ecx
80105b42:	89 cb                	mov    %ecx,%ebx
80105b44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105b4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
80105b50:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105b54:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
80105b57:	4a                   	dec    %edx
80105b58:	83 fa ff             	cmp    $0xffffffff,%edx
80105b5b:	75 f3                	jne    80105b50 <memmove+0x30>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80105b5d:	5b                   	pop    %ebx
80105b5e:	5e                   	pop    %esi
80105b5f:	5d                   	pop    %ebp
80105b60:	c3                   	ret    
80105b61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80105b68:	31 d2                	xor    %edx,%edx
80105b6a:	85 db                	test   %ebx,%ebx
80105b6c:	74 ef                	je     80105b5d <memmove+0x3d>
80105b6e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80105b70:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80105b74:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80105b77:	42                   	inc    %edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80105b78:	39 d3                	cmp    %edx,%ebx
80105b7a:	75 f4                	jne    80105b70 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
80105b7c:	5b                   	pop    %ebx
80105b7d:	5e                   	pop    %esi
80105b7e:	5d                   	pop    %ebp
80105b7f:	c3                   	ret    

80105b80 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105b80:	55                   	push   %ebp
80105b81:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80105b83:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80105b84:	eb 9a                	jmp    80105b20 <memmove>
80105b86:	8d 76 00             	lea    0x0(%esi),%esi
80105b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b90 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80105b90:	55                   	push   %ebp
80105b91:	89 e5                	mov    %esp,%ebp
80105b93:	57                   	push   %edi
80105b94:	8b 7d 08             	mov    0x8(%ebp),%edi
80105b97:	56                   	push   %esi
80105b98:	8b 75 0c             	mov    0xc(%ebp),%esi
80105b9b:	53                   	push   %ebx
80105b9c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
80105b9f:	85 db                	test   %ebx,%ebx
80105ba1:	74 35                	je     80105bd8 <strncmp+0x48>
80105ba3:	0f b6 17             	movzbl (%edi),%edx
80105ba6:	0f b6 0e             	movzbl (%esi),%ecx
80105ba9:	84 d2                	test   %dl,%dl
80105bab:	74 37                	je     80105be4 <strncmp+0x54>
80105bad:	38 d1                	cmp    %dl,%cl
80105baf:	75 33                	jne    80105be4 <strncmp+0x54>
80105bb1:	8d 47 01             	lea    0x1(%edi),%eax
80105bb4:	01 df                	add    %ebx,%edi
80105bb6:	eb 19                	jmp    80105bd1 <strncmp+0x41>
80105bb8:	90                   	nop
80105bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105bc0:	0f b6 10             	movzbl (%eax),%edx
80105bc3:	84 d2                	test   %dl,%dl
80105bc5:	74 19                	je     80105be0 <strncmp+0x50>
80105bc7:	0f b6 0b             	movzbl (%ebx),%ecx
80105bca:	40                   	inc    %eax
80105bcb:	89 de                	mov    %ebx,%esi
80105bcd:	38 ca                	cmp    %cl,%dl
80105bcf:	75 13                	jne    80105be4 <strncmp+0x54>
80105bd1:	39 c7                	cmp    %eax,%edi
    n--, p++, q++;
80105bd3:	8d 5e 01             	lea    0x1(%esi),%ebx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80105bd6:	75 e8                	jne    80105bc0 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80105bd8:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
80105bd9:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
80105bdb:	5e                   	pop    %esi
80105bdc:	5f                   	pop    %edi
80105bdd:	5d                   	pop    %ebp
80105bde:	c3                   	ret    
80105bdf:	90                   	nop
80105be0:	0f b6 4e 01          	movzbl 0x1(%esi),%ecx
80105be4:	5b                   	pop    %ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80105be5:	0f b6 c2             	movzbl %dl,%eax
80105be8:	29 c8                	sub    %ecx,%eax
}
80105bea:	5e                   	pop    %esi
80105beb:	5f                   	pop    %edi
80105bec:	5d                   	pop    %ebp
80105bed:	c3                   	ret    
80105bee:	66 90                	xchg   %ax,%ax

80105bf0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105bf0:	55                   	push   %ebp
80105bf1:	89 e5                	mov    %esp,%ebp
80105bf3:	8b 45 08             	mov    0x8(%ebp),%eax
80105bf6:	56                   	push   %esi
80105bf7:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105bfa:	53                   	push   %ebx
80105bfb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80105bfe:	89 c2                	mov    %eax,%edx
80105c00:	eb 15                	jmp    80105c17 <strncpy+0x27>
80105c02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105c08:	46                   	inc    %esi
80105c09:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
80105c0d:	42                   	inc    %edx
80105c0e:	84 c9                	test   %cl,%cl
80105c10:	88 4a ff             	mov    %cl,-0x1(%edx)
80105c13:	74 09                	je     80105c1e <strncpy+0x2e>
80105c15:	89 d9                	mov    %ebx,%ecx
80105c17:	85 c9                	test   %ecx,%ecx
80105c19:	8d 59 ff             	lea    -0x1(%ecx),%ebx
80105c1c:	7f ea                	jg     80105c08 <strncpy+0x18>
    ;
  while(n-- > 0)
80105c1e:	31 c9                	xor    %ecx,%ecx
80105c20:	85 db                	test   %ebx,%ebx
80105c22:	7e 19                	jle    80105c3d <strncpy+0x4d>
80105c24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105c2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *s++ = 0;
80105c30:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80105c34:	89 de                	mov    %ebx,%esi
80105c36:	41                   	inc    %ecx
80105c37:	29 ce                	sub    %ecx,%esi
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
80105c39:	85 f6                	test   %esi,%esi
80105c3b:	7f f3                	jg     80105c30 <strncpy+0x40>
    *s++ = 0;
  return os;
}
80105c3d:	5b                   	pop    %ebx
80105c3e:	5e                   	pop    %esi
80105c3f:	5d                   	pop    %ebp
80105c40:	c3                   	ret    
80105c41:	eb 0d                	jmp    80105c50 <safestrcpy>
80105c43:	90                   	nop
80105c44:	90                   	nop
80105c45:	90                   	nop
80105c46:	90                   	nop
80105c47:	90                   	nop
80105c48:	90                   	nop
80105c49:	90                   	nop
80105c4a:	90                   	nop
80105c4b:	90                   	nop
80105c4c:	90                   	nop
80105c4d:	90                   	nop
80105c4e:	90                   	nop
80105c4f:	90                   	nop

80105c50 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105c50:	55                   	push   %ebp
80105c51:	89 e5                	mov    %esp,%ebp
80105c53:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105c56:	56                   	push   %esi
80105c57:	8b 45 08             	mov    0x8(%ebp),%eax
80105c5a:	53                   	push   %ebx
80105c5b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80105c5e:	85 c9                	test   %ecx,%ecx
80105c60:	7e 22                	jle    80105c84 <safestrcpy+0x34>
80105c62:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80105c66:	89 c1                	mov    %eax,%ecx
80105c68:	eb 13                	jmp    80105c7d <safestrcpy+0x2d>
80105c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105c70:	42                   	inc    %edx
80105c71:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80105c75:	41                   	inc    %ecx
80105c76:	84 db                	test   %bl,%bl
80105c78:	88 59 ff             	mov    %bl,-0x1(%ecx)
80105c7b:	74 04                	je     80105c81 <safestrcpy+0x31>
80105c7d:	39 f2                	cmp    %esi,%edx
80105c7f:	75 ef                	jne    80105c70 <safestrcpy+0x20>
    ;
  *s = 0;
80105c81:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80105c84:	5b                   	pop    %ebx
80105c85:	5e                   	pop    %esi
80105c86:	5d                   	pop    %ebp
80105c87:	c3                   	ret    
80105c88:	90                   	nop
80105c89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105c90 <strlen>:

int
strlen(const char *s)
{
80105c90:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105c91:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
80105c93:	89 e5                	mov    %esp,%ebp
80105c95:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80105c98:	80 3a 00             	cmpb   $0x0,(%edx)
80105c9b:	74 0a                	je     80105ca7 <strlen+0x17>
80105c9d:	8d 76 00             	lea    0x0(%esi),%esi
80105ca0:	40                   	inc    %eax
80105ca1:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105ca5:	75 f9                	jne    80105ca0 <strlen+0x10>
    ;
  return n;
}
80105ca7:	5d                   	pop    %ebp
80105ca8:	c3                   	ret    

80105ca9 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80105ca9:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80105cad:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80105cb1:	55                   	push   %ebp
  pushl %ebx
80105cb2:	53                   	push   %ebx
  pushl %esi
80105cb3:	56                   	push   %esi
  pushl %edi
80105cb4:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105cb5:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105cb7:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80105cb9:	5f                   	pop    %edi
  popl %esi
80105cba:	5e                   	pop    %esi
  popl %ebx
80105cbb:	5b                   	pop    %ebx
  popl %ebp
80105cbc:	5d                   	pop    %ebp
  ret
80105cbd:	c3                   	ret    
80105cbe:	66 90                	xchg   %ax,%ax

80105cc0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105cc0:	55                   	push   %ebp
80105cc1:	89 e5                	mov    %esp,%ebp
80105cc3:	53                   	push   %ebx
80105cc4:	83 ec 04             	sub    $0x4,%esp
80105cc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80105cca:	e8 91 dc ff ff       	call   80103960 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105ccf:	8b 00                	mov    (%eax),%eax
80105cd1:	39 d8                	cmp    %ebx,%eax
80105cd3:	76 1b                	jbe    80105cf0 <fetchint+0x30>
80105cd5:	8d 53 04             	lea    0x4(%ebx),%edx
80105cd8:	39 d0                	cmp    %edx,%eax
80105cda:	72 14                	jb     80105cf0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80105cdc:	8b 45 0c             	mov    0xc(%ebp),%eax
80105cdf:	8b 13                	mov    (%ebx),%edx
80105ce1:	89 10                	mov    %edx,(%eax)
  return 0;
80105ce3:	31 c0                	xor    %eax,%eax
}
80105ce5:	5a                   	pop    %edx
80105ce6:	5b                   	pop    %ebx
80105ce7:	5d                   	pop    %ebp
80105ce8:	c3                   	ret    
80105ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80105cf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cf5:	eb ee                	jmp    80105ce5 <fetchint+0x25>
80105cf7:	89 f6                	mov    %esi,%esi
80105cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105d00 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105d00:	55                   	push   %ebp
80105d01:	89 e5                	mov    %esp,%ebp
80105d03:	53                   	push   %ebx
80105d04:	83 ec 04             	sub    $0x4,%esp
80105d07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80105d0a:	e8 51 dc ff ff       	call   80103960 <myproc>

  if(addr >= curproc->sz)
80105d0f:	39 18                	cmp    %ebx,(%eax)
80105d11:	76 27                	jbe    80105d3a <fetchstr+0x3a>
    return -1;
  *pp = (char*)addr;
80105d13:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105d16:	89 da                	mov    %ebx,%edx
80105d18:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80105d1a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80105d1c:	39 c3                	cmp    %eax,%ebx
80105d1e:	73 1a                	jae    80105d3a <fetchstr+0x3a>
    if(*s == 0)
80105d20:	80 3b 00             	cmpb   $0x0,(%ebx)
80105d23:	75 10                	jne    80105d35 <fetchstr+0x35>
80105d25:	eb 21                	jmp    80105d48 <fetchstr+0x48>
80105d27:	89 f6                	mov    %esi,%esi
80105d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105d30:	80 3a 00             	cmpb   $0x0,(%edx)
80105d33:	74 13                	je     80105d48 <fetchstr+0x48>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
80105d35:	42                   	inc    %edx
80105d36:	39 d0                	cmp    %edx,%eax
80105d38:	77 f6                	ja     80105d30 <fetchstr+0x30>
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80105d3a:	5a                   	pop    %edx
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
80105d3b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80105d40:	5b                   	pop    %ebx
80105d41:	5d                   	pop    %ebp
80105d42:	c3                   	ret    
80105d43:	90                   	nop
80105d44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
80105d48:	89 d0                	mov    %edx,%eax
  }
  return -1;
}
80105d4a:	5a                   	pop    %edx
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
80105d4b:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80105d4d:	5b                   	pop    %ebx
80105d4e:	5d                   	pop    %ebp
80105d4f:	c3                   	ret    

80105d50 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105d50:	55                   	push   %ebp
80105d51:	89 e5                	mov    %esp,%ebp
80105d53:	56                   	push   %esi
80105d54:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105d55:	e8 06 dc ff ff       	call   80103960 <myproc>
80105d5a:	8b 55 08             	mov    0x8(%ebp),%edx
80105d5d:	8b 40 18             	mov    0x18(%eax),%eax
80105d60:	8b 40 44             	mov    0x44(%eax),%eax
80105d63:	8d 1c 90             	lea    (%eax,%edx,4),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();
80105d66:	e8 f5 db ff ff       	call   80103960 <myproc>

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105d6b:	8d 73 04             	lea    0x4(%ebx),%esi
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105d6e:	8b 00                	mov    (%eax),%eax
80105d70:	39 c6                	cmp    %eax,%esi
80105d72:	73 1c                	jae    80105d90 <argint+0x40>
80105d74:	8d 53 08             	lea    0x8(%ebx),%edx
80105d77:	39 d0                	cmp    %edx,%eax
80105d79:	72 15                	jb     80105d90 <argint+0x40>
    return -1;
  *ip = *(int*)(addr);
80105d7b:	8b 45 0c             	mov    0xc(%ebp),%eax
80105d7e:	8b 53 04             	mov    0x4(%ebx),%edx
80105d81:	89 10                	mov    %edx,(%eax)
  return 0;
80105d83:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
}
80105d85:	5b                   	pop    %ebx
80105d86:	5e                   	pop    %esi
80105d87:	5d                   	pop    %ebp
80105d88:	c3                   	ret    
80105d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80105d90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d95:	eb ee                	jmp    80105d85 <argint+0x35>
80105d97:	89 f6                	mov    %esi,%esi
80105d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105da0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105da0:	55                   	push   %ebp
80105da1:	89 e5                	mov    %esp,%ebp
80105da3:	56                   	push   %esi
80105da4:	53                   	push   %ebx
80105da5:	83 ec 20             	sub    $0x20,%esp
80105da8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80105dab:	e8 b0 db ff ff       	call   80103960 <myproc>
80105db0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80105db2:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105db5:	89 44 24 04          	mov    %eax,0x4(%esp)
80105db9:	8b 45 08             	mov    0x8(%ebp),%eax
80105dbc:	89 04 24             	mov    %eax,(%esp)
80105dbf:	e8 8c ff ff ff       	call   80105d50 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105dc4:	c1 e8 1f             	shr    $0x1f,%eax
80105dc7:	84 c0                	test   %al,%al
80105dc9:	75 2d                	jne    80105df8 <argptr+0x58>
80105dcb:	89 d8                	mov    %ebx,%eax
80105dcd:	c1 e8 1f             	shr    $0x1f,%eax
80105dd0:	84 c0                	test   %al,%al
80105dd2:	75 24                	jne    80105df8 <argptr+0x58>
80105dd4:	8b 16                	mov    (%esi),%edx
80105dd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105dd9:	39 c2                	cmp    %eax,%edx
80105ddb:	76 1b                	jbe    80105df8 <argptr+0x58>
80105ddd:	01 c3                	add    %eax,%ebx
80105ddf:	39 da                	cmp    %ebx,%edx
80105de1:	72 15                	jb     80105df8 <argptr+0x58>
    return -1;
  *pp = (char*)i;
80105de3:	8b 55 0c             	mov    0xc(%ebp),%edx
80105de6:	89 02                	mov    %eax,(%edx)
  return 0;
80105de8:	31 c0                	xor    %eax,%eax
}
80105dea:	83 c4 20             	add    $0x20,%esp
80105ded:	5b                   	pop    %ebx
80105dee:	5e                   	pop    %esi
80105def:	5d                   	pop    %ebp
80105df0:	c3                   	ret    
80105df1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
80105df8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105dfd:	eb eb                	jmp    80105dea <argptr+0x4a>
80105dff:	90                   	nop

80105e00 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105e00:	55                   	push   %ebp
80105e01:	89 e5                	mov    %esp,%ebp
80105e03:	83 ec 28             	sub    $0x28,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105e06:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e09:	89 44 24 04          	mov    %eax,0x4(%esp)
80105e0d:	8b 45 08             	mov    0x8(%ebp),%eax
80105e10:	89 04 24             	mov    %eax,(%esp)
80105e13:	e8 38 ff ff ff       	call   80105d50 <argint>
80105e18:	85 c0                	test   %eax,%eax
80105e1a:	78 14                	js     80105e30 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80105e1c:	8b 45 0c             	mov    0xc(%ebp),%eax
80105e1f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105e23:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e26:	89 04 24             	mov    %eax,(%esp)
80105e29:	e8 d2 fe ff ff       	call   80105d00 <fetchstr>
}
80105e2e:	c9                   	leave  
80105e2f:	c3                   	ret    
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80105e30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80105e35:	c9                   	leave  
80105e36:	c3                   	ret    
80105e37:	89 f6                	mov    %esi,%esi
80105e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e40 <syscall>:
[SYS_policy]  sys_policy,
};

void
syscall(void)
{
80105e40:	55                   	push   %ebp
80105e41:	89 e5                	mov    %esp,%ebp
80105e43:	83 ec 18             	sub    $0x18,%esp
80105e46:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105e49:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int num;
  struct proc *curproc = myproc();
80105e4c:	e8 0f db ff ff       	call   80103960 <myproc>

  num = curproc->tf->eax;
80105e51:	8b 70 18             	mov    0x18(%eax),%esi

void
syscall(void)
{
  int num;
  struct proc *curproc = myproc();
80105e54:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80105e56:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105e59:	8d 50 ff             	lea    -0x1(%eax),%edx
80105e5c:	83 fa 16             	cmp    $0x16,%edx
80105e5f:	77 1f                	ja     80105e80 <syscall+0x40>
80105e61:	8b 14 85 c0 8e 10 80 	mov    -0x7fef7140(,%eax,4),%edx
80105e68:	85 d2                	test   %edx,%edx
80105e6a:	74 14                	je     80105e80 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80105e6c:	ff d2                	call   *%edx
80105e6e:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105e71:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105e74:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105e77:	89 ec                	mov    %ebp,%esp
80105e79:	5d                   	pop    %ebp
80105e7a:	c3                   	ret    
80105e7b:	90                   	nop
80105e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80105e80:	89 44 24 0c          	mov    %eax,0xc(%esp)
            curproc->pid, curproc->name, num);
80105e84:	8d 43 6c             	lea    0x6c(%ebx),%eax
80105e87:	89 44 24 08          	mov    %eax,0x8(%esp)

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80105e8b:	8b 43 10             	mov    0x10(%ebx),%eax
80105e8e:	c7 04 24 9c 8e 10 80 	movl   $0x80108e9c,(%esp)
80105e95:	89 44 24 04          	mov    %eax,0x4(%esp)
80105e99:	e8 a2 a7 ff ff       	call   80100640 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
80105e9e:	8b 43 18             	mov    0x18(%ebx),%eax
80105ea1:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80105ea8:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105eab:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105eae:	89 ec                	mov    %ebp,%esp
80105eb0:	5d                   	pop    %ebp
80105eb1:	c3                   	ret    
80105eb2:	66 90                	xchg   %ax,%ax
80105eb4:	66 90                	xchg   %ax,%ax
80105eb6:	66 90                	xchg   %ax,%ax
80105eb8:	66 90                	xchg   %ax,%ax
80105eba:	66 90                	xchg   %ax,%ax
80105ebc:	66 90                	xchg   %ax,%ax
80105ebe:	66 90                	xchg   %ax,%ax

80105ec0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105ec0:	55                   	push   %ebp
80105ec1:	0f bf d2             	movswl %dx,%edx
80105ec4:	89 e5                	mov    %esp,%ebp
80105ec6:	83 ec 58             	sub    $0x58,%esp
80105ec9:	89 7d fc             	mov    %edi,-0x4(%ebp)
80105ecc:	0f bf 7d 08          	movswl 0x8(%ebp),%edi
80105ed0:	0f bf c9             	movswl %cx,%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105ed3:	89 04 24             	mov    %eax,(%esp)
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105ed6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80105ed9:	89 75 f8             	mov    %esi,-0x8(%ebp)
80105edc:	89 7d bc             	mov    %edi,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105edf:	8d 7d da             	lea    -0x26(%ebp),%edi
80105ee2:	89 7c 24 04          	mov    %edi,0x4(%esp)
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105ee6:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80105ee9:	89 4d c0             	mov    %ecx,-0x40(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105eec:	e8 bf c0 ff ff       	call   80101fb0 <nameiparent>
80105ef1:	85 c0                	test   %eax,%eax
80105ef3:	0f 84 ef 00 00 00    	je     80105fe8 <create+0x128>
    return 0;
  ilock(dp);
80105ef9:	89 04 24             	mov    %eax,(%esp)
80105efc:	89 c3                	mov    %eax,%ebx
80105efe:	e8 ed b7 ff ff       	call   801016f0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80105f03:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80105f06:	89 44 24 08          	mov    %eax,0x8(%esp)
80105f0a:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105f0e:	89 1c 24             	mov    %ebx,(%esp)
80105f11:	e8 3a bd ff ff       	call   80101c50 <dirlookup>
80105f16:	85 c0                	test   %eax,%eax
80105f18:	89 c6                	mov    %eax,%esi
80105f1a:	74 54                	je     80105f70 <create+0xb0>
    iunlockput(dp);
80105f1c:	89 1c 24             	mov    %ebx,(%esp)
80105f1f:	e8 5c ba ff ff       	call   80101980 <iunlockput>
    ilock(ip);
80105f24:	89 34 24             	mov    %esi,(%esp)
80105f27:	e8 c4 b7 ff ff       	call   801016f0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105f2c:	83 7d c4 02          	cmpl   $0x2,-0x3c(%ebp)
80105f30:	75 1e                	jne    80105f50 <create+0x90>
80105f32:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80105f37:	89 f0                	mov    %esi,%eax
80105f39:	75 15                	jne    80105f50 <create+0x90>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105f3b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105f3e:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105f41:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105f44:	89 ec                	mov    %ebp,%esp
80105f46:	5d                   	pop    %ebp
80105f47:	c3                   	ret    
80105f48:	90                   	nop
80105f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80105f50:	89 34 24             	mov    %esi,(%esp)
80105f53:	e8 28 ba ff ff       	call   80101980 <iunlockput>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105f58:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
80105f5b:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105f5d:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105f60:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105f63:	89 ec                	mov    %ebp,%esp
80105f65:	5d                   	pop    %ebp
80105f66:	c3                   	ret    
80105f67:	89 f6                	mov    %esi,%esi
80105f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80105f70:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80105f73:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f77:	8b 03                	mov    (%ebx),%eax
80105f79:	89 04 24             	mov    %eax,(%esp)
80105f7c:	e8 ef b5 ff ff       	call   80101570 <ialloc>
80105f81:	85 c0                	test   %eax,%eax
80105f83:	89 c6                	mov    %eax,%esi
80105f85:	0f 84 c1 00 00 00    	je     8010604c <create+0x18c>
    panic("create: ialloc");

  ilock(ip);
80105f8b:	89 04 24             	mov    %eax,(%esp)
80105f8e:	e8 5d b7 ff ff       	call   801016f0 <ilock>
  ip->major = major;
80105f93:	8b 45 c0             	mov    -0x40(%ebp),%eax
  ip->minor = minor;
  ip->nlink = 1;
80105f96:	66 c7 46 56 01 00    	movw   $0x1,0x56(%esi)

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");

  ilock(ip);
  ip->major = major;
80105f9c:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80105fa0:	8b 45 bc             	mov    -0x44(%ebp),%eax
80105fa3:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
  iupdate(ip);
80105fa7:	89 34 24             	mov    %esi,(%esp)
80105faa:	e8 81 b6 ff ff       	call   80101630 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80105faf:	83 7d c4 01          	cmpl   $0x1,-0x3c(%ebp)
80105fb3:	74 3b                	je     80105ff0 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80105fb5:	8b 46 04             	mov    0x4(%esi),%eax
80105fb8:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105fbc:	89 1c 24             	mov    %ebx,(%esp)
80105fbf:	89 44 24 08          	mov    %eax,0x8(%esp)
80105fc3:	e8 e8 be ff ff       	call   80101eb0 <dirlink>
80105fc8:	85 c0                	test   %eax,%eax
80105fca:	78 74                	js     80106040 <create+0x180>
    panic("create: dirlink");

  iunlockput(dp);
80105fcc:	89 1c 24             	mov    %ebx,(%esp)
80105fcf:	e8 ac b9 ff ff       	call   80101980 <iunlockput>

  return ip;
80105fd4:	89 f0                	mov    %esi,%eax
}
80105fd6:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105fd9:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105fdc:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105fdf:	89 ec                	mov    %ebp,%esp
80105fe1:	5d                   	pop    %ebp
80105fe2:	c3                   	ret    
80105fe3:	90                   	nop
80105fe4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80105fe8:	31 c0                	xor    %eax,%eax
80105fea:	e9 4c ff ff ff       	jmp    80105f3b <create+0x7b>
80105fef:	90                   	nop
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80105ff0:	66 ff 43 56          	incw   0x56(%ebx)
    iupdate(dp);
80105ff4:	89 1c 24             	mov    %ebx,(%esp)
80105ff7:	e8 34 b6 ff ff       	call   80101630 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105ffc:	8b 46 04             	mov    0x4(%esi),%eax
80105fff:	ba 3c 8f 10 80       	mov    $0x80108f3c,%edx
80106004:	89 54 24 04          	mov    %edx,0x4(%esp)
80106008:	89 34 24             	mov    %esi,(%esp)
8010600b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010600f:	e8 9c be ff ff       	call   80101eb0 <dirlink>
80106014:	85 c0                	test   %eax,%eax
80106016:	78 1c                	js     80106034 <create+0x174>
80106018:	8b 43 04             	mov    0x4(%ebx),%eax
8010601b:	89 34 24             	mov    %esi,(%esp)
8010601e:	89 44 24 08          	mov    %eax,0x8(%esp)
80106022:	b8 3b 8f 10 80       	mov    $0x80108f3b,%eax
80106027:	89 44 24 04          	mov    %eax,0x4(%esp)
8010602b:	e8 80 be ff ff       	call   80101eb0 <dirlink>
80106030:	85 c0                	test   %eax,%eax
80106032:	79 81                	jns    80105fb5 <create+0xf5>
      panic("create dots");
80106034:	c7 04 24 2f 8f 10 80 	movl   $0x80108f2f,(%esp)
8010603b:	e8 00 a3 ff ff       	call   80100340 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
80106040:	c7 04 24 3e 8f 10 80 	movl   $0x80108f3e,(%esp)
80106047:	e8 f4 a2 ff ff       	call   80100340 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
8010604c:	c7 04 24 20 8f 10 80 	movl   $0x80108f20,(%esp)
80106053:	e8 e8 a2 ff ff       	call   80100340 <panic>
80106058:	90                   	nop
80106059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106060 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80106060:	55                   	push   %ebp
80106061:	89 e5                	mov    %esp,%ebp
80106063:	56                   	push   %esi
80106064:	89 c6                	mov    %eax,%esi
80106066:	53                   	push   %ebx
80106067:	89 d3                	mov    %edx,%ebx
80106069:	83 ec 20             	sub    $0x20,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
8010606c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010606f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106073:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010607a:	e8 d1 fc ff ff       	call   80105d50 <argint>
8010607f:	85 c0                	test   %eax,%eax
80106081:	78 2d                	js     801060b0 <argfd.constprop.0+0x50>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80106083:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80106087:	77 27                	ja     801060b0 <argfd.constprop.0+0x50>
80106089:	e8 d2 d8 ff ff       	call   80103960 <myproc>
8010608e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106091:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80106095:	85 c0                	test   %eax,%eax
80106097:	74 17                	je     801060b0 <argfd.constprop.0+0x50>
    return -1;
  if(pfd)
80106099:	85 f6                	test   %esi,%esi
8010609b:	74 02                	je     8010609f <argfd.constprop.0+0x3f>
    *pfd = fd;
8010609d:	89 16                	mov    %edx,(%esi)
  if(pf)
8010609f:	85 db                	test   %ebx,%ebx
801060a1:	74 1d                	je     801060c0 <argfd.constprop.0+0x60>
    *pf = f;
801060a3:	89 03                	mov    %eax,(%ebx)
  return 0;
801060a5:	31 c0                	xor    %eax,%eax
}
801060a7:	83 c4 20             	add    $0x20,%esp
801060aa:	5b                   	pop    %ebx
801060ab:	5e                   	pop    %esi
801060ac:	5d                   	pop    %ebp
801060ad:	c3                   	ret    
801060ae:	66 90                	xchg   %ax,%ax
801060b0:	83 c4 20             	add    $0x20,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
801060b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
801060b8:	5b                   	pop    %ebx
801060b9:	5e                   	pop    %esi
801060ba:	5d                   	pop    %ebp
801060bb:	c3                   	ret    
801060bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
801060c0:	31 c0                	xor    %eax,%eax
801060c2:	eb e3                	jmp    801060a7 <argfd.constprop.0+0x47>
801060c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801060ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801060d0 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
801060d0:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
801060d1:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
801060d3:	89 e5                	mov    %esp,%ebp
801060d5:	56                   	push   %esi
801060d6:	53                   	push   %ebx
801060d7:	83 ec 20             	sub    $0x20,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
801060da:	8d 55 f4             	lea    -0xc(%ebp),%edx
801060dd:	e8 7e ff ff ff       	call   80106060 <argfd.constprop.0>
801060e2:	85 c0                	test   %eax,%eax
801060e4:	78 18                	js     801060fe <sys_dup+0x2e>
    return -1;
  if((fd=fdalloc(f)) < 0)
801060e6:	8b 75 f4             	mov    -0xc(%ebp),%esi
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801060e9:	31 db                	xor    %ebx,%ebx
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801060eb:	e8 70 d8 ff ff       	call   80103960 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
801060f0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801060f4:	85 d2                	test   %edx,%edx
801060f6:	74 18                	je     80106110 <sys_dup+0x40>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801060f8:	43                   	inc    %ebx
801060f9:	83 fb 10             	cmp    $0x10,%ebx
801060fc:	75 f2                	jne    801060f0 <sys_dup+0x20>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
801060fe:	83 c4 20             	add    $0x20,%esp
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80106101:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80106106:	5b                   	pop    %ebx
80106107:	5e                   	pop    %esi
80106108:	5d                   	pop    %ebp
80106109:	c3                   	ret    
8010610a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80106110:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80106114:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106117:	89 04 24             	mov    %eax,(%esp)
8010611a:	e8 b1 ac ff ff       	call   80100dd0 <filedup>
  return fd;
}
8010611f:	83 c4 20             	add    $0x20,%esp
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
80106122:	89 d8                	mov    %ebx,%eax
}
80106124:	5b                   	pop    %ebx
80106125:	5e                   	pop    %esi
80106126:	5d                   	pop    %ebp
80106127:	c3                   	ret    
80106128:	90                   	nop
80106129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106130 <sys_read>:

int
sys_read(void)
{
80106130:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106131:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80106133:	89 e5                	mov    %esp,%ebp
80106135:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106138:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010613b:	e8 20 ff ff ff       	call   80106060 <argfd.constprop.0>
80106140:	85 c0                	test   %eax,%eax
80106142:	78 54                	js     80106198 <sys_read+0x68>
80106144:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106147:	89 44 24 04          	mov    %eax,0x4(%esp)
8010614b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106152:	e8 f9 fb ff ff       	call   80105d50 <argint>
80106157:	85 c0                	test   %eax,%eax
80106159:	78 3d                	js     80106198 <sys_read+0x68>
8010615b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010615e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106165:	89 44 24 08          	mov    %eax,0x8(%esp)
80106169:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010616c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106170:	e8 2b fc ff ff       	call   80105da0 <argptr>
80106175:	85 c0                	test   %eax,%eax
80106177:	78 1f                	js     80106198 <sys_read+0x68>
    return -1;
  return fileread(f, p, n);
80106179:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010617c:	89 44 24 08          	mov    %eax,0x8(%esp)
80106180:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106183:	89 44 24 04          	mov    %eax,0x4(%esp)
80106187:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010618a:	89 04 24             	mov    %eax,(%esp)
8010618d:	e8 be ad ff ff       	call   80100f50 <fileread>
}
80106192:	c9                   	leave  
80106193:	c3                   	ret    
80106194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80106198:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
8010619d:	c9                   	leave  
8010619e:	c3                   	ret    
8010619f:	90                   	nop

801061a0 <sys_write>:

int
sys_write(void)
{
801061a0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801061a1:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
801061a3:	89 e5                	mov    %esp,%ebp
801061a5:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801061a8:	8d 55 ec             	lea    -0x14(%ebp),%edx
801061ab:	e8 b0 fe ff ff       	call   80106060 <argfd.constprop.0>
801061b0:	85 c0                	test   %eax,%eax
801061b2:	78 54                	js     80106208 <sys_write+0x68>
801061b4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801061b7:	89 44 24 04          	mov    %eax,0x4(%esp)
801061bb:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801061c2:	e8 89 fb ff ff       	call   80105d50 <argint>
801061c7:	85 c0                	test   %eax,%eax
801061c9:	78 3d                	js     80106208 <sys_write+0x68>
801061cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061ce:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801061d5:	89 44 24 08          	mov    %eax,0x8(%esp)
801061d9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801061dc:	89 44 24 04          	mov    %eax,0x4(%esp)
801061e0:	e8 bb fb ff ff       	call   80105da0 <argptr>
801061e5:	85 c0                	test   %eax,%eax
801061e7:	78 1f                	js     80106208 <sys_write+0x68>
    return -1;
  return filewrite(f, p, n);
801061e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061ec:	89 44 24 08          	mov    %eax,0x8(%esp)
801061f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801061f3:	89 44 24 04          	mov    %eax,0x4(%esp)
801061f7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801061fa:	89 04 24             	mov    %eax,(%esp)
801061fd:	e8 fe ad ff ff       	call   80101000 <filewrite>
}
80106202:	c9                   	leave  
80106203:	c3                   	ret    
80106204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80106208:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
8010620d:	c9                   	leave  
8010620e:	c3                   	ret    
8010620f:	90                   	nop

80106210 <sys_close>:

int
sys_close(void)
{
80106210:	55                   	push   %ebp
80106211:	89 e5                	mov    %esp,%ebp
80106213:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80106216:	8d 55 f4             	lea    -0xc(%ebp),%edx
80106219:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010621c:	e8 3f fe ff ff       	call   80106060 <argfd.constprop.0>
80106221:	85 c0                	test   %eax,%eax
80106223:	78 23                	js     80106248 <sys_close+0x38>
    return -1;
  myproc()->ofile[fd] = 0;
80106225:	e8 36 d7 ff ff       	call   80103960 <myproc>
8010622a:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010622d:	31 c9                	xor    %ecx,%ecx
8010622f:	89 4c 90 28          	mov    %ecx,0x28(%eax,%edx,4)
  fileclose(f);
80106233:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106236:	89 04 24             	mov    %eax,(%esp)
80106239:	e8 e2 ab ff ff       	call   80100e20 <fileclose>
  return 0;
8010623e:	31 c0                	xor    %eax,%eax
}
80106240:	c9                   	leave  
80106241:	c3                   	ret    
80106242:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80106248:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
8010624d:	c9                   	leave  
8010624e:	c3                   	ret    
8010624f:	90                   	nop

80106250 <sys_fstat>:

int
sys_fstat(void)
{
80106250:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80106251:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80106253:	89 e5                	mov    %esp,%ebp
80106255:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80106258:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010625b:	e8 00 fe ff ff       	call   80106060 <argfd.constprop.0>
80106260:	85 c0                	test   %eax,%eax
80106262:	78 3c                	js     801062a0 <sys_fstat+0x50>
80106264:	b8 14 00 00 00       	mov    $0x14,%eax
80106269:	89 44 24 08          	mov    %eax,0x8(%esp)
8010626d:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106270:	89 44 24 04          	mov    %eax,0x4(%esp)
80106274:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010627b:	e8 20 fb ff ff       	call   80105da0 <argptr>
80106280:	85 c0                	test   %eax,%eax
80106282:	78 1c                	js     801062a0 <sys_fstat+0x50>
    return -1;
  return filestat(f, st);
80106284:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106287:	89 44 24 04          	mov    %eax,0x4(%esp)
8010628b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010628e:	89 04 24             	mov    %eax,(%esp)
80106291:	e8 6a ac ff ff       	call   80100f00 <filestat>
}
80106296:	c9                   	leave  
80106297:	c3                   	ret    
80106298:	90                   	nop
80106299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
801062a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
801062a5:	c9                   	leave  
801062a6:	c3                   	ret    
801062a7:	89 f6                	mov    %esi,%esi
801062a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801062b0 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
801062b0:	55                   	push   %ebp
801062b1:	89 e5                	mov    %esp,%ebp
801062b3:	57                   	push   %edi
801062b4:	56                   	push   %esi
801062b5:	53                   	push   %ebx
801062b6:	83 ec 3c             	sub    $0x3c,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801062b9:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801062bc:	89 44 24 04          	mov    %eax,0x4(%esp)
801062c0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801062c7:	e8 34 fb ff ff       	call   80105e00 <argstr>
801062cc:	85 c0                	test   %eax,%eax
801062ce:	0f 88 e5 00 00 00    	js     801063b9 <sys_link+0x109>
801062d4:	8d 45 d0             	lea    -0x30(%ebp),%eax
801062d7:	89 44 24 04          	mov    %eax,0x4(%esp)
801062db:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801062e2:	e8 19 fb ff ff       	call   80105e00 <argstr>
801062e7:	85 c0                	test   %eax,%eax
801062e9:	0f 88 ca 00 00 00    	js     801063b9 <sys_link+0x109>
    return -1;

  begin_op();
801062ef:	e8 0c c9 ff ff       	call   80102c00 <begin_op>
  if((ip = namei(old)) == 0){
801062f4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801062f7:	89 04 24             	mov    %eax,(%esp)
801062fa:	e8 91 bc ff ff       	call   80101f90 <namei>
801062ff:	85 c0                	test   %eax,%eax
80106301:	89 c3                	mov    %eax,%ebx
80106303:	0f 84 ab 00 00 00    	je     801063b4 <sys_link+0x104>
    end_op();
    return -1;
  }

  ilock(ip);
80106309:	89 04 24             	mov    %eax,(%esp)
8010630c:	e8 df b3 ff ff       	call   801016f0 <ilock>
  if(ip->type == T_DIR){
80106311:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106316:	0f 84 90 00 00 00    	je     801063ac <sys_link+0xfc>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
8010631c:	66 ff 43 56          	incw   0x56(%ebx)
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80106320:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80106323:	89 1c 24             	mov    %ebx,(%esp)
80106326:	e8 05 b3 ff ff       	call   80101630 <iupdate>
  iunlock(ip);
8010632b:	89 1c 24             	mov    %ebx,(%esp)
8010632e:	e8 9d b4 ff ff       	call   801017d0 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80106333:	8b 45 d0             	mov    -0x30(%ebp),%eax
80106336:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010633a:	89 04 24             	mov    %eax,(%esp)
8010633d:	e8 6e bc ff ff       	call   80101fb0 <nameiparent>
80106342:	85 c0                	test   %eax,%eax
80106344:	89 c6                	mov    %eax,%esi
80106346:	74 50                	je     80106398 <sys_link+0xe8>
    goto bad;
  ilock(dp);
80106348:	89 04 24             	mov    %eax,(%esp)
8010634b:	e8 a0 b3 ff ff       	call   801016f0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80106350:	8b 03                	mov    (%ebx),%eax
80106352:	39 06                	cmp    %eax,(%esi)
80106354:	75 3a                	jne    80106390 <sys_link+0xe0>
80106356:	8b 43 04             	mov    0x4(%ebx),%eax
80106359:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010635d:	89 34 24             	mov    %esi,(%esp)
80106360:	89 44 24 08          	mov    %eax,0x8(%esp)
80106364:	e8 47 bb ff ff       	call   80101eb0 <dirlink>
80106369:	85 c0                	test   %eax,%eax
8010636b:	78 23                	js     80106390 <sys_link+0xe0>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
8010636d:	89 34 24             	mov    %esi,(%esp)
80106370:	e8 0b b6 ff ff       	call   80101980 <iunlockput>
  iput(ip);
80106375:	89 1c 24             	mov    %ebx,(%esp)
80106378:	e8 a3 b4 ff ff       	call   80101820 <iput>

  end_op();
8010637d:	e8 ee c8 ff ff       	call   80102c70 <end_op>
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80106382:	83 c4 3c             	add    $0x3c,%esp
  iunlockput(dp);
  iput(ip);

  end_op();

  return 0;
80106385:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80106387:	5b                   	pop    %ebx
80106388:	5e                   	pop    %esi
80106389:	5f                   	pop    %edi
8010638a:	5d                   	pop    %ebp
8010638b:	c3                   	ret    
8010638c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80106390:	89 34 24             	mov    %esi,(%esp)
80106393:	e8 e8 b5 ff ff       	call   80101980 <iunlockput>
  end_op();

  return 0;

bad:
  ilock(ip);
80106398:	89 1c 24             	mov    %ebx,(%esp)
8010639b:	e8 50 b3 ff ff       	call   801016f0 <ilock>
  ip->nlink--;
801063a0:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
801063a4:	89 1c 24             	mov    %ebx,(%esp)
801063a7:	e8 84 b2 ff ff       	call   80101630 <iupdate>
  iunlockput(ip);
801063ac:	89 1c 24             	mov    %ebx,(%esp)
801063af:	e8 cc b5 ff ff       	call   80101980 <iunlockput>
  end_op();
801063b4:	e8 b7 c8 ff ff       	call   80102c70 <end_op>
  return -1;
}
801063b9:	83 c4 3c             	add    $0x3c,%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
801063bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801063c1:	5b                   	pop    %ebx
801063c2:	5e                   	pop    %esi
801063c3:	5f                   	pop    %edi
801063c4:	5d                   	pop    %ebp
801063c5:	c3                   	ret    
801063c6:	8d 76 00             	lea    0x0(%esi),%esi
801063c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801063d0 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
801063d0:	55                   	push   %ebp
801063d1:	89 e5                	mov    %esp,%ebp
801063d3:	57                   	push   %edi
801063d4:	56                   	push   %esi
801063d5:	53                   	push   %ebx
801063d6:	83 ec 5c             	sub    $0x5c,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
801063d9:	8d 45 c0             	lea    -0x40(%ebp),%eax
801063dc:	89 44 24 04          	mov    %eax,0x4(%esp)
801063e0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801063e7:	e8 14 fa ff ff       	call   80105e00 <argstr>
801063ec:	85 c0                	test   %eax,%eax
801063ee:	0f 88 75 01 00 00    	js     80106569 <sys_unlink+0x199>
    return -1;

  begin_op();
801063f4:	e8 07 c8 ff ff       	call   80102c00 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801063f9:	8b 45 c0             	mov    -0x40(%ebp),%eax
801063fc:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801063ff:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80106403:	89 04 24             	mov    %eax,(%esp)
80106406:	e8 a5 bb ff ff       	call   80101fb0 <nameiparent>
8010640b:	85 c0                	test   %eax,%eax
8010640d:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80106410:	0f 84 4e 01 00 00    	je     80106564 <sys_unlink+0x194>
    end_op();
    return -1;
  }

  ilock(dp);
80106416:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80106419:	89 34 24             	mov    %esi,(%esp)
8010641c:	e8 cf b2 ff ff       	call   801016f0 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80106421:	b8 3c 8f 10 80       	mov    $0x80108f3c,%eax
80106426:	89 44 24 04          	mov    %eax,0x4(%esp)
8010642a:	89 1c 24             	mov    %ebx,(%esp)
8010642d:	e8 ee b7 ff ff       	call   80101c20 <namecmp>
80106432:	85 c0                	test   %eax,%eax
80106434:	0f 84 1f 01 00 00    	je     80106559 <sys_unlink+0x189>
8010643a:	b8 3b 8f 10 80       	mov    $0x80108f3b,%eax
8010643f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106443:	89 1c 24             	mov    %ebx,(%esp)
80106446:	e8 d5 b7 ff ff       	call   80101c20 <namecmp>
8010644b:	85 c0                	test   %eax,%eax
8010644d:	0f 84 06 01 00 00    	je     80106559 <sys_unlink+0x189>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80106453:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80106456:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010645a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010645e:	89 34 24             	mov    %esi,(%esp)
80106461:	e8 ea b7 ff ff       	call   80101c50 <dirlookup>
80106466:	85 c0                	test   %eax,%eax
80106468:	89 c3                	mov    %eax,%ebx
8010646a:	0f 84 e9 00 00 00    	je     80106559 <sys_unlink+0x189>
    goto bad;
  ilock(ip);
80106470:	89 04 24             	mov    %eax,(%esp)
80106473:	e8 78 b2 ff ff       	call   801016f0 <ilock>

  if(ip->nlink < 1)
80106478:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010647d:	0f 8e 29 01 00 00    	jle    801065ac <sys_unlink+0x1dc>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80106483:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106488:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010648b:	74 7b                	je     80106508 <sys_unlink+0x138>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
8010648d:	31 d2                	xor    %edx,%edx
8010648f:	b8 10 00 00 00       	mov    $0x10,%eax
80106494:	89 54 24 04          	mov    %edx,0x4(%esp)
80106498:	89 44 24 08          	mov    %eax,0x8(%esp)
8010649c:	89 34 24             	mov    %esi,(%esp)
8010649f:	e8 bc f5 ff ff       	call   80105a60 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801064a4:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801064a7:	b9 10 00 00 00       	mov    $0x10,%ecx
801064ac:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
801064b0:	89 74 24 04          	mov    %esi,0x4(%esp)
801064b4:	89 44 24 08          	mov    %eax,0x8(%esp)
801064b8:	8b 45 b4             	mov    -0x4c(%ebp),%eax
801064bb:	89 04 24             	mov    %eax,(%esp)
801064be:	e8 1d b6 ff ff       	call   80101ae0 <writei>
801064c3:	83 f8 10             	cmp    $0x10,%eax
801064c6:	0f 85 d4 00 00 00    	jne    801065a0 <sys_unlink+0x1d0>
    panic("unlink: writei");
  if(ip->type == T_DIR){
801064cc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801064d1:	0f 84 a9 00 00 00    	je     80106580 <sys_unlink+0x1b0>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
801064d7:	8b 45 b4             	mov    -0x4c(%ebp),%eax
801064da:	89 04 24             	mov    %eax,(%esp)
801064dd:	e8 9e b4 ff ff       	call   80101980 <iunlockput>

  ip->nlink--;
801064e2:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
801064e6:	89 1c 24             	mov    %ebx,(%esp)
801064e9:	e8 42 b1 ff ff       	call   80101630 <iupdate>
  iunlockput(ip);
801064ee:	89 1c 24             	mov    %ebx,(%esp)
801064f1:	e8 8a b4 ff ff       	call   80101980 <iunlockput>

  end_op();
801064f6:	e8 75 c7 ff ff       	call   80102c70 <end_op>

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
801064fb:	83 c4 5c             	add    $0x5c,%esp
  iupdate(ip);
  iunlockput(ip);

  end_op();

  return 0;
801064fe:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80106500:	5b                   	pop    %ebx
80106501:	5e                   	pop    %esi
80106502:	5f                   	pop    %edi
80106503:	5d                   	pop    %ebp
80106504:	c3                   	ret    
80106505:	8d 76 00             	lea    0x0(%esi),%esi
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80106508:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
8010650c:	0f 86 7b ff ff ff    	jbe    8010648d <sys_unlink+0xbd>
80106512:	bf 20 00 00 00       	mov    $0x20,%edi
80106517:	eb 13                	jmp    8010652c <sys_unlink+0x15c>
80106519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106520:	83 c7 10             	add    $0x10,%edi
80106523:	3b 7b 58             	cmp    0x58(%ebx),%edi
80106526:	0f 83 61 ff ff ff    	jae    8010648d <sys_unlink+0xbd>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010652c:	b8 10 00 00 00       	mov    $0x10,%eax
80106531:	89 44 24 0c          	mov    %eax,0xc(%esp)
80106535:	89 7c 24 08          	mov    %edi,0x8(%esp)
80106539:	89 74 24 04          	mov    %esi,0x4(%esp)
8010653d:	89 1c 24             	mov    %ebx,(%esp)
80106540:	e8 8b b4 ff ff       	call   801019d0 <readi>
80106545:	83 f8 10             	cmp    $0x10,%eax
80106548:	75 4a                	jne    80106594 <sys_unlink+0x1c4>
      panic("isdirempty: readi");
    if(de.inum != 0)
8010654a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010654f:	74 cf                	je     80106520 <sys_unlink+0x150>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
80106551:	89 1c 24             	mov    %ebx,(%esp)
80106554:	e8 27 b4 ff ff       	call   80101980 <iunlockput>
  end_op();

  return 0;

bad:
  iunlockput(dp);
80106559:	8b 45 b4             	mov    -0x4c(%ebp),%eax
8010655c:	89 04 24             	mov    %eax,(%esp)
8010655f:	e8 1c b4 ff ff       	call   80101980 <iunlockput>
  end_op();
80106564:	e8 07 c7 ff ff       	call   80102c70 <end_op>
  return -1;
}
80106569:	83 c4 5c             	add    $0x5c,%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
8010656c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106571:	5b                   	pop    %ebx
80106572:	5e                   	pop    %esi
80106573:	5f                   	pop    %edi
80106574:	5d                   	pop    %ebp
80106575:	c3                   	ret    
80106576:	8d 76 00             	lea    0x0(%esi),%esi
80106579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80106580:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80106583:	66 ff 48 56          	decw   0x56(%eax)
    iupdate(dp);
80106587:	89 04 24             	mov    %eax,(%esp)
8010658a:	e8 a1 b0 ff ff       	call   80101630 <iupdate>
8010658f:	e9 43 ff ff ff       	jmp    801064d7 <sys_unlink+0x107>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
80106594:	c7 04 24 60 8f 10 80 	movl   $0x80108f60,(%esp)
8010659b:	e8 a0 9d ff ff       	call   80100340 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
801065a0:	c7 04 24 72 8f 10 80 	movl   $0x80108f72,(%esp)
801065a7:	e8 94 9d ff ff       	call   80100340 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
801065ac:	c7 04 24 4e 8f 10 80 	movl   $0x80108f4e,(%esp)
801065b3:	e8 88 9d ff ff       	call   80100340 <panic>
801065b8:	90                   	nop
801065b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801065c0 <sys_open>:
  return ip;
}

int
sys_open(void)
{
801065c0:	55                   	push   %ebp
801065c1:	89 e5                	mov    %esp,%ebp
801065c3:	57                   	push   %edi
801065c4:	56                   	push   %esi
801065c5:	53                   	push   %ebx
801065c6:	83 ec 2c             	sub    $0x2c,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801065c9:	8d 45 e0             	lea    -0x20(%ebp),%eax
801065cc:	89 44 24 04          	mov    %eax,0x4(%esp)
801065d0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801065d7:	e8 24 f8 ff ff       	call   80105e00 <argstr>
801065dc:	85 c0                	test   %eax,%eax
801065de:	0f 88 7f 00 00 00    	js     80106663 <sys_open+0xa3>
801065e4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801065e7:	89 44 24 04          	mov    %eax,0x4(%esp)
801065eb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801065f2:	e8 59 f7 ff ff       	call   80105d50 <argint>
801065f7:	85 c0                	test   %eax,%eax
801065f9:	78 68                	js     80106663 <sys_open+0xa3>
    return -1;

  begin_op();
801065fb:	e8 00 c6 ff ff       	call   80102c00 <begin_op>

  if(omode & O_CREATE){
80106600:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80106604:	75 6a                	jne    80106670 <sys_open+0xb0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80106606:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106609:	89 04 24             	mov    %eax,(%esp)
8010660c:	e8 7f b9 ff ff       	call   80101f90 <namei>
80106611:	85 c0                	test   %eax,%eax
80106613:	89 c6                	mov    %eax,%esi
80106615:	74 47                	je     8010665e <sys_open+0x9e>
      end_op();
      return -1;
    }
    ilock(ip);
80106617:	89 04 24             	mov    %eax,(%esp)
8010661a:	e8 d1 b0 ff ff       	call   801016f0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
8010661f:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80106624:	0f 84 a6 00 00 00    	je     801066d0 <sys_open+0x110>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010662a:	e8 31 a7 ff ff       	call   80100d60 <filealloc>
8010662f:	85 c0                	test   %eax,%eax
80106631:	89 c7                	mov    %eax,%edi
80106633:	74 21                	je     80106656 <sys_open+0x96>
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80106635:	e8 26 d3 ff ff       	call   80103960 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
8010663a:	31 db                	xor    %ebx,%ebx
8010663c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80106640:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80106644:	85 d2                	test   %edx,%edx
80106646:	74 48                	je     80106690 <sys_open+0xd0>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80106648:	43                   	inc    %ebx
80106649:	83 fb 10             	cmp    $0x10,%ebx
8010664c:	75 f2                	jne    80106640 <sys_open+0x80>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
8010664e:	89 3c 24             	mov    %edi,(%esp)
80106651:	e8 ca a7 ff ff       	call   80100e20 <fileclose>
    iunlockput(ip);
80106656:	89 34 24             	mov    %esi,(%esp)
80106659:	e8 22 b3 ff ff       	call   80101980 <iunlockput>
    end_op();
8010665e:	e8 0d c6 ff ff       	call   80102c70 <end_op>
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80106663:	83 c4 2c             	add    $0x2c,%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
80106666:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
8010666b:	5b                   	pop    %ebx
8010666c:	5e                   	pop    %esi
8010666d:	5f                   	pop    %edi
8010666e:	5d                   	pop    %ebp
8010666f:	c3                   	ret    
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80106670:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106673:	31 c9                	xor    %ecx,%ecx
80106675:	ba 02 00 00 00       	mov    $0x2,%edx
8010667a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106681:	e8 3a f8 ff ff       	call   80105ec0 <create>
    if(ip == 0){
80106686:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80106688:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010668a:	75 9e                	jne    8010662a <sys_open+0x6a>
8010668c:	eb d0                	jmp    8010665e <sys_open+0x9e>
8010668e:	66 90                	xchg   %ax,%ax
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80106690:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80106694:	89 34 24             	mov    %esi,(%esp)
80106697:	e8 34 b1 ff ff       	call   801017d0 <iunlock>
  end_op();
8010669c:	e8 cf c5 ff ff       	call   80102c70 <end_op>

  f->type = FD_INODE;
801066a1:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801066a7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
801066aa:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801066ad:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801066b4:	89 d0                	mov    %edx,%eax
801066b6:	83 e0 01             	and    $0x1,%eax
801066b9:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801066bc:	f6 c2 03             	test   $0x3,%dl
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801066bf:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
801066c2:	89 d8                	mov    %ebx,%eax

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801066c4:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801066c8:	83 c4 2c             	add    $0x2c,%esp
801066cb:	5b                   	pop    %ebx
801066cc:	5e                   	pop    %esi
801066cd:	5f                   	pop    %edi
801066ce:	5d                   	pop    %ebp
801066cf:	c3                   	ret    
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
801066d0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801066d3:	85 c9                	test   %ecx,%ecx
801066d5:	0f 84 4f ff ff ff    	je     8010662a <sys_open+0x6a>
801066db:	e9 76 ff ff ff       	jmp    80106656 <sys_open+0x96>

801066e0 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
801066e0:	55                   	push   %ebp
801066e1:	89 e5                	mov    %esp,%ebp
801066e3:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
801066e6:	e8 15 c5 ff ff       	call   80102c00 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801066eb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801066ee:	89 44 24 04          	mov    %eax,0x4(%esp)
801066f2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801066f9:	e8 02 f7 ff ff       	call   80105e00 <argstr>
801066fe:	85 c0                	test   %eax,%eax
80106700:	78 2e                	js     80106730 <sys_mkdir+0x50>
80106702:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106705:	31 c9                	xor    %ecx,%ecx
80106707:	ba 01 00 00 00       	mov    $0x1,%edx
8010670c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106713:	e8 a8 f7 ff ff       	call   80105ec0 <create>
80106718:	85 c0                	test   %eax,%eax
8010671a:	74 14                	je     80106730 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010671c:	89 04 24             	mov    %eax,(%esp)
8010671f:	e8 5c b2 ff ff       	call   80101980 <iunlockput>
  end_op();
80106724:	e8 47 c5 ff ff       	call   80102c70 <end_op>
  return 0;
80106729:	31 c0                	xor    %eax,%eax
}
8010672b:	c9                   	leave  
8010672c:	c3                   	ret    
8010672d:	8d 76 00             	lea    0x0(%esi),%esi
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
80106730:	e8 3b c5 ff ff       	call   80102c70 <end_op>
    return -1;
80106735:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010673a:	c9                   	leave  
8010673b:	c3                   	ret    
8010673c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106740 <sys_mknod>:

int
sys_mknod(void)
{
80106740:	55                   	push   %ebp
80106741:	89 e5                	mov    %esp,%ebp
80106743:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80106746:	e8 b5 c4 ff ff       	call   80102c00 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010674b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010674e:	89 44 24 04          	mov    %eax,0x4(%esp)
80106752:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106759:	e8 a2 f6 ff ff       	call   80105e00 <argstr>
8010675e:	85 c0                	test   %eax,%eax
80106760:	78 5e                	js     801067c0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80106762:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106765:	89 44 24 04          	mov    %eax,0x4(%esp)
80106769:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106770:	e8 db f5 ff ff       	call   80105d50 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
80106775:	85 c0                	test   %eax,%eax
80106777:	78 47                	js     801067c0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80106779:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010677c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106780:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106787:	e8 c4 f5 ff ff       	call   80105d50 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
8010678c:	85 c0                	test   %eax,%eax
8010678e:	78 30                	js     801067c0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80106790:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80106794:	ba 03 00 00 00       	mov    $0x3,%edx
80106799:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
8010679d:	89 04 24             	mov    %eax,(%esp)
801067a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801067a3:	e8 18 f7 ff ff       	call   80105ec0 <create>
801067a8:	85 c0                	test   %eax,%eax
801067aa:	74 14                	je     801067c0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
801067ac:	89 04 24             	mov    %eax,(%esp)
801067af:	e8 cc b1 ff ff       	call   80101980 <iunlockput>
  end_op();
801067b4:	e8 b7 c4 ff ff       	call   80102c70 <end_op>
  return 0;
801067b9:	31 c0                	xor    %eax,%eax
}
801067bb:	c9                   	leave  
801067bc:	c3                   	ret    
801067bd:	8d 76 00             	lea    0x0(%esi),%esi
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
801067c0:	e8 ab c4 ff ff       	call   80102c70 <end_op>
    return -1;
801067c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
801067ca:	c9                   	leave  
801067cb:	c3                   	ret    
801067cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801067d0 <sys_chdir>:

int
sys_chdir(void)
{
801067d0:	55                   	push   %ebp
801067d1:	89 e5                	mov    %esp,%ebp
801067d3:	56                   	push   %esi
801067d4:	53                   	push   %ebx
801067d5:	83 ec 20             	sub    $0x20,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801067d8:	e8 83 d1 ff ff       	call   80103960 <myproc>
801067dd:	89 c6                	mov    %eax,%esi
  
  begin_op();
801067df:	e8 1c c4 ff ff       	call   80102c00 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801067e4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801067e7:	89 44 24 04          	mov    %eax,0x4(%esp)
801067eb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801067f2:	e8 09 f6 ff ff       	call   80105e00 <argstr>
801067f7:	85 c0                	test   %eax,%eax
801067f9:	78 4a                	js     80106845 <sys_chdir+0x75>
801067fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067fe:	89 04 24             	mov    %eax,(%esp)
80106801:	e8 8a b7 ff ff       	call   80101f90 <namei>
80106806:	85 c0                	test   %eax,%eax
80106808:	89 c3                	mov    %eax,%ebx
8010680a:	74 39                	je     80106845 <sys_chdir+0x75>
    end_op();
    return -1;
  }
  ilock(ip);
8010680c:	89 04 24             	mov    %eax,(%esp)
8010680f:	e8 dc ae ff ff       	call   801016f0 <ilock>
  if(ip->type != T_DIR){
80106814:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
    iunlockput(ip);
80106819:	89 1c 24             	mov    %ebx,(%esp)
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
8010681c:	75 22                	jne    80106840 <sys_chdir+0x70>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
8010681e:	e8 ad af ff ff       	call   801017d0 <iunlock>
  iput(curproc->cwd);
80106823:	8b 46 68             	mov    0x68(%esi),%eax
80106826:	89 04 24             	mov    %eax,(%esp)
80106829:	e8 f2 af ff ff       	call   80101820 <iput>
  end_op();
8010682e:	e8 3d c4 ff ff       	call   80102c70 <end_op>
  curproc->cwd = ip;
  return 0;
80106833:	31 c0                	xor    %eax,%eax
    return -1;
  }
  iunlock(ip);
  iput(curproc->cwd);
  end_op();
  curproc->cwd = ip;
80106835:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
}
80106838:	83 c4 20             	add    $0x20,%esp
8010683b:	5b                   	pop    %ebx
8010683c:	5e                   	pop    %esi
8010683d:	5d                   	pop    %ebp
8010683e:	c3                   	ret    
8010683f:	90                   	nop
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
80106840:	e8 3b b1 ff ff       	call   80101980 <iunlockput>
    end_op();
80106845:	e8 26 c4 ff ff       	call   80102c70 <end_op>
  iunlock(ip);
  iput(curproc->cwd);
  end_op();
  curproc->cwd = ip;
  return 0;
}
8010684a:	83 c4 20             	add    $0x20,%esp
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
    end_op();
    return -1;
8010684d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  iunlock(ip);
  iput(curproc->cwd);
  end_op();
  curproc->cwd = ip;
  return 0;
}
80106852:	5b                   	pop    %ebx
80106853:	5e                   	pop    %esi
80106854:	5d                   	pop    %ebp
80106855:	c3                   	ret    
80106856:	8d 76 00             	lea    0x0(%esi),%esi
80106859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106860 <sys_exec>:

int
sys_exec(void)
{
80106860:	55                   	push   %ebp
80106861:	89 e5                	mov    %esp,%ebp
80106863:	57                   	push   %edi
80106864:	56                   	push   %esi
80106865:	53                   	push   %ebx
80106866:	81 ec ac 00 00 00    	sub    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
8010686c:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80106872:	89 44 24 04          	mov    %eax,0x4(%esp)
80106876:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010687d:	e8 7e f5 ff ff       	call   80105e00 <argstr>
80106882:	85 c0                	test   %eax,%eax
80106884:	0f 88 82 00 00 00    	js     8010690c <sys_exec+0xac>
8010688a:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80106890:	89 44 24 04          	mov    %eax,0x4(%esp)
80106894:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010689b:	e8 b0 f4 ff ff       	call   80105d50 <argint>
801068a0:	85 c0                	test   %eax,%eax
801068a2:	78 68                	js     8010690c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801068a4:	ba 80 00 00 00       	mov    $0x80,%edx
801068a9:	31 c9                	xor    %ecx,%ecx
801068ab:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801068b1:	31 db                	xor    %ebx,%ebx
801068b3:	89 54 24 08          	mov    %edx,0x8(%esp)
801068b7:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
801068bd:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801068c1:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801068c7:	89 04 24             	mov    %eax,(%esp)
801068ca:	e8 91 f1 ff ff       	call   80105a60 <memset>
801068cf:	90                   	nop
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801068d0:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801068d6:	89 7c 24 04          	mov    %edi,0x4(%esp)
801068da:	8d 04 98             	lea    (%eax,%ebx,4),%eax
801068dd:	89 04 24             	mov    %eax,(%esp)
801068e0:	e8 db f3 ff ff       	call   80105cc0 <fetchint>
801068e5:	85 c0                	test   %eax,%eax
801068e7:	78 23                	js     8010690c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
801068e9:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801068ef:	85 c0                	test   %eax,%eax
801068f1:	74 2d                	je     80106920 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801068f3:	89 74 24 04          	mov    %esi,0x4(%esp)
801068f7:	89 04 24             	mov    %eax,(%esp)
801068fa:	e8 01 f4 ff ff       	call   80105d00 <fetchstr>
801068ff:	85 c0                	test   %eax,%eax
80106901:	78 09                	js     8010690c <sys_exec+0xac>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80106903:	43                   	inc    %ebx
80106904:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
80106907:	83 fb 20             	cmp    $0x20,%ebx
8010690a:	75 c4                	jne    801068d0 <sys_exec+0x70>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
8010690c:	81 c4 ac 00 00 00    	add    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
80106912:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80106917:	5b                   	pop    %ebx
80106918:	5e                   	pop    %esi
80106919:	5f                   	pop    %edi
8010691a:	5d                   	pop    %ebp
8010691b:	c3                   	ret    
8010691c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
80106920:	31 c0                	xor    %eax,%eax
80106922:	89 84 9d 68 ff ff ff 	mov    %eax,-0x98(%ebp,%ebx,4)
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80106929:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010692f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106933:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
80106939:	89 04 24             	mov    %eax,(%esp)
8010693c:	e8 6f a0 ff ff       	call   801009b0 <exec>
}
80106941:	81 c4 ac 00 00 00    	add    $0xac,%esp
80106947:	5b                   	pop    %ebx
80106948:	5e                   	pop    %esi
80106949:	5f                   	pop    %edi
8010694a:	5d                   	pop    %ebp
8010694b:	c3                   	ret    
8010694c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106950 <sys_pipe>:

int
sys_pipe(void)
{
80106950:	55                   	push   %ebp
80106951:	89 e5                	mov    %esp,%ebp
80106953:	57                   	push   %edi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106954:	bf 08 00 00 00       	mov    $0x8,%edi
  return exec(path, argv);
}

int
sys_pipe(void)
{
80106959:	56                   	push   %esi
8010695a:	53                   	push   %ebx
8010695b:	83 ec 2c             	sub    $0x2c,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010695e:	8d 45 dc             	lea    -0x24(%ebp),%eax
80106961:	89 7c 24 08          	mov    %edi,0x8(%esp)
80106965:	89 44 24 04          	mov    %eax,0x4(%esp)
80106969:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106970:	e8 2b f4 ff ff       	call   80105da0 <argptr>
80106975:	85 c0                	test   %eax,%eax
80106977:	78 4b                	js     801069c4 <sys_pipe+0x74>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80106979:	8d 45 e4             	lea    -0x1c(%ebp),%eax
8010697c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106980:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106983:	89 04 24             	mov    %eax,(%esp)
80106986:	e8 75 c9 ff ff       	call   80103300 <pipealloc>
8010698b:	85 c0                	test   %eax,%eax
8010698d:	78 35                	js     801069c4 <sys_pipe+0x74>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010698f:	8b 7d e0             	mov    -0x20(%ebp),%edi
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80106992:	31 db                	xor    %ebx,%ebx
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80106994:	e8 c7 cf ff ff       	call   80103960 <myproc>
80106999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
801069a0:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801069a4:	85 f6                	test   %esi,%esi
801069a6:	74 30                	je     801069d8 <sys_pipe+0x88>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801069a8:	43                   	inc    %ebx
801069a9:	83 fb 10             	cmp    $0x10,%ebx
801069ac:	75 f2                	jne    801069a0 <sys_pipe+0x50>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
801069ae:	8b 45 e0             	mov    -0x20(%ebp),%eax
801069b1:	89 04 24             	mov    %eax,(%esp)
801069b4:	e8 67 a4 ff ff       	call   80100e20 <fileclose>
    fileclose(wf);
801069b9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801069bc:	89 04 24             	mov    %eax,(%esp)
801069bf:	e8 5c a4 ff ff       	call   80100e20 <fileclose>
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
801069c4:	83 c4 2c             	add    $0x2c,%esp
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
801069c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
801069cc:	5b                   	pop    %ebx
801069cd:	5e                   	pop    %esi
801069ce:	5f                   	pop    %edi
801069cf:	5d                   	pop    %ebp
801069d0:	c3                   	ret    
801069d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
801069d8:	8d 73 08             	lea    0x8(%ebx),%esi
801069db:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801069df:	8b 7d e4             	mov    -0x1c(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801069e2:	e8 79 cf ff ff       	call   80103960 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
801069e7:	31 d2                	xor    %edx,%edx
801069e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801069f0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801069f4:	85 c9                	test   %ecx,%ecx
801069f6:	74 18                	je     80106a10 <sys_pipe+0xc0>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801069f8:	42                   	inc    %edx
801069f9:	83 fa 10             	cmp    $0x10,%edx
801069fc:	75 f2                	jne    801069f0 <sys_pipe+0xa0>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
801069fe:	e8 5d cf ff ff       	call   80103960 <myproc>
80106a03:	31 d2                	xor    %edx,%edx
80106a05:	89 54 b0 08          	mov    %edx,0x8(%eax,%esi,4)
80106a09:	eb a3                	jmp    801069ae <sys_pipe+0x5e>
80106a0b:	90                   	nop
80106a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80106a10:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80106a14:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106a17:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106a19:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106a1c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
}
80106a1f:	83 c4 2c             	add    $0x2c,%esp
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
80106a22:	31 c0                	xor    %eax,%eax
}
80106a24:	5b                   	pop    %ebx
80106a25:	5e                   	pop    %esi
80106a26:	5f                   	pop    %edi
80106a27:	5d                   	pop    %ebp
80106a28:	c3                   	ret    
80106a29:	66 90                	xchg   %ax,%ax
80106a2b:	66 90                	xchg   %ax,%ax
80106a2d:	66 90                	xchg   %ax,%ax
80106a2f:	90                   	nop

80106a30 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106a30:	55                   	push   %ebp
80106a31:	89 e5                	mov    %esp,%ebp
  return fork();
}
80106a33:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80106a34:	e9 07 d2 ff ff       	jmp    80103c40 <fork>
80106a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106a40 <sys_exit>:
}

int
sys_exit(void)
{
80106a40:	55                   	push   %ebp
80106a41:	89 e5                	mov    %esp,%ebp
80106a43:	83 ec 28             	sub    $0x28,%esp
    int stat;

    if(argint(0, &stat) < 0)
80106a46:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106a49:	89 44 24 04          	mov    %eax,0x4(%esp)
80106a4d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106a54:	e8 f7 f2 ff ff       	call   80105d50 <argint>
80106a59:	85 c0                	test   %eax,%eax
80106a5b:	78 13                	js     80106a70 <sys_exit+0x30>
        return -1;
    exit(stat);
80106a5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a60:	89 04 24             	mov    %eax,(%esp)
80106a63:	e8 a8 d6 ff ff       	call   80104110 <exit>
    return 0;
80106a68:	31 c0                	xor    %eax,%eax
}
80106a6a:	c9                   	leave  
80106a6b:	c3                   	ret    
80106a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
sys_exit(void)
{
    int stat;

    if(argint(0, &stat) < 0)
        return -1;
80106a70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    exit(stat);
    return 0;
}
80106a75:	c9                   	leave  
80106a76:	c3                   	ret    
80106a77:	89 f6                	mov    %esi,%esi
80106a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106a80 <sys_wait>:

int
sys_wait(void)
{
80106a80:	55                   	push   %ebp
    int *status;

    if(argptr(0, (void*)&status, sizeof(*status)) < 0)
80106a81:	b8 04 00 00 00       	mov    $0x4,%eax
    return 0;
}

int
sys_wait(void)
{
80106a86:	89 e5                	mov    %esp,%ebp
80106a88:	83 ec 28             	sub    $0x28,%esp
    int *status;

    if(argptr(0, (void*)&status, sizeof(*status)) < 0)
80106a8b:	89 44 24 08          	mov    %eax,0x8(%esp)
80106a8f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106a92:	89 44 24 04          	mov    %eax,0x4(%esp)
80106a96:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106a9d:	e8 fe f2 ff ff       	call   80105da0 <argptr>
80106aa2:	85 c0                	test   %eax,%eax
80106aa4:	78 12                	js     80106ab8 <sys_wait+0x38>
        return -1;
    return wait(status);
80106aa6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106aa9:	89 04 24             	mov    %eax,(%esp)
80106aac:	e8 4f d9 ff ff       	call   80104400 <wait>
}
80106ab1:	c9                   	leave  
80106ab2:	c3                   	ret    
80106ab3:	90                   	nop
80106ab4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
sys_wait(void)
{
    int *status;

    if(argptr(0, (void*)&status, sizeof(*status)) < 0)
        return -1;
80106ab8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return wait(status);
}
80106abd:	c9                   	leave  
80106abe:	c3                   	ret    
80106abf:	90                   	nop

80106ac0 <sys_kill>:

int
sys_kill(void)
{
80106ac0:	55                   	push   %ebp
80106ac1:	89 e5                	mov    %esp,%ebp
80106ac3:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106ac6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106ac9:	89 44 24 04          	mov    %eax,0x4(%esp)
80106acd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106ad4:	e8 77 f2 ff ff       	call   80105d50 <argint>
80106ad9:	85 c0                	test   %eax,%eax
80106adb:	78 13                	js     80106af0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80106add:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ae0:	89 04 24             	mov    %eax,(%esp)
80106ae3:	e8 78 da ff ff       	call   80104560 <kill>
}
80106ae8:	c9                   	leave  
80106ae9:	c3                   	ret    
80106aea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
80106af0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
80106af5:	c9                   	leave  
80106af6:	c3                   	ret    
80106af7:	89 f6                	mov    %esi,%esi
80106af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b00 <sys_getpid>:

int
sys_getpid(void)
{
80106b00:	55                   	push   %ebp
80106b01:	89 e5                	mov    %esp,%ebp
80106b03:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106b06:	e8 55 ce ff ff       	call   80103960 <myproc>
80106b0b:	8b 40 10             	mov    0x10(%eax),%eax
}
80106b0e:	c9                   	leave  
80106b0f:	c3                   	ret    

80106b10 <sys_sbrk>:

int
sys_sbrk(void)
{
80106b10:	55                   	push   %ebp
80106b11:	89 e5                	mov    %esp,%ebp
80106b13:	53                   	push   %ebx
80106b14:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106b17:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106b1a:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b1e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106b25:	e8 26 f2 ff ff       	call   80105d50 <argint>
80106b2a:	85 c0                	test   %eax,%eax
80106b2c:	78 22                	js     80106b50 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106b2e:	e8 2d ce ff ff       	call   80103960 <myproc>
80106b33:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106b35:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b38:	89 04 24             	mov    %eax,(%esp)
80106b3b:	e8 70 d0 ff ff       	call   80103bb0 <growproc>
80106b40:	85 c0                	test   %eax,%eax
80106b42:	78 0c                	js     80106b50 <sys_sbrk+0x40>
    return -1;
  return addr;
80106b44:	89 d8                	mov    %ebx,%eax
}
80106b46:	83 c4 24             	add    $0x24,%esp
80106b49:	5b                   	pop    %ebx
80106b4a:	5d                   	pop    %ebp
80106b4b:	c3                   	ret    
80106b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80106b50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106b55:	eb ef                	jmp    80106b46 <sys_sbrk+0x36>
80106b57:	89 f6                	mov    %esi,%esi
80106b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b60 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
80106b60:	55                   	push   %ebp
80106b61:	89 e5                	mov    %esp,%ebp
80106b63:	53                   	push   %ebx
80106b64:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106b67:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106b6a:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b6e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106b75:	e8 d6 f1 ff ff       	call   80105d50 <argint>
80106b7a:	85 c0                	test   %eax,%eax
80106b7c:	78 7e                	js     80106bfc <sys_sleep+0x9c>
    return -1;
  acquire(&tickslock);
80106b7e:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80106b85:	e8 e6 ed ff ff       	call   80105970 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106b8a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
80106b8d:	8b 1d 00 80 11 80    	mov    0x80118000,%ebx
  while(ticks - ticks0 < n){
80106b93:	85 c9                	test   %ecx,%ecx
80106b95:	75 2a                	jne    80106bc1 <sys_sleep+0x61>
80106b97:	eb 4f                	jmp    80106be8 <sys_sleep+0x88>
80106b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106ba0:	b8 c0 77 11 80       	mov    $0x801177c0,%eax
80106ba5:	89 44 24 04          	mov    %eax,0x4(%esp)
80106ba9:	c7 04 24 00 80 11 80 	movl   $0x80118000,(%esp)
80106bb0:	e8 5b d7 ff ff       	call   80104310 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106bb5:	a1 00 80 11 80       	mov    0x80118000,%eax
80106bba:	29 d8                	sub    %ebx,%eax
80106bbc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80106bbf:	73 27                	jae    80106be8 <sys_sleep+0x88>
    if(myproc()->killed){
80106bc1:	e8 9a cd ff ff       	call   80103960 <myproc>
80106bc6:	8b 50 24             	mov    0x24(%eax),%edx
80106bc9:	85 d2                	test   %edx,%edx
80106bcb:	74 d3                	je     80106ba0 <sys_sleep+0x40>
      release(&tickslock);
80106bcd:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80106bd4:	e8 37 ee ff ff       	call   80105a10 <release>
      return -1;
80106bd9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
80106bde:	83 c4 24             	add    $0x24,%esp
80106be1:	5b                   	pop    %ebx
80106be2:	5d                   	pop    %ebp
80106be3:	c3                   	ret    
80106be4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80106be8:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80106bef:	e8 1c ee ff ff       	call   80105a10 <release>
  return 0;
}
80106bf4:	83 c4 24             	add    $0x24,%esp
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
80106bf7:	31 c0                	xor    %eax,%eax
}
80106bf9:	5b                   	pop    %ebx
80106bfa:	5d                   	pop    %ebp
80106bfb:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
80106bfc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106c01:	eb db                	jmp    80106bde <sys_sleep+0x7e>
80106c03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c10 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106c10:	55                   	push   %ebp
80106c11:	89 e5                	mov    %esp,%ebp
80106c13:	53                   	push   %ebx
80106c14:	83 ec 14             	sub    $0x14,%esp
  uint xticks;

  acquire(&tickslock);
80106c17:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80106c1e:	e8 4d ed ff ff       	call   80105970 <acquire>
  xticks = ticks;
80106c23:	8b 1d 00 80 11 80    	mov    0x80118000,%ebx
  release(&tickslock);
80106c29:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80106c30:	e8 db ed ff ff       	call   80105a10 <release>
  return xticks;
}
80106c35:	83 c4 14             	add    $0x14,%esp
80106c38:	89 d8                	mov    %ebx,%eax
80106c3a:	5b                   	pop    %ebx
80106c3b:	5d                   	pop    %ebp
80106c3c:	c3                   	ret    
80106c3d:	8d 76 00             	lea    0x0(%esi),%esi

80106c40 <sys_detach>:

int
sys_detach(void){
80106c40:	55                   	push   %ebp
80106c41:	89 e5                	mov    %esp,%ebp
80106c43:	83 ec 28             	sub    $0x28,%esp
    int pid;
  if(argint(0, &pid) < 0)
80106c46:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106c49:	89 44 24 04          	mov    %eax,0x4(%esp)
80106c4d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106c54:	e8 f7 f0 ff ff       	call   80105d50 <argint>
80106c59:	85 c0                	test   %eax,%eax
80106c5b:	78 13                	js     80106c70 <sys_detach+0x30>
    return -1;
  return detach(pid);
80106c5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106c60:	89 04 24             	mov    %eax,(%esp)
80106c63:	e8 88 da ff ff       	call   801046f0 <detach>
}
80106c68:	c9                   	leave  
80106c69:	c3                   	ret    
80106c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

int
sys_detach(void){
    int pid;
  if(argint(0, &pid) < 0)
    return -1;
80106c70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return detach(pid);
}
80106c75:	c9                   	leave  
80106c76:	c3                   	ret    
80106c77:	89 f6                	mov    %esi,%esi
80106c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c80 <sys_priority>:
//TODO -need to understand how to call this sys_call
int
sys_priority(void){
80106c80:	55                   	push   %ebp
80106c81:	89 e5                	mov    %esp,%ebp
80106c83:	83 ec 28             	sub    $0x28,%esp
  int pid;
  if(argint(0, &pid) < 0)
80106c86:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106c89:	89 44 24 04          	mov    %eax,0x4(%esp)
80106c8d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106c94:	e8 b7 f0 ff ff       	call   80105d50 <argint>
80106c99:	85 c0                	test   %eax,%eax
80106c9b:	78 13                	js     80106cb0 <sys_priority+0x30>
    return -1;
  priority(pid);
80106c9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ca0:	89 04 24             	mov    %eax,(%esp)
80106ca3:	e8 c8 da ff ff       	call   80104770 <priority>
  return 0;
80106ca8:	31 c0                	xor    %eax,%eax
}
80106caa:	c9                   	leave  
80106cab:	c3                   	ret    
80106cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
//TODO -need to understand how to call this sys_call
int
sys_priority(void){
  int pid;
  if(argint(0, &pid) < 0)
    return -1;
80106cb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  priority(pid);
  return 0;
}
80106cb5:	c9                   	leave  
80106cb6:	c3                   	ret    
80106cb7:	89 f6                	mov    %esi,%esi
80106cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106cc0 <sys_policy>:

int
sys_policy(void){
80106cc0:	55                   	push   %ebp
80106cc1:	89 e5                	mov    %esp,%ebp
80106cc3:	83 ec 28             	sub    $0x28,%esp
    int pid;
    if(argint(0, &pid) < 0)
80106cc6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106cc9:	89 44 24 04          	mov    %eax,0x4(%esp)
80106ccd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106cd4:	e8 77 f0 ff ff       	call   80105d50 <argint>
80106cd9:	85 c0                	test   %eax,%eax
80106cdb:	78 13                	js     80106cf0 <sys_policy+0x30>
        return -1;
    policy(pid);
80106cdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ce0:	89 04 24             	mov    %eax,(%esp)
80106ce3:	e8 88 db ff ff       	call   80104870 <policy>
    return 0;
80106ce8:	31 c0                	xor    %eax,%eax
}
80106cea:	c9                   	leave  
80106ceb:	c3                   	ret    
80106cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

int
sys_policy(void){
    int pid;
    if(argint(0, &pid) < 0)
        return -1;
80106cf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    policy(pid);
    return 0;
}
80106cf5:	c9                   	leave  
80106cf6:	c3                   	ret    
80106cf7:	89 f6                	mov    %esi,%esi
80106cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d00 <sys_wait_stat>:


int
sys_wait_stat(void)
{
80106d00:	55                   	push   %ebp
  //TODO - add perf struct to the args of the function
  return 0;
}
80106d01:	31 c0                	xor    %eax,%eax
}


int
sys_wait_stat(void)
{
80106d03:	89 e5                	mov    %esp,%ebp
  //TODO - add perf struct to the args of the function
  return 0;
}
80106d05:	5d                   	pop    %ebp
80106d06:	c3                   	ret    

80106d07 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106d07:	1e                   	push   %ds
  pushl %es
80106d08:	06                   	push   %es
  pushl %fs
80106d09:	0f a0                	push   %fs
  pushl %gs
80106d0b:	0f a8                	push   %gs
  pushal
80106d0d:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106d0e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106d12:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106d14:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106d16:	54                   	push   %esp
  call trap
80106d17:	e8 e4 00 00 00       	call   80106e00 <trap>
  addl $4, %esp
80106d1c:	83 c4 04             	add    $0x4,%esp

80106d1f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106d1f:	61                   	popa   
  popl %gs
80106d20:	0f a9                	pop    %gs
  popl %fs
80106d22:	0f a1                	pop    %fs
  popl %es
80106d24:	07                   	pop    %es
  popl %ds
80106d25:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106d26:	83 c4 08             	add    $0x8,%esp
  iret
80106d29:	cf                   	iret   
80106d2a:	66 90                	xchg   %ax,%ax
80106d2c:	66 90                	xchg   %ax,%ax
80106d2e:	66 90                	xchg   %ax,%ax

80106d30 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80106d30:	31 c0                	xor    %eax,%eax
80106d32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106d40:	8b 14 85 0c c0 10 80 	mov    -0x7fef3ff4(,%eax,4),%edx
80106d47:	b9 08 00 00 00       	mov    $0x8,%ecx
80106d4c:	66 89 0c c5 02 78 11 	mov    %cx,-0x7fee87fe(,%eax,8)
80106d53:	80 
80106d54:	31 c9                	xor    %ecx,%ecx
80106d56:	88 0c c5 04 78 11 80 	mov    %cl,-0x7fee87fc(,%eax,8)
80106d5d:	b1 8e                	mov    $0x8e,%cl
80106d5f:	88 0c c5 05 78 11 80 	mov    %cl,-0x7fee87fb(,%eax,8)
80106d66:	66 89 14 c5 00 78 11 	mov    %dx,-0x7fee8800(,%eax,8)
80106d6d:	80 
80106d6e:	c1 ea 10             	shr    $0x10,%edx
80106d71:	66 89 14 c5 06 78 11 	mov    %dx,-0x7fee87fa(,%eax,8)
80106d78:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80106d79:	40                   	inc    %eax
80106d7a:	3d 00 01 00 00       	cmp    $0x100,%eax
80106d7f:	75 bf                	jne    80106d40 <tvinit+0x10>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106d81:	55                   	push   %ebp

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80106d82:	b9 81 8f 10 80       	mov    $0x80108f81,%ecx
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106d87:	89 e5                	mov    %esp,%ebp
80106d89:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106d8c:	a1 0c c1 10 80       	mov    0x8010c10c,%eax
80106d91:	ba 08 00 00 00       	mov    $0x8,%edx

  initlock(&tickslock, "time");
80106d96:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80106d9a:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106da1:	66 89 15 02 7a 11 80 	mov    %dx,0x80117a02
80106da8:	66 a3 00 7a 11 80    	mov    %ax,0x80117a00
80106dae:	c1 e8 10             	shr    $0x10,%eax
80106db1:	c6 05 04 7a 11 80 00 	movb   $0x0,0x80117a04
80106db8:	c6 05 05 7a 11 80 ef 	movb   $0xef,0x80117a05
80106dbf:	66 a3 06 7a 11 80    	mov    %ax,0x80117a06

  initlock(&tickslock, "time");
80106dc5:	e8 46 ea ff ff       	call   80105810 <initlock>
}
80106dca:	c9                   	leave  
80106dcb:	c3                   	ret    
80106dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106dd0 <idtinit>:

void
idtinit(void)
{
80106dd0:	55                   	push   %ebp
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  pd[1] = (uint)p;
80106dd1:	b8 00 78 11 80       	mov    $0x80117800,%eax
80106dd6:	89 e5                	mov    %esp,%ebp
80106dd8:	0f b7 d0             	movzwl %ax,%edx
  pd[2] = (uint)p >> 16;
80106ddb:	c1 e8 10             	shr    $0x10,%eax
80106dde:	83 ec 10             	sub    $0x10,%esp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106de1:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
80106de7:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106deb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80106def:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106df2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106df5:	c9                   	leave  
80106df6:	c3                   	ret    
80106df7:	89 f6                	mov    %esi,%esi
80106df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e00 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106e00:	55                   	push   %ebp
80106e01:	89 e5                	mov    %esp,%ebp
80106e03:	83 ec 48             	sub    $0x48,%esp
80106e06:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80106e09:	8b 5d 08             	mov    0x8(%ebp),%ebx
80106e0c:	89 75 f8             	mov    %esi,-0x8(%ebp)
80106e0f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(tf->trapno == T_SYSCALL){
80106e12:	8b 43 30             	mov    0x30(%ebx),%eax
80106e15:	83 f8 40             	cmp    $0x40,%eax
80106e18:	0f 84 b2 01 00 00    	je     80106fd0 <trap+0x1d0>
    if(myproc()->killed)
      exit(0);
    return;
  }

  switch(tf->trapno){
80106e1e:	83 e8 20             	sub    $0x20,%eax
80106e21:	83 f8 1f             	cmp    $0x1f,%eax
80106e24:	77 0a                	ja     80106e30 <trap+0x30>
80106e26:	ff 24 85 28 90 10 80 	jmp    *-0x7fef6fd8(,%eax,4)
80106e2d:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80106e30:	e8 2b cb ff ff       	call   80103960 <myproc>
80106e35:	85 c0                	test   %eax,%eax
80106e37:	0f 84 22 02 00 00    	je     8010705f <trap+0x25f>
80106e3d:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106e41:	0f 84 18 02 00 00    	je     8010705f <trap+0x25f>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106e47:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106e4a:	8b 53 38             	mov    0x38(%ebx),%edx
80106e4d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80106e50:	89 55 dc             	mov    %edx,-0x24(%ebp)
80106e53:	e8 e8 ca ff ff       	call   80103940 <cpuid>
80106e58:	8b 73 30             	mov    0x30(%ebx),%esi
80106e5b:	89 c7                	mov    %eax,%edi
80106e5d:	8b 43 34             	mov    0x34(%ebx),%eax
80106e60:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106e63:	e8 f8 ca ff ff       	call   80103960 <myproc>
80106e68:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106e6b:	e8 f0 ca ff ff       	call   80103960 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106e70:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106e73:	89 74 24 0c          	mov    %esi,0xc(%esp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106e77:	8b 75 e0             	mov    -0x20(%ebp),%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106e7a:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106e7d:	89 7c 24 14          	mov    %edi,0x14(%esp)
80106e81:	89 54 24 18          	mov    %edx,0x18(%esp)
80106e85:	8b 55 e4             	mov    -0x1c(%ebp),%edx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106e88:	83 c6 6c             	add    $0x6c,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106e8b:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106e8f:	89 74 24 08          	mov    %esi,0x8(%esp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106e93:	89 54 24 10          	mov    %edx,0x10(%esp)
80106e97:	8b 40 10             	mov    0x10(%eax),%eax
80106e9a:	c7 04 24 e4 8f 10 80 	movl   $0x80108fe4,(%esp)
80106ea1:	89 44 24 04          	mov    %eax,0x4(%esp)
80106ea5:	e8 96 97 ff ff       	call   80100640 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80106eaa:	e8 b1 ca ff ff       	call   80103960 <myproc>
80106eaf:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80106eb6:	8d 76 00             	lea    0x0(%esi),%esi
80106eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106ec0:	e8 9b ca ff ff       	call   80103960 <myproc>
80106ec5:	85 c0                	test   %eax,%eax
80106ec7:	74 0c                	je     80106ed5 <trap+0xd5>
80106ec9:	e8 92 ca ff ff       	call   80103960 <myproc>
80106ece:	8b 50 24             	mov    0x24(%eax),%edx
80106ed1:	85 d2                	test   %edx,%edx
80106ed3:	75 4b                	jne    80106f20 <trap+0x120>
    exit(0);

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106ed5:	e8 86 ca ff ff       	call   80103960 <myproc>
80106eda:	85 c0                	test   %eax,%eax
80106edc:	74 0f                	je     80106eed <trap+0xed>
80106ede:	66 90                	xchg   %ax,%ax
80106ee0:	e8 7b ca ff ff       	call   80103960 <myproc>
80106ee5:	8b 40 0c             	mov    0xc(%eax),%eax
80106ee8:	83 f8 04             	cmp    $0x4,%eax
80106eeb:	74 53                	je     80106f40 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106eed:	e8 6e ca ff ff       	call   80103960 <myproc>
80106ef2:	85 c0                	test   %eax,%eax
80106ef4:	74 1b                	je     80106f11 <trap+0x111>
80106ef6:	e8 65 ca ff ff       	call   80103960 <myproc>
80106efb:	8b 40 24             	mov    0x24(%eax),%eax
80106efe:	85 c0                	test   %eax,%eax
80106f00:	74 0f                	je     80106f11 <trap+0x111>
80106f02:	8b 43 3c             	mov    0x3c(%ebx),%eax
80106f05:	83 e0 03             	and    $0x3,%eax
80106f08:	83 f8 03             	cmp    $0x3,%eax
80106f0b:	0f 84 e8 00 00 00    	je     80106ff9 <trap+0x1f9>
    exit(0);
}
80106f11:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80106f14:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106f17:	8b 7d fc             	mov    -0x4(%ebp),%edi
80106f1a:	89 ec                	mov    %ebp,%esp
80106f1c:	5d                   	pop    %ebp
80106f1d:	c3                   	ret    
80106f1e:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106f20:	8b 43 3c             	mov    0x3c(%ebx),%eax
80106f23:	83 e0 03             	and    $0x3,%eax
80106f26:	83 f8 03             	cmp    $0x3,%eax
80106f29:	75 aa                	jne    80106ed5 <trap+0xd5>
    exit(0);
80106f2b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106f32:	e8 d9 d1 ff ff       	call   80104110 <exit>
80106f37:	eb 9c                	jmp    80106ed5 <trap+0xd5>
80106f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106f40:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106f44:	75 a7                	jne    80106eed <trap+0xed>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
80106f46:	e8 d5 d2 ff ff       	call   80104220 <yield>
80106f4b:	eb a0                	jmp    80106eed <trap+0xed>
80106f4d:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80106f50:	e8 eb c9 ff ff       	call   80103940 <cpuid>
80106f55:	85 c0                	test   %eax,%eax
80106f57:	0f 84 d3 00 00 00    	je     80107030 <trap+0x230>
80106f5d:	8d 76 00             	lea    0x0(%esi),%esi
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80106f60:	e8 7b b8 ff ff       	call   801027e0 <lapiceoi>
    break;
80106f65:	e9 56 ff ff ff       	jmp    80106ec0 <trap+0xc0>
80106f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80106f70:	e8 2b b7 ff ff       	call   801026a0 <kbdintr>
    lapiceoi();
80106f75:	e8 66 b8 ff ff       	call   801027e0 <lapiceoi>
    break;
80106f7a:	e9 41 ff ff ff       	jmp    80106ec0 <trap+0xc0>
80106f7f:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80106f80:	e8 7b 02 00 00       	call   80107200 <uartintr>
    lapiceoi();
80106f85:	e8 56 b8 ff ff       	call   801027e0 <lapiceoi>
    break;
80106f8a:	e9 31 ff ff ff       	jmp    80106ec0 <trap+0xc0>
80106f8f:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106f90:	8b 7b 38             	mov    0x38(%ebx),%edi
80106f93:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80106f97:	e8 a4 c9 ff ff       	call   80103940 <cpuid>
80106f9c:	c7 04 24 8c 8f 10 80 	movl   $0x80108f8c,(%esp)
80106fa3:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80106fa7:	89 74 24 08          	mov    %esi,0x8(%esp)
80106fab:	89 44 24 04          	mov    %eax,0x4(%esp)
80106faf:	e8 8c 96 ff ff       	call   80100640 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
80106fb4:	e8 27 b8 ff ff       	call   801027e0 <lapiceoi>
    break;
80106fb9:	e9 02 ff ff ff       	jmp    80106ec0 <trap+0xc0>
80106fbe:	66 90                	xchg   %ax,%ax
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106fc0:	e8 5b b1 ff ff       	call   80102120 <ideintr>
80106fc5:	eb 96                	jmp    80106f5d <trap+0x15d>
80106fc7:	89 f6                	mov    %esi,%esi
80106fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
80106fd0:	e8 8b c9 ff ff       	call   80103960 <myproc>
80106fd5:	8b 70 24             	mov    0x24(%eax),%esi
80106fd8:	85 f6                	test   %esi,%esi
80106fda:	75 3c                	jne    80107018 <trap+0x218>
      exit(0);
    myproc()->tf = tf;
80106fdc:	e8 7f c9 ff ff       	call   80103960 <myproc>
80106fe1:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80106fe4:	e8 57 ee ff ff       	call   80105e40 <syscall>
    if(myproc()->killed)
80106fe9:	e8 72 c9 ff ff       	call   80103960 <myproc>
80106fee:	8b 48 24             	mov    0x24(%eax),%ecx
80106ff1:	85 c9                	test   %ecx,%ecx
80106ff3:	0f 84 18 ff ff ff    	je     80106f11 <trap+0x111>
      exit(0);
80106ff9:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit(0);
}
80107000:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107003:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107006:	8b 7d fc             	mov    -0x4(%ebp),%edi
80107009:	89 ec                	mov    %ebp,%esp
8010700b:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit(0);
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit(0);
8010700c:	e9 ff d0 ff ff       	jmp    80104110 <exit>
80107011:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit(0);
80107018:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010701f:	e8 ec d0 ff ff       	call   80104110 <exit>
80107024:	eb b6                	jmp    80106fdc <trap+0x1dc>
80107026:	8d 76 00             	lea    0x0(%esi),%esi
80107029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
80107030:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80107037:	e8 34 e9 ff ff       	call   80105970 <acquire>
      ticks++;
      wakeup(&ticks);
8010703c:	c7 04 24 00 80 11 80 	movl   $0x80118000,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
80107043:	ff 05 00 80 11 80    	incl   0x80118000
      wakeup(&ticks);
80107049:	e8 e2 d4 ff ff       	call   80104530 <wakeup>
      release(&tickslock);
8010704e:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80107055:	e8 b6 e9 ff ff       	call   80105a10 <release>
8010705a:	e9 fe fe ff ff       	jmp    80106f5d <trap+0x15d>
8010705f:	0f 20 d7             	mov    %cr2,%edi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80107062:	8b 73 38             	mov    0x38(%ebx),%esi
80107065:	e8 d6 c8 ff ff       	call   80103940 <cpuid>
8010706a:	89 7c 24 10          	mov    %edi,0x10(%esp)
8010706e:	89 74 24 0c          	mov    %esi,0xc(%esp)
80107072:	89 44 24 08          	mov    %eax,0x8(%esp)
80107076:	8b 43 30             	mov    0x30(%ebx),%eax
80107079:	c7 04 24 b0 8f 10 80 	movl   $0x80108fb0,(%esp)
80107080:	89 44 24 04          	mov    %eax,0x4(%esp)
80107084:	e8 b7 95 ff ff       	call   80100640 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
80107089:	c7 04 24 86 8f 10 80 	movl   $0x80108f86,(%esp)
80107090:	e8 ab 92 ff ff       	call   80100340 <panic>
80107095:	66 90                	xchg   %ax,%ax
80107097:	66 90                	xchg   %ax,%ax
80107099:	66 90                	xchg   %ax,%ax
8010709b:	66 90                	xchg   %ax,%ax
8010709d:	66 90                	xchg   %ax,%ax
8010709f:	90                   	nop

801070a0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801070a0:	a1 18 c6 10 80       	mov    0x8010c618,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
801070a5:	55                   	push   %ebp
801070a6:	89 e5                	mov    %esp,%ebp
  if(!uart)
801070a8:	85 c0                	test   %eax,%eax
801070aa:	74 1c                	je     801070c8 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801070ac:	ba fd 03 00 00       	mov    $0x3fd,%edx
801070b1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801070b2:	24 01                	and    $0x1,%al
801070b4:	84 c0                	test   %al,%al
801070b6:	74 10                	je     801070c8 <uartgetc+0x28>
801070b8:	ba f8 03 00 00       	mov    $0x3f8,%edx
801070bd:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801070be:	0f b6 c0             	movzbl %al,%eax
}
801070c1:	5d                   	pop    %ebp
801070c2:	c3                   	ret    
801070c3:	90                   	nop
801070c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
801070c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
801070cd:	5d                   	pop    %ebp
801070ce:	c3                   	ret    
801070cf:	90                   	nop

801070d0 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
801070d0:	55                   	push   %ebp
801070d1:	89 e5                	mov    %esp,%ebp
801070d3:	57                   	push   %edi
801070d4:	bf fd 03 00 00       	mov    $0x3fd,%edi
801070d9:	56                   	push   %esi
801070da:	be 80 00 00 00       	mov    $0x80,%esi
801070df:	53                   	push   %ebx
801070e0:	89 c3                	mov    %eax,%ebx
801070e2:	83 ec 1c             	sub    $0x1c,%esp
801070e5:	eb 18                	jmp    801070ff <uartputc.part.0+0x2f>
801070e7:	89 f6                	mov    %esi,%esi
801070e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
801070f0:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
801070f7:	e8 04 b7 ff ff       	call   80102800 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801070fc:	4e                   	dec    %esi
801070fd:	74 09                	je     80107108 <uartputc.part.0+0x38>
801070ff:	89 fa                	mov    %edi,%edx
80107101:	ec                   	in     (%dx),%al
80107102:	24 20                	and    $0x20,%al
80107104:	84 c0                	test   %al,%al
80107106:	74 e8                	je     801070f0 <uartputc.part.0+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107108:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010710d:	88 d8                	mov    %bl,%al
8010710f:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80107110:	83 c4 1c             	add    $0x1c,%esp
80107113:	5b                   	pop    %ebx
80107114:	5e                   	pop    %esi
80107115:	5f                   	pop    %edi
80107116:	5d                   	pop    %ebp
80107117:	c3                   	ret    
80107118:	90                   	nop
80107119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107120 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80107120:	55                   	push   %ebp
80107121:	31 c9                	xor    %ecx,%ecx
80107123:	89 e5                	mov    %esp,%ebp
80107125:	88 c8                	mov    %cl,%al
80107127:	57                   	push   %edi
80107128:	56                   	push   %esi
80107129:	53                   	push   %ebx
8010712a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010712f:	83 ec 1c             	sub    $0x1c,%esp
80107132:	89 da                	mov    %ebx,%edx
80107134:	ee                   	out    %al,(%dx)
80107135:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010713a:	b0 80                	mov    $0x80,%al
8010713c:	89 fa                	mov    %edi,%edx
8010713e:	ee                   	out    %al,(%dx)
8010713f:	b0 0c                	mov    $0xc,%al
80107141:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107146:	ee                   	out    %al,(%dx)
80107147:	be f9 03 00 00       	mov    $0x3f9,%esi
8010714c:	88 c8                	mov    %cl,%al
8010714e:	89 f2                	mov    %esi,%edx
80107150:	ee                   	out    %al,(%dx)
80107151:	b0 03                	mov    $0x3,%al
80107153:	89 fa                	mov    %edi,%edx
80107155:	ee                   	out    %al,(%dx)
80107156:	ba fc 03 00 00       	mov    $0x3fc,%edx
8010715b:	88 c8                	mov    %cl,%al
8010715d:	ee                   	out    %al,(%dx)
8010715e:	b0 01                	mov    $0x1,%al
80107160:	89 f2                	mov    %esi,%edx
80107162:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80107163:	ba fd 03 00 00       	mov    $0x3fd,%edx
80107168:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80107169:	fe c0                	inc    %al
8010716b:	74 52                	je     801071bf <uartinit+0x9f>
    return;
  uart = 1;
8010716d:	b9 01 00 00 00       	mov    $0x1,%ecx
80107172:	89 da                	mov    %ebx,%edx
80107174:	89 0d 18 c6 10 80    	mov    %ecx,0x8010c618
8010717a:	ec                   	in     (%dx),%al
8010717b:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107180:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
80107181:	31 db                	xor    %ebx,%ebx
80107183:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80107187:	bb a8 90 10 80       	mov    $0x801090a8,%ebx
8010718c:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80107193:	e8 b8 b1 ff ff       	call   80102350 <ioapicenable>
80107198:	b8 78 00 00 00       	mov    $0x78,%eax
8010719d:	eb 09                	jmp    801071a8 <uartinit+0x88>
8010719f:	90                   	nop

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801071a0:	43                   	inc    %ebx
801071a1:	0f be 03             	movsbl (%ebx),%eax
801071a4:	84 c0                	test   %al,%al
801071a6:	74 17                	je     801071bf <uartinit+0x9f>
void
uartputc(int c)
{
  int i;

  if(!uart)
801071a8:	8b 15 18 c6 10 80    	mov    0x8010c618,%edx
801071ae:	85 d2                	test   %edx,%edx
801071b0:	74 ee                	je     801071a0 <uartinit+0x80>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801071b2:	43                   	inc    %ebx
801071b3:	e8 18 ff ff ff       	call   801070d0 <uartputc.part.0>
801071b8:	0f be 03             	movsbl (%ebx),%eax
801071bb:	84 c0                	test   %al,%al
801071bd:	75 e9                	jne    801071a8 <uartinit+0x88>
    uartputc(*p);
}
801071bf:	83 c4 1c             	add    $0x1c,%esp
801071c2:	5b                   	pop    %ebx
801071c3:	5e                   	pop    %esi
801071c4:	5f                   	pop    %edi
801071c5:	5d                   	pop    %ebp
801071c6:	c3                   	ret    
801071c7:	89 f6                	mov    %esi,%esi
801071c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801071d0 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
801071d0:	8b 15 18 c6 10 80    	mov    0x8010c618,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
801071d6:	55                   	push   %ebp
801071d7:	89 e5                	mov    %esp,%ebp
801071d9:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
801071dc:	85 d2                	test   %edx,%edx
801071de:	74 10                	je     801071f0 <uartputc+0x20>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
801071e0:	5d                   	pop    %ebp
801071e1:	e9 ea fe ff ff       	jmp    801070d0 <uartputc.part.0>
801071e6:	8d 76 00             	lea    0x0(%esi),%esi
801071e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801071f0:	5d                   	pop    %ebp
801071f1:	c3                   	ret    
801071f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107200 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80107200:	55                   	push   %ebp
80107201:	89 e5                	mov    %esp,%ebp
80107203:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80107206:	c7 04 24 a0 70 10 80 	movl   $0x801070a0,(%esp)
8010720d:	e8 9e 95 ff ff       	call   801007b0 <consoleintr>
}
80107212:	c9                   	leave  
80107213:	c3                   	ret    

80107214 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80107214:	6a 00                	push   $0x0
  pushl $0
80107216:	6a 00                	push   $0x0
  jmp alltraps
80107218:	e9 ea fa ff ff       	jmp    80106d07 <alltraps>

8010721d <vector1>:
.globl vector1
vector1:
  pushl $0
8010721d:	6a 00                	push   $0x0
  pushl $1
8010721f:	6a 01                	push   $0x1
  jmp alltraps
80107221:	e9 e1 fa ff ff       	jmp    80106d07 <alltraps>

80107226 <vector2>:
.globl vector2
vector2:
  pushl $0
80107226:	6a 00                	push   $0x0
  pushl $2
80107228:	6a 02                	push   $0x2
  jmp alltraps
8010722a:	e9 d8 fa ff ff       	jmp    80106d07 <alltraps>

8010722f <vector3>:
.globl vector3
vector3:
  pushl $0
8010722f:	6a 00                	push   $0x0
  pushl $3
80107231:	6a 03                	push   $0x3
  jmp alltraps
80107233:	e9 cf fa ff ff       	jmp    80106d07 <alltraps>

80107238 <vector4>:
.globl vector4
vector4:
  pushl $0
80107238:	6a 00                	push   $0x0
  pushl $4
8010723a:	6a 04                	push   $0x4
  jmp alltraps
8010723c:	e9 c6 fa ff ff       	jmp    80106d07 <alltraps>

80107241 <vector5>:
.globl vector5
vector5:
  pushl $0
80107241:	6a 00                	push   $0x0
  pushl $5
80107243:	6a 05                	push   $0x5
  jmp alltraps
80107245:	e9 bd fa ff ff       	jmp    80106d07 <alltraps>

8010724a <vector6>:
.globl vector6
vector6:
  pushl $0
8010724a:	6a 00                	push   $0x0
  pushl $6
8010724c:	6a 06                	push   $0x6
  jmp alltraps
8010724e:	e9 b4 fa ff ff       	jmp    80106d07 <alltraps>

80107253 <vector7>:
.globl vector7
vector7:
  pushl $0
80107253:	6a 00                	push   $0x0
  pushl $7
80107255:	6a 07                	push   $0x7
  jmp alltraps
80107257:	e9 ab fa ff ff       	jmp    80106d07 <alltraps>

8010725c <vector8>:
.globl vector8
vector8:
  pushl $8
8010725c:	6a 08                	push   $0x8
  jmp alltraps
8010725e:	e9 a4 fa ff ff       	jmp    80106d07 <alltraps>

80107263 <vector9>:
.globl vector9
vector9:
  pushl $0
80107263:	6a 00                	push   $0x0
  pushl $9
80107265:	6a 09                	push   $0x9
  jmp alltraps
80107267:	e9 9b fa ff ff       	jmp    80106d07 <alltraps>

8010726c <vector10>:
.globl vector10
vector10:
  pushl $10
8010726c:	6a 0a                	push   $0xa
  jmp alltraps
8010726e:	e9 94 fa ff ff       	jmp    80106d07 <alltraps>

80107273 <vector11>:
.globl vector11
vector11:
  pushl $11
80107273:	6a 0b                	push   $0xb
  jmp alltraps
80107275:	e9 8d fa ff ff       	jmp    80106d07 <alltraps>

8010727a <vector12>:
.globl vector12
vector12:
  pushl $12
8010727a:	6a 0c                	push   $0xc
  jmp alltraps
8010727c:	e9 86 fa ff ff       	jmp    80106d07 <alltraps>

80107281 <vector13>:
.globl vector13
vector13:
  pushl $13
80107281:	6a 0d                	push   $0xd
  jmp alltraps
80107283:	e9 7f fa ff ff       	jmp    80106d07 <alltraps>

80107288 <vector14>:
.globl vector14
vector14:
  pushl $14
80107288:	6a 0e                	push   $0xe
  jmp alltraps
8010728a:	e9 78 fa ff ff       	jmp    80106d07 <alltraps>

8010728f <vector15>:
.globl vector15
vector15:
  pushl $0
8010728f:	6a 00                	push   $0x0
  pushl $15
80107291:	6a 0f                	push   $0xf
  jmp alltraps
80107293:	e9 6f fa ff ff       	jmp    80106d07 <alltraps>

80107298 <vector16>:
.globl vector16
vector16:
  pushl $0
80107298:	6a 00                	push   $0x0
  pushl $16
8010729a:	6a 10                	push   $0x10
  jmp alltraps
8010729c:	e9 66 fa ff ff       	jmp    80106d07 <alltraps>

801072a1 <vector17>:
.globl vector17
vector17:
  pushl $17
801072a1:	6a 11                	push   $0x11
  jmp alltraps
801072a3:	e9 5f fa ff ff       	jmp    80106d07 <alltraps>

801072a8 <vector18>:
.globl vector18
vector18:
  pushl $0
801072a8:	6a 00                	push   $0x0
  pushl $18
801072aa:	6a 12                	push   $0x12
  jmp alltraps
801072ac:	e9 56 fa ff ff       	jmp    80106d07 <alltraps>

801072b1 <vector19>:
.globl vector19
vector19:
  pushl $0
801072b1:	6a 00                	push   $0x0
  pushl $19
801072b3:	6a 13                	push   $0x13
  jmp alltraps
801072b5:	e9 4d fa ff ff       	jmp    80106d07 <alltraps>

801072ba <vector20>:
.globl vector20
vector20:
  pushl $0
801072ba:	6a 00                	push   $0x0
  pushl $20
801072bc:	6a 14                	push   $0x14
  jmp alltraps
801072be:	e9 44 fa ff ff       	jmp    80106d07 <alltraps>

801072c3 <vector21>:
.globl vector21
vector21:
  pushl $0
801072c3:	6a 00                	push   $0x0
  pushl $21
801072c5:	6a 15                	push   $0x15
  jmp alltraps
801072c7:	e9 3b fa ff ff       	jmp    80106d07 <alltraps>

801072cc <vector22>:
.globl vector22
vector22:
  pushl $0
801072cc:	6a 00                	push   $0x0
  pushl $22
801072ce:	6a 16                	push   $0x16
  jmp alltraps
801072d0:	e9 32 fa ff ff       	jmp    80106d07 <alltraps>

801072d5 <vector23>:
.globl vector23
vector23:
  pushl $0
801072d5:	6a 00                	push   $0x0
  pushl $23
801072d7:	6a 17                	push   $0x17
  jmp alltraps
801072d9:	e9 29 fa ff ff       	jmp    80106d07 <alltraps>

801072de <vector24>:
.globl vector24
vector24:
  pushl $0
801072de:	6a 00                	push   $0x0
  pushl $24
801072e0:	6a 18                	push   $0x18
  jmp alltraps
801072e2:	e9 20 fa ff ff       	jmp    80106d07 <alltraps>

801072e7 <vector25>:
.globl vector25
vector25:
  pushl $0
801072e7:	6a 00                	push   $0x0
  pushl $25
801072e9:	6a 19                	push   $0x19
  jmp alltraps
801072eb:	e9 17 fa ff ff       	jmp    80106d07 <alltraps>

801072f0 <vector26>:
.globl vector26
vector26:
  pushl $0
801072f0:	6a 00                	push   $0x0
  pushl $26
801072f2:	6a 1a                	push   $0x1a
  jmp alltraps
801072f4:	e9 0e fa ff ff       	jmp    80106d07 <alltraps>

801072f9 <vector27>:
.globl vector27
vector27:
  pushl $0
801072f9:	6a 00                	push   $0x0
  pushl $27
801072fb:	6a 1b                	push   $0x1b
  jmp alltraps
801072fd:	e9 05 fa ff ff       	jmp    80106d07 <alltraps>

80107302 <vector28>:
.globl vector28
vector28:
  pushl $0
80107302:	6a 00                	push   $0x0
  pushl $28
80107304:	6a 1c                	push   $0x1c
  jmp alltraps
80107306:	e9 fc f9 ff ff       	jmp    80106d07 <alltraps>

8010730b <vector29>:
.globl vector29
vector29:
  pushl $0
8010730b:	6a 00                	push   $0x0
  pushl $29
8010730d:	6a 1d                	push   $0x1d
  jmp alltraps
8010730f:	e9 f3 f9 ff ff       	jmp    80106d07 <alltraps>

80107314 <vector30>:
.globl vector30
vector30:
  pushl $0
80107314:	6a 00                	push   $0x0
  pushl $30
80107316:	6a 1e                	push   $0x1e
  jmp alltraps
80107318:	e9 ea f9 ff ff       	jmp    80106d07 <alltraps>

8010731d <vector31>:
.globl vector31
vector31:
  pushl $0
8010731d:	6a 00                	push   $0x0
  pushl $31
8010731f:	6a 1f                	push   $0x1f
  jmp alltraps
80107321:	e9 e1 f9 ff ff       	jmp    80106d07 <alltraps>

80107326 <vector32>:
.globl vector32
vector32:
  pushl $0
80107326:	6a 00                	push   $0x0
  pushl $32
80107328:	6a 20                	push   $0x20
  jmp alltraps
8010732a:	e9 d8 f9 ff ff       	jmp    80106d07 <alltraps>

8010732f <vector33>:
.globl vector33
vector33:
  pushl $0
8010732f:	6a 00                	push   $0x0
  pushl $33
80107331:	6a 21                	push   $0x21
  jmp alltraps
80107333:	e9 cf f9 ff ff       	jmp    80106d07 <alltraps>

80107338 <vector34>:
.globl vector34
vector34:
  pushl $0
80107338:	6a 00                	push   $0x0
  pushl $34
8010733a:	6a 22                	push   $0x22
  jmp alltraps
8010733c:	e9 c6 f9 ff ff       	jmp    80106d07 <alltraps>

80107341 <vector35>:
.globl vector35
vector35:
  pushl $0
80107341:	6a 00                	push   $0x0
  pushl $35
80107343:	6a 23                	push   $0x23
  jmp alltraps
80107345:	e9 bd f9 ff ff       	jmp    80106d07 <alltraps>

8010734a <vector36>:
.globl vector36
vector36:
  pushl $0
8010734a:	6a 00                	push   $0x0
  pushl $36
8010734c:	6a 24                	push   $0x24
  jmp alltraps
8010734e:	e9 b4 f9 ff ff       	jmp    80106d07 <alltraps>

80107353 <vector37>:
.globl vector37
vector37:
  pushl $0
80107353:	6a 00                	push   $0x0
  pushl $37
80107355:	6a 25                	push   $0x25
  jmp alltraps
80107357:	e9 ab f9 ff ff       	jmp    80106d07 <alltraps>

8010735c <vector38>:
.globl vector38
vector38:
  pushl $0
8010735c:	6a 00                	push   $0x0
  pushl $38
8010735e:	6a 26                	push   $0x26
  jmp alltraps
80107360:	e9 a2 f9 ff ff       	jmp    80106d07 <alltraps>

80107365 <vector39>:
.globl vector39
vector39:
  pushl $0
80107365:	6a 00                	push   $0x0
  pushl $39
80107367:	6a 27                	push   $0x27
  jmp alltraps
80107369:	e9 99 f9 ff ff       	jmp    80106d07 <alltraps>

8010736e <vector40>:
.globl vector40
vector40:
  pushl $0
8010736e:	6a 00                	push   $0x0
  pushl $40
80107370:	6a 28                	push   $0x28
  jmp alltraps
80107372:	e9 90 f9 ff ff       	jmp    80106d07 <alltraps>

80107377 <vector41>:
.globl vector41
vector41:
  pushl $0
80107377:	6a 00                	push   $0x0
  pushl $41
80107379:	6a 29                	push   $0x29
  jmp alltraps
8010737b:	e9 87 f9 ff ff       	jmp    80106d07 <alltraps>

80107380 <vector42>:
.globl vector42
vector42:
  pushl $0
80107380:	6a 00                	push   $0x0
  pushl $42
80107382:	6a 2a                	push   $0x2a
  jmp alltraps
80107384:	e9 7e f9 ff ff       	jmp    80106d07 <alltraps>

80107389 <vector43>:
.globl vector43
vector43:
  pushl $0
80107389:	6a 00                	push   $0x0
  pushl $43
8010738b:	6a 2b                	push   $0x2b
  jmp alltraps
8010738d:	e9 75 f9 ff ff       	jmp    80106d07 <alltraps>

80107392 <vector44>:
.globl vector44
vector44:
  pushl $0
80107392:	6a 00                	push   $0x0
  pushl $44
80107394:	6a 2c                	push   $0x2c
  jmp alltraps
80107396:	e9 6c f9 ff ff       	jmp    80106d07 <alltraps>

8010739b <vector45>:
.globl vector45
vector45:
  pushl $0
8010739b:	6a 00                	push   $0x0
  pushl $45
8010739d:	6a 2d                	push   $0x2d
  jmp alltraps
8010739f:	e9 63 f9 ff ff       	jmp    80106d07 <alltraps>

801073a4 <vector46>:
.globl vector46
vector46:
  pushl $0
801073a4:	6a 00                	push   $0x0
  pushl $46
801073a6:	6a 2e                	push   $0x2e
  jmp alltraps
801073a8:	e9 5a f9 ff ff       	jmp    80106d07 <alltraps>

801073ad <vector47>:
.globl vector47
vector47:
  pushl $0
801073ad:	6a 00                	push   $0x0
  pushl $47
801073af:	6a 2f                	push   $0x2f
  jmp alltraps
801073b1:	e9 51 f9 ff ff       	jmp    80106d07 <alltraps>

801073b6 <vector48>:
.globl vector48
vector48:
  pushl $0
801073b6:	6a 00                	push   $0x0
  pushl $48
801073b8:	6a 30                	push   $0x30
  jmp alltraps
801073ba:	e9 48 f9 ff ff       	jmp    80106d07 <alltraps>

801073bf <vector49>:
.globl vector49
vector49:
  pushl $0
801073bf:	6a 00                	push   $0x0
  pushl $49
801073c1:	6a 31                	push   $0x31
  jmp alltraps
801073c3:	e9 3f f9 ff ff       	jmp    80106d07 <alltraps>

801073c8 <vector50>:
.globl vector50
vector50:
  pushl $0
801073c8:	6a 00                	push   $0x0
  pushl $50
801073ca:	6a 32                	push   $0x32
  jmp alltraps
801073cc:	e9 36 f9 ff ff       	jmp    80106d07 <alltraps>

801073d1 <vector51>:
.globl vector51
vector51:
  pushl $0
801073d1:	6a 00                	push   $0x0
  pushl $51
801073d3:	6a 33                	push   $0x33
  jmp alltraps
801073d5:	e9 2d f9 ff ff       	jmp    80106d07 <alltraps>

801073da <vector52>:
.globl vector52
vector52:
  pushl $0
801073da:	6a 00                	push   $0x0
  pushl $52
801073dc:	6a 34                	push   $0x34
  jmp alltraps
801073de:	e9 24 f9 ff ff       	jmp    80106d07 <alltraps>

801073e3 <vector53>:
.globl vector53
vector53:
  pushl $0
801073e3:	6a 00                	push   $0x0
  pushl $53
801073e5:	6a 35                	push   $0x35
  jmp alltraps
801073e7:	e9 1b f9 ff ff       	jmp    80106d07 <alltraps>

801073ec <vector54>:
.globl vector54
vector54:
  pushl $0
801073ec:	6a 00                	push   $0x0
  pushl $54
801073ee:	6a 36                	push   $0x36
  jmp alltraps
801073f0:	e9 12 f9 ff ff       	jmp    80106d07 <alltraps>

801073f5 <vector55>:
.globl vector55
vector55:
  pushl $0
801073f5:	6a 00                	push   $0x0
  pushl $55
801073f7:	6a 37                	push   $0x37
  jmp alltraps
801073f9:	e9 09 f9 ff ff       	jmp    80106d07 <alltraps>

801073fe <vector56>:
.globl vector56
vector56:
  pushl $0
801073fe:	6a 00                	push   $0x0
  pushl $56
80107400:	6a 38                	push   $0x38
  jmp alltraps
80107402:	e9 00 f9 ff ff       	jmp    80106d07 <alltraps>

80107407 <vector57>:
.globl vector57
vector57:
  pushl $0
80107407:	6a 00                	push   $0x0
  pushl $57
80107409:	6a 39                	push   $0x39
  jmp alltraps
8010740b:	e9 f7 f8 ff ff       	jmp    80106d07 <alltraps>

80107410 <vector58>:
.globl vector58
vector58:
  pushl $0
80107410:	6a 00                	push   $0x0
  pushl $58
80107412:	6a 3a                	push   $0x3a
  jmp alltraps
80107414:	e9 ee f8 ff ff       	jmp    80106d07 <alltraps>

80107419 <vector59>:
.globl vector59
vector59:
  pushl $0
80107419:	6a 00                	push   $0x0
  pushl $59
8010741b:	6a 3b                	push   $0x3b
  jmp alltraps
8010741d:	e9 e5 f8 ff ff       	jmp    80106d07 <alltraps>

80107422 <vector60>:
.globl vector60
vector60:
  pushl $0
80107422:	6a 00                	push   $0x0
  pushl $60
80107424:	6a 3c                	push   $0x3c
  jmp alltraps
80107426:	e9 dc f8 ff ff       	jmp    80106d07 <alltraps>

8010742b <vector61>:
.globl vector61
vector61:
  pushl $0
8010742b:	6a 00                	push   $0x0
  pushl $61
8010742d:	6a 3d                	push   $0x3d
  jmp alltraps
8010742f:	e9 d3 f8 ff ff       	jmp    80106d07 <alltraps>

80107434 <vector62>:
.globl vector62
vector62:
  pushl $0
80107434:	6a 00                	push   $0x0
  pushl $62
80107436:	6a 3e                	push   $0x3e
  jmp alltraps
80107438:	e9 ca f8 ff ff       	jmp    80106d07 <alltraps>

8010743d <vector63>:
.globl vector63
vector63:
  pushl $0
8010743d:	6a 00                	push   $0x0
  pushl $63
8010743f:	6a 3f                	push   $0x3f
  jmp alltraps
80107441:	e9 c1 f8 ff ff       	jmp    80106d07 <alltraps>

80107446 <vector64>:
.globl vector64
vector64:
  pushl $0
80107446:	6a 00                	push   $0x0
  pushl $64
80107448:	6a 40                	push   $0x40
  jmp alltraps
8010744a:	e9 b8 f8 ff ff       	jmp    80106d07 <alltraps>

8010744f <vector65>:
.globl vector65
vector65:
  pushl $0
8010744f:	6a 00                	push   $0x0
  pushl $65
80107451:	6a 41                	push   $0x41
  jmp alltraps
80107453:	e9 af f8 ff ff       	jmp    80106d07 <alltraps>

80107458 <vector66>:
.globl vector66
vector66:
  pushl $0
80107458:	6a 00                	push   $0x0
  pushl $66
8010745a:	6a 42                	push   $0x42
  jmp alltraps
8010745c:	e9 a6 f8 ff ff       	jmp    80106d07 <alltraps>

80107461 <vector67>:
.globl vector67
vector67:
  pushl $0
80107461:	6a 00                	push   $0x0
  pushl $67
80107463:	6a 43                	push   $0x43
  jmp alltraps
80107465:	e9 9d f8 ff ff       	jmp    80106d07 <alltraps>

8010746a <vector68>:
.globl vector68
vector68:
  pushl $0
8010746a:	6a 00                	push   $0x0
  pushl $68
8010746c:	6a 44                	push   $0x44
  jmp alltraps
8010746e:	e9 94 f8 ff ff       	jmp    80106d07 <alltraps>

80107473 <vector69>:
.globl vector69
vector69:
  pushl $0
80107473:	6a 00                	push   $0x0
  pushl $69
80107475:	6a 45                	push   $0x45
  jmp alltraps
80107477:	e9 8b f8 ff ff       	jmp    80106d07 <alltraps>

8010747c <vector70>:
.globl vector70
vector70:
  pushl $0
8010747c:	6a 00                	push   $0x0
  pushl $70
8010747e:	6a 46                	push   $0x46
  jmp alltraps
80107480:	e9 82 f8 ff ff       	jmp    80106d07 <alltraps>

80107485 <vector71>:
.globl vector71
vector71:
  pushl $0
80107485:	6a 00                	push   $0x0
  pushl $71
80107487:	6a 47                	push   $0x47
  jmp alltraps
80107489:	e9 79 f8 ff ff       	jmp    80106d07 <alltraps>

8010748e <vector72>:
.globl vector72
vector72:
  pushl $0
8010748e:	6a 00                	push   $0x0
  pushl $72
80107490:	6a 48                	push   $0x48
  jmp alltraps
80107492:	e9 70 f8 ff ff       	jmp    80106d07 <alltraps>

80107497 <vector73>:
.globl vector73
vector73:
  pushl $0
80107497:	6a 00                	push   $0x0
  pushl $73
80107499:	6a 49                	push   $0x49
  jmp alltraps
8010749b:	e9 67 f8 ff ff       	jmp    80106d07 <alltraps>

801074a0 <vector74>:
.globl vector74
vector74:
  pushl $0
801074a0:	6a 00                	push   $0x0
  pushl $74
801074a2:	6a 4a                	push   $0x4a
  jmp alltraps
801074a4:	e9 5e f8 ff ff       	jmp    80106d07 <alltraps>

801074a9 <vector75>:
.globl vector75
vector75:
  pushl $0
801074a9:	6a 00                	push   $0x0
  pushl $75
801074ab:	6a 4b                	push   $0x4b
  jmp alltraps
801074ad:	e9 55 f8 ff ff       	jmp    80106d07 <alltraps>

801074b2 <vector76>:
.globl vector76
vector76:
  pushl $0
801074b2:	6a 00                	push   $0x0
  pushl $76
801074b4:	6a 4c                	push   $0x4c
  jmp alltraps
801074b6:	e9 4c f8 ff ff       	jmp    80106d07 <alltraps>

801074bb <vector77>:
.globl vector77
vector77:
  pushl $0
801074bb:	6a 00                	push   $0x0
  pushl $77
801074bd:	6a 4d                	push   $0x4d
  jmp alltraps
801074bf:	e9 43 f8 ff ff       	jmp    80106d07 <alltraps>

801074c4 <vector78>:
.globl vector78
vector78:
  pushl $0
801074c4:	6a 00                	push   $0x0
  pushl $78
801074c6:	6a 4e                	push   $0x4e
  jmp alltraps
801074c8:	e9 3a f8 ff ff       	jmp    80106d07 <alltraps>

801074cd <vector79>:
.globl vector79
vector79:
  pushl $0
801074cd:	6a 00                	push   $0x0
  pushl $79
801074cf:	6a 4f                	push   $0x4f
  jmp alltraps
801074d1:	e9 31 f8 ff ff       	jmp    80106d07 <alltraps>

801074d6 <vector80>:
.globl vector80
vector80:
  pushl $0
801074d6:	6a 00                	push   $0x0
  pushl $80
801074d8:	6a 50                	push   $0x50
  jmp alltraps
801074da:	e9 28 f8 ff ff       	jmp    80106d07 <alltraps>

801074df <vector81>:
.globl vector81
vector81:
  pushl $0
801074df:	6a 00                	push   $0x0
  pushl $81
801074e1:	6a 51                	push   $0x51
  jmp alltraps
801074e3:	e9 1f f8 ff ff       	jmp    80106d07 <alltraps>

801074e8 <vector82>:
.globl vector82
vector82:
  pushl $0
801074e8:	6a 00                	push   $0x0
  pushl $82
801074ea:	6a 52                	push   $0x52
  jmp alltraps
801074ec:	e9 16 f8 ff ff       	jmp    80106d07 <alltraps>

801074f1 <vector83>:
.globl vector83
vector83:
  pushl $0
801074f1:	6a 00                	push   $0x0
  pushl $83
801074f3:	6a 53                	push   $0x53
  jmp alltraps
801074f5:	e9 0d f8 ff ff       	jmp    80106d07 <alltraps>

801074fa <vector84>:
.globl vector84
vector84:
  pushl $0
801074fa:	6a 00                	push   $0x0
  pushl $84
801074fc:	6a 54                	push   $0x54
  jmp alltraps
801074fe:	e9 04 f8 ff ff       	jmp    80106d07 <alltraps>

80107503 <vector85>:
.globl vector85
vector85:
  pushl $0
80107503:	6a 00                	push   $0x0
  pushl $85
80107505:	6a 55                	push   $0x55
  jmp alltraps
80107507:	e9 fb f7 ff ff       	jmp    80106d07 <alltraps>

8010750c <vector86>:
.globl vector86
vector86:
  pushl $0
8010750c:	6a 00                	push   $0x0
  pushl $86
8010750e:	6a 56                	push   $0x56
  jmp alltraps
80107510:	e9 f2 f7 ff ff       	jmp    80106d07 <alltraps>

80107515 <vector87>:
.globl vector87
vector87:
  pushl $0
80107515:	6a 00                	push   $0x0
  pushl $87
80107517:	6a 57                	push   $0x57
  jmp alltraps
80107519:	e9 e9 f7 ff ff       	jmp    80106d07 <alltraps>

8010751e <vector88>:
.globl vector88
vector88:
  pushl $0
8010751e:	6a 00                	push   $0x0
  pushl $88
80107520:	6a 58                	push   $0x58
  jmp alltraps
80107522:	e9 e0 f7 ff ff       	jmp    80106d07 <alltraps>

80107527 <vector89>:
.globl vector89
vector89:
  pushl $0
80107527:	6a 00                	push   $0x0
  pushl $89
80107529:	6a 59                	push   $0x59
  jmp alltraps
8010752b:	e9 d7 f7 ff ff       	jmp    80106d07 <alltraps>

80107530 <vector90>:
.globl vector90
vector90:
  pushl $0
80107530:	6a 00                	push   $0x0
  pushl $90
80107532:	6a 5a                	push   $0x5a
  jmp alltraps
80107534:	e9 ce f7 ff ff       	jmp    80106d07 <alltraps>

80107539 <vector91>:
.globl vector91
vector91:
  pushl $0
80107539:	6a 00                	push   $0x0
  pushl $91
8010753b:	6a 5b                	push   $0x5b
  jmp alltraps
8010753d:	e9 c5 f7 ff ff       	jmp    80106d07 <alltraps>

80107542 <vector92>:
.globl vector92
vector92:
  pushl $0
80107542:	6a 00                	push   $0x0
  pushl $92
80107544:	6a 5c                	push   $0x5c
  jmp alltraps
80107546:	e9 bc f7 ff ff       	jmp    80106d07 <alltraps>

8010754b <vector93>:
.globl vector93
vector93:
  pushl $0
8010754b:	6a 00                	push   $0x0
  pushl $93
8010754d:	6a 5d                	push   $0x5d
  jmp alltraps
8010754f:	e9 b3 f7 ff ff       	jmp    80106d07 <alltraps>

80107554 <vector94>:
.globl vector94
vector94:
  pushl $0
80107554:	6a 00                	push   $0x0
  pushl $94
80107556:	6a 5e                	push   $0x5e
  jmp alltraps
80107558:	e9 aa f7 ff ff       	jmp    80106d07 <alltraps>

8010755d <vector95>:
.globl vector95
vector95:
  pushl $0
8010755d:	6a 00                	push   $0x0
  pushl $95
8010755f:	6a 5f                	push   $0x5f
  jmp alltraps
80107561:	e9 a1 f7 ff ff       	jmp    80106d07 <alltraps>

80107566 <vector96>:
.globl vector96
vector96:
  pushl $0
80107566:	6a 00                	push   $0x0
  pushl $96
80107568:	6a 60                	push   $0x60
  jmp alltraps
8010756a:	e9 98 f7 ff ff       	jmp    80106d07 <alltraps>

8010756f <vector97>:
.globl vector97
vector97:
  pushl $0
8010756f:	6a 00                	push   $0x0
  pushl $97
80107571:	6a 61                	push   $0x61
  jmp alltraps
80107573:	e9 8f f7 ff ff       	jmp    80106d07 <alltraps>

80107578 <vector98>:
.globl vector98
vector98:
  pushl $0
80107578:	6a 00                	push   $0x0
  pushl $98
8010757a:	6a 62                	push   $0x62
  jmp alltraps
8010757c:	e9 86 f7 ff ff       	jmp    80106d07 <alltraps>

80107581 <vector99>:
.globl vector99
vector99:
  pushl $0
80107581:	6a 00                	push   $0x0
  pushl $99
80107583:	6a 63                	push   $0x63
  jmp alltraps
80107585:	e9 7d f7 ff ff       	jmp    80106d07 <alltraps>

8010758a <vector100>:
.globl vector100
vector100:
  pushl $0
8010758a:	6a 00                	push   $0x0
  pushl $100
8010758c:	6a 64                	push   $0x64
  jmp alltraps
8010758e:	e9 74 f7 ff ff       	jmp    80106d07 <alltraps>

80107593 <vector101>:
.globl vector101
vector101:
  pushl $0
80107593:	6a 00                	push   $0x0
  pushl $101
80107595:	6a 65                	push   $0x65
  jmp alltraps
80107597:	e9 6b f7 ff ff       	jmp    80106d07 <alltraps>

8010759c <vector102>:
.globl vector102
vector102:
  pushl $0
8010759c:	6a 00                	push   $0x0
  pushl $102
8010759e:	6a 66                	push   $0x66
  jmp alltraps
801075a0:	e9 62 f7 ff ff       	jmp    80106d07 <alltraps>

801075a5 <vector103>:
.globl vector103
vector103:
  pushl $0
801075a5:	6a 00                	push   $0x0
  pushl $103
801075a7:	6a 67                	push   $0x67
  jmp alltraps
801075a9:	e9 59 f7 ff ff       	jmp    80106d07 <alltraps>

801075ae <vector104>:
.globl vector104
vector104:
  pushl $0
801075ae:	6a 00                	push   $0x0
  pushl $104
801075b0:	6a 68                	push   $0x68
  jmp alltraps
801075b2:	e9 50 f7 ff ff       	jmp    80106d07 <alltraps>

801075b7 <vector105>:
.globl vector105
vector105:
  pushl $0
801075b7:	6a 00                	push   $0x0
  pushl $105
801075b9:	6a 69                	push   $0x69
  jmp alltraps
801075bb:	e9 47 f7 ff ff       	jmp    80106d07 <alltraps>

801075c0 <vector106>:
.globl vector106
vector106:
  pushl $0
801075c0:	6a 00                	push   $0x0
  pushl $106
801075c2:	6a 6a                	push   $0x6a
  jmp alltraps
801075c4:	e9 3e f7 ff ff       	jmp    80106d07 <alltraps>

801075c9 <vector107>:
.globl vector107
vector107:
  pushl $0
801075c9:	6a 00                	push   $0x0
  pushl $107
801075cb:	6a 6b                	push   $0x6b
  jmp alltraps
801075cd:	e9 35 f7 ff ff       	jmp    80106d07 <alltraps>

801075d2 <vector108>:
.globl vector108
vector108:
  pushl $0
801075d2:	6a 00                	push   $0x0
  pushl $108
801075d4:	6a 6c                	push   $0x6c
  jmp alltraps
801075d6:	e9 2c f7 ff ff       	jmp    80106d07 <alltraps>

801075db <vector109>:
.globl vector109
vector109:
  pushl $0
801075db:	6a 00                	push   $0x0
  pushl $109
801075dd:	6a 6d                	push   $0x6d
  jmp alltraps
801075df:	e9 23 f7 ff ff       	jmp    80106d07 <alltraps>

801075e4 <vector110>:
.globl vector110
vector110:
  pushl $0
801075e4:	6a 00                	push   $0x0
  pushl $110
801075e6:	6a 6e                	push   $0x6e
  jmp alltraps
801075e8:	e9 1a f7 ff ff       	jmp    80106d07 <alltraps>

801075ed <vector111>:
.globl vector111
vector111:
  pushl $0
801075ed:	6a 00                	push   $0x0
  pushl $111
801075ef:	6a 6f                	push   $0x6f
  jmp alltraps
801075f1:	e9 11 f7 ff ff       	jmp    80106d07 <alltraps>

801075f6 <vector112>:
.globl vector112
vector112:
  pushl $0
801075f6:	6a 00                	push   $0x0
  pushl $112
801075f8:	6a 70                	push   $0x70
  jmp alltraps
801075fa:	e9 08 f7 ff ff       	jmp    80106d07 <alltraps>

801075ff <vector113>:
.globl vector113
vector113:
  pushl $0
801075ff:	6a 00                	push   $0x0
  pushl $113
80107601:	6a 71                	push   $0x71
  jmp alltraps
80107603:	e9 ff f6 ff ff       	jmp    80106d07 <alltraps>

80107608 <vector114>:
.globl vector114
vector114:
  pushl $0
80107608:	6a 00                	push   $0x0
  pushl $114
8010760a:	6a 72                	push   $0x72
  jmp alltraps
8010760c:	e9 f6 f6 ff ff       	jmp    80106d07 <alltraps>

80107611 <vector115>:
.globl vector115
vector115:
  pushl $0
80107611:	6a 00                	push   $0x0
  pushl $115
80107613:	6a 73                	push   $0x73
  jmp alltraps
80107615:	e9 ed f6 ff ff       	jmp    80106d07 <alltraps>

8010761a <vector116>:
.globl vector116
vector116:
  pushl $0
8010761a:	6a 00                	push   $0x0
  pushl $116
8010761c:	6a 74                	push   $0x74
  jmp alltraps
8010761e:	e9 e4 f6 ff ff       	jmp    80106d07 <alltraps>

80107623 <vector117>:
.globl vector117
vector117:
  pushl $0
80107623:	6a 00                	push   $0x0
  pushl $117
80107625:	6a 75                	push   $0x75
  jmp alltraps
80107627:	e9 db f6 ff ff       	jmp    80106d07 <alltraps>

8010762c <vector118>:
.globl vector118
vector118:
  pushl $0
8010762c:	6a 00                	push   $0x0
  pushl $118
8010762e:	6a 76                	push   $0x76
  jmp alltraps
80107630:	e9 d2 f6 ff ff       	jmp    80106d07 <alltraps>

80107635 <vector119>:
.globl vector119
vector119:
  pushl $0
80107635:	6a 00                	push   $0x0
  pushl $119
80107637:	6a 77                	push   $0x77
  jmp alltraps
80107639:	e9 c9 f6 ff ff       	jmp    80106d07 <alltraps>

8010763e <vector120>:
.globl vector120
vector120:
  pushl $0
8010763e:	6a 00                	push   $0x0
  pushl $120
80107640:	6a 78                	push   $0x78
  jmp alltraps
80107642:	e9 c0 f6 ff ff       	jmp    80106d07 <alltraps>

80107647 <vector121>:
.globl vector121
vector121:
  pushl $0
80107647:	6a 00                	push   $0x0
  pushl $121
80107649:	6a 79                	push   $0x79
  jmp alltraps
8010764b:	e9 b7 f6 ff ff       	jmp    80106d07 <alltraps>

80107650 <vector122>:
.globl vector122
vector122:
  pushl $0
80107650:	6a 00                	push   $0x0
  pushl $122
80107652:	6a 7a                	push   $0x7a
  jmp alltraps
80107654:	e9 ae f6 ff ff       	jmp    80106d07 <alltraps>

80107659 <vector123>:
.globl vector123
vector123:
  pushl $0
80107659:	6a 00                	push   $0x0
  pushl $123
8010765b:	6a 7b                	push   $0x7b
  jmp alltraps
8010765d:	e9 a5 f6 ff ff       	jmp    80106d07 <alltraps>

80107662 <vector124>:
.globl vector124
vector124:
  pushl $0
80107662:	6a 00                	push   $0x0
  pushl $124
80107664:	6a 7c                	push   $0x7c
  jmp alltraps
80107666:	e9 9c f6 ff ff       	jmp    80106d07 <alltraps>

8010766b <vector125>:
.globl vector125
vector125:
  pushl $0
8010766b:	6a 00                	push   $0x0
  pushl $125
8010766d:	6a 7d                	push   $0x7d
  jmp alltraps
8010766f:	e9 93 f6 ff ff       	jmp    80106d07 <alltraps>

80107674 <vector126>:
.globl vector126
vector126:
  pushl $0
80107674:	6a 00                	push   $0x0
  pushl $126
80107676:	6a 7e                	push   $0x7e
  jmp alltraps
80107678:	e9 8a f6 ff ff       	jmp    80106d07 <alltraps>

8010767d <vector127>:
.globl vector127
vector127:
  pushl $0
8010767d:	6a 00                	push   $0x0
  pushl $127
8010767f:	6a 7f                	push   $0x7f
  jmp alltraps
80107681:	e9 81 f6 ff ff       	jmp    80106d07 <alltraps>

80107686 <vector128>:
.globl vector128
vector128:
  pushl $0
80107686:	6a 00                	push   $0x0
  pushl $128
80107688:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010768d:	e9 75 f6 ff ff       	jmp    80106d07 <alltraps>

80107692 <vector129>:
.globl vector129
vector129:
  pushl $0
80107692:	6a 00                	push   $0x0
  pushl $129
80107694:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80107699:	e9 69 f6 ff ff       	jmp    80106d07 <alltraps>

8010769e <vector130>:
.globl vector130
vector130:
  pushl $0
8010769e:	6a 00                	push   $0x0
  pushl $130
801076a0:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801076a5:	e9 5d f6 ff ff       	jmp    80106d07 <alltraps>

801076aa <vector131>:
.globl vector131
vector131:
  pushl $0
801076aa:	6a 00                	push   $0x0
  pushl $131
801076ac:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801076b1:	e9 51 f6 ff ff       	jmp    80106d07 <alltraps>

801076b6 <vector132>:
.globl vector132
vector132:
  pushl $0
801076b6:	6a 00                	push   $0x0
  pushl $132
801076b8:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801076bd:	e9 45 f6 ff ff       	jmp    80106d07 <alltraps>

801076c2 <vector133>:
.globl vector133
vector133:
  pushl $0
801076c2:	6a 00                	push   $0x0
  pushl $133
801076c4:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801076c9:	e9 39 f6 ff ff       	jmp    80106d07 <alltraps>

801076ce <vector134>:
.globl vector134
vector134:
  pushl $0
801076ce:	6a 00                	push   $0x0
  pushl $134
801076d0:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801076d5:	e9 2d f6 ff ff       	jmp    80106d07 <alltraps>

801076da <vector135>:
.globl vector135
vector135:
  pushl $0
801076da:	6a 00                	push   $0x0
  pushl $135
801076dc:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801076e1:	e9 21 f6 ff ff       	jmp    80106d07 <alltraps>

801076e6 <vector136>:
.globl vector136
vector136:
  pushl $0
801076e6:	6a 00                	push   $0x0
  pushl $136
801076e8:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801076ed:	e9 15 f6 ff ff       	jmp    80106d07 <alltraps>

801076f2 <vector137>:
.globl vector137
vector137:
  pushl $0
801076f2:	6a 00                	push   $0x0
  pushl $137
801076f4:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801076f9:	e9 09 f6 ff ff       	jmp    80106d07 <alltraps>

801076fe <vector138>:
.globl vector138
vector138:
  pushl $0
801076fe:	6a 00                	push   $0x0
  pushl $138
80107700:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107705:	e9 fd f5 ff ff       	jmp    80106d07 <alltraps>

8010770a <vector139>:
.globl vector139
vector139:
  pushl $0
8010770a:	6a 00                	push   $0x0
  pushl $139
8010770c:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80107711:	e9 f1 f5 ff ff       	jmp    80106d07 <alltraps>

80107716 <vector140>:
.globl vector140
vector140:
  pushl $0
80107716:	6a 00                	push   $0x0
  pushl $140
80107718:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010771d:	e9 e5 f5 ff ff       	jmp    80106d07 <alltraps>

80107722 <vector141>:
.globl vector141
vector141:
  pushl $0
80107722:	6a 00                	push   $0x0
  pushl $141
80107724:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80107729:	e9 d9 f5 ff ff       	jmp    80106d07 <alltraps>

8010772e <vector142>:
.globl vector142
vector142:
  pushl $0
8010772e:	6a 00                	push   $0x0
  pushl $142
80107730:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80107735:	e9 cd f5 ff ff       	jmp    80106d07 <alltraps>

8010773a <vector143>:
.globl vector143
vector143:
  pushl $0
8010773a:	6a 00                	push   $0x0
  pushl $143
8010773c:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80107741:	e9 c1 f5 ff ff       	jmp    80106d07 <alltraps>

80107746 <vector144>:
.globl vector144
vector144:
  pushl $0
80107746:	6a 00                	push   $0x0
  pushl $144
80107748:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010774d:	e9 b5 f5 ff ff       	jmp    80106d07 <alltraps>

80107752 <vector145>:
.globl vector145
vector145:
  pushl $0
80107752:	6a 00                	push   $0x0
  pushl $145
80107754:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80107759:	e9 a9 f5 ff ff       	jmp    80106d07 <alltraps>

8010775e <vector146>:
.globl vector146
vector146:
  pushl $0
8010775e:	6a 00                	push   $0x0
  pushl $146
80107760:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107765:	e9 9d f5 ff ff       	jmp    80106d07 <alltraps>

8010776a <vector147>:
.globl vector147
vector147:
  pushl $0
8010776a:	6a 00                	push   $0x0
  pushl $147
8010776c:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107771:	e9 91 f5 ff ff       	jmp    80106d07 <alltraps>

80107776 <vector148>:
.globl vector148
vector148:
  pushl $0
80107776:	6a 00                	push   $0x0
  pushl $148
80107778:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010777d:	e9 85 f5 ff ff       	jmp    80106d07 <alltraps>

80107782 <vector149>:
.globl vector149
vector149:
  pushl $0
80107782:	6a 00                	push   $0x0
  pushl $149
80107784:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80107789:	e9 79 f5 ff ff       	jmp    80106d07 <alltraps>

8010778e <vector150>:
.globl vector150
vector150:
  pushl $0
8010778e:	6a 00                	push   $0x0
  pushl $150
80107790:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107795:	e9 6d f5 ff ff       	jmp    80106d07 <alltraps>

8010779a <vector151>:
.globl vector151
vector151:
  pushl $0
8010779a:	6a 00                	push   $0x0
  pushl $151
8010779c:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801077a1:	e9 61 f5 ff ff       	jmp    80106d07 <alltraps>

801077a6 <vector152>:
.globl vector152
vector152:
  pushl $0
801077a6:	6a 00                	push   $0x0
  pushl $152
801077a8:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801077ad:	e9 55 f5 ff ff       	jmp    80106d07 <alltraps>

801077b2 <vector153>:
.globl vector153
vector153:
  pushl $0
801077b2:	6a 00                	push   $0x0
  pushl $153
801077b4:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801077b9:	e9 49 f5 ff ff       	jmp    80106d07 <alltraps>

801077be <vector154>:
.globl vector154
vector154:
  pushl $0
801077be:	6a 00                	push   $0x0
  pushl $154
801077c0:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801077c5:	e9 3d f5 ff ff       	jmp    80106d07 <alltraps>

801077ca <vector155>:
.globl vector155
vector155:
  pushl $0
801077ca:	6a 00                	push   $0x0
  pushl $155
801077cc:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801077d1:	e9 31 f5 ff ff       	jmp    80106d07 <alltraps>

801077d6 <vector156>:
.globl vector156
vector156:
  pushl $0
801077d6:	6a 00                	push   $0x0
  pushl $156
801077d8:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801077dd:	e9 25 f5 ff ff       	jmp    80106d07 <alltraps>

801077e2 <vector157>:
.globl vector157
vector157:
  pushl $0
801077e2:	6a 00                	push   $0x0
  pushl $157
801077e4:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801077e9:	e9 19 f5 ff ff       	jmp    80106d07 <alltraps>

801077ee <vector158>:
.globl vector158
vector158:
  pushl $0
801077ee:	6a 00                	push   $0x0
  pushl $158
801077f0:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801077f5:	e9 0d f5 ff ff       	jmp    80106d07 <alltraps>

801077fa <vector159>:
.globl vector159
vector159:
  pushl $0
801077fa:	6a 00                	push   $0x0
  pushl $159
801077fc:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80107801:	e9 01 f5 ff ff       	jmp    80106d07 <alltraps>

80107806 <vector160>:
.globl vector160
vector160:
  pushl $0
80107806:	6a 00                	push   $0x0
  pushl $160
80107808:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010780d:	e9 f5 f4 ff ff       	jmp    80106d07 <alltraps>

80107812 <vector161>:
.globl vector161
vector161:
  pushl $0
80107812:	6a 00                	push   $0x0
  pushl $161
80107814:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80107819:	e9 e9 f4 ff ff       	jmp    80106d07 <alltraps>

8010781e <vector162>:
.globl vector162
vector162:
  pushl $0
8010781e:	6a 00                	push   $0x0
  pushl $162
80107820:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80107825:	e9 dd f4 ff ff       	jmp    80106d07 <alltraps>

8010782a <vector163>:
.globl vector163
vector163:
  pushl $0
8010782a:	6a 00                	push   $0x0
  pushl $163
8010782c:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80107831:	e9 d1 f4 ff ff       	jmp    80106d07 <alltraps>

80107836 <vector164>:
.globl vector164
vector164:
  pushl $0
80107836:	6a 00                	push   $0x0
  pushl $164
80107838:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010783d:	e9 c5 f4 ff ff       	jmp    80106d07 <alltraps>

80107842 <vector165>:
.globl vector165
vector165:
  pushl $0
80107842:	6a 00                	push   $0x0
  pushl $165
80107844:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80107849:	e9 b9 f4 ff ff       	jmp    80106d07 <alltraps>

8010784e <vector166>:
.globl vector166
vector166:
  pushl $0
8010784e:	6a 00                	push   $0x0
  pushl $166
80107850:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107855:	e9 ad f4 ff ff       	jmp    80106d07 <alltraps>

8010785a <vector167>:
.globl vector167
vector167:
  pushl $0
8010785a:	6a 00                	push   $0x0
  pushl $167
8010785c:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107861:	e9 a1 f4 ff ff       	jmp    80106d07 <alltraps>

80107866 <vector168>:
.globl vector168
vector168:
  pushl $0
80107866:	6a 00                	push   $0x0
  pushl $168
80107868:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010786d:	e9 95 f4 ff ff       	jmp    80106d07 <alltraps>

80107872 <vector169>:
.globl vector169
vector169:
  pushl $0
80107872:	6a 00                	push   $0x0
  pushl $169
80107874:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80107879:	e9 89 f4 ff ff       	jmp    80106d07 <alltraps>

8010787e <vector170>:
.globl vector170
vector170:
  pushl $0
8010787e:	6a 00                	push   $0x0
  pushl $170
80107880:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107885:	e9 7d f4 ff ff       	jmp    80106d07 <alltraps>

8010788a <vector171>:
.globl vector171
vector171:
  pushl $0
8010788a:	6a 00                	push   $0x0
  pushl $171
8010788c:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107891:	e9 71 f4 ff ff       	jmp    80106d07 <alltraps>

80107896 <vector172>:
.globl vector172
vector172:
  pushl $0
80107896:	6a 00                	push   $0x0
  pushl $172
80107898:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010789d:	e9 65 f4 ff ff       	jmp    80106d07 <alltraps>

801078a2 <vector173>:
.globl vector173
vector173:
  pushl $0
801078a2:	6a 00                	push   $0x0
  pushl $173
801078a4:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801078a9:	e9 59 f4 ff ff       	jmp    80106d07 <alltraps>

801078ae <vector174>:
.globl vector174
vector174:
  pushl $0
801078ae:	6a 00                	push   $0x0
  pushl $174
801078b0:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801078b5:	e9 4d f4 ff ff       	jmp    80106d07 <alltraps>

801078ba <vector175>:
.globl vector175
vector175:
  pushl $0
801078ba:	6a 00                	push   $0x0
  pushl $175
801078bc:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801078c1:	e9 41 f4 ff ff       	jmp    80106d07 <alltraps>

801078c6 <vector176>:
.globl vector176
vector176:
  pushl $0
801078c6:	6a 00                	push   $0x0
  pushl $176
801078c8:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801078cd:	e9 35 f4 ff ff       	jmp    80106d07 <alltraps>

801078d2 <vector177>:
.globl vector177
vector177:
  pushl $0
801078d2:	6a 00                	push   $0x0
  pushl $177
801078d4:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801078d9:	e9 29 f4 ff ff       	jmp    80106d07 <alltraps>

801078de <vector178>:
.globl vector178
vector178:
  pushl $0
801078de:	6a 00                	push   $0x0
  pushl $178
801078e0:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801078e5:	e9 1d f4 ff ff       	jmp    80106d07 <alltraps>

801078ea <vector179>:
.globl vector179
vector179:
  pushl $0
801078ea:	6a 00                	push   $0x0
  pushl $179
801078ec:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801078f1:	e9 11 f4 ff ff       	jmp    80106d07 <alltraps>

801078f6 <vector180>:
.globl vector180
vector180:
  pushl $0
801078f6:	6a 00                	push   $0x0
  pushl $180
801078f8:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801078fd:	e9 05 f4 ff ff       	jmp    80106d07 <alltraps>

80107902 <vector181>:
.globl vector181
vector181:
  pushl $0
80107902:	6a 00                	push   $0x0
  pushl $181
80107904:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80107909:	e9 f9 f3 ff ff       	jmp    80106d07 <alltraps>

8010790e <vector182>:
.globl vector182
vector182:
  pushl $0
8010790e:	6a 00                	push   $0x0
  pushl $182
80107910:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107915:	e9 ed f3 ff ff       	jmp    80106d07 <alltraps>

8010791a <vector183>:
.globl vector183
vector183:
  pushl $0
8010791a:	6a 00                	push   $0x0
  pushl $183
8010791c:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107921:	e9 e1 f3 ff ff       	jmp    80106d07 <alltraps>

80107926 <vector184>:
.globl vector184
vector184:
  pushl $0
80107926:	6a 00                	push   $0x0
  pushl $184
80107928:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010792d:	e9 d5 f3 ff ff       	jmp    80106d07 <alltraps>

80107932 <vector185>:
.globl vector185
vector185:
  pushl $0
80107932:	6a 00                	push   $0x0
  pushl $185
80107934:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80107939:	e9 c9 f3 ff ff       	jmp    80106d07 <alltraps>

8010793e <vector186>:
.globl vector186
vector186:
  pushl $0
8010793e:	6a 00                	push   $0x0
  pushl $186
80107940:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107945:	e9 bd f3 ff ff       	jmp    80106d07 <alltraps>

8010794a <vector187>:
.globl vector187
vector187:
  pushl $0
8010794a:	6a 00                	push   $0x0
  pushl $187
8010794c:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107951:	e9 b1 f3 ff ff       	jmp    80106d07 <alltraps>

80107956 <vector188>:
.globl vector188
vector188:
  pushl $0
80107956:	6a 00                	push   $0x0
  pushl $188
80107958:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010795d:	e9 a5 f3 ff ff       	jmp    80106d07 <alltraps>

80107962 <vector189>:
.globl vector189
vector189:
  pushl $0
80107962:	6a 00                	push   $0x0
  pushl $189
80107964:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80107969:	e9 99 f3 ff ff       	jmp    80106d07 <alltraps>

8010796e <vector190>:
.globl vector190
vector190:
  pushl $0
8010796e:	6a 00                	push   $0x0
  pushl $190
80107970:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107975:	e9 8d f3 ff ff       	jmp    80106d07 <alltraps>

8010797a <vector191>:
.globl vector191
vector191:
  pushl $0
8010797a:	6a 00                	push   $0x0
  pushl $191
8010797c:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107981:	e9 81 f3 ff ff       	jmp    80106d07 <alltraps>

80107986 <vector192>:
.globl vector192
vector192:
  pushl $0
80107986:	6a 00                	push   $0x0
  pushl $192
80107988:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010798d:	e9 75 f3 ff ff       	jmp    80106d07 <alltraps>

80107992 <vector193>:
.globl vector193
vector193:
  pushl $0
80107992:	6a 00                	push   $0x0
  pushl $193
80107994:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80107999:	e9 69 f3 ff ff       	jmp    80106d07 <alltraps>

8010799e <vector194>:
.globl vector194
vector194:
  pushl $0
8010799e:	6a 00                	push   $0x0
  pushl $194
801079a0:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801079a5:	e9 5d f3 ff ff       	jmp    80106d07 <alltraps>

801079aa <vector195>:
.globl vector195
vector195:
  pushl $0
801079aa:	6a 00                	push   $0x0
  pushl $195
801079ac:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801079b1:	e9 51 f3 ff ff       	jmp    80106d07 <alltraps>

801079b6 <vector196>:
.globl vector196
vector196:
  pushl $0
801079b6:	6a 00                	push   $0x0
  pushl $196
801079b8:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801079bd:	e9 45 f3 ff ff       	jmp    80106d07 <alltraps>

801079c2 <vector197>:
.globl vector197
vector197:
  pushl $0
801079c2:	6a 00                	push   $0x0
  pushl $197
801079c4:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801079c9:	e9 39 f3 ff ff       	jmp    80106d07 <alltraps>

801079ce <vector198>:
.globl vector198
vector198:
  pushl $0
801079ce:	6a 00                	push   $0x0
  pushl $198
801079d0:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801079d5:	e9 2d f3 ff ff       	jmp    80106d07 <alltraps>

801079da <vector199>:
.globl vector199
vector199:
  pushl $0
801079da:	6a 00                	push   $0x0
  pushl $199
801079dc:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801079e1:	e9 21 f3 ff ff       	jmp    80106d07 <alltraps>

801079e6 <vector200>:
.globl vector200
vector200:
  pushl $0
801079e6:	6a 00                	push   $0x0
  pushl $200
801079e8:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801079ed:	e9 15 f3 ff ff       	jmp    80106d07 <alltraps>

801079f2 <vector201>:
.globl vector201
vector201:
  pushl $0
801079f2:	6a 00                	push   $0x0
  pushl $201
801079f4:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801079f9:	e9 09 f3 ff ff       	jmp    80106d07 <alltraps>

801079fe <vector202>:
.globl vector202
vector202:
  pushl $0
801079fe:	6a 00                	push   $0x0
  pushl $202
80107a00:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107a05:	e9 fd f2 ff ff       	jmp    80106d07 <alltraps>

80107a0a <vector203>:
.globl vector203
vector203:
  pushl $0
80107a0a:	6a 00                	push   $0x0
  pushl $203
80107a0c:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107a11:	e9 f1 f2 ff ff       	jmp    80106d07 <alltraps>

80107a16 <vector204>:
.globl vector204
vector204:
  pushl $0
80107a16:	6a 00                	push   $0x0
  pushl $204
80107a18:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80107a1d:	e9 e5 f2 ff ff       	jmp    80106d07 <alltraps>

80107a22 <vector205>:
.globl vector205
vector205:
  pushl $0
80107a22:	6a 00                	push   $0x0
  pushl $205
80107a24:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80107a29:	e9 d9 f2 ff ff       	jmp    80106d07 <alltraps>

80107a2e <vector206>:
.globl vector206
vector206:
  pushl $0
80107a2e:	6a 00                	push   $0x0
  pushl $206
80107a30:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107a35:	e9 cd f2 ff ff       	jmp    80106d07 <alltraps>

80107a3a <vector207>:
.globl vector207
vector207:
  pushl $0
80107a3a:	6a 00                	push   $0x0
  pushl $207
80107a3c:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107a41:	e9 c1 f2 ff ff       	jmp    80106d07 <alltraps>

80107a46 <vector208>:
.globl vector208
vector208:
  pushl $0
80107a46:	6a 00                	push   $0x0
  pushl $208
80107a48:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80107a4d:	e9 b5 f2 ff ff       	jmp    80106d07 <alltraps>

80107a52 <vector209>:
.globl vector209
vector209:
  pushl $0
80107a52:	6a 00                	push   $0x0
  pushl $209
80107a54:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80107a59:	e9 a9 f2 ff ff       	jmp    80106d07 <alltraps>

80107a5e <vector210>:
.globl vector210
vector210:
  pushl $0
80107a5e:	6a 00                	push   $0x0
  pushl $210
80107a60:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107a65:	e9 9d f2 ff ff       	jmp    80106d07 <alltraps>

80107a6a <vector211>:
.globl vector211
vector211:
  pushl $0
80107a6a:	6a 00                	push   $0x0
  pushl $211
80107a6c:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107a71:	e9 91 f2 ff ff       	jmp    80106d07 <alltraps>

80107a76 <vector212>:
.globl vector212
vector212:
  pushl $0
80107a76:	6a 00                	push   $0x0
  pushl $212
80107a78:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80107a7d:	e9 85 f2 ff ff       	jmp    80106d07 <alltraps>

80107a82 <vector213>:
.globl vector213
vector213:
  pushl $0
80107a82:	6a 00                	push   $0x0
  pushl $213
80107a84:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80107a89:	e9 79 f2 ff ff       	jmp    80106d07 <alltraps>

80107a8e <vector214>:
.globl vector214
vector214:
  pushl $0
80107a8e:	6a 00                	push   $0x0
  pushl $214
80107a90:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107a95:	e9 6d f2 ff ff       	jmp    80106d07 <alltraps>

80107a9a <vector215>:
.globl vector215
vector215:
  pushl $0
80107a9a:	6a 00                	push   $0x0
  pushl $215
80107a9c:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107aa1:	e9 61 f2 ff ff       	jmp    80106d07 <alltraps>

80107aa6 <vector216>:
.globl vector216
vector216:
  pushl $0
80107aa6:	6a 00                	push   $0x0
  pushl $216
80107aa8:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80107aad:	e9 55 f2 ff ff       	jmp    80106d07 <alltraps>

80107ab2 <vector217>:
.globl vector217
vector217:
  pushl $0
80107ab2:	6a 00                	push   $0x0
  pushl $217
80107ab4:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80107ab9:	e9 49 f2 ff ff       	jmp    80106d07 <alltraps>

80107abe <vector218>:
.globl vector218
vector218:
  pushl $0
80107abe:	6a 00                	push   $0x0
  pushl $218
80107ac0:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107ac5:	e9 3d f2 ff ff       	jmp    80106d07 <alltraps>

80107aca <vector219>:
.globl vector219
vector219:
  pushl $0
80107aca:	6a 00                	push   $0x0
  pushl $219
80107acc:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107ad1:	e9 31 f2 ff ff       	jmp    80106d07 <alltraps>

80107ad6 <vector220>:
.globl vector220
vector220:
  pushl $0
80107ad6:	6a 00                	push   $0x0
  pushl $220
80107ad8:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80107add:	e9 25 f2 ff ff       	jmp    80106d07 <alltraps>

80107ae2 <vector221>:
.globl vector221
vector221:
  pushl $0
80107ae2:	6a 00                	push   $0x0
  pushl $221
80107ae4:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80107ae9:	e9 19 f2 ff ff       	jmp    80106d07 <alltraps>

80107aee <vector222>:
.globl vector222
vector222:
  pushl $0
80107aee:	6a 00                	push   $0x0
  pushl $222
80107af0:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107af5:	e9 0d f2 ff ff       	jmp    80106d07 <alltraps>

80107afa <vector223>:
.globl vector223
vector223:
  pushl $0
80107afa:	6a 00                	push   $0x0
  pushl $223
80107afc:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107b01:	e9 01 f2 ff ff       	jmp    80106d07 <alltraps>

80107b06 <vector224>:
.globl vector224
vector224:
  pushl $0
80107b06:	6a 00                	push   $0x0
  pushl $224
80107b08:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80107b0d:	e9 f5 f1 ff ff       	jmp    80106d07 <alltraps>

80107b12 <vector225>:
.globl vector225
vector225:
  pushl $0
80107b12:	6a 00                	push   $0x0
  pushl $225
80107b14:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107b19:	e9 e9 f1 ff ff       	jmp    80106d07 <alltraps>

80107b1e <vector226>:
.globl vector226
vector226:
  pushl $0
80107b1e:	6a 00                	push   $0x0
  pushl $226
80107b20:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107b25:	e9 dd f1 ff ff       	jmp    80106d07 <alltraps>

80107b2a <vector227>:
.globl vector227
vector227:
  pushl $0
80107b2a:	6a 00                	push   $0x0
  pushl $227
80107b2c:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107b31:	e9 d1 f1 ff ff       	jmp    80106d07 <alltraps>

80107b36 <vector228>:
.globl vector228
vector228:
  pushl $0
80107b36:	6a 00                	push   $0x0
  pushl $228
80107b38:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80107b3d:	e9 c5 f1 ff ff       	jmp    80106d07 <alltraps>

80107b42 <vector229>:
.globl vector229
vector229:
  pushl $0
80107b42:	6a 00                	push   $0x0
  pushl $229
80107b44:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80107b49:	e9 b9 f1 ff ff       	jmp    80106d07 <alltraps>

80107b4e <vector230>:
.globl vector230
vector230:
  pushl $0
80107b4e:	6a 00                	push   $0x0
  pushl $230
80107b50:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107b55:	e9 ad f1 ff ff       	jmp    80106d07 <alltraps>

80107b5a <vector231>:
.globl vector231
vector231:
  pushl $0
80107b5a:	6a 00                	push   $0x0
  pushl $231
80107b5c:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107b61:	e9 a1 f1 ff ff       	jmp    80106d07 <alltraps>

80107b66 <vector232>:
.globl vector232
vector232:
  pushl $0
80107b66:	6a 00                	push   $0x0
  pushl $232
80107b68:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107b6d:	e9 95 f1 ff ff       	jmp    80106d07 <alltraps>

80107b72 <vector233>:
.globl vector233
vector233:
  pushl $0
80107b72:	6a 00                	push   $0x0
  pushl $233
80107b74:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107b79:	e9 89 f1 ff ff       	jmp    80106d07 <alltraps>

80107b7e <vector234>:
.globl vector234
vector234:
  pushl $0
80107b7e:	6a 00                	push   $0x0
  pushl $234
80107b80:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107b85:	e9 7d f1 ff ff       	jmp    80106d07 <alltraps>

80107b8a <vector235>:
.globl vector235
vector235:
  pushl $0
80107b8a:	6a 00                	push   $0x0
  pushl $235
80107b8c:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107b91:	e9 71 f1 ff ff       	jmp    80106d07 <alltraps>

80107b96 <vector236>:
.globl vector236
vector236:
  pushl $0
80107b96:	6a 00                	push   $0x0
  pushl $236
80107b98:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107b9d:	e9 65 f1 ff ff       	jmp    80106d07 <alltraps>

80107ba2 <vector237>:
.globl vector237
vector237:
  pushl $0
80107ba2:	6a 00                	push   $0x0
  pushl $237
80107ba4:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107ba9:	e9 59 f1 ff ff       	jmp    80106d07 <alltraps>

80107bae <vector238>:
.globl vector238
vector238:
  pushl $0
80107bae:	6a 00                	push   $0x0
  pushl $238
80107bb0:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107bb5:	e9 4d f1 ff ff       	jmp    80106d07 <alltraps>

80107bba <vector239>:
.globl vector239
vector239:
  pushl $0
80107bba:	6a 00                	push   $0x0
  pushl $239
80107bbc:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107bc1:	e9 41 f1 ff ff       	jmp    80106d07 <alltraps>

80107bc6 <vector240>:
.globl vector240
vector240:
  pushl $0
80107bc6:	6a 00                	push   $0x0
  pushl $240
80107bc8:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107bcd:	e9 35 f1 ff ff       	jmp    80106d07 <alltraps>

80107bd2 <vector241>:
.globl vector241
vector241:
  pushl $0
80107bd2:	6a 00                	push   $0x0
  pushl $241
80107bd4:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107bd9:	e9 29 f1 ff ff       	jmp    80106d07 <alltraps>

80107bde <vector242>:
.globl vector242
vector242:
  pushl $0
80107bde:	6a 00                	push   $0x0
  pushl $242
80107be0:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107be5:	e9 1d f1 ff ff       	jmp    80106d07 <alltraps>

80107bea <vector243>:
.globl vector243
vector243:
  pushl $0
80107bea:	6a 00                	push   $0x0
  pushl $243
80107bec:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107bf1:	e9 11 f1 ff ff       	jmp    80106d07 <alltraps>

80107bf6 <vector244>:
.globl vector244
vector244:
  pushl $0
80107bf6:	6a 00                	push   $0x0
  pushl $244
80107bf8:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107bfd:	e9 05 f1 ff ff       	jmp    80106d07 <alltraps>

80107c02 <vector245>:
.globl vector245
vector245:
  pushl $0
80107c02:	6a 00                	push   $0x0
  pushl $245
80107c04:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107c09:	e9 f9 f0 ff ff       	jmp    80106d07 <alltraps>

80107c0e <vector246>:
.globl vector246
vector246:
  pushl $0
80107c0e:	6a 00                	push   $0x0
  pushl $246
80107c10:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107c15:	e9 ed f0 ff ff       	jmp    80106d07 <alltraps>

80107c1a <vector247>:
.globl vector247
vector247:
  pushl $0
80107c1a:	6a 00                	push   $0x0
  pushl $247
80107c1c:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107c21:	e9 e1 f0 ff ff       	jmp    80106d07 <alltraps>

80107c26 <vector248>:
.globl vector248
vector248:
  pushl $0
80107c26:	6a 00                	push   $0x0
  pushl $248
80107c28:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107c2d:	e9 d5 f0 ff ff       	jmp    80106d07 <alltraps>

80107c32 <vector249>:
.globl vector249
vector249:
  pushl $0
80107c32:	6a 00                	push   $0x0
  pushl $249
80107c34:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107c39:	e9 c9 f0 ff ff       	jmp    80106d07 <alltraps>

80107c3e <vector250>:
.globl vector250
vector250:
  pushl $0
80107c3e:	6a 00                	push   $0x0
  pushl $250
80107c40:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107c45:	e9 bd f0 ff ff       	jmp    80106d07 <alltraps>

80107c4a <vector251>:
.globl vector251
vector251:
  pushl $0
80107c4a:	6a 00                	push   $0x0
  pushl $251
80107c4c:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107c51:	e9 b1 f0 ff ff       	jmp    80106d07 <alltraps>

80107c56 <vector252>:
.globl vector252
vector252:
  pushl $0
80107c56:	6a 00                	push   $0x0
  pushl $252
80107c58:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107c5d:	e9 a5 f0 ff ff       	jmp    80106d07 <alltraps>

80107c62 <vector253>:
.globl vector253
vector253:
  pushl $0
80107c62:	6a 00                	push   $0x0
  pushl $253
80107c64:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107c69:	e9 99 f0 ff ff       	jmp    80106d07 <alltraps>

80107c6e <vector254>:
.globl vector254
vector254:
  pushl $0
80107c6e:	6a 00                	push   $0x0
  pushl $254
80107c70:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107c75:	e9 8d f0 ff ff       	jmp    80106d07 <alltraps>

80107c7a <vector255>:
.globl vector255
vector255:
  pushl $0
80107c7a:	6a 00                	push   $0x0
  pushl $255
80107c7c:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107c81:	e9 81 f0 ff ff       	jmp    80106d07 <alltraps>
80107c86:	66 90                	xchg   %ax,%ax
80107c88:	66 90                	xchg   %ax,%ax
80107c8a:	66 90                	xchg   %ax,%ax
80107c8c:	66 90                	xchg   %ax,%ax
80107c8e:	66 90                	xchg   %ax,%ax

80107c90 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107c90:	55                   	push   %ebp
80107c91:	89 e5                	mov    %esp,%ebp
80107c93:	83 ec 28             	sub    $0x28,%esp
80107c96:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80107c99:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107c9b:	c1 ea 16             	shr    $0x16,%edx
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107c9e:	89 7d fc             	mov    %edi,-0x4(%ebp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107ca1:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107ca4:	89 75 f8             	mov    %esi,-0x8(%ebp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
80107ca7:	8b 07                	mov    (%edi),%eax
80107ca9:	a8 01                	test   $0x1,%al
80107cab:	74 2b                	je     80107cd8 <walkpgdir+0x48>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107cad:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107cb2:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107cb8:	c1 eb 0a             	shr    $0xa,%ebx
}
80107cbb:	8b 7d fc             	mov    -0x4(%ebp),%edi
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107cbe:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
80107cc4:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
80107cc7:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107cca:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107ccd:	89 ec                	mov    %ebp,%esp
80107ccf:	5d                   	pop    %ebp
80107cd0:	c3                   	ret    
80107cd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107cd8:	85 c9                	test   %ecx,%ecx
80107cda:	74 34                	je     80107d10 <walkpgdir+0x80>
80107cdc:	e8 7f a8 ff ff       	call   80102560 <kalloc>
80107ce1:	85 c0                	test   %eax,%eax
80107ce3:	89 c6                	mov    %eax,%esi
80107ce5:	74 29                	je     80107d10 <walkpgdir+0x80>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80107ce7:	b8 00 10 00 00       	mov    $0x1000,%eax
80107cec:	31 d2                	xor    %edx,%edx
80107cee:	89 44 24 08          	mov    %eax,0x8(%esp)
80107cf2:	89 54 24 04          	mov    %edx,0x4(%esp)
80107cf6:	89 34 24             	mov    %esi,(%esp)
80107cf9:	e8 62 dd ff ff       	call   80105a60 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107cfe:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107d04:	83 c8 07             	or     $0x7,%eax
80107d07:	89 07                	mov    %eax,(%edi)
80107d09:	eb ad                	jmp    80107cb8 <walkpgdir+0x28>
80107d0b:	90                   	nop
80107d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  return &pgtab[PTX(va)];
}
80107d10:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
80107d13:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80107d15:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107d18:	8b 7d fc             	mov    -0x4(%ebp),%edi
80107d1b:	89 ec                	mov    %ebp,%esp
80107d1d:	5d                   	pop    %ebp
80107d1e:	c3                   	ret    
80107d1f:	90                   	nop

80107d20 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107d20:	55                   	push   %ebp
80107d21:	89 e5                	mov    %esp,%ebp
80107d23:	57                   	push   %edi
80107d24:	56                   	push   %esi
80107d25:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107d26:	89 d3                	mov    %edx,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107d28:	83 ec 2c             	sub    $0x2c,%esp
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107d2b:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107d31:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107d34:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107d38:	8b 7d 08             	mov    0x8(%ebp),%edi
80107d3b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107d40:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80107d43:	8b 45 0c             	mov    0xc(%ebp),%eax
80107d46:	29 df                	sub    %ebx,%edi
80107d48:	83 c8 01             	or     $0x1,%eax
80107d4b:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107d4e:	eb 17                	jmp    80107d67 <mappages+0x47>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80107d50:	f6 00 01             	testb  $0x1,(%eax)
80107d53:	75 45                	jne    80107d9a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80107d55:	8b 55 dc             	mov    -0x24(%ebp),%edx
80107d58:	09 d6                	or     %edx,%esi
    if(a == last)
80107d5a:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80107d5d:	89 30                	mov    %esi,(%eax)
    if(a == last)
80107d5f:	74 2f                	je     80107d90 <mappages+0x70>
      break;
    a += PGSIZE;
80107d61:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107d67:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107d6a:	b9 01 00 00 00       	mov    $0x1,%ecx
80107d6f:	89 da                	mov    %ebx,%edx
80107d71:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80107d74:	e8 17 ff ff ff       	call   80107c90 <walkpgdir>
80107d79:	85 c0                	test   %eax,%eax
80107d7b:	75 d3                	jne    80107d50 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80107d7d:	83 c4 2c             	add    $0x2c,%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
80107d80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80107d85:	5b                   	pop    %ebx
80107d86:	5e                   	pop    %esi
80107d87:	5f                   	pop    %edi
80107d88:	5d                   	pop    %ebp
80107d89:	c3                   	ret    
80107d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107d90:	83 c4 2c             	add    $0x2c,%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80107d93:	31 c0                	xor    %eax,%eax
}
80107d95:	5b                   	pop    %ebx
80107d96:	5e                   	pop    %esi
80107d97:	5f                   	pop    %edi
80107d98:	5d                   	pop    %ebp
80107d99:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
80107d9a:	c7 04 24 b0 90 10 80 	movl   $0x801090b0,(%esp)
80107da1:	e8 9a 85 ff ff       	call   80100340 <panic>
80107da6:	8d 76 00             	lea    0x0(%esi),%esi
80107da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107db0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107db0:	55                   	push   %ebp
80107db1:	89 e5                	mov    %esp,%ebp
80107db3:	57                   	push   %edi
80107db4:	89 c7                	mov    %eax,%edi
80107db6:	56                   	push   %esi
80107db7:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107db8:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107dbe:	83 ec 2c             	sub    $0x2c,%esp
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107dc1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107dc7:	39 d3                	cmp    %edx,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107dc9:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80107dcc:	73 62                	jae    80107e30 <deallocuvm.part.0+0x80>
80107dce:	89 d6                	mov    %edx,%esi
80107dd0:	eb 39                	jmp    80107e0b <deallocuvm.part.0+0x5b>
80107dd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80107dd8:	8b 10                	mov    (%eax),%edx
80107dda:	f6 c2 01             	test   $0x1,%dl
80107ddd:	74 22                	je     80107e01 <deallocuvm.part.0+0x51>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80107ddf:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107de5:	74 54                	je     80107e3b <deallocuvm.part.0+0x8b>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80107de7:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80107ded:	89 14 24             	mov    %edx,(%esp)
80107df0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107df3:	e8 98 a5 ff ff       	call   80102390 <kfree>
      *pte = 0;
80107df8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107dfb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80107e01:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107e07:	39 f3                	cmp    %esi,%ebx
80107e09:	73 25                	jae    80107e30 <deallocuvm.part.0+0x80>
    pte = walkpgdir(pgdir, (char*)a, 0);
80107e0b:	31 c9                	xor    %ecx,%ecx
80107e0d:	89 da                	mov    %ebx,%edx
80107e0f:	89 f8                	mov    %edi,%eax
80107e11:	e8 7a fe ff ff       	call   80107c90 <walkpgdir>
    if(!pte)
80107e16:	85 c0                	test   %eax,%eax
80107e18:	75 be                	jne    80107dd8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107e1a:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80107e20:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80107e26:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107e2c:	39 f3                	cmp    %esi,%ebx
80107e2e:	72 db                	jb     80107e0b <deallocuvm.part.0+0x5b>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80107e30:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107e33:	83 c4 2c             	add    $0x2c,%esp
80107e36:	5b                   	pop    %ebx
80107e37:	5e                   	pop    %esi
80107e38:	5f                   	pop    %edi
80107e39:	5d                   	pop    %ebp
80107e3a:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80107e3b:	c7 04 24 a6 88 10 80 	movl   $0x801088a6,(%esp)
80107e42:	e8 f9 84 ff ff       	call   80100340 <panic>
80107e47:	89 f6                	mov    %esi,%esi
80107e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107e50 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80107e50:	55                   	push   %ebp
80107e51:	89 e5                	mov    %esp,%ebp
80107e53:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80107e56:	e8 e5 ba ff ff       	call   80103940 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107e5b:	31 c9                	xor    %ecx,%ecx
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80107e5d:	66 c7 45 f2 2f 00    	movw   $0x2f,-0xe(%ebp)
80107e63:	8d 14 80             	lea    (%eax,%eax,4),%edx
80107e66:	8d 14 50             	lea    (%eax,%edx,2),%edx
80107e69:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107e6e:	c1 e2 04             	shl    $0x4,%edx
80107e71:	66 89 82 58 48 11 80 	mov    %ax,-0x7feeb7a8(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107e78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107e7d:	66 89 82 60 48 11 80 	mov    %ax,-0x7feeb7a0(%edx)
80107e84:	31 c0                	xor    %eax,%eax
80107e86:	66 89 82 62 48 11 80 	mov    %ax,-0x7feeb79e(%edx)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107e8d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107e92:	66 89 82 68 48 11 80 	mov    %ax,-0x7feeb798(%edx)
80107e99:	31 c0                	xor    %eax,%eax
80107e9b:	66 89 82 6a 48 11 80 	mov    %ax,-0x7feeb796(%edx)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107ea2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107ea7:	66 89 82 70 48 11 80 	mov    %ax,-0x7feeb790(%edx)
80107eae:	31 c0                	xor    %eax,%eax
80107eb0:	66 89 82 72 48 11 80 	mov    %ax,-0x7feeb78e(%edx)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107eb7:	66 89 8a 5a 48 11 80 	mov    %cx,-0x7feeb7a6(%edx)
80107ebe:	c6 82 5c 48 11 80 00 	movb   $0x0,-0x7feeb7a4(%edx)
80107ec5:	c6 82 5d 48 11 80 9a 	movb   $0x9a,-0x7feeb7a3(%edx)
80107ecc:	c6 82 5e 48 11 80 cf 	movb   $0xcf,-0x7feeb7a2(%edx)
80107ed3:	c6 82 5f 48 11 80 00 	movb   $0x0,-0x7feeb7a1(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107eda:	c6 82 64 48 11 80 00 	movb   $0x0,-0x7feeb79c(%edx)
80107ee1:	c6 82 65 48 11 80 92 	movb   $0x92,-0x7feeb79b(%edx)
80107ee8:	c6 82 66 48 11 80 cf 	movb   $0xcf,-0x7feeb79a(%edx)
80107eef:	c6 82 67 48 11 80 00 	movb   $0x0,-0x7feeb799(%edx)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107ef6:	c6 82 6c 48 11 80 00 	movb   $0x0,-0x7feeb794(%edx)
80107efd:	c6 82 6d 48 11 80 fa 	movb   $0xfa,-0x7feeb793(%edx)
80107f04:	c6 82 6e 48 11 80 cf 	movb   $0xcf,-0x7feeb792(%edx)
80107f0b:	c6 82 6f 48 11 80 00 	movb   $0x0,-0x7feeb791(%edx)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107f12:	c6 82 74 48 11 80 00 	movb   $0x0,-0x7feeb78c(%edx)
80107f19:	c6 82 75 48 11 80 f2 	movb   $0xf2,-0x7feeb78b(%edx)
80107f20:	c6 82 76 48 11 80 cf 	movb   $0xcf,-0x7feeb78a(%edx)
80107f27:	c6 82 77 48 11 80 00 	movb   $0x0,-0x7feeb789(%edx)
  lgdt(c->gdt, sizeof(c->gdt));
80107f2e:	81 c2 50 48 11 80    	add    $0x80114850,%edx
  pd[1] = (uint)p;
80107f34:	0f b7 c2             	movzwl %dx,%eax
  pd[2] = (uint)p >> 16;
80107f37:	c1 ea 10             	shr    $0x10,%edx
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  pd[1] = (uint)p;
80107f3a:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;

  asm volatile("lgdt (%0)" : : "r" (pd));
80107f3e:	8d 45 f2             	lea    -0xe(%ebp),%eax
{
  volatile ushort pd[3];

  pd[0] = size-1;
  pd[1] = (uint)p;
  pd[2] = (uint)p >> 16;
80107f41:	66 89 55 f6          	mov    %dx,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80107f45:	0f 01 10             	lgdtl  (%eax)
}
80107f48:	c9                   	leave  
80107f49:	c3                   	ret    
80107f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107f50 <switchkvm>:
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107f50:	a1 04 80 11 80       	mov    0x80118004,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80107f55:	55                   	push   %ebp
80107f56:	89 e5                	mov    %esp,%ebp
80107f58:	05 00 00 00 80       	add    $0x80000000,%eax
80107f5d:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
80107f60:	5d                   	pop    %ebp
80107f61:	c3                   	ret    
80107f62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107f70 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80107f70:	55                   	push   %ebp
80107f71:	89 e5                	mov    %esp,%ebp
80107f73:	57                   	push   %edi
80107f74:	56                   	push   %esi
80107f75:	53                   	push   %ebx
80107f76:	83 ec 2c             	sub    $0x2c,%esp
80107f79:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80107f7c:	85 f6                	test   %esi,%esi
80107f7e:	0f 84 c7 00 00 00    	je     8010804b <switchuvm+0xdb>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80107f84:	8b 5e 08             	mov    0x8(%esi),%ebx
80107f87:	85 db                	test   %ebx,%ebx
80107f89:	0f 84 d4 00 00 00    	je     80108063 <switchuvm+0xf3>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80107f8f:	8b 4e 04             	mov    0x4(%esi),%ecx
80107f92:	85 c9                	test   %ecx,%ecx
80107f94:	0f 84 bd 00 00 00    	je     80108057 <switchuvm+0xe7>
    panic("switchuvm: no pgdir");

  pushcli();
80107f9a:	e8 e1 d8 ff ff       	call   80105880 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107f9f:	e8 1c b9 ff ff       	call   801038c0 <mycpu>
80107fa4:	89 c3                	mov    %eax,%ebx
80107fa6:	e8 15 b9 ff ff       	call   801038c0 <mycpu>
80107fab:	89 c7                	mov    %eax,%edi
80107fad:	e8 0e b9 ff ff       	call   801038c0 <mycpu>
80107fb2:	83 c7 08             	add    $0x8,%edi
80107fb5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107fb8:	e8 03 b9 ff ff       	call   801038c0 <mycpu>
80107fbd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107fc0:	ba 67 00 00 00       	mov    $0x67,%edx
80107fc5:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80107fcc:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80107fd3:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
80107fda:	83 c1 08             	add    $0x8,%ecx
80107fdd:	c1 e9 10             	shr    $0x10,%ecx
80107fe0:	83 c0 08             	add    $0x8,%eax
80107fe3:	c1 e8 18             	shr    $0x18,%eax
80107fe6:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107fec:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80107ff3:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
80107ff9:	e8 c2 b8 ff ff       	call   801038c0 <mycpu>
80107ffe:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80108005:	e8 b6 b8 ff ff       	call   801038c0 <mycpu>
8010800a:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80108010:	e8 ab b8 ff ff       	call   801038c0 <mycpu>
80108015:	8b 56 08             	mov    0x8(%esi),%edx
80108018:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
8010801e:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80108021:	e8 9a b8 ff ff       	call   801038c0 <mycpu>
80108026:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
8010802c:	b8 28 00 00 00       	mov    $0x28,%eax
80108031:	0f 00 d8             	ltr    %ax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80108034:	8b 46 04             	mov    0x4(%esi),%eax
80108037:	05 00 00 00 80       	add    $0x80000000,%eax
8010803c:	0f 22 d8             	mov    %eax,%cr3
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
8010803f:	83 c4 2c             	add    $0x2c,%esp
80108042:	5b                   	pop    %ebx
80108043:	5e                   	pop    %esi
80108044:	5f                   	pop    %edi
80108045:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
80108046:	e9 75 d8 ff ff       	jmp    801058c0 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
8010804b:	c7 04 24 b6 90 10 80 	movl   $0x801090b6,(%esp)
80108052:	e8 e9 82 ff ff       	call   80100340 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
80108057:	c7 04 24 e1 90 10 80 	movl   $0x801090e1,(%esp)
8010805e:	e8 dd 82 ff ff       	call   80100340 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
80108063:	c7 04 24 cc 90 10 80 	movl   $0x801090cc,(%esp)
8010806a:	e8 d1 82 ff ff       	call   80100340 <panic>
8010806f:	90                   	nop

80108070 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80108070:	55                   	push   %ebp
80108071:	89 e5                	mov    %esp,%ebp
80108073:	83 ec 38             	sub    $0x38,%esp
80108076:	89 75 f8             	mov    %esi,-0x8(%ebp)
80108079:	8b 75 10             	mov    0x10(%ebp),%esi
8010807c:	8b 45 08             	mov    0x8(%ebp),%eax
8010807f:	89 7d fc             	mov    %edi,-0x4(%ebp)
80108082:	8b 7d 0c             	mov    0xc(%ebp),%edi
80108085:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80108088:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
8010808e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80108091:	77 59                	ja     801080ec <inituvm+0x7c>
    panic("inituvm: more than a page");
  mem = kalloc();
80108093:	e8 c8 a4 ff ff       	call   80102560 <kalloc>
  memset(mem, 0, PGSIZE);
80108098:	31 d2                	xor    %edx,%edx
8010809a:	89 54 24 04          	mov    %edx,0x4(%esp)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
8010809e:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801080a0:	b8 00 10 00 00       	mov    $0x1000,%eax
801080a5:	89 1c 24             	mov    %ebx,(%esp)
801080a8:	89 44 24 08          	mov    %eax,0x8(%esp)
801080ac:	e8 af d9 ff ff       	call   80105a60 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801080b1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801080b7:	b9 06 00 00 00       	mov    $0x6,%ecx
801080bc:	89 04 24             	mov    %eax,(%esp)
801080bf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801080c2:	31 d2                	xor    %edx,%edx
801080c4:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801080c8:	b9 00 10 00 00       	mov    $0x1000,%ecx
801080cd:	e8 4e fc ff ff       	call   80107d20 <mappages>
  memmove(mem, init, sz);
801080d2:	89 75 10             	mov    %esi,0x10(%ebp)
}
801080d5:	8b 75 f8             	mov    -0x8(%ebp),%esi
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
801080d8:	89 7d 0c             	mov    %edi,0xc(%ebp)
}
801080db:	8b 7d fc             	mov    -0x4(%ebp),%edi
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
801080de:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801080e1:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801080e4:	89 ec                	mov    %ebp,%esp
801080e6:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
801080e7:	e9 34 da ff ff       	jmp    80105b20 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
801080ec:	c7 04 24 f5 90 10 80 	movl   $0x801090f5,(%esp)
801080f3:	e8 48 82 ff ff       	call   80100340 <panic>
801080f8:	90                   	nop
801080f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108100 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80108100:	55                   	push   %ebp
80108101:	89 e5                	mov    %esp,%ebp
80108103:	57                   	push   %edi
80108104:	56                   	push   %esi
80108105:	53                   	push   %ebx
80108106:	83 ec 1c             	sub    $0x1c,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80108109:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80108110:	0f 85 98 00 00 00    	jne    801081ae <loaduvm+0xae>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80108116:	8b 75 18             	mov    0x18(%ebp),%esi
80108119:	31 db                	xor    %ebx,%ebx
8010811b:	85 f6                	test   %esi,%esi
8010811d:	75 1a                	jne    80108139 <loaduvm+0x39>
8010811f:	eb 77                	jmp    80108198 <loaduvm+0x98>
80108121:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108128:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010812e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80108134:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80108137:	76 5f                	jbe    80108198 <loaduvm+0x98>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80108139:	8b 55 0c             	mov    0xc(%ebp),%edx
8010813c:	31 c9                	xor    %ecx,%ecx
8010813e:	8b 45 08             	mov    0x8(%ebp),%eax
80108141:	01 da                	add    %ebx,%edx
80108143:	e8 48 fb ff ff       	call   80107c90 <walkpgdir>
80108148:	85 c0                	test   %eax,%eax
8010814a:	74 56                	je     801081a2 <loaduvm+0xa2>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
8010814c:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
8010814e:	bf 00 10 00 00       	mov    $0x1000,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80108153:	8b 4d 14             	mov    0x14(%ebp),%ecx
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80108156:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
8010815b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80108161:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80108164:	05 00 00 00 80       	add    $0x80000000,%eax
80108169:	89 44 24 04          	mov    %eax,0x4(%esp)
8010816d:	8b 45 10             	mov    0x10(%ebp),%eax
80108170:	01 d9                	add    %ebx,%ecx
80108172:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80108176:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010817a:	89 04 24             	mov    %eax,(%esp)
8010817d:	e8 4e 98 ff ff       	call   801019d0 <readi>
80108182:	39 c7                	cmp    %eax,%edi
80108184:	74 a2                	je     80108128 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80108186:	83 c4 1c             	add    $0x1c,%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80108189:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
8010818e:	5b                   	pop    %ebx
8010818f:	5e                   	pop    %esi
80108190:	5f                   	pop    %edi
80108191:	5d                   	pop    %ebp
80108192:	c3                   	ret    
80108193:	90                   	nop
80108194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108198:	83 c4 1c             	add    $0x1c,%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
8010819b:	31 c0                	xor    %eax,%eax
}
8010819d:	5b                   	pop    %ebx
8010819e:	5e                   	pop    %esi
8010819f:	5f                   	pop    %edi
801081a0:	5d                   	pop    %ebp
801081a1:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
801081a2:	c7 04 24 0f 91 10 80 	movl   $0x8010910f,(%esp)
801081a9:	e8 92 81 ff ff       	call   80100340 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
801081ae:	c7 04 24 b0 91 10 80 	movl   $0x801091b0,(%esp)
801081b5:	e8 86 81 ff ff       	call   80100340 <panic>
801081ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801081c0 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
801081c0:	55                   	push   %ebp
801081c1:	89 e5                	mov    %esp,%ebp
801081c3:	57                   	push   %edi
801081c4:	56                   	push   %esi
801081c5:	53                   	push   %ebx
801081c6:	83 ec 1c             	sub    $0x1c,%esp
801081c9:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
801081cc:	85 ff                	test   %edi,%edi
801081ce:	0f 88 ca 00 00 00    	js     8010829e <allocuvm+0xde>
    return 0;
  if(newsz < oldsz)
801081d4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
801081d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
801081da:	0f 82 89 00 00 00    	jb     80108269 <allocuvm+0xa9>
    return oldsz;

  a = PGROUNDUP(oldsz);
801081e0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801081e6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
801081ec:	39 df                	cmp    %ebx,%edi
801081ee:	77 4e                	ja     8010823e <allocuvm+0x7e>
801081f0:	e9 bb 00 00 00       	jmp    801082b0 <allocuvm+0xf0>
801081f5:	8d 76 00             	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
801081f8:	31 d2                	xor    %edx,%edx
801081fa:	b8 00 10 00 00       	mov    $0x1000,%eax
801081ff:	89 54 24 04          	mov    %edx,0x4(%esp)
80108203:	89 44 24 08          	mov    %eax,0x8(%esp)
80108207:	89 34 24             	mov    %esi,(%esp)
8010820a:	e8 51 d8 ff ff       	call   80105a60 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
8010820f:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80108215:	b9 06 00 00 00       	mov    $0x6,%ecx
8010821a:	89 04 24             	mov    %eax,(%esp)
8010821d:	8b 45 08             	mov    0x8(%ebp),%eax
80108220:	89 da                	mov    %ebx,%edx
80108222:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80108226:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010822b:	e8 f0 fa ff ff       	call   80107d20 <mappages>
80108230:	85 c0                	test   %eax,%eax
80108232:	78 44                	js     80108278 <allocuvm+0xb8>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80108234:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010823a:	39 df                	cmp    %ebx,%edi
8010823c:	76 72                	jbe    801082b0 <allocuvm+0xf0>
    mem = kalloc();
8010823e:	e8 1d a3 ff ff       	call   80102560 <kalloc>
    if(mem == 0){
80108243:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
80108245:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80108247:	75 af                	jne    801081f8 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
80108249:	c7 04 24 2d 91 10 80 	movl   $0x8010912d,(%esp)
80108250:	e8 eb 83 ff ff       	call   80100640 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80108255:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80108258:	76 44                	jbe    8010829e <allocuvm+0xde>
8010825a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010825d:	89 fa                	mov    %edi,%edx
8010825f:	8b 45 08             	mov    0x8(%ebp),%eax
80108262:	e8 49 fb ff ff       	call   80107db0 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80108267:	31 c0                	xor    %eax,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80108269:	83 c4 1c             	add    $0x1c,%esp
8010826c:	5b                   	pop    %ebx
8010826d:	5e                   	pop    %esi
8010826e:	5f                   	pop    %edi
8010826f:	5d                   	pop    %ebp
80108270:	c3                   	ret    
80108271:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80108278:	c7 04 24 45 91 10 80 	movl   $0x80109145,(%esp)
8010827f:	e8 bc 83 ff ff       	call   80100640 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80108284:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80108287:	76 0d                	jbe    80108296 <allocuvm+0xd6>
80108289:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010828c:	89 fa                	mov    %edi,%edx
8010828e:	8b 45 08             	mov    0x8(%ebp),%eax
80108291:	e8 1a fb ff ff       	call   80107db0 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80108296:	89 34 24             	mov    %esi,(%esp)
80108299:	e8 f2 a0 ff ff       	call   80102390 <kfree>
      return 0;
    }
  }
  return newsz;
}
8010829e:	83 c4 1c             	add    $0x1c,%esp
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
801082a1:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
801082a3:	5b                   	pop    %ebx
801082a4:	5e                   	pop    %esi
801082a5:	5f                   	pop    %edi
801082a6:	5d                   	pop    %ebp
801082a7:	c3                   	ret    
801082a8:	90                   	nop
801082a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801082b0:	83 c4 1c             	add    $0x1c,%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
801082b3:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
801082b5:	5b                   	pop    %ebx
801082b6:	5e                   	pop    %esi
801082b7:	5f                   	pop    %edi
801082b8:	5d                   	pop    %ebp
801082b9:	c3                   	ret    
801082ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801082c0 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
801082c0:	55                   	push   %ebp
801082c1:	89 e5                	mov    %esp,%ebp
801082c3:	8b 55 0c             	mov    0xc(%ebp),%edx
801082c6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801082c9:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801082cc:	39 d1                	cmp    %edx,%ecx
801082ce:	73 10                	jae    801082e0 <deallocuvm+0x20>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
801082d0:	5d                   	pop    %ebp
801082d1:	e9 da fa ff ff       	jmp    80107db0 <deallocuvm.part.0>
801082d6:	8d 76 00             	lea    0x0(%esi),%esi
801082d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801082e0:	89 d0                	mov    %edx,%eax
801082e2:	5d                   	pop    %ebp
801082e3:	c3                   	ret    
801082e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801082ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801082f0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801082f0:	55                   	push   %ebp
801082f1:	89 e5                	mov    %esp,%ebp
801082f3:	57                   	push   %edi
801082f4:	56                   	push   %esi
801082f5:	53                   	push   %ebx
801082f6:	83 ec 1c             	sub    $0x1c,%esp
801082f9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801082fc:	85 f6                	test   %esi,%esi
801082fe:	74 55                	je     80108355 <freevm+0x65>
80108300:	31 c9                	xor    %ecx,%ecx
80108302:	ba 00 00 00 80       	mov    $0x80000000,%edx
80108307:	89 f0                	mov    %esi,%eax
80108309:	89 f3                	mov    %esi,%ebx
8010830b:	e8 a0 fa ff ff       	call   80107db0 <deallocuvm.part.0>
80108310:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80108316:	eb 0f                	jmp    80108327 <freevm+0x37>
80108318:	90                   	nop
80108319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108320:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80108323:	39 fb                	cmp    %edi,%ebx
80108325:	74 1f                	je     80108346 <freevm+0x56>
    if(pgdir[i] & PTE_P){
80108327:	8b 03                	mov    (%ebx),%eax
80108329:	a8 01                	test   $0x1,%al
8010832b:	74 f3                	je     80108320 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
8010832d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108332:	83 c3 04             	add    $0x4,%ebx
80108335:	05 00 00 00 80       	add    $0x80000000,%eax
8010833a:	89 04 24             	mov    %eax,(%esp)
8010833d:	e8 4e a0 ff ff       	call   80102390 <kfree>
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80108342:	39 fb                	cmp    %edi,%ebx
80108344:	75 e1                	jne    80108327 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80108346:	89 75 08             	mov    %esi,0x8(%ebp)
}
80108349:	83 c4 1c             	add    $0x1c,%esp
8010834c:	5b                   	pop    %ebx
8010834d:	5e                   	pop    %esi
8010834e:	5f                   	pop    %edi
8010834f:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80108350:	e9 3b a0 ff ff       	jmp    80102390 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80108355:	c7 04 24 61 91 10 80 	movl   $0x80109161,(%esp)
8010835c:	e8 df 7f ff ff       	call   80100340 <panic>
80108361:	eb 0d                	jmp    80108370 <setupkvm>
80108363:	90                   	nop
80108364:	90                   	nop
80108365:	90                   	nop
80108366:	90                   	nop
80108367:	90                   	nop
80108368:	90                   	nop
80108369:	90                   	nop
8010836a:	90                   	nop
8010836b:	90                   	nop
8010836c:	90                   	nop
8010836d:	90                   	nop
8010836e:	90                   	nop
8010836f:	90                   	nop

80108370 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80108370:	55                   	push   %ebp
80108371:	89 e5                	mov    %esp,%ebp
80108373:	56                   	push   %esi
80108374:	53                   	push   %ebx
80108375:	83 ec 10             	sub    $0x10,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80108378:	e8 e3 a1 ff ff       	call   80102560 <kalloc>
8010837d:	85 c0                	test   %eax,%eax
8010837f:	74 6f                	je     801083f0 <setupkvm+0x80>
80108381:	89 c6                	mov    %eax,%esi
    return 0;
  memset(pgdir, 0, PGSIZE);
80108383:	31 d2                	xor    %edx,%edx
80108385:	b8 00 10 00 00       	mov    $0x1000,%eax
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010838a:	bb 20 c4 10 80       	mov    $0x8010c420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
8010838f:	89 44 24 08          	mov    %eax,0x8(%esp)
80108393:	89 54 24 04          	mov    %edx,0x4(%esp)
80108397:	89 34 24             	mov    %esi,(%esp)
8010839a:	e8 c1 d6 ff ff       	call   80105a60 <memset>
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010839f:	8b 53 0c             	mov    0xc(%ebx),%edx
801083a2:	8b 43 04             	mov    0x4(%ebx),%eax
801083a5:	8b 4b 08             	mov    0x8(%ebx),%ecx
801083a8:	89 54 24 04          	mov    %edx,0x4(%esp)
801083ac:	8b 13                	mov    (%ebx),%edx
801083ae:	89 04 24             	mov    %eax,(%esp)
801083b1:	29 c1                	sub    %eax,%ecx
801083b3:	89 f0                	mov    %esi,%eax
801083b5:	e8 66 f9 ff ff       	call   80107d20 <mappages>
801083ba:	85 c0                	test   %eax,%eax
801083bc:	78 1a                	js     801083d8 <setupkvm+0x68>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801083be:	83 c3 10             	add    $0x10,%ebx
801083c1:	81 fb 60 c4 10 80    	cmp    $0x8010c460,%ebx
801083c7:	75 d6                	jne    8010839f <setupkvm+0x2f>
801083c9:	89 f0                	mov    %esi,%eax
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
801083cb:	83 c4 10             	add    $0x10,%esp
801083ce:	5b                   	pop    %ebx
801083cf:	5e                   	pop    %esi
801083d0:	5d                   	pop    %ebp
801083d1:	c3                   	ret    
801083d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
801083d8:	89 34 24             	mov    %esi,(%esp)
801083db:	e8 10 ff ff ff       	call   801082f0 <freevm>
      return 0;
    }
  return pgdir;
}
801083e0:	83 c4 10             	add    $0x10,%esp
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
801083e3:	31 c0                	xor    %eax,%eax
    }
  return pgdir;
}
801083e5:	5b                   	pop    %ebx
801083e6:	5e                   	pop    %esi
801083e7:	5d                   	pop    %ebp
801083e8:	c3                   	ret    
801083e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
801083f0:	31 c0                	xor    %eax,%eax
801083f2:	eb d7                	jmp    801083cb <setupkvm+0x5b>
801083f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801083fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80108400 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80108400:	55                   	push   %ebp
80108401:	89 e5                	mov    %esp,%ebp
80108403:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80108406:	e8 65 ff ff ff       	call   80108370 <setupkvm>
8010840b:	a3 04 80 11 80       	mov    %eax,0x80118004
80108410:	05 00 00 00 80       	add    $0x80000000,%eax
80108415:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
80108418:	c9                   	leave  
80108419:	c3                   	ret    
8010841a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108420 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108420:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108421:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108423:	89 e5                	mov    %esp,%ebp
80108425:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108428:	8b 55 0c             	mov    0xc(%ebp),%edx
8010842b:	8b 45 08             	mov    0x8(%ebp),%eax
8010842e:	e8 5d f8 ff ff       	call   80107c90 <walkpgdir>
  if(pte == 0)
80108433:	85 c0                	test   %eax,%eax
80108435:	74 05                	je     8010843c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80108437:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010843a:	c9                   	leave  
8010843b:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
8010843c:	c7 04 24 72 91 10 80 	movl   $0x80109172,(%esp)
80108443:	e8 f8 7e ff ff       	call   80100340 <panic>
80108448:	90                   	nop
80108449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108450 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80108450:	55                   	push   %ebp
80108451:	89 e5                	mov    %esp,%ebp
80108453:	57                   	push   %edi
80108454:	56                   	push   %esi
80108455:	53                   	push   %ebx
80108456:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80108459:	e8 12 ff ff ff       	call   80108370 <setupkvm>
8010845e:	85 c0                	test   %eax,%eax
80108460:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108463:	0f 84 c1 00 00 00    	je     8010852a <copyuvm+0xda>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108469:	8b 55 0c             	mov    0xc(%ebp),%edx
8010846c:	85 d2                	test   %edx,%edx
8010846e:	0f 84 9c 00 00 00    	je     80108510 <copyuvm+0xc0>
80108474:	31 ff                	xor    %edi,%edi
80108476:	eb 50                	jmp    801084c8 <copyuvm+0x78>
80108478:	90                   	nop
80108479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80108480:	b8 00 10 00 00       	mov    $0x1000,%eax
80108485:	89 44 24 08          	mov    %eax,0x8(%esp)
80108489:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010848c:	89 34 24             	mov    %esi,(%esp)
8010848f:	05 00 00 00 80       	add    $0x80000000,%eax
80108494:	89 44 24 04          	mov    %eax,0x4(%esp)
80108498:	e8 83 d6 ff ff       	call   80105b20 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
8010849d:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801084a3:	b9 00 10 00 00       	mov    $0x1000,%ecx
801084a8:	89 04 24             	mov    %eax,(%esp)
801084ab:	8b 45 e0             	mov    -0x20(%ebp),%eax
801084ae:	89 fa                	mov    %edi,%edx
801084b0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801084b4:	e8 67 f8 ff ff       	call   80107d20 <mappages>
801084b9:	85 c0                	test   %eax,%eax
801084bb:	78 63                	js     80108520 <copyuvm+0xd0>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801084bd:	81 c7 00 10 00 00    	add    $0x1000,%edi
801084c3:	39 7d 0c             	cmp    %edi,0xc(%ebp)
801084c6:	76 48                	jbe    80108510 <copyuvm+0xc0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801084c8:	8b 45 08             	mov    0x8(%ebp),%eax
801084cb:	31 c9                	xor    %ecx,%ecx
801084cd:	89 fa                	mov    %edi,%edx
801084cf:	e8 bc f7 ff ff       	call   80107c90 <walkpgdir>
801084d4:	85 c0                	test   %eax,%eax
801084d6:	74 62                	je     8010853a <copyuvm+0xea>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
801084d8:	8b 18                	mov    (%eax),%ebx
801084da:	f6 c3 01             	test   $0x1,%bl
801084dd:	74 4f                	je     8010852e <copyuvm+0xde>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
801084df:	89 d8                	mov    %ebx,%eax
    flags = PTE_FLAGS(*pte);
801084e1:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
801084e7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801084ec:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
801084ef:	e8 6c a0 ff ff       	call   80102560 <kalloc>
801084f4:	85 c0                	test   %eax,%eax
801084f6:	89 c6                	mov    %eax,%esi
801084f8:	75 86                	jne    80108480 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
801084fa:	8b 45 e0             	mov    -0x20(%ebp),%eax
801084fd:	89 04 24             	mov    %eax,(%esp)
80108500:	e8 eb fd ff ff       	call   801082f0 <freevm>
  return 0;
80108505:	31 c0                	xor    %eax,%eax
}
80108507:	83 c4 2c             	add    $0x2c,%esp
8010850a:	5b                   	pop    %ebx
8010850b:	5e                   	pop    %esi
8010850c:	5f                   	pop    %edi
8010850d:	5d                   	pop    %ebp
8010850e:	c3                   	ret    
8010850f:	90                   	nop
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108510:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
80108513:	83 c4 2c             	add    $0x2c,%esp
80108516:	5b                   	pop    %ebx
80108517:	5e                   	pop    %esi
80108518:	5f                   	pop    %edi
80108519:	5d                   	pop    %ebp
8010851a:	c3                   	ret    
8010851b:	90                   	nop
8010851c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
      kfree(mem);
80108520:	89 34 24             	mov    %esi,(%esp)
80108523:	e8 68 9e ff ff       	call   80102390 <kfree>
      goto bad;
80108528:	eb d0                	jmp    801084fa <copyuvm+0xaa>
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
8010852a:	31 c0                	xor    %eax,%eax
8010852c:	eb d9                	jmp    80108507 <copyuvm+0xb7>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
8010852e:	c7 04 24 96 91 10 80 	movl   $0x80109196,(%esp)
80108535:	e8 06 7e ff ff       	call   80100340 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010853a:	c7 04 24 7c 91 10 80 	movl   $0x8010917c,(%esp)
80108541:	e8 fa 7d ff ff       	call   80100340 <panic>
80108546:	8d 76 00             	lea    0x0(%esi),%esi
80108549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108550 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108550:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108551:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108553:	89 e5                	mov    %esp,%ebp
80108555:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108558:	8b 55 0c             	mov    0xc(%ebp),%edx
8010855b:	8b 45 08             	mov    0x8(%ebp),%eax
8010855e:	e8 2d f7 ff ff       	call   80107c90 <walkpgdir>
  if((*pte & PTE_P) == 0)
80108563:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80108565:	89 c2                	mov    %eax,%edx
80108567:	83 e2 05             	and    $0x5,%edx
8010856a:	83 fa 05             	cmp    $0x5,%edx
8010856d:	75 11                	jne    80108580 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
8010856f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108574:	05 00 00 00 80       	add    $0x80000000,%eax
}
80108579:	c9                   	leave  
8010857a:	c3                   	ret    
8010857b:	90                   	nop
8010857c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
80108580:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
80108582:	c9                   	leave  
80108583:	c3                   	ret    
80108584:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010858a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80108590 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108590:	55                   	push   %ebp
80108591:	89 e5                	mov    %esp,%ebp
80108593:	57                   	push   %edi
80108594:	56                   	push   %esi
80108595:	53                   	push   %ebx
80108596:	83 ec 2c             	sub    $0x2c,%esp
80108599:	8b 75 14             	mov    0x14(%ebp),%esi
8010859c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
8010859f:	85 f6                	test   %esi,%esi
801085a1:	89 da                	mov    %ebx,%edx
801085a3:	75 41                	jne    801085e6 <copyout+0x56>
801085a5:	eb 71                	jmp    80108618 <copyout+0x88>
801085a7:	89 f6                	mov    %esi,%esi
801085a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801085b0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801085b3:	89 df                	mov    %ebx,%edi
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801085b5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801085b8:	29 d7                	sub    %edx,%edi
801085ba:	81 c7 00 10 00 00    	add    $0x1000,%edi
801085c0:	39 f7                	cmp    %esi,%edi
801085c2:	0f 47 fe             	cmova  %esi,%edi
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801085c5:	29 da                	sub    %ebx,%edx
801085c7:	01 c2                	add    %eax,%edx
801085c9:	89 14 24             	mov    %edx,(%esp)
801085cc:	89 7c 24 08          	mov    %edi,0x8(%esp)
801085d0:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801085d4:	e8 47 d5 ff ff       	call   80105b20 <memmove>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
801085d9:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
801085df:	01 7d 10             	add    %edi,0x10(%ebp)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801085e2:	29 fe                	sub    %edi,%esi
801085e4:	74 32                	je     80108618 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
801085e6:	8b 45 08             	mov    0x8(%ebp),%eax
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
801085e9:	89 d3                	mov    %edx,%ebx
801085eb:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    pa0 = uva2ka(pgdir, (char*)va0);
801085f1:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
801085f5:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
801085f8:	89 04 24             	mov    %eax,(%esp)
801085fb:	e8 50 ff ff ff       	call   80108550 <uva2ka>
    if(pa0 == 0)
80108600:	85 c0                	test   %eax,%eax
80108602:	75 ac                	jne    801085b0 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80108604:	83 c4 2c             	add    $0x2c,%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
80108607:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
8010860c:	5b                   	pop    %ebx
8010860d:	5e                   	pop    %esi
8010860e:	5f                   	pop    %edi
8010860f:	5d                   	pop    %ebp
80108610:	c3                   	ret    
80108611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108618:	83 c4 2c             	add    $0x2c,%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
8010861b:	31 c0                	xor    %eax,%eax
}
8010861d:	5b                   	pop    %ebx
8010861e:	5e                   	pop    %esi
8010861f:	5f                   	pop    %edi
80108620:	5d                   	pop    %ebp
80108621:	c3                   	ret    
